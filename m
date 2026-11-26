Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660273;
	b=0oV2BNDtYku2dajfzJVuEm3glfcHHCwZbG+xZUIS9A8f6UXc8OyCd0ZvssQVsorhtiWE
	 13wPFIkzZ7b6xZsePMp4ZXpDVMnsip+Cag4T6GgGN/GQ6qqH3zgdlFkg66Ex1a7Ae1s7l
	 HrPaPQLG/7Oj9VFC9eYUA7LIJc/OhRAOkUpx+w7PNjknj/MW8Fvfh3gXYWrFARmKqAans
	 UKTgAPM6oia7VPLrtiyh5GGvPkZ2ECD8jvs8y5UeGpBp+tHEP7zPSoD2yirSvlT/QrCVt
	 jAVetLZYetM1TGG5fuocEB3bzEy9PSrJYB5rb3WwlCu1paKHXyWwrU+0uca2ufRko/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NA3dxPx5kpLeZIBZWy1VGAvPGIUfeVILehoK5Z42ZCI=;
	b=TFsPim6/YYagXv76Lv1o0QdBouqyaDnKwktfSp2I7R+o2zo7uj/dipR309pdWXiXptT2
	 z5mywuHKWnOVmSGh3ubfnnXEndECBLUgJPPm8Ez63H8iJEmMRg61BBO/LfMeF7smNHyQ6
	 YZou7MsH0e3DG6FqUTo/2+/0lA845GU3p5VgTSStlhoYhtZfhk3u/jT2z3OLahNZTkzYv
	 svHDi8/1BcIB6i1La5s3d6rhVfUhbdRfuoiI9As00rU+ZWIz6ZoEedH5xzBiWX/ijtD+S
	 e5S3pRdOaTDGcjDfEb6CTNu8U0ioVopdj3rZY4UUIPQ8Skhn29W6z2pt4TU8+U1KP0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LUquglpk;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CF606A334
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 02:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C0CF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LUquglpk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-492690dd5daso4908347f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 18:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795660271; x=1796265071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NA3dxPx5kpLeZIBZWy1VGAvPGIUfeVILehoK5Z42ZCI=;
        b=LUquglpk9Yta9sPSg26o2HWSPXSKMYtImXRdZQ0zz/gF21pMkwWUrO4VG/7fKlRbU1
         hldloSMca2+7ATdQZJ+ekLZumicx7xeS37zCJYGF7GlEivaJ9biDuX3WOU0UUL55T4pO
         wq4bGxdY26aURiY6ApiQNzvZFCudo3GdvuIE71gwAyPl+nFKJUcI9+0S/8DXX6pztYQj
         qNiZ3kfC7b2NOI7tb2TGu57y8R/nhX067IyQRIIao2JxNDOe4coe8LmXZBmXvinat/+j
         EgDepwUvIKrNvb2nYXXSUjSCrMWx1BxbkrJPJA4x+vI+/YVDrZOtbyPvs7FkR5HCzli3
         JuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660271; x=1796265071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NA3dxPx5kpLeZIBZWy1VGAvPGIUfeVILehoK5Z42ZCI=;
        b=j5S9ju+JvLqDD/eTg1j15E6V0V7HnxYYAUReOGlxNKJm8vtf8yHH02cWoR47yJbQtX
         7b3+5EqKP601fUsWL2kZQckmsKRqu75UbYbxNFsRwVL8OTK4rOfNUjx4M6hc03XGjJtX
         S6SmxxGFRXPPUoLxzh3k7P1NxvKqGH5OApemUshbMM21BASKY+P8SERNF+u7sa5wxlOA
         Qq90i8XQG8wZHUY4x0uW8Mv5Gs/ZHMJYpiA2s+PbQy6ltrKuc8aDhS2EcAMdcUsboWPz
         H0CiiDW1+/uh2jHbf0K7Xi74P3uc7GtlgwwzA39YJoL9Lf4tJivO4BdcVq7g8w0rmkuF
         WLDg==
X-Forwarded-Encrypted: i=1; AL+hErE6xqbZsZP0TIf/otjBLs1h/F1Fq9aXEe2wBN4Xov3XIxDK05T3NMWGhXCEJxbVAvwabBxhFyYC3iorzg2Vz5JsX/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/vi4CwXdkmnpll0XbXM/fT3PL6+pE+WoN3a73bY4J+Lr32RYs
	SgRNQcxZi8FfsY/enhvv5QqUf6aM3+LPOFDRKu/CcdGys2deQmGU8SIX
X-Gm-Gg: AZFdTZeykDQR8Gy+FHPo5v5ONHSdYTaIXmk7+Z2TzCZ9uGZIEKY6u+ILQU/b1AjI3+G
	k9BO4+J04hGTa/IcjLnZTANW1pP6D8U05PuaTXJoviv4nldOZkStTB4Jl2c31gZy6q579yAAqOs
	6dICARyMvwLbEn2h9tO9i8TyR6z6fzWQaHLT4dm5fDgWh40/CS/duYunGTV60uo8MGXf0cpqDth
	53zyshYstLNJyvPfaHdQlYN46chOIByX4HTzTG6iGt95nZtbFxAqrAtLYPXcXYEZBwMl87TysPS
	Y2U3OakwCqrrWjT7tfLoCWdOvRC07flr/AdnP7d4spEHAwLaDNoZzjUu1vyrjqOWOpFoOod7BUT
	zwRQ29MPN8xd5pp8tr/IjZd6B1pJFJolqDWH54dmDEygYnBH3ztxlzNHyWOBorQGwKcYKirBirZ
	tGlbKPPFRn5gwHK1lm0aMXI+ci/SqHhn7kcyiF6fXxEtu3cnOrhqyjqJI941Cnfiflf7hGXpKg+
	gJlttn2tZJLUPY6aQw9qgeRPhtOax9Ten9vjheoeMesq73P6TzIWCUgJ9gLK5ag+dSXt2/h9M/I
	ozGz4EgtxYVy1oZIAwMQ4Im5fic0tCNV3HWCloqPfyRtzgaWoAdU7nMCuDYHNN0ORGduE4o6p5q
	6xv80vKuXH9OSrDT+k72SBdkECdLSjfgcsezBUYSHOTYiOerrST3nvdixpxrG5+5eF7ElHA2Taj
	80Mh/h8bquE7chCnCppiVtU57a0J/DY6+fiwGlyA==
X-Received: by 2002:a5d:59c3:0:b0:4b5:b60:4814 with SMTP id ffacd0b85a97d-4b50b60487bmr20466444f8f.54.1795660270516;
        Wed, 25 Nov 2026 18:31:10 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b10e-d501-d0c4-b021-8d77-e472.310.pool.telefonica.de. [2a02:3100:b10e:d501:d0c4:b021:8d77:e472])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm37722445f8f.20.2026.11.25.18.31.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 18:31:10 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Song Liu <song@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] sched/preempt: Check preempt counts in notrace helpers
Date: Thu, 26 Nov 2026 03:30:54 +0100
Message-Id: <87f882f6c8a66a3d293b6ec00612fd5f25cb2edd.1795631277.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1795631277.git.kmehltretter@gmail.com>
References: <cover.1795631277.git.kmehltretter@gmail.com>
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
CONFIG_DEBUG_PREEMPT, bypassing the underflow and near-overflow checks
used by ordinary operations.

Add checked noinstr helpers for notrace preemption-count updates and use
them in preempt_disable_notrace(), preempt_enable_notrace() and
preempt_enable_no_resched_notrace(). Export the out-of-line helpers for
module callers and retain raw updates when CONFIG_DEBUG_PREEMPT is
disabled. Remove the now-unused __preempt_count_inc() and
__preempt_count_dec() macros.

Share validation with preempt_count_add() and preempt_count_sub(),
leaving their preemption-latency tracing and ordering unchanged.

DEBUG_LOCKS_WARN_ON() evaluates its condition before entering its
instrumentation region. Branch profiling would therefore call
ftrace_likely_update() from noinstr text. Make the Branch Profiling
Kconfig choice depend on !DEBUG_PREEMPT, covering both
PROFILE_ANNOTATED_BRANCHES and PROFILE_ALL_BRANCHES without changing
non-debug configurations.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20261029093219.GH1779021@noisy.programming.kicks-ass.net
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Replace the kernel/sched/Makefile CFLAGS_core.o override with a
  !DEBUG_PREEMPT dependency on the Branch Profiling Kconfig choice
  (Steven Rostedt), covering both PROFILE_ANNOTATED_BRANCHES and
  PROFILE_ALL_BRANCHES.
- Remove unused __preempt_count_inc() and __preempt_count_dec() macros
  and clarify the changelog wording (Hongyan Xia).
 include/linux/preempt.h | 23 +++++++++++++++++------
 kernel/sched/core.c     | 40 ++++++++++++++++++++++++++++++++++++----
 kernel/trace/Kconfig    |  1 +
 3 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 06ff44a4b8b..b60fce55a35 100644
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
@@ -228,8 +239,8 @@ extern void preempt_count_sub(int val);
 #define preempt_count_dec_and_test() __preempt_count_dec_and_test()
 #endif
 
-#define __preempt_count_inc() __preempt_count_add(1)
-#define __preempt_count_dec() __preempt_count_sub(1)
+#define preempt_count_inc_notrace() preempt_count_add_notrace(1)
+#define preempt_count_dec_notrace() preempt_count_sub_notrace(1)
 
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
@@ -263,7 +274,7 @@ do { \
 #define preempt_enable_notrace() \
 do { \
 	barrier(); \
-	if (unlikely(__preempt_count_dec_and_test())) \
+	if (unlikely(preempt_count_dec_and_test_notrace())) \
 		__preempt_schedule_notrace(); \
 } while (0)
 
@@ -283,7 +294,7 @@ do { \
 #define preempt_enable_notrace() \
 do { \
 	barrier(); \
-	__preempt_count_dec(); \
+	preempt_count_dec_notrace(); \
 } while (0)
 
 #define preempt_check_resched() do { } while (0)
@@ -291,14 +302,14 @@ do { \
 
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 515b9d0353c..017549d1f72 100644
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
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 35d043b1933..a940dbe551b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -663,6 +663,7 @@ config TRACE_BRANCH_PROFILING
 
 choice
 	prompt "Branch Profiling"
+	depends on !DEBUG_PREEMPT
 	default BRANCH_PROFILE_NONE
 	help
 	 The branch profiling is a software profiler. It will add hooks
-- 
2.39.5 (Apple Git-154)

