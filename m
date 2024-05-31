Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AAA78C69;
	Fri, 31 May 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148890; cv=none; b=lDd082ix3BIVE/Vn2746V3IugdPGFMvDdZbx0jWCo5TPMQhfrHQnq41wZOaroTEveSPu1QkcwlCR7v8qjRBg0E9f/wWEipbIXL8FvFHqQSFuuP6S4ffoHUM/ALjDb4AnnbHNUT9wx843wjM/xMfBR2Oswj7nZBg60HbCV8RqjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148890; c=relaxed/simple;
	bh=9emyVcHeEjih4DKqAaHmMJgrsFc11xb6jFw6hilqh6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S50vtaiNz4rXlU325EpDb4Cd1Ua4MmqY55e+XOBKHyxozM5FX2aoGaUJHYmhgseq601Oifvcdo9AqD/vN2YD+3wEGxkucIKRVWXX2skyGgN2yLOjIphC1xnt+c+Qz73OQmK2l3lw0+X1fmqppu8BtzG7S8pkeiJVaITcaWWWSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihS01GEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihS01GEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84323C116B1;
	Fri, 31 May 2024 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717148889;
	bh=9emyVcHeEjih4DKqAaHmMJgrsFc11xb6jFw6hilqh6Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ihS01GEbqeFL8vs00CWNTYO4XItYZgqUxwn0UhZHlggv20Y4y8bxDx9/Tmqw2fJJK
	 u29IU4L/k8rrYANrHTK7MVlEeapqvAKO11SC3YM2oRhCDHv9zzyFrtzN6lrDIH+5k5
	 ELpgTzX8adQHhDCTPT7o93oBBQs52vu/a1fkbDQoDELzG3SL+SZ1OzIfq9Eo4tL5ae
	 B/8FQIIxWPgJNytnEZ+GdJxwRSUhEafKVKVOVDAVoHHwSVuJpk/b5sii2hi0GltNM+
	 bjrpIxMmlH4SPyvdCMbQv3M78xVh4p9JMySYYaNz3bWpb098dzWNfSGkwDHN/UAFHv
	 fpgR/2LJWu48g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH] tracing/fprobe: Support raw tracepoint events on modules
Date: Fri, 31 May 2024 18:48:06 +0900
Message-Id: <171714888633.198965.13093663631481169611.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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
 include/linux/tracepoint.h  |    7 +++++++
 kernel/trace/trace_fprobe.c |   46 ++++++++++++++++++++++++++++++++++++-------
 kernel/tracepoint.c         |   19 ++++++++++++++++++
 3 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 689b6d71590e..46e6a5e759fd 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -65,6 +65,8 @@ struct tp_module {
 bool trace_module_has_bad_taint(struct module *mod);
 extern int register_tracepoint_module_notifier(struct notifier_block *nb);
 extern int unregister_tracepoint_module_notifier(struct notifier_block *nb);
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
+				void *priv);
 #else
 static inline bool trace_module_has_bad_taint(struct module *mod)
 {
@@ -80,6 +82,11 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
 {
 	return 0;
 }
+static inline
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
+				void *priv)
+{
+}
 #endif /* CONFIG_MODULES */
 
 /*
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
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..981b60199413 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -735,6 +735,25 @@ static __init int init_tracepoints(void)
 	return ret;
 }
 __initcall(init_tracepoints);
+
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
+				void *priv)
+{
+	struct tp_module *tp_mod;
+	struct module *mod;
+
+	if (!mod->num_tracepoints)
+		return;
+
+	mutex_lock(&tracepoint_module_list_mutex);
+	list_for_each_entry(tp_mod, &tracepoint_module_list, list) {
+		mod = tp_mod->mod;
+		for_each_tracepoint_range(mod->__start___tracepoints_ptrs,
+			mod->tracepoints_ptrs + mod->num_tracepoints,
+			fct, priv);
+	}
+	mutex_unlock(&tracepoint_module_list_mutex);
+}
 #endif /* CONFIG_MODULES */
 
 /**

