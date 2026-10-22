Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646253;
	b=e2hctEGYSyH3dw0GD1AJ8QakKNjGzCbrBsjd+C8n/w7j1zh830T8CDiYrxE4Yy4goaPQ
	 5orcCFrnV76ia1VeZDxMBbmS8it3BaG+7ts2HlbHVmhSIYJJ/0BPEGv9uQusnisPuF2pI
	 q8xTyEgQTUNI8zRWzF33yPOxYcO9zyxgCjh+l1QyfbG2gIZy6MfEbZXEebVrKyCmZD/1i
	 ctFa1Jxf9M5IGSNKcCqhqZb0qaiXzFQTzY0Rob3nmbdCJBtCd4FwIhTJuvbYG8EE+D343
	 rT4gHnn+AzVWtjXdXxcEr66mNIQapUB/XDDBcGkjafTL0Bt/Y0FuUdc7DRX0KBDRgPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SgSVPju/oDwYCUMu1qXQuK1g6vGXDkUziO98RSaFsPc=;
	b=Py74ibqM8Q9FQZVPjaTNDZITuucYtDtaFj678/XiX0HzJjG3JTkyWrBgLWQJzU6oHkUn
	 TbUTxRhwt/MxGU9sFrQUao2jqEhLqU+2J3hGiVGeijcgOH8Moo1GonB3ar1RfsmJ7kGp0
	 gimt6MzjjJ2sWrh/61yFklnHJXS0VBElTPGXdROR0BVbMfAuCSiE3JtRhO4dFFOG6uxnL
	 Vnf8nCfz54gIb04rhmPKbh5logfzbZkLP696LuoesOlqWv8BzZxotTzNUDUmUFYYG0Nbx
	 ZO2949XAyvj3i1es/r2UkGRvQCueQZoaQqKh52K5s4E5GQlxa/Gj9cR9gZGO9l47RKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mV9IvZyy;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1960A260C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA1960A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mV9IvZyy
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso15954035e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646251; x=1793251051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgSVPju/oDwYCUMu1qXQuK1g6vGXDkUziO98RSaFsPc=;
        b=mV9IvZyyzzbb8eaAq6WvvyU135ja9QGcCNyd0fJ/Rk00xax7ivbbJh0YOCwOj0uU9r
         Sv3sxXQHx5XvUGVhU1w0dQId4eQB0Ahb1C/jzherVi59bpgQvHQEgzuCGSQjX1tynKtq
         XfNgYHmZNLlcc4Ks+57CJOVR20sy71p8y5GsPhGA3v089OZlWQZGOy54eJ9UWfP0xfT0
         EhawdTFhkEw5DB370nnFZn9FD6sSH6iN66zAa8OqDMF4OI+AFm3ecjvZzbU4FpZOKnfv
         Q+unLImemE4UTWn19tJ9yWLuFDHBUYq51E522H1mbVA6g8CqRgWFl10Z5gTsWhMC1xnd
         SKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646251; x=1793251051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgSVPju/oDwYCUMu1qXQuK1g6vGXDkUziO98RSaFsPc=;
        b=fhu+X4YJXdJg4ETmklRVAYUUfnJNFFtgeAQHZD7dYM0sCGPXxcxuGpm9/iBesTaJ9f
         MgpMxNFh65fWbPXE0pmoPwsxgseL7ZK+gnuvIOCts1YBkl/uTkb0t72rCL8EpiKCFkUf
         LsGw/RUowiQHfI+UE4af+5Nc6ZacQAkyF/9zVqYzYdWFacqk+v40UXNR1qKsRenfI2kh
         h3r79kqagoVEO1OSHRhv165bO/Ozx2DUJyMUoJNh/Rs0iVRfnPYxuoext75cNK0lx1c5
         zr1qPs8m9HOagskJjZ4uAeBSbGVdCci4U+u10u/vWW2C0FTJl2Mg17GSxUMIU58O/jTc
         4Cyw==
X-Forwarded-Encrypted: i=1; AKwUvBzxKFWbnxSXgGUpHJMRWb9CRQgOK/vS8j11OMz3H/mMrdPM6KGS53yte52ApoQMhQl4CpQf4ipNIj735nMcym6b6SU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrpr2gL/GQU3wXuXe8REWpB92N9sVc/VSnw6lHy6ltLT9ix4iv
	9CZ49aNQ0spF1cEZZkCrt78yQDffZr+8wBKE9MDEeTPGHheXNctrmziT
X-Gm-Gg: AYBFou1c4yf5kYPp8ogMO8iD2lqY3icNnFqq2Pm/Y8ok7ZIYYXR7INE+wc+NTF9+Wx0
	lTFPYejcF0w3OundqnJgnk+t5bjiDgHLolG8RjLGGy5CCciTgbQAlMjlnDy4qFfpmDp5LFoaW1K
	wUWl0fa8BKMtCOYUU5NJ5V5UbAgclX/3oCnwvF9whABRsV1tKusx/KRMsnQKwEchkNTQVv3FSKq
	rq039cqsC4fhKxBMNwXRiZs3ibTgCt9yFaD1N2iPazjGruAvyK2QHxsLMuXzbocO86gTLpSmk6i
	rlYjqTcsBm59hbi6HRTHLW5YNTHJhGFSA8DmqxYPC0uEaE7iANJMRsCrAmZFflNTtmEh/QVpnOh
	3ddD43d3LlEFrFVIe8W6J7KI9wpHnisz1nI6tyek2Xb0W5dG0f5ymy2eLrdqVTHtRFty3WONpnD
	ue6cOezVtQiYpmKVVHHfqxaL2na0Hhs3pQD1Pra+XAfsHr+xH9FCobiYSoHlkbLbQqhw2wWlrNK
	kBg867WlcskfOxmbmzsrQleMcMiF4pTgg4uy2TAoWp07W/dOc2z6JCXgY4u8z5IgzgoNxkZgdAT
	oDQ+M+7gnEtUdPywK26OHhmN/BhTNnxNuomddnda5NA04yWiclx0sfxORhZYBqP4JmvV7OaNo2F
	tzDTfuQvcJdQqPQmO/OMAOWBzf+bw7WbPrM6dYp54MO1n1x0BEq88r4YBCVQ=
X-Received: by 2002:a05:600d:8653:20b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4a205ca7975mr15129905e9.4.1792646250340;
        Wed, 21 Oct 2026 22:17:30 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:29 -0700 (PDT)
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
Subject: [RFC PATCH 06/12] lockdep: Prepare IRQ-on state from a hardirq return tail
Date: Thu, 22 Oct 2026 07:16:48 +0200
Message-Id: <20261022051654.79224-7-kmehltretter@gmail.com>
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

lockdep_hardirqs_on_prepare() rejects any live hardirq context. An ordinary
hardirq return tail needs to retain one synthetic hardirq nesting level
through traceable IRQ-on preparation so callbacks remain classified as
hardirq work.

Factor the common preparation and add a return-tail variant which accepts
exactly one nesting level. Keep the ordinary helper restricted to zero.
Neither helper changes IRQ or hardirq state. The caller must remove the
tail context before lockdep_hardirqs_on().

Assisted-by: LLM
---
 include/linux/irqflags.h |  2 ++
 kernel/locking/lockdep.c | 42 ++++++++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 12 deletions(-)

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
index 01dba8fb32a90..457bef3ea1689 100644
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
+static void __lockdep_hardirqs_on_prepare(unsigned int expected_context)
 {
 	if (unlikely(!debug_locks))
 		return;
@@ -4442,10 +4434,11 @@ void lockdep_hardirqs_on_prepare(void)
 		return;
 
 	/*
-	 * Can't allow enabling interrupts while in an interrupt handler,
-	 * that's general bad form and such. Recursion, limited stack etc..
+	 * Ordinary IRQ enable requires no hardirq context. The interrupt return
+	 * tail variant permits exactly the synthetic context it is about to
+	 * remove.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context()))
+	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context() != expected_context))
 		return;
 
 	current->hardirq_chain_key = current->curr_chain_key;
@@ -4454,8 +4447,33 @@ void lockdep_hardirqs_on_prepare(void)
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
+	__lockdep_hardirqs_on_prepare(0);
+}
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
 
+/**
+ * lockdep_hardirqs_on_prepare_irqtail - Prepare an interrupt return tail
+ *
+ * Like lockdep_hardirqs_on_prepare(), but invoked while the single synthetic
+ * lockdep hardirq context covering an interrupt return tail is still active.
+ * The caller must remove that context before lockdep_hardirqs_on().
+ */
+void lockdep_hardirqs_on_prepare_irqtail(void)
+{
+	__lockdep_hardirqs_on_prepare(1);
+}
+
 void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
-- 
2.39.5 (Apple Git-154)

