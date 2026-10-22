Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645680;
	b=yyucwDlzuhofsPi0vA20ChuBW4No1NJqJ+BaIRnB8woEKfav8J8EVAQcku0Wt2kjdToX
	 KCBePWGx2J7yr5kDcEBzxUjI6C51adWy8Kl1b8vSE5JVuSweudgVjBKdc+B/LEyBTvp5p
	 shUUtl28vZjUBwRKKq2EuxFTDa9Y/K83cGzDtS+i2wRZ5oX+yRnA5A67DH7Dtx9cLvFvj
	 H2PNNzsIKu4O37LNf9beMD67o0jiPH39Y1DxvK90qFmQi/VQ7Y4KObxa2J7AH0voYoUqg
	 5/Irls3rYxIihL3piWSndw3nSRTh/T4hOcICiCeGrA0FbwWL1qmEWDM52rrXNYNCIKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Qrw1ULjt+JjGEdYQsfQr+ebS9fDMiy8zq5/jCMfCY98=;
	b=X8jzOY9vZXxSypq8r2bTE1GmNch2we7ezdTY7y3T/D0Cw2KecBUv5aTQ9Qso3VAA3d7M
	 Uy5JYpmxMIKPsqHVt9RIqPUGbYXPSVh/XiUKEs8l8gnxucBtYcJmuslqeuTbecd77Xz1Q
	 9Oc/QkZYYUzFnpYhQZ6Ba067HZgUJDODZwa4pMv7J1WZ8XVPwMvK483C+M7fUYoP0A9dh
	 3z0J6KP3fxyCJGTD7PNuM8sMy1p6wkOgqqzFfxZWaF0BsekLCfHzCQMA3DaFJjkvJWWZl
	 JHKF+PVyT7iq5cANBFgtGIMSorHBFOsx9MlBKo+UNfckjN4ZA32JQ1RMF4xHCqCX19Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oQLVWCB9;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E9606A32E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E7E9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oQLVWCB9
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dee593f18so1118338f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645678; x=1793250478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qrw1ULjt+JjGEdYQsfQr+ebS9fDMiy8zq5/jCMfCY98=;
        b=oQLVWCB9w1aiSsapnFtew3AebgDpmw2NDtn3ZT/1jTGeXP6gB7WhXjLGMmm9NWmiqj
         K60zlrky5A3zuKmBukH5XRv3m0h6ZD8X7eirW3hewZ7cy3Ev1hFwdgFLVpZg7GgxDKz1
         ud9HekXYDqE2d4IWpj1hPMJz5YgTWByR7SezsBGLXcIv4E5FXQ91PXtzJThHaFKDBsiw
         bu6c+g4yD8pyHC66COqF1oZEASy1c0TejYYnhDki7GH4TtKBR6rlknCUH8YHA3FFb01Y
         SxZMwpk4G5rJgREDb631kKzsT0HWhz/0+zinvd88ETqHjeMumhW90scRLfnrc9r7kvEj
         Ec0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645678; x=1793250478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qrw1ULjt+JjGEdYQsfQr+ebS9fDMiy8zq5/jCMfCY98=;
        b=H8t/GZfIrHDzb31Q5QLcujtM3jfcNy/vsFoKTpX1b/MLAEjmksC0lxzU+sjo2v5v9u
         2ZJlaY56pbIetdOPJbHhAKMk6dZ7an9XcQENoag8j8zG6fPlGrUI7FZ+XkeDa18NCOEc
         x14saaA4SZf4On1ZRrJlb7DFkZdEQN6G6JYorrGIwbKnmecT5S7KreDMwcRLNwkk294Y
         /GAbDkMxreCeIR4fa8J6RuqrBRxsa5TIZ5T+ptKJZDDNDNvSt+Kd4FUuX4M/WjsPFNkX
         iGWWJ2HzI2dOdBmL5LpKa6ISoL/4gCr/l0kEaFDvoR6bzgZFlG94A3XUIvsil/vjqwKS
         peWg==
X-Forwarded-Encrypted: i=1; AKwUvBz9preWRrZ4KppXRO5Z6d8+4pXzeMkWlB8rRO+E8g+IKKJ65r0B2XBUSYlrWFSwdUsi+7LnXvtKQcloKJpgFN9i5WM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9S8UlGQiR3/paMuKul9NG9jBJOPIZ88blJM5s40MmiqIn+/IU
	yzewKBsHeqqLr8lEBVMVbVQFLiDpQtOdEtxGmMZavViQ5fLFMd+fph1LuZ0X5/FZ
X-Gm-Gg: AYBFou3X2LKFdv4DyhfapXPVy9Ip6lmAvO6ayvo7rCN1mVAZI93cWEmzQIPpSM06Wc4
	H3xRHDVNpeBwsKRy6R/BWwsMq0LwH5AbbGvYLKMzZFeAGrhKSVhFe+TNyWVciBxBzQCDc2S9CIy
	4fcg9JUEMNXITudPBAmYNBbxQLWedbmppsjGvy7lUkERirRy4HXQvxbooaLXunZn/kMBTNHqbXq
	Thge37sqJRwNp12eJxqukwbGLXP7nLTOka3wFsnwAzRaqufrdhN6vRAaADXYJU1QSo/QojScFwP
	vJCk0WKwadUDIZU5IJtcNpHDreVh2hOYbpZaTg6W3QxwD1qZtXhu/rul14baP5BdTgPNQ0vpSul
	MV2FD6VWo8Xdjct0EVGTcjqAh2lbzaZEiFb2hV5FhzBiZdb6Wp9Ouq2Ip7VziSbHhFTkLVH+H/7
	WCb4tyMXrKjNCvmRrfLky+YN54CllnjxtlzTC9mIRHe4spU+4stdn4YgSogXKAywRApvCGBCMO+
	SMKAUiOGz8g72ARM4j3b8RYdJZi5x+xKCmAueZk/iHcXt/5NEI9jkEuKWN5HUdTs335zEv+Dk62
	XvDMxsDp1NqbFbiWlDFdRtIAiHynEE5YrUTwLTO2CESQ4/wCZsBND5yGagZ16rBz08MvsG4tDqp
	VtAyJ2ICkKCaONpkPVolZ803FdYv+Vs/p4u4w6pFadiMxp+kgsf0G/mOxrYo=
X-Received: by 2002:a5d:4f04:0:b0:48d:deaa:4dbb with SMTP id ffacd0b85a97d-48e264cd228mr5976694f8f.40.1792645677744;
        Wed, 21 Oct 2026 22:07:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:56 -0700 (PDT)
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
Subject: [RFC PATCH 9/9] rv: Test IRQ-exit softirq provenance and handoff
Date: Thu, 22 Oct 2026 07:07:12 +0200
Message-Id: <20261022050712.75035-10-kmehltretter@gmail.com>
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

When IRQ exit processes softirqs inline, it replaces hardirq context with
serving-softirq context and restores hardirq context afterwards. Extend
the irqstate KUnit tests to cover this transition, nested hardirqs,
monitor synchronization and the from_hardirq value.

Exercise work raised by the softirq-entry, softirq-exit and final
hardirq-exit callbacks. Verify the ksoftirqd handoff and, with forced IRQ
threading, the ktimerd-to-ksoftirqd chain.

PREEMPT_RT does not process softirqs from IRQ exit. Skip the IRQ-exit
inline cases and require no hardirq provenance for RT softirq events.

Assisted-by: LLM
---
 Documentation/trace/rv/monitor_irqentry.rst   |  40 +-
 .../rv/monitors/irqstate/irqstate_kunit.c     | 443 +++++++++++++++++-
 kernel/trace/rv/rv_monitors_test.c            |   2 +
 3 files changed, 470 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/rv/monitor_irqentry.rst b/Documentation/trace/rv/monitor_irqentry.rst
index c2b7739a061f0..5d293207b6491 100644
--- a/Documentation/trace/rv/monitor_irqentry.rst
+++ b/Documentation/trace/rv/monitor_irqentry.rst
@@ -269,20 +269,32 @@ overflow.
 ``rv_test_irqstate_sync`` resets and enables the bare adapter inside single
 and nested hardirq contexts, inside a real serving-softirq callback, and
 inside a hardirq interrupting that callback. Valid unwinding must establish
-idle without a reaction. A separate unmatched exit must then react exactly
-once. The softirq cases snapshot reactions before the invalid control, so
-an error on the valid sequence cannot replace the expected later error.
-These are adapter synchronization tests, not concurrent tracefs writes.
+idle without a reaction. On non-RT, it also enables between hardirq entry
+and inline softirq processing. The provenance-marked softirq pair must
+remain unsynchronized until the final hardirq exit establishes idle. A
+separate unmatched exit must then react exactly once. The softirq cases
+snapshot reactions before the invalid control, so an error on the valid
+sequence cannot replace the expected later error. These are adapter
+synchronization tests, not concurrent tracefs writes.
 
 ``rv_test_irqstate_irq_exit_inline`` schedules a tasklet inside a real generic
 hardirq boundary and requires non-RT ``irq_exit_rcu()`` to process it before
-returning. Independent boundary probes require exactly one softirq entry
-before the tasklet and one exit afterward. The callback must run in the same
-task and on the same CPU with interrupts enabled and serving-softirq state set,
-but outside hardirq context; the monitor must accept both context pairs and
-the original counts must be restored. If the kernel diverts the tasklet to
-ksoftirqd, for example under forced IRQ threading, the test drains it and
-skips because that configuration does not provide the inline path.
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
 
 ``rv_test_irqstate_rt_inline_bh`` forces a pending tasklet through the
 PREEMPT_RT ``local_bh_enable()`` inline-processing path. It requires the
@@ -290,13 +302,15 @@ tasklet to finish synchronously in the enabling task, on the same CPU, while
 serving-softirq state is set and local interrupts are enabled. Independent
 boundary probes require exactly one entry before the callback and one exit
 afterward, both with local interrupts disabled and live serving state set;
-the monitor must accept the pair and the original counts must be restored.
+both must report no hardirq provenance. The monitor must accept the pair and
+the original counts must be restored.
 
 ``rv_test_irqstate_rt_empty_worker`` uses a KUnit-only seam around the same
 PREEMPT_RT worker entry and exit helpers, without calling
 ``handle_softirqs()``. It requires exactly one accepted context pair and no
 ``softirq_entry`` or ``softirq_exit`` action from the synthetic owner between
-those boundaries. The seam wakes ksoftirqd while interrupts are disabled so
+those boundaries. Both events must report no hardirq provenance. The seam
+wakes ksoftirqd while interrupts are disabled so
 pending work which races with the test remains scheduled. This
 deterministically covers the owner's no-handler interval; it does not invoke
 the smpboot predicate or prove that the current task is the real ksoftirqd
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
index e3928d10b2825..31e827cdba1c6 100644
--- a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
@@ -13,6 +13,7 @@
 #include <rv/kunit.h>
 #include <rv_trace.h>
 #include <trace/events/irq.h>
+#include <trace/events/sched.h>
 
 #include "irqstate_kunit.h"
 
@@ -510,6 +511,44 @@ static void rv_test_irqstate(struct kunit *test)
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
@@ -811,6 +850,32 @@ static void rv_test_irqstate_sync(struct kunit *test)
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
 	KUNIT_ASSERT_TRUE(test, completed);
@@ -838,20 +903,31 @@ struct irqstate_preempt_ctx {
 
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
+	unsigned int entry_tasklet_runs;
 	unsigned int exit_tasklet_runs;
 	bool armed;
+	bool raise_on_entry;
 	bool raise_on_exit;
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
@@ -860,6 +936,8 @@ struct irqstate_inline_bh_ctx {
 	bool tasklet_bracketed;
 	bool entry_attached;
 	bool exit_attached;
+	bool hardirq_entry_attached;
+	bool hardirq_exit_attached;
 };
 
 struct irqstate_empty_worker_ctx {
@@ -883,6 +961,19 @@ struct irqstate_empty_worker_ctx {
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
 static bool irqstate_empty_worker_matches(struct irqstate_empty_worker_ctx *empty_ctx)
 {
 	/* Pairs with owner publication in both empty-worker test paths. */
@@ -893,6 +984,39 @@ static bool irqstate_empty_worker_matches(struct irqstate_empty_worker_ctx *empt
 	return !empty_ctx->real_worker || softirq_kunit_empty_worker_active();
 }
 
+static void irqstate_inline_hardirq_entry(void *data, unsigned int depth)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx = data;
+
+	/* Inline softirq processing enables IRQs; ignore a nested real IRQ. */
+	if (!READ_ONCE(inline_ctx->armed) || current != inline_ctx->owner ||
+	    depth != 1)
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
+	    depth != 1)
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
@@ -901,10 +1025,21 @@ static void irqstate_inline_bh_entry(void *data, bool serving,
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
@@ -915,8 +1050,15 @@ static void irqstate_inline_bh_exit(void *data, bool serving,
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
@@ -949,6 +1091,14 @@ static void irqstate_inline_bh_exit_tasklet(struct tasklet_struct *tasklet)
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
@@ -961,6 +1111,7 @@ static void irqstate_inline_bh_kill_all(void *data)
 	struct irqstate_inline_bh_ctx *inline_ctx = data;
 
 	tasklet_kill(&inline_ctx->tasklet);
+	tasklet_kill(&inline_ctx->entry_tasklet);
 	tasklet_kill(&inline_ctx->exit_tasklet);
 }
 
@@ -969,6 +1120,12 @@ static void irqstate_inline_bh_detach(void *data)
 	struct irqstate_inline_bh_ctx *inline_ctx = data;
 
 	WRITE_ONCE(inline_ctx->armed, false);
+	if (inline_ctx->hardirq_exit_attached)
+		unregister_trace_hardirq_context_exit(
+			irqstate_inline_hardirq_exit, inline_ctx);
+	if (inline_ctx->hardirq_entry_attached)
+		unregister_trace_hardirq_context_entry(
+			irqstate_inline_hardirq_entry, inline_ctx);
 	if (inline_ctx->entry_attached)
 		unregister_trace_softirq_context_entry(irqstate_inline_bh_entry, inline_ctx);
 	if (inline_ctx->exit_attached)
@@ -976,6 +1133,248 @@ static void irqstate_inline_bh_detach(void *data)
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
+		unregister_trace_hardirq_context_exit(
+			irqstate_hardirq_exit_raise, exit_ctx);
+	tracepoint_synchronize_unregister();
+	tasklet_kill(&exit_ctx->tasklet);
+}
+
+/* Work first raised at the final hardirq boundary must reach ksoftirqd. */
+static void rv_test_irqstate_hardirq_exit_handoff(struct kunit *test)
+{
+	struct irqstate_hardirq_exit_ctx *exit_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long flags;
+	int ret;
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+	exit_ctx = kunit_kzalloc(test, sizeof(*exit_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, exit_ctx);
+	tasklet_setup(&exit_ctx->tasklet, irqstate_hardirq_exit_tasklet);
+	exit_ctx->owner = current;
+	exit_ctx->owner_cpu = raw_smp_processor_id();
+	exit_ctx->softirqd = this_cpu_ksoftirqd();
+	KUNIT_ASSERT_NOT_NULL(test, exit_ctx->softirqd);
+	if (local_softirq_pending() ||
+	    !wait_task_inactive(exit_ctx->softirqd, TASK_INTERRUPTIBLE)) {
+		kunit_skip(test, "Requires an idle local ksoftirqd");
+		return;
+	}
+
+	ret = register_trace_hardirq_context_exit(
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
+	local_irq_save(flags);
+	if (local_softirq_pending() || task_is_running(exit_ctx->softirqd)) {
+		local_irq_restore(flags);
+		kunit_skip(test, "Local ksoftirqd stopped being idle");
+		return;
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
+	kunit_release_action(test, irqstate_hardirq_exit_cleanup, exit_ctx);
+	KUNIT_EXPECT_TRUE(test, exit_ctx->callback_seen);
+	KUNIT_EXPECT_TRUE(test, exit_ctx->tasklet_pending);
+	KUNIT_EXPECT_TRUE(test, exit_ctx->softirqd_already_runnable);
+	KUNIT_EXPECT_FALSE(test, exit_ctx->bad_context);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+}
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
+		unregister_trace_hardirq_context_exit(
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
+	unsigned long flags;
+	int ret;
+
+	if (!force_irqthreads()) {
+		kunit_skip(test, "Requires forced IRQ threading");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+	timer_ctx = kunit_kzalloc(test, sizeof(*timer_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, timer_ctx);
+	tasklet_setup(&timer_ctx->tasklet, irqstate_timer_exit_tasklet);
+	timer_ctx->owner = current;
+	timer_ctx->owner_cpu = raw_smp_processor_id();
+	timer_ctx->softirqd = this_cpu_ksoftirqd();
+	timer_ctx->timersd = this_cpu_read(ktimerd);
+	KUNIT_ASSERT_NOT_NULL(test, timer_ctx->softirqd);
+	KUNIT_ASSERT_NOT_NULL(test, timer_ctx->timersd);
+	if (local_softirq_pending() || local_timers_pending_force_th() ||
+	    !wait_task_inactive(timer_ctx->softirqd, TASK_INTERRUPTIBLE) ||
+	    !wait_task_inactive(timer_ctx->timersd, TASK_INTERRUPTIBLE)) {
+		kunit_skip(test, "Requires idle local softirq workers");
+		return;
+	}
+
+	ret = register_trace_hardirq_context_exit(
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
+	local_irq_save(flags);
+	if (local_softirq_pending() || local_timers_pending_force_th() ||
+	    task_is_running(timer_ctx->softirqd) ||
+	    task_is_running(timer_ctx->timersd)) {
+		local_irq_restore(flags);
+		kunit_skip(test, "Local softirq worker stopped being idle");
+		return;
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
@@ -995,8 +1394,11 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 	inline_ctx = kunit_kzalloc(test, sizeof(*inline_ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, inline_ctx);
 	tasklet_setup(&inline_ctx->tasklet, irqstate_inline_bh_tasklet);
+	tasklet_setup(&inline_ctx->entry_tasklet,
+		      irqstate_inline_bh_entry_tasklet);
 	tasklet_setup(&inline_ctx->exit_tasklet,
 		      irqstate_inline_bh_exit_tasklet);
+	inline_ctx->expected_from_hardirq = true;
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, irqstate_inline_bh_kill_all,
 						  inline_ctx));
@@ -1008,6 +1410,14 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, irqstate_inline_bh_detach,
 						  inline_ctx));
+	ret = register_trace_hardirq_context_entry(
+		irqstate_inline_hardirq_entry, inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->hardirq_entry_attached = true;
+	ret = register_trace_hardirq_context_exit(
+		irqstate_inline_hardirq_exit, inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->hardirq_exit_attached = true;
 	ret = register_trace_softirq_context_exit(irqstate_inline_bh_exit,
 						  inline_ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -1039,6 +1449,7 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 		return;
 	}
 	WRITE_ONCE(inline_ctx->armed, true);
+	WRITE_ONCE(inline_ctx->raise_on_entry, true);
 	WRITE_ONCE(inline_ctx->raise_on_exit, true);
 	irq_enter_rcu();
 	tasklet_schedule(&inline_ctx->tasklet);
@@ -1063,6 +1474,7 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
 	}
 
 	KUNIT_EXPECT_EQ(test, inline_ctx->tasklet_runs, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->entry_tasklet_runs, 1U);
 	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_serving);
 	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_same_task);
 	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_same_cpu);
@@ -1074,8 +1486,15 @@ static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
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
@@ -1105,6 +1524,7 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
 	inline_ctx = kunit_kzalloc(test, sizeof(*inline_ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, inline_ctx);
 	inline_ctx->owner = current;
+	inline_ctx->expected_from_hardirq = false;
 	tasklet_setup(&inline_ctx->tasklet, irqstate_inline_bh_tasklet);
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, irqstate_inline_bh_kill,
@@ -1144,8 +1564,13 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
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
@@ -1170,7 +1595,8 @@ static void irqstate_empty_worker_entry(void *data, bool serving,
 		empty_ctx->bad_order = true;
 	empty_ctx->event_index++;
 	empty_ctx->inside_pair = true;
-	if (!serving || !in_serving_softirq() || !irqs_disabled())
+	if (!serving || from_hardirq || !in_serving_softirq() ||
+	    !irqs_disabled())
 		empty_ctx->bad_boundary_context = true;
 	if (raw_smp_processor_id() != READ_ONCE(empty_ctx->owner_cpu))
 		empty_ctx->bad_boundary_cpu = true;
@@ -1187,7 +1613,8 @@ static void irqstate_empty_worker_exit(void *data, bool serving,
 	if (empty_ctx->event_index != 1 || !empty_ctx->inside_pair)
 		empty_ctx->bad_order = true;
 	empty_ctx->event_index++;
-	if (!serving || !in_serving_softirq() || !irqs_disabled())
+	if (!serving || from_hardirq || !in_serving_softirq() ||
+	    !irqs_disabled())
 		empty_ctx->bad_boundary_context = true;
 	if (raw_smp_processor_id() != READ_ONCE(empty_ctx->owner_cpu))
 		empty_ctx->bad_boundary_cpu = true;
@@ -1570,6 +1997,16 @@ static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
 }
 
 #else
+static void rv_test_irqstate_hardirq_exit_handoff(struct kunit *test)
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
@@ -1613,6 +2050,8 @@ static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
 #define rv_test_irqstate_depth_overflow rv_test_stub
 #define rv_test_irqstate_sync rv_test_stub
 #define rv_test_irqstate_live_toggle rv_test_stub
+#define rv_test_irqstate_hardirq_exit_handoff rv_test_stub
+#define rv_test_irqstate_hardirq_exit_timer_handoff rv_test_stub
 #define rv_test_irqstate_irq_exit_inline rv_test_stub
 #define rv_test_irqstate_rt_inline_bh rv_test_stub
 #define rv_test_irqstate_rt_empty_worker rv_test_stub
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index be3aaae2613a8..0e2d693673cc3 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -167,6 +167,8 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_irqstate_depth_overflow),
 	KUNIT_CASE(rv_test_irqstate_sync),
 	KUNIT_CASE(rv_test_irqstate_live_toggle),
+	KUNIT_CASE(rv_test_irqstate_hardirq_exit_handoff),
+	KUNIT_CASE(rv_test_irqstate_hardirq_exit_timer_handoff),
 	KUNIT_CASE(rv_test_irqstate_irq_exit_inline),
 	KUNIT_CASE(rv_test_irqstate_rt_inline_bh),
 	KUNIT_CASE(rv_test_irqstate_rt_empty_worker),
-- 
2.39.5 (Apple Git-154)

