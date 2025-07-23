Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411AA1D63F0;
	Wed, 23 Jul 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234261; cv=none; b=LKqS8sfu+NPbXls1F8L+V4lT4mBOvE591V337c0i8oogw0R+8sdsWjgSzorxCbbwW37UR2X27QfBa3vewxKtWEHvxWOtxlIRbaeSHzC1MN6b26U0wiejhrT3JB4sTRXwrmSVmLWXx0wlLxS+NIzZTYc7dLDbYxLDAc/wlo/WGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234261; c=relaxed/simple;
	bh=VtZlCmcOqkyOJN941BewJUMCtimGRtGIU3j97zXjTm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua7R8NpYYjo55w3sMtFNJ7Sk4Nn9hZGmBStR3o95q1z101MLRxEk9LXndY3BtYDManF1Rm6QGB6zcSyB1Lamnvo7tQPFHLQxDQVw66iLeuLjuyKsRSEusi9TwcvZcQHG2yakcL+YT8DV6pINYi5OyJ4Q7QTHZozwQXeNiff6IQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3XV0szR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3XV0szR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB43C4CEEB;
	Wed, 23 Jul 2025 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234260;
	bh=VtZlCmcOqkyOJN941BewJUMCtimGRtGIU3j97zXjTm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3XV0szRb+xtV9QlC7zu8jrMwd7x4ikJafwW4Qu2c6TaOS+Iu8Vv+DWMuGAanZIaj
	 /I2/Tx7KWeAq+m983LS7Qa7EWoaSRAhHBrGPQaATd9KcIJWCv6BTLmp/Vxh3PJ4Ynf
	 if3VVRoTyhJjI+Qs4OzEZvTf5/6Wwv4LrEuzveF8v7MPd8PO2cIgTE5Rhq5PUqcPb/
	 +6fzTiDxiEIMVt5oAGwDFYuryKieIlqfybfqC0DqECZjVWgTuAmDJ/Be1ogab/NRk2
	 R1m/ri4hNkTvpzo3DzIjr5PeH03XukuIJgWciX3h4u9zJ6gNPHACqL+I9n1NxGzQfw
	 VD8leDqPNUigA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] tracing: probe: Allocate traceprobe_parse_context from heap
Date: Wed, 23 Jul 2025 10:30:56 +0900
Message-ID: <175323425650.57270.280750740753792504.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175323423662.57270.14650807176845939538.stgit@devnote2>
References: <175323423662.57270.14650807176845939538.stgit@devnote2>
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
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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

