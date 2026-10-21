Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550389;
	b=zAe7DIhWDA9Uy/cs61t/CHXCPMldoT8Lt1+ELZHJroU3i3Hq7+CL4VMQ/6lxrB2NqLTA
	 X+FA6Z+1omwG0kRh7pjHYJIlY8RX/XcnIcgU++C3LWzjxIw3etHJSpRL67l4xHFfESGBe
	 Qg8lOJZmo5fY7h3AvVT+mnPztfQoXAkD+lcL/fSkHHDq7vVvVdX4WUFClzozqVHgcjB0m
	 /cGMu8A+DHQK7fuQCsv+IPepQoGlapKG2sokZMIjGAfHpxXeInlBFuZDaxC+UPF/ZOBR3
	 NH1idXu93qE6/UJa8djX2Ygv0+WxxBu8e7UE8Y7fSxI0N0mA432vmZmBEUZn6Wg+Wfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wZzEJG+KuWuKC34TpbwLEcO6lDSRUEVZ4rjGM6mtgtM=;
	b=tv/07JsL+wAwWKbhDr2eWfW+Fp8J03+VqyP7nfRPFBir1TT0AWuefY9Ytd+ZQZd4X5gj
	 i7ogAwPZ5sbKj6GeQXvk4LL7PjGFy41avbnH5xYa76MDv/EUvIH3xknjMys+EZ7VJwLja
	 Pfm7U7DC8eVEwc1X+Nk0gtSRiZbT82SEp2ormLgn0eewrjDPmOAZBXZnP7QndKBMpYeBo
	 pVQIEkRQzrQVmcic32/+7Q4gQblbysL8phgehvSFjVK/YUqdkRpiaHDUEkaiNPZODXvml
	 mDa9C8og1tUHFCeZIq9NRcNKLWt40j4MFVojlGwYyfnnJhhoAur+QLKWlnTp3fdD9mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=H3FKdH7p;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79E606A328
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 02:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC79E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=H3FKdH7p
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e7ad9f78dso28823085a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 19:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550388; x=1793155188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZzEJG+KuWuKC34TpbwLEcO6lDSRUEVZ4rjGM6mtgtM=;
        b=H3FKdH7pQ+Zcx3kdgD+0Sou2nJSOqubYd3/2EHfQ6oTc56ShplBnAUEMZQv1RcBoz4
         Wr+u3cPO3UbK8i6RCCalG3uIcNk5GfDTTjG+61Y9bXomJtLei2/J5boY8IxHngl9Y0Ba
         bzBkN0bSxvGwNo+FCshmHVaXqc/uQj98zF3TbK1MUtN6++wrynAwuY5etI8C4OyMGFEt
         9gTjjUfhYVs8X2N9OV9jvGSigm+HE24TW56AEly7m3H0YPkz64K5ifm7F7Lf0/Z92ymK
         QUDJo3Lq6ooqtCK5SXCRxeAe50ktyYOqtiNtGC3lyJZuh67XrnvDKoG8iTQ24eUWD92q
         OYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550388; x=1793155188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wZzEJG+KuWuKC34TpbwLEcO6lDSRUEVZ4rjGM6mtgtM=;
        b=pqVhmxDIT0JWq85CIDyVgSTisA2UvrV+bw8tjVp7NIOmRm2g/rLVQ+AfNnqxSUDPti
         bi5FunGP92h0v0in5CAevNQuv3AJRsGurqB34pCQ1abAPKbgvxWJH8cr9eaup13+Bz03
         Aw+N++4wIEL6J5UvvO9hXw+E7ICFJB4qsWZdKPUTIVng4wzK6ROFKgAfT+iy5sJrn8Ba
         abhrzitxgl/pi0aKw5yeEV1wbYtztDIOQVjxWaKGJhgaQRziopqi8aSkYBjk69+7P58i
         n2X99DgBLlB60q6OIzAisaku2CpVPHtxfearu4mMesia/1GT0rpHaAEpnL3jPQgHyKZ7
         r6Ag==
X-Forwarded-Encrypted: i=1; AKwUvBxzgsT+UfLIzsub5S5yP+mlrWhVbOmHJRvzCz6WJnkGTyzd57JYwfQgnmQF1hpQB3HLBVkUXY0XwnsYtu6qXqRrEDU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhl7Rk8Qc0V5z1r9azBdsUiEZQtQpn7s9RvlxM3U9y9NIWtbdz
	JzEUvua7ecUVP32neGLqVZWKQzuZdf+DqOmOld7c6kfI28FPvlHn1u/IQSlIjtVT2ls=
X-Gm-Gg: AYBFou02OstPxkdkDncHuctnMol924BrBE1xssN7ckGV3MqzwWmEreRx0zBKEpp3AGg
	otGcdyrLsOP7P0tXxd+MFjagt/Gw3cFOTMF/AosEXA5dlrPc3D+LQjmQHORixinh7cCETceCJac
	jUZVTpQQ6YSKEjP6XQA6wrE2LXbnbti+2hrIHcrGbCyKj5JcATtXCyntiSt/t/g9Jv21R77RCUl
	1ZMjUGBvtppuS589xXRkRFdzkZW7Hn3aR1PeXWeDF+Y3jcS+Df0nYv7ywbwBqiQN6yp1OI9iRCw
	+ISsvnsBsccYtyHVchgsDUlCff7sJNMu4tR3VXg2x5kNsfDq5YW4cSjESxwPzaqIcKz85Fw8NNN
	tYx342GKQydZBA7Mj7mBSnc2DKGQzf7CZslEb97opAyaZxPDGbVvjiUlm4QhS8ZqkPMslepnaMC
	mjjhTFAaGrD29eE3cW2nK2vuJXzHA9D0idyI6y7aks9xVSPG7Y4RftnwEUphmVOXZUAwuPeZCer
	7sMeqaPdZ4JthkdQHhWclgakkblx6oMcJ/i7L8+kPEsFqvZ5n5eTVYOxwDT/OmTBT+gfbTnRY5V
	4grD45+EkjSX30RrXCdKQ0vCnTMyL0MJoqXAoqjCoD+hWqCfowWutCcVpkbU9U8=
X-Received: by 2002:a05:620a:28c8:b0:93b:db80:e0cf with SMTP id af79cd13be357-93f57f4bd53mr204750985a.60.1792550387716;
        Tue, 20 Oct 2026 19:39:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:47 -0700 (PDT)
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
Subject: [PATCH v3 2/8] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Tue, 20 Oct 2026 22:39:34 -0400
Message-ID: <20261021023940.1940971-3-gourry@gourry.net>
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
---
 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c7125f6693574..4cf2982c5b107 100644
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
+	preferred_zone = READ_ONCE(ac->preferred_zoneref->zone);
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
@@ -5183,6 +5192,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 {
 	struct page *page;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -5231,6 +5241,11 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
+	/* Read once; see get_page_from_freelist(). */
+	preferred_zone = READ_ONCE(ac.preferred_zoneref->zone);
+	if (!preferred_zone)
+		goto failed;
+
 	/* Find an allowed local zone that meets the low watermark. */
 	z = ac.preferred_zoneref;
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
@@ -5241,8 +5256,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
-		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
+		if (nr_online_nodes > 1 && zone != preferred_zone &&
+		    zone_to_nid(zone) != zone_to_nid(preferred_zone)) {
 			goto failed;
 		}
 
@@ -5250,7 +5265,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages - nr_populated;
 		if (zone_watermark_fast(zone, 0,  mark,
-				zonelist_zone_idx(ac.preferred_zoneref),
+				zone_idx(preferred_zone),
 				alloc_flags, gfp)) {
 			break;
 		}
@@ -5309,7 +5324,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	pcp_spin_unlock(pcp);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.53.0-Meta

