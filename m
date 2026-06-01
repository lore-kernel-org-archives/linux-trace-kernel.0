Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040826299;
	Mon,  1 Jun 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324551; cv=none; b=HDOlMPiSfjgF+SWFN84Bm73NdiFjC3BqzH3SmvkJ7MIIiF6dyP/3v/8Zn+jK9TF1DSG4iCpRuaGOkv7V9aiQkcaxoUBGZwiiklBftIkPg8wfrBM+uEAtuzI7hTw39Ueo+mcIkuQUdsq/WuIWrLONvM57ea7Cw/7LtzFmVS4HWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324551; c=relaxed/simple;
	bh=2aXBd3RQ2js8Jg9kVrExCOqCBxa3AsqaoHUncACrj8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfFHjHzDdMFvSIh1YONbenNkHLTXPySFeAQVMk8809zjE2aJuAsDo0NbZ2c+GYfIv6UEYwfwmPC7O0cQG3D/VMbjtais/KSWL4IUJh4UVupg6aWtDeKBsZM33o19XLVOPbMv3s5hHygTwVbUGaesUqK3nh+SKP7tsQfjh0ROqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYC69qu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYC69qu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E93B1F00893;
	Mon,  1 Jun 2026 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324550;
	bh=tYOOpvy9IkMZmwJi6amy7zUop+0VBeSC22/cOh/2QJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZYC69qu/CF9Gne0HL5HBrmA8/pzxabQLTF+YrpZEVBUNIzPQ1W/hUAkrxAMdOvJ5u
	 nERvqAIkhWNvzPn7WmgBDQStrasNyXBPZuCje2J4ksp3Y3rjjHV2nyEe5tLrnF8pGe
	 E3v7Ezg1LNwZ5hmDVltmBNckcIAVQTQyiZy7TI0VESefwi/orLXZoXtWnl4qdWLwqd
	 W2yLpGG9p47NxTV7MMalaw+DLrMRiBDZnRbqDyGjGeOL6ST5M7AWoAuCkxGhOf7wTA
	 UyrJ6zw4DT6Q8SBcCTwkE2xtbQpk+Q3Zju/GbdPrgYB/nGfnBbtNE/DccLJP4smclf
	 vzd6q1MNqigtQ==
Date: Mon, 1 Jun 2026 15:35:35 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com, 
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 10/14] mm/khugepaged: introduce
 collapse_allowable_orders helper function
Message-ID: <ah2UhZb9EYgYxj1F@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-11-npache@redhat.com>
 <b7ddff01-9adf-4ff7-84a6-021087936c34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ddff01-9adf-4ff7-84a6-021087936c34@kernel.org>

On Sun, May 31, 2026 at 10:18:16PM +0200, David Hildenbrand (Arm) wrote:
> On 5/22/26 17:00, Nico Pache wrote:
> > Add collapse_allowable_orders() to generalize THP order eligibility. The
> > function determines which THP orders are permitted based on collapse
> > context (khugepaged vs madv_collapse).
> >
> > This consolidates collapse configuration logic and provides a clean
> > interface for future mTHP collapse support where the orders may be
> > different.
>
> It would have been good to describe here that, for now, it only ever returns
> PMDs, and that it will be extended next.
>
> Logically, this patch belongs to #12, not #11 ... so seeing it before #11 was a bit
>
> ... and there, it is clear that we don't even want to know the orders?
>
> So can we just call this function
>
> "collapse_possible" and make it return a boolean?

Yeah agreed.

But I also don't love the naming, we now have thp_vma_allowable_orders(),
__thp_vma_allowable_orders(), and then collapse_allowable_orders() and we also
have 3 different ways of collapsing, one of which we call MADV_... COLLAPSE,
and the other khugepaged + fault-in too for laughs.

It's like a big circle of confusion.

And of course we call THP collapse 'collapse' in general, so :)

Anyway I'm fine with collapse_possible() so we can move on and then maybe
cleanup later.

Also - if I look at khugepaged.c I see thp_vma_allowable_orders() still used in
hugepage_vma_revalidate().

Wouldn't it be better then to do the abstraction once mTHP order checking is
properly introduced and change this also and have _every_ order check be
consistent in khugepaged.c?

>
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 4534025bc81d..64ceebc9d8a7 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -552,12 +552,21 @@ void __khugepaged_enter(struct mm_struct *mm)
> >  		wake_up_interruptible(&khugepaged_wait);
> >  }
> >
> > +/* Check what orders are allowed based on the vma and collapse type */

I'd expand this comment to explain that it's explicitly for accounting for
whether mTHP is used, but that also argues for this to be moved to a later
commit as David says.

Otherwise the comment is useless.

> > +static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
> > +		vm_flags_t vm_flags, enum tva_type tva_flags)
> > +{
> > +	unsigned long orders = BIT(HPAGE_PMD_ORDER);

Could be a const also.

> > +
> > +	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
> > +}
> > +
> >  void khugepaged_enter_vma(struct vm_area_struct *vma,
> >  			  vm_flags_t vm_flags)
> >  {
> >  	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> >  	    hugepage_pmd_enabled()) {
> > -		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> > +		if (collapse_allowable_orders(vma, vm_flags, TVA_KHUGEPAGED))

I hate that we separate out the VMA flags like this just for this case, but
that's something for a follow up probably from me as part of a VMA flags
conversion series...

> >  			__khugepaged_enter(vma->vm_mm);
> >  	}
> >  }
> > @@ -2680,7 +2689,7 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
> >  			cc->progress++;
> >  			break;
> >  		}
> > -		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
> > +		if (!collapse_allowable_orders(vma, vma->vm_flags, TVA_KHUGEPAGED)) {
> >  			cc->progress++;
> >  			continue;
> >  		}
> > @@ -2989,7 +2998,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
> >  	BUG_ON(vma->vm_start > start);
> >  	BUG_ON(vma->vm_end < end);
> >
> > -	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
> > +	if (!collapse_allowable_orders(vma, vma->vm_flags, TVA_FORCED_COLLAPSE))
> >  		return -EINVAL;
> >
> >  	cc = kmalloc_obj(*cc);
>
> Having a simple
>
> static bool collapse_possible(...)
> {
> 	return collapse_allowable_orders(...)
> }
>
> Would make the above slightly more readable.

Yup.

>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>
> --
> Cheers,
>
> David

Cheers, Lorenzo
