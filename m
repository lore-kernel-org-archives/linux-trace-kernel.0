Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E691221FF40
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737168; cv=none; b=c0HRWjnK5YcqFc6G4L9pSoATvHVH/Pa8k2cvwaQthcQCvpBMc1bB6i1X5Epfgnz8yQhQt+TSVc7lVWH9cN8nFrIU5JDT6h8LGG6YBmuWUJOsS1hk1qLp3ZggW6ozMohXZf7qsLWX+54+GwbezUsvhU+h0DMD+QfvtyL42jiurJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737168; c=relaxed/simple;
	bh=NOwIEeREB/ym9iFgMkdDeunubZxi6LNAtRLm2rvSy6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adyY5fasTVviMjqsf6DjH3whTwN57v0Wh4YoL5C1XJJ3kvPmE91JQiaWXMtTTV6b29N0YU4nk5B/eWDmxq5DogdZqbmz5VIAwPmvF3guoYUVW3lxeghUTCzBeN0hNJaLXZ0xFUcCGfvdmF3Ga99tidjxnMDTIqEdqgAmrnp5D1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByLpXDJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByLpXDJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vo8FQNXlen0UXALTqIXl1cj0LOauGoMS19U6EAESdmQ=;
	b=ByLpXDJSmDn5XmlWc6h6F0jsDX8VPHK/BBwl6Zf3Uky6Eomlt+v8E5D0139qFplvV38+Qj
	mWNbr0vVKsmZuEF0yBLrj6C358ZYydVnwLF6MHk0bYJLB9GhOFjrmTovpOALwxyUpC6OR+
	cFVg7v/3qR51yFCqjIGegQ3oa1AVLIk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-HzzBVFqVMxm0fWZIVO_pRA-1; Thu, 17 Jul 2025 03:26:04 -0400
X-MC-Unique: HzzBVFqVMxm0fWZIVO_pRA-1
X-Mimecast-MFC-AGG-ID: HzzBVFqVMxm0fWZIVO_pRA_1752737164
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7183dc67fc4so9682687b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737164; x=1753341964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo8FQNXlen0UXALTqIXl1cj0LOauGoMS19U6EAESdmQ=;
        b=eSY7Z1jj0VIdJMlLSlDIUe5jZc2fuPlyc20QzZSLDo9LqoRRC9hBxfSnVEoeJHah22
         cVDXYCuL7jgVVHoTVQ6pNXTi5o4Oah6l24orUfrMeiFqxRescTViLMBlQJiNiEtcPtlz
         sf9j0j5rDROk7MIp9AQg56ZO6zJWpMS/n8Hx+kxYMT1cFWdAZ+IlvkXHEBG6+e8IeZ0Z
         hodBZ8EAOkIkdF8lFVkdYfbdL81x08unC+ebNg/kG5AE+LS7bCIaTSZUAb+sYIJr4L47
         LTXfJzgn/QrKk/6tSzxOg7AG8bccLE5ko8a6SxndTKYr/eGJxdfz3ViDS+L111OQnSXZ
         jEvA==
X-Forwarded-Encrypted: i=1; AJvYcCWaznBzz4AIGF4zQli7DOAClPp6c4vZm6UV18ib0/QygJX6Vc6aqh3lTmKG0LLbW5X7B9kVPctIRNUjE6DeRaPft/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFQZSOgQduS92UD6qsmKPq1ZyzTcBBUHeYxLb+26WmARogh20
	FPA7S5k6VezcWtHEICINSHF7WWiv0YfBfWTHEHETSza25+ukuU/JtPePZJRiaQy1ULCKfhmyB/V
	vezxjE1d6c3mR1Az/g7Uv9cCB7X8t3G7bWPR6ZWkdSRYXDXXecvtcFKxbEk+GpGMEa1kJ21sJco
	k2N/jDLXMkXeLubHg44UjrhIHNAqYYPoDsmFBOIS7EuZ0uw2HC3w0qpdO3ngc=
X-Gm-Gg: ASbGnctNK6c+hhjsb4fvu0UnkT1RQwrc8aUPEVZWLlHsJTZtYbHLhExLcyroKRkchqZ
	oE91Ii4ACNU3feofEXgITX4gqMS0ti9IgT4FlTwjks7uI876hoZ2ZgZ9C6BXSLvMUJM8ua2OHeG
	2ea/pUqT1N/x/VXTtfHiotxVk=
X-Received: by 2002:a05:690c:6993:b0:70a:192d:122 with SMTP id 00721157ae682-71835178d52mr82694427b3.30.1752737164058;
        Thu, 17 Jul 2025 00:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMubBvQQAjL8j5OHlbNU/B1QBy1oxiKdyesMx8UucD2RpbZUXxzqn8VGYgbNvQhuy4s6xzfb4MYtoJBUi03NM=
X-Received: by 2002:a05:690c:6993:b0:70a:192d:122 with SMTP id
 00721157ae682-71835178d52mr82693867b3.30.1752737163491; Thu, 17 Jul 2025
 00:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-11-npache@redhat.com>
 <3b8d32dd-9d40-44b1-a0ab-8185073b9072@redhat.com>
In-Reply-To: <3b8d32dd-9d40-44b1-a0ab-8185073b9072@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:25:37 -0600
X-Gm-Features: Ac12FXzO2MpdN8Y0fWlVobBSI1-4HfFow54FOutJLg2yUFGIlRLNPwUMo-JRrD0
Message-ID: <CAA1CXcD2KphY8PEHyjQuYhZJf_oiNz-8UN1m9AtPF7j9O7U2sw@mail.gmail.com>
Subject: Re: [PATCH v9 10/14] khugepaged: allow khugepaged to check all
 anonymous mTHP orders
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QN0O2mt2G36ukZqc8KT8WKenv-IqvVmLxIx1ywc6Hz8_1752737164
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:28=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.07.25 02:32, Nico Pache wrote:
> > From: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> Should the subject better be
>
> "mm/khugepaged: enable collapsing mTHPs even when PMD THPs are disabled"
Thank does read better.
>
> (in general, I assume all subjects should be prefixed by "mm/khugepaged:"=
)
ehhh, seems like there's a mix of "mm/khugepaged", "khugepaged", and
"mm: khugepaged:" being used in other commits. I prefer using
khugepaged as it leaves me more space for the commit title
>
> >
> > We have now allowed mTHP collapse, but thp_vma_allowable_order() still =
only
> > checks if the PMD-sized mTHP is allowed to collapse. This prevents scan=
ning
> > and collapsing of 64K mTHP when only 64K mTHP is enabled. Thus, we shou=
ld
> > modify the checks to allow all large orders of anonymous mTHP.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 7a9c4edf0e23..3772dc0d78ea 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -491,8 +491,11 @@ void khugepaged_enter_vma(struct vm_area_struct *v=
ma,
> >   {
> >       if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> >           hugepage_pmd_enabled()) {
> > -             if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SY=
SFS,
> > -                                         PMD_ORDER))
> > +             unsigned long orders =3D vma_is_anonymous(vma) ?
> > +                                     THP_ORDERS_ALL_ANON : BIT(PMD_ORD=
ER);
> > +
> > +             if (thp_vma_allowable_orders(vma, vm_flags, TVA_ENFORCE_S=
YSFS,
> > +                                         orders))
> >                       __khugepaged_enter(vma->vm_mm);
> >       }
> >   }
> > @@ -2624,6 +2627,8 @@ static unsigned int collapse_scan_mm_slot(unsigne=
d int pages, int *result,
> >
> >       vma_iter_init(&vmi, mm, khugepaged_scan.address);
> >       for_each_vma(vmi, vma) {
> > +             unsigned long orders =3D vma_is_anonymous(vma) ?
> > +                                     THP_ORDERS_ALL_ANON : BIT(PMD_ORD=
ER);
> >               unsigned long hstart, hend;
> >
> >               cond_resched();
> > @@ -2631,8 +2636,8 @@ static unsigned int collapse_scan_mm_slot(unsigne=
d int pages, int *result,
> >                       progress++;
> >                       break;
> >               }
> > -             if (!thp_vma_allowable_order(vma, vma->vm_flags,
> > -                                     TVA_ENFORCE_SYSFS, PMD_ORDER)) {
> > +             if (!thp_vma_allowable_orders(vma, vma->vm_flags,
> > +                     TVA_ENFORCE_SYSFS, orders)) {
> >   skip:
> >                       progress++;
> >                       continue;
>
> Acked-by: David Hildenbrand <david@redhat.com>
Thank you for your review :)

>
> --
> Cheers,
>
> David / dhildenb
>

