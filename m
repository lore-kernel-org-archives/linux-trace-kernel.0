Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335532110;
	Tue,  1 Apr 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467358; cv=none; b=Wm/8Vp6NGAvocQBdNSbLbcHCgOjaIFSxotX/QDss1PBvhPjrvj5qLhPBhVT2QL0SVTVyGrh8hCKMTRjYssM85a5qGTGoLriP1cVHk9siuH+XyAdETMdIbQJEMw18cT/c7ny5NdyUmuOqwwDt++JCNeXAQa+pn1YKnjb/TOAHnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467358; c=relaxed/simple;
	bh=bTAjgggG2W/wOFkhPrIxf0x4Kcgbwu1NN49CiLAPGbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAYMcwtmjs61zKtUqYn9cYSbEawrXoyejLkAXgNseRn3PTfTI3ExS76ERf6ljeHI1mfjzDEOIBqgMp0bsrNUkHRj71xXV3NPJbfPtvpDdAk9sAnkb+VJjCdIjI1whl4QVTPEViwAyNBWjfgH/mKbKzDyuGRxNzLxrvo5rV82BG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14512C4CEE3;
	Tue,  1 Apr 2025 00:29:15 +0000 (UTC)
Date: Mon, 31 Mar 2025 20:30:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250331203014.5108200c@gandalf.local.home>
In-Reply-To: <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
	<20250331165801.715aba48@gandalf.local.home>
	<CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
	<20250331194251.02a4c238@gandalf.local.home>
	<CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 17:11:46 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I thought you did that already for the user mappings - don't use you
> remap_pfn_range()?

No, that's not what is done. The normal buffer is split among several
sub-buffers (usually one page in size each, but can also be a power of two
pages), and those pages are allocated via alloc_page() and are not
contiguous. Which is why the mapping to user space creates an array of
struct page pointers and then calls vm_insert_pages().

For the contigous physical memory, then yeah, we can simply use
vm_iomap_memory().


> So if you don't treat this as some kind of 'page' or 'folio' thing,
> then the proper function is actually flush_cache_range().
> 
> I actually suspect that if you treat things just as an arbitrary range
> of memory, it might simplify things in general.

Ah, yeah. That's the function I was looking for.


> Of course, I would expect the same to be true of the page/folio cases,
> so I don't think using flush_cache_range() should be any worse, but I
> *could* imagine that it's bad in a different way ;)

At least we can say we covered those other archs, and if a bug is reported,
then all that would need to be fixed is the flush_cache_range()
implementation ;-)

-- Steve
