Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3B2F5313
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Jan 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767430096; cv=none; b=uiyLh1TVNy6gorS4tON8mEWTqpPRZ12JXFQeocuaJe2wXOMmzQfeASrgro7z2lQucBh/UJZt9HnDpswiGRzA++BOVTjRVOFxPR/S9T6SoMoDbgzhu/Lpq20LBmW1vu2ZYWwG01003UIuniUpoc9GSoNGOLeMpT21ZckBEAqj19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767430096; c=relaxed/simple;
	bh=oIgv/iap6eJUypBzfrXqBPY24iAvY6WZM/n8hSDWbD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0KTBRhEJUvlQZsYO2pUnRiucRQZ/xROiny7W1c+5Jm8d4WHnas0N7qnEpEwk+Bkjv/hKIpIdSrpslT7UwZKAgt8e0wJEraXSr60IzmhHdpnWcMuUkcu+mGyh/43nrBVfPN0hFALlU+eFE2TfKuqPDqeEicDwJhaH18z6o8kdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bilx8RtB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bilx8RtB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso10066982b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Jan 2026 00:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767430092; x=1768034892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNQtBvCUtmnAPeuru8aiLc1c6bgNqqxLSRGoZ3PSDyY=;
        b=bilx8RtBmkyiCfSsTQVLuz0FN3P+m625t1fYEnRdOwgYe/SRKzZKRM6N9yIk7cUO4d
         I6AMvULEQ6G+E2Z0i/6KfVBiYgaTVS5SI+xe6pHQ2zC8n8upoQxIdb5yXU/EatHFGzLO
         SG2PtaFj41WVpSUHLtla78uZN6+KH8/wJfVsdo6k+sxMCuAE5ihvZXMwFIlEGoBB9SGj
         s2BumkGobJrg5g4NNPqOMzofjaPwYxUWP9IcEBdQ+WVFgc9WyguoWbwgb8hqs3UyqTba
         WHniO1ywZqeKX8i3GeUmBEeXQHgW4+QIeT3U2V7EYciY6SebbWQ91B6jEeEOw29qkOHr
         +xLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767430092; x=1768034892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zNQtBvCUtmnAPeuru8aiLc1c6bgNqqxLSRGoZ3PSDyY=;
        b=JZVatXF3u4v6rCokmgN1rZF9iSev9ZKfwuT+opDiTfWE5vbSBM6hs2/tj5bsazt7j/
         0OZ+JHjaMtJ9HqC7hqvaGDDrzkAVQJlCtbjetC9GjLmD5FZ8rkxCswjTJtl2SyMb93iO
         vRMTjBgh0yBMYPdlEkQIzIPJWFX3y+6oeMXmop4U/NDBFq8ak83pFMR9JMFaDOcNuEn0
         /hWeHXo2yKSF6kUmk2C6bTjGsBTOtHU/s7yKTTAOXdAQoDkocC0M+4tNnxiqFF9Ph6Jv
         3HnnxzVDdoknVVLZ04umtJL8vFGsO9Xf0ooqYovAutLtYxG/l41+aTEOAwCFH4JtoBWe
         N+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXPYsn6w4r7UpHwN9DWS8B9all1id5ER5krOCg3KxDBoDu+MdXU6Zc6lrL2AO6xCB9gX4RmozQZOvPg/s8+yne9N30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNbPbvDXaaoHzma6QVOw9bMHhnVRKPoZh5ycHq1R2UNYMHs04
	HAMxtUlHhzP+yI9JOdYoTc/DLWLNpH/ByQpA4MoYKq6TbK7+pAb0AuXi
X-Gm-Gg: AY/fxX6PmQEVhJE1PATHX6fyIbjYu/t4K32ySzd81KO5yLRORRP15TBQowbC+iLkPlE
	OX/bgMBeJvdolYjOlIgeQ6Ute7yE9aKQkusKaEuWcUTQi7Yk1iJV0+jvFpeaFuFDXceD3BmrR6y
	qTh6PNnUzzRzfF09e9mfs4glfjjd+k0T6YITZQ337RH4//cM29SJ+LUOkcesjmAPlyISD4xdk3k
	v40mZnIhszRVQrKFGGpxo6e9tWVQtYmVpnkeOrUwV2b/jR1NzzljDM6vEQmqvTxa5fnfeMb7+GD
	+HEILxX2R4QyvsuXOvsSJlmQbPV7HMg5uyQin8SvHnzzrxAvXpcMIcQ83QhiA0+GwYsd8RiPMKV
	u51RmCR9/gn+TZDp5aAbbx0gnjD/HKs0nkWqmqxaMVjYQC3msONzcQGUmrTYIC7+6No9387fD4t
	pjF0rLzze0jAXVBDKLKHjcbj+/wUsT8UHSm6k=
X-Google-Smtp-Source: AGHT+IGp+2Ae35OlKcY/AZO4SFhsJuhif38Zo263lmc6gG+RjhGQaVQCgX9rVZBWLxbZMYLURcJ7SA==
X-Received: by 2002:a05:6a00:e11:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-7ff6421137cmr37196936b3a.12.1767430092345;
        Sat, 03 Jan 2026 00:48:12 -0800 (PST)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([210.73.43.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm42704939b3a.33.2026.01.03.00.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 00:48:12 -0800 (PST)
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
Subject: [PATCH 5/5] uprobes: use kmap_local_page() for temporary page mappings
Date: Sat,  3 Jan 2026 16:42:43 +0800
Message-ID: <20260103084243.195125-6-ming.jvle@gmail.com>
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
 kernel/events/uprobes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d546d32390a8..a7d7d83ca1d7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -179,16 +179,16 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 
 void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
 
 static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
 
 static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *insn,
@@ -323,7 +323,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 		return ret == 0 ? -EBUSY : ret;
 	}
 
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	ptr = kaddr + (vaddr & ~PAGE_MASK);
 
 	if (unlikely(*ptr + d < 0)) {
@@ -336,7 +336,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 	*ptr += d;
 	ret = 0;
 out:
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	put_page(page);
 	return ret;
 }
-- 
2.43.0

