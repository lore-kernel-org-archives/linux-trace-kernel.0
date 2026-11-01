Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499232;
	b=zc4NxVaT64POmWBU6ypO8SQ95BPcVMznc9R/4e+C+X0yRGmxT68NwGwBjkH7AEwd6NIl
	 CwBHrlxpoMBSV6ZuQpgTGiPogZ5D5hElW8jGWVqpSAAT4GYfLk5sd0BwYnAuE1s5FlUUA
	 WBNrSOlHuWxa+Zfi53CChQAaxOgOHspcXjVYfqSpaf2Dozwd6hAehPGGYPPWX/APSpUm7
	 ONkN5zOlgdzcIJOy7ii89Qrbd2A6bb2RQJk+OtuiCG2NnOa/m+iP71scNUUaeW84kHm+b
	 t2MYRpBjjg4zfcp1qmq65RJo5pJ6TXc0EbJF601k+Q6+lCMgJu4zcoIvRxiEtJsmIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KAOVkIrNNyhi9D/V3dLJ+NSr5WjrzmwZ1Aks/FNVQtc=;
	b=oa2e/U5stgL09qTepimhJcdfG+uGPKpnAHBaS2um/EwS8ZM4EQsj5pIng6F9btO2jmeW
	 pY3LyrAY8fxFBmk0z8aMUMd7z0MdycW4VICxnQUtGUf8QZNPbrn3poBgqJSQN/F4R7uX5
	 kdbsFs01BGxq4BOhal9zVzIbMZyqiINtJonOWdrhEg1eihjNMirWjL30ymDKE6B27fGcU
	 IY5M+VMfNbsrM3HPkIsB4v46LLDqEVIz8qXOiIohWiyW8OM7uWK0t4cH0ytc/HkcW6LtT
	 SslM8iKayLXWomU4knXvYzhvy/ca0jCRLfBMxZxTyEJxmmENcirH3/sQ/5o64Lxy8Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GQZwPZut;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF53606A32F
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF53606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GQZwPZut
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93ece7a73b9so258160385a.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499231; x=1794104031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KAOVkIrNNyhi9D/V3dLJ+NSr5WjrzmwZ1Aks/FNVQtc=;
        b=GQZwPZut1+f0LNuk58xvNeHpw5iZVxdxph21KZg7S3cQYqlDaYoC2soU2pe5O0tbrr
         ZM77qC5FcogyagTiVBGGa20b5p+8WvYkrdxZAWuUpyvziaCPjLrF2Zc7+ltF/e99szjW
         IB0LdH3ROzeg288FHmXf23WAI83PduKfy/e2rBeeEQLjyTEmaqMfECko8xjHJnRjkx9m
         MK/ALbLe8W5W8N14SARnsl8bpxsWg2BRRsVPQXFdsk9cwlLQ+GoFtOeM5yqPuMOBJOO4
         crUFvgoV5iOdeGERJZGRRNcww1RBUg63cGdm1q3rd5lQFfoHAgV6sVQKxU8yU8MMdtHT
         upHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499231; x=1794104031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KAOVkIrNNyhi9D/V3dLJ+NSr5WjrzmwZ1Aks/FNVQtc=;
        b=xkqsxKswuykFPj2QDfIPqU9BLoCA6zlicSrlcE5GG09e10RrdiMGAgumi701p3ChIX
         MpiwsEl6GGMYw/xEKDiCbTclnB9QysrpyRYawlcC+LD6O2H+UCy+8usA4NOdvM5yJnVd
         6ioHVn+HpBSMMz8Z7PpX+Ir56zKe7ItmjcFNpb9//gw9RZ2bfBAXKTuB+x3JSg/INhJp
         1xFNLr7NRH9Syew9TwcrZNu638LVBHyX1Ee6A0cKJeTQw4vRdeh4snGYmww9Pp5z9ugp
         xK3uZXv2EyatGuGWtvrGuBc2J/mfKl5qsZhsWg/zi85Kj+Yk5/cRiK4j1FTg7nRZJBCv
         MYLw==
X-Gm-Message-State: AFq9FYJYtn7rWEXdkVmUsFesX76jMoRG32zVAWTMSHwjzo6GV+1RnzmC
	dNEA+h+fWpNYHq+pG1eD2iUIkFcjPAbMxLLe0C03CghNhlc+fUmELTb582Q5k8UFfyM=
X-Gm-Gg: AYBFou3ivYOcGtWopSxLh3D+xSOQUHt+Wgq1DJuCcJkb8DKsLPsv4TYJcZL+kunVI+1
	kSDfwDedbyw0H87/3Ljf3CQzMtCSF8MRgBdE3Yh63ztSUDpRrJA/1bplOi3KRM4aJ4mcflpIcAe
	NyHxTy4WNovojfhCZNDJy61c7ofwpo+fGfJ6Uou2NWuukHxsJVuSS+1Ugv/CYUGx+XK6I+Lc4Pf
	qEqJR1Ap0vt9Z7LgI43b3ltFMR+MHi8yUda1oYvtaEuWLzoaAKCpCwyXRKiqB9SoBkElOjPsHKB
	LRVSz15Q/D/0KMePdCiLRfIkzdo2u0z3W8ItBXKJ9djpk6tmAsNV7InE1YBBeck1zs2+J29w6Oa
	r1gIdMGtzYsy7C+Qx+ylPl4ciWacXu6FKybUu6xnbzCpyI5x++QAe69D+YTBLzJNar4loUkbkrO
	DAFhgTV6e5DnIUfZj4OdnBn7D9xKE3WiYvwUHAmSzmRn4GHgO05qEvIGnrS1H/ShjIsB1l8jkg1
	pGovkccjeSH+1+/M0tB5De4VAsY0KvQIAtOsu9Xh8R8LuC1D3Uw5kAZFo4gCfBXutR9SIRaw1Zq
	Iuvx/5URx54apIRllVz7zc/GkJKP6Y2xmmpzjD7cZBSR1tSenZiPWp5DC/pZKr6g/zvf41BRxLq
	Sv9UK1oAX3A==
X-Received: by 2002:a05:620a:254a:b0:93e:6325:ae6d with SMTP id af79cd13be357-9442175ae31mr1053484485a.40.1793499231477;
        Sat, 31 Oct 2026 19:13:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:51 -0700 (PDT)
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
Subject: [PATCH v5 03/12] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone
Date: Sat, 31 Oct 2026 22:13:31 -0400
Message-ID: <20261101021340.2251928-4-gourry@gourry.net>
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

should_reclaim_retry() walks a zonelist and passes the zoneref pointer
to the reclaim_retry_zone tracepoint, which loads the zone from the
entry again to find the node.

Memory hotplug rebuilds the zonelists in place while allocations are
under way. When a zone in front of the zoneref entry has become empty,
the entries move up, and this one can be the end marker by the time the
tracepoint looks at it. zonelist_node_idx() then dereferences a NULL
zone. Short of that, the event can name another zone than the one its
numbers belong to.

Pass the zone pointer instead of the zoneref pointer.

Fixes: d379f01de095 ("oom, trace: add oom detection tracepoints")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/trace/events/oom.h | 8 ++++----
 mm/page_alloc.c            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 9f0a5d1482c4..cbcf6fe4cc61 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -33,7 +33,7 @@ TRACE_EVENT(oom_score_adj_update,
 
 TRACE_EVENT(reclaim_retry_zone,
 
-	TP_PROTO(struct zoneref *zoneref,
+	TP_PROTO(struct zone *zone,
 		int order,
 		unsigned long reclaimable,
 		unsigned long available,
@@ -41,7 +41,7 @@ TRACE_EVENT(reclaim_retry_zone,
 		int no_progress_loops,
 		bool wmark_check),
 
-	TP_ARGS(zoneref, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
+	TP_ARGS(zone, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
 
 	TP_STRUCT__entry(
 		__field(	int, node)
@@ -55,8 +55,8 @@ TRACE_EVENT(reclaim_retry_zone,
 	),
 
 	TP_fast_assign(
-		__entry->node = zonelist_node_idx(zoneref);
-		__entry->zone_idx = zonelist_zone_idx(zoneref);
+		__entry->node = zone_to_nid(zone);
+		__entry->zone_idx = zone_idx(zone);
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1850a41f24f7..e14d550d4128 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4670,7 +4670,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
 				ac->highest_zoneidx, alloc_flags, available);
-		trace_reclaim_retry_zone(z, order, reclaimable,
+		trace_reclaim_retry_zone(zone, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
 			ret = true;
-- 
2.56.0

