Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804C2D7DCE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330093; cv=none; b=LhKrzawiCSrXqcnjvISnhL1FiuL0afwu8jB0hQtbHI+j3/4Z4ZTHxah74Gj63xHeuWLcgeLCFMf75vLma7daFfKJ4kvh9wcrGNJABBGk6o88Qx8XOEphz1HQ9FUyxyhBPvqK0oTyw1V5RcgJjWsD6g6xxDp79fqoGTle7RJbf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330093; c=relaxed/simple;
	bh=2Yekb9uLI7AP2TYXVKk8XIvri4BESEZ3tRy6fbBZKOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POuNnU+yUN21AwiCvGbXPvozwszrD3nJa30+sc5gDaVT0fOXrRHub8bxUoK8mA9mIwMwvvEEfqaPVVLCW2h7rXBi67xyVPXPDg8fJFK2RlMayWsNb19DVXNkxW5cMU4TBmZqWX3cfXYWP4M5EY3NqHp9Mv6TN/+pfyPlT3XFzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KFCrv1SH; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KFCrv1SH"
Message-ID: <76ff7922-bf54-472c-a628-ee191aeaf149@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780330077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hE1QzaSPeeuEtKpkpB1CtsBNbDEAW/Bexb+NhfT6llo=;
	b=KFCrv1SHIW6rKf6zXja1OJy3cyn2UvdGKCE3ASX3JWUedBw+K0MFreVvLWyzIJ7q05O895
	rvnhDuiR+5P9eKG7V9B0yQvbhmbdS8hrfybIXAU8pDudK2wZzqls5tbU4qer7NuOTc/QAp
	Jg8Y8lhEBuDUt90t+eGNkP5jGSXBzPs=
Date: Tue, 2 Jun 2026 00:07:24 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Nico Pache <npache@redhat.com>
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
References: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
 <20260601032804.96122-1-lance.yang@linux.dev>
 <f5d38f64-ab92-496d-afd3-29ccc17fec2b@kernel.org>
 <616de1a8-1cfd-40b8-b04f-7b324be40bfd@linux.dev>
 <6b11bf0a-769c-4ef2-ac6f-2af38200a6bc@kernel.org>
 <baa0a462-46e0-44ab-b583-c722ad253afe@linux.dev>
 <06d9b665-945f-4967-9ed9-b06514478996@kernel.org>
 <CAA1CXcAeEGOsqp-ywAQ7GMYQzXEeco-rUxUkk2hEF69HybC4=w@mail.gmail.com>
 <0bb49c47-8c41-478c-847e-b9154c75e59c@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <0bb49c47-8c41-478c-847e-b9154c75e59c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/1 23:05, David Hildenbrand (Arm) wrote:
> On 6/1/26 17:00, Nico Pache wrote:
>> On Mon, Jun 1, 2026 at 5:14 AM David Hildenbrand (Arm) <david@kernel.org> wrote:
>>>
>>> On 6/1/26 12:47, Lance Yang wrote:
>>>>
>>>>
>>>>
>>>> Ah, cool! __folio_mark_uptodate() already does the job :P
>>>>
>>>> So yeah, no extra smp_wmb() needed here!
>>>
>>> Yeah. BTW, I think we'd need a spin_lock_nested(), so @Nico, treat my code as a
>>> draft.
>>
>> Okay, I read the above and did some investigating.
>>
>> I will try to implement and verify the changes you suggested :)
>>
>> Or an even crazier idea... what if we ensure MIPS checks for PMD_none
>> before walking a PTE table?
> 
> But how would they update the cache then correctly?
> 
> I'm too non-MIPS to know the answer :)

Right, that's my concern as well ...

If MIPS sees pmd_none(), it has no PTE table to walk, so it also has
no way to do the cache update it wanted to do, I guess :)

But, the PTE table is not really gone there. khugepaged only cleared
the PMD temporarily while still using the old PTE table through _pmd.

So I'd go with David's suggestion:

"
Best to make sure the page table is already installed when updating
the entries.
"

Cheers, Lance
