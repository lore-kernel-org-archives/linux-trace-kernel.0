Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1428A73D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086312; cv=none; b=H1K5AY0WPOvy+ncTUrntLCErVFXD16pSby2iZHqUjkhPtyg8aDvdbOX+ry7qh9jsFlhGjSw3ABcqv0r2N0e4ek+S0JcB7X7Ey/wBS7zfkrxX3kc+GvgpVZea2HHldZTRuU+3/86GeCkeT4gBXWdBSLX68kfgXMhP3SrugUy7ayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086312; c=relaxed/simple;
	bh=26Nkhk4Td3qZPFdU6inRDEyqGbxc/8uOQyM4fceN6DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR7K4iOmQ4yWIzJPl9VYHbRPIVA0k0MxDpxq3OMgX3ZH5m524M3bbQMpjVBShM00iKsdIJQgMm8lqj1qyaUSjVcMbsdOjf1ZpQnykmUEErkqksNifzECOhaQbq+B1j4EBAjzX9ac+PCMTa0POSb3OKP2n2WMaOU1xCdhUyYMJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsHOHNRk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsHOHNRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFaID3H5j0ATow9ZzZ4NzIUU59bv7nhN7ABws7LMir4=;
	b=RsHOHNRkz9Zl+g19JFIqKTh4Q+P3W87oL+QUH2UOWRgv6zMDDvHi1StCE5DmILxfGL1K4f
	PNYszIvq8IWxCR8h56I9khL8rmlvc5Gc5VtfB30jEIwRSGsULfYxQ3vXJ5hKXyC/nPijCV
	itxZQkgGdsjbmQ5vY8YpBAwkY8nJkRM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-FtDXoGwrNmefifRz4MgnhQ-1; Mon,
 21 Jul 2025 04:25:04 -0400
X-MC-Unique: FtDXoGwrNmefifRz4MgnhQ-1
X-Mimecast-MFC-AGG-ID: FtDXoGwrNmefifRz4MgnhQ_1753086302
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 607A319560A2;
	Mon, 21 Jul 2025 08:25:02 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22C1719560AD;
	Mon, 21 Jul 2025 08:24:56 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 13/14] rv: Add nrp and sssw per-task monitors
Date: Mon, 21 Jul 2025 10:23:23 +0200
Message-ID: <20250721082325.71554-14-gmonaco@redhat.com>
In-Reply-To: <20250721082325.71554-1-gmonaco@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add 2 per-task monitors as part of the sched model:

* nrp: need-resched preempts
    Monitor to ensure preemption requires need resched.
* sssw: set state sleep and wakeup
    Monitor to ensure sched_set_state to sleepable leads to sleeping and
    sleeping tasks require wakeup.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst   | 167 +++++++++++++++++++++
 kernel/trace/rv/Kconfig                    |   2 +
 kernel/trace/rv/Makefile                   |   2 +
 kernel/trace/rv/monitors/nrp/Kconfig       |  16 ++
 kernel/trace/rv/monitors/nrp/nrp.c         | 138 +++++++++++++++++
 kernel/trace/rv/monitors/nrp/nrp.h         |  75 +++++++++
 kernel/trace/rv/monitors/nrp/nrp_trace.h   |  15 ++
 kernel/trace/rv/monitors/sched/Kconfig     |   1 +
 kernel/trace/rv/monitors/sssw/Kconfig      |  15 ++
 kernel/trace/rv/monitors/sssw/sssw.c       | 116 ++++++++++++++
 kernel/trace/rv/monitors/sssw/sssw.h       | 105 +++++++++++++
 kernel/trace/rv/monitors/sssw/sssw_trace.h |  15 ++
 kernel/trace/rv/rv_trace.h                 |   2 +
 tools/verification/models/sched/nrp.dot    |  29 ++++
 tools/verification/models/sched/sssw.dot   |  30 ++++
 15 files changed, 728 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/nrp/Kconfig
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.c
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.h
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp_trace.h
 create mode 100644 kernel/trace/rv/monitors/sssw/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw.c
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw.h
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw_trace.h
 create mode 100644 tools/verification/models/sched/nrp.dot
 create mode 100644 tools/verification/models/sched/sssw.dot

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 6c4c00216c07a..11ef963cb5780 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -174,6 +174,173 @@ running one, no real task switch occurs but interrupts are disabled nonetheless:
                   |               | irq_entry
                   +---------------+ irq_enable
 
+Monitor nrp
+-----------
+
+The need resched preempts (nrp) monitor ensures preemption requires
+``need_resched``. Only kernel preemption is considered, since preemption
+while returning to userspace, for this monitor, is indistinguishable from
+``sched_switch_yield`` (described in the sssw monitor).
+A kernel preemption is whenever ``__schedule`` is called with the preemption
+flag set to true (e.g. from preempt_enable or exiting from interrupts). This
+type of preemption occurs after the need for ``rescheduling`` has been set.
+This is not valid for the *lazy* variant of the flag, which causes only
+userspace preemption.
+A ``schedule_entry_preempt`` may involve a task switch or not, in the latter
+case, a task goes through the scheduler from a preemption context but it is
+picked as the next task to run. Since the scheduler runs, this clears the need
+to reschedule. The ``any_thread_running`` state does not imply the monitored
+task is not running as this monitor does not track the outcome of scheduling.
+
+In theory, a preemption can only occur after the ``need_resched`` flag is set. In
+practice, however, it is possible to see a preemption where the flag is not
+set. This can happen in one specific condition::
+
+  need_resched
+                   preempt_schedule()
+                                           preempt_schedule_irq()
+                                                   __schedule()
+  !need_resched
+                           __schedule()
+
+In the situation above, standard preemption starts (e.g. from preempt_enable
+when the flag is set), an interrupt occurs before scheduling and, on its exit
+path, it schedules, which clears the ``need_resched`` flag.
+When the preempted task runs again, the standard preemption started earlier
+resumes, although the flag is no longer set. The monitor considers this a
+``nested_preemption``, this allows another preemption without re-setting the
+flag. This condition relaxes the monitor constraints and may catch false
+negatives (i.e. no real ``nested_preemptions``) but makes the monitor more
+robust and able to validate other scenarios.
+For simplicity, the monitor starts in ``preempt_irq``, although no interrupt
+occurred, as the situation above is hard to pinpoint::
+
+    schedule_entry
+    irq_entry                 #===========================================#
+  +-------------------------- H                                           H
+  |                           H                                           H
+  +-------------------------> H             any_thread_running            H
+                              H                                           H
+  +-------------------------> H                                           H
+  |                           #===========================================#
+  | schedule_entry              |                       ^
+  | schedule_entry_preempt      | sched_need_resched    | schedule_entry
+  |                             |                      schedule_entry_preempt
+  |                             v                       |
+  |                           +----------------------+  |
+  |                      +--- |                      |  |
+  |   sched_need_resched |    |     rescheduling     | -+
+  |                      +--> |                      |
+  |                           +----------------------+
+  |                             | irq_entry
+  |                             v
+  |                           +----------------------+
+  |                           |                      | ---+
+  |                      ---> |                      |    | sched_need_resched
+  |                           |      preempt_irq     |    | irq_entry
+  |                           |                      | <--+
+  |                           |                      | <--+
+  |                           +----------------------+    |
+  |                             | schedule_entry          | sched_need_resched
+  |                             | schedule_entry_preempt  |
+  |                             v                         |
+  |                           +-----------------------+   |
+  +-------------------------- |    nested_preempt     | --+
+                              +-----------------------+
+                                ^ irq_entry         |
+                                +-------------------+
+
+Due to how the ``need_resched`` flag on the preemption count works on arm64,
+this monitor is unstable on that architecture, as it often records preemption
+when the flag is not set, even in presence of the workaround above.
+For the time being, the monitor is disabled by default on arm64.
+
+Monitor sssw
+------------
+
+The set state sleep and wakeup (sssw) monitor ensures ``set_state`` to
+sleepable leads to sleeping and sleeping tasks require wakeup. It includes the
+following types of switch:
+
+* ``switch_suspend``:
+  a task puts itself to sleep, this can happen only after explicitly setting
+  the task to ``sleepable``. After a task is suspended, it needs to be woken up
+  (``waking`` state) before being switched in again.
+  Setting the task's state to ``sleepable`` can be reverted before switching if it
+  is woken up or set to ``runnable``.
+* ``switch_blocking``:
+  a special case of a ``switch_suspend`` where the task is waiting on a
+  sleeping RT lock (``PREEMPT_RT`` only), it is common to see wakeup and set
+  state events racing with each other and this leads the model to perceive this
+  type of switch when the task is not set to sleepable. This is a limitation of
+  the model in SMP system and workarounds may slow down the system.
+* ``switch_preempt``:
+  a task switch as a result of kernel preemption (``schedule_entry_preempt`` in
+  the nrp model).
+* ``switch_yield``:
+  a task explicitly calls the scheduler or is preempted while returning to
+  userspace. It can happen after a ``yield`` system call, from the idle task or
+  if the ``need_resched`` flag is set. By definition, a task cannot yield while
+  ``sleepable`` as that would be a suspension. A special case of a yield occurs
+  when a task in ``TASK_INTERRUPTIBLE`` calls the scheduler while a signal is
+  pending. The task doesn't go through the usual blocking/waking and is set
+  back to runnable, the resulting switch (if there) looks like a yield to the
+  ``signal_wakeup`` state and is followed by the signal delivery. From this
+  state, the monitor expects a signal even if it sees a wakeup event, although
+  not necessary, to rule out false negatives.
+
+This monitor doesn't include a running state, ``sleepable`` and ``runnable``
+are only referring to the task's desired state, which could be scheduled out
+(e.g. due to preemption). However, it does include the event
+``sched_switch_in`` to represent when a task is allowed to become running. This
+can be triggered also by preemption, but cannot occur after the task got to
+``sleeping`` before a ``wakeup`` occurs::
+
+   +--------------------------------------------------------------------------+
+   |                                                                          |
+   |                                                                          |
+   | switch_suspend           |                                               |
+   | switch_blocking          |                                               |
+   v                          v                                               |
+ +----------+              #==========================#   set_state_runnable  |
+ |          |              H                          H   wakeup              |
+ |          |              H                          H   switch_in           |
+ |          |              H                          H   switch_yield        |
+ | sleeping |              H                          H   switch_preempt      |
+ |          |              H                          H   signal_deliver      |
+ |          |  switch_     H                          H ------+               |
+ |          |  _blocking   H         runnable         H       |               |
+ |          | <----------- H                          H <-----+               |
+ +----------+              H                          H                       |
+   |   wakeup              H                          H                       |
+   +---------------------> H                          H                       |
+                           H                          H                       |
+               +---------> H                          H                       |
+               |           #==========================#                       |
+               |             |                ^                               |
+               |             |                | set_state_runnable            |
+               |             |                | wakeup                        |
+               |    set_state_sleepable       |      +------------------------+
+               |             v                |      |
+               |           +--------------------------+  set_state_sleepable
+               |           |                          |  switch_in
+               |           |                          |  switch_preempt
+   signal_deliver          |        sleepable         |  signal_deliver
+               |           |                          | ------+
+               |           |                          |       |
+               |           |                          | <-----+
+               |           +--------------------------+
+               |             |                ^
+               |        switch_yield          | set_state_sleepable
+               |             v                |
+               |           +---------------+  |
+               +---------- | signal_wakeup | -+
+                           +---------------+
+                             ^           | switch_in
+                             |           | switch_preempt
+                             |           | switch_yield
+                             +-----------+ wakeup
+
 References
 ----------
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index b688b24081c8e..59d0db898d4ab 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -55,6 +55,8 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
 source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sts/Kconfig"
+source "kernel/trace/rv/monitors/nrp/Kconfig"
+source "kernel/trace/rv/monitors/sssw/Kconfig"
 # Add new sched monitors here
 
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 1939d3d7621c6..2afac88539d3f 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -14,6 +14,8 @@ obj-$(CONFIG_RV_MON_RTAPP) += monitors/rtapp/rtapp.o
 obj-$(CONFIG_RV_MON_PAGEFAULT) += monitors/pagefault/pagefault.o
 obj-$(CONFIG_RV_MON_SLEEP) += monitors/sleep/sleep.o
 obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
+obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
+obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/nrp/Kconfig b/kernel/trace/rv/monitors/nrp/Kconfig
new file mode 100644
index 0000000000000..f5ec08f65535d
--- /dev/null
+++ b/kernel/trace/rv/monitors/nrp/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_NRP
+	depends on RV
+	depends on RV_MON_SCHED
+	default y if !ARM64
+	select DA_MON_EVENTS_ID
+	bool "nrp monitor"
+	help
+	  Monitor to ensure preemption requires need resched.
+	  This monitor is part of the sched monitors collection.
+
+	  This monitor is unstable on arm64, say N unless you are testing it.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/nrp/nrp.c b/kernel/trace/rv/monitors/nrp/nrp.c
new file mode 100644
index 0000000000000..5a83b71714329
--- /dev/null
+++ b/kernel/trace/rv/monitors/nrp/nrp.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "nrp"
+
+#include <trace/events/irq.h>
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "nrp.h"
+
+static struct rv_monitor rv_nrp;
+DECLARE_DA_MON_PER_TASK(nrp, unsigned char);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/trace/irq_vectors.h>
+
+static void handle_vector_irq_entry(void *data, int vector)
+{
+	da_handle_event_nrp(current, irq_entry_nrp);
+}
+
+static void attach_vector_irq(void)
+{
+	rv_attach_trace_probe("nrp", local_timer_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_IRQ_WORK))
+		rv_attach_trace_probe("nrp", irq_work_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		rv_attach_trace_probe("nrp", reschedule_entry, handle_vector_irq_entry);
+		rv_attach_trace_probe("nrp", call_function_entry, handle_vector_irq_entry);
+		rv_attach_trace_probe("nrp", call_function_single_entry, handle_vector_irq_entry);
+	}
+}
+
+static void detach_vector_irq(void)
+{
+	rv_detach_trace_probe("nrp", local_timer_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_IRQ_WORK))
+		rv_detach_trace_probe("nrp", irq_work_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		rv_detach_trace_probe("nrp", reschedule_entry, handle_vector_irq_entry);
+		rv_detach_trace_probe("nrp", call_function_entry, handle_vector_irq_entry);
+		rv_detach_trace_probe("nrp", call_function_single_entry, handle_vector_irq_entry);
+	}
+}
+
+#else
+/* We assume irq_entry tracepoints are sufficient on other architectures */
+static void attach_vector_irq(void) { }
+static void detach_vector_irq(void) { }
+#endif
+
+static void handle_irq_entry(void *data, int irq, struct irqaction *action)
+{
+	da_handle_event_nrp(current, irq_entry_nrp);
+}
+
+static void handle_sched_need_resched(void *data, struct task_struct *tsk,
+				      int cpu, int tif)
+{
+	/*
+	 * Although need_resched leads to both the rescheduling and preempt_irq
+	 * states, it is safer to start the monitor always in preempt_irq,
+	 * which may not mirror the system state but makes the monitor simpler,
+	 */
+	if (tif == TIF_NEED_RESCHED)
+		da_handle_start_event_nrp(tsk, sched_need_resched_nrp);
+}
+
+static void handle_schedule_entry(void *data, bool preempt)
+{
+	if (preempt)
+		da_handle_event_nrp(current, schedule_entry_preempt_nrp);
+	else
+		da_handle_event_nrp(current, schedule_entry_nrp);
+}
+
+static int enable_nrp(void)
+{
+	int retval;
+
+	retval = da_monitor_init_nrp();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("nrp", irq_handler_entry, handle_irq_entry);
+	rv_attach_trace_probe("nrp", sched_set_need_resched_tp, handle_sched_need_resched);
+	rv_attach_trace_probe("nrp", sched_entry_tp, handle_schedule_entry);
+	attach_vector_irq();
+
+	return 0;
+}
+
+static void disable_nrp(void)
+{
+	rv_nrp.enabled = 0;
+
+	rv_detach_trace_probe("nrp", irq_handler_entry, handle_irq_entry);
+	rv_detach_trace_probe("nrp", sched_set_need_resched_tp, handle_sched_need_resched);
+	rv_detach_trace_probe("nrp", sched_entry_tp, handle_schedule_entry);
+	detach_vector_irq();
+
+	da_monitor_destroy_nrp();
+}
+
+static struct rv_monitor rv_nrp = {
+	.name = "nrp",
+	.description = "need resched preempts.",
+	.enable = enable_nrp,
+	.disable = disable_nrp,
+	.reset = da_monitor_reset_all_nrp,
+	.enabled = 0,
+};
+
+static int __init register_nrp(void)
+{
+	return rv_register_monitor(&rv_nrp, &rv_sched);
+}
+
+static void __exit unregister_nrp(void)
+{
+	rv_unregister_monitor(&rv_nrp);
+}
+
+module_init(register_nrp);
+module_exit(unregister_nrp);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("nrp: need resched preempts.");
diff --git a/kernel/trace/rv/monitors/nrp/nrp.h b/kernel/trace/rv/monitors/nrp/nrp.h
new file mode 100644
index 0000000000000..c9f12207cbf6b
--- /dev/null
+++ b/kernel/trace/rv/monitors/nrp/nrp.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of nrp automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_nrp {
+	preempt_irq_nrp = 0,
+	any_thread_running_nrp,
+	nested_preempt_nrp,
+	rescheduling_nrp,
+	state_max_nrp
+};
+
+#define INVALID_STATE state_max_nrp
+
+enum events_nrp {
+	irq_entry_nrp = 0,
+	sched_need_resched_nrp,
+	schedule_entry_nrp,
+	schedule_entry_preempt_nrp,
+	event_max_nrp
+};
+
+struct automaton_nrp {
+	char *state_names[state_max_nrp];
+	char *event_names[event_max_nrp];
+	unsigned char function[state_max_nrp][event_max_nrp];
+	unsigned char initial_state;
+	bool final_states[state_max_nrp];
+};
+
+static const struct automaton_nrp automaton_nrp = {
+	.state_names = {
+		"preempt_irq",
+		"any_thread_running",
+		"nested_preempt",
+		"rescheduling"
+	},
+	.event_names = {
+		"irq_entry",
+		"sched_need_resched",
+		"schedule_entry",
+		"schedule_entry_preempt"
+	},
+	.function = {
+		{
+			preempt_irq_nrp,
+			preempt_irq_nrp,
+			nested_preempt_nrp,
+			nested_preempt_nrp
+		},
+		{
+			any_thread_running_nrp,
+			rescheduling_nrp,
+			any_thread_running_nrp,
+			INVALID_STATE
+		},
+		{
+			nested_preempt_nrp,
+			preempt_irq_nrp,
+			any_thread_running_nrp,
+			any_thread_running_nrp
+		},
+		{
+			preempt_irq_nrp,
+			rescheduling_nrp,
+			any_thread_running_nrp,
+			any_thread_running_nrp
+		},
+	},
+	.initial_state = preempt_irq_nrp,
+	.final_states = { 0, 1, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/nrp/nrp_trace.h b/kernel/trace/rv/monitors/nrp/nrp_trace.h
new file mode 100644
index 0000000000000..2e13497de3b6f
--- /dev/null
+++ b/kernel/trace/rv/monitors/nrp/nrp_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_NRP
+DEFINE_EVENT(event_da_monitor_id, event_nrp,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_nrp,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+#endif /* CONFIG_RV_MON_NRP */
diff --git a/kernel/trace/rv/monitors/sched/Kconfig b/kernel/trace/rv/monitors/sched/Kconfig
index ae3eb410abd78..aa16456da8647 100644
--- a/kernel/trace/rv/monitors/sched/Kconfig
+++ b/kernel/trace/rv/monitors/sched/Kconfig
@@ -2,6 +2,7 @@
 #
 config RV_MON_SCHED
 	depends on RV
+	depends on RV_PER_TASK_MONITORS >= 3
 	bool "sched monitor"
 	help
 	  Collection of monitors to check the scheduler behaves according to specifications.
diff --git a/kernel/trace/rv/monitors/sssw/Kconfig b/kernel/trace/rv/monitors/sssw/Kconfig
new file mode 100644
index 0000000000000..23b7eeb38bbfc
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SSSW
+	depends on RV
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_ID
+	bool "sssw monitor"
+	help
+	  Monitor to ensure sched_set_state to sleepable leads to sleeping and
+	  sleeping tasks require wakeup.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/sssw/sssw.c b/kernel/trace/rv/monitors/sssw/sssw.c
new file mode 100644
index 0000000000000..84b8d890d9d4a
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/sssw.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "sssw"
+
+#include <trace/events/sched.h>
+#include <trace/events/signal.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "sssw.h"
+
+static struct rv_monitor rv_sssw;
+DECLARE_DA_MON_PER_TASK(sssw, unsigned char);
+
+static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+{
+	if (state == TASK_RUNNING)
+		da_handle_start_event_sssw(tsk, sched_set_state_runnable_sssw);
+	else
+		da_handle_event_sssw(tsk, sched_set_state_sleepable_sssw);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	if (preempt)
+		da_handle_event_sssw(prev, sched_switch_preempt_sssw);
+	else if (prev_state == TASK_RUNNING)
+		da_handle_event_sssw(prev, sched_switch_yield_sssw);
+	else if (prev_state == TASK_RTLOCK_WAIT)
+		/* special case of sleeping task with racy conditions */
+		da_handle_event_sssw(prev, sched_switch_blocking_sssw);
+	else
+		da_handle_event_sssw(prev, sched_switch_suspend_sssw);
+	da_handle_event_sssw(next, sched_switch_in_sssw);
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *p)
+{
+	/*
+	 * Wakeup can also lead to signal_wakeup although the system is
+	 * actually runnable. The monitor can safely start with this event.
+	 */
+	da_handle_start_event_sssw(p, sched_wakeup_sssw);
+}
+
+static void handle_signal_deliver(void *data, int sig,
+				   struct kernel_siginfo *info,
+				   struct k_sigaction *ka)
+{
+	da_handle_event_sssw(current, signal_deliver_sssw);
+}
+
+static int enable_sssw(void)
+{
+	int retval;
+
+	retval = da_monitor_init_sssw();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("sssw", sched_set_state_tp, handle_sched_set_state);
+	rv_attach_trace_probe("sssw", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("sssw", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("sssw", signal_deliver, handle_signal_deliver);
+
+	return 0;
+}
+
+static void disable_sssw(void)
+{
+	rv_sssw.enabled = 0;
+
+	rv_detach_trace_probe("sssw", sched_set_state_tp, handle_sched_set_state);
+	rv_detach_trace_probe("sssw", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("sssw", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("sssw", signal_deliver, handle_signal_deliver);
+
+	da_monitor_destroy_sssw();
+}
+
+static struct rv_monitor rv_sssw = {
+	.name = "sssw",
+	.description = "set state sleep and wakeup.",
+	.enable = enable_sssw,
+	.disable = disable_sssw,
+	.reset = da_monitor_reset_all_sssw,
+	.enabled = 0,
+};
+
+static int __init register_sssw(void)
+{
+	return rv_register_monitor(&rv_sssw, &rv_sched);
+}
+
+static void __exit unregister_sssw(void)
+{
+	rv_unregister_monitor(&rv_sssw);
+}
+
+module_init(register_sssw);
+module_exit(unregister_sssw);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("sssw: set state sleep and wakeup.");
diff --git a/kernel/trace/rv/monitors/sssw/sssw.h b/kernel/trace/rv/monitors/sssw/sssw.h
new file mode 100644
index 0000000000000..243d54050c943
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/sssw.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of sssw automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_sssw {
+	runnable_sssw = 0,
+	signal_wakeup_sssw,
+	sleepable_sssw,
+	sleeping_sssw,
+	state_max_sssw
+};
+
+#define INVALID_STATE state_max_sssw
+
+enum events_sssw {
+	sched_set_state_runnable_sssw = 0,
+	sched_set_state_sleepable_sssw,
+	sched_switch_blocking_sssw,
+	sched_switch_in_sssw,
+	sched_switch_preempt_sssw,
+	sched_switch_suspend_sssw,
+	sched_switch_yield_sssw,
+	sched_wakeup_sssw,
+	signal_deliver_sssw,
+	event_max_sssw
+};
+
+struct automaton_sssw {
+	char *state_names[state_max_sssw];
+	char *event_names[event_max_sssw];
+	unsigned char function[state_max_sssw][event_max_sssw];
+	unsigned char initial_state;
+	bool final_states[state_max_sssw];
+};
+
+static const struct automaton_sssw automaton_sssw = {
+	.state_names = {
+		"runnable",
+		"signal_wakeup",
+		"sleepable",
+		"sleeping"
+	},
+	.event_names = {
+		"sched_set_state_runnable",
+		"sched_set_state_sleepable",
+		"sched_switch_blocking",
+		"sched_switch_in",
+		"sched_switch_preempt",
+		"sched_switch_suspend",
+		"sched_switch_yield",
+		"sched_wakeup",
+		"signal_deliver"
+	},
+	.function = {
+		{
+			runnable_sssw,
+			sleepable_sssw,
+			sleeping_sssw,
+			runnable_sssw,
+			runnable_sssw,
+			INVALID_STATE,
+			runnable_sssw,
+			runnable_sssw,
+			runnable_sssw
+		},
+		{
+			INVALID_STATE,
+			sleepable_sssw,
+			INVALID_STATE,
+			signal_wakeup_sssw,
+			signal_wakeup_sssw,
+			INVALID_STATE,
+			signal_wakeup_sssw,
+			signal_wakeup_sssw,
+			runnable_sssw
+		},
+		{
+			runnable_sssw,
+			sleepable_sssw,
+			sleeping_sssw,
+			sleepable_sssw,
+			sleepable_sssw,
+			sleeping_sssw,
+			signal_wakeup_sssw,
+			runnable_sssw,
+			sleepable_sssw
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			runnable_sssw,
+			INVALID_STATE
+		},
+	},
+	.initial_state = runnable_sssw,
+	.final_states = { 1, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/sssw/sssw_trace.h b/kernel/trace/rv/monitors/sssw/sssw_trace.h
new file mode 100644
index 0000000000000..6c03cfc6960bf
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/sssw_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SSSW
+DEFINE_EVENT(event_da_monitor_id, event_sssw,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_sssw,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+#endif /* CONFIG_RV_MON_SSSW */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index fa9613cb94699..4c89032f01efe 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -123,6 +123,8 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 
 #include <monitors/wwnr/wwnr_trace.h>
 #include <monitors/snroc/snroc_trace.h>
+#include <monitors/nrp/nrp_trace.h>
+#include <monitors/sssw/sssw_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
 #endif /* CONFIG_DA_MON_EVENTS_ID */
diff --git a/tools/verification/models/sched/nrp.dot b/tools/verification/models/sched/nrp.dot
new file mode 100644
index 0000000000000..77bb64669416e
--- /dev/null
+++ b/tools/verification/models/sched/nrp.dot
@@ -0,0 +1,29 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = doublecircle] "any_thread_running"};
+	{node [shape = circle] "any_thread_running"};
+	{node [shape = circle] "nested_preempt"};
+	{node [shape = plaintext, style=invis, label=""] "__init_preempt_irq"};
+	{node [shape = circle] "preempt_irq"};
+	{node [shape = circle] "rescheduling"};
+	"__init_preempt_irq" -> "preempt_irq";
+	"any_thread_running" [label = "any_thread_running", color = green3];
+	"any_thread_running" -> "any_thread_running" [ label = "schedule_entry\nirq_entry" ];
+	"any_thread_running" -> "rescheduling" [ label = "sched_need_resched" ];
+	"nested_preempt" [label = "nested_preempt"];
+	"nested_preempt" -> "any_thread_running" [ label = "schedule_entry_preempt\nschedule_entry" ];
+	"nested_preempt" -> "nested_preempt" [ label = "irq_entry" ];
+	"nested_preempt" -> "preempt_irq" [ label = "sched_need_resched" ];
+	"preempt_irq" [label = "preempt_irq"];
+	"preempt_irq" -> "nested_preempt" [ label = "schedule_entry_preempt\nschedule_entry" ];
+	"preempt_irq" -> "preempt_irq" [ label = "irq_entry\nsched_need_resched" ];
+	"rescheduling" [label = "rescheduling"];
+	"rescheduling" -> "any_thread_running" [ label = "schedule_entry_preempt\nschedule_entry" ];
+	"rescheduling" -> "preempt_irq" [ label = "irq_entry" ];
+	"rescheduling" -> "rescheduling" [ label = "sched_need_resched" ];
+	{ rank = min ;
+		"__init_preempt_irq";
+		"preempt_irq";
+	}
+}
diff --git a/tools/verification/models/sched/sssw.dot b/tools/verification/models/sched/sssw.dot
new file mode 100644
index 0000000000000..4994c3e876be8
--- /dev/null
+++ b/tools/verification/models/sched/sssw.dot
@@ -0,0 +1,30 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_runnable"};
+	{node [shape = doublecircle] "runnable"};
+	{node [shape = circle] "runnable"};
+	{node [shape = circle] "signal_wakeup"};
+	{node [shape = circle] "sleepable"};
+	{node [shape = circle] "sleeping"};
+	"__init_runnable" -> "runnable";
+	"runnable" [label = "runnable", color = green3];
+	"runnable" -> "runnable" [ label = "sched_set_state_runnable\nsched_wakeup\nsched_switch_in\nsched_switch_yield\nsched_switch_preempt\nsignal_deliver" ];
+	"runnable" -> "sleepable" [ label = "sched_set_state_sleepable" ];
+	"runnable" -> "sleeping" [ label = "sched_switch_blocking" ];
+	"signal_wakeup" [label = "signal_wakeup"];
+	"signal_wakeup" -> "runnable" [ label = "signal_deliver" ];
+	"signal_wakeup" -> "signal_wakeup" [ label = "sched_switch_in\nsched_switch_preempt\nsched_switch_yield\nsched_wakeup" ];
+	"signal_wakeup" -> "sleepable" [ label = "sched_set_state_sleepable" ];
+	"sleepable" [label = "sleepable"];
+	"sleepable" -> "runnable" [ label = "sched_set_state_runnable\nsched_wakeup" ];
+	"sleepable" -> "signal_wakeup" [ label = "sched_switch_yield" ];
+	"sleepable" -> "sleepable" [ label = "sched_set_state_sleepable\nsched_switch_in\nsched_switch_preempt\nsignal_deliver" ];
+	"sleepable" -> "sleeping" [ label = "sched_switch_suspend\nsched_switch_blocking" ];
+	"sleeping" [label = "sleeping"];
+	"sleeping" -> "runnable" [ label = "sched_wakeup" ];
+	{ rank = min ;
+		"__init_runnable";
+		"runnable";
+	}
+}
-- 
2.50.1

