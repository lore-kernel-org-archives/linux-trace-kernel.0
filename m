Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0E3E929B;
	Thu, 19 Mar 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935947; cv=none; b=oUJOo1rPVCER+S8uT3kc1m3Vk94QniYZeLFp6cmGkdjrbyYkXrNSDrwSJXL+p2AtrcgRmQ4oxn+w1esXXOQVt+UYBLASk0k/f2WRCIYezHLBdzItWX9JlOk3rHRA4+aAUCOnUOxD5WBIYtoktH76n5RyUPrc78HIVbhoHm9MLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935947; c=relaxed/simple;
	bh=Lb4oqU4iPyvZ1i8PhgXMxctkWzAoFzaDDuT6Xm9wAYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBMBMYJ4cwLFoJ0jL3nYfPKd9J8kFPcCYtaFiJ4FfnJcs17yir6cFM1toxE/4ScaV1+MLBNhTCJYUoQsqB5M+0Arg79pMgolWnYidhcWF6cCpE2/tWWCbrCXgWTTGYkaGh31cvME/Q9iws8avXWNdSqQPSdBnhV/g3eq8puqM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/qOknp+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/qOknp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D16AC2BCAF;
	Thu, 19 Mar 2026 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773935946;
	bh=Lb4oqU4iPyvZ1i8PhgXMxctkWzAoFzaDDuT6Xm9wAYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/qOknp+NF8zfgg9EcPZ92SUhgK1wewr6thkOtev0OirSgVgo8CxM22mhI9t4olCZ
	 F9QKHOptUpnMSX4t//ajKhF5QZVTFfWiTzSdh88rgLDPci0Uy/5jKPaSIt/ZY+woCQ
	 1n1O3LjlaVjdze6GVVaNtuWOMomclWrAxCMWuiCtU/Xj6RODTMoR64DPCJ2wrJe3Lu
	 5XBLLtaNWFj+NSJ+SaQsQ1OkK6AmSV+CFKKwHIvC0xSPoR0rlXgaNxqOHEkmHJfDSu
	 m0EFEZECCKyxoGkvSvJVq8deNghNUoIIkQ3zHPRhsF2x61w5GnxOB6q4xDOrVKDUW3
	 CYFk6ohEaWLnw==
Date: Thu, 19 Mar 2026 15:59:04 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com, 
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, 
	pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v15 11/13] mm/khugepaged: avoid unnecessary
 mTHP collapse attempts
Message-ID: <b4731810-2ee0-4e89-a193-9cc4ba015e3e@lucifer.local>
References: <20260226031741.230674-1-npache@redhat.com>
 <20260226032631.234234-1-npache@redhat.com>
 <d8028d32-4791-4993-aae3-66506bf6d1bd@lucifer.local>
 <a9ddfa7b-5ee4-4c68-bac0-8a0c6c355bf7@redhat.com>
 <4774da78-8349-4eda-a09b-7248e82cb26b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4774da78-8349-4eda-a09b-7248e82cb26b@kernel.org>

On Wed, Mar 18, 2026 at 08:48:30PM +0100, David Hildenbrand (Arm) wrote:
> On 3/18/26 19:59, Nico Pache wrote:
> >
> >
> > On 3/17/26 4:35 AM, Lorenzo Stoakes (Oracle) wrote:
> >> On Wed, Feb 25, 2026 at 08:26:31PM -0700, Nico Pache wrote:
> >>> There are cases where, if an attempted collapse fails, all subsequent
> >>> orders are guaranteed to also fail. Avoid these collapse attempts by
> >>> bailing out early.
> >>>
> >>> Signed-off-by: Nico Pache <npache@redhat.com>
> >>
> >> With David's concern addressed:
> >>
> >> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> >>
> >>> ---
> >>>  mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 34 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>> index 1c3711ed4513..388d3f2537e2 100644
> >>> --- a/mm/khugepaged.c
> >>> +++ b/mm/khugepaged.c
> >>> @@ -1492,9 +1492,42 @@ static int mthp_collapse(struct mm_struct *mm, unsigned long address,
> >>>  			ret = collapse_huge_page(mm, collapse_address, referenced,
> >>>  						 unmapped, cc, mmap_locked,
> >>>  						 order);
> >>> -			if (ret == SCAN_SUCCEED) {
> >>> +
> >>> +			switch (ret) {
> >>> +			/* Cases were we continue to next collapse candidate */
> >>> +			case SCAN_SUCCEED:
> >>>  				collapsed += nr_pte_entries;
> >>> +				fallthrough;
> >>> +			case SCAN_PTE_MAPPED_HUGEPAGE:
> >>>  				continue;
> >>> +			/* Cases were lower orders might still succeed */
> >>> +			case SCAN_LACK_REFERENCED_PAGE:
> >>> +			case SCAN_EXCEED_NONE_PTE:
> >>> +			case SCAN_EXCEED_SWAP_PTE:
> >>> +			case SCAN_EXCEED_SHARED_PTE:
> >>> +			case SCAN_PAGE_LOCK:
> >>> +			case SCAN_PAGE_COUNT:
> >>> +			case SCAN_PAGE_LRU:
> >>> +			case SCAN_PAGE_NULL:
> >>> +			case SCAN_DEL_PAGE_LRU:
> >>> +			case SCAN_PTE_NON_PRESENT:
> >>> +			case SCAN_PTE_UFFD_WP:
> >>> +			case SCAN_ALLOC_HUGE_PAGE_FAIL:
> >>> +				goto next_order;
> >>> +			/* Cases were no further collapse is possible */
> >>> +			case SCAN_CGROUP_CHARGE_FAIL:
> >>> +			case SCAN_COPY_MC:
> >>> +			case SCAN_ADDRESS_RANGE:
> >>> +			case SCAN_NO_PTE_TABLE:
> >>> +			case SCAN_ANY_PROCESS:
> >>> +			case SCAN_VMA_NULL:
> >>> +			case SCAN_VMA_CHECK:
> >>> +			case SCAN_SCAN_ABORT:
> >>> +			case SCAN_PAGE_ANON:
> >>> +			case SCAN_PMD_MAPPED:
> >>> +			case SCAN_FAIL:
> >>> +			default:
> >>
> >> Agree with david, let's spell them out please :)
> >
> > I believe David is arguing for the opposite. To drop all these spelt out cases
> > and just leave the default case.
> >
> > @david is that correct or did I misunderstand that.
>
> Either spell all out (no default) OR add a default.
>
> I prefer to just ... use the default :)

I mean yup that's fine too I guess, all or nothing, something in between is
weird!

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
