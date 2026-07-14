Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9E2DB7B4;
	Tue, 14 Jul 2026 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991420; cv=none; b=aa0EIdeKhXotVzEp5nJQqdXVOCWkVdkiXqmXWOvEEnjUg7QaGEJoi98Dwk5Q1ym06IBbM4igNfHxcgmG7mrfIh7MukbFJdPF5kFzGmqrGgRezE35WjeoxI2wCNqa/B2PywOU4H2M/5wn5ex1gzdbPbxH03niCn4bib0GIdYjJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991420; c=relaxed/simple;
	bh=wNTvoZPoUdeBjlctW2RTUpGTBoi43EhWg0rcMQLHAEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwH/zmcSJJdRO5DzEXKgEYlpxhkUJkMimTJiie47InH0FHCUIutVf4m2r1q/msB6kurrwcI6/Tu0Vo62cyXZre8KxKSTNY5gK215X8X0zY0JYGGG62e1m14nuIF19aNpWzJyVCeJ/7cH1CHt/BSfH5VvMza+AmeOgFUaRP7g10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRiASUa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRiASUa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4543E1F000E9;
	Tue, 14 Jul 2026 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991418;
	bh=CH3ukZ3w4BfiYtFaN3CWSY6yKJ+CGwf9AtYqT/D1o6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QRiASUa1chUBUHsVyuJe1VH6rrFE4pDZbTez2M7BLHKsFKY3EcouRbyJ/MVHd2Rlj
	 2hAlm0CuzAlJQZvlWfvwEXLwCjOKroB+13iCweZlcl01N8DZsdLYk3pcUsCgHnuD6J
	 HyBBXSpLQsCTJqpi4mnot+QpH0aXF1NWPGQATM6c13fBSjIBkql9YTfCaIf87idz77
	 nJdMoCU5RbzIa41Hgq0w1Ox/O6y8TRKa9q8rxrZwdb3SrLIEUY+DbVRzNLXmP+5T1T
	 BAoQ92shgmh2NEFruAN+tyM2bTAbzppngkQFQ45uWHicZF+063wt+BfIPC4sE//0rs
	 V6JaGmsAz1kXQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/5] tracing/probes: Eliminate recursion in parse_probe_arg()
Date: Tue, 14 Jul 2026 10:10:14 +0900
Message-ID: <178399141396.27810.5390060618628718661.stgit@devnote2>
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

To avoid potential stack overflows on limited kernel stacks, convert
parse_probe_arg() from a recursive function into a loop-based
implementation with a simple local state stack.

Since recursion is eliminated using a loop with a fixed-size
stack in the context, this restricts the dereference nesting
depth. The maximum nesting depth of dereferences is now restricted
to the same limit as typecasts (TRACEPROBE_MAX_NESTED_LEVEL, which
is 8) and reports the same TOO_MANY_NESTED error. Update ftrace
selftests to reflect this restriction and simplify the checks.

Note that this change slightly alters the behavior of nested
dereferencing in fetcharg. Previously, dereferencing without BTF
allowed for up to 14 levels of nesting, whereas dereferencing
with BTF was limited to 3 levels. With this change, the nesting
depth is now limited to 8 levels in both cases.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
 - Removed unused is_ptr.
 - Add trace_probe_log_err() to the error case in parse_this_cpu().
 Changes in v2:
 - Clearly state that both derefernce nest and typecast nest are
   limited by the same TRACEPROBE_MAX_NESTED_LEVEL.
 - Extend TRACEPROBE_MAX_NESTED_LEVEL to 8.
 - Fix testcase to check TOO_MANY_NESTED instead of TOO_MANY_OPS
   (that should not be hit anymore)
---
 kernel/trace/trace_probe.c                         |  338 ++++++++++++--------
 kernel/trace/trace_probe.h                         |   33 ++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |    2 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    4 
 5 files changed, 242 insertions(+), 139 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index eb9f7bd13c19..7568f5e68de7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -356,61 +356,10 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		struct fetch_insn **pcode, struct fetch_insn *end,
 		struct traceprobe_parse_context *ctx);
 
-/* handle dereference nested call */
-static inline int handle_dereference(char *arg, struct fetch_insn **pcode,
-	struct fetch_insn *end, struct traceprobe_parse_context *ctx,
-	int deref, long offset)
+static int parse_this_cpu(char *arg, struct traceprobe_parse_context *ctx)
 {
-	const struct fetch_type *type = find_fetch_type(NULL, ctx->flags);
-	struct fetch_insn *code = *pcode;
-	int cur_offs = ctx->offset;
+	bool is_read = false;
 	char *tmp;
-	int ret;
-
-	tmp = strrchr(arg, ')');
-	if (!tmp) {
-		trace_probe_log_err(ctx->offset + strlen(arg),
-					DEREF_OPEN_BRACE);
-		return -EINVAL;
-	}
-
-	*tmp = '\0';
-	ret = parse_probe_arg(arg, type, &code, end, ctx);
-	if (ret)
-		return ret;
-	ctx->offset = cur_offs;
-	if (code->op == FETCH_OP_COMM || code->op == FETCH_OP_IMMSTR) {
-		trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
-		return -EINVAL;
-	}
-
-	/*
-	 * this_cpu_ptr(@SYM) does not use SYM value, but use SYM address.
-	 * So we overwrite the last FETCH_OP_DEREF with FETCH_OP_CPU_PTR.
-	 */
-	if (!(deref == FETCH_OP_CPU_PTR && *arg == '@')) {
-		code++;
-		if (code == end) {
-			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
-			return -EINVAL;
-		}
-	}
-	*pcode = code;
-
-	code->op = deref;
-	code->offset = offset;
-	/* Reset the last type if used */
-	ctx->last_type = NULL;
-	return 0;
-}
-
-static int parse_this_cpu(char *arg, struct fetch_insn **pcode,
-			  struct fetch_insn *end,
-			  struct traceprobe_parse_context *ctx)
-{
-	struct fetch_insn *code;
-	bool is_ptr = false;
-	int ret;
 
 	/*
 	 * This is only for kernel probes, excluding eprobe, because per-cpu
@@ -424,27 +373,29 @@ static int parse_this_cpu(char *arg, struct fetch_insn **pcode,
 	if (str_has_prefix(arg, THIS_CPU_PTR_PREFIX)) {
 		arg += THIS_CPU_PTR_LEN;
 		ctx->offset += THIS_CPU_PTR_LEN;
-		is_ptr = true;
 	} else if (str_has_prefix(arg, THIS_CPU_READ_PREFIX)) {
 		arg += THIS_CPU_READ_LEN;
 		ctx->offset += THIS_CPU_READ_LEN;
-	} else
+		is_read = true;
+	} else {
+		trace_probe_log_err(ctx->offset, BAD_FETCH_ARG);
 		return -EINVAL;
+	}
 
-	ret = handle_dereference(arg, pcode, end, ctx, FETCH_OP_CPU_PTR, 0);
-	if (ret || is_ptr)
-		return ret;
-
-	/* this_cpu_read(VAR) -> +0(this_cpu_ptr(VAR)) */
-	code = *pcode;
-	code++;
-	if (code == end) {
-		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+	tmp = strrchr(arg, ')');
+	if (!tmp) {
+		trace_probe_log_err(ctx->offset + strlen(arg),
+					DEREF_OPEN_BRACE);
 		return -EINVAL;
 	}
-	code->op = FETCH_OP_DEREF;
-	code->offset = 0;
-	*pcode = code;
+	*tmp = '\0';
+
+	ctx->stack[ctx->depth].type = STATE_DEREF;
+	ctx->stack[ctx->depth].deref.deref = FETCH_OP_CPU_PTR;
+	ctx->stack[ctx->depth].deref.offset = 0;
+	ctx->stack[ctx->depth].deref.cur_offs = ctx->offset;
+	ctx->stack[ctx->depth].deref.inner_arg = arg;
+	ctx->stack[ctx->depth].deref.is_cpu_read = is_read;
 	return 0;
 }
 
@@ -1007,14 +958,12 @@ static char *find_matched_close_paren(char *s)
 	return NULL;
 }
 
-static int handle_typecast(char *arg, struct fetch_insn **pcode,
-			   struct fetch_insn *end,
-			   struct traceprobe_parse_context *ctx)
+static int handle_typecast(char *arg, struct traceprobe_parse_context *ctx)
 {
 	int orig_offset = ctx->offset;
 	char *close;
 	char *tmp;
-	int ret;
+	char *fieldname;
 
 	if (!(tparg_is_event_probe(ctx->flags) ||
 	      tparg_is_function_entry(ctx->flags) ||
@@ -1028,12 +977,6 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 	 * For example: (STRUCT)VAR->FIELD and (STRUCT)(VAR)->FIELD are same.
 	 * VAR is solved in the nested call.
 	 */
-	ctx->nested_level++;
-	if (ctx->nested_level > TRACEPROBE_MAX_NESTED_LEVEL) {
-		trace_probe_log_err(ctx->offset, TOO_MANY_NESTED);
-		return -E2BIG;
-	}
-
 	tmp = strchr(arg, ')');
 	if (!tmp) {
 		trace_probe_log_err(ctx->offset + strlen(arg),
@@ -1103,30 +1046,19 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 	}
 	*close = '\0';
 
-	/* We need to parse the nested one */
-	ret = parse_probe_arg(tmp, find_fetch_type(NULL, ctx->flags),
-			      pcode, end, ctx);
-	if (ret < 0)
-		return ret;
-	ctx->nested_level--;
-	clear_struct_btf(ctx);
-
-	/* Let tmp point the field name. */
+	/* Let fieldname point the field name. */
 	if (close[1] == '-')
-		tmp = close + 3; /* Skip "->" after closing parenthesis */
+		fieldname = close + 3; /* Skip "->" after closing parenthesis */
 	else
-		tmp = close + 2; /* Skip ">" after inner variable name */
-
-	/* resolve the typecast struct name */
-	ctx->offset = orig_offset + 1; /* for the '(' */
-	ret = parse_btf_casttype(arg + 1, ctx);
-	if (ret < 0)
-		return ret;
-
-	ctx->offset = orig_offset + tmp - arg;
-	ret = parse_btf_field(tmp, ctx->last_struct, pcode, end, ctx);
-	ctx->prefix_byteoffs = 0;
-	return ret;
+		fieldname = close + 2; /* Skip ">" after inner variable name */
+
+	ctx->stack[ctx->depth].type = STATE_TYPECAST;
+	ctx->stack[ctx->depth].typecast.casttype = arg + 1;
+	ctx->stack[ctx->depth].typecast.fieldname = fieldname;
+	ctx->stack[ctx->depth].typecast.orig_offset = orig_offset;
+	ctx->stack[ctx->depth].typecast.field_offset_diff = fieldname - arg;
+	ctx->stack[ctx->depth].typecast.inner_arg = tmp;
+	return 0;
 }
 
 #else /* !CONFIG_PROBE_EVENTS_BTF_ARGS */
@@ -1171,9 +1103,20 @@ static int check_prepare_btf_string_fetch(char *typename,
 	return 0;
 }
 
-static int handle_typecast(char *arg, struct fetch_insn **pcode,
-			   struct fetch_insn *end,
+static int parse_btf_casttype(char *casttype,
+			      struct traceprobe_parse_context *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+static int parse_btf_field(char *fieldname, const struct btf_type *type,
+			   struct fetch_insn **pcode, struct fetch_insn *end,
 			   struct traceprobe_parse_context *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+static int handle_typecast(char *arg, struct traceprobe_parse_context *ctx)
 {
 	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 	return -EOPNOTSUPP;
@@ -1598,9 +1541,7 @@ static int parse_probe_arg_mem_symbol(char *arg, struct fetch_insn **pcode,
 	return 0;
 }
 
-static int parse_probe_arg_deref(char *arg, struct fetch_insn **pcode,
-				 struct fetch_insn *end,
-				 struct traceprobe_parse_context *ctx)
+static int parse_probe_arg_deref(char *arg, struct traceprobe_parse_context *ctx)
 {
 	int deref = FETCH_OP_DEREF;
 	long offset = 0;
@@ -1627,7 +1568,22 @@ static int parse_probe_arg_deref(char *arg, struct fetch_insn **pcode,
 	}
 	ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
 	arg = tmp + 1;
-	return handle_dereference(arg, pcode, end, ctx, deref, offset);
+
+	tmp = strrchr(arg, ')');
+	if (!tmp) {
+		trace_probe_log_err(ctx->offset + strlen(arg),
+					DEREF_OPEN_BRACE);
+		return -EINVAL;
+	}
+	*tmp = '\0';
+
+	ctx->stack[ctx->depth].type = STATE_DEREF;
+	ctx->stack[ctx->depth].deref.deref = deref;
+	ctx->stack[ctx->depth].deref.offset = offset;
+	ctx->stack[ctx->depth].deref.cur_offs = ctx->offset;
+	ctx->stack[ctx->depth].deref.inner_arg = arg;
+	ctx->stack[ctx->depth].deref.is_cpu_read = false;
+	return 0;
 }
 
 static int parse_probe_arg_imm(char *arg, struct fetch_insn *code,
@@ -1659,11 +1615,6 @@ static int parse_probe_arg_default(char *arg, struct fetch_insn **pcode,
 {
 	int ret;
 
-	if (str_has_prefix(arg, THIS_CPU_PTR_PREFIX) ||
-	    str_has_prefix(arg, THIS_CPU_READ_PREFIX)) {
-		return parse_this_cpu(arg, pcode, end, ctx);
-	}
-
 	if (isalpha(arg[0]) || arg[0] == '_') {
 		/* BTF variable or event field */
 		if (ctx->flags & TPARG_FL_TEVENT) {
@@ -1685,11 +1636,56 @@ static int parse_probe_arg_default(char *arg, struct fetch_insn **pcode,
 	return 0;
 }
 
-/* Recursive argument parser */
-static int
-parse_probe_arg(char *arg, const struct fetch_type *type,
-		struct fetch_insn **pcode, struct fetch_insn *end,
-		struct traceprobe_parse_context *ctx)
+static int parse_probe_arg_nested(char **parg, struct traceprobe_parse_context *ctx)
+{
+	char *arg = *parg;
+	int ret;
+
+	while (true) {
+		/* Determine if this is a nested argument */
+		if (arg[0] != '+' && arg[0] != '-' && arg[0] != '(' &&
+		    !str_has_prefix(arg, THIS_CPU_PTR_PREFIX) &&
+		    !str_has_prefix(arg, THIS_CPU_READ_PREFIX))
+			break;
+
+		/* If nested, check the maximum depth limit */
+		if (ctx->depth >= TRACEPROBE_MAX_NESTED_LEVEL) {
+			trace_probe_log_err(ctx->offset, TOO_MANY_NESTED);
+			return -E2BIG;
+		}
+
+		/* Perform the actual parsing subroutine calls */
+		switch (arg[0]) {
+		case '+':
+		case '-':
+			ret = parse_probe_arg_deref(arg, ctx);
+			if (ret)
+				return ret;
+			arg = ctx->stack[ctx->depth].deref.inner_arg;
+			break;
+		case '(':
+			ret = handle_typecast(arg, ctx);
+			if (ret)
+				return ret;
+			arg = ctx->stack[ctx->depth].typecast.inner_arg;
+			break;
+		default:
+			ret = parse_this_cpu(arg, ctx);
+			if (ret)
+				return ret;
+			arg = ctx->stack[ctx->depth].deref.inner_arg;
+			break;
+		}
+		ctx->depth++;
+	}
+
+	*parg = arg;
+	return 0;
+}
+
+static int parse_probe_arg_leaf(char *arg, const struct fetch_type *type,
+				struct fetch_insn **pcode, struct fetch_insn *end,
+				struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code = *pcode;
 	int ret;
@@ -1704,26 +1700,112 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 	case '@':	/* memory, file-offset or symbol */
 		ret = parse_probe_arg_mem_symbol(arg, pcode, end, ctx);
 		break;
-	case '+':	/* deref memory */
-	case '-':
-		ret = parse_probe_arg_deref(arg, pcode, end, ctx);
-		break;
 	case '\\':	/* Immediate value */
 		ret = parse_probe_arg_imm(arg, code, ctx);
 		break;
-	case '(':
-		ret = handle_typecast(arg, pcode, end, ctx);
-		break;
 	default:
 		ret = parse_probe_arg_default(arg, pcode, end, ctx);
 		break;
 	}
-	if (!ret && code->op == FETCH_OP_NOP) {
+
+	if (ret)
+		return ret;
+
+	if (code->op == FETCH_OP_NOP) {
 		/* Parsed, but do not find fetch method */
 		trace_probe_log_err(ctx->offset, BAD_FETCH_ARG);
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-	return ret;
+
+	return 0;
+}
+
+static int unwind_parse_states(struct fetch_insn **pcode, struct fetch_insn *end,
+			       struct traceprobe_parse_context *ctx)
+{
+	struct parse_state *state;
+	struct fetch_insn *code;
+	int ret;
+
+	while (ctx->depth > 0) {
+		ctx->depth--;
+		state = &ctx->stack[ctx->depth];
+
+		if (state->type == STATE_DEREF) {
+			code = *pcode;
+			ctx->offset = state->deref.cur_offs;
+			if (code->op == FETCH_OP_COMM || code->op == FETCH_OP_IMMSTR) {
+				trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
+				return -EINVAL;
+			}
+
+			if (!(state->deref.deref == FETCH_OP_CPU_PTR &&
+			      *state->deref.inner_arg == '@')) {
+				code++;
+				if (code == end) {
+					trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+					return -EINVAL;
+				}
+			}
+			*pcode = code;
+
+			code->op = state->deref.deref;
+			code->offset = state->deref.offset;
+			ctx->last_type = NULL;
+
+			if (state->deref.is_cpu_read) {
+				code = *pcode;
+				code++;
+				if (code == end) {
+					trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+					return -EINVAL;
+				}
+				code->op = FETCH_OP_DEREF;
+				code->offset = 0;
+				*pcode = code;
+			}
+		} else if (state->type == STATE_TYPECAST) {
+			clear_struct_btf(ctx);
+
+			/* resolve the typecast struct name */
+			ctx->offset = state->typecast.orig_offset + 1; /* for the '(' */
+			ret = parse_btf_casttype(state->typecast.casttype, ctx);
+			if (ret < 0)
+				return ret;
+
+			ctx->offset = state->typecast.orig_offset +
+				      state->typecast.field_offset_diff;
+			ret = parse_btf_field(state->typecast.fieldname,
+					      ctx->last_struct, pcode,
+					      end, ctx);
+			ctx->prefix_byteoffs = 0;
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* Loop-based (non-recursive) argument parser */
+static int
+parse_probe_arg(char *arg, const struct fetch_type *type,
+		struct fetch_insn **pcode, struct fetch_insn *end,
+		struct traceprobe_parse_context *ctx)
+{
+	int ret;
+
+	ctx->depth = 0;
+
+	ret = parse_probe_arg_nested(&arg, ctx);
+	if (ret)
+		return ret;
+
+	ret = parse_probe_arg_leaf(arg, type, pcode, end, ctx);
+	if (ret)
+		return ret;
+
+	return unwind_parse_states(pcode, end, ctx);
 }
 
 /* Bitfield type needs to be parsed into a fetch function */
@@ -1984,12 +2066,6 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			      ctx);
 	if (ret < 0)
 		goto fail;
-	/* nested_level must be 0 here, otherwise there is a bug. */
-	if (WARN_ON_ONCE(ctx->nested_level)) {
-		ret = -EINVAL;
-		goto fail;
-	}
-
 	/* Update storing type if BTF is available */
 	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
 	    ctx->last_type) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index e6d427910c4f..ebdc706e7cb6 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -437,6 +437,34 @@ static inline bool tparg_is_event_probe(unsigned int flags)
 	return !!(flags & TPARG_FL_TEVENT);
 }
 
+/* Each typecast consumes nested level. So the max number of typecast is 8. */
+#define TRACEPROBE_MAX_NESTED_LEVEL 8
+
+enum parse_state_type {
+	STATE_DEREF,
+	STATE_TYPECAST,
+};
+
+struct parse_state {
+	int type;
+	union {
+		struct {
+			int deref;
+			long offset;
+			int cur_offs;
+			char *inner_arg;
+			bool is_cpu_read;
+		} deref;
+		struct {
+			char *casttype;
+			char *fieldname;
+			int orig_offset;
+			int field_offset_diff;
+			char *inner_arg;
+		} typecast;
+	};
+};
+
 struct traceprobe_parse_context {
 	struct trace_event_call *event;
 	/* BTF related parameters */
@@ -453,12 +481,11 @@ struct traceprobe_parse_context {
 	struct trace_probe *tp;
 	unsigned int flags;
 	int offset;
-	int nested_level;
 	int prefix_byteoffs;	/* The byte offset of the prefix field of typecast */
+	struct parse_state stack[TRACEPROBE_MAX_NESTED_LEVEL + 1];
+	int depth;
 };
 
-/* Each typecast consumes nested level. So the max number of typecast is 3. */
-#define TRACEPROBE_MAX_NESTED_LEVEL 3
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				      const char *argv,
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 984ab94df213..384209968325 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -60,7 +60,7 @@ check_error 'f vfs_read ^&1'		# BAD_FETCH_ARG
 
 # We've introduced this limitation with array support
 if grep -q ' <type>\\\[<array-size>\\\]' README; then
-check_error 'f vfs_read +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 'f vfs_read +0(+0(+0(+0(+0(+0(+0(+0(^+0(@0)))))))))'	# TOO_MANY_NESTED
 check_error 'f vfs_read +0(@11):u8[10^'		# ARRAY_NO_CLOSE
 check_error 'f vfs_read +0(@11):u8[10]^a'	# BAD_ARRAY_SUFFIX
 check_error 'f vfs_read +0(@11):u8[^10a]'	# BAD_ARRAY_NUM
@@ -114,7 +114,7 @@ check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
 check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
 if grep -qF "[(structname" README ; then
 check_error 'f vfs_read arg1=(task_struct)file^'		# TYPECAST_REQ_FIELD
-check_error 'f vfs_read arg1=(a)((b)((c)(^(d)file->d)->c)->b)->a'	# TOO_MANY_NESTED
+check_error 'f vfs_read arg1=(a)((b)((c)((d)((e)((f)((g)((h)(^(i)file->i)->h)->g)->f)->e)->d)->c)->b)->a'	# TOO_MANY_NESTED
 check_error 'f vfs_read arg1=(task_struct,^in_execve)file->comm'	# TYPECAST_NOT_ALIGNED
 check_error 'f vfs_read arg1=(task_struct,^foo_bar)file->pid'	# NO_BTF_FIELD
 check_error 'f vfs_read arg1=(^task_struct1234)file->pid'	# NO_PTR_STRCT
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
index 2d0905b2c8b7..72b8652df9ba 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
@@ -46,7 +46,7 @@ check_error 't kfree ^&1'		# BAD_FETCH_ARG
 
 # We've introduced this limitation with array support
 if grep -q ' <type>\\\[<array-size>\\\]' README; then
-check_error 't kfree +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 't kfree +0(+0(+0(+0(+0(+0(+0(+0(^+0(@0)))))))))'	# TOO_MANY_NESTED
 check_error 't kfree +0(@11):u8[10^'		# ARRAY_NO_CLOSE
 check_error 't kfree +0(@11):u8[10]^a'		# BAD_ARRAY_SUFFIX
 check_error 't kfree +0(@11):u8[^10a]'		# BAD_ARRAY_NUM
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index d28f63b7e8a9..b0e6b80ccb01 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -56,7 +56,7 @@ check_error 'p vfs_read ^&1'		# BAD_FETCH_ARG
 
 # We've introduced this limitation with array support
 if grep -q ' <type>\\\[<array-size>\\\]' README; then
-check_error 'p vfs_read +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 'p vfs_read +0(+0(+0(+0(+0(+0(+0(+0(^+0(@0)))))))))'	# TOO_MANY_NESTED
 check_error 'p vfs_read +0(@11):u8[10^'		# ARRAY_NO_CLOSE
 check_error 'p vfs_read +0(@11):u8[10]^a'	# BAD_ARRAY_SUFFIX
 check_error 'p vfs_read +0(@11):u8[^10a]'	# BAD_ARRAY_NUM
@@ -117,7 +117,7 @@ check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'r kfree ^$retval'			# NO_RETVAL
 if grep -qF "[(structname" README ; then
 check_error 'p vfs_read arg1=(task_struct)file^'		# TYPECAST_REQ_FIELD
-check_error 'p vfs_read arg1=(a)((b)((c)(^(d)file->d)->c)->b)->a'	# TOO_MANY_NESTED
+check_error 'p vfs_read arg1=(a)((b)((c)((d)((e)((f)((g)((h)(^(i)file->i)->h)->g)->f)->e)->d)->c)->b)->a'	# TOO_MANY_NESTED
 check_error 'p vfs_read arg1=(task_struct,^in_execve)file->comm'	# TYPECAST_NOT_ALIGNED
 check_error 'p vfs_read arg1=(task_struct,^foo_bar)file->pid'	# NO_BTF_FIELD
 check_error 'p vfs_read arg1=(^task_struct1234)file->pid'		# NO_PTR_STRCT

