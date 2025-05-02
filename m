Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709ED18AFC;
	Fri,  2 May 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204608; cv=none; b=gsrOX22o6ojmHotQnobqEmt5sRRm5j9a2VIxox+HBCC8BaJVQkIwejeAA2rTI6LZ5R1PEjpGcJxziXq7Ivi+wUn3LhvrCOwdzu+zYk8hMVSkqbJHm2ce+oAVE7SiYe1HxzvbsZwZZdOAIOw//p9Alxn/JRd3L9Ifqe+DfJDD42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204608; c=relaxed/simple;
	bh=bm4xr8hMpbrr6xCBogjVI2hmyfWO28UiholBVkZgOdw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=nd7N5PrIzUB1sqiG4JSMR+2s5JyFqT1iCKwh8Ul3IYdloe1+QtteyI7BWK0jPIG1xsTfaHzjoFEKWitSDkB3isYPnUTqft9zIZChfpcMMHoeBG0dDbnwTSu1ZAWCNntCqPy/aXAGobybM/nYkTgD2II6cLuaBh0sP5HzKf0NARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F306C4CEE4;
	Fri,  2 May 2025 16:50:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAtaR-000000002zE-2CCu;
	Fri, 02 May 2025 12:50:07 -0400
Message-ID: <20250502164746.178864972@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 12:47:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 00/17] unwind_user: perf: x86: Deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


[ Shorten the Cc list to just those that maintain this ]

This series does not make any user space visible changes.
It only adds the necessary infrastructure of the deferred unwinder
and makes a few helpful cleanups to perf.

 Based off of tip/master: 252d33c92dbc23bcc1e662a889787c09a02eeccc

Peter,

Would you be willing to take this series? I'd like to get this part
in the kernel in the next merge window and then we can focus on getting perf
and ftrace to use it in the next merge window.

Perf exposes a lot of the interface to user space as the perf tool needs
to handle the merging of the stacks, I figured it would be better to just
get the kernel side mostly done and then work out the kinks of the code
between user and kernel.

Are you OK with this?

This series combines the non user interface of:

 [v7] perf: Deferred unwinding of user space stack traces
 https://lore.kernel.org/linux-trace-kernel/20250430195746.827125963@goodmis.org/

which had no changes, with:

 [v6] perf: Deferred unwinding of user space stack traces for per CPU events
 https://lore.kernel.org/linux-trace-kernel/20250501013202.997535180@goodmis.org/

With the following changes:

- Have unwind_deferred_request() return positive if already queued

- Check (current->flags & PF_KTHREAD | PF_EXITING) in
  unwind_deferred_request(), as the task_work will fail to be added in the
  exit code.

Hence, this is called v7.

Josh Poimboeuf (13):
      unwind_user: Add user space unwinding API
      unwind_user: Add frame pointer support
      unwind_user/x86: Enable frame pointer unwinding on x86
      perf/x86: Rename and move get_segment_base() and make it global
      unwind_user: Add compat mode frame pointer support
      unwind_user/x86: Enable compat mode frame pointer unwinding on x86
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/deferred: Make unwind deferral requests NMI-safe
      perf: Remove get_perf_callchain() init_nr argument
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Simplify get_perf_callchain() user logic
      perf: Skip user unwind if the task is a kernel thread.

Steven Rostedt (4):
      unwind_user/deferred: Add unwind_deferred_trace()
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Use SRCU unwind_deferred_task_work()
      perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL

----
 MAINTAINERS                              |   8 +
 arch/Kconfig                             |  11 +
 arch/x86/Kconfig                         |   2 +
 arch/x86/events/core.c                   |  44 +---
 arch/x86/include/asm/ptrace.h            |   2 +
 arch/x86/include/asm/unwind_user.h       |  61 ++++++
 arch/x86/include/asm/unwind_user_types.h |  17 ++
 arch/x86/kernel/ptrace.c                 |  38 ++++
 include/asm-generic/Kbuild               |   2 +
 include/asm-generic/unwind_user.h        |  24 +++
 include/asm-generic/unwind_user_types.h  |   9 +
 include/linux/entry-common.h             |   2 +
 include/linux/perf_event.h               |   2 +-
 include/linux/sched.h                    |   6 +
 include/linux/unwind_deferred.h          |  50 +++++
 include/linux/unwind_deferred_types.h    |  18 ++
 include/linux/unwind_user.h              |  15 ++
 include/linux/unwind_user_types.h        |  35 ++++
 kernel/Makefile                          |   1 +
 kernel/bpf/stackmap.c                    |   4 +-
 kernel/events/callchain.c                |  38 ++--
 kernel/events/core.c                     |   7 +-
 kernel/fork.c                            |   4 +
 kernel/unwind/Makefile                   |   1 +
 kernel/unwind/deferred.c                 | 349 +++++++++++++++++++++++++++++++
 kernel/unwind/user.c                     | 130 ++++++++++++
 26 files changed, 815 insertions(+), 65 deletions(-)
 create mode 100644 arch/x86/include/asm/unwind_user.h
 create mode 100644 arch/x86/include/asm/unwind_user_types.h
 create mode 100644 include/asm-generic/unwind_user.h
 create mode 100644 include/asm-generic/unwind_user_types.h
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/deferred.c
 create mode 100644 kernel/unwind/user.c
