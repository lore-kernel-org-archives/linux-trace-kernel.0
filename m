Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499244;
	b=V25YEFEewO/h3loE0zsP0V9LFkCqmwdE4ogueK5/UYJ/HyA858mY131mlV5BDz8903bx
	 8IOJpHxwkczbfGkkrNYa59weKFKAyvZwg3Olb4Wz31MUxV2BRImUlXFlhYeB9pmcNmXBv
	 SlLmK77EjtuTRMZAfErM9mmSOOIlyMkm1lvSVOKNTy/x+e1dsHf+36se6AGCeJfgp6QjJ
	 l8U9q8RjSteJeSmRs1cQ0nCfD7Iv/1CPNOkGZve1Yzsw9BuidNCEgqVYM7NSNzq3w7Bcq
	 Gn5l0PrM2wgZ4ANnBRFtplboOLWzNCNZEGLIvap7FgDeS8TZkUbC68JUdgpjrsn2l8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o3en/0J1kDOWu6/ZYZuTg1hfkkAOyFwxacReoQ2bAwQ=;
	b=E/SQwGVzAZe2iVpkjqPTdJpdhPzxgPRm/rBsY5GKrzt+G27QbOzYLdA5QhAJGE3G/gfn
	 BPivcDpIyM8is7Khu78R2KcOMyBtRLpt/hq6S+kF90UGGR70Csqcf8fTFCVcbhZ2r4dKJ
	 kuttXGEdzRu0x98r6b0Tf1n5sQZw4aWKoym/vubAyEGc/EJaBlBtV+3DFueEB15REymgf
	 WMqzX42xaw1aQAqu9C+vGKtfi5+ldf1bANyXI2ofoupoYasF8S0vyEGRz1w2FaVXDZ+2i
	 Cbol6R7bFw47GLpBlazmR4Ax3t5t49J5fSoHdYzMmcdMt5Z3HueMTrpKr9l4Ut1XwKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ECSWl59A;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A460A262C
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5A460A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ECSWl59A
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f20b304c0so182783585a.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499243; x=1794104043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3en/0J1kDOWu6/ZYZuTg1hfkkAOyFwxacReoQ2bAwQ=;
        b=ECSWl59ASRir+WxMsRUpqx1GkxjYPudAMCGYi6vwnEhsIg76UtVEhov7IxG6C+K2Li
         2WYVSGxom/iA0/OKDkKWNhV+yn/YAZBGyu9JuL5CetGtRtNtoS6RC4Lh64zHjbrsnFZt
         b7JiAubjFuO8jQOCAsHqtWdA4UFUpq7OugPBIvzv2GKOc3ZFEIRSHIxrAW3waBtHwv90
         SAtrfxTK8VeUUsJze/pcDzeyGD61NhFSp/abaGOGvkKu0DQG+S7SDpGyGGiUrRcEkc8D
         LO2rdjjqS9idGwqlufzSyhIu897Nfnd23zNnL5MXOho/ZbsgfzaXs6jhymAG5Iz69QO2
         UWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499243; x=1794104043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o3en/0J1kDOWu6/ZYZuTg1hfkkAOyFwxacReoQ2bAwQ=;
        b=K5/xfyimB3NAFHssAiCB2vSzsBc/fdzRyYsf5vpjBJldfRD+yVHP70qmGECpWnVIyR
         qKy4IZggY4voftfWC9t6B06JqlNNlQaYSlWCXLTmrnSZC9pB6M15zbsHQXv+pJuQ33J4
         0zNHgRzGLZN2Lm3L5vjZSW01fdQb4ynoM/jvPypOIBB2bf2n00erSAHCxN2YoOzdpH1E
         KU7j4kaxHmZI4FxbMgJC0+JSZORSnsz7rvyyDHpv5HdtmiPiDASrOnfsrsqs8tfwg7Ru
         YqO4bfCjO7cXRqrt7UOZb2L0wc0yqlpXYPjT4mtAJRbVlqEyR21jFRH+C3ZClbpuz1eE
         NDeA==
X-Gm-Message-State: AFq9FYLoFU1wCJ4VA/MM0S99xNwXslTWJbtGThX68m2FIxe95S25GItL
	zIeA4+n1URhlaIe9VSSjOd7k1pNQrJ9BiUZxZuS0J7zE1qjlxC2mxJ6AIgjPcKKq/0Y=
X-Gm-Gg: AYBFou02hiItvF2fWyDjaKV5tw9xl9Go7xvA4orlOQx7XWMBtDEXdJkFWQ4fQNW43X8
	Uyb8pbREetFKYKp+Ry9UxMkPbqDC6p55S4ckWYApJCdlLHEhcurgwrY62AUiR0qZRdAMjRvcXru
	QhoTMqMGAvWMsr1Cv336bXMwYKP+W0G5oWQkJB3b+ywoSmCwVKjFrAlywP1jExrro/6SjiwzqIT
	N9UCCc9z8tixVBLy6onB5h9ffyMMpiALA27wYDs2I4krWx1NfragSG9dw9MbDmRA4juRHOWf4J3
	V8nwp2CPXHhOKSkPDTagp7Xq4ogFIxpp2irm7skfQ/OA5o6MP4UewPFc7XsNtaCfiCErrHovlb4
	vI0GbsSEHLWrHwP5CJTgwdG3TrOzFor/CKHmJ0J75Xbc4a2ihrp3FrGUn8o6NlLnbU5z/TbMMGI
	pNSHPZbh1BY9+whVIDlRuyX+chTypT3gVrlDMnrMrWBJyqFq/q7plNxZqVDF3VWtjvrtgKHNOpB
	fJzhFYXfPJHsj4nPaUb2/hN13iNuuwQ/vWAeTkZdlNbXeimKgUYCKEjkCootV3dh1YdNhRGhBDj
	DWpHE1+mUsDSN8hVqdn/ZiT+ofWZtRLo7yfi7wzMedJQRmIbHU1JNN9aGDmkuBYbfet8vkY7WB4
	nkOFYPLEWTA==
X-Received: by 2002:a05:620a:44d1:b0:93f:2a56:2772 with SMTP id af79cd13be357-9442176a63amr1067445185a.78.1793499242716;
        Sat, 31 Oct 2026 19:14:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:14:02 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 10/12] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Sat, 31 Oct 2026 22:13:38 -0400
Message-ID: <20261101021340.2251928-11-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone.
alloc_contig_frozen_pages_noprof() approves a slot by the caller's gfp
and nodemask, then loads the zone from it:

  CPU 0                             CPU 1
  alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
    slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1]
                                        -> [MOVABLE1, NORMAL1]
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    alloc_contig_frozen_range(MOVABLE1 pfns)

A gigantic hugetlb page can then land in ZONE_MOVABLE, and a nodemask
caller can get a range from another node.  Gigantic pages are kept out
of ZONE_MOVABLE since commit 79b63f12abcb ("mm, hugetlb: do not allocate
non-migrateable gigantic pages from movable zones").

Check zonelist_update_seq before using each zone, and restart the walk
if it changed, as the hugetlb pool walk does.  Check again before
escalating to the pass that may migrate hugetlb pages, so a pass a
rebuild cut short is redone rather than escalated.

With kprobes holding the walk across the online, the base kernel put the
1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
ZONE_NORMAL in 3 of 3.  Direct GFP_KERNEL calls with nodemask {1} and
{2} got a ZONE_MOVABLE range and a node 1 range on base, 3 of 3 each,
and neither with this change.

Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 242bef2fe400..91ad979409e5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7570,6 +7570,7 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
+	unsigned int zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
@@ -7578,8 +7579,13 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 
 retry:
 	zonelist = node_zonelist(nid, gfp_mask);
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
+		/* A rebuild may have shifted an ineligible zone into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry;
+
 		spin_lock_irqsave(&zone->lock, flags);
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
@@ -7614,6 +7620,9 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 	 * second pass, we will try moving HugeTLB pages when those pages are
 	 * smaller than the requested contiguous region size.
 	 */
+	/* Redo a pass that a rebuild cut short before escalating. */
+	if (unlikely(check_retry_zonelist(zonelist_cookie)))
+		goto retry;
 	if (skip_hugetlb && skipped_hugetlb) {
 		skip_hugetlb = false;
 		goto retry;
-- 
2.56.0

