Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27322FAFD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647778; cv=none; b=UFL9lSoIwpDX3lzeB+mWscxkzbVBNaW9/tl7kDjflcWEDBfPYS4uhMmZ3lJLW5g1A04hejitHTAZ28rYMGrVCXijjXEWQhBHLRLtlWePSvNJHzl0O78I9BsfYHB2rT98C2E+lv9ZBFCAsxOY/VpSteSZfUhjpSD4Gz6xjsbwBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647778; c=relaxed/simple;
	bh=Hg03KZxxsk+1MYt3WijA1FrqtyCaQoAa06lPJceCr1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvgR2dT6QvKCIGGfzOKDFZfnhLIasHaDdQpiwEZqT5Iklx3cpAW6hTZ6l+uJkEJxpLMYvpllBEonJu8kW+YNHa7OQqveIXXnisddsSHFwuwAnXXAYlBNoq65fVD/N8L466tAoJUfKhfQN0lNB/YfdyMXbbbeVWZH19bk7QZn8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALXlPibO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALXlPibO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757647774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XS6u33nxOdz8zmIuHpnx05q90XDI86YR6KQOnGvzeFk=;
	b=ALXlPibOkCTUp7iUcs0umasaR3/IxrWteJWzC4CzABncWKvf11hx0YhdPfjF9dRmUDNb+k
	bewXJSO+1F5xDfUdPWdb+gWV/SR1jZqVNIDX7Gi374wCCg3BlCQfwukmMZj/LsuRNU/gOf
	zS9p07RHcpWY8lKjcQig/3kWebAtCK0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-3TICFVZ8MR6u5KpFCsMWKg-1; Thu,
 11 Sep 2025 23:29:28 -0400
X-MC-Unique: 3TICFVZ8MR6u5KpFCsMWKg-1
X-Mimecast-MFC-AGG-ID: 3TICFVZ8MR6u5KpFCsMWKg_1757647759
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B15661955E88;
	Fri, 12 Sep 2025 03:29:17 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25C571800451;
	Fri, 12 Sep 2025 03:29:03 +0000 (UTC)
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
Subject: [PATCH v11 00/15] khugepaged: mTHP support
Date: Thu, 11 Sep 2025 21:27:55 -0600
Message-ID: <20250912032810.197475-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The following series provides khugepaged with the capability to collapse
anonymous memory regions to mTHPs.

To achieve this we generalize the khugepaged functions to no longer depend
on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
pages that are occupied (!none/zero). After the PMD scan is done, we do
binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
range. The restriction on max_ptes_none is removed during the scan, to make
sure we account for the whole PMD range. When no mTHP size is enabled, the
legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
by the attempted collapse order to determine how full a mTHP must be to be
eligible for the collapse to occur. If a mTHP collapse is attempted, but
contains swapped out, or shared pages, we don't perform the collapse. It is
now also possible to collapse to mTHPs without requiring the PMD THP size
to be enabled.

When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
mTHP collapses to prevent collapse "creep" behavior. This prevents
constantly promoting mTHPs to the next available size, which would occur
because a collapse introduces more non-zero pages that would satisfy the
promotion condition on subsequent scans.

Patch 1:     Refactor/rename hpage_collapse
Patch 2:     Refactoring to combine madvise_collapse and khugepaged
Patch 3-7:   Generalize khugepaged functions for arbitrary orders
Patch 8:     skip collapsing mTHP to smaller orders
Patch 9-10:  Add per-order mTHP statistics and tracepoints
Patch 11:    Introduce collapse_allowable_orders
Patch 12-14: Introduce bitmap and mTHP collapse support
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
  (see followup [2] post for more details). We've decided to get the mTHP
  changes merged first before attempting the defer series.
- some basic testing on 64k page size.
- lots of general use.

V11 Changes:
- Minor nits and cleanup/refactoring
- commit messages updates
- split patches to make them easier to review
- added helper functions for checking allowable orders and max_ptes_none
- simplified anon_vma locking tracking to improve code readability
- Added automatic cap to max_ptes_none for mTHP collapse to prevent "creep"
- changed bitmap tracking to use page-level granularity instead of
  chunk-based this removes inaccuracies/complexity
- Improved documentation and comments throughout the series
- Refactored collapse_single_pmd() for better readability
- Added proper WARN_ON_ONCE() instead of BUG_ON() for better error handling
- reordered patches to make them easier to review
- merge Baolins patch to run khugepaged for all orders now that
  collapse_allowable_orders is available

V10: https://lore.kernel.org/lkml/20250819134205.622806-1-npache@redhat.com/
V9 : https://lore.kernel.org/lkml/20250714003207.113275-1-npache@redhat.com/
V8 : https://lore.kernel.org/lkml/20250702055742.102808-1-npache@redhat.com/
V7 : https://lore.kernel.org/lkml/20250515032226.128900-1-npache@redhat.com/
V6 : https://lore.kernel.org/lkml/20250515030312.125567-1-npache@redhat.com/
V5 : https://lore.kernel.org/lkml/20250428181218.85925-1-npache@redhat.com/
V4 : https://lore.kernel.org/lkml/20250417000238.74567-1-npache@redhat.com/
V3 : https://lore.kernel.org/lkml/20250414220557.35388-1-npache@redhat.com/
V2 : https://lore.kernel.org/lkml/20250211003028.213461-1-npache@redhat.com/
V1 : https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redhat.com/

A big thanks to everyone that has reviewed, tested, and participated in
the development process. Its been a great experience working with all of
you on this long endeavour.

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/

Baolin Wang (1):
  khugepaged: run khugepaged for all orders

Dev Jain (1):
  khugepaged: generalize alloc_charge_folio()

Nico Pache (13):
  khugepaged: rename hpage_collapse_* to collapse_*
  introduce collapse_single_pmd to unify khugepaged and madvise_collapse
  khugepaged: generalize hugepage_vma_revalidate for mTHP support
  khugepaged: generalize __collapse_huge_page_* for mTHP support
  khugepaged: introduce collapse_max_ptes_none helper function
  khugepaged: generalize collapse_huge_page for mTHP collapse
  khugepaged: skip collapsing mTHP to smaller orders
  khugepaged: add per-order mTHP collapse failure statistics
  khugepaged: improve tracepoints for mTHP orders
  khugepaged: introduce collapse_allowable_orders helper function
  khugepaged: Introduce mTHP collapse support
  khugepaged: avoid unnecessary mTHP collapse attempts
  Documentation: mm: update the admin guide for mTHP collapse

 Documentation/admin-guide/mm/transhuge.rst |  91 ++-
 include/linux/huge_mm.h                    |   5 +
 include/linux/khugepaged.h                 |   2 +
 include/trace/events/huge_memory.h         |  34 +-
 mm/huge_memory.c                           |  11 +
 mm/khugepaged.c                            | 612 ++++++++++++++-------
 mm/mremap.c                                |   2 +-
 7 files changed, 535 insertions(+), 222 deletions(-)

-- 
2.51.0

