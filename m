Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733811CAF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080437; cv=none; b=qTTctpJxv5ZeNi2QW8umQveSaV6MJOZo621kjPyoBtXnAn6MkwQ/r+VJbBaX6gKltZiGalcxpLbDqDGYZeC9HEs5oNNcrgnJoyCRc4oA+1aWGYLaYUfv8eoo5h8f6tpS0H4CDWwFcg19zEldHXzC1d2aBw0e674pdRjr+ZBTFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080437; c=relaxed/simple;
	bh=3wXEPXsxu/oMJl5HNJJc1n9SMwDyb81RSpXxDmfvgbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jdv9G4QEPsTxVUGsPu7GUWuEb9WwTzBEKpdMM5mA2PMW/GTQOZht6OfZXJC4MvzQe3C0m1iamufx/18sPJMO4apBOzOrUzl0gofkSuvOKesoqRc0cBi7az+C0GF3MDbzfCL1RMcLb7O+sNYtEF/lYbuXf+62UN4whr3lC+UtTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2DjI2v3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2DjI2v3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E8DC4CED6;
	Fri, 17 Jan 2025 02:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737080436;
	bh=3wXEPXsxu/oMJl5HNJJc1n9SMwDyb81RSpXxDmfvgbs=;
	h=From:To:Cc:Subject:Date:From;
	b=O2DjI2v3EhHBK9ETD6RQHc+N9RMoIz1wrN28r13GcBvKiVw0AD0iC8VJeQobwDIkg
	 l/GGd9KpCg5FFFJS/acjf/uWQ1OWKq6MnCTeleKpBSGvdM4f9L74wajzwAru413aFQ
	 1/H0+wWCAX/mWG5WdTlooVI6uy++P9u7q+3NJwIAG09BCx2mY7KamW0/X2v4Zwquyq
	 5zZ6LSA3N8K/LFr+9fbsW2zzLHBx2IxEjt18mJl+wOmEnyvP0mVolmDy6SSU4Rkaj7
	 Uzai7GhTMUE91r5a/5/hIzf3tTgpKFD5MiD10mIZn8KFpLy0OHr2QZsyml2RC6OrLk
	 uSRUlZf6c8I0A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7] tracing: Adopt __free() and guard() for trace_fprobe.c
Date: Fri, 17 Jan 2025 11:20:34 +0900
Message-ID:  <173708043449.319651.12242878905778792182.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
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
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v7:
  - Rebased on top of ftrace/for-next because trace_fprobe.c
   has been changed by fprobe on fgraph series.
---
 kernel/trace/trace_fprobe.c |  124 ++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 66 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index f487fadc2c08..b8f3c4ba309b 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -416,6 +416,9 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
 	}
 }
 
+/* Since alloc_trace_fprobe() can return error, check the pointer is ERR too. */
+DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_fprobe(_T))
+
 /*
  * Allocate new trace_probe and initialize it (including fprobe).
  */
@@ -426,7 +429,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       struct module *mod,
 					       int nargs, bool is_return)
 {
-	struct trace_fprobe *tf;
+	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
 	int ret = -ENOMEM;
 
 	tf = kzalloc(struct_size(tf, tp.args, nargs), GFP_KERNEL);
@@ -435,7 +438,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 
 	tf->symbol = kstrdup(symbol, GFP_KERNEL);
 	if (!tf->symbol)
-		goto error;
+		return ERR_PTR(-ENOMEM);
 
 	if (is_return)
 		tf->fp.exit_handler = fexit_dispatcher;
@@ -447,13 +450,10 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 
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
@@ -880,14 +880,12 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
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
@@ -897,7 +895,7 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 			trace_probe_log_err(0, EVENT_EXIST);
 		} else
 			pr_warn("Failed to register probe event(%d)\n", ret);
-		goto end;
+		return ret;
 	}
 
 	/* Register fprobe */
@@ -907,8 +905,6 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 	else
 		dyn_event_add(&tf->devent, trace_probe_event_call(&tf->tp));
 
-end:
-	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -1069,7 +1065,10 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	return 0;
 }
 
-static int __trace_fprobe_create(int argc, const char *argv[])
+DEFINE_FREE(module_put, struct module *, if (_T) module_put(_T))
+
+static int trace_fprobe_create_internal(int argc, const char *argv[],
+					struct traceprobe_parse_context *ctx)
 {
 	/*
 	 * Argument syntax:
@@ -1095,23 +1094,20 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	 * Type of args:
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
-	struct trace_fprobe *tf = NULL;
+	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
 	int i, new_argc = 0, ret = 0;
 	bool is_return = false;
-	char *symbol = NULL;
+	char *symbol __free(kfree) = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
-	const char **new_argv = NULL;
+	const char **new_argv __free(kfree) = NULL;
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
@@ -1121,13 +1117,11 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		group = TRACEPOINT_EVENT_SYSTEM;
 	}
 
-	trace_probe_log_init("trace_fprobe", argc, argv);
-
 	if (argv[0][1] != '\0') {
 		if (argv[0][1] != ':') {
 			trace_probe_log_set_index(0);
 			trace_probe_log_err(1, BAD_MAXACT);
-			goto parse_error;
+			return -EINVAL;
 		}
 		event = &argv[0][2];
 	}
@@ -1137,14 +1131,14 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	/* a symbol(or tracepoint) must be specified */
 	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
 	if (ret < 0)
-		goto parse_error;
+		return -EINVAL;
 
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
-			goto parse_error;
+			return -EINVAL;
 	}
 
 	if (!event) {
@@ -1160,49 +1154,44 @@ static int __trace_fprobe_create(int argc, const char *argv[])
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
@@ -1211,16 +1200,16 @@ static int __trace_fprobe_create(int argc, const char *argv[])
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
@@ -1231,7 +1220,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	ret = traceprobe_set_print_fmt(&tf->tp,
 			is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL);
 	if (ret < 0)
-		goto error;
+		return ret;
 
 	ret = register_trace_fprobe(tf);
 	if (ret) {
@@ -1242,29 +1231,32 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 		else if (ret != -ENOMEM && ret != -EEXIST)
 			trace_probe_log_err(0, FAIL_REG_PROBE);
-		goto error;
+		return -EINVAL;
 	}
 
-out:
-	if (tp_mod)
-		module_put(tp_mod);
+	/* 'tf' is successfully registered. To avoid freeing, assign NULL. */
+	tf = NULL;
+
+	return 0;
+}
+
+static int trace_fprobe_create_cb(int argc, const char *argv[])
+{
+	struct traceprobe_parse_context ctx = {
+		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
+	};
+	int ret;
+
+	trace_probe_log_init("trace_fprobe", argc, argv);
+	ret = trace_fprobe_create_internal(argc, argv, &ctx);
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
 {
-	return trace_probe_create(raw_command, __trace_fprobe_create);
+	return trace_probe_create(raw_command, trace_fprobe_create_cb);
 }
 
 static int trace_fprobe_release(struct dyn_event *ev)

