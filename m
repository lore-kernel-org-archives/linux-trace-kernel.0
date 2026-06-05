Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14C3B42C4
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676257; cv=none; b=Y5tJGVBhhkKS6UVehdMiXjU2gF6eJb1MsVt4Sqm8krepZvPJ38Od7p8oDZoSAm7qTG8y3PyVWJJU4vqlERbMP3pI25N8D7XLOvJ3Qd8dQU0snWG3+zm8gXNY/oIvFii60y7QO7WHLAEKNT6VDvi6g2ME8rbQVX6aXeqg6Q8HY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676257; c=relaxed/simple;
	bh=Jbsd3RFvzZia6KfmmcZB95qCmS885EPyGk6VJN12EZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lJ8fPYLgSFDpTFcBUAqLfxVWmehuaJ1y52z68WfKepIgZ66iniM7cg5zpNr4VmJPF0ol7+1ijgKDvRye84NL/GoHJh033e2QoZ2vW7bFbqhN4GmlydnIlGXnuepUGIYUhzX7a/0M2OpbmiwC0SDytLkUEpFS+AzQY2yxkIAcvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIBQccUn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIBQccUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780676255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=duJTZJog/IvaQNcYHxOllCKMt0JMc5PBsQeEuw3a1uk=;
	b=HIBQccUn+w5qu6p9+cNgCmT8sT4MhRBj8ZhXuSWEj8CyEokuEoWn9rHn44awd1L5IGe2v0
	Q0mJQs0/L8Tfj3zcOoFj5jwUPZwLV0GklWF+jF+781ORwnnckdgN3gLt7Gj20Oq3mtdkPj
	ihsN4TfLifdhCFnxTRcb8x/A4VmZqOY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-LIpes0QPPVuIxpV-J_iW3A-1; Fri,
 05 Jun 2026 12:17:31 -0400
X-MC-Unique: LIpes0QPPVuIxpV-J_iW3A-1
X-Mimecast-MFC-AGG-ID: LIpes0QPPVuIxpV-J_iW3A_1780676250
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F21B9180061E;
	Fri,  5 Jun 2026 16:17:29 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.44.22.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36F2D1800351;
	Fri,  5 Jun 2026 16:17:11 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	jackmanb@google.com,
	jannh@google.com,
	jglisse@google.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	ljs@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	npache@redhat.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rakie.kim@sk.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shivankg@amd.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	zokeefe@google.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH mm-unstable v19 12/14] mm/khugepaged: avoid unnecessary mTHP collapse attempts
Date: Fri,  5 Jun 2026 10:14:19 -0600
Message-ID: <20260605161422.213817-13-npache@redhat.com>
In-Reply-To: <20260605161422.213817-1-npache@redhat.com>
References: <20260605161422.213817-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: whixvu6jDmMQR5M2rBQopGr9R77Dyde64ymRz3ovl08_1780676250
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

There are cases where, if an attempted collapse fails, all subsequent
orders are guaranteed to also fail. Avoid these collapse attempts by
bailing out early.

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: Usama Arif <usama.arif@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 430047316f43..7de92b28dd30 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1499,6 +1499,7 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
 			collapse_address = address + offset * PAGE_SIZE;
 			ret = collapse_huge_page(mm, collapse_address, referenced,
 						 unmapped, cc, order);
+
 			switch (ret) {
 			/* Cases where we continue to next collapse candidate */
 			case SCAN_SUCCEED:
@@ -1509,6 +1510,18 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
 			/* Cases where lower orders might still succeed */
 			case SCAN_ALLOC_HUGE_PAGE_FAIL:
 				alloc_failed = true;
+				fallthrough;
+			case SCAN_LACK_REFERENCED_PAGE:
+			case SCAN_EXCEED_NONE_PTE:
+			case SCAN_EXCEED_SWAP_PTE:
+			case SCAN_EXCEED_SHARED_PTE:
+			case SCAN_PAGE_LOCK:
+			case SCAN_PAGE_COUNT:
+			case SCAN_PAGE_NULL:
+			case SCAN_DEL_PAGE_LRU:
+			case SCAN_PTE_NON_PRESENT:
+			case SCAN_PTE_UFFD_WP:
+			case SCAN_PAGE_LAZYFREE:
 				last_result = ret;
 				goto next_order;
 			/* Cases where no further collapse is possible */
-- 
2.54.0

