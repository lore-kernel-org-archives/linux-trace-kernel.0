Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075004A0F;
	Sun, 20 Jul 2025 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992512; cv=none; b=ashzZ9Mp8iFBhKutF2980aZO9euWOpvnwHDXUdabLaYZF5Av53kxxAayGYdVg6xJDrFFGWHgRCQpCVW1aeZFlhebZ7Wz/Pg+iGd2AEJ2UN64x/Y+fZGN+A5dBVSsVpH4Dd/Rrrj0Y6I2YzTTUFNcE09UhC4VD6CgGLnLU3/f/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992512; c=relaxed/simple;
	bh=o0R2CCHj+qVQFFwXi1ijtEJ/1OHgE5CgE1qHLrSSV0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6/nLSQwXYLvlVmg27ZvIJVPZk2Wy3c8SCx7g32kyx8nyRjOJ9INjPEMN2HVjkgYrAx5Uj6pzTtKKD6S0Able8UTH4RIM5Dtecml9Gbj+DZl8MyDA/BLtppWZR8mnlDVfx+NJsdqbM6DkvVxZxVMittXQd1SdSGEprwaMlpSteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNd+QV+N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNd+QV+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5B4C4CEE7;
	Sun, 20 Jul 2025 06:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752992511;
	bh=o0R2CCHj+qVQFFwXi1ijtEJ/1OHgE5CgE1qHLrSSV0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNd+QV+NMZyn2uNksNWeZtWQwfSJapPWJXDavgRJ1cSCEWQqy7hb3Ba8iDuK71tcK
	 w7v46MPIcgMAz5JLReawH+2PWqbGQ6fwLDmJSw9hn6Q4RpNCQxTLfJw9IIzvuSNjqy
	 85+TGG3jSr7/cl19TvHIXoR+N5cr7zua6qNnoY7/X2+kpBMc3z61D3w7fIh1WjM3Z9
	 3paH4O2nppUdpSaFaRTMZq8pBubmE/l35oTPw6+imFIQO0InyJa42s73/DpkZNZzNV
	 NFnuVqdyKL5TJeXLzoE/sNSLwAbeZyrhidWQtl+CSHJ87luJYk9gxoyo45aAhJYmBS
	 38n0sc/GyOQ2g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] tracing: probe: Allocate traceprobe_parse_context from heap
Date: Sun, 20 Jul 2025 15:21:47 +0900
Message-ID: <175299250735.418723.6298873768702875564.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175299249728.418723.17799706394466693180.stgit@devnote2>
References: <175299249728.418723.17799706394466693180.stgit@devnote2>
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
 Changes in v2:
  - Sort #include alphabetically.
  - Just NULL check for freeing traceprobe_parse_context.
  - Do not change the semantics of traceprobe_parse_context for uprobe
    event. (alloc/free in loop)
---
 kernel/trace/trace_eprobe.c |   14 ++++++++------
 kernel/trace/trace_fprobe.c |   13 ++++++++-----
 kernel/trace/trace_kprobe.c |   10 +++++++---
 kernel/trace/trace_probe.h  |   26 ++++++++++++++++++--------
 kernel/trace/trace_uprobe.c |   13 ++++++++-----
 5 files changed, 49 insertions(+), 27 deletions(-)

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
index 854e5668f5ee..842383fbc03b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -10,20 +10,22 @@
  * Author:     Srikar Dronamraju
  */
 
+#include <linux/bitops.h>
+#include <linux/btf.h>
+#include <linux/cleanup.h>
+#include <linux/kprobes.h>
+#include <linux/limits.h>
+#include <linux/perf_event.h>
+#include <linux/ptrace.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <linux/tracefs.h>
-#include <linux/types.h>
 #include <linux/string.h>
-#include <linux/ptrace.h>
-#include <linux/perf_event.h>
-#include <linux/kprobes.h>
 #include <linux/stringify.h>
-#include <linux/limits.h>
+#include <linux/tracefs.h>
+#include <linux/types.h>
 #include <linux/uaccess.h>
-#include <linux/bitops.h>
-#include <linux/btf.h>
+
 #include <asm/bitsperlong.h>
 
 #include "trace.h"
@@ -438,6 +440,14 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
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
index f95a2c3d5b1b..797ac1250956 100644
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

