Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158306;
	b=Tu08bC3iUN8Uajf/8XZlRKMW4gHasEVP0H8/G0uDJXlvNb3/PrMmBtb4pVIbSiIZzBhW
	 5EnCaH2L7TaapT3+8OYRbQGBCzbAZA0mkDaNUMTlGXmqj9bekT1rsQMhysJjIMyDlszGr
	 tCmlCyssF9giWPHYidvXspt3igafSlzH/Jj71jsc52pyYbifL+uJ+VmR4jd+uESOyE56c
	 PYZsbceL6I/7JGyeNJy4I5yi74jV0COiw9ww1Fg64I0FJ7NSsYI1MW0BAZ81ggu92EtOY
	 uPJF/waf+XGADO/S3VutCGFZqSsCL7so4BVEalb6g6aUp7FrCoxR8dQq+6lWUeqVE/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MfmoCWntxjvUsJ5jQdE0fli1C/EPjSIgsdskzAxULLU=;
	b=EY6frrArUCdorVWuhQmHIihd8iSC//e7jgUJVXvvzU6wJd0FTNCO6+xZWiyd8d/5Wb4h
	 SBZUiLZ8NVVB0y5yoZr9B0OfR8Tbz9/RhdOk5AadDeto3ut0jQqqtsCeL3CJ/P3evxtea
	 aWqkcch8gND8b7OeV5QHwrRj9DlXroPnkoYbiPHq+2eUTnnEoen4xO9Yhfb6FsjgJzfM8
	 W1nv0tS85xDnwK4Z3QYGL1y4tzuNgoRCEVElVCKSWpv9iIBfZcu6tA0bhlfNTNs8JrQh2
	 K/YWOGwHWAPjJ7BCjUH/7BDAbVmCIbNS2OMTDcsLYdeDlxD+qlhyKqyejF8TmiwK27w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ism9fz3i;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8F606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73E8F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ism9fz3i
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso4901235e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158304; x=1793763104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MfmoCWntxjvUsJ5jQdE0fli1C/EPjSIgsdskzAxULLU=;
        b=ism9fz3iddL8+FiO9jcwvJueqXy51UdSpEHoZ+RaRyPHfAv6q7SnK61TCZBa9qIT6f
         L+fzMna4qndMiioKJV4ZVWatZmEhyXc2+EmhNQHW3l6vP/I7Wo9zSf0STFjilhh9tWCi
         eLLdlj19UpxqCfQ4ax6CfVTaHnOyFzN0xnAApBKB9pf/kWmKiAmODe2Kww12drjmPg9K
         4oruhUAJoSw/kKC6em2VdQKVmH1fStmxgJzGO6JIXxsXov3UIGgyk+k9iwdLIWCDmWwB
         c43UjWt5W8pH1LCgxlOHt/79KuWbGnpbd5vUpJlXlpwdBi7Wg8jk8P4xabHqYZWdm4NX
         n9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158304; x=1793763104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MfmoCWntxjvUsJ5jQdE0fli1C/EPjSIgsdskzAxULLU=;
        b=GbIQ3kMu25OgPHK3H0OnagRjrzsGSAS963OR9ySmRibgjFPKV0PJmceWNBccPqbNJU
         ORLdXdRm5LZ9rDG5tUJgZh32WeGGAOtPQWssFlt4PJqh+yeinvDppleUkI4dvZEyVcTb
         KALdH/T+UATHdQlMEOFgiwgwRvcCRYCLu/ac6k7JR4PIRgxitnha5hSrtYSJmfQWg2B1
         X6+Uzj1ksHy3LflsjHZkBMb+N2KAL97lhhVUF3LbGVk8NVnlNmTXG2A2rJJ3BZXwL5oc
         A0suUtc1dgQ+nHkscTqdW90ffbLNy03joTs90Bw4YXcXxFww6ozl8LykpZokgFK/HsA3
         E6gA==
X-Forwarded-Encrypted: i=1; AKwUvBws7y4u8bSUe9hZp+RJ4VaNEHCmo7mOGIuPrIqeAkR665mpiHcEDlDwbhjtWZPrrP1qT+eBB8nslPRzo+DM0LpSqRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzMJGXr8d0e98IhRR9tbjJWPJaK9tYWOHqrmJukocSHjgQEfLq
	IDkDZwRVAQdkJXjeYHz5NBN54Mjg0Xesdk04uYcrKzIbI17jxIpEC+3U
X-Gm-Gg: AYBFou24DTopuE78qEezXvI1JpYBSCTVAx1LQDyJs9luHCWZeBg6ncoqSN8PnJZ2Unr
	y3tJ7Xabt55i/6oLUDna+3BbNY52vr+W9DAWF11lGFob+z8EeaSdDtgOtxOWCbv4gweqngqPPZU
	/MCWRQlP/kBXr4fNsS6W3hQPXxvsf3eAUp/WW5E3ph+S2p+ojIhqsnIbBApvbMukovKSvilfVpF
	8Bn8O3Ry3wvm3ULujEllFy+tDYBu+s8ahhPmrFtGXo40Za8IsOi3SRof+BNAvpnDqMdEofkX6zq
	LbFvk31rQmoFitovKYJQ8pd7Cs7bKQPGKiMe0P9xtkoRw/CpNKSulTLE39OFYJyvgoHm09Wx8Kh
	XdjvIi6hcCjMA3GsTiWYZ5ru/7Z1krIC3PbkwhIjSWIwS77WgkqefaIiy/nvkohLz0HsuiwJgVR
	ltIPfYjgl8FNG5VgjKKzmX3tnsgoLRripDEIlVPxHyljlXpUmpICk95MzFYZ/Bwur5GSJ1iAlU/
	tX9PYBE1J87xEFbxpzKZLrW94YyrbwzNihT5AXzsEx/bMTkgZJPUtmE1BlA+y0FHlNAGUuyc37k
	feyybtmdrgYHfWpaYvMJA5xz3vJAG3CfKNEdxMHuaXxaM0l5co+ywi1afqnoeaq24IBVn6YVgyK
	h4fK/6WZPno+a4f0sFYflh5V2VvpvhPvdJxBDlc9G+JLq/6Ma2nPFv0r8Won0MUanXk7+tDZmKK
	Nild3cH0fvjvgRSpjC/vRHv0Wqzj0nQpHk
X-Received: by 2002:a05:600c:6206:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4a967e8c07cmr16606825e9.34.1793158303715;
        Tue, 27 Oct 2026 20:31:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:42 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Hongyan Xia <hongyan.xia@transsion.com>,
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
Subject: [RFC PATCH v2 01/13] arm64: Always inline raw preempt count updates
Date: Wed, 28 Oct 2026 04:31:15 +0100
Message-Id: <20261028033127.82193-2-kmehltretter@gmail.com>
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

From: Hongyan Xia <hongyan.xia@transsion.com>

Clang can outline the raw preempt count helpers from noinstr callers into
ordinary instrumentable text. Force the add and subtract operations inline
so entry code performs the count update in its own noinstr section.

This is the preempt-count hunk from Hongyan Xia's pending Kprobe noinstr
RFC. Keep it as a separate prerequisite so the early-hardirq work neither
hides nor claims that fix.

Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
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
-- 
2.39.5 (Apple Git-154)
