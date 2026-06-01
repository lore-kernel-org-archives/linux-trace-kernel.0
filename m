Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C8391853
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310903; cv=none; b=ee2ddYcEccoYBswJpTZR4R5gnB8r5cp+h+CA8KhFV+g04lw2Vu2HuK7iVIOVztCEWd1YJ/4TTxWM5ubzVd8RzYmIhAnNWnGJxbsXh1X1B4zZz3OLJo9sEvRy0Gp5JgpOJmJP5InViwuCq3gBPxQO0JwNZg2EbPjSgFYqbY5EvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310903; c=relaxed/simple;
	bh=T7HEqqKt/hcYTLG5nwxbWXpj7+Okw4kr4HMN7yBXN3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Py2lmDoHbcuO1thYseMHcEtbXvo88hBluXqPDigR6Au6eg6p2ULj3qb8X2WOyt+JsO5Wdksq6kW+Xx6livpA2XIQ8lF7E57buD/bHVnS7/Obb1WLiL/VfNNkNcIdYcWf4X4qTxfu/s5TQIGc8Yknv0FiaKDYJJmw0ZCB3HCOmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=neaGU8o1; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="neaGU8o1"
Message-ID: <baa0a462-46e0-44ab-b583-c722ad253afe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780310899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpP3p+OZ5kTTKtnC7lknJ8SUiTBUDhdsLvtMvZmEm/4=;
	b=neaGU8o1iE3/4nTUTm1ddWoYsE2dfW3eX7wU62CONcntJ79HSV+NHfJSc9y6ThIun4wasJ
	BP4QDwazz2Xy7sFW7AuQhOUSjEUvavOzPE0+8qTglgU72VGjV5ffSvP3JWtwytKfZnfQwP
	88YxT/UrKu+ag27omxnIeveYLz889ok=
Date: Mon, 1 Jun 2026 18:47:46 +0800
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
 <616de1a8-1cfd-40b8-b04f-7b324be40bfd@linux.dev>
 <6b11bf0a-769c-4ef2-ac6f-2af38200a6bc@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <6b11bf0a-769c-4ef2-ac6f-2af38200a6bc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/1 18:23, David Hildenbrand (Arm) wrote:
> On 6/1/26 11:08, Lance Yang wrote:
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
>>>
>>>>
>>>> Just wanted to raise it since some arch code may still have assumptions
>>>> like this, and the always-enable-mTHP work is getting closer ...
>>>
>>> Right. I assume set_pte_at() couldn't trigger something similar (re-walk) in
>>> arch code,
>>> because we simply provide the ptep. update_mmu_cache_range() only consumes the
>>> pte.
>>>
>>>>
>>>> Probably very very very hard to hit, though :)
>>>
>>> Delaying update_mmu_cache_range() is nasty, as we'd have to make sure that
>>> nobody can interfere in the meantime ... and the PMD lock will not be sufficient.
>>>
>>> Maybe we could reinstall the page table with the cleared (none) entries while
>>> still holding the PTL?
>>>
>>> Thinking out loud:
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 5ba298d420b7..e39b750b1e6f 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1413,13 +1413,17 @@ static enum scan_result collapse_huge_page(struct
>>> mm_struct *mm, unsigned long s
>>>                   map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
>>>           } else {
>>>                   /*
>>> -                * set_ptes is called in map_anon_folio_pte_nopf with the
>>> -                * pmd_ptl lock still held; this is safe as the PMD is expected
>>> -                * to be none. The pmd entry is then repopulated below.
>>> +                * Re-insert the page table with the cleared entries, but
>>> +                * hold the PTL, such that no one can mess with the re-installed
>>> +                * page table until we updated the temporarily-cleared entries
>>> +                * through map_anon_folio_pte_nopf().
>>>                    */
>>> -               map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /
>>> *uffd_wp=*/ false);
>>> -               smp_wmb(); /* make PTEs visible before PMD. See pmd_install() */
>>
>> One small thing, I think we should probably keep the smp_wmb(), and just
>> move it before the earlier pmd_populate().
>>
>> IIUC, the ordering we want is still:
>>
>>    clear old PTEs
>>    smp_wmb()
>>    pmd_populate()
>>
>> so another CPU cannot walk through the re-installed PMD and still observe
>> the old PTEs, right?
> 
> There is a smp_wmb() in __folio_mark_uptodate(), that should be sufficient?

Ah, cool! __folio_mark_uptodate() already does the job :P

So yeah, no extra smp_wmb() needed here!

Cheers, Lance

