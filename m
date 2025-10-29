Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B93191DE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772484; cv=none; b=Z9h4yXa9oRFwZAvI3MN8Lm3d93WwG7ATWi4Hi+Dk5j/7rsZQATQUo3rMjAEp1OlXo9PUiiRuvHKQwlt9sgbCMTRTcZ+6/neoCH9xxshtBotOidId+ibaJKACvRIIWKFT0pwBspR9qKVakxvz8EVIOOXfmp4YdkHivDgcLPAOapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772484; c=relaxed/simple;
	bh=uA4o4s1QUU1aUgd+6IuizO22+dL/AjztreXwnzDIJOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKz1AV+VScYRc504c2FIqo89uTjE4LfwauXQIvTIPb7FGwED2zyPgf8l3e4Ls9Zim68+eUr3EDXYzUwqvnoIeOm/0j3DrbVtE2MpzfZmXtkNIhiepDIS9QpOo/4n028sZUYPg85+9P6x33i2fDNOxjAd7XK3p6ArhRzz97KRPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1DbXeuC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1DbXeuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761772482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPTTtw8BTZD1fn+qIBXIK1gjHXor2Nf0ItE5USDfdEk=;
	b=E1DbXeuC6tFAca0iR9b4vjcYrkMSifmOxcPwg1evTydD2Acwre//YK3hLNyBCrlnM3y+g6
	GetOqy+PHo7vHq7Or6PtgeDoMs1y1HPwws/aBzFddmNGf7fx8C7T7bBXxUtU3x5SQJJ0Ys
	bCFREHAolTigBwuPHW5XgXme+iptwFA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-MYO8nWVlMheRzQPIzSWwXQ-1; Wed, 29 Oct 2025 17:14:40 -0400
X-MC-Unique: MYO8nWVlMheRzQPIzSWwXQ-1
X-Mimecast-MFC-AGG-ID: MYO8nWVlMheRzQPIzSWwXQ_1761772479
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-378ccb2cd05so1034501fa.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772479; x=1762377279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPTTtw8BTZD1fn+qIBXIK1gjHXor2Nf0ItE5USDfdEk=;
        b=dJi7OIrnjQMQk1DRAKpaqfe7JVbzI5/GpzcMPThUYoVzQvA8uD/+yO/kDROhSkWh3q
         /5XtK1abaNgmsHqr/W4a0/tXXAFRiJLSlaYY2hZUr3TF+E5etkh8nuO8SVbN7uYVeKgZ
         sXHl4i7PjiNgFcLtezmxzvcTZYjwga7PDuKrIT4gL1xCSvP594rscZ1sPB6cff/jCgui
         YLOuAOCifoJUv2FjA+VeUCDCmRcNel5QcdTGzj8IadLPWufs4BbQ9xQm5PP6kKC/nAPv
         DN6A/ZJoixexaQQ5S6a9tJf4xZFAf3N8FKQ/YoXAc3hXlBb49oKuKVDVVPcf6Gulk7V1
         JV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnFY8kaNVEMAx7ozpbyE0JVDGdc3Yfh15O2j6u8stoMaVKJbsSCpcoKmTIDb1xWSa4nSgkjuDkZ6T9SPBHn5mIi80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrnLhJskYZeGFa+Zs4FpwU3bEHaktktRuIpIEYBPaEr5Mb37s
	L8A+0nYzMLVwLnIDaF8FJUjigyL0NW5DVyJVPZsk6Q6p+MmaYUTt1kE2bWhTHcyLeV8pKZI93TB
	YpoBE7QlO8eh6CpQdQfbM6uSY/gaODGRHBvHlFHuZkDcg0vPbFbmGQegKOcEqYULSoFGheTrho9
	QUEA73P7XaAGQT2Tw5z84iWGwRC3F9x2VUYJxbtsDsC4LA5Brg
X-Gm-Gg: ASbGncs00/ONqDU7yJ8bj2fAX4lW3fgoEKdHiXjB55Bcr2td68nqkSjdb4g86azs5XG
	xiLgy14VsxxCflpN7rB7iXEVhAg02CcjeawTCdJX0u5OkOH/m6o/XrfEiRh63+ci+ABFgmOVPtC
	b5MA1EoGha9CpFwjci3+OUIKsG5gn6TfbvVzD3OOV+PUhUrU2AQKMYXSzQTOPa+Jvj7Tb0cw==
X-Received: by 2002:a05:651c:543:b0:378:dde4:7987 with SMTP id 38308e7fff4ca-37a05332c83mr15015411fa.28.1761772479002;
        Wed, 29 Oct 2025 14:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT1rpy4gMrS8nShcIS4YGFz4w4G6pxRpfpNR82D/AUm8kkZFUHf+ArcjvP3FnX+a05XWhgXcWN2srFJMdzGAg=
X-Received: by 2002:a05:651c:543:b0:378:dde4:7987 with SMTP id
 38308e7fff4ca-37a05332c83mr15015071fa.28.1761772478459; Wed, 29 Oct 2025
 14:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local> <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com> <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
 <74583699-bd9e-496c-904c-ce6a8e1b42d9@redhat.com> <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
 <b1f8c5e3-0849-4c04-9ee3-5a0183d3af9b@linux.alibaba.com> <2ab547d2-584b-48fe-9f43-7c14caa7ab05@lucifer.local>
In-Reply-To: <2ab547d2-584b-48fe-9f43-7c14caa7ab05@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Oct 2025 15:14:11 -0600
X-Gm-Features: AWmQ_bkBHBsKVE1DM6K6PiXjxwYzk9VLBdKL8XAwMrrsQLZy0gtm_M8PLuoLaxI
Message-ID: <CAA1CXcA1nqt_f+zSOF66eTNWJACCE84hSQn4uNF8CjcBUZ_1oA@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
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
X-Mimecast-MFC-PROC-ID: TDjox_lIAkNN_eAJsSnBmC1BdtorpMvx4BgvBcSycbM_1761772479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:56=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 29, 2025 at 10:09:43AM +0800, Baolin Wang wrote:
> > I finally finished reading through the discussions across multiple
> > threads:), and it looks like we've reached a preliminary consensus (mak=
e
> > 0/511 work). Great and thanks!
>
> Yes we're getting there :) it's a sincere effort to try to find a way to =
move
> forwards.
>
> >
> > IIUC, the strategy is, configuring it to 511 means always enabling mTHP
> > collapse, configuring it to 0 means collapsing mTHP only if all PTEs ar=
e
> > non-none/zero, and for other values, we issue a warning and prohibit mT=
HP
> > collapse (avoid Lorenzo's concern about silently changing max_ptes_none=
).
> > Then the implementation for collapse_max_ptes_none() should be as follo=
ws:
> >
> > static int collapse_max_ptes_none(unsigned int order, bool full_scan)
> > {
> >         /* ignore max_ptes_none limits */
> >         if (full_scan)
> >                 return HPAGE_PMD_NR - 1;
> >
> >         if (order =3D=3D HPAGE_PMD_ORDER)
> >                 return khugepaged_max_ptes_none;
> >
> >         /*
> >          * To prevent creeping towards larger order collapses for mTHP
> > collapse,
> >          * we restrict khugepaged_max_ptes_none to only 511 or 0,
> > simplifying the
> >          * logic. This means:
> >          * max_ptes_none =3D=3D 511 -> collapse mTHP always
> >          * max_ptes_none =3D=3D 0 -> collapse mTHP only if we all PTEs =
are
> > non-none/zero
> >          */
> >         if (!khugepaged_max_ptes_none || khugepaged_max_ptes_none =3D=
=3D
> > HPAGE_PMD_NR - 1)
> >                 return khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER -
> > order);
> >
> >         pr_warn_once("mTHP collapse only supports khugepaged_max_ptes_n=
one
> > configured as 0 or %d\n", HPAGE_PMD_NR - 1);
> >         return -EINVAL;
> > }
> >
> > So what do you think?
>
> Yeah I think something like this.
>
> Though I'd implement it more explicitly like:
>
>         /* Zero/non-present collapse disabled. */
>         if (!khugepaged_max_ptes_none)
>            return 0;
>
>         /* Collapse the maximum number of zero/non-present PTEs. */
>         if (khugepaged_max_ptes_none =3D=3D HPAGE_PMD_NR - 1)
>                 return (1 << order) - 1;
>
> Then we can do away with this confusing (HPAGE_PMD_ORDER - order) stuff.

This looks cleaner/more explicit given the limits we are enforcing!

I'll go for something like that.

>
> A quick check in google sheets suggests my maths is ok here but do correc=
t me if
> I'm wrong :)

LGTM!

Thanks for all the reviews! I'm glad we were able to find a solution :)

-- Nico

>
> Cheers, Lorenzo
>

