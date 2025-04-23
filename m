Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD9223DFB;
	Wed, 23 Apr 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390979; cv=none; b=XHZB4jdAhzanslUF368wKPKyG9ZXNTUBWWozfJYdhKsJYjczL0kp/7BUSvAp2DvOBonrd7Wj+Kl/DjWrGEoO6uO9PRM6dajGEgGeC+zjbEhDq5rDvQ0X6BqhktdC2Up5Wizx/EIyo+KhbeEYCzrQZMn8NA6Pcjkk++/+9yrEMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390979; c=relaxed/simple;
	bh=lUuKd3ibErYYayL//vzQvPhmAbfz1EX03LJr3UQb6yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwuBaihxp87aEG3inT6hia6uanKUc2bk8XrodeIE8W5uioh+RjhtiHJXqs1pThvi7Jvn2FTrspoW4ePYwZYxynr98hKhSNnHueW5Z7GsMglLdde244PIMhsc2D3HkcOwSY6GhsN/o8blxIVXdZkyObbMZpLU+CJi1W5JSLNJl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=szjf+beS; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="szjf+beS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745390967; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JGm9lYL8xvhbTj7FN+hg66vA+WW9yw+RDmjxEEjhhuQ=;
	b=szjf+beSqHvZ4+g3t4cv+4oZdDBgNPLWxKUB8YHjKzNnALpNIxRsLbkC6Ch1yMee9MD03ClrtYkS4/yzAP/kJfofzEwtXeCPbXTePp4ql5pxoZIBXB7d46QmerHCRvPPxdpLUngYTkABtFF/xPdm/2iwCpNZB+dKiE/hXRS+mds=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXtRz4h_1745390641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Apr 2025 14:44:02 +0800
Message-ID: <a881ed65-351a-469f-b625-a3066d0f1d5c@linux.alibaba.com>
Date: Wed, 23 Apr 2025 14:44:01 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] introduce khugepaged_collapse_single_pmd to
 unify khugepaged and madvise_collapse
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
 <20250417000238.74567-2-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
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

Can you add a prefix 'khugepaged:' for the subject line?

> ---
>   mm/khugepaged.c | 92 ++++++++++++++++++++++++-------------------------
>   1 file changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b8838ba8207a..cecadc4239e7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2363,6 +2363,48 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>   }
>   #endif
>   
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int khugepaged_collapse_single_pmd(unsigned long addr,
> +				   struct vm_area_struct *vma, bool *mmap_locked,
> +				   struct collapse_control *cc)
> +{
> +	int result = SCAN_FAIL;
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
> +
> +	if (thp_vma_allowable_order(vma, vma->vm_flags,
> +					tva_flags, PMD_ORDER)) {

We've already checked the thp_vma_allowable_order() before calling this 
function, why check again?

> +		if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
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

why drop the following check?
if (*result == SCAN_PMD_MAPPED)
	*result = SCAN_SUCCEED;

> +				mmap_read_unlock(mm);
> +			}
> +		} else {
> +			result = hpage_collapse_scan_pmd(mm, vma, addr,
> +							 mmap_locked, cc);
> +		}
> +		if (cc->is_khugepaged && result == SCAN_SUCCEED)
> +			++khugepaged_pages_collapsed;
> +	}
> +end:
> +	return result;
> +}
> +
>   static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   					    struct collapse_control *cc)
>   	__releases(&khugepaged_mm_lock)
> @@ -2437,33 +2479,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   			VM_BUG_ON(khugepaged_scan.address < hstart ||
>   				  khugepaged_scan.address + HPAGE_PMD_SIZE >
>   				  hend);
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
> +						vma, &mmap_locked, cc);

If the khugepaged_collapse_single_pmd() returns a failure caused by 
hpage_collapse_test_exit_or_disable(), we should break out of the loop 
according to the original logic. But you've changed the action in this 
patch, is this intentional?

>   
>   			/* move to next address */
>   			khugepaged_scan.address += HPAGE_PMD_SIZE;
> @@ -2783,36 +2801,18 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>   		mmap_assert_locked(mm);
>   		memset(cc->node_load, 0, sizeof(cc->node_load));
>   		nodes_clear(cc->alloc_nmask);
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
> +		result = khugepaged_collapse_single_pmd(addr, vma, &mmap_locked, cc);
> +
>   		if (!mmap_locked)
>   			*prev = NULL;  /* Tell caller we dropped mmap_lock */
>   
> -handle_result:
>   		switch (result) {
>   		case SCAN_SUCCEED:
>   		case SCAN_PMD_MAPPED:
>   			++thps;
>   			break;
>   		case SCAN_PTE_MAPPED_HUGEPAGE:
> -			BUG_ON(mmap_locked);
> -			BUG_ON(*prev);
> -			mmap_read_lock(mm);
> -			result = collapse_pte_mapped_thp(mm, addr, true);
> -			mmap_read_unlock(mm);
> -			goto handle_result;
> -		/* Whitelisted set of results where continuing OK */
>   		case SCAN_PMD_NULL:
>   		case SCAN_PTE_NON_PRESENT:
>   		case SCAN_PTE_UFFD_WP:
