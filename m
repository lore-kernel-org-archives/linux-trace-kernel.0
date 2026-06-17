Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55442765FF;
	Wed, 17 Jun 2026 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658226; cv=none; b=HQve4LeNej4L9aE6ZZmKWl2eh9iws7JcdKONGsJRetvTwazh3Uv1Yjl07DLlQjDDydp75XHh4k3fGdWdPsdYqmM5v8nG7ZDfI0c6ylvo4iwFQA089dEmX/ksp/iyOz1czdIL8P9D+YAtj+mW+LCeUtWN7ViMr59JHqGOiIHkx5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658226; c=relaxed/simple;
	bh=GrcwO8TWV8irHnPdoVxHOqOcPz+JKYHn+hkbN3//yR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMNd1PcuKXdbWdjPrHRKP+lrEJ2xZ2R02dIGeX/LiXxXlo7gu58mcAUxuf6RrJ0gmw3PHgHaCYApyFys0SqlPYwgAGgCXeX1eTXRjpn7JoV+UhPhLyqxpNWtRV1nYF2m5x9HoGBq4CBtBJ1Id2OnKyUNnt5JDr/jGKUAXqx/dWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EF6jSQsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EF6jSQsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B241F000E9;
	Wed, 17 Jun 2026 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658224;
	bh=DI9l4DEo8PbHc1bLneV+ajCCZuIbwfXCGD/adItz+b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EF6jSQsSz4jdEgVIgg9XESBLDqMJt/kUwaryHT5FQeYHqbbhAA7irG6/Ln6AW8luV
	 HustMlOyxxbOJOomavZVLH05pWnF0+Z7klyPB1tYpZhhGUwvJVgrjAgZQsyZlAnSn6
	 NuoAd9yf7Lh9Y5iMv/RomydI+Pa0orT3qmnU1qZdW/dtjFA+tzzG6C5jdTJ9QFWq0w
	 RI38yxzIW47UcwtQuRXtEaHhTJoEWJ6sr6l6aA353J5nJRp86G6FuI21xpkSjxkPov
	 0go0yiCDbcBBoe2ust5MtsQ5gHWOCPaTVsaTF7qXqk5exnIO/HX25jr0EaEqNAzl7A
	 dLJZsBMVOCnFw==
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
Subject: [PATCH v5 6/7] tracing/probes: Add this_cpu_read() and this_cpu_ptr() dereference method to fetcharg
Date: Wed, 17 Jun 2026 10:03:40 +0900
Message-ID: <178165822065.269421.17479525780856772304.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178165816303.269421.7302603996990753309.stgit@devnote2>
References: <178165816303.269421.7302603996990753309.stgit@devnote2>
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
 kernel/trace/trace_probe.c          |  151 +++++++++++++++++++++++++----------
 kernel/trace/trace_probe.h          |    1 
 kernel/trace/trace_probe_tmpl.h     |   22 ++++-
 7 files changed, 132 insertions(+), 49 deletions(-)

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
index 93edac7fc943..34286a2ac72e 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -349,6 +349,93 @@ static int parse_trace_event(char *arg, struct fetch_insn *code,
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
+	if (code->op == FETCH_OP_COMM || code->op == FETCH_OP_DATA) {
+		trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
+		return -EINVAL;
+	}
+	code++;
+	if (code == end) {
+		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+		return -EINVAL;
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
@@ -940,11 +1027,6 @@ static char *find_matched_close_paren(char *s)
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
@@ -970,7 +1052,8 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 	*tmp++ = '\0';
 
 	/* Handle the nested structure like (STRUCT)(VAR->FIELD)->... */
-	if (*tmp == '(') {
+	if (*tmp == '(' || str_has_prefix(tmp, THIS_CPU_PTR_PREFIX) ||
+	    str_has_prefix(tmp, THIS_CPU_READ_PREFIX)) {
 		char *close = find_matched_close_paren(tmp);
 
 		ctx->offset += tmp - arg;
@@ -990,12 +1073,18 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 			trace_probe_log_err(ctx->offset, TOO_MANY_NESTED);
 			return -E2BIG;
 		}
-		*close = '\0';
 
-		ctx->offset += 1;	/* for the '(' */
-		/* We need to parse the nested one */
-		ret = parse_probe_arg(tmp + 1, find_fetch_type(NULL, ctx->flags),
-				pcode, end, ctx);
+		if (*tmp == '(') {
+			/* Extract the inner argument */
+			*close = '\0';
+			ctx->offset += 1;/* for the '(' */
+			/* Parse the nested one */
+			ret = parse_probe_arg(tmp + 1, find_fetch_type(NULL, ctx->flags),
+					pcode, end, ctx);
+		} else {
+			/* this_cpu_* will be parsed in parse_this_cpu() */
+			ret = parse_this_cpu(tmp, pcode, end, ctx);
+		}
 		if (ret < 0)
 			return ret;
 		ctx->nested_level--;
@@ -1465,36 +1554,9 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
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
-			    code->op == FETCH_OP_DATA) {
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
@@ -1515,15 +1577,18 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
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
index 62645e847bd1..3651ce1f144f 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -100,6 +100,7 @@ enum fetch_op {
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
 	FETCH_OP_UDEREF,	/* User-space Dereference: .offset */
+	FETCH_OP_CPU_PTR,	/* Per-CPU pointer for this CPU */
 	// Stage 3 (store) ops
 	FETCH_OP_ST_RAW,	/* Raw: .size */
 	FETCH_OP_ST_MEM,	/* Mem: .offset, .size */
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index f630930288d2..9265b03cf19d 100644
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

