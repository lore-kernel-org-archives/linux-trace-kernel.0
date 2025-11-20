Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E2221271;
	Thu, 20 Nov 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680493; cv=none; b=Uv1DNIfYt84RVhg4LkOAgvwbiK+IqF2OyuQIvFpYCy+5B6rKpMkRtx7ATpic69eIYXp43dn0sUFMyBAG99UiBIl+dMUwkm/B7x5EGe3dDYfwbzLjmsQQuTV5083puWwkSs6aZMi1aIjSF18t2DebVz1z+42p8a+Spr2cOhimv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680493; c=relaxed/simple;
	bh=0SJv0sGzKvvBYD1n3bx7OWfn0PnVi2MaSnJaUvnU8Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GPp+f6MMP8e2kBnKUwkHaeFGF5xMDfqr09pat4+p79I37/6viFV4IOz4pvAobgecJ4KBC2kgjTAWtftJ2mntpQsXce6V3XvApY5Kd6+pYjz+Kaqtws0/EuPHKrRr2fqhmuPeoLxtdoss/AwZnQNpNh15EAEm0dpRWJQ9IxLEyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E816B16038A;
	Thu, 20 Nov 2025 23:14:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 0C5606000D;
	Thu, 20 Nov 2025 23:14:41 +0000 (UTC)
Date: Thu, 20 Nov 2025 18:15:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Tom
 Zanussi <zanussi@kernel.org>
Subject: [PATCH] ftrace: Allow tracing of some of the tracing code
Message-ID: <20251120181514.736f2d5f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: b7fymcwz4tdi33pnkysmtftn5dfya6r5
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0C5606000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18VA5pcKeXK6k9PcBr0p6Igeo9SgYFHsSM=
X-HE-Tag: 1763680481-489509
X-HE-Meta: U2FsdGVkX1/G0Sii4BpLcUjUoH6YaMp5GyVVh+6r58VUBHJvpd9N4E522Z//SH6ywbspdVm6r7FR9gHfIroc4aM0UHML5ASONbp0HV2+4I25e994SXalRAJE6/giK37h223m6Wuris4feTXSQggX1k4SeuOCa8GRSedD+J25P0WDNFX2NNgCvJ+xVad6I7tLVRX7AeChO5X9a+SStPukYTDR5Nr9+do6l5Ls5ddWA8AwmqoA/ExcWXe4LlC9qt0PbiYwZvOtlUfUUbzAREgenXCzSKjqjt2xgHRBYNzSQF2/A+IEEjbX9a+NKMYZNocj7hBsp8QQgbqDkzFniR8AysaUjqryhX3Kuc8AlQnBro7HuQ6xDHKyya9Pjv17L9nD

From: Steven Rostedt <rostedt@goodmis.org>

There is times when tracing the tracing infrastructure can be useful for
debugging the tracing code. Currently all files in the tracing directory
are set to "notrace" the functions.

Add a new config option FUNCTION_SELF_TRACING that will allow some of the
files in the tracing infrastructure to be traced. It requires a config to
enable because it will add noise to the function tracer if events and
other tracing features are enabled. Tracing functions and events together
is quite common, so not tracing the event code should be the default.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig  | 14 ++++++++++++++
 kernel/trace/Makefile | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 99283b2dcfd6..e1214b9dc990 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -330,6 +330,20 @@ config DYNAMIC_FTRACE_WITH_ARGS
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+config FUNCTION_SELF_TRACING
+	bool "Function trace tracing code"
+	depends on FUNCTION_TRACER
+	help
+	  Normally all the tracing code is set to notrace, where the function
+	  tracer will ignore all the tracing functions. Sometimes it is useful
+	  for debugging to trace some of the tracing infratructure itself.
+	  Enable this to allow some of the tracing infrastructure to be traced
+	  by the function tracer. Note, this will likely add noise to function
+	  tracing if events and other tracing features are enabled along with
+	  function tracing.
+
+	  If unsure, say N.
+
 config FPROBE
 	bool "Kernel Function Probe (fprobe)"
 	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index dcb4e02afc5f..fc5dcc888e13 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -16,6 +16,23 @@ obj-y += trace_selftest_dynamic.o
 endif
 endif
 
+# Allow some files to be function traced
+ifdef CONFIG_FUNCTION_SELF_TRACING
+CFLAGS_trace_output.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_seq.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_stat.o = $(CC_FLAGS_FTRACE)
+CFLAGS_tracing_map.o = $(CC_FLAGS_FTRACE)
+CFLAGS_synth_event_gen_test.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_events.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_syscalls.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_events_filter.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_events_trigger.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_events_synth.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_events_hist.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_events_user.o = $(CC_FLAGS_FTRACE)
+CFLAGS_trace_dynevent.o = $(CC_FLAGS_FTRACE)
+endif
+
 ifdef CONFIG_FTRACE_STARTUP_TEST
 CFLAGS_trace_kprobe_selftest.o = $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe_selftest.o
-- 
2.51.0

