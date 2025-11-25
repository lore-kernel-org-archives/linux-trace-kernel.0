Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4933B6DC;
	Tue, 25 Nov 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101328; cv=none; b=T6lPeqRJezW0hWGR+pbseGSFqGMhgttsvAqjkUTKMQVX/TXWsjqtYIA+b+JdVbB6bwosGYqOnC6ssmAGBzR/PHl3rsg5DUPeRWhyS++ouwZCjm5RecQOb916pP1V0F/TkLUXI9WZot4UiSpbZZqNeDX8KXS1sQY0DeAIbwUP0H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101328; c=relaxed/simple;
	bh=1474bspfUG+zLCr2uM132tJe0uyQ7LvlFtTGKUxTlW4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RJybPUbLAiNzhPwc4wt4LEt3woNgifuchu1KLRU6dzOrIIT+1yrAarLqeBYvBxsfSvqjxG27xEY71kxfFGssSElSqCu6jTLZNy2MogaOUhbu/Z0JTL/1/etFab9QbEECnnR4iokBT3AIjY5GMBFbwsuKF87kQJsxwmj7BtuwVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpZK0h1w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpZK0h1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FC5C116D0;
	Tue, 25 Nov 2025 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764101328;
	bh=1474bspfUG+zLCr2uM132tJe0uyQ7LvlFtTGKUxTlW4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rpZK0h1wCA5JMMNv2llyiqdpEuv1P3h5o5P5sfjxqWVHiOHPYayxUV3hTEuo4Yr8M
	 fHVqobB/am/z1uwrwo7yjPaOExY/J0eChxefl3vl352n++dbjwA+mQdSgepWsiqubx
	 5iDiYnsYdq1RAgUNf/a/xVF9Ljhg6san9nKJnIl9Sm2UMECqPgAT6eTBlb6DjVGViA
	 3vjafjQRwE7P7QS9w0BZAWhy+SvDki+ZGAbPBgkvcEM1YefnSTEYCcXd6rQ3TbRVgp
	 HC21OLPbnpPJNsu2pd++64bShYi/oMpbKPvYx7fsDLuH3s59VKzQ4vcoB/VSqGT0DM
	 5K88UoZf/WW1w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vNzLw-00000005p1Q-1mae;
	Tue, 25 Nov 2025 15:09:32 -0500
Message-ID: <20251125200932.274566147@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 25 Nov 2025 15:08:58 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 1/2] tracing: Remove get_trigger_ops() and add count_func() from trigger
 ops
References: <20251125200857.975524485@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The struct event_command has a callback function called get_trigger_ops().
This callback returns the "trigger_ops" to use for the trigger. These ops
define the trigger function, how to init the trigger, how to print the
trigger and how to free it.

The only reason there's a callback function to get these ops is because
some triggers have two types of operations. One is an "always on"
operation, and the other is a "count down" operation. If a user passes in
a parameter to say how many times the trigger should execute. For example:

  echo stacktrace:5 > events/kmem/kmem_cache_alloc/trigger

It will trigger the stacktrace for the first 5 times the kmem_cache_alloc
event is hit.

Instead of having two different trigger_ops since the only difference
between them is the tigger itself (the print, init and free functions are
all the same), just use a single ops that the event_command points to and
add a function field to the trigger_ops to have a count_func.

When a trigger is added to an event, if there's a count attached to it and
the trigger ops has the count_func field, the data allocated to represent
this trigger will have a new flag set called COUNT.

Then when the trigger executes, it will check if the COUNT data flag is
set, and if so, it will call the ops count_func(). If that returns false,
it returns without executing the trigger.

This removes the need for duplicate event_trigger_ops structures.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                |  26 ++-
 kernel/trace/trace_eprobe.c         |   8 +-
 kernel/trace/trace_events_hist.c    |  60 +------
 kernel/trace/trace_events_trigger.c | 257 ++++++++++------------------
 4 files changed, 116 insertions(+), 235 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index da5d9527ebd6..b9c59d9f9a0c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1791,6 +1791,7 @@ extern void clear_event_triggers(struct trace_array *tr);
 
 enum {
 	EVENT_TRIGGER_FL_PROBE		= BIT(0),
+	EVENT_TRIGGER_FL_COUNT		= BIT(1),
 };
 
 struct event_trigger_data {
@@ -1822,6 +1823,10 @@ struct enable_trigger_data {
 	bool				hist;
 };
 
+bool event_trigger_count(struct event_trigger_data *data,
+			 struct trace_buffer *buffer,  void *rec,
+			 struct ring_buffer_event *event);
+
 extern int event_enable_trigger_print(struct seq_file *m,
 				      struct event_trigger_data *data);
 extern void event_enable_trigger_free(struct event_trigger_data *data);
@@ -1909,6 +1914,11 @@ extern void event_file_put(struct trace_event_file *file);
  *	registered the trigger (see struct event_command) along with
  *	the trace record, rec.
  *
+ * @count_func: If defined and a numeric parameter is passed to the
+ *	trigger, then this function will be called before @trigger
+ *	is called. If this function returns false, then @trigger is not
+ *	executed.
+ *
  * @init: An optional initialization function called for the trigger
  *	when the trigger is registered (via the event_command reg()
  *	function).  This can be used to perform per-trigger
@@ -1936,6 +1946,10 @@ struct event_trigger_ops {
 					   struct trace_buffer *buffer,
 					   void *rec,
 					   struct ring_buffer_event *rbe);
+	bool			(*count_func)(struct event_trigger_data *data,
+					      struct trace_buffer *buffer,
+					      void *rec,
+					      struct ring_buffer_event *rbe);
 	int			(*init)(struct event_trigger_data *data);
 	void			(*free)(struct event_trigger_data *data);
 	int			(*print)(struct seq_file *m,
@@ -1962,6 +1976,9 @@ struct event_trigger_ops {
  * @name: The unique name that identifies the event command.  This is
  *	the name used when setting triggers via trigger files.
  *
+ * @trigger_ops: The event_trigger_ops implementation associated with
+ *	the command.
+ *
  * @trigger_type: A unique id that identifies the event command
  *	'type'.  This value has two purposes, the first to ensure that
  *	only one trigger of the same type can be set at a given time
@@ -2013,17 +2030,11 @@ struct event_trigger_ops {
  *	event command, filters set by the user for the command will be
  *	ignored.  This is usually implemented by the generic utility
  *	function @set_trigger_filter() (see trace_event_triggers.c).
- *
- * @get_trigger_ops: The callback function invoked to retrieve the
- *	event_trigger_ops implementation associated with the command.
- *	This callback function allows a single event_command to
- *	support multiple trigger implementations via different sets of
- *	event_trigger_ops, depending on the value of the @param
- *	string.
  */
 struct event_command {
 	struct list_head	list;
 	char			*name;
+	const struct event_trigger_ops *trigger_ops;
 	enum event_trigger_type	trigger_type;
 	int			flags;
 	int			(*parse)(struct event_command *cmd_ops,
@@ -2040,7 +2051,6 @@ struct event_command {
 	int			(*set_filter)(char *filter_str,
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
-	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
 };
 
 /**
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index a1d402124836..14ae896dbe75 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -513,21 +513,15 @@ static void eprobe_trigger_unreg_func(char *glob,
 
 }
 
-static const struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
-							      char *param)
-{
-	return &eprobe_trigger_ops;
-}
-
 static struct event_command event_trigger_cmd = {
 	.name			= "eprobe",
 	.trigger_type		= ETT_EVENT_EPROBE,
 	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.trigger_ops		= &eprobe_trigger_ops,
 	.parse			= eprobe_trigger_cmd_parse,
 	.reg			= eprobe_trigger_reg_func,
 	.unreg			= eprobe_trigger_unreg_func,
 	.unreg_all		= NULL,
-	.get_trigger_ops	= eprobe_trigger_get_ops,
 	.set_filter		= NULL,
 };
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1d536219b624..f9cc8d6a215b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6363,12 +6363,6 @@ static const struct event_trigger_ops event_hist_trigger_named_ops = {
 	.free			= event_hist_trigger_named_free,
 };
 
-static const struct event_trigger_ops *event_hist_get_trigger_ops(char *cmd,
-								  char *param)
-{
-	return &event_hist_trigger_ops;
-}
-
 static void hist_clear(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
@@ -6908,11 +6902,11 @@ static struct event_command trigger_hist_cmd = {
 	.name			= "hist",
 	.trigger_type		= ETT_EVENT_HIST,
 	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.trigger_ops		= &event_hist_trigger_ops,
 	.parse			= event_hist_trigger_parse,
 	.reg			= hist_register_trigger,
 	.unreg			= hist_unregister_trigger,
 	.unreg_all		= hist_unreg_all,
-	.get_trigger_ops	= event_hist_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
@@ -6945,29 +6939,9 @@ hist_enable_trigger(struct event_trigger_data *data,
 	}
 }
 
-static void
-hist_enable_count_trigger(struct event_trigger_data *data,
-			  struct trace_buffer *buffer,  void *rec,
-			  struct ring_buffer_event *event)
-{
-	if (!data->count)
-		return;
-
-	if (data->count != -1)
-		(data->count)--;
-
-	hist_enable_trigger(data, buffer, rec, event);
-}
-
 static const struct event_trigger_ops hist_enable_trigger_ops = {
 	.trigger		= hist_enable_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops hist_enable_count_trigger_ops = {
-	.trigger		= hist_enable_count_trigger,
+	.count_func		= event_trigger_count,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
@@ -6975,36 +6949,12 @@ static const struct event_trigger_ops hist_enable_count_trigger_ops = {
 
 static const struct event_trigger_ops hist_disable_trigger_ops = {
 	.trigger		= hist_enable_trigger,
+	.count_func		= event_trigger_count,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static const struct event_trigger_ops hist_disable_count_trigger_ops = {
-	.trigger		= hist_enable_count_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops *
-hist_enable_get_trigger_ops(char *cmd, char *param)
-{
-	const struct event_trigger_ops *ops;
-	bool enable;
-
-	enable = (strcmp(cmd, ENABLE_HIST_STR) == 0);
-
-	if (enable)
-		ops = param ? &hist_enable_count_trigger_ops :
-			&hist_enable_trigger_ops;
-	else
-		ops = param ? &hist_disable_count_trigger_ops :
-			&hist_disable_trigger_ops;
-
-	return ops;
-}
-
 static void hist_enable_unreg_all(struct trace_event_file *file)
 {
 	struct event_trigger_data *test, *n;
@@ -7023,22 +6973,22 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
 static struct event_command trigger_hist_enable_cmd = {
 	.name			= ENABLE_HIST_STR,
 	.trigger_type		= ETT_HIST_ENABLE,
+	.trigger_ops		= &hist_enable_trigger_ops,
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
-	.get_trigger_ops	= hist_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
 static struct event_command trigger_hist_disable_cmd = {
 	.name			= DISABLE_HIST_STR,
 	.trigger_type		= ETT_HIST_ENABLE,
+	.trigger_ops		= &hist_disable_trigger_ops,
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
-	.get_trigger_ops	= hist_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index cbfc306c0159..576bad18bcdb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -28,6 +28,20 @@ void trigger_data_free(struct event_trigger_data *data)
 	kfree(data);
 }
 
+static inline void data_ops_trigger(struct event_trigger_data *data,
+				    struct trace_buffer *buffer,  void *rec,
+				    struct ring_buffer_event *event)
+{
+	const struct event_trigger_ops *ops = data->ops;
+
+	if (data->flags & EVENT_TRIGGER_FL_COUNT) {
+		if (!ops->count_func(data, buffer, rec, event))
+			return;
+	}
+
+	ops->trigger(data, buffer, rec, event);
+}
+
 /**
  * event_triggers_call - Call triggers associated with a trace event
  * @file: The trace_event_file associated with the event
@@ -70,7 +84,7 @@ event_triggers_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (!rec) {
-			data->ops->trigger(data, buffer, rec, event);
+			data_ops_trigger(data, buffer, rec, event);
 			continue;
 		}
 		filter = rcu_dereference_sched(data->filter);
@@ -80,7 +94,7 @@ event_triggers_call(struct trace_event_file *file,
 			tt |= data->cmd_ops->trigger_type;
 			continue;
 		}
-		data->ops->trigger(data, buffer, rec, event);
+		data_ops_trigger(data, buffer, rec, event);
 	}
 	return tt;
 }
@@ -122,7 +136,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->trigger(data, NULL, NULL, NULL);
+			data_ops_trigger(data, NULL, NULL, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
@@ -377,6 +391,36 @@ __init int unregister_event_command(struct event_command *cmd)
 	return -ENODEV;
 }
 
+/**
+ * event_trigger_count - Optional count function for event triggers
+ * @data: Trigger-specific data
+ * @buffer: The ring buffer that the event is being written to
+ * @rec: The trace entry for the event, NULL for unconditional invocation
+ * @event: The event meta data in the ring buffer
+ *
+ * For triggers that can take a count parameter that doesn't do anything
+ * special, they can use this function to assign to their .count_func
+ * field.
+ *
+ * This simply does a count down of the @data->count field.
+ *
+ * If the @data->count is greater than zero, it will decrement it.
+ *
+ * Returns false if @data->count is zero, otherwise true.
+ */
+bool event_trigger_count(struct event_trigger_data *data,
+			 struct trace_buffer *buffer,  void *rec,
+			 struct ring_buffer_event *event)
+{
+	if (!data->count)
+		return false;
+
+	if (data->count != -1)
+		(data->count)--;
+
+	return true;
+}
+
 /**
  * event_trigger_print - Generic event_trigger_ops @print implementation
  * @name: The name of the event trigger
@@ -807,9 +851,13 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
  * @private_data: User data to associate with the event trigger
  *
  * Allocate an event_trigger_data instance and initialize it.  The
- * @cmd_ops are used along with the @cmd and @param to get the
- * trigger_ops to assign to the event_trigger_data.  @private_data can
- * also be passed in and associated with the event_trigger_data.
+ * @cmd_ops defines how the trigger will operate. If @param is set,
+ * and @cmd_ops->trigger_ops->count_func is non NULL, then the
+ * data->count is set to @param and before the trigger is executed, the
+ * @cmd_ops->trigger_ops->count_func() is called. If that function returns
+ * false, the @cmd_ops->trigger_ops->trigger() function will not be called.
+ * @private_data can also be passed in and associated with the
+ * event_trigger_data.
  *
  * Use trigger_data_free() to free an event_trigger_data object.
  *
@@ -821,18 +869,17 @@ struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
 					      void *private_data)
 {
 	struct event_trigger_data *trigger_data;
-	const struct event_trigger_ops *trigger_ops;
-
-	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
 
 	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
 	if (!trigger_data)
 		return NULL;
 
 	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
+	trigger_data->ops = cmd_ops->trigger_ops;
 	trigger_data->cmd_ops = cmd_ops;
 	trigger_data->private_data = private_data;
+	if (param && cmd_ops->trigger_ops->count_func)
+		trigger_data->flags |= EVENT_TRIGGER_FL_COUNT;
 
 	INIT_LIST_HEAD(&trigger_data->list);
 	INIT_LIST_HEAD(&trigger_data->named_list);
@@ -1271,31 +1318,28 @@ traceon_trigger(struct event_trigger_data *data,
 	tracing_on();
 }
 
-static void
-traceon_count_trigger(struct event_trigger_data *data,
-		      struct trace_buffer *buffer, void *rec,
-		      struct ring_buffer_event *event)
+static bool
+traceon_count_func(struct event_trigger_data *data,
+		   struct trace_buffer *buffer, void *rec,
+		   struct ring_buffer_event *event)
 {
 	struct trace_event_file *file = data->private_data;
 
 	if (file) {
 		if (tracer_tracing_is_on(file->tr))
-			return;
+			return false;
 	} else {
 		if (tracing_is_on())
-			return;
+			return false;
 	}
 
 	if (!data->count)
-		return;
+		return false;
 
 	if (data->count != -1)
 		(data->count)--;
 
-	if (file)
-		tracer_tracing_on(file->tr);
-	else
-		tracing_on();
+	return true;
 }
 
 static void
@@ -1319,31 +1363,28 @@ traceoff_trigger(struct event_trigger_data *data,
 	tracing_off();
 }
 
-static void
-traceoff_count_trigger(struct event_trigger_data *data,
-		       struct trace_buffer *buffer, void *rec,
-		       struct ring_buffer_event *event)
+static bool
+traceoff_count_func(struct event_trigger_data *data,
+		    struct trace_buffer *buffer, void *rec,
+		    struct ring_buffer_event *event)
 {
 	struct trace_event_file *file = data->private_data;
 
 	if (file) {
 		if (!tracer_tracing_is_on(file->tr))
-			return;
+			return false;
 	} else {
 		if (!tracing_is_on())
-			return;
+			return false;
 	}
 
 	if (!data->count)
-		return;
+		return false;
 
 	if (data->count != -1)
 		(data->count)--;
 
-	if (file)
-		tracer_tracing_off(file->tr);
-	else
-		tracing_off();
+	return true;
 }
 
 static int
@@ -1362,13 +1403,7 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 
 static const struct event_trigger_ops traceon_trigger_ops = {
 	.trigger		= traceon_trigger,
-	.print			= traceon_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops traceon_count_trigger_ops = {
-	.trigger		= traceon_count_trigger,
+	.count_func		= traceon_count_func,
 	.print			= traceon_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
@@ -1376,41 +1411,19 @@ static const struct event_trigger_ops traceon_count_trigger_ops = {
 
 static const struct event_trigger_ops traceoff_trigger_ops = {
 	.trigger		= traceoff_trigger,
+	.count_func		= traceoff_count_func,
 	.print			= traceoff_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static const struct event_trigger_ops traceoff_count_trigger_ops = {
-	.trigger		= traceoff_count_trigger,
-	.print			= traceoff_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops *
-onoff_get_trigger_ops(char *cmd, char *param)
-{
-	const struct event_trigger_ops *ops;
-
-	/* we register both traceon and traceoff to this callback */
-	if (strcmp(cmd, "traceon") == 0)
-		ops = param ? &traceon_count_trigger_ops :
-			&traceon_trigger_ops;
-	else
-		ops = param ? &traceoff_count_trigger_ops :
-			&traceoff_trigger_ops;
-
-	return ops;
-}
-
 static struct event_command trigger_traceon_cmd = {
 	.name			= "traceon",
 	.trigger_type		= ETT_TRACE_ONOFF,
+	.trigger_ops		= &traceon_trigger_ops,
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= onoff_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
@@ -1418,10 +1431,10 @@ static struct event_command trigger_traceoff_cmd = {
 	.name			= "traceoff",
 	.trigger_type		= ETT_TRACE_ONOFF,
 	.flags			= EVENT_CMD_FL_POST_TRIGGER,
+	.trigger_ops		= &traceoff_trigger_ops,
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= onoff_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
@@ -1439,20 +1452,6 @@ snapshot_trigger(struct event_trigger_data *data,
 		tracing_snapshot();
 }
 
-static void
-snapshot_count_trigger(struct event_trigger_data *data,
-		       struct trace_buffer *buffer, void *rec,
-		       struct ring_buffer_event *event)
-{
-	if (!data->count)
-		return;
-
-	if (data->count != -1)
-		(data->count)--;
-
-	snapshot_trigger(data, buffer, rec, event);
-}
-
 static int
 register_snapshot_trigger(char *glob,
 			  struct event_trigger_data *data,
@@ -1486,31 +1485,19 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 
 static const struct event_trigger_ops snapshot_trigger_ops = {
 	.trigger		= snapshot_trigger,
+	.count_func		= event_trigger_count,
 	.print			= snapshot_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static const struct event_trigger_ops snapshot_count_trigger_ops = {
-	.trigger		= snapshot_count_trigger,
-	.print			= snapshot_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops *
-snapshot_get_trigger_ops(char *cmd, char *param)
-{
-	return param ? &snapshot_count_trigger_ops : &snapshot_trigger_ops;
-}
-
 static struct event_command trigger_snapshot_cmd = {
 	.name			= "snapshot",
 	.trigger_type		= ETT_SNAPSHOT,
+	.trigger_ops		= &snapshot_trigger_ops,
 	.parse			= event_trigger_parse,
 	.reg			= register_snapshot_trigger,
 	.unreg			= unregister_snapshot_trigger,
-	.get_trigger_ops	= snapshot_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
@@ -1558,20 +1545,6 @@ stacktrace_trigger(struct event_trigger_data *data,
 		trace_dump_stack(STACK_SKIP);
 }
 
-static void
-stacktrace_count_trigger(struct event_trigger_data *data,
-			 struct trace_buffer *buffer, void *rec,
-			 struct ring_buffer_event *event)
-{
-	if (!data->count)
-		return;
-
-	if (data->count != -1)
-		(data->count)--;
-
-	stacktrace_trigger(data, buffer, rec, event);
-}
-
 static int
 stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
@@ -1581,32 +1554,20 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 
 static const struct event_trigger_ops stacktrace_trigger_ops = {
 	.trigger		= stacktrace_trigger,
+	.count_func		= event_trigger_count,
 	.print			= stacktrace_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static const struct event_trigger_ops stacktrace_count_trigger_ops = {
-	.trigger		= stacktrace_count_trigger,
-	.print			= stacktrace_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops *
-stacktrace_get_trigger_ops(char *cmd, char *param)
-{
-	return param ? &stacktrace_count_trigger_ops : &stacktrace_trigger_ops;
-}
-
 static struct event_command trigger_stacktrace_cmd = {
 	.name			= "stacktrace",
 	.trigger_type		= ETT_STACKTRACE,
+	.trigger_ops		= &stacktrace_trigger_ops,
 	.flags			= EVENT_CMD_FL_POST_TRIGGER,
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= stacktrace_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
@@ -1642,24 +1603,24 @@ event_enable_trigger(struct event_trigger_data *data,
 		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
 }
 
-static void
-event_enable_count_trigger(struct event_trigger_data *data,
-			   struct trace_buffer *buffer,  void *rec,
-			   struct ring_buffer_event *event)
+static bool
+event_enable_count_func(struct event_trigger_data *data,
+			struct trace_buffer *buffer,  void *rec,
+			struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
 	if (!data->count)
-		return;
+		return false;
 
 	/* Skip if the event is in a state we want to switch to */
 	if (enable_data->enable == !(enable_data->file->flags & EVENT_FILE_FL_SOFT_DISABLED))
-		return;
+		return false;
 
 	if (data->count != -1)
 		(data->count)--;
 
-	event_enable_trigger(data, buffer, rec, event);
+	return true;
 }
 
 int event_enable_trigger_print(struct seq_file *m,
@@ -1706,13 +1667,7 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 
 static const struct event_trigger_ops event_enable_trigger_ops = {
 	.trigger		= event_enable_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops event_enable_count_trigger_ops = {
-	.trigger		= event_enable_count_trigger,
+	.count_func		= event_enable_count_func,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
@@ -1720,13 +1675,7 @@ static const struct event_trigger_ops event_enable_count_trigger_ops = {
 
 static const struct event_trigger_ops event_disable_trigger_ops = {
 	.trigger		= event_enable_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops event_disable_count_trigger_ops = {
-	.trigger		= event_enable_count_trigger,
+	.count_func		= event_enable_count_func,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
@@ -1906,45 +1855,23 @@ void event_enable_unregister_trigger(char *glob,
 		data->ops->free(data);
 }
 
-static const struct event_trigger_ops *
-event_enable_get_trigger_ops(char *cmd, char *param)
-{
-	const struct event_trigger_ops *ops;
-	bool enable;
-
-#ifdef CONFIG_HIST_TRIGGERS
-	enable = ((strcmp(cmd, ENABLE_EVENT_STR) == 0) ||
-		  (strcmp(cmd, ENABLE_HIST_STR) == 0));
-#else
-	enable = strcmp(cmd, ENABLE_EVENT_STR) == 0;
-#endif
-	if (enable)
-		ops = param ? &event_enable_count_trigger_ops :
-			&event_enable_trigger_ops;
-	else
-		ops = param ? &event_disable_count_trigger_ops :
-			&event_disable_trigger_ops;
-
-	return ops;
-}
-
 static struct event_command trigger_enable_cmd = {
 	.name			= ENABLE_EVENT_STR,
 	.trigger_type		= ETT_EVENT_ENABLE,
+	.trigger_ops		= &event_enable_trigger_ops,
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
-	.get_trigger_ops	= event_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
 static struct event_command trigger_disable_cmd = {
 	.name			= DISABLE_EVENT_STR,
 	.trigger_type		= ETT_EVENT_ENABLE,
+	.trigger_ops		= &event_disable_trigger_ops,
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
-	.get_trigger_ops	= event_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
 
-- 
2.51.0


