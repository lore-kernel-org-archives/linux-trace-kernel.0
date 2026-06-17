Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10AE284B3B;
	Wed, 17 Jun 2026 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658216; cv=none; b=UgdiDeULL8RBvwfo75dlUjHNtN/sxxVSGE3pv50V74vdg0xuGNuPIwZnhkgCWPkQ6PScM5LhotZIJXhsD5datGI5nPMFBYI3IrOY5Jca3pYk6VyOdnoJFzX7gY2DIBQkBqgrFsDz4CaLx7OhDlpaEbLHxM+Bnd1tSqx8Zq2JROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658216; c=relaxed/simple;
	bh=w64uNwld4O6Cp1Irr3DPkmPvikTuVyodZTvSbSTScHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuaNLwjQCD46tK3Wby0DC1fb4NwGFM3oa8u56kNg6VJ5DXuoLvIEYL+RDoWAJj2uOrQXIRrAljhgZLOMCpTzEINjLF0+y51gqkODsOce0TR1hKkx0qE1p70yPlyb6BnDf1CmG0q4AHmiLvr9KPNU1PRijal9WZd3bEVt9oqt8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXG8A/n4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXG8A/n4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F05A1F00A3A;
	Wed, 17 Jun 2026 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658215;
	bh=GZLBl8vR0/182jG6QpW6fSRs4D73rqfVy+fQ+kt0u9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nXG8A/n4cjNec8pJAA65wdS2QIthSGbTrKuHYE0SlWPKd17fG77UqB1Towr9zv1bt
	 n+9rn9rnxqVAjzvEGnSTP/sXv7zMEvXuE/nO3htLF1s2M02ciyyGR2VQAZKgRydFmO
	 aGPW4qB3bJjzSJSk3Tb8eL2LpFc8Wjp3oklBvYqrlmO8zP+ngimqKJcGvjxiwnTHRG
	 gvTWMJAMigvWEKtA9DNM8R2ZEt4nasu6nj3I/lZe2ijBlshskseGmo+cXf5qxCqSFj
	 QOZtly9EzRVAxebyQuvcHh50iW3MhJezuKXgmap6K4GXzWcJwSR0mX9ueyxAsorQ26
	 CbmQ4//LwjLrw==
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
Subject: [PATCH v5 5/7] tracing/probes: Add $current variable support
Date: Wed, 17 Jun 2026 10:03:31 +0900
Message-ID: <178165821121.269421.7894063612460991879.stgit@devnote2>
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

Since we can use the BTF to cast value to a structure pointer type,
it is useful to introduce "$current" special variable support to
fetcharg.

User can define a fetcharg to access current task_struct properties
using BTF info. e.g.

  $current->cpus_ptr

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
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
index 0f2be8c817fc..93edac7fc943 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -730,6 +730,24 @@ static int parse_btf_arg(char *varname,
 		goto found;
 	}
 
+	if (strcmp(varname, "$current") == 0) {
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
@@ -763,8 +781,8 @@ static int parse_btf_arg(char *varname,
 			return -ENOENT;
 		}
 	}
-	params = ctx->params;
 
+	params = ctx->params;
 	for (i = 0; i < ctx->nr_params; i++) {
 		const char *name = btf_name_by_offset(ctx->btf, params[i].name_off);
 
@@ -1254,6 +1272,24 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 		return 0;
 	}
 
+	/* $current returns the address of the current task_struct. */
+	if (str_has_prefix(arg, "current")) {
+		/* $current is only supported by kernel probe and need function name. */
+		if (!(ctx->flags & TPARG_FL_KERNEL) || !ctx->funcname) {
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
index 44f113faae61..62645e847bd1 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -96,6 +96,7 @@ enum fetch_op {
 	FETCH_OP_FOFFS,		/* File offset: .immediate */
 	FETCH_OP_DATA,		/* Allocated data: .data */
 	FETCH_OP_EDATA,		/* Entry data: .offset */
+	FETCH_OP_CURRENT,	/* Current task_struct address */
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
 	FETCH_OP_UDEREF,	/* User-space Dereference: .offset */
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

