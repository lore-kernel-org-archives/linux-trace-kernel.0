Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57ED23B1;
	Wed, 21 Aug 2024 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199711; cv=none; b=Cw0HtgHn9+/x4TCV19OHXB3M2uk5OK/JT/EQHWBzJ7L5j1o1nDaoQwl7DRnGNdITYwL+gvVRNayD5Ko9hYrdhbEUeSuzXWeOZu/NhPeZZKY6lgDQlEA2yVMeOGvW3SboyBRGlMavKLGylhx3KQhQn//9+RGrJX0bPAhOgxZjVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199711; c=relaxed/simple;
	bh=tO9lHjbgHTw7NCXp7c9FX69Zqx7Omwhqitb3z3Ge52M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fQqQ1k5PH5JmL8NghO4gSJ8pEf0BE984acTfnvg5q1RFm9zaX9uPpSwMZE16wjDfVtGb8ytlrKLKFSSr2FuXZ7mfY5E/zqkCqWy2JDLrY8Y1TU8owrtTuizBY42UzjD1HJkXxyaRIGZnLtEzeQ97vJsy15oWysJahKBlsfC8/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV2ke3H0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV2ke3H0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109C4C4AF0B;
	Wed, 21 Aug 2024 00:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724199710;
	bh=tO9lHjbgHTw7NCXp7c9FX69Zqx7Omwhqitb3z3Ge52M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YV2ke3H0jUy5+yks0gciA5hsVagnl3sM2CFk7mcbLuS1mHmo+tS543FBqpFXQToZZ
	 Badgq3gGFJNaA3MQCMP+jpf3TRuLHscJEh8fpOh9bQAkIA3YIaY3SZvZmcLAbgfJTt
	 N9ik+VFtOr4tvTMDK/O3fBWq1acfi/ZU5ruYj36ZSDxHUnMRx/CWZHX1h6t/Vw4RV+
	 /a7CHCstsiw3qMjOObRkxTVWr6DAWQ8kQWtTsgaNSgaWrRf3nd6ZPXxSKi9bumZc7x
	 sEpZHOXFYqqqdXl/fi+HZPGfcXuciRfmVQgilqV0zm2jIcCoqJTuSpfrsstH7n7pzX
	 Jv4H1VDuVlNjA==
Date: Wed, 21 Aug 2024 09:21:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sami Tolvanen
 <samitolvanen@google.com>, Mark Rutland <mark.rutland@arm.com>, Linux Trace
 Kernel <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-Id: <20240821092147.ff26a09cb0a72b8621abe750@kernel.org>
In-Reply-To: <20240821084351.4b1c9d4d52b5aa7e07681d69@kernel.org>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
	<20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
	<ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
	<CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
	<20240821070539.981b42e5f3b939c5ce5e3a71@kernel.org>
	<20240820181109.4203158d@gandalf.local.home>
	<20240821084351.4b1c9d4d52b5aa7e07681d69@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 08:43:51 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 20 Aug 2024 18:11:09 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 21 Aug 2024 07:05:39 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > 
> > > Does the noinline attribute prevent embedding callsite too? I mean
> > > 
> > > extern callee()
> > > 
> > > noinline callee()
> > > {
> > > ...
> > > }
> > > 
> > > caller()
> > > {
> > > 	callee() // (*)
> > > }
> > > 
> > > In this case, does noinline prevent LTO to embed the callee at the callsite(*)
> > > or prevent LTO remove the callee() symbol?
> > >
> > 
> > Even though we have it passed as a parameter, I think the compiler and
> > linker is smart enough to see that and notice its use, and that the
> > function passed in is a nop, which doesn't break the flow.
> > 
> > Can you add the __used and see if it fixes it?
> 
> Adding __used to DYN_FTRACE_TEST_NAME() and DYN_FTRACE_TEST_NAME2() does
> not change, the test still fails. Hmm, what about makes the caller
> (trace_selftest_startup_dynamic_tracing()) called via a function pointer?
> In that case, wouldn't it be subject to constant propagetion?
> 
> Let me try.

OK, it is succeeded! Calling `caller` via global function pointer makes
it run as we expected. It passed the dynamic_ftrace test, but other tests
still fails. Those need to be called via function pointer too.
                             
[    1.851324] Testing dynamic ftrace: PASSED                                     
[    2.083329] Testing dynamic ftrace ops #1:                                     
[    2.173751] (0 0 0 0 0) FAILED!                                                
[    2.182337] ------------[ cut here ]------------                               
[    2.183323] WARNING: CPU: 0 PID: 1 at kernel/trace/trace.c:2143 run_tracer_sel0
[    2.184323] Modules linked in:                              

Anyway, here is what I did.

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 97f1e4bc47dc..9663bc777888 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -353,9 +353,10 @@ static int trace_selftest_ops(struct trace_array *tr, int cnt)
 }
 
 /* Test dynamic code modification and ftrace filters */
-static int trace_selftest_startup_dynamic_tracing(struct tracer *trace,
-						  struct trace_array *tr,
-						  int (*func)(void))
+static int noinline
+trace_selftest_startup_dynamic_tracing(struct tracer *trace,
+					struct trace_array *tr,
+					int (*func)(void))
 {
 	int save_ftrace_enabled = ftrace_enabled;
 	unsigned long count;
@@ -569,10 +570,22 @@ trace_selftest_function_recursion(void)
 	return ret;
 }
 #else
-# define trace_selftest_startup_dynamic_tracing(trace, tr, func) ({ 0; })
+static int trace_selftest_startup_dynamic_tracing(struct tracer *trace,
+					struct trace_array *tr,
+					int (*func)(void))
+{
+	if (!trace || !tr || !func)
+		return -EINVAL;
+	return 0;
+}
 # define trace_selftest_function_recursion() ({ 0; })
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
+int (*global_trace_selftest_startup_dynamic_tracing)(struct tracer *trace,
+					struct trace_array *tr,
+					int (*func)(void))
+	= trace_selftest_startup_dynamic_tracing;
+
 static enum {
 	TRACE_SELFTEST_REGS_START,
 	TRACE_SELFTEST_REGS_FOUND,
@@ -732,7 +745,7 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
 		goto out;
 	}
 
-	ret = trace_selftest_startup_dynamic_tracing(trace, tr,
+	ret = global_trace_selftest_startup_dynamic_tracing(trace, tr,
 						     DYN_FTRACE_TEST_NAME);
 	if (ret)
 		goto out;

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
