Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E4211A1E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 May 2025 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190245; cv=none; b=ViLXjDFuGkq5myN/cPP/zgkcpdieXP/sHWeLtmz9q+ecpIy2qWZhoKirqwEYZyTsm0EwHSIAxPSlW6mA1CdEsTZ/Ej2CURSKLbt8v2NShvdaNnd2LadDdjvcRDIiWto3NugV1n3zMLhqPiLJtNwHWACVh/ykb3J5imWDjznWKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190245; c=relaxed/simple;
	bh=yJ2br5vO6A0anKaplCB0lpB6gJg7j9WiiLocIpMSJFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9n0BDbRnSrqcvzjv9kEopODUsQ1ykeBU4BOjvWBq/LxibGeQLi/pn/Tx6jyWlAWqQZuXIY2mdXm8v/l7ES0M+oWcUGVtX7L15iN3fS9nqSwF1wcsBD1nLJpqIauM3tEojMWzDmnICPPlE73sPbw5SI6nb5xSabTTmsGo5r5a8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0DPn0sc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0DPn0sc"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso6966a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 May 2025 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746190241; x=1746795041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld8hRinh9GbkBEMDrzL6i5e2SIxAQjM/p85QdAMHIYE=;
        b=J0DPn0scdHyczIHPToxyODRtPobzWzxlQgBSb8nfrxPmCWXoXaKrOUm/U3yjHc2xIb
         KUTVH+o/Lc6STJRJlEOixQuOkgVxBE/irVpnnNgzoZv2VjmXp1xK64OHHRzu8i+QIEsY
         b23rKINdQJ+d2tUqYPDfn00dQ9mqRjWKsEfSo3+eAq1GY2sON9vpa5Axlx5Zy6/j+mE8
         KDoB/fP+or8fh1ZrpC8VackeN5EuusR9FAcxGoUqMY5CwhySxzq98Znc57qhArPfrtCb
         EnN4isZO7Oy0OqhkIttGTAj0xmI2vIR3w2dlQX+TL15al6Y7eNO3GBxr2OtITguetm5/
         2tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746190241; x=1746795041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld8hRinh9GbkBEMDrzL6i5e2SIxAQjM/p85QdAMHIYE=;
        b=d60rWLI3EoLdKqYtk4qKY2znLYvoVZvG3HClauF2CWGyih5PSwPoxpcApecuZ/yQy+
         AOl7OPGBSLabX8HM8tLbH++jecTKG7zqk29h+RsxSgjpQUMUqArVAX+LGhEUzHHSifQ1
         ubws1nxVCBSYOrNmz1notfbxgNHieitMG0A0WH1f2SERnjAAMX+XIy42oigcWGOrCkYI
         azXEcUb7FSd8MeLxWJcrvC0MTkkomtm3QtRbFZzi4g+EtoQBrWx11yaV+OpEhBn42n35
         oJXvzqpVjDnT2dsXH1bJWhToq0RV+CyukAdU4cf6ACAllsNeHb1KZDzbmvhTr8RnxpN+
         IstA==
X-Forwarded-Encrypted: i=1; AJvYcCWBkMDrWlPKUuXObSltKEeKaGEKEqsBIQ8J8QNmsTsJxLMs3OgafBZGfPTTRtjkHy+WX971CZW7sT8nJwOuWEIRabs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fZuTKtDweq2GqA2X/5T3hz1ZLOLh/21N1YpVyXnCofKoC1mk
	389RCoqJw6YG/lTh/1JSvclhYgsUliFXKl9VXMoMvuvUvL9tmu+D8VQmzmanvh0HHocGwUV5ksm
	Lpxd6nuM+VjZzq2yuv6TDPp16gHJY0P/Pd9y5
X-Gm-Gg: ASbGncsCgtucz2TdZMFORtnkn8DQEfQVn0ea61/UZUlStNVU7ubk0v16PeDse1PkXr5
	WCJL4Hj30yDX8uLjCbcrUp9G/9MQxeSB+XQVivf7wL+kvAhSz/5EjsSjYcEhe5GdxJriaded5Td
	xpDG4lUgH1jFGB4J8yxDbxUjHA/aSnvIZsJ8m6bWgSF1ShlP/B9A==
X-Google-Smtp-Source: AGHT+IG3MxGSNZIU/DLDRhXYOvvIy6yvhn86oGlso7zA/bv5//6dzg5601r9+ubOpvul9MK0F9INy9LM5qMNZeJUT5g=
X-Received: by 2002:aa7:c599:0:b0:5de:bcd9:4aa with SMTP id
 4fb4d7f45d1cf-5f918c09629mr179021a12.3.1746190241144; Fri, 02 May 2025
 05:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428181218.85925-1-npache@redhat.com> <20250428181218.85925-8-npache@redhat.com>
 <CAG48ez2oge4xs1pSz_T9L46g=wQnFyC63kQKsXwbHGRWAxQ+aw@mail.gmail.com>
 <CAA1CXcBHJbs7_DGVR929NOD5G4nkJ3LguDrL9itV8-QS+BNUpg@mail.gmail.com> <b6093db0-9b18-4b70-81bd-6c02e80ac9fa@redhat.com>
In-Reply-To: <b6093db0-9b18-4b70-81bd-6c02e80ac9fa@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 14:50:05 +0200
X-Gm-Features: ATxdqUHoBHrob4F884q8RfFXZYe_rdAyjR_yWnJbdQTKUjzn_Qy_PjvRzckdGXk
Message-ID: <CAG48ez0oe6oZ0QTDWr1rtUJFFTLO69sVpdoCmo+CxZUb6L1seg@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: David Hildenbrand <david@redhat.com>, Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
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

On Fri, May 2, 2025 at 8:29=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
> On 02.05.25 00:29, Nico Pache wrote:
> > On Wed, Apr 30, 2025 at 2:53=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> >>
> >> On Mon, Apr 28, 2025 at 8:12=E2=80=AFPM Nico Pache <npache@redhat.com>=
 wrote:
> >>> Introduce the ability for khugepaged to collapse to different mTHP si=
zes.
> >>> While scanning PMD ranges for potential collapse candidates, keep tra=
ck
> >>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> >>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes.=
 If
> >>> mTHPs are enabled we remove the restriction of max_ptes_none during t=
he
> >>> scan phase so we dont bailout early and miss potential mTHP candidate=
s.
> >>>
> >>> After the scan is complete we will perform binary recursion on the
> >>> bitmap to determine which mTHP size would be most efficient to collap=
se
> >>> to. max_ptes_none will be scaled by the attempted collapse order to
> >>> determine how full a THP must be to be eligible.
> >>>
> >>> If a mTHP collapse is attempted, but contains swapped out, or shared
> >>> pages, we dont perform the collapse.
> >> [...]
> >>> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struc=
t *mm, unsigned long address,
> >>>          vma_start_write(vma);
> >>>          anon_vma_lock_write(vma->anon_vma);
> >>>
> >>> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr=
ess,
> >>> -                               address + HPAGE_PMD_SIZE);
> >>> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _add=
ress,
> >>> +                               _address + (PAGE_SIZE << order));
> >>>          mmu_notifier_invalidate_range_start(&range);
> >>>
> >>>          pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> >>> +
> >>>          /*
> >>>           * This removes any huge TLB entry from the CPU so we won't =
allow
> >>>           * huge and small TLB entries for the same virtual address t=
o
> >>
> >> It's not visible in this diff, but we're about to do a
> >> pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
> >> entire page table, meaning it tears down 2MiB of address space; and it
> >> assumes that the entire page table exclusively corresponds to the
> >> current VMA.
> >>
> >> I think you'll need to ensure that the pmdp_collapse_flush() only
> >> happens for full-size THP, and that mTHP only tears down individual
> >> PTEs in the relevant range. (That code might get a bit messy, since
> >> the existing THP code tears down PTEs in a detached page table, while
> >> mTHP would have to do it in a still-attached page table.)
> > Hi Jann!
> >
> > I was under the impression that this is needed to prevent GUP-fast
> > races (and potentially others).

Why would you need to touch the PMD entry to prevent GUP-fast races for mTH=
P?

> > As you state here, conceptually the PMD case is, detach the PMD, do
> > the collapse, then reinstall the PMD (similarly to how the system
> > recovers from a failed PMD collapse). I tried to keep the current
> > locking behavior as it seemed the easiest way to get it right (and not
> > break anything). So I keep the PMD detaching and reinstalling for the
> > mTHP case too. As Hugh points out I am releasing the anon lock too
> > early. I will comment further on his response.

As I see it, you're not "keeping" the current locking behavior; you're
making a big implicit locking change by reusing a codepath designed
for PMD THP for mTHP, where the page table may not be exclusively
owned by one VMA.

> > As I familiarize myself with the code more, I do see potential code
> > improvements/cleanups and locking improvements, but I was going to
> > leave those to a later series.
>
> Right, the simplest approach on top of the current PMD collapse is to do
> exactly what we do in the PMD case, including the locking: which
> apparently is no completely the same yet :).
>
> Instead of installing a PMD THP, we modify the page table and remap that.
>
> Moving from the PMD lock to the PTE lock will not make a big change in
> practice for most cases: we already must disable essentially all page
> table walkers (vma lock, mmap lock in write, rmap lock in write).
>
> The PMDP clear+flush is primarily to disable the last possible set of
> page table walkers: (1) HW modifications and (2) GUP-fast.
>
> So after the PMDP clear+flush we know that (A) HW can not modify the
> pages concurrently and (B) GUP-fast cannot succeed anymore.
>
> The issue with PTEP clear+flush is that we will have to remember all PTE
> values, to reset them if anything goes wrong. Using a single PMD value
> is arguably simpler. And then, the benefit vs. complexity is unclear.
>
> Certainly something to look into later, but not a requirement for the
> first support,

As I understand, one rule we currently have in MM is that an operation
that logically operates on one VMA (VMA 1) does not touch the page
tables of other VMAs (VMA 2) in any way, except that it may walk page
tables that cover address space that intersects with both VMA 1 and
VMA 2, and create such page tables if they are missing.

This proposed patch changes that, without explicitly discussing this
locking change.

Just as one example: I think this patch retracts a page table without
VMA-locking the relevant address space (we hold a VMA lock on VMA 1,
but not on VMA 2), and we then drop the PMD lock after (temporarily)
retracting the page table. At that point, I think a racing fault that
uses the VMA-locked fastpath can observe the empty PMD, and can
install a new page table? Then when collapse_huge_page() tries to
re-add the retracted page table, I think we'll get a BUG_ON(). Similar
thing with concurrent ftruncate() or such trying to zap PTEs, we can
probably end up not zapping PTEs that should have been zapped?

> The real challenge/benefit will be looking into avoiding taking all the
> heavy weight locks. Dev has already been thinking about that. For mTHP
> it might be easier than for THPs. Probably it will involve setting PTE
> migration entries whenever we drop the PTL, and dealing with the
> possibility of concurrent zapping of these migration entries.
