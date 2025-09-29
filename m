Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AB228CBC;
	Mon, 29 Sep 2025 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185308; cv=none; b=G/nnJu6GLRwXBvGfENOzROVN6pK+OItXKuDBwuMax1OrwIqQ4M5BU3J9zOedUAvqizaM9rM+l5ayi2DFrPOWbI/7b+in+kWtfClzBEVZpsfpWd/B7fzvxbR3lfZlpb8ZRH0EagPCfSy4MKXG+Xg5Ts0ZbULrIIZ4LEOdirkiSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185308; c=relaxed/simple;
	bh=SYiCDNGQhqdj7trgMRJ+Do6gam3RrhPxWL2vDWg7o2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVvo2gsB+BpbeBaHisNoGMRCcHuZFXIxOvK84ehByftEuZvOKig4kw+wOeRRbxQ55QufGJAgKXg5YnEaoXz5JamA3T/4Qe6OrfqHAWE3FkyU87oYjMCi6D95TLcRZJMAudttSGjDFj8h72Q9WarDkL40kTy+s8aLYwqB5OImyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nADvPc+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nADvPc+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C1BC4CEF4;
	Mon, 29 Sep 2025 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185307;
	bh=SYiCDNGQhqdj7trgMRJ+Do6gam3RrhPxWL2vDWg7o2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nADvPc+W+30lCK/FZXdtw2F/188bKn0dDh3koGzYbXBC6OG/y75vU+U6wDsSWdnfd
	 YyXHrBWEMgXWWjGqSrRE0Q0/ly2VY8cxsGpBvMFiyQ0wVWvZYcWZvNCs7kEXjCp0Z0
	 TJ+LAWjCCeCy8ppwn6V+CKgcqtabJl8OlKiR6xmHPUPVsSgSclR/LErzTkxkE8kXsx
	 vn8hxMG7246GRnpOBsKmbZUEDMqkjysWiE4bYRiQiMgJbSZcm2CtlXt7yMQIhP2wQs
	 gVo/9K2FYjDqa0Rb8qNi8ToMyQeYMVEF9AVuTDnR/FaagtIaBCDVXJBJzbCaL5vRkX
	 oFkP/fIeEIWZg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Tue, 30 Sep 2025 07:35:03 +0900
Message-ID: <175918530312.65920.16883543165110119969.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175918528341.65920.10238038992631012350.stgit@devnote2>
References: <175918528341.65920.10238038992631012350.stgit@devnote2>
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
 Changes in v2:
  - Define a dummy TRACE_ITER_PROF_TEXT_OFFSET if CONFIG_FUNCTION_PROFILER=n.
---
 kernel/trace/ftrace.c |   26 +++++++++++++++++++++++++-
 kernel/trace/trace.c  |    5 +++--
 kernel/trace/trace.h  |   11 ++++++++++-
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 00b76d450a89..d4802bb93793 100644
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
+	if (tr->trace_flags & TRACE_ITER_PROF_TEXT_OFFSET) {
+		long offset;
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
+			snprintf(str, sizeof(str), "  %s%+ld", refsymbol, offset);
+	}
+	if (!refsymbol)
+		kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
+
 	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 652b7dd34c25..3c39b7c68742 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -527,7 +527,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
-	       TRACE_ITER_PRINTK_MSGONLY | TRACE_ITER_RECORD_CMD)
+	       TRACE_ITER_PRINTK_MSGONLY | TRACE_ITER_RECORD_CMD |	\
+	       TRACE_ITER_PROF_TEXT_OFFSET)
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
@@ -11111,7 +11112,7 @@ __init static int tracer_alloc_buffers(void)
 
 #ifdef CONFIG_FUNCTION_TRACER
 /* Used to set module cached ftrace filtering at boot up */
-__init struct trace_array *trace_get_global_array(void)
+struct trace_array *trace_get_global_array(void)
 {
 	return &global_trace;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 41c613ea0b4d..b64f322d8c52 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1353,6 +1353,14 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_FUNCTION_PROFILER
+# define PROFILER_FLAGS					\
+		C(PROF_TEXT_OFFSET,	"prof-text-offset")
+#else
+# define PROFILER_FLAGS
+# define TRACE_ITER_PROF_TEXT_OFFSET	0UL
+#endif
+
 /*
  * trace_iterator_flags is an enumeration that defines bit
  * positions into trace_flags that controls the output.
@@ -1391,7 +1399,8 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-		BRANCH_FLAGS
+		BRANCH_FLAGS					\
+		PROFILER_FLAGS
 
 /*
  * By defining C, we can make TRACE_FLAGS a list of bit names

