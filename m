Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F7435961;
	Wed,  2 Apr 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608902; cv=none; b=gG2QwdlFJdSe8QxHmbXqqrvftKciS+kNCt0Hu3hVQgCtSAS2PzVyMdO6p/xEwR/umez/UnLFJvfI1u5odY6B8bliW7yE5LxFPtq+NEjNdNQt+oaAhec12yVLRXkxsGtOH13G0ZhZcDE74vu4dZtnBkWfY0Cpf8f0L+kIY5ZR5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608902; c=relaxed/simple;
	bh=/93U3LeqzW0FdmDHTEmAKWihlzM26mU2o+UpHaAbRSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBUpYe5AwcsMs2Gp252ySGX4bCbopfSnj2NqjIsTFqit43onHJaPUyWpOT3mXrm3hv1QQ5cw4rv3dRRDcc1dMMsUpbn05T90CzTeyj0ZnMLRKGc9OqedJwqIyNDjQ9NGQE1cVHEZTnKe7naTgFFfPrshxV6U/wxwsG2ULOWhkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB66C4CEDD;
	Wed,  2 Apr 2025 15:48:20 +0000 (UTC)
Date: Wed, 2 Apr 2025 11:49:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Jann
 Horn <jannh@google.com>
Subject: Re: [PATCH v6 0/4] tracing: Clean up persistent ring buffer code
Message-ID: <20250402114923.132217c1@gandalf.local.home>
In-Reply-To: <c3e395d7-0c64-44d0-a0a7-57205b2ab712@efficios.com>
References: <20250402144903.993276623@goodmis.org>
	<c3e395d7-0c64-44d0-a0a7-57205b2ab712@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 10:56:51 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> So I've been loosely following this patch series, and I'm confused about
> one thing.
> 
> AFAIU one goal is to have the ftrace persistent ring buffer written to
> through a memory range returned by vmap_page_range(), and userspace maps
> the buffer with virtual mappings.

Note, this series does not have that goal. The memory mapped buffer via
vmap_page_range() is not going to ever be mapped to user space. The only
time the buffer will be mapped via vmap_page_range() (after this patch
series) is when it is allocated via memmap=... which is a major hack and
cannot be trusted to be used with memory mappings.

The persistent buffer when mapped with reserve_mem=... is no different than
the normal buffer being allocated via page_alloc() and page_address() to
get the virtual address. (Note this series still doesn't it make available
to be mapped to user space).

> 
> With respect to architectures with aliasing dcache, is the plan:
> 
> A) To make sure all persistent ring buffer mappings are aligned on
>     SHMLBA:
> 
> Quoting "Documentation/core-api/cachetlb.rst":
> 
>    Is your port susceptible to virtual aliasing in its D-cache?
>    Well, if your D-cache is virtually indexed, is larger in size than
>    PAGE_SIZE, and does not prevent multiple cache lines for the same
>    physical address from existing at once, you have this problem.
> 
>    If your D-cache has this problem, first define asm/shmparam.h SHMLBA
>    properly, it should essentially be the size of your virtually
>    addressed D-cache (or if the size is variable, the largest possible
>    size).  This setting will force the SYSv IPC layer to only allow user
>    processes to mmap shared memory at address which are a multiple of
>    this value.
> 
> or
> 
> B) to flush both the kernel and userspace mappings when a ring buffer
>     page is handed over from writer to reader ?
> 
> I've seen both approaches being discussed in the recent threads, with
> some consensus aiming towards (A), but then the code that follows takes
> approach (B).

The alignment done is not for cache issues but for memory mapping in general.
Having the persistent buffer memory be page aligned and all of it fit
nicely in pages is a requirement so that there's nothing truncated.

For the cache issue, (B) is used. Note, all mappings to user space is from
the page allocator. As reserve_mem has it allocated but just not free to
use.

> 
> AFAIU, it we are aiming for approach (A), then I'm missing where
> vmap_page_range() guarantees that the _kernel_ virtual mapping is
> SHMLBA aligned. AFAIU, only user mappings are aligned on SHMLBA.

The code in this patch series makes vmap_page_range() only happen when
memmap= is used to allocate the buffer. And then it sets the
TRACE_ARRAY_FL_MEMMAP flag which tells the the tracing code "Do not ever
memory map his buffer to user space".

> 
> And if we aiming towards approach (A), then the explicit flushing
> is not needed when handing over pages from writer to reader, but
> an SHMLBA alignment should be introduced.
> 
> Please let me know if I'm missing something,

I guess what you are missing is that the code no longer is aimed at having
vmap_page_range() ever get mapped to user space ;-)

-- Steve
