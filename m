Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3821230BEC;
	Mon, 16 Feb 2026 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771226840; cv=none; b=d81FVhbdImUCkbw6KpKPICsbAd1Qd+F4kOAJC1Fx9BslkIpXn9YbGbnWQpmygmymfqDQlAZ1yXfmU58aypjrjVad9s5pNjaCXvdNBFT+rczCCY3CglKvmOoxk/3BYxpSGxyfuL4MAkSZEEO41pofkAor8m4S25AuFgdM6INuV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771226840; c=relaxed/simple;
	bh=MJehdGvTFYyR/jjKFfuRhIrjbHJ0KbdEcOXe+l3QyRM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IlFX8zDaMX5b0cGdprLzu6jC0CGWNrLt9DJWAsurJ3Ao/8xBAXVfBkkFE6DBLwqbrclCmnEmEhVZZyjKY+OoE7uelMoZRsuLzEOeUT3IMcQgWAWmrkUWuTNnj3Rm3CTP7nFyFPlAwcF4a02UWBSvOF0xy++pIhIyv9AEQN3raOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSpvVvRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSpvVvRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C64C116C6;
	Mon, 16 Feb 2026 07:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771226840;
	bh=MJehdGvTFYyR/jjKFfuRhIrjbHJ0KbdEcOXe+l3QyRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bSpvVvRy64Cp1+fxhYEO1Vlft/o4ZUe4Tl2gC1UVHZXUtAgQ3Uq9oMk+D/wb9xT0k
	 bIpqa9K/MZY9cSExrii0okqWARPgeOZlFVo8NZ5nay/lj+Y0I5OT/xbS573SYDYgxU
	 b5kMAXcTt5nBbJ/yD++8lh4LRQcR0DtBxy1ZXndFQoHC3KeIGcenkAqRyz1wZ9O6J4
	 U+GRwgYQMmut2xf7T3xqa7hta3J/KQg0F3xyuuSxT5UNLi06BHMBlfzJw0o0+axnNZ
	 JiexB2jpgTsFyCW9SlS7zsDNV9uQymI6bmzAJ8gQz2Ybr9QRz8NdE6hswf3l80UJHz
	 xgaUJYZDPMHcQ==
Date: Mon, 16 Feb 2026 16:27:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: Enhancing Conditional Filtering for Function Graph Tracer
Message-Id: <20260216162716.dc8ec2f3f2fe409b6c11e491@kernel.org>
In-Reply-To: <CAErzpmtMrHWQVAQx=jiq_sWo=+c_JOUoQmPafo-fq+Q3qi+BBw@mail.gmail.com>
References: <CAErzpmtMrHWQVAQx=jiq_sWo=+c_JOUoQmPafo-fq+Q3qi+BBw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 14 Feb 2026 18:36:24 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> Hi Steve and Masami,
> 
> I recently had an idea while using the function graph tracer.
> Currently, it supports basic
> filtering via set_ftrace_pid(PID-based) and
> set_graph_function(function name-based).
> However, this filtering mechanism feels somewhat limited. Given that
> we already have
> features like funcgraph-args, I wonder if we could enhance filtering by allowing
> conditional tracking based on function parameters — similar to how
> trace events support
> filters/triggers.

Agreed. I think it is a good idea.

> 
> To simplify implementation, I propose extending a new trigger type
> (e.g., "funcgraph").

OK, and I think the question is what do we want to filter. As you know,
the kernel function call-graph is a very context depending. I think we
may be better to start with specifying the pid filter via the tringger
instead of enabling/disabling it on all cpus.

echo "funcgraph:setpid:common_pid" >> events/fprobes/func_foo/trigger

Then, we can also specify a specific task's pid too via sched_switch
events etc. Also we can add "clearpid". Maybe we also need a special
PID (e.g. -1) for trace no process instead of using tracing_on.

Thank you,

> In ftrace_graph_ignore_func, we could look up the corresponding trace_fprobe and
> trace_event_file based on trace->func, then decide whether to trace
> the function using
> a helper like the following:
> 
> static bool ftrace_graph_filter(struct trace_fprobe *tf, struct
> ftrace_regs *fregs,
>                                struct trace_event_file *trace_file)
> {
>     struct fentry_trace_entry_head *entry;
>     struct trace_event_buffer fbuffer;
>     struct event_trigger_data *data;
>     int dsize;
> 
>     dsize = __get_data_size(&tf->tp, fregs, NULL);
>     entry = trace_event_buffer_reserve(&fbuffer, trace_file,
>                                        sizeof(*entry) + tf->tp.size + dsize);
>     if (!entry)
>         return false;
> 
>     entry = ring_buffer_event_data(fbuffer.event);
>     store_trace_args(&entry[1], &tf->tp, fregs, NULL, sizeof(*entry), dsize);
> 
>     list_for_each_entry_rcu(data, &trace_file->triggers, list) {
>         if (data->cmd_ops->trigger_type == TRIGGER_TYPE_FUNCGRAPH) {
>             struct event_filter *filter = rcu_dereference_sched(data->filter);
>             if (filter && filter_match_preds(filter, entry))
>                 return true; // Allow tracing
>         }
>     }
>     return false; // Skip tracing
> }
> 
> Does this approach make sense? Any suggestions or concerns?
> 
> Thanks,
> Donglin


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
