Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75439478F;
	Mon, 29 Jun 2026 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713682; cv=none; b=WBaz8XbmQ5rszbDo2RPinjqVEWJJ/nhdmahH/tJh1+dyARbeotqjxRyymhxRlro33nU53z1VikEYzMaux7irzshN+aih5YK/691z0fCtSacqKWw9TGZp2eNn1V7ahYjiMcmgWcuzBbLEH7E2oNbsqe/2iDslryLr9GIP2Yaa/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713682; c=relaxed/simple;
	bh=W1aqckSw6UoncYDT+SVrRa6GhiDUT4g/iLV8svwrNMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHsc51FsT5F7fNTyHLmv6O9QKpUu+v9y9vYQFgVf4rF3K1WRGK0kVBcZE0Op6dVDL/v3xlqmzsLFOmuHu4/vcCNYdxiVdlQgZiHvHFaYO4Gm6O2yAX2BIDVLUsdZWrkOU/COjZPcnR5NM2lCVngeKiOseP7IZXSa8SOGqWYivNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7g2bV0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7g2bV0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A301F000E9;
	Mon, 29 Jun 2026 06:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782713680;
	bh=k7/anP7t4ghVm/gjQf31KroM0ga10h9oMytnxmGitLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i7g2bV0ae4pcqRrYdgCNeITKHDaqI33t5OQ3SzGkS+kFFDfTcHw+ByReXH7Wf9ked
	 qJg4DzvZwDmRPkmipxwKtW36EkpRFplJHqksCtmXHWuHE+PGrkKVg45OtqIvG6dsWk
	 ByLIuZKhILhEakTyBSCj/DWhXBJfTbTX93N8DutDlw27WK9E60nWNpJVFARHd7NagY
	 MJOlrnqHDWQpP7IAZmzEBWtS0Ix0N6OeOREo4gXvp7PRpEeCKmEJC8r/Zb84ReUHCN
	 tmV/nhX49/a69fEV/Vn5NaBsKKUM4pZN7pxaI1k6LVq+dcnBnszY9mLJF4RyD/824M
	 Seykh1Mn1tp5A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v13 10/11] tracing/probes: Add this_cpu_read() and this_cpu_ptr() dereference method to fetcharg
Date: Mon, 29 Jun 2026 15:14:36 +0900
Message-ID: <178271367680.1176915.4711734074448973989.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178271357142.1176915.7193483024740701480.stgit@devnote2>
References: <178271357142.1176915.7193483024740701480.stgit@devnote2>
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

When tracing the kernel local variables, sometimes we need to get the
CPU local variables. To access it, current simple dereference is not
enough.

Thus, introduce a special this_cpu_read() dereference to access per-cpu
variable for the current CPU (accessing other CPU variable may race with
updates on other CPUs). Also this_cpu_ptr() is for accessing per-cpu
pointer.

Those are working as same as the kernel percpu macro.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v13:
  - Remove missed comma fix from this patch.
 Changes in v11:
  - Remove this_cpu_*() from eprobetrace.rst.
 Changes in v10:
  - Prohibit this_cpu_*() for eprobe events.
 Changes in v9:
  - Prohibit this_cpu_*() for non kernel probes.
 Changes in v6:
  - Rebased on dump fetcharg patch.
  - Fix to fetch static percpu variable with @SYM correctly.
 Changes in v5:
  - Simplify this_cpu_read() into +0(this_cpu_ptr()).
 Changes in v3:
  - Remove NULL check for percpu var because it is just an offset, could be 0.
  - Simplify process_fetch_insn_bottom() code.
  - If the last operation is this_cpu_read(), read only memory of the specific
    size (of type).
 Changes in v2:
  - Drop +CPU/+PCPU and introduce this_cpu_read() and this_cpu_ptr().
  - Support these method with BTF typecast.
  - Just check the base address is NOT NULL instead of is_kernel_percpu_address().
---
 Documentation/trace/fprobetrace.rst |    2 
 Documentation/trace/kprobetrace.rst |    2 
 kernel/trace/trace.c                |    1 
 kernel/trace/trace_probe.c          |  152 ++++++++++++++++++++++++++---------
 kernel/trace/trace_probe.h          |    4 +
 kernel/trace/trace_probe_tmpl.h     |   22 ++++-
 6 files changed, 138 insertions(+), 45 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 3392cab016b3..3439bc9bd351 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -52,6 +52,8 @@ Synopsis of fprobe-events
   $comm         : Fetch current task comm.
   $current      : Fetch the address of the current task_struct.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*4)(\*5)
+  this_cpu_read(FETCHARG) : Read the value of the per-CPU variable FETCHARG on the current CPU.
+  this_cpu_ptr(FETCHARG) : Get the address of the per-CPU variable FETCHARG on the current CPU.
   \IMM          : Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 81e4fe38791d..9ae330eb0a52 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -55,6 +55,8 @@ Synopsis of kprobe_events
   $comm		: Fetch current task comm.
   $current      : Fetch the address of the current task_struct.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  this_cpu_read(FETCHARG) : Read the value of the per-CPU variable FETCHARG on the current CPU.
+  this_cpu_ptr(FETCHARG) : Get the address of the per-CPU variable FETCHARG on the current CPU.
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2b0b4f9acb2e..c9e182d40059 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4329,6 +4329,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm, $current\n"
 #endif
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
+	"\t           this_cpu_read(<fetcharg>), this_cpu_ptr(<fetcharg>)\n"
 	"\t     kernel return probes support: $retval, $arg<N>, $comm\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 999dec84275d..18c212122344 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -345,6 +345,109 @@ static int parse_trace_event(char *arg, struct fetch_insn *code,
 	return -EINVAL;
 }
 
+/* this_cpu_* parser */
+#define THIS_CPU_PTR_PREFIX "this_cpu_ptr("
+#define THIS_CPU_READ_PREFIX "this_cpu_read("
+#define THIS_CPU_PTR_LEN (sizeof(THIS_CPU_PTR_PREFIX) - 1)
+#define THIS_CPU_READ_LEN (sizeof(THIS_CPU_READ_PREFIX) - 1)
+
+static int
+parse_probe_arg(char *arg, const struct fetch_type *type,
+		struct fetch_insn **pcode, struct fetch_insn *end,
+		struct traceprobe_parse_context *ctx);
+
+/* handle dereference nested call */
+static inline int handle_dereference(char *arg, struct fetch_insn **pcode,
+	struct fetch_insn *end, struct traceprobe_parse_context *ctx,
+	int deref, long offset)
+{
+	const struct fetch_type *type = find_fetch_type(NULL, ctx->flags);
+	struct fetch_insn *code = *pcode;
+	int cur_offs = ctx->offset;
+	char *tmp;
+	int ret;
+
+	tmp = strrchr(arg, ')');
+	if (!tmp) {
+		trace_probe_log_err(ctx->offset + strlen(arg),
+					DEREF_OPEN_BRACE);
+		return -EINVAL;
+	}
+
+	*tmp = '\0';
+	ret = parse_probe_arg(arg, type, &code, end, ctx);
+	if (ret)
+		return ret;
+	ctx->offset = cur_offs;
+	if (code->op == FETCH_OP_COMM || code->op == FETCH_OP_IMMSTR) {
+		trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
+		return -EINVAL;
+	}
+
+	/*
+	 * this_cpu_ptr(@SYM) does not use SYM value, but use SYM address.
+	 * So we overwrite the last FETCH_OP_DEREF with FETCH_OP_CPU_PTR.
+	 */
+	if (!(deref == FETCH_OP_CPU_PTR && *arg == '@')) {
+		code++;
+		if (code == end) {
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+			return -EINVAL;
+		}
+	}
+	*pcode = code;
+
+	code->op = deref;
+	code->offset = offset;
+	/* Reset the last type if used */
+	ctx->last_type = NULL;
+	return 0;
+}
+
+static int parse_this_cpu(char *arg, struct fetch_insn **pcode,
+			  struct fetch_insn *end,
+			  struct traceprobe_parse_context *ctx)
+{
+	struct fetch_insn *code;
+	bool is_ptr = false;
+	int ret;
+
+	/*
+	 * This is only for kernel probes, excluding eprobe, because per-cpu
+	 * pointer should not be recorded by events.
+	 */
+	if (!(ctx->flags & TPARG_FL_KERNEL) ||
+	    (ctx->flags & TPARG_FL_TEVENT)) {
+		trace_probe_log_err(ctx->offset, NOSUP_PERCPU);
+		return -EINVAL;
+	}
+	if (str_has_prefix(arg, THIS_CPU_PTR_PREFIX)) {
+		arg += THIS_CPU_PTR_LEN;
+		ctx->offset += THIS_CPU_PTR_LEN;
+		is_ptr = true;
+	} else if (str_has_prefix(arg, THIS_CPU_READ_PREFIX)) {
+		arg += THIS_CPU_READ_LEN;
+		ctx->offset += THIS_CPU_READ_LEN;
+	} else
+		return -EINVAL;
+
+	ret = handle_dereference(arg, pcode, end, ctx, FETCH_OP_CPU_PTR, 0);
+	if (ret || is_ptr)
+		return ret;
+
+	/* this_cpu_read(VAR) -> +0(this_cpu_ptr(VAR)) */
+	code = *pcode;
+	code++;
+	if (code == end) {
+		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+		return -EINVAL;
+	}
+	code->op = FETCH_OP_DEREF;
+	code->offset = 0;
+	*pcode = code;
+	return 0;
+}
+
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
 
 static u32 btf_type_int(const struct btf_type *t)
@@ -904,11 +1007,6 @@ static char *find_matched_close_paren(char *s)
 	return NULL;
 }
 
-static int
-parse_probe_arg(char *arg, const struct fetch_type *type,
-		struct fetch_insn **pcode, struct fetch_insn *end,
-		struct traceprobe_parse_context *ctx);
-
 static int handle_typecast(char *arg, struct fetch_insn **pcode,
 			   struct fetch_insn *end,
 			   struct traceprobe_parse_context *ctx)
@@ -961,7 +1059,9 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 		/* Skip '(' */
 		ctx->offset += 1;
 		tmp++;
-	} else if (*tmp == '+' || *tmp == '-') {
+	} else if (*tmp == '+' || *tmp == '-' ||
+		   str_has_prefix(tmp, THIS_CPU_PTR_PREFIX) ||
+		   str_has_prefix(tmp, THIS_CPU_READ_PREFIX)) {
 		/* Dereference can have another field access inside it. */
 		char *open = strchr(tmp + 1, '(');
 
@@ -1481,36 +1581,9 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		}
 		ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
 		arg = tmp + 1;
-		tmp = strrchr(arg, ')');
-		if (!tmp) {
-			trace_probe_log_err(ctx->offset + strlen(arg),
-					    DEREF_OPEN_BRACE);
-			return -EINVAL;
-		} else {
-			const struct fetch_type *t2 = find_fetch_type(NULL, ctx->flags);
-			int cur_offs = ctx->offset;
-
-			*tmp = '\0';
-			ret = parse_probe_arg(arg, t2, &code, end, ctx);
-			if (ret)
-				break;
-			ctx->offset = cur_offs;
-			if (code->op == FETCH_OP_COMM ||
-			    code->op == FETCH_OP_IMMSTR) {
-				trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
-				return -EINVAL;
-			}
-			if (++code == end) {
-				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
-				return -EINVAL;
-			}
-			*pcode = code;
-
-			code->op = deref;
-			code->offset = offset;
-			/* Reset the last type if used */
-			ctx->last_type = NULL;
-		}
+		ret = handle_dereference(arg, pcode, end, ctx, deref, offset);
+		if (ret < 0)
+			return ret;
 		break;
 	case '\\':	/* Immediate value */
 		if (arg[1] == '"') {	/* Immediate string */
@@ -1531,7 +1604,10 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		ret = handle_typecast(arg, pcode, end, ctx);
 		break;
 	default:
-		if (isalpha(arg[0]) || arg[0] == '_') {
+		if (str_has_prefix(arg, THIS_CPU_PTR_PREFIX) ||
+		    str_has_prefix(arg, THIS_CPU_READ_PREFIX)) {
+			ret = parse_this_cpu(arg, pcode, end, ctx);
+		} else if (isalpha(arg[0]) || arg[0] == '_') {
 			/* BTF variable or event field*/
 			if (ctx->flags & TPARG_FL_TEVENT) {
 				ret = parse_trace_event(arg, *pcode, ctx);
@@ -1548,8 +1624,8 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				return -EINVAL;
 			}
 			ret = parse_btf_arg(arg, pcode, end, ctx);
-			break;
 		}
+		break;
 	}
 	if (!ret && code->op == FETCH_OP_NOP) {
 		/* Parsed, but do not find fetch method */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 195096f5b8b1..e6268a8dc378 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -101,6 +101,7 @@ typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
 	/* Stage 2 (dereference) ops */					\
 	FETCH_OP(DEREF, offset),	/* Dereference: .offset */	\
 	FETCH_OP(UDEREF, offset),	/* User-space dereference: .offset */\
+	FETCH_OP(CPU_PTR, none),	/* Per-CPU pointer: .offset */	\
 	/* Stage 3 (store) ops */					\
 	FETCH_OP(ST_RAW, store),	/* Raw value: .size */		\
 	FETCH_OP(ST_MEM, store),	/* Memory: .offset, .size */	\
@@ -598,7 +599,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"), \
 	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses"), \
 	C(TYPECAST_NOT_ALIGNED,	"Typecast field option is not byte-aligned"), \
-	C(TYPECAST_BAD_ARROW,	"Typecast field option does not support -> operator"),
+	C(TYPECAST_BAD_ARROW,	"Typecast field option does not support -> operator"), \
+	C(NOSUP_PERCPU,		"Per-cpu variable access is only for kernel probes"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index d0e9662cde00..8db12f758fda 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -129,25 +129,35 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	struct fetch_insn *s3 = NULL;
 	int total = 0, ret = 0, i = 0;
 	u32 loc = 0;
-	unsigned long lval = val;
+	unsigned long lval, llval = val;
 
 stage2:
 	/* 2nd stage: dereference memory if needed */
 	do {
-		if (code->op == FETCH_OP_DEREF) {
-			lval = val;
+		lval = val;
+		switch (code->op) {
+		case FETCH_OP_DEREF:
 			ret = probe_mem_read(&val, (void *)val + code->offset,
 					     sizeof(val));
-		} else if (code->op == FETCH_OP_UDEREF) {
-			lval = val;
+			break;
+		case FETCH_OP_UDEREF:
 			ret = probe_mem_read_user(&val,
 				 (void *)val + code->offset, sizeof(val));
-		} else
 			break;
+		case FETCH_OP_CPU_PTR:
+			val = (unsigned long)this_cpu_ptr((void __percpu *)val);
+			ret = 0;
+			break;
+		default:
+			lval = llval;
+			goto out;
+		}
 		if (ret)
 			return ret;
+		llval = lval;
 		code++;
 	} while (1);
+out:
 
 	s3 = code;
 stage3:

