Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815685;
	b=x3iqKpbgvXQAN8LYRj5DGGcwocN9AMutEiDPgkJuevvRamb1ahGRJIdAqHgHFuuTE8Ay
	 NABPe/3JHz0nSWsRfplxGVCxkRz8h4IoqEZO2iStTsixf6Npfdi0t7U+4lLURx4/XRpyo
	 yUH+cTxYE8MK3R1SMcHzSKrINqvXONxETw5FLkxZdImmxD3IZ2YY8+sIwqxxx05hinjSp
	 QDiiWEqTAbl7t9Y5O4HsI8RjSnEvb/NX+2B49biSISi7hS75wCCQCR3ocqKk7W+UgoOy5
	 8EsJ92th9aHgQngPSjg0OfPRPEtA1r02hs0omnGWVPvSY+KvkFOhdzbil5amJTA5vUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wJhyoVPyEIrD5yY2pde0MNrXE6PDsUwt9Ka8QuL+Adc=;
	b=fQQKsrK8rAt1G0jpLliKA6OrjJPAl+3iriMqPL6abUaAb32U6K5SgOQ1ZmEKyv/vAPVO
	 ZwAkF2nDKst0MWIoNhfr1YN5o3f2XLFT9nLjh0zGEC56GQJMSE6iXzz8XtuW0LIx0SDj/
	 6RMcerZZtxGpF0nMpRE9daw8rgQAk1DAeFqNN3hSpxyL4tG3sTKh7STCloTTIP/7KfNhJ
	 /RHnKYDXYlnb1Y4DiGpglWfUyhD2gRCszyQdX5vwzBugVlXXVXzas7oi4HmzuphWlDGCS
	 VQV/yxXqfwy3VMwbBD3DaHNdjPBE9uuuawQm3ARFtrc4qV8ui24ZO25xzKiBAazyFRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhQUqA5t;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16334606A331
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 07:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16334606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhQUqA5t
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so38864515e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 23:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794815683; x=1795420483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJhyoVPyEIrD5yY2pde0MNrXE6PDsUwt9Ka8QuL+Adc=;
        b=lhQUqA5tQxQyzdAeDP0B7IISnBLRD6tyu9/mhI4hP9HrceXSEkJxjHy0rFBtYK92KP
         ww+JIfzB9y9fTwlYgoxLMV6aCfUuf803kp0Wb7BuiJNjsugc6rgrDeTQPc8Ot/McY8Uh
         CthJEKswOASfsQojc2vA8sQQwbtE9k/FzVXJFpjsMeggFXWymyQkWRTGJ3jK/OR4WvBM
         jMpzSxyKl4fQBO9C/w7xFHjUETY0v41ewe+WSrGTmhjisZxsPh/z/ISrsoRbdb6KYDTW
         YVbIFrLAw0wvRLxIEcGqYdHs7FAV84jcRZkZR1aeR7Dud4q1J7M8Db2gslNLntI2wvuo
         mjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815683; x=1795420483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wJhyoVPyEIrD5yY2pde0MNrXE6PDsUwt9Ka8QuL+Adc=;
        b=Ern4f+VGnSH+nNZDM+f9xQskF4MZL4MaVjDB+CLqPlMOJuqUehUXUThbSUXkm8gdd8
         kT+OxFvcINkQeiAKwxnNuxSywjLueGSY40NbFDIPJQ3Kvo9UwEsHpmW0/pxAx4X8TtTU
         uX8Nzb868Kxg7MsFhvWVKEmyWRAfG25NxH21g/d4V0cRLhoRvBWBpjcPefdVWVuMnryt
         YWNzQq5HNH4rpBjkQxupqTB5/edSRl59ZnU4HYOH5iPG72tVkfUPF1aZ4XImsIMYhkyE
         l93nKnScxN/qctJBRJHe2m+kdN0h4pfTAmqpg2W4OYmf3ldi/linFgz1LsbE7vGvjK9e
         pH5g==
X-Forwarded-Encrypted: i=1; AL+hErF+0Mr1b0rZ2y6DdGDKnok8rCMohTenj+P6YTbwXhZXAmCpLrd1cfmXKX3ZAfHgtkQU1WbB/3d770ZHTQdx/3qn/dI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZFrGwVUbZdmvM34OF6bud/3fKAvoxwSKh9l8/pSF+kiJISnrX
	FYkbJmi5AXeazYMGGYfWAedFEzmPYR7s1l6c86lTf3bFPbw97U4Nk/dB
X-Gm-Gg: AYBFou1nf0pIeejsqGR+qXoTStQ15NAo+1t8dPyilnIfO653RJvpb2/kzatNoFzBs5q
	sVmTx1nDofExrFwLHNd+0tGYR1lBaQ/AejRRuAtpDrcyyyTNbKB/ttlSg0GyzIIVbQhelLnodHS
	fqEyL+8zYpGqJQxk+9fcCsHF1I3ymUXnjDrC0ZtxCee/+vqyt1txC6Q+NKqCPKPHu9X5ezs6tCs
	JJxfIcvmXMWDOI521jlP6a3cLnmz7xkVr2SVaRxR2NUW2+nx8+uEViIfbb6VGtOXo/2jlCrOR2Y
	Lw7SJU0YduPMRlt9Kl9KnjFli8HFojd7VIsMSd2ifO1mEtRVmRJouCPz7ccng3vI/bhnCG6w/tV
	wy8/RoMrJ0wqnjrzye/FTBvfiRfz+4+4RouH7HtCtpUBGZIpFBkCuX6CWNlbRz2Hacb8DPPUrT4
	TA5MZHRMtpK5rp4mLaIooMBhbMpQ1vvK5GIZWO5dGv5W1oulnsa42upBbvHAIDuzabmHTFD1Y3m
	X+Il0vSO3QaZgeRAA5mSah5lfCXEggfIN/C+wG6VRyEtszMGx0Z7n11CMdcFtHg36EtDmW7qXG6
	Iww735/MA7ED+asWNZhGIXcnGNkim8n+i7g+JLxkd8HhyBu6uFcI1uoQUYoUCWV45Oxu/6WZJmo
	ifqCxDqBgytcg6sQcLNpgJ8A7+qbAJkIYd9HAPkcGDK9aOkmJey6vq96haBUPQ0D6MZs/vU2S7w
	X1I8QQNUs=
X-Received: by 2002:a05:600c:8b23:b0:4bb:6f6a:1976 with SMTP id 5b1f17b1804b1-4bb6f6a1e5amr67223255e9.2.1794815683432;
        Sun, 15 Nov 2026 23:54:43 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-148-032.95.117.pool.telefonica.de. [95.117.148.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5ba25b50sm210329875e9.14.2026.11.15.23.54.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:54:43 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Hongyan Xia <hongyan.xia@transsion.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 1/3] arm64: Always inline raw preempt count updates
Date: Mon, 16 Nov 2026 08:54:22 +0100
Message-Id: <23dc25d010cfeb8eddde12be5212fd73bf1cd5c4.1794814699.git.kmehltretter@gmail.com>
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

From: Hongyan Xia <hongyan.xia@transsion.com>

Raw preempt count updates can be emitted out of line by the compiler.
For a noinstr caller, that puts the update in ordinary instrumentable
text. Force __preempt_count_add() and __preempt_count_sub() inline so
their code stays in the caller's section.

Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
[kmehltretter: split out the arm64 preempt.h hunk and rewrite the changelog]
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/include/asm/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 75a592b7f47f7..f3a5c2cd1936d 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -41,14 +41,14 @@ static inline bool test_preempt_need_resched(void)
 	return !current_thread_info()->preempt.need_resched;
 }
 
-static inline void __preempt_count_add(int val)
+static __always_inline void __preempt_count_add(int val)
 {
 	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
 	pc += val;
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
-static inline void __preempt_count_sub(int val)
+static __always_inline void __preempt_count_sub(int val)
 {
 	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
 	pc -= val;
