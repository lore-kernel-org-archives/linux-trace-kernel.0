Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373734DCFD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216007; cv=none; b=NT20AJCfDo0H81ISeV5/gm0K6g0BWWR3/ZQ8rLlcp5ZqJfGbo+8QSixQcwyZkm65CGBY6c0pUlFe886DorDXqdafVPP7l5MmCNanyBsfb4Cuib0Xe1LnYnRCSTBUkWgK1Lx8bnOy41T5od+wkBs5Y/wV4pMiJFZIVOyUG/ClPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216007; c=relaxed/simple;
	bh=aEW8TLxUhDGilGZ76RbUuftqJyu2PcJJHQluxIUny4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKMBHGfiJhHJ4hTmBD5a5OD9H3Z9VFvW2tMLThbZafwOSiwZKQyZrpEQpmOEbCFuDVDUU4eoRjQwGzduYFZVYuZcw1Pn7D2qIrgOKXMVvUs7u+kKOqHU8/YZjKnoCHxDdoRs7QK3IriM9jsFqHv4HA0ex85h0xa4CfZPR4Axw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKDhKoTs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKDhKoTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756216004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3uSnnXl39wQmO2qN0SfNv5WwjyU8sgsdnwZmwwH7nE=;
	b=eKDhKoTsthIR9V7IhXSbPghTDdugCXkVV46ldrBc66dVlpk1/uObmMGOtyv/sLZRrtNK9e
	6JKRP+7TDZ7zxV/Bi5WNLM8ScHecCOvYwoW3QzYdA1LYv12Twk6oDkyMYXDdFUDE5kRwQD
	18JmH7PfiT8twGP1duX5/YxuolrRETM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-u3m1kXmBOgOkCPI-QPCZTg-1; Tue, 26 Aug 2025 09:46:43 -0400
X-MC-Unique: u3m1kXmBOgOkCPI-QPCZTg-1
X-Mimecast-MFC-AGG-ID: u3m1kXmBOgOkCPI-QPCZTg_1756216003
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e931cb403daso8302320276.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216003; x=1756820803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3uSnnXl39wQmO2qN0SfNv5WwjyU8sgsdnwZmwwH7nE=;
        b=vmovGHHYavOGjnpYUDsk6urs+4txxwkCSYLweCuilfJUvbjy35wqugRAGR3NM8cSOx
         w+4Yn3fmdIJl4IVJ0DyeTLExR1xcBmODq9IZUtHnR3gPKky8W27cb7YgeM2piLamKbKV
         cffDEzeuHUiVDiBjzgaY2Lem8pY3TV1Kg5zkO0C1AE0j9sxGf3V/A+1sgpk42RbjISVU
         OaA5ZKpSsrCPnFCW/ESnMzJXKtr0zYKzmXbXtPW6Yr00pxm0V8ATwTdT8zt+mCWOxb7Y
         IUbbZVWPbbMSzTWnmLvAlqb+QZJWl9GL2S7z5vV4My/jip2yUwBsTrO7tHuK4JYEvk5Z
         1KlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZBntMn2o52HbqrH81sOwARjEBAnHCTQuzCWQZrxt+aMfHQbQXhYQEwvSlGR4anDqtubuE5llVdT6F7V7o0+xQVE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrknejh9tjOeGD0lcPIiDINFHjYa1b0iFOSc8qUjIgFxpUOzuJ
	SR7GdW3WCE8aA1jVXc+BgoDQBltApf6b6cZ2DyCy+QEnP8ATs0xU52R50Cah8WCUsKg/q5EZKwF
	8qTPd0/FhYp9pxbyPUhUqugbteQDR3d2Zn0LyIFWP4cyVp2U5mtSU6F0SsW0JczNMKQIzPZlEJg
	uOHP9e0vTMWgNmpiubGS0mTsJ9BQcpl5h86nmM8BSuT3Z6qegS
X-Gm-Gg: ASbGnctnCiLAffNKfNdNKcCboW/T+Vhjo44dY3Cnsny7QjNoimCMrZRTqWR8NoS27Jq
	nmupWfRGIHboRsSAduAV17ZS/6UhXPNA2ZlmUmN+sCpgtxnSTvCRTiIONnS3MlMhrd+xVgJAvUH
	LcV8jEe2rhtDbKfkQXNHCOQpc=
X-Received: by 2002:a05:6902:1505:b0:e90:11bb:397c with SMTP id 3f1490d57ef6-e951c2e6476mr17866644276.10.1756216002414;
        Tue, 26 Aug 2025 06:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuxDJCtt4uGtkkNwYc+l5uBaWSrMn5+Sn6RTFNkIfr9/PHfQUvWNUMSRZXgQlOWs52bnkehKXLBXOH5bnIPQs=
X-Received: by 2002:a05:6902:1505:b0:e90:11bb:397c with SMTP id
 3f1490d57ef6-e951c2e6476mr17866565276.10.1756216001425; Tue, 26 Aug 2025
 06:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <20250819134205.622806-4-npache@redhat.com>
 <20250824013746.bvsz3vajjj2kphrl@master>
In-Reply-To: <20250824013746.bvsz3vajjj2kphrl@master>
From: Nico Pache <npache@redhat.com>
Date: Tue, 26 Aug 2025 07:46:14 -0600
X-Gm-Features: Ac12FXyLvLHJcV0w6rar3RVrCz2fxN5NrCxMe4grcCkIazMUynhHT0ZTM7eshuk
Message-ID: <CAA1CXcBskENLPGB3zCNu0UpPqMMRtSiQuAdLPDPsEZt6ne6JnA@mail.gmail.com>
Subject: Re: [PATCH v10 03/13] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
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
X-Mimecast-MFC-PROC-ID: zVocGQ-A7oBuOAO8yae5DFs9ePRqY3-Sh3gokE8IKbs_1756216003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 7:37=E2=80=AFPM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> Hi, Nico
>
> Some nit below.
>
> On Tue, Aug 19, 2025 at 07:41:55AM -0600, Nico Pache wrote:
> >For khugepaged to support different mTHP orders, we must generalize this
> >to check if the PMD is not shared by another VMA and the order is enable=
d.
> >
> >To ensure madvise_collapse can support working on mTHP orders without th=
e
> >PMD order enabled, we need to convert hugepage_vma_revalidate to take a
> >bitmap of orders.
> >
> >No functional change in this patch.
> >
> >Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >Acked-by: David Hildenbrand <david@redhat.com>
> >Co-developed-by: Dev Jain <dev.jain@arm.com>
> >Signed-off-by: Dev Jain <dev.jain@arm.com>
> >Signed-off-by: Nico Pache <npache@redhat.com>
> >---
> > mm/khugepaged.c | 13 ++++++++-----
> > 1 file changed, 8 insertions(+), 5 deletions(-)
> >
> >diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >index b7b98aebb670..2d192ec961d2 100644
> >--- a/mm/khugepaged.c
> >+++ b/mm/khugepaged.c
>
> There is a comment above this function, which says "revalidate vma before
> taking mmap_lock".
>
> I am afraid it is "after taking mmap_lock"? or "after taking mmap_lock ag=
ain"?
Good catch, never noticed that. I updated the comment!
>
> >@@ -917,7 +917,7 @@ static int collapse_find_target_node(struct collapse=
_control *cc)
> > static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long =
address,
> >                                  bool expect_anon,
> >                                  struct vm_area_struct **vmap,
> >-                                 struct collapse_control *cc)
> >+                                 struct collapse_control *cc, unsigned =
long orders)
> > {
> >       struct vm_area_struct *vma;
> >       enum tva_type type =3D cc->is_khugepaged ? TVA_KHUGEPAGED :
> >@@ -930,9 +930,10 @@ static int hugepage_vma_revalidate(struct mm_struct=
 *mm, unsigned long address,
> >       if (!vma)
> >               return SCAN_VMA_NULL;
> >
> >+      /* Always check the PMD order to insure its not shared by another=
 VMA */
> >       if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
> >               return SCAN_ADDRESS_RANGE;
> >-      if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER)=
)
> >+      if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, orders))
> >               return SCAN_VMA_CHECK;
> >       /*
> >        * Anon VMA expected, the address may be unmapped then
>
> Below is a comment, "thp_vma_allowable_order may return".
>
> Since you use thp_vma_allowable_orders, maybe we need to change the comme=
nt
> too.
Ack! Thanks for the review!
>
> >@@ -1134,7 +1135,8 @@ static int collapse_huge_page(struct mm_struct *mm=
, unsigned long address,
> >               goto out_nolock;
> >
> >       mmap_read_lock(mm);
> >-      result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
> >+      result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc,
> >+                                       BIT(HPAGE_PMD_ORDER));
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> >               goto out_nolock;
> >@@ -1168,7 +1170,8 @@ static int collapse_huge_page(struct mm_struct *mm=
, unsigned long address,
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
> >-      result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
> >+      result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc,
> >+                                       BIT(HPAGE_PMD_ORDER));
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> >@@ -2807,7 +2810,7 @@ int madvise_collapse(struct vm_area_struct *vma, u=
nsigned long start,
> >                       mmap_read_lock(mm);
> >                       mmap_locked =3D true;
> >                       result =3D hugepage_vma_revalidate(mm, addr, fals=
e, &vma,
> >-                                                       cc);
> >+                                                       cc, BIT(HPAGE_PM=
D_ORDER));
> >                       if (result  !=3D SCAN_SUCCEED) {
> >                               last_fail =3D result;
> >                               goto out_nolock;
> >--
> >2.50.1
> >
>
> --
> Wei Yang
> Help you, Help me
>

