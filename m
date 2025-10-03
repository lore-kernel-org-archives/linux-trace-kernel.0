Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7B2517AC
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498760; cv=none; b=t1Mt8tqpbPud1CLghPORMT7Z6UaQUTAKKZ5jHoghHOM9bBvRvG6t1iLlHbncA4MiFTw8YzlPtfOvO4dPixiP0t/Ghzhv1eh79ABWLBX5HC7swwSUDjczGiDx/xeYTh7RaSG39Q1asMEgdc8LVTMNONa+APkeTdXVZK7DfGDUIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498760; c=relaxed/simple;
	bh=jCbG47nIr2/y0UdsIaiKkxyaIjKy+gc2r3vZExVABsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=unB/cAubGpj4oEcsYoUSqGOh8qTY3Yi6/X45tW+TrrgKjhfzSousakUvmyD7XSk7us3OPtqtaaKU8F326lAgSK0B9zhZzTJ/r3cdWO3zW2LltXAixd/t2vdLI9ieCS35z0QtmgzM8eWvXCz+ZT/CF9+eEbYvRNTcs+2+AjvttNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBGthic/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBGthic/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e5bcf38dfso22013905e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498755; x=1760103555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VsntBoZ2UX1thgOJTBqIcQGNGyw+Zp/ZR+M9plVUyY=;
        b=OBGthic/M3iI4fYRo9IiGexA+QyMqTa3fbFj77yNp5ZQV8l4XCBTj170Qx2MNlXglv
         EBVSXsZDRrUNYIyGRfIgw8kki99WfUxQWSPoJJby7IiGRsjjQnQCazgeDZ6HF62yIApF
         T1hN8jD+yJhX/JxCAP3B1jTxZ0RTwgekfg1yiBX0ZOBVDC5dETPgpOm0mArh//NwwTBR
         ipUgsCpFBzamthzhjSp8bbvR2Har4wR5Z6e4vfDShbv9LrrgVHqCVGlNFmjuPPA1HsqF
         vQ+z8FMtbTDEG+uLj+hnNLWTZpRVpNVnaoOAYARFv1LC4fo7UFqjzun619Sn23lMLe0m
         ApVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498755; x=1760103555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VsntBoZ2UX1thgOJTBqIcQGNGyw+Zp/ZR+M9plVUyY=;
        b=FwoMk9N84w78uurvRVOeqSEVFGBE+kxBnA/RDSRkQW32vKKjgvUnauKGy5uIL055BX
         /OQi9uVKmraXSnbj7I8SUtIHFKcPEXa+kJC87PZOSNG3OXup2mOcFv1jqhW4A7jcAf6Q
         KIRf0II9LqM725GjUz90MFx0qg/PjbAYX3ukkw2pqDVm8D5eFGg9Rglx9wkXXhPSSShl
         tv6piDjxh0D6BaGYpO/s9klXLKjR8OSLqyKCvL7k0545KPK6vhfaBJ2/SwPXh3xvf8J/
         uX/tXkSeiUOCQuet55BEQxHl1M3QdPjWkU7n0t6SnOR8Giq2532RxMLbdFLnwsmBZxrX
         MnAw==
X-Forwarded-Encrypted: i=1; AJvYcCVq8dw38IykE0wf6OrMQxQkgBoKi5ae5M2tMV5X5Cry//p0uQ6AtTELa85DVoQfwwDZcl3NTWVccg2+cKSi8twtLyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr4djaGbS1pxuPYJH8yRRkm8Oj+rOajnic5yEOjKRa1mUgI8mU
	Dm4ZYMUN77kwP3xGuYG44F43bN+Djvz6MJoDDS4wz/LjxDdDS1fa7PwBbG660f0QmT1dHBBA9HJ
	4KKgj1DSmsl2lwdY2V3PTVg==
X-Google-Smtp-Source: AGHT+IFsYzxWE1q+iyfd/CPcAE+BH9Qt6DCpr8RRj96mk+HtmlAuCb4ka3fjLLxAs1Crrs+qBq6aGz3zEY320EBD
X-Received: from wmbdn6.prod.google.com ([2002:a05:600c:6546:b0:46e:6605:3ac2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83ca:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-46e70c5cef4mr26594895e9.8.1759498754928;
 Fri, 03 Oct 2025 06:39:14 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:16 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-20-vdonnefort@google.com>
Subject: [PATCH v7 19/28] KVM: arm64: Support unaligned fixmap in the pKVM hyp
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
the address alignment.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index ae8391baebc3..75014dc7d82e 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -239,7 +239,7 @@ static void *fixmap_map_slot(struct hyp_fixmap_slot *slot, phys_addr_t phys)
 	WRITE_ONCE(*ptep, pte);
 	dsb(ishst);
 
-	return (void *)slot->addr;
+	return (void *)slot->addr + offset_in_page(phys);
 }
 
 void *hyp_fixmap_map(phys_addr_t phys)
-- 
2.51.0.618.g983fd99d29-goog

