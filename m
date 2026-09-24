Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818235AC34
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240077; cv=none; b=fPQ/ancO+4z7EPBiBqlacRRsPATsTafT7Q0g6mhr8ktI+ZGIdVPG4jG39GRMtx8ilb9N25ErXY5kA+GJ6TFc4gUH+eNN8MgutqY90lwRlX5o6YvVReAcPQAEJ7E/plE2Vg8oJFqEiTMF8nSKtpI3Jq3ynqiwWjob/+d2Bt+qfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240077; c=relaxed/simple;
	bh=twgh3g1PnM87VxqM/4Rt4mbcLaJq2ja0aJ+oUhH0aK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRSe4N4qOVSCXojs+zPlyA2GByA+QGcmYGtVyFgy3OwCHb2MP08VaaU2e6MAsk2PnrFz4HECbZJq8a3HZ3E1wDXqbZAqkM04XonzHIUAF3UC7Lz8QsvKtKujh1FV6n8lNx48PS9wVhuuUe2SAkL5PtzqhgzFMO5r32Qo04sFrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtJHpO2C; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtJHpO2C"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso9988275e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790240074; x=1790844874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bHa1UAdZED9v4xIP0j2HFg/rXQgFI3X0Ub8oRadUOrA=;
        b=vtJHpO2C063MkAGySC/Dsj9UbRw/nO+1qxiyGaRJk2eCdw+l7Qvl+jfWv/xEnWMwnI
         YvTeIDeajgw+NN5aaTh0cJmQxZMB7iyfVIDzVjX6JOmp3GZFpJ5e8JEetmd4pNv5z01D
         kthYMFOF731GHu6S1+7mczVJSBVaJKp+RJqQJnoYOYogtdzAhPlC/BQGmMDjsaIPyUYN
         WXWZt+fPOrycOogGEHPkrhrSfWaIgDe6/4X2Fj1tQZB0cGGgaB1r80e1cjo1hmWE0EQf
         G506y+OLmtn6kzl2nlbmkwzp1n/Y6f270ZA8fPVMIajDe2y05r1W5QOrmHT2oLZkvS/Z
         aB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240074; x=1790844874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHa1UAdZED9v4xIP0j2HFg/rXQgFI3X0Ub8oRadUOrA=;
        b=jVk331bmQ6nJBwX72j7fYdXM1HfA6wfKiOkXEOZxA0RkOL0QyxmlXwqhCQEj7ZyHTY
         KIkjUoOLYNDnJ8JVP69WViqYhBw1APrY+BQfZK3pA3FJ8JiBPZJNpW78PJmanVrIL0WR
         /jWtslVdJdoDIeYei1KbHvOXqkrBxMZ0A8MGpOnR7gGlrGI6WPsyL8uJUB2yYlIbIfK8
         4vIvbsmM7ttvY3Obe2HraEkj24CSPWuMhIrPfKCYjFPuyCvfL7hm8N8t3xP76v4KQ+Ms
         dIWn9T6o2ltP3pWPqsTwBli05XeVJkcim7FVkaGLjh8W5j2RhBFx7OYy6ZFl9zHA75uV
         oWig==
X-Forwarded-Encrypted: i=1; AKwUvBzoKc5+ZPws8lPaT3Vyj9ndb9+js/xcvnf5dwCm/SeNif+MwFSJvurWl8LDRp4UzVVt2G/1k0xfeaITZ3hVPJ1T5y0=@vger.kernel.org
X-Gm-Message-State: AFuF++ldzrhoKS9Bh65XVcJyn8wMAD6at1uqmdYHURHz0JMdIXOq+763
	Rgy1z6MQa8CFLy7kOeAHb6pSwMyN5ZTBGdJsqK+9TBqbZApmoow+u2wq33BVg3eLiQ==
X-Gm-Gg: AYBFou28lUxxXRU6xTgakR98R6LLAxJFlcFLa1kub7SuIboW/WGPyIY+nvBSh5LpH6Q
	HuTaH5Ec5lyxSvwlUo09HQmBksBf1IeJXtzCc+7zDDzdfWj6iCr1RECpKbNTzNxVUv1jqFt/Q35
	OrFLh2C8Gjyjbbkn4FmJSfNq29YrrXN0vFWm3U3zHlQU8zJCI/jSprOdowiucnzjRFcSkVkPC/u
	EhglS7zK5keAD8OwBPsFCd4Z5gaT9DkjAkvnHCwqv9+FJcQdHpOW/eiX47+4GH7F/z1kTL1dPOb
	qyANAUhO8DyDbhDkt9oO+AshNyKhaYDxl4dpcbvBRE3h3HesfamffpYdEf/Cde4dHb4ExLGfyz1
	odY6vPgCpeBWaKQ/X4JLsFIe+xUOsVX31J8oIzr9pP7x6Jelvylej5n1T4qLafdr/Wr72Rkmyos
	caaB7P3kfsOLgEZivdT+hh33xR0wxotMErILLEhvl44KbHc4rKEdHJHnYl6Z4D4yzbigi6UQcZA
	HXGSY0cSBQtoq68qq4YLIQOery/CaB0qnpNGHkGAAL/FRqZyvvQhg==
X-Received: by 2002:a05:600c:34d4:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49fe66d07c9mr27713375e9.12.1790240073084;
        Thu, 24 Sep 2026 01:54:33 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3731fsm115272595e9.2.2026.09.24.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:54:32 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:54:28 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v4 1/2] tracing: add ring-buffer memory usage statistics
 in tracefs
Message-ID: <arTlRPvmR54Fa71o@google.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
 <20260921113047.1152602-1-gaoxiang17@xiaomi.com>
 <20260921113047.1152602-2-gaoxiang17@xiaomi.com>
 <arJNSjKsJ3bK40dH@google.com>
 <20260924102755.02084435309be26f664e3333@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924102755.02084435309be26f664e3333@kernel.org>

On Thu, Sep 24, 2026 at 10:27:55AM +0900, Masami Hiramatsu wrote:
> On Tue, 22 Sep 2026 10:41:30 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > On Mon, Sep 21, 2026 at 07:30:45PM +0800, Xiang Gao wrote:
> > > Report the memory consumed by the tracing ring buffers, rather than the
> > > usable data capacity exposed by buffer_size_kb. Android low-memory
> > > diagnostics need this to attribute the memory used by tracing when
> > > calculating lost RAM.
> > > 
> > > The buffers can be spread across the global trace array, dynamically
> > > created instances, and snapshot buffers. Userspace currently has to
> > > discover and sum every instance, and snapshot memory is not exposed by
> > > the per-instance totals.
> > > 
> > > Add a trace_stats directory with memory_usage_kb reporting:
> > > 
> > >   buffers:
> > >   snapshot_buffers:
> > > 
> > > covering the global trace array, all instances, and the bootstrapping
> > > temp_buffer across all CPUs.
> > > 
> > > The values account for the full pages backing the data sub-buffers and
> > > reader page, plus the cached read page and mmap metadata page when
> > > present. Slab-allocated ring-buffer metadata is not included, as it is
> > > already reported through Slab and would be double-counted when
> > > subtracting tracing memory from lost RAM. Remote buffers, whose pages
> > > are externally owned, report zero.
> > 
> > For the next version, it is good practice to __not__ in-reply-to with previous
> > version.
> > 
> 
> Indeed. This is hard to find which is the latest version.
> 
> > > 
> > > Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> > > ---
> > >  Documentation/trace/ftrace.rst | 12 +++++
> > >  include/linux/ring_buffer.h    |  1 +
> > >  kernel/trace/ring_buffer.c     | 41 +++++++++++++++
> > >  kernel/trace/trace.c           | 95 ++++++++++++++++++++++++++++++++++
> > >  4 files changed, 149 insertions(+)
> > > 
> > > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > > index 7261f25f8b4b..99ddfe26b7cd 100644
> > > --- a/Documentation/trace/ftrace.rst
> > > +++ b/Documentation/trace/ftrace.rst
> > > @@ -218,6 +218,18 @@ of ftrace. Here is a list of some of the key files:
> > >  
> > >  	This displays the total combined size of all the trace buffers.
> > >  
> > > +  trace_stats/memory_usage_kb:
> > > +
> > > +	This reports the memory consumed by the ring buffers, as opposed to
> > > +	the usable data capacity shown by buffer_size_kb. The value covers the
> > > +	main and snapshot buffers of the global trace array and all tracing
> > > +	instances. It does not include slab-allocated ring-buffer metadata.
> > > +
> > > +	Output::
> > > +
> > > +	    buffers: ...
> > > +	    snapshot_buffers: ...
> > > +
> > >    buffer_subbuf_size_kb:
> > >  
> > >  	This sets or displays the sub buffer size. The ring buffer is broken up
> > > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > > index eac3e9080c3c..96b99e6757d4 100644
> > > --- a/include/linux/ring_buffer.h
> > > +++ b/include/linux/ring_buffer.h
> > > @@ -167,6 +167,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
> > >  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
> > >  
> > >  unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
> > > +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
> > >  unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
> > >  
> > >  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 04bb94c29f58..efb88bf8970c 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -6559,6 +6559,47 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
> > >  }
> > >  EXPORT_SYMBOL_GPL(ring_buffer_size);
> > >  
> > > +/**
> > > + * ring_buffer_memory_size - return the memory used by the buffer (in bytes)
> > > + * @buffer: The ring buffer.
> > > + * @cpu: The CPU to get ring buffer memory from.
> > > + *
> > > + * Returns the page-allocator memory consumed by @cpu, including the data
> > > + * sub-buffers, the reader page, the cached read page, and the mmap
> > > + * metadata page. Unlike ring_buffer_size(), which reports the usable data
> > > + * capacity, this accounts for the full pages allocated to the buffer.
> > > + * Remote buffers do not own page-allocator memory and report zero.
> > > + */
> > > +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu)
> > > +{
> > > +	struct ring_buffer_per_cpu *cpu_buffer;
> > > +	unsigned long subbuf_size;
> > > +	unsigned long size;
> > > +
> > > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > > +		return 0;
> > > +
> > > +	/* Remote buffers use externally owned memory. */
> > > +	if (buffer->remote)
> > > +		return 0;
> 
> For the persistent ring buffer, you also need to check `buffer->range_addr_start`.
> That is a reserved memory, which is outside of page allocator.
> 
> > 
> > This is a generic interface. If you want to call this function on a remote
> > buffer, you should be able to.
> 
> But as the comment said, this function returns the size of page-allocator
> memory. Is remote ring buffer allocated from host?

It is down to the trace_remote implementer where the memory comes from, but
right now, all remote ring buffer are allocated from the buddy allocator.

Although, even coming from a carveout, the low-level function should probably
return something in any case, as it has all the informations it needs and to
stay as generic as possible.

Then, the caller (trace_stat) should know if the information is relevant or not,
or where to account for it. (probably with TRACE_ARRAY_FL_ flags ?). trace_stat
shouldn't report only what's relevant for Android. It can however split the
report between persistent ring-buffers and the others.

Overall, we could have

cat trace_mem

  main:
  instances:
  snapshots:
  persistents: 
  remotes:

  total_system:
  total_carveout:

Which I believe would be a more accurate picture: First the memory sorted by
"type" of buffers and then by "type of memory".

 
> 
> > 
> > Moreover, remote buffer in-production current use is for Android... So not only
> > ring_buffer_memory_size() should support them, but they should probably be
> > actively reported somewhere...
> 
> Maybe we should have different size accounting interface for remote buffer
> and persistent buffer.

For the remote, it should probably sit in trace_remote.c, which can call
ring_buffer_memory_size(). trace_stat can then query the memory size from
trace_remote.

And actually I have a pending series where I keep the list of trace_remote [1]
which would be a prerequisite.

[1] https://lore.kernel.org/all/20260817135517.3919534-2-vdonnefort@google.com/

> 
> Thanks,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Vincent
