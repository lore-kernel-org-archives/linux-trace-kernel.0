Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AFE21B9DB;
	Mon, 31 Mar 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435377; cv=none; b=p0zVjJZLS54rF+s0qE0eSgeLlAZ4TiG7V68IX30DV4sBQ2/jo+ifG97lAE25N8hupmA52MtlKL/gOfeUloTQHbrEcac9kGWhFBHePl4J+T4YmIy4ByGdTaqL1Y4JfgCmbMMYXuc3NlvvhYpgC2766P3aUkcZYDvyiP7aTTvDhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435377; c=relaxed/simple;
	bh=RlUfwXDJ5RjAjcgTELHXOJOf6J12mfUvB2aMFZnDNN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYvi/pTUuSsFPDjdRvJxPtg9nYiLLnLDtPU79GVkLRwp8vDz2U6fAb1MF7F014J0vEPAF5ZXW3SB/B5jPEt3mWUj5vhRFmMIihIjkHMmaCYRwevkJUiPY/6H21G53AcX4GnqMC8f8K2Fv1+GURSOi6HuTvlQv37NoWkmWVEgUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRzXusB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRzXusB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B13C4CEE3;
	Mon, 31 Mar 2025 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435374;
	bh=RlUfwXDJ5RjAjcgTELHXOJOf6J12mfUvB2aMFZnDNN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRzXusB9bw1/crI6kHJ10cy3aa5Tr87pKoIBKl9cWeshSSyTAfQJjflNvyJnz35oV
	 dX4ceqmVLhlew+Hur5UdcnoVgWiOlaEbgyENN7dhMSbzXTkV43lKXGJmfE60hZ24w1
	 IGUQkUlZsTJm8vedxj98o+ZMmdTNxtFEtoMQjZqEyQCjpgxnMCGMJmH1Ag6YA4fiwi
	 eKos+M++G0EK1hpPCEbm0YI1Sp1bEAQqniiI+KO1fGeOWgSnujnF+6IfIiLnVYYkHG
	 2+QSK8H0Pm6/j4bVIPBZ2MCc7dpf1S4hQ+Hd9wAALaKeWbYrOnhEgCqXUkPH9mIF1Y
	 RgBmybLkqvIvg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] tracing: fprobe-events: Register fprobe-events only when it is enabled
Date: Tue,  1 Apr 2025 00:36:11 +0900
Message-ID: <174343537128.843280.16131300052837035043.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <174343532655.843280.15317319860632975273.stgit@devnote2>
References: <174343532655.843280.15317319860632975273.stgit@devnote2>
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

Currently fprobe events are registered when it is defined. Thus it will
give some overhead even if it is disabled. This changes it to register the
fprobe only when it is enabled.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - export fprobe_count_ips_from_filter() to just count addresses instead
    of allocating address list.
---
 include/linux/fprobe.h      |    5 +
 kernel/trace/fprobe.c       |    5 +
 kernel/trace/trace_fprobe.c |  237 +++++++++++++++++++++----------------------
 3 files changed, 126 insertions(+), 121 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 702099f08929..7964db96e41a 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -94,6 +94,7 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
 int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
 int unregister_fprobe(struct fprobe *fp);
 bool fprobe_is_registered(struct fprobe *fp);
+int fprobe_count_ips_from_filter(const char *filter, const char *notfilter);
 #else
 static inline int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
 {
@@ -115,6 +116,10 @@ static inline bool fprobe_is_registered(struct fprobe *fp)
 {
 	return false;
 }
+static inline int fprobe_count_ips_from_filter(const char *filter, const char *notfilter)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /**
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 95c6e3473a76..50eb7b718c4d 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -647,6 +647,11 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
 
 #define FPROBE_IPS_MAX	INT_MAX
 
+int fprobe_count_ips_from_filter(const char *filter, const char *notfilter)
+{
+	return get_ips_from_filter(filter, notfilter, NULL, NULL, FPROBE_IPS_MAX);
+}
+
 /**
  * register_fprobe() - Register fprobe to ftrace by pattern.
  * @fp: A fprobe data structure to be registered.
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 150975237a20..cee5153da7ec 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -600,98 +600,6 @@ static struct trace_fprobe *find_trace_fprobe(const char *event,
 	return NULL;
 }
 
-static inline int __enable_trace_fprobe(struct trace_fprobe *tf)
-{
-	if (trace_fprobe_is_registered(tf))
-		enable_fprobe(&tf->fp);
-
-	return 0;
-}
-
-static void __disable_trace_fprobe(struct trace_probe *tp)
-{
-	struct trace_fprobe *tf;
-
-	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
-		if (!trace_fprobe_is_registered(tf))
-			continue;
-		disable_fprobe(&tf->fp);
-	}
-}
-
-/*
- * Enable trace_probe
- * if the file is NULL, enable "perf" handler, or enable "trace" handler.
- */
-static int enable_trace_fprobe(struct trace_event_call *call,
-			       struct trace_event_file *file)
-{
-	struct trace_probe *tp;
-	struct trace_fprobe *tf;
-	bool enabled;
-	int ret = 0;
-
-	tp = trace_probe_primary_from_call(call);
-	if (WARN_ON_ONCE(!tp))
-		return -ENODEV;
-	enabled = trace_probe_is_enabled(tp);
-
-	/* This also changes "enabled" state */
-	if (file) {
-		ret = trace_probe_add_file(tp, file);
-		if (ret)
-			return ret;
-	} else
-		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
-
-	if (!enabled) {
-		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
-			/* TODO: check the fprobe is gone */
-			__enable_trace_fprobe(tf);
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Disable trace_probe
- * if the file is NULL, disable "perf" handler, or disable "trace" handler.
- */
-static int disable_trace_fprobe(struct trace_event_call *call,
-				struct trace_event_file *file)
-{
-	struct trace_probe *tp;
-
-	tp = trace_probe_primary_from_call(call);
-	if (WARN_ON_ONCE(!tp))
-		return -ENODEV;
-
-	if (file) {
-		if (!trace_probe_get_file_link(tp, file))
-			return -ENOENT;
-		if (!trace_probe_has_single_file(tp))
-			goto out;
-		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-	} else
-		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
-
-	if (!trace_probe_is_enabled(tp))
-		__disable_trace_fprobe(tp);
-
- out:
-	if (file)
-		/*
-		 * Synchronization is done in below function. For perf event,
-		 * file == NULL and perf_trace_event_unreg() calls
-		 * tracepoint_synchronize_unregister() to ensure synchronize
-		 * event. We don't need to care about it.
-		 */
-		trace_probe_remove_file(tp, file);
-
-	return 0;
-}
-
 /* Event entry printers */
 static enum print_line_t
 print_fentry_event(struct trace_iterator *iter, int flags,
@@ -851,6 +759,29 @@ static int __regsiter_tracepoint_fprobe(struct trace_fprobe *tf)
 	return register_fprobe_ips(&tf->fp, &ip, 1);
 }
 
+/* Returns an error if the target function is not available, or 0 */
+static int trace_fprobe_verify_target(struct trace_fprobe *tf)
+{
+	int ret;
+
+	if (trace_fprobe_is_tracepoint(tf)) {
+
+		/* This tracepoint is not loaded yet */
+		if (!tracepoint_user_is_registered(tf->tuser))
+			return 0;
+
+		/* We assume all stab function is tracable. */
+		return tracepoint_user_ip(tf->tuser) ? 0 : -ENOENT;
+	}
+
+	/*
+	 * Note: since we don't lock the module, even if this succeeded,
+	 * register_fprobe() later can fail.
+	 */
+	ret = fprobe_count_ips_from_filter(tf->symbol, NULL);
+	return (ret < 0) ? ret : 0;
+}
+
 /* Internal register function - just handle fprobe and flags */
 static int __register_trace_fprobe(struct trace_fprobe *tf)
 {
@@ -870,11 +801,7 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 			return ret;
 	}
 
-	/* Set/clear disabled flag according to tp->flag */
-	if (trace_probe_is_enabled(&tf->tp))
-		tf->fp.flags &= ~FPROBE_FL_DISABLED;
-	else
-		tf->fp.flags |= FPROBE_FL_DISABLED;
+	tf->fp.flags &= ~FPROBE_FL_DISABLED;
 
 	if (trace_fprobe_is_tracepoint(tf)) {
 
@@ -895,10 +822,10 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
 	if (trace_fprobe_is_registered(tf)) {
 		unregister_fprobe(&tf->fp);
 		memset(&tf->fp, 0, sizeof(tf->fp));
-		if (trace_fprobe_is_tracepoint(tf)) {
-			tracepoint_user_put(tf->tuser);
-			tf->tuser = NULL;
-		}
+	}
+	if (trace_fprobe_is_tracepoint(tf)) {
+		tracepoint_user_put(tf->tuser);
+		tf->tuser = NULL;
 	}
 }
 
@@ -958,7 +885,7 @@ static bool trace_fprobe_has_same_fprobe(struct trace_fprobe *orig,
 	return false;
 }
 
-static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
+static int append_trace_fprobe_event(struct trace_fprobe *tf, struct trace_fprobe *to)
 {
 	int ret;
 
@@ -986,7 +913,7 @@ static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
 	if (ret)
 		return ret;
 
-	ret = __register_trace_fprobe(tf);
+	ret = trace_fprobe_verify_target(tf);
 	if (ret)
 		trace_probe_unlink(&tf->tp);
 	else
@@ -995,8 +922,8 @@ static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
 	return ret;
 }
 
-/* Register a trace_probe and probe_event */
-static int register_trace_fprobe(struct trace_fprobe *tf)
+/* Register a trace_probe and probe_event, and check the fprobe is available. */
+static int register_trace_fprobe_event(struct trace_fprobe *tf)
 {
 	struct trace_fprobe *old_tf;
 	int ret;
@@ -1006,7 +933,7 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 	old_tf = find_trace_fprobe(trace_probe_name(&tf->tp),
 				   trace_probe_group_name(&tf->tp));
 	if (old_tf)
-		return append_trace_fprobe(tf, old_tf);
+		return append_trace_fprobe_event(tf, old_tf);
 
 	/* Register new event */
 	ret = register_fprobe_event(tf);
@@ -1019,8 +946,8 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 		return ret;
 	}
 
-	/* Register fprobe */
-	ret = __register_trace_fprobe(tf);
+	/* Verify fprobe is sane. */
+	ret = trace_fprobe_verify_target(tf);
 	if (ret < 0)
 		unregister_fprobe_event(tf);
 	else
@@ -1084,15 +1011,6 @@ static struct tracepoint *find_tracepoint(const char *tp_name,
 }
 
 #ifdef CONFIG_MODULES
-static void reenable_trace_fprobe(struct trace_fprobe *tf)
-{
-	struct trace_probe *tp = &tf->tp;
-
-	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
-		__enable_trace_fprobe(tf);
-	}
-}
-
 /*
  * Find a tracepoint from specified module. In this case, this does not get the
  * module's refcount. The caller must ensure the module is not freed.
@@ -1146,9 +1064,8 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 			}
 
 			/* Finally enable fprobe on this module. */
-			if (!WARN_ON_ONCE(__regsiter_tracepoint_fprobe(tf)) &&
-			    trace_probe_is_enabled(&tf->tp))
-				reenable_trace_fprobe(tf);
+			if (trace_probe_is_enabled(&tf->tp) && !trace_fprobe_is_registered(tf))
+				WARN_ON_ONCE(__regsiter_tracepoint_fprobe(tf));
 		} else if (val == MODULE_STATE_GOING) {
 			tuser = tf->tuser;
 			/* Unregister all tracepoint_user in this module. */
@@ -1394,7 +1311,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	if (ret < 0)
 		return ret;
 
-	ret = register_trace_fprobe(tf);
+	ret = register_trace_fprobe_event(tf);
 	if (ret) {
 		trace_probe_log_set_index(1);
 		if (ret == -EILSEQ)
@@ -1463,6 +1380,84 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 	return 0;
 }
 
+/*
+ * Enable trace_probe
+ * if the file is NULL, enable "perf" handler, or enable "trace" handler.
+ */
+static int enable_trace_fprobe(struct trace_event_call *call,
+			       struct trace_event_file *file)
+{
+	struct trace_probe *tp;
+	struct trace_fprobe *tf;
+	bool enabled;
+	int ret = 0;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+	enabled = trace_probe_is_enabled(tp);
+
+	/* This also changes "enabled" state */
+	if (file) {
+		ret = trace_probe_add_file(tp, file);
+		if (ret)
+			return ret;
+	} else
+		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
+
+	if (!enabled) {
+		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
+			ret = __register_trace_fprobe(tf);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Disable trace_probe
+ * if the file is NULL, disable "perf" handler, or disable "trace" handler.
+ */
+static int disable_trace_fprobe(struct trace_event_call *call,
+				struct trace_event_file *file)
+{
+	struct trace_fprobe *tf;
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+
+	if (file) {
+		if (!trace_probe_get_file_link(tp, file))
+			return -ENOENT;
+		if (!trace_probe_has_single_file(tp))
+			goto out;
+		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
+	} else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+
+	if (!trace_probe_is_enabled(tp)) {
+		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
+			unregister_fprobe(&tf->fp);
+		}
+	}
+
+ out:
+	if (file)
+		/*
+		 * Synchronization is done in below function. For perf event,
+		 * file == NULL and perf_trace_event_unreg() calls
+		 * tracepoint_synchronize_unregister() to ensure synchronize
+		 * event. We don't need to care about it.
+		 */
+		trace_probe_remove_file(tp, file);
+
+	return 0;
+}
+
 /*
  * called by perf_trace_init() or __ftrace_set_clr_event() under event_mutex.
  */

