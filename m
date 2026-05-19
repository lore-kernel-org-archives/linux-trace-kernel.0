Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054123DB641;
	Tue, 19 May 2026 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177002; cv=none; b=a08+9OtSpontIqYNkKIK5r0KRRxgHo1U8Q4fCaoX2AalcnIf0ZTsOXZRqE2u2rQXuApL3gjmzzvYZD1RNapg4AbDSxNJJZuR8pX9+k1b0cBO0WMdqtcShpwPaZKgu9B6lwByz7lL/rUtFJjAgdBPEQWqVCXcyqLhWN3JNcE2lZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177002; c=relaxed/simple;
	bh=qB14ZcRjNUseOaH4fxbgwngfB0pNuavqGWlXPb9fYeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTV8jvHjTLEbMelDF4nBijvNAR7tXLywqb9L/W81/sYOeiNcoUlEuTjjWKmmMr5Yx5hQwpoUpYFqvg4uru5w+KvdxUQ9IGJSfmpEfKBa63Pw+Ubfr15Sh7sWbt7D2tA69YL4SVY3bQM9Ew/FQcCCNgLyY9hwfj8lLw0tF37Qqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vWopdMRm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtCQg2hb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vWopdMRm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtCQg2hb"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779176990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YAFz3/nEoV68jxh3U+BQ79tHP/jhnfEHV3OQmZJeY0=;
	b=vWopdMRmOcFkuCkxGIo/rOq1XPg2YCTaUCU9Xmog0M2lQYzOcZPC+vHw8mXoh5l6sRRYkb
	gbddZFAfoAmN3Z486X7xpQnAIlzy9XKvnxzp5C5viqMXQH0jxJUWBF3MtElDzXv0xfyG7c
	5polVzZyBmQfJ1+SXRyjzHSLjjuKmhxomtIkSAGn8RoiDj3gJ8O648SVxINxVS5jLjDp6G
	FeDhKA5uCZvyt3JE5V+2mPflj3Pzv9AJ7rrcYGzgLiV16EPhH9vbdeSTxknIqt+oltxbW7
	3sXufTqC64/35zmCGWG07ec5fOnQOv2Q5S22D14ZlmSQj9ca8Cj/GHdDYzI55g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779176990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YAFz3/nEoV68jxh3U+BQ79tHP/jhnfEHV3OQmZJeY0=;
	b=CtCQg2hbsUiF5sIef5HPURj3bjUZhBCAEpOuL4cPnRQU98y0odOzx/6Wotpmrfs0tDqjYX
	a7PIrbHVpA71+kAw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/3] rv/rtapp/sleep: Update nanosleep rule
Date: Tue, 19 May 2026 09:49:34 +0200
Message-ID: <a2175a6647bb88797ad8275eddb4b20b749474ec.1779176466.git.namcao@linutronix.de>
In-Reply-To: <cover.1779176466.git.namcao@linutronix.de>
References: <cover.1779176466.git.namcao@linutronix.de>
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

The rtapp monitor's purpose is warning people about common mistakes with
real-time design. However, warning about all clock types generates too much
false positives.

Update the monitor to only warn about CLOCK_REALTIME.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/monitors/sleep/sleep.c    | 10 ++---
 kernel/trace/rv/monitors/sleep/sleep.h    | 52 +++++++++++------------
 tools/verification/models/rtapp/sleep.ltl |  2 +-
 3 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monit=
ors/sleep/sleep.c
index 0a36f5519e6b..e01ac56b3f4a 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -43,9 +43,7 @@ static void ltl_atoms_init(struct task_struct *task, stru=
ct ltl_monitor *mon, bo
 	ltl_atom_set(mon, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, false);
=20
 	if (task_creation) {
-		ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
-		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
 		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
 		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
 		ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
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
index 95dc2727c059..ed1ac7ad008e 100644
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
 	LTL_SLEEP,
@@ -46,8 +45,7 @@ static const char *ltl_atom_str(enum ltl_atom atom)
 		"fu_wa",
 		"ker_th",
 		"kth_sh_st",
-		"na_cl_mo",
-		"na_cl_ta",
+		"na_cl_re",
 		"na_ti_ab",
 		"rt",
 		"sl",
@@ -87,8 +85,7 @@ static void ltl_start(struct task_struct *task, struct lt=
l_monitor *mon)
 	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
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
 	bool val13 =3D !wake;
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
 	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
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
 	bool val13 =3D !wake;
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
index 6f26c4810f78..2637bc48a620 100644
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

