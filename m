Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E0C2FF66A;
	Sun, 21 Jun 2026 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782012447; cv=none; b=aRSomOjczNjK9a9EW9FJ88AC2SO4NsFDOqdX2B60JKURjW3QYGOsoM+9FTxYunBn4bsvbCtttS273WFxfoSrdFDgSjd6Xv0pH+PLoElcrGswJXKS5OGvYBYTkIT4HGy78VeA3Mu7/VgHDs4nn1K5rC8mxeT/6wBjlBY88dXQQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782012447; c=relaxed/simple;
	bh=xU6zuM/HbYMaltYcjwukisTr0VSMBwt6jbjQ3T3zIHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXWW1vaNTqKlscdVtnQUfPuBBdXdfZnaY3OciST3po7nikYEjlb/1vs/uPxYdzIKJEy8SHrWYSXoW3psQseoFzgrDx06SM8qXQdk9FLBOW6gC64JLUNWJkRlvKWnhfIyLBGjee3ZqjdayHPPSsb8HBcdzKV5gBeFCvlG29/NRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvkZPznC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvkZPznC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DA31F000E9;
	Sun, 21 Jun 2026 03:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782012446;
	bh=l19KSv81H8CLDh/l6df6UqO1an9RpFg82puag8/Glqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvkZPznCSKgh6rDosJpdx6aHxGvmo18hE2VXIBtvdt+SNXW9tINo34jliT0W++U9k
	 aBzhPsoIqlThAp3hBuML1cmpaI65Ce8IhQNhWINNELLiENsTU4sXA0ZsK8KqEs7Czi
	 2tCxw9pVhymeo/07jCI6K+cq6iElpAtDb/DyeafSwwr5cWQ8l2RVanIdLErwGnYIqD
	 uh23EKf6uHzVYL3Fse+9DJdrvH+WDB4S+YIUyJOXKa4uUMvtAPbSvWAuH67g46clZb
	 m/S6wgL2cXuIbCdWuZx4rGCBmkyF9wjCUc+feP1PIuNrVWepwRjjDQMpTf1BUyRu0Z
	 Q892t7UTG79hA==
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
Subject: [RESEND PATCH v6 6/8] tracing/probes: Add $current variable support
Date: Sun, 21 Jun 2026 12:27:22 +0900
Message-ID: <178201244244.570818.11928719829378403826.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178201238795.570818.15573963115625446598.stgit@devnote2>
References: <178201238795.570818.15573963115625446598.stgit@devnote2>
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

Since we can use the BTF to cast value to a structure pointer type,
it is useful to introduce "$current" special variable support to
fetcharg.

User can define a fetcharg to access current task_struct properties
using BTF info. e.g.

  $current->cpus_ptr

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - Rebased on dump fetcharg patch.
  - Remove function name/eprobe requirement for $current.
 Changes in v5:
  - Use s32 for bof_find_btf_id().
 Changes in v4:
  - Add $current in README when CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y case.
  - Fix to prohibit using $current in eprobes and address based kprobes.
 Changes in v3:
  - Remove $current support from eprobes (because eprobes is only for event)
  - Prohibit uprobes to use $current.
 Changes in v2:
   - Support to parse $current in parse_btf_arg().
   - If no typecast on $current, it automatically casted to task_struct.
   - Check error case if $current follows something except for "-".
---
 Documentation/trace/fprobetrace.rst |    1 +
 Documentation/trace/kprobetrace.rst |    1 +
 kernel/trace/trace.c                |    4 ++--
 kernel/trace/trace_probe.c          |   40 ++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h          |    1 +
 kernel/trace/trace_probe_tmpl.h     |    3 +++
 6 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 290a9e6f7491..3392cab016b3 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -50,6 +50,7 @@ Synopsis of fprobe-events
   $argN         : Fetch the Nth function argument. (N >= 1) (\*2)
   $retval       : Fetch return value.(\*3)
   $comm         : Fetch current task comm.
+  $current      : Fetch the address of the current task_struct.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*4)(\*5)
   \IMM          : Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index a62707e6a9f2..81e4fe38791d 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -53,6 +53,7 @@ Synopsis of kprobe_events
   $argN		: Fetch the Nth function argument. (N >= 1) (\*1)
   $retval	: Fetch return value.(\*2)
   $comm		: Fetch current task comm.
+  $current      : Fetch the address of the current task_struct.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e36af853199..7a5676524f1a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4323,13 +4323,13 @@ static const char readme_msg[] =
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: (%<register>|$<efield>), @<address>, @<symbol>[+|-<offset>],\n"
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
+	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>, $current\n"
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
 	"\t           [(structname[,field])]<argname>[->field[->field|.field...]],\n"
 	"\t           [(structname[,field])](fetcharg)->field[->field|.field...],\n"
 #endif
 #else
-	"\t           $stack<index>, $stack, $retval, $comm,\n"
+	"\t           $stack<index>, $stack, $retval, $comm, $current\n"
 #endif
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     kernel return probes support: $retval, $arg<N>, $comm\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8c21c378fac7..1ddd0a804e39 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -700,7 +700,9 @@ static int parse_btf_arg(char *varname,
 	int i, is_ptr, ret;
 	u32 tid;
 
-	if (!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT))
+	/* Note: field is not separated at this point, so check prefix. */
+	if (!str_has_prefix(varname, "$current") &&
+	    !ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT))
 		return -EINVAL;
 
 	is_ptr = split_next_field(varname, &field, ctx);
@@ -713,6 +715,24 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (!strcmp(varname, "$current")) {
+		code->op = FETCH_OP_CURRENT;
+		/* If no typecast is specified for $current, use task_struct by default */
+		if (!ctx->struct_btf) {
+			s32 ttid = bpf_find_btf_id("task_struct", BTF_KIND_STRUCT,
+						   &ctx->struct_btf);
+
+			if (ttid < 0) {
+				trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
+				return -ENOENT;
+			}
+			/* btf_type_skip_modifier() requires u32 for type id. */
+			tid = ttid;
+			ctx->last_struct = btf_type_skip_modifiers(ctx->struct_btf, tid, &tid);
+		}
+		goto found;
+	}
+
 	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
 		code->op = FETCH_OP_RETVAL;
 		/* Check whether the function return type is not void, even with typecast. */
@@ -1273,6 +1293,24 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 		return 0;
 	}
 
+	/* $current returns the address of the current task_struct. */
+	if (str_has_prefix(arg, "current")) {
+		/* $current is only supported by kernel probe. */
+		if (!(ctx->flags & TPARG_FL_KERNEL)) {
+			err = TP_ERR_BAD_VAR;
+			goto inval;
+		}
+		arg += strlen("current");
+		if (*arg == '-' && IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS))
+			return parse_btf_arg(orig_arg, pcode, end, ctx);
+
+		if (*arg != '\0')
+			goto inval;
+
+		code->op = FETCH_OP_CURRENT;
+		return 0;
+	}
+
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	len = str_has_prefix(arg, "arg");
 	if (len) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index bc3ac148a655..488d6790b5ef 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -92,6 +92,7 @@ typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
 	FETCH_OP(RETVAL, none)		/* Return value */		\
 	FETCH_OP(IMM, imm)		/* Immediate: .immediate */	\
 	FETCH_OP(COMM, none)		/* Current comm */		\
+	FETCH_OP(CURRENT, none)		/* Current task_struct address */\
 	FETCH_OP(ARG, param)		/* Argument: .param = index */	\
 	FETCH_OP(FOFFS, imm)		/* File offset: .immediate */	\
 	FETCH_OP(DATA, ptr)		/* Allocated data: .data */	\
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index f39b37fcdb3b..f630930288d2 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -112,6 +112,9 @@ process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
 	case FETCH_OP_DATA:
 		*val = (unsigned long)code->data;
 		break;
+	case FETCH_OP_CURRENT:
+		*val = (unsigned long)current;
+		break;
 	default:
 		return -EILSEQ;
 	}

