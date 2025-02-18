Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3022CBD0;
	Tue, 18 Feb 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872032; cv=none; b=e2Mb7L/QmEcKkmmeo/7BPg27rNje2nC51l9KAXW0DKhr2WdTPhHVBWALxxJ2nx/wd6LSIbUUmldj2ydVRaQCKq69v0otRNomhX/9Oe2RPAFTMBoyjoxd0sLA/kMkNPpaZMerABnmpqX1FqhcBDEyIBbkdxVb/7aH0NwggZ0SGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872032; c=relaxed/simple;
	bh=RewN5nlvJM/iiydEKFf80mM01NzWJ5mNu9D7+12YtFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkyUF6HnIOpBNYrYl8p4tabTZwjTfF9B9b6fvO2Fd46vHkGmJIs4qPeyfLWM5AjHTUOqIOpf5i1BbfaP0DW2oq81Uedq5iag20NfBnxSg403odC1Tq67fwlsV+r0N6UxlE9lQe/IbdJd6Y1XIfIYtqssALDeVZw/y6GlkhsNhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxYr3p8+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxYr3p8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C41C4CEE2;
	Tue, 18 Feb 2025 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872031;
	bh=RewN5nlvJM/iiydEKFf80mM01NzWJ5mNu9D7+12YtFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxYr3p8+ONFGwBoe1iFxQlwIolL1Cznbq8f6dhKX94nIMMeQSNMLuJ4TNF4oqUsDg
	 di2QHX3OtREUPToYGwHEvIPPF/psJiHmlT3rKLI0NHX1ZUmJ6m2tbyN1bWv2rIrxcf
	 7mFDdcFWUQaCtf6tLCHuPWdpg+2TzUz0U8s9BGZ0FtLtb73kSwApNfMoN2r3wifvzC
	 KM3iXPsoh/LeRxt7ksvSTpiWTdyoPtWr1IFjeLhin+RLl9zT3etYaoijloF4PJhaQJ
	 5lGSC9GRKfalcPp7pRzRF9BzF0IZ5meUM6mrcKz68sY7tOQ42muFf1IBeKDS2QmDTN
	 ZeDmaT0MZD6KQ==
Date: Tue, 18 Feb 2025 11:47:05 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm/memblock: Add reserved memory release function
Message-ID: <Z7RXGX/TyAvETRgc@kernel.org>
References: <173928521419.906035.17750338150436695675.stgit@devnote2>
 <173928522350.906035.5626965043208329135.stgit@devnote2>
 <Z7Q1xY3jhWjaSdeh@kernel.org>
 <20250218174257.61018735a30268b5e21e50e3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218174257.61018735a30268b5e21e50e3@kernel.org>

On Tue, Feb 18, 2025 at 05:42:57PM +0900, Masami Hiramatsu wrote:
> Hi Mike,
> 
> On Tue, 18 Feb 2025 09:24:53 +0200
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Hi Masami,
> > 
> > On Tue, Feb 11, 2025 at 11:47:03PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Add reserve_mem_release_by_name() to release a reserved memory region
> > > with a given name. This allows us to release reserved memory which is
> > > defined by kernel cmdline, after boot.
> > > 
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: linux-mm@kvack.org
> > 
> > ...
> > 
> > > +/**
> > > + * reserve_mem_release_by_name - Release reserved memory region with a given name
> > > + * @name: The name that is attatched to a reserved memory region
> > > + *
> > > + * Forcibly release the pages in the reserved memory region so that those memory
> > > + * can be used as free memory. After released the reserved region size becomes 0.
> > > + *
> > > + * Returns: 1 if released or 0 if not found.
> > > + */
> > > +int reserve_mem_release_by_name(const char *name)
> > > +{
> > > +	struct reserve_mem_table *map;
> > > +	unsigned int page_count;
> > > +	phys_addr_t start;
> > > +
> > > +	guard(mutex)(&reserve_mem_lock);
> > > +	map = reserve_mem_find_by_name_nolock(name);
> > > +	if (!map)
> > > +		return 0;
> > > +
> > > +	start = map->start;
> > > +	page_count = DIV_ROUND_UP(map->size, PAGE_SIZE);
> > > +
> > > +	for (int i = 0; i < page_count; i++) {
> > > +		phys_addr_t addr = start + i * PAGE_SIZE;
> > > +		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
> > > +
> > > +		page->flags &= ~BIT(PG_reserved);
> > > +		__free_page(page);
> > > +	}
> > 
> > We have free_reserved_area(), please use it here.
> > Otherwise
> > 
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thanks! but I can not use free_reserved_area() here because it uses
> virt_to_page(). Here we only know the physical address in the map.
> I think we can use free_reserved_page() instead. Is that OK?

For reserve_mem ranges virt_to_phys() will work, they are allocated from the
memory that is covered by the direct map.
 
> Thank you,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Sincerely yours,
Mike.
