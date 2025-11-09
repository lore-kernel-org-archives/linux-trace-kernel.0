Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A1F513
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Nov 2025 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762654088; cv=none; b=LmxkAZMJvzgg68Yk50aRSQJN/I4fmegnSwTCLqKlQ1CjoI+7BbLDmi4YSQ+F4Z3N3OZY7gv9ux4HeXy5X2yIWkaYL/N1EL4M9NOdt3yFf1T/JJuFJnLV0ISjv4RSOPrhQZUT0vO53Ku0fNvfdfks5C14K+3Dee57d2OpltlQSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762654088; c=relaxed/simple;
	bh=N+9+BSCsN+P8osaHLNQCt2Bpc4SPzSbDqTrf2ii23o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE1L6hSZiLaCR/ElYRMHUxGy0ny75OrAtWUp+7rAqmAkiIhXnFVwKVM7aT6XXrIs/nCqRObdareGr2xCE6yQdjeA5j0mIaLxVEPJ9GDE0wId+HVGJRVO1dKgiZJo5VoHdDiIzxGzDoaaOlH72FtBAWqlIL8sPtdhNSI3pltG+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvToeigM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvToeigM"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so2962838a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 08 Nov 2025 18:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762654085; x=1763258885; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRHokLAF/q17VZFE2sUBBiNZnx7Ac3gofK115AlTtXA=;
        b=gvToeigMsqjxvM1Tzslu5xq1kcIVr0WOASRL5wxN5GtIzMg5czYy6h7/WAaLiWHebl
         +jjZEgHbUZqso+dHDus/mF84OvRsPP41PRjzYGKqmP5jeTOsQ/VWR620lz0AorCQSdIu
         xW4L9ScybOiumBk5VTVQiKM9aAx4jmZayckPf3/k5hb7VLej3xVXjQgvyIMLEb5DEOU+
         eL4iDQ05teAjYJQhBim29A5jprhUlt1ydJ0QpKKKxn9DNuN4HS0jwPC4OzbTLoChYN90
         bCjn+wi7Kdg6wjhfXVTQ8i+S2+qA7enznOQ3zQyROOu0Zf6r5QOjz/sBV5CMA7RMwRac
         0REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762654085; x=1763258885;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRHokLAF/q17VZFE2sUBBiNZnx7Ac3gofK115AlTtXA=;
        b=BJogAXXmRhg4V4d5aKHwtUjk+GVAtezx1K4Ca6QZ3xsKUYDOgugFvrq7du7s0wteU5
         Df/egozyE4tKhOPCqQsE+Gp65vv6MroqjE+j9iHf4on23tl6+CW6K0mzJwOVfnJZxKbY
         mkZ4SteFtp53A/rUyVXFmS8Jwy6rq4/5LUVTBUKq4vKuyJ0jTmGf91wlApmR+W6gVHGV
         9DIHG7bPKiCest+7Qe1K9Djn7Ap1uFkCOwvr8FtyvdWhb6EMAFYoUkhAW4RC7PArUkiG
         ZE2WdJ2s/cpL5OuQM844U0eJHCYmA6TL5heJ+RhsdXRKL0/o72Z1G8JW48LoBVa9Kysj
         zobQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQmmWe0BeoRj1S3AQ8bHRySiNdeEVgY4cQinoWZWbWSQRlQHY76gwB+aKcRYPfN2Odq3tLYWmj/BuIcKkI5Nl4f9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcWCAZ6qdKINWJX/7zOs5Sljym87N5H91KQc/LQcNTYnGX2pv
	c3/kNVhSpJCMsMZlOsmDMWbVKt0FJivoKCVQT2sIl2VHzV9KmGLfGnVE
X-Gm-Gg: ASbGncvcR+DAyonpIbzeYJWAEX5NlZDV0QhAQqLFurCNtemEm6sGVEDPd+mvyB3N0qW
	QMQAI0UKu5FByT+HsWaYdHktlvefrll8ezli1tV+3mFxdQYFDpmiQf9L8hRfzBSoP26EB/T6SmV
	HTA19oo+zZYuAYK/1zuvl0YSJTTypWIMRQlhFYlVl4a3BBzYQBPufwlXXk09nX52d9Tvt/+tZm3
	gLC157c7VskE2JsvUVh1LPXuVGFw4/FaJ7uo7NcC7JVuE4k6Y2kmhO5LDlY0sECapWumgzbtKeW
	eK3oN8LD/j6170bpfpbdAASb9AY5Q9F0arRjwtmDtV2Kymu2uITL3MGLeg387oQg8mCE/nEVYQx
	P0CQtvuJivYcL0rG4jJJWJeCCSXZCQwpI2Ah8kOfrwD1a040F5nEbufErHLVH4mZ8kxltfFdN23
	deJ9Umnw+iQA==
X-Google-Smtp-Source: AGHT+IFrhdbOBBwtJnhpa649VqXf7OJPVe3tNdIF6HQRQ4eHrJ1sdTvERcEapOjyZYnSHioMgX+QYw==
X-Received: by 2002:a17:907:3f97:b0:b70:f2c4:bdf2 with SMTP id a640c23a62f3a-b72e02dc592mr362361766b.23.1762654084427;
        Sat, 08 Nov 2025 18:08:04 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd72bsm674183466b.49.2025.11.08.18.08.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Nov 2025 18:08:03 -0800 (PST)
Date: Sun, 9 Nov 2025 02:08:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 12/15] khugepaged: Introduce mTHP collapse
 support
Message-ID: <20251109020802.g6dytbixd4aygdgh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-13-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-13-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:14PM -0600, Nico Pache wrote:
>During PMD range scanning, track occupied pages in a bitmap. If mTHPs are
>enabled we remove the restriction of max_ptes_none during the scan phase
>to avoid missing potential mTHP candidates.
>
>Implement collapse_scan_bitmap() to perform binary recursion on the bitmap
>and determine the best eligible order for the collapse. A stack struct is
>used instead of traditional recursion. The algorithm splits the bitmap
>into smaller chunks to find the best fit mTHP.  max_ptes_none is scaled by
>the attempted collapse order to determine how "full" an order must be
>before being considered for collapse.
>
>Once we determine what mTHP sizes fits best in that PMD range a collapse
>is attempted. A minimum collapse order of 2 is used as this is the lowest
>order supported by anon memory.
>
>mTHP collapses reject regions containing swapped out or shared pages.
>This is because adding new entries can lead to new none pages, and these
>may lead to constant promotion into a higher order (m)THP. A similar
>issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
>introducing at least 2x the number of pages, and on a future scan will
>satisfy the promotion condition once again. This issue is prevented via
>the collapse_allowable_orders() function.
>
>Currently madv_collapse is not supported and will only attempt PMD
>collapse.
>
>We can also remove the check for is_khugepaged inside the PMD scan as
>the collapse_max_ptes_none() function handles this logic now.
>
>Signed-off-by: Nico Pache <npache@redhat.com>

Generally LGTM.

Some nit below.

>---
> include/linux/khugepaged.h |   2 +
> mm/khugepaged.c            | 128 ++++++++++++++++++++++++++++++++++---
> 2 files changed, 122 insertions(+), 8 deletions(-)
>
>diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
>index eb1946a70cff..179ce716e769 100644
>--- a/include/linux/khugepaged.h
>+++ b/include/linux/khugepaged.h
>@@ -1,6 +1,8 @@
> /* SPDX-License-Identifier: GPL-2.0 */
> #ifndef _LINUX_KHUGEPAGED_H
> #define _LINUX_KHUGEPAGED_H
>+#define KHUGEPAGED_MIN_MTHP_ORDER	2
>+#define MAX_MTHP_BITMAP_STACK	(1UL << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
> 
> #include <linux/mm.h>
> 
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 89a105124790..e2319bfd0065 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -93,6 +93,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
> 
> static struct kmem_cache *mm_slot_cache __ro_after_init;
> 
>+struct scan_bit_state {
>+	u8 order;
>+	u16 offset;
>+};
>+
> struct collapse_control {
> 	bool is_khugepaged;
> 
>@@ -101,6 +106,13 @@ struct collapse_control {
> 
> 	/* nodemask for allocation fallback */
> 	nodemask_t alloc_nmask;
>+
>+	/*
>+	 * bitmap used to collapse mTHP sizes.
>+	 */
>+	 DECLARE_BITMAP(mthp_bitmap, HPAGE_PMD_NR);
>+	 DECLARE_BITMAP(mthp_bitmap_mask, HPAGE_PMD_NR);
>+	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_STACK];

Looks like an indent issue.

> };
> 
> /**
>@@ -1357,6 +1369,85 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long pmd_address,
> 	return result;
> }
> 
>+static void push_mthp_bitmap_stack(struct collapse_control *cc, int *top,
>+				   u8 order, u16 offset)
>+{
>+	cc->mthp_bitmap_stack[++*top] = (struct scan_bit_state)
>+		{ order, offset };
>+}
>+

For me, I may introduce pop_mth_bitmap_stack() .

And use it ...

>+/*
>+ * collapse_scan_bitmap() consumes the bitmap that is generated during
>+ * collapse_scan_pmd() to determine what regions and mTHP orders fit best.
>+ *
>+ * Each bit in the bitmap represents a single occupied (!none/zero) page.
>+ * A stack structure cc->mthp_bitmap_stack is used to check different regions
>+ * of the bitmap for collapse eligibility. We start at the PMD order and
>+ * check if it is eligible for collapse; if not, we add two entries to the
>+ * stack at a lower order to represent the left and right halves of the region.
>+ *
>+ * For each region, we calculate the number of set bits and compare it
>+ * against a threshold derived from collapse_max_ptes_none(). A region is
>+ * eligible if the number of set bits exceeds this threshold.
>+ */
>+static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
>+		int referenced, int unmapped, struct collapse_control *cc,
>+		bool *mmap_locked, unsigned long enabled_orders)
>+{
>+	u8 order, next_order;
>+	u16 offset, mid_offset;
>+	int num_chunks;
>+	int bits_set, threshold_bits;
>+	int top = -1;
>+	int collapsed = 0;
>+	int ret;
>+	struct scan_bit_state state;
>+	unsigned int max_none_ptes;
>+
>+	push_mthp_bitmap_stack(cc, &top, HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0);
>+
>+	while (top >= 0) {
>+		state = cc->mthp_bitmap_stack[top--];

... here.

>+		order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;

We push real_order - KHUGEPAGED_MIN_MTHP_ORDER, and get it by add
KHUGEPAGED_MIN_MTHP_ORDER.

Maybe we can push real_order ...

>+		offset = state.offset;
>+		num_chunks = 1UL << order;
>+
>+		/* Skip mTHP orders that are not enabled */
>+		if (!test_bit(order, &enabled_orders))
>+			goto next_order;
>+
>+		max_none_ptes = collapse_max_ptes_none(order, !cc->is_khugepaged);
>+
>+		/* Calculate weight of the range */
>+		bitmap_zero(cc->mthp_bitmap_mask, HPAGE_PMD_NR);
>+		bitmap_set(cc->mthp_bitmap_mask, offset, num_chunks);
>+		bits_set = bitmap_weight_and(cc->mthp_bitmap,
>+					     cc->mthp_bitmap_mask, HPAGE_PMD_NR);
>+
>+		threshold_bits = (1UL << order) - max_none_ptes - 1;
>+
>+		/* Check if the region is eligible based on the threshold */
>+		if (bits_set > threshold_bits) {
>+			ret = collapse_huge_page(mm, address, referenced,
>+						 unmapped, cc, mmap_locked,
>+						 order, offset);
>+			if (ret == SCAN_SUCCEED) {
>+				collapsed += 1UL << order;
>+				continue;
>+			}
>+		}
>+
>+next_order:
>+		if (state.order > 0) {

...and if (order > KHUGEPAGED_MIN_MTHP_ORDER) here?

Not sure you would like it.

>+			next_order = state.order - 1;
>+			mid_offset = offset + (num_chunks / 2);
>+			push_mthp_bitmap_stack(cc, &top, next_order, mid_offset);
>+			push_mthp_bitmap_stack(cc, &top, next_order, offset);
>+		}
>+	}
>+	return collapsed;
>+}
>+
> static int collapse_scan_pmd(struct mm_struct *mm,
> 			     struct vm_area_struct *vma,
> 			     unsigned long start_addr, bool *mmap_locked,
>@@ -1364,11 +1455,15 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> {
> 	pmd_t *pmd;
> 	pte_t *pte, *_pte;
>+	int i;
> 	int result = SCAN_FAIL, referenced = 0;
>-	int none_or_zero = 0, shared = 0;
>+	int none_or_zero = 0, shared = 0, nr_collapsed = 0;
> 	struct page *page = NULL;
>+	unsigned int max_ptes_none;
> 	struct folio *folio = NULL;
> 	unsigned long addr;
>+	unsigned long enabled_orders;
>+	bool full_scan = true;
> 	spinlock_t *ptl;
> 	int node = NUMA_NO_NODE, unmapped = 0;
> 
>@@ -1378,16 +1473,29 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> 	if (result != SCAN_SUCCEED)
> 		goto out;
> 
>+	bitmap_zero(cc->mthp_bitmap, HPAGE_PMD_NR);
> 	memset(cc->node_load, 0, sizeof(cc->node_load));
> 	nodes_clear(cc->alloc_nmask);
>+
>+	enabled_orders = collapse_allowable_orders(vma, vma->vm_flags, cc->is_khugepaged);
>+
>+	/*
>+	 * If PMD is the only enabled order, enforce max_ptes_none, otherwise
>+	 * scan all pages to populate the bitmap for mTHP collapse.
>+	 */
>+	if (cc->is_khugepaged && enabled_orders == _BITUL(HPAGE_PMD_ORDER))

We sometimes use BIT(), e.g. in collapse_allowable_orders().
And sometimes use _BITUL().

Suggest to use the same form.

Nothing else, great job!

>+		full_scan = false;
>+	max_ptes_none = collapse_max_ptes_none(HPAGE_PMD_ORDER, full_scan);
>+
> 	pte = pte_offset_map_lock(mm, pmd, start_addr, &ptl);
> 	if (!pte) {
> 		result = SCAN_PMD_NULL;
> 		goto out;
> 	}
> 
>-	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>-	     _pte++, addr += PAGE_SIZE) {
>+	for (i = 0; i < HPAGE_PMD_NR; i++) {
>+		_pte = pte + i;
>+		addr = start_addr + i * PAGE_SIZE;
> 		pte_t pteval = ptep_get(_pte);
> 		if (is_swap_pte(pteval)) {
> 			++unmapped;
>@@ -1412,8 +1520,7 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> 		if (pte_none_or_zero(pteval)) {
> 			++none_or_zero;
> 			if (!userfaultfd_armed(vma) &&
>-			    (!cc->is_khugepaged ||
>-			     none_or_zero <= khugepaged_max_ptes_none)) {
>+			    none_or_zero <= max_ptes_none) {
> 				continue;
> 			} else {
> 				result = SCAN_EXCEED_NONE_PTE;
>@@ -1461,6 +1568,8 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> 			}
> 		}
> 
>+		/* Set bit for occupied pages */
>+		bitmap_set(cc->mthp_bitmap, i, 1);
> 		/*
> 		 * Record which node the original page is from and save this
> 		 * information to cc->node_load[].
>@@ -1517,9 +1626,12 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> out_unmap:
> 	pte_unmap_unlock(pte, ptl);
> 	if (result == SCAN_SUCCEED) {
>-		result = collapse_huge_page(mm, start_addr, referenced,
>-					    unmapped, cc, mmap_locked,
>-					    HPAGE_PMD_ORDER, 0);
>+		nr_collapsed = collapse_scan_bitmap(mm, start_addr, referenced, unmapped,
>+					      cc, mmap_locked, enabled_orders);
>+		if (nr_collapsed > 0)
>+			result = SCAN_SUCCEED;
>+		else
>+			result = SCAN_FAIL;
> 	}
> out:
> 	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
>-- 
>2.51.0

-- 
Wei Yang
Help you, Help me
