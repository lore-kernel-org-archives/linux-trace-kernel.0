Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF922E3F0;
	Thu,  8 Jan 2026 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840688; cv=none; b=k2LWuJt92v57im7K9dEqRk6DB+afU409wY7oHR93YK5YWkiSUJq9jfPHXd+7N9psDIr4/prVJrdgGoNwfn9nfydB4jcR2imUfpILNKqOE0FDny6Bk5WlljwRo35gNgSVkmSJyXmRPyrdKWLFEHxae8W3Twjbb8v1bmuOHUXM2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840688; c=relaxed/simple;
	bh=m5OWiSf0UJBSVHsGjjM+85zSMCcnK9DKBfMbRTpbKwo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CpBjFffxRq/9ETch2efw08Ats5ZBuDVys5uw751OC3SydqhWuPcTs2UcOeezTw8bfOPuyMfIBhlEJUos6COVqhn90QrAfU92o7v9F8S18FFoEdDY0Vinc1ayqnO7YW2XaponxZsYCz5Zqo4O7IXVsjNbmkhmL0yIymvSCrbt5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBVlVe3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBVlVe3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F340C4CEF1;
	Thu,  8 Jan 2026 02:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767840687;
	bh=m5OWiSf0UJBSVHsGjjM+85zSMCcnK9DKBfMbRTpbKwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBVlVe3OkT3kev6vQnmoO4q8Y/rL7TjuDweBohCb7AZOEG0DaYLPfEPAPTBTwWE7J
	 MQby2GyV+rbCrNYvfYPgvxj7mcbB3/EDeYqC6L1NmG6pkyZhc7WriIJ4V3WUPB2T/V
	 mPuoBIPLg2cOAwxC3hvzNlul5yHUcWbtr769bTsT6pxcTY/XLKjWqUADDNuhlCkVca
	 be9emORO3n5N1JJMu/sDafxPi2sNjCwuc+tWEZtOtxfQadTETJhsaOkMAYDOeAeQ5R
	 hJuglAyNH8JHHrbc9TjhbwuoMna2R6LNW6CaVvkaoqmx2F2U82haxZAfT1WEsAeECJ
	 1htchw2QkoJOg==
Date: Thu, 8 Jan 2026 11:51:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Make the backup instance readonly
Message-Id: <20260108115125.b832464d94ebcfd0ea3b5af4@kernel.org>
In-Reply-To: <20260107114133.7f14dac2@gandalf.local.home>
References: <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
	<176779715937.4193242.8486149802702305279.stgit@mhiramat.tok.corp.google.com>
	<20260107114133.7f14dac2@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 11:41:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Jan 2026 23:45:59 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since there is no reason to reuse the backup instance, make it
> > readonly. Note that only backup instances are readonly, because
> > other trace instances will be empty unless it is writable.
> > Only backup instances have copy entries from the original.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace.c        |   91 ++++++++++++++++++++++++++++++++-----------
> >  kernel/trace/trace.h        |    6 +++
> >  kernel/trace/trace_events.c |   14 +++++--
> >  3 files changed, 84 insertions(+), 27 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 38f7a7a55c23..725930f5980e 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4888,6 +4888,9 @@ static int tracing_open(struct inode *inode, struct file *file)
> >  		int cpu = tracing_get_cpu(inode);
> >  		struct array_buffer *trace_buf = &tr->array_buffer;
> >  
> > +		if (trace_array_is_readonly(tr))
> > +			return -EPERM;
> 
> So this fails if someone opens a file in RDONLY mode?
> 
> Why?

Ah, that's a bug. Let me fix it.

> 
> 
> > +
> >  #ifdef CONFIG_TRACER_MAX_TRACE
> >  		if (tr->current_trace->print_max)
> >  			trace_buf = &tr->max_buffer;
> > @@ -6077,6 +6080,9 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
> >  ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
> >  				  unsigned long size, int cpu_id)
> >  {
> > +	if (trace_array_is_readonly(tr))
> > +		return -EPERM;
> 
> In fact, I don't think we need any of these.

Would you mean we should check readonly 

> 
> > +
> >  	guard(mutex)(&trace_types_lock);
> >  
> >  	if (cpu_id != RING_BUFFER_ALL_CPUS) {
> 
> 
> 
> > @@ -9353,12 +9381,16 @@ static void
> >  tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
> >  {
> >  	struct dentry *d_percpu = tracing_dentry_percpu(tr, cpu);
> > +	umode_t writable_mode = TRACE_MODE_WRITE;
> >  	struct dentry *d_cpu;
> >  	char cpu_dir[30]; /* 30 characters should be more than enough */
> >  
> >  	if (!d_percpu)
> >  		return;
> >  
> > +	if (trace_array_is_readonly(tr))
> > +		writable_mode = TRACE_MODE_READ;
> 
> This is more like what we should do with all the files in a read-only
> instance. Just make all files not allow writes.

Actually, that's my first prototype but it did not work (at least on
tracefs).
Superuser can write anything unless the file does not have .write
operation.

> 
> We may need to make sure they can't be changed to write as well. But that
> will require a change to tracefs (and eventfs).

Ah, you mean the permission check is not correctly done in tracefs/eventfs yet?

Thank you,

> 
> -- Steve
> 
> 
> > +
> >  	snprintf(cpu_dir, 30, "cpu%ld", cpu);
> >  	d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
> >  	if (!d_cpu) {
> > @@ -9371,7 +9403,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
> >  				tr, cpu, &tracing_pipe_fops);
> >  
> >  	/* per cpu trace */
> > -	trace_create_cpu_file("trace", TRACE_MODE_WRITE, d_cpu,
> > +	trace_create_cpu_file("trace", writable_mode, d_cpu,
> >  				tr, cpu, &tracing_fops);
> >  
> >  	trace_create_cpu_file("trace_pipe_raw", TRACE_MODE_READ, d_cpu,
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
