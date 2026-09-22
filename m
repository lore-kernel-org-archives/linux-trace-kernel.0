Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FF48A2C3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070098; cv=none; b=uJupR5XtVbH3UyR5dJCLu+EFxT/REsJQl/HbLoQIJ/UIEhhI9S5V70nH+oEkI1gBc+SKtWkeqWT9PALzzC2+Vo6nw5i9PTEbkpxTQYFqVrNpW2hi6cZUck4gTsoks/5AOkSMd3/lgewKSwWr2IUKwBCJdPkff/bOjAoFF59Lowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070098; c=relaxed/simple;
	bh=YM+n+gZvVY10p7fJ3CU3SkGJ78Q7KHDu7Ir/VVgrUew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh5bOBrEWtFWphvgXrgPsOvvyjivT6VoIcNxUcecf2GRBf0jv21TCJmixkRXrEBpYiKOXnQwyubirKNfl9YazvBFB9nkeANpqyT1F56Wa/Dvlm4GgLA4bmdvc37gsYL/zpAKClxLGAKUMEZpEpg4W13c4ScAAE7V5cK6HhoXWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFBmzRUS; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFBmzRUS"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so26809545e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790070095; x=1790674895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ihfL+tJmT3BCBYnWtaQmDFL2P9DOwEac8zYpc3/L1YU=;
        b=VFBmzRUSOLAfIhfPCNV3MaVno7crCbUyiaXPK8+d6Q2/7yGT2YZx8PAsTqB/4uzNxr
         XkDm9WOPD7M+UbOhh/KDA9QvftG0UgjKwHxCYkWsocCVOXNMvhIrFXvEx+wFxXxQYV6X
         a7pGAZVkUTGQPNC7HH/gJxo+a05P0irnwgNEDOLxCt9oGsR4gtRd4SPTTyNCx8kOPb7z
         Eop94XZMEiwH/ySGufrgG1xzC2Xl3SZzHyANs5VSnkb5w8PRH9QCVVQND64zw5Vqs8SI
         0SWKIrq8mt6pWtjjluVxYec/9bY47zVrGqMRftNVq+8msWevTSHv2vyth6wReBNkxb7L
         RZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070095; x=1790674895;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihfL+tJmT3BCBYnWtaQmDFL2P9DOwEac8zYpc3/L1YU=;
        b=HjVkS63PfzOiNGLTdUWSrsOPCDdPnRxTZaUP4xQlF6qZBK4+lGCx3ua7jfv572nv5m
         kCoY2kU5da9qwq42ur66dprT2ResQo0N0met8L9IfKKSv2n0TihJYfAfXq7jUffMrI5w
         kaWrGwBInm3NaR6XP6hURLeabhzrO4fS1bUHmCWTvst5aUcxLWVUOpbaqTBAFK5Fqrnt
         8VoTUEwNxsu07O7/N9v8zif+0+nlrRQUQstfJVGIqcY0pZZWmjnSmHxDcBllaUJ6Po+x
         tPWcjDX9aJcVjb/QLWn1twYe8oE4HWV3JvlM+WzlFzWfmg3TZvfkZ3y0NsUpUEyxVA9i
         kpYQ==
X-Forwarded-Encrypted: i=1; AKwUvByd5yC/x6GSlzFqBHglAe2OkSDlbdbYPJLVWgPzCpZQeKAlRfNiZigg/wLbiE4bxyuTLeR6hvJ1CSzDTR9jG8I8wYs=@vger.kernel.org
X-Gm-Message-State: AFuF++lQcuLaL6w6Bua8hwN0G1pdXW6LHK8+r7POi2uE5O1701ERbj4T
	NUKvDDUUYGIaGh0o9NhCSGX9t6hsg/Vvu5WA4OOSIjjsZnfy7BF7/bTamwtU0cMJ3A==
X-Gm-Gg: AYBFou2a3M0S4T2GLew8O2r+TuS4IS+AA0dOCbYxcxHhRqOpSP08q+sOLbo/L4ZFiCZ
	hWOhOKrkaYzGBLz77MrA7Ze+g3Sp1Y96Z8UfOPp35QaweV3/giX58MccAQqrAVBjR0lK/c96UDi
	MFMVGQcTdPLmjL5lwH1fiDbe1XdqGKF4gi49DBr4qc2NKz6urR/FyDDuVs9ULDUkt36v0S47KE1
	294qVQZ1elzgjJvwtkmVzhd2NkqLJLAgfY/G5rZeJwXqBf9kQsQ1nJZ+Ppb74DDkMwAE9Hx8ZIz
	Cy639jdeayxIFmTS5451U0UaN2yTfzf+/vORTI6/4iez2VIcIDyIGveF18bHtnvipmMkUXUkNO8
	OMxL0RZXYBlkcmqGg4+EVgKt215zQ5K6o7/EnAIsMDt8Fa5fpbiV7ds1sPWMclHGnzCrm2zaXcQ
	pWM3zqomYLk1rMAeNUgxoh5RfI1hi74F+N4QBmOLeXsREcZDLV4fkZACUlfMNKdPjJL7MvkI6p6
	vPSyqniSYZJps+efPyOu58DNtqUhiHggA+3MJGnvnY=
X-Received: by 2002:a05:600c:3ba0:b0:49e:73d3:78ab with SMTP id 5b1f17b1804b1-49fc55adc12mr237091315e9.0.1790070094567;
        Tue, 22 Sep 2026 02:41:34 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886279298asm3150725f8f.34.2026.09.22.02.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:41:33 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:41:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v4 1/2] tracing: add ring-buffer memory usage statistics
 in tracefs
Message-ID: <arJNSjKsJ3bK40dH@google.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
 <20260921113047.1152602-1-gaoxiang17@xiaomi.com>
 <20260921113047.1152602-2-gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921113047.1152602-2-gaoxiang17@xiaomi.com>

On Mon, Sep 21, 2026 at 07:30:45PM +0800, Xiang Gao wrote:
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
> covering the global trace array, all instances, and the bootstrapping
> temp_buffer across all CPUs.
> 
> The values account for the full pages backing the data sub-buffers and
> reader page, plus the cached read page and mmap metadata page when
> present. Slab-allocated ring-buffer metadata is not included, as it is
> already reported through Slab and would be double-counted when
> subtracting tracing memory from lost RAM. Remote buffers, whose pages
> are externally owned, report zero.

For the next version, it is good practice to __not__ in-reply-to with previous
version.

> 
> Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> ---
>  Documentation/trace/ftrace.rst | 12 +++++
>  include/linux/ring_buffer.h    |  1 +
>  kernel/trace/ring_buffer.c     | 41 +++++++++++++++
>  kernel/trace/trace.c           | 95 ++++++++++++++++++++++++++++++++++
>  4 files changed, 149 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 7261f25f8b4b..99ddfe26b7cd 100644
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
> index eac3e9080c3c..96b99e6757d4 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -167,6 +167,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
>  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
>  
>  unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
> +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
>  unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
>  
>  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..efb88bf8970c 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6559,6 +6559,47 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
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
> + * Remote buffers do not own page-allocator memory and report zero.
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
> +	/* Remote buffers use externally owned memory. */
> +	if (buffer->remote)
> +		return 0;

This is a generic interface. If you want to call this function on a remote
buffer, you should be able to.

Moreover, remote buffer in-production current use is for Android... So not only
ring_buffer_memory_size() should support them, but they should probably be
actively reported somewhere...

> +
> +	cpu_buffer = buffer->buffers[cpu];
> +	subbuf_size = PAGE_SIZE << READ_ONCE(buffer->subbuf_order);
> +
> +	/* Data sub-buffers plus the reader page. */
> +	size = (READ_ONCE(cpu_buffer->nr_pages) + 1) * subbuf_size;
> +
> +	/* The cached read page, if present, is a full sub-buffer page. */
> +	if (READ_ONCE(cpu_buffer->free_page.data))
> +		size += subbuf_size;
> +
> +	/* The mmap metadata page is a single system page. */
> +	if (READ_ONCE(cpu_buffer->meta_page))
> +		size += PAGE_SIZE;
> +
> +	return size;
> +}
> +
>  /**
>   * ring_buffer_max_event_size - return the max data size of an event
>   * @buffer: The ring buffer.
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c..d4a913ff8a69 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5771,6 +5771,79 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
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
> +	/*
> +	 * temp_buffer is allocated in tracer_alloc_buffers() and is never
> +	 * attached to a trace array. It temporarily holds event data for
> +	 * triggers when tracing is off. Account for its pages too.
> +	 */
> +	if (temp_buffer) {
> +		for_each_tracing_cpu(cpu)
> +			stats.buffers += ring_buffer_memory_size(temp_buffer, cpu);
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
> +
> +static int trace_mem_open(struct inode *inode, struct file *file)
> +{
> +	int ret;
> +
> +	ret = tracing_check_open_get_tr(NULL);
> +	if (ret)
> +		return ret;
> +
> +	return single_open(file, trace_mem_show, inode->i_private);
> +}
> +
> +static const struct file_operations trace_mem_fops = {
> +	.open		= trace_mem_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
>  #define LAST_BOOT_HEADER ((void *)1)
>  
>  static void *l_next(struct seq_file *m, void *v, loff_t *pos)
> @@ -9285,6 +9358,26 @@ static struct notifier_block trace_module_nb = {
>  };
>  #endif /* CONFIG_MODULES */
>  
> +static __init void init_trace_stats_tracefs(void)
> +{
> +	struct dentry *stats_dir;
> +
> +	/*
> +	 * tracer_alloc_buffers() frees tracing_buffer_mask and temp_buffer
> +	 * on failure without NULLing them, so do not iterate tracing CPUs
> +	 * here when tracing failed to initialize.
> +	 */
> +	if (tracing_disabled)
> +		return;
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
> @@ -9293,6 +9386,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
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

-- 
Vincent
