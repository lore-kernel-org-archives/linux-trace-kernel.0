Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071606;
	b=bVh+Iu7d3ydNSUv5Znbk7bwyMrwvPEbGyTaEW5XyIxCQJ8JhFYzGv2ePliCPXGypmKWM
	 tucVe+L76Fi+1FiH8Fd87u8QdS7aiHJKZKTMBXj+u+RA+N+j3uQM4CUsfCC72Ew9n5SY0
	 JfjGe9rA2DhtH/keAWU6wiCiDBiGhCe4l3dA3gdO+vGiKO8BWhqZCIFnfgafZcd0F8ktO
	 CfYsVTfND1e3R16pCxN/whgwmKtTmYBP3ZPw5przZ6q8EMJhfvji3jl891d9UnxvvNjdf
	 7EJcivWG7O00ca86GquaA/smPZZDpAEngRtwHSTvfxXZELMD6seQ+G3Wwo+ojJ3njzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cY4Zdp30rnyBf+8O7w9bEit8iyPlxVfUdM89VX78//0=;
	b=nKzedBxEOtF3DAg4m2MDhswfZQ5OP9yrkJL/tqBED+VMfSWseUARPF01zNoH143MOeP+
	 EC7KrtDsk3uACiOtX0anKD+Okwj14AGBIywGWbEXYtOmj29hp5D0EmTTAyFt30n35zhOd
	 ufiI2bhqquQ+z6Cpu8jiN/yI3kXw9rJmcyr9kyrcvV0vdm+zGWEDHMBSYdasG/Kmb+M8n
	 Of76xYYDIQd82bviRoYBTupNAeGSBoRSvvbpH3pHVCbd2gtGOr+C6a9K4okHUG3NEuiS0
	 cvqjDw0sgWF3C7axiwBZcRBfHiY6Hk+BOoZaPG2b6PD7oEvWQNdAJkgDyc5lksiZoVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k69LAPlm;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDD606EEB1
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 17:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3FDD606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k69LAPlm
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4922523d1afso921837f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 09:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071604; x=1794676404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cY4Zdp30rnyBf+8O7w9bEit8iyPlxVfUdM89VX78//0=;
        b=k69LAPlmtwCdqSew5tVKEDP395+TnZiRgMjw6tmhd5ZFxqvdaGo+N0JPdLmgAWwLWq
         baVAZLpIN1lo0S/qjtKF1bVEuQ+47nfziFPBHQCzXYVrlbBbU+ivQoJCRLXz1p01grFt
         hK4qhM+dpt0NoahWaeN+CPqqsHVzzIULUKXUDaQBWcg9wZIcobj57A9D56KzH5+VQL3C
         v2FHqbhATDcLCMHkdQWnnXOWeDW4eHK8Z9Z9ISy0W68SgPX1plNqbAhHT6ID96r5yEcS
         isD13xDxLIZ9c5wTkKW7xRj3v8z0mobQvigHUW+1fyQb0tTyBXjCkQzAA7hfewb/QeqE
         aZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071604; x=1794676404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cY4Zdp30rnyBf+8O7w9bEit8iyPlxVfUdM89VX78//0=;
        b=ARYDAk6peKlWNWdkQViqbusOOJI9qYcuVg/90LcGmK/4hCwvvhZbItJunfaMTNLOaI
         FcV5/YXTzZhQmqBD9wmBAvUmCxAg+5bTLkIaS7gtoMsa4WUM+GFQ5hHvWpHt8DQfy17j
         T2OyKkLib0u0j72sr8+Jh2+MqBdoBT9uL62Ep2i1L2YyZbi9KmdzmfaxJl+mLJdOmKi5
         aWoLzKfJNsbsUMg+QLPpJBTSMSjARPXs2nEuq0wbSxqpnGK+nj1vGMvSi/Zr/l4TRequ
         n//qKQdHxqXcOxfzljQA49o8noFyTgb39eLHiAuXGG8O6LuVIPT0s1f6AHfoClTRG35z
         MjFw==
X-Forwarded-Encrypted: i=1; AL+hErFoHqWv0VMcJN/8AX+o5LnKB586MTE4dtPt6MggPtZ3io+TJANgJbe3hsG1x287vNSXbZiqMieqBtpWq4pjRsxF4a8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AVnVmwu+6bBhlH+wKuCl+Kc3fpde9WIhxKuoFdRSfXYUhX0k3
	QDzXvqbma+G24kNx60KfmmJgsxzSP8Y5qf+sz5IVJz2vVgz+jhTVLXxN
X-Gm-Gg: AYBFou0TxINeRK7fHa6f2DvuoWsf0BZD2MeIZ3MHUB1xRlMDbS3JpaVBhhChDhAMgOd
	QGHsJ14zDMdMoegl4YQ55roB23QzZxpZPBGuBeqOaEUYqcDvNGfaBHMLPPiSS4xSu19cHOW3bY7
	piARywgEcQr2+zP9P4N2dpc2Bm9xhEw+STOeIg/CoTOKG+Z7r+RLWbRrrLiERcyrH5KFZ+oYSVi
	uKEDFMNQPdMtP2w8YWqTgx9A5a2exMIgCU80oNnKXdsnLz2xA5QjLT1Qkl0aJ3hC8XH6jqeIUaM
	3kxruDutd+1YsqH4I5YDAMfYVh1lwy6JtKDJjDnEbEoZCls3QKD0i77+Cq1rdgHpC+TP+Y00t3c
	QhWNGSsddcXdQsVF3rRQs1i8es9MBXA3731coeasIBLo9g8dC5Phpo6F5GysQYcZOlT5DC2w0G4
	+LfHNwJwZ3nU4PsXd8DSk+bjxQuUA77iN4gx6xzcG2V/5c5JXTUcYB97vcjWEdIsuMEbHeKjeZT
	oF9sM6/64jOrLZ9UVyYNatOyWaiQHGrdaV6685rbmNpUyH9Q2FGdbCoLOSSI2vz8aaf97pRszSP
	kvkdGTVAtdiuqqb/n4JwZlSI62pawGBTyG0hJPoOAmxAB7NSGPcDvGbwYS8AzZttOzdoM8N3e2r
	MOaYkc4oWfTQZ9s64JCg7SdusamAX8pYhqsDGw+aX3sPWFEpvUVSB81QV/XGVqqGwO0Wqfm8zBL
	Hd90oRi8XChP4mm5+adIuWphsTEXEj8gc=
X-Received: by 2002:a05:6000:288c:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-49277218ba7mr12062781f8f.22.1794071604037;
        Sat, 07 Nov 2026 09:13:24 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:23 -0800 (PST)
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
Subject: [RFC PATCH v2 8/9] rv: Test empty PREEMPT_RT softirq worker intervals
Date: Sat,  7 Nov 2026 18:12:51 +0100
Message-Id: <20261107171252.25090-9-kmehltretter@gmail.com>
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

On PREEMPT_RT, a worker enters serving-softirq state before it checks for
pending work and leaves that state afterward. A worker with no pending
action therefore creates a valid interval that action-based tests miss.

Add KUnit-only helpers that exercise the worker boundaries directly and
force the real per-CPU ksoftirqd task through one invocation with no
pending softirqs. Preserve pending work that races with the test seam.
Verify that each path emits one context pair without an intervening softirq
action.

Keep the seam inactive outside KUnit tests. Gate its predicate and worker
branches with the existing kunit_running static key, and isolate the test
bookkeeping in a helper. Outside a KUnit run, both added worker checks take
only the disabled static-key path.

When another KUnit suite enables the global static key, check the per-CPU
phase before trying the atomic compare-exchange. Keep the compare-exchange
as the arbiter between the worker claim and timeout disarm.

Both tests attach to non-exported IRQ boundary tracepoints. Run them only
when the RV KUnit suite is built in and report them as skipped when it is a
module.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/interrupt.h                     |   7 +
 kernel/softirq.c                              | 228 ++++++++++++++++-
 kernel/trace/rv/Kconfig                       |   6 +-
 .../rv/monitors/irqstate/irqstate_kunit.c     | 239 ++++++++++++++++++
 kernel/trace/rv/rv_monitors_test.c            |   2 +
 5 files changed, 479 insertions(+), 3 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee2dd5349697d..e1a4090596609 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -599,6 +599,13 @@ struct softirq_action
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
index 0d5fe265e354b..f6ed814f1f94a 100644
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
@@ -609,6 +612,190 @@ asmlinkage __visible void do_softirq(void)
 
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
+	if (atomic_read(&worker->phase) != SOFTIRQ_KUNIT_EMPTY_ARMED ||
+	    current != __this_cpu_read(ksoftirqd))
+		return false;
+
+	return atomic_cmpxchg(&worker->phase, SOFTIRQ_KUNIT_EMPTY_ARMED,
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
@@ -1198,11 +1385,50 @@ void __init softirq_init(void)
 
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
+}
+
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
 }
+#endif
 
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
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 9cdc881b8da29..2dc97edc38b1e 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -139,7 +139,9 @@ config RV_MONITORS_KUNIT_TEST
 	  These tests verify that monitors correctly detect violations by
 	  triggering fake events and validating the expected reactions.
 
-	  Enabling this may slightly increase overhead of some monitors if any
-	  unrelated KUnit test is running.
+	  Building this option, including as a module, adds test-only hooks to
+	  some monitored paths. KUnit's static key keeps the hooks dormant while
+	  no test is running. Running this or another KUnit suite can temporarily
+	  add slight overhead to those paths.
 
 	  If unsure, say N.
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
index e61c500a954a9..40fe9fd4b1fb4 100644
--- a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
@@ -885,6 +885,37 @@ struct irqstate_inline_bh_ctx {
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
@@ -1154,6 +1185,202 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
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
+		unregister_trace_softirq_context_exit_tp(irqstate_empty_worker_exit,
+							 empty_ctx);
+	if (empty_ctx->entry_attached)
+		unregister_trace_softirq_context_entry_tp(
+			irqstate_empty_worker_entry, empty_ctx);
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
+	ret = register_trace_softirq_context_entry_tp(
+		irqstate_empty_worker_entry, empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->entry_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test,
+						  irqstate_empty_worker_detach,
+						  empty_ctx));
+	ret = register_trace_softirq_context_exit_tp(irqstate_empty_worker_exit,
+						     empty_ctx);
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
@@ -1389,6 +1616,16 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
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
@@ -1414,6 +1651,8 @@ static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
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

