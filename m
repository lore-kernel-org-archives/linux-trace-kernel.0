Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C711A265E;
	Wed,  8 Jan 2025 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302295; cv=none; b=dtMI/eEe03fLpG8sHUm4wkB859JFgzU0zCEJ0hOSJP41LGkMmExNqDKLNYXzSge31y51fK85moz0oF0PXUAi6pjphKPtu9ZhBQfsml8nBANNd4sKVpL8eRZePXR45ttmEvPdrrLIVjuvLeREFtdZAjoWbGOE+g1MiRrj4gXzjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302295; c=relaxed/simple;
	bh=cWfM7pDjpnXkX6rzKo3buzt3QtdFFTEv3P6Y91fHmqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJih9zPX7xUdbejlnI3BoAVS2YdUxEm6XsiKHNEAIHsZTE0X3pwxy9HqjK8oGNfqK9u4DxNTN3ivbNLrgNCOGjimjdErT8W7LvT3PTnJToZeBVuSyY0DbWRGhK3or3P88d/URK8hFpN0uIU/n6jgBM5HhW5QidyK3YNBrOKNWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+nn+Zd4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+nn+Zd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2D3C4CED6;
	Wed,  8 Jan 2025 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302295;
	bh=cWfM7pDjpnXkX6rzKo3buzt3QtdFFTEv3P6Y91fHmqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+nn+Zd4r/Qo1kpbdhsyW+iqj+AxcD5J2EMvkHkUYiHiRqO5i5ffZRlZFNh2LsDcc
	 5dpjlSbJmnAvWrSI14wdJRIv/E4mX1T6C+3umgUTBhRhVeSO5vm5Mmzxxgtr9fBZFl
	 cX80DWALzIbPqLm14Yz8VvvArW+eQ20tvbkg+dS/F1boF9IkYwGx45KqlMiSQEb6uJ
	 IHlwFWzfFT43c+sP491rIgjtqNpLaTjOTuzD5K7pPA9wT7L+uTkOwRQ9zgyOe4hKB0
	 L0Actnwd0VtQ2A9FaXGjkITcWfiXJo9FO+z6o7zU0DQA705bR064ACWkibPvLAwXlX
	 JjKhV4belkhqQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] tracing: Adopt __free() and guard() for trace_fprobe.c
Date: Wed,  8 Jan 2025 11:11:30 +0900
Message-ID: <173630229003.1453474.2286376301458030998.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173630223453.1453474.6442447279377996686.stgit@devnote2>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
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

Adopt __free() and guard() for trace_fprobe.c to remove gotos.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |  129 ++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 69 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index c62d1629cffe..6d339c426b5d 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -379,6 +379,9 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
 	}
 }
 
+/* Since alloc_trace_fprobe() can return error, check the pointer is ERR too. */
+DEFINE_FREE(trace_fprobe, struct trace_fprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_fprobe(_T))
+
 /*
  * Allocate new trace_probe and initialize it (including fprobe).
  */
@@ -390,7 +393,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       int maxactive,
 					       int nargs, bool is_return)
 {
-	struct trace_fprobe *tf;
+	struct trace_fprobe *tf __free(trace_fprobe) = NULL;
 	int ret = -ENOMEM;
 
 	tf = kzalloc(struct_size(tf, tp.args, nargs), GFP_KERNEL);
@@ -399,7 +402,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 
 	tf->symbol = kstrdup(symbol, GFP_KERNEL);
 	if (!tf->symbol)
-		goto error;
+		return ERR_PTR(-ENOMEM);
 
 	if (is_return)
 		tf->fp.exit_handler = fexit_dispatcher;
@@ -412,13 +415,10 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 
 	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
 	if (ret < 0)
-		goto error;
+		return ERR_PTR(ret);
 
 	dyn_event_init(&tf->devent, &trace_fprobe_ops);
-	return tf;
-error:
-	free_trace_fprobe(tf);
-	return ERR_PTR(ret);
+	return_ptr(tf);
 }
 
 static struct trace_fprobe *find_trace_fprobe(const char *event,
@@ -845,14 +845,12 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 	struct trace_fprobe *old_tf;
 	int ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	old_tf = find_trace_fprobe(trace_probe_name(&tf->tp),
 				   trace_probe_group_name(&tf->tp));
-	if (old_tf) {
-		ret = append_trace_fprobe(tf, old_tf);
-		goto end;
-	}
+	if (old_tf)
+		return append_trace_fprobe(tf, old_tf);
 
 	/* Register new event */
 	ret = register_fprobe_event(tf);
@@ -862,7 +860,7 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 			trace_probe_log_err(0, EVENT_EXIST);
 		} else
 			pr_warn("Failed to register probe event(%d)\n", ret);
-		goto end;
+		return ret;
 	}
 
 	/* Register fprobe */
@@ -872,8 +870,6 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 	else
 		dyn_event_add(&tf->devent, trace_probe_event_call(&tf->tp));
 
-end:
-	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -1034,7 +1030,10 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	return 0;
 }
 
-static int __trace_fprobe_create(int argc, const char *argv[])
+DEFINE_FREE(module_put, struct module *, if (_T) module_put(_T))
+
+static int ___trace_fprobe_create(int argc, const char *argv[],
+				  struct traceprobe_parse_context *ctx)
 {
 	/*
 	 * Argument syntax:
@@ -1060,24 +1059,21 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	 * Type of args:
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
-	struct trace_fprobe *tf = NULL;
+	struct trace_fprobe *tf __free(trace_fprobe) = NULL;
 	int i, len, new_argc = 0, ret = 0;
 	bool is_return = false;
-	char *symbol = NULL;
+	char *symbol __free(kfree) = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
-	const char **new_argv = NULL;
+	const char **new_argv __free(kfree) = NULL;
 	int maxactive = 0;
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char sbuf[KSYM_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
-	char *dbuf = NULL;
+	char *dbuf __free(kfree) = NULL;
 	bool is_tracepoint = false;
-	struct module *tp_mod = NULL;
+	struct module *tp_mod __free(module_put) = NULL;
 	struct tracepoint *tpoint = NULL;
-	struct traceprobe_parse_context ctx = {
-		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
-	};
 
 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
 		return -ECANCELED;
@@ -1087,8 +1083,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		group = TRACEPOINT_EVENT_SYSTEM;
 	}
 
-	trace_probe_log_init("trace_fprobe", argc, argv);
-
 	event = strchr(&argv[0][1], ':');
 	if (event)
 		event++;
@@ -1100,21 +1094,21 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 			len = strlen(&argv[0][1]);
 		if (len > MAX_EVENT_NAME_LEN - 1) {
 			trace_probe_log_err(1, BAD_MAXACT);
-			goto parse_error;
+			return -EINVAL;
 		}
 		memcpy(buf, &argv[0][1], len);
 		buf[len] = '\0';
 		ret = kstrtouint(buf, 0, &maxactive);
 		if (ret || !maxactive) {
 			trace_probe_log_err(1, BAD_MAXACT);
-			goto parse_error;
+			return -EINVAL;
 		}
 		/* fprobe rethook instances are iterated over via a list. The
 		 * maximum should stay reasonable.
 		 */
 		if (maxactive > RETHOOK_MAXACTIVE_MAX) {
 			trace_probe_log_err(1, MAXACT_TOO_BIG);
-			goto parse_error;
+			return -EINVAL;
 		}
 	}
 
@@ -1123,12 +1117,12 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	/* a symbol(or tracepoint) must be specified */
 	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
 	if (ret < 0)
-		goto parse_error;
+		return -EINVAL;
 
 	if (!is_return && maxactive) {
 		trace_probe_log_set_index(0);
 		trace_probe_log_err(1, BAD_MAXACT_TYPE);
-		goto parse_error;
+		return -EINVAL;
 	}
 
 	trace_probe_log_set_index(0);
@@ -1136,7 +1130,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
-			goto parse_error;
+			return -EINVAL;
 	}
 
 	if (!event) {
@@ -1152,49 +1146,44 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	}
 
 	if (is_return)
-		ctx.flags |= TPARG_FL_RETURN;
+		ctx->flags |= TPARG_FL_RETURN;
 	else
-		ctx.flags |= TPARG_FL_FENTRY;
+		ctx->flags |= TPARG_FL_FENTRY;
 
 	if (is_tracepoint) {
-		ctx.flags |= TPARG_FL_TPOINT;
+		ctx->flags |= TPARG_FL_TPOINT;
 		tpoint = find_tracepoint(symbol, &tp_mod);
 		if (tpoint) {
-			ctx.funcname = kallsyms_lookup(
+			ctx->funcname = kallsyms_lookup(
 				(unsigned long)tpoint->probestub,
 				NULL, NULL, NULL, sbuf);
 		} else if (IS_ENABLED(CONFIG_MODULES)) {
 				/* This *may* be loaded afterwards */
 				tpoint = TRACEPOINT_STUB;
-				ctx.funcname = symbol;
+				ctx->funcname = symbol;
 		} else {
 			trace_probe_log_set_index(1);
 			trace_probe_log_err(0, NO_TRACEPOINT);
-			goto parse_error;
+			return -EINVAL;
 		}
 	} else
-		ctx.funcname = symbol;
+		ctx->funcname = symbol;
 
 	argc -= 2; argv += 2;
 	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
-					       abuf, MAX_BTF_ARGS_LEN, &ctx);
-	if (IS_ERR(new_argv)) {
-		ret = PTR_ERR(new_argv);
-		new_argv = NULL;
-		goto out;
-	}
+					       abuf, MAX_BTF_ARGS_LEN, ctx);
+	if (IS_ERR(new_argv))
+		return PTR_ERR(new_argv);
 	if (new_argv) {
 		argc = new_argc;
 		argv = new_argv;
 	}
-	if (argc > MAX_TRACE_ARGS) {
-		ret = -E2BIG;
-		goto out;
-	}
+	if (argc > MAX_TRACE_ARGS)
+		return -E2BIG;
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* setup a probe */
 	tf = alloc_trace_fprobe(group, event, symbol, tpoint, tp_mod,
@@ -1203,16 +1192,16 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
-		goto out;	/* We know tf is not allocated */
+		return ret;
 	}
 
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
-		ctx.offset = 0;
-		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &ctx);
+		ctx->offset = 0;
+		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], ctx);
 		if (ret)
-			goto error;	/* This can be -ENOMEM */
+			return ret;	/* This can be -ENOMEM */
 	}
 
 	if (is_return && tf->tp.entry_arg) {
@@ -1223,7 +1212,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	ret = traceprobe_set_print_fmt(&tf->tp,
 			is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL);
 	if (ret < 0)
-		goto error;
+		return ret;
 
 	ret = register_trace_fprobe(tf);
 	if (ret) {
@@ -1234,24 +1223,26 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 		else if (ret != -ENOMEM && ret != -EEXIST)
 			trace_probe_log_err(0, FAIL_REG_PROBE);
-		goto error;
-	}
+		ret = -EINVAL;
+	} else
+		/* 'tf' is successfully registered. To avoid freeing, assign NULL. */
+		tf = NULL;
 
-out:
-	if (tp_mod)
-		module_put(tp_mod);
+	return ret;
+}
+
+static int __trace_fprobe_create(int argc, const char *argv[])
+{
+	struct traceprobe_parse_context ctx = {
+		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
+	};
+	int ret;
+
+	trace_probe_log_init("trace_fprobe", argc, argv);
+	ret = ___trace_fprobe_create(argc, argv, &ctx);
 	traceprobe_finish_parse(&ctx);
 	trace_probe_log_clear();
-	kfree(new_argv);
-	kfree(symbol);
-	kfree(dbuf);
 	return ret;
-
-parse_error:
-	ret = -EINVAL;
-error:
-	free_trace_fprobe(tf);
-	goto out;
 }
 
 static int trace_fprobe_create(const char *raw_command)

