Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B96528C2DD;
	Thu, 20 Nov 2025 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625852; cv=none; b=eejrdyIXzzStG16twM3Dn2LaH10MQS476pPgg9Kx4OVObVyAog85YXki0cVPBV91x//rT92Bbb2+MRD8I/CPc9/1j130aC3NXzrkLpeBkBQhvy0+eceG75cyeOzFf6cYtXl+SBfdUsNFFa5lERCV3lNbMs5DfeH3Sr56dvOEJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625852; c=relaxed/simple;
	bh=sQj137RYX863daG1yGxeBAlV+j8TQLeg1yICfM4nJH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIzGFJGOq9PS5I2hcRuzWX+s9kQvCGiZG5kXjMtbpJx9SsTIu9co9R5ZYeoQf5FKZgIT7RXOoqW5FDLaZmEp339VPO/YLCkLjLz851xe3O2pJgcMEK5no2VEW7xvJUNtBAbt3EQPR7XfRvqvWJhZ+lOe0IXQEsiI0z1OY/Z10Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E68A2B;
	Thu, 20 Nov 2025 00:03:59 -0800 (PST)
Received: from [10.164.18.59] (MacBook-Pro.blr.arm.com [10.164.18.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AD1C3F740;
	Thu, 20 Nov 2025 00:04:01 -0800 (PST)
Message-ID: <6c1d6b80-d290-4110-9a49-53e7404136bc@arm.com>
Date: Thu, 20 Nov 2025 13:33:58 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] mm/khugepaged: map dirty/writeback pages failures
 to EAGAIN
To: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251120065043.41738-6-shivankg@amd.com>
 <20251120065043.41738-10-shivankg@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251120065043.41738-10-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/11/25 12:20 pm, Shivank Garg wrote:
> When collapse_file encounters dirty or writeback pages in file-backed
> mappings, it currently SCAN_FAIL which maps to -EINVAL. This is
> misleading as EINVAL suggests invalid arguments, whereas dirty/writeback
> pages represent transient conditions that may resolve on retry.
>
> Introduce SCAN_PAGE_NOT_CLEAN to cover both dirty and writeback states,
> mapping it to -EAGAIN. For MADV_COLLAPSE, this provides userspace with
> a clear signal that retry may succeed after writeback completes, making
> -EAGAIN semantically correct. For khugepaged, this is harmless as it
> will naturally revisit the range during periodic scans after async
> writeback completes.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>   include/trace/events/huge_memory.h | 3 ++-
>   mm/khugepaged.c                    | 8 +++++---
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 4cde53b45a85..1caf24b951e1 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -37,7 +37,8 @@
>   	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
>   	EM( SCAN_STORE_FAILED,		"store_failed")			\
>   	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
> -	EMe(SCAN_PAGE_FILLED,		"page_filled")
> +	EM( SCAN_PAGE_FILLED,		"page_filled")			\
> +	EMe(SCAN_PAGE_NOT_CLEAN,	"page_not_clean")
>   
>   #undef EM
>   #undef EMe
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 066a332c76ad..282b413d17e8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -59,6 +59,7 @@ enum scan_result {
>   	SCAN_STORE_FAILED,
>   	SCAN_COPY_MC,
>   	SCAN_PAGE_FILLED,
> +	SCAN_PAGE_NOT_CLEAN,
>   };
>   
>   #define CREATE_TRACE_POINTS
> @@ -1968,11 +1969,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   				 */
>   				xas_unlock_irq(&xas);
>   				filemap_flush(mapping);
> -				result = SCAN_FAIL;
> +				result = SCAN_PAGE_NOT_CLEAN;
>   				goto xa_unlocked;
>   			} else if (folio_test_writeback(folio)) {
>   				xas_unlock_irq(&xas);
> -				result = SCAN_FAIL;
> +				result = SCAN_PAGE_NOT_CLEAN;
>   				goto xa_unlocked;
>   			} else if (folio_trylock(folio)) {
>   				folio_get(folio);
> @@ -2019,7 +2020,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   			 * folio is dirty because it hasn't been flushed
>   			 * since first write.
>   			 */
> -			result = SCAN_FAIL;
> +			result = SCAN_PAGE_NOT_CLEAN;
>   			goto out_unlock;
>   		}
>   
> @@ -2748,6 +2749,7 @@ static int madvise_collapse_errno(enum scan_result r)
>   	case SCAN_PAGE_LRU:
>   	case SCAN_DEL_PAGE_LRU:
>   	case SCAN_PAGE_FILLED:
> +	case SCAN_PAGE_NOT_CLEAN:
>   		return -EAGAIN;
>   	/*
>   	 * Other: Trying again likely not to succeed / error intrinsic to

SCAN_PAGE_NOT_CLEAN is confusing - NOT_CLEAN literally means dirty, so why not SCAN_PAGE_DIRTY?
Or SCAN_PAGE_DIRTY_OR_UNDER_WRITEBACK? Since folio_test_writeback() is true as a result of
the folio being dirty, maybe just SCAN_PAGE_DIRTY can do.

Reviewed-by: Dev Jain <dev.jain@arm.com>

