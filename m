Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499242;
	b=yaUmbo8zAEwZ+rp1RyT+i05Ega4TnMCiOyG6UZnq8+HIVhzNly/s63RPb46DlpmMLIk9
	 EGjV+/fMQCtYGlz7skmZDl3VU5tZIF1Xlqv+/l2KRI6Bcn+WCrM2ElUbQ7IHy22bq3HCd
	 k7pJjZ9vfxQmfn1ifF0EUVlywUPjNzfg/JVMX43kFjny1fWNIR46X3ca7a4tds3umLppp
	 lPiZjICtCfKjyRHH/svsxO+K8a6rIEi4VqpRvcRJthnD9ZHrObXWOAehdhXw6GgfQNt+o
	 DBwkdMTOedU0boqlpOCzDokoRMPa5EZ1euWsB+mfdxt7Vls7GlXnmPwphBH2fj6z5jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=riPBcqO3vkhc0O/om8wK7f8cpXASGUa4k9CTnWK2v/U=;
	b=0mp8YQB3bCNXnH+4XURqkWNa+EgixD/6P88ouPIrem4McohrEnHxDGhkPBdMQyPXLinU
	 Ja1gP0EA91thw1a5ZIs+09dnGcVQyO/wh2pOYtTckFcq753NK5mFKGIsT+CHSWbxq4frb
	 +xOLdhKi+jxhguZxnR5rErOJtzJLvRJarv+96LEVJeTPm9oBkYA6fP/Ozy1+gEaCLGLYl
	 mpdxyV1B+cXqHv7c2cIvVmwNi2iumyoGGmSNVyQ0pIK5FYMspiP+Xp/Gko0JaG7OP0xYF
	 8negcHL0jJj0p6fRlUnJVXh/94nSiU3LR55vSL6p0Wlb0SCcwSs+ETNnH4vLZ73nxlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bd7gYeyX;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3060A2602
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB3060A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bd7gYeyX
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c162febb9so21537796d6.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499241; x=1794104041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riPBcqO3vkhc0O/om8wK7f8cpXASGUa4k9CTnWK2v/U=;
        b=bd7gYeyXbsO4b5WtmNTM2T9G8thWdsQlW55k8MN3pn2G/e4qmKq7lLj3OkAaqhCE1F
         ecSNEucUyo5DSj8fGheBXBt0lA4lO615Bxd+b2We9Z93ntmKnyznpARpX0hw2LgAWaZo
         lXFzIGovZ+iNQQQwKSoNCJs2Bl0sZRF07EdC9RJ1Gb5i7WIoVaUmXgdm4q8x8IBdevhJ
         iP5jERZy93X8QNJCURmj7kiVY1eOe2Or4PCJgJe74JozP1n6Y2NgdecD/dNgOwx95feV
         sYJjvliydXfnnKvXrVR6lsItsjA76MYob/ct9Mhiao6+dpWoSEPqcMbgWmSalNoP57rI
         CdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499241; x=1794104041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=riPBcqO3vkhc0O/om8wK7f8cpXASGUa4k9CTnWK2v/U=;
        b=wph1jVtrpgbIBR5OCJwKkAMSe/DceaX0AIQAJ8j+SI4/B1TPIAfq6kPY/bUr5wk+Ih
         uMjFF/BQbMJMg2u5KplDDqguTAwaoQHMVC9z1WkFmNpKO/jobOBlYyWP9XeDrpYADfy/
         Aacs6xVTyaxiUNbNZ74WZB2Lit4Xnt6KTJwsY5pIBTN03fOpTVC12vEitatLc8/fdBge
         4wJslsEgzUkLeJs+90kjCU2qdvvXAzUswRX5nuHNTV/zDyhYejrvxDMv+eLJ97msBw/u
         W6cIGDp6kavjvaMEJx8f88IahfLKJT2OEJgei5Jm6xBA5qABRijkGl4EUoZ0KPhX64zm
         s6mg==
X-Gm-Message-State: AFq9FYI2LJvsnszmPRUhrtIboYzKZ5qP3dxDoIUEEjq0hx8xP5/ZPQNZ
	SNTEYVrnzCm+zrmPNyPkq/VkxugP4GHp30F2QWB+3rQs+Lp29CLi96silmfstDX35Bo=
X-Gm-Gg: AYBFou0UI15DRfjNQbFNUXF5SviyXxs0l/ix8N+FCnxIgdtXCjYE3ZzRXTdApPh6zT3
	r4RLqlAOMBQxQ5hPgHCk01pkPe0YntRJz826nLZL4r+6eEMO+/tfv5nBEPEjSrgUIKBTB3a0GNF
	cF4RvshaP3/Gnfv+K9a6hTQLJJSBMufU4MZQZ11MdoV/7keQSzPMiUi4gUSOORn1fpIQ15bg0fD
	hfV85nim5MgtWCsegbeAwdhnE3xPsZUsCkoMcaB2G21gTMqytFGonUKYCaCzb1HQxDhhFYF5o+x
	KQNlAjAhfbH8ZXcmb5Y+cqBWJov6Q+Kdp5g88xH4FZeX8lPdu3h8xnjBakVt9OKi2h5fyLq2GSl
	B30nlB+Q9XTWjRKqc9uenz619DQ0+bc1SvB7xmNpD8cawohShQ+hOpsFu8zwbP/cabWpv0BTyc+
	ncVkf/6C7w/j4UMyFFE/BMmjZu7wMIfkv6bNm47gRTmPn6PNpJVMK9kFMgARFegtb6LHaxHSxKm
	P6qjtsVgquRbs4qVLTr3G6eLLhcDcsvXW6L8c+GJL3QJXKX7jiQWUuHVr6GkC57aOBZnPYCuVgz
	rGtL2E+9o535yKml73Uw/DdbLfax8wjNv+YTJ58nX6jJbmGdsqth9Fy31WDEitOfrsXvRW8hgJA
	4X2wMY3ZlRw==
X-Received: by 2002:a05:620a:440d:b0:943:faab:a144 with SMTP id af79cd13be357-9442175cf9cmr1087655285a.45.1793499241148;
        Sat, 31 Oct 2026 19:14:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:14:00 -0700 (PDT)
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
Subject: [PATCH v5 09/12] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Sat, 31 Oct 2026 22:13:37 -0400
Message-ID: <20261101021340.2251928-10-gourry@gourry.net>
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
shifting the slots after the new zone.  dequeue_hugetlb_folio_nodemask()
approves a slot by its node, then loads the zone from it, so a hugetlb
fault bound to one node can take a pool page from another:

  CPU 0                             CPU 1
  dequeue_hugetlb_folio_nodemask(nodemask {2})
    slot 3 (NORMAL2) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [.., NORMAL1, NORMAL2]
                                        -> [.., MOVABLE1, NORMAL1, ...]
    zone = zonelist_zone(slot 3)    /* NORMAL1 */
    dequeue_hugetlb_folio_node_exact(h, 1)

Check zonelist_update_seq before using each zone, and on the way out
with nothing found, and restart the walk if it changed.  Checking before
the dequeue leaves nothing to put back.  Reset the last-tried node on
restart, so it is not skipped.

With kprobes holding the walk across the online, a fault bound to node 2
took a node 1 page in 3 of 3 runs, and a node 2 page in 3 of 3 with this
change.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/page_alloc.c | 18 +-----------------
 mm/page_alloc.h | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da5d04edf7c1..b8a4fc2a996c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1293,11 +1293,11 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
 							int nid, nodemask_t *nmask)
 {
-	unsigned int cpuset_mems_cookie;
+	unsigned int cpuset_mems_cookie, zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
-	int node = NUMA_NO_NODE;
+	int node;
 
 	/* 'nid' should not be NUMA_NO_NODE. Try to catch any misuse of it and rectifiy. */
 	if (nid == NUMA_NO_NODE)
@@ -1306,10 +1306,16 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 	zonelist = node_zonelist(nid, gfp_mask);
 
 retry_cpuset:
+	node = NUMA_NO_NODE;
 	cpuset_mems_cookie = read_mems_allowed_begin();
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
 		struct folio *folio;
 
+		/* A rebuild may have shifted a node outside @nmask into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry_cpuset;
+
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 		/*
@@ -1324,7 +1330,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 		if (folio)
 			return folio;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f2f7e96bdef2..242bef2fe400 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4409,15 +4409,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  * retries the allocation if zonelist changes. Writer side is protected by the
  * embedded spin_lock.
  */
-static DEFINE_SEQLOCK(zonelist_update_seq);
-
-static unsigned int zonelist_iter_begin(void)
-{
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		return read_seqbegin(&zonelist_update_seq);
-
-	return 0;
-}
+DEFINE_SEQLOCK(zonelist_update_seq);
 
 /*
  * Never wait for the writer, which an ALLOC_NOLOCK caller in NMI may have
@@ -4432,14 +4424,6 @@ static unsigned int zonelist_iter_sample(void)
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
-{
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		return read_seqretry(&zonelist_update_seq, seq);
-
-	return 0;
-}
-
 /* Perform direct synchronous page reclaim */
 static unsigned long
 __perform_reclaim(gfp_t gfp_mask, unsigned int order,
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index e238ee91ed24..10a40ead6c00 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/nodemask.h>
+#include <linux/seqlock.h>
 #include <linux/types.h>
 
 #define ALLOC_DEFAULT		0
@@ -265,6 +266,24 @@ extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 extern void zone_pcp_init(struct zone *zone);
 
+extern seqlock_t zonelist_update_seq;
+
+static inline unsigned int zonelist_iter_begin(void)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return read_seqbegin(&zonelist_update_seq);
+
+	return 0;
+}
+
+static inline unsigned int check_retry_zonelist(unsigned int seq)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return read_seqretry(&zonelist_update_seq, seq);
+
+	return 0;
+}
+
 enum fallback_result {
 	/* Found suitable migratetype, *mt_out is valid. */
 	FALLBACK_FOUND,
-- 
2.56.0

