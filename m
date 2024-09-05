Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77617C990;
	Thu,  5 Sep 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540749; cv=none; b=T8qPH4ZYF2ySvQjllucXsfpiNCUbFbBYdqKrEeT77RPr6hpQWGJtL9YgkTPiF1NFohoDwj4VGr+4MtodpX0MqtxvBVWonKnCLav58zshxxXH3BqTYMk5pHc58OOCnSeEsocI77xjf0SPphQKwSE+QcxSB1bfXIopdCx939oxu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540749; c=relaxed/simple;
	bh=tN28YwSlwQtG46KzjQc8IJ4igXiJsYG+1FA/9ItvSmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eyxQRhnK9AjDPj262iC/HL5jBjfUD+BewXad69XcEKTDKldAJT5XxW2J53wKfE02dheK6OFCPRBogk1umrOWpb20xZ3/ULV3R1jzgV3gAPFqA4A3QFHxvQsroEePVK8VIAIWSKGu6YVLVLmCOTRcHtrg3+FmY99dAoeCzKe4ykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230CDC4CEC3;
	Thu,  5 Sep 2024 12:52:28 +0000 (UTC)
Date: Thu, 5 Sep 2024 08:53:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2] tracing/timerlat: Only clear timer if a kthread exists
Message-ID: <20240905085330.45985730@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The timerlat tracer can use user space threads to check for osnoise and
timer latency. If the program using this is killed via a SIGTERM, the
threads are shutdown one at a time and another tracing instance can start
up resetting the threads before they are fully closed. That causes the
hrtimer assigned to the kthread to be shutdown and freed twice when the
dying thread finally closes the file descriptors, causing a use-after-free
bug.

Only cancel the hrtimer if the associated thread is still around. Also add
the interface_lock around the resetting of the tlat_var->kthread.

Note, this is just a quick fix that can be backported to stable. A real
fix is to have a better synchronization between the shutdown of old
threads and the starting of new ones.

Link: https://lore.kernel.org/all/20240820130001.124768-1-tglozar@redhat.com/

Cc: stable@vger.kernel.org
Fixes: e88ed227f639e ("tracing/timerlat: Add user-space interface")
Reported-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20240903111642.35292e70@gandalf.local.home

- Added taking the interface_lock around the tlat_var_reset code.

 kernel/trace/trace_osnoise.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..fc227a386077 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -252,6 +252,11 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
 	return this_cpu_ptr(&per_cpu_timerlat_var);
 }
 
+/*
+ * Protect the interface.
+ */
+static struct mutex interface_lock;
+
 /*
  * tlat_var_reset - Reset the values of the given timerlat_variables
  */
@@ -259,14 +264,20 @@ static inline void tlat_var_reset(void)
 {
 	struct timerlat_variables *tlat_var;
 	int cpu;
+
+	/* Synchronize with the timerlat interfaces */
+	mutex_lock(&interface_lock);
 	/*
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
 	for_each_cpu(cpu, cpu_online_mask) {
 		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
+		if (tlat_var->kthread)
+			hrtimer_cancel(&tlat_var->timer);
 		memset(tlat_var, 0, sizeof(*tlat_var));
 	}
+	mutex_unlock(&interface_lock);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
 #define tlat_var_reset()	do {} while (0)
@@ -331,11 +342,6 @@ struct timerlat_sample {
 };
 #endif
 
-/*
- * Protect the interface.
- */
-static struct mutex interface_lock;
-
 /*
  * Tracer data.
  */
@@ -2579,7 +2585,8 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
 	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 
-	hrtimer_cancel(&tlat_var->timer);
+	if (tlat_var->kthread)
+		hrtimer_cancel(&tlat_var->timer);
 	memset(tlat_var, 0, sizeof(*tlat_var));
 
 	osn_var->sampling = 0;
-- 
2.43.0

