Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646241;
	b=YMSEGMzi+uzojTtaUacTWcD4yza/m89IszkFr3T8o70pa5IOCYKBJJ8//BJ6xjpHxkvO
	 YHQ8tWBzC7OPg9E2CdAkXkGe5u60KDm7ROalXg/AEwFW1i+ClRHtSToT82JWEVtTxV/D9
	 sHc9bjVkr0N1q6A610TcPJNtk1sa7+HRMJs4+P3R08doAU/1YxzAvyQC0zgZZ3VTkskUA
	 tKew4JWYJRwilxwWfb8IDnrGW6pFz1jlyHLYM4aK13G1pJ55yRErXOk7uMVyft0G0aiCG
	 mXvvAGEU6r/R/m7fNY/axPX3G4Wh8spCgU8R312fWJdmwMVs8WGqTXPguY6Ty4ZTb5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FHADbTy4zikl0HljBSmGkN/GzMWvpwiot6dr8kUaUas=;
	b=qFT9LFsB/n269cHstVl/wWmxiFQlGxnrlRevHjhOhe6P+E4V9pOpcihg1vtYa3qNcHrX
	 srDrMp2Ri5W6gPgji/vZrU5mD+yMTtUL3VH/YoW1ietpxcWJwXtxoTns5bf6icIfy4/2r
	 kwFfNJSr3ZBefISd04DfapUVKjTbCXRUH8YlzN+SA+orlOO5WHwpCsjaZmI0V8NtVJCaJ
	 +fMuEwT5J3ZRFWtUXhwInFflRgQtoqT4E3KluZHEtv/Rpdm9xBpFGmV1dFFHzJXg9Zt5w
	 jBijFEr0Fkk6fsXXpZMKx2A9YMjiWzf6KGZpr3LeuexaLntw5UeB0WQLiHvYCCd4W5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJ8MVNqh;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD360A2607
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCCD360A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJ8MVNqh
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so2693665e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646239; x=1793251039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHADbTy4zikl0HljBSmGkN/GzMWvpwiot6dr8kUaUas=;
        b=GJ8MVNqhnRrntr8SgM6UXidafF9eU+ZQd0Vc/ExGUloc15ICieAVftx4JAH7vssIeT
         gpv1uP2i99q9zJ7GxU1h5yYfKyuzVcFR7Pf5JBSLyLK829+VLlQ12Z7kIXurKA4HG4ss
         osOi8laCeLfIQtlnhFnufp/2cCQIsFivtIAPydAIib6/CYQSsgoilMYGcNVyRFWISaqG
         dzpiVJwT8C8qKYJuoSEyx5NflmKu369uj7BXTlEhpeqeV/LD+TqcsWtCVBIxlPNVIajX
         19LhZq/cRLgIIj8i7ZTD3NJvMpJClkpLPaeViTVwH6vouvhThL2rGV3cGBO7lTEyIHKV
         K6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646239; x=1793251039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHADbTy4zikl0HljBSmGkN/GzMWvpwiot6dr8kUaUas=;
        b=lzOgV6/mtp8S/FYTvdwBs7kQud8StfExUP3A6nKqmo3jkikf1SCa4F0uvp1TN+j1g2
         JLr6c8IbZ6PqbjbmY285EvZTZs7pU277Nep4Zmso9bFUZAGL+TBqpN7rE1WixsoZLZ2z
         9TcG+/dTrULLAe1zA2ZPvCQPz1uGfZJpvOOLCaryJ9H0+co4Mr5d/0ksceqcjCnVC/uI
         pRb2okTeWjYUQfuYQcp3VLkaTkXNtJ7Ucu5hgk8yPzNRLJjlEGMIyAq6w15Xf35jnH7B
         M5aEcLn2wkDEcvKUBhHzfmIVzllmuHxmirGVv4TU31mE60iQia1mG3VpqZpB2PhIOkSD
         w9jA==
X-Forwarded-Encrypted: i=1; AKwUvBwPUbSW4mMBS0MGBdtvVx666v4UIEhSD9hlxQOrxhDw9ZiOM3zkosfLQRNqtJl4326oS5X8K3IK9SMTomz1TeIF4iE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKDTVmdUxxsvhdymqhjULSgZkX9nLJu6bOXcNyl5PKMrDhP6eq
	VEh7eTFdLt4Rg06ghu7oOk4ZETyCFYShrEswlTEB4YXT85MIa8nC7slT
X-Gm-Gg: AYBFou2zXaXl+JpFXITXEbN6ycHMOyalj4rei9nUY0B4leRgyYmD3aasJhx7VXZPZyV
	tI758T5YNH6fpUy3+XQGsUC7ho51pIDmThdI6pR7ByzlPoPn1GZJ/eO5rKbkhCzF30lLhTyShvv
	M40I3oAs7HsNk3XC8+wPUTjys7R5wDLv6qHJzftMSejbU99+k5wEV7Ldj0DJ3RrTxgrNs2/nG7i
	UPu0GlK4+UmU8eoD2tEEZj+UkLG4zVBXIoL5dgMrZSZ8/3q7ohoJbppyOG4AjVQSQ32PQXpNGHr
	B8C+GeFG9LbF+7Sxw9BwfiLgf9Pknffmt1krYYBv2BMrqtOzelcIP3wBTc0KPoa77Izv2IEnmn5
	egil1LkKd0ShBpr24mOTDjBv44azrHqjpNt/ekSAC6GvzrY/h365tXLmEFqR+5K4XpC1IF+jhdM
	BKrpbORa4S1wf/Kwu5ej/YxkdCxWN5jlSdlY62fNcj2ARbT4PcUX6iC4ZhbG4dZPE9U04EhQ/5M
	uKHp8aFuOsoBElHCQq05KquD1pYQHySNDU7I7cChdsmu1YdEvwpWctlcPl+/KlL93uD8c6IWHpN
	eTDlpKOI6uKbYgiZok79yu36hRSmnLC2Rtq06S0/DcP3krd6Ii5ybjnXeIbk5AF3mxBWyB5qMj9
	+CiMZcmAC3+SUKULVMKt2xalGb5p3Qzmp0+tvDJxIm5CxUyuys2dKh7+cDeU=
X-Received: by 2002:a05:600c:4fc9:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4a204b2032cmr26718835e9.12.1792646239093;
        Wed, 21 Oct 2026 22:17:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:18 -0700 (PDT)
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
Subject: [RFC PATCH 02/12] lockdep: Use raw access for pinned hardirq state
Date: Thu, 22 Oct 2026 07:16:44 +0200
Message-Id: <20261022051654.79224-3-kmehltretter@gmail.com>
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

irqentry_nmi_enter() reads lockdep's hardirq state before __nmi_enter()
establishes NMI context. Arm64 does the same for its NMI-like EL1 debug
entry. Both paths run with interrupts disabled and cannot migrate.

lockdep_hardirqs_enabled() uses this_cpu_read(), whose preemption checks
are unnecessary for these callers. Add a raw accessor and use it in the
two entry paths and in lockdep_hardirqs_off(). Keep the existing accessor
for callers which are not already pinned.

Check the interrupt state before accessing per-CPU state in
lockdep_hardirqs_off(), independently of warning suppression.

On arm64, this change does not by itself make the call chain noinstr-safe:
__kern_my_cpu_offset() must also be forced inline. That prerequisite is
listed in the cover letter.

Assisted-by: LLM
---
 arch/arm64/kernel/entry-common.c | 2 +-
 include/linux/irqflags.h         | 3 +++
 kernel/entry/common.c            | 2 +-
 kernel/locking/lockdep.c         | 6 ++++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 72c03ccea59fe..93056a766fb20 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -141,7 +141,7 @@ static noinstr irqentry_state_t arm64_enter_el1_dbg(struct pt_regs *regs)
 {
 	irqentry_state_t state;
 
-	state.lockdep = lockdep_hardirqs_enabled();
+	state.lockdep = lockdep_hardirqs_enabled_raw();
 
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	ct_nmi_enter();
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 57b074e0cfbbb..5bc179a88e513 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -52,6 +52,8 @@ extern void trace_hardirqs_off(void);
 # define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
+/* The caller must already be pinned to the current CPU. */
+# define lockdep_hardirqs_enabled_raw()	(raw_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
@@ -113,6 +115,7 @@ do {						\
 # define lockdep_hardirq_context()		0
 # define lockdep_softirq_context(p)		0
 # define lockdep_hardirqs_enabled()		0
+# define lockdep_hardirqs_enabled_raw()		0
 # define lockdep_softirqs_enabled(p)		0
 # define lockdep_hardirq_enter()		do { } while (0)
 # define lockdep_hardirq_threaded()		do { } while (0)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e3d381fd3d251..28399c41ebfb1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -171,7 +171,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
 
-	irq_state.lockdep = lockdep_hardirqs_enabled();
+	irq_state.lockdep = lockdep_hardirqs_enabled_raw();
 
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c3dc84a7cef26..01dba8fb32a90 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4543,10 +4543,12 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	 * So we're supposed to get called after you mask local IRQs, but for
 	 * some reason the hardware doesn't quite think you did a proper job.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+	if (unlikely(!irqs_disabled())) {
+		DEBUG_LOCKS_WARN_ON(1);
 		return;
+	}
 
-	if (lockdep_hardirqs_enabled()) {
+	if (lockdep_hardirqs_enabled_raw()) {
 		struct irqtrace_events *trace = &current->irqtrace;
 
 		/*
-- 
2.39.5 (Apple Git-154)

