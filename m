Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFE1494CC;
	Fri, 31 Oct 2025 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874193; cv=none; b=HDnDUqEdaw++NSSJHXZ67ZPJ/qJzNkmKqlVmLGr8o5gVajdzvU52uJgYbw8p2HPgHCrwJVgOr/Te9ov61Fe8hZIeG8jVtFARbslSGZmR01UFHeZJtUbZUuRZxwJYMmifc5hMUYhLO8VVhTIBbvgVurYYRmDo9NF6EI6Fs3YA13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874193; c=relaxed/simple;
	bh=M2Ki4xBbuTViRC6kYySgCoDnEUoVz5i4+1wnPnoG+Gg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d7HwGyJ2Ib2mTtT8vwYVIAoEMSxSHQsqn64S5ftVCCkv3uXxTJsMO5tdow7yZqDchPuoe8P5rnUGhT0WQsUmtXCGUkkNmwOqXh8EB8HwtVkpXYxW8qLt2OHEAHblz8ncfwjCe2JDncuCwKPxxItS8DpwOZ4OllNO0g9uHzosNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNMhgEjU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNMhgEjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD75BC4CEF1;
	Fri, 31 Oct 2025 01:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761874191;
	bh=M2Ki4xBbuTViRC6kYySgCoDnEUoVz5i4+1wnPnoG+Gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MNMhgEjUHRERuAORKQ9LsOLRqftrR9+lbdz4YrmsXgGPyfH70S81Q/yxXFXrR/EWV
	 o6xuColzeWwKVE5v7cqOXV8IiEoBpOLcPlOQzEZj8cAusqqBWRDqF3LgIPBG4un/WC
	 1UrrHpmdRV9gpihKhzJ451soLqpWXUcHk2QFo0ppxR2q75g9QpGaPFJ+9EpVhRUqfs
	 1TyLMyWniSqypsti7GdeKbdZT5jQPHQG/r51YzK7PCLBzCOgZUvOunm7p1BRDPSDVb
	 AE71b4lINlu8ljn3emHM7isFT37XHMrFs0gsa2bhB+KDlYeyAPGXHRNpHeOsE6liCy
	 9H3+bZLifyIFg==
Date: Fri, 31 Oct 2025 10:29:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-Id: <20251031102947.c2cc7f437db1399c7ebc1863@kernel.org>
In-Reply-To: <20251030052548.31130e33@gandalf.local.home>
References: <176179500583.960652.5730113001091388258.stgit@devnote2>
	<20251030052548.31130e33@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 05:25:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 30 Oct 2025 12:30:05 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> >  kernel/trace/blktrace.c              |    6 +
> >  kernel/trace/ftrace.c                |   26 ++++++
> >  kernel/trace/trace.c                 |  154 +++++++++++++++++-----------------
> >  kernel/trace/trace.h                 |   40 +++++----
> >  kernel/trace/trace_events.c          |    4 -
> >  kernel/trace/trace_events_synth.c    |    2 
> >  kernel/trace/trace_fprobe.c          |    6 +
> >  kernel/trace/trace_functions_graph.c |   18 ++--
> >  kernel/trace/trace_irqsoff.c         |   30 +++----
> >  kernel/trace/trace_kdb.c             |    2 
> >  kernel/trace/trace_kprobe.c          |    6 +
> >  kernel/trace/trace_output.c          |   18 ++--
> >  kernel/trace/trace_sched_wakeup.c    |   24 +++--
> >  kernel/trace/trace_syscalls.c        |    4 -
> >  kernel/trace/trace_wprobe.c          |    2 
> 
> I didn't realize this affected your branch too. Which means I can't apply
> this to any branch.

Ah, I rebased it on the linux-trace/for-next, the auto merged branch.
Let me rebase it on trace/for-next.

> 
> Also, could you make a helper function...
> 
> +++ b/kernel/trace/trace_wprobe.c
> @@ -260,7 +260,7 @@ print_wprobe_event(struct trace_iterator *iter, int flags,
>  
>         trace_seq_printf(s, "%s: (", trace_probe_name(tp));
>  
> -       if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
> +       if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER(SYM_OFFSET)))
>                 goto out;
>  
>         trace_seq_putc(s, ')');
> 
> that both fprobe and wprobe use? And then you don't need to have this open
> coded everywhere.

Yeah, OK.

> 
> That is, add this patch:
> 
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 591adc9bb1e9..bd26004cc320 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -598,3 +598,9 @@ struct uprobe_dispatch_data {
>  	struct trace_uprobe	*tu;
>  	unsigned long		bp_addr;
>  };
> +
> +static inline int probe_print_ip_sym(struct trace_seq *s, unsigned long ip,
> +				     int flags)
> +{
> +	retun seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET);
> +}
> 
> And use that instead.

Shouldn't we make it trace-wide function ? 

> 
> So, new plan. Base this patch on top of v6.18-rc3 and send that.
> 

OK.

> Then what we can do is merge this branch into your branch and my branch and
> add on top of it.
> 
> Note, you should have rebased your probe branch on top of one of the
> v6.18-rc releases. It's still based on top of 6.17-rc6, which can cause
> other issues.

OK.

Thank you,

> 
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
