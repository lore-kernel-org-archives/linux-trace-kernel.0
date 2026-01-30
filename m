Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA26350D7D;
	Fri, 30 Jan 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764862; cv=none; b=UHpsJAAtdnbukJQqvn/Q3hJrdkoR6P+iTdXk8Q4ZfipeD2Zh3Nsca574olVGC3FavkMcbMOxjjzqGP2T9ey0TDXG8vHWB/DJUHx3AaeuVg4/rfoDDZeMeLwnN1N0POQs3+Miv3HFZ0hElics1lyUo3NIt3MkxAVPIfEArYDe5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764862; c=relaxed/simple;
	bh=ekf/LVP8bokOJ9c8cWda2ewGaqs2NCHjIOISWldjD6w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NT/U4JL7KaJhz5J17gZqPktcQYfkKmDItftphca7FULTUW4eWj4ohmDDGXCFzlq/00ZvuJxvUh91/GhZyloGIMFtQL7yej3eT8XeNiCbGsX9foF/yODRWqHPVdidv+f87iMdG2DMbJ5YVgClKjdKXioJ6HM4NFnPGBNUlkeE3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLCmp+D0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLCmp+D0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EB9C4CEF7;
	Fri, 30 Jan 2026 09:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769764862;
	bh=ekf/LVP8bokOJ9c8cWda2ewGaqs2NCHjIOISWldjD6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uLCmp+D0milRbQdPpI84P8q83TdMrNtKZkmOpPAk2d5tPuiRnOTVtf1CxQErG3dka
	 UKhLSTktxcdCim4C7qAeqljBS9ewqihI1fDOPzNIyAcME4pWUuqXWp/4mzHzuNPRAr
	 I3TrwVHH3P3G5ZNgsvFPJbaQ3JmIcxxVt01OWlTa+sevIyzamodLuQMdvXIQedw3HB
	 MKDSVmHrFsKKzER17CjKZdoTr4lOoke7DNdYijxsv79/JD5k1/WyOngTZ+/lKWTrCr
	 MVNceMhJpD5a0dEMPtIrXfu42+9/ow6aRTxoqY7Yt+W0HLqEV4ScC0hYOWJKCW50lm
	 54gJeoUFCOTyA==
Date: Fri, 30 Jan 2026 18:20:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] tracing: Make the backup instance non-reusable
Message-Id: <20260130182058.abb5c2b401f104afd25261d3@kernel.org>
In-Reply-To: <20260129150745.1f9ab283@gandalf.local.home>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955899639.2786091.8716448298561300937.stgit@mhiramat.tok.corp.google.com>
	<20260129150745.1f9ab283@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 15:07:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 Jan 2026 09:09:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -10632,17 +10658,23 @@ static __init void create_trace_instances(struct dentry *d_tracer)
> >  static void
> >  init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
> >  {
> > +	umode_t writable_mode = TRACE_MODE_WRITE;
> > +	bool readonly = trace_array_is_readonly(tr);
> >  	int cpu;
> >  
> > +	if (readonly)
> > +		writable_mode = TRACE_MODE_READ;
> > +
> >  	trace_create_file("available_tracers", TRACE_MODE_READ, d_tracer,
> > -			tr, &show_traces_fops);
> > +			  tr, &show_traces_fops);
> >  
> > -	trace_create_file("current_tracer", TRACE_MODE_WRITE, d_tracer,
> > -			tr, &set_tracer_fops);
> > +	trace_create_file("current_tracer", writable_mode, d_tracer,
> > +			  tr, &set_tracer_fops);
> >  
> > -	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
> > +	trace_create_file("tracing_cpumask", writable_mode, d_tracer,
> >  			  tr, &tracing_cpumask_fops);
> >  
> > +	/* Options are used for changing print-format even for readonly instance. */
> >  	trace_create_file("trace_options", TRACE_MODE_WRITE, d_tracer,
> >  			  tr, &tracing_iter_fops);
> >  
> > @@ -10652,27 +10684,35 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
> >  	trace_create_file("trace_pipe", TRACE_MODE_READ, d_tracer,
> >  			  tr, &tracing_pipe_fops);
> >  
> > -	trace_create_file("buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
> > +	trace_create_file("buffer_size_kb", writable_mode, d_tracer,
> >  			  tr, &tracing_entries_fops);
> >  
> >  	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
> >  			  tr, &tracing_total_entries_fops);
> >  
> > -	trace_create_file("free_buffer", 0200, d_tracer,
> > -			  tr, &tracing_free_buffer_fops);
> > +	if (!readonly) {
> > +		trace_create_file("free_buffer", 0200, d_tracer,
> > +				tr, &tracing_free_buffer_fops);
> 
> Hmm, why remove the free_buffer. It just shrinks the buffer down to a
> minimum. Perhaps its useless, but I it doesn't write to the buffer. Sure it
> removes data but so does trace_pipe.

I can keep it but free_buffer and free instance is a bit different on
the persistent ring buffer and its backup. For both cases, since the
scratch area needs to be kept, it does not free the reserved memory.
(but the minimum ring buffer is dynamically allocated.)
IMHO, the buffer resize interfaces are not useful for persistent ring
buffer.

> 
> >  
> > -	trace_create_file("trace_marker", 0220, d_tracer,
> > -			  tr, &tracing_mark_fops);
> > +		trace_create_file("trace_marker", 0220, d_tracer,
> > +				tr, &tracing_mark_fops);
> >  
> > -	tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
> > +		tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
> >  
> > -	trace_create_file("trace_marker_raw", 0220, d_tracer,
> > -			  tr, &tracing_mark_raw_fops);
> > +		trace_create_file("trace_marker_raw", 0220, d_tracer,
> > +				tr, &tracing_mark_raw_fops);
> >  
> > -	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
> > +		trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
> > +				tr, &buffer_percent_fops);
> > +
> > +		trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
> > +				tr, &tracing_syscall_buf_fops);
> > +	}
> > +
> > +	trace_create_file("trace_clock", writable_mode, d_tracer, tr,
> >  			  &trace_clock_fops);
> >  
> > -	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
> > +	trace_create_file("tracing_on", writable_mode, d_tracer,
> >  			  tr, &rb_simple_fops);
> 
> Hmm, should tracing_on exist in read only mode?

Ah, indeed. I'll remove this too.

> >  
> >  	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
> > @@ -10680,41 +10720,38 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
> >  
> >  	tr->buffer_percent = 50;
> >  
> > -	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
> > -			tr, &buffer_percent_fops);
> > -
> > -	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
> > +	trace_create_file("buffer_subbuf_size_kb", writable_mode, d_tracer,
> >  			  tr, &buffer_subbuf_size_fops);
> >  
> > -	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
> > -			 tr, &tracing_syscall_buf_fops);
> > -
> >  	create_trace_options_dir(tr);
> >  
> >  #ifdef CONFIG_TRACER_MAX_TRACE
> > -	trace_create_maxlat_file(tr, d_tracer);
> > +	if (!readonly)
> > +		trace_create_maxlat_file(tr, d_tracer);
> >  #endif
> >  
> > -	if (ftrace_create_function_files(tr, d_tracer))
> > +	if (!readonly && ftrace_create_function_files(tr, d_tracer))
> >  		MEM_FAIL(1, "Could not allocate function filter files");
> >  
> >  	if (tr->range_addr_start) {
> >  		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
> >  				  tr, &last_boot_fops);
> >  #ifdef CONFIG_TRACER_SNAPSHOT
> > -	} else {
> > +	} else if (!readonly) {
> >  		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
> >  				  tr, &snapshot_fops);
> >  #endif
> >  	}
> >  
> > -	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
> > -			  tr, &tracing_err_log_fops);
> > +	if (!readonly)
> > +		trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
> > +				  tr, &tracing_err_log_fops);
> 
> Why not move this up into the "if (!readonly) {" block above?

OK, I'll move it.

> 
> >  
> >  	for_each_tracing_cpu(cpu)
> >  		tracing_init_tracefs_percpu(tr, cpu);
> >  
> > -	ftrace_init_tracefs(tr, d_tracer);
> > +	if (!readonly)
> > +		ftrace_init_tracefs(tr, d_tracer);
> 
> Same here. Or just move the readonly block down to the end of the function.

OK.

> 
> >  }
> >  
> >  #ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 69e7defba6c6..0adc644084bf 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -33,6 +33,7 @@
> >  
> >  #define TRACE_MODE_WRITE	0640
> >  #define TRACE_MODE_READ		0440
> > +#define TRACE_MODE_WRITE_MASK	(TRACE_MODE_WRITE & ~TRACE_MODE_READ)
> >  
> >  enum trace_type {
> >  	__TRACE_FIRST_TYPE = 0,
> > @@ -483,6 +484,12 @@ extern bool trace_clock_in_ns(struct trace_array *tr);
> >  
> >  extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
> >  
> > +static inline bool trace_array_is_readonly(struct trace_array *tr)
> > +{
> > +	/* backup instance is read only. */
> > +	return tr->flags & TRACE_ARRAY_FL_VMALLOC;
> 
> Hmm, I wonder if we should create a RDONLY flag for the trace_array?

OK, let me add the RDONLY flag. (maybe it will be reused afterwards)

Thanks,

> 
> -- Steve
> 
> > +}
> > +
> >  /*
> >   * The global tracer (top) should be the first trace array added,
> >   * but we check the flag anyway.
> > @@ -681,7 +688,6 @@ struct dentry *trace_create_file(const char *name,
> >  				 void *data,
> >  				 const struct file_operations *fops);
> >  
> > -
> >  /**
> >   * tracer_tracing_is_on_cpu - show real state of ring buffer enabled on for a cpu
> >   * @tr : the trace array to know if ring buffer is enabled
> > diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> > index dbe29b4c6a7a..2ca2541c8a58 100644
> > --- a/kernel/trace/trace_boot.c
> > +++ b/kernel/trace/trace_boot.c
> > @@ -61,7 +61,8 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
> >  		v = memparse(p, NULL);
> >  		if (v < PAGE_SIZE)
> >  			pr_err("Buffer size is too small: %s\n", p);
> > -		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
> > +		if (trace_array_is_readonly(tr) ||
> > +		    tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
> >  			pr_err("Failed to resize trace buffer to %s\n", p);
> >  	}
> >  
> > @@ -597,7 +598,7 @@ trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
> >  
> >  	p = xbc_node_find_value(node, "tracer", NULL);
> >  	if (p && *p != '\0') {
> > -		if (tracing_set_tracer(tr, p) < 0)
> > +		if (trace_array_is_readonly(tr) || tracing_set_tracer(tr, p) < 0)
> >  			pr_err("Failed to set given tracer: %s\n", p);
> >  	}
> >  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
