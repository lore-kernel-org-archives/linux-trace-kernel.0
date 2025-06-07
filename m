Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047CCA5A
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Jun 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301427; cv=none; b=Go7ItaeDbZeGU/P1vNY1AjPpzYKQtk/uOBInohIFnPuv1worLYEdEqSjV7XGBdSAEef2jgCHDABb5ul2wFm+dLTmWShkuZnPS1nO4kOhIbSsAIO5mKtI4GIHpvTFFoD7+RM9FGNXRjOr+HqjHmEzv82JAg8ed7riWWyhG+KnXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301427; c=relaxed/simple;
	bh=Eqj6FJEHfq7+3qKDuYXg+g35tU6lnmHz5On8n9Rjhgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=St4KAg/CWtHvNTcbBRCvGj0YGlm8v0JQCGQp+v3lm+vdZd+nP6ztDcC1PuekkOpc+EXPCBQe3WhBrwH8hU4Zz4+OWUMaFaMuqdFUyfb7VxV51n2dQajAgiMME+qQ6LsoMyKur5VJ4HUScd+AyEHvGb+vCkkz5mnYv19hGkULlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zf/Euyby; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf/Euyby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749301424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfnJpnOmsGPup1H/ERs2tNGx2bCdZsNE5EPGkXR7fYk=;
	b=Zf/Euybyi0jGaJFaKKv6lvWbel9syJIDUCrdawwm4To8IW0AbgpEysEB8oAmhKLitVaXOO
	6DVwimDoYZPNCSYNvF1WtcDhEnZz9f8Gx0ljlaCIF7P7yXNNHU7vdTB4mmu4xGwJI0w9f6
	I9OTLSD3QS51QUhfF8bBqVg8gpKlC98=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-e2QY5tGaMu6e_dVXNoTZnQ-1; Sat, 07 Jun 2025 09:03:43 -0400
X-MC-Unique: e2QY5tGaMu6e_dVXNoTZnQ-1
X-Mimecast-MFC-AGG-ID: e2QY5tGaMu6e_dVXNoTZnQ_1749301423
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7081121c3f7so34526777b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Jun 2025 06:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749301423; x=1749906223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfnJpnOmsGPup1H/ERs2tNGx2bCdZsNE5EPGkXR7fYk=;
        b=lNN9lRFhzdbG5v+eC7ABCthq+mZmSL5F2jpv/jROk2nBrM2ptfle/KM56oMWXUL+7u
         k7ZvEiaOI1aLGyxMdk3yWBMf8llhmSNY0z/RSnZ79fnRBhXKHVHhq0MRa/wIZaWXu+wL
         2zAebOF2bIm8fqb5cNjv0Ub3Se6tVQJbnB/1TY882xAR0HKKCvNaE0TTqMnVgXDWJRKX
         6WyBwmPJ9bLEI88HzMNz+6AOtfKCCbopt2E+AlwZw4EBhtpm3iFlq0XUgx5aS2jUUe8o
         XVxgzfUbSfM1ZDg1KNQIBhtMXAIaLXC9ib+LVt6snSwQ7M6neyuLb8x57hdAMs76iBDz
         HJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBGkIY0x25Wwrs6E91yeL/Ycs3Qfv3/7uWD+mbTNo+xQjjw3KqG1kPA/uY+UvxhpbdD8aCec0zx8nKCi6y5lh+zN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhA0YRmy6DE1jTqBasWCaV34oy78720e8yWDMEQDWQkdEbM9da
	rAV5i+wJut0uyPn/vI5aW/YdkrrvB9/49vacEHIjgRHOmfqEXvskQR//AnIIAlXZ41yTnA+mqj/
	IgDz+vVIXLM/eHLIZ5zH1kYr6r4PzzI34xKlvZPOHcxuPRmyfBacqj1rb+O/L22ah6radDrdEZu
	KtI0tu2/nRA9kUFbVsqoN9Oa7tVilTNKW12Us6Rd+ZO4PhHxPQ
X-Gm-Gg: ASbGncuqxPc3FBGNmvvIi1xnT+hYXrRb+VBQQY74U9AqzNd9bJ7B96IRGWXxbDePSI/
	/x4MmLHnEo/j8SOIdk0en2B1NUAWQp5FR6Xgm4RxPF2MVucsChyA8ritYLP/Q1yyj844a554T/k
	DTg7gh6g==
X-Received: by 2002:a05:690c:dcb:b0:710:e81e:1364 with SMTP id 00721157ae682-710f7afa722mr95726387b3.6.1749301423020;
        Sat, 07 Jun 2025 06:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0D1oScsQFJkbV3leaGwsdhfTHQOUGGFXMT7UPU6qs5ZvaWLTmpU2PaV4/bjxQzeziLLSjyNubyd/h1pZsPnU=
X-Received: by 2002:a05:690c:dcb:b0:710:e81e:1364 with SMTP id
 00721157ae682-710f7afa722mr95725927b3.6.1749301422601; Sat, 07 Jun 2025
 06:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <20250515032226.128900-8-npache@redhat.com>
 <6f061c65-f3aa-42bb-ab70-b45afdcf2baf@arm.com>
In-Reply-To: <6f061c65-f3aa-42bb-ab70-b45afdcf2baf@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Sat, 7 Jun 2025 07:03:16 -0600
X-Gm-Features: AX0GCFsXeVlQnNKWAGBb29ema6RNmgUDaEXB5xk1LDR3gUMKNf8Z3uuBnY7lWI8
Message-ID: <CAA1CXcDVMdzNWS3maQPd3L2ZTOjnNyswH21H-BNfZpUPXk6UcQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/12] khugepaged: add mTHP support
To: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nDMhx1KhTqU1SRbzSHqNp00YkeITV4egEa4NCPG3Yjk_1749301423
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 12:24=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 15/05/25 8:52 am, Nico Pache wrote:
> > Introduce the ability for khugepaged to collapse to different mTHP size=
s.
> > While scanning PMD ranges for potential collapse candidates, keep track
> > of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> > represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. I=
f
> > mTHPs are enabled we remove the restriction of max_ptes_none during the
> > scan phase so we dont bailout early and miss potential mTHP candidates.
> >
> > After the scan is complete we will perform binary recursion on the
> > bitmap to determine which mTHP size would be most efficient to collapse
> > to. max_ptes_none will be scaled by the attempted collapse order to
> > determine how full a THP must be to be eligible.
> >
> > If a mTHP collapse is attempted, but contains swapped out, or shared
> > pages, we dont perform the collapse.
> >
> > For non PMD collapse we much leave the anon VMA write locked until afte=
r
> > we collapse the mTHP
>
> Why? I know that Hugh pointed out locking errors; I am yet to catch up
> on that thread, but you need to explain in the description why you do
> what you do.
>
> [--snip---]
>
> >
> > -
> > -     spin_lock(pmd_ptl);
> > -     BUG_ON(!pmd_none(*pmd));
> > -     folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
> > -     folio_add_lru_vma(folio, vma);
> > -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > -     set_pmd_at(mm, address, pmd, _pmd);
> > -     update_mmu_cache_pmd(vma, address, pmd);
> > -     deferred_split_folio(folio, false);
> > -     spin_unlock(pmd_ptl);
> > +     if (order =3D=3D HPAGE_PMD_ORDER) {
> > +             pgtable =3D pmd_pgtable(_pmd);
> > +             _pmd =3D folio_mk_pmd(folio, vma->vm_page_prot);
> > +             _pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> > +
> > +             spin_lock(pmd_ptl);
> > +             BUG_ON(!pmd_none(*pmd));
> > +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUS=
IVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > +             set_pmd_at(mm, address, pmd, _pmd);
> > +             update_mmu_cache_pmd(vma, address, pmd);
> > +             deferred_split_folio(folio, false);
> > +             spin_unlock(pmd_ptl);
> > +     } else { /* mTHP collapse */
> > +             mthp_pte =3D mk_pte(&folio->page, vma->vm_page_prot);
> > +             mthp_pte =3D maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> > +
> > +             spin_lock(pmd_ptl);
>
> Nico,
>
> I've noticed a few occasions where my review comments have not been ackno=
wledged -
> for example, [1]. It makes it difficult to follow up and contributes to s=
ome
> frustration on my end. I'd appreciate if you could make sure to respond t=
o
> feedback, even if you are disagreeing with my comments. Thanks!

I'm sorry you feel that way, are there any others? I feel like I've
been pretty good at responding to all comments. I've also been out of
the office for the last month, so keeping up with upstream has been
more difficult, but i'm back now.

Sorry I never got back to you on that one! I will add the BUG_ON, but
I believe it's unnecessary. Your changeset was focused on different
functionality and it seems that you had a bug in it if you were
hitting that often.

Cheers,
-- Nico
>
>
> [1] https://lore.kernel.org/all/08d13445-5ed1-42ea-8aee-c1dbde24407e@arm.=
com/
>
>
> [---snip---]
>

