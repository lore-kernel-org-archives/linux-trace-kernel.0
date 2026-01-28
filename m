Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2E21D5AA;
	Wed, 28 Jan 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769644081; cv=none; b=ZHvh3FxhuxwBtsBfHjjn+Sa4kLIrAbaDjwzHeTF4vqltQtO5j+r1VnfgDpFV3jXgV/WZTGCFYdmUyo77s/GkEfxgRr8M3DhFbWH4ZYeTjLv7tCUptXOE+ZNjceGqUb4PHZV7YlxIfEhUIqO3xZWT5vGN24JkH89Z5HOemx+JwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769644081; c=relaxed/simple;
	bh=4lTzb1cGm0Rqm2NAED9WEiaw4VLHfjKCmvY4w7uumTk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ElQ0u+Z9QYfgDq/QbQbbD2+TSOZ5I4hiykiv+VW7dhx3jcAW008oWCgAKTsrdSGstFHlpVExqFQA1OYhlwpMOjkJjKf6iWbfUPLbLfkYfbke4GZJ7MbbEiqyryhMii+PY7XfyvjBFxWb0tkdalawxuqdGplc/YUNhuAV7fSVZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbqRC2KN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbqRC2KN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10F5C4CEF1;
	Wed, 28 Jan 2026 23:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769644081;
	bh=4lTzb1cGm0Rqm2NAED9WEiaw4VLHfjKCmvY4w7uumTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbqRC2KN6PLi/sjXyu1GoPfmoA6Ncn8qy6jeQ0Lo3H74lpqSomeA5KixPDRS23Etc
	 H3G3Bo1KEWonAqSVoCfY/5S+dsMh9bNEfP1a60Af8vNr5GYzOQba1ddqJZn4ART9w7
	 5qaJs2T1jTcjdS3NydjS7I5LNhd+MMmyk1J33mySHP69kwhSCd7VE97h+gTm1SUr4O
	 pR/4lPlXRfY0gCDEg7cBpooi1/EKrSKeIBMLGr0oJaIsJQBI8Z0OmzW1QitgqKh9+2
	 eCLSzGva+LgsixCmiZDpW0LgSAuwb5GY8udJhl/F674QiFdSCu3Z8jd6i8ODx7gY2b
	 tX3nOAKZ8d2GA==
Date: Thu, 29 Jan 2026 08:47:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] ring-buffer: Add helper functions for allocations
Message-Id: <20260129084757.7e3747d0429d8231c26faa7b@kernel.org>
In-Reply-To: <20251125121153.35c07461@gandalf.local.home>
References: <20251125121153.35c07461@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 12:11:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The allocation of the per CPU buffer descriptor, the buffer page
> descriptors and the buffer page data itself can be pretty ugly:
> 
>   kzalloc_node(ALIGN(sizeof(struct buffer_page), cache_line_size()),
>                GFP_KERNEL, cpu_to_node(cpu));
> 
> And the data pages:
> 
>   page = alloc_pages_node(cpu_to_node(cpu),
>                           GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO, order);
>   if (!page)
> 	return NULL;
>   bpage->page = page_address(page);
>   rb_init_page(bpage->page);
> 
> Add helper functions to make the code easier to read.
> 
> This does make all allocations of the data page (bpage->page) allocated
> with the __GFP_RETRY_MAYFAIL flag (and not just the bulk allocator). Which
> is actually better, as allocating the data page for the ring buffer tracing
> should try hard but not trigger the OOM killer.
> 
> Link: https://lore.kernel.org/all/CAHk-=wjMMSAaqTjBSfYenfuzE1bMjLj+2DLtLWJuGt07UGCH_Q@mail.gmail.com/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> Changes since v1: https://patch.msgid.link/20251124140906.71a2abf6@gandalf.local.home
> 
> - Removed set but unused variables (kernel test robot)
> 
>  kernel/trace/ring_buffer.c | 97 +++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1244d2c5c384..6295443b0944 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -401,6 +401,41 @@ static void free_buffer_page(struct buffer_page *bpage)
>  	kfree(bpage);
>  }
>  
> +/*
> + * For best performance, allocate cpu buffer data cache line sized
> + * and per CPU.
> + */
> +#define alloc_cpu_buffer(cpu) (struct ring_buffer_per_cpu *)		\
> +	kzalloc_node(ALIGN(sizeof(struct ring_buffer_per_cpu),		\
> +			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
> +
> +#define alloc_cpu_page(cpu) (struct buffer_page *)			\
> +	kzalloc_node(ALIGN(sizeof(struct buffer_page),			\
> +			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
> +
> +static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
> +{
> +	struct buffer_data_page *dpage;
> +	struct page *page;
> +	gfp_t mflags;
> +
> +	/*
> +	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
> +	 * gracefully without invoking oom-killer and the system is not
> +	 * destabilized.
> +	 */
> +	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
> +
> +	page = alloc_pages_node(cpu_to_node(cpu), mflags, order);
> +	if (!page)
> +		return NULL;
> +
> +	dpage = page_address(page);
> +	rb_init_page(dpage);
> +
> +	return dpage;
> +}
> +
>  /*
>   * We need to fit the time_stamp delta into 27 bits.
>   */
> @@ -2204,7 +2239,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	struct ring_buffer_cpu_meta *meta = NULL;
>  	struct buffer_page *bpage, *tmp;
>  	bool user_thread = current->mm != NULL;
> -	gfp_t mflags;
>  	long i;
>  
>  	/*
> @@ -2218,13 +2252,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	if (i < nr_pages)
>  		return -ENOMEM;
>  
> -	/*
> -	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
> -	 * gracefully without invoking oom-killer and the system is not
> -	 * destabilized.
> -	 */
> -	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
> -
>  	/*
>  	 * If a user thread allocates too much, and si_mem_available()
>  	 * reports there's enough memory, even though there is not.
> @@ -2241,10 +2268,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
>  
>  	for (i = 0; i < nr_pages; i++) {
> -		struct page *page;
>  
> -		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
> -				    mflags, cpu_to_node(cpu_buffer->cpu));
> +		bpage = alloc_cpu_page(cpu_buffer->cpu);
>  		if (!bpage)
>  			goto free_pages;
>  
> @@ -2267,13 +2292,10 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  			bpage->range = 1;
>  			bpage->id = i + 1;
>  		} else {
> -			page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
> -						mflags | __GFP_COMP | __GFP_ZERO,
> -						cpu_buffer->buffer->subbuf_order);
> -			if (!page)
> +			int order = cpu_buffer->buffer->subbuf_order;
> +			bpage->page = alloc_cpu_data(cpu_buffer->cpu, order);
> +			if (!bpage->page)
>  				goto free_pages;
> -			bpage->page = page_address(page);
> -			rb_init_page(bpage->page);
>  		}
>  		bpage->order = cpu_buffer->buffer->subbuf_order;
>  
> @@ -2324,14 +2346,12 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  static struct ring_buffer_per_cpu *
>  rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  {
> -	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) = NULL;
> +	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
> +		alloc_cpu_buffer(cpu);
>  	struct ring_buffer_cpu_meta *meta;
>  	struct buffer_page *bpage;
> -	struct page *page;
>  	int ret;
>  
> -	cpu_buffer = kzalloc_node(ALIGN(sizeof(*cpu_buffer), cache_line_size()),
> -				  GFP_KERNEL, cpu_to_node(cpu));
>  	if (!cpu_buffer)
>  		return NULL;
>  
> @@ -2347,8 +2367,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
>  	mutex_init(&cpu_buffer->mapping_lock);
>  
> -	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
> -			    GFP_KERNEL, cpu_to_node(cpu));
> +	bpage = alloc_cpu_page(cpu);
>  	if (!bpage)
>  		return NULL;
>  
> @@ -2370,13 +2389,10 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  			rb_meta_buffer_update(cpu_buffer, bpage);
>  		bpage->range = 1;
>  	} else {
> -		page = alloc_pages_node(cpu_to_node(cpu),
> -					GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
> -					cpu_buffer->buffer->subbuf_order);
> -		if (!page)
> +		int order = cpu_buffer->buffer->subbuf_order;
> +		bpage->page = alloc_cpu_data(cpu, order);
> +		if (!bpage->page)
>  			goto fail_free_reader;
> -		bpage->page = page_address(page);
> -		rb_init_page(bpage->page);
>  	}
>  
>  	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
> @@ -6464,7 +6480,6 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct buffer_data_read_page *bpage = NULL;
>  	unsigned long flags;
> -	struct page *page;
>  
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return ERR_PTR(-ENODEV);
> @@ -6486,22 +6501,16 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
>  	arch_spin_unlock(&cpu_buffer->lock);
>  	local_irq_restore(flags);
>  
> -	if (bpage->data)
> -		goto out;
> -
> -	page = alloc_pages_node(cpu_to_node(cpu),
> -				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
> -				cpu_buffer->buffer->subbuf_order);
> -	if (!page) {
> -		kfree(bpage);
> -		return ERR_PTR(-ENOMEM);
> +	if (bpage->data) {
> +		rb_init_page(bpage->data);
> +	} else {
> +		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
> +		if (!bpage->data) {
> +			kfree(bpage);
> +			return ERR_PTR(-ENOMEM);
> +		}
>  	}
>  
> -	bpage->data = page_address(page);
> -
> - out:
> -	rb_init_page(bpage->data);
> -
>  	return bpage;
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
