Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33A79D0;
	Thu,  7 Nov 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994351; cv=none; b=lSY7NvNT4/Qs7kVZ8AffNh9cJ1WlVHVQtzkVsbABuRPZehdqIPvOoQSDdHaJ2RvICb5uTWy6WpzatfTxSFRjT4JZHKPYZiWap3uXfG55lr+trvibx/FrLKylMAZAYk6voMEsfweIUbievwUnersuM0Rtz5LJ7PeJsDSMR9UULi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994351; c=relaxed/simple;
	bh=zXYIeR54dQzPkyOF6iyFHBGFz9ClgZEwKTaYqILqrhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgOB904irqY1d+tlFto7pKEkDj5paz14LCfzuhWo4BiEngMjZgQwxoMbPNiH+5JumKDZJqsl0whoTMNcFcTzG1pLAHzfEEURPBcp8wMRIGmISOAV95aCn6j7MhBWFPfo2Ei99mXV43bbKKDWdUeipTzM9b+s6XVkRONIc9oOAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=vXQCeu7q; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vXQCeu7q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730994342;
	bh=zXYIeR54dQzPkyOF6iyFHBGFz9ClgZEwKTaYqILqrhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vXQCeu7qCY+Rx0XwRNX3obnwyQazNHm6gE9K+PzAQQJshUgA28WHpQ17/mL3/6laE
	 EyIO2okdpant6Sc0t/O7Rkw/g4khzGzhx6hbhPA8yLpbIK4YM9cieU/SC3ja9TJMp2
	 tjJ/zdfnZEm5pk23ZgiUp05qHK6xhi//dbSMCTk331Hp3q/mHw4Ro/Bzi6VlgOLFsh
	 LOV/UCNbtwtdIfg48lzFPFmdOVuaYKRNNX1oTzUdRwL4fLkMIU33kyyxrCCMDYyfSo
	 yA+OtGegirOx8kKhQ3CFaJ9Xxb/fkyWhJ1UFjOeijrHPFeQkLyTD6eocC0PejWY9Zu
	 Im8m4mez7Uwyg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xkmck1TPYzxTL;
	Thu,  7 Nov 2024 10:45:42 -0500 (EST)
Message-ID: <5b7defe4-09db-491e-b2fb-3fb6379dc452@efficios.com>
Date: Thu, 7 Nov 2024 10:44:12 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
To: Marco Elver <elver@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
References: <20241107122648.2504368-1-elver@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241107122648.2504368-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-07 07:25, Marco Elver wrote:
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
>    a. unprivileged triggering of a test module: test modules may register a
>       probe to be called back on task_prctl_unknown, and pick a very large
>       unknown prctl() option upon which they perform a test function for an
>       unprivileged user;
> 
>    b. unprivileged triggering of an eBPF program function: similar
>       as idea (a).
> 
> Example trace_pipe output:
> 
>    test-484     [000] .....   631.748104: task_prctl_unknown: comm=test option=1234 arg2=101 arg3=102 arg4=103 arg5=104
> 

My concern is that we start adding tons of special-case
tracepoints to the implementation of system calls which
are redundant with the sys_enter/exit tracepoints.

Why favor this approach rather than hooking on sys_enter/exit ?

Thanks,

Mathieu

> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Remove "pid" in trace output (suggested by Steven).
> ---
>   include/trace/events/task.h | 41 +++++++++++++++++++++++++++++++++++++
>   kernel/sys.c                |  3 +++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 47b527464d1a..9202cb2524c4 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -56,6 +56,47 @@ TRACE_EVENT(task_rename,
>   		__entry->newcomm, __entry->oom_score_adj)
>   );
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
> +		__string(	comm,		task->comm	)
> +		__field(	int,		option)
> +		__field(	unsigned long,	arg2)
> +		__field(	unsigned long,	arg3)
> +		__field(	unsigned long,	arg4)
> +		__field(	unsigned long,	arg5)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(comm);
> +		__entry->option = option;
> +		__entry->arg2 = arg2;
> +		__entry->arg3 = arg3;
> +		__entry->arg4 = arg4;
> +		__entry->arg5 = arg5;
> +	),
> +
> +	TP_printk("comm=%s option=%d arg2=%ld arg3=%ld arg4=%ld arg5=%ld",
> +		  __get_str(comm), __entry->option,
> +		  __entry->arg2, __entry->arg3, __entry->arg4, __entry->arg5)
> +);
> +
>   #endif
>   
>   /* This part must be outside protection */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 4da31f28fda8..dd0a71b68558 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -75,6 +75,8 @@
>   #include <asm/io.h>
>   #include <asm/unistd.h>
>   
> +#include <trace/events/task.h>
> +
>   #include "uid16.h"
>   
>   #ifndef SET_UNALIGN_CTL
> @@ -2785,6 +2787,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>   		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>   		break;
>   	default:
> +		trace_task_prctl_unknown(me, option, arg2, arg3, arg4, arg5);
>   		error = -EINVAL;
>   		break;
>   	}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

