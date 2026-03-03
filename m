Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EF3D6CD0;
	Tue,  3 Mar 2026 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574548; cv=none; b=FRCE+ePlei0RW+SouUewIaVA85C2Ps2GtuoLVyY43xQmtOzR021dwqwC9DSkoL1G7mcEg2QzwYuDJbNQPXOOcZ+uBKd2VhEGcVSzUmc97OOMCCj2yKIFdS80KVNmLJW5ya3GNlgibTguEjmCuOXyv+TUuCRW9CFqhadEkV9ZcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574548; c=relaxed/simple;
	bh=2O18WCD7nVs8vUnPwUpgTth3IEgvnga+ovswvO2RXro=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=D37zTliGENTmbO+mrjn0eUmcU+Dxqv/Ptv/eaWMV4ipOFB+DiENCCA9LjoObUQKZOrSSIkId9v8enjtwFoxX7rrevGc33oMyR7U8JXuai0m/jPU+wbXaNrRc7aw8JRMazQd5SG93y6iLLlgF32ryo4qygTGkb9ZXjDSsVsujzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJjojWng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJjojWng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87645C19425;
	Tue,  3 Mar 2026 21:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574547;
	bh=2O18WCD7nVs8vUnPwUpgTth3IEgvnga+ovswvO2RXro=;
	h=Date:From:To:Cc:Subject:References:From;
	b=AJjojWng1Td+NviD4/KI7t2XdIcBYtTkGF9TBU6hIjmpwxURIBS5p3X34y4kLKbxk
	 WE2AOVIbpgc6sQJFXA9PrM4gZXvNt7di29OZmHOu92qgY+lpktdn9REL1K45+3/fW5
	 mzj5z/MZhkBDR+uVkFDE7w9Wgv0itckwSVx+/MjsQtraVM795Ij6mJjwzI+IZixBIj
	 MpS++vSCC1AOcqKZ03+JsntMfzv3y6y9EM+2uuvtQINRwPLxhtMndKEV8OwWI/dcVs
	 4dZJhoA/WUhpIi5LrdkF37AffsFZknniy4l9wmRkvtZAJxqCcxkjfPo8OZGYqVFeNJ
	 gwc996sk+iSAQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vxXcc-00000002tlD-2OHc;
	Tue, 03 Mar 2026 16:49:42 -0500
Message-ID: <20260303214942.428502100@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 03 Mar 2026 16:47:36 -0500
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
Subject: [PATCH 1/2] tracing: Have futex syscall trace event show specific user data
References: <20260303214735.002154462@kernel.org>
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
 kernel/trace/trace_syscalls.c | 266 +++++++++++++++++++++++++++++++++-
 1 file changed, 263 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e96d0063cbcf..bc60a0497bcc 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -11,6 +11,8 @@
 #include <linux/xarray.h>
 #include <asm/syscall.h>
 
+#include <uapi/linux/futex.h>
+
 #include "trace_output.h"
 #include "trace.h"
 
@@ -237,6 +239,125 @@ sys_enter_openat_print(struct syscall_trace_enter *trace, struct syscall_metadat
 	return trace_handle_return(s);
 }
 
+static const char * __futex_cmds[] =
+{
+	"FUTEX_WAIT", "FUTEX_WAKE", "FUTEX_FD", "FUTEX_REQUEUE",
+	"FUTEX_CMP_REQUEUE", "FUTEX_WAKE_OP", "FUTEX_LOCK_PI",
+	"FUTEX_UNLOCK_PI", "FUTEX_TRYLOCK_PI", "FUTEX_WAIT_BITSET",
+	"FUTEX_WAKE_BITSET", "FUTEX_WAIT_REQUEUE_PI", "FUTEX_CMP_REQUEUE_PI",
+	"FUTEX_LOCK_PI2", };
+
+/* From futex/syscalls.c */
+static __always_inline bool futex_cmd_has_timeout(u32 cmd)
+{
+	switch (cmd) {
+	case FUTEX_WAIT:
+	case FUTEX_LOCK_PI:
+	case FUTEX_LOCK_PI2:
+	case FUTEX_WAIT_BITSET:
+	case FUTEX_WAIT_REQUEUE_PI:
+		return true;
+	}
+	return false;
+}
+
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
+static enum print_line_t
+sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata *entry,
+		      struct trace_seq *s, struct trace_event *event, int ent_size)
+{
+	bool done = false;
+	unsigned int op, cmd;
+	void *end = (void *)trace + ent_size;
+	void *ptr;
+	int i;
+
+	/* Set ptr to the user space copied area */
+	ptr = (void *)trace->args + sizeof(unsigned long) * entry->nb_args;
+	if (ptr + 4 > end)
+		ptr = NULL;
+
+	trace_seq_printf(s, "%s(", entry->name);
+
+	for (i = 0; !done && i < entry->nb_args; i++) {
+
+		if (trace_seq_has_overflowed(s))
+			goto end;
+
+		switch (i) {
+		case 0:
+			trace_seq_printf(s, "uaddr: 0x%lx", trace->args[i]);
+			if (ptr) {
+				u32 val = *(u32 *)ptr;
+				if (val < 10)
+					trace_seq_printf(s, " (%u)", val);
+				else
+					trace_seq_printf(s, " (0x%x)", val);
+			}
+			continue;
+		case 1:
+			op = trace->args[i];
+			cmd = op & FUTEX_CMD_MASK;
+			if (cmd <= FUTEX_LOCK_PI2)
+				trace_seq_printf(s, ", %s", __futex_cmds[cmd]);
+			else
+				trace_seq_puts(s, ", UNKNOWN");
+
+			if (op & FUTEX_PRIVATE_FLAG)
+				trace_seq_puts(s, "|FUTEX_PRIVATE_FLAG");
+			if (op & FUTEX_CLOCK_REALTIME)
+				trace_seq_puts(s, "|FUTEX_CLOCK_REALTIME");
+			continue;
+		case 3:
+			if (!futex_cmd_has_timeout(cmd)) {
+
+				if (!futex_cmd_has_addr2(cmd)) {
+					done = true;
+					continue;
+				}
+
+				trace_seq_printf(s, ", val2: 0x%x",
+						 (u32)(long)trace->args[i]);
+				continue;
+			}
+
+			if (!trace->args[i])
+				continue;
+
+			trace_seq_printf(s, ", timespec: 0x%lx",
+					 trace->args[i]);
+
+			continue;
+
+		case 4:
+			if (!futex_cmd_has_addr2(cmd)) {
+				done = true;
+				continue;
+			}
+			trace_seq_printf(s, ", uaddr2: 0x%lx", trace->args[i]);
+		}
+
+		trace_seq_printf(s, ", %s: %lu", entry->args[i],
+				 trace->args[i]);
+	}
+	trace_seq_putc(s, ')');
+end:
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
 static enum print_line_t
 print_syscall_enter(struct trace_iterator *iter, int flags,
 		    struct trace_event *event)
@@ -267,6 +388,10 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
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
@@ -437,6 +562,69 @@ sys_enter_openat_print_fmt(struct syscall_metadata *entry, char *buf, int len)
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
@@ -447,6 +635,8 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 	switch (entry->syscall_nr) {
 	case __NR_openat:
 		return sys_enter_openat_print_fmt(entry, buf, len);
+	case __NR_futex:
+		return sys_enter_futex_print_fmt(entry, buf, len);
 	default:
 		break;
 	}
@@ -523,6 +713,21 @@ static void __init free_syscall_print_fmt(struct trace_event_call *call)
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
@@ -544,6 +749,9 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 		offset += sizeof(unsigned long);
 	}
 
+	if (!ret && meta->syscall_nr == __NR_futex)
+		return futex_fields(call, offset);
+
 	if (ret || !meta->user_mask)
 		return ret;
 
@@ -689,6 +897,48 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
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
@@ -905,6 +1155,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 		if (syscall_get_data(sys_data, args, &user_ptr,
 				     &size, user_sizes, &uargs, tr->syscall_buf_sz) < 0)
 			return;
+	} else if (syscall_nr == __NR_futex) {
+		if (syscall_get_futex(args, &user_ptr, &size, tr->syscall_buf_sz) < 0)
+			return;
 	}
 
 	size += sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
@@ -921,6 +1174,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	if (mayfault)
 		syscall_put_data(sys_data, entry, user_ptr, size, user_sizes, uargs);
 
+	else if (syscall_nr == __NR_futex)
+		syscall_put_futex(sys_data, entry, user_ptr);
+
 	trace_event_buffer_commit(&fbuffer);
 }
 
@@ -971,14 +1227,18 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
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
@@ -986,7 +1246,7 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
 	if (!tr->sys_refcount_enter) {
 		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
 		if (ret < 0) {
-			if (sys_data->user_mask)
+			if (enable_faults)
 				syscall_fault_buffer_disable();
 			return ret;
 		}
@@ -1011,7 +1271,7 @@ static void unreg_event_syscall_enter(struct trace_event_file *file,
 	WRITE_ONCE(tr->enter_syscall_files[num], NULL);
 	if (!tr->sys_refcount_enter)
 		unregister_trace_sys_enter(ftrace_syscall_enter, tr);
-	if (sys_data->user_mask)
+	if (sys_data->user_mask || num == __NR_futex)
 		syscall_fault_buffer_disable();
 }
 
-- 
2.51.0


