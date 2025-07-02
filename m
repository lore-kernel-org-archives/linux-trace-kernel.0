Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC701D618E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435915; cv=none; b=D1Wa74YPcf0Ebp81KuRB4GSGcGLjQThDzq8P6urVvPM9av+9mwt53i1oE2onTKS1fx0bcl61vuVxDZN5wgXoJqqZCpeJtQwAIsa5Azp0QIG/xmeFnD9PLtPCKASSWhUIOm6kYEHLVQWkqV8w7EIGwKo0jTYjPjRXAaTbBj2R1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435915; c=relaxed/simple;
	bh=26sk2mmyIkvSUFMJhciQNPMuA+iIj17Y+b7xssIMYro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3Xq/IoP+QHOyEgP67aCXjsdyJq6N2mvVpasMisg5NvWGkqPm6Zem20MXszne/WD7aaF5sxsXWh3qegi3LUmlcN9+IUxS68D/620F1CTliSwTyL+Os50JljFWrfaIhGyRxQuJL89c+ciDy2yIRcwkAcQ0iGWpD4xJ1h8f971TfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+DKJ2bK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+DKJ2bK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751435912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ru2BNIktaDm+SjvCr/7YNTm/dRnN+Tk16VM9ar5kfms=;
	b=X+DKJ2bK989wQk9I86YUpYr3jQD+DHJ39sFVU0hmJA0Oci+RvtYuukMwEF5Q8Eh/nUpHHN
	k1v6VztPF+ppxbcMV4fEPeI8UfuzuenItqBety94ou/ySiNlegyvA89MUcsLh0PJ8E1rg7
	5DKgBCekTomB2GePaeYkmweGge+YBhc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-CiiaJfYCOLGC8nmrMt6bHw-1; Wed,
 02 Jul 2025 01:58:29 -0400
X-MC-Unique: CiiaJfYCOLGC8nmrMt6bHw-1
X-Mimecast-MFC-AGG-ID: CiiaJfYCOLGC8nmrMt6bHw_1751435903
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 188311944A8C;
	Wed,  2 Jul 2025 05:58:21 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.112])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7567180045B;
	Wed,  2 Jul 2025 05:58:03 +0000 (UTC)
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
	kirill.shutemov@linux.intel.com,
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
	rdunlap@infradead.org
Subject: [PATCH v8 00/15] khugepaged: mTHP support
Date: Tue,  1 Jul 2025 23:57:27 -0600
Message-ID: <20250702055742.102808-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The following series provides khugepaged and madvise collapse with the
capability to collapse anonymous memory regions to mTHPs.

To achieve this we generalize the khugepaged functions to no longer depend
on PMD_ORDER. Then during the PMD scan, we use a bitmap to track chunks of
pages (defined by KHUGEPAGED_MTHP_MIN_ORDER) that are utilized. After the
PMD scan is done, we do binary recursion on the bitmap to find the optimal
mTHP sizes for the PMD range. The restriction on max_ptes_none is removed
during the scan, to make sure we account for the whole PMD range. When no
mTHP size is enabled, the legacy behavior of khugepaged is maintained.
max_ptes_none will be scaled by the attempted collapse order to determine
how full a mTHP must be to be eligible for the collapse to occur. If a
mTHP collapse is attempted, but contains swapped out, or shared pages, we
don't perform the collapse. It is now also possible to collapse to mTHPs
without requiring the PMD THP size to be enabled.

With the default max_ptes_none=511, the code should keep its most of its
original behavior. When enabling multiple adjacent (m)THP sizes we need to
set max_ptes_none<=255. With max_ptes_none > HPAGE_PMD_NR/2 you will
experience collapse "creep" and constantly promote mTHPs to the next
available size. This is due the fact that a collapse will introduce at
least 2x the number of pages, and on a future scan will satisfy the
promotion condition once again.

Patch 1:     Refactor/rename hpage_collapse
Patch 2:     Some refactoring to combine madvise_collapse and khugepaged
Patch 3-5:   Generalize khugepaged functions for arbitrary orders
Patch 6-9:   The mTHP patches
Patch 10-12: Allow khugepaged to operate without PMD enabled
Patch 13-14: Tracing/stats
Patch 15:    Documentation

---------
 Testing
---------
- Built for x86_64, aarch64, ppc64le, and s390x
- selftests mm
- I created a test script that I used to push khugepaged to its limits
   while monitoring a number of stats and tracepoints. The code is
   available here[1] (Run in legacy mode for these changes and set mthp
   sizes to inherit)
   The summary from my testings was that there was no significant
   regression noticed through this test. In some cases my changes had
   better collapse latencies, and was able to scan more pages in the same
   amount of time/work, but for the most part the results were consistent.
- redis testing. I tested these changes along with my defer changes
  (see followup [3] post for more details). We've decided to get the mTHP
  changes merged first before attempting the defer series.
- some basic testing on 64k page size.
- lots of general use.

V8 Changes:
- Fix mishandled conflict with shmem config changes (Baolin)
- Add Baolin's patches for allowing collapse without PMD enabled
- Add additional patch for allowing madvise_collapse without PMD enabled
- Documentations nits (Randy)
- Simplify SCAN_ANY_PROCESS lock jumbling (Liam)
- Add a BUG_ON to the mTHP collapse similar to PMD (Dev)
- Remove doc comment about khugepaged PMD only limitation (Dev)
- Change revalidation function to accept multiple orders
- Handled conflicts introduced by Lorenzo's madvise changes

V7 (RESEND) [2]

V6 Changes:
- Dont release the anon_vma_lock early (like in the PMD case), as not all
  pages are isolated.
- Define the PTE as null to avoid a uninitilized condition
- minor nits and newline cleanup
- make sure to unmap and unlock the pte for the swapin case
- change the revalidation to always check the PMD order (as this will make
  sure that no other VMA spans it)

V5 Changes:
- switched the order of patches 1 and 2
- fixed some edge cases on the unified madvise_collapse and khugepaged
- Explained the "creep" some more in the docs
- fix EXCEED_SHARED vs EXCEED_SWAP accounting issue
- fix potential highmem issue caused by a early unmap of the PTE

V4 Changes:
- Rebased onto mm-unstable
- small changes to Documentation

V3 Changes:
- corrected legacy behavior for khugepaged and madvise_collapse
- added proper mTHP stat tracking
- Minor changes to prevent a nested lock on non-split-lock arches
- Took Devs version of alloc_charge_folio as it has the proper stats
- Skip cases were trying to collapse to a lower order would still fail
- Fixed cases were the bitmap was not being updated properly
- Moved Documentation update to this series instead of the defer set
- Minor bugs discovered during testing and review
- Minor "nit" cleanup

V2 Changes:
- Minor bug fixes discovered during review and testing
- removed dynamic allocations for bitmaps, and made them stack based
- Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
- Updated trace events to include collapsing order info.
- Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
- No longer require a chunk to be fully utilized before setting the bit.
   Use the same max_ptes_none scaling principle to achieve this.
- Skip mTHP collapse that requires swapin or shared handling. This helps
   prevent some of the "creep" that was discovered in v1.

A big thanks to everyone that has reviewed, tested, and participated in
the development process. Its been a great experience working with all of
you on this long endeavour.

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/lkml/20250515032226.128900-1-npache@redhat.com/
[3] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/

Baolin Wang (2):
  khugepaged: allow khugepaged to check all anonymous mTHP orders
  khugepaged: kick khugepaged for enabling none-PMD-sized mTHPs

Dev Jain (1):
  khugepaged: generalize alloc_charge_folio()

Nico Pache (12):
  khugepaged: rename hpage_collapse_* to khugepaged_*
  introduce khugepaged_collapse_single_pmd to unify khugepaged and
    madvise_collapse
  khugepaged: generalize hugepage_vma_revalidate for mTHP support
  khugepaged: generalize __collapse_huge_page_* for mTHP support
  khugepaged: introduce khugepaged_scan_bitmap for mTHP support
  khugepaged: add mTHP support
  khugepaged: skip collapsing mTHP to smaller orders
  khugepaged: avoid unnecessary mTHP collapse attempts
  khugepaged: allow madvise_collapse to check all anonymous mTHP orders
  khugepaged: improve tracepoints for mTHP orders
  khugepaged: add per-order mTHP khugepaged stats
  Documentation: mm: update the admin guide for mTHP collapse

 Documentation/admin-guide/mm/transhuge.rst |  19 +-
 include/linux/huge_mm.h                    |   5 +
 include/linux/khugepaged.h                 |   4 +
 include/trace/events/huge_memory.h         |  34 +-
 mm/huge_memory.c                           |  11 +
 mm/khugepaged.c                            | 510 ++++++++++++++-------
 6 files changed, 406 insertions(+), 177 deletions(-)

-- 
2.49.0

