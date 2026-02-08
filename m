Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FBC611E;
	Sun,  8 Feb 2026 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770509466; cv=none; b=JD6uYzBQyuAYloE7hbTezrFbWrbagbVwr9o7BD1Z62An+UrofHhgP9BnPSnMZvap+Z5matD/Ghkf2YGRNqOZjUBuhkD48/E/FQCdFLP1AqxXXmyl+mhVVyTutFhwqyhuDOppMBsDZ67bGIQIO9kkuEGNtKhn85TREs7F9QVaNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770509466; c=relaxed/simple;
	bh=7W2sMZ0eosKj8m1q8MSjX9tUw7pvfVXCUDEyf83/yhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sfHNs04/tXd3AiL3QYiwF94pBFe7Yymd9QXzrDXN0bfwyMB3+2BsJ8cp7GIwNTkOOZBowl/X4Ztc9aM0xDB/xmTQh/gcw1JjyGejqOExWN4fXUxAg9tjf8WxV0T9RS5pSKv8jBsVZcRHn6lBg5NBJ8unbE1K8tuqoLCzWWwEq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 77E22C023C;
	Sun,  8 Feb 2026 00:11:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id DCB6320024;
	Sun,  8 Feb 2026 00:11:02 +0000 (UTC)
Date: Sat, 7 Feb 2026 19:11:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Clean up use of trace_create_maxlat_file()
Message-ID: <20260207191101.0e014abd@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: DCB6320024
X-Stat-Signature: 5hsg463txoenx3jim5bewf5igwjw83b6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/nHpDIGJHH9htKsiOHf3hiTvoOxdUdWbQ=
X-HE-Tag: 1770509462-175938
X-HE-Meta: U2FsdGVkX1/U/+kRY70yWKOl3n/LVlo91EobYRx1stSgBCxn9RiaT6dkZtndIoJUguPKaZfcN6gw8ICMJoTutBccVJp8G9GC5gJXVsvwcw6GdfZ3n52zDeaKvaV/C4Vyz72x0Q+zt9dhdgbosXxtWGACjczr38B+z5xCasVXG7kK/eDwaPqfeehoCQqwBGanRajRkf68Hf7gRbIySNsTyI7RC1moMhRPCeuQL1bdTtC1OCqdVDAztd8tirrkYDGALm5siImDYZAJwfo+UhJd+FbPiWJU8uZMwI4nMWZCSCTEnk/xaaBCq+GTK1Se1yJj3FqUl+WuAzZUgkOPQ+qTstbrVNg3iVGn0N13Q2ecPvhBke7fz++SDkbcUoIztpQ0GfCCFwc+52n4kn7i5b2rfpwPgV4VR/Cl2Z/+AeNNlTkyvdSJiXEEtmBCHKHARdvOidweh/FyZAQ2Dw6xFB4iuQ==

From: Steven Rostedt <rostedt@goodmis.org>

In trace.c, the function trace_create_maxlat_file() is defined behind the
 #ifdef CONFIG_TRACER_MAX_TRACE block. The #else part defines it as:

 #define trace_create_maxlat_file(tr, d_tracer)				\
	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
			  d_tracer, tr, &tracing_max_lat_fops)

But the one place that it it used has:

 #ifdef CONFIG_TRACER_MAX_TRACE
	trace_create_maxlat_file(tr, d_tracer);
 #endif

Which is pointless and also wrong!

It only gets created when both CONFIG_TRACE_MAX_TRACE and CONFIG_FS_NOTIFY
is defined, but the file itself should not be dependent on
CONFIG_FS_NOTIFY. Always create that file when TRACE_MAX_TRACE is defined
regardless if FS_NOTIFY is or is not.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://patch.msgid.link/20260206230410.4ed96e9f@robin

- On further inspection, tracing_max_latency should always be created if
  CONFIG_TRACER_MAX_TRACE is defined regardless if CONFIG_FS_NOTIFY is.

 kernel/trace/trace.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 702ef851db45..d02c4004c718 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1912,10 +1912,7 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 unsigned long __read_mostly	tracing_thresh;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-static const struct file_operations tracing_max_lat_fops;
-
 #ifdef LATENCY_FS_NOTIFY
-
 static struct workqueue_struct *fsnotify_wq;
 
 static void latency_fsnotify_workfn(struct work_struct *work)
@@ -1932,17 +1929,6 @@ static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
 	queue_work(fsnotify_wq, &tr->fsnotify_work);
 }
 
-static void trace_create_maxlat_file(struct trace_array *tr,
-				     struct dentry *d_tracer)
-{
-	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
-	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
-	tr->d_max_latency = trace_create_file("tracing_max_latency",
-					      TRACE_MODE_WRITE,
-					      d_tracer, tr,
-					      &tracing_max_lat_fops);
-}
-
 __init static int latency_fsnotify_init(void)
 {
 	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
@@ -1967,14 +1953,22 @@ void latency_fsnotify(struct trace_array *tr)
 	 */
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
+#endif /* !LATENCY_FS_NOTIFY */
 
-#else /* !LATENCY_FS_NOTIFY */
-
-#define trace_create_maxlat_file(tr, d_tracer)				\
-	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, tr, &tracing_max_lat_fops)
+static const struct file_operations tracing_max_lat_fops;
 
+static void trace_create_maxlat_file(struct trace_array *tr,
+				     struct dentry *d_tracer)
+{
+#ifdef LATENCY_FS_NOTIFY
+	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
+	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
 #endif
+	tr->d_max_latency = trace_create_file("tracing_max_latency",
+					      TRACE_MODE_WRITE,
+					      d_tracer, tr,
+					      &tracing_max_lat_fops);
+}
 
 /*
  * Copy the new maximum trace into the separate maximum-trace
@@ -2109,7 +2103,9 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	__update_max_tr(tr, tsk, cpu);
 	arch_spin_unlock(&tr->max_lock);
 }
-
+#else /* !CONFIG_TRACER_MAX_TRACE */
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 struct pipe_wait {
@@ -10664,9 +10660,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 	trace_create_maxlat_file(tr, d_tracer);
-#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
-- 
2.51.0

