Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385A31E842;
	Fri, 19 Jun 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853698; cv=none; b=UneILoPY6G4CBpFnouQ8szn3yujfiw5eaf17Y65JGDQWNKDXpb++/WGsC+HHYhVJulRahvKi1Yn06NRXH/tgSKeh3Vscs78fvVOg3ez1GeBZby2mVuHcUMhBZ6pQ22nkVd/DEyokH2MI1n0YCW+hfVEJY5Sl+EfuiDKrnu+cU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853698; c=relaxed/simple;
	bh=vYvsIYh0jgwIHZAa9UftUJfZVnqcyFYEK7WYPzpV2aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0k14xaknCbYDbd3WqozjW1qCBPoDnVj64QjFT0sSQBgvm4uSr9OeSj4MqEh6//F9PW9DGKosBlj6P2XFNvavXz1gDqsXFIdYeAovxF749cjInIxqhIMnGhAYzoFyQhVUK3vs0pIwbhg3zkzi3GZvEXufzTEdJJS/bX9PWVy5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j3/BLpcU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fxu1XEK9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j3/BLpcU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fxu1XEK9"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781853695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADRdJjgkp4tYKTvA6WOi9Vd8I8cnK4DKUwd1zj57fj8=;
	b=j3/BLpcU9JdIeaUAIEoqbR6U5SVSVeO6eBG547KvH/ebLckQcQTiAnTw5C6hddHemT6q8g
	IgtZuSFssVDg/CzvXoc5OqeGt6VkD4G+2me5L86OifFDTuj+CRYlUtgxCl9XpQB1djuyZ0
	BmTo9pbStIqiqTN8Li2uupj22PjmWoyI1915fZmwz/yNXyoBwFJLMOHNnNjme153xH1/Vu
	NZ27phX+a/tvJw6lfCgA/sm6H55iO+/kEB50s1hQh2ZCv1iOw2zV8WuBQeXbBu1ZsEnxO9
	HQC+ZxnusrA8fNEfmAoHe50mdfiKdPWQDMmqmU5qvFXkZownKNT2rlYUH6ez5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781853695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADRdJjgkp4tYKTvA6WOi9Vd8I8cnK4DKUwd1zj57fj8=;
	b=Fxu1XEK995YZ0XUR1B996wwuLoCjHTbQZDLsEASE69J55AkOx+qU2zYAZ/vZ1wPbS5aFF5
	iTXMakiZxZIU5hDA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/4] rv/rtapp/sleep: Stop monitoring kernel threads
Date: Fri, 19 Jun 2026 09:21:21 +0200
Message-ID: <eec2ca5224bcdacc45b8e1eb2f0e68109e1cae7a.1781852967.git.namcao@linutronix.de>
In-Reply-To: <cover.1781852967.git.namcao@linutronix.de>
References: <cover.1781852967.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The rtapp/sleep monitor's primary purpose is detecting common mistakes
with user-space real-time design. Monitoring real-time issues with
kernel threads is a bonus.

However, accomodating kernel threads complicates the monitor due to
the edge cases which is seen by the monitor as lower-priority task
waking higher-priority task:

  - kthread_stop() wakes up the task in order to stop it.

  - The rcu thread and migration thread can be woken by any task.

  - The ktimerd thread is woken near the end of irq_exit_rcu(), where
    the preempt counter is "broken" and falsely says this is task
    context. This requires the monitor to use the hardirq_context flag
    instead of the preempt counter.

Beside complicating the monitor, the final case also requires enabling
CONFIG_TRACE_IRQFLAGS (so that "hardirq_context" can be used). This
adds overhead to the kernel even when the monitor is not active. This
may be an obstacle to enabling this monitor in distros' kernels.

Furthermore, kernel threads usually are started before the monitor is
enabled. Consequently, the threads' states (i.o.w. the monitor's
atomic propositions for the threads) are not fully known to the
monitor. As a result, the kernel threads mostly cannot be monitored.

Overall, the downsides of accomodating kernel threads outweights the
benefits. Thus, exclude kernel threads to simplify the monitor.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/trace/rv/monitor_rtapp.rst  |  22 ++---
 kernel/trace/rv/monitors/sleep/Kconfig    |   1 -
 kernel/trace/rv/monitors/sleep/sleep.c    |  39 +-------
 kernel/trace/rv/monitors/sleep/sleep.h    | 104 +++++++++-------------
 tools/verification/models/rtapp/sleep.ltl |   7 +-
 5 files changed, 54 insertions(+), 119 deletions(-)

diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace=
/rv/monitor_rtapp.rst
index 570be67a8f3b..502d3ea412eb 100644
--- a/Documentation/trace/rv/monitor_rtapp.rst
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -93,9 +93,9 @@ assessment.
=20
 The monitor's specification is::
=20
-  RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
+  RULE =3D always ((RT and SLEEP and USER_THREAD) imply (RT_FRIENDLY_SLEEP=
 or ALLOWLIST))
=20
-  RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
+  RT_FRIENDLY_SLEEP =3D RT_VALID_SLEEP_REASON
                   and ((not SCHEDULE_IN) until RT_FRIENDLY_WAKE)
=20
   RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
@@ -110,23 +110,13 @@ The monitor's specification is::
                   or WOKEN_BY_HARDIRQ
                   or WOKEN_BY_NMI
                   or ABORT_SLEEP
-                  or KTHREAD_SHOULD_STOP
=20
   ALLOWLIST =3D BLOCK_ON_RT_MUTEX
            or FUTEX_LOCK_PI
-           or TASK_IS_RCU
-           or TASK_IS_MIGRATION
-
-Beside the scenarios described above, this specification also handle some
-special cases:
-
-  - `KERNEL_THREAD`: kernel tasks do not have any pattern that can be reco=
gnized
-    as valid real-time sleeping reasons. Therefore sleeping reason is not
-    checked for kernel tasks.
-  - `KTHREAD_SHOULD_STOP`: a non-real-time thread may stop a real-time ker=
nel
-    thread by waking it and waiting for it to exit (`kthread_stop()`). This
-    wakeup is safe for real-time.
-  - `ALLOWLIST`: to handle known false positives with the kernel.
+
+Beside the scenarios described above, this specification also defines an a=
llow list
+to handle some special cases:
+
   - `BLOCK_ON_RT_MUTEX` is included in the allowlist due to its implementa=
tion.
     In the release path of rt_mutex, a boosted task is de-boosted before w=
aking
     the rt_mutex's waiter. Consequently, the monitor may see a real-time-u=
nsafe
diff --git a/kernel/trace/rv/monitors/sleep/Kconfig b/kernel/trace/rv/monit=
ors/sleep/Kconfig
index 6b7a122e7b47..d6ec3e9a91b6 100644
--- a/kernel/trace/rv/monitors/sleep/Kconfig
+++ b/kernel/trace/rv/monitors/sleep/Kconfig
@@ -5,7 +5,6 @@ config RV_MON_SLEEP
 	select RV_LTL_MONITOR
 	depends on HAVE_SYSCALL_TRACEPOINTS
 	depends on RV_MON_RTAPP
-	select TRACE_IRQFLAGS
 	default y
 	select LTL_MON_EVENTS_ID
 	bool "sleep monitor"
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monit=
ors/sleep/sleep.c
index 638be7d8747f..aa5a984853b5 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -43,7 +43,6 @@ static void ltl_atoms_init(struct task_struct *task, stru=
ct ltl_monitor *mon, bo
 	ltl_atom_set(mon, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, false);
=20
 	if (task_creation) {
-		ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
 		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
 		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
 		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
@@ -53,33 +52,7 @@ static void ltl_atoms_init(struct task_struct *task, str=
uct ltl_monitor *mon, bo
 		ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
 	}
=20
-	if (task->flags & PF_KTHREAD) {
-		ltl_atom_set(mon, LTL_KERNEL_THREAD, true);
-
-		/* kernel tasks do not do syscall */
-		ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
-		ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
-		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
-		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
-		ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
-
-		if (strstarts(task->comm, "migration/"))
-			ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, true);
-		else
-			ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, false);
-
-		if (strstarts(task->comm, "rcu"))
-			ltl_atom_set(mon, LTL_TASK_IS_RCU, true);
-		else
-			ltl_atom_set(mon, LTL_TASK_IS_RCU, false);
-	} else {
-		ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
-		ltl_atom_set(mon, LTL_KERNEL_THREAD, false);
-		ltl_atom_set(mon, LTL_TASK_IS_RCU, false);
-		ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, false);
-	}
-
+	ltl_atom_set(mon, LTL_USER_THREAD, !(task->flags & PF_KTHREAD));
 }
=20
 static void handle_sched_set_state(void *data, struct task_struct *task, i=
nt state)
@@ -97,7 +70,7 @@ static void handle_sched_exit(void *data, bool is_switch)
=20
 static void handle_sched_waking(void *data, struct task_struct *task)
 {
-	if (this_cpu_read(hardirq_context)) {
+	if (in_hardirq()) {
 		ltl_atom_pulse(task, LTL_WOKEN_BY_HARDIRQ, true);
 	} else if (in_task()) {
 		if (current->prio <=3D task->prio)
@@ -181,12 +154,6 @@ static void handle_sys_exit(void *data, struct pt_regs=
 *regs, long ret)
 	ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
 }
=20
-static void handle_kthread_stop(void *data, struct task_struct *task)
-{
-	/* FIXME: this could race with other tracepoint handlers */
-	ltl_atom_update(task, LTL_KTHREAD_SHOULD_STOP, true);
-}
-
 static int enable_sleep(void)
 {
 	int retval;
@@ -200,7 +167,6 @@ static int enable_sleep(void)
 	rv_attach_trace_probe("rtapp_sleep", sched_set_state_tp, handle_sched_set=
_state);
 	rv_attach_trace_probe("rtapp_sleep", contention_begin, handle_contention_=
begin);
 	rv_attach_trace_probe("rtapp_sleep", contention_end, handle_contention_en=
d);
-	rv_attach_trace_probe("rtapp_sleep", sched_kthread_stop, handle_kthread_s=
top);
 	rv_attach_trace_probe("rtapp_sleep", sys_enter, handle_sys_enter);
 	rv_attach_trace_probe("rtapp_sleep", sys_exit, handle_sys_exit);
 	return 0;
@@ -213,7 +179,6 @@ static void disable_sleep(void)
 	rv_detach_trace_probe("rtapp_sleep", sched_set_state_tp, handle_sched_set=
_state);
 	rv_detach_trace_probe("rtapp_sleep", contention_begin, handle_contention_=
begin);
 	rv_detach_trace_probe("rtapp_sleep", contention_end, handle_contention_en=
d);
-	rv_detach_trace_probe("rtapp_sleep", sched_kthread_stop, handle_kthread_s=
top);
 	rv_detach_trace_probe("rtapp_sleep", sys_enter, handle_sys_enter);
 	rv_detach_trace_probe("rtapp_sleep", sys_exit, handle_sys_exit);
=20
diff --git a/kernel/trace/rv/monitors/sleep/sleep.h b/kernel/trace/rv/monit=
ors/sleep/sleep.h
index 2fe2ec7edae8..44e593f41e6a 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.h
+++ b/kernel/trace/rv/monitors/sleep/sleep.h
@@ -18,15 +18,12 @@ enum ltl_atom {
 	LTL_EPOLL_WAIT,
 	LTL_FUTEX_LOCK_PI,
 	LTL_FUTEX_WAIT,
-	LTL_KERNEL_THREAD,
-	LTL_KTHREAD_SHOULD_STOP,
 	LTL_NANOSLEEP_CLOCK_REALTIME,
 	LTL_NANOSLEEP_TIMER_ABSTIME,
 	LTL_RT,
 	LTL_SCHEDULE_IN,
 	LTL_SLEEP,
-	LTL_TASK_IS_MIGRATION,
-	LTL_TASK_IS_RCU,
+	LTL_USER_THREAD,
 	LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
 	LTL_WOKEN_BY_HARDIRQ,
 	LTL_WOKEN_BY_NMI,
@@ -43,15 +40,12 @@ static const char *ltl_atom_str(enum ltl_atom atom)
 		"ep_wa",
 		"fu_lo_pi",
 		"fu_wa",
-		"ker_th",
-		"kth_sh_st",
 		"na_cl_re",
 		"na_ti_ab",
 		"rt",
 		"sch_in",
 		"sle",
-		"ta_mi",
-		"ta_rc",
+		"us_th",
 		"wo_eq_hi_pr",
 		"wo_ha",
 		"wo_nm",
@@ -79,46 +73,41 @@ static void ltl_start(struct task_struct *task, struct =
ltl_monitor *mon)
 	bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
 	bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_BY_EQUAL_OR_HIG=
HER_PRIO,
 	     mon->atoms);
-	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
-	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
+	bool user_thread =3D test_bit(LTL_USER_THREAD, mon->atoms);
 	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
 	bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
 	bool rt =3D test_bit(LTL_RT, mon->atoms);
 	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
 	bool nanosleep_clock_realtime =3D test_bit(LTL_NANOSLEEP_CLOCK_REALTIME, =
mon->atoms);
-	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
-	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
 	bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
 	bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
 	bool epoll_wait =3D test_bit(LTL_EPOLL_WAIT, mon->atoms);
 	bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
 	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
 	bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
-	bool val41 =3D task_is_rcu || task_is_migration;
-	bool val42 =3D futex_lock_pi || val41;
-	bool val5 =3D block_on_rt_mutex || val42;
-	bool val33 =3D abort_sleep || kthread_should_stop;
-	bool val34 =3D woken_by_nmi || val33;
-	bool val35 =3D woken_by_hardirq || val34;
-	bool val14 =3D woken_by_equal_or_higher_prio || val35;
+	bool val7 =3D block_on_rt_mutex || futex_lock_pi;
+	bool val32 =3D woken_by_nmi || abort_sleep;
+	bool val33 =3D woken_by_hardirq || val32;
+	bool val14 =3D woken_by_equal_or_higher_prio || val33;
 	bool val13 =3D !schedule_in;
 	bool val25 =3D !nanosleep_clock_realtime;
 	bool val26 =3D nanosleep_timer_abstime && val25;
 	bool val18 =3D clock_nanosleep && val26;
 	bool val20 =3D val18 || epoll_wait;
-	bool val9 =3D futex_wait || val20;
-	bool val11 =3D val9 || kernel_thread;
+	bool val11 =3D futex_wait || val20;
+	bool val3 =3D !user_thread;
 	bool val2 =3D !sleep;
+	bool val4 =3D val2 || val3;
 	bool val1 =3D !rt;
-	bool val3 =3D val1 || val2;
+	bool val5 =3D val1 || val4;
=20
-	if (val3)
+	if (val5)
 		__set_bit(S0, mon->states);
 	if (val11 && val13)
 		__set_bit(S1, mon->states);
 	if (val11 && val14)
 		__set_bit(S4, mon->states);
-	if (val5)
+	if (val7)
 		__set_bit(S5, mon->states);
 }
=20
@@ -129,130 +118,125 @@ ltl_possible_next_states(struct ltl_monitor *mon, u=
nsigned int state, unsigned l
 	bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
 	bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_BY_EQUAL_OR_HIG=
HER_PRIO,
 	     mon->atoms);
-	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
-	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
+	bool user_thread =3D test_bit(LTL_USER_THREAD, mon->atoms);
 	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
 	bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
 	bool rt =3D test_bit(LTL_RT, mon->atoms);
 	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
 	bool nanosleep_clock_realtime =3D test_bit(LTL_NANOSLEEP_CLOCK_REALTIME, =
mon->atoms);
-	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
-	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
 	bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
 	bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
 	bool epoll_wait =3D test_bit(LTL_EPOLL_WAIT, mon->atoms);
 	bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
 	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
 	bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
-	bool val41 =3D task_is_rcu || task_is_migration;
-	bool val42 =3D futex_lock_pi || val41;
-	bool val5 =3D block_on_rt_mutex || val42;
-	bool val33 =3D abort_sleep || kthread_should_stop;
-	bool val34 =3D woken_by_nmi || val33;
-	bool val35 =3D woken_by_hardirq || val34;
-	bool val14 =3D woken_by_equal_or_higher_prio || val35;
+	bool val7 =3D block_on_rt_mutex || futex_lock_pi;
+	bool val32 =3D woken_by_nmi || abort_sleep;
+	bool val33 =3D woken_by_hardirq || val32;
+	bool val14 =3D woken_by_equal_or_higher_prio || val33;
 	bool val13 =3D !schedule_in;
 	bool val25 =3D !nanosleep_clock_realtime;
 	bool val26 =3D nanosleep_timer_abstime && val25;
 	bool val18 =3D clock_nanosleep && val26;
 	bool val20 =3D val18 || epoll_wait;
-	bool val9 =3D futex_wait || val20;
-	bool val11 =3D val9 || kernel_thread;
+	bool val11 =3D futex_wait || val20;
+	bool val3 =3D !user_thread;
 	bool val2 =3D !sleep;
+	bool val4 =3D val2 || val3;
 	bool val1 =3D !rt;
-	bool val3 =3D val1 || val2;
+	bool val5 =3D val1 || val4;
=20
 	switch (state) {
 	case S0:
-		if (val3)
+		if (val5)
 			__set_bit(S0, next);
 		if (val11 && val13)
 			__set_bit(S1, next);
 		if (val11 && val14)
 			__set_bit(S4, next);
-		if (val5)
+		if (val7)
 			__set_bit(S5, next);
 		break;
 	case S1:
 		if (val11 && val13)
 			__set_bit(S1, next);
-		if (val13 && val3)
+		if (val13 && val5)
 			__set_bit(S2, next);
-		if (val14 && val3)
+		if (val14 && val5)
 			__set_bit(S3, next);
 		if (val11 && val14)
 			__set_bit(S4, next);
-		if (val13 && val5)
+		if (val13 && val7)
 			__set_bit(S6, next);
-		if (val14 && val5)
+		if (val14 && val7)
 			__set_bit(S7, next);
 		break;
 	case S2:
 		if (val11 && val13)
 			__set_bit(S1, next);
-		if (val13 && val3)
+		if (val13 && val5)
 			__set_bit(S2, next);
-		if (val14 && val3)
+		if (val14 && val5)
 			__set_bit(S3, next);
 		if (val11 && val14)
 			__set_bit(S4, next);
-		if (val13 && val5)
+		if (val13 && val7)
 			__set_bit(S6, next);
-		if (val14 && val5)
+		if (val14 && val7)
 			__set_bit(S7, next);
 		break;
 	case S3:
-		if (val3)
+		if (val5)
 			__set_bit(S0, next);
 		if (val11 && val13)
 			__set_bit(S1, next);
 		if (val11 && val14)
 			__set_bit(S4, next);
-		if (val5)
+		if (val7)
 			__set_bit(S5, next);
 		break;
 	case S4:
-		if (val3)
+		if (val5)
 			__set_bit(S0, next);
 		if (val11 && val13)
 			__set_bit(S1, next);
 		if (val11 && val14)
 			__set_bit(S4, next);
-		if (val5)
+		if (val7)
 			__set_bit(S5, next);
 		break;
 	case S5:
-		if (val3)
+		if (val5)
 			__set_bit(S0, next);
 		if (val11 && val13)
 			__set_bit(S1, next);
 		if (val11 && val14)
 			__set_bit(S4, next);
-		if (val5)
+		if (val7)
 			__set_bit(S5, next);
 		break;
 	case S6:
 		if (val11 && val13)
 			__set_bit(S1, next);
-		if (val13 && val3)
+		if (val13 && val5)
 			__set_bit(S2, next);
-		if (val14 && val3)
+		if (val14 && val5)
 			__set_bit(S3, next);
 		if (val11 && val14)
 			__set_bit(S4, next);
-		if (val13 && val5)
+		if (val13 && val7)
 			__set_bit(S6, next);
-		if (val14 && val5)
+		if (val14 && val7)
 			__set_bit(S7, next);
 		break;
 	case S7:
-		if (val3)
+		if (val5)
 			__set_bit(S0, next);
 		if (val11 && val13)
 			__set_bit(S1, next);
 		if (val11 && val14)
 			__set_bit(S4, next);
-		if (val5)
+		if (val7)
 			__set_bit(S5, next);
 		break;
 	}
diff --git a/tools/verification/models/rtapp/sleep.ltl b/tools/verification=
/models/rtapp/sleep.ltl
index 5923e58d7810..4d78fdd204c0 100644
--- a/tools/verification/models/rtapp/sleep.ltl
+++ b/tools/verification/models/rtapp/sleep.ltl
@@ -1,6 +1,6 @@
-RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
+RULE =3D always ((RT and SLEEP and USER_THREAD) imply (RT_FRIENDLY_SLEEP o=
r ALLOWLIST))
=20
-RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
+RT_FRIENDLY_SLEEP =3D RT_VALID_SLEEP_REASON
                 and ((not SCHEDULE_IN) until RT_FRIENDLY_WAKE)
=20
 RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
@@ -15,9 +15,6 @@ RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
                 or WOKEN_BY_HARDIRQ
                 or WOKEN_BY_NMI
                 or ABORT_SLEEP
-                or KTHREAD_SHOULD_STOP
=20
 ALLOWLIST =3D BLOCK_ON_RT_MUTEX
          or FUTEX_LOCK_PI
-         or TASK_IS_RCU
-         or TASK_IS_MIGRATION
--=20
2.47.3

