Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681BC26E64D;
	Tue, 18 Feb 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896188; cv=none; b=HTTGS49lsg0pspHKAlgtA6XqYY3Uz9LIh+tdGBipN9NxMYsAlmHhRZbyAw80tuDk99cBRIMQDiJbAEKSON+d4K2yp4RXqQgOoYFASCeyeyfdx6cC9MjaUb6mghXvs4O4Ok5Ump6FoQM1TSP6KOW95YzIfm+k8xhlitE1qy8yzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896188; c=relaxed/simple;
	bh=HWr81C6dpXi3EBfML/c9XIkCR8w1KpkEpuelxGb+R8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCSqE3fYL5OnBTVjDOBv3OTFSoPmjUiIRf3h2qBoaMituAPbM5KRGhkeEwZ0hoaf53S7XxwcQnH3l/mlhQWmHzbkDlVwqodijzV1269fyXnu4fDdXRZwW2mMqbugtSvOS5johC/LH2eln+689qcr7obHxOUfW26jDPuZDxkGI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AF2A16F3;
	Tue, 18 Feb 2025 08:30:04 -0800 (PST)
Received: from [10.1.27.186] (XHFQ2J9959.cambridge.arm.com [10.1.27.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF253F59E;
	Tue, 18 Feb 2025 08:29:39 -0800 (PST)
Message-ID: <e8b4efe9-1c1e-4229-83a0-127319f52cc5@arm.com>
Date: Tue, 18 Feb 2025 16:29:38 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/9] khugepaged: rename hpage_collapse_* to khugepaged_*
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 usamaarif642@gmail.com, audra@redhat.com, akpm@linux-foundation.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-3-npache@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250211003028.213461-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 00:30, Nico Pache wrote:
> functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> as the function prefix.
> 
> rename all of them to khugepaged to keep things consistent and slightly
> shorten the function names.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/khugepaged.c | 52 ++++++++++++++++++++++++-------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 46faee67378b..4c88d17250f4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -402,14 +402,14 @@ void __init khugepaged_destroy(void)
>  	kmem_cache_destroy(mm_slot_cache);
>  }
>  
> -static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> +static inline int khugepaged_test_exit(struct mm_struct *mm)
>  {
>  	return atomic_read(&mm->mm_users) == 0;
>  }
>  
> -static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
> +static inline int khugepaged_test_exit_or_disable(struct mm_struct *mm)
>  {
> -	return hpage_collapse_test_exit(mm) ||
> +	return khugepaged_test_exit(mm) ||
>  	       test_bit(MMF_DISABLE_THP, &mm->flags);
>  }
>  
> @@ -444,7 +444,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>  	int wakeup;
>  
>  	/* __khugepaged_exit() must not run from under us */
> -	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> +	VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
>  	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
>  		return;
>  
> @@ -503,7 +503,7 @@ void __khugepaged_exit(struct mm_struct *mm)
>  	} else if (mm_slot) {
>  		/*
>  		 * This is required to serialize against
> -		 * hpage_collapse_test_exit() (which is guaranteed to run
> +		 * khugepaged_test_exit() (which is guaranteed to run
>  		 * under mmap sem read mode). Stop here (after we return all
>  		 * pagetables will be destroyed) until khugepaged has finished
>  		 * working on the pagetables under the mmap_lock.
> @@ -606,7 +606,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		folio = page_folio(page);
>  		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>  
> -		/* See hpage_collapse_scan_pmd(). */
> +		/* See khugepaged_scan_pmd(). */
>  		if (folio_likely_mapped_shared(folio)) {
>  			++shared;
>  			if (cc->is_khugepaged &&
> @@ -851,7 +851,7 @@ struct collapse_control khugepaged_collapse_control = {
>  	.is_khugepaged = true,
>  };
>  
> -static bool hpage_collapse_scan_abort(int nid, struct collapse_control *cc)
> +static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>  {
>  	int i;
>  
> @@ -886,7 +886,7 @@ static inline gfp_t alloc_hugepage_khugepaged_gfpmask(void)
>  }
>  
>  #ifdef CONFIG_NUMA
> -static int hpage_collapse_find_target_node(struct collapse_control *cc)
> +static int khugepaged_find_target_node(struct collapse_control *cc)
>  {
>  	int nid, target_node = 0, max_value = 0;
>  
> @@ -905,7 +905,7 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
>  	return target_node;
>  }
>  #else
> -static int hpage_collapse_find_target_node(struct collapse_control *cc)
> +static int khugepaged_find_target_node(struct collapse_control *cc)
>  {
>  	return 0;
>  }
> @@ -925,7 +925,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  	struct vm_area_struct *vma;
>  	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>  
> -	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +	if (unlikely(khugepaged_test_exit_or_disable(mm)))
>  		return SCAN_ANY_PROCESS;
>  
>  	*vmap = vma = find_vma(mm, address);
> @@ -992,7 +992,7 @@ static int check_pmd_still_valid(struct mm_struct *mm,
>  
>  /*
>   * Bring missing pages in from swap, to complete THP collapse.
> - * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
> + * Only done if khugepaged_scan_pmd believes it is worthwhile.
>   *
>   * Called and returns without pte mapped or spinlocks held.
>   * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
> @@ -1078,7 +1078,7 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>  {
>  	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>  		     GFP_TRANSHUGE);
> -	int node = hpage_collapse_find_target_node(cc);
> +	int node = khugepaged_find_target_node(cc);
>  	struct folio *folio;
>  
>  	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> @@ -1264,7 +1264,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	return result;
>  }
>  
> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> +static int khugepaged_scan_pmd(struct mm_struct *mm,
>  				   struct vm_area_struct *vma,
>  				   unsigned long address, bool *mmap_locked,
>  				   struct collapse_control *cc)
> @@ -1380,7 +1380,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  		 * hit record.
>  		 */
>  		node = folio_nid(folio);
> -		if (hpage_collapse_scan_abort(node, cc)) {
> +		if (khugepaged_scan_abort(node, cc)) {
>  			result = SCAN_SCAN_ABORT;
>  			goto out_unmap;
>  		}
> @@ -1449,7 +1449,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>  
>  	lockdep_assert_held(&khugepaged_mm_lock);
>  
> -	if (hpage_collapse_test_exit(mm)) {
> +	if (khugepaged_test_exit(mm)) {
>  		/* free mm_slot */
>  		hash_del(&slot->hash);
>  		list_del(&slot->mm_node);
> @@ -1744,7 +1744,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
>  			continue;
>  
> -		if (hpage_collapse_test_exit(mm))
> +		if (khugepaged_test_exit(mm))
>  			continue;
>  		/*
>  		 * When a vma is registered with uffd-wp, we cannot recycle
> @@ -2266,7 +2266,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	return result;
>  }
>  
> -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> +static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
>  				    struct file *file, pgoff_t start,
>  				    struct collapse_control *cc)
>  {
> @@ -2311,7 +2311,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>  		}
>  
>  		node = folio_nid(folio);
> -		if (hpage_collapse_scan_abort(node, cc)) {
> +		if (khugepaged_scan_abort(node, cc)) {
>  			result = SCAN_SCAN_ABORT;
>  			break;
>  		}
> @@ -2357,7 +2357,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>  	return result;
>  }
>  #else
> -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> +static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
>  				    struct file *file, pgoff_t start,
>  				    struct collapse_control *cc)
>  {
> @@ -2389,19 +2389,19 @@ static int khugepaged_collapse_single_pmd(unsigned long addr, struct mm_struct *
>  
>  			mmap_read_unlock(mm);
>  			*mmap_locked = false;
> -			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
> +			result = khugepaged_scan_file(mm, addr, file, pgoff,
>  							  cc);
>  			fput(file);
>  			if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
>  				mmap_read_lock(mm);
> -				if (hpage_collapse_test_exit_or_disable(mm))
> +				if (khugepaged_test_exit_or_disable(mm))
>  					goto end;
>  				result = collapse_pte_mapped_thp(mm, addr,
>  								 !cc->is_khugepaged);
>  				mmap_read_unlock(mm);
>  			}
>  		} else {
> -			result = hpage_collapse_scan_pmd(mm, vma, addr,
> +			result = khugepaged_scan_pmd(mm, vma, addr,
>  							 mmap_locked, cc);
>  		}
>  		if (result == SCAN_SUCCEED || result == SCAN_PMD_MAPPED)
> @@ -2449,7 +2449,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  		goto breakouterloop_mmap_lock;
>  
>  	progress++;
> -	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +	if (unlikely(khugepaged_test_exit_or_disable(mm)))
>  		goto breakouterloop;
>  
>  	vma_iter_init(&vmi, mm, khugepaged_scan.address);
> @@ -2457,7 +2457,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  		unsigned long hstart, hend;
>  
>  		cond_resched();
> -		if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {
> +		if (unlikely(khugepaged_test_exit_or_disable(mm))) {
>  			progress++;
>  			break;
>  		}
> @@ -2479,7 +2479,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  			bool mmap_locked = true;
>  
>  			cond_resched();
> -			if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +			if (unlikely(khugepaged_test_exit_or_disable(mm)))
>  				goto breakouterloop;
>  
>  			VM_BUG_ON(khugepaged_scan.address < hstart ||
> @@ -2515,7 +2515,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  	 * Release the current mm_slot if this mm is about to die, or
>  	 * if we scanned all vmas of this mm.
>  	 */
> -	if (hpage_collapse_test_exit(mm) || !vma) {
> +	if (khugepaged_test_exit(mm) || !vma) {
>  		/*
>  		 * Make sure that if mm_users is reaching zero while
>  		 * khugepaged runs here, khugepaged_exit will find

