Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD7258EC0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613420; cv=none; b=KQ3gVf0Wv0VNcMg9N14rQyf5IMwT7/s10AHpiTFdZ0GdIvTDt6wteG/TcdStRWUHtIVzxKjKcUJ7n17v6xiUeNlduA+AI3UeHx9asNd1ie1i+LrT0fUnhgErCgiruy9axGbqlNaaanPCBcjsJ7QAtpHliNM5TdFDO/8iEORmP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613420; c=relaxed/simple;
	bh=Svo24zsBad1Yjo2p9ft9iXPbEuLvtl5ExtBxHBI5dC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blEz6B6x+gIBHC9gklbsE5amTxHgUHaPvCeu/YmYRLXV3/jP4k4m0JKr0JAgYtvcn6w1S/CPkDah4n5/W674063p5APMY14IKi5WT9WTq7VFpW7leGSdVamWwjWoTsY9AXcmfTHddIKYLNdgd+5xjVJNh57H6tsYklFfnIQzF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SM9/3q5x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM9/3q5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755613418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3Yx3WbmFOJltwzECtqg3RoGKlDwwsG1Ihs41TRQMQI=;
	b=SM9/3q5xpXhmqhZN8KgK6RTBl1ZDdWoq+pWnt+xj/gW3Ux+ceyMsI0RJwkIYGVtshMUfj7
	U+KX8HwMuggRPlEodca4f4LJLXzwBOYaqf9Yf/kDvtdwTVObCu3mjvvDNUEg82X3hmvFvg
	6uz176BbQXwRXHxQuOG+GO3DNTcP5+c=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-91zDNfq9MKyFD81xrmVrSA-1; Tue, 19 Aug 2025 10:23:35 -0400
X-MC-Unique: 91zDNfq9MKyFD81xrmVrSA-1
X-Mimecast-MFC-AGG-ID: 91zDNfq9MKyFD81xrmVrSA_1755613414
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e933a696359so4991759276.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613414; x=1756218214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3Yx3WbmFOJltwzECtqg3RoGKlDwwsG1Ihs41TRQMQI=;
        b=lTYCA7EXhXF0r8wLDSebeHRsoDwVb4FEYXrRSUH5EN0HRa0aQQ0xqr+/jDFhVWWhAy
         /295IowkD0OLeouvqxfoY0NJsRcZTEsSAdt5JM0n9MMPMRLCxGDb9XuNVp7/zI8TkGGX
         7w8QDrV2Hq9kvmQjFujGa8kOKLR4kBJdKKWES90lxglp1D8dlAS5rKAyMi3W0rDtKOkX
         k/3eDmheDC+I8x4rvMTy9avZ7Rr120aHFlIrTrTfz3Fv9OZpHTXgd84srv/DQd5JZrG8
         MH3jDow/CyBVcN4qPZa6sK4uJJ3my4qIgNoMgl4fa0U/JNkH1AxASoANUBgc0A0H5s+U
         6toA==
X-Forwarded-Encrypted: i=1; AJvYcCXzNE2M1w93/sj3uwasz2MVKf4/ys9F4G5B03OidnaN7zJuCpPz5dEHDQGDXhtWiyooMg8WYodtBJx4DjJ2V9BOO7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn3yQCqtPUd3mgAwlEtBWRLIqQP1Ygdtbc6vqgbJ8eeoOOjNmg
	8pmWDrXnE00Jj25VlA2F+c/PyPz3q5bWpTQgGGbECjd7SLPBL8DUgIEQdl1pCuDj++R1B6qj1Gd
	gr0ci5/WBhaH+oFEgs/2GoYR3v5ceHbW69eFSj+AZFs/YPZNc3uFME9fTgBIfS+EszvFsYzLPxt
	5jqv6ecRL6jrEV18+nHP2H7Dw2FM3iVtnanzGqQegXM1OzYcWd
X-Gm-Gg: ASbGncuH1GVNiJoLVKKd/df8/JqmuXDuBUXNhpJgIpYjuC8s6Vr2eHlWnHzE9OpWdFc
	BWWiiSrYtG0mEUxuNeumsHyltATw2/1J+cJo05NmMvWIz63uSYCh0TaE7l1C6BMr4/EG590r24j
	UFVtc1lrzflmtkqKTPzRjcAOc=
X-Received: by 2002:a05:6902:3302:b0:e90:6e1f:56b3 with SMTP id 3f1490d57ef6-e94e6094cd0mr2715203276.7.1755613414458;
        Tue, 19 Aug 2025 07:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnzwnibgt/XeaswLHQENR5+DMzayfV7924bb8m3+Q/0aGqUrDD2rGuExgIkd35TqRCyLnp3B2R4M4uEj5nITg=
X-Received: by 2002:a05:6902:3302:b0:e90:6e1f:56b3 with SMTP id
 3f1490d57ef6-e94e6094cd0mr2715129276.7.1755613414012; Tue, 19 Aug 2025
 07:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134824.623535-1-npache@redhat.com>
In-Reply-To: <20250819134824.623535-1-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 19 Aug 2025 08:23:07 -0600
X-Gm-Features: Ac12FXwnn2MMnUVTpNFBn4Ff3i8_FNGdV8T00Ku52kXw2sNhN4OlDuPKu8EOG9k
Message-ID: <CAA1CXcCS+eVoS_XyWgO2Xexwo-9pc_sUaTpmnet1EHqOGDGwWg@mail.gmail.com>
Subject: Re: [PATCH v10 12/13] khugepaged: add per-order mTHP khugepaged stats
To: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
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
X-Mimecast-MFC-PROC-ID: 3VXlfPj1gUa2-CTpgj3heDznBQAl3Xrq8RxghMbXW9U_1755613414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 7:49=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> With mTHP support inplace, let add the per-order mTHP stats for
> exceeding NONE, SWAP, and SHARED.
>
> Signed-off-by: Nico Pache <npache@redhat.com>

I had git send email error and had to resend this patch (12) and patch
13, but i forgot the in-reply-to
please ignore this one and reply to correct version

https://lore.kernel.org/lkml/20250819141610.626140-1-npache@redhat.com/
--in-reply-to=3D20250819141610.626140-1-npache@redhat.com


-- Nico

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 17 +++++++++++++++++
>  include/linux/huge_mm.h                    |  3 +++
>  mm/huge_memory.c                           |  7 +++++++
>  mm/khugepaged.c                            | 16 +++++++++++++---
>  4 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 7ccb93e22852..b85547ac4fe9 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -705,6 +705,23 @@ nr_anon_partially_mapped
>         an anonymous THP as "partially mapped" and count it here, even th=
ough it
>         is not actually partially mapped anymore.
>
> +collapse_exceed_swap_pte
> +       The number of anonymous THP which contain at least one swap PTE.
> +       Currently khugepaged does not support collapsing mTHP regions tha=
t
> +       contain a swap PTE.
> +
> +collapse_exceed_none_pte
> +       The number of anonymous THP which have exceeded the none PTE thre=
shold.
> +       With mTHP collapse, a bitmap is used to gather the state of a PMD=
 region
> +       and is then recursively checked from largest to smallest order ag=
ainst
> +       the scaled max_ptes_none count. This counter indicates that the n=
ext
> +       enabled order will be checked.
> +
> +collapse_exceed_shared_pte
> +       The number of anonymous THP which contain at least one shared PTE=
.
> +       Currently khugepaged does not support collapsing mTHP regions tha=
t
> +       contain a shared PTE.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4ada5d1f7297..6f1593d0b4b5 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -144,6 +144,9 @@ enum mthp_stat_item {
>         MTHP_STAT_SPLIT_DEFERRED,
>         MTHP_STAT_NR_ANON,
>         MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> +       MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> +       MTHP_STAT_COLLAPSE_EXCEED_NONE,
> +       MTHP_STAT_COLLAPSE_EXCEED_SHARED,
>         __MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 20d005c2c61f..9f0470c3e983 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -639,6 +639,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_=
FAILED);
>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>  DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
>  DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIA=
LLY_MAPPED);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEE=
D_SWAP);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEE=
D_NONE);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXC=
EED_SHARED);
> +
>
>  static struct attribute *anon_stats_attrs[] =3D {
>         &anon_fault_alloc_attr.attr,
> @@ -655,6 +659,9 @@ static struct attribute *anon_stats_attrs[] =3D {
>         &split_deferred_attr.attr,
>         &nr_anon_attr.attr,
>         &nr_anon_partially_mapped_attr.attr,
> +       &collapse_exceed_swap_pte_attr.attr,
> +       &collapse_exceed_none_pte_attr.attr,
> +       &collapse_exceed_shared_pte_attr.attr,
>         NULL,
>  };
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index c13bc583a368..5a3386043f39 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -594,7 +594,9 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                                 continue;
>                         } else {
>                                 result =3D SCAN_EXCEED_NONE_PTE;
> -                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +                               if (order =3D=3D HPAGE_PMD_ORDER)
> +                                       count_vm_event(THP_SCAN_EXCEED_NO=
NE_PTE);
> +                               count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_NONE);
>                                 goto out;
>                         }
>                 }
> @@ -633,10 +635,17 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>                          * shared may cause a future higher order collaps=
e on a
>                          * rescan of the same range.
>                          */
> -                       if (order !=3D HPAGE_PMD_ORDER || (cc->is_khugepa=
ged &&
> -                           shared > khugepaged_max_ptes_shared)) {
> +                       if (order !=3D HPAGE_PMD_ORDER) {
> +                               result =3D SCAN_EXCEED_SHARED_PTE;
> +                               count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
> +                               goto out;
> +                       }
> +
> +                       if (cc->is_khugepaged &&
> +                           shared > khugepaged_max_ptes_shared) {
>                                 result =3D SCAN_EXCEED_SHARED_PTE;
>                                 count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> +                               count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
>                                 goto out;
>                         }
>                 }
> @@ -1084,6 +1093,7 @@ static int __collapse_huge_page_swapin(struct mm_st=
ruct *mm,
>                  * range.
>                  */
>                 if (order !=3D HPAGE_PMD_ORDER) {
> +                       count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_=
SWAP);
>                         pte_unmap(pte);
>                         mmap_read_unlock(mm);
>                         result =3D SCAN_EXCEED_SWAP_PTE;
> --
> 2.50.1
>

