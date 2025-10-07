Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094F23C512;
	Tue,  7 Oct 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869002; cv=none; b=bT3SHaWS3yMIaZswCENZMhqlU2Caef4WKD60T/W7FJj3dg2i5QyBrFvNpuV78lrza2XjRDzWiwbt5ErrgFiu5pSbFbjdyZwkSlI4hpMwWcv3mdfyNJXe5z/NmPfwlyPCvrUDLM0B7bH+/KS5xEfozNRCtC4Go/SJnK9we41CtZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869002; c=relaxed/simple;
	bh=+/TcoE3NXm2WwSnw1g/yFWPlPIxTPwrZY+EQgUP1Ido=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=druNy5H6CtZArTyzH5Ox7iXsGF7o7vgS/ZfeDOhNzvjqrcU+/ma5vibUf8B17bb+k3mapOp+rCPn8sZb/rJkvOwRK5iOOuwnVWZaBuCDWrl4VzbfJ9F0rULVa6yNTnrezW6LitCsnfREA+pSEhnfaN9fqwKCHyAWxtxdep4OzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 53D6813A7C0;
	Tue,  7 Oct 2025 20:29:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 468CA2000F;
	Tue,  7 Oct 2025 20:29:49 +0000 (UTC)
Date: Tue, 7 Oct 2025 16:31:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Runping Lai <runpinglai@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Wattson CI <wattson-external@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Luo Gengkun
 <luogengkun@huaweicloud.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
Message-ID: <20251007163141.1034b120@gandalf.local.home>
In-Reply-To: <20251007154308.5b158d04@gandalf.local.home>
References: <20251007003417.3470979-2-runpinglai@google.com>
	<20251006221043.07cdb0fd@gandalf.local.home>
	<CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
	<20251007154308.5b158d04@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: t9sxqw9k7ywpmd85f4ai3o3sh5zkhoso
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 468CA2000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/eoAvrB6PJy2KODm1vnR0WOVXexAyVxd8=
X-HE-Tag: 1759868989-455320
X-HE-Meta: U2FsdGVkX1/THK0GXDneu8Zzv8ANWZnphBOSAfkOA4U7VrIFfQ/+MSUSWwYwqHP/j0L1ettm20B61/y29b+qAXOygk3UVGOKPsUS/ZtHPkrt2b7pzJSwbO/V3yEalJQnroieGTuZEPp7U3u4l3Kv+EJgsA197n7iR1hEDuITT6311TIDIYtXiPtrwG5TIpBGskukByeGjWgzo7qKEB6f+GRNHD+WmtEXC12CYpdTUqgvjGwjGhinzXserzypl1znbx8oUS7DbjeHqd/7G4L4bXzoGZ6GxtMH/stWxPhtuKja2YRHRYp/VRr/zEYiojegaASo/YnsSC06Bc/hSaCtOGArQcB9zKF1BIM8uxwEklv1Cd4rBColnW/HD3sPGYqu

On Tue, 7 Oct 2025 15:43:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I do have a working solution, but it isn't trivial.

Here is the solution that works. I based it off of a method I'm using to
read user space memory from the faultable system call tracepoints. Where it
can't do allocation in the tracepoint itself (for both speed as well as
adding noise to the trace). It follows the same idea as seq_counters do.
I've been playing with this for a couple of weeks now and it appears to be
quite reliable.

Writes to trace_marker has similar requirements. It is highly optimized for
user space debugging that has small race windows, and a the write doesn't
take any locks, let alone do any allocation.

The method here is when the trace_marker file is first opened, a per CPU
buffer is allocated. Then during the writes, the following is performed:

	preempt_disable();

	cpu = smp_processor_id();
	buffer = per_cpu_ptr(cpu_buffers, cpu);

	do {
		cnt = nr_context_switches_cpu(cpu);
		migrate_disable();
		preempt_enable();

		ret = copy_from_user(buffer, ptr, size);

		preempt_enable();
		migrate_enable();

	} while (cnt != nr_context_switches_cpu(cpu));

	ring_buffer_write(buffer);

	preempt_enable();


There's a little more to it than that (like checking for faults), but this
is the basic idea. Since the buffer can only be written in "task context"
(as supposed to interrupt context), if the copy succeeds without any
context switch, the buffer is considered to be valid. If there was a
context switch, the buffer has to be considered corrupted, and the read
must be performed again.

When I stress tested this with the faultable system call tracepoints, where
I had it read memory mapped memory (to always fault), and kicked off a
thousand programs doing the same thing, the looped triggered only 10% of
the time (I added counters to when it looped and when it did not loop).

Here's the code for doing this with trace_marker writes.

But, it's not a simply fix :-/

-- Steve

 kernel/trace/trace.c | 267 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 219 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b3c94fbaf002..cde9881065bd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4791,12 +4791,6 @@ int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
 	return single_release(inode, filp);
 }
 
-static int tracing_mark_open(struct inode *inode, struct file *filp)
-{
-	stream_open(inode, filp);
-	return tracing_open_generic_tr(inode, filp);
-}
-
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -7163,7 +7157,7 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
 
 #define TRACE_MARKER_MAX_SIZE		4096
 
-static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user *ubuf,
+static ssize_t write_marker_to_buffer(struct trace_array *tr, const char *buf,
 				      size_t cnt, unsigned long ip)
 {
 	struct ring_buffer_event *event;
@@ -7173,20 +7167,11 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	int meta_size;
 	ssize_t written;
 	size_t size;
-	int len;
-
-/* Used in tracing_mark_raw_write() as well */
-#define FAULTED_STR "<faulted>"
-#define FAULTED_SIZE (sizeof(FAULTED_STR) - 1) /* '\0' is already accounted for */
 
 	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
  again:
 	size = cnt + meta_size;
 
-	/* If less than "<faulted>", then make sure we can still add that */
-	if (cnt < FAULTED_SIZE)
-		size += FAULTED_SIZE - cnt;
-
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
@@ -7196,9 +7181,6 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 		 * make it smaller and try again.
 		 */
 		if (size > ring_buffer_max_event_size(buffer)) {
-			/* cnt < FAULTED size should never be bigger than max */
-			if (WARN_ON_ONCE(cnt < FAULTED_SIZE))
-				return -EBADF;
 			cnt = ring_buffer_max_event_size(buffer) - meta_size;
 			/* The above should only happen once */
 			if (WARN_ON_ONCE(cnt + meta_size == size))
@@ -7212,14 +7194,8 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
-
-	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
-	if (len) {
-		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-		cnt = FAULTED_SIZE;
-		written = -EFAULT;
-	} else
-		written = cnt;
+	memcpy(&entry->buf, buf, cnt);
+	written = cnt;
 
 	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
 		/* do not add \n before testing triggers, but add \0 */
@@ -7243,6 +7219,168 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	return written;
 }
 
+struct trace_user_buf {
+	char		*buf;
+};
+
+struct trace_user_buf_info {
+	struct trace_user_buf __percpu	*tbuf;
+	int				ref;
+};
+
+
+static DEFINE_MUTEX(trace_user_buffer_mutex);
+static struct trace_user_buf_info *trace_user_buffer;
+
+static void trace_user_fault_buffer_free(struct trace_user_buf_info *tinfo)
+{
+	char *buf;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		buf = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+		kfree(buf);
+	}
+	kfree(tinfo);
+}
+
+static int trace_user_fault_buffer_enable(void)
+{
+	struct trace_user_buf_info *tinfo;
+	char *buf;
+	int cpu;
+
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	if (trace_user_buffer) {
+		trace_user_buffer->ref++;
+		return 0;
+	}
+
+	tinfo = kmalloc(sizeof(*tinfo), GFP_KERNEL);
+	if (!tinfo)
+		return -ENOMEM;
+
+	tinfo->tbuf = alloc_percpu(struct trace_user_buf);
+	if (!tinfo->tbuf) {
+		kfree(tinfo);
+		return -ENOMEM;
+	}
+
+	tinfo->ref = 1;
+
+	/* Clear each buffer in case of error */
+	for_each_possible_cpu(cpu) {
+		per_cpu_ptr(tinfo->tbuf, cpu)->buf = NULL;
+	}
+
+	for_each_possible_cpu(cpu) {
+		buf = kmalloc_node(TRACE_MARKER_MAX_SIZE, GFP_KERNEL,
+				   cpu_to_node(cpu));
+		if (!buf) {
+			trace_user_fault_buffer_free(tinfo);
+			return -ENOMEM;
+		}
+		per_cpu_ptr(tinfo->tbuf, cpu)->buf = buf;
+	}
+
+	trace_user_buffer = tinfo;
+
+	return 0;
+}
+
+static void trace_user_fault_buffer_disable(void)
+{
+	struct trace_user_buf_info *tinfo;
+
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	tinfo = trace_user_buffer;
+
+	if (WARN_ON_ONCE(!tinfo))
+		return;
+
+	if (--tinfo->ref)
+		return;
+
+	trace_user_fault_buffer_free(tinfo);
+	trace_user_buffer = NULL;
+}
+
+/* Must be called with preemption disabled */
+static char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
+				   const char __user *ptr, size_t size,
+				   size_t *read_size)
+{
+	int cpu = smp_processor_id();
+	char *buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+	unsigned int cnt;
+	int trys = 0;
+	int ret;
+
+	if (size > TRACE_MARKER_MAX_SIZE)
+		size = TRACE_MARKER_MAX_SIZE;
+	*read_size = 0;
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
+
+	do {
+		/*
+		 * If for some reason, copy_from_user() always causes a context
+		 * switch, this would then cause an infinite loop.
+		 * If this task is preempted by another user space task, it
+		 * will cause this task to try again. But just in case something
+		 * changes where the copying from user space causes another task
+		 * to run, prevent this from going into an infinite loop.
+		 * 100 tries should be plenty.
+		 */
+		if (WARN_ONCE(trys++ > 100, "Error: Too many tries to read user space"))
+			return NULL;
+
+		/* Read the current CPU context switch counter */
+		cnt = nr_context_switches_cpu(cpu);
+
+		/*
+		 * Preemption is going to be enabled, but this task must
+		 * remain on this CPU.
+		 */
+		migrate_disable();
+
+		/*
+		 * Now preemption is being enabed and another task can come in
+		 * and use the same buffer and corrupt our data.
+		 */
+		preempt_enable_notrace();
+
+		ret = __copy_from_user(buffer, ptr, size);
+
+		preempt_disable_notrace();
+		migrate_enable();
+
+		/* if it faulted, no need to test if the buffer was corrupted */
+		if (ret)
+			return NULL;
+
+		/*
+		 * Preemption is disabled again, now check the per CPU context
+		 * switch counter. If it doesn't match, then another user space
+		 * process may have schedule in and corrupted our buffer. In that
+		 * case the copying must be retried.
+		 */
+	} while (nr_context_switches_cpu(cpu) != cnt);
+
+	*read_size = size;
+	return buffer;
+}
+
 static ssize_t
 tracing_mark_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7250,6 +7388,8 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
 	unsigned long ip;
+	size_t size;
+	char *buf;
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -7263,6 +7403,16 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (cnt > TRACE_MARKER_MAX_SIZE)
 		cnt = TRACE_MARKER_MAX_SIZE;
 
+	/* Must have preemption disabled while having access to the buffer */
+	guard(preempt_notrace)();
+
+	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size);
+	if (!buf)
+		return -EFAULT;
+
+	if (cnt > size)
+		cnt = size;
+
 	/* The selftests expect this function to be the IP address */
 	ip = _THIS_IP_;
 
@@ -7270,32 +7420,27 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tr == &global_trace) {
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
-			written = write_marker_to_buffer(tr, ubuf, cnt, ip);
+			written = write_marker_to_buffer(tr, buf, cnt, ip);
 			if (written < 0)
 				break;
 		}
 	} else {
-		written = write_marker_to_buffer(tr, ubuf, cnt, ip);
+		written = write_marker_to_buffer(tr, buf, cnt, ip);
 	}
 
 	return written;
 }
 
 static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
-					  const char __user *ubuf, size_t cnt)
+					  const char *buf, size_t cnt)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct raw_data_entry *entry;
 	ssize_t written;
-	int size;
-	int len;
-
-#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+	size_t size;
 
 	size = sizeof(*entry) + cnt;
-	if (cnt < FAULT_SIZE_ID)
-		size += FAULT_SIZE_ID - cnt;
 
 	buffer = tr->array_buffer.buffer;
 
@@ -7309,14 +7454,8 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 		return -EBADF;
 
 	entry = ring_buffer_event_data(event);
-
-	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
-	if (len) {
-		entry->id = -1;
-		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-		written = -EFAULT;
-	} else
-		written = cnt;
+	memcpy(&entry->id, buf, cnt);
+	written = cnt;
 
 	__buffer_unlock_commit(buffer, event);
 
@@ -7329,8 +7468,8 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
-
-#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+	size_t size;
+	char *buf;
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -7342,6 +7481,17 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (cnt < sizeof(unsigned int))
 		return -EINVAL;
 
+	/* Must have preemption disabled while having access to the buffer */
+	guard(preempt_notrace)();
+
+	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size);
+	if (!buf)
+		return -EFAULT;
+
+	/* raw write is all or nothing */
+	if (cnt > size)
+		return -EINVAL;
+
 	/* The global trace_marker_raw can go to multiple instances */
 	if (tr == &global_trace) {
 		guard(rcu)();
@@ -7357,6 +7507,27 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	return written;
 }
 
+static int tracing_mark_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = trace_user_fault_buffer_enable();
+	if (ret < 0)
+		return ret;
+
+	stream_open(inode, filp);
+	ret = tracing_open_generic_tr(inode, filp);
+	if (ret < 0)
+		trace_user_fault_buffer_disable();
+	return ret;
+}
+
+static int tracing_mark_release(struct inode *inode, struct file *file)
+{
+	trace_user_fault_buffer_disable();
+	return tracing_release_generic_tr(inode, file);
+}
+
 static int tracing_clock_show(struct seq_file *m, void *v)
 {
 	struct trace_array *tr = m->private;
@@ -7764,13 +7935,13 @@ static const struct file_operations tracing_free_buffer_fops = {
 static const struct file_operations tracing_mark_fops = {
 	.open		= tracing_mark_open,
 	.write		= tracing_mark_write,
-	.release	= tracing_release_generic_tr,
+	.release	= tracing_mark_release,
 };
 
 static const struct file_operations tracing_mark_raw_fops = {
 	.open		= tracing_mark_open,
 	.write		= tracing_mark_raw_write,
-	.release	= tracing_release_generic_tr,
+	.release	= tracing_mark_release,
 };
 
 static const struct file_operations trace_clock_fops = {
-- 
2.51.0

