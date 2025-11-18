Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6525D546;
	Tue, 18 Nov 2025 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437364; cv=none; b=mdY3yy9uFXAsXwMF1ooC3ygbr9bmyRMXGh4dDvd1NhQTmrclqjNhQdr1N9e9CAP3UcW2E9vGI57VwYTWGq5VETuxdKqvipjN3k9LaAMEaeOi7CTx9q2DsyL0SeuoRTo6OEK2v6C6iZ92OBoFpZ86HoBNsbAiOKKV2F33/LXPPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437364; c=relaxed/simple;
	bh=2XzxuITua8aghT0mcX76gXnjbdcLrh8Bg7jSkhii7mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeA4z3oc1+Jk8/tFx9p5WCKzOpsSM/tELwcdLfmv4zzpYBWkUPArNkPBlYojCzsil80VsZukteKohe5UFPSM2tWstgFJyCSUTKxg4/tWOq86ygot/UE/8YOlJas9/Kd5lOH1si0ivLM/vN05TgBlJjwgtLS2m3HQaLFreWcGVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUMEazAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUMEazAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B430C2BCC4;
	Tue, 18 Nov 2025 03:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763437363;
	bh=2XzxuITua8aghT0mcX76gXnjbdcLrh8Bg7jSkhii7mQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUMEazAQy2NXfUyEQVz1yPi3zU+Vi5AiUK2jEmFBb3MDcCTY21Xu0vipTDhUqyvMI
	 24VVGhdblf9JX6fOmTUbOQA4YY4zR+NL2QiNewLNnwoQ/9h+UAA/GIgYOUww0YPouS
	 eROYwYCJEXsSbgcrhyyRD/F2szWoRTkCHCuZjtKSuNf7SrFq9Jn+bsJuh3fqQRv9Wh
	 toToZ/OPqE9kZFgBPK9LPavn7L732qU61/OeNWCPPZiVMassHlV+DQHO7rAA9PnsiJ
	 Sec0g1MKXTRpjnA4mbAcsFV3SAfGl63HddYET3BUJ4RfdmY8A7TipXAVPxzXtX7z/l
	 XrAq+KipLEAHw==
Date: Mon, 17 Nov 2025 22:42:27 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Namhyung
 Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 0/3] tracing: Add perf events to trace buffer
Message-ID: <20251117224227.782f6eab@batman.local.home>
In-Reply-To: <20251118120821.0c47ef684b53d5d9a2d6dc83@kernel.org>
References: <20251118002950.680329246@kernel.org>
	<20251118120821.0c47ef684b53d5d9a2d6dc83@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 12:08:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Thanks for the great idea!

Thanks!

> > 
> > As this will eventual work with many more perf events than just cache-misses
> > and cpu-cycles , using options is not appropriate. Especially since the
> > options are limited to a 64 bit bitmask, and that can easily go much higher.
> > I'm thinking about having a file instead that will act as a way to enable
> > perf events for events, function and function graph tracing.
> > 
> >   set_event_perf, set_ftrace_perf, set_fgraph_perf  
> 
> What about adding a global `trigger` action file so that user can
> add these "perf" actions to write into it. It is something like
> stacktrace for events. (Maybe we can move stacktrace/user-stacktrace
> into it too)
> 
> For pre-defined/software counters:
> # echo "perf:cpu_cycles" >> /sys/kernel/tracing/trigger

For events, it would make more sense to put it into the events directory:

 # echo "perf:cpu_cycles" >> /sys/kernel/tracing/events/trigger

As there is already a events/enable

Heck we could even add it per system:

 # echo "perf:cpu_cycles" >> /sys/kernel/tracing/events/syscalls/trigger

> 
> For some hardware event sources (see /sys/bus/event_source/devices/):
> # echo "perf:cstate_core.c3-residency" >> /sys/kernel/tracing/trigger
> 
> echo "perf:my_counter=pmu/config=M,config1=N" >> /sys/kernel/tracing/trigger

Still need a way to add an identifier list. Currently, if the size of
the type identifier is one byte, then it can only support up to 256 events.

Do we need every event for this? Or just have a subset of events that
would be supported?


> 
> If we need to set those counters for tracers and events separately,
> we can add `events/trigger` and `tracer-trigger` files.

As I mentioned, the trigger for events should be in the events directory.

We could add a ftrace_trigger that can affect both function and
function graph tracer.

> 
> echo "perf:cpu_cycles" >> /sys/kernel/tracing/events/trigger
> 
> To disable counters, we can use '!' as same as event triggers.
> 
> echo !perf:cpu_cycles > trigger

Yes, it would follow the current way to disable a trigger.

> 
> To add more than 2 counters, connect it with ':'.
> (or, we will allow to append new perf counters)
> This allows user to set perf counter options for each events.
> 
> Maybe we also should move 'stacktrace'/'userstacktrace' option
> flags to it too eventually.

We can add them, but may never be able to remove them due to backward
compatibility.

> > 
> > And an available_perf_events that show what can be written into these files,
> > (similar to how set_ftrace_filter works). But for now, it was just easier to
> > implement them as options.
> > 
> > As for the perf event that is triggered. It currently is a dynamic array of
> > 64 bit values. Each value is broken up into 8 bits for what type of perf
> > event it is, and 56 bits for the counter. It only writes a per CPU raw
> > counter and does not do any math. That would be needed to be done by any
> > post processing.
> > 
> > Since the values are for user space to do the subtraction to figure out the
> > difference between events, for example, the function_graph tracer may have:
> > 
> >              is_vmalloc_addr() {
> >                /* cpu_cycles: 5582263593 cache_misses: 2869004572 */
> >                /* cpu_cycles: 5582267527 cache_misses: 2869006049 */
> >              }  
> 
> Just a style question: Would this mean the first line is for function entry
> and the second one is function return?

Yes.

Perhaps we could add field to the perf event to allow for annotation,
so the above could look like:

              is_vmalloc_addr() {
               /* --> cpu_cycles: 5582263593 cache_misses: 2869004572 */
               /* <-- cpu_cycles: 5582267527 cache_misses: 2869006049 */
             }  

Or something similar?



> > The next question is how to label the perf events to be in the 8 bit
> > portion. It could simply be a value that is registered, and listed in the
> > available_perf_events file.
> > 
> >   cpu_cycles:1
> >   cach_misses:2
> >   [..]  
> 
> Looks good to me. I think pre-definied events of `perf list`
> will be there and have fixed numbers.

Thanks for looking at this,

-- Steve
