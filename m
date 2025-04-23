Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF82676D1;
	Wed, 23 Apr 2025 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391362; cv=none; b=ByNkPAuSByu3y2BGS7zccs2H7/ECMOu/p1xEio5SACv14x2xRZPimhT3rRIhNVtfCSUM5f4UvOnkoxe95RI30Dps615SKI9UQ6WuIVea0SIXM6F6A6wOZY/Op7hbCZzRYwqF06CH1kNSPOsI/RN0oni2slXXdtMIoaJMhSCYgzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391362; c=relaxed/simple;
	bh=3i7r/58CtDZFupNSmZUcH6QLoYJHCa1IatB2xCxRyRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ow+jMrIk95gBzwQ6RJnUIBLvQNTxF4DIAPUcQpL167eZELDY/2kQRQ1gGyfhR4O8OLBfMZxS/js2FlumQzFyG7HoodEbKoGeNLakA16KW00WqsdjSYMAS+yjpQs3a6wtmK/JNRTJTjpmJMVlM7VoYdk0MpAW8sbfLdQVveDVOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EEK6Wc0j; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EEK6Wc0j"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745391356; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H1skONK6cs8UBil9X8sWmmdRUJr3xZeKqf2Y3Px4r6c=;
	b=EEK6Wc0jZrd0zYtCVb8w0ejHkm0uon0l9OSofXYYotzP3g3d2i2pqlGvHy6/a4k0BziLSYE6FqssVrzOwdXEJzlc+ij6EI4/cw5ZUBgnnHMm2eysBpis2dKypJqfh76VLi721aPnThVA5ACvJooMobHqaUaSF/J8e+mQovTslE8=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXtS1Fp_1745391352 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Apr 2025 14:55:53 +0800
Message-ID: <821dc0ef-faf9-460e-8396-2c0fdf3f6e94@linux.alibaba.com>
Date: Wed, 23 Apr 2025 14:55:52 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
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
 <20250417000238.74567-4-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-4-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
> For khugepaged to support different mTHP orders, we must generalize this
> function for arbitrary orders.
> 
> No functional change in this patch.
> 
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/khugepaged.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b6281c04f1e5..54d7f43da69c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -920,7 +920,7 @@ static int khugepaged_find_target_node(struct collapse_control *cc)
>   static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>   				   bool expect_anon,
>   				   struct vm_area_struct **vmap,
> -				   struct collapse_control *cc)
> +				   struct collapse_control *cc, int order)
>   {
>   	struct vm_area_struct *vma;
>   	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
> @@ -932,9 +932,9 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>   	if (!vma)
>   		return SCAN_VMA_NULL;
>   
> -	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
> +	if (!thp_vma_suitable_order(vma, address, order))
>   		return SCAN_ADDRESS_RANGE;
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, order))
>   		return SCAN_VMA_CHECK;
>   	/*
>   	 * Anon VMA expected, the address may be unmapped then
> @@ -1130,7 +1130,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   		goto out_nolock;
>   
>   	mmap_read_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED) {
>   		mmap_read_unlock(mm);
>   		goto out_nolock;
> @@ -1164,7 +1164,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 * mmap_lock.
>   	 */
>   	mmap_write_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
>   		goto out_up_write;
>   	/* check if the pmd is still valid */
> @@ -2790,7 +2790,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>   			mmap_read_lock(mm);
>   			mmap_locked = true;
>   			result = hugepage_vma_revalidate(mm, addr, false, &vma,
> -							 cc);
> +							 cc, HPAGE_PMD_ORDER);
>   			if (result  != SCAN_SUCCEED) {
>   				last_fail = result;
>   				goto out_nolock;
