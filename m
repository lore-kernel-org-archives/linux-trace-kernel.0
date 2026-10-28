Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158325;
	b=i4Sigb8dDmCh8NwtE26nBukmnTkl8ByQUqHLRMnQXVGJpEHCDuVxUbyrYkWydQXdfCDE
	 KETJsfcdtDjAOIsa7ln6WW2T6QMZcZ6/3mS4axud+sCzbtL+jlLV6aLmisB6ot+HzsHun
	 d87t+IhoBp4xUo7XaouW/k3NCGZjEl+orqo6+5ua6NbAs0fVPVYSTv/qFneIj1tAgYbKo
	 CWxpAe56g35vzKAN1P/kfU7u59a7/HEk6JCzYxgmc0K1W/DGDKjxnW3757d9uV94so+gG
	 lz0khd+mNqqWJjEruWM8+/1Imy4/JzVFneEYW9qa1vYlQDe6ZGTQXaOTNfLAeFUL0HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Jtc1fVPemAMqEoN4axaTKj+FevgUODBLdLJA6bSk8XM=;
	b=JsJDCRjACAF2NWqvF9qTYb/vbCWRdCv5uKrj2d0hTvBZOywa9i2mHgmxWgi8PZ28fr0M
	 VJYcnPObOpQ9+AmowOuYs4hSS8KSinlQd+Ti5TbqMMltPU8n+3MPCp8mAQhzLMAEmALRk
	 I+JMXUqKQPXydXe5zghceIpp4+tTFqaIXyKf3cseP1fhdPcphG+UYeHVclTpYv4YuSTXy
	 pCCCpqkN+wq5+MsWEsd+ABvj6h57ZtuF4u8EmeD5sEqo1nOBGdPDMVaUbj4/GKf9/40em
	 h1qtWRQldzrf6A6338kpkuaha5Eb7PuQSxUF59lmVnm5OT21RN4y//xdlUdKhZe+RUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YN1rJqSK;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13880606A324
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13880606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YN1rJqSK
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso4035975e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158322; x=1793763122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jtc1fVPemAMqEoN4axaTKj+FevgUODBLdLJA6bSk8XM=;
        b=YN1rJqSK4kfGeTi3P9WEN2JcOPI2UwtVuMHGOQaZb+j2qAUU19Wd43m8weFH5DCDIU
         oztgwHo2X4/DH4+lDGlZTTG0uzpvImrec4k3MMl2JOqzmXv0lWNmfWGNG4MRNO/cP1kj
         BjPEfioEt4GzPmC2+szafeNnMWTndPrJMTFgzrHa/dX8xVXt7gD/2HLhfc6Z5XZOPkEz
         Wlq+WwlG5/OkzQGWXtYwujgaBGaEImDIopp0Y0RfpHYLGom3sZkhuaPBDz9dH1ZIdnAr
         ep5D63bTpGGi1gSnuPoQVrZXkOv5pU68+AWIt5RHiZjQlRMhjyEr6VUrVqHg7hMNadCn
         A3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158322; x=1793763122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jtc1fVPemAMqEoN4axaTKj+FevgUODBLdLJA6bSk8XM=;
        b=QjL6o7/muH3odX5kmQBMMUdN0dKyZrwpdNXQGqjTv2csGeTmIN+cvRt37jBFU8xYqp
         6siuKy4QVJj5xukpxTA8741qXgM4nqJ8Z0YFOp9jWEHoWyZOvQUFLFoRH055XdEcmZ92
         4fcW801r27r7yg3OpozRCOpWWUnV23GBUdhYOE/fmOENp9wrjr9tGJwvq99s5fLH/XVx
         h29gaGHQwrLvVj8oRmEATALvQR1jTEIN3avOVC6OT/F1n1qdUzDdGxmGechwYBEk3MD1
         m/g6Hd9HZ71w08zN/toX+J/NEu5CLuYTIjnkivIAr1OfRwrTb+qXNXNARRCOAjUHHW55
         u4Xw==
X-Forwarded-Encrypted: i=1; AKwUvBw+FTQ9MhUDYeZHL57pT/x68/Qs7wWFVY8LivyEfst8qW3dRmebrG2+oVama9pArrBGVq69z0niFuXvewatwvko1dA=@vger.kernel.org
X-Gm-Message-State: AFq9FYINq6UAg0xBtY7wFiRsjlpN2Y13mOZDGWyUGFgDHvQ3x4EM8hRy
	QWTSZHOrfZJLcYGBdAvZnAACtwXOPvYQ6H+XR+8PWk9D0AgT5sTqnIe4
X-Gm-Gg: AYBFou03KH0pfxhChGweEEm8rX8cGsBg78C4GKVh4EqN93aAeGUInCxeobUwYqJEQqP
	RHB0NT1jscBxElek3MN4Crynu7weiXMG0MwIEO4UqT7pSe9NkcKuctdIE8VWCRbmWkuiwT0D/aA
	33gKRnJdz17ydiZzdOCYwTVwttqJdWHPx/vVYCpDiPYvjTwN2t1mLE5shDyhgXhTBihR2UPJBrl
	x83LfW21DPX1pEGcgaSLgEu7s+guhale7PzfrsQ9I02hJGvTauq4UJvI/RZ/9yOPW4oW/lKvI5M
	xULWAc9ZwAbWsWHAS3yTQwPrtCYQv7bfYI3DeBGo40IwD8M1m6n1geaGNuHrll3fArRnYpCcA7z
	g7rmkXhsLBRa1GbQmN5jJQKQ7IXwkgiJrTacOSxK91nX5rb+Ovp7MZ18jNNc5AXYGa160/7jXT8
	HoOunGu7wyA43ftnh4PTzXA7AA9CSirNFkSCVOKEWlctjpYYbQrDY/a9NxNQst1oIaPZ0HeIxqc
	eKiO3L+29m9trraQnYBU2cMznQyg0cWWW/XXN21NhiblJgEoNK7yvYqLfT1tZHCgYpPVTWxiwOL
	dG8LHFkzBAvwvtG+O0Pm62RIyxo0Sgw10kT6jL6/UKzmw+LOvqoOEb5HLr7iJjIWNKewcpgVDvM
	7kT1TEmPuilOUk9MMtdUEx1FGBVMqs5ge8BVAPOJsBuNuvPowRs+kC6TaByVp62Dnx9Vl2XK4YR
	d64GpIJTvn8DuVbwAOcOHrHiyfo0J2THSF
X-Received: by 2002:a05:600c:a314:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4a96b29d208mr13460435e9.18.1793158322397;
        Tue, 27 Oct 2026 20:32:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:01 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/13] context_tracking: Split IRQ-exit preparation from the EQS transition
Date: Wed, 28 Oct 2026 04:31:21 +0100
Message-Id: <20261028033127.82193-8-kmehltretter@gmail.com>
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

ct_irq_exit() combines traceable nesting and tracepoint work with the final
transition to an RCU extended quiescent state. A pre-counted ordinary
hardirq return needs to run that preparation before its synthetic hardirq
classification is removed, but it must enter the quiescent state only after
the raw count and lockdep teardown.

Split IRQ exit into prepare and finish phases. The prepare phase validates
and updates interrupt nesting, then emits the tracepoint while RCU is
watching. The finish phase performs the raw quiescent-state transition and
RCU Tasks bookkeeping.

Keep ct_irq_exit() and ct_nmi_exit() as adjacent prepare and finish
wrappers. Existing IRQ and NMI callers retain their ordering and behavior.

Assisted-by: LLM
---
 include/linux/context_tracking_irq.h | 32 +++++++++++-
 kernel/context_tracking.c            | 78 ++++++++++++++++++++++------
 2 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
index 197916ee91a4b..b038cd1249148 100644
--- a/include/linux/context_tracking_irq.h
+++ b/include/linux/context_tracking_irq.h
@@ -2,8 +2,23 @@
 #ifndef _LINUX_CONTEXT_TRACKING_IRQ_H
 #define _LINUX_CONTEXT_TRACKING_IRQ_H
 
+#include <linux/types.h>
+
+/**
+ * struct ct_irq_exit_state - Opaque context-tracking IRQ-exit state
+ * @exit_rcu: The interrupted context was in an RCU extended quiescent state
+ *
+ * This object is filled in by ct_irq_exit_prepare() and must be passed to the
+ * matching ct_irq_exit_finish(). Callers must consider its members private.
+ */
+struct ct_irq_exit_state {
+	bool exit_rcu;
+};
+
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 void ct_irq_enter(void);
+struct ct_irq_exit_state ct_irq_exit_prepare(void);
+void ct_irq_exit_finish(struct ct_irq_exit_state state);
 void ct_irq_exit(void);
 void ct_irq_enter_irqson(void);
 void ct_irq_exit_irqson(void);
@@ -11,7 +26,22 @@ void ct_nmi_enter(void);
 void ct_nmi_exit(void);
 #else
 static __always_inline void ct_irq_enter(void) { }
-static __always_inline void ct_irq_exit(void) { }
+static __always_inline struct ct_irq_exit_state ct_irq_exit_prepare(void)
+{
+	return (struct ct_irq_exit_state) { };
+}
+
+static __always_inline void ct_irq_exit_finish(struct ct_irq_exit_state state)
+{
+	(void)state;
+}
+
+static __always_inline void ct_irq_exit(void)
+{
+	struct ct_irq_exit_state state = ct_irq_exit_prepare();
+
+	ct_irq_exit_finish(state);
+}
 static inline void ct_irq_enter_irqson(void) { }
 static inline void ct_irq_exit_irqson(void) { }
 static __always_inline void ct_nmi_enter(void) { }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c00..80ed8ec606c6a 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -169,20 +169,10 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	instrumentation_end();
 }
 
-/**
- * ct_nmi_exit - inform RCU of exit from NMI context
- *
- * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update ct->state and ct->nmi_nesting
- * to let the RCU grace-period handling know that the CPU is back to
- * being RCU-idle.
- *
- * If you add or remove a call to ct_nmi_exit(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-void noinstr ct_nmi_exit(void)
+static struct ct_irq_exit_state noinstr __ct_nmi_exit_prepare(void)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+	struct ct_irq_exit_state state = { };
 
 	instrumentation_begin();
 	/*
@@ -203,7 +193,7 @@ void noinstr ct_nmi_exit(void)
 		WRITE_ONCE(ct->nmi_nesting, /* No store tearing. */
 			   ct_nmi_nesting() - 2);
 		instrumentation_end();
-		return;
+		return state;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
@@ -213,6 +203,15 @@ void noinstr ct_nmi_exit(void)
 	// instrumentation for the noinstr ct_kernel_exit_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
 	instrumentation_end();
+	state.exit_rcu = true;
+
+	return state;
+}
+
+static void noinstr __ct_nmi_exit_finish(struct ct_irq_exit_state state)
+{
+	if (!state.exit_rcu)
+		return;
 
 	// RCU is watching here ...
 	ct_kernel_exit_state(CT_RCU_WATCHING);
@@ -222,6 +221,24 @@ void noinstr ct_nmi_exit(void)
 		rcu_task_exit();
 }
 
+/**
+ * ct_nmi_exit - inform RCU of exit from NMI context
+ *
+ * If we are returning from the outermost NMI handler that interrupted an
+ * RCU-idle period, update ct->state and ct->nmi_nesting
+ * to let the RCU grace-period handling know that the CPU is back to
+ * being RCU-idle.
+ *
+ * If you add or remove a call to ct_nmi_exit(), be sure to test
+ * with CONFIG_RCU_EQS_DEBUG=y.
+ */
+void noinstr ct_nmi_exit(void)
+{
+	struct ct_irq_exit_state state = __ct_nmi_exit_prepare();
+
+	__ct_nmi_exit_finish(state);
+}
+
 /**
  * ct_nmi_enter - inform RCU of entry to NMI context
  *
@@ -348,7 +365,35 @@ noinstr void ct_irq_enter(void)
 }
 
 /**
- * ct_irq_exit - inform RCU that current CPU is exiting irq towards idle
+ * ct_irq_exit_prepare - prepare to exit an IRQ towards idle
+ *
+ * Perform the traceable part of an IRQ exit and return an opaque object for
+ * ct_irq_exit_finish(). RCU remains watching until the matching finish call.
+ * The caller must keep interrupts disabled, must not schedule or migrate, and
+ * must invoke ct_irq_exit_finish() exactly once.
+ *
+ * Return: An opaque object to pass to ct_irq_exit_finish().
+ */
+struct ct_irq_exit_state noinstr ct_irq_exit_prepare(void)
+{
+	lockdep_assert_irqs_disabled();
+	return __ct_nmi_exit_prepare();
+}
+
+/**
+ * ct_irq_exit_finish - finish exiting an IRQ towards idle
+ * @state: Return value from the matching ct_irq_exit_prepare()
+ *
+ * Complete a pending transition to an RCU extended quiescent state. Nothing
+ * traceable may run between this function and the low-level return path.
+ */
+void noinstr ct_irq_exit_finish(struct ct_irq_exit_state state)
+{
+	__ct_nmi_exit_finish(state);
+}
+
+/**
+ * ct_irq_exit - inform RCU that current CPU is exiting IRQ towards idle
  *
  * Exit from an interrupt handler, which might possibly result in entering
  * idle mode, in other words, leaving the mode in which read-side critical
@@ -368,8 +413,9 @@ noinstr void ct_irq_enter(void)
  */
 noinstr void ct_irq_exit(void)
 {
-	lockdep_assert_irqs_disabled();
-	ct_nmi_exit();
+	struct ct_irq_exit_state state = ct_irq_exit_prepare();
+
+	ct_irq_exit_finish(state);
 }
 
 /*
-- 
2.39.5 (Apple Git-154)

