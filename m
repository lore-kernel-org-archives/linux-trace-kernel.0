Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE83A5E64;
	Mon,  1 Jun 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320427; cv=none; b=kXRYOFERNhe3eyA4EkToCrnwQD3yRRuzs13eRYpI/i5gMB8Y0/j3xN3awv5o+LQwYyMn4dhkMmZPhO7ZutnysklsYH+PN5AAxDjN80q+gzV2Nwwe9R7A0xs32yNapmQqDtCq7EMUcVuH8cJzuDONJPuqjqxgpZdZz8R/a+7i8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320427; c=relaxed/simple;
	bh=+K1pD83RQkvtYDPlFLvHsTD57FvQieHUtt87ylKc8cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRwDbhG0TONtIxGYhTAS8SMz0jl5/8WkiC+Oh8jEmazGch2v4Ws6Ms16/BUVnJE6e2hZC/qx1uCapL9gSrCUi9zkG+GUeSfxJIKEDb727bjZ5HgAlnx2hj5djXPbmtYO8UyiT1SAvUI/AXWaiNY05wmFvH5o6Zd32S7hTL/6w0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtdLpnbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtdLpnbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D931F00893;
	Mon,  1 Jun 2026 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780320426;
	bh=XTwzxHHjfaMVcn6q19QW9qTc46zmU2vzB9WAnHCQB24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AtdLpnbcTiEUvj8PI8AYITcxKqucwq6vs6Xw+wGihOjs2NlCX/sO9PBMWe/R7HTbG
	 b6lQL9HUVMUA/bhudUGLpCRob4FBvkHpSru3AR8ImvKNLcAb56gEgizQv5iDX/VF2Z
	 wnZRzbas58507AwitF+T7RZxcfbGwtiMJv18wjjgLIDpqHCyYFZqB3Zda1BXw5KJTQ
	 cIknF3CUZi7eZneAXr6lJw+m1MzsDx5FL7KkTvtYW7ON0y3CcJV8gAmn0G7e3Yixop
	 d5zu+A/9Po9phNnWzLT6WvdowxMuKlydSsjhFbmyH4XlUiXOT1+HwbtewbTXfZgzzN
	 tcVGkHpgR9JeA==
Date: Mon, 1 Jun 2026 14:26:50 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH mm-unstable v18 03/14] mm/khugepaged: rework max_ptes_*
 handling with helper functions
Message-ID: <ah18esZ5rtzIlinB@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-4-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522150009.121603-4-npache@redhat.com>

On Fri, May 22, 2026 at 08:59:58AM -0600, Nico Pache wrote:
> The following cleanup reworks all the max_ptes_* handling into helper
> functions. This increases the code readability and will later be used to
> implement the mTHP handling of these variables.
>
> With these changes we abstract all the madvise_collapse() special casing
> (do not respect the sysctls) away from the functions that utilize them.
> And will be used later in this series to cleanly restrict the mTHP
> collapse behavior.
>
> No functional change is intended; however, we are now only reading the
> sysfs variables once per scan, whereas before these variables were being
> read on each loop iteration.
>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Nico Pache <npache@redhat.com>

Had a read through, this is nice, all LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  mm/khugepaged.c | 120 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 84 insertions(+), 36 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 13d82993755f..116f39518948 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -348,6 +348,64 @@ static bool pte_none_or_zero(pte_t pte)
>  	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
>  }
>
> +/**
> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs or PTEs mapping
> + * the shared zeropage for the given collapse operation.
> + * @cc: The collapse control struct
> + * @vma: The vma to check for userfaultfd
> + *
> + * Return: Maximum number of empty/shared zeropage PTEs for the collapse operation
> + */
> +static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
> +		struct vm_area_struct *vma)
> +{
> +	if (vma && userfaultfd_armed(vma))
> +		return 0;
> +	/* for MADV_COLLAPSE, allow any empty/shared zeropage PTEs */
> +	if (!cc->is_khugepaged)
> +		return HPAGE_PMD_NR;
> +	/* For all other cases respect the user defined maximum */
> +	return khugepaged_max_ptes_none;
> +}
> +
> +/**
> + * collapse_max_ptes_shared - Calculate maximum allowed PTEs that map shared
> + * anonymous pages for the given collapse operation.
> + * @cc: The collapse control struct
> + *
> + * Return: Maximum number of PTEs that map shared anonymous pages for the
> + * collapse operation
> + */
> +static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
> +{
> +	/*
> +	 * For MADV_COLLAPSE, do not restrict the number of PTEs that map shared
> +	 * anonymous pages.
> +	 */
> +	if (!cc->is_khugepaged)
> +		return HPAGE_PMD_NR;
> +	return khugepaged_max_ptes_shared;
> +}
> +
> +/**
> + * collapse_max_ptes_swap - Calculate the maximum allowed non-present PTEs or the
> + * maximum allowed non-present pagecache entries for the given collapse operation.
> + * @cc: The collapse control struct
> + *
> + * Return: Maximum number of non-present PTEs or the maximum allowed non-present
> + * pagecache entries for the collapse operation.
> + */
> +static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
> +{
> +	/*
> +	 * For MADV_COLLAPSE, do not restrict the number PTEs entries or
> +	 * pagecache entries that are non-present.
> +	 */
> +	if (!cc->is_khugepaged)
> +		return HPAGE_PMD_NR;
> +	return khugepaged_max_ptes_swap;
> +}
> +
>  int hugepage_madvise(struct vm_area_struct *vma,
>  		     vm_flags_t *vm_flags, int advice)
>  {
> @@ -540,6 +598,8 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		unsigned long start_addr, pte_t *pte, struct collapse_control *cc,
>  		struct list_head *compound_pagelist)
>  {
> +	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
> +	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
>  	struct page *page = NULL;
>  	struct folio *folio = NULL;
>  	unsigned long addr = start_addr;
> @@ -551,16 +611,12 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  	     _pte++, addr += PAGE_SIZE) {
>  		pte_t pteval = ptep_get(_pte);
>  		if (pte_none_or_zero(pteval)) {
> -			++none_or_zero;
> -			if (!userfaultfd_armed(vma) &&
> -			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> -				continue;
> -			} else {
> +			if (++none_or_zero > max_ptes_none) {
>  				result = SCAN_EXCEED_NONE_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>  				goto out;
>  			}
> +			continue;
>  		}
>  		if (!pte_present(pteval)) {
>  			result = SCAN_PTE_NON_PRESENT;
> @@ -591,9 +647,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>
>  		/* See collapse_scan_pmd(). */
>  		if (folio_maybe_mapped_shared(folio)) {
> -			++shared;
> -			if (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared) {
> +			if (++shared > max_ptes_shared) {
>  				result = SCAN_EXCEED_SHARED_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>  				goto out;
> @@ -1262,6 +1316,9 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  		struct vm_area_struct *vma, unsigned long start_addr,
>  		bool *lock_dropped, struct collapse_control *cc)
>  {
> +	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
> +	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
> +	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
>  	pmd_t *pmd;
>  	pte_t *pte, *_pte;
>  	int none_or_zero = 0, shared = 0, referenced = 0;
> @@ -1295,36 +1352,29 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>
>  		pte_t pteval = ptep_get(_pte);
>  		if (pte_none_or_zero(pteval)) {
> -			++none_or_zero;
> -			if (!userfaultfd_armed(vma) &&
> -			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> -				continue;
> -			} else {
> +			if (++none_or_zero > max_ptes_none) {
>  				result = SCAN_EXCEED_NONE_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>  				goto out_unmap;
>  			}
> +			continue;
>  		}
>  		if (!pte_present(pteval)) {
> -			++unmapped;
> -			if (!cc->is_khugepaged ||
> -			    unmapped <= khugepaged_max_ptes_swap) {
> -				/*
> -				 * Always be strict with uffd-wp
> -				 * enabled swap entries.  Please see
> -				 * comment below for pte_uffd_wp().
> -				 */
> -				if (pte_swp_uffd_wp_any(pteval)) {
> -					result = SCAN_PTE_UFFD_WP;
> -					goto out_unmap;
> -				}
> -				continue;
> -			} else {
> +			if (++unmapped > max_ptes_swap) {
>  				result = SCAN_EXCEED_SWAP_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>  				goto out_unmap;
>  			}
> +			/*
> +			 * Always be strict with uffd-wp
> +			 * enabled swap entries.  Please see
> +			 * comment below for pte_uffd_wp().
> +			 */
> +			if (pte_swp_uffd_wp_any(pteval)) {
> +				result = SCAN_PTE_UFFD_WP;
> +				goto out_unmap;
> +			}
> +			continue;
>  		}
>  		if (pte_uffd_wp(pteval)) {
>  			/*
> @@ -1367,9 +1417,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  		 * is shared.
>  		 */
>  		if (folio_maybe_mapped_shared(folio)) {
> -			++shared;
> -			if (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared) {
> +			if (++shared > max_ptes_shared) {
>  				result = SCAN_EXCEED_SHARED_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>  				goto out_unmap;
> @@ -2324,6 +2372,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  		unsigned long addr, struct file *file, pgoff_t start,
>  		struct collapse_control *cc)
>  {
> +	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, NULL);
> +	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
>  	struct folio *folio = NULL;
>  	struct address_space *mapping = file->f_mapping;
>  	XA_STATE(xas, &mapping->i_pages, start);
> @@ -2342,8 +2392,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>
>  		if (xa_is_value(folio)) {
>  			swap += 1 << xas_get_order(&xas);
> -			if (cc->is_khugepaged &&
> -			    swap > khugepaged_max_ptes_swap) {
> +			if (swap > max_ptes_swap) {
>  				result = SCAN_EXCEED_SWAP_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>  				break;
> @@ -2414,8 +2463,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  		cc->progress += HPAGE_PMD_NR;
>
>  	if (result == SCAN_SUCCEED) {
> -		if (cc->is_khugepaged &&
> -		    present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
> +		if (present < HPAGE_PMD_NR - max_ptes_none) {
>  			result = SCAN_EXCEED_NONE_PTE;
>  			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>  		} else {
> --
> 2.54.0
>
