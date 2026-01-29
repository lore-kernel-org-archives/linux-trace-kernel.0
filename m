Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879429B8D0;
	Thu, 29 Jan 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717257; cv=none; b=f84dgoDAE5IqrteKCwCrom9HzW0zTJKNZVmvRBHxDBM2GkYNsMZoZFKzCgdg4Kvmj9vo7DByOLUOMskQxX8HY6dwRUj2nty7X5y804AlWr7JOBy1dXi+tx0yd5FmRIAXtnqdZ+3X9hK3BaCjWBtDXymhA8wTY2+dZ9rgZgb4M/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717257; c=relaxed/simple;
	bh=GNa3lhk45sApQaBfV4t+WMuiA64iXvltuR7FnJWp2Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChFjrH92R/vBilcxWx/OWNTzcq24r19e/BWyJDM/qC2VBHcRZ3kuAN0+vCyI3z8vFYBao+vFU+lf6U2c6AA7aTtrt21hFzezy7p+51P2v4SLFzTDT9Yz54zUZZLhYeRlXQD4oOvJBWTSBik/dZ5AfnXcnEmSc1BXfVLgXiMLjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 3D8365837D;
	Thu, 29 Jan 2026 20:07:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 84D0134;
	Thu, 29 Jan 2026 20:07:32 +0000 (UTC)
Date: Thu, 29 Jan 2026 15:07:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] tracing: Make the backup instance non-reusable
Message-ID: <20260129150745.1f9ab283@gandalf.local.home>
In-Reply-To: <176955899639.2786091.8716448298561300937.stgit@mhiramat.tok.corp.google.com>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955899639.2786091.8716448298561300937.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8c1c6nmt4d3piacbk6ude4d9ysyxa4wa
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 84D0134
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/MCbXyVdEU8mg1Vmh92Xc5eDsVciNm4sA=
X-HE-Tag: 1769717252-882084
X-HE-Meta: U2FsdGVkX1+AbcApILfaETq+vJBwoQWwRwkgTEIdN1u0sU0s2/YCZr5f+77Nvi5dAls8yNPcobdAi0en4rISSNjQqWLHrfhUZT9rV+xbaw1FFCx+pGhlwljRQ69WPTY3JwqUj0gVAqiYEJuftyJV0hmDLJPlHzb2xHYtuZ1Haf3hBMA84LN3YGEPRQACyG6Q99iOiCtSyYkyNYb9OUMTTbi2c6N7trHjQ7TB7Ei++jhWhYgaPCtyaPIkYE37/ZeA4WpxzD3NMZ0KvNIvArx3OtjfJN/GQkqlVSVz+kJeDWyWBK8Qanm7kl9MOvk41BVESSS8YQ83ZJY5cyE3ZeW8v5MGpeCkcfcK

On Wed, 28 Jan 2026 09:09:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -10632,17 +10658,23 @@ static __init void create_trace_instances(struct dentry *d_tracer)
>  static void
>  init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  {
> +	umode_t writable_mode = TRACE_MODE_WRITE;
> +	bool readonly = trace_array_is_readonly(tr);
>  	int cpu;
>  
> +	if (readonly)
> +		writable_mode = TRACE_MODE_READ;
> +
>  	trace_create_file("available_tracers", TRACE_MODE_READ, d_tracer,
> -			tr, &show_traces_fops);
> +			  tr, &show_traces_fops);
>  
> -	trace_create_file("current_tracer", TRACE_MODE_WRITE, d_tracer,
> -			tr, &set_tracer_fops);
> +	trace_create_file("current_tracer", writable_mode, d_tracer,
> +			  tr, &set_tracer_fops);
>  
> -	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
> +	trace_create_file("tracing_cpumask", writable_mode, d_tracer,
>  			  tr, &tracing_cpumask_fops);
>  
> +	/* Options are used for changing print-format even for readonly instance. */
>  	trace_create_file("trace_options", TRACE_MODE_WRITE, d_tracer,
>  			  tr, &tracing_iter_fops);
>  
> @@ -10652,27 +10684,35 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  	trace_create_file("trace_pipe", TRACE_MODE_READ, d_tracer,
>  			  tr, &tracing_pipe_fops);
>  
> -	trace_create_file("buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
> +	trace_create_file("buffer_size_kb", writable_mode, d_tracer,
>  			  tr, &tracing_entries_fops);
>  
>  	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
>  			  tr, &tracing_total_entries_fops);
>  
> -	trace_create_file("free_buffer", 0200, d_tracer,
> -			  tr, &tracing_free_buffer_fops);
> +	if (!readonly) {
> +		trace_create_file("free_buffer", 0200, d_tracer,
> +				tr, &tracing_free_buffer_fops);

Hmm, why remove the free_buffer. It just shrinks the buffer down to a
minimum. Perhaps its useless, but I it doesn't write to the buffer. Sure it
removes data but so does trace_pipe.

>  
> -	trace_create_file("trace_marker", 0220, d_tracer,
> -			  tr, &tracing_mark_fops);
> +		trace_create_file("trace_marker", 0220, d_tracer,
> +				tr, &tracing_mark_fops);
>  
> -	tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
> +		tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
>  
> -	trace_create_file("trace_marker_raw", 0220, d_tracer,
> -			  tr, &tracing_mark_raw_fops);
> +		trace_create_file("trace_marker_raw", 0220, d_tracer,
> +				tr, &tracing_mark_raw_fops);
>  
> -	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
> +		trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
> +				tr, &buffer_percent_fops);
> +
> +		trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
> +				tr, &tracing_syscall_buf_fops);
> +	}
> +
> +	trace_create_file("trace_clock", writable_mode, d_tracer, tr,
>  			  &trace_clock_fops);
>  
> -	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
> +	trace_create_file("tracing_on", writable_mode, d_tracer,
>  			  tr, &rb_simple_fops);

Hmm, should tracing_on exist in read only mode?

>  
>  	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
> @@ -10680,41 +10720,38 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  
>  	tr->buffer_percent = 50;
>  
> -	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
> -			tr, &buffer_percent_fops);
> -
> -	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
> +	trace_create_file("buffer_subbuf_size_kb", writable_mode, d_tracer,
>  			  tr, &buffer_subbuf_size_fops);
>  
> -	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
> -			 tr, &tracing_syscall_buf_fops);
> -
>  	create_trace_options_dir(tr);
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
> -	trace_create_maxlat_file(tr, d_tracer);
> +	if (!readonly)
> +		trace_create_maxlat_file(tr, d_tracer);
>  #endif
>  
> -	if (ftrace_create_function_files(tr, d_tracer))
> +	if (!readonly && ftrace_create_function_files(tr, d_tracer))
>  		MEM_FAIL(1, "Could not allocate function filter files");
>  
>  	if (tr->range_addr_start) {
>  		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
>  				  tr, &last_boot_fops);
>  #ifdef CONFIG_TRACER_SNAPSHOT
> -	} else {
> +	} else if (!readonly) {
>  		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
>  				  tr, &snapshot_fops);
>  #endif
>  	}
>  
> -	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
> -			  tr, &tracing_err_log_fops);
> +	if (!readonly)
> +		trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
> +				  tr, &tracing_err_log_fops);

Why not move this up into the "if (!readonly) {" block above?

>  
>  	for_each_tracing_cpu(cpu)
>  		tracing_init_tracefs_percpu(tr, cpu);
>  
> -	ftrace_init_tracefs(tr, d_tracer);
> +	if (!readonly)
> +		ftrace_init_tracefs(tr, d_tracer);

Same here. Or just move the readonly block down to the end of the function.

>  }
>  
>  #ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 69e7defba6c6..0adc644084bf 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -33,6 +33,7 @@
>  
>  #define TRACE_MODE_WRITE	0640
>  #define TRACE_MODE_READ		0440
> +#define TRACE_MODE_WRITE_MASK	(TRACE_MODE_WRITE & ~TRACE_MODE_READ)
>  
>  enum trace_type {
>  	__TRACE_FIRST_TYPE = 0,
> @@ -483,6 +484,12 @@ extern bool trace_clock_in_ns(struct trace_array *tr);
>  
>  extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
>  
> +static inline bool trace_array_is_readonly(struct trace_array *tr)
> +{
> +	/* backup instance is read only. */
> +	return tr->flags & TRACE_ARRAY_FL_VMALLOC;

Hmm, I wonder if we should create a RDONLY flag for the trace_array?

-- Steve

> +}
> +
>  /*
>   * The global tracer (top) should be the first trace array added,
>   * but we check the flag anyway.
> @@ -681,7 +688,6 @@ struct dentry *trace_create_file(const char *name,
>  				 void *data,
>  				 const struct file_operations *fops);
>  
> -
>  /**
>   * tracer_tracing_is_on_cpu - show real state of ring buffer enabled on for a cpu
>   * @tr : the trace array to know if ring buffer is enabled
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index dbe29b4c6a7a..2ca2541c8a58 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -61,7 +61,8 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
>  		v = memparse(p, NULL);
>  		if (v < PAGE_SIZE)
>  			pr_err("Buffer size is too small: %s\n", p);
> -		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
> +		if (trace_array_is_readonly(tr) ||
> +		    tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
>  			pr_err("Failed to resize trace buffer to %s\n", p);
>  	}
>  
> @@ -597,7 +598,7 @@ trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
>  
>  	p = xbc_node_find_value(node, "tracer", NULL);
>  	if (p && *p != '\0') {
> -		if (tracing_set_tracer(tr, p) < 0)
> +		if (trace_array_is_readonly(tr) || tracing_set_tracer(tr, p) < 0)
>  			pr_err("Failed to set given tracer: %s\n", p);
>  	}
>  
