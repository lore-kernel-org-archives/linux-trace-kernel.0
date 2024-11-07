Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50F29CF4;
	Thu,  7 Nov 2024 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993647; cv=none; b=SW3ngCSd0VyXf8f8yOPwotZfkJVQj5zVbF4Kb7ou2vSp7yTAVfGKbZu9z4oHm22n+FOfnEGGl4nYg2biJbSYekqiQQ4Cit7h9BQjCWqW0ecXq0j7jUjj2+Q+DtnnRdthX36qaW+nly3K83d5qB9h2KTfpb+Ezmf/Cv3wP/5BYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993647; c=relaxed/simple;
	bh=S6Nyhohw0ltQ8Oz53Oa5BTzKcX5Q+uWwtFFNHqwaBVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=se26WfMo3YsQcL7V7yapkDC/eXurnZ/ZkQuAIvBFoKpitkIgQKxhndFuZvwUznKNlTL+Ubb50UtA3Juu9oFSyCeCFMCZz2ByZRngwGD/fLbp2KwwOgZTooAx1fL0VNDiYfH3+Xn87h01s/z/vxc/z+ZiRB6JOffO9nTJdolOrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFB0C4CECC;
	Thu,  7 Nov 2024 15:34:04 +0000 (UTC)
Date: Thu, 7 Nov 2024 10:34:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241107103410.44721a3d@gandalf.local.home>
In-Reply-To: <20241107122648.2504368-1-elver@google.com>
References: <20241107122648.2504368-1-elver@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 13:25:47 +0100
Marco Elver <elver@google.com> wrote:

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

The question is, do we really need comm? From your example, it's redundant:

  test-484     [000] .....   631.748104: task_prctl_unknown: comm=test option=1234 arg2=101 arg3=102 arg4=103 arg5=104
  ^^^^                                                            ^^^^

-- Steve


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
