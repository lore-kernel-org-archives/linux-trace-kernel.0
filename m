Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4ED267B78
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 May 2025 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138634; cv=none; b=EzTUjerM+rhL2lN3vWcvNRFewwa0Y5HXythlwBQa4zhh8Ze2FByAhKrPltLYAX2WTB68o9HB7BUinmN+MwRGoPx1EpeCnxacwhSnChJp18mvHitxQ+MD40D8kENXANC65eioMGDiedIdq0cHpBxRQj4fE0p0iXUgJrWC0RSqvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138634; c=relaxed/simple;
	bh=wBAN7KdlDuUplW6fFkHh3dA64w8CCdISLVwYqFYeXCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZMDbmPcS/Lb/LbH2KGYDb9JGl9hOftfyoJgELI+sPUYVg+sypwcZjOZEpud13qPefLUQdktbE8TG1KrlvUGLMwWrKvGSG0y+JE6t6tlZo6Phe8+J0RrT10ji5Hzm+lbTo2falk2A54T8M5srpiU3R3O93sxMiTP+eclukpdN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw0a8dZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw0a8dZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746138631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aj5kVh2fYvZNzYFZpUcEHW9ZehBS0ih3BpopJ9Qzk8I=;
	b=gw0a8dZ4D/vzoJy34UnWr/5A6CMCKmAOmra0ZmAuw8agWTZevYwFRkHuvMh1rZIkQef4+o
	JqiQW/nO6+qx9zSxcB8X4F9wOV1UWxERRYa8ql4IBImBOKHhSYtTJ0wRzxyysIDfsYq+9U
	KWhCY7aNx4LyV/ViXMzKOR5zaJqQGDs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-LNl4yQg_P6SgeDyIF61TfA-1; Thu, 01 May 2025 18:30:29 -0400
X-MC-Unique: LNl4yQg_P6SgeDyIF61TfA-1
X-Mimecast-MFC-AGG-ID: LNl4yQg_P6SgeDyIF61TfA_1746138629
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-703d7a66d77so21471277b3.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 May 2025 15:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138629; x=1746743429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj5kVh2fYvZNzYFZpUcEHW9ZehBS0ih3BpopJ9Qzk8I=;
        b=J9ZZQf0LWSkpbBo2d6581VaQXJIG5nrccCu0ul9X4b6qTe28mGeLLD0DmZixMGtX72
         Ze9la/FqGAPiytNWfFvNhnPXuwhfzWps6EE6dFiGUpoVaYQrG9zfi/YJLSysyIqQ2s/5
         bmzlRo3kRwcO6GqDIaZo6GW/R2qmNq/UAvUeRzVPfamIKkgdCEOpqMSLZX+TrrlQQGi8
         853DX8lxcKipDhhtU9U9DVRfKW6GL52AADvzrieKCAWveGXYAsM61p69Iukl3AMl1wJd
         M05d0B0d++SlrGplbFwVE2VFc77CHabSo1DaP53UWGwI9eWVUEAG6Vx4ZK45in16ZGdb
         5WBA==
X-Forwarded-Encrypted: i=1; AJvYcCUOkoJtxUs7He4bWmVMSD+HJU31NFMGnYGE12Ru41dWsLKqLVOpBKSfOlWn1RN5MIggxSEnRCcBUQjG0VP2GRX3nM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqMKqAMKu9b7+MEd8reYbaIaw2rj4mLBaV0QjIMq854ND3Ave
	rd/ldeMKr6VvOLcomScSfm5QQlzLoIjBa5I9UqgKWNa8OmuVg4DAAwBVXHn/R0obEfy4XkLtnOk
	g5518u1GPB0n7qgJJcbbbtIZ3zVxx0yzy0DY/NvcHUYVoz6jFdw2VQc0j5l4ard6GVffJgep/Ja
	eqfylOC6rY22lr49ZzJrlqHFT4KUDRD0jMMRpq99chh/Xm
X-Gm-Gg: ASbGnct1D8g5X9zei4+NZgql1ptecA4X2Pbdl5JmG5JeVwD5vnkzxCL3uCb5x/vAtNt
	23H8DlHz+vgeon9FX/wj4TTo84Jan56+iKb/NQanAJHV7voXiRTAcefipbyeJHYAHWA7wsddzph
	K0he/Cb9s=
X-Received: by 2002:a05:690c:3682:b0:705:edab:f36d with SMTP id 00721157ae682-708bcf63de9mr57369157b3.16.1746138629090;
        Thu, 01 May 2025 15:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu1yKkYW0x5UpDvp4pOXa+SP50x739VBt0tftsbYJvO8z/Vx/jbX4NbB97WC5+kpd2DDf1TwLAGOU//e5dFwA=
X-Received: by 2002:a05:690c:3682:b0:705:edab:f36d with SMTP id
 00721157ae682-708bcf63de9mr57368407b3.16.1746138628453; Thu, 01 May 2025
 15:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428181218.85925-1-npache@redhat.com> <20250428181218.85925-8-npache@redhat.com>
 <7a81339c-f9e5-a718-fa7f-6e3fb134dca5@google.com>
In-Reply-To: <7a81339c-f9e5-a718-fa7f-6e3fb134dca5@google.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 1 May 2025 16:30:02 -0600
X-Gm-Features: ATxdqUEUagrz6MnGz2JFhIpcOhdCVHIqIcs7JBNBBnnZq_vR2sDhzfKQ6iUD0_Q
Message-ID: <CAA1CXcDVe9jhjN4FAJq5Sh=kKA4t7OPcuJUqpbVSdo5qtZp1hA@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
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
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TcikvittujNz_js0wKQb-u6wOo_MnZjwN2gfSZqlWYY_1746138629
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 6:59=E2=80=AFAM Hugh Dickins <hughd@google.com> wrot=
e:
>
> On Mon, 28 Apr 2025, Nico Pache wrote:
>
> > Introduce the ability for khugepaged to collapse to different mTHP size=
s.
> > While scanning PMD ranges for potential collapse candidates, keep track
> > of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> > represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. I=
f
> > mTHPs are enabled we remove the restriction of max_ptes_none during the
> > scan phase so we dont bailout early and miss potential mTHP candidates.
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
>
> There are locking errors in this patch.  Let me comment inline below,
> then at the end append the fix patch I'm using, to keep mm-new usable
> for me. But that's more of an emergency rescue than a recommended fixup:
> I don't much like your approach here, and hope it will change in v6.
Hi Hugh,

Thank you for testing, and providing such a detailed report + fix!

>
> > ---
> >  mm/khugepaged.c | 125 ++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 88 insertions(+), 37 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 6e67db86409a..3a846cd70c66 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1136,13 +1136,14 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >  {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > -     pte_t *pte;
> > +     pte_t *pte, mthp_pte;
>
> I didn't wait to see the problem, just noticed that in the v4->v5
> update, pte gets used at out_up_write, but there are gotos before
> pte has been initialized. Declare pte =3D NULL here.

Ah thanks I missed that when I moved the PTE unmapping to out_up_write.

>
> >       pgtable_t pgtable;
> >       struct folio *folio;
> >       spinlock_t *pmd_ptl, *pte_ptl;
> >       int result =3D SCAN_FAIL;
> >       struct vm_area_struct *vma;
> >       struct mmu_notifier_range range;
> > +     unsigned long _address =3D address + offset * PAGE_SIZE;
> >
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> > @@ -1158,12 +1159,13 @@ static int collapse_huge_page(struct mm_struct =
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
> > @@ -1181,13 +1183,14 @@ static int collapse_huge_page(struct mm_struct =
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
> > @@ -1197,7 +1200,7 @@ static int collapse_huge_page(struct mm_struct *m=
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
> > @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
>
> I spent a long time trying to work out why the include/linux/swapops.h:51=
1
> BUG is soon hit - the BUG which tells there's a migration entry left behi=
nd
> after its folio has been unlocked.

Can you please share how you reproduce the bug? I haven't been able to
reproduce any BUGs with most of the memory debuggers enabled. This has
also been through a number of mm test suites and some internal
testing. So i'm curious how to hit this issue!
>
> In the patch at the end you'll see that I've inserted a check here, to
> abort if the VMA following the revalidated "vma" is sharing the page tabl=
e
> (and so also affected by clearing *pmd).  That turned out not to be the
> problem (WARN_ONs inserted never fired in my limited testing), but it sti=
ll
> looks to me as if some such check is needed.  Or I may be wrong, and
> "revalidate" (a better place for the check) does actually check that, but
> it wasn't obvious, and I haven't spent more time looking at it (but it di=
d
> appear to rule out the case of a VMA before "vma" sharing the page table

Hmm if I understand this correctly, the check you are adding is
already being handled in the PMD case through
thp_vma_suitable_order(s) (by checking that a PMD can fit in the VMA
@address); however, I think you are correct, we much check that the
VMA still spans the whole PMD region we are trying to a mTHP collapse
within it... if not its possible that a mremap+mmap might have occured
allowing a different mapping to belong to the same PMD (this also
makes support mTHP collapse in mappings <PMD sized difficult and is
the reason we haven't pursued it yet, the locking requires explode,
the simple solutions is as you noted, only support <PMD sized
collapses with a single VMA in the PMD range, this is a future
change).

I actually realized my revalidation is rather weak... mostly because
I'm passing the PMD address, not the mTHP starting address (see
address vs _address in collapse_huge_page). I think your check would
be handled if I pass it _address. If that was the case the following
check would be performed in thp_vma_suitable_order:

if (haddr < vma->vm_start || haddr + hpage_size > vma->vm_end)
return false;


>
> >       vma_start_write(vma);
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > -     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > -                             address + HPAGE_PMD_SIZE);
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address=
,
> > +                             _address + (PAGE_SIZE << order));
>
> mmu_notifiers tend to be rather a mystery to me, so I've made no change
> below, but it's not obvious whether it's correct clear the *pmd but only
> notify of clearing a subset of that range: what's outside the range soon
> gets replaced as it was, but is that good enough?  I don't know.
Sadly I dont have a good answer for you as mmu_notifier is mostly a
mystery to me too. I assume the anon_vma_lock_write would prevent any
others from touching the pages we ARE NOT invalidating here, and that
may be enough. Honestly I think the anon_vma_lock_write allows up to
remove a lot of the locking (but as i stated im trying to keep the
locking the  *same* in this series).
>
> >       mmu_notifier_invalidate_range_start(&range);
> >
> >       pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> > +
> >       /*
> >        * This removes any huge TLB entry from the CPU so we won't allow
> >        * huge and small TLB entries for the same virtual address to
>
> The line I want to comment on does not appear in this diff context:
>         _pmd =3D pmdp_collapse_flush(vma, address, pmd);
>
> That is appropriate for a THP occupying the whole range of the page table=
,
> but is a surprising way to handle an "mTHP" of just some of its ptes:
> I would expect you to be invalidating and replacing just those.

The reason for leaving it in the mTHP case was to prevent the
aforementioned GUP-fast race.
* Parallel GUP-fast is fine since GUP-fast will back off when
* it detects PMD is changed.

I tried to keep the same locking principles as the PMD case: remove
the PMD, hold all the same locks, collapse to (m)THP, reinstall the
PMD. This seems the easiest way to get it right and allowed me to
focus on adding the feature. The codebase being scattered with
mentions of potential races, and taking locks that might not be
needed, also made me weary.

I know Dev was looking into optimizations for the locking, and I have
some ideas of ways to improve it, or at least clean up some of the
locking.
>
> And that is the cause of the swapops:511 BUGs: "uninvolved" ptes are
> being temporarily hidden, so not found when remove_migration_ptes()
> goes looking for them.
>
> This reliance on pmdp_collapse_flush() can be rescued, with stricter
> locking (comment below); but I don't like it, and notice Jann has
> picked up on it too.  I hope v6 switches to handling ptes by ptes.
I believe the current approach with your anon_write_unlock fix would
suffice (if the gup race is a valid reason to keep the pmd flush), and
then we can follow up with locking improvements.
>
> > @@ -1226,18 +1230,16 @@ static int collapse_huge_page(struct mm_struct =
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
> >       }
> >
> >       if (unlikely(result !=3D SCAN_SUCCEED)) {
> > -             if (pte)
> > -                     pte_unmap(pte);
> >               spin_lock(pmd_ptl);
> >               BUG_ON(!pmd_none(*pmd));
> >               /*
> > @@ -1258,9 +1260,8 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       anon_vma_unlock_write(vma->anon_vma);
>
> Phew, it's just visible there in the context.  The anon_vma lock is what
> keeps out racing lookups; so, that anon_vma_unlock_write() (and its
> "All pages are isolated and locked" comment) is appropriate in the
> HPAGE_PMD_SIZEd THP case, but has to be left until later for mTHP ptes.
Makes sense!
>
> But the anon_vma lock may well span a much larger range than the pte
> lock, and the pmd lock certainly spans a much larger range than the
> pte lock; so we really prefer to release anon_vma lock and pmd lock
> as soon as is safe, and use pte lock in preference where possible.
>
> >
> >       result =3D __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> > -                                        vma, address, pte_ptl,
> > -                                        &compound_pagelist, HPAGE_PMD_=
ORDER);
> > -     pte_unmap(pte);
> > +                                        vma, _address, pte_ptl,
> > +                                        &compound_pagelist, order);
> >       if (unlikely(result !=3D SCAN_SUCCEED))
> >               goto out_up_write;
> >
> > @@ -1270,25 +1271,42 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >        * write.
> >        */
> >       __folio_mark_uptodate(folio);
> > -     pgtable =3D pmd_pgtable(_pmd);
> > -
> > -     _pmd =3D folio_mk_pmd(folio, vma->vm_page_prot);
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
> > +             _pmd =3D folio_mk_pmd(folio, vma->vm_page_prot);
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
> > +     } else { /* mTHP collapse */
> > +             mthp_pte =3D mk_pte(&folio->page, vma->vm_page_prot);
> > +             mthp_pte =3D maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> > +
> > +             spin_lock(pmd_ptl);
>
> I haven't changed that, but it is odd: yes, pmd_ptl will be required
> when doing the pmd_populate(), but it serves no purpose here when
> fiddling around with ptes in a disconnected page table.
Yes I believe a lot of locking can be improved and some is unnecessary.
>
> > +             folio_ref_add(folio, (1 << order) - 1);
> > +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUS=
IVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order=
));
> > +             update_mmu_cache_range(NULL, vma, _address, pte, (1 << or=
der));
> > +
> > +             smp_wmb(); /* make pte visible before pmd */
> > +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > +             spin_unlock(pmd_ptl);
> > +     }
> >
> >       folio =3D NULL;
> >
> >       result =3D SCAN_SUCCEED;
>
> Somewhere around here it becomes safe for mTHP to anon_vma_unlock_write()=
.
>
> >  out_up_write:
> > +     if (pte)
> > +             pte_unmap(pte);
> >       mmap_write_unlock(mm);
> >  out_nolock:
> >       *mmap_locked =3D false;
> > @@ -1364,31 +1382,58 @@ static int khugepaged_scan_pmd(struct mm_struct=
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
> > +     bool is_pmd_only;
> >       bool writable =3D false;
> > -
> > +     int chunk_none_count =3D 0;
> > +     int scaled_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER =
- KHUGEPAGED_MIN_MTHP_ORDER);
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
> > +
> > +     enabled_orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
> > +             tva_flags, THP_ORDERS_ALL_ANON);
> > +
> > +     is_pmd_only =3D (enabled_orders =3D=3D (1 << HPAGE_PMD_ORDER));
> > +
> >       pte =3D pte_offset_map_lock(mm, pmd, address, &ptl);
> >       if (!pte) {
> >               result =3D SCAN_PMD_NULL;
> >               goto out;
> >       }
> >
> > -     for (_address =3D address, _pte =3D pte; _pte < pte + HPAGE_PMD_N=
R;
> > -          _pte++, _address +=3D PAGE_SIZE) {
> > +     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +             /*
> > +              * we are reading in KHUGEPAGED_MIN_MTHP_NR page chunks. =
if
> > +              * there are pages in this chunk keep track of it in the =
bitmap
> > +              * for mTHP collapsing.
> > +              */
> > +             if (i % KHUGEPAGED_MIN_MTHP_NR =3D=3D 0) {
> > +                     if (chunk_none_count <=3D scaled_none)
> > +                             bitmap_set(cc->mthp_bitmap,
> > +                                        i / KHUGEPAGED_MIN_MTHP_NR, 1)=
;
> > +
> > +                     chunk_none_count =3D 0;
> > +             }
> > +
> > +             _pte =3D pte + i;
> > +             _address =3D address + i * PAGE_SIZE;
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (is_swap_pte(pteval)) {
> >                       ++unmapped;
> > @@ -1411,10 +1456,11 @@ static int khugepaged_scan_pmd(struct mm_struct=
 *mm,
> >                       }
> >               }
> >               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > +                     ++chunk_none_count;
> >                       ++none_or_zero;
> >                       if (!userfaultfd_armed(vma) &&
> > -                         (!cc->is_khugepaged ||
> > -                          none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> > +                         (!cc->is_khugepaged || !is_pmd_only ||
> > +                             none_or_zero <=3D khugepaged_max_ptes_non=
e)) {
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -1510,6 +1556,7 @@ static int khugepaged_scan_pmd(struct mm_struct *=
mm,
> >                                                                    addr=
ess)))
> >                       referenced++;
> >       }
> > +
> >       if (!writable) {
> >               result =3D SCAN_PAGE_RO;
> >       } else if (cc->is_khugepaged &&
> > @@ -1522,8 +1569,12 @@ static int khugepaged_scan_pmd(struct mm_struct =
*mm,
> >  out_unmap:
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> > -             result =3D collapse_huge_page(mm, address, referenced,
> > -                                         unmapped, cc, mmap_locked, HP=
AGE_PMD_ORDER, 0);
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
> > --
> > 2.48.1
>
> Fixes to 07/12 "khugepaged: add mTHP support".
> But I see now that the first hunk is actually not to this 07/12, but to
> 05/12 "khugepaged: generalize __collapse_huge_page_* for mTHP support":
> the mTHP check added in __collapse_huge_page_swapin() forgets to unmap
> and unlock before returning, causing RCU imbalance warnings and lockups.
> I won't separate it out here, let me leave that to you.
Thanks I'll get both of these issues fixed!
>
> And I had other fixes to v4, which you've fixed differently in v5,
> I haven't looked up which patch: where khugepaged_collapse_single_pmd()
> does mmap_read_(un)lock() around collapse_pte_mapped_thp().  I dislike
> your special use of result SCAN_ANY_PROCESS there, because mmap_locked

This is what the revalidate func is doing with
khugepaged_test_exit_or_disable so I tried to keep it consistent.
Sadly this was the cleanest solution I could come up with. If you dont
mind sharing what your solution to this was, I'd be happy to take a
look!

> is precisely the tool for that job, so just lock and unlock without
> setting *mmap_locked true (but I'd agree that mmap_locked is confusing,
> and offhand wouldn't want to assert exactly what it means - does it
> mean that mmap lock was *never* dropped, so "vma" is safe without
> revalidation? depends on where it's used perhaps).
I agree its use is confusing and I like to think of it as ONLY the
indicator of it being locked/unlocked. Im not sure if there were other
intended uses.
>
> Hugh
>
> ---
>  mm/khugepaged.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index c1c637dbcb81..2c814c239d65 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1054,6 +1054,8 @@ static int __collapse_huge_page_swapin(struct mm_st=
ruct *mm,
>
>                 /* Dont swapin for mTHP collapse */
>                 if (order !=3D HPAGE_PMD_ORDER) {
> +                       pte_unmap(pte);
> +                       mmap_read_unlock(mm);
>                         result =3D SCAN_EXCEED_SWAP_PTE;
>                         goto out;
>                 }
> @@ -1136,7 +1138,7 @@ static int collapse_huge_page(struct mm_struct *mm,=
 unsigned long address,
>  {
>         LIST_HEAD(compound_pagelist);
>         pmd_t *pmd, _pmd;
> -       pte_t *pte, mthp_pte;
> +       pte_t *pte =3D NULL, mthp_pte;
>         pgtable_t pgtable;
>         struct folio *folio;
>         spinlock_t *pmd_ptl, *pte_ptl;
> @@ -1208,6 +1210,21 @@ static int collapse_huge_page(struct mm_struct *mm=
, unsigned long address,
>         if (result !=3D SCAN_SUCCEED)
>                 goto out_up_write;
>
> +       if (vma->vm_end < address + HPAGE_PMD_SIZE) {
> +               struct vm_area_struct *next_vma =3D find_vma(mm, vma->vm_=
end);
> +               /*
> +                * We must not clear *pmd if it is used by the following =
VMA.
> +                * Well, perhaps we could if it, and all following VMAs u=
sing
> +                * this same page table, share the same anon_vma, and so =
are
> +                * locked out together: but keep it simple for now (and t=
his
> +                * code might better belong in hugepage_vma_revalidate())=
.
> +                */
> +               if (next_vma && next_vma->vm_start < address + HPAGE_PMD_=
SIZE) {
> +                       result =3D SCAN_ADDRESS_RANGE;
> +                       goto out_up_write;
> +               }
> +       }
> +
>         vma_start_write(vma);
>         anon_vma_lock_write(vma->anon_vma);
>
> @@ -1255,15 +1272,17 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
>
>         /*
>          * All pages are isolated and locked so anon_vma rmap
> -        * can't run anymore.
> -        */
> -       anon_vma_unlock_write(vma->anon_vma);
> +        * can't run anymore - IF the entire extent has been isolated.
> +        * anon_vma lock may cover a large area: better unlock a.s.a.p.
> +        */
> +       if (order =3D=3D HPAGE_PMD_ORDER)
> +               anon_vma_unlock_write(vma->anon_vma);
>
>         result =3D __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>                                            vma, _address, pte_ptl,
>                                            &compound_pagelist, order);
>         if (unlikely(result !=3D SCAN_SUCCEED))
> -               goto out_up_write;
> +               goto out_unlock_anon_vma;
>
>         /*
>          * The smp_wmb() inside __folio_mark_uptodate() ensures the
> @@ -1304,6 +1323,9 @@ static int collapse_huge_page(struct mm_struct *mm,=
 unsigned long address,
>         folio =3D NULL;
>
>         result =3D SCAN_SUCCEED;
> +out_unlock_anon_vma:
> +       if (order !=3D HPAGE_PMD_ORDER)
> +               anon_vma_unlock_write(vma->anon_vma);
>  out_up_write:
>         if (pte)
>                 pte_unmap(pte);
> --
> 2.43.0
>

