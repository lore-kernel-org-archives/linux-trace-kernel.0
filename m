Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588D39F160
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995950; cv=none; b=i8SZe+sDo9y5uLJskdNH939Abh5iX/DBgVfWy8B58z+nifsWJtACBIZoOQPCGizd1NogDZYtqBJo+qTjBIZS00IJZG6D5y72pkw0GXzA9Wjl/EvoC5qbvwFhlBhsRCmd/s9Af4HKtsdukrwysQx8hFQZAVJuxuPGK/F8QBV+d6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995950; c=relaxed/simple;
	bh=WYcC9vDs417GY/BpPGgXkSdMiE6T1BRyzU+3J0qq6Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jfoh9ZZDImCKVxWzp7htpculCvcDEpcJcmmS1Ukzg1aYgaNb79b3wFFQIU8NDh4iKytC4Dab/AbCku7KQI5rZrD99RBeEKs3KT5ncUGv8b0COnsWxifg7e6+LXz/RH/ZLI/wxUmE2ZLgzhRGEKTPrFABxA0c5GTWKGG8RKwaRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPyyZNEp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPyyZNEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780995947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wxr1O8JNsfK2/FvtzBM7LZ4zEH7+MeXY2kg9gcsAEbU=;
	b=IPyyZNEp40aor8Mh9UjPjnZ7oWf4e9cpGBZvT7EMhoH8iIJmERz4E3YEK76pzNdL/rv7tf
	0F1XPhRGFkQy2YYBEHgnmwQN4EjsgWOpd2DOeO21KLSXxZPiovIialMyLcPnpxbiN4kJNw
	Gucq2Mwo1defiGBHcVUNl8mRVmSaQaE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-kzdpnFzRPm6L1jefC34xWw-1; Tue, 09 Jun 2026 05:05:42 -0400
X-MC-Unique: kzdpnFzRPm6L1jefC34xWw-1
X-Mimecast-MFC-AGG-ID: kzdpnFzRPm6L1jefC34xWw_1780995942
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7efaace4bdcso46530207b3.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 02:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995942; x=1781600742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wxr1O8JNsfK2/FvtzBM7LZ4zEH7+MeXY2kg9gcsAEbU=;
        b=SzuXusTgNCKdk1u844Sv6TDE+47ai/SHaPH7VbjF20S7uuAozhIL3IwKl74Kt72jiX
         +I6DM8Tfo6sj9X/yXx3h+BuGCI1u+MzOI34GKvKJHL8wyb3MqP+JB+rRxoHGhPRaDxly
         ptmr+B/14RyFXbD5558Z9UybV1xpdApQPLu9KYYUTTX2foTaZo88dbIArk+RcZfh1Qkh
         CGgoSViM2sTXurkvF9rZohx9GGlol3RF3eVsHVtLBPMOZoA7bjyYvSPSgJa6qvsAiouj
         aDDNGLr1bWfpHemNyQRHEZTWVorqATOHqTfHANucrQ49SJZAdUVLQNm5eoC5NBVyj4ln
         3EJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iz0eteYfiYr7ujYmpk20sXOubKHcyvwa/8fQYc6ObHRU/wCKoPA3HZx4ct9zLEfZ6J2IHm1an/FfDhNyiR49QNEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrIToZcsOkoZLDgW+BKxFn8t6DMWwpFcE7P2HpkT6bJqGkUi4
	GKZE6Irzlt8zNaN+SivP2s/lr7c1ooErXZXRQr30IJw9YLHrX6s1V03rY34CTZDknWkzii/xGyT
	IAwv/X7JWhJ2pQqPG6avw7KS5za7eKQ9ygiOPdXQa1KPNEiVB47fJ2REu4M3B8y4gPGQqBYPrgm
	lZm2Hl/BnCJKoWEZ6ggSyPfoj7S0iwJqQTzKD5xRmo2gf7Snhj
X-Gm-Gg: Acq92OFxR3KahMC211p/qawNwJVznlp3gBAZTv1ADfQhU4c1N8FxyfG2qiXjNE/fh9w
	JLWyNdLhhHtDi6CjA3SgywB4H7iT6VHKlXjtOJLptd2eXFFcfC9L3yVzLzJgigOR2mq0MNx4gTM
	lvskQiAct68kcnuHEBJWKXu758xLrkZ15X1yijobeVG/yfuZMY1ZBJGr3x+Aog3HTWYXn11hsgd
	2J4oscCyFiFqJgp
X-Received: by 2002:a05:690e:4190:b0:660:62e5:92c9 with SMTP id 956f58d0204a3-661070cd438mr15281240d50.63.1780995941964;
        Tue, 09 Jun 2026 02:05:41 -0700 (PDT)
X-Received: by 2002:a05:690e:4190:b0:660:62e5:92c9 with SMTP id
 956f58d0204a3-661070cd438mr15281195d50.63.1780995941422; Tue, 09 Jun 2026
 02:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605161422.213817-12-npache@redhat.com> <20260606102800.26940-1-lance.yang@linux.dev>
 <2553caae-9e0e-42a7-8b61-d1216f1e81fa@kernel.org>
In-Reply-To: <2553caae-9e0e-42a7-8b61-d1216f1e81fa@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Tue, 9 Jun 2026 03:06:27 -0600
X-Gm-Features: AVVi8CdL9z1ryjSRfDfxfMh1RqlVgMHDGw_iSqBSnBDCj2SVI6kmrVDBphqzbx8
Message-ID: <CAA1CXcBY_2372eJru8VoCq90rUMxn7w23hHou68MmXRv48NRXg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v19 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: "David Hildenbrand (Arm)" <david@kernel.org>, Lance Yang <lance.yang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: onVKB0VsUCm7iFheKpJrdcoNK88U-j-qAYp6f2bLhZU_1780995942
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:57=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 6/6/26 12:28, Lance Yang wrote:
> >
> > On Fri, Jun 05, 2026 at 10:14:18AM -0600, Nico Pache wrote:
> >> Enable khugepaged to collapse to mTHP orders. This patch implements th=
e
> >> main scanning logic using a bitmap to track occupied pages and the
> >> algorithm to find optimal collapse sizes.
> >>
> >> Previous to this patch, PMD collapse had 3 main phases, a light weight
> >> scanning phase (mmap_read_lock) that determines a potential PMD
> >> collapse, an alloc phase (mmap unlocked), then finally heavier collaps=
e
> >> phase (mmap_write_lock).
> >>
> >> To enabled mTHP collapse we make the following changes:
> >>
> >> During PMD scan phase, track occupied pages in a bitmap. When mTHP
> >> orders are enabled, we remove the restriction of max_ptes_none during =
the
> >> scan phase to avoid missing potential mTHP collapse candidates. Once w=
e
> >> have scanned the full PMD range and updated the bitmap to track occupi=
ed
> >> pages, we use the bitmap to find the optimal mTHP size.
> >>
> >> Implement mthp_collapse() to walk forward through the bitmap and
> >> determine the best eligible order for each naturally-aligned region. T=
he
> >> algorithm starts at the beginning of the PMD range and, for each offse=
t,
> >> tries the highest order that fits the alignment. If the number of
> >> occupied PTEs in that region satisfies the max_ptes_none threshold for
> >> that order, a collapse is attempted. On failure, the order is
> >> decremented and the same offset is retried at the next smaller size. O=
nce
> >> the smallest enabled order is exhausted (or a collapse succeeds), the
> >> offset advances past the region just processed, and the next attempt
> >> starts at the highest order permitted by the new offset's natural
> >> alignment.
> >>
> >> The algorithm works as follows:
> >>    1) set offset=3D0 and order=3DHPAGE_PMD_ORDER
> >>    2) if the order is not enabled, go to step (5)
> >>    3) count occupied PTEs in the (offset, order) range using
> >>       bitmap_weight_from()
> >>    4) if the count satisfies the max_ptes_none threshold, attempt
> >>       collapse; on success, advance to step (6)
> >>    5) if a smaller enabled order exists, decrement order and retry
> >>       from step (2) at the same offset
> >>    6) advance offset past the current region and compute the next
> >>       order from the new offset's natural alignment via __ffs(offset),
> >>       capped at HPAGE_PMD_ORDER
> >>    7) repeat from step (2) until the full PMD range is covered
> >>
> >> mTHP collapses reject regions containing swapped out or shared pages.
> >> This is because adding new entries can lead to new none pages, and the=
se
> >> may lead to constant promotion into a higher order mTHP. A similar
> >> issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collaps=
e
> >> introducing at least 2x the number of pages, and on a future scan will
> >> satisfy the promotion condition once again. This issue is prevented vi=
a
> >> the collapse_max_ptes_none() function which imposes the max_ptes_none
> >> restrictions above.
> >>
> >> We currently only support mTHP collapse for max_ptes_none values of 0
> >> and HPAGE_PMD_NR - 1. resulting in the following behavior:
> >>
> >>    - max_ptes_none=3D0: Never introduce new empty pages during collaps=
e
> >>    - max_ptes_none=3DHPAGE_PMD_NR-1: Always try collapse to the highes=
t
> >>      available mTHP order
> >>
> >> Any other max_ptes_none value will emit a warning and default mTHP
> >> collapse to max_ptes_none=3D0. There should be no behavior change for =
PMD
> >> collapse.
> >>
> >> Once we determine what mTHP sizes fits best in that PMD range a collap=
se
> >> is attempted. A minimum collapse order of 2 is used as this is the low=
est
> >> order supported by anon memory as defined by THP_ORDERS_ALL_ANON.
> >>
> >> Currently madv_collapse is not supported and will only attempt PMD
> >> collapse.
> >>
> >> We can also remove the check for is_khugepaged inside the PMD scan as
> >> the collapse_max_ptes_none() function handles this logic now.
> >>
> >> Signed-off-by: Nico Pache <npache@redhat.com>
> >> ---
> >> mm/khugepaged.c | 146 +++++++++++++++++++++++++++++++++++++++++++++---
> >> 1 file changed, 138 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index ec886a031952..430047316f43 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -99,6 +99,8 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, M=
M_SLOTS_HASH_BITS);
> >>
> >> static struct kmem_cache *mm_slot_cache __ro_after_init;
> >>
> >> +#define KHUGEPAGED_MIN_MTHP_ORDER   2
> >> +
> >> struct collapse_control {
> >>      bool is_khugepaged;
> >>
> >> @@ -110,6 +112,9 @@ struct collapse_control {
> >>
> >>      /* nodemask for allocation fallback */
> >>      nodemask_t alloc_nmask;
> >> +
> >> +    /* Each bit represents a single occupied (!none/zero) page. */
> >> +    DECLARE_BITMAP(mthp_present_ptes, MAX_PTRS_PER_PTE);
> >> };
> >>
> >> /**
> >> @@ -1440,20 +1445,130 @@ static enum scan_result collapse_huge_page(st=
ruct mm_struct *mm, unsigned long s
> >>      return result;
> >> }
> >>
> >> +/* Return the highest naturally aligned order that fits at @offset wi=
thin a PMD. */
> >> +static unsigned int max_order_from_offset(unsigned int offset)
> >> +{
> >> +    if (offset =3D=3D 0)
> >> +            return HPAGE_PMD_ORDER;
> >> +
> >> +    return min_t(unsigned int, __ffs(offset), HPAGE_PMD_ORDER);
> >> +}
> >> +
> >> +/*
> >> + * mthp_collapse() consumes the bitmap that is generated during
> >> + * collapse_scan_pmd() to determine what regions and mTHP orders fit =
best.
> >> + *
> >> + * Each bit in cc->mthp_present_ptes represents a single occupied (!n=
one/zero)
> >> + * page. We start at the PMD order and check if it is eligible for co=
llapse;
> >> + * if not, we check the left and right halves of the PTE page table w=
e are
> >> + * examining at a lower order.
> >> + *
> >> + * For each of these, we determine how many PTE entries are occupied =
in the
> >> + * range of PTE entries we propose to collapse, then we compare this =
to a
> >> + * threshold number of PTE entries which would need to be occupied fo=
r a
> >> + * collapse to be permitted at that order (accounting for max_ptes_no=
ne).
> >> + *
> >> + * If a collapse is permitted, we attempt to collapse the PTE range i=
nto a
> >> + * mTHP.
> >> + */
> >> +static enum scan_result mthp_collapse(struct mm_struct *mm,
> >> +            unsigned long address, int referenced, int unmapped,
> >> +            struct collapse_control *cc, unsigned long enabled_orders=
)
> >> +{
> >> +    unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
> >> +    enum scan_result last_result =3D SCAN_FAIL;
> >> +    int collapsed =3D 0;
> >> +    bool alloc_failed =3D false;
> >> +    unsigned long collapse_address;
> >> +    unsigned int offset =3D 0;
> >> +    unsigned int order =3D HPAGE_PMD_ORDER;
> >> +
> >> +    while (offset < HPAGE_PMD_NR) {
> >> +            nr_ptes =3D 1UL << order;
> >> +
> >> +            if (!test_bit(order, &enabled_orders))
> >> +                    goto next_order;
> >> +
> >> +            max_ptes_none =3D collapse_max_ptes_none(cc, NULL, order)=
;
> >> +            nr_occupied_ptes =3D bitmap_weight_from(cc->mthp_present_=
ptes, offset,
> >> +                                                  offset + nr_ptes);
> >> +
> >> +            if (nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
> >
> > Looks broken for swap PTEs in PMD collapse ...
> >
> > collapse_scan_pmd() allows them up to max_ptes_swap and record them in
> > unmapped, but they don't get a bit in mthp_present_ptes. And then
> > mthp_collapse() does the check above:
>
> Right. I assumed this is implicitly handled by the optimization in collap=
se_scan_pmd:
>
>         if (enabled_orders !=3D BIT(HPAGE_PMD_ORDER))
>                 max_ptes_none =3D KHUGEPAGED_MAX_PTES_LIMIT;
>
> But we perform the check a second time.
>
> >
> > nr_occupied_ptes >=3D nr_ptes - max_ptes_none
> >
> > So max_ptes_none=3D0 + 511 present PTEs + one allowed swap PTE won't ev=
en
> > call collapse_huge_page() for PMD order.
> >
> > Shouldn't we account for them in the PMD-order check? Something like:
> >
> > if (is_pmd_order(order))
> >       nr_occupied_ptes +=3D unmapped;

This solution seems good for a temporary fixup. but longterm we may
want something else. I'm still not sure how we plan on supporting
swapin without causing creep. So I'd be ok with adding a fix for
legacy PMD behavior until we know how to handle mTHP creep correctly.

> As an alternative, we could either 1) skip the check there for
> pmd order (as the check was already done); or 2) introduce+maintain
> a bitmap that tracks non-present PTEs.
>
> @@ -1475,7 +1477,9 @@ static enum scan_result mthp_collapse(struct mm_str=
uct *mm,
>                 nr_occupied_ptes =3D bitmap_weight_from(cc->mthp_present_=
ptes, offset,
>                                                       offset + nr_ptes);
>
> -               if (nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
> +               /* Check was already done in the caller. */
> +               if (is_pmd_order(order) ||
> +                   nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
>                         enum scan_result ret;
>
>                         collapse_address =3D address + offset * PAGE_SIZE=
;
>
> 2) would probably be cleanest long-term.

That would be best for future swapin support in mTHP, but I still
don't think it solves the creep issue. Perhaps we could combine the
two bitmaps to determine if it would make the future collapse eligible
again? Not sure but ill start thinking about it.

Should I send a fixup for this using Lance's solution? Or does Lance
want to send a patch out with the fixes tag?

>
> --
> Cheers,
>
> David
>

