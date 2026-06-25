Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8290256D;
	Thu, 25 Jun 2026 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350793; cv=none; b=eBmNYITENc5q8UjvokR/jN2awkMjXS/XjuMcIK6ef3kyH+uC/cTj6/jOIPgQt48em0GX3SjCB+J5fazd4uw0ATUF3wu4DEElzPPhwdi2dBxLPh0okmEDr7hwJ1o0O5fKISsJ3lTkRupSOGGZPeW9qXl1e2BAXXtRlZLwDulZ1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350793; c=relaxed/simple;
	bh=l2uvPfQXmGFO+0/LT6+YK1OHndjdT4AlMuebdGffRLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h32XqdT+aaui88O7kT4/8mzbbOoB0HZQMd8k4SAgj5jS4NT8p1FOlEMb9KFWeoLaiJG6ekboLBodjnXXmKdWplzjcVNZq6r7fUc5KMThY/IVVp0As8Dvxm1ZHjRPxo3aC3Li6GrY/GSkfjFZAFasPaZ0eX5+MezObuox7c/J91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqQQZQDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqQQZQDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27421F000E9;
	Thu, 25 Jun 2026 01:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782350791;
	bh=8vkHSf/m3diAAbvgSUUkcBpHiiO1Z5fNx5oyO7nJ/cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqQQZQDGNCnXjBD7HurmIvEosFvi9HdmGZyYbcrjNMjzJtvkszWDbOPXvEyjsXPAb
	 3Sr9/E1mKguo+B1CKZE9l2nW0wXrTbPkO1f9vcOTJ5ZF2RYGIPTUJcl3qrhWNzR54V
	 U3lsU3XMq3M8wnI7X1Yi8iL87BW9JwTLpWTXLjP2kQQT/Dn146AKJ//XXaG/DjNVU5
	 gKwLF7frUov+Tm/yvA2Y7lgghWEV5yHK03Oe4Iv6yUoL6mhf9yxKKwtjKPUA7b80sM
	 w1YTZgL10CgZb1BgnRFcedrhfEE3aoMAahEhcEXYlV+Sia75291jkyO5NT4DWJ8fuc
	 K+AZeHHAIl55w==
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
Subject: [PATCH v9 4/9] tracing/probes: Support nested typecast
Date: Thu, 25 Jun 2026 10:26:27 +0900
Message-ID: <178235078755.766912.3766306715692698324.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178235074943.766912.25308838431649508.stgit@devnote2>
References: <178235074943.766912.25308838431649508.stgit@devnote2>
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

When we hit an open parenthesis right after typecast closing
parenthesis, it means we have nested typecast. This allows us to
typecast a generic data member in a structure to a pointer to
another structure.

For example, to cast a DATA_MEMBER of VAR structure to STRUCT pointer
and get MEMBER value.

  (STRUCT)(VAR->DATA_MEMBER)->MEMBER

Also, we can nest typecast.

  (STRUCT1)((STRUCT2)$ARG->FIELD2)->FIELD1

Currently the max nest level is limited to 3.

This also allows user to use typecasting for registers or stacks on
kprobe events. e.g.

  (STRUCT)(%ax)->MEMBER

  (STRUCT)($stack0)->MEMBER


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - Add a WARN_ON_ONCE check for leaking nested_level (it must not happen.)
 Changes in v4:
  - Use orig_offset for reporting NO_PTR_STRCT error.
 Changes in v2:
  - Fix to skip "->" after closing parenthetsis.
---
 Documentation/trace/eprobetrace.rst |    2 +
 Documentation/trace/fprobetrace.rst |    2 +
 Documentation/trace/kprobetrace.rst |    2 +
 kernel/trace/trace.c                |    1 
 kernel/trace/trace_probe.c          |   81 ++++++++++++++++++++++++++++++++---
 kernel/trace/trace_probe.h          |    7 +++
 6 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
index fe3602540569..cd0b4aa7f896 100644
--- a/Documentation/trace/eprobetrace.rst
+++ b/Documentation/trace/eprobetrace.rst
@@ -50,6 +50,8 @@ Synopsis of eprobe_events
                   a pointer to STRUCT and then derference the pointer defined by
                   ->MEMBER. Note that when this is used, the FIELD name does not
                   need to be prefixed with a '$'.
+  (STRUCT)(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above can
+		  also be used with another FETCHARG instead of FIELD.
 
 Types
 -----
diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 7435ded2d66d..6b8bb27bb62d 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -60,6 +60,8 @@ Synopsis of fprobe-events
   (STRUCT)FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
                   a pointer to STRUCT and then derference the pointer defined by
                   ->MEMBER.
+  (STRUCT)(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above can
+                 also be used with another FETCHARG instead of FIELD.
 
   (\*1) This is available only when BTF is enabled.
   (\*2) only for the probe on function entry (offs == 0). Note, this argument access
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index f73614997d52..c4382765d5b2 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -65,6 +65,8 @@ Synopsis of kprobe_events
                   a pointer to STRUCT and then derference the pointer defined by
                   ->MEMBER. Note that this is available only when the probe is
 		   on function entry.
+  (STRUCT)(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above can
+                 also be used with another FETCHARG instead of FIELD.
 
   (\*1) only for the probe on function entry (offs == 0). Note, this argument access
         is best effort, because depending on the argument type, it may be passed on
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 280a3dccd13f..e56ee034c486 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4323,6 +4323,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
 	"\t           [(structname)]<argname>[->field[->field|.field...]],\n"
+	"\t           [(structname)](fetcharg)->field[->field|.field...],\n"
 #endif
 #else
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e6cc9f3d6c8b..1d6afda39462 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -832,10 +832,35 @@ static int query_btf_struct(const char *sname, struct traceprobe_parse_context *
 	return 0;
 }
 
+/* Find the matching closing parenthesis for a given opening parenthesis. */
+static char *find_matched_close_paren(char *s)
+{
+	char *p = s;
+	int count = 0;
+
+	while (*p) {
+		if (*p == '(')
+			count++;
+		else if (*p == ')') {
+			if (--count == 0)
+				return p;
+		}
+		p++;
+	}
+	return NULL;
+}
+
+static int
+parse_probe_arg(char *arg, const struct fetch_type *type,
+		struct fetch_insn **pcode, struct fetch_insn *end,
+		struct traceprobe_parse_context *ctx);
+
 static int handle_typecast(char *arg, struct fetch_insn **pcode,
 			   struct fetch_insn *end,
 			   struct traceprobe_parse_context *ctx)
 {
+	int orig_offset = ctx->offset;
+	bool nested = false;
 	char *tmp;
 	int ret;
 
@@ -852,19 +877,56 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 				    DEREF_OPEN_BRACE);
 		return -EINVAL;
 	}
-	*tmp = '\0';
-	ret = query_btf_struct(arg + 1, ctx);
-	*tmp = ')';
+	*tmp++ = '\0';
+
+	/* Handle the nested structure like (STRUCT)(VAR->FIELD)->... */
+	if (*tmp == '(') {
+		char *close = find_matched_close_paren(tmp);
 
+		ctx->offset += tmp - arg;
+		if (!close) {
+			trace_probe_log_err(ctx->offset, DEREF_OPEN_BRACE);
+			return -EINVAL;
+		}
+		/* We expect a field access for typecast */
+		if (close[1] != '-' || close[2] != '>') {
+			trace_probe_log_err(ctx->offset + close - tmp + 1,
+					    TYPECAST_REQ_FIELD);
+			return -EINVAL;
+		}
+
+		ctx->nested_level++;
+		if (ctx->nested_level > TRACEPROBE_MAX_NESTED_LEVEL) {
+			trace_probe_log_err(ctx->offset, TOO_MANY_NESTED);
+			return -E2BIG;
+		}
+		*close = '\0';
+
+		ctx->offset += 1;	/* for the '(' */
+		/* We need to parse the nested one */
+		ret = parse_probe_arg(tmp + 1, find_fetch_type(NULL, ctx->flags),
+				pcode, end, ctx);
+		if (ret < 0)
+			return ret;
+		ctx->nested_level--;
+		clear_struct_btf(ctx);
+
+		tmp = close + 3;/* Skip "->" after closing parenthesis */
+		nested = true;
+	}
+
+	ret = query_btf_struct(arg + 1, ctx);
 	if (ret < 0) {
-		trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
+		trace_probe_log_err(orig_offset + 1, NO_PTR_STRCT);
 		return -EINVAL;
 	}
 
-	tmp++;
-
-	ctx->offset += tmp - arg;
-	ret = parse_btf_arg(tmp, pcode, end, ctx);
+	ctx->offset = orig_offset + tmp - arg;
+	/* If it is nested, tmp points to the field name. */
+	if (nested)
+		ret = parse_btf_field(tmp, ctx->last_struct, pcode, end, ctx);
+	else
+		ret = parse_btf_arg(tmp, pcode, end, ctx);
 	return ret;
 }
 
@@ -1638,6 +1700,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			      ctx);
 	if (ret < 0)
 		goto fail;
+	/* nested_level must be 0 here, otherwise there is a bug. */
+	if (WARN_ON_ONCE(ctx->nested_level))
+		goto fail;
 
 	/* Update storing type if BTF is available */
 	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index aa72e2ffdd93..7d71925244e8 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -450,8 +450,11 @@ struct traceprobe_parse_context {
 	struct trace_probe *tp;
 	unsigned int flags;
 	int offset;
+	int nested_level;
 };
 
+#define TRACEPROBE_MAX_NESTED_LEVEL 3
+
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				      const char *argv,
 				      struct traceprobe_parse_context *ctx);
@@ -587,7 +590,9 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
 	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
 	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),  \
-	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"),
+	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"), \
+	C(TYPECAST_REQ_FIELD,	"Typecast requires a field access"),	\
+	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

