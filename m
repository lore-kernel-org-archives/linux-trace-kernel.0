Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE90399364;
	Sun, 14 Jun 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448857; cv=none; b=emW7jULFVLpmK3w4+0d0cNpN/Xr3LJfREf1cEObJssKaNFa+104zlJcJv5GZHPFrOvv2Ej0liOptN+5X/AEDsh2eSwYIUF8rz5XcsBIueGRCmRGv3zQLV++eotYm1W+eRxbFo04ZmeGtzX/pJ9B4iNORYVQwg5MOzEtj46C/AA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448857; c=relaxed/simple;
	bh=DYCIsuuQSpcfpufYBS6TVEsoXrB3F9y2mHNsTTCxgBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kX54YO9Ys9gGBZV3dniIBalJVL1bGG0P6BzmSro8kTuY/kR2Rn19EY8hrRlLDCuJHt5z4tRAo78rjQm57ddkLMiM5sFe3GAtSIIY9qlMthP/keSyp31OA2ve8LiOgjzOsS9mPVfYBGhwCSYYZb7sM5Cag12N/7Wqal7ICYeqD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7DudASR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7DudASR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA46C1F000E9;
	Sun, 14 Jun 2026 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781448856;
	bh=VJiMKGdTkRU15aPiJf+0EJO8W0gjiFs5tUKRTwu6ZpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7DudASR7QbyTTPAMml5rTSvuHsjBS+iTMm5VyvAz+d7iJeBCDW2VEjDljKt4HfDz
	 v0xHLEWTnRBkgx0SKVdvHNuIXc7E2kYoGaKHY8IRXFoy1okX549E8/FkDtokl+7p7C
	 +UrHOYC/P0tiz8LlvrAYjmSRpkSgKMxB+Hy5qSMk9LGT/3vXfc2akAfrJWP2sDVRct
	 8E/TN9CUIS/KZ+Pgc9zY2JOp8uLhUuFOhrMozX6Ixa7Pac+oiFDe22T3N8oeT0Bh/X
	 NX7UkKeOka8F9XPA9Q8UoK5DCfm8SNpPqIkwnYJ675tqlRU+P7r2jAhQnF3AGbj7LJ
	 UaMyjB8jg7xCg==
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
Subject: [PATCH v3 5/7] tracing/probes: Add $current variable support
Date: Sun, 14 Jun 2026 23:54:11 +0900
Message-ID: <178144885187.159464.4971616625552578908.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178144880282.159464.16882854283219530040.stgit@devnote2>
References: <178144880282.159464.16882854283219530040.stgit@devnote2>
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
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_probe.c          |   34 +++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h          |    1 +
 kernel/trace/trace_probe_tmpl.h     |    3 +++
 6 files changed, 40 insertions(+), 2 deletions(-)

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
index 3ead93de2d93..017f30ae9def 100644
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
 
@@ -1247,6 +1261,24 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
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

