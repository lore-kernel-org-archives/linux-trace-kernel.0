Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550396;
	b=cjPk5zJSu0qEzNrFLk15Y/an8II27A5uR+ih3nzmkTUQ+GzTMYHLp3dpoPmkK9QpCnX3
	 IX0/Wr1a/hcXPC2qTRlFAOrtEMGXYDfqKeXXt3fZN0PQ4TnzW+xWAAYiAfenOlj/fs0wN
	 ryztbqaqjjzpIshduTQPSFTKqWq1P44d28LTxMP1G5iVU2ErXKdG6jlsFdP3BXO3jk2ws
	 PKpaXVyKB1OrhzXXTaX+Geaw7C8nWUtEr8rIkzhhCn59YCtHnsm1Mc6VPePH6wwv6QEQE
	 aUG4Caiwyg1+VHTZzxBnOAlnuHXAv7VfPleX0SbcquMtsRowbYOSX9Qsiw4Z+fa6y6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
	b=F1NDNUoTYBDmWjwUMzVUdRBzHDqTBkpEkzhy5qBtw38PyJzzb2ASj7yNvcjfD58ACkDu
	 mGHg/Z/5w9FkRwPmRtyX80gfFUEYmr9MmSOqg/E22mYKFvPiqKdbiHkmsaOsPWv8HY04V
	 o71J95O1jdwT4r7vDui6RV7Zq8y8k3Ljp7E0h+nWCSoXk/APvWEOn2x9z4xgxE5a5r3B4
	 hlX+0VEYU6CBe1MgBQjP92+yuhXQ8ju+MVzfU1vufk0AnFd0L5SQi0DMWKcqmtDK1j9o0
	 pmAyD5YnvMR8WnX17t2IG/jJYuLMS4dXXK1/AQDI0XHYKy8v/eV7XPtI2MamBVzjltg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=agfPLIGG;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6960A260B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 02:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C6960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=agfPLIGG
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917997ab0d9so2859506d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550395; x=1793155195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
        b=agfPLIGGiLVsUCOLHMgU/UcLSpxwViouNvaZrSqAOZSdV5uSMjzkT4D+DlabS5tvPO
         9+2z5tm5/VtSy8fxs4XWBqbQ04lH8JCWHbgqmPQ4SRfKNhURTo0R7lBsM05I6U7ynqrM
         eWDsvZHJcQD0xvaYmZ5YeMEqzRifU+skeh5p6cMv8UAtGRRK6P/fUAhHrp7bFNYmC7J+
         z+XQSLsvtPXfYQgV5ykAyRnKxOU+bF5iFCYzmMp+NOoYkgqCodOXmB9DXqH1C795Idqw
         BmaMW24Rd8tqEt4oIro7K9vthFEuxjeZN0TOD1lbUgoyho/s7eT+K4djWgZsSug1qaTT
         rkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550395; x=1793155195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
        b=h4/QiOUHxWoJeWT/ZBqTA85KF3bjd1rdea0FXG2aY+3AaKbFKQqg1R4RZ71+OQjsZj
         sSWJEFNUbz34gJxFgff1YJi/XZNFXUuvpubv8mHVKX3/3o2H+qK8vJbLzFkoaC0LwzBK
         jHs+xwmZ7g8TIcOiSQOAknmDLSGgd9H/w+4oUhz6JrgRxy6U/QfweUNyda7OEq9b9+zW
         xNbJuJmTADqZ9V03NHBf+780Crxk2fbyWVrL5jw5s6sBC6mLTAPvjAl4MAct0EsVt8ra
         C52wolNtlYQ6Jcru/ba20e3QP9yzGN2h51oTup63mpga1t4PGlY+Pg79GDsjwENvPUcW
         7C7Q==
X-Forwarded-Encrypted: i=1; AKwUvBz0F/CIyINPtZdJmJamUuyKDYhNdoTL2gMqMwnoYyEuesUw5G/WHOYkLCEXg2M3mSKejKT/VaQZXnXW7BjtOxTGrUo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYzGv1Yhjwa9zOVhBM0hkmjL1weGo8lQKi5MRkBBs86BukhqKA
	xBiq1YvwZ9vGB4auJUqBbzDziszH6s5qiHAJz8rOVXg34M/uPk59Ik/dmtejSOc+VD8=
X-Gm-Gg: AYBFou3Z/hhVs34Sc1TI8F52UE5TxQpO7dodn/UtuyEGZgWn2A8WQAb6u0DZsLK+mdk
	ykRM8gj9jvqJg16deaKQArNJw4zKT95NPegAai5CPTeEvdUZw9bQXAO3PlcVs2d1L8634mw9RdN
	FcEkyrRSGE2cEp1HyCCcvtH3/BzRDiSFgXA3X8SeNGtysrC577rMfF5Fmgwr0T1bHUrUcaTeurI
	9fhWeohyP3EfnXHluGZnK2DDXannh1whcfLZqxOvyM280Sf/l7D0UwEFyKDBUcNWMnkoh65rphh
	IUPstNdwu3V07g47aJ4jegRNcEKAKICzmfUVulbsFxYveL9zExi8oe96wCcoUNLs8B7YY8WF2pf
	DdxBeZzS56H6TSbSTfzUWNq8SRBz4NzSZXS+k2BxNn8Vj0Gvg8INCF7fhqOighODggK+0uylEhs
	ZUsccP4mknlvd6p5oorWCOC7kevc9PwbaK5iiBF79I17RDOWwIssMP+tehDdzyuCnpxqXNxWVpr
	l0UIbqi+skD+IEMmnaH25U29DgmcmmB0h7JoYDOKlC8c2dcKJPDNkH0LtkbXEn780+IGy6j5MtD
	ZbG8012WblnK2vmSs2OVYqjUkQG6idi4jNLHb2ENLYXMUja80qzlJFc44iGTaSI=
X-Received: by 2002:a05:620a:260a:b0:93e:48fc:aa85 with SMTP id af79cd13be357-93f57f1d75dmr211957385a.43.1792550394720;
        Tue, 20 Oct 2026 19:39:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:54 -0700 (PDT)
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
Subject: [PATCH v3 6/8] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Tue, 20 Oct 2026 22:39:38 -0400
Message-ID: <20261021023940.1940971-7-gourry@gourry.net>
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
shifting the slots after the new zone. A hugetlb fault bound to one node
can then take a pool page from another.

dequeue_hugetlb_folio_nodemask() picks pool nodes by walking a zonelist
with the policy nodemask. The iterator approves a slot by its node, and
the walk loads the zone from the slot afterwards:

  CPU 0                             CPU 1
  dequeue_hugetlb_folio_nodemask(nodemask {2})
    slot 3 (NORMAL2) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [.., NORMAL1, NORMAL2]
                                        -> [.., MOVABLE1, NORMAL1, ...]
    zone = zonelist_zone(slot 3)    /* NORMAL1 */
    dequeue_hugetlb_folio_node_exact(h, 1)

Check zonelist_update_seq before using each zone the walk returns, and
on the way out with nothing found, and restart the walk if it changed.
Checking before the dequeue leaves nothing to put back. Reset the node
the walk last tried on every restart, so a restart does not skip it.

With kprobes holding the walk across the online, a hugetlb fault bound
to node 2 took its page from node 1 in 3 of 3 runs, and from node 2 in 3
of 3 runs with this change.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/page_alloc.c |  4 ++--
 mm/page_alloc.h |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b37d7d0db7fc9..8edf323baf0fc 100644
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
index dd8c9046f9a06..5ca8e57c5fcbf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4411,7 +4411,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  */
 static DEFINE_SEQLOCK(zonelist_update_seq);
 
-static unsigned int zonelist_iter_begin(void)
+unsigned int zonelist_iter_begin(void)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
@@ -4432,7 +4432,7 @@ static unsigned int zonelist_iter_sample(void)
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
+unsigned int check_retry_zonelist(unsigned int seq)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 2b1017a91928c..53df6b8a0c00a 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -265,6 +265,9 @@ extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 extern void zone_pcp_init(struct zone *zone);
 
+unsigned int zonelist_iter_begin(void);
+unsigned int check_retry_zonelist(unsigned int seq);
+
 enum fallback_result {
 	/* Found suitable migratetype, *mt_out is valid. */
 	FALLBACK_FOUND,
-- 
2.53.0-Meta

