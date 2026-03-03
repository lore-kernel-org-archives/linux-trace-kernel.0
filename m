Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59119379EE0;
	Tue,  3 Mar 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574548; cv=none; b=kFnYZR+175Cb0qfZTsuVd9RNYSPRSVMSh7zb5mijx9c0Ha5hIO0GaFQKQMekZOXDsKi0In5bGd9NGkMg9gM6e/fWZhu+x+PxSuP+qZIg4sJrpRJgW1VcNomYmnGo303vqykIPUtljtzSD21WKPtaNmCz8jcL9ADeM1XGjGHPv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574548; c=relaxed/simple;
	bh=5sPfSnHFUqU/XesMMQKQat8eiF520UxlVhfmd26L8ZQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UrXx32+27YjQTOjZRBmroCuewE5s/B1aOYjLSfv5mFNhuaz2XKb0qfzOq5QXpbEuxsS1CiZGe+AwHKxqHgtfgLzVekcH4dfsE0X+pGA0buOdDCBlhcnd8L8Mmcpf97hmaNFlPit6M8g+S6z4IYKBsr58gn0RXQ1lIgyt2M1NPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OByp72Nt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OByp72Nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E63C2BCB0;
	Tue,  3 Mar 2026 21:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574547;
	bh=5sPfSnHFUqU/XesMMQKQat8eiF520UxlVhfmd26L8ZQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=OByp72NtYygps+BjIpC8rNF7PmgfTDl4/NOFesxwHjhnH6wDK6xikQ4ezTuUIEBy8
	 W7Slb+/58G/pfA7jU1B63JqbWdQfXRROGF4WFGPwGbRXukZcqeYZDV2/mmWQk+8T5/
	 OzfrKZhuLd4xY6mRRuOgYXxLXtrOwlDitrjYNbZaMjpuaDJBmgkkOD+59zQMyPP18O
	 Pu+rwDbDMUGNSMh+axfmFVq9ld0aRgJmprFk0F2D7uvG21fDEOClVMj0YFJk3HSY1c
	 vuFeCmcdo6cdCZAeINZnWy80gmMOLGT17aoYE41rkUnF3kPgdZGkNyyW64rpkdrBvq
	 d7110xAXLrHVg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vxXcc-00000002tm4-3H2Z;
	Tue, 03 Mar 2026 16:49:42 -0500
Message-ID: <20260303214942.587739736@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 03 Mar 2026 16:47:37 -0500
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
Subject: [PATCH 2/2] tracing: Update futex syscall trace event to show more commands
References: <20260303214735.002154462@kernel.org>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 138 +++++++++++++++++++++++++++++-----
 1 file changed, 121 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index bc60a0497bcc..d128dcb218a7 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -273,10 +273,18 @@ static __always_inline bool futex_cmd_has_addr2(u32 cmd)
 	return false;
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
 	bool done = false;
 	unsigned int op, cmd;
 	void *end = (void *)trace + ent_size;
@@ -285,8 +293,10 @@ sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata
 
 	/* Set ptr to the user space copied area */
 	ptr = (void *)trace->args + sizeof(unsigned long) * entry->nb_args;
-	if (ptr + 4 > end)
-		ptr = NULL;
+	if (ptr + sizeof(*data) > end)
+		data = NULL;
+	else
+		data = ptr;
 
 	trace_seq_printf(s, "%s(", entry->name);
 
@@ -298,8 +308,8 @@ sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata
 		switch (i) {
 		case 0:
 			trace_seq_printf(s, "uaddr: 0x%lx", trace->args[i]);
-			if (ptr) {
-				u32 val = *(u32 *)ptr;
+			if (data) {
+				u32 val = data->val1;
 				if (val < 10)
 					trace_seq_printf(s, " (%u)", val);
 				else
@@ -338,6 +348,15 @@ sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata
 			trace_seq_printf(s, ", timespec: 0x%lx",
 					 trace->args[i]);
 
+			if (!data)
+				continue;
+
+			if (!data->ts1 && !data->ts2) {
+				trace_seq_puts(s, " (0)");
+				continue;
+			}
+			trace_seq_printf(s, " (%lu.%09lu)",
+					 data->ts1, data->ts2);
 			continue;
 
 		case 4:
@@ -346,6 +365,12 @@ sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata
 				continue;
 			}
 			trace_seq_printf(s, ", uaddr2: 0x%lx", trace->args[i]);
+
+			if (!data)
+				continue;
+
+			trace_seq_printf(s, " (%x)", data->val2);
+			continue;
 		}
 
 		trace_seq_printf(s, ", %s: %lu", entry->args[i],
@@ -570,9 +595,9 @@ sys_enter_futex_print_fmt(struct syscall_metadata *entry, char *buf, int len)
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
@@ -618,10 +643,12 @@ sys_enter_futex_print_fmt(struct syscall_metadata *entry, char *buf, int len)
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
 
@@ -724,7 +751,39 @@ static int __init futex_fields(struct trace_event_call *call, int offset)
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
 
@@ -897,11 +956,51 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
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
 	char *buf;
 
 	/* buf_size of zero means user doesn't want user space read */
@@ -913,14 +1012,18 @@ syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf_size)
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
 
 	buf = *buffer;
 
@@ -931,12 +1034,13 @@ static void syscall_put_futex(struct syscall_metadata *sys_data,
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


