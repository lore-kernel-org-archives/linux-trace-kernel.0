Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872518B47C;
	Sun, 16 Mar 2025 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127697; cv=none; b=HEMIuDESFUyMQdThPfrpjhZ5shbiV+9Cb/s+qEtj6gq0M/pgyl+QJ1xb9xfXXwgx57cWVBHw3VdBIqDoT0PZJ3W5xtE1Zdf0YcRMno/ceOZ4XyVC4kKwvB+q/lkNStSFOX25W0L0l5Do/Bj3HCxQUHUNg8ta1ljVce705TCgilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127697; c=relaxed/simple;
	bh=lp4YDB/hAqNvIoicxsUzWvZXZHDX4oGJ7AOP3B9m0Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juwRL8iOjpad7929F7SreYUm6/jm+NsXbAiXiLh0jnOD7O/iFBVB5t8bUMV9I3WyM3mVLAkQiGh5TgPjoNnk/B5gzFH0usYu7Zpxa9ZDwdGUUpQdZ2F9EowI10ImjQNHdXbUuytawJhfINmGdpvD7mYoq+WfSnnU/c3d0c/ZYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0j/3HMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0j/3HMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E160BC4CEDD;
	Sun, 16 Mar 2025 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742127697;
	bh=lp4YDB/hAqNvIoicxsUzWvZXZHDX4oGJ7AOP3B9m0Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0j/3HMDdipVXotHjAVEtEspUV6zGkr5JasnS5aOCNiS8UicSBIsyxUhStx/ra9/E
	 hFPuxRfCzIhE9jCdHMcBk9AvFJDFvaLUTJddTH2AsXjFViXaKc2Tf2k4txXdOMlhhO
	 D8kA6R6iZp2U8vIuzkUdeB6mKqrjmyqdHQU1yloHwHYkjHrs2wPN3NOyVx0Nlr7BhY
	 AHqRkzA9x+xZLyIbtqyK/j/O2ryvC2WyCxuwwKSO6WH4reghWkUyNoOhTy8lvfji82
	 ml6XzFmj3DAIh1/qX3PjDTYV8pcEgSsZ/JDKOdLdhGdYkXc8dAc+iQYjryT1Hjul/q
	 mXNFGaJLDjsKQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/4] tracing: tprobe-events: Support multiple tprobes on the same tracepoint
Date: Sun, 16 Mar 2025 21:21:33 +0900
Message-ID: <174212769289.348872.12945848497242748827.stgit@devnote2>
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

Allow user to set multiple tracepoint-probe events on the same
tracepoint. After the last tprobe-event is removed, the tracepoint
callback is unregistered.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/module.h      |    4 +
 kernel/trace/trace_fprobe.c |  259 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 208 insertions(+), 55 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 30e5b19bafa9..01d5208cf473 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -14,6 +14,7 @@
 #include <linux/buildid.h>
 #include <linux/compiler.h>
 #include <linux/cache.h>
+#include <linux/cleanup.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/elf.h>
@@ -1027,4 +1028,7 @@ static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
 
 #endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
+/* Define __free(module_put) macro for struct module *. */
+DEFINE_FREE(module_put, struct module *, if (_T) module_put(_T))
+
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 08def94f9ca6..863c9343a939 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -21,7 +21,6 @@
 #define FPROBE_EVENT_SYSTEM "fprobes"
 #define TRACEPOINT_EVENT_SYSTEM "tracepoints"
 #define RETHOOK_MAXACTIVE_MAX 4096
-#define TRACEPOINT_STUB ERR_PTR(-ENOENT)
 
 static int trace_fprobe_create(const char *raw_command);
 static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
@@ -38,6 +37,89 @@ static struct dyn_event_operations trace_fprobe_ops = {
 	.match = trace_fprobe_match,
 };
 
+struct tracepoint_user {
+	struct tracepoint	*tpoint;
+	unsigned int		refcount;
+};
+
+static bool tracepoint_user_is_registered(struct tracepoint_user *tuser)
+{
+	return tuser && tuser->tpoint;
+}
+
+static int tracepoint_user_register(struct tracepoint_user *tuser)
+{
+	struct tracepoint *tpoint = tuser->tpoint;
+
+	if (!tpoint)
+		return 0;
+
+	return tracepoint_probe_register_prio_may_exist(tpoint,
+					tpoint->probestub, NULL, 0);
+}
+
+static void tracepoint_user_unregister(struct tracepoint_user *tuser)
+{
+	if (!tuser->tpoint)
+		return;
+
+	WARN_ON_ONCE(tracepoint_probe_unregister(tuser->tpoint, tuser->tpoint->probestub, NULL));
+	tuser->tpoint = NULL;
+}
+
+static unsigned long tracepoint_user_ip(struct tracepoint_user *tuser)
+{
+	if (!tuser->tpoint)
+		return 0UL;
+
+	return (unsigned long)tuser->tpoint->probestub;
+}
+
+static bool tracepoint_user_within_module(struct tracepoint_user *tuser,
+					  struct module *mod)
+{
+	return within_module(tracepoint_user_ip(tuser), mod);
+}
+
+static struct tracepoint_user *tracepoint_user_allocate(struct tracepoint *tpoint)
+{
+	struct tracepoint_user *tuser __free(kfree) = NULL;
+
+	tuser = kzalloc(sizeof(*tuser), GFP_KERNEL);
+	if (!tuser)
+		return NULL;
+	tuser->tpoint = tpoint;
+	tuser->refcount = 1;
+
+	return_ptr(tuser);
+}
+
+/* These must be called with event_mutex */
+static void tracepoint_user_get(struct tracepoint_user *tuser)
+{
+	tuser->refcount++;
+}
+
+static void tracepoint_user_put(struct tracepoint_user *tuser)
+{
+	if (--tuser->refcount > 0)
+		return;
+
+	if (tracepoint_user_is_registered(tuser))
+		tracepoint_user_unregister(tuser);
+	kfree(tuser);
+}
+
+static const char *tracepoint_user_lookup(struct tracepoint_user *tuser, char *buf)
+{
+	struct tracepoint *tpoint = tuser->tpoint;
+
+	if (!tpoint)
+		return NULL;
+
+	return kallsyms_lookup((unsigned long)tpoint->probestub, NULL, NULL, NULL, buf);
+}
+
 /*
  * Fprobe event core functions
  */
@@ -45,7 +127,7 @@ struct trace_fprobe {
 	struct dyn_event	devent;
 	struct fprobe		fp;
 	const char		*symbol;
-	struct tracepoint	*tpoint;
+	struct tracepoint_user	*tuser;
 	struct trace_probe	tp;
 };
 
@@ -75,7 +157,7 @@ static bool trace_fprobe_is_return(struct trace_fprobe *tf)
 
 static bool trace_fprobe_is_tracepoint(struct trace_fprobe *tf)
 {
-	return tf->tpoint != NULL;
+	return tf->tuser != NULL;
 }
 
 static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
@@ -125,6 +207,57 @@ static bool trace_fprobe_is_registered(struct trace_fprobe *tf)
 	return fprobe_is_registered(&tf->fp);
 }
 
+static struct tracepoint *find_tracepoint(const char *tp_name,
+	struct module **tp_mod);
+
+/*
+ * Get tracepoint_user if exist, or allocate new one. If tracepoint is on a
+ * module, get its refcounter.
+ */
+static struct tracepoint_user *
+trace_fprobe_get_tracepoint_user(const char *name, struct module **pmod)
+{
+	struct tracepoint_user *tuser __free(kfree) = NULL;
+	struct tracepoint *tpoint;
+	struct trace_fprobe *tf;
+	struct dyn_event *dpos;
+	struct module *mod __free(module_put) = NULL;
+	int ret;
+
+	tpoint = find_tracepoint(name, &mod);
+	if (mod && !try_module_get(mod)) {
+		mod = NULL;
+		tpoint = NULL;
+	}
+	/* tpoint can be NULL, but we don't care here. */
+
+	/* Search existing tracepoint_user */
+	for_each_trace_fprobe(tf, dpos) {
+		if (!trace_fprobe_is_tracepoint(tf))
+			continue;
+		if (!strcmp(tf->symbol, name)) {
+			tracepoint_user_get(tf->tuser);
+			*pmod = no_free_ptr(mod);
+			return tf->tuser;
+		}
+	}
+
+	/* Not found, allocate and register new tracepoint_user. */
+	tuser = tracepoint_user_allocate(tpoint);
+	if (!tuser)
+		return NULL;
+
+	if (tpoint) {
+		/* If the tracepoint is not loaded, tpoint can be NULL. */
+		ret = tracepoint_user_register(tuser);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	*pmod = no_free_ptr(mod);
+	return_ptr(tuser);
+}
+
 /*
  * Note that we don't verify the fetch_insn code, since it does not come
  * from user space.
@@ -410,6 +543,8 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
 {
 	if (tf) {
 		trace_probe_cleanup(&tf->tp);
+		if (tf->tuser)
+			tracepoint_user_put(tf->tuser);
 		kfree(tf->symbol);
 		kfree(tf);
 	}
@@ -424,7 +559,7 @@ DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *, if (!IS_ERR_OR_NULL(_T)) f
 static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       const char *event,
 					       const char *symbol,
-					       struct tracepoint *tpoint,
+					       struct tracepoint_user *tuser,
 					       int nargs, bool is_return)
 {
 	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
@@ -443,7 +578,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 	else
 		tf->fp.entry_handler = fentry_dispatcher;
 
-	tf->tpoint = tpoint;
+	tf->tuser = tuser;
 
 	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
 	if (ret < 0)
@@ -709,19 +844,11 @@ static int unregister_fprobe_event(struct trace_fprobe *tf)
 
 static int __regsiter_tracepoint_fprobe(struct trace_fprobe *tf)
 {
-	struct tracepoint *tpoint = tf->tpoint;
-	unsigned long ip = (unsigned long)tpoint->probestub;
-	int ret;
+	unsigned long ip = tracepoint_user_ip(tf->tuser);
+
+	if (!ip)
+		return -ENOENT;
 
-	/*
-	 * Here, we do 2 steps to enable fprobe on a tracepoint.
-	 * At first, put __probestub_##TP function on the tracepoint
-	 * and put a fprobe on the stub function.
-	 */
-	ret = tracepoint_probe_register_prio_may_exist(tpoint,
-				tpoint->probestub, NULL, 0);
-	if (ret < 0)
-		return ret;
 	return register_fprobe_ips(&tf->fp, &ip, 1);
 }
 
@@ -753,7 +880,7 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 	if (trace_fprobe_is_tracepoint(tf)) {
 
 		/* This tracepoint is not loaded yet */
-		if (tf->tpoint == TRACEPOINT_STUB)
+		if (!tracepoint_user_is_registered(tf->tuser))
 			return 0;
 
 		return __regsiter_tracepoint_fprobe(tf);
@@ -770,9 +897,8 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
 		unregister_fprobe(&tf->fp);
 		memset(&tf->fp, 0, sizeof(tf->fp));
 		if (trace_fprobe_is_tracepoint(tf)) {
-			tracepoint_probe_unregister(tf->tpoint,
-					tf->tpoint->probestub, NULL);
-			tf->tpoint = NULL;
+			tracepoint_user_put(tf->tuser);
+			tf->tuser = NULL;
 		}
 	}
 }
@@ -975,7 +1101,7 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 					unsigned long val, void *data)
 {
 	struct tp_module *tp_mod = data;
-	struct tracepoint *tpoint;
+	struct tracepoint_user *tuser;
 	struct trace_fprobe *tf;
 	struct dyn_event *pos;
 
@@ -984,21 +1110,48 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 
 	mutex_lock(&event_mutex);
 	for_each_trace_fprobe(tf, pos) {
-		if (val == MODULE_STATE_COMING && tf->tpoint == TRACEPOINT_STUB) {
+		if (!trace_fprobe_is_tracepoint(tf))
+			continue;
+
+		if (val == MODULE_STATE_COMING) {
+			/*
+			 * If any tracepoint used by tprobe is in the module,
+			 * register the stub.
+			 */
+			struct tracepoint *tpoint;
+
 			tpoint = find_tracepoint_in_module(tp_mod->mod, tf->symbol);
-			if (tpoint) {
-				tf->tpoint = tpoint;
-				if (!WARN_ON_ONCE(__regsiter_tracepoint_fprobe(tf)) &&
-				    trace_probe_is_enabled(&tf->tp))
-					reenable_trace_fprobe(tf);
-			}
-		} else if (val == MODULE_STATE_GOING && tp_mod->mod == tf->mod) {
-			unregister_fprobe(&tf->fp);
-			if (trace_fprobe_is_tracepoint(tf)) {
-				tracepoint_probe_unregister(tf->tpoint,
-					tf->tpoint->probestub, NULL);
-				tf->tpoint = TRACEPOINT_STUB;
+			/* This is not a tracepoint in this module. Skip it. */
+			if (!tpoint)
+				continue;
+
+			tuser = tf->tuser;
+			/* If the tracepoint is no registered yet, register it. */
+			if (!tracepoint_user_is_registered(tuser)) {
+				tuser->tpoint = tpoint;
+				if (WARN_ON_ONCE(tracepoint_user_register(tuser)))
+					continue;
 			}
+
+			/* Finally enable fprobe on this module. */
+			if (!WARN_ON_ONCE(__regsiter_tracepoint_fprobe(tf)) &&
+			    trace_probe_is_enabled(&tf->tp))
+				reenable_trace_fprobe(tf);
+		} else if (val == MODULE_STATE_GOING) {
+			tuser = tf->tuser;
+			/* Unregister all tracepoint_user in this module. */
+			if (tracepoint_user_is_registered(tuser) &&
+			    tracepoint_user_within_module(tuser, tp_mod->mod))
+				tracepoint_user_unregister(tuser);
+
+			/*
+			 * Here we need to handle shared tracepoint_user case.
+			 * Such tuser is unregistered, but trace_fprobe itself
+			 * is registered. (Note this only handles tprobes.)
+			 */
+			if (!tracepoint_user_is_registered(tuser) &&
+			    trace_fprobe_is_registered(tf))
+				unregister_fprobe(&tf->fp);
 		}
 	}
 	mutex_unlock(&event_mutex);
@@ -1067,7 +1220,9 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	return 0;
 }
 
-DEFINE_FREE(module_put, struct module *, if (_T) module_put(_T))
+DEFINE_FREE(tuser_put, struct tracepoint_user *,
+	if (!IS_ERR_OR_NULL(_T))
+		tracepoint_user_put(_T))
 
 static int trace_fprobe_create_internal(int argc, const char *argv[],
 					struct traceprobe_parse_context *ctx)
@@ -1097,6 +1252,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
+	struct tracepoint_user *tuser __free(tuser_put) = NULL;
+	struct module *mod __free(module_put) = NULL;
 	int i, new_argc = 0, ret = 0;
 	bool is_return = false;
 	char *symbol __free(kfree) = NULL;
@@ -1108,8 +1265,6 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	char abuf[MAX_BTF_ARGS_LEN];
 	char *dbuf __free(kfree) = NULL;
 	bool is_tracepoint = false;
-	struct module *tp_mod __free(module_put) = NULL;
-	struct tracepoint *tpoint = NULL;
 
 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
 		return -ECANCELED;
@@ -1162,25 +1317,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
 	if (is_tracepoint) {
 		ctx->flags |= TPARG_FL_TPOINT;
-		tpoint = find_tracepoint(symbol, &tp_mod);
-		/* lock module until register this tprobe. */
-		if (tp_mod && !try_module_get(tp_mod)) {
-			tpoint = NULL;
-			tp_mod = NULL;
-		}
-		if (tpoint) {
-			ctx->funcname = kallsyms_lookup(
-				(unsigned long)tpoint->probestub,
-				NULL, NULL, NULL, sbuf);
-		} else if (IS_ENABLED(CONFIG_MODULES)) {
-				/* This *may* be loaded afterwards */
-				tpoint = TRACEPOINT_STUB;
-				ctx->funcname = symbol;
-		} else {
+		tuser = trace_fprobe_get_tracepoint_user(symbol, &mod);
+		if (!tuser)
+			return -ENOMEM;
+		if (IS_ERR(tuser)) {
 			trace_probe_log_set_index(1);
 			trace_probe_log_err(0, NO_TRACEPOINT);
-			return -EINVAL;
+			return PTR_ERR(tuser);
 		}
+		ctx->funcname = tracepoint_user_lookup(tuser, sbuf);
+		/* If tracepoint is not loaded yet, use symbol name as funcname. */
+		if (!ctx->funcname)
+			ctx->funcname = symbol;
 	} else
 		ctx->funcname = symbol;
 
@@ -1204,13 +1352,14 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		return ret;
 
 	/* setup a probe */
-	tf = alloc_trace_fprobe(group, event, symbol, tpoint, argc, is_return);
+	tf = alloc_trace_fprobe(group, event, symbol, tuser, argc, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
 		return ret;
 	}
+	tuser = NULL; /* Move tuser to tf. */
 
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {

