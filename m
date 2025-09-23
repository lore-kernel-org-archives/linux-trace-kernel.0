Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5458324B07;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632754; cv=none; b=GcK9jMkeHZbU83gI4d1H9Rj+cHzwYDC/GCLsuZboNyKMRLBxkzUFy2XJY7u6XeGeV2mOTB1slLgi8aaMOnx5GdfuxHunu5BW8yZyw6NqRlIpMVnuGJ8SFiT0J86dY6ouZtZuW/cYJREowNtXh2S1lBa7293CUDaLj7YAbdLcAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632754; c=relaxed/simple;
	bh=rNBSgUDsBKlfStPzbudHOSIzVkIjyxeB/28FHnmxYo4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hYu3JUjE8r3bxbewCSN/MOcqjCaq5Ys4xx4tywA1jKr4p0/H2EVpgBiGD01YvPKwTdYZoKKVEfXJgvuym+tcfIDPyaw/I7T5gMYQzBu4v3UsQ743NIn0EvW3UKjTk9PIzezW57UF4NwMnWHKVXnUrOh63zaNY6Nj7ZKJufxg2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKdi6BsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKdi6BsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F6DC113CF;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632754;
	bh=rNBSgUDsBKlfStPzbudHOSIzVkIjyxeB/28FHnmxYo4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=nKdi6BsCD9o7XGxlnjQVQseh0qU3/BHYSh9i6IRoKNmWA5+hxomHR0ZWWVVhHBeGq
	 U67mnBsjS1guhGTVswHiyfsSKVyCWlMj7MfmShM6oLBtvTlPoQ95n+vtSqAOh9e4Aq
	 kJ30UMQaTWa0nYv0KAP1mbNTNcwelvi8+V+YhBkbBDVpDX/tGHJConI6yC0YWkCQes
	 iTh++o/5EKn0tB5wAKSOSyLSNU7WSL118NPkIXKSAr9+JLlGNJsL6di4RMVZthojrk
	 hWBt74PKDKaAZO0E37RCPUoPlti1vNk05I7bPP4LgxE7vkr0ctOYqHQ1B/HVQLduQE
	 iW54KLIM+56og==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v12ji-0000000Coq9-0Kt2;
	Tue, 23 Sep 2025 09:07:14 -0400
Message-ID: <20250923130713.936188500@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 23 Sep 2025 09:05:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH v2 3/8] tracing: Have syscall trace events read user space string
References: <20250923130457.901085554@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

As of commit 654ced4a1377 ("tracing: Introduce tracepoint_is_faultable()")
system call trace events allow faulting in user space memory. Have some of
the system call trace events take advantage of this.

Introduce a way to read strings that are nul terminated into the trace
event. The way this is accomplished is by creating a per CPU temporary
buffer that is used to read unsafe user memory.

When a syscall trace event needs to read user memory, it reads the per CPU
schedule switch counter. It then disables migration and enables
preemption, copies the user space memory into this buffer, then disables
preemption again. It reads the per CPU schedule switch counter again and
if it matches it considers the buffer is valid.  Otherwise it needs to try
again. This is similar to how seqcount works, but uses the per CPU context
switch counter as the sequence counter.

The reason it uses the sched switch counter and not just a per CPU counter
is because that wouldn't catch the case of:

  [task 1]
  cnt = this_cpu_inc(counter);
  preempt_enable()
  <sched switch to task 2>

  [task 2]
  cnt = this_cpu_inc(counter);
  preempt_enable();
  buffer = task 2 data
  <sched switch to task 1>

  [task 1]
  buffer = task 1 data
  <sched switch to task 2>

  [task 2]
  preempt_disable();
  if (cnt == this_cpu_read(counter))

Will return true even though the buffer was corrupted.

The syscall event has its nb_args shorten from an int to a short (where
even u8 is plenty big enough) and the freed two bytes are used for
"user_mask".  The new "user_mask" field is used to store the index of the
"args" field array that has the address to read from user space. This
value is set to 0 if the system call event does not need to read user
space for a field. This mask can be used to know if the event may fault or
not. Only one bit set in user_mask is supported at this time.

This allows the output to look like this:

 sys_access(filename: 0x7f8c55368470 "/etc/ld.so.preload", mode: 4)
 sys_execve(filename: 0x564ebcf5a6b8 "/usr/bin/emacs", argv: 0x7fff357c0300, envp: 0x564ebc4a4820)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250805193235.080757106@kernel.org

- Hide newsfstat around
  #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
  as parisc failed to build without it. (kernel test robot)

- Fixed allocation of sinfo which used sizeof(sinfo) and not
  sizeof(*sinfo) (kernel test robot)

- Instead of incrementing a counter via the sched_switch tracepoint, use
  the nr_context_switches() API. (Mathieu Desnoyers).

- Use the length saved in the meta data of the event to limit the size of
  the string printed "%.*s", len, str.

- Add comment describing that the method to read the memory from user
  space is similar to how seqcount works.

 include/trace/syscall.h       |   4 +-
 kernel/trace/trace_syscalls.c | 480 ++++++++++++++++++++++++++++++++--
 2 files changed, 464 insertions(+), 20 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 8e193f3a33b3..85f21ca15a41 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -16,6 +16,7 @@
  * @name: name of the syscall
  * @syscall_nr: number of the syscall
  * @nb_args: number of parameters it takes
+ * @user_mask: mask of @args that will read user space
  * @types: list of types as strings
  * @args: list of args as strings (args[i] matches types[i])
  * @enter_fields: list of fields for syscall_enter trace event
@@ -25,7 +26,8 @@
 struct syscall_metadata {
 	const char	*name;
 	int		syscall_nr;
-	int		nb_args;
+	short		nb_args;
+	short		user_mask;
 	const char	**types;
 	const char	**args;
 	struct list_head enter_fields;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 0f932b22f9ec..7ea763c07bb7 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <trace/syscall.h>
 #include <trace/events/syscalls.h>
+#include <linux/kernel_stat.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -123,6 +124,9 @@ const char *get_syscall_name(int syscall)
 	return entry->name;
 }
 
+/* Added to user strings when max limit is reached */
+#define EXTRA "..."
+
 static enum print_line_t
 print_syscall_enter(struct trace_iterator *iter, int flags,
 		    struct trace_event *event)
@@ -132,7 +136,9 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	struct trace_entry *ent = iter->ent;
 	struct syscall_trace_enter *trace;
 	struct syscall_metadata *entry;
-	int i, syscall;
+	int i, syscall, val;
+	unsigned char *ptr;
+	int len;
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
@@ -167,6 +173,19 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		else
 			trace_seq_printf(s, "%s: 0x%lx", entry->args[i],
 					 trace->args[i]);
+
+		if (!(BIT(i) & entry->user_mask))
+			continue;
+
+		/* This arg points to a user space string */
+		ptr = (void *)trace->args + sizeof(long) * entry->nb_args;
+		val = *(int *)ptr;
+
+		/* The value is a dynamic string (len << 16 | offset) */
+		ptr = (void *)ent + (val & 0xffff);
+		len = val >> 16;
+
+		trace_seq_printf(s, " \"%.*s\"", len, ptr);
 	}
 
 	trace_seq_putc(s, ')');
@@ -223,15 +242,27 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 	for (i = 0; i < entry->nb_args; i++) {
-		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s: 0x%%0%zulx%s",
-				entry->args[i], sizeof(unsigned long),
-				i == entry->nb_args - 1 ? "" : ", ");
+		if (i)
+			pos += snprintf(buf + pos, LEN_OR_ZERO, ", ");
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s: 0x%%0%zulx",
+				entry->args[i], sizeof(unsigned long));
+
+		if (!(BIT(i) & entry->user_mask))
+			continue;
+
+		/* Add the format for the user space string */
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
 	}
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
 	for (i = 0; i < entry->nb_args; i++) {
 		pos += snprintf(buf + pos, LEN_OR_ZERO,
 				", ((unsigned long)(REC->%s))", entry->args[i]);
+		if (!(BIT(i) & entry->user_mask))
+			continue;
+		/* The user space string for arg has name __<arg>_val */
+		pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
+				entry->args[i]);
 	}
 
 #undef LEN_OR_ZERO
@@ -277,8 +308,12 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 {
 	struct syscall_trace_enter trace;
 	struct syscall_metadata *meta = call->data;
+	unsigned long mask;
+	char *arg;
 	int offset = offsetof(typeof(trace), args);
+	int idx;
 	int ret = 0;
+	int len;
 	int i;
 
 	for (i = 0; i < meta->nb_args; i++) {
@@ -291,9 +326,232 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 		offset += sizeof(unsigned long);
 	}
 
+	if (ret || !meta->user_mask)
+		return ret;
+
+	mask = meta->user_mask;
+	idx = ffs(mask) - 1;
+
+	/*
+	 * User space strings are faulted into a temporary buffer and then
+	 * added as a dynamic string to the end of the event.
+	 * The user space string name for the arg pointer is "__<arg>_val".
+	 */
+	len = strlen(meta->args[idx]) + sizeof("___val");
+	arg = kmalloc(len, GFP_KERNEL);
+	if (WARN_ON_ONCE(!arg)) {
+		meta->user_mask = 0;
+		return -ENOMEM;
+	}
+
+	snprintf(arg, len, "__%s_val", meta->args[idx]);
+
+	ret = trace_define_field(call, "__data_loc char[]",
+				 arg, offset, sizeof(int), 0,
+				 FILTER_OTHER);
+	if (ret)
+		kfree(arg);
 	return ret;
 }
 
+struct syscall_buf {
+	char		*buf;
+};
+
+struct syscall_buf_info {
+	struct rcu_head			rcu;
+	struct syscall_buf __percpu	*sbuf;
+};
+
+/* Create a per CPU temporary buffer to copy user space pointers into */
+#define SYSCALL_FAULT_BUF_SZ 512
+static struct syscall_buf_info *syscall_buffer;
+
+static int syscall_fault_buffer_cnt;
+
+static void syscall_fault_buffer_free(struct syscall_buf_info *sinfo)
+{
+	char *buf;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		buf = per_cpu_ptr(sinfo->sbuf, cpu)->buf;
+		kfree(buf);
+	}
+	kfree(sinfo);
+}
+
+static void rcu_free_syscall_buffer(struct rcu_head *rcu)
+{
+	struct syscall_buf_info *sinfo = container_of(rcu, struct syscall_buf_info, rcu);
+
+	syscall_fault_buffer_free(sinfo);
+}
+
+/*
+ * The per CPU buffer syscall_fault_buffer is written to optimstically.
+ * The per CPU context switch count is taken, preemption is enabled,
+ * the copying of the user space memory is placed into the syscall_fault_buffer,
+ * Preeption is re-enabled and the count is read again. If the count does
+ * not match its previous reading, it could mean that another user space
+ * task scheduled in and the buffer is unreliable for use.
+ */
+static int syscall_fault_buffer_enable(void)
+{
+	struct syscall_buf_info *sinfo;
+	char *buf;
+	int cpu;
+
+	lockdep_assert_held(&syscall_trace_lock);
+
+	if (syscall_fault_buffer_cnt++)
+		return 0;
+
+	sinfo = kmalloc(sizeof(*sinfo), GFP_KERNEL);
+	if (!sinfo)
+		return -ENOMEM;
+
+	sinfo->sbuf = alloc_percpu(struct syscall_buf);
+	if (!sinfo->sbuf) {
+		kfree(sinfo);
+		return -ENOMEM;
+	}
+
+	/* Clear each buffer in case of error */
+	for_each_possible_cpu(cpu) {
+		per_cpu_ptr(sinfo->sbuf, cpu)->buf = NULL;
+	}
+
+	for_each_possible_cpu(cpu) {
+		buf = kmalloc_node(SYSCALL_FAULT_BUF_SZ, GFP_KERNEL,
+				   cpu_to_node(cpu));
+		if (!buf) {
+			syscall_fault_buffer_free(sinfo);
+			return -ENOMEM;
+		}
+		per_cpu_ptr(sinfo->sbuf, cpu)->buf = buf;
+	}
+
+	WRITE_ONCE(syscall_buffer, sinfo);
+	return 0;
+}
+
+static void syscall_fault_buffer_disable(void)
+{
+	struct syscall_buf_info *sinfo = syscall_buffer;
+
+	lockdep_assert_held(&syscall_trace_lock);
+
+	if (--syscall_fault_buffer_cnt)
+		return;
+
+	WRITE_ONCE(syscall_buffer, NULL);
+	call_rcu_tasks_trace(&sinfo->rcu, rcu_free_syscall_buffer);
+}
+
+static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_buf_info *sinfo,
+			    unsigned long *args, unsigned int *data_size)
+{
+	int cpu = smp_processor_id();
+	char *buf = per_cpu_ptr(sinfo->sbuf, cpu)->buf;
+	unsigned long size = SYSCALL_FAULT_BUF_SZ - 1;
+	unsigned long mask = sys_data->user_mask;
+	unsigned int cnt;
+	int idx = ffs(mask) - 1;
+	char *ptr;
+	int trys = 0;
+	int ret;
+
+	/* Get the pointer to user space memory to read */
+	ptr = (char *)args[idx];
+	*data_size = 0;
+
+	/*
+	 * This acts similar to a seqcount. The per CPU context switches are
+	 * recorded, migration is disabled and preemption is enabled. The
+	 * read of the user space memory is copied into the per CPU buffer.
+	 * Preemption is disabled again, and if the per CPU context switches count
+	 * is still the same, it means the buffer has not been corrupted.
+	 * If the count is different, it is assumed the buffer is corrupted
+	 * and reading must be tried again.
+	 */
+ again:
+	/*
+	 * If for some reason, copy_from_user() always causes a context
+	 * switch, this would then cause an inifinite loop.
+	 * If this task is preempted by another user space task, it
+	 * will cause this task to try again. But just in case something
+	 * changes where the copying from user space causes another task
+	 * to run, prevent this from going into an infinite loop.
+	 * 10 tries should be plenty.
+	 */
+	if (trys++ > 10) {
+		static bool once;
+		/*
+		 * Only print a message instead of a WARN_ON() as this could
+		 * theoretically trigger under real load.
+		 */
+		if (!once)
+			pr_warn("Error: Too many tries to read syscall %s\n", sys_data->name);
+		once = true;
+		return buf;
+	}
+
+	/* Read the current CPU context switch counter */
+	cnt = nr_context_switches_cpu(cpu);
+
+	/*
+	 * Preemption is going to be enabled, but this task must
+	 * remain on this CPU.
+	 */
+	migrate_disable();
+
+	/*
+	 * Now preemption is being enabed and another task can come in
+	 * and use the same buffer and corrupt our data.
+	 */
+	preempt_enable_notrace();
+
+	ret = strncpy_from_user(buf, ptr, size);
+
+	preempt_disable_notrace();
+	migrate_enable();
+
+	/* If it faulted, no use to try again */
+	if (ret < 0)
+		return buf;
+
+	/*
+	 * Preemption is disabled again, now check the per CPU context
+	 * switch counter. If it doesn't match, then another user space
+	 * process may have schedule in and corrupted our buffer. In that
+	 * case the copying must be retried.
+	 */
+	if (nr_context_switches_cpu(cpu) != cnt)
+		goto again;
+
+	/* Replace any non-printable characters with '.' */
+	for (int i = 0; i < ret; i++) {
+		if (!isprint(buf[i]))
+			buf[i] = '.';
+	}
+
+	/*
+	 * If the text was truncated due to our max limit, add "..." to
+	 * the string.
+	 */
+	if (ret > SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA)) {
+		strscpy(buf + SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA),
+			EXTRA, sizeof(EXTRA));
+		ret = SYSCALL_FAULT_BUF_SZ;
+	} else {
+		buf[ret++] = '\0';
+	}
+
+	*data_size = ret;
+	return buf;
+}
+
 static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 {
 	struct trace_array *tr = data;
@@ -302,15 +560,17 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct syscall_metadata *sys_data;
 	struct trace_event_buffer fbuffer;
 	unsigned long args[6];
+	char *user_ptr;
+	int user_size = 0;
 	int syscall_nr;
-	int size;
+	int size = 0;
+	bool mayfault;
 
 	/*
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
 	might_fault();
-	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
@@ -327,7 +587,32 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	if (!sys_data)
 		return;
 
-	size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
+	/* Check if this syscall event faults in user space memory */
+	mayfault = sys_data->user_mask != 0;
+
+	guard(preempt_notrace)();
+
+	syscall_get_arguments(current, regs, args);
+
+	if (mayfault) {
+		struct syscall_buf_info *sinfo;
+
+		/* If the syscall_buffer is NULL, tracing is being shutdown */
+		sinfo = READ_ONCE(syscall_buffer);
+		if (!sinfo)
+			return;
+
+		user_ptr = sys_fault_user(sys_data, sinfo, args, &user_size);
+		/*
+		 * user_size is the amount of data to append.
+		 * Need to add 4 for the meta field that points to
+		 * the user memory at the end of the event and also
+		 * stores its size.
+		 */
+		size = 4 + user_size;
+	}
+
+	size += sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
 	if (!entry)
@@ -335,9 +620,36 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	entry = ring_buffer_event_data(fbuffer.event);
 	entry->nr = syscall_nr;
-	syscall_get_arguments(current, regs, args);
+
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
+	if (mayfault) {
+		void *ptr;
+		int val;
+
+		/*
+		 * Set the pointer to point to the meta data of the event
+		 * that has information about the stored user space memory.
+		 */
+		ptr = (void *)entry->args + sizeof(unsigned long) * sys_data->nb_args;
+
+		/*
+		 * The meta data will store the offset of the user data from
+		 * the beginning of the event.
+		 */
+		val  = (ptr - (void *)entry) + 4;
+
+		/* Store the offset and the size into the meta data */
+		*(int *)ptr = val | (user_size << 16);
+
+		/* Nothing to do if the user space was empty or faulted */
+		if (user_size) {
+			/* Now store the user space data into the event */
+			ptr += 4;
+			memcpy(ptr, user_ptr, user_size);
+		}
+	}
+
 	trace_event_buffer_commit(&fbuffer);
 }
 
@@ -386,39 +698,50 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 static int reg_event_syscall_enter(struct trace_event_file *file,
 				   struct trace_event_call *call)
 {
+	struct syscall_metadata *sys_data = call->data;
 	struct trace_array *tr = file->tr;
 	int ret = 0;
 	int num;
 
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
+	num = sys_data->syscall_nr;
 	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return -ENOSYS;
-	mutex_lock(&syscall_trace_lock);
-	if (!tr->sys_refcount_enter)
+	guard(mutex)(&syscall_trace_lock);
+	if (sys_data->user_mask) {
+		ret = syscall_fault_buffer_enable();
+		if (ret)
+			return ret;
+	}
+	if (!tr->sys_refcount_enter) {
 		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
-	if (!ret) {
-		WRITE_ONCE(tr->enter_syscall_files[num], file);
-		tr->sys_refcount_enter++;
+		if (ret < 0) {
+			if (sys_data->user_mask)
+				syscall_fault_buffer_disable();
+			return ret;
+		}
 	}
-	mutex_unlock(&syscall_trace_lock);
-	return ret;
+	WRITE_ONCE(tr->enter_syscall_files[num], file);
+	tr->sys_refcount_enter++;
+	return 0;
 }
 
 static void unreg_event_syscall_enter(struct trace_event_file *file,
 				      struct trace_event_call *call)
 {
+	struct syscall_metadata *sys_data = call->data;
 	struct trace_array *tr = file->tr;
 	int num;
 
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
+	num = sys_data->syscall_nr;
 	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return;
-	mutex_lock(&syscall_trace_lock);
+	guard(mutex)(&syscall_trace_lock);
 	tr->sys_refcount_enter--;
 	WRITE_ONCE(tr->enter_syscall_files[num], NULL);
 	if (!tr->sys_refcount_enter)
 		unregister_trace_sys_enter(ftrace_syscall_enter, tr);
-	mutex_unlock(&syscall_trace_lock);
+	if (sys_data->user_mask)
+		syscall_fault_buffer_disable();
 }
 
 static int reg_event_syscall_exit(struct trace_event_file *file,
@@ -459,6 +782,123 @@ static void unreg_event_syscall_exit(struct trace_event_file *file,
 	mutex_unlock(&syscall_trace_lock);
 }
 
+/*
+ * For system calls that reference user space memory that can
+ * be recorded into the event, set the system call meta data's user_mask
+ * to the "args" index that points to the user space memory to retrieve.
+ */
+static void check_faultable_syscall(struct trace_event_call *call, int nr)
+{
+	struct syscall_metadata *sys_data = call->data;
+
+	/* Only work on entry */
+	if (sys_data->enter_event != call)
+		return;
+
+	switch (nr) {
+	/* user arg at position 0 */
+	case __NR_access:
+	case __NR_acct:
+	case __NR_add_key: /* Just _type. TODO add _description */
+	case __NR_chdir:
+	case __NR_chown:
+	case __NR_chmod:
+	case __NR_chroot:
+	case __NR_creat:
+	case __NR_delete_module:
+	case __NR_execve:
+	case __NR_fsopen:
+	case __NR_getxattr: /* Just pathname, TODO add name */
+	case __NR_lchown:
+	case __NR_lgetxattr: /* Just pathname, TODO add name */
+	case __NR_lremovexattr: /* Just pathname, TODO add name */
+	case __NR_link: /* Just oldname. TODO add newname */
+	case __NR_listxattr: /* Just pathname, TODO add list */
+	case __NR_llistxattr: /* Just pathname, TODO add list */
+	case __NR_lsetxattr: /* Just pathname, TODO add list */
+	case __NR_open:
+	case __NR_memfd_create:
+	case __NR_mount: /* Just dev_name, TODO add dir_name and type */
+	case __NR_mkdir:
+	case __NR_mknod:
+	case __NR_mq_open:
+	case __NR_mq_unlink:
+	case __NR_pivot_root: /* Just new_root, TODO add old_root */
+	case __NR_readlink:
+	case __NR_removexattr: /* Just pathname, TODO add name */
+	case __NR_rename: /* Just oldname. TODO add newname */
+	case __NR_request_key: /* Just _type. TODO add _description */
+	case __NR_rmdir:
+	case __NR_setxattr: /* Just pathname, TODO add list */
+	case __NR_shmdt:
+	case __NR_statfs:
+	case __NR_swapon:
+	case __NR_swapoff:
+	case __NR_symlink: /* Just oldname. TODO add newname */
+	case __NR_truncate:
+	case __NR_unlink:
+	case __NR_umount2:
+	case __NR_utime:
+	case __NR_utimes:
+		sys_data->user_mask = BIT(0);
+		break;
+	/* user arg at position 1 */
+	case __NR_execveat:
+	case __NR_faccessat:
+	case __NR_faccessat2:
+	case __NR_finit_module:
+	case __NR_fchmodat:
+	case __NR_fchmodat2:
+	case __NR_fchownat:
+	case __NR_fgetxattr:
+	case __NR_flistxattr:
+	case __NR_fsetxattr:
+	case __NR_fspick:
+	case __NR_fremovexattr:
+	case __NR_futimesat:
+	case __NR_getxattrat: /* Just pathname, TODO add name */
+	case __NR_inotify_add_watch:
+	case __NR_linkat: /* Just oldname. TODO add newname */
+	case __NR_listxattrat: /* Just pathname, TODO add list */
+	case __NR_mkdirat:
+	case __NR_mknodat:
+	case __NR_mount_setattr:
+	case __NR_move_mount: /* Just from_pathname, TODO add to_pathname */
+	case __NR_name_to_handle_at:
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
+	case __NR_newfstatat:
+#endif
+	case __NR_openat:
+	case __NR_openat2:
+	case __NR_open_tree:
+	case __NR_open_tree_attr:
+	case __NR_readlinkat:
+	case __NR_renameat: /* Just oldname. TODO add newname */
+	case __NR_renameat2: /* Just oldname. TODO add newname */
+	case __NR_removexattrat: /* Just pathname, TODO add name */
+	case __NR_quotactl:
+	case __NR_setxattrat: /* Just pathname, TODO add list */
+	case __NR_syslog:
+	case __NR_symlinkat: /* Just oldname. TODO add newname */
+	case __NR_statx:
+	case __NR_unlinkat:
+	case __NR_utimensat:
+		sys_data->user_mask = BIT(1);
+		break;
+	/* user arg at position 2 */
+	case __NR_init_module:
+	case __NR_fsconfig:
+		sys_data->user_mask = BIT(2);
+		break;
+	/* user arg at position 4 */
+	case __NR_fanotify_mark:
+		sys_data->user_mask = BIT(4);
+		break;
+	default:
+		sys_data->user_mask = 0;
+	}
+}
+
 static int __init init_syscall_trace(struct trace_event_call *call)
 {
 	int id;
@@ -471,6 +911,8 @@ static int __init init_syscall_trace(struct trace_event_call *call)
 		return -ENOSYS;
 	}
 
+	check_faultable_syscall(call, num);
+
 	if (set_syscall_print_fmt(call) < 0)
 		return -ENOMEM;
 
-- 
2.50.1


