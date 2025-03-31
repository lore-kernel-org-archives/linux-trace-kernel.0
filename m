Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B399139D1B;
	Mon, 31 Mar 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442690; cv=none; b=uXkl+5cGKXO6UUoI/QRQV507Z9UCZh7d4/dVawCFySKS6A4MZ+ZIUC4a9rz3g+glQlHqXg5j0zEuSvMtPYypZW+R77mrGpBOtnEpxjnBvO6g/3GBBDP0VmG9d/l2yWIvFvyXSs6vDfgF2jZ7zOoLt6ydzUOQt184JeXdGZisEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442690; c=relaxed/simple;
	bh=4iXrT9ZY4Xoqd9GGuS3SRMQkL/GITaKNwVGMJSBVvCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWUrxolAoASE25IYDpdQTjB2YqMbu+XhelmddvTwd7nkDexPg4XdMNO4qxy8lsctxprxXj5a2hlLgoOnwoWwYO0/BzXtwqc8CbIVMS+L8PWxS3SW6RijmtXc5+QQll6QzQgCsno53MR55fIv4I3pbBiQLa0gF68YztfuggdBtW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D453C4CEE3;
	Mon, 31 Mar 2025 17:38:08 +0000 (UTC)
Date: Mon, 31 Mar 2025 13:39:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250331133906.48e115f5@gandalf.local.home>
In-Reply-To: <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 09:55:28 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> > +       /* Make sure the mappings are page aligned */
> > +       *start = ALIGN(*start, PAGE_SIZE);  
> 
> The above is *completely* unacceptable.
> 
> There is no way in hell that ALIGN() can ever be right.

I just did this to be robust in case what was passed in was not aligned. In
all my use cases, it is.

> 
> You don't even fix up the low bits of the returned virtual address, so
> you literally return the virtual address of something that doesn't
> match what was passed in.
> 
> So if you pass it a starting area that isn't page-aligned, it now
> randomly gives you complete crap back, and includes some random
> unrelated part in the mapping.
> 
> So no. That needs to be a
> 
>         if (*start & PAGE_MASK)
>                 return NULL;

No problem, will update. As I said, I just added that to not map something
that wasn't part of what was passed in. But returning error if it's not
page aligned works for me too.

> 
> or whatever. Because just randomly corrupting the base address by
> ignoring the low bits is not ok.
> 
> > +       /* The size must fit full pages */
> > +       page_count = size >> PAGE_SHIFT;  
> 
> This part works, simply because truncating the size is fine. It won't
> all get mapped, but that's the caller's problem, at least the code
> isn't returning random crap that has random other data in it.
> 
> That said, I don't see the point. If you want to virtually map
> physical pages, they need to be full pages, otherwise the end result
> gets randomly truncated. So I think that while this is much better
> than the "return random crap that doesn't make any sense", it should
> be the same rule: just don't allow mapping partial pages.
> 
> So make it be
> 
>         if (size & PAGE_MASK)
>                 return NULL;
> 
> instead, and just enforce the fact that allocations have to be sanely
> aligned for vmap.

Again, I'm happy to error out on non alignment. I'll just update the
documentation to say it must be page size aligned. Currently it shows an
example of using 4096 for alignment, but that should be changed to
explicitly say to have it page aligned, as some archs (ppc) have 64K pages.

> 
> Anyway, that takes care of the horrific interface. However, there's
> another issue:
> 
> > +       pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);  
> 
> you create this pointless array of pages. Why? It's a physically
> contiguous area.
> 
> You do that just because you want to use vmap() to map that contiguous
> area one page at a time.
> 
> But this is NOT a new thing. It's exactly what every single PCI device
> with a random physical memory region BAR needs to do. And no, they
> don't create arrays of 'struct page *', because they use memory that
> doesn't even have page backing.
> 
> So we actually have interfaces to do linear virtual mappings of
> physical pages that *predate* vmap(), and do the right thing without
> any of these games.

[ Added the pstore folks ]

OK, so I did copy this from fs/pstore/ram_core.c as this does basically the
same thing as pstore. And it looks like pstore should be updated too.

> 
> Yes, the legacy versions of interfaces are all for IO memory, but we
> do have things like vmap_page_range() which should JustWork(tm).
> 
> Yeah, you'll need to do something like
> 
>         unsigned long vmap_start, vmap_end;
> 
>         area = get_vm_area(size, VM_IOREMAP);
>         if (!area)
>                 return NULL;
> 
>         vmap_start = (unsigned long) area->addr;
>         vmap_end = vmap_start + size;
> 
>         ret = vmap_page_range(vmap_start, vmap_end,
>                 *start, prot_nx(PAGE_KERNEL));
> 
>         if (ret < 0) {
>                 free_vm_area(area);
>                 return NULL;
>         }
> 
> and the above is *entirely* untested and maybe there's something wrong
> there, but the concept should work, and when you don't do it a page at
> a time, you not only don't need the kmalloc_array(), it should even do
> things like be able to use large page mappings if the alignment and
> size work out.
> 
> That said, the old code is *really* broken to begin with. I don't
> understand why you want to vmap() a contiguous physical range. Either
> it's real pages to begin with, and you can just use "page_address()"
> to get a virtual address, it's *not* real pages, and doing
> "pfn_to_page()" is actively wrong, because it creates a fake 'struct
> page *' pointer that isn't valid.
> 
> Is this all just for some disgusting HIGHMEM use (in which case you
> need the virtual mapping because of HIGHMEM)? Is there any reason to
> support HIGHMEM in this area at all?
> 
> So I'm not sure why this code does all this horror in the first place.
> Either it's all just confused code that just didn't know what it was
> doing and just happened to work (very possible..) or there is
> something odd going on.

[ Adding Mike Rapoport ]

This is due to what the "reserve_mem" kernel command line feature gives
back. It reserves physical memory that is not part of the kernel memory
allocator (it also works with memmap ie. memmap=12M$0x284500000, which also
requires physical memory addresses that are not part of the memory
allocator).

It's up to the user to map it to virtual memory. The same is true for
ramoops in pstore.

-- Steve
