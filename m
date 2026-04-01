Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9661314D26;
	Wed,  1 Apr 2026 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013599; cv=none; b=dute7PPPteTVOeKswT/7Mr/rWgFdAYyXSRGHDgc/aotyEsCCWBTnXAd2y1l22JBF+7JW2wMRTjCsHLVEJhdXhRTQfuNDCBw123JwsFopyXzS46jDiWIH7qgzVgegRKWBplPlo8BQzNHfYwaGvAy0AMeKR9BY2+ZKWjekB0Af6FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013599; c=relaxed/simple;
	bh=2/77Vb1fcrpcQCt3PjtiaT5/3YNApLfeu58DUnPa3ZA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n10H6/gOGdUwWT34D6TOex/e3WvDr6xYur5cFdpDaNmVT2u3pl4wVajB/bjTd6/1DNR2FKA/oRgjKHzzPhhYak99jWef2bJdEtr1Nd369VrLCJ0eXdrYu7qcclqlf36JZ3HD5ND4oXBerf996UZUm8TmV9+hY/3dgBEnkm4ZHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqAIxm0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqAIxm0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86BDC19423;
	Wed,  1 Apr 2026 03:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775013599;
	bh=2/77Vb1fcrpcQCt3PjtiaT5/3YNApLfeu58DUnPa3ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kqAIxm0u8n8u6OqZZQ7aLvdCQQ7Ferbt978ZmCwVpe87RnaU+LvZmN5B+MOqwpYsv
	 1C7cHfNJqNPolHOb/Hr57grqsW/h9rrS8hwer5clkMaTHnZpPaYbLccwbsejZ7Uwf8
	 U0QIi7bckQo2lkV18+++H3yqzWPbjZ5DFaxclkQfWTgt34h1JMArKQIVN/026dIPH/
	 l7s+dPOEocgLxzFLWj/thZz3DnXJIQ+z8n5iIjumeAG8RqDS536u0sazV/QpQ10tZr
	 PPDZX0CWQJbFL2Fws11diPP6Z2I0fmnqTMZO8w9K55O3o34VpWWPv90sxhCLmFvcAv
	 wb/rO9/eaLGSg==
Date: Wed, 1 Apr 2026 12:19:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] tracing: Remove the backup instance
 automatically after read
Message-Id: <20260401121957.2665d454390aff97593bb996@kernel.org>
In-Reply-To: <20260331171936.6f84e357@gandalf.local.home>
References: <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
	<177497475349.569199.11513916633426967730.stgit@mhiramat.tok.corp.google.com>
	<20260331171936.6f84e357@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 17:19:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  1 Apr 2026 01:32:33 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 8cec7bd70438..1d73400a01c7 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -539,8 +539,65 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
> >  	tr->ring_buffer_expanded = true;
> >  }
> >  
> > +static int __remove_instance(struct trace_array *tr);
> > +
> > +static void trace_array_autoremove(struct work_struct *work)
> > +{
> > +	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
> > +
> > +	guard(mutex)(&event_mutex);
> > +	guard(mutex)(&trace_types_lock);
> 
> Hmm, should we do a check if the tr still exists? Couldn't the user delete
> this via a rmdir after the last file closed and this was kicked?
> 
>   CPU 0							CPU 1
>   -----							-----
>   open(trace_pipe);
>   read(..);
>   close(trace_pipe);
>      kick the work queue to delete it....
> 						rmdir();
> 							[instance deleted]

I thought this requires trace_types_lock, and after kicked the queue,
can rmdir() gets the tr? (__trace_array_get() return error if
tr->free_on_close is set)

> 
>   __remove_instance();
> 
>    [ now the tr is freed, and the remove will crash!]
> 
> 
> What would prevent this is this is to use trace_array_destroy() that checks
> this and also adds the proper locking:
> 
> static void trace_array_autoremove(struct work_struct *work)
> {
> 	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
> 
> 	trace_array_destroy(tr);
> }

OK, let's use it.

> 
> 
> > +
> > +	/*
> > +	 * This can be fail if someone gets @tr before starting this
> > +	 * function, but in that case, this will be kicked again when
> > +	 * putting it. So we don't care about the result.
> > +	 */
> > +	__remove_instance(tr);
> > +}
> > +
> > +static struct workqueue_struct *autoremove_wq;
> > +
> > +static void trace_array_kick_autoremove(struct trace_array *tr)
> > +{
> > +	if (autoremove_wq && !work_pending(&tr->autoremove_work))
> > +		queue_work(autoremove_wq, &tr->autoremove_work);
> 
> Doesn't queue_work() check if it's pending? Do we really need to check it
> twice?

Indeed, it checked the flag.

> 
> > +}
> > +
> > +static void trace_array_cancel_autoremove(struct trace_array *tr)
> > +{
> > +	if (autoremove_wq && work_pending(&tr->autoremove_work))
> > +		cancel_work(&tr->autoremove_work);
> 
> Same here, as can't this be racy?

Yeah, and this should use cancel_work_sync().

> 
> > +}
> > +
> > +static void trace_array_init_autoremove(struct trace_array *tr)
> > +{
> > +	INIT_WORK(&tr->autoremove_work, trace_array_autoremove);
> > +}
> > +
> > +static void trace_array_start_autoremove(void)
> > +{
> > +	if (autoremove_wq)
> > +		return;
> > +
> > +	autoremove_wq = alloc_workqueue("tr_autoremove_wq",
> > +					WQ_UNBOUND | WQ_HIGHPRI, 0);
> > +	if (!autoremove_wq)
> > +		pr_warn("Unable to allocate tr_autoremove_wq. autoremove
> > disabled.\n"); +}
> > +
> >  LIST_HEAD(ftrace_trace_arrays);
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
