Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F921E08B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737023; cv=none; b=UWBFYhHap4p7jQKJ22eUnN1YbbQNqtJBRYx70XTIEk8iOK61WDTrKfxuVz8G5wg1QthjV0qNOSbq5FAZvvTU37asR5IUA5J5hqJOex08bX+qnxxwdT3Zs+arqk3qVMfpn6jRMNMk6CKM6sd7MY1jTUw1Ka3It/GiaGqc8oWN3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737023; c=relaxed/simple;
	bh=izJ7p1OU0lCyCKa4cgyAx8Vf4UaU956Ivc4z6abcz2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdifJejy1EW8HI73r5RQWn2XeSjsRdkXVSmpamX0pIJE255j6CgF4ZDxuVwYLl5gqZd+SIW0eTlDuoEZtxY0lIRjDXUlxje59EgIPjN+tszxxhkBa+96dPFZjrNziBdB5K+YJgf5b3Gpi0nqRDgtONSTWtHFc4lkYCPa5ucMd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkAZihGx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkAZihGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xka/ZuoT5H83UsFhmNwZ/doTSozyLFCxoHnEvCahLTQ=;
	b=TkAZihGxMNPFvkhynSbnz0oymNpx4EJMvEOofcaU9/j/cq6yj5/n6oscG8ShmEPrYcJs2O
	5z0WIV7i2AZ+ETXxvRbwBFH6xTgfVG/ZXa7yKSMchctmpTv4BEsym8Jmgh26vAIzp2Dr06
	6JPary6fPKMEZ6RssnyTD0RQ+1fE67Y=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-e-ze0rj-OqCiFAaqEGcfmg-1; Thu, 17 Jul 2025 03:23:40 -0400
X-MC-Unique: e-ze0rj-OqCiFAaqEGcfmg-1
X-Mimecast-MFC-AGG-ID: e-ze0rj-OqCiFAaqEGcfmg_1752737020
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7116680e13dso8560767b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737020; x=1753341820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xka/ZuoT5H83UsFhmNwZ/doTSozyLFCxoHnEvCahLTQ=;
        b=m7EppB8yWZaeraKFXzLU3N5GVEk+jIdtM+wm/rRyoH7Wm7ZiGO3OcGUBlKAMfVCtVn
         /29P4crx8IwrTcIRbiNjE0ryhdQXpUGX/FbWWxKnKfllIYOQQL7hHxSX9iSh7nKWh0fJ
         SA0/+b3Nb2/5WLe1Us4TrTnad6eo9uTRwJn+RfMI/4cTVcbM9xTfF/zlTO+jubaOEnsn
         u33K/IjsEJQ5O6LRzkiiahF0vCA8du+MR8JcwKF9ZpGPu8CCEgqhotl3IKPTFydtb0JE
         Z6jZiUI8zJRAWLL2iOoLEhHl87Ckt9DA98uCLB1Rx7TJFvKIW0i2662jvwDYHx8N6YHx
         rt6A==
X-Forwarded-Encrypted: i=1; AJvYcCULpT0sx4wo4FreTkplWZkjS2IxF/5Xe9i+znxixn8GYUTuE7l4gNjXJlzGdTWwofO2kVWYBXMQyv/W8XI5LOHOj0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNbcmeg3yLBDuu44CDNt9js8zCCpywGSJnBdkyf63xhke5ZBi
	szJyMASnqu9pBu/YSil4OKhzQh8PYax0LZ8KxuubbD1KI68+RLjJB1iU+d7lDn9Rzt6NHhGjvmZ
	Q+RjgAQMRefHrDoMM15gmsbX5Mwe0dtt5MUQzUoclZshG8ADTlbYYNojIWphkizZwTUrBjKGBkA
	P8z4Do7yjRP3abYuYJ1lx4/N0i3PTYrRAPPN3h0N3DXpuE77fp
X-Gm-Gg: ASbGncstP1h/7K4ZF1plRNTMBzZdwUiOvEpAYd+vtyQJ80UaJ/v6kLDeQDG2LqBKnv1
	A4FZhYDbAmXxMYIzfp/hBm2+5rOJvaasjwcEg0QHNj6nnleDknYRznpXtdJgiA2AWtTJOZ0gg9P
	ETWJkUQFfCAU3ncLiJFbAAeoM=
X-Received: by 2002:a05:690c:1c:b0:714:13:357a with SMTP id 00721157ae682-7183733e754mr75568837b3.20.1752737019389;
        Thu, 17 Jul 2025 00:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG062fQmQMTtzQaORYO8BQfLpIhFpvKSjhTVlHbWcaYDeY88CgnYk46dQY+VDz9L5BhRQfpAlIpXIV3Coe2VM0=
X-Received: by 2002:a05:690c:1c:b0:714:13:357a with SMTP id
 00721157ae682-7183733e754mr75568367b3.20.1752737018858; Thu, 17 Jul 2025
 00:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-6-npache@redhat.com>
 <5ff595db-3720-4ce3-8d92-5f08d0625c75@redhat.com>
In-Reply-To: <5ff595db-3720-4ce3-8d92-5f08d0625c75@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:23:12 -0600
X-Gm-Features: Ac12FXxSdZgIpFjqwS2OfbfxZpFjuP_7yWTzmxJmAa7_DtUsx7oTR3r9FbXes2k
Message-ID: <CAA1CXcBsCagKHJndYTKr=NyNCDxvJ=wf_wo0AubFoUe=r+Rdyw@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] khugepaged: generalize __collapse_huge_page_*
 for mTHP support
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d0QOsiBwjkhDEcOwRdTAMVsvfVTFqlldtArxHhEHwos_1752737020
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 8:03=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.07.25 02:31, Nico Pache wrote:
> > generalize the order of the __collapse_huge_page_* functions
> > to support future mTHP collapse.
> >
> > mTHP collapse can suffer from incosistant behavior, and memory waste
> > "creep". disable swapin and shared support for mTHP collapse.
> >
> > No functional changes in this patch.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 49 +++++++++++++++++++++++++++++++-----------------=
-
> >   1 file changed, 31 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index cc9a35185604..ee54e3c1db4e 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -552,15 +552,17 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
> >                                       unsigned long address,
> >                                       pte_t *pte,
> >                                       struct collapse_control *cc,
> > -                                     struct list_head *compound_pageli=
st)
> > +                                     struct list_head *compound_pageli=
st,
> > +                                     u8 order)
> >   {
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> >       bool writable =3D false;
> > +     int scaled_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER =
- order);
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> > +     for (_pte =3D pte; _pte < pte + (1 << order);
> >            _pte++, address +=3D PAGE_SIZE) {
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (pte_none(pteval) || (pte_present(pteval) &&
> > @@ -568,7 +570,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >                       ++none_or_zero;
> >                       if (!userfaultfd_armed(vma) &&
> >                           (!cc->is_khugepaged ||
> > -                          none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> > +                          none_or_zero <=3D scaled_none)) {
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -596,8 +598,8 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >               /* See hpage_collapse_scan_pmd(). */
> >               if (folio_maybe_mapped_shared(folio)) {
> >                       ++shared;
> > -                     if (cc->is_khugepaged &&
> > -                         shared > khugepaged_max_ptes_shared) {
> > +                     if (order !=3D HPAGE_PMD_ORDER || (cc->is_khugepa=
ged &&
> > +                         shared > khugepaged_max_ptes_shared)) {
> >                               result =3D SCAN_EXCEED_SHARED_PTE;
> >                               count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> >                               goto out;
> > @@ -698,13 +700,14 @@ static void __collapse_huge_page_copy_succeeded(p=
te_t *pte,
> >                                               struct vm_area_struct *vm=
a,
> >                                               unsigned long address,
> >                                               spinlock_t *ptl,
> > -                                             struct list_head *compoun=
d_pagelist)
> > +                                             struct list_head *compoun=
d_pagelist,
> > +                                             u8 order)
> >   {
> >       struct folio *src, *tmp;
> >       pte_t *_pte;
> >       pte_t pteval;
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> > +     for (_pte =3D pte; _pte < pte + (1 << order);
> >            _pte++, address +=3D PAGE_SIZE) {
> >               pteval =3D ptep_get(_pte);
> >               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > @@ -751,7 +754,8 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >                                            pmd_t *pmd,
> >                                            pmd_t orig_pmd,
> >                                            struct vm_area_struct *vma,
> > -                                          struct list_head *compound_p=
agelist)
> > +                                          struct list_head *compound_p=
agelist,
> > +                                          u8 order)
> >   {
> >       spinlock_t *pmd_ptl;
> >
> > @@ -768,7 +772,7 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >        * Release both raw and compound pages isolated
> >        * in __collapse_huge_page_isolate.
> >        */
> > -     release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> > +     release_pte_pages(pte, pte + (1 << order), compound_pagelist);
> >   }
> >
> >   /*
> > @@ -789,7 +793,7 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >   static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
> >               pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> >               unsigned long address, spinlock_t *ptl,
> > -             struct list_head *compound_pagelist)
> > +             struct list_head *compound_pagelist, u8 order)
> >   {
> >       unsigned int i;
> >       int result =3D SCAN_SUCCEED;
> > @@ -797,7 +801,7 @@ static int __collapse_huge_page_copy(pte_t *pte, st=
ruct folio *folio,
> >       /*
> >        * Copying pages' contents is subject to memory poison at any ite=
ration.
> >        */
> > -     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +     for (i =3D 0; i < (1 << order); i++) {
> >               pte_t pteval =3D ptep_get(pte + i);
> >               struct page *page =3D folio_page(folio, i);
> >               unsigned long src_addr =3D address + i * PAGE_SIZE;
> > @@ -816,10 +820,10 @@ static int __collapse_huge_page_copy(pte_t *pte, =
struct folio *folio,
> >
> >       if (likely(result =3D=3D SCAN_SUCCEED))
> >               __collapse_huge_page_copy_succeeded(pte, vma, address, pt=
l,
> > -                                                 compound_pagelist);
> > +                                                 compound_pagelist, or=
der);
> >       else
> >               __collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> > -                                              compound_pagelist);
> > +                                              compound_pagelist, order=
);
> >
> >       return result;
> >   }
> > @@ -994,11 +998,11 @@ static int check_pmd_still_valid(struct mm_struct=
 *mm,
> >   static int __collapse_huge_page_swapin(struct mm_struct *mm,
> >                                      struct vm_area_struct *vma,
> >                                      unsigned long haddr, pmd_t *pmd,
> > -                                    int referenced)
> > +                                    int referenced, u8 order)
> >   {
> >       int swapped_in =3D 0;
> >       vm_fault_t ret =3D 0;
> > -     unsigned long address, end =3D haddr + (HPAGE_PMD_NR * PAGE_SIZE)=
;
> > +     unsigned long address, end =3D haddr + (PAGE_SIZE << order);
> >       int result;
> >       pte_t *pte =3D NULL;
> >       spinlock_t *ptl;
> > @@ -1029,6 +1033,15 @@ static int __collapse_huge_page_swapin(struct mm=
_struct *mm,
> >               if (!is_swap_pte(vmf.orig_pte))
> >                       continue;
> >
> > +             /* Dont swapin for mTHP collapse */
> > +             if (order !=3D HPAGE_PMD_ORDER) {
> > +                     count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_=
SWAP);
>
> Doesn't compile. This is introduced way later in this series.
Whoops I stupidly applied this fixup to the wrong commit.
>
> Using something like
>
> git rebase -i mm/mm-unstable --exec "make -j16"
Ah I remember you showing me this in the past! Need to start using it
more-- Thank you.

>
> You can efficiently make sure that individual patches compile cleanly.
>
> --
> Cheers,
>
> David / dhildenb
>

