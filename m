Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645677;
	b=SHzhC286p0v9fe8ObxuQdBbSd1ceavN+do2rJZ/FnjfG2N/gh/CYfAxtCjGmlOxXIs/z
	 LrWmoT1s0yRJTED9LTRPr2xaH54TtuXKBktpWthbHHnhjXQsBRM6zfUPscuNbiR4DjZjk
	 Usz201FWah9ACO3xjrODYF0LVmzpBxPRMslh1ICbRcdvz1y0+0dhAvhZClBWsLnjNNn+I
	 okrTq3trmcq1jMVM0nA/DL9LBjptHgymMxhobc2GBa+w0D4i+xFwh5Qen8ODM9FwcxVV7
	 qev++Mq1HJVCiMjvcNhAKu6dAILrVTq7DagwrAvyoH6L74dxHYLGB0yJRhjXs3ul0Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=N6IAuRPS6MVSmy/0r8xn4KLanWBF8ABpPaslP1xDMFw=;
	b=xcXe6/olAnMkf1jFLNfUVm8l4HShYhTskymBApVsr8nLtLikV9E3GNxqwAj8Yiv3KlxZ
	 YoDE0Nu7G6Us501tPuWlWRhkuxo0uJQ+CDRTb9+EFd2FznT6p6h1L3LFtcPUDoXbydAxD
	 mm4S2cqMqYjTHNqqOLu/2LYDqXA9YEDmiovAu7Aid9CUYWfeieKmjGTis0En3eQCAvB0y
	 j/pLNGXPDMletMWrjEP3AHeZMtxAjLsuVzxeDuzyvT/zwTSjH11weI4jK6FA/KXayvnAU
	 q0jbUSZitOM7lPbzjdVrojW7kz2DmNBFDxVxM8X7aEMIsK0d6tlWSekEPC7+SHZxe9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rURPn9Zj;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3A606A32F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF3A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rURPn9Zj
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so9606615e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645675; x=1793250475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6IAuRPS6MVSmy/0r8xn4KLanWBF8ABpPaslP1xDMFw=;
        b=rURPn9Zjc8iHoGR2fSt3ScZ8zx3HYCHyoTSvaa0u6wwT/bKzlJm19z7uVAjwwff48C
         3y5ZD4c9Yel7LZ4hLkNVhKWPI9pNAE6XTjv0PQzt//B/T5spDyxPdxPxFUeik3EJb9Nt
         NpxGViXUOmm7n7ttKF55hkgOf835MNaeg1q+uljtkZ03u0EIMYemSLpzaANQKHvmBQCP
         cDURwfBAj2HKlCtQykZUZuDXVoaqvwIFYjTxlNC9EacrSv7yn4SLOBHhCghaoNHHZpu9
         l5RY97cjAodsR+zjp0lYdq3TJ9dPb/sDtFLufggdasf8Gqv91LprG6TaL6Jd3pr/u4lq
         fYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645675; x=1793250475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N6IAuRPS6MVSmy/0r8xn4KLanWBF8ABpPaslP1xDMFw=;
        b=ys6PW5S1zM6A7P/UcHU3H86n0QCnuw7HdBUh8oFV97O3VnwFHV83AePTsbwj+hqFhi
         Nphv9UazxtQzNLznSMEjam6eLdwlmtTuaWgsNgXeLF/lsbfVI79TKW5gErOGwi9DrRFF
         Lu6tU+ZqwJ9mejFripza8KJVVMofGGphWCtFUSMRzpftjxt8vQZp+eoo+NhkKWxEi6+D
         K1zd9Q60+3I0EvD/J0thxR75IxMVdAhNFCtPyQw/WIbhBEa/HTXgNM4sQMyZRyF4bAYf
         qBKytFnZIQOw6bVwN0+J4v+inmsS+we7ytTxCLEvSgF40HJAKIWo/qNh7VRbpTMvftus
         zDsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVb+uykiFxaH6llQTPpTpY/mshpyMYTUW9dmW4oHN0EwcIhCFlFstTiA85a2n74HDsyp7y8SFktveznnTAcJjdCRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLH23AXMeLxqQJMHAU67LSqxgYI6Ixy8gRA7FeT4S/v+xZSL8oZ
	Bz/mNXIjRrLEMTfNyWkU5GmwaCNzbc7DL8tyFs1dImTI6j2KTvLyY7Qg
X-Gm-Gg: AYBFou2e3/AlTQq1f2C56hLq0IIuGh1nL7W/4tJgoAjyxhwS1GygWLkH7lfW5SlbUWb
	OzMFvYLKG57dUDi5yXejvBEfS38CCpUzHpjcHi9xQR495W+nLZVwgkyekpM1jo5GLdQoFZhDEIB
	HaO2KPRr5CdB0eoLJgHN21WIIsRoA/Nu9HJ9fnP0k+wclz/1aPdDB+15Q5vdFUC8DPqvJxAIryG
	NAf5eOlWxuzgMt+itmJkSOlD2zrc1Ci1ZxfdAsQTGxIbjMV3fY6aYk6BbSmgKckILcHtadyQj5G
	FjThRQEUhoNz0Ub5Bg88/bCJ1w7lvEYnWbNzUgOS6ZO85M+QRmeAkr/VejiEKLv9VTnNNSJmb+T
	BPtTV2/7BMlS+v0bhYVA5wC/lhQYI/3yL9KnSt+XhoAUmRfgqYqdnLUWQUMj+Rgzj4y/Db7FHgm
	WCPBBeUWIv3k6hqn05UG7ixb019HgvF+PxGBAHJwFMepsLD84/MJ2iFL9qZxQQnpL243m7iqNJM
	g4/I23t6b5SKoUXOjlr4J0jdAbM4aPtJ2HMlyasYiY69aGnNuCaEG5msKn44N5OazrNPvfcU0bD
	w3YVfN8kSys7vLKV0TR9u4zH0XLZyNwPwMJCxhAF+TUT27N8/09rrtH1wPkPvPJ/rRAfA9eD0wf
	7BuLaQCgjJzAzy6n7r7tw/BEVzC9HZprm2llVeecAUdXrvC24UvQeOhmq9oM=
X-Received: by 2002:a05:600c:3492:b0:4a1:e4c4:f6a9 with SMTP id 5b1f17b1804b1-4a1fdd3d479mr83134855e9.23.1792645675020;
        Wed, 21 Oct 2026 22:07:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:54 -0700 (PDT)
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
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/9] rv: Test empty PREEMPT_RT softirq worker intervals
Date: Thu, 22 Oct 2026 07:07:11 +0200
Message-Id: <20261022050712.75035-9-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
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

On PREEMPT_RT, a worker enters serving-softirq state before checking for
pending work and leaves that state afterward. A worker with no pending
work therefore creates a valid interval that action-based tests miss.

Add KUnit-only helpers that exercise the worker boundaries directly and
force the per-CPU ksoftirqd task through one invocation with no pending
softirqs. Preserve work that races with the test seam. Verify that each
path emits one context pair without an intervening softirq action.

Gate the seam's predicate and worker branches with the existing
kunit_running static key. Outside a KUnit run, both added checks take only
the disabled static-key path.

Both tests attach to non-exported IRQ boundary tracepoints. Run them only
when the RV KUnit suite is built in and report them as skipped when it is a
module.

Assisted-by: LLM
---
 Documentation/trace/rv/monitor_irqentry.rst   |  23 ++
 include/linux/interrupt.h                     |   7 +
 kernel/softirq.c                              | 225 ++++++++++++++++-
 .../rv/monitors/irqstate/irqstate_kunit.c     | 239 ++++++++++++++++++
 kernel/trace/rv/rv_monitors_test.c            |   2 +
 5 files changed, 495 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/rv/monitor_irqentry.rst b/Documentation/trace/rv/monitor_irqentry.rst
index f4cd34c1b6bf1..c2b7739a061f0 100644
--- a/Documentation/trace/rv/monitor_irqentry.rst
+++ b/Documentation/trace/rv/monitor_irqentry.rst
@@ -292,6 +292,29 @@ boundary probes require exactly one entry before the callback and one exit
 afterward, both with local interrupts disabled and live serving state set;
 the monitor must accept the pair and the original counts must be restored.
 
+``rv_test_irqstate_rt_empty_worker`` uses a KUnit-only seam around the same
+PREEMPT_RT worker entry and exit helpers, without calling
+``handle_softirqs()``. It requires exactly one accepted context pair and no
+``softirq_entry`` or ``softirq_exit`` action from the synthetic owner between
+those boundaries. The seam wakes ksoftirqd while interrupts are disabled so
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
 With built-in RV KUnit tests, ``rv_test_irqexit_live`` enters the real
 ``preempt_schedule_irq()`` helper with and without a task switch on one CPU.
 ``rv_test_irqexit_migrate`` instead wakes a same-CPU FIFO worker which moves
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe07..f268e025921c1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -595,6 +595,13 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+void softirq_kunit_run_empty_worker(void);
+bool softirq_kunit_empty_worker_active(void);
+int softirq_kunit_run_empty_ksoftirqd(struct task_struct **owner,
+				      int *owner_cpu, bool *armed);
+#endif
+
 #ifdef CONFIG_PREEMPT_RT
 extern void do_softirq_post_smp_call_flush(unsigned int was_pending);
 #else
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2e3b6fd3f6d5d..e85bd3b81e779 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -10,6 +10,9 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #define INSTANTIATE_EXPORTED_INTERRUPT_DISABLE
+#include <kunit/test-bug.h>
+#include <kunit/visibility.h>
+#include <linux/completion.h>
 #include <linux/export.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
@@ -609,6 +612,187 @@ asmlinkage __visible void do_softirq(void)
 
 #endif /* !CONFIG_PREEMPT_RT */
 
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+enum softirq_kunit_empty_worker_phase {
+	SOFTIRQ_KUNIT_EMPTY_IDLE,
+	SOFTIRQ_KUNIT_EMPTY_PREPARING,
+	SOFTIRQ_KUNIT_EMPTY_ARMED,
+	SOFTIRQ_KUNIT_EMPTY_RUNNING,
+	SOFTIRQ_KUNIT_EMPTY_DONE,
+};
+
+struct softirq_kunit_empty_worker {
+	atomic_t phase;
+	struct completion done;
+	u32 held_pending;
+};
+
+static DEFINE_PER_CPU(struct softirq_kunit_empty_worker,
+			      softirq_kunit_empty_workers);
+
+/*
+ * Exercise the worker boundaries without entering handle_softirqs().
+ *
+ * The caller must be in preemptible task context with interrupts enabled and
+ * no active softirq context. Like run_ksoftirqd(), this returns with local
+ * interrupts enabled.
+ */
+void softirq_kunit_run_empty_worker(void)
+{
+	ksoftirqd_run_begin();
+	/* Preserve any pending work which raced with the test seam. */
+	wakeup_softirqd();
+	ksoftirqd_run_end();
+}
+EXPORT_SYMBOL_IF_KUNIT(softirq_kunit_run_empty_worker);
+
+bool softirq_kunit_empty_worker_active(void)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	worker = raw_cpu_ptr(&softirq_kunit_empty_workers);
+	return atomic_read(&worker->phase) == SOFTIRQ_KUNIT_EMPTY_RUNNING &&
+	       current == raw_cpu_read(ksoftirqd);
+}
+EXPORT_SYMBOL_IF_KUNIT(softirq_kunit_empty_worker_active);
+
+/*
+ * Force one real ksoftirqd invocation after its smpboot predicate observes
+ * no pending work. The run itself still uses run_ksoftirqd(). The caller must
+ * hold the CPU hotplug read lock across this call so the selected CPU and its
+ * ksoftirqd remain online. The returned task pointer carries no reference.
+ */
+int softirq_kunit_run_empty_ksoftirqd(struct task_struct **owner,
+				      int *owner_cpu, bool *armed)
+{
+	struct softirq_kunit_empty_worker *worker;
+	struct task_struct *tsk;
+	unsigned long completed;
+	int this_cpu, phase, ret;
+
+	if (!owner || !owner_cpu || !armed)
+		return -EINVAL;
+	WRITE_ONCE(*owner, NULL);
+	WRITE_ONCE(*owner_cpu, -1);
+	WRITE_ONCE(*armed, false);
+
+	lockdep_assert_cpus_held();
+	this_cpu = get_cpu();
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	if (atomic_cmpxchg(&worker->phase, SOFTIRQ_KUNIT_EMPTY_IDLE,
+			   SOFTIRQ_KUNIT_EMPTY_PREPARING) !=
+	    SOFTIRQ_KUNIT_EMPTY_IDLE) {
+		put_cpu();
+		return -EBUSY;
+	}
+
+	tsk = __this_cpu_read(ksoftirqd);
+	if (!tsk) {
+		atomic_set(&worker->phase, SOFTIRQ_KUNIT_EMPTY_IDLE);
+		put_cpu();
+		return -ENODEV;
+	}
+
+	init_completion(&worker->done);
+	worker->held_pending = 0;
+	WRITE_ONCE(*owner_cpu, this_cpu);
+	WRITE_ONCE(*owner, tsk);
+	/* Publish the owner before globally registered callbacks can match it. */
+	smp_store_release(armed, true);
+	atomic_set(&worker->phase, SOFTIRQ_KUNIT_EMPTY_ARMED);
+	wake_up_process(tsk);
+	put_cpu();
+
+	completed = wait_for_completion_timeout(&worker->done, 5 * HZ);
+	if (!completed) {
+		phase = atomic_cmpxchg(&worker->phase,
+				       SOFTIRQ_KUNIT_EMPTY_ARMED,
+				       SOFTIRQ_KUNIT_EMPTY_IDLE);
+		if (phase == SOFTIRQ_KUNIT_EMPTY_ARMED) {
+			ret = -ETIMEDOUT;
+			goto out_disarm;
+		}
+
+		/*
+		 * Once the predicate has claimed the request, synchronize with
+		 * complete() before making the completion reusable. CPU hotplug
+		 * remains excluded by the caller while this helper runs. RT lock
+		 * contention can delay the worker after it claims the request, so
+		 * wait for it to finish.
+		 */
+		if (phase != SOFTIRQ_KUNIT_EMPTY_RUNNING &&
+		    phase != SOFTIRQ_KUNIT_EMPTY_DONE) {
+			ret = -EIO;
+			goto out_disarm;
+		}
+		wait_for_completion(&worker->done);
+		phase = atomic_cmpxchg(&worker->phase,
+				       SOFTIRQ_KUNIT_EMPTY_DONE,
+				       SOFTIRQ_KUNIT_EMPTY_IDLE);
+		ret = phase == SOFTIRQ_KUNIT_EMPTY_DONE ? -ETIMEDOUT : -EIO;
+		goto out_disarm;
+	}
+
+	phase = atomic_cmpxchg(&worker->phase, SOFTIRQ_KUNIT_EMPTY_DONE,
+			       SOFTIRQ_KUNIT_EMPTY_IDLE);
+	ret = phase == SOFTIRQ_KUNIT_EMPTY_DONE ? 0 : -EIO;
+
+out_disarm:
+	WRITE_ONCE(*armed, false);
+	return ret;
+}
+EXPORT_SYMBOL_IF_KUNIT(softirq_kunit_run_empty_ksoftirqd);
+
+static bool softirq_kunit_force_empty_ksoftirqd(void)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	return current == __this_cpu_read(ksoftirqd) &&
+	       atomic_cmpxchg(&worker->phase, SOFTIRQ_KUNIT_EMPTY_ARMED,
+			      SOFTIRQ_KUNIT_EMPTY_RUNNING) ==
+			      SOFTIRQ_KUNIT_EMPTY_ARMED;
+}
+
+static bool softirq_kunit_begin_empty_ksoftirqd(void)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	if (atomic_read(&worker->phase) != SOFTIRQ_KUNIT_EMPTY_RUNNING)
+		return false;
+
+	worker->held_pending = local_softirq_pending();
+	set_softirq_pending(0);
+	return true;
+}
+
+static void softirq_kunit_restore_empty_ksoftirqd(bool active)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	if (!active)
+		return;
+
+	lockdep_assert_irqs_disabled();
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	or_softirq_pending(worker->held_pending);
+	worker->held_pending = 0;
+}
+
+static void softirq_kunit_finish_empty_ksoftirqd(bool active)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	if (!active)
+		return;
+
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	atomic_set(&worker->phase, SOFTIRQ_KUNIT_EMPTY_DONE);
+	complete(&worker->done);
+}
+#endif
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -1198,11 +1382,50 @@ void __init softirq_init(void)
 
 static int ksoftirqd_should_run(unsigned int cpu)
 {
-	return local_softirq_pending();
+	unsigned int pending = local_softirq_pending();
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+	if (!pending && static_branch_unlikely(&kunit_running) &&
+	    softirq_kunit_force_empty_ksoftirqd())
+		return 1;
+#endif
+	return pending;
 }
 
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+static void softirq_kunit_run_ksoftirqd(unsigned int cpu)
+{
+	bool kunit_empty;
+
+	ksoftirqd_run_begin();
+	kunit_empty = softirq_kunit_begin_empty_ksoftirqd();
+	if (local_softirq_pending()) {
+		/*
+		 * We can safely run softirq on inline stack, as we are not deep
+		 * in the task stack here.
+		 */
+		handle_softirqs(true);
+		softirq_kunit_restore_empty_ksoftirqd(kunit_empty);
+		ksoftirqd_run_end();
+		softirq_kunit_finish_empty_ksoftirqd(kunit_empty);
+		cond_resched();
+	} else {
+		softirq_kunit_restore_empty_ksoftirqd(kunit_empty);
+		ksoftirqd_run_end();
+		softirq_kunit_finish_empty_ksoftirqd(kunit_empty);
+	}
+}
+#endif
+
 static void run_ksoftirqd(unsigned int cpu)
 {
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+	if (static_branch_unlikely(&kunit_running)) {
+		softirq_kunit_run_ksoftirqd(cpu);
+		return;
+	}
+#endif
+
 	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
 		/*
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
index c5b8834fea3d9..e3928d10b2825 100644
--- a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
@@ -862,6 +862,37 @@ struct irqstate_inline_bh_ctx {
 	bool exit_attached;
 };
 
+struct irqstate_empty_worker_ctx {
+	struct task_struct *owner;
+	int owner_cpu;
+	unsigned int entries;
+	unsigned int exits;
+	unsigned int action_entries;
+	unsigned int action_exits;
+	unsigned int event_index;
+	bool armed;
+	bool real_worker;
+	bool inside_pair;
+	bool bad_order;
+	bool bad_boundary_context;
+	bool bad_boundary_cpu;
+	bool actions_at_exit;
+	bool entry_attached;
+	bool exit_attached;
+	bool action_entry_attached;
+	bool action_exit_attached;
+};
+
+static bool irqstate_empty_worker_matches(struct irqstate_empty_worker_ctx *empty_ctx)
+{
+	/* Pairs with owner publication in both empty-worker test paths. */
+	if (!smp_load_acquire(&empty_ctx->armed) ||
+	    current != READ_ONCE(empty_ctx->owner))
+		return false;
+
+	return !empty_ctx->real_worker || softirq_kunit_empty_worker_active();
+}
+
 static void irqstate_inline_bh_entry(void *data, bool serving,
 				     bool from_hardirq)
 {
@@ -1127,6 +1158,202 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
 		   softirq_count() == saved_softirq);
 }
 
+static void irqstate_empty_worker_entry(void *data, bool serving,
+					bool from_hardirq)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	if (!irqstate_empty_worker_matches(empty_ctx))
+		return;
+	empty_ctx->entries++;
+	if (empty_ctx->event_index != 0 || empty_ctx->inside_pair)
+		empty_ctx->bad_order = true;
+	empty_ctx->event_index++;
+	empty_ctx->inside_pair = true;
+	if (!serving || !in_serving_softirq() || !irqs_disabled())
+		empty_ctx->bad_boundary_context = true;
+	if (raw_smp_processor_id() != READ_ONCE(empty_ctx->owner_cpu))
+		empty_ctx->bad_boundary_cpu = true;
+}
+
+static void irqstate_empty_worker_exit(void *data, bool serving,
+				       bool from_hardirq)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	if (!irqstate_empty_worker_matches(empty_ctx))
+		return;
+	empty_ctx->exits++;
+	if (empty_ctx->event_index != 1 || !empty_ctx->inside_pair)
+		empty_ctx->bad_order = true;
+	empty_ctx->event_index++;
+	if (!serving || !in_serving_softirq() || !irqs_disabled())
+		empty_ctx->bad_boundary_context = true;
+	if (raw_smp_processor_id() != READ_ONCE(empty_ctx->owner_cpu))
+		empty_ctx->bad_boundary_cpu = true;
+	empty_ctx->actions_at_exit = empty_ctx->action_entries ||
+				     empty_ctx->action_exits;
+	empty_ctx->inside_pair = false;
+}
+
+static void irqstate_empty_worker_action_entry(void *data, unsigned int vec_nr)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	if (!irqstate_empty_worker_matches(empty_ctx) ||
+	    !empty_ctx->inside_pair)
+		return;
+	(void)vec_nr;
+	empty_ctx->action_entries++;
+	if (raw_smp_processor_id() != empty_ctx->owner_cpu)
+		empty_ctx->bad_boundary_cpu = true;
+}
+
+static void irqstate_empty_worker_action_exit(void *data, unsigned int vec_nr)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	if (!irqstate_empty_worker_matches(empty_ctx) ||
+	    !empty_ctx->inside_pair)
+		return;
+	(void)vec_nr;
+	empty_ctx->action_exits++;
+	if (raw_smp_processor_id() != empty_ctx->owner_cpu)
+		empty_ctx->bad_boundary_cpu = true;
+}
+
+static void irqstate_empty_worker_detach(void *data)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	WRITE_ONCE(empty_ctx->armed, false);
+	if (empty_ctx->action_exit_attached)
+		unregister_trace_softirq_exit(irqstate_empty_worker_action_exit,
+					      empty_ctx);
+	if (empty_ctx->action_entry_attached)
+		unregister_trace_softirq_entry(irqstate_empty_worker_action_entry,
+					       empty_ctx);
+	if (empty_ctx->exit_attached)
+		unregister_trace_softirq_context_exit(irqstate_empty_worker_exit,
+						      empty_ctx);
+	if (empty_ctx->entry_attached)
+		unregister_trace_softirq_context_entry(irqstate_empty_worker_entry,
+						       empty_ctx);
+	tracepoint_synchronize_unregister();
+}
+
+static void run_irqstate_rt_empty_worker(struct kunit *test, bool real_worker)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned int saved_count, saved_softirq;
+	bool order_ok, restored;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires RT worker serving boundaries");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	empty_ctx = kunit_kzalloc(test, sizeof(*empty_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, empty_ctx);
+	empty_ctx->real_worker = real_worker;
+
+	ret = register_trace_softirq_context_entry(irqstate_empty_worker_entry,
+						   empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->entry_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test,
+						  irqstate_empty_worker_detach,
+						  empty_ctx));
+	ret = register_trace_softirq_context_exit(irqstate_empty_worker_exit,
+						  empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->exit_attached = true;
+	ret = register_trace_softirq_entry(irqstate_empty_worker_action_entry,
+					   empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->action_entry_attached = true;
+	ret = register_trace_softirq_exit(irqstate_empty_worker_action_exit,
+					  empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->action_exit_attached = true;
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	KUNIT_ASSERT_TRUE(test, preemptible());
+	KUNIT_ASSERT_FALSE(test, irqs_disabled());
+	KUNIT_ASSERT_EQ(test, softirq_count(), 0U);
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+	if (real_worker) {
+		cpus_read_lock();
+		ret = softirq_kunit_run_empty_ksoftirqd(&empty_ctx->owner,
+							&empty_ctx->owner_cpu,
+							&empty_ctx->armed);
+		cpus_read_unlock();
+	} else {
+		migrate_disable();
+		WRITE_ONCE(empty_ctx->owner_cpu, smp_processor_id());
+		WRITE_ONCE(empty_ctx->owner, current);
+		/* Publish the owner before globally registered callbacks match it. */
+		smp_store_release(&empty_ctx->armed, true);
+		softirq_kunit_run_empty_worker();
+		WRITE_ONCE(empty_ctx->armed, false);
+		migrate_enable();
+		ret = 0;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, empty_ctx->owner);
+
+	order_ok = empty_ctx->event_index == 2 && !empty_ctx->inside_pair &&
+		   !empty_ctx->bad_order;
+	restored = preempt_count() == saved_count &&
+		   softirq_count() == saved_softirq && !irqs_disabled();
+	KUNIT_EXPECT_EQ(test, empty_ctx->entries, 1U);
+	KUNIT_EXPECT_EQ(test, empty_ctx->exits, 1U);
+	KUNIT_EXPECT_EQ(test, empty_ctx->action_entries, 0U);
+	KUNIT_EXPECT_EQ(test, empty_ctx->action_exits, 0U);
+	KUNIT_EXPECT_TRUE(test, order_ok);
+	KUNIT_EXPECT_FALSE(test, empty_ctx->bad_boundary_context);
+	KUNIT_EXPECT_FALSE(test, empty_ctx->bad_boundary_cpu);
+	KUNIT_EXPECT_FALSE(test, empty_ctx->actions_at_exit);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	KUNIT_EXPECT_FALSE(test, irqs_disabled());
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	if (real_worker)
+		kunit_info(test,
+			   "RT smpboot empty worker events=%u/%u actions=%u/%u order=%u serving=%u same_cpu=%u restored=%u\n",
+			   empty_ctx->entries, empty_ctx->exits,
+			   empty_ctx->action_entries, empty_ctx->action_exits,
+			   order_ok, !empty_ctx->bad_boundary_context,
+			   !empty_ctx->bad_boundary_cpu, restored);
+	else
+		kunit_info(test,
+			   "RT empty worker events=%u/%u actions=%u/%u order=%u serving=%u same_cpu=%u restored=%u\n",
+			   empty_ctx->entries, empty_ctx->exits,
+			   empty_ctx->action_entries, empty_ctx->action_exits,
+			   order_ok, !empty_ctx->bad_boundary_context,
+			   !empty_ctx->bad_boundary_cpu, restored);
+}
+
+/* Exercise an RT worker interval which executes no softirq action. */
+static void rv_test_irqstate_rt_empty_worker(struct kunit *test)
+{
+	run_irqstate_rt_empty_worker(test, false);
+}
+
+/* Exercise the real ksoftirqd task and its smpboot predicate. */
+static void rv_test_irqstate_rt_smpboot_empty_worker(struct kunit *test)
+{
+	run_irqstate_rt_empty_worker(test, true);
+}
+
 static int irqstate_preempt_worker(void *arg)
 {
 	struct irqstate_preempt_ctx *preempt_ctx = arg;
@@ -1353,6 +1580,16 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
 	kunit_skip(test, "Requires built-in RV tests");
 }
 
+static void rv_test_irqstate_rt_empty_worker(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqstate_rt_smpboot_empty_worker(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
 static void rv_test_irqstate_preempt(struct kunit *test)
 {
 	kunit_skip(test, "Requires built-in RV tests");
@@ -1378,6 +1615,8 @@ static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
 #define rv_test_irqstate_live_toggle rv_test_stub
 #define rv_test_irqstate_irq_exit_inline rv_test_stub
 #define rv_test_irqstate_rt_inline_bh rv_test_stub
+#define rv_test_irqstate_rt_empty_worker rv_test_stub
+#define rv_test_irqstate_rt_smpboot_empty_worker rv_test_stub
 #define rv_test_irqstate_preempt rv_test_stub
 #define rv_test_irqstate_rt_prepare_irq rv_test_stub
 #define rv_test_irqstate_rt_prepare_switch rv_test_stub
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 9eb37cbd2de22..be3aaae2613a8 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -169,6 +169,8 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_irqstate_live_toggle),
 	KUNIT_CASE(rv_test_irqstate_irq_exit_inline),
 	KUNIT_CASE(rv_test_irqstate_rt_inline_bh),
+	KUNIT_CASE(rv_test_irqstate_rt_empty_worker),
+	KUNIT_CASE(rv_test_irqstate_rt_smpboot_empty_worker),
 	KUNIT_CASE(rv_test_irqstate_preempt),
 	KUNIT_CASE(rv_test_irqstate_rt_prepare_irq),
 	KUNIT_CASE(rv_test_irqstate_rt_prepare_switch),
-- 
2.39.5 (Apple Git-154)

