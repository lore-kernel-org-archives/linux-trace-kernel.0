Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCD224B04;
	Sun, 21 Jun 2026 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782012430; cv=none; b=XvAbgbdPu21rqHcZEsmrQVgJ/su+6PRV1Q4QXG0lG+FvvyQSY6d+i9MnLVkUSSWPPGQSjX/A9ilFAnlxErYIOpcb1+dPsKvuCBVn3ELYg0OUi/3IqAYD9pIaZ0HSYhbiU18s0HQJ6fVTSD89P37W7IqlhcK6N8mfQQyEdfZ5afM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782012430; c=relaxed/simple;
	bh=zmnfADVRPpK/oeZ0siMG+ZNdyfRyUEavzeqAiiKIlkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8mSbxfLKeTNngIryVlzX4SCxWOlA70eD3QJNGbqs56VLTlFruZlbNaFoGEKRZXE3/RsE9rj6MKBH5nSfKw8FnnYtkETc4NCi6Gl73OmoiOB8YC/Xkre0Ez/VXsKpmbdG8W/WN1gVHzk/4k50rVa5g/JqFMXNXYFju/a0SxpVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4Kii8Nc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4Kii8Nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B491F000E9;
	Sun, 21 Jun 2026 03:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782012428;
	bh=e7+CbQvZItN7+BJLtmchrIMdNeoy0A8Qp/NedOJdSq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4Kii8NceaVK2xkxDScX7DDpXvCVojVHpxT9sRmBFNjE77b2arhunjaRYPFDRYApd
	 8jiEdqGCl57+YSQZWgllSK02MPnQ7liG+dYY3+0vrg/bFxB/brOJMPnxPcvnLrvLiD
	 0Lc8e/1tlXIG42sN1nT8eGrzecqniehK6XiFyugNDzq3xj2N68+vGpIg4yxPOke3Cj
	 ycsT9tMzbENDFFuiYANJHNiGNWhbesdOLXnYhWeLqAGUWGp4LOX9vV57uike/C7RGa
	 Mz6QoqYnvTzlFg2Z7VCveGiMWEnksYx/F6b9quQhp311z83mKUGolCgjA9meDpujG0
	 r+x6cfXy71RsA==
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
Subject: [RESEND PATCH v6 4/8] tracing/probes: Type casting always involves nested calls
Date: Sun, 21 Jun 2026 12:27:04 +0900
Message-ID: <178201242438.570818.13140434612987626286.stgit@devnote2>
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

This allows type casting to various fetchargs without parentheses
by recursively calling parse_probe_arg on the target when type
casting is used.

For example, this allows the following expressions:
 - (STRUCT)%REG->FIELD
 - (STRUCT)$stackN->FIELD
 - (STRUCT)@SYM->FIELD

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - Newly added.
---
 kernel/trace/trace_probe.c |  101 +++++++++++++++++++++++++++-----------------
 kernel/trace/trace_probe.h |    1 
 2 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cebfba580922..b413bbe8c3af 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -691,19 +691,6 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
-	if (ctx->flags & TPARG_FL_TEVENT) {
-		ret = parse_trace_event(varname, code, ctx);
-		if (ret < 0) {
-			trace_probe_log_err(ctx->offset, BAD_ATTACH_ARG);
-			return ret;
-		}
-		/* TEVENT is only here via a typecast */
-		if (WARN_ON_ONCE(ctx->struct_btf == NULL))
-			return -EINVAL;
-		type = ctx->last_struct;
-		goto found_type;
-	}
-
 	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
 		code->op = FETCH_OP_RETVAL;
 		/* Check whether the function return type is not void, even with typecast. */
@@ -867,7 +854,7 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 			   struct traceprobe_parse_context *ctx)
 {
 	int orig_offset = ctx->offset;
-	bool nested = false;
+	char *close;
 	char *tmp;
 	int ret;
 
@@ -878,6 +865,17 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Always consider the token after typecast as a nested call
+	 * For example: (STRUCT)VAR->FIELD and (STRUCT)(VAR)->FIELD are same.
+	 * VAR is solved in the nested call.
+	 */
+	ctx->nested_level++;
+	if (ctx->nested_level > TRACEPROBE_MAX_NESTED_LEVEL) {
+		trace_probe_log_err(ctx->offset, TOO_MANY_NESTED);
+		return -E2BIG;
+	}
+
 	tmp = strchr(arg, ')');
 	if (!tmp) {
 		trace_probe_log_err(ctx->offset + strlen(arg),
@@ -886,11 +884,10 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 	}
 	*tmp++ = '\0';
 
-	/* Handle the nested structure like (STRUCT)(VAR->FIELD)->... */
+	ctx->offset += tmp - arg;
 	if (*tmp == '(') {
-		char *close = find_matched_close_paren(tmp);
+		close = find_matched_close_paren(tmp);
 
-		ctx->offset += tmp - arg;
 		if (!close) {
 			trace_probe_log_err(ctx->offset, DEREF_OPEN_BRACE);
 			return -EINVAL;
@@ -901,27 +898,57 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 					    TYPECAST_REQ_FIELD);
 			return -EINVAL;
 		}
-
-		ctx->nested_level++;
-		if (ctx->nested_level > TRACEPROBE_MAX_NESTED_LEVEL) {
-			trace_probe_log_err(ctx->offset, TOO_MANY_NESTED);
-			return -E2BIG;
+		/* Skip '(' */
+		ctx->offset += 1;
+		tmp++;
+	} else if (*tmp == '+' || *tmp == '-') {
+		/* Dereference can have another field access inside it. */
+		char *open = strchr(tmp + 1, '(');
+
+		if (!open) {
+			trace_probe_log_err(ctx->offset,
+					    DEREF_NEED_BRACE);
+			return -EINVAL;
 		}
-		*close = '\0';
+		close = find_matched_close_paren(open);
+		if (!close) {
+			trace_probe_log_err(ctx->offset + strlen(tmp),
+					    DEREF_OPEN_BRACE);
+			return -EINVAL;
+		}
+		close++;
+		/* We expect a field access for typecast */
+		if (close[0] != '-' || close[1] != '>') {
+			trace_probe_log_err(ctx->offset + close - tmp + 1,
+					    TYPECAST_REQ_FIELD);
+			return -EINVAL;
+		}
+	} else {
+		/* Inner variable name */
+		close = strchr(tmp, '-');
+		if (!close || close[1] != '>') {
+			trace_probe_log_err(ctx->offset + strlen(tmp),
+					    TYPECAST_REQ_FIELD);
+			return -EINVAL;
+		}
+	}
+	*close = '\0';
 
-		ctx->offset += 1;	/* for the '(' */
-		/* We need to parse the nested one */
-		ret = parse_probe_arg(tmp + 1, find_fetch_type(NULL, ctx->flags),
-				pcode, end, ctx);
-		if (ret < 0)
-			return ret;
-		ctx->nested_level--;
-		clear_struct_btf(ctx);
+	/* We need to parse the nested one */
+	ret = parse_probe_arg(tmp, find_fetch_type(NULL, ctx->flags),
+			      pcode, end, ctx);
+	if (ret < 0)
+		return ret;
+	ctx->nested_level--;
+	clear_struct_btf(ctx);
 
-		tmp = close + 3;/* Skip "->" after closing parenthesis */
-		nested = true;
-	}
+	/* Let tmp point the field name. */
+	if (close[1] == '-')
+		tmp = close + 3; /* Skip "->" after closing parenthesis */
+	else
+		tmp = close + 2; /* Skip ">" after inner variable name */
 
+	/* resolve the typecast struct name */
 	ret = query_btf_struct(arg + 1, ctx);
 	if (ret < 0) {
 		trace_probe_log_err(orig_offset + 1, NO_PTR_STRCT);
@@ -929,11 +956,7 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 	}
 
 	ctx->offset = orig_offset + tmp - arg;
-	/* If it is nested, tmp points to the field name. */
-	if (nested)
-		ret = parse_btf_field(tmp, ctx->last_struct, pcode, end, ctx);
-	else
-		ret = parse_btf_arg(tmp, pcode, end, ctx);
+	ret = parse_btf_field(tmp, ctx->last_struct, pcode, end, ctx);
 	return ret;
 }
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 1515b3dda5be..e66e0fcb91a3 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -455,6 +455,7 @@ struct traceprobe_parse_context {
 	int nested_level;
 };
 
+/* Each typecast consumes nested level. So the max number of typecast is 3. */
 #define TRACEPROBE_MAX_NESTED_LEVEL 3
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,

