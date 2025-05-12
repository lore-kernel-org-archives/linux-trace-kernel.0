Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83671EB9E1;
	Mon, 12 May 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059347; cv=none; b=fwa/Zh+Q4GbpJFy7i6IOOX71cz8jIr2nDv7qfNTF+Yj4uVVzUO+jcKgvwVwSzLg6PHEJBCtmTWZaQMawChereAqP2vXlzSkKx2VrIVRCDSCbANcVkfYBITaXWP+EnyNS5uA3siBzF1jb8uZLzs0Th11kDb4Aj6m9NWgqaDRqB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059347; c=relaxed/simple;
	bh=R38AWIXebXqKOhTy3eQkXfwvvwPbJusndnvJjnJjaCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BP+YOc1aKo84D5DJP+TmUtKKEwMqNw/3TqGqb35xOMzL6dlAEEASEoGbHXXLb4PvHlgCeIx7rI9riUSm/Fuc9iPOhtORthO1x5LtouDGpxQZfe7GE2OsPC26eW7oTV9G5aSmsnWigFyGVuJtbMvUC3QfUxj0fcOoHNtNF24La7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F7EC4CEE7;
	Mon, 12 May 2025 14:15:46 +0000 (UTC)
Date: Mon, 12 May 2025 10:16:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, dolinux.peng@gmai.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ftrace: Fix preemption acounting for stacktrace
 trigger command
Message-ID: <20250512101608.3eb16e43@gandalf.local.home>
In-Reply-To: <20250512094246.1167956-1-dolinux.peng@gmail.com>
References: <20250512094246.1167956-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 17:42:45 +0800
pengdonglin <dolinux.peng@gmail.com> wrote:

> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> While using the stacktrace trigger command to trace syscalls/sys_enter_read,
> I noticed that the preemption count was consistently reported as 1, which seemed
> incorrect:

FYI, the change log should always be in "imperative mood". The above is
fine for cover letters, but for the change log that will live forever in
the git history, it should not reference "I" nor "This patch". That is, it
should state:

   When using the stacktrace trigger command to trace syscalls, the
   preemption count was consistently reported as 1 when the system call
   event itself had 0 (".").

   For example:

> 
> root@ubuntu22-vm:/sys/kernel/tracing/events/syscalls/sys_enter_read
> $ echo stacktrace > trigger
> $ echo 1 > enable
> 
>     sshd-416     [002] .....   232.864910: sys_read(fd: a, buf: 556b1f3221d0, count: 8000)
>     sshd-416     [002] ...1.   232.864913: <stack trace>
>  => ftrace_syscall_enter
>  => syscall_trace_enter
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe  
> 
> The root cause is that the trace framework disables preemption in __DO_TRACE before
> invoking the trigger callback.
> 
> This patch uses tracing_gen_ctx_dec() to obtain the correct preemption
> count within the callback, resulting in accurate reporting:

Instead of "This patch ..."

   Use the tracing_gen_ctx_dec() that will accommodate for the increase of
   the preemption count in __DO_TRACE when calling the callback. The result
   is the accurate reporting of:

This is FYI for when you send new patches. You don't need to resend. I'll
update the change logs and take these patches (unless of course I find
something else wrong with them).

-- Steve

> 
>     sshd-410     [004] .....   210.117660: sys_read(fd: 4, buf: 559b725ba130, count: 40000)
>     sshd-410     [004] .....   210.117662: <stack trace>
>  => ftrace_syscall_enter
>  => syscall_trace_enter
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe  
> 
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> ---
>  kernel/trace/trace_events_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index b66b6d235d91..6e87ae2a1a66 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1560,7 +1560,7 @@ stacktrace_trigger(struct event_trigger_data *data,
>  	struct trace_event_file *file = data->private_data;
>  
>  	if (file)
> -		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
> +		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
>  	else
>  		trace_dump_stack(STACK_SKIP);
>  }

