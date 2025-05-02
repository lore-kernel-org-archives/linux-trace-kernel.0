Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE751F470E;
	Fri,  2 May 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219228; cv=none; b=UfOdFUXc+SMx2OORkHF54XeacxGCoDSPOcsH9fVXsTaPYfc1LeYpnjw/kQ6Z85MWBZRlB4mCHPVqgwI6YOhCIklFU4vywltzFkD6wTFlXoFihNtVL2xPodzx0SCaBrnAtZQTziNyuEu2/hMvOaGKjU0hJNmUF0TtVyzvHiCNR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219228; c=relaxed/simple;
	bh=/aeOvEZwQov9D2HCk1uBsDlStuBR66p9FgUlvpI/mF0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=uKCJL5t0dbrXbA168/rkvM0jNjWcsy4Du9EuvGFtxhOVTHrW4RAFQbRkBW/to9anXzPGEf1aQosthoZMNJ+z0TUkzEK7cTX6XAOqyvD35rY6pZ84bWINiRlalb8EzHOThEtEfsiQbUQetwF0izE722hXdsaS/l58ssljTWoC8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A62C4CEE4;
	Fri,  2 May 2025 20:53:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOF-00000000697-3vqC;
	Fri, 02 May 2025 16:53:47 -0400
Message-ID: <20250502205147.283272733@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 00/12] tracing: Remove most uses of "disabled" field
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Looking into allowing syscall events to fault and read user space, I found
that the use of the per CPU data "disabled" field was mostly obsolete.
This goes back to 2008 when the tracing subsystem was first created.
The "disabled" field was the only way to know if tracing was disabled or
not. But things have changed in the last 17 years! The ring buffer itself
can disable tracing, and for the most part, that is what determines if
tracing is enabled or not.

Now the stack tracer and latency tracers still use the disabled field to
prevent corruption while its doing its per CPU accounting.

This series removes most uses of the disabled field. It also does some
various clean ups, like convert the disabled field into a local_t type from
an atomic_t type as it only is used to synchronize with interrupts and such.

Also, while inspecting the per CPU data, I realized that there's a
"buffer_page" field that was supposed to hold the reader page to be able to
reuse it. But that is done by the ring buffer infrastructure itself and this
field is unneeded, so it is removed.

Note, with this change, the trace events shouldn't need to be called with
preemption disabled anymore. This should allow the syscall trace event to be
updated to read user memory. It still has some code that requires preemption
disabled, but it does it internally and doesn't expect the functions to be
called with preemption disabled.

Steven Rostedt (12):
      tracing/mmiotrace: Remove reference to unused per CPU data pointer
      tracing: Do not bother setting "disabled" field for ftrace_dump_one()
      ftrace: Do not bother checking per CPU "disabled" flag
      tracing: Just use this_cpu_read() to access ignore_pid
      tracing: kdb: Use tracer_tracing_on/off() instead of setting per CPU disabled
      ftrace: Do not disabled function graph based on "disabled" field
      tracing: Do not use per CPU array_buffer.data->disabled for cpumask
      ring-buffer: Add ring_buffer_record_is_on_cpu()
      tracing: branch: Use trace_tracing_is_on_cpu() instead of "disabled" field
      tracing: Convert the per CPU "disabled" counter to local from atomic
      tracing: Use atomic_inc_return() for updating "disabled" counter in irqsoff tracer
      tracing: Remove unused buffer_page field from trace_array_cpu structure

----
 include/linux/ring_buffer.h          |  1 +
 kernel/trace/ring_buffer.c           | 18 ++++++++++++++
 kernel/trace/trace.c                 | 11 +--------
 kernel/trace/trace.h                 | 18 ++++++++++++--
 kernel/trace/trace_branch.c          |  4 +--
 kernel/trace/trace_events.c          |  9 ++++---
 kernel/trace/trace_functions.c       | 24 ++++++------------
 kernel/trace/trace_functions_graph.c | 38 +++++++----------------------
 kernel/trace/trace_irqsoff.c         | 47 +++++++++++++++++++++---------------
 kernel/trace/trace_kdb.c             |  8 ++----
 kernel/trace/trace_mmiotrace.c       | 12 ++-------
 kernel/trace/trace_sched_wakeup.c    | 18 +++++++-------
 12 files changed, 98 insertions(+), 110 deletions(-)
