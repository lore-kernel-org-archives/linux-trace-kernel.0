Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B713C9A3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879227; cv=none; b=hoW9iCSwepEKX+f4wHEtGStRMCoAxxdBZ1mx1L0zhzDPjRzeruEm1oAQrKkPjnKF8uuWjPLaXB2PSDyyMJxjkMnq7LfHQCEWDb0vBxTEY4b2kTPMksqPY/HTbGLAhHvxD2eZGy2jDqNrCRQC43KT/3BsJgzvVsDSkDaG4IsDf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879227; c=relaxed/simple;
	bh=Zfgo2T5Z8ixTevEHjtLUGGbCOSi8rIMCmEUR2CFBOKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RkvmZ6TdFZAov86PMRJRiDUCXFrRhp4kogS84tEQ0Ib6uPXvCpPjr+M2e0Wxg74nv9NV/lDB4ToR0JWyhIfuD7HikG4MFDGLRYeu/fDpBclwtneuVcXZFeo9Tq7951ryoGamWCsavPq+9bn6yEfz77QLvrTCJ/UudUwlQ5RzM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUo1Ll5r; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUo1Ll5r"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-68f95e37bbfso56617037b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722879225; x=1723484025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H05O9T3Ox5CpRnJDTmEZCPImDa43qtJg11hSfsrrifs=;
        b=DUo1Ll5rUZ5nLeINZvb2BifQbysOy7SJHc/QcQ1qXfp8ueNjqnMnxxOCXlb9aU9mLz
         l8wAmXCDEYeGq6dfvv6drUJYPOgf0ayXEaJGA5XkaHPhdPCZNsjvgGO5mlYA/iHSk15l
         kyuJ1OHGwXWk5aRfTTaijm/z+V0yHqKbEfuNN8cot9Rw5DEnVS1AwCj8WomPAdFPw/wu
         q5puAqAw/S3nzPEPYJZnnkbgJ9vxHi7AkW+yS2j2qQbgEvQu8Q75fCC1ZYTbhEt50SBt
         /WcPatwevO2Fb4aBMqNOZBmTu+OanAtxarV1vrCBd0NNoqX2LhF6+lgD61fzAJ061ze3
         3p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879225; x=1723484025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H05O9T3Ox5CpRnJDTmEZCPImDa43qtJg11hSfsrrifs=;
        b=jXcJN288RwuQ531/P6WduK554EcdaNs8amqA6mGCfWocOVRsqVTssUqgAcURvk600o
         oL3OyRpBjW5Exupl1qRulJvBECUnm5nnEXJ2jTAmrQBk7wMDwCu8NZ5xUvLH3RdZ/Tm0
         Wj8iaXeVsQz/Cbtgi1AF5AdG1YKpS0494Whp9mvbgMTA3+HxnDU4XfETxwQjdYZ8tH7I
         HintwhYxPQ2arkGLkWGiFyEBWfQlc1S8a9kORQMBQB1p0HkgMn7TUobyWnqT8VWnKHQY
         MSvg5sb8M1bIHLwO/P8IgE0bNIkJzr/zaRJOCyypJFu4huWDT9hRe1Ofo33486MzqAMv
         SiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn8k5j6M19kUfRGAdCcT0zufEFBbo+mVP4rza+GcaNdNEBogURAgEis9nNc5jHMsgBd7aLiPEQ6NejaFw1x41vxPxx6GZWnFtroEoJf8P4wUVu
X-Gm-Message-State: AOJu0YyO5mO6CYUQCeZmdTTnbB9yKvIdD8QNN0c97NgZbzLfv+Diy86W
	Y2EFhC0te0mR29jPVB7EvWB2gJA7+leyz/s9PQPpjjigfk/6pHPvqLtKHcrWdFsKadGqRTwboxt
	fsouZ4LfVZpuB9ITfDw==
X-Google-Smtp-Source: AGHT+IHsOD5YRnEw+D15bNoyyt5n/Vawa4b7qZVdFbq8DEDAkiXUJYvnAc5v2UIvgt8+ZyRPnnfMKxSEZPVyBIL3
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:2b02:b0:e03:31ec:8a24 with
 SMTP id 3f1490d57ef6-e0bde422b24mr78861276.8.1722879225124; Mon, 05 Aug 2024
 10:33:45 -0700 (PDT)
Date: Mon,  5 Aug 2024 18:32:28 +0100
In-Reply-To: <20240805173234.3542917-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805173234.3542917-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805173234.3542917-6-vdonnefort@google.com>
Subject: [RFC PATCH 05/11] KVM: arm64: Support unaligned fixmap in the nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
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
2.46.0.rc2.264.g509ed76dc8-goog

