Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D85661;
	Wed,  9 Jul 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083799; cv=none; b=sou/NP52ecQFYWuMCgyrE/VWfwjZB1s7AWF27RLYJpiqLYX/lf8e4OD7lPsiCkeUTpHGWTeUZHjKyGccTCyTLygt9yKChHWZb2AGUYl6obrWIMrZwYcTzmw/SsE9R8q24i/SLVgsNijL1W0kMFewha1x0eoSB6yjP29YwiORrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083799; c=relaxed/simple;
	bh=xtC6Vj0PhdWagPoVsoQwpvIvuzlL1FG9tQfHTn2Wg9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFIsHyx9uCpNHFuzYC9M3O22HLL5rdSn+IkVmiOzlHa9ilD360/eP2SwHYPAg43rYpvqUQDUYr7qGmmviuIBfjVfkz2EzKrVvEHiydyAt7+LjHuiAEcfYK4/030a3x/Gz/IMfcirfRugeL4Inog0fpLRgOcOeSGgLwvx0DQ2nfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4xHmykkT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8G9yumkm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4xHmykkT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8G9yumkm"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752083795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jT9AL+DrnQN5u3RzB2epCEvwPbVCl/BfflW+AMBsQwM=;
	b=4xHmykkT8twUhbuXP82FIsGtLPD3+dPB0E3xph3QwLg6CXUDC8EDfq8mmI5ELkKZmcSune
	Mndf+R3lIIhHsUEyxfibBPj9zNjGHMQdVuPGxZckePbi6tlDpItWbfT1OxUbdYbLc14P8S
	AWo3BOPvhJeHbQzWBkr6n22zYxyxR9gAh3BCpbDQVd/Ziki4IMD9l3ekKwQI32QO3xjS4S
	xd/2CfiEDaj5PLLHbVRUIglQU2KrUvpB8KBRoEhpkixgJBfyZf+8smVL00EtizIpEj4d4F
	n52Nk2c8QvNS2Y3q1FPeHGZ41RA0RnlUyLhMgvoSh2yMcHKS23ASL7WsUvv6Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752083795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jT9AL+DrnQN5u3RzB2epCEvwPbVCl/BfflW+AMBsQwM=;
	b=8G9yumkm18DMXSGx9J3pd7nnIJrDcpuu5ugh9zVDf5ODmJKJAIflQF1t51D3sRIyhTNUTR
	S5j5MUWepm0+vGBQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v12 00/12] RV: Linear temporal logic monitors for RT application
Date: Wed,  9 Jul 2025 19:56:17 +0200
Message-Id: <cover.1752082806.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Real-time applications may have design flaws causing them to have
unexpected latency. For example, the applications may raise page faults, or
may be blocked trying to take a mutex without priority inheritance.

However, while attempting to implement DA monitors for these real-time
rules, deterministic automaton is found to be inappropriate as the
specification language. The automaton is complicated, hard to understand,
and error-prone.

For these cases, linear temporal logic is found to be more suitable. The
LTL is more concise and intuitive.

This series adds support for LTL RV monitor, and use it to implement two
monitors for reporting problems with real-time tasks.

v11->v12 https://lore.kernel.org/linux-trace-kernel/cover.1751634289.git.na=
mcao@linutronix.de
  - drop the applied patches
  - fixup build failure when CONFIG_PRINTK=3Dn

v10->v11 https://lore.kernel.org/linux-trace-kernel/cover.1749547399.git.na=
mcao@linutronix.de/
  - Split the patch adding LTL support into three smaller patches
  - Keep comments and document within 80 columns
  - Add a '&' to memset's argument to make it look more natural
  Note: all changed patches are explicitly marked so below the --- line

v9->v10 https://lore.kernel.org/lkml/cover.1747649899.git.namcao@linutronix=
.de
  - rebase onto v6.16-rc1 (only the vpanic patch is changed)
  - riscv: move page fault tracepoints back to be after kprobe pagefault
    handling
  - drop x86 tracepoint patches, they have already been applied
  - drop arm64 tracepoint patch. It requires further discussion and will be
    sent separately.
  - pagefault monitor: set dependency on x86 and riscv, only these archs
    have the required tracepoints right now.

v8->v9 https://lore.kernel.org/lkml/cover.1747046848.git.namcao@linutronix.=
de/
  - Move page faults tracepoints to be before kprobe pagefault handling
  - Add guidance into Kconfig entries whether they should be enabled
  - Replace TRACE_EVENT with DECLARE_EVENT_CLASS for the tracepoint classes=
, so
    that the class names are not wrongly exposed to userspace

v7->v8 https://lore.kernel.org/lkml/cover.1746776116.git.namcao@linutronix.=
de/
  - Fix some pylint warnings
  - Fix some bugs with some currently-unused operators in the ltl2ba.py
    script
  - sleep monitor: Allow all FUTEX_WAIT_* as valid sleep reason

v6->v7 https://lore.kernel.org/lkml/cover.1745999587.git.namcao@linutronix.=
de/
  - Add missing parameter description for vpanic()
  - Remove the now-redundant CFLAGS_fault.o for x86
  - Change #if to #ifdef to resolve a build warning
  - rtapp/sleep monitor:
    + Handle the case where an RT task "aborts" the sleep by setting state
      to TASK_RUNNING. This case previously caused a false positive. Fix it
      by adding "ABORT_SLEEP" as an RT-safe wake.
    + Also allow CLOCK_TAI for real-time tasks.

v5->v6 https://lore.kernel.org/lkml/cover.1745926331.git.namcao@linutronix.=
de
  - sleep monitor: Drop the block_on_rt_mutex tracepoints. The contention
    tracepoints are sufficient.

v4->v5 https://lore.kernel.org/lkml/cover.1745390829.git.namcao@linutronix.=
de
  - sleep monitor: Fix a false positive due to a race with waking and
    scheduling.
  - sleep monitor: Add block_on_rt_mutex tracepoints and use them for
    BLOCK_ON_RT_MUTEX, instead of trace_sched_pi_setprio
  - sleep monitor: tighten the rule on nanosleep: only clock_nanosleep()
    with TIMER_ABSTIME and CLOCK_MONOTONIC is allowed
  - add comments explaining why it is correct to treat PI-boosted tasks as
    real-time tasks.

    It should be noted that due to the changes in v5, 'perf' does not work
    as well as before, because sometimes the errors happen out of the
    real-time tasks' contexts. Fixing this is left for future work.

    stress-ng is also far noisier in v5, because the rule on nanosleep is
    tightened.

v3->v4 https://lore.kernel.org/lkml/cover.1744785335.git.namcao@linutronix.=
de
  - support deadline tasks
  - rtapp_sleep: use sched_pi_setprio tracepoint instead of contention
    tracepoints for BLOCK_ON_RT_MUTEX, so that proxy lock is covered.
  - fix the scripts generating an "slightly" incorrect verification automat=
on
  - makes rtapp monitor depends on RV_PER_TASK_MONITORS >=3D 2
  - make the event tracepoint output a bit more readable
  - some documentation's format fixes

v2->v3 https://lore.kernel.org/lkml/cover.1744355018.git.namcao@linutronix.=
de/
  - fix a problem with sleep monitor's specification (around
    KTHREAD_SHOULD_STOP)
  - merge the patches that move the dot2k/rvgen scripts around
  - pull panic/printk changes into separate patches
  - fixup some build errors
  - fixup monitor's init function return code
  - fix some flake8 warnings with the scripts
  - add some references to LTL documentation
  - fixup some mistakes with rtapp documentation
  - fixup capitalization mistake with monitor_synthesis.rst
  - remove the now-redundant macro RV_PER_TASK_MONITORS

v1->v2 https://lore.kernel.org/lkml/cover.1741708239.git.namcao@linutronix.=
de/
  - Integrate the LTL scripts into the existing dot2k tool, taking
    advantage of the existing monitor generation scripts.
  - Switch the struct ltl_monitor to use bitmap instead of an array, to
    optimize memory usage.
  - Correct the generated code to be non-deterministic state machine,
    instead of deterministic state machine
  - Put common code for all LTL monitors into a single file
    (include/rv/ltl_monitor.h), reducing code duplication
  - Change the LTL monitors to make user of container. Add a bug fix to
    container while at it.
  - Make the number of per-task monitor configurable

Cc: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org

Nam Cao (12):
  rv: Add #undef TRACE_INCLUDE_FILE
  printk: Make vprintk_deferred() public
  panic: Add vpanic()
  rv: Let the reactors take care of buffers
  rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
  rv: Add support for LTL monitors
  rv: Add rtapp container monitor
  riscv: mm: Add page fault trace points
  rv: Add rtapp_pagefault monitor
  rv: Add rtapp_sleep monitor
  rv: Add documentation for rtapp monitor
  rv: Allow to configure the number of per-task monitor

 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_rtapp.rst      | 133 +++++++++
 arch/riscv/mm/fault.c                         |   8 +
 include/linux/panic.h                         |   3 +
 include/linux/printk.h                        |   5 +
 include/linux/rv.h                            |  75 ++++-
 include/linux/sched.h                         |   8 +-
 include/rv/da_monitor.h                       |  45 +--
 include/rv/ltl_monitor.h                      | 184 +++++++++++++
 kernel/fork.c                                 |   5 +-
 kernel/panic.c                                |  16 +-
 kernel/printk/internal.h                      |   1 -
 kernel/trace/rv/Kconfig                       |  27 +-
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/pagefault/Kconfig    |  20 ++
 .../trace/rv/monitors/pagefault/pagefault.c   |  88 ++++++
 .../trace/rv/monitors/pagefault/pagefault.h   |  64 +++++
 .../rv/monitors/pagefault/pagefault_trace.h   |  14 +
 kernel/trace/rv/monitors/rtapp/Kconfig        |  11 +
 kernel/trace/rv/monitors/rtapp/rtapp.c        |  33 +++
 kernel/trace/rv/monitors/rtapp/rtapp.h        |   3 +
 kernel/trace/rv/monitors/sleep/Kconfig        |  22 ++
 kernel/trace/rv/monitors/sleep/sleep.c        | 237 ++++++++++++++++
 kernel/trace/rv/monitors/sleep/sleep.h        | 257 ++++++++++++++++++
 kernel/trace/rv/monitors/sleep/sleep_trace.h  |  14 +
 kernel/trace/rv/reactor_panic.c               |   8 +-
 kernel/trace/rv/reactor_printk.c              |   8 +-
 kernel/trace/rv/rv.c                          |  10 +-
 kernel/trace/rv/rv_reactors.c                 |   2 +-
 kernel/trace/rv/rv_trace.h                    |  52 +++-
 tools/verification/models/rtapp/pagefault.ltl |   1 +
 tools/verification/models/rtapp/sleep.ltl     |  22 ++
 32 files changed, 1305 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst
 create mode 100644 include/rv/ltl_monitor.h
 create mode 100644 kernel/trace/rv/monitors/pagefault/Kconfig
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.c
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.h
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_trace.h
 create mode 100644 kernel/trace/rv/monitors/rtapp/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.c
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.h
 create mode 100644 kernel/trace/rv/monitors/sleep/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.c
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.h
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_trace.h
 create mode 100644 tools/verification/models/rtapp/pagefault.ltl
 create mode 100644 tools/verification/models/rtapp/sleep.ltl

--=20
2.39.5

