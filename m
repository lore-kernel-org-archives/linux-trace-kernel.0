Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756A610B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Apr 2025 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672048; cv=none; b=WF2XAO2F3zuNNyAuHDpuCHG6+Z1jBbw4Nir00Z0YpoL3o7FCmdDcZKSXgcrVT/rMITCahu3LSijF2TeARAudMedyOaBnxml1cAHxBQXPYo2j39a4i7tkWqUW0jIeyz4bx3oqA6XfJY/mrrwQEEqgxGBU4lUPEVG2+dGrr/sEenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672048; c=relaxed/simple;
	bh=OEzAoWxkcoAZNkHEwwfqpyyXY9JNYhsYRJtR/fY5Gqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEFrvHRL1nNqPHVoXad8BRB5aVY2ejmHpbV/+1asLIOgEBoj3AbFmHAsn4bSjFmsvbVfD7icsB+Rbsr2vfUpmL5JrFFRztyljGFs5IwKHUBj/rvzg/2x1zRADtkCxMsVNdvME6RTn8GGj4GgLJM7c31svL1hprms1qwvuMKvTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPNbsRm5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPNbsRm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744672044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5z2W/vB4qTifn8WM4HHvRVs16lLzfzPDjDBHTYrdpng=;
	b=cPNbsRm5xkMeKQF55Iin2kunqIyOw8rnGuErkUQMB665IPD3EcGkTO4D0CIKsTBQmn+Jbe
	Qb2xsWdlcj7AfqXjyPslkDTvvB0eYy94vysThYPfdWL57RRcAKb5BLw0SYMNEbNg8tvyyk
	a5p+AL3TQ3RYDqvXEbeZGfMNRwzmkDA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-jXAv2sjqMH6A6g0tlPbK1g-1; Mon, 14 Apr 2025 19:07:22 -0400
X-MC-Unique: jXAv2sjqMH6A6g0tlPbK1g-1
X-Mimecast-MFC-AGG-ID: jXAv2sjqMH6A6g0tlPbK1g_1744672042
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e6dfe7fe81aso7431033276.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Apr 2025 16:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672042; x=1745276842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z2W/vB4qTifn8WM4HHvRVs16lLzfzPDjDBHTYrdpng=;
        b=ul/Q9dHhMUXsCZdeTjWEjDRnPPODhYBO8i4SBVk5zF18K32x6ruSrXqkE6nNM9KR2e
         kAmbMckHFmmXrXOEFD88T3aq+SFvHtGrDAWLVeOoJ47P5/imMLnDQGo+X8M9vBS2cfnP
         5eHbE4eWTFPYjvD6KWbZTU4hsAaN74tD8ko0dIZOuMI9Bg8E80YxQKe0eNhos4Bbebmj
         AjixYwjwgNRPpRKMLAnar5HiWI5RVvs7dAAoLXhvn+GU8q/1dseMyBOp6p3fmxUO93Kg
         BgHqOFcU6QW1wlEAn1P7wIXSu1lNnHzNY+mOsDAU8e/CDjr/NQAUs5cgRFtBl8kArjQZ
         Jy3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdN/1OjvnKO+ivACIoch/nmYX9C6Wn+ax/NP0jDpusFChcVPw1PU3f9novSBtW8D89SBjwgVlcKav2MIiKExoFnNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytlqohe0aV9Rdw9qlT/4BrARlZiT1oeTyWuGl4Y3SRmXA0rzCX
	GJ0tuKe8CMIsxbWvpUg7NtAXEBrUJRv6Ub9EoDUTYF8sc/Zs9vAThvzyL5Z5Txgwas8c5Kg4n58
	RhbgvOLDsyKyhiSnzv2d+zLS96STMxiWlj2UAgigYOKvyA9GcRJk5bsLaC1USVVZc4lln3GNW6D
	8fQrJyM2UzsVJvwkwA+g5bbk5hJNTAZXAHd5MMkxOJJkX1
X-Gm-Gg: ASbGncs2OJFjrKfjiN4jT58++mj7ykzKN73dfH85VjR0bk95CGr9YjHRfXdy3lKomAA
	JBIZL3TLWNbWkfhYF3WE8LUnVkxO0C48SOs9gT+idsPnRb335xOUlPNM7QXjA4aGqC2yfgywOQt
	QBEtGmFy4=
X-Received: by 2002:a05:6902:240c:b0:e6d:ef29:169f with SMTP id 3f1490d57ef6-e704e0237d5mr22741950276.43.1744672041881;
        Mon, 14 Apr 2025 16:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpS6tCEdscY1ajpLXCS4mBTPxFQbVyi9luS1V24YEngOuYvYNvKWibleSBgqlIYifpvJdb8ua2eT/UxAod2Rw=
X-Received: by 2002:a05:6902:240c:b0:e6d:ef29:169f with SMTP id
 3f1490d57ef6-e704e0237d5mr22741888276.43.1744672041327; Mon, 14 Apr 2025
 16:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414220557.35388-1-npache@redhat.com> <20250414220557.35388-7-npache@redhat.com>
In-Reply-To: <20250414220557.35388-7-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 14 Apr 2025 17:06:55 -0600
X-Gm-Features: ATxdqUH4QUCNJG6cSyqRQldW0r1-zIVuLoCx1f8277YmMIgHsCkj4qzTqmin7Mc
Message-ID: <CAA1CXcAo2gUmD8=0xKw-y=rLyUz0PyO7ObHB3ukG1LGikJY27g@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, 
	willy@infradead.org, peterx@redhat.com, ziy@nvidia.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
	aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wo2Y07px70lQ_FEFy01SmEWdjXcJHIGYXMGC_kG135g_1744672042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:07=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> khugepaged scans PMD ranges for potential collapse to a hugepage. To add
> mTHP support we use this scan to instead record chunks of fully utilized
> sections of the PMD.
>
> create a bitmap to represent a PMD in order MIN_MTHP_ORDER chunks.
> by default we will set this to order 3. The reasoning is that for 4K 512
> PMD size this results in a 64 bit bitmap which has some optimizations.
> For other arches like ARM64 64K, we can set a larger order if needed.
>
> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
> that represents chunks of utilized regions. We can then determine what
> mTHP size fits best and in the following patch, we set this bitmap while
> scanning the PMD.
>
> max_ptes_none is used as a scale to determine how "full" an order must
> be before being considered for collapse.
>
> If a order is set to "always" lets always collapse to that order in a
> greedy manner.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/khugepaged.h |  4 ++
>  mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 89 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 1f46046080f5..60d41215bc1a 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -1,6 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_KHUGEPAGED_H
>  #define _LINUX_KHUGEPAGED_H
> +#define KHUGEPAGED_MIN_MTHP_ORDER      3
Somehow managed to drop
#define KHUGEPAGED_MIN_MTHP_ORDER 2
When cleaning up my patches.

Sending a V4 of just this patch in reply to this email.

Sorry for the noise...



> +#define KHUGEPAGED_MIN_MTHP_NR (1<<KHUGEPAGED_MIN_MTHP_ORDER)
> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGE=
D_MIN_MTHP_ORDER))
> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_O=
RDER))
>
>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index dfecedc6a515..5a3be30096fc 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_=
SLOTS_HASH_BITS);
>
>  static struct kmem_cache *mm_slot_cache __ro_after_init;
>
> +struct scan_bit_state {
> +       u8 order;
> +       u16 offset;
> +};
> +
>  struct collapse_control {
>         bool is_khugepaged;
>
> @@ -102,6 +107,18 @@ struct collapse_control {
>
>         /* nodemask for allocation fallback */
>         nodemask_t alloc_nmask;
> +
> +       /*
> +        * bitmap used to collapse mTHP sizes.
> +        * 1bit =3D order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> +        */
> +       DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +       DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> +       struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> +};
> +
> +struct collapse_control khugepaged_collapse_control =3D {
> +       .is_khugepaged =3D true,
>  };
>
>  /**
> @@ -851,10 +868,6 @@ static void khugepaged_alloc_sleep(void)
>         remove_wait_queue(&khugepaged_wait, &wait);
>  }
>
> -struct collapse_control khugepaged_collapse_control =3D {
> -       .is_khugepaged =3D true,
> -};
> -
>  static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>  {
>         int i;
> @@ -1118,7 +1131,8 @@ static int alloc_charge_folio(struct folio **foliop=
, struct mm_struct *mm,
>
>  static int collapse_huge_page(struct mm_struct *mm, unsigned long addres=
s,
>                               int referenced, int unmapped,
> -                             struct collapse_control *cc)
> +                             struct collapse_control *cc, bool *mmap_loc=
ked,
> +                                 u8 order, u16 offset)
>  {
>         LIST_HEAD(compound_pagelist);
>         pmd_t *pmd, _pmd;
> @@ -1137,8 +1151,12 @@ static int collapse_huge_page(struct mm_struct *mm=
, unsigned long address,
>          * The allocation can take potentially a long time if it involves
>          * sync compaction, and we do not need to hold the mmap_lock duri=
ng
>          * that. We will recheck the vma after taking it again in write m=
ode.
> +        * If collapsing mTHPs we may have already released the read_lock=
.
>          */
> -       mmap_read_unlock(mm);
> +       if (*mmap_locked) {
> +               mmap_read_unlock(mm);
> +               *mmap_locked =3D false;
> +       }
>
>         result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>         if (result !=3D SCAN_SUCCEED)
> @@ -1273,12 +1291,72 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
>  out_up_write:
>         mmap_write_unlock(mm);
>  out_nolock:
> +       *mmap_locked =3D false;
>         if (folio)
>                 folio_put(folio);
>         trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, resul=
t);
>         return result;
>  }
>
> +// Recursive function to consume the bitmap
> +static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long ad=
dress,
> +                       int referenced, int unmapped, struct collapse_con=
trol *cc,
> +                       bool *mmap_locked, unsigned long enabled_orders)
> +{
> +       u8 order, next_order;
> +       u16 offset, mid_offset;
> +       int num_chunks;
> +       int bits_set, threshold_bits;
> +       int top =3D -1;
> +       int collapsed =3D 0;
> +       int ret;
> +       struct scan_bit_state state;
> +       bool is_pmd_only =3D (enabled_orders =3D=3D (1 << HPAGE_PMD_ORDER=
));
> +
> +       cc->mthp_bitmap_stack[++top] =3D (struct scan_bit_state)
> +               { HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> +
> +       while (top >=3D 0) {
> +               state =3D cc->mthp_bitmap_stack[top--];
> +               order =3D state.order + KHUGEPAGED_MIN_MTHP_ORDER;
> +               offset =3D state.offset;
> +               num_chunks =3D 1 << (state.order);
> +               // Skip mTHP orders that are not enabled
> +               if (!test_bit(order, &enabled_orders))
> +                       goto next;
> +
> +               // copy the relavant section to a new bitmap
> +               bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap,=
 offset,
> +                                 MTHP_BITMAP_SIZE);
> +
> +               bits_set =3D bitmap_weight(cc->mthp_bitmap_temp, num_chun=
ks);
> +               threshold_bits =3D (HPAGE_PMD_NR - khugepaged_max_ptes_no=
ne - 1)
> +                               >> (HPAGE_PMD_ORDER - state.order);
> +
> +               //Check if the region is "almost full" based on the thres=
hold
> +               if (bits_set > threshold_bits || is_pmd_only
> +                       || test_bit(order, &huge_anon_orders_always)) {
> +                       ret =3D collapse_huge_page(mm, address, reference=
d, unmapped, cc,
> +                                       mmap_locked, order, offset * KHUG=
EPAGED_MIN_MTHP_NR);
> +                       if (ret =3D=3D SCAN_SUCCEED) {
> +                               collapsed +=3D (1 << order);
> +                               continue;
> +                       }
> +               }
> +
> +next:
> +               if (state.order > 0) {
> +                       next_order =3D state.order - 1;
> +                       mid_offset =3D offset + (num_chunks / 2);
> +                       cc->mthp_bitmap_stack[++top] =3D (struct scan_bit=
_state)
> +                               { next_order, mid_offset };
> +                       cc->mthp_bitmap_stack[++top] =3D (struct scan_bit=
_state)
> +                               { next_order, offset };
> +                       }
> +       }
> +       return collapsed;
> +}
> +
>  static int khugepaged_scan_pmd(struct mm_struct *mm,
>                                    struct vm_area_struct *vma,
>                                    unsigned long address, bool *mmap_lock=
ed,
> @@ -1445,9 +1523,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm=
,
>         pte_unmap_unlock(pte, ptl);
>         if (result =3D=3D SCAN_SUCCEED) {
>                 result =3D collapse_huge_page(mm, address, referenced,
> -                                           unmapped, cc);
> -               /* collapse_huge_page will return with the mmap_lock rele=
ased */
> -               *mmap_locked =3D false;
> +                                           unmapped, cc, mmap_locked, HP=
AGE_PMD_ORDER, 0);
>         }
>  out:
>         trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenc=
ed,
> --
> 2.48.1
>

