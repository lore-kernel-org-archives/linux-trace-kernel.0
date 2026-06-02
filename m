Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4EE3D47A3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395934; cv=none; b=r17GhvDSM5b76BfmhYpvWGdZmEH127l8qyhJ4kFIJ/MFQFFrHiFs3L955m2UXAEqJopOI+uqGxMNXN2I5xK3WB5QvcRiynwGV/IyVcLgdKHRnFkI1dcW14CfYBU7o6mXWBf5WwjebvG4sWnnXdH+RC4gM7RZna6IiGMRzYrUH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395934; c=relaxed/simple;
	bh=v/mNUCzjMW3NuapFIOaBB2YWhUzZvLlhF6p5ViObTzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSlbj+odXIcmTYulD2Mv0dMsASTYiWdfOrKhiHNml5NvUfVqvsYeuEK7C0VeAqZfWVAYchrl9TrPKG2oJTtLkbNTUMvINVbWBmz7XiD8Xd98SRkIPxKB8gbT498zK8ejqDkqCBbcYM9Z/pn8xgooz3WFsGfRwiAlz1NJaQT6JmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qh2SJbMM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qh2SJbMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780395932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tz/vVgYlWzqjYdT5CgsjAyARbiWMqKQW/JOPkRDARg4=;
	b=Qh2SJbMMumu/5DJVt4QdFbyS60/DjktMyZ30i/lSOR2oRKvFTws7afyiOaZXy4Woh1b6lW
	Q6vOhlPMkpwz7MPuu6TRO4bHdX1yd8WyHOYWp1dj3DcDQSxzCDxW+TYuFSoyqv14H/hCHI
	Ra+SiSq9LEpzvai7KLjpucNPAuJY+WU=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-kCq8cLa9NZeqFra0YdqsVA-1; Tue, 02 Jun 2026 06:25:31 -0400
X-MC-Unique: kCq8cLa9NZeqFra0YdqsVA-1
X-Mimecast-MFC-AGG-ID: kCq8cLa9NZeqFra0YdqsVA_1780395931
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66034c1b31cso7171686d50.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 03:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395931; x=1781000731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tz/vVgYlWzqjYdT5CgsjAyARbiWMqKQW/JOPkRDARg4=;
        b=BqW0DHyQYG9APcE52xX9X9eUVIRElIwLgi6aYvnRvDQN8VG4DETHeU0eoP3EQN/TqA
         X86jD/cvEdfIadfR9aG3ZPREbVbP5HxjG+lbZ1s6K6vsmQSmwK6CUzs7Zq8C9Z1NByyI
         VjwFFmR1BuXqgPOSMDcFlqIMwYXQE2FqmBGlfB/VJ3sht31YxbpPXgnmIt4NEtS+E1+0
         YehMsRRiHcOV+ac9j/uyhQqNbvGtlfqCexENXDN3bhB6268RAyv3cx4qhbJV5+CGsILJ
         Z14fOPREBUO+ZqwFkY0D+YQdz+vg8kjzU2oaY9KF7QZNch9RhsJAlODbhsTLThxSCMfJ
         gpzg==
X-Forwarded-Encrypted: i=1; AFNElJ8ELdewctC1o3J6xnqQcsbi3OYss7KWa/GvvEvx6aK565+YV9LGqn/hgZ/uO9D+lGpAKoKHL+fAOenmmUmR05tfA54=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqx77B2/NvxQnfDBXBU9/dSUSP/gcgooTBpcDZXGZWRoAPB4MT
	Qg6wJISib9VTtsLJlW+j/miwqeqpR3aQ9RobLRmCh7JtYLOww89gQvis43DNsXQ9uK3mtr/A+Ti
	EzvT81gU6Q6AJPZxAgdTISZbB8TmIFwdaZHUJjQlDC4XhtuK+gKCuWo0LwRKRWMN0vC4fQ665aS
	AFdb4QOVvpPKkdKPHSgx/JN7Wj23WrHuYQm8chWtEbt8cTh/Nh
X-Gm-Gg: Acq92OFeGlvlBj++zG7OHk7glOB3Gp+XnsCWPQHsQJGmybo6AWTa1rQBABaPJ/P7IGL
	xekMhs06kBj36oBBP6JxPMzkIU4Z/dcP4zxh5jPldZcO4CYjmdXfJSmbg5c4VA0UhaUVWhdFagY
	XFGULd/g0i3nW+F34esKpWQVuGQFTBnMnTjxSp5JZnkgRWkZR/GYVzm4I6uKhAkJ06HzX2L/47g
	7NRb5+0H+nU8xMmvQ==
X-Received: by 2002:a05:690e:1595:20b0:660:5e16:f249 with SMTP id 956f58d0204a3-6605edecbf9mr9767401d50.11.1780395930758;
        Tue, 02 Jun 2026 03:25:30 -0700 (PDT)
X-Received: by 2002:a05:690e:1595:20b0:660:5e16:f249 with SMTP id
 956f58d0204a3-6605edecbf9mr9767365d50.11.1780395930340; Tue, 02 Jun 2026
 03:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <20260522150009.121603-6-npache@redhat.com>
 <ah2Ro54tMDMsPevk@lucifer>
In-Reply-To: <ah2Ro54tMDMsPevk@lucifer>
From: Nico Pache <npache@redhat.com>
Date: Tue, 2 Jun 2026 04:26:09 -0600
X-Gm-Features: AVHnY4JldSmClM5zWrsLMpr94a96n3CDQXVYIR75HwJ96w-KO0z_Xu55vTpSsPY
Message-ID: <CAA1CXcAXWWKD64YYGL2ue5iKFUiGsSq-pK2_8qvvgG6EBS079Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 05/14] mm/khugepaged: require
 collapse_huge_page to enter/exit with the lock dropped
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, 
	rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XR6Cded1zrusOTGAyrBxAsRyd_A7nk5fiMJZwEJSob4_1780395931
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:13=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wro=
te:
>
> On Fri, May 22, 2026 at 09:00:00AM -0600, Nico Pache wrote:
> > Currently the collapse_huge_page function requires the mmap_read_lock t=
o
> > enter with it held, and exit with it dropped. This function moves the
> > unlock into its parent caller, and changes this semantic to requiring i=
t
> > to enter/exit with it always unlocked.
> >
> > In future patches, we need this expectation, as for in mTHP collapse, w=
e
> > may have already have dropped the lock, and do not want to conditionall=
y
> > check for this by passing through the lock_dropped variable.
> >
> > No functional change is expected as one of the first things the
> > collapse_huge_page function does is drop this lock before allocating th=
e
> > hugepage.
> >
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> One small nit below, otherwise LGTM, so:
>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Thank you for reviewing!

>
> > ---
> >  mm/khugepaged.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index e98ba5b15163..fab35d318641 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1208,6 +1208,12 @@ static enum scan_result alloc_charge_folio(struc=
t folio **foliop, struct mm_stru
> >       return SCAN_SUCCEED;
> >  }
> >
> > +/*
> > + * collapse_huge_page expects the mmap_lock to be unlocked before ente=
ring and
> > + * will always return with the lock unlocked, to avoid holding the mma=
p_lock
> > + * while allocating a THP, as that could trigger direct reclaim/compac=
tion.
> > + * Note that the VMA must be rechecked after grabbing the mmap_lock ag=
ain.
> > + */
> >  static enum scan_result collapse_huge_page(struct mm_struct *mm, unsig=
ned long address,
> >               int referenced, int unmapped, struct collapse_control *cc=
)
> >  {
> > @@ -1223,14 +1229,6 @@ static enum scan_result collapse_huge_page(struc=
t mm_struct *mm, unsigned long a
> >
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> > -     /*
> > -      * Before allocating the hugepage, release the mmap_lock read loc=
k.
> > -      * The allocation can take potentially a long time if it involves
> > -      * sync compaction, and we do not need to hold the mmap_lock duri=
ng
> > -      * that. We will recheck the vma after taking it again in write m=
ode.
> > -      */
> > -     mmap_read_unlock(mm);
> > -
>
> NIT: Maybe worth an mmap_assert_locked()?

But it will already be unlocked here. The contract is that we enter
unlocked and exit unlocked.

Cheers,
-- Nico

>
> >       result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_nolock;
> > @@ -1535,6 +1533,8 @@ static enum scan_result collapse_scan_pmd(struct =
mm_struct *mm,
> >  out_unmap:
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> > +             /* collapse_huge_page expects the lock to be dropped befo=
re calling */
> > +             mmap_read_unlock(mm);
> >               result =3D collapse_huge_page(mm, start_addr, referenced,
> >                                           unmapped, cc);
> >               /* collapse_huge_page will return with the mmap_lock rele=
ased */
> > --
> > 2.54.0
> >
>
> Cheers, Lorenzo
>

