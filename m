Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85F37C10C;
	Fri, 26 Jun 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483311; cv=none; b=lHOifKuqzD1y0L4p+NpZUqsw4A1Ebf8GaOi2OXqBnm/iGz0/iQ9W/J+m/wNaLFYP8nc082T9vYQbdNx7q7a2TmQlVB6BjdBhz+ZASZE+T1o61Fc/CR/LJHDUhsuxNxACc5JoICamMhNPOj9Dc+hUr7pI8MlrplsQlwQFVm/f/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483311; c=relaxed/simple;
	bh=O9xG2z+EFR+eRHAxrXpB7iM2ieNX3YhCuZhXD79qljQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMu0zHmsCg0TvAx50CtSq4898+p61Ldc5LdE7BGLBEwMbyHkdA8U7nNvE6PhWVphBN0tX4iUuSGbCPODIgcOgpJWpX7jZXZsbHUrMSleYngLr63Xy0qzEFTQweEiTccmJNxKf2Hn68WbKAcNbb8HMzxYEA78LyYZR4tTn3o72uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CELlmzP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CELlmzP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C201F000E9;
	Fri, 26 Jun 2026 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782483309;
	bh=5bW0GTnmvIpAldxgyCiZYrRAz0izEcnXpJfTh/lMxjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CELlmzP9rjupzZldRsaR8iaAXDNs4cKSX1Q7v9kAFD7KprG+ewgUhWHzonne83xDS
	 LiP+BSaHSkFmCb3UWvnDY2lrTz1AbujTat3nAE1YZUKUijiMjswnXBxcs24C0yaEf3
	 h1GbnU91HYe8LVQHeWYCk0w3A9/dEp7yZ4Ai5mTwJ0+AldZhCHleJW4NRpr6v21KRh
	 dvmL3DczQCYthZlpzBaaAyl65eHkuzM7UoM097NfZRJwBEVKLi8WhhplWVzSRAcnTy
	 11co2TeuTz5JeoewQyLQLFiehN6te24gVUSgkHNAsMk0o8nSImsJyqpin8sKpdGaPK
	 aSc8uc5uhpwZw==
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
Subject: [PATCH v11 05/11] tracing/probes: Support typecast for various probe events
Date: Fri, 26 Jun 2026 23:15:05 +0900
Message-ID: <178248330564.841606.15954758183438726969.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178248325671.841606.17344906774310339507.stgit@devnote2>
References: <178248325671.841606.17344906774310339507.stgit@devnote2>
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

Support BTF typecast feature on other probe events, but only if it is
kernel function entry or return, and must use function parameter name
or $retval. This means you can do:

  (STRUCT)PARAM->MEMBER

Note: you can not use other variables like $stackN, %reg etc. That
needs nesting support.

To support other probe events, we just need to use last_struct type
when we find a function parameter in parse_btf_arg().

This also updates <tracefs>/README file to show struct typecast.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v5:
  - Add comments about $retval with typecast.
  - Even if the type of retvalue is not known, if user specifies typecast,
    use it for its type.
 Changes in v3:
  - Clarify the limitation.
 Changes in v2:
  - Fix to re-enable typecast on eprobe.
---
 Documentation/trace/fprobetrace.rst |    3 +++
 Documentation/trace/kprobetrace.rst |    4 ++++
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_probe.c          |   23 +++++++++++++++++------
 kernel/trace/trace_probe.h          |    5 +++++
 5 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index b4c2ca3d02c1..7435ded2d66d 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -57,6 +57,9 @@ Synopsis of fprobe-events
                   (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
                   (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
                   and bitfield are supported.
+  (STRUCT)FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
+                  a pointer to STRUCT and then derference the pointer defined by
+                  ->MEMBER.
 
   (\*1) This is available only when BTF is enabled.
   (\*2) only for the probe on function entry (offs == 0). Note, this argument access
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 3b6791c17e9b..f73614997d52 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -61,6 +61,10 @@ Synopsis of kprobe_events
 		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
                   "string", "ustring", "symbol", "symstr" and bitfield are
                   supported.
+  (STRUCT)FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
+                  a pointer to STRUCT and then derference the pointer defined by
+                  ->MEMBER. Note that this is available only when the probe is
+		   on function entry.
 
   (\*1) only for the probe on function entry (offs == 0). Note, this argument access
         is best effort, because depending on the argument type, it may be passed on
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1146b83b711a..280a3dccd13f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4322,7 +4322,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
-	"\t           <argname>[->field[->field|.field...]],\n"
+	"\t           [(structname)]<argname>[->field[->field|.field...]],\n"
 #endif
 #else
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 0908019aea12..e6cc9f3d6c8b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -699,7 +699,7 @@ static int parse_btf_arg(char *varname,
 
 	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
 		code->op = FETCH_OP_RETVAL;
-		/* Check whether the function return type is not void */
+		/* Check whether the function return type is not void, even with typecast. */
 		if (query_btf_context(ctx) == 0) {
 			if (ctx->proto->type == 0) {
 				trace_probe_log_err(ctx->offset, NO_RETVAL);
@@ -708,6 +708,13 @@ static int parse_btf_arg(char *varname,
 			tid = ctx->proto->type;
 			goto found;
 		}
+		/*
+		 * Even if we can not find appropriate BTF info, we can still access
+		 * the field via typecast.
+		 */
+		if (ctx->struct_btf)
+			goto found;
+
 		if (field) {
 			trace_probe_log_err(ctx->offset + field - varname,
 					    NO_BTF_ENTRY);
@@ -752,7 +759,10 @@ static int parse_btf_arg(char *varname,
 	return -ENOENT;
 
 found:
-	type = btf_type_skip_modifiers(ctx->btf, tid, NULL);
+	if (ctx->struct_btf)
+		type = ctx->last_struct;
+	else
+		type = btf_type_skip_modifiers(ctx->btf, tid, NULL);
 found_type:
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
@@ -829,10 +839,11 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 	char *tmp;
 	int ret;
 
-	/* Currently this only works for eprobes */
-	if (!(ctx->flags & TPARG_FL_TEVENT)) {
-		trace_probe_log_err(ctx->offset, TYPECAST_NOT_EVENT);
-		return -EINVAL;
+	if (!(tparg_is_event_probe(ctx->flags) ||
+	      tparg_is_function_entry(ctx->flags) ||
+	      tparg_is_function_return(ctx->flags))) {
+		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
+		return -EOPNOTSUPP;
 	}
 
 	tmp = strchr(arg, ')');
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index e36cfe39e9a8..aa72e2ffdd93 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -429,6 +429,11 @@ static inline bool tparg_is_function_return(unsigned int flags)
 	return (flags & TPARG_FL_LOC_MASK) == (TPARG_FL_KERNEL | TPARG_FL_RETURN);
 }
 
+static inline bool tparg_is_event_probe(unsigned int flags)
+{
+	return !!(flags & TPARG_FL_TEVENT);
+}
+
 struct traceprobe_parse_context {
 	struct trace_event_call *event;
 	/* BTF related parameters */

