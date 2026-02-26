Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C25387359
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076361; cv=none; b=SUMW1HPhIFG8B1Q+pehmjuEnf0a+neSxV1ggy+Szb6Ak6wc/h7v3ejnmNO3Yctdm5SUNnHC0HUj1LJqOVop/pxAlwDPItAFUsHaKYSb7u8Zz5nTGz6lLev7x0uRVyIXaR39akBVagTs49K36W6DEW7F5Dv7DropeNetualJCRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076361; c=relaxed/simple;
	bh=obCRZc9oJcZON6KZf9oTdNSQebSXvtiFtpSSDQIrPzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UHfWoSN+IOJqQgphaQfvmdTdPdHGRl0nimw6T3uRij/dpWcw1nmaCcj8fiRpdEA4vwZ+l9Xq2WwguNzzNLCwH/5U5poaFA86Z6LUHPfA7Q6gNR/N0yIH4tdZnjnPN97RvKjQpSX+KuDBi72MdotmAQ2zrNEYmLl7eneX8gl2mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHH3bc8u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHH3bc8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772076359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hrj5LiTC77G7ZSzwqbk3lQXbCqvEX1Hq2YmAwZjmAZU=;
	b=PHH3bc8umziwWG7cS5DLI3aWZ444nm3KAP+ahcqooixh1zsHg3jba8L3JuM+bf4Vk7gDS8
	BniknstgGYyQfj6hh1vVu+1TwK2iUSmfb5xeH4Vz5Rl1vsx0+M0RS+ie7yd+ob5upe72dE
	+QvJsQ/NpaCwyNj1x4KPbppB2E8enAE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-rSU4vvJUMgeswmdfQjWCbQ-1; Wed,
 25 Feb 2026 22:25:55 -0500
X-MC-Unique: rSU4vvJUMgeswmdfQjWCbQ-1
X-Mimecast-MFC-AGG-ID: rSU4vvJUMgeswmdfQjWCbQ_1772076354
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C88941956067;
	Thu, 26 Feb 2026 03:25:54 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E844819560B6;
	Thu, 26 Feb 2026 03:25:44 +0000 (UTC)
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
Subject: [PATCH mm-unstable v15 09/13] mm/khugepaged: introduce collapse_allowable_orders helper function
Date: Wed, 25 Feb 2026 20:25:42 -0700
Message-ID: <20260226032542.233891-1-npache@redhat.com>
In-Reply-To: <20260226031741.230674-1-npache@redhat.com>
References: <20260226031741.230674-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: UnvS4tJ7f6wfB08lvtZpnnalnbUkb2zsHMOF5Qow__0_1772076354
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add collapse_allowable_orders() to generalize THP order eligibility. The
function determines which THP orders are permitted based on collapse
context (khugepaged vs madv_collapse).

This consolidates collapse configuration logic and provides a clean
interface for future mTHP collapse support where the orders may be
different.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2e66d660ee8e..2fdfb6d42cf9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -486,12 +486,22 @@ static unsigned int collapse_max_ptes_none(unsigned int order)
 	return -EINVAL;
 }
 
+/* Check what orders are allowed based on the vma and collapse type */
+static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
+			vm_flags_t vm_flags, bool is_khugepaged)
+{
+	enum tva_type tva_flags = is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
+	unsigned long orders = BIT(HPAGE_PMD_ORDER);
+
+	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
+}
+
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
 	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
 	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
+		if (collapse_allowable_orders(vma, vm_flags, /*is_khugepaged=*/true))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -2637,7 +2647,7 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *
 			progress++;
 			break;
 		}
-		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
+		if (!collapse_allowable_orders(vma, vma->vm_flags, /*is_khugepaged=*/true)) {
 			progress++;
 			continue;
 		}
@@ -2949,7 +2959,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON(vma->vm_start > start);
 	BUG_ON(vma->vm_end < end);
 
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
+	if (!collapse_allowable_orders(vma, vma->vm_flags, /*is_khugepaged=*/false))
 		return -EINVAL;
 
 	cc = kmalloc_obj(*cc);
-- 
2.53.0

