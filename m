Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D92C9D;
	Wed, 26 Nov 2025 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119283; cv=none; b=J8qywe1dGtvdUB5vAeRSfWVb7ZkmWHo22GNOaTO8XMA/xQHdUXH/gPnFG5XyfRq4UVl/wEwkv4fD5/MaVerF9lHaLhF4cMWYXz+ClDZLGinRp57txMr/ViLr1SQ8MIMKRpnnvRBLzJi+PHd21cWjASvrzYrCDF5d4KyolXNaDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119283; c=relaxed/simple;
	bh=4Vxg4P985oc4vpUrLYgs+sZ4v9vvVvTRhWpoclYBh3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D/yXvWowullxCav3aVR1sdr3kdwA9WHSmSJvKnQBAz+/YG1sTNy3nKaVjVEqtrDzSvETHKSqAe3EkyLSFBGfiorsZsusVOUPm7Wll1GGGPhMKy3Lfz1x5prz2KmnFBhMvH2vtszPPJGT6PEva9S6g46wrI7iysn9qRW5DYVr8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 63329514AD;
	Wed, 26 Nov 2025 01:07:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id B83AF2000D;
	Wed, 26 Nov 2025 01:07:57 +0000 (UTC)
Date: Tue, 25 Nov 2025 20:08:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2] tracing: Add system trigger file to enable triggers for
 all the system's events
Message-ID: <20251125200837.31aae207@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k1nd83mjwt8oxf4r3najc44yt1j7uaow
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B83AF2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+KGvnj4dytGDACocqg3D7v9eZJJSOTVRs=
X-HE-Tag: 1764119277-446731
X-HE-Meta: U2FsdGVkX1/M03Wdob7cvjapPh3sBCzjvCKLA6NrqHEiI3Ge8kXgT/AGwaazKw7jzMVXui0Lzgn6MvuLWdrZnGgTXlKDLW7lcKmoH+81j71M9abQGH4SYGy9o6VrDVdsn4T4pc7hTZKMBrXQZwe431g7kerhiKFKSlKyy5qa5LRzXrxXB0C1p7V4ELuH+FC2WPhc6Nk3DymPrA3+kgj1AWsIoDBQiH6vLGdpO86pdLvKNRhXl6A1JtcU5WQvAxH0M/qEKs8dT64K7Jcula8fLuS5oombhWMi1tgKOP3k6kVlFLueFuPcpta/f9BLOruzmIUfyIm1HNQDaXGni42xxeX9N0SVyVD2J7FySb5ub/wNbke5Cyz2F2dRj/TTU8yRoys/OWtDWV8B/kMhDJPJl8W35qjviXkdEt3IYoPgh5VEAGnshpkAfBaYis0LtwwRigYnXmqDgMo9/JinyZJDjZgpz5Y24BBZA6U1ryQlqzU=

From: Steven Rostedt <rostedt@goodmis.org>

Currently a trigger can only be added to individual events. Some triggers
(like stacktrace) can be useful to add as a bulk trigger for a set of
system events (like interrupt or scheduling).

Add a trigger file to the system directories:

   /sys/kernel/tracing/events/*/trigger

And allow stacktrace trigger to be enabled for all those events.

Writing into the system/trigger file acts the same as writing into each of
the system event's trigger files individually.

This also allows to remove a trigger from all events in a subsystem (even
if it's not a subsystem trigger!).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, this is based on top of:

  https://patchwork.kernel.org/project/linux-trace-kernel/cover/20251120205600.570673392@kernel.org/

Changes since v1: https://patch.msgid.link/20251120160003.2fa33d80@gandalf.local.home

- Removed unused set variable len (kernel test robot)

- Assign next to strim(buf) to remove beginning spaces

 Documentation/trace/events.rst      |  25 ++++
 kernel/trace/trace.c                |  11 +-
 kernel/trace/trace.h                |  15 ++-
 kernel/trace/trace_events.c         |  70 +++++-----
 kernel/trace/trace_events_trigger.c | 199 +++++++++++++++++++++++++++-
 5 files changed, 278 insertions(+), 42 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 18d112963dec..caa4958af43a 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -416,6 +416,31 @@ way, so beware about making generalizations between the two.
      can also enable triggers that are written into
      /sys/kernel/tracing/events/ftrace/print/trigger
 
+The system directory also has a trigger file that allows some triggers to be
+set for all the system's events. This is limited to only a small subset of the
+triggers and does not allow for the count parameter. But it does allow for
+filters. Writing into this file is the same as writing into each of the
+system's event's trigger files individually. Although only a subset of
+triggers may use this file for enabling, all triggers may use this file for
+disabling::
+
+	cd /sys/kernel/tracing
+	cat events/sched/trigger
+	# Available system triggers:
+	# stacktrace
+
+	echo stacktrace > events/sched/trigger
+	cat events/sched/sched_switch/trigger
+	stacktrace:unlimited
+
+	echo snapshot > events/sched/sched_waking/trigger
+	cat events/sched/sched_waking/trigger
+	snapshot:unlimited
+	echo '!snapshot' > events/sched/trigger
+	cat events/sched/sched_waking/trigger
+	# Available triggers:
+	# traceon traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
+
 6.1 Expression syntax
 ---------------------
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 032bdedca5d9..feced9f43156 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -592,11 +592,12 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
 
 LIST_HEAD(ftrace_trace_arrays);
 
-int trace_array_get(struct trace_array *this_tr)
+int __trace_array_get(struct trace_array *this_tr)
 {
 	struct trace_array *tr;
 
-	guard(mutex)(&trace_types_lock);
+	lockdep_assert_held(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (tr == this_tr) {
 			tr->ref++;
@@ -607,6 +608,12 @@ int trace_array_get(struct trace_array *this_tr)
 	return -ENODEV;
 }
 
+int trace_array_get(struct trace_array *tr)
+{
+	guard(mutex)(&trace_types_lock);
+	return __trace_array_get(tr);
+}
+
 static void __trace_array_put(struct trace_array *this_tr)
 {
 	WARN_ON(!this_tr->ref);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index fd5a6daa6c25..7379763a057d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -469,10 +469,14 @@ extern struct list_head ftrace_trace_arrays;
 extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
+extern int __trace_array_get(struct trace_array *tr);
 extern int tracing_check_open_get_tr(struct trace_array *tr);
 extern struct trace_array *trace_array_find(const char *instance);
 extern struct trace_array *trace_array_find_get(const char *instance);
 
+extern struct trace_subsystem_dir *trace_get_system_dir(struct inode *inode);
+void trace_put_system_dir(struct trace_subsystem_dir *dir);
+
 extern u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe);
 extern int tracing_set_filter_buffering(struct trace_array *tr, bool set);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
@@ -1774,6 +1778,7 @@ static inline struct trace_event_file *event_file_file(struct file *filp)
 }
 
 extern const struct file_operations event_trigger_fops;
+extern const struct file_operations event_system_trigger_fops;
 extern const struct file_operations event_hist_fops;
 extern const struct file_operations event_hist_debug_fops;
 extern const struct file_operations event_inject_fops;
@@ -2057,10 +2062,16 @@ struct event_command {
  *	regardless of whether or not it has a filter associated with
  *	it (filters make a trigger require access to the trace record
  *	but are not always present).
+ *
+ * @SYSTEM: A flag that says whether or not this command can be used
+ *	at the event system level. For example, can it be written into
+ *	events/sched/trigger file where it will be enabled for all
+ *	sched events?
  */
 enum event_command_flags {
-	EVENT_CMD_FL_POST_TRIGGER	= 1,
-	EVENT_CMD_FL_NEEDS_REC		= 2,
+	EVENT_CMD_FL_POST_TRIGGER	= BIT(1),
+	EVENT_CMD_FL_NEEDS_REC		= BIT(2),
+	EVENT_CMD_FL_SYSTEM		= BIT(3),
 };
 
 static inline bool event_command_post_trigger(struct event_command *cmd_ops)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9b07ad9eb284..f00b41f73fc2 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2168,51 +2168,52 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 static LIST_HEAD(event_subsystems);
 
-static int subsystem_open(struct inode *inode, struct file *filp)
+struct trace_subsystem_dir *trace_get_system_dir(struct inode *inode)
 {
-	struct trace_subsystem_dir *dir = NULL, *iter_dir;
-	struct trace_array *tr = NULL, *iter_tr;
-	struct event_subsystem *system = NULL;
-	int ret;
+	struct trace_subsystem_dir *dir;
+	struct trace_array *tr = NULL;
 
-	if (tracing_is_disabled())
-		return -ENODEV;
+	guard(mutex)(&event_mutex);
+	guard(mutex)(&trace_types_lock);
 
 	/* Make sure the system still exists */
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
-	list_for_each_entry(iter_tr, &ftrace_trace_arrays, list) {
-		list_for_each_entry(iter_dir, &iter_tr->systems, list) {
-			if (iter_dir == inode->i_private) {
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		list_for_each_entry(dir, &tr->systems, list) {
+			if (dir == inode->i_private) {
 				/* Don't open systems with no events */
-				tr = iter_tr;
-				dir = iter_dir;
-				if (dir->nr_events) {
-					__get_system_dir(dir);
-					system = dir->subsystem;
-				}
-				goto exit_loop;
+				if (!dir->nr_events)
+					return NULL;
+				if (__trace_array_get(tr) < 0)
+					return NULL;
+				__get_system_dir(dir);
+				return dir;
 			}
 		}
 	}
- exit_loop:
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
+	return NULL;
+}
 
-	if (!system)
+void trace_put_system_dir(struct trace_subsystem_dir *dir)
+{
+	trace_array_put(dir->tr);
+	put_system(dir);
+}
+
+static int subsystem_open(struct inode *inode, struct file *filp)
+{
+	struct trace_subsystem_dir *dir;
+	int ret;
+
+	if (tracing_is_disabled())
 		return -ENODEV;
 
-	/* Still need to increment the ref count of the system */
-	if (trace_array_get(tr) < 0) {
-		put_system(dir);
+	dir = trace_get_system_dir(inode);
+	if (!dir)
 		return -ENODEV;
-	}
 
 	ret = tracing_open_generic(inode, filp);
-	if (ret < 0) {
-		trace_array_put(tr);
-		put_system(dir);
-	}
+	if (ret < 0)
+		trace_put_system_dir(dir);
 
 	return ret;
 }
@@ -2761,6 +2762,9 @@ static int system_callback(const char *name, umode_t *mode, void **data,
 	else if (strcmp(name, "enable") == 0)
 		*fops = &ftrace_system_enable_fops;
 
+	else if (strcmp(name, "trigger") == 0)
+		*fops = &event_system_trigger_fops;
+
 	else
 		return 0;
 
@@ -2784,6 +2788,10 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		{
 			.name		= "enable",
 			.callback	= system_callback,
+		},
+		{
+			.name		= "trigger",
+			.callback	= system_callback,
 		}
 	};
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 1dfe69146a81..9249770679f3 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -329,21 +329,28 @@ int trigger_process_regex(struct trace_event_file *file, char *buff)
 	return -EINVAL;
 }
 
+static char *get_user_buf(const char __user *ubuf, size_t cnt)
+{
+	if (!cnt)
+		return NULL;
+
+	if (cnt >= PAGE_SIZE)
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user_nul(ubuf, cnt);
+}
+
 static ssize_t event_trigger_regex_write(struct file *file,
 					 const char __user *ubuf,
 					 size_t cnt, loff_t *ppos)
 {
 	struct trace_event_file *event_file;
 	ssize_t ret;
-	char *buf __free(kfree) = NULL;
+	char *buf __free(kfree) = get_user_buf(ubuf, cnt);
 
-	if (!cnt)
+	if (!buf)
 		return 0;
 
-	if (cnt >= PAGE_SIZE)
-		return -EINVAL;
-
-	buf = memdup_user_nul(ubuf, cnt);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -397,6 +404,184 @@ const struct file_operations event_trigger_fops = {
 	.release = event_trigger_release,
 };
 
+static ssize_t
+event_system_trigger_read(struct file *filp, char __user *ubuf,
+			  size_t count, loff_t *ppos)
+{
+	char *buf __free(kfree) = kmalloc(SZ_4K, GFP_KERNEL);
+	struct event_command *p;
+	struct seq_buf s;
+	int len;
+
+	if (!buf)
+		return -ENOMEM;
+
+	seq_buf_init(&s, buf, SZ_4K);
+
+	seq_buf_puts(&s, "# Available system triggers:\n");
+	seq_buf_putc(&s, '#');
+
+	guard(mutex)(&trigger_cmd_mutex);
+	list_for_each_entry_reverse(p, &trigger_commands, list) {
+		if (p->flags & EVENT_CMD_FL_SYSTEM)
+			seq_buf_printf(&s, " %s", p->name);
+	}
+	seq_buf_putc(&s, '\n');
+
+	len = seq_buf_used(&s);
+
+	if (*ppos >= len)
+		return 0;
+
+	len -= *ppos;
+
+	if (count > len)
+		count = len;
+
+	if (copy_to_user(ubuf, buf + *ppos, count))
+		return -EFAULT;
+
+	*ppos += count;
+
+	return count;
+}
+
+static int process_system_events(struct trace_subsystem_dir *dir,
+				 struct event_command *p, char *buff,
+				 char *command, char *next)
+{
+	struct event_subsystem *system = dir->subsystem;
+	struct trace_event_file *file;
+	struct trace_array *tr = dir->tr;
+	bool remove = false;
+	int ret = 0;
+
+	if (buff[0] == '!')
+		remove = true;
+
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(file, &tr->events, list) {
+
+		if (strcmp(system->name, file->event_call->class->system) != 0)
+			continue;
+
+		ret = p->parse(p, file, buff, command, next);
+
+		/* Removals and existing events do not error */
+		if (ret < 0 && ret != -EEXIST && !remove) {
+			pr_warn("Failed adding trigger %s on %s\n",
+				command, trace_event_name(file->event_call));
+		}
+	}
+	return 0;
+}
+
+static ssize_t
+event_system_trigger_write(struct file *filp, const char __user *ubuf,
+		    size_t cnt, loff_t *ppos)
+{
+	struct trace_subsystem_dir *dir = filp->private_data;
+	struct event_command *p;
+	char *command, *next;
+	char *buf __free(kfree) = get_user_buf(ubuf, cnt);
+	bool remove = false;
+	bool found = false;
+	ssize_t ret;
+
+	if (!buf)
+		return 0;
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	/* system triggers are not allowed to have counters */
+	if (strchr(buf, ':'))
+		return -EINVAL;
+
+	/* If opened for read too, dir is in the seq_file descriptor */
+	if (filp->f_mode & FMODE_READ) {
+		struct seq_file *m = filp->private_data;
+		dir = m->private;
+	}
+
+	/* Skip added space at beginning of buf */
+	next = strim(buf);
+
+	command = strsep(&next, " \t");
+	if (next) {
+		next = skip_spaces(next);
+		if (!*next)
+			next = NULL;
+	}
+	if (command[0] == '!') {
+		remove = true;
+		command++;
+	}
+
+	guard(mutex)(&event_mutex);
+	guard(mutex)(&trigger_cmd_mutex);
+
+	list_for_each_entry(p, &trigger_commands, list) {
+		/* Allow to remove any trigger */
+		if (!remove && !(p->flags & EVENT_CMD_FL_SYSTEM))
+			continue;
+		if (strcmp(p->name, command) == 0) {
+			found = true;
+			ret = process_system_events(dir, p, buf, command, next);
+			break;
+		}
+	}
+
+	if (!found)
+		ret = -ENODEV;
+
+	if (!ret)
+		*ppos += cnt;
+
+	if (remove || ret < 0)
+		return ret ? : cnt;
+
+	return cnt;
+}
+
+static int
+event_system_trigger_open(struct inode *inode, struct file *file)
+{
+	struct trace_subsystem_dir *dir;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	dir = trace_get_system_dir(inode);
+	if (!dir)
+		return -ENODEV;
+
+	file->private_data = dir;
+
+	return ret;
+}
+
+static int
+event_system_trigger_release(struct inode *inode, struct file *file)
+{
+	struct trace_subsystem_dir *dir = inode->i_private;
+
+	trace_put_system_dir(dir);
+
+	return 0;
+}
+
+const struct file_operations event_system_trigger_fops = {
+	.open = event_system_trigger_open,
+	.read = event_system_trigger_read,
+	.write = event_system_trigger_write,
+	.llseek = tracing_lseek,
+	.release = event_system_trigger_release,
+};
+
 /*
  * Currently we only register event commands from __init, so mark this
  * __init too.
@@ -1587,7 +1772,7 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 static struct event_command trigger_stacktrace_cmd = {
 	.name			= "stacktrace",
 	.trigger_type		= ETT_STACKTRACE,
-	.flags			= EVENT_CMD_FL_POST_TRIGGER,
+	.flags			= EVENT_CMD_FL_POST_TRIGGER | EVENT_CMD_FL_SYSTEM,
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-- 
2.51.0

