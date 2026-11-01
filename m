Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499238;
	b=ItZNeV6/6q/VsZiUSC6NdmpleOzVCyWthvU+8FUcCazj+pHXLib0OLKyJ6F1Ec/Uy7Fh
	 pboh7SmmtJTXIpPYs/Ron/M6P7gWtcy5QB/XFwSDv1L9x3/URjR4lIqtLNq6+wdyQ68ps
	 32OvT509RFHp4Q5UhTXYnebEKZBR93iTm4mGEB/WEJzYVvkhmSIKKxGhCkBCAz7V2nZSr
	 XYG2q4QOMXGM/Rae8PPh0aNHm4fX8QpvoSoEQci/ycK1gDEGbUOSAb/EQO9uh+QWRFs3O
	 phLkOsTByJqe21uFqLtE9+c3W6e2srAZ/8axN+nI20sqbcRNc2DrTZqHllZttGfAycQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bfcQbHHTje9Qk+CY4i9Q1tMr84K/2Do4+uTd71vDbHQ=;
	b=aeDm11XF9uNckRKl+4lGncPk9PJGivCDNatmIVR/uJoF4+ZreCpvYuIaxxSrmN2cBgGk
	 pcpMVqweghMmqVIrM+QGZ0iqLkdCPg8RfrrWjSxC3Rro0UghwxMbNRI06pKvukqRzfdqb
	 KSacDK5bTm0bW2XKkLHbBcwXX/HmJystVDhKKsVxxF3hGKThBuFg3hXAl2uVO4REf70VV
	 DPqdv/kX36sS4LB0c0SbxOuEyXB9SraSLJaBlWy8JoTdKFjg3IyvgmxlYrve7mRgvIpGd
	 21qvKp7pPPQfrcZWasAoeU3TzOs78xwKCsMbJ0pwuWx9O7NignM2OQ5SUYhssAjkGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Zw76JQjb;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0860A260E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DC0860A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Zw76JQjb
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f3c616c84so171413285a.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499236; x=1794104036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfcQbHHTje9Qk+CY4i9Q1tMr84K/2Do4+uTd71vDbHQ=;
        b=Zw76JQjb64/g/oHgoR4RwK+I3+edEcQMK/mldUIlOwSuJ5ixWvJsSEcCOlw3knbcML
         mW8SxKo8YPkDFeGbe5gyLDBf/pkvGEn7bTPswbaHVfPG1YQBL0dn2Nxev7fsG/MjosXR
         MefnbhdYbo+xygEwZwECaAeEFR4+uAdfALCYyU22IrLBIHgN1zUj68Pi2+H4hYLNuPbw
         2ELbuf5G1vedunp/DHwQ8ENG62NAyDiwE0eRt2LY2g13DReG2B1nKPQooTG8rzDnXHMo
         Rlncjx3f+l7N2mXL6FIPxNIpAg0y4mobCccVLa+AnutKbnq3OpRXiESOqDdYaDs7z58M
         SZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499236; x=1794104036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfcQbHHTje9Qk+CY4i9Q1tMr84K/2Do4+uTd71vDbHQ=;
        b=bOLyfnjoURyqwQxq2iavCcfl9+tTNFoDYvwZKYHJNkA+pMMZiBHpvBeAtjqNbWdUZG
         ujCdF519OvKvTDnkz6u24zYuqX73soj52Y2jlOahd30hrdeQ0NO6IGRnnZaOxWlDGK9m
         gpsJAYRR8y61V9YHlVI2nD4s5A+eWexWplfgg8c3PnRccRND9KWOivz9gqdtClD+knY5
         Ih/6rvvl2PXlWI9fGIWHbg6aEiLsUzy94cekhVo6EMSi8MJj60giQG/Xqq6WQPyOLCbk
         nHF1eB/2xt2sly5fE96wsFTMl0b6FKGYpx9LnZ03F6Hpxu+Oe/v6k/JMODVyHAKvda2G
         8tMg==
X-Gm-Message-State: AFq9FYLGnMd1OHOmUgqWMjKvbwHnmHSMap0s4XfUpaIw9wydZXinPMqs
	Vs2X1Z+kvDBVmtaE3eCExgoK7i/YPZWr26YgTUxErks2MOXAt4c4Tme36ucg6W3WF7w=
X-Gm-Gg: AYBFou31z4XXEi4A+/RW/1vATRYMZJHtz0zz/Egq/RBFvAKEnGPtrHvnXnbBvP1A2Om
	67uy07d4ksVol3rNEeyuY3y0dXLdEZFPat1WR9cbUCq/VbsYlDJqQKylRmx7P29I8VlziRGq6yM
	DzFz/Trf9R9aUonZh9+mp4AZIUOwzAvyQQBhkviFfYXNVvhquYMF/zgiJdg7CnSKcRION7V7ppj
	MvI7zhtQEJpMGQvP7Esn3w54DD1Kqz8+zySOPbMVn3nadHSzxriw/1YKCRaNpFLzG/dus2dOLiq
	A59l2uLEWs1AJYwChtAa2PRtz7Gv3mDpcW9a+QR+H+eRtobHsJW1yirB14mQ1YFKfveAITNNQ9H
	q0JKHUWd174QxAuXD1vzfGwVbG+510cj5DxKGFFPLlEYR5RC2vsISSVnr09EojGI/woMlcXFhdY
	etVuH22L/9HRblOjUtNcsxd2hmRuy5awjcXJz9LV+CyCzQpW0pOd70etXhU9IKtWYVLKTX3DRQk
	48VX0e4lw8NMjS7Ko84s0qvDCYTKaqGmOhrfoto7yQVvplyO1DbyIGUEay7OI5ZoHeQ1PpHJWsK
	dsZxxZ+bXiLBRrybOQ80HnlGFbY2iu9941PxQZPpHucBwqQZAbmK3JroMU4u+pT4j0MQ4Zs/itO
	0It1G/ouXrg==
X-Received: by 2002:a05:620a:4555:b0:93e:942f:b8b1 with SMTP id af79cd13be357-9442173ddb2mr1115363085a.64.1793499236470;
        Sat, 31 Oct 2026 19:13:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:56 -0700 (PDT)
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
Subject: [PATCH v5 06/12] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Sat, 31 Oct 2026 22:13:34 -0400
Message-ID: <20261101021340.2251928-7-gourry@gourry.net>
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

get_page_from_freelist() and alloc_pages_bulk_noprof() reread
ac->preferred_zoneref->zone at every use. Offlining a zone's last block
rebuilds the zonelists in place, and the shrunk list's NULL terminator
can land on the preferred slot mid-walk:

  CPU 0                             CPU 1
  get_page_from_freelist(GFP_KERNEL | __GFP_THISNODE)
    zone = NORMAL (slot 1)
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    rmqueue(zonelist_zone(slot 1), zone)
      zone_statistics(NULL, zone)

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:get_page_from_freelist+0x6a5/0x15f0
  Call Trace:
   __alloc_frozen_pages_noprof+0x125/0x330

Read the slot once. Zones are never freed, so a stale zone is safe, and
a NULL slot fails the same way as walking off the end.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 11be12b443ad..28d46f987685 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3794,12 +3794,21 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 {
 	struct zoneref *z;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
 	bool skip_kswapd_nodes = nr_online_nodes > 1;
 	bool skipped_kswapd_nodes = false;
 
+	/*
+	 * A concurrent zonelist rebuild can NULL or replace this slot. Zones
+	 * are never freed, so reading it once keeps a usable zone.
+	 */
+	preferred_zone = zonelist_zone(ac->preferred_zoneref);
+	if (!preferred_zone)
+		return NULL;
+
 retry:
 	/*
 	 * Scan zonelist, looking for a zone with enough free.
@@ -3846,7 +3855,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && !defrag_mode && nr_online_nodes > 1 &&
-		    zone != zonelist_zone(ac->preferred_zoneref)) {
+		    zone != preferred_zone) {
 			int local_nid;
 
 			/*
@@ -3854,7 +3863,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zonelist_node_idx(ac->preferred_zoneref);
+			local_nid = zone_to_nid(preferred_zone);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -3916,7 +3925,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (!node_reclaim_enabled() ||
-			    !zone_allows_reclaim(zonelist_zone(ac->preferred_zoneref), zone))
+			    !zone_allows_reclaim(preferred_zone, zone))
 				continue;
 
 			if (!node_reclaim(zone->zone_pgdat, gfp_mask, order))
@@ -3929,7 +3938,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
+		page = rmqueue(preferred_zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -5169,6 +5178,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 {
 	struct page *page;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -5217,6 +5227,11 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
+	/* Read once; see get_page_from_freelist(). */
+	preferred_zone = zonelist_zone(ac.preferred_zoneref);
+	if (!preferred_zone)
+		goto failed;
+
 	/* Find an allowed local zone that meets the low watermark. */
 	z = ac.preferred_zoneref;
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
@@ -5227,8 +5242,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
-		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
+		if (nr_online_nodes > 1 && zone != preferred_zone &&
+		    zone_to_nid(zone) != zone_to_nid(preferred_zone)) {
 			goto failed;
 		}
 
@@ -5236,7 +5251,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages - nr_populated;
 		if (zone_watermark_fast(zone, 0,  mark,
-				zonelist_zone_idx(ac.preferred_zoneref),
+				zone_idx(preferred_zone),
 				alloc_flags, gfp)) {
 			break;
 		}
@@ -5295,7 +5310,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	pcp_spin_unlock(pcp);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.56.0

