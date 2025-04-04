Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629671A2381
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Apr 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756406; cv=none; b=rXSkzlfBH5wz8rJYBUfhdaV9cl9V1BfBu4tg3ETO4lvNxQ1n3CQ9SnSSCzvE1nP0AUjaarF0MiOXeyrVDcWUOO//Ti9LvIoiSqe0smderaNkJtAa1eRzqIKXWwdiaiLfuMSRa8/LjdTmJRv87/KP1U3zfm6QwohZzUuMKnexryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756406; c=relaxed/simple;
	bh=i50gM4tT7IX3sEifqfq8pGEWMGHVZQ+2c+EUAQaVzsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKeijZXsjzdbFy33UPSjiiUgU8TYCMPraFNXV5wR94zWzWyrqAyfe0+aKivUWQX5iyG4peEaViW6isnu2wF1w1AGSKQxQ1B4wpkm0RzJJ7vAfZQhchimRiDNhexHAMuK9ezyi3ZYafWx9hFbLXNPdynnD3usXQkUS851SUlUUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kzgalc2w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kzgalc2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743756401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHoXIcEPqV4uyZhMjS0Q0v//R28OV1XzZQ86XVfDjxo=;
	b=Kzgalc2wFC9OAq1AJrrotfrZ7zpmOk2Ze5b+5l+w9ATNif/HfwDISSLKb9X2Q6tvXAfGGA
	D3r7OFdLpOqJVhqlpGrgCxByP9DzUCN2Im6zFHTQWGLoq2wpOIsyvKot1I+rVLfUSNX0m3
	YsQLenDZkpOr5bULKln0fjThurcTd+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-gcht6rFmNHGeeDtYtC7HNQ-1; Fri,
 04 Apr 2025 04:46:39 -0400
X-MC-Unique: gcht6rFmNHGeeDtYtC7HNQ-1
X-Mimecast-MFC-AGG-ID: gcht6rFmNHGeeDtYtC7HNQ_1743756398
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F6BD1954B33;
	Fri,  4 Apr 2025 08:46:38 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23B9A180A803;
	Fri,  4 Apr 2025 08:46:32 +0000 (UTC)
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
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH 9/9] rv: Add srs per-task monitor
Date: Fri,  4 Apr 2025 10:45:22 +0200
Message-ID: <20250404084512.98552-20-gmonaco@redhat.com>
In-Reply-To: <20250404084512.98552-11-gmonaco@redhat.com>
References: <20250404084512.98552-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a per-task monitor for task switches as part of the sched model:

* srs:
    Monitor to describe conditions for different types of task switch.
    This monitor enforces rules such as preempt after setting need
    for reschedule and suspend after setting a task to sleepable.

This new monitor implies the previously introduced snroc (set non
runnable on its own context), so replace that monitor with srs.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst      | 169 +++++++++++++++---
 kernel/trace/rv/Kconfig                       |   2 +-
 kernel/trace/rv/Makefile                      |   2 +-
 kernel/trace/rv/monitors/snroc/snroc.c        |  85 ---------
 kernel/trace/rv/monitors/snroc/snroc.h        |  47 -----
 .../trace/rv/monitors/{snroc => srs}/Kconfig  |   8 +-
 kernel/trace/rv/monitors/srs/srs.c            | 135 ++++++++++++++
 kernel/trace/rv/monitors/srs/srs.h            |  87 +++++++++
 .../{snroc/snroc_trace.h => srs/srs_trace.h}  |   8 +-
 kernel/trace/rv/rv_trace.h                    |   2 +-
 tools/verification/models/sched/snroc.dot     |  18 --
 tools/verification/models/sched/srs.dot       |  61 +++++++
 12 files changed, 443 insertions(+), 181 deletions(-)
 delete mode 100644 kernel/trace/rv/monitors/snroc/snroc.c
 delete mode 100644 kernel/trace/rv/monitors/snroc/snroc.h
 rename kernel/trace/rv/monitors/{snroc => srs}/Kconfig (52%)
 create mode 100644 kernel/trace/rv/monitors/srs/srs.c
 create mode 100644 kernel/trace/rv/monitors/srs/srs.h
 rename kernel/trace/rv/monitors/{snroc/snroc_trace.h => srs/srs_trace.h} (67%)
 delete mode 100644 tools/verification/models/sched/snroc.dot
 create mode 100644 tools/verification/models/sched/srs.dot

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 641e70e359aaa..c1516b71b8e73 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -61,27 +61,6 @@ happen only in thread context::
                                             |
                        scheduling_context  -+
 
-Monitor snroc
-~~~~~~~~~~~~~
-
-The set non runnable on its own context (snroc) monitor ensures changes in a
-task state happens only in the respective task's context. This is a per-task
-monitor::
-
-                        |
-                        |
-                        v
-                      +------------------+
-                      |  other_context   | <+
-                      +------------------+  |
-                        |                   |
-                        | sched_switch_in   | sched_switch_out
-                        v                   |
-    sched_set_state                         |
-  +------------------                       |
-  |                       own_context       |
-  +----------------->                      -+
-
 Monitor scpd
 ~~~~~~~~~~~~
 
@@ -193,6 +172,154 @@ real task switch occurs::
   +-------------- |                    | <-------------+
                   +--------------------+
 
+Monitor srs
+-----------
+
+The switch after resched or sleep (srs) monitor describes conditions for
+different types of task switch. This is a complex model, below we are going to
+explain it step by step. Unfortunately splitting this into smaller monitor is
+not trivial due to some shared events such as ``switch_in``::
+
+                                                      set_runnable
+                                  |                        wakeup +---+
+                                  |                   switch_vain |   |
+                                  v                               |   v      wakeup
+                         #================================================#  set_runnable
+      switch_in          H                                                H <----------+
+    +------------------> H                    running                     H            |
+    |                    H                                                H -----+     |
+    |                    #================================================#      |     |
+    |                         |        |                |         ^    ^         |     |
+    |                         |  switch_yield      need_resched   |    |         |     |
+    |                         |        |      need_resched_lazy   |    |         |     |
+    |                set_sleepable     v                |         |    |         |     |
+    |                         |      +-------------+    |         |    |         |     |
+    |                +--------+----> |  preempted  | ---+- switch_in   |         |     |
+    |                |        |      +-------------+    |              |         |     |
+    |        switch_preempt   |        |                |              |         |     |
+    |        switch_yield     |   need_resched          |   +- switch_vain       |     |
+    |                |        |        v                |   |                    |     |
+    |                |        |      +-------------+    |   |                    |     |
+    |  need_resched -+--------+----> | resched_out |    |   |                    |     |
+    |  |             |        |      +-------------+    |   |                    |     |
+    |  |             |        |        |                |   |     need_resched   |     |
+    |  |             |        |    switch_in            |   |     wakeup         |     |
+    |  |             |        |        v                v   |     set_runnable   |     |
+    |  |             |        |      +--------------------------+ -------+       |     |
+    |  |             |        |      |                          |        |       |     |
+    |  |             +--------+----- |       rescheduling       | <------+       |     |
+    |  |                      |      |                          |                |     |
+    |  |                      |      +--------------------------+ -----------+   |     |
+    |  |                      |        |           ^ wakeup                  |   |     |
+    |  |                      |  set_sleepable   set_runnable                |   |     |
+    |  |                      |        v           |                         |   |     |
+    |  |   +------------------+----- +---------------------------+           |   |     |
+    |  |   |                  |      |                           |           |   |     |
+ +--+--+---+------------------+----> |     resched_sleepable     | ---+      |   |     |
+ |  |  |   |                  |      |                           |    |      |   |     |
+ |  |  |   |    +-------------+----> +---------------------------+    |      |   |     |
+ |  |  |   |    |             |        |           ^      |           |      |   |     |
+ |  |  |   |    |             |  switch_preempt    | need_resched     |      |   |     |
+ |  |  |   |    |             |        |           | set_sleepable    |      |   |     |
+ |  |  |   |    |             |        v           +------+           |      |   |     |
+ |  |  |   |    |             |       +---------------------------+ --+------+---+-----+--+
+ |  |  |   |    |             |       |    preempted_sleepable    |   |      |   |     |  |
+ |  |  |   |    |             |       +---------------------------+ --+------+---+--+  |  |
+ |  |  |   |    |             |         |             ^               |      |   |  |  |  |
+ |  |  |   |    |             |     switch_in   switch_preempt        |      |   |  |  |  |
+ |  |  |   |    |             |         v             |          switch_vain |   |  |  |  |
+ |  |  |   |    |             |        +-------------------------+    |      |   |  |  |  |
+ |  |  |   |    |             +------> |                         | <--+      |   |  |  |  |
+ |  |  |   |    |                      |        sleepable        |           |   |  |  |  |
+ |  |  |   |    +- need_resched------- |                         | ----------+---+--+--+  |
+ |  |  |   |       need_resched_lazy   +-------------------------+           |   |  |     |
+ |  |  |   |                              |      ^      |          switch_block  |  |     |
+ |  |  |   |                              |      | set_sleepable             |   |  |     |
+ |  |  |   |                      switch_block   | switch_vain    +----------+   |  |     |
+ |  |  |   |                    switch_suspend   +------+         |              |  |     |
+ |  |  |   |                              v                       v              |  |     |
+ |  |  |   |   switch_block          +-----------------------------+  switch_block  |     |
+ |  |  |   +-switch_suspend--------> |          sleeping           | <-----------+  |     |
+ |  |  |                             +-----------------------------+                |     |
+ |  |  |                               | wakeup                                     |     |
+ |  |  |                               v                                            |     |
+ |  |  +- need_resched ------------- +-------------+  wakeup                        |     |
+ |  |                                |   waking    | <------------------------------+     |
+ |  +------------------------------- +-------------+                                      |
+ |                                                                                        |
+ |                         +-----------------------+                                      |
+ +----- switch_in -------- | resched_out_sleepable | <-- sched_need_resched --------------+
+                           +-----------------------+
+
+Types of switches:
+
+* ``switch_in``:
+  a non running task is scheduled in, this leads to ``running`` if the task is
+  runnable and ``sleepable`` if the task was preempted before sleeping.
+* ``switch_suspend``:
+  a task puts itself to sleep, this can happen only after explicitly setting
+  the task to ``sleepable``. After a task is suspended, it needs to be woken up
+  (``waking`` state) before being switched in again. The task can be set to
+  ``resched_sleepable`` via a ``need_resched`` but not preempted, in which case it
+  is equivalent to ``sleepable``.
+  Setting the task's state to ``sleepable`` can be reverted before switching if it
+  is woken up or set to runnable.
+* ``switch_blocked``:
+  a special case of a ``switch_suspend`` where the task is waiting on a
+  sleeping RT lock (``PREEMPT_RT`` only), it is common to see wakeup and set
+  state events racing with each other and this leads the model to perceive this
+  type of switch when the task is not set to sleepable. This is a limitation of
+  the model in SMP system and workarounds may require to slow down the
+  scheduler.
+* ``switch_yield``:
+  a task explicitly calls the scheduler, this looks like a preemption as the
+  task is still runnable but the ``need_resched`` flag is not set. It can
+  happen after a ``yield`` system call or from the idle task.
+* ``switch_preempt``:
+  a task is ``preempted``, this can happen after the need for ``rescheduling``
+  has been set, also in its ``lazy`` flavour. ``need_resched`` can be set as a
+  flag to the task or in the per-core preemption count, either of them can
+  trigger a preemption.
+  The task was previously running and can be switched in directly, but it is
+  possible that a task is preempted after it sets itself as ``sleepable``
+  (``preempted_sleepable``), in this condition, once the task is switched back
+  in, it will not be ``running`` but continue its sleeping process in
+  ``sleepable``.
+* ``switch_vain``:
+  a task goes through the scheduler but it is picked as the next task to run,
+  hence no real task switch occurs. Since we run the scheduler, this clears the
+  need to reschedule.
+
+The ``resched_out`` state (``resched_out_sleepable`` if the task is sleepable)
+is a special case reached if the ``need_resched`` is set after picking the next
+task but before switching. In this case, the previous task is switched out
+normally but once it switches in, it can be preempted in ``rescheduling``. This
+can happen, for instance, when a task disables migration and we do a
+dequeue/enqueue before actually switching out.
+
+This monitor has several events that can race with each other, for instance if
+running from multiple CPUs (e.g. ``need_resched`` and ``wakeup`` can occur from
+a remote CPU), we need to account for them in any possible order.
+
+This monitor allows set state (runnable or sleepable) only in states
+``running``, ``rescheduling``, ``resched_sleepable``, and ``sleepable``, and
+not for states where the task is ``sleeping`` or ``preempted``. This implies
+the set state event occurs only in the task's context::
+
+                        |
+                        |
+                        v
+                      +------------------+
+                      |  other_context   | <+
+                      +------------------+  |
+                        |                   |
+                        | switch_in         | switch_out
+                        v                   |
+    sched_set_state                         |
+  +------------------                       |
+  |                       own_context       |
+  +----------------->                      -+
+
 References
 ----------
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index a53a3eca9616d..f296095f1df28 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -29,11 +29,11 @@ source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 source "kernel/trace/rv/monitors/sched/Kconfig"
 source "kernel/trace/rv/monitors/sco/Kconfig"
-source "kernel/trace/rv/monitors/snroc/Kconfig"
 source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
 source "kernel/trace/rv/monitors/sts/Kconfig"
+source "kernel/trace/rv/monitors/srs/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index c609b72275cb8..5aba1d85ad662 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -7,11 +7,11 @@ obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
 obj-$(CONFIG_RV_MON_SCO) += monitors/sco/sco.o
-obj-$(CONFIG_RV_MON_SNROC) += monitors/snroc/snroc.o
 obj-$(CONFIG_RV_MON_SCPD) += monitors/scpd/scpd.o
 obj-$(CONFIG_RV_MON_SNEP) += monitors/snep/snep.o
 obj-$(CONFIG_RV_MON_SNCID) += monitors/sncid/sncid.o
 obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
+obj-$(CONFIG_RV_MON_SRS) += monitors/srs/srs.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
deleted file mode 100644
index bb1f60d552960..0000000000000
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ /dev/null
@@ -1,85 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/ftrace.h>
-#include <linux/tracepoint.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/rv.h>
-#include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
-
-#define MODULE_NAME "snroc"
-
-#include <trace/events/sched.h>
-#include <rv_trace.h>
-#include <monitors/sched/sched.h>
-
-#include "snroc.h"
-
-static struct rv_monitor rv_snroc;
-DECLARE_DA_MON_PER_TASK(snroc, unsigned char);
-
-static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
-{
-	da_handle_event_snroc(tsk, sched_set_state_snroc);
-}
-
-static void handle_sched_switch(void *data, bool preempt,
-				struct task_struct *prev,
-				struct task_struct *next,
-				unsigned int prev_state)
-{
-	da_handle_start_event_snroc(prev, sched_switch_out_snroc);
-	da_handle_event_snroc(next, sched_switch_in_snroc);
-}
-
-static int enable_snroc(void)
-{
-	int retval;
-
-	retval = da_monitor_init_snroc();
-	if (retval)
-		return retval;
-
-	rv_attach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
-	rv_attach_trace_probe("snroc", sched_switch, handle_sched_switch);
-
-	return 0;
-}
-
-static void disable_snroc(void)
-{
-	rv_snroc.enabled = 0;
-
-	rv_detach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
-	rv_detach_trace_probe("snroc", sched_switch, handle_sched_switch);
-
-	da_monitor_destroy_snroc();
-}
-
-static struct rv_monitor rv_snroc = {
-	.name = "snroc",
-	.description = "set non runnable on its own context.",
-	.enable = enable_snroc,
-	.disable = disable_snroc,
-	.reset = da_monitor_reset_all_snroc,
-	.enabled = 0,
-};
-
-static int __init register_snroc(void)
-{
-	rv_register_monitor(&rv_snroc, &rv_sched);
-	return 0;
-}
-
-static void __exit unregister_snroc(void)
-{
-	rv_unregister_monitor(&rv_snroc);
-}
-
-module_init(register_snroc);
-module_exit(unregister_snroc);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
-MODULE_DESCRIPTION("snroc: set non runnable on its own context.");
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
deleted file mode 100644
index c3650a2b1b107..0000000000000
--- a/kernel/trace/rv/monitors/snroc/snroc.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Automatically generated C representation of snroc automaton
- * For further information about this format, see kernel documentation:
- *   Documentation/trace/rv/deterministic_automata.rst
- */
-
-enum states_snroc {
-	other_context_snroc = 0,
-	own_context_snroc,
-	state_max_snroc
-};
-
-#define INVALID_STATE state_max_snroc
-
-enum events_snroc {
-	sched_set_state_snroc = 0,
-	sched_switch_in_snroc,
-	sched_switch_out_snroc,
-	event_max_snroc
-};
-
-struct automaton_snroc {
-	char *state_names[state_max_snroc];
-	char *event_names[event_max_snroc];
-	unsigned char function[state_max_snroc][event_max_snroc];
-	unsigned char initial_state;
-	bool final_states[state_max_snroc];
-};
-
-static const struct automaton_snroc automaton_snroc = {
-	.state_names = {
-		"other_context",
-		"own_context"
-	},
-	.event_names = {
-		"sched_set_state",
-		"sched_switch_in",
-		"sched_switch_out"
-	},
-	.function = {
-		{      INVALID_STATE,  own_context_snroc,       INVALID_STATE },
-		{  own_context_snroc,      INVALID_STATE, other_context_snroc },
-	},
-	.initial_state = other_context_snroc,
-	.final_states = { 1, 0 },
-};
diff --git a/kernel/trace/rv/monitors/snroc/Kconfig b/kernel/trace/rv/monitors/srs/Kconfig
similarity index 52%
rename from kernel/trace/rv/monitors/snroc/Kconfig
rename to kernel/trace/rv/monitors/srs/Kconfig
index 6e4365a2fea3b..a5b3998b32328 100644
--- a/kernel/trace/rv/monitors/snroc/Kconfig
+++ b/kernel/trace/rv/monitors/srs/Kconfig
@@ -1,13 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-config RV_MON_SNROC
+config RV_MON_SRS
 	depends on RV
 	depends on RV_MON_SCHED
 	default y
 	select DA_MON_EVENTS_ID
-	bool "snroc monitor"
+	bool "srs monitor"
 	help
-	  Monitor to ensure sched_set_state happens only in the respective task's context.
+	  Monitor to describe conditions for different types of task switch.
+	  This monitor enforces rules such as preempt after setting need
+	  for reschedule and suspend after setting a task to sleepable.
 	  This monitor is part of the sched monitors collection.
 
 	  For further information, see:
diff --git a/kernel/trace/rv/monitors/srs/srs.c b/kernel/trace/rv/monitors/srs/srs.c
new file mode 100644
index 0000000000000..3ea7419581e06
--- /dev/null
+++ b/kernel/trace/rv/monitors/srs/srs.c
@@ -0,0 +1,135 @@
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
+#define MODULE_NAME "srs"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "srs.h"
+
+static struct rv_monitor rv_srs;
+DECLARE_DA_MON_PER_TASK(srs, unsigned char);
+
+static void handle_sched_need_resched(void *data, struct task_struct *tsk, int cpu, int tif)
+{
+	if (tif == TIF_NEED_RESCHED)
+		da_handle_event_srs(tsk, sched_need_resched_srs);
+	else
+		da_handle_event_srs(tsk, sched_need_resched_lazy_srs);
+}
+
+static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+{
+	/* special case from preempt_enable */
+	if (preempt && unlikely(!tif_need_resched() && test_preempt_need_resched()))
+		da_handle_event_srs(current, sched_need_resched_srs);
+}
+
+static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+{
+	if (state == TASK_RUNNING)
+		da_handle_event_srs(tsk, sched_set_state_runnable_srs);
+	else
+		da_handle_event_srs(tsk, sched_set_state_sleepable_srs);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	if (preempt)
+		da_handle_event_srs(prev, sched_switch_preempt_srs);
+	else if (prev_state == TASK_RUNNING)
+		da_handle_start_run_event_srs(prev, sched_switch_yield_srs);
+	else if (prev_state == TASK_RTLOCK_WAIT)
+		/* special case of sleeping task with racy conditions */
+		da_handle_event_srs(prev, sched_switch_blocking_srs);
+	else
+		da_handle_event_srs(prev, sched_switch_suspend_srs);
+	/* switch in also leads to sleepable or rescheduling */
+	if (task_is_running(next) && !test_tsk_thread_flag(next, TIF_NEED_RESCHED))
+		da_handle_start_event_srs(next, sched_switch_in_srs);
+	else
+		da_handle_event_srs(next, sched_switch_in_srs);
+}
+
+static void handle_sched_switch_vain(void *data, bool preempt,
+				     struct task_struct *tsk,
+				     unsigned int tsk_state)
+{
+	da_handle_event_srs(tsk, sched_switch_vain_srs);
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *p)
+{
+	da_handle_event_srs(p, sched_wakeup_srs);
+}
+
+static int enable_srs(void)
+{
+	int retval;
+
+	retval = da_monitor_init_srs();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("srs", sched_set_need_resched_tp, handle_sched_need_resched);
+	rv_attach_trace_probe("srs", sched_set_state_tp, handle_sched_set_state);
+	rv_attach_trace_probe("srs", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("srs", sched_switch_vain_tp, handle_sched_switch_vain);
+	rv_attach_trace_probe("srs", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("srs", sched_entry_tp, handle_schedule_entry);
+
+	return 0;
+}
+
+static void disable_srs(void)
+{
+	rv_srs.enabled = 0;
+
+	rv_detach_trace_probe("srs", sched_set_need_resched_tp, handle_sched_need_resched);
+	rv_detach_trace_probe("srs", sched_set_state_tp, handle_sched_set_state);
+	rv_detach_trace_probe("srs", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("srs", sched_switch_vain_tp, handle_sched_switch_vain);
+	rv_detach_trace_probe("srs", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("srs", sched_entry_tp, handle_schedule_entry);
+
+	da_monitor_destroy_srs();
+}
+
+static struct rv_monitor rv_srs = {
+	.name = "srs",
+	.description = "switch after resched or sleep.",
+	.enable = enable_srs,
+	.disable = disable_srs,
+	.reset = da_monitor_reset_all_srs,
+	.enabled = 0,
+};
+
+static int __init register_srs(void)
+{
+	rv_register_monitor(&rv_srs, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_srs(void)
+{
+	rv_unregister_monitor(&rv_srs);
+}
+
+module_init(register_srs);
+module_exit(unregister_srs);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("srs: switch after resched or sleep.");
diff --git a/kernel/trace/rv/monitors/srs/srs.h b/kernel/trace/rv/monitors/srs/srs.h
new file mode 100644
index 0000000000000..ce2005880a105
--- /dev/null
+++ b/kernel/trace/rv/monitors/srs/srs.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of srs automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_srs {
+	running_srs = 0,
+	preempted_srs,
+	preempted_sleepable_srs,
+	resched_out_srs,
+	resched_out_sleepable_srs,
+	resched_sleepable_srs,
+	rescheduling_srs,
+	sleepable_srs,
+	sleeping_srs,
+	waking_srs,
+	state_max_srs
+};
+
+#define INVALID_STATE state_max_srs
+
+enum events_srs {
+	sched_need_resched_srs = 0,
+	sched_need_resched_lazy_srs,
+	sched_set_state_runnable_srs,
+	sched_set_state_sleepable_srs,
+	sched_switch_blocking_srs,
+	sched_switch_in_srs,
+	sched_switch_preempt_srs,
+	sched_switch_suspend_srs,
+	sched_switch_vain_srs,
+	sched_switch_yield_srs,
+	sched_wakeup_srs,
+	event_max_srs
+};
+
+struct automaton_srs {
+	char *state_names[state_max_srs];
+	char *event_names[event_max_srs];
+	unsigned char function[state_max_srs][event_max_srs];
+	unsigned char initial_state;
+	bool final_states[state_max_srs];
+};
+
+static const struct automaton_srs automaton_srs = {
+	.state_names = {
+		"running",
+		"preempted",
+		"preempted_sleepable",
+		"resched_out",
+		"resched_out_sleepable",
+		"resched_sleepable",
+		"rescheduling",
+		"sleepable",
+		"sleeping",
+		"waking"
+	},
+	.event_names = {
+		"sched_need_resched",
+		"sched_need_resched_lazy",
+		"sched_set_state_runnable",
+		"sched_set_state_sleepable",
+		"sched_switch_blocking",
+		"sched_switch_in",
+		"sched_switch_preempt",
+		"sched_switch_suspend",
+		"sched_switch_vain",
+		"sched_switch_yield",
+		"sched_wakeup"
+	},
+	.function = {
+		{          rescheduling_srs,          rescheduling_srs,               running_srs,             sleepable_srs,              sleeping_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,               running_srs,             preempted_srs,               running_srs },
+		{           resched_out_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,               running_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE },
+		{ resched_out_sleepable_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             sleepable_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,                waking_srs },
+		{             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,          rescheduling_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE },
+		{             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,     resched_sleepable_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE },
+		{     resched_sleepable_srs,             INVALID_STATE,          rescheduling_srs,     resched_sleepable_srs,              sleeping_srs,             INVALID_STATE,   preempted_sleepable_srs,              sleeping_srs,             sleepable_srs,             INVALID_STATE,          rescheduling_srs },
+		{          rescheduling_srs,             INVALID_STATE,          rescheduling_srs,     resched_sleepable_srs,              sleeping_srs,             INVALID_STATE,             preempted_srs,             INVALID_STATE,               running_srs,             preempted_srs,          rescheduling_srs },
+		{     resched_sleepable_srs,     resched_sleepable_srs,               running_srs,             sleepable_srs,              sleeping_srs,             INVALID_STATE,   preempted_sleepable_srs,              sleeping_srs,             sleepable_srs,             INVALID_STATE,               running_srs },
+		{             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,                waking_srs },
+		{           resched_out_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,               running_srs,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE,             INVALID_STATE },
+	},
+	.initial_state = running_srs,
+	.final_states = { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/snroc/snroc_trace.h b/kernel/trace/rv/monitors/srs/srs_trace.h
similarity index 67%
rename from kernel/trace/rv/monitors/snroc/snroc_trace.h
rename to kernel/trace/rv/monitors/srs/srs_trace.h
index 50114cef51229..fd033de926542 100644
--- a/kernel/trace/rv/monitors/snroc/snroc_trace.h
+++ b/kernel/trace/rv/monitors/srs/srs_trace.h
@@ -4,12 +4,12 @@
  * Snippet to be included in rv_trace.h
  */
 
-#ifdef CONFIG_RV_MON_SNROC
-DEFINE_EVENT(event_da_monitor_id, event_snroc,
+#ifdef CONFIG_RV_MON_SRS
+DEFINE_EVENT(event_da_monitor_id, event_srs,
 	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
 	     TP_ARGS(id, state, event, next_state, final_state));
 
-DEFINE_EVENT(error_da_monitor_id, error_snroc,
+DEFINE_EVENT(error_da_monitor_id, error_srs,
 	     TP_PROTO(int id, char *state, char *event),
 	     TP_ARGS(id, state, event));
-#endif /* CONFIG_RV_MON_SNROC */
+#endif /* CONFIG_RV_MON_SRS */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index a5e1c52e29926..f6ead55484751 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -123,7 +123,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 );
 
 #include <monitors/wwnr/wwnr_trace.h>
-#include <monitors/snroc/snroc_trace.h>
+#include <monitors/srs/srs_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
 #endif /* CONFIG_DA_MON_EVENTS_ID */
diff --git a/tools/verification/models/sched/snroc.dot b/tools/verification/models/sched/snroc.dot
deleted file mode 100644
index 8b71c32d4dca4..0000000000000
--- a/tools/verification/models/sched/snroc.dot
+++ /dev/null
@@ -1,18 +0,0 @@
-digraph state_automaton {
-	center = true;
-	size = "7,11";
-	{node [shape = plaintext, style=invis, label=""] "__init_other_context"};
-	{node [shape = ellipse] "other_context"};
-	{node [shape = plaintext] "other_context"};
-	{node [shape = plaintext] "own_context"};
-	"__init_other_context" -> "other_context";
-	"other_context" [label = "other_context", color = green3];
-	"other_context" -> "own_context" [ label = "sched_switch_in" ];
-	"own_context" [label = "own_context"];
-	"own_context" -> "other_context" [ label = "sched_switch_out" ];
-	"own_context" -> "own_context" [ label = "sched_set_state" ];
-	{ rank = min ;
-		"__init_other_context";
-		"other_context";
-	}
-}
diff --git a/tools/verification/models/sched/srs.dot b/tools/verification/models/sched/srs.dot
new file mode 100644
index 0000000000000..8926e1ab59d98
--- /dev/null
+++ b/tools/verification/models/sched/srs.dot
@@ -0,0 +1,61 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_running"};
+	{node [shape = doublecircle] "running"};
+	{node [shape = circle] "preempted"};
+	{node [shape = circle] "preempted_sleepable"};
+	{node [shape = circle] "resched_out"};
+	{node [shape = circle] "resched_out_sleepable"};
+	{node [shape = circle] "resched_sleepable"};
+	{node [shape = circle] "rescheduling"};
+	{node [shape = circle] "running"};
+	{node [shape = circle] "sleepable"};
+	{node [shape = circle] "sleeping"};
+	{node [shape = circle] "waking"};
+	"__init_running" -> "running";
+	"preempted" [label = "preempted"];
+	"preempted" -> "resched_out" [ label = "sched_need_resched" ];
+	"preempted" -> "running" [ label = "sched_switch_in" ];
+	"preempted_sleepable" [label = "preempted_sleepable"];
+	"preempted_sleepable" -> "resched_out_sleepable" [ label = "sched_need_resched" ];
+	"preempted_sleepable" -> "sleepable" [ label = "sched_switch_in" ];
+	"preempted_sleepable" -> "waking" [ label = "sched_wakeup" ];
+	"resched_out" [label = "resched_out"];
+	"resched_out" -> "rescheduling" [ label = "sched_switch_in" ];
+	"resched_out_sleepable" [label = "resched_out_sleepable"];
+	"resched_out_sleepable" -> "resched_sleepable" [ label = "sched_switch_in" ];
+	"resched_sleepable" [label = "resched_sleepable"];
+	"resched_sleepable" -> "preempted_sleepable" [ label = "sched_switch_preempt" ];
+	"resched_sleepable" -> "resched_sleepable" [ label = "sched_need_resched\nsched_set_state_sleepable" ];
+	"resched_sleepable" -> "rescheduling" [ label = "sched_wakeup\nsched_set_state_runnable" ];
+	"resched_sleepable" -> "sleepable" [ label = "sched_switch_vain" ];
+	"resched_sleepable" -> "sleeping" [ label = "sched_switch_suspend\nsched_switch_blocking" ];
+	"rescheduling" [label = "rescheduling"];
+	"rescheduling" -> "preempted" [ label = "sched_switch_preempt\nsched_switch_yield" ];
+	"rescheduling" -> "resched_sleepable" [ label = "sched_set_state_sleepable" ];
+	"rescheduling" -> "rescheduling" [ label = "sched_need_resched\nsched_wakeup\nsched_set_state_runnable" ];
+	"rescheduling" -> "running" [ label = "sched_switch_vain" ];
+	"rescheduling" -> "sleeping" [ label = "sched_switch_blocking" ];
+	"running" [label = "running", color = green3];
+	"running" -> "preempted" [ label = "sched_switch_yield" ];
+	"running" -> "rescheduling" [ label = "sched_need_resched\nsched_need_resched_lazy" ];
+	"running" -> "running" [ label = "sched_set_state_runnable\nsched_wakeup\nsched_switch_vain" ];
+	"running" -> "sleepable" [ label = "sched_set_state_sleepable" ];
+	"running" -> "sleeping" [ label = "sched_switch_blocking" ];
+	"sleepable" [label = "sleepable"];
+	"sleepable" -> "preempted_sleepable" [ label = "sched_switch_preempt" ];
+	"sleepable" -> "resched_sleepable" [ label = "sched_need_resched\nsched_need_resched_lazy" ];
+	"sleepable" -> "running" [ label = "sched_set_state_runnable\nsched_wakeup" ];
+	"sleepable" -> "sleepable" [ label = "sched_set_state_sleepable\nsched_switch_vain" ];
+	"sleepable" -> "sleeping" [ label = "sched_switch_suspend\nsched_switch_blocking" ];
+	"sleeping" [label = "sleeping"];
+	"sleeping" -> "waking" [ label = "sched_wakeup" ];
+	"waking" [label = "waking"];
+	"waking" -> "resched_out" [ label = "sched_need_resched" ];
+	"waking" -> "running" [ label = "sched_switch_in" ];
+	{ rank = min ;
+		"__init_running";
+		"running";
+	}
+}
-- 
2.49.0

