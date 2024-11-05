Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAC2C190;
	Tue,  5 Nov 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824272; cv=none; b=dYYQe9lhSmV/HoyN5DMZ8YG3LoBRNUNCvCAT128I/tZ7HTYtFadk0p8mLNGxscS6wK9Jx3HKYLTMuF7t04/eO3dRIyIdbXjMQqo9IzJB4zAGZ01PST3HxKUP3pI4nsPe8B+IfgCj4Ch3MSDYI3rKUBBIx+Dertqw376X3cTAXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824272; c=relaxed/simple;
	bh=7MOh4GwiFOvb9bVlArzUPENHDHkefPz5N7SZii2P0Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CX/LTbQDbpi/WQ5sUpV1ixJyxPJCJT48LLDweQpkThVzuXWT1ixmtc0k1+N3U+nfv+9KNj8tcCZOg6aoqDhRGVjuW/55DkQoXPBhma1d3hLi+9z4UWRh54F7yG303CegkaukEX/cyyKEs+kdFbkskTcbtX+BX59hhPEb/+BLtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910B2C4CECF;
	Tue,  5 Nov 2024 16:31:10 +0000 (UTC)
Date: Tue, 5 Nov 2024 11:31:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241105113111.76c46806@gandalf.local.home>
In-Reply-To: <20241105133610.1937089-1-elver@google.com>
References: <20241105133610.1937089-1-elver@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 14:34:05 +0100
Marco Elver <elver@google.com> wrote:

> prctl() is a complex syscall which multiplexes its functionality based
> on a large set of PR_* options. Currently we count 64 such options. The
> return value of unknown options is -EINVAL, and doesn't distinguish from
> known options that were passed invalid args that also return -EINVAL.
> 
> To understand if programs are attempting to use prctl() options not yet
> available on the running kernel, provide the task_prctl_unknown
> tracepoint.
> 
> Note, this tracepoint is in an unlikely cold path, and would therefore
> be suitable for continuous monitoring (e.g. via perf_event_open).
> 
> While the above is likely the simplest usecase, additionally this
> tracepoint can help unlock some testing scenarios (where probing
> sys_enter or sys_exit causes undesirable performance overheads):
> 
>   a. unprivileged triggering of a test module: test modules may register a
>      probe to be called back on task_prctl_unknown, and pick a very large
>      unknown prctl() option upon which they perform a test function for an
>      unprivileged user;
> 
>   b. unprivileged triggering of an eBPF program function: similar
>      as idea (a).
> 
> Example trace_pipe output:
> 
>   <...>-366     [004] .....   146.439400: task_prctl_unknown: pid=366 comm=a.out option=1234 arg2=101 arg3=102 arg4=103 arg5=104

          ^^^                                                       ^^^

> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/trace/events/task.h | 43 +++++++++++++++++++++++++++++++++++++
>  kernel/sys.c                |  3 +++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 47b527464d1a..ab711e581094 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -56,6 +56,49 @@ TRACE_EVENT(task_rename,
>  		__entry->newcomm, __entry->oom_score_adj)
>  );
>  
> +/**
> + * task_prctl_unknown - called on unknown prctl() option
> + * @task:	pointer to the current task
> + * @option:	option passed
> + * @arg2:	arg2 passed
> + * @arg3:	arg3 passed
> + * @arg4:	arg4 passed
> + * @arg5:	arg5 passed
> + *
> + * Called on an unknown prctl() option.
> + */
> +TRACE_EVENT(task_prctl_unknown,
> +
> +	TP_PROTO(struct task_struct *task, int option, unsigned long arg2, unsigned long arg3,
> +		 unsigned long arg4, unsigned long arg5),
> +
> +	TP_ARGS(task, option, arg2, arg3, arg4, arg5),
> +
> +	TP_STRUCT__entry(
> +		__field(	pid_t,		pid		)

Why record the pid that is already recorded by the event header?

> +		__string(	comm,		task->comm	)

I'm also surprised that the comm didn't show in the trace_pipe. I've
updated the code so that it should usually find it. But saving it here may
not be a big deal.

-- Steve

> +		__field(	int,		option)
> +		__field(	unsigned long,	arg2)
> +		__field(	unsigned long,	arg3)
> +		__field(	unsigned long,	arg4)
> +		__field(	unsigned long,	arg5)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pid = task->pid;
> +		__assign_str(comm);
> +		__entry->option = option;
> +		__entry->arg2 = arg2;
> +		__entry->arg3 = arg3;
> +		__entry->arg4 = arg4;
> +		__entry->arg5 = arg5;
> +	),
> +
> +	TP_printk("pid=%d comm=%s option=%d arg2=%ld arg3=%ld arg4=%ld arg5=%ld",
> +		  __entry->pid, __get_str(comm), __entry->option,
> +		  __entry->arg2, __entry->arg3, __entry->arg4, __entry->arg5)
> +);
> +
>  #endif
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 4da31f28fda8..dd0a71b68558 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -75,6 +75,8 @@
>  #include <asm/io.h>
>  #include <asm/unistd.h>
>  
> +#include <trace/events/task.h>
> +
>  #include "uid16.h"
>  
>  #ifndef SET_UNALIGN_CTL
> @@ -2785,6 +2787,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>  		break;
>  	default:
> +		trace_task_prctl_unknown(me, option, arg2, arg3, arg4, arg5);
>  		error = -EINVAL;
>  		break;
>  	}

