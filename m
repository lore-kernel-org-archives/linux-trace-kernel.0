Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88E19CC39;
	Thu,  3 Apr 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698752; cv=none; b=N2lJ89bcimn1xjYbuwKdvcM6bpy8GOM00+qP8ddxs38boAGPwzZ3EVYK0k/Efu9M9sgBkClF7zxwxueNGb1O0itHfUQAFiUt1LwtnQf6aYmXV5cQL+2ra0shl6ORNJI6DJhcj94mBGyfWuweoXYSL7Vbh7hCYYDBGlSa/3IvrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698752; c=relaxed/simple;
	bh=QlqqyTgfhOBUsMseHj0iRoTR9OP1M3MGpYbSHK7gYic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcJ971uW0RyzA+x2TPNO8vEz41cAV3Eu+O0gcOwFFBwt5Fi1RHlAuaDRADiDCZ2uJ0eur3vCqCkE6sm7O/Y7a32R8+r0aoDrBgd/fVbC/g6tR1jaAMBsP1I1GAcZ6IpW+jprYZH5TMQlAoW+LcnZab296f67wmhb7cnO0MW5Wis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0mntNNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0mntNNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EC1C4CEE3;
	Thu,  3 Apr 2025 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743698752;
	bh=QlqqyTgfhOBUsMseHj0iRoTR9OP1M3MGpYbSHK7gYic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0mntNNzRmV6GKNQWRx6dyXta5EpZ4+jICdyeitrea0jCYexlG241JBHs1nCNuqd4
	 eSda6m+R7PYLlXN6LXMh/HhPOh26+KGmEm+NFmSFYezoyLFSy4T1tdHh5nF16nxblP
	 OBdBR7DXyhfYBDSJe4157HLEwCh6MaqfwzVl7FDPXjGYZ2jnFINMN/ZbEqHTRHfuhb
	 XMBhOrJPV05l2m/8S+uNbD55cM8NcnawXR5x0oFNciKe/hXGE8ks8k8sMWDXqeTTC8
	 rdaV7rjTRKoJHgWIL23/N1xw6hsz5+WrOBMWv8h+G12Uv+YL4DbcMjKMh/ZNmtw7rp
	 j0Ql0iexXV8Uw==
Date: Thu, 3 Apr 2025 09:45:48 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <202504030941.E0AA2E023@keescook>
References: <20250331143426.947281958@goodmis.org>
 <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331133906.48e115f5@gandalf.local.home>

On Mon, Mar 31, 2025 at 01:39:06PM -0400, Steven Rostedt wrote:
> On Mon, 31 Mar 2025 09:55:28 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Anyway, that takes care of the horrific interface. However, there's
> > another issue:
> > 
> > > +       pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);  
> > 
> > you create this pointless array of pages. Why? It's a physically
> > contiguous area.
> > 
> > You do that just because you want to use vmap() to map that contiguous
> > area one page at a time.
> > 
> > But this is NOT a new thing. It's exactly what every single PCI device
> > with a random physical memory region BAR needs to do. And no, they
> > don't create arrays of 'struct page *', because they use memory that
> > doesn't even have page backing.
> > 
> > So we actually have interfaces to do linear virtual mappings of
> > physical pages that *predate* vmap(), and do the right thing without
> > any of these games.
> 
> [ Added the pstore folks ]
> 
> OK, so I did copy this from fs/pstore/ram_core.c as this does basically the
> same thing as pstore. And it looks like pstore should be updated too.

I think we're talking about persistent_ram_vmap()? That code predates my
maintainership, but I'm happy to update it to use better APIs.

> > Yes, the legacy versions of interfaces are all for IO memory, but we
> > do have things like vmap_page_range() which should JustWork(tm).
> > 
> > Yeah, you'll need to do something like
> > 
> >         unsigned long vmap_start, vmap_end;
> > 
> >         area = get_vm_area(size, VM_IOREMAP);
> >         if (!area)
> >                 return NULL;
> > 
> >         vmap_start = (unsigned long) area->addr;
> >         vmap_end = vmap_start + size;
> > 
> >         ret = vmap_page_range(vmap_start, vmap_end,
> >                 *start, prot_nx(PAGE_KERNEL));
> > 
> >         if (ret < 0) {
> >                 free_vm_area(area);
> >                 return NULL;
> >         }
> > 
> > and the above is *entirely* untested and maybe there's something wrong
> > there, but the concept should work, and when you don't do it a page at
> > a time, you not only don't need the kmalloc_array(), it should even do
> > things like be able to use large page mappings if the alignment and
> > size work out.
> > 
> > That said, the old code is *really* broken to begin with. I don't
> > understand why you want to vmap() a contiguous physical range. Either
> > it's real pages to begin with, and you can just use "page_address()"
> > to get a virtual address, it's *not* real pages, and doing
> > "pfn_to_page()" is actively wrong, because it creates a fake 'struct
> > page *' pointer that isn't valid.
> > 
> > Is this all just for some disgusting HIGHMEM use (in which case you
> > need the virtual mapping because of HIGHMEM)? Is there any reason to
> > support HIGHMEM in this area at all?
> > 
> > So I'm not sure why this code does all this horror in the first place.
> > Either it's all just confused code that just didn't know what it was
> > doing and just happened to work (very possible..) or there is
> > something odd going on.

pstore tries to work with either real RAM or with iomem things. What
is there now Currently Works Fine, but should this be using
vmap_page_range()?

-- 
Kees Cook
