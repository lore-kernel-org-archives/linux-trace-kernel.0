Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA421F463E;
	Tue, 18 Nov 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490858; cv=none; b=lorCrYB3k3MW7pLJ+fN3TwfxdiyxJ8UjCRKGEE8zYHqERBrwb04jA9pzoclogPmnuhDge3JlAtob3pgyosiC+MsPeaUwXh6ATXbDyOlOpC+xBGpR6zE/p8V1YL2nCXBn3SnN5d/ApJHI2CPfBKwxs7mYb6xyrsQocX6rO9rFBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490858; c=relaxed/simple;
	bh=sq+78rYhq5teXmnUM/zfpLBkeH/Wd1UwHj6V7fJ8QxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGIYqp1PbCVE0LWyn1B1N/f/mPekAiJiNRYRi4EMQBvAxeFk8B6Jzq76/E3dsePRsH4VTv0SFRTs5pupC2mL/dq5eLmitGBnb98a+cnB9XIkzaVyWjbt4+tyE71UVH11Yh+dBL79w3j8TvF3ZsCdCBvsxJGETTJstPfon3WVcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B878E14019B;
	Tue, 18 Nov 2025 18:34:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id D74DF80011;
	Tue, 18 Nov 2025 18:34:06 +0000 (UTC)
Date: Tue, 18 Nov 2025 13:34:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Show the tracer options in boot-time created
 instance
Message-ID: <20251118133434.67def626@gandalf.local.home>
In-Reply-To: <176345219055.1127138.4292126981726580037.stgit@mhiramat.tok.corp.google.com>
References: <176345219055.1127138.4292126981726580037.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6whqxk1cy4argsxsfioecj1k5mi8x8bx
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: D74DF80011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX194jAR60e4sob+9EUakCDAhsH6d0oSiMw4=
X-HE-Tag: 1763490846-634579
X-HE-Meta: U2FsdGVkX1+KVUWNEunkG4OU1YUaUff6WJhsTlb9gk16qPF9uFqNZ5q1TGWwRBjZZPJom0D1Ca65Q+zN/L9tiSdxmU7bxwEIVbjUorckY2DaFEHr/R30oYmi/SaKP/I1TRwW3+0ioP1cFIAQhkWq3TiCNm+ESEK3ji3EofM/XAgYm8f740ozBxmAH6/z6r8iZsq+fZdUiHeIeB9lOKDlGzNtXviOi0R51T347rluBeI3U8Ne3ldUUvMCNSzvgSarKdtJWeoGzFS/nHq4/3V/oG9yzJtmDgn9WRzFmHF7+S893TKFEcr/W6+Tg9Ord/3hcF1ReKFM/DmOV7PeAzuT7SY7zdFCtGpc

On Tue, 18 Nov 2025 16:49:50 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since tracer_init_tracefs_work_func() only updates the tracer options
> for the global_trace, the instances created by the kernel cmdline
> do not have those options.
> 
> Fix to update tracer options for those boot-time created instances
> to show those options.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Fixes: f20a580627f43 ("ftrace: Allow instances to use function tracing")

Actually, I think this should be:

Fixes: 428add559b69 ("tracing: Have tracer option be instance specific")

As it broke when we made function tracer options no longer global.

> ---
>  kernel/trace/trace.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8ae95800592d..2e87060e1d5a 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10903,6 +10903,7 @@ static struct notifier_block trace_module_nb = {
>  
>  static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  {
> +	struct trace_array *tr;
>  
>  	event_trace_init();
>  
> @@ -10937,7 +10938,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  
>  	create_trace_instances(NULL);
>  
> -	update_tracer_options(&global_trace);
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list)
> +		update_tracer_options(tr);
>  }
>  
>  static __init int tracer_init_tracefs(void)

Since update_trace_options() is only called by this function, instead of
doing the loop here, change the function to be:

static __init void update_tracer_options(void)
{
	struct trace_array *tr;

	guard(mutex)(&trace_types_lock);
	tracer_options_updated = true;
	list_for_each_entry(tr, &ftrace_trace_arrays, list)
		__update_tracer_options(tr);
}

Thanks,

-- Steve
