Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550394;
	b=tqsrjZuhZJ1NAQC5Bbc8UQxQJVSDjLXW/Crcwut4ff1haZxzYIWjt868GKZ8u1yeBADQ
	 b5UbCl44XZ4Xiune1cpDE4Mo5HAGgAmEmIV2aGGsaA98cfeKIxZ0ONarLHGFRAplQI9kF
	 GIMiBXBVrLYq1g+LA3V9ABCZK/oNaedP71skvmqBhnM7nABKQyXSkzE6FSGaqRhb37eHC
	 ltEhGjtnG/jqgjc5+BZYZcNlmG8pz8oecKFb6TT1ucuD0z0SaTmDjTWRPkYKgvHox+jju
	 vccueT/l+N6CMlBbGY5HzSky8ktXa+73dWN/wMc0VtAPz9PUkCzttsmvBb2XrWlDA8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7QVMVg0G5DwyEPbJ20bA+yPvHu9eLQ0AyyKAfGn2Dqw=;
	b=dTLDo/PO11IsVvg6Kl5NlAQ3jv8bhTRJGJ7aTaw0JJn/+tRYywyoRiAUTMJEKgWs9/90
	 rhzTHhPel5EWAWd6vUU5ZsBeElIpl1lUmJOth5oqWRQRL3dLSl7VwbmyE+sS0HxBHYstx
	 Pmao02oNMZNAqq7GBIlo6e9TVhgVeQsCbespB0hyrkiX64nErQRGYbwMPzP8dGZVDcMVI
	 gAELoENCV3ma/Y/W+ptMAzR3iKcwHdMem43UX2MwFKAPwXeaSkAS29FrizL0grqFpb6Z+
	 4n5fsBo6OKGo/0sepdit7p7UopLY9sLbZjXglLfD5LSVfEVFK2nGhM1ZflP4SYp3dwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ENo5OMzP;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F160A260A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 02:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261F160A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ENo5OMzP
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917997ab0d9so2859236d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550393; x=1793155193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7QVMVg0G5DwyEPbJ20bA+yPvHu9eLQ0AyyKAfGn2Dqw=;
        b=ENo5OMzPZcp5RC+BQspbKtmEZf3CFrGo14C/peIMskwGJs7v/XFvBv2bJjCygvG/Fg
         yL7AS3yR6MODNEi/4L2NdDHdH1xDWYH7v2X1U8ICGauH5pNtzP2R895KFvm6U3uQhoXj
         LdbXzUTN3TMB6NI43awAOfWuY2m0VFBPTB32WasuovbFMwpjTibsvCp+6u4+QTsiurur
         gbg+OXFTuSLGe+vbKi4s+BE0S+vPUELkK5gbH5LWrHUWf/bgqKowp6Cx+zM0KEA8iCVF
         DImeI0nLGRtMWGr33ppVQE2bj/qKtNugO2nC8QLJOz4P4VvjcoKCWmHFyh+6vhd36U1r
         72PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550393; x=1793155193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QVMVg0G5DwyEPbJ20bA+yPvHu9eLQ0AyyKAfGn2Dqw=;
        b=OKpfKlUz0YX/nNL60HNv2YBol/bgsjPDulpJWQL82n4D5YwG97QZSd9q2sb7pND8Sy
         BJw8zhsthvS1aMhQSOg1vQLRvKp7Tq5fg1SKyLW3+hXK+tldxCmxAO4W9LMnsW1p5BZx
         W1gc38czal+xaocfdXam22y2/5oQgx0CwprvkGgkJLtvTVzLZxWkOUOlIkNzKOMX02sh
         0zxMaQIzxGeX367VqpIZiB4FliF3MATRIdUz364/fmW+JFTxoHkMlkxOQavIkSRsKC9a
         gNC+WbGEHwQRjdXnQRrPUDN9tnG7Xy8O7//85yp/TIxaphvkgU8sWRoX7eSxtM6lkNbe
         WTew==
X-Forwarded-Encrypted: i=1; AKwUvBxunY9POwm9oJ5CN64MsahA4gXiiuraUYCPOwBTalZBbmFipbVqEF2Ml8RqQ3wjMuF3rUBnWFLuw01huo60M1u/iUg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6IGBbrEZ85u60NBhq7B+t9q8s9U+qiUze9RxAALjTPhMoS3XJ
	zINMqfOZNJAU2HRzzV0KW0cbtkrbo6zbFqHbfOXFJobDE0plzdn/Kg++zhZC+hkoWT4=
X-Gm-Gg: AYBFou3ZcJpNzDOZExFURXZpwNCGsTm/BVak3kIvOQ8HqpjsDjs7Lg50mmnfY+/TFRH
	FgsJj7lrf1n1RJ2ygVYsioOjLkrXMyogq9d5nThazp22PHw/PNbRyrLws0UHA1krdYWbjZLWSYz
	LLUL7ZimvRK2UKtqsUsjLe0amAbLE2iQY7mOjRsHUSeu6DnutGGDrshvHvLiK26xV46PWjYh3jp
	X1jHp72HMlS05mQkRgaj9xeEU8cXnIcP/Lkfy3syKC/ttP8l2LXpL9sqnmzI7i7xUZSv2lxmvcM
	Y57sJIIpi/CXw5y/BXL+FDxJL48fXZj1mPUXxu5K/3kC2R/yJbgP/DwY0CpJ9qGqzzBXMCH4vAS
	BXz/nT9K9AM96LvlMBqC+EAInyfReZuuRCagfDc4SeFIKRj7YjT6K4SI1MicXQrYdV4VszrtgXp
	126xayS693UnOvrtiWWKrqxn7WmbXJ1Lo6UtSSDYXCTS4PF/QksL2G8tj1MTqHFgAsix/jxxSdA
	vdr8fCYszlXM3PkVu0lg003VFQtAsm+hRhjZGzLv2VEI4S8cpdhq2NXFzBv3WurXekVxif8pZ7E
	eZM9PWUl5ZQXqCioGmv26QNAkb+ecrI3MKvj7CY7rg==
X-Received: by 2002:ad4:5d67:0:b0:91b:d948:c415 with SMTP id 6a1803df08f44-91c12f1de15mr12928996d6.44.1792550393065;
        Tue, 20 Oct 2026 19:39:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:52 -0700 (PDT)
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
Subject: [PATCH v3 5/8] mm/page_alloc: retry allocations that raced with a zonelist rebuild
Date: Tue, 20 Oct 2026 22:39:37 -0400
Message-ID: <20261021023940.1940971-6-gourry@gourry.net>
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
shifting the slots after the new zone. A GFP_KERNEL request can then
land in ZONE_MOVABLE, and a nodemask request can land on a node outside
its mask.

The iterator approves a slot by its zone index and node, and the
allocator loads the zone from the slot afterwards:

  CPU 0                             CPU 1
  prepare_alloc_pages()
    first_zones_zonelist(nodemask {1})
      slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1, NORMAL2, ...]
                                        -> [MOVABLE1, NORMAL1, ...]
  get_page_from_freelist()
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    allocates from MOVABLE1

zonelist_update_seq detects the rebuild, but only the slowpath's failure
exits check it, and this race ends in a successful allocation.

Check the count whenever an allocation succeeds, and free the page and
retry if it changed, as the memcg charge failure path already frees a
fresh page.

The fast and bulk paths sample the count without waiting for a writer: a
sample taken during a write only costs a retry, and a fastpath
ALLOC_NOLOCK caller can be an NMI that interrupted the writer. They read
the seqcount inside the seqlock, because on PREEMPT_RT the seqlock
accessor takes the spinlock while a write is in progress, which
ALLOC_NOLOCK cannot do.

check_retry_zonelist() now returns 0 when the check is compiled out, so
a backport without the hot-add change stays harmless.

With kprobes holding the walk across the online, the base kernel
misplaced the page in all 18 runs, through the fast path, the slowpath
and the bulk allocator, and none was misplaced with this change. The
check adds 5 instructions to an order-0 allocation on x86.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1bb308296fcdc..dd8c9046f9a06 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4419,12 +4419,25 @@ static unsigned int zonelist_iter_begin(void)
 	return 0;
 }
 
+/*
+ * Never wait for the writer, which an ALLOC_NOLOCK caller in NMI may have
+ * interrupted. Read the raw seqcount: on PREEMPT_RT the seqlock accessor takes
+ * the spinlock while a write is in progress.
+ */
+static unsigned int zonelist_iter_sample(void)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return raw_seqcount_begin(&zonelist_update_seq.seqcount.seqcount);
+
+	return 0;
+}
+
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
-	return seq;
+	return 0;
 }
 
 /* Perform direct synchronous page reclaim */
@@ -5114,6 +5127,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
+	/* A rebuild during the walk may have handed out an ineligible zone. */
+	if (page && check_retry_zonelist(zonelist_iter_cookie)) {
+		__free_frozen_pages(page, order, FPI_NONE);
+		page = NULL;
+		goto restart;
+	}
 	return page;
 }
 
@@ -5198,6 +5217,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	struct list_head *pcp_list;
 	struct alloc_context ac;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int zonelist_iter_cookie;
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -5238,6 +5258,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	gfp = current_gfp_context(gfp);
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
@@ -5287,6 +5308,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	/* The zone was chosen from a zonelist that a rebuild may have changed. */
+	if (unlikely(check_retry_zonelist(zonelist_iter_cookie)))
+		goto failed;
+
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp)
@@ -5427,6 +5452,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		.alloc_flags = alloc_flags,
 	};
 	unsigned int fastpath_alloc_flags = alloc_flags;
+	unsigned int zonelist_iter_cookie;
 
 	/* Other flags could be supported later if needed. */
 	if (WARN_ON(alloc_flags & ~(ALLOC_NOLOCK | ALLOC_NO_CODETAG)))
@@ -5456,6 +5482,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	 */
 	gfp = current_gfp_context(gfp);
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
 			&alloc_gfp, &fastpath_alloc_flags))
 		return NULL;
@@ -5472,6 +5499,11 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 
 	/* First allocation attempt (or, for nolock, only attempt) */
 	page = get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags, &ac);
+	if (likely(page) && unlikely(check_retry_zonelist(zonelist_iter_cookie))) {
+		__free_frozen_pages(page, order,
+				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
+		page = NULL;
+	}
 	if (likely(page) || (alloc_flags & ALLOC_NOLOCK))
 		goto out;
 
-- 
2.53.0-Meta

