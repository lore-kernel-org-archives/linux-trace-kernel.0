Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1932824A;
	Tue, 18 Nov 2025 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763435307; cv=none; b=KrlXTVUtGxJPP+vjkiCe+YHznkIcPEuBSy708hi68IpEr+FnzywxrvqCO2CIbA412Lv58BR9f7VhGZyZuBxpBu1G0McIq5QcqGVtVujDMRSTbdcJDK8Zv3VqkwO6RceZdWpVykQ0nKLiEdGvExDchITjeBNTvPXqvJhWtaPBYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763435307; c=relaxed/simple;
	bh=Xind89b6j0RPaaXNpfgRKjEU07FHRaCHtqEas4Uojr0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r5cbuposlgVwm1b9UFT4ToS0erezCq//CIhxJ5V5+2iBFYxPjC8TICQew+QfXmAdlUToKGIXRpAM+xh7YeiYF2P/uyGt774Hk+YpDAcbWWkH4MZgHK7SER6D+NtilISsnDhBwXBloIVmCV2d6nC0jLsA+KngNiIwnN9e9Tws9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpX+Jfwo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpX+Jfwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDFBC4CEF5;
	Tue, 18 Nov 2025 03:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763435306;
	bh=Xind89b6j0RPaaXNpfgRKjEU07FHRaCHtqEas4Uojr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpX+Jfwod17GoB//NGRSeccek0jUrx+izKskDzcFYU9lvMs2NOK3WTxS4oOiCdPHz
	 Oq7GPYivf0HSfu44yO/YpJzsw0gSSaD4bj2JpqYaNpzzdfN5PZlXNtiJWSKwgtvxoc
	 CBFlSugXT65HBTVnDlcKgU/gqoYqm+YJ4JOvbaodoo+WZcWF8Kwp/AbQmve+cOGkny
	 CLxtmKS7f2HObVSbvHH8FBkbhSwJrRVAmUyMvpzSTJfBMPBd+PgW7unYjnnQSyNjcL
	 wRWYGkUrdil7jQogKvaeups0dAnno+AgTFeWOHHv0veAlNqomoF6oVE1TVgx+aWjaI
	 IVD9cUP4vTPkQ==
Date: Tue, 18 Nov 2025 12:08:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Namhyung
 Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 0/3] tracing: Add perf events to trace buffer
Message-Id: <20251118120821.0c47ef684b53d5d9a2d6dc83@kernel.org>
In-Reply-To: <20251118002950.680329246@kernel.org>
References: <20251118002950.680329246@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

Thanks for the great idea!

On Mon, 17 Nov 2025 19:29:50 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> 
> This series adds a perf event to the ftrace ring buffer.
> It is currently a proof of concept as I'm not happy with the interface
> and I also think the recorded perf event format may be changed too.
> 
> This proof-of-concept interface (which I have no plans on using), currently
> just adds 6 new trace options.
> 
>   event_cache_misses
>   event_cpu_cycles
>   func-cache-misses
>   func-cpu-cycles
>   funcgraph-cache-misses
>   funcgraph-cpu-cycles
> 
> The first two trigger a perf event after every event, the second two trigger
> a perf event after every function and the last two trigger a perf event
> right after the start of a function and again at the end of the function.
> 
> As this will eventual work with many more perf events than just cache-misses
> and cpu-cycles , using options is not appropriate. Especially since the
> options are limited to a 64 bit bitmask, and that can easily go much higher.
> I'm thinking about having a file instead that will act as a way to enable
> perf events for events, function and function graph tracing.
> 
>   set_event_perf, set_ftrace_perf, set_fgraph_perf

What about adding a global `trigger` action file so that user can
add these "perf" actions to write into it. It is something like
stacktrace for events. (Maybe we can move stacktrace/user-stacktrace
into it too)

For pre-defined/software counters:
# echo "perf:cpu_cycles" >> /sys/kernel/tracing/trigger

For some hardware event sources (see /sys/bus/event_source/devices/):
# echo "perf:cstate_core.c3-residency" >> /sys/kernel/tracing/trigger

echo "perf:my_counter=pmu/config=M,config1=N" >> /sys/kernel/tracing/trigger

If we need to set those counters for tracers and events separately,
we can add `events/trigger` and `tracer-trigger` files.

echo "perf:cpu_cycles" >> /sys/kernel/tracing/events/trigger

To disable counters, we can use '!' as same as event triggers.

echo !perf:cpu_cycles > trigger

To add more than 2 counters, connect it with ':'.
(or, we will allow to append new perf counters)
This allows user to set perf counter options for each events.

Maybe we also should move 'stacktrace'/'userstacktrace' option
flags to it too eventually.



> 
> And an available_perf_events that show what can be written into these files,
> (similar to how set_ftrace_filter works). But for now, it was just easier to
> implement them as options.
> 
> As for the perf event that is triggered. It currently is a dynamic array of
> 64 bit values. Each value is broken up into 8 bits for what type of perf
> event it is, and 56 bits for the counter. It only writes a per CPU raw
> counter and does not do any math. That would be needed to be done by any
> post processing.
> 
> Since the values are for user space to do the subtraction to figure out the
> difference between events, for example, the function_graph tracer may have:
> 
>              is_vmalloc_addr() {
>                /* cpu_cycles: 5582263593 cache_misses: 2869004572 */
>                /* cpu_cycles: 5582267527 cache_misses: 2869006049 */
>              }

Just a style question: Would this mean the first line is for function entry
and the second one is function return?

> 
> User space would subtract 2869006049 - 2869004572 = 1477
> 
> Then 56 bits should be plenty.
> 
>   2^55 / 1,000,000,000 / 60 / 60 / 24 = 416
>   416 / 4 = 104
> 
> If you have a 4GHz machine, the cpu-cycles will overflow the 55 bits in 104
> days. This tooling is not for seeing how many cycles run over 104 days.
> User space tooling would just need to be aware that the vale is 56 bits and
> when calculating the difference between start and end do something like:
> 
>   if (start > end)
>       end |= 1ULL << 56;
> 
>   delta = end - start;
> 
> The next question is how to label the perf events to be in the 8 bit
> portion. It could simply be a value that is registered, and listed in the
> available_perf_events file.
> 
>   cpu_cycles:1
>   cach_misses:2
>   [..]

Looks good to me. I think pre-definied events of `perf list`
will be there and have fixed numbers.

Thank you,

> 
> And this would need to be recorded by any tooling reading the events
> so that it knows how to map the events with their attached ids.
> 
> But again, this is just a proof-of-concept. How this will eventually be
> implemented is yet to be determined.
> 
> But to test these patches (which are based on top of my linux-next branch,
> which should now be in linux-next):
> 
>   # cd /sys/kernel/tracing
>   # echo 1 > options/event_cpu_cycles
>   # echo 1 > options/event_cache_misses
>   # echo 1 > events/syscalls/enable
>   # cat trace
> [..]
>             bash-995     [007] .....    98.255252: sys_write -> 0x2
>             bash-995     [007] .....    98.255257: cpu_cycles: 1557241774 cache_misses: 449901166
>             bash-995     [007] .....    98.255284: sys_dup2(oldfd: 0xa, newfd: 1)
>             bash-995     [007] .....    98.255285: cpu_cycles: 1557260057 cache_misses: 449902679
>             bash-995     [007] .....    98.255305: sys_dup2 -> 0x1
>             bash-995     [007] .....    98.255305: cpu_cycles: 1557280203 cache_misses: 449906196
>             bash-995     [007] .....    98.255343: sys_fcntl(fd: 0xa, cmd: 1, arg: 0)
>             bash-995     [007] .....    98.255344: cpu_cycles: 1557322304 cache_misses: 449915522
>             bash-995     [007] .....    98.255352: sys_fcntl -> 0x1
>             bash-995     [007] .....    98.255353: cpu_cycles: 1557327809 cache_misses: 449916844
>             bash-995     [007] .....    98.255361: sys_close(fd: 0xa)
>             bash-995     [007] .....    98.255362: cpu_cycles: 1557335383 cache_misses: 449918232
>             bash-995     [007] .....    98.255369: sys_close -> 0x0
> 
> 
> 
> Comments welcomed.
> 
> 
> Steven Rostedt (3):
>       tracing: Add perf events
>       ftrace: Add perf counters to function tracing
>       fgraph: Add perf counters to function graph tracer
> 
> ----
>  include/linux/trace_recursion.h      |   5 +-
>  kernel/trace/trace.c                 | 153 ++++++++++++++++++++++++++++++++-
>  kernel/trace/trace.h                 |  38 ++++++++
>  kernel/trace/trace_entries.h         |  13 +++
>  kernel/trace/trace_event_perf.c      | 162 +++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_functions.c       | 124 +++++++++++++++++++++++++--
>  kernel/trace/trace_functions_graph.c | 117 +++++++++++++++++++++++--
>  kernel/trace/trace_output.c          |  70 +++++++++++++++
>  8 files changed, 670 insertions(+), 12 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
