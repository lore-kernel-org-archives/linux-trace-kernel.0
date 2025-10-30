Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B82D97B9;
	Thu, 30 Oct 2025 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795028; cv=none; b=nTfwLyTbNNXK+jU1j+LSm09864XNa3XrG5qrT6MtDg5fw1chBMk88ilJ7eGjhGKkgt1V8E+lvfO1lvF4oF6xf+6l1jyDzhyE/nXegDIbrvsj2NTIyrhUmWEW+IC3gfYwVpuv9N9eVKBPG6aALEywuQqOJg8/z6s7r6lo1+1HuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795028; c=relaxed/simple;
	bh=N8ZPqAHpBjPLFwerKKxyTm227ZJH3a57nKRfFjYQSE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaM/4fLr8nSeTwMTNzNqUOz+ddz6OGoOKt322iHGgRoWmsgGSTjZBxPetUqhVDn7OmDPNuXeuyQwf6DfSB9UTr/XZA6ZCLZk3nc0SZ4KgNWiBsuqBtZOfgmIGD3AfrnwUaZg6wPEOR0LT+jHQPJUeMDqGrMoYzy9rdykkABN0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s17BFMTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s17BFMTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12233C4CEF1;
	Thu, 30 Oct 2025 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761795028;
	bh=N8ZPqAHpBjPLFwerKKxyTm227ZJH3a57nKRfFjYQSE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s17BFMTuFVfhnDmLVyuJjsVRr4lgB+6axqWa05Z/stahpiKFFKhOnXfGSCb24OzjL
	 I7xYdEnYfwsClv5aPhX9yrLQ5Qq5uCHJKOnkKZNw8D+AUvG9Qxu/uAX9SQ+FZ1gQcM
	 +ZhiXZLum1UoOcAEZ9ztA8WA8+R1gaUCIQmwbzmhq/4xMY63ysfiCLjPcbdaKVn/uZ
	 RRv8ftuCc8JVc7U13PYDLVmaWAZ+HiG3yXNgK9kg5QWxxBlSjlMPbV4hv7mkzzuj+0
	 OjkUNh/5CL6XWPEeAzQf4NmqjTRNfcwdHJX6/J7jaOON0D2q9wCO6xng1vXgGQE8/z
	 g7Iih+Jh85I0w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Thu, 30 Oct 2025 12:30:24 +0900
Message-ID: <176179502461.960652.1171078579860650230.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176179500583.960652.5730113001091388258.stgit@devnote2>
References: <176179500583.960652.5730113001091388258.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Function profiler shows the hit count of each function using its symbol
name. However, there are some same-name local symbols, which we can not
distinguish.
To solve this issue, this introduces an option to show the symbols
in "_text+OFFSET" format. This can avoid exposing the random shift of
KASLR. The functions in modules are shown as "MODNAME+OFFSET" where the
offset is from ".text".

E.g. for the kernel text symbols, specify vmlinux and the output to
 addr2line, you can find the actual function and source info;

  $ addr2line -fie vmlinux _text+3078208
  __balance_callbacks
  kernel/sched/core.c:5064

for modules, specify the module file and .text+OFFSET;

  $ addr2line -fie samples/trace_events/trace-events-sample.ko .text+8224
  do_simple_thread_func
  samples/trace_events/trace-events-sample.c:23

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - Show offset in hex.
  - Make offset unsigned long.
 Changes in v5:
  - Update dummy flag according to new macros.
 Changes in v2:
  - Define a dummy TRACE_ITER_PROF_TEXT_OFFSET if CONFIG_FUNCTION_PROFILER=n.
---
 kernel/trace/ftrace.c |   26 +++++++++++++++++++++++++-
 kernel/trace/trace.c  |    5 +++--
 kernel/trace/trace.h  |   11 ++++++++++-
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 42bd2ba68a82..ab601cd9638b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -534,7 +534,9 @@ static int function_stat_headers(struct seq_file *m)
 
 static int function_stat_show(struct seq_file *m, void *v)
 {
+	struct trace_array *tr = trace_get_global_array();
 	struct ftrace_profile *rec = v;
+	const char *refsymbol = NULL;
 	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	static struct trace_seq s;
@@ -554,7 +556,29 @@ static int function_stat_show(struct seq_file *m, void *v)
 		return 0;
 #endif
 
-	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
+	if (tr->trace_flags & TRACE_ITER(PROF_TEXT_OFFSET)) {
+		unsigned long offset;
+
+		if (core_kernel_text(rec->ip)) {
+			refsymbol = "_text";
+			offset = rec->ip - (unsigned long)_text;
+		} else {
+			struct module *mod;
+
+			guard(rcu)();
+			mod = __module_text_address(rec->ip);
+			if (mod) {
+				refsymbol = mod->name;
+				/* Calculate offset from module's text entry address. */
+				offset = rec->ip - (unsigned long)mod->mem[MOD_TEXT].base;
+			}
+		}
+		if (refsymbol)
+			snprintf(str, sizeof(str), "  %s+%#lx", refsymbol, offset);
+	}
+	if (!refsymbol)
+		kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
+
 	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 70e30d615f72..61aa57c5f0d8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -523,7 +523,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER(PRINTK) |			\
-	       TRACE_ITER(PRINTK_MSGONLY) | TRACE_ITER(RECORD_CMD))
+	       TRACE_ITER(PRINTK_MSGONLY) | TRACE_ITER(RECORD_CMD) |	\
+	       TRACE_ITER(PROF_TEXT_OFFSET))
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
@@ -11495,7 +11496,7 @@ __init static int tracer_alloc_buffers(void)
 
 #ifdef CONFIG_FUNCTION_TRACER
 /* Used to set module cached ftrace filtering at boot up */
-__init struct trace_array *trace_get_global_array(void)
+struct trace_array *trace_get_global_array(void)
 {
 	return &global_trace;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 12716fe227bf..a3a15cfabacd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1367,6 +1367,14 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_FUNCTION_PROFILER
+# define PROFILER_FLAGS					\
+		C(PROF_TEXT_OFFSET,	"prof-text-offset"),
+#else
+# define PROFILER_FLAGS
+# define TRACE_ITER_PROF_TEXT_OFFSET_BIT	-1
+#endif
+
 /*
  * trace_iterator_flags is an enumeration that defines bit
  * positions into trace_flags that controls the output.
@@ -1405,7 +1413,8 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-		BRANCH_FLAGS
+		BRANCH_FLAGS					\
+		PROFILER_FLAGS
 
 /*
  * By defining C, we can make TRACE_FLAGS a list of bit names

