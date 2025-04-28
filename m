Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B348F5A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851667; cv=none; b=t/Ajijs7lKffXgCeCfvrAHFzUmKf/3wI3KchJjjVkaIZn+ONT1tK7rnEGPGt4u94/Z7BDhaOupA3QZuVED+9JcfdlVDUGSnAHzna68yTW1zKtW4ntTC27kWP+eg8oMJSGv1Rqg72yca/J7RuRiO8xDPDQ94QrqjNFGZJ5o1tZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851667; c=relaxed/simple;
	bh=7FNG+ItrdJ7ATPBw2w+D+H3RCmUh5MRebGnlgLlyoW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLy3mmqLA1M/9zDGNT9KfRV8tWlJUWr7nHKAtebIbOYrJF0kQxtqlAQCQfxhhZvFYVNFhlQJAo2MAAVKk/34XxDT2mSmwRzIBO82K20Wqms+WR3ZwGelcphpNnJzhDZWvYZP/lVt+tYN0gfvCXLPr5q1o1aOlhj1tXgczhPU9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfK0nyNy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfK0nyNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745851664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACNt1upMe6tBP1vArcgHmRSi246KnVFiBA1nlkLjZ1Y=;
	b=FfK0nyNyLZSaffJMZGP+Qz5hGnpxInoSjEKhm1ujNZvOLH1o93MAIgmZC+kDgRYd+NfEwl
	PvHAObBjKo3zVnZKm/pIBYMxZpW6+UbJhob38r207DVbOtHx+fklAHTQbbIk1RBLDGZf+U
	jDOzCIg5t7QcloNTqgIafp63GKrQLJY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-KI9rzQrCNYaKMXOSaYhhDw-1; Mon, 28 Apr 2025 10:47:42 -0400
X-MC-Unique: KI9rzQrCNYaKMXOSaYhhDw-1
X-Mimecast-MFC-AGG-ID: KI9rzQrCNYaKMXOSaYhhDw_1745851661
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-703d7a66d77so65569347b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 07:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851661; x=1746456461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACNt1upMe6tBP1vArcgHmRSi246KnVFiBA1nlkLjZ1Y=;
        b=j0KXdSSyq/whEl/bxCUBb37aPnXf6frANT2L/EpIYd9FyZP9YSIz4qyT4aWmqBm783
         9Oxw20pFZ9ZicP74LebMt9VaZqE+D+AHgq17CQssww58Ow8vc7U1GXeox6YYMEDQOgYn
         atVuXzAhhD+XkSGaqh4k5RyEpC3Bg23n4ami14zQ6NllkpYvUM3OURlHYtrw4m4wRAOJ
         sQC0IIc34lPUEdRePHuUMx7RzyLJ1aOUdxEFs6vju/HuRg4nAXnYDJe6OY4DmCx+rk3B
         9N+8nK7AHnezeo5VTLiQqcHYt2Mq1ZtZ/c0ckJkA45RB4aNUlN6ISeOily95ptjz82TL
         SGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj2UsHGbLWTOl12iXVcHY7QYxWNb/xS4qSG18M2ZckQdgOTYtEU6GpAfrwmuwBmAe0GiLFvrsTrQhayKcNRopZlSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAVOJ28Cxe6DOf4HoVl3702l4rygvx5oilNaC0iJU1QlKvu6t
	iYCI3/IbKVr9ncHepjZ7dLWCmB5kQv2Km3D7+aRFAUyKbxgHKVMN8IMYGhrhVRpwQgM7ZfH0+5H
	7+tdmUy7Ka0arxcuqoBCpuDrJyHb7Uw8lsfN3Nl9m0uqQBFgrI7LeeUSD8XHF1+VIUi+/RONX3W
	I4165WKpyrTrukmvV3AheWPydnkgouUt1ItEq9pyxHiPCi
X-Gm-Gg: ASbGncsEbZf1jyPUrEhFYuf3Y655QN7Sa/U4W6NzBuZz9soqa8YfC0r8hbsqhIpSDE4
	85qJDwmVWg9oxoya89XBtvf4zbQhujuS2iIznqHZnStavdZaLomg3OaEDL2oSzZrquvNJ/1+CWR
	SqGp0XDoc=
X-Received: by 2002:a05:690c:6b89:b0:6fb:9445:d28e with SMTP id 00721157ae682-708543f3f8bmr150019487b3.10.1745851661549;
        Mon, 28 Apr 2025 07:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVkmkE4Vcb08AcXyxikoE1TU4PLRHPVJn8yw3P8lrANxyblubLndQgNm2O8lhMvIXPZ36Drl3GMiypgwM8vns=
X-Received: by 2002:a05:690c:6b89:b0:6fb:9445:d28e with SMTP id
 00721157ae682-708543f3f8bmr150018817b3.10.1745851661161; Mon, 28 Apr 2025
 07:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417000238.74567-1-npache@redhat.com> <20250417000238.74567-7-npache@redhat.com>
 <5de38fe3-4a73-443b-87d1-0c836ffdbe30@linux.alibaba.com>
In-Reply-To: <5de38fe3-4a73-443b-87d1-0c836ffdbe30@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 28 Apr 2025 08:47:15 -0600
X-Gm-Features: ATxdqUFjy2qJlYlOt48ZRabeCVJgfUsYAeyPhh9bvAeZHSwObmUxYSjsHfeo0u8
Message-ID: <CAA1CXcAiiBJ4mMp0WJUk7tWTF20guJi80P8wBh271yJ9P+c_VA@mail.gmail.com>
Subject: Re: [PATCH v4 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
	baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org, 
	peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com, 
	hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
	rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1BsrpkhTOnRLlKVqslIQrYj9KY6wxzXUGFyVz8rUVQg_1745851661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 8:52=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/4/17 08:02, Nico Pache wrote:
> > khugepaged scans PMD ranges for potential collapse to a hugepage. To ad=
d
> > mTHP support we use this scan to instead record chunks of utilized
> > sections of the PMD.
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
> > When attempting to collapse an order that has its order set to "always"
> > lets always collapse to that order in a greedy manner without
> > considering the number of bits set.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   include/linux/khugepaged.h |  4 ++
> >   mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++---=
-
> >   2 files changed, 89 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index 1f46046080f5..18fe6eb5051d 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -1,6 +1,10 @@
> >   /* SPDX-License-Identifier: GPL-2.0 */
> >   #ifndef _LINUX_KHUGEPAGED_H
> >   #define _LINUX_KHUGEPAGED_H
> > +#define KHUGEPAGED_MIN_MTHP_ORDER    2
>
> Why is the minimum mTHP order set to 2? IMO, the file large folios can
> support order 1, so we don't expect to collapse exec file small folios
> to order 1 if possible?
I should have been more specific in the patch notes, but this affects
anonymous only. I'll go over my commit messages and make sure this is
reflected in the next version.
>
> (PS: I need more time to understand your logic in this patch, and any
> additional explanation would be helpful:) )

We are currently scanning ptes in a PMD. The core principle/reasoning
behind the bitmap is to keep the PMD scan while saving its state. We
then use this bitmap to determine which chunks of the PMD are active
and are the best candidates for mTHP collapse. We start at the PMD
level, and recursively break down the bitmap to find the appropriate
sizes for the bitmap.

looking at a simplified example: we scan a PMD and get the following
bitmap, 1111101101101011 (in this case MIN_MTHP_ORDER=3D 5, so each bit
=3D=3D 32 ptes, in the actual set each bit =3D=3D 4 ptes).
We would first attempt a PMD collapse, while checking the number of
bits set vs the max_ptes_none tunable. If those conditions arent
triggered, we will try the next enabled mTHP order, for each half of
the bitmap.

ie) order 8 attempt on 11111011 and order 8 attempt on 01101011.

If a collapse succeeds we dont keep recursing on that portion of the
bitmap. If not, we continue attempting lower orders.

Hopefully that helps you understand my logic here! Let me know if you
need more clarification.

I gave a presentation on this that might help too:
https://docs.google.com/presentation/d/1w9NYLuC2kRcMAwhcashU1LWTfmI5TIZRaTW=
uZq-CHEg/edit?usp=3Dsharing&resourcekey=3D0-nBAGld8cP1kW26XE6i0Bpg

Cheers,
-- Nico
>
> > +#define KHUGEPAGED_MIN_MTHP_NR       (1<<KHUGEPAGED_MIN_MTHP_ORDER)
> > +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPA=
GED_MIN_MTHP_ORDER))
> > +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP=
_ORDER))
> >
> >   extern unsigned int khugepaged_max_ptes_none __read_mostly;
> >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5e9272ab82da..83230e9cdf3a 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, M=
M_SLOTS_HASH_BITS);
> >
> >   static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> > +struct scan_bit_state {
> > +     u8 order;
> > +     u16 offset;
> > +};
> > +
> >   struct collapse_control {
> >       bool is_khugepaged;
> >
> > @@ -102,6 +107,18 @@ struct collapse_control {
> >
> >       /* nodemask for allocation fallback */
> >       nodemask_t alloc_nmask;
> > +
> > +     /*
> > +      * bitmap used to collapse mTHP sizes.
> > +      * 1bit =3D order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> > +      */
> > +     DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> > +     DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> > +     struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> > +};
> > +
> > +struct collapse_control khugepaged_collapse_control =3D {
> > +     .is_khugepaged =3D true,
> >   };
> >
> >   /**
> > @@ -851,10 +868,6 @@ static void khugepaged_alloc_sleep(void)
> >       remove_wait_queue(&khugepaged_wait, &wait);
> >   }
> >
> > -struct collapse_control khugepaged_collapse_control =3D {
> > -     .is_khugepaged =3D true,
> > -};
> > -
> >   static bool khugepaged_scan_abort(int nid, struct collapse_control *c=
c)
> >   {
> >       int i;
> > @@ -1118,7 +1131,8 @@ static int alloc_charge_folio(struct folio **foli=
op, struct mm_struct *mm,
> >
> >   static int collapse_huge_page(struct mm_struct *mm, unsigned long add=
ress,
> >                             int referenced, int unmapped,
> > -                           struct collapse_control *cc)
> > +                           struct collapse_control *cc, bool *mmap_loc=
ked,
> > +                               u8 order, u16 offset)
> >   {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > @@ -1137,8 +1151,12 @@ static int collapse_huge_page(struct mm_struct *=
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
> > @@ -1273,12 +1291,72 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >   out_up_write:
> >       mmap_write_unlock(mm);
> >   out_nolock:
> > +     *mmap_locked =3D false;
> >       if (folio)
> >               folio_put(folio);
> >       trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, resul=
t);
> >       return result;
> >   }
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
> > +     bool is_pmd_only =3D (enabled_orders =3D=3D (1 << HPAGE_PMD_ORDER=
));
> > +
> > +     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit_state)
> > +             { HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> > +
> > +     while (top >=3D 0) {
> > +             state =3D cc->mthp_bitmap_stack[top--];
> > +             order =3D state.order + KHUGEPAGED_MIN_MTHP_ORDER;
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
> > +             if (bits_set > threshold_bits || is_pmd_only
> > +                     || test_bit(order, &huge_anon_orders_always)) {
> > +                     ret =3D collapse_huge_page(mm, address, reference=
d, unmapped, cc,
> > +                                     mmap_locked, order, offset * KHUG=
EPAGED_MIN_MTHP_NR);
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
> > +
> >   static int khugepaged_scan_pmd(struct mm_struct *mm,
> >                                  struct vm_area_struct *vma,
> >                                  unsigned long address, bool *mmap_lock=
ed,
> > @@ -1445,9 +1523,7 @@ static int khugepaged_scan_pmd(struct mm_struct *=
mm,
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               result =3D collapse_huge_page(mm, address, referenced,
> > -                                         unmapped, cc);
> > -             /* collapse_huge_page will return with the mmap_lock rele=
ased */
> > -             *mmap_locked =3D false;
> > +                                         unmapped, cc, mmap_locked, HP=
AGE_PMD_ORDER, 0);
> >       }
> >   out:
> >       trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenc=
ed,
>

