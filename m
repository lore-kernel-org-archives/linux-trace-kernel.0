Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094544CF59;
	Tue, 31 Mar 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980815; cv=none; b=Q6nRLQaQWuGpr840+08YmkxVgT30Joifa+S6mdQU1bhzMPwT6etWsW6B3KEASSPwhaPdUI0RaybNXSIaBv+HnsNvB67KWkZ5lpTE4V2PaKu5mXqxLIp7Bf7+AYsplSkI2lKrGBOcMidCqXoVIjYq3UYH0/4RkYwNHiKOxtCunV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980815; c=relaxed/simple;
	bh=K6u0PspPsS0IqE8W/Ttx61OZoVKvYhh4U0f4jYfu35M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KQaOAvkm/0Hjfga0Jc+a1DpcwwdzrlsFdGr934kCqcUOLh9M1DVs4HmE/+2r1hkrPXOpt3YmhvvghWLOyOuFEcxEgRx77MGvlRUlylUqK4cYSWTCooX2o2dwwYR7h4J7XUqMikuAZrK6c0DwlRtspk5iAZ8YMiqFgcdiBwjPBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRFziVgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRFziVgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90570C2BCB3;
	Tue, 31 Mar 2026 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774980814;
	bh=K6u0PspPsS0IqE8W/Ttx61OZoVKvYhh4U0f4jYfu35M=;
	h=Date:From:To:Cc:Subject:References:From;
	b=oRFziVgvjRLjw3/Ebt7UIyKv/95MMu6F/DNYRfa8z5F2ESaZZ+DpWa5WrC7v839ZH
	 +aCH5mYX9JVInXdvRw0lsuJGWe9+X+Q+m61n6bVkF8KUl4wePsMHIFqai4qhjC/IgC
	 QHc8WcSPHuJ4R0l+AgRrFWcJvWfwjQpWnjK8vyRkg52H2IeHp+VqAgeJpKIvgUDh47
	 +ZyCRRFf85As4WoTjdrK/P1wlM0rj0EUp+48hKpBsP+ZW/2qjUX84/BkeD/F4x/S+K
	 MuEUG/bI2v6B7uTSbYD11Pxe3zVmY+NIpg/nev4+SIWP1l8skVUEZUtan3To7a3fAz
	 dyvjyc/EMTOAw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w7dbl-0000000H8ta-1DQo;
	Tue, 31 Mar 2026 14:14:33 -0400
Message-ID: <20260331181433.153334366@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 31 Mar 2026 14:13:51 -0400
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
Subject: [PATCH v3 2/3] tracing: Update futex syscall trace event to show more commands
References: <20260331181349.062575155@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Make the futex syscall trace event a little more smart. Have it read the
futex_op instruction to determine what else it can save and print. For the
appropriate options, it will read the utime (timespec) parameter and show
its output as well as the uaddr2.

 futex_requeue_p-1154    [004] .....   144.568339: sys_futex(uaddr: 0x5652b178d834 (0x482), FUTEX_UNLOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
 futex_requeue_p-1162    [002] .....   144.568696: sys_futex(uaddr: 0x7f763b7fece0 (2), FUTEX_WAIT|FUTEX_PRIVATE_FLAG, val: 2)
 futex_requeue_p-1151    [000] .....   144.568700: sys_futex(uaddr: 0x7f763b7fece0 (0), FUTEX_WAKE|FUTEX_PRIVATE_FLAG, val: 1)
 futex_requeue_p-1162    [002] .....   144.568705: sys_futex(uaddr: 0x7f763b7fece0 (0), FUTEX_WAKE|FUTEX_PRIVATE_FLAG, val: 1)
 futex_requeue_p-1151    [000] .....   144.568715: sys_futex(uaddr: 0x7f764369e990 (0x483), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, val: 1155)
 futex_requeue_p-1155    [005] .....   144.569420: sys_futex(uaddr: 0x5652b178d838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: 0x7ffdacfba500 (143.890024054), uaddr2: 0x5652b178d834 (0), val3: 0)
 futex_requeue_p-1155    [005] .....   144.569454: sys_futex(uaddr: 0x5652b178d834 (0), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/futex.h         |  35 ++++++++-
 kernel/futex/syscalls.c       |  48 ++++++-------
 kernel/trace/trace_syscalls.c | 129 +++++++++++++++++++++++++++++-----
 3 files changed, 164 insertions(+), 48 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 7eaf01ff68cf..ec0d9cfa8a59 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -82,8 +82,35 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
 
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
 #ifdef CONFIG_FTRACE_SYSCALLS
-void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args, u32 *ptr);
+void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args,
+			 u32 *ptr1, u32 *ptr2, unsigned long *ts1,
+			 unsigned long *ts2);
 extern const char * __futex_cmds[];
 #endif
 
@@ -120,7 +147,11 @@ static inline int futex_hash_allocate_default(void)
 static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
 static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
 static inline void futex_print_syscall(struct seq_buf *s, int nr_args,
-				       unsigned long *args, u32 *ptr) { }
+				       unsigned long *args, u32 *ptr1,
+				       u32 *ptr2, unsigned long *ts1,
+				       unsigned long *ts2) { }
+static __always_inline bool futex_cmd_has_timeout(u32 cmd) { return false; }
+static __always_inline bool futex_cmd_has_addr2(u32 cmd) { return false; }
 #endif
 
 #endif
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 3ba8ca017c9c..265ec0a236d0 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -158,31 +158,6 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	return -ENOSYS;
 }
 
-static __always_inline bool futex_cmd_has_timeout(u32 cmd)
-{
-	switch (cmd) {
-	case FUTEX_WAIT:
-	case FUTEX_LOCK_PI:
-	case FUTEX_LOCK_PI2:
-	case FUTEX_WAIT_BITSET:
-	case FUTEX_WAIT_REQUEUE_PI:
-		return true;
-	}
-	return false;
-}
-
-static __always_inline bool futex_cmd_has_addr2(u32 cmd)
-{
-	switch (cmd) {
-	case FUTEX_REQUEUE:
-	case FUTEX_CMP_REQUEUE:
-	case FUTEX_WAKE_OP:
-	case FUTEX_WAIT_REQUEUE_PI:
-		return true;
-	}
-	return false;
-}
-
 static __always_inline int
 futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
 {
@@ -231,7 +206,9 @@ const char * __futex_cmds[] =
 	"FUTEX_LOCK_PI2", NULL
 };
 
-void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args, u32 *ptr)
+void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args,
+			 u32 *ptr1, u32 *ptr2, unsigned long *ts1,
+			 unsigned long *ts2)
 {
 	unsigned int op, cmd;
 	bool done = false;
@@ -244,8 +221,8 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args, u3
 		switch (i) {
 		case 0:
 			seq_buf_printf(s, "uaddr: 0x%lx", args[i]);
-			if (ptr) {
-				u32 val = *ptr;
+			if (ptr1) {
+				u32 val = *ptr1;
 				if (val < 10)
 					seq_buf_printf(s, " (%u)", val);
 				else
@@ -287,6 +264,15 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args, u3
 				continue;
 
 			seq_buf_printf(s, ", timespec: 0x%lx", args[i]);
+
+			if (!ts1 || !ts2)
+				continue;
+
+			if (!*ts1 && !*ts2) {
+				seq_buf_puts(s, " (0)");
+				continue;
+			}
+			seq_buf_printf(s, " (%lu.%09lu)", *ts1, *ts2);
 			continue;
 		case 4:
 			if (!futex_cmd_has_addr2(cmd)) {
@@ -294,6 +280,12 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args, u3
 				continue;
 			}
 			seq_buf_printf(s, ", uaddr2: 0x%lx", args[i]);
+
+			if (!ptr2)
+				continue;
+
+			seq_buf_printf(s, " (%x)", *ptr2);
+
 			continue;
 		case 5:
 			seq_buf_printf(s, ", val3: %lu", args[i]);
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f8213d772f89..0c86986ec7c4 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -239,21 +239,35 @@ sys_enter_openat_print(struct syscall_trace_enter *trace, struct syscall_metadat
 	return trace_handle_return(s);
 }
 
+struct futex_data {
+	u32		val1;
+	u32		val2;
+	unsigned long	ts1;
+	unsigned long	ts2;
+};
+
 static enum print_line_t
 sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata *entry,
 		      struct trace_seq *s, struct trace_event *event, int ent_size)
 {
+	struct futex_data *data;
 	void *end = (void *)trace + ent_size;
-	void *ptr;
+	unsigned long *ts1 = NULL, *ts2 = NULL;
+	u32 *ptr1 = NULL, *ptr2 = NULL;
 
 	/* Set ptr to the user space copied area */
-	ptr = (void *)trace->args + sizeof(unsigned long) * entry->nb_args;
-	if (ptr + 4 > end)
-		ptr = NULL;
+	data = (void *)trace->args + sizeof(unsigned long) * entry->nb_args;
+	if ((void *)data + sizeof(*data) <= end) {
+		ptr1 = &data->val1;
+		ptr2 = &data->val2;
+		ts1 = &data->ts1;
+		ts2 = &data->ts2;
+	}
 
 	trace_seq_printf(s, "%s(", entry->name);
 
-	futex_print_syscall(&s->seq, entry->nb_args, trace->args, ptr);
+	futex_print_syscall(&s->seq, entry->nb_args, trace->args, ptr1, ptr2,
+			    ts1, ts2);
 
 	trace_seq_puts(s, ")\n");
 
@@ -472,9 +486,9 @@ sys_enter_futex_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 	pos += snprintf(buf + pos, LEN_OR_ZERO,
 			"\"uaddr: 0x%%lx (0x%%lx) cmd=%%s%%s%%s");
 	pos += snprintf(buf + pos, LEN_OR_ZERO,
-			"  val: 0x%%x timeout/val2: 0x%%llx");
+			"  val: 0x%%x timeout/val2: 0x%%llx (%%lu.%%lu)");
 	pos += snprintf(buf + pos, LEN_OR_ZERO,
-			" uaddr2: 0x%%lx val3: 0x%%x\", ");
+			" uaddr2: 0x%%lx (0x%%lx) val3: 0x%%x\", ");
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO,
 			" REC->uaddr,");
@@ -499,10 +513,12 @@ sys_enter_futex_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 			FUTEX_CLOCK_REALTIME);
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO,
-			" REC->val, REC->utime,");
+			" REC->val, REC->utime, REC->__ts1, REC->__ts2,");
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO,
-			" REC->uaddr, REC->val3");
+			" REC->uaddr,");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" REC->__value2, REC->val3");
 	return pos;
 }
 
@@ -605,7 +621,39 @@ static int __init futex_fields(struct trace_event_call *call, int offset)
 	ret = trace_define_field(call, "u32", arg, offset, sizeof(int), 0,
 				 FILTER_OTHER);
 	if (ret)
-		kfree(arg);
+		goto free;
+	offset += sizeof(int);
+
+	arg = kstrdup("__value2", GFP_KERNEL);
+	if (WARN_ON_ONCE(!arg))
+		return -ENOMEM;
+	ret = trace_define_field(call, "u32", arg, offset, sizeof(int), 0,
+				 FILTER_OTHER);
+	if (ret)
+		goto free;
+	offset += sizeof(int);
+
+	arg = kstrdup("__ts1", GFP_KERNEL);
+	if (WARN_ON_ONCE(!arg))
+		return -ENOMEM;
+	ret = trace_define_field(call, "unsigned long", arg, offset,
+				 sizeof(unsigned long), 0, FILTER_OTHER);
+	if (ret)
+		goto free;
+	offset += sizeof(long);
+
+	arg = kstrdup("__ts2", GFP_KERNEL);
+	if (WARN_ON_ONCE(!arg))
+		return -ENOMEM;
+	ret = trace_define_field(call, "unsigned long", arg, offset,
+				 sizeof(unsigned long), 0, FILTER_OTHER);
+	if (ret)
+		goto free;
+
+	return 0;
+
+free:
+	kfree(arg);
 	return ret;
 }
 
@@ -778,11 +826,51 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
 	return 0;
 }
 
+struct tp_futex_data {
+	u32			cmd;
+	const u32		__user *val1;
+	const u32 		__user *val2;
+	void			__user *timeout;
+};
+
+static int syscall_copy_futex(char *buf, const char __user *ptr,
+			      size_t size, void *data)
+{
+	struct tp_futex_data *tp_data = data;
+	struct futex_data *fdata = (void *)buf;
+	int cmd = tp_data->cmd & FUTEX_CMD_MASK;
+	int ret;
+
+	memset(fdata, 0, sizeof(*fdata));
+
+	if (tp_data->val1) {
+		ret = __copy_from_user(&fdata->val1, tp_data->val1, 4);
+		if (ret)
+			return -1;
+	}
+
+	if (tp_data->val2 && futex_cmd_has_addr2(cmd)) {
+		ret = __copy_from_user(&fdata->val2, tp_data->val2, 4);
+		if (ret)
+			return -1;
+	}
+
+	if (tp_data->timeout && futex_cmd_has_timeout(cmd)) {
+		/* Copies both ts1 and ts2 */
+		ret = __copy_from_user(&fdata->ts1, tp_data->timeout,
+				       sizeof(long) * 2);
+		if (ret)
+			return -1;
+	}
+
+	return 0;
+}
+
 static int
 syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf_size)
 {
 	struct syscall_user_buffer *sbuf;
-	const char __user *ptr;
+	struct tp_futex_data tp_data;
 
 	/* buf_size of zero means user doesn't want user space read */
 	if (!buf_size)
@@ -793,14 +881,18 @@ syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf_size)
 	if (!sbuf)
 		return -1;
 
-	ptr = (char __user *)args[0];
+	tp_data.cmd = args[1];
+	tp_data.val1 = (u32 __user *)args[0];
+	tp_data.val2 = (u32 __user *)args[4];
+	tp_data.timeout = (u64 __user *)args[3];
 
-	*buffer = trace_user_fault_read(&sbuf->buf, ptr, 4, NULL, NULL);
+	*buffer = trace_user_fault_read(&sbuf->buf, NULL, 0,
+					syscall_copy_futex, &tp_data);
 	if (!*buffer)
 		return -1;
 
-	/* Add room for the value */
-	*size += 4;
+	/* Add room for values */
+	*size += sizeof(struct futex_data);
 
 	return 0;
 }
@@ -809,12 +901,13 @@ static void syscall_put_futex(struct syscall_metadata *sys_data,
 			      struct syscall_trace_enter *entry,
 			      char *buffer)
 {
-	u32 *ptr;
+	struct futex_data *fdata = (void *)buffer;
+	struct futex_data *data;
 
 	/* Place the futex key into the storage */
-	ptr = (void *)entry->args + sizeof(unsigned long) * sys_data->nb_args;
+	data = (void *)entry->args + sizeof(unsigned long) * sys_data->nb_args;
 
-	*ptr = *(u32 *)buffer;
+	*data = *fdata;
 }
 
 static char *sys_fault_user(unsigned int buf_size,
-- 
2.51.0


