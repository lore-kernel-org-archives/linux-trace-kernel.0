Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DB1EDA29;
	Thu,  6 Feb 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856132; cv=none; b=bv/oD5RaKUHLtXbMzy1hFo39X9nwSnfeOmhBznI1GCvgcqyyOiRf7OKS8YqvLW7HOZk6vK0uJ6P3li4C+v/X3JIOS3Wsg63774wcBG6iKkszMkSEm+OT9FiqXbbD+8OnaqljkSCdxN72yEradwP5fwkgpLibnMzTJyK0vjneg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856132; c=relaxed/simple;
	bh=gOMHX2Q+w6hLohZgDMrr4HjRsOKoZUv4ynW5WakTNa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1iZ8YiPrZnilUfG7TAm3K2rs5Q61C1qi5KuEuhHKeDi/Xlaomil49YQ75VEsgO49xoPMeM0/vgMuOw7Ougkr+jfIRdPN54ERDeGiWLQlsKGQgBQ1ew9H4yEmczB93NF3GRgKUkHSeyAWbzxFM0vhsqIZI6ZGOo0J7hGvyVsBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB99C4CEDF;
	Thu,  6 Feb 2025 15:35:30 +0000 (UTC)
Date: Thu, 6 Feb 2025 10:36:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 8/8] tracing: Update modules to persistent instances
 when loaded
Message-ID: <20250206103612.355a4be9@gandalf.local.home>
In-Reply-To: <20250206190124.1518c3bf070e862da7993d9e@kernel.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225104.264333506@goodmis.org>
	<20250206190124.1518c3bf070e862da7993d9e@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 19:01:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +static void trace_module_record(struct module *mod)
> > +{
> > +	struct trace_array *tr;
> > +
> > +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> > +		/* Update any persistent trace array that has already been started */
> > +		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
> > +		    TRACE_ARRAY_FL_BOOT) {
> > +			/* Only update if the trace array is active */
> > +			if (trace_array_active(tr))  
> 
> Do we really need this check? It seems that we can just save_mod() if the
> above condition is true.

It gets a little more  complicated if we need to add and remove modules.

> 
> > +				save_mod(mod, tr);
> > +		}
> > +	}
> > +}
> > +
> >  static int trace_module_notify(struct notifier_block *self,
> >  			       unsigned long val, void *data)
> >  {
> > @@ -10096,6 +10120,7 @@ static int trace_module_notify(struct notifier_block *self,
> >  	switch (val) {
> >  	case MODULE_STATE_COMING:
> >  		trace_module_add_evals(mod);
> > +		trace_module_record(mod);
> >  		break;
> >  	case MODULE_STATE_GOING:
> >  		trace_module_remove_evals(mod);  
> 
> Don't we need to remove the module entry when a module is removed?
> (everytime we remove a module, trace data is cleared?)

I do have a patch that that removes entries, but I decided we don't really
want to do that.

If we want to have events for modules that were removed. Note, the ring
buffer is cleared if any module event was ever enabled and then the module
is removed, as how to print it is removed too. But we could disable that
for the persistent ring buffers as they should not be using the default
trace event print format anyway.

As for stack traces, we still want the module it was for when the stack
trace happens. A common bug we see is when a module is removed, it can
cause other bugs. We want to know about modules that were removed. Keeping
that information about removed modules will allow us to see what functions
were called by a stack trace for a module that was removed.

-- Steve
