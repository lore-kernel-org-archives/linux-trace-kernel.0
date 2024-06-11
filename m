Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587B15278E;
	Tue, 11 Jun 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145390; cv=none; b=QvqWY8o4LD+R9K536C8FBySfbkMh+CZQI0x+9VLb+ox32XZFH1IHMDaz+F0cjF5mMezFupaR5Tb0lk032RHn0ys05r36CiyB7Z0A9EiEkv9OqPyUue2zXgv3SLKqEBb7YYdXKnndSceHqwX11AdGqgWoHmpwdzdkZy6RBYKP0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145390; c=relaxed/simple;
	bh=oz2WDd+8rgQTA6tAKBoiy2olZlmCeF6niFRohD0MmbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0XhJKvPyJw5iLnbc45REMKpieL6CYNwqEWOp5vdcR8v+GdAtZrrTFcSsTciu35UW7OegBeTMW985PTGoC9QsZh5HOopMfWfFjvydDZM1dXYTR3Ubf8rgFVi6oVPoe9rqtU6/TeFxQ0dVKZFBs7ga1LwjDHO32Nc5A3PHj9HTDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E625CC2BD10;
	Tue, 11 Jun 2024 22:36:26 +0000 (UTC)
Date: Tue, 11 Jun 2024 18:36:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mike
 Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240611183643.0327ef5b@gandalf.local.home>
In-Reply-To: <d6c55ff7-91ac-4505-b821-1416d57edda9@roeck-us.net>
References: <20240611215610.548854415@goodmis.org>
	<20240611215801.443593152@goodmis.org>
	<d6c55ff7-91ac-4505-b821-1416d57edda9@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 15:26:05 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index d09136e040d3..044ddce8f085 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2244,6 +2244,121 @@ void __init memblock_free_all(void)
> >   	totalram_pages_add(pages);
> >   }
> >   
> > +/* Keep a table to reserve named memory */
> > +#define RESERVE_MEM_MAX_ENTRIES		8
> > +#define RESERVE_MEM_NAME_SIZE		16
> > +struct reserve_mem_table {
> > +	char			name[RESERVE_MEM_NAME_SIZE];
> > +	phys_addr_t		start;
> > +	phys_addr_t		size;
> > +};
> > +static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
> > +static int reserved_mem_count;
> > +
> > +/* Add wildcard region with a lookup name */
> > +static int __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
> > +				   const char *name)
> > +{
> > +	struct reserve_mem_table *map;
> > +
> > +	if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
> > +		return -EINVAL;
> > +  
> 
> I know I am picky, but name is never NULL, and strlen(name) is guaranteed to be > 0.
> Personally I'd suggest to check for strlen(name) >= RESERVE_MEM_NAME_SIZE together
> with !strlen(name) and drop the duplicate checks here (and, as side effect, avoid
> the pointless memory allocation if the name is invalid).

Yeah, it's now checked before hand. I'll remove it for v5.

> 
> > +	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
> > +		return -1;
> > +
> > +	map = &reserved_mem_table[reserved_mem_count++];
> > +	map->start = start;
> > +	map->size = size;
> > +	strscpy(map->name, name);
> > +	return 0;
> > +}
> > +


> > +/*
> > + * Parse reserve_mem=nn:align:name
> > + */
> > +static int __init reserve_mem(char *p)
> > +{
> > +	phys_addr_t start, size, align;
> > +	char *name;
> > +	char *oldp;
> > +	int err;
> > +
> > +	if (!p)
> > +		return -EINVAL;
> > +
> > +	oldp = p;
> > +	size = memparse(p, &p);
> > +	if (!size || p == oldp)
> > +		return -EINVAL;
> > +
> > +	if (*p != ':')
> > +		return -EINVAL;
> > +
> > +	align = memparse(p+1, &p);
> > +	if (*p != ':')
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * memblock_phys_alloc() doesn't like a zero size align,
> > +	 * but it is OK for this command to have it.
> > +	 */
> > +	if (align <= SMP_CACHE_BYTES)  
> 
> Any reason for using <= instead of < ?

Nope. Not sure why I did that. :-/

I'll fix that too.

Thanks,

-- Steve

> 
> Guenter
> 
> > +		align = SMP_CACHE_BYTES;
> > +
> > +	name = p + 1;
> > +	if (!strlen(name))
> > +		return -EINVAL;
> > +
> > +	/* Make sure that name has text */
> > +	for (p = name; *p; p++) {
> > +		if (!isspace(*p))
> > +			break;
> > +	}
> > +	if (!*p)
> > +		return -EINVAL;
> > +
> > +	start = memblock_phys_alloc(size, align);
> > +	if (!start)
> > +		return -ENOMEM;
> > +
> > +	err = reserved_mem_add(start, size, name);
> > +	if (err) {
> > +		memblock_phys_free(start, size);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +__setup("reserve_mem=", reserve_mem);
> > +
> >   #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> >   static const char * const flagname[] = {
> >   	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",  

