Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1F3859E6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 05:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144888; cv=none; b=S/jKSI2bEEGmy3enGtX2gnhQF/Qi4BK9L3tPQAhnHHq1ijD7VWa95QUXlJivQMCE8jWYWA2twY4cgVvCzJ+8/zpSvx4Kp2sjse2QwRwlvgWQ8nyJ3zolye/A5jjbs01IHIpnoEQI0CSZDnXjHrgBTKIPnY3EUYXszAEEih3W0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144888; c=relaxed/simple;
	bh=l98DFZTkmOwoiuoBKjF0ek24tBD/mMIzuhsdftbo4gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHihlQRkFKtVTOxc040/cak8Hth/LmGoSGROnz4EeExaRUNQvphskueNTvF3N3yKW4t6mN6v/CCY4KzMXg8cBcUqnmyh/h5t1k0pIkFnb8e2wVgMrZzX/8n1NmRU5Q6yoLD+R7fzqfzUueZium2PZcZI7s+MyT7Nu0bhy0VM4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pdgnYyyX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pdgnYyyX"
Message-ID: <65dcf7ab-1299-411f-9cbc-438ae72ff757@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769144867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFRsUB2fiki1rnBoFdqWSSWTb0H7HGcu8eMrImuExro=;
	b=pdgnYyyX9QKwooSTwRL3gPwN0gQ6ctxRiNO92M2DPTle3a4TI9mETzpWXx0W/pUXyMNP8p
	2tROMYwNQQa9BT2Xzq7S/r/SJtavAE/SZu358cQUx1El2Vxrjlt3RGLYyAP54+9awzmb/b
	+F2Rv1n+PCL/fv20UtoAoh6IOcSqREY=
Date: Fri, 23 Jan 2026 13:07:16 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable v14 03/16] introduce collapse_single_pmd to
 unify khugepaged and madvise_collapse
Content-Language: en-US
To: Nico Pache <npache@redhat.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com,
 hannes@cmpxchg.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, zokeefe@google.com, rientjes@google.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
References: <20260122192841.128719-1-npache@redhat.com>
 <20260122192841.128719-4-npache@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260122192841.128719-4-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/23 03:28, Nico Pache wrote:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create collapse_single_pmd to increase code reuse and create an entry
> point to these two users.
> 
> Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> collapse_single_pmd function. This introduces a minor behavioral change
> that is most likely an undiscovered bug. The current implementation of
> khugepaged tests collapse_test_exit_or_disable before calling
> collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
> case. By unifying these two callers madvise_collapse now also performs
> this check. We also modify the return value to be SCAN_ANY_PROCESS which
> properly indicates that this process is no longer valid to operate on.
> 
> We also guard the khugepaged_pages_collapsed variable to ensure its only
> incremented for khugepaged.
> 
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

I think this patch introduces some functional changes compared to previous
version[1] ...

Maybe we should drop the r-b tags and let folks take another look?

There might be an issue with the vma access in madvise_collapse(). See 
below:

[1] 
https://lore.kernel.org/linux-mm/20251201174627.23295-3-npache@redhat.com/

>   mm/khugepaged.c | 106 +++++++++++++++++++++++++++---------------------
>   1 file changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index fefcbdca4510..59e5a5588d85 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2394,6 +2394,54 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm, unsigned long a
>   	return result;
>   }
>   
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static enum scan_result collapse_single_pmd(unsigned long addr,
> +		struct vm_area_struct *vma, bool *mmap_locked,
> +		struct collapse_control *cc)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	enum scan_result result;
> +	struct file *file;
> +	pgoff_t pgoff;
> +
> +	if (vma_is_anonymous(vma)) {
> +		result = collapse_scan_pmd(mm, vma, addr, mmap_locked, cc);
> +		goto end;
> +	}
> +
> +	file = get_file(vma->vm_file);
> +	pgoff = linear_page_index(vma, addr);
> +
> +	mmap_read_unlock(mm);
> +	*mmap_locked = false;
> +	result = collapse_scan_file(mm, addr, file, pgoff, cc);
> +	fput(file);
> +
> +	if (result != SCAN_PTE_MAPPED_HUGEPAGE)
> +		goto end;
> +
> +	mmap_read_lock(mm);
> +	*mmap_locked = true;
> +	if (collapse_test_exit_or_disable(mm)) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +		return SCAN_ANY_PROCESS;
> +	}
> +	result = try_collapse_pte_mapped_thp(mm, addr, !cc->is_khugepaged);
> +	if (result == SCAN_PMD_MAPPED)
> +		result = SCAN_SUCCEED;
> +	mmap_read_unlock(mm);
> +	*mmap_locked = false;
> +
> +end:
> +	if (cc->is_khugepaged && result == SCAN_SUCCEED)
> +		++khugepaged_pages_collapsed;
> +	return result;
> +}
> +
>   static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *result,
>   					    struct collapse_control *cc)
>   	__releases(&khugepaged_mm_lock)
> @@ -2466,34 +2514,9 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *
>   			VM_BUG_ON(khugepaged_scan.address < hstart ||
>   				  khugepaged_scan.address + HPAGE_PMD_SIZE >
>   				  hend);
> -			if (!vma_is_anonymous(vma)) {
> -				struct file *file = get_file(vma->vm_file);
> -				pgoff_t pgoff = linear_page_index(vma,
> -						khugepaged_scan.address);
> -
> -				mmap_read_unlock(mm);
> -				mmap_locked = false;
> -				*result = collapse_scan_file(mm,
> -					khugepaged_scan.address, file, pgoff, cc);
> -				fput(file);
> -				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
> -					mmap_read_lock(mm);
> -					if (collapse_test_exit_or_disable(mm))
> -						goto breakouterloop;
> -					*result = try_collapse_pte_mapped_thp(mm,
> -						khugepaged_scan.address, false);
> -					if (*result == SCAN_PMD_MAPPED)
> -						*result = SCAN_SUCCEED;
> -					mmap_read_unlock(mm);
> -				}
> -			} else {
> -				*result = collapse_scan_pmd(mm, vma,
> -					khugepaged_scan.address, &mmap_locked, cc);
> -			}
> -
> -			if (*result == SCAN_SUCCEED)
> -				++khugepaged_pages_collapsed;
>   
> +			*result = collapse_single_pmd(khugepaged_scan.address,
> +						      vma, &mmap_locked, cc);
>   			/* move to next address */
>   			khugepaged_scan.address += HPAGE_PMD_SIZE;
>   			progress += HPAGE_PMD_NR;
> @@ -2799,6 +2822,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   			cond_resched();
>   			mmap_read_lock(mm);
>   			mmap_locked = true;
> +			*lock_dropped = true;
>   			result = hugepage_vma_revalidate(mm, addr, false, &vma,
>   							 cc);
>   			if (result  != SCAN_SUCCEED) {
> @@ -2809,17 +2833,17 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   			hend = min(hend, vma->vm_end & HPAGE_PMD_MASK);
>   		}
>   		mmap_assert_locked(mm);
> -		if (!vma_is_anonymous(vma)) {
> -			struct file *file = get_file(vma->vm_file);
> -			pgoff_t pgoff = linear_page_index(vma, addr);
>   
> -			mmap_read_unlock(mm);
> -			mmap_locked = false;
> +		result = collapse_single_pmd(addr, vma, &mmap_locked, cc);
> +
> +		if (!mmap_locked)
>   			*lock_dropped = true;
> -			result = collapse_scan_file(mm, addr, file, pgoff, cc);
>   
> -			if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb &&
> -			    mapping_can_writeback(file->f_mapping)) {
> +		if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb) {
> +			struct file *file = get_file(vma->vm_file);
> +			pgoff_t pgoff = linear_page_index(vma, addr);


After collapse_single_pmd() returns, mmap_lock might have been released. 
Between
that unlock and here, another thread could unmap/remap the VMA, making 
the vma
pointer stale when we access vma->vm_file?

Would it be safer to get the file reference before calling 
collapse_single_pmd()?
Or we need to revalidate the VMA after getting the lock back?


Thanks,
Lance

> +
> +			if (mapping_can_writeback(file->f_mapping)) {
>   				loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
>   				loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
>   
> @@ -2829,26 +2853,16 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   				goto retry;
>   			}
>   			fput(file);
> -		} else {
> -			result = collapse_scan_pmd(mm, vma, addr, &mmap_locked, cc);
>   		}
> -		if (!mmap_locked)
> -			*lock_dropped = true;
>   
> -handle_result:
>   		switch (result) {
>   		case SCAN_SUCCEED:
>   		case SCAN_PMD_MAPPED:
>   			++thps;
>   			break;
> -		case SCAN_PTE_MAPPED_HUGEPAGE:
> -			BUG_ON(mmap_locked);
> -			mmap_read_lock(mm);
> -			result = try_collapse_pte_mapped_thp(mm, addr, true);
> -			mmap_read_unlock(mm);
> -			goto handle_result;
>   		/* Whitelisted set of results where continuing OK */
>   		case SCAN_NO_PTE_TABLE:
> +		case SCAN_PTE_MAPPED_HUGEPAGE:
>   		case SCAN_PTE_NON_PRESENT:
>   		case SCAN_PTE_UFFD_WP:
>   		case SCAN_LACK_REFERENCED_PAGE:

