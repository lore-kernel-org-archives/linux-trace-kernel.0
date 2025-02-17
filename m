Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000D228C97;
	Mon, 17 Feb 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812305; cv=none; b=QITsTe+uZ20JPZo0Shv/EuNydKjs3DE+yI9xkH1dyg00fjm4dowfYNAxKiIUKScunJhJeRqUD53EzTCXm5OPVLzLZ/CozdxqlKjHyHmdfAqwEKFTbDhEtYn1D2EmwdCmZ4atRbu5O99esfIPcKRTmB+VCvs2v1+rrhVQq/6cA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812305; c=relaxed/simple;
	bh=4tNSrJklWGYCu2yT2wSB4UOdbK0ppiFhM7Wt4+N+aXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnFvWtgy0MMbSifKs3SenHVQg0GvCywyHOWLrBmqPz2QNk2mT4H6g/GpuEbqW21Yxdd4Mnl1UiY32/psSVEQCLz/kI9Euc0+kzSft+KIxUYMOPymYGiR8VKLdbo2kKKvqtWDEXa5e/lGr5YgIQubiUAB1uuhj/v/bRZtEPRyo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhdNYNPV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhdNYNPV"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso6508339a12.2;
        Mon, 17 Feb 2025 09:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739812302; x=1740417102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mudxCB9OkqUojTHkhRKv6yUJ5eIj9UqRE+5jcMB05/o=;
        b=DhdNYNPVQoDvT+7b4sUvHZWoYicPBqWbnQ1jDSC911MmT282R6hLT9klEpHt52vWWH
         LyRl8VTTH6XGEtCthW1uqIMaeCbzkQCQb066BwFTlZtsSHsDkU3VbBoZGAlydhjEN8YF
         6FsF04QVvFsmZoEpbAWnKbovAk05GBCuxJcW6FD/TFYcS0TMACmN4AemWimX/uR63aVm
         WVY6cfXz9KKxQW4L1UN2yCQxLThaOYIBYsYisAUsDXgCunf0wjdBtdM63RSJJVFFJfOJ
         Un07wpLsW3fGReiLPJxSoVcwnzUqT4CG5H/fQ4NBuxjU1ZOn3w7xv4F0uK4WdAvAQhp0
         VjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739812302; x=1740417102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mudxCB9OkqUojTHkhRKv6yUJ5eIj9UqRE+5jcMB05/o=;
        b=Qxc8QtL/jN5Fb2O44kcSxho1lryJR0Aiv13R6rcYRFVdgd3AoXEZVxAEHZ171H5gRI
         0jA8PsufIEm/3BWXX9RCg4gXDGxkGgRe+lM1NEKPiXIP4+ktOSlRl/NXAQAP/RLi+7iG
         fK1m2dEw8fVTDm7V57vx5zPWXTxxh2Gxtg8fla1qRmCQJXo9z7ZBygVh5Yo/3RH+dLGl
         PS6n3uy7XjJrpN6mTjHNJz2B9COMHYsJRpRr8c5emV55OfQH8UDhsHld65zFqm09iB0+
         kH/wyDFsRsw6VG5xOsd+h6AQjUQY+iGnmQTfP89AE0fERqHW0jw58X5+UXeQ0Lta75n/
         ZkAw==
X-Forwarded-Encrypted: i=1; AJvYcCVaOumHx8H+pnVexWZzVg6aWYaexU/OFAfPBoKoGHd0zgSFRexvNRDq9rfJJ2CsHfsuNqRho5brh8JdVkw=@vger.kernel.org, AJvYcCVyu0ftqqqb85Jr7cmRkUV9IJXlHXfgtc5RYyzMsD/Mc9UUoz/onWCB7UBrUTFt38mtWyYR91hUeq8qHxMu7MxGFXZh@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBw/hkDY8Ou7KS5Q315L8o4wnJtY3R2vJIIpW29CNBwYvXhbZ
	oBh6U3JlvRUi3A4YMcgVOkEW+iyCdOoO9ZXmwNbjNobBwLmgTeBJ
X-Gm-Gg: ASbGnctNLeWOLBc3349PpdeNQKbGibPjRkUBVsxtsbfap00Fn3jQg2XsbNpAH44l9tR
	OkxZQu23Smgav863F/LpFZhiMESDu1lCPGnydYANBVmBADiolxlI56hzmYd3VvBzxmsisinLFgx
	5mmFYrd3llM0JHHzjACcQ46+LYrKu/SiBNanxEhe1CUWxdXEuc0++r/wpUz16Xbv8d3vSej+K2O
	p1W9h+atOOmnY9XGdBSvektWPpJK6UCstB8YMgs9BDqC6dYKBfq7xVmveqK4Jh0b4qRpFl05rUx
	qzLeCOHT8Wy/033/7H7spWn/5LZOXBySCSMewDR4AxVhBO75mMaLQhgk7vbmJByXXmY=
X-Google-Smtp-Source: AGHT+IG56R3Y0YnI3sLutCCORGsErropaX6pN9CjJrQef9MugZOcOnNlfZMNK6HfQo4sIp0o4L/+qQ==
X-Received: by 2002:a05:6402:3547:b0:5dc:cf9b:b04a with SMTP id 4fb4d7f45d1cf-5e035ff9d49mr22676972a12.1.1739812301687;
        Mon, 17 Feb 2025 09:11:41 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:fb:39c9:9a24:d181? ([2620:10d:c092:500::7:6466])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376abbsm922559166b.93.2025.02.17.09.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 09:11:41 -0800 (PST)
Message-ID: <79c80db7-5786-4bb5-9d5d-fa76882116e8@gmail.com>
Date: Mon, 17 Feb 2025 17:11:39 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/9] introduce khugepaged_collapse_single_pmd to unify
 khugepaged and madvise_collapse
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-2-npache@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
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
> +{
> +	int result = SCAN_FAIL;
> +	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
> +
> +	if (!*mmap_locked) {
> +		mmap_read_lock(mm);
> +		*mmap_locked = true;
> +	}
> +
> +	if (thp_vma_allowable_order(vma, vma->vm_flags,
> +					tva_flags, PMD_ORDER)) {
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
> +				mmap_read_unlock(mm);
> +			}
> +		} else {
> +			result = hpage_collapse_scan_pmd(mm, vma, addr,
> +							 mmap_locked, cc);
> +		}
> +		if (result == SCAN_SUCCEED || result == SCAN_PMD_MAPPED)
> +			++khugepaged_pages_collapsed;
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

you will be incrementing khugepaged_pages_collapsed at madvise_collapse by calling
khugepaged_collapse_single_pmd which is not correct.

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

