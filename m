Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E633F8D8;
	Wed,  5 Nov 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359567; cv=none; b=a9NOAQBC3EsSLo/6krjkupBIfNrZK7+neMxrwMQDo/JPrUxcSAL6Ju0PnE6wqbFTmq93NtV6554Fayux0VjiUyFoUQK6Q8xWSe8+IZ5EB7kMObRp37Ajrs7Mz320lbzdJCajB9r9x0sZXEa5c2rgNhZIGFRcvwPjtu8CbTHszXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359567; c=relaxed/simple;
	bh=WfSC/Rse3xLN3P8zBrBMqCofdKiaSzH8oUlpMDX+Ilk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mGkMQ4AsiNKvourVhWOX6+Y+rZE0J3sVzsyO3wOeSpHgpIEokxjftzYmT5NCQIMHDX59gTg6Hz+PUpL2z/Jrf6Xp35Huz4poQ0Lx/Gvaw6p6S1u4HOZ9PAcbH0y3pATV340mWBcIs3ypqe+i18CAuo/x9fp8yMFa6aE5hLXwgBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCFNm+NW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCFNm+NW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0721C4AF0D;
	Wed,  5 Nov 2025 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359566;
	bh=WfSC/Rse3xLN3P8zBrBMqCofdKiaSzH8oUlpMDX+Ilk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=tCFNm+NWfbH5E1N+AAmEqcnUb1ysz+4A32SJcmfMshu10NONhC/Fw3svYSyamFze5
	 TuLN9uLEHehZGLO5jHdbIfpdUDDErlCF7jhAqMXanVSprx0tN8eFjvYtWJUzY08Alc
	 5IXBz6WoSjS0hpUG56bllNZp07GZswXe6vr21k8+QEX1VpXXWlADQZB2jGivbmHK+C
	 Kzsp6KxWHwrKnF/y06It5IcOk7w9MHFdyzWXqpboR6A67OqVedyKf0fA1BjzC5Hxqa
	 lBLEYPVO2bv+T8cWW8mc9ETy8RVZv5hO0L1EZ0THdO22L3gef+S5K+pW0o4eGT0AWb
	 lT+bdEMMVJz1w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vGgER-00000000pVD-1UGa;
	Wed, 05 Nov 2025 11:19:35 -0500
Message-ID: <20251105161935.206093132@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 05 Nov 2025 11:19:10 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/5] tracing: Remove dummy options and flags
References: <20251105161909.590008129@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a tracer does not define their own flags, dummy options and flags are
used so that the values are always valid. There's not that many locations
that reference these values so having dummy versions just complicates the
code. Remove the dummy values and just check for NULL when appropriate.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 48 +++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e822db5d9e4..afeaa9a164e9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -94,17 +94,6 @@ static bool tracepoint_printk_stop_on_boot __initdata;
 static bool traceoff_after_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
-/* For tracers that don't implement custom flags */
-static struct tracer_opt dummy_tracer_opt[] = {
-	{ }
-};
-
-static int
-dummy_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
-{
-	return 0;
-}
-
 /*
  * To prevent the comm cache from being overwritten when no
  * tracing is active, only save the comm when a trace event
@@ -2356,23 +2345,9 @@ int __init register_tracer(struct tracer *type)
 		}
 	}
 
-	if (!type->set_flag)
-		type->set_flag = &dummy_set_flag;
-	if (!type->flags) {
-		/*allocate a dummy tracer_flags*/
-		type->flags = kmalloc(sizeof(*type->flags), GFP_KERNEL);
-		if (!type->flags) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		type->flags->val = 0;
-		type->flags->opts = dummy_tracer_opt;
-	} else
-		if (!type->flags->opts)
-			type->flags->opts = dummy_tracer_opt;
-
 	/* store the tracer for __set_tracer_option */
-	type->flags->trace = type;
+	if (type->flags)
+		type->flags->trace = type;
 
 	ret = do_run_tracer_selftest(type);
 	if (ret < 0)
@@ -5159,14 +5134,12 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 {
 	struct tracer_opt *trace_opts;
 	struct trace_array *tr = m->private;
+	struct tracer *trace;
 	u32 tracer_flags;
 	int i;
 
 	guard(mutex)(&trace_types_lock);
 
-	tracer_flags = tr->current_trace->flags->val;
-	trace_opts = tr->current_trace->flags->opts;
-
 	for (i = 0; trace_options[i]; i++) {
 		if (tr->trace_flags & (1ULL << i))
 			seq_printf(m, "%s\n", trace_options[i]);
@@ -5174,6 +5147,13 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 			seq_printf(m, "no%s\n", trace_options[i]);
 	}
 
+	trace = tr->current_trace;
+	if (!trace->flags || !trace->flags->opts)
+		return 0;
+
+	tracer_flags = tr->current_trace->flags->val;
+	trace_opts = tr->current_trace->flags->opts;
+
 	for (i = 0; trace_opts[i].name; i++) {
 		if (tracer_flags & trace_opts[i].bit)
 			seq_printf(m, "%s\n", trace_opts[i].name);
@@ -5189,9 +5169,10 @@ static int __set_tracer_option(struct trace_array *tr,
 			       struct tracer_opt *opts, int neg)
 {
 	struct tracer *trace = tracer_flags->trace;
-	int ret;
+	int ret = 0;
 
-	ret = trace->set_flag(tr, tracer_flags->val, opts->bit, !neg);
+	if (trace->set_flag)
+		ret = trace->set_flag(tr, tracer_flags->val, opts->bit, !neg);
 	if (ret)
 		return ret;
 
@@ -5210,6 +5191,9 @@ static int set_tracer_option(struct trace_array *tr, char *cmp, int neg)
 	struct tracer_opt *opts = NULL;
 	int i;
 
+	if (!tracer_flags || !tracer_flags->opts)
+		return 0;
+
 	for (i = 0; tracer_flags->opts[i].name; i++) {
 		opts = &tracer_flags->opts[i];
 
-- 
2.51.0


