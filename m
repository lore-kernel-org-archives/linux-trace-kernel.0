Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF21391508;
	Mon, 27 Apr 2026 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319573; cv=none; b=dSleb/EM5Z9O8gVNFVd7H1XeGbPnv/DKbYHdnnFa/Aj+4+nhw1S7LT8MDzIDfd+MA1wmp0ipWXDovs4yyyU6vQTrbT4aTfDOOswRIDwuT2gVmZt/YAa4Mwm5qPF5x5yQTW6MwL1CGssB5Nf2Xja8Af5jCrvnxLJpqkeYz2t/pro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319573; c=relaxed/simple;
	bh=nMUs3j4oRfS4xN/aXfAYDXvvR+JDwFyrHxatlmxxLsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvVz8CRWdyl8M9DgdMIswbtSc2ffy+UckVU8ki0YpK/iqM377kSC22R+/HzEB8OmifnFAnKK2jq/+yqy/30u1EaFaXq4wx8whpz2HIkt7fe7ihMFqx47OCQeMFZhR22Fpf/Le7bZgarNaH7+JuYCYvcJR8xNZHbhdAc4mYrLL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCf1Y2V8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCf1Y2V8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD5EC19425;
	Mon, 27 Apr 2026 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319572;
	bh=nMUs3j4oRfS4xN/aXfAYDXvvR+JDwFyrHxatlmxxLsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fCf1Y2V8QS100Le+B2nUjSCjkbs627LHV9ITFoSou0A2UiR/U2RXRmlx7xPk8o+8L
	 Fj8jFWNSru/FORmZhoW5Oal7Fayc8nchcPyzea/nNzoF9IMMybxX1ZwroQo9yUwACw
	 RLllrNFicdFtA5UGwjJRsTFenbGJIy1t1AREfwiVvgWW1He/rvADKz9mXr7jve5hiZ
	 dBcYIzYY6c84KaZq3b/o9akK9X0ksD5ozMzFbB+r/KnxwZAjSb2J4u7PSjqELjtV6x
	 hEB87RPq16WmuaV/WNRfX6s+EF99MyWg8BSElbKLd16gODJelbsf/WjdyUai7dXc0D
	 xDQ+5zTITabJQ==
Message-ID: <c82a0b73-67ff-45e6-a792-e610b35a5b2f@kernel.org>
Date: Mon, 27 Apr 2026 21:52:32 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 v16 03/13] mm/khugepaged: rework max_ptes_* handling
 with helper functions
To: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com,
 cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com,
 jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 Liam.Howlett@oracle.com, ljs@kernel.org, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com,
 shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com,
 thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com,
 vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
 will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
References: <20260419185750.260784-1-npache@redhat.com>
 <20260419185750.260784-4-npache@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260419185750.260784-4-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/26 20:57, Nico Pache wrote:
> The following cleanup reworks all the max_ptes_* handling into helper
> functions. This increases the code readability and will later be used to
> implement the mTHP handling of these variables.
> 
> With these changes we abstract all the madvise_collapse() special casing
> (dont respect the sysctls) away from the functions that utilize them. And
> will later in this series to cleanly restrict mTHP collapses behaviors.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 114 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 78 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index afac6bc4e76d..f42b55421191 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -348,6 +348,58 @@ static bool pte_none_or_zero(pte_t pte)
>  	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
>  }
>  
> +/**
> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse

empty PTE or PTE mapping the shared zeropage ? That should be clarified also below.

> + * @cc: The collapse control struct
> + * @vma: The vma to check for userfaultfd
> + *
> + * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
> + * empty page.

Not completely accurate due to uffd. And it's not really "empty page".

Is that information really necessary for the caller? I'd suggest you drop this
here and instead add a comment inline above the "return HPAGE_PMD_NR;".

> + *
> + * Return: Maximum number of empty PTEs allowed for the collapse operation
> + */
> +static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
> +		struct vm_area_struct *vma)
> +{
> +	if (vma && userfaultfd_armed(vma))
> +		return 0;
> +	if (!cc->is_khugepaged)
> +		return HPAGE_PMD_NR;
> +	return khugepaged_max_ptes_none;
> +}
> +
> +/**
> + * collapse_max_ptes_shared - Calculate maximum allowed shared PTEs for collapse

"shared PTE" is not quite clear.

"PTEs that map shared anonymous pages" ?

> + * @cc: The collapse control struct
> + *
> + * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
> + * shared page.

Same comment as above.

> + *
> + * Return: Maximum number of shared PTEs allowed for the collapse operation
> + */
> +static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
> +{
> +	if (!cc->is_khugepaged)
> +		return HPAGE_PMD_NR;
> +	return khugepaged_max_ptes_shared;
> +}
> +
> +/**
> + * collapse_max_ptes_swap - Calculate maximum allowed swap PTEs for collapse

We're actually checking non-present page table entries (anonymous THP collapse)
or non-present pagecache entries (file THP collapse).

I wonder if there is an easy way to clarify that here, at least in the
description (confusing name can stay unless we find something better).

> + * @cc: The collapse control struct
> + *
> + * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
> + * swap page.

Dito.

> + *
> + * Return: Maximum number of swap PTEs allowed for the collapse operation
> + */
> +static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
> +{
> +	if (!cc->is_khugepaged)
> +		return HPAGE_PMD_NR;
> +	return khugepaged_max_ptes_swap;
> +}
> +
>  int hugepage_madvise(struct vm_area_struct *vma,
>  		     vm_flags_t *vm_flags, int advice)
>  {
> @@ -546,21 +598,19 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  	pte_t *_pte;
>  	int none_or_zero = 0, shared = 0, referenced = 0;
>  	enum scan_result result = SCAN_FAIL;
> +	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
> +	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);

These could be const, right? Or will that change in future patches?

>  
>  	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
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
> @@ -591,9 +641,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
> @@ -1270,6 +1318,9 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  	unsigned long addr;
>  	spinlock_t *ptl;
>  	int node = NUMA_NO_NODE, unmapped = 0;
> +	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
> +	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
> +	unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);

Same question here.

>  
>  	VM_BUG_ON(start_addr & ~HPAGE_PMD_MASK);
>  


In general, LGTM. With the doc fixed up

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
