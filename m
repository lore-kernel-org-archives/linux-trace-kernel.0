Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E543DA4C;
	Thu, 26 Feb 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124732; cv=none; b=QolA0rzNybU03DsHBOWmQcU0qoxOxTOoD9QP8tn08V6G/NAvRoCOlhkRweAoJCkGzlr4jBHFKfFy6W5agIvn1AMEIRw76domNlsiLcNXBLAgNBefenlF6IFQWNSODbWFjyR1L1JmFHRi9k67dkcfG5TKAlPTZw6o6JLjfv08MSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124732; c=relaxed/simple;
	bh=okt8i/bFqzeZQpyJ+vcrA7LvdTGAt3oKtfcW92dj/qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHOCsAhTXbRJuTuo6ZGQ8GRP7S3DdrdUr3VmD6hWCWYWNYFqbzlC1SbHvN0I5x+gogp+Rf0QzFbUIJm9LV1b75yw9KW3DabTXMw1C8TyN77zxVK7DUgQ6dS/DkQNwLkM2z8XytiG+IJHvwhQfLpW0CqVWlLKOOgKp+1nrsrZdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 2642FB8455;
	Thu, 26 Feb 2026 16:52:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 08DD780021;
	Thu, 26 Feb 2026 16:52:06 +0000 (UTC)
Date: Thu, 26 Feb 2026 11:52:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Qing Wang <wangqing7171@gmail.com>
Cc: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
Message-ID: <20260226115229.7111b070@gandalf.local.home>
In-Reply-To: <20260226091657.895403-1-wangqing7171@gmail.com>
References: <699fc6d3.a00a0220.21906d.0073.GAE@google.com>
	<20260226091657.895403-1-wangqing7171@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 08DD780021
X-Stat-Signature: ibdqrysftgxtbao9kctptuq8raf1ucch
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JweBpFadc3XAu7pWX6gjtQf2Zx3n0hqo=
X-HE-Tag: 1772124726-687430
X-HE-Meta: U2FsdGVkX1+kJhcPd99faAipHim0fIXcEs8MTr6zqDY/xXrpbYjnu6gj/smozfMc1rvu1jfLoimfyCXWAa9nv/zro9iFki23a6dR09mHfRloYoeONVTQpdJUrXipOSV5Pg18lo73Ak1Kdv5usl4lDdlS8hJx9kPJ7rGqTP9Z+HRx3fdFZ//kLSbMDfAAlJ5rzEYTl1nUp0bDrBoM4Ef/AIjtePZt/xmjFBD+949uCTwOb8UGD5fUpDnFcYi1H3A4c86gCwwFZZfy18lkY40sZm9uDFBpXnhtmrtXWxZc/bPTr5lw/hZy3kyOaIu9kIqN+ivzz8/TMqzMtocarCfZOPpSr21qdNHP

On Thu, 26 Feb 2026 17:16:57 +0800
Qing Wang <wangqing7171@gmail.com> wrote:

> #syz test
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 876358cfe1b1..07f5127c8255 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -248,6 +248,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
>  
>  int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  		    struct vm_area_struct *vma);
> +void ring_buffer_map_user_mapped_inc(struct trace_buffer *buffer, int cpu);
>  int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
>  int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
>  #endif /* _LINUX_RING_BUFFER_H */
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index f16f053ef77d..59516b89e612 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7310,6 +7310,30 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  	return err;
>  }
>  
> +/**
> + * ring_buffer_map_user_mapped_inc - Increment user_mapped counter for VMA duplication
> + * @buffer: The ring buffer
> + * @cpu: The CPU of the ring buffer to increment
> + *
> + * This is called when a VMA is duplicated (e.g., on fork()) to increment
> + * the user_mapped counter without remapping pages.

OK, so the issue is that the ring buffer was mapped, then the process that
mapped it forked duplicating the mappings. And then on exit (or unmap),
the first one to unmap the buffer will cause the ring buffer to think it
was fully unmapped causing the next one to unmap to trigger the error.


> + */
> +void ring_buffer_map_user_mapped_inc(struct trace_buffer *buffer, int cpu)

Let's call this ring_buffer_map_dup() to be consistent with ring_buffer_map().

inc would expect a dec, but dup() is more of what it is doing.

> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return;

I wonder if this fails we should warn. As it should never be called unless
it was successfully mapped.

> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
> +	guard(mutex)(&cpu_buffer->mapping_lock);
> +
> +	if (cpu_buffer->user_mapped)
> +		__rb_inc_dec_mapped(cpu_buffer, true);

Probably should also warn if user_mapped is not set. Again, this should not
ever not be mapped if we get here.

-- Steve

> +}
> +EXPORT_SYMBOL_GPL(ring_buffer_map_user_mapped_inc);
> +
>  int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 23de3719f495..b2ab95ed8d41 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8213,6 +8213,14 @@ static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
>  static inline void put_snapshot_map(struct trace_array *tr) { }
>  #endif
>  
> +static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
> +{
> +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +
> +	ring_buffer_map_user_mapped_inc(iter->array_buffer->buffer, iter->cpu_file);
> +}
> +
>  static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
>  {
>  	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> @@ -8232,6 +8240,7 @@ static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long a
>  }
>  
>  static const struct vm_operations_struct tracing_buffers_vmops = {
> +	.open		= tracing_buffers_mmap_open,
>  	.close		= tracing_buffers_mmap_close,
>  	.may_split      = tracing_buffers_may_split,
>  };

