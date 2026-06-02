Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7E3EDE57
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415103; cv=none; b=LetJr8R1t339UjLDxmo6+WqjU8CcRL5KIwSRgBP19lYs8mSmOWYhS6qI4ZLOAP2EkuYDQJVuCLFzMYY053Y2YBPjlsmJlUgHMXSbzactr4X7YPVbIAQGEoGpsrxA1Asy4jSxjIJXnCwIjrZbFSbhXA99vaWWtvcEr45lerPaCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415103; c=relaxed/simple;
	bh=jZS53jNYRwftHvcSkUKQ42Zn65dp7rnKvchXLtDd1S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ociOXZMqT9knd99tpYJWY+9Pytjfm5rpRwRrNUJstWR2YeTDxu/+FxyqUfyY2pc05RcPiDbldDlOJEjQETlALIps1G65aPJ+ZBMStxhXghtRQ3fIuMUV519W1EKX7jFDb5aTXU/4et6ZeyA1aM1LEo8w1vk6JeppW3/C2Mes4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dUPN8UjC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dUPN8UjC"
Message-ID: <185f5699-3797-4300-8c54-bb99fc2a45e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780415088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8W9tKC2C6NAekt7xw/i353pEy5xESfITkwO5U4ZKyM=;
	b=dUPN8UjCk9D//WfVj3ZIPIfxri7y0+DyfDfey/e1A6zAzAK6UEAwk60rmDdQMBMczBTVfQ
	eYmfVDCyFQ4DgX5Zvih0NOTAT5JeaRkrMW9fNX91jRnKuwjIyKGOWl6TgNiUuKF1OUIs5y
	itnu61NoSa2Vsg4tbFTDOK/aUcpzzfM=
Date: Tue, 2 Jun 2026 23:44:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
Content-Language: en-US
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
 gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
 jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, liam@infradead.org, ljs@kernel.org,
 mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de,
 rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org,
 richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org,
 rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz,
 vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org,
 willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
References: <20260522150009.121603-12-npache@redhat.com>
 <20260531071845.10875-1-lance.yang@linux.dev>
 <CAA1CXcA+oZmp=cxiC2_EBDxqGX94gAd335d9eFPNv=j_0=og7Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAA1CXcA+oZmp=cxiC2_EBDxqGX94gAd335d9eFPNv=j_0=og7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/2 18:58, Nico Pache wrote:
> On Sun, May 31, 2026 at 1:19 AM Lance Yang <lance.yang@linux.dev> wrote:
>>
>>
>> On Fri, May 22, 2026 at 09:00:06AM -0600, Nico Pache wrote:
>> [...]
>>> @@ -1587,10 +1749,11 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>>>        if (result == SCAN_SUCCEED) {
>>>                /* collapse_huge_page expects the lock to be dropped before calling */
>>>                mmap_read_unlock(mm);
>>> -              result = collapse_huge_page(mm, start_addr, referenced,
>>> -                                          unmapped, cc, HPAGE_PMD_ORDER);
>>> -              /* collapse_huge_page will return with the mmap_lock released */
>>> +              nr_collapsed = mthp_collapse(mm, vma, start_addr, referenced,
>>> +                                           unmapped, cc, enabled_orders);
>>> +              /* mmap_lock was released above, set lock_dropped */
>>>                *lock_dropped = true;
>>> +              result = nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
>>
>> Hmm ... don't we lose the allocation-failure result here?
>>
>> Previously collapse_scan_pmd() propagated SCAN_ALLOC_HUGE_PAGE_FAIL from
>> collapse_huge_page(), so khugepaged would call khugepaged_alloc_sleep()
>> in khugepaged_do_scan().
>>
>> Now if allocation fails and nr_collapsed stays 0, we just return
>> SCAN_FAIL. So we won't back off via khugepaged_alloc_sleep() anymore?
> 
> Ok I did the error propagation! I think I handled both of these cases
> you brought up pretty easily.

Thanks.

> However I don't know what to do in the following case: We successfully
> collapsed some portion of the PMD, but during that process, we also
> hit an allocation failure. Is it best to back off entirely? or can we
> treat some forward progress as a sign we can continue trying collapses
> without sleeping.
> 
> Basically, do we prioritize SCAN_ALLOC_HUGE_PAGE_FAIL or the
> successful collapses as the returned value?

Thinking out loud, forward progress should win here, the allocation
failure only matter if we made no progress at all?

> This is what I currently have:
> done:
>      if (collapsed)
>          return SCAN_SUCCEED;
>      if (alloc_failed)
>          return SCAN_ALLOC_HUGE_PAGE_FAIL;

I'd go with this ordering :)

Cheers, Lance
