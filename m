Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969522B5A3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822204; cv=none; b=Wx76ojL/2u1HT6d8HhLHkdrUOYjfqtDw4rP/x0OgA1/i3ZAMMzELtMXHZPxDDO37XEB2ZuokcvKh/WI0Nt0QmbnfFsPmC4xApk7iBKmxIlEWfNYm8+O+/cpZMkTPKTXpgHTRv+6tQ/pAwVi6r48JJVASDFzZqB2LVSvci2SqqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822204; c=relaxed/simple;
	bh=45zvzCpuZdiOQMH+CSHIRZqZFl4bhX5N9y5i5DgP08s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agkH5YZm0KFagM9c1S5OT6UFPKFxCmu7ca9n7XL/UWiPnEMAdhd/7XYcOhyDknvo3orwDk0sUi092EwLHmPM4XEf59NZU0j/SpGFloejGNAMyhQxmoZ/fwEtWObyuscvE8y2kt95dv3IBhS4+wVp7uZliyfmbP41oWKHgLnlIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8N+1ZwZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8N+1ZwZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739822201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqCdFAjIMlG+m7JvnwnT/7LZs5YuDBGEp7uqaQeK9Xw=;
	b=M8N+1ZwZH7fFRUhrYWNVkK28XX5Yz8vFbSpGy2VCQAhE00cMaI+cHNzj7sZCl0cQO8Y/Pm
	bzhougegFeR2uPO4UD6SDK8ZlyeDPMOp57PNUcTfCfcqhsAdKFU1XVPUNPbEp3+bSEuLN0
	m2uFmux79wmXLuxD43IsvA3PpK6nBKY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-zLfQEKKXMjy39Mzpq1MTOg-1; Mon, 17 Feb 2025 14:56:38 -0500
X-MC-Unique: zLfQEKKXMjy39Mzpq1MTOg-1
X-Mimecast-MFC-AGG-ID: zLfQEKKXMjy39Mzpq1MTOg_1739822198
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e5dca677776so3115212276.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739822198; x=1740426998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqCdFAjIMlG+m7JvnwnT/7LZs5YuDBGEp7uqaQeK9Xw=;
        b=Y2yIJOItr+o6MZO3mKBlXC5rnTAgyd2MUoF9y0J7Pd3iGV1bLGWUKRPtzNGSI0oZAf
         LmcxGgBNRW43TAFk6UBh1QcBv87kWsr4LF0vxRk628I8xaowC4R70cXqu3udkwYOZDZH
         3HlKX6bTyz0ZrZYO/sfltMaLnH90tZprHrAr+Hq2jouSZwhwu9p0Z3n3mYQerqBFHUAN
         Kp4Orl0/bP4jSGocEMJzxaGcWqFuFvcUY0MzBnmD5RUnmvnIwBU8fEYGx6GGPFoQwJiL
         lh9NxqA1dr2ruDb4hwwCqfIVCmkl2kUjutOjutSllgSwcwSkd6mscNY4YkC0j3WViJDe
         UNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKxF2tdsDc+ju42ZFp8sXVHrWWgRMjr0MtRN14nmGf5VCYqBK6VkR7J3PdkWUq02XzfC1+7oGl1SFt1Zz4UyHui0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9GSyLQpzGR6hUoGQIivia1j3OyjdKNOj5cJj3Q00sG22AKLy
	ylTWG+s5NwdjQeskaQXhMdC8MgrRtIiNlQn//5vFoL+40wzLW6ijFaGN1R8BUZVdMrM/UaxwnrD
	uyc1LGEgSrEftnbeDu0rEKSd6LwR/502yzNFSYpkBPmWjeye6S5ZDOVS0nQS6X/6JqrIbL+zesu
	ZfkZFyMGPxncBNWOPnePbIDZeGcUOMWCXzL/omyYzvrT3O
X-Gm-Gg: ASbGncv88qviPqIQ+U9gMvOFEAeGq1tZkLFxE0PSxaxrY0h7B4PaZerxzwRGhPpMyPE
	BP9vClscljOMhcg3hkPReCGnAEHraMHq5HOtv/yx5JDBcTFIervbk1WvV9jMb6j66/Tut9WDt+b
	A=
X-Received: by 2002:a05:6902:10c9:b0:e5b:3f2b:28cc with SMTP id 3f1490d57ef6-e5dc9082c71mr10387590276.23.1739822197785;
        Mon, 17 Feb 2025 11:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0c+uqtnHXYo8YxqqHqGfRhytcD8J945ccQNdE/lv0NN9KVif1/J+AAv9kWkW4QXSEJUvh87oMtKMsTN20X9Q=
X-Received: by 2002:a05:6902:10c9:b0:e5b:3f2b:28cc with SMTP id
 3f1490d57ef6-e5dc9082c71mr10387573276.23.1739822197433; Mon, 17 Feb 2025
 11:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-2-npache@redhat.com>
 <79c80db7-5786-4bb5-9d5d-fa76882116e8@gmail.com>
In-Reply-To: <79c80db7-5786-4bb5-9d5d-fa76882116e8@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 12:56:11 -0700
X-Gm-Features: AWEUYZk_MdQF26SDqyZdTE3j8L5mxZs6sCr0DlDyq0R_tw1lka-hNvuiPKWnvAU
Message-ID: <CAA1CXcAD0g250r6Dda4XpSDrUVR7g2gXXmFm6-WwtqKdfNXNNA@mail.gmail.com>
Subject: Re: [RFC v2 1/9] introduce khugepaged_collapse_single_pmd to unify
 khugepaged and madvise_collapse
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
X-Mimecast-MFC-PROC-ID: j04QF9Hzh6WGodxmTX_p8C1fpNy8ng6lvBJ9PTZl834_1739822198
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 10:11=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
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
> > +{
> > +     int result =3D SCAN_FAIL;
> > +     unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> > +
> > +     if (!*mmap_locked) {
> > +             mmap_read_lock(mm);
> > +             *mmap_locked =3D true;
> > +     }
> > +
> > +     if (thp_vma_allowable_order(vma, vma->vm_flags,
> > +                                     tva_flags, PMD_ORDER)) {
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
>
> you will be incrementing khugepaged_pages_collapsed at madvise_collapse b=
y calling
> khugepaged_collapse_single_pmd which is not correct.

Ah good catch, Ill add a conditional around the incrementation. Thanks!

>
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

