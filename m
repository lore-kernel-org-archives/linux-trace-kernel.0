Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1C3542F8;
	Fri, 14 Aug 2026 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723243; cv=none; b=To04R7EdwuaH4GeTkD9uFUDG2OwNGZXTXy2zRXrvTNH1tLB5+jPDoXAiyqYX7xb3kiwIrQnnEmDULYH6OPMDVpjwz3dO0XKo7KYBEjeud7Kmcpr7Tz0LDgPid+VzKnJgZfHj9uoh7XCTgtVbegNQieKyQrNg4vOpZKCjOysKGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723243; c=relaxed/simple;
	bh=5Tm0Vl3phe8vpuIn6f/Z/UqnpFBiD6SLgvJAY1xzuow=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ED+Nc5cTPQiLx1HnQtkCUQhOGYw7F9fXOTt4Iral+xW+FFMykR3OL3EPq/KmuQnTdcqZQsAv6yKBS4HowhQuW6mzzoMaTfbTno/YOY3mPj1Y+G/czkZ+zePAghuVNBe2PQbdBN6mTpgd8fmMK5nmFUO5etZ93BWT+9Xk1Ym+QlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drvycj6w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drvycj6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF8B1F000E9;
	Fri, 14 Aug 2026 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786723242;
	bh=1pIcx6Q99RlH8YI1SGJWQxglZoUf0npHwh2S/AR4m6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=drvycj6wXo8r7L02rBzEl4oOlkiNHWAjCO88LRdEg89sspgOde7vUG9aEoPOeOMD5
	 BC2QetWHOLPr9gjlNqv5qwMjDVbmZExgurfaDGpgDLwRt8X72Dl+2qQ/N4g59B0FIt
	 aHROzoAxHFJmuqipzp8RtpvEgeb6CbJcgI03VC4v6if7skINTe51T9hOiDO5naODDM
	 BUJYop+aoH2yOkReBy3FmLj8DfIBuJ4AFybai9LuDkZRIFXCxzs3da0htab2jOzLkE
	 1iawM8algXhEgxjuo+das/EICsLI8Qla7hKXJ6FwQnURmdxvOzLkFAfDJQkxBteaNl
	 WxI7rAyi6tvGQ==
Date: Sat, 15 Aug 2026 01:00:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com
Subject: Re: [PATCH] ring-buffer: Fix race between
 ring_buffer_subbuf_order_set() and readers
Message-Id: <20260815010038.a75cb3b411c7b846fb162c99@kernel.org>
In-Reply-To: <an8r9yMinscYpmjA@google.com>
References: <178663776361.475864.7685868697103378735.stgit@devnote2>
	<178663777320.475864.4716637934003507750.stgit@devnote2>
	<20260814104208.28f47749@gandalf.local.home>
	<an8r9yMinscYpmjA@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 15:53:43 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Fri, Aug 14, 2026 at 10:42:08AM -0400, Steven Rostedt wrote:
> > On Fri, 14 Aug 2026 01:16:13 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > When ring_buffer_subbuf_order_set() updates buffer->subbuf_order, it
> > > previously modified buffer->subbuf_order before clearing the cached
> > > per-CPU free_page entries. Furthermore, clearing cpu_buffer->free_page
> > > was done under cpu_buffer->reader_lock, whereas
> > > ring_buffer_alloc_read_page() protects cpu_buffer->free_page using
> > > arch_spin_lock(&cpu_buffer->lock).
> > > 
> > > Because ring_buffer_alloc_read_page(), ring_buffer_free_read_page(),
> > > and ring_buffer_read_page() checked buffer->subbuf_order locklessly
> > > before accessing reader resources, a TOCTOU race allowed a concurrent
> > > reader to obtain, cache, or swap a page allocated under an outdated order
> > > while tagging bpage->order with the new order. This allowed undersized
> > > pages to be swapped into the ring buffer, leading to heap buffer overflows,
> > > or caused free_pages() to be called with an invalid order.
> > > 
> > > Fix this by:
> > > 1. Flushing and freeing all per-CPU cached free_page entries under
> > >    arch_spin_lock(&cpu_buffer->lock) using old_order before modifying
> > >    buffer->subbuf_order.
> > > 2. Protecting bpage->order assignment under
> > >    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_alloc_read_page().
> > > 3. Moving the buffer->subbuf_order validation inside
> > >    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_free_read_page().
> > > 4. Re-validating buffer->subbuf_order inside reader_lock in
> > >    ring_buffer_read_page().
> > > 5. Protecting cpu_buffer->free_page extraction with
> > >    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_subbuf_order_set().
> > > 
> > > Fixes: 2808e31ec12e ("ring-buffer: Add interface for configuring trace sub buffer size")
> > > Assisted-by: Antigravity:gemini-3.6-flash
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > 
> > 
> > Please rebase on top of ring-buffer/for-next, as I added Vincent's patches to that.
> > 
> > >  kernel/trace/ring_buffer.c |   35 +++++++++++++++++++++++++++++------
> > >  1 file changed, 29 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 2667992f0aa2..6d180689ad59 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -6957,11 +6957,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> > >  	if (!bpage)
> > >  		return ERR_PTR(-ENOMEM);
> > >  
> > > -	bpage->order = buffer->subbuf_order;
> > >  	cpu_buffer = buffer->buffers[cpu];
> > >  	local_irq_save(flags);
> > >  	arch_spin_lock(&cpu_buffer->lock);
> > >  
> > > +	bpage->order = buffer->subbuf_order;
> > 
> > This is still needed.
> 
> I am not sure, the lock is per-cpu_buffer but subbuf_order. is global to
> trace_buffer?

Yeah, we don't need this.
I got new ring_buffer_read_page() ensures the data_page->order ==
cpu_buffer->reader_page->order. This is a bit tricky but it allows us to
asynchronously allocate reader_page in different order outside of locking.
(and if free_page exists, it is copied with its order, so it is safe.)

> 
> > 
> > >  	if (cpu_buffer->free_page) {
> > >  		bpage->data = cpu_buffer->free_page;
> > >  		cpu_buffer->free_page = NULL;
> > > @@ -7010,13 +7010,13 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
> > >  	 * is different from the subbuffer order of the buffer -
> > >  	 * we can't reuse it
> > >  	 */
> > > -	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
> > > +	if (page_ref_count(page) > 1)
> > >  		goto out;
> > >  
> > >  	local_irq_save(flags);
> > >  	arch_spin_lock(&cpu_buffer->lock);
> > >  
> > > -	if (!cpu_buffer->free_page) {
> > > +	if (data_page->order == buffer->subbuf_order && !cpu_buffer->free_page) {
> > 
> > Swap the order please. It has to check both to continue and if one fails it
> > will not continue. Checking for cpu_buffer->free_page to be NULL first is
> > the quicker check. And also the more likely one to fail.
> > 
> > >  		cpu_buffer->free_page = dpage;
> > >  		dpage = NULL;
> > >  	}
> > > @@ -7094,15 +7094,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> > >  	if (!data_page || !data_page->data)
> > >  		return -1;
> > >  
> > > -	if (data_page->order != buffer->subbuf_order)
> > > -		return -1;
> > > -
> > >  	dpage = data_page->data;
> > >  	if (!dpage)
> > >  		return -1;
> > >  
> > >  	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
> > >  
> > > +	if (data_page->order != buffer->subbuf_order)
> > > +		return -1;
> > > +
> 
> I have modified this as part of 
> 
> tracing: Fix subbuf resize races with trace_pipe_raw readers 

Got it. Yours changes the data structure. Mine is for older kernels
as a minimal change. 

> 
> > >  	reader = rb_get_reader_page(cpu_buffer);
> > >  	if (!reader)
> > >  		return -1;
> > > @@ -7350,6 +7350,27 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> > >  	/* Make sure all commits have finished */
> > >  	synchronize_rcu();
> > >  
> > > +	/* Flush any cached free_page allocated with old_order */
> > > +	for_each_buffer_cpu(buffer, cpu) {
> > > +		struct buffer_data_page *old_free;
> > > +		unsigned long flags;
> > > +
> > > +		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > > +			continue;
> > > +
> > > +		cpu_buffer = buffer->buffers[cpu];
> > > +
> > > +		local_irq_save(flags);
> > > +		arch_spin_lock(&cpu_buffer->lock);
> > > +		old_free = cpu_buffer->free_page;
> > > +		cpu_buffer->free_page = NULL;
> > > +		arch_spin_unlock(&cpu_buffer->lock);
> > > +		local_irq_restore(flags);
> > > +
> > > +		if (old_free)
> > > +			free_pages((unsigned long)old_free, old_order);
> > > +	}
> > 
> > Honestly, this should be a separate patch. The first part of this patch is
> > data races with adding and freeing, but this is about changes to the size.

Since Vincent's patch[1] handles data page pointer with its order, we don't
this part anymore.

[1] ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page

So I confirmed Vincent's patches with Fixed tag are fixing the racing
problem in the different way.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
