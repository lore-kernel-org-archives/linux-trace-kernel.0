Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8922AE76
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737134; cv=none; b=jjhzjxS99Qg/KrpZQjeteA2rqg5axntbLJCzfBeQUVnSXliLXUwtgOcZzBcV4Y1OBn2YjxXNIqVI4Ojvt+zHg3uTz65iR7scCEKd6pDq7b1XYl+60Rr6D921fP+emig7v9SW33cebLbU/Figld1+UjaQVMNLYrnwx4E9JeFhS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737134; c=relaxed/simple;
	bh=j58zeUSOM0h/p9sADyLgvkI2QIcTR+seK1bRLizS8o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4DhftMlxUEFmv01CsDZVPNO35fDCZwDJZtWKJ962hqCMPsH4ZJJJAWNDHtbSeVxyFlBqRMzcHFrFr2dJ/D0SmUlGZ3xMzoaH+x2UfdVeaeh55mamU1N99FDuI5rQ3c86i9CQPqynFIn+IuXghbEkWdB8fEjk4+FhI1DSKFXgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DU3jdAST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DU3jdAST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2qRJ0vhUxgZfAdGXu3qCJFwuvYHORHNNQHgAFNdhP0=;
	b=DU3jdASTw3zckpV2ZRtIzQrHznDCJ7v8cwyHvYLS3cd3a62iAIOop1EssL/C3U3BUbx1uO
	EIrjxzB2NNBM7QgEyIityBhPttC9Bhzj18sh6WOWU4XV5rfxgrZ53ySkSOJnSUb7RKChKR
	qPfs9pv9S8FfCdwJV8Ozl3N/5EBIrFo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-6PFbFdE8OTaOJqiEyP3btg-1; Thu, 17 Jul 2025 03:25:26 -0400
X-MC-Unique: 6PFbFdE8OTaOJqiEyP3btg-1
X-Mimecast-MFC-AGG-ID: 6PFbFdE8OTaOJqiEyP3btg_1752737126
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-713ff70871dso6651497b3.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737126; x=1753341926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2qRJ0vhUxgZfAdGXu3qCJFwuvYHORHNNQHgAFNdhP0=;
        b=AMRdsz/imIGxBLWGgkuPCrvwvE4JJdm432GpHSM1C/Sdc9tZBZhObkHa66A6X0mpp0
         DDHOPa9jTrAOMQSW074IIjbxtzSZ7nAyElSiLbWhtvQp08H5ftUACLivdpKnKkECrtLi
         pULujH7tthvvgKFCy8c1hpbqmKAUZDTjSUrLKS+tdZXkcERhF2zRLKqvQIiI8NjU/F8e
         nzW+hG5w2u9RjO6IUmhNJgB9APySnEeyFuxXEB2KcCyfqxVItRN71brzyS5zrU2OWDXX
         140CcIu8A7XTVBlUN87/DcUYUewItkHS2c5fLaQzxl1DKlTPqUFHYo3q1pEbmvsy/C9J
         psTA==
X-Forwarded-Encrypted: i=1; AJvYcCUpC6yLO/zLCQmz5Qd9hU6TTFpEPXaaaCSrzCrJxHiYwyDHZLCWk7b1Gc4Q7pZD9H47DjwpNrFSB/aNUIgpgRhbD+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhu2yX2OtSQVgTlTiLBWsE1wGxhZd6pD+puO2jbej7xEXYR0cl
	n5rt8O0kwr62YzIbiTgsy3JfbPzjTTpm6/LBap6UcmFfYw2dI7tACH42IHQ39emocmZbrg0F9Hy
	4w8ngud3sspaaGYUEYzvZi1Y4aolTNtSInIpfFTUbyO8ouJJ1TIaQEaZ43U3guoK0GnwptnKEST
	CDgk/y4j5XAKvg/frpDv5EAXyVZw/J6GawP1TIPkzVrlfwLKFG
X-Gm-Gg: ASbGncs4FGmZXSxWvme1GNzM6w9xfZJbLruaf4PTrRDRVaNyfmCH1hBBvFjxFovWdj5
	lkqNhcDTWXECiwmIOseQa+9AZOTrUvjfnoSim/jnCbxoE2NcHI7Q9TV2+FcPZOs209Do4g+45RO
	oiOuvJRyMvP721Y5QXdIaJcRE=
X-Received: by 2002:a05:690c:6c8f:b0:70a:2675:70b3 with SMTP id 00721157ae682-71837475aaemr81219367b3.17.1752737125999;
        Thu, 17 Jul 2025 00:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3zLwOVx14CX9ZFk5M7NptbR4Vtkv7y2swdOQcVV2bdsXyIwCQieST6so7r6GPy5LTDbi4OxzkmKDiHQeVo40=
X-Received: by 2002:a05:690c:6c8f:b0:70a:2675:70b3 with SMTP id
 00721157ae682-71837475aaemr81219087b3.17.1752737125474; Thu, 17 Jul 2025
 00:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-9-npache@redhat.com>
 <290d669f-e358-471a-95b7-c46f974742d0@redhat.com>
In-Reply-To: <290d669f-e358-471a-95b7-c46f974742d0@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:24:58 -0600
X-Gm-Features: Ac12FXw-dqZQr1iCc1PpyFCVkqA86TGy_82hTQcSrhEKTcjVPQocXibYjfgQIuE
Message-ID: <CAA1CXcAciHMz7RCAqFZcnDk-nvhfd-G7QSdMub1aYzKAq8pdHw@mail.gmail.com>
Subject: Re: [PATCH v9 08/14] khugepaged: skip collapsing mTHP to smaller orders
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
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
X-Mimecast-MFC-PROC-ID: s0T_RVQl-cCKIGqdlV3LtuN2I7Y1YQLk7wwTxeG4yTo_1752737126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 8:32=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.07.25 02:32, Nico Pache wrote:
> > khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
> > some pages being unmapped. Skip these cases until we have a way to chec=
k
> > if its ok to collapse to a smaller mTHP size (like in the case of a
> > partially mapped folio).
> >
> > This patch is inspired by Dev Jain's work on khugepaged mTHP support [1=
].
> >
> > [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.c=
om/
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5d7c5be9097e..a701d9f0f158 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -612,7 +612,12 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >               folio =3D page_folio(page);
> >               VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
> >
> > -             /* See hpage_collapse_scan_pmd(). */
> > +             if (order !=3D HPAGE_PMD_ORDER && folio_order(folio) >=3D=
 order) {
> > +                     result =3D SCAN_PTE_MAPPED_HUGEPAGE;
> > +                     goto out;
> > +             }
>
> Probably worth adding a TODO in the code like
>
> /*
>   * TODO: In some cases of partially-mapped folios, we'd actually
>   * want to collapse.
>   */
Done! Good idea with these TODOs!
>
> Acked-by: David Hildenbrand <david@redhat.com>
Thank you :)
>
> --
> Cheers,
>
> David / dhildenb
>

