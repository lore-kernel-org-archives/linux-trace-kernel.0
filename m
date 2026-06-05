Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB23E3178
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657587; cv=none; b=pBVTUzp9JfIYnrN6KRZxC9DZDaKUKtlUvqipgtAT8FCy1RwnoszP3qlZGXj30gWl8znIFap6ATwvMoNGY9L83zNH1zx/qPAU6I44uq1nAUVC9VLAugD6+4s2ceeweitm/Reqz49eeyGvau/p1u0MPXhnl2OhyCtyZK7pzK/hDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657587; c=relaxed/simple;
	bh=Vf6uAB/TrKKENCZditS2bsY8VAW+Jel9XUhyKLpMUXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AB5UPnoA/iAG847BdUvJHT4CIWeTc0K3ZUncY1hU4Zotsu+PZjlkNCh8Og5UOVC7YbwdpUSLLHmgUIKJuzf2b216qwo4GhuRGK5uuE48HSddEJ9vAj9NbnWaffwycZfjjo0qwRwLAqUHPbsElvtUEvZ7YaJVz1GVVmil5JwxgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwDPdzqn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwDPdzqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780657584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PxPAk8T27TyTY8AVC2CuS3+e0RgRW2Hvk0iP9IAVhA=;
	b=RwDPdzqncZYfntnXCXYE0VwvNnjb2xBcEPsTUKPmlntPDdb/5pAY3Gpc5riZkIvIYOidtX
	WN61d93qqrfLqnm9+W3dIes4QE13tV6XpebyPBy3Pf2JSTsD/LEaa+Fu2n3lTxrVgDilrA
	hduWx8cif7c/17wP1jv0TxEkYkVbPw4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-lgEDL4htNdy3doqzMYu4ew-1; Fri, 05 Jun 2026 07:06:23 -0400
X-MC-Unique: lgEDL4htNdy3doqzMYu4ew-1
X-Mimecast-MFC-AGG-ID: lgEDL4htNdy3doqzMYu4ew_1780657582
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7dcd01ca614so35655987b3.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 04:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780657582; x=1781262382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PxPAk8T27TyTY8AVC2CuS3+e0RgRW2Hvk0iP9IAVhA=;
        b=ojvDE0T64G+hPrEf7JQqgpuZ23fBOiMQnPfGyfqo/5g7NGLwpw9eErMlZSeKLzVM/i
         92iipqvHZ3YH+M3Lzd7Ll5yPxEZs55JuKdbLYOgC6HcK32QJaj7Pgqavb82IkD/e/odz
         YwxuhTK/QmnI3d0frhvQVnWvXOMa4r3+y1YMKvqxouGMA3VekEV7W5YYk+FUiTtOGW7u
         5rPWEcPXpjR+o0USA+n0BLf2jkRSOAw6b5pHFoOnDW1xkOcYTqGJZ5kIvTDbvZSqFvDp
         sK4liy06nZ0BgH4wcE2i8Llkvp7IxuETGqzqvFamC2x3Ii5ZoHRDEsEdVE18zgrH+pGD
         uyAw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ncl7PyFJvZUU4D+HgzFSI7v27Vt8sOfXpVbs0Ap/ZY422dOk7Jhl8ZTp/+zzyjhVGi7LQ1I2MVIAaIzOGY6Xyx3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7z9KU7P0z/2nrklD79F4pkm+5Rw6bqefIhmca/avsaRWETjvf
	BMK/8spkiDcgwa1PrtszCNesf4u0hFNyx1QWyFM8MCII4vjbnrvjcZ2W8fC43l2r59SAZKqDdyg
	hg9bxqNl47HIbqHeyrt3dhdxLYTZDGkNnSp4wUlWZjvF4RutWVlANsGfFaWAm0pWpmFRjR50eCb
	Qxrop3NUq5QVZ0a3pTPTnBh0iYiYonqF5D7asJp8DwliQIJqm3
X-Gm-Gg: Acq92OH1A89RcGsxkdkOLcdDwRtH9A0ETEX+giRCV/SuqtYLUT+ZGh4S9LxR86RoDD8
	DCg/S3nuW3As9A2YsNFWXHHqeGgMVvF92s3u+pDZQUNTlgvz8gHdQRpCrYJxVORulLb1j0LV4wZ
	3zPVdf8HF1CTVvuFoeGDITtYJh1F+KlDF716AobWRMycv8swiaIlFlpOXwm+1Wg0jVdl29kva/Y
	DbInOxtVSS4M0Q=
X-Received: by 2002:a53:c84d:0:b0:651:bb21:e7fd with SMTP id 956f58d0204a3-66106f39d59mr1970119d50.42.1780657582131;
        Fri, 05 Jun 2026 04:06:22 -0700 (PDT)
X-Received: by 2002:a53:c84d:0:b0:651:bb21:e7fd with SMTP id
 956f58d0204a3-66106f39d59mr1970055d50.42.1780657581531; Fri, 05 Jun 2026
 04:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <20260522150009.121603-12-npache@redhat.com>
 <aiGOvIR9sfm91cvT@lucifer>
In-Reply-To: <aiGOvIR9sfm91cvT@lucifer>
From: Nico Pache <npache@redhat.com>
Date: Fri, 5 Jun 2026 05:07:04 -0600
X-Gm-Features: AVHnY4Js5ldAQ1HZNLA0gnEn0ZSi0kwFDeXun--00mlx3eEyIY1YaUh2h1kc-FE
Message-ID: <CAA1CXcBeg5yFvG89xd49mD=LuSouDsXNCkfMF8Xmdgy7-h522g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, 
	rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: COAj8RIIwoAwDnmG4-wgDsfCN_PEg6lcQTLW9F01BGo_1780657582
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:45=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wro=
te:
>
> On Fri, May 22, 2026 at 09:00:06AM -0600, Nico Pache wrote:
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
> > Any other max_ptes_none value will emit a warning and default mTHP
> > collapse to max_ptes_none=3D0. There should be no behavior change for P=
MD
> > collapse.
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
> >  mm/khugepaged.c | 181 +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 172 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 64ceebc9d8a7..d3d7db8be26c 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -99,6 +99,30 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, M=
M_SLOTS_HASH_BITS);
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
> > @@ -110,6 +134,12 @@ struct collapse_control {
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
> > @@ -1411,20 +1441,137 @@ static enum scan_result collapse_huge_page(str=
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
> > +static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *=
vma,
> > +             unsigned long address, int referenced, int unmapped,
> > +             struct collapse_control *cc, unsigned long enabled_orders=
)
> > +{
> > +     unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
> > +     int collapsed =3D 0, stack_size =3D 0;
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
> > +             max_ptes_none =3D collapse_max_ptes_none(cc, vma, order);
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
> > +             if ((BIT(order) - 1) & enabled_orders) {
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
> > -     const unsigned int max_ptes_none =3D collapse_max_ptes_none(cc, v=
ma, HPAGE_PMD_ORDER);
> >       const unsigned int max_ptes_shared =3D collapse_max_ptes_shared(c=
c, HPAGE_PMD_ORDER);
> >       const unsigned int max_ptes_swap =3D collapse_max_ptes_swap(cc, H=
PAGE_PMD_ORDER);
> > +     unsigned int max_ptes_none =3D collapse_max_ptes_none(cc, vma, HP=
AGE_PMD_ORDER);
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
> > @@ -1436,8 +1583,19 @@ static enum scan_result collapse_scan_pmd(struct=
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
>
> Hmm, this is a bit odd, what if the user set max_ptes_none =3D 0?

We'd still want to scan the full PMD to populate the bitmap. That way
we can find the smaller orders that contain 0 none/zero PTEs.

>
> I assume we handle the 0/511 thing elsewhere?

Yes in the bitmap weight check and in collapse_huge_page_isolate()

>
> > +
> >       pte =3D pte_offset_map_lock(mm, pmd, start_addr, &ptl);
> >       if (!pte) {
> >               cc->progress++;
> > @@ -1445,11 +1603,13 @@ static enum scan_result collapse_scan_pmd(struc=
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
> > @@ -1529,6 +1689,8 @@ static enum scan_result collapse_scan_pmd(struct =
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
> > @@ -1587,10 +1749,11 @@ static enum scan_result collapse_scan_pmd(struc=
t mm_struct *mm,
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               /* collapse_huge_page expects the lock to be dropped befo=
re calling */
> >               mmap_read_unlock(mm);
> > -             result =3D collapse_huge_page(mm, start_addr, referenced,
> > -                                         unmapped, cc, HPAGE_PMD_ORDER=
);
> > -             /* collapse_huge_page will return with the mmap_lock rele=
ased */
> > +             nr_collapsed =3D mthp_collapse(mm, vma, start_addr, refer=
enced,
> > +                                          unmapped, cc, enabled_orders=
);
>
> I guess mthp_collapse() also does PMD collapse if only PMD is enabled?
>
> It feels like this name is a bit confusing then :)
>
> But I guess we can do a follow up to think of a better name possibly.
>
> > +             /* mmap_lock was released above, set lock_dropped */
> >               *lock_dropped =3D true;
> > +             result =3D nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
> >       }
> >  out:
> >       trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> > --
> > 2.54.0
> >
>
> Thanks, Lorenzo
>

