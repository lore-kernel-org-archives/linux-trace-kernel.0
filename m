Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CC370D4C;
	Tue, 23 Jun 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179141; cv=none; b=VK2yxFAJ0A3XwgDo7bC8R9TzOppmswVSjajnpdrTuZwKFA8XUL0/NW6Nin/opozMHSd+DV71BWBsECzt8epm7RZMpivl2Fsf3pGlln5K4gIXMOq67MRaYAzJCZ7cyEDewx/QzPiK+rEFK7SZAAQeQpnhsVs3gxrlf+TXkn8PEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179141; c=relaxed/simple;
	bh=a+Nrp48slBHka3A4rFdSR7KjTiYAZfDSqqinrnqW/GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksqf1d0mExU76PskcQuyyJF2u8dCroTEIQhQ/AvXbZh1DP3AmHC0UrvF8bMTzVMFSUzEYX0yCq8p9CEcVLHaH76ICHPxLNCFau+vm0fp0TNf9lW2+cXrhRBg97k+YpqYCfIjTdlzMjS59+IVD6vSqlHbVcIyaS3yNxtBJi7oCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC1In8HP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC1In8HP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36A11F000E9;
	Tue, 23 Jun 2026 01:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179139;
	bh=IiDcBuLBk/fju9UcboJBXuGH/onJ/umnUwfDE7gnx/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RC1In8HPNjEys0E7xY+woLF9e5K5Hf6t70iHTVPjBgcDl4u21/pcfri9NPWnll5Kh
	 19YPdPJhrg+g6IC6iRNyyB1fEnlsZivn/nsIIkJzsd6XOLdcEiQstocEIuma1N/Q4d
	 5cDHPUCjMvhEv6rCUv4iFsWN/j3rMTfEziBDgX6q3u/sPzVPokzxWHCDPHVtIe2dEp
	 +Yt/xaqD5ygvSVhHbJ2gkpaYXOJlCMZxuLy3NySEKLglTF9j1L83ZtjXSGmLcCGhvV
	 6BR7cpc0y+2yxSQ2/i7dpQlAuagVEqUkxxn/+pKVdIrpAjByBdwv8SnPTOKTfHlYKc
	 yWLtsD/PjHPoA==
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
Subject: [PATCH v7 09/10] tracing/probes: Add this_cpu_read() and this_cpu_ptr() dereference method to fetcharg
Date: Tue, 23 Jun 2026 10:45:35 +0900
Message-ID: <178217913555.643090.17801549274989959955.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178217904992.643090.15726197350652241270.stgit@devnote2>
References: <178217904992.643090.15726197350652241270.stgit@devnote2>
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
 Documentation/trace/eprobetrace.rst |    2 
 Documentation/trace/fprobetrace.rst |    2 
 Documentation/trace/kprobetrace.rst |    2 
 kernel/trace/trace.c                |    1 
 kernel/trace/trace_probe.c          |  143 ++++++++++++++++++++++++++---------
 kernel/trace/trace_probe.h          |    3 -
 kernel/trace/trace_probe_tmpl.h     |   22 ++++-
 7 files changed, 130 insertions(+), 45 deletions(-)

diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
index 680e0af43d5d..279396951b34 100644
--- a/Documentation/trace/eprobetrace.rst
+++ b/Documentation/trace/eprobetrace.rst
@@ -39,6 +39,8 @@ Synopsis of eprobe_events
   @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
   $comm		: Fetch current task comm.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  this_cpu_read(FETCHARG) : Read the value of the per-CPU variable FETCHARG on the current CPU.
+  this_cpu_ptr(FETCHARG) : Get the address of the per-CPU variable FETCHARG on the current CPU.
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
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
index 7a5676524f1a..d4121acc2938 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4332,6 +4332,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm, $current\n"
 #endif
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
+	"\t           this_cpu_read(<fetcharg>), this_cpu_ptr(<fetcharg>)\n"
 	"\t     kernel return probes support: $retval, $arg<N>, $comm\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ddcbc8c12ad9..85aed7327530 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -349,6 +349,100 @@ static int parse_trace_event(char *arg, struct fetch_insn *code,
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
@@ -913,11 +1007,6 @@ static char *find_matched_close_paren(char *s)
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
@@ -970,7 +1059,9 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 		/* Skip '(' */
 		ctx->offset += 1;
 		tmp++;
-	} else if (*tmp == '+' || *tmp == '-') {
+	} else if (*tmp == '+' || *tmp == '-' ||
+		   str_has_prefix(tmp, THIS_CPU_PTR_PREFIX) ||
+		   str_has_prefix(tmp, THIS_CPU_READ_PREFIX)) {
 		/* Dereference can have another field access inside it. */
 		char *open = strchr(tmp + 1, '(');
 
@@ -1483,36 +1574,9 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
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
@@ -1533,15 +1597,18 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		ret = handle_typecast(arg, pcode, end, ctx);
 		break;
 	default:
-		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
+		if (str_has_prefix(arg, THIS_CPU_PTR_PREFIX) ||
+		    str_has_prefix(arg, THIS_CPU_READ_PREFIX)) {
+			ret = parse_this_cpu(arg, pcode, end, ctx);
+		} else if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
 			if (!tparg_is_function_entry(ctx->flags) &&
 			    !tparg_is_function_return(ctx->flags)) {
 				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
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
index 37f065b82a32..e6c925817640 100644
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
@@ -595,7 +596,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"), \
 	C(TYPECAST_REQ_FIELD,	"Typecast requires a field access"),	\
 	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"), \
-	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses") \
+	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses"), \
 	C(TYPECAST_NOT_ALIGNED,	"Typecast field option is not byte-aligned"), \
 	C(TYPECAST_BAD_ARROW,	"Typecast field option does not support -> operator"),
 
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

