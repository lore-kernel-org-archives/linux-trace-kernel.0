Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4A2D8DDB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776312898; cv=none; b=UbmbuovzyzNLyGubitiuAqcs+Spr+wLdVk6hNNG6bYYSaOHWjyOUg+ZnsZSViNEM78x5EV81Mw676P+TAmdqr2T+GJjCw+fmP4tSdmVWwOZjGnqqfXMNY3hFpDZCJ70lcYBk1o8HkzCvpcGQOWJbHbSI/n7bcJvu11pWDWs4q3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776312898; c=relaxed/simple;
	bh=dWz91ARxLsGlXW7XSGaqXIVfC7WDn8iro5Npuj98YlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Odn1NjZakzUOFrTsbyXzcMXqHfijDHfgYncqB3tXigazeaOojrm6O9VgT2sUa4z1r8UOXBq7rsV+PJrj6Z1Az0Jvgs6N9CiQnafHTcv5Ux3++/DarGN3SzJA5/uoJlptEBfLE5N1kOoCVKVgCwHfist0XA0WggrIW7eoD1TdHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvCTPyNo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvCTPyNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776312895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRivx3o9YlPIRYPzXoVedxYyHVyEWOjBKnATULWHp3k=;
	b=MvCTPyNooWCBNal69/1sngMdDq8zXMHx8eRmStAD/N/rskglyDpdpgEvwykSj3Qj/t1C77
	Efd1mTKHAQewsQwlntqMROSUsUAB03rf8hbYt38GOfdEkfS4JFEsII2gRYhI3WNMZutPCV
	wd0PD47YGJAB9U7DhdQYRQ2DHNWrFGA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-EOEFtsFlMHm0tVQbTCvg7A-1; Thu, 16 Apr 2026 00:14:53 -0400
X-MC-Unique: EOEFtsFlMHm0tVQbTCvg7A-1
X-Mimecast-MFC-AGG-ID: EOEFtsFlMHm0tVQbTCvg7A_1776312893
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7a3715e9e69so6169727b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Apr 2026 21:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776312893; x=1776917693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cRivx3o9YlPIRYPzXoVedxYyHVyEWOjBKnATULWHp3k=;
        b=C1lktv+Qto/mUcuZ6H4ES4E9fQgRkoxwlnUUB7J0LrMVdZ32OdLnURjvTiIsEY5rT4
         xZ4fg8I4kbQ98Q07Uz2t4NXre0Rx3e1cQ3EGbUwCTwdtOMYynAIDPoXmb+nGhwqgdwER
         D1DUU1gjblIWPGttlBKQ0tXjzn7nYrdD3/npTTHk0CHOawC7+BvALyNbJpvSifZGTJhZ
         B5MP+j/Aj4b1qL8WAvr0KphD6G9rpY/CLFyoBWijaU0+i3e63U2JBZRrCJzEjzGiJolQ
         vNSAtSpgOijbJ+H4bgPKL7cwp2LCXUnx5M62fJt9Hhh5Ip4/EWi8WT2pzDmUD4GalVRF
         hWTg==
X-Forwarded-Encrypted: i=1; AFNElJ9BcGf2qPDYwNUjkfwqnJFh7o0M+JsdM+cezSj0IdEhbR/tdwSGZu2fLEjHu9DMS7TM70hij3CYK0TlBsZNsi8tb1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTy53wBfWuVTHA8OdE6FNws5sDOitPuOkyhrk2PM5utMdybWG6
	PPiL8Copr9Nc25bvt65sErxzrGB/bpErbND35lDpISVccVSocHgHJRnm/Q/0MoNxM/9Q0FNMk17
	CmhgIHu9FAwUPNp3TsN8NUjvsJSlU05U1Q2NPahvgZtJX1RdpN9gb6mgofkPtLzFtFXHic46b1E
	5WS/GtL4Z25BenEIU2CJRWM8I5NUWvErODKnVmct4oVG3kY5f7
X-Gm-Gg: AeBDiesb2LGm7znFVanttDqytR3Fxrb2ev3XNIKuiiNg2xXsJZKm64WpegCi/AWLqti
	cEzY/42Ujbw9Og1gWNfVpy3pL7FvQv30uuODwLYNYy6M5V1GDdp8YeKfyfxduWvL3m6DZujd0DX
	uvhSZ/AKH3rdZ+6Q4SGTp6BXXwwm/Fg6zE32Uhaj7iunKjQ/Ve+ZMMMczdcQtszjVnE5kpNVPXo
	FSCsfqjb/+fDbP9dBE=
X-Received: by 2002:a53:ac9a:0:b0:651:d5cb:a490 with SMTP id 956f58d0204a3-65300f34cedmr63526d50.9.1776312892726;
        Wed, 15 Apr 2026 21:14:52 -0700 (PDT)
X-Received: by 2002:a53:ac9a:0:b0:651:d5cb:a490 with SMTP id
 956f58d0204a3-65300f34cedmr63494d50.9.1776312892131; Wed, 15 Apr 2026
 21:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226031741.230674-1-npache@redhat.com> <20260226032427.233282-1-npache@redhat.com>
 <9f0b8790-eace-4caa-a0c0-45f66285887f@lucifer.local>
In-Reply-To: <9f0b8790-eace-4caa-a0c0-45f66285887f@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 15 Apr 2026 22:14:45 -0600
X-Gm-Features: AQROBzC1KKy87TR-iBvBmj4hP_sLQhLGbBJB_L1VWLUErkn8zNpUDcEW6TlhoHU
Message-ID: <CAA1CXcDL20wS5u7FHHK8JFL5OVcopLtLrdwt34zN4RfriXsefg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v15 05/13] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mrs-HeVxX-aIWjGhjlwwUGH2YrmaTwN3mvox5y_uFyY_1776312893
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 10:52=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Wed, Feb 25, 2026 at 08:24:27PM -0700, Nico Pache wrote:
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
>
> The '--' seems weird here :) maybe meant to be ' - '?

It's called an em-dash, and I've been utilizing them for ages. Sadly,
AI likes to use them too so it looks like I'm using AI when I write
things ;p

>
> > the mTHP case this is not true, and we must keep the lock to prevent
> > changes to the VMA from occurring.
>
> You mean changes to the page tables right? rmap won't alter VMA parameter=
s
> without a VMA lock. Better to be specific.

yes, I will update, thanks!

>
> >
> > Also convert these BUG_ON's to WARN_ON_ONCE's as these conditions, whil=
e
> > unexpected, should not bring down the system.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 102 +++++++++++++++++++++++++++++-------------------
> >  1 file changed, 62 insertions(+), 40 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 99f78f0e44c6..fb3ba8fe5a6c 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1150,44 +1150,53 @@ static enum scan_result alloc_charge_folio(stru=
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
>
> This is getting horrible, could we maybe look at passing through a helper
> struct or something?

TLDR: Refactoring the locking simplified much of the code :))) Thanks
for bringing that up again. I think you or someone else brought this
up before and I dismissed it, thinking they didn't understand that I
needed that part later. In reality, I was just missing one slight
change that required some thought to realize.

Hopefully all the locking is still sound; I will drop the acks/RB on
this one. Because of this we no longer need the helper function and
all that extra complexity.

>
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
> > +     const unsigned long pmd_address =3D start_addr & HPAGE_PMD_MASK;
>
> We have start_addr and pmd_address, let's make our mind up and call both
> either addr or address please.

ok

>
> >
> > -     VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> > +     VM_WARN_ON_ONCE(pmd_address & ~HPAGE_PMD_MASK);
>
> You just masked this with HPAGE_PMD_MASK then check & ~HPAGE_PMD_MASK? :)
>
> Can we just drop it? :)

im cool with that.

>
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
>
> If you use a helper struct you can write a function that'll do both of
> these at once, E.g.:
>
> static void scan_mmap_unlock(struct scan_state *scan)
> {
>         if (!scan->mmap_locked)
>                 return;
>
>         mmap_read_unlock(scan->mm);
>         scan->mmap_locked =3D false;
> }
>
>         ...
>
>         scan_mmap_unlock(scan_state);
>
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
> Be nice to add a /*expect_anon=3D*/true, here so we can read what paramet=
er
> that is at a glance.

ack!

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
> > @@ -1197,13 +1206,16 @@ static enum scan_result collapse_huge_page(stru=
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
> > @@ -1213,20 +1225,20 @@ static enum scan_result collapse_huge_page(stru=
ct mm_struct *mm, unsigned long a
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
>
> Hmm you take an mmap... write lock here then don/t set *mmap_locked =3D
> true... It's inconsistent and bug prone.

yay we no longer need the gross lock tracking :)

>
> I'm also seriously not a fan of switching between mmap read and write loc=
k
> here but keeping an *mmap_locked parameter here which is begging for a bu=
g.
>
> In general though, you seem to always make sure in the (fairly hideous
> honestly) error goto labels to have the mmap lock dropped, so what is the
> point in keeping the *mmap_locked parameter updated throughou this anyway=
?

Cleaned up the locking and its all much better now

>
> Are we ever exiting with it set? If not why not drop the parameter/helper
> struct field and just have the caller understand that it's dropped on exi=
t
> (and document that).

This...

>
> Since you're just dropping the lock on entry, why not have the caller do
> that and document that you have to enter unlocked anyway?


+ moving one piece of code up into the parent (the part I was missing
conceptually) solved all this. Thanks!

>
>
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
>
> Again with a helper struct you can abstract this and avoid more noise.
>
> E.g. scan_anon_vma_lock_write(scan);
>
> >
> > -     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > -                             address + HPAGE_PMD_SIZE);
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start_ad=
dr,
> > +                             start_addr + (PAGE_SIZE << order));
>
> I hate this open-coded 'start_addr + (PAGE_SIZE << order)' construct.
>
> If you use a helper struct (theme here :) you could have a macro that
> generates it set an end param to this.

Ill probably just do a variable with map_size or something. I dont
think we need a helper for this.

>
>
> >       mmu_notifier_invalidate_range_start(&range);
> >
> >       pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> > @@ -1238,24 +1250,21 @@ static enum scan_result collapse_huge_page(stru=
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
>
> Will this work correctly with the non-PMD aligned start_addr?

Yes we generalize all the other functions in the previous patch if
that is what you are asking.

>
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
>
> Can we downgrade to WARN_ON_ONCE() as we pass by any BUG_ON()'s please?
> Since we're churning here anyway it's worth doing :)

ack.

>
> >               /*
> > @@ -1265,21 +1274,21 @@ static enum scan_result collapse_huge_page(stru=
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
>
> This is really unclear. What does 'can't run anymore' mean? Why must we
> hold the lock for mTHP?

In the PMD case we have isolated all the pages in the PMD, so no
changes can occur, and we don't need to hold the lock. in the mTHP
case, the PMD is only partially isolated, so if we drop the lock,
changes can occur to the rest of the PMD. This was based on a bug
found by Hugh https://lore.kernel.org/lkml/7a81339c-f9e5-a718-fa7f-6e3fb134=
dca5@google.com/

>
> I realise the previous comment was equally as unclear but let's make this
> make sense please :)

Ack ill make it more clear.

>
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
> > @@ -1289,20 +1298,34 @@ static enum scan_result collapse_huge_page(stru=
ct mm_struct *mm, unsigned long a
> >        * write.
> >        */
> >       __folio_mark_uptodate(folio);
> > -     pgtable =3D pmd_pgtable(_pmd);
> > +     if (is_pmd_order(order)) { /* PMD collapse */
>
> At this point we still hold the pte lock, is that intended? Are we sure
> there won't be any issues leaving it held during the operations that now
> happen before you release it?

I will verify before posting, but nothing has shown up in all my
testing (not that doesn't mean it's okay).

>
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
>
> If we're PMD order start_addr =3D=3D pmd_address right?

Correct. If you're asking why we don't uniformly use `start_addr`
across the board, it's because using the PMD variable seemed clearer
for PMD-related functions. Let me know which you prefer.

>
> > +     } else { /* mTHP collapse */
> > +             spin_lock(pmd_ptl);
> > +             WARN_ON_ONCE(!pmd_none(*pmd));
>
> You duplicate both of these lines in both branches, pull them out?

Ill give that a shot.

>
> > +             map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /*uf=
fd_wp=3D*/ false);
> > +             smp_wmb(); /* make PTEs visible before PMD. See pmd_insta=
ll() */
>
> It'd be much nicer to call pmd_install() :)

I don't think we can do that easily.

>
> Or maybe even to separate out the unlocked bit from pmd_install(), put th=
at
> in e.g. __pmd_install(), then use that after lock acquired?

Can we please save all this for later? It's rather trivial; and last
time I made a cosmetic change I broke something that i had spent over
a year testing and verifying.

>
> > +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > +     }
> >       spin_unlock(pmd_ptl);
> >
> >       folio =3D NULL;
>
> Not your code but... why? I guess to avoid the folio_put() below but
> gross. Anyway this function needs refactoring, can be a follow up.

ack

>
> >
> >       result =3D SCAN_SUCCEED;
> >  out_up_write:
> > +     if (anon_vma_locked)
> > +             anon_vma_unlock_write(vma->anon_vma);
> > +     if (pte)
> > +             pte_unmap(pte);
>
> Again can be helped with helper struct :)
>
> >       mmap_write_unlock(mm);
> > +     *mmap_locked =3D false;
>
> And this... I also hate the break from if (*mmap_locked) ... etc.
>
> >  out_nolock:
> > +     WARN_ON_ONCE(*mmap_locked);
>
> Should be a VM_WARN_ON_ONCE() if we keep it.

ack to the above. I will try cleaning up the locking.

>
> >       if (folio)
> >               folio_put(folio);
> >       trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, resul=
t);
> > @@ -1483,9 +1506,8 @@ static enum scan_result collapse_scan_pmd(struct =
mm_struct *mm,
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               result =3D collapse_huge_page(mm, start_addr, referenced,
> > -                                         unmapped, cc);
> > -             /* collapse_huge_page will return with the mmap_lock rele=
ased */
>
> Hm except this is true :) We also should probably just unlock before
> entering as mentioned before.

Ack will keep that in mind as part of above

>
> > -             *mmap_locked =3D false;
> > +                                         unmapped, cc, mmap_locked,
> > +                                         HPAGE_PMD_ORDER);
> >       }
> >  out:
> >       trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> > --
> > 2.53.0
> >
>
> Cheers, Lorenzo

Thank you for the review :)

Cheers,
-- Nico

>

