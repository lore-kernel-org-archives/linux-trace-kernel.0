Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E7314B8E;
	Tue, 11 Nov 2025 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762832480; cv=none; b=kzsdvXNLCxU+4k4YEAXE5L/E/PNaqyFEoNaOdjGks3bIbKIE7AIiqxk+V05Q2C8IkhBmZ7wNauza5Jqb3LsQGgErBIz8+vNJqf1yKXldzEgaJVPA11Aw5EHC+u6Nkf5E7Noq2tBdK2ppdDP1JXRlPAFGuzWroS/sFJ4GXErzOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762832480; c=relaxed/simple;
	bh=sDswkZJYCUFqFb7Jr1TYvJDWFPReh8rYaSKFz6GHaSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLHFhcfy9zGq36CTkgueB8crdwCnsZ9o9DFV4hewl3PwNVIKW/Mgqq8zTIv8dGtcCHJX76yZQA8ctJdPaAxwEcnxSzhfXRsQkXxwHSZq6A9Ie/jDttHHytfyo+PiLTkM9ozTU8vhF2PEH2vYRMvrUbTjdXmkxWgvbQOBeXqiogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FF5D2F;
	Mon, 10 Nov 2025 19:41:10 -0800 (PST)
Received: from [10.164.136.36] (unknown [10.164.136.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A34B3F63F;
	Mon, 10 Nov 2025 19:41:11 -0800 (PST)
Message-ID: <a63d5305-2266-4a60-89e5-d737ba6e2f4c@arm.com>
Date: Tue, 11 Nov 2025 09:11:08 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
 <f21b37bb-7a2b-412b-be76-e8968b4c375d@lucifer.local>
 <3f5f8a48-fa3b-4985-95e1-dd0ac21b5dcc@arm.com>
 <312bfcbd-d31a-40d3-8b9c-edc7b6166113@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <312bfcbd-d31a-40d3-8b9c-edc7b6166113@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/11/25 7:06 pm, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 06:54:57PM +0530, Dev Jain wrote:
>> On 10/11/25 5:31 pm, Lorenzo Stoakes wrote:
>>> ofc you are addressing this with the !cc->is_khugepaged, but feels like we'd be
>>> better off just doing it in madvise_collapse().
>> I suppose the common case is that writeback is not needed, and I don't know what
>> is the overhead of filemap_write_and_wait_range() in that case, but your
> Low.
>
>> suggestion will force that unconditional overhead and skip all the early exits
>> possible in hpage_collapse_scan_file()?
> Which are?
>
> PMD-mapped folio at start of range, scan abort, non-LRU, spurious ref count
>
> I don't think this matters.
>
> And we're trading for putting _yet more_ logic that belongs elsewhere in the
> wrong place.
>
> I mean I'd actually be pretty good with us putting it literally in madvise.c,
> but since we defer the collapse to khugepaged.c then madvise_collapse().
>
>>> I wonder also if doing I/O without getting the mmap lock again and revalidating
>>> is wise, as the state of things might have changed significantly.
>>>
>>> So maybe need a hugepage_vma_revalidate() as well?
>> The file collapse path (apart from collapse_pte_mapped_thp) is solely concerned
>> about doing the collapse in the page cache, for which information about the mm or
>> the vma is not needed, that is why no locking is required. The get_file() in
> The user has asked specifically to collapse pages in a VMA's range. Yes you can
> go check the mapping of a pinned file which you're keeping pinned during this
> operation (wise? Not sure it is).
>
> This would be the first time in this operation we are doing a _synchronous_ I/O
> operation where we sleep holding a pin.
>
> So no, I think we really do need to revalidate.
>
> 'Collapse some random file we no longer map at this address' is probably not
> great semantics, also of course, we are revalidating at each PMD anyway.
>
> Maybe even do a addr -= HPAGE_PMD_SIZE; continue + take it from the top?
>
> Maybe David has thoughts...
>
>> khugepaged_scan_mm_slot() seems to be serving the same function as maybe_unlock_mmap_for_io().
>> So I don't think this is needed?
> We're talking about the MADV_COLLAPSE case so don't understand this? I may be
> missing something here (happens a lot ;)!

My bad, meant to say madvise_collapse() -> get_file().

>
>
>>>
>>>> +
>>>>    	result = alloc_charge_folio(&new_folio, mm, cc);
>>>>    	if (result != SCAN_SUCCEED)
>>>>    		goto out;
>>>>
>>>> base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
>>>> --
>>>> 2.43.0
>>>>
>>> Thanks, Lorenzo
> Cheers, Lorenzo
