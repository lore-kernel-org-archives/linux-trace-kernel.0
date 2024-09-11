Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89218593F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047059; cv=none; b=p3+TZUF+XKRl5BOm5yA0hVpzB/OWzBxJ9STJBCQ+UaeM6i1VWC1bHfRF4SIbn3ieLJF3QFwL8zKavYQXBYfi6OdpVlM4CPklGFpCrSBhTEr0rff5jAcbrELqLae2bmS7TLMFInYI44fqqR6HNQyhzBzlPjl4qplIEiuurPYyHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047059; c=relaxed/simple;
	bh=WyNAlQoRSlaQbJNtJku/DZE31pU2tETQT6EsDmgk7cU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P9TFeJgYUZDDZX0skV/ZstfmhqidZgGZTiYiuaxAzwv54PIx7hNWaYSkgOF6QBY+LyQliqNyW6G8DztBBWhNMm9FHWmI1i5hz6Mt8FwwCgDxMz+51WucXn/DBfZ5MpAhVZkTA+80yC/YGl8/qCQZTDwwsnYHuH4KdyZqHCvTUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yr2aUjo; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yr2aUjo"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-374c25d886aso3082414f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726047056; x=1726651856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yejuAYdn5/QbIt85/V9/g+97PUpnS0RfPemDihHOcTE=;
        b=1yr2aUjoJT20kF+eahXdW+v0qb2zWTxzO5405VPXsGrQpHQ1Eo3Cr3Ql6a9u9sAeG2
         XxBRhI4Mha3DuLIfTz0p5wKTFhrna7Iv2tX7PYjIaAaRoq2N0ZxaZO8STKOqd3/1zCMw
         u4sO6OKXSqd7lCDATPwgV9/qvDjUJkWE05H7Cs1KPnfpVB8XYdNmYjFOgdhCRGex9KAA
         r796uwqbe7WYOAqDI6UKahOsTEdLGo/EAMNiychGrGf06l+b5FCJxGwBmbiXfHxLrtAc
         eIK+tNfoiGOpZ5bLFCNH5OkujyN2ljrkKYrRpKr0UWsSAU3WYTVDX7lDyyrwO9WRwhDh
         ub5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047056; x=1726651856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yejuAYdn5/QbIt85/V9/g+97PUpnS0RfPemDihHOcTE=;
        b=d6se+Oh4fUKF8lmKNctk5PHMeLAnvaKCRuk1hzKEz7v2fVOQkKnXa72pE3oG9SBm3J
         ODj4ouIolS7NvTfxOpdNViKdO2RNW6zRdkmQLDTPI7vIRY9ngZm9JCQQxyL17fWODS12
         Z03m6W0KGntEOgTbQqqLUkCbqjDkQPWcO0QrvlzduUndiJIP3ZUxbGQK/svh+rzDHw9R
         Xy0N4xPEx0HXW/QWolTTlT53uFgDyrKuJg+3cGNKj3ftle4NL2FXjb5tArlQTEqTdZk8
         i/6SD9ZTsG/Qrff0BNC0sh6/J3ci7tpr4r0qaZsBYS0+NY0a5qL8ctf4rfPTxjiInAvF
         IraA==
X-Forwarded-Encrypted: i=1; AJvYcCUaltKSJ1fVRKEkpBvFi3gN+oy2x4iMUICeFk3mnqzaEMvgbACHJoqqBxMoHN26zKBMHt/exaCVHS/4Y0U2NHMYXh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFKCQQROxSNicyOOxd/I3Ek0ZJct5Gbrg5XgEmiO2kION0nNk
	RH+7Pol9v3spPnzMqvTpM7R1mYGwxDMkZROFKk01dlOw1S2aEiorDQJVE5zTbfqFhjVvNVYnToR
	lYqDdQBPJR32AixcRrQ==
X-Google-Smtp-Source: AGHT+IH3JK62CsMjZY6SFuOrVbxoHTbhIFQKDf2kfn8b46cEmKNMGKp9tKKeHqg7ZrDPIMVbTdlp++65L0GaDZBF
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:edc2:0:b0:374:b238:79e5 with SMTP
 id ffacd0b85a97d-378895c63e4mr21238f8f.2.1726047056142; Wed, 11 Sep 2024
 02:30:56 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:30:21 +0100
In-Reply-To: <20240911093029.3279154-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911093029.3279154-6-vdonnefort@google.com>
Subject: [PATCH 05/13] KVM: arm64: Support unaligned fixmap in the nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Return the fixmap VA with the page offset, instead of the page base
address.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 8850b591d775..c5a9d8874eb2 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -240,7 +240,7 @@ void *hyp_fixmap_map(phys_addr_t phys)
 	WRITE_ONCE(*ptep, pte);
 	dsb(ishst);
 
-	return (void *)slot->addr;
+	return (void *)slot->addr + offset_in_page(phys);
 }
 
 static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
-- 
2.46.0.598.g6f2099f65c-goog

