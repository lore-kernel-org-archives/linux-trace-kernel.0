Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41733383C9D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217384; cv=none; b=jayjOVO74vLITt1WFaRqNyscaQVw981zbTjtXOtdCDw1wqWh+XnuG1TZoqTFTQhbemyeXBnui5OHxg/SaLgdnPp+oNVNhPWDERT+DrI9M55LKNmChO2qiCbyu5CGTSKX+fII3mk0WHCfQj2XScxsORMh+yMvkOl6gykMYYqIk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217384; c=relaxed/simple;
	bh=M/SnnbqoU4cRuxbwBYw5TcDVBwjkEi7HVMxFL8F6nEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJSzIJjmZeLdBbBHQvBpG0HRZbUWMzzh9uPQlsQkt+FJvvLvtCzilnYyB4kODZ0oNWDUtjkNaC3NZ54/tLLn8UzVx9Oh9ifGbEvlTkv8PKkqF8pKWyjk9MLZ2zC9pTYu3y7/NzfPTL3yawgsMFe3MaufZdygTDu9op9DoFg2ULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxsFsWRV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxsFsWRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779217382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVAA2tyy87o83ai/87dFFBv/pFOI8NrPweDff+Gjdvo=;
	b=ZxsFsWRVNDuVLbcY9E8D98bENZYIbWvHOy65Ivf+PvmCmnBjsFEkFO1EV7oSesLSTzzyvB
	4D9i7ynlTi+T2fdkbBTfhWVw5zVPqzMVaagghok+wJn4UWSRflTY3JbzEvOZ59H/8BuVpt
	VMB5Lrs2JmlSWdysa3btD2VPSGiTFII=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-ssW_qRTeN32T9Fi3M44xPQ-1; Tue, 19 May 2026 15:02:59 -0400
X-MC-Unique: ssW_qRTeN32T9Fi3M44xPQ-1
X-Mimecast-MFC-AGG-ID: ssW_qRTeN32T9Fi3M44xPQ_1779217378
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-651bd2131f0so8045581d50.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 12:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217378; x=1779822178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVAA2tyy87o83ai/87dFFBv/pFOI8NrPweDff+Gjdvo=;
        b=A2W/tfy80ozOvKmRi2unQUS1hO8bmKAFg9uNUylC/V6XDz4SyNxHh0+WsuKfhIgePn
         CEMzaofbKuDV2/34NndYv6QyCvYxQxGpEINN9j8c0BzBjJnCHEGt7hY+F3GocvXDv3y2
         R4S0viIw18wBzzcyPLxHGq9+WmgLI4nPk0EkS8vKklzuwYbUgOUbDmJ/b4AKZV3Iu88I
         hh1IhwPd+/O6j8GrhDfDYtLTkPSK7CH/bv1y8IQ1iTaJuvg7onhhHCM5/Tgm5bRjCmeA
         5Fcllls2bXI3be0zEuS9o7Ubl3wM0/7gYKr3QBOoSVVX27wh1gLoDZdFXlxVVlK4cNgT
         jHzw==
X-Forwarded-Encrypted: i=1; AFNElJ/yPz0/BJUTAfAKL+KjwDwtLTVJJfIPCRQLRMsoCkwmlE62yHZujKGv2v44gg8k9umCicT6aRF/9BXC+AV5Vg67m6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZH66dODMhKwkYct3OOiImggjUAoHxrgsrwml+zwKIoKKQPbcF
	2xRKYNq3FcqlSEjLX09bts7DyhXdU2zpb3TO+MVx+YDjIiUvKRBCLzRNuTd2XlBRfBI/QxY/mn3
	itNKwE052UgJHAa5aruI0QKUm0b9hhTiDOq2S5W/Uoa8cnXrayY8t1TjYNoVn8RO2Fw2q3f9EQI
	aVTsdh+Cxvl/yxwG1rk1FHREB+X0elAz/V3kN+a6S6G4xw0PgSCf4YCqq9E/s=
X-Gm-Gg: Acq92OGHWZdg20F4XTR/SIFMpAoDfBkm0ix2Xqf65NP5vHULiVNCH2hYOwTkia63yU3
	ZnJ+nWl2DuEX6MgNQhffB/YSXkbvTr+Y0f64vRlpyCx2Ro45GWpDQfp/b90K0AB20d07R2UAMnE
	ABWqpJ9UwiXybPXVdT3JK55opE8ECGfasbtbMKYPrgBcD3knzMpbU/GIrWhL9TrvptrsysrqIvr
	Xmduw==
X-Received: by 2002:a05:690e:1501:b0:650:38c4:9d80 with SMTP id 956f58d0204a3-65e22808b89mr19193831d50.35.1779217378226;
        Tue, 19 May 2026 12:02:58 -0700 (PDT)
X-Received: by 2002:a05:690e:1501:b0:650:38c4:9d80 with SMTP id
 956f58d0204a3-65e22808b89mr19193751d50.35.1779217377583; Tue, 19 May 2026
 12:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518115553.3513034-1-usama.arif@linux.dev> <51db205d-77cf-416f-bfe5-fd9d0b12c433@linux.dev>
In-Reply-To: <51db205d-77cf-416f-bfe5-fd9d0b12c433@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Tue, 19 May 2026 13:03:23 -0600
X-Gm-Features: AVHnY4LOZz9hIpEKrtfLZuWF4c69rvSr03brNz_SdNAbFptVm56-2ZdU64Y6lF8
Message-ID: <CAA1CXcCTnEP85mdawwfxKVP4cRqC5wLCXe47kf6w7F5Qn2DEwg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v17 02/14] mm/khugepaged: generalize alloc_charge_folio()
To: Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
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
X-Mimecast-MFC-PROC-ID: isyRrcURgByvpTGQvNL7440GhTJNjmlN6RqVErBA-7I_1779217378
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 8:50=E2=80=AFAM Lance Yang <lance.yang@linux.dev> w=
rote:
>
>
>
> On 2026/5/18 19:55, Usama Arif wrote:
> [...]
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index 979885694351..f0e29d5c7b1f 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -1068,21 +1068,26 @@ static enum scan_result __collapse_huge_page_s=
wapin(struct mm_struct *mm,
> >>   }
> >>
> >>   static enum scan_result alloc_charge_folio(struct folio **foliop, st=
ruct mm_struct *mm,
> >> -            struct collapse_control *cc)
> >> +            struct collapse_control *cc, unsigned int order)
> >>   {
> >>      gfp_t gfp =3D (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpm=
ask() :
> >>                   GFP_TRANSHUGE);
> >>      int node =3D collapse_find_target_node(cc);
> >>      struct folio *folio;
> >>
> >> -    folio =3D __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nm=
ask);
> >> +    folio =3D __folio_alloc(gfp, order, node, &cc->alloc_nmask);
> >>      if (!folio) {
> >>              *foliop =3D NULL;
> >> -            count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> >> +            if (is_pmd_order(order))
> >> +                    count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> >> +            count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
> >>              return SCAN_ALLOC_HUGE_PAGE_FAIL;
> >>      }
> >>
> >> -    count_vm_event(THP_COLLAPSE_ALLOC);
> >> +    if (is_pmd_order(order))
> >> +            count_vm_event(THP_COLLAPSE_ALLOC);
> >> +    count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
> >> +
> >
> > The vmstat THP_COLLAPSE_ALLOC counter is pmd order only.
> > But after this we have
> >
> >       count_memcg_folio_events(folio, THP_COLLAPSE_ALLOC, 1);
> >
> > which is not being guarded with is_pmd_order().
>
> Good catch!
>
> >
> > I think we want this to be pmd order only as well so that
> > the meaning of the vmstat and cgroup counter remains the same?
>
> Agreed. THP_COLLAPSE_ALLOC should remain PMD order only for
> vmstat and memcg events.
>
> So this should be guarded with is_pmd_order() as well :)

Thanks Usama, I added that.

>
> Cheers, Lance
>

