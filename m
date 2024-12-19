Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252951BD9C2;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639184; cv=none; b=hxZOE4B7pj4TsAJLOHtoECPQ167aJZpkh8wEucNtzEpZdyYCDOKiSfHsNMoye1jn7MECIQTyhu8PQN7X00cR55oJWYf8xLRw4+6pMR6xDXhreyO5b6hhUVZCyuJRuCpx6ir0xKGj5bjLPT9RwE8Atuzo8ukgvm8BRZPHvAaDwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639184; c=relaxed/simple;
	bh=P0pjYChQ/bTt4XMa0/8tq9sE8LWSl7We6OrB8wffB3o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=U+PT/VD2tdezdsME5liAnPwiRRIxq301DhUCP9EdzhzG0oVpDd1Ab8un7qCOhWn7ArMgwiPvrmW057FdxN27YJNPF9BQojQPvQiNcikWP/RviDcpyD5ke8yFqPAm4jfuHunPXIklweaq0caZbWafsStUKNnoiiaFQqpOx1I1nNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDA9C4CED7;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu1-0000000AOJQ-2p6F;
	Thu, 19 Dec 2024 15:13:45 -0500
Message-ID: <20241219201345.522546095@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/14] tracing: Switch trace_events.c code over to use guard()
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are several functions in trace_events.c that have "goto out;" or
equivalent on error in order to release locks that were taken. This can be
error prone or just simply make the code more complex.

Switch every location that ends with unlocking a mutex on error over to
using the guard(mutex)() infrastructure to let the compiler worry about
releasing locks. This makes the code easier to read and understand.

Some locations did some simple arithmetic after releasing the lock. As
this causes no real overhead for holding a mutex while processing the file
position (*ppos += cnt;) let the lock be held over this logic too.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 103 +++++++++++++-----------------------
 1 file changed, 38 insertions(+), 65 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 86db6ee6f26c..047d2775184b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1546,19 +1546,18 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&event_mutex);
+
 	switch (val) {
 	case 0:
 	case 1:
-		mutex_lock(&event_mutex);
 		file = event_file_file(filp);
-		if (likely(file)) {
-			ret = tracing_update_buffers(file->tr);
-			if (ret >= 0)
-				ret = ftrace_event_enable_disable(file, val);
-		} else {
-			ret = -ENODEV;
-		}
-		mutex_unlock(&event_mutex);
+		if (!file)
+			return -ENODEV;
+		ret = tracing_update_buffers(file->tr);
+		if (ret < 0)
+			return ret;
+		ret = ftrace_event_enable_disable(file, val);
 		if (ret < 0)
 			return ret;
 		break;
@@ -2145,7 +2144,7 @@ event_pid_write(struct file *filp, const char __user *ubuf,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	if (type == TRACE_PIDS) {
 		filtered_pids = rcu_dereference_protected(tr->filtered_pids,
@@ -2161,7 +2160,7 @@ event_pid_write(struct file *filp, const char __user *ubuf,
 
 	ret = trace_pid_write(filtered_pids, &pid_list, ubuf, cnt);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (type == TRACE_PIDS)
 		rcu_assign_pointer(tr->filtered_pids, pid_list);
@@ -2186,11 +2185,7 @@ event_pid_write(struct file *filp, const char __user *ubuf,
 	 */
 	on_each_cpu(ignore_task_cpu, tr, 1);
 
- out:
-	mutex_unlock(&event_mutex);
-
-	if (ret > 0)
-		*ppos += ret;
+	*ppos += ret;
 
 	return ret;
 }
@@ -3257,13 +3252,13 @@ int trace_add_event_call(struct trace_event_call *call)
 	int ret;
 	lockdep_assert_held(&event_mutex);
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	ret = __register_event(call, NULL);
-	if (ret >= 0)
-		__add_event_to_tracers(call);
+	if (ret < 0)
+		return ret;
 
-	mutex_unlock(&trace_types_lock);
+	__add_event_to_tracers(call);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(trace_add_event_call);
@@ -3517,30 +3512,21 @@ struct trace_event_file *trace_get_event_file(const char *instance,
 			return ERR_PTR(ret);
 	}
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	file = find_event_file(tr, system, event);
 	if (!file) {
 		trace_array_put(tr);
-		ret = -EINVAL;
-		goto out;
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* Don't let event modules unload while in use */
 	ret = trace_event_try_get_ref(file->event_call);
 	if (!ret) {
 		trace_array_put(tr);
-		ret = -EBUSY;
-		goto out;
+		return ERR_PTR(-EBUSY);
 	}
 
-	ret = 0;
- out:
-	mutex_unlock(&event_mutex);
-
-	if (ret)
-		file = ERR_PTR(ret);
-
 	return file;
 }
 EXPORT_SYMBOL_GPL(trace_get_event_file);
@@ -3778,12 +3764,11 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 
 	event = strsep(&param, ":");
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
-	ret = -EINVAL;
 	file = find_event_file(tr, system, event);
 	if (!file)
-		goto out;
+		return -EINVAL;
 
 	enable = strcmp(cmd, ENABLE_EVENT_STR) == 0;
 
@@ -3792,19 +3777,14 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 	else
 		ops = param ? &event_disable_count_probe_ops : &event_disable_probe_ops;
 
-	if (glob[0] == '!') {
-		ret = unregister_ftrace_function_probe_func(glob+1, tr, ops);
-		goto out;
-	}
-
-	ret = -ENOMEM;
+	if (glob[0] == '!')
+		return unregister_ftrace_function_probe_func(glob+1, tr, ops);
 
 	if (param) {
 		number = strsep(&param, ":");
 
-		ret = -EINVAL;
 		if (!strlen(number))
-			goto out;
+			return -EINVAL;
 
 		/*
 		 * We use the callback data field (which is a pointer)
@@ -3812,20 +3792,19 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 		 */
 		ret = kstrtoul(number, 0, &count);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/* Don't let event modules unload while probe registered */
 	ret = trace_event_try_get_ref(file->event_call);
-	if (!ret) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (!ret)
+		return -EBUSY;
 
 	ret = __ftrace_event_enable_disable(file, 1, 1);
 	if (ret < 0)
 		goto out_put;
 
+	ret = -ENOMEM;
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		goto out_put;
@@ -3840,23 +3819,20 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 	 * but if it didn't find any functions it returns zero.
 	 * Consider no functions a failure too.
 	 */
-	if (!ret) {
-		ret = -ENOENT;
-		goto out_disable;
-	} else if (ret < 0)
-		goto out_disable;
+
 	/* Just return zero, not the number of enabled functions */
-	ret = 0;
- out:
-	mutex_unlock(&event_mutex);
-	return ret;
+	if (ret > 0)
+		return 0;
 
- out_disable:
 	kfree(data);
+
+	if (!ret)
+		ret = -ENOENT;
+
 	__ftrace_event_enable_disable(file, 0, 1);
  out_put:
 	trace_event_put_ref(file->event_call);
-	goto out;
+	return ret;
 }
 
 static struct ftrace_func_command event_enable_cmd = {
@@ -4079,20 +4055,17 @@ early_event_add_tracer(struct dentry *parent, struct trace_array *tr)
 {
 	int ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	ret = create_event_toplevel_files(parent, tr);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	down_write(&trace_event_sem);
 	__trace_early_add_event_dirs(tr);
 	up_write(&trace_event_sem);
 
- out_unlock:
-	mutex_unlock(&event_mutex);
-
-	return ret;
+	return 0;
 }
 
 /* Must be called with event_mutex held */
-- 
2.45.2


