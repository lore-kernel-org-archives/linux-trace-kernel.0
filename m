Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646255;
	b=Szq/1mTdAKYm786tkt/sfrw34GX/TGAySgnBXYwEGSQUCERpl2jaBJkdP0HmNSa2moOs
	 HZ5MT+Xj9VyV70F0gPAX6eX3pdgM7buT2dM4/MHiXvcsbxyTlvnm/h9RLjQaESt8JVy4s
	 b8qB72XL00Yfbpp2ljd81BzuSDdM+JM+IjNYZn9om2mlqwgnPVmehApNeZ5XnWSOa0et2
	 68AFzMznWOPuRzpR454Tls3WD59ACMEADbDtPExPlwzuukatj4julIDYJV3eLLNFQq2UE
	 oDRNWxp8x73ubbMxP6kmzuIZve7hSJf2Y0U9gegoAXgJpTcSnnhL6zpp/0x9rekOX2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o431Tw10LszC2V1Uv9HWe6VBCp/9n4XWQz8uJL/s53U=;
	b=C8Fy323x0BnjV3xQ2YB0PNMcHaXhO2zRKhAwOobziCoMkKKdoEvSdnAjx6J6OG4e9s+W
	 V7Ltp+jJDdbNHgdcUb3Q0S2JMZnASBk3QkJJwdBQfIsI6ZFRZdlLiYufiWnVn43vG/lSG
	 gaGxuasfGrvdPOP//5P25nabKL8LjxMyY9z7686VHmrWuOdxHBznUqMGe/UVeuIabelno
	 AMxUFj9hLjhG01mDXD8dRcIKPMugOoWN8cAX3aXeuK+tRtT+R0zJhY/z/hq4ANsha3xJo
	 pWJ//Xzn21fhnSOf73Aavv8c1duwkokGXT/GDgBUhsVB/6m4dbdKhh50Nj/bA/PQtPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RzHwvSq2;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFAC60A2614
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DFAC60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RzHwvSq2
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so9649025e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646254; x=1793251054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o431Tw10LszC2V1Uv9HWe6VBCp/9n4XWQz8uJL/s53U=;
        b=RzHwvSq2K3s5a0rf/pDlZSEgoSA7iM8cuXfaPb7r/TLPrxl+I2LC8gNwKD2BUcXCK6
         O6SFBM7XdQRVhTDql5gW8i+3zErEep5djtSe7MUTJSt4Vyy6ICuNP7imXUtDe1eoxu37
         lGbYIBJ4eI0SJoRqY6aMdinrDOvkcQvt5V45URI/IZuErdzvr1nHqsBw8dYjJGQ/O7vM
         H0+FeMdrq9hnYUszy0CA9URw0h1HNdRhElAQlXrpEXr4pD7XP5mHWnL8fzmtMarP1Z/k
         aCuub+KE0gPpACapqN9xqJrVUhZE0AabWfr98dH9+IXvjbcmPNU1oO/wg3QZcFJUKoxY
         BGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646254; x=1793251054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o431Tw10LszC2V1Uv9HWe6VBCp/9n4XWQz8uJL/s53U=;
        b=b7VjUGu8oRY+rVKTedg0QwNl2qhtG75eUDJFQ2PUySFUghiyOk8GPr26fu0b0pcnLg
         F9QoBbQoo9m/okn6MdPa47EdgRHdiPTDz3VsYqOOEdpQNXkW7iBZRWUto1p6RMnlocBg
         Hc3vsr8ZfGVNNONuMop+51wF/Dd+YjuY7RpnjLp84A5yQqGtI4WPcfq29rthGOjn8hG+
         5cu7A+U8P2QHJ9z2ijocYl12HyEZLTRidGDdomA5mCaWUmhDRN3dCYxj8AOCzFHgs4XH
         5ZBaQNVMTCcV+Jvf1KngqTrKrpssO/1e1YpTmPstGFwFnDn43yMXoqCi4fdXaHgCm783
         Cm7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwe//tn6K/u91QhvAocNnU0kpxRHP4IWCwybDQAazK3OhUKSiIcn9bofXTetV8W3086lLX8wTasEQbHUQmbo+NjA1w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyYJ/fMqhWyI+5lVwQhg5HwY3p4TzKRPEo027ls2nkrBfd1+n8
	7vufHxysVX+5w2yOdBtXayzDDxfvHmc21Mk7vfTFbi+TBleWU7uSmBD4
X-Gm-Gg: AYBFou01PEkJKPMnSHnHouMkJBquoprwh6PbEA+oQox701R9x+cCtD7QCrX5VTZDFP/
	gs1hvlggzGDDupPJ/QJeMLdxRgPTCahqUcCPUtLTEyOdSFGY/yK5v6guE/PUCSpoK7V2gH9NZ+f
	HFU9VsCT2aZdFTIaEqUdHGyhZH6gIIojIuYwwdPdtAdP3ChgZTkFcMnBvEWzCh0Isaui6/no+dx
	4LhfjA08MbCYFrP5Q91JzkbIPB4wgglbNS1Tga0Cx6dJkCb7nhrMbkjw8fVrXMsynoM6lrVQeFM
	hGRxtJ672oquXcCFt/5GGbdWO6NmJqGiT3AsbW69eiy1ULqmMtuu5ssvTU3o3q1AER3NUsq0FAF
	SM4Gez+TCNqTznBweS4jA+GGiTVo0sbyeUVIHvVdlT9bG6vUW6TeFZUdMCqgGYUgD5g0CSUhQEP
	gUo3hmIfmW2Id04KvA4WisOUZcP4uztoo4j9orT4wTh68w5NXWIO0dsNK49VcWZA9Islp5tUg+6
	fWGvAS0QiRP3Wrk4YuDs2atFa0sgCc1kdHUtf6sD62jEsFFsWCZL+oYGZgYMkB0h52brRcDOsxf
	kDDIdz1jr1QvvnnYNYyrcXsfELBi3fbhoHf6sE42ei7DV30QRm9+AKLgFdzt9ASuzejWCvgDqjA
	XMu3NQITqUhSPHUbcw6sYMaZ5Ak8cvbSmsC0NuGoskJlGivxuax4M6R7mRTA=
X-Received: by 2002:a05:600c:4e03:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a1fdd14200mr75350095e9.12.1792646253837;
        Wed, 21 Oct 2026 22:17:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:32 -0700 (PDT)
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
Subject: [RFC PATCH 07/12] entry: Carry ordinary-hardirq provenance through kernel return
Date: Thu, 22 Oct 2026 07:16:49 +0200
Message-Id: <20261022051654.79224-8-kmehltretter@gmail.com>
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

The entry state can cross hardirq teardown and a possible reschedule before
the architecture completes its return tail. At that point preempt_count()
no longer identifies whether the original entry was an ordinary hardirq, a
synchronous exception, or an NMI-like event.

Record ordinary-hardirq provenance in irqentry_state_t and initialize it
in every entry path. A later return tail can restore hardirq classification
only for entries which established the pre-counted hardirq lifecycle.

Assisted-by: LLM
---
 include/linux/irq-entry-common.h | 4 ++++
 kernel/entry/common.c            | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 24c2b9fdff4f4..2ed637cf66b0c 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -333,6 +333,8 @@ static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
  *            exit path has to invoke ct_irq_exit().
  * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
  *           lockdep state is restored correctly on exit from nmi.
+ * @hardirq: Records that irqentry_hardirq_enter() established this state for
+ *           an ordinary hard interrupt.
  *
  * This opaque object is filled in by the irqentry_*_enter() functions and
  * must be passed back into the corresponding irqentry_*_exit() functions
@@ -347,6 +349,7 @@ typedef struct irqentry_state {
 		bool	exit_rcu;
 		bool	lockdep;
 	};
+	bool		hardirq;
 } irqentry_state_t;
 #endif
 
@@ -396,6 +399,7 @@ __irqentry_enter_from_kernel_mode(struct pt_regs *regs, bool hardirq)
 {
 	irqentry_state_t ret = {
 		.exit_rcu = false,
+		.hardirq = hardirq,
 	};
 
 	/*
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 36c43d3c76eae..ba5959a84bc4a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -112,6 +112,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		irqentry_state_t ret = {
 			.exit_rcu = false,
+			.hardirq = false,
 		};
 
 		irqentry_enter_from_user_mode(regs);
@@ -140,6 +141,7 @@ noinstr irqentry_state_t irqentry_hardirq_enter(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		irqentry_state_t ret = {
 			.exit_rcu = false,
+			.hardirq = true,
 		};
 
 		__enter_from_user_mode(regs, true);
@@ -199,7 +201,9 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 
 irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 {
-	irqentry_state_t irq_state;
+	irqentry_state_t irq_state = {
+		.hardirq = false,
+	};
 
 	irq_state.lockdep = lockdep_hardirqs_enabled_raw();
 
-- 
2.39.5 (Apple Git-154)

