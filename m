Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646260;
	b=VFvKup7TJgggm7tOOmQQaJ6aNlDGsY4sEHGJwBMKTFc1IOZ/G3/NcDDM8XM4FAIhKFdR
	 lkFEQnlxAQXtSnMSlNAXYZ3z90ftFTc2Rkd8mc0niC0xnlvUumX+1ebVJ1pP++ncPWKM6
	 ZjG65QmDMB8bze5EY3aFef1tO2WEvuuBRkoEvgC4FentrXt5eXJU0/jXzVIwvDF2a3yIV
	 ZO5Km2ywuG0v/n6+2IIgoF8NhdtbS1w82vblR74htyYW4Mw0LZVSPVzaa2i+6S6/u1XEv
	 f/67x1QNE1wFQevPqxHGXDfYxhTQJInJlaO38e5jXQaoGoc+cM7Xht316B7gYFhbr1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yI/KRMuZRPijWcltjKclweO2FOu/JT/OWUV8SsmHo1Y=;
	b=HQYdvHvVditsekK8bXucCta13snpjbl1T+X/t0Yt6sNmoaPZn2wkNiD7bNO/VUaJRByL
	 hadbjaJm1wLtQFvps7MnyFtn/1hNIQ5ZRPQTsnbBc7KzMdxuyjGSTXMV4vqN4jN5RPoUs
	 xMe57FwIxQr54qTkTKsHkw0vO5VAPIqtfeFC/4zkSg7/zrbaYxKaKgofuTquiNEnP+/yF
	 HDln2R0CHnU4NWsnO8SyF+R23xEsJsgSAa7dN8Bfc26yX6WSE8Ln7pxXVcOnwPoRrLCN3
	 0EIUPRAnJDUv9yoR8P+j1ho2rGsv/Ome8sjNES6c+G7t16X4IKRpUjbL1689DZbN+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qI8Dm1lc;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEA60A261B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9BEA60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qI8Dm1lc
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so9975105e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646258; x=1793251058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yI/KRMuZRPijWcltjKclweO2FOu/JT/OWUV8SsmHo1Y=;
        b=qI8Dm1lc6l4Pm124YVTo0ElbcftWuaEQ4GUynWy9sON0zmFKegF1hgN/8G0IXY5sNz
         i3tk9CDskvKX7y4UqVoiblcDq6ju1fpVmO/jKOtZpM2j9CIJmFUOLYcuZVP3eSvzgIiW
         WnlIJ9lm6R/XwfcfwIAkdK3NpVRLXGW05c4emxzVr5SPkYM6ivtHtodRLZ2W52iBdoMR
         D033B8ZVWX3dzDj7cK4rAQlVRRMnEDvBrtxHoVVDBa/BTfXcrv7ObYbCrvHjaxSXL3ZZ
         0F3154PeUwnYQJPZOkffD1b06f2onhTKkNudOsZdNQ+sfKqznFIqV8dzf2eWkbbWx4qC
         oHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646258; x=1793251058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yI/KRMuZRPijWcltjKclweO2FOu/JT/OWUV8SsmHo1Y=;
        b=hfa/crpZZDY2BPaLFjkmYfNVobW/xBJJbf2rNL5jK7Nl907yx8lgr8f06NH6AjYL8U
         /3uTTixY53F6PQnVi1SELRkr18jI7GOj14rbJK8smhsJ3VfwzaLSLnWfu0AK1aLbWx4M
         CLkz4hrBfopbezKMEnyAYAWkULCOWEWANvmpSYis6VyGNKrC2Cmjq7w6JQI7RsJCB7nv
         etJZ6bvvNedk5RZ3Gnr5qsrFl/r5vNZ9dEZiDjCfsaWRdA9PZmN2Z0jMklc1KfNPPC4r
         OMCg3jvWjhgjqB5RY3eoWAU2MEpF38lh2P9TDrsyJXzOm0H42k8RgMlyTs69nw0eRlU6
         dDhQ==
X-Forwarded-Encrypted: i=1; AKwUvByUU81spOPhW5i5bId1fjc+hG91cZXoHZjyvG47Nht8b4VOun6ep/66VB4TRbPfptENCd9Xl7LaAWkdNTL9fkAyaYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGlTb5bE3bHPS5e3toH0H+CPn4O77uPxrdkUURpR4A0d8maod9
	VQePCPCPEKUi7o6GBctxHXQUCZWxElJ+v3v8MI+lCY4TprGtcUS4favz
X-Gm-Gg: AYBFou1BA4E6/inIodxyZ4J2Slvp6NhiQZyFGO97nAjGiQ1q2+gJtEzVsqOPgprGSHb
	iBAJyK8v1sQXBx1p3vZYc1GBjxmIjsPrYN31K0fwJ0pW0lrNycGHPU6U9Ouar8wSZCuMV6eHugd
	iHoLM5rxyr1MdHVaQ4s6sRI7Q0r6OjFTvB6mbcK+VZmA3ILiUQb51pGjxwj5Kfye4P84E9K+8kw
	41BTnMmax4yIQOU80RcNQuWCyHCkjB26M1LIQJpZLxKNpTqes2I7vpVq0RZ39ah/GWcfc4vZx/w
	D2wIA+QNdiCD/aJ3+o0r3H/IX7cOXpq6l9VI8kE+Dy5VJtmNr9In5iIMEhQBJ1mQwgxkEL/JrJV
	VikvhorMzROYYCjllkqDWhsaith4bn7Jp7CW0I3suy4rbhkb1moTfrVfUWU9HCzsqfvVe2FQ2vm
	WSyaJR/960U6vo/6CcBG+ftOXkLpIW+Np7hSWdaNajbSvhL+okXJYOFDClViTTwtM79GC8g/NcX
	hRHVzkLPV4fqiZMNq0LqEOTs/GWEQSX3KOi1di+qoLq1U0nzrC4QlNybY6aSY40lY32AUzAQ+lw
	jpZbC6mYISDYfhfiXc8mnciS/87jwz6Yqf9Fa8WitTOMWAVaiPLWRF6baUAujYnyjUdNSsdwOIV
	VDEl39W7pdEJdPu5dnDUGif5Mk4IZcGNV6PP1Je0NysYGHUD17ES+vCou5GdSQDjxC0YImxzK+h
	s4cgBO
X-Received: by 2002:a05:600c:1f88:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4a1fdd15bc6mr83285535e9.31.1792646257872;
        Wed, 21 Oct 2026 22:17:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Subject: [RFC PATCH 08/12] entry: Classify ordinary hardirq return-tail work as hardirq context
Date: Thu, 22 Oct 2026 07:16:50 +0200
Message-Id: <20261022051654.79224-9-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022051654.79224-1-kmehltretter@gmail.com>
References: <20261022051654.79224-1-kmehltretter@gmail.com>
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

An ordinary hardirq removes its original count and lockdep state before the
return path may preempt. Traceable return-tail callbacks then appear to run
in the interrupted task or softirq context and can collide with recursion
state owned by that context.

Use the saved ordinary-hardirq provenance to restore only preempt-count and
lockdep classification after the preemption decision. Keep it across
traceable return-tail work, deferred hrtimer rearming, IRQ-on preparation,
and context-tracking preparation.

Before removing the raw tail state, prepare the count and lockdep teardown
and close late regular or forced-thread softirq work. Complete any pending
RCU quiescent-state transition only after that raw teardown.

Do not repeat interrupt accounting, RCU or tick entry. Existing non-hardirq
return paths remain unchanged.

Assisted-by: LLM
---
 include/linux/hardirq.h          |  5 +++
 include/linux/irq-entry-common.h | 59 ++++++++++++++++++++++++++++++--
 kernel/softirq.c                 | 18 ++++++++++
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index ad27a06c859a0..a120e3756d076 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -27,6 +27,7 @@ static __always_inline void rcu_irq_enter_check_tick(void)
 
 void irq_enter_rcu_preempt_counted(void);
 bool irq_exit_rcu_preempt_counted_prepare(void);
+void noinstr irqentry_hardirq_tail_exit(void);
 
 /*
  * Prepare every potentially instrumentable part of hardirq teardown before
@@ -37,6 +38,10 @@ static __always_inline bool irqentry_hardirq_exit_prepare(void)
 {
 	bool do_sub;
 
+	/*
+	 * Preempt-on tracing can raise deferred work. The caller must perform
+	 * the final worker closure before removing the raw hardirq count.
+	 */
 	do_sub = preempt_count_sub_prepare(HARDIRQ_OFFSET);
 	lockdep_hardirq_exit_prepare();
 	return do_sub;
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 2ed637cf66b0c..c6bdd5a2522e8 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -355,6 +355,28 @@ typedef struct irqentry_state {
 
 irqentry_state_t noinstr irqentry_hardirq_enter(struct pt_regs *regs);
 
+/**
+ * irqentry_hardirq_tail_enter - Restore ordinary-hardirq return-tail state
+ * @state: Return value from the matching irqentry_hardirq_enter()
+ *
+ * Restore only the hardirq classification which traceable return-tail work
+ * needs. Accounting, RCU and tick handling belong to the completed interrupt
+ * and must not be repeated here.
+ */
+static __always_inline void
+irqentry_hardirq_tail_enter(irqentry_state_t state)
+{
+	if (!state.hardirq)
+		return;
+
+	__preempt_count_add(HARDIRQ_OFFSET);
+	lockdep_hardirq_enter();
+
+	instrumentation_begin();
+	preempt_count_add_finish(HARDIRQ_OFFSET);
+	instrumentation_end();
+}
+
 /**
  * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
  *
@@ -505,7 +527,9 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
  *
  * The rearm on return to user mode needs no such annotation: no locks are
  * held there, so it uses the same lock chains as the rearm in hardirq
- * context.
+ * context. Ordinary-hardirq return paths do not use this wrapper: their saved
+ * provenance restores both the hardirq count and lockdep nesting across the
+ * whole traceable tail and they call hrtimer_rearm_deferred() directly.
  */
 static __always_inline void irqentry_hrtimer_rearm_deferred(void)
 {
@@ -520,7 +544,9 @@ static __always_inline void irqentry_hrtimer_rearm_deferred(void)
  * @state:	Return value from matching call to irqentry_enter_from_kernel_mode()
  *
  * This is to be invoked after irqentry_exit_to_kernel_mode_preempt() and before
- * actually returning to the interrupted context.
+ * actually returning to the interrupted context. If @state records ordinary
+ * hardirq provenance, the caller must first invoke
+ * irqentry_hardirq_tail_enter() exactly once.
  *
  * There are no requirements for the CPU state other than being able to complete
  * the tracing, lockdep and RCU state transitions. After this function returns
@@ -529,6 +555,31 @@ static __always_inline void irqentry_hrtimer_rearm_deferred(void)
 static __always_inline void
 irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_t state)
 {
+	struct ct_irq_exit_state ct_state = { };
+
+	if (state.hardirq) {
+		if (!regs_irqs_disabled(regs)) {
+			instrumentation_begin();
+			hrtimer_rearm_deferred();
+			/* Tell the tracer that the return will enable IRQs. */
+			trace_hardirqs_on_prepare();
+			lockdep_hardirqs_on_prepare_irqtail();
+			instrumentation_end();
+		}
+
+		if (state.exit_rcu)
+			ct_state = ct_irq_exit_prepare();
+
+		irqentry_hardirq_tail_exit();
+
+		if (state.exit_rcu)
+			ct_irq_exit_finish(ct_state);
+
+		if (!regs_irqs_disabled(regs))
+			lockdep_hardirqs_on(CALLER_ADDR0);
+		return;
+	}
+
 	if (!regs_irqs_disabled(regs)) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
@@ -570,7 +621,8 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
  *
  * This is the counterpart of irqentry_enter_from_kernel_mode() and combines
  * the calls to irqentry_exit_to_kernel_mode_preempt() and
- * irqentry_exit_to_kernel_mode_after_preempt().
+ * irqentry_exit_to_kernel_mode_after_preempt(). It also establishes the
+ * conditional hardirq return tail between those calls.
  *
  * The requirement for the CPU state is that it can schedule. After the function
  * returns the tracing, lockdep and RCU state transitions are completed and the
@@ -585,6 +637,7 @@ static __always_inline void irqentry_exit_to_kernel_mode(struct pt_regs *regs,
 	irqentry_exit_to_kernel_mode_preempt(regs, state);
 	instrumentation_end();
 
+	irqentry_hardirq_tail_enter(state);
 	irqentry_exit_to_kernel_mode_after_preempt(regs, state);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 63427d29cb6d1..80d12deeb694a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -833,6 +833,24 @@ irq_exit_wake_late_softirqs(unsigned int wake_flags)
 		irq_exit_wake_ksoftirqd();
 }
 
+/**
+ * irqentry_hardirq_tail_exit - Close work and remove return-tail state
+ *
+ * Run every instrumentable teardown operation, including the final worker
+ * closure, before removing the raw hardirq count and lockdep nesting.
+ */
+void noinstr irqentry_hardirq_tail_exit(void)
+{
+	bool do_sub;
+
+	instrumentation_begin();
+	do_sub = irqentry_hardirq_exit_prepare();
+	irq_exit_wake_late_softirqs(0);
+	instrumentation_end();
+
+	irqentry_hardirq_exit_finish(do_sub);
+}
+
 static __always_inline unsigned int __irq_exit_rcu(bool keep_hardirq_count)
 {
 	unsigned int wake_flags = 0;
-- 
2.39.5 (Apple Git-154)

