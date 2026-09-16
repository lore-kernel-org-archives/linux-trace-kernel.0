Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B53DD847
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541416; cv=none; b=ZC5ASThgHEkL3lKWVwgx9pBWXBL9jS1vQiFTTDrUw4J88Jo3yy09FcHHDtsV0MCsvpWfoWD+Km/WOLQTi8qvDLkaQTOa03NkWFqoENyZgDKRJZc3BM2q9VFqqACkQxxJR4j+Bj2YYjseRrYXBed8HarXnGSJk2BaLo3qEXZQeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541416; c=relaxed/simple;
	bh=w/AFk4jHZ1BxZstXSRxkGeMbrYS+VC5zoTiMmP2eRBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DyhfW9KsFKU1F6ViGbPkaJ46jHTmpxOLncvzWcA6LKTFgOrKRQ5O3VBUy6C2RUoXmcP+YBpzkLWMjZwELQ/KfUFXt8qHA71EEKJH30S8J7VH2HEJ1IyOFMIrBjuGcEV/1lJxsM1AmGxKLW/ngLwvXWwfKOLf6r/NBrW1wDuvBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nojAqYru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nojAqYru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A331F000FF;
	Wed, 16 Sep 2026 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541414;
	bh=aU7q24Eqpfpep+XPDfTbjusbX4C+pAN5UjaEOyvVbhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nojAqYru8IdceCJEJyTo86nJHpXAuQKsDvqISzgmHzDdLngiGiuWoLPK1soAOjp/9
	 F2LnWVE2CvwJyhqQvV2WgMCxuN41/VhbuhlvBEZxP1upVsrNJamStZc5xoMgbjKsBf
	 6WrxItW8IH+40mQj1tXJkzCO6NrSZER1mkVW306qdE3cXRq5dAequVS4xF4qcY3Evs
	 znI3wnz4Kchts4fPhp4WXeyiQ5bBz8r59B8ErwFW2D7mYrvuAABsrwrXiKA2PLaUJm
	 z3SD+H62Idn0xpbjc3URSf13YTllAV1fC+EcmngR0zVWxd0dctCeZJpDQGzPdYjiuJ
	 0ce++0JpPZ/fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] tracing: add ring-buffer memory usage statistics
 in tracefs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Gao" <gxxa03070307@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260916063322.472172-2-gaoxiang17@xiaomi.com>
References: <20260911155017.3377254-1-gaoxiang17@xiaomi.com>
 <20260916063322.472172-1-gaoxiang17@xiaomi.com>
 <20260916063322.472172-2-gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:50:14 +0000
Message-Id: <20260916065014.A1A331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing: Use-After-Free on temp_buffer and tracing_buffer_mask whe=
n tracer_alloc_buffers fails
--

commit 74cf4963596c0d99d36452a0e504036b25685bcc
Author: Xiang Gao <gxxa03070307@gmail.com>

tracing: add ring-buffer memory usage statistics in tracefs
   =20
This commit adds a tracefs file, trace_stats/memory_usage_kb, to report
the memory consumed by tracing ring buffers. It calculates the memory
usage across the global trace array, instances, and snapshot buffers
using a new function, ring_buffer_memory_size().

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8658cad53cb59..5a023018f612e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[ ... ]
> @@ -5771,6 +5771,62 @@ tracing_total_entries_read(struct file *filp, char=
 __user *ubuf,
>  	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
>  }
> =20
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
> +		*buffers +=3D ring_buffer_memory_size(tr->array_buffer.buffer, cpu);
> +
> +#ifdef CONFIG_TRACER_SNAPSHOT
> +	if (tr->snapshot_buffer.buffer)
> +		*snapshot +=3D ring_buffer_memory_size(tr->snapshot_buffer.buffer, cpu=
);
> +#endif
> +}
> +
> +static struct trace_mem_stats trace_buffers_memory(void)
> +{
> +	struct trace_mem_stats stats =3D {};
> +	struct trace_array *tr;
> +	int cpu;
> +
> +	guard(mutex)(&trace_types_lock);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		for_each_tracing_cpu(cpu)

[Severity: High]
Does this code trigger a use-after-free if tracer_alloc_buffers() fails dur=
ing
early boot?

If tracer_alloc_buffers() fails in kernel/trace/trace.c, it frees both
tracing_buffer_mask and temp_buffer but leaves their global pointers dangli=
ng:

kernel/trace/trace.c:tracer_alloc_buffers() {
    ...
out_free_buffer_mask:
    ...
    ring_buffer_free(temp_buffer);
    free_cpumask_var(tracing_buffer_mask);
    ...
}

Because trace_stats/memory_usage_kb is created unconditionally by
tracer_init_tracefs_work_func(), and its file operations (trace_mem_fops)
do not check the tracing_disabled flag, a local user can still read the fil=
e.

When trace_mem_show() executes trace_buffers_memory(), the
for_each_tracing_cpu() macro will dereference the dangling
tracing_buffer_mask.

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
> +			stats.buffers +=3D ring_buffer_memory_size(temp_buffer, cpu);

[Severity: High]
Does this also cause a use-after-free on temp_buffer in trace_buffers_memor=
y()?

If tracer_alloc_buffers() fails, temp_buffer is freed but its pointer
is never set to NULL on the error path. This branch will evaluate the dangl=
ing
pointer as true and pass it to ring_buffer_memory_size(), which will
dereference the freed memory.

> +	}
> +
> +	return stats;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916063322.4721=
72-1-gaoxiang17@xiaomi.com?part=3D1
