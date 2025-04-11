Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B42189B84;
	Fri, 11 Apr 2025 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357089; cv=none; b=VUlSfkNSy/8Cct5pbKTZDcJjNpGbs4CLF403+MDkWV+JK6uBHPizR2ff+HBAbwnQIBUTJZmapaboyLahuXr89tJz6Ch0MRy9XwmmdrL6ZgyO1HxkeT8v4g5FeF3uR1xQnS0wrdsx0f8i3i2LHuQYlFuDRYjiim7NvDxXzCv5Cz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357089; c=relaxed/simple;
	bh=FkmNq8spcxTsT57GpKxaP9mUS5Z7/q9TIo0bAqcucgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRr1N71K44D/T3XN7UxOg/ozD/OAUtwMstMRtIh+8+Zae7goRRINI2km3bhrN9EgOV9QJU6Co7hSFlvtlRyF7yjFOaoAiATr6p61UkAY5f2/JDgChk4/cxxb8loatEmobu2mE+/8BsqIP/izqYPpJEeeY0NVg0PFSw/BEnUscEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PmDg3Rk2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8GmeuNaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PmDg3Rk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8GmeuNaV"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R4mghS5tZhqJKd9HaDFwH96FOpAhGsQjnHoB2PQgndc=;
	b=PmDg3Rk2LanAt/sc5+VI6Y1wMMxeszfLDTq/xIt6pJo2K1GrbC7EvL9yr00gzFLkxA1yfg
	z5vOMeRQ3eozU7Htc85w7PC/Bj5yH/r42NKxDuW4yX2TuzbmAQE5zK0Fuc6K9MIc/QJ2cF
	RB6Xlk7TnEV16pUkw0MRd56eEmTviC1ZuwWKOP4Bi4omCD4g/oao/8nimqwUtyBetP0HGR
	ppuU+UAjNhhqggVUKcoM6XZv3B2xlay8CJcGjVFhE2wJiXFDgAe6HybtodScMt7gdrNIfh
	beiCLbHcnbBCyBXEJXRadA1qAm34Jmc+VOO6bObFLQdnzCfXtyHADGoo/E8MZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R4mghS5tZhqJKd9HaDFwH96FOpAhGsQjnHoB2PQgndc=;
	b=8GmeuNaVOm5ubVMs1csyaTy3r2uaKXsNrQ+SkeXQsZ1QNYhXfYkr8IqwC7QawP3ZHGqg6x
	CrD0bzVBgGrRMjAA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 00/22] RV: Linear temporal logic monitors for RT application
Date: Fri, 11 Apr 2025 09:37:16 +0200
Message-Id: <cover.1744355018.git.namcao@linutronix.de>
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

Patch 1-7 do some cleanups to RV.

Patch 8-12 prepare the RV code for the integration of LTL monitors.

Patch 13 adds support for LTL monitors.

Patch 14 adds the container monitor "rtapp". This encapsulates the
sub-monitors for real-time.

Patch 15-18 prepares the pagefault tracepoints, so that patch 19 can add
the monitor which watches real-time tasks doing page faults.

Patch 20 adds the "sleep" monitor: it detects potential undesirable latency
with real-time threads.

Patch 21 adds documentation on the new monitors.

Patch 22 allows the number of per-task monitors to be configurable, so that
the two new monitors can be enabled simultaneously.

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
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org

Nam Cao (22):
  rv: Fix out-of-bound memory access in rv_is_container_monitor()
  rv: Add #undef TRACE_INCLUDE_FILE
  rv: Let the reactors take care of buffers
  verification/dot2k: Make it possible to invoke dot2k without
    installation
  verification/dot2k: Make a separate dot2k_templates/Kconfig_container
  verification/dot2k: Remove __buff_to_string()
  verification/dot2k: Replace is_container() hack with subparsers
  rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
  verification/dot2k: Prepare the frontend for LTL inclusion
  Documentation/rv: Prepare monitor synthesis document for LTL inclusion
  verification/rvgen: Prepare the templates for LTL inclusion
  verification/rvgen: Restructure the classes to prepare for LTL
    inclusion
  rv: Add support for LTL monitors
  rv: Add rtapp container monitor
  x86/tracing: Remove redundant trace_pagefault_key
  x86/tracing: Move page fault trace points to generic
  arm64: mm: Add page fault trace points
  riscv: mm: Add page fault trace points
  rv: Add rtapp_pagefault monitor
  rv: Add rtapp_sleep monitor
  rv: Add documentation for rtapp monitor
  rv: Allow to configure the number of per-task monitor

 .../trace/rv/da_monitor_synthesis.rst         | 147 -----
 Documentation/trace/rv/index.rst              |   3 +-
 .../trace/rv/linear_temporal_logic.rst        |  97 +++
 Documentation/trace/rv/monitor_rtapp.rst      | 105 ++++
 Documentation/trace/rv/monitor_synthesis.rst  | 256 ++++++++
 arch/arm64/mm/fault.c                         |   8 +
 arch/riscv/mm/fault.c                         |   8 +
 arch/x86/include/asm/trace/common.h           |  12 -
 arch/x86/include/asm/trace/irq_vectors.h      |   1 -
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/tracepoint.c                  |  21 -
 arch/x86/mm/fault.c                           |   5 +-
 include/linux/panic.h                         |   3 +
 include/linux/printk.h                        |   5 +
 include/linux/rv.h                            |  67 ++-
 include/linux/sched.h                         |   8 +-
 include/rv/da_monitor.h                       |  45 +-
 include/rv/ltl_monitor.h                      | 184 ++++++
 .../trace/events}/exceptions.h                |  27 +-
 kernel/fork.c                                 |   5 +-
 kernel/panic.c                                |  17 +-
 kernel/printk/internal.h                      |   1 -
 kernel/trace/rv/Kconfig                       |  27 +-
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/pagefault/Kconfig    |  11 +
 .../trace/rv/monitors/pagefault/pagefault.c   |  83 +++
 .../trace/rv/monitors/pagefault/pagefault.h   |  57 ++
 .../rv/monitors/pagefault/pagefault_trace.h   |  14 +
 kernel/trace/rv/monitors/rtapp/Kconfig        |   6 +
 kernel/trace/rv/monitors/rtapp/rtapp.c        |  34 ++
 kernel/trace/rv/monitors/rtapp/rtapp.h        |   3 +
 kernel/trace/rv/monitors/sleep/Kconfig        |  13 +
 kernel/trace/rv/monitors/sleep/sleep.c        | 217 +++++++
 kernel/trace/rv/monitors/sleep/sleep.h        | 293 ++++++++++
 kernel/trace/rv/monitors/sleep/sleep_trace.h  |  14 +
 kernel/trace/rv/reactor_panic.c               |   8 +-
 kernel/trace/rv/reactor_printk.c              |   8 +-
 kernel/trace/rv/rv.c                          |  17 +-
 kernel/trace/rv/rv_reactors.c                 |   2 +-
 kernel/trace/rv/rv_trace.h                    |  52 +-
 tools/verification/dot2/Makefile              |  26 -
 tools/verification/dot2/dot2k                 |  53 --
 tools/verification/models/rtapp/pagefault.ltl |   1 +
 tools/verification/models/rtapp/sleep.ltl     |  15 +
 tools/verification/rvgen/.gitignore           |   3 +
 tools/verification/rvgen/Makefile             |  30 +
 tools/verification/rvgen/__main__.py          |  67 +++
 tools/verification/{dot2 =3D> rvgen}/dot2c      |   2 +-
 .../{dot2 =3D> rvgen/rvgen}/automata.py         |   0
 tools/verification/rvgen/rvgen/container.py   |  22 +
 .../{dot2 =3D> rvgen/rvgen}/dot2c.py            |   2 +-
 tools/verification/rvgen/rvgen/dot2k.py       | 129 ++++
 .../dot2k.py =3D> rvgen/rvgen/generator.py}     | 233 ++------
 tools/verification/rvgen/rvgen/ltl2ba.py      | 552 ++++++++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py       | 242 ++++++++
 .../templates}/Kconfig                        |   0
 .../rvgen/templates/container/Kconfig         |   5 +
 .../templates/container/main.c}               |   0
 .../templates/container/main.h}               |   0
 .../templates/dot2k}/main.c                   |   0
 .../templates/dot2k}/trace.h                  |   0
 .../verification/rvgen/templates/ltl2k/main.c | 102 ++++
 .../rvgen/templates/ltl2k/trace.h             |  14 +
 63 files changed, 2857 insertions(+), 529 deletions(-)
 delete mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst
 create mode 100644 Documentation/trace/rv/monitor_synthesis.rst
 delete mode 100644 arch/x86/include/asm/trace/common.h
 delete mode 100644 arch/x86/kernel/tracepoint.c
 create mode 100644 include/rv/ltl_monitor.h
 rename {arch/x86/include/asm/trace =3D> include/trace/events}/exceptions.h=
 (55%)
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
 delete mode 100644 tools/verification/dot2/Makefile
 delete mode 100644 tools/verification/dot2/dot2k
 create mode 100644 tools/verification/models/rtapp/pagefault.ltl
 create mode 100644 tools/verification/models/rtapp/sleep.ltl
 create mode 100644 tools/verification/rvgen/.gitignore
 create mode 100644 tools/verification/rvgen/Makefile
 create mode 100644 tools/verification/rvgen/__main__.py
 rename tools/verification/{dot2 =3D> rvgen}/dot2c (97%)
 rename tools/verification/{dot2 =3D> rvgen/rvgen}/automata.py (100%)
 create mode 100644 tools/verification/rvgen/rvgen/container.py
 rename tools/verification/{dot2 =3D> rvgen/rvgen}/dot2c.py (99%)
 create mode 100644 tools/verification/rvgen/rvgen/dot2k.py
 rename tools/verification/{dot2/dot2k.py =3D> rvgen/rvgen/generator.py} (5=
6%)
 create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
 create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
 rename tools/verification/{dot2/dot2k_templates =3D> rvgen/templates}/Kcon=
fig (100%)
 create mode 100644 tools/verification/rvgen/templates/container/Kconfig
 rename tools/verification/{dot2/dot2k_templates/main_container.c =3D> rvge=
n/templates/container/main.c} (100%)
 rename tools/verification/{dot2/dot2k_templates/main_container.h =3D> rvge=
n/templates/container/main.h} (100%)
 rename tools/verification/{dot2/dot2k_templates =3D> rvgen/templates/dot2k=
}/main.c (100%)
 rename tools/verification/{dot2/dot2k_templates =3D> rvgen/templates/dot2k=
}/trace.h (100%)
 create mode 100644 tools/verification/rvgen/templates/ltl2k/main.c
 create mode 100644 tools/verification/rvgen/templates/ltl2k/trace.h

--=20
2.39.5

