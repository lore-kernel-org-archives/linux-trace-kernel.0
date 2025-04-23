Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC871E47C5;
	Wed, 23 Apr 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390956; cv=none; b=Ng1Xt5RwQHrirmX6QwDSjsabbt9Ao3OJMdqq20d18mIIiy8Bb6nzOmAEAvaBS0egiv0sQCKh4M61K8d25q1FlWzdOWVYcHv6qGBXEWmX6t0KYS1U8YLoxmMJqZbM3YAwuK2eYo2jbVQ+C3wnQh+ECysvYQ6UlXz+yYX3oZlELg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390956; c=relaxed/simple;
	bh=FvkUIcD+k1VdaVv0AT7fbiFJkpzh4S0vJw4yHG/Q/Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1Mf2HcLpEm7NyTea7NIrnOhD92HpN9JkLYdY+E5W64O34g+b4kxnjHlMYXlJxwkGREVqLAg9oT4dkICOlIspxeWT0gcb33O24rg2yNmJOKPHrCvkJ1sJZ5JFBPAOHwA6zex524ZwDEnT6DpDHWuKxnUWBiGEN8NiSaErlVAxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l9zDt2Th; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l9zDt2Th"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745390944; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2y0KviKeCmEsTK0cwMWTPnt4ulk5zm52OBi/NMgP9sk=;
	b=l9zDt2ThVBsddLI7VYSj6iq4DesvenhFcNbwkgVJAEjMLjp7Hs5nfygXHcdr7wgxLQ0RPmGnwzS+U0IRMssB99L822XnsOWdTqyBCnEc4wqf0ulaECzMXSnO4vQpgOhqoRu298OFTwwiq8bF/ilQskQPBsjxQ7M3mVQgCDu+A0Q=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXtUz9c_1745390941 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Apr 2025 14:49:01 +0800
Message-ID: <9617de11-c98a-4610-9c17-11fb981ef3dc@linux.alibaba.com>
Date: Wed, 23 Apr 2025 14:49:00 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] khugepaged: rename hpage_collapse_* to
 khugepaged_*
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250417000238.74567-1-npache@redhat.com>
 <20250417000238.74567-3-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
> functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> as the function prefix.
> 
> rename all of them to khugepaged to keep things consistent and slightly
> shorten the function names.

Yes, make sense to me.

> Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Nit: this renaming cleanup should be put in patch 1.

> ---
>   mm/khugepaged.c | 50 ++++++++++++++++++++++++-------------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cecadc4239e7..b6281c04f1e5 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -402,14 +402,14 @@ void __init khugepaged_destroy(void)
>   	kmem_cache_destroy(mm_slot_cache);
>   }
>   
> -static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> +static inline int khugepaged_test_exit(struct mm_struct *mm)
>   {
>   	return atomic_read(&mm->mm_users) == 0;
>   }
>   
> -static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
> +static inline int khugepaged_test_exit_or_disable(struct mm_struct *mm)
>   {
> -	return hpage_collapse_test_exit(mm) ||
> +	return khugepaged_test_exit(mm) ||
>   	       test_bit(MMF_DISABLE_THP, &mm->flags);
>   }
>   
> @@ -444,7 +444,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>   	int wakeup;
>   
>   	/* __khugepaged_exit() must not run from under us */
> -	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> +	VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
>   	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
>   		return;
>   
> @@ -503,7 +503,7 @@ void __khugepaged_exit(struct mm_struct *mm)
>   	} else if (mm_slot) {
>   		/*
>   		 * This is required to serialize against
> -		 * hpage_collapse_test_exit() (which is guaranteed to run
> +		 * khugepaged_test_exit() (which is guaranteed to run
>   		 * under mmap sem read mode). Stop here (after we return all
>   		 * pagetables will be destroyed) until khugepaged has finished
>   		 * working on the pagetables under the mmap_lock.
> @@ -851,7 +851,7 @@ struct collapse_control khugepaged_collapse_control = {
>   	.is_khugepaged = true,
>   };
>   
> -static bool hpage_collapse_scan_abort(int nid, struct collapse_control *cc)
> +static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>   {
>   	int i;
>   
> @@ -886,7 +886,7 @@ static inline gfp_t alloc_hugepage_khugepaged_gfpmask(void)
>   }
>   
>   #ifdef CONFIG_NUMA
> -static int hpage_collapse_find_target_node(struct collapse_control *cc)
> +static int khugepaged_find_target_node(struct collapse_control *cc)
>   {
>   	int nid, target_node = 0, max_value = 0;
>   
> @@ -905,7 +905,7 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
>   	return target_node;
>   }
>   #else
> -static int hpage_collapse_find_target_node(struct collapse_control *cc)
> +static int khugepaged_find_target_node(struct collapse_control *cc)
>   {
>   	return 0;
>   }
> @@ -925,7 +925,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>   	struct vm_area_struct *vma;
>   	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>   
> -	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +	if (unlikely(khugepaged_test_exit_or_disable(mm)))
>   		return SCAN_ANY_PROCESS;
>   
>   	*vmap = vma = find_vma(mm, address);
> @@ -992,7 +992,7 @@ static int check_pmd_still_valid(struct mm_struct *mm,
>   
>   /*
>    * Bring missing pages in from swap, to complete THP collapse.
> - * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
> + * Only done if khugepaged_scan_pmd believes it is worthwhile.
>    *
>    * Called and returns without pte mapped or spinlocks held.
>    * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
> @@ -1078,7 +1078,7 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>   {
>   	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>   		     GFP_TRANSHUGE);
> -	int node = hpage_collapse_find_target_node(cc);
> +	int node = khugepaged_find_target_node(cc);
>   	struct folio *folio;
>   
>   	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> @@ -1264,7 +1264,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	return result;
>   }
>   
> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> +static int khugepaged_scan_pmd(struct mm_struct *mm,
>   				   struct vm_area_struct *vma,
>   				   unsigned long address, bool *mmap_locked,
>   				   struct collapse_control *cc)
> @@ -1378,7 +1378,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   		 * hit record.
>   		 */
>   		node = folio_nid(folio);
> -		if (hpage_collapse_scan_abort(node, cc)) {
> +		if (khugepaged_scan_abort(node, cc)) {
>   			result = SCAN_SCAN_ABORT;
>   			goto out_unmap;
>   		}
> @@ -1447,7 +1447,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>   
>   	lockdep_assert_held(&khugepaged_mm_lock);
>   
> -	if (hpage_collapse_test_exit(mm)) {
> +	if (khugepaged_test_exit(mm)) {
>   		/* free mm_slot */
>   		hash_del(&slot->hash);
>   		list_del(&slot->mm_node);
> @@ -1742,7 +1742,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
>   			continue;
>   
> -		if (hpage_collapse_test_exit(mm))
> +		if (khugepaged_test_exit(mm))
>   			continue;
>   		/*
>   		 * When a vma is registered with uffd-wp, we cannot recycle
> @@ -2264,7 +2264,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   	return result;
>   }
>   
> -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> +static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
>   				    struct file *file, pgoff_t start,
>   				    struct collapse_control *cc)
>   {
> @@ -2309,7 +2309,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>   		}
>   
>   		node = folio_nid(folio);
> -		if (hpage_collapse_scan_abort(node, cc)) {
> +		if (khugepaged_scan_abort(node, cc)) {
>   			result = SCAN_SCAN_ABORT;
>   			break;
>   		}
> @@ -2355,7 +2355,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>   	return result;
>   }
>   #else
> -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> +static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
>   				    struct file *file, pgoff_t start,
>   				    struct collapse_control *cc)
>   {
> @@ -2383,19 +2383,19 @@ static int khugepaged_collapse_single_pmd(unsigned long addr,
>   
>   			mmap_read_unlock(mm);
>   			*mmap_locked = false;
> -			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
> +			result = khugepaged_scan_file(mm, addr, file, pgoff,
>   							  cc);
>   			fput(file);
>   			if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
>   				mmap_read_lock(mm);
> -				if (hpage_collapse_test_exit_or_disable(mm))
> +				if (khugepaged_test_exit_or_disable(mm))
>   					goto end;
>   				result = collapse_pte_mapped_thp(mm, addr,
>   								 !cc->is_khugepaged);
>   				mmap_read_unlock(mm);
>   			}
>   		} else {
> -			result = hpage_collapse_scan_pmd(mm, vma, addr,
> +			result = khugepaged_scan_pmd(mm, vma, addr,
>   							 mmap_locked, cc);
>   		}
>   		if (cc->is_khugepaged && result == SCAN_SUCCEED)
> @@ -2443,7 +2443,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   		goto breakouterloop_mmap_lock;
>   
>   	progress++;
> -	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +	if (unlikely(khugepaged_test_exit_or_disable(mm)))
>   		goto breakouterloop;
>   
>   	vma_iter_init(&vmi, mm, khugepaged_scan.address);
> @@ -2451,7 +2451,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   		unsigned long hstart, hend;
>   
>   		cond_resched();
> -		if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {
> +		if (unlikely(khugepaged_test_exit_or_disable(mm))) {
>   			progress++;
>   			break;
>   		}
> @@ -2473,7 +2473,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   			bool mmap_locked = true;
>   
>   			cond_resched();
> -			if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +			if (unlikely(khugepaged_test_exit_or_disable(mm)))
>   				goto breakouterloop;
>   
>   			VM_BUG_ON(khugepaged_scan.address < hstart ||
> @@ -2509,7 +2509,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   	 * Release the current mm_slot if this mm is about to die, or
>   	 * if we scanned all vmas of this mm.
>   	 */
> -	if (hpage_collapse_test_exit(mm) || !vma) {
> +	if (khugepaged_test_exit(mm) || !vma) {
>   		/*
>   		 * Make sure that if mm_users is reaching zero while
>   		 * khugepaged runs here, khugepaged_exit will find
