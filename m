Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313972D836D;
	Thu, 14 May 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783331; cv=none; b=sV2NYN12r3pGrEcSjCJ3XiNtfH0FSoCtQOMGH6mDo+l3E65vqDBfzq+qMqWbraoeWdmEs5msH2Drp4b/G97/cMG91Wwqp7nXKc15sq1qapc2AISEpGIm2SiB4uIBX/hj/uZg7d1aujgHGeexTMZK6TfiSOc/z9gEPJ+66+pdTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783331; c=relaxed/simple;
	bh=A0xbDquRvnyW2D8cpPeGpARcAjX2yjAc8rCfXyXZ+m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbVdjR8UKinhf1fZXhQYA6oY+hKNiwY+BkFnHs/k/g9ZiJkUWvp9W6cvZGH5ewhOg2QAtv4GxeojpCO89FuQ2cvganm6+r+3nX/wvx9K8uH8MbR/9/5rXvbyDsm2nAPj1uEz19meq11F0w1CW8QY8PrQrj1WhtNw79jIWR6zaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdpXsltz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdpXsltz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E22C2BCB3;
	Thu, 14 May 2026 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778783331;
	bh=A0xbDquRvnyW2D8cpPeGpARcAjX2yjAc8rCfXyXZ+m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdpXsltzlfr6ukk9YEDrM7fqZ7N58jmotCJRI9ZG/OYZmpJM9ZoG/RdUKOQOcvZ7w
	 rCdQ+M8C0BP1nGiZPEci0Ln0IMzCdSm2YXqnxezLpER4UueG4c0No2UYx3itVpkw0P
	 8vkUzdnX4u+KW833UBQmpIe5p2xDRl8B/4+RfCkFx76qGT3nldjx+t8L4u0RgsISsg
	 nH/3JqrhQR5jQxO+NcQRZVTj4FQBAc18qTQwNpdunTed2e3dFhOV4MNI/VQok0x3gi
	 MXe2ju0FYxiwZp0AnPSA06y4aJoc+WoJLGFCTdpq6IPcghVove8XLw7swRcYnOZKC/
	 xFkK1bXSAdaqQ==
Date: Thu, 14 May 2026 11:28:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2] tracing: Allow perf to read synthetic events
Message-ID: <agYUXoDOjXGvOMSi@google.com>
References: <20260513150007.3b280e87@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513150007.3b280e87@gandalf.local.home>

On Wed, May 13, 2026 at 03:00:07PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Currently, perf can not enable synthetic events. When it does, it either
> causes a warning in the kernel or errors with "no such device".
> 
> Add the necessary code to allow perf to also attach to synthetic events.
> 
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Changes since v1: https://patch.msgid.link/20251217113920.50b56246@gandalf.local.home
> 
> - Forward ported to v7.1-rc2
> 
>  kernel/trace/trace_events_synth.c | 121 +++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 39ac4eba0702..e6871230bde9 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -499,28 +499,19 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
>  	return len;
>  }
>  
> -static void trace_event_raw_event_synth(void *__data,
> -					u64 *var_ref_vals,
> -					unsigned int *var_ref_idx)
> +static __always_inline int get_field_size(struct synth_event *event,
> +					  u64 *var_ref_vals,
> +					  unsigned int *var_ref_idx)
>  {
> -	unsigned int i, n_u64, val_idx, len, data_size = 0;
> -	struct trace_event_file *trace_file = __data;
> -	struct synth_trace_event *entry;
> -	struct trace_event_buffer fbuffer;
> -	struct trace_buffer *buffer;
> -	struct synth_event *event;
> -	int fields_size = 0;
> -
> -	event = trace_file->event_call->data;
> -
> -	if (trace_trigger_soft_disabled(trace_file))
> -		return;
> +	int fields_size;
>  
>  	fields_size = event->n_u64 * sizeof(u64);
>  
> -	for (i = 0; i < event->n_dynamic_fields; i++) {
> +	for (int i = 0; i < event->n_dynamic_fields; i++) {
>  		unsigned int field_pos = event->dynamic_fields[i]->field_pos;
>  		char *str_val;
> +		int val_idx;
> +		int len;
>  
>  		val_idx = var_ref_idx[field_pos];
>  		str_val = (char *)(long)var_ref_vals[val_idx];
> @@ -535,18 +526,18 @@ static void trace_event_raw_event_synth(void *__data,
>  
>  		fields_size += len;
>  	}
> +	return fields_size;
> +}
>  
> -	/*
> -	 * Avoid ring buffer recursion detection, as this event
> -	 * is being performed within another event.
> -	 */
> -	buffer = trace_file->tr->array_buffer.buffer;
> -	guard(ring_buffer_nest)(buffer);
> -
> -	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> -					   sizeof(*entry) + fields_size);
> -	if (!entry)
> -		return;
> +static __always_inline void write_synth_entry(struct synth_event *event,
> +					      struct synth_trace_event *entry,
> +					      u64 *var_ref_vals,
> +					      unsigned int *var_ref_idx)
> +{
> +	int data_size = 0;
> +	int i, n_u64;
> +	int val_idx;
> +	int len;
>  
>  	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
>  		val_idx = var_ref_idx[i];
> @@ -587,10 +578,83 @@ static void trace_event_raw_event_synth(void *__data,
>  			n_u64++;
>  		}
>  	}
> +}
> +
> +static void trace_event_raw_event_synth(void *__data,
> +					u64 *var_ref_vals,
> +					unsigned int *var_ref_idx)
> +{
> +	struct trace_event_file *trace_file = __data;
> +	struct synth_trace_event *entry;
> +	struct trace_event_buffer fbuffer;
> +	struct trace_buffer *buffer;
> +	struct synth_event *event;
> +	int fields_size;
> +
> +	event = trace_file->event_call->data;
> +
> +	if (trace_trigger_soft_disabled(trace_file))
> +		return;
> +
> +	fields_size = get_field_size(event, var_ref_vals, var_ref_idx);
> +
> +	/*
> +	 * Avoid ring buffer recursion detection, as this event
> +	 * is being performed within another event.
> +	 */
> +	buffer = trace_file->tr->array_buffer.buffer;
> +	guard(ring_buffer_nest)(buffer);
> +
> +	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> +					   sizeof(*entry) + fields_size);
> +	if (!entry)
> +		return;
> +
> +	write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
>  
>  	trace_event_buffer_commit(&fbuffer);
>  }
>  
> +#ifdef CONFIG_PERF_EVENTS
> +static void perf_event_raw_event_synth(void *__data,
> +				       u64 *var_ref_vals,
> +				       unsigned int *var_ref_idx)
> +{
> +	struct trace_event_call *call = __data;
> +	struct synth_trace_event *entry;
> +	struct hlist_head *perf_head;
> +	struct synth_event *event;
> +	struct pt_regs *regs;
> +	int fields_size;
> +	size_t size;
> +	int context;
> +
> +	event = call->data;
> +
> +	perf_head = this_cpu_ptr(call->perf_events);
> +
> +	if (!perf_head || hlist_empty(perf_head))
> +		return;
> +
> +	fields_size = get_field_size(event, var_ref_vals, var_ref_idx);
> +
> +	size = ALIGN(sizeof(*entry) + fields_size, 8);
> +
> +	entry = perf_trace_buf_alloc(size, &regs, &context);
> +
> +	if (unlikely(!entry))
> +		return;
> +
> +	write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
> +
> +	perf_fetch_caller_regs(regs);
> +
> +	perf_trace_buf_submit(entry, size, context,
> +			      call->event.type, 1, regs,
> +			      perf_head, NULL);
> +}
> +#endif
> +
>  static void free_synth_event_print_fmt(struct trace_event_call *call)
>  {
>  	if (call) {
> @@ -917,6 +981,9 @@ static int register_synth_event(struct synth_event *event)
>  	call->flags = TRACE_EVENT_FL_TRACEPOINT;
>  	call->class->reg = synth_event_reg;
>  	call->class->probe = trace_event_raw_event_synth;
> +#ifdef CONFIG_PERF_EVENTS
> +	call->class->perf_probe = perf_event_raw_event_synth;
> +#endif
>  	call->data = event;
>  	call->tp = event->tp;
>  
> -- 
> 2.53.0
> 
