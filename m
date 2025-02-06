Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AF239585;
	Thu,  6 Feb 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862261; cv=none; b=AqfY3p6qEEFT82A00zjfEoRIoNqDV9sU96dS/s/9z9NCblAYhPpNH2VbQHdM/c6HypClHDrXfUq9zD/XyE5l2GWVPJs/OwJQk3ROrGNVBi3xdm9y69UJ+eW68MWe9e+Z6h0Kz4OdR9Fe3UJ9sROqgODwLCHp5ZU563rVOB4c1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862261; c=relaxed/simple;
	bh=crTHumSAMVWLcvTo2eaTjMQzspDTRycB6MBoLGS130E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlKMphlTqt3/X+fwCm6J3khnTDu4wNnL8OrkUkiLpSDGliBIqHcIgMYtB/PQwkCCtwF5wSINfIOCKbpjyYkSa2PuiOndjb4AdPCtfhNW88LFOv2S9LMAgeYZmHmp0WKPn/Y51rTuVhkdtNO+woBAa5LY9WaAUCqGE0DFKr0r2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464ECC4CEDD;
	Thu,  6 Feb 2025 17:17:39 +0000 (UTC)
Date: Thu, 6 Feb 2025 12:18:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 8/8] tracing: Update modules to persistent instances
 when loaded
Message-ID: <20250206121820.1ebf3c98@gandalf.local.home>
In-Reply-To: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225104.264333506@goodmis.org>
	<20250206190124.1518c3bf070e862da7993d9e@kernel.org>
	<20250206103612.355a4be9@gandalf.local.home>
	<20250207015330.5c71ad55ed2f516da1410711@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 01:53:30 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 6 Feb 2025 10:36:12 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 6 Feb 2025 19:01:24 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >   
> > > > +static void trace_module_record(struct module *mod)
> > > > +{
> > > > +	struct trace_array *tr;
> > > > +
> > > > +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> > > > +		/* Update any persistent trace array that has already been started */
> > > > +		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
> > > > +		    TRACE_ARRAY_FL_BOOT) {
> > > > +			/* Only update if the trace array is active */
> > > > +			if (trace_array_active(tr))    
> > > 
> > > Do we really need this check? It seems that we can just save_mod() if the
> > > above condition is true.  
> > 
> > It gets a little more  complicated if we need to add and remove modules.  
> 
> Yeah, but for converting the module address, we don't want to see other
> module information.

But we want to see the module information for modules that were loaded
during the trace. If a module is removed and suddenly the system crashed,
we just lost that information. Hence why I reset the module information
when the tracing starts.


> > If we want to have events for modules that were removed. Note, the ring
> > buffer is cleared if any module event was ever enabled and then the module
> > is removed, as how to print it is removed too. But we could disable that
> > for the persistent ring buffers as they should not be using the default
> > trace event print format anyway.  
> 
> Yeah, if the event is on the module the buffer is cleared.
> But the module address can be in the stacktrace. In that case, the event
> in the module is not enabled, but other events like sched_switch can
> take stacktrace which can include the module address. In that case, the
> buffer is also cleared when the module is removed?

No. The buffer is only cleared if one of its events were ever enabled. If
no event within the module was enabled, then the buffer is not cleared.

> 
> > As for stack traces, we still want the module it was for when the stack
> > trace happens. A common bug we see is when a module is removed, it can
> > cause other bugs. We want to know about modules that were removed. Keeping
> > that information about removed modules will allow us to see what functions
> > were called by a stack trace for a module that was removed.  
> 
> Hmm, but that should be covered by module load/unload events?

If we have them enabled.

-- Steve
