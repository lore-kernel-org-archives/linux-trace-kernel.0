Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57D220F5E;
	Fri, 12 Sep 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691544; cv=none; b=qKvimIs9uT7rdvEYpMjCuuI6nNFVJE+HZ7FosbBn2U5I5N/znYRltN+jY66DzB03/GCcXWS87Oz/zHZfqa+iYg5/jkYliU88VgCfRmpyDi8TPZ/vN1Q/qDrHRI8iSud3B986drM0w1ofF5iYmUOHOxcqq/3m2LENMiDUloDjltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691544; c=relaxed/simple;
	bh=MqWqEVkiavY1Oa+6UsdYHS5X7LREs3JN+4OZa8gJU1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0HtWMjp05Bc5k1XN5ipr6bdiKSvh/KX8MdYHieB5aAq8SESuDeZdmkECaCiUwmlO/62IgQbo6AP/9+3ntqwapl1W8/oLBizWQZm6wWzeXcAZsT0tAFOMDuv3cyXWL+GTgNEnE+/x0QuM5Yj2nQm2faiOrezXXI+hJ/065EJQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d78ruUZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d78ruUZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE88C4AF0B;
	Fri, 12 Sep 2025 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757691544;
	bh=MqWqEVkiavY1Oa+6UsdYHS5X7LREs3JN+4OZa8gJU1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d78ruUZVhOjeYkF1ayZ7BTafwkKl5MtnhcQA3vyg9+Z/zGFyr6Cv6IY/37xaGE5KA
	 E2UkLzMuS2a6hOoIETtRjkX0Sy31SXpDxIFcZTIgSjZBQB/qphjykl+uv4LHXYsnvt
	 HRRW8MD6nr6f02XVFgHfXUIkddJ8xL8bqKfZQ9iLdyBF0D7OCELuwFLYYot1h6C+aB
	 ELsGSe8jzThCmeUPoqwIoY8JRjIwnXNcX3UUJt/3eYy+0ph3CEVbQzGkwKg5xaokRV
	 nX5ZLdmIWk1p6q3fNYntpdLe+DsKzkpRGJSZdX1pzBYXDZO3Y8MlHwsgEZM+t0iB4F
	 2P163fhRC1y1Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id E95DDF40068;
	Fri, 12 Sep 2025 11:39:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 12 Sep 2025 11:39:01 -0400
X-ME-Sender: <xms:lT7EaHmd6YseUp8_myHE6QI5XITPd40RhUlV69wM0VdVN1w-u43ghA>
    <xme:lT7EaHrCEItqTX1gDappaQb9WOxjSOCiBzqu9SDmnA6QuXyW-v6mcJPa4yU7sHpza
    iF3vywUwrDTXhY7LtI>
X-ME-Received: <xmr:lT7EaP5HVr1QBClyORn4Xn1cbEHmjCW3UzoAcg1kG90YM1IHJo9VktilHoK9Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeelkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhfrghltggrthhosehsuhhsvgdruggvpdhrtghpthhtohepuggrvhhiugesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhr
    tghpthhtohepnhhprggthhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihihiesnhhvih
    guihgrrdgtohhm
X-ME-Proxy: <xmx:lT7EaPvb5YgSO-BnFXc5GNkonXqhrxEzv9gl9ZO5OcMhkpTc8h9W2w>
    <xmx:lT7EaK9myZsXSE11OMxOm9GP9D8cWKgR7IF0PS-QeUE18mBYBBh7tA>
    <xmx:lT7EaD6aalZPZm7Wy-Nn5NxqjbeTxzw5DSTmNlaytsOtiXB9WUadVw>
    <xmx:lT7EaM8_9ZA0Vty_GXNotMrr7XBmMeXwptz08uyaQT13YdpSdBFJYA>
    <xmx:lT7EaD-QWgKjY6rpuxP47U04xMwQlWW3OD-igRLAeIY6Jry9BD2K-Qr5>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 11:39:01 -0400 (EDT)
Date: Fri, 12 Sep 2025 16:38:59 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@redhat.com>,
 	Johannes Weiner <hannes@cmpxchg.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, 	Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
 	rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, 	akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, 	vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, 	jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, 	zokeefe@google.com,
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
 	hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev,
 vbabka@suse.cz, 	rppt@kernel.org, jannh@google.com
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <k54teuep6r63gbgivpka32tk47zvzmy5thik2mekl5xpycvead@fth2lv4kuicg>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
 <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
 <hcpxpo3xpqcppxlxhmyxkqkqnu4syohhkt5oeyh7qse7kvuwiw@qbhiubf2ubtm>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hcpxpo3xpqcppxlxhmyxkqkqnu4syohhkt5oeyh7qse7kvuwiw@qbhiubf2ubtm>

On Fri, Sep 12, 2025 at 04:15:23PM +0100, Pedro Falcato wrote:
> On Fri, Sep 12, 2025 at 03:46:36PM +0200, David Hildenbrand wrote:
> > On 12.09.25 15:37, Johannes Weiner wrote:
> > > On Fri, Sep 12, 2025 at 02:25:31PM +0200, David Hildenbrand wrote:
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
> > > > > 
> > > > 
> > > > I am all for not adding any more ugliness on top of all the ugliness we
> > > > added in the past.
> > > > 
> > > > I will soon propose deprecating that parameter in favor of something
> > > > that makes a bit more sense.
> > > > 
> > > > In essence, we'll likely have an "eagerness" parameter that ranges from
> > > > 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
> > > > not all is populated".
> > > > 
> > > > In between we will have more flexibility on how to set these values.
> > > > 
> > > > Likely 9 will be around 50% to not even motivate the user to set
> > > > something that does not make sense (creep).
> > > 
> > > One observation we've had from production experiments is that the
> > > optimal number here isn't static. If you have plenty of memory, then
> > > even very sparse THPs are beneficial.
> > 
> > Exactly.
> > 
> > And willy suggested something like "eagerness" similar to "swapinness" that
> > gives us more flexibility when implementing it, including dynamically
> > adjusting the values in the future.
> >
> 
> Ideally we would be able to also apply this to the page faulting paths.
> In many cases, there's no good reason to create a THP on the first fault...
> 
> > > 
> > > An extreme example: if all your THPs have 2/512 pages populated,
> > > that's still cutting TLB pressure in half!
> > 
> > IIRC, you create more pressure on the huge entries, where you might have
> > less TLB entries :) But yes, there can be cases where it is beneficial, if
> > there is absolutely no memory pressure.
> >
> 
> Correct, but it depends on the microarchitecture. For modern x86_64 AMD, it
> happens that the L1 TLB entries are shared between 4K/2M/1G. This was not
> (is not?) the case for Intel, where e.g back on kabylake, you had separate
> entries for 4K/2MB/1GB.

On Intel secondary TLB is shared between 4k and 2M. L2 TLB for 1G is
separate.

> Maybe in the Great Glorious Future (how many of those do we have?!) it would
> be a good idea to take this kinds of things into account. Just because we can
> map a THP, doesn't mean we should.
> 
> Shower thought: it might be in these cases especially where the FreeBSD
> reservation system comes in handy - best effort allocating a THP, but not
> actually mapping it as such until you really _know_ it is hot - and until
> then, memory reclaim can just break your THP down if it really needs to.

This is just silly. All downsides without benefit until maybe later. And
for short-lived processes the "later" never comes.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
