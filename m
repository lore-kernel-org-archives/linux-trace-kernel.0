Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57D212D6E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070415; cv=none; b=NUUgL50v2Nv0a/uSzhuW4fRZ0PAMpvNi4HVWlXxKmaG+msg9tpLY7nb6+FGbDRtDGlytWzN2aq6NXZ4GTyOE9lcsocSdIdrnYY8YbdracXSt9s14Q7BovN/kFxV/Fi5TQex17U+8oM8Ft/5Yiy8ThvXEKO/rMatlwp8DUxQmyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070415; c=relaxed/simple;
	bh=U/eZ0oUVQM00VSo0/HvcMo60Qu/CLyn6lUj0799HsKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSRf4mZuChyQnPYyvEM4N1DZpA1hcPwQbplFovGxznMM9ASic0Rwqb5x7AQPsS27GbeRrlHM3Vob/SUClnSE2KZVocolx5NT017DybK9wY/p/KJfeTQVttqoGuiiTlPu+GbADKe7acJyqcv4EhnqjmtLKtX0cYI3ZPZLQ+to/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49060C4CED1;
	Thu, 20 Feb 2025 16:53:34 +0000 (UTC)
Date: Thu, 20 Feb 2025 11:54:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH] ftrace: Correct preemption accounting for function
 tracing.
Message-ID: <20250220115400.4d75d881@gandalf.local.home>
In-Reply-To: <44ymxgot422oetab62w55rth5tqrzseyhwirxg2ho7vzvvkaud@qiada52ckt25>
References: <20250220140749.pfw8qoNZ@linutronix.de>
	<44ymxgot422oetab62w55rth5tqrzseyhwirxg2ho7vzvvkaud@qiada52ckt25>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 12:10:30 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> On Thu, Feb 20, 2025 at 03:07:49PM +0100, Sebastian Andrzej Siewior wrote:
> > The function tracer should record the preemption level at the point when
> > the function is invoked. If the tracing subsystem decrement the
> > preemption counter it needs to correct this before feeding the data into
> > the trace buffer. This was broken in the commit cited below while
> > shifting the preempt-disabled section.
> > 
> > Use tracing_gen_ctx_dec() which properly subtracts one from the
> > preemption counter on a preemptible kernel.
> > 
> > Cc: Wander Lairson Costa <wander@redhat.com>
> > Fixes: ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > I haven't been ftrace for quite some time if I got the fixes tag right.
> > 
> >  kernel/trace/trace_functions.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> > index d358c9935164d..df56f9b760109 100644
> > --- a/kernel/trace/trace_functions.c
> > +++ b/kernel/trace/trace_functions.c
> > @@ -216,7 +216,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
> >  
> >  	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
> >  
> > -	trace_ctx = tracing_gen_ctx();
> > +	trace_ctx = tracing_gen_ctx_dec();
> >  
> >  	data = this_cpu_ptr(tr->array_buffer.data);
> >  	if (!atomic_read(&data->disabled))
> > @@ -321,7 +321,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
> >  	struct trace_array *tr = op->private;
> >  	struct trace_array_cpu *data;
> >  	unsigned int trace_ctx;
> > -	unsigned long flags;
> >  	int bit;
> >  
> >  	if (unlikely(!tr->function_enabled))
> > @@ -347,8 +346,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
> >  	if (is_repeat_check(tr, last_info, ip, parent_ip))
> >  		goto out;
> >  
> > -	local_save_flags(flags);
> > -	trace_ctx = tracing_gen_ctx_flags(flags);
> > +	trace_ctx = tracing_gen_ctx_dec();
> >  	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
> >  
> >  	trace_function(tr, ip, parent_ip, trace_ctx);
> > -- 
> > 2.47.2
> >   
> 
> It now reports the preemption count correctly:
> 
>     kworker/0:5-88      [000] b...3   211.972885: e1000_check_for_ack_vf <-e1000_write_posted_mbx
>      kworker/0:5-88      [000] b...3   211.983386: e1000_read_posted_mbx <-e1000_reset_hw_vf
>      kworker/0:5-88      [000] b...3   211.983389: e1000_init_hw_vf <-igbvf_reset
>      kworker/0:5-88      [000] b...3   211.983390: e1000_rar_set_vf <-e1000_init_hw_vf
>      kworker/0:5-88      [000] b...3   211.983390: e1000_write_posted_mbx <-e1000_rar_set_vf
>      kworker/0:5-88      [000] D.Zf2   211.983391: igbvf_reset_L14: (igbvf_reset+0x62/0x120 [igbvf])
>      kworker/0:5-88      [000] .N...   211.983396: igbvf_reset_L16: (igbvf_reset+0x7b/0x120 [igbvf])
>   irq/63-ens14f0-1122    [000] b...2   211.983399: igb_msix_other <-irq_thread_fn
>   irq/63-ens14f0-1122    [000] b...2   211.983399: igb_rd32 <-igb_msix_other
>   irq/63-ens14f0-1122    [000] b...3   211.983400: igb_check_for_rst <-igb_msix_other
>   irq/63-ens14f0-1122    [000] b...3   211.983400: igb_check_for_rst_pf <-igb_msix_other
>   irq/63-ens14f0-1122    [000] b...3   211.983400: igb_rd32 <-igb_check_for_rst_pf
>   irq/63-ens14f0-1122    [000] b...3   211.983401: igb_check_for_msg <-igb_msix_other
>   irq/63-ens14f0-1122    [000] b...3   211.983401: igb_check_for_msg_pf <-igb_msix_other
>   irq/63-ens14f0-1122    [000] b...3   211.983401: igb_rd32 <-igb_check_for_msg_pf
>   irq/63-ens14f0-1122    [000] b...3   211.983402: igb_check_for_ack <-igb_msix_other
>   irq/63-ens14f0-1122    [000] b...3   211.983402: igb_check_for_ack_pf <-igb_msix_other
> 
> (Except in line 6 where it show 'f', which seems to be an unrelated issue)

But it appears to be consistent.

Let me go and add some probes and see what they show. The output you gave
me that I requested didn't show anything unusual.

-- Steve
