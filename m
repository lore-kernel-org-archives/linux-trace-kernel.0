Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D33E92A6;
	Tue, 10 Mar 2026 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173427; cv=none; b=mT93BrYkD4dH1tNi6XPkpnocXvkYhg7kodiWNsYdI4/9amLoCDmw0RNtq/mwQHMaqfIvLb3O1L+Jcslg7zrkFJshA8cLz3kw/ii0raOGC+20hVTTO0lG4UQnfUCPY4ZL6kTWUBorbjCUWIWukkAtaJZmgn6GyvICssjIVg+hink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173427; c=relaxed/simple;
	bh=lU1o05H5o1+yLP3TaL3mIt1AnhJ8MBEvnw/+fkq9R7I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OnDiMcD5GwQhJFw+uPacW8Bk4FtRHi7ar6ZGn2eKtv4NX19Pi41YCLtwH2euF2FhVUm2VumzFR+UXtQCOKqieeP+/07rlgDZKqalBNvrSdBdzLGPIhc7iqoH//JiBJ605u3mQOR6iZ7UKdZNLQxWHXJNJ3MM+p/ID5E1jC41S2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1zR/YDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1zR/YDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347F4C19425;
	Tue, 10 Mar 2026 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773173427;
	bh=lU1o05H5o1+yLP3TaL3mIt1AnhJ8MBEvnw/+fkq9R7I=;
	h=Date:From:To:Cc:Subject:References:From;
	b=A1zR/YDB7qcJrPgHngzfAjy+JgFcyZ6mIYxwo4t0AUGnh6eOdFvqSgQ/5/QPYfzbR
	 i1odmhJIm1+5UxFyHyJO8r4+Iv+wry9qSrTg4XXVWi6MuUMmMWLoIJoHI3Tn8jRzYb
	 IjXgmXchpud4PKN7Y75w2nqlVdRiW87WM8RvXzW7H0jRNI4cGGo6xuQViNZfA83HKW
	 1qw2gASD9yE+Cs3MSd5Ax7pClSOfwopoi0KD0rwCBMENrp/OKrguKmyVbJEmpGg4AR
	 HDG9gMgZZMq/K2Gn5Ga4CpX6hLKTiJ6RqpdS5o5SiujndOh4WPRlhkO/Qa+GUGdEpI
	 svCjsaRuw1TNg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w03PY-00000002kqv-2v0v;
	Tue, 10 Mar 2026 16:10:36 -0400
Message-ID: <20260310201036.542627924@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 10 Mar 2026 16:09:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Brian Geffon <bgeffon@google.com>,
 John Stultz <jstultz@google.com>,
 Ian Rogers <irogers@google.com>,
 Suleiman Souhlal <suleiman@google.com>
Subject: [PATCH v2 1/3] tracing: Have futex syscall trace event show specific user data
References: <20260310200954.285663884@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add specific reporting of the futex system call. This allows for debugging
the futex code a bit easier. Instead of just showing the values passed
into the futex system call, read the value of the user space memory
pointed to by the addr parameter.

Also make the op parameter more readable by parsing the values to show
what the command is:

 futex_requeue_p-3251    [002] .....  2101.068479: sys_futex(uaddr: 0x55e79a4da834 (0x80000cb1), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
 futex_requeue_p-3248    [001] .....  2101.068970: sys_futex(uaddr: 0x7f859072f990 (0xcb2), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, val: 3250)
 futex_requeue_p-3252    [005] .....  2101.069108: sys_futex(uaddr: 0x55e79a4da838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: 0x7ffe61076aa0, uaddr2: 0x55e79a4da834, uaddr2: 94453214586932, val3: 0)
 futex_requeue_p-3252    [005] .....  2101.069410: sys_futex(uaddr: 0x55e79a4da834 (0x80000cb1), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20260303214942.428502100@kernel.org/

- Moved the printing of the futex parameters to kernel/futex/syscall.c to
  keep it closer to the actual system call.

 include/linux/futex.h         |   7 +-
 kernel/futex/syscalls.c       |  89 ++++++++++++++++++
 kernel/trace/trace_syscalls.c | 168 +++++++++++++++++++++++++++++++++-
 3 files changed, 260 insertions(+), 4 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9e9750f04980..9fc47aa01a8b 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -82,6 +82,10 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
 
+#ifdef CONFIG_FTRACE_SYSCALLS
+void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args, u32 *ptr);
+#endif
+
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
@@ -114,7 +118,8 @@ static inline int futex_hash_allocate_default(void)
 }
 static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
 static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
-
+static inline void futex_print_syscall(struct seq_buf *s, int nr_args,
+				       unsigned long *args, u32 *ptr) { }
 #endif
 
 #endif
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 743c7a728237..a1cd512aa502 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -171,6 +171,18 @@ static __always_inline bool futex_cmd_has_timeout(u32 cmd)
 	return false;
 }
 
+static __always_inline bool futex_cmd_has_addr2(u32 cmd)
+{
+	switch (cmd) {
+	case FUTEX_REQUEUE:
+	case FUTEX_CMP_REQUEUE:
+	case FUTEX_WAKE_OP:
+	case FUTEX_WAIT_REQUEUE_PI:
+		return true;
+	}
+	return false;
+}
+
 static __always_inline int
 futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
 {
@@ -207,6 +219,83 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
+#ifdef CONFIG_FTRACE_SYSCALLS
+static const char * __futex_cmds[] =
+{
+	"FUTEX_WAIT", "FUTEX_WAKE", "FUTEX_FD", "FUTEX_REQUEUE",
+	"FUTEX_CMP_REQUEUE", "FUTEX_WAKE_OP", "FUTEX_LOCK_PI",
+	"FUTEX_UNLOCK_PI", "FUTEX_TRYLOCK_PI", "FUTEX_WAIT_BITSET",
+	"FUTEX_WAKE_BITSET", "FUTEX_WAIT_REQUEUE_PI", "FUTEX_CMP_REQUEUE_PI",
+	"FUTEX_LOCK_PI2",
+};
+
+void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args, u32 *ptr)
+{
+	unsigned int op, cmd;
+	bool done = false;
+
+	for (int i = 0; !done && i < nr_args; i++) {
+
+		if (seq_buf_has_overflowed(s))
+			break;
+
+		switch (i) {
+		case 0:
+			seq_buf_printf(s, "uaddr: 0x%lx", args[i]);
+			if (ptr) {
+				u32 val = *ptr;
+				if (val < 10)
+					seq_buf_printf(s, " (%u)", val);
+				else
+					seq_buf_printf(s, " (0x%x)", val);
+			}
+			continue;
+		case 1:
+			op = args[i];
+			cmd = op & FUTEX_CMD_MASK;
+			if (cmd <= FUTEX_LOCK_PI2)
+				seq_buf_printf(s, ", %s", __futex_cmds[cmd]);
+			else
+				seq_buf_puts(s, ", UNKNOWN");
+
+			if (op & FUTEX_PRIVATE_FLAG)
+				seq_buf_puts(s, "|FUTEX_PRIVATE_FLAG");
+			if (op & FUTEX_CLOCK_REALTIME)
+				seq_buf_puts(s, "|FUTEX_CLOCK_REALTIME");
+			continue;
+		case 3:
+			if (!futex_cmd_has_timeout(cmd)) {
+
+				if (!futex_cmd_has_addr2(cmd)) {
+					done = true;
+					continue;
+				}
+
+				seq_buf_printf(s, ", val2: 0x%x", (u32)(long)args[i]);
+				continue;
+			}
+
+			if (!args[i])
+				continue;
+
+			seq_buf_printf(s, ", timespec: 0x%lx", args[i]);
+			continue;
+		case 4:
+			if (!futex_cmd_has_addr2(cmd)) {
+				done = true;
+				continue;
+			}
+			seq_buf_printf(s, ", uaddr2: 0x%lx", args[i]);
+			continue;
+		case 5:
+			seq_buf_printf(s, ", val3: %lu", args[i]);
+			done = true;
+			continue;
+		}
+	}
+}
+#endif
+
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
  * @futexv:	Kernel side list of waiters to be filled
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 37317b81fcda..8cb3af569157 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -6,11 +6,13 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>	/* for MODULE_NAME_LEN via KSYM_SYMBOL_LEN */
+#include <linux/futex.h>
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
 #include <linux/xarray.h>
 #include <asm/syscall.h>
 
+
 #include "trace_output.h"
 #include "trace.h"
 
@@ -237,6 +239,27 @@ sys_enter_openat_print(struct syscall_trace_enter *trace, struct syscall_metadat
 	return trace_handle_return(s);
 }
 
+static enum print_line_t
+sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata *entry,
+		      struct trace_seq *s, struct trace_event *event, int ent_size)
+{
+	void *end = (void *)trace + ent_size;
+	void *ptr;
+
+	/* Set ptr to the user space copied area */
+	ptr = (void *)trace->args + sizeof(unsigned long) * entry->nb_args;
+	if (ptr + 4 > end)
+		ptr = NULL;
+
+	trace_seq_printf(s, "%s(", entry->name);
+
+	futex_print_syscall(&s->seq, entry->nb_args, trace->args, ptr);
+
+	trace_seq_puts(s, ")\n");
+
+	return trace_handle_return(s);
+}
+
 static enum print_line_t
 print_syscall_enter(struct trace_iterator *iter, int flags,
 		    struct trace_event *event)
@@ -267,6 +290,10 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		if (!tr || !(tr->trace_flags & TRACE_ITER(VERBOSE)))
 			return sys_enter_openat_print(trace, entry, s, event);
 		break;
+	case __NR_futex:
+		if (!tr || !(tr->trace_flags & TRACE_ITER(VERBOSE)))
+			return sys_enter_futex_print(trace, entry, s, event, iter->ent_size);
+		break;
 	default:
 		break;
 	}
@@ -437,6 +464,69 @@ sys_enter_openat_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 	return pos;
 }
 
+static int __init
+sys_enter_futex_print_fmt(struct syscall_metadata *entry, char *buf, int len)
+{
+	int pos = 0;
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"\"uaddr: 0x%%lx (0x%%lx) cmd=%%s%%s%%s");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"  val: 0x%%x timeout/val2: 0x%%llx");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" uaddr2: 0x%%lx val3: 0x%%x\", ");
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" REC->uaddr,");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" REC->__value,");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"  __print_symbolic(REC->op & 0x%x, ", FUTEX_CMD_MASK);
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_WAIT\"}, ", FUTEX_WAIT);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_WAKE\"}, ", FUTEX_WAKE);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_FD\"}, ", FUTEX_FD);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_REQUEUE\"}, ", FUTEX_REQUEUE);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_CMP_REQUEUE\"}, ", FUTEX_CMP_REQUEUE);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_WAKE_OP\"}, ", FUTEX_WAKE_OP);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_LOCK_PI\"}, ", FUTEX_LOCK_PI);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_UNLOCK_PI\"}, ", FUTEX_UNLOCK_PI);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_TRYLOCK_PI\"}, ", FUTEX_TRYLOCK_PI);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_WAIT_BITSET\"}, ", FUTEX_WAIT_BITSET);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_WAKE_BITSET\"}, ", FUTEX_WAKE_BITSET);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_WAIT_REQUEUE_PI\"}, ", FUTEX_WAIT_REQUEUE_PI);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_CMP_REQUEUE_PI\"}, ", FUTEX_CMP_REQUEUE_PI);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{%d, \"FUTEX_LOCK_PI2\"}),", FUTEX_LOCK_PI2);
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" (REC->op & %d) ? \"|FUTEX_PRIVATE_FLAG\" : \"\",",
+			FUTEX_PRIVATE_FLAG);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" (REC->op & %d) ? \"|FUTEX_CLOCK_REALTIME\" : \"\",",
+			FUTEX_CLOCK_REALTIME);
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" REC->val, REC->utime,");
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" REC->uaddr, REC->val3");
+	return pos;
+}
+
 static int __init
 __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 {
@@ -447,6 +537,8 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 	switch (entry->syscall_nr) {
 	case __NR_openat:
 		return sys_enter_openat_print_fmt(entry, buf, len);
+	case __NR_futex:
+		return sys_enter_futex_print_fmt(entry, buf, len);
 	default:
 		break;
 	}
@@ -523,6 +615,21 @@ static void __init free_syscall_print_fmt(struct trace_event_call *call)
 		kfree(call->print_fmt);
 }
 
+static int __init futex_fields(struct trace_event_call *call, int offset)
+{
+	char *arg;
+	int ret;
+
+	arg = kstrdup("__value", GFP_KERNEL);
+	if (WARN_ON_ONCE(!arg))
+		return -ENOMEM;
+	ret = trace_define_field(call, "u32", arg, offset, sizeof(int), 0,
+				 FILTER_OTHER);
+	if (ret)
+		kfree(arg);
+	return ret;
+}
+
 static int __init syscall_enter_define_fields(struct trace_event_call *call)
 {
 	struct syscall_trace_enter trace;
@@ -544,6 +651,9 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 		offset += sizeof(unsigned long);
 	}
 
+	if (!ret && meta->syscall_nr == __NR_futex)
+		return futex_fields(call, offset);
+
 	if (ret || !meta->user_mask)
 		return ret;
 
@@ -689,6 +799,48 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
 	return 0;
 }
 
+static int
+syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf_size)
+{
+	struct syscall_user_buffer *sbuf;
+	const char __user *ptr;
+	char *buf;
+
+	/* buf_size of zero means user doesn't want user space read */
+	if (!buf_size)
+		return -1;
+
+	/* If the syscall_buffer is NULL, tracing is being shutdown */
+	sbuf = READ_ONCE(syscall_buffer);
+	if (!sbuf)
+		return -1;
+
+	ptr = (char __user *)args[0];
+
+	*buffer = trace_user_fault_read(&sbuf->buf, ptr, 4, NULL, NULL);
+	if (!*buffer)
+		return -1;
+
+	/* Add room for the value */
+	*size += 4;
+
+	buf = *buffer;
+
+	return 0;
+}
+
+static void syscall_put_futex(struct syscall_metadata *sys_data,
+			      struct syscall_trace_enter *entry,
+			      char *buffer)
+{
+	u32 *ptr;
+
+	/* Place the futex key into the storage */
+	ptr = (void *)entry->args + sizeof(unsigned long) * sys_data->nb_args;
+
+	*ptr = *(u32 *)buffer;
+}
+
 static char *sys_fault_user(unsigned int buf_size,
 			    struct syscall_metadata *sys_data,
 			    struct syscall_user_buffer *sbuf,
@@ -905,6 +1057,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 		if (syscall_get_data(sys_data, args, &user_ptr,
 				     &size, user_sizes, &uargs, tr->syscall_buf_sz) < 0)
 			return;
+	} else if (syscall_nr == __NR_futex) {
+		if (syscall_get_futex(args, &user_ptr, &size, tr->syscall_buf_sz) < 0)
+			return;
 	}
 
 	size += sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
@@ -921,6 +1076,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	if (mayfault)
 		syscall_put_data(sys_data, entry, user_ptr, size, user_sizes, uargs);
 
+	else if (syscall_nr == __NR_futex)
+		syscall_put_futex(sys_data, entry, user_ptr);
+
 	trace_event_buffer_commit(&fbuffer);
 }
 
@@ -971,14 +1129,18 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
 {
 	struct syscall_metadata *sys_data = call->data;
 	struct trace_array *tr = file->tr;
+	bool enable_faults;
 	int ret = 0;
 	int num;
 
 	num = sys_data->syscall_nr;
 	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return -ENOSYS;
+
+	enable_faults = sys_data->user_mask || num == __NR_futex;
+
 	guard(mutex)(&syscall_trace_lock);
-	if (sys_data->user_mask) {
+	if (enable_faults) {
 		ret = syscall_fault_buffer_enable();
 		if (ret < 0)
 			return ret;
@@ -986,7 +1148,7 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
 	if (!tr->sys_refcount_enter) {
 		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
 		if (ret < 0) {
-			if (sys_data->user_mask)
+			if (enable_faults)
 				syscall_fault_buffer_disable();
 			return ret;
 		}
@@ -1011,7 +1173,7 @@ static void unreg_event_syscall_enter(struct trace_event_file *file,
 	WRITE_ONCE(tr->enter_syscall_files[num], NULL);
 	if (!tr->sys_refcount_enter)
 		unregister_trace_sys_enter(ftrace_syscall_enter, tr);
-	if (sys_data->user_mask)
+	if (sys_data->user_mask || num == __NR_futex)
 		syscall_fault_buffer_disable();
 }
 
-- 
2.51.0


