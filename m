Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451DA371049;
	Fri, 14 Aug 2026 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671113; cv=none; b=knnX/eobRu7CzTttcP1Kl5OC3KgEsQUd/P0DIKZSXFBiRUCRgbZNkTSTuka+wbN8B9wrLcvsOe9B+AFA9QIdk/TyvzdAfPjWAIIaaaQc634XUgUEn8VZIVc0gpndctSnOK8JDJgCeH8bC5u4u45iF0DY22zyvAXSO4cSRNbf4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671113; c=relaxed/simple;
	bh=K+btkpFdmISW4RbckUy9AELif7IsSFBaDy5szJDPwbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AklXng/ZF/hJD+7mMefCM+Y1yjW4zVcl7y4+PnM6FALHta5QEazCqmTcOn3AxjQsaLjzTDryrzugx+CHIuowkW8g6wzHX+rWtNS0g2wNIsHRNhdP4lWsqGBjTdNxyw9x3R87OTf9kNcHaWYcZor2HSBX7U3pbnPcbAfXHmYzZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=rwhtd3Gd; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="rwhtd3Gd"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 49726802D6;
	Fri, 14 Aug 2026 01:31:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 709882000F;
	Fri, 14 Aug 2026 01:31:36 +0000 (UTC)
Date: Thu, 13 Aug 2026 21:31:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/10] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260813213153.4ac1e1ff@gandalf.local.home>
In-Reply-To: <20260813131152.3589632-7-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-7-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 709882000F
X-Stat-Signature: 363i1ha68kbypieh1box9ektkha8omdt
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qSLsEEKBbSKtDZrsxaCiB2JRnaOUg/mk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=X9buxWth/uMucxtNYGdkTbY/TqZKxvju+Gn/RSp42C4=; b=rwhtd3Gd3Hg4rtb3icR3faTNInin2+iy33VZ1ZK1+xFjsFQ57lR7wRgcME+T+oaL9ZHkejhF/4wMmxUmP+qYAm3yuSuK86s0BtLZebenzEmq+fZoEDP/v+/Qx+xA4BeZuzcpt9Zy1tQo9vne5qGatpdOfzaunzaC2h7RXqhHQZ0=
X-HE-Tag: 1786671096-371322
X-HE-Meta: U2FsdGVkX1+cKX7/3LIiDXVlPcarlcRQsTVxNaRzQ/mMG2tcrpFxklenFUCUD6e8NpZf96Lc5GgkebTIOhqTHTDEkksFf2Cy4FendkyqNiLj0lyn15Tz5L+S1RS8ZgyWNZBgqbcnjkdzEk80V54M1jWeXcib8aSLEFJlNREGb88H85CldSDKMkz5agtPjoFZXOh52sjf+7w1yBpohc4sKp+NURoyDgufe8eicEFfQTQ3AAp0ozo3xckPJvFD0LZJ8jJ9eep3guzbfHs8TO8DNUjmwQYl80RSVJsnLxPQLkDYzhzTTr5MA+T/7u4ms/u8XElGGeFEL/gCjt4khqrzgxCFFJ/x0RA0+cDBq/xw2fRwcZCw7+keq4w74TE1o61+

On Thu, 13 Aug 2026 14:11:48 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index a00ab8a9cbd0..83292d90599e 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6976,34 +6976,52 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
>   * ring_buffer_alloc_read_page - allocate a page to read from buffer
>   * @buffer: the buffer to allocate for.
>   * @cpu: the cpu buffer to allocate.
> + * @prev: The previous page to be repurposed (can be NULL).
>   *
> - * This function is used in conjunction with ring_buffer_read_page.
> + * This function is used in conjunction with ring_buffer_read_page().
>   * When reading a full page from the ring buffer, these functions
>   * can be used to speed up the process. The calling function should
>   * allocate a few pages first with this function. Then when it
>   * needs to get pages from the ring buffer, it passes the result
> - * of this function into ring_buffer_read_page, which will swap
> + * of this function into ring_buffer_read_page(), which will swap
>   * the page that was allocated, with the read page of the buffer.
>   *
> + * If @prev is provided, and it has a different order than the current
> + * subbuffer order, its payload will be freed and re-allocated. If it
> + * already matches the order, it is simply returned.
> + *
>   * Returns:
>   *  The page allocated, or ERR_PTR
>   */
> -struct buffer_data_read_page *
> -ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> +struct buffer_data_read_page *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
> +							  struct buffer_data_read_page *prev)

I think we should do this differently. I don't like the "prev" argument.
Instead, let's pass by address.

int ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu, struct buffer_data_read_page **rpage)




> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 395238b2b715..f9399f391ac6 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7080,8 +7080,8 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
>  {
>  	struct ftrace_buffer_info *info = filp->private_data;
>  	struct trace_iterator *iter = &info->iter;
> -	void *trace_data;
> -	int page_size;
> +	void *trace_data, *prev_spare;
> +	unsigned int spare_size;
>  	ssize_t ret = 0;
>  	ssize_t size;
>  
> @@ -7091,36 +7091,30 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
>  	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
>  		return -EBUSY;
>  
> -	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> +again:


> +	prev_spare = info->spare;
> +	if (prev_spare) {
> +		spare_size = ring_buffer_read_page_size(info->spare);
>  
> -	/* Make sure the spare matches the current sub buffer size */
> -	if (info->spare) {
> -		if (page_size != info->spare_size) {
> -			ring_buffer_free_read_page(iter->array_buffer->buffer,
> -						   info->spare_cpu, info->spare);
> -			info->spare = NULL;
> -		}
> +		/* Do we have previous read data to read? */
> +		if (info->read < spare_size)
> +			goto read;
>  	}
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
> +	/* Make sure the read page order is aligned with the current buffer subbuf order */
> +	info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
> +						  prev_spare);
> +	if (IS_ERR(info->spare)) {
> +		ret = PTR_ERR(info->spare);
> +		info->spare = NULL;
> +		ring_buffer_free_read_page(iter->array_buffer->buffer, info->spare_cpu, prev_spare);
>  		return ret;
> +	}


instead of the above:

	ret = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
					  &info->space);

Where the above could do (under lock):

	if (*rpage) {
		if (*rpage)->order == buffer->subbuf_order)
			return 0;
		ring_buffer_free_read_page(*rpage);
		*rpage = NULL;
	}

	*rpage = all the reader page;

That is, lets completely remove the responsibility of the user having to
keep track of the buffer order here.

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

And if we could make ring_buffer_read_page() return -EAGAIN if the spare is
not the proper order. And only for that case.


> @@ -7129,6 +7123,10 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
>  	trace_access_unlock(iter->cpu_file);
>  
>  	if (ret < 0) {
> +		/* Did we race with ring_buffer_subbuf_order_set ? */
> +		if (spare_size != ring_buffer_subbuf_size_get(iter->array_buffer->buffer))
> +			goto again;

Then here we can just have:

		if (ret == -EAGAIN)
			goto again;

-- Steve


> +
>  		if (trace_empty(iter) && !iter->closed) {
>  			if (update_last_data_if_empty(iter->tr))
>  				return 0;
> @@ -7142,12 +7140,14 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
>  
>  			goto again;
>  		}
> +
>  		return 0;
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
