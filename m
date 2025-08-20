Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6992E266E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704473; cv=none; b=PjPca3Q1GJqj/vvW+xGkOyBcnX26+jpPHhf5bcILX9T+yVxLYu8UFrGbq7j2cAgSA1PrWMuBeflABr0H6ESuCEB9jvDA8isEvcq+mpwHXy+fXty9NtOZ20hL8tLyN2Y6BR4/trrqsKzV+pqaKhhettcrD88v0RiBxVVYVU7+/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704473; c=relaxed/simple;
	bh=1cTJ5YS37dXXDca+7HZLxXlAjhXuuTwagT2XyBDXiAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyK9cZrhU47jXZe1f3nLSRNCtaJdiwG7Tzi3Jx0VKr7sDULyZVFd5mx1/1Ah0wLTDezz/m2VY5fwmCAeEJBxspVl7Wdzq5t5zE1myyU1pYbYIu7pG+N4E5vi9G06mptFEL49t1ICCqw9MigmVlM+4NWwcR+Lc5YIdY1taxaGKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJqwkMZo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJqwkMZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755704471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYSofwZAlBuy0oyzsu8d75QQkZFfweO09q+8sQkHcvo=;
	b=SJqwkMZoOB9Ki72DeOJWH9zQWaT1ta/qLZQUub4+xkcAgAiC4G5/8Th+tsRqUQl2d3rRv+
	UMWd4CYA5k8FvFcO4+RSvhMnie8n1atPDsYZTfeLw57jojMJC0j2mmLARrVzpAlfftpsdJ
	NOUboQdc6Olsnw2aZzhnAKb454Ma414=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-sqVdf9xWPzOF9Xb65Z9GtQ-1; Wed, 20 Aug 2025 11:41:08 -0400
X-MC-Unique: sqVdf9xWPzOF9Xb65Z9GtQ-1
X-Mimecast-MFC-AGG-ID: sqVdf9xWPzOF9Xb65Z9GtQ_1755704467
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e934e7eda88so4616055276.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704467; x=1756309267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYSofwZAlBuy0oyzsu8d75QQkZFfweO09q+8sQkHcvo=;
        b=hr/FVcLFdtwgi0Cno9VU4qa1zTT+BAAk5PThodMFpgv9ZWGrxm+nRjtGpE/bvvyzU3
         DikFtSTnv5GepZuhaXsJ3/tnNggas1RGdDAoyTdDEN9QCYqV0FaI9MTXBidZoXNpNPVE
         M2AbMF5+baupPAtpztbVe5hUrtVe1s07Y41EmD05p6/dw23zzyK+v6SPNbpLR0/MpZ+M
         0fiYkbqaOlLssvUqnmhYMNPKI0Huk3HdrZdAEUNoah8NlmR3FNSQq21HN8gxCkFwT9A/
         0aRU72EhWpkJtkIw2w84T99xpxzmbPCR8ybbYe+zF6Ci5BWmzr2OXdtnFyUEDVEVnITd
         U4HA==
X-Forwarded-Encrypted: i=1; AJvYcCWL1VGQWzkjIbBD1Ri76qqMwf6yppX8M0+ixRdcG1AENNkB9c4WFRIdaqKFm6+7ht3XszrAVK+fVbcqynG1uFib0f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDaeeJTWCiSLoRg86H0t+HzpxBr4U63Gr/CCHmg6vHmxVGInZE
	hNDzJCGFHNEm1Fpc/OABhPpbyfsobrM2uvxQafdyjP01gaD0dcXxfx81q+TnzLx9pYlRLydqDKD
	nL4uG8csgxO96aOF1NtgR7eyD2flBJpt7p3k4VtzPcrNGZMs8gL1l9wMOXiGraqhkRE8Qe0h4dL
	RvHvg19l+7gQa8vL/VfoWepN8+j7QNGdhbUgAJLWTPMb+9iGKX
X-Gm-Gg: ASbGncvVkOGTcum5aMl/rGYmgOwJ1QBoSJQJ9LlS13Q2MPrJV09Anmo81eAArhTt6AV
	mRDevk1FFPmaebwGuojA5/ul09U9mQfQqyK/eFXFuIeNqqI3acN61LAG2X3V60pnV/IyaVfTyNg
	OeKV3P3giqgW7zk3hf8JYKGwc=
X-Received: by 2002:a05:6902:4a84:b0:e94:25a2:f8f5 with SMTP id 3f1490d57ef6-e94f6539a69mr3281639276.3.1755704467415;
        Wed, 20 Aug 2025 08:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOTBrpkhP4lXt+J3rPPABO3gkD8lKSX5VfjJLDUErExXxnxu+nUSNzUqoP1cAU7FTl4VV3oeWsS3Y6s5hhVS4=
X-Received: by 2002:a05:6902:4a84:b0:e94:25a2:f8f5 with SMTP id
 3f1490d57ef6-e94f6539a69mr3281610276.3.1755704466967; Wed, 20 Aug 2025
 08:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <20250819134205.622806-4-npache@redhat.com>
 <cd4dd743-679f-4c55-9635-6d32e6fa5ff7@lucifer.local>
In-Reply-To: <cd4dd743-679f-4c55-9635-6d32e6fa5ff7@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 20 Aug 2025 09:40:40 -0600
X-Gm-Features: Ac12FXzD1K71b8kZ8iPzUj6lIyXHh5PjcoNqYYPU597Q2ZwJYp0jVWP2zrGYIjI
Message-ID: <CAA1CXcDORXqm4JoHn4ZSEhT3ajsuY2MAPwefMXk3+YMXcpvqkw@mail.gmail.com>
Subject: Re: [PATCH v10 03/13] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
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
X-Mimecast-MFC-PROC-ID: qiCwTppiu-BBjzBuXnZdJzrTTdv4vpQqRsprK1KwFMQ_1755704467
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:25=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 19, 2025 at 07:41:55AM -0600, Nico Pache wrote:
> > For khugepaged to support different mTHP orders, we must generalize thi=
s
> > to check if the PMD is not shared by another VMA and the order is enabl=
ed.
> >
> > To ensure madvise_collapse can support working on mTHP orders without t=
he
> > PMD order enabled, we need to convert hugepage_vma_revalidate to take a
> > bitmap of orders.
> >
> > No functional change in this patch.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> LGTM (modulo nit/query below) so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Thanks :)
>
> > ---
> >  mm/khugepaged.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b7b98aebb670..2d192ec961d2 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -917,7 +917,7 @@ static int collapse_find_target_node(struct collaps=
e_control *cc)
> >  static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long=
 address,
> >                                  bool expect_anon,
> >                                  struct vm_area_struct **vmap,
> > -                                struct collapse_control *cc)
> > +                                struct collapse_control *cc, unsigned =
long orders)
> >  {
> >       struct vm_area_struct *vma;
> >       enum tva_type type =3D cc->is_khugepaged ? TVA_KHUGEPAGED :
> > @@ -930,9 +930,10 @@ static int hugepage_vma_revalidate(struct mm_struc=
t *mm, unsigned long address,
> >       if (!vma)
> >               return SCAN_VMA_NULL;
> >
> > +     /* Always check the PMD order to insure its not shared by another=
 VMA */
>
> NIT: ensure not insure.
ack, ill fix that!
>
> >       if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
> >               return SCAN_ADDRESS_RANGE;
> > -     if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER)=
)
> > +     if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, orders))
> >               return SCAN_VMA_CHECK;
> >       /*
> >        * Anon VMA expected, the address may be unmapped then
> > @@ -1134,7 +1135,8 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >               goto out_nolock;
> >
> >       mmap_read_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > +                                      BIT(HPAGE_PMD_ORDER));
>
> Shouldn't this be PMD order? Seems equivalent.
Yeah i'm actually not sure why we have both... they seem to be the
same thing, but perhaps there is some reason for having two...
>
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> >               goto out_nolock;
> > @@ -1168,7 +1170,8 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > +                                      BIT(HPAGE_PMD_ORDER));
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> > @@ -2807,7 +2810,7 @@ int madvise_collapse(struct vm_area_struct *vma, =
unsigned long start,
> >                       mmap_read_lock(mm);
> >                       mmap_locked =3D true;
> >                       result =3D hugepage_vma_revalidate(mm, addr, fals=
e, &vma,
> > -                                                      cc);
> > +                                                      cc, BIT(HPAGE_PM=
D_ORDER));
> >                       if (result  !=3D SCAN_SUCCEED) {
> >                               last_fail =3D result;
> >                               goto out_nolock;
> > --
> > 2.50.1
> >
>

