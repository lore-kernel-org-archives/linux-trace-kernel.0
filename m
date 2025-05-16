Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0DE1DBB3A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402865; cv=none; b=KpoF1GxrfoK4wnIUBfDoJrrN05Q/h4PhjAjc9ZcyoMfGzq1MQC9kGVg332rblPEM2L5we3DdXtcj8q9rzk17Vj3DHOQsy3XnK0SpElKnGb0sgFPZyXoKk1quW32GOVUzPvcFRje2vLd0i2PklI8cEgmXVXhpbaTa/LuGWpQdj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402865; c=relaxed/simple;
	bh=oIK25k9bycvTVzsTkwmIx1RZPV+DV84Nx1oo308pa9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UuqT2osqQAaiRylw9bZ6WqtGkOpxjHR2RZU2Vjzcbbh/+PeIWDXCLcvXACZsTt72ZVN3OnojZpkxkw7v49d/RKUZkvZppF2SX+R1X+wcxUYInRRHomVuklpWB2uK4jO4SztNzNuM27IdJTksO7Jgg/D5TAdS8UGdTM5uTSY/z6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1RqXikK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1RqXikK"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso16837415e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402862; x=1748007662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROhVGMzsFKUKcbl+uc4M+NtezlfJHXVXpAYtpBvAgk4=;
        b=S1RqXikKZ24dnAKx8gKpDZRlzPHmIzqJDg9r8RCPkgLy5mh39YuCpKUdsUA8jpqimv
         wjb/ymzRSdhKo2cioir+RpfOelMkcrp9OXYyWb3PEHmOGW+chbG9lIQo8wYl0kPbsStG
         DmFjM80IGGR1JPknV1mPKCWeUj43ViDNqJ2gGbcLJTksqawPpIUR6znrcfsFx3FK6Lbm
         9AniZON9P3TK1NUqu4XziKE1rpZvhn0LTpvyZ9Pn566kb+ZhjdjOemZyHR0Crh54jbYy
         UUsenm9cr1tD/8weYvEhQIFJeslMrONs7qWCJdD6edsayEKtV56Oe0UwDGzoNQbGBZ8R
         ljGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402862; x=1748007662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROhVGMzsFKUKcbl+uc4M+NtezlfJHXVXpAYtpBvAgk4=;
        b=n4ohDTZcK7WlePjia7YAwQYwcB3nHudwJx4SYPJ4rJCS9PqJjaPrQIy8xiuGWlHcDj
         DpNuBsFZzjWh6BiaHk9sEbpDFfEKEWphZhT+5pHcYum5TzLh/X21tQYKazPJudXrDFMg
         2XKNWDBNbAyG9+1KBIZdrdTiGL+JShf3Hv5BTI6VXoYVzO3Fog1o7RfQRmV5Gxwu+2pL
         dcJ+2oKhcvwOgUMMV97ev43BQrMpxbtwZyhVaJCjENC2MMepBXIOGl4R8BLSRwPxjL+X
         JU2HYcA77vwbasB3qZOvencNDMGwENsPru9RUwjWIqLgHo+dw39PC3umxwFfV6LRQxzZ
         aSpA==
X-Forwarded-Encrypted: i=1; AJvYcCX3PMUbI6p61+nN4xZTHGcK6d3WxtoB3xt7zf2CpPsocpOr1HM1ic2LsHdoutABAAY8u/7iixS7yd63ppU22geqFr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLUKlFPjYE22/59cLA1+kB3WZ4grU87fvXJntvdd9WkZm5PPo
	dkDPPa199IjYkaLvjzvsTLMZngKCp0SZgcqhZzozp3BrsQaHFtEzp6nhff0nP1x8IA0z+Ok0xio
	Jfe2/0RrIV5ho7xQ2BFvttQ==
X-Google-Smtp-Source: AGHT+IE25G0/BjDIzRGhaY+tUE0a1T8as9PDGc7bUXR9TD/pYwUJpZs3atjTMCsK34rjbeQcFKFoizPiNPQFaZsH
X-Received: from wmbfm27.prod.google.com ([2002:a05:600c:c1b:b0:442:cd25:eed8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c3:b0:441:a715:664a with SMTP id 5b1f17b1804b1-442fd6607c9mr27539065e9.20.1747402862237;
 Fri, 16 May 2025 06:41:02 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:21 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-16-vdonnefort@google.com>
Subject: [PATCH v5 15/25] KVM: arm64: Support unaligned fixmap in the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Return the fixmap VA with the page offset, instead of the page base
address. This allows to use hyp_fixmap_map() seamlessly regardless of
the address alignment.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index f41c7440b34b..720cc3b36596 100644
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
2.49.0.1101.gccaa498523-goog

