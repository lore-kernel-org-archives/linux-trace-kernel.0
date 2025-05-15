Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B81A28D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 May 2025 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279378; cv=none; b=RzS6ADSixWB5a0dDCNgKvN9k4M+unisbJpHCOLxeImXrHTDBtmFT6EhdYduOrPQbRpeVIglgTwEbS/5Andd/EKNS0M6C8u3hAKgkRJDzPqbsJaGN6zXDc1epZc6vtyTTHbobaAr4Bn949gktx0TlxODw5xkqApsylxP+8vIOwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279378; c=relaxed/simple;
	bh=CcvM8TPahvrvDY29hyXvR11tNSUKj/pJlZmeV5QgToM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MT9qNIWldOAgSI3Vg9ey+oqkPQT8MI85tFRLUbcLhx1XwV8GTBedkI6aiqWCxOx04MXSd28+D5P+oPGTl1Cxy8jmmy4XcI4iMJpwhKOxVaxI9eV9nJMr3BquXxoZsTTAX2YTKCJAuf5Shzo53YaY/36drocFX88/8b6TW2M8lVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQagdqAB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQagdqAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747279375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JpaebEPPZJMesPD/jagQR+EUUomMl0IAlT5nBhfQTL8=;
	b=bQagdqABSMP4CHq7m+mc57C5RYZfOzXLzjR7UlvTGoPSWl0pjkE199GC1mqjR0WOOPUicl
	CFSDbqQawed4M8wT7RnVTzHi5K2U/JR2TV6Lq6JiAHbXKpDR5ds+fQ7aGoaADDCBkFaSPz
	GhemPq8a03sEjXdsWUzjETX7zoEkaKA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-aM9DqdCfNiGiVpei6HkWqQ-1; Wed,
 14 May 2025 23:22:52 -0400
X-MC-Unique: aM9DqdCfNiGiVpei6HkWqQ-1
X-Mimecast-MFC-AGG-ID: aM9DqdCfNiGiVpei6HkWqQ_1747279368
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1592C18003FC;
	Thu, 15 May 2025 03:22:47 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 962911800268;
	Thu, 15 May 2025 03:22:30 +0000 (UTC)
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
Subject: [PATCH v7 00/12] khugepaged: mTHP support
Date: Wed, 14 May 2025 21:22:14 -0600
Message-ID: <20250515032226.128900-1-npache@redhat.com>
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
on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pages
(defined by KHUGEPAGED_MTHP_MIN_ORDER) that are utilized. This info is
tracked using a bitmap. After the PMD scan is done, we do binary recursion
on the bitmap to find the optimal mTHP sizes for the PMD range. The
restriction on max_ptes_none is removed during the scan, to make sure we
account for the whole PMD range. When no mTHP size is enabled, the legacy
behavior of khugepaged is maintained. max_ptes_none will be scaled by the
attempted collapse order to determine how full a THP must be to be
eligible. If a mTHP collapse is attempted, but contains swapped out, or
shared pages, we dont perform the collapse.

With the default max_ptes_none=511, the code should keep its most of its
original behavior. To exercise mTHP collapse we need to set
max_ptes_none<=255. With max_ptes_none > HPAGE_PMD_NR/2 you will
experience collapse "creep" and constantly promote mTHPs to the next
available size. This is due the fact that it will introduce at least 2x
the number of pages, and on a future scan will satisfy that condition once
again.

Patch 1:     Refactor/rename hpage_collapse
Patch 2:     Some refactoring to combine madvise_collapse and khugepaged
Patch 3-5:   Generalize khugepaged functions for arbitrary orders
Patch 6-9:   The mTHP patches
Patch 10-11: Tracing/stats
Patch 12:    Documentation

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
  (see followup post for more details).
- some basic testing on 64k page size.
- lots of general use.

V6 Changes:
- Dont release the anon_vma_lock early (like in the PMD case), as not all
  pages are isolated.
- Define the PTE as null to avoid a uninitilized condition
- minor nits and newline cleanup
- make sure to unmap and unlock the pte for the swapin case
- change the revalidation to always check the PMD order (as this will make
  sure that no other VMA spans it)

V5 Changes [2]:
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

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/all/20250428181218.85925-1-npache@redhat.com/

Dev Jain (1):
  khugepaged: generalize alloc_charge_folio()

Nico Pache (11):
  khugepaged: rename hpage_collapse_* to khugepaged_*
  introduce khugepaged_collapse_single_pmd to unify khugepaged and
    madvise_collapse
  khugepaged: generalize hugepage_vma_revalidate for mTHP support
  khugepaged: generalize __collapse_huge_page_* for mTHP support
  khugepaged: introduce khugepaged_scan_bitmap for mTHP support
  khugepaged: add mTHP support
  khugepaged: skip collapsing mTHP to smaller orders
  khugepaged: avoid unnecessary mTHP collapse attempts
  khugepaged: improve tracepoints for mTHP orders
  khugepaged: add per-order mTHP khugepaged stats
  Documentation: mm: update the admin guide for mTHP collapse

 Documentation/admin-guide/mm/transhuge.rst |  14 +-
 include/linux/huge_mm.h                    |   5 +
 include/linux/khugepaged.h                 |   4 +
 include/trace/events/huge_memory.h         |  34 +-
 mm/huge_memory.c                           |  11 +
 mm/khugepaged.c                            | 472 ++++++++++++++-------
 6 files changed, 382 insertions(+), 158 deletions(-)

-- 
2.49.0

