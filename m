Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EF3812DE;
	Tue,  8 Sep 2026 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848544; cv=none; b=pBJFqEOqL5J9pBk8mDlTLX/5iQgmX4Iz5LfoAiRo3rj7mIsOf6WYG/wInTsUqstGzq4Lh+JPSPtEZQWXjbwqnTm0rWZ1wCWjP3L3w4cjU1vCD7l6VtfPnMhCUi36B3Tz3OFsSPNewJm9YP+D3BVwNkKQlPTrvuBl4RHnaAA9vU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848544; c=relaxed/simple;
	bh=WBf+zqJbBvN5xIbqWxhQ23l3IDDtZTVTqQvNQhY7iZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzzlwZUSNI7WHBa8ZUumLPnKWZHGDReacFK+LbYM1QV1zAqxrxNDDGt7p12AhkGqiovTGvSBkXq5FMT7x6P7/n6khqNQ14lROZ4itprmeS8/zUqTTNocAyZ0tU+C3AXqhqmUbZWpw0N2Hvlyex3wtBq/cGS7wUaKJUGe9XnJc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qowH2sEU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/hPtNVQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qowH2sEU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/hPtNVQ"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OpkTnovo4vbK9Ryr8abdG64TmDgSw2P4cKEhNt7uqj4=;
	b=qowH2sEUHDhHacv0cANwY6hAlOzn8Yeb6uEuD7+rCRh7Rf8EDoFRDSdnWJfaKWzLqzQsf3
	mdRFtXpyBpLBVkauKDDgMdvCD7dX/oZT9sxb4QPj84wU6BGC8JNj/y6b5q1GVEIzGryMRU
	K9M0G2n65ztysmBY7YYO2aUKpJ/SqlOJpRKSDC+BnTWL69ElZnf+1DwcGr/GfPqEVCxuzM
	hwjT+in7cYouB/LbhClx6h+4QeWh1xAHarWpx0XWyGSXnV6Kh7mAxxB9UXwWAzjCcQR3aZ
	e/jS+4qWpX/CYrsotiIsla1z0TRQn+r3Bq6leu3tdgmQXuC/YeNkizL/YmUzIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OpkTnovo4vbK9Ryr8abdG64TmDgSw2P4cKEhNt7uqj4=;
	b=I/hPtNVQ1lBMdgH7XzoEZ2C2Nhp1R78xLeg9hzuZNMoMVwihvTmaOibDpy1sKeCXTY9sJ6
	Te0o7UzwWFgcrLBw==
Date: Tue, 08 Sep 2026 08:22:20 +0200
Subject: [PATCH v2 6/7] tracing: Add a filter argument to
 __ftrace_set_clr_event()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-tracing-cli-event-filter-v2-6-05396a3fb663@linutronix.de>
References: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
In-Reply-To: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848535; l=7325;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WBf+zqJbBvN5xIbqWxhQ23l3IDDtZTVTqQvNQhY7iZs=;
 b=0UCIuq0xExQO0QrcwJ+GtXvc1nwzWMr7UdNTcq1peF2v8FCkzSFKXN6WTDrG2/fDU8wFR6Cjh
 tb4usoSk1sLB5jWAKxXwsIZ1TfMdVzWJXLKU1ELAFvohVTXWs87T8Ya
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make it possible to directly enable a filter when enabling an event.

For now this is unused, an upcoming patch will wire it up.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/trace_events.c | 47 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7a491dbe6e81..f8881a9d3c7a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -943,6 +943,7 @@ struct event_mod_load {
 	char			*match;
 	char			*system;
 	char			*event;
+	char			*filter;
 };
 
 static void free_event_mod(struct event_mod_load *event_mod)
@@ -952,6 +953,7 @@ static void free_event_mod(struct event_mod_load *event_mod)
 	kfree(event_mod->match);
 	kfree(event_mod->system);
 	kfree(event_mod->event);
+	kfree(event_mod->filter);
 	kfree(event_mod);
 }
 
@@ -993,7 +995,7 @@ static int remove_cache_mod(struct trace_array *tr, const char *mod,
 }
 
 static int cache_mod(struct trace_array *tr, const char *mod, int set,
-		     const char *match, const char *system, const char *event)
+		     const char *match, const char *system, const char *event, const char *filter)
 {
 	struct event_mod_load *event_mod;
 
@@ -1032,6 +1034,12 @@ static int cache_mod(struct trace_array *tr, const char *mod, int set,
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
@@ -1044,7 +1052,7 @@ static int cache_mod(struct trace_array *tr, const char *mod, int set,
 #else /* CONFIG_MODULES */
 static inline void clear_mod_events(struct trace_array *tr) { }
 static int cache_mod(struct trace_array *tr, const char *mod, int set,
-		     const char *match, const char *system, const char *event)
+		     const char *match, const char *system, const char *event, const char *filter)
 {
 	return -EINVAL;
 }
@@ -1353,7 +1361,7 @@ static void remove_event_file_dir(struct trace_event_file *file)
 static int
 __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 			      const char *sub, const char *event, int set,
-			      const char *mod)
+			      const char *mod, char *filter)
 {
 	struct trace_event_file *file;
 	struct trace_event_call *call;
@@ -1403,7 +1411,11 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
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
@@ -1421,14 +1433,14 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
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
 
@@ -1436,7 +1448,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 		return -EACCES;
 
 	mutex_lock(&event_mutex);
-	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set, mod);
+	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set, mod, filter);
 	mutex_unlock(&event_mutex);
 
 	return ret;
@@ -1499,7 +1511,7 @@ int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set)
 
 	ftrace_parse_event_string(dupped_buf, &match, &sub, &event, &mod);
 
-	return __ftrace_set_clr_event(tr, match, sub, event, set, mod);
+	return __ftrace_set_clr_event(tr, match, sub, event, set, mod, NULL);
 }
 
 /**
@@ -1521,7 +1533,7 @@ int trace_set_clr_event(const char *system, const char *event, int set)
 	if (!tr)
 		return -ENODEV;
 
-	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL);
+	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_set_clr_event);
 
@@ -1547,7 +1559,7 @@ int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		return -ENOENT;
 
 	set = (enable == true) ? 1 : 0;
-	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL);
+	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
 
@@ -2067,7 +2079,7 @@ system_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (system)
 		name = system->name;
 
-	ret = __ftrace_set_clr_event(dir->tr, NULL, name, NULL, val, NULL);
+	ret = __ftrace_set_clr_event(dir->tr, NULL, name, NULL, val, NULL, NULL);
 	if (ret)
 		goto out;
 
@@ -4022,7 +4034,8 @@ static void update_mod_cache(struct trace_array *tr, struct module *mod)
 
 		__ftrace_set_clr_event_nolock(tr, event_mod->match,
 					      event_mod->system,
-					      event_mod->event, 1, mod->name);
+					      event_mod->event, 1, mod->name,
+					      event_mod->filter);
 		free_event_mod(event_mod);
 	}
 }
@@ -4796,7 +4809,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 	__ftrace_clear_event_pids(tr, TRACE_PIDS | TRACE_NO_PIDS);
 
 	/* Disable any running events */
-	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0, NULL);
+	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0, NULL, NULL);
 
 	/* Make sure no more events are being executed */
 	tracepoint_synchronize_unregister();
@@ -5106,7 +5119,7 @@ static __init void event_trace_self_tests(void)
 
 		pr_info("Testing event system %s: ", system->name);
 
-		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 1, NULL);
+		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 1, NULL, NULL);
 		if (WARN_ON_ONCE(ret)) {
 			pr_warn("error enabling system %s\n",
 				system->name);
@@ -5115,7 +5128,7 @@ static __init void event_trace_self_tests(void)
 
 		event_test_stuff();
 
-		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 0, NULL);
+		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 0, NULL, NULL);
 		if (WARN_ON_ONCE(ret)) {
 			pr_warn("error disabling system %s\n",
 				system->name);
@@ -5130,7 +5143,7 @@ static __init void event_trace_self_tests(void)
 	pr_info("Running tests on all trace events:\n");
 	pr_info("Testing all events: ");
 
-	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 1, NULL);
+	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 1, NULL, NULL);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error enabling all events\n");
 		return;
@@ -5139,7 +5152,7 @@ static __init void event_trace_self_tests(void)
 	event_test_stuff();
 
 	/* reset sysname */
-	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 0, NULL);
+	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 0, NULL, NULL);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error disabling all events\n");
 		return;

-- 
2.55.0

