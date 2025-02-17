Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2C21C9F6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797979; cv=none; b=J/8xk3pkstfr5bg4Xxuqh2ITPKBacI7+UzLZLhBwNSDAbTCNL9NQDTySqiGWxcbgSjlliKaqP712+NAZAf21wcbsQGnAoI50NAEjOgNTvsyJRIR3gk0CcsDFc65SnBoJs182WYDOTrk77M2vf7TCxJhdY1DkrlcHDKdr4x5ubIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797979; c=relaxed/simple;
	bh=j2DIEPJn234b25zWy2ollwEvyS7l9DLI9kE9Xxv/KPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgHolswCzpu2sSWpcKP1DZ7cOs+HhprAgkFz/+M1KP3LsDcwOCbNQI7vA+bEJD65fkLmaF5dXZhblu2xILus8x8maSR+wQqpQSPGWmhVfKsj11Y1cUEt+MZe7qxKF44a6iuk08FpStueigIpcacNoEuN0pyMBBdrBCAe7jZ9JpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSMZDwcJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSMZDwcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739797975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncfRznIDJ0C7V6n5PD+CDnDY5iuvbJ9L9cieyHdRpfI=;
	b=VSMZDwcJPlYxseFGRwruoqzXSaLxfB09pKByj3HxwDc+SefCV5uwor9r/7UGu+93QNhJyO
	bm58boWDa/TCirZmDvTZsl0zjXA6LZtL/p3/UfVfeWZwPZZJ92chpI4RDWRoF/+xr63rGV
	HBiIPNTffd5k9qG6QZCWVyQmDloXfbg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-hROh814MMEWeS79anPxqkg-1; Mon,
 17 Feb 2025 08:12:52 -0500
X-MC-Unique: hROh814MMEWeS79anPxqkg-1
X-Mimecast-MFC-AGG-ID: hROh814MMEWeS79anPxqkg_1739797971
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E76119373D8;
	Mon, 17 Feb 2025 13:12:51 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0CB4180035E;
	Mon, 17 Feb 2025 13:12:47 +0000 (UTC)
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
Subject: [PATCH v2 06/11] rv: Add snroc per-task monitor
Date: Mon, 17 Feb 2025 14:11:57 +0100
Message-ID: <20250217131206.388485-7-gmonaco@redhat.com>
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

Add a per-task monitor as part of the sched model:

* snroc: set non runnable on its own context
    Monitor to ensure set_state happens only in the respective task's context

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Kconfig                      |  1 +
 kernel/trace/rv/Makefile                     |  1 +
 kernel/trace/rv/monitors/snroc/Kconfig       | 14 ++++
 kernel/trace/rv/monitors/snroc/snroc.c       | 87 ++++++++++++++++++++
 kernel/trace/rv/monitors/snroc/snroc.h       | 47 +++++++++++
 kernel/trace/rv/monitors/snroc/snroc_trace.h | 15 ++++
 kernel/trace/rv/rv_trace.h                   |  1 +
 tools/verification/models/sched/snroc.dot    | 18 ++++
 8 files changed, 184 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/snroc/Kconfig
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc.c
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc.h
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc_trace.h
 create mode 100644 tools/verification/models/sched/snroc.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 961ac1e487df1..c4f1c0fc3abc6 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -30,6 +30,7 @@ source "kernel/trace/rv/monitors/wwnr/Kconfig"
 source "kernel/trace/rv/monitors/sched/Kconfig"
 source "kernel/trace/rv/monitors/tss/Kconfig"
 source "kernel/trace/rv/monitors/sco/Kconfig"
+source "kernel/trace/rv/monitors/snroc/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index ef2a084ff3102..6d11d6400ddd0 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
 obj-$(CONFIG_RV_MON_TSS) += monitors/tss/tss.o
 obj-$(CONFIG_RV_MON_SCO) += monitors/sco/sco.o
+obj-$(CONFIG_RV_MON_SNROC) += monitors/snroc/snroc.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/snroc/Kconfig b/kernel/trace/rv/monitors/snroc/Kconfig
new file mode 100644
index 0000000000000..6e4365a2fea3b
--- /dev/null
+++ b/kernel/trace/rv/monitors/snroc/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SNROC
+	depends on RV
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_ID
+	bool "snroc monitor"
+	help
+	  Monitor to ensure sched_set_state happens only in the respective task's context.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
new file mode 100644
index 0000000000000..14c8eca3d5c8e
--- /dev/null
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -0,0 +1,87 @@
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
+#define MODULE_NAME "snroc"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "snroc.h"
+
+static struct rv_monitor rv_snroc;
+DECLARE_DA_MON_PER_TASK(snroc, unsigned char);
+
+static void handle_sched_set_state(void *data, struct task_struct *tsk, int curr_state, int state)
+{
+	struct task_struct *p = tsk;
+
+	da_handle_event_snroc(p, sched_set_state_snroc);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	da_handle_start_event_snroc(prev, sched_switch_out_snroc);
+	da_handle_event_snroc(next, sched_switch_in_snroc);
+}
+
+static int enable_snroc(void)
+{
+	int retval;
+
+	retval = da_monitor_init_snroc();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
+	rv_attach_trace_probe("snroc", sched_switch, handle_sched_switch);
+
+	return 0;
+}
+
+static void disable_snroc(void)
+{
+	rv_snroc.enabled = 0;
+
+	rv_detach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
+	rv_detach_trace_probe("snroc", sched_switch, handle_sched_switch);
+
+	da_monitor_destroy_snroc();
+}
+
+static struct rv_monitor rv_snroc = {
+	.name = "snroc",
+	.description = "set non runnable on its own context.",
+	.enable = enable_snroc,
+	.disable = disable_snroc,
+	.reset = da_monitor_reset_all_snroc,
+	.enabled = 0,
+};
+
+static int __init register_snroc(void)
+{
+	rv_register_monitor(&rv_snroc, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_snroc(void)
+{
+	rv_unregister_monitor(&rv_snroc);
+}
+
+module_init(register_snroc);
+module_exit(unregister_snroc);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("snroc: set non runnable on its own context.");
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
new file mode 100644
index 0000000000000..c3650a2b1b107
--- /dev/null
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of snroc automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_snroc {
+	other_context_snroc = 0,
+	own_context_snroc,
+	state_max_snroc
+};
+
+#define INVALID_STATE state_max_snroc
+
+enum events_snroc {
+	sched_set_state_snroc = 0,
+	sched_switch_in_snroc,
+	sched_switch_out_snroc,
+	event_max_snroc
+};
+
+struct automaton_snroc {
+	char *state_names[state_max_snroc];
+	char *event_names[event_max_snroc];
+	unsigned char function[state_max_snroc][event_max_snroc];
+	unsigned char initial_state;
+	bool final_states[state_max_snroc];
+};
+
+static const struct automaton_snroc automaton_snroc = {
+	.state_names = {
+		"other_context",
+		"own_context"
+	},
+	.event_names = {
+		"sched_set_state",
+		"sched_switch_in",
+		"sched_switch_out"
+	},
+	.function = {
+		{      INVALID_STATE,  own_context_snroc,       INVALID_STATE },
+		{  own_context_snroc,      INVALID_STATE, other_context_snroc },
+	},
+	.initial_state = other_context_snroc,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/snroc/snroc_trace.h b/kernel/trace/rv/monitors/snroc/snroc_trace.h
new file mode 100644
index 0000000000000..50114cef51229
--- /dev/null
+++ b/kernel/trace/rv/monitors/snroc/snroc_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SNROC
+DEFINE_EVENT(event_da_monitor_id, event_snroc,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_snroc,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+#endif /* CONFIG_RV_MON_SNROC */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index f49e85ca97a1f..a533bc29cfddf 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -120,6 +120,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 );
 
 #include <monitors/wwnr/wwnr_trace.h>
+#include <monitors/snroc/snroc_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
 #endif /* CONFIG_DA_MON_EVENTS_ID */
diff --git a/tools/verification/models/sched/snroc.dot b/tools/verification/models/sched/snroc.dot
new file mode 100644
index 0000000000000..8b71c32d4dca4
--- /dev/null
+++ b/tools/verification/models/sched/snroc.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_other_context"};
+	{node [shape = ellipse] "other_context"};
+	{node [shape = plaintext] "other_context"};
+	{node [shape = plaintext] "own_context"};
+	"__init_other_context" -> "other_context";
+	"other_context" [label = "other_context", color = green3];
+	"other_context" -> "own_context" [ label = "sched_switch_in" ];
+	"own_context" [label = "own_context"];
+	"own_context" -> "other_context" [ label = "sched_switch_out" ];
+	"own_context" -> "own_context" [ label = "sched_set_state" ];
+	{ rank = min ;
+		"__init_other_context";
+		"other_context";
+	}
+}
-- 
2.48.1

