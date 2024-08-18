Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC073381D9;
	Sun, 18 Aug 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977809; cv=none; b=jl55fMHw0W0Y085rCj91HwC0uE2B59q8SluJAx09XuUf5IktARi07aKjju7gGiskdUU1xzsrNL5+TKlRd7jcBQq1lHRFXledSEX6Z3lnUPjdXf2iFfMVdAeAncH6r04D4FWLT5vg1N9lxxKvD3D867y/s4PWhr1Qi/MEAMQ7KuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977809; c=relaxed/simple;
	bh=MZOaid6cAqLQgv+JhjDgg9phuooFUeOYA88rwQdbU0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwJ0Ad6jfICwbxfP0DG33M+G6PiUJFS3C0U/Y7dJQq2aKeASTMJul5s9Y8eC/J2dxr46x6m3ZvK+GDqaDH1LE1Xq8D2teAoXwxk2W9S7QVtvTekPXiRnRt0Q2RuQOysoCmNXmyvMHPp26Fi5do7iYxrAMxTSrcwf60iMNlYPqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVyHLwGb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVyHLwGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7B1C32786;
	Sun, 18 Aug 2024 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723977809;
	bh=MZOaid6cAqLQgv+JhjDgg9phuooFUeOYA88rwQdbU0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVyHLwGbuLe+x6UnSlfQgoF+DND7CeNHECP1XrQ69UN17zdyJwoZno3vjW8PiLni2
	 syC6cN44hlPHLDloumNdADw1t21bDV2f8UrLio5Hsds6AVrIMaOyamv3mxu0g7RJFX
	 DZ9SUJTyu1C2Q2yjAHTrIH2DvzQk0Dj3Ueg/qQN8tQ/qqfMkLmxYRzqrHKVjcmylJb
	 VEtHPk4ofNOuoFWABqIzQ1n1dASz1lcbHbSFStG1PmHIbCbnUPYrl3Ssr0VAWuLKfv
	 HxGxcjf5yrkboVTZVe2hw41YjherhOIdULbTaYcJstjYalCR1j1ycVfJLuZwAPfSHX
	 48yQsELCKDwdg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v3 4/5] tracing/fprobe: Support raw tracepoints on future loaded modules
Date: Sun, 18 Aug 2024 19:43:26 +0900
Message-Id: <172397780593.286558.18360375226968537828.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172397776900.286558.8986646398199362026.stgit@devnote2>
References: <172397776900.286558.8986646398199362026.stgit@devnote2>
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

Support raw tracepoint events on future loaded (unloaded) modules.
This allows user to create raw tracepoint events which can be used from
module's __init functions.

Note: since the kernel does not have any information about the tracepoints
in the unloaded modules, fprobe events can not check whether the tracepoint
exists nor extend the BTF based arguments.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Newly added.
---
 kernel/trace/trace_fprobe.c                        |  151 +++++++++++++-------
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |    1 
 2 files changed, 101 insertions(+), 51 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 8b1127e37da5..a079abd8955b 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -21,6 +21,7 @@
 #define FPROBE_EVENT_SYSTEM "fprobes"
 #define TRACEPOINT_EVENT_SYSTEM "tracepoints"
 #define RETHOOK_MAXACTIVE_MAX 4096
+#define TRACEPOINT_STUB ERR_PTR(-ENOENT)
 
 static int trace_fprobe_create(const char *raw_command);
 static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
@@ -674,6 +675,24 @@ static int unregister_fprobe_event(struct trace_fprobe *tf)
 	return trace_probe_unregister_event_call(&tf->tp);
 }
 
+static int __regsiter_tracepoint_fprobe(struct trace_fprobe *tf)
+{
+	struct tracepoint *tpoint = tf->tpoint;
+	unsigned long ip = (unsigned long)tpoint->probestub;
+	int ret;
+
+	/*
+	 * Here, we do 2 steps to enable fprobe on a tracepoint.
+	 * At first, put __probestub_##TP function on the tracepoint
+	 * and put a fprobe on the stub function.
+	 */
+	ret = tracepoint_probe_register_prio_may_exist(tpoint,
+				tpoint->probestub, NULL, 0);
+	if (ret < 0)
+		return ret;
+	return register_fprobe_ips(&tf->fp, &ip, 1);
+}
+
 /* Internal register function - just handle fprobe and flags */
 static int __register_trace_fprobe(struct trace_fprobe *tf)
 {
@@ -700,18 +719,12 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 		tf->fp.flags |= FPROBE_FL_DISABLED;
 
 	if (trace_fprobe_is_tracepoint(tf)) {
-		struct tracepoint *tpoint = tf->tpoint;
-		unsigned long ip = (unsigned long)tpoint->probestub;
-		/*
-		 * Here, we do 2 steps to enable fprobe on a tracepoint.
-		 * At first, put __probestub_##TP function on the tracepoint
-		 * and put a fprobe on the stub function.
-		 */
-		ret = tracepoint_probe_register_prio_may_exist(tpoint,
-					tpoint->probestub, NULL, 0);
-		if (ret < 0)
-			return ret;
-		return register_fprobe_ips(&tf->fp, &ip, 1);
+
+		/* This tracepoint is not loaded yet */
+		if (tf->tpoint == TRACEPOINT_STUB)
+			return 0;
+
+		return __regsiter_tracepoint_fprobe(tf);
 	}
 
 	/* TODO: handle filter, nofilter or symbol list */
@@ -864,36 +877,6 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 	return ret;
 }
 
-#ifdef CONFIG_MODULES
-static int __tracepoint_probe_module_cb(struct notifier_block *self,
-					unsigned long val, void *data)
-{
-	struct tp_module *tp_mod = data;
-	struct trace_fprobe *tf;
-	struct dyn_event *pos;
-
-	if (val != MODULE_STATE_GOING)
-		return NOTIFY_DONE;
-
-	mutex_lock(&event_mutex);
-	for_each_trace_fprobe(tf, pos) {
-		if (tp_mod->mod == tf->mod) {
-			tracepoint_probe_unregister(tf->tpoint,
-					tf->tpoint->probestub, NULL);
-			tf->tpoint = NULL;
-			tf->mod = NULL;
-		}
-	}
-	mutex_unlock(&event_mutex);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block tracepoint_module_nb = {
-	.notifier_call = __tracepoint_probe_module_cb,
-};
-#endif /* CONFIG_MODULES */
-
 struct __find_tracepoint_cb_data {
 	const char *tp_name;
 	struct tracepoint *tpoint;
@@ -906,10 +889,12 @@ static void __find_tracepoint_module_cb(struct tracepoint *tp, struct module *mo
 
 	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
 		data->tpoint = tp;
-		data->mod = mod;
-		if (!try_module_get(data->mod)) {
-			data->tpoint = NULL;
-			data->mod = NULL;
+		if (!data->mod) {
+			data->mod = mod;
+			if (!try_module_get(data->mod)) {
+				data->tpoint = NULL;
+				data->mod = NULL;
+			}
 		}
 	}
 }
@@ -947,6 +932,67 @@ static struct tracepoint *find_tracepoint(const char *tp_name,
 	return data.tpoint;
 }
 
+#ifdef CONFIG_MODULES
+static void reenable_trace_fprobe(struct trace_fprobe *tf)
+{
+	struct trace_probe *tp = &tf->tp;
+
+	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
+		__enable_trace_fprobe(tf);
+	}
+}
+
+static struct tracepoint *find_tracepoint_in_module(struct module *mod,
+						    const char *tp_name)
+{
+	struct __find_tracepoint_cb_data data = {
+		.tp_name = tp_name,
+		.mod = mod,
+	};
+
+	for_each_tracepoint_in_module(mod, __find_tracepoint_module_cb, &data);
+	return data.tpoint;
+}
+
+static int __tracepoint_probe_module_cb(struct notifier_block *self,
+					unsigned long val, void *data)
+{
+	struct tp_module *tp_mod = data;
+	struct tracepoint *tpoint;
+	struct trace_fprobe *tf;
+	struct dyn_event *pos;
+
+	if (val != MODULE_STATE_GOING && val != MODULE_STATE_COMING)
+		return NOTIFY_DONE;
+
+	mutex_lock(&event_mutex);
+	for_each_trace_fprobe(tf, pos) {
+		if (val == MODULE_STATE_COMING && tf->tpoint == TRACEPOINT_STUB) {
+			tpoint = find_tracepoint_in_module(tp_mod->mod, tf->symbol);
+			if (tpoint) {
+				tf->tpoint = tpoint;
+				tf->mod = tp_mod->mod;
+				if (!WARN_ON_ONCE(__regsiter_tracepoint_fprobe(tf)) &&
+				    trace_probe_is_enabled(&tf->tp))
+					reenable_trace_fprobe(tf);
+			}
+		} else if (val == MODULE_STATE_GOING && tp_mod->mod == tf->mod) {
+			tracepoint_probe_unregister(tf->tpoint,
+					tf->tpoint->probestub, NULL);
+			tf->tpoint = NULL;
+			tf->mod = NULL;
+		}
+	}
+	mutex_unlock(&event_mutex);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block tracepoint_module_nb = {
+	.notifier_call = __tracepoint_probe_module_cb,
+};
+#endif /* CONFIG_MODULES */
+
 static int parse_symbol_and_return(int argc, const char *argv[],
 				   char **symbol, bool *is_return,
 				   bool is_tracepoint)
@@ -1113,14 +1159,19 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	if (is_tracepoint) {
 		ctx.flags |= TPARG_FL_TPOINT;
 		tpoint = find_tracepoint(symbol, &tp_mod);
-		if (!tpoint) {
+		if (tpoint) {
+			ctx.funcname = kallsyms_lookup(
+				(unsigned long)tpoint->probestub,
+				NULL, NULL, NULL, sbuf);
+		} else if (IS_ENABLED(CONFIG_MODULES)) {
+				/* This *may* be loaded afterwards */
+				tpoint = TRACEPOINT_STUB;
+				ctx.funcname = symbol;
+		} else {
 			trace_probe_log_set_index(1);
 			trace_probe_log_err(0, NO_TRACEPOINT);
 			goto parse_error;
 		}
-		ctx.funcname = kallsyms_lookup(
-				(unsigned long)tpoint->probestub,
-				NULL, NULL, NULL, sbuf);
 	} else
 		ctx.funcname = symbol;
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
index da117b8f1d12..ffe8ffef4027 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
@@ -9,7 +9,6 @@ check_error() { # command-with-error-pos-by-^
 
 check_error 't^100 kfree'		# BAD_MAXACT_TYPE
 
-check_error 't ^non_exist_tracepoint'	# NO_TRACEPOINT
 check_error 't:^/bar kfree'		# NO_GROUP_NAME
 check_error 't:^12345678901234567890123456789012345678901234567890123456789012345/bar kfree'	# GROUP_TOO_LONG
 

