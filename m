Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74006263C8C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625122; cv=none; b=AbVXST+LcjbbODvYlR1vCJxafB50aPxy47u2CIi3QZwZvDi5jlPPBksQ/cti7Ipctl9DrgZ6Qn7imLiZDPK7OznD7k9v7zQJ+PcrIMhaiSg5Zz34xF9sZ0Nk6VqDMjrs8iFHG4yw25eWtAV6rvE+AaZVrrd1w5DnXMxIgXEKvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625122; c=relaxed/simple;
	bh=KxyOm/oivm0BpTIm7i8kXRVzm0f7MN13ba2p+o3ikYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=c5+8YVUgU6qit7Zwo1/xUUqkDBE6PCWtWf61kAjUVeCzWyK8KUlA40rygQEbsQrW3IjsUdDemlHqP0uBwWlH7T3jnmF8UH1CdUdHoy8RG6rz8zp/pFo+7a4hp/9ADdZOGLTc4yPZJEU3v243hcAODu91yeTTE0ySqpKSgq2iTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrN/eYd6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrN/eYd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776625119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yy5vk9Dp4ItrgUo2V4M7nrMoaDvOeSA2Soef+4DJRew=;
	b=BrN/eYd66FaS6RagSlvhyXhwozAmA7E9VhkF6ybA5pG43ttVKNYjJI4SfWOdZC+mga3Se0
	LE81IPVdYoIfXud8q+p47QZrxfnVNRvsVxWJIXiMThdDSRTDn7u9aj6CRujTahAbiSvMBe
	QI/r3YT8tLgUFY4tkH9MYMWDMVVr4fE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-HXVqmU7gNNK66kPtndohEw-1; Sun,
 19 Apr 2026 14:58:36 -0400
X-MC-Unique: HXVqmU7gNNK66kPtndohEw-1
X-Mimecast-MFC-AGG-ID: HXVqmU7gNNK66kPtndohEw_1776625115
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EB41195608D;
	Sun, 19 Apr 2026 18:58:35 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7F571956095;
	Sun, 19 Apr 2026 18:58:13 +0000 (UTC)
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
	zokeefe@google.com
Subject: [PATCH 7.2 v16 00/13] khugepaged: mTHP support
Date: Sun, 19 Apr 2026 12:57:37 -0600
Message-ID: <20260419185750.260784-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 5H1jjVMuEhWQHv5Mw7Y4xnm8NavPZtMYTAvq2Xm5Tok_1776625115
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The following series provides khugepaged with the capability to collapse
anonymous memory regions to mTHPs.

To achieve this we generalize the khugepaged functions to no longer depend
on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
pages that are occupied (!none/zero). After the PMD scan is done, we use
the bitmap to find the optimal mTHP sizes for the PMD range. The
restriction on max_ptes_none is removed during the scan, to make sure we
account for the whole PMD range in the bitmap. When no mTHP size is
enabled, the legacy behavior of khugepaged is maintained.

We currently only support max_ptes_none values of 0 or HPAGE_PMD_NR - 1
(ie 511). If any other value is specified, the kernel will emit a warning
and no mTHP collapse will be attempted. If a mTHP collapse is attempted,
but contains swapped out, or shared pages, we don't perform the collapse.
It is now also possible to collapse to mTHPs without requiring the PMD THP
size to be enabled. These limitations are to prevent collapse "creep"
behavior. This prevents constantly promoting mTHPs to the next available
size, which would occur because a collapse introduces more non-zero pages
that would satisfy the promotion condition on subsequent scans.


Patch 1-2:   Generalize hugepage_vma_revalidate and alloc_charge_folio
	     for arbitrary orders.
Patch 3:     Rework max_ptes_* handling into helper functions
Patch 4-5:   Generalize __collapse_huge_page_* and collapse_huge_page
Patch 6:     Skip collapsing mTHP to smaller orders
Patch 7-8:   Add per-order mTHP statistics and tracepoints
Patch 9:     Introduce collapse_allowable_orders helper function
Patch 10-12: Introduce bitmap and mTHP collapse support, fully enabled
Patch 13:    Documentation

Testing:
- Built for x86_64, aarch64, ppc64le, and s390x
- ran all arches on test suites provided by the kernel-tests project
- internal testing suites: functional testing and performance testing
- selftests mm
- I created a test script that I used to push khugepaged to its limits
   while monitoring a number of stats and tracepoints. The code is
   available here[1] (Run in legacy mode for these changes and set mthp
   sizes to inherit)
   The summary from my testings was that there was no significant
   regression noticed through this test. In some cases my changes had
   better collapse latencies, and was able to scan more pages in the same
   amount of time/work, but for the most part the results were consistent.
- redis testing. I did some testing with these changes along with my defer
  changes (see followup [2] post for more details). We've decided to get
  the mTHP changes merged first before attempting the defer series.
- some basic testing on 64k page size.
- lots of general use.

V16 Changes:
- This was quite the respin, so hopefully everything is ok! I dropped
  some acks/rb on patches that changed significantly. Major changes
  are related to the locking cleanup in collapse_huge_page().
  sorry if i missed any feedback there was quite a bit of minor requests
- New cleanup patch: introduce collapse_max_ptes_none/shared/swap()
  helpers, absorbing madvise_collapse special-casing (David)
- Merge "introduce collapse_max_ptes_none helper" into the generalize
  __collapse_huge_page_* patch, dropping the separate patch (David)
- Simplify collapse_huge_page() locking: move mmap_read_unlock() to
  caller, remove mmap_locked tracking parameter entirely (Lorenzo)
- Use enum tva_type instead of bool is_khugepaged in
  collapse_allowable_orders() (David, Lorenzo)
- collapse_allowable_orders() takes (vma, tva_flags), accesses
  vma->vm_flags internally (Lorenzo)
- Rename mthp_* functions to collapse_mthp_* prefix (David, Lorenzo)
- Use MAX_PTRS_PER_PTE consistently for bitmap ops (Lorenzo)
- Downgrade BUG_ON() to WARN_ON_ONCE() in collapse_huge_page() (Lorenzo)
- Add /*expect_anon=*/true annotation to revalidate calls (Lorenzo)
- Pull common spin_lock + WARN_ON_ONCE out of PMD/mTHP branch (Lorenzo)
- Fix pteval declaration style; use end_addr variable (Lorenzo)
- Use ternary for result assignment in collapse_scan_pmd() (Lorenzo)
- Improve anon_vma locking comment for mTHP case (Lorenzo)
- Document why skip-smaller-order isn't done in scan phase (David)
- Make documentation of max_ptes_none mTHP behavior (only 0 and
  HPAGE_PMD_NR-1 supported) in admin guide more apparent. (David, Lorenzo)
- Collect new Acks/RB tags from v15 review

V15: https://lore.kernel.org/all/20260226031741.230674-1-npache@redhat.com
V14: https://lore.kernel.org/all/20260122192841.128719-1-npache@redhat.com
V13: https://lore.kernel.org/all/20251201174627.23295-1-npache@redhat.com
V12: https://lore.kernel.org/all/20251022183717.70829-1-npache@redhat.com
V11: https://lore.kernel.org/all/20250912032810.197475-1-npache@redhat.com
V10: https://lore.kernel.org/all/20250819134205.622806-1-npache@redhat.com
V9 : https://lore.kernel.org/all/20250714003207.113275-1-npache@redhat.com
V8 : https://lore.kernel.org/all/20250702055742.102808-1-npache@redhat.com
V7 : https://lore.kernel.org/all/20250515032226.128900-1-npache@redhat.com
V6 : https://lore.kernel.org/all/20250515030312.125567-1-npache@redhat.com
V5 : https://lore.kernel.org/all/20250428181218.85925-1-npache@redhat.com
V4 : https://lore.kernel.org/all/20250417000238.74567-1-npache@redhat.com
V3 : https://lore.kernel.org/all/20250414220557.35388-1-npache@redhat.com
V2 : https://lore.kernel.org/all/20250211003028.213461-1-npache@redhat.com
V1 : https://lore.kernel.org/all/20250108233128.14484-1-npache@redhat.com

A big thanks to everyone that has reviewed, tested, and participated in
the development process. Its been a great experience working with all of
you on this endeavor.

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/

Baolin Wang (1):
  mm/khugepaged: run khugepaged for all orders

Dev Jain (1):
  mm/khugepaged: generalize alloc_charge_folio()

Nico Pache (11):
  mm/khugepaged: generalize hugepage_vma_revalidate for mTHP support
  mm/khugepaged: rework max_ptes_* handling with helper functions
  mm/khugepaged: generalize __collapse_huge_page_* for mTHP support
  mm/khugepaged: generalize collapse_huge_page for mTHP collapse
  mm/khugepaged: skip collapsing mTHP to smaller orders
  mm/khugepaged: add per-order mTHP collapse failure statistics
  mm/khugepaged: improve tracepoints for mTHP orders
  mm/khugepaged: introduce collapse_allowable_orders helper function
  mm/khugepaged: Introduce mTHP collapse support
  mm/khugepaged: avoid unnecessary mTHP collapse attempts
  Documentation: mm: update the admin guide for mTHP collapse

 Documentation/admin-guide/mm/transhuge.rst |  81 ++-
 include/linux/huge_mm.h                    |   5 +
 include/linux/khugepaged.h                 |   6 +-
 include/trace/events/huge_memory.h         |  34 +-
 mm/huge_memory.c                           |  13 +-
 mm/khugepaged.c                            | 623 ++++++++++++++++-----
 mm/vma.c                                   |   6 +-
 tools/testing/vma/include/stubs.h          |   3 +-
 8 files changed, 589 insertions(+), 182 deletions(-)


base-commit: 4569c01e84d440f1f6c79df1e13e9c86a9fb80ca
--
2.53.0

