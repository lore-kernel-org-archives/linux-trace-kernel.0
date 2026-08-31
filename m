Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44BA3F1045;
	Mon, 31 Aug 2026 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788139249; cv=none; b=meFNDIqvScxXIBda3JgpsflWgdALjRMfTsLVpV93iXnGeM1Mrq3AmGzYOW3cHbVYtiC8tS0XnNatgHXEGpPWqPSzrw9WYOUEVLI9d0FhLBiAzrHc/jIB3F9T5SWztm9EpnRL07+RNZoW+Oyqg2IO/svyEzq7ri78fhM5MKd6YnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788139249; c=relaxed/simple;
	bh=XRQc1fGyoLLjiVHvTIuRDuY4AJVA16SC5BIymvzToGk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Prz6ZrJn6vT7Me7L6YyHJ786xZz1x1HIdX/U8hgvLPei/YKrJwRmKQGR0mh6i2j4WAEJ0krozYDxhni6RJDzVo0gaAe4/QeCX9kS6ZLj1udlFTDzeVjTT2IngG05JJw6gGzOf+fi3LPAqcD65RJj9ED6ZWNbbNiP2LtrVkoj7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATnz0yUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATnz0yUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C531F000E9;
	Mon, 31 Aug 2026 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788139248;
	bh=kxqglTzX5el/KsW91k91hjmZuG0uTrHN9C0U9a3Lu9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ATnz0yUCGQK2R2Icttr60wuNp37xldHFd7FYbP0B+7BE3ORKJRlh9KYZtcIyVabnl
	 PCKjPYXF2Y8rAcjP12yyNpqjwE+vJfgYBxMZg5Fw5R65X91ezoxmSdt+GvQjZ4fIKj
	 Bayr5qB2nU9OBkHgNCOkyVCOkg0dSxV0clHFyl2VpR88S83LIO29U0QIyTipgmXjU+
	 LbRZU3kLKyH1EqriujkCkAhNGCAmDsWztA6UPUnID+YNHtyUxlpqPB2yFOaz7SIbBe
	 MEzyjntmln+KP87U7k1tpg5R25JROhQWMlxFKICPe3HZzuDxvdEqOB5qskyYWIPbkK
	 K9ZJIQGzDD3VA==
Date: Mon, 31 Aug 2026 10:20:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: <hu.shengming@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <mark.rutland@arm.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <ran.xiaokai@zte.com.cn>, <xu.xin16@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: Re: [RFC PATCH 0/4] ftrace: Add task comm filtering for function
 tracing
Message-Id: <20260831102042.6f91bd1e35691ea2d1ac808d@kernel.org>
In-Reply-To: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
References: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 19:07:43 +0800 (CST)
<hu.shengming@zte.com.cn> wrote:

> Hi Steven and Masami,
> 
> This series adds two comm-based task filters for the function and
> function_graph tracers:
> 
>   set_ftrace_comm
>   set_ftrace_notrace_comm
> 
> Function tracing currently supports selecting tasks by PID. This makes
> it difficult to configure tracing before a service starts, because it
> does not have a PID yet. It is also inconvenient to keep tracing the
> same service across restarts, as its PID may change. This use case was
> suggested by Xuxin, a KSM reviewer.

Thanks for the idea. I thought we can use `pidof` but it is for running
processes.

> 
> The new filters match task comm names exactly. When both PID and comm 
> include filters are active, a task must match both to be traced. A
> match in either the PID or comm notrace filter excludes the task.
> 
> To avoid string matching in the function tracing fast path, the filters
> are evaluated when a task is scheduled in. The result is stored in the
> existing per-CPU cache used by PID filtering. Changing a filter refreshes
> the cached result for currently running tasks. If a task's comm changes,
> the new name is used the next time the task is scheduled in.

OK, but can trace scheduler event (or add a new event) that we just convert
comm to PID when the comm is changed and add/remove it to pid filter?
If that works, we can also extend generic event trigger to set ftrace pid
filter. Using this allows you to add or remove processes as ftrace targets
at runtime—not only based on comm, but for other reasons as well.
(of course, setting per-cpu cache requires to kick a worker...)

This will leak the pid via set_ftrace_pid, but that is good from the
monitoring point of view.

Thank you,

> 
> The first two patches prepare the existing PID-filtering infrastructure
> by using general task-filter names and centralizing sched_switch probe
> registration and per-CPU cache updates. The third patch adds the comm
> filters, and the final patch documents their interface and interaction
> with PID filters.
> 
> This is an RFC intended to discuss whether comm-based task filtering is
> a useful direction for function tracing and whether this interface would
> be suitable for eventual upstream inclusion. Additional selftests are
> planned for the next revision. Feedback on the overall approach and
> interface would be greatly appreciated.
> 
> Thanks,
> Shengming
> 
> Shengming Hu (4):
>   ftrace: Generalize function task filter names
>   ftrace: Centralize task filter state updates
>   ftrace: Add exact task comm filtering
>   Documentation/ftrace: Document function comm filters
> 
>  Documentation/trace/ftrace.rst |  31 +++
>  include/linux/ftrace.h         |   4 +-
>  kernel/trace/Makefile          |   1 +
>  kernel/trace/comm_list.c       | 314 +++++++++++++++++++++++++
>  kernel/trace/comm_list.h       |  17 ++
>  kernel/trace/fgraph.c          |   4 +-
>  kernel/trace/ftrace.c          | 402 ++++++++++++++++++++++++++++++---
>  kernel/trace/trace.c           |   5 +
>  kernel/trace/trace.h           |  34 ++-
>  kernel/trace/trace_events.c    |  16 +-
>  kernel/trace/trace_functions.c |   2 +-
>  kernel/trace/trace_pid.c       |   8 +-
>  12 files changed, 791 insertions(+), 47 deletions(-)
>  create mode 100644 kernel/trace/comm_list.c
>  create mode 100644 kernel/trace/comm_list.h
> 
> -- 
> 2.25.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
