Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF9386429;
	Tue, 23 Jun 2026 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179112; cv=none; b=evLAun0IysqeFVYb9Tqk97PJtdZGpL0iX95aXEZsseicsO5nsYcRz8oLJwDRnFqhQFJnlkd60fPTUTD/cFtyFLHUBLlIAOpN0kJ7IbC9ZHrcawd+FqvSF99so5yvbS9/3xduolcX8xfPZx+i4L3VONFvNXJ2qJ9UPelKEA4c9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179112; c=relaxed/simple;
	bh=h3KKNTCx5opm5Xc2PGW4UBGeRmXLLdnTKk0JYM3UU2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxyPctNoTvfgEm0W0GYxa8wMNK3yeM4h65wk7VNRftk6sJkHg+xHflKwtO9kKIPgmNcCykmsPRi+dtA+zzTHGNOTIZlKSVeM+YuNQzDJpyFr1bEsLLCSGOJ2FX2lzF3h4zb/5+xHmRCk0LlvCGZSPdy9xlhvW6HME9vT4E53pmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6p7dZJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6p7dZJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411811F000E9;
	Tue, 23 Jun 2026 01:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179111;
	bh=RXhVCOb6Pq6MmOvjeJJObw+CTd3tagr8mrOXi5Ou0jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6p7dZJU+COG2/5Hh1hv4ZIvjZlaotCYQtCtle4ZZDSevkP2y6I4U6/5RiJfxwEPy
	 wG57FBXQMMrbr0AafH32lg1mAGkKymhe0lHcsM/Y/OPtgnrsLc5yJJarIHQwy8kdLP
	 61dEV5uw/XwZFLDNAnWtF6IahkeyrTsPtE0BsQJgHYoY3gzHT0VykYyy4Nd1zTX0MC
	 CauN7cOmQxJxWnuv/kvSfUeWnp2TgcDi9XSkzGwKGGmBkdXQCKNWZCSZ/ik75no8MZ
	 ivz0uFmVDfUdCBKr+QLNOtig6plOYh+H1xqahJle8fM4H7D/+Ag48iVWf7XcwpX9Hw
	 SCpzFtbfwR0aA==
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
Subject: [PATCH v7 06/10] tracing/probes: Type casting always involves nested calls
Date: Tue, 23 Jun 2026 10:45:07 +0900
Message-ID: <178217910709.643090.6379198143797177881.stgit@devnote2>
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
 Changes in v7:
  - Prohibit using @SYM+/-OFFSET without parentheses.
  - Cleanup parse_btf_arg() since ctx->struct_btf is always NULL now.
 Changes in v6:
  - Newly added.
---
 kernel/trace/trace_probe.c |  122 ++++++++++++++++++++++++++------------------
 kernel/trace/trace_probe.h |    4 +
 2 files changed, 74 insertions(+), 52 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e8eae3aab652..2a50a9188c0c 100644
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
@@ -715,13 +702,6 @@ static int parse_btf_arg(char *varname,
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
@@ -766,11 +746,7 @@ static int parse_btf_arg(char *varname,
 	return -ENOENT;
 
 found:
-	if (ctx->struct_btf)
-		type = ctx->last_struct;
-	else
-		type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
-found_type:
+	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 		return -EINVAL;
@@ -867,7 +843,7 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 			   struct traceprobe_parse_context *ctx)
 {
 	int orig_offset = ctx->offset;
-	bool nested = false;
+	char *close;
 	char *tmp;
 	int ret;
 
@@ -878,6 +854,17 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
@@ -886,11 +873,10 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
@@ -901,27 +887,65 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
+		if (tmp[0] == '@') {
+			close = strpbrk(tmp, "+-");
+			if (close && isdigit(close[1])) {
+				trace_probe_log_err(ctx->offset,
+						    TYPECAST_SYM_OFFSET);
+				return -EINVAL;
+			}
+		}
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
@@ -929,11 +953,7 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
index 122d31b1cb14..bc487b366da6 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -453,6 +453,7 @@ struct traceprobe_parse_context {
 	int nested_level;
 };
 
+/* Each typecast consumes nested level. So the max number of typecast is 3. */
 #define TRACEPROBE_MAX_NESTED_LEVEL 3
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
@@ -591,7 +592,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),  \
 	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"), \
 	C(TYPECAST_REQ_FIELD,	"Typecast requires a field access"),	\
-	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"),
+	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"), \
+	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses")
 
 #undef C
 #define C(a, b)		TP_ERR_##a

