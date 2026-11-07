Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071590;
	b=xzhG+giNrqa8o/zsQJHWpK/1Za8J9/h55dZNJN3xEGAqyf4trS/4opmTgnDPRQ8ZvEBi
	 6xl3fmL8fhjGmA5CCodOyjWrAL9pI+R/ooB0InEIiGjLowq4gfdHOBs8A6IVKHOg1S0cU
	 enBlBkrE+uyoApY8ez+Ep9+7x6rWzkGaZryARsETYH+rg1N6jjbR6GojgWZF8UV4Jlwgo
	 /7fWQajpL6l0fDoUhMZMjccZGcV5eEMcJ9cgEvEcd0QE+iETz6T3421lnNuXetQeP+8mx
	 wuCblqcftA1/fddnQdUfDJr+XU7opkFvPubFmabp2411zAQE2h8JvHMszBF1KpqRnrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TIc6+YNxVXhGA8deHKYHd4FZyrT7f/jlj0igPXFCOsE=;
	b=E1DEOXgGPeqeSQsU2BRNgJsz6N0D+mLnthEBjcbfZ3tlesLXyfZGkkZJFkd0c6TY0gO4
	 w4Q+w/xan65AsIosrHjW6PLPiG088uq7WfUAsP3HuqFMKYyFqmleoL3onY358SwBN0cTR
	 1NzWsXVP7nQea1zGgtztSrp1A2HfKfrglveYn4kdfzBgqk/ulkBSIjIgLb3sfXGGBkisH
	 40rUYITJo1WmY4USG6VJfM6OsZyDVUin7L04REAPcpkIVF21R4IqpE8t+S5VD58WlhRwd
	 JS/ZaBlBUj6vtWbrF7EN9YNb728OaNPUOgdL1NImWDiYOkEDAWM8/AbwewfO3dyGQzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6OSU7Ir;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5266606A335
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 17:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5266606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6OSU7Ir
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-491846221ffso1432457f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 09:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071588; x=1794676388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TIc6+YNxVXhGA8deHKYHd4FZyrT7f/jlj0igPXFCOsE=;
        b=x6OSU7Ir21f6GzY3BamV86ebskkhQEG7OSMk1lTI9Nc1pNOHgHZ1lYDP5dTByyQXQq
         pnVsizsC04hWjoEHcNOwKXoZx3hYdyuDm3u8Rr1r6LSkWoClZuTasWJQtvqbksHMUTH+
         6o9rhfmCTfAQ5wkvWws3P4WzmcKJnM2fP4hwwPhHEGjbMeEPV2ZXU2KBKaZ+zIt78g5q
         pZuC4zdWGnvbUAXkIPC3tVFK+8NFV99ba3CNQW2T0ePSTIOvzRKvXo5ivVAxeBvNtuS/
         LSJCxqa0jl/W9OVD0I5dwsG1Za1gubmG7eYtCjrKPqOGmYtYLTx6Qis51cWznqkdGCi5
         wqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071588; x=1794676388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIc6+YNxVXhGA8deHKYHd4FZyrT7f/jlj0igPXFCOsE=;
        b=WFKp58ddD527v9+SxG/yOUMPJGWfbwGrzMfrSuhUT7BFDL3SuO4orPo0HUXmNfMGxk
         eO46l1ee9JIcapkcp1Pk8T/vjvTSqeSVlGXyoOvM9XGdm3OQVoAFIT+BTpb1pcRunMJ7
         C9uy/FpJLqZ7UeZQCq7Ag02/gcS3XJjEiQwON6r6fOLYZa6eqCqIOcr7sY5pRRMqLNnH
         2te2R0Uw7LY4xugnUbnUJL3TpyAtgqnnXoO5Iy7i+NtyXYosgbEl2imcFgb0FzOnmElw
         oL2ABcMukCMQYOB2ZbQpyci29afIRYgLJ36hAxPF6phcr1kk8nmLZd2kjoIkaU2OSoS+
         sK+A==
X-Forwarded-Encrypted: i=1; AL+hErHW0A76NcHv3TD56JcPxgfcm6ScoM2VK2ACQZ33vWTK/JSrl4ylw3dGh3U/yxgMNnZtOg8/LG5B0jLifO35STt/0wE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w0D42ddao7Nb+rB+zuyTtFvOFIPlHOSEQ8wXbw/umAq51D2Ra
	WgpwU2ate+RZbfkDMeb2QMeXKqTlZOat/AE+gmtjXGEH0gi80Z86Jwu8
X-Gm-Gg: AYBFou3e55zl50kzBMUzejjFXwv1NL40EOjeqDq7qdKixshkt2dL9yEtuvB6zB2fqmZ
	xWJFS7Zp2SPoLp6Z1oiluESHrkc0DZx/gKq/1sMIYzFkFELpw1vJHDq6oMKFqCdvmAY5+2CuNHH
	LzZA4MzMzC3wdcAW9cfpkD3q02dapWtlgx4KP9C2m4gp2Bdp331MEeZvCmR6qoidRdGO42NXveC
	5C4uCDJ5vi8OBzBhKpDqUz3EegRWhuMeFh+CXTsTKQnsboyBUZwvcKLBA6KTyuViqgbW0vHC2wj
	hqJ7PrRuO0mis39vGU+VW9MtYzOc6dTl6JAI9+Y1C+6lOVShJuzNscKT56jwmX23pgwgICt55xu
	3UlWYW97V7AEYDSbaIKqAMdn8unVqfNUP3hxwo10F7+06ND1RmNDP7KlkdDQkIOW4I1eIW0zWtz
	bNLvduh658vouyFQh47zug+AkMm4Y3KMzp2smjK83WnnZAe4DmJjeC5Sw5wEXmixQbtKwoWbVqj
	MXsujs5c3DeqJ4AtC26HQ+01BeZ0yU5oQ1mhLl17Wshr/uFfQ0I8Pv16WtnqhtJl5YEXBjscIAz
	u1FY37btPwZe/wmYX01W5qXenfOJDGGHVcIIdUYiuGDn/szDztXwGT5Cmf/QiOizkXda5M6w3Jr
	f3x9DrzZnNDGwp0JoH5oKQpYZyeYf5pUR0o1xT/iShFBeHVlaKswUuLSmaUmMkj6xsL1NFb5wIO
	vxdeblI5M1z2pA4pTya0EZ5O7driqqDcQ=
X-Received: by 2002:a05:6000:490d:b0:48f:fcac:a5e2 with SMTP id ffacd0b85a97d-49277404453mr10990954f8f.38.1794071587759;
        Sat, 07 Nov 2026 09:13:07 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:06 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/9] rv: Verify generic IRQ context transitions
Date: Sat,  7 Nov 2026 18:12:43 +0100
Message-Id: <20261107171252.25090-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQ action tracepoints describe handlers, but not the lifetime of the
enclosing IRQ context. One context may run several actions, and an action
may be dispatched outside hardirq context. PREEMPT_RT may also enter
serving-softirq state without invoking an action. This leaves no generic
event stream from which an RV monitor can check IRQ-context transitions.

This RFC adds tracepoints at the generic hardirq and serving-softirq
boundaries. The irq:irqstate RV monitor checks their order and agreement
with live kernel state. irq:irqexit follows the owner of a
preempt_schedule_irq() invocation across task switches and CPU migration.

The hardirq tracepoints cover paths through irq_enter() or
irq_enter_rcu() and their matching exits. They do not cover direct
__irq_enter() and __irq_exit() users, raw paths, or architecture-specific
entry and return intervals. irqexit covers preempt_schedule_irq(), not
the complete interrupt-return path.

Boundary callbacks can raise softirq work after the pending-work check.
The series wakes ksoftirqd or ktimerd for remaining work. KUnit covers
nesting, monitor synchronization, PREEMPT_RT worker intervals, provenance
and late-work handoff.

Gabriele answered two of the v1 questions [1]:

  - The boundaries are now bare DECLARE_TRACE() tracepoints like the
    existing RV hooks in include/trace/events/sched.h, so they add no
    tracefs ABI.
  - irqstate and irqexit stay separate automata because one is per-CPU
    and the other per-task. A hardirq or non-RT softirq belongs to the
    CPU it interrupts. A preempt_schedule_irq() invocation belongs to
    the interrupted task, several tasks can be inside one at the same
    time, and it can migrate before it returns. Each RV automaton has a
    single monitor type. Both now sit under an irq container, so they
    are enabled together by default, and the irqentry/irqexit naming
    clash is gone.

Questions still open from v1:

  1. Are dedicated scheduler tracepoints the right way to follow
     preempt_schedule_irq() across task switches and migration?
  2. Is the KUnit-only hook for an empty ksoftirqd invocation
     acceptable? Outside a KUnit run, its worker checks take a disabled
     static-key path.

Patches 1-5 add the tracepoints, monitors and documentation. Patches 6-9
add KUnit coverage.

The series is based on v7.4-rc1, which contains the v1 prerequisite and
Wen Yang's reactor lockdep fix:

  commit feb5c9a2447a ("softirq: Preserve interrupt context on return from interrupt")
  commit 39ccedfd9e55 ("rv: Use LD_WAIT_SPIN as the reactor lockdep wait type")

The series is independent of the early-hardirq series [2], which
installs hardirq state before entry tracing. Both change
kernel/softirq.c, so applying one on top of the other needs a small
conflict resolution in __irq_exit_rcu().

Changes since v1:

  - Use bare DECLARE_TRACE() tracepoints instead of trace events
    (Gabriele)
  - Rename the irqentry container to irq (Gabriele)
  - Add text schematics of both models to the documentation (Gabriele)
  - Document why irqstate and irqexit are separate automata
  - Rebase onto v7.4-rc1

Testing on v7.4-rc1 with Clang 23.1.5, GCC 14.2 (x86) and GCC 16.2
(cross), and QEMU 10.0 TCG, with lockdep and the locking selftests:

  - Each patch builds with W=1 on x86_64 without new warnings.
    RV_MONITORS_KUNIT_TEST=m builds on x86_64 and arm64. kernel-doc
    reports no warnings for the changed headers.
  - The rv_mon KUnit suite and the reactor suites passed without
    failures on:

      x86_64   PREEMPT SMP4 and UP, PREEMPT with nohz_full=1-3 and
               threadirqs, PREEMPT_RT SMP4, PREEMPT_RT SMP8 with
               nohz_full=1-3
      arm64    PREEMPT, PREEMPT with nohz_full=1-3 and threadirqs,
               PREEMPT_RT, PREEMPT_RT SMP8 with nohz_full=1-3
      riscv64  PREEMPT
      ARMv7    UP

    Each configuration ran 13 to 21 of the 29 rv_mon cases. The others
    are skipped because they need a different configuration.
  - RV=n kernels boot on x86_64 and arm64.
  - On top of the early-hardirq series, the same suites passed on
    x86_64 (PREEMPT, PREEMPT_RT), arm64 (PREEMPT, PREEMPT_RT) and
    riscv64.

An LLM assisted with the patches and the testing.

v1: https://lore.kernel.org/all/20261022050712.75035-1-kmehltretter@gmail.com/

[1] https://lore.kernel.org/all/FACA54EC-F846-4051-9ADD-DB46E7665FAD@redhat.com/
[2] https://lore.kernel.org/all/20261028033127.82193-1-kmehltretter@gmail.com/

Karl Mehltretter (9):
  tracing/irq: Add generic IRQ context boundary tracepoints
  tracing/sched: Add IRQ preemption lifecycle tracepoints
  rv: Add a monitor for generic IRQ context transitions
  rv: Add a monitor for IRQ-exit scheduling ownership
  docs/rv: Document the IRQ monitors
  rv: Add KUnit coverage for IRQ context transitions
  rv: Add KUnit coverage for IRQ-exit scheduling
  rv: Test empty PREEMPT_RT softirq worker intervals
  rv: Test IRQ-exit softirq provenance and handoff

 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_irq.rst        |  475 ++++
 include/linux/interrupt.h                     |    8 +
 include/rv/kunit.h                            |   34 +-
 include/trace/events/irq.h                    |   56 +
 include/trace/events/sched.h                  |   26 +
 kernel/sched/core.c                           |    6 +
 kernel/softirq.c                              |  324 ++-
 kernel/trace/rv/Kconfig                       |   11 +-
 kernel/trace/rv/Makefile                      |    3 +
 kernel/trace/rv/monitors/irq/Kconfig          |   13 +
 kernel/trace/rv/monitors/irq/irq.c            |   35 +
 kernel/trace/rv/monitors/irq/irq.h            |    3 +
 kernel/trace/rv/monitors/irqexit/Kconfig      |   14 +
 kernel/trace/rv/monitors/irqexit/irqexit.c    |  172 ++
 kernel/trace/rv/monitors/irqexit/irqexit.h    |   85 +
 .../trace/rv/monitors/irqexit/irqexit_kunit.c |  540 ++++
 .../trace/rv/monitors/irqexit/irqexit_kunit.h |   21 +
 .../trace/rv/monitors/irqexit/irqexit_trace.h |   19 +
 kernel/trace/rv/monitors/irqstate/Kconfig     |   14 +
 kernel/trace/rv/monitors/irqstate/irqstate.c  |  289 ++
 kernel/trace/rv/monitors/irqstate/irqstate.h  |  139 +
 .../rv/monitors/irqstate/irqstate_kunit.c     | 2339 +++++++++++++++++
 .../rv/monitors/irqstate/irqstate_kunit.h     |   25 +
 .../rv/monitors/irqstate/irqstate_trace.h     |   15 +
 kernel/trace/rv/rv_monitors_test.c            |   30 +
 kernel/trace/rv/rv_trace.h                    |    2 +
 tools/verification/models/irq/irqexit.dot     |   21 +
 tools/verification/models/irq/irqstate.dot    |   32 +
 29 files changed, 4737 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_irq.rst
 create mode 100644 kernel/trace/rv/monitors/irq/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irq/irq.c
 create mode 100644 kernel/trace/rv/monitors/irq/irq.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.c
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_trace.h
 create mode 100644 tools/verification/models/irq/irqexit.dot
 create mode 100644 tools/verification/models/irq/irqstate.dot


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.39.5 (Apple Git-154)

