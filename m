Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702229993A;
	Wed, 30 Jul 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879555; cv=none; b=e0+TVM7hYswlGWzfghsWzkS6tv38WyuhnFzqc/xdqxzp1xvhAuH/rV6ya4jDgbG470i17WbAP81GUfwbpij0FAfP2N+pWD2eMT0v21xLLK44gYOPLw/UQWGg1ecj1WxX6kGAWH4PYdD7dwu4CDuNmJDdlunM2LgU38H/p0gvsas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879555; c=relaxed/simple;
	bh=Nqqw8GQdbkA2wcGUdKyFw4jWrP7v4bYhHnJ7hECZ5vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDi56gDbuV6eg5qCpbOR9wJByOrSujNFdYgwKFHR8Uv5/uDyptpu4YdaIKeMX1x/gRTjYZxBydo1c1e4DPHPYP6kAO/I9S778t9xmIL+m1V4ZhdutLwjxbaY/Zl6Np9WKmKuw3yzuyp+Nvs1mcP2XztBSGHlx7xfB+Pbuu+zzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=teYNSu3X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=izaKvcsx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="teYNSu3X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="izaKvcsx"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753879549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsmGN1MF/UyltIqjER+3HwzGgGupyEGtu2ZKTPREJG0=;
	b=teYNSu3X0Bt9RYo10Ooc8Y1C4rRdcTqfS550PYOGMT0AuIVWethuYENPCYkpPvf8duoXsg
	7JnWVRc5/1E6QUJl574rzaCGnx1BbBuIvvuAIzr3iiv4XUdsBfDOhbkrLMKRt9Y5xGKly4
	s7xdx8PT56Fq3azulW7dYldF7+BAiApp/revc9N8OWLdxLHv3o6oYnHgVmxlQcQevFGxjH
	QguMVPANtWI3GQI0N3v2l9NVKpnKbLppPiuWciCaWix3vb+y5KK2bAhVhnWZxVmdvWWKdo
	e5tQSV16GJHcHHhPbC8+sNfr47tLoSoab8BAV395sBxpHmg2gFPggOdIToa+4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753879549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsmGN1MF/UyltIqjER+3HwzGgGupyEGtu2ZKTPREJG0=;
	b=izaKvcsxwEqS/e22LGHCRysoODHOQDd2z2HqM3x/OevPD3sMa4q4XPpk0014FQoGtJvEA3
	gFZ9/0hxSDmwvGBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 5/5] rv: Add rts monitor
Date: Wed, 30 Jul 2025 14:45:43 +0200
Message-Id: <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
In-Reply-To: <cover.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add "real-time scheduling" monitor, which validates that SCHED_RR and
SCHED_FIFO tasks are scheduled before tasks with normal and extensible
scheduling policies

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst |  19 ++++
 kernel/trace/rv/Kconfig                  |   1 +
 kernel/trace/rv/Makefile                 |   1 +
 kernel/trace/rv/monitors/rts/Kconfig     |  17 +++
 kernel/trace/rv/monitors/rts/rts.c       | 131 +++++++++++++++++++++++
 kernel/trace/rv/monitors/rts/rts.h       | 126 ++++++++++++++++++++++
 kernel/trace/rv/monitors/rts/rts_trace.h |  15 +++
 tools/verification/models/sched/rts.ltl  |   5 +
 8 files changed, 315 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/rts/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rts/rts.c
 create mode 100644 kernel/trace/rv/monitors/rts/rts.h
 create mode 100644 kernel/trace/rv/monitors/rts/rts_trace.h
 create mode 100644 tools/verification/models/sched/rts.ltl

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace=
/rv/monitor_sched.rst
index 3f8381ad9ec7..2f9d62a1af1f 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -396,6 +396,25 @@ preemption is always disabled. On non- ``PREEMPT_RT`` =
kernels, the interrupts
 might invoke a softirq to set ``need_resched`` and wake up a task. This is
 another special case that is currently not supported by the monitor.
=20
+Monitor rts
+-----------
+
+The real-time scheduling monitor validates that tasks with real-time sched=
uling
+policies (`SCHED_FIFO` and `SCHED_RR`) are always scheduled before tasks w=
ith
+normal and extensible scheduling policies (`SCHED_OTHER`, `SCHED_BATCH`,
+`SCHED_IDLE`, `SCHED_EXT`):
+
+.. literalinclude:: ../../../tools/verification/models/sched/rts.ltl
+
+Note that this monitor may report errors if real-time throttling or fair
+deadline server is enabled. These mechanisms prevent real-time tasks from
+monopolying the CPU by giving tasks with normal and extensible scheduling
+policies a chance to run. They give system administrators a chance to kill=
 a
+misbehaved real-time task. However, they violate the scheduling priorities=
 and
+may cause latency to well-behaved real-time tasks. Thus, if you see errors=
 from
+this monitor, consider disabling real-time throttling and the fair deadline
+server.
+
 References
 ----------
=20
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 951c2e0cda25..3992ff6ac8b1 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -62,6 +62,7 @@ source "kernel/trace/rv/monitors/sts/Kconfig"
 source "kernel/trace/rv/monitors/nrp/Kconfig"
 source "kernel/trace/rv/monitors/sssw/Kconfig"
 source "kernel/trace/rv/monitors/opid/Kconfig"
+source "kernel/trace/rv/monitors/rts/Kconfig"
 # Add new sched monitors here
=20
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 750e4ad6fa0f..d7bfc7ae6677 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_RV_MON_STS) +=3D monitors/sts/sts.o
 obj-$(CONFIG_RV_MON_NRP) +=3D monitors/nrp/nrp.o
 obj-$(CONFIG_RV_MON_SSSW) +=3D monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
+obj-$(CONFIG_RV_MON_RTS) +=3D monitors/rts/rts.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
diff --git a/kernel/trace/rv/monitors/rts/Kconfig b/kernel/trace/rv/monitor=
s/rts/Kconfig
new file mode 100644
index 000000000000..1b780bce6133
--- /dev/null
+++ b/kernel/trace/rv/monitors/rts/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_RTS
+	depends on RV
+	select RV_LTL_MONITOR
+	depends on RV_MON_SCHED
+	default y
+	select LTL_MON_EVENTS_IMPLICIT
+	bool "rts monitor"
+	help
+	  Add support for RTS (real-time scheduling) monitor which validates
+	  that real-time-priority tasks are scheduled before SCHED_OTHER tasks.
+
+	  This monitor may report an error if RT throttling or deadline server
+	  is enabled.
+
+	  Say Y if you are debugging or testing a real-time system.
diff --git a/kernel/trace/rv/monitors/rts/rts.c b/kernel/trace/rv/monitors/=
rts/rts.c
new file mode 100644
index 000000000000..e23563c47eb1
--- /dev/null
+++ b/kernel/trace/rv/monitors/rts/rts.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <linux/sched/deadline.h>
+#include <linux/sched/rt.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "rts"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "rts.h"
+#include <rv/ltl_monitor.h>
+
+static DEFINE_PER_CPU(unsigned int, nr_queued);
+
+static void ltl_atoms_fetch(unsigned int cpu, struct ltl_monitor *mon)
+{
+}
+
+static void ltl_atoms_init(unsigned int cpu, struct ltl_monitor *mon,
+			   bool target_creation)
+{
+	ltl_atom_set(mon, LTL_SCHED_SWITCH, false);
+	ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, false);
+	ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, false);
+
+	/*
+	 * This may not be accurate, there may be enqueued RT tasks. But that's
+	 * okay, the worst we get is a false negative. It will be accurate as
+	 * soon as the CPU no longer has any queued RT task.
+	 */
+	ltl_atom_set(mon, LTL_RT_TASK_ENQUEUED, false);
+}
+
+static void handle_enqueue_task_rt(void *data, int cpu, struct task_struct=
 *task)
+{
+	unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
+
+	(*queued)++;
+	ltl_atom_update(cpu, LTL_RT_TASK_ENQUEUED, true);
+}
+
+static void handle_dequeue_task_rt(void *data, int cpu, struct task_struct=
 *task)
+{
+	unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
+
+	/*
+	 * This may not be accurate for a short time after the monitor is
+	 * enabled, because there may be enqueued RT tasks which are not counted
+	 * torward nr_queued. But that's okay, the worst we get is a false
+	 * negative. nr_queued will be accurate as soon as the CPU no longer has
+	 * any queued RT task.
+	 */
+	if (*queued)
+		(*queued)--;
+	if (!*queued)
+		ltl_atom_update(cpu, LTL_RT_TASK_ENQUEUED, false);
+}
+
+static void handle_sched_switch(void *data, bool preempt, struct task_stru=
ct *prev,
+				struct task_struct *next, unsigned int prev_state)
+{
+	unsigned int cpu =3D smp_processor_id();
+	struct ltl_monitor *mon =3D ltl_get_monitor(cpu);
+
+	ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, rt_task(next));
+	ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, dl_task(next));
+	ltl_atom_update(cpu, LTL_SCHED_SWITCH, true);
+
+	ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, false);
+	ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, false);
+	ltl_atom_update(cpu, LTL_SCHED_SWITCH, false);
+}
+
+static int enable_rts(void)
+{
+	int retval;
+
+	retval =3D ltl_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("rts", enqueue_task_rt_tp, handle_enqueue_task_rt);
+	rv_attach_trace_probe("rts", dequeue_task_rt_tp, handle_dequeue_task_rt);
+	rv_attach_trace_probe("rts", sched_switch, handle_sched_switch);
+
+	return 0;
+}
+
+static void disable_rts(void)
+{
+	rv_detach_trace_probe("rts", enqueue_task_rt_tp, handle_enqueue_task_rt);
+	rv_detach_trace_probe("rts", dequeue_task_rt_tp, handle_dequeue_task_rt);
+	rv_detach_trace_probe("rts", sched_switch, handle_sched_switch);
+
+	ltl_monitor_destroy();
+}
+
+/*
+ * This is the monitor register section.
+ */
+static struct rv_monitor rv_rts =3D {
+	.name =3D "rts",
+	.description =3D "Validate that real-time tasks are scheduled before lowe=
r-priority tasks",
+	.enable =3D enable_rts,
+	.disable =3D disable_rts,
+};
+
+static int __init register_rts(void)
+{
+	return rv_register_monitor(&rv_rts, &rv_sched);
+}
+
+static void __exit unregister_rts(void)
+{
+	rv_unregister_monitor(&rv_rts);
+}
+
+module_init(register_rts);
+module_exit(unregister_rts);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
+MODULE_DESCRIPTION("rts: Validate that real-time tasks are scheduled befor=
e lower-priority tasks");
diff --git a/kernel/trace/rv/monitors/rts/rts.h b/kernel/trace/rv/monitors/=
rts/rts.h
new file mode 100644
index 000000000000..9fbf0d97c1a7
--- /dev/null
+++ b/kernel/trace/rv/monitors/rts/rts.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * C implementation of Buchi automaton, automatically generated by
+ * tools/verification/rvgen from the linear temporal logic specification.
+ * For further information, see kernel documentation:
+ *   Documentation/trace/rv/linear_temporal_logic.rst
+ */
+
+#include <linux/rv.h>
+
+#define MONITOR_NAME rts
+
+#define LTL_MONITOR_TYPE LTL_CPU_MONITOR
+
+enum ltl_atom {
+	LTL_RT_TASK_ENQUEUED,
+	LTL_SCHED_SWITCH,
+	LTL_SCHED_SWITCH_DL,
+	LTL_SCHED_SWITCH_RT,
+	LTL_NUM_ATOM
+};
+static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);
+
+static const char *ltl_atom_str(enum ltl_atom atom)
+{
+	static const char *const names[] =3D {
+		"rt_ta_en",
+		"sc_sw",
+		"sc_sw_dl",
+		"sc_sw_rt",
+	};
+
+	return names[atom];
+}
+
+enum ltl_buchi_state {
+	S0,
+	S1,
+	S2,
+	S3,
+	S4,
+	RV_NUM_BA_STATES
+};
+static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
+
+static void ltl_start(unsigned int cpu, struct ltl_monitor *mon)
+{
+	bool sched_switch_rt =3D test_bit(LTL_SCHED_SWITCH_RT, mon->atoms);
+	bool sched_switch_dl =3D test_bit(LTL_SCHED_SWITCH_DL, mon->atoms);
+	bool sched_switch =3D test_bit(LTL_SCHED_SWITCH, mon->atoms);
+	bool rt_task_enqueued =3D test_bit(LTL_RT_TASK_ENQUEUED, mon->atoms);
+	bool val13 =3D !rt_task_enqueued;
+	bool val8 =3D sched_switch_dl || val13;
+	bool val9 =3D sched_switch_rt || val8;
+	bool val6 =3D !sched_switch;
+	bool val1 =3D !rt_task_enqueued;
+
+	if (val1)
+		__set_bit(S0, mon->states);
+	if (val6)
+		__set_bit(S1, mon->states);
+	if (val9)
+		__set_bit(S4, mon->states);
+}
+
+static void
+ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsi=
gned long *next)
+{
+	bool sched_switch_rt =3D test_bit(LTL_SCHED_SWITCH_RT, mon->atoms);
+	bool sched_switch_dl =3D test_bit(LTL_SCHED_SWITCH_DL, mon->atoms);
+	bool sched_switch =3D test_bit(LTL_SCHED_SWITCH, mon->atoms);
+	bool rt_task_enqueued =3D test_bit(LTL_RT_TASK_ENQUEUED, mon->atoms);
+	bool val13 =3D !rt_task_enqueued;
+	bool val8 =3D sched_switch_dl || val13;
+	bool val9 =3D sched_switch_rt || val8;
+	bool val6 =3D !sched_switch;
+	bool val1 =3D !rt_task_enqueued;
+
+	switch (state) {
+	case S0:
+		if (val1)
+			__set_bit(S0, next);
+		if (val6)
+			__set_bit(S1, next);
+		if (val9)
+			__set_bit(S4, next);
+		break;
+	case S1:
+		if (val6)
+			__set_bit(S1, next);
+		if (val1 && val6)
+			__set_bit(S2, next);
+		if (val1 && val9)
+			__set_bit(S3, next);
+		if (val9)
+			__set_bit(S4, next);
+		break;
+	case S2:
+		if (val6)
+			__set_bit(S1, next);
+		if (val1 && val6)
+			__set_bit(S2, next);
+		if (val1 && val9)
+			__set_bit(S3, next);
+		if (val9)
+			__set_bit(S4, next);
+		break;
+	case S3:
+		if (val1)
+			__set_bit(S0, next);
+		if (val6)
+			__set_bit(S1, next);
+		if (val9)
+			__set_bit(S4, next);
+		break;
+	case S4:
+		if (val1)
+			__set_bit(S0, next);
+		if (val6)
+			__set_bit(S1, next);
+		if (val9)
+			__set_bit(S4, next);
+		break;
+	}
+}
diff --git a/kernel/trace/rv/monitors/rts/rts_trace.h b/kernel/trace/rv/mon=
itors/rts/rts_trace.h
new file mode 100644
index 000000000000..0ac9e112a8b0
--- /dev/null
+++ b/kernel/trace/rv/monitors/rts/rts_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_RTS
+DEFINE_EVENT(event_ltl_monitor, event_rts,
+	TP_PROTO(unsigned int cpu, char *states, char *atoms, char *next),
+	TP_ARGS(cpu, states, atoms, next));
+
+DEFINE_EVENT(error_ltl_monitor, error_rts,
+	TP_PROTO(unsigned int cpu),
+	TP_ARGS(cpu));
+#endif /* CONFIG_RV_MON_RTS */
diff --git a/tools/verification/models/sched/rts.ltl b/tools/verification/m=
odels/sched/rts.ltl
new file mode 100644
index 000000000000..90872bca46b1
--- /dev/null
+++ b/tools/verification/models/sched/rts.ltl
@@ -0,0 +1,5 @@
+RULE =3D always (RT_TASK_ENQUEUED imply SCHEDULE_RT_NEXT)
+
+SCHEDULE_RT_NEXT =3D (not SCHED_SWITCH) until (SCHED_SWITCH_RT or EXCEPTIO=
NS)
+
+EXCEPTIONS =3D SCHED_SWITCH_DL or not RT_TASK_ENQUEUED
--=20
2.39.5

