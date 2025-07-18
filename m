Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4CA221F04;
	Fri, 18 Jul 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838453; cv=none; b=PoOtTq0C+eNmtS7I+iSyX4XdxtBFai3hnX2MMkXYAQVjNCEpYuVqZ+yuwSsvAtrTJjRVuQOLCzK38C9NnmuSIQ2k/bE5d+lC6Nfa1HI+23TrMcclgqT3dslxyVf5n3I0O5+RxD7xDPBCNTTmuTMrnm5rMAX35+j0KVAkfJsxcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838453; c=relaxed/simple;
	bh=VWXd4JzwDeER8jbP3WGyWoPVm9dCSHbXPe6mmaw+s0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCZoLMcacQoZmx1L+vUBaiFgd/PNsdpN9L181bNQ7Oqhr4a2wndg7qINtABApjI7xk24nDDOK6DIGj73Hn96nHxoCMA5zlog2Orgwq9t+5s10kiTfUmCT+71MnzrwBCdumgD9RBvUnJz9JFAmNJePJ/Zcznyb6zxpuke/qbVgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH45Cj8K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH45Cj8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F35C4CEEB;
	Fri, 18 Jul 2025 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838453;
	bh=VWXd4JzwDeER8jbP3WGyWoPVm9dCSHbXPe6mmaw+s0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pH45Cj8K24bBuwuVhoFyLZZOFDfBO3tKfqrRyKN1LC6iS24Ot2KieyCLZ0Mo2X+Yh
	 GgZq31i2/x0DKonw9sewphArFl+AYKMj7x7SXkloUY3n9P5ts5r2P6FiE2Q638th7H
	 YO5H0ia2FgfcNeicb+DZr+miOr6qbFqqbXsIEYxApJqZFNfBN1P+EaA1qO4+VrvzXy
	 X2wFEjx3ivYxH5/zVuc+JlOd6Zz+bvDIb7W7Mm8dsswlzciytrBHEZe31883h/FvMD
	 qIGexpSHkDed4rt4PTrHx6v4K1bPeBS85xkuPHHQkKVsL6h6eyUISA8sO23pMPmrVi
	 pgRWU84jbsmvQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/5] tracing: probe: Allocate traceprobe_parse_context from heap
Date: Fri, 18 Jul 2025 20:34:08 +0900
Message-ID: <175283844827.343578.10408845752163723065.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175283843771.343578.8524137568048302760.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
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

Instead of allocating traceprobe_parse_context on stack, allocate it
dynamically from heap (slab).

This change is likely intended to prevent potential stack overflow
issues, which can be a concern in the kernel environment where stack
space is limited.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506240416.nZIhDXoO-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |   14 ++++++++------
 kernel/trace/trace_fprobe.c |   13 ++++++++-----
 kernel/trace/trace_kprobe.c |   10 +++++++---
 kernel/trace/trace_probe.h  |    9 +++++++++
 kernel/trace/trace_uprobe.c |   15 +++++++++------
 5 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 916555f0de81..1e18a8619b40 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -797,18 +797,20 @@ find_and_get_event(const char *system, const char *event_name)
 
 static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[], int i)
 {
-	struct traceprobe_parse_context ctx = {
-		.event = ep->event,
-		.flags = TPARG_FL_KERNEL | TPARG_FL_TEVENT,
-	};
+	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
 	int ret;
 
-	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], &ctx);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->event = ep->event;
+	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_TEVENT;
+
+	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], ctx);
 	/* Handle symbols "@" */
 	if (!ret)
 		ret = traceprobe_update_arg(&ep->tp.args[i]);
 
-	traceprobe_finish_parse(&ctx);
 	return ret;
 }
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index dbf9d413125a..264cf7fc9a1d 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1383,14 +1383,17 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
 static int trace_fprobe_create_cb(int argc, const char *argv[])
 {
-	struct traceprobe_parse_context ctx = {
-		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
-	};
+	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
 	int ret;
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
+
 	trace_probe_log_init("trace_fprobe", argc, argv);
-	ret = trace_fprobe_create_internal(argc, argv, &ctx);
-	traceprobe_finish_parse(&ctx);
+	ret = trace_fprobe_create_internal(argc, argv, ctx);
 	trace_probe_log_clear();
 	return ret;
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3e5c47b6d7b2..15d7a381a128 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1065,14 +1065,18 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 
 static int trace_kprobe_create_cb(int argc, const char *argv[])
 {
-	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
+	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
 	int ret;
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->flags = TPARG_FL_KERNEL;
+
 	trace_probe_log_init("trace_kprobe", argc, argv);
 
-	ret = trace_kprobe_create_internal(argc, argv, &ctx);
+	ret = trace_kprobe_create_internal(argc, argv, ctx);
 
-	traceprobe_finish_parse(&ctx);
 	trace_probe_log_clear();
 	return ret;
 }
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 854e5668f5ee..7bc4c84464e4 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -10,6 +10,7 @@
  * Author:     Srikar Dronamraju
  */
 
+#include <linux/cleanup.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -438,6 +439,14 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
  * this MUST be called for clean up the context and return a resource.
  */
 void traceprobe_finish_parse(struct traceprobe_parse_context *ctx);
+static inline void traceprobe_free_parse_ctx(struct traceprobe_parse_context *ctx)
+{
+	traceprobe_finish_parse(ctx);
+	kfree(ctx);
+}
+
+DEFINE_FREE(traceprobe_parse_context, struct traceprobe_parse_context *,
+		if (!IS_ERR_OR_NULL(_T)) traceprobe_free_parse_ctx(_T))
 
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f95a2c3d5b1b..1fd479718d03 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -537,6 +537,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
  */
 static int __trace_uprobe_create(int argc, const char **argv)
 {
+	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
 	struct trace_uprobe *tu;
 	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
 	char *arg, *filename, *rctr, *rctr_end, *tmp;
@@ -693,15 +694,17 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	tu->path = path;
 	tu->filename = filename;
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		ret = -ENOMEM;
+		goto error;
+	}
+	ctx->flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER;
+
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
-		struct traceprobe_parse_context ctx = {
-			.flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER,
-		};
-
 		trace_probe_log_set_index(i + 2);
-		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], &ctx);
-		traceprobe_finish_parse(&ctx);
+		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], ctx);
 		if (ret)
 			goto error;
 	}

