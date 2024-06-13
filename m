Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E1837C;
	Thu, 13 Jun 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258567; cv=none; b=OR7yxlnDFhChAm13ywu4sNOpr17SI1eRaYX9Sc1vDwTzGUnr6BVBoV4KgYokU/oHxrmq+XfJESOegvFekpz1zyARRDjNyEZYJdp5F3Ym9JnYlKFIq4UDin56F53zcAa3MPa25YABO++p57DCWPcJsHJe/9XIKyIwrzD4Cu57mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258567; c=relaxed/simple;
	bh=3sL49NFvnClvD1y18UTPpLyD+rkcg9Qkf8lGulrYlEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efMhuAsbtUlZ0wobXcipPZ6QYVYz/MY5S73mU7nb90LjcvvumjcgYsqkcwlQojP7n+w9QGMg+V9iAIpEH1dDsoIQinGDCdgtfNDAXKmQUZS/G9rZmeGItm8AMSnTOCw8xjFsC0I9sCj0iIsnQPRsLSrQMtjTy7XUj1yhXUeTVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvkO8eyv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvkO8eyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637B4C2BBFC;
	Thu, 13 Jun 2024 06:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718258567;
	bh=3sL49NFvnClvD1y18UTPpLyD+rkcg9Qkf8lGulrYlEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvkO8eyvvIQKPJoZWLyWMTfK6O5N03AQA4XC6mijqToSBsMszcXr9Ps7YULdd+mwQ
	 CMIxPSG6EFndRhrbMBaKeL08MauHHAIYDLjAKQjgKU9NWCkcTVyFrvmFQ8r91xLE5G
	 KwzQ4EytMRXAmkLSDbDYk3Jw+MQeBKW52A481j5Gd4DtQ4Vuoxq/v80A/v3kTyKhUZ
	 ykIEmOFhBgNH6uX8WEQThF4xIbon1RXDG+QAmVAq9AD4LNVqnG0TVN+3QEi1q60q0h
	 oN9NkQffZog6Xl9BoKMpr+ebDOPGgNSA3sS4mGDmYKBzRXD9g7BgXpjse/6BO5DZDa
	 qaftLWaQdNBdA==
Date: Thu, 13 Jun 2024 09:00:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v5 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <ZmqK_zeGus_VxAHN@kernel.org>
References: <20240613003435.401549779@goodmis.org>
 <20240613003508.752963299@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613003508.752963299@goodmis.org>

On Wed, Jun 12, 2024 at 08:34:36PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In order to allow for requesting a memory region that can be used for
> things like pstore on multiple machines where the memory layout is not the
> same, add a new option to the kernel command line called "reserve_mem".
> 
> The format is:  reserve_mem=nn:align:name
> 
> Where it will find nn amount of memory at the given alignment of align.
> The name field is to allow another subsystem to retrieve where the memory
> was found. For example:
> 
>   reserve_mem=12M:4096:oops ramoops.mem_name=oops
> 
> Where ramoops.mem_name will tell ramoops that memory was reserved for it
> via the reserve_mem option and it can find it by calling:
> 
>   if (reserve_mem_find_by_name("oops", &start, &size)) {
> 	// start holds the start address and size holds the size given
> 
> This is typically used for systems that do not wipe the RAM, and this
> command line will try to reserve the same physical memory on soft reboots.
> Note, it is not guaranteed to be the same location. For example, if KASLR
> places the kernel at the location of where the RAM reservation was from a
> previous boot, the new reservation will be at a different location.  Any
> subsystem using this feature must add a way to verify that the contents of
> the physical memory is from a previous boot, as there may be cases where
> the memory will not be located at the same location.
> 
> Not all systems may work either. There could be bit flips if the reboot
> goes through the BIOS. Using kexec to reboot the machine is likely to
> have better results in such cases.
> 
> Link: https://lore.kernel.org/all/ZjJVnZUX3NZiGW6q@kernel.org/
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v4: https://lore.kernel.org/linux-trace-kernel/20240611215801.443593152@goodmis.org
> 
> - Add all checks about reserve_mem before allocation.
>   This means reserved_mem_add() is now a void function.
> 
> - Check for name duplications.
> 
> - Fix compare of align to SMP_CACHE_BYTES ("<" instead of "<=")
> 
>  .../admin-guide/kernel-parameters.txt         |  20 +++
>  include/linux/mm.h                            |   2 +
>  mm/memblock.c                                 | 117 ++++++++++++++++++
>  3 files changed, 139 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index d09136e040d3..739d106a9165 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c

...

> +/*
> + * Parse reserve_mem=nn:align:name
> + */
> +static int __init reserve_mem(char *p)
> +{
> +	phys_addr_t start, size, align;
> +	char *name;
> +	char *oldp;
> +	int len;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	/* Check if there's room for more reserved memory */
> +	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
> +		return -EBUSY;
> +
> +	oldp = p;
> +	size = memparse(p, &p);
> +	if (!size || p == oldp)
> +		return -EINVAL;
> +
> +	if (*p != ':')
> +		return -EINVAL;
> +
> +	align = memparse(p+1, &p);
> +	if (*p != ':')
> +		return -EINVAL;
> +
> +	/*
> +	 * memblock_phys_alloc() doesn't like a zero size align,
> +	 * but it is OK for this command to have it.
> +	 */
> +	if (align < SMP_CACHE_BYTES)
> +		align = SMP_CACHE_BYTES;
> +
> +	name = p + 1;
> +	len = strlen(name);
> +
> +	/* name needs to have length but not too big */
> +	if (!len || len >= RESERVE_MEM_NAME_SIZE)
> +		return -EINVAL;
> +
> +	/* Make sure that name has text */
> +	for (p = name; *p; p++) {
> +		if (!isspace(*p))
> +			break;
> +	}
> +	if (!*p)
> +		return -EINVAL;
> +
> +	/* Make sure the name is not already used (size is only updated if found) */
> +	if (reserve_mem_find_by_name(name, &start, &size))
> +		return -EBUSY;

I'd prefer another variable here rather than size. Will be more robust IMO.

> +
> +	start = memblock_phys_alloc(size, align);
> +	if (!start)
> +		return -ENOMEM;
> +
> +	reserved_mem_add(start, size, name);
> +
> +	return 0;
> +}
> +__setup("reserve_mem=", reserve_mem);
> +
>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
>  static const char * const flagname[] = {
>  	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.
