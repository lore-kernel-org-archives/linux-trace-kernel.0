Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28732391846;
	Mon, 18 May 2026 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132786; cv=none; b=EF+aVlUiEddfkMXJ2ho88t2mWd6UQ6rkeXDYJqTFbNHM/Ny5BtQ8wV9OFaeMopaK8/Yv9FbHv9Bg7PvyUeNUNKUmRpFXtntcs8DLXpCxFdsBq5Puz+4EfLX9N/pgRYWcUh5GsctPx6qXF9vCZbijFIGKxfsiOLabVSzxTa+VG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132786; c=relaxed/simple;
	bh=YkGCI2ydQOiH18bfYuav9c9v7raj6NjUh/q2u2zqGQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+guBRHnkVhy7W089AsW1Idu3YKA25J/4r+efwUBegaBIHeOq8JEJDHyQ19zJWBGf2VBX3IJ7xpv0a+OmgpVo3S3Mp22Onoo9cLVvrR9bclGPkQCSyIM/Gcmr/BqWo4wwRZ1ZmWmRgN/Or9Is3SvwtsLg/tpwup17Rx7eBJfy64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDmvFmZ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDmvFmZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D75C2BCC6;
	Mon, 18 May 2026 19:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132785;
	bh=YkGCI2ydQOiH18bfYuav9c9v7raj6NjUh/q2u2zqGQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDmvFmZ+iTrW6rG0Gcm9nWDPvvRK1Rsj48dFtKprQeQ1e6lYyM5VMFRhBpg8rwS61
	 0TNXTtczIM+BVYe4dk6R82ZVaWwaFbuN+I3al6alVhDH1MljGD3eYqKFw/QXi7Qvm0
	 JKoE6kG5Db51dOjr9Juw7dqsEFy3nED8MYgsGtG2paTjp5kcRM6tNacnnxJWHErq5S
	 M8Qrai0JHOMsBE7ZTTpOx6tIkJOYjnAKZFKHD4doWsSaZi9ZYNp4SbjR5D1f4rsOHj
	 H3beDvWRIUdalnXZNIQ+HM/9w5MnR/fIEerEMaPESJ8Zc3zgsQGlP1eDVwfo09KpCR
	 ofuvouMs7WwgQ==
Date: Mon, 18 May 2026 20:32:50 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, 
	Lance Yang <lance.yang@linux.dev>, npache@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com, 
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v17 04/14] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
Message-ID: <agtpK1x27B-E7mMo@lucifer>
References: <20260511185817.686831-5-npache@redhat.com>
 <20260512074202.10253-1-lance.yang@linux.dev>
 <20260514031009.f66cgop3ctgiqxz3@master>
 <9b33339e-157a-45b7-942e-3be3418a5142@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b33339e-157a-45b7-942e-3be3418a5142@kernel.org>

On Mon, May 18, 2026 at 03:16:11PM +0200, David Hildenbrand (Arm) wrote:
> On 5/14/26 05:10, Wei Yang wrote:
> > On Tue, May 12, 2026 at 03:42:02PM +0800, Lance Yang wrote:
> >>
> >> On Mon, May 11, 2026 at 12:58:04PM -0600, Nico Pache wrote:
> >>> generalize the order of the __collapse_huge_page_* and collapse_max_*
> >>> functions to support future mTHP collapse.
> >>>
> >>> The current mechanism for determining collapse with the
> >>> khugepaged_max_ptes_none value is not designed with mTHP in mind. This
> >>> raises a key design issue: if we support user defined max_pte_none values
> >>> (even those scaled by order), a collapse of a lower order can introduces
> >>> an feedback loop, or "creep", when max_ptes_none is set to a value greater
> >>> than HPAGE_PMD_NR / 2. [1]
> >>>
> >>> With this configuration, a successful collapse to order N will populate
> >>> enough pages to satisfy the collapse condition on order N+1 on the next
> >>> scan. This leads to unnecessary work and memory churn.
> >>>
> >>> To fix this issue introduce a helper function that will limit mTHP
> >>> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
> >>> This effectively supports two modes: [2]
> >>>
> >>> - max_ptes_none=0: never collapses if it encounters an empty PTE or a PTE
> >>>  that maps the shared zeropage. Consequently, no memory bloat.
> >>> - max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
> >>>  available mTHP order.
> >>>
> >>> This removes the possiblilty of "creep", while not modifying any uAPI
> >>> expectations. A warning will be emitted if any non-supported
> >>> max_ptes_none value is configured with mTHP enabled.
> >>>
> >>> mTHP collapse will not honor the khugepaged_max_ptes_shared or
> >>> khugepaged_max_ptes_swap parameters, and will fail if it encounters a
> >>> shared or swapped entry.
> >>>
> >>> No functional changes in this patch; however it defines future behavior
> >>> for mTHP collapse.
> >>>
> >>> [1] - https://lore.kernel.org/all/e46ab3ab-a3d7-4fb7-9970-d0704bd5d05a@arm.com
> >>> [2] - https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@redhat.com
> >>>
> >>> Co-developed-by: Dev Jain <dev.jain@arm.com>
> >>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> >>> Signed-off-by: Nico Pache <npache@redhat.com>
> >>> ---
> >>> include/trace/events/huge_memory.h |   3 +-
> >>> mm/khugepaged.c                    | 117 ++++++++++++++++++++---------
> >>> 2 files changed, 85 insertions(+), 35 deletions(-)
> >>>
> >>> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> >>> index bcdc57eea270..443e0bd13fdb 100644
> >>> --- a/include/trace/events/huge_memory.h
> >>> +++ b/include/trace/events/huge_memory.h
> >>> @@ -39,7 +39,8 @@
> >>> 	EM( SCAN_STORE_FAILED,		"store_failed")			\
> >>> 	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
> >>> 	EM( SCAN_PAGE_FILLED,		"page_filled")			\
> >>> -	EMe(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")
> >>> +	EM(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")	\
> >>> +	EMe(SCAN_INVALID_PTES_NONE,	"invalid_ptes_none")
> >>>
> >>> #undef EM
> >>> #undef EMe
> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>> index f68853b3caa7..27465161fa6d 100644
> >>> --- a/mm/khugepaged.c
> >>> +++ b/mm/khugepaged.c
> >>> @@ -61,6 +61,7 @@ enum scan_result {
> >>> 	SCAN_COPY_MC,
> >>> 	SCAN_PAGE_FILLED,
> >>> 	SCAN_PAGE_DIRTY_OR_WRITEBACK,
> >>> +	SCAN_INVALID_PTES_NONE,
> >>> };
> >>>
> >>> #define CREATE_TRACE_POINTS
> >>> @@ -353,37 +354,60 @@ static bool pte_none_or_zero(pte_t pte)
> >>>  * PTEs for the given collapse operation.
> >>>  * @cc: The collapse control struct
> >>>  * @vma: The vma to check for userfaultfd
> >>> + * @order: The folio order being collapsed to
> >>>  *
> >>>  * Return: Maximum number of none-page or zero-page PTEs allowed for the
> >>>  * collapse operation.
> >>>  */
> >>> -static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
> >>> -		struct vm_area_struct *vma)
> >>> +static int collapse_max_ptes_none(struct collapse_control *cc,
> >>> +		struct vm_area_struct *vma, unsigned int order)
> >>> {
> >>> +	unsigned int max_ptes_none = khugepaged_max_ptes_none;
> >>> 	// If the vma is userfaultfd-armed, allow no none-page or zero-page PTEs.
> >>
> >> One thing I still want to call out: kernel code usually uses C-style
> >> comments :)
> >>
> >>> 	if (vma && userfaultfd_armed(vma))
> >>> 		return 0;
> >>> 	// for MADV_COLLAPSE, allow any none-page or zero-page PTEs.
> >>> 	if (!cc->is_khugepaged)
> >>> 		return HPAGE_PMD_NR;
> >>> -	// For all other cases repect the user defined maximum.
> >>> -	return khugepaged_max_ptes_none;
> >>> +	// for PMD collapse, respect the user defined maximum.
> >>> +	if (is_pmd_order(order))
> >>> +		return max_ptes_none;
> >>> +	/* Zero/non-present collapse disabled. */
> >>> +	if (!max_ptes_none)
> >>> +		return 0;
> >>> +	// for mTHP collapse with the sysctl value set to KHUGEPAGED_MAX_PTES_LIMIT,
> >>> +	// scale the maximum number of PTEs to the order of the collapse.
> >>> +	if (max_ptes_none == KHUGEPAGED_MAX_PTES_LIMIT)
> >>> +		return (1 << order) - 1;
> >>> +
> >>> +	// We currently only support max_ptes_none values of 0 or KHUGEPAGED_MAX_PTES_LIMIT.
> >>> +	// Emit a warning and return -EINVAL.
> >>> +	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %u\n",
> >>> +		      KHUGEPAGED_MAX_PTES_LIMIT);
> >>
> >> Maybe fallback to 0 instead, as David suggested earlier?
> >>
> >
> > It looks reasonable to fallback to 0.
> >
> > But as the updated Document says in patch 14:
> >
> >   For mTHP collapse, only 0 or (HPAGE_PMD_NR - 1) are supported. Any other
> >   value will emit a warning and no mTHP collapse will be attempted.
> >
> > This is why it does like this now.
> >
> >     mthp_collapse()
> >         max_ptes_none = collapse_max_ptes_none();
> >         if (max_ptes_none < 0)
> >             return collapsed;
> >
> >> max_ptes_none is mostly legacy PMD THP behavior. mTHP is new, and any
> >> intermediate value in (0, KHUGEPAGED_MAX_PTES_LIMIT) would implicitly
> >> disable it :(
> >>
> >
> > So it depends on what we want to do here :-)
> >
> > For me, I would vote for fallback to 0.
>
> At this point I'll prefer to not return errors from collapse_max_ptes_none().
> It's just rather awkward to return an error deep down in collapse code for a
> configuration problem.
>
> For mthp collapse, we only support max_ptes_none==0 and
> max_ptes_none=="HPAGE_PMD_NR - 1" (default).
>
> If another value is specified while collapsing mTHP, print a warning and treat
> it as 0 (save value, no creep, no memory waste).
>
> In a sense, this is similar to how we handle max_ptes_shared + max_ptes_swap:
> for mTHP: we always treat them as being 0 for mTHP collapse (and don't issue a
> warning, because we would issue a warning with the default settings).
>
> @Lorenzo, fine with you?

Yes 100%, this sounds sensible both in terms of the error and the default. Let's
keep our lives simple(-ish) please :)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
