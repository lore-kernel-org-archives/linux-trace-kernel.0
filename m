Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7E2F41;
	Fri, 23 May 2025 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747983346; cv=none; b=iOxbbZwVEGwOBY+uS/MgcdEz1TckT0UDx7gbe1VJQFRXsmDzc7gA8hOiPc4k0swVQLQjPldvhJ8FopU4MbkmMLBBKqjN2kj0sw/7vPX7zmFlfkngRnGUc3nGj6FBPi5ky9ekaMOOHKPr9TVuxAAvjEEaduA3UHQREaFBL/Qh6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747983346; c=relaxed/simple;
	bh=pVHutlHjk19bDsR5XHyrVEKz0M1o9YrQaWRutQHH+7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyrExshWC0WrKDVHLh3GeQSqqHR1KE7sBVD74jRW5sz9mi1uA8esTjPsQc5Gkkl/qapETKaf01DYs1tnpW2IKa/WNtNn8+KkDC+UXq2h/P34uZbpCW6zU6827u/XRfXQwWVoqOa5ws2ybQx0i5g5LxVa27g+w6zCvL/0hjXxRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O4AMrPff; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O4AMrPff"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747983339; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kEIfINKZejvJZsMGvS6UgezRdxkkGcgt66QsjivJra8=;
	b=O4AMrPffGEWRuSIQeLSJqdnJxh2sjB1i+nk8zjVX7OVQ5mua7SQUFPudGG8EP3PVWq4FwL78CMEFToTOU7FsuYmMFcIHvneYymAUI+5zQboAOJjN10Gn6+PZFHlNeKn8t43pDTqCi3c4k3ZLwNLhX4yv4lb4lX3f7Z2scRou0UU=
Received: from 30.74.144.180(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbZKq8c_1747983335 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 May 2025 14:55:36 +0800
Message-ID: <469db7d1-ba99-4dc7-af13-b5fe850d4031@linux.alibaba.com>
Date: Fri, 23 May 2025 14:55:34 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/12] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
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
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-4-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250515032226.128900-4-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/15 11:22, Nico Pache wrote:
> For khugepaged to support different mTHP orders, we must generalize this
> to check if the PMD is not shared by another VMA and the order is
> enabled.
> 
> No functional change in this patch.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5457571d505a..0c4d6a02d59c 100644
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
> @@ -934,7 +934,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>   
>   	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))

Sorry, I missed this before. Should we also change 'PMD_ORDER' to 
'order' for the thp_vma_suitable_order()?

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
> @@ -2782,7 +2782,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>   			mmap_read_lock(mm);
>   			mmap_locked = true;
>   			result = hugepage_vma_revalidate(mm, addr, false, &vma,
> -							 cc);
> +							 cc, HPAGE_PMD_ORDER);
>   			if (result  != SCAN_SUCCEED) {
>   				last_fail = result;
>   				goto out_nolock;
