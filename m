Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA656B63
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDUWT0PU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e586a62f7so31349865e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705050787; x=1705655587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1EgXaRaTUet4TEXGVTFAunKXdsXPqv3B+ZztFe87RQ=;
        b=bDUWT0PUubl7IXlxAdtKF3qx7UDYNhmM9ngSGTI4oC5FjLp9K1XRSMU09GUoCBhEKC
         gyxWSOT86xZpZQtnkuNIqPhbOv84UFvtATfBfBYZq9Rgzhwjrn+4Z0Yg6tyGxNEzW/wh
         1U/gZKGDQJY9MZfvV4nuXYCkRZZ4VQglmF+YJStr9uohI8lRS1l2RXonDWwS+fZMNKoW
         HQTva2zDtsLwVs1dxbvs1/IHP8hz5jAkuyfbLgkqSVgFkGEWoUnrc66YLNioFY0xwRwl
         XzqTCpSla/Fac2ob7oM27qptDQt/r/IZVSj3SwuudQrzb73HP0LDG2c1tjI6LjB0QOu+
         3+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705050787; x=1705655587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1EgXaRaTUet4TEXGVTFAunKXdsXPqv3B+ZztFe87RQ=;
        b=uAcTFEHurttPy602HrwX/acndF7VggUJxl6B+pKwDuNlF0FuD49TGp+zlt+QwfoYrR
         35RuQ7Kpl4PpfkvGSO6178Jwrb9WbvvX4iQ03H3PKSfEKXIunedgUcQsJS6UZODHraea
         rOyWPjRSudZbRHew6zeU52bxRtx/3F9fyvdpo6FeryA/HE42tMItO1a3/Ka/56a7koku
         qie21jCiUOD+buAjXbDHc+jIn9w0kBoUiiJ9QIw4WFPuaFCcBvCGvkNex60zNt8k+dq4
         d8t0qZsy7UUSlz+hgZwWKOiQvYaBY6sCuUtTektRdbmLmZJaeRGn+3PFhLHaX/hEDYKo
         29CA==
X-Gm-Message-State: AOJu0Yy1uod9fYFOlqYuPk9DSJKvHfr55fiVo96PPNj19/Co8701mdXB
	FfBFptP94ozwOIrGJopTqjdYHV09q5wM
X-Google-Smtp-Source: AGHT+IFdVEbldrn6GQS2XfH/1UYqKPpyHh+bndsCodBDUSD8g0kbmLd8FP3JUwTXDMwF9sy7py/nGw==
X-Received: by 2002:a05:600c:4589:b0:40e:43ab:4a1d with SMTP id r9-20020a05600c458900b0040e43ab4a1dmr612027wmo.163.1705050786878;
        Fri, 12 Jan 2024 01:13:06 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id az8-20020a05600c600800b0040e49045e0asm4991094wmb.48.2024.01.12.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:13:06 -0800 (PST)
Date: Fri, 12 Jan 2024 09:13:02 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZaECnv7EJHo6sqcT@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
 <20240111161712.1480333-3-vdonnefort@google.com>
 <c3dba53f-66de-43f5-9b82-38aa807da67a@efficios.com>
 <20240111181814.362c42cf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111181814.362c42cf@gandalf.local.home>

On Thu, Jan 11, 2024 at 06:23:20PM -0500, Steven Rostedt wrote:
> On Thu, 11 Jan 2024 11:34:58 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> 
> > The LTTng kernel tracer has supported mmap'd buffers for nearly 15 years [1],
> > and has a lot of similarities with this patch series.
> > 
> > LTTng has the notion of "subbuffer id" to allow atomically exchanging a
> > "reader" extra subbuffer with the subbuffer to be read. It implements
> > "get subbuffer" / "put subbuffer" ioctls to allow the consumer (reader)
> > to move the currently read subbuffer position. [2]
> > 
> > It would not hurt to compare your approach to LTTng and highlight
> > similarities/differences, and the rationale for the differences.
> > 
> > Especially when it comes to designing kernel ABIs, it's good to make sure
> > that all bases are covered, because those choices will have lasting impacts.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > [1] https://git.lttng.org/?p=lttng-modules.git;a=blob;f=src/lib/ringbuffer/ring_buffer_mmap.c
> > [2] https://git.lttng.org/?p=lttng-modules.git;a=blob;f=src/lib/ringbuffer/ring_buffer_vfs.c
> > 
> 
> Hi Mathieu,
> 
> Thanks for sharing!
> 
> As we discussed a little bit in the tracing meeting we do somethings
> differently but very similar too ;-)
> 
> The similarities as that all the sub-buffers are mapped. You have a
> reader-sub-buffer as well.
> 
> The main difference is that you use an ioctl() that returns where to find
> the reader-sub-buffer, where our ioctl() is just "I'm done, get me a new
> reader-sub-buffer". Ours will update the meta page.
> 
> Our meta page looks like this:
> 
> > +struct trace_buffer_meta {
> > +	unsigned long	entries;
> > +	unsigned long	overrun;
> > +	unsigned long	read;
> 
> If start tracing: trace-cmd start -e sched_switch and do:
> 
>  ~ cat /sys/kernel/tracing/per_cpu/cpu0/stats 
> entries: 14
> overrun: 0
> commit overrun: 0
> bytes: 992
> oldest event ts: 84844.825372
> now ts: 84847.102075
> dropped events: 0
> read events: 0
> 
> You'll see similar to the above.
> 
>  entries = entries
>  overrun = overrun
>  read = read
> 
> The above "read" is total number of events read.
> 
> Pretty staight forward ;-)
> 
> 
> > +
> > +	unsigned long	subbufs_touched;
> > +	unsigned long	subbufs_lost;
> > +	unsigned long	subbufs_read;
> 
> Now I'm thinking we may not want this exported, as I'm not sure it's useful.

touched and lost are not useful now, but it'll be for my support of the
hypervisor tracing, that's why I added them already.

subbufs_read could probably go away though as even in that case I can track that
in the reader.

> 
> Vincent, talking with Mathieu, he was suggesting that we only export what
> we really need, and I don't think we need the above. Especially since they
> are not exposed in the stats file.
> 
> 
> > +
> > +	struct {
> > +		unsigned long	lost_events;
> > +		__u32		id;
> > +		__u32		read;
> > +	} reader;
> 
> The above is definitely needed, as all of it is used to read the
> reader-page of the sub-buffer.
> 
> lost_events is the number of lost events that happened before this
> sub-buffer was swapped out.
> 
> Hmm, Vincent, I just notice that you update the lost_events as:
> 
> > +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > +{
> > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > +
> > +	WRITE_ONCE(meta->entries, local_read(&cpu_buffer->entries));
> > +	WRITE_ONCE(meta->overrun, local_read(&cpu_buffer->overrun));
> > +	WRITE_ONCE(meta->read, cpu_buffer->read);
> > +
> > +	WRITE_ONCE(meta->subbufs_touched, local_read(&cpu_buffer->pages_touched));
> > +	WRITE_ONCE(meta->subbufs_lost, local_read(&cpu_buffer->pages_lost));
> > +	WRITE_ONCE(meta->subbufs_read, local_read(&cpu_buffer->pages_read));
> > +
> > +	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
> > +	WRITE_ONCE(meta->reader.id, cpu_buffer->reader_page->id);
> > +	WRITE_ONCE(meta->reader.lost_events, cpu_buffer->lost_events);
> > +}
> 
> The lost_events may need to be handled differently, as it doesn't always
> get cleared. So it may be stale data.

My idea was to check this value after the ioctl(). If > 0 then events were lost
between the that ioctl() and the previous swap.

But now if with "[PATCH] ring-buffer: Have mmapped ring buffer keep track of
missed events" we put this information in the page itself, we can get rid of
this field.

> 
> 
> > +
> > +	__u32		subbuf_size;
> > +	__u32		nr_subbufs;
> 
> This gets is the information needed to read the mapped ring buffer.
> 
> > +
> > +	__u32		meta_page_size;
> > +	__u32		meta_struct_len;
> 
> The ring buffer gets mapped after "meta_page_size" and this structure is
> "meta_struct_len" which will change if we add new data to it.
> 
> > +};
> 
> -- Steve
