Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32222A819;
	Thu, 16 Jan 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038127; cv=none; b=VT6kL9/rmxbQyUTOUAMlb77yRlaTpFcUK99HQVBcqQGm5+LBKy3KXS7B5mL9MAATqG2rJxzxeTJpDk3qe4bqZIk0FdFf9GRTRf/Xk877DL8CPs9wci9EUtSx+ttDbsXBnLNCLwxTk2bvZQseSSjtEIeO0ZF0kP7KqOANg91tBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038127; c=relaxed/simple;
	bh=y4LTdOEBxJLL3cFj7STiotOvKKux37vfBVzToKRXGec=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KE89r+FHNGmgKyqL7h0zAuBP4IdLUYZtC2uwjCXW9e+Sg+SISuNEsnfk2GnqAIekOlRXYD8qn4Tn9gevO6Rk6FmWK7tT4GuQJyN9SXcPfvJPhjZKiHS3rFiSrA4GJddVGMWOfnib7Kv4TR/YAMGy3jqiNAK1aASAsvyE/YMxJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51658C4CEE6;
	Thu, 16 Jan 2025 14:35:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYQy5-00000000syG-1rNx;
	Thu, 16 Jan 2025 09:35:33 -0500
Message-ID: <20250116143533.214496360@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 16 Jan 2025 09:33:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 jochensp@jochen.sprickerhof.de,
 peter.griffin@linaro.org
Subject: [PATCH 1/3] tracing: Add :mod: command to enabled module events
References: <20250116143334.073917300@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add a :mod: command to enable only events from a given module from the
set_events file.

  echo '*:mod:<module>' > set_events

Or

  echo ':mod:<module>' > set_events

Will enable all events for that module. Specific events can also be
enabled via:

  echo '<event>:mod:<module>' > set_events

Or

  echo '<system>:<event>:mod:<module>' > set_events

Or

  echo '*:<event>:mod:<module>' > set_events

The ":mod:" keyword is consistent with the function tracing filter to
enable functions from a given module.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/events.rst | 22 +++++++++++++
 kernel/trace/trace.c           |  2 ++
 kernel/trace/trace_events.c    | 59 ++++++++++++++++++++++++++--------
 3 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 759907c20e75..3db57516eb86 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -55,6 +55,28 @@ command::
 
 	# echo 'irq:*' > /sys/kernel/tracing/set_event
 
+The set_event file may also be used to enable events associated to only
+a specific module::
+
+	# echo ':mod:<module>' > /sys/kernel/tracing/set_event
+
+Will enable all events in the module ``<module>``.
+
+The text before ``:mod:`` will be parsed to specify specific events that the
+module creates::
+
+	# echo '<match>:mod:<module>' > /sys/kernel/tracing/set_event
+
+The above will enable any system or event that ``<match>`` matches. If
+``<match>`` is ``"*"`` then it will match all events.
+
+To enable only a specific event within a system::
+
+	# echo '<system>:<event>:mod:<module>' > /sys/kernel/tracing/set_event
+
+If ``<event>`` is ``"*"`` then it will match all events within the system
+for a given module.
+
 2.2 Via the 'enable' toggle
 ---------------------------
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5aeb898054e7..cb85ee4a8807 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5514,6 +5514,8 @@ static const char readme_msg[] =
 	"\t    efield: For event probes ('e' types), the field is on of the fields\n"
 	"\t            of the <attached-group>/<attached-event>.\n"
 #endif
+	"  set_event\t\t- Enables events by name written into it\n"
+	"\t\t\t  Can enable module events via: :mod:<module>\n"
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
 	"      enable\t\t- Write 0/1 to enable/disable tracing of all events\n"
 	"  events/<system>/\t- Directory containing all trace events for <system>:\n"
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2b9222e7bd5a..5c7d0e07618d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1153,17 +1153,36 @@ static void remove_event_file_dir(struct trace_event_file *file)
  */
 static int
 __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
-			      const char *sub, const char *event, int set)
+			      const char *sub, const char *event, int set,
+			      const char *mod)
 {
 	struct trace_event_file *file;
 	struct trace_event_call *call;
+	char *module __free(kfree) = NULL;
 	const char *name;
 	int ret = -EINVAL;
 	int eret = 0;
 
+	if (mod) {
+		char *p;
+
+		module = kstrdup(mod, GFP_KERNEL);
+		if (!module)
+			return -ENOMEM;
+
+		/* Replace all '-' with '_' as that's what modules do */
+		for (p = strchr(module, '-'); p; p = strchr(p + 1, '-'))
+			*p = '_';
+	}
+
 	list_for_each_entry(file, &tr->events, list) {
 
 		call = file->event_call;
+
+		/* If a module is specified, skip events that are not that module */
+		if (module && (!call->module || strcmp(module_name(call->module), module)))
+			continue;
+
 		name = trace_event_name(call);
 
 		if (!name || !call->class || !call->class->reg)
@@ -1200,12 +1219,13 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 }
 
 static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
-				  const char *sub, const char *event, int set)
+				  const char *sub, const char *event, int set,
+				  const char *mod)
 {
 	int ret;
 
 	mutex_lock(&event_mutex);
-	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set);
+	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set, mod);
 	mutex_unlock(&event_mutex);
 
 	return ret;
@@ -1213,11 +1233,20 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
-	char *event = NULL, *sub = NULL, *match;
+	char *event = NULL, *sub = NULL, *match, *mod;
 	int ret;
 
 	if (!tr)
 		return -ENOENT;
+
+	/* Modules events can be appened with :mod:<module> */
+	mod = strstr(buf, ":mod:");
+	if (mod) {
+		*mod = '\0';
+		/* move to the module name */
+		mod += 5;
+	}
+
 	/*
 	 * The buf format can be <subsystem>:<event-name>
 	 *  *:<event-name> means any event by that name.
@@ -1240,9 +1269,13 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 			sub = NULL;
 		if (!strlen(event) || strcmp(event, "*") == 0)
 			event = NULL;
+	} else if (mod) {
+		/* Allow wildcard for no length or star */
+		if (!strlen(match) || strcmp(match, "*") == 0)
+			match = NULL;
 	}
 
-	ret = __ftrace_set_clr_event(tr, match, sub, event, set);
+	ret = __ftrace_set_clr_event(tr, match, sub, event, set, mod);
 
 	/* Put back the colon to allow this to be called again */
 	if (buf)
@@ -1270,7 +1303,7 @@ int trace_set_clr_event(const char *system, const char *event, int set)
 	if (!tr)
 		return -ENODEV;
 
-	return __ftrace_set_clr_event(tr, NULL, system, event, set);
+	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_set_clr_event);
 
@@ -1296,7 +1329,7 @@ int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		return -ENOENT;
 
 	set = (enable == true) ? 1 : 0;
-	return __ftrace_set_clr_event(tr, NULL, system, event, set);
+	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
 
@@ -1646,7 +1679,7 @@ system_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (system)
 		name = system->name;
 
-	ret = __ftrace_set_clr_event(dir->tr, NULL, name, NULL, val);
+	ret = __ftrace_set_clr_event(dir->tr, NULL, name, NULL, val, NULL);
 	if (ret)
 		goto out;
 
@@ -4094,7 +4127,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 	__ftrace_clear_event_pids(tr, TRACE_PIDS | TRACE_NO_PIDS);
 
 	/* Disable any running events */
-	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0);
+	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0, NULL);
 
 	/* Make sure no more events are being executed */
 	tracepoint_synchronize_unregister();
@@ -4378,7 +4411,7 @@ static __init void event_trace_self_tests(void)
 
 		pr_info("Testing event system %s: ", system->name);
 
-		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 1);
+		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 1, NULL);
 		if (WARN_ON_ONCE(ret)) {
 			pr_warn("error enabling system %s\n",
 				system->name);
@@ -4387,7 +4420,7 @@ static __init void event_trace_self_tests(void)
 
 		event_test_stuff();
 
-		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 0);
+		ret = __ftrace_set_clr_event(tr, NULL, system->name, NULL, 0, NULL);
 		if (WARN_ON_ONCE(ret)) {
 			pr_warn("error disabling system %s\n",
 				system->name);
@@ -4402,7 +4435,7 @@ static __init void event_trace_self_tests(void)
 	pr_info("Running tests on all trace events:\n");
 	pr_info("Testing all events: ");
 
-	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 1);
+	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 1, NULL);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error enabling all events\n");
 		return;
@@ -4411,7 +4444,7 @@ static __init void event_trace_self_tests(void)
 	event_test_stuff();
 
 	/* reset sysname */
-	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 0);
+	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 0, NULL);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error disabling all events\n");
 		return;
-- 
2.45.2


