Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3634E56D6;
	Thu,  3 Sep 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450468; cv=none; b=pLek89kghu7heswsE0XheWDigkcD4dJ8xFcZfum9/zNlCvbZokDdXcRMrw9ab/ozczJcKs+aYbY7mM6Ildz1BBLMcqbrKFW6lPxVVCepswd0COyHwe9WciMXtey7P+gK1o5k399AXzqNYaZFTJw/ZC/J8ijPQgZWVn7zuMFOh7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450468; c=relaxed/simple;
	bh=HfYHvyqB5PtBuPmi086kVJuCSKdAEmSFkGc/keIk1Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2N8EPhpop0Wy73ckytzAA7mffVQ9+HzfMBfvp2aWhmC7P5o4AKpj+eDa7wbaXo5aiF8EmnvlGzxAXqRtMl89LIriSwMHsAf1tIwDdLSeY60yGKIYTwnxa6CWbWe+z03gvVuQjldUy/4ygP+ifrj05wztv7iZrp5+wOZvp1YvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=VERux9SG; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="VERux9SG"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id D6E44160581;
	Thu,  3 Sep 2026 15:47:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 031C62F;
	Thu,  3 Sep 2026 15:47:41 +0000 (UTC)
Date: Thu, 3 Sep 2026 11:48:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/4] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260903114845.4eec2020@gandalf.local.home>
In-Reply-To: <20260901155445.1475405-3-vdonnefort@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
	<20260901155445.1475405-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cmhxzg5p1i3fjd1361wgjwnkhh451ii4
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 031C62F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18GrpUEGdC89ccKikCZdkWpS3RjyXpSh2E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=FZbmFI4t38i1UBimWEoQex/XNX5CXRCKPEdEaX+iyNQ=; b=VERux9SGge1WUcjCed2DtXoijQzLKlZjorcmHES29lX+9tn84TfzIHZ9p3PAJBnsrtWFbIpF//hW5qEmsNQZM8ctXsGf8pFbvfuC+0OyMYmmNYEIVBlJAy4Bj4Z50zXLWP0x8LtVFLstxDF70n4HxJgAhaYjhdF6yxqRkgZKGic=
X-HE-Tag: 1788450461-869149
X-HE-Meta: U2FsdGVkX19Oq+kSpW/N12s+zBNZZVKuOlrlPiOb1m/tAzRaj6FCT/4kL/dcacDbeDdbXIssiEHfG/iNTz3Phu/qTYcK1nrsu1KLlimB1S3G7ypDtPB7dsNKfNZKd/QuOGQBe9CmTLQPzEdR0IKMrbNUBpfeiuPStIv3OICECFWmvzbO/LRk4Ofurhisq4lHzERa11i3QCRnWWqrF0FEQ+upcBreWgYA8lDhxDADr3hGkVZnMan+8mLpqNCdFZ9Qd/75EEUcKPPnaMsV/jDsL9YfJfg8rOgGB+Iwgz85MxbNZHQCCKyIl84u0hv7i//IcJ/gIeUVc1WBkvnGLuqBQTHVbOgMHAS63s0+R6aonJe2EIgqjZzPPg==

On Tue,  1 Sep 2026 16:54:43 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> uninitialized memory to userspace due to stale size values.
> 
> Modify ring_buffer_alloc_read_page() to handle the resizing of an
> existing buffer_data_read_page if necessary and add a new
> ring_buffer_read_page_size(). This new function enables ring-buffer
> buffer_data_read_page users to not call the racy
> ring_buffer_subbuf_size_get(). This makes the spare_size member of
> ftrace_buffer_info redundant.
> 
> Finally, handle buffer_data_read_page/reader_page order discrepancy in
> ring_buffer_read_page(). On a mismatch simply copy manually the data to
> the buffer_data_read_page.

Let's add here:

 Link: https://lore.kernel.org/all/20260817140812.2C7D41F00A3A@smtp.kernel.org/

As it has more information about why we came up with this solution.

> 
> Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>



> -struct buffer_data_read_page *
> -ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> +int ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
> +				struct buffer_data_read_page **rpage)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
> -	struct buffer_data_read_page *bpage = NULL;
>  	unsigned long flags;
> +	unsigned int order;
>  
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> -		return ERR_PTR(-ENODEV);
> +		return -ENODEV;
>  
> -	bpage = kzalloc_obj(*bpage);
> -	if (!bpage)
> -		return ERR_PTR(-ENOMEM);
> +	if (!rpage)
> +		return -EINVAL;
>  
> -	bpage->order = buffer->subbuf_order;
> +	order = buffer->subbuf_order;

Hmm, should we add a READ_ONCE() around the subbuf_order? There's no locks
taken here and couldn't we get some inconsistency if things change. I feel
more comfortable knowing that "order" is consistent throughout this
function.

> +
> +	if (*rpage) {
> +		if ((*rpage)->order == order)
> +			return 0;
> +
> +		/* We can reuse rpage, but we discard the payload */
> +		free_pages((unsigned long)(*rpage)->data, (*rpage)->order);
> +		(*rpage)->data = NULL;
> +	} else {
> +		*rpage = kzalloc_obj(**rpage);
> +		if (!*rpage)
> +			return -ENOMEM;
> +	}
> +
> +	(*rpage)->order = order;
>  	cpu_buffer = buffer->buffers[cpu];
> +
>  	local_irq_save(flags);
>  	arch_spin_lock(&cpu_buffer->lock);
>  
>  	if (cpu_buffer->free_page.data) {
> -		*bpage = cpu_buffer->free_page;
> +		**rpage = cpu_buffer->free_page;
>  		cpu_buffer->free_page.data = NULL;
>  	}
>  
>  	arch_spin_unlock(&cpu_buffer->lock);
>  	local_irq_restore(flags);
>  
> -	if (bpage->data) {
> -		rb_init_data_page(bpage->data);
> +	if ((*rpage)->data) {
> +		rb_init_data_page((*rpage)->data);
>  	} else {
> -		bpage->data = alloc_cpu_data(cpu, bpage->order);
> -		if (!bpage->data) {
> -			kfree(bpage);
> -			return ERR_PTR(-ENOMEM);
> +		(*rpage)->data = alloc_cpu_data(cpu, (*rpage)->order);
> +		if (!(*rpage)->data) {
> +			kfree(*rpage);
> +			*rpage = NULL;
> +			return -ENOMEM;
>  		}
>  	}
>  
> -	return bpage;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
>  
> @@ -7050,21 +7077,30 @@ EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
>   * ring_buffer_free_read_page - free an allocated read page
>   * @buffer: the buffer the page was allocate for
>   * @cpu: the cpu buffer the page came from
> - * @data_page: the page to free
> + * @rpage: the buffer_dat_read_page to free
>   *
>   * Free a page allocated from ring_buffer_alloc_read_page.
>   */
>  void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
> -				struct buffer_data_read_page *data_page)
> +				struct buffer_data_read_page *rpage)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
> -	struct buffer_data_page *dpage = data_page->data;
> -	struct page *page = virt_to_page(dpage);
> +	struct buffer_data_page *dpage;
>  	unsigned long flags;
> +	struct page *page;
>  
>  	if (!buffer || !buffer->buffers || !buffer->buffers[cpu])
>  		return;
>  
> +	if (!rpage)
> +		return;
> +
> +	dpage = rpage->data;
> +	if (!dpage)
> +		goto out;
> +
> +	page = virt_to_page(dpage);
> +
>  	cpu_buffer = buffer->buffers[cpu];
>  
>  	/*
> @@ -7072,14 +7108,14 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
>  	 * is different from the subbuffer order of the buffer -
>  	 * we can't reuse it
>  	 */
> -	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
> +	if (page_ref_count(page) > 1 || rpage->order != buffer->subbuf_order)
>  		goto out;
>  
>  	local_irq_save(flags);
>  	arch_spin_lock(&cpu_buffer->lock);
>  
>  	if (!cpu_buffer->free_page.data) {
> -		cpu_buffer->free_page = *data_page;
> +		cpu_buffer->free_page = *rpage;
>  		dpage = NULL;
>  	}
>  
> @@ -7087,8 +7123,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
>  	local_irq_restore(flags);
>  
>   out:
> -	free_pages((unsigned long)dpage, data_page->order);
> -	kfree(data_page);
> +	free_pages((unsigned long)dpage, rpage->order);
> +	kfree(rpage);
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
>  
> @@ -7159,10 +7195,9 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	if (!dpage)
>  		return -1;
>  
> -	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
> +	len = min_t(size_t, len, rb_read_page_capacity(data_page));
>  
> -	if (data_page->order != cpu_buffer->reader_page->order)
> -		return -1;
> +	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
>  
>  	reader = rb_get_reader_page(cpu_buffer);
>  	if (!reader)
> @@ -7177,16 +7212,18 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	/* Check if any events were dropped */
>  	missed_events = cpu_buffer->lost_events;
>  
> -	/*
> -	 * If this page has been partially read or
> -	 * if len is not big enough to read the rest of the page or
> -	 * a writer is still on the page, then
> -	 * we must copy the data from the page to the buffer.
> -	 * Otherwise, we can simply swap the page with the one passed in.
> -	 */
> +	 /*
> +	  * It is not possible to swap the reader page if:
> +	  *   - It has been partially read
> +	  *   - len is not big enough to read it entirely
> +	  *   - A writer is still on it
> +	  *   - The ring buffer is static
> +	  *   - The order doesn't match
> +	  */
>  	if (read || (len < (size - read)) ||
>  	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> -	    rb_is_static(cpu_buffer)) {
> +	    rb_is_static(cpu_buffer) ||
> +	    data_page->order != reader->order) {
>  		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
>  		unsigned int rpos = read;
>  		unsigned int pos = 0;
> @@ -7280,7 +7317,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		 * missed events, then record it there.
>  		 */
>  		if (missed_events > 0 &&
> -		    rb_page_capacity(reader) - size >= sizeof(missed_events)) {
> +		    rb_read_page_capacity(data_page) - size >= sizeof(missed_events)) {
>  			memcpy(&dpage->data[size], &missed_events,
>  			       sizeof(missed_events));
>  			local_add(RB_MISSED_STORED, &dpage->commit);
> @@ -7300,8 +7337,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	/*
>  	 * This page may be off to user land. Zero it out here.
>  	 */
> -	if (size < rb_page_capacity(reader))
> -		memset(&dpage->data[size], 0, rb_page_capacity(reader) - size);
> +	if (size < rb_read_page_capacity(data_page))
> +		memset(&dpage->data[size], 0, rb_read_page_capacity(data_page) - size);
>  
>  	return read;
>  }
> @@ -7319,6 +7356,18 @@ void *ring_buffer_read_page_data(struct buffer_data_read_page *page)
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
>  
> +/**
> + * ring_buffer_read_page_size - get size of the read page.
> + * @page:  the page to get the size from
> + *
> + * Returns size of the page in bytes.
> + */
> +unsigned int ring_buffer_read_page_size(struct buffer_data_read_page *rpage)
> +{
> +	return PAGE_SIZE << rpage->order;
> +}
> +EXPORT_SYMBOL_GPL(ring_buffer_read_page_size);
> +
>  /**
>   * ring_buffer_subbuf_size_get - get size of the sub buffer.
>   * @buffer: the buffer to get the sub buffer size from
> diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
> index 593e3b59e42e..c3d34c0e64e2 100644
> --- a/kernel/trace/ring_buffer_benchmark.c
> +++ b/kernel/trace/ring_buffer_benchmark.c
> @@ -104,7 +104,7 @@ static enum event_status read_event(int cpu)
>  
>  static enum event_status read_page(int cpu)
>  {
> -	struct buffer_data_read_page *bpage;
> +	struct buffer_data_read_page *bpage = NULL;
>  	struct ring_buffer_event *event;
>  	struct rb_page *rpage;
>  	unsigned long commit;
> @@ -114,8 +114,8 @@ static enum event_status read_page(int cpu)
>  	int inc;
>  	int i;
>  
> -	bpage = ring_buffer_alloc_read_page(buffer, cpu);
> -	if (IS_ERR(bpage))
> +	ret = ring_buffer_alloc_read_page(buffer, cpu, &bpage);
> +	if (ret < 0)
>  		return EVENT_DROPPED;
>  
>  	page_size = ring_buffer_subbuf_size_get(buffer);
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a946e0183fd1..7ba3856daf44 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7082,8 +7082,8 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
>  {
>  	struct ftrace_buffer_info *info = filp->private_data;
>  	struct trace_iterator *iter = &info->iter;
> +	unsigned int spare_size;
>  	void *trace_data;
> -	int page_size;
>  	ssize_t ret = 0;
>  	ssize_t size;
>  
> @@ -7093,36 +7093,24 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
>  	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
>  		return -EBUSY;
>  
> -	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> -
> -	/* Make sure the spare matches the current sub buffer size */
> +again:
>  	if (info->spare) {
> -		if (page_size != info->spare_size) {
> -			ring_buffer_free_read_page(iter->array_buffer->buffer,
> -						   info->spare_cpu, info->spare);
> -			info->spare = NULL;
> -		}
> +		spare_size = ring_buffer_read_page_size(info->spare);
> +		/* Do we have previous read data to read? */
> +		if (info->read < spare_size)
> +			goto read;
>  	}

I would have ring_buffer_free_read_page() accept a null pointer and then here do:

	spare_size = ring_buffer_read_page_size(info->spare);

 again:
	/* Do we have previous read data to read? */
	if (info->read < spare_size)
		goto read;

As the jump to here below has already calculated the spare_size, why do it again?

Have ring_buffer_read_page_size() be:

unsigned int ring_buffer_read_page_size(struct buffer_data_read_page *rpage)
{
	return rpage ? PAGE_SIZE << rpage->order : 0;
}

Then info->read could not be less than spare_size if there was no spare.

>  
> -	if (!info->spare) {
> -		info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer,
> -							  iter->cpu_file);
> -		if (IS_ERR(info->spare)) {
> -			ret = PTR_ERR(info->spare);
> -			info->spare = NULL;
> -		} else {
> -			info->spare_cpu = iter->cpu_file;
> -			info->spare_size = page_size;
> -		}
> -	}
> -	if (!info->spare)
> +	/* Make sure the read page order is aligned with the current subbuf order */

The above comment doesn't really make sense anymore since the user here
should not care about the order. I would nuke it.

> +	ret = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
> +					  &info->spare);
> +	if (ret)
>  		return ret;
>  
> -	/* Do we have previous read data to read? */
> -	if (info->read < page_size)
> -		goto read;
> +	spare_size = ring_buffer_read_page_size(info->spare);
> +	info->read = spare_size;
> +	info->spare_cpu = iter->cpu_file;
>  
> - again:
>  	trace_access_lock(iter->cpu_file);
>  	ret = ring_buffer_read_page(iter->array_buffer->buffer,
>  				    info->spare,
> @@ -7148,8 +7136,9 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
>  	}
>  
>  	info->read = 0;
> +
>   read:
> -	size = page_size - info->read;
> +	size = spare_size - info->read;
>  	if (size > count)
>  		size = count;
>  	trace_data = ring_buffer_read_page_data(info->spare);
> @@ -7199,17 +7188,17 @@ int tracing_buffers_release(struct inode *inode, struct file *file)
>  }
>  
>  struct buffer_ref {
> -	struct trace_buffer	*buffer;
> -	void			*page;
> -	int			cpu;
> -	refcount_t		refcount;
> +	struct trace_buffer		*buffer;
> +	struct buffer_data_read_page	*rpage;
> +	int				cpu;
> +	refcount_t			refcount;
>  };
>  
>  static void buffer_ref_release(struct buffer_ref *ref)
>  {
>  	if (!refcount_dec_and_test(&ref->refcount))
>  		return;
> -	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
> +	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->rpage);
>  	kfree(ref);
>  }
>  
> @@ -7270,23 +7259,12 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  	};
>  	struct buffer_ref *ref;
>  	bool woken = false;
> -	int page_size;
>  	int entries, i;
>  	ssize_t ret = 0;
>  
>  	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
>  		return -EBUSY;
>  
> -	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> -	if (*ppos & (page_size - 1))
> -		return -EINVAL;
> -
> -	if (len & (page_size - 1)) {
> -		if (len < page_size)
> -			return -EINVAL;
> -		len &= (~(page_size - 1));
> -	}

OK, you are removing this so that it is tested in the loop?

> -
>  	if (splice_grow_spd(pipe, &spd))
>  		return -ENOMEM;
>  
> @@ -7294,7 +7272,8 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  	trace_access_lock(iter->cpu_file);
>  	entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
>  
> -	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= page_size) {
> +	for (i = 0; i < spd.nr_pages_max && len && entries; i++) {

Is there a reason you moved the len -= page_size from here to the end of
the loop?  Basically that has no functional change.

> +		unsigned int page_size;

Was that just to move page_size here?

Let's keep it as-is.

>  		struct page *page;
>  		int r;
>  
> @@ -7306,25 +7285,36 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  
>  		refcount_set(&ref->refcount, 1);
>  		ref->buffer = iter->array_buffer->buffer;
> -		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
> -		if (IS_ERR(ref->page)) {
> -			ret = PTR_ERR(ref->page);
> -			ref->page = NULL;
> +
> +		ret = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, &ref->rpage);
> +		if (ret) {
>  			kfree(ref);
>  			break;
>  		}
>  		ref->cpu = iter->cpu_file;
>  
> -		r = ring_buffer_read_page(ref->buffer, ref->page,
> -					  len, iter->cpu_file, 1);
> +		page_size = ring_buffer_read_page_size(ref->rpage);
> +
> +		r = -EINVAL;
> +		if (IS_ALIGNED(*ppos, page_size) && len >= page_size) {
> +			r = ring_buffer_read_page(ref->buffer, ref->rpage, len, iter->cpu_file, 1);
> +		} else if (!i) {
> +			/*
> +			 * If the first iteration fails this is an invalid
> +			 * userspace input. Otherwise, this is because the
> +			 * subbuf order has been modified. Do not report an
> +			 * error and finish the read.
> +			 */
> +			ret = -EINVAL;

This is more likely to be true not because the subbuf order was modified,
but also if the length was not a multiple of page_size. From the code you
removed;

-	if (len & (page_size - 1)) {
-		if (len < page_size)
-			return -EINVAL;
-		len &= (~(page_size - 1));
-	}

It would error if len was smaller than page_size but otherwise it would
modify len to be a multiple of page_size.

The overall behavior is the same, but the comment needs to be updated.

-- Steve

> +		}
> +
>  		if (r < 0) {
> -			ring_buffer_free_read_page(ref->buffer, ref->cpu,
> -						   ref->page);
> +			ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->rpage);
>  			kfree(ref);
>  			break;
>  		}
>  
> -		page = virt_to_page(ring_buffer_read_page_data(ref->page));
> +		page = virt_to_page(ring_buffer_read_page_data(ref->rpage));
>  
>  		spd.pages[i] = page;
>  		spd.partial[i].len = page_size;
> @@ -7332,6 +7322,7 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  		spd.partial[i].private = (unsigned long)ref;
>  		spd.nr_pages++;
>  		*ppos += page_size;
> +		len -= page_size;
>  
>  		entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
>  	}
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 74a7a50d1e78..203d098ee14e 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -745,11 +745,10 @@ static inline int tracing_get_cpu(struct inode *inode)
>  void tracing_reset_cpu(struct array_buffer *buf, int cpu);
>  
>  struct ftrace_buffer_info {
> -	struct trace_iterator	iter;
> -	void			*spare;
> -	unsigned int		spare_cpu;
> -	unsigned int		spare_size;
> -	unsigned int		read;
> +	struct trace_iterator		iter;
> +	struct buffer_data_read_page	*spare;
> +	unsigned int			spare_cpu;
> +	unsigned int			read;
>  };
>  
>  /**

