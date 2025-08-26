Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4471DAC95
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215065; cv=none; b=BHxjMSnPmVNrkbkIZe5Wk2ht2RKLkt9o8Q97v+E2SjjOzvxc6wPZmu0/qVVbSzb8kBEHwEeSSXiFf851pBtBxSc2gImVlojKZJ/sWXfyxXTSdqIKwjECV+v5xuk17Tbl7Z3H/7aSL6Zv7HKAGrYjPKUGs0RlSfUb9GSmD1MVkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215065; c=relaxed/simple;
	bh=Wz81753XfR8VU3zTn+IaPzh3mKWD4ka6j/OUnf+0vNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNcXz65LtYpVcXT+N6gbKwCnaDWCY5k7lRUd2N4FIEtGTUz7PsJCrP0qcFrfwd668JGF9S/V98+BvhDDSeZKtr4pD4h7zWHjOBH2Nx6vOmAbu31GeIi1Yx7MxFLjbTntoaIn/E+5EgvsQEs2YFCSHKWPL6uJKtzh3AJ9Op+Fkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoXcWM7c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoXcWM7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756215062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThzqNbFT5eEjjDVJ/O46CUDGi3VRQ7VcMo2GH+SRmsI=;
	b=FoXcWM7cERQqovtgciztMTUzc+ZmiRx8EF98UUnTnhq+0dxCI/iF2CiydSK+h6gbHo3zGI
	3DbLSkmvgZvb2D6IqLmSxhLS0T2DKnzd7aw77cizZiWjQFkr614rx/gUB4/6G6Wq5cqBl2
	x7zY6OFit+BlANj85nVfcfMi8ythGgg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-TKs_LT0EM7maJShHcAIiPQ-1; Tue, 26 Aug 2025 09:31:01 -0400
X-MC-Unique: TKs_LT0EM7maJShHcAIiPQ-1
X-Mimecast-MFC-AGG-ID: TKs_LT0EM7maJShHcAIiPQ_1756215061
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e951ec54a4dso5505287276.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215060; x=1756819860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThzqNbFT5eEjjDVJ/O46CUDGi3VRQ7VcMo2GH+SRmsI=;
        b=tukuVk6WGJfgMeP0GV2oiWRvJTUXU7fjGpduFwZJcVQSYpIf40EsMVhsX752aaHYD1
         p46fBZb1TJIGlmZ+Nor6sByELDm/tk/rtR1tvo8CzMKvqC1xbL86eVdsPYcFfb+9s5WT
         1BLyvsSKJgDvWxTBxHqwJIBjFuyd0FZB5ICMgo+z75D5fCfghdDr7rQnUu7VRzUk268X
         pPV1yzL7seAsFxwUeWgRpUOrvGU+U5PQTdA97RjFMSuzmbUqFkCEOlWkQJ+4j4oyfTm5
         DqhPHyeMS/EO+mUIY7bj0PbPinNISUjmKi/igCcCNVV9Y0m9QLVuv0CYuxyotwUPXhIU
         fYkA==
X-Forwarded-Encrypted: i=1; AJvYcCVXN9uUyq3F83hqd9WNY1zNw8pCmK+llKUYwr/Xf9cowTP/1ALjah7Vr970Qhj1Ns20B36SDgoi7Ve1e3M9QuTKqrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03xhFS2YhPWGMNOr/tXpZgiGzZ2xffs2dt5fZGZhCUl/AlVZo
	p0daTThNCJTaiY0TaKocXdxNlMwwFPNTb1OT21lvbq3dsZH6vyR5Ls9UnoclRkfixAlH8awMTDK
	ZUt6JBXJqCgP3cen1Lkb663oLQx0fRgUuLhMGgzS9TaiU7ysWr9h+9RhOOdkschHIfu+0r1s9Wo
	CqSDBd6WpB43NdFb7fxangNvrBxfkwzEsHHHglet9PeiArc25nJuUhjPguJQs=
X-Gm-Gg: ASbGncvBbteQFvXwGLZwYLywPe9ZrlJVq6guGshjjTuFH4IIbSRvXPnql4ABHsV6dh+
	3DE3NuStpFfDG96+Iz2Wru8ao8ifIQzuYIiB3JTdfenmCZhuaCJSvs6VQEBCPJHraOro1nrfu6O
	DFDQOpA1k0vRvhdSh3erbV9kk=
X-Received: by 2002:a05:6902:1508:b0:e93:494e:9ec1 with SMTP id 3f1490d57ef6-e951c226d3cmr16403709276.19.1756215060136;
        Tue, 26 Aug 2025 06:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwnjAIyAKhv/avnddORq32kP91AHRB6ucC6WdjDpDx7JPGPfCyoy8rJf6lzWUDJb45Nn1NI45iA1j8g8ls5/U=
X-Received: by 2002:a05:6902:1508:b0:e93:494e:9ec1 with SMTP id
 3f1490d57ef6-e951c226d3cmr16403642276.19.1756215059326; Tue, 26 Aug 2025
 06:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <20250819134205.622806-3-npache@redhat.com>
 <248d57e5-8cd5-408b-a6c8-970df6876b6c@lucifer.local> <CAA1CXcC-7MudjF06JaJQUvKkNh4vPHTTeoMDBE-devotyFXjkA@mail.gmail.com>
 <d8932d68-1c43-479e-8167-6ab7b1b92cb6@lucifer.local>
In-Reply-To: <d8932d68-1c43-479e-8167-6ab7b1b92cb6@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Tue, 26 Aug 2025 07:30:32 -0600
X-Gm-Features: Ac12FXwynFJ3OHCwYVCi6LKJzKmqCLxiByf5LM0fU2vuu8ONvv7U6rorcw7ASiQ
Message-ID: <CAA1CXcDRnCtKRyXKLmxDwRBncw7GzqchwL1XRhHpDWbzttrw+g@mail.gmail.com>
Subject: Re: [PATCH v10 02/13] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
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
X-Mimecast-MFC-PROC-ID: au89Jn1J2oTzEqRwgNJGg0AqKK0YGohT6RzVIsel_Dc_1756215061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:23=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Aug 20, 2025 at 10:35:57AM -0600, Nico Pache wrote:
> > On Wed, Aug 20, 2025 at 5:22=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, Aug 19, 2025 at 07:41:54AM -0600, Nico Pache wrote:
> > > > The khugepaged daemon and madvise_collapse have two different
> > > > implementations that do almost the same thing.
> > > >
> > > > Create collapse_single_pmd to increase code reuse and create an ent=
ry
> > > > point to these two users.
> > > >
> > > > Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> > > > collapse_single_pmd function. This introduces a minor behavioral ch=
ange
> > > > that is most likely an undiscovered bug. The current implementation=
 of
> > > > khugepaged tests collapse_test_exit_or_disable before calling
> > > > collapse_pte_mapped_thp, but we weren't doing it in the madvise_col=
lapse
> > > > case. By unifying these two callers madvise_collapse now also perfo=
rms
> > > > this check.
> > > >
> > > > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > > Acked-by: David Hildenbrand <david@redhat.com>
> > > > Signed-off-by: Nico Pache <npache@redhat.com>
> > > > ---
> > > >  mm/khugepaged.c | 94 ++++++++++++++++++++++++++-------------------=
----
> > > >  1 file changed, 49 insertions(+), 45 deletions(-)
> > > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index 0e7bbadf03ee..b7b98aebb670 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -2382,6 +2382,50 @@ static int collapse_scan_file(struct mm_stru=
ct *mm, unsigned long addr,
> > > >       return result;
> > > >  }
> > > >
> > > > +/*
> > > > + * Try to collapse a single PMD starting at a PMD aligned addr, an=
d return
> > > > + * the results.
> > > > + */
> > > > +static int collapse_single_pmd(unsigned long addr,
> > > > +                             struct vm_area_struct *vma, bool *mma=
p_locked,
> > > > +                             struct collapse_control *cc)
> > > > +{
> > > > +     int result =3D SCAN_FAIL;
> > >
> > > You assign result in all branches, so this can be uninitialised.
> > ack, thanks.
> > >
> > > > +     struct mm_struct *mm =3D vma->vm_mm;
> > > > +
> > > > +     if (!vma_is_anonymous(vma)) {
> > > > +             struct file *file =3D get_file(vma->vm_file);
> > > > +             pgoff_t pgoff =3D linear_page_index(vma, addr);
> > > > +
> > > > +             mmap_read_unlock(mm);
> > > > +             *mmap_locked =3D false;
> > > > +             result =3D collapse_scan_file(mm, addr, file, pgoff, =
cc);
> > > > +             fput(file);
> > > > +             if (result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> > > > +                     mmap_read_lock(mm);
> > > > +                     *mmap_locked =3D true;
> > > > +                     if (collapse_test_exit_or_disable(mm)) {
> > > > +                             mmap_read_unlock(mm);
> > > > +                             *mmap_locked =3D false;
> > > > +                             result =3D SCAN_ANY_PROCESS;
> > > > +                             goto end;
> > >
> > > Don't love that in e.g. collapse_scan_mm_slot() we are using the mmap=
 lock being
> > > disabled as in effect an error code.
> > >
> > > Is SCAN_ANY_PROCESS correct here? Because in collapse_scan_mm_slot() =
you'd
> > > previously:
> > https://lore.kernel.org/lkml/a881ed65-351a-469f-b625-a3066d0f1d5c@linux=
.alibaba.com/
> > Baolin brought up a good point a while back that if
> > collapse_test_exit_or_disable returns true we will be breaking out of
> > the loop and should change the return value to indicate this. So to
> > combine the madvise breakout and the scan_slot breakout we drop the
> > lock and return SCAN_ANY_PROCESS.
>
> Let's document in commit msg, as Liam's pointed out it's really important=
 to
> track things, and part of that as well is detailing in the commit message=
 what
> you're doing + why.
ack! thanks
>
> With the THP code being as 'organically grown' as it is shall we say :) i=
t's
> even more mportant to be specific.
>
> > >
> > >         if (*result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> > >                 mmap_read_lock(mm);
> > >                 if (collapse_test_exit_or_disable(mm))
> > >                         goto breakouterloop;
> > >                 ...
> > >         }
> > >
> > > But now you're setting result =3D SCAN_ANY_PROCESS rather than
> > > SCAN_PTE_MAPPED_HUGEPAGE in this instance?
> > >
> > > You don't mention that you're changing this, or at least explicitly e=
nough,
> > > the commit message should state that you're changing this and explain=
 why
> > > it's ok.
> > I do state it but perhaps I need to be more verbose! I will update the
> > message to state we are also changing the result value too.
>
> Thanks!
>
> > >
> > > This whole file is horrid, and it's kinda an aside, but I really wish=
 we
> > > had some comment going through each of the scan_result cases and expl=
aining
> > > what each one meant.
> > Yeah its been a huge pain to have to investigate what everything is
> > supposed to mean, and I often have to go searching to confirm things.
> > include/trace/events/huge_memory.h has a "good" summary of them
> > >
> > > Also I think:
> > >
> > >         return SCAN_ANY_PROCESS;
> > >
> > > Is better than:
> > >
> > >         result =3D SCAN_ANY_PROCESS;
> > >         goto end;
> > I agree! I will change that :)
> > >         ...
> > > end:
> > >         return result;
> > >
> > > > +                     }
> > > > +                     result =3D collapse_pte_mapped_thp(mm, addr,
> > > > +                                                      !cc->is_khug=
epaged);
> > >
> > > Hm another change here, in the original code in collapse_scan_mm_slot=
()
> > > this is:
> > >
> > >         *result =3D collapse_pte_mapped_thp(mm,
> > >                 khugepaged_scan.address, false);
> > >
> > > Presumably collapse_scan_mm_slot() is only ever invoked with
> > > cc->is_khugepaged?
> > Correct, but the madvise_collapse calls this with true, hence why it
> > now depends on the is_khugepaged variable. No functional change here.
> > >
> > > Maybe worth adding a VM_WARN_ON_ONCE(!cc->is_khugepaged) at the top o=
f
> > > collapse_scan_mm_slot() to assert this (and other places where your c=
hange
> > > assumes this to be the case).
> > Ok I will investigate doing that but it would take a huge mistake to
> > hit that assertion.
> > >
> > >
> > > > +                     if (result =3D=3D SCAN_PMD_MAPPED)
> > > > +                             result =3D SCAN_SUCCEED;
> > > > +                     mmap_read_unlock(mm);
> > > > +                     *mmap_locked =3D false;
> > > > +             }
> > > > +     } else {
> > > > +             result =3D collapse_scan_pmd(mm, vma, addr, mmap_lock=
ed, cc);
> > > > +     }
> > > > +     if (cc->is_khugepaged && result =3D=3D SCAN_SUCCEED)
> > > > +             ++khugepaged_pages_collapsed;
> > >
> > > Similarly, presumably because collapse_scan_mm_slot() only ever invok=
ed
> > > khugepaged case this didn't have the cc->is_khugepaged check?
> > Correct, we only increment this when its khugepaged, so we need to
> > guard it so madvise collapse wont increment this.
>
> You know what I'm going to say :) commit message please!
ack, although this isnt anything new. I just needed to add it because
madvise collapse doesnt increment this. Still I'll add a blurb.
>
> > >
> > > > +end:
> > > > +     return result;
> > > > +}
> > >
> > > There's a LOT of nesting going on here, I think we can simplify this =
a
> > > lot. If we make the change I noted above re: returning SCAN_ANY_PROCE=
SS< we
> > > can move the end label up a bit and avoid a ton of nesting, e.g.:
> > Ah I like this much more, I will try to implement/test it.
> > >
> > > static int collapse_single_pmd(unsigned long addr,
> > >                                 struct vm_area_struct *vma, bool *mma=
p_locked,
> > >                                 struct collapse_control *cc)
> > > {
> > >         struct mm_struct *mm =3D vma->vm_mm;
> > >         struct file *file;
> > >         pgoff_t pgoff;
> > >         int result;
> > >
> > >         if (vma_is_anonymous(vma)) {
> > >                 result =3D collapse_scan_pmd(mm, vma, addr, mmap_lock=
ed, cc);
> > >                 goto end:
> > >         }
> > >
> > >         file =3D get_file(vma->vm_file);
> > >         pgoff =3D linear_page_index(vma, addr);
> > >
> > >         mmap_read_unlock(mm);
> > >         *mmap_locked =3D false;
> > >         result =3D collapse_scan_file(mm, addr, file, pgoff, cc);
> > >         fput(file);
> > >         if (result !=3D SCAN_PTE_MAPPED_HUGEPAGE)
> > >                 goto end;
> > >
> > >         mmap_read_lock(mm);
> > >         *mmap_locked =3D true;
> > >         if (collapse_test_exit_or_disable(mm)) {
> > >                 mmap_read_unlock(mm);
> > >                 *mmap_locked =3D false;
> > >                 return SCAN_ANY_PROCESS;
> > >         }
> > >         result =3D collapse_pte_mapped_thp(mm, addr, !cc->is_khugepag=
ed);
> > >         if (result =3D=3D SCAN_PMD_MAPPED)
> > >                 result =3D SCAN_SUCCEED;
> > >         mmap_read_unlock(mm);
> > >         *mmap_locked =3D false;
> > >
> > > end:
> > >         if (cc->is_khugepaged && result =3D=3D SCAN_SUCCEED)
> > >                 ++khugepaged_pages_collapsed;
> > >
> > >         return result;
> > > }
> > >
> > > (untested, thrown together so do double check!)
>
> This suggested refactoring work for you?
Looks correct, I'm going to implement all the changes then test to
make sure it works as intended.
>
> > >
> > > > +
> > > >  static unsigned int collapse_scan_mm_slot(unsigned int pages, int =
*result,
> > > >                                           struct collapse_control *=
cc)
> > > >       __releases(&khugepaged_mm_lock)
> > > > @@ -2455,34 +2499,9 @@ static unsigned int collapse_scan_mm_slot(un=
signed int pages, int *result,
> > > >                       VM_BUG_ON(khugepaged_scan.address < hstart ||
> > > >                                 khugepaged_scan.address + HPAGE_PMD=
_SIZE >
> > > >                                 hend);
> > > > -                     if (!vma_is_anonymous(vma)) {
> > > > -                             struct file *file =3D get_file(vma->v=
m_file);
> > > > -                             pgoff_t pgoff =3D linear_page_index(v=
ma,
> > > > -                                             khugepaged_scan.addre=
ss);
> > > > -
> > > > -                             mmap_read_unlock(mm);
> > > > -                             mmap_locked =3D false;
> > > > -                             *result =3D collapse_scan_file(mm,
> > > > -                                     khugepaged_scan.address, file=
, pgoff, cc);
> > > > -                             fput(file);
> > > > -                             if (*result =3D=3D SCAN_PTE_MAPPED_HU=
GEPAGE) {
> > > > -                                     mmap_read_lock(mm);
> > > > -                                     if (collapse_test_exit_or_dis=
able(mm))
> > > > -                                             goto breakouterloop;
> > > > -                                     *result =3D collapse_pte_mapp=
ed_thp(mm,
> > > > -                                             khugepaged_scan.addre=
ss, false);
> > > > -                                     if (*result =3D=3D SCAN_PMD_M=
APPED)
> > > > -                                             *result =3D SCAN_SUCC=
EED;
> > > > -                                     mmap_read_unlock(mm);
> > > > -                             }
> > > > -                     } else {
> > > > -                             *result =3D collapse_scan_pmd(mm, vma=
,
> > > > -                                     khugepaged_scan.address, &mma=
p_locked, cc);
> > > > -                     }
> > > > -
> > > > -                     if (*result =3D=3D SCAN_SUCCEED)
> > > > -                             ++khugepaged_pages_collapsed;
> > > >
> > > > +                     *result =3D collapse_single_pmd(khugepaged_sc=
an.address,
> > > > +                                                     vma, &mmap_lo=
cked, cc);
> > > >                       /* move to next address */
> > > >                       khugepaged_scan.address +=3D HPAGE_PMD_SIZE;
> > > >                       progress +=3D HPAGE_PMD_NR;
> > > > @@ -2799,34 +2818,19 @@ int madvise_collapse(struct vm_area_struct =
*vma, unsigned long start,
> > > >               mmap_assert_locked(mm);
> > > >               memset(cc->node_load, 0, sizeof(cc->node_load));
> > > >               nodes_clear(cc->alloc_nmask);
> > > > -             if (!vma_is_anonymous(vma)) {
> > > > -                     struct file *file =3D get_file(vma->vm_file);
> > > > -                     pgoff_t pgoff =3D linear_page_index(vma, addr=
);
> > > >
> > > > -                     mmap_read_unlock(mm);
> > > > -                     mmap_locked =3D false;
> > > > -                     result =3D collapse_scan_file(mm, addr, file,=
 pgoff, cc);
> > > > -                     fput(file);
> > > > -             } else {
> > > > -                     result =3D collapse_scan_pmd(mm, vma, addr,
> > > > -                                                &mmap_locked, cc);
> > > > -             }
> > > > +             result =3D collapse_single_pmd(addr, vma, &mmap_locke=
d, cc);
> > > > +
> > >
> > > Ack the fact you noted the behaviour change re:
> > > collapse_test_exit_or_disable() that seems fine.
> > >
> > > >               if (!mmap_locked)
> > > >                       *lock_dropped =3D true;
> > > >
> > > > -handle_result:
> > > >               switch (result) {
> > > >               case SCAN_SUCCEED:
> > > >               case SCAN_PMD_MAPPED:
> > > >                       ++thps;
> > > >                       break;
> > > > -             case SCAN_PTE_MAPPED_HUGEPAGE:
> > > > -                     BUG_ON(mmap_locked);
> > > > -                     mmap_read_lock(mm);
> > > > -                     result =3D collapse_pte_mapped_thp(mm, addr, =
true);
> > > > -                     mmap_read_unlock(mm);
> > > > -                     goto handle_result;
> > >
> > > One thing that differs with new code her is we filter SCAN_PMD_MAPPED=
 to
> > > SCAN_SUCCEED.
> > >
> > > I was about to say 'but ++thps - is this correct' but now I realise t=
his
> > > was looping back on itself with a goto to do just that... ugh ye gads=
.
> > >
> > > Anwyay that's fine because it doesn't change anything.
> > >
> > > Re: switch statement in general, again would be good to always have e=
ach
> > > scan possibility in switch statements, but perhaps given so many not
> > > practical :)
> >
> > Yeah it may be worth investigating for future changes I have for
> > khugepaged (including the new switch statement I implement later and
> > you commented on)
>
> Ack yeah this can be one for the future!
>
> > >
> > > (that way the compiler warns on missing a newly added enum val)
> > >
> > > >               /* Whitelisted set of results where continuing OK */
> > > > +             case SCAN_PTE_MAPPED_HUGEPAGE:
> > > >               case SCAN_PMD_NULL:
> > > >               case SCAN_PTE_NON_PRESENT:
> > > >               case SCAN_PTE_UFFD_WP:
> > > > --
> >
> > Thanks for the review :)
>
> No probs, to underline as well - the critique is to make sure we get this=
 right,
> my aim here is to get your series landed in as good a form as possible :)
All critiquing is welcome and appreciated :) The refactoring looks
much better now too!

Cheers,
-- Nico
>
> >
> > -- Nico
> > > > 2.50.1
> > > >
> > >
> >
>
> Cheers, Lorenzo
>

