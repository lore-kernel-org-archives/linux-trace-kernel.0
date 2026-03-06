Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A63BFE2C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807777; cv=none; b=ToFptwF/ua6WxmuXjf26dHpqq/vf0DWOG+FU7Mcpn+YUZYZWl2Ynwd8GvQWteBRbe6hmvaYsP7DzGhWAcu6ljUPY8pPnBdBaVAlows/UPPhJtdXO6pjddHtBv00pyLq5pjTAYVBopWQ77XjA1x+CBlS70UbUDbph26V1vXaq9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807777; c=relaxed/simple;
	bh=cWmCVGc8Z9dVFyLjcgMh+d+QoVHI1pxbCmuYrrytJC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQ0CUtDCaHUV3qvl/2NYX85U4aPwjPK+omK+2fSavx1ywB65XX+oXjUpM/gigiLpDF1ga1L1nsl7fLun67JmEgFlLzW5H0WktaQTKvVE6QQE2CkFCvQLL/dmdcalpzBCgCTP0z8vUNRjjnGEVbNwZl9dsjgoBAJmxbA2aEcNYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OicWoWRe; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OicWoWRe"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so93270215e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807775; x=1773412575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KUjQbuHQJ21p2RQALWJdLghrvcyrBZVXJ9cfGciG9M=;
        b=OicWoWRedZyV0n8lR/4qhRNHL9aDsjFdrTnHO0v+9u9epvAoaeVf1G1vypX7LuU41p
         4sbXZywU28/20qF9DaYPtqHZzs1D8qcCTW4MW3iNZotpv2MSOf9AK5vFP9g96QSjS8iK
         tTpM4EE5Vrue+mIt40BAg8biP9WNFmfSv0qUKejnm6zOW834SVkPFPLGKxnBv/lZXhhd
         QlBBFDQhgI4tmpyh7OQds3Gh9h8B4QEB69BLA+zp/SxJ00EoA2PeLqPQu/jWPtOphoyd
         OjFHRRHtnMX78nqvLBuPSYxHxCVjfrTr1f/2Vbi55afU6qQxD7u3eIIOW78d2tj/9VXC
         Lifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807775; x=1773412575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KUjQbuHQJ21p2RQALWJdLghrvcyrBZVXJ9cfGciG9M=;
        b=emDoPFxGWDOI5eHhDJ3yEpQDciZayCJ2HCNrnG8D0oxT0WxGVhGAa2TKc7ZOcQbZL0
         HiF9CH5IGcqj7yE2bFgvNWAf0n818F7YBJI1Aa6A8gHLl7k6k/sM/dHbBSnbpLvTomn+
         167cQORLo9V8HgKJnqzAcQMJuFM2Z4WQDr97D/gMn/zLKQ1pXjVa2F80V4ozhhPNTi8X
         Kjtw4Ek4jT10B8nBBigMTfT1Oh/8ax5Mj8dV1sHNjfwX2X74oR98kNkofZZiBWLo95Ca
         HOBR54PXXVcArSHfL1oDIeLKBActPSVE2kYeSEQ/ZFEFAHrYfm4czrMSBROEZ8MXbg8b
         IP+w==
X-Forwarded-Encrypted: i=1; AJvYcCV0HR+9+uGnjhwTWsomwP4cKI7DwZXi8HcBBxA7+sTN6pdwPhpNUtopIW/sZp3quSRr24yuhQY9heQ3JIB85aYv2JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWs2a2/bb6QUo9529A0MZELmi+ROv4Isjg6i+ldJjqDoRRcCXm
	CwjVT1RNILsjFOBbZ7F7WMUAtEd++fVSMYeERkpKyS1+6Bt3muN9KlcDFu32VACZa0SuQVdgiDI
	ftAnGslM+bND+DMdJJ0+SCA==
X-Received: from wmcn3-n1.prod.google.com ([2002:a05:600c:c0c3:10b0:479:2d82:5535])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4446:b0:483:29f4:26b3 with SMTP id 5b1f17b1804b1-48526715248mr36686515e9.1.1772807774527;
 Fri, 06 Mar 2026 06:36:14 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:26 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-23-vdonnefort@google.com>
Subject: [PATCH v13 22/32] KVM: arm64: Support unaligned fixmap in the pKVM hyp
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
index 218976287d3f..c98cec0c150f 100644
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
2.53.0.473.g4a7958ca14-goog

