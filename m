Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FBC22F01;
	Sun,  8 Feb 2026 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770523573; cv=none; b=tQEgduhmgdjfZ2tsgzTy9Q+zPjYw12atMpiTL6Yd/2Irw5qTmV/i7SGtDrAhAT2Rel70hqHfS1lezM3Cc8yY3l3yVGSW50PoZXzhgqRikH/wnF4DLKEuwdvLf9xnmce5g4aQHZ7CLvv54Yp9Fk60j1lp3NVLnRrVppBgob3dJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770523573; c=relaxed/simple;
	bh=qhPFfNy0/STpcM79qX0r7AcqDjTQr3MIE6wNy1Vpx84=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JzFEohKpiDWcSEQjpV6d4VVxmc5AEKtbxtLgCST+F378qQK7ouT3X3l38g1XBk8Lg2FSPFZ5RgXRaFeetmf5QVsNfkd0zSIH1zw0wvPD5ax9eg6S5Az8D9HDKumk8a8Lb/gNd/rSbQZWPCrZrv/0CKIf7NCe/1GFcQldf5XRa6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Woo39r9c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Woo39r9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDF1C4CEF7;
	Sun,  8 Feb 2026 04:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770523573;
	bh=qhPFfNy0/STpcM79qX0r7AcqDjTQr3MIE6wNy1Vpx84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Woo39r9ciJPyiVt/0xbB2P+4GE3wOZDu4mQcRzYAlKEToXF1YqOANHzBH4dIYKTZ/
	 4A7TwEX1lOgguA49gXwmckqzGlZyeWrqfjBbv7zdSdqKMnJoirb8R3+yIgKoDXElvm
	 JS79L25PR9FSSgMnXxEQxeMQTDAb+2wm7vMD3VMRuv9VB0h2Xg5knHCO3+0i2h7krE
	 9nkjntxZvgJaWoYQkK3X8qiMaegGSKpDVwhuHzlh4GB2a4yCj9E+3xn5bNNbq7wS3l
	 HzZvkmZ7Kf+CMMVqxxxaQvJmwknXn6eTDCEAFU4zEgMcmc7yd6dLFU88SHukYBj2G/
	 V1xnEomnkZbsg==
Date: Sun, 8 Feb 2026 13:06:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Have all triggers expect a file parameter
Message-Id: <20260208130608.5de71fa94f9a4ef28286c84a@kernel.org>
In-Reply-To: <20260206101351.609d8906@gandalf.local.home>
References: <20260206101351.609d8906@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 10:13:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the triggers were first created, they may not have had a file
> parameter passed to them and things needed to be done generically.
> 
> But today, all triggers have a file parameter passed to them. Remove the
> generic code and add a "if (WARN_ON_ONCE(!file))" to each trigger.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_trigger.c | 62 +++++++++++------------------
>  1 file changed, 24 insertions(+), 38 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 06b75bcfc7b8..7fa26327c9c7 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1347,18 +1347,13 @@ traceon_trigger(struct event_trigger_data *data,
>  {
>  	struct trace_event_file *file = data->private_data;
>  
> -	if (file) {
> -		if (tracer_tracing_is_on(file->tr))
> -			return;
> -
> -		tracer_tracing_on(file->tr);
> +	if (WARN_ON_ONCE(!file))
>  		return;
> -	}
>  
> -	if (tracing_is_on())
> +	if (tracer_tracing_is_on(file->tr))
>  		return;
>  
> -	tracing_on();
> +	tracer_tracing_on(file->tr);
>  }
>  
>  static bool
> @@ -1368,13 +1363,11 @@ traceon_count_func(struct event_trigger_data *data,
>  {
>  	struct trace_event_file *file = data->private_data;
>  
> -	if (file) {
> -		if (tracer_tracing_is_on(file->tr))
> -			return false;
> -	} else {
> -		if (tracing_is_on())
> -			return false;
> -	}
> +	if (WARN_ON_ONCE(!file))
> +		return false;
> +
> +	if (tracer_tracing_is_on(file->tr))
> +		return false;
>  
>  	if (!data->count)
>  		return false;
> @@ -1392,18 +1385,13 @@ traceoff_trigger(struct event_trigger_data *data,
>  {
>  	struct trace_event_file *file = data->private_data;
>  
> -	if (file) {
> -		if (!tracer_tracing_is_on(file->tr))
> -			return;
> -
> -		tracer_tracing_off(file->tr);
> +	if (WARN_ON_ONCE(!file))
>  		return;
> -	}
>  
> -	if (!tracing_is_on())
> +	if (!tracer_tracing_is_on(file->tr))
>  		return;
>  
> -	tracing_off();
> +	tracer_tracing_off(file->tr);
>  }
>  
>  static bool
> @@ -1413,13 +1401,11 @@ traceoff_count_func(struct event_trigger_data *data,
>  {
>  	struct trace_event_file *file = data->private_data;
>  
> -	if (file) {
> -		if (!tracer_tracing_is_on(file->tr))
> -			return false;
> -	} else {
> -		if (!tracing_is_on())
> -			return false;
> -	}
> +	if (WARN_ON_ONCE(!file))
> +		return false;
> +
> +	if (!tracer_tracing_is_on(file->tr))
> +		return false;
>  
>  	if (!data->count)
>  		return false;
> @@ -1481,10 +1467,10 @@ snapshot_trigger(struct event_trigger_data *data,
>  {
>  	struct trace_event_file *file = data->private_data;
>  
> -	if (file)
> -		tracing_snapshot_instance(file->tr);
> -	else
> -		tracing_snapshot();
> +	if (WARN_ON_ONCE(!file))
> +		return;
> +
> +	tracing_snapshot_instance(file->tr);
>  }
>  
>  static int
> @@ -1570,10 +1556,10 @@ stacktrace_trigger(struct event_trigger_data *data,
>  {
>  	struct trace_event_file *file = data->private_data;
>  
> -	if (file)
> -		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
> -	else
> -		trace_dump_stack(STACK_SKIP);
> +	if (WARN_ON_ONCE(!file))
> +		return;
> +
> +	__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
>  }
>  
>  static int
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
