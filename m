Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678B18A6AD;
	Thu,  6 Feb 2025 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819355; cv=none; b=RxD28TNU2LFO2KykIfulUA+s1Lji/cwPp98H28J5fixqBX22VF3ZnQhkbnP2Hp7FbdJQyg1Q3Cyim7roqG194Mz6iQ0/HLqQAeScAeKckqQ4wi2NZv3PijYVqgiCky7zcyWd3QtfzofaX1XScy2NJx6Tb/2WG/HomCuvxhFxV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819355; c=relaxed/simple;
	bh=fXp5l+d6hVf0eMnKwpmt1GpjidcY0mNOjDjrEJ7fpTE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ePl1UThz07IaoJ672fsWIUZD40tfMxutVQsUfpFamGfKxEI8DPl+WFefIw7OnAgFlepGTue3p1Le/90lN7aRNlemA/W7mTeG1neQ0/TUbI/tqlBdpvdQOvCj+h/47ZPG3UtU18z/3wZOwUSkEhGa7jN4eFxZ6DZqkAIBAD2u/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9lkfBfu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9lkfBfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D70C4CEDD;
	Thu,  6 Feb 2025 05:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738819355;
	bh=fXp5l+d6hVf0eMnKwpmt1GpjidcY0mNOjDjrEJ7fpTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P9lkfBfu4+5CfywJRfN/7pTo6f9iV51Yk5WNCcAunUDxT1g9HUadD6kF1xU6zPOGr
	 3AFjbOFn1/LVQ4KmCAMLyCSofIvHbwWaXRmjkYdN/dAojeI2MDef7JXKJ+zrta8+k6
	 3BZjQ761SyJvywNLToOMwK1SVqgtDtLhWcM7jQMZD9UcWkf8+sdLyxJ0XfRUd37q+W
	 4LrjXYyM3XloSDfX71UM8GhbVIQl000umMwiZvr5feffLASFieYOrh2XuSLrUiHvL9
	 2fCsmoz3gjU8xRUeYQKqDogLbWTK52eWT3mbRkjWYbaV/dDOWz6+uAUZojOt1wDVm5
	 QCMwKB7PU863A==
Date: Thu, 6 Feb 2025 14:22:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] tracing: Have persistent trace instances save KASLR
 offset
Message-Id: <20250206142232.5a10545649210f3b3ba172c2@kernel.org>
In-Reply-To: <20250205225103.596907199@goodmis.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.596907199@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Feb 2025 17:50:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There's no reason to save the KASLR offset for the ring buffer itself.
> That is used by the tracer. Now that the tracer has a way to save data in
> the persistent memory of the ring buffer, have the tracing infrastructure
> take care of the saving of the KASLR offset.
> 

Looks good to me. But note that the scratchpad size may not enough for
module table later, because 1 module requires at least the name[]
(64byte - sizeof(ulong)) and the base address (ulong). This means
1 entry consumes 64byte. Thus there can be only 63 entries + meta
data in 4K page. My ubuntu loads 189(!) modules;

$ lsmod | wc -l
190

so we want 255 entries, which requires 16KB.

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/ring_buffer.h |  1 -
>  kernel/trace/ring_buffer.c  | 47 -------------------------------------
>  kernel/trace/trace.c        | 38 ++++++++++++++++++++++++++----
>  kernel/trace/trace.h        |  6 +++--
>  4 files changed, 38 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index b95f940fd07a..d6d9c94e8d8a 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -94,7 +94,6 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
>  					       unsigned long range_size,
>  					       struct lock_class_key *key);
>  
> -bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr);
>  void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
>  
>  /*
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5a81ff785665..a42406287281 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -55,7 +55,6 @@ struct ring_buffer_meta {
>  };
>  
>  struct ring_buffer_cpu_meta {
> -	unsigned long	kaslr_addr;
>  	unsigned long	first_buffer;
>  	unsigned long	head_buffer;
>  	unsigned long	commit_buffer;
> @@ -557,8 +556,6 @@ struct trace_buffer {
>  
>  	struct ring_buffer_meta		*meta;
>  
> -	unsigned long			kaslr_addr;
> -
>  	unsigned int			subbuf_size;
>  	unsigned int			subbuf_order;
>  	unsigned int			max_data_size;
> @@ -1931,15 +1928,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	}
>  }
>  
> -static void rb_meta_init_text_addr(struct ring_buffer_cpu_meta *meta)
> -{
> -#ifdef CONFIG_RANDOMIZE_BASE
> -	meta->kaslr_addr = kaslr_offset();
> -#else
> -	meta->kaslr_addr = 0;
> -#endif
> -}
> -
>  static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
>  {
>  	struct ring_buffer_cpu_meta *meta;
> @@ -1967,7 +1955,6 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
>  			meta->first_buffer += delta;
>  			meta->head_buffer += delta;
>  			meta->commit_buffer += delta;
> -			buffer->kaslr_addr = meta->kaslr_addr;
>  			continue;
>  		}
>  
> @@ -1984,7 +1971,6 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
>  		subbuf = rb_subbufs_from_meta(meta);
>  
>  		meta->first_buffer = (unsigned long)subbuf;
> -		rb_meta_init_text_addr(meta);
>  
>  		/*
>  		 * The buffers[] array holds the order of the sub-buffers
> @@ -2514,27 +2500,6 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
>  	return alloc_buffer(size, flags, order, start, start + range_size, key);
>  }
>  
> -/**
> - * ring_buffer_last_boot_delta - return the delta offset from last boot
> - * @buffer: The buffer to return the delta from
> - * @text: Return text delta
> - * @data: Return data delta
> - *
> - * Returns: The true if the delta is non zero
> - */
> -bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr)
> -{
> -	if (!buffer)
> -		return false;
> -
> -	if (!buffer->kaslr_addr)
> -		return false;
> -
> -	*kaslr_addr = buffer->kaslr_addr;
> -
> -	return true;
> -}
> -
>  void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size)
>  {
>  	if (!buffer || !buffer->meta)
> @@ -6098,7 +6063,6 @@ static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
>  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
> -	struct ring_buffer_cpu_meta *meta;
>  
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return;
> @@ -6117,11 +6081,6 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
>  	atomic_dec(&cpu_buffer->record_disabled);
>  	atomic_dec(&cpu_buffer->resize_disabled);
>  
> -	/* Make sure persistent meta now uses this buffer's addresses */
> -	meta = rb_range_meta(buffer, 0, cpu_buffer->cpu);
> -	if (meta)
> -		rb_meta_init_text_addr(meta);
> -
>  	mutex_unlock(&buffer->mutex);
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
> @@ -6136,7 +6095,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
>  void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
> -	struct ring_buffer_cpu_meta *meta;
>  	int cpu;
>  
>  	/* prevent another thread from changing buffer sizes */
> @@ -6164,11 +6122,6 @@ void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
>  
>  		reset_disabled_cpu_buffer(cpu_buffer);
>  
> -		/* Make sure persistent meta now uses this buffer's addresses */
> -		meta = rb_range_meta(buffer, 0, cpu_buffer->cpu);
> -		if (meta)
> -			rb_meta_init_text_addr(meta);
> -
>  		atomic_dec(&cpu_buffer->record_disabled);
>  		atomic_sub(RESET_BIT, &cpu_buffer->resize_disabled);
>  	}
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a9e8eaf1d47e..cb9f8e6878a0 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5994,8 +5994,14 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
>  	return ret;
>  }
>  
> +struct trace_scratch {
> +	unsigned long		kaslr_addr;
> +};
> +
>  static void update_last_data(struct trace_array *tr)
>  {
> +	struct trace_scratch *tscratch;
> +
>  	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
>  		return;
>  
> @@ -6010,6 +6016,17 @@ static void update_last_data(struct trace_array *tr)
>  	/* Using current data now */
>  	tr->text_delta = 0;
>  
> +	if (!tr->scratch)
> +		return;
> +
> +	tscratch = tr->scratch;
> +
> +	/* Set the persistent ring buffer meta data to this address */
> +#ifdef CONFIG_RANDOMIZE_BASE
> +	tscratch->kaslr_addr = kaslr_offset();
> +#else
> +	tscratch->kaslr_addr = 0;
> +#endif
>  	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
>  }
>  
> @@ -6823,6 +6840,7 @@ static ssize_t
>  tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
>  {
>  	struct trace_array *tr = filp->private_data;
> +	struct trace_scratch *tscratch = tr->scratch;
>  	struct seq_buf seq;
>  	char buf[64];
>  
> @@ -6835,10 +6853,10 @@ tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
>  	 * Otherwise it shows the KASLR address from the previous boot which
>  	 * should not be the same as the current boot.
>  	 */
> -	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> +	if (!tscratch || !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
>  		seq_buf_puts(&seq, "Offset: current\n");
>  	else
> -		seq_buf_printf(&seq, "Offset: %lx\n", tr->kaslr_addr);
> +		seq_buf_printf(&seq, "Offset: %lx\n", tscratch->kaslr_addr);
>  
>  	return simple_read_from_buffer(ubuf, cnt, ppos, buf, seq_buf_used(&seq));
>  }
> @@ -9212,6 +9230,8 @@ static int
>  allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
>  {
>  	enum ring_buffer_flags rb_flags;
> +	unsigned int scratch_size;
> +	void *scratch;
>  
>  	rb_flags = tr->trace_flags & TRACE_ITER_OVERWRITE ? RB_FL_OVERWRITE : 0;
>  
> @@ -9222,10 +9242,20 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
>  						      tr->range_addr_start,
>  						      tr->range_addr_size);
>  
> +		scratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
> +		if (scratch) {
> +			tr->scratch = scratch;
> +			tr->scratch_size = scratch_size;
> +
>  #ifdef CONFIG_RANDOMIZE_BASE
> -		if (ring_buffer_last_boot_delta(buf->buffer, &tr->kaslr_addr))
> -			tr->text_delta = kaslr_offset() - tr->kaslr_addr;
> +			{
> +				struct trace_scratch *tscratch = tr->scratch;
> +
> +				if (tscratch->kaslr_addr)
> +					tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
> +			}
>  #endif
> +		}
>  		/*
>  		 * This is basically the same as a mapped buffer,
>  		 * with the same restrictions.
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index abe8169c3e87..3a020fb82a34 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -348,8 +348,11 @@ struct trace_array {
>  	unsigned int		mapped;
>  	unsigned long		range_addr_start;
>  	unsigned long		range_addr_size;
> -	unsigned long		kaslr_addr;
>  	long			text_delta;
> +	void			*scratch; /* pointer in persistent memory */
> +	int			scratch_size;
> +
> +	int			buffer_disabled;
>  
>  	struct trace_pid_list	__rcu *filtered_pids;
>  	struct trace_pid_list	__rcu *filtered_no_pids;
> @@ -367,7 +370,6 @@ struct trace_array {
>  	 * CONFIG_TRACER_MAX_TRACE.
>  	 */
>  	arch_spinlock_t		max_lock;
> -	int			buffer_disabled;
>  #ifdef CONFIG_FTRACE_SYSCALLS
>  	int			sys_refcount_enter;
>  	int			sys_refcount_exit;
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
