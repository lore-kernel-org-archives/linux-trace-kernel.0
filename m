Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742B72617;
	Sun, 31 May 2026 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780217326; cv=none; b=YMU9SAc3d+AQqTL/OovAz/9As1dTGxJ/K9g/oP6t/LpwlOuffcgnQ5ej9d8naH9cT2p5xEWHmbxo2FKVpVRokiX4GRr/xQza0GhjiAMDwrhB95+F/s8sShfOQb2w49plm/BtmvAsq9JXxOp//IHL/rRBmnkPIeEvooag1da7u00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780217326; c=relaxed/simple;
	bh=uSedyu6fa22/scmtGFWpkpwKG/xroOzUSAdrt+6hLoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ki4EEprELV234do+IDz4QupVfOwaINKzUr/G8bmexxcsCctlOTMpkXJLH+4KtU5tvs32jC5pzZD+cg5rFgn+eEUgOmeI2y8QXDi3VlxresCn3wxg90CKaJOAs37KuNSASmo7xkd3R8VeW9CtVfa80sYVrsDUhThtf3i9TV98q6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aoIoHeGS; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aoIoHeGS"
Message-ID: <6a9f062c-8376-4f83-90a9-8b167f925dc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780217312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtWyv+l/PUjKD80QEnpdDAWmHtcb20b8E/xmF2pmiZc=;
	b=aoIoHeGSPv7WJAUGcwp8gvMotVzsI7iE0R9cK8zt8tCXV44otjV2XtrKmsWdhCusYmakor
	0G8XAsjLn21UL2vyqYY9VyPR0mcD7GaqVNcRo7DEf9pLj1qvz2RziNjQmJnHOjSQwtNeav
	STvc2+9ZkdHUwWEQ6I4akRieqYKUEvw=
Date: Sun, 31 May 2026 16:48:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: npache@redhat.com
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260531071845.10875-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/5/31 15:18, Lance Yang wrote:
> 
> On Fri, May 22, 2026 at 09:00:06AM -0600, Nico Pache wrote:
> [...]
>> @@ -1587,10 +1749,11 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>> 	if (result == SCAN_SUCCEED) {
>> 		/* collapse_huge_page expects the lock to be dropped before calling */
>> 		mmap_read_unlock(mm);
>> -		result = collapse_huge_page(mm, start_addr, referenced,
>> -					    unmapped, cc, HPAGE_PMD_ORDER);
>> -		/* collapse_huge_page will return with the mmap_lock released */
>> +		nr_collapsed = mthp_collapse(mm, vma, start_addr, referenced,
>> +					     unmapped, cc, enabled_orders);
>> +		/* mmap_lock was released above, set lock_dropped */
>> 		*lock_dropped = true;
>> +		result = nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
> 
> Hmm ... don't we lose the allocation-failure result here?
> 
> Previously collapse_scan_pmd() propagated SCAN_ALLOC_HUGE_PAGE_FAIL from
> collapse_huge_page(), so khugepaged would call khugepaged_alloc_sleep()
> in khugepaged_do_scan().
> 
> Now if allocation fails and nr_collapsed stays 0, we just return
> SCAN_FAIL. So we won't back off via khugepaged_alloc_sleep() anymore?

Looks like this is a more general issue with mthp_collapse() only
returning nr_collapsed.

For example, SCAN_PMD_MAPPED used to be propagated too, and
madvise_collapse() treats that as success. With the new code, if
nothing was collapsed by this call, that can also become SCAN_FAIL ...

So I think we should keep both.

Cheers, Lance

