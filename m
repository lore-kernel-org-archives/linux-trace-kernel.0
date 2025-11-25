Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1D33CEA4;
	Tue, 25 Nov 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101328; cv=none; b=HKhhFXFEcmpnty1bw2PP8U6utPb5jMouZ7a+JzwEbFYo2/c05IvfzGPb4t+qImrt/cNQvqTT24Qgm+W4SPmsUNL8fH54avq04vTSOcS56ao2cUMAsggkpziYkUrY0DajjNDX3QDG8yEemWJjP9b1u5LFQ9f9di3yzRkpwlfz6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101328; c=relaxed/simple;
	bh=+hZMiOH6JZMWir/h/XxWP2a5atzPh9AnsR9dGavQaeo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OFh/IihjTD3thNmNQd0BuJI+JDVn/o3JyRibhhgvXZOw0epqH2gL+uAppu1roIBDBPUNkRu1BTRSA5Zuq1fKTMlfBgqfKxo7muoLWULWAE6cEYJ3ZZ2szwD+WYXCLTi1arQ9nHDCSHoMEUHiaEEEVw0qm9GOoL1DYbh9WsUdx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNOU1AYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNOU1AYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28149C4AF09;
	Tue, 25 Nov 2025 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764101328;
	bh=+hZMiOH6JZMWir/h/XxWP2a5atzPh9AnsR9dGavQaeo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=FNOU1AYbrU5Toc7RZ5tKZKf3hwfopZ5AQ8R7+ObpTeFz8y1fU4x4lUHlX5AwmqzLs
	 /ss6Y+o5g75hYDexyyoSvp17wT44hkG67zscMMFuBoq8KzmBIJu7rvGPhXHhNvEWS3
	 MWmOlHJkJIhIjdiJcsV1RCln8KmSJAe/Q6M06Iz0tIgNHk2fC65VsZLFoPzf0GkfKO
	 ka4so+0C0PXlxII9L/V5sw2nJe2V0NXCyZwzgR1Tjh+rvDg2/r/SnbtRgsSsduwemH
	 0S+wRP+w3MEqRJfZhVsOz+2tQHqTOXTuBmfqkQTF+Tw9Hdtr9U3Ft2dFmLWTuhfgAX
	 j52gkVPjwckig==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vNzLw-00000005p1v-2Vbu;
	Tue, 25 Nov 2025 15:09:32 -0500
Message-ID: <20251125200932.446322765@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 25 Nov 2025 15:08:59 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 2/2] tracing: Merge struct event_trigger_ops into struct event_command
References: <20251125200857.975524485@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Now that there's pretty much a one to one mapping between the struct
event_trigger_ops and struct event_command, there's no reason to have two
different structures. Merge the function pointers of event_trigger_ops
into event_command.

There's one exception in trace_events_hist.c for the
event_hist_trigger_named_ops. This has special logic for the init and free
function pointers for "named histograms". In this case, allocate the
cmd_ops of the event_trigger_data and set it to the proper init and free
functions, which are used to initialize and free the event_trigger_data
respectively. Have the free function and the init function (on failure)
free the cmd_ops of the data element.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20251119031603.658997916@kernel.org

- Removed duplicate declaration of trigger_hist_cmd (Tom Zanussi)

 kernel/trace/trace.h                | 126 +++++++++++-----------------
 kernel/trace/trace_eprobe.c         |  13 +--
 kernel/trace/trace_events_hist.c    |  93 ++++++++++----------
 kernel/trace/trace_events_trigger.c | 121 +++++++++++---------------
 4 files changed, 151 insertions(+), 202 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b9c59d9f9a0c..901aad30099b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1798,7 +1798,6 @@ struct event_trigger_data {
 	unsigned long			count;
 	int				ref;
 	int				flags;
-	const struct event_trigger_ops	*ops;
 	struct event_command		*cmd_ops;
 	struct event_filter __rcu	*filter;
 	char				*filter_str;
@@ -1889,73 +1888,6 @@ extern void event_trigger_unregister(struct event_command *cmd_ops,
 extern void event_file_get(struct trace_event_file *file);
 extern void event_file_put(struct trace_event_file *file);
 
-/**
- * struct event_trigger_ops - callbacks for trace event triggers
- *
- * The methods in this structure provide per-event trigger hooks for
- * various trigger operations.
- *
- * The @init and @free methods are used during trigger setup and
- * teardown, typically called from an event_command's @parse()
- * function implementation.
- *
- * The @print method is used to print the trigger spec.
- *
- * The @trigger method is the function that actually implements the
- * trigger and is called in the context of the triggering event
- * whenever that event occurs.
- *
- * All the methods below, except for @init() and @free(), must be
- * implemented.
- *
- * @trigger: The trigger 'probe' function called when the triggering
- *	event occurs.  The data passed into this callback is the data
- *	that was supplied to the event_command @reg() function that
- *	registered the trigger (see struct event_command) along with
- *	the trace record, rec.
- *
- * @count_func: If defined and a numeric parameter is passed to the
- *	trigger, then this function will be called before @trigger
- *	is called. If this function returns false, then @trigger is not
- *	executed.
- *
- * @init: An optional initialization function called for the trigger
- *	when the trigger is registered (via the event_command reg()
- *	function).  This can be used to perform per-trigger
- *	initialization such as incrementing a per-trigger reference
- *	count, for instance.  This is usually implemented by the
- *	generic utility function @event_trigger_init() (see
- *	trace_event_triggers.c).
- *
- * @free: An optional de-initialization function called for the
- *	trigger when the trigger is unregistered (via the
- *	event_command @reg() function).  This can be used to perform
- *	per-trigger de-initialization such as decrementing a
- *	per-trigger reference count and freeing corresponding trigger
- *	data, for instance.  This is usually implemented by the
- *	generic utility function @event_trigger_free() (see
- *	trace_event_triggers.c).
- *
- * @print: The callback function invoked to have the trigger print
- *	itself.  This is usually implemented by a wrapper function
- *	that calls the generic utility function @event_trigger_print()
- *	(see trace_event_triggers.c).
- */
-struct event_trigger_ops {
-	void			(*trigger)(struct event_trigger_data *data,
-					   struct trace_buffer *buffer,
-					   void *rec,
-					   struct ring_buffer_event *rbe);
-	bool			(*count_func)(struct event_trigger_data *data,
-					      struct trace_buffer *buffer,
-					      void *rec,
-					      struct ring_buffer_event *rbe);
-	int			(*init)(struct event_trigger_data *data);
-	void			(*free)(struct event_trigger_data *data);
-	int			(*print)(struct seq_file *m,
-					 struct event_trigger_data *data);
-};
-
 /**
  * struct event_command - callbacks and data members for event commands
  *
@@ -1976,9 +1908,6 @@ struct event_trigger_ops {
  * @name: The unique name that identifies the event command.  This is
  *	the name used when setting triggers via trigger files.
  *
- * @trigger_ops: The event_trigger_ops implementation associated with
- *	the command.
- *
  * @trigger_type: A unique id that identifies the event command
  *	'type'.  This value has two purposes, the first to ensure that
  *	only one trigger of the same type can be set at a given time
@@ -2008,7 +1937,7 @@ struct event_trigger_ops {
  *
  * @reg: Adds the trigger to the list of triggers associated with the
  *	event, and enables the event trigger itself, after
- *	initializing it (via the event_trigger_ops @init() function).
+ *	initializing it (via the event_command @init() function).
  *	This is also where commands can use the @trigger_type value to
  *	make the decision as to whether or not multiple instances of
  *	the trigger should be allowed.  This is usually implemented by
@@ -2017,7 +1946,7 @@ struct event_trigger_ops {
  *
  * @unreg: Removes the trigger from the list of triggers associated
  *	with the event, and disables the event trigger itself, after
- *	initializing it (via the event_trigger_ops @free() function).
+ *	initializing it (via the event_command @free() function).
  *	This is usually implemented by the generic utility function
  *	@unregister_trigger() (see trace_event_triggers.c).
  *
@@ -2030,11 +1959,46 @@ struct event_trigger_ops {
  *	event command, filters set by the user for the command will be
  *	ignored.  This is usually implemented by the generic utility
  *	function @set_trigger_filter() (see trace_event_triggers.c).
+ *
+ * All the methods below, except for @init() and @free(), must be
+ * implemented.
+ *
+ * @trigger: The trigger 'probe' function called when the triggering
+ *	event occurs.  The data passed into this callback is the data
+ *	that was supplied to the event_command @reg() function that
+ *	registered the trigger (see struct event_command) along with
+ *	the trace record, rec.
+ *
+ * @count_func: If defined and a numeric parameter is passed to the
+ *	trigger, then this function will be called before @trigger
+ *	is called. If this function returns false, then @trigger is not
+ *	executed.
+ *
+ * @init: An optional initialization function called for the trigger
+ *	when the trigger is registered (via the event_command reg()
+ *	function).  This can be used to perform per-trigger
+ *	initialization such as incrementing a per-trigger reference
+ *	count, for instance.  This is usually implemented by the
+ *	generic utility function @event_trigger_init() (see
+ *	trace_event_triggers.c).
+ *
+ * @free: An optional de-initialization function called for the
+ *	trigger when the trigger is unregistered (via the
+ *	event_command @reg() function).  This can be used to perform
+ *	per-trigger de-initialization such as decrementing a
+ *	per-trigger reference count and freeing corresponding trigger
+ *	data, for instance.  This is usually implemented by the
+ *	generic utility function @event_trigger_free() (see
+ *	trace_event_triggers.c).
+ *
+ * @print: The callback function invoked to have the trigger print
+ *	itself.  This is usually implemented by a wrapper function
+ *	that calls the generic utility function @event_trigger_print()
+ *	(see trace_event_triggers.c).
  */
 struct event_command {
 	struct list_head	list;
 	char			*name;
-	const struct event_trigger_ops *trigger_ops;
 	enum event_trigger_type	trigger_type;
 	int			flags;
 	int			(*parse)(struct event_command *cmd_ops,
@@ -2051,6 +2015,18 @@ struct event_command {
 	int			(*set_filter)(char *filter_str,
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
+	void			(*trigger)(struct event_trigger_data *data,
+					   struct trace_buffer *buffer,
+					   void *rec,
+					   struct ring_buffer_event *rbe);
+	bool			(*count_func)(struct event_trigger_data *data,
+					      struct trace_buffer *buffer,
+					      void *rec,
+					      struct ring_buffer_event *rbe);
+	int			(*init)(struct event_trigger_data *data);
+	void			(*free)(struct event_trigger_data *data);
+	int			(*print)(struct seq_file *m,
+					 struct event_trigger_data *data);
 };
 
 /**
@@ -2071,7 +2047,7 @@ struct event_command {
  *	either committed or discarded.  At that point, if any commands
  *	have deferred their triggers, those commands are finally
  *	invoked following the close of the current event.  In other
- *	words, if the event_trigger_ops @func() probe implementation
+ *	words, if the event_command @func() probe implementation
  *	itself logs to the trace buffer, this flag should be set,
  *	otherwise it can be left unspecified.
  *
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 14ae896dbe75..f3e0442c3b96 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -484,13 +484,6 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
 	__eprobe_trace_func(edata, rec);
 }
 
-static const struct event_trigger_ops eprobe_trigger_ops = {
-	.trigger		= eprobe_trigger_func,
-	.print			= eprobe_trigger_print,
-	.init			= eprobe_trigger_init,
-	.free			= eprobe_trigger_free,
-};
-
 static int eprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
 				    char *glob, char *cmd,
@@ -517,12 +510,15 @@ static struct event_command event_trigger_cmd = {
 	.name			= "eprobe",
 	.trigger_type		= ETT_EVENT_EPROBE,
 	.flags			= EVENT_CMD_FL_NEEDS_REC,
-	.trigger_ops		= &eprobe_trigger_ops,
 	.parse			= eprobe_trigger_cmd_parse,
 	.reg			= eprobe_trigger_reg_func,
 	.unreg			= eprobe_trigger_unreg_func,
 	.unreg_all		= NULL,
 	.set_filter		= NULL,
+	.trigger		= eprobe_trigger_func,
+	.print			= eprobe_trigger_print,
+	.init			= eprobe_trigger_init,
+	.free			= eprobe_trigger_free,
 };
 
 static struct event_trigger_data *
@@ -542,7 +538,6 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
 
 	trigger->flags = EVENT_TRIGGER_FL_PROBE;
 	trigger->count = -1;
-	trigger->ops = &eprobe_trigger_ops;
 
 	/*
 	 * EVENT PROBE triggers are not registered as commands with
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f9cc8d6a215b..f0dafc1f2787 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5694,7 +5694,7 @@ static void hist_trigger_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -6016,7 +6016,7 @@ static void hist_trigger_debug_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -6326,20 +6326,21 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 	free_hist_pad();
 }
 
-static const struct event_trigger_ops event_hist_trigger_ops = {
-	.trigger		= event_hist_trigger,
-	.print			= event_hist_trigger_print,
-	.init			= event_hist_trigger_init,
-	.free			= event_hist_trigger_free,
-};
-
 static int event_hist_trigger_named_init(struct event_trigger_data *data)
 {
+	int ret;
+
 	data->ref++;
 
 	save_named_trigger(data->named_data->name, data);
 
-	return event_hist_trigger_init(data->named_data);
+	ret = event_hist_trigger_init(data->named_data);
+	if (ret < 0) {
+		kfree(data->cmd_ops);
+		data->cmd_ops = &trigger_hist_cmd;
+	}
+
+	return ret;
 }
 
 static void event_hist_trigger_named_free(struct event_trigger_data *data)
@@ -6351,18 +6352,14 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 
 	data->ref--;
 	if (!data->ref) {
+		struct event_command *cmd_ops = data->cmd_ops;
+
 		del_named_trigger(data);
 		trigger_data_free(data);
+		kfree(cmd_ops);
 	}
 }
 
-static const struct event_trigger_ops event_hist_trigger_named_ops = {
-	.trigger		= event_hist_trigger,
-	.print			= event_hist_trigger_print,
-	.init			= event_hist_trigger_named_init,
-	.free			= event_hist_trigger_named_free,
-};
-
 static void hist_clear(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
@@ -6556,13 +6553,24 @@ static int hist_register_trigger(char *glob,
 		data->paused = true;
 
 	if (named_data) {
+		struct event_command *cmd_ops;
+
 		data->private_data = named_data->private_data;
 		set_named_trigger_data(data, named_data);
-		data->ops = &event_hist_trigger_named_ops;
+		/* Copy the command ops and update some of the functions */
+		cmd_ops = kmalloc(sizeof(*cmd_ops), GFP_KERNEL);
+		if (!cmd_ops) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		*cmd_ops = *data->cmd_ops;
+		cmd_ops->init = event_hist_trigger_named_init;
+		cmd_ops->free = event_hist_trigger_named_free;
+		data->cmd_ops = cmd_ops;
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -6676,8 +6684,8 @@ static void hist_unregister_trigger(char *glob,
 		}
 	}
 
-	if (test && test->ops->free)
-		test->ops->free(test);
+	if (test && test->cmd_ops->free)
+		test->cmd_ops->free(test);
 
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || test)
@@ -6729,8 +6737,8 @@ static void hist_unreg_all(struct trace_event_file *file)
 			update_cond_flag(file);
 			if (hist_data->enable_timestamps)
 				tracing_set_filter_buffering(file->tr, false);
-			if (test->ops->free)
-				test->ops->free(test);
+			if (test->cmd_ops->free)
+				test->cmd_ops->free(test);
 		}
 	}
 }
@@ -6902,12 +6910,15 @@ static struct event_command trigger_hist_cmd = {
 	.name			= "hist",
 	.trigger_type		= ETT_EVENT_HIST,
 	.flags			= EVENT_CMD_FL_NEEDS_REC,
-	.trigger_ops		= &event_hist_trigger_ops,
 	.parse			= event_hist_trigger_parse,
 	.reg			= hist_register_trigger,
 	.unreg			= hist_unregister_trigger,
 	.unreg_all		= hist_unreg_all,
 	.set_filter		= set_trigger_filter,
+	.trigger		= event_hist_trigger,
+	.print			= event_hist_trigger_print,
+	.init			= event_hist_trigger_init,
+	.free			= event_hist_trigger_free,
 };
 
 __init int register_trigger_hist_cmd(void)
@@ -6939,22 +6950,6 @@ hist_enable_trigger(struct event_trigger_data *data,
 	}
 }
 
-static const struct event_trigger_ops hist_enable_trigger_ops = {
-	.trigger		= hist_enable_trigger,
-	.count_func		= event_trigger_count,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops hist_disable_trigger_ops = {
-	.trigger		= hist_enable_trigger,
-	.count_func		= event_trigger_count,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
 static void hist_enable_unreg_all(struct trace_event_file *file)
 {
 	struct event_trigger_data *test, *n;
@@ -6964,8 +6959,8 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			update_cond_flag(file);
 			trace_event_trigger_enable_disable(file, 0);
-			if (test->ops->free)
-				test->ops->free(test);
+			if (test->cmd_ops->free)
+				test->cmd_ops->free(test);
 		}
 	}
 }
@@ -6973,23 +6968,31 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
 static struct event_command trigger_hist_enable_cmd = {
 	.name			= ENABLE_HIST_STR,
 	.trigger_type		= ETT_HIST_ENABLE,
-	.trigger_ops		= &hist_enable_trigger_ops,
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
 	.set_filter		= set_trigger_filter,
+	.trigger		= hist_enable_trigger,
+	.count_func		= event_trigger_count,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static struct event_command trigger_hist_disable_cmd = {
 	.name			= DISABLE_HIST_STR,
 	.trigger_type		= ETT_HIST_ENABLE,
-	.trigger_ops		= &hist_disable_trigger_ops,
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
 	.set_filter		= set_trigger_filter,
+	.trigger		= hist_enable_trigger,
+	.count_func		= event_trigger_count,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static __init void unregister_trigger_hist_enable_disable_cmds(void)
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 576bad18bcdb..7795af600466 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -32,14 +32,14 @@ static inline void data_ops_trigger(struct event_trigger_data *data,
 				    struct trace_buffer *buffer,  void *rec,
 				    struct ring_buffer_event *event)
 {
-	const struct event_trigger_ops *ops = data->ops;
+	const struct event_command *cmd_ops = data->cmd_ops;
 
 	if (data->flags & EVENT_TRIGGER_FL_COUNT) {
-		if (!ops->count_func(data, buffer, rec, event))
+		if (!cmd_ops->count_func(data, buffer, rec, event))
 			return;
 	}
 
-	ops->trigger(data, buffer, rec, event);
+	cmd_ops->trigger(data, buffer, rec, event);
 }
 
 /**
@@ -205,7 +205,7 @@ static int trigger_show(struct seq_file *m, void *v)
 	}
 
 	data = list_entry(v, struct event_trigger_data, list);
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 
 	return 0;
 }
@@ -422,7 +422,7 @@ bool event_trigger_count(struct event_trigger_data *data,
 }
 
 /**
- * event_trigger_print - Generic event_trigger_ops @print implementation
+ * event_trigger_print - Generic event_command @print implementation
  * @name: The name of the event trigger
  * @m: The seq_file being printed to
  * @data: Trigger-specific data
@@ -457,7 +457,7 @@ event_trigger_print(const char *name, struct seq_file *m,
 }
 
 /**
- * event_trigger_init - Generic event_trigger_ops @init implementation
+ * event_trigger_init - Generic event_command @init implementation
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger initialization.
@@ -474,7 +474,7 @@ int event_trigger_init(struct event_trigger_data *data)
 }
 
 /**
- * event_trigger_free - Generic event_trigger_ops @free implementation
+ * event_trigger_free - Generic event_command @free implementation
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger de-initialization.
@@ -536,8 +536,8 @@ clear_event_triggers(struct trace_array *tr)
 		list_for_each_entry_safe(data, n, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
-			if (data->ops->free)
-				data->ops->free(data);
+			if (data->cmd_ops->free)
+				data->cmd_ops->free(data);
 		}
 	}
 }
@@ -600,8 +600,8 @@ static int register_trigger(char *glob,
 			return -EEXIST;
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			return ret;
 	}
@@ -639,8 +639,8 @@ static bool try_unregister_trigger(char *glob,
 	}
 
 	if (data) {
-		if (data->ops->free)
-			data->ops->free(data);
+		if (data->cmd_ops->free)
+			data->cmd_ops->free(data);
 
 		return true;
 	}
@@ -875,10 +875,9 @@ struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
 		return NULL;
 
 	trigger_data->count = -1;
-	trigger_data->ops = cmd_ops->trigger_ops;
 	trigger_data->cmd_ops = cmd_ops;
 	trigger_data->private_data = private_data;
-	if (param && cmd_ops->trigger_ops->count_func)
+	if (param && cmd_ops->count_func)
 		trigger_data->flags |= EVENT_TRIGGER_FL_COUNT;
 
 	INIT_LIST_HEAD(&trigger_data->list);
@@ -1401,41 +1400,33 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static const struct event_trigger_ops traceon_trigger_ops = {
-	.trigger		= traceon_trigger,
-	.count_func		= traceon_count_func,
-	.print			= traceon_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops traceoff_trigger_ops = {
-	.trigger		= traceoff_trigger,
-	.count_func		= traceoff_count_func,
-	.print			= traceoff_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
 static struct event_command trigger_traceon_cmd = {
 	.name			= "traceon",
 	.trigger_type		= ETT_TRACE_ONOFF,
-	.trigger_ops		= &traceon_trigger_ops,
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
 	.set_filter		= set_trigger_filter,
+	.trigger		= traceon_trigger,
+	.count_func		= traceon_count_func,
+	.print			= traceon_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static struct event_command trigger_traceoff_cmd = {
 	.name			= "traceoff",
 	.trigger_type		= ETT_TRACE_ONOFF,
 	.flags			= EVENT_CMD_FL_POST_TRIGGER,
-	.trigger_ops		= &traceoff_trigger_ops,
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
 	.set_filter		= set_trigger_filter,
+	.trigger		= traceoff_trigger,
+	.count_func		= traceoff_count_func,
+	.print			= traceoff_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 #ifdef CONFIG_TRACER_SNAPSHOT
@@ -1483,22 +1474,18 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static const struct event_trigger_ops snapshot_trigger_ops = {
-	.trigger		= snapshot_trigger,
-	.count_func		= event_trigger_count,
-	.print			= snapshot_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
 static struct event_command trigger_snapshot_cmd = {
 	.name			= "snapshot",
 	.trigger_type		= ETT_SNAPSHOT,
-	.trigger_ops		= &snapshot_trigger_ops,
 	.parse			= event_trigger_parse,
 	.reg			= register_snapshot_trigger,
 	.unreg			= unregister_snapshot_trigger,
 	.set_filter		= set_trigger_filter,
+	.trigger		= snapshot_trigger,
+	.count_func		= event_trigger_count,
+	.print			= snapshot_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static __init int register_trigger_snapshot_cmd(void)
@@ -1552,23 +1539,19 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static const struct event_trigger_ops stacktrace_trigger_ops = {
-	.trigger		= stacktrace_trigger,
-	.count_func		= event_trigger_count,
-	.print			= stacktrace_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
 static struct event_command trigger_stacktrace_cmd = {
 	.name			= "stacktrace",
 	.trigger_type		= ETT_STACKTRACE,
-	.trigger_ops		= &stacktrace_trigger_ops,
 	.flags			= EVENT_CMD_FL_POST_TRIGGER,
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
 	.set_filter		= set_trigger_filter,
+	.trigger		= stacktrace_trigger,
+	.count_func		= event_trigger_count,
+	.print			= stacktrace_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static __init int register_trigger_stacktrace_cmd(void)
@@ -1665,22 +1648,6 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 	}
 }
 
-static const struct event_trigger_ops event_enable_trigger_ops = {
-	.trigger		= event_enable_trigger,
-	.count_func		= event_enable_count_func,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops event_disable_trigger_ops = {
-	.trigger		= event_enable_trigger,
-	.count_func		= event_enable_count_func,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
 int event_enable_trigger_parse(struct event_command *cmd_ops,
 			       struct trace_event_file *file,
 			       char *glob, char *cmd, char *param_and_filter)
@@ -1810,8 +1777,8 @@ int event_enable_register_trigger(char *glob,
 		}
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			return ret;
 	}
@@ -1851,28 +1818,36 @@ void event_enable_unregister_trigger(char *glob,
 		}
 	}
 
-	if (data && data->ops->free)
-		data->ops->free(data);
+	if (data && data->cmd_ops->free)
+		data->cmd_ops->free(data);
 }
 
 static struct event_command trigger_enable_cmd = {
 	.name			= ENABLE_EVENT_STR,
 	.trigger_type		= ETT_EVENT_ENABLE,
-	.trigger_ops		= &event_enable_trigger_ops,
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.set_filter		= set_trigger_filter,
+	.trigger		= event_enable_trigger,
+	.count_func		= event_enable_count_func,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static struct event_command trigger_disable_cmd = {
 	.name			= DISABLE_EVENT_STR,
 	.trigger_type		= ETT_EVENT_ENABLE,
-	.trigger_ops		= &event_disable_trigger_ops,
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.set_filter		= set_trigger_filter,
+	.trigger		= event_enable_trigger,
+	.count_func		= event_enable_count_func,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static __init void unregister_trigger_enable_disable_cmds(void)
-- 
2.51.0


