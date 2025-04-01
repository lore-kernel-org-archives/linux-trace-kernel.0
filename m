Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC1CA4B;
	Tue,  1 Apr 2025 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501400; cv=none; b=OfpE04wPp2PonQ46zDIuErRxoFSTQ0zDOfepb05TzKHF2TKuND04/574UkUNgWz6h2OPMe68Y+6kkUVw6xjcEhXZeig68PU+yUO7q8dTysVHEaGVzLLdtsQM0+8bmbRzjzijghOKjHdT4fAi+7t2GJxOlcDJdjJ5+3EH6qsXWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501400; c=relaxed/simple;
	bh=upU1NVbqR47hE6/uqphnMe1vr28PRG9Jgkjfi8SzQKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZa7JmlRUyrEEt9fX4J2x8rKY1LFmoBgrzHNyi5MNU+HdVsYawuv7MUZIAJClfPogPgVwo9u0HeWqN6b3utCNleRXKPMmzI0fliG5Jn+I1u2nrXmHj2QYDv+TlsOqkcm9/8zB/mXEZ64XKAAlh1DozU3+Xo4LG+O6sOShNW5Ti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvX/riQz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvX/riQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF7BC4CEE4;
	Tue,  1 Apr 2025 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501399;
	bh=upU1NVbqR47hE6/uqphnMe1vr28PRG9Jgkjfi8SzQKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvX/riQzga/HcyqM+Uz59gE06oEgCvByzwXNWdOH1tiFZIthvAXnjFQTa32/qOvoT
	 bsvaF6UYplswEj3FM0ipkEfRserFgW8ORuVaSx2VCfU88tFY+TTsF+FaV8MYA+7e+y
	 MK0xwxd8DM9oHPlzhjSttsNKoNVrUpiD6Kso2ZN5ttO4hUivVFjidgXRoYmMr2+KvJ
	 yUW6D0OzcpJlqKopwVe3jLyJ1zs+ROMwKUukhyAlMz88XXjdt5rVNckrrNTouLPsRI
	 bJ095eHLZ2ugqlFPZf8co4B/J79nwrIh8B/zxt4BttM5lU6rK2agb+Q6l0fgZao8Zl
	 M7cam5wgks43A==
Date: Tue, 1 Apr 2025 12:56:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
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
Message-ID: <Z-u4Tzz9J8hSk6G7@kernel.org>
References: <20250331143426.947281958@goodmis.org>
 <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home>
 <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home>
 <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>

On Mon, Mar 31, 2025 at 02:42:38PM -0700, Linus Torvalds wrote:
> On Mon, 31 Mar 2025 at 13:57, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Note, this only works with RAM.
> 
> That's not the issue, actually.
> 
> The issue is whether there's a 'struct page'. And "being RAM" does not
> mean that a struct page exists.
> 
> For example, using "mem=" on the kernel command line will literally
> limit the amount of RAM the kernel will use, and in doing so will
> limit the page allocations too.

And using memmap=m$n on x86 creates a hole in System RAM that does not have
neither struct page nor kernel mappings and it is never considered RAM
anywhere in mm.
 
> IOW, all of these kernel command line things are *subtle*.
> 
> Don't mis-use them by then making assumptions about how they work
> today (or how they will work tomorrow).

I'd say it's better not to use them at all. They cause weirdness in memory
layout and also they are inconsistent in how architectures implement them.
 
> > Mike can correct me if I'm wrong, but the memory that was stolen was actual
> > memory returned by the system (E820 in x86). It reserves the memory before
> > the memory allocation reserves this memory. So what reserve_mem returns is
> > valid memory that can be used by memory allocator, but is currently just
> > "reserved" which means it wants to prevent the allocator from using it.
> 
> That may indeed be true of reserve_mem.

The reserve_mem behaves like any other early allocation, it has proper
struct pages (PG_Reserved) and it is mapped in the direct map so
phys_to_virt() will work on it.

As for mapping it to userspace, vm_iomap_memory() seems the best API to
use. It has all the alignment checks and will refuse to map ranges that are
not properly aligned and it will use vma information to create the right
mappings.
 
>                Linus

-- 
Sincerely yours,
Mike.
