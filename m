Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E03749F8;
	Sun, 28 Jun 2026 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782690757; cv=none; b=EafnpaTPiG+UXanh+78ekfhWtthqdwooZas2rTgoZK7fdyZvyuX6hQLh69GUNfu/5dHwId+n/zfxD7g1l/0JX0tzF4QLlH0g5QNpmqokio7V49W40uwlIEeyjKbDz+SUYeyNydYvwx/GWs4ubU5y5sCpf9Gbt2nooNR1ohm/wK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782690757; c=relaxed/simple;
	bh=s7iK5Vnr1A+nfXCc0dUg10Fz3VBELf3c74bst5xJV+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeUYmYKaFksf/agN4rVwKUbPCGZ5FD6gkNDJhD8rM9ttMVWpt/m42TZhtZN7175a9YO6j/y/81LEHYh4IkZYraNUM69kb9fwanZRA4lz8SNi8JYEuN2seTev4tLPD9d5+9vL9Ly2kkf8ghjJZjLYi2A4NBoLsOPu9Vgh7BcQWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxndcnBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxndcnBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBC21F000E9;
	Sun, 28 Jun 2026 23:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782690756;
	bh=G0F3WkDnxAsnJ+ic2fWZoMY8z1J+qJbFouRtZeR2slM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxndcnBgHi635VnqEoP4FdW/CCq1UfH/po9LeqY9NKhMcaO4DLx2wKldljrvtdv1f
	 QQNJYx4PnZiKnQR7lw0kNANoNTmQlGh9HE5JhSB4obB0HnPPrQH+GyylZzpdAwj2TN
	 zlE5eQc4dV4+CEHHMTCji04x9AzOfVAzgNXOu/Oz9Kud+XdlHhBcAWCrWQKJ+g0LsG
	 wVSFOYaT82hvR/zopOV5eQwVLmlYCZE3oIsuv1EXsfPqQzFKC/yFaOBXD5MsInJyN0
	 PlTtUYkUdw8eWU+AO495aR35hb5aTRm2O7ojF08xCo4+ERVEQ7AJ7cRCtmKJlZMDm5
	 JhfuArZQ3+ZKg==
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
Subject: [PATCH v12 07/11] tracing/probes: Type casting always involves nested calls
Date: Mon, 29 Jun 2026 08:52:32 +0900
Message-ID: <178269075202.1161310.12069574650324434766.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178269068329.1161310.17763177188897860801.stgit@devnote2>
References: <178269068329.1161310.17763177188897860801.stgit@devnote2>
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

Note that @SYM+/-OFFSET with typecast needs parentheses like:
  - (STRUCT)(@SYM-8)->FIELD

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Fix caret position in error case.
  - Add a comment about @SYM+/-OFFSET without parentheses.
 Changes in v7:
  - Prohibit using @SYM+/-OFFSET without parentheses.
  - Cleanup parse_btf_arg() since ctx->struct_btf is always NULL now.
 Changes in v6:
  - Newly added.
---
 kernel/trace/trace_probe.c |  123 ++++++++++++++++++++++++++------------------
 kernel/trace/trace_probe.h |    4 +
 2 files changed, 75 insertions(+), 52 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 827ae04f6351..1b97b125e9cb 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -684,19 +684,6 @@ static int parse_btf_arg(char *varname,
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
@@ -708,13 +695,6 @@ static int parse_btf_arg(char *varname,
 			tid = ctx->proto->type;
 			goto found;
 		}
-		/*
-		 * Even if we can not find appropriate BTF info, we can still access
-		 * the field via typecast.
-		 */
-		if (ctx->struct_btf)
-			goto found;
-
 		if (field) {
 			trace_probe_log_err(ctx->offset + field - varname,
 					    NO_BTF_ENTRY);
@@ -759,11 +739,7 @@ static int parse_btf_arg(char *varname,
 	return -ENOENT;
 
 found:
-	if (ctx->struct_btf)
-		type = ctx->last_struct;
-	else
-		type = btf_type_skip_modifiers(ctx->btf, tid, NULL);
-found_type:
+	type = btf_type_skip_modifiers(ctx->btf, tid, NULL);
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 		return -EINVAL;
@@ -860,7 +836,7 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 			   struct traceprobe_parse_context *ctx)
 {
 	int orig_offset = ctx->offset;
-	bool nested = false;
+	char *close;
 	char *tmp;
 	int ret;
 
@@ -871,6 +847,17 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
@@ -879,11 +866,10 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
@@ -894,27 +880,66 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
+		}
+		close = find_matched_close_paren(open);
+		if (!close) {
+			trace_probe_log_err(ctx->offset + strlen(tmp),
+					    DEREF_OPEN_BRACE);
+			return -EINVAL;
+		}
+		close++;
+		/* We expect a field access for typecast */
+		if (close[0] != '-' || close[1] != '>') {
+			trace_probe_log_err(ctx->offset + close - tmp,
+					    TYPECAST_REQ_FIELD);
+			return -EINVAL;
+		}
+	} else {
+		if (tmp[0] == '@') {
+			/* @sym+offset is not allowed without parenthesized */
+			close = strpbrk(tmp, "+-");
+			if (close && isdigit(close[1])) {
+				trace_probe_log_err(ctx->offset,
+						    TYPECAST_SYM_OFFSET);
+				return -EINVAL;
+			}
 		}
-		*close = '\0';
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
@@ -922,11 +947,7 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
index 7d71925244e8..f4fbe3010978 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -453,6 +453,7 @@ struct traceprobe_parse_context {
 	int nested_level;
 };
 
+/* Each typecast consumes nested level. So the max number of typecast is 3. */
 #define TRACEPROBE_MAX_NESTED_LEVEL 3
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
@@ -592,7 +593,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),  \
 	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"), \
 	C(TYPECAST_REQ_FIELD,	"Typecast requires a field access"),	\
-	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"),
+	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"), \
+	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses")
 
 #undef C
 #define C(a, b)		TP_ERR_##a

