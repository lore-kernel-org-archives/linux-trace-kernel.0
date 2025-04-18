Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70C8C0E;
	Fri, 18 Apr 2025 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938553; cv=none; b=cOzJUEx4e1gXqJj6BGqWjS8U3qEoaPXERRGDjeK8kfjIL9wBu8qzA0iPtHxojSMYE+65MoHHCaqMfu9aAeVqrOdX6WNqux8cn6pvP2+C/WiG+rMdHJBIcj9hEtTweLi9kAGH1d8TZFd3KU9cRtxPB+Me4wnSkdI59R8hTonubbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938553; c=relaxed/simple;
	bh=q/sNUi3Id7+KfkudHCphuMBEouo8BCvkRk8JqMjb+n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALUEpguWDZkFwYQyRAPENZ923VAUr3SKaviOgd/wTTQq1onoreND6A9Y88Bciwr8OZ+hAteGaMy2RY7MZjpeFpYlqtBdUn9vPwnjA3YyKE48+MEht6z4eAjYug1qTeVKw35DDmpRahSyybaJy/KqYZbaE7BpQi9sv3aR4vZggmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=saJkvimI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="saJkvimI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744938541; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/zpmOaOeab+ITuItqENzqv6ySxnros0qeyQCTC95Sbo=;
	b=saJkvimIjpgm396tUgpV8cRflR1RuMGHbro6q9SYITLWSq9edAS4ZaWivQsv4xFgTyIGE596Xu2AbsxXeOJitTPy3g7tDpCtGEODWnq7ixQcgmhc7Qxe2gMJab0CX327bDcgFwqIEC0fJci8An5j5MOVPL392x542P+X7Elp3Vo=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXH6Ihr_1744938538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Apr 2025 09:08:59 +0800
Message-ID: <2b8d048a-7089-41b4-b256-e061af10216d@linux.alibaba.com>
Date: Fri, 18 Apr 2025 09:08:58 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] khugepaged: Refactor
 trace_mm_collapse_huge_page_isolate() to take folio instead of page
To: nifan.cxl@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org,
 willy@infradead.org
Cc: akpm@linux-foundation.org, david@redhat.com, fan.ni@samsung.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, npache@redhat.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, dave@stgolabs.net
References: <20250417171758.142745-1-nifan.cxl@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417171758.142745-1-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/18 01:17, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> trace_mm_collapse_huge_page_isolate() is only used in
> __collapse_huge_page_isolate(), which passes in the head page of a
> folio, so refactor it to take folio directly.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/trace/events/huge_memory.h | 6 +++---
>   mm/khugepaged.c                    | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 9d5c00b0285c..a73699f000de 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -116,10 +116,10 @@ TRACE_EVENT(mm_collapse_huge_page,
>   
>   TRACE_EVENT(mm_collapse_huge_page_isolate,
>   
> -	TP_PROTO(struct page *page, int none_or_zero,
> +	TP_PROTO(struct folio *folio, int none_or_zero,
>   		 int referenced, bool  writable, int status),
>   
> -	TP_ARGS(page, none_or_zero, referenced, writable, status),
> +	TP_ARGS(folio, none_or_zero, referenced, writable, status),
>   
>   	TP_STRUCT__entry(
>   		__field(unsigned long, pfn)
> @@ -130,7 +130,7 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
>   	),
>   
>   	TP_fast_assign(
> -		__entry->pfn = page ? page_to_pfn(page) : -1;
> +		__entry->pfn = folio ? folio_pfn(folio) : -1;
>   		__entry->none_or_zero = none_or_zero;
>   		__entry->referenced = referenced;
>   		__entry->writable = writable;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b8838ba8207a..950d147cd95e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -696,13 +696,13 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		result = SCAN_LACK_REFERENCED_PAGE;
>   	} else {
>   		result = SCAN_SUCCEED;
> -		trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
> +		trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
>   						    referenced, writable, result);
>   		return result;
>   	}
>   out:
>   	release_pte_pages(pte, _pte, compound_pagelist);
> -	trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
> +	trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
>   					    referenced, writable, result);
>   	return result;
>   }
