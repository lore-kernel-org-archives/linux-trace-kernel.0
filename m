Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C903148D8;
	Fri, 19 Jun 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853697; cv=none; b=dDUmlddHWndxa+oZ5MAHInb+8ZblEDT+spz8HIs9Umb9Ic++rTfqJroDvCccrw59TKTBhUPP6eb+ajeHBKCkn9z7XEHKQi0s6sFM/6v2RztpuqbQilQzAQQyK6ZQiQiGrjdf7ufD6DDF9D+PcoMw1Il3TXlzSytRpyMpCX4eRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853697; c=relaxed/simple;
	bh=WlZciGztyn7iJ3KWHQkC22hIX/4E5CKHMLHh4y45ml0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYtLffoblaH+lmz41IiDOk9dXe4WJM2/Ag1Y0sHDXdsLt47uvK0665cECaAnbAGXL1qY8/g5EMVJMqdO9Yacaz5PkIZ93a/WMmYrQYLni+GG/AHkXmL/byM8dFKE/SMCWwUI8sWaRmIVmGQwGxCh/m0SIHwtjYUP5Zjans6WsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+fRrc/X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=88SM+BWs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+fRrc/X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="88SM+BWs"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781853694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxS0tlHNIDugIE7RkjmyrQO8m+UvOGwxp0A8eUP2Z4Q=;
	b=g+fRrc/X9S7JUWXC0n3L/QOudcEUaS3S004MRJm7nPfmwQhYT5RWEC/z0nFUq4b4+T/UIX
	hD/AIaG0JrAOw2I1fV7jlEduMHzsRUujel0T5poS+9njLwGi2HWvRzRZam203Zh319xct9
	Dbhi2s9jfimN/xB5kn87YNwhanqcMjhGxwtqiUhXVDULDmb28HXFRJyWLJvCh2On4r/h/0
	fu6GvhZj2S7T0zaxE9BIlHqt7puku+m4qyQTODQ69v12m8CAzLgSVoU2M9CB/TEmPVmJYy
	Msf8+wDLgZbaGjHoxdpv53IHZRvLBw2nJ3m4JyO76uuyfT4v8O5Hn39bquRwLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781853694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxS0tlHNIDugIE7RkjmyrQO8m+UvOGwxp0A8eUP2Z4Q=;
	b=88SM+BWsaEJorK7Uq1AlQBGf8cL8XhcatD3q1u3tmjjNRbURM8pkg1LGC8BpQmgVK1tkUf
	lB/saZwXJ9klnQAA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 2/4] rv/rtapp/sleep: Update nanosleep rule
Date: Fri, 19 Jun 2026 09:21:20 +0200
Message-ID: <c7ceb5c6263ee8f43a2676acae669cf486b0d903.1781852967.git.namcao@linutronix.de>
In-Reply-To: <cover.1781852967.git.namcao@linutronix.de>
References: <cover.1781852967.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CLOCK_REALTIME is the only clock that often is misused in real-time
applications. The other clocks either are safe for real-time uses
(CLOCK_TAI, CLOCK_MONOTONIC, CLOCK_BOOTTIME) or are unlikely to be misused
(CLOCK_AUX, CLOCK_PROCESS_CPUTIME_ID).

Update the monitor to only warn about CLOCK_REALTIME.

While at it, update the out-of-sync documentation.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/monitor_rtapp.rst  | 17 +++++---
 kernel/trace/rv/monitors/sleep/sleep.c    | 12 ++----
 kernel/trace/rv/monitors/sleep/sleep.h    | 52 +++++++++++------------
 tools/verification/models/rtapp/sleep.ltl |  2 +-
 4 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace=
/rv/monitor_rtapp.rst
index 01656bf7080a..570be67a8f3b 100644
--- a/Documentation/trace/rv/monitor_rtapp.rst
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -51,12 +51,13 @@ The `sleep` monitor reports real-time threads sleeping =
in a manner that may
 cause undesirable latency. Real-time applications should only put a real-t=
ime
 thread to sleep for one of the following reasons:
=20
-  - Cyclic work: real-time thread sleeps waiting for the next cycle. For t=
his
-    case, only the `clock_nanosleep` syscall should be used with `TIMER_AB=
STIME`
-    (to avoid time drift) and `CLOCK_MONOTONIC` (to avoid the clock being
-    changed). No other method is safe for real-time. For example, threads
-    waiting for timerfd can be woken by softirq which provides no real-time
-    guarantee.
+  - Cyclic work: real-time thread sleeps waiting for the next
+    cycle. For this case, only the `clock_nanosleep` syscall should be
+    used with `TIMER_ABSTIME` (to avoid time drift). Additionally,
+    `CLOCK_REALTIME` should not be used (to avoid the clock being
+    changed). No other method is safe for real-time. For example,
+    threads waiting for timerfd can be woken by softirq which provides
+    no real-time guarantee.
   - Real-time thread waiting for something to happen (e.g. another thread
     releasing shared resources, or a completion signal from another thread=
). In
     this case, only futexes (FUTEX_LOCK_PI, FUTEX_LOCK_PI2 or one of
@@ -99,14 +100,16 @@ The monitor's specification is::
=20
   RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
                        or RT_FRIENDLY_NANOSLEEP
+                       or EPOLL_WAIT
=20
   RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
                       and NANOSLEEP_TIMER_ABSTIME
-                      and NANOSLEEP_CLOCK_MONOTONIC
+                      and not NANOSLEEP_CLOCK_REALTIME
=20
   RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
                   or WOKEN_BY_HARDIRQ
                   or WOKEN_BY_NMI
+                  or ABORT_SLEEP
                   or KTHREAD_SHOULD_STOP
=20
   ALLOWLIST =3D BLOCK_ON_RT_MUTEX
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monit=
ors/sleep/sleep.c
index d6b677fab8f8..638be7d8747f 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -44,8 +44,7 @@ static void ltl_atoms_init(struct task_struct *task, stru=
ct ltl_monitor *mon, bo
=20
 	if (task_creation) {
 		ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
 		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
 		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
 		ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
@@ -60,8 +59,7 @@ static void ltl_atoms_init(struct task_struct *task, stru=
ct ltl_monitor *mon, bo
 		/* kernel tasks do not do syscall */
 		ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
 		ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
 		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
 		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
 		ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
@@ -136,8 +134,7 @@ static void handle_sys_enter(void *data, struct pt_regs=
 *regs, long id)
 	case __NR_clock_nanosleep_time64:
 #endif
 		syscall_get_arguments(current, regs, args);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, args[0] =3D=3D CLOCK_MO=
NOTONIC);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, args[0] =3D=3D CLOCK_TAI);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, args[0] =3D=3D CLOCK_REA=
LTIME);
 		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, args[1] =3D=3D TIMER_ABST=
IME);
 		ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
 		break;
@@ -178,8 +175,7 @@ static void handle_sys_exit(void *data, struct pt_regs =
*regs, long ret)
=20
 	ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
 	ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
-	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
-	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
+	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
 	ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
 	ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
 	ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
diff --git a/kernel/trace/rv/monitors/sleep/sleep.h b/kernel/trace/rv/monit=
ors/sleep/sleep.h
index 403dc2852c52..2fe2ec7edae8 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.h
+++ b/kernel/trace/rv/monitors/sleep/sleep.h
@@ -20,8 +20,7 @@ enum ltl_atom {
 	LTL_FUTEX_WAIT,
 	LTL_KERNEL_THREAD,
 	LTL_KTHREAD_SHOULD_STOP,
-	LTL_NANOSLEEP_CLOCK_MONOTONIC,
-	LTL_NANOSLEEP_CLOCK_TAI,
+	LTL_NANOSLEEP_CLOCK_REALTIME,
 	LTL_NANOSLEEP_TIMER_ABSTIME,
 	LTL_RT,
 	LTL_SCHEDULE_IN,
@@ -46,8 +45,7 @@ static const char *ltl_atom_str(enum ltl_atom atom)
 		"fu_wa",
 		"ker_th",
 		"kth_sh_st",
-		"na_cl_mo",
-		"na_cl_ta",
+		"na_cl_re",
 		"na_ti_ab",
 		"rt",
 		"sch_in",
@@ -87,8 +85,7 @@ static void ltl_start(struct task_struct *task, struct lt=
l_monitor *mon)
 	bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
 	bool rt =3D test_bit(LTL_RT, mon->atoms);
 	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
-	bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms=
);
-	bool nanosleep_clock_monotonic =3D test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC=
, mon->atoms);
+	bool nanosleep_clock_realtime =3D test_bit(LTL_NANOSLEEP_CLOCK_REALTIME, =
mon->atoms);
 	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
 	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
 	bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
@@ -97,17 +94,17 @@ static void ltl_start(struct task_struct *task, struct =
ltl_monitor *mon)
 	bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
 	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
 	bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
-	bool val42 =3D task_is_rcu || task_is_migration;
-	bool val43 =3D futex_lock_pi || val42;
-	bool val5 =3D block_on_rt_mutex || val43;
-	bool val34 =3D abort_sleep || kthread_should_stop;
-	bool val35 =3D woken_by_nmi || val34;
-	bool val36 =3D woken_by_hardirq || val35;
-	bool val14 =3D woken_by_equal_or_higher_prio || val36;
+	bool val41 =3D task_is_rcu || task_is_migration;
+	bool val42 =3D futex_lock_pi || val41;
+	bool val5 =3D block_on_rt_mutex || val42;
+	bool val33 =3D abort_sleep || kthread_should_stop;
+	bool val34 =3D woken_by_nmi || val33;
+	bool val35 =3D woken_by_hardirq || val34;
+	bool val14 =3D woken_by_equal_or_higher_prio || val35;
 	bool val13 =3D !schedule_in;
-	bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
-	bool val27 =3D nanosleep_timer_abstime && val26;
-	bool val18 =3D clock_nanosleep && val27;
+	bool val25 =3D !nanosleep_clock_realtime;
+	bool val26 =3D nanosleep_timer_abstime && val25;
+	bool val18 =3D clock_nanosleep && val26;
 	bool val20 =3D val18 || epoll_wait;
 	bool val9 =3D futex_wait || val20;
 	bool val11 =3D val9 || kernel_thread;
@@ -138,8 +135,7 @@ ltl_possible_next_states(struct ltl_monitor *mon, unsig=
ned int state, unsigned l
 	bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
 	bool rt =3D test_bit(LTL_RT, mon->atoms);
 	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
-	bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms=
);
-	bool nanosleep_clock_monotonic =3D test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC=
, mon->atoms);
+	bool nanosleep_clock_realtime =3D test_bit(LTL_NANOSLEEP_CLOCK_REALTIME, =
mon->atoms);
 	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
 	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
 	bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
@@ -148,17 +144,17 @@ ltl_possible_next_states(struct ltl_monitor *mon, uns=
igned int state, unsigned l
 	bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
 	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
 	bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
-	bool val42 =3D task_is_rcu || task_is_migration;
-	bool val43 =3D futex_lock_pi || val42;
-	bool val5 =3D block_on_rt_mutex || val43;
-	bool val34 =3D abort_sleep || kthread_should_stop;
-	bool val35 =3D woken_by_nmi || val34;
-	bool val36 =3D woken_by_hardirq || val35;
-	bool val14 =3D woken_by_equal_or_higher_prio || val36;
+	bool val41 =3D task_is_rcu || task_is_migration;
+	bool val42 =3D futex_lock_pi || val41;
+	bool val5 =3D block_on_rt_mutex || val42;
+	bool val33 =3D abort_sleep || kthread_should_stop;
+	bool val34 =3D woken_by_nmi || val33;
+	bool val35 =3D woken_by_hardirq || val34;
+	bool val14 =3D woken_by_equal_or_higher_prio || val35;
 	bool val13 =3D !schedule_in;
-	bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
-	bool val27 =3D nanosleep_timer_abstime && val26;
-	bool val18 =3D clock_nanosleep && val27;
+	bool val25 =3D !nanosleep_clock_realtime;
+	bool val26 =3D nanosleep_timer_abstime && val25;
+	bool val18 =3D clock_nanosleep && val26;
 	bool val20 =3D val18 || epoll_wait;
 	bool val9 =3D futex_wait || val20;
 	bool val11 =3D val9 || kernel_thread;
diff --git a/tools/verification/models/rtapp/sleep.ltl b/tools/verification=
/models/rtapp/sleep.ltl
index 464c84b9df87..5923e58d7810 100644
--- a/tools/verification/models/rtapp/sleep.ltl
+++ b/tools/verification/models/rtapp/sleep.ltl
@@ -9,7 +9,7 @@ RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
=20
 RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
                     and NANOSLEEP_TIMER_ABSTIME
-                    and (NANOSLEEP_CLOCK_MONOTONIC or NANOSLEEP_CLOCK_TAI)
+                    and not NANOSLEEP_CLOCK_REALTIME
=20
 RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
                 or WOKEN_BY_HARDIRQ
--=20
2.47.3

