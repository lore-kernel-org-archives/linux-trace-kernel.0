Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF63EDAD0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191349; cv=none; b=lLP9EbNtJH99QEmF+JgZyTtam1J4o3KJeqKJbmE609k8Kq9rLw9shj/ErJIpImIjyv4j+iiW362vOHUbPBUrKDthC2kHdY08lZg83MqzFe7DBFqGkXL6BgGRk+PdstoKlg91q2u5y9UWwsOFGqAH5weBaXrJ/ncy4DaSjDSDz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191349; c=relaxed/simple;
	bh=i8Sw1I4/A+3axgYDDTfGhONQ4L4qVg3O1tglgRoTUVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQ/SLIqLROPbf+lHU1jnD4/NdCDmnx3o8/MNyu/XH1YXnaQGKbCdh59FuH6eKQxDOspyR3WMIfP7AGIyiNNIOGRtms9ASuVAidnWmpVkGJrrU5RaRgz1NdQmm5Xu5z70+RSr9ghR/+WTQfQEj6FaqWJy7h705THgiYkW4eMUo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSSJ7GAV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSSJ7GAV"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4807068eacbso15818985e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 03:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772191346; x=1772796146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dD7EV1DV0Ud7whD3GiYG42Kld3f1oFtGQyxIVexZ98=;
        b=DSSJ7GAVTo/csytTxnPJQ9Q46DzVH+XfvcpCy5kNHfAMzQUIiWuICpJfiZTweI2Nxs
         S4xGSp/n09PRFPhR3nvHT49rz6fGFdM866Nbbx4dmsA7t61LsPJ967VPKSbL8Al7xZ/O
         Us8tFJ5vfLeWtdfQCjZt/iT0IJvqp0dMwQ8O6+Ot1JYm7e9WbZJcp6q1BYOTzGONb8FI
         27NmgD0lxXxKSAy8LPF39Eo8kcYor+YmEOT2ynSummIk1LpeTEHz4FwBNE/jELclVYEl
         OcdtGEFHzFiLvA3tY2cJ874jdJ3NK75ck17lO5clmeeO2zoHcJWEJs4fYDOcMSklK4zA
         pCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772191346; x=1772796146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dD7EV1DV0Ud7whD3GiYG42Kld3f1oFtGQyxIVexZ98=;
        b=Ve/11iY/r2lBUweVJgX4PK77HCo6vqW/JHOUPRvLwrr4GvKe9kQe/YOVuPZAYXpf2r
         /ykOmQLLxWYrreCI5IwHbMRvklBEwFcB0fR6YoWb4lSoMaKX/RMivITEfbVCCqzYHwDi
         p1kycxneOuTwQF22QqSHYD/p2h+BJsfM15P12cAVUn2IJ8Bm+7L83NFePbyppaKZ2bhU
         RBQMTYqbIbEg42JZkrXuMMl8bBqnsYEsSZq7bpq65sqJcxLjT+qnkUKzVYKz0wgdbKUv
         QhtsyFV+2oKnety+pARSFcTu9QCzCAkC0qodezq9uQ+Z1myt0QlDd+UPZSI1uruiYxg7
         6iNA==
X-Forwarded-Encrypted: i=1; AJvYcCVmHGeKVD7mc9xHOmPNLf4PHCdIfi1HFYoKdS9IPWK4c+KZ5+rnt9JvUn4GgwApAcDXVC/pKQtHT1hi5q4QFnijX8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhYO3AgE9Y+AbOBzLBbaJOWQXNKLFEcvytWdftNxQrJ9v4Eo/
	JfCk1ToP4QSMnRc3zXvLD1tOOjG23dp066Acudw69mJ9zlajDoWv6r7cxHNBMkXVqw==
X-Gm-Gg: ATEYQzyh8hRGKQuv9CJ6BXHNEzmiZMklN+dT/dDiAOYd5KNXzVqFRG6tcblGDfYjsol
	mRifoFAU6ZMLgezgH5OUWTo4hG+UGx0FmnNlQngZQh88dJVDGwairGjw2drOjakW5Ov9adu+wQo
	17E7oDKx1JyoxU4xZsgrzzSpfWy5E2vRCiEHXSmA3d4zC0DSsIQtz+ishnTa0sZF8uTglIjiMRw
	RFWb23yHKTx/pwektTNsomWlYbVjbdDPYUXAJYmv66NTwrHLPaTCeYrXdwHlEIfSBrdejbMSLK/
	mmZsiSdQ48/OhswKHwUIt4vt3uNxFF+AOmiA9U9UMSBSBl1ViKuMjZPfcRRlq1CUBnvAt8hKzHe
	Yu8G+CvPMtrJBNLni1uJlOaXY8B5EgbrKEI2TR3A/QXjQ0Mubn4EpcMYAeYZWrG8PzGEw2dAnHS
	QflwD+Uo7+HOePasD3wsUuPtM2qfCcsZPtc4P4d1RMoVGrf6U0vNEqX++oMJoJZm/7JSNv1DxNg
	GDewg==
X-Received: by 2002:a05:600c:8289:b0:483:6a8d:b2fc with SMTP id 5b1f17b1804b1-483c9babda5mr35903405e9.8.1772191345979;
        Fri, 27 Feb 2026 03:22:25 -0800 (PST)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c7657c7sm6577185f8f.28.2026.02.27.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 03:22:25 -0800 (PST)
Date: Fri, 27 Feb 2026 11:22:22 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Qing Wang <wangqing7171@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <aaF-bhAIhCgusG9k@google.com>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
 <aaFrmHzIAkEe7ufy@google.com>
 <aaF0zS3xh5KgM_yy@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaF0zS3xh5KgM_yy@google.com>

On Fri, Feb 27, 2026 at 10:41:17AM +0000, Vincent Donnefort wrote:
> On Fri, Feb 27, 2026 at 10:02:00AM +0000, Vincent Donnefort wrote:
> > On Fri, Feb 27, 2026 at 10:58:42AM +0800, Qing Wang wrote:
> > > When a process forks, the child process copies the parent's VMAs but the
> > > user_mapped reference count is not incremented. As a result, when both the
> > > parent and child processes exit, tracing_buffers_mmap_close() is called
> > > twice. On the second call, user_mapped is already 0, causing the function to
> > > return -ENODEV and triggering a WARN_ON.
> > > 
> > > Fix it by incrementing the user_mapped reference count without re-mapping
> > > the pages in the VMA's open callback.
> > 
> > Hum, not sure this is entirely correct. We do set VM_DONTCOPY when creating the
> > mapping (see __rb_map_vma). So AFAICT ->open() is not called in this situation (see
> > dup_mmap())
> 
> Ah right, Syzkaller is using madvise(MADVISE_DOFORK) which resets VM_DONTCOPY.

As we are applying restrictive rules for this mapping, I believe setting VM_IO
might be a better fix.

> 
> > 
> > > 
> > > Fixes: cf9f0f7c4c5bb ("tracing: Allow user-space mapping of the ring-buffer")
> > > Reported-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
> > > Tested-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
> > > Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> > > ---
> > >  include/linux/ring_buffer.h |  1 +
> > >  kernel/trace/ring_buffer.c  | 21 +++++++++++++++++++++
> > >  kernel/trace/trace.c        | 13 +++++++++++++
> > >  3 files changed, 35 insertions(+)
> > > 
> > > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > > index 876358cfe1b1..d862fa610270 100644
> > > --- a/include/linux/ring_buffer.h
> > > +++ b/include/linux/ring_buffer.h
> > > @@ -248,6 +248,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
> > >  
> > >  int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> > >  		    struct vm_area_struct *vma);
> > > +void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu);
> > >  int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
> > >  int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
> > >  #endif /* _LINUX_RING_BUFFER_H */
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index f16f053ef77d..17d0ea0cc3e6 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -7310,6 +7310,27 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> > >  	return err;
> > >  }
> > >  
> > > +/*
> > > + * This is called when a VMA is duplicated (e.g., on fork()) to increment
> > > + * the user_mapped counter without remapping pages.
> > > + */
> > > +void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu)
> > > +{
> > > +	struct ring_buffer_per_cpu *cpu_buffer;
> > > +
> > > +	if (WARN_ON(!cpumask_test_cpu(cpu, buffer->cpumask)))
> > > +		return;
> > > +
> > > +	cpu_buffer = buffer->buffers[cpu];
> > > +
> > > +	guard(mutex)(&cpu_buffer->mapping_lock);
> > > +
> > > +	if (cpu_buffer->user_mapped)
> > > +		__rb_inc_dec_mapped(cpu_buffer, true);
> > > +	else
> > > +		WARN(1, "Unexpected buffer stat, it should be mapped");
> > > +}
> > > +
> > >  int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
> > >  {
> > >  	struct ring_buffer_per_cpu *cpu_buffer;
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index 23de3719f495..1e7c032a72d2 100644
> > > --- a/kernel/trace/trace.c
> > > +++ b/kernel/trace/trace.c
> > > @@ -8213,6 +8213,18 @@ static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
> > >  static inline void put_snapshot_map(struct trace_array *tr) { }
> > >  #endif
> > >  
> > > +/*
> > > + * This is called when a VMA is duplicated (e.g., on fork()) to increment
> > > + * the user_mapped counter without remapping pages.
> > > + */
> > > +static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
> > > +{
> > > +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> > > +	struct trace_iterator *iter = &info->iter;
> > > +
> > > +	ring_buffer_map_dup(iter->array_buffer->buffer, iter->cpu_file);
> > > +}
> > > +
> > >  static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
> > >  {
> > >  	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> > > @@ -8232,6 +8244,7 @@ static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long a
> > >  }
> > >  
> > >  static const struct vm_operations_struct tracing_buffers_vmops = {
> > > +	.open		= tracing_buffers_mmap_open,
> > >  	.close		= tracing_buffers_mmap_close,
> > >  	.may_split      = tracing_buffers_may_split,
> > >  };
> > > -- 
> > > 2.34.1
> > > 
