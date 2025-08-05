Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2ED224B1B;
	Tue,  5 Aug 2025 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422325; cv=none; b=KbRCcCScYnrOdcKybC+USroU0hP71XGhmu0rZ0yJADpWuBy2v53QOVWcmHh/ZJDh7L1VguetQOR3TkPVlaq9rJqWvJqdPC/1KMnLKizD+5333zIB3JLG7SVs1UdOLZINc15lwdeG6egup79shIYrIjLQeBZNTTGTgj4A9eaJNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422325; c=relaxed/simple;
	bh=tuX/OptcMQOGRrH5a07VcqE26bPG1oUm4MoPAqpNLF8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qKiQh3ecrN4WpAAbaM6Vy6X3pbe0Qg6wy02tGNwsLEPwVI6aSfxpVJHNQKiMt5mvHz2/P28RYu33UTfpbsIHBusAtY66f0YqtENdmv4iLEqJQ1B4Fh96onWb5m+PsCFm26aEXKzKxckf0489RugZ9sCwqJgWm2H4YOD1Vz/64aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/KavdGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/KavdGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A31C4CEF7;
	Tue,  5 Aug 2025 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754422325;
	bh=tuX/OptcMQOGRrH5a07VcqE26bPG1oUm4MoPAqpNLF8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=l/KavdGB6SPb8GW4CWH3WQt8tBCKM+zi1qBJJrbLHtKgpxUiQF1TOuFEHVp77Vxjw
	 AoqLEsSdAJvR5gBebzrCSoppUhdMOPaDxsLVrVg9r6fhVhl3uxHhxgxJ1bxibYyxuO
	 5LAsrcG0SVrbCnf9HDyhAkIvaWMepdDTQ1HhRdg1e+kySmLsXg9is7NYYE+HypXwzV
	 IeMCq7EPFSbac/T7o4PDINfl+z5APtoeOYen1nLC5WUuayfyJ2oysrLRUAt94jO/4u
	 uhhyZ6NPmWCOeFfmFFNgBmL7Wnq2YUnscvf0ZKS62vXF+LNWXt+6wMCoyWb3ii+GGl
	 t5bm704u4lT2Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ujNOl-0000000AtFQ-32wr;
	Tue, 05 Aug 2025 15:32:35 -0400
Message-ID: <20250805193235.582013098@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 05 Aug 2025 15:26:52 -0400
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
 aahringo@redhat.com,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH 6/7] tracing: Allow syscall trace events to read more than one user
 parameter
References: <20250805192646.328291790@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Allow more than one field of a syscall trace event to read user space.
Build on top of the user_mask by allowing more than one bit to be set that
corresponds to the @args array of the syscall metadata. For each argument
in the @args array that is to be read, it will have a dynamic array/string
field associated to it.

Note that multiple fields to be read from user space is not supported if
the user_arg_size field is set in the syscall metada. That field can only
be used if only one field is being read from user space as that field is a
number representing the size field of the syscall event that holds the
size of the data to read from user space. It becomes ambiguous if the
system call reads more than one field. Currently this is not an issue.

If a syscall event happens to enable two events to read user space and
sets the user_arg_size field, it will trigger a warning at boot and the
user_arg_size field will be cleared.

The per CPU buffer that is used to read the user space addresses is now
broken up into 3 sections, each of 168 bytes. The reason for 168 is that
it is the biggest portion of 512 bytes divided by 3 that is 8 byte aligned.

The max amount copied into the ring buffer from user space is now only 128
bytes, which is plenty. When reading user space, it still reads 167
(168-1) bytes and uses the remaining to know if it should append the extra
"..." to the end or not.

This will allow the event to look like this:

  sys_renameat2(olddfd: 0xffffff9c, oldname: 0x7ffe02facdff "/tmp/x", newdfd: 0xffffff9c, newname: 0x7ffe02face06 "/tmp/y", flags: 1)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 312 ++++++++++++++++++++++------------
 1 file changed, 207 insertions(+), 105 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 8c0142eea898..b39fa9dd1067 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -139,6 +139,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	struct syscall_metadata *entry;
 	int i, syscall, val, len;
 	unsigned char *ptr;
+	int offset = 0;
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
@@ -178,11 +179,12 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 			continue;
 
 		/* This arg points to a user space string */
-		ptr = (void *)trace->args + sizeof(long) * entry->nb_args;
+		ptr = (void *)trace->args + sizeof(long) * entry->nb_args + offset;
 		val = *(int *)ptr;
 
 		ptr = (void *)ent + (val & 0xffff);
 		len = val >> 16;
+		offset += 4;
 
 		if (entry->user_arg_size < 0 || entry->user_arg_is_str) {
 			trace_seq_printf(s, " \"%.*s\"", len, ptr);
@@ -335,7 +337,6 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 	unsigned long mask;
 	char *arg;
 	int offset = offsetof(typeof(trace), args);
-	int idx;
 	int ret = 0;
 	int len;
 	int i;
@@ -354,27 +355,35 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 		return ret;
 
 	mask = meta->user_mask;
-	idx = ffs(mask) - 1;
 
-	/*
-	 * User space data is faulted into a temporary buffer and then
-	 * added as a dynamic string or array to the end of the event.
-	 * The user space data name for the arg pointer is "__<arg>_val".
-	 */
-	len = strlen(meta->args[idx]) + sizeof("___val");
-	arg = kmalloc(len, GFP_KERNEL);
-	if (WARN_ON_ONCE(!arg)) {
-		meta->user_mask = 0;
-		return -ENOMEM;
-	}
+	while (mask) {
+		int idx = ffs(mask) - 1;
+		mask &= ~BIT(idx);
+
+		/*
+		 * User space data is faulted into a temporary buffer and then
+		 * added as a dynamic string or array to the end of the event.
+		 * The user space data name for the arg pointer is
+		 * "__<arg>_val".
+		 */
+		len = strlen(meta->args[idx]) + sizeof("___val");
+		arg = kmalloc(len, GFP_KERNEL);
+		if (WARN_ON_ONCE(!arg)) {
+			meta->user_mask = 0;
+			return -ENOMEM;
+		}
 
-	snprintf(arg, len, "__%s_val", meta->args[idx]);
+		snprintf(arg, len, "__%s_val", meta->args[idx]);
 
-	ret = trace_define_field(call, "__data_loc char[]",
-				 arg, offset, sizeof(int), 0,
-				 FILTER_OTHER);
-	if (ret)
-		kfree(arg);
+		ret = trace_define_field(call, "__data_loc char[]",
+					 arg, offset, sizeof(int), 0,
+					 FILTER_OTHER);
+		if (ret) {
+			kfree(arg);
+			break;
+		}
+		offset += 4;
+	}
 	return ret;
 }
 
@@ -387,8 +396,25 @@ struct syscall_buf_info {
 	struct syscall_buf __percpu	*sbuf;
 };
 
-/* Create a per CPU temporary buffer to copy user space pointers into */
+/*
+ * Create a per CPU temporary buffer to copy user space pointers into.
+ *
+ * SYSCALL_FAULT_BUF_SZ holds the size of the per CPU buffer to use
+ * to copy memory from user space addresses into.
+ *
+ * SYSCALL_FAULT_ARG_SZ is the amount to copy from user space.
+ *
+ * SYSCALL_FAULT_USER_MAX is the amount to copy into the ring buffer.
+ *  It's slightly smaller than SYSCALL_FAULT_ARG_SZ to know if it
+ *  needs to append the EXTRA or not.
+ *
+ * This only allows up to 3 args from system calls.
+ */
 #define SYSCALL_FAULT_BUF_SZ 512
+#define SYSCALL_FAULT_ARG_SZ 168
+#define SYSCALL_FAULT_USER_MAX 128
+#define SYSCALL_FAULT_MAX_CNT 3
+
 static struct syscall_buf_info *syscall_buffer;
 static DEFINE_PER_CPU(unsigned long, sched_switch_cnt);
 
@@ -498,22 +524,57 @@ static void syscall_fault_buffer_disable(void)
 	call_rcu_tasks_trace(&sinfo->rcu, rcu_free_syscall_buffer);
 }
 
-static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_buf_info *sinfo,
-			    unsigned long *args, unsigned int *data_size)
+static char *sys_fault_user(struct syscall_metadata *sys_data,
+			    struct syscall_buf_info *sinfo,
+			    unsigned long *args,
+			    unsigned int data_size[SYSCALL_FAULT_MAX_CNT])
 {
-	char *buf = per_cpu_ptr(sinfo->sbuf, smp_processor_id())->buf;
-	unsigned long size = SYSCALL_FAULT_BUF_SZ - 1;
+	char *buffer = per_cpu_ptr(sinfo->sbuf, smp_processor_id())->buf;
 	unsigned long mask = sys_data->user_mask;
+	unsigned long size = SYSCALL_FAULT_ARG_SZ - 1;
 	unsigned int cnt;
-	int idx = ffs(mask) - 1;
 	bool array = false;
-	char *ptr;
+	char *ptr_array[SYSCALL_FAULT_MAX_CNT];
+	char *buf;
+	int read[SYSCALL_FAULT_MAX_CNT];
 	int trys = 0;
+	int uargs;
 	int ret;
+	int i = 0;
+
+	/* The extra is appended to the user data in the buffer */
+	BUILD_BUG_ON(SYSCALL_FAULT_USER_MAX + sizeof(EXTRA) >=
+		     SYSCALL_FAULT_ARG_SZ);
+
+	/*
+	 * If this system call event has a size argument, use
+	 * it to define how much of user space memory to read,
+	 * and read it as an array and not a string.
+	 */
+	if (sys_data->user_arg_size >= 0) {
+		array = true;
+		size = args[sys_data->user_arg_size];
+		if (size > SYSCALL_FAULT_ARG_SZ - 1)
+			size = SYSCALL_FAULT_ARG_SZ - 1;
+	}
+
+	while (mask) {
+		int idx = ffs(mask) - 1;
+		mask &= ~BIT(idx);
+
+		if (WARN_ON_ONCE(i == SYSCALL_FAULT_MAX_CNT))
+			break;
+
+		/* Get the pointer to user space memory to read */
+		ptr_array[i++] = (char *)args[idx];
+	}
 
-	/* Get the pointer to user space memory to read */
-	ptr = (char *)args[idx];
-	*data_size = 0;
+	uargs = i;
+
+	/* Clear the values that are not used */
+	for (; i < SYSCALL_FAULT_MAX_CNT; i++) {
+		data_size[i] = -1; /* Denotes no pointer */
+	}
 
  again:
 	/*
@@ -532,24 +593,12 @@ static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_bu
 		if (!once)
 			pr_warn("Error: Too many tries to read syscall %s\n", sys_data->name);
 		once = true;
-		return buf;
+		return buffer;
 	}
 
 	/* Read the current sched switch count */
 	cnt = this_cpu_read(sched_switch_cnt);
 
-	/*
-	 * If this system call event has a size argument, use
-	 * it to define how much of user space memory to read,
-	 * and read it as an array and not a string.
-	 */
-	if (sys_data->user_arg_size >= 0) {
-		array = true;
-		size = args[sys_data->user_arg_size];
-		if (size > SYSCALL_FAULT_BUF_SZ - 1)
-			size = SYSCALL_FAULT_BUF_SZ - 1;
-	}
-
 	/*
 	 * Preemption is going to be enabled, but this task must
 	 * remain on this CPU.
@@ -562,20 +611,23 @@ static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_bu
 	 */
 	preempt_enable_notrace();
 
-	if (array) {
-		ret = __copy_from_user(buf, ptr, size);
-		ret = ret ? -1 : size;
-	} else {
-		ret = strncpy_from_user(buf, ptr, size);
+	buf = buffer;
+
+	for (i = 0; i < uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
+		char *ptr = ptr_array[i];
+
+		if (array) {
+			ret = __copy_from_user(buf, ptr, size);
+			ret = ret ? -1 : size;
+		} else {
+			ret = strncpy_from_user(buf, ptr, size);
+		}
+		read[i] = ret;
 	}
 
 	preempt_disable_notrace();
 	migrate_enable();
 
-	/* If it faulted, no use to try again */
-	if (ret < 0)
-		return buf;
-
 	/*
 	 * Preemption is disabled again, now check the sched_switch_cnt.
 	 * If it increased by two or more, then another user space process
@@ -592,28 +644,39 @@ static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_bu
 	if (this_cpu_read(sched_switch_cnt) > cnt + 1)
 		goto again;
 
-	/* For strings, replace any non-printable characters with '.' */
-	if (!array) {
-		for (int i = 0; i < ret; i++) {
-			if (!isprint(buf[i]))
-				buf[i] = '.';
-		}
+	buf = buffer;
+	for (i = 0; i < uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
 
-		/*
-		 * If the text was truncated due to our max limit, add "..." to
-		 * the string.
-		 */
-		if (ret > SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA)) {
-			strscpy(buf + SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA),
-				EXTRA, sizeof(EXTRA));
-			ret = SYSCALL_FAULT_BUF_SZ;
+		ret = read[i];
+		if (ret < 0)
+			continue;
+		buf[ret] = '\0';
+
+		/* For strings, replace any non-printable characters with '.' */
+		if (!array) {
+			for (int x = 0; x < ret; x++) {
+				if (!isprint(buf[x]))
+					buf[x] = '.';
+			}
+
+			/*
+			 * If the text was truncated due to our max limit,
+			 * add "..." to the string.
+			 */
+			if (ret > SYSCALL_FAULT_USER_MAX) {
+				strscpy(buf + SYSCALL_FAULT_USER_MAX, EXTRA,
+					sizeof(EXTRA));
+				ret = SYSCALL_FAULT_USER_MAX + sizeof(EXTRA);
+			} else {
+				buf[ret++] = '\0';
+			}
 		} else {
-			buf[ret++] = '\0';
+			ret = min(ret, SYSCALL_FAULT_USER_MAX);
 		}
+		data_size[i] = ret;
 	}
 
-	*data_size = ret;
-	return buf;
+	return buffer;
 }
 
 static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
@@ -625,9 +688,10 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct trace_event_buffer fbuffer;
 	unsigned long args[6];
 	char *user_ptr;
-	int user_size = 0;
+	int user_sizes[SYSCALL_FAULT_MAX_CNT] = {};
 	int syscall_nr;
 	int size = 0;
+	int uargs = 0;
 	bool mayfault;
 
 	/*
@@ -660,20 +724,27 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	if (mayfault) {
 		struct syscall_buf_info *sinfo;
+		int i;
 
 		/* If the syscall_buffer is NULL, tracing is being shutdown */
 		sinfo = READ_ONCE(syscall_buffer);
 		if (!sinfo)
 			return;
 
-		user_ptr = sys_fault_user(sys_data, sinfo, args, &user_size);
+		user_ptr = sys_fault_user(sys_data, sinfo, args, user_sizes);
 		/*
 		 * user_size is the amount of data to append.
 		 * Need to add 4 for the meta field that points to
 		 * the user memory at the end of the event and also
 		 * stores its size.
 		 */
-		size = 4 + user_size;
+		for (i = 0; i < SYSCALL_FAULT_MAX_CNT; i++) {
+			if (user_sizes[i] < 0)
+				break;
+			size += user_sizes[i] + 4;
+		}
+		/* Save the number of user read arguments of this syscall */
+		uargs = i;
 	}
 
 	size += sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
@@ -688,6 +759,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	if (mayfault) {
+		char *buf = user_ptr;
 		void *ptr;
 		int val;
 
@@ -699,21 +771,30 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 		/*
 		 * The meta data will store the offset of the user data from
-		 * the beginning of the event.
+		 * the beginning of the event. That is after the static arguments
+		 * and the meta data fields.
 		 */
-		val  = (ptr - (void *)entry) + 4;
+		val = (ptr - (void *)entry) + 4 * uargs;
+
+		for (int i = 0; i < uargs; i++) {
 
-		/* Store the offset and the size into the meta data */
-		*(int *)ptr = val | (user_size << 16);
+			if (i)
+				val += user_sizes[i - 1];
 
-		if (WARN_ON_ONCE((ptr - (void *)entry + user_size) > size))
-			user_size = 0;
+			/* Store the offset and the size into the meta data */
+			*(int *)ptr = val | (user_sizes[i] << 16);
 
-		/* Nothing to do if the user space was empty or faulted */
-		if (user_size) {
-			/* Now store the user space data into the event */
+			/* Skip the meta data */
 			ptr += 4;
-			memcpy(ptr, user_ptr, user_size);
+		}
+
+		for (int i = 0; i < uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
+			/* Nothing to do if the user space was empty or faulted */
+			if (!user_sizes[i])
+				continue;
+
+			memcpy(ptr, buf, user_sizes[i]);
+			ptr += user_sizes[i];
 		}
 	}
 
@@ -857,6 +938,7 @@ static void unreg_event_syscall_exit(struct trace_event_file *file,
 static void check_faultable_syscall(struct trace_event_call *call, int nr)
 {
 	struct syscall_metadata *sys_data = call->data;
+	unsigned long mask;
 
 	/* Only work on entry */
 	if (sys_data->enter_event != call)
@@ -888,7 +970,6 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	/* user arg at position 0 */
 	case __NR_access:
 	case __NR_acct:
-	case __NR_add_key: /* Just _type. TODO add _description */
 	case __NR_chdir:
 	case __NR_chown:
 	case __NR_chmod:
@@ -897,28 +978,15 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_delete_module:
 	case __NR_execve:
 	case __NR_fsopen:
-	case __NR_getxattr: /* Just pathname, TODO add name */
 	case __NR_lchown:
-	case __NR_lgetxattr: /* Just pathname, TODO add name */
-	case __NR_lremovexattr: /* Just pathname, TODO add name */
-	case __NR_link: /* Just oldname. TODO add newname */
-	case __NR_listxattr: /* Just pathname, TODO add list */
-	case __NR_llistxattr: /* Just pathname, TODO add list */
-	case __NR_lsetxattr: /* Just pathname, TODO add list */
 	case __NR_open:
 	case __NR_memfd_create:
-	case __NR_mount: /* Just dev_name, TODO add dir_name and type */
 	case __NR_mkdir:
 	case __NR_mknod:
 	case __NR_mq_open:
 	case __NR_mq_unlink:
-	case __NR_pivot_root: /* Just new_root, TODO add old_root */
 	case __NR_readlink:
-	case __NR_removexattr: /* Just pathname, TODO add name */
-	case __NR_rename: /* Just oldname. TODO add newname */
-	case __NR_request_key: /* Just _type. TODO add _description */
 	case __NR_rmdir:
-	case __NR_setxattr: /* Just pathname, TODO add list */
 	case __NR_shmdt:
 	case __NR_statfs:
 	case __NR_swapon:
@@ -945,14 +1013,10 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_fspick:
 	case __NR_fremovexattr:
 	case __NR_futimesat:
-	case __NR_getxattrat: /* Just pathname, TODO add name */
 	case __NR_inotify_add_watch:
-	case __NR_linkat: /* Just oldname. TODO add newname */
-	case __NR_listxattrat: /* Just pathname, TODO add list */
 	case __NR_mkdirat:
 	case __NR_mknodat:
 	case __NR_mount_setattr:
-	case __NR_move_mount: /* Just from_pathname, TODO add to_pathname */
 	case __NR_name_to_handle_at:
 	case __NR_newfstatat:
 	case __NR_openat:
@@ -960,13 +1024,8 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_open_tree:
 	case __NR_open_tree_attr:
 	case __NR_readlinkat:
-	case __NR_renameat: /* Just oldname. TODO add newname */
-	case __NR_renameat2: /* Just oldname. TODO add newname */
-	case __NR_removexattrat: /* Just pathname, TODO add name */
 	case __NR_quotactl:
-	case __NR_setxattrat: /* Just pathname, TODO add list */
 	case __NR_syslog:
-	case __NR_symlinkat: /* Just oldname. TODO add newname */
 	case __NR_statx:
 	case __NR_unlinkat:
 	case __NR_utimensat:
@@ -981,9 +1040,52 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_fanotify_mark:
 		sys_data->user_mask = BIT(4);
 		break;
+	/* 2 user args, 0 and 1 */
+	case __NR_add_key:
+	case __NR_getxattr:
+	case __NR_lgetxattr:
+	case __NR_lremovexattr:
+	case __NR_link:
+	case __NR_listxattr:
+	case __NR_llistxattr:
+	case __NR_lsetxattr:
+	case __NR_pivot_root:
+	case __NR_removexattr:
+	case __NR_rename:
+	case __NR_request_key:
+	case __NR_setxattr:
+	case __NR_symlinkat:
+		sys_data->user_mask = BIT(0) | BIT(1);
+		break;
+	/* 2 user args, 1 and 3 */
+	case __NR_getxattrat:
+	case __NR_linkat:
+	case __NR_listxattrat:
+	case __NR_move_mount:
+	case __NR_renameat:
+	case __NR_renameat2:
+	case __NR_removexattrat:
+	case __NR_setxattrat:
+		sys_data->user_mask = BIT(1) | BIT(3);
+		break;
+	case __NR_mount: /* Just dev_name and dir_name, TODO add type */
+		sys_data->user_mask = BIT(0) | BIT(1) | BIT(2);
+		break;
 	default:
 		sys_data->user_mask = 0;
+		return;
 	}
+
+	if (sys_data->user_arg_size < 0)
+		return;
+
+	/*
+	 * The user_arg_size can only be used when the system call
+	 * is reading only a single address from user space.
+	 */
+	mask = sys_data->user_mask;
+	if (WARN_ON(mask & (mask - 1)))
+		sys_data->user_arg_size = -1;
 }
 
 static int __init init_syscall_trace(struct trace_event_call *call)
-- 
2.47.2


