Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBDE284889;
	Mon, 17 Nov 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414942; cv=none; b=UW/6mO8MwQxGzGuV5EZf3EMaHZRPP5XYE6kCh+aStQDgKUdoqAH6g8+5RDyZiuYrNPHXgR3vurZgnr1ByCVNBSedwvxOgiDtQQ8WJxPfiCA+ledJpM7bBDlh7n1BcOyf4I/uNcSr7KDYf6pPsO7p+jax7/yjfMglu4zJOqeVeuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414942; c=relaxed/simple;
	bh=iUfXNTDIhu/Fmhl5nM6ZwUX9XoSb4lcORth57vwCh2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHBSOl2WmXdoVkjaVl2K5IoUtR7vuLw/lrsN/wsGq7YTsI2mw3+eVbeJ1TJou9AZMLatxPSlbfQAbH5GADHKs7WstaHOcf06dvsm0q8su1LDBGI9Z7K4AVO8WNDi9c6PIr0NyDlamY7MUIkP5TeUvWZ5WW2hH54iyKRrXGwnPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaUWARs8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaUWARs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D98C2BCB0;
	Mon, 17 Nov 2025 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763414940;
	bh=iUfXNTDIhu/Fmhl5nM6ZwUX9XoSb4lcORth57vwCh2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YaUWARs8wMck47fp1ETJXoMlaT7/8oZ3lVYqxlHwyHWpVleiGWX0FcNo0ZoJM4Z4C
	 wszTf4SdTfdGmbIRTjPv9DI4H4zk+8RxJwwOyjyW/gn0r7oBFui1WPdSorq3HqwuEm
	 fp/qfsFXYVZn9Jf3ro4BdgT4/qu3YjqhiWXpbkLthI4KG1CMqSDPKvxxmWLCK490yn
	 KxSIskzxBtZiTmCxsB1Kq0QJkovt2V5cZ8akCqQVDcO553QYDvP/M/nwm0aK4VWkLf
	 OdHsNa0zQDgUHI0Jl6dbFT9Vek1WEs9jQvLfzfIab9GGhipDDAt+snduN0qByiFD3E
	 Uo4WEzRVGwhQQ==
Date: Mon, 17 Nov 2025 13:28:59 -0800
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH] unwind: Show that entries of struct unwind_cache is not
 bound by nr_entries
Message-ID: <202511171303.1623D77@keescook>
References: <20251114121352.35108fb8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114121352.35108fb8@gandalf.local.home>

On Fri, Nov 14, 2025 at 12:13:52PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The structure unwind_cache has:
> 
> struct unwind_cache {
> 	unsigned long		unwind_completed;
> 	unsigned int		nr_entries;
> 	unsigned long		entries[];
> };
> 
> Which triggers lots of scripts to convert this to:
> 
> struct unwind_cache {
> 	unsigned long		unwind_completed;
> 	unsigned int		nr_entries;
> 	unsigned long		entries[] __counted_by(nr_entries);
> };
> 
> But that is incorrect. The structure is created via:
> 
>  #define UNWIND_MAX_ENTRIES					\
> 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
> 
>  info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES), GFP_KERNEL);
> 
> Where the size of entries is determined by the size of the rest of the
> structure subtracted from 4K. But because the size of entries has a
> dependency on the structure itself, it can't be used to define it.
> 
> The entries are filled by another function that returns how many entries it
> added and that is what nr_entries gets set to. This would most definitely
> trigger a false-positive out-of-bounds bug if the __counted_by() was added.

Just so I'm clear: "nr_entries" shows how many _valid_ entries exist in
entries[] (even if more are allocated there)? (Wouldn't you still want to
know if something tried to access an invalid entry? But I digress...)

> To stop scripts from thinking this needs a counted_by(), move the
> UNWIND_MAX_ENTRIES macro to the header, and add a comment in the entries
> size:
> 
> 	unsigned long		entries[ /* UNWIND_MAX_ENTRIES */ ];

This doesn't solve the problem that we've hidden the actual size of the
(fixed size!) object from the compiler, forcing it to avoid doing bounds
checking on it.

The problem is that the non-"entries" portion of the struct doesn't have
a "name" associated with it at declaration time, but we have a solution
for that already: struct_group. I would propose this form instead, which
requires no changes to how unwind_cache is used, and allows for the true
size of the "entries" array to be exposed to the compiler (and allows
for "normal" methods of finding the max entries):

struct unwind_cache {
	struct_group_tagged(unwind_cache_hdr, hdr,
		unsigned long unwind_completed;
		unsigned int  nr_entries;
	);
	unsigned long         entries[(SZ_4K - sizeof(struct unwind_cache_hdr)) / sizeof(long)];
};

#define UNWIND_MAX_ENTRIES ARRAY_SIZE(((struct unwind_cache*)NULL)->entries)

And this checks out for me:

UNWIND_MAX_ENTRIES:510
sizeof(struct unwind_cache):4096

No hiding things from the compiler, and you can treat "entries" like a
real array (since it is one now).

-Kees

-- 
Kees Cook
