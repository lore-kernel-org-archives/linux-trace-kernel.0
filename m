Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E933A1E6C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188884; cv=none; b=O4V+h+FEEnK3ijAlOQcPmz9d5gjrij/ANgxs90jsSlInICXsinlvVbVztB8KMPtcFuIIlGKaDcyG60A1ErUtzQWxgkrXp3FucSXD1P8gu3KBgWEha8ayDqq3N4R5nCFBseWYC8Ijdm8ahde/t9QxTKI54Cn+joQ0sqX8B1KYJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188884; c=relaxed/simple;
	bh=NVckoVnayRCDg2lxO8A99rAy12Dz1VRVrDZC3M7E05Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4QH6KDPQC0XJ2CdLTWD9X9Kfp/cTwve6+53bIAUZ+datc+BjhgxT7SIp+XxDET/8kckku4CcoLIImnpMi8T7cpp4F93ZQDt2QyZs+FADRPpw+dZ4DrpaKk2HIQEucjOd87DNrgGZIvGQIHlUnTfdWtKOlmYsDAFOdIwMrpNhJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdx8rsuL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdx8rsuL"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1282753f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772188882; x=1772793682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=agntuRFRcyFCg1UlMZtKJYzJVOGWEdQf/hNuyCKdXO0=;
        b=sdx8rsuLHzo8efQiXbpT/pj9NFvwIYvnSfnSfCl7lzHcC2ugv5VVZW5XE5CuTgQkIl
         gfJbRVij8ErGm04nDoktFtSrqiODypMxNIZL8hnWUOcmby6XLz1X/efi9B+7Xsa9wDEk
         4L9h0LjiGAGRMXLe3WweOHFVrQm+jVDObTQLnhwvzZta3moKJwe1GrsRyvbo3OYpqtbR
         w/LM/lKo28BLIRVtsQttkcpHqtm8lVUk5Ad+YUFvGSiSzstA0rpzqhjXZXC8TNr04ICM
         WgKwYR9pz7jB35PD7qzNLM2nvDy0zELTfiF59NwbtgDqB/hE20aOmpJlDPERqaep8qRN
         3S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188882; x=1772793682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agntuRFRcyFCg1UlMZtKJYzJVOGWEdQf/hNuyCKdXO0=;
        b=tidZ9ZcKPyh7qll3Lj8XVqwg7fzIMzubZkvoRuEmW5yYwOUQKua9+ubycx223G1/QA
         Qvi65p7VoHs9jzm815h/haoklz1j+GhZ+NImvCmF1CISdUHkdYLHET4wMx+0oBw4KIte
         lMGCg/DABnlEbyTJj9yxT+k0DSGpft3j0DJN4yN6bKD0ogxTkCk9ZKfIJj2Hl/h+wXm7
         8+kTMpJV7/kT9Rh41yCN7BYT/x7TRTZV5f3jJAWGW8H5W/9hNa+eyGf1eJmOsTNPBiEG
         WtMaJRWfn5xFrVkXjEu8frt/ZUizF0827VhHSkKUKambAV7VbnTZI8H3uthXh97Y89pT
         gn3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv1o4eieILe0D/LHl1o1RyeQnN4zVfWRbJT0an4RASuK22dwt823IgRFiQmY5xD73T8nruaNLp4lxSXNrcaOalbIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiyx3gIDR7JF9gMhBkhwD34TDWn2ai6fyK+ogrrfe+CPckvvmQ
	dgJaI0bgwKxKCwFQq62eQiBQ3iAH0rp2oRWe0/zQo/SK6ci4JxLtSC3myHcFrATV0A==
X-Gm-Gg: ATEYQzycWymlX3tL/dtUwTkC8nF/y+Nwqr+s6cMbKZefDwMz8JCM5FGYfoObPwhLIT3
	m3S0M+ULM2wgoBRCtgREuK1SJR9BKN+GlF+FAgYsx/0hwGzhG3PpHjtPeFWeYnYHvKCSHOqE0ta
	OgBnTMbBIJTzw4YrQI/v7DEeFUdKLJ7NXS+sNtF9BcSJMl07rQ+APaaEIR+VoaG+IsrqkxFr6l3
	s3wuUg71D7CRDivkIG7Ri2gzF+9uzu1fvVi+L+7zLCJba4GTqjzxfIMBsn9Nwj94vTA8lCe10Hz
	rg1AOfde4ITWsTMguqz/HocJUMBPdmYrJAqIMFKQIDG8CwzH9aUwHDOnJxCmfpbZ+uDVWQe4K1n
	tt3wD6gWdMPTo9GyTXQtuRWnn2KT8GsG7QJM9P+tOoAbZrHj7US2fyJ87kmC2UfVIdRXOnkMuJn
	CZjeMBCVFGrwORDYtYMCLBi6YuLn1/t2n/npKcj/EQ1DovYeDn9edmqMzjyCN3Turxbf0=
X-Received: by 2002:a05:6000:2313:b0:436:307c:b756 with SMTP id ffacd0b85a97d-4399de2fcdemr3455055f8f.47.1772188881266;
        Fri, 27 Feb 2026 02:41:21 -0800 (PST)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a0f6sm6726300f8f.22.2026.02.27.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 02:41:20 -0800 (PST)
Date: Fri, 27 Feb 2026 10:41:17 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Qing Wang <wangqing7171@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <aaF0zS3xh5KgM_yy@google.com>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
 <aaFrmHzIAkEe7ufy@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaFrmHzIAkEe7ufy@google.com>

On Fri, Feb 27, 2026 at 10:02:00AM +0000, Vincent Donnefort wrote:
> On Fri, Feb 27, 2026 at 10:58:42AM +0800, Qing Wang wrote:
> > When a process forks, the child process copies the parent's VMAs but the
> > user_mapped reference count is not incremented. As a result, when both the
> > parent and child processes exit, tracing_buffers_mmap_close() is called
> > twice. On the second call, user_mapped is already 0, causing the function to
> > return -ENODEV and triggering a WARN_ON.
> > 
> > Fix it by incrementing the user_mapped reference count without re-mapping
> > the pages in the VMA's open callback.
> 
> Hum, not sure this is entirely correct. We do set VM_DONTCOPY when creating the
> mapping (see __rb_map_vma). So AFAICT ->open() is not called in this situation (see
> dup_mmap())

Ah right, Syzkaller is using madvise(MADVISE_DOFORK) which resets VM_DONTCOPY.

> 
> > 
> > Fixes: cf9f0f7c4c5bb ("tracing: Allow user-space mapping of the ring-buffer")
> > Reported-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
> > Tested-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
> > Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> > ---
> >  include/linux/ring_buffer.h |  1 +
> >  kernel/trace/ring_buffer.c  | 21 +++++++++++++++++++++
> >  kernel/trace/trace.c        | 13 +++++++++++++
> >  3 files changed, 35 insertions(+)
> > 
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index 876358cfe1b1..d862fa610270 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -248,6 +248,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
> >  
> >  int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> >  		    struct vm_area_struct *vma);
> > +void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu);
> >  int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
> >  int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
> >  #endif /* _LINUX_RING_BUFFER_H */
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index f16f053ef77d..17d0ea0cc3e6 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -7310,6 +7310,27 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> >  	return err;
> >  }
> >  
> > +/*
> > + * This is called when a VMA is duplicated (e.g., on fork()) to increment
> > + * the user_mapped counter without remapping pages.
> > + */
> > +void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +
> > +	if (WARN_ON(!cpumask_test_cpu(cpu, buffer->cpumask)))
> > +		return;
> > +
> > +	cpu_buffer = buffer->buffers[cpu];
> > +
> > +	guard(mutex)(&cpu_buffer->mapping_lock);
> > +
> > +	if (cpu_buffer->user_mapped)
> > +		__rb_inc_dec_mapped(cpu_buffer, true);
> > +	else
> > +		WARN(1, "Unexpected buffer stat, it should be mapped");
> > +}
> > +
> >  int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
> >  {
> >  	struct ring_buffer_per_cpu *cpu_buffer;
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 23de3719f495..1e7c032a72d2 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -8213,6 +8213,18 @@ static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
> >  static inline void put_snapshot_map(struct trace_array *tr) { }
> >  #endif
> >  
> > +/*
> > + * This is called when a VMA is duplicated (e.g., on fork()) to increment
> > + * the user_mapped counter without remapping pages.
> > + */
> > +static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
> > +{
> > +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> > +	struct trace_iterator *iter = &info->iter;
> > +
> > +	ring_buffer_map_dup(iter->array_buffer->buffer, iter->cpu_file);
> > +}
> > +
> >  static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
> >  {
> >  	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> > @@ -8232,6 +8244,7 @@ static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long a
> >  }
> >  
> >  static const struct vm_operations_struct tracing_buffers_vmops = {
> > +	.open		= tracing_buffers_mmap_open,
> >  	.close		= tracing_buffers_mmap_close,
> >  	.may_split      = tracing_buffers_may_split,
> >  };
> > -- 
> > 2.34.1
> > 
