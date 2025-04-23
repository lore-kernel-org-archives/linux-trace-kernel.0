Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610F1922C4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Apr 2025 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391994; cv=none; b=X77RnxK751rVmzMuOkQFG+LOiiH2YecTwPHnY6nqftJqEml+5ALjDy5EYmz7tAE7z4jsPKCGuGzYCxxnVK3ZxZqyjXBB32nsIi8ro+wVrvtk/wpLLP5jVCKkxvYrPuac0QqetGOLihWZOjDpBgVGw5/0fY3Rxb26dlqOUQ+SNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391994; c=relaxed/simple;
	bh=lLqKv0R0kL0eb+FWIFo3ut3HXEE8IuEBwVZOyXaE33w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB/0WDZRDXYIqdUUOWFnSDYNj0Bwt/ivj7vdEroiHGwqh6mfl+xOLvrduAfT1/iDrGTM+iInt1yczGkIjxgqnC7qmXrDWXteD/W6kH2LCkNZQKfDY3GB3YzaVVlva1J6eB/Cn8qdaXivQ9g0eyGjugnHemBSZZT+pFRdDHDfiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ag9T1pl3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ag9T1pl3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745391991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1JjUTR5AO6/ELifNnwiuDnWLUGlhgp/n6mKbz4s1r8=;
	b=Ag9T1pl3hPRMllsz5j69U/rA8VyGXYKKKFIdGNZMDa9HItggW9lrTq64f/SmOufyuxKhDo
	j5SYmVIyQiL8Q2lD1Gwq7fTaHuxzW71Si5IkStZC3kQGv4chCRnPiGwU3IxHt6Qt6HTc3p
	lpZ07bJQsDkuj9/ltSAoMdZU9FueMQk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-R_2OxPAtO-Swl67RqCMEvQ-1; Wed, 23 Apr 2025 03:06:28 -0400
X-MC-Unique: R_2OxPAtO-Swl67RqCMEvQ-1
X-Mimecast-MFC-AGG-ID: R_2OxPAtO-Swl67RqCMEvQ_1745391988
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e639763e43dso7829615276.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Apr 2025 00:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745391988; x=1745996788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1JjUTR5AO6/ELifNnwiuDnWLUGlhgp/n6mKbz4s1r8=;
        b=TnP2wgdFPBcRQrEqtCvdSty/ugfPTdlRPADlwxkHyVGU3l8jxpc0D1wNanZdHdmBxE
         OTApNN7Pw1cNYzveFTp6TfDpaQAYmLeXldC0iv7FEd+um5VjgpqBSnocc5+j/t0+JMfE
         /QH7g2eDH9lJyY4WaRQ7gI0fEQTCxdI9uz1Rf1S/T9Agv2LzKbAjgxFXD6iy988HNbWb
         5BtXEOwcHt5qaeg7T4ESlOy9oNkY8izSZSZQ8LJcl0beLCGNi14DNzVrWAms0pr/Mpab
         /Rue2ld3kbtxcN4aVh2ois7uYH3zH45qo7NMJaM+f/aFl1pBpBYsB/4XGCPVECORfLPL
         p/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWPwAgmMqtIVlaYl0O1WJ8OHEGW76m4w0xo+eOAt4h7eOH7lUUYZOJc+0nQ2gI4+VYMXXj3OOW/hDzrI3/LZIftS1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YybETbom/aNzfSzEgM4ubMJlptGHd3M+vMGoBRVwm+XI27uXI5s
	+bdkrXjsxS79ZwVvtRkFI6yjOmradecFKtpkZBCU8XQ8iF20TTsr9VxBIZcsHrBOV1TT3ek0zFO
	6+YghdkZ3zMhbAeBOumrq1vJSNytAYRUR4jGnjvkrt3nmvQCQuPDGZ1EYjfhwVtMEWA1RMOQebx
	dxCAkLxHdLOcp9SqnZOcGEGBT26ib2usL+sUK+2wGtD7Lg
X-Gm-Gg: ASbGncvO/aJ+uNV2iCYUeTdAQ8ojHaq6i7sWr3qO9CejTTWBsQmUJEBvTuP6JVmO3A3
	TPzdCx8dZwu2SxKQdNa5HPhkN8vNkv/ogb4uh3X1avdB7pa3BuSFQ9250DFyRXlpelozZlcMxvK
	THWUqI6u4=
X-Received: by 2002:a05:6902:c10:b0:e6d:f41c:6bdb with SMTP id 3f1490d57ef6-e7297d93324mr23626303276.6.1745391988163;
        Wed, 23 Apr 2025 00:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn1zWiBl7mj2ZHMbPzEt4TQGJA7ZA52O1IykfzgHQk9rLrJ75DUXlgd4SeW7i6QSPYXTpfssBeJp5N7K7bY+g=
X-Received: by 2002:a05:6902:c10:b0:e6d:f41c:6bdb with SMTP id
 3f1490d57ef6-e7297d93324mr23626241276.6.1745391987773; Wed, 23 Apr 2025
 00:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417000238.74567-1-npache@redhat.com> <20250417000238.74567-2-npache@redhat.com>
 <a881ed65-351a-469f-b625-a3066d0f1d5c@linux.alibaba.com>
In-Reply-To: <a881ed65-351a-469f-b625-a3066d0f1d5c@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 23 Apr 2025 01:06:01 -0600
X-Gm-Features: ATxdqUHpjU8S0MShRUQwhPVFS5hZ7SZaiRUxbW-9PYZFjeXZxNqacPcUS1Nsk1c
Message-ID: <CAA1CXcC+QrDJ0XkjX5MqwRGgHh6Q1jXSmBqLgaOnz_FZY6dQLg@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] introduce khugepaged_collapse_single_pmd to
 unify khugepaged and madvise_collapse
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
X-Mimecast-MFC-PROC-ID: JutKwxS5K-m9jz2btxhuSDs514sFolQg0xNYYSd9vok_1745391988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 12:44=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/4/17 08:02, Nico Pache wrote:
> > The khugepaged daemon and madvise_collapse have two different
> > implementations that do almost the same thing.
> >
> > Create khugepaged_collapse_single_pmd to increase code
> > reuse and create an entry point for future khugepaged changes.
> >
> > Refactor madvise_collapse and khugepaged_scan_mm_slot to use
> > the new khugepaged_collapse_single_pmd function.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> Can you add a prefix 'khugepaged:' for the subject line?
I had that originally but the subject line is already extremely long.
>
> > ---
> >   mm/khugepaged.c | 92 ++++++++++++++++++++++++------------------------=
-
> >   1 file changed, 46 insertions(+), 46 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b8838ba8207a..cecadc4239e7 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2363,6 +2363,48 @@ static int hpage_collapse_scan_file(struct mm_st=
ruct *mm, unsigned long addr,
> >   }
> >   #endif
> >
> > +/*
> > + * Try to collapse a single PMD starting at a PMD aligned addr, and re=
turn
> > + * the results.
> > + */
> > +static int khugepaged_collapse_single_pmd(unsigned long addr,
> > +                                struct vm_area_struct *vma, bool *mmap=
_locked,
> > +                                struct collapse_control *cc)
> > +{
> > +     int result =3D SCAN_FAIL;
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> > +
> > +     if (thp_vma_allowable_order(vma, vma->vm_flags,
> > +                                     tva_flags, PMD_ORDER)) {
>
> We've already checked the thp_vma_allowable_order() before calling this
> function, why check again?
>
> > +             if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
> > +                     struct file *file =3D get_file(vma->vm_file);
> > +                     pgoff_t pgoff =3D linear_page_index(vma, addr);
> > +
> > +                     mmap_read_unlock(mm);
> > +                     *mmap_locked =3D false;
> > +                     result =3D hpage_collapse_scan_file(mm, addr, fil=
e, pgoff,
> > +                                                       cc);
> > +                     fput(file);
> > +                     if (result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> > +                             mmap_read_lock(mm);
> > +                             if (hpage_collapse_test_exit_or_disable(m=
m))
> > +                                     goto end;
> > +                             result =3D collapse_pte_mapped_thp(mm, ad=
dr,
> > +                                                              !cc->is_=
khugepaged);
>
> why drop the following check?
> if (*result =3D=3D SCAN_PMD_MAPPED)
>         *result =3D SCAN_SUCCEED;

Good catch! When generalizing this for madvise_collapse i forgot to
properly handle the khugepaged case of PMD_MAPPED=3D=3DSUCCEED.
>
> > +                             mmap_read_unlock(mm);
> > +                     }
> > +             } else {
> > +                     result =3D hpage_collapse_scan_pmd(mm, vma, addr,
> > +                                                      mmap_locked, cc)=
;
> > +             }
> > +             if (cc->is_khugepaged && result =3D=3D SCAN_SUCCEED)
> > +                     ++khugepaged_pages_collapsed;
> > +     }
> > +end:
> > +     return result;
> > +}
> > +
> >   static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *=
result,
> >                                           struct collapse_control *cc)
> >       __releases(&khugepaged_mm_lock)
> > @@ -2437,33 +2479,9 @@ static unsigned int khugepaged_scan_mm_slot(unsi=
gned int pages, int *result,
> >                       VM_BUG_ON(khugepaged_scan.address < hstart ||
> >                                 khugepaged_scan.address + HPAGE_PMD_SIZ=
E >
> >                                 hend);
> > -                     if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous=
(vma)) {
> > -                             struct file *file =3D get_file(vma->vm_fi=
le);
> > -                             pgoff_t pgoff =3D linear_page_index(vma,
> > -                                             khugepaged_scan.address);
> >
> > -                             mmap_read_unlock(mm);
> > -                             mmap_locked =3D false;
> > -                             *result =3D hpage_collapse_scan_file(mm,
> > -                                     khugepaged_scan.address, file, pg=
off, cc);
> > -                             fput(file);
> > -                             if (*result =3D=3D SCAN_PTE_MAPPED_HUGEPA=
GE) {
> > -                                     mmap_read_lock(mm);
> > -                                     if (hpage_collapse_test_exit_or_d=
isable(mm))
> > -                                             goto breakouterloop;
> > -                                     *result =3D collapse_pte_mapped_t=
hp(mm,
> > -                                             khugepaged_scan.address, =
false);
> > -                                     if (*result =3D=3D SCAN_PMD_MAPPE=
D)
> > -                                             *result =3D SCAN_SUCCEED;
> > -                                     mmap_read_unlock(mm);
> > -                             }
> > -                     } else {
> > -                             *result =3D hpage_collapse_scan_pmd(mm, v=
ma,
> > -                                     khugepaged_scan.address, &mmap_lo=
cked, cc);
> > -                     }
> > -
> > -                     if (*result =3D=3D SCAN_SUCCEED)
> > -                             ++khugepaged_pages_collapsed;
> > +                     *result =3D khugepaged_collapse_single_pmd(khugep=
aged_scan.address,
> > +                                             vma, &mmap_locked, cc);
>
> If the khugepaged_collapse_single_pmd() returns a failure caused by
> hpage_collapse_test_exit_or_disable(), we should break out of the loop
> according to the original logic. But you've changed the action in this
> patch, is this intentional?

Nope, not intentional! Thanks for pointing that out. I'll get that fixed!

Thanks for the in depth review ! I'll work on cleaning up these corner case=
s.
>
> >
> >                       /* move to next address */
> >                       khugepaged_scan.address +=3D HPAGE_PMD_SIZE;
> > @@ -2783,36 +2801,18 @@ int madvise_collapse(struct vm_area_struct *vma=
, struct vm_area_struct **prev,
> >               mmap_assert_locked(mm);
> >               memset(cc->node_load, 0, sizeof(cc->node_load));
> >               nodes_clear(cc->alloc_nmask);
> > -             if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
> > -                     struct file *file =3D get_file(vma->vm_file);
> > -                     pgoff_t pgoff =3D linear_page_index(vma, addr);
> >
> > -                     mmap_read_unlock(mm);
> > -                     mmap_locked =3D false;
> > -                     result =3D hpage_collapse_scan_file(mm, addr, fil=
e, pgoff,
> > -                                                       cc);
> > -                     fput(file);
> > -             } else {
> > -                     result =3D hpage_collapse_scan_pmd(mm, vma, addr,
> > -                                                      &mmap_locked, cc=
);
> > -             }
> > +             result =3D khugepaged_collapse_single_pmd(addr, vma, &mma=
p_locked, cc);
> > +
> >               if (!mmap_locked)
> >                       *prev =3D NULL;  /* Tell caller we dropped mmap_l=
ock */
> >
> > -handle_result:
> >               switch (result) {
> >               case SCAN_SUCCEED:
> >               case SCAN_PMD_MAPPED:
> >                       ++thps;
> >                       break;
> >               case SCAN_PTE_MAPPED_HUGEPAGE:
> > -                     BUG_ON(mmap_locked);
> > -                     BUG_ON(*prev);
> > -                     mmap_read_lock(mm);
> > -                     result =3D collapse_pte_mapped_thp(mm, addr, true=
);
> > -                     mmap_read_unlock(mm);
> > -                     goto handle_result;
> > -             /* Whitelisted set of results where continuing OK */
> >               case SCAN_PMD_NULL:
> >               case SCAN_PTE_NON_PRESENT:
> >               case SCAN_PTE_UFFD_WP:
>

