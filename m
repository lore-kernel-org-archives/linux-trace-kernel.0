Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB0358D08
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866185; cv=none; b=NIKqhTjO35L/bGveMYLz/fMcVLxV56bRMicZ5ZIp3/NH2E2fDqwUUNUtVrjlhsHgBOqkcI90B1CmVyf/SslcVHReWE/HGy0tSf6dopsIwI2xGmraBy0jBIP/WayBAgBoYmdjAVSYueBbS7tA2byGxWhp2XTgVQYo17l3LW4alCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866185; c=relaxed/simple;
	bh=akk2UdENQbgS4aNRHidtxoT1q7g4hUSbv0c7DfQudsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IxiuSwCSYcARAexBwCowgve5pHPGp3bHixafPPxD8DnFZwgVIenbdP9KMTkp9xsICS16l/jXv4vUgtJS0fOgJbB7tmIPZAA8Y8L0PSXGBCkFsip4OETsMAu6zfRzc6Pv0aVRDMdPr20s9jq6rQNlBjS4s3ssxGzDV//CS7Cu9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/pNujnO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/pNujnO"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4806e7c4220so24409615e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866182; x=1770470982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Vepb6gWbmfw10H3EWIgkkfZunr0icHCkKhsRxDAh8=;
        b=t/pNujnOwB85L2YeTRb9dJriij34mynEj5+sU3zaNqDyqewNrkT+6n8/7QqKIQDxx0
         UafwOZslGpmcg3+SkV8McU7PPHylq8mzwqAThEnRKe6JpXZoPQ1rTvOFnrNOmo/h7Dll
         f9GPFXAK8oe+QeAycwdx0DGi0S98W33luaxCfT62Jh9FTTB4hyKuLmUUhZIZz22c1dX5
         I3b5HxmJFui5PBxWw5cYLMkq2rC0381VwsIiFZ0wVxcaaBsquXWjKjLkjfWgN6CW9vvy
         IjMs/FYTUI3nI5qvuBhjs+cmADXlaM3pYlSYpdhva3BU7yamqAHAB7R8qOZyhcS5rUM7
         WeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866182; x=1770470982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Vepb6gWbmfw10H3EWIgkkfZunr0icHCkKhsRxDAh8=;
        b=fRQJQscVWva8RI5JOm6xVnYRK5R+N+6A+JdjEE9UyrGIwUOPVEenbovTm/sTSkvmuO
         Cc9WAKxHsPQ9+0wYCIGuawzMhvRERcTht549UJXupzRDEDNf+dR9w06pNn4GmH+nSHYi
         On2OGQcc3PHvf5S1/5wQv875LI9xMbnIyPAKazVSoFQFwOYA2CwPOW/24pbObi+LVghK
         RJi7qUefzzAu4sgtA9rtwis7DwNeHgXJ4/NaoFrV86wxxnfdiGHpr8y1YbuZHxSUOFkL
         avZhCH+JP8ToswJ13FK1+hO3rF1PUU04uHhZlv+8bIZUbcxieCf4Va3bfnpI4qY90mIO
         SnQA==
X-Forwarded-Encrypted: i=1; AJvYcCUikC6bEyqKYoY8IGcSGdbbVdnFAF7P7u2qeFoBfCHT1oPXhvB9LatsGa2qMvaYa00GHSAPpKipx51tcI3cTwiaZ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOC31FBtOWMXQ6DTm6qWoB0Lxq+90Ra/YOvx19/qWLUUYuA/bK
	qRFEUlL+/JaRiDWzgV2DDSpk6zRn7kUCnNr7G+eBgIeC5MJ0rhnRW2OMXFaHtbwoIeNnjBEnkCs
	CqoHpyCCvv1rULwvP0I2UCA==
X-Received: from wmcn4.prod.google.com ([2002:a05:600c:c0c4:b0:480:6afd:1fd0])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d03:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-482db4567d6mr85643685e9.1.1769866182054;
 Sat, 31 Jan 2026 05:29:42 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:40 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-23-vdonnefort@google.com>
Subject: [PATCH v11 22/30] KVM: arm64: Support unaligned fixmap in the pKVM hyp
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
2.53.0.rc1.225.gd81095ad13-goog

