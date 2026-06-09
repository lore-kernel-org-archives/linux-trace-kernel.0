Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42D3F8ECC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002188; cv=none; b=bhKOeyF5DhDQojC0OEO8uTlLmjQQr8xOO7XkznyPnhWRPXI4FmkYWeB11J/5yHQLiJKENTNOJYw/qjyh/Ex2hYc85xCVdMqKvafZtdTEnqJj5MOBpzeTKytcBpjpjqiSg75SC8zmihXfUoKsA6RhZj0f85wSfMY4JNhMh7pMYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002188; c=relaxed/simple;
	bh=6CAvEDz43yKdOGhFNUEWaYf/+bgtBO1ehTPPArgHn20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzKRx0BzhG4Rg/SgSPxeTVHDs8Nf/p3ITD8JtY0QLsxSI43jmbtl1hOijtdxIE6rxv2IihJvy9jGy5+IM4YJIjto6Z0UhdUYbvFw64HvkFMRctL8Gh9f9TC2ayZ4TcJKBfyZ66u5tH2+TiPeGopBFY6vz4JLCG6Fjb+fplWUrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3jKzHFN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3jKzHFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781002186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oybSjy/BUCusB5v0qku6caRMlW4QF0kXV4iZvPCHaIo=;
	b=c3jKzHFNDJwEUkxjLjXAjnr8WHGpu4C/jVbXNZukTYGoE56CXmp01U1ob1+zfKxEfc8HCb
	c+mPOhqA4XIk79ThuGw4MOdznOZOY1ZUzBlGCYUFnKUQwSrlFSi4YYunLEetuusgLrY6Gx
	2pGbpnD3pSfyI7VzwTXlxZQXTa2I0Js=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-OmWCniztOritVWgr_i2o8g-1; Tue, 09 Jun 2026 06:49:45 -0400
X-MC-Unique: OmWCniztOritVWgr_i2o8g-1
X-Mimecast-MFC-AGG-ID: OmWCniztOritVWgr_i2o8g_1781002185
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-660555be5a0so8406702d50.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 03:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002185; x=1781606985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oybSjy/BUCusB5v0qku6caRMlW4QF0kXV4iZvPCHaIo=;
        b=XH5vtHZbNLNM5zwlko8j2IQ7tZxEj9RWTD/bCRol7sLSRatiDSGNMiAQWnY58YbwaO
         wqzyZSAzUp24lRaUDP4Z4txyaf+KMlGXVVC86z63OGL2VKXHNDOYuxqGTEv/uHT6/nX1
         ecrXyRv8VDkwj2nVEv+6klqkCXfrf1X5wb9aaPscC5KnnAgs/5ZUCYn0UNWYKx5s0lmp
         UjeB+vKJ1Rcw0IBbMk4O+u3q6CxEfUddXhPt2Cs8kgdOtBZ7Wm9ZUjzMAnfMciZqe9XE
         nImJ9jA4lrd+ubQw4TbGLv3QdSS66bFAAmDtNU0YFnZQYbaYL4lvKF3tjmvDT+01/8yJ
         +AFg==
X-Forwarded-Encrypted: i=1; AFNElJ/QWZhxl2FbSnPJKXRhOkJjAOwLhyChO3e5nIjf6FtaPFpNOgky0u3Dc/2tUTcYEGQCNxTN5Zoy9FNa/ltsEM3qQE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/QpKR+VpiRYXL4iDDgsChytahXTnRS0SVWd6UM5S2o2tplbo
	D9IvTRZQ/XavxS/oI3VB6nB+ochcN13RfiQPAPERyrOAFZdortuEh1TPfpgNugbbzYua+qU5kjH
	k0ltsImdNoESjCr46to0RtDPM4OpHul1RdT2TIzbXUcXOcBx8WDl9+F/VWMBcR5PL2BiCCKb7Tb
	iZgD4lm2OXPBjfooB27NN7YEaZhkerpTvw/5Fs3A3Pt5hVbCVg
X-Gm-Gg: Acq92OGj1KqEG+UDKHqOKNK5gQV3kYSdEYSiZRh3rEh6JIgNKRKqAqlU5a+0HIM1ETT
	0DMLm41eXsPVBvvO33ZfD6NPnsPSTaJI9SskyjLM+iz9AN6oZYfY+c9C5saMlt3KDOJPTHcAIf1
	dy4W5ggFVvYjQGmHjCx11CLTkJbYW8IHjkmWDdQQq4Yrcypf+DGWwZM8WN3QWTKLkzhr/2ELcfW
	u6HOUF+44Gexfkn
X-Received: by 2002:a05:690e:bc8:b0:661:1307:3d48 with SMTP id 956f58d0204a3-661130740c1mr14942497d50.23.1781002184651;
        Tue, 09 Jun 2026 03:49:44 -0700 (PDT)
X-Received: by 2002:a05:690e:bc8:b0:661:1307:3d48 with SMTP id
 956f58d0204a3-661130740c1mr14942464d50.23.1781002184142; Tue, 09 Jun 2026
 03:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605161422.213817-12-npache@redhat.com> <20260606102800.26940-1-lance.yang@linux.dev>
 <2553caae-9e0e-42a7-8b61-d1216f1e81fa@kernel.org> <CAA1CXcBY_2372eJru8VoCq90rUMxn7w23hHou68MmXRv48NRXg@mail.gmail.com>
 <b7fb4184-7a99-42c7-8ee2-4c7fa20827c4@kernel.org> <CAA1CXcAhw8V+_dYcrqmtZ9ht4Pqz5PPB8EOcDrVCp4DA4y7pLg@mail.gmail.com>
 <7e36f7f0-b4d5-41c9-b399-9e0079907d33@linux.dev>
In-Reply-To: <7e36f7f0-b4d5-41c9-b399-9e0079907d33@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Tue, 9 Jun 2026 04:50:30 -0600
X-Gm-Features: AVVi8CfEmBBiPisLcTlQkrBGxz8hwbio2e3oUzPtBYwEihX4RcQI0ruEO3CUrE4
Message-ID: <CAA1CXcD7WAiA1b9GTLAuNZ+kHaFx0SzZwpBkqAZ=s+RHsTUaow@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v19 11/14] mm/khugepaged: Introduce mTHP
 collapse support
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
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DXIT-SKV_0Zb9Dp-iHZubA8uo0JcyZx6LuPyOAe_OTo_1781002185
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 4:37=E2=80=AFAM Lance Yang <lance.yang@linux.dev> wr=
ote:
>
>
>
> On 2026/6/9 17:32, Nico Pache wrote:
> > On Tue, Jun 9, 2026 at 3:26=E2=80=AFAM David Hildenbrand (Arm) <david@k=
ernel.org> wrote:
> >>
> >> On 6/9/26 11:06, Nico Pache wrote:
> >>> On Mon, Jun 8, 2026 at 8:57=E2=80=AFAM David Hildenbrand (Arm) <david=
@kernel.org> wrote:
> >>>>
> >>>> On 6/6/26 12:28, Lance Yang wrote:
> >>>>>
> >>>>>
> >>>>> Looks broken for swap PTEs in PMD collapse ...
> >>>>>
> >>>>> collapse_scan_pmd() allows them up to max_ptes_swap and record them=
 in
> >>>>> unmapped, but they don't get a bit in mthp_present_ptes. And then
> >>>>> mthp_collapse() does the check above:
> >>>>
> >>>> Right. I assumed this is implicitly handled by the optimization in c=
ollapse_scan_pmd:
> >>>>
> >>>>          if (enabled_orders !=3D BIT(HPAGE_PMD_ORDER))
> >>>>                  max_ptes_none =3D KHUGEPAGED_MAX_PTES_LIMIT;
> >>>>
> >>>> But we perform the check a second time.
> >>>>
> >>>>>
> >>>>> nr_occupied_ptes >=3D nr_ptes - max_ptes_none
> >>>>>
> >>>>> So max_ptes_none=3D0 + 511 present PTEs + one allowed swap PTE won'=
t even
> >>>>> call collapse_huge_page() for PMD order.
> >>>>>
> >>>>> Shouldn't we account for them in the PMD-order check? Something lik=
e:
> >>>>>
> >>>>> if (is_pmd_order(order))
> >>>>>        nr_occupied_ptes +=3D unmapped;
> >>>
> >>> This solution seems good for a temporary fixup. but longterm we may
> >>> want something else. I'm still not sure how we plan on supporting
> >>> swapin without causing creep. So I'd be ok with adding a fix for
> >>> legacy PMD behavior until we know how to handle mTHP creep correctly.
> >>>
> >>>> As an alternative, we could either 1) skip the check there for
> >>>> pmd order (as the check was already done); or 2) introduce+maintain
> >>>> a bitmap that tracks non-present PTEs.
> >>>>
> >>>> @@ -1475,7 +1477,9 @@ static enum scan_result mthp_collapse(struct m=
m_struct *mm,
> >>>>                  nr_occupied_ptes =3D bitmap_weight_from(cc->mthp_pr=
esent_ptes, offset,
> >>>>                                                        offset + nr_p=
tes);
> >>>>
> >>>> -               if (nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
> >>>> +               /* Check was already done in the caller. */
> >>>> +               if (is_pmd_order(order) ||
> >>>> +                   nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
> >>>>                          enum scan_result ret;
> >>>>
> >>>>                          collapse_address =3D address + offset * PAG=
E_SIZE;
> >>>>
> >>>> 2) would probably be cleanest long-term.
> >>>
> >>> That would be best for future swapin support in mTHP, but I still
> >>> don't think it solves the creep issue.
> >>
> >> It wouldn't, we'd simply maintain the state we collect + rely on in se=
parate
> >> bitmaps. On swapin, we'd have to update/refresh bitmaps I guess.
> >
> > Yeah, I'm saying for the future, it obviously solves this issue here
> > as well, but if we have positional tracking of the swapout, shared,
> > and none PTEs, I think we can use this to determine whether the
> > collapse would lead to creep. If we detect creep would happen it may
> > be best to automatically collapse to the N+1 (or greater) candidate.
> > Just thinking outloud here.
> >
> >>
> >>> Perhaps we could combine the
> >>> two bitmaps to determine if it would make the future collapse eligibl=
e
> >>> again? Not sure but ill start thinking about it.
> >>>
> >>> Should I send a fixup for this using Lance's solution? Or does Lance
> >>> want to send a patch out with the fixes tag?
> >>
> >> If Lance could send a fixup, explaining the situation, that would be n=
ice.
>
> Sure, happy to send a fixup :P
>
> Should I send it as a fixup to be folded into this patch, or as a
> separate patch with a Fixes: tag?

Id assume a seperate patch so you can keep credit for the discovery :)

Thank you for all the review you provided on this series, its been
really helpful!

-- Nico

>
> Will get one out soon :)
>
> > OK, I'd appreciate that :)
>
> Cheers!
>

