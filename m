Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CA273D76
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115818; cv=none; b=jdZOmf3onQYEXmL1spiZ8AyKoMQciMQkykqKgDpX/mFtMm22u5NzotEQ3dt+TPyqMA71Z0Q9TdJMlwlSCS8gjRNNyH8isrdVZXSgkTyZTR7f2eTLekktDT7gTQhXR9CivUl+4svT17ShTtehf6wbMC3hQosPzzxifOgDgWJx3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115818; c=relaxed/simple;
	bh=oURhpEBlAycUWGbt4NLTrrptb/5bAJzXmY4fgpuMNSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0/kxR8aES2J1y136Z8oFXYEs6XedTXXol7jtsqk1hpgQnUg2yo956TGphBCU1wmSomlhFQDC6c1XVb+hNMTW/EcJoeeBkIgMnXUnSleb7169SxZO2gr+HpA9V6sWvVLkv+SXeCbGn+G/s11YgHdfY6QL1so9/RbjbNnwID2oVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GGDI55Jj; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GGDI55Jj"
Message-ID: <51db205d-77cf-416f-bfe5-fd9d0b12c433@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779115804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4JAT+Wv/wwNQKfA8xAYYX6sfEdDyGrZpZJWJ9wvC6o=;
	b=GGDI55JjKEWW58pLJGuEuk13mpMWz2AZW3HUCXipMsnflKZs31jdktebMCfBgPW9nmuzTY
	ZYmzrf6bs0k7XjgXrnImxn9WjNZNHKzB4lrc7ZZwSVGza9GdmjDhHFTot3DH8zZ5yqjGl4
	DiJ3oqFstsnOR3UmclsnOEO4xKuhJCQ=
Date: Mon, 18 May 2026 22:49:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable v17 02/14] mm/khugepaged: generalize
 alloc_charge_folio()
Content-Language: en-US
To: Usama Arif <usama.arif@linux.dev>, Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
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
References: <20260518115553.3513034-1-usama.arif@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260518115553.3513034-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/5/18 19:55, Usama Arif wrote:
[...]
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 979885694351..f0e29d5c7b1f 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1068,21 +1068,26 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
>>   }
>>   
>>   static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>> -		struct collapse_control *cc)
>> +		struct collapse_control *cc, unsigned int order)
>>   {
>>   	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>>   		     GFP_TRANSHUGE);
>>   	int node = collapse_find_target_node(cc);
>>   	struct folio *folio;
>>   
>> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
>> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>>   	if (!folio) {
>>   		*foliop = NULL;
>> -		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>> +		if (is_pmd_order(order))
>> +			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>> +		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>>   		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>>   	}
>>   
>> -	count_vm_event(THP_COLLAPSE_ALLOC);
>> +	if (is_pmd_order(order))
>> +		count_vm_event(THP_COLLAPSE_ALLOC);
>> +	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
>> +
> 
> The vmstat THP_COLLAPSE_ALLOC counter is pmd order only.
> But after this we have
> 
> 	count_memcg_folio_events(folio, THP_COLLAPSE_ALLOC, 1);
> 
> which is not being guarded with is_pmd_order().

Good catch!

> 
> I think we want this to be pmd order only as well so that
> the meaning of the vmstat and cgroup counter remains the same?

Agreed. THP_COLLAPSE_ALLOC should remain PMD order only for
vmstat and memcg events.

So this should be guarded with is_pmd_order() as well :)

Cheers, Lance
