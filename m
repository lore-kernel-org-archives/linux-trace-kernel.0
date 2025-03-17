Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7D21ABCC;
	Mon, 17 Mar 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198601; cv=none; b=uRb9UWi7/jG9d6r+NcW5k7r+3I1hFKbNFr1djon0pdzGEYQSsfBizavSJq7FpyzXpEEbrQ7MCkCS0HBUlcdMP7/nExbs1U5hzsRlKS8zmfav1u40t2CqDapHKokOjvDahl+YwnZUqX5jUyDrS9rDa3jFSsWb9gIRd3UEYFD2Q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198601; c=relaxed/simple;
	bh=tl7g7tnLHVkIpMwuft/E0gPaRqKFHy7aKobfLmft7/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/8h1KPrJRFyC5HQyu3qLcX+HWWxCcMpHFmS8JlaF5uFX3YmL8e4Iq/z5616sQc4ADRD65x+mZW8adGu7p4O5TvSv2IBtC2kGMifG7/yprOvnzo1kTV6X4faee/FulvTkNBqrNN83XdgDgQc2wWlIxtXVx4ZJALcizqVdtF7TrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6jyJ4Jg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6jyJ4Jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EC3C4CEE3;
	Mon, 17 Mar 2025 08:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742198600;
	bh=tl7g7tnLHVkIpMwuft/E0gPaRqKFHy7aKobfLmft7/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6jyJ4JgnJqWcyOKsNzUpfJrRqsU4ztN8Bsdxrli9HjMUSaiWS+TslQaFbiK04kbG
	 DBMjE6MKkz6WrGTXyc0cEJbx3kxbbRh0OVZtViS24SlaAGJ56HH2EL0rnUucwhJGTZ
	 Xgh4wpDFezE8n/YOgJgt1QmpJ03Z3FXFJleaSnzeyEQEk8X2nZtS9u4EwujYcGD+37
	 VzM2PVRT6dhundulCq2Ys4MDvm88LheKBf41RnJDiruO2yimrXegJgfa5Z2Nffnz1I
	 ya8d1FcbWQ0ucksPfjFjW9PNIs+HoU5kYlEO0WiOyCizzqqM1raaFi+xTKjfVH+6qF
	 WjPWpvYbP7SCA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH] tracing: tprobe-events: Register tracepoint when enable tprobe event
Date: Mon, 17 Mar 2025 17:03:16 +0900
Message-ID: <174219859655.549159.12584048778295152488.stgit@devnote2>
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

As same as fprobe, register tracepoint stub function only when enabling
tprobe events. The major changes are introducing a list of
tracepoint_user and its lock, and tprobe_event_module_nb, which is
another module notifier for module loading/unloading.  By spliting the
lock from event_mutex and a module notifier for trace_fprobe, it
solved AB-BA lock dependency issue between event_mutex and
tracepoint_module_list_mutex.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |  382 +++++++++++++++++++++++++------------------
 1 file changed, 218 insertions(+), 164 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index ac3b0a34810a..2c4352f4dc11 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -7,7 +7,9 @@
 #include <asm/ptrace.h>
 
 #include <linux/fprobe.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/rculist.h>
 #include <linux/security.h>
 #include <linux/tracepoint.h>
@@ -37,15 +39,21 @@ static struct dyn_event_operations trace_fprobe_ops = {
 	.match = trace_fprobe_match,
 };
 
+/* List of tracepoint_user */
+static LIST_HEAD(tracepoint_user_list);
+static DEFINE_MUTEX(tracepoint_user_mutex);
+
+/* While living tracepoint_user, @tpoint can be NULL and @refcount != 0. */
 struct tracepoint_user {
+	struct list_head	list;
+	const char		*name;
 	struct tracepoint	*tpoint;
 	unsigned int		refcount;
 };
 
-static bool tracepoint_user_is_registered(struct tracepoint_user *tuser)
-{
-	return tuser && tuser->tpoint;
-}
+/* NOTE: you must lock tracepoint_user_mutex. */
+#define for_each_tracepoint_user(tuser)		\
+	list_for_each_entry(tuser, &tracepoint_user_list, list)
 
 static int tracepoint_user_register(struct tracepoint_user *tuser)
 {
@@ -75,58 +83,112 @@ static unsigned long tracepoint_user_ip(struct tracepoint_user *tuser)
 	return (unsigned long)tuser->tpoint->probestub;
 }
 
-static bool tracepoint_user_within_module(struct tracepoint_user *tuser,
-					  struct module *mod)
+static void __tracepoint_user_free(struct tracepoint_user *tuser)
 {
-	return within_module(tracepoint_user_ip(tuser), mod);
+	if (!tuser)
+		return;
+	kfree(tuser->name);
+	kfree(tuser);
 }
 
-static struct tracepoint_user *tracepoint_user_allocate(struct tracepoint *tpoint)
+DEFINE_FREE(tuser_free, struct tracepoint_user *, __tracepoint_user_free(_T))
+
+static struct tracepoint_user *__tracepoint_user_init(const char *name, struct tracepoint *tpoint)
 {
-	struct tracepoint_user *tuser __free(kfree) = NULL;
+	struct tracepoint_user *tuser __free(tuser_free) = NULL;
+	int ret;
 
 	tuser = kzalloc(sizeof(*tuser), GFP_KERNEL);
 	if (!tuser)
 		return NULL;
+	tuser->name = kstrdup(name, GFP_KERNEL);
+	if (!tuser->name)
+		return NULL;
+
+	if (tpoint) {
+		ret = tracepoint_user_register(tuser);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	tuser->tpoint = tpoint;
 	tuser->refcount = 1;
+	INIT_LIST_HEAD(&tuser->list);
+	list_add(&tuser->list, &tracepoint_user_list);
 
 	return_ptr(tuser);
 }
 
-/* These must be called with event_mutex */
-static void tracepoint_user_get(struct tracepoint_user *tuser)
-{
-	tuser->refcount++;
-}
+static struct tracepoint *find_tracepoint(const char *tp_name,
+	struct module **tp_mod);
 
-static void tracepoint_user_put(struct tracepoint_user *tuser)
+/*
+ * Get tracepoint_user if exist, or allocate new one and register it.
+ * If tracepoint is on a module, get its refcounter too.
+ * This returns errno or NULL (not loaded yet) or tracepoint_user.
+ */
+static struct tracepoint_user *tracepoint_user_find_get(const char *name, struct module **pmod)
 {
-	if (--tuser->refcount > 0)
-		return;
+	struct module *mod __free(module_put) = NULL;
+	struct tracepoint_user *tuser;
+	struct tracepoint *tpoint;
 
-	if (tracepoint_user_is_registered(tuser))
-		tracepoint_user_unregister(tuser);
-	kfree(tuser);
+	/* Get and lock the module which has tracepoint. */
+	tpoint = find_tracepoint(name, &mod);
+	if (mod && !try_module_get(mod)) {
+		mod = NULL;
+		tpoint = NULL;
+	}
+
+	guard(mutex)(&tracepoint_user_mutex);
+	/* Search existing tracepoint_user */
+	for_each_tracepoint_user(tuser) {
+		if (!strcmp(tuser->name, name)) {
+			tuser->refcount++;
+			*pmod = no_free_ptr(mod);
+			return tuser;
+		}
+	}
+
+	/* The corresponding tracepoint_user is not found. */
+	tuser = __tracepoint_user_init(name, tpoint);
+	if (!IS_ERR_OR_NULL(tuser))
+		*pmod = no_free_ptr(mod);
+
+	return tuser;
 }
 
-static const char *tracepoint_user_lookup(struct tracepoint_user *tuser, char *buf)
+static void tracepoint_user_put(struct tracepoint_user *tuser)
 {
-	struct tracepoint *tpoint = tuser->tpoint;
+	scoped_guard(mutex, &tracepoint_user_mutex) {
+		if (--tuser->refcount > 0)
+			return;
 
-	if (!tpoint)
-		return NULL;
+		list_del(&tuser->list);
+		tracepoint_user_unregister(tuser);
+	}
 
-	return kallsyms_lookup((unsigned long)tpoint->probestub, NULL, NULL, NULL, buf);
+	__tracepoint_user_free(tuser);
 }
 
+DEFINE_FREE(tuser_put, struct tracepoint_user *,
+	if (!IS_ERR_OR_NULL(_T))
+		tracepoint_user_put(_T))
+
 /*
  * Fprobe event core functions
  */
+
+/*
+ * @tprobe is true for tracepoint probe.
+ * @tuser can be NULL if the trace_fprobe is disabled or the tracepoint is not
+ * loaded with a module. If @tuser != NULL, this trace_fprobe is enabled.
+ */
 struct trace_fprobe {
 	struct dyn_event	devent;
 	struct fprobe		fp;
 	const char		*symbol;
+	bool			tprobe;
 	struct tracepoint_user	*tuser;
 	struct trace_probe	tp;
 };
@@ -157,7 +219,7 @@ static bool trace_fprobe_is_return(struct trace_fprobe *tf)
 
 static bool trace_fprobe_is_tracepoint(struct trace_fprobe *tf)
 {
-	return tf->tuser != NULL;
+	return tf->tprobe;
 }
 
 static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
@@ -207,57 +269,6 @@ static bool trace_fprobe_is_registered(struct trace_fprobe *tf)
 	return fprobe_is_registered(&tf->fp);
 }
 
-static struct tracepoint *find_tracepoint(const char *tp_name,
-	struct module **tp_mod);
-
-/*
- * Get tracepoint_user if exist, or allocate new one. If tracepoint is on a
- * module, get its refcounter.
- */
-static struct tracepoint_user *
-trace_fprobe_get_tracepoint_user(const char *name, struct module **pmod)
-{
-	struct tracepoint_user *tuser __free(kfree) = NULL;
-	struct tracepoint *tpoint;
-	struct trace_fprobe *tf;
-	struct dyn_event *dpos;
-	struct module *mod __free(module_put) = NULL;
-	int ret;
-
-	tpoint = find_tracepoint(name, &mod);
-	if (mod && !try_module_get(mod)) {
-		mod = NULL;
-		tpoint = NULL;
-	}
-	/* tpoint can be NULL, but we don't care here. */
-
-	/* Search existing tracepoint_user */
-	for_each_trace_fprobe(tf, dpos) {
-		if (!trace_fprobe_is_tracepoint(tf))
-			continue;
-		if (!strcmp(tf->symbol, name)) {
-			tracepoint_user_get(tf->tuser);
-			*pmod = no_free_ptr(mod);
-			return tf->tuser;
-		}
-	}
-
-	/* Not found, allocate and register new tracepoint_user. */
-	tuser = tracepoint_user_allocate(tpoint);
-	if (!tuser)
-		return NULL;
-
-	if (tpoint) {
-		/* If the tracepoint is not loaded, tpoint can be NULL. */
-		ret = tracepoint_user_register(tuser);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
-	*pmod = no_free_ptr(mod);
-	return_ptr(tuser);
-}
-
 /*
  * Note that we don't verify the fetch_insn code, since it does not come
  * from user space.
@@ -559,8 +570,8 @@ DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *, if (!IS_ERR_OR_NULL(_T)) f
 static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       const char *event,
 					       const char *symbol,
-					       struct tracepoint_user *tuser,
-					       int nargs, bool is_return)
+					       int nargs, bool is_return,
+					       bool is_tracepoint)
 {
 	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
 	int ret = -ENOMEM;
@@ -578,7 +589,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 	else
 		tf->fp.entry_handler = fentry_dispatcher;
 
-	tf->tuser = tuser;
+	tf->tprobe = is_tracepoint;
 
 	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
 	if (ret < 0)
@@ -752,12 +763,35 @@ static int unregister_fprobe_event(struct trace_fprobe *tf)
 
 static int __regsiter_tracepoint_fprobe(struct trace_fprobe *tf)
 {
-	unsigned long ip = tracepoint_user_ip(tf->tuser);
+	struct tracepoint_user *tuser __free(tuser_put) = NULL;
+	struct module *mod __free(module_put) = NULL;
+	unsigned long ip;
+	int ret;
 
-	if (!ip)
-		return -ENOENT;
+	if (WARN_ON_ONCE(tf->tuser))
+		return -EINVAL;
+
+	/* If the tracepoint is in a module, it must be locked in this function. */
+	tuser = tracepoint_user_find_get(tf->symbol, &mod);
+	/* This tracepoint is not loaded yet */
+	if (IS_ERR(tuser))
+		return PTR_ERR(tuser);
+	if (!tuser)
+		return -ENOMEM;
+
+	/* Register fprobe only if the tracepoint is loaded. */
+	if (tuser->tpoint) {
+		ip = tracepoint_user_ip(tuser);
+		if (WARN_ON_ONCE(!ip))
+			return -ENOENT;
 
-	return register_fprobe_ips(&tf->fp, &ip, 1);
+		ret = register_fprobe_ips(&tf->fp, &ip, 1);
+		if (ret < 0)
+			return ret;
+	}
+
+	tf->tuser = no_free_ptr(tuser);
+	return 0;
 }
 
 /* Returns an error if the target function is not available, or 0 */
@@ -766,15 +800,9 @@ static int trace_fprobe_verify_target(struct trace_fprobe *tf)
 	unsigned long *addrs __free(kfree) = NULL;
 	int ret;
 
-	if (trace_fprobe_is_tracepoint(tf)) {
-
-		/* This tracepoint is not loaded yet */
-		if (!tracepoint_user_is_registered(tf->tuser))
-			return 0;
-
-		/* We assume all stab function is tracable. */
-		return tracepoint_user_ip(tf->tuser) ? 0 : -ENOENT;
-	}
+	/* Tracepoint should have a stub function. */
+	if (trace_fprobe_is_tracepoint(tf))
+		return 0;
 
 	ret = fprobe_alloc_ip_list_from_filter(tf->symbol, NULL, &addrs);
 	return (ret < 0) ? ret : 0;
@@ -801,14 +829,8 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 
 	tf->fp.flags &= ~FPROBE_FL_DISABLED;
 
-	if (trace_fprobe_is_tracepoint(tf)) {
-
-		/* This tracepoint is not loaded yet */
-		if (!tracepoint_user_is_registered(tf->tuser))
-			return 0;
-
+	if (trace_fprobe_is_tracepoint(tf))
 		return __regsiter_tracepoint_fprobe(tf);
-	}
 
 	/* TODO: handle filter, nofilter or symbol list */
 	return register_fprobe(&tf->fp, tf->symbol, NULL);
@@ -817,11 +839,9 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 /* Internal unregister function - just handle fprobe and flags */
 static void __unregister_trace_fprobe(struct trace_fprobe *tf)
 {
-	if (trace_fprobe_is_registered(tf)) {
+	if (trace_fprobe_is_registered(tf))
 		unregister_fprobe(&tf->fp);
-		memset(&tf->fp, 0, sizeof(tf->fp));
-	}
-	if (trace_fprobe_is_tracepoint(tf)) {
+	if (tf->tuser) {
 		tracepoint_user_put(tf->tuser);
 		tf->tuser = NULL;
 	}
@@ -1012,63 +1032,52 @@ static struct tracepoint *find_tracepoint_in_module(struct module *mod,
 	return data.tpoint;
 }
 
+/* These are CONFIG_MODULES=y specific functions. */
+static bool tracepoint_user_within_module(struct tracepoint_user *tuser,
+					  struct module *mod)
+{
+	return within_module(tracepoint_user_ip(tuser), mod);
+}
+
+static int tracepoint_user_register_again(struct tracepoint_user *tuser,
+					  struct tracepoint *tpoint)
+{
+	tuser->tpoint = tpoint;
+	return tracepoint_user_register(tuser);
+}
+
+static void tracepoint_user_unregister_clear(struct tracepoint_user *tuser)
+{
+	tracepoint_user_unregister(tuser);
+	tuser->tpoint = NULL;
+}
+
+/* module callback for tracepoint_user */
 static int __tracepoint_probe_module_cb(struct notifier_block *self,
 					unsigned long val, void *data)
 {
 	struct tp_module *tp_mod = data;
 	struct tracepoint_user *tuser;
-	struct trace_fprobe *tf;
-	struct dyn_event *pos;
+	struct tracepoint *tpoint;
 
 	if (val != MODULE_STATE_GOING && val != MODULE_STATE_COMING)
 		return NOTIFY_DONE;
 
-	mutex_lock(&event_mutex);
-	for_each_trace_fprobe(tf, pos) {
-		if (!trace_fprobe_is_tracepoint(tf))
-			continue;
-
+	mutex_lock(&tracepoint_user_mutex);
+	for_each_tracepoint_user(tuser) {
 		if (val == MODULE_STATE_COMING) {
-			/*
-			 * If any tracepoint used by tprobe is in the module,
-			 * register the stub.
-			 */
-			struct tracepoint *tpoint;
-
-			tpoint = find_tracepoint_in_module(tp_mod->mod, tf->symbol);
 			/* This is not a tracepoint in this module. Skip it. */
+			tpoint = find_tracepoint_in_module(tp_mod->mod, tuser->name);
 			if (!tpoint)
 				continue;
-
-			tuser = tf->tuser;
-			/* If the tracepoint is no registered yet, register it. */
-			if (!tracepoint_user_is_registered(tuser)) {
-				tuser->tpoint = tpoint;
-				if (WARN_ON_ONCE(tracepoint_user_register(tuser)))
-					continue;
-			}
-
-			/* Finally enable fprobe on this module. */
-			if (trace_probe_is_enabled(&tf->tp) && !trace_fprobe_is_registered(tf))
-				WARN_ON_ONCE(__regsiter_tracepoint_fprobe(tf));
-		} else if (val == MODULE_STATE_GOING) {
-			tuser = tf->tuser;
+			WARN_ON_ONCE(tracepoint_user_register_again(tuser, tpoint));
+		} else if (val == MODULE_STATE_GOING &&
+			  tracepoint_user_within_module(tuser, tp_mod->mod)) {
 			/* Unregister all tracepoint_user in this module. */
-			if (tracepoint_user_is_registered(tuser) &&
-			    tracepoint_user_within_module(tuser, tp_mod->mod))
-				tracepoint_user_unregister(tuser);
-
-			/*
-			 * Here we need to handle shared tracepoint_user case.
-			 * Such tuser is unregistered, but trace_fprobe itself
-			 * is registered. (Note this only handles tprobes.)
-			 */
-			if (!tracepoint_user_is_registered(tuser) &&
-			    trace_fprobe_is_registered(tf))
-				unregister_fprobe(&tf->fp);
+			tracepoint_user_unregister_clear(tuser);
 		}
 	}
-	mutex_unlock(&event_mutex);
+	mutex_unlock(&tracepoint_user_mutex);
 
 	return NOTIFY_DONE;
 }
@@ -1076,6 +1085,54 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 static struct notifier_block tracepoint_module_nb = {
 	.notifier_call = __tracepoint_probe_module_cb,
 };
+
+/* module callback for tprobe events */
+static int __tprobe_event_module_cb(struct notifier_block *self,
+				     unsigned long val, void *data)
+{
+	struct trace_fprobe *tf;
+	struct dyn_event *pos;
+	struct module *mod = data;
+
+	if (val != MODULE_STATE_GOING && val != MODULE_STATE_COMING)
+		return NOTIFY_DONE;
+
+	mutex_lock(&event_mutex);
+	for_each_trace_fprobe(tf, pos) {
+		/* Skip fprobe and disabled tprobe events. */
+		if (!trace_fprobe_is_tracepoint(tf) || !tf->tuser)
+			continue;
+
+		/* Before this notification, tracepoint notifier has already done. */
+		if (val == MODULE_STATE_COMING &&
+		    tracepoint_user_within_module(tf->tuser, mod)) {
+			unsigned long ip = tracepoint_user_ip(tf->tuser);
+
+			WARN_ON_ONCE(register_fprobe_ips(&tf->fp, &ip, 1));
+		} else if (val == MODULE_STATE_GOING &&
+			   /*
+			    * tracepoint_user_within_module() does not work here because
+			    * tracepoint_user is already unregistered and cleared tpoint.
+			    * Instead, checking whether the fprobe is registered but
+			    * tpoint is cleared(unregistered). Such unbalance probes
+			    * must be adjusted anyway.
+			    */
+			    trace_fprobe_is_registered(tf) &&
+			    !tf->tuser->tpoint) {
+			unregister_fprobe(&tf->fp);
+		}
+	}
+	mutex_unlock(&event_mutex);
+
+	return NOTIFY_DONE;
+}
+
+/* NOTE: this must be called after tracepoint callback */
+static struct notifier_block tprobe_event_module_nb = {
+	.notifier_call = __tprobe_event_module_cb,
+	/* Make sure this is later than tracepoint module notifier. */
+	.priority = -10,
+};
 #endif /* CONFIG_MODULES */
 
 static int parse_symbol_and_return(int argc, const char *argv[],
@@ -1134,10 +1191,6 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	return 0;
 }
 
-DEFINE_FREE(tuser_put, struct tracepoint_user *,
-	if (!IS_ERR_OR_NULL(_T))
-		tracepoint_user_put(_T))
-
 static int trace_fprobe_create_internal(int argc, const char *argv[],
 					struct traceprobe_parse_context *ctx)
 {
@@ -1166,7 +1219,6 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
-	struct tracepoint_user *tuser __free(tuser_put) = NULL;
 	struct module *mod __free(module_put) = NULL;
 	int i, new_argc = 0, ret = 0;
 	bool is_return = false;
@@ -1229,21 +1281,21 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	else
 		ctx->flags |= TPARG_FL_FENTRY;
 
+	ctx->funcname = NULL;
 	if (is_tracepoint) {
+		/* Get tracepoint and lock its module until the end of the registration. */
+		struct tracepoint *tpoint = find_tracepoint(symbol, &mod);
+
 		ctx->flags |= TPARG_FL_TPOINT;
-		tuser = trace_fprobe_get_tracepoint_user(symbol, &mod);
-		if (!tuser)
-			return -ENOMEM;
-		if (IS_ERR(tuser)) {
-			trace_probe_log_set_index(1);
-			trace_probe_log_err(0, NO_TRACEPOINT);
-			return PTR_ERR(tuser);
+		if (mod && !try_module_get(mod)) {
+			mod = NULL;
+			tpoint = NULL;
 		}
-		ctx->funcname = tracepoint_user_lookup(tuser, sbuf);
-		/* If tracepoint is not loaded yet, use symbol name as funcname. */
-		if (!ctx->funcname)
-			ctx->funcname = symbol;
-	} else
+		if (tpoint)
+			ctx->funcname = kallsyms_lookup((unsigned long)tpoint->probestub,
+							NULL, NULL, NULL, sbuf);
+	}
+	if (!ctx->funcname)
 		ctx->funcname = symbol;
 
 	argc -= 2; argv += 2;
@@ -1266,14 +1318,13 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		return ret;
 
 	/* setup a probe */
-	tf = alloc_trace_fprobe(group, event, symbol, tuser, argc, is_return);
+	tf = alloc_trace_fprobe(group, event, symbol, argc, is_return, is_tracepoint);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
 		return ret;
 	}
-	tuser = NULL; /* Move tuser to tf. */
 
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
@@ -1491,6 +1542,9 @@ static __init int init_fprobe_trace_early(void)
 	ret = register_tracepoint_module_notifier(&tracepoint_module_nb);
 	if (ret)
 		return ret;
+	ret = register_module_notifier(&tprobe_event_module_nb);
+	if (ret)
+		return ret;
 #endif
 
 	return 0;

