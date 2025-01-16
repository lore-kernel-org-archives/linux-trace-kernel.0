Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A322B5AC;
	Thu, 16 Jan 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038128; cv=none; b=L4CWI9DnZ+FNEHkkCuK8cEMh4RRHWuqyLIBT+Gdqr8FwZMz7AckCk6BME1vUhcr2BOScW/8GnJy5LAFxU+uwH6kOvDZgcvi7SRySh36iVgB5u5vxYyg1GTpunMbz79pO5HyW0CbnMKOkhTSHNadOg8ZipulxvIAv3vpx/W3ZH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038128; c=relaxed/simple;
	bh=wrHix7/1w4cqTn9Mzf8gQptR2oIBDMtEuDr6iOVW1dM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bbiMZpPphEfO9hLZPVzXrZ6MTZylwNgngWqu+14MR17hyZPgZCpd3kg5WTNeK/LuhKePWXlD/pNfRCpbIzshVfxSAH3Y/KKUl5DYkTsemXGrdvVS54IQWGEs2U6wl4+K9AUN/C4/bEA0p5bsQ1wXGf0HIeQVbdcKa7oMFAr2Cks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FA9C4CEE1;
	Thu, 16 Jan 2025 14:35:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYQy5-00000000syk-38TT;
	Thu, 16 Jan 2025 09:35:33 -0500
Message-ID: <20250116143533.514730995@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 16 Jan 2025 09:33:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 jochensp@jochen.sprickerhof.de,
 peter.griffin@linaro.org
Subject: [PATCH 2/3] tracing: Cache ":mod:" events for modules not loaded yet
References: <20250116143334.073917300@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the :mod: command is written into /sys/kernel/tracing/set_event (or
that file within an instance), if the module specified after the ":mod:"
is not yet loaded, it will store that string internally. When the module
is loaded, it will enable the events as if the module was loaded when the
string was written into the set_event file.

This can also be useful to enable events that are in the init section of
the module, as the events are enabled before the init section is executed.

This also works on the kernel command line:

 trace_event=:mod:<module>

Will enable the events for <module> when it is loaded.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         |   8 +
 Documentation/trace/events.rst                |   4 +-
 kernel/trace/ftrace.c                         |  17 --
 kernel/trace/trace.c                          |  26 ++
 kernel/trace/trace.h                          |  12 +
 kernel/trace/trace_events.c                   | 241 +++++++++++++++++-
 6 files changed, 279 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6ec49d..4f563cb0ca0f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6858,6 +6858,14 @@
 			comma-separated list of trace events to enable. See
 			also Documentation/trace/events.rst
 
+			To enable modules, use :mod: keyword:
+
+			trace_event=:mod:<module>
+
+			The value before :mod: will only enable specific events
+			that are part of the module. See the above mentioned
+			document for more information.
+
 	trace_instance=[instance-info]
 			[FTRACE] Create a ring buffer instance early in boot up.
 			This will be listed in:
diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 3db57516eb86..2d88a2acacc0 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -60,7 +60,9 @@ a specific module::
 
 	# echo ':mod:<module>' > /sys/kernel/tracing/set_event
 
-Will enable all events in the module ``<module>``.
+Will enable all events in the module ``<module>``.  If the module is not yet
+loaded, the string will be saved and when a module is that matches ``<module>``
+is loaded, then it will apply the enabling of events then.
 
 The text before ``:mod:`` will be parsed to specify specific events that the
 module creates::
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9b17efb1a87d..cafcfc97ff2a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4930,23 +4930,6 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 	return __ftrace_hash_move_and_update_ops(ops, orig_hash, hash, enable);
 }
 
-static bool module_exists(const char *module)
-{
-	/* All modules have the symbol __this_module */
-	static const char this_mod[] = "__this_module";
-	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
-	unsigned long val;
-	int n;
-
-	n = snprintf(modname, sizeof(modname), "%s:%s", module, this_mod);
-
-	if (n > sizeof(modname) - 1)
-		return false;
-
-	val = module_kallsyms_lookup_name(modname);
-	return val != 0;
-}
-
 static int cache_mod(struct trace_array *tr,
 		     const char *func, char *module, int enable)
 {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index cb85ee4a8807..87402b6e8c58 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9407,6 +9407,10 @@ trace_array_create_systems(const char *name, const char *systems,
 	INIT_LIST_HEAD(&tr->hist_vars);
 	INIT_LIST_HEAD(&tr->err_log);
 
+#ifdef CONFIG_MODULES
+	INIT_LIST_HEAD(&tr->mod_events);
+#endif
+
 	if (allocate_trace_buffers(tr, trace_buf_size) < 0)
 		goto out_free_tr;
 
@@ -9823,6 +9827,24 @@ late_initcall_sync(trace_eval_sync);
 
 
 #ifdef CONFIG_MODULES
+
+bool module_exists(const char *module)
+{
+	/* All modules have the symbol __this_module */
+	static const char this_mod[] = "__this_module";
+	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
+	unsigned long val;
+	int n;
+
+	n = snprintf(modname, sizeof(modname), "%s:%s", module, this_mod);
+
+	if (n > sizeof(modname) - 1)
+		return false;
+
+	val = module_kallsyms_lookup_name(modname);
+	return val != 0;
+}
+
 static void trace_module_add_evals(struct module *mod)
 {
 	if (!mod->num_trace_evals)
@@ -10535,6 +10557,10 @@ __init static int tracer_alloc_buffers(void)
 #endif
 	ftrace_init_global_array_ops(&global_trace);
 
+#ifdef CONFIG_MODULES
+	INIT_LIST_HEAD(&global_trace.mod_events);
+#endif
+
 	init_trace_flags_index(&global_trace);
 
 	register_tracer(&nop_trace);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9691b47b5f3d..05ea0ebf5eba 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -400,6 +400,9 @@ struct trace_array {
 	cpumask_var_t		pipe_cpumask;
 	int			ref;
 	int			trace_ref;
+#ifdef CONFIG_MODULES
+	struct list_head	mod_events;
+#endif
 #ifdef CONFIG_FUNCTION_TRACER
 	struct ftrace_ops	*ops;
 	struct trace_pid_list	__rcu *function_pids;
@@ -434,6 +437,15 @@ enum {
 	TRACE_ARRAY_FL_BOOT	= BIT(1),
 };
 
+#ifdef CONFIG_MODULES
+bool module_exists(const char *module);
+#else
+static inline bool module_exists(const char *module)
+{
+	return false;
+}
+#endif
+
 extern struct list_head ftrace_trace_arrays;
 
 extern struct mutex trace_types_lock;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 5c7d0e07618d..f762e554fad4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -857,6 +857,120 @@ static int ftrace_event_enable_disable(struct trace_event_file *file,
 	return __ftrace_event_enable_disable(file, enable, 0);
 }
 
+#if CONFIG_MODULES
+struct event_mod_load {
+	struct list_head	list;
+	char			*module;
+	char			*match;
+	char			*system;
+	char			*event;
+};
+
+static void free_event_mod(struct event_mod_load *event_mod)
+{
+	list_del(&event_mod->list);
+	kfree(event_mod->module);
+	kfree(event_mod->match);
+	kfree(event_mod->system);
+	kfree(event_mod->event);
+	kfree(event_mod);
+}
+
+static void clear_mod_events(struct trace_array *tr)
+{
+	struct event_mod_load *event_mod, *n;
+
+	list_for_each_entry_safe(event_mod, n, &tr->mod_events, list) {
+		free_event_mod(event_mod);
+	}
+}
+
+static int remove_cache_mod(struct trace_array *tr, const char *mod,
+			    const char *match, const char *system, const char *event)
+{
+	struct event_mod_load *event_mod, *n;
+	int ret = -EINVAL;
+
+	list_for_each_entry_safe(event_mod, n, &tr->mod_events, list) {
+		if (strcmp(event_mod->module, mod) != 0)
+			continue;
+
+		if (match && strcmp(event_mod->match, match) != 0)
+			continue;
+
+		if (system &&
+		    (!event_mod->system || strcmp(event_mod->system, system) != 0))
+			continue;
+
+		if (event &&
+		    (!event_mod->event || strcmp(event_mod->event, event) != 0))
+			continue;
+
+		free_event_mod(event_mod);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int cache_mod(struct trace_array *tr, const char *mod, int set,
+		     const char *match, const char *system, const char *event)
+{
+	struct event_mod_load *event_mod;
+
+	/* If the module exists, then this just failed to find an event */
+	if (module_exists(mod))
+		return -EINVAL;
+
+	/* See if this is to remove a cached filter */
+	if (!set)
+		return remove_cache_mod(tr, mod, match, system, event);
+
+	event_mod = kzalloc(sizeof(*event_mod), GFP_KERNEL);
+	if (!event_mod)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&event_mod->list);
+	event_mod->module = kstrdup(mod, GFP_KERNEL);
+	if (!event_mod->module)
+		goto out_free;
+
+	if (match) {
+		event_mod->match = kstrdup(match, GFP_KERNEL);
+		if (!event_mod->match)
+			goto out_free;
+	}
+
+	if (system) {
+		event_mod->system = kstrdup(system, GFP_KERNEL);
+		if (!event_mod->system)
+			goto out_free;
+	}
+
+	if (event) {
+		event_mod->event = kstrdup(event, GFP_KERNEL);
+		if (!event_mod->event)
+			goto out_free;
+	}
+
+	list_add(&event_mod->list, &tr->mod_events);
+
+	return 0;
+
+ out_free:
+	free_event_mod(event_mod);
+
+	return -ENOMEM;
+}
+#else /* CONFIG_MODULES */
+static inline void clear_mod_events(struct trace_array *tr) { }
+static int cache_mod(struct trace_array *tr, const char *mod, int set,
+		     const char *match, const char *system, const char *event)
+{
+	return -EINVAL;
+}
+#endif
+
 static void ftrace_clear_events(struct trace_array *tr)
 {
 	struct trace_event_file *file;
@@ -865,6 +979,7 @@ static void ftrace_clear_events(struct trace_array *tr)
 	list_for_each_entry(file, &tr->events, list) {
 		ftrace_event_enable_disable(file, 0);
 	}
+	clear_mod_events(tr);
 	mutex_unlock(&event_mutex);
 }
 
@@ -1215,6 +1330,13 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 		ret = eret;
 	}
 
+	/*
+	 * If this is a module setting and nothing was found,
+	 * check if the module was loaded. If it wasn't cache it.
+	 */
+	if (module && ret == -EINVAL && !eret)
+		ret = cache_mod(tr, module, set, match, sub, event);
+
 	return ret;
 }
 
@@ -1416,37 +1538,71 @@ static void *t_start(struct seq_file *m, loff_t *pos)
 	return file;
 }
 
+enum set_event_iter_type {
+	SET_EVENT_FILE,
+	SET_EVENT_MOD,
+};
+
+struct set_event_iter {
+	enum set_event_iter_type	type;
+	union {
+		struct trace_event_file	*file;
+		struct event_mod_load	*event_mod;
+	};
+};
+
 static void *
 s_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct trace_event_file *file = v;
+	struct set_event_iter *iter = v;
+	struct trace_event_file *file;
 	struct trace_array *tr = m->private;
 
 	(*pos)++;
 
-	list_for_each_entry_continue(file, &tr->events, list) {
-		if (file->flags & EVENT_FILE_FL_ENABLED)
-			return file;
+	if (iter->type == SET_EVENT_FILE) {
+		file = iter->file;
+		list_for_each_entry_continue(file, &tr->events, list) {
+			if (file->flags & EVENT_FILE_FL_ENABLED) {
+				iter->file = file;
+				return iter;
+			}
+		}
+#ifdef CONFIG_MODULES
+		iter->type = SET_EVENT_MOD;
+		iter->event_mod = list_entry(&tr->mod_events, struct event_mod_load, list);
+#endif
 	}
 
+#ifdef CONFIG_MODULES
+	list_for_each_entry_continue(iter->event_mod, &tr->mod_events, list)
+		return iter;
+#endif
+
 	return NULL;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	struct trace_event_file *file;
 	struct trace_array *tr = m->private;
+	struct set_event_iter *iter;
 	loff_t l;
 
+	iter = kzalloc(sizeof(iter), GFP_KERNEL);
+	if (!iter)
+		return NULL;
+
 	mutex_lock(&event_mutex);
 
-	file = list_entry(&tr->events, struct trace_event_file, list);
+	iter->type = SET_EVENT_FILE;
+	iter->file = list_entry(&tr->events, struct trace_event_file, list);
+
 	for (l = 0; l <= *pos; ) {
-		file = s_next(m, file, &l);
-		if (!file)
+		iter = s_next(m, iter, &l);
+		if (!iter)
 			break;
 	}
-	return file;
+	return iter;
 }
 
 static int t_show(struct seq_file *m, void *v)
@@ -1466,6 +1622,45 @@ static void t_stop(struct seq_file *m, void *p)
 	mutex_unlock(&event_mutex);
 }
 
+#ifdef CONFIG_MODULES
+static int s_show(struct seq_file *m, void *v)
+{
+	struct set_event_iter *iter = v;
+	const char *system;
+	const char *event;
+
+	if (iter->type == SET_EVENT_FILE)
+		return t_show(m, iter->file);
+
+	/* When match is set, system and event are not */
+	if (iter->event_mod->match) {
+		seq_printf(m, "%s:mod:%s", iter->event_mod->match,
+			   iter->event_mod->module);
+		return 0;
+	}
+
+	system = iter->event_mod->system ? : "*";
+	event = iter->event_mod->event ? : "*";
+
+	seq_printf(m, "%s:%s:mod:%s\n", system, event, iter->event_mod->module);
+
+	return 0;
+}
+#else /* CONFIG_MODULES */
+static int s_show(struct seq_file *m, void *v)
+{
+	struct set_event_iter *iter = v;
+
+	return t_show(m, iter->file);
+}
+#endif
+
+static void s_stop(struct seq_file *m, void *p)
+{
+	kfree(p);
+	t_stop(m, NULL);
+}
+
 static void *
 __next(struct seq_file *m, void *v, loff_t *pos, int type)
 {
@@ -2253,8 +2448,8 @@ static const struct seq_operations show_event_seq_ops = {
 static const struct seq_operations show_set_event_seq_ops = {
 	.start = s_start,
 	.next = s_next,
-	.show = t_show,
-	.stop = t_stop,
+	.show = s_show,
+	.stop = s_stop,
 };
 
 static const struct seq_operations show_set_pid_seq_ops = {
@@ -3385,6 +3580,28 @@ EXPORT_SYMBOL_GPL(trace_remove_event_call);
 	     event++)
 
 #ifdef CONFIG_MODULES
+static void update_cache(struct trace_array *tr, struct module *mod)
+{
+	struct event_mod_load *event_mod, *n;
+
+	list_for_each_entry_safe(event_mod, n, &tr->mod_events, list) {
+		if (strcmp(event_mod->module, mod->name) != 0)
+			continue;
+
+		__ftrace_set_clr_event_nolock(tr, event_mod->match,
+					      event_mod->system,
+					      event_mod->event, 1, mod->name);
+		free_event_mod(event_mod);
+	}
+}
+
+static void update_cache_events(struct module *mod)
+{
+	struct trace_array *tr;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list)
+		update_cache(tr, mod);
+}
 
 static void trace_module_add_events(struct module *mod)
 {
@@ -3407,6 +3624,8 @@ static void trace_module_add_events(struct module *mod)
 		__register_event(*call, mod);
 		__add_event_to_tracers(*call);
 	}
+
+	update_cache_events(mod);
 }
 
 static void trace_module_remove_events(struct module *mod)
-- 
2.45.2


