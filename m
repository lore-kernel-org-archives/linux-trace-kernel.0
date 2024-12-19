Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC51B4253;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639183; cv=none; b=QhAtT3Z7or/v2+6gTZ763FsEOowiWQRT5OWKM+y48C/FMI6N/h5SCKvxkhNt4R5y/nJLOzBJd5osTszdXnfOrgG8aco5WI4Jqz7V5fkOL6tt/6oGHCYAPlDU4wEDlVL2yHosEX5xzgwWhK+VnUNo57tpfr9nFMQxyPKHvizW7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639183; c=relaxed/simple;
	bh=/czgHjoXoT2INLBuxWbn+E5/f6Gr+nQt9SpxgCjOYCM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=OTkKkGUUwJyL7oqOLYu+TNKmXc+YFyOFJKxrBaLI/XYTClqS7/WOo2T4lxW1r+rwtpqMtyn4exH51lU2dQJqS+Z/3E6BSJDGXhhsiSW8EcSXc5N5XVf0uUcZJO0qjqakL7B9xQmTr+rsPQu2r4Et5a+5XLw9c9KnKWCsTUfZhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36403C4CED4;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu0-0000000AOGH-2lDt;
	Thu, 19 Dec 2024 15:13:44 -0500
Message-ID: <20241219201158.193821672@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:11:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 00/14] tracing: Convert over to guard() and __free() infrastructure
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Move tracing over to using guard() and __free() infrastructure

In the past, there's been several bug fixes in the tracing code that
were related to error paths. An error may cause a function to exit
without freeing some memory or releasing a lock.

The new guard() and __free() clean up removes this problem by having
the locks released or memory freed whenever the function exits in
any path.

This also removes a lot of the goto spaghetti code and makes it easier
to read.

This series converts most of the tracing code over to use this infrastructure
where it makes sense.

Steven Rostedt (14):
      tracing: Switch trace.c code over to use guard()
      tracing: Return -EINVAL if a boot tracer tries to enable the mmiotracer at boot
      tracing: Have event_enable_write() just return error on error
      tracing: Simplify event_enable_func() goto out_free logic
      tracing: Simplify event_enable_func() goto_reg logic
      tracing: Switch trace_events.c code over to use guard()
      tracing: Switch trace_events_hist.c code over to use guard()
      tracing: Switch trace_events_trigger.c code over to use guard()
      tracing/string: Create and use __free(argv_free) in trace_dynevent.c
      tracing: Switch trace_events_filter.c code over to use guard()
      tracing: Switch trace_events_synth.c code over to use guard()
      tracing: Switch trace_osnoise.c code over to use guard() and __free()
      tracing: Switch trace_stack.c code over to use guard()
      tracing: Switch trace_stat.c code over to use guard()

----
 include/linux/string.h              |   3 +
 kernel/trace/trace.c                | 266 +++++++++++++-----------------------
 kernel/trace/trace_dynevent.c       |  23 +---
 kernel/trace/trace_events.c         | 151 +++++++++-----------
 kernel/trace/trace_events_filter.c  |  23 +---
 kernel/trace/trace_events_hist.c    |  32 ++---
 kernel/trace/trace_events_synth.c   |  17 +--
 kernel/trace/trace_events_trigger.c |  69 ++++------
 kernel/trace/trace_osnoise.c        |  40 ++----
 kernel/trace/trace_stack.c          |   6 +-
 kernel/trace/trace_stat.c           |  26 ++--
 11 files changed, 236 insertions(+), 420 deletions(-)
