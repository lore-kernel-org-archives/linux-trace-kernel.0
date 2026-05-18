Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAC3F8898
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105368; cv=none; b=mwbqNXYiuPvzqWT4uVHVG0CxvJgaGI0mXiHtzvgSVvwpEfcqT81Kaji4EdMCJON5nmQPy7R0V8z+CTcRbPKvzZxSudm4BJg/c+iUr9KRfcKaFV3leC9sJKQZlKaSR0BISVElc6WMebLHPVMxMo4OftgbUhcyqUQVBEq1x+PhIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105368; c=relaxed/simple;
	bh=lfpuBWpE/drB2RGskLZuxkE7ezxb0JMljtdwM6JQyMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eApi02t/14pHZ0Lm+cfOdWYSwUxfc0Uwc4GGc9dtbQ3RKPWDzB9EZ9ITV6BZq5m1iRoEIjuzKvliBMYkxm8iirC3fiTYXc+YUltIASG8sTdF9II96n0kFVrtj4lP/VIwdChYTtp4aoebNwS5nT858HPHb+DJZfZGyOYprzVD7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rdqyiaYq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rdqyiaYq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779105363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LJeLV2647C+GmwKXUyT3/UeLI1LWOfAc30rkgrn0ms=;
	b=rdqyiaYqPu/3PGr8wI8hiBGi8r49XAev4HhrQSjq2yn+GuqjVSomehva6Vv/1joKeJCYm2
	AxIJ3YQcKZvuKJIYrgCvb5HhkMUwLM11PF58ri2ZAi6OeIw3qVQINowz/X6q9sDGDsbjVE
	cg+Xr8pxJdU77R/0uRSV3F7ivZO1xE4=
From: Usama Arif <usama.arif@linux.dev>
To: Nico Pache <npache@redhat.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	jackmanb@google.com,
	jannh@google.com,
	jglisse@google.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	ljs@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rakie.kim@sk.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shivankg@amd.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: Re: [PATCH mm-unstable v17 02/14] mm/khugepaged: generalize alloc_charge_folio()
Date: Mon, 18 May 2026 04:55:51 -0700
Message-ID: <20260518115553.3513034-1-usama.arif@linux.dev>
In-Reply-To: <20260511185817.686831-3-npache@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 11 May 2026 12:58:02 -0600 Nico Pache <npache@redhat.com> wrote:

> From: Dev Jain <dev.jain@arm.com>
> 
> Pass order to alloc_charge_folio() and update mTHP statistics.
> 
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |  8 ++++++++
>  include/linux/huge_mm.h                    |  2 ++
>  mm/huge_memory.c                           |  4 ++++
>  mm/khugepaged.c                            | 17 +++++++++++------
>  4 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 5fbc3d89bb07..c51932e6275d 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -639,6 +639,14 @@ anon_fault_fallback_charge
>  	instead falls back to using huge pages with lower orders or
>  	small pages even though the allocation was successful.
>  
> +collapse_alloc
> +	is incremented every time a huge page is successfully allocated for a
> +	khugepaged collapse.
> +
> +collapse_alloc_failed
> +	is incremented every time a huge page allocation fails during a
> +	khugepaged collapse.
> +
>  zswpout
>  	is incremented every time a huge page is swapped out to zswap in one
>  	piece without splitting.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2949e5acff35..ba7ae6808544 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -128,6 +128,8 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_FAULT_ALLOC,
>  	MTHP_STAT_ANON_FAULT_FALLBACK,
>  	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_COLLAPSE_ALLOC,
> +	MTHP_STAT_COLLAPSE_ALLOC_FAILED,
>  	MTHP_STAT_ZSWPOUT,
>  	MTHP_STAT_SWPIN,
>  	MTHP_STAT_SWPIN_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e9d499da0ac7..05f482a72a89 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -699,6 +699,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>  DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc, MTHP_STAT_COLLAPSE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc_failed, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>  DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> @@ -764,6 +766,8 @@ static struct attribute *any_stats_attrs[] = {
>  #endif
>  	&split_attr.attr,
>  	&split_failed_attr.attr,
> +	&collapse_alloc_attr.attr,
> +	&collapse_alloc_failed_attr.attr,
>  	NULL,
>  };
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 979885694351..f0e29d5c7b1f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1068,21 +1068,26 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
>  }
>  
>  static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -		struct collapse_control *cc)
> +		struct collapse_control *cc, unsigned int order)
>  {
>  	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>  		     GFP_TRANSHUGE);
>  	int node = collapse_find_target_node(cc);
>  	struct folio *folio;
>  
> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>  	if (!folio) {
>  		*foliop = NULL;
> -		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		if (is_pmd_order(order))
> +			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>  		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>  	}
>  
> -	count_vm_event(THP_COLLAPSE_ALLOC);
> +	if (is_pmd_order(order))
> +		count_vm_event(THP_COLLAPSE_ALLOC);
> +	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
> +

The vmstat THP_COLLAPSE_ALLOC counter is pmd order only.
But after this we have

	count_memcg_folio_events(folio, THP_COLLAPSE_ALLOC, 1);

which is not being guarded with is_pmd_order().

I think we want this to be pmd order only as well so that
the meaning of the vmstat and cgroup counter remains the same?


>  	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
>  		folio_put(folio);
>  		*foliop = NULL;
> @@ -1118,7 +1123,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>  	 */
>  	mmap_read_unlock(mm);
>  
> -	result = alloc_charge_folio(&folio, mm, cc);
> +	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
>  		goto out_nolock;
>  
> @@ -1899,7 +1904,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
>  	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>  
> -	result = alloc_charge_folio(&new_folio, mm, cc);
> +	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
>  		goto out;
>  
> -- 
> 2.54.0
> 
> 
