Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A790533343D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611252; cv=none; b=Y/p3LDtAsF9hlJkpizh4jN5PGd8As6RJrWKYy2r+VkMOfPw1gp/pV7FjcAnYbaeq5S6RNSbyAUdE0ahubY20UkkhxxEUMqMqchjMEFm3pZmBZiXkYPyMNRbuGG9fO7XXup8PvdEozRKpzmdGb7M4qx1mOFelYo5jujC9J/rMB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611252; c=relaxed/simple;
	bh=cF8aV9/F7xvXHXHmmNNjnabv/qjgE+z/kVzYK4dVDBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGsxDsLxuZuE5BgQhqxyi3L8NZ3aGlAQnBnr5ro1Q4KrNPwFRkDv/dEvvXajx50tyDgaBe7mxX1MlW7deuc5PyX7JjZVvLXXXY4h8IHgvz1s/s4uji3oFliy45KX968QJtO+Jg48ajvalEZ8Nbq1hTJr5pjpSyKIuM2mII+FTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+nack9i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+nack9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764611249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K7EblCrPHmPeGpU4jKxy0TCLMZyCEXvxixVXeFlcSRE=;
	b=D+nack9i5yk4SEE1lOkGdtX3cp2STMvDLxkG7Ko2LqCuMtUYXjGDxsKF/t+CHhjPMZ28DX
	YddSNeWShTxFFm5QMNbyRuT8ejm1AxzNBO8M1/x5lXQdBW1Stp4LgiA7zL8hBN4WxQLs6w
	DH9Tt69ZsjLdYk/BGMFEoI420WbxyQs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-p7dA_RP7MS2HhAqYrjA5-w-1; Mon,
 01 Dec 2025 12:47:28 -0500
X-MC-Unique: p7dA_RP7MS2HhAqYrjA5-w-1
X-Mimecast-MFC-AGG-ID: p7dA_RP7MS2HhAqYrjA5-w_1764611243
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E843018007F2;
	Mon,  1 Dec 2025 17:47:21 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.66.60])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9A251800361;
	Mon,  1 Dec 2025 17:47:09 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
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
Subject: [PATCH v13 mm-new 00/16] khugepaged: mTHP support
Date: Mon,  1 Dec 2025 10:46:11 -0700
Message-ID: <20251201174627.23295-1-npache@redhat.com>
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
size to be enabled. These limitiations are to prevent collapse "creep"
behavior. This prevents constantly promoting mTHPs to the next available
size, which would occur because a collapse introduces more non-zero pages
that would satisfy the promotion condition on subsequent scans.

Patch 1:     Refactor/rename hpage_collapse
Patch 2:     Refactoring to combine madvise_collapse and khugepaged
Patch 3-8:   Generalize khugepaged functions for arbitrary orders and
	     introduce some helper functions
Patch 9:     skip collapsing mTHP to smaller orders
Patch 10-11: Add per-order mTHP statistics and tracepoints
Patch 12:    Introduce collapse_allowable_orders
Patch 13-15: Introduce bitmap and mTHP collapse support, fully enabled
Patch 16:    Documentation

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

V13 Changes:
- Lots of minor nits, cleanups, comments, and renames
- Bitmap function simplification and more helpers (Wei, Lorenzo)
- Max_ptes_none (0 or 511) restriction
- commit description expansion
- list all reachable enum values in mthp_collapse()
- Fix ppc64 compile error due to using HPAGE_PMD_ORDER (replace with
  ilog2(MAX_PTRS_PER_PTE))

V12: https://lore.kernel.org/lkml/20251022183717.70829-1-npache@redhat.com/
V11: https://lore.kernel.org/lkml/20250912032810.197475-1-npache@redhat.com/
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
you on this endeavour.

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/

Baolin Wang (1):
  khugepaged: run khugepaged for all orders

Dev Jain (1):
  khugepaged: generalize alloc_charge_folio()

Nico Pache (14):
  khugepaged: rename hpage_collapse_* to collapse_*
  introduce collapse_single_pmd to unify khugepaged and madvise_collapse
  khugepaged: generalize hugepage_vma_revalidate for mTHP support
  khugepaged: introduce is_mthp_order helper
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

 Documentation/admin-guide/mm/transhuge.rst |  80 ++-
 include/linux/huge_mm.h                    |   5 +
 include/trace/events/huge_memory.h         |  34 +-
 mm/huge_memory.c                           |  11 +
 mm/khugepaged.c                            | 696 +++++++++++++++------
 mm/mremap.c                                |   2 +-
 6 files changed, 618 insertions(+), 210 deletions(-)

-- 
2.51.1

