Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BC42A80;
	Sun, 30 Aug 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088336; cv=none; b=Q8cnM2sYyI7V7kWS+y1DGWRj0903CxBC4Jfy083RIgCA6cxy8JWHBX+KJO9lHm2KobWXSrFafBzlPFGukZQcHy+SFZdQxtHfkj0YYPtIS2QFCjhUWkCA14Jp45sU07ONIIQBB9Uj2zyfbymcA6ib9FUZAeJe6XygmMdHjgMEnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088336; c=relaxed/simple;
	bh=mq1hqMy4vpni/e+58gq8O1q05NIcUds4jVHovVJWQUg=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=B553p6Iw8attuawjmQtvv2tfh5SZWkEo2tTJQOC4OXPiTTtT6p4VeP8Endf6Zi7hXAeGKl4/Njp1PyatZ6roLX8mFlQQBTigd+NCmI2cytC25k2m3UN5AaKTm8j4QUWoRRjzMpw+TZB8guRvwfisPrrJZiI0QdkF8A3JFupzbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hXqG40X2dz8Xrnt;
	Sun, 30 Aug 2026 19:12:12 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 67UBC24Q003845;
	Sun, 30 Aug 2026 19:12:02 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 30 Aug 2026 19:12:03 +0800 (CST)
X-Zmail-TransId: 2af96a941003781-e07fa
X-Mailer: Zmail v1.0
Message-ID: <20260830191203740Bw7THNERUcr5pSC4VdvzO@zte.com.cn>
In-Reply-To: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
References: 20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn
Date: Sun, 30 Aug 2026 19:12:03 +0800 (CST)
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
Subject: =?UTF-8?B?W1JGQyBQQVRDSCAzLzRdIGZ0cmFjZTogQWRkIGV4YWN0IHRhc2sgY29tbSBmaWx0ZXJpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 67UBC24Q003845
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 30 Aug 2026 19:12:12 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A94100C.000/4hXqG40X2dz8Xrnt

From: Shengming Hu <hu.shengming@zte.com.cn>

PID filters only select tasks that already have a known PID. This makes
it difficult to set up function tracing for a service before it starts
or to keep tracing it after it restarts with a different PID.

Add set_ftrace_comm and set_ftrace_notrace_comm to filter function and
function_graph tracing by task comm.

Comm filters share the existing sched_switch probe and per-CPU cached
task decision with PID filters. The filters are checked when a task is
scheduled in, so the function tracing fast path remains unchanged.

Comm names are matched exactly. Each write adds one name to the list.
A trailing newline is ignored, while embedded newlines and names longer
than TASK_COMM_LEN - 1 are rejected. Empty writes have no effect,
duplicate names are ignored, and opening the file with O_TRUNC clears
the list.

When both PID and comm include filters are set, a task must match both.
A match in either exclude filter prevents the task from being traced.
If a running task changes its comm, the new name takes effect the next
time the task is scheduled in.

Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/Makefile    |   1 +
 kernel/trace/comm_list.c | 314 ++++++++++++++++++++++++++++++++++++
 kernel/trace/comm_list.h |  17 ++
 kernel/trace/ftrace.c    | 336 ++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.c     |   5 +
 kernel/trace/trace.h     |  32 ++++
 6 files changed, 701 insertions(+), 4 deletions(-)
 create mode 100644 kernel/trace/comm_list.c
 create mode 100644 kernel/trace/comm_list.h

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f934ff586bd4..415cd9db9c3e 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING) += trace_pid.o
 obj-$(CONFIG_TRACER_SNAPSHOT) += trace_snapshot.o
 obj-$(CONFIG_TRACING) += 	pid_list.o
+obj-$(CONFIG_TRACING) +=    comm_list.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_SYNTH_EVENT_GEN_TEST) += synth_event_gen_test.o
diff --git a/kernel/trace/comm_list.c b/kernel/trace/comm_list.c
new file mode 100644
index 000000000000..c94c53d7d70c
--- /dev/null
+++ b/kernel/trace/comm_list.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 ZTE Inc, Shengming Hu <hu.shengming@zte.com.cn>
+ */
+
+#include <linux/limits.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "trace.h"
+#include "comm_list.h"
+
+#define COMM_LIST_INIT_SIZE	4
+
+static int comm_cmp(const char a[TASK_COMM_LEN],
+		    const char b[TASK_COMM_LEN])
+{
+	return memcmp(a, b, TASK_COMM_LEN);
+}
+
+/*
+ * Return true if @comm exists. @pos is either the matching position or the
+ * insertion position that keeps the array sorted.
+ */
+static bool trace_comm_list_find(struct trace_comm_list *comm_list,
+				 const char comm[TASK_COMM_LEN],
+				 unsigned int *pos)
+{
+	unsigned int low = 0;
+	unsigned int high;
+
+	if (!comm_list) {
+		*pos = 0;
+		return false;
+	}
+
+	high = comm_list->nr_comms;
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+		int cmp = comm_cmp(comm_list->comms[mid], comm);
+
+		if (cmp < 0)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	*pos = low;
+	return low < comm_list->nr_comms &&
+	       !comm_cmp(comm_list->comms[low], comm);
+}
+
+/**
+ * trace_comm_list_alloc - create a new comm_list
+ *
+ * Allocates a new comm_list to store comms into.
+ *
+ * Returns the comm_list on success, NULL otherwise.
+ */
+struct trace_comm_list *trace_comm_list_alloc(void)
+{
+	return kzalloc(sizeof(struct trace_comm_list), GFP_KERNEL);
+}
+
+/**
+ * trace_comm_list_free - Frees an allocated comm_list.
+ * @comm_list: The comm list to free.
+ *
+ * Frees the memory for a comm_list that was allocated.
+ */
+void trace_comm_list_free(struct trace_comm_list *comm_list)
+{
+	if (!comm_list)
+		return;
+
+	kfree(comm_list->comms);
+	kfree(comm_list);
+}
+
+/**
+ * trace_comm_list_is_set - test if the comm is set in the list
+ * @comm_list: The comm list to test
+ * @comm: The comm to see if set in the list.
+ *
+ * Tests if @comm is set in the @comm_list.
+ *
+ * Return true if the comm is in the list, false otherwise.
+ */
+bool trace_comm_list_is_set(struct trace_comm_list *comm_list,
+			    const char comm[TASK_COMM_LEN])
+{
+	unsigned int pos;
+
+	return trace_comm_list_find(comm_list, comm, &pos);
+}
+
+static int trace_comm_list_grow(struct trace_comm_list *comm_list)
+{
+	char (*comms)[TASK_COMM_LEN];
+	unsigned int max_comms;
+
+	if (comm_list->nr_comms < comm_list->max_comms)
+		return 0;
+
+	if (!comm_list->max_comms) {
+		max_comms = COMM_LIST_INIT_SIZE;
+	} else {
+		if (comm_list->max_comms > UINT_MAX / 2)
+			return -E2BIG;
+		max_comms = comm_list->max_comms * 2;
+	}
+
+	comms = krealloc_array(comm_list->comms, max_comms,
+			       sizeof(*comm_list->comms), GFP_KERNEL);
+	if (!comms)
+		return -ENOMEM;
+
+	comm_list->comms = comms;
+	comm_list->max_comms = max_comms;
+	return 0;
+}
+
+/**
+ * trace_comm_list_set - add a comm to the list
+ * @comm_list: The comm list to add the @comm to.
+ * @comm: The comm to add.
+ *
+ * Adds @comm to @comm_list. The comms are kept sorted and duplicate
+ * entries are ignored.
+ *
+ * Return 0 on success, negative otherwise.
+ */
+int trace_comm_list_set(struct trace_comm_list *comm_list,
+			const char comm[TASK_COMM_LEN])
+{
+	unsigned int pos;
+	int ret;
+
+	if (!comm_list)
+		return -ENODEV;
+
+	if (trace_comm_list_find(comm_list, comm, &pos))
+		return 0;
+
+	ret = trace_comm_list_grow(comm_list);
+	if (ret)
+		return ret;
+
+	if (pos < comm_list->nr_comms)
+		memmove(&comm_list->comms[pos + 1], &comm_list->comms[pos],
+			(comm_list->nr_comms - pos) * sizeof(*comm_list->comms));
+
+	memcpy(comm_list->comms[pos], comm, TASK_COMM_LEN);
+	comm_list->nr_comms++;
+
+	return 0;
+}
+
+/**
+ * trace_ignore_comm_task - should a task be ignored by comm filters
+ * @filtered_comms: The list of comms to trace
+ * @filtered_no_comms: The list of comms not to be traced
+ * @task: The task to test against the comm filters
+ *
+ * Checks whether @task should be ignored by the comm include/exclude
+ * filters.
+ *
+ * Returns true if @task should not be traced, false otherwise.
+ */
+bool trace_ignore_comm_task(struct trace_comm_list *filtered_comms,
+			    struct trace_comm_list *filtered_no_comms,
+			    struct task_struct *task)
+{
+	char comm[TASK_COMM_LEN];
+
+	get_task_comm(comm, task);
+
+	return (filtered_comms &&
+		!trace_comm_list_is_set(filtered_comms, comm)) ||
+	       (filtered_no_comms &&
+		trace_comm_list_is_set(filtered_no_comms, comm));
+}
+
+/**
+ * trace_comm_start - start iterating over a comm list
+ * @comm_list: The comm list to show
+ * @pos: The position of the file
+ *
+ * Returns the comm at @pos, or NULL if there are no more comms.
+ */
+void *trace_comm_start(struct trace_comm_list *comm_list, loff_t *pos)
+{
+	if (!comm_list || *pos < 0 || *pos >= (loff_t)comm_list->nr_comms)
+		return NULL;
+
+	return comm_list->comms[*pos];
+}
+
+/**
+ * trace_comm_next - return the next comm in the list
+ * @comm_list: The comm list to show
+ * @v: The current comm
+ * @pos: The position of the file
+ *
+ * Returns the next comm in @comm_list, or NULL if there are no more comms.
+ */
+void *trace_comm_next(struct trace_comm_list *comm_list, void *v, loff_t *pos)
+{
+	(void)v;
+
+	(*pos)++;
+	return trace_comm_start(comm_list, pos);
+}
+
+/**
+ * trace_comm_show - show the current comm
+ * @m: The seq_file structure to write into
+ * @v: The comm to display
+ *
+ * Displays the current comm in the seq_file.
+ */
+int trace_comm_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s\n", (char *)v);
+	return 0;
+}
+
+static int trace_comm_from_user(char comm[TASK_COMM_LEN],
+				const char __user *ubuf, size_t cnt)
+{
+	char buf[TASK_COMM_LEN];
+	size_t len = cnt;
+
+	if (cnt > sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, cnt))
+		return -EFAULT;
+
+	if (len && buf[len - 1] == '\n')
+		len--;
+
+	if (!len) {
+		comm[0] = '\0';
+		return 0;
+	}
+
+	if (len >= TASK_COMM_LEN || memchr(buf, '\0', len) ||
+	    memchr(buf, '\n', len))
+		return -EINVAL;
+
+	memset(comm, 0, TASK_COMM_LEN);
+	memcpy(comm, buf, len);
+
+	return 1;
+}
+
+/**
+ * trace_comm_write - add a comm to a comm list
+ * @filtered_comms: The current comm list
+ * @new_comm_list: The pointer to place the new comm list
+ * @ubuf: The user buffer containing the comm
+ * @cnt: The size of the user buffer
+ *
+ * Creates a new comm list containing the current comms and the comm
+ * specified by the user.
+ *
+ * Return the number of bytes written on success, negative otherwise.
+ */
+int trace_comm_write(struct trace_comm_list *filtered_comms,
+		     struct trace_comm_list **new_comm_list,
+		     const char __user *ubuf, size_t cnt)
+{
+	struct trace_comm_list *comm_list;
+	char comm[TASK_COMM_LEN];
+	unsigned int i;
+	int parsed;
+	int ret;
+
+	parsed = trace_comm_from_user(comm, ubuf, cnt);
+	if (parsed < 0)
+		return parsed;
+
+	if (!parsed || trace_comm_list_is_set(filtered_comms, comm)) {
+		*new_comm_list = filtered_comms;
+		return cnt;
+	}
+
+	comm_list = trace_comm_list_alloc();
+	if (!comm_list)
+		return -ENOMEM;
+
+	if (filtered_comms) {
+		for (i = 0; i < filtered_comms->nr_comms; i++) {
+			ret = trace_comm_list_set(comm_list,
+						  filtered_comms->comms[i]);
+			if (ret < 0)
+				goto fail;
+		}
+	}
+
+	ret = trace_comm_list_set(comm_list, comm);
+	if (ret < 0)
+		goto fail;
+
+	*new_comm_list = comm_list;
+	return cnt;
+
+fail:
+	trace_comm_list_free(comm_list);
+	return ret;
+}
diff --git a/kernel/trace/comm_list.h b/kernel/trace/comm_list.h
new file mode 100644
index 000000000000..1f2a6b329ed3
--- /dev/null
+++ b/kernel/trace/comm_list.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Do not include this file directly. */
+
+#ifndef _TRACE_INTERNAL_COMM_LIST_H
+#define _TRACE_INTERNAL_COMM_LIST_H
+
+#include <linux/sched.h>
+
+struct trace_comm_list {
+	unsigned int nr_comms;
+	unsigned int max_comms;
+	char (*comms)[TASK_COMM_LEN];
+};
+
+#endif /* _TRACE_INTERNAL_COMM_LIST_H */
+
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0c73abb8fec8..e2a466448a9b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -108,7 +108,10 @@ bool ftrace_task_filters_enabled(struct ftrace_ops *ops)

 	tr = ops->private;

-	return tr->function_pids != NULL || tr->function_no_pids != NULL;
+	return rcu_access_pointer(tr->function_pids) ||
+		rcu_access_pointer(tr->function_no_pids) ||
+		rcu_access_pointer(tr->function_comms) ||
+		rcu_access_pointer(tr->function_no_comms);
 }

 static void ftrace_update_trampoline(struct ftrace_ops *ops);
@@ -168,7 +171,7 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }

-/* Call this function for when a callback filters on set_ftrace_pid */
+/* Call this function for when a callback uses task filters */
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
@@ -8642,11 +8645,32 @@ static bool ftrace_task_filters_active(struct trace_array *tr)
 	return rcu_dereference_protected(tr->function_pids,
 					 lockdep_is_held(&ftrace_lock)) ||
 		rcu_dereference_protected(tr->function_no_pids,
+					  lockdep_is_held(&ftrace_lock)) ||
+		rcu_dereference_protected(tr->function_comms,
+					  lockdep_is_held(&ftrace_lock)) ||
+		rcu_dereference_protected(tr->function_no_comms,
 					  lockdep_is_held(&ftrace_lock));
 }

 static void ignore_task_cpu(void *data);

+static bool __ftrace_ignore_task(struct trace_pid_list *pid_list,
+				 struct trace_pid_list *no_pid_list,
+				 struct trace_comm_list *comm_filter,
+				 struct trace_comm_list *no_comm_filter,
+				 struct task_struct *task)
+{
+	if ((pid_list || no_pid_list) &&
+	    trace_ignore_pid_task(pid_list, no_pid_list, task))
+		return true;
+
+	if ((comm_filter || no_comm_filter) &&
+	    trace_ignore_comm_task(comm_filter, no_comm_filter, task))
+		return true;
+
+	return false;
+}
+
 static void
 ftrace_filter_task_sched_switch_probe(void *data, bool preempt,
 				     struct task_struct *prev,
@@ -8656,11 +8680,15 @@ ftrace_filter_task_sched_switch_probe(void *data, bool preempt,
 	struct trace_array *tr = data;
 	struct trace_pid_list *pid_list;
 	struct trace_pid_list *no_pid_list;
+	struct trace_comm_list *comm_filter;
+	struct trace_comm_list *no_comm_filter;

 	pid_list = rcu_dereference_sched(tr->function_pids);
 	no_pid_list = rcu_dereference_sched(tr->function_no_pids);

-	if (trace_ignore_pid_task(pid_list, no_pid_list, next))
+	comm_filter = rcu_dereference_sched(tr->function_comms);
+	no_comm_filter = rcu_dereference_sched(tr->function_no_comms);
+	if (__ftrace_ignore_task(pid_list, no_pid_list, comm_filter, no_comm_filter, next))
 		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
 			       FTRACE_PID_IGNORE);
 	else
@@ -8788,6 +8816,54 @@ static void ftrace_pid_reset(struct trace_array *tr, int type)
 	mutex_unlock(&ftrace_lock);
 }

+static void clear_ftrace_comms(struct trace_array *tr, int type)
+{
+	struct trace_comm_list *comm_filter;
+	struct trace_comm_list *no_comm_filter;
+	bool task_filters_enabled;
+
+	comm_filter = rcu_dereference_protected(tr->function_comms,
+						lockdep_is_held(&ftrace_lock));
+	no_comm_filter = rcu_dereference_protected(tr->function_no_comms,
+						   lockdep_is_held(&ftrace_lock));
+
+	if (!comm_type_enabled(type, comm_filter, no_comm_filter))
+		return;
+
+	task_filters_enabled = ftrace_task_filters_active(tr);
+
+	if (type & TRACE_COMMS)
+		rcu_assign_pointer(tr->function_comms, NULL);
+
+	if (type & TRACE_NO_COMMS)
+		rcu_assign_pointer(tr->function_no_comms, NULL);
+
+	ftrace_task_filters_changed(tr, task_filters_enabled);
+	synchronize_rcu();
+
+	if ((type & TRACE_COMMS) && comm_filter)
+		trace_comm_list_free(comm_filter);
+
+	if ((type & TRACE_NO_COMMS) && no_comm_filter)
+		trace_comm_list_free(no_comm_filter);
+}
+
+void ftrace_clear_comms(struct trace_array *tr)
+{
+	mutex_lock(&ftrace_lock);
+	clear_ftrace_comms(tr, TRACE_COMMS | TRACE_NO_COMMS);
+	mutex_unlock(&ftrace_lock);
+}
+
+static void ftrace_comm_reset(struct trace_array *tr, int type)
+{
+	mutex_lock(&ftrace_lock);
+	clear_ftrace_comms(tr, type);
+	ftrace_update_pid_func();
+	ftrace_startup_all(0);
+	mutex_unlock(&ftrace_lock);
+}
+
 /* Greater than any max PID */
 #define FTRACE_NO_PIDS		(void *)(PID_MAX_LIMIT + 1)

@@ -8880,6 +8956,102 @@ static const struct seq_operations ftrace_no_pid_sops = {
 	.show = fpid_show,
 };

+/* Not a valid comm pointer */
+#define FTRACE_NO_COMM		((void *)1)
+
+static void *fcomm_start(struct seq_file *m, loff_t *pos)
+	__acquires(RCU)
+{
+	struct trace_comm_list *comm_list;
+	struct trace_array *tr = m->private;
+
+	mutex_lock(&ftrace_lock);
+	rcu_read_lock_sched();
+
+	comm_list = rcu_dereference_sched(tr->function_comms);
+
+	if (!comm_list)
+		return !(*pos) ? FTRACE_NO_COMM : NULL;
+
+	return trace_comm_start(comm_list, pos);
+}
+
+static void *fcomm_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct trace_array *tr = m->private;
+	struct trace_comm_list *comm_list;
+
+	if (v == FTRACE_NO_COMM) {
+		(*pos)++;
+		return NULL;
+	}
+
+	comm_list = rcu_dereference_sched(tr->function_comms);
+	return trace_comm_next(comm_list, v, pos);
+}
+
+static void fcomm_stop(struct seq_file *m, void *p)
+	__releases(RCU)
+{
+	rcu_read_unlock_sched();
+	mutex_unlock(&ftrace_lock);
+}
+
+static int fcomm_show(struct seq_file *m, void *v)
+{
+	if (v == FTRACE_NO_COMM) {
+		seq_puts(m, "no comm\n");
+		return 0;
+	}
+
+	return trace_comm_show(m, v);
+}
+
+static const struct seq_operations ftrace_comm_sops = {
+	.start	= fcomm_start,
+	.next	= fcomm_next,
+	.stop	= fcomm_stop,
+	.show	= fcomm_show,
+};
+
+static void *fncomm_start(struct seq_file *m, loff_t *pos)
+	__acquires(RCU)
+{
+	struct trace_comm_list *comm_list;
+	struct trace_array *tr = m->private;
+
+	mutex_lock(&ftrace_lock);
+	rcu_read_lock_sched();
+
+	comm_list = rcu_dereference_sched(tr->function_no_comms);
+
+	if (!comm_list)
+		return !(*pos) ? FTRACE_NO_COMM : NULL;
+
+	return trace_comm_start(comm_list, pos);
+}
+
+static void *fncomm_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct trace_array *tr = m->private;
+	struct trace_comm_list *comm_list;
+
+	if (v == FTRACE_NO_COMM) {
+		(*pos)++;
+		return NULL;
+	}
+
+	comm_list = rcu_dereference_sched(tr->function_no_comms);
+	return trace_comm_next(comm_list, v, pos);
+}
+
+static const struct seq_operations ftrace_no_comm_sops = {
+	.start	= fncomm_start,
+	.next	= fncomm_next,
+	.stop	= fcomm_stop,
+	.show	= fcomm_show,
+};
+
 static int pid_open(struct inode *inode, struct file *file, int type)
 {
 	const struct seq_operations *seq_ops;
@@ -8932,11 +9104,62 @@ ftrace_no_pid_open(struct inode *inode, struct file *file)
 	return pid_open(inode, file, TRACE_NO_PIDS);
 }

+static int comm_open(struct inode *inode, struct file *file, int type)
+{
+	const struct seq_operations *seq_ops;
+	struct trace_array *tr = inode->i_private;
+	struct seq_file *m;
+	int ret = 0;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	if ((file->f_mode & FMODE_WRITE) &&
+	    (file->f_flags & O_TRUNC))
+		ftrace_comm_reset(tr, type);
+
+	switch (type) {
+	case TRACE_COMMS:
+		seq_ops = &ftrace_comm_sops;
+		break;
+	case TRACE_NO_COMMS:
+		seq_ops = &ftrace_no_comm_sops;
+		break;
+	default:
+		trace_array_put(tr);
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	ret = seq_open(file, seq_ops);
+	if (ret < 0) {
+		trace_array_put(tr);
+	} else {
+		m = file->private_data;
+		m->private = tr;
+	}
+
+	return ret;
+}
+
+static int ftrace_comm_open(struct inode *inode, struct file *file)
+{
+	return comm_open(inode, file, TRACE_COMMS);
+}
+
+static int ftrace_no_comm_open(struct inode *inode, struct file *file)
+{
+	return comm_open(inode, file, TRACE_NO_COMMS);
+}
+
 static void ignore_task_cpu(void *data)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *pid_list;
 	struct trace_pid_list *no_pid_list;
+	struct trace_comm_list *comm_filter;
+	struct trace_comm_list *no_comm_filter;

 	/*
 	 * This function is called by on_each_cpu() while the
@@ -8947,7 +9170,12 @@ static void ignore_task_cpu(void *data)
 	no_pid_list = rcu_dereference_protected(tr->function_no_pids,
 						mutex_is_locked(&ftrace_lock));

-	if (trace_ignore_pid_task(pid_list, no_pid_list, current))
+	comm_filter = rcu_dereference_protected(tr->function_comms,
+						mutex_is_locked(&ftrace_lock));
+	no_comm_filter = rcu_dereference_protected(tr->function_no_comms,
+						   mutex_is_locked(&ftrace_lock));
+
+	if (__ftrace_ignore_task(pid_list, no_pid_list, comm_filter, no_comm_filter, current))
 		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
 			       FTRACE_PID_IGNORE);
 	else
@@ -9022,6 +9250,86 @@ ftrace_pid_write(struct file *filp, const char __user *ubuf,
 	return pid_write(filp, ubuf, cnt, ppos, TRACE_PIDS);
 }

+static ssize_t comm_write(struct file *filp, const char __user *ubuf,
+			  size_t cnt, loff_t *ppos, int type)
+{
+	struct seq_file *m = filp->private_data;
+	struct trace_array *tr = m->private;
+	struct trace_comm_list *filtered_comms;
+	struct trace_comm_list *comm_list;
+	bool task_filters_enabled;
+	ssize_t ret;
+
+	if (!cnt)
+		return 0;
+
+	guard(mutex)(&ftrace_lock);
+	task_filters_enabled = ftrace_task_filters_active(tr);
+
+	switch (type) {
+	case TRACE_COMMS:
+		filtered_comms = rcu_dereference_protected(tr->function_comms,
+						      lockdep_is_held(&ftrace_lock));
+		break;
+	case TRACE_NO_COMMS:
+		filtered_comms = rcu_dereference_protected(tr->function_no_comms,
+						      lockdep_is_held(&ftrace_lock));
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	ret = trace_comm_write(filtered_comms, &comm_list, ubuf, cnt);
+	if (ret < 0)
+		return ret;
+
+	if (comm_list == filtered_comms) {
+		*ppos += ret;
+		return ret;
+	}
+
+	if (type == TRACE_COMMS)
+		rcu_assign_pointer(tr->function_comms, comm_list);
+	else
+		rcu_assign_pointer(tr->function_no_comms, comm_list);
+
+	if (filtered_comms) {
+		synchronize_rcu();
+		trace_comm_list_free(filtered_comms);
+	}
+
+	ftrace_task_filters_changed(tr, task_filters_enabled);
+	ftrace_update_pid_func();
+	ftrace_startup_all(0);
+
+	*ppos += ret;
+	return ret;
+}
+
+static ssize_t ftrace_comm_write(struct file *filp, const char __user *ubuf,
+				 size_t cnt, loff_t *ppos)
+{
+	return comm_write(filp, ubuf, cnt, ppos, TRACE_COMMS);
+}
+
+static ssize_t ftrace_no_comm_write(struct file *filp,
+				    const char __user *ubuf,
+				    size_t cnt, loff_t *ppos)
+{
+	return comm_write(filp, ubuf, cnt, ppos, TRACE_NO_COMMS);
+}
+
+static int
+ftrace_comm_release(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+
+	trace_array_put(tr);
+
+	return seq_release(inode, file);
+}
+
 static ssize_t
 ftrace_no_pid_write(struct file *filp, const char __user *ubuf,
 		    size_t cnt, loff_t *ppos)
@@ -9055,12 +9363,32 @@ static const struct file_operations ftrace_no_pid_fops = {
 	.release	= ftrace_pid_release,
 };

+static const struct file_operations ftrace_comm_fops = {
+	.open		= ftrace_comm_open,
+	.write		= ftrace_comm_write,
+	.read		= seq_read,
+	.llseek		= tracing_lseek,
+	.release	= ftrace_comm_release,
+};
+
+static const struct file_operations ftrace_no_comm_fops = {
+	.open		= ftrace_no_comm_open,
+	.write		= ftrace_no_comm_write,
+	.read		= seq_read,
+	.llseek		= tracing_lseek,
+	.release	= ftrace_comm_release,
+};
+
 void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
 	trace_create_file("set_ftrace_pid", TRACE_MODE_WRITE, d_tracer,
 			    tr, &ftrace_pid_fops);
 	trace_create_file("set_ftrace_notrace_pid", TRACE_MODE_WRITE,
 			  d_tracer, tr, &ftrace_no_pid_fops);
+	trace_create_file("set_ftrace_comm", TRACE_MODE_WRITE, d_tracer,
+			  tr, &ftrace_comm_fops);
+	trace_create_file("set_ftrace_notrace_comm", TRACE_MODE_WRITE,
+			  d_tracer, tr, &ftrace_no_comm_fops);
 }

 void __init ftrace_init_tracefs_toplevel(struct trace_array *tr,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3e0907aef172..8cbfaed24810 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4261,6 +4261,10 @@ static const char readme_msg[] =
 	"\t\t    (function)\n"
 	"  set_ftrace_notrace_pid\t- Write pid(s) to not function trace those pids\n"
 	"\t\t    (function)\n"
+	"  set_ftrace_comm\t- Write task comms to only function trace those tasks\n"
+	"\t\t    (function)\n"
+	"  set_ftrace_notrace_comm\t- Write task comms to not function trace those tasks\n"
+	"\t\t    (function)\n"
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	"  set_graph_function\t- Trace the nested calls of a function (function_graph)\n"
@@ -8789,6 +8793,7 @@ static int __remove_instance(struct trace_array *tr)
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
 	ftrace_clear_pids(tr);
+	ftrace_clear_comms(tr);
 	ftrace_destroy_function_files(tr);
 	tracefs_remove(tr->dir);
 	free_percpu(tr->last_func_repeats);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f73913eed307..218bd26dc73a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -182,6 +182,7 @@ struct fexit_trace_entry_head {
 #define TRACE_BUF_SIZE		1024

 struct trace_array;
+struct trace_comm_list;

 /*
  * The CPU trace array - it consists of thousands of trace entries
@@ -237,12 +238,32 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid);
 int trace_pid_list_first(struct trace_pid_list *pid_list, unsigned int *pid);
 int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
 			unsigned int *next);
+struct trace_comm_list *trace_comm_list_alloc(void);
+void trace_comm_list_free(struct trace_comm_list *comm_list);
+bool trace_comm_list_is_set(struct trace_comm_list *comm_list,
+			    const char comm[TASK_COMM_LEN]);
+int trace_comm_list_set(struct trace_comm_list *comm_list,
+			const char comm[TASK_COMM_LEN]);
+bool trace_ignore_comm_task(struct trace_comm_list *filtered_comms,
+			    struct trace_comm_list *filtered_no_comms,
+			    struct task_struct *task);
+void *trace_comm_next(struct trace_comm_list *comm_list, void *v, loff_t *pos);
+void *trace_comm_start(struct trace_comm_list *comm_list, loff_t *pos);
+int trace_comm_show(struct seq_file *m, void *v);
+int trace_comm_write(struct trace_comm_list *filtered_comms,
+		     struct trace_comm_list **new_comm_list,
+		     const char __user *ubuf, size_t cnt);

 enum {
 	TRACE_PIDS		= BIT(0),
 	TRACE_NO_PIDS		= BIT(1),
 };

+enum {
+	TRACE_COMMS = BIT(0),
+	TRACE_NO_COMMS = BIT(1),
+};
+
 static inline bool pid_type_enabled(int type, struct trace_pid_list *pid_list,
 				    struct trace_pid_list *no_pid_list)
 {
@@ -251,6 +272,13 @@ static inline bool pid_type_enabled(int type, struct trace_pid_list *pid_list,
 		((type & TRACE_NO_PIDS) && no_pid_list);
 }

+static inline bool comm_type_enabled(int type, struct trace_comm_list *comm_list,
+			     struct trace_comm_list *no_comm_list)
+{
+	return ((type & TRACE_COMMS) && comm_list) ||
+		((type & TRACE_NO_COMMS) && no_comm_list);
+}
+
 static inline bool still_need_pid_events(int type, struct trace_pid_list *pid_list,
 					 struct trace_pid_list *no_pid_list)
 {
@@ -434,6 +462,8 @@ struct trace_array {
 	struct ftrace_ops	*ops;
 	struct trace_pid_list	__rcu *function_pids;
 	struct trace_pid_list	__rcu *function_no_pids;
+	struct trace_comm_list	__rcu *function_comms;
+	struct trace_comm_list	__rcu *function_no_comms;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	struct fgraph_ops	*gops;
 #endif
@@ -1267,6 +1297,7 @@ void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 void ftrace_init_tracefs_toplevel(struct trace_array *tr,
 				  struct dentry *d_tracer);
 void ftrace_clear_pids(struct trace_array *tr);
+void ftrace_clear_comms(struct trace_array *tr);
 int init_function_trace(void);
 void ftrace_pid_follow_fork(struct trace_array *tr, bool enable);
 #else
@@ -1289,6 +1320,7 @@ static inline void ftrace_reset_array_ops(struct trace_array *tr) { }
 static inline void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d) { }
 static inline void ftrace_init_tracefs_toplevel(struct trace_array *tr, struct dentry *d) { }
 static inline void ftrace_clear_pids(struct trace_array *tr) { }
+static inline void ftrace_clear_comms(struct trace_array *tr) { }
 static inline int init_function_trace(void) { return 0; }
 static inline void ftrace_pid_follow_fork(struct trace_array *tr, bool enable) { }
 /* ftace_func_t type is not defined, use macro instead of static inline */
-- 
2.25.1
