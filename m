Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20C31B132
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508351; cv=none; b=JUfPsPUCAgZfGE47DtWbT7aOXWovP6vIRWNwd4NCfJ0arsTAmCucLFzsHSOrD3XBqjDDHCxRGLU9s+Db+8EIZXWApGo7bOow4ctN2HQ1/fjmpPtMm3h/OiTHCdpJmNhWEaZQK/gBrWGTGoL8EHNUgCW0B5zTU0W4C3j0YxjZicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508351; c=relaxed/simple;
	bh=K6BFdGsDSreoyO+1qzHWDmbuE9TGzb/eB9/SColmUFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cIwDH5tjclBOrGy8CQyGWL7edwT5DW0REm2paL8NMGUY5vgqk9UWB42DOInFphec2oNkRqzDNs4Z8RXvCou1iKm2moKImbIJo/QUF6bsmMJ35znpiAnkoleH+DDa7icdvcJ+GeNBfhk8O1RYNoEHvYZsUbpelECoDDZe7dpD4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1zFmU5oU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1zFmU5oU"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775e54a70aso5884615e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508346; x=1763113146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8iSqv7nsn+0/xw84T8G+e+uKy51ge38OdRp2we4P8U=;
        b=1zFmU5oUqwLZRTFQxLS5h+uOGZkXqH3DgBPXDTB8zzue+7ax1QXgSq0bkEbcwSC0gM
         C0w6MPzmDIcIbMU8j2ImdbJitjosVS99HVcz1T0XJr7l0ld5kEL8VLfTh0QKaEmQTNBO
         aYjBicS2nhazk1ghFI8WWWL3/0NW7L/eqJ3mgMYLg1x0s+9sYzRW2M8gJrIbytIwY7l9
         Ii93e0s111DdkwmVa41XGGM2msxg+cuDOXmJNx7OofmBgBKzbffQuAMB9LXD6DMPcBOL
         AL/CgYwOMUb53YUqZE2chZuhI5XgWWW1u6/v8qGrJIvlOczYzblf9rgTNrEir1FPAqP9
         0qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508346; x=1763113146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8iSqv7nsn+0/xw84T8G+e+uKy51ge38OdRp2we4P8U=;
        b=ZmWDEnNKKW8akaCYMd5CEFuVAj8tD9DXQgHUwVQltuD08vo8ZUX+TXDLlUTU8v3QYe
         lkxD25MlorbqCsoXowWoYPHukt/d2U+gUw+srL71DmYnHiQCSN6zhOWfYEYswR3PAXkE
         BB/5ems93JnKoSSBxnsDK42+eRgqyd1rlU30dXMtJoDNEi9A1N5dgddiKKtIU7zpWrgc
         9QkJKnNHLfn6y3/YDZaY5IWBz0fTSveLlW+CDys5FKp5cZLWMP3JrPnUPBhwEJqGp3OI
         +9vl+OJ8DvWQ9VcdpOVmEYLcSJtaCSJyIlDceBrXA+FW5rupKH+yOZDx2MLqoiw49QdO
         aP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ85WIAvjWL1zxkMSwn3ifny7nTG8esgz0yT3FqSuH12hDBfGWBWiGquhSUmzriVNiRtRJJDOWuKuFIa+wSE2AdPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxr5VyVvyL/ZISzzhTk7gO2aJMPs9SAGZgVssg6kTaP7xWpF1A
	lS5sTi3aNG+iJ/4/ZxVNMN8h1VPqhf5ug4hq7MPh/mW8U/NJadF5PqrdoLmCz7KsXJnqxvVoHzp
	cDj+DZg0n92wG3NrJ24Bw5w==
X-Google-Smtp-Source: AGHT+IHsR3qBiRucA8EKV6gtWcPn+2ggqqibNDj6Tp411vd1dft0CpDHY+pu14k+X5SUIXMeB/b4TqMhsuxDYA6Y
X-Received: from wmbju15.prod.google.com ([2002:a05:600c:56cf:b0:475:d898:b23c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3113:b0:471:3b5:aeac with SMTP id 5b1f17b1804b1-4776bcae3d2mr20603165e9.15.1762508346413;
 Fri, 07 Nov 2025 01:39:06 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:31 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-20-vdonnefort@google.com>
Subject: [PATCH v8 19/28] KVM: arm64: Support unaligned fixmap in the pKVM hyp
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
2.51.2.1041.gc1ab5b90ca-goog

