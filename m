Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215D26F478
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710713; cv=none; b=hI8U38xt505e3v9S2kfylyyWIfFxvI5jzI7QVpeF8r+unO9wd/WacsfIxhR0mi1V7/GmBR4TYSN4pyE6GxMJQapFynpEH10CbNJbEkPeQopLBw8zPCRY9gsp5D0UNH4bkA5QcVC+AwKF1GabVrBVK9+XJWy8TiVb8rJmFW3H8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710713; c=relaxed/simple;
	bh=Xy6Mjo15gXVoUvM4/NFiZDsNwAArmJUp1JazCCg2gEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+jlnA+v/lA44FTCVzKBJu5mvQSzfxfHXjGdM+t0G47DdlbeLkwF6ci/J+8IUQeJEqMzJq/wtZLqkZwvZRwJYeuXFHqfN/Jk64xD2wCjXwwznBe8zeidCj2C0oRK8EiX1EmTwJGc38C4mBHw+Tm1TsBgx8535GrfDaX3gC6QPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHR5qKQo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHR5qKQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaRCVtSRV70MOgHzaehafntfEaH1JUJhTDLc3J35uIc=;
	b=AHR5qKQosi7ziriOGtzKnq23kLDdE0PgUVgcuWwcRwQ9mrYK7V1CF785CLbPfN6oJzoXSs
	zUCc9/4os3KX/kOIyxMFs/hqa6X9wKJtNqtn7arNfjSr0pAKy4aW9IWwaswkUanpWhGt54
	CLJM9S4TL0QZR4rdPZxJWz6jke1+klQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-ufG3cPh9MP2EdWYmKyKcrw-1; Mon,
 28 Jul 2025 09:51:47 -0400
X-MC-Unique: ufG3cPh9MP2EdWYmKyKcrw-1
X-Mimecast-MFC-AGG-ID: ufG3cPh9MP2EdWYmKyKcrw_1753710705
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C5CB19560AD;
	Mon, 28 Jul 2025 13:51:45 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0FEE1800287;
	Mon, 28 Jul 2025 13:51:38 +0000 (UTC)
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
Subject: [PATCH v5 9/9] rv: Add opid per-cpu monitor
Date: Mon, 28 Jul 2025 15:50:21 +0200
Message-ID: <20250728135022.255578-10-gmonaco@redhat.com>
In-Reply-To: <20250728135022.255578-1-gmonaco@redhat.com>
References: <20250728135022.255578-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a per-cpu monitor as part of the sched model:
* opid: operations with preemption and irq disabled
    Monitor to ensure wakeup and need_resched occur with irq and
    preemption disabled or in irq handlers.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst   |  55 +++++++
 kernel/trace/rv/Kconfig                    |   1 +
 kernel/trace/rv/Makefile                   |   1 +
 kernel/trace/rv/monitors/opid/Kconfig      |  19 +++
 kernel/trace/rv/monitors/opid/opid.c       | 168 +++++++++++++++++++++
 kernel/trace/rv/monitors/opid/opid.h       | 104 +++++++++++++
 kernel/trace/rv/monitors/opid/opid_trace.h |  15 ++
 kernel/trace/rv/rv_trace.h                 |   1 +
 tools/verification/models/sched/opid.dot   |  35 +++++
 9 files changed, 399 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/opid/Kconfig
 create mode 100644 kernel/trace/rv/monitors/opid/opid.c
 create mode 100644 kernel/trace/rv/monitors/opid/opid.h
 create mode 100644 kernel/trace/rv/monitors/opid/opid_trace.h
 create mode 100644 tools/verification/models/sched/opid.dot

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 11ef963cb578..3f8381ad9ec7 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -341,6 +341,61 @@ can be triggered also by preemption, but cannot occur after the task got to
                              |           | switch_yield
                              +-----------+ wakeup
 
+Monitor opid
+------------
+
+The operations with preemption and irq disabled (opid) monitor ensures
+operations like ``wakeup`` and ``need_resched`` occur with interrupts and
+preemption disabled or during interrupt context, in such case preemption may
+not be disabled explicitly.
+``need_resched`` can be set by some RCU internals functions, in which case it
+doesn't match a task wakeup and might occur with only interrupts disabled::
+
+                 |                     sched_need_resched
+                 |                     sched_waking
+                 |                     irq_entry
+                 |                   +--------------------+
+                 v                   v                    |
+               +------------------------------------------------------+
+  +----------- |                     disabled                         | <+
+  |            +------------------------------------------------------+  |
+  |              |                 ^                                     |
+  |              |          preempt_disable      sched_need_resched      |
+  |       preempt_enable           |           +--------------------+    |
+  |              v                 |           v                    |    |
+  |            +------------------------------------------------------+  |
+  |            |                   irq_disabled                       |  |
+  |            +------------------------------------------------------+  |
+  |                              |             |        ^                |
+  |     irq_entry            irq_entry         |        |                |
+  |     sched_need_resched       v             |   irq_disable           |
+  |     sched_waking +--------------+          |        |                |
+  |           +----- |              |     irq_enable    |                |
+  |           |      |    in_irq    |          |        |                |
+  |           +----> |              |          |        |                |
+  |                  +--------------+          |        |          irq_disable
+  |                     |                      |        |                |
+  | irq_enable          | irq_enable           |        |                |
+  |                     v                      v        |                |
+  |            #======================================================#  |
+  |            H                     enabled                          H  |
+  |            #======================================================#  |
+  |              |                   ^         ^ preempt_enable     |    |
+  |       preempt_disable     preempt_enable   +--------------------+    |
+  |              v                   |                                   |
+  |            +------------------+  |                                   |
+  +----------> | preempt_disabled | -+                                   |
+               +------------------+                                      |
+                 |                                                       |
+                 +-------------------------------------------------------+
+
+This monitor is designed to work on ``PREEMPT_RT`` kernels, the special case of
+events occurring in interrupt context is a shortcut to identify valid scenarios
+where the preemption tracepoints might not be visible, during interrupts
+preemption is always disabled. On non- ``PREEMPT_RT`` kernels, the interrupts
+might invoke a softirq to set ``need_resched`` and wake up a task. This is
+another special case that is currently not supported by the monitor.
+
 References
 ----------
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 59d0db898d4a..5b4be87ba59d 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -57,6 +57,7 @@ source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sts/Kconfig"
 source "kernel/trace/rv/monitors/nrp/Kconfig"
 source "kernel/trace/rv/monitors/sssw/Kconfig"
+source "kernel/trace/rv/monitors/opid/Kconfig"
 # Add new sched monitors here
 
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 2afac88539d3..750e4ad6fa0f 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_RV_MON_SLEEP) += monitors/sleep/sleep.o
 obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
 obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
 obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
+obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/opid/Kconfig b/kernel/trace/rv/monitors/opid/Kconfig
new file mode 100644
index 000000000000..561d32da572b
--- /dev/null
+++ b/kernel/trace/rv/monitors/opid/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_OPID
+	depends on RV
+	depends on TRACE_IRQFLAGS
+	depends on TRACE_PREEMPT_TOGGLE
+	depends on RV_MON_SCHED
+	default y if PREEMPT_RT
+	select DA_MON_EVENTS_IMPLICIT
+	bool "opid monitor"
+	help
+	  Monitor to ensure operations like wakeup and need resched occur with
+	  interrupts and preemption disabled or during IRQs, where preemption
+	  may not be disabled explicitly.
+
+	  This monitor is unstable on !PREEMPT_RT, say N unless you are testing it.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
new file mode 100644
index 000000000000..50d64e7fb8c4
--- /dev/null
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -0,0 +1,168 @@
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
+#define MODULE_NAME "opid"
+
+#include <trace/events/sched.h>
+#include <trace/events/irq.h>
+#include <trace/events/preemptirq.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "opid.h"
+
+static struct rv_monitor rv_opid;
+DECLARE_DA_MON_PER_CPU(opid, unsigned char);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/trace/irq_vectors.h>
+
+static void handle_vector_irq_entry(void *data, int vector)
+{
+	da_handle_event_opid(irq_entry_opid);
+}
+
+static void attach_vector_irq(void)
+{
+	rv_attach_trace_probe("opid", local_timer_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_IRQ_WORK))
+		rv_attach_trace_probe("opid", irq_work_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		rv_attach_trace_probe("opid", reschedule_entry, handle_vector_irq_entry);
+		rv_attach_trace_probe("opid", call_function_entry, handle_vector_irq_entry);
+		rv_attach_trace_probe("opid", call_function_single_entry, handle_vector_irq_entry);
+	}
+}
+
+static void detach_vector_irq(void)
+{
+	rv_detach_trace_probe("opid", local_timer_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_IRQ_WORK))
+		rv_detach_trace_probe("opid", irq_work_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		rv_detach_trace_probe("opid", reschedule_entry, handle_vector_irq_entry);
+		rv_detach_trace_probe("opid", call_function_entry, handle_vector_irq_entry);
+		rv_detach_trace_probe("opid", call_function_single_entry, handle_vector_irq_entry);
+	}
+}
+
+#else
+/* We assume irq_entry tracepoints are sufficient on other architectures */
+static void attach_vector_irq(void) { }
+static void detach_vector_irq(void) { }
+#endif
+
+static void handle_irq_disable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_event_opid(irq_disable_opid);
+}
+
+static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_event_opid(irq_enable_opid);
+}
+
+static void handle_irq_entry(void *data, int irq, struct irqaction *action)
+{
+	da_handle_event_opid(irq_entry_opid);
+}
+
+static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_event_opid(preempt_disable_opid);
+}
+
+static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_event_opid(preempt_enable_opid);
+}
+
+static void handle_sched_need_resched(void *data, struct task_struct *tsk, int cpu, int tif)
+{
+	/* The monitor's intitial state is not in_irq */
+	if (this_cpu_read(hardirq_context))
+		da_handle_event_opid(sched_need_resched_opid);
+	else
+		da_handle_start_event_opid(sched_need_resched_opid);
+}
+
+static void handle_sched_waking(void *data, struct task_struct *p)
+{
+	/* The monitor's intitial state is not in_irq */
+	if (this_cpu_read(hardirq_context))
+		da_handle_event_opid(sched_waking_opid);
+	else
+		da_handle_start_event_opid(sched_waking_opid);
+}
+
+static int enable_opid(void)
+{
+	int retval;
+
+	retval = da_monitor_init_opid();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("opid", irq_disable, handle_irq_disable);
+	rv_attach_trace_probe("opid", irq_enable, handle_irq_enable);
+	rv_attach_trace_probe("opid", irq_handler_entry, handle_irq_entry);
+	rv_attach_trace_probe("opid", preempt_disable, handle_preempt_disable);
+	rv_attach_trace_probe("opid", preempt_enable, handle_preempt_enable);
+	rv_attach_trace_probe("opid", sched_set_need_resched_tp, handle_sched_need_resched);
+	rv_attach_trace_probe("opid", sched_waking, handle_sched_waking);
+	attach_vector_irq();
+
+	return 0;
+}
+
+static void disable_opid(void)
+{
+	rv_opid.enabled = 0;
+
+	rv_detach_trace_probe("opid", irq_disable, handle_irq_disable);
+	rv_detach_trace_probe("opid", irq_enable, handle_irq_enable);
+	rv_detach_trace_probe("opid", irq_handler_entry, handle_irq_entry);
+	rv_detach_trace_probe("opid", preempt_disable, handle_preempt_disable);
+	rv_detach_trace_probe("opid", preempt_enable, handle_preempt_enable);
+	rv_detach_trace_probe("opid", sched_set_need_resched_tp, handle_sched_need_resched);
+	rv_detach_trace_probe("opid", sched_waking, handle_sched_waking);
+	detach_vector_irq();
+
+	da_monitor_destroy_opid();
+}
+
+/*
+ * This is the monitor register section.
+ */
+static struct rv_monitor rv_opid = {
+	.name = "opid",
+	.description = "operations with preemption and irq disabled.",
+	.enable = enable_opid,
+	.disable = disable_opid,
+	.reset = da_monitor_reset_all_opid,
+	.enabled = 0,
+};
+
+static int __init register_opid(void)
+{
+	return rv_register_monitor(&rv_opid, &rv_sched);
+}
+
+static void __exit unregister_opid(void)
+{
+	rv_unregister_monitor(&rv_opid);
+}
+
+module_init(register_opid);
+module_exit(unregister_opid);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("opid: operations with preemption and irq disabled.");
diff --git a/kernel/trace/rv/monitors/opid/opid.h b/kernel/trace/rv/monitors/opid/opid.h
new file mode 100644
index 000000000000..b4b8c2ff7f64
--- /dev/null
+++ b/kernel/trace/rv/monitors/opid/opid.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of opid automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_opid {
+	disabled_opid = 0,
+	enabled_opid,
+	in_irq_opid,
+	irq_disabled_opid,
+	preempt_disabled_opid,
+	state_max_opid
+};
+
+#define INVALID_STATE state_max_opid
+
+enum events_opid {
+	irq_disable_opid = 0,
+	irq_enable_opid,
+	irq_entry_opid,
+	preempt_disable_opid,
+	preempt_enable_opid,
+	sched_need_resched_opid,
+	sched_waking_opid,
+	event_max_opid
+};
+
+struct automaton_opid {
+	char *state_names[state_max_opid];
+	char *event_names[event_max_opid];
+	unsigned char function[state_max_opid][event_max_opid];
+	unsigned char initial_state;
+	bool final_states[state_max_opid];
+};
+
+static const struct automaton_opid automaton_opid = {
+	.state_names = {
+		"disabled",
+		"enabled",
+		"in_irq",
+		"irq_disabled",
+		"preempt_disabled"
+	},
+	.event_names = {
+		"irq_disable",
+		"irq_enable",
+		"irq_entry",
+		"preempt_disable",
+		"preempt_enable",
+		"sched_need_resched",
+		"sched_waking"
+	},
+	.function = {
+		{
+			INVALID_STATE,
+			preempt_disabled_opid,
+			disabled_opid,
+			INVALID_STATE,
+			irq_disabled_opid,
+			disabled_opid,
+			disabled_opid
+		},
+		{
+			irq_disabled_opid,
+			INVALID_STATE,
+			INVALID_STATE,
+			preempt_disabled_opid,
+			enabled_opid,
+			INVALID_STATE,
+			INVALID_STATE
+		},
+		{
+			INVALID_STATE,
+			enabled_opid,
+			in_irq_opid,
+			INVALID_STATE,
+			INVALID_STATE,
+			in_irq_opid,
+			in_irq_opid
+		},
+		{
+			INVALID_STATE,
+			enabled_opid,
+			in_irq_opid,
+			disabled_opid,
+			INVALID_STATE,
+			irq_disabled_opid,
+			INVALID_STATE
+		},
+		{
+			disabled_opid,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			enabled_opid,
+			INVALID_STATE,
+			INVALID_STATE
+		},
+	},
+	.initial_state = disabled_opid,
+	.final_states = { 0, 1, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/opid/opid_trace.h b/kernel/trace/rv/monitors/opid/opid_trace.h
new file mode 100644
index 000000000000..3df6ff955c30
--- /dev/null
+++ b/kernel/trace/rv/monitors/opid/opid_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_OPID
+DEFINE_EVENT(event_da_monitor, event_opid,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_opid,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_OPID */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index e4e78d23b7b0..4a6faddac614 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -62,6 +62,7 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 #include <monitors/scpd/scpd_trace.h>
 #include <monitors/snep/snep_trace.h>
 #include <monitors/sts/sts_trace.h>
+#include <monitors/opid/opid_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_IMPLICIT here
 
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
diff --git a/tools/verification/models/sched/opid.dot b/tools/verification/models/sched/opid.dot
new file mode 100644
index 000000000000..840052f6952b
--- /dev/null
+++ b/tools/verification/models/sched/opid.dot
@@ -0,0 +1,35 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_disabled"};
+	{node [shape = circle] "disabled"};
+	{node [shape = doublecircle] "enabled"};
+	{node [shape = circle] "enabled"};
+	{node [shape = circle] "in_irq"};
+	{node [shape = circle] "irq_disabled"};
+	{node [shape = circle] "preempt_disabled"};
+	"__init_disabled" -> "disabled";
+	"disabled" [label = "disabled"];
+	"disabled" -> "disabled" [ label = "sched_need_resched\nsched_waking\nirq_entry" ];
+	"disabled" -> "irq_disabled" [ label = "preempt_enable" ];
+	"disabled" -> "preempt_disabled" [ label = "irq_enable" ];
+	"enabled" [label = "enabled", color = green3];
+	"enabled" -> "enabled" [ label = "preempt_enable" ];
+	"enabled" -> "irq_disabled" [ label = "irq_disable" ];
+	"enabled" -> "preempt_disabled" [ label = "preempt_disable" ];
+	"in_irq" [label = "in_irq"];
+	"in_irq" -> "enabled" [ label = "irq_enable" ];
+	"in_irq" -> "in_irq" [ label = "sched_need_resched\nsched_waking\nirq_entry" ];
+	"irq_disabled" [label = "irq_disabled"];
+	"irq_disabled" -> "disabled" [ label = "preempt_disable" ];
+	"irq_disabled" -> "enabled" [ label = "irq_enable" ];
+	"irq_disabled" -> "in_irq" [ label = "irq_entry" ];
+	"irq_disabled" -> "irq_disabled" [ label = "sched_need_resched" ];
+	"preempt_disabled" [label = "preempt_disabled"];
+	"preempt_disabled" -> "disabled" [ label = "irq_disable" ];
+	"preempt_disabled" -> "enabled" [ label = "preempt_enable" ];
+	{ rank = min ;
+		"__init_disabled";
+		"disabled";
+	}
+}
-- 
2.50.1

