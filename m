Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815686;
	b=SLwZLJZGgNs9T3FKRD5iGN3ccHDkdf6ra48gXedd+darOLmsJard50DN7V0ile50AJCj
	 mpKhJNS+JIliF2sMBfq4eGE2dl3Qt9AZWbpUAvnoS+8BJ4pCY/pJseeO5Lg6ctunLkZdt
	 V8PCXT6cVovmhQtYoovOkk7TfC4So3J+3SvOeovOmRfewwhNqrv6nttMsXX89RJ2Rislw
	 zFW6TF9AaC5+5JcbpX2oDoXuIMABjmSawKj2TC7MalkrjS83/5TJP1rgnyJun/7z9AO6Q
	 z743+fBu3f2nu4BDgQDsAuJhcIZ+BVCVX7U/hsVS/Vj6Pwx/o/91Zd2JxaTQ1tzI90g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iUzaZQp5S4tbvRPCNxK/bmUolbaZVx4k2EZhZDo+zsg=;
	b=rAslK5frRIewx+O/yhz1EUIeN746x1CTNxVsv1IMQyhIQcRhrKdRkXxoghDzZ+vuPuBp
	 XUjB1hd1VtC6aeGmbRz5eNVYLnW/NHZn6mLLANxol5Ip2vv0zhV/ogdnqpwQMsd2S9KRI
	 q/T9IZWCg0o6UB1xR9AoXJH61uTY9zR+1ANBP6q/uIC3NvpI7KupCdPrAQfof0+eb8LMG
	 Ik/KKG3V1qPib9VBCkYedvkIIlgWXYfPwopBsFs7mvxkD+eS32zhZtjsDSkc0S+7hlC3A
	 hfM/C8HdJjOPPGgor6nqv9YRPiyiYn1LbQ4gRl95rCZLBXRD2ScHEC2TTqnMbXpio6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zgj9aZ31;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C97606A886
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 07:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C97606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zgj9aZ31
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso17756835e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 23:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794815685; x=1795420485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUzaZQp5S4tbvRPCNxK/bmUolbaZVx4k2EZhZDo+zsg=;
        b=Zgj9aZ31u8m3FzsGEhEs7KO15dsARdwE1Gkc6+g5hd460kl94T88hNK4FMOkxBUB3J
         V3pRBbkdWaNZvU5EzTndqpK2kgdqj5O85mjsYGd/zFwWD8aR0YRNFy129Yrd0meN3TW0
         Rbfr1YpuiRjEYmfQ1oRxsg7YTZ1R1j2L7lE50MB6uGa3eu/CrhnVHTq/FPeUqKg/lbwJ
         1/Pkmh3CjCqDun2aCVECmyaPf3HgLsKGiUR1WlKFSzyDA2FnHDrCafkka+rQVBjXtDK2
         NOsqxyKdCIP0JQvz4xJhzI1wOfEBPZg0LozZuokQ/+GHuLGsXRdcBpV3g3WgDpOtShX0
         wO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815685; x=1795420485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iUzaZQp5S4tbvRPCNxK/bmUolbaZVx4k2EZhZDo+zsg=;
        b=CAlcyOeTonUNnVeGsST3ZhoGWx9tRVhcXrIdc/QjMIQfzURzJ8qeouMmgvfZUlmERw
         O48xJ3SmmL763chV80XhfAS1e9e7ZaC6+jQRb+MR3r0HEMCPOnV8jHbeetpZoumHbr9L
         cs6jp/AW/g9YBHo7YjLbWwdIwBYGkmvGCV1maA7IJcx5fRjnF1y5BT2OtL8BO/+SbgCq
         Ol2iaKJM510qPxeXY1RCrfLAEMjD+8+kss6VpFSd3xhFUArj4/GtCUu30ZqwovnqNVv4
         witIz0PlVojG6yWuAhey8iicTUhlN+Y1XPwtAwzx6fVTegXBsv5yNhgHXl+n/7H1FYTO
         pC9A==
X-Forwarded-Encrypted: i=1; AL+hErFrF0O7TW0dWrzpJWGmN9yzHK41vkW98tZ7oA5l9Iu0oPlytFTJh8FCqtxo7GF8O60WycJGWDrj0I2vV+7RCSK6M/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S4M1GvB+QGXNP3BLhXNKoJAYcCRazo/DT2LSPol2K/mvp79QA
	PM0ykhpjozl/Rgmltw7gqQIeKvHduo+jnqkNSCdaVQoeK2Zw92TAJ6R6
X-Gm-Gg: AYBFou23On7Ck6m8A9xWgODPT9DtKC64pfmyyTqdkrId1Cb6qsq+y4hVtAGW3oIZusw
	iZ2OAy/m3xknwBhNCcUaBnmDO0BRxN8yKh4FL0+14ETpYEhgjFnmwiT9iXOFq+LThj3xyL2J9vS
	gIQw8RFE5Wc/m1YjPQ6SDTd+g07gjLfz2ix5EVthBsGdq2wGCYjvBBL3vxqSrLdGKPGBZ5c2gGt
	08X9D8sr82uo9QGp+A+nSSzb8w6c36F+gyPQS+rAo/dul3HokEq/Ssvvl87MlrQ+v9vf1Dgo/V3
	0NMvdiwI7/IqQPbbotoVSbrakLoN3uzNw1G346tQCP4C2JrKI7PqRx1WKh5VP/zA/JPV8/C7CCq
	AGPYOZmdidaI9iuE6Z3Gzp4Qt1yfrdKRKPygtv6TQVSbm1VdEdrDAwT7md8SK+/aTFNW8UTtEAQ
	+bjiImvGED+MPju8P/pDMkA75OpJA4y/XWTpgJ8iRkLUekFcBqsyhsF/8h1niw52k3X4YYQKmrR
	o0S9pqOuo5Cg/2yuoJaNSnw4npxzD+rXQ9dIndeT0HfttLRiKHTt36u9qOTYCL3jJw6XEa1pXBv
	QQKkcoD0WapM+99ku9k2nmGwwFoH8otH9YmrSJDe6wxfubQEUnyUeCV9RaJ4s1Atz+OchaH0Bm6
	79fITJSr24uwj+h41oe2rKvo//4OXt5zEMmaBDIYenaD4iJiHfHqghrSgXPwvVyhg8HjwruAe4b
	SKkyuUkw==
X-Received: by 2002:a05:600c:4e88:b0:4bb:7033:c936 with SMTP id 5b1f17b1804b1-4bb7033cd72mr46814345e9.24.1794815684668;
        Sun, 15 Nov 2026 23:54:44 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-148-032.95.117.pool.telefonica.de. [95.117.148.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5ba25b50sm210329875e9.14.2026.11.15.23.54.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:54:44 -0800 (PST)
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
Subject: [PATCH 2/3] arm64: Always inline preempt count and reschedule checks
Date: Mon, 16 Nov 2026 08:54:23 +0100
Message-Id: <80d8bdd8995a4b31a44e65bb9347b41c5be5226c.1794814699.git.kmehltretter@gmail.com>
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

The preempt count and reschedule checks are plain inline functions,
which permits out-of-line copies in instrumentable text. The checked
notrace helpers added by the following patch use preempt_count(), while
preempt_enable_notrace() uses should_resched() with
CONFIG_DEBUG_PREEMPT and __preempt_count_dec_and_test() without it.

Force all three operations inline so noinstr callers keep them in their
own section.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/include/asm/preempt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index f3a5c2cd1936d..805f7b33baf09 100644
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
@@ -75,13 +75,13 @@ static inline int __preempt_count_sub_return(int val)
 	return pc;
 }
 
-static inline bool should_resched(int preempt_offset)
+static __always_inline bool should_resched(int preempt_offset)
 {
 	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
 	return unlikely(pc == preempt_offset);
 }
 
-static inline bool __preempt_count_dec_and_test(void)
+static __always_inline bool __preempt_count_dec_and_test(void)
 {
 	/*
 	 * We must load the combined 'preempt_count' after decrementing
