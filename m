Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118101AB530;
	Thu, 24 Apr 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481118; cv=none; b=OxmCNZJm0eHP9eYXDtyrAkFhA+evtoH6S7Hq7D3ezqi2cbrvetovupD0bacHw7/uot2c7BDf90Khi3k3yY4oJjpH0b8jb5MB8JE+C00nZURyBZ8137KNwD1rt/nGOk1MzPnHkFUmsvo1cFqG+ZBPO5f/dyUImpCoCXtCy4Ggg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481118; c=relaxed/simple;
	bh=4AZFZSmc3tQJqAQh2QZKQ7f5PRHrwE+6Rtqt+watsHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V81qqbOm5KuWn+tYHBxjaNxh0LiheBIlyqnea3cHuTWcsHQIiyXpEidnO0g7o7E6toTfWcqPWgRSNaVF585kw/3BRX9o7au1zVxGIpLMVrTME/ZaAbQHmBT0HMLx+FC/oMNAY/HWqQa9j1BeUzHIsD5fPyspr3rBkd1KGiRLd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KSXnKJVh; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KSXnKJVh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745481112; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=66EBE6//T4b858PvX3WkhRuMXFKHkqm2EIhR70lCzm0=;
	b=KSXnKJVhdwjcVdeKBS6o76b2k45HK1cM5ZObJKC/Gu6b6x5nzGGTaZv2o2g10CYKlKflxv9PoZncbVhtRMzS6tjPDfJOoLwbYDLPxvLX+5tMY+TCu8Lahj7TwzwEE1ninOjIVHmcPYDwsvmgAa2iGfrzbRB5/Av1o0H/TEtI0mY=
Received: from 30.74.146.225(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXyHI1o_1745481108 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 15:51:49 +0800
Message-ID: <5187c3fb-bf2a-41a0-902d-2661f1b3a2c9@linux.alibaba.com>
Date: Thu, 24 Apr 2025 15:51:48 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] khugepaged: improve tracepoints for mTHP orders
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
 <20250417000238.74567-11-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-11-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
> Add the order to the tracepoints to give better insight into what order
> is being operated at for khugepaged.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/trace/events/huge_memory.h | 34 +++++++++++++++++++-----------
>   mm/khugepaged.c                    | 10 +++++----
>   2 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 9d5c00b0285c..ea2fe20a39f5 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -92,34 +92,37 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
>   
>   TRACE_EVENT(mm_collapse_huge_page,
>   
> -	TP_PROTO(struct mm_struct *mm, int isolated, int status),
> +	TP_PROTO(struct mm_struct *mm, int isolated, int status, int order),
>   
> -	TP_ARGS(mm, isolated, status),
> +	TP_ARGS(mm, isolated, status, order),
>   
>   	TP_STRUCT__entry(
>   		__field(struct mm_struct *, mm)
>   		__field(int, isolated)
>   		__field(int, status)
> +		__field(int, order)
>   	),
>   
>   	TP_fast_assign(
>   		__entry->mm = mm;
>   		__entry->isolated = isolated;
>   		__entry->status = status;
> +		__entry->order = order;
>   	),
>   
> -	TP_printk("mm=%p, isolated=%d, status=%s",
> +	TP_printk("mm=%p, isolated=%d, status=%s order=%d",
>   		__entry->mm,
>   		__entry->isolated,
> -		__print_symbolic(__entry->status, SCAN_STATUS))
> +		__print_symbolic(__entry->status, SCAN_STATUS),
> +		__entry->order)
>   );
>   
>   TRACE_EVENT(mm_collapse_huge_page_isolate,
>   
>   	TP_PROTO(struct page *page, int none_or_zero,
> -		 int referenced, bool  writable, int status),
> +		 int referenced, bool  writable, int status, int order),
>   
> -	TP_ARGS(page, none_or_zero, referenced, writable, status),
> +	TP_ARGS(page, none_or_zero, referenced, writable, status, order),
>   
>   	TP_STRUCT__entry(
>   		__field(unsigned long, pfn)
> @@ -127,6 +130,7 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
>   		__field(int, referenced)
>   		__field(bool, writable)
>   		__field(int, status)
> +		__field(int, order)
>   	),
>   
>   	TP_fast_assign(
> @@ -135,27 +139,31 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
>   		__entry->referenced = referenced;
>   		__entry->writable = writable;
>   		__entry->status = status;
> +		__entry->order = order;
>   	),
>   
> -	TP_printk("scan_pfn=0x%lx, none_or_zero=%d, referenced=%d, writable=%d, status=%s",
> +	TP_printk("scan_pfn=0x%lx, none_or_zero=%d, referenced=%d, writable=%d, status=%s order=%d",
>   		__entry->pfn,
>   		__entry->none_or_zero,
>   		__entry->referenced,
>   		__entry->writable,
> -		__print_symbolic(__entry->status, SCAN_STATUS))
> +		__print_symbolic(__entry->status, SCAN_STATUS),
> +		__entry->order)
>   );
>   
>   TRACE_EVENT(mm_collapse_huge_page_swapin,
>   
> -	TP_PROTO(struct mm_struct *mm, int swapped_in, int referenced, int ret),
> +	TP_PROTO(struct mm_struct *mm, int swapped_in, int referenced, int ret,
> +			int order),
>   
> -	TP_ARGS(mm, swapped_in, referenced, ret),
> +	TP_ARGS(mm, swapped_in, referenced, ret, order),
>   
>   	TP_STRUCT__entry(
>   		__field(struct mm_struct *, mm)
>   		__field(int, swapped_in)
>   		__field(int, referenced)
>   		__field(int, ret)
> +		__field(int, order)
>   	),
>   
>   	TP_fast_assign(
> @@ -163,13 +171,15 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
>   		__entry->swapped_in = swapped_in;
>   		__entry->referenced = referenced;
>   		__entry->ret = ret;
> +		__entry->order = order;
>   	),
>   
> -	TP_printk("mm=%p, swapped_in=%d, referenced=%d, ret=%d",
> +	TP_printk("mm=%p, swapped_in=%d, referenced=%d, ret=%d, order=%d",
>   		__entry->mm,
>   		__entry->swapped_in,
>   		__entry->referenced,
> -		__entry->ret)
> +		__entry->ret,
> +		__entry->order)
>   );
>   
>   TRACE_EVENT(mm_khugepaged_scan_file,
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 738dd9c5751d..67da0950b833 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -721,13 +721,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   	} else {
>   		result = SCAN_SUCCEED;
>   		trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
> -						    referenced, writable, result);
> +						    referenced, writable, result,
> +						    order);
>   		return result;
>   	}
>   out:
>   	release_pte_pages(pte, _pte, compound_pagelist);
>   	trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
> -					    referenced, writable, result);
> +					    referenced, writable, result, order);
>   	return result;
>   }
>   
> @@ -1097,7 +1098,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   
>   	result = SCAN_SUCCEED;
>   out:
> -	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result);
> +	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result,
> +						order);
>   	return result;
>   }
>   
> @@ -1318,7 +1320,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	*mmap_locked = false;
>   	if (folio)
>   		folio_put(folio);
> -	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
> +	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result, order);
>   	return result;
>   }
>   
