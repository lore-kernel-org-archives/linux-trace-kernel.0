Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815685;
	b=CdRcluXIb4OHNDsShnsxJnUpcebWqrZ7RnBXfEkjhJQEpehGJtwIuHFdjRVGhVADcMkU
	 2Z4O95zJ3jA+fbQABObVTRALDYl6an5Tmca8nSy9mdU0WHUltYmYk2UdeVrc+StBjkXCN
	 7tIpgOaaCc1ij8izM9nkiyZz0+a17ZxADfN46utL1W9oudZJ66ZEe6P/iWtlenBboHOz9
	 fZqpVQN58BZS5sSLGGxRcsjDD/gHgdMjfbfAGZD6nSKdUxdZ7fo4lgTyCWLVIzd7LFwCK
	 oWEmTJ/I+G+EiASlgnuCY/9tW68aHw8cI3ag059/RD/GUVS3qCHOOGBAfjRERBe9DdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3S8KfE2z0glH5v8quz46BnbWAnWJFZkpiRBDqpKkjZU=;
	b=5KrG1UEzJ62BwDaD91UuAa3olw799J9+3rYZYg+/R22jffAFnuX4crTQbUJcf31RDpTv
	 DpE6ZvbqbOWotaa20Gx5W4XkuBELRZAnO1z4OFEqt6cp0p2wnLFD5YPchqXhiNRLhrgg1
	 SQUnYlClkJlcwXdpT974bgf/lkNAfGM1HsA+rVbWfgaa/geCPUbwc2LVqVmJiontsl5bB
	 jE97kCNE/cES52ugJcklOZ6JGpeYGvg2O9boIkUk6WH5o685XzYZHaffE21Cywefx+spI
	 oBawv8SflsjS86p+uxEfOIcqhuVTJnIi8BHM2BbpOgr4uSz42it2Bp4ZJjFAPWRRlpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Svoyk9Oe;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BD606A32A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 07:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 314BD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Svoyk9Oe
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so17525755e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794815682; x=1795420482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3S8KfE2z0glH5v8quz46BnbWAnWJFZkpiRBDqpKkjZU=;
        b=Svoyk9OeIgA5CrWzHRhBX/vVjGQ4KhCIwR8o+KZGSUeFauGW52ixWvTzihSZzy1AQF
         Jatlbgw2Oz/zzI8h3uf7zloAqp5S/zXdBi4u6E/YbQwCIIuH98hbAyryjBM9Gy8EvuUC
         jnJU0NM/O1FPwEOUUmZ0gt0YtUXszZZ4ZKrkQzerfilHTJVx7Jljx2KJFPzDX6NUDanB
         R8Om7gbV0y+Un8qQBOHE0KJC9QuaiA1PModXec5xfD8CUghQp7eIiepyoB5Qgk0HinjF
         Q5DpKj80L6HnqXk82BGO2/TZOE6VbgiX9pNz6htp5UInfwuxtd2BexPu2VhqvMFkrloN
         GQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815682; x=1795420482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3S8KfE2z0glH5v8quz46BnbWAnWJFZkpiRBDqpKkjZU=;
        b=EIXxKocU6XtyrmiMxdgivS32WANruBXl/xGMQk2q3Q1tzekEA+u76Av7mgWbvUSJSw
         K7LWKAnjEbQvWnyFZStnNQI+wwUKn5ORJM4eLc+WbXpQ/T6bAndkchXwTYWeUff6EGiq
         pGfXI72dNgls4Zl1ih2H9d5bDRIXLd6yw7bPe07MM4DyfHdSs+IuFBmA0OAfekqPp5ac
         B0d3c0QjBMdgbl1RnGUkFJT8/au9CFsz/xLTg088u9McUcKVfvZt+9QSrssuuMbnwnx8
         bS5NjffA9i29AWFB4UiKpBlJDNuyF0COFkkgVkntwmolIl+QYor5cMb2qj9Zz3cNs+/P
         j/Zw==
X-Forwarded-Encrypted: i=1; AL+hErFIC2ijuSgUJwLtfOa77nfLMUYXRns661gn9HPLYuDk1rpRcYETohD5PwtVNZqUvHKJqSHRudr3FjnTy/3bJ7DeTv4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/H4I1a99NGza9pCtXWJknmk7g52Zbv3j1tveKVLU9rMC5CIHPb
	HgOeUbXYcRUSxUNtth+qrVipSHeX91FOriuabE7ysuBJQRekQ0Mi7fJy
X-Gm-Gg: AYBFou3X0D+bMUOgWrcGOpdM2L3+DY/m+tIzjGt1Y9H3742WrcglLZXcM9drT1xqDTl
	o1UGwBW2nCr0o+E9XjiVhk3qNEw2YOUhSEctfQ7nTwoZz8myAibpnnh3/iOVe07YPlFOkoOoOaZ
	JepPMq12S+HZuNfwInm694+MwLT+/up7qAm8NRu85Wp0JSCTrBe3AVP0dV4PwHZ0N6FFj01E4ip
	b9h/Yr00OuyotQRlrY/DsESt7kf/amPhrvCItiv9ZDOsECYZR2ThP1FbImu0nY/Fp4wTQRP2zEy
	aoby73iwazh5jQC95F1ej75Be/CMQR+4xktjuHeqynbZlDsFYVNGeBbNAWk3Fa6dDQQGSr3Cj01
	AiXWBvVXKphIrjbMIPHCC3BPaZiowFHt3yZZKwPCr3eCD08gs53BRk+OaOoD1iJRtF/RhwJ8hy/
	tn1IUt5SGQQDthSZ+Xxlm0IDhjwo7wqTpSLHJnwGUKoo1toa0uznCmkcuMkjd8E7jbLm446tnKn
	TC7MrR5U+xV2Vm1eGcMC+Aq4Y6LxlTxKTt3AzsxB+ygv6qQDUOMVchSnHjRGbEjT/sunDjRQSkl
	U3kvZmCIuZQ+A1QsESvGmn/qZbs7PmOk9m2Y7Y2Zzul6B47mlkIQfIKoq+9phivA7pcc60HDsLC
	vwrosuTGNNvNO+v9H3wYOQKTphIVewxQVpIDdD31QSXUbs7CJvEbmizdi6JXg5hhmQdC1YJTLaJ
	6+lVhg7E5BBzLxHOu+KLdqifk/nJLP
X-Received: by 2002:a05:600c:2d2:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4bb55a63720mr149965015e9.24.1794815682214;
        Sun, 15 Nov 2026 23:54:42 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-148-032.95.117.pool.telefonica.de. [95.117.148.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5ba25b50sm210329875e9.14.2026.11.15.23.54.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:54:41 -0800 (PST)
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
Subject: [PATCH 0/3] sched/preempt: Check notrace preempt-count updates
Date: Mon, 16 Nov 2026 08:54:21 +0100
Message-Id: <cover.1794814699.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

With CONFIG_DEBUG_PREEMPT, the notrace preemption macros bypass the
bounds checks used by ordinary operations. Add checked noinstr updates
for their existing callers and share validation with
preempt_count_add() and preempt_count_sub().

Patch 1 forces the arm64 raw updates called by the new helpers inline.
Patch 2 does the same for preempt_count(), which the helpers use, for
should_resched(), reached by the debug notrace enable path, and for the
existing non-debug __preempt_count_dec_and_test() path. The corresponding
x86, s390 and asm-generic operations are already __always_inline.

Patch 1 is extracted from Hongyan Xia's entry RFC. Song Liu also posted
notrace annotations for the same arm64 helpers:

  https://lore.kernel.org/r/20261023011049.1164625-10-song@kernel.org

Patch 3 disables branch profiling for core.o when DEBUG_PREEMPT and
TRACE_BRANCH_PROFILING are both enabled. DEBUG_LOCKS_WARN_ON() evaluates
its condition before entering its instrumentation region, so profiling
that condition would call ftrace_likely_update() from noinstr text. The
scheduler Makefile already uses this per-object exclusion for
build_policy.o and build_utility.o.

The cost is loss of branch-profile data for the rest of core.o in that
configuration. Scheduler tracepoints and function tracing are unchanged.
A dedicated non-profiled object is the fallback if this object-wide cost
is considered too broad.

This series is independently useful. It also supplies the checked count
update planned for follow-up IRQ-entry work; it does not change IRQ entry,
trace-recursion lifetime or TRACE_CTX_TRANSITION.

This addresses Peter's suggestion here:

  https://lore.kernel.org/r/20261029093219.GH1779021@noisy.programming.kicks-ass.net

The series is based on v7.4-rc2.

Testing:

- Clang 19.1.7 x86-64: a W=1 defconfig-derived build with
  DEBUG_PREEMPT, annotated branch profiling, DEBUG_ENTRY and noinstr
  validation passed. A nested-KVM boot passed the built-in and external
  module checks and all five tracer workloads. A DEBUG_PREEMPT=n control
  retained branch profiling for core.o and emitted no new helper symbols.
- GCC 14.2 arm64: a W=1 PREEMPT_RT build and allmodconfig passed. The
  latter's nVHE object had no undefined references to the new helpers.
  A native Axion boot passed the built-in and module checks and all five
  tracers.
- GCC 14.2 and 16.2 ARC, C-SKY and MIPS: performance, size, all-branches
  and forced-noinline core.o inspections passed without prohibited
  noinstr relocations or branch-profile records. Full baseline and patched
  kernels plus the external debug module built. Matching QEMU boots reached
  the expected balanced and invalid-count markers on ARC and C-SKY UP and
  MIPS UP/SMP. The patched kernels diagnosed every invalid operation;
  rejected decrements retained their counts. An ARC DEBUG_PREEMPT=n
  control retained core.o profiling without references to the new helpers.

The MIPS UP baseline and patched positive boots emitted the same three
existing smp_processor_id() diagnostics; the SMP boots emitted none.

I used an LLM to help extract and review the changes, write the test
harnesses and prepare the commit messages.

Hongyan Xia (1):
  arm64: Always inline raw preempt count updates

Karl Mehltretter (2):
  arm64: Always inline preempt count and reschedule checks
  sched/preempt: Check preempt counts in notrace helpers

 arch/arm64/include/asm/preempt.h | 10 ++++----
 include/linux/preempt.h          | 22 ++++++++++++++----
 kernel/sched/Makefile            |  3 +++
 kernel/sched/core.c              | 40 ++++++++++++++++++++++++++++----
 4 files changed, 62 insertions(+), 13 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
