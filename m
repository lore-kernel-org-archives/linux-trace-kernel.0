Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E81EDA12;
	Thu,  6 Feb 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855424; cv=none; b=trF864BXse8IOGc3iF3co255xaUe6h8cP+PtCFl4h+1dWYGU1Xlf3mN89d2iFoX+42j2eeca4JTmQ8xPycLslQxiM9DzV4j/5+cmnqJAdLWGMlE+KBk25NKN82O5ytm7u3lAYL2CoAGkr3Nedagud90Ln9Jg7TVIlySffBUk0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855424; c=relaxed/simple;
	bh=nUu17B7s0z1EoNOLJJ+yCLRICxXjZP3DnG1WBW5SukA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTGfCXYUkqj/9OeM/gtnjIewiqCC4rJ/p4tB5EbnR3dYj4m0mVxeNuMKQ2xJQ2zHGHQzfJDbRgD5Y2lrV/lEn7OtzcmiZZwGHiDCe0w11T04OrM1iEablbTFIRgG5hbHIVejrsJayGwNonjXhei2gCgj4r0MUCEdriuYPn84CHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BEFC4CEDD;
	Thu,  6 Feb 2025 15:23:43 +0000 (UTC)
Date: Thu, 6 Feb 2025 10:24:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] tracing: Have persistent trace instances save KASLR
 offset
Message-ID: <20250206102425.2d1f71ad@gandalf.local.home>
In-Reply-To: <20250206142232.5a10545649210f3b3ba172c2@kernel.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.596907199@goodmis.org>
	<20250206142232.5a10545649210f3b3ba172c2@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:22:32 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 05 Feb 2025 17:50:35 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > There's no reason to save the KASLR offset for the ring buffer itself.
> > That is used by the tracer. Now that the tracer has a way to save data in
> > the persistent memory of the ring buffer, have the tracing infrastructure
> > take care of the saving of the KASLR offset.
> >   
> 
> Looks good to me. But note that the scratchpad size may not enough for
> module table later, because 1 module requires at least the name[]
> (64byte - sizeof(ulong)) and the base address (ulong). This means
> 1 entry consumes 64byte. Thus there can be only 63 entries + meta
> data in 4K page. My ubuntu loads 189(!) modules;
> 
> $ lsmod | wc -l
> 190
> 
> so we want 255 entries, which requires 16KB.

So, I was thinking of modifying the allocation of the persistent ring
buffer, which currently is

#define ring_buffer_alloc_range(size, flags, order, start, range_size)

[ it's a macro to add lockdep key information in it ]

But I should change it to include a scratch size, and allow the tracing
system to define how much of the range it should allocate for scratch.

Then we could do:

		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
						      tr->range_addr_start,
						      tr->range_addr_size,
						      struct_size(tscratch, entries, 128));

Which would make sure that the scratch size contains enough memory to hold
128 modules.

-- Steve
