Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9BA2F5302
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928174; cv=none; b=ECTaj00sKSnU6FijDNCWw8JTNo8xm/w8oWgK7S+o00B7zl9oWzrW/G2XpPzoJ2huZ0XGsiWGwHuqmi+QldFv8dT1Cf2/IFkQKRQQQxq934kRSrnFae9DW/ECQPlXCCs/0MZxETr9epP5Oia1ABtcRv2Hmv0yjhGHfvld1p1GSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928174; c=relaxed/simple;
	bh=FCX12NufR9hPAdv0bFmisNfhDgNG0TsC9/KUddJvsbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiPLXBw642Q3/aPBvYULhOUencPXd5lEkTddAa+MNBl3/TylVyQVa3YKz97Bt2XQxgzB9NwMe6pkEFS4GYDwzfMTxehNuItCFXiCsPZDrD5B1hGeBr6bN9oU4Tg5KcHL7XR9ltemdwRqUCWptTVMqf+GoL6vi7OzXdViVsQ5hmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddgSRp7M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddgSRp7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C1DC4CEF1;
	Mon, 15 Sep 2025 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928174;
	bh=FCX12NufR9hPAdv0bFmisNfhDgNG0TsC9/KUddJvsbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddgSRp7MYQO0PpKvVULa2Y7Ou8Joa17mmVxhWUcMVEDONwpA8MWRiT4Hu5UvXEcrM
	 6CeRaGFVa4NTj2lUUlocQshU8G3QuxvtRW/Dg++Rb20pRpJvplQCG2WyBXlsIP8Bll
	 ZN5EkQEpXyvr6lVHTMo9fWGvwM96xCRvFebVXCXJGfxYtXUXtUExCFFzHJJlFMB3k/
	 Gkq+g2/UbkB9WuoBab4Qs3a0h6oJeN4umrx1Sti+y0Z2fYYX9d6xhWsY2Cc4lCyQOo
	 T/oUKV2GUNiafRHnWNbiDXDVddmL8KboT7k1luCw7g2CK2DbQrUPhQLP85KCQIHCbZ
	 fAuOk95uYQakQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 13730F40066;
	Mon, 15 Sep 2025 05:22:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 05:22:52 -0400
X-ME-Sender: <xms:69rHaBEX8--NaKtOgfLpSSuCjoFscA_2YIgMsHF3PGXj1EtIfRYaWw>
    <xme:69rHaDIYeI73CF1n7bboa4cVBQZbVHe1P3ojx3I6sHIjMNlMvzCaBhwDUFNUm4yaN
    tmmcjcYN4kziDFTCm4>
X-ME-Received: <xmr:69rHaFYX-ZyG29VFQwNq94hT6b5G8BzVzbLRmPu9xup814c3hZWTP0evMIcgEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgestheksfdttddtjeenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeetkedvheektdefhfefjeeujeejtdejuedufefhveekkeeffeetvedvffek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepleekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnphgrtghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugesrh
    gvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhtrhgrtggvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomhdprhgtphhtthho
    pegsrgholhhinhdrfigrnhhgsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpth
    htoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:69rHaHM0oXzGFzFz42IznQZHvLOHMYiGmso2AUhXWSNDW_O5pFLnfw>
    <xmx:69rHaMfhqVLAknOGODhFLpQwFOo_AQMuJWX8dj6UvWfCONKobg_CPw>
    <xmx:69rHaHaTtizXT2uzWD6RFr1F4J5BVSYYgURP90lEWJl9LsVZMX_Abg>
    <xmx:69rHaKes1mC3bPXTYnlir4bDw_7k6oIQL1DTQwkJ2kH2EriG7CYw8A>
    <xmx:7NrHaDf4P7T48R-9rl0wnfVssBgbK2dhFa8Q6nKwUgx3ByHykSNyjkIe>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:22:51 -0400 (EDT)
Date: Mon, 15 Sep 2025 10:22:48 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
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
Message-ID: <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>

On Fri, Sep 12, 2025 at 05:31:51PM -0600, Nico Pache wrote:
> On Fri, Sep 12, 2025 at 6:25 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 12.09.25 14:19, Kiryl Shutsemau wrote:
> > > On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> > >> The following series provides khugepaged with the capability to collapse
> > >> anonymous memory regions to mTHPs.
> > >>
> > >> To achieve this we generalize the khugepaged functions to no longer depend
> > >> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> > >> pages that are occupied (!none/zero). After the PMD scan is done, we do
> > >> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
> > >> range. The restriction on max_ptes_none is removed during the scan, to make
> > >> sure we account for the whole PMD range. When no mTHP size is enabled, the
> > >> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
> > >> by the attempted collapse order to determine how full a mTHP must be to be
> > >> eligible for the collapse to occur. If a mTHP collapse is attempted, but
> > >> contains swapped out, or shared pages, we don't perform the collapse. It is
> > >> now also possible to collapse to mTHPs without requiring the PMD THP size
> > >> to be enabled.
> > >>
> > >> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
> > >> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
> > >> mTHP collapses to prevent collapse "creep" behavior. This prevents
> > >> constantly promoting mTHPs to the next available size, which would occur
> > >> because a collapse introduces more non-zero pages that would satisfy the
> > >> promotion condition on subsequent scans.
> > >
> > > Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> > > all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> > >
> >
> > I am all for not adding any more ugliness on top of all the ugliness we
> > added in the past.
> >
> > I will soon propose deprecating that parameter in favor of something
> > that makes a bit more sense.
> >
> > In essence, we'll likely have an "eagerness" parameter that ranges from
> > 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
> > not all is populated".
> Hi David,
> 
> Do you have any reason for 0-10, I'm guessing these will map to
> different max_ptes_none values.
> I suggest 0-5, mapping to 0,32,64,128,255,511

That's too x86-64 specific.

And the whole idea is not to map to directly, but give kernel wiggle
room to play.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
