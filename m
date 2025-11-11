Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2712E9EB9;
	Tue, 11 Nov 2025 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903458; cv=none; b=U4ZyoJqTsJ9zS0zHqUl+kYQ0IcEmYsFb3bby43MkseIr4SMEHra4VcQuGmAmqvb46jwzZOEf4KFrRpKT4mt+a4U14GsheBAwOR3UWWB2zh5FwvnMdH5ipHyGKUXwdRbmNdK/ctivefOmQY3WGauHp4L3fROfPcw8UnIT3X5lmBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903458; c=relaxed/simple;
	bh=4sXzPLdZ5KAtiaOblquQvaOmj0BJ88Q3ycOf/MDgf3s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NASOBy51gces2dNEi91pMt8i+6FOKYYvyexpXll0YHOX1fPkn73I29mkUQgFnhsRMcbFBiNqXUWoOIJcxyp3LCp2ZY77Wr7dXK+LKfEj3wLDfo6Q8pKWfjihTN2h8VZ27Zxqz0Rafq0ALzG/8RUdNR5pAHoXFuOJm0PzuCCUfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W09RoQ3V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W09RoQ3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E400C4CEFB;
	Tue, 11 Nov 2025 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762903457;
	bh=4sXzPLdZ5KAtiaOblquQvaOmj0BJ88Q3ycOf/MDgf3s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=W09RoQ3VJ8nf7AVkZVs7mMZs+/LXGefkoWl0b9wilkefKuv630F498Q4JUpH9NUan
	 wVMqTnt54wIQ44xEglIK3eFSa+dkzb/e+8owhTqBX5TzXq3ggXMFuga7RrwKxMCArv
	 so5uqLPmuoX6pcbbkORn0eyGRFn5HbLllsXVI8KZmOVuedw4u+eJOvK8zkG+2aVaKp
	 8tLSPUNJYHkW+XcOhecTCd9CnMfGXTk83VuonjEkBrTUvVBfMKf3iD60C9MeGHU9J1
	 lKzePFF0JldXzE9FYUFehUDUS0rlVLoEozWkJXNPARUBs9aTXiC+SZQzFCBJdyJ0M6
	 V5QRxk7J/grDQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vIxiv-00000000uRt-1tCt;
	Tue, 11 Nov 2025 18:24:29 -0500
Message-ID: <20251111232429.305317942@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 11 Nov 2025 18:24:07 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 1/3] tracing: Have tracer option be instance specific
References: <20251111232406.183056289@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Tracers can add specify options to modify them. This logic was added
before instances were created and the tracer flags were global variables.
After instances were created where a tracer may exist in more than one
instance, the flags were not updated from being global into instance
specific. This causes confusion with these options. For example, the
function tracer has an option to enable function arguments:

  # cd /sys/kernel/tracing
  # mkdir instances/foo
  # echo function > instances/foo/current_tracer
  # echo 1 > options/func-args
  # echo function > current_tracer
  # cat trace
[..]
  <idle>-0       [005] d..3.  1050.656187: rcu_needs_cpu() <-tick_nohz_next_event
  <idle>-0       [005] d..3.  1050.656188: get_next_timer_interrupt(basej=0x10002dbad, basem=0xf45fd7d300) <-tick_nohz_next_event
  <idle>-0       [005] d..3.  1050.656189: _raw_spin_lock(lock=0xffff8944bdf5de80) <-__get_next_timer_interrupt
  <idle>-0       [005] d..4.  1050.656190: do_raw_spin_lock(lock=0xffff8944bdf5de80) <-__get_next_timer_interrupt
  <idle>-0       [005] d..4.  1050.656191: _raw_spin_lock_nested(lock=0xffff8944bdf5f140, subclass=1) <-__get_next_timer_interrupt
 # cat instances/foo/options/func-args
 1
 # cat instances/foo/trace
[..]
  kworker/4:1-88      [004] ...1.   298.127735: next_zone <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127736: first_online_pgdat <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127738: next_online_pgdat <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127739: fold_diff <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127741: round_jiffies_relative <-vmstat_update
[..]

The above shows that setting "func-args" in the top level instance also
set it in the instance "foo", but since the interface of the trace flags
are per instance, the update didn't take affect in the "foo" instance.

Update the infrastructure to allow tracers to add a "default_flags" field
in the tracer structure that can be set instead of "flags" which will make
the flags per instance. If a tracer needs to keep the flags global (like
blktrace), keeping the "flags" field set will keep the old behavior.

This does not update function or the function graph tracers. That will be
handled later.

Fixes: f20a580627f43 ("ftrace: Allow instances to use function tracing")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v3: https://patch.msgid.link/20251110234341.767135255@kernel.org

- Fix registering of command line tracers.
  A command line tracer is registered before the global array attaches
  itself to the list of instances. This keeps the tracer from attaching to
  the global array and that keeps the tracer from adding itself to the
  global array, and this means it fails to start at boot.

- Also add a warning if the starting of a boot tracer fails to start.

 kernel/trace/trace.c | 257 ++++++++++++++++++++++++++++++-------------
 kernel/trace/trace.h |   3 +
 2 files changed, 186 insertions(+), 74 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0aea9cb84276..9268489d2ce8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -94,6 +94,13 @@ static bool tracepoint_printk_stop_on_boot __initdata;
 static bool traceoff_after_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
+/* Store tracers and their flags per instance */
+struct tracers {
+	struct list_head	list;
+	struct tracer		*tracer;
+	struct tracer_flags	*flags;
+};
+
 /*
  * To prevent the comm cache from being overwritten when no
  * tracing is active, only save the comm when a trace event
@@ -2164,6 +2171,7 @@ static int save_selftest(struct tracer *type)
 static int run_tracer_selftest(struct tracer *type)
 {
 	struct trace_array *tr = &global_trace;
+	struct tracer_flags *saved_flags = tr->current_trace_flags;
 	struct tracer *saved_tracer = tr->current_trace;
 	int ret;
 
@@ -2194,6 +2202,7 @@ static int run_tracer_selftest(struct tracer *type)
 	tracing_reset_online_cpus(&tr->array_buffer);
 
 	tr->current_trace = type;
+	tr->current_trace_flags = type->flags ? : type->default_flags;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	if (type->use_max_tr) {
@@ -2210,6 +2219,7 @@ static int run_tracer_selftest(struct tracer *type)
 	ret = type->selftest(type, tr);
 	/* the test is responsible for resetting too */
 	tr->current_trace = saved_tracer;
+	tr->current_trace_flags = saved_flags;
 	if (ret) {
 		printk(KERN_CONT "FAILED!\n");
 		/* Add the warning after printing 'FAILED' */
@@ -2302,10 +2312,23 @@ static inline int do_run_tracer_selftest(struct tracer *type)
 }
 #endif /* CONFIG_FTRACE_STARTUP_TEST */
 
-static int add_tracer_options(struct trace_array *tr, struct tracer *t);
+static int add_tracer(struct trace_array *tr, struct tracer *t);
 
 static void __init apply_trace_boot_options(void);
 
+static void free_tracers(struct trace_array *tr)
+{
+	struct tracers *t, *n;
+
+	lockdep_assert_held(&trace_types_lock);
+
+	list_for_each_entry_safe(t, n, &tr->tracers, list) {
+		list_del(&t->list);
+		kfree(t->flags);
+		kfree(t);
+	}
+}
+
 /**
  * register_tracer - register a tracer with the ftrace system.
  * @type: the plugin for the tracer
@@ -2314,6 +2337,7 @@ static void __init apply_trace_boot_options(void);
  */
 int __init register_tracer(struct tracer *type)
 {
+	struct trace_array *tr;
 	struct tracer *t;
 	int ret = 0;
 
@@ -2353,10 +2377,13 @@ int __init register_tracer(struct tracer *type)
 	if (ret < 0)
 		goto out;
 
-	ret = add_tracer_options(&global_trace, type);
-	if (ret < 0) {
-		pr_warn("Failed to create tracer options for %s\n", type->name);
-		goto out;
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		ret = add_tracer(tr, type);
+		if (ret < 0) {
+			/* The tracer will still exist but without options */
+			pr_warn("Failed to create tracer options for %s\n", type->name);
+			break;
+		}
 	}
 
 	type->next = trace_types;
@@ -2373,7 +2400,7 @@ int __init register_tracer(struct tracer *type)
 
 	printk(KERN_INFO "Starting tracer '%s'\n", type->name);
 	/* Do we want this tracer to start on bootup? */
-	tracing_set_tracer(&global_trace, type->name);
+	WARN_ON(tracing_set_tracer(&global_trace, type->name) < 0);
 	default_bootup_tracer = NULL;
 
 	apply_trace_boot_options();
@@ -5139,6 +5166,7 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 {
 	struct tracer_opt *trace_opts;
 	struct trace_array *tr = m->private;
+	struct tracer_flags *flags;
 	struct tracer *trace;
 	u32 tracer_flags;
 	int i;
@@ -5152,12 +5180,14 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 			seq_printf(m, "no%s\n", trace_options[i]);
 	}
 
-	trace = tr->current_trace;
-	if (!trace->flags || !trace->flags->opts)
+	flags = tr->current_trace_flags;
+	if (!flags || !flags->opts)
 		return 0;
 
-	tracer_flags = tr->current_trace->flags->val;
-	trace_opts = tr->current_trace->flags->opts;
+	trace = tr->current_trace;
+
+	tracer_flags = flags->val;
+	trace_opts = flags->opts;
 
 	for (i = 0; trace_opts[i].name; i++) {
 		if (tracer_flags & trace_opts[i].bit)
@@ -5191,8 +5221,7 @@ static int __set_tracer_option(struct trace_array *tr,
 /* Try to assign a tracer specific option */
 static int set_tracer_option(struct trace_array *tr, char *cmp, int neg)
 {
-	struct tracer *trace = tr->current_trace;
-	struct tracer_flags *tracer_flags = trace->flags;
+	struct tracer_flags *tracer_flags = tr->current_trace_flags;
 	struct tracer_opt *opts = NULL;
 	int i;
 
@@ -5203,7 +5232,7 @@ static int set_tracer_option(struct trace_array *tr, char *cmp, int neg)
 		opts = &tracer_flags->opts[i];
 
 		if (strcmp(cmp, opts->name) == 0)
-			return __set_tracer_option(tr, trace->flags, opts, neg);
+			return __set_tracer_option(tr, tracer_flags, opts, neg);
 	}
 
 	return -EINVAL;
@@ -6235,11 +6264,6 @@ int tracing_update_buffers(struct trace_array *tr)
 	return ret;
 }
 
-struct trace_option_dentry;
-
-static int
-create_trace_option_files(struct trace_array *tr, struct tracer *tracer);
-
 /*
  * Used to clear out the tracer before deletion of an instance.
  * Must have trace_types_lock held.
@@ -6255,26 +6279,15 @@ static void tracing_set_nop(struct trace_array *tr)
 		tr->current_trace->reset(tr);
 
 	tr->current_trace = &nop_trace;
+	tr->current_trace_flags = nop_trace.flags;
 }
 
 static bool tracer_options_updated;
 
-static int add_tracer_options(struct trace_array *tr, struct tracer *t)
-{
-	/* Only enable if the directory has been created already. */
-	if (!tr->dir && !(tr->flags & TRACE_ARRAY_FL_GLOBAL))
-		return 0;
-
-	/* Only create trace option files after update_tracer_options finish */
-	if (!tracer_options_updated)
-		return 0;
-
-	return create_trace_option_files(tr, t);
-}
-
 int tracing_set_tracer(struct trace_array *tr, const char *buf)
 {
-	struct tracer *t;
+	struct tracer *trace = NULL;
+	struct tracers *t;
 #ifdef CONFIG_TRACER_MAX_TRACE
 	bool had_max_tr;
 #endif
@@ -6292,18 +6305,20 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		ret = 0;
 	}
 
-	for (t = trace_types; t; t = t->next) {
-		if (strcmp(t->name, buf) == 0)
+	list_for_each_entry(t, &tr->tracers, list) {
+		if (strcmp(t->tracer->name, buf) == 0) {
+			trace = t->tracer;
 			break;
+		}
 	}
-	if (!t)
+	if (!trace)
 		return -EINVAL;
 
-	if (t == tr->current_trace)
+	if (trace == tr->current_trace)
 		return 0;
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	if (t->use_max_tr) {
+	if (trace->use_max_tr) {
 		local_irq_disable();
 		arch_spin_lock(&tr->max_lock);
 		ret = tr->cond_snapshot ? -EBUSY : 0;
@@ -6314,14 +6329,14 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	}
 #endif
 	/* Some tracers won't work on kernel command line */
-	if (system_state < SYSTEM_RUNNING && t->noboot) {
+	if (system_state < SYSTEM_RUNNING && trace->noboot) {
 		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
-			t->name);
+			trace->name);
 		return -EINVAL;
 	}
 
 	/* Some tracers are only allowed for the top level buffer */
-	if (!trace_ok_for_array(t, tr))
+	if (!trace_ok_for_array(trace, tr))
 		return -EINVAL;
 
 	/* If trace pipe files are being read, we can't change the tracer */
@@ -6340,8 +6355,9 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 	/* Current trace needs to be nop_trace before synchronize_rcu */
 	tr->current_trace = &nop_trace;
+	tr->current_trace_flags = nop_trace.flags;
 
-	if (had_max_tr && !t->use_max_tr) {
+	if (had_max_tr && !trace->use_max_tr) {
 		/*
 		 * We need to make sure that the update_max_tr sees that
 		 * current_trace changed to nop_trace to keep it from
@@ -6354,7 +6370,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		tracing_disarm_snapshot(tr);
 	}
 
-	if (!had_max_tr && t->use_max_tr) {
+	if (!had_max_tr && trace->use_max_tr) {
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
 			return ret;
@@ -6363,18 +6379,21 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	tr->current_trace = &nop_trace;
 #endif
 
-	if (t->init) {
-		ret = tracer_init(t, tr);
+	tr->current_trace_flags = t->flags ? : t->tracer->flags;
+
+	if (trace->init) {
+		ret = tracer_init(trace, tr);
 		if (ret) {
 #ifdef CONFIG_TRACER_MAX_TRACE
-			if (t->use_max_tr)
+			if (trace->use_max_tr)
 				tracing_disarm_snapshot(tr);
 #endif
+			tr->current_trace_flags = nop_trace.flags;
 			return ret;
 		}
 	}
 
-	tr->current_trace = t;
+	tr->current_trace = trace;
 	tr->current_trace->enabled++;
 	trace_branch_enable(tr);
 
@@ -9598,40 +9617,20 @@ create_trace_option_file(struct trace_array *tr,
 
 	topt->entry = trace_create_file(opt->name, TRACE_MODE_WRITE,
 					t_options, topt, &trace_options_fops);
-
 }
 
 static int
-create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
+create_trace_option_files(struct trace_array *tr, struct tracer *tracer,
+			  struct tracer_flags *flags)
 {
 	struct trace_option_dentry *topts;
 	struct trace_options *tr_topts;
-	struct tracer_flags *flags;
 	struct tracer_opt *opts;
 	int cnt;
-	int i;
-
-	if (!tracer)
-		return 0;
-
-	flags = tracer->flags;
 
 	if (!flags || !flags->opts)
 		return 0;
 
-	/*
-	 * If this is an instance, only create flags for tracers
-	 * the instance may have.
-	 */
-	if (!trace_ok_for_array(tracer, tr))
-		return 0;
-
-	for (i = 0; i < tr->nr_topts; i++) {
-		/* Make sure there's no duplicate flags. */
-		if (WARN_ON_ONCE(tr->topts[i].tracer->flags == tracer->flags))
-			return -EINVAL;
-	}
-
 	opts = flags->opts;
 
 	for (cnt = 0; opts[cnt].name; cnt++)
@@ -9663,6 +9662,96 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 	return 0;
 }
 
+static int get_global_flags_val(struct tracer *tracer)
+{
+	struct tracers *t;
+
+	list_for_each_entry(t, &global_trace.tracers, list) {
+		if (t->tracer != tracer)
+			continue;
+		if (!t->flags)
+			return -1;
+		return t->flags->val;
+	}
+	return -1;
+}
+
+static int add_tracer_options(struct trace_array *tr, struct tracers *t)
+{
+	struct tracer *tracer = t->tracer;
+	struct tracer_flags *flags = t->flags ?: tracer->flags;
+
+	if (!flags)
+		return 0;
+
+	/* Only add tracer options after update_tracer_options finish */
+	if (!tracer_options_updated)
+		return 0;
+
+	return create_trace_option_files(tr, tracer, flags);
+}
+
+static int add_tracer(struct trace_array *tr, struct tracer *tracer)
+{
+	struct tracer_flags *flags;
+	struct tracers *t;
+	int ret;
+
+	/* Only enable if the directory has been created already. */
+	if (!tr->dir && !(tr->flags & TRACE_ARRAY_FL_GLOBAL))
+		return 0;
+
+	/*
+	 * If this is an instance, only create flags for tracers
+	 * the instance may have.
+	 */
+	if (!trace_ok_for_array(tracer, tr))
+		return 0;
+
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	t->tracer = tracer;
+	t->flags = NULL;
+	list_add(&t->list, &tr->tracers);
+
+	flags = tracer->flags;
+	if (!flags) {
+		if (!tracer->default_flags)
+			return 0;
+
+		/*
+		 * If the tracer defines default flags, it means the flags are
+		 * per trace instance.
+		 */
+		flags = kmalloc(sizeof(*flags), GFP_KERNEL);
+		if (!flags)
+			return -ENOMEM;
+
+		*flags = *tracer->default_flags;
+		flags->trace = tracer;
+
+		t->flags = flags;
+
+		/* If this is an instance, inherit the global_trace flags */
+		if (!(tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
+			int val = get_global_flags_val(tracer);
+			if (!WARN_ON_ONCE(val < 0))
+				flags->val = val;
+		}
+	}
+
+	ret = add_tracer_options(tr, t);
+	if (ret < 0) {
+		list_del(&t->list);
+		kfree(t->flags);
+		kfree(t);
+	}
+
+	return ret;
+}
+
 static struct dentry *
 create_trace_option_core_file(struct trace_array *tr,
 			      const char *option, long index)
@@ -10111,13 +10200,27 @@ static void init_trace_flags_index(struct trace_array *tr)
 		tr->trace_flags_index[i] = i;
 }
 
-static int __update_tracer_options(struct trace_array *tr)
+static int __update_tracer(struct trace_array *tr)
 {
 	struct tracer *t;
 	int ret = 0;
 
 	for (t = trace_types; t && !ret; t = t->next)
+		ret = add_tracer(tr, t);
+
+	return ret;
+}
+
+static __init int __update_tracer_options(struct trace_array *tr)
+{
+	struct tracers *t;
+	int ret = 0;
+
+	list_for_each_entry(t, &tr->tracers, list) {
 		ret = add_tracer_options(tr, t);
+		if (ret < 0)
+			break;
+	}
 
 	return ret;
 }
@@ -10171,7 +10274,7 @@ static int trace_array_create_dir(struct trace_array *tr)
 	}
 
 	init_tracer_tracefs(tr, tr->dir);
-	ret = __update_tracer_options(tr);
+	ret = __update_tracer(tr);
 	if (ret) {
 		event_trace_del_tracer(tr);
 		tracefs_remove(tr->dir);
@@ -10226,11 +10329,13 @@ trace_array_create_systems(const char *name, const char *systems,
 	spin_lock_init(&tr->snapshot_trigger_lock);
 #endif
 	tr->current_trace = &nop_trace;
+	tr->current_trace_flags = nop_trace.flags;
 
 	INIT_LIST_HEAD(&tr->systems);
 	INIT_LIST_HEAD(&tr->events);
 	INIT_LIST_HEAD(&tr->hist_vars);
 	INIT_LIST_HEAD(&tr->err_log);
+	INIT_LIST_HEAD(&tr->tracers);
 	INIT_LIST_HEAD(&tr->marker_list);
 
 #ifdef CONFIG_MODULES
@@ -10403,6 +10508,7 @@ static int __remove_instance(struct trace_array *tr)
 	free_percpu(tr->last_func_repeats);
 	free_trace_buffers(tr);
 	clear_tracing_err_log(tr);
+	free_tracers(tr);
 
 	if (tr->range_name) {
 		reserve_mem_release_by_name(tr->range_name);
@@ -11437,6 +11543,7 @@ __init static int tracer_alloc_buffers(void)
 	 * just a bootstrap of current_trace anyway.
 	 */
 	global_trace.current_trace = &nop_trace;
+	global_trace.current_trace_flags = nop_trace.flags;
 
 	global_trace.max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -11450,10 +11557,7 @@ __init static int tracer_alloc_buffers(void)
 
 	init_trace_flags_index(&global_trace);
 
-	register_tracer(&nop_trace);
-
-	/* Function tracing may start here (via kernel command line) */
-	init_function_trace();
+	INIT_LIST_HEAD(&global_trace.tracers);
 
 	/* All seems OK, enable tracing */
 	tracing_disabled = 0;
@@ -11474,6 +11578,11 @@ __init static int tracer_alloc_buffers(void)
 	list_add(&global_trace.marker_list, &marker_copies);
 	list_add(&global_trace.list, &ftrace_trace_arrays);
 
+	register_tracer(&nop_trace);
+
+	/* Function tracing may start here (via kernel command line) */
+	init_function_trace();
+
 	apply_trace_boot_options();
 
 	register_snapshot_cmd();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8ecaf91ca823..299862aad66c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -392,6 +392,7 @@ struct trace_array {
 	int			buffer_percent;
 	unsigned int		n_err_log_entries;
 	struct tracer		*current_trace;
+	struct tracer_flags	*current_trace_flags;
 	u64			trace_flags;
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
 	unsigned int		flags;
@@ -406,6 +407,7 @@ struct trace_array {
 	struct list_head	systems;
 	struct list_head	events;
 	struct list_head	marker_list;
+	struct list_head	tracers;
 	struct trace_event_file *trace_marker_file;
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
 	/* one per_cpu trace_pipe can be opened by only one user */
@@ -637,6 +639,7 @@ struct tracer {
 						u64 mask, int set);
 	struct tracer		*next;
 	struct tracer_flags	*flags;
+	struct tracer_flags	*default_flags;
 	int			enabled;
 	bool			print_max;
 	bool			allow_instances;
-- 
2.51.0


