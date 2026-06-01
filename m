Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD0374735
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315381; cv=none; b=LD7YUCi+Y5Ty6pMzKy/8NFq1NpmGlJ/3JWCVrCbgYxNlPif6QF8PXLB0nOziyMnDUlAk34SW4jrpsGHAxjUqQ8C1Z3NW5r0YnG48hE/vaWroJFWXDR2X9agTbOXh15sts4+7o7x3DF6DldWK6zPonRDTi37Z8vjC8WEBPKPbe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315381; c=relaxed/simple;
	bh=CFgxzmbbqYlWGxzxM7D+ZILeu3gEzT4iSuq27d1AdFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/LSWmFS4JHkUxb6tSev+2BK4kdrRtVBgFV2OP79mWSK26VB4qF/dz85nrtuCwRa1teg82kccSfi+QwJkkpjj0vQsMjAA49vR2H+fDeMyEMNq5KTOuLt3HJEjgPTAT7KhCqkfxSpfKLqh2fXmdUGsMcZQLxQu6rH4JOylW58DX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbtgNDks; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbtgNDks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780315377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/Dmnjx8evCUVN9l8RKJhflaCWiIEgpPUvqXkCQtCRk=;
	b=dbtgNDksv/mQVK1DYePrIay6+6Qg7cXoaM/Y/n7/JrjP5iRAGt+DiWECV5QajGHqSPjIbV
	E3JqbdLEKRDOXQrIL7P1O4VnEKFljAaxwcFKzuyZdxFkPsRqDthOd5p/j9unndMes+kdJ8
	Mac9B59jrKIzjtv2/h5QrgC8BfD1Cxc=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-qXSwYl9JPZ6q-si_9mKRMw-1; Mon, 01 Jun 2026 08:02:56 -0400
X-MC-Unique: qXSwYl9JPZ6q-si_9mKRMw-1
X-Mimecast-MFC-AGG-ID: qXSwYl9JPZ6q-si_9mKRMw_1780315376
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66034c1b31cso5649716d50.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 05:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315376; x=1780920176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/Dmnjx8evCUVN9l8RKJhflaCWiIEgpPUvqXkCQtCRk=;
        b=mPP0rWVJCjeHj0dpo5n3sNjqD3IjcFGwILyuPo+o7KWNcD+rXPDLRms5yxKI0KvaAy
         H+Q2sAPYhuabOEb9lB7iJTat9oDaJkXoGbpgBuPWhawBchfTZW5QF9yb9sRxgIWPn0IV
         rur2UfJy2C16HGndCyKBNXIYM4iYkDRSMmCxuv/X24EqXUKtI3HWIFn5thIaPOlmhxOW
         //eld6FcihfZ/mTrb6G9/EqegLUb7kklWqBHahw0qT1Ysl+YSAohekd6lDh89FHnxX2J
         nZhNEUczjfF65UtEmRgELCUFDvRMBkRqZENF+gStochm7mlCN5iFFj48LZuMp4Q0mcHU
         WVQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7coqrX/SstffKizKZaXp76s6W+S2QSRyKQpY8Qyt3eYAxl8JQtOZgcxfkbsNYoKffwvvJy1DOziHZ44J1RSdjEhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNM7jELwqNretFYI+xY05V3lfJKge3x8I7Crf54c/CVpo141i5
	0WYMIKhE9vrx9+sRAYghJQMGOmebmRLSrupe/PLowV2qhjCWt7mjB/UUDrYAdgW4rkHZOaNK5r3
	gktsbONN4S+pwPbIcjbL61nIqE/HxbxgeithnNL3nGerqQgzY4Q0yWO4qS9aGwfSEANPaLkMHz8
	2Yu3uInOjtrB1b9oECRsmuLcyJMsvY79uuPDqGo0KAh/JGChht
X-Gm-Gg: Acq92OGGVcl/Smzca2bfm+3M0ft4fT4zaPKZ78xkyTxvuqnRIjCd/FURkH2EIgfrzEm
	TWLosfEDtIFhkzrH5ij4LVs/HbTMdX3fWN6I2Tn41Ssj40Td+Pyp/NxSyS0SQ0mA4ZQ06qVbtLU
	I34VUJQfqDM0/yQqFn5yL/m9jZLJdMMk1b6j+0/SYvuKjgbLTnRxK5s1zQfXQKRNmFq4a0oPD7/
	/9kdxGhfmdhvHIJHA==
X-Received: by 2002:a05:690e:1916:b0:660:4886:922c with SMTP id 956f58d0204a3-6605ef3d9ddmr8301959d50.17.1780315306018;
        Mon, 01 Jun 2026 05:01:46 -0700 (PDT)
X-Received: by 2002:a05:690e:1916:b0:660:4886:922c with SMTP id
 956f58d0204a3-6605ef3d9ddmr8297124d50.17.1780315266993; Mon, 01 Jun 2026
 05:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-12-npache@redhat.com> <20260531071845.10875-1-lance.yang@linux.dev>
 <6a9f062c-8376-4f83-90a9-8b167f925dc6@linux.dev>
In-Reply-To: <6a9f062c-8376-4f83-90a9-8b167f925dc6@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Mon, 1 Jun 2026 06:01:46 -0600
X-Gm-Features: AVHnY4Ifoce-ym9rt4H7XGBtAQemIZHZ2nK_-zOeAzqon_03N1y6C3UXAt3eth4
Message-ID: <CAA1CXcCfww9X-f2Vb=ipz8tY2nMNnMx5_58Ozz63tvZTz_wpOw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: Lance Yang <lance.yang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, liam@infradead.org, ljs@kernel.org, 
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
X-Mimecast-MFC-PROC-ID: 4ar6MlxNjQvi4T29AvNPO9CEfx5vsjw9Wx998gNVD0g_1780315376
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 2:48=E2=80=AFAM Lance Yang <lance.yang@linux.dev> w=
rote:
>
>
>
> On 2026/5/31 15:18, Lance Yang wrote:
> >
> > On Fri, May 22, 2026 at 09:00:06AM -0600, Nico Pache wrote:
> > [...]
> >> @@ -1587,10 +1749,11 @@ static enum scan_result collapse_scan_pmd(stru=
ct mm_struct *mm,
> >>      if (result =3D=3D SCAN_SUCCEED) {
> >>              /* collapse_huge_page expects the lock to be dropped befo=
re calling */
> >>              mmap_read_unlock(mm);
> >> -            result =3D collapse_huge_page(mm, start_addr, referenced,
> >> -                                        unmapped, cc, HPAGE_PMD_ORDER=
);
> >> -            /* collapse_huge_page will return with the mmap_lock rele=
ased */
> >> +            nr_collapsed =3D mthp_collapse(mm, vma, start_addr, refer=
enced,
> >> +                                         unmapped, cc, enabled_orders=
);
> >> +            /* mmap_lock was released above, set lock_dropped */
> >>              *lock_dropped =3D true;
> >> +            result =3D nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
> >
> > Hmm ... don't we lose the allocation-failure result here?
> >
> > Previously collapse_scan_pmd() propagated SCAN_ALLOC_HUGE_PAGE_FAIL fro=
m
> > collapse_huge_page(), so khugepaged would call khugepaged_alloc_sleep()
> > in khugepaged_do_scan().
> >
> > Now if allocation fails and nr_collapsed stays 0, we just return
> > SCAN_FAIL. So we won't back off via khugepaged_alloc_sleep() anymore?
>
> Looks like this is a more general issue with mthp_collapse() only
> returning nr_collapsed.
>
> For example, SCAN_PMD_MAPPED used to be propagated too, and
> madvise_collapse() treats that as success. With the new code, if
> nothing was collapsed by this call, that can also become SCAN_FAIL ...
>
> So I think we should keep both.

Yeah I thought about this before, but more regarding the "incorrect"
propagation of errors; I didn't consider that those results were
actually being considered.

I actually had a patch to track the last_failure (with some
prioritization on certain results). I think that would solve this
issue.

Thanks for reminding me to improve this.

Depending on how the rest of the reviews go, I can either send up a
follow up series to do some more cleanups and improvements of the
current approach or we can send out a v19.

Cheers,
-- Nico

>
> Cheers, Lance
>

