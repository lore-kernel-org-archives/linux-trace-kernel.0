Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF1258CF1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647899; cv=none; b=eLsg+kO91ClAZNC5/SNcHdsci55CSwQyjNv066orEeFhCyuax8tSqsT6LoTQlE5bktab2Pu06WADyHrc8iMYxUpQT1ThjsRs0Gb7CZ+9lkNxT0W1ALYzp0vxjGfxT4dW9HRxuk5oxpxLUvo1RA3XsnUPgo32c2sAUqAWwVC58IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647899; c=relaxed/simple;
	bh=ri0YdrH20n1iZNTn51xGNWhcblljB0dVx/6+MetMLjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBG1Ugs9IH9cA/Ixp/xVmXDjaXX6xQW9TW3Fz6fXocjk96Myy+lB5dGQRF11ZVLb99aKMdDzvbFl3yh7HclrhJRpQ96ayh6O0vO09HtuCDByDDFri7ES8AgQTfXHLDZhpVy0Mo0v/NWbNF9HDSYE35+Xg2UniRjw9q0BcFo7evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG5VL8aD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG5VL8aD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757647895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WkSS2x1APmP4WSa/KdkdNQb+giopwv0nFFtO61rokc=;
	b=QG5VL8aDvjXb+lWdXmuMxlu52CiUl9XUdOoCeKczsH4LZsV6laN/7Dfh06VBivPiINNFJS
	tjAu3mohmKaGPtmlbxkcN7ErXw1z5dYIXCZTAvbQMpUrtJHl6v+SIsyT4ZSvoVLS1L1Fui
	fZtl71QOnWXmlbKxDl6G7jvbz3wHRT4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-8MqFEGeOPS2NV-lcySUhFw-1; Thu,
 11 Sep 2025 23:31:32 -0400
X-MC-Unique: 8MqFEGeOPS2NV-lcySUhFw-1
X-Mimecast-MFC-AGG-ID: 8MqFEGeOPS2NV-lcySUhFw_1757647887
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C9471956086;
	Fri, 12 Sep 2025 03:31:27 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68CC81800451;
	Fri, 12 Sep 2025 03:31:18 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	willy@infradead.org,
	peterx@redhat.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kas@kernel.org,
	aarcange@redhat.com,
	raquini@redhat.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org,
	hughd@google.com,
	richard.weiyang@gmail.com,
	lance.yang@linux.dev,
	vbabka@suse.cz,
	rppt@kernel.org,
	jannh@google.com,
	pfalcato@suse.de
Subject: [PATCH v11 13/15] khugepaged: avoid unnecessary mTHP collapse attempts
Date: Thu, 11 Sep 2025 21:28:08 -0600
Message-ID: <20250912032810.197475-14-npache@redhat.com>
In-Reply-To: <20250912032810.197475-1-npache@redhat.com>
References: <20250912032810.197475-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

There are cases where, if an attempted collapse fails, all subsequent
orders are guaranteed to also fail. Avoid these collapse attempts by
bailing out early.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8455a02dc3d6..ead07ccac351 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1435,10 +1435,39 @@ static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
 			ret = collapse_huge_page(mm, address, referenced,
 						 unmapped, cc, mmap_locked,
 						 order, offset);
-			if (ret == SCAN_SUCCEED) {
+
+			/*
+			 * Analyze failure reason to determine next action:
+			 * - goto next_order: try smaller orders in same region
+			 * - continue: try other regions at same order
+			 * - break: stop all attempts (system-wide failure)
+			 */
+			switch (ret) {
+			/* Cases were we should continue to the next region */
+			case SCAN_SUCCEED:
 				collapsed += 1UL << order;
+				fallthrough;
+			case SCAN_PTE_MAPPED_HUGEPAGE:
 				continue;
+			/* Cases were lower orders might still succeed */
+			case SCAN_LACK_REFERENCED_PAGE:
+			case SCAN_EXCEED_NONE_PTE:
+			case SCAN_EXCEED_SWAP_PTE:
+			case SCAN_EXCEED_SHARED_PTE:
+			case SCAN_PAGE_LOCK:
+			case SCAN_PAGE_COUNT:
+			case SCAN_PAGE_LRU:
+			case SCAN_PAGE_NULL:
+			case SCAN_DEL_PAGE_LRU:
+			case SCAN_PTE_NON_PRESENT:
+			case SCAN_PTE_UFFD_WP:
+			case SCAN_ALLOC_HUGE_PAGE_FAIL:
+				goto next_order;
+			/* All other cases should stop collapse attempts */
+			default:
+				break;
 			}
+			break;
 		}
 
 next_order:
-- 
2.51.0

