Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3EC1C3BE4;
	Mon, 23 Dec 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979730; cv=none; b=aTLz1+Uziul0MX/6mFHW7yeBmrSMBsZuIQ2AC/PKnDkeZd4s6uWcIdYBqTZwi/5Hha3xiaRd5/ufLlMDAchmVm0TZiFcdYearPP17o8iwwEk2Fk7ct/1PDWSole6SUrOHII4o7um3M/AqoSpN8MlYaIigT5TcBIh0Hjd/9TMdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979730; c=relaxed/simple;
	bh=P9L4tLMSuzxiMz49e8tAq+/2m8DzE2Lk7uR6qWpeI88=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TasMdWjEWJL0XXqiz0Dvl8a2pGwshEJAo+tmxm6QqNfGib6/s1KHooUowFK05yedEJ509amkl7umRRKbcV7lhItSLywdpXZpVFtoczQWC4hgv9BOesk7pQzEc9KkgxC3sShs1QieLc0OiaqaIjxXeG8pJmar0KBGTbzT5LuIEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB26C4CEE2;
	Mon, 23 Dec 2024 18:48:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tPnUr-0000000Dcnm-3eis;
	Mon, 23 Dec 2024 13:49:41 -0500
Message-ID: <20241223184941.718001540@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 23 Dec 2024 13:46:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] ftrace: Switch ftrace.c code over to use guard()
References: <20241223184618.176607694@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are a few functions in ftrace.c that have "goto out" or equivalent
on error in order to release locks that were taken. This can be error
prone or just simply make the code more complex.

Switch every location that ends with unlocking a mutex on error over to
using the guard(mutex)() infrastructure to let the compiler worry about
releasing locks. This makes the code easier to read and understand.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 97 +++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 63 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2c1691aa1d2f..6ebc76bafd38 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -536,24 +536,21 @@ static int function_stat_show(struct seq_file *m, void *v)
 {
 	struct ftrace_profile *rec = v;
 	char str[KSYM_SYMBOL_LEN];
-	int ret = 0;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	static struct trace_seq s;
 	unsigned long long avg;
 	unsigned long long stddev;
 #endif
-	mutex_lock(&ftrace_profile_lock);
+	guard(mutex)(&ftrace_profile_lock);
 
 	/* we raced with function_profile_reset() */
-	if (unlikely(rec->counter == 0)) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (unlikely(rec->counter == 0))
+		return -EBUSY;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	avg = div64_ul(rec->time, rec->counter);
 	if (tracing_thresh && (avg < tracing_thresh))
-		goto out;
+		return 0;
 #endif
 
 	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
@@ -590,10 +587,8 @@ static int function_stat_show(struct seq_file *m, void *v)
 	trace_print_seq(m, &s);
 #endif
 	seq_putc(m, '\n');
-out:
-	mutex_unlock(&ftrace_profile_lock);
 
-	return ret;
+	return 0;
 }
 
 static void ftrace_profile_reset(struct ftrace_profile_stat *stat)
@@ -944,20 +939,16 @@ ftrace_profile_write(struct file *filp, const char __user *ubuf,
 
 	val = !!val;
 
-	mutex_lock(&ftrace_profile_lock);
+	guard(mutex)(&ftrace_profile_lock);
 	if (ftrace_profile_enabled ^ val) {
 		if (val) {
 			ret = ftrace_profile_init();
-			if (ret < 0) {
-				cnt = ret;
-				goto out;
-			}
+			if (ret < 0)
+				return ret;
 
 			ret = register_ftrace_profiler();
-			if (ret < 0) {
-				cnt = ret;
-				goto out;
-			}
+			if (ret < 0)
+				return ret;
 			ftrace_profile_enabled = 1;
 		} else {
 			ftrace_profile_enabled = 0;
@@ -968,8 +959,6 @@ ftrace_profile_write(struct file *filp, const char __user *ubuf,
 			unregister_ftrace_profiler();
 		}
 	}
- out:
-	mutex_unlock(&ftrace_profile_lock);
 
 	*ppos += cnt;
 
@@ -5610,20 +5599,15 @@ static DEFINE_MUTEX(ftrace_cmd_mutex);
 __init int register_ftrace_command(struct ftrace_func_command *cmd)
 {
 	struct ftrace_func_command *p;
-	int ret = 0;
 
-	mutex_lock(&ftrace_cmd_mutex);
+	guard(mutex)(&ftrace_cmd_mutex);
 	list_for_each_entry(p, &ftrace_commands, list) {
-		if (strcmp(cmd->name, p->name) == 0) {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
+		if (strcmp(cmd->name, p->name) == 0)
+			return -EBUSY;
 	}
 	list_add(&cmd->list, &ftrace_commands);
- out_unlock:
-	mutex_unlock(&ftrace_cmd_mutex);
 
-	return ret;
+	return 0;
 }
 
 /*
@@ -5633,20 +5617,17 @@ __init int register_ftrace_command(struct ftrace_func_command *cmd)
 __init int unregister_ftrace_command(struct ftrace_func_command *cmd)
 {
 	struct ftrace_func_command *p, *n;
-	int ret = -ENODEV;
 
-	mutex_lock(&ftrace_cmd_mutex);
+	guard(mutex)(&ftrace_cmd_mutex);
+
 	list_for_each_entry_safe(p, n, &ftrace_commands, list) {
 		if (strcmp(cmd->name, p->name) == 0) {
-			ret = 0;
 			list_del_init(&p->list);
-			goto out_unlock;
+			return 0;
 		}
 	}
- out_unlock:
-	mutex_unlock(&ftrace_cmd_mutex);
 
-	return ret;
+	return -ENODEV;
 }
 
 static int ftrace_process_regex(struct ftrace_iterator *iter,
@@ -5656,7 +5637,7 @@ static int ftrace_process_regex(struct ftrace_iterator *iter,
 	struct trace_array *tr = iter->ops->private;
 	char *func, *command, *next = buff;
 	struct ftrace_func_command *p;
-	int ret = -EINVAL;
+	int ret;
 
 	func = strsep(&next, ":");
 
@@ -5673,17 +5654,14 @@ static int ftrace_process_regex(struct ftrace_iterator *iter,
 
 	command = strsep(&next, ":");
 
-	mutex_lock(&ftrace_cmd_mutex);
+	guard(mutex)(&ftrace_cmd_mutex);
+
 	list_for_each_entry(p, &ftrace_commands, list) {
-		if (strcmp(p->name, command) == 0) {
-			ret = p->func(tr, hash, func, command, next, enable);
-			goto out_unlock;
-		}
+		if (strcmp(p->name, command) == 0)
+			return p->func(tr, hash, func, command, next, enable);
 	}
- out_unlock:
-	mutex_unlock(&ftrace_cmd_mutex);
 
-	return ret;
+	return -EINVAL;
 }
 
 static ssize_t
@@ -8280,7 +8258,7 @@ pid_write(struct file *filp, const char __user *ubuf,
 	if (!cnt)
 		return 0;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	switch (type) {
 	case TRACE_PIDS:
@@ -8296,14 +8274,13 @@ pid_write(struct file *filp, const char __user *ubuf,
 					     lockdep_is_held(&ftrace_lock));
 		break;
 	default:
-		ret = -EINVAL;
 		WARN_ON_ONCE(1);
-		goto out;
+		return -EINVAL;
 	}
 
 	ret = trace_pid_write(filtered_pids, &pid_list, ubuf, cnt);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	switch (type) {
 	case TRACE_PIDS:
@@ -8332,11 +8309,8 @@ pid_write(struct file *filp, const char __user *ubuf,
 
 	ftrace_update_pid_func();
 	ftrace_startup_all(0);
- out:
-	mutex_unlock(&ftrace_lock);
 
-	if (ret > 0)
-		*ppos += ret;
+	*ppos += ret;
 
 	return ret;
 }
@@ -8739,17 +8713,17 @@ static int
 ftrace_enable_sysctl(const struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int ret = -ENODEV;
+	int ret;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	if (unlikely(ftrace_disabled))
-		goto out;
+		return -ENODEV;
 
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 
 	if (ret || !write || (last_ftrace_enabled == !!ftrace_enabled))
-		goto out;
+		return ret;
 
 	if (ftrace_enabled) {
 
@@ -8763,8 +8737,7 @@ ftrace_enable_sysctl(const struct ctl_table *table, int write,
 	} else {
 		if (is_permanent_ops_registered()) {
 			ftrace_enabled = true;
-			ret = -EBUSY;
-			goto out;
+			return -EBUSY;
 		}
 
 		/* stopping ftrace calls (just send to ftrace_stub) */
@@ -8774,9 +8747,7 @@ ftrace_enable_sysctl(const struct ctl_table *table, int write,
 	}
 
 	last_ftrace_enabled = !!ftrace_enabled;
- out:
-	mutex_unlock(&ftrace_lock);
-	return ret;
+	return 0;
 }
 
 static struct ctl_table ftrace_sysctls[] = {
-- 
2.45.2


