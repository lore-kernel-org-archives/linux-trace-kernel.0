Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464F3EFFAE;
	Fri, 26 Jun 2026 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483272; cv=none; b=FGknDZsX1I6b2CmCYso5dg+VZUZEfQglLjXdCeiepl0jLmO00s4BfcGgKnHZlQHPgXfkyzRwGQrZLBqLxVHS+18jO3z+Cfv6Vlwr5vJpJDRz7hzjuskFce4AtXFYVtFzk5DdVTUeaC4J156gmX/WU22hS/4HjlxdRmIy3sxn6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483272; c=relaxed/simple;
	bh=ILB/ElfIWa9u0xQ12aAYqyj8anSCHxMnZsNP9BRN1oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaC/9gFMsCIOqU895+rT/xdardSC3kekKLjP9PNfbR6ApoVT96hhSIrRDjk6DP7UaNscv3BHGk2FfUJk+pwBNW0n3zomnODpg8C7rtpHZtAATU/IAk2VnAqHXCM0jgP0GdF/zx8v7wxUK/pkitbhyhCjqubjyOxTpFRnXI9HEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHSkm1Pq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHSkm1Pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B425B1F00A3D;
	Fri, 26 Jun 2026 14:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782483271;
	bh=zA1ny7mz86qD9VEgfTKY9l9S9cY7unn92daWUtN0ORY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WHSkm1Pqp32TDMD98U2dsB0jvyLGZNUrC7D3K4aI5nkKxlo38YZzX6FZJ7Q0U1Xx/
	 s9cOooDptDT0zdbJluyJEQm+m7vKqSwRWfLNOYPfAyM0nVVay+QR0+XBPjlw2SXiY1
	 4R65lKzqQL5ryNU1upjrFIRMl8dpaF9HHhU7wqeMABmMQptW47E0H+0Oqdfmtk6t21
	 RJB86rL5AaIZI4naMlCNCfI++iyLXf6L3R8F7Lux/WZNFSR2W4hrHVh3h8YE4BpZR5
	 GZ5YSDSXQu9RsC/a634SXNWU8DzpjLp4lt4Q/C5xC15LHHcWucYuVxB+F/At2PG1Xf
	 BXePjSd7di7gw==
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
Subject: [PATCH v11 01/11] tracing/probes: Allow eprobe to use variable without $ prefix
Date: Fri, 26 Jun 2026 23:14:26 +0900
Message-ID: <178248326672.841606.5469594713059767810.stgit@devnote2>
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

The commit 69efd863a785 ("tracing/eprobes: Allow use of BTF names
to dereference pointers") allows eprobe to use event field without
"$" prefix when it is used with typecast, it is natual to allow it
without typecast.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Newly added.
---
 kernel/trace/trace_probe.c                         |   12 +++++++++++-
 kernel/trace/trace_probe.h                         |    1 +
 .../test.d/dynevent/eprobes_syntax_errors.tc       |    3 +--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 0da7c0b53ba7..2ce7d62471cb 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1341,7 +1341,17 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		ret = handle_typecast(arg, pcode, end, ctx);
 		break;
 	default:
-		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
+		if (isalpha(arg[0]) || arg[0] == '_') {
+			/* BTF variable or event field*/
+			if (ctx->flags & TPARG_FL_TEVENT) {
+				ret = parse_trace_event(arg, *pcode, ctx);
+				if (ret < 0) {
+					trace_probe_log_err(ctx->offset,
+							    NO_EVENT_FIELD);
+					return -EINVAL;
+				}
+				break;
+			}
 			if (!tparg_is_function_entry(ctx->flags) &&
 			    !tparg_is_function_return(ctx->flags)) {
 				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 40b53b5b58a9..2e0d8384ee5c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -559,6 +559,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_PTR_STRCT,		"This is not a pointer to union/structure."),	\
 	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),\
 	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
+	C(NO_EVENT_FIELD,	"This event field is not found."),	\
 	C(NO_BTF_FIELD,		"This field is not found."),	\
 	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
index 2a680c086047..0e65e787e426 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
@@ -10,7 +10,7 @@ check_error() { # command-with-error-pos-by-^
 check_error 'e ^a.'			# NO_EVENT_INFO
 check_error 'e ^.b'			# NO_EVENT_INFO
 check_error 'e ^a.b'			# BAD_ATTACH_EVENT
-check_error 'e syscalls/sys_enter_openat ^foo'	# BAD_ATTACH_ARG
+check_error 'e syscalls/sys_enter_openat ^foo'	# NO_EVENT_FIELD
 check_error 'e:^/bar syscalls/sys_enter_openat'	# NO_GROUP_NAME
 check_error 'e:^12345678901234567890123456789012345678901234567890123456789012345/bar syscalls/sys_enter_openat'	# GROUP_TOO_LONG
 
@@ -19,7 +19,6 @@ check_error 'e:^ syscalls/sys_enter_openat'		# NO_EVENT_NAME
 check_error 'e:foo/^12345678901234567890123456789012345678901234567890123456789012345 syscalls/sys_enter_openat'	# EVENT_TOO_LONG
 check_error 'e:foo/^bar.1 syscalls/sys_enter_openat'	# BAD_EVENT_NAME
 
-check_error 'e:foo/bar syscalls/sys_enter_openat arg=^dfd'	# BAD_FETCH_ARG
 check_error 'e:foo/bar syscalls/sys_enter_openat arg=^$foo'	# BAD_ATTACH_ARG
 
 if grep -q '<attached-group>\.<attached-event>.*\[if <filter>\]' README; then

