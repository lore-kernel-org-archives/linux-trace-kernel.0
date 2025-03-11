Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA42620C8;
	Tue, 11 Mar 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712731; cv=none; b=CTKuXy/n5xesv0A4S+U8aF3089B7UErXD15wDaJbsH0TuHckn/67AN8S+Sn8Yl0NXGo+p/klQnYo4DUelZqS7r0yn+li7LPuxASMJ6IpVMILdCqt0/rUS8DzfXIQBfBrTeWTn/pso4nX9BfLQmLR/8x5lvjBbZga0X9Zzetn++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712731; c=relaxed/simple;
	bh=ONXYMfuYmUUAlwWR0vc5HAxUGUFVyrdYPxi3wCZYKeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=igea0RtLnbjFEZT10yJCGqSDoeIVqwml0aCoU4mc0Zzw3cZRXhkfA71M2ZLMc0ZzWGsOWW4dyZOGVB8AQHgkuZysZrlbXiZwUlx0/26U7xWS/3jiBtIjMtaF+STIEjAIkkBV1qkiZ2qu9z2c2FazH7RFEql6huyoMm5CLhNC5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sYGW4xw2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2D0NJRU9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sYGW4xw2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2D0NJRU9"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUsPp1jQTrqZ2jR4NIigEvKqpKp3maP3MQmc7gBjH+s=;
	b=sYGW4xw2xbNzSaYkGFBMfjQbbVtVs08FZeVwlObMVr1B6DiShw7LCOE7pgX9+nNhuZlDbD
	FjpL7M39ZBx6WkvbKEfUpaQFLGQtDG0AUzefHNOkx+N8tHpFdBeF9FJbckXFqUD/JIerVf
	8B8HlIidbugnowcpEkPp3J98uELo6gc/dW4KcwsFqKM6dmMhqOrp8Xj7LeTvlDky5mp8e/
	MbJmJsZrMmx503BrM52/N0JvSMM8jAy8VtwxaWRi4TDkQ4GHv9jLoiIpqm2wc7xZA/pVRb
	qNNM7RK6guPKUJMrmMdUQOCf7zIu8VFhWy81rI80HLurRyDoJDU8ChQSrw5GYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUsPp1jQTrqZ2jR4NIigEvKqpKp3maP3MQmc7gBjH+s=;
	b=2D0NJRU9d1s9rEwUOtOR1qPCRHKWnf/mD+ReTlfzkmV65RAwQHCc7xNMADASI+Te6Fg9w+
	4CnC+bm41Tv8jmAw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 04/10] rv: Add rtapp_block monitor
Date: Tue, 11 Mar 2025 18:05:05 +0100
Message-Id: <c8a1658c6da343b6055cbfcd6ee5ddea48335d31.1741708239.git.namcao@linutronix.de>
In-Reply-To: <cover.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add an RV monitor to detect realtime tasks getting blocked. For the full
description, see Documentation/trace/rv/monitor_rtapp_block.rst.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>
---
 .../trace/rv/monitor_rtapp_block.rst          |  34 +++
 include/trace/events/lock.h                   |  12 +
 kernel/locking/rtmutex.c                      |   4 +
 kernel/trace/rv/Kconfig                       |  12 +-
 kernel/trace/rv/Makefile                      |   2 +
 kernel/trace/rv/monitors/rtapp_block/ba.c     | 146 +++++++++++
 kernel/trace/rv/monitors/rtapp_block/ba.h     | 166 +++++++++++++
 kernel/trace/rv/monitors/rtapp_block/ltl      |   9 +
 .../rv/monitors/rtapp_block/rtapp_block.c     | 232 ++++++++++++++++++
 kernel/trace/rv/rv_trace.h                    |  44 ++++
 lib/Kconfig.debug                             |   3 +
 11 files changed, 663 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/trace/rv/monitor_rtapp_block.rst
 create mode 100644 kernel/trace/rv/monitors/rtapp_block/ba.c
 create mode 100644 kernel/trace/rv/monitors/rtapp_block/ba.h
 create mode 100644 kernel/trace/rv/monitors/rtapp_block/ltl
 create mode 100644 kernel/trace/rv/monitors/rtapp_block/rtapp_block.c

diff --git a/Documentation/trace/rv/monitor_rtapp_block.rst b/Documentation=
/trace/rv/monitor_rtapp_block.rst
new file mode 100644
index 000000000000..9cabbe66fa4a
--- /dev/null
+++ b/Documentation/trace/rv/monitor_rtapp_block.rst
@@ -0,0 +1,34 @@
+Monitor rtapp_block
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Name: rtapp_block - real time applications are undesirably blocked
+- Type: per-task linear temporal logic monitor
+- Author: Nam Cao <namcao@linutronix.de>
+
+Introduction
+------------
+
+Real time threads could be blocked and fail to finish their execution time=
ly. For instance, they
+need to access shared resources which are already acquired by other thread=
s. Or they could be
+waiting for non-realtime threads to signal them to proceed: as the non-rea=
ltime threads are not
+prioritized by the scheduler, the execution of realtime threads could be d=
elayed indefinitely.
+These scenarios are often unintentional, and cause unexpected latency to t=
he realtime application.
+
+The rtapp_block monitor reports this type of scenario, by monitoring for:
+
+  * Realtime threads going to sleep without explicitly asking for it (name=
ly, with nanosleep
+    syscall).
+  * Realtime threads are woken up by non-realtime threads.
+
+How to fix the monitor's warnings?
+----------------------------------
+
+There is no single answer, the solution needs to be evaluated depending on=
 the specific cases.
+
+If the realtime thread is blocked trying to take a `pthread_mutex_t` which=
 is already taken by a
+non-realtime thread, the solution could be enabling priority inheritance f=
or the mutex, so that the
+blocking non-realtime thread would be priority-boosted to run at realtime =
priority.
+
+If realtime thread needs to wait for non-realtime thread to signal it to p=
roceed, perhaps the design
+needs to be reconsidered to remove this dependency. Often, the work execut=
ed by the realtime thread
+needs not to be realtime at all.
diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 8e89baa3775f..d4b32194d47f 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -138,6 +138,18 @@ TRACE_EVENT(contention_end,
 	TP_printk("%p (ret=3D%d)", __entry->lock_addr, __entry->ret)
 );
=20
+#ifdef CONFIG_TRACE_RT_MUTEX_WAKE_WAITER
+DECLARE_TRACE(rt_mutex_wake_waiter_begin,
+		TP_PROTO(struct task_struct *task),
+		TP_ARGS(task))
+DECLARE_TRACE(rt_mutex_wake_waiter_end,
+		TP_PROTO(struct task_struct *task),
+		TP_ARGS(task))
+#else
+#define trace_rt_mutex_wake_waiter_begin(...)
+#define trace_rt_mutex_wake_waiter_end(...)
+#endif /* CONFIG_TRACE_RT_MUTEX */
+
 #endif /* _TRACE_LOCK_H */
=20
 /* This part must be outside protection */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a8df1800cbb..fc9cf4a2cf75 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -561,6 +561,8 @@ static __always_inline void rt_mutex_wake_q_add(struct =
rt_wake_q_head *wqh,
=20
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
+	trace_rt_mutex_wake_waiter_begin(current);
+
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
 		wake_up_state(wqh->rtlock_task, TASK_RTLOCK_WAIT);
 		put_task_struct(wqh->rtlock_task);
@@ -572,6 +574,8 @@ static __always_inline void rt_mutex_wake_up_q(struct r=
t_wake_q_head *wqh)
=20
 	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
 	preempt_enable();
+
+	trace_rt_mutex_wake_waiter_end(current);
 }
=20
 /*
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 8226352a0062..d65bf9bda2f2 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -13,7 +13,7 @@ config DA_MON_EVENTS_ID
=20
 menuconfig RV
 	bool "Runtime Verification"
-	depends on TRACING
+	select TRACING
 	help
 	  Enable the kernel runtime verification infrastructure. RV is a
 	  lightweight (yet rigorous) method that complements classical
@@ -29,6 +29,16 @@ source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 # Add new monitors here
=20
+config RV_MON_RTAPP_BLOCK
+	depends on RV
+	select DA_MON_EVENTS
+	select TRACE_IRQFLAGS
+	select TRACE_RT_MUTEX_WAKE_WAITER
+	bool "rtapp_block monitor"
+	help
+	  Enable rtapp_wakeup which monitors that realtime tasks are not blocked.
+	  For details, see Documentation/trace/rv/monitor_rtapp_block.rst.
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 188b64668e1f..6570a3116127 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -5,6 +5,8 @@ ccflags-y +=3D -I $(src)		# needed for trace events
 obj-$(CONFIG_RV) +=3D rv.o
 obj-$(CONFIG_RV_MON_WIP) +=3D monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) +=3D monitors/wwnr/wwnr.o
+obj-$(CONFIG_RV_MON_RTAPP_BLOCK) +=3D monitors/rtapp_block/ba.o \
+				    monitors/rtapp_block/rtapp_block.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
diff --git a/kernel/trace/rv/monitors/rtapp_block/ba.c b/kernel/trace/rv/mo=
nitors/rtapp_block/ba.c
new file mode 100644
index 000000000000..5e99f79d5e74
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp_block/ba.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is generated, do not edit.
+ */
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <trace/events/task.h>
+#include <trace/events/sched.h>
+
+#include "ba.h"
+
+static_assert(NUM_ATOM <=3D RV_MAX_LTL_ATOM);
+
+enum buchi_state {
+	INIT,
+	S3,
+	DEAD,
+};
+
+int rv_rtapp_block_task_slot =3D RV_PER_TASK_MONITOR_INIT;
+
+static void init_monitor(struct task_struct *task)
+{
+	struct ltl_monitor *mon =3D rv_rtapp_block_get_monitor(task);
+
+	for (int i =3D 0; i < NUM_ATOM; ++i)
+		mon->atoms[i] =3D LTL_UNDETERMINED;
+	mon->state =3D INIT;
+}
+
+static void handle_task_newtask(void *data, struct task_struct *task, unsi=
gned long flags)
+{
+	struct ltl_monitor *mon =3D rv_rtapp_block_get_monitor(task);
+
+	init_monitor(task);
+
+	rv_rtapp_block_atoms_init(task, mon);
+	rv_rtapp_block_atoms_fetch(task, mon);
+}
+
+int rv_rtapp_block_init(size_t data_size)
+{
+	struct task_struct *g, *p;
+	int ret, cpu;
+
+	if (WARN_ON(data_size > RV_MAX_DATA_SIZE))
+		return -EINVAL;
+
+	ret =3D rv_get_task_monitor_slot();
+	if (ret < 0)
+		return ret;
+
+	rv_rtapp_block_task_slot =3D ret;
+
+	rv_attach_trace_probe("rtapp_block", task_newtask, handle_task_newtask);
+
+	read_lock(&tasklist_lock);
+
+	for_each_process_thread(g, p)
+		init_monitor(p);
+
+	for_each_present_cpu(cpu)
+		init_monitor(idle_task(cpu));
+
+	read_unlock(&tasklist_lock);
+
+	return 0;
+}
+
+void rv_rtapp_block_destroy(void)
+{
+	rv_put_task_monitor_slot(rv_rtapp_block_task_slot);
+	rv_rtapp_block_task_slot =3D RV_PER_TASK_MONITOR_INIT;
+
+	rv_detach_trace_probe("rtapp_block", task_newtask, handle_task_newtask);
+}
+
+static void illegal_state(struct task_struct *task, struct ltl_monitor *mo=
n)
+{
+	mon->state =3D INIT;
+	rv_rtapp_block_error(task, mon);
+}
+
+static void rv_rtapp_block_attempt_start(struct task_struct *task, struct =
ltl_monitor *mon)
+{
+	int i;
+
+	mon =3D rv_rtapp_block_get_monitor(task);
+
+	rv_rtapp_block_atoms_fetch(task, mon);
+
+	for (i =3D 0; i < NUM_ATOM; ++i) {
+		if (mon->atoms[i] =3D=3D LTL_UNDETERMINED)
+			return;
+	}
+
+	if (((!mon->atoms[WAKEUP_RT_TASK] || (mon->atoms[RT] || (mon->atoms[RT_MU=
TEX_WAKING_WAITER]
+	   || (mon->atoms[STOPPING_WOKEN_TASK] || (mon->atoms[WOKEN_TASK_IS_MIGRA=
TION] ||
+	   mon->atoms[WOKEN_TASK_IS_RCU])))))) && (((!mon->atoms[USER_TASK] || !m=
on->atoms[RT]) ||
+	   (!mon->atoms[SLEEP] || (mon->atoms[DO_NANOSLEEP] || mon->atoms[FUTEX_L=
OCK_WITH_PI])))))
+		mon->state =3D S3;
+	else
+		illegal_state(task, mon);
+}
+
+static void rv_rtapp_block_step(struct task_struct *task, struct ltl_monit=
or *mon)
+{
+	switch (mon->state) {
+	case S3:
+		if (((!mon->atoms[WAKEUP_RT_TASK] || (mon->atoms[RT] ||
+		   (mon->atoms[RT_MUTEX_WAKING_WAITER] || (mon->atoms[STOPPING_WOKEN_TAS=
K] ||
+		   (mon->atoms[WOKEN_TASK_IS_MIGRATION] || mon->atoms[WOKEN_TASK_IS_RCU]=
)))))) &&
+		   (((!mon->atoms[USER_TASK] || !mon->atoms[RT]) || (!mon->atoms[SLEEP] =
||
+		   (mon->atoms[DO_NANOSLEEP] || mon->atoms[FUTEX_LOCK_WITH_PI])))))
+			mon->state =3D S3;
+		else
+			illegal_state(task, mon);
+		break;
+	case DEAD:
+	case INIT:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
+void rv_rtapp_block_atom_update(struct task_struct *task, unsigned int ato=
m, bool value)
+{
+	struct ltl_monitor *mon =3D rv_rtapp_block_get_monitor(task);
+
+	rv_rtapp_block_atom_set(mon, atom, value);
+
+	if (mon->state =3D=3D DEAD)
+		return;
+
+	if (mon->state =3D=3D INIT)
+		rv_rtapp_block_attempt_start(task, mon);
+	if (mon->state =3D=3D INIT)
+		return;
+
+	mon->atoms[atom] =3D value;
+
+	rv_rtapp_block_atoms_fetch(task, mon);
+
+	rv_rtapp_block_step(task, mon);
+}
diff --git a/kernel/trace/rv/monitors/rtapp_block/ba.h b/kernel/trace/rv/mo=
nitors/rtapp_block/ba.h
new file mode 100644
index 000000000000..c1ba88f6779a
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp_block/ba.h
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file is generated, do not edit.
+ *
+ * This file includes necessary functions to glue the Buchi automaton and =
the kernel together.
+ * Some of these functions must be manually implemented (look for "Must be=
 implemented", or just
+ * let the compiler tells you).
+ *
+ * Essentially, you need to manually define the meaning of the atomic prop=
ositions in the LTL
+ * property. The primary function for that is rv_rtapp_block_atom_update()=
, which can be called
+ * in tracepoints' handlers for example. In some specific cases where
+ * rv_rtapp_block_atom_update() is not convenient, rv_rtapp_block_atoms_fe=
tch() can be used.
+ *
+ * rv_rtapp_block_init()/rv_rtapp_block_destroy() must be called while ena=
bling/disabling
+ * the monitor.
+ *
+ * If the fields in struct ltl_monitor is not enough, extra custom data ca=
n be used. See
+ * rv_rtapp_block_get_data().
+ */
+
+#include <linux/sched.h>
+
+enum rtapp_block_atom {
+	DO_NANOSLEEP,
+	FUTEX_LOCK_WITH_PI,
+	RT,
+	RT_MUTEX_WAKING_WAITER,
+	SLEEP,
+	STOPPING_WOKEN_TASK,
+	USER_TASK,
+	WAKEUP_RT_TASK,
+	WOKEN_TASK_IS_MIGRATION,
+	WOKEN_TASK_IS_RCU,
+	NUM_ATOM
+};
+
+/**
+ * rv_rtapp_block_init
+ * @data_size:	required custom data size, can be zero
+ *
+ * Must be called while enabling the monitor
+ */
+int rv_rtapp_block_init(size_t data_size);
+
+/**
+ * rv_rtapp_block_destroy
+ *
+ * must be called while disabling the monitor
+ */
+void rv_rtapp_block_destroy(void);
+
+/**
+ * rv_rtapp_block_error - report violation of the LTL property
+ * @task:	the task violating the LTL property
+ * @mon:	the LTL monitor
+ *
+ * Must be implemented. This function should invoke the RV reactor and the=
 monitor's tracepoints.
+ */
+void rv_rtapp_block_error(struct task_struct *task, struct ltl_monitor *mo=
n);
+
+extern int rv_rtapp_block_task_slot;
+
+/**
+ * rv_rtapp_block_get_monitor - get the struct ltl_monitor of a task
+ */
+static inline struct ltl_monitor *rv_rtapp_block_get_monitor(struct task_s=
truct *task)
+{
+	return &task->rv[rv_rtapp_block_task_slot].ltl_mon;
+}
+
+/**
+ * rv_rtapp_block_atoms_init - initialize the atomic propositions
+ * @task:	the task
+ * @mon:	the LTL monitor
+ *
+ * Must be implemented. This function is called during task creation, and =
should initialize all
+ * atomic propositions. rv_rtapp_block_atom_set() should be used to implem=
ent this function.
+ *
+ * This function does not have to initialize atomic propositions that are =
updated by
+ * rv_rtapp_block_atoms_fetch(), because the two functions are called toge=
ther.
+ */
+void rv_rtapp_block_atoms_init(struct task_struct *task, struct ltl_monito=
r *mon);
+
+/**
+ * rv_rtapp_block_atoms_fetch - fetch the atomic propositions
+ * @task:	the task
+ * @mon:	the LTL monitor
+ *
+ * Must be implemented. This function is called anytime the Buchi automato=
n is triggered. Its
+ * intended purpose is to update the atomic propositions which are expensi=
ve to trace and can be
+ * easily read from @task. rv_rtapp_block_atom_set() should be used to imp=
lement this function.
+ *
+ * Using this function may cause incorrect verification result if it is im=
portant for the LTL that
+ * the atomic propositions must be updated at the correct time. Therefore,=
 if it is possible,
+ * updating atomic propositions should be done with rv_rtapp_block_atom_up=
date() instead.
+ *
+ * An example where this function is useful is with the LTL property:
+ *    always (RT imply not PAGEFAULT)
+ * (a realtime task does not raise page faults)
+ *
+ * In this example, adding tracepoints to track RT is complicated, because=
 it is changed in
+ * differrent places (mutex's priority boosting, sched_setscheduler). Furt=
hermore, for this LTL
+ * property, we don't care exactly when RT changes, as long as we have its=
 correct value when
+ * PAGEFAULT=3D=3Dtrue. Therefore, it is better to update RT in rv_rtapp_b=
lock_atoms_fetch(), as it
+ * can easily be retrieved from task_struct.
+ *
+ * This function can be empty.
+ */
+void rv_rtapp_block_atoms_fetch(struct task_struct *task, struct ltl_monit=
or *mon);
+
+/**
+ * rv_rtapp_block_atom_update - update an atomic proposition
+ * @task:	the task
+ * @atom:	the atomic proposition, one of enum rtapp_block_atom
+ * @value:	the new value for @atom
+ *
+ * Update an atomic proposition and trigger the Buchi atomaton to check fo=
r violation of the LTL
+ * property. This function can be called in tracepoints' handler, for exam=
ple.
+ */
+void rv_rtapp_block_atom_update(struct task_struct *task, unsigned int ato=
m, bool value);
+
+/**
+ * rv_rtapp_block_atom_get - get an atomic proposition
+ * @mon:	the monitor
+ * @atom:	the atomic proposition, one of enum rtapp_block_atom
+ *
+ * Returns the value of an atomic proposition.
+ */
+static inline
+enum ltl_truth_value rv_rtapp_block_atom_get(struct ltl_monitor *mon, unsi=
gned int atom)
+{
+	return mon->atoms[atom];
+}
+
+/**
+ * rv_rtapp_block_atom_set - set an atomic proposition
+ * @mon:	the monitor
+ * @atom:	the atomic proposition, one of enum rtapp_block_atom
+ * @value:	the new value for @atom
+ *
+ * Update an atomic proposition without triggering the Buchi automaton. Th=
is can be useful to
+ * implement rv_rtapp_block_atoms_fetch() and rv_rtapp_block_atoms_init().
+ *
+ * Another use case for this function is when multiple atomic propositions=
 change at the same time,
+ * because calling rv_rtapp_block_atom_update() (and thus triggering the B=
uchi automaton)
+ * multiple times may be incorrect. In that case, rv_rtapp_block_atom_set(=
) can be used to avoid
+ * triggering the Buchi automaton, and rv_rtapp_block_atom_update() is onl=
y used for the last
+ * atomic proposition.
+ */
+static inline
+void rv_rtapp_block_atom_set(struct ltl_monitor *mon, unsigned int atom, b=
ool value)
+{
+	mon->atoms[atom] =3D value;
+}
+
+/**
+ * rv_rtapp_block_get_data - get the custom data of this monitor.
+ * @mon: the monitor
+ *
+ * If this function is used, rv_rtapp_block_init() must have been called w=
ith a positive
+ * data_size.
+ */
+static inline void *rv_rtapp_block_get_data(struct ltl_monitor *mon)
+{
+	return &mon->data;
+}
diff --git a/kernel/trace/rv/monitors/rtapp_block/ltl b/kernel/trace/rv/mon=
itors/rtapp_block/ltl
new file mode 100644
index 000000000000..781f0144a222
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp_block/ltl
@@ -0,0 +1,9 @@
+RULE =3D always (WAKEUP_RT_TASK imply (RT or WAKEUP_WHITELIST))
+   and always ((USER_TASK and RT) imply (SLEEP imply INTENTIONAL_SLEEP))
+
+INTENTIONAL_SLEEP =3D DO_NANOSLEEP or FUTEX_LOCK_WITH_PI
+
+WAKEUP_WHITELIST =3D RT_MUTEX_WAKING_WAITER
+                or STOPPING_WOKEN_TASK
+                or WOKEN_TASK_IS_MIGRATION
+                or WOKEN_TASK_IS_RCU
diff --git a/kernel/trace/rv/monitors/rtapp_block/rtapp_block.c b/kernel/tr=
ace/rv/monitors/rtapp_block/rtapp_block.c
new file mode 100644
index 000000000000..3f5b1efb7af0
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched/rt.h>
+#include <linux/preempt.h>
+#include <linux/rv.h>
+
+#include <uapi/linux/futex.h>
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <trace/events/task.h>
+#include <trace/events/lock.h>
+#include <trace/events/preemptirq.h>
+
+#include <rv_trace.h>
+#include <rv/instrumentation.h>
+
+
+#include "ba.h"
+
+struct rtapp_block_data {
+	struct task_struct *woken_task;
+	struct task_struct *stopping_task;
+};
+
+static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
+{
+	unsigned long args[6];
+	int op, cmd;
+
+	switch (id) {
+	case __NR_nanosleep:
+	case __NR_clock_nanosleep:
+#ifdef __NR_clock_nanosleep_time64
+	case __NR_clock_nanosleep_time64:
+#endif
+		rv_rtapp_block_atom_update(current, DO_NANOSLEEP, true);
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
+		if (cmd =3D=3D FUTEX_LOCK_PI || cmd =3D=3D FUTEX_LOCK_PI2)
+			rv_rtapp_block_atom_update(current, FUTEX_LOCK_WITH_PI, true);
+		break;
+	}
+}
+
+static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
+{
+	struct ltl_monitor *mon =3D rv_rtapp_block_get_monitor(current);
+
+	rv_rtapp_block_atom_set(mon, FUTEX_LOCK_WITH_PI, false);
+	rv_rtapp_block_atom_update(current, DO_NANOSLEEP, false);
+}
+
+static void handle_sched_switch(void *data, bool preempt, struct task_stru=
ct *prev,
+				struct task_struct *next, unsigned int prev_state)
+{
+	if (prev_state & TASK_INTERRUPTIBLE)
+		rv_rtapp_block_atom_update(prev, SLEEP, true);
+	rv_rtapp_block_atom_update(next, SLEEP, false);
+}
+
+void rv_rtapp_block_atoms_fetch(struct task_struct *task, struct ltl_monit=
or *mon)
+{
+	rv_rtapp_block_atom_set(mon, RT, rt_task(task));
+	rv_rtapp_block_atom_set(mon, USER_TASK, !(task->flags & PF_KTHREAD));
+}
+
+void rv_rtapp_block_atoms_init(struct task_struct *task, struct ltl_monito=
r *mon)
+{
+	rv_rtapp_block_atom_set(mon, SLEEP, false);
+	rv_rtapp_block_atom_set(mon, DO_NANOSLEEP, false);
+	rv_rtapp_block_atom_set(mon, FUTEX_LOCK_PI, false);
+	rv_rtapp_block_atom_set(mon, WAKEUP_RT_TASK, false);
+	rv_rtapp_block_atom_set(mon, RT_MUTEX_WAKING_WAITER, false);
+	rv_rtapp_block_atom_set(mon, STOPPING_WOKEN_TASK, false);
+	rv_rtapp_block_atom_set(mon, WOKEN_TASK_IS_MIGRATION, false);
+	rv_rtapp_block_atom_set(mon, WOKEN_TASK_IS_RCU, false);
+}
+
+static void handle_rt_mutex_wake_waiter_begin(void *, struct task_struct *=
task)
+{
+	rv_rtapp_block_atom_update(task, RT_MUTEX_WAKING_WAITER, true);
+}
+
+static void handle_rt_mutex_wake_waiter_end(void *, struct task_struct *ta=
sk)
+{
+	rv_rtapp_block_atom_update(task, RT_MUTEX_WAKING_WAITER, false);
+}
+
+static void handle_sched_kthread_stop(void *, struct task_struct *task)
+{
+	struct ltl_monitor *mon =3D rv_rtapp_block_get_monitor(current);
+	struct rtapp_block_data *data =3D rv_rtapp_block_get_data(mon);
+
+	data->stopping_task =3D task;
+}
+
+static void handle_sched_kthread_stop_ret(void *, int)
+{
+	struct ltl_monitor *mon =3D rv_rtapp_block_get_monitor(current);
+	struct rtapp_block_data *data =3D rv_rtapp_block_get_data(mon);
+
+	data->stopping_task =3D NULL;
+}
+
+static void handle_sched_wakeup(void *, struct task_struct *task)
+{
+	struct ltl_monitor *mon =3D rv_rtapp_block_get_monitor(current);
+	struct rtapp_block_data *data =3D rv_rtapp_block_get_data(mon);
+
+	if (!in_task())
+		return;
+
+	if (this_cpu_read(hardirq_context))
+		return;
+
+	if (!rt_task(task))
+		return;
+
+	data->woken_task =3D task;
+
+	if (!strncmp(task->comm, "migration/", strlen("migration/")))
+		rv_rtapp_block_atom_set(mon, WOKEN_TASK_IS_MIGRATION, true);
+	if (!strcmp(task->comm, "rcu_preempt"))
+		rv_rtapp_block_atom_set(mon, WOKEN_TASK_IS_RCU, true);
+	if (data->stopping_task =3D=3D data->woken_task)
+		rv_rtapp_block_atom_set(mon, STOPPING_WOKEN_TASK, true);
+
+	rv_rtapp_block_atom_update(current, WAKEUP_RT_TASK, true);
+
+	rv_rtapp_block_atom_set(mon, WOKEN_TASK_IS_MIGRATION, false);
+	rv_rtapp_block_atom_set(mon, WOKEN_TASK_IS_RCU, false);
+	rv_rtapp_block_atom_set(mon, STOPPING_WOKEN_TASK, false);
+	rv_rtapp_block_atom_update(current, WAKEUP_RT_TASK, false);
+}
+
+static int enable_rtapp_block(void)
+{
+	int ret;
+
+	ret =3D rv_rtapp_block_init(sizeof(struct rtapp_block_data));
+
+	if (ret)
+		return ret;
+
+	rv_attach_trace_probe("rtapp_block", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("rtapp_block", rt_mutex_wake_waiter_begin,
+					     handle_rt_mutex_wake_waiter_begin);
+	rv_attach_trace_probe("rtapp_block", rt_mutex_wake_waiter_end,
+					     handle_rt_mutex_wake_waiter_end);
+	rv_attach_trace_probe("rtapp_block", sched_kthread_stop, handle_sched_kth=
read_stop);
+	rv_attach_trace_probe("rtapp_block", sched_kthread_stop_ret, handle_sched=
_kthread_stop_ret);
+	rv_attach_trace_probe("rtapp_block", sys_enter, handle_sys_enter);
+	rv_attach_trace_probe("rtapp_block", sys_exit, handle_sys_exit);
+	rv_attach_trace_probe("rtapp_block", sched_switch, handle_sched_switch);
+
+	return 0;
+}
+
+static void disable_rtapp_block(void)
+{
+	rv_detach_trace_probe("rtapp_block", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("rtapp_block", rt_mutex_wake_waiter_begin,
+					     handle_rt_mutex_wake_waiter_begin);
+	rv_detach_trace_probe("rtapp_block", rt_mutex_wake_waiter_end,
+					     handle_rt_mutex_wake_waiter_end);
+	rv_detach_trace_probe("rtapp_block", sched_kthread_stop, handle_sched_kth=
read_stop);
+	rv_detach_trace_probe("rtapp_block", sched_kthread_stop_ret, handle_sched=
_kthread_stop_ret);
+	rv_detach_trace_probe("rtapp_block", sys_enter, handle_sys_enter);
+	rv_detach_trace_probe("rtapp_block", sys_exit, handle_sys_exit);
+	rv_detach_trace_probe("rtapp_block", sched_switch, handle_sched_switch);
+
+	rv_rtapp_block_destroy();
+}
+
+static struct rv_monitor rv_rtapp_block =3D {
+	.name =3D "rtapp_block",
+	.description =3D "Monitor that RT tasks are not blocked by non-RT tasks",
+	.enable =3D enable_rtapp_block,
+	.disable =3D disable_rtapp_block,
+};
+
+void rv_rtapp_block_error(struct task_struct *task, struct ltl_monitor *mo=
n)
+{
+	struct rtapp_block_data *data =3D rv_rtapp_block_get_data(mon);
+	struct task_struct *woken =3D data->woken_task;
+
+	bool sleep =3D rv_rtapp_block_atom_get(mon, SLEEP);
+
+	if (sleep)
+		trace_rtapp_block_sleep_error(task);
+	else
+		trace_rtapp_block_wakeup_error(task, woken);
+
+#ifdef CONFIG_RV_REACTORS
+	if (!rv_rtapp_block.react)
+		return;
+
+	if (sleep) {
+		rv_rtapp_block.react("rv: %s[%d](RT) is blocked\n", task->comm, task->pi=
d);
+	} else {
+		rv_rtapp_block.react("rv: %s[%d](RT) was blocked %s[%d](non-RT)\n",
+					woken->comm, woken->pid,
+					task->comm, task->pid);
+	}
+#endif
+}
+
+static int __init register_rtapp_block(void)
+{
+	rv_register_monitor(&rv_rtapp_block);
+	return 0;
+}
+
+static void __exit unregister_rtapp_block(void)
+{
+	rv_unregister_monitor(&rv_rtapp_block);
+}
+
+module_init(register_rtapp_block);
+module_exit(unregister_rtapp_block);
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 96264233cac5..79a7388b5c55 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -121,6 +121,50 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
=20
 #endif /* CONFIG_DA_MON_EVENTS_ID */
+#ifdef CONFIG_RV_MON_RTAPP_BLOCK
+TRACE_EVENT(rtapp_block_wakeup_error,
+
+	TP_PROTO(struct task_struct *task, struct task_struct *woken),
+
+	TP_ARGS(task, woken),
+
+	TP_STRUCT__entry(
+		__string(comm, task->comm)
+		__string(woken_comm, woken->comm)
+		__field(pid_t, pid)
+		__field(pid_t, woken_pid)
+	),
+
+	TP_fast_assign(
+		__assign_str(comm);
+		__assign_str(woken_comm);
+		__entry->pid =3D task->pid;
+		__entry->woken_pid =3D woken->pid;
+	),
+
+	TP_printk("rv: %s[%d](RT) was blocked by %s[%d](non-RT)\n",
+			__get_str(woken_comm), __entry->woken_pid,
+			__get_str(comm), __entry->pid)
+);
+TRACE_EVENT(rtapp_block_sleep_error,
+
+	TP_PROTO(struct task_struct *task),
+
+	TP_ARGS(task),
+
+	TP_STRUCT__entry(
+		__string(comm, task->comm)
+		__field(pid_t, pid)
+	),
+
+	TP_fast_assign(
+		__assign_str(comm);
+		__entry->pid =3D task->pid;
+	),
+
+	TP_printk("rv: %s[%d](RT) is blocked\n", __get_str(comm), __entry->pid)
+);
+#endif
 #endif /* _TRACE_RV_H */
=20
 /* This part must be outside protection */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..942318ef3f62 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1638,6 +1638,9 @@ config TRACE_IRQFLAGS
 	  Enables hooks to interrupt enabling and disabling for
 	  either tracing or lock debugging.
=20
+config TRACE_RT_MUTEX_WAKE_WAITER
+	bool
+
 config TRACE_IRQFLAGS_NMI
 	def_bool y
 	depends on TRACE_IRQFLAGS
--=20
2.39.5

