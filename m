Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF342F4A10
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555933; cv=none; b=VwyAUWTin2AXN2KCZ5HV4XfivVWUEc0vZqkv0rRepBuUX5Bax32sq6Ws8HkydJa5NRMpFM8R4mG8ppEr76743IAjM61iv4J/YV5VSecy1A2nxL4bRXqJsVYjTPvcfJHMYFiiCbXutCIVkMvzXV6Um8Q9FIV8DDtcWRuOpYSd678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555933; c=relaxed/simple;
	bh=0IiqlVUG7S0wBoQ/zJYgI1esaKEp/CFe4tRDjifEH24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuNfvtrSTFdAoknFZ4HOyXe0hB+DwWyJqBxxawrhKiAcaB7zXFm4OtIXCGhwU34CLwVlb9bL4JxNe6YhERkhy7uiJVMLCQI5yW91Wl1HdR0KKxBk4BiUp/1ff8nDz4ADwDUOVTGgUpufkCnFoq69eke28pfA6np2dT8NMT2y7e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xrsvdXAL; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xrsvdXAL"
Message-ID: <8c44810e-e687-44e1-bbe9-2e64a72b9e2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761555929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NrdA8zghIW2EEF1Iqq/Rrvu3dfufJEJ150yLue2lTE=;
	b=xrsvdXAL+FTmsqE5XZlLIYk3hLO05tn4wf4XrAQxTSY2hAzpq9hOE7VfsMnMXWnNb7O7gx
	+/dCgCMymwRQkjaJEFGH/4IssLmoCNbzC35zQLwUjxp05uX8UHGNBuPTfd2YIBsM/JfR1j
	nuocz7EbvsLcqRtfehjSxRmitH+n7aQ=
Date: Mon, 27 Oct 2025 17:05:03 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v12 mm-new 04/15] khugepaged: generalize
 alloc_charge_folio()
Content-Language: en-US
To: Nico Pache <npache@redhat.com>, dev.jain@arm.com
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, linux-trace-kernel@vger.kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, linux-mm@kvack.org,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 linux-kernel@vger.kernel.org, cl@gentwo.org, jglisse@google.com,
 surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org,
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
 hughd@google.com, richard.weiyang@gmail.com, vbabka@suse.cz,
 rppt@kernel.org, jannh@google.com, pfalcato@suse.de,
 linux-doc@vger.kernel.org
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-5-npache@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251022183717.70829-5-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/23 02:37, Nico Pache wrote:
> From: Dev Jain <dev.jain@arm.com>
> 
> Pass order to alloc_charge_folio() and update mTHP statistics.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

Cool! LGTM.

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>   Documentation/admin-guide/mm/transhuge.rst |  8 ++++++++
>   include/linux/huge_mm.h                    |  2 ++
>   mm/huge_memory.c                           |  4 ++++
>   mm/khugepaged.c                            | 17 +++++++++++------
>   4 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 1654211cc6cf..13269a0074d4 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -634,6 +634,14 @@ anon_fault_fallback_charge
>   	instead falls back to using huge pages with lower orders or
>   	small pages even though the allocation was successful.
>   
> +collapse_alloc
> +	is incremented every time a huge page is successfully allocated for a
> +	khugepaged collapse.
> +
> +collapse_alloc_failed
> +	is incremented every time a huge page allocation fails during a
> +	khugepaged collapse.
> +
>   zswpout
>   	is incremented every time a huge page is swapped out to zswap in one
>   	piece without splitting.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7698b3542c4f..3d29624c4f3f 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -128,6 +128,8 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_ALLOC,
>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_COLLAPSE_ALLOC,
> +	MTHP_STAT_COLLAPSE_ALLOC_FAILED,
>   	MTHP_STAT_ZSWPOUT,
>   	MTHP_STAT_SWPIN,
>   	MTHP_STAT_SWPIN_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 370ecfd6a182..0063d1ba926e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -620,6 +620,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc, MTHP_STAT_COLLAPSE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc_failed, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>   DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>   DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> @@ -685,6 +687,8 @@ static struct attribute *any_stats_attrs[] = {
>   #endif
>   	&split_attr.attr,
>   	&split_failed_attr.attr,
> +	&collapse_alloc_attr.attr,
> +	&collapse_alloc_failed_attr.attr,
>   	NULL,
>   };
>   
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6cf8700823f9..36ee659acfbb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1061,21 +1061,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   }
>   
>   static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -			      struct collapse_control *cc)
> +		struct collapse_control *cc, unsigned int order)
>   {
>   	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>   		     GFP_TRANSHUGE);
>   	int node = collapse_find_target_node(cc);
>   	struct folio *folio;
>   
> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>   	if (!folio) {
>   		*foliop = NULL;
> -		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		if (order == HPAGE_PMD_ORDER)
> +			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>   		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>   	}
>   
> -	count_vm_event(THP_COLLAPSE_ALLOC);
> +	if (order == HPAGE_PMD_ORDER)
> +		count_vm_event(THP_COLLAPSE_ALLOC);
> +	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
> +
>   	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
>   		folio_put(folio);
>   		*foliop = NULL;
> @@ -1112,7 +1117,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 */
>   	mmap_read_unlock(mm);
>   
> -	result = alloc_charge_folio(&folio, mm, cc);
> +	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
>   		goto out_nolock;
>   
> @@ -1850,7 +1855,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
>   	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>   
> -	result = alloc_charge_folio(&new_folio, mm, cc);
> +	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
>   		goto out;
>   

