Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7717A2FB;
	Mon, 18 May 2026 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110188; cv=none; b=oRTt7jAJz++QXMS455WJKD71T4gI6ha498QPJzLwxw1tHeNlmjLWr0OWN1YzSATLNXqlb3eW1kQliA/N9FiRJvcsuJzhjBUD/lGCKF9IxGAIsmk/OBiTbxTS1N7sbpq/2xuQF4hws2lzHuQqGtJO5xazKmHhQ6PMGfDH+lzPoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110188; c=relaxed/simple;
	bh=7C2KbRu57NYB8I5vOPmKIt/tonT3UaMHhB/V/5DWvmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZ+1/t47U12C3Jm+e9zDPdQ20LT2A2q71FrNWiFJArv7C1Bmlqq1X+oeN//tvFwytPfs1OnJCx0cuWQciDoHtnYGOPUvGn/i7e1ucy4wmbwPQbDdtIQxDifb/169nIL+N2z1ieZFWWmpsuHqLkNM4HgoRV/Gb9GX9ZQll06QNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftydGKR6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftydGKR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86002C2BCB7;
	Mon, 18 May 2026 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779110188;
	bh=7C2KbRu57NYB8I5vOPmKIt/tonT3UaMHhB/V/5DWvmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ftydGKR6xHwh2ozkWaKKyAQKMEcHYT7dLWtS8NV3C7Zo2iISlDQCxBt2Q3Yr+nzKF
	 YHY8XccWzjrLn+SawgWpmHwQiw80bXnCEovVA2x6ZU8Ha/S4A8pUKfcMk+jI0Kxgs6
	 27mYcsk2PBZlbbO4hLjcLDbUclMNVuoZu86t9Fc2P1Dk/AEVUgM2/sCbUhryKuA455
	 +BScNseJqMh+btS8eyCeU3VE4lblSOnILIptkt8ewEH8inyxY8K/yWGlSOxbiYaBua
	 /VhHH7atfwCdC1JmEoAhMaYWuQIIEXrnVZ1GXMIWCqn4oDIlVP4mvqPG84Udv0tksi
	 sbEQKW5KPbIgA==
Message-ID: <9b33339e-157a-45b7-942e-3be3418a5142@kernel.org>
Date: Mon, 18 May 2026 15:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v17 04/14] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
To: Wei Yang <richard.weiyang@gmail.com>, Lance Yang <lance.yang@linux.dev>
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
 rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
 ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com,
 surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de,
 usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com,
 wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
 yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com,
 zokeefe@google.com
References: <20260511185817.686831-5-npache@redhat.com>
 <20260512074202.10253-1-lance.yang@linux.dev>
 <20260514031009.f66cgop3ctgiqxz3@master>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260514031009.f66cgop3ctgiqxz3@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 05:10, Wei Yang wrote:
> On Tue, May 12, 2026 at 03:42:02PM +0800, Lance Yang wrote:
>>
>> On Mon, May 11, 2026 at 12:58:04PM -0600, Nico Pache wrote:
>>> generalize the order of the __collapse_huge_page_* and collapse_max_*
>>> functions to support future mTHP collapse.
>>>
>>> The current mechanism for determining collapse with the
>>> khugepaged_max_ptes_none value is not designed with mTHP in mind. This
>>> raises a key design issue: if we support user defined max_pte_none values
>>> (even those scaled by order), a collapse of a lower order can introduces
>>> an feedback loop, or "creep", when max_ptes_none is set to a value greater
>>> than HPAGE_PMD_NR / 2. [1]
>>>
>>> With this configuration, a successful collapse to order N will populate
>>> enough pages to satisfy the collapse condition on order N+1 on the next
>>> scan. This leads to unnecessary work and memory churn.
>>>
>>> To fix this issue introduce a helper function that will limit mTHP
>>> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
>>> This effectively supports two modes: [2]
>>>
>>> - max_ptes_none=0: never collapses if it encounters an empty PTE or a PTE
>>>  that maps the shared zeropage. Consequently, no memory bloat.
>>> - max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
>>>  available mTHP order.
>>>
>>> This removes the possiblilty of "creep", while not modifying any uAPI
>>> expectations. A warning will be emitted if any non-supported
>>> max_ptes_none value is configured with mTHP enabled.
>>>
>>> mTHP collapse will not honor the khugepaged_max_ptes_shared or
>>> khugepaged_max_ptes_swap parameters, and will fail if it encounters a
>>> shared or swapped entry.
>>>
>>> No functional changes in this patch; however it defines future behavior
>>> for mTHP collapse.
>>>
>>> [1] - https://lore.kernel.org/all/e46ab3ab-a3d7-4fb7-9970-d0704bd5d05a@arm.com
>>> [2] - https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@redhat.com
>>>
>>> Co-developed-by: Dev Jain <dev.jain@arm.com>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>> include/trace/events/huge_memory.h |   3 +-
>>> mm/khugepaged.c                    | 117 ++++++++++++++++++++---------
>>> 2 files changed, 85 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
>>> index bcdc57eea270..443e0bd13fdb 100644
>>> --- a/include/trace/events/huge_memory.h
>>> +++ b/include/trace/events/huge_memory.h
>>> @@ -39,7 +39,8 @@
>>> 	EM( SCAN_STORE_FAILED,		"store_failed")			\
>>> 	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
>>> 	EM( SCAN_PAGE_FILLED,		"page_filled")			\
>>> -	EMe(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")
>>> +	EM(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")	\
>>> +	EMe(SCAN_INVALID_PTES_NONE,	"invalid_ptes_none")
>>>
>>> #undef EM
>>> #undef EMe
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index f68853b3caa7..27465161fa6d 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -61,6 +61,7 @@ enum scan_result {
>>> 	SCAN_COPY_MC,
>>> 	SCAN_PAGE_FILLED,
>>> 	SCAN_PAGE_DIRTY_OR_WRITEBACK,
>>> +	SCAN_INVALID_PTES_NONE,
>>> };
>>>
>>> #define CREATE_TRACE_POINTS
>>> @@ -353,37 +354,60 @@ static bool pte_none_or_zero(pte_t pte)
>>>  * PTEs for the given collapse operation.
>>>  * @cc: The collapse control struct
>>>  * @vma: The vma to check for userfaultfd
>>> + * @order: The folio order being collapsed to
>>>  *
>>>  * Return: Maximum number of none-page or zero-page PTEs allowed for the
>>>  * collapse operation.
>>>  */
>>> -static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
>>> -		struct vm_area_struct *vma)
>>> +static int collapse_max_ptes_none(struct collapse_control *cc,
>>> +		struct vm_area_struct *vma, unsigned int order)
>>> {
>>> +	unsigned int max_ptes_none = khugepaged_max_ptes_none;
>>> 	// If the vma is userfaultfd-armed, allow no none-page or zero-page PTEs.
>>
>> One thing I still want to call out: kernel code usually uses C-style
>> comments :)
>>
>>> 	if (vma && userfaultfd_armed(vma))
>>> 		return 0;
>>> 	// for MADV_COLLAPSE, allow any none-page or zero-page PTEs.
>>> 	if (!cc->is_khugepaged)
>>> 		return HPAGE_PMD_NR;
>>> -	// For all other cases repect the user defined maximum.
>>> -	return khugepaged_max_ptes_none;
>>> +	// for PMD collapse, respect the user defined maximum.
>>> +	if (is_pmd_order(order))
>>> +		return max_ptes_none;
>>> +	/* Zero/non-present collapse disabled. */
>>> +	if (!max_ptes_none)
>>> +		return 0;
>>> +	// for mTHP collapse with the sysctl value set to KHUGEPAGED_MAX_PTES_LIMIT,
>>> +	// scale the maximum number of PTEs to the order of the collapse.
>>> +	if (max_ptes_none == KHUGEPAGED_MAX_PTES_LIMIT)
>>> +		return (1 << order) - 1;
>>> +
>>> +	// We currently only support max_ptes_none values of 0 or KHUGEPAGED_MAX_PTES_LIMIT.
>>> +	// Emit a warning and return -EINVAL.
>>> +	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %u\n",
>>> +		      KHUGEPAGED_MAX_PTES_LIMIT);
>>
>> Maybe fallback to 0 instead, as David suggested earlier?
>>
> 
> It looks reasonable to fallback to 0.
> 
> But as the updated Document says in patch 14:
> 
>   For mTHP collapse, only 0 or (HPAGE_PMD_NR - 1) are supported. Any other
>   value will emit a warning and no mTHP collapse will be attempted.
> 
> This is why it does like this now.
> 
>     mthp_collapse()
>         max_ptes_none = collapse_max_ptes_none();
>         if (max_ptes_none < 0)
>             return collapsed;
> 
>> max_ptes_none is mostly legacy PMD THP behavior. mTHP is new, and any
>> intermediate value in (0, KHUGEPAGED_MAX_PTES_LIMIT) would implicitly
>> disable it :(
>>
> 
> So it depends on what we want to do here :-)
> 
> For me, I would vote for fallback to 0.

At this point I'll prefer to not return errors from collapse_max_ptes_none().
It's just rather awkward to return an error deep down in collapse code for a
configuration problem.

For mthp collapse, we only support max_ptes_none==0 and
max_ptes_none=="HPAGE_PMD_NR - 1" (default).

If another value is specified while collapsing mTHP, print a warning and treat
it as 0 (save value, no creep, no memory waste).

In a sense, this is similar to how we handle max_ptes_shared + max_ptes_swap:
for mTHP: we always treat them as being 0 for mTHP collapse (and don't issue a
warning, because we would issue a warning with the default settings).

@Lorenzo, fine with you?

-- 
Cheers,

David
