Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F754763;
	Thu, 24 Sep 2026 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213281; cv=none; b=cGRawWeZSwFDbWcnWhEidtZzy/q6M7n7wpbBnlPflqnQmODs5WKSH4Jiz2CoUkEmHMB/Dwpp293HM7WBjE+NXXxrdiXxvZBKk37LaE/B4AqH2uaq3aonA8MMYRfirVZ0fTt7+mVrt21hJVwE9y4K7sTG55C7Rft4gYzTcnkjEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213281; c=relaxed/simple;
	bh=YsYAqoYAyX+uA6mAsV5A9jca7BEbn0gPFbYSEw2uvHI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tu4/pLIntLOdJnpTVWcCqR/bfg1tFs1zc3FSEHbB9975CmFrkFi8R8ec7yqDF48J92wFfac2P9DpSTXmxtAebNF7NSrNcoFLGKRhtL6MFd3kwfErWVkZAZKdIk5NHdDlprdIkAj/oi0PJYCfmbVavSYzOKtUap1bOibUB+5q4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2uZ8Oag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2uZ8Oag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD7D1F000FF;
	Thu, 24 Sep 2026 01:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213280;
	bh=WLIAsKg6Rj0NVELrPnn6n6V8aDuJE1I+Q+mT9BMTfJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f2uZ8Oag3jONB62ALuOxp+2rcwF7yt7bkl4jfNDrh9K1wnUt28irsS401RjLFO8iL
	 PKAnMlO3dFyBttTWzPVa82VLiLfRU6Ava1ftTKo0yEboN1YS5dzBddYNQB7Bd3JmGW
	 KPY0xujl1e4wSxKJPfoV6qxyRSopGuvLFkvTCyb4R3j8ebAGEOs0DXk/Nry3we8K33
	 C/C/ai2fYV3cIl0SwcQ5MV1yxbEe6aabHS7elUjM2qNQGyWz008vvV09QCVH3K8mk3
	 ZLp9uf4uLDFCQNam+mVO/MXzeh3uFVoCsKdE76CAWEB1VGGlT6vBO0I4IGAHBbWv/o
	 c18+OEQsiJaHw==
Date: Thu, 24 Sep 2026 10:27:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lorenzo Stoakes <ljs@kernel.org>, gao xu
 <gaoxu2@honor.com>, yinchuang1@xiaomi.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Xiang Gao
 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v4 1/2] tracing: add ring-buffer memory usage statistics
 in tracefs
Message-Id: <20260924102755.02084435309be26f664e3333@kernel.org>
In-Reply-To: <arJNSjKsJ3bK40dH@google.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-2-gaoxiang17@xiaomi.com>
	<arJNSjKsJ3bK40dH@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 10:41:30 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Mon, Sep 21, 2026 at 07:30:45PM +0800, Xiang Gao wrote:
> > Report the memory consumed by the tracing ring buffers, rather than the
> > usable data capacity exposed by buffer_size_kb. Android low-memory
> > diagnostics need this to attribute the memory used by tracing when
> > calculating lost RAM.
> > 
> > The buffers can be spread across the global trace array, dynamically
> > created instances, and snapshot buffers. Userspace currently has to
> > discover and sum every instance, and snapshot memory is not exposed by
> > the per-instance totals.
> > 
> > Add a trace_stats directory with memory_usage_kb reporting:
> > 
> >   buffers:
> >   snapshot_buffers:
> > 
> > covering the global trace array, all instances, and the bootstrapping
> > temp_buffer across all CPUs.
> > 
> > The values account for the full pages backing the data sub-buffers and
> > reader page, plus the cached read page and mmap metadata page when
> > present. Slab-allocated ring-buffer metadata is not included, as it is
> > already reported through Slab and would be double-counted when
> > subtracting tracing memory from lost RAM. Remote buffers, whose pages
> > are externally owned, report zero.
> 
> For the next version, it is good practice to __not__ in-reply-to with previous
> version.
> 

Indeed. This is hard to find which is the latest version.

> > 
> > Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> > ---
> >  Documentation/trace/ftrace.rst | 12 +++++
> >  include/linux/ring_buffer.h    |  1 +
> >  kernel/trace/ring_buffer.c     | 41 +++++++++++++++
> >  kernel/trace/trace.c           | 95 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 149 insertions(+)
> > 
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 7261f25f8b4b..99ddfe26b7cd 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -218,6 +218,18 @@ of ftrace. Here is a list of some of the key files:
> >  
> >  	This displays the total combined size of all the trace buffers.
> >  
> > +  trace_stats/memory_usage_kb:
> > +
> > +	This reports the memory consumed by the ring buffers, as opposed to
> > +	the usable data capacity shown by buffer_size_kb. The value covers the
> > +	main and snapshot buffers of the global trace array and all tracing
> > +	instances. It does not include slab-allocated ring-buffer metadata.
> > +
> > +	Output::
> > +
> > +	    buffers: ...
> > +	    snapshot_buffers: ...
> > +
> >    buffer_subbuf_size_kb:
> >  
> >  	This sets or displays the sub buffer size. The ring buffer is broken up
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index eac3e9080c3c..96b99e6757d4 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -167,6 +167,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
> >  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
> >  
> >  unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
> > +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
> >  unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
> >  
> >  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 04bb94c29f58..efb88bf8970c 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -6559,6 +6559,47 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(ring_buffer_size);
> >  
> > +/**
> > + * ring_buffer_memory_size - return the memory used by the buffer (in bytes)
> > + * @buffer: The ring buffer.
> > + * @cpu: The CPU to get ring buffer memory from.
> > + *
> > + * Returns the page-allocator memory consumed by @cpu, including the data
> > + * sub-buffers, the reader page, the cached read page, and the mmap
> > + * metadata page. Unlike ring_buffer_size(), which reports the usable data
> > + * capacity, this accounts for the full pages allocated to the buffer.
> > + * Remote buffers do not own page-allocator memory and report zero.
> > + */
> > +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +	unsigned long subbuf_size;
> > +	unsigned long size;
> > +
> > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +		return 0;
> > +
> > +	/* Remote buffers use externally owned memory. */
> > +	if (buffer->remote)
> > +		return 0;

For the persistent ring buffer, you also need to check `buffer->range_addr_start`.
That is a reserved memory, which is outside of page allocator.

> 
> This is a generic interface. If you want to call this function on a remote
> buffer, you should be able to.

But as the comment said, this function returns the size of page-allocator
memory. Is remote ring buffer allocated from host?

> 
> Moreover, remote buffer in-production current use is for Android... So not only
> ring_buffer_memory_size() should support them, but they should probably be
> actively reported somewhere...

Maybe we should have different size accounting interface for remote buffer
and persistent buffer.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
