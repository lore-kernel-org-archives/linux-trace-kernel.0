Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14D17B500
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Mar 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378473; cv=none; b=qdl9wqcq4wpysAv6imydrFYIBNS8j2F/R/m8b4hXJB5n0if+2ZRBprO44Fw9V8yKHDzNFaTa/CZWPcIOtD083Cnyc4GApHqnq6HU20g2fP5dLhGgUujpwDl0NbstJIZD1iOahjLaNjGH0z6MIOIAwGU8tY1q6Y/v82zNd+QJpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378473; c=relaxed/simple;
	bh=vOXoeGDY8OTimLHEkiYdUw51amNFl3KTjwJWTZrMeXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQqI/nQ0VuJpY27z3XlkkhVnB+uej1GTLtj6LXXzGpsauSPtUBUl7BBwFS/fnAXLYx+S+5kWYOgdkYIlNnb2kKikVQZIbZgvS2v80kNsxbQIK1FbBwqmC6y4t+3r2DUnNj4A0tKn119YJ+nkTH3bmbBOtOkI5dLH7B+XhV7m4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KH0h0Ol2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KH0h0Ol2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741378470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxJwtmM4tDaaaJtUoJYUBJHeB22i/CfDT0FW05ETxfY=;
	b=KH0h0Ol2U65XIrovcrwYm65ULZBKPlfulKokyyVT1skciYeZazT5rYbAWWVivump/KusIi
	31LuTK/N3kWqoyhM86KjzlgWT2g7R2veuCL4gW3fpZd8uk7llqzgMT/BAOGUQRZ4pBVW4K
	DbdilKznBueTNnui8ls8rMDQtiSZx44=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-OaMH3zQrOm6Qi24EMj8PGA-1; Fri, 07 Mar 2025 15:14:29 -0500
X-MC-Unique: OaMH3zQrOm6Qi24EMj8PGA-1
X-Mimecast-MFC-AGG-ID: OaMH3zQrOm6Qi24EMj8PGA_1741378469
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f6d40a61e7so31999567b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Mar 2025 12:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741378469; x=1741983269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxJwtmM4tDaaaJtUoJYUBJHeB22i/CfDT0FW05ETxfY=;
        b=RCV9xM8KKAcIsUm33/0JuY+QEC/Sk6oq3T5ybaw8juArfDltfHraQicEkBzCAaU8sJ
         hoW+N3stDP2ZWf+TJWeI1HkTx4B5Mw6Ijy5ItmmAz53rjTw2r4+ehOsU7lgS3u0ZV2z6
         7Lt/uNFig2RyJJMG0dcJmJvoCQpnVHQg7kmqRqgO+HKh+v3FdrfycP2SUnigpoCI0pu8
         dI/5rvvY7OZm6f2xJpTg4IvpjkicC3kLel1gSNJ+zOWmb59M0fTKn/tX99ZZYdh8+8L3
         mC9GylaoiFx74wMCjA+pRQgykpPS5RBzTfXpWf+XEExzgexPn7+2AMF/kI9g8ayQczaX
         udVg==
X-Forwarded-Encrypted: i=1; AJvYcCVSLeC8qlNnTOx9ldQXubiAicph0Lwe4bt6Pimc/5gn9ec8wlvX/Ozbll0CRvKCP7Cr5BudW8ydzGzAMWKlWxnLuvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GebFyGQu5gGXpWqbm7balgV0lWYxeijv5O8Q+zNyWG7ZRnsv
	DpKyHScDO6zTXwPCpVCToHgGzQmCCCDeG/CL8s247knGRfS3+enCTvXcdWoNgBzPvKz5dBml7a3
	VQyzo6G4QVryALslyWiBQuxzJvHfuVs/9LUyLRIf5R5fDi6Dfx3f/psbme6G4GmISJq7ke6znRk
	2ikR5aelS9ptycJJo3jTocqbOO35BXS+dWwuovfmsXg9kK
X-Gm-Gg: ASbGnctW4KnFdy3uH/eE0AxvbPzCzRl2q1luUNhyAqr4EgckxR1PU15a9g5g07MUI0W
	f9aNMEdiLk73EwPijViycwwzlOBjmu1keMEpz9TrPjy9xuV9JxW9fsl4aqUUOvFqFnLh31kYwuu
	wC3f+ypObLCCU=
X-Received: by 2002:a05:6902:1b88:b0:e60:917e:c365 with SMTP id 3f1490d57ef6-e635c1e53f5mr7556199276.39.1741378468914;
        Fri, 07 Mar 2025 12:14:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa0o1vIToV9Ki6RpIRTfu6uhnuUYlkzlEzYpPrIVMKmsIQx94IzSW44ADtFxldFJHtOj7rJvIrYLlvd1vnEUg=
X-Received: by 2002:a05:6902:1b88:b0:e60:917e:c365 with SMTP id
 3f1490d57ef6-e635c1e53f5mr7556124276.39.1741378468407; Fri, 07 Mar 2025
 12:14:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-8-npache@redhat.com>
 <b246b91b-4b4f-4582-ad3b-8b3adde834e2@arm.com>
In-Reply-To: <b246b91b-4b4f-4582-ad3b-8b3adde834e2@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 7 Mar 2025 15:14:02 -0500
X-Gm-Features: AQ5f1JrsYD5ErZEtl6MzA_CGtoPY8FlM3OZ2C20cuAEoNcCrUY3puHoOso34hkc
Message-ID: <CAA1CXcA+E8BLZ3SfL8jeGSY8hRF0BgzSuWDUA70J_z28NU5_Cw@mail.gmail.com>
Subject: Re: [RFC v2 7/9] khugepaged: add mTHP support
To: Dev Jain <dev.jain@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, 
	apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org, 
	baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu, 
	haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org, 
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com, 
	surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com, 
	zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com, 
	willy@infradead.org, kirill.shutemov@linux.intel.com, david@redhat.com, 
	aarcange@redhat.com, raquini@redhat.com, sunnanyong@huawei.com, 
	usamaarif642@gmail.com, audra@redhat.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zNptWKV_IvXStt4iRBAG083xjVPNkhAouHP6TrsS82k_1741378469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:39=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 11/02/25 6:00 am, Nico Pache wrote:
> > Introduce the ability for khugepaged to collapse to different mTHP size=
s.
> > While scanning a PMD range for potential collapse candidates, keep trac=
k
> > of pages in MIN_MTHP_ORDER chunks via a bitmap. Each bit represents a
> > utilized region of order MIN_MTHP_ORDER ptes. We remove the restriction
> > of max_ptes_none during the scan phase so we dont bailout early and mis=
s
> > potential mTHP candidates.
> >
> > After the scan is complete we will perform binary recursion on the
> > bitmap to determine which mTHP size would be most efficient to collapse
> > to. max_ptes_none will be scaled by the attempted collapse order to
> > determine how full a THP must be to be eligible.
> >
> > If a mTHP collapse is attempted, but contains swapped out, or shared
> > pages, we dont perform the collapse.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 122 ++++++++++++++++++++++++++++++++---------------=
-
> >   1 file changed, 83 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index c8048d9ec7fb..cd310989725b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1127,13 +1127,14 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >   {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > -     pte_t *pte;
> > +     pte_t *pte, mthp_pte;
> >       pgtable_t pgtable;
> >       struct folio *folio;
> >       spinlock_t *pmd_ptl, *pte_ptl;
> >       int result =3D SCAN_FAIL;
> >       struct vm_area_struct *vma;
> >       struct mmu_notifier_range range;
> > +     unsigned long _address =3D address + offset * PAGE_SIZE;
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> >       /*
> > @@ -1148,12 +1149,13 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >               *mmap_locked =3D false;
> >       }
> >
> > -     result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> > +     result =3D alloc_charge_folio(&folio, mm, cc, order);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_nolock;
> >
> >       mmap_read_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, H=
PAGE_PMD_ORDER);
> > +     *mmap_locked =3D true;
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, o=
rder);
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> >               goto out_nolock;
> > @@ -1171,13 +1173,14 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >                * released when it fails. So we jump out_nolock directly=
 in
> >                * that case.  Continuing to collapse causes inconsistenc=
y.
> >                */
> > -             result =3D __collapse_huge_page_swapin(mm, vma, address, =
pmd,
> > -                             referenced, HPAGE_PMD_ORDER);
> > +             result =3D __collapse_huge_page_swapin(mm, vma, _address,=
 pmd,
> > +                             referenced, order);
> >               if (result !=3D SCAN_SUCCEED)
> >                       goto out_nolock;
> >       }
> >
> >       mmap_read_unlock(mm);
> > +     *mmap_locked =3D false;
> >       /*
> >        * Prevent all access to pagetables with the exception of
> >        * gup_fast later handled by the ptep_clear_flush and the VM
> > @@ -1187,7 +1190,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, H=
PAGE_PMD_ORDER);
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, o=
rder);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> > @@ -1198,11 +1201,12 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >       vma_start_write(vma);
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > -     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > -                             address + HPAGE_PMD_SIZE);
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address=
,
> > +                             _address + (PAGE_SIZE << order));
> >       mmu_notifier_invalidate_range_start(&range);
> >
> >       pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> > +
> >       /*
> >        * This removes any huge TLB entry from the CPU so we won't allow
> >        * huge and small TLB entries for the same virtual address to
> > @@ -1216,10 +1220,10 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >       mmu_notifier_invalidate_range_end(&range);
> >       tlb_remove_table_sync_one();
> >
> > -     pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> > +     pte =3D pte_offset_map_lock(mm, &_pmd, _address, &pte_ptl);
> >       if (pte) {
> > -             result =3D __collapse_huge_page_isolate(vma, address, pte=
, cc,
> > -                                     &compound_pagelist, HPAGE_PMD_ORD=
ER);
> > +             result =3D __collapse_huge_page_isolate(vma, _address, pt=
e, cc,
> > +                                     &compound_pagelist, order);
> >               spin_unlock(pte_ptl);
> >       } else {
> >               result =3D SCAN_PMD_NULL;
> > @@ -1248,8 +1252,8 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       anon_vma_unlock_write(vma->anon_vma);
> >
> >       result =3D __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> > -                                        vma, address, pte_ptl,
> > -                                        &compound_pagelist, HPAGE_PMD_=
ORDER);
> > +                                        vma, _address, pte_ptl,
> > +                                        &compound_pagelist, order);
> >       pte_unmap(pte);
> >       if (unlikely(result !=3D SCAN_SUCCEED))
> >               goto out_up_write;
> > @@ -1260,20 +1264,37 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >        * write.
> >        */
> >       __folio_mark_uptodate(folio);
> > -     pgtable =3D pmd_pgtable(_pmd);
> > -
> > -     _pmd =3D mk_huge_pmd(&folio->page, vma->vm_page_prot);
> > -     _pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> > -
> > -     spin_lock(pmd_ptl);
> > -     BUG_ON(!pmd_none(*pmd));
> > -     folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
> > -     folio_add_lru_vma(folio, vma);
> > -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > -     set_pmd_at(mm, address, pmd, _pmd);
> > -     update_mmu_cache_pmd(vma, address, pmd);
> > -     deferred_split_folio(folio, false);
> > -     spin_unlock(pmd_ptl);
> > +     if (order =3D=3D HPAGE_PMD_ORDER) {
> > +             pgtable =3D pmd_pgtable(_pmd);
> > +             _pmd =3D mk_huge_pmd(&folio->page, vma->vm_page_prot);
> > +             _pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> > +
> > +             spin_lock(pmd_ptl);
> > +             BUG_ON(!pmd_none(*pmd));
> > +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUS=
IVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > +             set_pmd_at(mm, address, pmd, _pmd);
> > +             update_mmu_cache_pmd(vma, address, pmd);
> > +             deferred_split_folio(folio, false);
> > +             spin_unlock(pmd_ptl);
> > +     } else { //mTHP
> > +             mthp_pte =3D mk_pte(&folio->page, vma->vm_page_prot);
> > +             mthp_pte =3D maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> > +
> > +             spin_lock(pmd_ptl);
>
> Please add a BUG_ON(!pmd_none(*pmd)) here. I hit this a lot of times
> when I was generalizing for VMA size.

The PMD has been removed until the PMD_populate. The BUG_ON will
always be hit if we do this.
>
> > +             folio_ref_add(folio, (1 << order) - 1);
> > +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUS=
IVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             spin_lock(pte_ptl);
> > +             set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order=
));
> > +             update_mmu_cache_range(NULL, vma, _address, pte, (1 << or=
der));
> > +             spin_unlock(pte_ptl);
> > +             smp_wmb(); /* make pte visible before pmd */
> > +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > +             deferred_split_folio(folio, false);
> > +             spin_unlock(pmd_ptl);
> > +     }
> >
> >       folio =3D NULL;
> >
> > @@ -1353,21 +1374,27 @@ static int khugepaged_scan_pmd(struct mm_struct=
 *mm,
> >   {
> >       pmd_t *pmd;
> >       pte_t *pte, *_pte;
> > +     int i;
> >       int result =3D SCAN_FAIL, referenced =3D 0;
> >       int none_or_zero =3D 0, shared =3D 0;
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       unsigned long _address;
> > +     unsigned long enabled_orders;
> >       spinlock_t *ptl;
> >       int node =3D NUMA_NO_NODE, unmapped =3D 0;
> >       bool writable =3D false;
> > -
> > +     int chunk_none_count =3D 0;
> > +     int scaled_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER =
- MIN_MTHP_ORDER);
> > +     unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> >       result =3D find_pmd_or_thp_or_none(mm, address, &pmd);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out;
> >
> > +     bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> > +     bitmap_zero(cc->mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> >       memset(cc->node_load, 0, sizeof(cc->node_load));
> >       nodes_clear(cc->alloc_nmask);
> >       pte =3D pte_offset_map_lock(mm, pmd, address, &ptl);
> > @@ -1376,8 +1403,12 @@ static int khugepaged_scan_pmd(struct mm_struct =
*mm,
> >               goto out;
> >       }
> >
> > -     for (_address =3D address, _pte =3D pte; _pte < pte + HPAGE_PMD_N=
R;
> > -          _pte++, _address +=3D PAGE_SIZE) {
> > +     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +             if (i % MIN_MTHP_NR =3D=3D 0)
> > +                     chunk_none_count =3D 0;
> > +
> > +             _pte =3D pte + i;
> > +             _address =3D address + i * PAGE_SIZE;
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (is_swap_pte(pteval)) {
> >                       ++unmapped;
> > @@ -1400,16 +1431,14 @@ static int khugepaged_scan_pmd(struct mm_struct=
 *mm,
> >                       }
> >               }
> >               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > +                     ++chunk_none_count;
> >                       ++none_or_zero;
> > -                     if (!userfaultfd_armed(vma) &&
> > -                         (!cc->is_khugepaged ||
> > -                          none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> > -                             continue;
> > -                     } else {
> > +                     if (userfaultfd_armed(vma)) {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> >                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> >                               goto out_unmap;
> >                       }
> > +                     continue;
> >               }
> >               if (pte_uffd_wp(pteval)) {
> >                       /*
> > @@ -1500,7 +1529,16 @@ static int khugepaged_scan_pmd(struct mm_struct =
*mm,
> >                    folio_test_referenced(folio) || mmu_notifier_test_yo=
ung(vma->vm_mm,
> >                                                                    addr=
ess)))
> >                       referenced++;
> > +
> > +             /*
> > +              * we are reading in MIN_MTHP_NR page chunks. if there ar=
e no empty
> > +              * pages keep track of it in the bitmap for mTHP collapsi=
ng.
> > +              */
> > +             if (chunk_none_count < scaled_none &&
> > +                     (i + 1) % MIN_MTHP_NR =3D=3D 0)
> > +                     bitmap_set(cc->mthp_bitmap, i / MIN_MTHP_NR, 1);
> >       }
> > +
> >       if (!writable) {
> >               result =3D SCAN_PAGE_RO;
> >       } else if (cc->is_khugepaged &&
> > @@ -1513,10 +1551,14 @@ static int khugepaged_scan_pmd(struct mm_struct=
 *mm,
> >   out_unmap:
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> > -             result =3D collapse_huge_page(mm, address, referenced,
> > -                                         unmapped, cc, mmap_locked, HP=
AGE_PMD_ORDER, 0);
> > -             /* collapse_huge_page will return with the mmap_lock rele=
ased */
> > -             *mmap_locked =3D false;
> > +             enabled_orders =3D thp_vma_allowable_orders(vma, vma->vm_=
flags,
> > +                     tva_flags, THP_ORDERS_ALL_ANON);
> > +             result =3D khugepaged_scan_bitmap(mm, address, referenced=
, unmapped, cc,
> > +                            mmap_locked, enabled_orders);
> > +             if (result > 0)
> > +                     result =3D SCAN_SUCCEED;
> > +             else
> > +                     result =3D SCAN_FAIL;
> >       }
> >   out:
> >       trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenc=
ed,
> > @@ -2476,11 +2518,13 @@ static int khugepaged_collapse_single_pmd(unsig=
ned long addr, struct mm_struct *
> >                       fput(file);
> >                       if (result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> >                               mmap_read_lock(mm);
> > +                             *mmap_locked =3D true;
> >                               if (khugepaged_test_exit_or_disable(mm))
> >                                       goto end;
> >                               result =3D collapse_pte_mapped_thp(mm, ad=
dr,
> >                                                                !cc->is_=
khugepaged);
> >                               mmap_read_unlock(mm);
> > +                             *mmap_locked =3D false;
> >                       }
> >               } else {
> >                       result =3D khugepaged_scan_pmd(mm, vma, addr,
>

