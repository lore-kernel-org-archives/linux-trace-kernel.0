Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE937F312;
	Tue, 28 Jul 2026 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213618; cv=none; b=bifbGc3R8ZO4SPO4V0Ah7QX+lD1MlnlLiFKnvoUTb/jBzJm7J5XmIUj2EszCXoDwJg6iWRm42GkgEYwqCN/NvZjTUnD6U+6/whXF/MDOtYfXwh+ZMygVGGg4Oi5ocMNwHvh9XntTvcWKKka7VdGJbuV5pKOM0ywrl+KFlZNLl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213618; c=relaxed/simple;
	bh=GUe+fe2zsoqxXgCgJ5nu5gU+bLJEBlQhpmkR1E8JgpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DEzYYDbOG2ZQsU+Hz4hwdJWNgfZzBhbJx3tia38CfFj9LTUtuhcSlnndAQCCkJiVxfd9Fl+1MYBtYb7xPdEPNmFck/iame0rBPdZS4JX5ik6TV42/U7ggnzdnVS7X3ZLn/rr3cccBRrvAdXGh84NCkYLxi8ryZIePDF2DgFej7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzekOOO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzekOOO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F251F000E9;
	Tue, 28 Jul 2026 04:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785213615;
	bh=B+GEo6EbNu+WbI9rxL6HSXoSE0/vc1WxlUJRyPpSIuc=;
	h=From:To:Cc:Subject:Date;
	b=WzekOOO3u7hehKM8IpzIudu8Dd4SNhgcjq44bUfml6xbQnRr23SIExZx7+t5LSAW4
	 M7LpD2XYk4YKTnvRHHUfZciXQlfJ/BgHzbZe9Ojs/DmAtIt10zmAQ1QuuJVIJ8WMv6
	 mxfzRnipae4lK2UDNlnnjb1CuhpU7HrGeJ9dhLDo6lqp6w/JE+yiJNwJCA9eIP+bP3
	 QPvJevWIzZfRVksGAjbF3ik/8O+Isz0jvNBXtDaYE/Os9vNptdnzwNrKTabkfJo9pk
	 F+w4Yk46EVSiN5yEl/q0eTKJEFTJiIXOtepaK3ird3t5u//MPgBot2dXJY333KmTJG
	 bOdhVbnMQWpcA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: [PATCH] tracing/probes: Treating longer symbol name on event comparation
Date: Tue, 28 Jul 2026 13:40:11 +0900
Message-ID: <178521361102.34226.9650586522488974115.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

MAX_COMMON_HEAD_LEN (63) was used to allocate a temporary buffer for
formatting command heads in trace_kprobe_match_command_head() and
trace_uprobe_match_command_head(). However, the buffer size is too
short for some longer symbols. Especially, with rust code, the symbol
can be mangled and become very long.

Refactor trace_kprobe_match_command_head() to perform direct string
comparisons using strcmp() and strncmp(), eliminating the need for a
temporary buffer and removing the MAX_COMMON_HEAD_LEN string length
restriction on probe symbol names.

For trace_uprobe_match_command_head(), since tu->filename is already
matched via strncmp(), use a fixed 64-byte stack buffer solely for
formatting offset and ref_ctr_offset (which requires at most 39 bytes).

With all users converted, remove the MAX_COMMON_HEAD_LEN definition from
trace_probe.h.

Reported-by: Zhan Xusheng <zhanxusheng1024@gmail.com>
Link: https://lore.kernel.org/all/20260724023317.624074-1-zhanxusheng@xiaomi.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
base-commit: 5be3a9db600853578559681b2dd20a9bc7dd4fc5
---
 kernel/trace/trace_kprobe.c |   24 ++++++++++++++++--------
 kernel/trace/trace_probe.h  |    1 -
 kernel/trace/trace_uprobe.c |    2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c25f902aa1a6..e41a7c113646 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -149,20 +149,28 @@ static bool trace_kprobe_is_busy(struct dyn_event *ev)
 static bool trace_kprobe_match_command_head(struct trace_kprobe *tk,
 					    int argc, const char **argv)
 {
-	char buf[MAX_COMMON_HEAD_LEN + 1];
+	char buf[32];
+	int len;
 
 	if (!argc)
 		return true;
 
-	if (!tk->symbol)
+	if (!tk->symbol) {
 		snprintf(buf, sizeof(buf), "0x%p", tk->rp.kp.addr);
-	else if (tk->rp.kp.offset)
-		snprintf(buf, sizeof(buf), "%s+%u",
-			 trace_kprobe_symbol(tk), tk->rp.kp.offset);
-	else
-		snprintf(buf, sizeof(buf), "%s", trace_kprobe_symbol(tk));
-	if (strcmp(buf, argv[0]))
+		if (strcmp(buf, argv[0]))
+			return false;
+	} else if (tk->rp.kp.offset) {
+		len = strlen(trace_kprobe_symbol(tk));
+		if (strncmp(trace_kprobe_symbol(tk), argv[0], len) ||
+		    argv[0][len] != '+')
+			return false;
+
+		snprintf(buf, sizeof(buf), "%u", tk->rp.kp.offset);
+		if (strcmp(buf, &argv[0][len + 1]))
+			return false;
+	} else if (strcmp(trace_kprobe_symbol(tk), argv[0]))
 		return false;
+
 	argc--; argv++;
 
 	return trace_probe_match_command_args(&tk->tp, argc, argv);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index c0f05763811c..fba1af092a9b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -33,7 +33,6 @@
 
 #define MAX_TRACE_ARGS		128
 #define MAX_ARGSTR_LEN		255
-#define MAX_COMMON_HEAD_LEN	63
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
 #define MAX_BTF_ARGS_LEN	128
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 67bd8fd91e3e..861d857adadb 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -281,7 +281,7 @@ static bool trace_uprobe_is_busy(struct dyn_event *ev)
 static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
 					    int argc, const char **argv)
 {
-	char buf[MAX_COMMON_HEAD_LEN + 1];
+	char buf[64];
 	int len;
 
 	if (!argc)

