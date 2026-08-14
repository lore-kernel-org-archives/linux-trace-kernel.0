Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D75436BE6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719233; cv=none; b=ddd+WCzspwncQuiitH2/kpczZYTYuUxARK76HI0GwiWv1bgE79POsVpdLwx7GumqTF8c0iolTN9ILqwauJwOnaqNVMr1ysI2QjacjJtdBIemUsPV6as34N/SzkTBfhgOwRuSf5fju8Ms18d+GI1/16TMdexyL2iuIj2vLi5dRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719233; c=relaxed/simple;
	bh=mzk8aKbdFuG5Vu68J+c+zfEBpGwzivGgHtRkC0dkzrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYxdW/cVPVz/QcX5Z3ASqKvcfQwmLXLGJXU2VH+PuRpOqEYxG23W3WPSAJXwZeFcW5eoZF+MmsEyioJbGsptz4Ty95TMNSeghIoOg9tj93cFmLYdaebRFbS0FsB9+LFSy7RiXA3aAWc++JA/EAFFipCoFdvZ0qCHzBmVcc3SfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEamMCKW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEamMCKW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49802c418b5so11226715e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786719228; x=1787324028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQImDO1MNrue3/f5xyKVW9ULG6rmGDlRWjNqJzFU5E8=;
        b=YEamMCKWRo8YPLoYLPBN/3wNdz1XdF0dThkQm4+rtt8AqFZbhS2fSKxklE19xCEAKa
         VjB8WVvG7DhGzSiXaObYr+GkRBQyiah0zrXW8UxxFeDZdG1WpNT331OX4Yptf4RXN6Y2
         wfj31m2UG7G8D1sN+DhTllyyhOanR4rELEkXcEZM2pdsnw5bvyeVfeuKQ6ceWwL9nfU3
         wjdZaUs4Tm1fbfBATDUHA7NPDVLgyNeladI3Knjfc4mF+Fy+s6QON/A0cG4oQEALojkQ
         qzlc82tpq10xD+h5qOAU7gofZjEwWE335MSuDJ/+oOp1iBRL1itih5GAb6l8R4zqwm3w
         WQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719228; x=1787324028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQImDO1MNrue3/f5xyKVW9ULG6rmGDlRWjNqJzFU5E8=;
        b=XdqzuxMPYhRKvHEQb04MGb04Jcbk1VBkr9Q9nJHQ3bWssVQcYCVLfRLgXNLvyc2ACN
         ywlVX1yV0hRAdSlAno3rzApHkCxMhsAA+k9MXv4VZWbds+7QOwvvjE38rOvDtk315nsg
         /Bde+tP2ocFOevNEgo6uu4Il4lCJCEwJJJYoSa56c2n8P8cc+1TZfUUhfKq9IxNUC0tu
         eqTGpOpiJ+xzHBgxUhc4tjXHR2vZXjvSR+tn1eoHIrn6Hm+M6H5w9Jc/5JKebIXYFBiP
         +ncAnYBulMhnRX5Vjf8KKc6TzbhyRGX0M8PghjQ1DYa/x6vEDV/86YWDg2NPGKpSYlbq
         3jzg==
X-Forwarded-Encrypted: i=1; AHgh+Rry+7CHRUAkDWCBcKNgp8qZKzUcqGDLElGKXhXqNMQS7PnwiT7ILDnJvUiSqa+wNqo6P8HYfC+TPzOC0YGmiVPl9yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/ZwRp+JWsMiiKdz0nssnBlKEsGjDe8pzMzETDcoT9Pgco8pE
	qOB4wcHugBiopgI9PIT4geEKlkwTCzn707auHJ6Xy0OXvD5Tgho64vjSm0XdyT/V5Q==
X-Gm-Gg: AR+sD11jsbIJYJGteNps7p3l+reosZOUEmKn3EpQHCBFF8Xwse0v0+gsDGiCjpopqcs
	QNr4hNDfLqcBUaSOqbicu7di41A9FSkUvF/thTSkOPx/r8o9Dc+xfrxcTi3yQpZsAakKEJ3U3FX
	8KQeOTM29ZG4kPmFnLakEr0u3Bs/H1dzgnXazY600ulv+UAV+xQUH6KwV1ZiTbIHe4xkwQlO3Op
	qcm5FqPx2tO9lOSCO3NJtbQSI2FDt0S3G0O+p4KWnj4mzYUskAArIDwYp+8FgtAPfwBQqbxL2C3
	vR6r4TxpugszObnzRS6aEHJPQ00eUK9IwV8URGOcztGuKDJjI036unye7VZnrhkBPO61x8fnYWQ
	ZrQsGx3mAgKYnp2TC1QHyBPJ63fp5tfpn+2RjR0QbdBl0lzwMSyMCKqjy8NVwCJva5CL+Lba79/
	wtTWgCDDD9x2RGby9XjSAo+KhZ0tfNO2+Ka3aeOd4pAiBP/G7v1WCFBOuoHy8LkaD0jEOwzQR+q
	M5Q7AS7W3g0jZg0uaSj/F4muu9nGsWr
X-Received: by 2002:a05:600c:19d1:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-499879ae4f4mr84287635e9.15.1786719227894;
        Fri, 14 Aug 2026 07:53:47 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d33asm60194785e9.10.2026.08.14.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:53:47 -0700 (PDT)
Date: Fri, 14 Aug 2026 15:53:43 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH] ring-buffer: Fix race between
 ring_buffer_subbuf_order_set() and readers
Message-ID: <an8r9yMinscYpmjA@google.com>
References: <178663776361.475864.7685868697103378735.stgit@devnote2>
 <178663777320.475864.4716637934003507750.stgit@devnote2>
 <20260814104208.28f47749@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814104208.28f47749@gandalf.local.home>

On Fri, Aug 14, 2026 at 10:42:08AM -0400, Steven Rostedt wrote:
> On Fri, 14 Aug 2026 01:16:13 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > When ring_buffer_subbuf_order_set() updates buffer->subbuf_order, it
> > previously modified buffer->subbuf_order before clearing the cached
> > per-CPU free_page entries. Furthermore, clearing cpu_buffer->free_page
> > was done under cpu_buffer->reader_lock, whereas
> > ring_buffer_alloc_read_page() protects cpu_buffer->free_page using
> > arch_spin_lock(&cpu_buffer->lock).
> > 
> > Because ring_buffer_alloc_read_page(), ring_buffer_free_read_page(),
> > and ring_buffer_read_page() checked buffer->subbuf_order locklessly
> > before accessing reader resources, a TOCTOU race allowed a concurrent
> > reader to obtain, cache, or swap a page allocated under an outdated order
> > while tagging bpage->order with the new order. This allowed undersized
> > pages to be swapped into the ring buffer, leading to heap buffer overflows,
> > or caused free_pages() to be called with an invalid order.
> > 
> > Fix this by:
> > 1. Flushing and freeing all per-CPU cached free_page entries under
> >    arch_spin_lock(&cpu_buffer->lock) using old_order before modifying
> >    buffer->subbuf_order.
> > 2. Protecting bpage->order assignment under
> >    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_alloc_read_page().
> > 3. Moving the buffer->subbuf_order validation inside
> >    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_free_read_page().
> > 4. Re-validating buffer->subbuf_order inside reader_lock in
> >    ring_buffer_read_page().
> > 5. Protecting cpu_buffer->free_page extraction with
> >    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_subbuf_order_set().
> > 
> > Fixes: 2808e31ec12e ("ring-buffer: Add interface for configuring trace sub buffer size")
> > Assisted-by: Antigravity:gemini-3.6-flash
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> 
> 
> Please rebase on top of ring-buffer/for-next, as I added Vincent's patches to that.
> 
> >  kernel/trace/ring_buffer.c |   35 +++++++++++++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 2667992f0aa2..6d180689ad59 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -6957,11 +6957,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> >  	if (!bpage)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	bpage->order = buffer->subbuf_order;
> >  	cpu_buffer = buffer->buffers[cpu];
> >  	local_irq_save(flags);
> >  	arch_spin_lock(&cpu_buffer->lock);
> >  
> > +	bpage->order = buffer->subbuf_order;
> 
> This is still needed.

I am not sure, the lock is per-cpu_buffer but subbuf_order. is global to
trace_buffer?

> 
> >  	if (cpu_buffer->free_page) {
> >  		bpage->data = cpu_buffer->free_page;
> >  		cpu_buffer->free_page = NULL;
> > @@ -7010,13 +7010,13 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
> >  	 * is different from the subbuffer order of the buffer -
> >  	 * we can't reuse it
> >  	 */
> > -	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
> > +	if (page_ref_count(page) > 1)
> >  		goto out;
> >  
> >  	local_irq_save(flags);
> >  	arch_spin_lock(&cpu_buffer->lock);
> >  
> > -	if (!cpu_buffer->free_page) {
> > +	if (data_page->order == buffer->subbuf_order && !cpu_buffer->free_page) {
> 
> Swap the order please. It has to check both to continue and if one fails it
> will not continue. Checking for cpu_buffer->free_page to be NULL first is
> the quicker check. And also the more likely one to fail.
> 
> >  		cpu_buffer->free_page = dpage;
> >  		dpage = NULL;
> >  	}
> > @@ -7094,15 +7094,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  	if (!data_page || !data_page->data)
> >  		return -1;
> >  
> > -	if (data_page->order != buffer->subbuf_order)
> > -		return -1;
> > -
> >  	dpage = data_page->data;
> >  	if (!dpage)
> >  		return -1;
> >  
> >  	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
> >  
> > +	if (data_page->order != buffer->subbuf_order)
> > +		return -1;
> > +

I have modified this as part of 

tracing: Fix subbuf resize races with trace_pipe_raw readers 

> >  	reader = rb_get_reader_page(cpu_buffer);
> >  	if (!reader)
> >  		return -1;
> > @@ -7350,6 +7350,27 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  	/* Make sure all commits have finished */
> >  	synchronize_rcu();
> >  
> > +	/* Flush any cached free_page allocated with old_order */
> > +	for_each_buffer_cpu(buffer, cpu) {
> > +		struct buffer_data_page *old_free;
> > +		unsigned long flags;
> > +
> > +		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +			continue;
> > +
> > +		cpu_buffer = buffer->buffers[cpu];
> > +
> > +		local_irq_save(flags);
> > +		arch_spin_lock(&cpu_buffer->lock);
> > +		old_free = cpu_buffer->free_page;
> > +		cpu_buffer->free_page = NULL;
> > +		arch_spin_unlock(&cpu_buffer->lock);
> > +		local_irq_restore(flags);
> > +
> > +		if (old_free)
> > +			free_pages((unsigned long)old_free, old_order);
> > +	}
> 
> Honestly, this should be a separate patch. The first part of this patch is
> data races with adding and freeing, but this is about changes to the size.
> 
> > +
> >  	buffer->subbuf_order = order;
> >  	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
> >  
> > @@ -7431,8 +7452,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
> >  		cpu_buffer->nr_pages_to_update = 0;
> >  
> > +		arch_spin_lock(&cpu_buffer->lock);
> >  		old_free_data_page = cpu_buffer->free_page;
> >  		cpu_buffer->free_page = NULL;
> > +		arch_spin_unlock(&cpu_buffer->lock);
> 
> This is already fixed by Vincent (and I would have asked this to be a
> separate patch too if it hadn't).
> 
> -- Steve
> 
> >  
> >  		rb_head_page_activate(cpu_buffer);
> >  
> 

-- 
Vincent
