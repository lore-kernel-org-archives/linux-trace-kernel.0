Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7234D381;
	Mon, 10 Nov 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762753709; cv=none; b=KgcWCGa+LmMT1DseyjbxtMcndin6D/EksF8iQ8CuLdii7cRNNdqMqu4HzprYdIu0xCt46GTRO3J/qZziGxOMiL0tlpoUvLKAubi67W7hndRwK2DcGNifGk17yr2TwnzaupiaW2faaZaFxNizlMfYV8MsGhsmSV8MulXMZPnBcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762753709; c=relaxed/simple;
	bh=FEGMIRfi+HxXqdTYkmJ5HNEZwzhK8LobI4wcmVPJ/y4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sf3dbhgUXCWppJq16UOUwevvNP6t7ZL8Id/h5Q3le/ccA/gbBAWx2XCLNs5OFzK++Jo5e/Abu4Waw0YsUsCq6bjoE5CuMoKMkjVu+RCHhppWkO2EsS0Ko7eEN9warxrkmCdYJSSZLxvVGFjXZOjLIvkzUlfYckTejXIWMAA4Jio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egl+TR/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egl+TR/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F3AC4CEFB;
	Mon, 10 Nov 2025 05:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762753709;
	bh=FEGMIRfi+HxXqdTYkmJ5HNEZwzhK8LobI4wcmVPJ/y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egl+TR/rf8oBgu6QNIxmfN79IlwLZWmXPbE/E9mCKW5Dp1jbszG7sUCGWALSe4tbI
	 vaKIIaau9uLHYFpoYxzk8cFffRuFYvlKahFUbqGptcG3mE0of3FeIm52vB+6pM4hIV
	 bTorj3mpfwb1Ur+s9QH0evbTcQmBXcJCqd2+IqJ5m4m8SSulv2TZXrlI77iggaB8eZ
	 OQfVs907YwCiJX/nCAkbL3qKK6tdpHAHGFyy7jzOqCROOWTLs/J11yQv2hhWgd+20h
	 x014WnTL9nI1KNJ8sqZQTkkm9Qy2/GZpDCxg7NwkIb7qzqIdxTMgfxHSyszAWhfFEa
	 3NzV4P+vPZCYQ==
Date: Mon, 10 Nov 2025 14:48:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] tracing: Use switch statement instead of ifs in
 set_tracer_flag()
Message-Id: <20251110144826.8d92d83af67efebac2a3ecf5@kernel.org>
In-Reply-To: <20251106003501.890298562@kernel.org>
References: <20251106003324.964761749@kernel.org>
	<20251106003501.890298562@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Nov 2025 19:33:26 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The "mask" passed in to set_trace_flag() has a single bit set. The
> function then checks if the mask is equal to one of the option masks and
> performs the appropriate function associated to that option.
> 
> Instead of having a bunch of "if ()" statement, use a "switch ()"
> statement instead to make it cleaner and a bit more optimal.
> 
> No function changes.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, set_tracer_flag() seems to expect to modify only one bit.
If we can count the number of its in @mask and reject if it is
not 1, we can use bit-mask instead of the first switch()?

	if (!mask ||	/* mask has no bit */
	    (mask & ~(1 << (ffs64(mask) - 1))))	/* mask has more than 2 bits */
		return -EINVAL;

Thanks,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 07bd10808277..8460bec9f263 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5251,11 +5251,13 @@ int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
>  
>  int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  {
> -	if ((mask == TRACE_ITER(RECORD_TGID)) ||
> -	    (mask == TRACE_ITER(RECORD_CMD)) ||
> -	    (mask == TRACE_ITER(TRACE_PRINTK)) ||
> -	    (mask == TRACE_ITER(COPY_MARKER)))
> +	switch (mask) {
> +	case TRACE_ITER(RECORD_TGID):
> +	case TRACE_ITER(RECORD_CMD):
> +	case TRACE_ITER(TRACE_PRINTK):
> +	case TRACE_ITER(COPY_MARKER):
>  		lockdep_assert_held(&event_mutex);
> +	}
>  
>  	/* do nothing if flag is already set */
>  	if (!!(tr->trace_flags & mask) == !!enabled)
> @@ -5266,7 +5268,8 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  		if (tr->current_trace->flag_changed(tr, mask, !!enabled))
>  			return -EINVAL;
>  
> -	if (mask == TRACE_ITER(TRACE_PRINTK)) {
> +	switch (mask) {
> +	case TRACE_ITER(TRACE_PRINTK):
>  		if (enabled) {
>  			update_printk_trace(tr);
>  		} else {
> @@ -5283,9 +5286,9 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  			if (printk_trace == tr)
>  				update_printk_trace(&global_trace);
>  		}
> -	}
> +		break;
>  
> -	if (mask == TRACE_ITER(COPY_MARKER)) {
> +	case TRACE_ITER(COPY_MARKER):
>  		update_marker_trace(tr, enabled);
>  		/* update_marker_trace updates the tr->trace_flags */
>  		return 0;
> @@ -5296,10 +5299,12 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  	else
>  		tr->trace_flags &= ~mask;
>  
> -	if (mask == TRACE_ITER(RECORD_CMD))
> +	switch (mask) {
> +	case TRACE_ITER(RECORD_CMD):
>  		trace_event_enable_cmd_record(enabled);
> +		break;
>  
> -	if (mask == TRACE_ITER(RECORD_TGID)) {
> +	case TRACE_ITER(RECORD_TGID):
>  
>  		if (trace_alloc_tgid_map() < 0) {
>  			tr->trace_flags &= ~TRACE_ITER(RECORD_TGID);
> @@ -5307,24 +5312,27 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  		}
>  
>  		trace_event_enable_tgid_record(enabled);
> -	}
> +		break;
>  
> -	if (mask == TRACE_ITER(EVENT_FORK))
> +	case TRACE_ITER(EVENT_FORK):
>  		trace_event_follow_fork(tr, enabled);
> +		break;
>  
> -	if (mask == TRACE_ITER(FUNC_FORK))
> +	case TRACE_ITER(FUNC_FORK):
>  		ftrace_pid_follow_fork(tr, enabled);
> +		break;
>  
> -	if (mask == TRACE_ITER(OVERWRITE)) {
> +	case TRACE_ITER(OVERWRITE):
>  		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
>  #ifdef CONFIG_TRACER_MAX_TRACE
>  		ring_buffer_change_overwrite(tr->max_buffer.buffer, enabled);
>  #endif
> -	}
> +		break;
>  
> -	if (mask == TRACE_ITER(PRINTK)) {
> +	case TRACE_ITER(PRINTK):
>  		trace_printk_start_stop_comm(enabled);
>  		trace_printk_control(enabled);
> +		break;
>  	}
>  
>  	return 0;
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
