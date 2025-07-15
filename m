Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF700271444
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563805; cv=none; b=ffY2in8+jYtRifNtqBuDl1RLyOgkH+AOKwS/40TtYkKE8wqbjMxM+t8co+Y3hKJZukyiWbKGgQqRy8YzRnkYkXwV/khduqmIOog1eTyg/Mag/qVT5NOvzUPghf9mmwawIZS1CApKTLdlWJEIuOYAQ5wmn+2tvrmYwMOgqUvqcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563805; c=relaxed/simple;
	bh=C9FpPt4mjAevzoQEGNWPfuiXNKmuUNYZl+Cm4CPw3zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EchjK0XmON+II2gw50fghkk2dTVn9xTSGmGd5hKNzbHQkSwjv+V4z3Sc192ODbnh+WeXisZ3RI4+vyENI7Q8LGZk6d8MzLdi9eppBYDKbmKewt8/HatUclIoKq+Um4DiC0vqTfb+QYLAFDWNpoh+w+2huxHChS2GKlGdrmKwyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3m+xdjj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3m+xdjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jcjnNiYIWu2QI/9G/sQy3Mcv+k/bbHwqD/R9rcwbyQ=;
	b=f3m+xdjjDTbDzKiNwmEokm5PRmpzUoBHGgQ3mPqcRX2loFLpDuPrR0GpI4WgWsn1e7wg0t
	6f8du2NOTmsSeN8cL74HikkR2QrZCyF22cj/r7GMW30GOMZGcbaMUCjCO3MhZEg1UHpeAP
	DfWO9BU+6VWrNw7wmuL9yJWSwlmmyUE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-GjawVHHjPW2inTwNqPUO1Q-1; Tue,
 15 Jul 2025 03:16:40 -0400
X-MC-Unique: GjawVHHjPW2inTwNqPUO1Q-1
X-Mimecast-MFC-AGG-ID: GjawVHHjPW2inTwNqPUO1Q_1752563798
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1E3E180029F;
	Tue, 15 Jul 2025 07:16:38 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E3DE180045B;
	Tue, 15 Jul 2025 07:16:32 +0000 (UTC)
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
Subject: [PATCH v3 16/17] rv: Add nrp and sssw per-task monitors
Date: Tue, 15 Jul 2025 09:14:33 +0200
Message-ID: <20250715071434.22508-17-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 Documentation/trace/rv/monitor_sched.rst   | 168 +++++++++++++++++++++
 kernel/trace/rv/Kconfig                    |   2 +
 kernel/trace/rv/Makefile                   |   2 +
 kernel/trace/rv/monitors/nrp/Kconfig       |  14 ++
 kernel/trace/rv/monitors/nrp/nrp.c         | 146 ++++++++++++++++++
 kernel/trace/rv/monitors/nrp/nrp.h         |  87 +++++++++++
 kernel/trace/rv/monitors/nrp/nrp_trace.h   |  15 ++
 kernel/trace/rv/monitors/sched/Kconfig     |   1 +
 kernel/trace/rv/monitors/sssw/Kconfig      |  15 ++
 kernel/trace/rv/monitors/sssw/sssw.c       | 115 ++++++++++++++
 kernel/trace/rv/monitors/sssw/sssw.h       |  97 ++++++++++++
 kernel/trace/rv/monitors/sssw/sssw_trace.h |  15 ++
 kernel/trace/rv/rv_trace.h                 |   2 +
 tools/verification/models/sched/nrp.dot    |  29 ++++
 tools/verification/models/sched/sssw.dot   |  24 +++
 15 files changed, 732 insertions(+)
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
index e4171aadef1c2..4cb6590284786 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -198,6 +198,174 @@ real task switch occurs::
   +-------------- |                    | <-------------+
                   +--------------------+
 
+Monitor nrp
+-----------
+
+The need resched preempts (nrp) monitor ensures preemption requires need
+resched. Only kernel preemptions are considered, since preemptions while
+returning to userspace, for this monitor, are indistinguishable from
+``sched_switch_yield`` (described in the sssw monitor).
+A preemption is any of the following types of ``sched_switch``:
+
+* ``sched_switch_preempt``:
+  a task is ``preempted``, this can happen after the need for ``rescheduling``
+  has been set. This is not valid for the *lazy* variant of the flag, which
+  causes only userspace preemptions.
+* ``sched_switch_vain_preempt``:
+  a task goes through the scheduler from a preemption context but it is picked
+  as the next task to run, hence no real task switch occurs. Since the
+  scheduler runs, this clears the need to reschedule.
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
+occurred, as the situation above is tricky to pinpoint.
+
+This monitor ignores when the task is switched in, as this complicates things
+when different types of ``sched_switch`` occur (e.g. sleeping or yielding, here
+marked as ``sched_switch_other`` or ``sched_switch_vain``). The snroc monitor
+ensures a task is switched in before it can be switched out again.
+For this reason, the ``any_thread_running`` state does not imply that the
+monitored task is not running, simply it is not set for rescheduling::
+
+    sched_switch_other
+    sched_switch_vain
+    irq_entry                 #===========================================#
+  +-------------------------- H                                           H
+  |                           H                                           H
+  +-------------------------> H             any_thread_running            H
+                              H                                           H
+  +-------------------------> H                                           H
+  |                           #===========================================#
+  |                             |                       ^
+  | sched_switch_preempt        |                       | sched_switch_preempt
+  | sched_switch_vain_preempt   |                      sched_switch_vain_preempt
+  | sched_switch_other          | sched_need_resched    | sched_switch_other
+  | sched_switch_vain           |                       | sched_switch_vain
+  |                             v                       |
+  |                           +----------------------+  |
+  |                      +--- |                      |  |
+  |   sched_need_resched |    |     rescheduling     | -+
+  |                      +--> |                      |
+  |                           +----------------------+
+  |                             |
+  |                             | irq_exit
+  |                             v
+  |                           +----------------------+
+  |                           |                      | ---+
+  |                      ---> |                      |    | sched_need_resched
+  |                           |      preempt_irq     |    | irq_exit
+  |                           |                      | <--+
+  |                           |                      | <--+
+  |                           +----------------------+    |
+  |                             |                         |
+  |                             | sched_switch_preempt    |
+  |                            sched_switch_vain_preempt  |
+  |                             | sched_switch_other      | sched_need_resched
+  |                             | sched_switch_vain       |
+  |                             v                         |
+  |                           +-----------------------+   |
+  +-------------------------- |    nested_preempt     | --+
+                              +-----------------------+
+                                ^ irq_entry         |
+                                +-------------------+
+
+Due to how the ``need_resched`` flag on the preemption count works on arm64,
+this monitor is unstable on that architecture, as it often records preemptions
+when the flag is not set, even in presence of the workaround above.
+For the time being, the monitor is disabled by default on arm64.
+
+Monitor sssw
+------------
+
+The set state sleep and wakeup (sssw) monitor ensures ``sched_set_state`` to
+sleepable leads to sleeping and sleeping tasks require wakeup.
+It includes the following types of ``sched_switch``:
+
+* ``switch_suspend``:
+  a task puts itself to sleep, this can happen only after explicitly setting
+  the task to ``sleepable``. After a task is suspended, it needs to be woken up
+  (``waking`` state) before being switched in again.
+  Setting the task's state to ``sleepable`` can be reverted before switching if it
+  is woken up or set to ``runnable``.
+* ``switch_blocked``:
+  a special case of a ``switch_suspend`` where the task is waiting on a
+  sleeping RT lock (``PREEMPT_RT`` only), it is common to see wakeup and set
+  state events racing with each other and this leads the model to perceive this
+  type of switch when the task is not set to sleepable. This is a limitation of
+  the model in SMP system and workarounds may slow down the system.
+* ``switch_yield``:
+  a task explicitly calls the scheduler, this looks like a preemption as the
+  task is still runnable but the ``need_resched`` flag is not set. It can
+  happen after a ``yield`` system call or from the idle task. By definition,
+  a task cannot yield while ``sleepable`` as that would be a suspension.
+* ``switch_vain``:
+  a task explicitly calls the scheduler but it is picked as the next task to run,
+  hence no real task switch occurs. This can occur as a yield, which is not
+  valid when the task is sleepable. A special case of a yield is when a task in
+  ``TASK_INTERRUPTIBLE`` calls the scheduler while a signal is pending. The
+  task doesn't go through the usual blocking/waking and is set back to
+  runnable, the resulting switch looks like a yield.
+
+As for the nrp monitor, this monitor doesn't include a running state,
+``sleepable`` and ``runnable`` are only referring to the task's desired
+state, which could be scheduled out (e.g. due to preemption). However, it does
+include the event ``sched_switch_in`` to represent when a task is allowed to
+become running. This can be triggered also by preemption, but cannot occur
+after the task got to ``sleeping`` until a ``wakeup``::
+
+  sched_set_state_runnable
+  sched_wakeup
+  sched_switch_vain_preempt     |
+  sched_switch_preempt          |
+  sched_switch_yield            v
+  sched_switch_vain        #=============================================#
+       +-----------------> H                                             H
+       |                   H                                             H
+       +------------------ H                  runnable                   H
+                           H                                             H
+       +-----------------> H                                             H
+       |                   #=============================================#
+  sched_set_state_runnable   |                          |            ^
+  sched_wakeup               |               sched_switch_blocking   |
+       |          sched_set_state_sleepable             |            |
+       |                     v                          |            |
+       |                   +------------------------+   |       sched_wakeup
+       +------------------ |                        |   |            |
+                           |                        |   |            |
+       +-----------------> |        sleepable       |   |            |
+       |                   |                        |   |            |
+       +------------------ |                        |   |            |
+  sched_switch_in          +------------------------+   |            |
+  sched_switch_preempt                  |               |            |
+  sched_switch_vain_preempt    sched_switch_suspend     |            |
+  sched_set_state_sleepable    sched_switch_blocking    |            |
+                                        |               |            |
+                                        v               |            |
+                           +------------------------+   |            |
+                           |         sleeping       | <-+            |
+                           +------------------------+                |
+                                        |                            |
+                                        +----------------------------+
+
 References
 ----------
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index da62d97d329aa..2cce1f22892a0 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -51,6 +51,8 @@ source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
 source "kernel/trace/rv/monitors/sts/Kconfig"
+source "kernel/trace/rv/monitors/nrp/Kconfig"
+source "kernel/trace/rv/monitors/sssw/Kconfig"
 # Add new sched monitors here
 
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index db8653f7cedf3..3f517fe639c5a 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -15,6 +15,8 @@ obj-$(CONFIG_RV_MON_RTAPP) += monitors/rtapp/rtapp.o
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
index 0000000000000..f37ff70e8d204
--- /dev/null
+++ b/kernel/trace/rv/monitors/nrp/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_NRP
+	depends on RV
+	depends on RV_MON_SCHED
+	default y if !ARCH_ARM64
+	select DA_MON_EVENTS_ID
+	bool "nrp monitor"
+	help
+	  Monitor to ensure preemption requires need resched.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/nrp/nrp.c b/kernel/trace/rv/monitors/nrp/nrp.c
new file mode 100644
index 0000000000000..90600497dc487
--- /dev/null
+++ b/kernel/trace/rv/monitors/nrp/nrp.c
@@ -0,0 +1,146 @@
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
+static void handle_irq_entry(void *data, int irq, struct irqaction *action)
+{
+	da_handle_event_nrp(current, irq_entry_nrp);
+}
+
+static void handle_sched_need_resched(void *data, struct task_struct *tsk,
+				      int cpu, int tif)
+{
+	if (tif == TIF_NEED_RESCHED)
+		da_handle_start_event_nrp(tsk, sched_need_resched_nrp);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	if (preempt)
+		da_handle_event_nrp(prev, sched_switch_preempt_nrp);
+	else
+		da_handle_event_nrp(prev, sched_switch_other_nrp);
+}
+
+static void handle_sched_switch_vain(void *data, bool preempt,
+				     struct task_struct *tsk,
+				     unsigned int tsk_state)
+{
+	if (preempt)
+		da_handle_event_nrp(tsk, sched_switch_vain_preempt_nrp);
+	else
+		da_handle_event_nrp(tsk, sched_switch_vain_nrp);
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
+	rv_attach_trace_probe("nrp", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("nrp", sched_switch_vain_tp, handle_sched_switch_vain);
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
+	rv_detach_trace_probe("nrp", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("nrp", sched_switch_vain_tp, handle_sched_switch_vain);
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
index 0000000000000..376c5a03dd2e9
--- /dev/null
+++ b/kernel/trace/rv/monitors/nrp/nrp.h
@@ -0,0 +1,87 @@
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
+	sched_switch_other_nrp,
+	sched_switch_preempt_nrp,
+	sched_switch_vain_nrp,
+	sched_switch_vain_preempt_nrp,
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
+		"sched_switch_other",
+		"sched_switch_preempt",
+		"sched_switch_vain",
+		"sched_switch_vain_preempt"
+	},
+	.function = {
+		{
+			preempt_irq_nrp,
+			preempt_irq_nrp,
+			nested_preempt_nrp,
+			nested_preempt_nrp,
+			nested_preempt_nrp,
+			nested_preempt_nrp
+		},
+		{
+			any_thread_running_nrp,
+			rescheduling_nrp,
+			any_thread_running_nrp,
+			INVALID_STATE,
+			any_thread_running_nrp,
+			INVALID_STATE
+		},
+		{
+			nested_preempt_nrp,
+			preempt_irq_nrp,
+			any_thread_running_nrp,
+			any_thread_running_nrp,
+			any_thread_running_nrp,
+			any_thread_running_nrp
+		},
+		{
+			preempt_irq_nrp,
+			rescheduling_nrp,
+			any_thread_running_nrp,
+			any_thread_running_nrp,
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
index 0000000000000..efa695dead36a
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/sssw.c
@@ -0,0 +1,115 @@
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
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "sssw.h"
+
+static struct rv_monitor rv_sssw;
+DECLARE_DA_MON_PER_TASK(sssw, unsigned char);
+
+static void handle_sched_set_state(void *data, struct task_struct *tsk,
+				   int state, bool from_signal)
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
+		da_handle_start_event_sssw(prev, sched_switch_yield_sssw);
+	else if (prev_state == TASK_RTLOCK_WAIT)
+		/* special case of sleeping task with racy conditions */
+		da_handle_event_sssw(prev, sched_switch_blocking_sssw);
+	else
+		da_handle_event_sssw(prev, sched_switch_suspend_sssw);
+	da_handle_event_sssw(next, sched_switch_in_sssw);
+}
+
+static void handle_sched_switch_vain(void *data, bool preempt,
+				     struct task_struct *tsk,
+				     unsigned int tsk_state)
+{
+	if (preempt)
+		da_handle_event_sssw(tsk, sched_switch_vain_preempt_sssw);
+	else
+		da_handle_start_event_sssw(tsk, sched_switch_vain_sssw);
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *p)
+{
+	da_handle_start_event_sssw(p, sched_wakeup_sssw);
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
+	rv_attach_trace_probe("sssw", sched_switch_vain_tp, handle_sched_switch_vain);
+	rv_attach_trace_probe("sssw", sched_wakeup, handle_sched_wakeup);
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
+	rv_detach_trace_probe("sssw", sched_switch_vain_tp, handle_sched_switch_vain);
+	rv_detach_trace_probe("sssw", sched_wakeup, handle_sched_wakeup);
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
index 0000000000000..2b29230f29cff
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/sssw.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of sssw automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_sssw {
+	runnanble_sssw = 0,
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
+	sched_switch_vain_sssw,
+	sched_switch_vain_preempt_sssw,
+	sched_switch_yield_sssw,
+	sched_wakeup_sssw,
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
+		"runnanble",
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
+		"sched_switch_vain",
+		"sched_switch_vain_preempt",
+		"sched_switch_yield",
+		"sched_wakeup"
+	},
+	.function = {
+		{
+			runnanble_sssw,
+			sleepable_sssw,
+			sleeping_sssw,
+			runnanble_sssw,
+			runnanble_sssw,
+			INVALID_STATE,
+			runnanble_sssw,
+			runnanble_sssw,
+			runnanble_sssw,
+			runnanble_sssw
+		},
+		{
+			runnanble_sssw,
+			sleepable_sssw,
+			sleeping_sssw,
+			sleepable_sssw,
+			sleepable_sssw,
+			sleeping_sssw,
+			INVALID_STATE,
+			sleepable_sssw,
+			INVALID_STATE,
+			runnanble_sssw
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			runnanble_sssw
+		},
+	},
+	.initial_state = runnanble_sssw,
+	.final_states = { 1, 0, 0 },
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
index dbd2f2ef513a7..b5cb1d1807fd2 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -124,6 +124,8 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 
 #include <monitors/wwnr/wwnr_trace.h>
 #include <monitors/snroc/snroc_trace.h>
+#include <monitors/nrp/nrp_trace.h>
+#include <monitors/sssw/sssw_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
 #endif /* CONFIG_DA_MON_EVENTS_ID */
diff --git a/tools/verification/models/sched/nrp.dot b/tools/verification/models/sched/nrp.dot
new file mode 100644
index 0000000000000..337ea310f7f8a
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
+	"any_thread_running" -> "any_thread_running" [ label = "sched_switch_other\nsched_switch_vain\nirq_entry" ];
+	"any_thread_running" -> "rescheduling" [ label = "sched_need_resched" ];
+	"nested_preempt" [label = "nested_preempt"];
+	"nested_preempt" -> "any_thread_running" [ label = "sched_switch_preempt\nsched_switch_vain_preempt\nsched_switch_other\nsched_switch_vain" ];
+	"nested_preempt" -> "nested_preempt" [ label = "irq_entry" ];
+	"nested_preempt" -> "preempt_irq" [ label = "sched_need_resched" ];
+	"preempt_irq" [label = "preempt_irq"];
+	"preempt_irq" -> "nested_preempt" [ label = "sched_switch_preempt\nsched_switch_vain_preempt\nsched_switch_other\nsched_switch_vain" ];
+	"preempt_irq" -> "preempt_irq" [ label = "irq_entry\nsched_need_resched" ];
+	"rescheduling" [label = "rescheduling"];
+	"rescheduling" -> "any_thread_running" [ label = "sched_switch_preempt\nsched_switch_vain_preempt\nsched_switch_other\nsched_switch_vain" ];
+	"rescheduling" -> "preempt_irq" [ label = "irq_entry" ];
+	"rescheduling" -> "rescheduling" [ label = "sched_need_resched" ];
+	{ rank = min ;
+		"__init_preempt_irq";
+		"preempt_irq";
+	}
+}
diff --git a/tools/verification/models/sched/sssw.dot b/tools/verification/models/sched/sssw.dot
new file mode 100644
index 0000000000000..362e783f2bd58
--- /dev/null
+++ b/tools/verification/models/sched/sssw.dot
@@ -0,0 +1,24 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_runnanble"};
+	{node [shape = doublecircle] "runnanble"};
+	{node [shape = circle] "runnanble"};
+	{node [shape = circle] "sleepable"};
+	{node [shape = circle] "sleeping"};
+	"__init_runnanble" -> "runnanble";
+	"runnanble" [label = "runnanble", color = green3];
+	"runnanble" -> "runnanble" [ label = "sched_set_state_runnable\nsched_wakeup\nsched_switch_in\nsched_switch_vain\nsched_switch_yield\nsched_switch_preempt\nsched_switch_vain_preempt" ];
+	"runnanble" -> "sleepable" [ label = "sched_set_state_sleepable" ];
+	"runnanble" -> "sleeping" [ label = "sched_switch_blocking" ];
+	"sleepable" [label = "sleepable"];
+	"sleepable" -> "runnanble" [ label = "sched_set_state_runnable\nsched_wakeup" ];
+	"sleepable" -> "sleepable" [ label = "sched_set_state_sleepable\nsched_switch_in\nsched_switch_preempt\nsched_switch_vain_preempt" ];
+	"sleepable" -> "sleeping" [ label = "sched_switch_suspend\nsched_switch_blocking" ];
+	"sleeping" [label = "sleeping"];
+	"sleeping" -> "runnanble" [ label = "sched_wakeup" ];
+	{ rank = min ;
+		"__init_runnanble";
+		"runnanble";
+	}
+}
-- 
2.50.1

