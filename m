Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38F21B91D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797984; cv=none; b=eYhZszaOeeh5JhDV3XLWEsNPUWlUJWqAZ47OjGsUqlz7S2uEQzjQMZHRpF3vLlgL0PHS0oQvdjOJQV4xC4xwG+av9OJ7lLP4NZnSMoimktZ/AAuTZe9iPRoGOHQJMW62oSpRITkCjhc41TzwNe73R5GX1XHU45I69H50eJel+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797984; c=relaxed/simple;
	bh=yovrjLO5C2lI2eSzru+1Mb9+OYScywOuVc/sKVRRLEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGWn/fL4cfqo1EVuSVT1/WxaKn8z3oHTm/IBxn5pT0FCf2yjblbNMhz+zLyh4Ycq9Pcx3Cf56rLmL0B/cnCaXJe1Y4YB4FeOxq5RVoNaP78QF0QJONOB6FrNd3y0IWBu8CoqX4UhrOoeyMdth5Ux9Lbw737O6x2F7tVALygDZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVB6uV6V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVB6uV6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739797980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkVEMAD1KIHnt/RQNLq8JVn6UMoPGr35EGnArS1ZYxI=;
	b=iVB6uV6VAeRA74nNvePE/nhr2w6LuHGt0r2TrhGSqtJkX252AOa5f8zSPPkbbnPm5TjTV3
	+04uPymLMc6dlEhTGadxlR8e4OW/Xj9bJVogcCIdQQIGzmcOB37ywnPX3YQ6vWDXavypoz
	aQMsKK18YGoZVIMluthQiGyGRxnqFCk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-4Kb8VVI3NtOz_uKb-1ElMg-1; Mon,
 17 Feb 2025 08:12:57 -0500
X-MC-Unique: 4Kb8VVI3NtOz_uKb-1ElMg-1
X-Mimecast-MFC-AGG-ID: 4Kb8VVI3NtOz_uKb-1ElMg_1739797976
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 411CB1800877;
	Mon, 17 Feb 2025 13:12:56 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B326A1800360;
	Mon, 17 Feb 2025 13:12:52 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH v2 07/11] rv: Add scpd, snep and sncid per-cpu monitors
Date: Mon, 17 Feb 2025 14:11:58 +0100
Message-ID: <20250217131206.388485-8-gmonaco@redhat.com>
In-Reply-To: <20250217131206.388485-1-gmonaco@redhat.com>
References: <20250217131206.388485-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add 3 per-cpu monitors as part of the sched model:

* scpd: schedule called with preemption disabled
    Monitor to ensure schedule is called with preemption disabled
* snep: schedule does not enable preempt
    Monitor to ensure schedule does not enable preempt
* sncid: schedule not called with interrupt disabled
    Monitor to ensure schedule is not called with interrupt disabled

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Kconfig                      |  3 +
 kernel/trace/rv/Makefile                     |  3 +
 kernel/trace/rv/monitors/scpd/Kconfig        | 15 +++
 kernel/trace/rv/monitors/scpd/scpd.c         | 96 ++++++++++++++++++++
 kernel/trace/rv/monitors/scpd/scpd.h         | 49 ++++++++++
 kernel/trace/rv/monitors/scpd/scpd_trace.h   | 15 +++
 kernel/trace/rv/monitors/sncid/Kconfig       | 15 +++
 kernel/trace/rv/monitors/sncid/sncid.c       | 96 ++++++++++++++++++++
 kernel/trace/rv/monitors/sncid/sncid.h       | 49 ++++++++++
 kernel/trace/rv/monitors/sncid/sncid_trace.h | 15 +++
 kernel/trace/rv/monitors/snep/Kconfig        | 15 +++
 kernel/trace/rv/monitors/snep/snep.c         | 96 ++++++++++++++++++++
 kernel/trace/rv/monitors/snep/snep.h         | 49 ++++++++++
 kernel/trace/rv/monitors/snep/snep_trace.h   | 15 +++
 kernel/trace/rv/rv_trace.h                   |  3 +
 tools/verification/models/sched/scpd.dot     | 18 ++++
 tools/verification/models/sched/sncid.dot    | 18 ++++
 tools/verification/models/sched/snep.dot     | 18 ++++
 18 files changed, 588 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/scpd/Kconfig
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd.c
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd.h
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd_trace.h
 create mode 100644 kernel/trace/rv/monitors/sncid/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid.c
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid.h
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid_trace.h
 create mode 100644 kernel/trace/rv/monitors/snep/Kconfig
 create mode 100644 kernel/trace/rv/monitors/snep/snep.c
 create mode 100644 kernel/trace/rv/monitors/snep/snep.h
 create mode 100644 kernel/trace/rv/monitors/snep/snep_trace.h
 create mode 100644 tools/verification/models/sched/scpd.dot
 create mode 100644 tools/verification/models/sched/sncid.dot
 create mode 100644 tools/verification/models/sched/snep.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index c4f1c0fc3abc6..b39f36013ef23 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -31,6 +31,9 @@ source "kernel/trace/rv/monitors/sched/Kconfig"
 source "kernel/trace/rv/monitors/tss/Kconfig"
 source "kernel/trace/rv/monitors/sco/Kconfig"
 source "kernel/trace/rv/monitors/snroc/Kconfig"
+source "kernel/trace/rv/monitors/scpd/Kconfig"
+source "kernel/trace/rv/monitors/snep/Kconfig"
+source "kernel/trace/rv/monitors/sncid/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 6d11d6400ddd0..f9b2cd0483c3c 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -9,6 +9,9 @@ obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
 obj-$(CONFIG_RV_MON_TSS) += monitors/tss/tss.o
 obj-$(CONFIG_RV_MON_SCO) += monitors/sco/sco.o
 obj-$(CONFIG_RV_MON_SNROC) += monitors/snroc/snroc.o
+obj-$(CONFIG_RV_MON_SCPD) += monitors/scpd/scpd.o
+obj-$(CONFIG_RV_MON_SNEP) += monitors/snep/snep.o
+obj-$(CONFIG_RV_MON_SNCID) += monitors/sncid/sncid.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/scpd/Kconfig b/kernel/trace/rv/monitors/scpd/Kconfig
new file mode 100644
index 0000000000000..b9114fbf680f9
--- /dev/null
+++ b/kernel/trace/rv/monitors/scpd/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SCPD
+	depends on RV
+	depends on PREEMPT_TRACER
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_IMPLICIT
+	bool "scpd monitor"
+	help
+	  Monitor to ensure schedule is called with preemption disabled.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/scpd/scpd.c b/kernel/trace/rv/monitors/scpd/scpd.c
new file mode 100644
index 0000000000000..cbdd6a5f8d7fd
--- /dev/null
+++ b/kernel/trace/rv/monitors/scpd/scpd.c
@@ -0,0 +1,96 @@
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
+#define MODULE_NAME "scpd"
+
+#include <trace/events/sched.h>
+#include <trace/events/preemptirq.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "scpd.h"
+
+static struct rv_monitor rv_scpd;
+DECLARE_DA_MON_PER_CPU(scpd, unsigned char);
+
+static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_event_scpd(preempt_disable_scpd);
+}
+
+static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_start_event_scpd(preempt_enable_scpd);
+}
+
+static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+{
+	da_handle_event_scpd(schedule_entry_scpd);
+}
+
+static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+{
+	da_handle_event_scpd(schedule_exit_scpd);
+}
+
+static int enable_scpd(void)
+{
+	int retval;
+
+	retval = da_monitor_init_scpd();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("scpd", preempt_disable, handle_preempt_disable);
+	rv_attach_trace_probe("scpd", preempt_enable, handle_preempt_enable);
+	rv_attach_trace_probe("scpd", sched_entry_tp, handle_schedule_entry);
+	rv_attach_trace_probe("scpd", sched_exit_tp, handle_schedule_exit);
+
+	return 0;
+}
+
+static void disable_scpd(void)
+{
+	rv_scpd.enabled = 0;
+
+	rv_detach_trace_probe("scpd", preempt_disable, handle_preempt_disable);
+	rv_detach_trace_probe("scpd", preempt_enable, handle_preempt_enable);
+	rv_detach_trace_probe("scpd", sched_entry_tp, handle_schedule_entry);
+	rv_detach_trace_probe("scpd", sched_exit_tp, handle_schedule_exit);
+
+	da_monitor_destroy_scpd();
+}
+
+static struct rv_monitor rv_scpd = {
+	.name = "scpd",
+	.description = "schedule called with preemption disabled.",
+	.enable = enable_scpd,
+	.disable = disable_scpd,
+	.reset = da_monitor_reset_all_scpd,
+	.enabled = 0,
+};
+
+static int __init register_scpd(void)
+{
+	rv_register_monitor(&rv_scpd, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_scpd(void)
+{
+	rv_unregister_monitor(&rv_scpd);
+}
+
+module_init(register_scpd);
+module_exit(unregister_scpd);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("scpd: schedule called with preemption disabled.");
diff --git a/kernel/trace/rv/monitors/scpd/scpd.h b/kernel/trace/rv/monitors/scpd/scpd.h
new file mode 100644
index 0000000000000..295f735a58110
--- /dev/null
+++ b/kernel/trace/rv/monitors/scpd/scpd.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of scpd automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_scpd {
+	cant_sched_scpd = 0,
+	can_sched_scpd,
+	state_max_scpd
+};
+
+#define INVALID_STATE state_max_scpd
+
+enum events_scpd {
+	preempt_disable_scpd = 0,
+	preempt_enable_scpd,
+	schedule_entry_scpd,
+	schedule_exit_scpd,
+	event_max_scpd
+};
+
+struct automaton_scpd {
+	char *state_names[state_max_scpd];
+	char *event_names[event_max_scpd];
+	unsigned char function[state_max_scpd][event_max_scpd];
+	unsigned char initial_state;
+	bool final_states[state_max_scpd];
+};
+
+static const struct automaton_scpd automaton_scpd = {
+	.state_names = {
+		"cant_sched",
+		"can_sched"
+	},
+	.event_names = {
+		"preempt_disable",
+		"preempt_enable",
+		"schedule_entry",
+		"schedule_exit"
+	},
+	.function = {
+		{     can_sched_scpd,     INVALID_STATE,     INVALID_STATE,     INVALID_STATE },
+		{     INVALID_STATE,    cant_sched_scpd,     can_sched_scpd,     can_sched_scpd },
+	},
+	.initial_state = cant_sched_scpd,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/scpd/scpd_trace.h b/kernel/trace/rv/monitors/scpd/scpd_trace.h
new file mode 100644
index 0000000000000..6b0f4aa4732e8
--- /dev/null
+++ b/kernel/trace/rv/monitors/scpd/scpd_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SCPD
+DEFINE_EVENT(event_da_monitor, event_scpd,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_scpd,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_SCPD */
diff --git a/kernel/trace/rv/monitors/sncid/Kconfig b/kernel/trace/rv/monitors/sncid/Kconfig
new file mode 100644
index 0000000000000..76bcfef4fd103
--- /dev/null
+++ b/kernel/trace/rv/monitors/sncid/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SNCID
+	depends on RV
+	depends on IRQSOFF_TRACER
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_IMPLICIT
+	bool "sncid monitor"
+	help
+	  Monitor to ensure schedule is not called with interrupt disabled.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/sncid/sncid.c b/kernel/trace/rv/monitors/sncid/sncid.c
new file mode 100644
index 0000000000000..f5037cd6214c2
--- /dev/null
+++ b/kernel/trace/rv/monitors/sncid/sncid.c
@@ -0,0 +1,96 @@
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
+#define MODULE_NAME "sncid"
+
+#include <trace/events/sched.h>
+#include <trace/events/preemptirq.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "sncid.h"
+
+static struct rv_monitor rv_sncid;
+DECLARE_DA_MON_PER_CPU(sncid, unsigned char);
+
+static void handle_irq_disable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_event_sncid(irq_disable_sncid);
+}
+
+static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_start_event_sncid(irq_enable_sncid);
+}
+
+static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+{
+	da_handle_start_event_sncid(schedule_entry_sncid);
+}
+
+static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+{
+	da_handle_start_event_sncid(schedule_exit_sncid);
+}
+
+static int enable_sncid(void)
+{
+	int retval;
+
+	retval = da_monitor_init_sncid();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("sncid", irq_disable, handle_irq_disable);
+	rv_attach_trace_probe("sncid", irq_enable, handle_irq_enable);
+	rv_attach_trace_probe("sncid", sched_entry_tp, handle_schedule_entry);
+	rv_attach_trace_probe("sncid", sched_exit_tp, handle_schedule_exit);
+
+	return 0;
+}
+
+static void disable_sncid(void)
+{
+	rv_sncid.enabled = 0;
+
+	rv_detach_trace_probe("sncid", irq_disable, handle_irq_disable);
+	rv_detach_trace_probe("sncid", irq_enable, handle_irq_enable);
+	rv_detach_trace_probe("sncid", sched_entry_tp, handle_schedule_entry);
+	rv_detach_trace_probe("sncid", sched_exit_tp, handle_schedule_exit);
+
+	da_monitor_destroy_sncid();
+}
+
+static struct rv_monitor rv_sncid = {
+	.name = "sncid",
+	.description = "schedule not called with interrupt disabled.",
+	.enable = enable_sncid,
+	.disable = disable_sncid,
+	.reset = da_monitor_reset_all_sncid,
+	.enabled = 0,
+};
+
+static int __init register_sncid(void)
+{
+	rv_register_monitor(&rv_sncid, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_sncid(void)
+{
+	rv_unregister_monitor(&rv_sncid);
+}
+
+module_init(register_sncid);
+module_exit(unregister_sncid);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("sncid: schedule not called with interrupt disabled.");
diff --git a/kernel/trace/rv/monitors/sncid/sncid.h b/kernel/trace/rv/monitors/sncid/sncid.h
new file mode 100644
index 0000000000000..21304725142bc
--- /dev/null
+++ b/kernel/trace/rv/monitors/sncid/sncid.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of sncid automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_sncid {
+	can_sched_sncid = 0,
+	cant_sched_sncid,
+	state_max_sncid
+};
+
+#define INVALID_STATE state_max_sncid
+
+enum events_sncid {
+	irq_disable_sncid = 0,
+	irq_enable_sncid,
+	schedule_entry_sncid,
+	schedule_exit_sncid,
+	event_max_sncid
+};
+
+struct automaton_sncid {
+	char *state_names[state_max_sncid];
+	char *event_names[event_max_sncid];
+	unsigned char function[state_max_sncid][event_max_sncid];
+	unsigned char initial_state;
+	bool final_states[state_max_sncid];
+};
+
+static const struct automaton_sncid automaton_sncid = {
+	.state_names = {
+		"can_sched",
+		"cant_sched"
+	},
+	.event_names = {
+		"irq_disable",
+		"irq_enable",
+		"schedule_entry",
+		"schedule_exit"
+	},
+	.function = {
+		{ cant_sched_sncid,   INVALID_STATE, can_sched_sncid, can_sched_sncid },
+		{    INVALID_STATE, can_sched_sncid,   INVALID_STATE,   INVALID_STATE },
+	},
+	.initial_state = can_sched_sncid,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/sncid/sncid_trace.h b/kernel/trace/rv/monitors/sncid/sncid_trace.h
new file mode 100644
index 0000000000000..3ce42a57671d4
--- /dev/null
+++ b/kernel/trace/rv/monitors/sncid/sncid_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SNCID
+DEFINE_EVENT(event_da_monitor, event_sncid,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_sncid,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_SNCID */
diff --git a/kernel/trace/rv/monitors/snep/Kconfig b/kernel/trace/rv/monitors/snep/Kconfig
new file mode 100644
index 0000000000000..77527f9712325
--- /dev/null
+++ b/kernel/trace/rv/monitors/snep/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SNEP
+	depends on RV
+	depends on PREEMPT_TRACER
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_IMPLICIT
+	bool "snep monitor"
+	help
+	  Monitor to ensure schedule does not enable preempt.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/snep/snep.c b/kernel/trace/rv/monitors/snep/snep.c
new file mode 100644
index 0000000000000..0076ba6d7ea44
--- /dev/null
+++ b/kernel/trace/rv/monitors/snep/snep.c
@@ -0,0 +1,96 @@
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
+#define MODULE_NAME "snep"
+
+#include <trace/events/sched.h>
+#include <trace/events/preemptirq.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "snep.h"
+
+static struct rv_monitor rv_snep;
+DECLARE_DA_MON_PER_CPU(snep, unsigned char);
+
+static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_start_event_snep(preempt_disable_snep);
+}
+
+static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_start_event_snep(preempt_enable_snep);
+}
+
+static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+{
+	da_handle_event_snep(schedule_entry_snep);
+}
+
+static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+{
+	da_handle_start_event_snep(schedule_exit_snep);
+}
+
+static int enable_snep(void)
+{
+	int retval;
+
+	retval = da_monitor_init_snep();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("snep", preempt_disable, handle_preempt_disable);
+	rv_attach_trace_probe("snep", preempt_enable, handle_preempt_enable);
+	rv_attach_trace_probe("snep", sched_entry_tp, handle_schedule_entry);
+	rv_attach_trace_probe("snep", sched_exit_tp, handle_schedule_exit);
+
+	return 0;
+}
+
+static void disable_snep(void)
+{
+	rv_snep.enabled = 0;
+
+	rv_detach_trace_probe("snep", preempt_disable, handle_preempt_disable);
+	rv_detach_trace_probe("snep", preempt_enable, handle_preempt_enable);
+	rv_detach_trace_probe("snep", sched_entry_tp, handle_schedule_entry);
+	rv_detach_trace_probe("snep", sched_exit_tp, handle_schedule_exit);
+
+	da_monitor_destroy_snep();
+}
+
+static struct rv_monitor rv_snep = {
+	.name = "snep",
+	.description = "schedule does not enable preempt.",
+	.enable = enable_snep,
+	.disable = disable_snep,
+	.reset = da_monitor_reset_all_snep,
+	.enabled = 0,
+};
+
+static int __init register_snep(void)
+{
+	rv_register_monitor(&rv_snep, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_snep(void)
+{
+	rv_unregister_monitor(&rv_snep);
+}
+
+module_init(register_snep);
+module_exit(unregister_snep);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("snep: schedule does not enable preempt.");
diff --git a/kernel/trace/rv/monitors/snep/snep.h b/kernel/trace/rv/monitors/snep/snep.h
new file mode 100644
index 0000000000000..6d16b9ad931e1
--- /dev/null
+++ b/kernel/trace/rv/monitors/snep/snep.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of snep automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_snep {
+	non_scheduling_context_snep = 0,
+	scheduling_contex_snep,
+	state_max_snep
+};
+
+#define INVALID_STATE state_max_snep
+
+enum events_snep {
+	preempt_disable_snep = 0,
+	preempt_enable_snep,
+	schedule_entry_snep,
+	schedule_exit_snep,
+	event_max_snep
+};
+
+struct automaton_snep {
+	char *state_names[state_max_snep];
+	char *event_names[event_max_snep];
+	unsigned char function[state_max_snep][event_max_snep];
+	unsigned char initial_state;
+	bool final_states[state_max_snep];
+};
+
+static const struct automaton_snep automaton_snep = {
+	.state_names = {
+		"non_scheduling_context",
+		"scheduling_contex"
+	},
+	.event_names = {
+		"preempt_disable",
+		"preempt_enable",
+		"schedule_entry",
+		"schedule_exit"
+	},
+	.function = {
+		{ non_scheduling_context_snep, non_scheduling_context_snep, scheduling_contex_snep,               INVALID_STATE },
+		{               INVALID_STATE,               INVALID_STATE,          INVALID_STATE, non_scheduling_context_snep },
+	},
+	.initial_state = non_scheduling_context_snep,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/snep/snep_trace.h b/kernel/trace/rv/monitors/snep/snep_trace.h
new file mode 100644
index 0000000000000..01aad49a949a8
--- /dev/null
+++ b/kernel/trace/rv/monitors/snep/snep_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SNEP
+DEFINE_EVENT(event_da_monitor, event_snep,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_snep,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_SNEP */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index a533bc29cfddf..422b75f58891e 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -60,6 +60,9 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 #include <monitors/wip/wip_trace.h>
 #include <monitors/tss/tss_trace.h>
 #include <monitors/sco/sco_trace.h>
+#include <monitors/scpd/scpd_trace.h>
+#include <monitors/snep/snep_trace.h>
+#include <monitors/sncid/sncid_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_IMPLICIT here
 
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
diff --git a/tools/verification/models/sched/scpd.dot b/tools/verification/models/sched/scpd.dot
new file mode 100644
index 0000000000000..340413896765c
--- /dev/null
+++ b/tools/verification/models/sched/scpd.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext] "can_sched"};
+	{node [shape = plaintext, style=invis, label=""] "__init_cant_sched"};
+	{node [shape = ellipse] "cant_sched"};
+	{node [shape = plaintext] "cant_sched"};
+	"__init_cant_sched" -> "cant_sched";
+	"can_sched" [label = "can_sched"];
+	"can_sched" -> "can_sched" [ label = "schedule_entry\nschedule_exit" ];
+	"can_sched" -> "cant_sched" [ label = "preempt_enable" ];
+	"cant_sched" [label = "cant_sched", color = green3];
+	"cant_sched" -> "can_sched" [ label = "preempt_disable" ];
+	{ rank = min ;
+		"__init_cant_sched";
+		"cant_sched";
+	}
+}
diff --git a/tools/verification/models/sched/sncid.dot b/tools/verification/models/sched/sncid.dot
new file mode 100644
index 0000000000000..072851721b50a
--- /dev/null
+++ b/tools/verification/models/sched/sncid.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_can_sched"};
+	{node [shape = ellipse] "can_sched"};
+	{node [shape = plaintext] "can_sched"};
+	{node [shape = plaintext] "cant_sched"};
+	"__init_can_sched" -> "can_sched";
+	"can_sched" [label = "can_sched", color = green3];
+	"can_sched" -> "can_sched" [ label = "schedule_entry\nschedule_exit" ];
+	"can_sched" -> "cant_sched" [ label = "irq_disable" ];
+	"cant_sched" [label = "cant_sched"];
+	"cant_sched" -> "can_sched" [ label = "irq_enable" ];
+	{ rank = min ;
+		"__init_can_sched";
+		"can_sched";
+	}
+}
diff --git a/tools/verification/models/sched/snep.dot b/tools/verification/models/sched/snep.dot
new file mode 100644
index 0000000000000..fe1300e93f211
--- /dev/null
+++ b/tools/verification/models/sched/snep.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_non_scheduling_context"};
+	{node [shape = ellipse] "non_scheduling_context"};
+	{node [shape = plaintext] "non_scheduling_context"};
+	{node [shape = plaintext] "scheduling_contex"};
+	"__init_non_scheduling_context" -> "non_scheduling_context";
+	"non_scheduling_context" [label = "non_scheduling_context", color = green3];
+	"non_scheduling_context" -> "non_scheduling_context" [ label = "preempt_disable\npreempt_enable" ];
+	"non_scheduling_context" -> "scheduling_contex" [ label = "schedule_entry" ];
+	"scheduling_contex" [label = "scheduling_contex"];
+	"scheduling_contex" -> "non_scheduling_context" [ label = "schedule_exit" ];
+	{ rank = min ;
+		"__init_non_scheduling_context";
+		"non_scheduling_context";
+	}
+}
-- 
2.48.1

