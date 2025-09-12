Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00727EFE3;
	Fri, 12 Sep 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669101; cv=none; b=pn7SlpOXJ+T5MHoCPSjTttvD4Cj3uaUPCNrG8Qcf4hTbdfn1//Yx74YCfQlfjzkCmjOPf1iexa+KhlFARhQKtx3mDCVwni8XV0isdU4pE4cw78mtSjHir+odK9yqtxVbImwdozCl820eS3BWuBzQoEyVug6YSdycsXY1L8LZK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669101; c=relaxed/simple;
	bh=GmEAPbFMXpczpVM7DQb8d28PRbScKAo5q6THwLy4XlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2AqHL2w2cUPLiLLEt9f46h7dxrdBaGwfGIRQHiNiBbYZII5OvfAx/VChP7qdLYm9PG8LiJ3bgHkvXDezc2SrDWhvYo9wbZuoN/YVw2dfL87kXVLEpPyGnZCOKtKZvQv8I5BndGdFqFEFSdGlEaJcjOg6y3ooJ0th/AWbdnLeqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FC5rw6ix; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FC5rw6ix"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757669095; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yeQuxM0fjpmIe4g0xUTHddlrE41HXqCqb25Ih/uw2qU=;
	b=FC5rw6ixR5LazE+N3z4/dTcrJQMWug331XVyZltsj007wwaIMcbYk1MIz7HngLF0s48iJ7+quRnMaADJDkw5FAgDSKcC/7EV7t1PcFZAU7rVMv77wrKs5veqVYDtymV6+emOeD/vU/Fp/dzr9mc5ojNrdmEOPVrDVkd25W2SiMw=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnqpgPM_1757669090 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 17:24:52 +0800
Message-ID: <50305e9f-ad03-4ce9-9ae7-0c657bd87ef0@linux.alibaba.com>
Date: Fri, 12 Sep 2025 17:24:50 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/15] khugepaged: introduce collapse_allowable_orders
 helper function
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20250912032810.197475-1-npache@redhat.com>
 <20250912032810.197475-12-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250912032810.197475-12-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/12 11:28, Nico Pache wrote:
> Add collapse_allowable_orders() to generalize THP order eligibility. The
> function determines which THP orders are permitted based on collapse
> context (khugepaged vs madv_collapse).
> 
> This consolidates collapse configuration logic and provides a clean
> interface for future mTHP collapse support where the orders may be
> different.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/khugepaged.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5b45ef575446..d224fa97281a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -485,7 +485,16 @@ static int collapse_max_ptes_none(unsigned int order)
>   	else
>   		max_ptes_none = khugepaged_max_ptes_none;
>   	return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> +}
> +
> +/* Check what orders are allowed based on the vma and collapse type */
> +static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
> +			vm_flags_t vm_flags, bool is_khugepaged)
> +{
> +	enum tva_type tva_flags = is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
> +	unsigned long orders = BIT(HPAGE_PMD_ORDER);
>   
> +	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>   }
>   
>   void khugepaged_enter_vma(struct vm_area_struct *vma,
> @@ -493,7 +502,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>   {
>   	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>   	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> +		if (collapse_allowable_orders(vma, vm_flags, true))
>   			__khugepaged_enter(vma->vm_mm);
>   	}
>   }
> @@ -2557,7 +2566,7 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
>   			progress++;
>   			break;
>   		}
> -		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
> +		if (!collapse_allowable_orders(vma, vma->vm_flags, true)) {
>   skip:
>   			progress++;
>   			continue;
> @@ -2865,7 +2874,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   	BUG_ON(vma->vm_start > start);
>   	BUG_ON(vma->vm_end < end);
>   
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
> +	if (!collapse_allowable_orders(vma, vma->vm_flags, false))
>   		return -EINVAL;
>   
>   	cc = kmalloc(sizeof(*cc), GFP_KERNEL);

