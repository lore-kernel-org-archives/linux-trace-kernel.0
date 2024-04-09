Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB413667F
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677574; cv=none; b=fG/Y1/c3FwrtV73FyUSF6Bz4r/ngQ3865Ls71+QiGt+6Ryg6jMw/aEAgcx+HQS4GQqCjbPomQHK/6o9bNcmJtxqe40LcpkhwLqpHD+SLBMq6mNcKbaxToB8dJU/FNccP+PkfjdNPSXVQ7zRDafobl36+auyS3aTUXd5DLySNYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677574; c=relaxed/simple;
	bh=4YNynUGh8NwIznE4z7XpT8p/m3+R1fGobPIeDJ73050=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJCbwJSkUCzgbqOPFMlhS3SEG89824WPtCucxp0qaIFRrSt6T9ndrQho9UYx7yGHk1UwekrvXXnQA2LuzLIzjTfY2mUNgrJcLDPF26hSrx9f13cFbjJIZKzdWJham359ZSVZh+l2eQp3cjKgCGj+G8IkEbDh50aibhDEjMPJivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OJ9SIXcj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OJ9SIXcj"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so3828218b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712677571; x=1713282371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZb3iRMe5mVHNLzHciI0SO6cgHqSkIE7M20XVfQvi74=;
        b=OJ9SIXcj1d8DD3AnrJn6fSIE4nm3csk7FIJi/u75zL0+E88z1I/PlYHH26hJZNIctd
         7KqFnenEfHRRv3deZ00Toyb2SmtmwZQ1J3mvdIyPDKX5EbQuwjrRFSLgj+N1BYG0Aq+n
         BxaQx+K28QFPpGdtTT9+VWOWAqXJ+Rmx1oYQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677571; x=1713282371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZb3iRMe5mVHNLzHciI0SO6cgHqSkIE7M20XVfQvi74=;
        b=fuNUx374xkDYVvyvP6j+U7EHp1WwGv6bwNMGJNqKUTOwX7MLxzGuZLmIKHYqvZovk0
         1glHvauFpTi/uAOhvtj94T3mDLA2ks8aOq+IiGWZ0ptNUCCn5OJ8srnPTfB51SXCfh4q
         z9EgGkueGpQkakAKLySVnQJlyiHR4lKVCclEaA8EZ9dxfn3dlLWi6qHev8CdzRG8BOO+
         6VQCHi+z1teJ3UighEjoTIv9vxq9/ZIQ81c6uNHGG26yo3NJrM6F4nDwrZH/lZleOPol
         vJf7n/Tm6WoSPLyk1XCC5A1iRAH0lEbJtzMzREoIHU20cLLz5uiVCH/g+uDDM9pKawqg
         RPKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfo9IuOKWR7tv2Tht/CnZY1+ApO/OprERL/x17WJcbKKz7DyKaVFXngqADbYkauTnh2caFvSR0jw5nwiAea76y58L+CYbRDWdG7YojweyoZqiQ
X-Gm-Message-State: AOJu0Yx//HzKoDQhlBAzvsekzHtHCinDOl9mRu5+2bdiETZ0yUsXdK8I
	eXbp4HjclDiZOMDgLwcrWJMNxhYbjHkQ87BUhwk/i+5ZJrTM0VfUI3SkAomcDg==
X-Google-Smtp-Source: AGHT+IFY4YnmxxIgxT9REWRm8+8QvKZDpcEh61QeY1CTDZRblqm40N34Vq/Eeh+kF58mWnqkXyrA8A==
X-Received: by 2002:a05:6a00:2355:b0:6ec:da6c:fc2d with SMTP id j21-20020a056a00235500b006ecda6cfc2dmr13723474pfj.23.1712677571643;
        Tue, 09 Apr 2024 08:46:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 27-20020a630f5b000000b005dc5289c4edsm8296124pgp.64.2024.04.09.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:46:11 -0700 (PDT)
Date: Tue, 9 Apr 2024 08:46:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
Message-ID: <202404090840.E09789B66@keescook>
References: <20240408090205.3714934-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408090205.3714934-1-elver@google.com>

On Mon, Apr 08, 2024 at 11:01:54AM +0200, Marco Elver wrote:
> Add "new_exec" tracepoint, which is run right after the point of no
> return but before the current task assumes its new exec identity.
> 
> Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
> runs before flushing the old exec, i.e. while the task still has the
> original state (such as original MM), but when the new exec either
> succeeds or crashes (but never returns to the original exec).
> 
> Being able to trace this event can be helpful in a number of use cases:
> 
>   * allowing tracing eBPF programs access to the original MM on exec,
>     before current->mm is replaced;
>   * counting exec in the original task (via perf event);
>   * profiling flush time ("new_exec" to "sched_process_exec").
> 
> Example of tracing output ("new_exec" and "sched_process_exec"):
> 
>   $ cat /sys/kernel/debug/tracing/trace_pipe
>       <...>-379     [003] .....   179.626921: new_exec: filename=/usr/bin/sshd pid=379 comm=sshd
>       <...>-379     [003] .....   179.629131: sched_process_exec: filename=/usr/bin/sshd pid=379 old_pid=379
>       <...>-381     [002] .....   180.048580: new_exec: filename=/bin/bash pid=381 comm=sshd
>       <...>-381     [002] .....   180.053122: sched_process_exec: filename=/bin/bash pid=381 old_pid=381
>       <...>-385     [001] .....   180.068277: new_exec: filename=/usr/bin/tty pid=385 comm=bash
>       <...>-385     [001] .....   180.069485: sched_process_exec: filename=/usr/bin/tty pid=385 old_pid=385
>       <...>-389     [006] .....   192.020147: new_exec: filename=/usr/bin/dmesg pid=389 comm=bash
>        bash-389     [006] .....   192.021377: sched_process_exec: filename=/usr/bin/dmesg pid=389 old_pid=389
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  fs/exec.c                   |  2 ++
>  include/trace/events/task.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 38bf71cbdf5e..ab778ae1fc06 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1268,6 +1268,8 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		return retval;
>  
> +	trace_new_exec(current, bprm);
> +

All other steps in this function have explicit comments about
what/why/etc. Please add some kind of comment describing why the
tracepoint is where it is, etc.

For example, maybe something like:

/*
 * Before any changes to 'current', report that the exec is about to
 * happen (since we made it to the point of no return). On a successful
 * exec, the 'sched_process_exec' tracepoint will also fire. On failure,
 * ... [something else]
 */

> +TRACE_EVENT(new_exec,
> +
> +	TP_PROTO(struct task_struct *task, struct linux_binprm *bprm),
> +
> +	TP_ARGS(task, bprm),
> +
> +	TP_STRUCT__entry(
> +		__string(	filename,	bprm->filename	)
> +		__field(	pid_t,		pid		)
> +		__string(	comm,		task->comm	)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(filename, bprm->filename);

What about binfmt_misc, and binfmt_script? You may want bprm->interp
too?

-Kees

> +		__entry->pid = task->pid;
> +		__assign_str(comm, task->comm);
> +	),
> +
> +	TP_printk("filename=%s pid=%d comm=%s",
> +		  __get_str(filename), __entry->pid, __get_str(comm))
> +);
> +
>  #endif
>  
>  /* This part must be outside protection */
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

-- 
Kees Cook
