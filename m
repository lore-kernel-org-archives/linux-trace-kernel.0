Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3492571A6;
	Mon, 21 Apr 2025 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745205037; cv=none; b=P+6NGLj1gUkg3uSiuONZfc01QU9mIcjq2RQPOdsfpNcBxs8acSmfv6inZGPbwUkKChxbT4uszS1ak5nzcjW7RBUYswSSU3IGXczUI+Nvm0X9OfLI47JdE6RWdOwdSMUd+lso9PDl5baaIBJlfjPziFnqIb58eMQCRP8ifUTJOcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745205037; c=relaxed/simple;
	bh=iprY2zXnlUwG2yTN+Eg/CLNl/6+OwHB6ofTHwi6qcJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9UUGnsERMoUqoI0aPkAM60vyg49BTI1CFw1qkTK66AT5MICxNSxbrcIUj9qrdlPy7JpSpkEU3OL6F19hHk7HHyeOlC3q2Ay1SbKlK6S9p3v0xok60xCBxh0YhvnvcMj8PC+AgSCPmbgL2AV2q6KWixx8ZGkk36kQ2NyztPOYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=riJseXti; arc=none smtp.client-ip=47.90.199.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="riJseXti"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745205015; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=70UhExgNaocK5X30hvKk4vB85NegZCk9Mwiwz/Y2+cw=;
	b=riJseXtiijWJwAuybiZB12za1gZyDZCIB0wdj/z6MJF9iNyJR6Cqy8zUzA2vdLsW6WZvQ8PxyN+YjwWqH/KbPEcziodNgPhvOr9E/eILYe3iufBS5cFmwHwPGJX0o1m5VAI/zGor7kWeCXLF5GWF7W7soPqJKW/whaoz7LH+gPg=
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXRJzgE_1745204077 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Apr 2025 10:54:38 +0800
Message-ID: <65a0ffcd-d650-4dcd-8366-833f4a0ee7b6@linux.alibaba.com>
Date: Mon, 21 Apr 2025 10:54:37 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] khugepaged: Refactor
 trace_mm_khugepaged_scan_pmd() to take folio instead of page
To: nifan.cxl@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org,
 willy@infradead.org
Cc: akpm@linux-foundation.org, david@redhat.com, fan.ni@samsung.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, npache@redhat.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, dave@stgolabs.net
References: <20250418183920.273154-1-nifan.cxl@gmail.com>
 <20250418183920.273154-2-nifan.cxl@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250418183920.273154-2-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/19 02:34, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> trace_mm_khugepaged_scan_pmd() is only called in
> hpage_collapse_scan_pmd(), where the head page of a folio is passed in,
> so refactor it to take folio directly.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> This is a new patch added to the series.
> ---
>   include/trace/events/huge_memory.h | 6 +++---
>   mm/khugepaged.c                    | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index a73699f000de..2305df6cb485 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -55,10 +55,10 @@ SCAN_STATUS
>   
>   TRACE_EVENT(mm_khugepaged_scan_pmd,
>   
> -	TP_PROTO(struct mm_struct *mm, struct page *page, bool writable,
> +	TP_PROTO(struct mm_struct *mm, struct folio *folio, bool writable,
>   		 int referenced, int none_or_zero, int status, int unmapped),
>   
> -	TP_ARGS(mm, page, writable, referenced, none_or_zero, status, unmapped),
> +	TP_ARGS(mm, folio, writable, referenced, none_or_zero, status, unmapped),
>   
>   	TP_STRUCT__entry(
>   		__field(struct mm_struct *, mm)
> @@ -72,7 +72,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
>   
>   	TP_fast_assign(
>   		__entry->mm = mm;
> -		__entry->pfn = page ? page_to_pfn(page) : -1;
> +		__entry->pfn = folio ? folio_pfn(folio) : -1;
>   		__entry->writable = writable;
>   		__entry->referenced = referenced;
>   		__entry->none_or_zero = none_or_zero;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 950d147cd95e..bf5583dca1cb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1435,7 +1435,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   		*mmap_locked = false;
>   	}
>   out:
> -	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
> +	trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
>   				     none_or_zero, result, unmapped);
>   	return result;
>   }
