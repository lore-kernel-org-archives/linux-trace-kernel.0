Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D1386C17;
	Tue, 23 Jun 2026 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179131; cv=none; b=svssqHSPJfHxgqjGlF7Imugl931Uqegigsyi8WVH714EwoZPblijA2PENkJDdbV5XOMapNR5v47R1wo+w4Wf4c9cJwsunkNRc6NDJ/4HCB33ai9vDnWCsREB0IwSzEACy+ab2bVgERY3DxN+AFsecXNEi6QMbw7gAJgYE5WEVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179131; c=relaxed/simple;
	bh=KoShVbNi/VRmX3TUZq0rQJS/rZ9YOTIVrWfIL9aat1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dab7W15cBqOapJbiVjmdm6XbQ0lwd1CgQvohSCTtPKtTBE53cLi/HVnllj7BfcGjAqiY62Axpz6YiDccGGv1pc9AVieQTmD5d9ZyXEy8JHtfXevQ8tR8mYK1xlzrx1vRqoAe+1cI2gjjCGzkSCyeR2qU9OUPDGY/bWFB3vRAXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnFYeWys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnFYeWys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5BB1F00A3A;
	Tue, 23 Jun 2026 01:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179130;
	bh=CJxbfQqY6P3zEZKNpHiufayaJx0BDtYo6pcS/DXu2eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EnFYeWysuStO8Sx4+fCfJCGWvtdYDQLvZGaj1YxdiSIBPNtKQCpJWWbIFtfbhObUf
	 J8ZuZf0ZTl+8B4lZL43dycNTVWQC7j7j86Amwml6tmnEGmmVm4tDhsc+b9/9gapxuf
	 nEZeRLNLQ9KWKokspkoBInzLyrgtqocGny6G13uVKsMYg1ZedmUO89LPn8iUhweWEt
	 4433EtSafXgBoYpUJnAaja169xWzsI5KrYvfgL5+iXEScYm5D208wJrAoj8P2YXvBT
	 1cr3sIsZzA1aiBShDZsH58wio/rGNVe4yi9GsoUi+RqMnltE6j1Ss+X7hxeY/T9rCv
	 wDhCAcn11HhJA==
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
Subject: [PATCH v7 08/10] tracing/probes: Add $current variable support
Date: Tue, 23 Jun 2026 10:45:26 +0900
Message-ID: <178217912614.643090.8477405539676234888.stgit@devnote2>
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

Since we can use the BTF to cast value to a structure pointer type,
it is useful to introduce "$current" special variable support to
fetcharg.

User can define a fetcharg to access current task_struct properties
using BTF info. e.g.

  $current->cpus_ptr

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Fix to use force-typecast for task_struct implicitly.
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
 kernel/trace/trace_probe.c          |   38 ++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h          |    1 +
 kernel/trace/trace_probe_tmpl.h     |    3 +++
 6 files changed, 45 insertions(+), 3 deletions(-)

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
index 755c0f94a54b..ddcbc8c12ad9 100644
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
@@ -713,6 +715,22 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (!strcmp(varname, "$current")) {
+		s32 stid;
+
+		code->op = FETCH_OP_CURRENT;
+		/* If no typecast is specified for $current, use task_struct by default */
+		stid = bpf_find_btf_id("task_struct", BTF_KIND_STRUCT, &ctx->struct_btf);
+		if (stid < 0) {
+			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
+			return -ENOENT;
+		}
+		/* btf_type_skip_modifier() requires u32 for type id. */
+		tid = stid;
+		ctx->last_struct = btf_type_skip_modifiers(ctx->struct_btf, tid, &tid);
+		goto found;
+	}
+
 	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
 		code->op = FETCH_OP_RETVAL;
 		/* Check whether the function return type is not void, even with typecast. */
@@ -1271,6 +1289,24 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
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
index 213d2aea4f06..37f065b82a32 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -92,6 +92,7 @@ typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
 	FETCH_OP(RETVAL, none),		/* Return value */		\
 	FETCH_OP(IMM, imm),		/* Immediate: .immediate */	\
 	FETCH_OP(COMM, none),		/* Current comm */		\
+	FETCH_OP(CURRENT, none),	/* Current task_struct address */\
 	FETCH_OP(ARG, param),		/* Argument: .param = index */	\
 	FETCH_OP(FOFFS, imm),		/* File offset: .immediate */	\
 	FETCH_OP(IMMSTR, string),	/* Allocated string: .data */	\
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 51436f19083b..d0e9662cde00 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -112,6 +112,9 @@ process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
 	case FETCH_OP_IMMSTR:
 		*val = (unsigned long)code->data;
 		break;
+	case FETCH_OP_CURRENT:
+		*val = (unsigned long)current;
+		break;
 	default:
 		return -EILSEQ;
 	}

