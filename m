Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC22F4A19
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Jan 2026 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767430074; cv=none; b=KlnSDm+1Fh2dPcPKb9K7Tba8AH30mkFf74xG4h/p978mcn71UP1itw1PUpQjcsSpMtVWtIXF97zUqMJLY3kpeMraz4At2q+N8vOVSi0DAvKJnsy4yvps1jPbCvQWE+R9eHzSJwZhwbm7cqOIKOhYFemeF9F0ECZjLmFHmTBpKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767430074; c=relaxed/simple;
	bh=iTYbGlbd0WfjgajAU0khl46xvYSC9oXnQ3HkejxUQc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzzHt/qWh18BieyCiFQTgv+PCV2nhICo9HsMwgY06xtbBkiN7+m/X5v1nQlesTRmgOpWEVjV1HY/F0Oseq4eV5bsyii4cO8allTPZOh1RDSlI9Uy7xwwVzxes9rlorioScR7DrMNcVu0gTN43gYcqabcbAH1aEG0ssgiI1R+xR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgDqA+FQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgDqA+FQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7f651586be1so232618b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Jan 2026 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767430072; x=1768034872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa14InhCOXebwmWDP7ecBkutspm2W7OpFimtcnzXp3w=;
        b=XgDqA+FQhtRYBBW9jtqVZwzk//76ieIC64Vab2DbizJZ/IWlwJOwp+yGnpd7VXvKVm
         bKQ8L3mXDLriKjflCfUqogiXRwiy/FXkIY8fUXLn60F+wbzyerIfTEi9RW0yvT9hHxcZ
         ZJiPExY0z2jYWFHuxvCGC+Vw6f3MmFF0kc1MTFXyBtHxdVUol3lh2vHGnQ+S3v++DMa+
         PfrYf3IxA+h0uyrtnwu2+vg/R7W+RKcoTxhFR7lPs1PX1ZGBSoyhCc5X2AEER/HftsDq
         C7lu8OfIMh3KVsOq8egW0WFONk93vZS7LshO6jsNS5OZLtcSgk5A1G16GmEvZsgjaPUQ
         H1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767430072; x=1768034872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sa14InhCOXebwmWDP7ecBkutspm2W7OpFimtcnzXp3w=;
        b=HihOtbPZWVJRD1U8RIedTQVzqUVHy0S3fGMYWyGU+YDWMQ7lIh3dnvKYpQjxWveFsV
         hhqZylngUbLPefJbwfd+IMD3dkfRHkasbnRSy/8wmyyD4sidnVKld2JhhlOrybLbQak3
         j5NUkDpqPgXdQru9UNzm/v1dUYN5nbsLptoFCgiltEOsq/pWyePvq/xBHC8ORpXe9X2H
         jd6vGTKhxfgaK78apXMRyJJ82vocpVuQ4NFwQULT+SOWblUjKS207j1fzepapGi6I77j
         w+gPloFvm5dOm2ttI/NKG/OTT7Yl0lt9OqrrUJWugFfV8kbOnFm9XIyx2cxkixcEyx5Z
         0jCw==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZJAvjJ8LNQjA1ZVw9dY6mcBy3CFMw9VTWJOzUoXON8BwyjBkcZKmjyyfQyHt25VR1nlpou142rndFBzPcj/EIEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUS6/5xbsawnG7rXBS5LvQJZYuw1A87uwNGnlDpfzZkZcYDzv
	8GYiH8M3EdtzkwMH4g/TRbOGMm2f+D4/UoCpYQWlKfLzA6ygKf+BZPhI
X-Gm-Gg: AY/fxX6Akq9nCtzVvjIWrtbLmm271YA9tEu9dnw7iaBSz4B2947sQEgt4mi85ssMlYr
	0+M2xPjoAXsr3FX18h3nisAaBp+4wjwVM935GFDs8+c1WICOOglhCINXVVfjNFdkwoQELS3p6Rv
	naMxiaFMHY9FPNJaXCXJPHUMFJeT7eF7ishPiMqqp4cY5Xi+PEJFuSxunK+ilvmJg7+lfO6Mzci
	1W6AIh3tPQy71X3nh9QJVOoKJ6NV4Qas7jcuKk6mSjRPicCfjvVz6lEXO+o3LK8L/ONbCqyiqY8
	bCpzUNsp6urVqCz9vl5IfwNjRTGrl9Iy4DkPpztR3qd4jXn9k7FNVWot8kv+jUVEv9ul/jNGX+J
	gcaishQEvdFjUdOQ6ofWEeq8T0NR4dK7wD3kX97UEZat/LM5fOwHikSVzfs3WEcLBEsjLHn3DNP
	RjPCbCew74a7BlsPp+23Hoz0R1O+8KEt7lUOA=
X-Google-Smtp-Source: AGHT+IEE/qkOzQdehsR4JxutS5UUMjtZZSX5KqQIX0KxALxL/oRTRg+GqK0LQ65hB9xD4RLyoqIiJw==
X-Received: by 2002:a05:6a00:1f04:b0:7e8:3fcb:bc46 with SMTP id d2e1a72fcca58-8148b5212bdmr1895799b3a.27.1767430072502;
        Sat, 03 Jan 2026 00:47:52 -0800 (PST)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([210.73.43.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm42704939b3a.33.2026.01.03.00.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 00:47:52 -0800 (PST)
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
Subject: [PATCH 1/5] riscv/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
Date: Sat,  3 Jan 2026 16:42:39 +0800
Message-ID: <20260103084243.195125-2-ming.jvle@gmail.com>
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
 arch/riscv/kernel/probes/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index cc15f7ca6cc1..f0d0691a8688 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -165,7 +165,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 			   void *src, unsigned long len)
 {
 	/* Initialize the slot */
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 	void *dst = kaddr + (vaddr & ~PAGE_MASK);
 	unsigned long start = (unsigned long)dst;
 
@@ -178,5 +178,5 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	}
 
 	flush_icache_range(start, start + len);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
-- 
2.43.0

