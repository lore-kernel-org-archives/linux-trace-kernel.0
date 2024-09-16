Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE317753;
	Mon, 16 Sep 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504771; cv=none; b=j+JrlwyyGKpcrZ7R0B2VPgXxL2gNT2rYtj1NhUJFy7ET4OOCoy10jcUeIhh/yqECkT6jhXOhMhtiOkMfi8nYq9bEWmNHyjwnvGPS5kJsaXeTCDwe8YDttXY0a/s5FFtuRDadECygu/DATpMfc8YZpHiSnM6K74gNngAVfGm3yF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504771; c=relaxed/simple;
	bh=gv8EgQe8x2SyriNJcVhFuJKrcV/u44CqCxDex4u+n8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmO/GfNb7uYXwa09IaiaQNel3Yvytm3BH4L3BpVeHjc6qQOinGtkKJEcXp3VZ/cvaEX8+t0HoVWN71ityezwH1L5sg7jh9L50Qii23hxM95G4vjpI9U2oiJ1LOH2vw4y4CVi6s0Vd7ru9QAaTYgvGepDXGkdG/TZtBUAC1FFPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCECC4CEC4;
	Mon, 16 Sep 2024 16:39:29 +0000 (UTC)
Date: Mon, 16 Sep 2024 12:39:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] function_graph: remove unnecessary initialization in
 ftrace_graph_ret_addr()
Message-ID: <20240916123925.5398abdf@rorschach.local.home>
In-Reply-To: <20240916135643.GA23958@redhat.com>
References: <20240916135643.GA23958@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 15:56:43 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> After the commit 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()")
> ftrace_graph_ret_addr() doesn't need to initialize "int i" at the start.
> 
> While at it, move the declaration of "ret_stack" into the main loop.

Should not make two changes like this, because it risks the entire
patch being denied.


> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/trace/fgraph.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d7d4fb403f6f..d45a8bc97997 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -890,9 +890,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
>  unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  				    unsigned long ret, unsigned long *retp)
>  {
> -	struct ftrace_ret_stack *ret_stack;
>  	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
> -	int i = task->curr_ret_stack;
> +	int i;

I'm fine with removing the unneeded init of i.

>  
>  	if (ret != return_handler)
>  		return ret;
> @@ -902,7 +901,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  
>  	i = *idx ? : task->curr_ret_stack;
>  	while (i > 0) {
> -		ret_stack = get_ret_stack(task, i, &i);
> +		struct ftrace_ret_stack *ret_stack = get_ret_stack(task, i, &i);

This is just a preference. Sometimes I like the declaration up on top,
sometimes in the block it used. But this case, I wont it at top.

Please make a v2 with just the change to i.

-- Steve


>  		if (!ret_stack)
>  			break;
>  		/*

