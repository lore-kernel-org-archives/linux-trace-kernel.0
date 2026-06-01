Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD0F389118
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303518; cv=none; b=sMKOx+xjpLL1Nei9k1H5go2tIGnejFBC1jPxi/9vQlHTs1aZd2A3wd9XY9jdu2697zWym8ld54xSbRT4MHg3gkrkI1Zax1Oy/0bLOyuMdvyQQKhRwYvycuoCLAZz6GJygY6hysSNBndbiXDJKiARdSE3TyXrXIl0d4LeIJYZj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303518; c=relaxed/simple;
	bh=GTUzk1xbOR3HrMGPr1vzXbCMH8PmLMq7Js6eGVC2H6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtKHkDr/G+4z+FyAqq4Hyu085rg7JvcnRl6KA9OzkNJ8palBiLcQ0AYXHoQgZillNkz4QDqIGaED0CsCn4fqdE1bkcW2D+HrkR9olOivyD6XX4RFX6WJwqR1t38yqnUQXp3FvyLgjsMwhPW0g+sUi2w2JUItfMek6dR8aZF0ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZLZ7xn9h; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZLZ7xn9h"
Message-ID: <32751424-8ad3-4fd2-9f07-8a4f5a98d632@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780303510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOza5WLjJJP8CiSXeBVxPUywkC8JLKE6qF7U7SNImWM=;
	b=ZLZ7xn9hizllj61bp6haxPz5lrd2xU6GM6bDFO7OqfBI8FyYU42nZlvDfUN0Z5UMU7aoPF
	43AKsI66i32+vOBgOtACggTlFYEWqqH+kqMMNwAHNssdinbwxhK69jz7fMZGpnr4PB5lUn
	G1D4AFqa1xpKp9BarKxWXLQdyayfjMk=
Date: Mon, 1 Jun 2026 16:44:44 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: npache@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
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
References: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
 <20260601032804.96122-1-lance.yang@linux.dev>
 <f5d38f64-ab92-496d-afd3-29ccc17fec2b@kernel.org>
 <fb8f24b1-ce8e-4f06-bbd8-f148a9bcaeee@linux.dev>
 <1c99294c-9ebe-4856-bfde-09801701d75c@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <1c99294c-9ebe-4856-bfde-09801701d75c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/1 16:15, David Hildenbrand (Arm) wrote:
> On 6/1/26 09:49, Lance Yang wrote:
>>
>>
>> On 2026/6/1 14:54, David Hildenbrand (Arm) wrote:
>>> On 6/1/26 05:28, Lance Yang wrote:
>>>>
>>>>
>>>> Ah, fair point.
>>>>
>>>> I was mostly worried about arch hooks that walk vma->vm_mm again, rather
>>>> than only using the pte pointer passed in. For example, mips does:
>>>
>>> Right, a re-walk would be the real problem.
>>>
>>>>
>>>>     update_mmu_cache_range()
>>>>       -> __update_tlb()
>>>>         -> pgd_offset(vma->vm_mm, address)
>>>>         -> pte_offset_map(...)
>>>>
>>>> and __update_tlb() has this assumption:
>>>>
>>>>          /*
>>>>           * update_mmu_cache() is called between pte_offset_map_lock()
>>>>           * and pte_unmap_unlock(), so we can assume that ptep is not
>>>>           * NULL here: and what should be done below if it were NULL?
>>>>           */
>>>>
>>>> So if khugepaged happens to run with current->active_mm == vma->vm_mm
>>>> here, could __update_tlb() hit the none PMD, get NULL from
>>>> pte_offset_map(), and then dereference it?
>>>
>>> Likely yes -- that MIPS code is horrible. And the comment in MIPS code
>>> even spells that out. :(
>>>
>>> Do you know about other code like that, or is MIPS the only one doing a
>>> re-walk and crossing fingers?
>>
>> I had Codex do the boring grep-work through the arch update_mmu_cache*
>> code :D
>>
>> MIPS doesn't seem to be the only code doing a re-walk, but it is the
>> only one I found that appears to assume the PMD/PTE walk cannot fail,
>> without checking whether the PMD is none ...
> 
> Okay, but likely the other code that tries to handle it is also problematic.
> 
> Best to make sure the page table is already installed when updating the entries.

Neat, makes sense to me :D

That way the page talbe is back in place before any arch hook gets to 
look at it :)

