Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097E330B2B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658658; cv=none; b=DtywZ9ir+oxSuEm6yj2UERIN4LwRRyAUgxTBBMPVDWjYiDcQ51tAvg+cR8I1cUsteFSufEVDGNZVCX5zeSeaDXr6b3iT/fldPxoX5KYkqwaWzwXZ//yN6bJlZS1rqrx+rH8wJxlMVl5TiSGVBsfIwBBybmcafriJc/tqUpC+sVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658658; c=relaxed/simple;
	bh=iI1dQYUcLDLsvExCrEZOOSIuT6HyPYHdpTI6JcB9SLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5KdmtSt0/XDj5jHNxsZT59pLFDm2Ou1EERcev1Cgx0gMSjGqAQiTV2ZjGdjZw+cplgg6edcn2uS/lxlkCpTBVGXqhBCUdnMLvJjPC2R1cMdSR2RKh915PPPg5+1DLy6HxggHmXPYLIVfSFtgIK01Cl2RVM3G99Vpe3vg/BOjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bmt8Y89v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bmt8Y89v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761658646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=391BPTjMq7U4Si7/L0Y5C310VmT6EKvmZL7j8j+OpFA=;
	b=Bmt8Y89vDdDhMNLQEizpyKcy4kp2u4kHR9UCCENHkhrkVs6E8em48dCgu+GBH+Y7oR1siT
	LUl+LcEmx9so6i+VZEdkFIsJpKx288uEY/E09A0xguYWvK8iC3NDHN8c6Rjs8dD+EXQL9L
	f3VnPSVzOi45fp8HrhX6iw9+gaYrlQo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-MIdwMvV_MwulkmOmeWbuQQ-1; Tue, 28 Oct 2025 09:37:22 -0400
X-MC-Unique: MIdwMvV_MwulkmOmeWbuQQ-1
X-Mimecast-MFC-AGG-ID: MIdwMvV_MwulkmOmeWbuQQ_1761658641
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-782c219f163so83192387b3.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658641; x=1762263441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=391BPTjMq7U4Si7/L0Y5C310VmT6EKvmZL7j8j+OpFA=;
        b=dPiSDbQS3KHy0UnmEwnNMfsR6Ysrvv3DNmb3fX4Rf/XYvxeHQZ9pqPNdeTaI0peQaG
         tSgDqB25xfk/NwGKFPw/51N7I50SlDIkzqygjvMnqnz92ya1275Tsy4VChla7CCBp22P
         ve7VZFD5jTOR/2CX5ki/3Tca4XrkokynHi8G3h5IpETIsyY8ubUYh1cFAfhCX2H5RK+W
         4F5fj5nvKtPzqltWvTeN8oZS4ouI1JZuuZgpglf3Cff5xCpIRthA+ZIWRYQrvwm5AMJ6
         yecZJtyvPjwK8Hj6ep0FVz71aIc9CCi1k/CITypNNmn2g/tRq6omYDFnUrECeYPfgGV8
         goNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV39RMIe3UOjEljO9e3CQkIXsksWq40ucJiYvkYvd+tgGuzJQH855Mi+PTS7j9oZIUuBGxDvbVqvXJ8lo3Rosrq0OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx308CZcB55KII2eV9UOWPUrjWTmMJUllxF76FcXlOcheEncMjr
	L6gZN+lYxMMPe1fDcx0ilcvzzbTIjZGKmgukpEBq3HFuXMUELoztACYr9vXVoyRPTU2TM62mwxc
	bbPqBOcZiN7fSFCCKewhTNGZhq80cIiwK+ldNad5DK5uV3E2tCqh7P0VjJk2S5sX6JkQEbXrtAe
	Rm66jQSkQ0d73GMEgtBIlISzgfTsf0fW4tH66k2kpmqD+GFcyG1KCKNQPHKF/Weg==
X-Gm-Gg: ASbGnctEQNmMRmtc4JDXZRxxfM/HWiMPNYnzqOLKe2xM06w3IPDfWx6/9neCuB4sPmo
	rOX0kdsT5P9NA/i7XH10QaoQdhoQ0exFnID3HN3xmOKB1Fpodk/weCvAFGybwEsEg10nHQoboo/
	akUS7rV3akjYRxgrTcb3kdgibRwL1jlH/blv7sVEtGLGN8e+BRmVG7bfM1Ng6TULWZLgsGXw==
X-Received: by 2002:a53:cd41:0:b0:63c:f5a6:f2ef with SMTP id 956f58d0204a3-63f6bab5662mr2132928d50.65.1761658641289;
        Tue, 28 Oct 2025 06:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI5+9/fHp4gwqVR+X5FCEMvrHe+GcwlBX4w2Wql+/7C/fl5yLGrv62o9V5yeHttxzVZEf22GwHT7NBFpcz7XM=
X-Received: by 2002:a53:cd41:0:b0:63c:f5a6:f2ef with SMTP id
 956f58d0204a3-63f6bab5662mr2132906d50.65.1761658640837; Tue, 28 Oct 2025
 06:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
In-Reply-To: <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Tue, 28 Oct 2025 07:36:55 -0600
X-Gm-Features: AWmQ_bmW8XylmR-fGz7b8D2DLOax1IHPOfKa83653zAJ0iAfVZ2XGu7NC_3nK0A
Message-ID: <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p_17I_6aPfGjRt0B07VTGujcD3_FYPQ0cAzmQycnaX4_1761658641
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 11:54=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:37:08PM -0600, Nico Pache wrote:
> > The current mechanism for determining mTHP collapse scales the
> > khugepaged_max_ptes_none value based on the target order. This
> > introduces an undesirable feedback loop, or "creep", when max_ptes_none
> > is set to a value greater than HPAGE_PMD_NR / 2.
> >
> > With this configuration, a successful collapse to order N will populate
> > enough pages to satisfy the collapse condition on order N+1 on the next
> > scan. This leads to unnecessary work and memory churn.
> >
> > To fix this issue introduce a helper function that caps the max_ptes_no=
ne
> > to HPAGE_PMD_NR / 2 - 1 (255 on 4k page size). The function also scales
> > the max_ptes_none number by the (PMD_ORDER - target collapse order).
> >
> > The limits can be ignored by passing full_scan=3Dtrue, this is useful f=
or
> > madvise_collapse (which ignores limits), or in the case of
> > collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
> > collapse is available.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 4ccebf5dda97..286c3a7afdee 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -459,6 +459,39 @@ void __khugepaged_enter(struct mm_struct *mm)
> >               wake_up_interruptible(&khugepaged_wait);
> >  }
> >
> > +/**
> > + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for c=
ollapse
> > + * @order: The folio order being collapsed to
> > + * @full_scan: Whether this is a full scan (ignore limits)
> > + *
> > + * For madvise-triggered collapses (full_scan=3Dtrue), all limits are =
bypassed
> > + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
> > + *
> > + * For PMD-sized collapses (order =3D=3D HPAGE_PMD_ORDER), use the con=
figured
> > + * khugepaged_max_ptes_none value.
> > + *
> > + * For mTHP collapses, scale down the max_ptes_none proportionally to =
the folio
> > + * order, but caps it at HPAGE_PMD_NR/2-1 to prevent a collapse feedba=
ck loop.
> > + *
> > + * Return: Maximum number of empty PTEs allowed for the collapse opera=
tion
> > + */
> > +static unsigned int collapse_max_ptes_none(unsigned int order, bool fu=
ll_scan)
> > +{
> > +     unsigned int max_ptes_none;
> > +
> > +     /* ignore max_ptes_none limits */
> > +     if (full_scan)
> > +             return HPAGE_PMD_NR - 1;
> > +
> > +     if (order =3D=3D HPAGE_PMD_ORDER)
> > +             return khugepaged_max_ptes_none;
> > +
> > +     max_ptes_none =3D min(khugepaged_max_ptes_none, HPAGE_PMD_NR/2 - =
1);
>

Hey Lorenzo,

> I mean not to beat a dead horse re: v11 commentary, but I thought we were=
 going
> to implement David's idea re: the new 'eagerness' tunable, and again we'r=
e now just
> implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?

I spoke to David and he said to continue forward with this series; the
"eagerness" tunable will take some time, and may require further
considerations/discussion.

>
> I'm still really quite uncomfortable with us silently capping this value.
>
> If we're putting forward theoretical ideas that are to be later built upo=
n, this
> series should be an RFC.
>
> But if we really intend to silently ignore user input the problem is that=
 then
> becomes established uAPI.
>
> I think it's _sensible_ to avoid this mTHP escalation problem, but the is=
sue is
> visibility I think.
>
> I think people are going to find it odd that you set it to something, but=
 then
> get something else.

The alternative solution is to not support max_ptes_none for mTHP
collapse and not allow none/zero pages. This is essentially "capping"
the value too.

>
> As an alternative we could have a new sysfs field:
>
> /sys/kernel/mm/transparent_hugepage/khugepaged/max_mthp_ptes_none
>
> That shows the cap clearly.
>
> In fact, it could be read-only... and just expose it to the user. That re=
duces
> complexity.

I agree with Baolin here; adding another tunable will only increase
the complexity for our future goals, and also provides needless
insight into the internals when they can not be customized.

Cheers,
-- Nico

>
> We can then bring in eagerness later and have the same situation of
> max_ptes_none being a parameter that exists (plus this additional read-on=
ly
> parameter).
>
> > +
> > +     return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> > +
> > +}
> > +
> >  void khugepaged_enter_vma(struct vm_area_struct *vma,
> >                         vm_flags_t vm_flags)
> >  {
> > @@ -546,7 +579,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> >       const unsigned long nr_pages =3D 1UL << order;
> > -     int max_ptes_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDE=
R - order);
> > +     int max_ptes_none =3D collapse_max_ptes_none(order, !cc->is_khuge=
paged);
> >
> >       for (_pte =3D pte; _pte < pte + nr_pages;
> >            _pte++, addr +=3D PAGE_SIZE) {
> > --
> > 2.51.0
> >
>

