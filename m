Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526F4A07;
	Wed, 19 Nov 2025 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763510769; cv=none; b=GTewa9nQwRwqXrjf6FdSvUwFd8R/huSpelKvlts8j+TaeNWLplyZpklP9Le4GdZrYxxxKtzghnIrUHVwrCtB/ozo3fJZncFloKeBNb5a5lBn6H4AOoXFqo9C0XugPHejsxLTEDaRblbQRTLJKOGDQfMSO4VVShdhv9EPrPl5H+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763510769; c=relaxed/simple;
	bh=5qlAftSRqnozlJxCziItMsKaLob0o7k1YAr0YJ8qRb4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GGctOE61oPBAJBhj8N/mzP5zRccp4WM/gUz5MF2nijZiaNF59ZWQEewYp4piJZdVvtXEF41+aL7DYDtSgHdSBjXi9pxA+I35zlXu0tHaZqNImF/R/0szlSiwU03UgXxoqti08zkfRu4hKSY7CeIVefIkuPe4KNFyt3S/8WOqhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcu9PERR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcu9PERR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0024FC4CEF1;
	Wed, 19 Nov 2025 00:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763510766;
	bh=5qlAftSRqnozlJxCziItMsKaLob0o7k1YAr0YJ8qRb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lcu9PERRaVxYFpGWv97l6RGtvEAE0t7wYo0Y8zwRLA6MLNiRBqyrEyT2mOQpbWo+f
	 anP0Df00I7gB+cF+GTFNPunSz3oJPvYFwpeqaRKSmw5oCdQtLDzl7cKJKUHzeE35nD
	 pRry1r2rNUTHnDWECMNczcg6o3vz+MCHl0DQICfZWdOa6niq7uXBr2lnPexfw0QTOp
	 tBgJNluQxMOITMYI1mLTw3+MMbdlaKvt8Y7nSEDDEBHCDGV6ziTE/aXjl7PjlBWOn/
	 xy/ilxosaoWYl+OMKjEXCQzvz0GT9fORbGgC3YzGOclIfXErpJlhOqfO+HAHCFkGic
	 SIUpflzReYZkw==
Date: Wed, 19 Nov 2025 09:06:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Show the tracer options in boot-time created
 instance
Message-Id: <20251119090602.7605a36b3fbc9184abad7a59@kernel.org>
In-Reply-To: <20251118133434.67def626@gandalf.local.home>
References: <176345219055.1127138.4292126981726580037.stgit@mhiramat.tok.corp.google.com>
	<20251118133434.67def626@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 13:34:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 18 Nov 2025 16:49:50 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since tracer_init_tracefs_work_func() only updates the tracer options
> > for the global_trace, the instances created by the kernel cmdline
> > do not have those options.
> > 
> > Fix to update tracer options for those boot-time created instances
> > to show those options.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Fixes: f20a580627f43 ("ftrace: Allow instances to use function tracing")
> 
> Actually, I think this should be:
> 
> Fixes: 428add559b69 ("tracing: Have tracer option be instance specific")
> 
> As it broke when we made function tracer options no longer global.
> 

OK, let me change it.

> > ---
> >  kernel/trace/trace.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 8ae95800592d..2e87060e1d5a 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -10903,6 +10903,7 @@ static struct notifier_block trace_module_nb = {
> >  
> >  static __init void tracer_init_tracefs_work_func(struct work_struct *work)
> >  {
> > +	struct trace_array *tr;
> >  
> >  	event_trace_init();
> >  
> > @@ -10937,7 +10938,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
> >  
> >  	create_trace_instances(NULL);
> >  
> > -	update_tracer_options(&global_trace);
> > +	list_for_each_entry(tr, &ftrace_trace_arrays, list)
> > +		update_tracer_options(tr);
> >  }
> >  
> >  static __init int tracer_init_tracefs(void)
> 
> Since update_trace_options() is only called by this function, instead of
> doing the loop here, change the function to be:
> 
> static __init void update_tracer_options(void)
> {
> 	struct trace_array *tr;
> 
> 	guard(mutex)(&trace_types_lock);
> 	tracer_options_updated = true;
> 	list_for_each_entry(tr, &ftrace_trace_arrays, list)
> 		__update_tracer_options(tr);
> }

OK. Let me send v2.

Thanks,

> 
> Thanks,
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
