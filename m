Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815688;
	b=2XJ9UafD3Nb+jT3UEH68GNs8b2xpFxszYufSQXpVFZcXsgEiFES2mNAGT+FayTnJfgYI
	 UE4D092CXAaOVS9U01lWt/eSeP3tj1f0yaLtCCTHkJeBvhdJBewO5JaXA2/WPKCAAjyYc
	 NNrcCzdp16jPaotmXvuP6zmh77F3XL5I2+Du2jHAUf+GrmTQZz/WLWzl0ZnALbZfTylss
	 Spl0RfJylwCZafMsGSwf5grGxDBYqTpYC/ODKO2URT56pfE0OKlD6F73T6ZWGzJLOZxSX
	 SC26pJNpgBE5CvLGgGdRxK/9zY+HlveLHTHlQ6Eds5QeD0OXaUZD7t0uPQL90OKtqJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V/ALRmUD/hAy570O2Xf1osysz7Ylv+AoJE5xebVPkiE=;
	b=YNkmLftbO/xgyQMaYFXmPMkKqL7okTQAe07lumVvC1iIQYta/sM2co7qwQWS++eLtenu
	 XHs8oiiepXTSAB65p5Xq0s2PdEWxtV7JwvKfOTgOO8MrFT9Zp+rggXZEkkKl+K2G+n9v6
	 KX6UvT/ZCE9sHFJ2kqWwOyQO1Lg/552Z9Wd6+vzKr0x9jt/aTCSeu2PwIS2VTVktc8zh2
	 kH5IKc6dAqMDb+EllTxWUOcD6Qm95Nw+fb8LovOh58ZxzTRdg7Ft49k7otgrANpsqjmg/
	 hp/ewZ9Ic1J9b8KnnYbVrZ+7jImbf93/VtvTxbOyFX2dYRwD+bv9huTSrMat+gQupJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvZjNdHq;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4774606A894
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 07:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4774606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvZjNdHq
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so17526425e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 23:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794815686; x=1795420486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/ALRmUD/hAy570O2Xf1osysz7Ylv+AoJE5xebVPkiE=;
        b=fvZjNdHq+TzTFxD8WAWKmO3XhCPWghE4pID+d8gCU4kYBuG9N+vRpmIw2el5mQ2vgR
         173Z+k08ZqqHeEfuS0p+Q7KxYhIlOGp5AiP0o2TMTdJtRgp3T/Egm6KHcRSiE3ZNW0TQ
         8cFQZ1LlM4gHVxWHiH4ojeUbXTEgVXUWLL70LNPP9VL4/B4TzefBch/qZ2yekteG8c6p
         z5GCH3H3Mhgn8rfVzvnmOSAgVWvuZOaIkGnd+sFc/DCBFIIHidQoyy4OiaBXzzC0Jk1r
         VcfxEzctgflDlFSKtEHB9rLIqSMCeZoMBjZf1yZ0VR851oTEKzCuirCdjH+5MwCdWC6m
         7e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815686; x=1795420486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/ALRmUD/hAy570O2Xf1osysz7Ylv+AoJE5xebVPkiE=;
        b=iyfctmyjNZbDsHCmyypTgTFP0rC5Pvavhrfh0OowE9+3R74VmCg1YGT8jkTCUgNJEv
         vBVWQige+6JhDZmKdsbo2x8aUwbTuGW6ARldUXGGJXY4QLfX6f7QE0AqrBZHc1yN2VSJ
         FDiemjspDw02VjaIhMuM1lkQQunkBmroD1gxCCTleJh56SdaUxsYtbu3Iz3T2Q1qPPce
         9/T3ZrWAiUgkOa+6GKbrMZdpWDeSG/1lIcaJ2S7BfBwjmKV94ff3DSe8dM0QwebJtXi3
         VJ4S4liknwu/ApQUqItbqfEg9SjIcdn9Pj9o6Vgsl67PipijeJBQkvJCtXgcizHF9ne8
         qaAw==
X-Forwarded-Encrypted: i=1; AL+hErEJ8Wrrzih42NIMOvwAefvdGSZxk9pi0+OfLIqjmENJoB4rEqFLWUcEyOLgybjnYHcMZdd0CzhmEKSHIzxG82ga3kU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QR0/CLyMtyV9gVMTfw+IcPd2jmAVBX0QeXd2gEYkIxqPXnjxB
	anq1gD8Man7VwsE+xAZWKmtiG2bPeBhWPy0jHaE0mcXIvlNCYhfmLA9a
X-Gm-Gg: AYBFou2mmSwBelHzRGLAOfen4dkZ5m45Ba3yrniJS5farcuJTMkwEyLYlWvnAcgUh1U
	8LwFU4XR8yAljavk51P82rsS/wf/jE+Lf0bZ3dD6EKfC0ogy3zB06iF0ZL2s+NMooFru98NBI6E
	uEDxFwfyMQNuGqwsnCGUKcv+w2gFPXPraJAHe7Tx8RTdQSGwyLQ1HkhgkQfocbKCo38IOTuFr3E
	HfM3nXd29vKLQ/ZSvTki19TLylEwGQcW84v7At+s9ODQNe8GBV7dcOtPrJrdtqVvYX99N2povIj
	/wyI41cNk6JVm8+jpgnpvlov/R3W+w297Fn6Anufp1w8KGdJEMfZcdBxUfmRO8BZpG9UIEJdcTA
	dDjLzJViZLCjuHg63Bll091aFDmvA073faW62Lyo3WKDBJgJkRUUmkHFV3/yRqgymp/iPFgP71N
	DA5BDiZh9kj3uy/7WRLXmleOJP/VxOV3hVAoh8rRl1plrTIcdyFnHfDB5+737HclsagF+Ms+302
	ON8in8dMjSyDVTSkN/M/XvI6X7UaYJ6yrxqy/S1hCoMM3UqvKCVc8qPxnWoPlku6OYmLkR1LEvH
	5cF3Zu0y6mOIYGba9dZJUfwCNA3bwfSa4Ogb2nY/CjftkNgQZMxUUj1kUfYxUMd5F+INXxRxHFS
	qkxNxsQDA3c668jlcnr8NT/fc81sKaBPAx0GtFv79N++cCv5cmKYPt9b8aMfkW2XP8mr53jSzUu
	Y0ZeJTeoX2fW3+kBDsFwskWTJkulSi
X-Received: by 2002:a05:600c:a010:b0:4bb:6238:cd81 with SMTP id 5b1f17b1804b1-4bb6238d365mr123245015e9.10.1794815685909;
        Sun, 15 Nov 2026 23:54:45 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-148-032.95.117.pool.telefonica.de. [95.117.148.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5ba25b50sm210329875e9.14.2026.11.15.23.54.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:54:45 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sched/preempt: Check preempt counts in notrace helpers
Date: Mon, 16 Nov 2026 08:54:24 +0100
Message-Id: <446e2bd042ce071da52ea80f577fe43c1b3dc031.1794814699.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1794814699.git.kmehltretter@gmail.com>
References: <cover.1794814699.git.kmehltretter@gmail.com>
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

The notrace preemption macros use raw count updates even with
CONFIG_DEBUG_PREEMPT enabled. They therefore skip the bounds checks
which ordinary preemption operations provide.

Add checked noinstr preempt-count helpers and use them in
preempt_disable_notrace(), preempt_enable_notrace() and
preempt_enable_no_resched_notrace(). Export the out-of-line helpers
for module callers. Keep raw updates when CONFIG_DEBUG_PREEMPT is
disabled.

Share the validation with preempt_count_add() and preempt_count_sub(),
while leaving their preemption-latency tracing and ordering unchanged.
DEBUG_LOCKS_WARN_ON() brackets its diagnostic work with
instrumentation_begin() and instrumentation_end(), but evaluates its
condition before that region. Branch profiling would therefore call
ftrace_likely_update() from noinstr text.

Compile core.o with branch profiling disabled when DEBUG_PREEMPT and
TRACE_BRANCH_PROFILING are both enabled, as the scheduler Makefile already
does for build_policy.o and build_utility.o. This keeps valid notrace count
updates free of profiler calls while retaining the existing warning path.
The tradeoff is loss of branch-profile data for the rest of core.o in that
configuration; scheduler tracepoints and function tracing are unchanged.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20261029093219.GH1779021@noisy.programming.kicks-ass.net
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/preempt.h | 22 ++++++++++++++++++----
 kernel/sched/Makefile   |  3 +++
 kernel/sched/core.c     | 40 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 06ff44a4b8b6a..42c585fd91d45 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -217,6 +217,17 @@ static __always_inline unsigned char interrupt_context_level(void)
  */
 #define in_atomic_preempt_off() (preempt_count() != PREEMPT_DISABLE_OFFSET)
 
+#ifdef CONFIG_DEBUG_PREEMPT
+void preempt_count_add_notrace(int val);
+void preempt_count_sub_notrace(int val);
+#define preempt_count_dec_and_test_notrace() \
+	({ preempt_count_sub_notrace(1); should_resched(0); })
+#else
+#define preempt_count_add_notrace(val)	__preempt_count_add(val)
+#define preempt_count_sub_notrace(val)	__preempt_count_sub(val)
+#define preempt_count_dec_and_test_notrace() __preempt_count_dec_and_test()
+#endif
+
 #if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
 extern void preempt_count_add(int val);
 extern void preempt_count_sub(int val);
@@ -231,6 +242,9 @@ extern void preempt_count_sub(int val);
 #define __preempt_count_inc() __preempt_count_add(1)
 #define __preempt_count_dec() __preempt_count_sub(1)
 
+#define preempt_count_inc_notrace() preempt_count_add_notrace(1)
+#define preempt_count_dec_notrace() preempt_count_sub_notrace(1)
+
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
@@ -263,7 +277,7 @@ do { \
 #define preempt_enable_notrace() \
 do { \
 	barrier(); \
-	if (unlikely(__preempt_count_dec_and_test())) \
+	if (unlikely(preempt_count_dec_and_test_notrace())) \
 		__preempt_schedule_notrace(); \
 } while (0)
 
@@ -283,7 +297,7 @@ do { \
 #define preempt_enable_notrace() \
 do { \
 	barrier(); \
-	__preempt_count_dec(); \
+	preempt_count_dec_notrace(); \
 } while (0)
 
 #define preempt_check_resched() do { } while (0)
@@ -291,14 +305,14 @@ do { \
 
 #define preempt_disable_notrace() \
 do { \
-	__preempt_count_inc(); \
+	preempt_count_inc_notrace(); \
 	barrier(); \
 } while (0)
 
 #define preempt_enable_no_resched_notrace() \
 do { \
 	barrier(); \
-	__preempt_count_dec(); \
+	preempt_count_dec_notrace(); \
 } while (0)
 
 #else /* !CONFIG_PREEMPT_COUNT */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index b1f1a367034ff..d87f1bd3c28c3 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -27,6 +27,9 @@ endif
 
 # Branch profiling isn't noinstr-safe
 ifdef CONFIG_TRACE_BRANCH_PROFILING
+ifdef CONFIG_DEBUG_PREEMPT
+CFLAGS_core.o += -DDISABLE_BRANCH_PROFILING
+endif
 CFLAGS_build_policy.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_build_utility.o += -DDISABLE_BRANCH_PROFILING
 endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a088d4576f59..98ca93bc60887 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6040,7 +6040,7 @@ static inline void preempt_latency_start(int val)
 	}
 }
 
-void preempt_count_add(int val)
+static __always_inline bool __preempt_count_add_checked(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -6052,7 +6052,7 @@ void preempt_count_add(int val)
 	 */
 	if (!IS_ENABLED(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS) &&
 	    DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))
-		return;
+		return false;
 #endif
 	__preempt_count_add(val);
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -6062,6 +6062,21 @@ void preempt_count_add(int val)
 	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
 				PREEMPT_MASK - 10);
 #endif
+	return true;
+}
+
+#ifdef CONFIG_DEBUG_PREEMPT
+void noinstr preempt_count_add_notrace(int val)
+{
+	__preempt_count_add_checked(val);
+}
+EXPORT_SYMBOL(preempt_count_add_notrace);
+#endif
+
+void preempt_count_add(int val)
+{
+	if (!__preempt_count_add_checked(val))
+		return;
 	preempt_latency_start(val);
 }
 EXPORT_SYMBOL(preempt_count_add);
@@ -6077,7 +6092,7 @@ static inline void preempt_latency_stop(int val)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }
 
-void preempt_count_sub(int val)
+static __always_inline bool preempt_count_sub_debug_checks(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -6087,15 +6102,32 @@ void preempt_count_sub(int val)
 	unsigned int pc = preempt_count();
 
 	if (DEBUG_LOCKS_WARN_ON(pc - uval > pc))
-		return;
+		return false;
 	/*
 	 * Is the spinlock portion underflowing?
 	 */
 	if (DEBUG_LOCKS_WARN_ON((val < PREEMPT_MASK) &&
 			!(preempt_count() & PREEMPT_MASK)))
+		return false;
+#endif
+	return true;
+}
+
+#ifdef CONFIG_DEBUG_PREEMPT
+void noinstr preempt_count_sub_notrace(int val)
+{
+	if (!preempt_count_sub_debug_checks(val))
 		return;
+	__preempt_count_sub(val);
+}
+EXPORT_SYMBOL(preempt_count_sub_notrace);
 #endif
 
+void preempt_count_sub(int val)
+{
+	if (!preempt_count_sub_debug_checks(val))
+		return;
+
 	preempt_latency_stop(val);
 	__preempt_count_sub(val);
 }
