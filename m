Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092D3A9623;
	Tue, 31 Mar 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954169; cv=none; b=BfDhfaJ63aIAEhajGoYLzheihPayXBhgjj4CuI6U4gj8QnCyIaiKm1Ovrye+GNLempTJjsqd7kpTsBBSIeCECdo1fSs8rCa7WbtLts2DtEiW6mMz5wZICLDUVCTYl9dS51DhSVtGPtzL6Zkt0qwBxIYdlc1QWc26s/ghjV5ybK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954169; c=relaxed/simple;
	bh=HlILzv4uA6TGQrbzncJ54pWYKVdU9vpGRgmHL6Lwq3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxHxogSlJj8nRMxzal+Zz2zAg0CMRgbHPGBRS4okzSwVYWsBc5fQZB8kHYD64hQsbnX2uVmzxHB35qf7R2ZkFevgzPAQQLJ+/Z5x8mHR0JALRftq9KWHWup+FjY40rMhhdRTH+eCe2BiExtP4oPrca/HqZiXGNFUXlXTdzHhh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLSioINn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtvVs0Ix; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLSioINn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtvVs0Ix"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774954165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uYdKAK10x6QwQM9ujCi3jvA8r0QQ2cCaehpH6IP6LQE=;
	b=SLSioINnq0PolG8gUFzu8ckG1pFybBjl/10glmJ5/VHML3g63JPtNz/824VakyGh5oGy3o
	IPcf+UwL7Sg8RNt7ZqDyqVIF8iJCO5omaCu0DJHhdVFCNBR9MWRl9zRMf9I6DB0Az3O1Q+
	C1rDpoOeLrxFCH4sg9uz8VU/MkXcrVWwluWXb4BxO+oifOLIBaJaHeswu7XISB6H87locw
	XLQJAYPfY6Du6qi5D+dOVOJ6TaXpDqEDMjo57zfpCnHiGVa8TL/gUCvPsAb6+qEiLoOcb1
	Tm0CjFvrgm0hBh4QMyDKTAUvrP4DEmtMp7Wr+bZmqUw5lcBfFoh9G3yBORjrcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774954165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uYdKAK10x6QwQM9ujCi3jvA8r0QQ2cCaehpH6IP6LQE=;
	b=XtvVs0IxFK5toHkW6A53h8Mom4QFan/YmcYITDPboyL9cU+nHFg/Qh9ndyFhlF4xcuxDDu
	OpmwbUyhmHvPkgAA==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH] rv: Allow epoll in rtapp-sleep monitor
Date: Tue, 31 Mar 2026 12:49:18 +0200
Message-ID: <20260331104918.2710853-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 0c43094f8cc9 ("eventpoll: Replace rwlock with spinlock"),
epoll_wait is real-time-safe syscall for sleeping.

Add epoll_wait to the list of rt-safe sleeping APIs.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/monitors/sleep/sleep.c    |  8 ++
 kernel/trace/rv/monitors/sleep/sleep.h    | 98 ++++++++++++-----------
 tools/verification/models/rtapp/sleep.ltl |  1 +
 3 files changed, 61 insertions(+), 46 deletions(-)

diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monit=
ors/sleep/sleep.c
index c1347da69e9d..59091863c17c 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -49,6 +49,7 @@ static void ltl_atoms_init(struct task_struct *task, stru=
ct ltl_monitor *mon, bo
 		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
 		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
 		ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
+		ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
 		ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
 		ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
 	}
@@ -63,6 +64,7 @@ static void ltl_atoms_init(struct task_struct *task, stru=
ct ltl_monitor *mon, bo
 		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
 		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
 		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
+		ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
=20
 		if (strstarts(task->comm, "migration/"))
 			ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, true);
@@ -162,6 +164,11 @@ static void handle_sys_enter(void *data, struct pt_reg=
s *regs, long id)
 			break;
 		}
 		break;
+#ifdef __NR_epoll_wait
+	case __NR_epoll_wait:
+		ltl_atom_set(mon, LTL_EPOLL_WAIT, true);
+		break;
+#endif
 	}
 }
=20
@@ -174,6 +181,7 @@ static void handle_sys_exit(void *data, struct pt_regs =
*regs, long ret)
 	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
 	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
 	ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
+	ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
 	ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
 }
=20
diff --git a/kernel/trace/rv/monitors/sleep/sleep.h b/kernel/trace/rv/monit=
ors/sleep/sleep.h
index 2ab46fd218d2..95dc2727c059 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.h
+++ b/kernel/trace/rv/monitors/sleep/sleep.h
@@ -15,6 +15,7 @@ enum ltl_atom {
 	LTL_ABORT_SLEEP,
 	LTL_BLOCK_ON_RT_MUTEX,
 	LTL_CLOCK_NANOSLEEP,
+	LTL_EPOLL_WAIT,
 	LTL_FUTEX_LOCK_PI,
 	LTL_FUTEX_WAIT,
 	LTL_KERNEL_THREAD,
@@ -40,6 +41,7 @@ static const char *ltl_atom_str(enum ltl_atom atom)
 		"ab_sl",
 		"bl_on_rt_mu",
 		"cl_na",
+		"ep_wa",
 		"fu_lo_pi",
 		"fu_wa",
 		"ker_th",
@@ -75,39 +77,41 @@ static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
=20
 static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
 {
-	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
-	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
-	bool val40 =3D task_is_rcu || task_is_migration;
-	bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
-	bool val41 =3D futex_lock_pi || val40;
-	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
-	bool val5 =3D block_on_rt_mutex || val41;
-	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
-	bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
-	bool val32 =3D abort_sleep || kthread_should_stop;
 	bool woken_by_nmi =3D test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
-	bool val33 =3D woken_by_nmi || val32;
 	bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
-	bool val34 =3D woken_by_hardirq || val33;
 	bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_BY_EQUAL_OR_HIG=
HER_PRIO,
 	     mon->atoms);
-	bool val14 =3D woken_by_equal_or_higher_prio || val34;
 	bool wake =3D test_bit(LTL_WAKE, mon->atoms);
-	bool val13 =3D !wake;
-	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
+	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
+	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
+	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
+	bool rt =3D test_bit(LTL_RT, mon->atoms);
+	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
 	bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms=
);
 	bool nanosleep_clock_monotonic =3D test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC=
, mon->atoms);
-	bool val24 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
-	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
-	bool val25 =3D nanosleep_timer_abstime && val24;
-	bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
-	bool val18 =3D clock_nanosleep && val25;
+	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
+	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
 	bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
-	bool val9 =3D futex_wait || val18;
+	bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
+	bool epoll_wait =3D test_bit(LTL_EPOLL_WAIT, mon->atoms);
+	bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
+	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
+	bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
+	bool val42 =3D task_is_rcu || task_is_migration;
+	bool val43 =3D futex_lock_pi || val42;
+	bool val5 =3D block_on_rt_mutex || val43;
+	bool val34 =3D abort_sleep || kthread_should_stop;
+	bool val35 =3D woken_by_nmi || val34;
+	bool val36 =3D woken_by_hardirq || val35;
+	bool val14 =3D woken_by_equal_or_higher_prio || val36;
+	bool val13 =3D !wake;
+	bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
+	bool val27 =3D nanosleep_timer_abstime && val26;
+	bool val18 =3D clock_nanosleep && val27;
+	bool val20 =3D val18 || epoll_wait;
+	bool val9 =3D futex_wait || val20;
 	bool val11 =3D val9 || kernel_thread;
-	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
 	bool val2 =3D !sleep;
-	bool rt =3D test_bit(LTL_RT, mon->atoms);
 	bool val1 =3D !rt;
 	bool val3 =3D val1 || val2;
=20
@@ -124,39 +128,41 @@ static void ltl_start(struct task_struct *task, struc=
t ltl_monitor *mon)
 static void
 ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsi=
gned long *next)
 {
-	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
-	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
-	bool val40 =3D task_is_rcu || task_is_migration;
-	bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
-	bool val41 =3D futex_lock_pi || val40;
-	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
-	bool val5 =3D block_on_rt_mutex || val41;
-	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
-	bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
-	bool val32 =3D abort_sleep || kthread_should_stop;
 	bool woken_by_nmi =3D test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
-	bool val33 =3D woken_by_nmi || val32;
 	bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
-	bool val34 =3D woken_by_hardirq || val33;
 	bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_BY_EQUAL_OR_HIG=
HER_PRIO,
 	     mon->atoms);
-	bool val14 =3D woken_by_equal_or_higher_prio || val34;
 	bool wake =3D test_bit(LTL_WAKE, mon->atoms);
-	bool val13 =3D !wake;
-	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
+	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
+	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
+	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
+	bool rt =3D test_bit(LTL_RT, mon->atoms);
+	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
 	bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms=
);
 	bool nanosleep_clock_monotonic =3D test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC=
, mon->atoms);
-	bool val24 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
-	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
-	bool val25 =3D nanosleep_timer_abstime && val24;
-	bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
-	bool val18 =3D clock_nanosleep && val25;
+	bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms=
);
+	bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
 	bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
-	bool val9 =3D futex_wait || val18;
+	bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
+	bool epoll_wait =3D test_bit(LTL_EPOLL_WAIT, mon->atoms);
+	bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
+	bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
+	bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
+	bool val42 =3D task_is_rcu || task_is_migration;
+	bool val43 =3D futex_lock_pi || val42;
+	bool val5 =3D block_on_rt_mutex || val43;
+	bool val34 =3D abort_sleep || kthread_should_stop;
+	bool val35 =3D woken_by_nmi || val34;
+	bool val36 =3D woken_by_hardirq || val35;
+	bool val14 =3D woken_by_equal_or_higher_prio || val36;
+	bool val13 =3D !wake;
+	bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
+	bool val27 =3D nanosleep_timer_abstime && val26;
+	bool val18 =3D clock_nanosleep && val27;
+	bool val20 =3D val18 || epoll_wait;
+	bool val9 =3D futex_wait || val20;
 	bool val11 =3D val9 || kernel_thread;
-	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
 	bool val2 =3D !sleep;
-	bool rt =3D test_bit(LTL_RT, mon->atoms);
 	bool val1 =3D !rt;
 	bool val3 =3D val1 || val2;
=20
diff --git a/tools/verification/models/rtapp/sleep.ltl b/tools/verification=
/models/rtapp/sleep.ltl
index 6379bbeb6212..6f26c4810f78 100644
--- a/tools/verification/models/rtapp/sleep.ltl
+++ b/tools/verification/models/rtapp/sleep.ltl
@@ -5,6 +5,7 @@ RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THRE=
AD)
=20
 RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
                      or RT_FRIENDLY_NANOSLEEP
+                     or EPOLL_WAIT
=20
 RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
                     and NANOSLEEP_TIMER_ABSTIME
--=20
2.47.3

