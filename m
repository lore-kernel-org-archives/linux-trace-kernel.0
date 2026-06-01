Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E663B27D1;
	Mon,  1 Jun 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323224; cv=none; b=nFfTpcd71pDMoTKc5QoAfE2mRqbZNYhGbT5YPC37cgSJco0jJzjiqnn+m3ax20WKOKgiVrQpdJneSUcWvFruxaPYu+g4+tWpmDSwp6mo+w+8zxbnPauoRuVyxcZCj1Y8NzIEAckPDxMFBDlF8HIkSiMUv5WG+h4GffYfTQf/MlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323224; c=relaxed/simple;
	bh=fboTUE8QM8s/GHFZVrRGnzaZM0sydyBVEqdWxWhaEkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJbgANYcb0Zoknn60fOZWd1nSHqa3B6oWdZbFj7/TyWZqea3x8Plp5AoIZicr4GnX6olpwZ7MPu+GPHv74YKyAxE66JVce8K9APZCGz/Agb+Mj4nZpjIIjoPFYygnhu22xGuhAvLxTsmHaA5IJjhFYjVeL2xlBGW9S5C/FsN5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGujj4tD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGujj4tD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA7E1F00893;
	Mon,  1 Jun 2026 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780323223;
	bh=MiMUoPQVbAq+0Xavfk3WxTvqOCU0qayiHbRRU+6Geak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HGujj4tDkadqTA9Q8vNWga74uKYF9W9ayMskIVPbIn5pPH6oxITdEMT2GhUPh1k+n
	 sqDs5jEwPtLZnq1QYz/22DN4VB5+zAWkYvZs30wRNPprt3r82UM/HuoWyfPpsye9kW
	 b9D/JXZ5pztZrfUd2YLKeOWywci2An1XYFTmdO9kpksI3SMlbGT3ZeQpZU5+l6Y7ed
	 3ClUukjPJTkQJtxZ9N4hREXHZTTqGNQzeNlWJLr4+75uUDnwo1Rp3cBiTwm6n6S2EH
	 4Agp83sUSHwwN6a2Q1i8nFlUgKXAdZR+4l4N+/p0C6aWUDoUwfL8BvInhzGZG4wfka
	 am9uNQNtvTgng==
Date: Mon, 1 Jun 2026 15:13:28 +0100
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
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 08/14] mm/khugepaged: add per-order mTHP
 collapse failure statistics
Message-ID: <ah2TDTIrpw0dd2zg@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-9-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522150009.121603-9-npache@redhat.com>

On Fri, May 22, 2026 at 09:00:03AM -0600, Nico Pache wrote:
> Add three new mTHP statistics to track collapse failures for different
> orders when encountering swap PTEs, excessive none PTEs, and shared PTEs:
>
> - collapse_exceed_swap_pte: Increment when mTHP collapse fails due to
> 	encountering a swap PTE.
>
> - collapse_exceed_none_pte: Counts when mTHP collapse fails due to
>   	exceeding the none PTE threshold for the given order
>
> - collapse_exceed_shared_pte: Counts when mTHP collapse fails due to
> 	encountering a shared PTE.
>
> These statistics complement the existing THP_SCAN_EXCEED_* events by
> providing per-order granularity for mTHP collapse attempts. The stats are
> exposed via sysfs under
> `/sys/kernel/mm/transparent_hugepage/hugepages-*/stats/` for each
> supported hugepage size.
>
> As we currently do not support collapsing mTHPs that contain a swap or
> shared entry, those statistics keep track of how often we are
> encountering failed mTHP collapses due to these restrictions.
>
> We will add support for mTHP collapse for anonymous pages next; lets also
> track when this happens at the PMD level within the per-mTHP stats.
>
> Signed-off-by: Nico Pache <npache@redhat.com>

Logic LGTM, small comment below, but otherwise:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 14 ++++++++++++++
>  include/linux/huge_mm.h                    |  3 +++
>  mm/huge_memory.c                           |  7 +++++++
>  mm/khugepaged.c                            | 21 +++++++++++++++++++--
>  4 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index c51932e6275d..80a4d0bed70b 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -714,6 +714,20 @@ nr_anon_partially_mapped
>         an anonymous THP as "partially mapped" and count it here, even though it
>         is not actually partially mapped anymore.
>
> +collapse_exceed_none_pte
> +       The number of collapse attempts that failed due to exceeding the
> +       max_ptes_none threshold.
> +
> +collapse_exceed_swap_pte
> +       The number of collapse attempts that failed due to exceeding the
> +       max_ptes_swap threshold. For non-PMD orders this occurs if a mTHP range
> +       contains at least one swap PTE.
> +
> +collapse_exceed_shared_pte
> +       The number of collapse attempts that failed due to exceeding the
> +       max_ptes_shared threshold. For non-PMD orders this occurs if a mTHP range
> +       contains at least one shared PTE.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index ba7ae6808544..48496f09909b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -144,6 +144,9 @@ enum mthp_stat_item {
>  	MTHP_STAT_SPLIT_DEFERRED,
>  	MTHP_STAT_NR_ANON,
>  	MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> +	MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> +	MTHP_STAT_COLLAPSE_EXCEED_NONE,
> +	MTHP_STAT_COLLAPSE_EXCEED_SHARED,
>  	__MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 345c54133c83..5c128cdec810 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -703,6 +703,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>  DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
>  DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEED_NONE);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
> +
>
>  static struct attribute *anon_stats_attrs[] = {
>  	&anon_fault_alloc_attr.attr,
> @@ -719,6 +723,9 @@ static struct attribute *anon_stats_attrs[] = {
>  	&split_deferred_attr.attr,
>  	&nr_anon_attr.attr,
>  	&nr_anon_partially_mapped_attr.attr,
> +	&collapse_exceed_swap_pte_attr.attr,
> +	&collapse_exceed_none_pte_attr.attr,
> +	&collapse_exceed_shared_pte_attr.attr,
>  	NULL,
>  };
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 928e32a0d4d7..fff6a8fbf1d4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -649,7 +649,9 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		if (pte_none_or_zero(pteval)) {
>  			if (++none_or_zero > max_ptes_none) {
>  				result = SCAN_EXCEED_NONE_PTE;
> -				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				if (is_pmd_order(order))
> +					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
>  				goto out;
>  			}
>  			continue;
> @@ -683,9 +685,17 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>
>  		/* See collapse_scan_pmd(). */
>  		if (folio_maybe_mapped_shared(folio)) {
> +			/*
> +			 * TODO: Support shared pages without leading to further
> +			 * mTHP collapses. Currently bringing in new pages via
> +			 * shared may cause a future higher order collapse on a
> +			 * rescan of the same range.
> +			 */

Seems weird to add this comment in a stats update patch?

Not a massively big deal but maybe worth moving to the relevant commit.

>  			if (++shared > max_ptes_shared) {
>  				result = SCAN_EXCEED_SHARED_PTE;
> -				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
> +				if (is_pmd_order(order))
> +					count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
> +				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
>  				goto out;
>  			}
>  		}
> @@ -1138,6 +1148,7 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
>  		 * range.
>  		 */
>  		if (!is_pmd_order(order)) {
> +			count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
>  			pte_unmap(pte);
>  			mmap_read_unlock(mm);
>  			result = SCAN_EXCEED_SWAP_PTE;
> @@ -1433,6 +1444,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  			if (++none_or_zero > max_ptes_none) {
>  				result = SCAN_EXCEED_NONE_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				count_mthp_stat(HPAGE_PMD_ORDER,
> +						MTHP_STAT_COLLAPSE_EXCEED_NONE);
>  				goto out_unmap;
>  			}
>  			continue;
> @@ -1441,6 +1454,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  			if (++unmapped > max_ptes_swap) {
>  				result = SCAN_EXCEED_SWAP_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
> +				count_mthp_stat(HPAGE_PMD_ORDER,
> +						MTHP_STAT_COLLAPSE_EXCEED_SWAP);
>  				goto out_unmap;
>  			}
>  			/*
> @@ -1498,6 +1513,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  			if (++shared > max_ptes_shared) {
>  				result = SCAN_EXCEED_SHARED_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
> +				count_mthp_stat(HPAGE_PMD_ORDER,
> +						MTHP_STAT_COLLAPSE_EXCEED_SHARED);
>  				goto out_unmap;
>  			}
>  		}
> --
> 2.54.0
>
