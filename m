Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF71BDAA2;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639184; cv=none; b=n1vdYtR4mjdaT6Q+13qnIvtNUwy64v/o7kA12U+/tEDvmvQrAc8uO4RUYBYdsss1/O0Mn1tm9sU5hy8Yhudi0KKLP1owKw4aP+RPgAExjnea+5CLw5QC3OTo0haff3etVflQ6k01MCRFNHAQ0OTRpNho+mypl1uwcuHNn0kkcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639184; c=relaxed/simple;
	bh=i3NQgVVh+RkdLkZXsVB2ZCoIeXbuseGt5L8kIZGKk4o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=axndWrbicfwK3KSMu+R/RF8DQkise+pu1FZuqQT538O7rJj0Q/7G/bLGGEFdhrIrYKuK7a0Z92M4RMlqbC6J0sj5tYulMlM0yd23ECkVgbISR+AkAhIuJHQYy2GXEX1IJhzEu8yRgD19NEgmzUc3jNE7YKc62WfozZGpwTaMQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47692C4CEEB;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu2-0000000AOKQ-02QG;
	Thu, 19 Dec 2024 15:13:46 -0500
Message-ID: <20241219201345.860391310@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 08/14] tracing: Switch trace_events_trigger.c code over to use guard()
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are a few functions in trace_events_trigger.c that have "goto out" or
equivalent on error in order to release locks that were taken. This can be
error prone or just simply make the code more complex.

Switch every location that ends with unlocking a mutex on error over to
using the guard(mutex)() infrastructure to let the compiler worry about
releasing locks. This makes the code easier to read and understand.

Also use __free() for free a temporary buffer in event_trigger_regex_write().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 69 ++++++++++-------------------
 1 file changed, 24 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index a5e3d6acf1e1..ac1583f8dcaf 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -211,12 +211,10 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 	if (ret)
 		return ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
-	if (unlikely(!event_file_file(file))) {
-		mutex_unlock(&event_mutex);
+	if (unlikely(!event_file_file(file)))
 		return -ENODEV;
-	}
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC)) {
@@ -239,8 +237,6 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 		}
 	}
 
-	mutex_unlock(&event_mutex);
-
 	return ret;
 }
 
@@ -248,7 +244,6 @@ int trigger_process_regex(struct trace_event_file *file, char *buff)
 {
 	char *command, *next;
 	struct event_command *p;
-	int ret = -EINVAL;
 
 	next = buff = skip_spaces(buff);
 	command = strsep(&next, ": \t");
@@ -259,17 +254,14 @@ int trigger_process_regex(struct trace_event_file *file, char *buff)
 	}
 	command = (command[0] != '!') ? command : command + 1;
 
-	mutex_lock(&trigger_cmd_mutex);
+	guard(mutex)(&trigger_cmd_mutex);
+
 	list_for_each_entry(p, &trigger_commands, list) {
-		if (strcmp(p->name, command) == 0) {
-			ret = p->parse(p, file, buff, command, next);
-			goto out_unlock;
-		}
+		if (strcmp(p->name, command) == 0)
+			return p->parse(p, file, buff, command, next);
 	}
- out_unlock:
-	mutex_unlock(&trigger_cmd_mutex);
 
-	return ret;
+	return -EINVAL;
 }
 
 static ssize_t event_trigger_regex_write(struct file *file,
@@ -278,7 +270,7 @@ static ssize_t event_trigger_regex_write(struct file *file,
 {
 	struct trace_event_file *event_file;
 	ssize_t ret;
-	char *buf;
+	char *buf __free(kfree) = NULL;
 
 	if (!cnt)
 		return 0;
@@ -288,28 +280,22 @@ static ssize_t event_trigger_regex_write(struct file *file,
 
 	buf = memdup_user_nul(ubuf, cnt);
 	if (IS_ERR(buf))
-		return PTR_ERR(buf);
+		return PTR_ERR(no_free_ptr(buf));
 
 	strim(buf);
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
+
 	event_file = event_file_file(file);
-	if (unlikely(!event_file)) {
-		mutex_unlock(&event_mutex);
-		kfree(buf);
+	if (unlikely(!event_file))
 		return -ENODEV;
-	}
-	ret = trigger_process_regex(event_file, buf);
-	mutex_unlock(&event_mutex);
 
-	kfree(buf);
+	ret = trigger_process_regex(event_file, buf);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	*ppos += cnt;
-	ret = cnt;
- out:
-	return ret;
+	return cnt;
 }
 
 static int event_trigger_regex_release(struct inode *inode, struct file *file)
@@ -359,20 +345,16 @@ const struct file_operations event_trigger_fops = {
 __init int register_event_command(struct event_command *cmd)
 {
 	struct event_command *p;
-	int ret = 0;
 
-	mutex_lock(&trigger_cmd_mutex);
+	guard(mutex)(&trigger_cmd_mutex);
+
 	list_for_each_entry(p, &trigger_commands, list) {
-		if (strcmp(cmd->name, p->name) == 0) {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
+		if (strcmp(cmd->name, p->name) == 0)
+			return -EBUSY;
 	}
 	list_add(&cmd->list, &trigger_commands);
- out_unlock:
-	mutex_unlock(&trigger_cmd_mutex);
 
-	return ret;
+	return 0;
 }
 
 /*
@@ -382,20 +364,17 @@ __init int register_event_command(struct event_command *cmd)
 __init int unregister_event_command(struct event_command *cmd)
 {
 	struct event_command *p, *n;
-	int ret = -ENODEV;
 
-	mutex_lock(&trigger_cmd_mutex);
+	guard(mutex)(&trigger_cmd_mutex);
+
 	list_for_each_entry_safe(p, n, &trigger_commands, list) {
 		if (strcmp(cmd->name, p->name) == 0) {
-			ret = 0;
 			list_del_init(&p->list);
-			goto out_unlock;
+			return 0;
 		}
 	}
- out_unlock:
-	mutex_unlock(&trigger_cmd_mutex);
 
-	return ret;
+	return -ENODEV;
 }
 
 /**
-- 
2.45.2


