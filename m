Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634E2676D1;
	Wed, 23 Apr 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391052; cv=none; b=B4oBiyZQmncQvSZ/9PfsPXxrP3ylKnhqSM53K2MnvRy1dYczTlqyKriz3XVGxgWOtFvS+u9RncPrkWQpQwUZQpvfsWtAtvhhZSAApdE8p8sOSOJmX/lcp5fc8sqTXtgGW7EVeGLllhWB3wXQrVih35C1Hmqq6iQSfsk+OdLBff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391052; c=relaxed/simple;
	bh=lIM9H77EQ+qEdOB6se/DozpSBna42RGNceUFRO1sKtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJIC66kI54KkjIPgZvS0yKbTI2Hh3FOMYtQXH7QrOyLxDdA2yoEGLwLqjgs7z2v4HExCZ3KHCxt2oA2aCCowXy2BrVHhmt0IhQhdozLI1i/XJVbMAAPGL5YvDQtrokWIpzhpoL2KyJuD6UXExKOaMsGAmdfvBW2in+wnxP5JVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xi8+VOdB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pCp8Wca2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xi8+VOdB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pCp8Wca2"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745391041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Llutf32SmyZ1q/a4+U4wdgR0MbgYXep3gUPR1k5eGQ=;
	b=xi8+VOdBIYesPV4kLpyoRPrjXqyrZteSoohjS6HK3ESPZykpqVs92d7vHROMUqh+9k+OjP
	6kyTojgZn/oJvf9bcbF3m34pfOnVkEQ7nR6zT8v0zJ7Lu38GMmm2kG3952btSw3mOhOX9o
	YWQylCPXDAXwoBWKigcUVx2B3iwtyobA2GVbcLNtZmj/7cppGsgjbN1Eymua22LTjrOsCj
	nCXl9kNp5vR9I+DM0nyu3yl5xnfJkLGZaGeEA2qFzoI1yFg24Y7BgDDO1cXF1QJsrJMu2Q
	vGETLPomG2y5hjnWfQUG6dC+MZHhYbZ6n0qwT7qZZRoNw6FHPR0+o1CvV+frfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745391041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Llutf32SmyZ1q/a4+U4wdgR0MbgYXep3gUPR1k5eGQ=;
	b=pCp8Wca2n7IfpgNF72KYRHhSlhKn5PzMMWRA8lRgZBK1lKO5ucFwYbeD7DXHjWgZz8W7QD
	Ggua7eZcj63IcrBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 20/22] rv: Add rtapp_sleep monitor
Date: Wed, 23 Apr 2025 08:50:15 +0200
Message-Id: <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de>
In-Reply-To: <cover.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a monitor for checking that real-time tasks do not go to sleep in a
manner that may cause undesirable latency.

Also change
	RV depends on TRACING
to
	RV select TRACING
to avoid the following recursive dependency:

 error: recursive dependency detected!
	symbol TRACING is selected by PREEMPTIRQ_TRACEPOINTS
	symbol PREEMPTIRQ_TRACEPOINTS depends on TRACE_IRQFLAGS
	symbol TRACE_IRQFLAGS is selected by RV_MON_SLEEP
	symbol RV_MON_SLEEP depends on RV
	symbol RV depends on TRACING

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/Kconfig                      |   3 +-
 kernel/trace/rv/Makefile                     |   1 +
 kernel/trace/rv/monitors/sleep/Kconfig       |  13 +
 kernel/trace/rv/monitors/sleep/sleep.c       | 201 +++++++++++++
 kernel/trace/rv/monitors/sleep/sleep.h       | 287 +++++++++++++++++++
 kernel/trace/rv/monitors/sleep/sleep_trace.h |  14 +
 kernel/trace/rv/rv_trace.h                   |   1 +
 tools/verification/models/rtapp/sleep.ltl    |  15 +
 8 files changed, 534 insertions(+), 1 deletion(-)
 create mode 100644 kernel/trace/rv/monitors/sleep/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.c
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.h
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_trace.h
 create mode 100644 tools/verification/models/rtapp/sleep.ltl

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6f86d8501e87..942d57575e67 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -20,7 +20,7 @@ config RV_LTL_MONITOR
=20
 menuconfig RV
 	bool "Runtime Verification"
-	depends on TRACING
+	select TRACING
 	help
 	  Enable the kernel runtime verification infrastructure. RV is a
 	  lightweight (yet rigorous) method that complements classical
@@ -43,6 +43,7 @@ source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
 source "kernel/trace/rv/monitors/pagefault/Kconfig"
+source "kernel/trace/rv/monitors/sleep/Kconfig"
 # Add new monitors here
=20
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 353ecf939d0e..13ec2944c665 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_RV_MON_SNEP) +=3D monitors/snep/snep.o
 obj-$(CONFIG_RV_MON_SNCID) +=3D monitors/sncid/sncid.o
 obj-$(CONFIG_RV_MON_RTAPP) +=3D monitors/rtapp/rtapp.o
 obj-$(CONFIG_RV_MON_PAGEFAULT) +=3D monitors/pagefault/pagefault.o
+obj-$(CONFIG_RV_MON_SLEEP) +=3D monitors/sleep/sleep.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
diff --git a/kernel/trace/rv/monitors/sleep/Kconfig b/kernel/trace/rv/monit=
ors/sleep/Kconfig
new file mode 100644
index 000000000000..d00aa1aae069
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SLEEP
+	depends on RV
+	select RV_LTL_MONITOR
+	depends on HAVE_SYSCALL_TRACEPOINTS
+	depends on RV_MON_RTAPP
+	select TRACE_IRQFLAGS
+	default y
+	select LTL_MON_EVENTS_ID
+	bool "sleep monitor"
+	help
+	  Monitor that real-time tasks do not sleep in a manner that may cause un=
desirable latency.
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monit=
ors/sleep/sleep.c
new file mode 100644
index 000000000000..8907606a3a05
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rv.h>
+#include <linux/sched/deadline.h>
+#include <linux/sched/rt.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "sleep"
+
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <trace/events/lock.h>
+#include <uapi/linux/futex.h>
+#include <rv_trace.h>
+#include <monitors/rtapp/rtapp.h>
+
+#include "sleep.h"
+#include <rv/ltl_monitor.h>
+
+static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *=
mon)
+{
+	ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
+}
+
+static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *m=
on, bool task_creation)
+{
+	/* event-like atomic propositions */
+	ltl_atom_set(mon, LTL_SLEEP, false);
+	ltl_atom_set(mon, LTL_WAKE, false);
+	ltl_atom_set(mon, LTL_WOKEN_BY_HARDIRQ, false);
+	ltl_atom_set(mon, LTL_WOKEN_BY_NMI, false);
+	ltl_atom_set(mon, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, false);
+
+	if (task_creation) {
+		ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP, false);
+		ltl_atom_set(mon, LTL_PI_FUTEX, false);
+		ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
+	}
+
+	if (task->flags & PF_KTHREAD) {
+		ltl_atom_set(mon, LTL_KERNEL_THREAD, true);
+
+		/* kernel tasks do not do syscall */
+		ltl_atom_set(mon, LTL_PI_FUTEX, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP, false);
+
+		if (strstarts(task->comm, "migration/"))
+			ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, true);
+		else
+			ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, false);
+
+		if (strstarts(task->comm, "rcu"))
+			ltl_atom_set(mon, LTL_TASK_IS_RCU, true);
+		else
+			ltl_atom_set(mon, LTL_TASK_IS_RCU, false);
+	} else {
+		ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
+		ltl_atom_set(mon, LTL_KERNEL_THREAD, false);
+		ltl_atom_set(mon, LTL_TASK_IS_RCU, false);
+		ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, false);
+	}
+
+}
+
+static void handle_sched_switch(void *data, bool preempt, struct task_stru=
ct *prev,
+				struct task_struct *next, unsigned int prev_state)
+{
+	struct ltl_monitor *mon =3D ltl_get_monitor(next);
+
+	if (prev_state & TASK_INTERRUPTIBLE)
+		ltl_atom_pulse(prev, LTL_SLEEP, true);
+	ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
+	ltl_atom_pulse(next, LTL_WAKE, true);
+}
+
+static void handle_sched_waking(void *data, struct task_struct *task)
+{
+	if (this_cpu_read(hardirq_context)) {
+		ltl_atom_pulse(task, LTL_WOKEN_BY_HARDIRQ, true);
+	} else if (in_task()) {
+		if (current->prio <=3D task->prio)
+			ltl_atom_pulse(task, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, true);
+	} else if (in_nmi()) {
+		ltl_atom_pulse(task, LTL_WOKEN_BY_NMI, true);
+	}
+}
+
+static void handle_sched_pi_setprio(void *data, struct task_struct *task,
+				    struct task_struct *pi_task)
+{
+	if (pi_task)
+		ltl_atom_update(pi_task, LTL_BLOCK_ON_RT_MUTEX, true);
+}
+
+static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
+{
+	struct ltl_monitor *mon;
+	unsigned long args[6];
+	int op, cmd;
+
+	mon =3D ltl_get_monitor(current);
+
+	switch (id) {
+	case __NR_nanosleep:
+	case __NR_clock_nanosleep:
+#ifdef __NR_clock_nanosleep_time64
+	case __NR_clock_nanosleep_time64:
+#endif
+		ltl_atom_update(current, LTL_NANOSLEEP, true);
+		break;
+
+	case __NR_futex:
+#ifdef __NR_futex_time64
+	case __NR_futex_time64:
+#endif
+		syscall_get_arguments(current, regs, args);
+		op =3D args[1];
+		cmd =3D op & FUTEX_CMD_MASK;
+
+		switch (cmd) {
+		case FUTEX_LOCK_PI:
+		case FUTEX_LOCK_PI2:
+		case FUTEX_WAIT_REQUEUE_PI:
+			ltl_atom_update(current, LTL_PI_FUTEX, true);
+		}
+		break;
+	}
+}
+
+static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
+{
+	struct ltl_monitor *mon =3D ltl_get_monitor(current);
+
+	ltl_atom_set(mon, LTL_PI_FUTEX, false);
+	ltl_atom_update(current, LTL_NANOSLEEP, false);
+}
+
+static void handle_kthread_stop(void *data, struct task_struct *task)
+{
+	/* FIXME: this could race with other tracepoint handlers */
+	ltl_atom_update(task, LTL_KTHREAD_SHOULD_STOP, true);
+}
+
+static int enable_sleep(void)
+{
+	int retval;
+
+	retval =3D ltl_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("rtapp_sleep", sched_waking, handle_sched_waking);
+	rv_attach_trace_probe("rtapp_sleep", sched_pi_setprio, handle_sched_pi_se=
tprio);
+	rv_attach_trace_probe("rtapp_sleep", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("rtapp_sleep", sys_enter, handle_sys_enter);
+	rv_attach_trace_probe("rtapp_sleep", sys_exit, handle_sys_exit);
+	rv_attach_trace_probe("rtapp_sleep", sched_kthread_stop, handle_kthread_s=
top);
+	return 0;
+}
+
+static void disable_sleep(void)
+{
+	rv_detach_trace_probe("rtapp_sleep", sched_waking, handle_sched_waking);
+	rv_detach_trace_probe("rtapp_sleep", sched_pi_setprio, handle_sched_pi_se=
tprio);
+	rv_detach_trace_probe("rtapp_sleep", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("rtapp_sleep", sys_enter, handle_sys_enter);
+	rv_detach_trace_probe("rtapp_sleep", sys_exit, handle_sys_exit);
+	rv_detach_trace_probe("rtapp_sleep", sched_kthread_stop, handle_kthread_s=
top);
+
+	ltl_monitor_destroy();
+}
+
+static struct rv_monitor rv_sleep =3D {
+	.name =3D "sleep",
+	.description =3D "Monitor that RT tasks do not undesirably sleep",
+	.enable =3D enable_sleep,
+	.disable =3D disable_sleep,
+};
+
+static int __init register_sleep(void)
+{
+	return rv_register_monitor(&rv_sleep, &rv_rtapp);
+}
+
+static void __exit unregister_sleep(void)
+{
+	rv_unregister_monitor(&rv_sleep);
+}
+
+module_init(register_sleep);
+module_exit(unregister_sleep);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
+MODULE_DESCRIPTION("sleep: Monitor that RT tasks do not undesirably sleep"=
);
diff --git a/kernel/trace/rv/monitors/sleep/sleep.h b/kernel/trace/rv/monit=
ors/sleep/sleep.h
new file mode 100644
index 000000000000..3d2283644c9b
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/sleep.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/rv.h>
+
+#define MONITOR_NAME sleep
+
+enum ltl_atom {
+	LTL_BLOCK_ON_RT_MUTEX,
+	LTL_KERNEL_THREAD,
+	LTL_KTHREAD_SHOULD_STOP,
+	LTL_NANOSLEEP,
+	LTL_PI_FUTEX,
+	LTL_RT,
+	LTL_SLEEP,
+	LTL_TASK_IS_MIGRATION,
+	LTL_TASK_IS_RCU,
+	LTL_WAKE,
+	LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
+	LTL_WOKEN_BY_HARDIRQ,
+	LTL_WOKEN_BY_NMI,
+	LTL_NUM_ATOM
+};
+static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);
+
+static const char *ltl_atom_str(enum ltl_atom atom)
+{
+	static const char *const names[] =3D {
+		"bl_on_rt_mu",
+		"ker_th",
+		"kth_sh_st",
+		"na",
+		"pi_fu",
+		"rt",
+		"sl",
+		"ta_mi",
+		"ta_rc",
+		"wak",
+		"wo_eq_hi_pr",
+		"wo_ha",
+		"wo_nm",
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
+	S5,
+	S6,
+	S7,
+	S8,
+	S9,
+	S10,
+	RV_NUM_BA_STATES
+};
+static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
+
+static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
+{
+	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
+	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
+	bool val30 =3D task_is_rcu || task_is_migration;
+	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
+	bool val4 =3D block_on_rt_mutex || val30;
+	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
+	bool woken_by_nmi =3D test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
+	bool val24 =3D woken_by_nmi || kthread_should_stop;
+	bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
+	bool val25 =3D woken_by_hardirq || val24;
+	bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_BY_EQUAL_OR_HIG=
HER_PRIO,
+	     mon->atoms);
+	bool val14 =3D woken_by_equal_or_higher_prio || val25;
+	bool wake =3D test_bit(LTL_WAKE, mon->atoms);
+	bool val13 =3D !wake;
+	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
+	bool nanosleep =3D test_bit(LTL_NANOSLEEP, mon->atoms);
+	bool pi_futex =3D test_bit(LTL_PI_FUTEX, mon->atoms);
+	bool val9 =3D pi_futex || nanosleep;
+	bool val11 =3D val9 || kernel_thread;
+	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
+	bool val2 =3D !sleep;
+	bool rt =3D test_bit(LTL_RT, mon->atoms);
+	bool val1 =3D !rt;
+
+	if (val1)
+		__set_bit(S0, mon->states);
+	if (val2)
+		__set_bit(S1, mon->states);
+	if (val11 && val13)
+		__set_bit(S2, mon->states);
+	if (val11 && val14)
+		__set_bit(S7, mon->states);
+	if (val4)
+		__set_bit(S8, mon->states);
+}
+
+static void
+ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsi=
gned long *next)
+{
+	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
+	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
+	bool val30 =3D task_is_rcu || task_is_migration;
+	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
+	bool val4 =3D block_on_rt_mutex || val30;
+	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
+	bool woken_by_nmi =3D test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
+	bool val24 =3D woken_by_nmi || kthread_should_stop;
+	bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
+	bool val25 =3D woken_by_hardirq || val24;
+	bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_BY_EQUAL_OR_HIG=
HER_PRIO,
+	     mon->atoms);
+	bool val14 =3D woken_by_equal_or_higher_prio || val25;
+	bool wake =3D test_bit(LTL_WAKE, mon->atoms);
+	bool val13 =3D !wake;
+	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
+	bool nanosleep =3D test_bit(LTL_NANOSLEEP, mon->atoms);
+	bool pi_futex =3D test_bit(LTL_PI_FUTEX, mon->atoms);
+	bool val9 =3D pi_futex || nanosleep;
+	bool val11 =3D val9 || kernel_thread;
+	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
+	bool val2 =3D !sleep;
+	bool rt =3D test_bit(LTL_RT, mon->atoms);
+	bool val1 =3D !rt;
+
+	switch (state) {
+	case S0:
+		if (val1)
+			__set_bit(S0, next);
+		if (val2)
+			__set_bit(S1, next);
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val4)
+			__set_bit(S8, next);
+		break;
+	case S1:
+		if (val1)
+			__set_bit(S0, next);
+		if (val2)
+			__set_bit(S1, next);
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val4)
+			__set_bit(S8, next);
+		break;
+	case S2:
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val1 && val13)
+			__set_bit(S3, next);
+		if (val13 && val2)
+			__set_bit(S4, next);
+		if (val13 && val4)
+			__set_bit(S5, next);
+		if (val1 && val14)
+			__set_bit(S6, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val14 && val2)
+			__set_bit(S9, next);
+		if (val14 && val4)
+			__set_bit(S10, next);
+		break;
+	case S3:
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val1 && val13)
+			__set_bit(S3, next);
+		if (val13 && val2)
+			__set_bit(S4, next);
+		if (val13 && val4)
+			__set_bit(S5, next);
+		if (val1 && val14)
+			__set_bit(S6, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val14 && val2)
+			__set_bit(S9, next);
+		if (val14 && val4)
+			__set_bit(S10, next);
+		break;
+	case S4:
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val1 && val13)
+			__set_bit(S3, next);
+		if (val13 && val2)
+			__set_bit(S4, next);
+		if (val13 && val4)
+			__set_bit(S5, next);
+		if (val1 && val14)
+			__set_bit(S6, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val14 && val2)
+			__set_bit(S9, next);
+		if (val14 && val4)
+			__set_bit(S10, next);
+		break;
+	case S5:
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val1 && val13)
+			__set_bit(S3, next);
+		if (val13 && val2)
+			__set_bit(S4, next);
+		if (val13 && val4)
+			__set_bit(S5, next);
+		if (val1 && val14)
+			__set_bit(S6, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val14 && val2)
+			__set_bit(S9, next);
+		if (val14 && val4)
+			__set_bit(S10, next);
+		break;
+	case S6:
+		if (val1)
+			__set_bit(S0, next);
+		if (val2)
+			__set_bit(S1, next);
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val4)
+			__set_bit(S8, next);
+		break;
+	case S7:
+		if (val1)
+			__set_bit(S0, next);
+		if (val2)
+			__set_bit(S1, next);
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val4)
+			__set_bit(S8, next);
+		break;
+	case S8:
+		if (val1)
+			__set_bit(S0, next);
+		if (val2)
+			__set_bit(S1, next);
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val4)
+			__set_bit(S8, next);
+		break;
+	case S9:
+		if (val1)
+			__set_bit(S0, next);
+		if (val2)
+			__set_bit(S1, next);
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val4)
+			__set_bit(S8, next);
+		break;
+	case S10:
+		if (val1)
+			__set_bit(S0, next);
+		if (val2)
+			__set_bit(S1, next);
+		if (val11 && val13)
+			__set_bit(S2, next);
+		if (val11 && val14)
+			__set_bit(S7, next);
+		if (val4)
+			__set_bit(S8, next);
+		break;
+	}
+}
diff --git a/kernel/trace/rv/monitors/sleep/sleep_trace.h b/kernel/trace/rv=
/monitors/sleep/sleep_trace.h
new file mode 100644
index 000000000000..22eaf31da987
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/sleep_trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SLEEP
+DEFINE_EVENT(event_ltl_monitor_id, event_sleep,
+	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *=
next),
+	     TP_ARGS(task, states, atoms, next));
+DEFINE_EVENT(error_ltl_monitor_id, error_sleep,
+	     TP_PROTO(struct task_struct *task),
+	     TP_ARGS(task));
+#endif /* CONFIG_RV_MON_SLEEP */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 02c906c9745b..283d5c2fd055 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -173,6 +173,7 @@ TRACE_EVENT(error_ltl_monitor_id,
 	TP_printk("%s[%d]: violation detected", __get_str(comm), __entry->pid)
 );
 #include <monitors/pagefault/pagefault_trace.h>
+#include <monitors/sleep/sleep_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
diff --git a/tools/verification/models/rtapp/sleep.ltl b/tools/verification=
/models/rtapp/sleep.ltl
new file mode 100644
index 000000000000..416ace2da0f2
--- /dev/null
+++ b/tools/verification/models/rtapp/sleep.ltl
@@ -0,0 +1,15 @@
+RULE =3D always (RT imply (SLEEP imply (RT_FRIENDLY_SLEEP or ALLOWLIST)))
+
+RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
+                and ((not WAKE) until RT_FRIENDLY_WAKE)
+
+RT_VALID_SLEEP_REASON =3D PI_FUTEX or NANOSLEEP
+
+RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
+                or WOKEN_BY_HARDIRQ
+                or WOKEN_BY_NMI
+                or KTHREAD_SHOULD_STOP
+
+ALLOWLIST =3D BLOCK_ON_RT_MUTEX
+         or TASK_IS_RCU
+         or TASK_IS_MIGRATION
--=20
2.39.5

