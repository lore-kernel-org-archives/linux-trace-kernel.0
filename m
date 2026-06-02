Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0E37E2FB
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418110; cv=none; b=LkRHKHbyZY4KdT0pAU7K2uhBolwiq3KP2rr+I7WJhTB/qtZL3zW8fUFZS92t69ApCtp5yRfBnh+061i/3SgFJzALdHx0kBY5lCHGWb75vYkrQ+MR7NQDlRhe5YJmuxD5jp5p8/3yFc6fqTpMaESLPa7ol/3UVUf3qVRBQzBEmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418110; c=relaxed/simple;
	bh=e02MIFR4Eh5QfCCofm7+5HoQnYnpURbtiujJHVzOfS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thmPAeaVpIUMVnwZcUrgAAlbdKeiBlIqzwKlev+uTD8DYp1ohgufTuY3qm4cff9W/2DuQV/Se981WsTGY5R0P938t8eHCZR872N+BY/EN2prYa961Ql9zMHbW+Af/oIk0iH4Vo6NJFv7BrzCvOS7yzrn0QG6HFcM35xgC8wsS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e99alI/o; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e99alI/o"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780418093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kfv65sDfPDmPDpEO0E3tjxWYqpXB1G5lz0Quc0XLk54=;
	b=e99alI/oamPJv8ECRvV4dpEn6AtfCTtrQLYfTTiheBxLC0V7F4073yDgp+SJ8btK+1Bls+
	489j1GGe0TmK1/VotWwJHV1ZBblOz+AnoFF6aywKWaSeg1yk/EUaSnEX8fmav4ytNOvWDs
	35D+wl50XsMRVVFSKGbug9oWaVNSKEI=
From: Lance Yang <lance.yang@linux.dev>
To: npache@redhat.com
Cc: lance.yang@linux.dev,
	david@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	jackmanb@google.com,
	jannh@google.com,
	jglisse@google.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	liam@infradead.org,
	ljs@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rakie.kim@sk.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shivankg@amd.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	zokeefe@google.com,
	usama.arif@linux.dev
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize collapse_huge_page for mTHP collapse
Date: Wed,  3 Jun 2026 00:34:18 +0800
Message-Id: <20260602163418.93877-1-lance.yang@linux.dev>
In-Reply-To: <CAA1CXcD7peS3WHueVgAWhhRrjBO_1b19+Xc0CfZBSO8OwJJKQw@mail.gmail.com>
References: <CAA1CXcD7peS3WHueVgAWhhRrjBO_1b19+Xc0CfZBSO8OwJJKQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, Jun 02, 2026 at 09:30:06AM -0600, Nico Pache wrote:
>On Mon, Jun 1, 2026 at 4:48 AM Lance Yang <lance.yang@linux.dev> wrote:
>>
>>
>>
>> On 2026/6/1 18:23, David Hildenbrand (Arm) wrote:
>> > On 6/1/26 11:08, Lance Yang wrote:
>> >>
>> >>
>> >> On 2026/6/1 14:54, David Hildenbrand (Arm) wrote:
>> >>> On 6/1/26 05:28, Lance Yang wrote:
>> >>>>
>> >>>>
>> >>>> Ah, fair point.
>> >>>>
>> >>>> I was mostly worried about arch hooks that walk vma->vm_mm again, rather
>> >>>> than only using the pte pointer passed in. For example, mips does:
>> >>>
>> >>> Right, a re-walk would be the real problem.
>> >>>
>> >>>>
>> >>>>     update_mmu_cache_range()
>> >>>>       -> __update_tlb()
>> >>>>         -> pgd_offset(vma->vm_mm, address)
>> >>>>         -> pte_offset_map(...)
>> >>>>
>> >>>> and __update_tlb() has this assumption:
>> >>>>
>> >>>>          /*
>> >>>>           * update_mmu_cache() is called between pte_offset_map_lock()
>> >>>>           * and pte_unmap_unlock(), so we can assume that ptep is not
>> >>>>           * NULL here: and what should be done below if it were NULL?
>> >>>>           */
>> >>>>
>> >>>> So if khugepaged happens to run with current->active_mm == vma->vm_mm
>> >>>> here, could __update_tlb() hit the none PMD, get NULL from
>> >>>> pte_offset_map(), and then dereference it?
>> >>>
>> >>> Likely yes -- that MIPS code is horrible. And the comment in MIPS code
>> >>> even spells that out. :(
>> >>>
>> >>> Do you know about other code like that, or is MIPS the only one doing a
>> >>> re-walk and crossing fingers?
>> >>>
>> >>>>
>> >>>> Just wanted to raise it since some arch code may still have assumptions
>> >>>> like this, and the always-enable-mTHP work is getting closer ...
>> >>>
>> >>> Right. I assume set_pte_at() couldn't trigger something similar (re-walk) in
>> >>> arch code,
>> >>> because we simply provide the ptep. update_mmu_cache_range() only consumes the
>> >>> pte.
>> >>>
>> >>>>
>> >>>> Probably very very very hard to hit, though :)
>> >>>
>> >>> Delaying update_mmu_cache_range() is nasty, as we'd have to make sure that
>> >>> nobody can interfere in the meantime ... and the PMD lock will not be sufficient.
>> >>>
>> >>> Maybe we could reinstall the page table with the cleared (none) entries while
>> >>> still holding the PTL?
>> >>>
>> >>> Thinking out loud:
>> >>>
>> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> >>> index 5ba298d420b7..e39b750b1e6f 100644
>> >>> --- a/mm/khugepaged.c
>> >>> +++ b/mm/khugepaged.c
>> >>> @@ -1413,13 +1413,17 @@ static enum scan_result collapse_huge_page(struct
>> >>> mm_struct *mm, unsigned long s
>> >>>                   map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
>> >>>           } else {
>> >>>                   /*
>> >>> -                * set_ptes is called in map_anon_folio_pte_nopf with the
>> >>> -                * pmd_ptl lock still held; this is safe as the PMD is expected
>> >>> -                * to be none. The pmd entry is then repopulated below.
>> >>> +                * Re-insert the page table with the cleared entries, but
>> >>> +                * hold the PTL, such that no one can mess with the re-installed
>> >>> +                * page table until we updated the temporarily-cleared entries
>> >>> +                * through map_anon_folio_pte_nopf().
>> >>>                    */
>> >>> -               map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /
>> >>> *uffd_wp=*/ false);
>> >>> -               smp_wmb(); /* make PTEs visible before PMD. See pmd_install() */
>> >>
>> >> One small thing, I think we should probably keep the smp_wmb(), and just
>> >> move it before the earlier pmd_populate().
>> >>
>> >> IIUC, the ordering we want is still:
>> >>
>> >>    clear old PTEs
>> >>    smp_wmb()
>> >>    pmd_populate()
>> >>
>> >> so another CPU cannot walk through the re-installed PMD and still observe
>> >> the old PTEs, right?
>> >
>> > There is a smp_wmb() in __folio_mark_uptodate(), that should be sufficient?
>>
>> Ah, cool! __folio_mark_uptodate() already does the job :P
>>
>> So yeah, no extra smp_wmb() needed here!
>
>are we sure? that folio_mark_uptodate is done before the PTEs are
>reinstalled. Then we reinstall the PMD right after. Currently
>separated by the smp_wmb().

Reinstalling the PMD first makes the PTE table reachable again, right?

So before pmd_populate(), we only need to order the old PTE clears before
the PTE table is reachable again; __folio_mark_uptodate() already has the
smp_wmb() for that :)

The new PTEs are filled later under the PTL.

Hopefully I didn't miss soemthing :)

>I was copying this from other THP code that performs similar PTE/PMD juggling.
>
>I can remove it, but I'd rather air on the side of caution with this.

Cheers, Lance
