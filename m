Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFE23817E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048525; cv=none; b=rnrt1PxBXzlOVX9B8z+LWwDPc4tpvjZp1JCD7ROV6FI7JHFDgT0t0kmgl+vsaIddL36gZgo37CaEjdrvXUqNoH7sOeF0VOfJtQQw2NMWN9iTM5JWuxQL2bIAqkuL9juGkR8k0iM01Y+78dBT1YzomoP/zLonkZOOHv8KP4Sx+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048525; c=relaxed/simple;
	bh=WDSkU69d23oA41r26eTbNiLbIMezYo2HY98fcr2R7cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOoPiew/3Dac3UJ7LzSVE7bPt9KMvGK0hWbvc6gDZUWgOH2RqLlhVnD8pmDWRZf7JgMvBh5mPwiGrfkIdrzPhFYwV9tRMbmzbu4qOvdd6o7w/6mfgyEhbWREmkhLpQRjI7i5p+g7aR8vKJpaie5Rcl9mkdly5jZG11qfXc0K2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WudvJZ66; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WudvJZ66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776048522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipq+oq6oBakti4FTC7ep+u1PWOX2wbuMMxX1sQWOxoU=;
	b=WudvJZ66etcg8OZP4505cnHQPzjCcTQeL2HpRQuXL3SMrvwSiTxfY8+IsXBjeCanJUQTgg
	YKSbHh92s6r4AMs3FZc6i+pN47w326A2nY4q9/BQ6efr4EkbyvkYTFMa5qn3c241KeL9Zl
	W7UyNCOCAaW3z/K1U0q3Qo99JnfCq5g=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-_bxl0qzNO0WeWbKkiP0Tkg-1; Sun, 12 Apr 2026 22:48:41 -0400
X-MC-Unique: _bxl0qzNO0WeWbKkiP0Tkg-1
X-Mimecast-MFC-AGG-ID: _bxl0qzNO0WeWbKkiP0Tkg_1776048520
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64eb0bbab48so7892545d50.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 19:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048520; x=1776653320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipq+oq6oBakti4FTC7ep+u1PWOX2wbuMMxX1sQWOxoU=;
        b=C+RLkxseic2zRx0GlyQXjY34pMYhOMo8SKxExkym9vnQNJvkp5V481mJoSwY7LkOVu
         hfpUT2DOZA0bWn33crokNOkc/rp36xrMwZEFivmN4GjKKSlel4bqlBo+25b60e0nhtDh
         yT8PALQ66V9ioegCLsrXBa04jl1i6B2ajJ2uaazyK4YaYpQnq0j6z7BnSvPQLs1G+cu5
         HlGyzECrLNfpPBjI4uzp8RCPhtgutQp3pTrbdCKZ/gur9A05vO7PUsVzM/hyNhH8Y+TV
         gJ4hHXosDIVg75uSo7b/gXT/d0bhM4TXaJklqu/27vVlA1VI1hLML72Gxv0D80EYbWb+
         oygA==
X-Forwarded-Encrypted: i=1; AFNElJ/LG+ZCpGPsPqESoBu64OiDO9KIxpF5A0xIFMVOo2C/ghU7ha2lWmjFr4gNhJFJtF2Aw+lu2DSaXsisQ4bK2DWnSGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9swSANHfLfk2Z+L68PWO2tX/mhN0jHL4CuMvwuylHJktx1ta
	nOsLTMwQ/ESDsA8f21PhbjnNIwslfiQ9iFu/CqwEtVqKENB5bv0g1qhBEo5HnubljC7ncPg+3g1
	TXdMnyhPDUl68xhbDQGnmZYNFFu+ddq0mtHRGRx97yEAB7JDSP+5HFgJP/A/TpzoPSCPgOTY+wp
	pOnEwjqSB0BjQXvW4r/aFDFji6Yqxl4gdDiGYtxFBarc9kA4gl
X-Gm-Gg: AeBDietYHMus6lm7bxUoRF2nkShR9RhXlRLxBtAVAyWFFqrhwASzo7gpxXAQ3SU4dDa
	E4cYGDXeQtXyz5FkkIrilC1ITQNBTQ3gJdap7jgywh+SQr0nmfEDDd5WfoLiXVA1gKyWNCAdMOh
	gQnyHMOMnD0Kcm7ctxVigFeYsaJf944i2ox+lualu7R55W/h6u0GSD7LYbastrHKobQGOebMOZ0
	UStbRLg
X-Received: by 2002:a05:690e:4849:b0:64e:e6ca:1564 with SMTP id 956f58d0204a3-6518724af28mr8403936d50.34.1776048520495;
        Sun, 12 Apr 2026 19:48:40 -0700 (PDT)
X-Received: by 2002:a05:690e:4849:b0:64e:e6ca:1564 with SMTP id
 956f58d0204a3-6518724af28mr8403906d50.34.1776048520015; Sun, 12 Apr 2026
 19:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226031741.230674-1-npache@redhat.com> <20260226032504.233594-1-npache@redhat.com>
 <c832d503-8b8c-487a-b61a-df74a3057308@lucifer.local>
In-Reply-To: <c832d503-8b8c-487a-b61a-df74a3057308@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Sun, 12 Apr 2026 20:48:29 -0600
X-Gm-Features: AQROBzAnrSbSKarMGYOQfjR0CAwy4v95QjUC8UMaaOKZsxklTcr1VSvGMtYqDEU
Message-ID: <CAA1CXcCS9gWySN1oQzEYpALfURxBwt58us9tkAbNPnHOKmLd5g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v15 07/13] mm/khugepaged: add per-order mTHP
 collapse failure statistics
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
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
X-Mimecast-MFC-PROC-ID: 68UcNcoHqS3DYDzuh033aHzsuoWz_H0r7uBzFAKCTto_1776048520
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 11:05=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Wed, Feb 25, 2026 at 08:25:04PM -0700, Nico Pache wrote:
> > Add three new mTHP statistics to track collapse failures for different
> > orders when encountering swap PTEs, excessive none PTEs, and shared PTE=
s:
> >
> > - collapse_exceed_swap_pte: Increment when mTHP collapse fails due to s=
wap
> >       PTEs
> >
> > - collapse_exceed_none_pte: Counts when mTHP collapse fails due to
> >       exceeding the none PTE threshold for the given order
> >
> > - collapse_exceed_shared_pte: Counts when mTHP collapse fails due to sh=
ared
> >       PTEs
> >
> > These statistics complement the existing THP_SCAN_EXCEED_* events by
> > providing per-order granularity for mTHP collapse attempts. The stats a=
re
> > exposed via sysfs under
> > `/sys/kernel/mm/transparent_hugepage/hugepages-*/stats/` for each
> > supported hugepage size.
> >
> > As we currently dont support collapsing mTHPs that contain a swap or
> > shared entry, those statistics keep track of how often we are
> > encountering failed mTHP collapses due to these restrictions.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 24 ++++++++++++++++++++++
> >  include/linux/huge_mm.h                    |  3 +++
> >  mm/huge_memory.c                           |  7 +++++++
> >  mm/khugepaged.c                            | 16 ++++++++++++---
> >  4 files changed, 47 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index c51932e6275d..eebb1f6bbc6c 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -714,6 +714,30 @@ nr_anon_partially_mapped
> >         an anonymous THP as "partially mapped" and count it here, even =
though it
> >         is not actually partially mapped anymore.
> >
> > +collapse_exceed_none_pte
> > +       The number of collapse attempts that failed due to exceeding th=
e
> > +       max_ptes_none threshold. For mTHP collapse, Currently only max_=
ptes_none
> > +       values of 0 and (HPAGE_PMD_NR - 1) are supported. Any other val=
ue will
> > +       emit a warning and no mTHP collapse will be attempted. khugepag=
ed will
>
> It's weird to document this here but not elsewhere in the document? I mea=
n I
> made this comment on the documentation patch also.

I can add some more documentation but TBH I don't really know where or
what else to put. I checked a few of these other per-mTHP stats, and
none are referenced elsewhere. if anything these 3 additions are the
best documented ones.

>
> Not sure if I missed you adding it to another bit of the docs? :)
>
> > +       try to collapse to the largest enabled (m)THP size; if it fails=
, it will
> > +       try the next lower enabled mTHP size. This counter records the =
number of
> > +       times a collapse attempt was skipped for exceeding the max_ptes=
_none
> > +       threshold, and khugepaged will move on to the next available mT=
HP size.
> > +
> > +collapse_exceed_swap_pte
> > +       The number of anonymous mTHP PTE ranges which were unable to co=
llapse due
> > +       to containing at least one swap PTE. Currently khugepaged does =
not
> > +       support collapsing mTHP regions that contain a swap PTE. This c=
ounter can
> > +       be used to monitor the number of khugepaged mTHP collapses that=
 failed
> > +       due to the presence of a swap PTE.
> > +
> > +collapse_exceed_shared_pte
> > +       The number of anonymous mTHP PTE ranges which were unable to co=
llapse due
> > +       to containing at least one shared PTE. Currently khugepaged doe=
s not
> > +       support collapsing mTHP PTE ranges that contain a shared PTE. T=
his
> > +       counter can be used to monitor the number of khugepaged mTHP co=
llapses
> > +       that failed due to the presence of a shared PTE.
>
> All of these talk about 'ranges' that could be of any size. Are these use=
ful
> metrics? Counting a bunch of failures and not knowing if they are 256 KB
> failures or 16 KB failures or whatever is maybe not so useful information=
?

These are per-mTHP size statistics. If you look at the surrounding
examples and docs this all makes more sense.

>
> Also, from the code, aren't you treating PMD events the same as mTHP ones=
 from
> the point of view of these counters? Maybe worth documenting that?

IIUC, yes but that is true of all these

```
In /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/stats, There are
also individual counters for each huge page size, which can be utilized to
monitor the system's effectiveness in providing huge pages for usage. Each
counter has its own corresponding file.
```

>
> > +
> >  As the system ages, allocating huge pages may be expensive as the
> >  system uses memory compaction to copy data around memory to free a
> >  huge page for use. There are some counters in ``/proc/vmstat`` to help
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 9941fc6d7bd8..e8777bb2347d 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -144,6 +144,9 @@ enum mthp_stat_item {
> >       MTHP_STAT_SPLIT_DEFERRED,
> >       MTHP_STAT_NR_ANON,
> >       MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> > +     MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> > +     MTHP_STAT_COLLAPSE_EXCEED_NONE,
> > +     MTHP_STAT_COLLAPSE_EXCEED_SHARED,
> >       __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 228f35e962b9..1049a207a257 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -642,6 +642,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLI=
T_FAILED);
> >  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >  DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
> >  DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PART=
IALLY_MAPPED);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXC=
EED_SWAP);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXC=
EED_NONE);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_E=
XCEED_SHARED);
>
> Is there a reason there's such a difference between the names and the act=
ual
> enum names?

Good point I didnt think about that. I can update those as long as
they don't conflict with something else (I forget why i named them
like this).

>
> > +
> >
> >  static struct attribute *anon_stats_attrs[] =3D {
> >       &anon_fault_alloc_attr.attr,
> > @@ -658,6 +662,9 @@ static struct attribute *anon_stats_attrs[] =3D {
> >       &split_deferred_attr.attr,
> >       &nr_anon_attr.attr,
> >       &nr_anon_partially_mapped_attr.attr,
> > +     &collapse_exceed_swap_pte_attr.attr,
> > +     &collapse_exceed_none_pte_attr.attr,
> > +     &collapse_exceed_shared_pte_attr.attr,
> >       NULL,
> >  };
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index c739f26dd61e..a6cf90e09e4a 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -595,7 +595,9 @@ static enum scan_result __collapse_huge_page_isolat=
e(struct vm_area_struct *vma,
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > -                             count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> > +                             if (is_pmd_order(order))
> > +                                     count_vm_event(THP_SCAN_EXCEED_NO=
NE_PTE);
> > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_NONE);
>
> It's a bit gross to have separate stats for both thp and mthp but maybe
> unavoidable from a legacy stand point.

I agree but that's how it currently is. Perhaps we can add this to the
TODO list for THP work.

>
> Why are we dropping the _PTE suffix?

I follow the convention that the other mTHP stats follow for example
(MTHP_STAT_SPLIT_DEFERRED)

>
> >                               goto out;
> >                       }
> >               }
> > @@ -631,10 +633,17 @@ static enum scan_result __collapse_huge_page_isol=
ate(struct vm_area_struct *vma,
> >                        * shared may cause a future higher order collaps=
e on a
> >                        * rescan of the same range.
> >                        */
> > -                     if (!is_pmd_order(order) || (cc->is_khugepaged &&
> > -                         shared > khugepaged_max_ptes_shared)) {
>
> OK losing track here :) as the series sadly doesn't currently apply so ca=
n't
> browser file as is.
>
> In the code I'm looking at, there's also a ++shared here that I guess ano=
ther
> patch removed?
>
> Is this in the folio_maybe_mapped_shared() branch?

yes the counting is now done at the top of that branch.

>
> > +                     if (!is_pmd_order(order)) {
> > +                             result =3D SCAN_EXCEED_SHARED_PTE;
> > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
> > +                             goto out;
> > +                     }
> > +
> > +                     if (cc->is_khugepaged &&
> > +                         shared > khugepaged_max_ptes_shared) {
> >                               result =3D SCAN_EXCEED_SHARED_PTE;
> >                               count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
> >                               goto out;
>
> Anyway I'm a bit lost on this logic until a respin but this looks like a =
LOT of
> code duplication. I see David alluded to a refactoring so maybe what he s=
uggests
> will help (not had a chance to check what it is specifically :P)

Yep :) should look cleaner in the next one. Although it's quite a bit
of refactoring. I'll be praying that i got it right on the first go,
and I put all the other pieces in the desired spot.

>
> >                       }
> >               }
> > @@ -1081,6 +1090,7 @@ static enum scan_result __collapse_huge_page_swap=
in(struct mm_struct *mm,
> >                * range.
> >                */
> >               if (!is_pmd_order(order)) {
> > +                     count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_=
SWAP);
>
> Hmm I thought we were incrementing mthp stats for pmd sized also?

Yes we are supposed to. I've already refactored and it looks fine
there... perhaps i missed this one in this version!

Cheers,

-- Nico

>
> >                       pte_unmap(pte);
> >                       mmap_read_unlock(mm);
> >                       result =3D SCAN_EXCEED_SWAP_PTE;
> > --
> > 2.53.0
> >
>
> Cheers, Lorenzo
>

