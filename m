Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F51307AE3;
	Tue, 18 Nov 2025 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453513; cv=none; b=mFnuD9VkUuMNkIrR51zEJQKC14sjhHc+9hu6dVRqr2MvLoehK+J2C/99enUf/5F76BcREer4vFIo6TJtKFKCeKBFYqzw3pVU4bVWAMBwFoDXFV0G9/N/Q8exxGI5PCm7O238qs3ZaBOSIruecujT1I0ftkFv84tVUDwqkuooWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453513; c=relaxed/simple;
	bh=azixfj45mLMgmy/9ZXyv9rbPj8m4aG4BUBrgTP9yh9Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XD+OXHI4O0gKKRFP/sprs1B2oYDxvcBjhVV2dMfUbGTJ9uF64fhp6O/Ad2KsEs2TaT3BLarn3+z1hqY3GR8uFC9pPvKn4LCbj5prGWzl6HbpRH1qIO3wCzepqtETxJjePMpROjywFwBfjoQ07PfTkgjiIjUvUId6v9l0v7HoZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIBRYyuy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIBRYyuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984BEC19424;
	Tue, 18 Nov 2025 08:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763453512;
	bh=azixfj45mLMgmy/9ZXyv9rbPj8m4aG4BUBrgTP9yh9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hIBRYyuySVBwcuni5hZKpBS8zi8+llwGC4Di/s4tGVkqVF0i00p28HOJqoNE6gOuF
	 IBcthlmivl0AheTQU9qkVV8jfique/kXU/n5IWVrImHWJ9s+Wbh2h6PP5AYbBM9R/e
	 OZm7z7MItyX5bAEEU2o6NgnNODG3W0j5wlRRwoJ9kMLmuiSuaIbvmEZVYDcqYB18A0
	 O8B9y3JNj+XU2VLRcNkbd5EADnlN++6yjaMyV9jmn8qgLCUTAxP391VzhVE7HfpN+p
	 D0o4Pg7sSygN2NzCYeMv8usoBSEBAZfVgYn+rmAFqBkHSixU1pd0mAGsy59VI/DSra
	 wJdbPA+4ebzSg==
Date: Tue, 18 Nov 2025 17:11:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Namhyung
 Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 0/3] tracing: Add perf events to trace buffer
Message-Id: <20251118171147.72d4f1e26407f8d54720e0f2@kernel.org>
In-Reply-To: <20251117224227.782f6eab@batman.local.home>
References: <20251118002950.680329246@kernel.org>
	<20251118120821.0c47ef684b53d5d9a2d6dc83@kernel.org>
	<20251117224227.782f6eab@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 22:42:27 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> > > As this will eventual work with many more perf events than just cache-misses
> > > and cpu-cycles , using options is not appropriate. Especially since the
> > > options are limited to a 64 bit bitmask, and that can easily go much higher.
> > > I'm thinking about having a file instead that will act as a way to enable
> > > perf events for events, function and function graph tracing.
> > > 
> > >   set_event_perf, set_ftrace_perf, set_fgraph_perf  
> > 
> > What about adding a global `trigger` action file so that user can
> > add these "perf" actions to write into it. It is something like
> > stacktrace for events. (Maybe we can move stacktrace/user-stacktrace
> > into it too)
> > 
> > For pre-defined/software counters:
> > # echo "perf:cpu_cycles" >> /sys/kernel/tracing/trigger
> 
> For events, it would make more sense to put it into the events directory:
> 
>  # echo "perf:cpu_cycles" >> /sys/kernel/tracing/events/trigger
> 
> As there is already a events/enable
> 
> Heck we could even add it per system:
> 
>  # echo "perf:cpu_cycles" >> /sys/kernel/tracing/events/syscalls/trigger

Yes, this will be very useful!


> 
> > 
> > For some hardware event sources (see /sys/bus/event_source/devices/):
> > # echo "perf:cstate_core.c3-residency" >> /sys/kernel/tracing/trigger
> > 
> > echo "perf:my_counter=pmu/config=M,config1=N" >> /sys/kernel/tracing/trigger
> 
> Still need a way to add an identifier list. Currently, if the size of
> the type identifier is one byte, then it can only support up to 256 events.

Yes, so if user adds more than that, it will return -ENOSPC.

> 
> Do we need every event for this? Or just have a subset of events that
> would be supported?

For the event tracing, maybe those are used as measuring delta between
paired events. For such use case, user may want to set it only on those
events.

> 
> 
> > 
> > If we need to set those counters for tracers and events separately,
> > we can add `events/trigger` and `tracer-trigger` files.
> 
> As I mentioned, the trigger for events should be in the events directory.

Agreed.

> 
> We could add a ftrace_trigger that can affect both function and
> function graph tracer.

Got it.

> 
> > 
> > echo "perf:cpu_cycles" >> /sys/kernel/tracing/events/trigger
> > 
> > To disable counters, we can use '!' as same as event triggers.
> > 
> > echo !perf:cpu_cycles > trigger
> 
> Yes, it would follow the current way to disable a trigger.
> 
> > 
> > To add more than 2 counters, connect it with ':'.
> > (or, we will allow to append new perf counters)
> > This allows user to set perf counter options for each events.
> > 
> > Maybe we also should move 'stacktrace'/'userstacktrace' option
> > flags to it too eventually.
> 
> We can add them, but may never be able to remove them due to backward
> compatibility.

Ah, indeed.

> 
> > > 
> > > And an available_perf_events that show what can be written into these files,
> > > (similar to how set_ftrace_filter works). But for now, it was just easier to
> > > implement them as options.
> > > 
> > > As for the perf event that is triggered. It currently is a dynamic array of
> > > 64 bit values. Each value is broken up into 8 bits for what type of perf
> > > event it is, and 56 bits for the counter. It only writes a per CPU raw
> > > counter and does not do any math. That would be needed to be done by any
> > > post processing.
> > > 
> > > Since the values are for user space to do the subtraction to figure out the
> > > difference between events, for example, the function_graph tracer may have:
> > > 
> > >              is_vmalloc_addr() {
> > >                /* cpu_cycles: 5582263593 cache_misses: 2869004572 */
> > >                /* cpu_cycles: 5582267527 cache_misses: 2869006049 */
> > >              }  
> > 
> > Just a style question: Would this mean the first line is for function entry
> > and the second one is function return?
> 
> Yes.
> 
> Perhaps we could add field to the perf event to allow for annotation,
> so the above could look like:
> 
>               is_vmalloc_addr() {
>                /* --> cpu_cycles: 5582263593 cache_misses: 2869004572 */
>                /* <-- cpu_cycles: 5582267527 cache_misses: 2869006049 */
>              }  
> 
> Or something similar?

Yeah, it looks more readable.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
