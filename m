Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158321;
	b=niKSU31E4Syoh5AmT1uUAK6LAJkQyZLmREQ1cuZxElLQG2qbTvaRf596Z1p5Mq2WHf/U
	 WNuJnbs0F5ALwfqTMPAQCMz/Qmo6escn2omrQzLF/TS5oPd1wjxHzssxLMj6xTO46FvQO
	 YkS8EGTUjLRyxAIlibsylmnC3e5xDR9od++51tNrjHIzdrWiqMdLK5RmOsHcKP8DNO6Zy
	 6PmvJhK8N/YTuaF/OnnDcx4T85yVxTlffUXFGUpj/TInYTr1EVDTqkFMR+X5BZItZaYw+
	 IHNJGVgXtfVD0piEJOge+9salyl7PpoRnj6lV5cvnWLlgmL0fLy/lTRKiAQBUmYhn1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Uboz3++C7Vd9eZqJpqK4o7EY0U6A0LogLMvrqlbwgTM=;
	b=QYNxShKGlm+eaBvMvl6RzKYcoE5wO8k01ULPLeQYTYkaXIG0NqPCZKX6g0o5E/mVI5aL
	 q9upMkIEyrSCq2a5e/kaORVqAycRAyuZtPWmPBE8AUjxNOirte31ouiQo+bs8Q7lS1liK
	 kqr0KphMqqAtWT/Z/utQG2fZhnEbp4nEQ8hbRX5qi538AVozyewOfM6hO9Mr5QgdGO7BH
	 czl8CqAE2xfjOyTSN+X5MPiOKylVLxWh6+3XnpKKsYhQMD6N5nweFE7yG3SdusfZhjhsK
	 6Gmi3MMChXdwRO/nYV93uLSf3N2bPFAt5n91p0mvxCa9t3wuAlQGcSwKLtRTIbaeL+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byqKZ7W5;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD62606A32E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD62606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byqKZ7W5
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so381992f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158319; x=1793763119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uboz3++C7Vd9eZqJpqK4o7EY0U6A0LogLMvrqlbwgTM=;
        b=byqKZ7W5UhcRnSu2xxUZbE+yuSVLG5xXpLtK7cb7czM3NOEXtb6wKc6iXFz2DKpwA9
         wMMJxxbtH2nyjid4h+HCiHZrWvG6538k/yc0/3xF2bGRJU15yX+EkqfA/n7BgmD1DBrP
         dG70rDNxKUrsvvDyFunqI4goaCGmjZi+m6z3O1PPT4yqwNsRZq8epZYulFKe6vkGnX+B
         cQVOJZQbjs1l+qhuLvjydugvN0jOJT0WzPUeM76lU27qI496W7dQCLgrZAN0HctCTGOU
         lsLtoQb7vHfYkb61UEwwYTNpU7Cnf+YP7WdGSPAdz5DB9aQ5KdYnYi1tjAfnoB9zzXV/
         i1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158319; x=1793763119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uboz3++C7Vd9eZqJpqK4o7EY0U6A0LogLMvrqlbwgTM=;
        b=it2JTUDu58zAe1BdExHrnDNZEknew9+EyZmJz2khn43hF3Xat+OMrd00Az8GoFZAxR
         6FuNbQ0gk+NLUWNogUbmIQIYl9DQ0NGX0cY80w8gsQAhD2nZifW0M0OXr/7oqR2s1Wtz
         fd1NrIX2ke2yI20d2UflrreBknW7zZ8JnvIp+DyOLfkU49qV+SIHgI/7nm4VC5HUEzsJ
         KrL5xcMnjKDGqtioQ3blQqzvTIkXx0veVlu59hcRW3sSNJJhbMze58SKtkEUGKOKhRls
         SZTT3uD30+WRtEtKIjrSlDFyaBPHpDVcQ6S8BxoqkXR2jmyl5pG+T+lig5iZRt6SsWYe
         05Ng==
X-Forwarded-Encrypted: i=1; AKwUvBxE6sCCcXapr1mj2p6XNxp2Nom/t1o/x5nRcUMOP9l/g7MrELuvuFMTYlBz7cUSNRORBG2MXNDcmtzfYvFCuBQ7ojI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdE+JOSX8KDDHon+fRvpVDjCSQbDpJBuW+quBbr38vI1ZR69Jh
	cKyW0RtMzlFcfodEhLmQwgb9S79uj3u5Q7+mJY4WcF5wj7FRzwBUlIPV
X-Gm-Gg: AYBFou0baBB9uz1XYjP+lxpCuDh7bUVO0FLbRaoo4ww1Eiqh6+/g1fs1CMklUst5vGc
	onQeEn+JDLBkw5BSq8PWaVV9IWl5ngRtLcpqUSYkCziniCuuYpHRfhXnJ4lT/GxUBlJ5J2+xJcf
	ryMCBQCXpdqbNyvwQlk3gqXTsbfPD1DNkcTPmjThVRkFq1nkAC6Rge3G52tozgV9U7fUWx+BINZ
	Jbabi2bvEJayb188YD79RuVJW8wz24QznMlDvj/4H/b2dr0I0wB/petKRqnqBrThQcBZHL7YpmN
	TdlH7DAZ7nJOlR6VjPciRoildoUO0nhGTGJgjPh8oMfqqO449tt+2P9mDXt9dSHsM6XIoHFFI7U
	Iu3Ep33vH4UBCYe0OiWEDRGfKt5RIcKTT3MgV8xt9c0XallzdSvJJedDklJ2ODSjCKWEcLNmj75
	0vjHMIAjMPQeOThgOUIg6zfQrUrMzwaBNNNC4xMIpXXYIp8Zb11LuuimTZi6H9Z2C+m8BCc17lS
	qCMXOKX6LPRfZZfCOTYGG3Od1RNl2qxB5ZSae2rxlav5C2OMDJ+MmSHIuW0R4954xJlmyuG6YCz
	E3NmnxDgudwnQNtovA6Mbylp+dBEer7ch2Ft06+j0Jg1hmqlhW8zcMFy0VTfvKkBYUB4EnarP11
	7YiLOfPMrlzYJoQULIK2KU1xAaT59R5Xe/5s4tQFJQy796ktwcNMvg4dUN72sd0/CTkFu8ihBST
	zL6khUhyX+5qhRIPXnXWzziYty78emrI2J
X-Received: by 2002:a5d:6f04:0:b0:48d:f7ef:cd1d with SMTP id ffacd0b85a97d-48e5d2e7526mr2965587f8f.9.1793158319122;
        Tue, 27 Oct 2026 20:31:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:58 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/13] entry: Skip inactive IRQ-return reschedule calls
Date: Wed, 28 Oct 2026 04:31:20 +0100
Message-Id: <20261028033127.82193-7-kmehltretter@gmail.com>
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

irqentry_exit_to_kernel_mode_preempt() calls the reschedule helper when
preemption is enabled even if the preempt count is nonzero. The helper
returns immediately, but its call and return remain traceable after hardirq
context has been removed.

Check the preempt count in the inline caller and avoid the inactive call.
Keep the existing check in the helper for its other callers. This does not
change whether IRQ return schedules.

Arm64 invokes this caller from noinstr code. Force its preempt_count()
implementation inline so Clang cannot outline the new check into
instrumentable text.

Assisted-by: LLM
---
 arch/arm64/include/asm/preempt.h | 2 +-
 include/linux/irq-entry-common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index f3a5c2cd1936d..3e9bcc6e76625 100644
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
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 289e308d2d46c..e1fd9155410c1 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -503,7 +503,7 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
 	if (regs_irqs_disabled(regs) || state.exit_rcu)
 		return;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
+	if (IS_ENABLED(CONFIG_PREEMPTION) && !preempt_count())
 		irqentry_exit_cond_resched();
 }
 
-- 
2.39.5 (Apple Git-154)

