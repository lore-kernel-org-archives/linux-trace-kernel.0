Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7317E4;
	Fri,  7 Feb 2025 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738889273; cv=none; b=stKRIgY03B68BOJfgPk2pM49IzEWEh613VRv/yXGHwqmObuin0qqht4m69gzTI4OO17cNjSwyd7ligYcdhT1xSuS3/1v7j53w92TcC799I1pdaIQv0HtPw5mlMRKvTywNhIop5+aU2hPt3NyyYcJ2eANPtpi8g9sH0n3EIY2g9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738889273; c=relaxed/simple;
	bh=w8UjyACvoFHxPDNReEpOPs72erNDTwxnFeiTpkJNDOM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nvAmMY5xL25Wq2ECNGvqDFA04v7xz4FCWFjxBob3iBlUbtN4yY50uMwY+FdcinJjhKYm1I1jCfR2IkcFkqT0e4QvSPClRDcmRdCq7KBFop2u3GKV8WR0pkTKlcsqHhwVrXAKYTCiEL3yAR9b2InLPZZ9BOt6O+AkHleDSYpPbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plFuOlOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plFuOlOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D10C4CEDD;
	Fri,  7 Feb 2025 00:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738889272;
	bh=w8UjyACvoFHxPDNReEpOPs72erNDTwxnFeiTpkJNDOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=plFuOlOH+8EsQce3Z5ZSCuhg0flkt9ay4pb6MF0UVOxNPv0+8xhGBk4+sUnCUmo/m
	 7XBR8tmFCin3YyjY7miPfkLkVTSNmRpeW3U0xy9mMzZBHIOCv1bz5hOr2PKt0jCniD
	 /8hEM3f0ZtSso8kpya+jb02ZrNEkxp6JkFVq2GbLEuTFQ6N4EOJezvSiO2+GVDxbjY
	 s4hE3y2YkE3nnNPJOvaBQc536ZOb1rDvpAI1lGt6DL1jfmY25a+HRCJit8RRBwHTTM
	 hTxdG4vG6mVpZdJUZiCvp3e/VyKWugLrRjEJv6D1pnobT6phSXmENJlJtH8wyJNKlN
	 IQq4Dy2rx6Rlw==
Date: Fri, 7 Feb 2025 09:47:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 8/8] tracing: Update modules to persistent instances
 when loaded
Message-Id: <20250207094749.a325cb0eb15b2431fbb7271a@kernel.org>
In-Reply-To: <20250206121820.1ebf3c98@gandalf.local.home>
References: <20250205225031.799739376@goodmis.org>
	<20250205225104.264333506@goodmis.org>
	<20250206190124.1518c3bf070e862da7993d9e@kernel.org>
	<20250206103612.355a4be9@gandalf.local.home>
	<20250207015330.5c71ad55ed2f516da1410711@kernel.org>
	<20250206121820.1ebf3c98@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 12:18:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Feb 2025 01:53:30 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 6 Feb 2025 10:36:12 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Thu, 6 Feb 2025 19:01:24 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >   
> > > > > +static void trace_module_record(struct module *mod)
> > > > > +{
> > > > > +	struct trace_array *tr;
> > > > > +
> > > > > +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> > > > > +		/* Update any persistent trace array that has already been started */
> > > > > +		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
> > > > > +		    TRACE_ARRAY_FL_BOOT) {
> > > > > +			/* Only update if the trace array is active */
> > > > > +			if (trace_array_active(tr))    
> > > > 
> > > > Do we really need this check? It seems that we can just save_mod() if the
> > > > above condition is true.  
> > > 
> > > It gets a little more  complicated if we need to add and remove modules.  
> > 
> > Yeah, but for converting the module address, we don't want to see other
> > module information.
> 
> But we want to see the module information for modules that were loaded
> during the trace. If a module is removed and suddenly the system crashed,
> we just lost that information. Hence why I reset the module information
> when the tracing starts.

Then, what about removing module info if the address is recycled for
new module? We can keep it until the same address range is used by other
module(s).

> 
> 
> > > If we want to have events for modules that were removed. Note, the ring
> > > buffer is cleared if any module event was ever enabled and then the module
> > > is removed, as how to print it is removed too. But we could disable that
> > > for the persistent ring buffers as they should not be using the default
> > > trace event print format anyway.  
> > 
> > Yeah, if the event is on the module the buffer is cleared.
> > But the module address can be in the stacktrace. In that case, the event
> > in the module is not enabled, but other events like sched_switch can
> > take stacktrace which can include the module address. In that case, the
> > buffer is also cleared when the module is removed?
> 
> No. The buffer is only cleared if one of its events were ever enabled. If
> no event within the module was enabled, then the buffer is not cleared.
> 
> > 
> > > As for stack traces, we still want the module it was for when the stack
> > > trace happens. A common bug we see is when a module is removed, it can
> > > cause other bugs. We want to know about modules that were removed. Keeping
> > > that information about removed modules will allow us to see what functions
> > > were called by a stack trace for a module that was removed.  
> > 
> > Hmm, but that should be covered by module load/unload events?
> 
> If we have them enabled.

Yes, and current module load event does not cover the address. I think
we can add a new event to log it.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
