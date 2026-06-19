Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93B3101A6;
	Fri, 19 Jun 2026 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853697; cv=none; b=H5jVPol9bxvYVrhIczUI5OHZqqzX3rCgmIerv7qph09Qq8pWgjQyPJBQttyo9bM7mL6zlRV0VUeMXAVLbWf1tpgaiLMRfILP5cqFKXvSJQw776kxbwWFpfMj6YHvYYUZibfZ+w8/kgZg7mZRYv8HnotuHT5AcmwuO7Nm0oTAff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853697; c=relaxed/simple;
	bh=Ek/qcAJSHNjZpAm0+dT970pFb4s30b47rFLRpIphX+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMbPgUa38NtLfPx7Rl6Tmwki0pYXJH1DIic0eUgHHBWeEiLbW39yAn527VbaFsDx89eIqayRL9i2r60vo39/ZIkZeU24RtVNsCXV9C8EmninqB6UEPapeCiRISqVYtybVtw+UM7klS6SdKE14RT3WykruQEMkCE2sbyR8yiU90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXBAGJeB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1oBHvbi/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXBAGJeB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1oBHvbi/"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781853694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nh3eyGS0+E1J1pkEjIwGnAEozJXkuoO4vb03IncLbzI=;
	b=kXBAGJeBe8syqI4GLu0paBPHgfjxD3trJX5QfIl60FIOdkTmSr2NrMRiUlF2q/Cy2yJHvB
	c3DEpxqu4uJNgLahUyErlOnnPOkxbh6jaweQewdo30x44uvOmBwhous8OlAtMV6pBtdwkG
	OJGxuNnKkLLHEfBkHPixjYB2VAHW0n6iQbJWFlC7J3P4DPR9Jfb4RI1ZbxUVKWqXEYpJPQ
	m5/OJDhqdelY+srMI4VbMrpVQVWvyQaImyeiNj0LNRmqDD1uuE0liE5uvV7JbAB1NXmo+7
	UZ4Hj9CbQ5qCrpE4Z62AV0PSRqTXU5E8ao5rpBOnpO169SJXa45FZXM8kzU3yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781853694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nh3eyGS0+E1J1pkEjIwGnAEozJXkuoO4vb03IncLbzI=;
	b=1oBHvbi/ILMxk0yeDwMpbCKP3jnEWa2cP7b0oouPc38f/cp934Tav//Eo8I4w5oen96fSy
	UH0wcXhHuTscrYDQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 1/4] rv/rtapp/sleep: Make the error more informative for user
Date: Fri, 19 Jun 2026 09:21:19 +0200
Message-ID: <d97b4b5c476e5792b6875ec9bbf8dc214f999516.1781852967.git.namcao@linutronix.de>
In-Reply-To: <cover.1781852967.git.namcao@linutronix.de>
References: <cover.1781852967.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The rtapp/sleep monitor detects real-time tasks which go to sleep in an
real-time-unsafe manner. If this happen, the monitor triggers a trace event
in the sched_wakeup tracepoint's handler.

However, the invoking context of that trace event is not the most
informative, because of the stack trace of that event is the wakeup's code
path which is not very helpful:

74.669317: rv:error_sleep: condvar[254]: violation detected
    ltl_validate+0x345 ([kernel.kallsyms])
    handle_sched_wakeup+0x34 ([kernel.kallsyms])
    ttwu_do_activate+0xff ([kernel.kallsyms])
    sched_ttwu_pending+0x104 ([kernel.kallsyms])
    __flush_smp_call_function_queue+0x15b ([kernel.kallsyms])
    __sysvec_call_function_single+0x18 ([kernel.kallsyms])
    sysvec_call_function_single+0x66 ([kernel.kallsyms])
    asm_sysvec_call_function_single+0x1a ([kernel.kallsyms])
    pv_native_safe_halt+0xf ([kernel.kallsyms])
    default_idle+0x9 ([kernel.kallsyms])
    default_idle_call+0x33 ([kernel.kallsyms])
    do_idle+0x234 ([kernel.kallsyms])
    cpu_startup_entry+0x24 ([kernel.kallsyms])
    start_secondary+0xf8 ([kernel.kallsyms])
    common_startup_64+0x13e ([kernel.kallsyms])

What would be much more valuable is the stack trace of the task itself.

Instead of using the sched_wakeup tracepoint, use the sched_exit
tracepoint. This makes the event happen in the task's context, making
the stack trace far more informative for user:

rv:error_sleep: condvar[254]: violation detected
    ltl_validate+0x345 ([kernel.kallsyms])
    handle_sched_exit+0x39 ([kernel.kallsyms])
    __schedule+0x80f ([kernel.kallsyms])
    schedule+0x22 ([kernel.kallsyms])
    futex_do_wait+0x33 ([kernel.kallsyms])
    __futex_wait+0x8c ([kernel.kallsyms])
    futex_wait+0x73 ([kernel.kallsyms])
    do_futex+0xc6 ([kernel.kallsyms])
    __x64_sys_futex+0x121 ([kernel.kallsyms])
    do_syscall_64+0xf3 ([kernel.kallsyms])
    entry_SYSCALL_64_after_hwframe+0x77 ([kernel.kallsyms])
    __futex_abstimed_wait_common64+0xc6 (inlined)
    __futex_abstimed_wait_common+0xc6 (/usr/lib/x86_64-linux-gnu/libc.so.6)

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/monitor_rtapp.rst  |  2 +-
 kernel/trace/rv/monitors/sleep/sleep.c    | 10 +++++-----
 kernel/trace/rv/monitors/sleep/sleep.h    | 14 +++++++-------
 tools/verification/models/rtapp/sleep.ltl |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace=
/rv/monitor_rtapp.rst
index c8104eda924a..01656bf7080a 100644
--- a/Documentation/trace/rv/monitor_rtapp.rst
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -95,7 +95,7 @@ The monitor's specification is::
   RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
=20
   RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
-                  and ((not WAKE) until RT_FRIENDLY_WAKE)
+                  and ((not SCHEDULE_IN) until RT_FRIENDLY_WAKE)
=20
   RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
                        or RT_FRIENDLY_NANOSLEEP
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monit=
ors/sleep/sleep.c
index 8dfe5ec13e19..d6b677fab8f8 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -36,7 +36,7 @@ static void ltl_atoms_fetch(struct task_struct *task, str=
uct ltl_monitor *mon)
 static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *m=
on, bool task_creation)
 {
 	ltl_atom_set(mon, LTL_SLEEP, false);
-	ltl_atom_set(mon, LTL_WAKE, false);
+	ltl_atom_set(mon, LTL_SCHEDULE_IN, false);
 	ltl_atom_set(mon, LTL_ABORT_SLEEP, false);
 	ltl_atom_set(mon, LTL_WOKEN_BY_HARDIRQ, false);
 	ltl_atom_set(mon, LTL_WOKEN_BY_NMI, false);
@@ -92,9 +92,9 @@ static void handle_sched_set_state(void *data, struct tas=
k_struct *task, int sta
 		ltl_atom_pulse(task, LTL_ABORT_SLEEP, true);
 }
=20
-static void handle_sched_wakeup(void *data, struct task_struct *task)
+static void handle_sched_exit(void *data, bool is_switch)
 {
-	ltl_atom_pulse(task, LTL_WAKE, true);
+	ltl_atom_pulse(current, LTL_SCHEDULE_IN, true);
 }
=20
 static void handle_sched_waking(void *data, struct task_struct *task)
@@ -200,7 +200,7 @@ static int enable_sleep(void)
 		return retval;
=20
 	rv_attach_trace_probe("rtapp_sleep", sched_waking, handle_sched_waking);
-	rv_attach_trace_probe("rtapp_sleep", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("rtapp_sleep", sched_exit_tp, handle_sched_exit);
 	rv_attach_trace_probe("rtapp_sleep", sched_set_state_tp, handle_sched_set=
_state);
 	rv_attach_trace_probe("rtapp_sleep", contention_begin, handle_contention_=
begin);
 	rv_attach_trace_probe("rtapp_sleep", contention_end, handle_contention_en=
d);
@@ -213,7 +213,7 @@ static int enable_sleep(void)
 static void disable_sleep(void)
 {
 	rv_detach_trace_probe("rtapp_sleep", sched_waking, handle_sched_waking);
-	rv_detach_trace_probe("rtapp_sleep", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("rtapp_sleep", sched_exit_tp, handle_sched_exit);
 	rv_detach_trace_probe("rtapp_sleep", sched_set_state_tp, handle_sched_set=
_state);
 	rv_detach_trace_probe("rtapp_sleep", contention_begin, handle_contention_=
begin);
 	rv_detach_trace_probe("rtapp_sleep", contention_end, handle_contention_en=
d);
diff --git a/kernel/trace/rv/monitors/sleep/sleep.h b/kernel/trace/rv/monit=
ors/sleep/sleep.h
index 95dc2727c059..403dc2852c52 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.h
+++ b/kernel/trace/rv/monitors/sleep/sleep.h
@@ -24,10 +24,10 @@ enum ltl_atom {
 	LTL_NANOSLEEP_CLOCK_TAI,
 	LTL_NANOSLEEP_TIMER_ABSTIME,
 	LTL_RT,
+	LTL_SCHEDULE_IN,
 	LTL_SLEEP,
 	LTL_TASK_IS_MIGRATION,
 	LTL_TASK_IS_RCU,
-	LTL_WAKE,
 	LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
 	LTL_WOKEN_BY_HARDIRQ,
 	LTL_WOKEN_BY_NMI,
@@ -50,10 +50,10 @@ static const char *ltl_atom_str(enum ltl_atom atom)
 		"na_cl_ta",
 		"na_ti_ab",
 		"rt",
-		"sl",
+		"sch_in",
+		"sle",
 		"ta_mi",
 		"ta_rc",
-		"wak",
 		"wo_eq_hi_pr",
 		"wo_ha",
 		"wo_nm",
@@ -81,10 +81,10 @@ static void ltl_start(struct task_struct *task, struct =
ltl_monitor *mon)
 	bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
 	bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_BY_EQUAL_OR_HIG=
HER_PRIO,
 	     mon->atoms);
-	bool wake =3D test_bit(LTL_WAKE, mon->atoms);
 	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
 	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
 	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
+	bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
 	bool rt =3D test_bit(LTL_RT, mon->atoms);
 	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
 	bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms=
);
@@ -104,7 +104,7 @@ static void ltl_start(struct task_struct *task, struct =
ltl_monitor *mon)
 	bool val35 =3D woken_by_nmi || val34;
 	bool val36 =3D woken_by_hardirq || val35;
 	bool val14 =3D woken_by_equal_or_higher_prio || val36;
-	bool val13 =3D !wake;
+	bool val13 =3D !schedule_in;
 	bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
 	bool val27 =3D nanosleep_timer_abstime && val26;
 	bool val18 =3D clock_nanosleep && val27;
@@ -132,10 +132,10 @@ ltl_possible_next_states(struct ltl_monitor *mon, uns=
igned int state, unsigned l
 	bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
 	bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_BY_EQUAL_OR_HIG=
HER_PRIO,
 	     mon->atoms);
-	bool wake =3D test_bit(LTL_WAKE, mon->atoms);
 	bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
 	bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
 	bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
+	bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
 	bool rt =3D test_bit(LTL_RT, mon->atoms);
 	bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mo=
n->atoms);
 	bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms=
);
@@ -155,7 +155,7 @@ ltl_possible_next_states(struct ltl_monitor *mon, unsig=
ned int state, unsigned l
 	bool val35 =3D woken_by_nmi || val34;
 	bool val36 =3D woken_by_hardirq || val35;
 	bool val14 =3D woken_by_equal_or_higher_prio || val36;
-	bool val13 =3D !wake;
+	bool val13 =3D !schedule_in;
 	bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
 	bool val27 =3D nanosleep_timer_abstime && val26;
 	bool val18 =3D clock_nanosleep && val27;
diff --git a/tools/verification/models/rtapp/sleep.ltl b/tools/verification=
/models/rtapp/sleep.ltl
index 6f26c4810f78..464c84b9df87 100644
--- a/tools/verification/models/rtapp/sleep.ltl
+++ b/tools/verification/models/rtapp/sleep.ltl
@@ -1,7 +1,7 @@
 RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
=20
 RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
-                and ((not WAKE) until RT_FRIENDLY_WAKE)
+                and ((not SCHEDULE_IN) until RT_FRIENDLY_WAKE)
=20
 RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
                      or RT_FRIENDLY_NANOSLEEP
--=20
2.47.3

