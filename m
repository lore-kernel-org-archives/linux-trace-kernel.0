Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081C313555;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407936; cv=none; b=VMkT+fkDxW8OjjWzl7o6gJpCISr0SNNJb+XrbwbQm2qkMozYN13Yc5aYuBoxnWOSa9hcBAuxvyjcjPwK54ac05U+4ya7MKc3fgfmHAL8VPRDRlhJjfReLZ1fMHb+KEU40sEQtw21EMSLSTJ2J/n8m2ozzNBq6Mi4q+Cxezl/KK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407936; c=relaxed/simple;
	bh=t2rOpDpWLCPuCe4ZzaGjsKUutjpB2qUkHTfZkoEUwA0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=UtQOsL/TJ3vXSrk0H/wCuav4rZfTik1u6glJc4bZy49NFxckJ4/9eMoCfRZdF0gD1Th4MHot9ypihu0PeEFXKD9IozkOJG8k96SqM9K8n8lADX4RwoeJkWQ9lhkGg8fKohDZcrXPVVZrARN2pb5t6OUFpgeKpjkqQKqrgZG38go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu5ZgbZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu5ZgbZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10211C116C6;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407936;
	bh=t2rOpDpWLCPuCe4ZzaGjsKUutjpB2qUkHTfZkoEUwA0=;
	h=Date:From:To:Cc:Subject:From;
	b=hu5ZgbZSua0h7tzTj2tasoLgPoF7VAEdOTccBBFAapJDHfL96dQlZXgSuWwEt5PAe
	 r6nfXBDWe+K6/nFY8MkQA1AJj6DI44r5e8Omc+aVE7jzUFbjMxn9bGUQKQpiKIaHiF
	 Qb+DmzUJuh70BbkTcZacZW64bPnRj0Cwmx0x5v/pu4+a1Te26yEaNuDm7/TmHCj+2t
	 KjmFVpNNT3HRZJYqp9F17FOZRxv2Mr83Sp9+pyAolnx2BsjyfgKSceYMlyURlEhEKt
	 2PCGHTjZ+K47btTBvcWGuH/Yqf1ONQgur82FoadCaS4Z0c0DD882kNS3dB/ziZA59Q
	 TDj9e1X5IfnEQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzK-0000000A6lm-3vNk;
	Fri, 06 Feb 2026 14:59:34 -0500
Message-ID: <20260206193741.767171392@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:41 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 00/12] tracing: Clean up trace.c and move some code into other files
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


The trace.c file was a dumping ground for most tracing code. Start
organizing it better by moving various functions out into their own files.

The trace.c file is almost 12000 lines in size. After this change, it
goes down to just under 10,000. By organizing the code by topics and
moving them to their own files, it makes it more manageable to maintain.

- Move some generic always_inline functions into trace.h

- Move the trace_printk functions into the existing trace_printk.c file.
  This also required some clean up of the code.

- Move the pid filtering code into a new file: trace_pid.c.

- Move the snapshot and max latency handling code into a new file:
  trace_snapshot.c

This is mostly a non-functional change. But due to some clean ups, there
is still slightly some functional changes (but for the better).

This will also cause some existing code being worked on to conflict,
but I'll handle that.

I have done basic testing with this code, but it hasn't gone through
my full test suite. I'll start that now. Those tests test various config
options which may catch something I missed.


Steven Rostedt (12):
      tracing: Make tracing_disabled global for tracing system
      tracing: Make tracing_selftest_running global to the tracing subsystem
      tracing: Move __trace_buffer_{un}lock_*() functions to trace.h
      tracing: Move ftrace_trace_stack() out of trace.c and into trace.h
      tracing: Make printk_trace global for tracing system
      tracing: Make tracing_update_buffers() take NULL for global_trace
      tracing: Have trace_printk functions use flags instead of using global_trace
      tracing: Use system_state in trace_printk_init_buffers()
      tracing: Move trace_printk functions out of trace.c and into trace_printk.c
      tracing: Move pid filtering into trace_pid.c
      tracing: Move tracing_set_filter_buffering() into trace_events_hist.c
      tracing: Move snapshot code out of trace.c and into trace_snapshot.c

----
 include/linux/ftrace.h           |    2 +-
 kernel/trace/Makefile            |    2 +
 kernel/trace/trace.c             | 2264 +++-----------------------------------
 kernel/trace/trace.h             |  188 +++-
 kernel/trace/trace_events.c      |    2 +-
 kernel/trace/trace_events_hist.c |   20 +
 kernel/trace/trace_kprobe.c      |    2 +-
 kernel/trace/trace_pid.c         |  246 +++++
 kernel/trace/trace_printk.c      |  431 ++++++++
 kernel/trace/trace_snapshot.c    | 1068 ++++++++++++++++++
 10 files changed, 2120 insertions(+), 2105 deletions(-)
 create mode 100644 kernel/trace/trace_pid.c
 create mode 100644 kernel/trace/trace_snapshot.c
