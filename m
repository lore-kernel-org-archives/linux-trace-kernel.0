Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0E4C9017
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525893; cv=none; b=Ed5QN7uZ//oWnx5Yjxh9E36YX7O0Lh/W0CFd37HKxYEGawcyAeTrSq6X4RkNmH+w9uMjWdY/M7+L7RLZjEUZ6O2WpDWqKYYzFepv6WeGhEVd2sWa0FaboRm9TCY4VdCaWkK/X7QLbOY1GizKZhvapP4KCc2aRNvAipIM7K5rJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525893; c=relaxed/simple;
	bh=W2pNCSRgiTMPwligOYn2/kINsQKSeuhMJrrb0eSPWTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VB9mzbwp5jNMfhNVGHek2TMo1gEsHgtk2tPJceBC2pBG28SBUecDL3HoJPHcqS+g09VwPhZUJtU/qJJFtUYFDJWjNsn4VfLjYz333z/2johcOaLJJKr/Xfc5ptXktsoVp2oeV7PLzNsZVdy56ezRrDMUAIIR9llkOWnAYAjehf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQz97wjU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQz97wjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778525891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oNsjune8AgX3ZJqUXwC46MzLj/0i13SmM4jWdVs6uOE=;
	b=cQz97wjURO5jRLnTej3wnDgu7g2qmXcvNUBdprCNU6xstJhXs2dl3og8jTkYPoIjeYrXCP
	Xvc+S6+wHNstGJRh3X8aCfj7X+pGYormo2rVkVH7p4dqgqKCNelOolDaqS0yFmUADYIdlD
	3+0yHnZ8n9QTUbZS8OR31DBIrNtlKcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-oSQbW2fWPUyR_ujO9BZBCA-1; Mon,
 11 May 2026 14:58:07 -0400
X-MC-Unique: oSQbW2fWPUyR_ujO9BZBCA-1
X-Mimecast-MFC-AGG-ID: oSQbW2fWPUyR_ujO9BZBCA_1778525886
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DBBE1800343;
	Mon, 11 May 2026 18:58:06 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.44.22.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49CDC30001BE;
	Mon, 11 May 2026 18:57:43 +0000 (UTC)
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
Subject: [PATCH mm-unstable v17 00/14] khugepaged: mTHP support
Date: Mon, 11 May 2026 12:58:00 -0600
Message-ID: <20260511185817.686831-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 78bjUaj8PTqp9y6QsTkv6_m4-tYd9LTIbG7okyXwkRo_1778525886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Patch 4:     Generalize __collapse_huge_page_* for mTHP support
Patch 5:     Require collapse_huge_page to enter/exit with the lock dropped
Patch 6:     Generalize collapse_huge_page for mTHP collapse
Patch 7:     Skip collapsing mTHP to smaller orders
Patch 8-9:   Add per-order mTHP statistics and tracepoints
Patch 10:    Introduce collapse_allowable_orders helper function
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

V17 Changes:
- Added Acks/RB
- New patch(5): split the mmap_read_unlock() locking contract change out of
  "generalize collapse_huge_page" into its own patch; add a comment
  documenting the enter/exit-with-lock-dropped contract (Usama, David)
- [patch 03] Add const to max_ptes_none/shared/swap variables; improve the
  three helper docstrings; replace the paragraphs with inline comments;
  note that sysctl values are now snapshotted once per scan (Usama, David)
- [patch 04] Add SCAN_INVALID_PTES_NONE result code and return it instead
  of SCAN_FAIL when collapse_max_ptes_none() returns -EINVAL (Usama);
  snapshot khugepaged_max_ptes_none into a local variable to fix race on
  the two comparisons (Usama); clean up mTHP docstring paragraphs into
  inline comments; fix commit message wording (David)
- [patch 06] Remove /* PMD collapse */ and /* mTHP collapse */ comments
  (David); move const declarations to top of variable list (David); add
  comment explaining that map_anon_folio_pte_nopf() calls set_ptes under
  pmd_ptl and is safe because PMD is expected to be none (Usama)
- [patch 08] Shorten sysfs counter documentation for
  collapse_exceed_swap/shared_pte to concise one-liners; trim
  collapse_exceed_none_pte description; fix "dont" → "do not" (David)
- [patch 10] Keep vm_flags parameter in khugepaged_enter_vma() and
  collapse_allowable_orders() rather than dropping it and reading
  vma->vm_flags internally; pass vm_flags explicitly at all three
  collapse_allowable_orders() call sites (David, sashskio)
- [patch 11] Fix MTHP_STACK_SIZE: was exponential (~128); correct formula
  is (height + 1) for a DFS on a binary tree rewrite comment to explain
  the DFS sizing (sashskio)
- [patch 12] Replace SCAN_PAGE_LRU with SCAN_PAGE_LAZYFREE in the
  "goto next_order" early-bail cases; non-LRU page failures cannot be
  recovered at any order and belong in the default (return) path
- [patch 13] Use tva_flags == TVA_KHUGEPAGED (strict equality) instead of
  tva_flags & TVA_KHUGEPAGED; flatten nested if into single condition;
  retain vm_flags parameter; pass vm_flags to collapse_allowable_orders()

V16: https://lore.kernel.org/all/20260419185750.260784-1-npache@redhat.com
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
  mm/khugepaged: introduce collapse_allowable_orders helper function
  mm/khugepaged: Introduce mTHP collapse support
  mm/khugepaged: avoid unnecessary mTHP collapse attempts
  Documentation: mm: update the admin guide for mTHP collapse

 Documentation/admin-guide/mm/transhuge.rst |  71 ++-
 include/linux/huge_mm.h                    |   5 +
 include/trace/events/huge_memory.h         |  37 +-
 mm/huge_memory.c                           |  11 +
 mm/khugepaged.c                            | 625 ++++++++++++++++-----
 5 files changed, 579 insertions(+), 170 deletions(-)


base-commit: e9dd96806dbc2d50a66770b6a86962bd5d601153
-- 
2.54.0

