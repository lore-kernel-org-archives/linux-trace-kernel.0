Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313948B389
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130942; cv=none; b=EMND977hz2BHAuHPzOQVnc6AJVTgwUM32xm+qOwVGR2NjH/jkrltIKQQ87ByF2DyaJiThGLPf+DbzeRXqVSO5e9YfOW6F7cklE8fqagBL18ol8rytDc1qNV8cMMnmzBE7t4+XL/Re4nI2T8oGyAFytDOwuHWhpyXUdXrxckQ/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130942; c=relaxed/simple;
	bh=STBY0G6DHixqQwGxRMWKbAx2MYp06qcCDkil70SZmqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=murM1OZz1qXgw++ULABlKR4blnMdlMydXG1xgxikAOEIzCgxKo18DGCpP+PZxcUg4MqxZeKUbnLBBvShk0Vhny7N0YLhf6xyZ9riijrbCLbcKMZw4hk8MrwikEZ/mBfB+DHXLqpIPN6ZI9/woEPaj52xK2kyXP/+I6IgItNXAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VnLKYN/S; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VnLKYN/S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784130922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XBs/iZ6MmTQu7DoOoSSI8RIx1fXFg8s0vEoeX9y13WI=;
	b=VnLKYN/SYTW4IPxxXxdh7OLwjdnR3rtVKdIbx5URLlSipoausZmcXswKRQjmUa1zwXjWg/
	9IGwqKrYmXLy1jNFGciWCcKTJgotZ0iyR/UiSCu8xYpQPrp2Bj5XZMI+7VAC3OnxbOn/jU
	mmvgl8NVEgLDhE3d6RO1SnJfENnsEpg=
From: Usama Arif <usama.arif@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	leitao@debian.org
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [RFC] tracing: Try user copies with page faults disabled first
Date: Wed, 15 Jul 2026 08:54:54 -0700
Message-ID: <20260715155454.4127988-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

trace_user_fault_read() is called with preemption disabled to copy user
memory into a per-cpu scratch buffer. The existing implementation enables
preemption around the copy because faulting user memory can sleep. That
opens a window where another task can run on the same CPU and clobber the
per-cpu buffer, so the copy is wrapped in a retry loop: sample
nr_context_switches_cpu(), do the preempt-enabled copy, and retry if the
counter changed. If this fails to complete 100 times, the function gives up
with a warning.

nr_context_switches_cpu() reads rq->nr_switches. That counter increments
for every context switch on the CPU, not only for switches to tasks that
use this tracing scratch buffer. On a heavily loaded system, unrelated
scheduler activity can move the counter during every preempt-enabled copy
attempt, exhaust the retry guard, and trigger the warning.

This is showing up across the Meta fleet around 100 times a day since the
kernel began upgrading to 7.1, mostly on arm servers:

  Error: Too many tries to read user space
  WARNING: kernel/trace/trace.c:6244 at trace_user_fault_read+0x284/0x2c8, CPU#28: Collection-18/677527
  CPU: 28 UID: 0 PID: 677527 Comm: Collection-18 Kdump: loaded Not tainted 7.1.0-.... #1 PREEMPTLAZY
  Hardware name: Quanta Java Island MP 29F0EMA08CH/Java Island, BIOS F0EJ3A16 03/12/2026
  Call trace:
   trace_user_fault_read+0x284/0x2c8 (P)
   syscall_get_data+0x144/0x2c0
   perf_syscall_enter+0xc0/0x2d8
   syscall_trace_enter+0x1a0/0x270
   do_el0_svc+0x54/0xb8
   el0_svc+0x44/0x268
   el0t_64_sync_handler+0x7c/0x120
   el0t_64_sync+0x17c/0x180
  ---[ end trace 0000000000000000 ]---

The retry loop is only needed when preemption must be enabled for the user
copy. If the user pages are already resident, the copy can complete without
fault handling that sleeps, and preemption can stay disabled throughout.

Add a fast path that first tries the copy with page faults disabled. For
the plain copy_from_user case, use __copy_from_user_inatomic(). If the
probe faults, the architecture exception-table fixup returns a non-zero
not-copied count and trace_user_fault_read() falls back to the existing
preempt-enabled slow path.

Custom copy callbacks need the same behavior. Update the syscall argument
copy callbacks to report a non-zero return only when the pagefault-disabled
probe faults. With page faults enabled, keep their previous behavior:
record the syscall event and omit only the individual user argument that
still cannot be copied.

The slow path remains in place for nonresident pages and permanent copy
failures. nr_context_switches_cpu() still overcounts, but the retry loop is
now avoided for the common resident-page case that does not need fault
handling.

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
This warning is very likely occuring when the fleetwide profiler runs
and something else seems to load the server. (As we have perf_syscall_enter()
in the stack and I see the profiler process active when the warning prints).
It can occur several days after boot, so its a bit difficult to verify
if the warning will go away with this patch deployed.
If the patch looks good, we can deploy it in the fleet and report back.
---
 kernel/trace/trace.c          | 22 +++++++++++++++--
 kernel/trace/trace_syscalls.c | 45 ++++++++++++++++++++++++++++++++---
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1146b83b711a..fe1637afac84 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6173,8 +6173,10 @@ int trace_user_fault_put(struct trace_user_buf_info *tinfo)
  *   size: The @size of the ptr to read
  *   data: The @data parameter
  *
- * It is expected that @copy_func will return 0 on success and non zero
- * if there was a fault.
+ * @copy_func may be called with page faults disabled first. It is
+ * expected that @copy_func will return 0 on success and non zero if the
+ * copy needs to be retried with page faults enabled or if there was a
+ * fault.
  *
  * Returns a pointer to the buffer with the content read from @ptr.
  *   Preemption must remain disabled while the caller accesses the
@@ -6201,6 +6203,22 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 	if (size > tinfo->size)
 		return NULL;
 
+	/*
+	 * Fastpath: try the copy with page faults disabled. Preemption is
+	 * already disabled by the caller, so no other task can run on this
+	 * CPU to corrupt the per-CPU buffer, and the seqcount-style retry
+	 * loop below is unnecessary. This succeeds whenever the user pages
+	 * are already present.
+	 */
+	pagefault_disable();
+	if (copy_func)
+		ret = copy_func(buffer, ptr, size, data);
+	else
+		ret = __copy_from_user_inatomic(buffer, ptr, size);
+	pagefault_enable();
+	if (!ret)
+		return buffer;
+
 	/*
 	 * This acts similar to a seqcount. The per CPU context switches are
 	 * recorded, migration is disabled and preemption is enabled. The
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e98ee7e1e66f..bc9d0134f7c1 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>	/* for MODULE_NAME_LEN via KSYM_SYMBOL_LEN */
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
+#include <linux/uaccess.h>
 #include <linux/xarray.h>
 #include <asm/syscall.h>
 
@@ -660,32 +661,70 @@ struct syscall_args {
 	int		uargs;
 };
 
+/*
+ * The callback return value is consumed by trace_user_fault_read() as a
+ * whole-buffer status: 0 means the per-CPU scratch buffer can be used,
+ * non-zero means retry with page faults enabled or fail the read.
+ *
+ * Syscall tracing also needs per-argument status, because one bad user
+ * pointer should omit only that appended argument, not the syscall event
+ * itself. Store that per-argument result in args->read[].
+ *
+ * When called by the pagefault-disabled fast path, a fault may just mean the
+ * user page needs to be faulted in, so report it to trace_user_fault_read().
+ * When called by the pagefault-enabled slow path, record the per-argument
+ * failure in args->read[] and return 0 so the syscall event can still be emitted.
+ */
 static int syscall_copy_user(char *buf, const char __user *ptr,
 			     size_t size, void *data)
 {
 	struct syscall_args *args = data;
+	bool inatomic = pagefault_disabled();
+	bool faulted = false;
 	int ret;
 
 	for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
 		ptr = (char __user *)args->ptr_array[i];
 		ret = strncpy_from_user(buf, ptr, size);
 		args->read[i] = ret;
+		if (inatomic && ret < 0)
+			faulted = true;
 	}
-	return 0;
+
+	return faulted ? -EFAULT : 0;
 }
 
+/*
+ * Copy explicitly sized user arguments into the per-CPU scratch buffer.
+ * The callback return value is whole-buffer status for trace_user_fault_read():
+ * return non-zero from the pagefault-disabled fast path so it can retry with
+ * faults enabled. Per-argument status is stored in args->read[].
+ *
+ * The __copy_from_user*() helpers return bytes not copied. Store @size for a
+ * fully copied argument and -1 for a copy fault. When the pagefault-enabled
+ * slow path still faults, return 0 so the syscall event can be emitted and
+ * only that appended user argument is omitted.
+ */
 static int syscall_copy_user_array(char *buf, const char __user *ptr,
 				   size_t size, void *data)
 {
 	struct syscall_args *args = data;
+	bool inatomic = pagefault_disabled();
+	bool faulted = false;
 	int ret;
 
 	for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
 		ptr = (char __user *)args->ptr_array[i];
-		ret = __copy_from_user(buf, ptr, size);
+		if (inatomic)
+			ret = __copy_from_user_inatomic(buf, ptr, size);
+		else
+			ret = __copy_from_user(buf, ptr, size);
 		args->read[i] = ret ? -1 : size;
+		if (inatomic && ret)
+			faulted = true;
 	}
-	return 0;
+
+	return faulted ? -EFAULT : 0;
 }
 
 static char *sys_fault_user(unsigned int buf_size,
-- 
2.53.0-Meta

