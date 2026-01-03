Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60F2F49EC
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Jan 2026 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767430090; cv=none; b=mmlDng50naAKsMHxx+d+NyHx6MIJi+c2OxvBbeR9OM9Gbk8ojNTO2D5cOa/lzTyh/1b4iCSV2hz45mAVJhSIQ8qRgpY8fM5q/GW0nGuAeSOQNlpXzlo1BIsPYIuXzpizCp1+EZhccNtLp/ssq0CA7GmeMhbU/gyHAvpUQMgEDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767430090; c=relaxed/simple;
	bh=xm/rDkVpNNqDrniaXUpYpfdxQGvr5ncLeT+0eKBuOOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjI6rnnl1QrxCufE0Y4LWM9x9YP0Ho06AIwVJimCMEN7yfhsaJDwQq+ZlXVRKC9TUQY7G0AJQzhYT3K2p0qiFQ9s7BQmnGUUgRIpNXc7W4pf9fjELolerC0f9mbMSu9KdK/p9lomb1zmfzWPuQaK5Uabu4jmSKR133tQuEGPMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOPsDNsh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOPsDNsh"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7f651586be1so232663b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Jan 2026 00:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767430087; x=1768034887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHUhniRWcOleZ/LWsZA4B498/r40yHnXuPYvUqkOFcY=;
        b=XOPsDNshZSFjL7QX1dgFmnLo5Di9/jKQLul/j0coKTsqBeX6Z/Gv7l0eBc/KiwcA0h
         dbek4L4GZpR/fs6Ys25KUX0jgs1tDCvq7ceXUwsH6we4vRwOe7R/JzyU9bjTOXN2ii+R
         yoP1sdw2rV3+Is5OrYbp26zHoDP1sm//LtkKKSdnV6Q6lph2qwHsLaFGr07/HcQRYKwx
         blzU0KAh/ky8OFoWLplwnfNVHEKVK8GhYUfmTDhFqXZe17FG7IF3LU9NkHQxR193qo7t
         t3ApRuP9GiYssNQq5CQthnGwUvMJsVpB8850tGpFQkRFHiG/HVvZPWt0hX0rBl/BSsk6
         oCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767430087; x=1768034887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JHUhniRWcOleZ/LWsZA4B498/r40yHnXuPYvUqkOFcY=;
        b=jM5hn0oBtonX6iHnEU+R1gFUqPwEk77ComBO6zZfY3ljM1BPkNfjjXLoxxGFbTko/w
         pLcBZj3bn0uriLtIq9o121ugdCIBzc8yxJm2Dvd4A/PjpsmVjkeIrlOX1ylROvuhpy89
         4tFvk8rp5r9z2ZE8f3+G7P2q9wlHyr0moNTamaWSugmhcirVpa/G73nHe2AiD2uzjehz
         jpD+A6F8IUuHgcaOF7u2jS3S+UH/vC5Phnt+cycQM4l5+hFtLPS1gFECxfefKYQWMRMj
         5laE2QRK0tJs9NZin2EAhNDVW/UhPifzyyT/jOhTHnfYeNoQnNFDkN3RlmaBFMYRMNpS
         Sq6g==
X-Forwarded-Encrypted: i=1; AJvYcCUemowm5gY/BK0jrDk5oCYo+SR8U8zdo699wu3gwSmOBdIWbbZ5IxqdKjIg1yF+MvuppPjHEJlWJI5kPxvHuHhmNTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9HAA2PVG5HbsnKVqENi+GkdD+SoRQD0bFhcgBokle9hWC+sK
	286zjH3qhrVDOpoIbXMZS/yPxNRV+U6OLVdVWAOdwY+c8oJr4JtH18QM
X-Gm-Gg: AY/fxX6VnvvtoYvuKCOywWpzEs4wW/rGgk62O8GKYpHDoedvJE1RIdsnLZr/R05lKh+
	pOLOCBPe2IJ7dfIGS1H+BF0fp5UBNLkZDEIZJwgUfTORzDjiV/BytXu3e6PMdRzSeIchuSmNbxV
	GZAMhr/D6La7ZvBC8SPMJoyGmg4W0q3FAHSeJZmkX9x5QWQFikdnnVBBszSrRSFtgn+8OUKqZRm
	5IPEJL9t7iB7CsRqH1Nt5f25ymXxINF0veSOynW6scqhnafEIDJegqZmOyUV0Jus21zQJP5spz+
	C6wscdqKcTWk3AF8WaVnRwoRM0HE6C74Jd7PJsTz9ARin8gA4eLiHQUi91JkEYmbi/quSSSb5mB
	T2qLfvkop1ROF6MdEXClfjOvMHYp/cJz/NYD7iGX8lunZP5VHywRDXT6M45uN7f6GAZyY5QqHz4
	x213+laPbrZxJFgl4j/E4ylokcDFVTQsAgw/Y=
X-Google-Smtp-Source: AGHT+IFoiqDv7u4QVwPAsnB9Ilz+AGYXHXN7Krwf9OXzvHcyBpVKkqOp/lFBq/KGwKuFExK695g6Ag==
X-Received: by 2002:a05:6a00:4895:b0:7e8:3fcb:9afc with SMTP id d2e1a72fcca58-8148ba1ab36mr1175712b3a.18.1767430087435;
        Sat, 03 Jan 2026 00:48:07 -0800 (PST)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([210.73.43.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm42704939b3a.33.2026.01.03.00.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 00:48:07 -0800 (PST)
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
Subject: [PATCH 4/5] arm/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
Date: Sat,  3 Jan 2026 16:42:42 +0800
Message-ID: <20260103084243.195125-5-ming.jvle@gmail.com>
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
 arch/arm/probes/uprobes/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index 3d96fb41d624..0e1c6b9e7e54 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -113,7 +113,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 			   void *src, unsigned long len)
 {
-	void *xol_page_kaddr = kmap_atomic(page);
+	void *xol_page_kaddr = kmap_local_page(page);
 	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
 
 	preempt_disable();
@@ -126,7 +126,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 
 	preempt_enable();
 
-	kunmap_atomic(xol_page_kaddr);
+	kunmap_local(xol_page_kaddr);
 }
 
 
-- 
2.43.0

