Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C864484257;
	Thu, 13 Aug 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630054; cv=none; b=E8h6E+hWoTpxn2qSyMDUGXMw9rgFYTv1V1GNgp7Fy9cu3kZnERVup9KT+/gTy+L2VhnZexGu9xY5A763wOPINzAFhs6M9LI14f0hdInyHR2YzVFvJ4UHzI63x0hmrBrXTSxBePCEWedhRnmGS2nJ8dtQounXk2oI/FGDcyZOGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630054; c=relaxed/simple;
	bh=YWFW1zcn9gtEa9Lz/HYzGgMoaHvPxdat3XRJHNgLzZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vk9d01sP3z6dMmvEXOeP7M/9jm+e+dfQa1CPRLHcfnuMnuvo8o29XyV6Mcfph3KrFCPjXs3+6S4YZA13wW2pAb9UnHkVFEpMGXg9l3f7AjcQi2jsyJF4wNPDe2Z3fIM/3lnyF37/A0H1ttEW4LFdZOd/LYbRCaAelpz0n0ymeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByRyLMrz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PHSMyvLj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByRyLMrz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PHSMyvLj"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786630050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKbiUJ/lxCgVioUyVAAFZc/QFm1LoDhCJCkL6YyTbWY=;
	b=ByRyLMrzB5bRHhSU/aHtVObFi0xnByBp3Gvg3QEtr29oKV7VSf1DwvYyIJXJATzAXqN8EY
	graXGlKUtUCcULfE9s+c4wqIM0lgmENVqyZqRVXEcelXr/sBFBrutJyiSVqcaqXZ0nHkHP
	oJE2DXOgjpLi2C+nRNJ6b1I03xo6Ms3lt+zB9VSMx8lTaIrwFy0zhP9FTLAAn7HGUGydMz
	18RRlhNzQpGkUlgY5/Gn01EZf6zZgcsyuzEkBkzYDxwONImm6+9hSxe83wzIWisNvqQDmN
	27szZczdFi3qFoH2hbiOqz+CfQ7U+TwlBS2zTceh4MYK/5JMjefjSiXLMnrjrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786630050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKbiUJ/lxCgVioUyVAAFZc/QFm1LoDhCJCkL6YyTbWY=;
	b=PHSMyvLjqisPnVkzC7vCp+61t/VuRuIT5iExn3wr3EnM+DP/uJncnyS3ep6jg/71J24JJq
	joA5JkSsfe9Lo9BA==
Date: Thu, 13 Aug 2026 16:07:19 +0200
Subject: [PATCH RFC 6/7] tracing: Add a filter argument to
 __ftrace_set_clr_event()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-tracing-cli-event-filter-v1-6-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
In-Reply-To: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786630039; l=7315;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YWFW1zcn9gtEa9Lz/HYzGgMoaHvPxdat3XRJHNgLzZI=;
 b=u9b4SIM0bhn9zRwXDzWU2xTvX6gwjR6dfkL46w5pPjKBpD8fl9Hj5vyxp06pr5Q6Zj5M/z6A9
 SCLBeIog9iDDJXxTk1heap8cokRJINO/3jOGCE2sjvbgU3waSkNf3fl
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make it possible to directly enable a filter when enabling an event.

For now this is unused, an upcoming patch will wire it up.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/trace_events.c | 47 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 098a5aee5ec7..c24929d003dd 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -916,6 +916,7 @@ struct event_mod_load {
 	char			*match;
 	char			*system;
 	char			*event;
+	char			*filter;
 };
 
 static void free_event_mod(struct event_mod_load *event_mod)
@@ -925,6 +926,7 @@ static void free_event_mod(struct event_mod_load *event_mod)
 	kfree(event_mod->match);
 	kfree(event_mod->system);
 	kfree(event_mod->event);
+	kfree(event_mod->filter);
 	kfree(event_mod);
 }
 
@@ -966,7 +968,7 @@ static int remove_cache_mod(struct trace_array *tr, const char *mod,
 }
 
 static int cache_mod(struct trace_array *tr, const char *mod, int set,
-		     const char *match, const char *system, const char *event)
+		     const char *match, const char *system, const char *event, const char *filter)
 {
 	struct event_mod_load *event_mod;
 
@@ -1005,6 +1007,12 @@ static int cache_mod(struct trace_array *tr, const char *mod, int set,
 			goto out_free;
 	}
 
+	if (filter) {
+		event_mod->filter = kstrdup(filter, GFP_KERNEL);
+		if (!event_mod->filter)
+			goto out_free;
+	}
+
 	list_add(&event_mod->list, &tr->mod_events);
 
 	return 0;
@@ -1017,7 +1025,7 @@ static int cache_mod(struct trace_array *tr, const char *mod, int set,
 #else /* CONFIG_MODULES */
 static inline void clear_mod_events(struct trace_array *tr) { }
 static int cache_mod(struct trace_array *tr, const char *mod, int set,
-		     const char *match, const char *system, const char *event)
+		     const char *match, const char *system, const char *event, const char *filter)
 {
 	return -EINVAL;
 }
@@ -1326,7 +1334,7 @@ static void remove_event_file_dir(struct trace_event_file *file)
 static int
 __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 			      const char *sub, const char *event, int set,
-			      const char *mod)
+			      const char *mod, char *filter)
 {
 	struct trace_event_file *file;
 	struct trace_event_call *call;
@@ -1374,7 +1382,11 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 		if (event && strcmp(event, name) != 0)
 			continue;
 
-		ret = ftrace_event_enable_disable(file, set);
+		if (filter)
+			ret = apply_event_filter(file, filter);
+
+		if (!filter || !ret)
+			ret = ftrace_event_enable_disable(file, set);
 
 		/*
 		 * Save the first error and return that. Some events
@@ -1392,14 +1404,14 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 	 * check if the module was loaded. If it wasn't cache it.
 	 */
 	if (module && ret == -EINVAL && !eret)
-		ret = cache_mod(tr, module, set, match, sub, event);
+		ret = cache_mod(tr, module, set, match, sub, event, filter);
 
 	return ret;
 }
 
 static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 				  const char *sub, const char *event, int set,
-				  const char *mod)
+				  const char *mod, char *filter)
 {
 	int ret;
 
@@ -1407,7 +1419,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 		return -EACCES;
 
 	mutex_lock(&event_mutex);
-	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set, mod);
+	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set, mod, filter);
 	mutex_unlock(&event_mutex);
 
 	return ret;
@@ -1470,7 +1482,7 @@ int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
 
 	ftrace_parse_event_string(buf, &match, &sub, &event, &mod);
 
-	return __ftrace_set_clr_event(tr, match, sub, event, set, mod);
+	return __ftrace_set_clr_event(tr, match, sub, event, set, mod, NULL);
 }
 
 /**
@@ -1492,7 +1504,7 @@ int trace_set_clr_event(const char *system, const char *event, int set)
 	if (!tr)
 		return -ENODEV;
 
-	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL);
+	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_set_clr_event);
 
@@ -1518,7 +1530,7 @@ int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		return -ENOENT;
 
 	set = (enable == true) ? 1 : 0;
-	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL);
+	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
 
@@ -2038,7 +2050,7 @@ system_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (system)
 		name = system->name;
 
-	ret = __ftrace_set_clr_event(dir->tr, NULL, name, NULL, val, NULL);
+	ret = __ftrace_set_clr_event(dir->tr, NULL, name, NULL, val, NULL, NULL);
 	if (ret)
 		goto out;
 
@@ -3909,7 +3921,8 @@ static void update_mod_cache(struct trace_array *tr, struct module *mod)
 
 		__ftrace_set_clr_event_nolock(tr, event_mod->match,
 					      event_mod->system,
-					      event_mod->event, 1, mod->name);
+					      event_mod->event, 1, mod->name,
+					      event_mod->filter);
 		free_event_mod(event_mod);
 	}
 }
@@ -4676,7 +4689,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 	__ftrace_clear_event_pids(tr, TRACE_PIDS | TRACE_NO_PIDS);
 
 	/* Disable any running events */
-	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0, NULL);
+	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0, NULL, NULL);
 
 	/* Make sure no more events are being executed */
 	tracepoint_synchronize_unregister();
@@ -4982,7 +4995,7 @@ static __init void event_trace_self_tests(void)
 
 		pr_info("Testing event system %s: ", system->name);
 
-		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 1, NULL);
+		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 1, NULL, NULL);
 		if (WARN_ON_ONCE(ret)) {
 			pr_warn("error enabling system %s\n",
 				system->name);
@@ -4991,7 +5004,7 @@ static __init void event_trace_self_tests(void)
 
 		event_test_stuff();
 
-		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 0, NULL);
+		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 0, NULL, NULL);
 		if (WARN_ON_ONCE(ret)) {
 			pr_warn("error disabling system %s\n",
 				system->name);
@@ -5006,7 +5019,7 @@ static __init void event_trace_self_tests(void)
 	pr_info("Running tests on all trace events:\n");
 	pr_info("Testing all events: ");
 
-	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 1, NULL);
+	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 1, NULL, NULL);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error enabling all events\n");
 		return;
@@ -5015,7 +5028,7 @@ static __init void event_trace_self_tests(void)
 	event_test_stuff();
 
 	/* reset sysname */
-	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 0, NULL);
+	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 0, NULL, NULL);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error disabling all events\n");
 		return;

-- 
2.55.0

