Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF094D11B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158070; cv=none; b=cIoKtzGZmFSzLwGdsbOoDrDx3bNxf3hVNmUD67Qgf7M85yMXLHgxVGaeM1s4mWysYXBF/vlgH72Pd+AFhFDOQ22lYD0SIzKhXOFIOtzrzh8akRIgpuca7bJAnoYoB6iHpet2G5TpR8b79joUjaq8pstn3DbB3u2tA84i4EuctUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158070; c=relaxed/simple;
	bh=Fl5YeI3W81kjLg5aazIjQlhmbWSK2v2kWZWhBJm4wEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsrZs/2TXt4l6RadOshgvoUiCQpeHer2qIR/TYsR+/ChcM20tgi76X9NtnfWR8yleSGzHMMgJYRLaIT8FpuAjehJ4WA2xqyJbsDvoELhVKUbbYKU1BnIlCns2rGbMbKriU7pc9Ub4yf7cPZzlYE/g6GVMXGrsXROTHeUS2hp5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ar0VGePk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ar0VGePk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fdd5bbe65so7773865e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707158067; x=1707762867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WALNCZMo14LgMhEZM0Qc2mfijc001s1SzuUUHFNi9h4=;
        b=ar0VGePk3uOKsLUTxTdKIk2UXW2I566AzbwSLnF4aLH3kKUshrrLXH6hxgnP5u7z3D
         nhPl6frZ//YY5BkSNnM/2sDpx9sV5Dz9Vhbs2bPOufZaG+J0PAxIa5wqfvbb+mrRr2y1
         HgMWl3s+3Y9xccJkk2jaLWFopM/z/PBiwWA34JcvDzqHj/0FzeDkCGfGMFMYkXWldHLS
         UscT3D0X07YtgREME3HU9XgbJztP0R835DWnlFxxbqImuJAR6eqSUJLwwcsub9T1oo5r
         RjM9jAGB7VyMkJGQ2xg5JmpOQy9DT8LCgb2tfZ+whQOzPAKmkB4EQijQ+dKvZMDLFUoc
         LY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707158067; x=1707762867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WALNCZMo14LgMhEZM0Qc2mfijc001s1SzuUUHFNi9h4=;
        b=OihYkRURv/gETi+U3s/Q5VL3IX8H1p/1VOnwb6oUnqK/GaSh/oJGlCIaceXfk1PHI+
         2umB+4bMlDuyVawFFT08aOibbElq9gG7WUkQyGLa7ulG3UEyCfBgn/DrH45/is7E2KtI
         6LQqwawnHA94x85VGzQcVSqAtO+c5Kg849zlVtQtRsjthN3r3Twa85pmwTv/Bsr8x/nj
         TuQJpiONrhWAjy/FU8eqD4VZOYg8fJ64VJEtPSWrU0qmsfxksrWLLGO4MpufMVjED9US
         yoRIWL/xhX8TGTtASXIrmfi4dcMU48VsipSEvXN/bw65WMoj7msf4IvtMtGFFEnS80jy
         OT4g==
X-Gm-Message-State: AOJu0Yx9G1zhPMzUlFWYPExw7DVucr6PaBoNhLnf0qLJA3WloILmPmE7
	0tPXONpiEqaz4FWJsq1xIhF7suoZAncxynnB0+yRtd2pUJbW7owAQhEjyVAySjuc2ffxELoULrv
	lMw==
X-Google-Smtp-Source: AGHT+IEj7pThq9V6uC6Tlr1yne+C/QFr0F7F4obzy1XnLviYRp5ha6QEwrpwXVb6IxLUGBQh+3FC8Q==
X-Received: by 2002:a05:600c:4ecf:b0:40f:b770:fa42 with SMTP id g15-20020a05600c4ecf00b0040fb770fa42mr402990wmq.33.1707158066572;
        Mon, 05 Feb 2024 10:34:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXaWlVGy1jiIAfcKIv4XXtb60jndvuoVB8ECBUln5cmbnlyVekx2b/fHXQ2yNb5nvlxR/mcXksY7K5Hfzqb530NP3r1OHiDyXdr4zWFuZNUqOe+wP1ZOMSQtHTYERQ+lhmVM9M6/tjLFuYA5QdLH7TR8QE752VLh/Ar7DoIVrsv/bpLrOmN7I4wnShif0TMv6cGvTOzC69G5dhanGojAA==
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b0040ee2460966sm9377250wmp.24.2024.02.05.10.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:34:26 -0800 (PST)
Date: Mon, 5 Feb 2024 18:34:22 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v14 4/6] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <ZcEqLmyi3fEMOSIl@google.com>
References: <20240205163410.2296552-1-vdonnefort@google.com>
 <20240205163410.2296552-5-vdonnefort@google.com>
 <3c16bee0-70b7-420f-a085-c9e09e293fe2@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c16bee0-70b7-420f-a085-c9e09e293fe2@efficios.com>

On Mon, Feb 05, 2024 at 11:55:08AM -0500, Mathieu Desnoyers wrote:
> On 2024-02-05 11:34, Vincent Donnefort wrote:
> > Currently, user-space extracts data from the ring-buffer via splice,
> > which is handy for storage or network sharing. However, due to splice
> > limitations, it is imposible to do real-time analysis without a copy.
> > 
> > A solution for that problem is to let the user-space map the ring-buffer
> > directly.
> > 
> > The mapping is exposed via the per-CPU file trace_pipe_raw. The first
> > element of the mapping is the meta-page. It is followed by each
> > subbuffer constituting the ring-buffer, ordered by their unique page ID:
> > 
> >    * Meta-page -- include/uapi/linux/trace_mmap.h for a description
> >    * Subbuf ID 0
> >    * Subbuf ID 1
> >       ...
> > 
> > It is therefore easy to translate a subbuf ID into an offset in the
> > mapping:
> > 
> >    reader_id = meta->reader->id;
> >    reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
> > 
> > When new data is available, the mapper must call a newly introduced ioctl:
> > TRACE_MMAP_IOCTL_GET_READER. This will update the Meta-page reader ID to
> > point to the next reader containing unread data.
> > 
> > Mapping will prevent snapshot and buffer size modifications.
> 
> How are the kernel linear mapping and the userspace mapping made coherent
> on architectures with virtually aliasing data caches ?
> 
> Ref. https://lore.kernel.org/lkml/20240202210019.88022-1-mathieu.desnoyers@efficios.com/T/#t

Hi Mathieu,

Thanks for the pointer.

We are in the exact same problem as DAX. We do modify the data through the
kernel linear mapping while user-space can read it through its own. I should
probably return an error when used with any of the arch ARM || SPARC || MIPS,
until cpu_dcache_is_aliasing() introduces a fine-grain differentiation.

> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> > index 182e05a3004a..7330249257e7 100644
> > --- a/include/uapi/linux/trace_mmap.h
> > +++ b/include/uapi/linux/trace_mmap.h
> > @@ -43,4 +43,6 @@ struct trace_buffer_meta {
> >   	__u64	Reserved2;
> >   };
> > +#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
> > +
> >   #endif /* _TRACE_MMAP_H_ */
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 4ebf4d0bd14c..36b62cf2fb3f 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -1175,6 +1175,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
> >   		return;
> >   	}
> > +	if (tr->mapped) {
> > +		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
> > +		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
> > +		return;
> > +	}
> > +
> >   	local_irq_save(flags);
> >   	update_max_tr(tr, current, smp_processor_id(), cond_data);
> >   	local_irq_restore(flags);
> > @@ -1307,7 +1313,7 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
> >   	lockdep_assert_held(&trace_types_lock);
> >   	spin_lock(&tr->snapshot_trigger_lock);
> > -	if (tr->snapshot == UINT_MAX) {
> > +	if (tr->snapshot == UINT_MAX || tr->mapped) {
> >   		spin_unlock(&tr->snapshot_trigger_lock);
> >   		return -EBUSY;
> >   	}
> > @@ -6533,7 +6539,7 @@ static void tracing_set_nop(struct trace_array *tr)
> >   {
> >   	if (tr->current_trace == &nop_trace)
> >   		return;
> > -	
> > +
> >   	tr->current_trace->enabled--;
> >   	if (tr->current_trace->reset)
> > @@ -8652,15 +8658,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
> >   	return ret;
> >   }
> > -/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
> >   static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >   {
> >   	struct ftrace_buffer_info *info = file->private_data;
> >   	struct trace_iterator *iter = &info->iter;
> > +	int err;
> > +
> > +	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
> > +		if (!(file->f_flags & O_NONBLOCK)) {
> > +			err = ring_buffer_wait(iter->array_buffer->buffer,
> > +					       iter->cpu_file,
> > +					       iter->tr->buffer_percent);
> > +			if (err)
> > +				return err;
> > +		}
> > -	if (cmd)
> > -		return -ENOIOCTLCMD;
> > +		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
> > +						  iter->cpu_file);
> > +	} else if (cmd) {
> > +		return -ENOTTY;
> > +	}
> > +	/*
> > +	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
> > +	 * waiters
> > +	 */
> >   	mutex_lock(&trace_types_lock);
> >   	iter->wait_index++;
> > @@ -8673,6 +8695,97 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
> >   	return 0;
> >   }
> > +static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
> > +{
> > +	struct ftrace_buffer_info *info = vmf->vma->vm_file->private_data;
> > +	struct trace_iterator *iter = &info->iter;
> > +	vm_fault_t ret = VM_FAULT_SIGBUS;
> > +	struct page *page;
> > +
> > +	page = ring_buffer_map_fault(iter->array_buffer->buffer, iter->cpu_file,
> > +				     vmf->pgoff);
> > +	if (!page)
> > +		return ret;
> > +
> > +	get_page(page);
> > +	vmf->page = page;
> > +	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> > +	vmf->page->index = vmf->pgoff;
> > +
> > +	return 0;
> > +}
> > +
> > +static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
> > +{
> > +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> > +	struct trace_iterator *iter = &info->iter;
> > +	struct trace_array *tr = iter->tr;
> > +
> > +	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
> > +
> > +#ifdef CONFIG_TRACER_MAX_TRACE
> > +	spin_lock(&tr->snapshot_trigger_lock);
> > +	if (!WARN_ON(!tr->mapped))
> > +		tr->mapped--;
> > +	spin_unlock(&tr->snapshot_trigger_lock);
> > +#endif
> > +}
> > +
> > +static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
> > +{
> > +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> > +	struct trace_iterator *iter = &info->iter;
> > +
> > +	WARN_ON(ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file));
> > +}
> > +
> > +static const struct vm_operations_struct tracing_buffers_vmops = {
> > +	.open		= tracing_buffers_mmap_open,
> > +	.close		= tracing_buffers_mmap_close,
> > +	.fault		= tracing_buffers_mmap_fault,
> > +};
> > +
> > +static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +	struct ftrace_buffer_info *info = filp->private_data;
> > +	struct trace_iterator *iter = &info->iter;
> > +	struct trace_array *tr = iter->tr;
> > +	int ret = 0;
> > +
> > +	if (vma->vm_flags & VM_WRITE)
> > +		return -EPERM;
> > +
> > +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
> > +	vma->vm_ops = &tracing_buffers_vmops;
> > +
> > +#ifdef CONFIG_TRACER_MAX_TRACE
> > +	/*
> > +	 * We hold mmap_lock here. lockdep would be unhappy if we would now take
> > +	 * trace_types_lock. Instead use the specific snapshot_trigger_lock.
> > +	 */
> > +	spin_lock(&tr->snapshot_trigger_lock);
> > +	if (tr->snapshot || tr->mapped == UINT_MAX) {
> > +		spin_unlock(&tr->snapshot_trigger_lock);
> > +		return -EBUSY;
> > +	}
> > +	tr->mapped++;
> > +	spin_unlock(&tr->snapshot_trigger_lock);
> > +
> > +	/* Wait for update_max_tr() to observe iter->tr->mapped */
> > +	if (tr->mapped == 1)
> > +		synchronize_rcu();
> > +#endif
> > +	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
> > +#ifdef CONFIG_TRACER_MAX_TRACE
> > +	if (ret) {
> > +		spin_lock(&tr->snapshot_trigger_lock);
> > +		iter->tr->mapped--;
> > +		spin_unlock(&tr->snapshot_trigger_lock);
> > +	}
> > +#endif
> > +	return ret;
> > +}
> > +
> >   static const struct file_operations tracing_buffers_fops = {
> >   	.open		= tracing_buffers_open,
> >   	.read		= tracing_buffers_read,
> > @@ -8681,6 +8794,7 @@ static const struct file_operations tracing_buffers_fops = {
> >   	.splice_read	= tracing_buffers_splice_read,
> >   	.unlocked_ioctl = tracing_buffers_ioctl,
> >   	.llseek		= no_llseek,
> > +	.mmap		= tracing_buffers_mmap,
> >   };
> >   static ssize_t
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index bd312e9afe25..8a96e7a89e6b 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -336,6 +336,7 @@ struct trace_array {
> >   	bool			allocated_snapshot;
> >   	spinlock_t		snapshot_trigger_lock;
> >   	unsigned int		snapshot;
> > +	unsigned int		mapped;
> >   	unsigned long		max_latency;
> >   #ifdef CONFIG_FSNOTIFY
> >   	struct dentry		*d_max_latency;
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
