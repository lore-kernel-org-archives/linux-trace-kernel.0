Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38E3148B8;
	Fri, 12 Sep 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691863; cv=none; b=YOUSqgnJPViOGg34PMTojVBLqJnoa3zqHIx/FRUoZKgMrjhzE1CnSK1Ep12o/htCBrpjW5TPk44hWXbIRmzSQ4PKr72xaAGX2Zt3t6WtwiKWcaG0AhTTsXUDU2Vpaoa0jQkaX2h+x8fgtP1yu1M7suxD3bVVOgOkmGmPBMGkO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691863; c=relaxed/simple;
	bh=kpVYj7WUHWfm+jnW6bApk8xbRCU272PKzrnqUyqiGjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm0aJgG4+N/QMqzXHyhYnv9X24kJkvbda4Xk6NrrVl1xLMEVNL70UXbS6uXaaQaWz357U6F1AUdPgyt7amXTLuGm6yE1KYmYiKZ6+L3mTmmrpITEkRn3ikXO5KH+rwiJUN6M9/MkX1sCzOhVPrTlll8hyRsj7rQo/iK0p/9Gfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZb7/Ffl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZb7/Ffl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A148C4CEF4;
	Fri, 12 Sep 2025 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757691863;
	bh=kpVYj7WUHWfm+jnW6bApk8xbRCU272PKzrnqUyqiGjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZb7/Ffllikt1PXlZ4utdqkFTqhzSxJ5t3jjKXQPzjS6QCKL3ZeYIUb0qIELhKAA5
	 5hybKO1qwzk2htug/5MY/L+aEf4Ez6KNb9p7NeHUxVC6hxfUxXi3vCzzOzSLH0C00G
	 239Edai8GH+VbnsmgHWnHsGW8pS9ESiwU3cJEba+vgBj+N1zRV8aEU1vWMStYvoshh
	 5kmkF+q3sIgQsQhnYtdR8JfZwRMOEUDIL/4c8JsbHZwjVxcU0pHAMN0V3J9qMh1rJ6
	 DTF4ed9NcpU6eYdNqF+3nnu+dG4y3Bhh76nYrwp2HbR3Q4Yvn5w/SaXWneo/yDxCqC
	 EUI4teo+YWajA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id A9237F40066;
	Fri, 12 Sep 2025 11:44:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 12 Sep 2025 11:44:20 -0400
X-ME-Sender: <xms:1D_EaGsWdRp8F2mVm6-IDKfSFB5-M77EMj4jXSx81KrLf9NRyNvxmw>
    <xme:1D_EaIStNObfpHQ21qmqZHb_7SDbSk7iv-3_vQvA5woaku-3eV5qO-YwmiydSw0xI
    qfYK4r_F0OHV6txsq8>
X-ME-Received: <xmr:1D_EaEBXBCr6dqXqn_-3KAeNQ6mzJf30RPAeY9ttbW1bG5HuePVKwFjrgjqd7Q>
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
    ohepphhfrghltggrthhosehsuhhsvgdruggvpdhrtghpthhtohepuggrvhhiugesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhr
    tghpthhtohepnhhprggthhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihihiesnhhvih
    guihgrrdgtohhm
X-ME-Proxy: <xmx:1D_EaBWnj324dLTo8bCSbIZLTbHfiqWiI4VScbBxm134V47WNLcrHA>
    <xmx:1D_EaME8hhyGlnR9VQGNhVof7qnANEr9X7-uIjIsAUeYZbnU8ELefw>
    <xmx:1D_EaOjrvcP-XNRIvuq0ERhwqIC43EqDXUxoY7x4Irxu4J4iSFNEFg>
    <xmx:1D_EaDHBha3yZ9jrV0t5GvDpnySHp8c1Pga83bdlxixzD5-j2B6oNg>
    <xmx:1D_EaPmyd0IDEoFruMoEWLoJfqlGsi9WDWcu7SnNijalaLzDLKxCPS9y>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 11:44:19 -0400 (EDT)
Date: Fri, 12 Sep 2025 16:44:17 +0100
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
Message-ID: <y6ljs2byyzxkxqqxaf37kx5lqpshv47ndejksen2ihrvhcwksc@4r6f4sdtjd3g>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
 <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
 <hcpxpo3xpqcppxlxhmyxkqkqnu4syohhkt5oeyh7qse7kvuwiw@qbhiubf2ubtm>
 <k54teuep6r63gbgivpka32tk47zvzmy5thik2mekl5xpycvead@fth2lv4kuicg>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k54teuep6r63gbgivpka32tk47zvzmy5thik2mekl5xpycvead@fth2lv4kuicg>

On Fri, Sep 12, 2025 at 04:39:02PM +0100, Kiryl Shutsemau wrote:
> > Shower thought: it might be in these cases especially where the FreeBSD
> > reservation system comes in handy - best effort allocating a THP, but not
> > actually mapping it as such until you really _know_ it is hot - and until
> > then, memory reclaim can just break your THP down if it really needs to.
> 
> This is just silly. All downsides without benefit until maybe later. And
> for short-lived processes the "later" never comes.

The right way out is to get better info on access pattern from hardware.
For instance, if we move access bit out of page table entry and make it
independent of the actually mapping size that would give us much better
view on what actually is going on.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
