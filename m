Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645649;
	b=pu8p0E1tJTXlLgwG7GNFxouUmJKmKpZIQO6CD8ylBfCq89QdC5zfbmjFY3YXkftgakN9
	 zApCHX1yIKBdSdLS1qRHp0pp8RpYQ9QvNhHiiH0Rx63cZ4QbRXK1ZcAqDTvcF90y2P5EC
	 xp2ajiRHeHsak64W32FaGzxRGOTfptFpInvBSHiWyoKKAPiToF3HXPUyXYlcv6vi8ZdE9
	 Jmu12m2asMO02q1s0Y4H5+DzaALxFQyEYzbmdxQV33B9PQZqhMy69A0TLQe08NDxctotT
	 tGpHgugLfbwYYgT4eGLYyKDstmUPBBkduczwd3FF0QimzCLeHGiSJrHkUYUifWM+fSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KKy+ja1fSybZTSaoVcplsHwk3DZqhgSOeUQYBnw8jvg=;
	b=uVrBa6xR735szTtwLep85cgjxpWLZMEc4Tpf078T6Wvck4eL8ei+TyB+EUvigBnhKP12
	 PsQOkfD/JovNBi8hhR4zHaPDKadubBUr7Ugk+ls2wTNTIpGKImhUIUOltNFHIY2j7BUem
	 0NtYJQ3VJU9LGzh+zDw6d8yomnrMN7v5I8Y04SvijAi4Ju1XcC5OeqHb5/wgM4Y8JTphv
	 ejN159KFZ9gFn8c4tr/MLoFWKSDLU7aOM3Tv2KxzFA1NPrFV4CZFhHu+Na2EL3sUiwYVc
	 KgZPRQMVqpwjdRdRsSSiLk8Kg5B32DvUEoBggKes3dCck/1qADTSCtRWpRxn1ytu9jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VIhnsijj;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93062606A319
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93062606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VIhnsijj
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so2037085e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645647; x=1793250447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKy+ja1fSybZTSaoVcplsHwk3DZqhgSOeUQYBnw8jvg=;
        b=VIhnsijjA8kg/piHAsO7oMQkkGD0xU6PhxEaV+DmutYzasiXRiQIxH9Q1oadlQzXCA
         06dz+M9GHd31jpezm8FWReTRQxD6dhvlr2u6svZ9UPxqzPXgf8GjEYQkoVJ7MKX7iSxf
         8sqzNR8KIEGZ/DKfWpUFU8TTuL2+cF9GNfZmHxBiYQMrjQNXjOTqZJ/i96nmuiKdV0ta
         Venxdx+pffZpWTXFMado/Liwac6aFEWRr5mydqQ6eRGlmMz9qIPhj383Zin4y4kNuSPK
         KJ50vPhOT446IQeY42z9EVqUMjLyNFnTFXOYBL+eLp7Zu+IDToku4K7F2FqXMJGZvwq/
         xa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645647; x=1793250447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKy+ja1fSybZTSaoVcplsHwk3DZqhgSOeUQYBnw8jvg=;
        b=EX3Vyc8WIraPv+qEkAV7ZHC7MwhukCN6NvLClwC0i7bahkhKRGaelrbxtzS3iu5NpW
         9i0uZsTXNIhJUtt+w33oAYYpuKzVkYVrFHU6oahR4bETB2KFoAgL01X+WpsXRyF9arQh
         LfiDu5x5iCrEoOGcm5LUjG3yJSZP4G6Dns8n1uH3SDSO391XLy7+bELHBsbxTTL6BxvY
         4GjB4OQjSoD2hFh9cyB1wqlXY1iMJiPzHLyxAT1LO9vpuM4Xzx2iK8ZBy0uVH2CkQ2Qy
         tRu3Hd7mY22IQqzNzJpY5WxeG1PLEP4AUwNqfeeeUZCRVd992fECedDDDo9FV9qXrQ2L
         zPgg==
X-Forwarded-Encrypted: i=1; AKwUvBwRQJV9fF+HyTb69TkXOKtYkoxXCJm8+EsK2I5HNI0svs8oEmidi+e/9fT9SdFFfKevrBkt567CA675FZMRcQUo/e8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQHrDafNIPZEuIx5dAoTt4BAGNebRSJdKHb0rMGToYLGQwp87v
	1DxKExO/LH/eMNIq1dfdMan4h5+5PEVdAyKgxcEcqqLMttMENklU4o+S
X-Gm-Gg: AYBFou3M0LJM/gVlsuiISCUpS8dGxA9SBZiMMYYJGlptM/PZH0XhL8vmB+8+rt+cc5o
	54JGWTYAXUNqjjynmPhZPoeFIW7p/MI9FUfbkIkTGeQbik0j1Sf3CXkoz7jGNMc+WaDwogweL0n
	23qL2KyEEFsfo/02WHp3o6fyOXJTg7Ty8+LT+cs11x/wCTMXbiv8abJT2jbQPe/dww5Ph30ix+1
	EHMIWrhqR/VXB2B9hNaqp84w+od6Mc+heOEEOLbxYHiYDLxPcI+Gcjg93zU8GJ1PDfSOr+tGGGa
	2GyDe4Ss9MhRVfEZUyWbTWT27u9H0+rd6vSV4trebFnnVAlxBSjc5nRM+wcyPE4Zw+tzikP5hQk
	iT7MrFivdZOP9RcfB/glfnOeovWIpIXdQMjIsjMwjAC9Gp6/eLUgw5bMssEwaeYtVYiVjXh7itc
	i/iorohIjjOvDm30odd8B2AhPzyEKBXSTXvMfRZXhY4vLY+1YmP7UW21gZ2mM+9drndsfFo2J/t
	DWgcF/ejJCPjwZsETH+e+PueP2B/zijeXL4jP5JZRNIP2lDmre78m35Zid1/4pvq2RkShGZBMMv
	DG2lSzSjE4UzXAtrDQ5Ypd7eWD8NhVwRz3WkPDZm3cD/GtBcTSTYw+/b5K6HG1PWWeMc/4vPhg2
	wYhd9EmuL3LZ0P6rz2yPe+mZ52PPAelPuzHDiHmFrtt7v+CbPrHRaha67uE8=
X-Received: by 2002:a05:600c:4585:b0:4a1:acaa:9d4c with SMTP id 5b1f17b1804b1-4a1fdb20774mr81702295e9.25.1792645646631;
        Wed, 21 Oct 2026 22:07:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:25 -0700 (PDT)
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
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] rv: Verify generic IRQ context transitions
Date: Thu, 22 Oct 2026 07:07:03 +0200
Message-Id: <20261022050712.75035-1-kmehltretter@gmail.com>
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

This RFC adds events at the generic hardirq and serving-softirq
boundaries. The irqstate RV monitor checks their order and agreement with
live kernel state. irqexit follows the owner of a preempt_schedule_irq()
invocation across task switches and CPU migration.

The hardirq events cover paths through irq_enter() or irq_enter_rcu() and
their matching exits. They do not cover direct __irq_enter() and
__irq_exit() users, raw paths, or architecture-specific entry and return
intervals. irqexit covers preempt_schedule_irq(), not the complete
interrupt-return path.

Boundary callbacks can raise softirq work after the pending-work check.
The series wakes ksoftirqd or ktimerd for remaining work. KUnit covers
nesting, monitor synchronization, PREEMPT_RT worker intervals, provenance
and late-work handoff.

Cross-architecture RV KUnit testing also exposed an Arm-specific opid bug:

  https://lore.kernel.org/r/20261020035158.90190-1-kmehltretter@gmail.com

I would especially appreciate feedback on:

  1. Should the context boundaries be trace events or private RV
     instrumentation?
  2. Are dedicated scheduler events the right way to follow
     preempt_schedule_irq() across task switches and migration?
  3. Should irqstate and irqexit remain separate monitors?
  4. Is the KUnit-only hook for an empty ksoftirqd invocation acceptable?
     Outside a KUnit run, its worker checks take a disabled static-key
     path.

Patches 1-5 add the events, monitors, and documentation. Patches 6-9 add
KUnit coverage.

This series is based on v7.3 (c03c1a14507d) and depends on the following
accepted change, which is not included:

  softirq: Preserve interrupt context on return from interrupt
  https://lore.kernel.org/r/20261011060742.30584-1-kmehltretter@gmail.com

A pre-existing issue can make rv_test_dummy intermittently report a
false-positive invalid-wait-context warning under lockdep. Wen Yang has
posted a fix:

  https://lore.kernel.org/lkml/5586dd00789a0f904cc299cd8889744b8c6f8dc9.1789412799.git.wen.yang@linux.dev/

This series does not include that fix.

Karl Mehltretter (9):
  tracing/irq: Add generic IRQ context boundary events
  tracing/sched: Add IRQ preemption lifecycle events
  rv: Add a monitor for generic IRQ context transitions
  rv: Add a monitor for IRQ-exit scheduling ownership
  docs/rv: Document the IRQ-entry monitors
  rv: Add KUnit coverage for IRQ context transitions
  rv: Add KUnit coverage for IRQ-exit scheduling
  rv: Test empty PREEMPT_RT softirq worker intervals
  rv: Test IRQ-exit softirq provenance and handoff

 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_irqentry.rst   |  398 ++++
 include/linux/interrupt.h                     |    7 +
 include/rv/kunit.h                            |   34 +-
 include/trace/events/irq.h                    |   70 +
 include/trace/events/sched.h                  |   51 +
 kernel/sched/core.c                           |    6 +
 kernel/softirq.c                              |  308 ++-
 kernel/trace/rv/Kconfig                       |    5 +
 kernel/trace/rv/Makefile                      |    3 +
 kernel/trace/rv/monitors/irqentry/Kconfig     |   13 +
 kernel/trace/rv/monitors/irqentry/irqentry.c  |   35 +
 kernel/trace/rv/monitors/irqentry/irqentry.h  |    3 +
 kernel/trace/rv/monitors/irqexit/Kconfig      |   14 +
 kernel/trace/rv/monitors/irqexit/irqexit.c    |  172 ++
 kernel/trace/rv/monitors/irqexit/irqexit.h    |   85 +
 .../trace/rv/monitors/irqexit/irqexit_kunit.c |  537 +++++
 .../trace/rv/monitors/irqexit/irqexit_kunit.h |   21 +
 .../trace/rv/monitors/irqexit/irqexit_trace.h |   19 +
 kernel/trace/rv/monitors/irqstate/Kconfig     |   14 +
 kernel/trace/rv/monitors/irqstate/irqstate.c  |  289 +++
 kernel/trace/rv/monitors/irqstate/irqstate.h  |  139 ++
 .../rv/monitors/irqstate/irqstate_kunit.c     | 2062 +++++++++++++++++
 .../rv/monitors/irqstate/irqstate_kunit.h     |   25 +
 .../rv/monitors/irqstate/irqstate_trace.h     |   15 +
 kernel/trace/rv/rv_monitors_test.c            |   29 +
 kernel/trace/rv/rv_trace.h                    |    2 +
 .../verification/models/irqentry/irqexit.dot  |   21 +
 .../verification/models/irqentry/irqstate.dot |   32 +
 29 files changed, 4397 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_irqentry.rst
 create mode 100644 kernel/trace/rv/monitors/irqentry/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.c
 create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.h
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
 create mode 100644 tools/verification/models/irqentry/irqexit.dot
 create mode 100644 tools/verification/models/irqentry/irqstate.dot

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
prerequisite-patch-id: 6ac7167f0aa7c5319dac78bf5b06a989fd7dfac5
-- 
2.39.5 (Apple Git-154)

