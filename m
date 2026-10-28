Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158326;
	b=oNufAjfxs0iU3GD7J/q20ep37xWLoqMK5RainVAeB22vOTQCv9ARxTNuz6UKaTk6NjUH
	 n0HjWQkCRt6cx55GtoNXEerMzLrqXpFoA+Xn3gCR3ktmtb9xfQWAKUhBm+ayqBcl8023h
	 5TF5Qn4Qa/XqQewYp1H+iOc55ErP00yVdvJVI9LZBSANVPiIKRjnRoxL4UpDr3x0njiqW
	 ZtiEknuovqdsnoABFBY+gWnlvRHDVUR+1AXi+srLBp483yy44lkNEG5RaL0dFnZzOQySC
	 yh2Ybnwa9wUjETEWaj2f9sEUtW11XLHjozSUP1zD/HabJ3UwV9y18y/LvQM91485oDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A8EkBHzSkpvWMyA+KA0OYUqo4zY3bIhhFtk/YpfILDM=;
	b=bavhpm5MS/uR3n+NQs8aN4XBBjv/cm28+72VCE+AjusQGYZLZN0YUicHn4DNC3MC13Hu
	 UNdwfP4qodSdrlLd2WmrqFOJNxyCPSr91YIQgnIjCIVRCNuJJTgiSEDPIRJN23ER6dLFX
	 sGjavAeWpppiA/ClamN3XNPbttQ66yPpEZK16W2QRb91hYwgNm9septcQ8AfW3JWFXbQO
	 X4QWOqFpvW3nM7pJbsvUnPBBRpF7UZiv9K8HW0s8mw4U52VRdl9FBUlxNwL6es0wiePZN
	 cQk6HPfUpEi5Hj+ytdMSRVDs+F8tjQS6sR5YrWKz6WMlieQSkP29z15tm66BbvlyX1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IQYihddN;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED61606A31F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CED61606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IQYihddN
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df54150dfso285863f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158324; x=1793763124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A8EkBHzSkpvWMyA+KA0OYUqo4zY3bIhhFtk/YpfILDM=;
        b=IQYihddNldSwwNQL4cNDOCOj3vvWf6Wnmb806Mt7YnHev8qmPKJiywxcjV1sz23mXu
         dsePR7cCzgB1pkxuONknafj6ZvOcKxOm9j21xDL+bfrY+eQ0VQuSbN3gctFdA4KuZLpc
         OoXsqXDz1La7cEGOcnMkuJs36dhQ4jJmZlkgx/4ZM7D8fxZnRkApn6OA0yKoYFHPPqbk
         NXtRw8M6f3S2T8WDmwVlJoDaOifcuApwzusE2dCncmuNF7/4LvAnZecpSlEEWnG4gGCG
         f43UwyjXzPxKe0pBrfcsDQ79AEFjnAbqaV9ok+1I9lUNLDqEtqrdHjtp3kc55W7icDz0
         hOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158324; x=1793763124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A8EkBHzSkpvWMyA+KA0OYUqo4zY3bIhhFtk/YpfILDM=;
        b=U/tC99AtdCL/4s6sXn7fTsDu+syoHwjVu1P5/nEOVKMrMFr3bG0ofiQqTJSon6C4Cx
         1EmonaQlaHXbJvGzl6QR8ZkQ4s14cexlxjU1vp641O2/HHuOu+SvwKO14WtYD7dEJqEW
         mhsbIYg3bVufGIyiZavdyDeOTWJkyrKZPsIk4ZQmI0dyj9r/l7ZVlra2dLtXrru31nrp
         2DvcHhbrNOI8OGYzzc7S5klayzmuhyavFUfz1GF5XuL/aDf6fIhu0+WGSBrlMLv5lsj/
         8nLyKv8LcPlU5O2TKzoLdVrNh/IJImyDP8BKoNm55NVoicueH/XPT4c+q3LuxNpiUTkx
         pKrg==
X-Forwarded-Encrypted: i=1; AKwUvByQh091S7OD59hacDa5A3BDYzuySgw0V1ejV/i4JKYQADYu1IKXa41pnu+gpZ2VfSdhea5N0Pfqm7AVb1L3OzFFMdI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyEEMri9KdKIzx3ByYAlt2u1vuuGLFUAIvG/NUOQfKsWYqLrSE
	r9FcmJ4LLROuuzGj4t+NavZXIpG2UiYYY0DvtVDILyl/XgYZn5EFZ51M
X-Gm-Gg: AYBFou1dpHJdWD3IX1MGvU4VtiSvfxCodWoP3n9cpeee4wPG2H2Z0joW0T3/DU19rwS
	fGE6nJ3/UsiloSGxVxVxt96m+iFXyR6kNyEzidZop0y8U6CJUUWwX4B3IrUT8GHNUDSKW0z1evl
	LaO3g3hY3Kr8qM4KuIe1+SyM2/7ygq+bX6vyElfnwiKl2yJlc1PI8fHLcillh5LdsEFFKv8PQjO
	lzsB3JfY+KrmANBlvrW1wUdK6rAWvLllY54sVXimTUMTlO99QlYRLTlK7HGHNGYkC6jpxgI1Bn3
	0P13JevhI2XrT+/65u2BGp09/DXE60RxonboxZtq3MjdBRQOI3+0SKn4hJ7xCdUKsH40HGF1W8M
	d4SZuWhFbRlC8X5eDnESDc7MOkf/vODqiSUdIg8nbiLalMJ/Awxj9qNaJhYTVejYXbPc1hirNKw
	7fWXbAdmsfDR73gAi8VW1q81fy4XnXkTp9YR1FTel0WzC0xfE1wfC0WB57f9IoE9cgz1NkSOORR
	HSoMp8JDEKK9CYU07inRSWFkKMNdGpl5A2TWPIBb/9IlEl+gesSRYzdKEC34QdE1AM+f9sotpwv
	ZRMZF6xKXkUNHP1UC2DyFAss+vztcUYNfZJ6WCrykkEG6LiV4vHhGdI0btpJoF2n4k2CoE2Xdcv
	V6aK+KOabYOFEduheqksiuImq6qN4Zm40vLFLUcD4g+9JDAHQUylguer0+7dibTvB/6gFsGUfU0
	5wRikYUYotsDdYTRrXSOPACxB996kkZpIT
X-Received: by 2002:a05:6000:46d9:b0:48d:fa9c:7838 with SMTP id ffacd0b85a97d-48e5d567dd3mr1945784f8f.2.1793158324146;
        Tue, 27 Oct 2026 20:32:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.32.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/13] lockdep: Prepare IRQ-on state from a hardirq return tail
Date: Wed, 28 Oct 2026 04:31:22 +0100
Message-Id: <20261028033127.82193-9-kmehltretter@gmail.com>
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

lockdep_hardirqs_on_prepare() rejects any live hardirq context. An ordinary
hardirq return tail needs to retain synthetic hardirq nesting through
traceable IRQ-on preparation. This keeps callbacks classified as hardirq
work.

Factor the common preparation and add a return-tail variant which requires
the synthetic hardirq context to be present. An interrupted outer hardirq
can contribute additional nesting. Keep the ordinary helper restricted to
zero. Neither helper changes IRQ or hardirq state. The caller must remove
the tail context before lockdep_hardirqs_on().

Assisted-by: LLM
---
 include/linux/irqflags.h |  2 ++
 kernel/locking/lockdep.c | 43 +++++++++++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index e98313a8ad307..c7601a173e55b 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -25,6 +25,7 @@ struct task_struct;
   extern void lockdep_softirqs_on(unsigned long ip);
   extern void lockdep_softirqs_off(unsigned long ip);
   extern void lockdep_hardirqs_on_prepare(void);
+void lockdep_hardirqs_on_prepare_irqtail(void);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
   extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
@@ -33,6 +34,7 @@ struct task_struct;
   static inline void lockdep_softirqs_on(unsigned long ip) { }
   static inline void lockdep_softirqs_off(unsigned long ip) { }
   static inline void lockdep_hardirqs_on_prepare(void) { }
+static inline void lockdep_hardirqs_on_prepare_irqtail(void) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
   static inline void lockdep_cleanup_dead_cpu(unsigned int cpu,
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 01dba8fb32a90..2ecd506715fa7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4395,15 +4395,7 @@ static void __trace_hardirqs_on_caller(void)
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 }
 
-/**
- * lockdep_hardirqs_on_prepare - Prepare for enabling interrupts
- *
- * Invoked before a possible transition to RCU idle from exit to user or
- * guest mode. This ensures that all RCU operations are done before RCU
- * stops watching. After the RCU transition lockdep_hardirqs_on() has to be
- * invoked to set the final state.
- */
-void lockdep_hardirqs_on_prepare(void)
+static void __lockdep_hardirqs_on_prepare(bool expect_hardirq)
 {
 	if (unlikely(!debug_locks))
 		return;
@@ -4442,10 +4434,11 @@ void lockdep_hardirqs_on_prepare(void)
 		return;
 
 	/*
-	 * Can't allow enabling interrupts while in an interrupt handler,
-	 * that's general bad form and such. Recursion, limited stack etc..
+	 * Ordinary IRQ enable requires no hardirq context. The interrupt return
+	 * tail variant requires its synthetic context, possibly nested inside
+	 * an interrupted outer hardirq.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context()))
+	if (DEBUG_LOCKS_WARN_ON(!!lockdep_hardirq_context() != expect_hardirq))
 		return;
 
 	current->hardirq_chain_key = current->curr_chain_key;
@@ -4454,8 +4447,34 @@ void lockdep_hardirqs_on_prepare(void)
 	__trace_hardirqs_on_caller();
 	lockdep_recursion_finish();
 }
+
+/**
+ * lockdep_hardirqs_on_prepare - Prepare for enabling interrupts
+ *
+ * Invoked before a possible transition to RCU idle from exit to user or
+ * guest mode. This ensures that all RCU operations are done before RCU
+ * stops watching. After the RCU transition lockdep_hardirqs_on() has to be
+ * invoked to set the final state.
+ */
+void lockdep_hardirqs_on_prepare(void)
+{
+	__lockdep_hardirqs_on_prepare(false);
+}
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
 
+/**
+ * lockdep_hardirqs_on_prepare_irqtail - Prepare an interrupt return tail
+ *
+ * Like lockdep_hardirqs_on_prepare(), but invoked while the synthetic lockdep
+ * hardirq context covering an interrupt return tail is still active. An
+ * interrupted outer hardirq can contribute additional nesting. The caller
+ * must remove the tail context before lockdep_hardirqs_on().
+ */
+void lockdep_hardirqs_on_prepare_irqtail(void)
+{
+	__lockdep_hardirqs_on_prepare(true);
+}
+
 void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
-- 
2.39.5 (Apple Git-154)

