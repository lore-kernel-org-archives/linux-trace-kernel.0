Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499231;
	b=ph1szE1Q5EuoWK91CxKL7DirzB/R1TF4KnUkIjW8QVPFjdcnR2Oj1UmwX8mkg/9dXlg8
	 RacYA7Lkn6cBByixL36MfjHvjwAwSp+U9bW68H/gfZI7t9X6cK5Rqkfzi3dsuubdCEjCo
	 gYqne6L+hQ/Xw8psx9OZIjBQyey/b7Md787E6xtz2nYCNIUKBzu/sXsfCQ9YIYWth1Upz
	 3QaAOwABKQaHdE/rdaLDObYhSH9pTYYjijfgHNChJg8Jv5tPhFIhv8jkMCcnDaW0YnpTF
	 KodykU3Qrdy5YO66yWMTnnXs+H0igbKDKkMnp1nrfRwBYyJBPjnZ8do939waF3sNyoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z4rxIRaCxnrdC1SqVr2USnkLP2QgDb4JUWWHxADVHGo=;
	b=m1OHXG0k46wR8MBgqmQFLRrDO7JBx8WnGKJjo/zy+gd2FkvkqWl+HiEjhrMWXNnvOmcp
	 vsaR7CRwqPOWsouBK2afOZuKL8Wpzogj3a+pGQw05KDyGSi/R761fNhf0lEoGunDZTam+
	 viyJfDIqPBf0ngGTMZq2RpZeE1yCx/7y8C083MR7CFPHpc66IUevhtz+UQy7RrnZNuW11
	 /BlCq4KxWaojW6hMFh/r904EYfhHrQKHgBUfKOiqYTAaLsq5DaPnwpX5XOAs3oD9jqOm4
	 wHVVxgv5iZ7FqpSdfUY4Z7rxEvsFkyqz4R2qHBue3pAz3YsLIfOKD5RFpUEzaUrctEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Lbg2F140;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB9606A33F
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2AB9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Lbg2F140
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f079a63b8so198583185a.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499230; x=1794104030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4rxIRaCxnrdC1SqVr2USnkLP2QgDb4JUWWHxADVHGo=;
        b=Lbg2F1403q6XpzKwEZAwWFPs42aQyaQYLUByjOB/Ad/EZMXWJ4DhvwRBk8t2MDtp2a
         sg2AnSSfb8cEu9XhQQbNCjBSD9SMY52O5UIrF24IaazQhoDtWU3jSBoBFNftM+MFOlrW
         gvjncfZUmafwmwTflLcOApw9/QBEVYIlMJgsNFwBfcevvLVe1ifR1uhagKmNZYUUoJLb
         SzW0VVjO+3GMQzBqLPc1bLloL3vVSJuPD3mN+fmABkq6X+0NfdYROZIaRb5PMDy0PNEt
         e8xtBlGaYE6Xs0EGAO7ZYEYcqVWpZJUxExAUnHV8u6zBU81IJYN/SYTpEG6cOI+JnwBX
         JtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499230; x=1794104030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4rxIRaCxnrdC1SqVr2USnkLP2QgDb4JUWWHxADVHGo=;
        b=TbzOFwcBZeibCZ5LvbnM6iRnwdqo8RW+iFwfvgw1Qy4CUJoSQDDIotuXl208rx84s1
         PpFzVuCNNQHLzwsqPd9RGDlAK5heaY+7Og0Hm0Zc+qHD07iHUM/EW0bPLUVdiDleBdk+
         dogSvXaGRBee+9vkOH4n2dD01+IljkvResUXtvn4W1QuK93rCWp0qUoNNDgAbShy04KS
         InZEfEzGmOjoFNNHH5SQ8K/Osjf8K6qhuRG9MqZOQNbzaIct80yd/TYDRe0blDXXPFyl
         XK4z/kKkO+re0e2e3BSnLpjaPQBtKOlYSl4IRpmQmco0VHQBkTuvC1KO56lkiFWx5ijM
         YaZw==
X-Gm-Message-State: AFq9FYIo32NccA5eHu2ogz0r+ps1dgO4VA7UcUQW9YVEkFPvuC9RgvfG
	pMyEznRQy8i1dcc1deiU4Q37G85lkCp4BQ+GqKgOV/e54lHsnEkXO9i27IE7uFmV/Gg=
X-Gm-Gg: AYBFou3bvKfeD+bxDhiBXW4WrPeGWYE7VOjudr5fQr2QSz6tLSGJpzt769Eia1ySwHg
	EAbeZvYmgZxnlbPh87vdFcB9ok1/jwzhQGQGSaS0ZVHYLLUd8UKjshszzXC50DjvnM68Fh4uap0
	YCzbkXur+rDV38O80NlnwzpoudaKF3oRqDLI2YQZIllsxXf3J6iwArYw8hSzfdeXZAioO2R0zfu
	RBWGMw4skeT/YOsjERoTXssFfQrDU1rVjyIGZHIVNSKpVHhtlPH+Jdi6TY4R4PYgUbn4GjWUdmd
	FRGsXnLxAcvP2xQf9x3djGj/5Z3wYKML9CtQMYJO+CEO540Y0bTP0wx1BUxEX/MQFL9+spOoUKF
	DREdCRhPOWE1Mqa1vFe/+wawaBMfUgIoPYnqDFzzRh/4UxOZH5W85IVIkKCq7qfl/KhdKLXS4cl
	O77NiS//7CvwOH8WYI24Yutj1uTiDiRWVFG1+uRge4bKRQqIuGDhkCfM5oQHGYGdDDDNE8EVaqx
	5M+GciK99ThSmICMCXlKjFSfiYDHxK3Fzo0Zqu33U8rmTdl/Yn/r6P7ue3NOB2+k0PeIqf6y9kN
	h4zdC67LeqjQ1lSGxwWhSSqKpUhtx2zl4ZLnUIsKbgdoJL5Z5UEN5xzcU3J29NnC9fqXD1WmcrX
	KQvZs+v8z/w==
X-Received: by 2002:a05:620a:29d4:b0:943:f4a1:7bb9 with SMTP id af79cd13be357-944216efcc7mr1061645285a.18.1793499229856;
        Sat, 31 Oct 2026 19:13:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:49 -0700 (PDT)
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
	Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 02/12] mm/page_alloc: keep the pagesets of an empty zone
Date: Sat, 31 Oct 2026 22:13:30 -0400
Message-ID: <20261101021340.2251928-3-gourry@gourry.net>
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

From: Josef Bacik <josef@toxicpanda.com>

When the last memory of a zone goes offline, zone_pcp_reset() frees
zone->per_cpu_pageset and zone->per_cpu_zonestats. Nothing waits for those
who found the zone populated and still use the two pointers. They take
neither the memory hotplug lock nor any other lock which offline_pages()
holds, and some of them can sleep:

  CPU0 vmstat_update()                CPU1 offline_pages()
  refresh_cpu_vm_stats()
    for_each_populated_zone(zone)
      pcp = zone->per_cpu_pageset
      cond_resched()
                                      adjust_present_page_count()
                                      zone_pcp_reset(zone)
                                        free_percpu(zone->per_cpu_pageset)
      decay_pcp_high(zone, pcp)
      __this_cpu_write(pcp->expire, 0)

The same goes for drain_all_pages(NULL), which takes pcp->lock, for
zone_pcp_update(), show_free_areas() and the readers and writers of the
zonestats. If the per-cpu memory has got a new owner in the meantime, it
is corrupted.

The pagesets are only freed because setup_zone_pageset() would otherwise
leak them when the zone gets memory again. Keep them instead and let
setup_zone_pageset() and zone_pcp_init() use them again, like it is done
with pgdat->per_cpu_nodestats. Their lists are empty, and their limits
have been calculated for a zone without memory by the
init_per_zone_wmark_min() of offline_pages(), which is what
setup_zone_pageset() would come up with as well.

Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes empty")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f1048168c90c..1850a41f24f7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6308,6 +6308,10 @@ void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
 
+	/* The zone has been populated before, see zone_pcp_reset(). */
+	if (zone->per_cpu_pageset != &boot_pageset)
+		return;
+
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
@@ -6400,6 +6404,10 @@ void __init setup_per_cpu_pageset(void)
 
 __meminit void zone_pcp_init(struct zone *zone)
 {
+	/* A node which is added again, see zone_pcp_reset(). */
+	if (zone->per_cpu_pageset && zone->per_cpu_pageset != &boot_pageset)
+		return;
+
 	/*
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
@@ -7680,6 +7688,12 @@ void zone_pcp_enable(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * The zone has become empty. Its pagesets and zonestats are not freed: nothing
+ * keeps somebody who found the zone populated, such as refresh_cpu_vm_stats()
+ * or drain_all_pages(), from still using them. They are used again when the
+ * zone gets memory again.
+ */
 void zone_pcp_reset(struct zone *zone)
 {
 	int cpu;
@@ -7690,12 +7704,6 @@ void zone_pcp_reset(struct zone *zone)
 			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 			drain_zonestat(zone, pzstats);
 		}
-		free_percpu(zone->per_cpu_pageset);
-		zone->per_cpu_pageset = &boot_pageset;
-		if (zone->per_cpu_zonestats != &boot_zonestats) {
-			free_percpu(zone->per_cpu_zonestats);
-			zone->per_cpu_zonestats = &boot_zonestats;
-		}
 	}
 }
 
-- 
2.56.0

