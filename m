Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D941B0F3C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Apr 2025 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668406; cv=none; b=S3mplDg8Ck/u0duNftq+hdXE41T/G0Otbs+G6IdBuBMCOMEPQOzXdxNd85bx0uVdadt+VmKR8QDfNRSGG162tD7TAyIkD5QAe9tIzJ4G05oHuzj94BgsH2h5vJoFxR2xoCXltv+quMuWkL4pEWPsgnD9cpwBhrJXkQ1svAa7JQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668406; c=relaxed/simple;
	bh=fejDswuf7V0RzMSrs0ALv14zz8fbbeLCxWpLbydMRfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfSj7WfU9R0wyvGInnTpFsAT4/kI1twieF1x/bax3r8sa5X5rkf2PMbFeUnG+mZAt3m0BPclFBnWZTVCfpfwYMuBy05SkhKqARhA27lIhLNfpRkwVx7XqQPNyYZfen6bQeYTHgm4RQlfSD3xNdfspQ1auWrI8v6bagSAifMtX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8v7dh2o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8v7dh2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744668401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7A+Lf5b6+QKJm+ZLr2WSKVaUqffwZGw3fSnH07I2CYs=;
	b=O8v7dh2oFUqnbkgFDw8SmYSVWlwFJKt1r64W8K0g8QDJZzgTnUE5Hs93HaJvH6FBGDwOBE
	LK1k4G0j+wiJpzEQkwuYGfcdlTz5YKx3c5lDLd8GPJWhV2V6xJI+3NVtGqSpuLj2yhpXW5
	Wvy91Z6DXa3p8PAIu+ofUyJCu3Htzbs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-XqYKilyTPFGcWBaK2QIohA-1; Mon,
 14 Apr 2025 18:06:37 -0400
X-MC-Unique: XqYKilyTPFGcWBaK2QIohA-1
X-Mimecast-MFC-AGG-ID: XqYKilyTPFGcWBaK2QIohA_1744668393
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5595A195609E;
	Mon, 14 Apr 2025 22:06:32 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.91])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA0131956094;
	Mon, 14 Apr 2025 22:06:22 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@redhat.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	willy@infradead.org,
	peterx@redhat.com,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
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
	mhocko@suse.com
Subject: [PATCH v3 00/12] khugepaged: mTHP support
Date: Mon, 14 Apr 2025 16:05:45 -0600
Message-ID: <20250414220557.35388-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The following series provides khugepaged and madvise collapse with the
capability to collapse regions to mTHPs.

To achieve this we generalize the khugepaged functions to no longer depend
on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pages
(defined by MTHP_MIN_ORDER) that are utilized. This info is tracked
using a bitmap. After the PMD scan is done, we do binary recursion on the
bitmap to find the optimal mTHP sizes for the PMD range. The restriction
on max_ptes_none is removed during the scan, to make sure we account for
the whole PMD range. When no mTHP size is enabled, the legacy behavior of
khugepaged is maintained. max_ptes_none will be scaled by the attempted
collapse order to determine how full a THP must be to be eligible. If a
mTHP collapse is attempted, but contains swapped out, or shared pages, we
dont perform the collapse.

With the default max_ptes_none=511, the code should keep its most of its
original behavior. To exercise mTHP collapse we need to set max_ptes_none<=255.
With max_ptes_none > HPAGE_PMD_NR/2 you will experience collapse "creep" and
constantly promote mTHPs to the next available size.

Patch 1:     Some refactoring to combine madvise_collapse and khugepaged
Patch 2:     Refactor/rename hpage_collapse
Patch 3-5:   Generalize khugepaged functions for arbitrary orders
Patch 6-9:   The mTHP patches
Patch 10-11: Tracing/stats
Patch 12:    Documentation

---------
 Testing
---------
- Built for x86_64, aarch64, ppc64le, and s390x
- selftests mm
- I created a test script that I used to push khugepaged to its limits while
   monitoring a number of stats and tracepoints. The code is available
   here[1] (Run in legacy mode for these changes and set mthp sizes to inherit)
   The summary from my testings was that there was no significant regression
   noticed through this test. In some cases my changes had better collapse
   latencies, and was able to scan more pages in the same amount of time/work,
   but for the most part the results were consistent.
- redis testing. I tested these changes along with my defer changes
  (see followup post for more details).
- some basic testing on 64k page size.
- lots of general use. These changes have been running in my VM for some time.

Changes since V2:
- corrected legacy behavior for khugepaged and madvise_collapse
- added proper mTHP stat tracking
- Minor changes to prevent a nested lock on non-split-lock arches
- Took Devs version of alloc_charge_folio as it has the proper stats
- Skip cases were trying to collapse to a lower order would still fail
- Fixed cases were the bitmap was not being updated properly
- Moved Documentation update to this series instead of the defer set
- Minor bugs discovered during testing and review
- Minor "nit" cleanup


Changes since V1 [2]:
- Minor bug fixes discovered during review and testing
- removed dynamic allocations for bitmaps, and made them stack based
- Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
- Updated trace events to include collapsing order info.
- Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
- No longer require a chunk to be fully utilized before setting the bit. Use
   the same max_ptes_none scaling principle to achieve this.
- Skip mTHP collapse that requires swapin or shared handling. This helps prevent
   some of the "creep" that was discovered in v1.

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redhat.com/

Dev Jain (1):
  khugepaged: generalize alloc_charge_folio()

Nico Pache (11):
  introduce khugepaged_collapse_single_pmd to unify khugepaged and
    madvise_collapse
  khugepaged: rename hpage_collapse_* to khugepaged_*
  khugepaged: generalize hugepage_vma_revalidate for mTHP support
  khugepaged: generalize __collapse_huge_page_* for mTHP support
  khugepaged: introduce khugepaged_scan_bitmap for mTHP support
  khugepaged: add mTHP support
  khugepaged: skip collapsing mTHP to smaller orders
  khugepaged: avoid unnecessary mTHP collapse attempts
  khugepaged: improve tracepoints for mTHP orders
  khugepaged: add per-order mTHP khugepaged stats
  Documentation: mm: update the admin guide for mTHP collapse

 Documentation/admin-guide/mm/transhuge.rst |   9 +-
 include/linux/huge_mm.h                    |   5 +
 include/linux/khugepaged.h                 |   4 +
 include/trace/events/huge_memory.h         |  34 +-
 mm/huge_memory.c                           |  11 +
 mm/khugepaged.c                            | 457 ++++++++++++++-------
 6 files changed, 368 insertions(+), 152 deletions(-)

-- 
2.48.1

