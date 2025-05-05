Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA13266B4B;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480148; cv=none; b=Np0Ed1b326PZiB+tYhkMgYJHOCvQUVaCxXQONkVf4gNH2jWEkFts6yqBPU2GJ8mVz8pRal/qkj9w2dcy3gLRM/2/36e9JAGx5GPIi3bDmQK6rjSEh0wAj9iJ9p1ZGmXtGTAGPp56rpQZjaz0M73wwyO0ChOWESMeD44NF0FIGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480148; c=relaxed/simple;
	bh=mMiZ88hq2phAuiVKVFcfz5gWWEqxHWm2kRYSjaG+xRI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=L/GhGf8xHR8gj6PuNAnUOCbSmVkMsDBMZklEGK9KmcMCDGQwZ86O5/ZFTH0ZderkM7MVKUBKpF4tMpA7FH6963NhaH+g3EARjWyk/PD4f/1zEPZtYyHdG/6kp69hDR0W+oWkNjLXySvuka6iCN+3RtMdr8gtQtDPSXFmHoynVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4F1C4CEE4;
	Mon,  5 May 2025 21:22:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gk-00000000yAk-2nrh;
	Mon, 05 May 2025 17:22:34 -0400
Message-ID: <20250505212104.986494754@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 00/13] tracing: Remove most uses of "disabled" field
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

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20250502205147.283272733@goodmis.org/

- Fixed "raw_smp_process_id()" to "raw_smp_processor_id()" in branch tracer
  (kernel test robot)

- Fixed unused "int cpu;" (kernel test robot)

- Add tracer_tracing_disable/enable() functions

- Use tracer_tracing_disable() instead of tracer_tracing_on() for ftrace_dump_one()

- Use the new tracer_tracing_disable() instead of tracer_tracing_off() for kdb_ftdump
  (Doug Anderson)


Head SHA1: 70b9ea306f1c611f81d6365f0866ee421c664200


Steven Rostedt (13):
      tracing/mmiotrace: Remove reference to unused per CPU data pointer
      ftrace: Do not bother checking per CPU "disabled" flag
      tracing: Just use this_cpu_read() to access ignore_pid
      tracing: Add tracer_tracing_disable/enable() functions
      tracing: Use tracer_tracing_disable() instead of "disabled" field for ftrace_dump_one()
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
 kernel/trace/trace.c                 | 46 ++++++++++++++++++++++++++++-------
 kernel/trace/trace.h                 | 20 +++++++++++++--
 kernel/trace/trace_branch.c          |  4 +--
 kernel/trace/trace_events.c          |  9 ++++---
 kernel/trace/trace_functions.c       | 24 ++++++------------
 kernel/trace/trace_functions_graph.c | 38 +++++++----------------------
 kernel/trace/trace_irqsoff.c         | 47 +++++++++++++++++++++---------------
 kernel/trace/trace_kdb.c             |  9 ++-----
 kernel/trace/trace_mmiotrace.c       | 12 ++-------
 kernel/trace/trace_sched_wakeup.c    | 18 +++++++-------
 12 files changed, 136 insertions(+), 110 deletions(-)
