Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED226460E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233876; cv=none; b=du1TyQKuRdl04vKKHDDr8AFbQ9QZGFbgDpiXdCBYnfMr9V650mG0yZb+VZiuSiRmdETdJz+HbkhAQ8Znl+M3ZO3MoFPtB8IiCqqAgGUBEvMklvfB3GiOUzyFA559SgorwuyFrtdPGfT0wBGcisnok1hqKgUVzHhTcC8s+KpuTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233876; c=relaxed/simple;
	bh=iDHTAvqsNtAMEXu8qu9xgMtUaTltQ6x5FMmy+IDzPRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQGDE2vJ/aUEhIEAduZ2nyqVDgRONfSNCrP5l7U7LehX2Kfeqeep64vqqRPlD9Gu9RHHh/pORD5WEeaJdHps4Ajaz9b6lgwsXQMY+6FKxzCAK0VooeBvVFZLyCltLq+rmYJi3XRDbcxAbizh+o9R29YfhR91hgkDA40lu265M3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XO6EX7P+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO6EX7P+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739233873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lt4B3Gv3OCrw8JiFM9sdRNcEjetfZHNbsKR6G5cmR7c=;
	b=XO6EX7P+NtiVKs/5+ZXtYZ9FW85XQFrocQ2sEIx08OnMx7rihSW5xiFAg1BZACONHs9RtQ
	0OlFA81lEmESAjfYJxJ1VEk7T4KjEIJorN/qsc50LCvaKVsaYQ0D6H7I+w2nkp+5QGdUQN
	UlR872iEOvEbnlANvQ971d5cRuadPvA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-dlf1c_dsMhCtKj-fEFFg6A-1; Mon,
 10 Feb 2025 19:31:10 -0500
X-MC-Unique: dlf1c_dsMhCtKj-fEFFg6A-1
X-Mimecast-MFC-AGG-ID: dlf1c_dsMhCtKj-fEFFg6A
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C96C195608C;
	Tue, 11 Feb 2025 00:31:04 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFD3B18004A7;
	Tue, 11 Feb 2025 00:30:52 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	srivatsa@csail.mit.edu,
	haowenchao22@gmail.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	jglisse@google.com,
	surenb@google.com,
	vishal.moola@gmail.com,
	zokeefe@google.com,
	zhengqi.arch@bytedance.com,
	jhubbard@nvidia.com,
	21cnbao@gmail.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com,
	david@redhat.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
	sunnanyong@huawei.com,
	usamaarif642@gmail.com,
	audra@redhat.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	tiwai@suse.de
Subject: [RFC v2 0/9] khugepaged: mTHP support
Date: Mon, 10 Feb 2025 17:30:19 -0700
Message-ID: <20250211003028.213461-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The following series provides khugepaged and madvise collapse with the
capability to collapse regions to mTHPs.

To achieve this we generalize the khugepaged functions to no longer depend
on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pages
(defined by MTHP_MIN_ORDER) that are utilized. This info is tracked
using a bitmap. After the PMD scan is done, we do binary recursion on the
bitmap to find the optimal mTHP sizes for the PMD range. The restriction
on max_ptes_none is removed during the scan, to make sure we account for
the whole PMD range. max_ptes_none will be scaled by the attempted collapse
order to determine how full a THP must be to be eligible. If a mTHP collapse
is attempted, but contains swapped out, or shared pages, we dont perform the
collapse.

With the default max_ptes_none=511, the code should keep its most of its 
original behavior. To exercise mTHP collapse we need to set max_ptes_none<=255.
With max_ptes_none > HPAGE_PMD_NR/2 you will experience collapse "creep" and 
constantly promote mTHPs to the next available size.

Patch 1:     Some refactoring to combine madvise_collapse and khugepaged
Patch 2:     Refactor/rename hpage_collapse
Patch 3-5:   Generalize khugepaged functions for arbitrary orders
Patch 6-9:   The mTHP patches

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
   but for the most part the results were consistant.
- redis testing. I tested these changes along with my defer changes
  (see followup post for more details).
- some basic testing on 64k page size.
- lots of general use. These changes have been running in my VM for some time.

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

Nico Pache (9):
  introduce khugepaged_collapse_single_pmd to unify khugepaged and
    madvise_collapse
  khugepaged: rename hpage_collapse_* to khugepaged_*
  khugepaged: generalize hugepage_vma_revalidate for mTHP support
  khugepaged: generalize alloc_charge_folio for mTHP support
  khugepaged: generalize __collapse_huge_page_* for mTHP support
  khugepaged: introduce khugepaged_scan_bitmap for mTHP support
  khugepaged: add mTHP support
  khugepaged: improve tracepoints for mTHP orders
  khugepaged: skip collapsing mTHP to smaller orders

 include/linux/khugepaged.h         |   4 +
 include/trace/events/huge_memory.h |  34 ++-
 mm/khugepaged.c                    | 422 +++++++++++++++++++----------
 3 files changed, 306 insertions(+), 154 deletions(-)

-- 
2.48.1

