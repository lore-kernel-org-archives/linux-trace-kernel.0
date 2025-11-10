Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5B19F13F;
	Mon, 10 Nov 2025 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752288; cv=none; b=Ag4NT+7cQG/7+vh7PKJy+LpqNafGAx7D9+LmplYyxRJtmHbsw9LOyE3TvHIi4cvAK+zvehI3DdaaDx+fyDihg/aEm248HYVibCO3Y5DXqO+yaKF9xTRFyYkjw56rGhoeieDbKRQ0L2sKfIYumMRHfGbkOiRRpha06rDqinp18GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752288; c=relaxed/simple;
	bh=gdk7UxmkEKvvMHc9kBpLd+XXCzH6cFQwNXy7/F1XAqc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tMn+aBm4+AR1V77gY2BYsAGhy4K2qGuqpDkUypwSv9yAw1Q05Cb9iQ9LB08C8Uys57H95DmsNuM/6gVDxLMeSE8I6UsYoWFU5k6qp0emkkz0JruzgcmMLHnp5E1kpPKg3VnnaK2oxMpZOI8Mt0LbQvE8NN/KldsL83P52n/B8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAiJFsC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAiJFsC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A82C116D0;
	Mon, 10 Nov 2025 05:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762752288;
	bh=gdk7UxmkEKvvMHc9kBpLd+XXCzH6cFQwNXy7/F1XAqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oAiJFsC4Jk1TQGYrQ047DoMfnP9Yk69/c/1dZMEBE/kpju6wWaIC6eZxBbVtilLuH
	 iKAX3EBkbf+CF2EDnomQaaKQjpH2kqMhGl1D0/GqYb3/vx9cHQHq4oyXdAghBbm0q3
	 +2aTEdH8hDeYAR6ogUy19t5LQPqc1eglmrwlbMo2R2+Sq/FBB3FXyzf9aPhOSiNh/s
	 Heo+ogxLRaOrAvSiv1ANfHz/A8te8+8ocofLLhd1SYnOUfSaSht+K4ArYrqe+5UAi0
	 c3ODonuIIhkSxnYnfNjqAdJY7qVhT95sfZfrajsQy4g2e8jDU0m/YMli+hyN6MixSA
	 Vc5YKl+85Pvew==
Date: Mon, 10 Nov 2025 14:24:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] tracing: Exit out immediately after
 update_marker_trace()
Message-Id: <20251110142445.db72eb74a64f01cdc6689f43@kernel.org>
In-Reply-To: <20251106003501.726406870@kernel.org>
References: <20251106003324.964761749@kernel.org>
	<20251106003501.726406870@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Nov 2025 19:33:25 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The call to update_marker_trace() in set_tracer_flag() performs the update
> to the tr->trace_flags. There's no reason to perform it again after it is
> called. Return immediately instead.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index dea1566b3301..07bd10808277 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5285,8 +5285,11 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  		}
>  	}
>  
> -	if (mask == TRACE_ITER(COPY_MARKER))
> +	if (mask == TRACE_ITER(COPY_MARKER)) {
>  		update_marker_trace(tr, enabled);
> +		/* update_marker_trace updates the tr->trace_flags */
> +		return 0;
> +	}
>  
>  	if (enabled)
>  		tr->trace_flags |= mask;
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
