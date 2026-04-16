Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06718389DFF;
	Thu, 16 Apr 2026 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324083; cv=none; b=SLohLAHMXqDKECFuk4ejIVxqZL/su4M9wdNPy1c50b8Ft0fVTm5823syK9mxxHRJ+Ug3djtTXqdsyW2mK4jNtJNT39oG749V/QANWkqrMhBxVE2kgPW5+UnWEKJVcJExDTVgiAl+d0DP4qQYSlbkDm9cPJPmrnERHRzbd05wwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324083; c=relaxed/simple;
	bh=0ymd9ycVrp8Bw35IXBADj2QEe35ENGWzHv22RoybH9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4WFhGofMjy0PJRaTnFiJr15jEgZQsMLDmA6iy22iZouaZysejUyg7gizKYZ506/MBl5ckdPGOQaJ1JxPaAuWNA+nssekcd0MM3WHYVvaZ9Zupa+0D3R4XPn2UFJ3xtLPj4HeZjhNXI32L5aHzkquFg7IiPFQnrpFXuS5l6lTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNufEJHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNufEJHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB97C2BCAF;
	Thu, 16 Apr 2026 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776324082;
	bh=0ymd9ycVrp8Bw35IXBADj2QEe35ENGWzHv22RoybH9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNufEJHE0To++g4VWWqZ+8sj2QU4KogfXr3w4jfj1OdfyL0UrxVoW+mbgM21ck+Cy
	 kcIHXm6KwL4/JKtcEHWeUZT5u7tC4yWaVRgYaM1V4BT3sWV9HufJvcoV3pFKMk0MuQ
	 vSWjwFgk+maDWtIICPeGVxnY0+x7Df2RY9obG+gNqGTSKfu2JmfZqe5VEbPItDp0kJ
	 tVgbRYElPoIgkQ9y2Jw2RrKT13TTr24n7gj9J9w5vDsJ7zVFVTssBbLnCNNmtPjNRD
	 M7k8hAgZbuQTmqaBk/ufG45TcPlngLq+vSASajVwMHNFXdcrbnzRGh3S4eU8mnl5Rk
	 Fsd++iBZlBTDw==
Date: Thu, 16 Apr 2026 08:21:07 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v15 07/13] mm/khugepaged: add per-order mTHP
 collapse failure statistics
Message-ID: <aeCFqEHaeO8dD11M@lucifer>
References: <20260226031741.230674-1-npache@redhat.com>
 <20260226032504.233594-1-npache@redhat.com>
 <c832d503-8b8c-487a-b61a-df74a3057308@lucifer.local>
 <CAA1CXcCS9gWySN1oQzEYpALfURxBwt58us9tkAbNPnHOKmLd5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcCS9gWySN1oQzEYpALfURxBwt58us9tkAbNPnHOKmLd5g@mail.gmail.com>

Ack on all below due to lower bandwidth :P

It's nothing really major here so don't let any of this block on respin!

Cheers, Lorenzo

On Sun, Apr 12, 2026 at 08:48:29PM -0600, Nico Pache wrote:
> On Tue, Mar 17, 2026 at 11:05 AM Lorenzo Stoakes (Oracle)
> <ljs@kernel.org> wrote:
> >
> > On Wed, Feb 25, 2026 at 08:25:04PM -0700, Nico Pache wrote:
> > > Add three new mTHP statistics to track collapse failures for different
> > > orders when encountering swap PTEs, excessive none PTEs, and shared PTEs:
> > >
> > > - collapse_exceed_swap_pte: Increment when mTHP collapse fails due to swap
> > >       PTEs
> > >
> > > - collapse_exceed_none_pte: Counts when mTHP collapse fails due to
> > >       exceeding the none PTE threshold for the given order
> > >
> > > - collapse_exceed_shared_pte: Counts when mTHP collapse fails due to shared
> > >       PTEs
> > >
> > > These statistics complement the existing THP_SCAN_EXCEED_* events by
> > > providing per-order granularity for mTHP collapse attempts. The stats are
> > > exposed via sysfs under
> > > `/sys/kernel/mm/transparent_hugepage/hugepages-*/stats/` for each
> > > supported hugepage size.
> > >
> > > As we currently dont support collapsing mTHPs that contain a swap or
> > > shared entry, those statistics keep track of how often we are
> > > encountering failed mTHP collapses due to these restrictions.
> > >
> > > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > Signed-off-by: Nico Pache <npache@redhat.com>
> > > ---
> > >  Documentation/admin-guide/mm/transhuge.rst | 24 ++++++++++++++++++++++
> > >  include/linux/huge_mm.h                    |  3 +++
> > >  mm/huge_memory.c                           |  7 +++++++
> > >  mm/khugepaged.c                            | 16 ++++++++++++---
> > >  4 files changed, 47 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> > > index c51932e6275d..eebb1f6bbc6c 100644
> > > --- a/Documentation/admin-guide/mm/transhuge.rst
> > > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > > @@ -714,6 +714,30 @@ nr_anon_partially_mapped
> > >         an anonymous THP as "partially mapped" and count it here, even though it
> > >         is not actually partially mapped anymore.
> > >
> > > +collapse_exceed_none_pte
> > > +       The number of collapse attempts that failed due to exceeding the
> > > +       max_ptes_none threshold. For mTHP collapse, Currently only max_ptes_none
> > > +       values of 0 and (HPAGE_PMD_NR - 1) are supported. Any other value will
> > > +       emit a warning and no mTHP collapse will be attempted. khugepaged will
> >
> > It's weird to document this here but not elsewhere in the document? I mean I
> > made this comment on the documentation patch also.
>
> I can add some more documentation but TBH I don't really know where or
> what else to put. I checked a few of these other per-mTHP stats, and
> none are referenced elsewhere. if anything these 3 additions are the
> best documented ones.
>
> >
> > Not sure if I missed you adding it to another bit of the docs? :)
> >
> > > +       try to collapse to the largest enabled (m)THP size; if it fails, it will
> > > +       try the next lower enabled mTHP size. This counter records the number of
> > > +       times a collapse attempt was skipped for exceeding the max_ptes_none
> > > +       threshold, and khugepaged will move on to the next available mTHP size.
> > > +
> > > +collapse_exceed_swap_pte
> > > +       The number of anonymous mTHP PTE ranges which were unable to collapse due
> > > +       to containing at least one swap PTE. Currently khugepaged does not
> > > +       support collapsing mTHP regions that contain a swap PTE. This counter can
> > > +       be used to monitor the number of khugepaged mTHP collapses that failed
> > > +       due to the presence of a swap PTE.
> > > +
> > > +collapse_exceed_shared_pte
> > > +       The number of anonymous mTHP PTE ranges which were unable to collapse due
> > > +       to containing at least one shared PTE. Currently khugepaged does not
> > > +       support collapsing mTHP PTE ranges that contain a shared PTE. This
> > > +       counter can be used to monitor the number of khugepaged mTHP collapses
> > > +       that failed due to the presence of a shared PTE.
> >
> > All of these talk about 'ranges' that could be of any size. Are these useful
> > metrics? Counting a bunch of failures and not knowing if they are 256 KB
> > failures or 16 KB failures or whatever is maybe not so useful information?
>
> These are per-mTHP size statistics. If you look at the surrounding
> examples and docs this all makes more sense.
>
> >
> > Also, from the code, aren't you treating PMD events the same as mTHP ones from
> > the point of view of these counters? Maybe worth documenting that?
>
> IIUC, yes but that is true of all these
>
> ```
> In /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/stats, There are
> also individual counters for each huge page size, which can be utilized to
> monitor the system's effectiveness in providing huge pages for usage. Each
> counter has its own corresponding file.
> ```
>
> >
> > > +
> > >  As the system ages, allocating huge pages may be expensive as the
> > >  system uses memory compaction to copy data around memory to free a
> > >  huge page for use. There are some counters in ``/proc/vmstat`` to help
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index 9941fc6d7bd8..e8777bb2347d 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -144,6 +144,9 @@ enum mthp_stat_item {
> > >       MTHP_STAT_SPLIT_DEFERRED,
> > >       MTHP_STAT_NR_ANON,
> > >       MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> > > +     MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> > > +     MTHP_STAT_COLLAPSE_EXCEED_NONE,
> > > +     MTHP_STAT_COLLAPSE_EXCEED_SHARED,
> > >       __MTHP_STAT_COUNT
> > >  };
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 228f35e962b9..1049a207a257 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -642,6 +642,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> > >  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> > >  DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
> > >  DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
> > > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
> > > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEED_NONE);
> > > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
> >
> > Is there a reason there's such a difference between the names and the actual
> > enum names?
>
> Good point I didnt think about that. I can update those as long as
> they don't conflict with something else (I forget why i named them
> like this).
>
> >
> > > +
> > >
> > >  static struct attribute *anon_stats_attrs[] = {
> > >       &anon_fault_alloc_attr.attr,
> > > @@ -658,6 +662,9 @@ static struct attribute *anon_stats_attrs[] = {
> > >       &split_deferred_attr.attr,
> > >       &nr_anon_attr.attr,
> > >       &nr_anon_partially_mapped_attr.attr,
> > > +     &collapse_exceed_swap_pte_attr.attr,
> > > +     &collapse_exceed_none_pte_attr.attr,
> > > +     &collapse_exceed_shared_pte_attr.attr,
> > >       NULL,
> > >  };
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index c739f26dd61e..a6cf90e09e4a 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -595,7 +595,9 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >                               continue;
> > >                       } else {
> > >                               result = SCAN_EXCEED_NONE_PTE;
> > > -                             count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> > > +                             if (is_pmd_order(order))
> > > +                                     count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> > > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
> >
> > It's a bit gross to have separate stats for both thp and mthp but maybe
> > unavoidable from a legacy stand point.
>
> I agree but that's how it currently is. Perhaps we can add this to the
> TODO list for THP work.
>
> >
> > Why are we dropping the _PTE suffix?
>
> I follow the convention that the other mTHP stats follow for example
> (MTHP_STAT_SPLIT_DEFERRED)
>
> >
> > >                               goto out;
> > >                       }
> > >               }
> > > @@ -631,10 +633,17 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >                        * shared may cause a future higher order collapse on a
> > >                        * rescan of the same range.
> > >                        */
> > > -                     if (!is_pmd_order(order) || (cc->is_khugepaged &&
> > > -                         shared > khugepaged_max_ptes_shared)) {
> >
> > OK losing track here :) as the series sadly doesn't currently apply so can't
> > browser file as is.
> >
> > In the code I'm looking at, there's also a ++shared here that I guess another
> > patch removed?
> >
> > Is this in the folio_maybe_mapped_shared() branch?
>
> yes the counting is now done at the top of that branch.
>
> >
> > > +                     if (!is_pmd_order(order)) {
> > > +                             result = SCAN_EXCEED_SHARED_PTE;
> > > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
> > > +                             goto out;
> > > +                     }
> > > +
> > > +                     if (cc->is_khugepaged &&
> > > +                         shared > khugepaged_max_ptes_shared) {
> > >                               result = SCAN_EXCEED_SHARED_PTE;
> > >                               count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
> > > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
> > >                               goto out;
> >
> > Anyway I'm a bit lost on this logic until a respin but this looks like a LOT of
> > code duplication. I see David alluded to a refactoring so maybe what he suggests
> > will help (not had a chance to check what it is specifically :P)
>
> Yep :) should look cleaner in the next one. Although it's quite a bit
> of refactoring. I'll be praying that i got it right on the first go,
> and I put all the other pieces in the desired spot.
>
> >
> > >                       }
> > >               }
> > > @@ -1081,6 +1090,7 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
> > >                * range.
> > >                */
> > >               if (!is_pmd_order(order)) {
> > > +                     count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
> >
> > Hmm I thought we were incrementing mthp stats for pmd sized also?
>
> Yes we are supposed to. I've already refactored and it looks fine
> there... perhaps i missed this one in this version!
>
> Cheers,
>
> -- Nico
>
> >
> > >                       pte_unmap(pte);
> > >                       mmap_read_unlock(mm);
> > >                       result = SCAN_EXCEED_SWAP_PTE;
> > > --
> > > 2.53.0
> > >
> >
> > Cheers, Lorenzo
> >
>
