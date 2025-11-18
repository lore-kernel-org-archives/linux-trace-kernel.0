Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078628488F;
	Tue, 18 Nov 2025 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450758; cv=none; b=UdQy44MMi+WM8dnycLzukkCQDfkfdZB4BjVn337C1E0G8IZ1Rp61UCajCqAVbJ6enK6iSPvfeP2XZz3DKYZT6EBu0G0B6NID9PCdpB/W5N1sOm1qi7FwIdy15x3UGGNhHcXCQS9IX+MCZNokCnvkgQCzvn34nlcpIryEui1UsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450758; c=relaxed/simple;
	bh=Y7Ru86Z46TzyG8ccE+SPjdgIlv0YGmpO3CzTnOY5HAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIrrsoMdeIqJtn758FQxaTQviBsLIkcEg/Bo0VXgvrNb+fyYssgpW0MFLXhsPyzT9tGf7BGb9rRUlXsbq4ZrQSptvJcw6elE4HBcQYIg/49XMlsed66cS3nEXjZmwzLdpwRgE1yD/xfOpBb/k/plgRGh93ZEi8A9C/W6fzkIMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6FyHkhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6FyHkhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF88BC4CEF1;
	Tue, 18 Nov 2025 07:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450758;
	bh=Y7Ru86Z46TzyG8ccE+SPjdgIlv0YGmpO3CzTnOY5HAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6FyHkhj7UqtYrPY7Iggj/tx4HRcVut/LE1zDEBDEF7u19a4ZNQ4Zrik9tq2tkgB6
	 fV1tSMggDTL8v9EC04v3SHbamzvWJaNB1B3MZumnYgjj+MUJgzDJAbGituGQpbA1Op
	 0gbIbYa0MWsPxh0JUB/TV94Ghu6q60xGPno/vk5bquKMhpZZ8h/i6Iu00XDQTIS0oM
	 rDlA2PO/ja0HF/R8fZTfZf+1xl2yK47uo4cjfNwzdQzTRWKGLnDowt6StZg27ipGtp
	 ZTMdy0wGnigOk4c4FmP7r6dEehtFv0jh5QMHS1kQaYJ1dYqJ7Jcbp1nZu7djsuQrAT
	 r9clv5Z0in4fw==
Date: Mon, 17 Nov 2025 23:25:56 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 0/3] tracing: Add perf events to trace buffer
Message-ID: <aRwfhIT4pJ0pbY2k@google.com>
References: <20251118002950.680329246@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118002950.680329246@kernel.org>

Hi Steve,

On Mon, Nov 17, 2025 at 07:29:50PM -0500, Steven Rostedt wrote:
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

Unfortunately the hardware cache event is ambiguous on which level it
refers to and architectures define it differently.  There are
encodings to clearly define the cache levels and accesses but the
support depends on the hardware capabilities.

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

If you want to keep the perf events per CPU, you may consider CPU
migrations for the func-graph case.  Otherwise userspace may not
calculate the diff from the begining correctly.

> 
> Since the values are for user space to do the subtraction to figure out the
> difference between events, for example, the function_graph tracer may have:
> 
>              is_vmalloc_addr() {
>                /* cpu_cycles: 5582263593 cache_misses: 2869004572 */
>                /* cpu_cycles: 5582267527 cache_misses: 2869006049 */
>              }
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

Just FYI, I did the similar thing (like fgraph case) in uftrace and I
grouped two related events to produce a metric.

  $ uftrace -T a@read=pmu-cycle ~/tmp/abc
  # DURATION     TID      FUNCTION
              [ 521741] | main() {
              [ 521741] |   a() {
              [ 521741] |     /* read:pmu-cycle (cycles=482 instructions=38) */
              [ 521741] |     b() {
              [ 521741] |       c() {
     0.659 us [ 521741] |         getpid();
     1.600 us [ 521741] |       } /* c */
     1.780 us [ 521741] |     } /* b */
              [ 521741] |     /* diff:pmu-cycle (cycles=+7361 instructions=+3955 IPC=0.54) */
    24.485 us [ 521741] |   } /* a */
    34.797 us [ 521741] | } /* main */

It reads cycles and instructions events (specified by 'pmu-cycle') at
entry and exit of the given function ('a') and shows the diff with the
metric IPC.

Thanks,
Namhyung

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
