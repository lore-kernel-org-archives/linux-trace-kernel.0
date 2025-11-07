Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84216339704
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538524; cv=none; b=VKCPncsJIuSY5jOtL54UusmyblWAcmT2Nnh5EMQPCm5qlTlWcOERVCN0EqHa28o0adnvi0+joslf2mfhTMXE0Vyi3166fCcAS3/RooEMIQIrPYAJpa0DW4IElZBQFS79ce03efRruI53WECkfjSIu3CuI9qOVza5LdjdySvYRX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538524; c=relaxed/simple;
	bh=mgm8qxjZEYmIZNBjWTRuwvARGl9cfquNJwY3c7URdeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFNJV+kotq5t7iAXH2i45+fiihDIOYOERsm5AQk79qykaclpu3BmuGd/XvQB4YFhAQxgRGdtf/ZA0TfS+UPk+Gs6w5QZ+qzti1vL3tkxlHQ+XtlVA3tulOLOMTMflmRhGtciaAiiXyfxVrq/dBNhiEhoiBqkXz0vBOd6iVbNtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPSGrrv+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPSGrrv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762538521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o03EPvkF1Ee4HFaXHVj6CmMYvciS5SYoQDAqRDI5EK0=;
	b=fPSGrrv+ltOSknZKq3nDkoJGUd6mAdWKL6GTqVlxDDuOSwNEJU5bzldL29BbwpAX0cRl9g
	tuQ15AYD1GFxfhY1yArwscs0Y19al7YVfUJJM9PDRC6BCWs+UvlZguxv443Rzinlktz+ae
	z1mldcKqOdzaU8hN8bfLSqNnsIs9zYg=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-ccUHvOQdNnC-YOfdlrxBfw-1; Fri, 07 Nov 2025 13:01:53 -0500
X-MC-Unique: ccUHvOQdNnC-YOfdlrxBfw-1
X-Mimecast-MFC-AGG-ID: ccUHvOQdNnC-YOfdlrxBfw_1762538513
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e324b2fd0so1398809d50.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762538513; x=1763143313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o03EPvkF1Ee4HFaXHVj6CmMYvciS5SYoQDAqRDI5EK0=;
        b=JMLxKMcZnulGLgMNegqgg7qn0YIpq/IXynFut7Wuc0+P2+hnhJFXMqoTRf/VpLDyVZ
         GxeD+BykPIu02vljb6BqPOvUCBnZLsiI2M488oE5PBZbqQXrF4G6UNRgdRChcXpdD1sz
         Dexn3pRPaF6HTdeMn9rAl4BxjCPUIebSgr1zya7iuaSrDE3p2Pmpot5Cw6YlpfFyeCOK
         gzrunj92UjaXRNiYDOzGNqhXxwJ6D8HpePwek48jP5yEh4gCK5W8embFNswh8bmRH5gH
         fBJYtAlN7YcxJv9i6oCnguEmxeWKA0hsrgucGJGDUCOrI5wProgbhPUjWphnUYexX5Qe
         Mt+A==
X-Forwarded-Encrypted: i=1; AJvYcCV+rfK0JOpiZ8Jz8yVmrazv/EoI4riyP1DQG78wG32QXDj805VpJ9PZsWvAvEurZi5i/ANcWKdDV7BOD1DvR3MT20I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpaq7FOx6m66dZeAGN+B8GFKEyHExkY9iErjvvvnhbKYWq0kFs
	R1/utoq+VqcqSjJ/5cZs3rAqhnJmPGd8un6BVq6VkWHLN9dJBYjKdD/ZOeyumhrTcCCLXjn9bJu
	zAk7PyKcU3ykdQtsuzJB7aTCQaL4gzACoruH0l8sT03o5UIY/6KJUauGYmmPsv6K6OnRI/YZH/F
	H7TRbiEEoUJsKl1kmZCayrklE6QawnSpnUTZHzb3Wez0KTL6fu
X-Gm-Gg: ASbGncsWphhats20doTTdH6ItShmoisJaf6FIpsG1bM6+X6z431MAMgxx4m5HuNGwgx
	VrJokIDc30UuT8omVc8gz3/sqylkmkWDDGE57wbArlsm6b/exGL/mCPLYr87vGwIO35WzBtHexK
	p/8WT1yQGVEBqhs98VzaVgeAj1T24GIzvUOBZLCeeoR89Pv/jAcpPsujqofB+mrYQxSMcqPw==
X-Received: by 2002:a05:690e:2417:b0:63f:b4d8:1f3c with SMTP id 956f58d0204a3-640c42dac2dmr2587364d50.35.1762538512622;
        Fri, 07 Nov 2025 10:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjLDv5pucIrLunFcmpT5DImh7xOQHAmSWOhb/WF5swQ3zC4ISlOHgSzClnhRgLhl4xOKSEVGJksfqOFQroVQk=
X-Received: by 2002:a05:690e:2417:b0:63f:b4d8:1f3c with SMTP id
 956f58d0204a3-640c42dac2dmr2587310d50.35.1762538511869; Fri, 07 Nov 2025
 10:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-12-npache@redhat.com>
 <5b2dbd05-094f-452a-8067-d342b2819af9@lucifer.local>
In-Reply-To: <5b2dbd05-094f-452a-8067-d342b2819af9@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Fri, 7 Nov 2025 11:01:23 -0700
X-Gm-Features: AWmQ_bnZCljbkWgTreWCIKIWGk5V1YSCEzkc_26ghNPznQVbhA9Vnvap7t_CMZI
Message-ID: <CAA1CXcDG8=89uPcptkRv23JfmczAGp6_KQMQOFhQ6Uivo-33kw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 11/15] khugepaged: introduce
 collapse_allowable_orders helper function
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
X-Mimecast-MFC-PROC-ID: sP_ifQXn_jPLRYLW9ncgkkUDXGr7ZV0J-Ug7B8AGWvg_1762538513
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:51=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:37:13PM -0600, Nico Pache wrote:
> > Add collapse_allowable_orders() to generalize THP order eligibility. Th=
e
> > function determines which THP orders are permitted based on collapse
> > context (khugepaged vs madv_collapse).
> >
> > This consolidates collapse configuration logic and provides a clean
> > interface for future mTHP collapse support where the orders may be
> > different.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> With nits below adddressed, LGTM so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thank you!

> > ---
> >  mm/khugepaged.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 0dbbe04c31fe..89a105124790 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -489,7 +489,16 @@ static unsigned int collapse_max_ptes_none(unsigne=
d int order, bool full_scan)
> >       max_ptes_none =3D min(khugepaged_max_ptes_none, HPAGE_PMD_NR/2 - =
1);
> >
> >       return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> > +}
> > +
> > +/* Check what orders are allowed based on the vma and collapse type */
> > +static unsigned long collapse_allowable_orders(struct vm_area_struct *=
vma,
> > +                     vm_flags_t vm_flags, bool is_khugepaged)
> > +{
> > +     enum tva_type tva_flags =3D is_khugepaged ? TVA_KHUGEPAGED : TVA_=
FORCED_COLLAPSE;
> > +     unsigned long orders =3D BIT(HPAGE_PMD_ORDER);
>
> Nit, but can const-ify.

It becomes a function of is_khugepaged in a later patch.

>
> >
> > +     return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders)=
;
> >  }
> >
> >  void khugepaged_enter_vma(struct vm_area_struct *vma,
> > @@ -497,7 +506,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vm=
a,
> >  {
> >       if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> >           hugepage_pmd_enabled()) {
> > -             if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED=
, PMD_ORDER))
> > +             if (collapse_allowable_orders(vma, vm_flags, true))
>
> If we have a 'mystery meat' boolean parameter can we always use the conve=
ntion of:
>
> collapse_allowable_orders(vma, vm_flags, /*is_khugepaged=3D*/true)
>
> Please? Same goes for other invocations obviously.

Sounds good! I'll fix those up.

Thanks,
-- Nico

>
>
> >                       __khugepaged_enter(vma->vm_mm);
> >       }
> >  }
> > @@ -2567,7 +2576,7 @@ static unsigned int collapse_scan_mm_slot(unsigne=
d int pages, int *result,
> >                       progress++;
> >                       break;
> >               }
> > -             if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUG=
EPAGED, PMD_ORDER)) {
> > +             if (!collapse_allowable_orders(vma, vma->vm_flags, true))=
 {
> >  skip:
> >                       progress++;
> >                       continue;
> > @@ -2873,7 +2882,7 @@ int madvise_collapse(struct vm_area_struct *vma, =
unsigned long start,
> >       BUG_ON(vma->vm_start > start);
> >       BUG_ON(vma->vm_end < end);
> >
> > -     if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLA=
PSE, PMD_ORDER))
> > +     if (!collapse_allowable_orders(vma, vma->vm_flags, false))
> >               return -EINVAL;
> >
> >       cc =3D kmalloc(sizeof(*cc), GFP_KERNEL);
> > --
> > 2.51.0
> >
>

