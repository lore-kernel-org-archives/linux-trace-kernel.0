Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F874437A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722719; cv=none; b=mThCO/TCAfLyoQDxapzlZyLOKqon7+VEYqgjhwyolgu4dhRCmTkIB4KiXrVc+gn9zpJJcBX6v94bnmdhHJi8PLclr9/AStk2s2Wz7ncr9OttfEQUSg5PCXpmFIb1wJ9bBqv9W7/pYkJFWWvxkmIHvMBbcudMhJSWJadjIJ+9c/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722719; c=relaxed/simple;
	bh=l4ajafdB1+Zc4Os2K0LLf6LEAhTUjLOoNJPPBfIa9aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3vovb61bXgH4rzFWYSSIHDUy1JRvOwXCp5nG+tEU06RHW0sxGb4qCU8wR+uL7ualsgZ9F8Y43kQP7XrK+oH2vl/EBeSc60wNkexcLVW+qjNbNL4uVxBsvlrYN0JzKZLyQonIGfnVrm28Jzj3VbPLcpTyqFio1EJSie0oTCTEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7v3NXS1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7v3NXS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757722716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4ajafdB1+Zc4Os2K0LLf6LEAhTUjLOoNJPPBfIa9aU=;
	b=i7v3NXS1XFOcTPuopeKeBpm8Ln1WzPh4ljgM3kxcGeHI3WHGvQtxTajqT1RC4FhkRaPs5+
	dIRZTyJvWlc/UkcFzlWU7Qxj8UG1xs0pphFcRk39vztpjO96VQgHYbMf4GNAzR8DKWxOqQ
	qZy+v+WlVQph1jZoLFTLIVzZiLD3wxs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-i523qIE2OOWXXRQOFN4wgQ-1; Fri, 12 Sep 2025 20:18:35 -0400
X-MC-Unique: i523qIE2OOWXXRQOFN4wgQ-1
X-Mimecast-MFC-AGG-ID: i523qIE2OOWXXRQOFN4wgQ_1757722715
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-731572565c3so10059927b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757722715; x=1758327515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ajafdB1+Zc4Os2K0LLf6LEAhTUjLOoNJPPBfIa9aU=;
        b=iyEYuRITQN66ec30xQsogZxCMy72tn2xDjbqzMXc0fZ3uLI0mzSoRTQtqkr6iPdHi1
         cG0ed6H5ILUZYmkBYh8jKpTFZZXfAocnmHP2ATSXP1Vl4pQ22p4Qqe38WBL9WUKA9PST
         vs2Hwo2gvIpoh4xD5s1Cd2/WK92zkJnsXAScXFIDNozVy2Ujmx4MVfyrV5ds8ikjUN6J
         AlE9I3xjzHg0yry7buetXR9gX06Q913Swj8oIzq9IHsoO3z/hbOFBau0z09uUy9VP8dq
         cq/ExtL4bXRVuk8Cx0l7J2V/d9+CcoRudXD0el5meIHV8HPdT7NseSZAF8qKNYIvyiOY
         8BfA==
X-Forwarded-Encrypted: i=1; AJvYcCVjeCgFOYFRc5KZdw1SpsMMZvZ7GhNLrKGfCY2GdxN3jg8Qj1sR6lbu/i5f6v2uQdJzoEkgYnsA150OptDvDTc0rZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWqHgkyra7NePvczp1AERsGvJmBC9AsFZvGtUohzJA/kwBKj4
	2RuoC0iXlAARh8gexa9G7//wwrqzB66i+IcT9999f0nvFeZBIg+fIHgpwqzT+rijnPGvpJkZiBy
	B1nBer4FbC+dD9v54k3VToYbwCmuRyQE5frIMu24f5wqAAwCDf6QjkFGZacPnIudX6wGDQoTOWA
	kFH9IPBIBqQFOGpPTdJ3WAeeM7hJ+PIxgNlymo95jIV3uqBxb5
X-Gm-Gg: ASbGnctf7cj4Yx39VTOG0OIDYrs/S7tAd533f9fuDeNPS/8QNWouU8FQ+3v+EiZxPBr
	kZ8UPqtA1SDj25ROGWxLdiURHau9zf+Esz3clb5iQSVedcApQQQUUy6VepNWq8Wlx+48uuc7eH1
	08N7K6giC+Q45tyil2ec1fO6G10qVeE6hXnT0=
X-Received: by 2002:a05:690c:9688:b0:721:e87c:8c33 with SMTP id 00721157ae682-73064b0d05fmr42485987b3.42.1757722714762;
        Fri, 12 Sep 2025 17:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbHcwYvFm4L2fdbefOJomRceVwWpbQwHhmonPQcrjsF8ec8coXUMU+h3EdJ4sn6nutD1Tcv7kHs6OwIFQ+2cI=
X-Received: by 2002:a05:690c:9688:b0:721:e87c:8c33 with SMTP id
 00721157ae682-73064b0d05fmr42485567b3.42.1757722714282; Fri, 12 Sep 2025
 17:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912032810.197475-1-npache@redhat.com> <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com> <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
 <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
 <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com> <7ri4u7uxsv6elyohqiq2w5oxv4yhk2tyniwglfxtiueiyofb3n@l4exlmlf5ty4>
 <59641180-a0d9-400c-aaeb-0c9e93954bf5@redhat.com> <c5bcecb8-13e7-4db5-849e-2120c69b2af5@lucifer.local>
 <ed784d6c-6c2a-4e0b-ad2f-e953bf310ce8@redhat.com>
In-Reply-To: <ed784d6c-6c2a-4e0b-ad2f-e953bf310ce8@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 12 Sep 2025 18:18:08 -0600
X-Gm-Features: Ac12FXy0N5FtwbsBO2SqhUxuddBI79Z6-L0KsGN5hICFyqJ2VbVlnALj3j-diZ0
Message-ID: <CAA1CXcCwsQ4U95jEjvN63+915=8dfoTQboHnWRF=SApUssGMww@mail.gmail.com>
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ljz2LV0RaNRx5sS2nV_UFqnqZfEAWHhBE8tBZdNQiw_1757722715
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:53=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 12.09.25 17:51, Lorenzo Stoakes wrote:
> > On Fri, Sep 12, 2025 at 05:45:26PM +0200, David Hildenbrand wrote:
> >> On 12.09.25 17:41, Kiryl Shutsemau wrote:
> >>> On Fri, Sep 12, 2025 at 04:56:47PM +0200, David Hildenbrand wrote:
> >>>> On 12.09.25 16:35, Kiryl Shutsemau wrote:
> >>>>> On Fri, Sep 12, 2025 at 04:28:09PM +0200, David Hildenbrand wrote:
> >>>>>> On 12.09.25 15:47, David Hildenbrand wrote:
> >>>>>>> On 12.09.25 14:19, Kiryl Shutsemau wrote:
> >>>>>>>> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> >>>>>>>>> The following series provides khugepaged with the capability to=
 collapse
> >>>>>>>>> anonymous memory regions to mTHPs.
> >>>>>>>>>
> >>>>>>>>> To achieve this we generalize the khugepaged functions to no lo=
nger depend
> >>>>>>>>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to trac=
k individual
> >>>>>>>>> pages that are occupied (!none/zero). After the PMD scan is don=
e, we do
> >>>>>>>>> binary recursion on the bitmap to find the optimal mTHP sizes f=
or the PMD
> >>>>>>>>> range. The restriction on max_ptes_none is removed during the s=
can, to make
> >>>>>>>>> sure we account for the whole PMD range. When no mTHP size is e=
nabled, the
> >>>>>>>>> legacy behavior of khugepaged is maintained. max_ptes_none will=
 be scaled
> >>>>>>>>> by the attempted collapse order to determine how full a mTHP mu=
st be to be
> >>>>>>>>> eligible for the collapse to occur. If a mTHP collapse is attem=
pted, but
> >>>>>>>>> contains swapped out, or shared pages, we don't perform the col=
lapse. It is
> >>>>>>>>> now also possible to collapse to mTHPs without requiring the PM=
D THP size
> >>>>>>>>> to be enabled.
> >>>>>>>>>
> >>>>>>>>> When enabling (m)THP sizes, if max_ptes_none >=3D HPAGE_PMD_NR/=
2 (255 on
> >>>>>>>>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/=
2 - 1 for
> >>>>>>>>> mTHP collapses to prevent collapse "creep" behavior. This preve=
nts
> >>>>>>>>> constantly promoting mTHPs to the next available size, which wo=
uld occur
> >>>>>>>>> because a collapse introduces more non-zero pages that would sa=
tisfy the
> >>>>>>>>> promotion condition on subsequent scans.
> >>>>>>>>
> >>>>>>>> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> >>>>>>>> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> >>>>>>>
> >>>>>>> BTW, I thought further about this and I agree: if we count zero-f=
illed
> >>>>>>> pages towards none_or_zero one we can avoid the "creep" problem.
> >>>>>>>
> >>>>>>> The scanning-for-zero part is rather nasty, though.
> >>>>>>
> >>>>>> Aaand, thinking again from the other direction, this would mean th=
at just
> >>>>>> because pages became zero after some time that we would no longer =
collapse
> >>>>>> because none_or_zero would then be higher. Hm ....
> >>>>>>
> >>>>>> How I hate all of this so very very much :)
> >>>>>
> >>>>> This is not new. Shrinker has the same problem: it cannot distingui=
sh
> >>>>> between hot 4k that happened to be zero from the 4k that is there j=
ust
> >>>>> because of we faulted in 2M a time.
> >>>>
> >>>> Right. And so far that problem is isolated to the shrinker.
> >>>>
> >>>> To me so far "none_or_zero" really meant "will I consume more memory=
 when
> >>>> collapsing". That's not true for zero-filled pages, obviously.
> >>>
> >>> Well, KSM can reclaim these zero-filled memory until we collapse it.
> >>
> >> KSM is used so rarely (for good reasons) that I would never ever build=
 an
> >> argument based on its existence :P
> >>
> >> But yes: during the very first shrinker discussion I raised that KSM c=
an do
> >> the same thing. Obviously that was not good enough.
> >>
> >> --
> >> Cheers
> >>
> >> David / dhildenb
> >>
> >
> > With all this stuff said, do we have an actual plan for what we intend =
to do
> > _now_?
>
> Oh no, no I have to use my brain and it's Friday evening.
>
> >
> > As Nico has implemented a basic solution here that we all seem to agree=
 is not
> > what we want.
> >
> > Without needing special new hardware or major reworks, what would this =
parameter
> > look like?
> >
> > What would the heuristics be? What about the eagerness scales?
> >
> > I'm but a simple kernel developer,
>
> :)
>
> and interested in simple pragmatic stuff :)
> > do you have a plan right now David?
>
> Ehm, if you ask me that way ...
>
> >
> > Maybe we can start with something simple like a rough percentage per ea=
gerness
> > entry that then gets scaled based on utilisation?
>
> ... I think we should probably:
>
> 1) Start with something very simple for mTHP that doesn't lock us into an=
y particular direction.
>
> 2) Add an "eagerness" parameter with fixed scale and use that for mTHP as=
 well
I think the best design is to map to different max_ptes_none values,
0-5: 0,32,64,128,255,511
>
> 3) Improve that "eagerness" algorithm using a dynamic scale or #whatever
>
> 4) Solve world peace and world hunger
>
> 5) Connect it all to memory pressure / reclaim / shrinker / heuristics / =
hw hotness / #whatever
>
>
> I maintain my initial position that just using
>
> max_ptes_none =3D=3D 511 -> collapse mTHP always
> max_ptes_none !=3D 511 -> collapse mTHP only if we all PTEs are non-none/=
zero
I think we should implement the eagerness toggle, and map it to
different max_pte_none values like I described above. This fits nicely
in the current collapse_max_ptes_none() function.
If we go with just 0/511 without the eagerness changes, we will be
removing configurability, only to reintroduce it again. When we can
leave the configurability from the start.
>
> As a starting point is probably simple and best, and likely leaves room f=
or any
> changes later.
>
>
> Of course, we could do what Nico is proposing here, as 1) and change it a=
ll later.
I dont think this is much different than the eagerness approach; it
just compresses the max_ptes_none from 0-512 to 0-5/10.

I will wait for your RFC for the next version.

Does your implementation/thoughts align with what I describe above?
>
> It's just when it comes to documenting all that stuff in patch #15 that I=
 feel like
> "alright, we shouldn't be doing it longterm like that, so let's not make =
anybody
> depend on any weird behavior here by over-domenting it".
>
> I mean
>
> "
> +To prevent "creeping" behavior where collapses continuously promote to l=
arger
> +orders, if max_ptes_none >=3D HPAGE_PMD_NR/2 (255 on 4K page size), it i=
s
> +capped to HPAGE_PMD_NR/2 - 1 for mTHP collapses. This is due to the fact
> +that introducing more than half of the pages to be non-zero it will alwa=
ys
> +satisfy the eligibility check on the next scan and the region will be co=
llapse.
> "
>
> Is just way, way to detailed.
>
> I would just say "The kernel might decide to use a more conservative appr=
oach
> when collapsing smaller THPs" etc.

Sounds good I can make it more ambiguous!

Cheers.
-- Nico
>
>
> Thoughts?
>
> --
> Cheers
>
> David / dhildenb
>

