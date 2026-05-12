Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493237DAB3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590166; cv=none; b=NencjvO5A2oboNipg8MLB2svqpgvAPYQkS+ivngau/my0KZ8D15M6FzG3H1lJpBxKPv70Hbx2rCDUufL0/OKsG3YIIXhK8Lfnt41zgz6X+gwZ+D7M84JT6cyvVQ9hUGwiCSZBZD2H0KLztoJj1pzvSlN2rpnSWbDmjEHMvi5h5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590166; c=relaxed/simple;
	bh=SBvm6+jP+U2l7uMXSXFQ1WvZtFjwHb3u2Q8u1wUCpO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjg1tUKflnq0Y4y4EWqWQgcPyQvykzw2yR/KYTcmoibq+8WpBzC9UAbHJkttwJ8b6fWFF1ZwRNrPl2T96zoURQF7ovIyFWCBuatELCxQATlvvS2srCh+TO0FwBjrPVzfxyEH/Q8d0WBxkFrAC+nDo3ZM9sVxdERn9BIeWI4jZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y0UNX/fZ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y0UNX/fZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778590150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk7t5MkLo6XzuMHVqU+2InNqpcc/cRZVM5/ZDanGOMU=;
	b=Y0UNX/fZohdD2/O+ae5TCK7pk3M3M0epqtEBV1l66A576fgZVKcBPMZWjonXh9hxeMayja
	Ff7SKFC1E9eA17pAEV26oVIAVy3HLg+MRUwuSDMY67Ykn6RMPBwvWKgfa3r2iozKrlyl/d
	eCHC5MpBah/awdxD7pDcdmucX/Gy/KU=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: leitao@debian.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	liam@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	lance.yang@linux.dev
Subject: Re: [PATCH v6 1/4] mm/memory-failure: report MF_MSG_KERNEL for reserved pages
Date: Tue, 12 May 2026 20:48:37 +0800
Message-Id: <20260512124837.38883-1-lance.yang@linux.dev>
In-Reply-To: <9504c193-8c01-4d03-8f62-c50fd7fbdbc0@kernel.org>
References: <9504c193-8c01-4d03-8f62-c50fd7fbdbc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, May 12, 2026 at 10:17:00AM +0200, David Hildenbrand (Arm) wrote:
>On 5/11/26 17:38, Breno Leitao wrote:
>> When get_hwpoison_page() returns a negative value, distinguish
>> reserved pages from other failure cases by reporting MF_MSG_KERNEL
>> instead of MF_MSG_GET_HWPOISON. Reserved pages belong to the kernel
>> and should be classified accordingly for proper handling.
>> 
>> Sample PG_reserved before the get_hwpoison_page() call. In the
>> MF_COUNT_INCREASED path get_any_page() can drop the caller's
>> reference before returning -EIO, after which the underlying page may
>> have been freed and reallocated with page->flags reset; reading
>> PageReserved(p) at that point would observe stale or unrelated state.
>> The pre-call snapshot reflects what the page actually was at the
>> time of the failure event.
>> 
>> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  mm/memory-failure.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 866c4428ac7ef..f112fb27a8ff6 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2348,6 +2348,7 @@ int memory_failure(unsigned long pfn, int flags)
>>  	unsigned long page_flags;
>>  	bool retry = true;
>>  	int hugetlb = 0;
>> +	bool is_reserved;
>>  
>>  	if (!sysctl_memory_failure_recovery)
>>  		panic("Memory failure on page %lx", pfn);
>> @@ -2411,6 +2412,18 @@ int memory_failure(unsigned long pfn, int flags)
>>  	 * In fact it's dangerous to directly bump up page count from 0,
>>  	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
>>  	 */
>> +	/*
>> +	 * Pages with PG_reserved set are not currently managed by the
>> +	 * page allocator (memblock-reserved memory, driver reservations,
>> +	 * etc.), so classify them as kernel-owned for reporting.
>> +	 *
>> +	 * Sample the flag before get_hwpoison_page(): in the
>> +	 * MF_COUNT_INCREASED path, get_any_page() can drop the caller's
>> +	 * reference before returning -EIO, after which page->flags may
>> +	 * have been reset by the allocator.
>> +	 */
>> +	is_reserved = PageReserved(p);
>> +
>>  	res = get_hwpoison_page(p, flags);
>>  	if (!res) {
>>  		if (is_free_buddy_page(p)) {
>> @@ -2432,7 +2445,11 @@ int memory_failure(unsigned long pfn, int flags)
>>  		}
>>  		goto unlock_mutex;
>>  	} else if (res < 0) {
>> -		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
>> +		if (is_reserved)
>> +			res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
>> +		else
>> +			res = action_result(pfn, MF_MSG_GET_HWPOISON,
>> +					    MF_IGNORED);
>>  		goto unlock_mutex;
>>  	}
>>  
>> 
>
>It's a bit odd that we need this handling when we already have handling for
>reserved pages in error_states[].
>
>HWPoisonHandlable() would always essentially reject PG_reserved pages. So
>__get_hwpoison_page() ... would always fail? Making
>get_hwpoison_page()->get_any_page() always fail?
>
>But then, we never call identify_page_state()? And never call me_kernel()?

Looks like we never get that far ...

>This all looks very odd.
>
>Why would you even want to call get_hwpoison_page() in the first place if you
>find PageReserved?

Ah, I see :)

For a PG_reserved page, I would not expect PageLRU to be set, nor would
I expect it to be in the buddy allocator.

include/linux/page-flags.h also says:

"
Once (if ever) freed, PG_reserved is cleared and they will be given to
the page allocator.
"

So maybe special-case PageReserved() before get_hwpoison_page()?
Something like:

	if (PageReserved(p)){
		res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
		goto unlock_mutex; 	
	}

	res = get_hwpoison_page(p, flags, &gp_status);

Cheers, Lance
