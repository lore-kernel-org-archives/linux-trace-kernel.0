Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57963ED5A6
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676028; cv=none; b=DvegUKTpbtVcyLWvZKrp/Go3HENK7OIjuD9n/SqeSDdK6PTsGuhHAL6eDoDdVuMhZdCk0ZdB9jxwrhN6UpaTrlHKTeInIU5m3TqM1yS3y/PgLung0PoQH0qYBs7JOTALAKqnmvNKFIA/AGIKBnaKaYqSntW8BY2zraHHdlr9lsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676028; c=relaxed/simple;
	bh=KxvLLEf3L+qn0IoFoO2VvGAcQ9AXKBtaOWPgwcDOP7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=MVrNQKvUX0A/Y8wXaBPp239C0mFhVVRW8MEUxJPYROdRp7QkJ+yKTYdKPF3g13dhmVKl6AJz6qJNELdh0TS+0NRC+rk/T3ffnby/VTw7h5fmwfpQ09vE3X2H2J4CNbynknRwu93+L9DubVGBvpKQcSmqWf6zrfQmNan6TfRqGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFAtMgds; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFAtMgds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780676024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A4y+MelSbX2M+ZZatm09vxhIOL+bctnk296UHynr2zs=;
	b=QFAtMgdsNQbMk8OaHd0JD0bFabOk2F7WvmwKWYgbwyWTqUK3+5gCxOqErtsrFwBa4btNIn
	QtcmkuW8F0IlaxSwPtCGrumGfTEagi1KjbzSJWZ5FZR7dDBgpYprxfc6MaAKeEvkPus7O9
	WWYX+1HRUiA7LcJ2nuxFc1WCav0iNH4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-pLsb70pbPJ6lrOLJMIxNJA-1; Fri,
 05 Jun 2026 12:13:43 -0400
X-MC-Unique: pLsb70pbPJ6lrOLJMIxNJA-1
X-Mimecast-MFC-AGG-ID: pLsb70pbPJ6lrOLJMIxNJA_1780676022
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17CB81944D29;
	Fri,  5 Jun 2026 16:13:42 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.44.22.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF35C180049F;
	Fri,  5 Jun 2026 16:13:17 +0000 (UTC)
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
	zokeefe@google.com
Subject: [PATCH mm-unstable v19 00/14] khugepaged: add mTHP collapse support
Date: Fri,  5 Jun 2026 10:14:07 -0600
Message-ID: <20260605161422.213817-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: xLvCvYcK6xxtv2kT7ApgQyRuj14sEAqczrzZKRhZoyo_1780676022
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
and mTHP collapse will default to max_ptes_none=0. If a mTHP collapse is
attempted, but contains swapped out, or shared pages, we don't perform
the collapse.
It is now also possible to collapse to mTHPs without requiring the PMD THP
size to be enabled. These limitations are to prevent collapse "creep"
behavior. This prevents constantly promoting mTHPs to the next available
size, which would occur because a collapse introduces more non-zero pages
that would satisfy the promotion condition on subsequent scans.

Patch 1-2:   Generalize hugepage_vma_revalidate and alloc_charge_folio
             for arbitrary orders.
Patch 3:     Rework max_ptes_* handling into helper functions
Patch 4:     Generalize __collapse_huge_page_* for mTHP support
Patch 5:     Require collapse_huge_page to enter/exit with the lock dropped
Patch 6:     Generalize collapse_huge_page for mTHP collapse
Patch 7:     Skip collapsing mTHP to smaller orders
Patch 8-9:   Add per-order mTHP statistics and tracepoints
Patch 10:    Introduce collapse_possible_orders helper functions
Patch 11-13: Introduce bitmap and mTHP collapse support, fully enabled
Patch 14:    Documentation

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

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/

V19 Changes:
- Rebased onto mm-unstable (base: 9282f9bdbdf2, where v18 was based)
- Added RBs/Acks
- [patch 04] Make max_ptes_none const; guard pr_warn_once with
  check so we only warn for non-zero intermediate values and use a single
  "return 0" path (David)
- [patch 06] Add comment explaining the mmu_notifier_range covers only
  the modified PTE range (David); change BUG_ON to VM_WARN_ON_ONCE
  (David); fix update_mmu_cache_range() arch safety issue: reinstall
  PMD via pmd_populate() before calling map_anon_folio_pte_nopf() and
  hold the PTE lock nested inside pmd_ptl during the operation (David,
  Lance); drop the now-unnecessary smp_wmb() as __folio_mark_uptodate()
  provides the required ordering (David, Lance)
- [patch 07] Clarify commit message: "mTHP to a folio of equal or
  smaller size, possibly resulting in a partially mapped source folio"
  (David)
- [patch 08] Add Lorenzo's RB and David's Ack; move TODO comment about
  shared pages to patch 4 (David)
- [patch 10] Rename collapse_allowable_orders() to
  collapse_possible_orders() and add collapse_possible() boolean wrapper
  for callers that only need a yes/no answer (David)
- [patch 11] Major rework: replace the DFS stack-based algorithm with a
  simpler linear forward-walking approach using offset + order (David);
  remove mthp_range struct, mthp_bitmap_stack[], stack push/pop
  functions, and MTHP_STACK_SIZE; add max_order_from_offset() helper
  using __ffs(offset) for natural alignment; rename mthp_bitmap to
  mthp_present_ptes (David); remove temporary mthp_bitmap_mask and use
  bitmap_weight_from() directly (David); fix result propagation so
  mthp_collapse() returns enum scan_result and properly propagates
  SCAN_ALLOC_HUGE_PAGE_FAIL and SCAN_PTE_MAPPED_HUGEPAGE to callers
  (Lance); fold in v18 fixup for potential use-after-free of vma in
  mthp_collapse() by passing NULL to collapse_max_ptes_none()
- [patch 12] Rework to match new linear algorithm; expand the set of
  failures that allow retrying at a lower order
- [patch 14] Re-add note about file/shmem still only collapsing to
  PMD-sized THPs (David)

Baolin Wang (1):
  mm/khugepaged: run khugepaged for all orders

Dev Jain (1):
  mm/khugepaged: generalize alloc_charge_folio()

Nico Pache (12):
  mm/khugepaged: generalize hugepage_vma_revalidate for mTHP support
  mm/khugepaged: rework max_ptes_* handling with helper functions
  mm/khugepaged: generalize __collapse_huge_page_* for mTHP support
  mm/khugepaged: require collapse_huge_page to enter/exit with the lock
    dropped
  mm/khugepaged: generalize collapse_huge_page for mTHP collapse
  mm/khugepaged: skip collapsing mTHP to smaller orders
  mm/khugepaged: add per-order mTHP collapse failure statistics
  mm/khugepaged: improve tracepoints for mTHP orders
  mm/khugepaged: introduce collapse_possible_orders helper functions
  mm/khugepaged: Introduce mTHP collapse support
  mm/khugepaged: avoid unnecessary mTHP collapse attempts
  Documentation: mm: update the admin guide for mTHP collapse

 Documentation/admin-guide/mm/transhuge.rst |  71 ++-
 include/linux/huge_mm.h                    |   5 +
 include/trace/events/huge_memory.h         |  34 +-
 mm/huge_memory.c                           |  11 +
 mm/khugepaged.c                            | 616 ++++++++++++++++-----
 5 files changed, 569 insertions(+), 168 deletions(-)


base-commit: 9282f9bdbdf22a1914f0b085f2fe5e8141cbc3de
-- 
2.54.0

