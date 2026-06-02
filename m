Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F48360EFF
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414171; cv=none; b=VyVIt++B6gfUeaPdYDNVcNF3FCq/GVq0bwgDEepRtIegpqoJGDsMxmR6dbTvTLvfcvXNgkXBGdsaaKFOeNiC5tshZLtLa7asX2kKQpVzKCy25LgSlJhIgtCbsgTi2XTF+33t2Q6862sq4c4zM/as9bX+57aMrIp/ketkeEctwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414171; c=relaxed/simple;
	bh=a8rzFTRZmTNeGD9TQ3lwEM3tZ9cTaD8C1O4FRKxZ4Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alJXdfr/dnXiDas1GUNQN741yRjPuG8yzrEZ8NeHRcAbQE5UAdsJLJKkqLW0Vw0F0UJVWI0vgT4dfzDszyKxNdMoT9tD5RWhyz622MceXMW5IsXaLK0zf8sc/mm2fsMCly7t8Sk7qXlaDwwNYn+LfEE+Krfi6h6rU8fWXvL683M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvBQGYZR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvBQGYZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780414168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoHOGHc6Dr79Ii3CKFCTRjW9SLXuC6GuIiX+icbDNi0=;
	b=UvBQGYZR92DCU5YJmrGnaZXVjJXQ/AKOBMTOyg9CdFZZ7dE6o/nNLhHkEPQF9l+R+az/E0
	7yaWvxTrZDCktKrz6twuPxvroESGPqt4bcalZ12+O5pf2hAVqVEtD+o9jTG4n6+Kmkeziy
	p6xAmhtotSXcNkoqG+grUJp1JUCGB4s=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-0UsBRnxTM8q0WGVbaSFk0A-1; Tue, 02 Jun 2026 11:29:27 -0400
X-MC-Unique: 0UsBRnxTM8q0WGVbaSFk0A-1
X-Mimecast-MFC-AGG-ID: 0UsBRnxTM8q0WGVbaSFk0A_1780414167
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66044a47d6fso8005721d50.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 08:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414167; x=1781018967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoHOGHc6Dr79Ii3CKFCTRjW9SLXuC6GuIiX+icbDNi0=;
        b=oDmColSGz2nH5iZFbXFV/VjTbsGLq2e45Vp+ghzyHH96GaHgw6Rik31JAX1ojkrHQ5
         cO19adOmhyHjdIhl/HWeLZM2kIsRI92xzwGpVrGKuBw6m/dVehNA2ZXGihwNre8KB3ay
         HXYZO2ytkMm+HDt/XNERV/Hk5NETYi/W3zgVGJlMZbtVARyaizVaGoqwn45mks/QO3F5
         G+kj9QL08P4HstQpkfomHT5VS6CXXhlo48xvx8fjbsWFJYzF8XLBZexjov7I3pSQn1qx
         3wQnedOfJ95pKqZ90rpd1JjDBab+2KED/yqFwWPtOfQbKTLhZ4t5MRKoxAT3Tx7wiBBz
         lOxw==
X-Forwarded-Encrypted: i=1; AFNElJ/+aH3x8rBVoIM7zi2jbFy5CxdqPAtL4P12V8CmnQhuX5UmvpRPRhBl70zLL6bMBnBlZGWEc7bZhVANnvggouhk7I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXuyyGO+b+GmmNVvZLgo13HJ7t9du5OkK6l8Z2CNfIESvGR0y
	OvIrkxa1UeK+rt+AuV6pD4NSoDr6THfWoA+iOAUchVZWvjhO1PBzAFIPSi52mpcA2+WXKlTlO67
	IG06XdrJxyBJ7HU9U6+BGc6aQjrGPBLnjtkyFdHrQisSFyxwGhoS8EiIKWt1Nmyq8ZN+B6UqE5Y
	CzTftcww5CS+e0HwryjunpLfWN67rGv88Vu+9VKB16VOO4pby8
X-Gm-Gg: Acq92OEhOp26SOjniOco1zA7fPcfSsOKT7u/7mHqPmVNcJulqniHXsDxXFJd9S98QNm
	wEzZdNsm6SLddFGrOlN4zn2YyZ8AqAQyIC9uPP7ulc0ecdUN7A1VxT3hvLy+0PredVH+IhusRxI
	yptKvS4AfSB/KKuXNDhzszsBWuLR3t4FoJkDHeEtTCtzZnU3QBeIMCOsetGZQ6IXrEbMP4ii8cS
	di6aXhZjo67XzlfKw==
X-Received: by 2002:a05:690e:4395:b0:651:bf58:446b with SMTP id 956f58d0204a3-660d5e4dcfamr221820d50.10.1780414167094;
        Tue, 02 Jun 2026 08:29:27 -0700 (PDT)
X-Received: by 2002:a05:690e:4395:b0:651:bf58:446b with SMTP id
 956f58d0204a3-660d5e4dcfamr221781d50.10.1780414166617; Tue, 02 Jun 2026
 08:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
 <20260601032804.96122-1-lance.yang@linux.dev> <f5d38f64-ab92-496d-afd3-29ccc17fec2b@kernel.org>
 <616de1a8-1cfd-40b8-b04f-7b324be40bfd@linux.dev> <6b11bf0a-769c-4ef2-ac6f-2af38200a6bc@kernel.org>
 <baa0a462-46e0-44ab-b583-c722ad253afe@linux.dev>
In-Reply-To: <baa0a462-46e0-44ab-b583-c722ad253afe@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Tue, 2 Jun 2026 09:30:06 -0600
X-Gm-Features: AVHnY4Kv1G0ugXWOd835wx5jHS-wLy0DPKwsrrM_yqPdHcBhPWzJa9aKptOmpM8
Message-ID: <CAA1CXcD7peS3WHueVgAWhhRrjBO_1b19+Xc0CfZBSO8OwJJKQw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
To: Lance Yang <lance.yang@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com, usama.arif@linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hIm5jYlBZs0_NDWfP64amkhGUI_umNImwM4MLXAzI0g_1780414167
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 4:48=E2=80=AFAM Lance Yang <lance.yang@linux.dev> wr=
ote:
>
>
>
> On 2026/6/1 18:23, David Hildenbrand (Arm) wrote:
> > On 6/1/26 11:08, Lance Yang wrote:
> >>
> >>
> >> On 2026/6/1 14:54, David Hildenbrand (Arm) wrote:
> >>> On 6/1/26 05:28, Lance Yang wrote:
> >>>>
> >>>>
> >>>> Ah, fair point.
> >>>>
> >>>> I was mostly worried about arch hooks that walk vma->vm_mm again, ra=
ther
> >>>> than only using the pte pointer passed in. For example, mips does:
> >>>
> >>> Right, a re-walk would be the real problem.
> >>>
> >>>>
> >>>>     update_mmu_cache_range()
> >>>>       -> __update_tlb()
> >>>>         -> pgd_offset(vma->vm_mm, address)
> >>>>         -> pte_offset_map(...)
> >>>>
> >>>> and __update_tlb() has this assumption:
> >>>>
> >>>>          /*
> >>>>           * update_mmu_cache() is called between pte_offset_map_lock=
()
> >>>>           * and pte_unmap_unlock(), so we can assume that ptep is no=
t
> >>>>           * NULL here: and what should be done below if it were NULL=
?
> >>>>           */
> >>>>
> >>>> So if khugepaged happens to run with current->active_mm =3D=3D vma->=
vm_mm
> >>>> here, could __update_tlb() hit the none PMD, get NULL from
> >>>> pte_offset_map(), and then dereference it?
> >>>
> >>> Likely yes -- that MIPS code is horrible. And the comment in MIPS cod=
e
> >>> even spells that out. :(
> >>>
> >>> Do you know about other code like that, or is MIPS the only one doing=
 a
> >>> re-walk and crossing fingers?
> >>>
> >>>>
> >>>> Just wanted to raise it since some arch code may still have assumpti=
ons
> >>>> like this, and the always-enable-mTHP work is getting closer ...
> >>>
> >>> Right. I assume set_pte_at() couldn't trigger something similar (re-w=
alk) in
> >>> arch code,
> >>> because we simply provide the ptep. update_mmu_cache_range() only con=
sumes the
> >>> pte.
> >>>
> >>>>
> >>>> Probably very very very hard to hit, though :)
> >>>
> >>> Delaying update_mmu_cache_range() is nasty, as we'd have to make sure=
 that
> >>> nobody can interfere in the meantime ... and the PMD lock will not be=
 sufficient.
> >>>
> >>> Maybe we could reinstall the page table with the cleared (none) entri=
es while
> >>> still holding the PTL?
> >>>
> >>> Thinking out loud:
> >>>
> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>> index 5ba298d420b7..e39b750b1e6f 100644
> >>> --- a/mm/khugepaged.c
> >>> +++ b/mm/khugepaged.c
> >>> @@ -1413,13 +1413,17 @@ static enum scan_result collapse_huge_page(st=
ruct
> >>> mm_struct *mm, unsigned long s
> >>>                   map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
> >>>           } else {
> >>>                   /*
> >>> -                * set_ptes is called in map_anon_folio_pte_nopf with=
 the
> >>> -                * pmd_ptl lock still held; this is safe as the PMD i=
s expected
> >>> -                * to be none. The pmd entry is then repopulated belo=
w.
> >>> +                * Re-insert the page table with the cleared entries,=
 but
> >>> +                * hold the PTL, such that no one can mess with the r=
e-installed
> >>> +                * page table until we updated the temporarily-cleare=
d entries
> >>> +                * through map_anon_folio_pte_nopf().
> >>>                    */
> >>> -               map_anon_folio_pte_nopf(folio, pte, vma, start_addr, =
/
> >>> *uffd_wp=3D*/ false);
> >>> -               smp_wmb(); /* make PTEs visible before PMD. See pmd_i=
nstall() */
> >>
> >> One small thing, I think we should probably keep the smp_wmb(), and ju=
st
> >> move it before the earlier pmd_populate().
> >>
> >> IIUC, the ordering we want is still:
> >>
> >>    clear old PTEs
> >>    smp_wmb()
> >>    pmd_populate()
> >>
> >> so another CPU cannot walk through the re-installed PMD and still obse=
rve
> >> the old PTEs, right?
> >
> > There is a smp_wmb() in __folio_mark_uptodate(), that should be suffici=
ent?
>
> Ah, cool! __folio_mark_uptodate() already does the job :P
>
> So yeah, no extra smp_wmb() needed here!

are we sure? that folio_mark_uptodate is done before the PTEs are
reinstalled. Then we reinstall the PMD right after. Currently
separated by the smp_wmb().

I was copying this from other THP code that performs similar PTE/PMD juggli=
ng.

I can remove it, but I'd rather air on the side of caution with this.

>
> Cheers, Lance
>

