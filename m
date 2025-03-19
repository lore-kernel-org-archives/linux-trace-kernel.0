Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D31253B60;
	Wed, 19 Mar 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390999; cv=none; b=B6oHiLkd8/BwOytLxkGpVMpeytGCcQMz2w1pc/V0DD55PejsObIq5CALF+8aYvQfFflQBaNU57/l+litnS5uKxKQD9YhPrXV0jTs4vqvHgkYTOvUYJOzmIPb479DNzKVqFbAfYwFvn3fMjT9zb05uHuoyUNH7PW0qBGZNmxgZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390999; c=relaxed/simple;
	bh=L3zkG5wkdf9levIxPwOzxunDMgNfSmvM+Dhstn7lFMs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r5EPCTglQE9zJcGsc02h9v0+6x1xA5/9vjj1qN4DVE3LwOfCy0xlDcBetiKU534cy9qgP6CeoWRNk1M3RAb+xXDtf1Kcos56BA1DiFlLs0SbyKHi6pS8jZe2n9u0EOhfTyzOyoCeFBhi5deE6KbzBm3e3+g/7TBXtqtFIAAVQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5LvZbzD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5LvZbzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CDC4CEE9;
	Wed, 19 Mar 2025 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742390997;
	bh=L3zkG5wkdf9levIxPwOzxunDMgNfSmvM+Dhstn7lFMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5LvZbzDHkwilSgVWZ5dAnzNuav8+5oNYdF/MIr7MBiXYz3MuPO3YRoq12u5YC4vg
	 nHlJztUkZWG2rplLgMB2Y3prRqiOm9MGkgT5Bnbb20VlskXgYq1zL2GYEkv6bPEoT2
	 iOBIRE76JyX9Y9qxc2qszU8mu3Yso9k3njeC9ruOqmH1QIaPtyqr4JTMGezfAjeLov
	 FzCYbB/oprB8y/lMg4XKfS4/Mof45vnb5X2wUSLk4AsVY1kIZkQCdBXbs09QdM4eAt
	 tBdpOxSBa/E+ayPilaML2LRylEoiuYWtolxiKzrlMqKFa5sTHOB3KJV7s9Y0p77Pp8
	 uBNTtQnoZrtIQ==
Date: Wed, 19 Mar 2025 22:29:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Douglas RAILLARD <douglas.raillard@arm.com>
Cc: rostedt@goodmis.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Ensure module defining synth event cannot be
 unloaded while tracing
Message-Id: <20250319222953.3c741b520a8686c8e0a9b1d9@kernel.org>
In-Reply-To: <20250318180906.226841-1-douglas.raillard@arm.com>
References: <20250318180906.226841-1-douglas.raillard@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 18:09:05 +0000
Douglas RAILLARD <douglas.raillard@arm.com> wrote:

> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Currently, using synth_event_delete() will fail if the event is being
> used (tracing in progress), but that is normally done in the module exit
> function. At that stage, failing is problematic as returning a non-zero
> status means the module will become locked (impossible to unload or
> reload again).
> 
> Instead, ensure the module exit function does not get called in the
> first place by increasing the module refcnt when the event is enabled.
> 

OK, I think this is correct way to fix that scenario.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  kernel/trace/trace_events_synth.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index e3f7d09e5512..bb7ef6e76991 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -852,6 +852,34 @@ static struct trace_event_fields synth_event_fields_array[] = {
>  	{}
>  };
>  
> +static int synth_event_reg(struct trace_event_call *call,
> +		    enum trace_reg type, void *data)
> +{
> +	struct synth_event *event = container_of(call, struct synth_event, call);
> +
> +	switch (type) {
> +	case TRACE_REG_REGISTER:
> +	case TRACE_REG_PERF_REGISTER:
> +		if (!try_module_get(event->mod))
> +			return -EBUSY;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	int ret = trace_event_reg(call, type, data);
> +
> +	switch (type) {
> +	case TRACE_REG_UNREGISTER:
> +	case TRACE_REG_PERF_UNREGISTER:
> +		module_put(event->mod);
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +
>  static int register_synth_event(struct synth_event *event)
>  {
>  	struct trace_event_call *call = &event->call;
> @@ -881,7 +909,7 @@ static int register_synth_event(struct synth_event *event)
>  		goto out;
>  	}
>  	call->flags = TRACE_EVENT_FL_TRACEPOINT;
> -	call->class->reg = trace_event_reg;
> +	call->class->reg = synth_event_reg;
>  	call->class->probe = trace_event_raw_event_synth;
>  	call->data = event;
>  	call->tp = event->tp;
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
