Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5451898E9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 May 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199849; cv=none; b=lc0sIVqLb/AzFfl7nxA6pJJ3LrVxTqIN1pkfdna/jubFeUD+a4PoG/mqRJmcDGPKqDhClEkTx7M51VQX0bbCSLqCmLX2hSftk2ddMXWpOsmyBDzqLrbGQx+nz1A7umJe9Evj5pIev3faVwldYF6qLGlpw1SVh1waHOYHL13ou1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199849; c=relaxed/simple;
	bh=BIFWU+BQxI+ybrEDzGvM0RmDpuDQig3eWd60cE/H7E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egsgesQzOjC717vDdtgSjXgTltHRikzuyqIhQGWl9dR+IP7+qwNb9cuQB+dowPVfdsOg9Dqpra86ucj5vO9tVIRbV+rUb2MqugOExnGyB2bNDEEEhurOI/C98Bc6iFpbMMrZJwbvQ/Um73YMXBNHj+oiVxi0wEQXLaLWbPi3+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPk9ykYN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPk9ykYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746199846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkRh4xfxcDiGVCznroJyFPZrZVvXnyniPVMlI+7tnp0=;
	b=QPk9ykYN/Q1PNg0HArzusOFpUgoz/NDPdCO4D+CkH8btTFPvoWXsSHehUVGHgI8tlghIM6
	/1xe7hBkYGOezZ3nFO1EN2f5WukjXVQW9cbvruoSwBoVR2tmS0Hf3g9N+V3EID6rWHLgJX
	wjVy863FgYQL808pHpyybqsagxYyrMA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-e9DVoSTUNlKmolrinUfQjg-1; Fri, 02 May 2025 11:30:43 -0400
X-MC-Unique: e9DVoSTUNlKmolrinUfQjg-1
X-Mimecast-MFC-AGG-ID: e9DVoSTUNlKmolrinUfQjg_1746199843
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-703ad0aaeebso28433447b3.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 May 2025 08:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199843; x=1746804643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkRh4xfxcDiGVCznroJyFPZrZVvXnyniPVMlI+7tnp0=;
        b=hNdGPXzP2MvxxvFFgdIsrbiI78K00ME3VAiGFZucsdermqYSw2UBvyCxHDhMhwx1xq
         gJ8iX0ARHHqQhezuw8CZ8QkAi5sWMXNhW5odw7dmXOLsqUBEo9l+ki7SBeA9TL/NPmUf
         MATXfjtJGLi4hvW4bUjyHXCQG/WkweXK/qSt/hYwuU93LmOaL6zK76vauYA5GNDvm7fV
         d2uMeuTXwOvNC4zOrNhmjCV0IF5H1Lh3rsSnoXeLjX1T7D1yawF9tEpJc/UlhxW2h5h5
         Yd5J3dtY2G37Yzn2pbV0KJ4aENHG2730uBFuXc0kaVHvBROsDDDIcbg5996hu3N8X+ht
         in9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1KGlDCRNaYRjL8JEuGHJghM+NNdnrtcMqt/2IgZveJdcr7icd05wHYwvQPxpSviYBWzogWDwVwDjG690+JqIGq1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9tQggnbIt2AA+B5WElWqdEiXUbWw9t/v1pgrpQaGJmT2ESYCC
	sL6kqqrPZCjHLCrVW0aLt1KqwagoXdzBG9ZH1KAATuRXbjwFF/elmcWO5KqRukX1EwYEaD4CW6B
	rhy/eE2r92Uo4mnWLqBs6PpZvOjYvx1deg75eX0aFNFMe5nBTkM9OlZwGMxsNT0H+lIwez3PaNP
	eO3b2iWLTYeSn8ppyfPUb0CMrbL4gsQL/gVv0x0TyxVIql
X-Gm-Gg: ASbGncsXegblVukHbi2CStV7aRCFy4D99P33L+0Od6GlyLaiabAtJn5RVFuXDqv75PZ
	mYi59CeEnZpuHTDjIIhrk9OsAvzKHg9WG79dCtKjleX+LQW7xMksL7IIi8cvX1GhVl01ekg==
X-Received: by 2002:a05:6902:1b8a:b0:e73:1bce:cc9 with SMTP id 3f1490d57ef6-e7565659e7fmr4340355276.41.1746199843127;
        Fri, 02 May 2025 08:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD6u8L0lnSuVxL/j3o/HQoXiJHgTftmzjv4yoMTN8vHad/uToYdYiOCpNgDW/bu4MUj8nb7B5bHGeWlfpjB0I=
X-Received: by 2002:a05:6902:1b8a:b0:e73:1bce:cc9 with SMTP id
 3f1490d57ef6-e7565659e7fmr4340275276.41.1746199842658; Fri, 02 May 2025
 08:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428181218.85925-1-npache@redhat.com> <20250428181218.85925-8-npache@redhat.com>
 <CAG48ez2oge4xs1pSz_T9L46g=wQnFyC63kQKsXwbHGRWAxQ+aw@mail.gmail.com>
 <CAA1CXcBHJbs7_DGVR929NOD5G4nkJ3LguDrL9itV8-QS+BNUpg@mail.gmail.com>
 <b6093db0-9b18-4b70-81bd-6c02e80ac9fa@redhat.com> <CAG48ez0oe6oZ0QTDWr1rtUJFFTLO69sVpdoCmo+CxZUb6L1seg@mail.gmail.com>
 <b91af3df-643e-4131-96e7-2680f322194d@redhat.com> <CAG48ez25Wo7BSt4dn3v+xO0mojvjtBpd02kaAu7kn_+AfgSrNQ@mail.gmail.com>
In-Reply-To: <CAG48ez25Wo7BSt4dn3v+xO0mojvjtBpd02kaAu7kn_+AfgSrNQ@mail.gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 2 May 2025 09:30:15 -0600
X-Gm-Features: ATxdqUER09h9rU5R_TsgAlu2Vl2YcDHMhrm313BXUDsCp0-N15muBn86mxdYUg8
Message-ID: <CAA1CXcBn3eZpcdzsG5DRNBa+rFBg1dQjssC=SYyXW5_7fDmwXg@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org, 
	peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com, 
	hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
	rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2fOItowwfrbkUgbuXO_dxJv-xLjkC96qmf6N--t_ce0_1746199843
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 9:27=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, May 2, 2025 at 5:19=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 02.05.25 14:50, Jann Horn wrote:
> > > On Fri, May 2, 2025 at 8:29=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> > >> On 02.05.25 00:29, Nico Pache wrote:
> > >>> On Wed, Apr 30, 2025 at 2:53=E2=80=AFPM Jann Horn <jannh@google.com=
> wrote:
> > >>>>
> > >>>> On Mon, Apr 28, 2025 at 8:12=E2=80=AFPM Nico Pache <npache@redhat.=
com> wrote:
> > >>>>> Introduce the ability for khugepaged to collapse to different mTH=
P sizes.
> > >>>>> While scanning PMD ranges for potential collapse candidates, keep=
 track
> > >>>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each b=
it
> > >>>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER p=
tes. If
> > >>>>> mTHPs are enabled we remove the restriction of max_ptes_none duri=
ng the
> > >>>>> scan phase so we dont bailout early and miss potential mTHP candi=
dates.
> > >>>>>
> > >>>>> After the scan is complete we will perform binary recursion on th=
e
> > >>>>> bitmap to determine which mTHP size would be most efficient to co=
llapse
> > >>>>> to. max_ptes_none will be scaled by the attempted collapse order =
to
> > >>>>> determine how full a THP must be to be eligible.
> > >>>>>
> > >>>>> If a mTHP collapse is attempted, but contains swapped out, or sha=
red
> > >>>>> pages, we dont perform the collapse.
> > >>>> [...]
> > >>>>> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_s=
truct *mm, unsigned long address,
> > >>>>>           vma_start_write(vma);
> > >>>>>           anon_vma_lock_write(vma->anon_vma);
> > >>>>>
> > >>>>> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, =
address,
> > >>>>> -                               address + HPAGE_PMD_SIZE);
> > >>>>> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, =
_address,
> > >>>>> +                               _address + (PAGE_SIZE << order));
> > >>>>>           mmu_notifier_invalidate_range_start(&range);
> > >>>>>
> > >>>>>           pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary =
*/
> > >>>>> +
> > >>>>>           /*
> > >>>>>            * This removes any huge TLB entry from the CPU so we w=
on't allow
> > >>>>>            * huge and small TLB entries for the same virtual addr=
ess to
> > >>>>
> > >>>> It's not visible in this diff, but we're about to do a
> > >>>> pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
> > >>>> entire page table, meaning it tears down 2MiB of address space; an=
d it
> > >>>> assumes that the entire page table exclusively corresponds to the
> > >>>> current VMA.
> > >>>>
> > >>>> I think you'll need to ensure that the pmdp_collapse_flush() only
> > >>>> happens for full-size THP, and that mTHP only tears down individua=
l
> > >>>> PTEs in the relevant range. (That code might get a bit messy, sinc=
e
> > >>>> the existing THP code tears down PTEs in a detached page table, wh=
ile
> > >>>> mTHP would have to do it in a still-attached page table.)
> > >>> Hi Jann!
> > >>>
> > >>> I was under the impression that this is needed to prevent GUP-fast
> > >>> races (and potentially others).
> > >
> > > Why would you need to touch the PMD entry to prevent GUP-fast races f=
or mTHP?
> > >
> > >>> As you state here, conceptually the PMD case is, detach the PMD, do
> > >>> the collapse, then reinstall the PMD (similarly to how the system
> > >>> recovers from a failed PMD collapse). I tried to keep the current
> > >>> locking behavior as it seemed the easiest way to get it right (and =
not
> > >>> break anything). So I keep the PMD detaching and reinstalling for t=
he
> > >>> mTHP case too. As Hugh points out I am releasing the anon lock too
> > >>> early. I will comment further on his response.
> > >
> > > As I see it, you're not "keeping" the current locking behavior; you'r=
e
> > > making a big implicit locking change by reusing a codepath designed
> > > for PMD THP for mTHP, where the page table may not be exclusively
> > > owned by one VMA.
> >
> > That is not the intention. The intention in this series (at least as we
> > discussed) was to not do it across VMAs; that is considered the next
> > logical step (which will be especially relevant on arm64 IMHO).
>
> Ah, so for now this is supposed to only work for PTEs which are in a
> PMD which is fully covered by the VMA? So if I make a 16KiB VMA and
> then try to collapse its contents to an order-2 mTHP page, that should
> just not work?
Correct! As I started in reply to Hugh, the locking conditions explode
if we drop that requirement. A simple workaround we've considered is
only collapsing if a single VMA intersects a PMD. I can make sure this
is more clear in the coverletter + this patch.

 Cheers,
-- Nico
>

