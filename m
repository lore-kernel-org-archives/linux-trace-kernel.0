Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646247;
	b=fZouUFS1Rz5rMDyXeYaEWq/hoysmLFXzMGmyA4vJbaFMJGlNMCPqGz+jeA/zeZ11Gp9+
	 Nc0dHHXBwBwSYTLuhnM+do+0TastNjLBqRib2gEiTiun/lHXLfR8gF92THzTyI7FT6bcB
	 ZarQNsOq4lWTiqyDblCmB0f0MMmMazichdnHhwhhCGT8W1NSde6mA7o4JgTlToF9PFMrG
	 LAdJVFszCV0NOX0IiUu1bceW8FJlzN+71L7SsFRgdccUaWJGfERJ0Gqomi36KUC4xDR+T
	 PJ+rnP26cMHpk/mxVQDKkHD6Tas5YYnhP1chegOXdx/LkgB7Gc7eGy3/6rsKg/OMj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OcKo2jdE/+qreu4/thhFC1vb4R1orDdFtElaGu2Tq3o=;
	b=1XJP0Xt9fSVM14sFvp09ah4y3eqZfD6BOm/lGR7Dh2wou76bJyQq8yqMiCP7+iP1Wl9u
	 b6xbLG5GLCKe2mRADExQKZfs2zPNnzH44256uAViHAnC8IylPMZHKGEBjMw0gCBA5Pl2q
	 D/79HDbBxKg5o7NyIr20wvxgWwJuCY0gp7ocLieApR78C2PHu4OyCpGeGAdfMCEsZSiHH
	 h5AM3RcMew/ilUiZIoe07agxIn/Atj+cmaZ8Hu1gq6P7e6gCFL0qx1Utg+KZ+uwWwA0P8
	 n5fVfP+kKu+puKy0lbd3X8H577DyzuVL0PZ9WehvKzkazn2lOigS8HcnKikK6FLgCpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LqkWBcSc;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3460A2606
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A3460A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LqkWBcSc
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1df146015so10968255e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646245; x=1793251045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcKo2jdE/+qreu4/thhFC1vb4R1orDdFtElaGu2Tq3o=;
        b=LqkWBcScPpks/4WfMW3Pd7NIY0qc2VVqJZxuI23Sxdqcvct8QTowqDeNQwpvDAMz0h
         eQGDp45mamYyDt+QdYyimZG0l+6wjwZWocX64RLTbkrALUJIkvv4bLa21W/k5rJW4qTo
         2lDbVMzpLf+gRcvw7Iw6NkhDUaquxhX6dcjJrUdX6e3XYWdqqjF+PAW77EUj3qzZBowx
         +U7vr3uSOjkNS2k2URv6C64Zy2UzfOqLLwDah8oseX5M/rKrTZRV4rsaIBV65/8gol64
         D44ejnTi7pe7aYQkkfL+P3W+dP1ECSUum0vK8dbQHOSHPku7HP9/RGGWpbMTq4ETL2EE
         LKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646245; x=1793251045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcKo2jdE/+qreu4/thhFC1vb4R1orDdFtElaGu2Tq3o=;
        b=gxaYHZTwf/izgroLv3TwLtkbTXFYrNWk241jXQmG//Ins8G4gmzBz8syOQJ3nn0aJ3
         sq2YluT1A8mLU1sOpw3maukB27WNmJb6osaDTIpjK4kXYwPKg9/yh71TBhSjvu4q7/7X
         vaFCJqtOqOI/s3E4zCqUh7Iggp2O/NfuDm8+eRjVsZc7i3tKgPfs/K04ciItTPc0rW/9
         2KoWJnJChNb9lsZm++VFBs/goxDdAkdumJpxLCHU2U4v9/ZwBqLZ8bDJKZcKAMgKCHn7
         oVKYPFpIP6DVF+GxfL9uTX1/vedvuUapBhfQL12ByrCAn5hTr+NpIVq4eqVQ80KV9Tz2
         XA5g==
X-Forwarded-Encrypted: i=1; AKwUvBxKZuG0ZtdYRGSsDxeAX9FnkVNR5ji1PyjoCZzDyUF9i28wn0N9n9USExdzdW4Cg9K7FI31ihO5rxsE+YcbIhJeshI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9h2Kw52xMFwxeEUOyHfB2g8iXAMknxpizLsYW9IVF/yXXOvB3
	mSvWq6KTrdkwt8wQB0PXZvu+SEtmrp0TXOZM5t36SUyoIvyEoErFeKRX
X-Gm-Gg: AYBFou2Sr1DbsnkGl+wJFYH8Zyh0PT879qbbCv9tdqUVIUq8HiBXyBqCk0ZKJdnLG+k
	UXFSLXbiZgWKa9xWwA0B4/vhvWOQW0CJ9WH/Id0Hmtfxgpd0v1UPDxaB9rZB1+Sc9TeWYZwuue+
	znUVh0V0aSKSQnf5oIK/6sE+qn6+cf366mSkt4+9nlr1q9ZKXrHScx+0I34njQ73hhTQlW3Occ5
	w8S3YUjPhGLu+Ru+AzBLBsbCkCQ6+YhjG4Ye7Q+82SWScYzVV1e9NiPcMZCbSM/du4PmM50c0oV
	7i3hOsUghd+ozJzJeym+6RPgzjnD3RWYqqUR4SMqIr0lqRu9UM8K/ywLnwbYR9EwIqVbM0H/V3n
	rhixBzyOPRmjrGNXV8I+fSE80vh+0ZGRkKsIjEPfcaS+GWyuOhcowEilNmaQ7GxP3ccsk19fWwh
	nzOTN+XLum0XGZoPpJtkz3YheA5TYEUwL0Pm6JreaQpA+nq+yBpO+oyd3670lEMFs7h1Q6q3qXE
	+I/goBy8YX7tpXfDMG0TH0VjLElrXMmJUkj6UKu8iGzroynCnkNGO710mvfWzExqo7wkljzzfsd
	QTOsdMICWiVc6JMRCvKVq4YZrf2sD9foqc8vhXfi+iVItz/9WUhzJ4lGczqtpR8ZWI3fh2Bmt0V
	24XUIOcI5ImYFZKrlj03fDX0NFo+QqXwLb4mmDzJJN8R1zB+gH8UqYsas83E=
X-Received: by 2002:a05:600c:4f50:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4a1fdb079ebmr98097255e9.10.1792646245241;
        Wed, 21 Oct 2026 22:17:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:24 -0700 (PDT)
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
Subject: [RFC PATCH 04/12] entry: Skip inactive IRQ-return reschedule calls
Date: Thu, 22 Oct 2026 07:16:46 +0200
Message-Id: <20261022051654.79224-5-kmehltretter@gmail.com>
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

irqentry_exit_to_kernel_mode_preempt() calls the dynamic reschedule helper
when preemption is enabled even if the preempt count is nonzero. The helper
returns immediately, but its call and return remain traceable after hardirq
context has been removed.

Check the preempt count in the inline caller and avoid the inactive call.
Keep the existing check in the helper for its other callers. This does not
change whether IRQ return schedules.

Assisted-by: LLM
---
 include/linux/irq-entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 3ee80e926a17a..24c2b9fdff4f4 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -487,7 +487,7 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
 	if (regs_irqs_disabled(regs) || state.exit_rcu)
 		return;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
+	if (IS_ENABLED(CONFIG_PREEMPTION) && !preempt_count())
 		irqentry_exit_cond_resched();
 }
 
-- 
2.39.5 (Apple Git-154)

