Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D00489863;
	Mon,  3 Aug 2026 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785725028; cv=none; b=oFXVFkAL6Xom5BrLzI3+CN5M3hFJcTRVGq7iAQa0cWzkCVwxua+soySRtMJeXuG6HoRmf3sWbZz8A2s4gl5srIXltPSFRNSHJdi6FsS/cFcCeOQTGSIIS8qSCKe3CkIrf65VtkdZhHTsMbDRun1omeDdBOC6igtWOtuZCeWbzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785725028; c=relaxed/simple;
	bh=CFNSytE+2tg0bkqq7UMDHzkgq4F5EqtfTyEFf8TpgrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sprt2HZY7CZF4+dHM+cusvgTi/fXUfUaLlkQr/wT/Mnt3K5DAfdufJU2XywUqd7YjuCmdjH7K+ppOjUCtqEy8wqI4557pkbKb4ajtEKOlf2SPzI4ip2A4Ad7PLag/BHWsWJRutyWldNXCVZMlZKucuzBPO69lJQINdThWhA9ZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFu8fuyU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFu8fuyU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785725025; x=1817261025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CFNSytE+2tg0bkqq7UMDHzkgq4F5EqtfTyEFf8TpgrM=;
  b=kFu8fuyUivNfuv1b20Z/BgKD5WD0q3KZabkjyh8d8j7+1k2kH34NjNGr
   EQ7z4a3PmfHJvUUes4Nhwqy9ZxeMaKHiHG8pUhx12luooITjLr2XZETEW
   X8lg9UpVfwv0WyZmba8bv0MQ8SErvfAUAtLo9wZmDO/XjlP/afTYSpMhw
   vOdTQ5THt8yq12nd6xz5ZmJ0pg/R6cGdhr7Exu09/Je0SlywJrt+BAr9s
   mCCDsqLmDda5uOtPmtD+74ttxeVAEfSwSigijoou7ZdvzozvfOaepWH2i
   jqnL8+YY5sYr8yvvEqFhWar1Yy/LJ24tfHOl4l1KT1fY5vEWNz2iRP9Kw
   Q==;
X-CSE-ConnectionGUID: qlLuhEv4Sbqog1+RZIQvTg==
X-CSE-MsgGUID: c9q+uS57TbC3XHJLE4GpRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="90143910"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="90143910"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 19:43:44 -0700
X-CSE-ConnectionGUID: BEG4ZP1DRymmaTKVaWpetA==
X-CSE-MsgGUID: B7M1+kP7TIiUCgGwEr8Lcw==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 19:43:30 -0700
Message-ID: <25ab36cf-888a-4547-b3f7-5bd4e057c1d0@intel.com>
Date: Mon, 3 Aug 2026 10:43:26 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/41] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org,
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-7-35f9aec2aed2@google.com>
 <60d19013-d6d7-4eec-827a-2622e22cec98@intel.com>
 <CAEvNRgF0SxmoMtqq69tUih54A9K7j_wcMFRrq=r9w6TnAGAUQQ@mail.gmail.com>
 <dd4201f2-3660-46ad-958f-c70feb1ab1c3@intel.com>
 <amzMtg4K6qEEsudx@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <amzMtg4K6qEEsudx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/2026 12:26 AM, Sean Christopherson wrote:
> On Fri, Jul 31, 2026, Xiaoyao Li wrote:
>> On 7/31/2026 4:42 AM, Ackerley Tng wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>
>>>> On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
>>>>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>>>>> index 33c9830190e2e..89cf922232920 100644
>>>>> --- a/virt/kvm/guest_memfd.c
>>>>> +++ b/virt/kvm/guest_memfd.c
>>>>> @@ -893,6 +893,27 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>>>>     EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>>>>>
>>>>>     #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
>>>>> +static bool kvm_range_is_private(struct file *file, pgoff_t index,
>>>>> +				 size_t nr_pages, struct kvm *kvm, gfn_t gfn)
>>>>> +{
>>>>> +	struct inode *inode = file_inode(file);
>>>>> +	pgoff_t last = index + nr_pages - 1;
>>>>> +	struct maple_tree *mt;
>>>>> +	void *entry;
>>>>> +
>>>>> +	if (!gmem_in_place_conversion)
>>>>> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>>>>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>>>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>>>>> +
>>>>> +	mt = &GMEM_I(inode)->attributes;
>>>>> +	mt_for_each(mt, entry, index, last) {
>>>>> +		if (kvm_gmem_interpret_entry(inode, entry) !=
>>>>> +		    KVM_MEMORY_ATTRIBUTE_PRIVATE)
>>>>> +			return false;
>>>>> +	}
>>>>> +	return true;
>>>>> +}
>>>>>
>>>>>     static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>>>>     				struct file *file, gfn_t gfn, struct page *src_page,
>>>>> @@ -913,9 +934,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>>>>
>>>>>     	folio_unlock(folio);
>>>>>
>>>>> -	if (!kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + 1,
>>>>> -						KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>>>> -						KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
>>>>> +	if (!kvm_range_is_private(file, index, 1, kvm, gfn)) {
>>>>
>>>> It's checking if a single gfn is private.
>>>>
>>>
>>> But with huge page support we'd need to check a range of gfns... I guess
>>> there's the argument of not keeping complexity for the future, but in
>>> this case it's undoing functionality for this series and probably adding
>>> it back later.
>>
>> let's leave the work for huge page support in the future.
> 
> It's not just for hugepage support, the core functionality is used in this series
> by __kvm_gmem_set_attributes() in:
> 
>    KVM: guest_memfd: Return early if range already has requested attributes
> 
>>>> We can just use kvm_mem_is_private()? And it seems can be a separate patch.
>>>>
>>>
>>> Do you mean that this refactoring could be a separate patch? I could
>>> refactor out kvm_range_is_private() in a separate patch, then put in the
>>> mt_for_each() check in this patch together as part of all the rest of
>>> the "wiring".
>>>
>>> I considered that but it seemed like the refactoring was too small to
>>> separate out into another patch when the mt_for_each() part is going to
>>> be in this patch anyway.
>>>
>>> Or, I could add an earlier patch to first replace the call to
>>> kvm_range_has_vm_memory_attributes() with a call to check just 1 gfn,
>>> then this wiring patch would be simpler.
>>>
>>
>> This is what I meant. An earlier patch to just replace
>> kvm_range_has_vm_memory_attributes() with kvm_mem_is_private(). Then we can
>> drop this 'big' diff in this patch.
>>
>> If kvm_range_is_private() is useful/required by huge page support, then let
>> the huge page series to introduce it. It has nothing to do with the in-place
>> conversion series.
> 
> If it weren't for the fact that the range-based search is used later in this
> series, I would 100% agree with Xiaoyao.  
 > But since the core logic is used and needed elsewhere,

I don't see it a problem. Without introducing kvm_range_is_private() in 
this patch, the core logic of range-based search on gmem can still be 
introduced as kvm_gmem_range_has_attributes() directly in patch 10 or in 
a separate patch.

 > and because kvm_range_has_vm_memory_attributes() takes a range,> my 
vote is to provide the plumbing now, even though a small portion of it isn't
> strictly necessary.

So my initial feedback was "we can just use kvm_mem_is_private(kvm, 
gfn)". It makes code simpler. And as a bonus, the logic to choose 
between gmem-based attribute query and vm-based attribute query is 
hidden from the static call.

The second bonus of dropping kvm_range_is_private() is that we can 
eliminate one more chunk in patch 20.
