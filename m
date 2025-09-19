Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D22522BE;
	Fri, 19 Sep 2025 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758261355; cv=none; b=dB+wc+82ninj4SOzUl65bwQSXWkq+Tn0KAR3uDzZr5Hn8AeyijPbTFRHxJCw05qJyDK6c9ZFtu4TIy30CKjchhnZeGXlfWMp6u9OMqPK+lcrnxKev/zSjQNn/wEhUzEC0RwQw1U2UoYBD/bhWkYq6eHpjjLRXNduruoaZlQZdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758261355; c=relaxed/simple;
	bh=fn2LTaeB7nmbRxugxeZG6nhXPDtiqg7HUccKWZc+oZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SK1/3VIcgVePtcz3v+l+St7UcA39jC5SyJjnqvOOZelJ7oWhLGPnvt5ex+8sxKh65AVabvI04vBT4lqdafsCg1CCBElani+pXgI++fG+pREdJK28eVjVILE4RSnK2MkVoavmye343nWRsW32pOe2nwAIcWJgx678teC+3nvuYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP6W36si; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP6W36si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB283C4CEF0;
	Fri, 19 Sep 2025 05:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758261354;
	bh=fn2LTaeB7nmbRxugxeZG6nhXPDtiqg7HUccKWZc+oZI=;
	h=From:To:Cc:Subject:Date:From;
	b=UP6W36si3ug6giUmM3i4niYCh2tXKVWIYS9y/iIMkTkw9waIFEbmpCXU73ST69vtT
	 06S970dwx0vhudb+mQO7ztJ1sB8iszjnGmDX9AjUo+BUfkFE8Yq1dRwaGLdGJCqqs4
	 MbVvJXCAQiX7CNJbaET6J24nsEaiBUuW9mZ2a2bKyp3oLJ+MZ/LVNrBFyWuen0PYzO
	 kVGW7sSAn5OXt7QpJaf2DR01NdtZaJz3DL4oFb1KvbH2uf00FyvUGoKWY2Va8JdKIf
	 p8b7jI/Was7FW6t1wiVVXQ3MZLjJYfxseopvYyf434aiA2CZcGmcv28s+zZoWXVr4L
	 uD+5Q9RweiEFg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Fri, 19 Sep 2025 14:55:50 +0900
Message-ID: <175826135058.101165.7219957344129610147.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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
 kernel/trace/ftrace.c |   26 +++++++++++++++++++++++++-
 kernel/trace/trace.c  |    5 +++--
 kernel/trace/trace.h  |   10 +++++++++-
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a69067367c29..c759cc392fbe 100644
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
index b3c94fbaf002..bd82b28b8d2b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -522,7 +522,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
-	       TRACE_ITER_PRINTK_MSGONLY | TRACE_ITER_RECORD_CMD)
+	       TRACE_ITER_PRINTK_MSGONLY | TRACE_ITER_RECORD_CMD |	\
+	       TRACE_ITER_PROF_TEXT_OFFSET)
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
@@ -11115,7 +11116,7 @@ __init static int tracer_alloc_buffers(void)
 
 #ifdef CONFIG_FUNCTION_TRACER
 /* Used to set module cached ftrace filtering at boot up */
-__init struct trace_array *trace_get_global_array(void)
+struct trace_array *trace_get_global_array(void)
 {
 	return &global_trace;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5f4bed5842f9..f698aac73b14 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1359,6 +1359,13 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_FUNCTION_PROFILER
+# define PROFILER_FLAGS					\
+		C(PROF_TEXT_OFFSET,	"prof-text-offset"),
+#else
+# define PROFILER_FLAGS
+#endif
+
 /*
  * trace_iterator_flags is an enumeration that defines bit
  * positions into trace_flags that controls the output.
@@ -1397,7 +1404,8 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-		BRANCH_FLAGS
+		BRANCH_FLAGS					\
+		PROFILER_FLAGS
 
 /*
  * By defining C, we can make TRACE_FLAGS a list of bit names

