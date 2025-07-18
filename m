Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04BC1F8EFF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872458; cv=none; b=rahjSMDsHIWkFEZCON116PKdXEpxkax8xYtSayQIHe5HHM2zeE4mMT2qDgOjFmDatDYBfU6+FHp4tJeLz2Ys0T1jkgwaHmz/K2ocVchkfmNrYfTcJ9wH2nPNyQuBRoFshn0wbHpqZwyfLWBEuefSShOD7vtI+5fMz0BLwMECC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872458; c=relaxed/simple;
	bh=ItX9nLm0rKHfLSwYPt3aRk0stdgRo5qgnqLw2DNuo5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU9cNOz6E32iP+fNcCJHYr/kvGDHc18kS/UmdUSgaI/SH7BiWuNAta1+VoUMWohRB2TsmOipUUrKJ+3pl7EhK9Y9vbdPv+mzDSddRHDJmgt7CLBp2MHBZkNc4u7x3Sryy+6wHNEqAN1cDcREeUlSwAaT4Is8qJFAKcLPulT2+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/0u35Ng; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/0u35Ng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752872455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XswQuaaE2754OlYhBT3pS/FTBtUgeNS0s3HKHNzAPSU=;
	b=b/0u35NgjyWNMzJh1sP7W0Ak2N6tPhoeGl8orLMNsqpiun7CdJ5EH+mc5BBy+NBu3MvNy0
	fwB8Cq3pIz8WZ0rL8Tg/N5hd7JYIED0OyfLWs+M5mdCezfhir8V12aP9k0+7/mBZgWUJD8
	Rvui3sbEHggCcQHoBLKzt7kwsVQ9J5k=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-rs9ZGvQ_NZyhnbhkNkHZmg-1; Fri, 18 Jul 2025 17:00:53 -0400
X-MC-Unique: rs9ZGvQ_NZyhnbhkNkHZmg-1
X-Mimecast-MFC-AGG-ID: rs9ZGvQ_NZyhnbhkNkHZmg_1752872453
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7194c6b0b8aso25384467b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752872452; x=1753477252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XswQuaaE2754OlYhBT3pS/FTBtUgeNS0s3HKHNzAPSU=;
        b=R5h76z+419OM5C05lpYjQwa1zdAGW/5qaAnh2LztzMq7rwC9J777DctU7LWhbqpHem
         3We4bdX5w6yuN3ysPu8PoawUMLBRXlYZ/djT5cF3ygUarMpMLSgXPlOuG1WWCR65IdcC
         CP6w7/OHzL2dgQecckkEWQjUGIs3zKvqewth5fmBE+bfIJIXV2tbBu7YYmimKc334EIk
         UwV63iPZ28wj0esIExuBNF5IHl7oZjRYawptd+xqj7HQU4XKSl0Q/knt67ZuFcGhqhbx
         iFUV+ZVohrqNPrtznabdvXAhNxKPnvS8QLHYMCn1sFLMdqgjVlg9AYaGs64Ar/D766iG
         2nIg==
X-Forwarded-Encrypted: i=1; AJvYcCVAcvuoPMEs1r0w5q8t6Dat3Tf5pVri5aGZFgHLcTzHMpLDuqb7Kc+zFBc6Wm1Id0418o6Wzp8tTQUu5t3yNpboI7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze25SlD94l7DmC/oMeB6P0eoHT3njWqZHWabYFBT/yxEPRvAl4
	+Wjn8FCo+clnArFPkuyjn9AdhwIDHaqhUXhfvI4a+VH6lu5WUwWrufz1G6QHCOHT4yXQrnitYDE
	xM/xv6D8wMjlTcbEZprrVtMjGTUYnCtBIhLzOc0VwcU5Q0WbAXUiDz/tz9W5ESia6n1WEXJ8Nn4
	NhEI83tm954MUXgN47ffvSVe9d/fRKSgbGux1vxU1Wmqpx6Ya8ReYg8RjAYa/RAQ==
X-Gm-Gg: ASbGncsqpT3rIlGZNY9ha1nFf0d4EECWW+PVBMIhhJJ7gjT4+IsfqruRGlwIZx1UdlC
	2Coyz/B/Sr8X/M8awR1jjJeY897vRKNFdlJJUO4hho7rzMM7so66i8JYEC0QQA6DYrili7bNRry
	gGKEAkJk8IhqAbNSQeTvsqvhQ=
X-Received: by 2002:a05:690c:3703:b0:70c:a854:8384 with SMTP id 00721157ae682-719521a381cmr41623627b3.11.1752872452185;
        Fri, 18 Jul 2025 14:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbt85bf5Kp+dxoJKo0BjW8mtOr2VJ49x22KnfNGF3rtqH8j5TzQacIXdf97YAgrjTlUoNcqs6kDMtwdOrWCrU=
X-Received: by 2002:a05:690c:3703:b0:70c:a854:8384 with SMTP id
 00721157ae682-719521a381cmr41623077b3.11.1752872451784; Fri, 18 Jul 2025
 14:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-14-npache@redhat.com>
 <94c8899a-f116-4b6a-94d3-f8295ee3f535@linux.alibaba.com>
In-Reply-To: <94c8899a-f116-4b6a-94d3-f8295ee3f535@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 18 Jul 2025 15:00:25 -0600
X-Gm-Features: Ac12FXyZkvpO72Y8KuApMa6zkujq0hEtG4p8bsgfkYpSM3DyaV_34-FVHPb5UAY
Message-ID: <CAA1CXcDQeiMjVhxVjnCvBuTQLSBQh0ea7FJXg52ebNFDHfXm1g@mail.gmail.com>
Subject: Re: [PATCH v9 13/14] khugepaged: add per-order mTHP khugepaged stats
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com, 
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
X-Mimecast-MFC-PROC-ID: 0t1NphGmdE8Q30tp43csMQq7pMRMBj0Z98zvirPwbtw_1752872453
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:05=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/7/14 08:32, Nico Pache wrote:
> > With mTHP support inplace, let add the per-order mTHP stats for
> > exceeding NONE, SWAP, and SHARED.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   Documentation/admin-guide/mm/transhuge.rst | 17 +++++++++++++++++
> >   include/linux/huge_mm.h                    |  3 +++
> >   mm/huge_memory.c                           |  7 +++++++
> >   mm/khugepaged.c                            | 15 ++++++++++++---
> >   4 files changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 2c523dce6bc7..28c8af61efba 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -658,6 +658,23 @@ nr_anon_partially_mapped
> >          an anonymous THP as "partially mapped" and count it here, even=
 though it
> >          is not actually partially mapped anymore.
> >
> > +collapse_exceed_swap_pte
> > +       The number of anonymous THP which contain at least one swap PTE=
.
> > +       Currently khugepaged does not support collapsing mTHP regions t=
hat
> > +       contain a swap PTE.
> > +
> > +collapse_exceed_none_pte
> > +       The number of anonymous THP which have exceeded the none PTE th=
reshold.
> > +       With mTHP collapse, a bitmap is used to gather the state of a P=
MD region
> > +       and is then recursively checked from largest to smallest order =
against
> > +       the scaled max_ptes_none count. This counter indicates that the=
 next
> > +       enabled order will be checked.
> > +
> > +collapse_exceed_shared_pte
> > +       The number of anonymous THP which contain at least one shared P=
TE.
> > +       Currently khugepaged does not support collapsing mTHP regions t=
hat
> > +       contain a shared PTE.
> > +
> >   As the system ages, allocating huge pages may be expensive as the
> >   system uses memory compaction to copy data around memory to free a
> >   huge page for use. There are some counters in ``/proc/vmstat`` to hel=
p
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 4042078e8cc9..e0a27f80f390 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -141,6 +141,9 @@ enum mthp_stat_item {
> >       MTHP_STAT_SPLIT_DEFERRED,
> >       MTHP_STAT_NR_ANON,
> >       MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> > +     MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> > +     MTHP_STAT_COLLAPSE_EXCEED_NONE,
> > +     MTHP_STAT_COLLAPSE_EXCEED_SHARED,
> >       __MTHP_STAT_COUNT
> >   };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index e2ed9493df77..57e5699cf638 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -632,6 +632,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLI=
T_FAILED);
> >   DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >   DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
> >   DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PAR=
TIALLY_MAPPED);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXC=
EED_SWAP);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXC=
EED_NONE);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_E=
XCEED_SHARED);
> > +
> >
> >   static struct attribute *anon_stats_attrs[] =3D {
> >       &anon_fault_alloc_attr.attr,
> > @@ -648,6 +652,9 @@ static struct attribute *anon_stats_attrs[] =3D {
> >       &split_deferred_attr.attr,
> >       &nr_anon_attr.attr,
> >       &nr_anon_partially_mapped_attr.attr,
> > +     &collapse_exceed_swap_pte_attr.attr,
> > +     &collapse_exceed_none_pte_attr.attr,
> > +     &collapse_exceed_shared_pte_attr.attr,
> >       NULL,
> >   };
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index d0c99b86b304..8a5873d0a23a 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -594,7 +594,10 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > -                             count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> > +                             if (order =3D=3D HPAGE_PMD_ORDER)
> > +                                     count_vm_event(THP_SCAN_EXCEED_NO=
NE_PTE);
> > +                             else
> > +                                     count_mthp_stat(order, MTHP_STAT_=
COLLAPSE_EXCEED_NONE);
>
> Please follow the same logic as other mTHP statistics, meaning there is
> no need to filter out PMD-sized orders, because mTHP also supports
> PMD-sized orders. So logic should be:
>
> if (order =3D=3D HPAGE_PMD_ORDER)
>         count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>
> count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
Good point-- I will fix that!
>
> >                               goto out;
> >                       }
> >               }
> > @@ -623,8 +626,14 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >               /* See khugepaged_scan_pmd(). */
> >               if (folio_maybe_mapped_shared(folio)) {
> >                       ++shared;
> > -                     if (order !=3D HPAGE_PMD_ORDER || (cc->is_khugepa=
ged &&
> > -                         shared > khugepaged_max_ptes_shared)) {
> > +                     if (order !=3D HPAGE_PMD_ORDER) {
> > +                             result =3D SCAN_EXCEED_SHARED_PTE;
> > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
> > +                             goto out;
> > +                     }
>
> Ditto.
Thanks!

There is also the SWAP one, which is slightly different as it is
calculated during the scan phase, and in the mTHP case in the swapin
faulting code. Not sure if during the scan phase we should also
increment the counter for the PMD order... or just leave it as a
general vm_event counter since it's not attributed to an order during
scan. I believe the latter is the correct approach and only attribute
an order to it in the __collapse_huge_page_swapin function if its mTHP
collapses.
>
> > +
> > +                     if (cc->is_khugepaged &&
> > +                             shared > khugepaged_max_ptes_shared) {
> >                               result =3D SCAN_EXCEED_SHARED_PTE;
> >                               count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> >                               goto out;
>

