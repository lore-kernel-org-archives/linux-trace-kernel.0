Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C021D079D;
	Wed,  2 Oct 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877350; cv=none; b=oxwFguQMNOa0miCKhdjE1e8pRkVPP/PcWr57hN9VYxDRoo6N1L4FPayuvSP0gSMOeXO5y/zwfSWJAQcYlfi0A5P89lDEGDSFVn1PMcbc365op/iCeVje7ylqPq1abdxWer3gV9Rn1THNYDOZsbUv6zdogLzWp+/fuiCYgzhRfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877350; c=relaxed/simple;
	bh=ZU4nM5/pEwLBhpoMZqbc0Npso54JrxNg66HKClbXLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvOtb5hr5bJpdBTvV5nMwO5+ybetBwY36Ng3gx6qEot9VwCWReCYJ3FZPBxns2VUUncSPJAMFCN0toqeortEZBvVDpfgoPLRpWE6FPiOyG7xFKxlrkxcW0J2YAUknfrWyD4hNpexB87ERXXuRKrxTIS2avE+RT4lHkIqxLZ1w8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FE9C4CECD;
	Wed,  2 Oct 2024 13:55:49 +0000 (UTC)
Date: Wed, 2 Oct 2024 09:56:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ftrace: Hide a extra entry in stack trace
Message-ID: <20241002095640.55e6cc37@gandalf.local.home>
In-Reply-To: <20241002051347.4239-3-tatsuya.s2862@gmail.com>
References: <20241002051347.4239-3-tatsuya.s2862@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 14:13:48 +0900
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
> 
> [003] .....   110.171589: vfs_write <-__x64_sys_write
> [003] .....   110.171600: <stack trace>
> => XXXXXXXXX (Wrong function name)

BTW, instead of X'ing it out, can you show what that extra function was.
Just saying "Wrong function name" doesn't give me any idea of what happened.

> => vfs_write
> => ksys_write
> => do_syscall_64
> => entry_SYSCALL_64_after_hwframe  
> 
> To resolve this, increment skip for __ftrace_trace_stack() in
> function_stack_trace_call().
> The reason why skip is incremented for __ftrace_trace_stack()
> is because __ftrace_trace_stack() in stack trace is the only function
> that wasn't skipped from anywhere.

Is that the function that was "wrong"?

-- Steve

> 
> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
> ---
> V2 -> V3: Changed the place to increment skip number
> V1 -> V2: Fixed redundant code
> 
>  kernel/trace/trace_functions.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 3b0cea37e029..27089d8e65d4 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -203,23 +203,21 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  	ftrace_test_recursion_unlock(bit);
>  }
>  
> -#ifdef CONFIG_UNWINDER_ORC
> -/*
> - * Skip 2:
> - *
> - *   function_stack_trace_call()
> - *   ftrace_call()
> - */
> -#define STACK_SKIP 2
> -#else
>  /*
>   * Skip 3:
> - *   __trace_stack()
> - *   function_stack_trace_call()
> - *   ftrace_call()
> + *   Skipped functions if CONFIG_UNWINDER_ORC is defined
> + *
> + *     __ftrace_trace_stack()
> + *     function_stack_trace_call()
> + *     ftrace_call()
> + *
> + *   Otherwise
> + *
> + *     __trace_stack()
> + *     function_stack_trace_call()
> + *     ftrace_call()
>   */
>  #define STACK_SKIP 3
> -#endif
>  
>  static void
>  function_stack_trace_call(unsigned long ip, unsigned long parent_ip,

