Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8628629B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917522; cv=none; b=nN4bOtwCbaOrW0w+5KD24VVMy9gKQDUXIj/fJIwxoOYzQfftc0inva2JmR0iMSmbGQ04uey4Ocxl5BWAV/qBpHZyTukztdw+QPAlIGVyx4tKwzdHlFv+QhjzRrIubBw7XWmyox4J5r4ezoynI2BRNrhn0l9PMGKkzssMhJLlE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917522; c=relaxed/simple;
	bh=LLa1n0vgA60rft65PihFMpatdgjjR47ZYkSWGWjpsF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkUAbdeuNkXpYvGy5vGeBYHDisEz70Ne3APnCfrWSc+y6RPTKBAc1ZNM3Kfn5KwKQ/1LdCCy9mc5M87l4pt1sR8CXovVhy0r7nEjsUgcTjcuyCalTCdCkLmTk7qGDA6YKIeihN5QShQ5uVkxlSfHxnMFKCunfiXlL7/v+ZAGHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DA7rJ7Ul; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA7rJ7Ul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739917518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uolaZicYHg5+y+Pz9RgAB2e8l9DfMJppe4IWrGSl24I=;
	b=DA7rJ7UlCNjcCNEYYmduwl9+ObyCJzLy1L+IU7lS00aamJQS7o75oD2PbiyBQqwQx0QY32
	gwROuGTsrTg1uE8LJrDxMvn4soGGvRmqJiZ3cckQuqEpEYltDBVf9LJeMbv9lm7t48QjsN
	KXyvrVv3+LAqwpZLj1EsPgAfh4pKrnM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-piV-P_MNMVGiGQZkPpel3g-1; Tue, 18 Feb 2025 17:25:16 -0500
X-MC-Unique: piV-P_MNMVGiGQZkPpel3g-1
X-Mimecast-MFC-AGG-ID: piV-P_MNMVGiGQZkPpel3g_1739917516
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6fb469853ffso45525807b3.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739917516; x=1740522316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uolaZicYHg5+y+Pz9RgAB2e8l9DfMJppe4IWrGSl24I=;
        b=VHw29BLRDWqLU7bKSDfLHG3X9a7FEumfxHOkVKyLx9cmwt07B7Qfgr5Fje0iwv95Vz
         YdlwPsCShZz3EeK9pYuCgK2fbGzCp/zpIRVtxxrD8V9iFDfsLXUQEq5AYIAugTa6fZ+T
         bl3beDDHdBeJJRzTzS1Ts3+zZzts+j6Brlhjs3gl/jLAlrEORGU/A15ejzz3mA9KyxuW
         Rs3Uf8O+9NB15cOJnkA4pmMEKSZw0CKZDbxgS8VdsYaT/y93/7WfVYKBWBvX5BOBzD44
         UZTNu3vLZu1PLnI7Q9Zq4MSWwGF3R7RcgFVWH/BjsuAYStgx9UAjk83IKT+Vag87xuGn
         yjwg==
X-Forwarded-Encrypted: i=1; AJvYcCU4waAHfL5dJH3b1LWdyxHc/mmqnRKUfR6YidRj+PSSNYNTzzkjr2IWmx+U6cBui07XIrEkZldJ7rEgnSVBV7H17Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9+aim5Bi+OaFvxvTLLnmCvhkPG1HKR4uuP0DsSw/TuBVEXcW
	hTTUhOjZUpdYTrTwVFAiCVsxBL8CXoebjbqE5pZA6tw4sLTr7SjKbGg7n5ZYhOO8i6iR84xH77z
	OUIR2SbcPFS1NuieRe8TMojgEYK2wjzmanhgTKy3h6n3qsJQAAPg36q6URMgCwezFHUV5EydA6o
	hGw2Rz3HMVc7RIfaL0DVYEP+dE/F/Wg/9fPGPyPrUc1e2k
X-Gm-Gg: ASbGncvZINKfSLn/TDl0xmZTqrMEahXixkcM0ukBFVtOI8eYPqy/E+4htpYcD4c5Knt
	y6zGbFiLRsh3gxdSx+fEaG4E8DJlYp90DmjQWPZp80I74wJ+DHufFufqahI9cuyE+gk+U+D7r+d
	g=
X-Received: by 2002:a05:6902:a06:b0:e5d:cb35:59ad with SMTP id 3f1490d57ef6-e5e0a130d82mr1456791276.31.1739917515895;
        Tue, 18 Feb 2025 14:25:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbLdIDA7W8b7S7Vw5wFLoiCrmHVgVEE4AdNMwuOX5Ui1GwIyfL4fakzqmMyQ3bo2Fzq3h+smXl4DCCzGL6h+Q=
X-Received: by 2002:a05:6902:a06:b0:e5d:cb35:59ad with SMTP id
 3f1490d57ef6-e5e0a130d82mr1456780276.31.1739917515590; Tue, 18 Feb 2025
 14:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-2-npache@redhat.com>
 <8d1fed22-5ba8-433b-9ef9-478b337b10d5@arm.com>
In-Reply-To: <8d1fed22-5ba8-433b-9ef9-478b337b10d5@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 18 Feb 2025 15:24:49 -0700
X-Gm-Features: AWEUYZncCSKg8r54HWOU0tx_q-3fZrZtewemdqSCm6AyoWEay7IYmb-RET1BGEU
Message-ID: <CAA1CXcA1btm3ddHzKfrCZcce8=ekVKfbo84=4SegabQSgqoeWw@mail.gmail.com>
Subject: Re: [RFC v2 1/9] introduce khugepaged_collapse_single_pmd to unify
 khugepaged and madvise_collapse
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, usamaarif642@gmail.com, audra@redhat.com, 
	akpm@linux-foundation.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, tiwai@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XfrGscfpAwUE1ZCTj6sMxaNbe9CNbMPkJLrHdXXC4dI_1739917516
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 9:26=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/02/2025 00:30, Nico Pache wrote:
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
> > ---
> >  mm/khugepaged.c | 96 +++++++++++++++++++++++++------------------------
> >  1 file changed, 50 insertions(+), 46 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5f0be134141e..46faee67378b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2365,6 +2365,52 @@ static int hpage_collapse_scan_file(struct mm_st=
ruct *mm, unsigned long addr,
> >  }
> >  #endif
> >
> > +/*
> > + * Try to collapse a single PMD starting at a PMD aligned addr, and re=
turn
> > + * the results.
> > + */
> > +static int khugepaged_collapse_single_pmd(unsigned long addr, struct m=
m_struct *mm,
> > +                                struct vm_area_struct *vma, bool *mmap=
_locked,
> > +                                struct collapse_control *cc)
>
> nit: given the vma links to the mm is it really neccessary to pass both? =
Why not
> just pass vma?
Ah good point!
>
> > +{
> > +     int result =3D SCAN_FAIL;
> > +     unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> > +
> > +     if (!*mmap_locked) {
> > +             mmap_read_lock(mm);
> > +             *mmap_locked =3D true;
> > +     }
>
> AFAICT, the read lock is always held when khugepaged_collapse_single_pmd(=
) is
> called. Perhaps VM_WARN_ON(!*mmap_locked) would be more appropriate?

Hmm, I'm actually not sure why that's there. Its probably left over
from a previous change I was trying a while back.

>
> > +
> > +     if (thp_vma_allowable_order(vma, vma->vm_flags,
> > +                                     tva_flags, PMD_ORDER)) {
> > +             if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
>
> I guess it was like this before, but what's the relevance of CONFIG_SHMEM=
?
> Surely this should work for any file if CONFIG_READ_ONLY_THP_FOR_FS is en=
abled?

Yeah I think David brought up a similar point during one of our
meetings. I'm just combining the collapse users, so I'll leave it for
now.

>
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
> > +                             mmap_read_unlock(mm);
> > +                     }
> > +             } else {
> > +                     result =3D hpage_collapse_scan_pmd(mm, vma, addr,
> > +                                                      mmap_locked, cc)=
;
> > +             }
> > +             if (result =3D=3D SCAN_SUCCEED || result =3D=3D SCAN_PMD_=
MAPPED)
> > +                     ++khugepaged_pages_collapsed;
>
> Looks like this counter was previously only incremented for the scan path=
, not
> for the madvise_collapse path. Not sure if that's a problem?

Yep! Usama noted that too, already fixed in the next version :)

Thanks!
-- Nico

>
> Thanks,
> Ryan
>
> > +     }
> > +end:
> > +     return result;
> > +}
> > +
> >  static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *r=
esult,
> >                                           struct collapse_control *cc)
> >       __releases(&khugepaged_mm_lock)
> > @@ -2439,33 +2485,9 @@ static unsigned int khugepaged_scan_mm_slot(unsi=
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
> > +                                             mm, vma, &mmap_locked, cc=
);
> >
> >                       /* move to next address */
> >                       khugepaged_scan.address +=3D HPAGE_PMD_SIZE;
> > @@ -2785,36 +2807,18 @@ int madvise_collapse(struct vm_area_struct *vma=
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
> > +             result =3D khugepaged_collapse_single_pmd(addr, mm, vma, =
&mmap_locked, cc);
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

