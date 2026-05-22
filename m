Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B7382285
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453520; cv=none; b=sqLFb5K2IQYyUoPMV/raeriiiMP3wXa6J2ld9sCQgSNjTAZCjZQsDwpris2Xx0IrFmp0QQ3aj3S9iKZAyRnWOE22NIiZ19ldUpTdKO+tK3rdSMl/ulrnWugIBTAi+zhkEqI7L7HNBrIZp9oTox4dDEXDwx02ViB2dFYvJOeKtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453520; c=relaxed/simple;
	bh=IfAnYerZxzOHRhNEuFhm9aGfxU5YhLPWXgGqJMkGt9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1mq83H32JX8e063kPxWy6kkAR8VrszMPBNkwr3J0W4byjpAnamH13WzbHgVGjAXHF5CSeNruWqngapV1uQktSD6hAppugL0qhkfmWn8P2dKzMGxX5V+frNWfv0hyGs9eEuN/paMZqzhunrwtYkyKTQejLuk5ZBX1ksLYUwh/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH354mjN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH354mjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779453517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg23ABobLAvo17YgPulsA536JEjAEQBhbDk1f8xAEPo=;
	b=GH354mjN1RhdG87cdY7pzyUP38l1SVObegBhtT8PKWlcFmUodPBqK9iIcPlwcYGCiBHYlE
	ngmCCMRcaPPZW+vntIEI3DzpzbZ5LDksleUsjWhjYju2DOhD+sAlwAEEXohCSpChII4xDS
	ZbbksIE/d2Rr39s+91b2KlcisvUuqzg=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-NmgK2F0RMaOixm7bFNxnkQ-1; Fri, 22 May 2026 08:38:36 -0400
X-MC-Unique: NmgK2F0RMaOixm7bFNxnkQ-1
X-Mimecast-MFC-AGG-ID: NmgK2F0RMaOixm7bFNxnkQ_1779453516
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-651bd2131f0so1072664d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 05:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453515; x=1780058315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kg23ABobLAvo17YgPulsA536JEjAEQBhbDk1f8xAEPo=;
        b=NboE+IKnnh1zBYsXSU8eGVJteiUr8OPuLaWoAt/isDpoYstWeXAXwweq33S85LbM7d
         fl3j/JnDWi7JOFyBIb7oQJXuIZtXQY3jRCTG/EOuU8cJJb/fgoZGLjnR90pUfmpZwtTE
         C1jkZdakg5Oyo0eeisJVcZHyqf3zdHy1yCI6hys+ELfDUmfyyVg3QSzQo0gGL5yvN3hr
         Y1MSlEgepsmXuN+dVygAxSVYrhJuwCymzoiNULziTSwDk1lEeOlgwILqkZRlPpbr5eMA
         4jccOVDb6yKAGSjBkrCRI4w5KQ8mLuXAO9iIv0wceA9+/ERhu9nMWwXNxA4+RwewRX5E
         bA4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8C3HTZK5IE+Lp+JcSoFlXTYi8xpNtD+Hs8uk+eW4j69H6fbf2uA2iMhR6bwJUxBElqS/1FG4dZDwrb7ZvywXeBIQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl3U5pNiYu9hCKntboRm/eRzDfKPgpmjjl0jqJ8PkCdQe8U0uk
	BzdVAR4iIcPabQaJ5MTgvb2TuuM+COBTRVQlhoH4dHMiE/9oQwSIEXdDnbzazMiC5eyY3vPxQGO
	5LKGYdz7vS/qCAMU6uPaw3Doc3+ohYcUJ4hz6TAYyaoUQc3bhT6YjYqYXPTS/+jAx0rOdGTsz6s
	EmD0po7+W20TLbeIASEHG5OkgGOfmbDI23IiHAKMteZ3WpW/F9
X-Gm-Gg: Acq92OEJYvJOoPfYbkOZ2XJMnnX7Uls8O5/d2Dyj3suBqqlFrd/feRGhLpR5tBX36eS
	tjXpcCNP6UBA/MIBl6Z3b64X6va9HHPW1kNJug7TDuRpKy6w3hlPUgQNRrsU0kr6Fu0ADGPFuid
	WJeTx5+Lvmw+rlPQH484w6y7DX99bRI9Kzu0kmBNoU0IHYKHROrC+tnuiCCdvYgDfx3d/J6X1L8
	1/JBA==
X-Received: by 2002:a05:690e:158c:10b0:651:bf58:446b with SMTP id 956f58d0204a3-65ec9631800mr2781423d50.10.1779453515313;
        Fri, 22 May 2026 05:38:35 -0700 (PDT)
X-Received: by 2002:a05:690e:158c:10b0:651:bf58:446b with SMTP id
 956f58d0204a3-65ec9631800mr2781360d50.10.1779453514666; Fri, 22 May 2026
 05:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511185817.686831-1-npache@redhat.com> <20260511185817.686831-12-npache@redhat.com>
 <8f9834db-8981-4eb1-ae46-94908943da3d@gmail.com>
In-Reply-To: <8f9834db-8981-4eb1-ae46-94908943da3d@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 22 May 2026 06:39:03 -0600
X-Gm-Features: AVHnY4LFvT9jaG1lKSI1iBeS9jy3DaF71oKCjVSOye26a7f354AdFd7ZtnzcLS8
Message-ID: <CAA1CXcBs=b4_ZC=pBLEnTu3NRuFYkbW+cLiVXPP2-GONVq1N2g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v17 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: Vernon Yang <vernon2gm@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
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
X-Mimecast-MFC-PROC-ID: 7JnlGID0e2tv4NYLqCr2v-yL9SPpLJxMd07tdbjW_N8_1779453516
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:36=E2=80=AFPM Vernon Yang <vernon2gm@gmail.com> w=
rote:
>
> On Mon, May 11, 2026 at 12:58:11PM -0600, Nico Pache wrote:
> > Enable khugepaged to collapse to mTHP orders. This patch implements the
> > main scanning logic using a bitmap to track occupied pages and a stack
> > structure that allows us to find optimal collapse sizes.
> >
> > Previous to this patch, PMD collapse had 3 main phases, a light weight
> > scanning phase (mmap_read_lock) that determines a potential PMD
> > collapse, an alloc phase (mmap unlocked), then finally heavier collapse
> > phase (mmap_write_lock).
> >
> > To enabled mTHP collapse we make the following changes:
> >
> > During PMD scan phase, track occupied pages in a bitmap. When mTHP
> > orders are enabled, we remove the restriction of max_ptes_none during t=
he
> > scan phase to avoid missing potential mTHP collapse candidates. Once we
> > have scanned the full PMD range and updated the bitmap to track occupie=
d
> > pages, we use the bitmap to find the optimal mTHP size.
> >
> > Implement collapse_scan_bitmap() to perform binary recursion on the bit=
map
> > and determine the best eligible order for the collapse. A stack structu=
re
> > is used instead of traditional recursion to manage the search. This als=
o
> > prevents a traditional recursive approach when the kernel stack struct =
is
> > limited. The algorithm recursively splits the bitmap into smaller chunk=
s to
> > find the highest order mTHPs that satisfy the collapse criteria. We sta=
rt
> > by attempting the PMD order, then moved on the consecutively lower orde=
rs
> > (mTHP collapse). The stack maintains a pair of variables (offset, order=
),
> > indicating the number of PTEs from the start of the PMD, and the order =
of
> > the potential collapse candidate.
> >
> > The algorithm for consuming the bitmap works as such:
> >     1) push (0, HPAGE_PMD_ORDER) onto the stack
> >     2) pop the stack
> >     3) check if the number of set bits in that (offset,order) pair
> >        statisfy the max_ptes_none threshold for that order
> >     4) if yes, attempt collapse
> >     5) if no (or collapse fails), push two new stack items representing
> >        the left and right halves of the current bitmap range, at the
> >        next lower order
> >     6) repeat at step (2) until stack is empty.
> >
> > Below is a diagram representing the algorithm and stack items:
> >
> >                             offset   mid_offset
> >                             |        |
> >                             |        |
> >                             v        v
> >           ____________________________________
> >          |          PTE Page Table            |
> >          --------------------------------------
> >                           <-------><------->
> >                              order-1  order-1
> >
> > mTHP collapses reject regions containing swapped out or shared pages.
> > This is because adding new entries can lead to new none pages, and thes=
e
> > may lead to constant promotion into a higher order mTHP. A similar
> > issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
> > introducing at least 2x the number of pages, and on a future scan will
> > satisfy the promotion condition once again. This issue is prevented via
> > the collapse_max_ptes_none() function which imposes the max_ptes_none
> > restrictions above.
> >
> > We currently only support mTHP collapse for max_ptes_none values of 0
> > and HPAGE_PMD_NR - 1. resulting in the following behavior:
> >
> >     - max_ptes_none=3D0: Never introduce new empty pages during collaps=
e
> >     - max_ptes_none=3DHPAGE_PMD_NR-1: Always try collapse to the highes=
t
> >       available mTHP order
> >
> > Any other max_ptes_none value will emit a warning and skip mTHP collaps=
e
> > attempts. There should be no behavior change for PMD collapse.
> >
> > Once we determine what mTHP sizes fits best in that PMD range a collaps=
e
> > is attempted. A minimum collapse order of 2 is used as this is the lowe=
st
> > order supported by anon memory as defined by THP_ORDERS_ALL_ANON.
> >
> > Currently madv_collapse is not supported and will only attempt PMD
> > collapse.
> >
> > We can also remove the check for is_khugepaged inside the PMD scan as
> > the collapse_max_ptes_none() function handles this logic now.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 182 +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 174 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 3492b135d667..39bf7ea8a6e8 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -100,6 +100,30 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash,=
 MM_SLOTS_HASH_BITS);
> >
> >  static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> > +#define KHUGEPAGED_MIN_MTHP_ORDER    2
> > +/*
> > + * mthp_collapse() does an iterative DFS over a binary tree, from
> > + * HPAGE_PMD_ORDER down to KHUGEPAGED_MIN_MTHP_ORDER. The max stack
> > + * size needed for a DFS on a binary tree is height + 1, where
> > + * height =3D HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER.
> > + *
> > + * ilog2 is used in place of HPAGE_PMD_ORDER because some architecture=
s
> > + * (e.g. ppc64le) do not define HPAGE_PMD_ORDER until after build time=
.
> > + */
> > +#define MTHP_STACK_SIZE      (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN=
_MTHP_ORDER + 1)
> > +
> > +/*
> > + * Defines a range of PTE entries in a PTE page table which are being
> > + * considered for mTHP collapse.
> > + *
> > + * @offset: the offset of the first PTE entry in a PMD range.
> > + * @order: the order of the PTE entries being considered for collapse.
> > + */
> > +struct mthp_range {
> > +     u16 offset;
> > +     u8 order;
> > +};
> > +
> >  struct collapse_control {
> >       bool is_khugepaged;
> >
> > @@ -111,6 +135,12 @@ struct collapse_control {
> >
> >       /* nodemask for allocation fallback */
> >       nodemask_t alloc_nmask;
> > +
> > +     /* Each bit represents a single occupied (!none/zero) page. */
> > +     DECLARE_BITMAP(mthp_bitmap, MAX_PTRS_PER_PTE);
> > +     /* A mask of the current range being considered for mTHP collapse=
. */
> > +     DECLARE_BITMAP(mthp_bitmap_mask, MAX_PTRS_PER_PTE);
> > +     struct mthp_range mthp_bitmap_stack[MTHP_STACK_SIZE];
> >  };
> >
> >  /**
> > @@ -1404,20 +1434,140 @@ static enum scan_result collapse_huge_page(str=
uct mm_struct *mm, unsigned long s
> >       return result;
> >  }
> >
> > +static void collapse_mthp_stack_push(struct collapse_control *cc, int =
*stack_size,
> > +                                  u16 offset, u8 order)
> > +{
> > +     const int size =3D *stack_size;
> > +     struct mthp_range *stack =3D &cc->mthp_bitmap_stack[size];
> > +
> > +     VM_WARN_ON_ONCE(size >=3D MTHP_STACK_SIZE);
> > +     stack->order =3D order;
> > +     stack->offset =3D offset;
> > +     (*stack_size)++;
> > +}
> > +
> > +static struct mthp_range collapse_mthp_stack_pop(struct collapse_contr=
ol *cc,
> > +                                              int *stack_size)
> > +{
> > +     const int size =3D *stack_size;
> > +
> > +     VM_WARN_ON_ONCE(size <=3D 0);
> > +     (*stack_size)--;
> > +     return cc->mthp_bitmap_stack[size - 1];
> > +}
> > +
> > +static unsigned int collapse_mthp_count_present(struct collapse_contro=
l *cc,
> > +                                             u16 offset, unsigned int =
nr_ptes)
> > +{
> > +     bitmap_zero(cc->mthp_bitmap_mask, MAX_PTRS_PER_PTE);
> > +     bitmap_set(cc->mthp_bitmap_mask, offset, nr_ptes);
> > +     return bitmap_weight_and(cc->mthp_bitmap, cc->mthp_bitmap_mask, M=
AX_PTRS_PER_PTE);
> > +}
> > +
> > +/*
> > + * mthp_collapse() consumes the bitmap that is generated during
> > + * collapse_scan_pmd() to determine what regions and mTHP orders fit b=
est.
> > + *
> > + * Each bit in cc->mthp_bitmap represents a single occupied (!none/zer=
o) page.
> > + * A stack structure cc->mthp_bitmap_stack is used to check different =
regions
> > + * of the bitmap for collapse eligibility. The stack maintains a pair =
of
> > + * variables (offset, order), indicating the number of PTEs from the s=
tart of
> > + * the PMD, and the order of the potential collapse candidate respecti=
vely. We
> > + * start at the PMD order and check if it is eligible for collapse; if=
 not, we
> > + * add two entries to the stack at a lower order to represent the left=
 and right
> > + * halves of the PTE page table we are examining.
> > + *
> > + *                         offset       mid_offset
> > + *                         |         |
> > + *                         |         |
> > + *                         v         v
> > + *      --------------------------------------
> > + *      |          cc->mthp_bitmap            |
> > + *      --------------------------------------
> > + *                         <-------><------->
> > + *                          order-1  order-1
> > + *
> > + * For each of these, we determine how many PTE entries are occupied i=
n the
> > + * range of PTE entries we propose to collapse, then we compare this t=
o a
> > + * threshold number of PTE entries which would need to be occupied for=
 a
> > + * collapse to be permitted at that order (accounting for max_ptes_non=
e).
> > + *
> > + * If a collapse is permitted, we attempt to collapse the PTE range in=
to a
> > + * mTHP.
> > + */
> > +static int mthp_collapse(struct mm_struct *mm, unsigned long address,
> > +             int referenced, int unmapped, struct collapse_control *cc=
,
> > +             unsigned long enabled_orders)
> > +{
> > +     unsigned int nr_occupied_ptes, nr_ptes;
> > +     int max_ptes_none, collapsed =3D 0, stack_size =3D 0;
> > +     unsigned long collapse_address;
> > +     struct mthp_range range;
> > +     u16 offset;
> > +     u8 order;
> > +
> > +     collapse_mthp_stack_push(cc, &stack_size, 0, HPAGE_PMD_ORDER);
> > +
> > +     while (stack_size) {
> > +             range =3D collapse_mthp_stack_pop(cc, &stack_size);
> > +             order =3D range.order;
> > +             offset =3D range.offset;
> > +             nr_ptes =3D 1UL << order;
> > +
> > +             if (!test_bit(order, &enabled_orders))
> > +                     goto next_order;
> > +
> > +             max_ptes_none =3D collapse_max_ptes_none(cc, NULL, order)=
;
> > +
> > +             if (max_ptes_none < 0)
> > +                     return collapsed;
> > +
> > +             nr_occupied_ptes =3D collapse_mthp_count_present(cc, offs=
et,
> > +                                                            nr_ptes);
> > +
> > +             if (nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
> > +                     int ret;
> > +
> > +                     collapse_address =3D address + offset * PAGE_SIZE=
;
> > +                     ret =3D collapse_huge_page(mm, collapse_address, =
referenced,
> > +                                              unmapped, cc, order);
> > +                     if (ret =3D=3D SCAN_SUCCEED) {
> > +                             collapsed +=3D nr_ptes;
> > +                             continue;
> > +                     }
> > +             }
> > +
> > +next_order:
> > +             if (order > KHUGEPAGED_MIN_MTHP_ORDER) {
>
> Hi Nico, thank you very much for your contributions to this series.
>
> I found a minor issue, for MADV_COLLAPSE, if collapse_huge_page() fails
> for some reason (e.g. allocate folio), it goes to next_order and
> continues splitting to the next small order. However, enabled_orders
> only supports HPAGE_PMD_ORDER, so it keeps runing the split operations
> without any effective work until KHUGEPAGED_MIN_MTHP_ORDER is reached
> before exiting. For khugepaged, e.g. setting only 2MB to always, also
> same phenomenon.
>
> This does not affect the overall functionality of mthp collapse, just
> redundant.
>
> The redundant operations can be easily skipped with the following
> modification. If I miss some thing, please let me know. Thanks!

Hi Vernon!

Thank you for the report and very clean solution :) I will implement
your optimization into this commit.

Cheers,
-- Nico

>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1a25af3d6d0f..fa407cce525c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1574,7 +1574,7 @@ static int mthp_collapse(struct mm_struct *mm, unsi=
gned long address,
>                 }
>
>  next_order:
> -               if (order > KHUGEPAGED_MIN_MTHP_ORDER) {
> +               if ((BIT(order) - 1) & enabled_orders) {
>                         const u8 next_order =3D order - 1;
>                         const u16 mid_offset =3D offset + (nr_ptes / 2);
>
> --
> Cheers,
> Vernon
>
> > +                     const u8 next_order =3D order - 1;
> > +                     const u16 mid_offset =3D offset + (nr_ptes / 2);
> > +
> > +                     collapse_mthp_stack_push(cc, &stack_size, mid_off=
set,
> > +                                              next_order);
> > +                     collapse_mthp_stack_push(cc, &stack_size, offset,
> > +                                              next_order);
> > +             }
> > +     }
> > +     return collapsed;
> > +}
> > +
> >  static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> >               struct vm_area_struct *vma, unsigned long start_addr,
> >               bool *lock_dropped, struct collapse_control *cc)
> >  {
> > -     const int max_ptes_none =3D collapse_max_ptes_none(cc, vma, HPAGE=
_PMD_ORDER);
> > +     int max_ptes_none =3D collapse_max_ptes_none(cc, vma, HPAGE_PMD_O=
RDER);
> >       const unsigned int max_ptes_shared =3D collapse_max_ptes_shared(c=
c, HPAGE_PMD_ORDER);
> >       const unsigned int max_ptes_swap =3D collapse_max_ptes_swap(cc, H=
PAGE_PMD_ORDER);
> > +     enum tva_type tva_flags =3D cc->is_khugepaged ? TVA_KHUGEPAGED : =
TVA_FORCED_COLLAPSE;
> >       pmd_t *pmd;
> > -     pte_t *pte, *_pte;
> > -     int none_or_zero =3D 0, shared =3D 0, referenced =3D 0;
> > +     pte_t *pte, *_pte, pteval;
> > +     int i;
> > +     int none_or_zero =3D 0, shared =3D 0, nr_collapsed =3D 0, referen=
ced =3D 0;
> >       enum scan_result result =3D SCAN_FAIL;
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       unsigned long addr;
> > +     unsigned long enabled_orders;
> >       spinlock_t *ptl;
> >       int node =3D NUMA_NO_NODE, unmapped =3D 0;
> >
> > @@ -1429,8 +1579,19 @@ static enum scan_result collapse_scan_pmd(struct=
 mm_struct *mm,
> >               goto out;
> >       }
> >
> > +     bitmap_zero(cc->mthp_bitmap, MAX_PTRS_PER_PTE);
> >       memset(cc->node_load, 0, sizeof(cc->node_load));
> >       nodes_clear(cc->alloc_nmask);
> > +
> > +     enabled_orders =3D collapse_allowable_orders(vma, vma->vm_flags, =
tva_flags);
> > +
> > +     /*
> > +      * If PMD is the only enabled order, enforce max_ptes_none, other=
wise
> > +      * scan all pages to populate the bitmap for mTHP collapse.
> > +      */
> > +     if (enabled_orders !=3D BIT(HPAGE_PMD_ORDER))
> > +             max_ptes_none =3D KHUGEPAGED_MAX_PTES_LIMIT;
> > +
> >       pte =3D pte_offset_map_lock(mm, pmd, start_addr, &ptl);
> >       if (!pte) {
> >               cc->progress++;
> > @@ -1438,11 +1599,13 @@ static enum scan_result collapse_scan_pmd(struc=
t mm_struct *mm,
> >               goto out;
> >       }
> >
> > -     for (addr =3D start_addr, _pte =3D pte; _pte < pte + HPAGE_PMD_NR=
;
> > -          _pte++, addr +=3D PAGE_SIZE) {
> > +     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +             _pte =3D pte + i;
> > +             addr =3D start_addr + i * PAGE_SIZE;
> > +             pteval =3D ptep_get(_pte);
> > +
> >               cc->progress++;
> >
> > -             pte_t pteval =3D ptep_get(_pte);
> >               if (pte_none_or_zero(pteval)) {
> >                       if (++none_or_zero > max_ptes_none) {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -1522,6 +1685,8 @@ static enum scan_result collapse_scan_pmd(struct =
mm_struct *mm,
> >                       }
> >               }
> >
> > +             /* Set bit for occupied pages */
> > +             __set_bit(i, cc->mthp_bitmap);
> >               /*
> >                * Record which node the original page is from and save t=
his
> >                * information to cc->node_load[].
> > @@ -1580,10 +1745,11 @@ static enum scan_result collapse_scan_pmd(struc=
t mm_struct *mm,
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               /* collapse_huge_page expects the lock to be dropped befo=
re calling */
> >               mmap_read_unlock(mm);
> > -             result =3D collapse_huge_page(mm, start_addr, referenced,
> > -                                         unmapped, cc, HPAGE_PMD_ORDER=
);
> > +             nr_collapsed =3D mthp_collapse(mm, start_addr, referenced=
, unmapped,
> > +                                           cc, enabled_orders);
> >               /* collapse_huge_page will return with the mmap_lock rele=
ased */
> >               *lock_dropped =3D true;
> > +             result =3D nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
> >       }
> >  out:
> >       trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> > --
> > 2.54.0
> >
> >
>

