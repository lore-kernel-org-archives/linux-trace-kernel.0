Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118824061F;
	Fri,  9 May 2025 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746818803; cv=none; b=Nbbzr9AXEs/hJ4nAUZoloFseJnL38Bo4nev1enssEZgE8DumvXlbkyvkFkWWuS2Lo/0ofiVSpjzuynxBXI3y80k7cUL+e1nHqJBUW36roXLKECYMLfopAR3dtyAbBmlUxpdIUJN37/y4qE4KmnEFVR4t3WdJBviDndZVE1npEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746818803; c=relaxed/simple;
	bh=KhVx0ZtdZRxRMbsEKFrKcth3+kmgCy0v2+FzCIBaVCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Mo824cT2l9C8z2s7nPeVCmTWlEDvJ4G36lZaBf6UZ2+HbvU1Y3sKNSa6YvXcqexLY7ibZaik728vLEBsZ5wyhVhsmFRuknv098VjFYjZn5LBf1ReHmrqj51hNe5H0xsH76HkJeGNdebCyyN81GMK9PV3Thk5FHKNsqTIjh8+lR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB20C4CEE4;
	Fri,  9 May 2025 19:26:41 +0000 (UTC)
Date: Fri, 9 May 2025 15:26:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Divya Indi <divya.indi@oracle.com>
Subject: [PATCH] tracing: samples: Initialize trace_array_printk() with the
 correct function
Message-ID: <20250509152657.0f6744d9@gandalf.local.home>
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

When using trace_array_printk() on a created instance, the correct
function to use to initialize it is:

  trace_array_init_printk()

Not

  trace_printk_init_buffer()

The former is a proper function to use, the latter is for initializing
trace_printk() and causes the NOTICE banner to be displayed.

Fixes: 89ed42495ef4a ("tracing: Sample module to demonstrate kernel access to Ftrace instances.")
Fixes: 38ce2a9e33db6 ("tracing: Add trace_array_init_printk() to initialize instance trace_printk() buffers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/ftrace/sample-trace-array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index dac67c367457..4147616102f9 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -112,7 +112,7 @@ static int __init sample_trace_array_init(void)
 	/*
 	 * If context specific per-cpu buffers havent already been allocated.
 	 */
-	trace_printk_init_buffers();
+	trace_array_init_printk(tr);
 
 	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
 	if (IS_ERR(simple_tsk)) {
-- 
2.47.2

