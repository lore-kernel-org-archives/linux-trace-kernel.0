Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094046;
	b=gJ2x2UddDFO3J8oDeeJAoSWKaaybb8qH5L4eg1q2m4ZzMd3bdIZPl+jvh49KEfHj481s
	 O0csO9kPj+hjv+LLIvq1Vu8MFPVgDgVKdJCn+bA1n/OD6AIlurvMfmO8ohh+2hQJreJDE
	 y3tUfhDflnVQsyheUE8NLCWOynJjebxNRggfZknKl1jzMQ+b+PtWYWBGjsVwKVPcLxxLL
	 3znKKZiRZ3LrF1YN6ikN4G6Zk4+f4iZdhwJ9aRdFF+Ax5U4wG/1JjRuQG28XHmJRqOlLW
	 51MWMx2lq3KIyfX2DduLVDC/CZxHlu7QGbmzJbGQt4rYTY2jxYPha/ztdh/hs9ryiag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094046;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=4KnuBOFznA/VDWJ5if53/N0G1tiho15zBcRHO3JDxRY=;
	b=FOPzFarcPnUpJKYEFbdf6XABHywm3wcJTj/gxSA0W/np5RIiX2NtAuP6dQqLbU4pMPxO
	 QqACvVCqr8OGSXj6rzEgzg6/GMkG5UPdNPXw8+Er5uuQ3n9cOzWdffKXDlWEaVPz2GBcr
	 Vv4fcFRo+jZ+/4whDTz2PXZ0qqeY/sivYz1zumccJpUPqV1i+yYFx8zg4kFsxTlX8u/YL
	 OHgl5FsPmczoJrDguq6964zJIGwuIvBP87zQbzJOW98m8RL+rkhDxYIYEjmObvDx7OxZh
	 ZeqbU8ExBIvi0PfLO0yUy/9054/c9fGmNrPl+cRzfk88pIpW9w/t1LA0114AaXj/o+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D2606A32A;
	Tue, 27 Oct 2026 09:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 283D2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7622c894d1ea11f19a56ed5b684f684d-20261027
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b8b19f8b-e63f-405e-8854-954816a2d84b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:b8b19f8b-e63f-405e-8854-954816a2d84b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:d63e7cb1ef2d14fbaf4f4c2e2408e69d,BulkI
	D:261027174039JO0S0EI1,BulkQuantity:0,SF:17|19|38|66|78|81|82|102|127|136|
	850|865|898,TC:nil,Content:0|15|50|99|100|102|155,EDM:-3|-100,IP:-2,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7622c894d1ea11f19a56ed5b684f684d-20261027
X-User: wangxuewen@kylinos.cn
Received: from localhost.localdomain [(223.104.42.231)] by mailgw.kylinos.cn
	(envelope-from <wangxuewen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 265772172; Tue, 27 Oct 2026 17:40:35 +0800
From: Xuewen Wang <wangxuewen@kylinos.cn>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Xuewen Wang <wangxuewen@kylinos.cn>
Subject: [PATCH 2/2] mm/shmem: trace folio allocation failures and fallbacks
Date: Tue, 27 Oct 2026 17:40:14 +0800
Message-Id: <20261027094014.2432692-3-wangxuewen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261027094014.2432692-1-wangxuewen@kylinos.cn>
References: <20261027094014.2432692-1-wangxuewen@kylinos.cn>
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

The shmem allocation counters cannot identify which tmpfs file is
affected by allocation fallback. They also do not describe order
filtering caused by VMA constraints or existing page-cache entries.

Trace failed calls to shmem_alloc_and_add_folio() and successful calls
that allocate below the highest order permitted by the supplied mask.
Record the original index and the highest permitted, highest suitable
and allocated orders to distinguish filtering from allocator fallback.
A suitable order of -1 identifies an empty filtered mask, where no folio
allocation is attempted; such records use a separate filter stage and keep
the stage error at zero while preserving the helper return value. Omit
successes at the requested order, including ordinary base-page allocations.

Identify failures by stage: allocation, memcg charging, cache insertion
or filesystem accounting. Preserve both the stage's errno and the
returned errno. In particular, a charge failure remains visible even
when a page-cache conflict makes the function return -EEXIST instead.
Stage and errno distinguish this case from a direct insertion race.

Document that each event describes one call to the helper, which may try
multiple candidate orders. The caller may subsequently retry at order 0
or restart a lookup, so an error in this event is not necessarily a failed
user operation. A successful order-0 retry is omitted as a success at that
call's requested order.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
---
 Documentation/trace/events-shmem.rst | 45 +++++++++++++++++++++++
 include/trace/events/shmem.h         | 55 ++++++++++++++++++++++++++++
 mm/shmem.c                           | 34 ++++++++++++++++-
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/events-shmem.rst b/Documentation/trace/events-shmem.rst
index 45da82761360..4a0e50bdbdf3 100644
--- a/Documentation/trace/events-shmem.rst
+++ b/Documentation/trace/events-shmem.rst
@@ -71,3 +71,48 @@ Filter or aggregate by both ``dev`` and ``ino``; inode numbers alone are
 not unique across mounts. Trace filters use the numeric values shown by
 the event's ``format`` file. Check ``per_cpu/cpu*/stats`` for dropped events
 before interpreting counts.
+
+Allocation attempts
+-------------------
+
+``shmem_alloc_folio_finish`` records failed calls to
+``shmem_alloc_and_add_folio()`` and successful calls that allocate below
+their requested order. Successes at the requested order are omitted,
+including ordinary order-0 allocations.
+
+This is an attempt result, not the final result of a read, write or fault.
+After a higher-order failure the caller may retry at order 0, or restart
+its lookup on ``-EEXIST``. A successful order-0 retry is not recorded.
+Do not count all nonzero returns as failed user operations.
+
+``requested_order`` is the highest order allowed by this call's order mask,
+or 0 for a base-page request. ``suitable_order`` is the highest remaining
+order after VMA and page-cache filtering, or -1 if none remains.
+``actual_order`` is the allocated folio's order, or -1 if allocation did
+not produce a folio. Orders refer to base pages, not bytes.
+
+``stage`` identifies where the attempt ended:
+
+* ``filter``: filtering removed every candidate order, so no folio
+  allocation was attempted. ``suitable_order=-1`` identifies this case.
+* ``alloc``: a suitable order existed, but every allocation failed.
+* ``charge``: memcg charging failed.
+* ``cache``: page-cache insertion failed.
+* ``account``: filesystem block accounting failed after its retry.
+* ``done``: allocation succeeded at a smaller order.
+
+``error`` is the error at that stage; ``ret`` is the error returned to the
+caller. ``stage=filter`` has ``error=0`` because no allocator call occurred,
+while ``ret=-ENOMEM`` preserves the helper's return value. Both are zero for
+``done``. For a charge failure followed by a page-cache conflict, ``error``
+retains the charge error (such as ``-ENOMEM``), while ``ret=-EEXIST``
+requests a lookup retry. A direct insertion race instead has
+``stage=cache error=-EEXIST ret=-EEXIST``. Accounting errors retain
+``-ENOSPC`` or ``-EDQUOT`` as appropriate.
+
+Enable ``events/shmem/shmem_alloc_folio_finish/enable`` in the trace
+instance to collect these records. On successful fallbacks,
+``suitable_order < requested_order`` shows filtering, and
+``actual_order < suitable_order`` shows allocator fallback. Both may
+occur in one attempt. The existing shmem allocation and fallback
+counters remain useful for aggregate statistics.
diff --git a/include/trace/events/shmem.h b/include/trace/events/shmem.h
index 7a0050a1686f..72b20d6b3caf 100644
--- a/include/trace/events/shmem.h
+++ b/include/trace/events/shmem.h
@@ -80,6 +80,61 @@ TRACE_EVENT(shmem_swapin_folio,
 		  __entry->fallback_error, __entry->error)
 );
 
+#define SHMEM_ALLOC_ALLOC	0
+#define SHMEM_ALLOC_CHARGE	1
+#define SHMEM_ALLOC_CACHE		2
+#define SHMEM_ALLOC_ACCOUNT	3
+#define SHMEM_ALLOC_DONE		4
+#define SHMEM_ALLOC_FILTER	5
+
+TRACE_EVENT(shmem_alloc_folio_finish,
+
+	TP_PROTO(struct inode *inode, pgoff_t index,
+		 int requested_order, int suitable_order, int actual_order,
+		 unsigned int stage, int error, int ret),
+
+	TP_ARGS(inode, index, requested_order, suitable_order, actual_order,
+		stage, error, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(unsigned long, index)
+		__field(int, requested_order)
+		__field(int, suitable_order)
+		__field(int, actual_order)
+		__field(unsigned int, stage)
+		__field(int, error)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->index = index;
+		__entry->requested_order = requested_order;
+		__entry->suitable_order = suitable_order;
+		__entry->actual_order = actual_order;
+		__entry->stage = stage;
+		__entry->error = error;
+		__entry->ret = ret;
+	),
+
+	TP_printk("dev=%d:%d ino=%lu index=%lu requested_order=%d suitable_order=%d actual_order=%d stage=%s error=%d ret=%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->index,
+		  __entry->requested_order, __entry->suitable_order,
+		  __entry->actual_order,
+		  __print_symbolic(__entry->stage,
+				   { SHMEM_ALLOC_ALLOC, "alloc" },
+				   { SHMEM_ALLOC_CHARGE, "charge" },
+				   { SHMEM_ALLOC_CACHE, "cache" },
+				   { SHMEM_ALLOC_ACCOUNT, "account" },
+				   { SHMEM_ALLOC_DONE, "done" },
+				   { SHMEM_ALLOC_FILTER, "filter" }),
+		  __entry->error, __entry->ret)
+);
+
 #endif /* _TRACE_SHMEM_H */
 
 /* This part must be outside protection */
diff --git a/mm/shmem.c b/mm/shmem.c
index 3b910aec5bcf..68321d61dfdb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2155,17 +2155,23 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 	unsigned long suitable_orders = 0;
 	struct folio *folio = NULL;
 	pgoff_t aligned_index;
+	pgoff_t orig_index = index;
 	long pages;
 	int error, order;
+	int requested_order, suitable_order;
+	int charge_error = 0;
+	unsigned int stage;
 
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		orders = 0;
 
+	requested_order = orders ? highest_order(orders) : 0;
 	if (orders > 0) {
 		suitable_orders = shmem_suitable_orders(inode, vmf,
 							mapping, index, orders);
 
 		order = highest_order(suitable_orders);
+		suitable_order = order;
 		while (suitable_orders) {
 			pages = 1UL << order;
 			aligned_index = round_down(index, pages);
@@ -2181,19 +2187,35 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 			order = next_order(&suitable_orders, order);
 		}
 	} else {
+		suitable_order = 0;
 		pages = 1;
 		folio = shmem_alloc_folio(gfp, 0, info, index);
 	}
-	if (!folio)
+	if (!folio) {
+		if (suitable_order < 0)
+			trace_shmem_alloc_folio_finish(inode, orig_index,
+						       requested_order,
+						       suitable_order, -1,
+						       SHMEM_ALLOC_FILTER, 0,
+						       -ENOMEM);
+		else
+			trace_shmem_alloc_folio_finish(inode, orig_index,
+						       requested_order,
+						       suitable_order, -1,
+						       SHMEM_ALLOC_ALLOC, -ENOMEM,
+						       -ENOMEM);
 		return ERR_PTR(-ENOMEM);
+	}
 
 allocated:
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 
 	gfp &= GFP_RECLAIM_MASK;
+	stage = SHMEM_ALLOC_CHARGE;
 	error = mem_cgroup_charge(folio, fault_mm, gfp);
 	if (error) {
+		charge_error = error;
 		if (xa_find(&mapping->i_pages, &index,
 				index + pages - 1, XA_PRESENT)) {
 			error = -EEXIST;
@@ -2208,10 +2230,12 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 		goto unlock;
 	}
 
+	stage = SHMEM_ALLOC_CACHE;
 	error = shmem_add_to_page_cache(folio, mapping, index, NULL, gfp);
 	if (error)
 		goto unlock;
 
+	stage = SHMEM_ALLOC_ACCOUNT;
 	error = shmem_inode_acct_blocks(inode, pages);
 	if (error) {
 		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
@@ -2242,9 +2266,17 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 
 	shmem_recalc_inode(inode, pages, 0);
 	folio_add_lru(folio);
+	if (folio_order(folio) < requested_order)
+		trace_shmem_alloc_folio_finish(inode, orig_index,
+					       requested_order, suitable_order,
+					       folio_order(folio),
+					       SHMEM_ALLOC_DONE, 0, 0);
 	return folio;
 
 unlock:
+	trace_shmem_alloc_folio_finish(inode, orig_index, requested_order,
+				       suitable_order, folio_order(folio), stage,
+				       charge_error ?: error, error);
 	folio_unlock(folio);
 	folio_put(folio);
 	return ERR_PTR(error);
-- 
2.25.1

