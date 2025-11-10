Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649451DE8B5;
	Mon, 10 Nov 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782410; cv=none; b=pS1yE05Rt25FgnI9YZGuP3BOq45CmKwO6cngZyzpjfPZ0bc7dqDjMjJruzZ9T3NxDve85rWWJaR4j47BgcelHRXmuzuZ2jXmAWklyYBlzcjE09RsdB9G3zqQd+18QOFeAGbSCvsGOvoAzXRDJaGpuJSEJSIYYRxIQxhWDHpmB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782410; c=relaxed/simple;
	bh=pGInTelnFne7TBdJF+TcCBM++QQIqd7Kw3BwWi6MhkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWdjI1sPTldpXszN3qdIul5Qf24r7+nNuOA6IHptf8Ei+DfrkcX5lU3NRkS4F3ssoM8U9yqE/1SH41RSvR42GDUvV1KIkNc+TribyanJGsoqQklzdeQIKuFuRVIiVhXIfeP3ujl6A4zG6AXiyUlwSk1BNSrbNV42QTS50bD2D14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 171C42F;
	Mon, 10 Nov 2025 05:46:40 -0800 (PST)
Received: from [10.164.136.34] (Mac.blr.arm.com [10.164.136.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E67353F63F;
	Mon, 10 Nov 2025 05:46:42 -0800 (PST)
Message-ID: <4ab54ae0-2607-443d-8698-788d8e951bdd@arm.com>
Date: Mon, 10 Nov 2025 19:16:40 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/khugepaged: return EAGAIN for transient dirty
 pages in MADV_COLLAPSE
To: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251110113254.77822-1-shivankg@amd.com>
 <20251110113254.77822-3-shivankg@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251110113254.77822-3-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/11/25 5:02 pm, Shivank Garg wrote:
> When MADV_COLLAPSE encounters dirty file-backed pages, it currently
> returns -EINVAL, this is misleading as EINVAL suggests invalid arguments,
> whereas dirty pages are a transient condition that may resolve on retry.
>
> Introduce SCAN_PAGE_DIRTY and map it to -EAGAIN. For khugepaged, this
> is harmless as it will revisit the range after async writeback completes.

Taking a cursory look at enum scan_result, I am sure there are other error
codes as well which redirect to -EINVAL when they actually should to something
else...

>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>   include/trace/events/huge_memory.h | 3 ++-
>   mm/khugepaged.c                    | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index dd94d14a2427..9014a9bbe64c 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -38,7 +38,8 @@
>   	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
>   	EM( SCAN_STORE_FAILED,		"store_failed")			\
>   	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
> -	EMe(SCAN_PAGE_FILLED,		"page_filled")
> +	EM(SCAN_PAGE_FILLED,		"page_filled")			\
> +	EMe(SCAN_PAGE_DIRTY,		"page_dirty")
>   
>   #undef EM
>   #undef EMe
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d08ed6eb9ce1..7df329c9c87d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -60,6 +60,7 @@ enum scan_result {
>   	SCAN_STORE_FAILED,
>   	SCAN_COPY_MC,
>   	SCAN_PAGE_FILLED,
> +	SCAN_PAGE_DIRTY,
>   };
>   
>   #define CREATE_TRACE_POINTS
> @@ -1967,7 +1968,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   				 */
>   				xas_unlock_irq(&xas);
>   				filemap_flush(mapping);
> -				result = SCAN_FAIL;
> +				result = SCAN_PAGE_DIRTY;
>   				goto xa_unlocked;
>   			} else if (folio_test_writeback(folio)) {
>   				xas_unlock_irq(&xas);

Now that you are at it, it would make sense to redirect this folio_test_writeback()
branch also to -EAGAIN, and call the common error code SCAN_PAGE_UNDER_WRITEBACK.

> @@ -2747,6 +2748,7 @@ static int madvise_collapse_errno(enum scan_result r)
>   	case SCAN_PAGE_LRU:
>   	case SCAN_DEL_PAGE_LRU:
>   	case SCAN_PAGE_FILLED:
> +	case SCAN_PAGE_DIRTY:
>   		return -EAGAIN;
>   	/*
>   	 * Other: Trying again likely not to succeed / error intrinsic to
