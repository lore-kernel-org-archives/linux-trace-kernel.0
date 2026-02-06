Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A92D9ECA;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407936; cv=none; b=S8b9l5wPWHLTSmlkjBgLDZNWDFVvqmSNjpBv4EaDwI23g3yILZbdXyglLFgvmr7dmBEFNYVdR8WgpTHSNjvlUF+q2OYfluUuWIIjY1kEAL5rAXrAYTppZT5C5dLXClO8stYL2u/xmUYgBT9InMR88GB3jJHmIZJvpzWtBLsuSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407936; c=relaxed/simple;
	bh=TtEiHaNcCXpnjiMUEzl5E1qGp0IhB1/OfPUdEfw+OnA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XBt0/gWB2wyUr6zcsdA/OjoAJDph4yp9Hb7w/DAsXCgkA0WU7Wc7kaeLxuo8Vw4zaS1IBS613a+Rpu5Y6E8QEOJiSX4Hq9dRDGW8qi1r36lhbBQCu1MERMDENdbbwQjDtYXgWRJP/DRSacv3mFCgLIgc5y6J4Eis/6QKLqprHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9F/lfVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9F/lfVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F35C19423;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407936;
	bh=TtEiHaNcCXpnjiMUEzl5E1qGp0IhB1/OfPUdEfw+OnA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Z9F/lfVzGrH/9J8LmK8WMJbSh6YyhhcoXfv8rC0B1/dFzdyShWdkUzQrO/quBtGN9
	 yrx9f0xOIFa/Zdqeb4Vlp18Fm7DFGIhvbHHknVLMGmrSB5lzZys3a8fcQrXs1d4BMR
	 BXbRoPRNwRCSKoH2zP3RI0YunQkU2UbpgWvIU8bCNf673mYpuTITcgopYSl7mf5cOS
	 0tK/7kho+63pERspr/gDMKn5Gwiat5repKibW2rfG0pkYbiaTq1WPXBhu/qvax2fjO
	 WiKFNWjDKQ2HP9amfGdJ98wRigtGEWsRu8pvIfr4DjdiZaVtT2Tbo5dgY6K5pREwbh
	 7AIcSizw3A+lw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzL-0000000A6mI-0SDz;
	Fri, 06 Feb 2026 14:59:35 -0500
Message-ID: <20260206195934.961147222@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:42 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 01/12] tracing: Make tracing_disabled global for tracing system
References: <20260206193741.767171392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The tracing_disabled variable is set to one on boot up to prevent some
parts of tracing to access the tracing infrastructure before it is set up.
It also can be set after boot if an anomaly is discovered.

It is currently a static variable in trace.c and can be accessed via a
function call trace_is_disabled(). There's really no reason to use a
function call as the tracing subsystem should be able to access it
directly.

By making the variable accessed directly, code can be moved out of trace.c
without adding overhead of a function call to see if tracing is disabled
or not.

Make tracing_disabled global and remove the tracing_is_disabled() helper
function. Also add some "unlikely()"s around tracing_disabled where it's
checked in hot paths.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 13 ++++---------
 kernel/trace/trace.h        |  3 ++-
 kernel/trace/trace_events.c |  2 +-
 kernel/trace/trace_kprobe.c |  2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 19b5a347a8fc..45972d089061 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -114,7 +114,7 @@ DEFINE_PER_CPU(bool, trace_taskinfo_save);
  * of the tracer is successful. But that is the only place that sets
  * this back to zero.
  */
-static int tracing_disabled = 1;
+int tracing_disabled = 1;
 
 cpumask_var_t __read_mostly	tracing_buffer_mask;
 
@@ -3425,7 +3425,7 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 	unsigned int trace_ctx;
 	char *tbuffer;
 
-	if (tracing_disabled)
+	if (unlikely(tracing_disabled))
 		return 0;
 
 	/* Don't pollute graph traces with trace_vprintk internals */
@@ -4767,11 +4767,6 @@ int tracing_open_generic(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-bool tracing_is_disabled(void)
-{
-	return (tracing_disabled) ? true: false;
-}
-
 /*
  * Open and update trace_array ref count.
  * Must have the current trace_array passed to it.
@@ -7611,7 +7606,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	unsigned long ip;
 	char *buf;
 
-	if (tracing_disabled)
+	if (unlikely(tracing_disabled))
 		return -EINVAL;
 
 	if (!(tr->trace_flags & TRACE_ITER(MARKERS)))
@@ -7691,7 +7686,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	ssize_t written = -ENODEV;
 	char *buf;
 
-	if (tracing_disabled)
+	if (unlikely(tracing_disabled))
 		return -EINVAL;
 
 	if (!(tr->trace_flags & TRACE_ITER(MARKERS)))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f1466e57ffb2..fda87c9f84bc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -662,6 +662,8 @@ trace_buffer_iter(struct trace_iterator *iter, int cpu)
 	return iter->buffer_iter ? iter->buffer_iter[cpu] : NULL;
 }
 
+extern int tracing_disabled;
+
 int tracer_init(struct tracer *t, struct trace_array *tr);
 int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct array_buffer *buf);
@@ -673,7 +675,6 @@ int tracing_release_generic_tr(struct inode *inode, struct file *file);
 int tracing_open_file_tr(struct inode *inode, struct file *filp);
 int tracing_release_file_tr(struct inode *inode, struct file *filp);
 int tracing_single_release_file_tr(struct inode *inode, struct file *filp);
-bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
 void tracer_tracing_off(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index af6d1fe5cab7..61fe01dce7a6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2268,7 +2268,7 @@ static int subsystem_open(struct inode *inode, struct file *filp)
 	struct event_subsystem *system = NULL;
 	int ret;
 
-	if (tracing_is_disabled())
+	if (unlikely(tracing_disabled))
 		return -ENODEV;
 
 	/* Make sure the system still exists */
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9953506370a5..48311300205d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2079,7 +2079,7 @@ static __init int kprobe_trace_self_tests_init(void)
 	struct trace_kprobe *tk;
 	struct trace_event_file *file;
 
-	if (tracing_is_disabled())
+	if (unlikely(tracing_disabled))
 		return -ENODEV;
 
 	if (tracing_selftest_disabled)
-- 
2.51.0


