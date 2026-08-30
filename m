Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982C3ACEEA;
	Sun, 30 Aug 2026 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088239; cv=none; b=lU5yMC+YSFuTqxsH3bBeFbRVyQJCnegPSvF0vQNZiV05Wq0Yjb305Zg3a6Cn4vhGyZfqsr8hW2Mcyb8nVdrwG0gYp0fl/LHVypjjT7xPSvsZxqUcAiJTz75jP/V14ZbISnphIghNC05kIc7bx+ymk9XjTS+aXf/OQoQlYaRF2hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088239; c=relaxed/simple;
	bh=1QlMXC2PALYXXt54bHFQlta4IRwKDT+rCT8w1CSUzPI=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=D8sZn9NMbCVfDBYh+z95K4r+OMd81Yw+QlG2vfzxPhUCr9Tw/OYvE1Ux8ejdUlEe3N/YB/Dx2eJKezOWAQZjnNXVca0Z4PkdO6+K7kriOBfPwt4Ht9V8kFTQZfs9x0rycp4sbP2RrqQdCuk1B/NHLcLU0MpBmuwlk3lsGrdFgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hXqD92Jfqz5BNRf;
	Sun, 30 Aug 2026 19:10:33 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 67UBARCT014401;
	Sun, 30 Aug 2026 19:10:27 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 30 Aug 2026 19:10:29 +0800 (CST)
X-Zmail-TransId: 2afc6a940fa5773-d27fa
X-Mailer: Zmail v1.0
Message-ID: <20260830191029780ubpoH6QdASK9mvsfhLTcA@zte.com.cn>
In-Reply-To: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
References: 20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn
Date: Sun, 30 Aug 2026 19:10:29 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <hu.shengming@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mark.rutland@arm.com>,
        <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: =?UTF-8?B?4oCLW1JGQyBQQVRDSCAyLzRdIGZ0cmFjZTogQ2VudHJhbGl6ZSB0YXNrIGZpbHRlciBzdGF0ZSB1cGRhdGVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 67UBARCT014401
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 30 Aug 2026 19:10:33 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A940FA9.000/4hXqD92Jfqz5BNRf

From: Shengming Hu <hu.shengming@zte.com.cn>

A later change will add task comm filtering alongside the existing PID
filters. Both filters need to share the sched_switch probe and the
per-CPU cached task decision.

Move the probe registration and cache refresh logic into
ftrace_task_filters_changed(). This gives PID and future task filters
a single place to update the shared state when a filter changes.

The helper also refreshes the cached result for currently running tasks
when one PID filter is cleared while the other remains active, instead
of leaving the result unchanged until the next schedule-in.

Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/ftrace.c | 58 +++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 479ea004adc3..0c73abb8fec8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8637,6 +8637,16 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 	return ops->func;
 }

+static bool ftrace_task_filters_active(struct trace_array *tr)
+{
+	return rcu_dereference_protected(tr->function_pids,
+					 lockdep_is_held(&ftrace_lock)) ||
+		rcu_dereference_protected(tr->function_no_pids,
+					  lockdep_is_held(&ftrace_lock));
+}
+
+static void ignore_task_cpu(void *data);
+
 static void
 ftrace_filter_task_sched_switch_probe(void *data, bool preempt,
 				     struct task_struct *prev,
@@ -8703,11 +8713,31 @@ void ftrace_pid_follow_fork(struct trace_array *tr, bool enable)
 	}
 }

+static void ftrace_task_filters_changed(struct trace_array *tr,
+					bool was_enabled)
+{
+	bool enabled = ftrace_task_filters_active(tr);
+	int cpu;
+
+	if (!was_enabled && enabled)
+		register_trace_sched_switch(ftrace_filter_task_sched_switch_probe, tr);
+	else if (was_enabled && !enabled) {
+		unregister_trace_sched_switch(ftrace_filter_task_sched_switch_probe, tr);
+		for_each_possible_cpu(cpu)
+			per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid =
+				FTRACE_PID_TRACE;
+		return;
+	}
+
+	if (enabled)
+		on_each_cpu(ignore_task_cpu, tr, 1);
+}
+
 static void clear_ftrace_pids(struct trace_array *tr, int type)
 {
 	struct trace_pid_list *pid_list;
 	struct trace_pid_list *no_pid_list;
-	int cpu;
+	bool task_filters_enabled;

 	pid_list = rcu_dereference_protected(tr->function_pids,
 					     lockdep_is_held(&ftrace_lock));
@@ -8718,12 +8748,7 @@ static void clear_ftrace_pids(struct trace_array *tr, int type)
 	if (!pid_type_enabled(type, pid_list, no_pid_list))
 		return;

-	/* See if the pids still need to be checked after this */
-	if (!still_need_pid_events(type, pid_list, no_pid_list)) {
-		unregister_trace_sched_switch(ftrace_filter_task_sched_switch_probe, tr);
-		for_each_possible_cpu(cpu)
-			per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid = FTRACE_PID_TRACE;
-	}
+	task_filters_enabled = ftrace_task_filters_active(tr);

 	if (type & TRACE_PIDS)
 		rcu_assign_pointer(tr->function_pids, NULL);
@@ -8731,6 +8756,8 @@ static void clear_ftrace_pids(struct trace_array *tr, int type)
 	if (type & TRACE_NO_PIDS)
 		rcu_assign_pointer(tr->function_no_pids, NULL);

+	ftrace_task_filters_changed(tr, task_filters_enabled);
+
 	/* Wait till all users are no longer using pid filtering */
 	synchronize_rcu();

@@ -8935,27 +8962,24 @@ pid_write(struct file *filp, const char __user *ubuf,
 	struct seq_file *m = filp->private_data;
 	struct trace_array *tr = m->private;
 	struct trace_pid_list *filtered_pids;
-	struct trace_pid_list *other_pids;
 	struct trace_pid_list *pid_list;
+	bool task_filters_enabled;
 	ssize_t ret;

 	if (!cnt)
 		return 0;

 	guard(mutex)(&ftrace_lock);
+	task_filters_enabled = ftrace_task_filters_active(tr);

 	switch (type) {
 	case TRACE_PIDS:
 		filtered_pids = rcu_dereference_protected(tr->function_pids,
 					     lockdep_is_held(&ftrace_lock));
-		other_pids = rcu_dereference_protected(tr->function_no_pids,
-					     lockdep_is_held(&ftrace_lock));
 		break;
 	case TRACE_NO_PIDS:
 		filtered_pids = rcu_dereference_protected(tr->function_no_pids,
 					     lockdep_is_held(&ftrace_lock));
-		other_pids = rcu_dereference_protected(tr->function_pids,
-					     lockdep_is_held(&ftrace_lock));
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -8979,17 +9003,9 @@ pid_write(struct file *filp, const char __user *ubuf,
 	if (filtered_pids) {
 		synchronize_rcu();
 		trace_pid_list_free(filtered_pids);
-	} else if (pid_list && !other_pids) {
-		/* Register a probe to set whether to ignore the tracing of a task */
-		register_trace_sched_switch(ftrace_filter_task_sched_switch_probe, tr);
 	}

-	/*
-	 * Ignoring of pids is done at task switch. But we have to
-	 * check for those tasks that are currently running.
-	 * Always do this in case a pid was appended or removed.
-	 */
-	on_each_cpu(ignore_task_cpu, tr, 1);
+	ftrace_task_filters_changed(tr, task_filters_enabled);

 	ftrace_update_pid_func();
 	ftrace_startup_all(0);
-- 
2.25.1
