Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089C3E171C;
	Tue, 12 May 2026 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591103; cv=none; b=Rbdz1C8hRZolH240Vs5nyDdW0/olzcROeojSJRc4sj9wyw/VGBdpVg2hCb0m2c5ONyGw23SUUJ2DDlAEu+7FQB4Wp7e+wsKy2Fzyq57zKmxti2yqKkOg6hfUil2f5XpqX+uwEHCIuRIpFE/lOHX99yOOw/TgS+S54an1NpHkhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591103; c=relaxed/simple;
	bh=reIL4HB0IH30r9pckDhq+IwQg23PS4LherY1kPXAT6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0unlE1wxWx8S02rHwKxEk2htevbuFmsqJryHBmraNbggDiUVKL+ot9KETQNfWDoIaYGYrt27dWjXfWiJE0s9G/UwrZGaW9zccQuKbNssHeUqX2BdL87eXIUZq7/C8Vy6xWVGtknVAmI0LOx7lB26tFnZ4n1zGlLER88yDdrNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IWxKhxuC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IWxKhxuC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E0aFRyJuhw1FtNPMKr1MBpgrmHtqCJuNbQnKGEA8QiY=; b=IWxKhxuC8RCB2ActRTE8KVCN5M
	DnB++oI0X/b1BOwytq0dCdw2EnHJ5xKN7a8N7CjMHhp6vimHXGFuskQWqFyVDCgYVjcrr/QtfyRz+
	Vhj1QBg0V3xx+ogUFvMEj/oO5A18drI7yOJFJefy7H8zgIlbq+4+3eCURXkveQPjvt5e18OHgIS3E
	803DK7ZSg6AxWI4Sz9ropY1dhIEyM+7MsALBGdkmcgi9iFa9eSbqb3QdEr2eTnSQDlTzBAl7BF3dM
	LoG2lIC4HSHeZak3IXAesaJIsDmjccUXQsB352Bp38OVfglSjXPBACflDJcF+j0nmAPLklKei7oGC
	+iJ1PGTw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMmmd-002Oak-1d;
	Tue, 12 May 2026 13:04:23 +0000
Date: Tue, 12 May 2026 06:04:15 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v6 1/4] mm/memory-failure: report MF_MSG_KERNEL for
 reserved pages
Message-ID: <agMj4ukhj1PkXXrN@gmail.com>
References: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
 <20260511-ecc_panic-v6-1-183012ba7d4b@debian.org>
 <9504c193-8c01-4d03-8f62-c50fd7fbdbc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9504c193-8c01-4d03-8f62-c50fd7fbdbc0@kernel.org>
X-Debian-User: leitao

On Tue, May 12, 2026 at 10:17:00AM +0200, David Hildenbrand (Arm) wrote:
> > @@ -2348,6 +2348,7 @@ int memory_failure(unsigned long pfn, int flags)
> >  	unsigned long page_flags;
> >  	bool retry = true;
> >  	int hugetlb = 0;
> > +	bool is_reserved;
> >  
> >  	if (!sysctl_memory_failure_recovery)
> >  		panic("Memory failure on page %lx", pfn);
> > @@ -2411,6 +2412,18 @@ int memory_failure(unsigned long pfn, int flags)
> >  	 * In fact it's dangerous to directly bump up page count from 0,
> >  	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
> >  	 */
> > +	/*
> > +	 * Pages with PG_reserved set are not currently managed by the
> > +	 * page allocator (memblock-reserved memory, driver reservations,
> > +	 * etc.), so classify them as kernel-owned for reporting.
> > +	 *
> > +	 * Sample the flag before get_hwpoison_page(): in the
> > +	 * MF_COUNT_INCREASED path, get_any_page() can drop the caller's
> > +	 * reference before returning -EIO, after which page->flags may
> > +	 * have been reset by the allocator.
> > +	 */
> > +	is_reserved = PageReserved(p);
> > +
> >  	res = get_hwpoison_page(p, flags);
> >  	if (!res) {
> >  		if (is_free_buddy_page(p)) {
> > @@ -2432,7 +2445,11 @@ int memory_failure(unsigned long pfn, int flags)
> >  		}
> >  		goto unlock_mutex;
> >  	} else if (res < 0) {
> > -		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
> > +		if (is_reserved)
> > +			res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
> > +		else
> > +			res = action_result(pfn, MF_MSG_GET_HWPOISON,
> > +					    MF_IGNORED);
> >  		goto unlock_mutex;
> >  	}
> >  
> > 
> 
> It's a bit odd that we need this handling when we already have handling for
> reserved pages in error_states[].
> 
> HWPoisonHandlable() would always essentially reject PG_reserved pages. So
> __get_hwpoison_page() ... would always fail? Making
> get_hwpoison_page()->get_any_page() always fail?
> 
> But then, we never call identify_page_state()? And never call me_kernel()?

From what I read, it seems that error_states[0] = { reserved, reserved, MF_MSG_KERNEL, me_kernel }
has been effectively dead code on the hwpoison-from-MCE path for a
while.

My v6 patch relabels the failure-path output to match what me_kernel() would
have reported anyway.

> This all looks very odd.
> 
> Why would you even want to call get_hwpoison_page() in the first place if you
> find PageReserved?

Are you suggesting we should all the page action as soon as we detect the page
is reserved and get out?

Something as:

    if (PageReserved(p)) {
        res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
        goto unlock_mutex;
    }

    res = get_hwpoison_page(p, flags);

Thanks for the review,
--breno
