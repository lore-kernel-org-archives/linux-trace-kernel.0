Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E6246327;
	Tue, 28 Oct 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646199; cv=none; b=BnuxvHPyLi/Mm/uhZ67b6H+5DxLuH4vhBzr5KfkllewiM3H+VHFd5BC9bhAKNtdEz1ndi/sCkb1zSCcK0uoCau/LtxmAH5oO8uil2wxZx942sue12O/cLGFsDg1TSM5AVM8ZNTR/BEs5HZeM4za+YMlvNRKujGQhxZT7B+o1/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646199; c=relaxed/simple;
	bh=qn8TL4Pnq29CxpNBsZZBQhthbh6JK6irzIuvCt3Nlno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw4sqSC4GAJ9lKzD4awMGebS4iUZPLBIBHoSvNYoJ5uvg+Uz766YhW8tbMd12KDNflEFV+Kx1c4+iZNMnJdNl2MVenmsiIg/jitBi0z8UU0KV8YqmzuG2+Cc8NDAKmvXWd58V74RjM6gxGp5WLtwQmo1hSYR6tf6fyX1AmrCLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DM4GyyeD; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DM4GyyeD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761646188; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D1ryY5baZqSqiYaszWAZLXVQIoYi/aODofY8GTd3HL8=;
	b=DM4GyyeDJGNigw4ek4uvE4agu4aX1tDWLhDK/7sMkF4hyvg/n+92nduqCI2bOx84mWciqHs6seODEDSAVK/sIz46bHp5jadYkYq7oK9h1WT0wJnYSVP4Pj9tWnIwrRsbQYtXkZbhpe5eKI+/BKmjzvau8FCFknVjohaGsYJ6yrQ=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WrBnYT2_1761646184 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 18:09:45 +0800
Message-ID: <063f8369-96c7-4345-ab28-7265ed7214cb@linux.alibaba.com>
Date: Tue, 28 Oct 2025 18:09:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
 ziy@nvidia.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/28 01:53, Lorenzo Stoakes wrote:
> On Wed, Oct 22, 2025 at 12:37:08PM -0600, Nico Pache wrote:
>> The current mechanism for determining mTHP collapse scales the
>> khugepaged_max_ptes_none value based on the target order. This
>> introduces an undesirable feedback loop, or "creep", when max_ptes_none
>> is set to a value greater than HPAGE_PMD_NR / 2.
>>
>> With this configuration, a successful collapse to order N will populate
>> enough pages to satisfy the collapse condition on order N+1 on the next
>> scan. This leads to unnecessary work and memory churn.
>>
>> To fix this issue introduce a helper function that caps the max_ptes_none
>> to HPAGE_PMD_NR / 2 - 1 (255 on 4k page size). The function also scales
>> the max_ptes_none number by the (PMD_ORDER - target collapse order).
>>
>> The limits can be ignored by passing full_scan=true, this is useful for
>> madvise_collapse (which ignores limits), or in the case of
>> collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
>> collapse is available.
>>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 4ccebf5dda97..286c3a7afdee 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -459,6 +459,39 @@ void __khugepaged_enter(struct mm_struct *mm)
>>   		wake_up_interruptible(&khugepaged_wait);
>>   }
>>
>> +/**
>> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
>> + * @order: The folio order being collapsed to
>> + * @full_scan: Whether this is a full scan (ignore limits)
>> + *
>> + * For madvise-triggered collapses (full_scan=true), all limits are bypassed
>> + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
>> + *
>> + * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
>> + * khugepaged_max_ptes_none value.
>> + *
>> + * For mTHP collapses, scale down the max_ptes_none proportionally to the folio
>> + * order, but caps it at HPAGE_PMD_NR/2-1 to prevent a collapse feedback loop.
>> + *
>> + * Return: Maximum number of empty PTEs allowed for the collapse operation
>> + */
>> +static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
>> +{
>> +	unsigned int max_ptes_none;
>> +
>> +	/* ignore max_ptes_none limits */
>> +	if (full_scan)
>> +		return HPAGE_PMD_NR - 1;
>> +
>> +	if (order == HPAGE_PMD_ORDER)
>> +		return khugepaged_max_ptes_none;
>> +
>> +	max_ptes_none = min(khugepaged_max_ptes_none, HPAGE_PMD_NR/2 - 1);
> 
> I mean not to beat a dead horse re: v11 commentary, but I thought we were going
> to implement David's idea re: the new 'eagerness' tunable, and again we're now just
> implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
> 
> I'm still really quite uncomfortable with us silently capping this value.
> 
> If we're putting forward theoretical ideas that are to be later built upon, this
> series should be an RFC.
> 
> But if we really intend to silently ignore user input the problem is that then
> becomes established uAPI.
> 
> I think it's _sensible_ to avoid this mTHP escalation problem, but the issue is
> visibility I think.
> 
> I think people are going to find it odd that you set it to something, but then
> get something else.
> 
> As an alternative we could have a new sysfs field:
> 
> /sys/kernel/mm/transparent_hugepage/khugepaged/max_mthp_ptes_none
> 
> That shows the cap clearly.
> 
> In fact, it could be read-only... and just expose it to the user. That reduces
> complexity.
> 
> We can then bring in eagerness later and have the same situation of
> max_ptes_none being a parameter that exists (plus this additional read-only
> parameter).

We all know that ultimately using David's suggestion to add the 
'eagerness' tunable parameter is the best approach, but for now, we need 
an initial version to support mTHP collapse (as we've already discussed 
extensively here:)).

I don't like the idea of adding another and potentially confusing 
'max_mthp_ptes_none' interface, which might make it more difficult to 
accommodate the 'eagerness' parameter in the future.

If Nico's current proposal still doesn't satisfy everyone, I personally 
lean towards David's earlier simplified approach:
	max_ptes_none == 511 -> collapse mTHP always
	max_ptes_none != 511 -> collapse mTHP only if all PTEs are non-none/zero

Let's first have an initial approach in place, which will also simplify 
the following addition of the 'eagerness' tunable parameter.

Nico, Lorenzo, and David, what do you think?

Code should be:
static unsigned int collapse_max_ptes_none(unsigned int order, bool 
full_scan)
{
         unsigned int max_ptes_none;

         /* ignore max_ptes_none limits */
         if (full_scan)
                 return HPAGE_PMD_NR - 1;

         if (order == HPAGE_PMD_ORDER)
                 return khugepaged_max_ptes_none;

         /*
          * For mTHP collapse, we can simplify the logic:
          * max_ptes_none == 511 -> collapse mTHP always
          * max_ptes_none != 511 -> collapse mTHP only if we all PTEs 
are non-none/zero
          */
         if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
                 return khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - 
order);

         return 0;
}
