Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B9256C8D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Jan 2026 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767430079; cv=none; b=KPIoXmtnYWTBfExO1a7FzQfCz23hk8rA7NCUNS7UQodB3hDyKP24QOksoqxlalEuU7mgfGZhmzpmQREUI3cpYUNI8AfbRlG1kvqVChF45XGKvYmbEFNdSjyy7NR1TgT8+nPaFnqjPDO0xaKx5iG4KVuTf0mCRXmiapbveGTmhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767430079; c=relaxed/simple;
	bh=zLuwregW6aPF+bcK9tNXHz3bXvv4OHq25g7xGPW1gMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQPXiMsuCSXWHPIu4YdClhxWltZe/mqURMojJZfBhLj3O3p2AZbIBsmkJTNXFJRHZ5x+DkpuzHP1y+P2+qooirL29uZhE2zkhsWrCFrtOnhs5WITM15xmuDMmwMUziusVWENVwjbr5mWUDOMJv9PW086CNKsNnkYUUf4e9PYpPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StVzVyqQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StVzVyqQ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so13397448a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Jan 2026 00:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767430077; x=1768034877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqmOWnbBqbw0qz0iwR261elwKrPwnP+8eo7jB++6bUk=;
        b=StVzVyqQZAfVw0hUZpSHha0ZTFztw5w/soY9ezi5zRjaTHQlKogJ2nk1KvEo+2Tupz
         /Ajc6DAxP9dQIUrnj0wgIo4kf3qSjDb8pgncyvkQmUuWUeBXmK5rLFaee2OI4qYuitQl
         xFT9Rg202ZgJfswhpQbfjR8hNPyU5lpLro5a0d4xLA9v9EVoPEdZfHpazxrndbdTmCGC
         cFMoNQinGQuiH2VGtW61o5vCF5ed9eGWVpfNvFjOxWYUMwIZjGwfRigFglhBqjEYRueg
         jCkFvheyYai5qoqzfs0L4lGYsSPUOfZg+Y02ui5y6Rv1Ur+Q2Ql8ZdDfhqMKSSNdo972
         SgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767430077; x=1768034877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqmOWnbBqbw0qz0iwR261elwKrPwnP+8eo7jB++6bUk=;
        b=kFnyPXDR5S4X9H3u0OlADntqe+Vyn63KuXvzbS73+/6j4J9X2GDOqAnh0PuSn+eGyC
         mG+Io25XC0nTN+dJHZTol85ednoKG1Wt0QHIFehu2EOUmcMjxJswrUhreywjHfIsp70n
         raRC9KGr8n4Et46b9z8myEaesbErw8XcYEdnP0JaboEYm2s3izWm+Ey3I5ZYj7JJt5ZK
         Smh1q0r9Vugj0Xt8f0JX4BIw+5UbZRfkqUAu1KfS3PDtuMRtugu3bAOkst0xQXbzWPbk
         M9Ie9UsPxyyJLYF3z3xdEmllqa5FQvkue8iAUV950T4+SsMy8AiQszKpe1AIMHBGuHB0
         9WQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqrzeAvmCAB/yFt3Dp5DB4b30+KQDA0oVMaWzm7Ol5ZgDH7VDHjiuxmsRQHL8GHrOSQ0rp8JDQZ7QTrz8gRgS+jP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EYBQjXNXEZX7N3PLtSbgSqGVpBvp3SQ80ueLbPaieKxkpIQV
	tVOYhwTpeGIelAXji/sV4IPcw/nmjkvzonJCfJ4xnCAyx1JDEUAu0Yc4
X-Gm-Gg: AY/fxX4gsF2CaDejQBXxjjAkjyXVQPf5p6Yk1B9m6drscaknsRrCVDUxbIydUAsMBO+
	J5/Thzf3AJYbIlwJP9h7Xc5fg0ozbkufdDiPMk3z+h12FbGrIw2aO8YiGQss7S4//lj3XOYqqoz
	uEqABGXwoX6x5rS+WNFr3HGzK7H6IDW3dTwAUmlbutiiwYbXRZqHgcehqgqnky8UW30i8vqORBo
	5LN4ls53K7v9V6bhbR/S1/Kfnk2nvk5F/QdVxZh/T9Y8pK9Q/HSNJlQD3aEz817jdnd8mzf78Ch
	JjstPkyU/XCDVcVGfnqCIHNNnp6MscDDF2+KGtTRSDEPiU90inFezZbL/+18SGR/OW7mwkQwgLv
	tJKnY+0pm6/FVssd8UXYcN6ZHg7EgoggNPDxHqACEbtFjYdxN7AYASbvfDnmb8MLXz6nGcfywjJ
	flnElnwfxsAs/0tOWOuFo2KcQb7qRSUujPh9c=
X-Google-Smtp-Source: AGHT+IH4FDI6MNb+jt4Z9VqoK4GzC1dQlMhMQECNsnvlTczu/ydbQzhhClMmRjiO1aySaBttAjLuTQ==
X-Received: by 2002:a17:90b:548c:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-34e921e90e0mr31635393a91.32.1767430077312;
        Sat, 03 Jan 2026 00:47:57 -0800 (PST)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([210.73.43.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm42704939b3a.33.2026.01.03.00.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 00:47:56 -0800 (PST)
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
Subject: [PATCH 2/5] arm64/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
Date: Sat,  3 Jan 2026 16:42:40 +0800
Message-ID: <20260103084243.195125-3-ming.jvle@gmail.com>
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
 arch/arm64/kernel/probes/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 941668800aea..4c55bf832ec3 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -15,7 +15,7 @@
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		void *src, unsigned long len)
 {
-	void *xol_page_kaddr = kmap_atomic(page);
+	void *xol_page_kaddr = kmap_local_page(page);
 	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
 
 	/*
@@ -32,7 +32,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	sync_icache_aliases((unsigned long)dst, (unsigned long)dst + len);
 
 done:
-	kunmap_atomic(xol_page_kaddr);
+	kunmap_local(xol_page_kaddr);
 }
 
 unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
-- 
2.43.0

