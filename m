Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145744C8E;
	Thu,  6 Feb 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860815; cv=none; b=JyzoJBNllXcUZA0lqti0MYQLJtu8fwB5OQ5wsE2jUVkHnWG+/eQi5DWBL7mHoCayZmN4oR5NGe6C/HvdTYqf063YrP6Kxin13yjRKPoGLz1d34xmycccjTD/UTAW0JWfjbSKyuH4ccDSWoVSQYth43BEhNeoL0UAzm00an66dfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860815; c=relaxed/simple;
	bh=DKO+kwALhFMpC8zVOlPUIw99ENox0XfOW1iKe3jlteY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GKUCpG6u/LXQ3cJoMSW8fDCFeg4JnAJ6pXUXxk4rh8N6hWdksMqtvabOmVi9gIfZMvCJTESxu8PNAPNueew5InutTosyu+OQA1u3iqshOX2j/491nwQzpwe7SYKCa+1OyjcSQSXIG0KuVcYn+279zWXTDPGYlHzD7pM85713lgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrxziGze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrxziGze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3331C4CEDD;
	Thu,  6 Feb 2025 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738860813;
	bh=DKO+kwALhFMpC8zVOlPUIw99ENox0XfOW1iKe3jlteY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BrxziGze6dZHIHcRyeZBin2i7LID2pNMsvbPZE1ytT7PgNVZca/lti85SES7bWepU
	 UyBUPgj0NLE0zJ/+hN5dvbdF5fAwtczGFL3e0MPl2teuYyzNtOk7q7zYvXeDwTE1uC
	 wwbiPKw9YWvUGK74vUvVtxUpEtItWXcyYRN0+t+14/Cl679/3BhzSTfW3jIQr6z3DV
	 ISkLV7NZc3TU6syrJffla2H4NYTf05Pd+BraETEbdFTANjWidrXDUvfHDOehy/DLqh
	 rWdEM/B/cq9JgKhyM6C9LEsQP2aLxgn8qZ58avIaqEw/GqIDjBp6G0DN+v1sUb9HR6
	 v2UBvh2qfnNsA==
Date: Fri, 7 Feb 2025 01:53:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 8/8] tracing: Update modules to persistent instances
 when loaded
Message-Id: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
In-Reply-To: <20250206103612.355a4be9@gandalf.local.home>
References: <20250205225031.799739376@goodmis.org>
	<20250205225104.264333506@goodmis.org>
	<20250206190124.1518c3bf070e862da7993d9e@kernel.org>
	<20250206103612.355a4be9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 10:36:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 6 Feb 2025 19:01:24 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > +static void trace_module_record(struct module *mod)
> > > +{
> > > +	struct trace_array *tr;
> > > +
> > > +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> > > +		/* Update any persistent trace array that has already been started */
> > > +		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
> > > +		    TRACE_ARRAY_FL_BOOT) {
> > > +			/* Only update if the trace array is active */
> > > +			if (trace_array_active(tr))  
> > 
> > Do we really need this check? It seems that we can just save_mod() if the
> > above condition is true.
> 
> It gets a little more  complicated if we need to add and remove modules.

Yeah, but for converting the module address, we don't want to see other
module information.

> 
> > 
> > > +				save_mod(mod, tr);
> > > +		}
> > > +	}
> > > +}
> > > +
> > >  static int trace_module_notify(struct notifier_block *self,
> > >  			       unsigned long val, void *data)
> > >  {
> > > @@ -10096,6 +10120,7 @@ static int trace_module_notify(struct notifier_block *self,
> > >  	switch (val) {
> > >  	case MODULE_STATE_COMING:
> > >  		trace_module_add_evals(mod);
> > > +		trace_module_record(mod);
> > >  		break;
> > >  	case MODULE_STATE_GOING:
> > >  		trace_module_remove_evals(mod);  
> > 
> > Don't we need to remove the module entry when a module is removed?
> > (everytime we remove a module, trace data is cleared?)
> 
> I do have a patch that that removes entries, but I decided we don't really
> want to do that.
> 
> If we want to have events for modules that were removed. Note, the ring
> buffer is cleared if any module event was ever enabled and then the module
> is removed, as how to print it is removed too. But we could disable that
> for the persistent ring buffers as they should not be using the default
> trace event print format anyway.

Yeah, if the event is on the module the buffer is cleared.
But the module address can be in the stacktrace. In that case, the event
in the module is not enabled, but other events like sched_switch can
take stacktrace which can include the module address. In that case, the
buffer is also cleared when the module is removed?

> As for stack traces, we still want the module it was for when the stack
> trace happens. A common bug we see is when a module is removed, it can
> cause other bugs. We want to know about modules that were removed. Keeping
> that information about removed modules will allow us to see what functions
> were called by a stack trace for a module that was removed.

Hmm, but that should be covered by module load/unload events?

Anyway, this series does not cover the module text address in the stacktrace.
I just made a series of patches (which also not cover the module removal yet),
but it can show the basic idea.

My idea is to sort the previous module entries in the persistent buffer
when it is setup. We also make a "module_delta" array in the trace_array.
Then the print function can searche the appropriate module info from
the sorted table and find corresponding delta from "module_delta".

For example,

/sys/kernel/tracing/instances/boot_mapped # cat trace
           <...>-1629    [006] .....   202.860051: foo_bar_with_fn: foo Look at me 4
           <...>-1629    [006] .....   202.860059: <stack trace>
 => trace_event_raw_event_foo_bar_with_fn
 => simple_thread_fn
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
/sys/kernel/tracing/instances/boot_mapped # cat last_boot_info 
Offset: 0
ffffffffa0016000 trace_events_sample
ffffffffa0025000 trace_printk
/sys/kernel/tracing/instances/boot_mapped # lsmod 

trace_events_sample 45056 0 - Live 0xffffffffa001c000
trace_printk 12288 0 - Live 0xffffffffa0016000

Let me share it.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
