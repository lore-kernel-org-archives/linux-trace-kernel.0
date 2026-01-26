Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B7332900
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424289; cv=none; b=tXpAK5xaAlfjcjMyg79L3ORlXEQ8jcKAMetSC2S0qSboJBRXxGNfSg83W9kCP/gT4+q3M/2TjhLCxejr/nNrkofrCezYjFVx00EolTNE+v5j1rsj6/Qi1oUS3U4h7hs1YDMGJiO93S0MDsRUkePO27b4KepB7J3mWyf5Samvr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424289; c=relaxed/simple;
	bh=oo4/5f4YHfSVUMNCfUHjyArRgPM9xVrZtPhrVV+hXu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OaWBhXSY1E+yQqusB3fADYz2qe5Lm8uNKp74M2Ju2E0e2m34C7ApOG9G4uHwiIUSGFCRxHSpbcUuYx5lnp7LnTEZ3uaYdsFgQjsB5nazs0B09WKy1brkYAHI8MRqmyFHy/ORcRRpLA7FOQxce+i+BqDn76myRAmTM6NYalJuAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjtvoSJ/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjtvoSJ/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso32359755e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424286; x=1770029086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHa7j/CKtQd71sr9sGVN3KtiKJalnxGKPFOliEGiPCE=;
        b=cjtvoSJ/nFEwArZRawlnObOcK92nt7gfofnieIgV0/wAGwXTAeZXCy2JwBO+0IDYGO
         ag3vsaIiuE4Jt0QjDErbGdcOg9wJMHUnYnA5LM1MwUeN/l/F3M1OsNU8abaNBsUpwTrs
         6iUFrLgHJ8QaxbNbiLXrDBb0EVbtvyK/+3q2ucpMLysYjF2ihFGzbPe8HX0n6+6ed5f0
         DmwVgIoDDTb/iWmgXXcqIDLnQ2tvJPM7YZGVgag5mYex6yxKG0n/YoUwlB/BLDgen58o
         AfIuxA/mx38YKLD+X5Q5z75CiNKiCEMIjfGMxe5ZUhq4QSS8Q6pzBooiP0nhase1D6aD
         WXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424286; x=1770029086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHa7j/CKtQd71sr9sGVN3KtiKJalnxGKPFOliEGiPCE=;
        b=f0Smf6gf05bGJFogVSLbu8Jy56EQUBJPH1xFbOsDZu50KViDM1fL6kN0i647Y0qWBV
         Hbpn5e1LxARSxJQ1K5Ols/HyPsGh+srkmArAoOBLWfXxalz1TWXGHXcZBV6K7O6MBMIw
         yxlpxIZfSgwEP7k3lwVC7n/tqJD8blhS6/TLQe3eFI5lVhBc2o9NBEqUrCBOa/9Gboci
         d4ALjM/UsDsxBuZqGnkJoaDztQU1jpTf41eJox9vMVm8Tv+29dJ5JgHBLq7N1JK00Rq1
         p5pBYOf5vWUhZ2rGJ0toNmEqObbb3z13JizHPXTmoO/R4X4nsY30klgvUUro09eWzboa
         vThg==
X-Forwarded-Encrypted: i=1; AJvYcCV3dAQ4TI2e+3ohQ6TP/dzOCqFGR1g4ldMbOaJTH2C1Ym9h928h1prrW63Qv5pTEYhlF7qLnUoU0wF5KO6wn/nq1NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvJ4CFDjqBR5rDsyUyhsP58evYfJWKp9pD29ygIEMEFDI3QnQ
	+ZIwclCGeYJ/Z3kRBlKNuh+TzuipLy2zpMHbEO6DMaUF1j0DqEOuAGwFKo6cVUJUhQd9MlAn+AH
	ILQ8AewRwOrg70UPvIsl0yw==
X-Received: from wmpx5.prod.google.com ([2002:a05:600c:1885:b0:480:4a03:7b7f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8a1a:20b0:480:4a4f:c36f with SMTP id 5b1f17b1804b1-4805e6f7fddmr42640155e9.21.1769424286085;
 Mon, 26 Jan 2026 02:44:46 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:11 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-23-vdonnefort@google.com>
Subject: [PATCH v10 22/30] KVM: arm64: Support unaligned fixmap in the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Return the fixmap VA with the page offset, instead of the page base
address. This allows to use hyp_fixmap_map() seamlessly regardless of
the address alignment. While at it, do the same for hyp_fixblock_map().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index ae8391baebc3..a6eafd72f87c 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -244,7 +244,7 @@ static void *fixmap_map_slot(struct hyp_fixmap_slot *slot, phys_addr_t phys)
 
 void *hyp_fixmap_map(phys_addr_t phys)
 {
-	return fixmap_map_slot(this_cpu_ptr(&fixmap_slots), phys);
+	return fixmap_map_slot(this_cpu_ptr(&fixmap_slots), phys) + offset_in_page(phys);
 }
 
 static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
@@ -366,7 +366,7 @@ void *hyp_fixblock_map(phys_addr_t phys, size_t *size)
 #ifdef HAS_FIXBLOCK
 	*size = PMD_SIZE;
 	hyp_spin_lock(&hyp_fixblock_lock);
-	return fixmap_map_slot(&hyp_fixblock_slot, phys);
+	return fixmap_map_slot(&hyp_fixblock_slot, phys) + offset_in_page(phys);
 #else
 	*size = PAGE_SIZE;
 	return hyp_fixmap_map(phys);
-- 
2.52.0.457.g6b5491de43-goog

