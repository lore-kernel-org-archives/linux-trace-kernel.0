Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FC198E60;
	Tue, 18 Feb 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895974; cv=none; b=JZQcu8eLU7JtjJ8hmvQC4y4npmu9OfoB1Zf+asnKVBnFH1cGmLNmBZeuiinzLbe6neuXnT8B/G6Gi4ZuVFwXJrz+LQssYZnC53NRqTr0a4RE5n6GE/ioEvnSNdGil+AhKcisatISAqXJSbOn/4NQZzShxmQXayBCeJ7snn1P7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895974; c=relaxed/simple;
	bh=mAKKpLK8tkLsblSxhjdkSQA7q+BNXVXYxQw89MAWpxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSXExnqZuxjf/g8axdk0ZQIkiJ1cEi0rEabpM17wQ143H+NUi8VSUdvWUcj52T2Sq5YH2Di5KTBklF/LwllyboVPrC4G/9n2rhvNBaYXzfRT928ofZ3xVA8tnXVq7zHNKj3xXRC72ALN/B7+ST78SZORROm/Q2B2827n7Q3UdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6C54152B;
	Tue, 18 Feb 2025 08:26:28 -0800 (PST)
Received: from [10.1.27.186] (XHFQ2J9959.cambridge.arm.com [10.1.27.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364EB3F59E;
	Tue, 18 Feb 2025 08:26:04 -0800 (PST)
Message-ID: <8d1fed22-5ba8-433b-9ef9-478b337b10d5@arm.com>
Date: Tue, 18 Feb 2025 16:26:02 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/9] introduce khugepaged_collapse_single_pmd to unify
 khugepaged and madvise_collapse
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
 <20250211003028.213461-2-npache@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250211003028.213461-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 00:30, Nico Pache wrote:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create khugepaged_collapse_single_pmd to increase code
> reuse and create an entry point for future khugepaged changes.
> 
> Refactor madvise_collapse and khugepaged_scan_mm_slot to use
> the new khugepaged_collapse_single_pmd function.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 96 +++++++++++++++++++++++++------------------------
>  1 file changed, 50 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5f0be134141e..46faee67378b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2365,6 +2365,52 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>  }
>  #endif
>  
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int khugepaged_collapse_single_pmd(unsigned long addr, struct mm_struct *mm,
> +				   struct vm_area_struct *vma, bool *mmap_locked,
> +				   struct collapse_control *cc)

nit: given the vma links to the mm is it really neccessary to pass both? Why not
just pass vma?

> +{
> +	int result = SCAN_FAIL;
> +	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
> +
> +	if (!*mmap_locked) {
> +		mmap_read_lock(mm);
> +		*mmap_locked = true;
> +	}

AFAICT, the read lock is always held when khugepaged_collapse_single_pmd() is
called. Perhaps VM_WARN_ON(!*mmap_locked) would be more appropriate?

> +
> +	if (thp_vma_allowable_order(vma, vma->vm_flags,
> +					tva_flags, PMD_ORDER)) {
> +		if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {

I guess it was like this before, but what's the relevance of CONFIG_SHMEM?
Surely this should work for any file if CONFIG_READ_ONLY_THP_FOR_FS is enabled?

> +			struct file *file = get_file(vma->vm_file);
> +			pgoff_t pgoff = linear_page_index(vma, addr);
> +
> +			mmap_read_unlock(mm);
> +			*mmap_locked = false;
> +			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
> +							  cc);
> +			fput(file);
> +			if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
> +				mmap_read_lock(mm);
> +				if (hpage_collapse_test_exit_or_disable(mm))
> +					goto end;
> +				result = collapse_pte_mapped_thp(mm, addr,
> +								 !cc->is_khugepaged);
> +				mmap_read_unlock(mm);
> +			}
> +		} else {
> +			result = hpage_collapse_scan_pmd(mm, vma, addr,
> +							 mmap_locked, cc);
> +		}
> +		if (result == SCAN_SUCCEED || result == SCAN_PMD_MAPPED)
> +			++khugepaged_pages_collapsed;

Looks like this counter was previously only incremented for the scan path, not
for the madvise_collapse path. Not sure if that's a problem?

Thanks,
Ryan

> +	}
> +end:
> +	return result;
> +}
> +
>  static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  					    struct collapse_control *cc)
>  	__releases(&khugepaged_mm_lock)
> @@ -2439,33 +2485,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  			VM_BUG_ON(khugepaged_scan.address < hstart ||
>  				  khugepaged_scan.address + HPAGE_PMD_SIZE >
>  				  hend);
> -			if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
> -				struct file *file = get_file(vma->vm_file);
> -				pgoff_t pgoff = linear_page_index(vma,
> -						khugepaged_scan.address);
>  
> -				mmap_read_unlock(mm);
> -				mmap_locked = false;
> -				*result = hpage_collapse_scan_file(mm,
> -					khugepaged_scan.address, file, pgoff, cc);
> -				fput(file);
> -				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
> -					mmap_read_lock(mm);
> -					if (hpage_collapse_test_exit_or_disable(mm))
> -						goto breakouterloop;
> -					*result = collapse_pte_mapped_thp(mm,
> -						khugepaged_scan.address, false);
> -					if (*result == SCAN_PMD_MAPPED)
> -						*result = SCAN_SUCCEED;
> -					mmap_read_unlock(mm);
> -				}
> -			} else {
> -				*result = hpage_collapse_scan_pmd(mm, vma,
> -					khugepaged_scan.address, &mmap_locked, cc);
> -			}
> -
> -			if (*result == SCAN_SUCCEED)
> -				++khugepaged_pages_collapsed;
> +			*result = khugepaged_collapse_single_pmd(khugepaged_scan.address,
> +						mm, vma, &mmap_locked, cc);
>  
>  			/* move to next address */
>  			khugepaged_scan.address += HPAGE_PMD_SIZE;
> @@ -2785,36 +2807,18 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  		mmap_assert_locked(mm);
>  		memset(cc->node_load, 0, sizeof(cc->node_load));
>  		nodes_clear(cc->alloc_nmask);
> -		if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
> -			struct file *file = get_file(vma->vm_file);
> -			pgoff_t pgoff = linear_page_index(vma, addr);
>  
> -			mmap_read_unlock(mm);
> -			mmap_locked = false;
> -			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
> -							  cc);
> -			fput(file);
> -		} else {
> -			result = hpage_collapse_scan_pmd(mm, vma, addr,
> -							 &mmap_locked, cc);
> -		}
> +		result = khugepaged_collapse_single_pmd(addr, mm, vma, &mmap_locked, cc);
> +
>  		if (!mmap_locked)
>  			*prev = NULL;  /* Tell caller we dropped mmap_lock */
>  
> -handle_result:
>  		switch (result) {
>  		case SCAN_SUCCEED:
>  		case SCAN_PMD_MAPPED:
>  			++thps;
>  			break;
>  		case SCAN_PTE_MAPPED_HUGEPAGE:
> -			BUG_ON(mmap_locked);
> -			BUG_ON(*prev);
> -			mmap_read_lock(mm);
> -			result = collapse_pte_mapped_thp(mm, addr, true);
> -			mmap_read_unlock(mm);
> -			goto handle_result;
> -		/* Whitelisted set of results where continuing OK */
>  		case SCAN_PMD_NULL:
>  		case SCAN_PTE_NON_PRESENT:
>  		case SCAN_PTE_UFFD_WP:

