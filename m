Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D9C348469
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513432; cv=none; b=sjrEfUD5Wd6nEIEHeSWp1V0IaS2P7k3PNIyRzExtpGZxh7Jn4Fcskw2+t599EUQ8P7mIPHmur16t6mmdIawVdlZrbzT30wZW7wRyAnAs/BQeY9SCgAiqJljGG1CAuyuokz/sMu/e6CYsZsxoXET6qBlhuLBhwe2XrTnpLt5jlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513432; c=relaxed/simple;
	bh=9koaOg8gz/LIYhm5Xo3A1Dhg2C+g70uI5oYNUnCRRUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L76HLISMOb+3JJv9MnnjuTps7BYrImoq1OY9Y1yN0Wn9EMeb51Qp3LNffT4o2H48eZzSqS7hFrpISGQMmsWRXKZKozxdoxc7nDSImUCe4k7BRyVBkNIvJPVM0uVZPuXUFhk4HvBzKne8kRWQphujUNIstriv+jhHyHOck/wRDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1FC6Mrcc; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1FC6Mrcc"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8f9734e619so77441966b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513429; x=1772118229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F2gZpXDniUcFidBjYaLwAM4ahhSMDy4xfU2xFo+BZpQ=;
        b=1FC6MrccIb5WmBbemFpCzY+Jt24vkym0oz9+3UjVAl6bl4qz6YG9QqKsqIiPdZPb2I
         7GOw38GRR1CwMJ8lO0tEz6NyCL8bnq8UHXXFjZVBbyMeADXwiYVMapmLVDgQlOzY1U9Y
         Ixh+hn++Pum/r1CGgg4Ht3ZboOuU3KUcbJ/HFRSjPQhreWw346Sy+4k0dyLiVHrNX/Df
         6ymB9+QxoF9ocU62lxu/pDn/tsQyd6IdmkpS0Zk2ZIqLFQG0H/aZHf4ieO9Zw9zgOWY5
         lDn6h35sSFPT2y+38n6dhUsBQmodeKDX2kk3/DJX5OY1c6tEdevA+KJeewgNdIG3l4Fw
         +MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513429; x=1772118229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2gZpXDniUcFidBjYaLwAM4ahhSMDy4xfU2xFo+BZpQ=;
        b=ZOm/5WvAemiVzOrBJ18q4mGbZxNoqFdlo3iyWlcScXGCZ+rwhhC0zCWpEdCwVLursA
         lkbkCfLxn1Mw/zVVbPZlIbqSjlJ6GQsrtcvl9HsNwvagGKLO+DhDA5XT3A3WBNaW1Yn/
         E5+f0KtR7kEjJob+z1bfwiL3pHdlUuXdgVBSrWk4ShsmN/qJMDCBzi+bJozCyO3KIroU
         Uax66RuvfkqgxvAz4NWOZlMlSpbMNgKHYH8XXojQAb0ptBFaKlJKSQyOnIZwJVediCiX
         hDZ3NEmr2uv7oPAxoDvwYeR8sAL7oxQWOMkxDS81HxWVhc4arl+VkXda29g5Ydi8ud95
         L1dA==
X-Forwarded-Encrypted: i=1; AJvYcCUXbDD+ysSZ71MVnOJg+3VDG8duMYvsehn0tBnKMR7j+RVgBPG6A5nDEe7/a9FPPMANWRW2KX44b245RpahpKs7Eao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9CLGC45RDOf4GNZI2qCa6KTm3ZLBtLoeO8LhoRXs20duF3ne
	SOlNteWaj3tFpylVU72YNZq7oDv/QLa0FRA7nSQnoBrHqU6wynqg5L0sA8PVFqVtA4XOMGsSdzf
	PWKlegn3Ws6UXj9LuVNjBzQ==
X-Received: from ejcfr47.prod.google.com ([2002:a17:906:892f:b0:b7a:21aa:8969])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:86aa:b0:b8d:e10d:6f96 with SMTP id a640c23a62f3a-b903dc94b3bmr358008266b.32.1771513428793;
 Thu, 19 Feb 2026 07:03:48 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:59 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-23-vdonnefort@google.com>
Subject: [PATCH v12 22/30] KVM: arm64: Support unaligned fixmap in the pKVM hyp
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
2.53.0.335.g19a08e0c02-goog

