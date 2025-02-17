Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FED226545
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827378; cv=none; b=EtbDiCeOjMh65qxHJXoR7Ua9UXYC25Ii1fPCK3pucKBtW0thJVcuaE21aMT1zywgj6eevtzXagD6xGALZ2Xbkc71Dk8bjWQX/HVGJ98JGIPnLbsrp6xj0uG3TVMsxX6/DKBXzwT/DolTxdKi7nz1UFU6v/5Cfbjj68o6emVQi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827378; c=relaxed/simple;
	bh=qluJQvrRJ+MswdbhwXHCV2wiKgOYpzV6Fog8wkzgh3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATGEXJOHU2LvIxaBWGkpKLyaZCL/ZPLy3rY5kC25HaRnrfrU1YDdDWtuNM+/ZnMTvji5kJ7L58iQkLYODruQR3Ymy+Nk8V4hPt9yl+kX2XWzWjooE3DUzaAVjv0m4CBw9Oe/93RIx5yecP8tRd6PGFOdcD7fbJvLAQx/Tr9J/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=femupMse; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="femupMse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739827375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eG6T8JcLfwLox/I5xgQezPSrfEMMz3m/GHZxMCyEUJ0=;
	b=femupMseDI4cfFT6LG/Zz3yx1ufBqLHR7o1sgi7mvwGzMmbye6fj31zV0dxMCmXFZgV6Pw
	tNd88FjtL99bqf12HmHqxtj5AarFBQZUuogaayXeA2XvZ2kVbxq2OjR0bFx2qo6ogtQc/P
	j8mM8VvI+CszWB7zCLhA9IcgKxVxalI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-7C16RHhANR6lx5dKo44ccA-1; Mon, 17 Feb 2025 16:22:54 -0500
X-MC-Unique: 7C16RHhANR6lx5dKo44ccA-1
X-Mimecast-MFC-AGG-ID: 7C16RHhANR6lx5dKo44ccA_1739827374
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6f4348c854eso64291977b3.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739827374; x=1740432174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eG6T8JcLfwLox/I5xgQezPSrfEMMz3m/GHZxMCyEUJ0=;
        b=BemX7r8Z7dWl5AnqYBNzjffxawLEgfMQCXYtXMQTNbh+1WY/C6YGBH2VdyMNyHJwpP
         q9yz8xDI4xUyABTiyX0CJ9zhIT5SLssXgcT4v31pqEaijx7Yz9a3M5ZzBHnArFihgmcR
         Mj/BJ15Shxm1pBXQ8DAnWWfhHGHA7kua2jYccwP6BqYClYSPcYI1ppV/u4/Tp1uAh4g1
         RqG07a3+so07ehZvEvFgofraQKBrpw4kGYsTa+PzZR7xgLgdNHMR4zaZ1i0t3xmIwJiK
         8U+RTLL+Xb8E168IxZIqywHwVOyU6mMSCEN171vtw1o4yYqMAUBfzh4ETBsvWGqcKzwT
         PPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrsh0GzE/5xddP3hJcJiXsO4yE7oqCVfEkv52ZvReiQbCPi9Qbz0AZYRBOpPEYDxn61v6d+em7UHfl0+hjYMs4CxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbgJMTqDPC1elNfPCfvgEMeXHPknL9w+vpwjZviGVnjKHO9X8
	P5MGA7/ISQTlH7rTQPV2aBwOv0wrjlVObj595UYZkqoVFZtLePQt8hxMinVUSk2fxKt5wMfTsDH
	NwNM7rg6enBtbTbk/C8dgCiVI/1YCaRLHN/hSQqBN/fNbXsi3Yxqz7xEiscgaZGg8VRQH7XjwWe
	9HQNECg/jNJyUxBhzN+3GBrwhpFYHUENYZD7HZC42bF85X
X-Gm-Gg: ASbGncv7SE/QrZihdKu9BLcEbTxrYmxIxQD9jMvFyyP/LLA9uBePd26qojCVyHqBLks
	6Q79aoldX4pBfLtiGQeQ0MT60g7ML7owiN4dy5LZrxCirFSaztDS3j6L3f5QEYMepLB1cNqIwFq
	E=
X-Received: by 2002:a05:6902:150d:b0:e5b:1b51:f0a0 with SMTP id 3f1490d57ef6-e5dc91dd08amr9703693276.33.1739827373656;
        Mon, 17 Feb 2025 13:22:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0JO7dsrwyJi4/TipueyIzMJjIIcN761MkWvq2Krgp7T1K588ltDg7X4iqqcobZ2OTXjashL9eS26hVFPRfpE=
X-Received: by 2002:a05:6902:150d:b0:e5b:1b51:f0a0 with SMTP id
 3f1490d57ef6-e5dc91dd08amr9703633276.33.1739827373197; Mon, 17 Feb 2025
 13:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-8-npache@redhat.com>
 <f8f7bb71-ca31-46ee-a62d-7ddfd83e0ead@gmail.com>
In-Reply-To: <f8f7bb71-ca31-46ee-a62d-7ddfd83e0ead@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 14:22:27 -0700
X-Gm-Features: AWEUYZlm5mjXZ3tEVVWOcl-sJ5fnc1BSQk3G0UDGPmn0oCqHkCSO8-KGeF-Y9Jw
Message-ID: <CAA1CXcAOO8KkdF-beDAvZMtEy9K5yT5B3ykxZoL9d01+XSwxPg@mail.gmail.com>
Subject: Re: [RFC v2 7/9] khugepaged: add mTHP support
To: Usama Arif <usamaarif642@gmail.com>
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
	aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, audra@redhat.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5hRFQZv3smUq9k9hzssz2iaokE9j78bVFdYSADyO4bY_1739827374
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 1:55=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 11/02/2025 00:30, Nico Pache wrote:
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
> >  mm/khugepaged.c | 122 ++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 83 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index c8048d9ec7fb..cd310989725b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1127,13 +1127,14 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >  {
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
> >  {
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
>
> Its likely you might introduce a regression in khugepaged cpu usage over =
here.
>
> For intel x86 machines that dont have TLB coalescing (AMD) or contpte (AR=
M),
> there is a reduced benefit of mTHPs, I feel like a lot of people will nev=
er
> change from the current kernel default, i.e. 2M THPs and fallback to 4K.
>
> If you are only parsing 2M hugepages, early bailout when
> none_or_zero <=3D khugepaged_max_ptes_none is a good optimization, and ge=
tting
> rid of that will cause a regression? It might look a bit out of place,
> but is it possible to keep this restriction of max_ptes_none during the
> scanning phase if only PMD mappable THPs are allowed?

That seems like a reasonable request, I will try to implement that. Thanks!

>
>
>
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
> >  out_unmap:
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
> >  out:
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

