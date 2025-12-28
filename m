Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDC285C99
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Dec 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766962780; cv=none; b=NSPaLm/84BJ/eSOzXijVyzu4pf7NVrJO3hL9UgyPgqi4y3pHuKHQespFtmAxUCFDG0z4dxtFzTrwosREbO3SzQ2b2GrvemfWUracJNlzh/BGIHIzH5wurE9oTk2XQPGFyHnpRPZmfoAbk68Y7DtVOhTAuOwP1z2kDe/130uyOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766962780; c=relaxed/simple;
	bh=SnI/sZneONUNTFINlR52iLxzEy1RPhmaeCVzPxkT7IA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe1onDj4badiUOgIUDihsmG8SIOBTc4TA/SHNyAdleLutPI/nbYdPs4S0of9lMJz1pYUAO4IjcYUZ9A2VM5mNMzpIK/AsZabgcCCWETs9O5LptBXgu/YT2rsma5SWAZzLipwIHcDUaaWckukVTGSIrrQjQ2OonHNGeJym8116AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1fopVA3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1fopVA3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775ae77516so84501365e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Dec 2025 14:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766962777; x=1767567577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf2bXjhDilXWzzb4SUI4bAUZ6hOhvd01u3js7UteToY=;
        b=h1fopVA3OVfsrSOJ0Gnc9/f4aCYBvnesplfFZflo/+VB5F2Ir4RTorY0GyqmpsIZgq
         Jh3Iw+GtD7q44J85BEEko9mgnAHHLZ2o3ZKI4CvRgMDbGel6nH12Ov/vZ7Hd78ib+yQU
         8T71iW28goX5ErWyJ1amvtZ67Qi+5q5tV6K59/dHzF2V4mhly90AJbHEWTLHmp42v6/s
         HJBcuWPjQXwh6XrZTP3UFvtczK+Gr23kkt8auRRr3AC5CoFpYvQXczUfnIqJ3O4jI3hz
         Wp62TqmCdN7j/U4nJQMzN2rFfWmCStsbdwuc44mUd4YHuiSWvvuiB420YnTK3CB0kCst
         ioeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766962777; x=1767567577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bf2bXjhDilXWzzb4SUI4bAUZ6hOhvd01u3js7UteToY=;
        b=hLd2XZzwO25KZ5luoBmMQfuDRknhKkjM28XRfsPMbwJmWSERVLqqYdw9gxNNQOUCnY
         VsAuuaZhhOi6Ds2KclgTTq5NijZ5pbVza/j+oL2vooGmPdZ0kVmJ8OTg3DuVodDITIkO
         weT7s2sDyT7KuYUrsmqDOW8DOEmrTd+wbVj7AytHhRnR9BPogV6+oGksbfBl2It5G9eG
         9adEJ/MAbWFs9rxZkebCMn2PTHJ6bpeZpwziaJmbXEqLNjPmgisJXy87i9F0VMUEZS6M
         rMATcsMG47iBoNOIcMF8kN9IE4yFSaK8tDJHdZE7NuVc/hPOuRQFxYPNTnr+iM5OYBjW
         h5gg==
X-Forwarded-Encrypted: i=1; AJvYcCWF6/f5lUSCkZT3WE92SPL0Ly//rdY2pt6EEcBgdQwzz3TDzBVZGsvbC/kCC2dmgKBKyszyLcEHhEUiRNKLmFbcGP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJWKIVpaZbiSTwimQYrbyisI5uM8R5dS72W5KzXdn7yG0Kdva
	f14YGHmlGj97B/Brh63xEF2eEfdI646sNj5zAUqyAjjlpRk3N04bSk1E
X-Gm-Gg: AY/fxX7y+Dx4N2hx3TWpC4TUZ6c6dDUvz5hekVkdOOcPOgD0oLnDZhwjhddfAclRF9t
	wbrGdd/bvpXqh+BexFq68Tw6UZKHqcyMig70vAUzC7cZVP0cnEZi2j1bX3hUG2vrbH/DWu3tKxm
	hNxYFFUvnpxDZ4iCb7FzXzYkjhkPgVp09+DUJwskMOD46tuAuuDNHS4udCiQhdZx/KtwTQfPZTs
	dYjVxxS+KxgHMcWuvYgn2diWaB6k2OclDjhqbfC4XjgclVP2VfMcIEoK2m5VY0iLSGFBxNPuDfn
	3SnscfEVSMQR6lE+zZ+G7+Ae3RvhhqZKyAF/yd0xRBdQDfYtxmwCp/fZVvKSIIRx3uVqywiqg6W
	/+klAK5MzmeMmevBrIFnnb67/LytLA24qhcCp3Izw7BYnLC+vrrMIJKA4OKAWBOH560D/1ETEYl
	c=
X-Google-Smtp-Source: AGHT+IHdkP7yesZaXjkos2ZAbiaBQ5KnJuaSa4FqfVZRSZQZMMqUiM/aT1sIN8tSR+ZFzDYT867HiA==
X-Received: by 2002:a05:600c:4fd3:b0:477:63b5:6f39 with SMTP id 5b1f17b1804b1-47d195a702bmr279842115e9.19.1766962776938;
        Sun, 28 Dec 2025 14:59:36 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432613f7e6esm48079487f8f.21.2025.12.28.14.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 14:59:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 28 Dec 2025 23:59:34 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Allow perf to read synthetic events
Message-ID: <aVG2VoBpFoEEE1gG@krava>
References: <20251217113920.50b56246@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217113920.50b56246@gandalf.local.home>

On Wed, Dec 17, 2025 at 11:39:20AM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Currently, perf can not enable synthetic events. When it does, it either
> causes a warning in the kernel or errors with "no such device".
> 
> Add the necessary code to allow perf to also attach to synthetic events.
> 
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

hi,
I don't see the crash, but perf record/script gives me 'FAILED TO PARSE' in perf script:

  # cd /sys/kernel/tracing
  # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
  # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=common_stacktrace  if prev_state == 2' >> events/sched/sched_switch/trigger
  # echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(block_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
  # echo 1 > events/synthetic/block_lat/enable

  # perf record -e 'synthetic:block_lat' -a
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.259 MB perf.data (1 samples) ]
  # perf script
  kworker/u33:2-w     244 [000]  1707.836263: synthetic:block_lat: [FAILED TO PARSE] pid=244 delta=21 stack=ARRAY[0b, 00, 00, 00, 00, 00, 00, 00, 1d, 72, 9d, 82, ff, ff, ff, ff, 0d, 7d, 9d, 82, ff, ff, ff, ff, 3d, 3d, 9e, 82, ff, ff, ff, ff, 05, 91, 9d, 82, ff, ff, ff, ff, 40, 7a, 42, 81, ff, ff, ff, ff, 5e, f4, 0c, 82, ff, ff, ff, ff, 43, 8d, 0c, 82, ff, ff, ff, ff, 82, 2d, 89, 81, ff, ff, ff, ff, 9b, 39, 89, 81, ff, ff, ff, ff, a6, 5a, 9c, 82, ff, ff, ff, ff, 2f, 01, 00, 81, ff, ff, ff, ff]

not sure it's fixed in the latest libtraceevent, mine is
  libtraceevent-1.8.4-3.fc42.x86_64

jirka


> ---
>  kernel/trace/trace_events_synth.c | 121 +++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 4554c458b78c..026e06f28958 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -493,28 +493,19 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
>  	return len;
>  }
>  
> -static notrace void trace_event_raw_event_synth(void *__data,
> -						u64 *var_ref_vals,
> -						unsigned int *var_ref_idx)
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
> @@ -529,18 +520,18 @@ static notrace void trace_event_raw_event_synth(void *__data,
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
> @@ -581,10 +572,83 @@ static notrace void trace_event_raw_event_synth(void *__data,
>  			n_u64++;
>  		}
>  	}
> +}
> +
> +static notrace void trace_event_raw_event_synth(void *__data,
> +						u64 *var_ref_vals,
> +						unsigned int *var_ref_idx)
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
> +static notrace void perf_event_raw_event_synth(void *__data,
> +					       u64 *var_ref_vals,
> +					       unsigned int *var_ref_idx)
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
> @@ -911,6 +975,9 @@ static int register_synth_event(struct synth_event *event)
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
> 2.51.0
> 
