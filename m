Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B927B4F7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719596; cv=none; b=psO1XUsVTfA+VWJAaloS/heNwoSbvXwB6gqrmmEUyusgE5QA/hZYD/62h4pi1GfGevBEZOLbro2fdxoKve4TukKx0UEFVvDwde+MjVzya13OxbW+HIUmPO6mmoExwc0mNLNDuBolQJUrzhFDIKL0jtwabfBA77GIUAQrU0vFYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719596; c=relaxed/simple;
	bh=RUkRli7PaRf5LNeLB4V9FNYl+iBZf3baaMUpWMMuQ84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgeQ9AXRnhCx8ZuM+9JLX8muWa1I8PONsUDmN+wgc5yuP6URsVF4nny/8LvWoAHEL0SpHxzv4syszSSDDtSLwXCSz9ViI5aH9s+mduabnKsNl66BPf5kaYp4xLLcuwzTv9uTE67tvU9jMkBvoRqIaZI9pphlfwIjDLTr+vXRqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBDWP43g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBDWP43g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757719591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYya9fW1mJvYJ3jPqwJBitUidkWXto77tPEtahloeFg=;
	b=FBDWP43gpSVYXyQCUEMEN/1bgKqbNUqUIFZdSGzPeR+octA38Mbxs6Kb5UHhmXU1fjf4Ce
	vMlZNQUgLzwdgCzLmZ8G8/0WpWL7em80LqYjF7r9G2aL6X2kSgR5HKuxwd7MVVSlqaRbD1
	eOoF6+v9KxtBReFg+lwyrNIZj5yYm3o=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-1mZdstFEP7u4p9MuCx60WQ-1; Fri, 12 Sep 2025 19:26:30 -0400
X-MC-Unique: 1mZdstFEP7u4p9MuCx60WQ-1
X-Mimecast-MFC-AGG-ID: 1mZdstFEP7u4p9MuCx60WQ_1757719590
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6119ec806f9so2137017d50.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719590; x=1758324390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYya9fW1mJvYJ3jPqwJBitUidkWXto77tPEtahloeFg=;
        b=c/TyXls8C/NN5wlgLgmN6XdZAYc6nISaW050ZOjeQiFP6N2v+vLopjYvaH5/u4KzWG
         ROGcHzcKRTXHGW85rts19pDimurnzGXZceq/UfqcTWppf0FSTn89ffT6X6kFGC3Gse51
         PJFkyy7YwZY/L5jnhGAw8BU3X8O4sFRNuVwS5W7qytGuGOAtbKock4ZR2UWB0Qgtxlkc
         fgUcZnZ5rwq/tn7hMIodAxh6rEu5PlyDZIkAYBeCbcZ3JyEUGhgONY4VWZU7MamCOch7
         e36LRhHFCEpCSUUCg8AjhoE1FAx950G+TxzT5y62zW/Q7qpcwhYm4g5Gi4HLTRFA84nv
         jO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZG9CrtrWLpYeUX5+XDSffm9wunjnlV7tO3oLHFclmkm48TXekID0BSuf0/GY127x0VRKS6b9c8orlQzjfifKN8aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRTVeUxjbuCwiifaKvwX1Ov5gCG5D3zTtpn8Gs3ihuwAZTntx
	PMef84i73D3QYwWv2aAJgx6OjYWnXOqRlXc9GUTBM/miEfxc8kEHN+BQYtA6wyhfYGxiLH6NI+a
	ZMKnBwApcAxgUR0a4FDunR4KJjvFWWzxNrVcUe8sX50AVIgbRTCKc/eeAtGWHPRSTCLUUyC/hEh
	MVpTDg5qOEYASnzKlIhCDDmFf/xf2UK04BCNdpiNcmv4LzD4ff
X-Gm-Gg: ASbGncs569XEhYt6TkGRGSQM9ZH7Fjy85u5h4JT5Kq4po9Oh70W1rqiBvnHQ1Yk9tX2
	zthslhrC4T6AqTnhk+T2z4bMCe1sERVZMx3Q0qPP2QkTjF1Swqkt/CcAVzY5+FwFsp0WH0nL4ZG
	oDsZQkz+EC/MhXWJxkKxh7Ozkbsj8ub0ga+8s=
X-Received: by 2002:a53:c949:0:b0:623:696e:39c6 with SMTP id 956f58d0204a3-62724632d67mr3454867d50.35.1757719589814;
        Fri, 12 Sep 2025 16:26:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4AnimwV4DJpIrzY5zDni7Ex/wppWCYlFBHUNbQWqcehb1JqlslO2cG7IpWR63nH0AcJL1oIrwAvdwGrMu0Z8=
X-Received: by 2002:a53:c949:0:b0:623:696e:39c6 with SMTP id
 956f58d0204a3-62724632d67mr3454856d50.35.1757719589379; Fri, 12 Sep 2025
 16:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912032810.197475-1-npache@redhat.com> <20250912032810.197475-7-npache@redhat.com>
 <4e1fef74-f369-439e-83ff-c50f991c834e@lucifer.local>
In-Reply-To: <4e1fef74-f369-439e-83ff-c50f991c834e@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Fri, 12 Sep 2025 17:26:03 -0600
X-Gm-Features: Ac12FXw8kuzu15sT3828_sGKN1OjxWfPvlvmcTocIEno-x-VWWBe1uDeooNmQyg
Message-ID: <CAA1CXcCugu0C3s2V1GcZZC=WksiNy8vkomHCcdvtGKfhxhoyfw@mail.gmail.com>
Subject: Re: [PATCH v11 06/15] khugepaged: introduce collapse_max_ptes_none
 helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SDGIi3o3iyHYAQhuWx0RJpV2vkM0ejDMFxAbHdQarUE_1757719590
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:36=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Sep 11, 2025 at 09:28:01PM -0600, Nico Pache wrote:
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
>
> I would say very clearly that this is only in the mTHP case.

ack, I stole most of the verbiage here from other notes I've
previously written, but it can be improved.

>
>
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> Hmm I thought we were going to wait for David to investigate different
> approaches to this?
>
> This is another issue with quickly going to another iteration. Though I d=
o think
> David explicitly said he'd come back with a solution?

Sorry I thought that was being done in lockstep. The last version was
about a month ago and I had a lot of changes queued up. Now that we
have collapse_max_pte_none() David has a much easier entry point to
work off :)

I think he will still need this groundwork for the solution he is
working on with "eagerness". if 10 -> 511, and 9 ->255, ..., 0 -> 0.
It will still have to do the scaling. Although I believe 0-10 should
be more like 0-5 mapping to 0,32,64,128,255,511

>
> So I'm not sure why we're seeing this solution here? Unless I'm missing
> something?
>
> > ---
> >  mm/khugepaged.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b0ae0b63fc9b..4587f2def5c1 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -468,6 +468,26 @@ void __khugepaged_enter(struct mm_struct *mm)
> >               wake_up_interruptible(&khugepaged_wait);
> >  }
> >
> > +/* Returns the scaled max_ptes_none for a given order.
>
> We don't start comments at the /*, please use a normal comment format lik=
e:
ack
>
> /*
>  * xxxx
>  */
>
> > + * Caps the value to HPAGE_PMD_NR/2 - 1 in the case of mTHP collapse t=
o prevent
>
> This is super unclear.
>
> It start with 'caps the xxx' which seems like you're talking generally.
>
> You should say very clearly 'For PMD allocations we apply the
> khugepaged_max_ptes_none parameter as normal. For mTHP ... [details about=
 mTHP].
ack I will clean this up.
>
> > + * a feedback loop. If max_ptes_none is greater than HPAGE_PMD_NR/2, t=
he value
> > + * would lead to collapses that introduces 2x more pages than the orig=
inal
> > + * number of pages. On subsequent scans, the max_ptes_none check would=
 be
> > + * satisfied and the collapses would continue until the largest order =
is reached
> > + */
>
> This is a super vauge explanation. Please describe the issue with creep m=
ore
> clearly.
ok I will try to come up with something clearer.
>
> Also aren't we saying that 511 or 0 are the sensible choices? But now som=
ehow
> that's not the case?
Oh I stated I wanted to propose this, and although there was some
pushback I still thought it deserved another attempt. This still
allows for some configurability, and with David's eagerness toggle
this still seems to fit nicely.
>
> You're also not giving a kdoc info on what this returns.
Ok I'll add a kdoc here, why this function in particular, I'm trying
to understand why we dont add kdocs on other functions?
>
> > +static int collapse_max_ptes_none(unsigned int order)
>
> It's a problem that existed already, but khugepaged_max_ptes_none is an u=
nsigned
> int and this returns int.
>
> Maybe we should fix this while we're at it...
ack
>
> > +{
> > +     int max_ptes_none;
> > +
> > +     if (order !=3D HPAGE_PMD_ORDER &&
> > +         khugepaged_max_ptes_none >=3D HPAGE_PMD_NR/2)
> > +             max_ptes_none =3D HPAGE_PMD_NR/2 - 1;
> > +     else
> > +             max_ptes_none =3D khugepaged_max_ptes_none;
> > +     return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> > +
> > +}
> > +
>
> I really don't like this formulation, you're making it unnecessarily uncl=
ear and
> now, for the super common case of PMD size, you have to figure out 'oh it=
's this
> second branch and we're subtracting HPAGE_PMD_ORDER from HPAGE_PMD_ORDER =
so just
> return khugepaged_max_ptes_none'. When we could... just return it no?
>
> So something like:
>
> #define MAX_PTES_NONE_MTHP_CAP (HPAGE_PMD_NR / 2 - 1)
>
> static unsigned int collapse_max_ptes_none(unsigned int order)
> {
>         unsigned int max_ptes_none_pmd;
>
>         /* PMD-sized THPs behave precisely the same as before. */
>         if (order =3D=3D HPAGE_PMD_ORDER)
>                 return khugepaged_max_ptes_none;
>
>         /*
>         * Bizarrely, this is expressed in terms of PTEs were this PMD-siz=
ed.
>         * For the reasons stated above, we cap this value in the case of =
mTHP.
>         */
>         max_ptes_none_pmd =3D MIN(MAX_PTES_NONE_MTHP_CAP,
>                 khugepaged_max_ptes_none);
>
>         /* Apply PMD -> mTHP scaling. */
>         return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> }
yeah that's much cleaner thanks!
>
> >  void khugepaged_enter_vma(struct vm_area_struct *vma,
> >                         vm_flags_t vm_flags)
> >  {
> > @@ -554,7 +574,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >       struct folio *folio =3D NULL;
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> > -     int scaled_max_ptes_none =3D khugepaged_max_ptes_none >> (HPAGE_P=
MD_ORDER - order);
> > +     int scaled_max_ptes_none =3D collapse_max_ptes_none(order);
> >       const unsigned long nr_pages =3D 1UL << order;
> >
> >       for (_pte =3D pte; _pte < pte + nr_pages;
> > --
> > 2.51.0
> >
>
> Thanks, Lorenzo
>

