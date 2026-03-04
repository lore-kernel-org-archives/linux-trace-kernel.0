Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB623BD1B;
	Wed,  4 Mar 2026 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588916; cv=none; b=VcVM6PH/9H5KxYtzxZp7ZOOV5AQwXVZnngOU62g1tIi6ehFFeapdsOuv2nNw5xYNVDoELrFz3k9tbWnoKHUoEp6Th5oJVaRPSk6ga/FGR3XtlwpzXu7SyIsHzdfarLBFT2NmVMQn2kykgjn0DPrYtrRuhFQMqeiVtr2kPNzR+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588916; c=relaxed/simple;
	bh=Fa9nLYOGHIHdefzwWFDP3AaDErCLowrkNcenetv9BXA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=InskvX8b0+yeNRuMTU87a02TMn8Zf38NOo2spxF7yj8iPZhRHygm0qz0lxBbW6OU4SQwU0zIlYQk/KKbYtE3Y+XT4dIWWRrTUniFlzvSs5tAIig0BckK/FrVPNPhEgSqs5M90Ims0a6o21LjSe4wcmn0luWUnZIZBWMveGAItPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul6QKCwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul6QKCwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B753C116C6;
	Wed,  4 Mar 2026 01:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772588915;
	bh=Fa9nLYOGHIHdefzwWFDP3AaDErCLowrkNcenetv9BXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ul6QKCwK91bg0QFzXIybQTpXMCy+daPHWbucxDZ8U6cBI8003uei0PfqUZjxrbwpr
	 h4ISCY5bSowbeNvsIeA75NRwY5gbKtCXGz5ob4eIY8QXS3j2u0ECwfnv59HXAqRsu7
	 A0uW2eY2MwPbeR20MQ2IWP6KQsm+RoGdUrz7kQ13PImqS6MgogXoFpeE0WffleaFUZ
	 aRlUXVK90xP0KgZZF3C7/bI4OTHo4YErekJTjNrIzYpmWlyuIPHxo+CFmgrzW/WWlb
	 +D+PcltSc4al3z1VPsIxd4JfRb7/ciWogYG8f3gd9VJNKuc6XE/LLnwoOWSZRy574r
	 qjUCEBwPmH5sg==
Date: Wed, 4 Mar 2026 10:48:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Disable preemption in the tracepoint callbacks
 handling filtered pids
Message-Id: <20260304104833.7b157f3cd2ff911cbcf77660@kernel.org>
In-Reply-To: <20260303093949.4210e854@gandalf.local.home>
References: <20260302213546.156e3e4f@gandalf.local.home>
	<20260303131706.96057f61a48a34c43ce1e396@kernel.org>
	<20260303093949.4210e854@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Mar 2026 09:39:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 3 Mar 2026 13:17:06 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 9928da636c9d..3b3aaf4831e9 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -1039,6 +1039,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
> >  	struct trace_pid_list *pid_list;
> >  	struct trace_array *tr = data;
> >  
> > +	guard(preempt)();
> >  	pid_list = rcu_dereference_raw(tr->filtered_pids);
> >  	trace_filter_add_remove_task(pid_list, NULL, task);
> >  
> > @@ -1054,6 +1055,7 @@ event_filter_pid_sched_process_fork(void *data,
> >  	struct trace_pid_list *pid_list;
> >  	struct trace_array *tr = data;
> >  
> > +	guard(preempt)();
> >  	pid_list = rcu_dereference_sched(tr->filtered_pids);
> >  	trace_filter_add_remove_task(pid_list, self, task);
> >  
> 
> Yep. I can make them two different patches. Do you want me to take this as
> your patch? I'll need a SoB from you then.

I think we can combine those since it fixes the same commit.
(just for bisectability)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
