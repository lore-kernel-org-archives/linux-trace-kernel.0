Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA52C029A;
	Fri, 17 Oct 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717756; cv=none; b=MAh4WARoAKcoYluWghq+jQEl/3NgaUToBABpF0zNWE+vmhQYIHaNl/ZmuHzDGv5i7Lt03FmSZLpaG42ZewrNCly0mGrWixYicH54v6toSAdwuiufHAGqE9z5btloDuM6+YhDmFZphRIhqor60naHFp/mjhx3zwK1DiMQmEQoUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717756; c=relaxed/simple;
	bh=iN9QxgdL5sM1aHqGKMzcz8sT8xP19Pb9eUWgXg1nfKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAFfYk8ql8EZ8VS3JAw9ZYvUy510i5oeeSXoQty03WpgCp0fyWUPtty6Bs59rjWMBb+IH1+XtQuZ0PE5HCyiGKJsdCtOXWm7G6ZOJpu0N3KGU1FeMX5bgBrFlGtjlN9gfJEOwSOM1whpsy9FqZQxzUlhZ3YxGOKssbrZZJEJROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+p3BAVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+p3BAVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFD7C113D0;
	Fri, 17 Oct 2025 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760717755;
	bh=iN9QxgdL5sM1aHqGKMzcz8sT8xP19Pb9eUWgXg1nfKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+p3BAVbFYGVjyj1/5eJ59fJTBHTH74pSYvEFU8RBBYNrvFSnJwQSUSOslz3OBEEi
	 LNjZ47mxlszLJ4gjbHCHwdq7drsAmi4zfzAJ2sBBMuPWAgbWFLE962dme/LuQWTYB/
	 B9NKliXf2SC5CjoM4N/13vO7CLiEkbOcHYr4nf0IsBU12TqznFYgWqKNIMAafJ+qKZ
	 sN24tAa7mLR1wi+/NZGYeFKDWLXM91jRd1eoIxWQHUHsf98your/HZo1PQ0FGUpeKd
	 qjaNY0RFLFpWRpuqM8yTShmr4Ua0/h+KR0Xc4WNtIsr5KGnjJOg3mYCvaa0TtYTqnU
	 kF6hIuEsLbX2w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Sat, 18 Oct 2025 01:15:50 +0900
Message-ID: <176071775059.175601.3827350589430991963.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176071773144.175601.17884676964675287059.stgit@devnote2>
References: <176071773144.175601.17884676964675287059.stgit@devnote2>
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
index 2b3fe0a30c7d..9f254c290bcd 100644
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
@@ -11106,7 +11107,7 @@ __init static int tracer_alloc_buffers(void)
 
 #ifdef CONFIG_FUNCTION_TRACER
 /* Used to set module cached ftrace filtering at boot up */
-__init struct trace_array *trace_get_global_array(void)
+struct trace_array *trace_get_global_array(void)
 {
 	return &global_trace;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index caec534072e7..3d034dd753c6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1353,6 +1353,14 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_FUNCTION_PROFILER
+# define PROFILER_FLAGS					\
+		C(PROF_TEXT_OFFSET,	"prof-text-offset"),
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

