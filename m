Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660271;
	b=SXCOKQZZSSsV99xCn2cR4gKfU+OskTpZIhlgJZHB/2h5aPYYNvFqxJFuXjasSICul5eC
	 Il0n4FIxZS3lHQQkFtUJmkibMlHaCmkSQ+VryXmpKVP6M+X38jNxiRu4KucNuHEYaMhpj
	 QVR1baXPfrGfzJIi2RPYL3zKcB6QdZ1mARhusmEcp2UzF7iPHTdf0iP82DKGYLKgeM+QI
	 aNu2pOKgtu2B1QjF3En3YgMEkTsx7uz3Efg+KAo5DkQhnKqLH1J3EGqtEBfJb4dY9UlnX
	 dyg+T2tpI+Uixxw6oyErZqLkq1fzzJXx5JPUwBH1HEJlBNOd1ziZndsYNxMPOW4s6Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yN5H3rKOI/8+8/yT1waYVkwONxbU+zHepwtMaoJjEe4=;
	b=RrA/+mKrztv/mLdjzL1IkoMkEnHc8vcNsJNfbrPLCQJuvw1EiBYAR/0XShuvtdn0OyXq
	 Y4STkxTT+z3JwWzlIZIGBVlL5iX+S8+w+JnunNBFhkyfKpiBbbrA38/QmIzeklcnUKyWL
	 uTkoj3qpL1uXlTTFn2+v1WXSh0cx/7QTJR7aLfiKSTw7pXbwRBYgNKiktLW728bM2MNx7
	 uW5fDWzTIk8Oz5RNtst3qcpDS4VPpiSwgp1Pkd48gXzrQT93MdVsoXKWsGv68fkWMfO92
	 ecoSxFouvyXntgER5D1dGr8TSXS119khFfl4mTqcffc4kH50eAwzQQzqq4xsnuAR9Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sp3vYyEe;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F1606A69E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 02:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD0F1606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sp3vYyEe
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so36091935e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 18:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795660269; x=1796265069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yN5H3rKOI/8+8/yT1waYVkwONxbU+zHepwtMaoJjEe4=;
        b=sp3vYyEeIzdhmt/2NwQA8bgBqIVHI+phLfbI6wKT3iWAoTwwuGZz1IyO9rmEYDKgXw
         I4QCJbHNji4RjTk7q06rodTVNRoqedu9oQrRkq5daFrrrw7a7PQlDqWs00HiZQYNMS4Y
         fs78czPKWoQMClgGKDBbFbAkuGR0j+9RKAlD3QSLHs4+BQfdNZ6mJ2fVQsIsCPg6wvw6
         EnaKCnfz9c+hOozBpB4XIeN/K9Kyy7hmD2Zq81JRc17dVxuzR0A17Sn6HBg+r1kRpPI4
         ePd758R9egnFXEGuqqzpBAVgUJyQXRCbSW21psTFLMoXDtSq+CWlDISk1Mjvxq5YnxnQ
         ra2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660269; x=1796265069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yN5H3rKOI/8+8/yT1waYVkwONxbU+zHepwtMaoJjEe4=;
        b=HQ+WJZnEM+3eoOjCvMXfynOhRIZnBPQH573UHMQJAdtOg4nsRYtkdg553CRI5cffuA
         CQY8slNV/GLUMHrEIwnq3YEil0aeOI9iMvqtD+0fm0BfzIG5LlKfj9HN4KlkVBLHXdzh
         8s57ZMAonHv4qVqiXa/a2Lz5y7RIqECBiV7/F2/PwEx8O7YX8vfPD9655CQPu2XsALnA
         ozXwf/EBgBhtgXqnCuv1Nw52EENTUKA2TYwCrSj824XRpZvNZ7JGvwSRnopqQkOIYIxD
         +oe4J+WrsCg4GDdudb068TmV43Kf+tgzHAjE84cMmtOeWwtEb2oeSV6FQHsuiEJH63BZ
         o8iQ==
X-Forwarded-Encrypted: i=1; AL+hErFiTWy2geknQhBKRmy4xLKnb4mgWzAvd3BxKRCAqY2rvhVhosojkbbl+TV+KeB1BE1Hvqw4kCXiEtpfHL1ELdblxQg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9otFVEYM9uBaPAH0CFWOUx9VRlF8z443CK9ureKTdrUAzTlu46
	f35iab3JDtnmHWXIjEsszadEk9VsJuKVODL+v7NTzxaUmyqpBXwperAFJmOe2Khi
X-Gm-Gg: AZFdTZfSoTehXTx5NNBm4DSyVUvTWAC/y55oJpev4yyUeVqpNvhdKa93vA6pBP0z3AO
	ve6oONVN19fpju1OpnATtYcnDU37as7Q/5kbFWStYRVfUixWRjs2+4n/ghhooB/VBhEYb/iYdMF
	oAyPVmYgwW1riiV43vGrITblzyzxjW4ulk9/gNF/K44XguKTfRQEELhTMJtKDolIrCAjS4XyEfe
	2HL+OmUHT9b2YwTTY8ZX0j53BKjAo7+08wsBPGr1phGuXmpyxsxr650nylz99YNThKort9WP8pX
	ym4Dw8F0Uei59o3tcGY3gtA1TzrmMkzojVnv1hG+Hu/fTKB4zYZ9KEnzMIYkkDHA6/pOcA2sXVK
	Im6rD4rSoqzLW4mFSNwG5iQlPKFR+eFgC428OxhYW0J01brgabW7JlByJv8sNSCKrKUH8/myrCM
	H/i8ZUd/aOEEMaLjYT2HDrFZVEnwotmQRa45ezB5ndM7/2zZS1uFEnHPf9KVPLCAZf3S4blBmW8
	ZwZNf1JXOqXxqwItWI7pJf0UFaEysxw6sG0fXsVGUzIZHteUsNPBOgGvIQ3yxCuNRpmhlK+nehn
	Cpo/jb8P3DvWr/yw/1uExKWQVCOLxvAUteJB54DUmPFlJi27Dc6+PXYqGxa6jgGD4i6hvvIRAI0
	6NBnd3bTa4BmzJ1WhbFTktZ1AlHOgSzebCV7l26zn23XAsciugFXYJrloQnSt7ZKNGhLpcc/6w5
	3oVkxp6hG5676OystbFwCCGvZzLkbqSqOcen7VQg==
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6118:4c9a with SMTP id 5b1f17b1804b1-4bb88819940mr456668815e9.30.1795660269096;
        Wed, 25 Nov 2026 18:31:09 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b10e-d501-d0c4-b021-8d77-e472.310.pool.telefonica.de. [2a02:3100:b10e:d501:d0c4:b021:8d77:e472])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm37722445f8f.20.2026.11.25.18.31.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 18:31:08 -0800 (PST)
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
Subject: [PATCH v2 2/3] arm64: Always inline preempt count and reschedule checks
Date: Thu, 26 Nov 2026 03:30:53 +0100
Message-Id: <9546998cffeaf365f8f67901a48ef103945dc342.1795631277.git.kmehltretter@gmail.com>
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

The preempt count and reschedule checks are plain inline functions,
which permits out-of-line copies in instrumentable text. The checked
notrace helpers added by the following patch use preempt_count(), while
preempt_enable_notrace() uses should_resched() with
CONFIG_DEBUG_PREEMPT and __preempt_count_dec_and_test() without it.

Force all three operations inline so noinstr callers keep them in their
own section.

Reviewed-by: Hongyan Xia <hongyan.xia@transsion.com>
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/include/asm/preempt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index f3a5c2cd193..805f7b33baf 100644
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
-- 
2.39.5 (Apple Git-154)

