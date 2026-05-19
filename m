Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320CB3DD847;
	Tue, 19 May 2026 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176998; cv=none; b=Oq544hOtmR4G8qVYKqU+UBxEgisijfgn2Y8qb4Pm4lRqylkbm542tCEv56WTB7TTOJpE9ydRJ79sRHqY65VQ8RNkG34CfovQxYp1gNbJBdpnoUkycx+Y+Yar1qv+8Glqcj61pDPr9Sz54MYmcznOGlgmBW3v01liEnys9VfHEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176998; c=relaxed/simple;
	bh=mgCpvKA1Z8lP7MIk4JH67/fuLeGUyUtS1SEIdFGylLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gua9ZQrFH0xwEIK7+8wbxegDYu+CpUZlS0YWMlYqA6AGGax1UV44o8tsANL0zoIVcevbGwRZvzbrP150NT2Ne/P/VIy9XvoB3aG7O3n1vNPXanE5Ak+WjfyxVtadPWW6XL05M3HJo72GpqKejXdNU2IuTqkU2WXl2H10Mn9X4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AtRSeb0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YjR/uvaD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AtRSeb0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YjR/uvaD"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779176989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsOE7YC2GreJsc6/lCfnO7P4YYGxLfwkbP8mSrCEJ3E=;
	b=AtRSeb0XTn3k1YFb7IqdjqtZpgZWhve37/RW3Z9rn0iHpoFJMSfvqqwuQfmPD13+OXFHBZ
	4LY73WFcHN82k3eBpNUyvlWRjjxoxVgwmD4CR44tNZ9eFyCWwuefBMJjUQk/00Dg0gO7fs
	40b5yiga8HINLlEU/KWgPodR4hBWPm+IXkGgW3rdr/8tkdehWTC3yMhKDbPQLmg0d7w0pk
	2x2HHJyHNPU5FO32LMi1T/VRbfp5j7H9KtaBGsGa4mmssgqoq36j29jeB3ozBbbAdYJRR8
	72Mz4m8w92hpE2fZid6BGm+3lV/zW3SSQd+nPwMd9XtSbUNPHFPLwQDsoK3mCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779176989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsOE7YC2GreJsc6/lCfnO7P4YYGxLfwkbP8mSrCEJ3E=;
	b=YjR/uvaDKKfogHOdgUXs0+vS91/Cyw99Jsbd0KavYdsXmtCiESkZS5EFdFtdIjb6DuHecY
	Bi+HQVStC9nW+NAQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/3] rv/rtapp/sleep: Make the error more informative for user
Date: Tue, 19 May 2026 09:49:33 +0200
Message-ID: <14242f444f7d2396c0c5a345f0099665d09a0ec5.1779176466.git.namcao@linutronix.de>
In-Reply-To: <cover.1779176466.git.namcao@linutronix.de>
References: <cover.1779176466.git.namcao@linutronix.de>
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

Change the update of WAKEUP from being in sched_wakeup trace point's
handler to sched_exit trace point's handler. This makes the event happen in
the task's context, making the stack trace far more informative for user:

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
 kernel/trace/rv/monitors/sleep/sleep.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monit=
ors/sleep/sleep.c
index 8dfe5ec13e19..0a36f5519e6b 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -92,9 +92,9 @@ static void handle_sched_set_state(void *data, struct tas=
k_struct *task, int sta
 		ltl_atom_pulse(task, LTL_ABORT_SLEEP, true);
 }
=20
-static void handle_sched_wakeup(void *data, struct task_struct *task)
+static void handle_sched_exit(void *data, bool is_switch)
 {
-	ltl_atom_pulse(task, LTL_WAKE, true);
+	ltl_atom_pulse(current, LTL_WAKE, true);
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
--=20
2.47.3

