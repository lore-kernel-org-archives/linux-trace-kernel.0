Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F7324B3F;
	Tue, 23 Sep 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632755; cv=none; b=SUWERN99TB4FlTbl/HMPNpf64McosKWK+7cezuZqSkZ5REEcSxD1aTTW1TwYOnATFnpHKLQMLEWWrgJTRMrIFIsY6vUouQZl8QByyP83oFsDII9CF8kV2lTyGPG+BuZqzO5epX09Vfc6yKGKdjSzrv3Nm/47DVIJULexA0KW2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632755; c=relaxed/simple;
	bh=5YviO26TYWuozo0wcWDzyxzCROCodBzEAXVmxAHlTPo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=J8Eaqg9NdvlrXbBEE6Twm9ArwCn8RtLmBFhKXJ7IiwfX6qbYHhyl6hZ4U4dn9EgQ1sduD/2soXc/ctmECjILD3HBMLi/JgZ1mhB2EckQjcDP+VSOhJGMRy+FNFRDPIST5wQiOVjm5u0hjlaouR8i5Tc+GbhFZu5SRM9IJ3nw2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipk7/Flc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipk7/Flc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB423C16AAE;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632755;
	bh=5YviO26TYWuozo0wcWDzyxzCROCodBzEAXVmxAHlTPo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ipk7/Flc66LZV83dX/o1AHFjf2VGtNkzNuuzKBG/sIZd1IFyIjzdX5gSqGZ5o2CbK
	 AUBnoxiPHRAGTIMyvFN+MaQnxWzkNI1EqQ2wsoiDNN1RvtCOsLlPYYw/TGIZ3CIRoN
	 3XdNLiCZAQiXrOKo5nRApG+YOdCpkTnOy8gdNzQMFs7h8apgHv7J5dG+MyjxVM2aUK
	 PoP6i61J2Bv76MXzgmHecDq+zAvrPvkIfOruYGgC9K77+D+fuCuIBKi6QD3DISkvKq
	 5R+ONxxEmnbUQunF4q0VGCwKCmW+4eBEN7fa/J3GrsR8B3V0AlwKPf7m1Em9SwpCWE
	 tlXYScGKLBO2g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v12ji-0000000Cos5-38NT;
	Tue, 23 Sep 2025 09:07:14 -0400
Message-ID: <20250923130714.603760198@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 23 Sep 2025 09:05:04 -0400
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
Subject: [PATCH v2 7/8] tracing: Add syscall_user_buf_size to limit amount written
References: <20250923130457.901085554@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a system call that reads user space addresses copy it to the ring
buffer, it can copy up to 511 bytes of data. This can waste precious ring
buffer space if the user isn't interested in the output. Add a new file
"syscall_user_buf_size" that gets initialized to a new config
CONFIG_SYSCALL_BUF_SIZE_DEFAULT that defaults to 63.

Also lower the max down to 165, as this isn't to record everything that a
system call may be passing through to the kernel. 165 is more than enough.

The reason for 165 is because adding one for the nul terminating byte, as
well as possibly needing to append the "..." string turns it into 170
bytes. As this needs to save up to 3 arguments and 3 * 170 is 510 which
fits nicely in 512 bytes (a power of 2).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250805193235.747004484@kernel.org

- Change default to 63 (127 seemed too much)

- Change the max to 165 to fill in the extra data.

- Use the size macros of the max size and max args to calculate the size
  of the buffer to save the values in.

 Documentation/trace/ftrace.rst |  8 ++++++
 kernel/trace/Kconfig           | 13 +++++++++
 kernel/trace/trace.c           | 52 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h           |  3 ++
 kernel/trace/trace_syscalls.c  | 42 ++++++++++++++-------------
 5 files changed, 98 insertions(+), 20 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index af66a05e18cc..87fd3ed1301f 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -366,6 +366,14 @@ of ftrace. Here is a list of some of the key files:
 	for each function. The displayed address is the patch-site address
 	and can differ from /proc/kallsyms address.
 
+  syscall_user_buf_size:
+
+	Some system call trace events will record the data from a user
+	space address that one of the parameters point to. The amount of
+	data per event is limited. This file holds the max number of bytes
+	that will be recorded into the ring buffer to hold this data.
+	The max value is currently 165.
+
   dyn_ftrace_total_info:
 
 	This file is for debugging purposes. The number of functions that
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d2c79da81e4f..a055ca174da5 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -575,6 +575,19 @@ config FTRACE_SYSCALLS
 	help
 	  Basic tracer to catch the syscall entry and exit events.
 
+config TRACE_SYSCALL_BUF_SIZE_DEFAULT
+	int "System call user read max size"
+	range 0 165
+	default 63
+	depends on FTRACE_SYSCALLS
+	help
+	 Some system call trace events will record the data from a user
+	 space address that one of the parameters point to. The amount of
+	 data per event is limited. It may be further limited by this
+	 config and later changed by writing an ASCII number into:
+
+	   /sys/kernel/tracing/syscall_user_buf_size
+
 config TRACER_SNAPSHOT
 	bool "Create a snapshot trace buffer"
 	select TRACER_MAX_TRACE
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1b7db732c0b1..a3d2e7d1c664 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6913,6 +6913,43 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 	goto out;
 }
 
+static ssize_t
+tracing_syscall_buf_read(struct file *filp, char __user *ubuf,
+			 size_t cnt, loff_t *ppos)
+{
+	struct inode *inode = file_inode(filp);
+	struct trace_array *tr = inode->i_private;
+	char buf[64];
+	int r;
+
+	r = snprintf(buf, 64, "%d\n", tr->syscall_buf_sz);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+static ssize_t
+tracing_syscall_buf_write(struct file *filp, const char __user *ubuf,
+			  size_t cnt, loff_t *ppos)
+{
+	struct inode *inode = file_inode(filp);
+	struct trace_array *tr = inode->i_private;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > SYSCALL_FAULT_USER_MAX)
+		val = SYSCALL_FAULT_USER_MAX;
+
+	tr->syscall_buf_sz = val;
+
+	*ppos += cnt;
+
+	return cnt;
+}
+
 static ssize_t
 tracing_entries_read(struct file *filp, char __user *ubuf,
 		     size_t cnt, loff_t *ppos)
@@ -7737,6 +7774,14 @@ static const struct file_operations tracing_entries_fops = {
 	.release	= tracing_release_generic_tr,
 };
 
+static const struct file_operations tracing_syscall_buf_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= tracing_syscall_buf_read,
+	.write		= tracing_syscall_buf_write,
+	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
+};
+
 static const struct file_operations tracing_buffer_meta_fops = {
 	.open		= tracing_buffer_meta_open,
 	.read		= seq_read,
@@ -9839,6 +9884,8 @@ trace_array_create_systems(const char *name, const char *systems,
 
 	raw_spin_lock_init(&tr->start_lock);
 
+	tr->syscall_buf_sz = global_trace.syscall_buf_sz;
+
 	tr->max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 #ifdef CONFIG_TRACER_MAX_TRACE
 	spin_lock_init(&tr->snapshot_trigger_lock);
@@ -10155,6 +10202,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
 			  tr, &buffer_subbuf_size_fops);
 
+	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
+			 tr, &tracing_syscall_buf_fops);
+
 	create_trace_options_dir(tr);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -11081,6 +11131,8 @@ __init static int tracer_alloc_buffers(void)
 
 	global_trace.flags = TRACE_ARRAY_FL_GLOBAL;
 
+	global_trace.syscall_buf_sz = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
+
 	INIT_LIST_HEAD(&global_trace.systems);
 	INIT_LIST_HEAD(&global_trace.events);
 	INIT_LIST_HEAD(&global_trace.hist_vars);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 85eabb454bee..0499e6dd51fa 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -131,6 +131,8 @@ enum trace_type {
 #define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
 #define HIST_STACKTRACE_SKIP	5
 
+#define SYSCALL_FAULT_USER_MAX 165
+
 /*
  * syscalls are special, and need special handling, this is why
  * they are not included in trace_entries.h
@@ -430,6 +432,7 @@ struct trace_array {
 	int			function_enabled;
 #endif
 	int			no_filter_buffering_ref;
+	unsigned int		syscall_buf_sz;
 	struct list_head	hist_vars;
 #ifdef CONFIG_TRACER_SNAPSHOT
 	struct cond_snapshot	*cond_snapshot;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index b602c9a7dbd8..367e10096c6f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -399,24 +399,21 @@ struct syscall_buf_info {
 /*
  * Create a per CPU temporary buffer to copy user space pointers into.
  *
- * SYSCALL_FAULT_BUF_SZ holds the size of the per CPU buffer to use
- * to copy memory from user space addresses into.
- *
- * SYSCALL_FAULT_ARG_SZ is the amount to copy from user space.
- *
- * SYSCALL_FAULT_USER_MAX is the amount to copy into the ring buffer.
- *  It's slightly smaller than SYSCALL_FAULT_ARG_SZ to know if it
- *  needs to append the EXTRA or not.
+ * SYSCALL_FAULT_USER_MAX is the amount to copy from user space.
+ *  (defined in kernel/trace/trace.h)
+
+ * SYSCALL_FAULT_ARG_SZ is the amount to copy from user space plus the
+ *   nul terminating byte and possibly appended EXTRA (4 bytes).
  *
- * This only allows up to 3 args from system calls.
+ * SYSCALL_FAULT_BUF_SZ holds the size of the per CPU buffer to use
+ * to copy memory from user space addresses into that will hold
+ * 3 args as only 3 args are allowed to be copied from system calls.
  */
-#define SYSCALL_FAULT_BUF_SZ 512
-#define SYSCALL_FAULT_ARG_SZ 168
-#define SYSCALL_FAULT_USER_MAX 128
+#define SYSCALL_FAULT_ARG_SZ (SYSCALL_FAULT_USER_MAX + 1 + 4)
 #define SYSCALL_FAULT_MAX_CNT 3
+#define SYSCALL_FAULT_BUF_SZ (SYSCALL_FAULT_ARG_SZ * SYSCALL_FAULT_MAX_CNT)
 
 static struct syscall_buf_info *syscall_buffer;
-
 static int syscall_fault_buffer_cnt;
 
 static void syscall_fault_buffer_free(struct syscall_buf_info *sinfo)
@@ -499,7 +496,7 @@ static void syscall_fault_buffer_disable(void)
 	call_rcu_tasks_trace(&sinfo->rcu, rcu_free_syscall_buffer);
 }
 
-static char *sys_fault_user(struct syscall_metadata *sys_data,
+static char *sys_fault_user(struct trace_array *tr, struct syscall_metadata *sys_data,
 			    struct syscall_buf_info *sinfo,
 			    unsigned long *args,
 			    unsigned int data_size[SYSCALL_FAULT_MAX_CNT])
@@ -552,6 +549,10 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 		data_size[i] = -1; /* Denotes no pointer */
 	}
 
+	/* A zero size means do not even try */
+	if (!tr->syscall_buf_sz)
+		return buffer;
+
 	/*
 	 * This acts similar to a seqcount. The per CPU context switches are
 	 * recorded, migration is disabled and preemption is enabled. The
@@ -639,19 +640,20 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 					buf[x] = '.';
 			}
 
+			size = min(tr->syscall_buf_sz, SYSCALL_FAULT_USER_MAX);
+
 			/*
 			 * If the text was truncated due to our max limit,
 			 * add "..." to the string.
 			 */
-			if (ret > SYSCALL_FAULT_USER_MAX) {
-				strscpy(buf + SYSCALL_FAULT_USER_MAX, EXTRA,
-					sizeof(EXTRA));
-				ret = SYSCALL_FAULT_USER_MAX + sizeof(EXTRA);
+			if (ret > size) {
+				strscpy(buf + size, EXTRA, sizeof(EXTRA));
+				ret = size + sizeof(EXTRA);
 			} else {
 				buf[ret++] = '\0';
 			}
 		} else {
-			ret = min(ret, SYSCALL_FAULT_USER_MAX);
+			ret = min((unsigned int)ret, tr->syscall_buf_sz);
 		}
 		data_size[i] = ret;
 	}
@@ -711,7 +713,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 		if (!sinfo)
 			return;
 
-		user_ptr = sys_fault_user(sys_data, sinfo, args, user_sizes);
+		user_ptr = sys_fault_user(tr, sys_data, sinfo, args, user_sizes);
 		/*
 		 * user_size is the amount of data to append.
 		 * Need to add 4 for the meta field that points to
-- 
2.50.1


