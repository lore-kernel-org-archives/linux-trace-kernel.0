Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09D3815D9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677746; cv=none; b=gDwsRzTLyJVjJLc2asuSZwhXkv7ShVvnPVvylNUHnaVgFY3VzJNyjk0KzG1X2Al88yXQbbvIC++lbnqaTioWOy+vtF4fOqcP7CK7JViYR4BSpRSo770Fv/lebv5+Rg4e6IZtg/JpNb2LI8iiGipOU3iCdAn2BzWTkfL50PTzAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677746; c=relaxed/simple;
	bh=AeOjg4Jddf5MO5WmWnokhyLQPgGJ785kavbAxEYTZbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=romFOKxHZsvbOZX9WAMr5KaGqkifMvLaHZIvxNlfmhNTVV1LSXg/8dOUqnU2PINvMVuq6A+rdBMp/804Ej5NMzN3SToLZtlujcQg4us6IW5wvDx64RAsNodYICpnln/o2M1C/m5fpBjbs7UGp1af6NrXnfZ7DgpfQNc6nZPAlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmgmjUyr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmgmjUyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775677741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6lebmAFqUc0VWZTv0HOUyslnYO3ZnOF7fQDUUciAcQ=;
	b=VmgmjUyrbHu3XU+hBtBqvlaIcHruzqZq/RFpdHVFFaxYYjNCiWKhYOd+II3TDcsNQ9REV1
	TzzGITWPW6CJtEu6Sx3Be+CD5OVhgpvGZVj2PiEqRfvovHIs1DfrG6NqMmtEAJ7tGhHwhR
	ydm38VMFMbmo6nSOfGPw351UAZeoo5M=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-YwVSFEQPM_-DQueees4gGg-1; Wed, 08 Apr 2026 15:48:59 -0400
X-MC-Unique: YwVSFEQPM_-DQueees4gGg-1
X-Mimecast-MFC-AGG-ID: YwVSFEQPM_-DQueees4gGg_1775677738
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7a5f9d43c48so2209997b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 12:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677738; x=1776282538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s6lebmAFqUc0VWZTv0HOUyslnYO3ZnOF7fQDUUciAcQ=;
        b=IE8kBXzuyKjcQSMDzBYT4vFgPICHb4H4/TRZh3SJXYVeZZ8H6dYmew9Th+eYnuFIw8
         uEjNlGUiO/owru7N2uS19CO0ueyN+VUlTe29e4wNUj8FNBLXv//+ynxMGT5xlVOaYQDq
         uKpU0IFwgVdkLU+G9BDDaw1vMPV+fMweNz27mAuN53frAqJJoANS99cT1X/mR3/cnD42
         xJvhqyhmeGKm0GTXbXzlvw4ppS3Sn8lqj3gN9QwPYtA872robaeClofZ5Y4Mxwud4scc
         pbNzDvQh1N/ZKMZv+BSoKdhhl+M0A63BRUE+F2OFuSeK7q/D/68xptpYfv+GXDTGlVCD
         N5bA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Z7sRhN60tJDqY/AvPOFUEmP0yHKjy9t0KKymjLrlIOKm2hiSARCnr8cdztVxWq5XGYdeD4W1MtixDXoTexsdrcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLSZkIUMt1/TvIEZ6YAHb9dQmpFiZX2w8ShJMUzitHSq3Vg+e
	cSAK2UiFSM8wu0Wycv6QZzK5FCbcH44mtmEEGE3HYjVaJ//0eSCbbCcLhjhVWVijncOBpZHpkNh
	U8SfkP9qJc6Tw1dR+w5yWxRtBPAmA7GD1Jnty5LU5jya1B4W5mHRhA8io/VwOp2AoCYqVUUt1xo
	QEFPOXdnJSdtHH4uy8m5FlsbLPNDp+X4QJanG8ixTyIzZ5mIeX
X-Gm-Gg: AeBDieuVX3ypVYUW5N1QRp0uTltutNIcgnWNcLC+iJSGvZdEXjDyGCMgL1xekWpZvvU
	Bs13c8WiObmCvPl7B24JR4gjQEywomno65ol3lwZt5JHxNM4vAzqYKdNqGhe+H0NSaeBSVD/Pub
	eStX/Pq0NdHpKroZSTfxUOCfVnY1LbChMhHx6b1Na1dGlQ2XjOGG1Z7ErF3UdO0h6bNylDDc1G0
	kUAsZVr
X-Received: by 2002:a05:690e:1501:b0:64e:a976:dc0f with SMTP id 956f58d0204a3-6504870ac04mr22045461d50.19.1775677738214;
        Wed, 08 Apr 2026 12:48:58 -0700 (PDT)
X-Received: by 2002:a05:690e:1501:b0:64e:a976:dc0f with SMTP id
 956f58d0204a3-6504870ac04mr22045409d50.19.1775677737724; Wed, 08 Apr 2026
 12:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226031741.230674-1-npache@redhat.com> <20260226032347.232939-1-npache@redhat.com>
 <8a4568de-e0f9-471b-bc94-1062d4af3938@kernel.org> <ee39e605-0d9f-433b-9dfa-f70fd92edfac@kernel.org>
 <c4e80668-9018-48fc-883c-5d52a5950065@kernel.org>
In-Reply-To: <c4e80668-9018-48fc-883c-5d52a5950065@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 8 Apr 2026 13:48:43 -0600
X-Gm-Features: AQROBzAhFnBMl7uCD_-PNdDxiKciHJ1I9BsrODaSd6nYngTKfPDHydTd_07lxzo
Message-ID: <CAA1CXcA8nE2PZrB4J1gV5v16PeQ7X2AiwjJ3gO1Q8hW7tyTtPQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v15 03/13] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
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
X-Mimecast-MFC-PROC-ID: ckes-HYNo1yzXNUEGCzY0UnaVPDm9moiDgOZRKFM7a0_1775677738
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:56=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 3/12/26 21:36, David Hildenbrand (Arm) wrote:
> > On 3/12/26 21:32, David Hildenbrand (Arm) wrote:
> >> On 2/26/26 04:23, Nico Pache wrote:
> >>> generalize the order of the __collapse_huge_page_* functions
> >>> to support future mTHP collapse.
> >>>
> >>> mTHP collapse will not honor the khugepaged_max_ptes_shared or
> >>> khugepaged_max_ptes_swap parameters, and will fail if it encounters a
> >>> shared or swapped entry.
> >>>
> >>> No functional changes in this patch.
> >>>
> >>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> >>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> >>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>> Co-developed-by: Dev Jain <dev.jain@arm.com>
> >>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> >>> Signed-off-by: Nico Pache <npache@redhat.com>
> >>> ---
> >>>  mm/khugepaged.c | 73 +++++++++++++++++++++++++++++++----------------=
--
> >>>  1 file changed, 47 insertions(+), 26 deletions(-)
> >>>
> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>> index a9b645402b7f..ecdbbf6a01a6 100644
> >>> --- a/mm/khugepaged.c
> >>> +++ b/mm/khugepaged.c
> >>> @@ -535,7 +535,7 @@ static void release_pte_pages(pte_t *pte, pte_t *=
_pte,
> >>>
> >>>  static enum scan_result __collapse_huge_page_isolate(struct vm_area_=
struct *vma,
> >>>             unsigned long start_addr, pte_t *pte, struct collapse_con=
trol *cc,
> >>> -           struct list_head *compound_pagelist)
> >>> +           unsigned int order, struct list_head *compound_pagelist)
> >>>  {
> >>>     struct page *page =3D NULL;
> >>>     struct folio *folio =3D NULL;
> >>> @@ -543,15 +543,17 @@ static enum scan_result __collapse_huge_page_is=
olate(struct vm_area_struct *vma,
> >>>     pte_t *_pte;
> >>>     int none_or_zero =3D 0, shared =3D 0, referenced =3D 0;
> >>>     enum scan_result result =3D SCAN_FAIL;
> >>> +   const unsigned long nr_pages =3D 1UL << order;
> >>> +   int max_ptes_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDE=
R - order);
> >>
> >> It might be a bit more readable to move "const unsigned long
> >> nr_pages =3D 1UL << order;" all the way to the top.
> >>
> >> Then, have here
> >>
> >>      int max_ptes_none =3D 0;
> >>
> >> and do at the beginning of the function:
> >>
> >>      /* For MADV_COLLAPSE, we always collapse ... */
> >>      if (!cc->is_khugepaged)
> >>              max_ptes_none =3D HPAGE_PMD_NR;
> >>      /*  ... except if userfaultf relies on MISSING faults. */
> >>      if (!userfaultfd_armed(vma))
> >>              max_ptes_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_=
ORDER - order);
> >>
> >> (but see below regarding helper function)
> >>
> >> then the code below becomes ...
> >>
> >>>
> >>> -   for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> >>> +   for (_pte =3D pte; _pte < pte + nr_pages;
> >>>          _pte++, addr +=3D PAGE_SIZE) {
> >>>             pte_t pteval =3D ptep_get(_pte);
> >>>             if (pte_none_or_zero(pteval)) {
> >>>                     ++none_or_zero;
> >>>                     if (!userfaultfd_armed(vma) &&
> >>>                         (!cc->is_khugepaged ||
> >>> -                        none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> >>> +                        none_or_zero <=3D max_ptes_none)) {
> >>
> >> ...
> >>
> >>      if (none_or_zero <=3D max_ptes_none) {
> >>
> >>
> >> I see that you do something like that (but slightly different) in the =
next
> >> patch. You could easily extend the above by it.
> >>
> >> Or go one step further and move all of that conditional into collapse_=
max_ptes_none(), whereby
> >> you simply also pass the cc and the vma.
> >>
> >> Then this all gets cleaned up and you'd end up above with
> >>
> >> max_ptes_none =3D collapse_max_ptes_none(cc, vma, order);
> >> if (max_ptes_none < 0)
> >>      return result;
> >>
> >> I'd do all that in this patch here, getting rid of #4.
> >>
> >>
> >>>                             continue;
> >>>                     } else {
> >>>                             result =3D SCAN_EXCEED_NONE_PTE;
> >>> @@ -585,8 +587,14 @@ static enum scan_result __collapse_huge_page_iso=
late(struct vm_area_struct *vma,
> >>>             /* See collapse_scan_pmd(). */
> >>>             if (folio_maybe_mapped_shared(folio)) {
> >>>                     ++shared;
> >>> -                   if (cc->is_khugepaged &&
> >>> -                       shared > khugepaged_max_ptes_shared) {
> >>> +                   /*
> >>> +                    * TODO: Support shared pages without leading to =
further
> >>> +                    * mTHP collapses. Currently bringing in new page=
s via
> >>> +                    * shared may cause a future higher order collaps=
e on a
> >>> +                    * rescan of the same range.
> >>> +                    */
> >>> +                   if (!is_pmd_order(order) || (cc->is_khugepaged &&
> >>> +                       shared > khugepaged_max_ptes_shared)) {
> >>
> >> That's not how we indent within a nested ().
> >>
> >> To make this easier to read, what about similarly having at the beginn=
ing
> >> of the function:
> >>
> >> int max_ptes_shared =3D 0;
> >>
> >> /* For MADV_COLLAPSE, we always collapse. */
> >> if (cc->is_khugepaged)
> >>      max_ptes_none =3D HPAGE_PMD_NR;
> >> /* TODO ... */
> >> if (is_pmd_order(order))
> >>      max_ptes_none =3D khugepaged_max_ptes_shared;
> >>
> >> to turn this code into a
> >>
> >>      if (shared > khugepaged_max_ptes_shared)
> >>
> >> Also, here, might make sense to have a collapse_max_ptes_swap(cc, orde=
r)
> >> to do that and clean it up.
> >>
> >>
> >>>                             result =3D SCAN_EXCEED_SHARED_PTE;
> >>>                             count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> >>>                             goto out;
> >>> @@ -679,18 +687,18 @@ static enum scan_result __collapse_huge_page_is=
olate(struct vm_area_struct *vma,
> >>>  }
> >>>
> >>>  static void __collapse_huge_page_copy_succeeded(pte_t *pte,
> >>> -                                           struct vm_area_struct *vm=
a,
> >>> -                                           unsigned long address,
> >>> -                                           spinlock_t *ptl,
> >>> -                                           struct list_head *compoun=
d_pagelist)
> >>> +           struct vm_area_struct *vma, unsigned long address,
> >>> +           spinlock_t *ptl, unsigned int order,
> >>> +           struct list_head *compound_pagelist)
> >>>  {
> >>> -   unsigned long end =3D address + HPAGE_PMD_SIZE;
> >>> +   unsigned long end =3D address + (PAGE_SIZE << order);
> >>>     struct folio *src, *tmp;
> >>>     pte_t pteval;
> >>>     pte_t *_pte;
> >>>     unsigned int nr_ptes;
> >>> +   const unsigned long nr_pages =3D 1UL << order;
> >>
> >> Move it further to the top.
> >>
> >>>
> >>> -   for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR; _pte +=3D nr_ptes,
> >>> +   for (_pte =3D pte; _pte < pte + nr_pages; _pte +=3D nr_ptes,
> >>>          address +=3D nr_ptes * PAGE_SIZE) {
> >>>             nr_ptes =3D 1;
> >>>             pteval =3D ptep_get(_pte);
> >>> @@ -743,13 +751,11 @@ static void __collapse_huge_page_copy_succeeded=
(pte_t *pte,
> >>>  }
> >>>
> >>>  static void __collapse_huge_page_copy_failed(pte_t *pte,
> >>> -                                        pmd_t *pmd,
> >>> -                                        pmd_t orig_pmd,
> >>> -                                        struct vm_area_struct *vma,
> >>> -                                        struct list_head *compound_p=
agelist)
> >>> +           pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> >>> +           unsigned int order, struct list_head *compound_pagelist)
> >>>  {
> >>>     spinlock_t *pmd_ptl;
> >>> -
> >>> +   const unsigned long nr_pages =3D 1UL << order;
> >>>     /*
> >>>      * Re-establish the PMD to point to the original page table
> >>>      * entry. Restoring PMD needs to be done prior to releasing
> >>> @@ -763,7 +769,7 @@ static void __collapse_huge_page_copy_failed(pte_=
t *pte,
> >>>      * Release both raw and compound pages isolated
> >>>      * in __collapse_huge_page_isolate.
> >>>      */
> >>> -   release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> >>> +   release_pte_pages(pte, pte + nr_pages, compound_pagelist);
> >>>  }
> >>>
> >>>  /*
> >>> @@ -783,16 +789,16 @@ static void __collapse_huge_page_copy_failed(pt=
e_t *pte,
> >>>   */
> >>>  static enum scan_result __collapse_huge_page_copy(pte_t *pte, struct=
 folio *folio,
> >>>             pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> >>> -           unsigned long address, spinlock_t *ptl,
> >>> +           unsigned long address, spinlock_t *ptl, unsigned int orde=
r,
> >>>             struct list_head *compound_pagelist)
> >>>  {
> >>>     unsigned int i;
> >>>     enum scan_result result =3D SCAN_SUCCEED;
> >>> -
> >>> +   const unsigned long nr_pages =3D 1UL << order;
> >>
> >> Same here, all the way to the top.
> >>
> >>>     /*
> >>>      * Copying pages' contents is subject to memory poison at any ite=
ration.
> >>>      */
> >>> -   for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> >>> +   for (i =3D 0; i < nr_pages; i++) {
> >>>             pte_t pteval =3D ptep_get(pte + i);
> >>>             struct page *page =3D folio_page(folio, i);
> >>>             unsigned long src_addr =3D address + i * PAGE_SIZE;
> >>> @@ -811,10 +817,10 @@ static enum scan_result __collapse_huge_page_co=
py(pte_t *pte, struct folio *foli
> >>>
> >>>     if (likely(result =3D=3D SCAN_SUCCEED))
> >>>             __collapse_huge_page_copy_succeeded(pte, vma, address, pt=
l,
> >>> -                                               compound_pagelist);
> >>> +                                               order, compound_pagel=
ist);
> >>>     else
> >>>             __collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> >>> -                                            compound_pagelist);
> >>> +                                            order, compound_pagelist=
);
> >>>
> >>>     return result;
> >>>  }
> >>> @@ -985,12 +991,12 @@ static enum scan_result check_pmd_still_valid(s=
truct mm_struct *mm,
> >>>   * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
> >>>   */
> >>>  static enum scan_result __collapse_huge_page_swapin(struct mm_struct=
 *mm,
> >>> -           struct vm_area_struct *vma, unsigned long start_addr, pmd=
_t *pmd,
> >>> -           int referenced)
> >>> +           struct vm_area_struct *vma, unsigned long start_addr,
> >>> +           pmd_t *pmd, int referenced, unsigned int order)
> >>>  {
> >>>     int swapped_in =3D 0;
> >>>     vm_fault_t ret =3D 0;
> >>> -   unsigned long addr, end =3D start_addr + (HPAGE_PMD_NR * PAGE_SIZ=
E);
> >>> +   unsigned long addr, end =3D start_addr + (PAGE_SIZE << order);
> >>>     enum scan_result result;
> >>>     pte_t *pte =3D NULL;
> >>>     spinlock_t *ptl;
> >>> @@ -1022,6 +1028,19 @@ static enum scan_result __collapse_huge_page_s=
wapin(struct mm_struct *mm,
> >>>                 pte_present(vmf.orig_pte))
> >>>                     continue;
> >>>
> >>> +           /*
> >>> +            * TODO: Support swapin without leading to further mTHP
> >>> +            * collapses. Currently bringing in new pages via swapin =
may
> >>> +            * cause a future higher order collapse on a rescan of th=
e same
> >>> +            * range.
> >>> +            */
> >>> +           if (!is_pmd_order(order)) {
> >>> +                   pte_unmap(pte);
> >>> +                   mmap_read_unlock(mm);
> >>> +                   result =3D SCAN_EXCEED_SWAP_PTE;
> >>> +                   goto out;
> >>> +           }
> >>> +
> >>
> >> Interesting, we just swapin everything we find :)
> >>
> >> But do we really need this check here? I mean, we just found it to be =
present.
> >>
> >> In the rare event that there was a race, do we really care? It was jus=
t
> >> present, now it's swapped. Bad luck. Just swap it in.
> >>
> >
> > Okay, now I am confused. Why are you not taking care of
> > collapse_scan_pmd() in the same context?
> >
> > Because if you make sure that we properly check against a max_ptes_swap
> > similar as in the style above, we'd rule out swapin right from the star=
t?
> >
> > Also, I would expect that all other parameters in there are similarly
> > handled?
> >
>
> Okay, I think you should add the following:

Hey! Thanks for all your reviews here.

For multiple reasons, here is the solution I developed:

Add a patch before the generalize __collapse.. patch that reworks the
max_ptes* handling and introduces the helpers (no functional changes).

I later updated these functions to follow the specific mthp rules in
the generalization patch. Honestly, refactoring much of this has been
very hard without one large patch, which is why we split it up
initially.

How does that sound?

-- Nico

>
> From 17bce81ab93f3b16e044ac2f4f62be19aac38180 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Thu, 12 Mar 2026 21:54:22 +0100
> Subject: [PATCH] tmp
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/khugepaged.c | 89 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 36 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b7b4680d27ab..6a3773bfa0a2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -318,6 +318,34 @@ static ssize_t max_ptes_shared_store(struct kobject =
*kobj,
>         return count;
>  }
>
> +static int collapse_max_ptes_none(struct collapse_control *cc,
> +               struct vm_area_struct *vma)
> +{
> +       /* We don't mess with MISSING faults. */
> +       if (vma && userfaultfd_armed(vma))
> +               return 0;
> +       /* MADV_COLLAPSE always collapses. */
> +       if (!cc->is_khugepaged)
> +               return HPAGE_PMD_NR;
> +       return khugepaged_max_ptes_none;
> +}
> +
> +static int collapse_max_ptes_shared(struct collapse_control *cc)
> +{
> +       /* MADV_COLLAPSE always collapses. */
> +       if (!cc->is_khugepaged)
> +               return HPAGE_PMD_NR;
> +       return khugepaged_max_ptes_shared;
> +}
> +
> +static int collapse_max_ptes_swap(struct collapse_control *cc)
> +{
> +       /* MADV_COLLAPSE always collapses. */
> +       if (!cc->is_khugepaged)
> +               return HPAGE_PMD_NR;
> +       return khugepaged_max_ptes_swap;
> +}
> +
>  static struct kobj_attribute khugepaged_max_ptes_shared_attr =3D
>         __ATTR_RW(max_ptes_shared);
>
> @@ -539,6 +567,8 @@ static enum scan_result __collapse_huge_page_isolate(=
struct vm_area_struct *vma,
>                 unsigned long start_addr, pte_t *pte, struct collapse_con=
trol *cc,
>                 struct list_head *compound_pagelist)
>  {
> +       const int max_ptes_none =3D collapse_max_ptes_none(cc, vma);
> +       const int max_ptes_shared =3D collapse_max_ptes_shared(cc);
>         struct page *page =3D NULL;
>         struct folio *folio =3D NULL;
>         unsigned long addr =3D start_addr;
> @@ -550,16 +580,12 @@ static enum scan_result __collapse_huge_page_isolat=
e(struct vm_area_struct *vma,
>              _pte++, addr +=3D PAGE_SIZE) {
>                 pte_t pteval =3D ptep_get(_pte);
>                 if (pte_none_or_zero(pteval)) {
> -                       ++none_or_zero;
> -                       if (!userfaultfd_armed(vma) &&
> -                           (!cc->is_khugepaged ||
> -                            none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> -                               continue;
> -                       } else {
> +                       if (++none_or_zero > max_ptes_none) {
>                                 result =3D SCAN_EXCEED_NONE_PTE;
>                                 count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>                                 goto out;
>                         }
> +                       continue;
>                 }
>                 if (!pte_present(pteval)) {
>                         result =3D SCAN_PTE_NON_PRESENT;
> @@ -586,9 +612,7 @@ static enum scan_result __collapse_huge_page_isolate(=
struct vm_area_struct *vma,
>
>                 /* See hpage_collapse_scan_pmd(). */
>                 if (folio_maybe_mapped_shared(folio)) {
> -                       ++shared;
> -                       if (cc->is_khugepaged &&
> -                           shared > khugepaged_max_ptes_shared) {
> +                       if (++shared > max_ptes_shared) {
>                                 result =3D SCAN_EXCEED_SHARED_PTE;
>                                 count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
>                                 goto out;
> @@ -1247,6 +1271,9 @@ static enum scan_result hpage_collapse_scan_pmd(str=
uct mm_struct *mm,
>                 struct vm_area_struct *vma, unsigned long start_addr,
>                 bool *mmap_locked, struct collapse_control *cc)
>  {
> +       const int max_ptes_none =3D collapse_max_ptes_none(cc, vma);
> +       const int max_ptes_swap =3D collapse_max_ptes_swap(cc);
> +       const int max_ptes_shared =3D collapse_max_ptes_shared(cc);
>         pmd_t *pmd;
>         pte_t *pte, *_pte;
>         int none_or_zero =3D 0, shared =3D 0, referenced =3D 0;
> @@ -1280,36 +1307,28 @@ static enum scan_result hpage_collapse_scan_pmd(s=
truct mm_struct *mm,
>
>                 pte_t pteval =3D ptep_get(_pte);
>                 if (pte_none_or_zero(pteval)) {
> -                       ++none_or_zero;
> -                       if (!userfaultfd_armed(vma) &&
> -                           (!cc->is_khugepaged ||
> -                            none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> -                               continue;
> -                       } else {
> +                       if (++none_or_zero > max_ptes_none) {
>                                 result =3D SCAN_EXCEED_NONE_PTE;
>                                 count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>                                 goto out_unmap;
>                         }
> +                       continue;
>                 }
>                 if (!pte_present(pteval)) {
> -                       ++unmapped;
> -                       if (!cc->is_khugepaged ||
> -                           unmapped <=3D khugepaged_max_ptes_swap) {
> -                               /*
> -                                * Always be strict with uffd-wp
> -                                * enabled swap entries.  Please see
> -                                * comment below for pte_uffd_wp().
> -                                */
> -                               if (pte_swp_uffd_wp_any(pteval)) {
> -                                       result =3D SCAN_PTE_UFFD_WP;
> -                                       goto out_unmap;
> -                               }
> -                               continue;
> -                       } else {
> +                       if (++unmapped > max_ptes_swap) {
>                                 result =3D SCAN_EXCEED_SWAP_PTE;
>                                 count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>                                 goto out_unmap;
>                         }
> +                       /*
> +                        * Always be strict with uffd-wp enabled swap ent=
ries.
> +                        * See the comment below for pte_uffd_wp().
> +                        */
> +                       if (pte_swp_uffd_wp_any(pteval)) {
> +                               result =3D SCAN_PTE_UFFD_WP;
> +                               goto out_unmap;
> +                       }
> +                       continue;
>                 }
>                 if (pte_uffd_wp(pteval)) {
>                         /*
> @@ -1348,9 +1367,7 @@ static enum scan_result hpage_collapse_scan_pmd(str=
uct mm_struct *mm,
>                  * is shared.
>                  */
>                 if (folio_maybe_mapped_shared(folio)) {
> -                       ++shared;
> -                       if (cc->is_khugepaged &&
> -                           shared > khugepaged_max_ptes_shared) {
> +                       if (++shared > max_ptes_shared) {
>                                 result =3D SCAN_EXCEED_SHARED_PTE;
>                                 count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
>                                 goto out_unmap;
> @@ -2305,6 +2322,8 @@ static enum scan_result hpage_collapse_scan_file(st=
ruct mm_struct *mm,
>                 unsigned long addr, struct file *file, pgoff_t start,
>                 struct collapse_control *cc)
>  {
> +       const int max_ptes_none =3D collapse_max_ptes_none(cc, NULL);
> +       const int max_ptes_swap =3D collapse_max_ptes_swap(cc);
>         struct folio *folio =3D NULL;
>         struct address_space *mapping =3D file->f_mapping;
>         XA_STATE(xas, &mapping->i_pages, start);
> @@ -2323,8 +2342,7 @@ static enum scan_result hpage_collapse_scan_file(st=
ruct mm_struct *mm,
>
>                 if (xa_is_value(folio)) {
>                         swap +=3D 1 << xas_get_order(&xas);
> -                       if (cc->is_khugepaged &&
> -                           swap > khugepaged_max_ptes_swap) {
> +                       if (swap > max_ptes_swap) {
>                                 result =3D SCAN_EXCEED_SWAP_PTE;
>                                 count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>                                 break;
> @@ -2395,8 +2413,7 @@ static enum scan_result hpage_collapse_scan_file(st=
ruct mm_struct *mm,
>                 cc->progress +=3D HPAGE_PMD_NR;
>
>         if (result =3D=3D SCAN_SUCCEED) {
> -               if (cc->is_khugepaged &&
> -                   present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
> +               if (present < HPAGE_PMD_NR - max_ptes_none) {
>                         result =3D SCAN_EXCEED_NONE_PTE;
>                         count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>                 } else {
> --
> 2.43.0
>
>
> Then extend it by passing an order + return value check in this patch her=
e. You can
> directly squash changes from patch #4 in here then.
>
> --
> Cheers,
>
> David
>

