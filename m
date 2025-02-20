Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4D262D36
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077358; cv=none; b=QVNFBeEneMTh1G3GCF/A4494xfXvGApXOF3aeWBfjhB1k+dtlLLgLXHw5nIIlIhtp/+zpBUeAL7VobphJ4IJphQr7GPJ3w5x6bLsfixkue/MshtexoZ46a1EA2tSE1bud8KXyTpM8hpSHbr2siIBpE3Ak0meJgmYBtf4Q4dAbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077358; c=relaxed/simple;
	bh=5wS46zSr2Nql0CrKrwBFiHxRi5z1u7sUz0LIYHYomSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRrl3rHMeSiOOAl61I66JVIRIzJbj8ifq9zz1IzomX3MZVPr9KvpsHUPc/u0ULe4NtfOpNgnDm1BfYUDWyxSw9ygBUjmtlNRZVT9YUJbDiWudP5sMS+OYkr5/nuvqWJrYRTuwo3C6hDXCCkRrc8Ezz291wvCULSdk3eoAy8FFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7fXsCGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7fXsCGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740077355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUOODgfJXNQeyzzsjecbw2Drf+SGFtFyxDLhlahe2Ss=;
	b=e7fXsCGZPsKIEPLMoJ4OLRO0QWgzC3eUBcZUkFFdA96QoHuc4IazYCDEwE1DtGXtH8NCeJ
	wOVd+vGrwh9QcpeMJ8Rh4951+UpyPtCdb5xry0ZC1fyBtHhgim4vo/MxDnKAk1z7uKLHVC
	+kPyzioa6+aWbpfFEwUFMHfHhD/8s64=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-75FMZQCkOzy268HBa_3kUw-1; Thu, 20 Feb 2025 13:49:14 -0500
X-MC-Unique: 75FMZQCkOzy268HBa_3kUw-1
X-Mimecast-MFC-AGG-ID: 75FMZQCkOzy268HBa_3kUw_1740077354
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6f2a2ab50f6so17213507b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077354; x=1740682154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUOODgfJXNQeyzzsjecbw2Drf+SGFtFyxDLhlahe2Ss=;
        b=AMxul/JDKjrtlmpGmjQWL2jxQyWPy8Ub++WAEVFisbf2DLs0EgjHePWxIDT26PDPch
         JZ9Ag0aR2qRG27BxAkZMVzEGoP1sN1Twi9Ar77eDAqx1O13zKUupnZsrmAYGKATO1YXO
         B3pPNar6gq/OKPKopCv/efmK47n0ZDMdzZ3llX59lly9IzTa7g36IJifx/No4Xc2vNHu
         OYb5KqGfqnERAilY2kIY7AHlT4l30wzg8+gkzBl8GipNqusRbY0RdUNiEQp6KFGCOIfM
         8fs4vq67Y3emIuVDufPJEY1ttULHMwP2V7GoHyckNjuuGr4NztaO+vSYqonDZas0Vbd2
         hsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUBQWRDI8KS4rLyJIsiqfO1ScnDNvXCmb2+Q0HJMWx1qEPZrg6mepZvK9MbdIFdedh1Mo83TegKhApGim50GJ7rXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99izHWknVQusC4MBVHZ0N/v/5jhHkZvdbs4JlDFCVwUFG85vH
	/qW9qyL6rvMxq0/LkUbHr8tsYNdQ5lwGNpBKZpRQm2O9vh/5zLS6FIy/xN+l0UK/QAWF8GbSnVa
	rYyEiqd9y6N6NUHFi4oz/umtDPx7vZDGoAMrmrPFPDtOg0IXxyFXHp9qZ4I8+NNlOrckUjYj2db
	96gtxvraY65Vm0rwDcHvxGUeYmbTPehFwqp24urwBUEgqH
X-Gm-Gg: ASbGnctrYb2+ipgbboyB8RtFIhVlkQgyNksNv8FxNBKB10fvLKIBfh0ee/CpeK1ERGa
	u5ajGFDD48wQWs/Q6d0jNsN4xyKazt5ockqaXvbPMDXxccEbhxOkWrX089wp+dG8m7JqTF/ynsK
	4=
X-Received: by 2002:a05:690c:61c6:b0:6fb:9474:7b5f with SMTP id 00721157ae682-6fbcc23a926mr1434147b3.14.1740077353706;
        Thu, 20 Feb 2025 10:49:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGq7HcO+16vZtHnzk0o6nsS4cfjbj9QH0ZJWTYiqMTU+ttLvnD3YT70YopmDHRn2kaZzVeyNtkcYLUycbm740=
X-Received: by 2002:a05:690c:61c6:b0:6fb:9474:7b5f with SMTP id
 00721157ae682-6fbcc23a926mr1433907b3.14.1740077353331; Thu, 20 Feb 2025
 10:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-7-npache@redhat.com>
 <45b898f2-c514-44d3-bbd9-523772c71b0b@arm.com>
In-Reply-To: <45b898f2-c514-44d3-bbd9-523772c71b0b@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 20 Feb 2025 11:48:47 -0700
X-Gm-Features: AWEUYZkz9CCfhvHyu1E9Ejd74JwsxySTif1aPPoncOXMUYPpDkPwWiE8fgya338
Message-ID: <CAA1CXcB7cqEoHB=J7oBfrrSmaP2MPRgj1jkeZCX1aZmACayw8Q@mail.gmail.com>
Subject: Re: [RFC v2 6/9] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, usamaarif642@gmail.com, audra@redhat.com, 
	akpm@linux-foundation.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, tiwai@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H9V5l7_sRJDVYC-YJ_iKDRMSgOO_u99wBMAL6gzcDWw_1740077354
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 9:28=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/02/2025 00:30, Nico Pache wrote:
> > khugepaged scans PMD ranges for potential collapse to a hugepage. To ad=
d
> > mTHP support we use this scan to instead record chunks of fully utilize=
d
> > sections of the PMD.
> >
> > create a bitmap to represent a PMD in order MTHP_MIN_ORDER chunks.
> > by default we will set this to order 3. The reasoning is that for 4K 51=
2
>
> I'm still a bit confused by this (hopefully to be resolved as I'm about t=
o read
> the code); Does this imply that the smallest order you can collapse to is=
 order
> 3? Because that would be different from the fault handler. For anon memor=
y we
> can support order-2 and above. I believe that these days files can suppor=
t order-1.

Yes, it may have been a premature optimization. I will test with
MTHP_MIN_ORDER=3D2 and compare!

>
> There is a case for wanting to support order-2 for arm64. We have a (not =
yet
> well deployed) technology called Hardware Page Aggregation (HPA) which ca=
n
> automatically (transparent to SW) aggregate (usually) 4 contiguous pages =
into a
> single TLB. I'd like the solution to be compatible with that.

Sounds reasonable, especially if the hardware support is going to give
that size a huge boost.

>
> > PMD size this results in a 64 bit bitmap which has some optimizations.
> > For other arches like ARM64 64K, we can set a larger order if needed.
> >
> > khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
> > that represents chunks of utilized regions. We can then determine what
> > mTHP size fits best and in the following patch, we set this bitmap whil=
e
> > scanning the PMD.
> >
> > max_ptes_none is used as a scale to determine how "full" an order must
> > be before being considered for collapse.
> >
> > If a order is set to "always" lets always collapse to that order in a
> > greedy manner.
>
> This is not the policy that the fault handler uses, and I think we should=
 use
> the same policy in both places.
>
> The fault handler gets a list of orders that are permitted for the VMA, t=
hen
> prefers the highest orders in that list.
>
> I don't think we should be preferring a smaller "always" order over a lar=
ger
> "madvise" order if MADV_HUGEPAGE is set for the VMA (if that's what your
> statement was suggesting).

It does start at the highest order. All this means that if you have
PMD=3Dalways
1024kB=3Dmadvise

the PMD collapse will always happen (if we dont want this behavior lmk!)

>
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  include/linux/khugepaged.h |  4 ++
> >  mm/khugepaged.c            | 89 +++++++++++++++++++++++++++++++++++---
> >  2 files changed, 86 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index 1f46046080f5..1fe0c4fc9d37 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -1,6 +1,10 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  #ifndef _LINUX_KHUGEPAGED_H
> >  #define _LINUX_KHUGEPAGED_H
> > +#define MIN_MTHP_ORDER       3
> > +#define MIN_MTHP_NR  (1<<MIN_MTHP_ORDER)
> > +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE * PAGE_SIZ=
E) - MIN_MTHP_ORDER))
>
> I don't think you want "* PAGE_SIZE" here? I think MAX_MTHP_BITMAP_SIZE w=
ants to
> specify the maximum number of groups of MIN_MTHP_NR pte entries in a PTE =
table?
>
> In that case, MAX_PTRS_PER_PTE will be 512 on x86_64. Your current formul=
a will
> give 262144 (which is 32KB!). I think you just need:

Yes that is correct! Thanks for pointing that out. the bitmap size is
supposed to be 64 not 262144! that should save some memory :P

>
> #define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - MIN_MTHP_O=
RDER))
>
> > +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - MIN_MTHP_ORDER))
>
> Perhaps all of these macros need a KHUGEPAGED_ prefix? Otherwise MIN_MTHP=
_ORDER,
> especially, is misleading. The min MTHP order is not 3.


I will add the prefixes, thanks!

>
> >
> >  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 3776055bd477..c8048d9ec7fb 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, M=
M_SLOTS_HASH_BITS);
> >
> >  static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> > +struct scan_bit_state {
> > +     u8 order;
> > +     u16 offset;
> > +};
> > +
> >  struct collapse_control {
> >       bool is_khugepaged;
> >
> > @@ -102,6 +107,15 @@ struct collapse_control {
> >
> >       /* nodemask for allocation fallback */
> >       nodemask_t alloc_nmask;
> > +
> > +     /* bitmap used to collapse mTHP sizes. 1bit =3D order MIN_MTHP_OR=
DER mTHP */
> > +     DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> > +     DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> > +     struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> > +};
> > +
> > +struct collapse_control khugepaged_collapse_control =3D {
> > +     .is_khugepaged =3D true,
> >  };
> >
> >  /**
> > @@ -851,10 +865,6 @@ static void khugepaged_alloc_sleep(void)
> >       remove_wait_queue(&khugepaged_wait, &wait);
> >  }
> >
> > -struct collapse_control khugepaged_collapse_control =3D {
> > -     .is_khugepaged =3D true,
> > -};
> > -
> >  static bool khugepaged_scan_abort(int nid, struct collapse_control *cc=
)
> >  {
> >       int i;
> > @@ -1112,7 +1122,8 @@ static int alloc_charge_folio(struct folio **foli=
op, struct mm_struct *mm,
> >
> >  static int collapse_huge_page(struct mm_struct *mm, unsigned long addr=
ess,
> >                             int referenced, int unmapped,
> > -                           struct collapse_control *cc)
> > +                           struct collapse_control *cc, bool *mmap_loc=
ked,
> > +                               u8 order, u16 offset)
> >  {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > @@ -1130,8 +1141,12 @@ static int collapse_huge_page(struct mm_struct *=
mm, unsigned long address,
> >        * The allocation can take potentially a long time if it involves
> >        * sync compaction, and we do not need to hold the mmap_lock duri=
ng
> >        * that. We will recheck the vma after taking it again in write m=
ode.
> > +      * If collapsing mTHPs we may have already released the read_lock=
.
> >        */
> > -     mmap_read_unlock(mm);
> > +     if (*mmap_locked) {
> > +             mmap_read_unlock(mm);
> > +             *mmap_locked =3D false;
> > +     }
> >
> >       result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> >       if (result !=3D SCAN_SUCCEED)
> > @@ -1266,12 +1281,71 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >  out_up_write:
> >       mmap_write_unlock(mm);
> >  out_nolock:
> > +     *mmap_locked =3D false;
> >       if (folio)
> >               folio_put(folio);
> >       trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, resul=
t);
> >       return result;
> >  }
> >
> > +// Recursive function to consume the bitmap
> > +static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long =
address,
> > +                     int referenced, int unmapped, struct collapse_con=
trol *cc,
> > +                     bool *mmap_locked, unsigned long enabled_orders)
> > +{
> > +     u8 order, next_order;
> > +     u16 offset, mid_offset;
> > +     int num_chunks;
> > +     int bits_set, threshold_bits;
> > +     int top =3D -1;
> > +     int collapsed =3D 0;
> > +     int ret;
> > +     struct scan_bit_state state;
> > +
> > +     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit_state)
> > +             { HPAGE_PMD_ORDER - MIN_MTHP_ORDER, 0 };
> > +
> > +     while (top >=3D 0) {
> > +             state =3D cc->mthp_bitmap_stack[top--];
> > +             order =3D state.order + MIN_MTHP_ORDER;
> > +             offset =3D state.offset;
> > +             num_chunks =3D 1 << (state.order);
> > +             // Skip mTHP orders that are not enabled
> > +             if (!test_bit(order, &enabled_orders))
> > +                     goto next;
> > +
> > +             // copy the relavant section to a new bitmap
> > +             bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap,=
 offset,
> > +                               MTHP_BITMAP_SIZE);
> > +
> > +             bits_set =3D bitmap_weight(cc->mthp_bitmap_temp, num_chun=
ks);
> > +             threshold_bits =3D (HPAGE_PMD_NR - khugepaged_max_ptes_no=
ne - 1)
> > +                             >> (HPAGE_PMD_ORDER - state.order);
> > +
> > +             //Check if the region is "almost full" based on the thres=
hold
> > +             if (bits_set > threshold_bits
> > +                     || test_bit(order, &huge_anon_orders_always)) {
> > +                     ret =3D collapse_huge_page(mm, address, reference=
d, unmapped, cc,
> > +                                     mmap_locked, order, offset * MIN_=
MTHP_NR);
> > +                     if (ret =3D=3D SCAN_SUCCEED) {
> > +                             collapsed +=3D (1 << order);
> > +                             continue;
> > +                     }
> > +             }
> > +
> > +next:
> > +             if (state.order > 0) {
> > +                     next_order =3D state.order - 1;
> > +                     mid_offset =3D offset + (num_chunks / 2);
> > +                     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit=
_state)
> > +                             { next_order, mid_offset };
> > +                     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit=
_state)
> > +                             { next_order, offset };
> > +                     }
> > +     }
> > +     return collapsed;
> > +}
>
> I'm struggling to understand the details of this function. I'll come back=
 to it
> when I have more time.
Hopefully the presentation helped a little. This is a recursive
function that uses a stack instead of function calling. This was to
remove the recursion, and to make the result handling much easier.
Basic idea is to start at PMD and work your way down until you find
that the bitmap satisfies the conditions for collapse. If it doesn't
collapse, it will add two new collapse attempts to the stack (order--,
left and right chunks)

>
> > +
> >  static int khugepaged_scan_pmd(struct mm_struct *mm,
> >                                  struct vm_area_struct *vma,
> >                                  unsigned long address, bool *mmap_lock=
ed,
> > @@ -1440,7 +1514,7 @@ static int khugepaged_scan_pmd(struct mm_struct *=
mm,
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               result =3D collapse_huge_page(mm, address, referenced,
> > -                                         unmapped, cc);
> > +                                         unmapped, cc, mmap_locked, HP=
AGE_PMD_ORDER, 0);
> >               /* collapse_huge_page will return with the mmap_lock rele=
ased */
> >               *mmap_locked =3D false;
>
> Given that collapse_huge_page() now takes mmap_locked and sets it to fals=
e on
> return, I don't think we need this line here any longer?

I think that is correct! Thanks

>
> >       }
> > @@ -2856,6 +2930,7 @@ int madvise_collapse(struct vm_area_struct *vma, =
struct vm_area_struct **prev,
> >       mmdrop(mm);
> >       kfree(cc);
> >
> > +
> >       return thps =3D=3D ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
> >                       : madvise_collapse_errno(last_fail);
> >  }
>

