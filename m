Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE042E5412
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794811; cv=none; b=p4DgjMtnR5m0b5MA5xrTt9WCDAq7aGNK/S1qgwS/79WuRPXIdnDKvf/S8565Rbd7+pgx8ztWuJ6tvf+Hx/wnbYGAsfGoglOQ0OCAtged74m6xDLS4sC8KqUtLopVgCSStJNI+74OVf+2j7jGKoUAoYkysm8tJvRBJEl7t9oGfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794811; c=relaxed/simple;
	bh=K+mWAWlKU6CDwFFxkffPdBHLCp/B7mW1LgpO4rkLh5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/JSyOsd7NKTLdxh8BPcOq6V2cO5BQK+nZwMxLCTfKPv8JzKLwcshPM1VAVDcwoeg8snYezwu87Xl9NrMCAcFJykh7f0zueA4Va2SyBzt04/ieEmlmsFRwTWA8tb7lBC6D075NRUBDJ7VY/rozT9qo42C6dDVilfXksGPjmStfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBiL0/vk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBiL0/vk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755794808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrtIXbgafzeCezod7PYLVl1s+ax0OUuwvjrZLQ9YMkw=;
	b=eBiL0/vkdGRiCg1eOXk87zgfx2mft0OFH31y7gjNvJNHIDffyUNpIoXioPZPCu6FQXnkSM
	ZMp3BVI+PmEvjWH32FrxfohglkzCdcqOL1uhuNhs/pQM2dq9yv7qd8qhuCQUnzReKgZ+7t
	XXSuDUBNcnLGTqgThg6PlcZKP10NM9Y=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-wZxaJ6THPiyrXr6puiqD3g-1; Thu, 21 Aug 2025 12:46:47 -0400
X-MC-Unique: wZxaJ6THPiyrXr6puiqD3g-1
X-Mimecast-MFC-AGG-ID: wZxaJ6THPiyrXr6puiqD3g_1755794806
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e9500a4ca5cso1819441276.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794806; x=1756399606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrtIXbgafzeCezod7PYLVl1s+ax0OUuwvjrZLQ9YMkw=;
        b=qlryFpN2RMKkM/yHrfgWMM1csL7AGsODVirZORvRhc3XigcfhMwO6y+TihRv+BAHPQ
         NuG7lAXn9GcRgDNf7YTdwLOP9y4AzDjNF1Q0U8odRT5EpeSnrh9VfhT4+Jaw6qwNm3ol
         cAr4A3pwg8Mbs6tc7R8JTmloWqcrxCNAWQA13rh1kY62jPCBVkwPom+03sju7MJQ5MMQ
         /JaTPVrv37DhYKE7vx5F+Qx+hvip4NKU4dneS50a0dX0G3ix9XlZDwCbjgwHEpfFFCaN
         9L7k3NbzgINZCGwPNbOzN2BOAOsy43OMh5SeDbs8mPDnT/eumFYMXycqf5+rFwktkATJ
         SIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5T3IxF/0WDog9looSt1wbfv5PaaRbRj2/en4lL66pRS227ZhwVUFXwqWCg9z1if+YcM2PFzpsdek1LTC08gBf0lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCgnuMX84hH6eqDHvfQgV9Tu+7k0Ldkl+N4FMl4K03ZzF0i+q
	FCcZ7gLf2HAc/s1GqI+DIt1kxdDe2wyyApb5xtxgw6NEm2FUr0KB2Mg6W/KaoXqouC6Dmu0Gorx
	BwWzBeXxNCobRh1CtWTitncpz9NhCNfS/ui56H2M48XrHzXzT9bpX1GOwSrHl5To4TrPhmIO5aR
	6ZQOuFLk60mLy8gDkEpdk/cTKRqUnxKhe3g+qmsrNNABJa8Bpp
X-Gm-Gg: ASbGncvA2WQ83C483Ta6m0CVF/OyRTwVYheBTJHT7Ez8stgmKC6r8hbAdBsBmfp0fWm
	LYRTBCgg/BTWDVATkJnrPJV1woYRPMl9bNQcY+OpCxEBGP7Q1AqgfqxGvleRSt6YTeT7rA3+Enj
	unTJ9r3cSZkd1cwxrUkbJXAK4=
X-Received: by 2002:a05:6902:100e:b0:e93:3bef:e01e with SMTP id 3f1490d57ef6-e951c2c83e8mr219554276.2.1755794806111;
        Thu, 21 Aug 2025 09:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfqUfsas2F3doNqS6BSKUG3YCszLmKMRtctwEjzAX/JZnaeEO3udW9FnxE4ev1vtDOEGhPCLBWe8mQkGNnEvw=
X-Received: by 2002:a05:6902:100e:b0:e93:3bef:e01e with SMTP id
 3f1490d57ef6-e951c2c83e8mr219500276.2.1755794805518; Thu, 21 Aug 2025
 09:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
 <38b37195-28c8-4471-bd06-951083118efd@arm.com> <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com> <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local>
In-Reply-To: <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Thu, 21 Aug 2025 10:46:18 -0600
X-Gm-Features: Ac12FXzSV_TeCPS1yO_m6RxtfmwTbbPB-Js0Syvou348xGcst1M_U3eimOxq4ZI
Message-ID: <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hf23mmDNbsKRUVr4ok6BuYY7Kh6i6W2Zk6tgVLzVPQc_1755794806
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:40=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 21, 2025 at 09:27:19AM -0600, Nico Pache wrote:
> > On Thu, Aug 21, 2025 at 9:25=E2=80=AFAM Nico Pache <npache@redhat.com> =
wrote:
> > >
> > > On Thu, Aug 21, 2025 at 9:20=E2=80=AFAM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Thu, Aug 21, 2025 at 08:43:18PM +0530, Dev Jain wrote:
> > > > >
> > > > > On 21/08/25 8:31 pm, Lorenzo Stoakes wrote:
> > > > > > OK so I noticed in patch 13/13 (!) where you change the documen=
tation that you
> > > > > > essentially state that the whole method used to determine the r=
atio of PTEs to
> > > > > > collapse to mTHP is broken:
> > > > > >
> > > > > >     khugepaged uses max_ptes_none scaled to the order of the en=
abled
> > > > > >     mTHP size to determine collapses. When using mTHPs it's rec=
ommended
> > > > > >     to set max_ptes_none low-- ideally less than HPAGE_PMD_NR /=
 2 (255
> > > > > >     on 4k page size). This will prevent undesired "creep" behav=
ior that
> > > > > >     leads to continuously collapsing to the largest mTHP size; =
when we
> > > > > >     collapse, we are bringing in new non-zero pages that will, =
on a
> > > > > >     subsequent scan, cause the max_ptes_none check of the +1 or=
der to
> > > > > >     always be satisfied. By limiting this to less than half the=
 current
> > > > > >     order, we make sure we don't cause this feedback
> > > > > >     loop. max_ptes_shared and max_ptes_swap have no effect when
> > > > > >     collapsing to a mTHP, and mTHP collapse will fail on shared=
 or
> > > > > >     swapped out pages.
> > > > > >
> > > > > > This seems to me to suggest that using
> > > > > > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none as=
 some means
> > > > > > of establishing a 'ratio' to do this calculation is fundamental=
ly flawed.
> > > > > >
> > > > > > So surely we ought to introduce a new sysfs tunable for this? P=
erhaps
> > > > > >
> > > > > > /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_no=
ne_ratio
> > > > > >
> > > > > > Or something like this?
> > > > > >
> > > > > > It's already questionable that we are taking a value that is ex=
pressed
> > > > > > essentially in terms of PTE entries per PMD and then use it imp=
licitly to
> > > > > > determine the ratio for mTHP, but to then say 'oh but the defau=
lt value is
> > > > > > known-broken' is just a blocker for the series in my opinion.
> > > > > >
> > > > > > This really has to be done a different way I think.
> > > > > >
> > > > > > Cheers, Lorenzo
> > > > >
> > > > > FWIW this was my version of the documentation patch:
> > > > > https://lore.kernel.org/all/20250211111326.14295-18-dev.jain@arm.=
com/
> > > > >
> > > > > The discussion about the creep problem started here:
> > > > > https://lore.kernel.org/all/7098654a-776d-413b-8aca-28f811620df7@=
arm.com/
> > > > >
> > > > > and the discussion continuing here:
> > > > > https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@=
redhat.com/
> > > > >
> > > > > ending with a summary I gave here:
> > > > > https://lore.kernel.org/all/8114d47b-b383-4d6e-ab65-a0e88b99c873@=
arm.com/
> > > > >
> > > > > This should help you with the context.
> > > > >
> > > > >
> > > >
> > > > Thanks and I"ll have a look, but this series is unmergeable with a =
broken
> > > > default in
> > > > /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_r=
atio
> > > > sorry.
> > > >
> > > > We need to have a new tunable as far as I can tell. I also find the=
 use of
> > > > this PMD-specific value as an arbitrary way of expressing a ratio p=
retty
> > > > gross.
> > > The first thing that comes to mind is that we can pin max_ptes_none t=
o
> > > 255 if it exceeds 255. It's worth noting that the issue occurs only
> > > for adjacently enabled mTHP sizes.
>
> No! Presumably the default of 511 (for PMDs with 512 entries) is set for =
a
> reason, arbitrarily changing this to suit a specific case seems crazy no?
We wouldn't be changing it for PMD collapse, just for the new
behavior. At 511, no mTHP collapses would ever occur anyways, unless
you have 2MB disabled and other mTHP sizes enabled. Technically at 511
only the highest enabled order always gets collapsed.

Ive also argued in the past that 511 is a terrible default for
anything other than thp.enabled=3Dalways, but that's a whole other can
of worms we dont need to discuss now.

with this cap of 255, the PMD scan/collapse would work as intended,
then in mTHP collapses we would never introduce this undesired
behavior. We've discussed before that this would be a hard problem to
solve without introducing some expensive way of tracking what has
already been through a collapse, and that doesnt even consider what
happens if things change or are unmapped, and rescanning that section
would be helpful. So having a strictly enforced limit of 255 actually
seems like a good idea to me, as it completely avoids the undesired
behavior and does not require the admins to be aware of such an issue.

Another thought similar to what (IIRC) Dev has mentioned before, if we
have max_ptes_none > 255 then we only consider collapses to the
largest enabled order, that way no creep to the largest enabled order
would occur in the first place, and we would get there straight away.

To me one of these two solutions seem sane in the context of what we
are dealing with.
>
> > >
> > > ie)
> > > if order!=3DHPAGE_PMD_ORDER && khugepaged_max_ptes_none > 255
> > >       temp_max_ptes_none =3D 255;
> > Oh and my second point, introducing a new tunable to control mTHP
> > collapse may become exceedingly complex from a tuning and code
> > management standpoint.
>
> Umm right now you hve a ratio expressed in PTES per mTHP * ((PTEs per PMD=
) /
> PMD) 'except please don't set to the usual default when using mTHP' and i=
t's
> currently default-broken.
>
> I'm really not sure how that is simpler than a seprate tunable that can b=
e
> expressed as a ratio (e.g. percentage) that actually makes some kind of s=
ense?
I agree that the current tunable wasn't designed for this, but we
tried to come up with something that leverages the tunable we have to
avoid new tunables and added complexity.
>
> And we can make anything workable from a code management point of view by
> refactoring/developing appropriately.
What happens if max_ptes_none =3D 0 and the ratio is 50% - 1 pte
(ideally the max number)? seems like we would be saying we want no new
none pages, but also to allow new none pages. To me that seems equally
broken and more confusing than just taking a scale of the current
number (now with a cap).


-- Nico

>
> And given you're now proposing changing the default for even THP pages wi=
th a
> cap or perhaps having mTHP being used silently change the cap - that is c=
learly
> _far_ worse from a tuning standpoint.
>
> With a new tunable you can just set a sensible default and people don't e=
ven
> necessarily have to think about it.
>

