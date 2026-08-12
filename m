Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089EB45C70B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553876; cv=none; b=L2oT9BqqpHkKlMUt4nEEicYo/b1gPOwAdNfxd827FiNgyjSr95uBao7B+CE/QXNY7nPAljyMsiNht87o1A0auS9E1Fcv+aXSANZwTihCZID6qBEVyBnPmtF3BC30qgpLxjA6rFG236wvJ3pGbyo9wYhSwURXTx/bijo05V07d9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553876; c=relaxed/simple;
	bh=/f6rHx1CGTNU7JGVtGJV0kDvGyd1L4uKEPb/eW21JZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+C8M3LTEP5JUJPMw57aIg4obz/eGLROulA5AyQO5M9Yn4cSmoXB9/4pqOIDUS5WZWdpK4YYBMiOBR6uJFgt7BQsnzFlCVgYhEHYvznaJUJ8W7l1IEqfzAdfzXhGVaKzseSx5ZYNanD0G9hccTX2xJhWGvJNJ5A5WiAZiV97MN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=he3ja1Ww; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="he3ja1Ww"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso938553f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786553873; x=1787158673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uqa5uijQCgQBJxboOxrjC5tiDajJgn4zS4IgZwEs4uQ=;
        b=he3ja1WwS7z+jBV7ZMStqM8zixMa1q4ZV553Pv9Pvvp/PA8vAjdVY3IcNFyPbMB/0G
         A7kdb8iHvYdYoOx8I0KrYjsdvAmxfP/9voRTz4HTWx8eCoELQIVBt3hbaKKdvapJir4k
         oFuRfTOFzbN6NPn0aNUSpw6GL5qMQidyepK4ZHFSAmM6bgJlEqJDMIKHXstB2q/fwEPO
         ausEEPgcf/wxEkR4wXplB9PiR48g6kaOXHB8wm643FC/GIgcLYacyHmE9zb3W8UIUWkH
         PjPQlPq6LlJT0ACsOZX61hZOh57sOwT3UeCW4LqQ9OoGTiOaeASgcotdwMG6tqDLxEF/
         L5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553873; x=1787158673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uqa5uijQCgQBJxboOxrjC5tiDajJgn4zS4IgZwEs4uQ=;
        b=tP4aS5piBnzXAHAJ7a3cF6vZ5r+SkfV8l4J5h+hRNIbmC68mO7vBD9DrkAvL4QF7n7
         VzJHSunoWu/tTZPu4gZMGUBIn5BZK8R5cclHd9s0n2xYxwGuwPJri8MethXYdfP+xNr5
         +hbMWAhprhYL59rgE670G4i0ISaYmrtVODpprIOqL8Kr5jQGu9o5U+Dc8CcHqHPCXNfL
         F9vONTFjQkP70adaYJDlX4wzyPoaUo5ZjvwIojevVnrlwb0pZ9dKPWAuqsp57wDFknnh
         ZfsYtlzboLVnTV/tvobOltcwIJ4DZJPkbnY/scY5xisMv43lHuryI7TX126WBM4X1cSQ
         mumQ==
X-Gm-Message-State: AOJu0YzjROCv915mqhgLUux5FauuwxmjjQ23NB8oJadmOXu0h48rqRdz
	s7GUFV83aBp8nuSI2S6xb6+PIr9Q7NUmTc4EHajmGHZI3HcHWQjaNOaeQeMT84BNzrPi+QRgLBL
	aVZt02w==
X-Gm-Gg: AR+sD13nySnTdBJEkQIj3LzSg53/XwxsZdEecmEF3MT90T8DETsdeBUp9ZqMlKm1GCK
	+r5yqiI+9M1JDfzrA1KP53PStgCTU3EjzGa8fbVx9ItF8gV5lHf+wnD9OGOzh0vQu9slvebUFne
	beui1U5vtRkr5Tay57mc/TliDAStr0rXSXGfWyjIY0u6ClJ7pZhBEWWe5ToO1Gun8JVYgzoOc+H
	9yAQLH3p2/aYJ5P6QeuS61pzLA+ELg3ShdR6sqVdNuPRcI4JupcRLxgPa1ffzle+p75jPAk3gcM
	tJl6SYAx35BMaWWZq/L9umLE4rfOBnT2HtQ0PTxNDVML8Ld7JRq1Z19T3XP40CBuK41OBvMKV/a
	/PV0u7/fwEoIxX+ZdJI4OkdKdJuP5TrcZ+1tqqdfnobISpcsx8yN+c7d4+kIAizEZEzjhcA1fk5
	YRLXH1x+G5vmFM35MqRvtN8IbCS6QeleupxjQLnHw2eukfJ945w2ocl+nroWap5vuZ0O3N2zZhK
	XKAYNsNL3OXE6e0eelaEwVTMr8dgcX6
X-Received: by 2002:a05:6000:25ca:b0:47f:d011:f644 with SMTP id ffacd0b85a97d-48152b40d40mr10039370f8f.4.1786553872737;
        Wed, 12 Aug 2026 09:57:52 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf7774sm9174021f8f.2.2026.08.12.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:57:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:57:49 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] tracing: Fix subbuf resize races in
 trace_pipe_raw readers
Message-ID: <anymDQcYJLuZE3Kd@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-6-vdonnefort@google.com>
 <20260812154706.486061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812154706.486061F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 03:47:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] A logic error in the retry loop of `tracing_buffers_read()` bypasses `ring_buffer_read_page()` on retry, leaking uninitialized or stale kernel memory to userspace.
> 
> Pre-existing issues:
> - [Critical] A race condition during subbuffer resize causes `cpu_buffer->free_page` to retain an old allocation size while `buffer->subbuf_order` reflects the new order, leading to a kernel buffer overflow.
> --
> 
> --- Patch [5]: [PATCH v4 5/9] tracing: Fix subbuf resize races in trace_pipe_raw readers ---
> commit c5c1a16fabb91c8f580283f14e5e76cc1ccb99b0
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing: Fix subbuf resize races in trace_pipe_raw readers
> 
> Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> uninitialized memory to userspace due to stale size values.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 94552a433228d..f62d6853ee5c0 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> 
> [ ... ]
> 
> > @@ -6988,22 +6988,34 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
> >   * Returns:
> >   *  The page allocated, or ERR_PTR
> >   */
> > -struct buffer_data_read_page *
> > -ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> > +struct buffer_data_read_page *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
> > +							  struct buffer_data_read_page *prev)
> >  {
> > +	struct buffer_data_read_page *bpage = prev;
> >  	struct ring_buffer_per_cpu *cpu_buffer;
> > -	struct buffer_data_read_page *bpage = NULL;
> >  	unsigned long flags;
> > +	unsigned int order;
> >  
> >  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> >  		return ERR_PTR(-ENODEV);
> >  
> > -	bpage = kzalloc_obj(*bpage);
> > -	if (!bpage)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	bpage->order = buffer->subbuf_order;
> > +	order = buffer->subbuf_order;
> >  	cpu_buffer = buffer->buffers[cpu];
> > +
> > +	if (!bpage) {
> > +		bpage = kzalloc_obj(*bpage);
> > +		if (!bpage)
> > +			return ERR_PTR(-ENOMEM);
> > +	} else {
> > +		if (bpage->order == order)
> > +			return bpage;
> > +
> > +		free_pages((unsigned long)bpage->data, bpage->order);
> > +		bpage->data = NULL;
> > +	}
> > +
> > +	bpage->order = order;
> > +
> >  	local_irq_save(flags);
> >  	arch_spin_lock(&cpu_buffer->lock);
> >  
> >  	if (cpu_buffer->free_page) {
> >  		bpage->data = cpu_buffer->free_page;
> >  		cpu_buffer->free_page = NULL;
> >  	}
> 
> [Severity: Critical]
> This is a pre-existing issue, but can this lead to an out-of-bounds write
> during a subbuffer resize?
> 
> In ring_buffer_alloc_read_page(), the newly read buffer->subbuf_order is
> assigned to a page stolen from cpu_buffer->free_page without checking if
> their size orders match.
> 
> If a concurrent call to ring_buffer_subbuf_order_set() updates
> buffer->subbuf_order locklessly, and this function is called before
> cpu_buffer->free_page is cleared, it will steal the old free_page but assign
> it the new size order.
> 
> Will this malformed page be swapped into the ring buffer, allowing writers
> to write past its actual bounds?
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 395238b2b715c..0409d20a168bb 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> 
> [ ... ]
> 
> > @@ -7080,8 +7080,8 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  {
> >  	struct ftrace_buffer_info *info = filp->private_data;
> >  	struct trace_iterator *iter = &info->iter;
> > -	void *trace_data;
> > -	int page_size;
> > +	void *trace_data, *prev_spare;
> > +	unsigned int spare_size;
> >  	ssize_t ret = 0;
> >  	ssize_t size;
> >  
> > @@ -7091,36 +7091,31 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
> >  		return -EBUSY;
> >  
> > -	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> > +again:
> > +	prev_spare = info->spare;
> > +	if (prev_spare) {
> > +		spare_size = ring_buffer_read_page_size(info->spare);
> >  
> > -	/* Make sure the spare matches the current sub buffer size */
> > -	if (info->spare) {
> > -		if (page_size != info->spare_size) {
> > -			ring_buffer_free_read_page(iter->array_buffer->buffer,
> > -						   info->spare_cpu, info->spare);
> > -			info->spare = NULL;
> > -		}
> > +		/* Do we have previous read data to read? */
> > +		if (info->read < spare_size)
> > +			goto read;
> >  	}
> 
> [Severity: High]
> Can the retry path bypass the actual read function and copy stale data
> to userspace?
> 
> When reading from an empty trace_pipe_raw file, ring_buffer_read_page()
> returns < 0. The code then blocks in wait_on_pipe(). Once woken up, it
> executes a goto again.
> 
> At the again label, info->read is 0 and info->spare is already allocated,
> so the condition info->read < spare_size will evaluate to true.
> 
> Does this cause execution to jump directly to the read label, bypassing
> ring_buffer_read_page(), and copy the uninitialized or stale info->spare
> page to userspace?

Arg, this one is real!

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812153311.2328812-1-vdonnefort@google.com?part=5

-- 
Vincent
