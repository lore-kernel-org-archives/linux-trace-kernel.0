Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388B32ED49
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940643; cv=none; b=nu6+evCZPlRFepS49UZaojHE8LF40uTAx2sMfLr/yX3e7ODEZOBMXuTtOuC6q1FOSizsOjZ/m61AviQjXqSJknZ/qqfH7PKHyhdkL1Wup6iwjNn5suFeKB7xjZbKBwKKOda84JXTwXT3gM7/Mczx6KW9+gVRzcgeYWxMUmnMV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940643; c=relaxed/simple;
	bh=tiaUo0qYIAxuMm1nZKXfE8h7DaMsLLuoN6nP7ese+Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP/JESI3JgAOxYV1Sl2nRc2igc4WQiMrBrgzHaWruzEacJRAkfZuhnSpZF5JiQ3Ib0huZjxNJN7v03p9wl3JxenGYqWzlDBKrF7fEeEeQvobpv0/Ji0KxMpnJjAK57SKB247hn91wdlxTFT6lz5SVTm9gHkj3k51CkFa4DwWdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdDzwMhZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdDzwMhZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764940635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80GuvibACcJ2VyVxoFdm18G8D8rfzxl/Aix/mgujaLk=;
	b=bdDzwMhZ5EiG1DO58sTwMtw7wku6BX6iz6XvT2mBt2nXobr3WSo/kyOzqnGs21F860KBeE
	N4QQL2hGu9KU858+0t81Cb5QZWQlTKgMegzUM3b1u1Q6yZ9qg5UnhSzx3T3iIWBe5tuu3p
	NsZ4dYhm+ZSQwvz2Wyey5iW2P+c/PH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-P675trQbMLyzUkGb2DEpXw-1; Fri,
 05 Dec 2025 08:17:12 -0500
X-MC-Unique: P675trQbMLyzUkGb2DEpXw-1
X-Mimecast-MFC-AGG-ID: P675trQbMLyzUkGb2DEpXw_1764940631
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22E471800365;
	Fri,  5 Dec 2025 13:17:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5539180045B;
	Fri,  5 Dec 2025 13:17:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 06/13] rv: Add sample hybrid monitors stall
Date: Fri,  5 Dec 2025 14:16:14 +0100
Message-ID: <20251205131621.135513-7-gmonaco@redhat.com>
In-Reply-To: <20251205131621.135513-1-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a sample monitor to showcase hybrid/timed automata.
The stall monitor identifies tasks stalled for longer than a threshold
and reacts when that happens.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V3:
    * Extend stall model to handle preemption

 Documentation/tools/rv/index.rst             |   1 +
 Documentation/tools/rv/rv-mon-stall.rst      |  44 ++++++
 Documentation/trace/rv/index.rst             |   1 +
 Documentation/trace/rv/monitor_stall.rst     |  43 ++++++
 kernel/trace/rv/Kconfig                      |   1 +
 kernel/trace/rv/Makefile                     |   1 +
 kernel/trace/rv/monitors/stall/Kconfig       |  13 ++
 kernel/trace/rv/monitors/stall/stall.c       | 150 +++++++++++++++++++
 kernel/trace/rv/monitors/stall/stall.h       |  81 ++++++++++
 kernel/trace/rv/monitors/stall/stall_trace.h |  19 +++
 kernel/trace/rv/rv_trace.h                   |   1 +
 tools/verification/models/stall.dot          |  22 +++
 12 files changed, 377 insertions(+)
 create mode 100644 Documentation/tools/rv/rv-mon-stall.rst
 create mode 100644 Documentation/trace/rv/monitor_stall.rst
 create mode 100644 kernel/trace/rv/monitors/stall/Kconfig
 create mode 100644 kernel/trace/rv/monitors/stall/stall.c
 create mode 100644 kernel/trace/rv/monitors/stall/stall.h
 create mode 100644 kernel/trace/rv/monitors/stall/stall_trace.h
 create mode 100644 tools/verification/models/stall.dot

diff --git a/Documentation/tools/rv/index.rst b/Documentation/tools/rv/index.rst
index 64ba2efe2e85..4d66e0a78e1e 100644
--- a/Documentation/tools/rv/index.rst
+++ b/Documentation/tools/rv/index.rst
@@ -16,6 +16,7 @@ Runtime verification (rv) tool
    rv-mon-wip
    rv-mon-wwnr
    rv-mon-sched
+   rv-mon-stall
 
 .. only::  subproject and html
 
diff --git a/Documentation/tools/rv/rv-mon-stall.rst b/Documentation/tools/rv/rv-mon-stall.rst
new file mode 100644
index 000000000000..c79d7c2e4dd4
--- /dev/null
+++ b/Documentation/tools/rv/rv-mon-stall.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+rv-mon-stall
+============
+--------------------
+Stalled task monitor
+--------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+
+**rv mon stall** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+The stalled task (**stall**) monitor is a sample per-task timed monitor that
+checks if tasks are scheduled within a defined threshold after they are ready.
+
+See kernel documentation for further information about this monitor:
+<https://docs.kernel.org/trace/rv/monitor_stall.html>
+
+OPTIONS
+=======
+
+.. include:: common_ikm.rst
+
+SEE ALSO
+========
+
+**rv**\(1), **rv-mon**\(1)
+
+Linux kernel *RV* documentation:
+<https://www.kernel.org/doc/html/latest/trace/rv/index.html>
+
+AUTHOR
+======
+
+Written by Gabriele Monaco <gmonaco@redhat.com>
+
+.. include:: common_appendix.rst
diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index ad298784bda2..bf9962f49959 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -16,3 +16,4 @@ Runtime Verification
    monitor_wwnr.rst
    monitor_sched.rst
    monitor_rtapp.rst
+   monitor_stall.rst
diff --git a/Documentation/trace/rv/monitor_stall.rst b/Documentation/trace/rv/monitor_stall.rst
new file mode 100644
index 000000000000..d29e820b2433
--- /dev/null
+++ b/Documentation/trace/rv/monitor_stall.rst
@@ -0,0 +1,43 @@
+Monitor stall
+=============
+
+- Name: stall - stalled task monitor
+- Type: per-task hybrid automaton
+- Author: Gabriele Monaco <gmonaco@redhat.com>
+
+Description
+-----------
+
+The stalled task (stall) monitor is a sample per-task timed monitor that checks
+if tasks are scheduled within a defined threshold after they are ready::
+
+                        |
+                        |
+                        v
+                      #==========================#
+  +-----------------> H         dequeued         H
+  |                   #==========================#
+  |                     |
+ sched_switch_wait      | sched_wakeup;reset(clk)
+  |                     v
+  |                   +--------------------------+ <+
+  |                   |         enqueued         |  | sched_wakeup
+  |                   | clk < threshold_jiffies  | -+
+  |                   +--------------------------+
+  |                     |                 ^
+  |              sched_switch_in    sched_switch_preempt;reset(clk)
+  |                     v                 |
+  |                   +--------------------------+
+  +------------------ |         running          |
+                      +--------------------------+
+                        ^ sched_switch_in      |
+                        | sched_wakeup         |
+                        +----------------------+
+
+The threshold can be configured as a parameter by either booting with the
+``stall.threshold_jiffies=<new value>`` argument or writing a new value to
+``/sys/module/stall/parameters/threshold_jiffies``.
+
+Specification
+-------------
+Graphviz Dot file in tools/verification/models/stall.dot
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 4ad392dfc57f..720fbe4935f8 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -78,6 +78,7 @@ source "kernel/trace/rv/monitors/pagefault/Kconfig"
 source "kernel/trace/rv/monitors/sleep/Kconfig"
 # Add new rtapp monitors here
 
+source "kernel/trace/rv/monitors/stall/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 750e4ad6fa0f..51c95e2d2da6 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
 obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
 obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
+obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/stall/Kconfig b/kernel/trace/rv/monitors/stall/Kconfig
new file mode 100644
index 000000000000..6f846b642544
--- /dev/null
+++ b/kernel/trace/rv/monitors/stall/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_STALL
+	depends on RV
+	select HA_MON_EVENTS_ID
+	bool "stall monitor"
+	help
+	  Enable the stall sample monitor that illustrates the usage of hybrid
+	  automata monitors. It can be used to identify tasks stalled for
+	  longer than a threshold.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_stall.rst
diff --git a/kernel/trace/rv/monitors/stall/stall.c b/kernel/trace/rv/monitors/stall/stall.c
new file mode 100644
index 000000000000..9ccfda6b0e73
--- /dev/null
+++ b/kernel/trace/rv/monitors/stall/stall.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "stall"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+
+#define RV_MON_TYPE RV_MON_PER_TASK
+#define HA_TIMER_TYPE HA_TIMER_WHEEL
+#include "stall.h"
+#include <rv/ha_monitor.h>
+
+static u64 threshold_jiffies = 1000;
+module_param(threshold_jiffies, ullong, 0644);
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_stall env, u64 time_ns)
+{
+	if (env == clk_stall)
+		return ha_get_clk_jiffy(ha_mon, env);
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_stall env, u64 time_ns)
+{
+	if (env == clk_stall)
+		ha_reset_clk_jiffy(ha_mon, env);
+}
+
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == enqueued_stall)
+		return ha_check_invariant_jiffy(ha_mon, clk_stall, time_ns);
+	return true;
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == dequeued_stall && event == sched_wakeup_stall)
+		ha_reset_env(ha_mon, clk_stall, time_ns);
+	else if (curr_state == running_stall && event == sched_switch_preempt_stall)
+		ha_reset_env(ha_mon, clk_stall, time_ns);
+	return res;
+}
+
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == curr_state)
+		return;
+	if (next_state == enqueued_stall)
+		ha_start_timer_jiffy(ha_mon, clk_stall, threshold_jiffies, time_ns);
+	else if (curr_state == enqueued_stall)
+		ha_cancel_timer(ha_mon);
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	if (!ha_verify_invariants(ha_mon, curr_state, event, next_state, time_ns))
+		return false;
+
+	if (!ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns))
+		return false;
+
+	ha_setup_invariants(ha_mon, curr_state, event, next_state, time_ns);
+
+	return true;
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	if (!preempt && prev_state != TASK_RUNNING)
+		da_handle_start_event(prev, sched_switch_wait_stall);
+	else
+		da_handle_event(prev, sched_switch_preempt_stall);
+	da_handle_event(next, sched_switch_in_stall);
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *p)
+{
+	da_handle_event(p, sched_wakeup_stall);
+}
+
+static int enable_stall(void)
+{
+	int retval;
+
+	retval = da_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("stall", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("stall", sched_wakeup, handle_sched_wakeup);
+
+	return 0;
+}
+
+static void disable_stall(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("stall", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("stall", sched_wakeup, handle_sched_wakeup);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "stall",
+	.description = "identify tasks stalled for longer than a threshold.",
+	.enable = enable_stall,
+	.disable = disable_stall,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_stall(void)
+{
+	return rv_register_monitor(&rv_this, NULL);
+}
+
+static void __exit unregister_stall(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_stall);
+module_exit(unregister_stall);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("stall: identify tasks stalled for longer than a threshold.");
diff --git a/kernel/trace/rv/monitors/stall/stall.h b/kernel/trace/rv/monitors/stall/stall.h
new file mode 100644
index 000000000000..638520cb1082
--- /dev/null
+++ b/kernel/trace/rv/monitors/stall/stall.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of stall automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME stall
+
+enum states_stall {
+	dequeued_stall,
+	enqueued_stall,
+	running_stall,
+	state_max_stall,
+};
+
+#define INVALID_STATE state_max_stall
+
+enum events_stall {
+	sched_switch_in_stall,
+	sched_switch_preempt_stall,
+	sched_switch_wait_stall,
+	sched_wakeup_stall,
+	event_max_stall,
+};
+
+enum envs_stall {
+	clk_stall,
+	env_max_stall,
+	env_max_stored_stall = env_max_stall,
+};
+
+_Static_assert(env_max_stored_stall <= MAX_HA_ENV_LEN, "Not enough slots");
+
+struct automaton_stall {
+	char *state_names[state_max_stall];
+	char *event_names[event_max_stall];
+	char *env_names[env_max_stall];
+	unsigned char function[state_max_stall][event_max_stall];
+	unsigned char initial_state;
+	bool final_states[state_max_stall];
+};
+
+static const struct automaton_stall automaton_stall = {
+	.state_names = {
+		"dequeued",
+		"enqueued",
+		"running",
+	},
+	.event_names = {
+		"sched_switch_in",
+		"sched_switch_preempt",
+		"sched_switch_wait",
+		"sched_wakeup",
+	},
+	.env_names = {
+		"clk",
+	},
+	.function = {
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			enqueued_stall,
+		},
+		{
+			running_stall,
+			INVALID_STATE,
+			INVALID_STATE,
+			enqueued_stall,
+		},
+		{
+			running_stall,
+			enqueued_stall,
+			dequeued_stall,
+			running_stall,
+		},
+	},
+	.initial_state = dequeued_stall,
+	.final_states = { 1, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/stall/stall_trace.h b/kernel/trace/rv/monitors/stall/stall_trace.h
new file mode 100644
index 000000000000..6a7cc1b1d040
--- /dev/null
+++ b/kernel/trace/rv/monitors/stall/stall_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_STALL
+DEFINE_EVENT(event_da_monitor_id, event_stall,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_stall,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_stall,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_STALL */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 7c598967bc0e..1661f8fe4a88 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -187,6 +187,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 		__get_str(env))
 );
 
+#include <monitors/stall/stall_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/stall.dot b/tools/verification/models/stall.dot
new file mode 100644
index 000000000000..50077d1dff74
--- /dev/null
+++ b/tools/verification/models/stall.dot
@@ -0,0 +1,22 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = circle] "enqueued"};
+	{node [shape = plaintext, style=invis, label=""] "__init_dequeued"};
+	{node [shape = doublecircle] "dequeued"};
+	{node [shape = circle] "running"};
+	"__init_dequeued" -> "dequeued";
+	"enqueued" [label = "enqueued\nclk < threshold_jiffies"];
+	"running" [label = "running"];
+	"dequeued" [label = "dequeued", color = green3];
+	"running" -> "running" [ label = "sched_switch_in\nsched_wakeup" ];
+	"enqueued" -> "enqueued" [ label = "sched_wakeup" ];
+	"enqueued" -> "running" [ label = "sched_switch_in" ];
+	"running" -> "dequeued" [ label = "sched_switch_wait" ];
+	"dequeued" -> "enqueued" [ label = "sched_wakeup;reset(clk)" ];
+	"running" -> "enqueued" [ label = "sched_switch_preempt;reset(clk)" ];
+	{ rank = min ;
+		"__init_dequeued";
+		"dequeued";
+	}
+}
-- 
2.52.0

