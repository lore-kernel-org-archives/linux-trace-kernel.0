Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F44F30EE;
	Thu,  3 Sep 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454535; cv=none; b=YxdeSjESNKBtKdofWerWLE8LpVTq6P6s8vFDEu+H9F34ueKWf0CcqApuPYH7NYTFC3rbQ8qZ+bczehiTAosEn39yBeG90ZHvhYQw4PZsqgnRzsdIik60E/5i1Zn6sJKgLtX7DJkUt5XpgidGennOlMKPbzQ+5DAG3TBqS90NyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454535; c=relaxed/simple;
	bh=8WHzY9NyHgmc2ohi2rMNL0Xt+Sbb6vGYDrmBNMLFuyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMnAbE5BBL3vD62gi03YdVBqg9qvcOx8zj2ydJsKVGutztPZBQXbA5MY+yonvWTA+XmUaGw5pAZR6Wg1QjRRrHuJJqdjezmhlN5wGW38sBw6VKhFNYBk1UyjP1LMS9ZcD/IkaJNpQzSupAVa0vxPxB9tvWaVlykL33Cmz/hA3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=CnwAu9Qg; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="CnwAu9Qg"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A4067A4669;
	Thu,  3 Sep 2026 16:55:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id BAA1F2000E;
	Thu,  3 Sep 2026 16:55:23 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:56:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ring-buffer: Cap static ring buffer nr_pages
Message-ID: <20260903125621.36cd33b8@gandalf.local.home>
In-Reply-To: <20260901155445.1475405-4-vdonnefort@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
	<20260901155445.1475405-4-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cfs3iw96eun6gxzpetbt9kysaktxice3
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: BAA1F2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19h0V6qv4jDnLkjd6pDu+1eS9uz8p+Vcb8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yYjsUcoAO6nzkm3oiEYR0fnUlNb08Ho92FmFoR9fJoc=; b=CnwAu9QgqbRumYhCLCz6aaSAAV1I4AAneLJ04jTunvXfShuO0TfYH3keNTJSarJPz4YAd7GbLDaFCyWLH8zEfZ3p9SSv+XcfXqXS+Jb2pK91gj0Nmv+R3qa9cC2ylSTUcAdtOxBhgfU+GV5nM00OgDQGF9n9pRDFWjp42NzmEm4=
X-HE-Tag: 1788454523-549378
X-HE-Meta: U2FsdGVkX19K7/dYI+sPeiHNONtb4OWZJ9dS5MHOgR7Z7z8ZODqub/3MwDV0mSEDQH3MQvpvLqHIC+qSobGTxnyF9sunI1wwgNHH15nvDDdC7zPBgVrwAjV1EDE2GJvvinoG7IMvi4hj+GzEJbqTKoHg6RJeDAKFcEqVKvmYMLT7hDRWigF+/Ztdp9fJrpRGI/5rFUgaj8YeehBfQbRSz8rBf4Ek99VLChJT9RQJTl60vfrGkppzKzx2IyWulzlz8/GgYQwl2jJiOxlvGF2BlWbwmIXAuTkriBdFMxoGNzotMq1iKO3BH1PdLLMxBh3DWpYUmdi+lhMcfyKOK2eFePnSqupKL0V7

On Tue,  1 Sep 2026 16:54:44 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Static ring buffers (i.e. persistent, user-mapped and remote) rely on
> the bpage::id field. The number of pages for those ring buffers must fit
> into that variable. Enforce this limit on ring buffer creation or
> user-mapping.
> 
> While at it, make buffer_page::id 31 bits. This does not change the
> struct buffer_page size.

Let's not add that change to this patch. Especially since this has a fixes
tag to it. That change has nothing to do with the fix.

The reason I had it as 30 to begin with was to reserve a bit in case I
found another reason for it. If 1<<30 is too small for the number of boot
buffer pages, we can always up in another order in the future.

> 
> Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 28dd76edfecf..c4260d6ecdfc 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -350,7 +350,7 @@ struct buffer_page {
>  	local_t		 entries;	/* entries on this page */
>  	unsigned long	 real_end;	/* real end of data */
>  	unsigned	 order;		/* order of the page */
> -	u32		 id:30;		/* ID for external mapping */
> +	u32		 id:31;		/* ID for external mapping */
>  	u32		 range:1;	/* Mapped via a range */
>  	struct buffer_data_page *page;	/* Actual data page */
>  };
> @@ -657,6 +657,15 @@ static bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
>  	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->ring_meta;
>  }
>  
> +static unsigned long rb_static_max_pages(void)
> +{
> +	/*
> +	 * Static ring buffers are using bpage::id and must account for the
> +	 * reader page.
> +	 */
> +	return (1UL << 31) - 1;
> +}
> +
>  struct ring_buffer_iter {
>  	struct ring_buffer_per_cpu	*cpu_buffer;
>  	unsigned long			head;
> @@ -2842,6 +2851,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
>  		 */
>  		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
>  			(subbuf_size + sizeof(int));
> +
> +		if (nr_pages > rb_static_max_pages())
> +			goto fail_free_buffers;
> +

If you want to add something, we could add to the beginning of this
function:

	/* Prevent ridiculously small sizes */
	if (size < PAGE_SIZE)
		return NULL;

to shut up Sashiko about overflows :-p

-- Steve



>  		/* Need at least two pages plus the reader page */
>  		if (nr_pages < 3)
>  			goto fail_free_buffers;
> @@ -2874,6 +2887,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
>  		/* The writer is remote. This ring-buffer is read-only */
>  		atomic_inc(&buffer->record_disabled);
>  		nr_pages = desc->nr_page_va - 1;
> +
> +		if (nr_pages > rb_static_max_pages())
> +			goto fail_free_buffers;
> +
>  		if (nr_pages < 2)
>  			goto fail_free_buffers;
>  	} else {
> @@ -7836,6 +7853,9 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  	/* prevent another thread from changing buffer/sub-buffer sizes */
>  	guard(mutex)(&buffer->mutex);
>  
> +	if (cpu_buffer->nr_pages > rb_static_max_pages())
> +		return -E2BIG;
> +
>  	err = rb_alloc_meta_page(cpu_buffer);
>  	if (err)
>  		return err;

