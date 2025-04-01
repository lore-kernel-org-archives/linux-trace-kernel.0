Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82238207A1F;
	Tue,  1 Apr 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521211; cv=none; b=X2AU3YRh5hjFUrtgpbYI2E8d4zTcFdUTA0uFMOLjunwLb97N0G3q6qZDEfqGSJcHY37gEcYsWj3tRheYp7+BB9xOuMVNLEqf+lrW0Vhp+sAX+umReMoZGnGUYpwxNofJQrISjVIBuAx4E98vyKrHKBAT7O7VslNtcNTL4+Nesqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521211; c=relaxed/simple;
	bh=/ohicfUBP224KyzqJct/MrQi5KS4J8o/vn8O7erypHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHtA7cen5IBDLt1o4hN6q9xryr/n8An77zH0+9HFmYDO0kPdCWbl3CO06EqtMAiWw6CCXcpCyhd+yJ3U7CXLBpA2P9FaAe+/Tj8cx9AsZqVLkTwG470XD2hCBv3qSH2eru3W/QA/hz5YTvzyYkP2ixTjw+9XBZ7P1PyMMApAaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFKgTwta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFKgTwta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCA3C4CEE4;
	Tue,  1 Apr 2025 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743521211;
	bh=/ohicfUBP224KyzqJct/MrQi5KS4J8o/vn8O7erypHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFKgTwtaSF18L3xEbNMyfuUS7wsob5GxRbvLvGMRYI8DqRW/wfNT2pOQsQGGMKvpB
	 bWGDTvMIkGDSuR0Ix96qziD/nCjNPbyDlHQhtf+MOJS40HcCJvQnd68iJpdJuJt5Cj
	 +2XxB7+uGQfCwg12FWI72rRAHPsQWXknMv6SVVgV4sx9n7PVvBsTp6IInimEeHLQpE
	 WB+gtAGwXJwktpNgQq6j5Zqq9LI1H6uJh53K1+COf1oFzr7XHoJtcaPItjQtrfEKhi
	 89ac4Apeecv40EOdS2wCLq/toITNdIeF/+lJwBqErZ8vPXgeeOL9qX4/VPytAmOa3k
	 4iWwtklsiy/LA==
Date: Tue, 1 Apr 2025 18:26:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <Z-wFszhJ_9o4dc8O@kernel.org>
References: <20250331143426.947281958@goodmis.org>
 <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home>
 <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home>
 <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <Z-u4Tzz9J8hSk6G7@kernel.org>
 <20250401111159.7632a0fa@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401111159.7632a0fa@gandalf.local.home>

On Tue, Apr 01, 2025 at 11:11:59AM -0400, Steven Rostedt wrote:
> On Tue, 1 Apr 2025 12:56:31 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > For example, using "mem=" on the kernel command line will literally
> > > limit the amount of RAM the kernel will use, and in doing so will
> > > limit the page allocations too.  
> > 
> > And using memmap=m$n on x86 creates a hole in System RAM that does not have
> > neither struct page nor kernel mappings and it is never considered RAM
> > anywhere in mm.
> 
> Hmm, when that is used, then we had better not "free" the buffer.
> 
> >  
> > > IOW, all of these kernel command line things are *subtle*.
> > > 
> > > Don't mis-use them by then making assumptions about how they work
> > > today (or how they will work tomorrow).  
> > 
> > I'd say it's better not to use them at all. They cause weirdness in memory
> > layout and also they are inconsistent in how architectures implement them.
> >  
> > > > Mike can correct me if I'm wrong, but the memory that was stolen was actual
> > > > memory returned by the system (E820 in x86). It reserves the memory before
> > > > the memory allocation reserves this memory. So what reserve_mem returns is
> > > > valid memory that can be used by memory allocator, but is currently just
> > > > "reserved" which means it wants to prevent the allocator from using it.  
> > > 
> > > That may indeed be true of reserve_mem.  
> > 
> > The reserve_mem behaves like any other early allocation, it has proper
> > struct pages (PG_Reserved) and it is mapped in the direct map so
> > phys_to_virt() will work on it.
> > 
> > As for mapping it to userspace, vm_iomap_memory() seems the best API to
> > use. It has all the alignment checks and will refuse to map ranges that are
> > not properly aligned and it will use vma information to create the right
> > mappings.
> >  
> 
> When using vmap() to get the virtual addresses (via the kmalloc_array() of
> struct pages), the vunmap() gives the memory back to the memory allocator:
> 
> ~# free
>                total        used        free      shared  buff/cache   available
> Mem:         8185928      296676     7840576         920      148280     7889252
> Swap:        7812092           0     7812092
> ~# rmdir /sys/kernel/tracing/instances/boot_mapped/
> ~# free
>                total        used        free      shared  buff/cache   available
> Mem:         8206404      290868     7866772         920      148384     7915536
> Swap:        7812092           0     7812092
> 
> With no issues.
> 
> But if I use vmap_page_range(), how do I give that back to the memory allocator?

But you don't need neither vmap() nor vmap_page_range() to have kernel page
tables for memory that you get from reserve_mem. It's already mapped and
plain phys_to_virt() gives you the virtual address you can use.
 
> Calling vunmap() on that memory gives me:
> 
>  1779.832484] ------------[ cut here ]------------
> [ 1779.834076] Trying to vunmap() nonexistent vm area (000000027c000000)
> [ 1779.835941] WARNING: CPU: 6 PID: 956 at mm/vmalloc.c:3413 vunmap+0x5a/0x60
> 
> What's the proper way to say: "I no longer need this physical memory I
> reserved, the kernel can now use it"?
 
free_reserved_area()

> -- Steve

-- 
Sincerely yours,
Mike.
