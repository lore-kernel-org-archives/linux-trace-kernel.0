Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697426158C;
	Tue, 11 Mar 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712728; cv=none; b=Rn8QvnhkzLqPEBTnYD79g8j3qVc/gbDeUcd1wvTV3rI5KEIvSkL2J2w7ZGgYn6AeCfYPBxZCdS95tW/7KBmMTljkZWMFgtAV6+G61L+ivMRwpD4V92tI19oiOJzPnMmzeid2tQDSlnp2L1zi3EyUkgAoJee2XALZiuiJYd4VOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712728; c=relaxed/simple;
	bh=p/FI/jaJXSldv/niuiE3OSdHh8UO+zTsHFCSZMOkA6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NHUEhZjfTEF3xNCgLr4M7Lf1oAyjLW6tDUCQHPuP+dZI9ANNXxCOuVBjTh37dpAHPpal9X8BvQcYR7bMhjEKg81q++WrMIXS8Q3/vGoAviPzYvJFwKUanJ2cFIQGTV17JavR1+40YAmk5/tD18Q0b5Cz/+7aD22qNZuIFUJrPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNeVZzdh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hTvx8MaW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNeVZzdh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hTvx8MaW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N3e4tj6ROkN3p27mylRSx8gaNCKBu+sOfIY2rp6Gxgg=;
	b=pNeVZzdhA5swQnEwtsQ/5kLbJwl6JUfT+1SnfKDY3yuQmw6giX8hQk/rojJpKGKjMsRTwV
	YO+GMAeWiagTB3VcUhRwf2zr3x9zqSoBnVMtxJaQcetTddeVLLEgoXYnPwjC/ffbsJyMCJ
	Qq7nLn0l2F5NhAsh1J+X+orIsixXMO99UOtfSQJetgkOKb7o5JSYqctMkeUytVgCIX89K7
	MiCA3a5goxiRnmZKw17ZBfXMI7AOKjFntTGH8gWIHkCZPiasGPdCRHqOf1E2Hp77BOFAkv
	GFvU6jbkM8j5uQl94lO36dPywYp4P+td3t20TjjJkUsm8+dI2wENHvrE7p4WUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N3e4tj6ROkN3p27mylRSx8gaNCKBu+sOfIY2rp6Gxgg=;
	b=hTvx8MaWv3hAE+ypqmvnDk3yBpEfjB4tJMZsZ3OXdEtYT8fWx9qJbipKM+gmWRj8K34jTC
	IuI4AM5RR2UAfqCA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
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
Subject: [PATCH 00/10] RV: Linear temporal logic monitors for RT application
Date: Tue, 11 Mar 2025 18:05:01 +0100
Message-Id: <cover.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Realtime applications often have design flaws causing them to have
unexpected latency.  For example, the applications may raise page faults,
or may be blocked trying to take a mutex without priority inheritance.

This series adds runtime verification monitors to detect these flaws.

This monitors was tried on pipewire and detected some issues. One of them
has been reported to pipewire's maintainers and is being fixed:
https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2285

Patch 1 and patch 2 fix some minor issues with RV.

Patch 3 adds the infrastructure for linear temporal logic monitor.

Patch 4 adds the first monitor: rtapp_block. This monitor detects if a
realtime task is undesirable blocked.

Patch 5-8 prepare the pagefault tracepoints, so that patch 9 can add the
rtapp_pagefault monitor.  This monitor task detects if an RT task raise
page fault.

Patch 10 raises the max number of per-task monitor to 2, so that the above
monitors can be enabled simultaneously.
---
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
---
Nam Cao (10):
  rv: Add #undef TRACE_INCLUDE_FILE
  rv: Let the reactors take care of buffers
  rv: Add infrastructure for linear temporal logic monitor
  rv: Add rtapp_block monitor
  x86/tracing: Remove redundant trace_pagefault_key
  x86/tracing: Move page fault trace points to generic
  arm64: mm: Add page fault trace points
  riscv: mm: Add page fault trace points
  rv: Add rtapp_pagefault monitor
  rv: raise the number of per-task monitor to 2

 .../trace/rv/linear_temporal_logic.rst        |  73 +++
 .../trace/rv/monitor_rtapp_block.rst          |  34 ++
 .../trace/rv/monitor_rtapp_pagefault.rst      |  36 ++
 arch/arm64/mm/fault.c                         |   8 +
 arch/riscv/mm/fault.c                         |   8 +
 arch/x86/include/asm/trace/common.h           |  12 -
 arch/x86/include/asm/trace/irq_vectors.h      |   1 -
 arch/x86/kernel/tracepoint.c                  |  21 -
 arch/x86/mm/fault.c                           |   5 +-
 include/linux/printk.h                        |   1 +
 include/linux/rv.h                            |  39 +-
 include/rv/da_monitor.h                       |  61 +-
 .../trace/events}/exceptions.h                |  27 +-
 include/trace/events/lock.h                   |  12 +
 kernel/fork.c                                 |   5 +-
 kernel/locking/rtmutex.c                      |   4 +
 kernel/printk/internal.h                      |   1 -
 kernel/trace/rv/Kconfig                       |  20 +-
 kernel/trace/rv/Makefile                      |   4 +
 kernel/trace/rv/monitors/rtapp_block/ba.c     | 146 +++++
 kernel/trace/rv/monitors/rtapp_block/ba.h     | 166 ++++++
 kernel/trace/rv/monitors/rtapp_block/ltl      |   9 +
 .../rv/monitors/rtapp_block/rtapp_block.c     | 232 ++++++++
 kernel/trace/rv/monitors/rtapp_pagefault/ba.c | 139 +++++
 kernel/trace/rv/monitors/rtapp_pagefault/ba.h | 158 +++++
 kernel/trace/rv/monitors/rtapp_pagefault/ltl  |   1 +
 .../rtapp_pagefault/rtapp_pagefault.c         |  84 +++
 kernel/trace/rv/reactor_panic.c               |   7 +-
 kernel/trace/rv/reactor_printk.c              |   8 +-
 kernel/trace/rv/rv_reactors.c                 |   2 +-
 kernel/trace/rv/rv_trace.h                    |  67 ++-
 lib/Kconfig.debug                             |   3 +
 tools/verification/ltl2ba/.gitignore          |   3 +
 tools/verification/ltl2ba/generate.py         | 154 +++++
 tools/verification/ltl2ba/ltl.py              | 556 ++++++++++++++++++
 tools/verification/ltl2ba/template.c          | 131 +++++
 tools/verification/ltl2ba/template.h          | 157 +++++
 37 files changed, 2262 insertions(+), 133 deletions(-)
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
 create mode 100644 Documentation/trace/rv/monitor_rtapp_block.rst
 create mode 100644 Documentation/trace/rv/monitor_rtapp_pagefault.rst
 delete mode 100644 arch/x86/include/asm/trace/common.h
 delete mode 100644 arch/x86/kernel/tracepoint.c
 rename {arch/x86/include/asm/trace =3D> include/trace/events}/exceptions.h=
 (55%)
 create mode 100644 kernel/trace/rv/monitors/rtapp_block/ba.c
 create mode 100644 kernel/trace/rv/monitors/rtapp_block/ba.h
 create mode 100644 kernel/trace/rv/monitors/rtapp_block/ltl
 create mode 100644 kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
 create mode 100644 kernel/trace/rv/monitors/rtapp_pagefault/ba.c
 create mode 100644 kernel/trace/rv/monitors/rtapp_pagefault/ba.h
 create mode 100644 kernel/trace/rv/monitors/rtapp_pagefault/ltl
 create mode 100644 kernel/trace/rv/monitors/rtapp_pagefault/rtapp_pagefaul=
t.c
 create mode 100644 tools/verification/ltl2ba/.gitignore
 create mode 100755 tools/verification/ltl2ba/generate.py
 create mode 100644 tools/verification/ltl2ba/ltl.py
 create mode 100644 tools/verification/ltl2ba/template.c
 create mode 100644 tools/verification/ltl2ba/template.h

--=20
2.39.5

