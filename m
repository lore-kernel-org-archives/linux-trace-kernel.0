Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131702AD10
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242487; cv=none; b=YwAjdPAo+1K3rMZnOjLiKKqlrrAUtNxbkoiYsJcYa9KvRw6rbnuWEZ0pMJadrbvVRPZWFBOm7oEsULkEkcUCjfLmVbtlxxWb+ElE2yn7OzF5DxOC3D7UEAEEnQ6GgOQhxpNdcICi3NlYJD2WIXM8hEwZ3Gvi6RlxHjU0WYWkqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242487; c=relaxed/simple;
	bh=ZATpSEkEjb493SHF9kG4VXaKrQ4+5P8h3wHPNtIoUME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFcHnDo+RKP0tFLwajY0/LHSHJrv0ioHF9q8+xXf/w6WIUUaldonUTDZQnSEOeX0jvs51daWZ7NfaQ6afEUVfBDRdEh6ZmWwFY4tPYVkuhQC8XUqeUcggKjsjTkS785h2z4fTKw+le2a2lr6dC9l2zwPv5xnKCYvAJBN7uYZcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScEQUJ+2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScEQUJ+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770242486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQ9b4xt7wkni1thV96wDs9A59mL4ne2sOksOF+2S8Co=;
	b=ScEQUJ+2zczmrtB877V4T8UBoeAfiQNjhvzYRPFHLr8IhfJVIWHNL1o6+wWS+3t+v5FOUg
	76yMUzffPTbBlCTwkKbTAik9rCfeUjruNudvsNXxW8TtltkyGHw8UlwlZvAbCL17R5W9qC
	DttjPTgXFY+dKB1rXZ2k2apoi7oM29w=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-ShhYvZKDOgedQXllMEAQjA-1; Wed, 04 Feb 2026 17:01:25 -0500
X-MC-Unique: ShhYvZKDOgedQXllMEAQjA-1
X-Mimecast-MFC-AGG-ID: ShhYvZKDOgedQXllMEAQjA_1770242484
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64956932a51so448106d50.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 14:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770242484; x=1770847284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQ9b4xt7wkni1thV96wDs9A59mL4ne2sOksOF+2S8Co=;
        b=TvIaw8EsQ8VcEJGMwUtCntPT3+Rejfvq6s2GgAHGf6DhbabUfoTVSnA/VPnM+if7sp
         5mO8TpqOwA+0LofWr/o1OVUQwnPvdyJZWpAwJNJteRA89w1xYbQo4kepRzdsIvMDPR+R
         wfCndsqJFRXhkf6P+ns+W/Qp6Cj+9Iw5ZvAklVcQxPozkHrCBnnzzz3VcG1nwAs5GRgL
         OJHVw7Gas9yHg5vOCVCiHpBt35nb7kB01A9y8HRpQzc9oG4OvIWdb/phohdGwJpAqZz7
         +eaGDyX2TR98EtVZ2HJgFZFpiisV2tyEXMQxs46t2i0/mLqmWNSVE2UGZZ3XzvKF2vYC
         cW6A==
X-Forwarded-Encrypted: i=1; AJvYcCXTuk/AgB2XssaqokVZWJzKo2z5WswGCIg21bUHtScnrG+nerzN5QkLlobz9jB8Av5738tVq0h8H2F3SxdVQrotnPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywui+sh3CngXZlpA00wJb6hjMvAy/mKp2rNHM2CTT2xKTCien0L
	TXfItfF1E8D+G8HYD2dFMOzJTr1in71xq2pnQJPewuVLw9hAZxVt2twTpRflm8zvc5Mawv4K6Fz
	0HnDQfO+fVrCb0tkMqESsz3GAXSh8nxRzLotKaBOY3VPiNXYWcj2sUL+W/1iZlTLRwtmtn4vwZi
	TngY8pvhUSyghUBbJy9TN5Ljwp6s9SiND/wnXwb9x0RRUjKsGf
X-Gm-Gg: AZuq6aIRyKfUTl0HkL8Kh0XvXAm4Cj31UTyVjJvFj5FZjdLdJh2T69lugvhdpQ8jwSz
	UxYwbWzeC30dZo1HVeHAZoso7FFACbqGPjKMtm2IfypiePfF2T3Fs76MH5EPhdrVD59RVIW8qHw
	w2bvIhJOzH/qLt6KNT2gAKZy8giDykPm85l6ceC4TpYNGOKfOmadrcWmFeM0T6LTWd
X-Received: by 2002:a05:690c:4612:b0:794:b013:2452 with SMTP id 00721157ae682-794fe84185cmr61397067b3.68.1770242484094;
        Wed, 04 Feb 2026 14:01:24 -0800 (PST)
X-Received: by 2002:a05:690c:4612:b0:794:b013:2452 with SMTP id
 00721157ae682-794fe84185cmr61396207b3.68.1770242483544; Wed, 04 Feb 2026
 14:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122192841.128719-1-npache@redhat.com> <20260122192841.128719-9-npache@redhat.com>
 <599ebe0a-086a-4701-b797-dcd801ad02fb@lucifer.local>
In-Reply-To: <599ebe0a-086a-4701-b797-dcd801ad02fb@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 4 Feb 2026 15:00:57 -0700
X-Gm-Features: AZwV_QhtPTjqCI8Cllr25MJgjjbEFKf_v7zZtVDS9KZH8RlSQwP57ib5pDCOz2w
Message-ID: <CAA1CXcCCbiV9j+_SVNJrkfVRqKPXjGg+Lt3YnyNUhDHWkRjHGQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v14 08/16] khugepaged: generalize
 collapse_huge_page for mTHP collapse
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, willy@infradead.org, peterx@redhat.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com, 
	raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	cl@gentwo.org, jglisse@google.com, zokeefe@google.com, rientjes@google.com, 
	rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0FLA3CnDccgsOTho1KzyM3d03SKX8vakvKJpm_mmYGQ_1770242484
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 6:13=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jan 22, 2026 at 12:28:33PM -0700, Nico Pache wrote:
> > Pass an order and offset to collapse_huge_page to support collapsing an=
on
> > memory to arbitrary orders within a PMD. order indicates what mTHP size=
 we
> > are attempting to collapse to, and offset indicates were in the PMD to
> > start the collapse attempt.
> >
> > For non-PMD collapse we must leave the anon VMA write locked until afte=
r
> > we collapse the mTHP-- in the PMD case all the pages are isolated, but =
in
> > the mTHP case this is not true, and we must keep the lock to prevent
> > changes to the VMA from occurring.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 111 +++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 71 insertions(+), 40 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 9b7e05827749..76cb17243793 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1151,44 +1151,54 @@ static enum scan_result alloc_charge_folio(stru=
ct folio **foliop, struct mm_stru
> >       return SCAN_SUCCEED;
> >  }
> >
> > -static enum scan_result collapse_huge_page(struct mm_struct *mm, unsig=
ned long address,
> > -             int referenced, int unmapped, struct collapse_control *cc=
)
> > +static enum scan_result collapse_huge_page(struct mm_struct *mm, unsig=
ned long start_addr,
> > +             int referenced, int unmapped, struct collapse_control *cc=
,
> > +             bool *mmap_locked, unsigned int order)
> >  {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > -     pte_t *pte;
> > +     pte_t *pte =3D NULL;
> >       pgtable_t pgtable;
> >       struct folio *folio;
> >       spinlock_t *pmd_ptl, *pte_ptl;
> >       enum scan_result result =3D SCAN_FAIL;
> >       struct vm_area_struct *vma;
> >       struct mmu_notifier_range range;
> > +     bool anon_vma_locked =3D false;
> > +     const unsigned long nr_pages =3D 1UL << order;
> > +     const unsigned long pmd_address =3D start_addr & HPAGE_PMD_MASK;
> >
> > -     VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> > +     VM_WARN_ON_ONCE(pmd_address & ~HPAGE_PMD_MASK);
> >
> >       /*
> >        * Before allocating the hugepage, release the mmap_lock read loc=
k.
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
> > -     result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> > +     result =3D alloc_charge_folio(&folio, mm, cc, order);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_nolock;
> >
> >       mmap_read_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > -                                      HPAGE_PMD_ORDER);
> > +     *mmap_locked =3D true;
> > +     result =3D hugepage_vma_revalidate(mm, pmd_address, true, &vma, c=
c, order);
>
> Why would we use the PMD address here rather than the actual start addres=
s?

The revalidation relies on the pmd_addr not the start_addr. It (only)
uses this to make sure the VMA is still at least PMD sized, and it
uses the order to validate that the target order is allowed. I left a
small comment about this in the revalidate function.

>
> Also please add /*expect_anon=3D*/ before the 'true' because it's hard to
> understand what that references.

ack

>
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> > +             *mmap_locked =3D false;
> >               goto out_nolock;
> >       }
> >
> > -     result =3D find_pmd_or_thp_or_none(mm, address, &pmd);
> > +     result =3D find_pmd_or_thp_or_none(mm, pmd_address, &pmd);
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> > +             *mmap_locked =3D false;
> >               goto out_nolock;
> >       }
> >
> > @@ -1198,13 +1208,16 @@ static enum scan_result collapse_huge_page(stru=
ct mm_struct *mm, unsigned long a
> >                * released when it fails. So we jump out_nolock directly=
 in
> >                * that case.  Continuing to collapse causes inconsistenc=
y.
> >                */
> > -             result =3D __collapse_huge_page_swapin(mm, vma, address, =
pmd,
> > -                                                  referenced, HPAGE_PM=
D_ORDER);
> > -             if (result !=3D SCAN_SUCCEED)
> > +             result =3D __collapse_huge_page_swapin(mm, vma, start_add=
r, pmd,
> > +                                                  referenced, order);
> > +             if (result !=3D SCAN_SUCCEED) {
> > +                     *mmap_locked =3D false;
> >                       goto out_nolock;
> > +             }
> >       }
> >
> >       mmap_read_unlock(mm);
> > +     *mmap_locked =3D false;
> >       /*
> >        * Prevent all access to pagetables with the exception of
> >        * gup_fast later handled by the ptep_clear_flush and the VM
> > @@ -1214,20 +1227,20 @@ static enum scan_result collapse_huge_page(stru=
ct mm_struct *mm, unsigned long a
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > -                                      HPAGE_PMD_ORDER);
> > +     result =3D hugepage_vma_revalidate(mm, pmd_address, true, &vma, c=
c, order);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> >       vma_start_write(vma);
> > -     result =3D check_pmd_still_valid(mm, address, pmd);
> > +     result =3D check_pmd_still_valid(mm, pmd_address, pmd);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >
> >       anon_vma_lock_write(vma->anon_vma);
> > +     anon_vma_locked =3D true;
> >
> > -     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > -                             address + HPAGE_PMD_SIZE);
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start_ad=
dr,
> > +                             start_addr + (PAGE_SIZE << order));
> >       mmu_notifier_invalidate_range_start(&range);
> >
> >       pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> > @@ -1239,24 +1252,21 @@ static enum scan_result collapse_huge_page(stru=
ct mm_struct *mm, unsigned long a
> >        * Parallel GUP-fast is fine since GUP-fast will back off when
> >        * it detects PMD is changed.
> >        */
> > -     _pmd =3D pmdp_collapse_flush(vma, address, pmd);
> > +     _pmd =3D pmdp_collapse_flush(vma, pmd_address, pmd);
> >       spin_unlock(pmd_ptl);
> >       mmu_notifier_invalidate_range_end(&range);
> >       tlb_remove_table_sync_one();
> >
> > -     pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> > +     pte =3D pte_offset_map_lock(mm, &_pmd, start_addr, &pte_ptl);
> >       if (pte) {
> > -             result =3D __collapse_huge_page_isolate(vma, address, pte=
, cc,
> > -                                                   HPAGE_PMD_ORDER,
> > -                                                   &compound_pagelist)=
;
> > +             result =3D __collapse_huge_page_isolate(vma, start_addr, =
pte, cc,
> > +                                                   order, &compound_pa=
gelist);
> >               spin_unlock(pte_ptl);
> >       } else {
> >               result =3D SCAN_NO_PTE_TABLE;
> >       }
> >
> >       if (unlikely(result !=3D SCAN_SUCCEED)) {
> > -             if (pte)
> > -                     pte_unmap(pte);
> >               spin_lock(pmd_ptl);
> >               BUG_ON(!pmd_none(*pmd));
> >               /*
> > @@ -1266,21 +1276,21 @@ static enum scan_result collapse_huge_page(stru=
ct mm_struct *mm, unsigned long a
> >                */
> >               pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> >               spin_unlock(pmd_ptl);
> > -             anon_vma_unlock_write(vma->anon_vma);
> >               goto out_up_write;
> >       }
> >
> >       /*
> > -      * All pages are isolated and locked so anon_vma rmap
> > -      * can't run anymore.
> > +      * For PMD collapse all pages are isolated and locked so anon_vma
> > +      * rmap can't run anymore. For mTHP collapse we must hold the loc=
k
> >        */
> > -     anon_vma_unlock_write(vma->anon_vma);
> > +     if (is_pmd_order(order)) {
> > +             anon_vma_unlock_write(vma->anon_vma);
> > +             anon_vma_locked =3D false;
> > +     }
> >
> >       result =3D __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> > -                                        vma, address, pte_ptl,
> > -                                        HPAGE_PMD_ORDER,
> > -                                        &compound_pagelist);
> > -     pte_unmap(pte);
> > +                                        vma, start_addr, pte_ptl,
> > +                                        order, &compound_pagelist);
> >       if (unlikely(result !=3D SCAN_SUCCEED))
> >               goto out_up_write;
> >
> > @@ -1290,20 +1300,42 @@ static enum scan_result collapse_huge_page(stru=
ct mm_struct *mm, unsigned long a
> >        * write.
> >        */
> >       __folio_mark_uptodate(folio);
> > -     pgtable =3D pmd_pgtable(_pmd);
> > +     if (is_pmd_order(order)) { /* PMD collapse */
> > +             pgtable =3D pmd_pgtable(_pmd);
> >
> > -     spin_lock(pmd_ptl);
> > -     BUG_ON(!pmd_none(*pmd));
> > -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > -     map_anon_folio_pmd_nopf(folio, pmd, vma, address);
> > +             spin_lock(pmd_ptl);
> > +             WARN_ON_ONCE(!pmd_none(*pmd));
> > +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > +             map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_address);
> > +     } else { /* mTHP collapse */
> > +             pte_t mthp_pte =3D mk_pte(folio_page(folio, 0), vma->vm_p=
age_prot);
> > +
> > +             mthp_pte =3D maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> > +             spin_lock(pmd_ptl);
> > +             WARN_ON_ONCE(!pmd_none(*pmd));
> > +             folio_ref_add(folio, nr_pages - 1);
> > +             folio_add_new_anon_rmap(folio, vma, start_addr, RMAP_EXCL=
USIVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             set_ptes(vma->vm_mm, start_addr, pte, mthp_pte, nr_pages)=
;
> > +             update_mmu_cache_range(NULL, vma, start_addr, pte, nr_pag=
es);
> > +
> > +             smp_wmb(); /* make PTEs visible before PMD. See pmd_insta=
ll() */
> > +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>
> I seriously hate this being open-coded, can we separate it out into anoth=
er
> function?

Yeah I think we've discussed this before. I started to generalize
this, and apply it to other parts of the kernel that maintain a
similar pattern, but each potential user of the helper was slightly
different in its approach and I was unable to find a quick solution to
make it apply to all. I think it will require a lot more thought to
cleanly refactor this. I figured I could leave this to the later
cleanup work, or I could just create a static function just for
khugepaged for now?

>
> > +     }
> >       spin_unlock(pmd_ptl);
> >
> >       folio =3D NULL;
> >
> >       result =3D SCAN_SUCCEED;
> >  out_up_write:
> > +     if (anon_vma_locked)
> > +             anon_vma_unlock_write(vma->anon_vma);
>
> Thanks it's much better tracking this specifically.
>
> The whole damn thing needs refactoring (by this I mean - khugepaged and r=
eally
> THP in general to be clear :) but it's not your fault.

Yeah it has not been the prettiest code to try and understand/work on!

>
> Could I ask though whether you might help out with some cleanups after th=
is
> lands :)
>
> I feel like we all need to do our bit to pay down some technical debt!


Yes ofc! I had already planned on doing so. I have some in mind, and I
believe others have already tackled some. After this land, let's
discuss further plans (discussion thread or THP meeting).

Cheers,
-- Nico

>
> > +     if (pte)
> > +             pte_unmap(pte);
> >       mmap_write_unlock(mm);
> > +     *mmap_locked =3D false;
> >  out_nolock:
> > +     WARN_ON_ONCE(*mmap_locked);
> >       if (folio)
> >               folio_put(folio);
> >       trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, resul=
t);
> > @@ -1471,9 +1503,8 @@ static enum scan_result collapse_scan_pmd(struct =
mm_struct *mm,
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               result =3D collapse_huge_page(mm, start_addr, referenced,
> > -                                         unmapped, cc);
> > -             /* collapse_huge_page will return with the mmap_lock rele=
ased */
> > -             *mmap_locked =3D false;
> > +                                         unmapped, cc, mmap_locked,
> > +                                         HPAGE_PMD_ORDER);
> >       }
> >  out:
> >       trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> > --
> > 2.52.0
> >
>
> Cheers, Lorenzo
>

