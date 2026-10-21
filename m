Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550398;
	b=exR5B66rdPITC9RsdEYp+KcNVuXWEg7ebbm8mirsMtf4ah4G73T1t/KDLrJH2rzzGJXE
	 +P+FMlUgd/Ctdms+2QL430SGcHb3PfrSmatA0cv47V6hC5Dxol2Nfg78P7rpHjSHEP8zR
	 SLZocCiF0y6ULuCxMkyyuqVqmb3/ZyXBhKnSQ8uUxNacsqqxVeH4bcthaKGB5cBbGcEJh
	 mHXx0zlbKxAtwTUknntGeHWEhFqcRDhSMyTgrFYrsa2gp+BdcnP3IdFkSPAHiyV56jsKm
	 a8p1SqntC1uw601n68i8USPZmrnXmJwUWT0YOxMLYnUIVrH8UWFrOgn4ju/FF7kwEHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
	b=r4+M90KqCSeqfPNxbKsYQYfR1RPNhPU464tt6DEqG2RRm17qQnilGNdOnvvzI1YqAE8U
	 PhI3X7aVoRCczvvXWsFBnLYAj7JJMxJpv3Q5buwwfA3Nks5HNTIKJvIOwr+H6Wvu6HIOi
	 P5gChML0PeBltjzeWukQRQ2e7oOuFy7IOj+74mURliDpthQWosnA4PaAPxErW3gmobtbd
	 928mTe/BDjD4kqzX2vZu1ztYnjOtOMIFHSfPjPpnI+XCoTHOO3ZRBbULFOgIAHqwPklvK
	 c7s1WnTnjOIYAKIIMSpS2CULGYhMgLlC4MypkdmYJKOmsD2oBdPSHZlHgHHCYK88R/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="F/iNkFBi";
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026B606A324
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 02:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0026B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=F/iNkFBi
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-917bab38b14so2939116d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550397; x=1793155197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
        b=F/iNkFBirVBfnEafRXRu2OPVpKI7JLXjC30Y+cUA9A3n3yEkVflguQZF1gE6lRAn2k
         GOEWdaKODhaYPg432iFYEIGdsEk8Xatu7sp4ximEmgCcPgRMgcBDV+gvy+scaf8JY/0B
         OzRjY2LqWYHF79W/19hzAFpn1YaMszY8HnBPspNTehrxQ0aFZvVjI3pKBA6xEcDk2gTi
         si4VT1SdZdUFCOe3uLnxH3SXIjhcL2rqWwijdL3gxx+4UnxBvu/AXv6Jtm65keyzQwmY
         x4Qlp7VPSOWaMtixpJLa3iU2ssaHz4FcIeC31LKws18BR9zYzNaBu/sfIjeBcr2knfYK
         mywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550397; x=1793155197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
        b=h//d6+jdeNS9hrYHUuo+U/k2ZqJHN3n0fHVGC8AtE7a218EovfE6mvFUaT41zBaZkI
         GQoWFPZ+9OJwP4uR/pEEA81TRmkLx6Vx0McGjCwTq1eAvimFkrEk4MdgUc8aqec78Ug+
         83BUgXWvRy77dntq3oaKQHEfnrC1SVKDNHp/PCRYKxmtDQseKp7qiup3VKwl64ZFAfFc
         B0wkLWK3WR/0apgOQBYZQwL0UXM9ScyV2WFMcUKdpZnymUyGQPldroLgfkmrnULf6fJq
         N+uhIIleQ8N8awjvz9gLkmhyySagejZl4YlznmZp/kszsEdM+Eo8uBRtviS0gCqTwRtL
         2JRw==
X-Forwarded-Encrypted: i=1; AKwUvBx4WCa4r5jtxbHoGH4Mr6BH5xpRLCVx6WU6Jlb5BuWwLScOX6dxXS5Bzz5pAOVyKNhRYaTzddnox2SrUqc1ZraDefk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe5vh9/ypDjscUGRtAu3ZiRjhFwVZEdQkcJGWVM9L4KfZlMZTw
	vzI2Au3f+S0gux3jP8XiXfiBUvh2LyRfrKShgX4eEDPwReHyc9rpPnM57jDqjUHG7HQ=
X-Gm-Gg: AYBFou0PUzuNHFd+kDIcrO2AVTaM4mPf/HvWZ8qvNBYAALuIjFV6jbDbKg1TR2O2USk
	hO1m5HGj9cUJiG5ACkL1q/t2lb51lvsb9XrPQRIZsvRUk6ZhKAYjJUH7pgWqsjr6qMkHLU3iGh+
	rioOIt1S4GKSx/yLOyGyeT2knUlHoWBcs++g8cnA65p7Fu1ohy9zIHbE/E/zZAkaxt2CQF6wS2F
	4FCPvrI7T8Bd9zKjkoIrhE54tJfULUwOWSgnaxz1QWjZ/3mz8fWOmgoInt/37Pr9tXDVaheiHwE
	asNr5V+5eK89HLBGuYf30nyZ8P5zwC8mNWhHGOpMawLLrmJ+P55apP7/y+OOLojtP/DIcbvc1rW
	+gB19YYfnJFc4DrMFYND1JJVcAwyjswwhyQWZEhDM+fr2Cw1g6F7Zl2qTQu0MOowevKhBZ30t/v
	WWxlpLYSn1JBtQ1GrIhDc5Jnt8RmVyFFQ0X0WK0llCoOnUX/YyOhwTNtG17MzPT3S/IHTkuSjLD
	ttb3Fo+De7l8fcA+/Jl2vfx/TnFpV1cwgwN/vYTLQ2xucyz0z4nVMiq+6B9lFES5cL5xNo0S+z6
	xQW1G1MWNFcL2bgnx7HyJsa2TsPs1yasqff3cmknXuTTFEwx+pjHiDIGRb//zPc=
X-Received: by 2002:a05:6214:300c:b0:915:eacb:cb90 with SMTP id 6a1803df08f44-91c12dfef37mr14292296d6.5.1792550397043;
        Tue, 20 Oct 2026 19:39:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:56 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 7/8] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 20 Oct 2026 22:39:39 -0400
Message-ID: <20261021023940.1940971-8-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
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
shifting the slots after the new zone. alloc_contig_pages() can then
take a range from a zone or node its filters rejected.

Writing 1 to a node's 1G nr_hugepages while that node's first
ZONE_MOVABLE block comes online puts the gigantic page in ZONE_MOVABLE,
which commit 79b63f12abcb ("mm, hugetlb: do not allocate non-migrateable
gigantic pages from movable zones") excludes.

alloc_contig_frozen_pages_noprof() walks the zonelist with the caller's
gfp and nodemask, and the iterator approves a slot before the walk loads
the zone from it:

  CPU 0                             CPU 1
  alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
    slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1]
                                        -> [MOVABLE1, NORMAL1]
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    alloc_contig_frozen_range(MOVABLE1 pfns)

Check zonelist_update_seq before using each zone the walk returns, and
on the way out with nothing found, and restart the walk if it changed,
as the hugetlb pool walk does.

With kprobes holding the walk across the online, the base kernel put the
1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
ZONE_NORMAL in 3 of 3.

Calling alloc_contig_pages() directly, GFP_KERNEL with nodemask {1} got
a ZONE_MOVABLE range and nodemask {2} a node 1 range in 3 of 3 runs
each, and neither did with this change.

Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5ca8e57c5fcbf..96ae09c8099be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7592,6 +7592,7 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
+	unsigned int zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
@@ -7600,8 +7601,13 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 
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
@@ -7640,6 +7646,8 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 		skip_hugetlb = false;
 		goto retry;
 	}
+	if (unlikely(check_retry_zonelist(zonelist_cookie)))
+		goto retry;
 	return NULL;
 }
 EXPORT_SYMBOL(alloc_contig_frozen_pages_noprof);
-- 
2.53.0-Meta

