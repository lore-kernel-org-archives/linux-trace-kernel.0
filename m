Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FD232373;
	Tue, 18 Feb 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868180; cv=none; b=uDoFzFTb6bzntzDcnAf2UUWOtAO1rYb1WLdOode2c7o38kkzDdSzIL55nUJTahnk+zbN9PWkTDDdM7dtDn/Oj2ckqdybfitmxdZuu+ct7Kk+EETyIXar6CDGX75lWd518ddXfmtOLV7oPl3yQnmRL/7atW2Wqi4T8vGzvA1xnq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868180; c=relaxed/simple;
	bh=dZj4WZKT+DPeEny8O4y/kHznbdhmpc4YiiO8vAgv9xQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DYD5+J4ZYyTt1QBvYQI6gDJEdrz/3jytQFoklYLvT1JcVgeGHrqdOBoGQBVsj7DS7ojGqlEKZlyQv6jIJjEbITUfKpgfgJUMHkMQb8Mi6Jefq2sRxetd/iMOItSoT2UO5rtn+n7pymAqmXXZmv1ySqYUxxf7R3tEnsTQV7eclYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSY8zTlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSY8zTlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E96C4CEE2;
	Tue, 18 Feb 2025 08:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739868180;
	bh=dZj4WZKT+DPeEny8O4y/kHznbdhmpc4YiiO8vAgv9xQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSY8zTlLGGME3fNBQLvfB4Hhhq/C9RBpdnk1C4vnK1mlkKk8JSg9qbE4kbKAqAPIw
	 c3IBQnAhRK+wDwwbMyYBUjrsqWIWIShBYj0bonDHAY3W3u5gFHHA/x2gHgXj/IprXA
	 XZMtNsNjLO4wyrw8vEWagbn6XqLJYJcm28A3u8wl5eLPx7BqpxRxLlWsAiIOEuq5FC
	 UfsBH9IN6dpb/OeEs5QlrHD/GzRMR4ze1ecuX/xwQxr5aDWKOHkOXYLDpwmi+T6tz0
	 9idnNcB69/mYFp8LoR6dmRVsGYs261+RP5J4+sUncMtkqF1bZokm/y7q8SBmDPq9nH
	 Xj2BzxsQbFHPA==
Date: Tue, 18 Feb 2025 17:42:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm/memblock: Add reserved memory release
 function
Message-Id: <20250218174257.61018735a30268b5e21e50e3@kernel.org>
In-Reply-To: <Z7Q1xY3jhWjaSdeh@kernel.org>
References: <173928521419.906035.17750338150436695675.stgit@devnote2>
	<173928522350.906035.5626965043208329135.stgit@devnote2>
	<Z7Q1xY3jhWjaSdeh@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mike,

On Tue, 18 Feb 2025 09:24:53 +0200
Mike Rapoport <rppt@kernel.org> wrote:

> Hi Masami,
> 
> On Tue, Feb 11, 2025 at 11:47:03PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add reserve_mem_release_by_name() to release a reserved memory region
> > with a given name. This allows us to release reserved memory which is
> > defined by kernel cmdline, after boot.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: linux-mm@kvack.org
> 
> ...
> 
> > +/**
> > + * reserve_mem_release_by_name - Release reserved memory region with a given name
> > + * @name: The name that is attatched to a reserved memory region
> > + *
> > + * Forcibly release the pages in the reserved memory region so that those memory
> > + * can be used as free memory. After released the reserved region size becomes 0.
> > + *
> > + * Returns: 1 if released or 0 if not found.
> > + */
> > +int reserve_mem_release_by_name(const char *name)
> > +{
> > +	struct reserve_mem_table *map;
> > +	unsigned int page_count;
> > +	phys_addr_t start;
> > +
> > +	guard(mutex)(&reserve_mem_lock);
> > +	map = reserve_mem_find_by_name_nolock(name);
> > +	if (!map)
> > +		return 0;
> > +
> > +	start = map->start;
> > +	page_count = DIV_ROUND_UP(map->size, PAGE_SIZE);
> > +
> > +	for (int i = 0; i < page_count; i++) {
> > +		phys_addr_t addr = start + i * PAGE_SIZE;
> > +		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
> > +
> > +		page->flags &= ~BIT(PG_reserved);
> > +		__free_page(page);
> > +	}
> 
> We have free_reserved_area(), please use it here.
> Otherwise
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks! but I can not use free_reserved_area() here because it uses
virt_to_page(). Here we only know the physical address in the map.
I think we can use free_reserved_page() instead. Is that OK?

Thank you,


> 
> > +	map->size = 0;
> > +
> > +	return 1;
> > +}
> > +
> >  /*
> >   * Parse reserve_mem=nn:align:name
> >   */
> > 
> 
> -- 
> Sincerely yours,
> Mike.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
