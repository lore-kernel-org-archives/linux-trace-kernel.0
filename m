Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169EE1FBCA7;
	Tue, 18 Nov 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426108; cv=none; b=UOM5soOKrSK0QwInGeIBEtqLFBNrqZZSsbxVtfqecJwkdZg65l7vutsKBNL8a4qjeI+OFx9hGlptiqJnnceBxzFlmMZmTitXWhumMA1LLwzMQWrHvD5JeRUcBeuJ3URFIkCnDpUvznVCpoEAf4upVfXk5/ptgSebw6x49PpmGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426108; c=relaxed/simple;
	bh=eTJwxCzJzW3WfIGlWU8WtCDcH7+6niDwAKzH4ggLapE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JwhAhpM2XQubukqG0f8Ri7Dn3UwJdDu1owUNxIQKRlMA8HF7UHHT9x7aOEunPRypL2ixRWhdu79/8OzVVqBXxhT86fBeu+LiRJg3HtNjVDtLPuXeW0MHQt5sGqkCsVKpze685fdTGbw0Ou+b+pwfGn3BF8+yTFfFC+2y95ecfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9l5QmVw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9l5QmVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4514DC2BCB7;
	Tue, 18 Nov 2025 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426106;
	bh=eTJwxCzJzW3WfIGlWU8WtCDcH7+6niDwAKzH4ggLapE=;
	h=Date:From:To:Cc:Subject:From;
	b=D9l5QmVwK5jBvkC0Oeyv1MJqxcVv2VJXaQ6BmAc6EQ3T+ywpoXQsdVQEE0o5gMK56
	 QSPqrLz4lS0l6w4at6ZCX7JMJK1wBLN9rVvUfoZDvHlxz/ScWUCfH4ZuITjqrLJvw8
	 cszXl0xlGn3EE/A7tZ1HG6hp2dxkFzlaqhQQAjngt889gAZeNm6NdMBT2TPdINrZY/
	 aFH97lK8XNZfY4ZkM8Pv4lvwSX7eIMUNGx5EK4W0g2WoL/nh6v3xJc55PRnML23R0I
	 zAmfvbFi06iOGhzK1g9dlUSn/wnXR6VxloYGt7exgTEQsQhqgj9eDQa0RsxqLU3Ox4
	 xDL1tJfP+XxFA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vL9gx-00000002zJU-2are;
	Mon, 17 Nov 2025 19:35:31 -0500
Message-ID: <20251118002950.680329246@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 17 Nov 2025 19:29:50 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [POC][RFC][PATCH 0/3] tracing: Add perf events to trace buffer
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


This series adds a perf event to the ftrace ring buffer.
It is currently a proof of concept as I'm not happy with the interface
and I also think the recorded perf event format may be changed too.

This proof-of-concept interface (which I have no plans on using), currently
just adds 6 new trace options.

  event_cache_misses
  event_cpu_cycles
  func-cache-misses
  func-cpu-cycles
  funcgraph-cache-misses
  funcgraph-cpu-cycles

The first two trigger a perf event after every event, the second two trigger
a perf event after every function and the last two trigger a perf event
right after the start of a function and again at the end of the function.

As this will eventual work with many more perf events than just cache-misses
and cpu-cycles , using options is not appropriate. Especially since the
options are limited to a 64 bit bitmask, and that can easily go much higher.
I'm thinking about having a file instead that will act as a way to enable
perf events for events, function and function graph tracing.

  set_event_perf, set_ftrace_perf, set_fgraph_perf

And an available_perf_events that show what can be written into these files,
(similar to how set_ftrace_filter works). But for now, it was just easier to
implement them as options.

As for the perf event that is triggered. It currently is a dynamic array of
64 bit values. Each value is broken up into 8 bits for what type of perf
event it is, and 56 bits for the counter. It only writes a per CPU raw
counter and does not do any math. That would be needed to be done by any
post processing.

Since the values are for user space to do the subtraction to figure out the
difference between events, for example, the function_graph tracer may have:

             is_vmalloc_addr() {
               /* cpu_cycles: 5582263593 cache_misses: 2869004572 */
               /* cpu_cycles: 5582267527 cache_misses: 2869006049 */
             }

User space would subtract 2869006049 - 2869004572 = 1477

Then 56 bits should be plenty.

  2^55 / 1,000,000,000 / 60 / 60 / 24 = 416
  416 / 4 = 104

If you have a 4GHz machine, the cpu-cycles will overflow the 55 bits in 104
days. This tooling is not for seeing how many cycles run over 104 days.
User space tooling would just need to be aware that the vale is 56 bits and
when calculating the difference between start and end do something like:

  if (start > end)
      end |= 1ULL << 56;

  delta = end - start;

The next question is how to label the perf events to be in the 8 bit
portion. It could simply be a value that is registered, and listed in the
available_perf_events file.

  cpu_cycles:1
  cach_misses:2
  [..]

And this would need to be recorded by any tooling reading the events
so that it knows how to map the events with their attached ids.

But again, this is just a proof-of-concept. How this will eventually be
implemented is yet to be determined.

But to test these patches (which are based on top of my linux-next branch,
which should now be in linux-next):

  # cd /sys/kernel/tracing
  # echo 1 > options/event_cpu_cycles
  # echo 1 > options/event_cache_misses
  # echo 1 > events/syscalls/enable
  # cat trace
[..]
            bash-995     [007] .....    98.255252: sys_write -> 0x2
            bash-995     [007] .....    98.255257: cpu_cycles: 1557241774 cache_misses: 449901166
            bash-995     [007] .....    98.255284: sys_dup2(oldfd: 0xa, newfd: 1)
            bash-995     [007] .....    98.255285: cpu_cycles: 1557260057 cache_misses: 449902679
            bash-995     [007] .....    98.255305: sys_dup2 -> 0x1
            bash-995     [007] .....    98.255305: cpu_cycles: 1557280203 cache_misses: 449906196
            bash-995     [007] .....    98.255343: sys_fcntl(fd: 0xa, cmd: 1, arg: 0)
            bash-995     [007] .....    98.255344: cpu_cycles: 1557322304 cache_misses: 449915522
            bash-995     [007] .....    98.255352: sys_fcntl -> 0x1
            bash-995     [007] .....    98.255353: cpu_cycles: 1557327809 cache_misses: 449916844
            bash-995     [007] .....    98.255361: sys_close(fd: 0xa)
            bash-995     [007] .....    98.255362: cpu_cycles: 1557335383 cache_misses: 449918232
            bash-995     [007] .....    98.255369: sys_close -> 0x0



Comments welcomed.


Steven Rostedt (3):
      tracing: Add perf events
      ftrace: Add perf counters to function tracing
      fgraph: Add perf counters to function graph tracer

----
 include/linux/trace_recursion.h      |   5 +-
 kernel/trace/trace.c                 | 153 ++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h                 |  38 ++++++++
 kernel/trace/trace_entries.h         |  13 +++
 kernel/trace/trace_event_perf.c      | 162 +++++++++++++++++++++++++++++++++++
 kernel/trace/trace_functions.c       | 124 +++++++++++++++++++++++++--
 kernel/trace/trace_functions_graph.c | 117 +++++++++++++++++++++++--
 kernel/trace/trace_output.c          |  70 +++++++++++++++
 8 files changed, 670 insertions(+), 12 deletions(-)
