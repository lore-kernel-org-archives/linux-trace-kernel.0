Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8D26C3A2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076303; cv=none; b=mceUCg8IwcSLCBU83XSqC06AWIbCSFirvBObzDaZH6o0Li6wWeQLdNiOWZzPKb7gJpc0FRQVdLiF1bGJZ4Cy8j5m0+Juohqy6QT2wlGjqUnnXtqUoa/oUbeDF0O2i6ZpDx3lvNmYr/YFu998aoME+iG2kQwmBFjR6blEkFPMwt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076303; c=relaxed/simple;
	bh=+c9RsW6skCuOQN+2hqZBUbiRYGIMSrhWIoQ+SsOc4U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FR+oz4J/H50HqCuKW4mQ1M75C4EsDyv+1OHrrw1WfBUWqs2M/QBvQSjdOKaIF9WO0fi5cFNzkHDE4S4GkGhMnABwxMPFIcM6kClZEBQ+ckfSOQcNmeOM+j3mWOi3P43U90PPRqXMwjh0PTOg3Bk3AEzrowA1HZYBG3vM5o9Un2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MygGrYDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MygGrYDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772076302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpC44Hv8Tld3RE64HDzSAIEvSppcKmy+xXlb2CxI4KA=;
	b=MygGrYDgxhAOD0dCes3jl8ZONSaqlcriLrkTXDQqHAAaQ8Kw3s6x45NeQGQ8Wyb+X2wGw5
	DOVzHrQVlLYw/Pvx7wBWnz1Iz507aUTAzA/sPjtkeXPp+AAeVGfNRuUmzMBs9MkKam3tk3
	nRpvRDswp8aiVQ7Dd30G9X1pqGU044M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-FtE6jsC0NJS5jOw0qvk3rQ-1; Wed,
 25 Feb 2026 22:24:58 -0500
X-MC-Unique: FtE6jsC0NJS5jOw0qvk3rQ-1
X-Mimecast-MFC-AGG-ID: FtE6jsC0NJS5jOw0qvk3rQ_1772076297
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 319B6195608F;
	Thu, 26 Feb 2026 03:24:57 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C8361955F43;
	Thu, 26 Feb 2026 03:24:47 +0000 (UTC)
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
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
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
	zokeefe@google.com
Subject: [PATCH mm-unstable v15 06/13] mm/khugepaged: skip collapsing mTHP to smaller orders
Date: Wed, 25 Feb 2026 20:24:45 -0700
Message-ID: <20260226032445.233437-1-npache@redhat.com>
In-Reply-To: <20260226031741.230674-1-npache@redhat.com>
References: <20260226031741.230674-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: q9w4mrCuh921gwwc3iL8C8cB-1XoomHCWX_kK8U81KA_1772076297
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
some pages being unmapped. Skip these cases until we have a way to check
if its ok to collapse to a smaller mTHP size (like in the case of a
partially mapped folio).

This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].

[1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fb3ba8fe5a6c..c739f26dd61e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -638,6 +638,14 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 				goto out;
 			}
 		}
+		/*
+		 * TODO: In some cases of partially-mapped folios, we'd actually
+		 * want to collapse.
+		 */
+		if (!is_pmd_order(order) && folio_order(folio) >= order) {
+			result = SCAN_PTE_MAPPED_HUGEPAGE;
+			goto out;
+		}
 
 		if (folio_test_large(folio)) {
 			struct folio *f;
-- 
2.53.0

