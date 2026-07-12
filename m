Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C41FC101;
	Sun, 12 Jul 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783868780; cv=none; b=UFnhHSm2pR+rqvoF6Z5NRwIMoXCPBX1Nlk68GvzO6AlaA8IYJEa505Zv12dZgDwYZwWd8q4y+HQKFp9pDqNdqcpMuKtDlKx54+mGxWrG0wKxenxBjereiYtSQNTJ0RHux+nk6NxpyGMeQeHf1EJwMjVIDobJSE/4+MoDX92VCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783868780; c=relaxed/simple;
	bh=sbUj+3v53dPLU66tan8aCdsvJuBn6HapejRXnHkwQxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihX1nyIBAojPF7VCT78gMeqZAoQcuQMXtX9A/I3n7qMufu+VbVZXTkc4L9t1Q/sdoCJypUL796dzXf+rZL5cDvVrm20odJ9epSJ4Xt7kii9jaPj+fSw90cZOg30M6QeTW7rtO8wUmy5qqC9SGRgaAbFa7ngY87Mumh0ETw/7/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT6u/YI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT6u/YI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7361F000E9;
	Sun, 12 Jul 2026 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783868779;
	bh=Lp2LKTwGDvoSloSg7EhLWRTt1pdS3kMEMSXspT6hlaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WT6u/YI30ko6ZSQQhf6nshtuP57JwxPgx9TAGi9DralRrp2MveLfAdSXZJiMdI/IM
	 kDx8bxq2HYPm0+8G4676VXw2enNyeu9wjgOviubbT869UsGHC3NMMzoq2iz01J+XyL
	 lICwIiFMTdbslo78uLHPmYN7PiS+NoP0g8d157X7rVy1cmq0Nz1D64v4Ue8WPQN9vk
	 GtR5DnaKFPW4BurhEC4okJNOKMgC2Icgb1P+aorGKhiVrf+D/OHCAQbNltbopQseep
	 7v1u5ZMbww3sYnRffC5XUdG77E+A3Szuh8Ur7zlE+ztc7NAMyzULsOT1HG7mcowjk/
	 m0YtSEJodrpLw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/5] tracing/probes: Refactor parse_probe_vars()
Date: Mon, 13 Jul 2026 00:06:15 +0900
Message-ID: <178386877517.3174487.13406442794979828170.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178386876526.3174487.5142283230157728964.stgit@devnote2>
References: <178386876526.3174487.5142283230157728964.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

Decompose parse_probe_vars() by extracting retval, stack, current task
struct, and function argument parsing logic into dedicated static
helper functions (parse_probe_var_retval, parse_probe_var_stack,
parse_probe_var_current, and parse_probe_var_arg). This simplifies
parse_probe_vars() and improves its readability.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |  248 +++++++++++++++++++++++++++-----------------
 1 file changed, 151 insertions(+), 97 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 18c212122344..b762336ebf03 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1319,67 +1319,147 @@ NOKPROBE_SYMBOL(store_trace_entry_data)
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
-/* Parse $vars. @orig_arg points '$', which syncs to @ctx->offset */
-static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
-			    struct fetch_insn **pcode,
-			    struct fetch_insn *end,
-			    struct traceprobe_parse_context *ctx)
+static int parse_probe_var_retval(char *orig_arg, char *arg,
+				  struct fetch_insn **pcode,
+				  struct fetch_insn *end,
+				  struct traceprobe_parse_context *ctx,
+				  int *err)
 {
 	struct fetch_insn *code = *pcode;
-	int err = TP_ERR_BAD_VAR;
-	char *arg = orig_arg + 1;
+
+	if (!(ctx->flags & TPARG_FL_RETURN)) {
+		*err = TP_ERR_RETVAL_ON_PROBE;
+		return -EINVAL;
+	}
+	if (!(ctx->flags & TPARG_FL_KERNEL) ||
+	    !IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS)) {
+		code->op = FETCH_OP_RETVAL;
+		return 0;
+	}
+	return parse_btf_arg(orig_arg, pcode, end, ctx);
+}
+
+static int parse_probe_var_stack(char *arg, int len, struct fetch_insn *code,
+				 struct traceprobe_parse_context *ctx,
+				 int *err)
+{
 	unsigned long param;
-	int ret = 0;
-	int len;
+	int ret;
 
-	if (ctx->flags & TPARG_FL_TEVENT) {
-		if (parse_trace_event(arg, code, ctx) < 0) {
-			/* 'comm' should be checked after field parsing. */
-			if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
-				code->op = FETCH_OP_COMM;
-				return 0;
-			}
-			goto inval;
-		}
+	if (arg[len] == '\0') {
+		code->op = FETCH_OP_STACKP;
 		return 0;
 	}
 
-	if (str_has_prefix(arg, "retval")) {
-		if (!(ctx->flags & TPARG_FL_RETURN)) {
-			err = TP_ERR_RETVAL_ON_PROBE;
-			goto inval;
-		}
-		if (!(ctx->flags & TPARG_FL_KERNEL) ||
-		    !IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS)) {
-			code->op = FETCH_OP_RETVAL;
-			return 0;
+	if (isdigit(arg[len])) {
+		ret = kstrtoul(arg + len, 10, &param);
+		if (ret)
+			return ret;
+
+		if ((ctx->flags & TPARG_FL_KERNEL) &&
+		    param > PARAM_MAX_STACK) {
+			*err = TP_ERR_BAD_STACK_NUM;
+			return -EINVAL;
 		}
+		code->op = FETCH_OP_STACK;
+		code->param = (unsigned int)param;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int parse_probe_var_current(char *orig_arg, char *arg,
+				   struct fetch_insn **pcode,
+				   struct fetch_insn *end,
+				   struct traceprobe_parse_context *ctx,
+				   int *err)
+{
+	struct fetch_insn *code = *pcode;
+
+	/* $current is only supported by kernel probe. */
+	if (!(ctx->flags & TPARG_FL_KERNEL)) {
+		*err = TP_ERR_BAD_VAR;
+		return -EINVAL;
+	}
+	arg += strlen("current");
+	if (*arg == '-' && IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS))
 		return parse_btf_arg(orig_arg, pcode, end, ctx);
+
+	if (*arg != '\0')
+		return -EINVAL;
+
+	code->op = FETCH_OP_CURRENT;
+	return 0;
+}
+
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+static int parse_probe_var_arg(char *arg, int len, struct fetch_insn *code,
+			       struct traceprobe_parse_context *ctx,
+			       int *err)
+{
+	unsigned long param;
+	int ret;
+
+	ret = kstrtoul(arg + len, 10, &param);
+	if (ret)
+		return ret;
+
+	if (!param || param > PARAM_MAX_STACK) {
+		*err = TP_ERR_BAD_ARG_NUM;
+		return -EINVAL;
 	}
+	param--; /* argN starts from 1, but internal arg[N] starts from 0 */
 
-	len = str_has_prefix(arg, "stack");
-	if (len) {
+	if (tparg_is_function_entry(ctx->flags)) {
+		code->op = FETCH_OP_ARG;
+		code->param = (unsigned int)param;
+		/*
+		 * The tracepoint probe will probe a stub function, and the
+		 * first parameter of the stub is a dummy and should be ignored.
+		 */
+		if (ctx->flags & TPARG_FL_TPOINT)
+			code->param++;
+	} else if (tparg_is_function_return(ctx->flags)) {
+		/* function entry argument access from return probe */
+		ret = __store_entry_arg(ctx->tp, param);
+		if (ret < 0)	/* This error should be an internal error */
+			return ret;
 
-		if (arg[len] == '\0') {
-			code->op = FETCH_OP_STACKP;
-			return 0;
-		}
+		code->op = FETCH_OP_EDATA;
+		code->offset = ret;
+	} else {
+		*err = TP_ERR_NOFENTRY_ARGS;
+		return -EINVAL;
+	}
+	return 0;
+}
+#else
+static int parse_probe_var_arg(char *arg, int len, struct fetch_insn *code,
+			       struct traceprobe_parse_context *ctx,
+			       int *err)
+{
+	*err = TP_ERR_BAD_VAR;
+	return -EINVAL;
+}
+#endif
 
-		if (isdigit(arg[len])) {
-			ret = kstrtoul(arg + len, 10, &param);
-			if (ret)
-				goto inval;
+/* Parse $vars. @orig_arg points '$', which syncs to @ctx->offset */
+static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
+			    struct fetch_insn **pcode,
+			    struct fetch_insn *end,
+			    struct traceprobe_parse_context *ctx)
+{
+	struct fetch_insn *code = *pcode;
+	char *arg = orig_arg + 1;
+	int err = TP_ERR_BAD_VAR;
+	int ret = -EINVAL;
+	int len;
 
-			if ((ctx->flags & TPARG_FL_KERNEL) &&
-			    param > PARAM_MAX_STACK) {
-				err = TP_ERR_BAD_STACK_NUM;
-				goto inval;
-			}
-			code->op = FETCH_OP_STACK;
-			code->param = (unsigned int)param;
+	if (ctx->flags & TPARG_FL_TEVENT) {
+		ret = parse_trace_event(arg, code, ctx);
+		if (!ret)
 			return 0;
-		}
-		goto inval;
 	}
 
 	if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
@@ -1387,65 +1467,39 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 		return 0;
 	}
 
-	/* $current returns the address of the current task_struct. */
-	if (str_has_prefix(arg, "current")) {
-		/* $current is only supported by kernel probe. */
-		if (!(ctx->flags & TPARG_FL_KERNEL)) {
-			err = TP_ERR_BAD_VAR;
-			goto inval;
-		}
-		arg += strlen("current");
-		if (*arg == '-' && IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS))
-			return parse_btf_arg(orig_arg, pcode, end, ctx);
-
-		if (*arg != '\0')
-			goto inval;
+	/* eprobe only support event fields or '$comm'. */
+	if (ctx->flags & TPARG_FL_TEVENT)
+		goto end;
 
-		code->op = FETCH_OP_CURRENT;
-		return 0;
+	if (str_has_prefix(arg, "retval")) {
+		ret = parse_probe_var_retval(orig_arg, arg, pcode, end, ctx, &err);
+		goto end;
 	}
 
-#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	len = str_has_prefix(arg, "arg");
+	len = str_has_prefix(arg, "stack");
 	if (len) {
-		ret = kstrtoul(arg + len, 10, &param);
-		if (ret)
-			goto inval;
-
-		if (!param || param > PARAM_MAX_STACK) {
-			err = TP_ERR_BAD_ARG_NUM;
-			goto inval;
-		}
-		param--; /* argN starts from 1, but internal arg[N] starts from 0 */
+		ret = parse_probe_var_stack(arg, len, code, ctx, &err);
+		goto end;
+	}
 
-		if (tparg_is_function_entry(ctx->flags)) {
-			code->op = FETCH_OP_ARG;
-			code->param = (unsigned int)param;
-			/*
-			 * The tracepoint probe will probe a stub function, and the
-			 * first parameter of the stub is a dummy and should be ignored.
-			 */
-			if (ctx->flags & TPARG_FL_TPOINT)
-				code->param++;
-		} else if (tparg_is_function_return(ctx->flags)) {
-			/* function entry argument access from return probe */
-			ret = __store_entry_arg(ctx->tp, param);
-			if (ret < 0)	/* This error should be an internal error */
-				return ret;
+	/* $current returns the address of the current task_struct. */
+	if (str_has_prefix(arg, "current")) {
+		ret = parse_probe_var_current(orig_arg, arg, pcode, end, ctx, &err);
+		goto end;
+	}
 
-			code->op = FETCH_OP_EDATA;
-			code->offset = ret;
-		} else {
-			err = TP_ERR_NOFENTRY_ARGS;
-			goto inval;
-		}
-		return 0;
+	len = str_has_prefix(arg, "arg");
+	if (len) {
+		ret = parse_probe_var_arg(arg, len, code, ctx, &err);
+		goto end;
 	}
-#endif
 
-inval:
-	__trace_probe_log_err(ctx->offset, err);
-	return -EINVAL;
+end:
+	if (ret < 0) {
+		__trace_probe_log_err(ctx->offset, err);
+		return ret;
+	}
+	return 0;
 }
 
 static int str_to_immediate(char *str, unsigned long *imm)

