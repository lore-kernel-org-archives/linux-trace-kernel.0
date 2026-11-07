Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071608;
	b=nOXIQOrUavGQfxA/wOV3BVJsWG9W7lBweFBFcKCiCKCQVTrt4eTnV6F4vB3QoKEleocI
	 IV+cUkpSwWVCLnWKpQIKly7pAVKsjNpQCV6JqPsl3rC9Yt4o900vVaW/cDTyh8jzdDYub
	 e7Nmf0/QpMpQtLswe4QiSq/Uy2nkwj74wPv532YA6hDX/WFbJGQvPCMUFvhy9/O0H8cwx
	 fhyypNbJbkeEqx1G8F7puV5JIf6So4vEciQBkC68fWceAXFrSFIR+gS9pcqjwkSPqPWgl
	 DQrAhpeRxQNcIdPKv312AlOmju3D6rmcKxLgwBGEhQu1KO/4LPdCkShjkCZXXtqNPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dKH2RI2VuIKeC4rJTJKeMvpgo8Fn7rAU8sCg4LQrdgA=;
	b=phkH+qh+D2GMMf54g9HV5NY6v4/6KMxUeP3fGjxQyIeTrb10OByVl2Jo7cZ9ExzPN3xt
	 rBlUuEZahlDlAzTG6lrLdyQz5SgvbE05FRnKERrQiuoXbEmH49SfxbvJ+h+84KqoatM2I
	 OhrGh/cvK5s8yRsfHGEHKekKqq+jqC8fy2pPQU1nGKYxkR57MguIrPIhz9TvXuzC3Kk85
	 gy/MTJKGaLxECixyVAg1eMWyBx+aCP4QNmbHNzOhiM5eVMcak2KsyBeSkNU3el0tXUYQY
	 GiNW6W1ua/ujn63p8gu/DTQAdM9Y1qOIpROeBzOmuwrvfkMTRq6vIbt7Z4BhrBN0ddg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCWHsL64;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF606083612
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 17:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF606083612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCWHsL64
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-49134c8509fso1372247f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071606; x=1794676406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dKH2RI2VuIKeC4rJTJKeMvpgo8Fn7rAU8sCg4LQrdgA=;
        b=WCWHsL64dbzre4eTvwayAuSiM2P/vmxmCHaQ+iDX6L180lIL1xR3uqoqsRxtoatwsm
         bBZ5vMatV6UMt9hXh4BILjiDiEeoxk+VDRa4M7OLQBSFNI/XKXeS2qtx+3AbsjrC4YQL
         b+CDpIZHtR3MYT6+LK3V2/xnnU5r+ttNoKKffvBR+4Y3jp1EXJru+XwC1DrUwR5j4eHD
         ALqw+ScpNHD1a1OYVzYKpUyo+UmO7oLfG+Kk6vABcElMNni72J+7y+s6rby0nXE1Dsgc
         WDzj1j+SY1FbYUp5LffqjjUWyC9HzMR5/k5o2FY06+/RDq6m9Kfqu8yD1oNxvANgADyc
         jVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071606; x=1794676406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKH2RI2VuIKeC4rJTJKeMvpgo8Fn7rAU8sCg4LQrdgA=;
        b=F9e4pB3oUOGfXKGlVoF0A6lge+AOfac6xm/w+vB7oIbsDwU9lwO3ZIJfbiiAty6z/f
         QCgbwFGSUMZk25bv07r/HtMshlmo4o0ax3dKxT0I+ZGlwrmzu8TXFHvZ5ksL1Qo9SQEU
         f+7Xw4HLcPquVi75Lfv9xmTXly/k3zVApAe6pfpBQGmJBpnsKLMQsisZRnkVqiaXTLFA
         ybSkC7/Jd8FpWPjQvpH7SjYHNonM3fi1Z595xRLqDnegDNZ2NAmTiYfp++D7OiZc13nb
         SLKGOE6c2nXMTJGF2kPtwfF+2FzqtLuok6y8bzNg3z9pp6iMxE5H8cbNPIjCtMzjscTl
         AW3A==
X-Forwarded-Encrypted: i=1; AL+hErGW1mkL4pgiRRuCV9jb1q9AW63EMUaFHg83PzWNpkUSvtqdbHRth5P6sGOa+NesZ6ws9MSh318CcJci/EAtje+ksrI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WGchgC9mmQLc6WiATEzW5gIXFih+kRbjRES62eVoCVgLqt06v
	VBS+7OqnJtIB/fNpDPrxEc5bRfcHlTzLBAti0mELWufe/Tic78gnxQTz
X-Gm-Gg: AYBFou22xft1asX2jXLXuzUxfMVYFRUp/meBSd/5FVN570rSAk2PTf5yDM60DFH8qTS
	0jucLXTNXHZGoFQWqnwZ0YGtzeM65QZPovf3OKGK/Adv2t9oHwLQ7V5syqoyefL0oLwPUdwyfd0
	ZES1/lQMgAoGwdNFCldRByIPu1lWfzW0FGY9743zdmsarMV0BA1ulUz7VNltekqsuORPmY61Ole
	m2IyTjT4B28P7fO8NFt5bSIv8XicLAKBtZ2X+0XOW9QKWaP288n8d3iuZONBOaJJCM3RsIi0M0q
	0ZRSGmzRphK3MT2+fCvn7INKoMOAfhK3VlG/oqgr2m1Y6DrBuSrn1ltVYZZs5HSFePR0/zlsCbc
	Firoxsc0E6ss71xnd6tLVoW+WpA2QJOcKG7P8I3+3AXviBdm8/MkYjWtAsofWVe9ILnnhJmNsEO
	oVSCjr6W0Xr/ByjEVcuOkPSar+4jDPcTV0qjz766pT/uBgxL0wGeeZTFmrvCJ5iG7ULhp1Xk6Pr
	K331kkI758xhAEpkhkPZTehUZGbD1wS86Ju5Dteu0q1c7NRovYEgPyN0ZuFZr2ZuzMKqJ0mnFuY
	8zFjUHcEGcUAVtllm/1luOHQvty38bOh72hOPR/M+ocVs+xoekb1CgmMjcVYMl1JlmXy6kKjxHT
	+ov/5PS0XL4lrUhTZuCiTBu6Sa1xcSaq76+fg4aMRobcKlX7h3E+ra67BhDb0pvG9oSFBalLZbJ
	fpWyDBStZFB3zIBilkvLs/+Br1VZrAexc=
X-Received: by 2002:a05:6000:4312:b0:490:6fbc:9457 with SMTP id ffacd0b85a97d-4927678e068mr12750268f8f.41.1794071605834;
        Sat, 07 Nov 2026 09:13:25 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:25 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 9/9] rv: Test IRQ-exit softirq provenance and handoff
Date: Sat,  7 Nov 2026 18:12:52 +0100
Message-Id: <20261107171252.25090-10-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQ-exit softirq processing preserves hardirq state until it finishes. Test
the resulting hardirq-to-softirq-to-hardirq sequence, including a nested
hardirq and monitor attachment during the transition.

Boundary and tick-exit callbacks can themselves raise more softirq work.
Raise work at softirq entry, softirq exit, the final hardirq boundary, and
a full-NOHZ tick_stop event. Verify that ordinary work reaches ksoftirqd,
forced-thread timer work reaches ktimerd, and a timer-wakeup callback which
raises ordinary work gets the final ksoftirqd recheck.

Track the synthetic owner and serving-softirq interval so unrelated nested
interrupts do not corrupt the expected sequence. Reject the handoff setup
while bottom halves are blocked, attach observers before waiting for
workers, and recheck the setup with interrupts disabled.

On PREEMPT_RT, verify that worker events do not report hardirq provenance.
Do not run the synthetic inline IRQ-exit cases there. IRQ exit defers
softirqs to workers, and serving-softirq state is task-local rather than
encoded solely in preempt_count().

Snapshot reaction counts inside synthetic IRQ-disabled and hardirq
intervals, then evaluate the KUnit expectations after restoring normal task
context.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/trace/rv/monitor_irq.rst        | 125 ++++
 include/linux/interrupt.h                     |   1 +
 kernel/softirq.c                              |  15 +-
 .../rv/monitors/irqstate/irqstate_kunit.c     | 684 +++++++++++++++++-
 kernel/trace/rv/rv_monitors_test.c            |   3 +
 5 files changed, 825 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/rv/monitor_irq.rst b/Documentation/trace/rv/monitor_irq.rst
index 3e4aa819fcbbc..f1e7b3d8923a6 100644
--- a/Documentation/trace/rv/monitor_irq.rst
+++ b/Documentation/trace/rv/monitor_irq.rst
@@ -300,6 +300,131 @@ entry/exit events used by ``sts``.
      - no
      - yes
 
+KUnit scheduling coverage
+-------------------------
+
+``RV_MONITORS_KUNIT_TEST`` can be built in or as a module. The generated
+state-table and adapter cases run in either form. Tests which invoke
+non-exported generic IRQ entry/exit helpers or attach to non-exported boundary
+tracepoints require the built-in suite. A module build reports the standalone
+cases as skipped.
+
+``rv_test_irqstate_shared_actions`` emits two distinct IRQ action pairs for
+one IRQ number inside a single real ``irq_enter_rcu()``/``irq_exit_rcu()``
+boundary. Independent probes, filtered by the exact action pointers, require
+the first action to return ``IRQ_NONE`` and the second ``IRQ_HANDLED`` in the
+same order used by generic shared-IRQ dispatch. They also check hardirq and
+interrupt state, task and CPU identity, event counts, and count restoration.
+The monitor must accept the surrounding context without treating either
+action as another hardirq boundary. The test emits the action tracepoints
+directly; it does not construct an IRQ descriptor or invoke action handlers.
+
+``rv_test_irqstate_depth`` constructs every representable hardirq nesting
+level with the raw accounting helpers, then unwinds the complete stack. It
+checks the actual deepest component and restoration of the original count.
+An unmatched exit after the valid cycle must fail, so ignoring every event
+cannot satisfy the test. This is maximum valid nesting, not live counter
+overflow or physical interrupt-stack recursion.
+
+``rv_test_irqstate_depth_overflow`` fills the hardirq component to its maximum
+and then supplies the adapter with the depth value that another increment
+would wrap to. It requires exactly one reaction, no additional reaction while
+the valid stack is unwound, an unchanged NMI component, and exact restoration
+of the original preempt count. The test deliberately does not execute the
+overflowing raw increment, because that would carry into the adjacent NMI
+component. It tests rejection of wrapped boundary metadata, not live counter
+overflow.
+
+``rv_test_irqstate_sync`` resets and enables the bare adapter inside single
+and nested hardirq contexts, inside a real serving-softirq callback, and
+inside a hardirq interrupting that callback. Valid unwinding must establish
+idle without a reaction. On non-RT, it also enables between hardirq entry
+and inline softirq processing. The provenance-marked softirq pair must
+remain unsynchronized until the final hardirq exit establishes idle. A
+separate unmatched exit must then react exactly once. The softirq cases
+snapshot reactions before the invalid control, so an error on the valid
+sequence cannot replace the expected later error. These are adapter
+synchronization tests, not concurrent tracefs writes.
+
+``rv_test_irqstate_irq_exit_inline`` schedules a tasklet inside a real generic
+hardirq boundary and requires non-RT ``irq_exit_rcu()`` to process it before
+returning. Independent probes require hardirq entry, softirq entry, softirq
+exit, and final hardirq exit in that order. Both softirq events must report
+hardirq provenance. The entry callback raises a high-priority tasklet and
+requires it to run in the same interval, so entry-created work cannot be lost
+by the initial pending-bit clear. The exit callback raises another tasklet and
+requires the late ksoftirqd handoff. If the kernel diverts the original
+tasklet to ksoftirqd, for example under forced IRQ threading, the test drains
+it and skips because that configuration does not provide the inline path.
+
+``rv_test_irqstate_hardirq_exit_handoff`` raises a tasklet from the final
+hardirq-exit event. It requires the pending bit to remain set and ksoftirqd to
+be runnable before interrupts are restored. The corresponding forced-thread
+timer test raises timer work at the same event. The ktimerd wakeup callback
+then raises a tasklet. Both workers must be runnable before interrupts are
+restored, which checks the finite ksoftirqd, ktimerd, ksoftirqd closure. The
+test skips when forced IRQ threading is unavailable.
+
+``rv_test_irqstate_tick_exit_handoff`` runs on a full-NOHZ CPU and forces a
+``tick_stop`` event from the real IRQ-exit tick path. Its callback raises a
+tasklet after normal softirq processing. The test requires the final hardirq
+boundary to make ksoftirqd runnable before interrupts are restored. It skips
+when no full-NOHZ CPU is online.
+
+``rv_test_irqstate_rt_inline_bh`` forces a pending tasklet through the
+PREEMPT_RT ``local_bh_enable()`` inline-processing path. It requires the
+tasklet to finish synchronously in the enabling task, on the same CPU, while
+serving-softirq state is set and local interrupts are enabled. Independent
+boundary probes require exactly one entry before the callback and one exit
+afterward, both with local interrupts disabled and live serving state set;
+both must report no hardirq provenance. The monitor must accept the pair and
+the original counts must be restored.
+
+``rv_test_irqstate_rt_empty_worker`` uses a KUnit-only seam around the same
+PREEMPT_RT worker entry and exit helpers, without calling
+``handle_softirqs()``. It requires exactly one accepted context pair and no
+``softirq_entry`` or ``softirq_exit`` action from the synthetic owner between
+those boundaries. Both events must report no hardirq provenance. The seam
+wakes ksoftirqd while interrupts are disabled so
+pending work which races with the test remains scheduled. This
+deterministically covers the owner's no-handler interval; it does not invoke
+the smpboot predicate or prove that the current task is the real ksoftirqd
+thread.
+
+``rv_test_irqstate_rt_smpboot_empty_worker`` complements that unit seam. A
+KUnit-only flag makes the real ``ksoftirqd_should_run()`` predicate return true
+once when no work is pending. The smpboot loop then invokes
+``run_ksoftirqd()`` in the real per-CPU ksoftirqd task. The test requires the
+same empty boundary pair and accepts samples only while that forced invocation
+is active. This exercises the real predicate-to-worker path and pending-zero
+decision; it does not claim to reproduce the naturally raced pending-bit
+interleaving.
+
+Both empty-worker tests require a built-in RV KUnit suite. A modular suite
+reports them as skipped because the IRQ boundary tracepoints they attach to
+are not exported.
+
+With built-in RV KUnit tests, ``rv_test_irqexit_live`` enters the real
+``preempt_schedule_irq()`` helper with and without a task switch on one CPU.
+``rv_test_irqexit_migrate`` instead wakes a same-CPU FIFO worker which moves
+the switched-out owner to a different allowed online CPU. The test requires
+accepted entry and suspension on the source CPU and resumption and return
+on the destination. It also samples the CPU on which the helper actually
+returned, independently of the RV observer, and checks restoration of the
+owner's original affinity before the tested task exits.
+
+The two live helper cases use single-element parameter fixtures. Monitor
+slot allocation and destruction, and CPU-hotplug read locking, run in the
+suite runner, which owns the RV interface mutex. The case body and its
+cleanup can run in different KUnit threads. The tests retain a task
+reference until the observer and worker are stopped; the migration case
+checks restoration of the tested task's affinity before that task exits.
+
+The migration case skips when fewer than two allowed CPUs are online, or
+when the tests are modules: the helper is not exported. These tests exercise
+the real helper and scheduler, but invoke the helper directly. They are not
+evidence of an architecture's physical interrupt-return assembly path.
+
 Coverage limits
 ---------------
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index e1a4090596609..851d2e3769946 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -602,6 +602,7 @@ asmlinkage void __do_softirq(void);
 #if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
 void softirq_kunit_run_empty_worker(void);
 bool softirq_kunit_empty_worker_active(void);
+bool softirq_kunit_local_bh_blocked(void);
 int softirq_kunit_run_empty_ksoftirqd(struct task_struct **owner,
 				      int *owner_cpu, bool *armed);
 #endif
diff --git a/kernel/softirq.c b/kernel/softirq.c
index f6ed814f1f94a..196029a670a8a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -630,6 +630,16 @@ struct softirq_kunit_empty_worker {
 static DEFINE_PER_CPU(struct softirq_kunit_empty_worker,
 			      softirq_kunit_empty_workers);
 
+bool softirq_kunit_local_bh_blocked(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+	return local_bh_blocked();
+#else
+	return false;
+#endif
+}
+EXPORT_SYMBOL_IF_KUNIT(softirq_kunit_local_bh_blocked);
+
 /*
  * Exercise the worker boundaries without entering handle_softirqs().
  *
@@ -1038,7 +1048,10 @@ static inline void __irq_exit_rcu(void)
 
 		trace_hardirq_context_exit_tp(hardirq_count() >> HARDIRQ_SHIFT);
 
-		/* Hand work raised by the final boundary event to its worker. */
+		/*
+		 * Hand off work raised after normal softirq processing, including
+		 * by tick-exit and final-boundary callbacks.
+		 */
 		if (hardirq_count() == HARDIRQ_OFFSET) {
 			if (irq_count() == HARDIRQ_OFFSET &&
 			    unlikely(local_softirq_pending()) &&
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
index 40fe9fd4b1fb4..99bd51d72d25c 100644
--- a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
@@ -9,10 +9,13 @@
 #include <linux/kthread.h>
 #include <linux/rv.h>
 #include <linux/sched.h>
+#include <linux/tick.h>
 #include <linux/wait.h>
 #include <rv/kunit.h>
 #include <rv_trace.h>
 #include <trace/events/irq.h>
+#include <trace/events/sched.h>
+#include <trace/events/timer.h>
 
 #include "irqstate_kunit.h"
 
@@ -512,6 +515,44 @@ static void rv_test_irqstate(struct kunit *test)
 	local_irq_restore(flags);
 	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
 
+	/* PREEMPT_RT never serves softirqs from irq_exit(). */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/* Softirq processing replaces and then restores hardirq state. */
+		local_irq_save(flags);
+		__irq_enter_raw();
+		rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+		__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
+		rv_irqstate_ops.handle_softirq_entry(NULL, true, true);
+		__irq_enter_raw();
+		rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		__irq_exit_raw();
+		rv_irqstate_ops.handle_softirq_exit(NULL, true, true);
+		__preempt_count_add(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		reactions[0] = READ_ONCE(ctx->reactions);
+		__irq_exit_raw();
+		local_irq_restore(flags);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+
+		/* Provenance selects the transition which returns to hardirq. */
+		local_irq_save(flags);
+		__irq_enter_raw();
+		rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+		__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
+		reactions[0] = READ_ONCE(ctx->reactions);
+		rv_irqstate_ops.handle_softirq_entry(NULL, true, false);
+		reactions[1] = READ_ONCE(ctx->reactions);
+		__preempt_count_add(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		reactions[2] = READ_ONCE(ctx->reactions);
+		__irq_exit_raw();
+		local_irq_restore(flags);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 1);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[2], 0);
+	}
+
 	/* A second outer entry is not a nested interrupt. */
 	local_irq_save(flags);
 	__irq_enter_raw();
@@ -830,6 +871,32 @@ static void rv_test_irqstate_sync(struct kunit *test)
 		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[2], 1);
 	}
 
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/* A mid-hardirq attach ignores softirq and syncs at H-exit. */
+		local_irq_save(flags);
+		mon->enabled = 0;
+		__irq_enter_raw();
+		rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+		mon->reset();
+		mon->enabled = 1;
+		__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
+		rv_irqstate_ops.handle_softirq_entry(NULL, true, true);
+		rv_irqstate_ops.handle_softirq_exit(NULL, true, true);
+		__preempt_count_add(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		__irq_exit_raw();
+		reactions[0] = READ_ONCE(ctx->reactions);
+		__irq_enter_raw();
+		reactions[1] = READ_ONCE(ctx->reactions);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		reactions[2] = READ_ONCE(ctx->reactions);
+		__irq_exit_raw();
+		local_irq_restore(flags);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 0);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[2], 1);
+	}
+
 	expected = ctx->expected;
 	completed = run_irqstate_softirq_case(IRQSTATE_SOFTIRQ_SYNC, &rx_at_sync);
 	KUNIT_EXPECT_TRUE(test, completed);
@@ -861,20 +928,33 @@ struct irqstate_preempt_ctx {
 
 struct irqstate_inline_bh_ctx {
 	struct tasklet_struct tasklet;
+	struct tasklet_struct entry_tasklet;
 	struct tasklet_struct exit_tasklet;
 	struct task_struct *owner;
 	struct task_struct *softirqd;
 	int owner_cpu;
 	unsigned int entries;
 	unsigned int exits;
+	unsigned int hardirq_entries;
+	unsigned int hardirq_exits;
+	unsigned int event_index;
 	unsigned int tasklet_runs;
+	unsigned int nested_hardirq_runs;
+	unsigned int entry_tasklet_runs;
 	unsigned int exit_tasklet_runs;
 	bool armed;
+	bool raise_on_entry;
 	bool raise_on_exit;
+	bool inject_nested_hardirq;
+	bool expected_from_hardirq;
+	bool entry_from_hardirq;
+	bool exit_from_hardirq;
 	bool exit_tasklet_pending;
 	bool softirqd_already_runnable;
 	bool bad_boundary_context;
 	bool bad_boundary_cpu;
+	bool bad_provenance;
+	bool bad_order;
 	bool tasklet_serving;
 	bool tasklet_same_task;
 	bool tasklet_same_cpu;
@@ -883,6 +963,8 @@ struct irqstate_inline_bh_ctx {
 	bool tasklet_bracketed;
 	bool entry_attached;
 	bool exit_attached;
+	bool hardirq_entry_attached;
+	bool hardirq_exit_attached;
 };
 
 struct irqstate_empty_worker_ctx {
@@ -906,6 +988,44 @@ struct irqstate_empty_worker_ctx {
 	bool action_exit_attached;
 };
 
+struct irqstate_hardirq_exit_ctx {
+	struct tasklet_struct tasklet;
+	struct task_struct *owner;
+	struct task_struct *softirqd;
+	int owner_cpu;
+	bool armed;
+	bool callback_seen;
+	bool tasklet_pending;
+	bool softirqd_already_runnable;
+	bool bad_context;
+	bool attached;
+};
+
+#ifdef CONFIG_NO_HZ_FULL
+struct irqstate_tick_exit_ctx {
+	struct kunit *test;
+	struct tasklet_struct tasklet;
+	struct task_struct *owner;
+	struct task_struct *softirqd;
+	cpumask_t saved_mask;
+	unsigned int tick_dep_before;
+	unsigned int tick_dep_after;
+	int owner_cpu;
+	int tick_success;
+	int tick_dependency;
+	bool armed;
+	bool callback_seen;
+	bool tasklet_pending;
+	bool softirqd_already_runnable;
+	bool bad_context;
+	bool tick_attached;
+	bool tick_dep_added;
+	bool tick_dep_sampled;
+	bool affinity_changed;
+	bool hotplug_disabled;
+};
+#endif
+
 static bool irqstate_empty_worker_matches(struct irqstate_empty_worker_ctx *empty_ctx)
 {
 	/* Pairs with owner publication in both empty-worker test paths. */
@@ -916,6 +1036,39 @@ static bool irqstate_empty_worker_matches(struct irqstate_empty_worker_ctx *empt
 	return !empty_ctx->real_worker || softirq_kunit_empty_worker_active();
 }
 
+static void irqstate_inline_hardirq_entry(void *data, unsigned int depth)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx = data;
+
+	/* Inline softirq processing enables IRQs; ignore a nested real IRQ. */
+	if (!READ_ONCE(inline_ctx->armed) || current != inline_ctx->owner ||
+	    in_serving_softirq() || depth != 1)
+		return;
+	inline_ctx->hardirq_entries++;
+	if (inline_ctx->event_index != 0)
+		inline_ctx->bad_order = true;
+	inline_ctx->event_index++;
+	if (hardirq_count() != HARDIRQ_OFFSET || in_serving_softirq() ||
+	    !irqs_disabled())
+		inline_ctx->bad_boundary_context = true;
+}
+
+static void irqstate_inline_hardirq_exit(void *data, unsigned int depth)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx = data;
+
+	if (!READ_ONCE(inline_ctx->armed) || current != inline_ctx->owner ||
+	    in_serving_softirq() || depth != 1)
+		return;
+	inline_ctx->hardirq_exits++;
+	if (inline_ctx->event_index != 3)
+		inline_ctx->bad_order = true;
+	inline_ctx->event_index++;
+	if (hardirq_count() != HARDIRQ_OFFSET || in_serving_softirq() ||
+	    !irqs_disabled())
+		inline_ctx->bad_boundary_context = true;
+}
+
 static void irqstate_inline_bh_entry(void *data, bool serving,
 				     bool from_hardirq)
 {
@@ -924,10 +1077,21 @@ static void irqstate_inline_bh_entry(void *data, bool serving,
 	if (!READ_ONCE(inline_ctx->armed) || current != inline_ctx->owner)
 		return;
 	inline_ctx->entries++;
+	if (inline_ctx->event_index !=
+	    (inline_ctx->expected_from_hardirq ? 1 : 0))
+		inline_ctx->bad_order = true;
+	inline_ctx->event_index++;
+	inline_ctx->entry_from_hardirq = from_hardirq;
 	if (!serving || !in_serving_softirq() || !irqs_disabled())
 		inline_ctx->bad_boundary_context = true;
+	if (from_hardirq != inline_ctx->expected_from_hardirq)
+		inline_ctx->bad_provenance = true;
 	if (raw_smp_processor_id() != inline_ctx->owner_cpu)
 		inline_ctx->bad_boundary_cpu = true;
+	if (READ_ONCE(inline_ctx->raise_on_entry)) {
+		WRITE_ONCE(inline_ctx->raise_on_entry, false);
+		tasklet_hi_schedule(&inline_ctx->entry_tasklet);
+	}
 }
 
 static void irqstate_inline_bh_exit(void *data, bool serving,
@@ -938,8 +1102,15 @@ static void irqstate_inline_bh_exit(void *data, bool serving,
 	if (!READ_ONCE(inline_ctx->armed) || current != inline_ctx->owner)
 		return;
 	inline_ctx->exits++;
+	if (inline_ctx->event_index !=
+	    (inline_ctx->expected_from_hardirq ? 2 : 1))
+		inline_ctx->bad_order = true;
+	inline_ctx->event_index++;
+	inline_ctx->exit_from_hardirq = from_hardirq;
 	if (!serving || !in_serving_softirq() || !irqs_disabled())
 		inline_ctx->bad_boundary_context = true;
+	if (from_hardirq != inline_ctx->expected_from_hardirq)
+		inline_ctx->bad_provenance = true;
 	if (raw_smp_processor_id() != inline_ctx->owner_cpu)
 		inline_ctx->bad_boundary_cpu = true;
 	if (READ_ONCE(inline_ctx->raise_on_exit)) {
@@ -951,6 +1122,7 @@ static void irqstate_inline_bh_exit(void *data, bool serving,
 static void irqstate_inline_bh_tasklet(struct tasklet_struct *tasklet)
 {
 	struct irqstate_inline_bh_ctx *inline_ctx;
+	unsigned long flags;
 
 	inline_ctx = from_tasklet(inline_ctx, tasklet, tasklet);
 	inline_ctx->tasklet_runs++;
@@ -962,6 +1134,13 @@ static void irqstate_inline_bh_tasklet(struct tasklet_struct *tasklet)
 	inline_ctx->tasklet_in_hardirq = !!in_hardirq();
 	inline_ctx->tasklet_bracketed = inline_ctx->entries == 1 &&
 					 inline_ctx->exits == 0;
+	if (inline_ctx->inject_nested_hardirq) {
+		local_irq_save(flags);
+		irq_enter_rcu();
+		irq_exit_rcu();
+		local_irq_restore(flags);
+		inline_ctx->nested_hardirq_runs++;
+	}
 }
 
 static void irqstate_inline_bh_exit_tasklet(struct tasklet_struct *tasklet)
@@ -972,6 +1151,14 @@ static void irqstate_inline_bh_exit_tasklet(struct tasklet_struct *tasklet)
 	inline_ctx->exit_tasklet_runs++;
 }
 
+static void irqstate_inline_bh_entry_tasklet(struct tasklet_struct *tasklet)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx;
+
+	inline_ctx = from_tasklet(inline_ctx, tasklet, entry_tasklet);
+	inline_ctx->entry_tasklet_runs++;
+}
+
 static void irqstate_inline_bh_kill(void *data)
 {
 	struct irqstate_inline_bh_ctx *inline_ctx = data;
@@ -984,6 +1171,7 @@ static void irqstate_inline_bh_kill_all(void *data)
 	struct irqstate_inline_bh_ctx *inline_ctx = data;
 
 	tasklet_kill(&inline_ctx->tasklet);
+	tasklet_kill(&inline_ctx->entry_tasklet);
 	tasklet_kill(&inline_ctx->exit_tasklet);
 }
 
@@ -992,6 +1180,12 @@ static void irqstate_inline_bh_detach(void *data)
 	struct irqstate_inline_bh_ctx *inline_ctx = data;
 
 	WRITE_ONCE(inline_ctx->armed, false);
+	if (inline_ctx->hardirq_exit_attached)
+		unregister_trace_hardirq_context_exit_tp(
+			irqstate_inline_hardirq_exit, inline_ctx);
+	if (inline_ctx->hardirq_entry_attached)
+		unregister_trace_hardirq_context_entry_tp(
+			irqstate_inline_hardirq_entry, inline_ctx);
 	if (inline_ctx->entry_attached)
 		unregister_trace_softirq_context_entry_tp(irqstate_inline_bh_entry, inline_ctx);
 	if (inline_ctx->exit_attached)
@@ -999,6 +1193,444 @@ static void irqstate_inline_bh_detach(void *data)
 	tracepoint_synchronize_unregister();
 }
 
+static void irqstate_hardirq_exit_tasklet(struct tasklet_struct *tasklet)
+{
+	(void)tasklet;
+}
+
+static void irqstate_hardirq_exit_raise(void *data, unsigned int depth)
+{
+	struct irqstate_hardirq_exit_ctx *exit_ctx = data;
+
+	if (!READ_ONCE(exit_ctx->armed) || current != exit_ctx->owner)
+		return;
+	exit_ctx->callback_seen = true;
+	if (depth != 1 || hardirq_count() != HARDIRQ_OFFSET ||
+	    in_serving_softirq() || !irqs_disabled() ||
+	    raw_smp_processor_id() != exit_ctx->owner_cpu)
+		exit_ctx->bad_context = true;
+	tasklet_schedule(&exit_ctx->tasklet);
+}
+
+static void irqstate_hardirq_exit_cleanup(void *data)
+{
+	struct irqstate_hardirq_exit_ctx *exit_ctx = data;
+
+	WRITE_ONCE(exit_ctx->armed, false);
+	if (exit_ctx->attached)
+		unregister_trace_hardirq_context_exit_tp(
+			irqstate_hardirq_exit_raise, exit_ctx);
+	tracepoint_synchronize_unregister();
+	tasklet_kill(&exit_ctx->tasklet);
+}
+
+#ifdef CONFIG_NO_HZ_FULL
+static void irqstate_tick_exit_tasklet(struct tasklet_struct *tasklet)
+{
+	(void)tasklet;
+}
+
+static void irqstate_tick_exit_raise(void *data, int success, int dependency)
+{
+	struct irqstate_tick_exit_ctx *tick_ctx = data;
+
+	if (!READ_ONCE(tick_ctx->armed) ||
+	    current != READ_ONCE(tick_ctx->owner) ||
+	    READ_ONCE(tick_ctx->callback_seen))
+		return;
+
+	WRITE_ONCE(tick_ctx->callback_seen, true);
+	tick_ctx->tick_success = success;
+	tick_ctx->tick_dependency = dependency;
+	if (success || !dependency ||
+	    hardirq_count() != HARDIRQ_OFFSET ||
+	    irq_count() != HARDIRQ_OFFSET || in_serving_softirq() ||
+	    !irqs_disabled() ||
+	    raw_smp_processor_id() != tick_ctx->owner_cpu)
+		tick_ctx->bad_context = true;
+	tasklet_schedule(&tick_ctx->tasklet);
+}
+
+static void irqstate_tick_exit_restore_dep(struct irqstate_tick_exit_ctx *tick_ctx)
+{
+	if (tick_ctx->tick_dep_added) {
+		tick_dep_clear_task(tick_ctx->owner, TICK_DEP_BIT_POSIX_TIMER);
+		tick_ctx->tick_dep_added = false;
+	}
+	if (!tick_ctx->tick_dep_sampled) {
+		tick_ctx->tick_dep_after =
+			atomic_read(&tick_ctx->owner->tick_dep_mask);
+		tick_ctx->tick_dep_sampled = true;
+	}
+}
+
+static void irqstate_tick_exit_cleanup(void *data)
+{
+	struct irqstate_tick_exit_ctx *tick_ctx = data;
+	int ret;
+
+	WRITE_ONCE(tick_ctx->armed, false);
+	if (tick_ctx->tick_attached)
+		unregister_trace_tick_stop(irqstate_tick_exit_raise, tick_ctx);
+	tracepoint_synchronize_unregister();
+	irqstate_tick_exit_restore_dep(tick_ctx);
+	tasklet_kill(&tick_ctx->tasklet);
+	if (tick_ctx->affinity_changed &&
+	    !(READ_ONCE(tick_ctx->owner->flags) & PF_EXITING)) {
+		ret = set_cpus_allowed_ptr(tick_ctx->owner,
+					   &tick_ctx->saved_mask);
+		KUNIT_EXPECT_EQ(tick_ctx->test, ret, 0);
+		if (!ret)
+			tick_ctx->affinity_changed = false;
+	}
+	if (tick_ctx->hotplug_disabled) {
+		cpu_hotplug_enable();
+		tick_ctx->hotplug_disabled = false;
+	}
+	put_task_struct(tick_ctx->owner);
+	tick_ctx->owner = NULL;
+}
+#endif
+
+/* Work first raised at the final hardirq boundary must reach ksoftirqd. */
+static void rv_test_irqstate_hardirq_exit_handoff(struct kunit *test)
+{
+	struct irqstate_hardirq_exit_ctx *exit_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	const char *skip_reason = NULL;
+	unsigned long flags;
+	int ret;
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	exit_ctx = kunit_kzalloc(test, sizeof(*exit_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, exit_ctx);
+	tasklet_setup(&exit_ctx->tasklet, irqstate_hardirq_exit_tasklet);
+	ret = register_trace_hardirq_context_exit_tp(
+		irqstate_hardirq_exit_raise, exit_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	exit_ctx->attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test,
+						  irqstate_hardirq_exit_cleanup,
+						  exit_ctx));
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	migrate_disable();
+	exit_ctx->owner = current;
+	exit_ctx->owner_cpu = raw_smp_processor_id();
+	exit_ctx->softirqd = this_cpu_ksoftirqd();
+	if (!exit_ctx->softirqd || local_softirq_pending() ||
+	    softirq_kunit_local_bh_blocked() ||
+	    !wait_task_inactive(exit_ctx->softirqd, TASK_INTERRUPTIBLE)) {
+		skip_reason = "Requires an idle local ksoftirqd";
+		goto out_enable_migration;
+	}
+
+	local_irq_save(flags);
+	if (local_softirq_pending() || softirq_kunit_local_bh_blocked() ||
+	    task_is_running(exit_ctx->softirqd)) {
+		local_irq_restore(flags);
+		skip_reason = "Local ksoftirqd stopped being idle";
+		goto out_enable_migration;
+	}
+	WRITE_ONCE(exit_ctx->armed, true);
+	irq_enter_rcu();
+	irq_exit_rcu();
+	exit_ctx->tasklet_pending =
+		!!(local_softirq_pending() & BIT(TASKLET_SOFTIRQ));
+	exit_ctx->softirqd_already_runnable =
+		!wake_up_process(exit_ctx->softirqd);
+	WRITE_ONCE(exit_ctx->armed, false);
+	local_irq_restore(flags);
+
+out_enable_migration:
+	migrate_enable();
+	if (skip_reason) {
+		kunit_skip(test, "%s", skip_reason);
+		return;
+	}
+
+	kunit_release_action(test, irqstate_hardirq_exit_cleanup, exit_ctx);
+	KUNIT_EXPECT_TRUE(test, exit_ctx->callback_seen);
+	KUNIT_EXPECT_TRUE(test, exit_ctx->tasklet_pending);
+	KUNIT_EXPECT_TRUE(test, exit_ctx->softirqd_already_runnable);
+	KUNIT_EXPECT_FALSE(test, exit_ctx->bad_context);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+}
+
+#ifdef CONFIG_NO_HZ_FULL
+/* Tick-exit instrumentation must run before the final hardirq handoff. */
+static void rv_test_irqstate_tick_exit_handoff(struct kunit *test)
+{
+	struct irqstate_tick_exit_ctx *tick_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	const char *skip_reason = NULL;
+	unsigned long flags;
+	unsigned int cpu;
+	int ret;
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	tick_ctx = kunit_kzalloc(test, sizeof(*tick_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tick_ctx);
+	tick_ctx->test = test;
+	tick_ctx->owner = current;
+	get_task_struct(tick_ctx->owner);
+	tasklet_setup(&tick_ctx->tasklet, irqstate_tick_exit_tasklet);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test,
+						  irqstate_tick_exit_cleanup,
+						  tick_ctx));
+	ret = register_trace_tick_stop(irqstate_tick_exit_raise, tick_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	tick_ctx->tick_attached = true;
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	cpu_hotplug_disable();
+	tick_ctx->hotplug_disabled = true;
+	for_each_online_cpu(cpu) {
+		if (tick_nohz_full_cpu(cpu))
+			break;
+	}
+	if (cpu >= nr_cpu_ids) {
+		skip_reason = "Requires an online full-NOHZ CPU";
+		goto out;
+	}
+
+	cpumask_copy(&tick_ctx->saved_mask, current->cpus_ptr);
+	ret = set_cpus_allowed_ptr(current, cpumask_of(cpu));
+	if (ret) {
+		skip_reason = "Could not run on a full-NOHZ CPU";
+		goto out;
+	}
+	tick_ctx->affinity_changed = true;
+	if (raw_smp_processor_id() != cpu) {
+		skip_reason = "Did not migrate to the full-NOHZ CPU";
+		goto out;
+	}
+
+	tick_ctx->owner_cpu = cpu;
+	tick_ctx->softirqd = per_cpu(ksoftirqd, cpu);
+	if (!tick_ctx->softirqd ||
+	    !wait_task_inactive(tick_ctx->softirqd, TASK_INTERRUPTIBLE)) {
+		skip_reason = "Requires an idle local ksoftirqd";
+		goto out;
+	}
+
+	local_irq_save(flags);
+	if (local_softirq_pending() || softirq_kunit_local_bh_blocked() ||
+	    task_is_running(tick_ctx->softirqd)) {
+		skip_reason = "Local ksoftirqd stopped being idle";
+		goto out_restore_irqs;
+	}
+
+	tick_ctx->tick_dep_before = atomic_read(&current->tick_dep_mask);
+	if (!(tick_ctx->tick_dep_before & TICK_DEP_MASK_POSIX_TIMER)) {
+		tick_dep_set_task(current, TICK_DEP_BIT_POSIX_TIMER);
+		tick_ctx->tick_dep_added = true;
+	}
+	WRITE_ONCE(tick_ctx->armed, true);
+	irq_enter_rcu();
+	irq_exit_rcu();
+	WRITE_ONCE(tick_ctx->armed, false);
+	irqstate_tick_exit_restore_dep(tick_ctx);
+	tick_ctx->tasklet_pending =
+		!!(local_softirq_pending() & BIT(TASKLET_SOFTIRQ));
+	/* A zero return proves that the final handoff already woke the worker. */
+	tick_ctx->softirqd_already_runnable =
+		!wake_up_process(tick_ctx->softirqd);
+
+out_restore_irqs:
+	local_irq_restore(flags);
+out:
+	if (skip_reason) {
+		kunit_mark_skipped(test, "%s", skip_reason);
+		return;
+	}
+
+	kunit_release_action(test, irqstate_tick_exit_cleanup, tick_ctx);
+	KUNIT_EXPECT_TRUE(test, tick_ctx->callback_seen);
+	KUNIT_EXPECT_EQ(test, tick_ctx->tick_success, 0);
+	KUNIT_EXPECT_NE(test, tick_ctx->tick_dependency, 0);
+	KUNIT_EXPECT_EQ(test, tick_ctx->tick_dep_after,
+			tick_ctx->tick_dep_before);
+	KUNIT_EXPECT_TRUE(test, tick_ctx->tasklet_pending);
+	KUNIT_EXPECT_TRUE(test, tick_ctx->softirqd_already_runnable);
+	KUNIT_EXPECT_FALSE(test, tick_ctx->bad_context);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+}
+#else
+static void rv_test_irqstate_tick_exit_handoff(struct kunit *test)
+{
+	kunit_skip(test, "Requires full NO_HZ support");
+}
+#endif
+
+#ifdef CONFIG_IRQ_FORCED_THREADING
+struct irqstate_timer_exit_ctx {
+	struct tasklet_struct tasklet;
+	struct task_struct *owner;
+	struct task_struct *softirqd;
+	struct task_struct *timersd;
+	int owner_cpu;
+	bool armed;
+	bool callback_seen;
+	bool timer_wakeup_seen;
+	bool timer_pending;
+	bool tasklet_pending;
+	bool softirqd_already_runnable;
+	bool timersd_already_runnable;
+	bool bad_context;
+	bool hardirq_exit_attached;
+	bool sched_waking_attached;
+};
+
+static void irqstate_timer_exit_tasklet(struct tasklet_struct *tasklet)
+{
+	(void)tasklet;
+}
+
+static void irqstate_timer_exit_raise(void *data, unsigned int depth)
+{
+	struct irqstate_timer_exit_ctx *timer_ctx = data;
+
+	if (!READ_ONCE(timer_ctx->armed) || current != timer_ctx->owner)
+		return;
+	timer_ctx->callback_seen = true;
+	if (depth != 1 || hardirq_count() != HARDIRQ_OFFSET ||
+	    in_serving_softirq() || !irqs_disabled() ||
+	    raw_smp_processor_id() != timer_ctx->owner_cpu)
+		timer_ctx->bad_context = true;
+	raise_ktimers_thread(TIMER_SOFTIRQ);
+}
+
+static void irqstate_timer_sched_waking(void *data, struct task_struct *task)
+{
+	struct irqstate_timer_exit_ctx *timer_ctx = data;
+
+	if (!READ_ONCE(timer_ctx->armed) || task != timer_ctx->timersd)
+		return;
+	timer_ctx->timer_wakeup_seen = true;
+	if (current != timer_ctx->owner || !irqs_disabled() ||
+	    raw_smp_processor_id() != timer_ctx->owner_cpu)
+		timer_ctx->bad_context = true;
+	tasklet_schedule(&timer_ctx->tasklet);
+}
+
+static void irqstate_timer_exit_detach(void *data)
+{
+	struct irqstate_timer_exit_ctx *timer_ctx = data;
+
+	WRITE_ONCE(timer_ctx->armed, false);
+	if (timer_ctx->sched_waking_attached)
+		unregister_trace_sched_waking(irqstate_timer_sched_waking,
+					      timer_ctx);
+	if (timer_ctx->hardirq_exit_attached)
+		unregister_trace_hardirq_context_exit_tp(
+			irqstate_timer_exit_raise, timer_ctx);
+	tracepoint_synchronize_unregister();
+	tasklet_kill(&timer_ctx->tasklet);
+}
+
+/* Late timer-wakeup work must reach ktimerd and then ksoftirqd. */
+static void rv_test_irqstate_hardirq_exit_timer_handoff(struct kunit *test)
+{
+	struct irqstate_timer_exit_ctx *timer_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	const char *skip_reason = NULL;
+	unsigned long flags;
+	int ret;
+
+	if (!force_irqthreads()) {
+		kunit_skip(test, "Requires forced IRQ threading");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	timer_ctx = kunit_kzalloc(test, sizeof(*timer_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, timer_ctx);
+	tasklet_setup(&timer_ctx->tasklet, irqstate_timer_exit_tasklet);
+	ret = register_trace_hardirq_context_exit_tp(
+		irqstate_timer_exit_raise, timer_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	timer_ctx->hardirq_exit_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqstate_timer_exit_detach,
+						  timer_ctx));
+	ret = register_trace_sched_waking(irqstate_timer_sched_waking, timer_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	timer_ctx->sched_waking_attached = true;
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	migrate_disable();
+	timer_ctx->owner = current;
+	timer_ctx->owner_cpu = raw_smp_processor_id();
+	timer_ctx->softirqd = this_cpu_ksoftirqd();
+	timer_ctx->timersd = this_cpu_read(ktimerd);
+	if (!timer_ctx->softirqd || !timer_ctx->timersd ||
+	    local_softirq_pending() || local_timers_pending_force_th() ||
+	    softirq_kunit_local_bh_blocked() ||
+	    !wait_task_inactive(timer_ctx->softirqd, TASK_INTERRUPTIBLE) ||
+	    !wait_task_inactive(timer_ctx->timersd, TASK_INTERRUPTIBLE)) {
+		skip_reason = "Requires idle local softirq workers";
+		goto out_enable_migration;
+	}
+
+	local_irq_save(flags);
+	if (local_softirq_pending() || local_timers_pending_force_th() ||
+	    softirq_kunit_local_bh_blocked() ||
+	    task_is_running(timer_ctx->softirqd) ||
+	    task_is_running(timer_ctx->timersd)) {
+		local_irq_restore(flags);
+		skip_reason = "Local softirq worker stopped being idle";
+		goto out_enable_migration;
+	}
+	WRITE_ONCE(timer_ctx->armed, true);
+	irq_enter_rcu();
+	irq_exit_rcu();
+	timer_ctx->timer_pending =
+		!!(local_timers_pending_force_th() & BIT(TIMER_SOFTIRQ));
+	timer_ctx->tasklet_pending =
+		!!(local_softirq_pending() & BIT(TASKLET_SOFTIRQ));
+	timer_ctx->timersd_already_runnable =
+		!wake_up_process(timer_ctx->timersd);
+	timer_ctx->softirqd_already_runnable =
+		!wake_up_process(timer_ctx->softirqd);
+	WRITE_ONCE(timer_ctx->armed, false);
+	local_irq_restore(flags);
+
+out_enable_migration:
+	migrate_enable();
+	if (skip_reason) {
+		kunit_skip(test, "%s", skip_reason);
+		return;
+	}
+
+	kunit_release_action(test, irqstate_timer_exit_detach, timer_ctx);
+	KUNIT_EXPECT_TRUE(test, timer_ctx->callback_seen);
+	KUNIT_EXPECT_TRUE(test, timer_ctx->timer_wakeup_seen);
+	KUNIT_EXPECT_TRUE(test, timer_ctx->timer_pending);
+	KUNIT_EXPECT_TRUE(test, timer_ctx->tasklet_pending);
+	KUNIT_EXPECT_TRUE(test, timer_ctx->timersd_already_runnable);
+	KUNIT_EXPECT_TRUE(test, timer_ctx->softirqd_already_runnable);
+	KUNIT_EXPECT_FALSE(test, timer_ctx->bad_context);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+}
+#else
+static void rv_test_irqstate_hardirq_exit_timer_handoff(struct kunit *test)
+{
+	kunit_skip(test, "Requires forced IRQ threading");
+}
+#endif
+
 /* Exercise non-RT inline softirq processing from a real hardirq exit. */
 static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 {
@@ -1018,8 +1650,12 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 	inline_ctx = kunit_kzalloc(test, sizeof(*inline_ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, inline_ctx);
 	tasklet_setup(&inline_ctx->tasklet, irqstate_inline_bh_tasklet);
+	tasklet_setup(&inline_ctx->entry_tasklet,
+		      irqstate_inline_bh_entry_tasklet);
 	tasklet_setup(&inline_ctx->exit_tasklet,
 		      irqstate_inline_bh_exit_tasklet);
+	inline_ctx->expected_from_hardirq = true;
+	inline_ctx->inject_nested_hardirq = true;
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, irqstate_inline_bh_kill_all,
 						  inline_ctx));
@@ -1031,6 +1667,14 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, irqstate_inline_bh_detach,
 						  inline_ctx));
+	ret = register_trace_hardirq_context_entry_tp(
+		irqstate_inline_hardirq_entry, inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->hardirq_entry_attached = true;
+	ret = register_trace_hardirq_context_exit_tp(
+		irqstate_inline_hardirq_exit, inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->hardirq_exit_attached = true;
 	ret = register_trace_softirq_context_exit_tp(irqstate_inline_bh_exit,
 						     inline_ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -1065,6 +1709,7 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 		return;
 	}
 	WRITE_ONCE(inline_ctx->armed, true);
+	WRITE_ONCE(inline_ctx->raise_on_entry, true);
 	WRITE_ONCE(inline_ctx->raise_on_exit, true);
 	irq_enter_rcu();
 	tasklet_schedule(&inline_ctx->tasklet);
@@ -1090,6 +1735,8 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 	}
 
 	KUNIT_EXPECT_EQ(test, inline_ctx->tasklet_runs, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->nested_hardirq_runs, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->entry_tasklet_runs, 1U);
 	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_serving);
 	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_same_task);
 	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_same_cpu);
@@ -1101,8 +1748,15 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, inline_ctx->exit_tasklet_runs, 1U);
 	KUNIT_EXPECT_EQ(test, inline_ctx->entries, 1U);
 	KUNIT_EXPECT_EQ(test, inline_ctx->exits, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->hardirq_entries, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->hardirq_exits, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->event_index, 4U);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->entry_from_hardirq);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->exit_from_hardirq);
 	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_boundary_context);
 	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_boundary_cpu);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_provenance);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_order);
 	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
 	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
 	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
@@ -1132,6 +1786,7 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
 	inline_ctx = kunit_kzalloc(test, sizeof(*inline_ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, inline_ctx);
 	inline_ctx->owner = current;
+	inline_ctx->expected_from_hardirq = false;
 	tasklet_setup(&inline_ctx->tasklet, irqstate_inline_bh_tasklet);
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, irqstate_inline_bh_kill,
@@ -1171,8 +1826,13 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_bracketed);
 	KUNIT_EXPECT_EQ(test, inline_ctx->entries, 1U);
 	KUNIT_EXPECT_EQ(test, inline_ctx->exits, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->event_index, 2U);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->entry_from_hardirq);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->exit_from_hardirq);
 	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_boundary_context);
 	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_boundary_cpu);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_provenance);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_order);
 	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
 	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
 	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
@@ -1197,7 +1857,8 @@ static void irqstate_empty_worker_entry(void *data, bool serving,
 		empty_ctx->bad_order = true;
 	empty_ctx->event_index++;
 	empty_ctx->inside_pair = true;
-	if (!serving || !in_serving_softirq() || !irqs_disabled())
+	if (!serving || from_hardirq || !in_serving_softirq() ||
+	    !irqs_disabled())
 		empty_ctx->bad_boundary_context = true;
 	if (raw_smp_processor_id() != READ_ONCE(empty_ctx->owner_cpu))
 		empty_ctx->bad_boundary_cpu = true;
@@ -1214,7 +1875,8 @@ static void irqstate_empty_worker_exit(void *data, bool serving,
 	if (empty_ctx->event_index != 1 || !empty_ctx->inside_pair)
 		empty_ctx->bad_order = true;
 	empty_ctx->event_index++;
-	if (!serving || !in_serving_softirq() || !irqs_disabled())
+	if (!serving || from_hardirq || !in_serving_softirq() ||
+	    !irqs_disabled())
 		empty_ctx->bad_boundary_context = true;
 	if (raw_smp_processor_id() != READ_ONCE(empty_ctx->owner_cpu))
 		empty_ctx->bad_boundary_cpu = true;
@@ -1606,6 +2268,21 @@ static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
 }
 
 #else
+static void rv_test_irqstate_hardirq_exit_handoff(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqstate_tick_exit_handoff(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqstate_hardirq_exit_timer_handoff(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
 static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 {
 	kunit_skip(test, "Requires built-in RV tests");
@@ -1649,6 +2326,9 @@ static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
 #define rv_test_irqstate_depth_overflow rv_test_stub
 #define rv_test_irqstate_sync rv_test_stub
 #define rv_test_irqstate_live_toggle rv_test_stub
+#define rv_test_irqstate_hardirq_exit_handoff rv_test_stub
+#define rv_test_irqstate_tick_exit_handoff rv_test_stub
+#define rv_test_irqstate_hardirq_exit_timer_handoff rv_test_stub
 #define rv_test_irqstate_irq_exit_inline rv_test_stub
 #define rv_test_irqstate_rt_inline_bh rv_test_stub
 #define rv_test_irqstate_rt_empty_worker rv_test_stub
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index be3aaae2613a8..0b8a55d02645c 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -167,6 +167,9 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_irqstate_depth_overflow),
 	KUNIT_CASE(rv_test_irqstate_sync),
 	KUNIT_CASE(rv_test_irqstate_live_toggle),
+	KUNIT_CASE(rv_test_irqstate_hardirq_exit_handoff),
+	KUNIT_CASE(rv_test_irqstate_tick_exit_handoff),
+	KUNIT_CASE(rv_test_irqstate_hardirq_exit_timer_handoff),
 	KUNIT_CASE(rv_test_irqstate_irq_exit_inline),
 	KUNIT_CASE(rv_test_irqstate_rt_inline_bh),
 	KUNIT_CASE(rv_test_irqstate_rt_empty_worker),
-- 
2.39.5 (Apple Git-154)

