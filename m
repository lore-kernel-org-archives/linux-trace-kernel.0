Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B332253B0;
	Mon, 15 Jun 2026 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486061; cv=none; b=Ijx/yEjizL611UoQDmfI8d1FkUeQ6XYm/f4g0HFaouz5IXmSvo9ofriM5ZpItXJfcOqqcdisd3Ku3ZkkW/xOhDI/1gN5kD1czMAFCcvNoucSD1CTarHTc12eRohTPN4DhDVDZ7fuFilQaPySlQa8BFCFDBmfO+W2cFo1xlvlP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486061; c=relaxed/simple;
	bh=YfIa3Hr4r6NuTu4xZ2plP1j1jkTYOc4WNbzul/0RyzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJn8N2HVAIdFQW+IQUqPf77ws+Dg1zOBuM4YMQswcEXtmSTF+yFs89XBRejn4jXWHioTmAZCPkbgmd1WgSvGESvV8Kkjab5jDMpX4ZXqLM6OKoUZ9kjd2qmgvUa8dToqI9S9JZxOGZfbQBQFzEBanM3zEH33WXRkNYEPOl/Ievo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmwWfwuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmwWfwuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0957C1F000E9;
	Mon, 15 Jun 2026 01:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781486060;
	bh=NozuaN42qM8btN6q2vJGPq5T+jYqGAZiwp3g6Jnngj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JmwWfwuY8dY13KPFsgfrl+zOvsfdtUFmwlRb4NmVxpJjjlahp1K2az2Ww0JXfSdha
	 CCUCTEMRyjOK6TxROr1ctSlrDW4atkU3pIabH7qyFpVAokdjopCuezwzQalVUUQz+v
	 c25BGgI0+NO/Z9CppXinkUhD4KZEhD9aYWuKRfUUm8QASjj6MnCyJa+CE4ZgzaP6yn
	 8bAh5JMj1FflPG54+HhMDNmcIITwKQycMrA4zrRo8Dut+IR6RnSNssvj6GwS92Th+n
	 +mFMMCBIEP2SppPW3qfVkS/u30QrORQyZ88OvnbKq0Cg4nYY6PJitkS1/1EnwPJQB0
	 8TGoIPhqkMPpw==
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
Subject: [PATCH v4 2/7] tracing/probes: Support typecast for various probe events
Date: Mon, 15 Jun 2026 10:14:15 +0900
Message-ID: <178148605582.185520.1655275732035142368.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178148603548.185520.3389196102475741865.stgit@devnote2>
References: <178148603548.185520.3389196102475741865.stgit@devnote2>
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

but you can not do (this should be enabled by nesting support)

  (STRUCT)%reg->MEMBER

To support other probe events, we just need to use last_struct type
when we find a function parameter in parse_btf_arg().

This also update <tracefs>/README file to show struct typecast.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Clarify the limitation.
 Changes in v2:
  - Fix to re-enable typecast on eprobe.
---
 Documentation/trace/fprobetrace.rst |    3 +++
 Documentation/trace/kprobetrace.rst |    4 ++++
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_probe.c          |   14 +++++++++-----
 kernel/trace/trace_probe.h          |    5 +++++
 5 files changed, 22 insertions(+), 6 deletions(-)

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
index 6eb4d3097a4d..aa93e7b01146 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4325,7 +4325,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
-	"\t           <argname>[->field[->field|.field...]],\n"
+	"\t           [(structname)]<argname>[->field[->field|.field...]],\n"
 #endif
 #else
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index fd1caa1f9723..9158f1f22a62 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -759,7 +759,10 @@ static int parse_btf_arg(char *varname,
 	return -ENOENT;
 
 found:
-	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
+	if (ctx->struct_btf)
+		type = ctx->last_struct;
+	else
+		type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
 found_type:
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
@@ -836,10 +839,11 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
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
index 15758cc11fc6..883938a74aee 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -414,6 +414,11 @@ static inline bool tparg_is_function_return(unsigned int flags)
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

