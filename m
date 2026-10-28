Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158341;
	b=BOCB/UtBhPWE+DYblG3lVTKVoOJIz2r7jEKp/yeSgvTebLek50IP6jhioTJLLwCREc3x
	 9lUnEpjWkih++v5HDHZKOeEm+QAf6iFNLcIKaSG7wROPZpPnO7wJFQHQZjngu7+pGfbgQ
	 cUEkP64ovH1iDJM3MVk9vrkhsOQxp0TSEUfzIAfeyCl46pBjkK1Bo03S/nhmy43XRWBAN
	 Jk1573rSS5H1WwR82Ds6TVskOg7DdCfYwVjVlCvCDvVrpgY4U6oAuGGnWL5vCBCiuUZiz
	 lrktZ9C5tFa7a4XnUbfu1lD7L/PmPRzHgOKWZ6ec4wWvxfZ+8Kko4zi+Bjj+tdQJkSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZR3iK/21HRL590OT/HWs7TggzA8Gmahp8IuVcPxIo1I=;
	b=2+SyjT930EcYdRYIJV3FZpZFLQpP8UkV9y2dBs33ICHUBBKro9wK4mymMsvasT/RIOJG
	 AL24swtBKtVInMw9HfPiHk3rQPmf/0msKLRHoZJL5fjSPiQtIHmJ2nGmj4U6AAK2ccFIr
	 3KUEOwXMSTbjd0AI3e4D0gZjNnTQ5XKX8f3Wk4Nozvr4scY8i5bM0r4yJ/Np+yJkMRvEm
	 B/bDkgu/64thAbLt7OGA1UOGfpwZF8CsxZDvq39pexi32zvPBupgOybPjNakA8V9BUMwE
	 Ii6cPhJCnAGaRrF0RPaSp0Qz+3+wly3nqXlniOsFdZ7M6uGwaIoNZdlQjSGyKlHb0MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Td9F3R7p;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA54606A33F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DA54606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Td9F3R7p
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so949565e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158340; x=1793763140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZR3iK/21HRL590OT/HWs7TggzA8Gmahp8IuVcPxIo1I=;
        b=Td9F3R7pKt9XoyGMCk2tSwEFepXc6mG0UKbjwl4qrQPGswD12MrUnQNew0T0VRdVx7
         Z0ASLPwsJAX6QRsg5D6z23EVXQ2Ij7jQvCFtTbdkbwv2ZLCC/x1dqh6Bf1tgIJW8y3zf
         K8R58PTVmwPzqGUT4lIFqDjBHVlL3f8McSL/ryhcPxOO+n36Tl/svJ7iBjqTIdlIDe8S
         YORIEupvQ+PVliBwnBmNTvqvHz64J9V4C495f7Pv297tROUMULxaTRDp6OIyJPGQsbeg
         6UlwdRVZsD3MQN95UOXuEcpKM9WBvg4sTUemDgeJMG5zEst3NYtyD0tLqVDiikRt2uiG
         kmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158340; x=1793763140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZR3iK/21HRL590OT/HWs7TggzA8Gmahp8IuVcPxIo1I=;
        b=DrL1O0MOq+TnwiZH5I9v0Xc3+QoZRCL6RJEKxk4ww8pOC5w32Wm16qjKClehe6ou1V
         9Aq8EVIy5HKzCtR3DCOwH5X12zZYsxCnVFPn/BPm8ZgAPN/8/UZ2w086Z9Gy4buAx7sk
         oV+q15c5hYI4IpyOPKgcG8I3TToO1aNljXTBp6VQUL36qCWDhl7Dcky1Rza1LrJPoOYj
         P0GaV0wJxb+J29teEhYUI/CCFDnaJmjpDmhTuvEah4QLoCe55l4aGigJIxFd4NZy4Nb9
         qdjvrg1ZYqw0iJUHrUUNeNvDqm+Al8TiCiPFlWgqrK0gWHGSMSadeWEu0EEgS3yD9Cxh
         bcKw==
X-Forwarded-Encrypted: i=1; AKwUvBxfdPp3euPLPGqCr33GLSFngJKtgvKcfAru0hUp1LBm0OFuOqAxol2SCSYts86ERsNcLAj/uq9lcjvdi6IhnGW0qzs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCUiF4Rp5YD5V5OJMbq2q2bYGvUDifWQgmbxvSUK/TZ6bi323X
	pUYbXdHotDKr5V6y1aPETtgze/GBZKYLF0kLkf14esW4xEPVNs1q2vQ1
X-Gm-Gg: AYBFou2X3omM7SdWvNiZ8qahMJQyresqsXuBdtrQHAI4AtGj92q7AX0PwMwdesWCIvJ
	a5LRl7pWR4f5mMILBTCTnhgJXptjasvvgGAhMl2cDddTsiivOV42NyaKNZqyauWZAcpSCC8kL/p
	WgcuEwPybCGeeWpbaxs/oJqiAeRVbQ5/9ZHzyZROgi22dc8xto20c3SjoRCKsQdvsfBFaQV2uD9
	M7h6pLYPPmL8oHWMk8xhIDaOMFmQrwidUvTl6yMBaGl+MhRlGIprsFiiosC2Y7a8hWPOeyRqy1A
	PvD94kz8o1KZWqpzi30JgeX+c2ZvvoUiSY9XcCVMluT3kAUW5u4DyoqRa+t3LvdUtnrSX0/qKSI
	cTUuH0BJ/OfC0GspMaJPNkxLaZx7n5yfwu+vJpN29Wln2XPe1Sxqpmpyk3eCXGiabeeBqy2w210
	1VtrLPPmlJgHw2n/kIoo6tnpjSAS1YsQuH+ZAQUbkIRskb0pyXWJGXkAJ/laB8XvRVUNfu7i9Od
	0CdRYqzN+S3mEiKNEmiB8K+dM4eH2RUsxKJxj/P95+OH9jEw5SiLJ6p9ELyJBMjFOUuJdR5QXjX
	ZB9+sLJYFISEtjcZs7Zsh9T43KnQEtFXUbcUdpB3bMa6o5JYZJVMv2knUWQsm6jfNFpBBbFPUIJ
	rhNCmd77ajtT0juJii67I3O/5ckrjP2jn4SYXZOutVPHLW0C+y5mHd5m377sFn44WJc2aRGpks1
	Rjn5VeoM4KAWmuzhabMBFMsVdgmTWvk7kH
X-Received: by 2002:a05:600d:8641:20b0:4a2:10d:5e0d with SMTP id 5b1f17b1804b1-4a7c58f389cmr88355155e9.14.1793158339700;
        Tue, 27 Oct 2026 20:32:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.32.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:19 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/13] locking/selftest: Exercise hardirq return-tail preparation
Date: Wed, 28 Oct 2026 04:31:27 +0100
Message-Id: <20261028033127.82193-14-kmehltretter@gmail.com>
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

The return-tail lockdep preparation must see a live hardirq context. A zero
depth must fail. Depth one and nested contexts must pass. The ordinary
preparation helper must continue to reject a live hardirq context.

Add focused boot-time lockdep cases for those four states. Skip the final
IRQ-state transition after an expected preparation failure so that each
failure remains attributable to the preparation invariant.

Assisted-by: LLM
---
 lib/locking-selftest.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index c3d976c801bb4..7e26b757344a4 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -222,6 +222,55 @@ static void init_shared_classes(void)
 		local_irq_enable();		\
 		local_bh_enable();
 
+static void irqtail_prepare_test_enter(unsigned int nr)
+{
+	unsigned int i;
+
+	local_irq_disable();
+	for (i = 0; i < nr; i++)
+		__irq_enter_raw();
+	trace_hardirqs_on_prepare();
+}
+
+static void irqtail_prepare_test_exit(unsigned int nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++)
+		__irq_exit_raw();
+	if (debug_locks)
+		lockdep_hardirqs_on(_THIS_IP_);
+	raw_local_irq_enable();
+}
+
+static void prepare_irqtail_0(void)
+{
+	irqtail_prepare_test_enter(0);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(0);
+}
+
+static void prepare_irqtail_1(void)
+{
+	irqtail_prepare_test_enter(1);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(1);
+}
+
+static void prepare_irqtail_2(void)
+{
+	irqtail_prepare_test_enter(2);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(2);
+}
+
+static void prepare_regular_1(void)
+{
+	irqtail_prepare_test_enter(1);
+	lockdep_hardirqs_on_prepare();
+	irqtail_prepare_test_exit(1);
+}
+
 /*
  * Shortcuts for lock/unlock API variants, to keep
  * the testcases compact:
@@ -2934,6 +2983,10 @@ void locking_selftest(void)
 	DO_TESTCASE_6x2x2RW("irq read-recursion", irq_read_recursion);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #3", irq_read_recursion3);
+	DO_TESTCASE_1B("IRQ tail prepare", prepare_irqtail, 0);
+	DO_TESTCASE_1("IRQ tail prepare", prepare_irqtail, 1);
+	DO_TESTCASE_1("IRQ tail prepare", prepare_irqtail, 2);
+	DO_TESTCASE_1B("regular IRQ prepare", prepare_regular, 1);
 
 	ww_tests();
 
-- 
2.39.5 (Apple Git-154)

