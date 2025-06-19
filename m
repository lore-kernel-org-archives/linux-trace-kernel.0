Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C221F542A;
	Thu, 19 Jun 2025 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750304723; cv=none; b=D4SmGxJVU6vulkRW4y4DRznstWubaLEBd0SANnYrOqmkdDdVcLEiNemih6TsSsHpQeCWTO5jwk/c13AIvFZSmr24gaj33DeI6aCwfSK9ug+y4FGwK3UBzuic+78fT+wZ0/DDhrA9zYVs52/5kotUNaC2gGEY3p+IqK1A3w/+4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750304723; c=relaxed/simple;
	bh=9CzMphxe3lW5Q3aLp/MGYbMjrc/VDOWnRy/s1Jiwmv0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Is0PvEYo10L6WdeuECQXbh3zXnxS5uwpPFYwi6wqytoVNcdy1OEJPZrFEi0cAf6aHre1aZcTqR1DiH/+kUvgamoXTcl9mmVM2mQfRgLMUR7xQYE7QBpYoMeVPMh0WvCeQ2KFNISB8Qow4XtT/I2AEq6uVg3R11e38qoex7F+oE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXvzKPqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXvzKPqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E1CC4CEEA;
	Thu, 19 Jun 2025 03:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750304720;
	bh=9CzMphxe3lW5Q3aLp/MGYbMjrc/VDOWnRy/s1Jiwmv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MXvzKPqUZiVQLYrAn65ar80qKZyE29uppXnHTNGE5EpWmEGYeAld594V8mSewyozp
	 qL+uz6D33wRi4CxdN+FPQ/T0ta/Fds8j7VYG+XSwWSWr5QG1Q7hkVzewEmKW4tx6TE
	 4gk08HPKQ2GsDS5i3Ws590JY1CKBN8JaFLM50uYuIlvvc/URj9m3w4Tl9wdJNuvz97
	 VKdliSZ4ccaPh5Uj1xPCUSjdodo2yVNSP0QSI23kLexXybQjPH2jRW5LSfl4FzpzHO
	 nG0Yl0MikXbHcuKicd2N0fFnszhzNnCTpoZ5vZSewP2lJGsFDmBJWZUU2jZuZMaRXV
	 AH3IowBPDFqFw==
Date: Thu, 19 Jun 2025 12:45:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: Keep track of when fgraph_ops are registered or
 not
Message-Id: <20250619124517.3e6665439e1794918e83f1b6@kernel.org>
In-Reply-To: <20250618073117.024efb2e@gandalf.local.home>
References: <20250618073117.024efb2e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 07:31:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add a warning if unregister_ftrace_graph() is called without ever
> registering it, or if register_ftrace_graph() is called twice. This can
> detect errors when they happen and not later when there's a side effect:
> 
> Link: https://lore.kernel.org/all/20250617120830.24fbdd62@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index c5b207992fb4..c6bb6c68764f 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1325,6 +1325,10 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	int ret = 0;
>  	int i = -1;
>  
> +	if (WARN_ONCE(gops->ops.flags & FTRACE_OPS_FL_GRAPH,
> +		      "function graph ops registered again"))
> +		return -EBUSY;
> +
>  	guard(mutex)(&ftrace_lock);
>  
>  	if (!fgraph_stack_cachep) {
> @@ -1401,17 +1405,21 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  {
>  	int command = 0;
>  
> +	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
> +		      "function graph ops unregistered without registering"))
> +		return;
> +
>  	guard(mutex)(&ftrace_lock);
>  
>  	if (unlikely(!ftrace_graph_active))
> -		return;
> +		goto out;
>  
>  	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE ||
>  		     fgraph_array[gops->idx] != gops))
> -		return;
> +		goto out;
>  
>  	if (fgraph_lru_release_index(gops->idx) < 0)
> -		return;
> +		goto out;
>  
>  	fgraph_array[gops->idx] = &fgraph_stub;
>  
> @@ -1434,4 +1442,6 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
>  	}
>  	gops->saved_func = NULL;
> + out:
> +	gops->ops.flags = 0;

Can we make it cleaning only FTRACE_OPS_FL_GRAPH flag here?
Or, ops.flags should be set again before registering it?

Thank you,

>  }
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
