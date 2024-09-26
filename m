Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC943175B1;
	Thu, 26 Sep 2024 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727327142; cv=none; b=Jw3OR9oWzM49w2OzQtsoE+vJ0xEIhRf1F4KSgU5L4NUCGnOlxOEIBCcP9ITVRwdmSL2Mj07doOyxtWZsJcKr74FxsipZ7eDUy5QAAlV5Lxkx+3QrtZO2d8N7fHFxEc0SB/ocyOjBt798qfvc6q+ERlQZgh797gaWH863Yjz05Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727327142; c=relaxed/simple;
	bh=ruX8CnA4KyJIXgGd6Bi3t1j73QPQbIk2N8BOPvX17jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMUn8ARFlSQmnI4+gTCGLZ0SzJPRxkYh8H7Nw3c9V9HZHPoBOXyvyHs9/bdFfe3joszQo2mZKRGMiWZUdgfNcvTHlo0xAqf0Vm9rorF6yLFvBOPIe5hLGbYC7RD+A2lfe24RAIgQxAM/e5TZyX1FaaPauzGR7NqK21E7zTuAT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F10C4CEC5;
	Thu, 26 Sep 2024 05:05:40 +0000 (UTC)
Date: Thu, 26 Sep 2024 01:05:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Hide a extra entry in stack trace
Message-ID: <20240926010536.5fe73463@rorschach.local.home>
In-Reply-To: <20240923035916.6567-1-tatsuya.s2862@gmail.com>
References: <20240923035916.6567-1-tatsuya.s2862@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 12:59:15 +0900
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
> 
>     [003] .....   110.171589: vfs_write <-__x64_sys_write
>     [003] .....   110.171600: <stack trace>
>  => XXXXXXXXX (Wrong function name)
>  => vfs_write
>  => __x64_sys_write
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe  
> 
> To resolve this, increment skip in __ftrace_trace_stack().
> The reason why skip is incremented in __ftrace_trace_stack()
> is because __ftrace_trace_stack() in stack trace is the only function
> that wasn't skipped from anywhere.
> 
> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
> ---
>  kernel/trace/trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c3b2c7dfadef..e0d98621ff23 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2919,6 +2919,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  #ifndef CONFIG_UNWINDER_ORC
>  	if (!regs)
>  		skip++;
> +#else
> +	skip++;
>  #endif

The above #ifdef block should be removed and replaced with;


	if (IS_ENABLED(CONFIG_UNWINDER_ORC) || !regs)
		skip++;

>  
>  	preempt_disable_notrace();

-- Steve
