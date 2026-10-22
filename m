Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646263;
	b=JDR0LJuR/izGB/jHLOucWBhAu3WGkx8/SuKERrU8dBH7UAswlLEvjgT2t+CVY4aZ8Ufm
	 xDCJHqQtEar2l8Bewf/vPaSTGLo/wEV8YRuuf3xRKgbLJYCiovumEmR5ymtDFv+pT/rIb
	 X8hO89teVVgbFiQwSzrhGs/Qyzuesygw6bZz6wq0KstJyOgB+0cMglXbjdhtO0/vzE0cS
	 39H5BtHRVK5j6GC4HoERZVRouCdDTPB7zQ6wR+1YPLHHCPPTYJXkwEZ6ru34Pekfg9z+D
	 3NOTpXfOPcNIjOJPu5niBsdfnBIXokthq54UZWwkImVgjznjtcudoOSQCpKNnyinxdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kNAQ43P7mOXqvjFIm1UIgh+LHBg4TUD3j/lYh+CFxWo=;
	b=i3IZlIxyLqF/Ak8EY9sqe5r4CxyKY/l10++Vq8Cl7HRrzS60S8Kq/sMlnvOlVl2WNzk+
	 meWtGlMtLTZyUbpuKpa7dcarSsReTXKDipDuz7S/H4OKx/9MrhmfK/a/jnoYWU/2WsRWB
	 85fdu8iDXY0zY+CScvuj/SprYPuZDS3TrprfVAwBwQ31jWG7JZ1N6+yz4Yka7uFwskw92
	 6dR0mOVYHWt7z51UqPAHzFtggE0FnBKWjyO3M7OO9U2uNclG2G62x+oiVPtDbAQrD6Trz
	 BNtWsKMckeNWgkfg3xVJrKL0bqMYfXx41nzr/n4yTMA3gEmosc/58nGJwCGN7Qxt3UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sVoa5sPI;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC360A2620
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43BC360A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sVoa5sPI
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so9975365e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646262; x=1793251062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNAQ43P7mOXqvjFIm1UIgh+LHBg4TUD3j/lYh+CFxWo=;
        b=sVoa5sPIaKdctHZpZqX/Tr/a3nD/WcLeHZH9WemG0HXKqTdFFgQaFQZ4Cur//1TVtP
         +IJn6IC0dDP6m4vxjQWZ5aR79dbKnXLHOPNUVurEmFnZV/yqzsl/muVxW+cMH/0zPQdd
         dK/8pqIuUUk9dLZUuIQTWEglQ5bCKqg/XsY7lVX/kuRlghT8EUfinDMS4f2mkQ8Mt9Fz
         EmXEQVQ/l6Wtatrq/tc7Is3h3kRt4DHc0JnYD0UP1IIfrpj77eW+iAD7w+r8XxYlAHrZ
         EElQx2RYSJCa1tDUa2Y9+3pFcnzxyHS/dBzXaHOgb2gR8NWlTrnSbb607yDipz8V6BfE
         WVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646262; x=1793251062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNAQ43P7mOXqvjFIm1UIgh+LHBg4TUD3j/lYh+CFxWo=;
        b=QT2jMcq1Rs6DaZGhT+WdedKlBCRlqE+xW4OtfWCJU+T11+OwJptNHocHK6Zj3lwhTk
         taTLAzMMUuexBM1LJUd8ZhdEbnLVRbhWSmlYh5RZvicUi5+A0Ceppnd/IXb/itT9DWvM
         rUZcRG1rG6kzLkS7Od/lt45pyQkKjJgm4Jag0LKedfFHPr99+Kh7nYQnp2v9eGvEHP37
         HxDYCNIYoj9RcV410BTarYGhhyab0+ytudf2Mk2Hu1sgK+HsSk+Z2hUcLOcx8V6Ju9FM
         FFkGe19rKEg3KhUsavvGuF/JNpCW5eK+Ajupj9rKcbyU498GTZWtEjj4IjqHnbxap6t/
         mGpg==
X-Forwarded-Encrypted: i=1; AKwUvBwquS02MbI5jFLTJL/wwme6rmLrdq1fIGkidBtFdokGIugZq6GrPD0KmPe3oZ8HB2obWhC/hF/f/kmYMZH2yjDjXt4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmr/7g6RjNwhCOP/D/058WkFJaIdr6zye1hj+ZMxllfErGEopB
	IOJ9ONtXMKFnDrZeWmlkUMk3+07t3pGhxqDo0RpyxZ4uwbGge/8ThSYl
X-Gm-Gg: AYBFou2UUt57pFpVkCtRPsqZkDZSzQQXKfnvz7jY+riJZ6YsEcjgSHWtuRpeU19ewnV
	/NurW3HnLjP5h7uEIJuIEPQwdjk8XEFzu4+W9ZLiukuWgbEibBK08eabIvtIArgBogKS/0ZNAiL
	DVAeUdx96SbGZiUiZfCFBej7iJ/08A7JI6M5Vw8016L6KM+xpER2zahMRmqc1vEDuTGhMX/+y8o
	hWm6Tfg99apiHeIyfQpgVJawaNpneodzrqjoDFlhMQmsQzIUAeps2Dj2WLMx2P2LET4gQyi4jhJ
	FDBrF6K1CV21Q4Kkt/4S2FIJ+W1+/weUXBH9f+saYf+BeB7JCfYYUQib5zL8bDgo0AxUXTpCJ/N
	+vmEzmwuopzqrPuMziGfIe6bSfqFMSjNxSYUJX77hEDF8vVG3p11wS+odicQa9Fr6heHMSgNN42
	WwvWvwQk01Cmlsq1mBf+zICYE6UDXXUoLGyJKfQOovteZ8A678SnahtJ6mIamy/akyy9wGrvp2g
	51kmVamjoSCCPSlNEmsNLrk5FHT1eHvnXI1hRl6iFz+/QkTD4jz1qzXehtdeOQQsvvqc2zVrIjH
	HDnMWmtS3eBGrlBcarbmHbyZrXn8ptyuqnlBH2PV5JYVDdVyEpSz9Hm9fAz4lR9Z/bWOWSC90FV
	U4YZ53xP5MI3vyyMF+dd8s0OC3QWqPKYoSfFMXVw743QPt7xzsMyB6oAsBidAYBXq2vshuI2c0y
	MEq7qoGw==
X-Received: by 2002:a05:600c:8b4c:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4a20729f92bmr16486165e9.8.1792646261504;
        Wed, 21 Oct 2026 22:17:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:41 -0700 (PDT)
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
Subject: [RFC PATCH 09/12] arm64: Use the pre-counted hardirq lifecycle
Date: Thu, 22 Oct 2026 07:16:51 +0200
Message-Id: <20261022051654.79224-10-kmehltretter@gmail.com>
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

Ordinary EL0 and EL1 interrupt paths establish generic entry state before
irq_enter_rcu() adds HARDIRQ_OFFSET and lockdep nesting. Callbacks in that
early window are therefore not classified as hardirq work. Their exit paths
also drop the classification before function-graph return callbacks and the
kernel return tail have completed.

After the EL1 pseudo-NMI decision, enter ordinary interrupts through
irqentry_hardirq_enter(). Complete delayed timer and accounting work with
irq_enter_rcu_preempt_counted(). Use the retained exit preparation followed
immediately by raw count and lockdep teardown.

For kernel returns, restore return-tail classification after masking DAIF
and before MTE exit tracing. Keep the pseudo-NMI lifecycle unchanged. Force
arm64 preempt_count() inline so noinstr callers cannot be outlined into
instrumentable text.

The noinstr path also depends on the raw preempt-count and
__kern_my_cpu_offset() inlining changes carried as patches 1 and 2. Keep
them separate because they are externally authored fixes.

Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
Link: https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org
Assisted-by: LLM
---
 arch/arm64/include/asm/preempt.h |  2 +-
 arch/arm64/kernel/entry-common.c | 23 +++++++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 4f917596f387d..3d61be0f825fb 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -7,7 +7,7 @@
 #define PREEMPT_NEED_RESCHED	BIT(32)
 #define PREEMPT_ENABLED	(PREEMPT_NEED_RESCHED)
 
-static inline int preempt_count(void)
+static __always_inline int preempt_count(void)
 {
 	return READ_ONCE(current_thread_info()->preempt.count);
 }
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 93056a766fb20..fda807c61ff27 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -56,6 +56,8 @@ static void noinstr __arm64_exit_to_kernel_mode(struct pt_regs *regs,
 						irqentry_state_t state)
 {
 	local_daif_mask();
+	/* arm64 uses the split exit API, so enter the tail before MTE tracing. */
+	irqentry_hardirq_tail_enter(state);
 	mte_check_tfsr_exit();
 	irqentry_exit_to_kernel_mode_after_preempt(regs, state);
 }
@@ -523,12 +525,16 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 				      void (*handler)(struct pt_regs *))
 {
 	irqentry_state_t state;
+	bool do_sub;
 
-	state = arm64_enter_from_kernel_mode(regs);
+	state = irqentry_hardirq_enter(regs);
+	mte_check_tfsr_entry();
+	mte_disable_tco_entry(current);
 
-	irq_enter_rcu();
+	irq_enter_rcu_preempt_counted();
 	do_interrupt_handler(regs, handler);
-	irq_exit_rcu();
+	do_sub = irq_exit_rcu_preempt_counted_prepare();
+	irqentry_hardirq_exit_finish(do_sub);
 
 	arm64_exit_to_kernel_mode_preempt(regs, state);
 }
@@ -839,16 +845,21 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 static void noinstr el0_interrupt(struct pt_regs *regs,
 				  void (*handler)(struct pt_regs *))
 {
-	arm64_enter_from_user_mode(regs);
+	bool do_sub;
+
+	(void)irqentry_hardirq_enter(regs);
+	mte_disable_tco_entry(current);
+	sme_enter_from_user_mode();
 
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
 
-	irq_enter_rcu();
+	irq_enter_rcu_preempt_counted();
 	do_interrupt_handler(regs, handler);
-	irq_exit_rcu();
+	do_sub = irq_exit_rcu_preempt_counted_prepare();
+	irqentry_hardirq_exit_finish(do_sub);
 
 	arm64_exit_to_user_mode(regs);
 }
-- 
2.39.5 (Apple Git-154)

