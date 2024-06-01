Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A93A1BF;
	Sat,  1 Jun 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717230169; cv=none; b=k4WnRgv0gqOCAvxa2V7PyfXy92H9+AbXT9qKqVto3v2HMDUm6cjjV3/kDuy1wFbyjLFn8yb2m+D9y7qSo5DUAT0o21BDgXZgv3qT/9qXdJkNWIsunI30gxAQ0mCRdM6Y70FMRN8U3Iof4LHhfVwtPSvkZPAku1HTKNSYH+/cpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717230169; c=relaxed/simple;
	bh=c0m0QDfRqXzY8JEBFpa5rsivo9DQtJWRdwquS1zNvaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHxYlCyrTlNh4myv/3WhPQxTvfpodTpJLjuMIYg72TD+ZoqQ8EI/1rYwWGNCRh1I6tIETNqzDTn0ZVZJbAZc83vu5+q9CQ5uYNHutiHKDvcdbsfNBp8LUnjQ2l8dD/X+F4JNsvKywtlE0qMGMdmgSpVAKO9meHxRTI8xlN5U9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx16sp0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx16sp0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38112C116B1;
	Sat,  1 Jun 2024 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717230169;
	bh=c0m0QDfRqXzY8JEBFpa5rsivo9DQtJWRdwquS1zNvaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fx16sp0uxID0l0j5B+rYTbqsNxgR+arVUIO2uderAxws59WgbTdvdz0SWeeCNozcZ
	 imNAJyylAWO468epSHapMsVFK5YsKS1ZE5Anjhvv1FxaTwOD/2CmOTt4tWqqCDfVQn
	 TLmQaoAKrinBPXBYEtq9ebbgXjbipr4ZXHM77Zq3nc4HyZKnhYCuOOv8OgSDIvpMrD
	 2lX5ib7JMsdns01x8EhKOytWTCmcSq0VnwtcAbwotaNmOKjeool6wW9l/D6CQ9YB72
	 s5lUq/qesZ6uvokWT46c8kI8Zr4xyODdfyTcFDU70eXUYuYaCyvctAYDdJ0MBTkDSN
	 4ld6zxcbX3cjw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v2 2/3] tracing/fprobe: Support raw tracepoint events on modules
Date: Sat,  1 Jun 2024 17:22:46 +0900
Message-Id: <171723016594.258703.1629777910752596529.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171723014778.258703.6731294779199848686.stgit@devnote2>
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
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

Support raw tracepoint event on module by fprobe events.
Since it only uses for_each_kernel_tracepoint() to find a tracepoint,
the tracepoints on modules are not handled. Thus if user specified a
tracepoint on a module, it shows an error.
This adds new for_each_module_tracepoint() API to tracepoint subsystem,
and uses it to find tracepoints on modules.

Reported-by: don <zds100@gmail.com>
Closes: https://lore.kernel.org/all/20240530215718.aeec973a1d0bf058d39cb1e3@kernel.org/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix build errors with CONFIG_MODULES=y.
---
 kernel/trace/trace_fprobe.c |   46 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 62e6a8f4aae9..1d8a983e1edc 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -385,6 +385,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       const char *event,
 					       const char *symbol,
 					       struct tracepoint *tpoint,
+					       struct module *mod,
 					       int maxactive,
 					       int nargs, bool is_return)
 {
@@ -405,6 +406,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 		tf->fp.entry_handler = fentry_dispatcher;
 
 	tf->tpoint = tpoint;
+	tf->mod = mod;
 	tf->fp.nr_maxactive = maxactive;
 
 	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
@@ -895,8 +897,23 @@ static struct notifier_block tracepoint_module_nb = {
 struct __find_tracepoint_cb_data {
 	const char *tp_name;
 	struct tracepoint *tpoint;
+	struct module *mod;
 };
 
+static void __find_tracepoint_module_cb(struct tracepoint *tp, void *priv)
+{
+	struct __find_tracepoint_cb_data *data = priv;
+
+	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
+		data->tpoint = tp;
+		data->mod = __module_text_address((unsigned long)tp->probestub);
+		if (!try_module_get(data->mod)) {
+			data->tpoint = NULL;
+			data->mod = NULL;
+		}
+	}
+}
+
 static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
 {
 	struct __find_tracepoint_cb_data *data = priv;
@@ -905,14 +922,28 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
 		data->tpoint = tp;
 }
 
-static struct tracepoint *find_tracepoint(const char *tp_name)
+/*
+ * Find a tracepoint from kernel and module. If the tracepoint is in a module,
+ * this increments the module refcount to prevent unloading until the
+ * trace_fprobe is registered to the list. After registering the trace_fprobe
+ * on the trace_fprobe list, the module refcount is decremented because
+ * tracepoint_probe_module_cb will handle it.
+ */
+static struct tracepoint *find_tracepoint(const char *tp_name,
+					  struct module **tp_mod)
 {
 	struct __find_tracepoint_cb_data data = {
 		.tp_name = tp_name,
+		.mod = NULL,
 	};
 
 	for_each_kernel_tracepoint(__find_tracepoint_cb, &data);
 
+	if (!data.tpoint && IS_ENABLED(CONFIG_MODULES)) {
+		for_each_module_tracepoint(__find_tracepoint_module_cb, &data);
+		*tp_mod = data.mod;
+	}
+
 	return data.tpoint;
 }
 
@@ -996,6 +1027,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	char abuf[MAX_BTF_ARGS_LEN];
 	char *dbuf = NULL;
 	bool is_tracepoint = false;
+	struct module *tp_mod = NULL;
 	struct tracepoint *tpoint = NULL;
 	struct traceprobe_parse_context ctx = {
 		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
@@ -1080,7 +1112,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 	if (is_tracepoint) {
 		ctx.flags |= TPARG_FL_TPOINT;
-		tpoint = find_tracepoint(symbol);
+		tpoint = find_tracepoint(symbol, &tp_mod);
 		if (!tpoint) {
 			trace_probe_log_set_index(1);
 			trace_probe_log_err(0, NO_TRACEPOINT);
@@ -1110,8 +1142,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		goto out;
 
 	/* setup a probe */
-	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
-				argc, is_return);
+	tf = alloc_trace_fprobe(group, event, symbol, tpoint, tp_mod,
+				maxactive, argc, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */
@@ -1119,10 +1151,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		goto out;	/* We know tf is not allocated */
 	}
 
-	if (is_tracepoint)
-		tf->mod = __module_text_address(
-				(unsigned long)tf->tpoint->probestub);
-
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
 		trace_probe_log_set_index(i + 2);
@@ -1155,6 +1183,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	}
 
 out:
+	if (tp_mod)
+		module_put(tp_mod);
 	traceprobe_finish_parse(&ctx);
 	trace_probe_log_clear();
 	kfree(new_argv);

