Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669693D16E2;
	Mon,  8 Jun 2026 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928672; cv=none; b=iRW5OznlThQJFX3JdxLLkT6ysKgUWWhF15hEtw/PWTGBMkoK6T+eSd57bRJrUzOz1yBLdPD1KcenDQe33TxUKu8yWm1RkpqRhxgul04xENHmjspIBv8XatDBII+Jy9qxhpnwcvmpsopJyH/eOcfXdM/rvCNtQ5Mx7mqOsKJDifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928672; c=relaxed/simple;
	bh=V0c+IyF3SscrcA6Rf9PobeT44GuZn6nth30MNP0OUkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ52ggVUCIBuLanPf2mgd9L9js4yNORWy2SkaVwPgAkdHIohKY9FybPgfKu7YaoDzYrNOtPI18b6m2/L2et8aD4lxJFP8MwUr0wS4vPRyhJPZ8B+FSPzRKw8C28VD8pewFKLi1odGeUe1OezhUbyllZBJwgXS99Syl0xRN5dvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAVuL7iG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAVuL7iG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8BE1F00893;
	Mon,  8 Jun 2026 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928671;
	bh=y2S0cH7Hc5ycetv8oxZAkbKoW30tIBWPCidb4Za0kqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MAVuL7iGEFS8S4rELvRF9IWcrU7Ph/6KLLbfrhc0gz8G9tkXLEb5s6zScLEZOX/Of
	 KW1NhEzlgD6JvQGDQEm+zNjhm6yicJcI7eGZrH2ocnz9+ePyTKlqMglWWRqeZbWLE6
	 /qct2oSBnRvLIkBBsT18EQfpBlG9hvHekwe/Mbzfu4hMrTu+w8Po0ch9+Z+nIJ8+dP
	 TA3lNqHU+Vz4rzhdrjLyocG4dGlLDs9scZ6f3vZvJ65uVcGiI3cZNOdj5QEyTFpi+w
	 RqinfXMsVOfVsiZ678ZJpAzYSkOBNvfBVzoLD+gTlM7tSFY1zxNsZ9MUtKZLDXI2Kh
	 WNnOi+K2setnA==
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
Subject: [RFC PATCH 1/7] tracing/probes: Support typecast for various probe events
Date: Mon,  8 Jun 2026 23:24:26 +0900
Message-ID: <178092866688.163648.6670468618889245533.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178092865666.163648.10457567771536160909.stgit@devnote2>
References: <178092865666.163648.10457567771536160909.stgit@devnote2>
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

Support BTF typecast feature on other probe events (but only if it is
kernel function entry or return.)

To support other probe events, we just need to use last_struct type
when we find a function parameter in parse_btf_arg().

This also update <tracefs>/README file to show struct typecast.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobetrace.rst |    3 +++
 Documentation/trace/kprobetrace.rst |    4 ++++
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_probe.c          |   12 +++++++-----
 4 files changed, 15 insertions(+), 6 deletions(-)

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
index fd1caa1f9723..609b156986c5 100644
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
@@ -836,10 +839,9 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 	char *tmp;
 	int ret;
 
-	/* Currently this only works for eprobes */
-	if (!(ctx->flags & TPARG_FL_TEVENT)) {
-		trace_probe_log_err(ctx->offset, TYPECAST_NOT_EVENT);
-		return -EINVAL;
+	if (!(tparg_is_function_entry(ctx->flags) || tparg_is_function_return(ctx->flags))) {
+		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
+		return -EOPNOTSUPP;
 	}
 
 	tmp = strchr(arg, ')');

