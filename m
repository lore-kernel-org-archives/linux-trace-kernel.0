Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84F1DE2C9;
	Thu, 17 Oct 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179043; cv=none; b=b77s/hPfl6GZkbpp4GTwVCQwBAXeoHghxBDB9791GF+eh1PIXkmUKQWDUHElIgn4+k5LjVANqz40nq0sQaulRlqto1FMKrgBTdZfNNDQUHUjGnq/89R9LEHm9bvX6k1QIfFqACmBDuODILxhSStLV03TXZKPgjjgisrNoU902wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179043; c=relaxed/simple;
	bh=9LVb4k0xluyfrwEgNONwAXsPXVPCz1o2fCkjs7f1+yw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cBgTD6ffgwKvtBxHssmwLAGtpWvjoKkSjhyhlTwFariQN01n9Hh5N7TyA4Hrv+KqqBjs4TTavaQSLK8dZCOlYbVsfg96T+8KOxZBpG1f7maJnDPmoV7tJoUZyUD1YeFnCwLn3jL85eltIUhTkAl2Z7dFTmpVROvE42uzVQn4gnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5878FC4CECD;
	Thu, 17 Oct 2024 15:30:42 +0000 (UTC)
Date: Thu, 17 Oct 2024 11:31:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] ftrace: Show timings of how long nop patching took
Message-ID: <20241017113105.1edfa943@gandalf.local.home>
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

Since the beginning of ftrace, the code that did the patching had its
timings saved on how long it took to complete. But this information was
never exposed. It was used for debugging and exposing it was always
something that was on the TODO list. Now it's time to expose it. There's
even a file that is where it should go!

Also include how long patching modules took as a separate value.

 # cat /sys/kernel/tracing/dyn_ftrace_total_info
 57680 pages:231 groups: 9
 ftrace boot update time = 14024666 (ns)
 ftrace module total update time = 126070 (ns)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 11 ++++++++---
 kernel/trace/trace.c  | 15 +++++++++++----
 kernel/trace/trace.h  |  2 ++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e9fd4fb2769e..7fb0d2934a23 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3686,7 +3686,8 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
 }
 
 
-static u64		ftrace_update_time;
+u64			ftrace_update_time;
+u64			ftrace_total_mod_time;
 unsigned long		ftrace_update_tot_cnt;
 unsigned long		ftrace_number_of_pages;
 unsigned long		ftrace_number_of_groups;
@@ -3706,7 +3707,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 	bool init_nop = ftrace_need_init_nop();
 	struct ftrace_page *pg;
 	struct dyn_ftrace *p;
-	u64 start, stop;
+	u64 start, stop, update_time;
 	unsigned long update_cnt = 0;
 	unsigned long rec_flags = 0;
 	int i;
@@ -3750,7 +3751,11 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 	}
 
 	stop = ftrace_now(raw_smp_processor_id());
-	ftrace_update_time = stop - start;
+	update_time = stop - start;
+	if (mod)
+		ftrace_total_mod_time += update_time;
+	else
+		ftrace_update_time = update_time;
 	ftrace_update_tot_cnt += update_cnt;
 
 	return 0;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c01375adc471..405dcf498159 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8548,15 +8548,22 @@ tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 	char *buf;
 	int r;
 
-	/* 256 should be plenty to hold the amount needed */
-	buf = kmalloc(256, GFP_KERNEL);
+	/* 512 should be plenty to hold the amount needed */
+#define DYN_INFO_BUF_SIZE	512
+
+	buf = kmalloc(DYN_INFO_BUF_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	r = scnprintf(buf, 256, "%ld pages:%ld groups: %ld\n",
+	r = scnprintf(buf, DYN_INFO_BUF_SIZE,
+		      "%ld pages:%ld groups: %ld\n"
+		      "ftrace boot update time = %llu (ns)\n"
+		      "ftrace module total update time = %llu (ns)\n",
 		      ftrace_update_tot_cnt,
 		      ftrace_number_of_pages,
-		      ftrace_number_of_groups);
+		      ftrace_number_of_groups,
+		      ftrace_update_time,
+		      ftrace_total_mod_time);
 
 	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 	kfree(buf);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6adf48ef4312..3307dad4d917 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -775,6 +775,8 @@ extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 extern unsigned long ftrace_update_tot_cnt;
 extern unsigned long ftrace_number_of_pages;
 extern unsigned long ftrace_number_of_groups;
+extern u64 ftrace_update_time;
+extern u64 ftrace_total_mod_time;
 void ftrace_init_trace_array(struct trace_array *tr);
 #else
 static inline void ftrace_init_trace_array(struct trace_array *tr) { }
-- 
2.45.2

