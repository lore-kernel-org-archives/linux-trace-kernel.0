Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170F1F92E;
	Thu,  6 Feb 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855137; cv=none; b=rFcUct49zTHlupYldJgieeKp12wdaW5JJLhpXYQyWZuigyY2ZEzlY7h1l60iYRlgUQ/YfmWOYTrNP4fZgJSRzXRxgrzNx8XdfnywVsIuJ/cg24iUzTEnSzlp2ZGP8vGYH1C+/SHUWb3RArAXd/Vf5SA7HG7YSOj1tTSFrjzNxsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855137; c=relaxed/simple;
	bh=HKtbZK40dUUQND4YmYIdiRPLPRtH2T/s+oKa5QpUyL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfA0VjS0DEh31+aiQ8HDBJbQgpRRZBbgRsFXvPLIljDmvVG1QkeEYhSWI6AX2ttuUPHHSsVUZN4QSCOSbtz+Kb4jI0uUWIrySSaSoEAP/T9CH1QOxvRYIylUfbjAe0BEMoCwZz7e45ZeIrmqOwZ9A1lbP6RqBxWedNrM6oIsOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF8AC4CEDD;
	Thu,  6 Feb 2025 15:18:55 +0000 (UTC)
Date: Thu, 6 Feb 2025 10:19:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/8] ring-buffer: Add buffer meta data for persistent
 ring buffer
Message-ID: <20250206101936.17791160@gandalf.local.home>
In-Reply-To: <20250206141035.3d2e91abf5b77584aa2e0d6d@kernel.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.259337686@goodmis.org>
	<20250206141035.3d2e91abf5b77584aa2e0d6d@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:10:35 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:


> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 7146b780176f..0446d053dbd6 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -49,7 +49,12 @@ static void update_pages_handler(struct work_struct *work);
> >    
> 
> Can you add a comment to explain the layout of these meta-data and subbufs?

Sure.

> 
> 
> >  struct ring_buffer_meta {
> >  	int		magic;
> > -	int		struct_size;
> > +	int		struct_sizes;
> > +	unsigned long	total_size;
> > +	unsigned long	buffers_offset;
> > +};
> > +

> > @@ -1664,14 +1674,73 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
> >  	return (void *)ptr;
> >  }
> >  
> > +/*
> > + * See if the existing memory contains a valid meta section.
> > + * if so, use that, otherwise initialize it.  
> 
> Note that this must be called only for the persistent ring buffer.

Or just make it return false if bmeta is NULL.

The range_addr_start is only set for persistent ring buffers.

Also, this is to initialize a persistent ring buffer meta data, which makes
calling it for anything else rather strange.

> 
> > + */
> > +static bool rb_meta_init(struct trace_buffer *buffer)
> > +{
> > +	unsigned long ptr = buffer->range_addr_start;
> > +	struct ring_buffer_meta *bmeta;
> > +	unsigned long total_size;
> > +	int struct_sizes;
> > +
> > +	bmeta = (struct ring_buffer_meta *)ptr;
> > +	buffer->meta = bmeta;
> > +
> > +	total_size = buffer->range_addr_end - buffer->range_addr_start;
> > +
> > +	struct_sizes = sizeof(struct ring_buffer_cpu_meta);
> > +	struct_sizes |= sizeof(*bmeta) << 16;
> > +
> > +	/* The first buffer will start one page after the meta page */
> > +	ptr += sizeof(*bmeta);
> > +	ptr = ALIGN(ptr, PAGE_SIZE);
> > +
> > +	if (bmeta->magic != RING_BUFFER_META_MAGIC) {
> > +		pr_info("Ring buffer boot meta mismatch of magic\n");
> > +		goto init;
> > +	}
> > +
> > +	if (bmeta->struct_sizes != struct_sizes) {
> > +		pr_info("Ring buffer boot meta mismatch of struct size\n");
> > +		goto init;
> > +	}
> > +
> > +	if (bmeta->total_size != total_size) {
> > +		pr_info("Ring buffer boot meta mismatch of total size\n");
> > +		goto init;
> > +	}
> > +
> > +	if (bmeta->buffers_offset > bmeta->total_size) {
> > +		pr_info("Ring buffer boot meta mismatch of offset outside of total size\n");
> > +		goto init;
> > +	}
> > +
> > +	if (bmeta->buffers_offset != (void *)ptr - (void *)bmeta) {
> > +		pr_info("Ring buffer boot meta mismatch of first buffer offset\n");
> > +		goto init;
> > +	}
> > +
> > +	return true;
> > +


> > @@ -2327,10 +2386,16 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
> >  
> >  	/* If start/end are specified, then that overrides size */
> >  	if (start && end) {
> > +		unsigned long buffers_start;
> >  		unsigned long ptr;
> >  		int n;
> >  
> >  		size = end - start;
> > +
> > +		/* Subtract the buffer meta data */
> > +		size -= PAGE_SIZE;
> > +		buffers_start = start + PAGE_SIZE;
> > +  
> 
> So the buffer meta data is PAGE_SIZE aligned?

It's documented in the reserve_mem to be, but not as a requirement.
I should modify this to not depend on that.

Thanks,

-- Steve

> 
> >  		size = size / nr_cpu_ids;
> >  
> >  		/*
> > @@ -2340,7 +2405,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
> >  		 * needed, plus account for the integer array index that
> >  		 * will be appended to the meta data.
> >  		 */
> > -		nr_pages = (size - sizeof(struct ring_buffer_meta)) /
> > +		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
> >  			(subbuf_size + sizeof(int));
> >  		/* Need at least two pages plus the reader page */
> >  		if (nr_pages < 3)
> > @@ -2348,8 +2413,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
> >  
> >   again:
> >  		/* Make sure that the size fits aligned */
> > -		for (n = 0, ptr = start; n < nr_cpu_ids; n++) {
> > -			ptr += sizeof(struct ring_buffer_meta) +
> > +		for (n = 0, ptr = buffers_start; n < nr_cpu_ids; n++) {
> > +			ptr += sizeof(struct ring_buffer_cpu_meta) +
> >  				sizeof(int) * nr_pages;
> >  			ptr = ALIGN(ptr, subbuf_size);
> >  			ptr += subbuf_size * nr_pages;
> > @@ -3075,7 +3140,7 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
> >  }
> >  
> >  /* Return the index into the sub-buffers for a given sub-buffer */
> > -static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf)
> > +static int rb_meta_subbuf_idx(struct ring_buffer_cpu_meta *meta, void *subbuf)
> >  {
> >  	void *subbuf_array;
> >  
> > @@ -3087,7 +3152,7 @@ static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf)
> >  static void rb_update_meta_head(struct ring_buffer_per_cpu *cpu_buffer,
> >  				struct buffer_page *next_page)
> >  {
> > -	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
> > +	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
> >  	unsigned long old_head = (unsigned long)next_page->page;
> >  	unsigned long new_head;
> >  
> > @@ -3104,7 +3169,7 @@ static void rb_update_meta_head(struct ring_buffer_per_cpu *cpu_buffer,
> >  static void rb_update_meta_reader(struct ring_buffer_per_cpu *cpu_buffer,
> >  				  struct buffer_page *reader)
> >  {
> > -	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
> > +	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
> >  	void *old_reader = cpu_buffer->reader_page->page;
> >  	void *new_reader = reader->page;
> >  	int id;
> > @@ -3733,7 +3798,7 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
> >  			  rb_page_write(cpu_buffer->commit_page));
> >  		rb_inc_page(&cpu_buffer->commit_page);
> >  		if (cpu_buffer->ring_meta) {
> > -			struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
> > +			struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
> >  			meta->commit_buffer = (unsigned long)cpu_buffer->commit_page->page;
> >  		}
> >  		/* add barrier to keep gcc from optimizing too much */
> > @@ -5986,7 +6051,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> >  	if (cpu_buffer->mapped) {
> >  		rb_update_meta_page(cpu_buffer);
> >  		if (cpu_buffer->ring_meta) {
> > -			struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
> > +			struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
> >  			meta->commit_buffer = meta->head_buffer;
> >  		}
> >  	}
> > @@ -6020,7 +6085,7 @@ static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> >  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
> >  {
> >  	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
> > -	struct ring_buffer_meta *meta;
> > +	struct ring_buffer_cpu_meta *meta;
> >  
> >  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> >  		return;
> > @@ -6058,7 +6123,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
> >  void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
> >  {
> >  	struct ring_buffer_per_cpu *cpu_buffer;
> > -	struct ring_buffer_meta *meta;
> > +	struct ring_buffer_cpu_meta *meta;
> >  	int cpu;
> >  
> >  	/* prevent another thread from changing buffer sizes */  
> 
> Thank you,
> 
> > -- 
> > 2.45.2
> > 
> >   
> 
> 

