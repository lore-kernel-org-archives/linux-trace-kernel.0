Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08221DF756;
	Fri,  4 Jul 2025 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609489; cv=none; b=uZrAbu0xk78TByVDU1Hy1ZG8kp2B7yaNE1nvIEMvs1aKqi/udH1OVi39Q9VqeVYrn1wUYed24ZFVVQepJZ71y4FOgzZLha5s1lgo/nqDaGSAGWY0sIhFc6vRWzujk1KUvFGEHiwBww2duXIUJb9XGmASKK5Ltj771mrUpnQW3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609489; c=relaxed/simple;
	bh=37vTWydzOOilvawZgVTJ3C/b1jmtIPZSmCWufUailro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYSaK8L+sBoWAIQ2XztBspsg3mXcAFQ2bbQ2aWZ5bSbi7b3v0k1slsFelb5ku+uQQhfdJ8TB5/80nhWDUptcJoSFbQkRHk7Hh4SDDl5XfjfeUESm9+E9ppbhOXxhCPltSTmkL68ZSYSwQPnOgN2Poz78VKBYIDymD8IIul9H8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=II4QTLzW; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="II4QTLzW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751609477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eFIDEdjGbaabW/o+SYfX0GCyecdOoVdNRLtkOOBMNxs=;
	b=II4QTLzWXyj5KCCyShJ/sgxfqhOSRga3Hq56ApISu8VmRevDuXEcWY040jjQqe9Olay3Ux6HgsAs01l1RUc1dmH7Uzy2X87NIwQ1T1TiWFo6mesjlDh+CGtOh1cCywcATSxdpsmr1QYPv6ZcLRTrb9+YnzwbltLiM2TAjUI5PW4=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WhCHD62_1751609473 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 14:11:14 +0800
Message-ID: <2f6d9541-8083-4d3c-a9c1-cba0d5bf98a0@linux.alibaba.com>
Date: Fri, 4 Jul 2025 14:11:13 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/15] khugepaged: allow madvise_collapse to check all
 anonymous mTHP orders
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
References: <20250702055742.102808-1-npache@redhat.com>
 <20250702055742.102808-12-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250702055742.102808-12-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/2 13:57, Nico Pache wrote:
> Allow madvise_collapse to scan/collapse all mTHP orders without the
> strict requirement of needing the PMD-order enabled.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

I am afraid we should drop this patch from the series, since Hugh 
explicitly opposed my modification of the madvise_collapse control logic 
in this thread[1].

Moreover, since we have not yet clarified how to handle the conflict 
between the semantics of madvise_collapse and the THP interfaces, we 
should keep the current logic[2] (means madvise_collapse still only 
allows PMD collapse).

If madvise_collapse is to support mTHP collapse, there will be more 
semantic conflicts to discuss.

[1] 
https://lore.kernel.org/all/cover.1750815384.git.baolin.wang@linux.alibaba.com/
[2] 
https://lore.kernel.org/all/23b8ad10-cd1f-45df-a25c-78d01c8af44f@redhat.com/

> ---
>   mm/khugepaged.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b96a7327b9c0..6ea681b81647 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2930,11 +2930,13 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   	unsigned long hstart, hend, addr;
>   	int thps = 0, last_fail = SCAN_FAIL;
>   	bool mmap_locked = true;
> +	unsigned long orders = vma_is_anonymous(vma) ?
> +					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
>   
>   	BUG_ON(vma->vm_start > start);
>   	BUG_ON(vma->vm_end < end);
>   
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
> +	if (!thp_vma_allowable_orders(vma, vma->vm_flags, 0, orders))
>   		return -EINVAL;
>   
>   	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> @@ -2956,7 +2958,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   			mmap_read_lock(mm);
>   			mmap_locked = true;
>   			result = hugepage_vma_revalidate(mm, addr, false, &vma,
> -							 cc, BIT(HPAGE_PMD_ORDER));
> +							 cc, orders);
>   			if (result  != SCAN_SUCCEED) {
>   				last_fail = result;
>   				goto out_nolock;

