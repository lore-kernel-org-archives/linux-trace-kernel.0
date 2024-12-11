Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032E2288C3;
	Wed, 11 Dec 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950455; cv=none; b=PTxsU6BRVq7DFj9u0XS8ZwsoVMyxuuQSslme7/NewY8SFHwYlI8Mac1oxfnI86+uKQcgX7G0VvQnHqR6R1aa6lWQVomXMwF5RWFOPFw9XK8rciJudFZHmfbxPE6fL01sJYbN3FrLis28fjI0aqeanGPPC9xqBts/goS67wmTFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950455; c=relaxed/simple;
	bh=qP+jw3reK6oo4+Arv7+zjxhygcwR7XDDrmzN/M1EP2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lryjx3BkWr1o4f5gpuB4SK6izJluy2KqdcY2O3eFWNYiLefRGh/30tKUn/uoX9IptjsjsU42ReJFSo1zcPI6QoyLsNFcwltA5Anv0bjBh5g39K2rRMotZeKfAFvtNooTYchDTBY/wnKAdwsPAJAJohj9awguX5MLyZwgkeGCCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE61FC4CED2;
	Wed, 11 Dec 2024 20:54:12 +0000 (UTC)
Date: Wed, 11 Dec 2024 15:54:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Al Viro <viro@ZenIV.linux.org.uk>, Michal
 Simek <monstr@monstr.eu>, Jeff Xie <jeff.xie@linux.dev>
Subject: Re: [PATCH] ftrace/microblaze: Do not find "true_parent" for return
 address
Message-ID: <20241211155411.46643bb9@batman.local.home>
In-Reply-To: <20241211153634.69c75afa@batman.local.home>
References: <20241211153634.69c75afa@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


[ Added Jeff ]

-- Steve

On Wed, 11 Dec 2024 15:36:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When function tracing and function graph tracing are both enabled (in
> different instances) the "parent" of some of the function tracing events
> is "return_to_handler" which is the trampoline used by function graph
> tracing. To fix this, ftrace_get_true_parent_ip() was introduced that
> returns the "true" parent ip instead of the trampoline.
> 
> To do this, the ftrace_regs_get_stack_pointer() is used, which uses
> kernel_stack_pointer(). The problem is that microblaze does not implement
> kerenl_stack_pointer() so when function graph tracing is enabled, the
> build fails.
> 
> Modify the #ifdef check to the code around ftrace_get_true_parent_ip() to
> include !defined(CONFIG_MICROBLAZE) which will default it to just return
> the parent ip passed in, which may still be the ip of the function garph
> trampoline.
> 
> Fixes: 60b1f578b578 ("ftrace: Get the true parent ip for function tracer")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_functions.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 74c353164ca1..a75d107a45f8 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
>  	tracing_reset_online_cpus(&tr->array_buffer);
>  }
>  
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +/* Microblaze currently doesn't implement kernel_stack_pointer() */
> +#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && !defined(CONFIG_MICROBLAZE)
>  static __always_inline unsigned long
>  function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
>  {

