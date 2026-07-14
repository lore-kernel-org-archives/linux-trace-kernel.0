Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C199357D09;
	Tue, 14 Jul 2026 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991381; cv=none; b=dXPDLtj3lduTg+5HYrS0a0vTJrjAi+CgkYvyHc2ggw0h2NOqlbNa2EG3RyjrANWPWnDvvVud1udaEqlCHk+/Wc+5mcy4bzVqVeK8lssm6qkelOeSO1imucfXg+t1THSsW96xDVsjfiVM8oXsB/XTmRoXRaYrqvFLPxXJ70vSEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991381; c=relaxed/simple;
	bh=aAWxbpBiZPGebHF9stH6l/gs8j+Os4yg4PXoWGQhY58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWgPVu9QeESOsHI8KvyvJPKhocV5POgcLoHcvg04kec39q3yJs4iCR8O7Jq4qdbxOU1KZTOG/qiQ5I7ns1n31XnAL+bFqdyp/Bac8iP38+1XbVC9ye/Qc9FMQwK718+m/FJ3Fhdadzoo75EM6plHUg62Df16sg4zGQWnzhGxWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5ZyEBNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5ZyEBNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A061F000E9;
	Tue, 14 Jul 2026 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991380;
	bh=+OT/874fdAI7aXO7+JscTbts10vAI7o7zqy5+UWPWEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B5ZyEBNbYUoBhd+S9byIpFztrUD79Ilvo1gu99f5q8HIPmTzR7ytXH1w4HCjIQMMV
	 K8ThaX4b47rikaVdan2ohWut+uik1e9B56BJciVFRvhD+AcLMT0Y56THmwGV5u/YOj
	 DhL4Pdk8oKNEZ6IuEaIYH3qAoZ1jgqsT3C/VOwmoD5e5NsCXwjBhsBPBxclKPBN+CP
	 WNESX7/Wns9txdw0qS6h/aoi8yV69XFbuBTGDsZmez+m84sRcLM8cRPvQsWyY/VJaz
	 OLdHBOD+z71xokUTFa85dFOvYZ6nlpYtNNzkVaMGSHr0/VhTi/HpJcN6+U+a4pmzTh
	 wKY4c7+df8jqQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/5] tracing/probes: Refactor parse_probe_vars()
Date: Tue, 14 Jul 2026 10:09:36 +0900
Message-ID: <178399137612.27810.14869178899276413372.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178399136606.27810.4469135881050354189.stgit@devnote2>
References: <178399136606.27810.4469135881050354189.stgit@devnote2>
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
Changes in v2:
 - Fix double error logging by removing err code passing, but just
   record errors inside subfunctions.
 - Simplify parse_probe_vars().
---
 kernel/trace/trace_probe.c |  237 ++++++++++++++++++++++++++------------------
 1 file changed, 140 insertions(+), 97 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 18c212122344..8af97e29f096 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1319,132 +1319,175 @@ NOKPROBE_SYMBOL(store_trace_entry_data)
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
-/* Parse $vars. @orig_arg points '$', which syncs to @ctx->offset */
-static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
-			    struct fetch_insn **pcode,
-			    struct fetch_insn *end,
-			    struct traceprobe_parse_context *ctx)
+static int parse_probe_var_retval(char *orig_arg, char *arg,
+				  struct fetch_insn **pcode,
+				  struct fetch_insn *end,
+				  struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code = *pcode;
-	int err = TP_ERR_BAD_VAR;
-	char *arg = orig_arg + 1;
+
+	if (!(ctx->flags & TPARG_FL_RETURN)) {
+		trace_probe_log_err(ctx->offset, RETVAL_ON_PROBE);
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
+				 struct traceprobe_parse_context *ctx)
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
+	if (isdigit(arg[len])) {
+		ret = kstrtoul(arg + len, 10, &param);
+		if (ret) {
+			trace_probe_log_err(ctx->offset, BAD_VAR);
+			return ret;
 		}
-		if (!(ctx->flags & TPARG_FL_KERNEL) ||
-		    !IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS)) {
-			code->op = FETCH_OP_RETVAL;
-			return 0;
+
+		if ((ctx->flags & TPARG_FL_KERNEL) &&
+		    param > PARAM_MAX_STACK) {
+			trace_probe_log_err(ctx->offset, BAD_STACK_NUM);
+			return -EINVAL;
 		}
+		code->op = FETCH_OP_STACK;
+		code->param = (unsigned int)param;
+		return 0;
+	}
+
+	trace_probe_log_err(ctx->offset, BAD_VAR);
+	return -EINVAL;
+}
+
+static int parse_probe_var_current(char *orig_arg, char *arg,
+				   struct fetch_insn **pcode,
+				   struct fetch_insn *end,
+				   struct traceprobe_parse_context *ctx)
+{
+	struct fetch_insn *code = *pcode;
+
+	/* $current is only supported by kernel probe. */
+	if (!(ctx->flags & TPARG_FL_KERNEL)) {
+		trace_probe_log_err(ctx->offset, BAD_VAR);
+		return -EINVAL;
+	}
+	arg += strlen("current");
+	if (*arg == '-' && IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS))
 		return parse_btf_arg(orig_arg, pcode, end, ctx);
+
+	if (*arg != '\0') {
+		trace_probe_log_err(ctx->offset, BAD_VAR);
+		return -EINVAL;
 	}
 
-	len = str_has_prefix(arg, "stack");
-	if (len) {
+	code->op = FETCH_OP_CURRENT;
+	return 0;
+}
 
-		if (arg[len] == '\0') {
-			code->op = FETCH_OP_STACKP;
-			return 0;
-		}
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+static int parse_probe_var_arg(char *arg, int len, struct fetch_insn *code,
+			       struct traceprobe_parse_context *ctx)
+{
+	unsigned long param;
+	int ret;
 
-		if (isdigit(arg[len])) {
-			ret = kstrtoul(arg + len, 10, &param);
-			if (ret)
-				goto inval;
+	ret = kstrtoul(arg + len, 10, &param);
+	if (ret) {
+		trace_probe_log_err(ctx->offset, BAD_VAR);
+		return ret;
+	}
 
-			if ((ctx->flags & TPARG_FL_KERNEL) &&
-			    param > PARAM_MAX_STACK) {
-				err = TP_ERR_BAD_STACK_NUM;
-				goto inval;
-			}
-			code->op = FETCH_OP_STACK;
-			code->param = (unsigned int)param;
-			return 0;
-		}
-		goto inval;
+	if (!param || param > PARAM_MAX_STACK) {
+		trace_probe_log_err(ctx->offset, BAD_ARG_NUM);
+		return -EINVAL;
 	}
+	param--; /* argN starts from 1, but internal arg[N] starts from 0 */
 
-	if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
-		code->op = FETCH_OP_COMM;
-		return 0;
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
+
+		code->op = FETCH_OP_EDATA;
+		code->offset = ret;
+	} else {
+		trace_probe_log_err(ctx->offset, NOFENTRY_ARGS);
+		return -EINVAL;
 	}
+	return 0;
+}
+#else
+static int parse_probe_var_arg(char *arg, int len, struct fetch_insn *code,
+			       struct traceprobe_parse_context *ctx)
+{
+	trace_probe_log_err(ctx->offset, BAD_VAR);
+	return -EINVAL;
+}
+#endif
 
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
+/* Parse $vars. @orig_arg points '$', which syncs to @ctx->offset */
+static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
+			    struct fetch_insn **pcode,
+			    struct fetch_insn *end,
+			    struct traceprobe_parse_context *ctx)
+{
+	struct fetch_insn *code = *pcode;
+	char *arg = orig_arg + 1;
+	int len, ret;
 
-		if (*arg != '\0')
-			goto inval;
+	if (ctx->flags & TPARG_FL_TEVENT) {
+		ret = parse_trace_event(arg, code, ctx);
+		if (!ret)
+			return 0;
+	}
 
-		code->op = FETCH_OP_CURRENT;
+	if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
+		code->op = FETCH_OP_COMM;
 		return 0;
 	}
 
-#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	len = str_has_prefix(arg, "arg");
-	if (len) {
-		ret = kstrtoul(arg + len, 10, &param);
-		if (ret)
-			goto inval;
+	/* eprobe only support event fields or '$comm'. */
+	if (ctx->flags & TPARG_FL_TEVENT)
+		goto inval;
 
-		if (!param || param > PARAM_MAX_STACK) {
-			err = TP_ERR_BAD_ARG_NUM;
-			goto inval;
-		}
-		param--; /* argN starts from 1, but internal arg[N] starts from 0 */
+	if (str_has_prefix(arg, "retval"))
+		return parse_probe_var_retval(orig_arg, arg, pcode, end, ctx);
 
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
+	len = str_has_prefix(arg, "stack");
+	if (len)
+		return parse_probe_var_stack(arg, len, code, ctx);
 
-			code->op = FETCH_OP_EDATA;
-			code->offset = ret;
-		} else {
-			err = TP_ERR_NOFENTRY_ARGS;
-			goto inval;
-		}
-		return 0;
-	}
-#endif
+	/* $current returns the address of the current task_struct. */
+	if (str_has_prefix(arg, "current"))
+		return parse_probe_var_current(orig_arg, arg, pcode, end, ctx);
+
+	len = str_has_prefix(arg, "arg");
+	if (len)
+		return parse_probe_var_arg(arg, len, code, ctx);
 
 inval:
-	__trace_probe_log_err(ctx->offset, err);
+	trace_probe_log_err(ctx->offset, BAD_VAR);
 	return -EINVAL;
 }
 

