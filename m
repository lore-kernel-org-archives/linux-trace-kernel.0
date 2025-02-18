Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420F248161
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881920; cv=none; b=S+HrwGmN8SMUfqC0lsAqRF8N5KUeOR43K4ccONO+bdA2l032GloOZtYfIGTgGoU3CHLK3M8ZxVATLZpkRBqM6n5GSmf9P3MWJdXvEuyPIvndlDXXJUWmBkelASAAx1NpBNbVyEC4DcXZH6hH5WgPkiqaLGqnlnMU89/an5bhCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881920; c=relaxed/simple;
	bh=8E0z+xBwGcR/UNVfkDxrm/jDH9u0mqaDikfGuOws3X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIQ5WWwnIVeSlorXquoTgE9DNTIqlnAuWVDtPxXBOLASCFE+Pz+Bp37aPpZJqyWDL8V6Y7/YDCcH7/h7UEVycaVN0M7vTQ1wix4rUWl6XE2eVxGIG6sKvmb+o+IUK7uzVt5VN7DUoefbMaF1jNaIY1yceMISIjRKJZWxLfeDIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idoPzfP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idoPzfP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739881917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ea6O7Knc7qjPjroV8vOO4NXOWXgbpWm1Jrqs8kULx0g=;
	b=idoPzfP9RnWAW4JBuSwXqcrFE1VjJBO/AmWGRHjfHOl3EeFwEpk7HJgI8MdRefJPbBTHua
	oTUmZzAga6Ij+HEvDo/ufxzsu/qt2Ky9XFOuNbbXfzqFIGzJtravfjJnZD9s8f/MqiLAfs
	C+3U4qnA6Tc2/k3VPUBw+lJnzWl73E8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-l80rDsF5PKeBT0SNYdvhOQ-1; Tue,
 18 Feb 2025 07:31:53 -0500
X-MC-Unique: l80rDsF5PKeBT0SNYdvhOQ-1
X-Mimecast-MFC-AGG-ID: l80rDsF5PKeBT0SNYdvhOQ_1739881912
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8C8F1801A1B;
	Tue, 18 Feb 2025 12:31:51 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39E781800352;
	Tue, 18 Feb 2025 12:31:47 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH v4 05/11] rv: Add sco and tss per-cpu monitors
Date: Tue, 18 Feb 2025 13:31:10 +0100
Message-ID: <20250218123121.253551-6-gmonaco@redhat.com>
In-Reply-To: <20250218123121.253551-1-gmonaco@redhat.com>
References: <20250218123121.253551-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add 2 per-cpu monitors as part of the sched model:

* sco: scheduling context operations
    Monitor to ensure sched_set_state happens only in thread context
* tss: task switch while scheduling
    Monitor to ensure sched_switch happens only in scheduling context

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Kconfig                  |  2 +
 kernel/trace/rv/Makefile                 |  2 +
 kernel/trace/rv/monitors/sco/Kconfig     | 14 ++++
 kernel/trace/rv/monitors/sco/sco.c       | 88 +++++++++++++++++++++++
 kernel/trace/rv/monitors/sco/sco.h       | 47 ++++++++++++
 kernel/trace/rv/monitors/sco/sco_trace.h | 15 ++++
 kernel/trace/rv/monitors/tss/Kconfig     | 14 ++++
 kernel/trace/rv/monitors/tss/tss.c       | 91 ++++++++++++++++++++++++
 kernel/trace/rv/monitors/tss/tss.h       | 47 ++++++++++++
 kernel/trace/rv/monitors/tss/tss_trace.h | 15 ++++
 kernel/trace/rv/rv_trace.h               |  2 +
 tools/verification/models/sched/sco.dot  | 18 +++++
 tools/verification/models/sched/tss.dot  | 18 +++++
 13 files changed, 373 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/sco/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sco/sco.c
 create mode 100644 kernel/trace/rv/monitors/sco/sco.h
 create mode 100644 kernel/trace/rv/monitors/sco/sco_trace.h
 create mode 100644 kernel/trace/rv/monitors/tss/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tss/tss.c
 create mode 100644 kernel/trace/rv/monitors/tss/tss.h
 create mode 100644 kernel/trace/rv/monitors/tss/tss_trace.h
 create mode 100644 tools/verification/models/sched/sco.dot
 create mode 100644 tools/verification/models/sched/tss.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 84c98a5327f3e..961ac1e487df1 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -28,6 +28,8 @@ menuconfig RV
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 source "kernel/trace/rv/monitors/sched/Kconfig"
+source "kernel/trace/rv/monitors/tss/Kconfig"
+source "kernel/trace/rv/monitors/sco/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 1c784df03b9a7..ef2a084ff3102 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -6,6 +6,8 @@ obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
+obj-$(CONFIG_RV_MON_TSS) += monitors/tss/tss.o
+obj-$(CONFIG_RV_MON_SCO) += monitors/sco/sco.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/sco/Kconfig b/kernel/trace/rv/monitors/sco/Kconfig
new file mode 100644
index 0000000000000..097c96cccdd7d
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SCO
+	depends on RV
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_IMPLICIT
+	bool "sco monitor"
+	help
+	  Monitor to ensure sched_set_state happens only in thread context.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
new file mode 100644
index 0000000000000..4cff59220bfc7
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -0,0 +1,88 @@
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
+#define MODULE_NAME "sco"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "sco.h"
+
+static struct rv_monitor rv_sco;
+DECLARE_DA_MON_PER_CPU(sco, unsigned char);
+
+static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+{
+	da_handle_start_event_sco(sched_set_state_sco);
+}
+
+static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+{
+	da_handle_event_sco(schedule_entry_sco);
+}
+
+static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+{
+	da_handle_start_event_sco(schedule_exit_sco);
+}
+
+static int enable_sco(void)
+{
+	int retval;
+
+	retval = da_monitor_init_sco();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("sco", sched_set_state_tp, handle_sched_set_state);
+	rv_attach_trace_probe("sco", sched_entry_tp, handle_schedule_entry);
+	rv_attach_trace_probe("sco", sched_exit_tp, handle_schedule_exit);
+
+	return 0;
+}
+
+static void disable_sco(void)
+{
+	rv_sco.enabled = 0;
+
+	rv_detach_trace_probe("sco", sched_set_state_tp, handle_sched_set_state);
+	rv_detach_trace_probe("sco", sched_entry_tp, handle_schedule_entry);
+	rv_detach_trace_probe("sco", sched_exit_tp, handle_schedule_exit);
+
+	da_monitor_destroy_sco();
+}
+
+static struct rv_monitor rv_sco = {
+	.name = "sco",
+	.description = "scheduling context operations.",
+	.enable = enable_sco,
+	.disable = disable_sco,
+	.reset = da_monitor_reset_all_sco,
+	.enabled = 0,
+};
+
+static int __init register_sco(void)
+{
+	rv_register_monitor(&rv_sco, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_sco(void)
+{
+	rv_unregister_monitor(&rv_sco);
+}
+
+module_init(register_sco);
+module_exit(unregister_sco);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("sco: scheduling context operations.");
diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
new file mode 100644
index 0000000000000..7a4c1f2d5ca1c
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of sco automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_sco {
+	thread_context_sco = 0,
+	scheduling_context_sco,
+	state_max_sco
+};
+
+#define INVALID_STATE state_max_sco
+
+enum events_sco {
+	sched_set_state_sco = 0,
+	schedule_entry_sco,
+	schedule_exit_sco,
+	event_max_sco
+};
+
+struct automaton_sco {
+	char *state_names[state_max_sco];
+	char *event_names[event_max_sco];
+	unsigned char function[state_max_sco][event_max_sco];
+	unsigned char initial_state;
+	bool final_states[state_max_sco];
+};
+
+static const struct automaton_sco automaton_sco = {
+	.state_names = {
+		"thread_context",
+		"scheduling_context"
+	},
+	.event_names = {
+		"sched_set_state",
+		"schedule_entry",
+		"schedule_exit"
+	},
+	.function = {
+		{     thread_context_sco, scheduling_context_sco,          INVALID_STATE },
+		{          INVALID_STATE,          INVALID_STATE,     thread_context_sco },
+	},
+	.initial_state = thread_context_sco,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/sco/sco_trace.h b/kernel/trace/rv/monitors/sco/sco_trace.h
new file mode 100644
index 0000000000000..b711cd9024ec4
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SCO
+DEFINE_EVENT(event_da_monitor, event_sco,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_sco,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_SCO */
diff --git a/kernel/trace/rv/monitors/tss/Kconfig b/kernel/trace/rv/monitors/tss/Kconfig
new file mode 100644
index 0000000000000..479f86f52e60d
--- /dev/null
+++ b/kernel/trace/rv/monitors/tss/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_TSS
+	depends on RV
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_IMPLICIT
+	bool "tss monitor"
+	help
+	  Monitor to ensure sched_switch happens only in scheduling context.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/tss/tss.c
new file mode 100644
index 0000000000000..542787e6524fc
--- /dev/null
+++ b/kernel/trace/rv/monitors/tss/tss.c
@@ -0,0 +1,91 @@
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
+#define MODULE_NAME "tss"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "tss.h"
+
+static struct rv_monitor rv_tss;
+DECLARE_DA_MON_PER_CPU(tss, unsigned char);
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	da_handle_event_tss(sched_switch_tss);
+}
+
+static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+{
+	da_handle_event_tss(schedule_entry_tss);
+}
+
+static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+{
+	da_handle_start_event_tss(schedule_exit_tss);
+}
+
+static int enable_tss(void)
+{
+	int retval;
+
+	retval = da_monitor_init_tss();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("tss", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("tss", sched_entry_tp, handle_schedule_entry);
+	rv_attach_trace_probe("tss", sched_exit_tp, handle_schedule_exit);
+
+	return 0;
+}
+
+static void disable_tss(void)
+{
+	rv_tss.enabled = 0;
+
+	rv_detach_trace_probe("tss", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("tss", sched_entry_tp, handle_schedule_entry);
+	rv_detach_trace_probe("tss", sched_exit_tp, handle_schedule_exit);
+
+	da_monitor_destroy_tss();
+}
+
+static struct rv_monitor rv_tss = {
+	.name = "tss",
+	.description = "task switch while scheduling.",
+	.enable = enable_tss,
+	.disable = disable_tss,
+	.reset = da_monitor_reset_all_tss,
+	.enabled = 0,
+};
+
+static int __init register_tss(void)
+{
+	rv_register_monitor(&rv_tss, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_tss(void)
+{
+	rv_unregister_monitor(&rv_tss);
+}
+
+module_init(register_tss);
+module_exit(unregister_tss);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("tss: task switch while scheduling.");
diff --git a/kernel/trace/rv/monitors/tss/tss.h b/kernel/trace/rv/monitors/tss/tss.h
new file mode 100644
index 0000000000000..f0a36fda1b873
--- /dev/null
+++ b/kernel/trace/rv/monitors/tss/tss.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of tss automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_tss {
+	thread_tss = 0,
+	sched_tss,
+	state_max_tss
+};
+
+#define INVALID_STATE state_max_tss
+
+enum events_tss {
+	sched_switch_tss = 0,
+	schedule_entry_tss,
+	schedule_exit_tss,
+	event_max_tss
+};
+
+struct automaton_tss {
+	char *state_names[state_max_tss];
+	char *event_names[event_max_tss];
+	unsigned char function[state_max_tss][event_max_tss];
+	unsigned char initial_state;
+	bool final_states[state_max_tss];
+};
+
+static const struct automaton_tss automaton_tss = {
+	.state_names = {
+		"thread",
+		"sched"
+	},
+	.event_names = {
+		"sched_switch",
+		"schedule_entry",
+		"schedule_exit"
+	},
+	.function = {
+		{     INVALID_STATE,         sched_tss,     INVALID_STATE },
+		{         sched_tss,     INVALID_STATE,        thread_tss },
+	},
+	.initial_state = thread_tss,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/tss/tss_trace.h b/kernel/trace/rv/monitors/tss/tss_trace.h
new file mode 100644
index 0000000000000..4619dbb50cc06
--- /dev/null
+++ b/kernel/trace/rv/monitors/tss/tss_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_TSS
+DEFINE_EVENT(event_da_monitor, event_tss,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_tss,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_TSS */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 5e65097423ba4..f49e85ca97a1f 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -58,6 +58,8 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 );
 
 #include <monitors/wip/wip_trace.h>
+#include <monitors/tss/tss_trace.h>
+#include <monitors/sco/sco_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_IMPLICIT here
 
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
diff --git a/tools/verification/models/sched/sco.dot b/tools/verification/models/sched/sco.dot
new file mode 100644
index 0000000000000..20b0e3b449a6b
--- /dev/null
+++ b/tools/verification/models/sched/sco.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext] "scheduling_context"};
+	{node [shape = plaintext, style=invis, label=""] "__init_thread_context"};
+	{node [shape = ellipse] "thread_context"};
+	{node [shape = plaintext] "thread_context"};
+	"__init_thread_context" -> "thread_context";
+	"scheduling_context" [label = "scheduling_context"];
+	"scheduling_context" -> "thread_context" [ label = "schedule_exit" ];
+	"thread_context" [label = "thread_context", color = green3];
+	"thread_context" -> "scheduling_context" [ label = "schedule_entry" ];
+	"thread_context" -> "thread_context" [ label = "sched_set_state" ];
+	{ rank = min ;
+		"__init_thread_context";
+		"thread_context";
+	}
+}
diff --git a/tools/verification/models/sched/tss.dot b/tools/verification/models/sched/tss.dot
new file mode 100644
index 0000000000000..7dfa1d9121bbd
--- /dev/null
+++ b/tools/verification/models/sched/tss.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext] "sched"};
+	{node [shape = plaintext, style=invis, label=""] "__init_thread"};
+	{node [shape = ellipse] "thread"};
+	{node [shape = plaintext] "thread"};
+	"__init_thread" -> "thread";
+	"sched" [label = "sched"];
+	"sched" -> "sched" [ label = "sched_switch" ];
+	"sched" -> "thread" [ label = "schedule_exit" ];
+	"thread" [label = "thread", color = green3];
+	"thread" -> "sched" [ label = "schedule_entry" ];
+	{ rank = min ;
+		"__init_thread";
+		"thread";
+	}
+}
-- 
2.48.1

