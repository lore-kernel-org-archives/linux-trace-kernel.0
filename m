Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16631E10A;
	Fri, 12 Sep 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691679; cv=none; b=avxYPmEoy5oyOuASGNOIxE0hr/uDQP5ie8DuU8GzK8GWpoY3Gq5Tp3EASoEug3Bu6KFZRZ2fmM2eomzHVI/jN2gRLnNK/2el/2WLnqM3FXWnwnSYAgzvSo7lqAzoF1m6ki9KlLyI3dI8Vsf/aZTgX7r0C3rZXcdSnKdQjH25uOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691679; c=relaxed/simple;
	bh=Pnh9rQTYsWlWtV4pH/2q/GaxI6G4+CAlVzB4h1vWAoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYCBp+HLUOX16wccRHmRtZCInbpItGYQXa98F2LB7D2U+MUipP+lfF96EvXFUoLYJMchBO8Jfj1ugSRg+axCtubSi3mn7JnT5SVpoMY+F/Tdqv3QXlj4hsbPaVgLY3ZXr9tdQkGD7GKNp2GKCPH0x9TORvqmu2Oz5H49AxQ6RXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LETEawqk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LETEawqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F098BC4CEFA;
	Fri, 12 Sep 2025 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757691678;
	bh=Pnh9rQTYsWlWtV4pH/2q/GaxI6G4+CAlVzB4h1vWAoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LETEawqks87rrqCiHQ5/U14DkW7DlUVM93h+Ie4U9Dl4p6mYpnwLE4ZqR5AO8AEBn
	 dR1WStbWV5V9l9qK3zmkbGLb6UBjJD5O6u+2h3j89D+ciFYRl+Th3glaQUrcx30MQw
	 Tkld+qm5o/EUk3ytI2gfN9O6rIoZULo/ETcpvpu7hO+ViRz3K4/5KAM3ORxWD/wrNh
	 VzvfFXGaRR4rBbOfklPvWEhXKsa2ZRqkYDUG5ukgbSZLfkFDcT7jaZpgTkfZdjy/v2
	 MyF/zZDRovmWQ2/Xn5K5R1uoRrwa3V94yrMqFNfGUqtK21Ok88HhXPDWZ0om90q6el
	 7+N1NeEgpSZYQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3D2FDF40066;
	Fri, 12 Sep 2025 11:41:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 12 Sep 2025 11:41:15 -0400
X-ME-Sender: <xms:Gz_EaOsbf31G_UXVkIOUtD0npSfMH0xLF6dHFR3WGNEPXd02pGS-Dw>
    <xme:Gz_EaBS5LF0vrQqGE-T4tzVT3yWzra1_wjtlfYaSiXICuy4mBnNp-WAsEjzl-yl5s
    DX6ch17wM9xjkcoCGY>
X-ME-Received: <xmr:Gz_EaHnFVMwlGSqkETfEvMPfhx6t1OtXoxkXRZpuyjZpu79YwQupf9WCWtUBKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeelkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhhprggthhgvsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
    sggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtth
    hopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:Gz_EaJGoEIfYRYdOJMLO3p1Ayi-LNhwkTjZnkBk9hX6EIQqfnae1mw>
    <xmx:Gz_EaJIMiWEI0LTXh-qd-YU5gzmFymkxr1ZbO2n2SuyFlUmXlbd3sg>
    <xmx:Gz_EaPrAIDTKpJT5sMkEYfN_hCgQIRB427TL9pAeEEF5Ez2_39i48w>
    <xmx:Gz_EaC1u3_UGXrJyTRYAy_bFxc7y2Pox7uFkM5OKfmrYyCh0oq-h0g>
    <xmx:Gz_EaJI2cA6z4MM-kX4yh72tx0H_aTTuhQrmm4VTq_ozAg3kuAhZzXv0>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 11:41:14 -0400 (EDT)
Date: Fri, 12 Sep 2025 16:41:11 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, 	rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, 	akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, 	vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, 	jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, 	zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 	rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 	lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 	pfalcato@suse.de
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <7ri4u7uxsv6elyohqiq2w5oxv4yhk2tyniwglfxtiueiyofb3n@l4exlmlf5ty4>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
 <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
 <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
 <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com>

On Fri, Sep 12, 2025 at 04:56:47PM +0200, David Hildenbrand wrote:
> On 12.09.25 16:35, Kiryl Shutsemau wrote:
> > On Fri, Sep 12, 2025 at 04:28:09PM +0200, David Hildenbrand wrote:
> > > On 12.09.25 15:47, David Hildenbrand wrote:
> > > > On 12.09.25 14:19, Kiryl Shutsemau wrote:
> > > > > On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> > > > > > The following series provides khugepaged with the capability to collapse
> > > > > > anonymous memory regions to mTHPs.
> > > > > > 
> > > > > > To achieve this we generalize the khugepaged functions to no longer depend
> > > > > > on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> > > > > > pages that are occupied (!none/zero). After the PMD scan is done, we do
> > > > > > binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
> > > > > > range. The restriction on max_ptes_none is removed during the scan, to make
> > > > > > sure we account for the whole PMD range. When no mTHP size is enabled, the
> > > > > > legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
> > > > > > by the attempted collapse order to determine how full a mTHP must be to be
> > > > > > eligible for the collapse to occur. If a mTHP collapse is attempted, but
> > > > > > contains swapped out, or shared pages, we don't perform the collapse. It is
> > > > > > now also possible to collapse to mTHPs without requiring the PMD THP size
> > > > > > to be enabled.
> > > > > > 
> > > > > > When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
> > > > > > 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
> > > > > > mTHP collapses to prevent collapse "creep" behavior. This prevents
> > > > > > constantly promoting mTHPs to the next available size, which would occur
> > > > > > because a collapse introduces more non-zero pages that would satisfy the
> > > > > > promotion condition on subsequent scans.
> > > > > 
> > > > > Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> > > > > all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> > > > 
> > > > BTW, I thought further about this and I agree: if we count zero-filled
> > > > pages towards none_or_zero one we can avoid the "creep" problem.
> > > > 
> > > > The scanning-for-zero part is rather nasty, though.
> > > 
> > > Aaand, thinking again from the other direction, this would mean that just
> > > because pages became zero after some time that we would no longer collapse
> > > because none_or_zero would then be higher. Hm ....
> > > 
> > > How I hate all of this so very very much :)
> > 
> > This is not new. Shrinker has the same problem: it cannot distinguish
> > between hot 4k that happened to be zero from the 4k that is there just
> > because of we faulted in 2M a time.
> 
> Right. And so far that problem is isolated to the shrinker.
> 
> To me so far "none_or_zero" really meant "will I consume more memory when
> collapsing". That's not true for zero-filled pages, obviously.

Well, KSM can reclaim these zero-filled memory until we collapse it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
