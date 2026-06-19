Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91833342C;
	Fri, 19 Jun 2026 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853699; cv=none; b=FCV9HHzzGhmcrn6TDRXTCwJRLA24i4r0UnhTsr9K0WVjN+k+lyBEsVUmydo5KzKxaMShVtslspO1P0Qef5BDv4PKl2PaFKktUd3F4PVmeHx4ZSz/XnuTRM9ZvJDYRScMMqqJT9TLTDrV4Vc/ur4WLL12R69pt4tGcsRn25AJ9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853699; c=relaxed/simple;
	bh=pe/7w0nsVQI7RE6ST7vE+VzdjoDqzE2MczjoaVA+T14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJVcyr0KQQhypRphsI2kAkG6VtVuG+NQQ+sH13ZmkA9lDyYKoQ4kw2XE15M18BgEoUjU8Jv0cmCpa77PB/uzLjKJ+KdCmONpQ0xAaZF3YewEISEwMTgSR7xBSHh2rGh026Gr1yzO1n1yzkuaQpU20hn20QJepN+kO17wbRheF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rlu6fAev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L/pql04W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlu6fAev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L/pql04W"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781853695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOPUw3LrTiUvvk3hfS8OK2fTpRBgOstuolv92aaa8uI=;
	b=rlu6fAev2eyJ9tjoRK66R2ArjgzCCAC5fEUfX9MdEllkKptwacIkICqyxLxvMh7Ha76NqH
	xIi674s4kcuk4DqC6Q4EvGW9WwR1DSGsTBP+iEh2vJEnzky3Q+gw+Os5NJWFy8hyqYWtX8
	bgF9KJVnpJGXXuzgMxlZqO2kwn5qZHyQUDULv13X1f1Ex48qUnxqf60jk/xNtOichJz5fE
	uGnRrStbhKywn33a5jeTLB0ue+gRn0U0gQwAXfNdcnVUNkoJyUVex7rCC2MA030r8Z06tC
	32HcUF28zbxX8cflCVuJs1fJHS8vPGeg3iLwCQkyyUOKlGtOlT3f40d81ZqrfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781853695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOPUw3LrTiUvvk3hfS8OK2fTpRBgOstuolv92aaa8uI=;
	b=L/pql04WMVK0T3ZWClYpfPMSoeOFIehMshYlyY5jp0rc7/ijagRZloiuWPD1id37uP2Tni
	+DRIV8dQaGZJP4Dw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 4/4] rv/rtapp: Add wakeup monitor
Date: Fri, 19 Jun 2026 09:21:22 +0200
Message-ID: <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
In-Reply-To: <cover.1781852967.git.namcao@linutronix.de>
References: <cover.1781852967.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a wakeup monitor to detect a lower-priority task waking up a
higher-priority task.

The rtapp/sleep monitor already detects this. However, that monitor
triggers an error in the context of the wakee task and user only gets
the stacktrace of that task. It is also extremely useful to get the
stacktrace of the waker task, which this monitor offers. In other
words, this monitor complements the rtapp/sleep monitor.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/monitor_rtapp.rst      |  20 +++
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/rtapp/Kconfig        |   2 +-
 kernel/trace/rv/monitors/wakeup/Kconfig       |  16 ++
 kernel/trace/rv/monitors/wakeup/wakeup.c      | 153 ++++++++++++++++++
 kernel/trace/rv/monitors/wakeup/wakeup.h      |  92 +++++++++++
 .../trace/rv/monitors/wakeup/wakeup_trace.h   |  14 ++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/rtapp/wakeup.ltl    |   5 +
 10 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100644 kernel/trace/rv/monitors/wakeup/Kconfig
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.c
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.h
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup_trace.h
 create mode 100644 tools/verification/models/rtapp/wakeup.ltl

diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace=
/rv/monitor_rtapp.rst
index 502d3ea412eb..238b59395ff5 100644
--- a/Documentation/trace/rv/monitor_rtapp.rst
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -124,3 +124,23 @@ to handle some special cases:
     real-time-safe because preemption is disabled for the duration.
   - `FUTEX_LOCK_PI` is included in the allowlist for the same reason as
     `BLOCK_ON_RT_MUTEX`.
+
+Monitor wakeup
+++++++++++++++
+
+The `wakeup` monitor reports real-time threads being woken by lower-priori=
ty threads,
+which is a hint of priority inversion. Its specification is::
+
+  RULE =3D always (((RT and USER_THREAD) imply
+                (not (WOKEN_BY_LOWER_PRIO or WOKEN_BY_SOFTIRQ)) or ALLOWLI=
ST))
+
+  ALLOWLIST =3D BLOCK_ON_RT_MUTEX
+           or FUTEX_LOCK_PI
+
+The `sleep` monitor already reports this type of problem. The difference i=
s the
+context in which the problem is reported. While the `sleep` monitor report=
s the problem
+in the context of the wakee, this `wakeup` monitor reports the problem in =
the context of
+the waker. This monitor complement the `sleep` monitor, giving user better
+understanding of the issue. For instance, to debug a lower-priority task w=
aking a
+higher-priority task scenario, user can enable both `wakeup` monitor and `=
sleep`
+monitor to get the stack traces of both tasks.
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..4d3a14a0bac2 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -76,6 +76,7 @@ source "kernel/trace/rv/monitors/opid/Kconfig"
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
 source "kernel/trace/rv/monitors/pagefault/Kconfig"
 source "kernel/trace/rv/monitors/sleep/Kconfig"
+source "kernel/trace/rv/monitors/wakeup/Kconfig"
 # Add new rtapp monitors here
=20
 source "kernel/trace/rv/monitors/stall/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 94498da35b37..c2c0e4142eb4 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_STALL) +=3D monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) +=3D monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) +=3D monitors/nomiss/nomiss.o
+obj-$(CONFIG_RV_MON_WAKEUP) +=3D monitors/wakeup/wakeup.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig b/kernel/trace/rv/monit=
ors/rtapp/Kconfig
index 1ce9370a9ba8..1fcd7a400ded 100644
--- a/kernel/trace/rv/monitors/rtapp/Kconfig
+++ b/kernel/trace/rv/monitors/rtapp/Kconfig
@@ -1,6 +1,6 @@
 config RV_MON_RTAPP
 	depends on RV
-	depends on RV_PER_TASK_MONITORS >=3D 2
+	depends on RV_PER_TASK_MONITORS >=3D 3
 	bool "rtapp monitor"
 	help
 	  Collection of monitors to check for common problems with real-time
diff --git a/kernel/trace/rv/monitors/wakeup/Kconfig b/kernel/trace/rv/moni=
tors/wakeup/Kconfig
new file mode 100644
index 000000000000..ec3a5c06a8c4
--- /dev/null
+++ b/kernel/trace/rv/monitors/wakeup/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_WAKEUP
+	depends on RV
+	depends on RV_MON_RTAPP
+	depends on HAVE_SYSCALL_TRACEPOINTS
+	default y
+	select LTL_MON_EVENTS_ID
+	bool "wakeup monitor"
+	help
+	  This monitor detects a lower-priority task waking up a
+	  higher-priority task. The RV_MON_SLEEP monitor already
+	  detects this case, but this monitor detects in the context
+	  of the waker task instead. This and RV_MON_SLEEP can be
+	  enabled together to get the stacktrace of both the waker
+	  task and the wakee task.
diff --git a/kernel/trace/rv/monitors/wakeup/wakeup.c b/kernel/trace/rv/mon=
itors/wakeup/wakeup.c
new file mode 100644
index 000000000000..01b47416f24e
--- /dev/null
+++ b/kernel/trace/rv/monitors/wakeup/wakeup.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "wakeup"
+
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <trace/events/lock.h>
+#include <uapi/linux/futex.h>
+
+#include <rv_trace.h>
+#include <monitors/rtapp/rtapp.h>
+
+
+#ifndef __NR_futex
+#define __NR_futex (-__COUNTER__)
+#endif
+#ifndef __NR_futex_time64
+#define __NR_futex_time64 (-__COUNTER__)
+#endif
+
+#include "wakeup.h"
+#include <rv/ltl_monitor.h>
+
+static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *=
mon)
+{
+	/*
+	 * This includes "actual" real-time tasks and also PI-boosted
+	 * tasks. A task being PI-boosted means it is blocking an "actual"
+	 * real-task, therefore it should also obey the monitor's rule,
+	 * otherwise the "actual" real-task may be delayed.
+	 */
+	ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
+}
+
+static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *m=
on, bool task_creation)
+{
+	ltl_atom_set(mon, LTL_WOKEN_BY_LOWER_PRIO, false);
+	ltl_atom_set(mon, LTL_WOKEN_BY_SOFTIRQ, false);
+
+	if (task_creation) {
+		ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
+		ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
+	}
+
+	ltl_atom_set(mon, LTL_USER_THREAD, !(task->flags & PF_KTHREAD));
+}
+
+static void handle_sched_waking(void *data, struct task_struct *task)
+{
+	if (in_task()) {
+		if (current->prio > task->prio)
+			ltl_atom_pulse(task, LTL_WOKEN_BY_LOWER_PRIO, true);
+	} else if (in_serving_softirq()) {
+		ltl_atom_pulse(task, LTL_WOKEN_BY_SOFTIRQ, true);
+	}
+}
+
+static void handle_contention_begin(void *data, void *lock, unsigned int f=
lags)
+{
+	if (flags & LCB_F_RT)
+		ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, true);
+}
+
+static void handle_contention_end(void *data, void *lock, int ret)
+{
+	ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, false);
+}
+
+static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
+{
+	unsigned long args[6];
+	int op, cmd;
+
+	switch (id) {
+	case __NR_futex:
+	case __NR_futex_time64:
+		syscall_get_arguments(current, regs, args);
+		op =3D args[1];
+		cmd =3D op & FUTEX_CMD_MASK;
+
+		switch (cmd) {
+		case FUTEX_LOCK_PI:
+		case FUTEX_LOCK_PI2:
+			ltl_atom_update(current, LTL_FUTEX_LOCK_PI, true);
+			break;
+		}
+		break;
+	}
+}
+
+static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
+{
+	ltl_atom_update(current, LTL_FUTEX_LOCK_PI, false);
+}
+
+static int enable_wakeup(void)
+{
+	int retval;
+
+	retval =3D ltl_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("rtapp_wakeup", sched_waking, handle_sched_waking);
+	rv_attach_trace_probe("rtapp_wakeup", contention_begin, handle_contention=
_begin);
+	rv_attach_trace_probe("rtapp_wakeup", contention_end, handle_contention_e=
nd);
+	rv_attach_trace_probe("rtapp_wakeup", sys_enter, handle_sys_enter);
+	rv_attach_trace_probe("rtapp_wakeup", sys_exit, handle_sys_exit);
+
+	return 0;
+}
+
+static void disable_wakeup(void)
+{
+	rv_detach_trace_probe("rtapp_wakeup", sched_waking, handle_sched_waking);
+	rv_detach_trace_probe("rtapp_wakeup", contention_begin, handle_contention=
_begin);
+	rv_detach_trace_probe("rtapp_wakeup", contention_end, handle_contention_e=
nd);
+	rv_detach_trace_probe("rtapp_wakeup", sys_enter, handle_sys_enter);
+	rv_detach_trace_probe("rtapp_wakeup", sys_exit, handle_sys_exit);
+
+	ltl_monitor_destroy();
+}
+
+static struct rv_monitor rv_wakeup =3D {
+	.name =3D "wakeup",
+	.description =3D "Monitor that real-time tasks are not woken by lower-pri=
ority tasks",
+	.enable =3D enable_wakeup,
+	.disable =3D disable_wakeup,
+};
+
+static int __init register_wakeup(void)
+{
+	return rv_register_monitor(&rv_wakeup, &rv_rtapp);
+}
+
+static void __exit unregister_wakeup(void)
+{
+	rv_unregister_monitor(&rv_wakeup);
+}
+
+module_init(register_wakeup);
+module_exit(unregister_wakeup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
+MODULE_DESCRIPTION("Monitor that real-time tasks are not woken by lower-pr=
iority tasks");
diff --git a/kernel/trace/rv/monitors/wakeup/wakeup.h b/kernel/trace/rv/mon=
itors/wakeup/wakeup.h
new file mode 100644
index 000000000000..6f80da64e0e1
--- /dev/null
+++ b/kernel/trace/rv/monitors/wakeup/wakeup.h
@@ -0,0 +1,92 @@
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
+#define MONITOR_NAME wakeup
+
+enum ltl_atom {
+	LTL_BLOCK_ON_RT_MUTEX,
+	LTL_FUTEX_LOCK_PI,
+	LTL_RT,
+	LTL_USER_THREAD,
+	LTL_WOKEN_BY_LOWER_PRIO,
+	LTL_WOKEN_BY_SOFTIRQ,
+	LTL_NUM_ATOM
+};
+static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);
+
+static const char *ltl_atom_str(enum ltl_atom atom)
+{
+	static const char *const names[] =3D {
+		"bl_on_rt_mu",
+		"fu_lo_pi",
+		"rt",
+		"us_th",
+		"wo_lo_pr",
+		"wo_so",
+	};
+
+	return names[atom];
+}
+
+enum ltl_buchi_state {
+	S0,
+	RV_NUM_BA_STATES
+};
+static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
+
+static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
+{
+	bool woken_by_softirq =3D test_bit(LTL_WOKEN_BY_SOFTIRQ, mon->atoms);
+	bool woken_by_lower_prio =3D test_bit(LTL_WOKEN_BY_LOWER_PRIO, mon->atoms=
);
+	bool user_thread =3D test_bit(LTL_USER_THREAD, mon->atoms);
+	bool rt =3D test_bit(LTL_RT, mon->atoms);
+	bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
+	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
+	bool val9 =3D block_on_rt_mutex || futex_lock_pi;
+	bool val6 =3D !woken_by_softirq;
+	bool val5 =3D !woken_by_lower_prio;
+	bool val8 =3D val5 && val6;
+	bool val10 =3D val8 || val9;
+	bool val3 =3D !user_thread;
+	bool val2 =3D !rt;
+	bool val4 =3D val2 || val3;
+	bool val11 =3D val4 || val10;
+
+	if (val11)
+		__set_bit(S0, mon->states);
+}
+
+static void
+ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsi=
gned long *next)
+{
+	bool woken_by_softirq =3D test_bit(LTL_WOKEN_BY_SOFTIRQ, mon->atoms);
+	bool woken_by_lower_prio =3D test_bit(LTL_WOKEN_BY_LOWER_PRIO, mon->atoms=
);
+	bool user_thread =3D test_bit(LTL_USER_THREAD, mon->atoms);
+	bool rt =3D test_bit(LTL_RT, mon->atoms);
+	bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
+	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
+	bool val9 =3D block_on_rt_mutex || futex_lock_pi;
+	bool val6 =3D !woken_by_softirq;
+	bool val5 =3D !woken_by_lower_prio;
+	bool val8 =3D val5 && val6;
+	bool val10 =3D val8 || val9;
+	bool val3 =3D !user_thread;
+	bool val2 =3D !rt;
+	bool val4 =3D val2 || val3;
+	bool val11 =3D val4 || val10;
+
+	switch (state) {
+	case S0:
+		if (val11)
+			__set_bit(S0, next);
+		break;
+	}
+}
diff --git a/kernel/trace/rv/monitors/wakeup/wakeup_trace.h b/kernel/trace/=
rv/monitors/wakeup/wakeup_trace.h
new file mode 100644
index 000000000000..7e056183f920
--- /dev/null
+++ b/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_WAKEUP
+DEFINE_EVENT(event_ltl_monitor_id, event_wakeup,
+	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *=
next),
+	     TP_ARGS(task, states, atoms, next));
+DEFINE_EVENT(error_ltl_monitor_id, error_wakeup,
+	     TP_PROTO(struct task_struct *task),
+	     TP_ARGS(task));
+#endif /* CONFIG_RV_MON_WAKEUP */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 9622c269789c..2f8a932432c9 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -241,6 +241,7 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 );
 #include <monitors/pagefault/pagefault_trace.h>
 #include <monitors/sleep/sleep_trace.h>
+#include <monitors/wakeup/wakeup_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
=20
diff --git a/tools/verification/models/rtapp/wakeup.ltl b/tools/verificatio=
n/models/rtapp/wakeup.ltl
new file mode 100644
index 000000000000..a5d63ca0811a
--- /dev/null
+++ b/tools/verification/models/rtapp/wakeup.ltl
@@ -0,0 +1,5 @@
+RULE =3D always (((RT and USER_THREAD) imply
+		(not (WOKEN_BY_LOWER_PRIO or WOKEN_BY_SOFTIRQ)) or ALLOWLIST))
+
+ALLOWLIST =3D BLOCK_ON_RT_MUTEX
+         or FUTEX_LOCK_PI
--=20
2.47.3

