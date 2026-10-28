Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158315;
	b=5NW1slGc7nXMMWnaax59KWd88L5OvXumJOa0A5koQyDdGSDI4Mi93EGZzPYhJUyItah0
	 76v9cnIE1qix2pVdM81VE2cIa9bpfWhi/hByLJGMETavZIYOcohHcAW3LQcib5JrL9KVC
	 7di+NZoTayFkMnEVSu0JnYbD+gq8vw5rHYnYYMLO5Sk6OvRAyb3bvv+bjj/4ExGY/5oE5
	 Bf9u+2z7VKCJQ5U3fmrMskxsuuiCDUvKw66n+M1KkPIfYlt103+l4GK2+roRgpctg2oVY
	 Tftp0/+DdaP5EB/MfTnuTfLIzO+xYXR+0HWgF2LJgDKMhDpLO82iEpUeG/YO2sC4XYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4bZvL/9Bc8+ZGmd5br85IbVSWoa0e2ud1GyeOTF2PTQ=;
	b=swg3Y1pxSdI+iPeCLKJWjtemWjYpbEMsqvtjYP2IHeUVcluMzJmPbdF7T9/9NG7pSoKP
	 jRlTXPtm3mcMy68uN1+lB01anNrHNM1jZ47qsbj7dnfgj3ysYa+gutRosHRwJPhN0FCNE
	 cpVihSHHRIRz1CigQ4IBd+oItcOPLSPxrSItH1lXvEYPBuywyhNXVsmoBqh3kACiP8AYJ
	 9dnt5sCgi7AJJV0QjNWVBMbIOqCzG0Iu1DuByrnxjBG7AB5Ej0+YfBVuJ2NQ0ISSLqvma
	 KQPePx4ccbMxGF1gNBPqBw5lQzARtBdMgulbPqASEoF8K9j6+yP6QljyU2uIXFkilow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMmmb3sX;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8B606A325
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C8B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMmmb3sX
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b042c0759so229892f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158313; x=1793763113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bZvL/9Bc8+ZGmd5br85IbVSWoa0e2ud1GyeOTF2PTQ=;
        b=dMmmb3sXN+9+WtWYT5GIYxukvgjY6lg7vM9vMpuXULzuhss44sjTF2Ww0uz6wBUVUP
         YeyXil4UPV//QQdO3O7MzMp32Q6YpRghE8pNsbChAsRVNxGn1XyXw2a6Q1cdD1l9do3/
         Mpelq8RhzvmulGHfMQbtHfEmrTo/OyDUr27s14L52zhwTeIX1uJCQ0VKIatZERd4E4ID
         ILeSX8mL2xZoiZlK0PDPsikO1j7O9PBEuaFA6wJCnfEjmdArq0uwtfN7ov+2jQ/iXrp/
         zOgQBZlvtPyLXkoa4VVx2lWoCP+MyFqTzLTwDCnuaxA7aL4zMUNzZ3ZaNT3fJ/QXt6bm
         steg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158313; x=1793763113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bZvL/9Bc8+ZGmd5br85IbVSWoa0e2ud1GyeOTF2PTQ=;
        b=KFL6arpUSZxjPmNX4f0I7n/z3WK/r52DNgsCcu6uvGkVW1PiOfnBzjoNKUprSAUEjr
         mJ7CKlVAlCVg4bxpK/lVZrDb2AjKPmfP/xf+2a+ibkIr5pShT2eRzOOGEfLWQrTYGsRQ
         SMefHscmYouy+06ZV2Sxwjwil62WHcSWChf3ud0nGvaakhzH4x1x7vTyPwhPFIoWmihT
         FxjUXkOiyhBLZ4mghvGVeYD3wianV+creT+d8bPaXZsXRGv1mYiuA8qF2cpYS99UomuY
         Bb/BzaJoNsfy+89NxZeY08bGt+1Dr1kcLTCVTTE27T/H7co866kIWRnQMe/8vuNLcQXU
         Ycnw==
X-Forwarded-Encrypted: i=1; AKwUvBypDw9YsvK1x5VtK2tKf5NFOJyI7h88Qnr7Pe8aVP+cNR6ieQuET6mWruMnzUDEPGUb9L5Fg5LYaLWaX/5S10Oh/iA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNP50hP4ryxLTPNicPh0LPZXuBD4zVaAPAL9Z2twouy5fMrstM
	11Sz0K88UPF+j1oFlIwvxK6OKLSEBRdzaRq4HDCzRHAGTpndhRupQJZ1
X-Gm-Gg: AYBFou22CwWXGlGsxLhs2UZQ3rpAhVN1V4JKrgN4DBCklJd+AFGLqDB1YHpk9OPusWZ
	x3lDO/nHojYj8sEf4ccPLPrdejcy1oZPHeMJW90kKr6anIQ6kImUWTEowmxX4j8Hzl5eBzZYOjW
	Eegp4XDKaT3y8/nMveoAN/LtkgzZlr3DwA0nyFdWxw9o0DFVtAJ9plFpQxvLH+0/C9YDBj6vg1+
	ezOFOSKfaJnGInFv+AgeghSYBnNisBn8yNk3nG2wZ44m3Yo5W8ZlqEXiaAmqX7+zW6E+rtTpMMD
	403DKnZM0GLRQohGZYYSeI75eMoSamXM9D3OmPdfEbub7rh75mJ1p7OB0ZRDORrzEXNbBi6rXZY
	Zy/iDxveYb16rYSVIDjaWOrxg3GEmyKnoO0UkH8uOCJmeDFyiFvEmTG6Ty4SoF1h9b5U4J7WvUA
	jswYZq1f7+pwas57qugDViudusFrsrGDshjENic6/gUB0oJFYc2B5j9g3i4+hiEdeSZa5eY7nOW
	zeP6CNjr1zechBhcINRZ9LkQezksK+aKneGmu5FYa3fy3Xl+Z49ADXQqk/EP3w4Fdhb9JyADwjr
	Nj/b7C1131R4VaUUvHv5guBmQb+IVwdcTy6rddR4STAO34YgdnTdK1T9Q7cEeBHUbWTzXvmUTyG
	7hnjzQpaznotvvJji+CMA3C78fAy1lvbsoDY8wEPqY3SM7d0ofrZ9S+mb/xuLT7MQwFqE1ihe5B
	Uwk5qxTfS1TE8I3MgscwzqkcfIgoakRVFL
X-Received: by 2002:a05:6000:1862:b0:48b:d9:cb52 with SMTP id ffacd0b85a97d-48e5d2f0870mr3087140f8f.27.1793158313112;
        Tue, 27 Oct 2026 20:31:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:51 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/13] lockdep: Use raw access for pinned hardirq state
Date: Wed, 28 Oct 2026 04:31:18 +0100
Message-Id: <20261028033127.82193-5-kmehltretter@gmail.com>
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

irqentry_nmi_enter() reads lockdep's hardirq state before __nmi_enter()
establishes NMI context. Arm64 does the same for its NMI-like EL1 debug
entry. Both paths run with interrupts disabled and cannot migrate.

lockdep_hardirqs_enabled() uses this_cpu_read(), whose preemption checks
are unnecessary for these callers. Add a raw accessor and use it in the
two entry paths and in lockdep_hardirqs_off(). Keep the existing accessor
for callers which are not already pinned.

Check the interrupt state before accessing per-CPU state in
lockdep_hardirqs_off(), independently of warning suppression.

On arm64, this change relies on __kern_my_cpu_offset() being forced inline
by the earlier prerequisite patch so the call chain remains noinstr-safe.

Assisted-by: LLM
---
 arch/arm64/kernel/entry-common.c | 6 +++---
 include/linux/irqflags.h         | 3 +++
 kernel/entry/common.c            | 2 +-
 kernel/locking/lockdep.c         | 6 ++++--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 11d3f888fcd87..003f84109a913 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -177,9 +177,9 @@ asmlinkage void noinstr asm_exit_to_user_mode(struct pt_regs *regs)
  */
 static noinstr irqentry_state_t arm64_enter_el1_dbg(struct pt_regs *regs)
 {
-	irqentry_state_t state;
-
-	state.lockdep = lockdep_hardirqs_enabled();
+	irqentry_state_t state = {
+		.lockdep = lockdep_hardirqs_enabled_raw(),
+	};
 
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
index e234b04373fea..2f5229132466c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -158,7 +158,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
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

