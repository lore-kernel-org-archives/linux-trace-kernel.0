Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150A3C33;
	Wed, 13 Aug 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095418; cv=none; b=j6TwLNyZIW6noLJ16HMGcd+sM/DZ36UFMqoqRChS38lmRz2Dic2MFXM81WJ3LWpalHsUQQ1XYpblhAhljZOcaqhN/4DHAPjgbaJ7WIVWBSyv+vx5aCuycWpcXkk2fTHAHBR4FeRIWqflqCIhbZFiPu2gxfYVvZpz1gvN7LXFWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095418; c=relaxed/simple;
	bh=MYPEj/1UaAR+SG/EgGexa4okmshAoVUJvRwXGzcaCEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHBPVFzItjS359n9y3Gau0JxbDyZPAlO6x59eWAiODJRibroZx9m6qMbuqdQ7QlPR1P2T+bXMUcnTsXdi06iPRsbSlrMIStqZx9b2/gA9PKD49o3V/fVxx/P0tSRR7GCX3oG4gtwT+WMXRLPOTduWHqKA4udyYEztr8e+UsmZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj4BQv+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj4BQv+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D26C4CEEB;
	Wed, 13 Aug 2025 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095417;
	bh=MYPEj/1UaAR+SG/EgGexa4okmshAoVUJvRwXGzcaCEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aj4BQv+4Yz5yRrbbVtZVoCL/+yOYojBoh6/eO9h64fK5ipEo8X/liwRayFmUHP8VE
	 xTdKMxvEephgZf27gQBtLCieXwg1AaM48JhuSE0o/3lIf1JBYvGLthBgdmwBxxTPId
	 Wn+zOckhbkGKgGT9Z4xF9x+X9G4iWsySpf1DERjfW3AnMW0t2rQ7iznWvvGUu8PE6+
	 VROXFpAij7BosJTTyMt8vdSVh74i1ADiOrA1vHnRLl2HuG3F2SQzhxy3IZw6NVM33v
	 KecrUJ5kYRBuCpOZ8bpU19CLnmkCE2P4Yb87Sa/J3LKvWZa8FrHT/Mmr4SJQCwtXjL
	 TwOi6CdUVm4mQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/4] tracing: uprobe: eprobes: Allocate traceprobe_parse_context per probe
Date: Wed, 13 Aug 2025 23:30:14 +0900
Message-ID: <175509541393.193596.16330324746701582114.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175509537667.193596.9139462012987606126.stgit@devnote2>
References: <175509537667.193596.9139462012987606126.stgit@devnote2>
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

Since traceprobe_parse_context is reusable among a probe arguments,
it is more efficient to allocate it outside of the loop for parsing
probe argument as kprobe and fprobe events do.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |   32 ++++++++++++--------------------
 kernel/trace/trace_uprobe.c |   12 ++++++------
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index f7a1ff509d7e..d58d8702a327 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -801,25 +801,6 @@ find_and_get_event(const char *system, const char *event_name)
 	return NULL;
 }
 
-static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[], int i)
-{
-	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
-	int ret;
-
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-	ctx->event = ep->event;
-	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_TEVENT;
-
-	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], ctx);
-	/* Handle symbols "@" */
-	if (!ret)
-		ret = traceprobe_update_arg(&ep->tp.args[i]);
-
-	return ret;
-}
-
 static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
 {
 	struct event_filter *dummy = NULL;
@@ -871,6 +852,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	 * Fetch args (no space):
 	 *  <name>=$<field>[:TYPE]
 	 */
+	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
 	struct trace_eprobe *ep __free(trace_event_probe_cleanup) = NULL;
 	const char *trlog __free(trace_probe_log_clear) = NULL;
 	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
@@ -956,11 +938,21 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	} else
 		ep->filter_str = NULL;
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->event = ep->event;
+	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_TEVENT;
+
 	argc -= 2; argv += 2;
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
-		ret = trace_eprobe_tp_update_arg(ep, argv, i);
+
+		ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], ctx);
+		/* Handle symbols "@" */
+		if (!ret)
+			ret = traceprobe_update_arg(&ep->tp.args[i]);
 		if (ret)
 			return ret;
 	}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9c628dab3dc6..8f9b95cee786 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -541,6 +541,7 @@ DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (_T) free_trace_uprobe(
  */
 static int __trace_uprobe_create(int argc, const char **argv)
 {
+	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
 	struct trace_uprobe *tu __free(free_trace_uprobe) = NULL;
 	const char *trlog __free(trace_probe_log_clear) = NULL;
 	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
@@ -698,14 +699,13 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	memset(&path, 0, sizeof(path));
 	tu->filename = no_free_ptr(filename);
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER;
+
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
-		struct traceprobe_parse_context *ctx __free(traceprobe_parse_context)
-			= kzalloc(sizeof(*ctx), GFP_KERNEL);
-
-		if (!ctx)
-			return -ENOMEM;
-		ctx->flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER;
 		trace_probe_log_set_index(i + 2);
 		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], ctx);
 		if (ret)

