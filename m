Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4C78F3A;
	Mon, 13 Jul 2026 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927684; cv=none; b=e090AcSh/+5w8ao4xM93k60tGfUpI0FuhWj8mxpjJ872WhNgugjWC2Dc18bSwb8j2TsH5/2rwe6jaFnoAE7aE6K3oYdn08qH1P0rbJj2Oy+JMHDMg/QrEwRgnvX3vqkACyW6jlhBU5qagS1JncHoVL91/h23R2/ao03cQrq/4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927684; c=relaxed/simple;
	bh=LE+AnQ24huGg63zUmwQarBgmLBHfJWh6PywE7q6APls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biJ6mrIdTjX3p6CqT5J3ZDk/hBK5W8BSRrpvAvCysKWs4l9W40dUk8XDoj75+FTQKB6ErZfPIk2b1swLLkZRW8IPZtZeTViyxxxmCx5EJYmMKCW5DHkNcJzWgpPVN1oozfJTMINC7p+uo6Dy6Q0+iBTJbA6u7LnF3uTVEV+jtd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdRAPihZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdRAPihZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2D91F000E9;
	Mon, 13 Jul 2026 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927683;
	bh=6/heml6maRPFbbnCNFYbo/qzvnxE/Beejn0YYEkdEd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdRAPihZy7uulKgR9twTj0ZOHqfEwubj/ku7c2/RgMkngvadBKXlgGHqGJtR3xjiO
	 nN7qL2hMPN973ay3A9CD/TXMckRRxtyiH7CavQA98n6VDAfHM1GSyfPk26RvgLwbtj
	 JWNQ7FxzCd/lXBkLVEu2YG3p8NFL3XrHKYSAw0itrc23R0mNHCL0gMFGlwnLeSxNQA
	 4L868BlVi/7SDHRFk1oeC4NWIh77x4QO/iAF4iTiUHrX3V2EcDBZHNp8NlTnXtLy3v
	 xgp3huFSCtOTMbh5199wVL2b9ltYEAj0aB97R5cvl9cpDUVLbuOjRWzTZScp7JixMp
	 FpaSxT+40rVmg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/5] tracing/probes: Refactor parse_probe_arg()
Date: Mon, 13 Jul 2026 16:27:58 +0900
Message-ID: <178392767869.3229912.15569496973769350593.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178392766002.3229912.15711868107734330750.stgit@devnote2>
References: <178392766002.3229912.15711868107734330750.stgit@devnote2>
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

Decompose parse_probe_arg() by extracting register, memory/symbol,
dereference, immediate, and default BTF/CPU parsing handlers into
dedicated static helper functions (parse_probe_arg_register,
parse_probe_arg_mem_symbol, parse_probe_arg_deref, parse_probe_arg_imm,
and parse_probe_arg_default). This modularizes the recursive argument
parser and improves readability.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |  300 ++++++++++++++++++++++++++------------------
 1 file changed, 174 insertions(+), 126 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8af97e29f096..eb9f7bd13c19 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1516,158 +1516,206 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
 	return 0;
 }
 
-/* Recursive argument parser */
-static int
-parse_probe_arg(char *arg, const struct fetch_type *type,
-		struct fetch_insn **pcode, struct fetch_insn *end,
-		struct traceprobe_parse_context *ctx)
+static int parse_probe_arg_register(char *arg, struct fetch_insn *code,
+				    struct traceprobe_parse_context *ctx)
+{
+	int ret;
+
+	if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
+		/* eprobe and fprobe do not handle registers */
+		trace_probe_log_err(ctx->offset, BAD_VAR);
+		return -EINVAL;
+	}
+	ret = regs_query_register_offset(arg + 1);
+	if (ret >= 0) {
+		code->op = FETCH_OP_REG;
+		code->param = (unsigned int)ret;
+		return 0;
+	}
+	trace_probe_log_err(ctx->offset, BAD_REG_NAME);
+	return -EINVAL;
+}
+
+static int parse_probe_arg_mem_symbol(char *arg, struct fetch_insn **pcode,
+				      struct fetch_insn *end,
+				      struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
+	long offset = 0;
+	int ret;
+
+	if (isdigit(arg[1])) {
+		ret = kstrtoul(arg + 1, 0, &param);
+		if (ret) {
+			trace_probe_log_err(ctx->offset, BAD_MEM_ADDR);
+			return ret;
+		}
+		/* load address */
+		code->op = FETCH_OP_IMM;
+		code->immediate = param;
+	} else if (arg[1] == '+') {
+		/* Kernel probes do not support file offsets */
+		if (ctx->flags & TPARG_FL_KERNEL) {
+			trace_probe_log_err(ctx->offset, FILE_ON_KPROBE);
+			return -EINVAL;
+		}
+		ret = kstrtol(arg + 2, 0, &offset);
+		if (ret) {
+			trace_probe_log_err(ctx->offset, BAD_FILE_OFFS);
+			return ret;
+		}
+
+		code->op = FETCH_OP_FOFFS;
+		code->immediate = (unsigned long)offset;
+		offset = 0;
+	} else {
+		/* uprobes don't support symbols */
+		if (!(ctx->flags & TPARG_FL_KERNEL)) {
+			trace_probe_log_err(ctx->offset, SYM_ON_UPROBE);
+			return -EINVAL;
+		}
+		/* Preserve symbol for updating */
+		code->op = FETCH_NOP_SYMBOL;
+		code->data = kstrdup(arg + 1, GFP_KERNEL);
+		if (!code->data)
+			return -ENOMEM;
+		if (++code == end) {
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+			return -EINVAL;
+		}
+		code->op = FETCH_OP_IMM;
+		code->immediate = 0;
+	}
+	/* These are fetching from memory */
+	if (++code == end) {
+		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+		return -EINVAL;
+	}
+	*pcode = code;
+	code->op = FETCH_OP_DEREF;
+	code->offset = offset;
+	return 0;
+}
+
+static int parse_probe_arg_deref(char *arg, struct fetch_insn **pcode,
+				 struct fetch_insn *end,
+				 struct traceprobe_parse_context *ctx)
+{
 	int deref = FETCH_OP_DEREF;
 	long offset = 0;
 	char *tmp;
-	int ret = 0;
+	int ret;
 
-	switch (arg[0]) {
-	case '$':
-		ret = parse_probe_vars(arg, type, pcode, end, ctx);
-		break;
+	if (arg[1] == 'u') {
+		deref = FETCH_OP_UDEREF;
+		arg[1] = arg[0];
+		arg++;
+	}
+	if (arg[0] == '+')
+		arg++;	/* Skip '+', because kstrtol() rejects it. */
+	tmp = strchr(arg, '(');
+	if (!tmp) {
+		trace_probe_log_err(ctx->offset, DEREF_NEED_BRACE);
+		return -EINVAL;
+	}
+	*tmp = '\0';
+	ret = kstrtol(arg, 0, &offset);
+	if (ret) {
+		trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
+		return ret;
+	}
+	ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
+	arg = tmp + 1;
+	return handle_dereference(arg, pcode, end, ctx, deref, offset);
+}
 
-	case '%':	/* named register */
-		if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
-			/* eprobe and fprobe do not handle registers */
-			trace_probe_log_err(ctx->offset, BAD_VAR);
-			break;
+static int parse_probe_arg_imm(char *arg, struct fetch_insn *code,
+			       struct traceprobe_parse_context *ctx)
+{
+	char *tmp;
+	int ret;
+
+	if (arg[1] == '"') {	/* Immediate string */
+		ret = __parse_imm_string(arg + 2, &tmp, ctx->offset + 2);
+		if (ret)
+			return ret;
+		code->op = FETCH_OP_IMMSTR;
+		code->data = tmp;
+	} else {
+		ret = str_to_immediate(arg + 1, &code->immediate);
+		if (ret) {
+			trace_probe_log_err(ctx->offset + 1, BAD_IMM);
+			return ret;
 		}
-		ret = regs_query_register_offset(arg + 1);
-		if (ret >= 0) {
-			code->op = FETCH_OP_REG;
-			code->param = (unsigned int)ret;
-			ret = 0;
-		} else
-			trace_probe_log_err(ctx->offset, BAD_REG_NAME);
-		break;
+		code->op = FETCH_OP_IMM;
+	}
+	return 0;
+}
 
-	case '@':	/* memory, file-offset or symbol */
-		if (isdigit(arg[1])) {
-			ret = kstrtoul(arg + 1, 0, &param);
-			if (ret) {
-				trace_probe_log_err(ctx->offset, BAD_MEM_ADDR);
-				break;
-			}
-			/* load address */
-			code->op = FETCH_OP_IMM;
-			code->immediate = param;
-		} else if (arg[1] == '+') {
-			/* Kernel probes do not support file offsets */
-			if (ctx->flags & TPARG_FL_KERNEL) {
-				trace_probe_log_err(ctx->offset, FILE_ON_KPROBE);
-				return -EINVAL;
-			}
-			ret = kstrtol(arg + 2, 0, &offset);
-			if (ret) {
-				trace_probe_log_err(ctx->offset, BAD_FILE_OFFS);
-				break;
-			}
+static int parse_probe_arg_default(char *arg, struct fetch_insn **pcode,
+				   struct fetch_insn *end,
+				   struct traceprobe_parse_context *ctx)
+{
+	int ret;
 
-			code->op = FETCH_OP_FOFFS;
-			code->immediate = (unsigned long)offset;  // imm64?
-			offset = 0;
-		} else {
-			/* uprobes don't support symbols */
-			if (!(ctx->flags & TPARG_FL_KERNEL)) {
-				trace_probe_log_err(ctx->offset, SYM_ON_UPROBE);
-				return -EINVAL;
-			}
-			/* Preserve symbol for updating */
-			code->op = FETCH_NOP_SYMBOL;
-			code->data = kstrdup(arg + 1, GFP_KERNEL);
-			if (!code->data)
-				return -ENOMEM;
-			if (++code == end) {
-				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+	if (str_has_prefix(arg, THIS_CPU_PTR_PREFIX) ||
+	    str_has_prefix(arg, THIS_CPU_READ_PREFIX)) {
+		return parse_this_cpu(arg, pcode, end, ctx);
+	}
+
+	if (isalpha(arg[0]) || arg[0] == '_') {
+		/* BTF variable or event field */
+		if (ctx->flags & TPARG_FL_TEVENT) {
+			ret = parse_trace_event(arg, *pcode, ctx);
+			if (ret < 0) {
+				trace_probe_log_err(ctx->offset, NO_EVENT_FIELD);
 				return -EINVAL;
 			}
-			code->op = FETCH_OP_IMM;
-			code->immediate = 0;
+			return 0;
 		}
-		/* These are fetching from memory */
-		if (++code == end) {
-			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+		if (!tparg_is_function_entry(ctx->flags) &&
+		    !tparg_is_function_return(ctx->flags)) {
+			trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 			return -EINVAL;
 		}
-		*pcode = code;
-		code->op = FETCH_OP_DEREF;
-		code->offset = offset;
-		break;
+		return parse_btf_arg(arg, pcode, end, ctx);
+	}
 
+	return 0;
+}
+
+/* Recursive argument parser */
+static int
+parse_probe_arg(char *arg, const struct fetch_type *type,
+		struct fetch_insn **pcode, struct fetch_insn *end,
+		struct traceprobe_parse_context *ctx)
+{
+	struct fetch_insn *code = *pcode;
+	int ret;
+
+	switch (arg[0]) {
+	case '$':
+		ret = parse_probe_vars(arg, type, pcode, end, ctx);
+		break;
+	case '%':	/* named register */
+		ret = parse_probe_arg_register(arg, code, ctx);
+		break;
+	case '@':	/* memory, file-offset or symbol */
+		ret = parse_probe_arg_mem_symbol(arg, pcode, end, ctx);
+		break;
 	case '+':	/* deref memory */
 	case '-':
-		if (arg[1] == 'u') {
-			deref = FETCH_OP_UDEREF;
-			arg[1] = arg[0];
-			arg++;
-		}
-		if (arg[0] == '+')
-			arg++;	/* Skip '+', because kstrtol() rejects it. */
-		tmp = strchr(arg, '(');
-		if (!tmp) {
-			trace_probe_log_err(ctx->offset, DEREF_NEED_BRACE);
-			return -EINVAL;
-		}
-		*tmp = '\0';
-		ret = kstrtol(arg, 0, &offset);
-		if (ret) {
-			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
-			break;
-		}
-		ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
-		arg = tmp + 1;
-		ret = handle_dereference(arg, pcode, end, ctx, deref, offset);
-		if (ret < 0)
-			return ret;
+		ret = parse_probe_arg_deref(arg, pcode, end, ctx);
 		break;
 	case '\\':	/* Immediate value */
-		if (arg[1] == '"') {	/* Immediate string */
-			ret = __parse_imm_string(arg + 2, &tmp, ctx->offset + 2);
-			if (ret)
-				break;
-			code->op = FETCH_OP_IMMSTR;
-			code->data = tmp;
-		} else {
-			ret = str_to_immediate(arg + 1, &code->immediate);
-			if (ret)
-				trace_probe_log_err(ctx->offset + 1, BAD_IMM);
-			else
-				code->op = FETCH_OP_IMM;
-		}
+		ret = parse_probe_arg_imm(arg, code, ctx);
 		break;
 	case '(':
 		ret = handle_typecast(arg, pcode, end, ctx);
 		break;
 	default:
-		if (str_has_prefix(arg, THIS_CPU_PTR_PREFIX) ||
-		    str_has_prefix(arg, THIS_CPU_READ_PREFIX)) {
-			ret = parse_this_cpu(arg, pcode, end, ctx);
-		} else if (isalpha(arg[0]) || arg[0] == '_') {
-			/* BTF variable or event field*/
-			if (ctx->flags & TPARG_FL_TEVENT) {
-				ret = parse_trace_event(arg, *pcode, ctx);
-				if (ret < 0) {
-					trace_probe_log_err(ctx->offset,
-							    NO_EVENT_FIELD);
-					return -EINVAL;
-				}
-				break;
-			}
-			if (!tparg_is_function_entry(ctx->flags) &&
-			    !tparg_is_function_return(ctx->flags)) {
-				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
-				return -EINVAL;
-			}
-			ret = parse_btf_arg(arg, pcode, end, ctx);
-		}
+		ret = parse_probe_arg_default(arg, pcode, end, ctx);
 		break;
 	}
 	if (!ret && code->op == FETCH_OP_NOP) {

