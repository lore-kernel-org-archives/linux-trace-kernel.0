Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158339;
	b=Ri1YibjSjb9ELsrmK0VeTesy5Y9MxCPo8QazkGRPvQjtC1Y1dLdSPPLaCSPtzXhhgUaJ
	 goBwx/8dk2ZCz2UgvVommT7ADfhQQD2NTXg2i5RZBOC6IFP/tct3jIV17i7B96QowMkpT
	 BDR6rJOQN59jJDAT6u3Ic7obIp8cFR0ABIRjRsVrwFG7sl8Pjp1zPHKq2WIYDGYTZ4IUy
	 FG0AirsIpnPPfGlTxXZ61jjoxafkKnVKlgt6PV82Syb1N6grNxoLli5xb7t5DHCTxFTyV
	 0nfWso7wPXzexz0yeY2chQl//djZw2pALcIvT9fwBqR/C8pj6s3rQsf3AKVCq7SRftA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/z19Dyd36Kry4my+DL1hRK2Ik7rhLnBj6p5QTA/aWQg=;
	b=My6/kQAL72/sx9dj6XyY39cKvHeIr4ryhPYn8rgG53p0lL1XNs3PPXvLfu4EWbWT1Pec
	 onHwEqKDEtED0G/hACjh6uTaW/MDBQGNpWfmzrw5ca3jGS44SlesdbXAcKzctXd1fOaqU
	 +RL+9aKJsqFIRypyT11A1+7MBRCsCuxK/y1j+GR/HWlUD8Ka69M1rlalpjZZJ+dJuU1gt
	 7IHOyZNmTY+bAVqRP77jjFGTzFvbBy2XyYIAcokMFr7KHODNyNaQuIfLHH4EWXzaDzKFi
	 rj0aVcMsxaXL0/FfuI8tZylmZCuUFHAzLDwXDuW9zNz2pE1mH4cv0pYFitYovm9o5bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOWVwp7y;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820F60A2603
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B820F60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOWVwp7y
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4d870d54so304324f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158337; x=1793763137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/z19Dyd36Kry4my+DL1hRK2Ik7rhLnBj6p5QTA/aWQg=;
        b=GOWVwp7yfQojsYBMOt1ToiDrLrBqZZ26mjcO66IJmMemadtvb+jcIFRZKadRhNCQp6
         d1uM1MZU7mmEXAKsg/cCD+BNVgrzt0JKma7NMmuWEA4LxACxfYjQDC5RKRGKM57B/76+
         zuXZnLL9LsJZT2o4tA8EjyIEOY//LBI39yJfK8WbLs1D89lqaAXpQBF6fJs8rPi+GN3W
         YqGoHxUcuPK01ZAG6JIvYqMmrOXxM2RUG8Ayh+Em9wD+/9h3MMAXjkqaYUaaGg+qB8yY
         E4FNmH9VZ0qlOJTHgnmBqo/C7wAEgx0k6SP0aJ+BEAXpCJS/m6gszoG5jA6cpAoRWbu6
         fOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158337; x=1793763137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/z19Dyd36Kry4my+DL1hRK2Ik7rhLnBj6p5QTA/aWQg=;
        b=D2w/bWMUxj3IBwvx7qYHvRtX7SWHyDdxiEk5mTj7hCmUYA1YM5eU05PBmOqUkscGSG
         cH4Ix6bIvOYKMH/Vj1LAM5/caLB5A9Idx0nFDndbV+ZL1kBTo1OyOG9Tv7UuCO7KcF6W
         vS+LB5uTrYVpgYUPOzz66+EJLnkIdL53RQ/AcnxGXxsl7kv/v+EddwPXkaif6bAHBxwV
         WsGToHsGx1JRXBybqjneREJrdIrkjWOeFeHzWxbvy6vPq7I3/Kg9Bc9YOZWIU3dHgE0N
         eYOj8bfyolTyc8eJo0jBFwkwm6gY52xORdhGdlQS4/GzUhnCh5M+iV5FcDyz2A8nndXe
         aI3A==
X-Forwarded-Encrypted: i=1; AKwUvBx7XTGqz7vemch4ta9rDllS6gd/QgqyShBgOEdX+iXyL3dl9cmjZoxeyur1mg0pIFfaqd5Yi4T0lhXvZQ6wcYcnjWk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJos73mAriKQbtSs2ye2i5AFa6+nMR/JmXOgqkzuc+9qHt6AZv
	W9LcUMwn1+5kof98CCU428FQDyDkqysu1MivewLak5zEVaVGJpM4jbrP
X-Gm-Gg: AYBFou3txfiebFo5Ti9Z7PamKvY4SuMVoXIWyoaIfH7rDcTPXkj+fBFCPfUtSW4gaVK
	+z9VztN6i6Oyrp2NRvwyL3uiSxpLRNZmNNbGjQ7qslZ+62tXtmvex7A6frxPFuyl1ElrBkB2ifd
	Nj2aiwEDgQ85t90SeHHtd1w4mLh4KG2UPVYUY9r/MRinLzE+u346RD3xtPAW8iGqUvyzlSCKIAW
	dr6I2A+eswtb0Nmq58N/8kCElXEP5kzmyTnar9psiAN3ulxNKCbbcfN8Vyqu/ly1AAtvtWmK2Aw
	e544JsAh6AfJeiIhgltXtJXqO5yHCQsVtPJ10K/cQT7qCp9vwHlqKc33lvA5OoK0eh1whtRALXe
	5OpFvskN0Jj7CzTbzB+Y1i0xFKCZ4fVfv25rAoa95OzpyCGfVm/SXn3oJtF1y5RE1xNrhmyq69v
	VyKTr8g+c2sHxf2C9DKpuf82IJcKFmnb4bVvwRLXxTSltkZlvDyugUnmj6OawdzEFwg5ybzp/3y
	+AIBfh5lkPRl0IF52KNDPag5B71wZ9cvrRH67HKNY7T+k4ps4AenSWpsKFJhJQY6VXe4WtkAXib
	GSDr/r+dMe0ol4PFcq4eC65M/g/+neYS/TWZW58h6Z+hnnNhb/FUXx85B0LDAPzhlm3m7uS+Osf
	y8RArdQZNnp6/dA2Vzl6bKWzLx4GiluNiGG2UWGfXiUbOMHGXjtZOtjNKZB3vzHl/p14H7qczEn
	p5wbNb8vEw0kLSqBS6Du9JrPLV05jn8VRn
X-Received: by 2002:adf:e011:0:10b0:48c:4d32:ccf8 with SMTP id ffacd0b85a97d-48e5d58f11dmr2007171f8f.16.1793158337059;
        Tue, 27 Oct 2026 20:32:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.32.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:15 -0700 (PDT)
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
Subject: [RFC PATCH v2 12/13] Documentation: entry: Describe the pre-counted hardirq lifecycle
Date: Wed, 28 Oct 2026 04:31:26 +0100
Message-Id: <20261028033127.82193-13-kmehltretter@gmail.com>
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

The entry documentation covers only the traditional irq_enter_rcu()
path. It does not explain the early-counted entry contract or the retained
and synthetic hardirq exit phases.

Document the staged raw count and lockdep entry, delayed traceable
bookkeeping and rejected-add handling, hardirq accounting,
hardirq-to-softirq classification switch, retained real IRQ exit, possible
preemption and migration, and the classification-only return tail. Also
cover late worker closure, conditional raw teardown and context-tracking
order.

Record that arm64 excludes pseudo-NMIs from this lifecycle and identify its
external noinstr inlining prerequisites.

Assisted-by: LLM
---
 Documentation/core-api/entry.rst | 89 ++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index 09942135aad18..7153cc4120192 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -193,21 +193,14 @@ Note that the invocation of the actual interrupt handler is within a
 irq_enter_rcu() and irq_exit_rcu() pair.
 
 irq_enter_rcu() updates the preemption count which makes in_hardirq()
-return true, handles NOHZ tick state and interrupt time accounting. This
-means that up to the point where irq_enter_rcu() is invoked in_hardirq()
-returns false.
+return true, handles NOHZ tick state and interrupt time accounting. On this
+entry path, in_hardirq() therefore returns false until irq_enter_rcu() is
+invoked.
 
 irq_exit_rcu() handles interrupt time accounting, handles soft interrupts if
 possible, handles the NOHZ tick state and finally undoes the preemption count
 update.
 
-In theory, the preemption count could be updated in irqentry_enter(). In
-practice, deferring this update to irq_enter_rcu() allows the preemption-count
-code to be traced, while also maintaining symmetry with irq_exit_rcu() and
-irqentry_exit(), which are described in the next paragraph. The only downside
-is that the early entry code up to irq_enter_rcu() must be aware that the
-preemption count has not yet been updated with the HARDIRQ_OFFSET state.
-
 Note that soft interrupt handlers must run in BH context rather than in hard
 interrupt context. irq_exit_rcu() therefore replaces HARDIRQ_OFFSET with
 SOFTIRQ_OFFSET in the preemption count while it handles soft interrupts and
@@ -216,6 +209,82 @@ is still attributed to the interrupt. HARDIRQ_OFFSET is removed before
 irq_exit_rcu() returns because irqentry_exit() might schedule, which requires
 that HARDIRQ_OFFSET has been removed from the preemption count.
 
+Pre-counted hardirq lifecycle
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Architectures which need hardirq state before early context-tracking or
+tracing callbacks can use the pre-counted lifecycle. It applies only to an
+ordinary hard interrupt after the architecture has distinguished it from an
+NMI-like event:
+
+  * irqentry_hardirq_enter() attempts to add HARDIRQ_OFFSET with a raw update
+    and records whether the update was applied. It establishes IRQ-disabled
+    and lockdep hardirq state before instrumentable entry work. It then runs
+    the generic entry and context-tracking path, including any required
+    transition out of an RCU extended quiescent state.
+
+  * irq_enter_rcu_preempt_counted() later finishes the staged attempt. For an
+    applied update it performs traceable debug and latency bookkeeping. For a
+    rejected update it attempts deferred reporting and skips post-add
+    bookkeeping. It also performs the deferred timer repair, NOHZ tick
+    handling and interrupt accounting from irq_enter_rcu().
+
+  * irq_exit_rcu_preempt_counted_prepare() performs interrupt accounting,
+    softirq handling and NOHZ tick handling while carrying any applied
+    hardirq count across the traceable exit path. When an applied outer
+    hardirq invokes softirqs, both the preempt-count and lockdep
+    classifications temporarily switch from hardirq to softirq and back. The
+    architecture immediately follows the preparation with
+    irqentry_hardirq_exit_finish(), which performs the conditional raw-count
+    subtraction and lockdep teardown.
+
+The staged addition carries an opaque state into its instrumentable finish and
+matching teardown. With DEBUG_PREEMPT and no separate reschedule bits, an
+already-negative count follows the legacy DEBUG_LOCKS_WARN_ON() rule. During
+an oops the warning condition is bypassed and the addition is applied.
+Otherwise the attempt is rejected and leaves the count unchanged. Its finish
+attempts deferred reporting, which an intervening oops can suppress. A
+rejected token always skips post-add bookkeeping and the matching subtraction,
+independently of whether reporting produced a warning.
+
+The real interrupt is complete after that teardown. Return-to-kernel
+preemption can schedule and migrate the task before the architecture-specific
+tail runs, so the current preemption count cannot identify the original entry
+class. irqentry_state_t retains that provenance instead.
+
+For an ordinary hardirq returning to kernel mode,
+irqentry_hardirq_tail_enter() makes a fresh staged attempt to add
+HARDIRQ_OFFSET and establishes lockdep hardirq nesting after the preemption
+decision. This synthetic classification covers traceable architecture tail
+work, deferred timer rearming, IRQ-on preparation and context-tracking
+preparation. It does not repeat interrupt accounting, RCU or tick entry.
+IRQ-on preparation requires this synthetic lockdep nesting to remain present.
+An interrupted outer hardirq can contribute additional nesting.
+
+irqentry_hardirq_tail_exit() performs the final traceable teardown preparation
+and then conditionally removes any applied raw synthetic count. For an applied
+staged count at outermost hardirq depth, both retained exit points recheck
+regular softirq work and forced-thread timer work raised by late callbacks and
+wake the corresponding workers before ending hardirq state. If the interrupted
+context was in an RCU extended quiescent state,
+ct_irq_exit_prepare() runs before the raw tail teardown and
+ct_irq_exit_finish() completes the transition afterwards.
+
+On arm64 the ordinary lifecycle is selected only after the pseudo-NMI
+decision. Pseudo-NMIs continue to use irqentry_nmi_enter() and
+irqentry_nmi_exit(). All raw transitions are in noinstr paths, so
+preempt_count(), the raw preempt-count update helpers and
+__kern_my_cpu_offset() must remain inline. The arm64 conversion includes the
+first requirement and depends on the `arm64 raw preempt-count inlining
+prerequisite`_ and `arm64 per-CPU offset inlining prerequisite`_ for the
+others.
+
+.. _`arm64 raw preempt-count inlining prerequisite`:
+   https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
+
+.. _`arm64 per-CPU offset inlining prerequisite`:
+   https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org
+
 Even though interrupt handlers are expected to run with local interrupts
 disabled, interrupt nesting is common from an entry/exit perspective. For
 example, softirq handling happens within an irqentry_{enter,exit}() block with
-- 
2.39.5 (Apple Git-154)

