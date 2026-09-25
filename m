Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C223A1B5;
	Fri, 25 Sep 2026 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790298555; cv=none; b=jHk3Igxa7xW9UQNonFKxUQ08EOvgVeRNn2WCbrR4nnAF3xsMwz3PtefBvZEFbCr5UJFLnn5VLvwVSmYRiD/fu3rC6qDkcUh58d15LBmDJbRJSS4lFf6MhThQ/tdo+XLWTNyMIPF8n94/XI7ly9eJ19AR559ExsQQ4AnMZA9X5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790298555; c=relaxed/simple;
	bh=qB6fHJOTfA6PQMD74N16cYuSENurpQNubc9j37qBuJE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=svOJCUJhhXtYuF8qaZeAH0+0AG3/okrfYhiny54tjg3V8jRzwxKJGE1QgVsOtgmDNktcCuKEBs5YoFO3utPevlAGOTVDBrlnlhQ99h8NnP5SS89D9wK3vY4vSyLZ+/dbbWfxHJtksWYXEMdjYtgRrdJSGLy8vU0T+FJztLPphVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AATyQ69w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AATyQ69w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD311F000FF;
	Fri, 25 Sep 2026 01:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790298553;
	bh=9Ij28vRxIvZHuJPgdpGDxrNhsIui5GPI4jf+cAlvS9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AATyQ69wrNPgSQE/U7XdC3b/4eROqQpEMX+SLjdrvUhI6oPUszCGEmKzMweLjzGyZ
	 ergSo9z8dg3k65hHMU7WntNe9Br2/gteQWxT81qyoDeNL9g326150pP6n5cylyFXHf
	 wPGsupgbr0zGFONz9Q+JD8WMkWBqS+91e9fjUaSPagkoSlXui6hQphAaIxS/D1ivoh
	 ymlwhn9jNc1U5Sr++q6dfFmg7og/gmXH7llH0b7PMKQBByTSXcrzW8omnQAIcqM/ni
	 TPQn4HJ0UVXU7ifVcs6c5OUUuQLM7iNCLbKBI9fjYe41S3MtCcPVPPH4EDIadDaT4R
	 Mhnb2eeYTKs9g==
Date: Fri, 25 Sep 2026 10:09:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lorenzo Stoakes
 <ljs@kernel.org>, gao xu <gaoxu2@honor.com>, yinchuang1@xiaomi.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Xiang Gao
 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v4 1/2] tracing: add ring-buffer memory usage statistics
 in tracefs
Message-Id: <20260925100908.66c46353e5a2abeb73b1e15a@kernel.org>
In-Reply-To: <arTlRPvmR54Fa71o@google.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-2-gaoxiang17@xiaomi.com>
	<arJNSjKsJ3bK40dH@google.com>
	<20260924102755.02084435309be26f664e3333@kernel.org>
	<arTlRPvmR54Fa71o@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 09:54:28 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Thu, Sep 24, 2026 at 10:27:55AM +0900, Masami Hiramatsu wrote:
> > On Tue, 22 Sep 2026 10:41:30 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > On Mon, Sep 21, 2026 at 07:30:45PM +0800, Xiang Gao wrote:
> > > > Report the memory consumed by the tracing ring buffers, rather than the
> > > > usable data capacity exposed by buffer_size_kb. Android low-memory
> > > > diagnostics need this to attribute the memory used by tracing when
> > > > calculating lost RAM.
> > > > 
> > > > The buffers can be spread across the global trace array, dynamically
> > > > created instances, and snapshot buffers. Userspace currently has to
> > > > discover and sum every instance, and snapshot memory is not exposed by
> > > > the per-instance totals.
> > > > 
> > > > Add a trace_stats directory with memory_usage_kb reporting:
> > > > 
> > > >   buffers:
> > > >   snapshot_buffers:
> > > > 
> > > > covering the global trace array, all instances, and the bootstrapping
> > > > temp_buffer across all CPUs.
> > > > 
> > > > The values account for the full pages backing the data sub-buffers and
> > > > reader page, plus the cached read page and mmap metadata page when
> > > > present. Slab-allocated ring-buffer metadata is not included, as it is
> > > > already reported through Slab and would be double-counted when
> > > > subtracting tracing memory from lost RAM. Remote buffers, whose pages
> > > > are externally owned, report zero.
> > > 
> > > For the next version, it is good practice to __not__ in-reply-to with previous
> > > version.
> > > 
> > 
> > Indeed. This is hard to find which is the latest version.
> > 
> > > > 
> > > > Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> > > > ---
> > > >  Documentation/trace/ftrace.rst | 12 +++++
> > > >  include/linux/ring_buffer.h    |  1 +
> > > >  kernel/trace/ring_buffer.c     | 41 +++++++++++++++
> > > >  kernel/trace/trace.c           | 95 ++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 149 insertions(+)
> > > > 
> > > > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > > > index 7261f25f8b4b..99ddfe26b7cd 100644
> > > > --- a/Documentation/trace/ftrace.rst
> > > > +++ b/Documentation/trace/ftrace.rst
> > > > @@ -218,6 +218,18 @@ of ftrace. Here is a list of some of the key files:
> > > >  
> > > >  	This displays the total combined size of all the trace buffers.
> > > >  
> > > > +  trace_stats/memory_usage_kb:
> > > > +
> > > > +	This reports the memory consumed by the ring buffers, as opposed to
> > > > +	the usable data capacity shown by buffer_size_kb. The value covers the
> > > > +	main and snapshot buffers of the global trace array and all tracing
> > > > +	instances. It does not include slab-allocated ring-buffer metadata.
> > > > +
> > > > +	Output::
> > > > +
> > > > +	    buffers: ...
> > > > +	    snapshot_buffers: ...
> > > > +
> > > >    buffer_subbuf_size_kb:
> > > >  
> > > >  	This sets or displays the sub buffer size. The ring buffer is broken up
> > > > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > > > index eac3e9080c3c..96b99e6757d4 100644
> > > > --- a/include/linux/ring_buffer.h
> > > > +++ b/include/linux/ring_buffer.h
> > > > @@ -167,6 +167,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
> > > >  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
> > > >  
> > > >  unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
> > > > +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
> > > >  unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
> > > >  
> > > >  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
> > > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > > index 04bb94c29f58..efb88bf8970c 100644
> > > > --- a/kernel/trace/ring_buffer.c
> > > > +++ b/kernel/trace/ring_buffer.c
> > > > @@ -6559,6 +6559,47 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(ring_buffer_size);
> > > >  
> > > > +/**
> > > > + * ring_buffer_memory_size - return the memory used by the buffer (in bytes)
> > > > + * @buffer: The ring buffer.
> > > > + * @cpu: The CPU to get ring buffer memory from.
> > > > + *
> > > > + * Returns the page-allocator memory consumed by @cpu, including the data
> > > > + * sub-buffers, the reader page, the cached read page, and the mmap
> > > > + * metadata page. Unlike ring_buffer_size(), which reports the usable data
> > > > + * capacity, this accounts for the full pages allocated to the buffer.
> > > > + * Remote buffers do not own page-allocator memory and report zero.
> > > > + */
> > > > +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu)
> > > > +{
> > > > +	struct ring_buffer_per_cpu *cpu_buffer;
> > > > +	unsigned long subbuf_size;
> > > > +	unsigned long size;
> > > > +
> > > > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > > > +		return 0;
> > > > +
> > > > +	/* Remote buffers use externally owned memory. */
> > > > +	if (buffer->remote)
> > > > +		return 0;
> > 
> > For the persistent ring buffer, you also need to check `buffer->range_addr_start`.
> > That is a reserved memory, which is outside of page allocator.
> > 
> > > 
> > > This is a generic interface. If you want to call this function on a remote
> > > buffer, you should be able to.
> > 
> > But as the comment said, this function returns the size of page-allocator
> > memory. Is remote ring buffer allocated from host?
> 
> It is down to the trace_remote implementer where the memory comes from, but
> right now, all remote ring buffer are allocated from the buddy allocator.

Ah, I got it, its size should be reported via ring_buffer_memory_size().
Hmm, maybe we should add a callback for each trace instance so that it
can return the actual size and the attribute (host memory, guest memory,
reserved memory, or device memory (e.g. GPU memory?))

> 
> Although, even coming from a carveout, the low-level function should probably
> return something in any case, as it has all the informations it needs and to
> stay as generic as possible.
> 
> Then, the caller (trace_stat) should know if the information is relevant or not,
> or where to account for it. (probably with TRACE_ARRAY_FL_ flags ?). trace_stat
> shouldn't report only what's relevant for Android. It can however split the
> report between persistent ring-buffers and the others.

Yeah, this should return the attribute flag with the memory size.

> 
> Overall, we could have
> 
> cat trace_mem
> 
>   main:
>   instances:
>   snapshots:
>   persistents: 
>   remotes:
> 
>   total_system:
>   total_carveout:
> 
> Which I believe would be a more accurate picture: First the memory sorted by
> "type" of buffers and then by "type of memory".

Agreed.

> 
>  
> > 
> > > 
> > > Moreover, remote buffer in-production current use is for Android... So not only
> > > ring_buffer_memory_size() should support them, but they should probably be
> > > actively reported somewhere...
> > 
> > Maybe we should have different size accounting interface for remote buffer
> > and persistent buffer.
> 
> For the remote, it should probably sit in trace_remote.c, which can call
> ring_buffer_memory_size(). trace_stat can then query the memory size from
> trace_remote.

I think the copy of the persistent ring buffer (backup instance) could be
implemented as remote, but the persistent ring buffer itself is not remote
because it is writable. (copy ring buffer is actually like remote, it is
read only, and it should be auto unloaded.)

Thank you,

> 
> And actually I have a pending series where I keep the list of trace_remote [1]
> which would be a prerequisite.
> 
> [1] https://lore.kernel.org/all/20260817135517.3919534-2-vdonnefort@google.com/
> 
> > 
> > Thanks,
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> -- 
> Vincent


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
