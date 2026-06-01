Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFE1B142D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278923; cv=none; b=X50mA7f35YPceEyu2P+eaptYVasP7nmJhv5ZuI6U63/Kq+kn3cARPPQ6mrpkMmzalLeWFkEf7E1j/Kvo6mExShHQwOb2aKwIapcDkifOSKWViFDyw5v+DhY8humS+6SonIEr7ZPtBK63EFgUKL4w3fSA/ckvb+nNm7W03TZR9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278923; c=relaxed/simple;
	bh=j4uRY4vfme7Hj8zI1X26nZmyC//UW5FolYkUWvVXqhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3ZGYKH5bj0i6Rsu5uv53AEjxkx0YSYCSyYvkjRRP99SjcihSJu1qDVz8keTE3cF3UB3+7/f9XMmA005oB4WAdRqJPF/VQin9XtS+IGk58jjFDQmsUQFB0Y9NbZGWaCNAMgYbbrHG+edralFOt595k2xfvLrkoN3Lq/bZpbKSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GnCTJd3B; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GnCTJd3B"
Message-ID: <bb855309-422b-418d-ae34-54969e01375f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780278918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQCbMRkdqdDT9GLUSMLXaeh0gg478vZBNxmXwoTOz6U=;
	b=GnCTJd3BSfUClP+EsrGgz2anJizI1lNps8XDR/4ezY3+8U5Tb14abeAfZv2bzXchAihLYN
	fo8bwJf0yz6X2MYCySFso5RSnCLFQzVrw/qGsL4jzIsdFzY9+5xj6RAlNCwd23SGSJ8xRa
	aMauQxDjTgID35xkiQSfsyXbn9R29L4=
Date: Mon, 1 Jun 2026 09:53:28 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable v18 12/14] mm/khugepaged: avoid unnecessary
 mTHP collapse attempts
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>, npache@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net,
 hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com,
 jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com,
 kas@kernel.org, liam@infradead.org, ljs@kernel.org,
 mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de,
 rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org,
 richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org,
 rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz,
 vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org,
 willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com,
 usama.arif@linux.dev
References: <20260522150009.121603-13-npache@redhat.com>
 <20260531073102.20318-1-lance.yang@linux.dev>
 <65e201dd-10d6-43f6-8758-0fc313158fe7@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <65e201dd-10d6-43f6-8758-0fc313158fe7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/1 04:02, David Hildenbrand (Arm) wrote:
> On 5/31/26 09:31, Lance Yang wrote:
>>
>> On Fri, May 22, 2026 at 09:00:07AM -0600, Nico Pache wrote:
>>> There are cases where, if an attempted collapse fails, all subsequent
>>> orders are guaranteed to also fail. Avoid these collapse attempts by
>>> bailing out early.
>>>
>>> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>>> Acked-by: Usama Arif <usama.arif@linux.dev>
>>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>> mm/khugepaged.c | 24 +++++++++++++++++++++++-
>>> 1 file changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index d3d7db8be26c..15b7298bc225 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1535,9 +1535,31 @@ static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
>>> 			collapse_address = address + offset * PAGE_SIZE;
>>> 			ret = collapse_huge_page(mm, collapse_address, referenced,
>>> 						 unmapped, cc, order);
>>> -			if (ret == SCAN_SUCCEED) {
>>> +
>>> +			switch (ret) {
>>> +			/* Cases where we continue to next collapse candidate */
>>> +			case SCAN_SUCCEED:
>>> 				collapsed += nr_ptes;
>>> +				fallthrough;
>>> +			case SCAN_PTE_MAPPED_HUGEPAGE:
>>> 				continue;
>>> +			/* Cases where lower orders might still succeed */
>>> +			case SCAN_LACK_REFERENCED_PAGE:
>>> +			case SCAN_EXCEED_NONE_PTE:
>>> +			case SCAN_EXCEED_SWAP_PTE:
>>> +			case SCAN_EXCEED_SHARED_PTE:
>>> +			case SCAN_PAGE_LOCK:
>>> +			case SCAN_PAGE_COUNT:
>>> +			case SCAN_PAGE_NULL:
>>> +			case SCAN_DEL_PAGE_LRU:
>>> +			case SCAN_PTE_NON_PRESENT:
>>> +			case SCAN_PTE_UFFD_WP:
>>> +			case SCAN_ALLOC_HUGE_PAGE_FAIL:
>>
>> Nit: shouldn't SCAN_CGROUP_CHARGE_FAIL go with SCAN_ALLOC_HUGE_PAGE_FAIL
>> here?
>>
>> If charging the current order fails, a smaller order might still fit :)
> 
> I think the reasoning was here, that if we are already that close to our mem
> limit, we should just give up instead of trying to squeeze it in .. :)

Fair point. Just a nit, nevermind :)
