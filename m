Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8702F39A4
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Jan 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767430084; cv=none; b=bohl6M5nS0tS0NQS7OF8zGd39IDSpzVUu6Hxhd9HQgxLaLHm9N8Wgl8ATO1uDdH4WBXd018Lp9e19Y6EIvnoLggecZkmgCWEnRV34qrXpy2CMZ5+2dWGNil+ny7hNTnu2RIvv1fzjndRtJeDtC6hPT9yn6dmP6QrHqK6YHMYQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767430084; c=relaxed/simple;
	bh=oYuaUV5WENSL8F/FjXeon1A0GIHc+2y/rBKD0wnXrPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMYpQYhL05MuramxJ83nqBf5iGC2q8+moSuzj6A9pUsBDCQe9cwe726vwdrxdTDUiS4R+PKyT/XK7EG3QCDMnfY4K3nNiRw++UZZyU2BQfbzk9cz0oFkL9ssfXRqAVsbVfliNsRSihBr5mXBwh2Yg1N/4Babildwx3KnL6/C0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9g65KJ8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9g65KJ8"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo14103510b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Jan 2026 00:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767430082; x=1768034882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvs9mu39u8pUKEaoauSfWHl5WiFJwmaNAiuKq3SpZKw=;
        b=N9g65KJ8ls6eTbuuzFNnIHa8J4iX4HVSOKPC+OTcziaWUi2+UYW0Woy3QAm7tnyAec
         MdtbXdEDTvVTVFw+/wO+d+ijtz9jT70WrTR01g/rrChIdeHSXnfCc9joETFSihgZsp2u
         pXImFY8OPbtrtZR6x1i7PBWxLc9IvRaHofYkAdJRV9LxOjJ/V4TxC4VZ6+ReotXwhX3n
         r/fTwVikQc1ov1qB9bvAqHIbOZRQvAOsA3s1lVU3N89tRdrxdMOa5L9aU+P80DIfes+e
         45m8n12KfIoox+gCTiwPkpoZkRJO+bsk3zBClzl8GpqSmAtUrhlCZMkhbiMjuvHfMBW0
         GyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767430082; x=1768034882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bvs9mu39u8pUKEaoauSfWHl5WiFJwmaNAiuKq3SpZKw=;
        b=WmneCz3V/3alN5cDS0ogTWVD6cSeZ8waiSiMA7h2kex+H51NAGLMivZWKttYp+WQAq
         yTvL0jDx2dwIoHLipkLkQj1wpZhH56vqb5NtyqdCFWwvWWTkDDfGBnwMZ0GL2el8kx+h
         YUuOnAu6KjLTzDg+LaKlRJj5uRJgLRFb2yIKYqABWZHk+hpp2hohDqq0Q/gGj3jMXG7x
         LFdf1mrdP8ALQTizhfbm87EH0MuV4W5LNDpxABQ6jsT8nSYo6iBATabRKrwclTi6z9PH
         M7cXPDdOTw/V5OCX90Di9VwhHSdPV+HaBT9lHlOiR1zYO6J9uDuz7BwDsRFmbctuYShy
         yDyw==
X-Forwarded-Encrypted: i=1; AJvYcCWynthmP1DK8hdBWyJtgSiaRQKWdS0CBFc8eoQ3jchcZRaHcssGskfyKtUVuLa9UJgXgN9fVk6bwe518HlPUABa6XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBAGg659/v8qk22Y1RcaiVSzH/Pr8LyZmAOm7clIdKK/6pmck
	U904uhlGNY2nW25xqzUkqPHeSF5lWZCEAa50ikCfh20lCmSUz3Gy6t6F
X-Gm-Gg: AY/fxX5S1gpisY+fzAB1JRFQp476/UdjJS9vrDQ2hoYVHy2hn6oQO/e07NlJKthQwHt
	J8BPauke/Wm/qaWjltD94scPo7fekHltpwPCjeF+mtnpQgmUnCRyoeKXNduffpGl9nJB7hFZ/M2
	PxyqHdposmbdFhQZm9dmfv6vKsxMaS3ShAfDSxyFdjmful7rBum1QvN7FYwSlsFMQ/BQgIr7adC
	gWvjYjGi+H+EEzQ4PHHU0vRxLyPgWb1FBgGCOCgVlqOFVqoJ+K5DXsT2CeCE94mkrfs1tMr2NeI
	Lsuzi2vGqB2hy3MdPI8imWeCXGbFWRQjGaMBzy/x1yzQ7OrLTZKQpkUSm90ob8Ux1M++p1aamNE
	Wp1GpuOHnsYqy3UNpWZTKMvb+QNCixm/D0RPEGE7+l6H+vlqxVcXSMkxfNOn6JxUbYeALELkOwY
	yI74T4114DLIrHrYs4WqwTgTbTkom9W2Baic8=
X-Google-Smtp-Source: AGHT+IFtMJvjrpfUuqAmA+OpACtkefUVF2XH5YredFgsYPdy6OhoXIwbDm8pMiudZkIWzurpixeN8w==
X-Received: by 2002:a05:6a00:338f:b0:7a2:7792:a477 with SMTP id d2e1a72fcca58-7ff65d7e81amr37223258b3a.27.1767430082432;
        Sat, 03 Jan 2026 00:48:02 -0800 (PST)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([210.73.43.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm42704939b3a.33.2026.01.03.00.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 00:48:02 -0800 (PST)
From: Keke Ming <ming.jvle@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org
Cc: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	tsbogend@alpha.franken.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Keke Ming <ming.jvle@gmail.com>
Subject: [PATCH 3/5] mips/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
Date: Sat,  3 Jan 2026 16:42:41 +0800
Message-ID: <20260103084243.195125-4-ming.jvle@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260103084243.195125-1-ming.jvle@gmail.com>
References: <20260103084243.195125-1-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated kmap_atomic() with kmap_local_page().

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
---
 arch/mips/kernel/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 401b148f8917..05cfc320992b 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -214,11 +214,11 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	unsigned long kaddr, kstart;
 
 	/* Initialize the slot */
-	kaddr = (unsigned long)kmap_atomic(page);
+	kaddr = (unsigned long)kmap_local_page(page);
 	kstart = kaddr + (vaddr & ~PAGE_MASK);
 	memcpy((void *)kstart, src, len);
 	flush_icache_range(kstart, kstart + len);
-	kunmap_atomic((void *)kaddr);
+	kunmap_local((void *)kaddr);
 }
 
 /**
-- 
2.43.0

