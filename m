Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9412153EA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770773; cv=none; b=Upqrw/qxIvRFy6N1sJfHsRxFW+zQUurZHfnm9Lei90fogmmA1hgaPkRw0E1wldCV0cOQ5po5BsJUToygwXp8GnJ+n2CeU37ZB4ov9JgSXenht2a8Y7qmdRgDA/0d//8e7/hPXyJ66lxTBNwMOQALG8Svjo7bh/dGWw+f49TDgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770773; c=relaxed/simple;
	bh=Oc7TviWFReNwMnSXKOGb/n3L3/gUc3bxbMJqDDekPOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtL2lmQhA/iR/8d207hye3KluFlIVdfnJDBk1Da3Km5AZEg79A0BRYQd+qcQKHtP9dhNyU8uP1WeeuZGQtpPw+7p/nAtWLdgfBxUgV8RnKheC+QV/11XZ9bhZMjZvQPWxupAscYaDH/4D6xL+zasNkVH3qC/D4Z8Hkv15Or3R+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEZNc94y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEZNc94y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761770770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc7TviWFReNwMnSXKOGb/n3L3/gUc3bxbMJqDDekPOM=;
	b=UEZNc94ySFfUujpAZ6u44fJi+9m7HnU/amOUhM3GT3ORk8ae/E9OXeLau75cQt9kJFL+EH
	mYbJIw1H5V2D4X+YfLLPJkmxhbbEa2fdRnekV1Z0DfjLkGpoRzHRwxvJuflxMBqWDwIGLl
	kphrxR2/9aE6uA9PA1o3FcQn9yB3rZU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-ctOmMmbJMNmUHFO12YLpZg-1; Wed, 29 Oct 2025 16:46:07 -0400
X-MC-Unique: ctOmMmbJMNmUHFO12YLpZg-1
X-Mimecast-MFC-AGG-ID: ctOmMmbJMNmUHFO12YLpZg_1761770766
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-591ead2ba5fso146770e87.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770766; x=1762375566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc7TviWFReNwMnSXKOGb/n3L3/gUc3bxbMJqDDekPOM=;
        b=lMpi2lhzX/fU6eP+wZtoYOLp3hJReI+hV4rpZYagv6lOfypLPmFaHiStJbaBJWR6gF
         MKc9LiXA1B58A+4RRtgv0GVrfE3rOBVfUp5Vig/JTscGoZNmuwbeouKKyDs5v7JMbAPK
         7BNTOnS/3AlBYH2Xvchbn6NsIdfqG3YbSUKoQ5ks0QNpsmDMcYKcnd87riQGEjNUZLwp
         +YPPnKVK+dDQ/XP56ps0h8lE7Qbh8lbYOI6uHsVvN6g31mz288u7+CoUHCIof6dg98XC
         ni1JqJz60UwwqvUXaROL/OtGRhQk/YC6St2S8pRe3Hh4iGNWbJNQEHj60tRTFxSgnamP
         +w4A==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZjBP6AawWdH+tY81l7mPcqyt4bgrsVCDB3g3dMCxcmuspfU2VFBx+Cp+W1kmq4n0+iKk+nibZJgwynSGnIICFww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFx3u4HqnE4SDdYbzdqGsHs8cw6txJKf4EmAGgg/bjnY0nfYc
	yLCjWix8HMHq+//Xm7slgwr2fWndjCnKdc6wnOifHZA25RofQ9Tj669HZxsE926UqpTyrqyYcMx
	ErWUrvHEGtfUKkiDR+h4Ot/sVSCKlszUZJ3aB9tmHdew8cxhG3KLEhW/fosD0DFWamd7W+Ikr2/
	6nJiYIcfgClbX5bl5wC7+YcUM3+m0BShXgGZ79V6wBvBaVNHdT
X-Gm-Gg: ASbGncuZS3Y8B2wlP+zcgkf0GCTkMnA0/X2jas4r/zGkv0+fAb5EpckMKdUVWU/2twj
	qlMdRfk/fzW1rZWdgPKU5jHzZGtuqjntlJ00AFFtMJEYxMY8a02eQ931VuD/ETWfYr8v2PuB25A
	DQ6O6cKRGiKHGVsgx1Bu3S4bmXL1wYTpOZjJb49zZv7bcwOB2//B2d+zO9igbLwSyQIt/XCw==
X-Received: by 2002:a05:6512:b20:b0:592:f263:a8be with SMTP id 2adb3069b0e04-5941287135emr1435959e87.17.1761770765578;
        Wed, 29 Oct 2025 13:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESQyEgec9ex4Rpf1NItxvzspecqCkRicn0v9c5QWtVC9BBjbVp+t2j6z7oKTbm0IWm6xmKhy+0SdXD0hdMpZU=
X-Received: by 2002:a05:6512:b20:b0:592:f263:a8be with SMTP id
 2adb3069b0e04-5941287135emr1435937e87.17.1761770765022; Wed, 29 Oct 2025
 13:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local> <063f8369-96c7-4345-ab28-7265ed7214cb@linux.alibaba.com>
 <9a3f2d8d-abd1-488c-8550-21cd12efff3e@lucifer.local> <e2a89e74-1533-4a83-8d0f-3f4821750e25@redhat.com>
 <64b9a6cd-d2e4-4142-bf41-abe80bf1f61a@lucifer.local> <dc002ef9-53ee-4466-b963-baadfd5162b7@redhat.com>
 <a97780ab-6256-43b7-8c0a-80ecbdc3d52d@lucifer.local> <2d8ed924-6d06-42e4-a876-381fb331f926@redhat.com>
In-Reply-To: <2d8ed924-6d06-42e4-a876-381fb331f926@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Oct 2025 14:45:37 -0600
X-Gm-Features: AWmQ_bm4p9MBC5sUu8O6J9Sn0293VN6CpobZZzMQVEnRiyb3Ke7AEB3M45KqdEg
Message-ID: <CAA1CXcBi8N2a3b4uEKQ8mzGWTiUEVuPDXx3vonDyBDakjd9bHw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, ziy@nvidia.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Me-ukEENBUDBPvkDdb1Zs3kW0erZ9cIUIBLdMWjU6E0_1761770766
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:04=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>
> >> No creep, because you'll always collapse.
> >
> > OK so in the 511 scenario, do we simply immediately collapse to the lar=
gest
> > possible _mTHP_ page size if based on adjacent none/zero page entries i=
n the
> > PTE, and _never_ collapse to PMD on this basis even if we do have suffi=
cient
> > none/zero PTE entries to do so?
>
> Right. And if we fail to allocate a PMD, we would collapse to smaller
> sizes, and later, once a PMD is possible, collapse to a PMD.
>
> But there is no creep, as we would have collapsed a PMD right from the
> start either way.
>
> >
> > And only collapse to PMD size if we have sufficient adjacent PTE entrie=
s that
> > are populated?
> >
> > Let's really nail this down actually so we can be super clear what the =
issue is
> > here.
> >
>
> I hope what I wrote above made sense.
>
> >
> >>
> >> Creep only happens if you wouldn't collapse a PMD without prior mTHP
> >> collapse, but suddenly would in the same scenario simply because you h=
ad
> >> prior mTHP collapse.
> >>
> >> At least that's my understanding.
> >
> > OK, that makes sense, is the logic (this may be part of the bit I haven=
't
> > reviewed yet tbh) then that for khugepaged mTHP we have the system wher=
e we
> > always require prior mTHP collapse _first_?
>
> So I would describe creep as
>
> "we would not collapse a PMD THP because max_ptes_none is violated, but
> because we collapsed smaller mTHP THPs before, we essentially suddenly
> have more PTEs that are not none-or-zero, making us suddenly collapse a
> PMD THP at the same place".
>
> Assume the following: max_ptes_none =3D 256
>
> This means we would only collapse if at most half (256/512) of the PTEs
> are none-or-zero.
>
> But imagine the (simplified) PTE layout with PMD =3D 8 entries to simplif=
y:
>
> [ P Z P Z P Z Z Z ]
>
> 3 Present vs. 5 Zero -> do not collapse a PMD (8)
>
> But sssume we collapse smaller mTHP (2 entries) first
>
> [ P P P P P P Z Z ]
>
> We collapsed 3x "P Z" into "P P" because the ratio allowed for it.
>
> Suddenly we have
>
> 6 Present vs 2 Zero and we collapse a PMD (8)
>
> [ P P P P P P P P ]
>
> That's the "creep" problem.

I'd like to add a little to this,

The worst case scenario is all mTHP sizes enabled and a value of 256.
A 16kb collapse would then lead all the way up to a PMD collapse,
stopping to collapse at each mTHP level on each subsequent scan of the
same PMD range. The larger the max_pte_none value is, the less "stops"
it will make before reaching a PMD size, but it will ultimately creep
up to a PMD. Hence the cap. At 511, a single pte in a range will
always satisfy the PMD collapse, so we will never attempt any other
orders (other than in the case of the collapse failing, which David
explains above).

Hopefully that helps give some more insight to the creep problem.

Cheers
-- Nico

>
> >
> >>
> >>>
> >>>> max_ptes_none =3D=3D 0 -> collapse mTHP only if all non-none/zero
> >>>>
> >>>> And for the intermediate values
> >>>>
> >>>> (1) pr_warn() when mTHPs are enabled, stating that mTHP collapse is =
not
> >>>> supported yet with other values
> >>>
> >>> It feels a bit much to issue a kernel warning every time somebody twi=
ddles that
> >>> value, and it's kind of against user expectation a bit.
> >>
> >> pr_warn_once() is what I meant.
> >
> > Right, but even then it feels a bit extreme, warnings are pretty seriou=
s
> > things. Then again there's precedent for this, and it may be the least =
worse
> > solution.
> >
> > I just picture a cloud provider turning this on with mTHP then getting =
their
> > monitoring team reporting some urgent communication about warnings in d=
mesg :)
>
> I mean, one could make the states mutually, maybe?
>
> Disallow enabling mTHP with max_ptes_none set to unsupported values and
> the other way around.
>
> That would probably be cleanest, although the implementation might get a
> bit more involved (but it's solvable).
>
> But the concern could be that there are configs that could suddenly
> break: someone that set max_ptes_none and enabled mTHP.
>
>
> I'll note that we could also consider only supporting "max_ptes_none =3D
> 511" (default) to start with.
>
> The nice thing about that value is that it us fully supported with the
> underused shrinker, because max_ptes_none=3D511 -> never shrink.
>
> --
> Cheers
>
> David / dhildenb
>

