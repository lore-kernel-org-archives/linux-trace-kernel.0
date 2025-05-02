Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD7256C81
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 May 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199620; cv=none; b=Dc3jct0Hm53uY1tudPKAY7T3nr8kKKFQo73DfOlpB9j3iH3g7VM76eo3I/5QVHEMSV4PDS70rjHrrVaMnf4ifIKfoYvVmdupnlhTjoYeadrLF4F7XCfj1/0btbuhtfcbR4+aAYV221NY741Zgh11XudA2lVXRnzhAzbKYOffG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199620; c=relaxed/simple;
	bh=hLW15ayYi6SnXVYov9TgVyvpQxM/q5FOvyu0WDhrQvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2GgcU2BZZyaFCRqamUVIF440+G14PNCcgct0cuikB9ge8mcBMumHRPp6HS39jk31KMXIQOfhd5kMnqGM70LPG9niGmBswshjd+MhvHEksr+oYEMETmyDkMi2GFLa1iRQK2sAJxv8zn4vJ1PJgTRxuSYmkrIxc3cNd19dG63IqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DzfUgjCl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzfUgjCl"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f88f236167so11317a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 May 2025 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746199617; x=1746804417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHb0ZzxGlBB6NHKFNbHGJJeCMu/az8eLbQ7nlZew+9Q=;
        b=DzfUgjClzI4/KUAoSMf5aiTAtZXkE51WRvNVskMeGrKFnGopa52FeE3Pgy1vmRVTU1
         veJQlGCL9/Qx0EkbcMz8je9IW1LKWU/tPhOKhQhWY8B/PtSjyfyw3imM9bNlFdy3WQrR
         m1yxIa6faJI5VjIJdeVpS/uNgRscH/gJOAixDOvgRANgj8wqcNYoAfXnb8J8LKKkc1AT
         rG8P18t/ekoAQWY45wsIFzqWwtiC4s07o8zwFUlkz1rk2ONQMxiDTKOPsDhlIY7CKyl9
         ZTuCKdJCCPFBvm7RhuOEpFA9ihOp3SE22rMMcxdKbBTb35UeuOMnOcvWMhAuQD+dmThI
         PV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199617; x=1746804417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHb0ZzxGlBB6NHKFNbHGJJeCMu/az8eLbQ7nlZew+9Q=;
        b=UxjylEqlYV+yqxxPoKbJS7IpDh63sxQkhIGAMqoOvvs306m4JWPXuHzucXt3OHuKUE
         JyQAYy7TRDh8z+3qyorp7sfjdfBaZuJv705lBPX8Vs36TUbIkvKugK5myRCjAREzhqz+
         hkbHq9wWzhwz2CyMXrcnTsV4GTaWObOksvwMmjob6IN4jJYCh6z8UXfwEv92l/5kpOPj
         JkLNlFOGAMsNc5lvPy4VlCzp/FyD6VAlEQ13+uaOA6eLw9eGmoq4L5obqMFJoGX7vENc
         ueXD/5CxkIcVxuPbxx25Lg4obdIC2RtuL87U41R5AYNecEdPb+KtqAxNwCYXMeL9st+W
         UydQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqyZHm+aAjdAr7ow6zYci0WgCWgVdiyxlbHYTuFFxjm3qQNaYpqW1h034wU8JM571o0ySRLFieykWIeRj8aPm6Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhg56ONp/0uNVJfEZ8x1n6KJf4uKCv6nlOaJ2oq2caswozZ0Y
	4CA6ZPvsuh7xmviUX/TNS+dmKS+qJvMBQvc7hbTo9OhofH1p9RG0uNaZHGjfBuOZs99WsfuR34U
	H5wmkRA+AUVLR0BuIonyhElWIM4kZEbx8GlMQ
X-Gm-Gg: ASbGncsYN/K8LEXBqGdi+tVkzV0usxlcgZF39BsEMKha62/DDaL0E0J9r7B685U/FxO
	g5sN+A9hRk4foRqBCqOx/kHD2eHhaurWiDf4t9WINB11nfNOHGLYScwMAhL1Y4BWmIImgdw6kZF
	GRbyS0rRtZ/3BMxPq63Y48wMVUijEU4fgVgnN2NvLQI7ta+FZfIg==
X-Google-Smtp-Source: AGHT+IE/jsfd3H3yBbKiN8dMrqyRJlNNmsTZdJpQFgt4OoMxHc8Yf7S8yh/e6oWWssFQ84fXTZBdZr1AlAKZB/MOXHQ=
X-Received: by 2002:a50:8719:0:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5f918c0853dmr175309a12.3.1746199616297; Fri, 02 May 2025
 08:26:56 -0700 (PDT)
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
 <b91af3df-643e-4131-96e7-2680f322194d@redhat.com>
In-Reply-To: <b91af3df-643e-4131-96e7-2680f322194d@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 17:26:20 +0200
X-Gm-Features: ATxdqUEpkMTf_H-rMFPW7kzp3FCFlwgrzXrEa9BFkSIOp67pix4PyNJ7gFGimKI
Message-ID: <CAG48ez25Wo7BSt4dn3v+xO0mojvjtBpd02kaAu7kn_+AfgSrNQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:19=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 02.05.25 14:50, Jann Horn wrote:
> > On Fri, May 2, 2025 at 8:29=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >> On 02.05.25 00:29, Nico Pache wrote:
> >>> On Wed, Apr 30, 2025 at 2:53=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> >>>>
> >>>> On Mon, Apr 28, 2025 at 8:12=E2=80=AFPM Nico Pache <npache@redhat.co=
m> wrote:
> >>>>> Introduce the ability for khugepaged to collapse to different mTHP =
sizes.
> >>>>> While scanning PMD ranges for potential collapse candidates, keep t=
rack
> >>>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> >>>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER pte=
s. If
> >>>>> mTHPs are enabled we remove the restriction of max_ptes_none during=
 the
> >>>>> scan phase so we dont bailout early and miss potential mTHP candida=
tes.
> >>>>>
> >>>>> After the scan is complete we will perform binary recursion on the
> >>>>> bitmap to determine which mTHP size would be most efficient to coll=
apse
> >>>>> to. max_ptes_none will be scaled by the attempted collapse order to
> >>>>> determine how full a THP must be to be eligible.
> >>>>>
> >>>>> If a mTHP collapse is attempted, but contains swapped out, or share=
d
> >>>>> pages, we dont perform the collapse.
> >>>> [...]
> >>>>> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_str=
uct *mm, unsigned long address,
> >>>>>           vma_start_write(vma);
> >>>>>           anon_vma_lock_write(vma->anon_vma);
> >>>>>
> >>>>> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, ad=
dress,
> >>>>> -                               address + HPAGE_PMD_SIZE);
> >>>>> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _a=
ddress,
> >>>>> +                               _address + (PAGE_SIZE << order));
> >>>>>           mmu_notifier_invalidate_range_start(&range);
> >>>>>
> >>>>>           pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> >>>>> +
> >>>>>           /*
> >>>>>            * This removes any huge TLB entry from the CPU so we won=
't allow
> >>>>>            * huge and small TLB entries for the same virtual addres=
s to
> >>>>
> >>>> It's not visible in this diff, but we're about to do a
> >>>> pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
> >>>> entire page table, meaning it tears down 2MiB of address space; and =
it
> >>>> assumes that the entire page table exclusively corresponds to the
> >>>> current VMA.
> >>>>
> >>>> I think you'll need to ensure that the pmdp_collapse_flush() only
> >>>> happens for full-size THP, and that mTHP only tears down individual
> >>>> PTEs in the relevant range. (That code might get a bit messy, since
> >>>> the existing THP code tears down PTEs in a detached page table, whil=
e
> >>>> mTHP would have to do it in a still-attached page table.)
> >>> Hi Jann!
> >>>
> >>> I was under the impression that this is needed to prevent GUP-fast
> >>> races (and potentially others).
> >
> > Why would you need to touch the PMD entry to prevent GUP-fast races for=
 mTHP?
> >
> >>> As you state here, conceptually the PMD case is, detach the PMD, do
> >>> the collapse, then reinstall the PMD (similarly to how the system
> >>> recovers from a failed PMD collapse). I tried to keep the current
> >>> locking behavior as it seemed the easiest way to get it right (and no=
t
> >>> break anything). So I keep the PMD detaching and reinstalling for the
> >>> mTHP case too. As Hugh points out I am releasing the anon lock too
> >>> early. I will comment further on his response.
> >
> > As I see it, you're not "keeping" the current locking behavior; you're
> > making a big implicit locking change by reusing a codepath designed
> > for PMD THP for mTHP, where the page table may not be exclusively
> > owned by one VMA.
>
> That is not the intention. The intention in this series (at least as we
> discussed) was to not do it across VMAs; that is considered the next
> logical step (which will be especially relevant on arm64 IMHO).

Ah, so for now this is supposed to only work for PTEs which are in a
PMD which is fully covered by the VMA? So if I make a 16KiB VMA and
then try to collapse its contents to an order-2 mTHP page, that should
just not work?
