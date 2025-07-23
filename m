Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824619C55E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235767; cv=none; b=UMSqzyEDpYh5/CLXPuQRTsVEqxg3z/LZAzxtu4ie7nneNpno/E5L4QVoioXwKqW9O11eVnYlg3XKQrRwXpYTsQBipQ6H/Rt3bjxtgAKRONNM5aunS8XQoQ3e+bcNa7CUca6p8dKUwBw17R6P1Fj+eanlDid7eCT2UQBVJoJ9r+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235767; c=relaxed/simple;
	bh=XqjNArdmJFTRu9QH13Le9hvtpPRBeyYXdj4zrQ3V3x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OB6BY5evsh7n8lwjmOxAOhCuPv/nPWesXrPirbO7HKhhqJxmFqrD+a+rR8v17qTObNY1zWbbjCd3I6/qnRda8GuV+7qOi8zkKVEz035tojKXn+3IFa7fMQ8W708m/Kti23KiFG33ofo7XvP6s5386QJWf2k++hXyh0u2utlHnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dk8hG44Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dk8hG44Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753235764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bz6qe7sGza0nelW7zhVuxtwxYXtjXl9NGKLnwwou5kM=;
	b=dk8hG44Z4ti5kZEu3B1DxhoESh66VYyyP1KlyDsos88yLoUo2cIgmwa9MO3l1rnQHq0nYX
	xLAQCmMO/ISZnz3io+mZGHKpV98t0lMGAp5XUKQJDu5zeGN2feSIZdYx9DA62PsHqx6Jn5
	bvBYWgya1p1qbE/35JRaBtcwW4Zz4Mc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-KEA1JdKTMQWOKcNnV246nA-1; Tue, 22 Jul 2025 21:56:02 -0400
X-MC-Unique: KEA1JdKTMQWOKcNnV246nA-1
X-Mimecast-MFC-AGG-ID: KEA1JdKTMQWOKcNnV246nA_1753235762
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-713e879bd7cso80095327b3.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753235762; x=1753840562;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bz6qe7sGza0nelW7zhVuxtwxYXtjXl9NGKLnwwou5kM=;
        b=RoD8xrJqv3QX15RUOV0AnJFX8nrVpRuiaKBM9flW2aZwaBjxfkLIFsbhMMz22+mI1S
         sUSLUj2pT0yjtMuZKhRDwSUJ1gNzyJxjQ0CjMalum69OvwEEHB51F1gGQSUqqBfMQovP
         dHxagLiTUEB4LjaZDD6ARf+DMR9MPK8AQVVUXJ07Dlh3yXJLgP3pYVg45JHh1GpdlwZw
         iYwOa8zmuzsmN2ki46oO87dbD0KJFTgGGvBabpOzJycw8DWQJzNpkjesIPID/YmrsCOn
         giUxyZQbSq1mFtFj8MzT+d6vhOdR/MNhN4VzFLQr5x1m6S5CXpQEdnvZ2jRfHWodd8Uh
         YW1w==
X-Forwarded-Encrypted: i=1; AJvYcCVh+nd0qXsQdPu3BToAzWQpRTMxqW97Ek5DNyQlaEI4ySkcNI5Kvj66m9ppOlSka8sByuYdotLI4twGFtfATJfmJ+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGzID639RjNYWdIT9NxURwlkNsT2osJKHGT7Ob6kXPdsG/G8R
	YkASSbStwKg+Fn3Akyyl7203OnFyqPOaqUJH7nQSQM4L5RNlg/DyScU8sx9iUfQ4eWYGEf1NKPN
	DEqDHsaaULcy0CpqerlEoDXJep6f9fetY8RmchUeYjp+04hH3OVdu2WRNDpwhZVpYuJIw7qlrcx
	Br1aO69pHhY0edgxM2rhc7LwUlx9VYUWbljmQGj87G7CbIhw19
X-Gm-Gg: ASbGnctogzp0/kvIOanONFB/RpqwVayz4NP2jhA4ooTOFiH0e3mwyxigfKIdSDP2IFR
	9JD63qXS/jkXuslqNvzdLNOyM0a9mMA/kvCA/JUlIAdxM3dDc76whO7DVsARMfGRECzlDiZJYjX
	4c/yNxHkW6ayJAQRPQEXVnn2c=
X-Received: by 2002:a05:690c:6c8e:b0:718:385e:58e1 with SMTP id 00721157ae682-719b40e6c74mr19777777b3.0.1753235761938;
        Tue, 22 Jul 2025 18:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcUvSR1xEnNnk2wsz8RU+3YgmlHPQ8xdxNQT/0M5qmuW8jeOgz0aWxtQp7CitqZyNVGjBNQEb70xM7y6n+amQ=
X-Received: by 2002:a05:690c:6c8e:b0:718:385e:58e1 with SMTP id
 00721157ae682-719b40e6c74mr19777527b3.0.1753235761489; Tue, 22 Jul 2025
 18:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-3-npache@redhat.com>
 <ifgx5ufi3qxcw7cj2nmkui56xsen5pifd7utv4v7firbjhotuk@2fozz3b7adwk>
In-Reply-To: <ifgx5ufi3qxcw7cj2nmkui56xsen5pifd7utv4v7firbjhotuk@2fozz3b7adwk>
From: Nico Pache <npache@redhat.com>
Date: Tue, 22 Jul 2025 19:55:33 -0600
X-Gm-Features: Ac12FXzKmyB_PCF_XfE0ZL6463nA8qUSGh0SKuLPbr3f8v6ajiQFuaDPZtk_Y-I
Message-ID: <CAA1CXcAJU4mKmHLixGrm1mZiphFYbfdE+1yqQLSvxH2A-An__Q@mail.gmail.com>
Subject: Re: [PATCH v9 02/14] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jEu1gO5VkrMm0oschjfElaP5R1Gx99f7V5rPl-N0o78_1753235762
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:14=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Nico Pache <npache@redhat.com> [250713 20:33]:
> > The khugepaged daemon and madvise_collapse have two different
> > implementations that do almost the same thing.
> >
> > Create collapse_single_pmd to increase code reuse and create an entry
> > point to these two users.
> >
> > Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> > collapse_single_pmd function. This introduces a minor behavioral change
> > that is most likely an undiscovered bug. The current implementation of
> > khugepaged tests collapse_test_exit_or_disable before calling
> > collapse_pte_mapped_thp, but we weren't doing it in the madvise_collaps=
e
> > case. By unifying these two callers madvise_collapse now also performs
> > this check.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 95 +++++++++++++++++++++++++------------------------
> >  1 file changed, 49 insertions(+), 46 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index eb0babb51868..47a80638af97 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2362,6 +2362,50 @@ static int collapse_scan_file(struct mm_struct *=
mm, unsigned long addr,
> >       return result;
> >  }
> >
> > +/*
> > + * Try to collapse a single PMD starting at a PMD aligned addr, and re=
turn
> > + * the results.
> > + */
> > +static int collapse_single_pmd(unsigned long addr,
> > +                                struct vm_area_struct *vma, bool *mmap=
_locked,
> > +                                struct collapse_control *cc)
> > +{
> > +     int result =3D SCAN_FAIL;
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +
> > +     if (!vma_is_anonymous(vma)) {
> > +             struct file *file =3D get_file(vma->vm_file);
> > +             pgoff_t pgoff =3D linear_page_index(vma, addr);
> > +
> > +             mmap_read_unlock(mm);
> > +             *mmap_locked =3D false;
>
> Okay, just for my sanity, when we reach this part.. mmap_locked will
> be false on return.  Because we set it a bunch more below.. but it's
> always false on return.
>
> Although this is cleaner implementation of the lock, I'm just not sure
> why you keep flipping the mmap_locked variable here?  We could probably
> get away with comments that it will always be false.
>
>
> > +             result =3D collapse_scan_file(mm, addr, file, pgoff, cc);
> > +             fput(file);
> > +             if (result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> > +                     mmap_read_lock(mm);
> > +                     *mmap_locked =3D true;
> > +                     if (collapse_test_exit_or_disable(mm)) {
> > +                             mmap_read_unlock(mm);
> > +                             *mmap_locked =3D false;
> > +                             result =3D SCAN_ANY_PROCESS;
> > +                             goto end;
> > +                     }
> > +                     result =3D collapse_pte_mapped_thp(mm, addr,
> > +                                                      !cc->is_khugepag=
ed);
> > +                     if (result =3D=3D SCAN_PMD_MAPPED)
> > +                             result =3D SCAN_SUCCEED;
> > +                     mmap_read_unlock(mm);
> > +                     *mmap_locked =3D false;
> > +             }
> > +     } else {
> > +             result =3D collapse_scan_pmd(mm, vma, addr, mmap_locked, =
cc);
> > +     }
> > +     if (cc->is_khugepaged && result =3D=3D SCAN_SUCCEED)
> > +             ++khugepaged_pages_collapsed;
> > +end:
> > +     return result;
> > +}
> > +
> >  static unsigned int collapse_scan_mm_slot(unsigned int pages, int *res=
ult,
> >                                           struct collapse_control *cc)
> >       __releases(&khugepaged_mm_lock)
> > @@ -2436,34 +2480,9 @@ static unsigned int collapse_scan_mm_slot(unsign=
ed int pages, int *result,
> >                       VM_BUG_ON(khugepaged_scan.address < hstart ||
> >                                 khugepaged_scan.address + HPAGE_PMD_SIZ=
E >
> >                                 hend);
> > -                     if (!vma_is_anonymous(vma)) {
> > -                             struct file *file =3D get_file(vma->vm_fi=
le);
> > -                             pgoff_t pgoff =3D linear_page_index(vma,
> > -                                             khugepaged_scan.address);
> > -
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
> >
> > +                     *result =3D collapse_single_pmd(khugepaged_scan.a=
ddress,
> > +                                             vma, &mmap_locked, cc);
> >                       /* move to next address */
> >                       khugepaged_scan.address +=3D HPAGE_PMD_SIZE;
> >                       progress +=3D HPAGE_PMD_NR;
> > @@ -2780,35 +2799,19 @@ int madvise_collapse(struct vm_area_struct *vma=
, unsigned long start,
> >               mmap_assert_locked(mm);
> >               memset(cc->node_load, 0, sizeof(cc->node_load));
> >               nodes_clear(cc->alloc_nmask);
> > -             if (!vma_is_anonymous(vma)) {
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
> > +             result =3D collapse_single_pmd(addr, vma, &mmap_locked, c=
c);
> > +
> >               if (!mmap_locked)
> >                       *lock_dropped =3D true;
>
> All of this locking is scary, because there are comments everywhere that
> imply that mmap_locked indicates that the lock was dropped at some
> point, but we are using it to indicate that the lock is currently held -
> which are very different things..
>
> Here, for example locked_dropped may not be set to true event though we
> have toggled it through collapse_single_pmd() -> collapse_scan_pmd() ->
> ... -> collapse_huge_page().
>
> Maybe these scenarios are safe because of known limitations of what will
> or will not happen, but the code paths existing without a comment about
> why it is safe seems like a good way to introduce races later.
You bring up some good points here...

Its actually rather confusing why we have this flag, and what purpose
it serves with relation to those comments (other than tracking the
state of the mmap_lock). You are correct that it states to indicate
that the lock was dropped at some point, but in practice that is not
the case, there are multiple cases of the lock being dropped and
reacquired without flipping the flag to false. So in practice I dont
think that's the way it's actually working.

I did some digging and it was introduced in 50ad2f24b3b4
("mm/khugepaged: propagate enum scan_result codes back to callers"),
and AFAICT it was introduced to so we can properly indicate the return
value/state to the parent callers and those comments are incorrect.

"Since khugepaged_scan_pmd()'s return value already has a specific meaning
    (whether mmap_lock was unlocked or not), add a bool* argument to
    khugepaged_scan_pmd() to retrieve this information."

Cheers,
-- Nico
>
> >
> > -handle_result:
> >               switch (result) {
> >               case SCAN_SUCCEED:
> >               case SCAN_PMD_MAPPED:
> >                       ++thps;
> >                       break;
> > -             case SCAN_PTE_MAPPED_HUGEPAGE:
> > -                     BUG_ON(mmap_locked);
> > -                     mmap_read_lock(mm);
> > -                     result =3D collapse_pte_mapped_thp(mm, addr, true=
);
> > -                     mmap_read_unlock(mm);
> > -                     goto handle_result;
> >               /* Whitelisted set of results where continuing OK */
> > +             case SCAN_PTE_MAPPED_HUGEPAGE:
> >               case SCAN_PMD_NULL:
> >               case SCAN_PTE_NON_PRESENT:
> >               case SCAN_PTE_UFFD_WP:
> > --
> > 2.50.0
> >
> >
>

