Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34B25EFBC;
	Tue, 25 Mar 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919899; cv=none; b=J9p3xNDS0uFm2fUnEPnFpcgRlcxpx+yRG6L8z2k5tPFVxlBlKppe1UNk50Hpt1j4vG9TSY79Xo4J8eWKeHiueXEG8dWg+fkmwG6wGuFeFxEdf9TSU/D6EQpxKGEmedbRzssdH00yonjH3XRapqYqxPjI90nChDI1jYC+1ta1qo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919899; c=relaxed/simple;
	bh=Jf5QeiRGrAJkT2xtRP6oG4u7YIZYPlXTcKqRPOOEXDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ER6RQsH5P8EJT7mQwlCGS+hPuh4B3SPWtQNzOkElgTcU7cXBQsNJtpfapQZIfKuk7Cboj969rfg+66ZYMfYQevG4+/FcTtlwp+gXQF1bltn6ytjOpVebsA5LP5OIAnJ72pojHhV4GPEB3gde/LkfzRBntzMRkubviAZACgc2zD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E74C4CEEA;
	Tue, 25 Mar 2025 16:24:58 +0000 (UTC)
Date: Tue, 25 Mar 2025 12:25:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 3/3] tracing: Rename trace_synth() to
 synth_event_trace2()
Message-ID: <20250325122542.02973078@gandalf.local.home>
In-Reply-To: <9f030639-2ce2-4400-90e4-6c7dfbabf42c@arm.com>
References: <20250318180814.226644-1-douglas.raillard@arm.com>
	<20250318180814.226644-3-douglas.raillard@arm.com>
	<20250319223728.ca7a5ac6fa37798d17bd2e29@kernel.org>
	<3732e7f8-a452-4f65-8e8b-1575c01d33b9@arm.com>
	<20250324152945.e47bc6d1e491658cfc6924fe@kernel.org>
	<9f030639-2ce2-4400-90e4-6c7dfbabf42c@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 16:05:00 +0000
Douglas Raillard <douglas.raillard@arm.com> wrote:

> Yes, the dynamic API was exactly what I needed unfortunately. I'm porting the kernel module we have to Rust (using our own bindings as
> we cannot mandate CONFIG_RUST=y). While I have some support for C code generation based on the Rust source, it is significantly more
> convenient to simply use a dynamic API. In the current state of my code, defining an event is as simple as:
> 
>    let f = new_event! {
>    	lisa__myevent2,
>    	fields: {
>    		field1: u8,
>    		field3: &CStr,
>    		field2: u64,
>    	}
>    }?;
>    
>    // Emit the event
>    f(1, c"hello", 2);
>    f(3, c"world", 4);
> 
> So it's as non-confusing can be: the event name is stated plainly and the field names and types are mentioned once, with no repetition.
> The result can simply be called to emit the event, and when dropped, the event is unregistered.

Interesting.

> 
> 
> On top of that in ways unrelated to Rust:
> 1. We have some really high traffic event (PELT-related) that include some data that is not always needed (e.g. taskgroup name).
>     We currently regularly hit memory size limitation on our test device (pixel 6), and using trace-cmd record instead of
>     trace-cmd start is not always a good idea as this will have an effect on scheduling, disturbing the very thing we are trying
>     to observe. Having the dynamic API means we could simply omit the fields in the event that we don't care about in a specific
>     experiment via dynamic configuration.
> 
> 2. Some events may or may not be supported on the system based on some runtime condition. Currently, there is no great way for
>     the module to feed back that info. No matter what, the event exists, even if the machinery that is supposed to emit it is
>     disabled for whatever reason. If some user starts tracing the event "everything will work" and there will be no event in the
>     trace. That may make the user think a condition did not trigger, whereas in fact the whole machinery was simply not operating.
>     Being able to register or not the event dynamically solves that cleanly, as enabling the event will simply fail as it won't
>     have been registered in the first place.
> 
> 3. We will likely at some point relay events coming from some non-CPU part of the system into the ftrace buffer. If and when that
>     happens, it would be ideal if that producer can simply declare the events it supports, and our module dynamically create the
>     matching synthetic events. That would avoid any problem coming from mismatching source that would otherwise plague such setup.
> 
> So considering things seem to work overall with not much tuning needed, it would be sad to have to revert to TRACE_EVENT() macro
> and end up having to do more work for a worse result. If that's the route you choose though, it may be nice to amend the
> documentation to clearly state this API is testing-only and not supported in normal use case, as it currently reads:
> 
>    The trace event subsystem provides an in-kernel API allowing modules
>    or other kernel code to generate user-defined 'synthetic' events at
>    will, which can be used to either augment the existing trace stream
>    and/or signal that a particular important state has occurred.

Note, there is also a CUSTOM_TRACE_EVENT() macro that can attach to any
tracepoint (including those that have a TRACE_EVENT() already attached to
them) and create a new trace event that shows up into tracefs.

I still do not think "synthetic events" should be used for this purpose.
They are complex enough with the user interface we shouldn't have them
created in the kernel. That documentation should be rewritten to not make
it sound like the kernel or modules can create them.

That said, it doesn't mean you can't use dynamic events for this purpose.
Now what exactly is that "new_event!" doing?

I guess, what's different to that than a kprobe event? A kprobe event is a
dynamic trace event in the kernel. Could you do the same with that? Or is
this adding a nop in the code like a real event would?

I'm not against rust dynamic events, but I do not think synthetic events
are the answer. It will just cause more confusion.

I also added Alice to the Cc, as she has created trace events for Rust.

-- Steve
