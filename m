Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158319;
	b=L9srLTtcN5A8FaXxpIdQ06WyQ83pqu7zGPm9P5Ile+VGKfweVOWm8CNZufNlUsbufhWe
	 Ky5T9oO+j12JGVybhG3bzW+RB7EBJ4Rxx9BsnuWpnFaxuBA9B5W5NGjxVLh0s8+juXQL1
	 fRR6FueYhTnTTm6o888z88V0+AXnx7CQYYdfmY2DowFsG9fLDmhdah0xLh+oP2+EcbL9s
	 xy3UuCrn6sNjDxcFp89jTOtmtnDDxtuD41pvO4tOzgDp8RWNl60j3vQkohZTmr379liD9
	 2MhH/cT755iBxRb5Lc1wN+pUFGuFC/awdEPEINpDDXGqIlnZoulPJBLiKO4wYlecYrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eeFaMcaI/QULWPGI46eWUbs+3gYM1Hxa41OxQr0Fu1k=;
	b=TDO92ygCHghYreg/BTHmhCzhQovX32sVzA00ZE+SD9ll4q/l0X47dRwjXtJBwI0Z6e2Z
	 tBd+K0HvB9Xfjx0Takdbi3cDUc01uAnww+0qh6dzlwWTUK2nMDXHByIQLiTuU71VgDQiE
	 1AD9Bo6gbZX5qnrSpL0hD7xWro4frVNGvdlLd/kbzLnBbGMBtnfwTcZxMKHN3JPuaLxzH
	 iyOQGY1CdgnuXnNOKXA6lnTSd4FtNYqKewAavgMlnKZW+DqDzY5cPZsu6xnkXCQBglER6
	 E5HtvRX6SCVq3wUnsZMXksKsu6DB+4Lj7S6Mkmm+uoHYyDaLPdSOC766l8OzDdCyuLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSM5kXWU;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E4606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 676E4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSM5kXWU
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso309203f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158317; x=1793763117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eeFaMcaI/QULWPGI46eWUbs+3gYM1Hxa41OxQr0Fu1k=;
        b=mSM5kXWUR8Z96cy2saxlbGZeUUJymchja8NP7GC57+LJygUU34b8LffxX4qAaCmdBH
         k12HPMshRpVmXnmfT3zmnO/6tuMTaJlBzdJhKV1+fUCZsTxPLqZkiVWKwxuhirBqHhQw
         AFCdcBQ9w96IIQAYF4OwVmxBFEaE739rfqIVp4jO678G1wZerMFvL6k7m0Ld3Ev3cvSj
         MxWNgJ4fxdvEsTZl2uOHfJW06fSNzieFWl/7ofPLvlnw+b16KkQxGb0yzxO3xu0zUj5e
         0BA20IMeBYv+vxEf9cTCfpHJKtH82aLd5ALo6ZmVMxQSvCDQdzETdBgZ/2XAVhwAFtK+
         QKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158317; x=1793763117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eeFaMcaI/QULWPGI46eWUbs+3gYM1Hxa41OxQr0Fu1k=;
        b=HgB0ztorUrVU/RCAcuwOBMGyY0fu2plaGa74gt+6uBJWYFtpYYENYbPrpnPWaO4XPd
         L76i9mATULLHWCbzNaCpMYBFwvM/4pKGEy/hopmAAoLbCnpye6S3mp3Uu+gmlW80WySF
         ADSKg7JsMCNavIYUQ9XJoFEtx5DSHUcLeRPdu/ejNf3Za4clPu1pSYNQ2eGUPwyevWWH
         aybs3n6LiWpLw8r3RnM1I4jTVdYjhzzYsSYz3YsHqseWctlfPmdZ7Dk938+qCvLDe91l
         baj9blsBpxUfH5nYBPLQ7zsQ8vJU7HG7vWhkZbNh28tc3A4RTqMd8wmYrqaI7omRw3LV
         eU+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwskeLFKeQP75jGsHUm6n/WZA9tMt2JOVEa0OX5pPMfFoljCMTGzzGnt3eXHdivHzNjz0L06ESVY9yswfPJ9+AVGyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwMj1p/Aky903XcP6tbFHNwprQRQ1csQZw77A3HfA8lmYM1pxS
	6t/J2cxwo5UWtXWYh9bKr775NyO2S/pN1VhosljpGs4cYuIO0cwjaXIC
X-Gm-Gg: AYBFou3TOPRC1870BbNb7z2y1fvx6pRilaT2hm+4keibX5wOGSMmBdrz8FbGxmVAhfG
	0Vu1Wbc2/4oZbvvWcr8Yjsl9bXInLe9KsZ8W4RQbuh2UD/VjFn+DaSpb+zjxHfMmRG8rNRsDabh
	7uCXmce8Z2RJZZzDXxDmM421C4VdCGM73zIKq3Nh1U4W/hWbVJvZTtyNiWwOWD+jGMrw5nmeErv
	/go+rOzik1hfmw3lK8u94hAS2/dpHyOobLZa7F+jBv+JEqgWCQgY0ChmrZLSefWCe+oeQkv3vGI
	JnUgaf08sAcOKNdRh75DHYXIGmwf/ArKyS+yCvm2pOgcrpXcqgDq/MBsj9ywq+VwegS4AnVFLv0
	N/WtBZy0PHUMzjd/GGMEFIPwhMzKCkKngwMJlVjo9cr05awW2Oyn3zgbW89/L4mllmYJF4fj4LJ
	8tqHxnLzn1HVccoBBU4S/JmCd5WOBVdjmlePiMgYAW6DL5df7wyZneGdpbRfddRzFMmXDCl7oNT
	qpgfdhqrKAijwlgctBnmHPl50O5agtj65/U0yuz5Msa8RLJO/f+sd0zAtyZqKsMeysKHgD/2Fke
	M5G/1hYMBXsEeJbgD32YHDXL6IJZNE9P/PcowDXTF1N2BfJOoH/9dOgIzJ1WSWyhY7sFqzCt0Jy
	TVeJjWwKMIi5jpklgNXm5e4RT85TcoV2Jcqhh6FJKVdQs04pRZkE8U0puziwfozB4ZZ6iV5qLxb
	LssDtNIZGifXuSUY4tEhOWU4/WTCX4IHXl
X-Received: by 2002:adf:f18f:0:b0:48e:1d87:f170 with SMTP id ffacd0b85a97d-48e5d5c27c7mr2142297f8f.12.1793158316595;
        Tue, 27 Oct 2026 20:31:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 05/13] entry: Add the pre-counted ordinary-hardirq entry/exit contract
Date: Wed, 28 Oct 2026 04:31:19 +0100
Message-Id: <20261028033127.82193-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028033127.82193-1-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
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

Architectures which identify ordinary hardirqs before generic entry need
to install HARDIRQ_OFFSET before context tracking and tracing callbacks
run. Lockdep hardirq state must agree with that count. On exit, both states
must remain installed until every traceable callback has returned.

Add irqentry_hardirq_enter() to stage the raw count update, record whether
it was applied in irqentry_state_t, and establish lockdep state before
instrumentable entry work. irq_enter_rcu_preempt_counted() finishes the
staged count update while preserving the existing timer and hardirq
accounting boundary.

Add a retained exit path which runs IRQ-exit processing and instrumentable
teardown preparation before returning to an immediate conditional raw count
and lockdep teardown. This keeps function-graph return callbacks in hardirq
context.

A return callback after the final softirq drain can raise regular or
forced-thread timer work while hardirq state still suppresses the usual
wakeup. Recheck ksoftirqd, ktimerd, then ksoftirqd after the last traceable
teardown step. Record wake requests made by the main exit path so the
closure does not repeat them.

Keep the existing entry and exit interfaces unchanged. Architectures opt
in only after distinguishing ordinary hardirqs from NMI-like entry. They
must not place instrumentable code between the retained-exit helper and
raw teardown.

Assisted-by: LLM
---
 include/linux/hardirq.h          |  31 ++++++
 include/linux/interrupt.h        |   2 +-
 include/linux/irq-entry-common.h |  62 +++++++++++-
 include/linux/irqflags.h         |   9 +-
 kernel/entry/common.c            |  37 +++++++
 kernel/softirq.c                 | 160 ++++++++++++++++++++++++++-----
 6 files changed, 271 insertions(+), 30 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index dcbda3c1d5636..d4b2754468c09 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -26,6 +26,37 @@ static __always_inline void rcu_irq_enter_check_tick(void)
 		__rcu_irq_enter_check_tick();
 }
 
+void irq_enter_rcu_preempt_counted(struct irqentry_hardirq_cookie cookie);
+bool irq_exit_rcu_preempt_counted_prepare(struct irqentry_hardirq_cookie cookie);
+
+/*
+ * Prepare every potentially instrumentable part of hardirq teardown before
+ * the raw count and lockdep updates. The caller must invoke the matching
+ * finish helper without passing through instrumentable code.
+ */
+static __always_inline bool
+irqentry_hardirq_exit_prepare(struct irqentry_hardirq_cookie cookie)
+{
+	bool do_sub;
+
+	/*
+	 * Preempt-on tracing can raise deferred work. The caller must perform
+	 * the final worker closure before conditionally removing an applied
+	 * raw hardirq count.
+	 */
+	do_sub = irqentry_hardirq_count_applied(cookie) &&
+		 irqentry_hardirq_count_sub_prepare();
+	lockdep_hardirq_exit_prepare();
+	return do_sub;
+}
+
+static __always_inline void irqentry_hardirq_exit_finish(bool do_sub)
+{
+	if (do_sub)
+		__preempt_count_sub(HARDIRQ_OFFSET);
+	lockdep_hardirq_exit_finish();
+}
+
 /*
  * It is safe to do non-atomic ops on ->hardirq_context,
  * because NMI handlers may not preempt and the ops are
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee2dd5349697d..6143ef6074ad6 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -640,7 +640,7 @@ DECLARE_PER_CPU(struct task_struct *, ktimerd);
 DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
 void raise_ktimers_thread(unsigned int nr);
 
-static inline unsigned int local_timers_pending_force_th(void)
+static __always_inline unsigned int local_timers_pending_force_th(void)
 {
 	return __this_cpu_read(pending_timer_softirq);
 }
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index d5a66f54d70b5..289e308d2d46c 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -5,6 +5,8 @@
 #include <linux/context_tracking.h>
 #include <linux/hrtimer_rearm.h>
 #include <linux/kmsan.h>
+#include <linux/preempt.h>
+#include <linux/irqentry_hardirq.h>
 #include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
@@ -76,8 +78,9 @@ static __always_inline bool arch_in_rcu_eqs(void) { return false; }
 #endif
 
 /**
- * enter_from_user_mode - Establish state when coming from user mode
+ * __enter_from_user_mode - Establish state when coming from user mode
  * @regs:	Pointer to currents pt_regs
+ * @hardirq:	Whether to establish hardirq lockdep context before tracing
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -95,10 +98,13 @@ static __always_inline bool arch_in_rcu_eqs(void) { return false; }
  * done between establishing state and enabling interrupts. The caller must
  * enable interrupts before invoking syscall_enter_from_user_mode_work().
  */
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+static __always_inline void __enter_from_user_mode(struct pt_regs *regs,
+						   bool hardirq)
 {
 	arch_enter_from_user_mode(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
+	if (hardirq)
+		lockdep_hardirq_enter();
 
 	CT_WARN_ON(__ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
@@ -109,6 +115,11 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 	instrumentation_end();
 }
 
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	__enter_from_user_mode(regs, false);
+}
+
 /**
  * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
  *				 to user mode.
@@ -317,6 +328,12 @@ static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	exit_to_user_mode();
 }
 
+enum irqentry_hardirq_state {
+	IRQENTRY_HARDIRQ_NONE,
+	IRQENTRY_HARDIRQ_APPLIED,
+	IRQENTRY_HARDIRQ_REJECTED,
+};
+
 #ifndef irqentry_state
 /**
  * struct irqentry_state - Opaque object for exception state storage
@@ -324,6 +341,8 @@ static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
  *            exit path has to invoke ct_irq_exit().
  * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
  *           lockdep state is restored correctly on exit from nmi.
+ * @hardirq: Encodes whether the current staged hardirq-count attempt was
+ *           applied.
  *
  * This opaque object is filled in by the irqentry_*_enter() functions and
  * must be passed back into the corresponding irqentry_*_exit() functions
@@ -338,9 +357,32 @@ typedef struct irqentry_state {
 		bool	exit_rcu;
 		bool	lockdep;
 	};
+	u8		hardirq;
 } irqentry_state_t;
 #endif
 
+irqentry_state_t noinstr irqentry_hardirq_enter(struct pt_regs *regs);
+
+static __always_inline struct irqentry_hardirq_cookie
+irqentry_hardirq_count_state(irqentry_state_t state)
+{
+	struct irqentry_hardirq_cookie cookie = { };
+
+#if defined(CONFIG_DEBUG_PREEMPT) && \
+	!defined(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS)
+	cookie.applied = state.hardirq == IRQENTRY_HARDIRQ_APPLIED;
+#endif
+	return cookie;
+}
+
+static __always_inline void
+irqentry_hardirq_count_state_set(irqentry_state_t *state,
+				 struct irqentry_hardirq_cookie cookie)
+{
+	state->hardirq = irqentry_hardirq_count_applied(cookie) ?
+		IRQENTRY_HARDIRQ_APPLIED : IRQENTRY_HARDIRQ_REJECTED;
+}
+
 /**
  * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
  *
@@ -349,8 +391,9 @@ typedef struct irqentry_state {
 void irqentry_exit_cond_resched(void);
 
 /**
- * irqentry_enter_from_kernel_mode - Establish state before invoking the irq handler
+ * __irqentry_enter_from_kernel_mode - Establish state before invoking an exception
  * @regs:	Pointer to currents pt_regs
+ * @hardirq:	Whether to establish hardirq lockdep context before tracing
  *
  * Invoked from architecture specific entry code with interrupts disabled.
  * Can only be called when the interrupt entry came from kernel mode. The
@@ -364,7 +407,8 @@ void irqentry_exit_cond_resched(void);
  *
  * Returns: An opaque object that must be passed to irqentry_exit_to_kernel_mode().
  */
-static __always_inline irqentry_state_t irqentry_enter_from_kernel_mode(struct pt_regs *regs)
+static __always_inline irqentry_state_t
+__irqentry_enter_from_kernel_mode(struct pt_regs *regs, bool hardirq)
 {
 	irqentry_state_t ret = {
 		.exit_rcu = false,
@@ -401,6 +445,8 @@ static __always_inline irqentry_state_t irqentry_enter_from_kernel_mode(struct p
 		 * as in irqentry_enter_from_user_mode().
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
+		if (hardirq)
+			lockdep_hardirq_enter();
 		ct_irq_enter();
 		instrumentation_begin();
 		kmsan_unpoison_entry_regs(regs);
@@ -418,6 +464,8 @@ static __always_inline irqentry_state_t irqentry_enter_from_kernel_mode(struct p
 	 * in having another one here.
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
+	if (hardirq)
+		lockdep_hardirq_enter();
 	instrumentation_begin();
 	kmsan_unpoison_entry_regs(regs);
 	rcu_irq_enter_check_tick();
@@ -427,6 +475,12 @@ static __always_inline irqentry_state_t irqentry_enter_from_kernel_mode(struct p
 	return ret;
 }
 
+static __always_inline irqentry_state_t
+irqentry_enter_from_kernel_mode(struct pt_regs *regs)
+{
+	return __irqentry_enter_from_kernel_mode(regs, false);
+}
+
 /**
  * irqentry_exit_to_kernel_mode_preempt - Run preempt checks on return to kernel mode
  * @regs:	Pointer to current's pt_regs
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 5bc179a88e513..e98313a8ad307 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -64,9 +64,14 @@ do {							\
 do {						\
 	current->hardirq_threaded = 1;		\
 } while (0)
+# define lockdep_hardirq_exit_prepare()	\
+	__this_cpu_preempt_check("add")
+# define lockdep_hardirq_exit_finish()		\
+	raw_cpu_dec(hardirq_context)
 # define lockdep_hardirq_exit()			\
 do {						\
-	__this_cpu_dec(hardirq_context);	\
+	lockdep_hardirq_exit_prepare();		\
+	lockdep_hardirq_exit_finish();		\
 } while (0)
 
 # define lockdep_hrtimer_enter(__hrtimer)		\
@@ -119,6 +124,8 @@ do {						\
 # define lockdep_softirqs_enabled(p)		0
 # define lockdep_hardirq_enter()		do { } while (0)
 # define lockdep_hardirq_threaded()		do { } while (0)
+# define lockdep_hardirq_exit_prepare()	do { } while (0)
+# define lockdep_hardirq_exit_finish()		do { } while (0)
 # define lockdep_hardirq_exit()			do { } while (0)
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2f5229132466c..9d207c37c5707 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/futex.h>
+#include <linux/hardirq.h>
 #include <linux/highmem.h>
 #include <linux/irq-entry-common.h>
 #include <linux/jump_label.h>
@@ -120,6 +121,42 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return irqentry_enter_from_kernel_mode(regs);
 }
 
+/**
+ * irqentry_hardirq_enter - Establish state for ordinary hardirq entry
+ * @regs: Pointer to the interrupted register state
+ *
+ * Attempt a staged raw hardirq-count addition before anything instrumentable
+ * can run and record whether it was applied. Then establish IRQ-disabled and
+ * hardirq lockdep state before context tracking or irqflag tracing can invoke
+ * callbacks. The caller must have distinguished an ordinary hardirq from
+ * NMI-like entry and must finish the staged attempt with
+ * irq_enter_rcu_preempt_counted().
+ *
+ * Returns: An opaque object for the matching irqentry exit operation.
+ */
+noinstr irqentry_state_t irqentry_hardirq_enter(struct pt_regs *regs)
+{
+	struct irqentry_hardirq_cookie cookie;
+	irqentry_state_t ret;
+
+	cookie = irqentry_hardirq_count_start();
+
+	if (user_mode(regs)) {
+		ret = (irqentry_state_t) {
+			.exit_rcu = false,
+		};
+		irqentry_hardirq_count_state_set(&ret, cookie);
+
+		__enter_from_user_mode(regs, true);
+		rseq_note_user_irq_entry();
+		return ret;
+	}
+
+	ret = __irqentry_enter_from_kernel_mode(regs, true);
+	irqentry_hardirq_count_state_set(&ret, cookie);
+	return ret;
+}
+
 /**
  * arch_irqentry_exit_need_resched - Architecture specific need resched function
  *
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7fc2200392cdf..169c559832501 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -14,6 +14,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/instrumentation.h>
 #include <linux/local_lock.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
@@ -353,15 +354,18 @@ static inline void ksoftirqd_run_end(void)
 static inline bool softirq_handle_begin(void) { return false; }
 static inline void softirq_handle_end(bool from_irq_exit) { }
 
-static inline bool should_wake_ksoftirqd(void)
+static __always_inline bool should_wake_ksoftirqd(void)
 {
 	return !this_cpu_read(softirq_ctrl.cnt);
 }
 
-static inline void invoke_softirq(void)
+static inline bool invoke_softirq(void)
 {
-	if (should_wake_ksoftirqd())
-		wakeup_softirqd();
+	if (!should_wake_ksoftirqd())
+		return false;
+
+	wakeup_softirqd();
+	return true;
 }
 
 #define SCHED_SOFTIRQ_MASK	BIT(SCHED_SOFTIRQ)
@@ -525,12 +529,12 @@ static inline void ksoftirqd_run_end(void)
 	local_irq_enable();
 }
 
-static inline bool should_wake_ksoftirqd(void)
+static __always_inline bool should_wake_ksoftirqd(void)
 {
 	return true;
 }
 
-static inline void invoke_softirq(void)
+static inline bool invoke_softirq(void)
 {
 	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
@@ -548,9 +552,11 @@ static inline void invoke_softirq(void)
 		 */
 		do_softirq_own_stack();
 #endif
-	} else {
-		wakeup_softirqd();
+		return false;
 	}
+
+	wakeup_softirqd();
+	return true;
 }
 
 asmlinkage __visible void do_softirq(void)
@@ -703,13 +709,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	handle_softirqs(false);
 }
 
-/**
- * irq_enter_rcu - Enter an interrupt context with RCU watching
- */
-void irq_enter_rcu(void)
+static __always_inline void irq_enter_rcu_common(void)
 {
-	__irq_enter_raw();
-
 	/*
 	 * If this is a nested interrupt that hits the exit_to_user_mode_loop
 	 * where it has enabled interrupts but before it has hit schedule() we
@@ -724,6 +725,32 @@ void irq_enter_rcu(void)
 	account_hardirq_enter(current);
 }
 
+/**
+ * irq_enter_rcu_preempt_counted - Finish staged hardirq entry
+ * @cookie: Staged hardirq-count cookie from irqentry_hardirq_enter()
+ *
+ * Finish an early staged hardirq preempt-count attempt, then establish the
+ * remaining timer and accounting state. The matching lockdep hardirq state
+ * was established by irqentry_hardirq_enter() before entry tracing. An
+ * applied update receives post-add bookkeeping. A rejected update attempts
+ * deferred reporting and skips that bookkeeping even if reporting is
+ * suppressed.
+ */
+void irq_enter_rcu_preempt_counted(struct irqentry_hardirq_cookie cookie)
+{
+	irqentry_hardirq_count_finish(cookie);
+	irq_enter_rcu_common();
+}
+
+/**
+ * irq_enter_rcu - Enter an interrupt context with RCU watching
+ */
+void irq_enter_rcu(void)
+{
+	__irq_enter_raw();
+	irq_enter_rcu_common();
+}
+
 /**
  * irq_enter - Enter an interrupt context including RCU update
  */
@@ -764,8 +791,56 @@ static inline void wake_timersd(void) { }
 
 #endif
 
-static inline void __irq_exit_rcu(void)
+static __always_inline bool irq_exit_wake_ksoftirqd(void)
 {
+	if (irq_count() != HARDIRQ_OFFSET || !local_softirq_pending() ||
+	    !should_wake_ksoftirqd())
+		return false;
+
+	wakeup_softirqd();
+	return true;
+}
+
+static __always_inline bool irq_exit_wake_timersd(void)
+{
+	if (!IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) || !force_irqthreads() ||
+	    !local_timers_pending_force_th() ||
+	    hardirq_count() != HARDIRQ_OFFSET)
+		return false;
+
+	wake_timersd();
+	return true;
+}
+
+enum irq_exit_wake_flags {
+	IRQ_EXIT_WAKE_KSOFTIRQD	= BIT(0),
+	IRQ_EXIT_WAKE_KTIMERD	= BIT(1),
+};
+
+static __always_inline void
+irq_exit_wake_late_softirqs(unsigned int wake_flags)
+{
+	bool ksoftirqd_wake_requested = wake_flags & IRQ_EXIT_WAKE_KSOFTIRQD;
+	bool ktimerd_wake_requested = wake_flags & IRQ_EXIT_WAKE_KTIMERD;
+
+	/*
+	 * A wakeup can be traced, and its callback can raise work for the other
+	 * worker. Check ksoftirqd, then ktimerd, then ksoftirqd again. Skip a
+	 * worker whose direct wake request was recorded above: it cannot run on
+	 * this CPU before hardirq teardown, so later work remains visible to it.
+	 */
+	if (!ksoftirqd_wake_requested)
+		ksoftirqd_wake_requested = irq_exit_wake_ksoftirqd();
+	if (!ktimerd_wake_requested)
+		ktimerd_wake_requested = irq_exit_wake_timersd();
+	if (!ksoftirqd_wake_requested && ktimerd_wake_requested)
+		irq_exit_wake_ksoftirqd();
+}
+
+static __always_inline unsigned int __irq_exit_rcu(bool keep_hardirq_count)
+{
+	unsigned int wake_flags = 0;
+
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
 	local_irq_disable();
 #else
@@ -774,7 +849,8 @@ static inline void __irq_exit_rcu(void)
 	account_hardirq_exit(current);
 
 	/*
-	 * HARDIRQ_OFFSET is still set. Only the outermost interrupt handles
+	 * HARDIRQ_OFFSET normally remains set. A rejected staged addition leaves
+	 * an already-invalid count unchanged. Only the outermost interrupt handles
 	 * softirqs, and only if it did not hit a softirq or BH disabled section.
 	 */
 	if (irq_count() == HARDIRQ_OFFSET && local_softirq_pending()) {
@@ -783,20 +859,56 @@ static inline void __irq_exit_rcu(void)
 		 * before enabling interrupts to run softirq.
 		 */
 		hrtimer_rearm_deferred();
-		invoke_softirq();
+		if (invoke_softirq() && keep_hardirq_count)
+			wake_flags |= IRQ_EXIT_WAKE_KSOFTIRQD;
 	}
 
 	/*
 	 * Wake the timer thread even if the interrupt hit a softirq or a
 	 * section with BHs disabled. Only the outermost interrupt can wake it.
 	 */
-	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
-	    local_timers_pending_force_th() &&
-	    hardirq_count() == HARDIRQ_OFFSET)
-		wake_timersd();
+	if (irq_exit_wake_timersd() && keep_hardirq_count)
+		wake_flags |= IRQ_EXIT_WAKE_KTIMERD;
 
 	tick_irq_exit();
-	preempt_count_sub(HARDIRQ_OFFSET);
+	if (!keep_hardirq_count)
+		preempt_count_sub(HARDIRQ_OFFSET);
+
+	return wake_flags;
+}
+
+/**
+ * irq_exit_rcu_preempt_counted_prepare - Process IRQ exit and prepare teardown
+ * @cookie: Staged hardirq-count cookie from irqentry_hardirq_enter()
+ *
+ * The caller staged a hardirq-count attempt and established lockdep state
+ * before instrumentable IRQ entry. Carry any applied count across traceable
+ * IRQ exit. Softirq handling temporarily replaces HARDIRQ_OFFSET with
+ * SOFTIRQ_OFFSET and restores it afterwards. The caller must invoke the raw
+ * teardown helper immediately after return. A rejected staged-add state makes
+ * that helper skip the matching subtraction.
+ *
+ * Return callbacks can raise regular or forced-thread timer softirqs after
+ * __irq_exit_rcu() performed its final drain and worker wakeups. Recheck both
+ * queues after all traceable preparation. Worker wakeups are traceable too,
+ * so order the rechecks such that a callback which raises work for the other
+ * worker cannot leave it asleep. Do not repeat a direct worker wake
+ * recorded by __irq_exit_rcu(); the worker cannot run on this CPU before
+ * hardirq teardown.
+ */
+bool noinstr
+irq_exit_rcu_preempt_counted_prepare(struct irqentry_hardirq_cookie cookie)
+{
+	unsigned int wake_flags;
+	bool do_sub;
+
+	instrumentation_begin();
+	wake_flags = __irq_exit_rcu(true);
+	do_sub = irqentry_hardirq_exit_prepare(cookie);
+	irq_exit_wake_late_softirqs(wake_flags);
+	instrumentation_end();
+
+	return do_sub;
 }
 
 /**
@@ -806,7 +918,7 @@ static inline void __irq_exit_rcu(void)
  */
 void irq_exit_rcu(void)
 {
-	__irq_exit_rcu();
+	__irq_exit_rcu(false);
 	 /* must be last! */
 	lockdep_hardirq_exit();
 }
@@ -818,7 +930,7 @@ void irq_exit_rcu(void)
  */
 void irq_exit(void)
 {
-	__irq_exit_rcu();
+	__irq_exit_rcu(false);
 	ct_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();
-- 
2.39.5 (Apple Git-154)

