Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31211194A73
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780853; cv=none; b=Vbj6XbMGrYSJvsaj6S5T0jYS93/osroJ8kaMwCSWglsHN7htlOim35hrWdQFC+EqAOqhlqX21zRreazyxrSAMzfWthEdjCOv7VLgo4AZONvxZiXdyig1H3XvrUXoPLCL4hwyw8nLWlJ3fF4+fLPF3hxTMq3qsflE+fcq67iO8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780853; c=relaxed/simple;
	bh=vEBH9XPc2rKbCjMaVjOOuA3NRcebjaC+ZlxyGTwiRu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jsp6KdAxe+FStufbg8oh4d2Tr5RpDazkLKE2wezgtugEOE2Fteq/R/bsY0C3lxSWSid/igKvNRVO5MuYHDfHxW0C4RAselJTlc3OA0Fzhw1IXqpD9YADA1k4S4vZXy8uzIi4JXClTHdR7mQUMv5Q9rHJALXf1HuP8OOHChAz5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SALqeAnv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SALqeAnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762780850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urxiosn/NbwpEI7+7ewd9/gyn1msOWD8+3UzRaHmJoM=;
	b=SALqeAnvicRZgRuMq6VsXc1UhXdD07tryneCy7IflZ8GOId3OrhbERjgHB1FpSJzZEvK7b
	o3HnqgcJM6PzlpAQ1Ezdx1rpWsFt8klS04RD4dqSeZFQslwnt0+xzUGTtnrMbg0vNAEvE1
	sKVe+w90xMAMPsC1EonB13aEeFNV8sE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-F3-pP-YZNsKErnGcSIuV9g-1; Mon, 10 Nov 2025 08:20:49 -0500
X-MC-Unique: F3-pP-YZNsKErnGcSIuV9g-1
X-Mimecast-MFC-AGG-ID: F3-pP-YZNsKErnGcSIuV9g_1762780848
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63f9f128060so854079d50.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780848; x=1763385648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=urxiosn/NbwpEI7+7ewd9/gyn1msOWD8+3UzRaHmJoM=;
        b=VyhknJ/zPm3G9JPYR9LDD1DWmpHsu24A7bKk3w7teJQG07bwxqBKY4EIHB6aGsc/PU
         m8GMaN/7kuhZJaTqo+weOVd9TNuINmZ/6oUPT30q3LASDJa6bDV2Z1J3Qq4WjHHWRsEF
         BfcCjKkG9//mNQ11KOgC0YPn7w41kFZ2hfol71mXlpS2pqnWIo66fEZyZHSH81eEtGk0
         7qc3aQ9cilBW8h3YTgqX/F2IpELJGRP0m7+C6Ih3NvdJANXtinhHuYJ/zcEm3AhQvBUj
         ryjYqcxmT/kcY9C12c/ldI1S92mm8cMf3YVqnQxqSWnVrO6YhanFhJlPVAYDUpW7T1Pn
         Kslg==
X-Forwarded-Encrypted: i=1; AJvYcCV84BpBAWMB9zRnWH26ilDlrJ0QS9LcjZaj0NibfYno2lYRMXLlyp//xuLxctUb9auOjwbwjOStD6zY+eUYSHmglWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/OTS+xK7rliUZbv7NYw3pjaB1Ao7/6bW8B//PJ6MdznqS04ox
	sro+xxVqJg7cHHTD2K4MN3rBAFZCRqXlYrbqqEw4LqZKMJ3B2EZs5KnL7HMR8e7Sj6DzEzo64xe
	UeIHbO/opfWE80VyRPf54//kqthYn+wDDXpR7kvpitDXG9DycGaTzrw3/BCXitklXglioMWepsW
	YW5OxGvlEhVl+hTRYWM7Nr61tt7uaMuWpn+FIweNL5KTt7Ty05
X-Gm-Gg: ASbGncu6bgsKV+1ThrM781sJ3yAPmfe8pwTtm2fI9ye/Bc+Jnp7PbxLNb1NYm2dcbbB
	UiSWbAPHy527ZaLUHCYaChAgiIvxsP4h0Y2GM3JpTZGoKynWO7oGMO70j0QRyInJ0yPljam1JZl
	75UzKGA87z7V/DP6+D4z8nwm858zntJ1XhxQR/krEVHDgN7ci8rzBvSxDssZRgGxwh+7gzTg==
X-Received: by 2002:a05:690e:4294:10b0:63e:2269:42eb with SMTP id 956f58d0204a3-640d45e44c7mr6043610d50.45.1762780848420;
        Mon, 10 Nov 2025 05:20:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTRQESUUA3UUwtC2W4YtCmQg9mhvjmQTjoTx734yFEd98HC1RArMhT0g1T28Uas2i8mqc5JggC/bkNFhlknoM=
X-Received: by 2002:a05:690e:4294:10b0:63e:2269:42eb with SMTP id
 956f58d0204a3-640d45e44c7mr6043563d50.45.1762780847954; Mon, 10 Nov 2025
 05:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-6-npache@redhat.com>
 <c006138d-6d12-4f91-8a06-da279ae3795a@lucifer.local>
In-Reply-To: <c006138d-6d12-4f91-8a06-da279ae3795a@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Mon, 10 Nov 2025 06:20:21 -0700
X-Gm-Features: AWmQ_blTm6w8ib4f4NzgbzKAoQLgTz4lR-RJcVNY7GnUdXc1WfEKmfLTDuAagMs
Message-ID: <CAA1CXcBefDp4hzU6-jLf6XEWEaZaaX4SdCN0awxm1qz9RAWQFg@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 05/15] khugepaged: generalize
 __collapse_huge_page_* for mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mstmuf7_R-QNbhVzTNTvQvf6b83skcuKlcIZ8_6mwBM_1762780848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:02=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:37:07PM -0600, Nico Pache wrote:
> > generalize the order of the __collapse_huge_page_* functions
> > to support future mTHP collapse.
> >
> > mTHP collapse will not honor the khugepaged_max_ptes_shared or
> > khugepaged_max_ptes_swap parameters, and will fail if it encounters a
> > shared or swapped entry.
> >
> > No functional changes in this patch.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> Thanks for addressing the v10 stuff (didn't check at v11).
>
> Overall LGTM, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!
>
> Few minor nits below.
>
> > ---
> >  mm/khugepaged.c | 78 ++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 48 insertions(+), 30 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 36ee659acfbb..4ccebf5dda97 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -537,25 +537,25 @@ static void release_pte_pages(pte_t *pte, pte_t *=
_pte,
> >  }
> >
> >  static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > -                                     unsigned long start_addr,
> > -                                     pte_t *pte,
> > -                                     struct collapse_control *cc,
> > -                                     struct list_head *compound_pageli=
st)
> > +             unsigned long start_addr, pte_t *pte, struct collapse_con=
trol *cc,
> > +             unsigned int order, struct list_head *compound_pagelist)
>
> This series isn't the right place for it, but god do we need helper struc=
ts in
> this code... :)

Well we have collapse_control! I can spend some time in a follow up
series to better leverage this struct.

>
> >  {
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       unsigned long addr =3D start_addr;
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> > +     const unsigned long nr_pages =3D 1UL << order;
> > +     int max_ptes_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDE=
R - order);
>
> Nit, but we should const-ify this too.

This gets converted to collapse_max_ptes_none in the future.

>
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> > +     for (_pte =3D pte; _pte < pte + nr_pages;
> >            _pte++, addr +=3D PAGE_SIZE) {
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (pte_none_or_zero(pteval)) {
> >                       ++none_or_zero;
> >                       if (!userfaultfd_armed(vma) &&
> >                           (!cc->is_khugepaged ||
> > -                          none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> > +                          none_or_zero <=3D max_ptes_none)) {
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -583,8 +583,14 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >               /* See collapse_scan_pmd(). */
> >               if (folio_maybe_mapped_shared(folio)) {
> >                       ++shared;
> > -                     if (cc->is_khugepaged &&
> > -                         shared > khugepaged_max_ptes_shared) {
> > +                     /*
> > +                      * TODO: Support shared pages without leading to =
further
> > +                      * mTHP collapses. Currently bringing in new page=
s via
> > +                      * shared may cause a future higher order collaps=
e on a
> > +                      * rescan of the same range.
> > +                      */
>
> Yeah, I wish we could find a way to address this in some other way but gi=
ven the
> mire of THP code putting this comment here for now is probably the only s=
ensible
> way.
>
> > +                     if (order !=3D HPAGE_PMD_ORDER || (cc->is_khugepa=
ged &&
> > +                         shared > khugepaged_max_ptes_shared)) {
> >                               result =3D SCAN_EXCEED_SHARED_PTE;
> >                               count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> >                               goto out;
> > @@ -677,18 +683,18 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
> >  }
> >
> >  static void __collapse_huge_page_copy_succeeded(pte_t *pte,
> > -                                             struct vm_area_struct *vm=
a,
> > -                                             unsigned long address,
> > -                                             spinlock_t *ptl,
> > -                                             struct list_head *compoun=
d_pagelist)
> > +             struct vm_area_struct *vma, unsigned long address,
> > +             spinlock_t *ptl, unsigned int order,
> > +             struct list_head *compound_pagelist)
> >  {
> > -     unsigned long end =3D address + HPAGE_PMD_SIZE;
> > +     unsigned long end =3D address + (PAGE_SIZE << order);
> >       struct folio *src, *tmp;
> >       pte_t pteval;
> >       pte_t *_pte;
> >       unsigned int nr_ptes;
> > +     const unsigned long nr_pages =3D 1UL << order;
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR; _pte +=3D nr_ptes,
> > +     for (_pte =3D pte; _pte < pte + nr_pages; _pte +=3D nr_ptes,
> >            address +=3D nr_ptes * PAGE_SIZE) {
> >               nr_ptes =3D 1;
> >               pteval =3D ptep_get(_pte);
> > @@ -741,13 +747,11 @@ static void __collapse_huge_page_copy_succeeded(p=
te_t *pte,
> >  }
> >
> >  static void __collapse_huge_page_copy_failed(pte_t *pte,
> > -                                          pmd_t *pmd,
> > -                                          pmd_t orig_pmd,
> > -                                          struct vm_area_struct *vma,
> > -                                          struct list_head *compound_p=
agelist)
> > +             pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> > +             unsigned int order, struct list_head *compound_pagelist)
> >  {
> >       spinlock_t *pmd_ptl;
> > -
> > +     const unsigned long nr_pages =3D 1UL << order;
> >       /*
> >        * Re-establish the PMD to point to the original page table
> >        * entry. Restoring PMD needs to be done prior to releasing
> > @@ -761,7 +765,7 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >        * Release both raw and compound pages isolated
> >        * in __collapse_huge_page_isolate.
> >        */
> > -     release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> > +     release_pte_pages(pte, pte + nr_pages, compound_pagelist);
> >  }
> >
> >  /*
> > @@ -781,16 +785,16 @@ static void __collapse_huge_page_copy_failed(pte_=
t *pte,
> >   */
> >  static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
> >               pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> > -             unsigned long address, spinlock_t *ptl,
> > +             unsigned long address, spinlock_t *ptl, unsigned int orde=
r,
> >               struct list_head *compound_pagelist)
> >  {
> >       unsigned int i;
> >       int result =3D SCAN_SUCCEED;
> > -
> > +     const unsigned long nr_pages =3D 1UL << order;
> >       /*
> >        * Copying pages' contents is subject to memory poison at any ite=
ration.
> >        */
> > -     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +     for (i =3D 0; i < nr_pages; i++) {
> >               pte_t pteval =3D ptep_get(pte + i);
> >               struct page *page =3D folio_page(folio, i);
> >               unsigned long src_addr =3D address + i * PAGE_SIZE;
> > @@ -809,10 +813,10 @@ static int __collapse_huge_page_copy(pte_t *pte, =
struct folio *folio,
> >
> >       if (likely(result =3D=3D SCAN_SUCCEED))
> >               __collapse_huge_page_copy_succeeded(pte, vma, address, pt=
l,
> > -                                                 compound_pagelist);
> > +                                                 order, compound_pagel=
ist);
> >       else
> >               __collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> > -                                              compound_pagelist);
> > +                                              order, compound_pagelist=
);
> >
> >       return result;
> >  }
> > @@ -985,13 +989,12 @@ static int check_pmd_still_valid(struct mm_struct=
 *mm,
> >   * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
> >   */
> >  static int __collapse_huge_page_swapin(struct mm_struct *mm,
> > -                                    struct vm_area_struct *vma,
> > -                                    unsigned long start_addr, pmd_t *p=
md,
> > -                                    int referenced)
> > +             struct vm_area_struct *vma, unsigned long start_addr,
> > +             pmd_t *pmd, int referenced, unsigned int order)
>
> Nit, super nit really, but since other __collapse_huge_page_*() functions=
 have
> ..., order, param) as their last parameters, perhaps worth flipping refer=
enced +
> order here?
>
> Not a big deal though.
>
> >  {
> >       int swapped_in =3D 0;
> >       vm_fault_t ret =3D 0;
> > -     unsigned long addr, end =3D start_addr + (HPAGE_PMD_NR * PAGE_SIZ=
E);
> > +     unsigned long addr, end =3D start_addr + (PAGE_SIZE << order);
> >       int result;
> >       pte_t *pte =3D NULL;
> >       spinlock_t *ptl;
> > @@ -1022,6 +1025,19 @@ static int __collapse_huge_page_swapin(struct mm=
_struct *mm,
> >               if (!is_swap_pte(vmf.orig_pte))
> >                       continue;
> >
> > +             /*
> > +              * TODO: Support swapin without leading to further mTHP
> > +              * collapses. Currently bringing in new pages via swapin =
may
> > +              * cause a future higher order collapse on a rescan of th=
e same
> > +              * range.
> > +              */
>
> Same comment as above re: this, i.e. that it's a pity but probably unavoi=
dable
> for now.
>
> > +             if (order !=3D HPAGE_PMD_ORDER) {
> > +                     pte_unmap(pte);
> > +                     mmap_read_unlock(mm);
> > +                     result =3D SCAN_EXCEED_SWAP_PTE;
> > +                     goto out;
> > +             }
> > +
> >               vmf.pte =3D pte;
> >               vmf.ptl =3D ptl;
> >               ret =3D do_swap_page(&vmf);
> > @@ -1142,7 +1158,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >                * that case.  Continuing to collapse causes inconsistenc=
y.
> >                */
> >               result =3D __collapse_huge_page_swapin(mm, vma, address, =
pmd,
> > -                                                  referenced);
> > +                                                  referenced, HPAGE_PM=
D_ORDER);
> >               if (result !=3D SCAN_SUCCEED)
> >                       goto out_nolock;
> >       }
> > @@ -1190,6 +1206,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> >       if (pte) {
> >               result =3D __collapse_huge_page_isolate(vma, address, pte=
, cc,
> > +                                                   HPAGE_PMD_ORDER,
> >                                                     &compound_pagelist)=
;
> >               spin_unlock(pte_ptl);
> >       } else {
> > @@ -1220,6 +1237,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >
> >       result =3D __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> >                                          vma, address, pte_ptl,
> > +                                        HPAGE_PMD_ORDER,
> >                                          &compound_pagelist);
> >       pte_unmap(pte);
> >       if (unlikely(result !=3D SCAN_SUCCEED))
> > --
> > 2.51.0
> >
>

