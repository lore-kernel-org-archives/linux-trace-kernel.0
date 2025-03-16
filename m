Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA71A3175;
	Sun, 16 Mar 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127707; cv=none; b=JLLhBkJcdwnG5ObUGFrH3G1sionox4Gtwb3SoFebbmGFVsMTHmtwh5wCyr3l3aGXpXyLwZ0WTyG2W/a9ENLNtnYpR1SE72ODe9/MYG0iqVagLPTrrMAQzEzeO0fokUNOaNdEzZrGSRhHuv1NzAhFFl9ey5RtItqYerQ46OhZ1HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127707; c=relaxed/simple;
	bh=bBYHEjoEDIrgh2tzmkSng7ANeEMzqqTfDt0ky2Xlg1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJrigUHC7gwjnTjfjxk9uQq3iEJn5Gma0P3/JitcXPllaFI43c995G1Dej/emGNZCOphW1lF/Pnw76StVw6ScLD179LdY+SWv3gC881jKhJqQ2fXCi8CBKe6O8mcvqAoURS4QYi9qbD33Ma0BbAuMtTLRxKC3TiEr/0FqRSqBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuAKH3Vd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuAKH3Vd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC54C4CEDD;
	Sun, 16 Mar 2025 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742127706;
	bh=bBYHEjoEDIrgh2tzmkSng7ANeEMzqqTfDt0ky2Xlg1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuAKH3VdYgKcNealxOivgsaSFEVYxXUhrqy7LSTGBCrTWi+TX1aH0s8GdFZF584Jv
	 Mdg+Zcn6NDhLFIlqC8LKEwzuEjNBIKAhDAmY2GbPNXTWUu0v/5pzSDrlgD97UHkVD1
	 DJA3Plz8oe27e9gjmxX9IIMdWfOqhybarCitwzV0opapiJKHzJXd+S+qZdQzw+I8F8
	 q+1r7DlZ/bYBJJZlnZT8L2m2uvdj2acsnPZ5nmX20u0SaTJS9/zoJ3ndw2/C/mC5SF
	 DbGiBcImReIyqUEIQROqHNn13YfC6WQpEKPdZa3VG8JYIsjCzP1bix10RJ3noOKNpG
	 L3ilgPgCFK4Ew==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/4] tracing: fprobe-events: Register fprobe-events only when it is enabled
Date: Sun, 16 Mar 2025 21:21:42 +0900
Message-ID: <174212770238.348872.12106623852892827796.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <174212767109.348872.18231451508464729427.stgit@devnote2>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
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
 include/linux/fprobe.h      |    8 +
 kernel/trace/fprobe.c       |   29 +++--
 kernel/trace/trace_fprobe.c |  234 +++++++++++++++++++++----------------------
 3 files changed, 140 insertions(+), 131 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 702099f08929..9635a24d5a25 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -94,6 +94,8 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
 int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
 int unregister_fprobe(struct fprobe *fp);
 bool fprobe_is_registered(struct fprobe *fp);
+int fprobe_alloc_ip_list_from_filter(const char *filter, const char *notfilter,
+	unsigned long **addrs);
 #else
 static inline int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
 {
@@ -115,6 +117,12 @@ static inline bool fprobe_is_registered(struct fprobe *fp)
 {
 	return false;
 }
+static inline int fprobe_alloc_ip_list_from_filter(const char *filter,
+						   const char *notfilter,
+						   unsigned long **addrs)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /**
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 33082c4e8154..05050f1c2239 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -486,6 +486,24 @@ static int ip_list_from_filter(const char *filter, const char *notfilter,
 	return match.index ?: -ENOENT;
 }
 
+#define FPROBE_IPS_MAX	INT_MAX
+
+int fprobe_alloc_ip_list_from_filter(const char *filter, const char *notfilter,
+				     unsigned long **addrs)
+{
+	int ret;
+
+	/* Count the number of ips from filter. */
+	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
+	if (ret < 0)
+		return ret;
+
+	*addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
+	if (!*addrs)
+		return -ENOMEM;
+	return ip_list_from_filter(filter, notfilter, *addrs, ret);
+}
+
 static void fprobe_fail_cleanup(struct fprobe *fp)
 {
 	kfree(fp->hlist_array);
@@ -528,8 +546,6 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
 	return 0;
 }
 
-#define FPROBE_IPS_MAX	INT_MAX
-
 /**
  * register_fprobe() - Register fprobe to ftrace by pattern.
  * @fp: A fprobe data structure to be registered.
@@ -549,14 +565,7 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 	if (!fp || !filter)
 		return -EINVAL;
 
-	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
-	if (ret < 0)
-		return ret;
-
-	addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
-	if (!addrs)
-		return -ENOMEM;
-	ret = ip_list_from_filter(filter, notfilter, addrs, ret);
+	ret = fprobe_alloc_ip_list_from_filter(filter, notfilter, &addrs);
 	if (ret > 0)
 		ret = register_fprobe_ips(fp, addrs, ret);
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 863c9343a939..ac3b0a34810a 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -601,98 +601,6 @@ static struct trace_fprobe *find_trace_fprobe(const char *event,
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
@@ -852,6 +760,26 @@ static int __regsiter_tracepoint_fprobe(struct trace_fprobe *tf)
 	return register_fprobe_ips(&tf->fp, &ip, 1);
 }
 
+/* Returns an error if the target function is not available, or 0 */
+static int trace_fprobe_verify_target(struct trace_fprobe *tf)
+{
+	unsigned long *addrs __free(kfree) = NULL;
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
+	ret = fprobe_alloc_ip_list_from_filter(tf->symbol, NULL, &addrs);
+	return (ret < 0) ? ret : 0;
+}
+
 /* Internal register function - just handle fprobe and flags */
 static int __register_trace_fprobe(struct trace_fprobe *tf)
 {
@@ -871,11 +799,7 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 			return ret;
 	}
 
-	/* Set/clear disabled flag according to tp->flag */
-	if (trace_probe_is_enabled(&tf->tp))
-		tf->fp.flags &= ~FPROBE_FL_DISABLED;
-	else
-		tf->fp.flags |= FPROBE_FL_DISABLED;
+	tf->fp.flags &= ~FPROBE_FL_DISABLED;
 
 	if (trace_fprobe_is_tracepoint(tf)) {
 
@@ -896,10 +820,10 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
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
 
@@ -959,7 +883,7 @@ static bool trace_fprobe_has_same_fprobe(struct trace_fprobe *orig,
 	return false;
 }
 
-static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
+static int append_trace_fprobe_event(struct trace_fprobe *tf, struct trace_fprobe *to)
 {
 	int ret;
 
@@ -987,7 +911,7 @@ static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
 	if (ret)
 		return ret;
 
-	ret = __register_trace_fprobe(tf);
+	ret = trace_fprobe_verify_target(tf);
 	if (ret)
 		trace_probe_unlink(&tf->tp);
 	else
@@ -996,8 +920,8 @@ static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
 	return ret;
 }
 
-/* Register a trace_probe and probe_event */
-static int register_trace_fprobe(struct trace_fprobe *tf)
+/* Register a trace_probe and probe_event, and check the fprobe is available. */
+static int register_trace_fprobe_event(struct trace_fprobe *tf)
 {
 	struct trace_fprobe *old_tf;
 	int ret;
@@ -1007,7 +931,7 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 	old_tf = find_trace_fprobe(trace_probe_name(&tf->tp),
 				   trace_probe_group_name(&tf->tp));
 	if (old_tf)
-		return append_trace_fprobe(tf, old_tf);
+		return append_trace_fprobe_event(tf, old_tf);
 
 	/* Register new event */
 	ret = register_fprobe_event(tf);
@@ -1020,8 +944,8 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 		return ret;
 	}
 
-	/* Register fprobe */
-	ret = __register_trace_fprobe(tf);
+	/* Verify fprobe is sane. */
+	ret = trace_fprobe_verify_target(tf);
 	if (ret < 0)
 		unregister_fprobe_event(tf);
 	else
@@ -1075,15 +999,6 @@ static struct tracepoint *find_tracepoint(const char *tp_name,
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
 /* Find a tracepoint from specified module. */
 static struct tracepoint *find_tracepoint_in_module(struct module *mod,
 						    const char *tp_name)
@@ -1134,9 +1049,8 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
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
@@ -1385,7 +1299,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	if (ret < 0)
 		return ret;
 
-	ret = register_trace_fprobe(tf);
+	ret = register_trace_fprobe_event(tf);
 	if (ret) {
 		trace_probe_log_set_index(1);
 		if (ret == -EILSEQ)
@@ -1454,6 +1368,84 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
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

