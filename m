Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032BA29;
	Wed, 19 Mar 2025 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391452; cv=none; b=UPD078bTEmzj+CbA9nboWQwfeOeus6L3AW/oYDyFN8Fdvi1xw4v+haYMvHdgnn+/vClf0fFMc7OMIRzB+9PIA/WW9tANJAyxIfxxFIbtwi6XnfE7A549V2oNKe8Dgw2YA3J4liNBovgOQzyH72s9uQTU4QtVwVuInl3LfftABPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391452; c=relaxed/simple;
	bh=335xjWhzRNUO+l7fGS7jF7TlC0bhYkjhGXDFTrQ28mI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NYqBq3b0KmUT/SSoTLvFhMUPDatjNWOG6k2tCGZbMUqwnu1zWsbg4T6/O26D9uXszaU+QFs/SkS7AQ4XVufQjQ7eg9zy5p76cfISHv+uarSltw5rZ9IyEtdTbg0ydwEImq3MK3uUiuGyijB00z9miZGQ0d7C61Df/U9SkNi8sIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLS6/Hat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLS6/Hat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B57C4CEE9;
	Wed, 19 Mar 2025 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742391452;
	bh=335xjWhzRNUO+l7fGS7jF7TlC0bhYkjhGXDFTrQ28mI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XLS6/Hat4Pj77LW9INJB/RXwRIJ4eqUG7PxG9A/CH1YmWhkIdi1RJtLpM3cq9UOjY
	 zTyjAe4CUkLLh4tDZ16euxc5RW3V+kXH2jqqP3K2BMOnPm+e/a5yzJahbl9UPxG6JG
	 qkm2N8+aFwwctW9+lKaFb0AZnq+plJUbbu/y5f1wJcbbtxdAqGRKOjYR5jEh5cTMUq
	 cYT5QWV6Inl6IZKfU3zXRpQJ/EszpriMYOt9eiHDMC2kjG2t46czjEEIKYb4Qe3M3k
	 LFAdAmFpzCJE3RXFodGZrjRXqB/KneKhhIwDarRhLHHtZ13PpYbuie7eVmTSGN/abx
	 0SJB7yo5Afhxg==
Date: Wed, 19 Mar 2025 22:37:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Douglas RAILLARD <douglas.raillard@arm.com>
Cc: rostedt@goodmis.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: Rename trace_synth() to
 synth_event_trace2()
Message-Id: <20250319223728.ca7a5ac6fa37798d17bd2e29@kernel.org>
In-Reply-To: <20250318180814.226644-3-douglas.raillard@arm.com>
References: <20250318180814.226644-1-douglas.raillard@arm.com>
	<20250318180814.226644-3-douglas.raillard@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 18:08:12 +0000
Douglas RAILLARD <douglas.raillard@arm.com> wrote:

> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Rename the frehsly exposed trace_synth() to synth_event_trace2() to
> comply with the existing naming convention. Since synth_event_trace()
> already exists (and operates on a "struct trace_event_file *"), use a
> new name for it.
> 

I don't like this '2' and similar version digit naming for the functions.
Can you choose another better name?

BTW, can you also write a cover mail so that what is the goal of this
series, background and results?

Thank you,

> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  include/linux/trace_events.h      | 2 +-
>  kernel/trace/trace_events_hist.c  | 2 +-
>  kernel/trace/trace_events_synth.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index e069d84a73f0..753ce8aecfe4 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -521,7 +521,7 @@ struct synth_event;
>  
>  extern struct synth_event *synth_event_find(const char *name);
>  
> -extern void trace_synth(struct synth_event *event, u64 *var_ref_vals,
> +extern void synth_event_trace2(struct synth_event *event, u64 *var_ref_vals,
>  			       unsigned int *var_ref_idx);
>  
>  extern int synth_event_delete(const char *name);
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 7067f6fedb1a..ee0fee123c91 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -822,7 +822,7 @@ static void action_trace(struct hist_trigger_data *hist_data,
>  {
>  	struct synth_event *event = data->synth_event;
>  
> -	trace_synth(event, var_ref_vals, data->var_ref_idx);
> +	synth_event_trace2(event, var_ref_vals, data->var_ref_idx);
>  }
>  
>  struct hist_var_data {
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 4a9a44d37ffc..8837aa258479 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -850,7 +850,7 @@ EXPORT_SYMBOL_GPL(synth_event_find);
>  typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
>  				    unsigned int *var_ref_idx);
>  
> -void trace_synth(struct synth_event *event, u64 *var_ref_vals,
> +void synth_event_trace2(struct synth_event *event, u64 *var_ref_vals,
>  			       unsigned int *var_ref_idx)
>  {
>  	struct tracepoint *tp = event->tp;
> @@ -873,7 +873,7 @@ void trace_synth(struct synth_event *event, u64 *var_ref_vals,
>  		}
>  	}
>  }
> -EXPORT_SYMBOL_GPL(trace_synth);
> +EXPORT_SYMBOL_GPL(synth_event_trace2);
>  
>  static struct trace_event_fields synth_event_fields_array[] = {
>  	{ .type = TRACE_FUNCTION_TYPE,
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
