Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5F2ECD1D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764083; cv=none; b=bw/PEzXVJ/jHKQ19vV+FqEUZK1PC1/kd3owA0bxSlMf6AYVIRvfl5GSWSOfHOd0olSC/gKdBEgzyeRvMt/17rUTRBSXdyCqrknw67DqMfDDP0w+wld7c0GfdLKTJst/e8YSFJQO7/2XcZqiG0nM/8MdQcrJmt6G9AN/4MoC6WuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764083; c=relaxed/simple;
	bh=djyw3UFCiwMzV7bmORQp1O1b0BX5/uC4F49iUhOQOjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gae7QbGM9RJxF3TSdjaL5X6clcqBQIlI5FncXDPVI8VdqK1pZI1UBk1cZ4UwVo+53CrX1nkyZVZO6c7H8VkQV8MSZ/kvWXLrEQomvfW7UL17NUhRV4Rq76ieUYIdkL2pWlddSAONFC+RdsgnMvFY9ZteeXFRH3armsF3rEyUP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHk00zVN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHk00zVN"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9dc553704so607841f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764080; x=1756368880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPIqYp3UxnrgGl3qJNmgFxP+ej/sPqPAZCQlcsmkZcU=;
        b=PHk00zVNN9qJbN+a+QOfJ16QzCETjAAhoWsPVSmkAPIuZBV5ABRICEtEAhDqVB8RXt
         0VnI3euFT9PSSk+L6ADA7I1tuqdnHJZzcYuCBHlfP1y5uxe4dubVjh9h4/zaLstlWMLn
         +XBovied7lKnmpf90us6A7xDL1VfYM0L6jktxpijlWKB8vpTx6vwxUHgsItynJIUydjd
         5l10uuIStEbW5fKNVAGSrvputRA/35AXzV8lk/Ezrgpi/RM3YOOpsfxLNesZjS1dPXc9
         TvYHMpWtNw7fU43UkL7wOz452echRcEXAgiHpQpH5tVeS+JgW3p5BigPxc0TPAS6QTrN
         Fz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764080; x=1756368880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPIqYp3UxnrgGl3qJNmgFxP+ej/sPqPAZCQlcsmkZcU=;
        b=fxmlZ3oYLj7SgMRTBc6Y5qEkeK1fTUjYmdpJY47BAPORyZ1EfTUhS+1D3s9fqrzk7B
         ogL7PzDyXsS801RUxaIdYzeVpA+XRw423vA3L8OiQv/IHK6DLYQeJNgJ7KxeAja2iv6X
         IkY01JS6Tq6xSys2pGmBHqhFHtMeDqjNiYuwnXlxg3leX5KY6huRfT7DH+4+mR5ckaHF
         C6K+kLIYFj1uEzW/LtorQqbuF6TtsPNvSp1D0bdrrCCnp0tZD9mNYOUQPntStU3LSXNf
         MLedEa71BWTEFKy6uMOfegoA1+xMucIv2A5/mOPnbSL0lphAeyN3Eu3f+IRZO5AppC6Q
         BRsA==
X-Forwarded-Encrypted: i=1; AJvYcCVc6Yfa3Bbh3egNj3Nd+7fWMF9VdKcsOGRCUjtMjTzD57v5h5xd9RrKtfyFjhBkDKycQbLWgrxMDcauUT0PiD/3Gnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9vQnNzfCM7ndcBZcMrKg3RI583VokoqMdw/d7xie3sqbQoBF
	Z2ymrrZn0wsWcBYcknnGRaWu9yT/4FV0u2H1etKyyD+NHwiURQbINuZ9WpHWmHvasEW7C9TiTBl
	dDEXJvbJnrGCxOm3F+8ciNw==
X-Google-Smtp-Source: AGHT+IFW0oHYaYpDIBDZYmTqCX5wHO/vO6Eo9gvoYMFEfcVe8Gc0SJN49mBNwuBaONnBa7e5yp3hTafs+zGb5o3m
X-Received: from wrno12.prod.google.com ([2002:adf:eacc:0:b0:3b8:e019:9f6b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:220b:b0:3b7:8412:4540 with SMTP id ffacd0b85a97d-3c49596dddcmr1244691f8f.27.1755764080019;
 Thu, 21 Aug 2025 01:14:40 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:03 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-16-vdonnefort@google.com>
Subject: [PATCH v6 15/24] KVM: arm64: Support unaligned fixmap in the pKVM hyp
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
2.51.0.rc2.233.g662b1ed5c5-goog

