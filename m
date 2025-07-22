Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003EB221FC9;
	Tue, 22 Jul 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221710; cv=none; b=XsPhuYfkr0/puGQPTjwi5CCvug51kOT4jnur4Ow6P/MovgvFOot5mIcxJ3f4if9p+7RpsvVOHRLuLXTIEyjIfcw40YKtfiKc3fKifnKVvpODosIFnXxfGGq0hBxPkqiITvT6pqWR73All5T6pfq+xHMK93BvaeSX44FylAV8MXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221710; c=relaxed/simple;
	bh=7BcGUd4WqQVRorAiAOCWe6/HJTyfG3sk3ApDuhdwFww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJNYyjKHxi/KcQF3LNKxWhl3gXDI0vW5dd7YfRTpo5Ye3hAznxCnw77Xcp3Y/FFP/ulnQrxujuFy81a7A1fw3VQ2/rBIcGDdj/C+fViAc7PP4biQjrhrGNN0b5/IHmfZUssyMqVm/bl8t6VsesBhOs00N55HxxShMRMwww/4o+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtiN+tR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtiN+tR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBE1C4CEEB;
	Tue, 22 Jul 2025 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221709;
	bh=7BcGUd4WqQVRorAiAOCWe6/HJTyfG3sk3ApDuhdwFww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtiN+tR0+rSnHBX2t5Mg0al3Ug5PMel//dg6RqLtaJvccsZlzcATAD6XImhiWyPFk
	 azvP1NLWy9bWY3rnefUTq52kbr2xLSE4c8NYVkS2iEqtxGcOh1gDb3To8mFi+Gz58h
	 33I/HqFLoGGASIghJmMyQeqs4G+evB7kqBI1qmwC0vNHgs4mSUqb3DweKJHtYhikeW
	 7vz6uMVWj7tlzok0TzqSNZE+9y0xJYH7SWhBLkWsTLOIiJCIC/WknRN4QGdOMigfkv
	 2MNzmnsDSKa5b7plgQs9ZJKBNvIZz8q4qgzNIg8fv8ZJFKt0hpi+BUqc4pVdaEf+SA
	 HxI6ZoDUa/u7A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] tracing: probe: Allocate traceprobe_parse_context from heap
Date: Wed, 23 Jul 2025 07:01:46 +0900
Message-ID: <175322170601.44400.16839124706616607558.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175322168606.44400.9155291012158349647.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
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
 Changes in v3:
  - Split #include sorting.
 Changes in v2:
  - Sort #include alphabetically.
  - Just NULL check for freeing traceprobe_parse_context.
  - Do not change the semantics of traceprobe_parse_context for uprobe
    event. (alloc/free in loop)
---
 kernel/trace/trace_eprobe.c |   14 ++++++++------
 kernel/trace/trace_fprobe.c |   13 ++++++++-----
 kernel/trace/trace_kprobe.c |   10 +++++++---
 kernel/trace/trace_probe.h  |    9 +++++++++
 kernel/trace/trace_uprobe.c |   13 ++++++++-----
 5 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 23e06712bead..7ba3a18be4c5 100644
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
index add08ffb04d7..610f8d53be8a 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1384,14 +1384,17 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
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
index cac128a5f7e0..d14b33e205f7 100644
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
index 719604855279..842383fbc03b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -12,6 +12,7 @@
 
 #include <linux/bitops.h>
 #include <linux/btf.h>
+#include <linux/cleanup.h>
 #include <linux/kprobes.h>
 #include <linux/limits.h>
 #include <linux/perf_event.h>
@@ -439,6 +440,14 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
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
+	if (_T) traceprobe_free_parse_ctx(_T))
 
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3cc3404b09f0..872dce092e46 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -695,13 +695,16 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
-		struct traceprobe_parse_context ctx = {
-			.flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER,
-		};
+		struct traceprobe_parse_context *ctx __free(traceprobe_parse_context)
+			= kzalloc(sizeof(*ctx), GFP_KERNEL);
 
+		if (!ctx) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		ctx->flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER;
 		trace_probe_log_set_index(i + 2);
-		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], &ctx);
-		traceprobe_finish_parse(&ctx);
+		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], ctx);
 		if (ret)
 			goto error;
 	}

