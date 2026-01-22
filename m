Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A82F1FD0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110355; cv=none; b=WoqpEcOmj+5ALSZRXafpUxFri1UzmOcVGGbJietQkUvqB54pcqjDkT5dWrbxPekZ3Ic6DYFOwmRSMmIO8zZAq+qi9+KqxnFS0PnZ3HPs8DbvSV4/Pcfnm+JwxkQ5JW12PFPP25xaUu1uzI8hfIjf5nKaJQOp2nRVcDflltGIrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110355; c=relaxed/simple;
	bh=ztCthO/TGdyWb+8Xz3iOVJJ8BeVpOSTqhzIoFrjD1cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESNpttIZfrGP8oQ9pcTFdx/u8zZtkpDMbiOAgh0DasK6bO4YW92+iqE3Y8ZYPsO5yqDy3A04uAmqirR6fVYRDU7PwZTgN7Fnhq5bv0qDKjU4q4gJPPSW68DhTb4/k4JcaS9aMQ/tsFCYMHkcrjdEft883hfFlFw/gssuDYy0wLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUVWBxJu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUVWBxJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769110342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RhMmE0j15+AytfNHqSYxoudGtkDedyV3jj2GyoY8E=;
	b=YUVWBxJuOpmxV1+aM+SP+dOAMbSCgfpqkPJa3BtSqWlHQc28FJ0dMOFDNE6KgnhfZ+IcTT
	DvKUK5z452wBA49p0ArIG/OPazIlfoBQJEnzfsfwGyFNYrYTdBPP65xEeZSomJDrtwY2xX
	5PQrAya5ooeLLHcOuPKTLMU+N3tUeJw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-jGStdGjWMo27TlKmqq4KjA-1; Thu,
 22 Jan 2026 14:32:21 -0500
X-MC-Unique: jGStdGjWMo27TlKmqq4KjA-1
X-Mimecast-MFC-AGG-ID: jGStdGjWMo27TlKmqq4KjA_1769110340
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E4361944F12;
	Thu, 22 Jan 2026 19:32:20 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D8091958DC1;
	Thu, 22 Jan 2026 19:32:11 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: npache@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
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
	zokeefe@google.com,
	rientjes@google.com,
	rdunlap@infradead.org,
	hughd@google.com,
	richard.weiyang@gmail.com
Subject: [PATCH mm-unstable v14 14/16] khugepaged: avoid unnecessary mTHP collapse attempts
Date: Thu, 22 Jan 2026 12:28:39 -0700
Message-ID: <20260122192841.128719-15-npache@redhat.com>
In-Reply-To: <20260122192841.128719-1-npache@redhat.com>
References: <20260122192841.128719-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There are cases where, if an attempted collapse fails, all subsequent
orders are guaranteed to also fail. Avoid these collapse attempts by
bailing out early.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5947faaba85f..344f7cec55b4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1499,9 +1499,42 @@ static int mthp_collapse(struct mm_struct *mm, unsigned long address,
 			ret = collapse_huge_page(mm, collapse_address, referenced,
 						 unmapped, cc, mmap_locked,
 						 order);
-			if (ret == SCAN_SUCCEED) {
+
+			switch (ret) {
+			/* Cases were we continue to next collapse candidate */
+			case SCAN_SUCCEED:
 				collapsed += nr_pte_entries;
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
+			/* Cases were no further collapse is possible */
+			case SCAN_CGROUP_CHARGE_FAIL:
+			case SCAN_COPY_MC:
+			case SCAN_ADDRESS_RANGE:
+			case SCAN_NO_PTE_TABLE:
+			case SCAN_ANY_PROCESS:
+			case SCAN_VMA_NULL:
+			case SCAN_VMA_CHECK:
+			case SCAN_SCAN_ABORT:
+			case SCAN_PAGE_ANON:
+			case SCAN_PMD_MAPPED:
+			case SCAN_FAIL:
+			default:
+				return collapsed;
 			}
 		}
 
-- 
2.52.0

