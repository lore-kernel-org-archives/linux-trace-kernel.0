Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB3313543
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358350; cv=none; b=I6aw2jGuOx3Uzj1nY4t9HS4WfPozluWfDssY5GgU/xTHIavVI80lz2InEBru/KvlgbKLONQJUP0SfXOUlDGSb9kTifbA2m4f/9cAca+K+RD97lGfrhcBvo18gSUWPt/0ZdG98kFTasZgP3+3ZV3RBUGoD5JrITleNH9i+7ytY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358350; c=relaxed/simple;
	bh=4kEiZQdMuLDYjvuzWO3Ebx5AEJmfCVbLhWyIIpWBH4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNkHTkNKUDGlpHWE0oVdpbbT63/Qx82U44zJcjMFwnsrwDxPzxGsKgRsdQ/eP6t4Xwe1OZfbtYsUdcBZ3b7ZeIvQ5ij0dp5wi0TCI5wERrqnjafueBmhoUYURYX4Sf1IWAd1zyXaBLH22/Obb6rDrlMg4raP91ZeB11WRaK9pts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVlavPBt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVlavPBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768358348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsaYDMAkcB1oPv2ajw72CMxvsVxtZEIcouIazzEAlDI=;
	b=HVlavPBtHTCqrvKaVa8Dc5qqCb5GHVRANSyprDH12RmbIsBfB21zzgI6kOgaVxyVgs5tDQ
	036iPpVKhtxAgSJ3512V+vmxEg1iEAR5ltbuNk+P3AslaBXLVwbIfoZ06SMU+m/3dsvNFu
	hWKB+lthr3/yZKvX3zH24oQOyGIdIvU=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-3GbZzBKmPmmWRye65ENmnw-1; Tue, 13 Jan 2026 21:39:06 -0500
X-MC-Unique: 3GbZzBKmPmmWRye65ENmnw-1
X-Mimecast-MFC-AGG-ID: 3GbZzBKmPmmWRye65ENmnw_1768358346
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-645528427b4so13159045d50.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 18:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768358346; x=1768963146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GsaYDMAkcB1oPv2ajw72CMxvsVxtZEIcouIazzEAlDI=;
        b=i0Ie6gG86OmLOAbYXTcLWCvYqegoOpivRBVAPtUtQv9DcVyv50g6ShYC0hzyu/sORM
         zF38Ck32UZWKIENmiN1HdjpJ7pnBq3Bf/m+oeS6BE9z7KIqqe6iRTOat6XtIeL4Mu9GR
         fUeZ6d7aTs4Vly9p0r0A5m/WPorc+i8gR87NryGhXPYNwshBJlpsnC7x0HZlp/YinM+I
         ys+MUSW/4HwDxuBCDU+s3nLvalcRr8FwNxoQ2G80NI8qNaTy9mH6kcGutOw3nuRGCsK2
         uE14a0i2+DVar2VAlY3Nup/GNfZA/0dOGCm5H7H9KvKevNYuT8/6Qs8Sg8ixS4TESesU
         uhgg==
X-Forwarded-Encrypted: i=1; AJvYcCXoNY0C9RcndYR4L2VVW53hp/dBZExKmtLCfLVMH2Jd99lN3DNFs50ZOpy5IOfI7dNxwTKWXG32wys65d7nrbnk2I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcdB2ca59HFG+TczKfbG8xYSlVhLs6tC+eAvcRKQPMbLvjse3
	jqN+BZb/bUPOYl9atu71vc/FZOQCpf0xHjpks/oJKnqzc4J3ITuz8qbw5K96em1i/6WPUTAnINI
	YXCP4tJ06d7diMSfO4mW0KRGImC8lHY9sb2khJAFazpzVuMbCsWkkgYtd6bx8EfI7z267L2fyDK
	Tc+4PiGrWJcyllqzPtXNZ55uPmayXXwpyk8OaVlKEVgpovG5M1
X-Gm-Gg: AY/fxX4NtwcyeJnkI/TX6kbYjtAc50Hw3hI6sN1+tdwQy4BzXS6I87zZ4JA+CP1vDBy
	AnMhNcqB1RCGPEfVgGKrIqKqdnHIsrxhquiXnzyTAVhLFetQdDUmrqXjz8jxQfJkhnSnPBu2QyS
	fII5VrzG1COB4bJVKjyB8wqIcZLUaXmIR/NgdAaZtIp7z4BYDmGcv/quMwDnNAkV9wyskyneIlp
	Cpi3/3X
X-Received: by 2002:a53:b199:0:b0:63f:9928:3f85 with SMTP id 956f58d0204a3-64901b01ee2mr778922d50.62.1768358346211;
        Tue, 13 Jan 2026 18:39:06 -0800 (PST)
X-Received: by 2002:a53:b199:0:b0:63f:9928:3f85 with SMTP id
 956f58d0204a3-64901b01ee2mr778884d50.62.1768358345750; Tue, 13 Jan 2026
 18:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201174627.23295-1-npache@redhat.com> <20251201174627.23295-6-npache@redhat.com>
 <CCE3840A-A46A-4F33-8412-FC55161A6D6C@nvidia.com>
In-Reply-To: <CCE3840A-A46A-4F33-8412-FC55161A6D6C@nvidia.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 13 Jan 2026 19:38:39 -0700
X-Gm-Features: AZwV_Qg4QcCHsWf9Yf2aqPxUCcKE6236uDrcuWobRoGZDAiQfOTpw9hN9JUYA5U
Message-ID: <CAA1CXcC9YsOKbsvyZpgOwLdE938VBcPUrLyF97uN024uM2uiPA@mail.gmail.com>
Subject: Re: [PATCH v13 mm-new 05/16] khugepaged: introduce is_mthp_order helper
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
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
X-Mimecast-MFC-PROC-ID: irOSA7sfWDIehvaIX9EgqHUWJbBstPnlIMXcNAq9mG0_1768358346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 8:13=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 1 Dec 2025, at 12:46, Nico Pache wrote:
>
> > In order to add mTHP support, we will often be checking if a given orde=
r
> > is a mTHP or PMD order. Lets create a simple helper function to keep th=
e
> > code clean and readable.
> >
> > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 8599c7fa112e..9c041141b2e3 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -338,6 +338,11 @@ static bool pte_none_or_zero(pte_t pte)
> >       return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
> >  }
> >
> > +static bool is_mthp_order(unsigned int order)
> > +{
> > +     return order !=3D HPAGE_PMD_ORDER;
> > +}
> > +
>
> The code at the bottom of __folio_split() in mm/huge_memory.c
> can use this helper.
>
> The code in deferred_split_folio() uses folio_test_pmd_mappable()
> instead of order =3D=3D HPAGE_PMD_ORDER, but the code can be changed
> to use the helper.

static inline bool folio_test_pmd_mappable(struct folio *folio)
{
return folio_order(folio) >=3D HPAGE_PMD_ORDER;
}

Should we make the is_mthp_order() check all orders that are less than
HPAGE_PMD_ORDER.

ie)

+static bool is_mthp_order(unsigned int order)
+{
+     return order < HPAGE_PMD_ORDER;
}

This way it's true to its mTHP nature being smaller than the PMD.

Cheers,
-- Nico

>
> >  int hugepage_madvise(struct vm_area_struct *vma,
> >                    vm_flags_t *vm_flags, int advice)
> >  {
> > @@ -1071,13 +1076,13 @@ static int alloc_charge_folio(struct folio **fo=
liop, struct mm_struct *mm,
> >       folio =3D __folio_alloc(gfp, order, node, &cc->alloc_nmask);
> >       if (!folio) {
> >               *foliop =3D NULL;
> > -             if (order =3D=3D HPAGE_PMD_ORDER)
> > +             if (!is_mthp_order(order))
> >                       count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> >               count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
> >               return SCAN_ALLOC_HUGE_PAGE_FAIL;
> >       }
> >
> > -     if (order =3D=3D HPAGE_PMD_ORDER)
> > +     if (!is_mthp_order(order))
> >               count_vm_event(THP_COLLAPSE_ALLOC);
> >       count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
> >
> > --
> > 2.51.1
>
>
> Best Regards,
> Yan, Zi
>

