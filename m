Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAD315D27
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668217; cv=none; b=Tbdv5l5oY3ZK02+140sWdhZID7WFk/AYhhajSr/sAe9kRb0gqCl0PtXJdy5onrBzCDIZKsMz3fbDQyu5KdUX12SwAJT0VSbsliNhc3Wc1ypeuJMr+Fh9tw/s3DYfz8W5aiXlcEAL+iOnXHnTgxCWXcY9l7AunglgBtDjowUbqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668217; c=relaxed/simple;
	bh=Q99ZHptghXaCpExrmPZ+3oDScYxZaZVcLLYNcVgWl8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eyXHjOD3PMHpnAsLABakdHW8WnP2k05f37i3uxbWzjO2ncY3bi6D4xcmRJGK9AoX/PpGvZQvrnAkMg5Wn5DZrJTdOChUx786rNjqXYnPA3yPs09KfB3w3/iYneOQ0SWN42liqCLT8YI/ZcrepuoUnHXEI9HZSX8AnRU2G5OimXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bkj0kPo+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkj0kPo+"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42e2e448d01so1470710f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668213; x=1765273013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0u7iZOSRB+/DoXWsZu1l6FhJZS9KBdr/uN7Ps8a3zY=;
        b=bkj0kPo+JCPZjHzf4oIlAeRfu9U+EtZmJc18XkFbguTBQMBlgEqxXZODCVcTnSjMTn
         PKQwuXdzTEi/0Slps61gd5hyUotXsTEbsTNV6oUXpP8d9N3nf2ZsLmzxxalOizG/Q18B
         b31FxehbHnmHztXe+eRKVdI4a+4eazc9orVujSOFD0HV4+/7TRy6zJVaiUrqyacGNgi0
         QPeTyMQhFNXtG1DHAsvv+m3d4SFlzZfqrSLyyI9zBB02PXF5lbwWN9pHJ7WQ/s9+xUK0
         gFoiSDLnWHYGomjMB6Gvq+FjOpJFzlsMSrO9vyr0eVAz0L4PCJnUTGBXjRJpqcDsS8AP
         QxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668213; x=1765273013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0u7iZOSRB+/DoXWsZu1l6FhJZS9KBdr/uN7Ps8a3zY=;
        b=O9I2dDh/c4N2AFh/LuaE/yTTCgEZ1BpzFkAUfCco7oIWoGtU7GkhGUpKX/1ep6ab9F
         6H23ySOJkYc4q47h7J6B8efFkli0lRtR+BAI5z2Ukc9syD7bLxViXLQMHaAqClLvvD2l
         NT27LIgaYGqR1Z1QmgmuDDIeNAsnQX92UJiYaVCoDgzzU1XOG69M8o5QRazRUwBYypNZ
         Fd3uibakO/rjfICfDW0awlzz/2c7lMLRJ3RpV0VvKgXYYlhOjI6zHqbaQNPSIyymPFHF
         uJG/pOvmKKp9LHbxLK9K0UM++1cYWlUCexMjwi1CaMgiYrS5J8WX/eDG9DCOPev4rZoC
         AWBA==
X-Forwarded-Encrypted: i=1; AJvYcCVcQwaF6l9WI7ETXvJpPYa0BmDkeaj+789wCbGYA7F3Rb8baB0mFCdtP9Jw0+HEWrnORxJk5mAiKX7SSERiFndv3Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlHMLnWhMBTP/EEgbQVSwQrWd8RcKGzQvTzA3gcFLRE24k5hF
	8LfyFrOlWS6C1g1nlL9HX4LYwdak3LNvo+oHFNpTnsm67IGh+bHjtAelUDPdZJq5uvQE7ilFCJx
	DF3aLUZfbogi8mb05RgPrBA==
X-Google-Smtp-Source: AGHT+IFuFDiK5O/H4DCPpcGsIXjLLUp67EQUdvqZzMXYtR/E9T82F4OhwcYQh3aVnhXs8gEpu7agTyI46dk1Z4AU
X-Received: from wmom17.prod.google.com ([2002:a05:600c:4611:b0:477:40c1:3e61])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fce:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47904ad9438mr274538365e9.9.1764668212914;
 Tue, 02 Dec 2025 01:36:52 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:15 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-23-vdonnefort@google.com>
Subject: [PATCH v9 22/30] KVM: arm64: Support unaligned fixmap in the pKVM hyp
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
2.52.0.107.ga0afd4fd5b-goog

