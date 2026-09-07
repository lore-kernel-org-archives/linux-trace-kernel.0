Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB1441633
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773199; cv=none; b=SGxB0dUt4o8nKOrrzPeIcCoN1+86at89ql7G8g4KUA1jgUlWk04Eb3U94eEiFgoeiDBYe57BW9XZL6QiJ12rdMzKdsuo83N7H1yy9LHJAQSyySQzToxYcKX5qrmDuvjOIdLDzexij7gXDhU43qMrpP4OxoXdurtW3siP/I2LH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773199; c=relaxed/simple;
	bh=NZjqV9sLk5M4ltbVQvH+Y+qK2Y8lMcauE4SFlxJ+Ds8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMIVgyby2hSud4+gOHj8XcDoKU4hNk+rebstRmhbK2Yuh6mWrtl9ZAPbPMdNBj0aCrjP0aCVcqlwT3o68MuoSSGcxBf9qZOuTDRISry2UMZJCUEQiyYJSgIp9AugjA3yyc14dAPvvXexbp3h/lmJufzrQJs2VPR9UZVg1xGh99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oc/9RHjn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oc/9RHjn"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482e257a23aso2277216f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788773195; x=1789377995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9MEER6Ux+1nai2tIQnasCaU7opCHdz3VYPzH1+GfP78=;
        b=oc/9RHjnXk7pwot9XKvkXsb0x9HPlz4mm6TcWBKI6T6Eajldra0aI1659bgHamFjZS
         x8ARtuj5NGMde1px9Ewpuwnss07Z4cF/kc5YsAt2X3HZEsA+JGbYmIhYyC835BPAKDmt
         Kf3HAAPOdlLFEaHX4KZ7s51JSvTIUNvWtDvgCYRCfiKnwoSIYh6jwYusjNc9Bog6AVuv
         sfGVYleZ1ACxu0f3KysQJ+00Y0QRlKP8BHVjPBFNRwYShVc4h73oqp6COzr3Yfb6thjr
         NF7xlLTIXP7L/tqQeBo0zN5PgwmS1O/lBX0a5y6sywEELRywcKgrYTxI6JnmIDAGzG/0
         fjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773195; x=1789377995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MEER6Ux+1nai2tIQnasCaU7opCHdz3VYPzH1+GfP78=;
        b=Nkb1zVkIW6jBHg4Trh8UlDFZoeW/PdorCJ4Qtp35R2t38h7SA1zxJNPiUlAxAh3vPx
         BcGlXWIfP18k3Eb4Hq3+bIQqEHvfcOfWx1YY4Ps9yW12SE9HTWGOSJeZE04G/eQlBReZ
         P0vZ0m6WDBnU46L2zuu1gWCgNbmTEVrIszBM8BKyckGYOkGxXOalvEkb41ZQKWH8GVXE
         qoktiNP/2qwbNDjXc4MY5GZP+fPTSzmvIrK5VPeOqXjvFdkiCWmQx+nTrKdFJ0+NJ7aI
         g9XCNJpIyFjybDmIv1JlPkMsdKA7FDkaAYCp4I/S8GGX50C8k2QuQg4kC3vB+Bh9pVv1
         XAuw==
X-Forwarded-Encrypted: i=1; AKwUvBzT+CEI6JGkAS/pku0/ZgpA3y7wHTkr+UPUX6aL7KuAJT4XmQ/C9SRa174qMytltR1JYKBvTe3J4uiEo+qK9a7du2o=@vger.kernel.org
X-Gm-Message-State: AFuF++mWyondBgAO9ex4qqB/eYUlnnhrnecdk7ZaPfMFIbJo/Rlp5shP
	BMoVp55e0/Lo49jtiF+ik0L+qC0KQJbmFmHS9dxf2A/je4BOuj3VWwMvjNAdYs4y6A==
X-Gm-Gg: AYBFou0BVAv0FC2oEWJHbDhc40nV60HIyLfgeh0fuIoFBjd+/HGCsi1EdRU7bp4ex3+
	fGceNIQ9pYzcdxJK7xybQbqIoRecgcJxIKU6lh3LzFE9+c4CVnJxUD55dwPoDpUbymcpqj/5npN
	Fz2H7fI/eFJ6Yfi8hjt+bykOgGxJvWgCoHqqi10xnPDXfvDybNqjGrEXhqeMQhILfLWh1zju47E
	D0SQJyqZtt5TQqbv0jH9PCIXT3GAJxe8HMey8vDVqRo4Bh/F492IKsihsXhYNN2w14GFUIiMpv6
	KOPs/XUBT6Len3xZAeN3nk7r1/yvIWavD4xBCOo5K80soYc53fGEqqXYdS4n6WSbVtCFFnRbG8U
	AMJBY2lDKWHy4FyqW6kK2H4GEGyrj389FWANnVPjOoTyu+u8VROj6aBxTQSu+n556pXTjy1ok66
	aa1zMB0HYgi+xp+t+fotL+HnAuXdJSolrtZ7QCE538ofHb0KTg8ifjjE9yO8j9ZYDVzrJ1InhIH
	ALZ1rvY+ESgMf2NrvvxM4gEZriMXzr6
X-Received: by 2002:a05:6000:2282:b0:485:8a46:b3c0 with SMTP id ffacd0b85a97d-4858a46b595mr21215117f8f.40.1788773194651;
        Mon, 07 Sep 2026 02:26:34 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm26508442f8f.32.2026.09.07.02.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:26:33 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:26:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH 1/2] tracing: add ring-buffer memory usage statistics in
 tracefs
Message-ID: <ap6DRq_tWE6uGLFm@google.com>
References: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
 <20260905112732.3705405-2-gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905112732.3705405-2-gaoxiang17@xiaomi.com>

On Sat, Sep 05, 2026 at 07:27:31PM +0800, Xiang Gao wrote:
> Report the memory consumed by the tracing ring buffers, rather than the
> usable data capacity exposed by buffer_size_kb. Android low-memory
> diagnostics need this to attribute the memory used by tracing when
> calculating lost RAM.
> 
> The buffers can be spread across the global trace array, dynamically
> created instances, and snapshot buffers. Userspace currently has to
> discover and sum every instance, and snapshot memory is not exposed by
> the per-instance totals.
> 
> Add a trace_stats directory with memory_usage_kb reporting:
> 
>   buffers:
>   snapshot_buffers:
> 
> covering the global trace array and all instances across all CPUs.
> 
> The values account for the full pages backing the data sub-buffers and
> reader page, plus the cached read page and mmap metadata page when
> present. Slab-allocated ring-buffer metadata is not included, as it is
> already reported through Slab and would be double-counted when
> subtracting tracing memory from lost RAM. Range and remote buffers,
> whose pages are externally owned, report zero.
> 
> Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> ---
>  Documentation/trace/ftrace.rst | 12 +++++++
>  include/linux/ring_buffer.h    |  1 +
>  kernel/trace/ring_buffer.c     | 41 +++++++++++++++++++++++
>  kernel/trace/trace.c           | 60 ++++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 84f06bf0da9b..ff9d604dd1b8 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -218,6 +218,18 @@ of ftrace. Here is a list of some of the key files:
>  
>  	This displays the total combined size of all the trace buffers.
>  
> +  trace_stats/memory_usage_kb:
> +
> +	This reports the memory consumed by the ring buffers, as opposed to
> +	the usable data capacity shown by buffer_size_kb. The value covers the
> +	main and snapshot buffers of the global trace array and all tracing
> +	instances. It does not include slab-allocated ring-buffer metadata.
> +
> +	Output::
> +
> +	    buffers: ...
> +	    snapshot_buffers: ...
> +
>    buffer_subbuf_size_kb:
>  
>  	This sets or displays the sub buffer size. The ring buffer is broken up
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 0670742b2d60..64eded40222c 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -166,6 +166,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
>  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
>  
>  unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
> +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
>  unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
>  
>  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8e2485bb3aa8..a8719b517798 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6464,6 +6464,47 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_size);
>  
> +/**
> + * ring_buffer_memory_size - return the memory used by the buffer (in bytes)
> + * @buffer: The ring buffer.
> + * @cpu: The CPU to get ring buffer memory from.
> + *
> + * Returns the page-allocator memory consumed by @cpu, including the data
> + * sub-buffers, the reader page, the cached read page, and the mmap
> + * metadata page. Unlike ring_buffer_size(), which reports the usable data
> + * capacity, this accounts for the full pages allocated to the buffer.
> + * Range and remote buffers do not own page-allocator memory and report zero.
> + */
> +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long subbuf_size;
> +	unsigned long size;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return 0;
> +
> +	/* Range and remote buffers use externally owned memory. */
> +	if (buffer->range_addr_start || buffer->remote)
> +		return 0;

Hum, why not including that? This is still memory immobilised for tracing.
(notice though remote buffers wouldn't appear in ftrace_trace_arrays)

> +
> +	cpu_buffer = buffer->buffers[cpu];
> +	subbuf_size = PAGE_SIZE << buffer->subbuf_order;

READ_ONCE(buffer->subbuf_order);

> +
> +	/* Data sub-buffers plus the reader page. */
> +	size = (cpu_buffer->nr_pages + 1) * subbuf_size;
> +
> +	/* The cached read page, if present, is a full sub-buffer page. */
> +	if (cpu_buffer->free_page)
> +		size += subbuf_size;
> +
> +	/* The mmap metadata page is a single system page. */
> +	if (cpu_buffer->meta_page)
> +		size += PAGE_SIZE;
> +
> +	return size;
> +}
> +
>  /**
>   * ring_buffer_max_event_size - return the max data size of an event
>   * @buffer: The ring buffer.
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 01a5e87af299..b343e03a6cf8 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5769,6 +5769,52 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
>  	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
>  }
>  
> +struct trace_mem_stats {
> +	unsigned long	buffers;
> +	unsigned long	snapshot;
> +};
> +
> +static void
> +trace_array_buffer_memory(struct trace_array *tr, int cpu,
> +			  unsigned long *buffers, unsigned long *snapshot)
> +{
> +	if (tr->array_buffer.buffer)
> +		*buffers += ring_buffer_memory_size(tr->array_buffer.buffer, cpu);
> +
> +#ifdef CONFIG_TRACER_SNAPSHOT
> +	if (tr->snapshot_buffer.buffer)
> +		*snapshot += ring_buffer_memory_size(tr->snapshot_buffer.buffer, cpu);
> +#endif
> +}
> +
> +static struct trace_mem_stats trace_buffers_memory(void)
> +{
> +	struct trace_mem_stats stats = {};
> +	struct trace_array *tr;
> +	int cpu;
> +
> +	guard(mutex)(&trace_types_lock);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		for_each_tracing_cpu(cpu)
> +			trace_array_buffer_memory(tr, cpu, &stats.buffers,
> +						  &stats.snapshot);
> +	}
> +
> +	return stats;
> +}
> +
> +static int trace_mem_show(struct seq_file *m, void *v)
> +{
> +	struct trace_mem_stats stats = trace_buffers_memory();
> +
> +	seq_printf(m, "buffers: %lu\n", stats.buffers >> 10);
> +	seq_printf(m, "snapshot_buffers: %lu\n", stats.snapshot >> 10);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(trace_mem);
> +
>  #define LAST_BOOT_HEADER ((void *)1)
>  
>  static void *l_next(struct seq_file *m, void *v, loff_t *pos)
> @@ -9188,6 +9234,18 @@ static struct notifier_block trace_module_nb = {
>  };
>  #endif /* CONFIG_MODULES */
>  
> +static __init void init_trace_stats_tracefs(void)
> +{
> +	struct dentry *stats_dir;
> +
> +	stats_dir = tracefs_create_dir("trace_stats", NULL);
> +	if (!stats_dir)
> +		return;
> +
> +	trace_create_file("memory_usage_kb", TRACE_MODE_READ, stats_dir,
> +			  NULL, &trace_mem_fops);
> +}
> +
>  static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  {
>  
> @@ -9196,6 +9254,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  	init_tracer_tracefs(&global_trace, NULL);
>  	ftrace_init_tracefs_toplevel(&global_trace, NULL);
>  
> +	init_trace_stats_tracefs();
> +
>  	trace_create_file("tracing_thresh", TRACE_MODE_WRITE, NULL,
>  			&global_trace, &tracing_thresh_fops);
>  
> -- 
> 2.34.1
> 
> 
