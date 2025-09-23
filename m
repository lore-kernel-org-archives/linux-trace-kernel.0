Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D7324B06;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632754; cv=none; b=S8fxYD2CWLCIt4qekP41ndoBpdteUPRUytAlB0nbuNO1vMugGAB1r5EBK1OOKqMinLTHg5jesegp6AuDw262MABOKH4q8ys3vG/AKfamGGWSSkzPnIPF/Wojfw/vMVxaebjeZrkA7kyCpwnZHO6qW2z4SpXqF0tQvMXZOLBdGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632754; c=relaxed/simple;
	bh=VKA2yJYweWElPnAZodk8sAgNvirHzx1QCF7wG5bI2Zg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dlQ5DZ5tiwJirHTZw5jgcOF3tCJZ/s9yc+psZHZZPUtG7kHZBiwOcD0r1+zIZAO1YssAAD9BSP8JD6cVoX5Kbnd5L66ZEK1nw1eTaKhQuh+JCCsD8d9/GzpU6JTtW7Y/PK+EcveHdo6uL7fSD2JxirfNtl8Pwk1Og8Bo+FJfbyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwwiMQvu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwwiMQvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B448C19422;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632754;
	bh=VKA2yJYweWElPnAZodk8sAgNvirHzx1QCF7wG5bI2Zg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=bwwiMQvuREY68BR2iJn9BeuDEub6TKUks4tCZWUyXcbinByckr1DX8iJ5b09YyktF
	 okK/mlYgsa4hJtrRflGjcyC8XYeyOWe9BI+pTAZB25P/67QtWGNCvhPc123Yr71adI
	 pqei9oUTCzIXMENlaQNm3TkbHKwSmFYq9s6bRJ9kefKO1kMFdEs16aHxlckxWHGP+c
	 rW3f4xJ8Qy7p+a+38aFz1MCFPsxQa+r8K13U0epyvIPArhncZVaIOnddG/63sUYHq9
	 x+3KCu7Njb6DdP315BVtddBb/zosKai2FgOKIQacfRbgQK2+PpsZorc4H899hsJQ0B
	 Yz0pWmDGjhK9Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v12ji-0000000Coqd-11hK;
	Tue, 23 Sep 2025 09:07:14 -0400
Message-ID: <20250923130714.101202613@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 23 Sep 2025 09:05:01 -0400
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
Subject: [PATCH v2 4/8] tracing: Have system call events record user array data
References: <20250923130457.901085554@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

For system call events that have a length field, add a "user_arg_size"
parameter to the system call meta data that denotes the index of the args
array that holds the size of arg that the user_mask field has a bit set
for.

The "user_mask" has a bit set that denotes the arg that points to an array
in the user space address space and if a system call event has the
user_mask field set and the user_arg_size set, it will then record the
content of that address into the trace event, up to the size defined by
SYSCALL_FAULT_BUF_SZ - 1.

This allows the output to look like:

  sys_write(fd: 0xa, buf: 0x5646978d13c0 (01:00:05:00:00:00:00:00:01:87:55:89:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00), count: 0x20)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/syscall.h       |   4 +-
 kernel/trace/trace_syscalls.c | 111 +++++++++++++++++++++++++---------
 2 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 85f21ca15a41..9413c139da66 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -16,6 +16,7 @@
  * @name: name of the syscall
  * @syscall_nr: number of the syscall
  * @nb_args: number of parameters it takes
+ * @user_arg_size: holds @arg that has size of the user space to read
  * @user_mask: mask of @args that will read user space
  * @types: list of types as strings
  * @args: list of args as strings (args[i] matches types[i])
@@ -26,7 +27,8 @@
 struct syscall_metadata {
 	const char	*name;
 	int		syscall_nr;
-	short		nb_args;
+	u8		nb_args;
+	s8		user_arg_size;
 	short		user_mask;
 	const char	**types;
 	const char	**args;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 7ea763c07bb7..7658b592c55f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -124,7 +124,7 @@ const char *get_syscall_name(int syscall)
 	return entry->name;
 }
 
-/* Added to user strings when max limit is reached */
+/* Added to user strings or arrays when max limit is reached */
 #define EXTRA "..."
 
 static enum print_line_t
@@ -136,9 +136,8 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	struct trace_entry *ent = iter->ent;
 	struct syscall_trace_enter *trace;
 	struct syscall_metadata *entry;
-	int i, syscall, val;
+	int i, syscall, val, len;
 	unsigned char *ptr;
-	int len;
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
@@ -185,7 +184,23 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		ptr = (void *)ent + (val & 0xffff);
 		len = val >> 16;
 
-		trace_seq_printf(s, " \"%.*s\"", len, ptr);
+		if (entry->user_arg_size < 0) {
+			trace_seq_printf(s, " \"%.*s\"", len, ptr);
+			continue;
+		}
+
+		val = trace->args[entry->user_arg_size];
+
+		trace_seq_puts(s, " (");
+		for (int x = 0; x < len; x++, ptr++) {
+			if (x)
+				trace_seq_putc(s, ':');
+			trace_seq_printf(s, "%02x", *ptr);
+		}
+		if (len < val)
+			trace_seq_printf(s, ", %s", EXTRA);
+
+		trace_seq_putc(s, ')');
 	}
 
 	trace_seq_putc(s, ')');
@@ -250,8 +265,11 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 		if (!(BIT(i) & entry->user_mask))
 			continue;
 
-		/* Add the format for the user space string */
-		pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
+		/* Add the format for the user space string or array */
+		if (entry->user_arg_size < 0)
+			pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
+		else
+			pos += snprintf(buf + pos, LEN_OR_ZERO, " (%%s)");
 	}
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
@@ -260,9 +278,14 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 				", ((unsigned long)(REC->%s))", entry->args[i]);
 		if (!(BIT(i) & entry->user_mask))
 			continue;
-		/* The user space string for arg has name __<arg>_val */
-		pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
-				entry->args[i]);
+		/* The user space data for arg has name __<arg>_val */
+		if (entry->user_arg_size < 0) {
+			pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
+					entry->args[i]);
+		} else {
+			pos += snprintf(buf + pos, LEN_OR_ZERO, ", __print_dynamic_array(__%s_val, 1)",
+					entry->args[i]);
+		}
 	}
 
 #undef LEN_OR_ZERO
@@ -333,9 +356,9 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 	idx = ffs(mask) - 1;
 
 	/*
-	 * User space strings are faulted into a temporary buffer and then
-	 * added as a dynamic string to the end of the event.
-	 * The user space string name for the arg pointer is "__<arg>_val".
+	 * User space data is faulted into a temporary buffer and then
+	 * added as a dynamic string or array to the end of the event.
+	 * The user space data name for the arg pointer is "__<arg>_val".
 	 */
 	len = strlen(meta->args[idx]) + sizeof("___val");
 	arg = kmalloc(len, GFP_KERNEL);
@@ -458,6 +481,7 @@ static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_bu
 	unsigned long mask = sys_data->user_mask;
 	unsigned int cnt;
 	int idx = ffs(mask) - 1;
+	bool array = false;
 	char *ptr;
 	int trys = 0;
 	int ret;
@@ -500,6 +524,18 @@ static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_bu
 	/* Read the current CPU context switch counter */
 	cnt = nr_context_switches_cpu(cpu);
 
+	/*
+	 * If this system call event has a size argument, use
+	 * it to define how much of user space memory to read,
+	 * and read it as an array and not a string.
+	 */
+	if (sys_data->user_arg_size >= 0) {
+		array = true;
+		size = args[sys_data->user_arg_size];
+		if (size > SYSCALL_FAULT_BUF_SZ - 1)
+			size = SYSCALL_FAULT_BUF_SZ - 1;
+	}
+
 	/*
 	 * Preemption is going to be enabled, but this task must
 	 * remain on this CPU.
@@ -512,7 +548,12 @@ static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_bu
 	 */
 	preempt_enable_notrace();
 
-	ret = strncpy_from_user(buf, ptr, size);
+	if (array) {
+		ret = __copy_from_user(buf, ptr, size);
+		ret = ret ? -1 : size;
+	} else {
+		ret = strncpy_from_user(buf, ptr, size);
+	}
 
 	preempt_disable_notrace();
 	migrate_enable();
@@ -530,22 +571,24 @@ static char *sys_fault_user(struct syscall_metadata *sys_data, struct syscall_bu
 	if (nr_context_switches_cpu(cpu) != cnt)
 		goto again;
 
-	/* Replace any non-printable characters with '.' */
-	for (int i = 0; i < ret; i++) {
-		if (!isprint(buf[i]))
-			buf[i] = '.';
-	}
+	/* For strings, replace any non-printable characters with '.' */
+	if (!array) {
+		for (int i = 0; i < ret; i++) {
+			if (!isprint(buf[i]))
+				buf[i] = '.';
+		}
 
-	/*
-	 * If the text was truncated due to our max limit, add "..." to
-	 * the string.
-	 */
-	if (ret > SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA)) {
-		strscpy(buf + SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA),
-			EXTRA, sizeof(EXTRA));
-		ret = SYSCALL_FAULT_BUF_SZ;
-	} else {
-		buf[ret++] = '\0';
+		/*
+		 * If the text was truncated due to our max limit, add "..." to
+		 * the string.
+		 */
+		if (ret > SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA)) {
+			strscpy(buf + SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA),
+				EXTRA, sizeof(EXTRA));
+			ret = SYSCALL_FAULT_BUF_SZ;
+		} else {
+			buf[ret++] = '\0';
+		}
 	}
 
 	*data_size = ret;
@@ -642,6 +685,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 		/* Store the offset and the size into the meta data */
 		*(int *)ptr = val | (user_size << 16);
 
+		if (WARN_ON_ONCE((ptr - (void *)entry + user_size) > size))
+			user_size = 0;
+
 		/* Nothing to do if the user space was empty or faulted */
 		if (user_size) {
 			/* Now store the user space data into the event */
@@ -795,7 +841,16 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	if (sys_data->enter_event != call)
 		return;
 
+	sys_data->user_arg_size = -1;
+
 	switch (nr) {
+	/* user arg 1 with size arg at 2 */
+	case __NR_write:
+	case __NR_mq_timedsend:
+	case __NR_pwrite64:
+		sys_data->user_mask = BIT(1);
+		sys_data->user_arg_size = 2;
+		break;
 	/* user arg at position 0 */
 	case __NR_access:
 	case __NR_acct:
-- 
2.50.1


