Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA636F8F1;
	Mon, 13 Jul 2026 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927704; cv=none; b=NMbvrBCV1UiSPEfz4LizAA4rmU7AwLfY78+eImyzm5MTRWVCBtYeWm5RxiZn0v3hmY952kdB0G2G8Hx+u+eEtjCS7TxqBsU2l/oNfwwD+rrAt1rN3Fu10mLtc93UfBg4l7g6C38VLygtraebhtq27UWAdg0ePQcqRO3JKzMTz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927704; c=relaxed/simple;
	bh=ANvE8llAdzDP9c8mDycRInCbne15+pbtq+cxKv+VHMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oW7jnUCJPs3Ys0804BvkfVAZZN897WzjCMSHCAmRU1cy+xQDWfcgQ8+7q2QPeP91xZrvBuYShxdC+PeZlCwKp9yix9FNxHsWj1VngH2bUmjO+4ndcKxdR3bSxNMfl8DDYRBuhBjnc87MTWA2W/rbMrNcs4MbN+w7YbcjDhl9Rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihr1HkRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihr1HkRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC041F000E9;
	Mon, 13 Jul 2026 07:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927702;
	bh=Egqhsjf9ud4/qwjC3GdkEb3I7uHVjH2JTBx2h3IYAic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ihr1HkRWQaznu2lFTvbokk9NjvktuK36TaFjrJatHCzAp+gW1dWXxQLGOiTyEOodU
	 ttSLIy3NqPCbB5QDqVUiC/fPRBEtdOujDR4ixDdrPy8/lg4XbSCGQGKpZMOwCCxghT
	 TthTG+zeKdyJnsIqNhnrXNRCITqn4LmwO9Yg6t5ywOIs83jWRZcghaaFUFxwHLs2wX
	 WgDrURg+W+p0KPgxsd5sbEBuwgK1K1fhVSSAiOIncHWoNlbQ8d/6I8ePo19abXdZAt
	 /066QnjrtQfQC0DEJfX3PoKZyOMmqU9Hisnqx04pRUsWLflNLZuayhwyU+361T1yJd
	 7quLSiM6L3+tw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/5] tracing/probes: Extend max length of argument string
Date: Mon, 13 Jul 2026 16:28:18 +0900
Message-ID: <178392769822.3229912.2100340337736317320.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178392766002.3229912.15711868107734330750.stgit@devnote2>
References: <178392766002.3229912.15711868107734330750.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

To support BTF argument parsing (such as accessing fields within nested
structures via typecasting), the maximum argument string length needs
to be extended. Extend MAX_ARGSTR_LEN from 63 to 255.

Since MAX_ARGSTR_LEN was previously reused to format command heads in
trace_*probe_match_command_head() functions, introduce a dedicated
MAX_COMMON_HEAD_LEN (63) macro for matching command heads and switch
these functions to use the new macro.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
 - Make the MAX_ARGSTR_LEN to 255 instead of 256.
---
 kernel/trace/trace_fprobe.c                        |    2 +-
 kernel/trace/trace_kprobe.c                        |    2 +-
 kernel/trace/trace_probe.h                         |    3 ++-
 kernel/trace/trace_uprobe.c                        |    2 +-
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    2 +-
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |    2 +-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    2 +-
 7 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 536781cd4c47..5638a90e61cc 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -238,7 +238,7 @@ static bool trace_fprobe_is_busy(struct dyn_event *ev)
 static bool trace_fprobe_match_command_head(struct trace_fprobe *tf,
 					    int argc, const char **argv)
 {
-	char buf[MAX_ARGSTR_LEN + 1];
+	char buf[MAX_COMMON_HEAD_LEN + 1];
 
 	if (!argc)
 		return true;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index cfa807d8e760..cc24e992732c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -149,7 +149,7 @@ static bool trace_kprobe_is_busy(struct dyn_event *ev)
 static bool trace_kprobe_match_command_head(struct trace_kprobe *tk,
 					    int argc, const char **argv)
 {
-	char buf[MAX_ARGSTR_LEN + 1];
+	char buf[MAX_COMMON_HEAD_LEN + 1];
 
 	if (!argc)
 		return true;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index e64e323244a5..e6d427910c4f 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -32,7 +32,8 @@
 #include "trace_output.h"
 
 #define MAX_TRACE_ARGS		128
-#define MAX_ARGSTR_LEN		63
+#define MAX_ARGSTR_LEN		255
+#define MAX_COMMON_HEAD_LEN	63
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
 #define MAX_BTF_ARGS_LEN	128
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b2e264a4b96c..67bd8fd91e3e 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -281,7 +281,7 @@ static bool trace_uprobe_is_busy(struct dyn_event *ev)
 static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
 					    int argc, const char **argv)
 {
-	char buf[MAX_ARGSTR_LEN + 1];
+	char buf[MAX_COMMON_HEAD_LEN + 1];
 	int len;
 
 	if (!argc)
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index e9d7e6919c7f..984ab94df213 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -75,7 +75,7 @@ check_error 'f vfs_read ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_L
 check_error 'f vfs_read ^=@11'			# NO_ARG_NAME
 check_error 'f vfs_read ^var.1=@11'		# BAD_ARG_NAME
 check_error 'f vfs_read var1=@11 ^var1=@12'	# USED_ARG_NAME
-check_error 'f vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 'f vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))))))))))))))))))))))'	# ARG_TOO_LONG
 check_error 'f vfs_read arg1=^'			# NO_ARG_BODY
 
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
index ffe8ffef4027..2d0905b2c8b7 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
@@ -61,7 +61,7 @@ check_error 't kfree ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
 check_error 't kfree ^=@11'			# NO_ARG_NAME
 check_error 't kfree ^var.1=@11'		# BAD_ARG_NAME
 check_error 't kfree var1=@11 ^var1=@12'	# USED_ARG_NAME
-check_error 't kfree ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 't kfree ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))))))))))))))))))))))'	# ARG_TOO_LONG
 check_error 't kfree arg1=^'			# NO_ARG_BODY
 
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 21ce8414459f..d28f63b7e8a9 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -71,7 +71,7 @@ check_error 'p vfs_read ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_L
 check_error 'p vfs_read ^=@11'			# NO_ARG_NAME
 check_error 'p vfs_read ^var.1=@11'		# BAD_ARG_NAME
 check_error 'p vfs_read var1=@11 ^var1=@12'	# USED_ARG_NAME
-check_error 'p vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 'p vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))))))))))))))))))))))'	# ARG_TOO_LONG
 check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
 
 # instruction boundary check is valid on x86 (at this moment)

