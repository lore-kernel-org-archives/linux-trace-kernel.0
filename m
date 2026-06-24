Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C5E555;
	Wed, 24 Jun 2026 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782261450; cv=none; b=u7qEyaU38+pJaPnb47dWpP+d0CHwYnZpVBQd33/TwlJU8uYgfKd8zXFCBxcK5TAnhjDfsX5/9k/c0sNR44rLpRPoxSXQmhmpJrByke95/BU5doumJoL42dVrhPbXeAs77PQ7QfwEEm1uhne1hoMikBfKUJyz64/Q1/2iAoiOpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782261450; c=relaxed/simple;
	bh=hFoZB6NJJoW0wM1KmUP3LfW1yv3020xmLmykB/czkns=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DgNzosPfXfLCCmNYgIt2hA6qP5Us9lKGyEf8a6A54DVeUiILBkNheVkzAS8iS7smJNsGC7y3n3k69mF+0Kae5iykmDStaSFOl7IYKBonXsaL6YVZTWnZcC6Fx9V9d39JBeY0UrJFuWxusGnNilD8kK68WbTj9X/zoArModFE+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evWiMjHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evWiMjHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAFF1F000E9;
	Wed, 24 Jun 2026 00:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782261449;
	bh=NJqeTdUKZWjduNX7nzHBWvgqeZ6FMHBM9Nh8vV2PDfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=evWiMjHXUTycFnOOiig6If91ceUIeHbac/PljIIbOR87l0Vne7khLwOiNDrp9zWGI
	 rXI+bu8YSTh2XpaEx3u2uc8Ab2Rjf9/1RuuGs+hBtPrq8x6R0mC9jJj21IbG9zAFSa
	 e13uoku5HR8eBPh21sbWTD4osEsPqeXLo+c+3n97l+yqOcCK7KNwFqCfI1L93HdJ2j
	 q+QJfVMZ2bw1uFpsTEO7Su2RWHetnXxIg4IidIF6rIZjlXYglcJEUwuN++3frvoNHB
	 StjNG9cTKjMoTPktvGYLMnMQOcScoxxNlGZfGLS9ffaK93kNuwRdDsksBFOLntFLhI
	 sXJLIiX2KCf2A==
Date: Wed, 24 Jun 2026 09:37:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/fprobe: Fix NULL pointer dereference in
 fprobe_fgraph_entry()
Message-Id: <20260624093725.01ba9ab1feba618f0b047bd5@kernel.org>
In-Reply-To: <20260619184425.3824774-1-rhkrqnwk98@gmail.com>
References: <20260619184425.3824774-1-rhkrqnwk98@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 18:44:24 +0000
Sechang Lim <rhkrqnwk98@gmail.com> wrote:

> fprobe_fgraph_entry() sizes a shadow-stack reservation in one walk of
> the per-ip fprobe list and fills it in a second walk, both under
> rcu_read_lock() only. A fprobe registered on an already-live ip can
> become visible between the two walks, so the fill walk processes an
> exit_handler the sizing walk did not count and used runs past
> reserved_words. If the sizing walk counted nothing, fgraph_data is NULL
> and the first write_fprobe_header() faults:
> 
>   Oops: general protection fault, probably for non-canonical address ...
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:fprobe_fgraph_entry+0xa38/0xf10 kernel/trace/fprobe.c:167
>   Call Trace:
>    <TASK>
>    function_graph_enter_regs+0x44c/0xa10 kernel/trace/fgraph.c:677
>    ftrace_graph_func+0xc5/0x140 arch/x86/kernel/ftrace.c:671
>    __kernel_text_address+0x9/0x40 kernel/extable.c:78
>    arch_stack_walk+0x117/0x170 arch/x86/kernel/stacktrace.c:26
>    kmem_cache_free+0x188/0x580 mm/slub.c:6378
>    tcp_data_queue+0x18d/0x6550 net/ipv4/tcp_input.c:5590
>    [...]
>    </TASK>
> 
> The list cannot be frozen across the two walks, so skip a node that does
> not fit the reservation and count it as missed.
> 

Ah, good catch! Yes, if the list is scanned repeatedly, there is a
possibility that it could be updated even when using RCU guards.
This is rare case, but hmm, I think we need something like
fgraph_increment_reserved_data() to avoid skipping.
Anyway, this looks good to me. Let me pick it.

Thanks!

> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  kernel/trace/fprobe.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index f378613ad120..f215990b9061 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -613,6 +613,16 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  			continue;
>  
>  		data_size = fp->entry_data_size;
> +		/*
> +		 * The list may have grown since it was sized, so this node
> +		 * may not fit. Skip it as missed rather than overrun the
> +		 * reservation.
> +		 */
> +		if (fp->exit_handler &&
> +		    used + FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(data_size) > reserved_words) {
> +			fp->nmissed++;
> +			continue;
> +		}
>  		if (data_size && fp->exit_handler)
>  			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
>  		else
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
