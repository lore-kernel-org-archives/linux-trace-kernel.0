Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8668334695;
	Tue, 24 Feb 2026 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922221; cv=none; b=cyIQPxzaCO9YFSBVibVtGjs7Si65WQumbEacvtlikoE2XVJBJO5Z6RuK7R1qBoQzZsjzdntiihM0VSeqHdzqRx6+WRCqIjwv2GS/tIcMR+OOFrAE5pna0u2Tjg3aZUv6lg7pUdNB+EheEXV7/YYJ2ERgpwtkwCrzNdrvto3T/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922221; c=relaxed/simple;
	bh=Bp5EWO7W/31kL/lJseyg4KFNPCFWYypAV1BQnVfO82Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k34kJnAOtH446cKr8Ho+WW3FITNkT3U1uVnbq7s5zfGGPtXZhFrsSJKmCKfQOkcQFcMdTlbmynKr1V3hgLwIWB7dzOc0/07oRB6TjJOt4N1LCR0JtIB6kZ57JkpUdpmkRsXbbavl6T2Z+s8TeD6j8nJOYtSbUvE7ARJ4JGeBz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg5XeSWJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg5XeSWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18963C116D0;
	Tue, 24 Feb 2026 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771922221;
	bh=Bp5EWO7W/31kL/lJseyg4KFNPCFWYypAV1BQnVfO82Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xg5XeSWJsFfsOl8hwM8Fno7XTmGnnitNk7WmGDa2fpD9blosluMvpUbdOf8Ta5jeP
	 oEP2h1hWB7qpmAMM5K69TsASVEjARMYjro20XnZMC1dI6HJ0RLIAjzQYb6xc53E/V8
	 jL9TjNdIuukF/48RYxZBF3GPBV5DYrvRWicqEPJlNxckSLcGQaHnxcGfCogdSPhZCk
	 G7A2+VcMllAHIyvpZ6ozWpiKY3XmPjFYgdBmOy26zCNZzA2wH+S5mbL+btVBiyiTKs
	 8Y8AvmX7sdRakcRhw7i0nhrpDFxOoLxx9qfdZ1ZtpYP29RSShRgtsELYJN9jhYZXkT
	 ImW7USl2kKG9g==
Date: Tue, 24 Feb 2026 17:36:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: <hu.shengming@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <zhang.run@zte.com.cn>,
 <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: Re: [PATCH 2/2] fgraph: fix thresh_return nosleeptime double-adjust
Message-Id: <20260224173658.f4882de0db9b290ced3ae1f4@kernel.org>
In-Reply-To: <20260221113314048jE4VRwIyZEALiYByGK0My@zte.com.cn>
References: <202602211116123227p4Je6QELxr2byqvy9kTE@zte.com.cn>
	<20260221113314048jE4VRwIyZEALiYByGK0My@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Feb 2026 11:33:14 +0800 (CST)
<hu.shengming@zte.com.cn> wrote:

> From: Shengming Hu <hu.shengming@zte.com.cn>
> 
> trace_graph_thresh_return() called handle_nosleeptime() and then
> delegated to trace_graph_return(), which calls
> handle_nosleeptime() again. When sleep-time accounting is
> disabled this double-adjusts calltime and can produce bogus
> durations (including underflow).
> 
> Fix this by computing rettime once, applying
> handle_nosleeptime() only once, using the adjusted calltime
> for threshold comparison, and writing the return event
> directly via __trace_graph_return() when the threshold is met.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Fixes: 3c9880f3ab52b ("ftrace: Use a running sleeptime instead of
> saving on shadow stack")
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> ---
>  kernel/trace/trace_functions_graph.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index cbe43680c..b9c81fbd9 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -403,8 +403,12 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
>  	unsigned long *task_var = fgraph_get_task_var(gops);
>  	struct fgraph_times *ftimes;
>  	struct trace_array *tr;
> +	unsigned int trace_ctx;
> +	u64 calltime, rettime;
>  	int size;
> 
> +	rettime = trace_clock_local();
> +
>  	ftrace_graph_addr_finish(gops, trace);
> 
>  	if (*task_var & TRACE_GRAPH_NOTRACE) {
> @@ -419,11 +423,13 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
>  	tr = gops->private;
>  	handle_nosleeptime(tr, trace, ftimes, size);
> 
> -	if (tracing_thresh &&
> -	    (trace_clock_local() - ftimes->calltime < tracing_thresh))
> +	calltime = ftimes->calltime;
> +
> +	if (tracing_thresh && (rettime - calltime < tracing_thresh))
>  		return;
> -	else
> -		trace_graph_return(trace, gops, fregs);
> +
> +	trace_ctx = tracing_gen_ctx();
> +	__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
>  }
> 
>  static struct fgraph_ops funcgraph_ops = {
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
