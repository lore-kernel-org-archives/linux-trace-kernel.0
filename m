Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05951F0E25;
	Wed, 10 Jun 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052735; cv=none; b=AsQqrasygSYeaa4FPsGvjl4dtslA392Ly0d3d78XG5yoMr44M/7cRIFgz6Dv8wQnrU/RYlp0dmuUOZ449YHGt7lZHd98QBgq9rU0DxCqD4x096trTQUN4GoZYNGFTq9/KXxmPrUNIqZNXqoFOzyIbcX23DkNPuQe8biFtK81ATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052735; c=relaxed/simple;
	bh=Fn6NFeVl+8I2Lt+Te4HJEOhim318pM42fs0mIl3ydgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpgZRkcsYZKcJmM9UdA+XYldTeEOV6LByaX/GDo8eaPchMyeeK+vI44n+IELuBX4+uGYGxFA9hAzfJf7gV7q+aSjLkS2RNfa+j4Ncom6TYBzoUJhPgWsScy+/AmlRWTgQZ9wLTFE+rLGHEYD22gp9JVqPwYqxnC1HS75lGEnGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqjqqX3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqjqqX3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4151F00893;
	Wed, 10 Jun 2026 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781052734;
	bh=ZxennJuN8G9gRrbq+oG+R8TiWvbtABTeNRFAsYm0Kxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqjqqX3nDeYf8HiHxqzYHHz6ZRMp+BW3gwHFlrm/slKJKf4wzPBlE4B5PMscVSdh5
	 Jh1LG2qTVb+OngAdmSkimSfkpLz7yNZgmt7p+M4PnQ6+DgXORFZgpODjxhEXmfGIN9
	 vXo4h3OXioCNKhELx33ZUwWqsdXEOYZg5hgJLM3OkNuYMRjUg2E1HKfmUJbe49YKis
	 qUnsiQ/6jNR5w7eOBX0zOM39FwiYmdmSiivVV1Uv/qr3rikqu3+mRZbnxNGPKuadwh
	 pqpERJk2LPJL+Oc5Z+hIFZR3caDnwLlQgO6HfTy8Ps40khP2VohNALOKnVXH3i9xWA
	 N2QNSWxJwD4Mw==
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
Subject: [RFC PATCH v2 5/7] tracing/probes: Add $current variable support
Date: Wed, 10 Jun 2026 09:52:10 +0900
Message-ID: <178105273050.21760.12587121915086626782.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178105268094.21760.13668249930524377840.stgit@devnote2>
References: <178105268094.21760.13668249930524377840.stgit@devnote2>
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
  Changes in v2:
   - Support to parse $current in parse_btf_arg().
   - If no typecast on $current, it automatically casted to task_struct.
   - Check error case if $current follows something except for "-".
---
 Documentation/trace/eprobetrace.rst |    1 +
 Documentation/trace/fprobetrace.rst |    1 +
 Documentation/trace/kprobetrace.rst |    1 +
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_probe.c          |   29 ++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h          |    1 +
 kernel/trace/trace_probe_tmpl.h     |    3 +++
 7 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
index 680e0af43d5d..dcf92d5b4175 100644
--- a/Documentation/trace/eprobetrace.rst
+++ b/Documentation/trace/eprobetrace.rst
@@ -38,6 +38,7 @@ Synopsis of eprobe_events
   @ADDR		: Fetch memory at ADDR (ADDR should be in kernel)
   @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
   $comm		: Fetch current task comm.
+  $current	: Fetch the address of the current task_struct.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
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
index 0e36af853199..e185a006cb08 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4329,7 +4329,7 @@ static const char readme_msg[] =
 	"\t           [(structname[,field])](fetcharg)->field[->field|.field...],\n"
 #endif
 #else
-	"\t           $stack<index>, $stack, $retval, $comm,\n"
+	"\t           $stack<index>, $stack, $retval, $comm, $current\n"
 #endif
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     kernel return probes support: $retval, $arg<N>, $comm\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 726be9782775..4bdccd9bd7d1 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -718,6 +718,20 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (strcmp(varname, "$current") == 0) {
+		code->op = FETCH_OP_CURRENT;
+		/* If no typecast is specified for $current, use task_struct by default */
+		if (!ctx->struct_btf) {
+			tid = bpf_find_btf_id("task_struct", BTF_KIND_STRUCT, &ctx->struct_btf);
+			if (tid < 0) {
+				trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
+				return -ENOENT;
+			}
+			ctx->last_struct = btf_type_skip_modifiers(ctx->struct_btf, tid, &tid);
+		}
+		goto found;
+	}
+
 	if (ctx->flags & TPARG_FL_TEVENT) {
 		ret = parse_trace_event(varname, code, ctx);
 		if (ret < 0) {
@@ -756,8 +770,8 @@ static int parse_btf_arg(char *varname,
 			return -ENOENT;
 		}
 	}
-	params = ctx->params;
 
+	params = ctx->params;
 	for (i = 0; i < ctx->nr_params; i++) {
 		const char *name = btf_name_by_offset(ctx->btf, params[i].name_off);
 
@@ -1246,6 +1260,19 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 		return 0;
 	}
 
+	/* $current returns the address of the current task_struct. */
+	if (str_has_prefix(arg, "current")) {
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

