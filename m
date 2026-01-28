Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEF313552
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618328; cv=none; b=sQTnkIXVlrmXP9MN9zGIy/EDIkuB6Dssb72C3CN+4MWXFa+B6NsckO2xSP0VjJSuEV7x8El50KoaE1rmwH6ODwg7hHr4r+lM6aKHe41g6nJC/rEF/tVIH521CZv3Q8kn/2JTXOhJux57ISe6WU4+JAC+opajjRzJUWZ9zCLExz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618328; c=relaxed/simple;
	bh=oYpywg6wSKKfqKMO9drAZK+XQSP+GwNWRgfyOXjs4ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/wlChCHcPux075ZYO9htzz53KQTmiCnHNZ1tOeowDSJWCbbMeG2L8Fn+bVR/au81TBKVdSfyUUbyj9RgJtheiP2ZoJQhwSaDOfNYQadOsuUouJxy2aOSJLa4pylqLlaC11Xy3hLyxf26aVq9c2AA1QYTCr+WgNdIh1ebvZBrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARRu21ty; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARRu21ty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769618325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvwUtKzwHdNf28qH621RfDijiiFJTykMerMvhScCt2E=;
	b=ARRu21tyqu5DOTFbFXrvmWpky3yzHdNxZtAJLJJmXMF60E84wCF7PsyJnDHIf3tDKocwpm
	ISSjSVEJNYr0j96GuO0DwFv1NYlgY3T7AvHiS+q1/YerdRHxt6bd2unABLJZio8eJsN9Jl
	OX943DxrOmMEIfb/pP1slBxkAYqPduU=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-ph3CW09vNRe8XrX8HLSOIQ-1; Wed, 28 Jan 2026 11:38:44 -0500
X-MC-Unique: ph3CW09vNRe8XrX8HLSOIQ-1
X-Mimecast-MFC-AGG-ID: ph3CW09vNRe8XrX8HLSOIQ_1769618324
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4088136faccso12058092fac.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 08:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769618324; x=1770223124;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvwUtKzwHdNf28qH621RfDijiiFJTykMerMvhScCt2E=;
        b=BqdWjyxNKmuHR2wJBe3OkkHCt1l8VY36OBdDQn/WaXOAsvM+bWKTSMTozPkCO6atQK
         UaSWhyScRkElojWD8RJdTb0ee1Lj0okpsuWCc4xk2AkXKuLX7zAVPlTEKJKDH92pgn4i
         ts08ePNW1Xz3jnLEsOnllpx6aWIdCAg61jB22PduEOUh8YdYhtT6hvW/lDNV66NCOlbN
         biD36O+OOpi4lZr9KW5leXKEVO2RORaoORidrgq1Al6683hjUvQZByPzdRVOw1NcBgfV
         DkWBNIE/YEo1aPhoqk4Y9YCqVCr6RfCU/N16qP89GY3AhYehQ/yhiFBUfRFcnYvb0rm0
         YAbA==
X-Forwarded-Encrypted: i=1; AJvYcCVZJKQN2IvOjzUONhszurI+Z3xf6WczD826dr7h3oC1jsglXIbhx7IubLSYF5GldOhtIxLLJjIPcWVIYsZgiYXKcfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYh8lqHnl8wD6kQbP7wGeexD9hXdgPbYXUMpzicRvbwJCzaWq
	qiCmDv3genEuskQ94kMicPq7vE9Yk4QmUVfHwuCHxu5SB+Lpn1YdTgrz1sZuSFVv3linuFbh2YV
	eIM4vNjmuJUtMWxgOY+/98mbrvkhrbJ6uRq093ux5vfR5DGyojSF1HUWhoIqN00otHXrUKGFjgg
	==
X-Gm-Gg: AZuq6aI3dLPD6TMWbbTC7dqYoUGWx5wP82oWyY/8YHRdJjxNkS/brfp69GwGEotGVsK
	VSIak4NMS3Qe5CqLAiJ0VbAYniek/a85luNNrRQUrN2aGtZ44R7wlzuMxDNStLjN5EJBX9oZ1BM
	XyVLUaCYFavOUWrndydtdLJj7/w0XlaYBgz1TxsaFlor+vs+SkAdM68uv/TcympkysedvQMMpJS
	Cm/ZP6LTxfixHDRe+CzOOgl4HyLxBxo08/4EODzGEWHukfsWG5ZxL2jRyqulEq+FRlW1uXQUwid
	Tq8i5OpXpZMCL9u/ju1s1rPqAqx0iIgGqgIsmu5urLqRcflCfgBEK0Un34l7CA8c2bO300jumTl
	goLkO3nira9qlyoBoWQ==
X-Received: by 2002:a05:6870:6f03:b0:3ec:3aa1:84d2 with SMTP id 586e51a60fabf-4093fc716demr3763764fac.11.1769618322522;
        Wed, 28 Jan 2026 08:38:42 -0800 (PST)
X-Received: by 2002:a05:6870:6f03:b0:3ec:3aa1:84d2 with SMTP id 586e51a60fabf-4093fc716demr3763682fac.11.1769618320931;
        Wed, 28 Jan 2026 08:38:40 -0800 (PST)
Received: from ?IPV6:2601:282:1c83:9aa0::56cf? ([2601:282:1c83:9aa0::56cf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409570f63b4sm2077985fac.3.2026.01.28.08.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:38:40 -0800 (PST)
Message-ID: <b824f131-3e51-422c-9e98-044b0a2928a6@redhat.com>
Date: Wed, 28 Jan 2026 09:38:37 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v14 03/16] introduce collapse_single_pmd to
 unify khugepaged and madvise_collapse
To: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Cc: david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org,
 willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, zokeefe@google.com, rientjes@google.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 David Hildenbrand <david@redhat.com>, shivankg@amd.com
References: <20260122192841.128719-1-npache@redhat.com>
 <20260122192841.128719-4-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
In-Reply-To: <20260122192841.128719-4-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fyid1eqwfgD9mzfwCMMVFYrga5E0SDk60V4pBV61ue8_1769618324
X-Mimecast-Originator: redhat.com
Content-Language: en-US, en-ZM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

could you please apply the following fixup to avoid potentially using a stale
VMA in the new writeback-retry logic for madvise collapse.

Thank you!
-- Nico

----8<----
commit a9ac3b1bfa926dd707ac3a785583f8d7a0579578
Author: Nico Pache <npache@redhat.com>
Date:   Fri Jan 23 16:32:42 2026 -0700

    madvise writeback retry logic fix

    Signed-off-by: Nico Pache <npache@redhat.com>

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 59e5a5588d85..2b054f7d9753 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2418,6 +2418,14 @@ static enum scan_result collapse_single_pmd(unsigned long
addr,
 	mmap_read_unlock(mm);
 	*mmap_locked = false;
 	result = collapse_scan_file(mm, addr, file, pgoff, cc);
+
+	if (!cc->is_khugepaged && result == SCAN_PAGE_DIRTY_OR_WRITEBACK &&
+	    mapping_can_writeback(file->f_mapping)) {
+		const loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
+		const loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
+
+		filemap_write_and_wait_range(file->f_mapping, lstart, lend);
+	}
 	fput(file);

 	if (result != SCAN_PTE_MAPPED_HUGEPAGE)
@@ -2840,19 +2848,8 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned
long start,
 			*lock_dropped = true;

 		if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb) {
-			struct file *file = get_file(vma->vm_file);
-			pgoff_t pgoff = linear_page_index(vma, addr);
-
-			if (mapping_can_writeback(file->f_mapping)) {
-				loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
-				loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
-
-				filemap_write_and_wait_range(file->f_mapping, lstart, lend);
-				triggered_wb = true;
-				fput(file);
-				goto retry;
-			}
-			fput(file);
+			triggered_wb = true;
+			goto retry;
 		}

 		switch (result) {
--
2.52.0

On 1/22/26 12:28 PM, Nico Pache wrote:
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
>  mm/khugepaged.c | 106 +++++++++++++++++++++++++++---------------------
>  1 file changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index fefcbdca4510..59e5a5588d85 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2394,6 +2394,54 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm, unsigned long a
>  	return result;
>  }
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
>  static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *result,
>  					    struct collapse_control *cc)
>  	__releases(&khugepaged_mm_lock)
> @@ -2466,34 +2514,9 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *
>  			VM_BUG_ON(khugepaged_scan.address < hstart ||
>  				  khugepaged_scan.address + HPAGE_PMD_SIZE >
>  				  hend);
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
>  			/* move to next address */
>  			khugepaged_scan.address += HPAGE_PMD_SIZE;
>  			progress += HPAGE_PMD_NR;
> @@ -2799,6 +2822,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  			cond_resched();
>  			mmap_read_lock(mm);
>  			mmap_locked = true;
> +			*lock_dropped = true;
>  			result = hugepage_vma_revalidate(mm, addr, false, &vma,
>  							 cc);
>  			if (result  != SCAN_SUCCEED) {
> @@ -2809,17 +2833,17 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  			hend = min(hend, vma->vm_end & HPAGE_PMD_MASK);
>  		}
>  		mmap_assert_locked(mm);
> -		if (!vma_is_anonymous(vma)) {
> -			struct file *file = get_file(vma->vm_file);
> -			pgoff_t pgoff = linear_page_index(vma, addr);
>  
> -			mmap_read_unlock(mm);
> -			mmap_locked = false;
> +		result = collapse_single_pmd(addr, vma, &mmap_locked, cc);
> +
> +		if (!mmap_locked)
>  			*lock_dropped = true;
> -			result = collapse_scan_file(mm, addr, file, pgoff, cc);
>  
> -			if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb &&
> -			    mapping_can_writeback(file->f_mapping)) {
> +		if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb) {
> +			struct file *file = get_file(vma->vm_file);
> +			pgoff_t pgoff = linear_page_index(vma, addr);
> +
> +			if (mapping_can_writeback(file->f_mapping)) {
>  				loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
>  				loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
>  
> @@ -2829,26 +2853,16 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  				goto retry;
>  			}
>  			fput(file);
> -		} else {
> -			result = collapse_scan_pmd(mm, vma, addr, &mmap_locked, cc);
>  		}
> -		if (!mmap_locked)
> -			*lock_dropped = true;
>  
> -handle_result:
>  		switch (result) {
>  		case SCAN_SUCCEED:
>  		case SCAN_PMD_MAPPED:
>  			++thps;
>  			break;
> -		case SCAN_PTE_MAPPED_HUGEPAGE:
> -			BUG_ON(mmap_locked);
> -			mmap_read_lock(mm);
> -			result = try_collapse_pte_mapped_thp(mm, addr, true);
> -			mmap_read_unlock(mm);
> -			goto handle_result;
>  		/* Whitelisted set of results where continuing OK */
>  		case SCAN_NO_PTE_TABLE:
> +		case SCAN_PTE_MAPPED_HUGEPAGE:
>  		case SCAN_PTE_NON_PRESENT:
>  		case SCAN_PTE_UFFD_WP:
>  		case SCAN_LACK_REFERENCED_PAGE:

