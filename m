Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD038E132
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241205; cv=none; b=SV2xOji/s2B7Mx8SitIyVXx0TF2P0cCwg6w4wf05Mi+M4CXKtcWVkVjzYJ5adqJW3XntlnUCND0gaVkS3PQiBh62+TGFXrO3xgo8e21b1Sz6+7AppeVdolpEyPc3I03qWodI1BwTMElM9zmXWtlyD986MAqNICUJ+sgkdFHFU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241205; c=relaxed/simple;
	bh=sBrgGJZeRGpCcKQa1Nkipjs2qjlNQKQCOxzY/hPe9PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM7Z4T1/CggOwwxdqd4bvDwtXalkvcAnqrmX9+j31WM7/9ie6A3jHsUmHjufKYBlqmfFa8wj1n7ZuraoKM6zaHZiNo4JbX95aLNYc7EwAGn85mbp03m6/a7Yl0SbZKNSWkAJVCbf8+B0TpmHsSRnM2bv2KitQf222jS2015e5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+rq3QUq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+rq3QUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770241203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/RRR9VLmVAaUDYnt9wwOlgiAGyPDV2RrmGH4fySXkM=;
	b=H+rq3QUq7yFQKzoOoXgxlk1HrXIqMYFuJUol+k9c//HPvef+VsnHKa5FQC9sIdIjEtAUjW
	9nsQoYFFt3n6p6lddTSRIWE3KnUc8jGc9I8czTpkq9qJW90oJUEYQ/tjCZRP976WgoHQtJ
	1T8h0hTAalB5V7geQUsOO6sMtEAKXp4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-jXae7CnlPCuWin_kei8dpQ-1; Wed, 04 Feb 2026 16:40:02 -0500
X-MC-Unique: jXae7CnlPCuWin_kei8dpQ-1
X-Mimecast-MFC-AGG-ID: jXae7CnlPCuWin_kei8dpQ_1770241202
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-794ae9fc4dfso3646207b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 13:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241202; x=1770846002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/RRR9VLmVAaUDYnt9wwOlgiAGyPDV2RrmGH4fySXkM=;
        b=oN0CtWv4Jzerr4h6fGBLkA4p9NJAVsUMFrv9g0lbTIeiM0C7k9DplC5AMVIDrnsy8W
         thgR2HuTOis+e8mX/YhUmCXHINbe4Hva7gfuDKpcra52nsQUiKk6nQUxwXhSs6y4kBrv
         Uq2uGVlOpECMKgLk8cPAefWGDzzOrRNs0D2la6e658gO6o3yyk7jdHgeZWoRO3qyQMaK
         3oszOi+4epUuK24F6Op71XGuGPi7SOxUv/E3fQwjqjg1rD0xQ8M8pjGfeK/WkqcmWnNO
         L/FWFUL+fbBmVUQbud9GW5791YBVXQSJti5NIBsj/x5dJK3fw24IJePevmdZiTHvoPdj
         BNCg==
X-Forwarded-Encrypted: i=1; AJvYcCWirMPduPl+Y7NcAxOz8Uu5rakAbww9ZGh8TVSHqmIoK878shR0wsAw4lQz6LQNNRCRpqVYgjNA9JwXq8rAtU9GXCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JXHCS3Uhd9yRGBMEaVyhrPWOnJhsFaNn1mXMIN6gIoNqERdU
	Nv7ccGjT+rSs42Z16hfHaZVaSdy5P2NCLvxnZBCLRdO1InfhQNozA3PR6hKzhDVmfZfVKGtj/Lc
	cll5VZArxiZQKQbhNP103kTl3cHH8dgUjZce9kO+YPu49PY4m1TTRxMaVk4C9o3CiraEbh3lR4e
	z5DHPug/4KEf6yfBImoM3pRQ80mZKzmmY6TiaXqQ1hndan04lE
X-Gm-Gg: AZuq6aKzWWuOYHsRgtHpRjnlNvrEHqjxSRNBMNPaa2OUi5oQ0co9suDeteDLcn7JJ73
	AaPwzAZN46uVbNCe7wgC1+F+a1IYF68FJBilgGDdUMzrAb3JEM+U/rULzTvzirG31B/w9mhB8B9
	EQa0hE83rxRVtE7fbEqtSPA9f7gZbpladET1eLSY8q22tpGtzoV0nvX3ng6rjIi0YY
X-Received: by 2002:a05:690c:e3cb:b0:794:eeba:55af with SMTP id 00721157ae682-794fe763e45mr43273867b3.39.1770241202100;
        Wed, 04 Feb 2026 13:40:02 -0800 (PST)
X-Received: by 2002:a05:690c:e3cb:b0:794:eeba:55af with SMTP id
 00721157ae682-794fe763e45mr43273167b3.39.1770241201601; Wed, 04 Feb 2026
 13:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122192841.128719-1-npache@redhat.com> <20260122192841.128719-8-npache@redhat.com>
 <db10946c-9743-49e0-a845-7f53a60778a6@lucifer.local>
In-Reply-To: <db10946c-9743-49e0-a845-7f53a60778a6@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 4 Feb 2026 14:39:35 -0700
X-Gm-Features: AZwV_QiWF5a0ic6AE73ER09Zi2Q0iEGOziUo-C9Qoix8T3UNqNr91IEvUAcICs0
Message-ID: <CAA1CXcAEc4McCq5iCeF69-Kc6R-5Sxk9-+QrkW1Ht+00ACJjfg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v14 07/16] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, willy@infradead.org, peterx@redhat.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com, 
	raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	cl@gentwo.org, jglisse@google.com, zokeefe@google.com, rientjes@google.com, 
	rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pQyjldjZBH5TlmarMLuRQwIbBh_vZDr2g-U-XI2TDps_1770241202
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 5:09=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jan 22, 2026 at 12:28:32PM -0700, Nico Pache wrote:
> > The current mechanism for determining mTHP collapse scales the
> > khugepaged_max_ptes_none value based on the target order. This
> > introduces an undesirable feedback loop, or "creep", when max_ptes_none
> > is set to a value greater than HPAGE_PMD_NR / 2.
> >
> > With this configuration, a successful collapse to order N will populate
> > enough pages to satisfy the collapse condition on order N+1 on the next
> > scan. This leads to unnecessary work and memory churn.
> >
> > To fix this issue introduce a helper function that will limit mTHP
> > collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
> > This effectively supports two modes:
> >
> > - max_ptes_none=3D0: never introduce new none-pages for mTHP collapse.
> > - max_ptes_none=3D511 (on 4k pagesz): Always collapse to the highest
> >   available mTHP order.
> >
> > This removes the possiblilty of "creep", while not modifying any uAPI
> > expectations. A warning will be emitted if any non-supported
> > max_ptes_none value is configured with mTHP enabled.
> >
> > The limits can be ignored by passing full_scan=3Dtrue, this is useful f=
or
> > madvise_collapse (which ignores limits), or in the case of
> > collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
> > collapse is available.
>
> Thanks, great commit msg!
>
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> This LGTM in terms of logic, some nits below, with those addressed feel
> free to add:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks :)

>
> Cheers, Lorenzo
>
> > ---
> >  mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 0f68902edd9a..9b7e05827749 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -460,6 +460,44 @@ void __khugepaged_enter(struct mm_struct *mm)
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
> > + * For mTHP collapses, we currently only support khugepaged_max_pte_no=
ne values
> > + * of 0 or (HPAGE_PMD_NR - 1). Any other value will emit a warning and=
 no mTHP
> > + * collapse will be attempted
> > + *
> > + * Return: Maximum number of empty PTEs allowed for the collapse opera=
tion
> > + */
> > +static unsigned int collapse_max_ptes_none(unsigned int order, bool fu=
ll_scan)
> > +{
> > +     /* ignore max_ptes_none limits */
> > +     if (full_scan)
> > +             return HPAGE_PMD_NR - 1;
>
> I wonder if, given we are effectively doing:
>
>         const unsigned int nr_pages =3D collapse_max_ptes_none(order, /*f=
ull_scan=3D*/true);
>
>         ...
>
>         foo(nr_pages);
>
> In places where we ignore limits, whether we would be better off putting
> HPAGE_PMD_NR - 1 into a define and just using that in these cases, like:
>
> #define COLLAPSE_MAX_PTES_LIM (HPAGE_PMD_NR - 1)
>
> Then instead doing:
>
>         foo(COLLAPSE_MAX_PTES_LIM);
>
> ?
>
> Seems somewhat silly to pass in a boolean that makes it return a set valu=
e in
> cases where you know that should be the case at the outset.
>
> > +
> > +     if (is_pmd_order(order))
> > +             return khugepaged_max_ptes_none;
> > +
> > +     /* Zero/non-present collapse disabled. */
> > +     if (!khugepaged_max_ptes_none)
> > +             return 0;
> > +
> > +     if (khugepaged_max_ptes_none =3D=3D HPAGE_PMD_NR - 1)
>
> Having a define for HPAGE_PMD_NR - 1 would also be handy here...
>
> > +             return (1 << order) - 1;
> > +
> > +     pr_warn_once("mTHP collapse only supports max_ptes_none values of=
 0 or %d\n",
> > +                   HPAGE_PMD_NR - 1);
>
> ...and here.
>
> Also a MICRO nit here - the function returns unsigned int and thus we
> express PTEs in this unit, so maybe use %u rather than %d?
>
> > +     return -EINVAL;
> > +}
>
> Logic of this function looks correct though!
>
> > +
> >  void khugepaged_enter_vma(struct vm_area_struct *vma,
> >                         vm_flags_t vm_flags)
> >  {
> > @@ -548,7 +586,10 @@ static enum scan_result __collapse_huge_page_isola=
te(struct vm_area_struct *vma,
> >       int none_or_zero =3D 0, shared =3D 0, referenced =3D 0;
> >       enum scan_result result =3D SCAN_FAIL;
> >       const unsigned long nr_pages =3D 1UL << order;
> > -     int max_ptes_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDE=
R - order);
> > +     int max_ptes_none =3D collapse_max_ptes_none(order, !cc->is_khuge=
paged);
>
> Yeah, the !cc->is_khugepaged is a bit gross here, so as per the above, ma=
ybe do:

Ok sounds good! I'll make the recommended changes.

Thanks!

-- Nico

>
>         int max_ptes_none;
>
>         if (cc->is_khugepaged)
>                 max_ptes_none =3D collapse_max_ptes_none(order);
>         else    /* MADV_COLLAPSE is not limited. */
>                 max_ptes_none =3D COLLAPSE_MAX_PTES_LIM;
>
> > +
> > +     if (max_ptes_none =3D=3D -EINVAL)
> > +             return result;
> >
> >       for (_pte =3D pte; _pte < pte + nr_pages;
> >            _pte++, addr +=3D PAGE_SIZE) {
> > --
> > 2.52.0
> >
>

