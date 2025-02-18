Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF41B423D;
	Tue, 18 Feb 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863506; cv=none; b=t9s/Dd66s6Gf6CrIcmxva0V766Rf6raCpc5mPQ6wO3DZccJRfnnPrk7Yk1ciZreJiG40nyWahrBhAK2NH3ogufOLhWkJEwG74ANQqcfbDuR+7uyh0xCleMR/TJ+dbfWhcGICoGRfSqH3m1cSkxJDKq0jL7Q+GYPlHSG5TKndo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863506; c=relaxed/simple;
	bh=8vw7qjOHRzJxuFb5HuECnMEs8o0UACpysBm5oKep0Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiehsMSq7Fk7U2ElkjSpCi7uy47zGxi5xDpt7PU1e/1PZ07W9eWqYQKlOVc2osG0giMOOeVSCmF9XROYwTR9ssRTBtqTjtd/DafSovvQNDyBpoHdD9AMgxFx3fBDji/yIO2nkIyKrqxzRv2izmAbZTz+MUsb2KH5VHkTND2vxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU+SGjVE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU+SGjVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2050C4CEE2;
	Tue, 18 Feb 2025 07:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739863506;
	bh=8vw7qjOHRzJxuFb5HuECnMEs8o0UACpysBm5oKep0Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PU+SGjVEoG9Xd0pBqFf+epTcdZXj9L5oj+iOVYQHPSZApDubU3lgURgN2/QTfzbNp
	 l9hFx9H03Km4EQbcqstzjODnRRn81x0VMWjUY7KZDVHIZjAW3lLiMrx98WUtRKejLS
	 yB8XfmiVUKFWcKLha0cHLagEzt3oDOpmoj2Ks9TikzfVNpXf9v2ltgQncXjbeHlQZt
	 LCHOTs8RcRIphxW6SPGS6JQ9kQOQVfYK7LZ4U4ZFl0AjPKkse1Ekpuq08xIEWtDQzF
	 i9z0hTa5Oma6iAdmQQNjtNe6iHQOpsSQ8uz/ETjERHL+fd90iNVP+0LfVuGfPmBQb1
	 +xiyg8WHFsr2Q==
Date: Tue, 18 Feb 2025 09:24:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm/memblock: Add reserved memory release function
Message-ID: <Z7Q1xY3jhWjaSdeh@kernel.org>
References: <173928521419.906035.17750338150436695675.stgit@devnote2>
 <173928522350.906035.5626965043208329135.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173928522350.906035.5626965043208329135.stgit@devnote2>

Hi Masami,

On Tue, Feb 11, 2025 at 11:47:03PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add reserve_mem_release_by_name() to release a reserved memory region
> with a given name. This allows us to release reserved memory which is
> defined by kernel cmdline, after boot.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: linux-mm@kvack.org

...

> +/**
> + * reserve_mem_release_by_name - Release reserved memory region with a given name
> + * @name: The name that is attatched to a reserved memory region
> + *
> + * Forcibly release the pages in the reserved memory region so that those memory
> + * can be used as free memory. After released the reserved region size becomes 0.
> + *
> + * Returns: 1 if released or 0 if not found.
> + */
> +int reserve_mem_release_by_name(const char *name)
> +{
> +	struct reserve_mem_table *map;
> +	unsigned int page_count;
> +	phys_addr_t start;
> +
> +	guard(mutex)(&reserve_mem_lock);
> +	map = reserve_mem_find_by_name_nolock(name);
> +	if (!map)
> +		return 0;
> +
> +	start = map->start;
> +	page_count = DIV_ROUND_UP(map->size, PAGE_SIZE);
> +
> +	for (int i = 0; i < page_count; i++) {
> +		phys_addr_t addr = start + i * PAGE_SIZE;
> +		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
> +
> +		page->flags &= ~BIT(PG_reserved);
> +		__free_page(page);
> +	}

We have free_reserved_area(), please use it here.
Otherwise

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> +	map->size = 0;
> +
> +	return 1;
> +}
> +
>  /*
>   * Parse reserve_mem=nn:align:name
>   */
> 

-- 
Sincerely yours,
Mike.
