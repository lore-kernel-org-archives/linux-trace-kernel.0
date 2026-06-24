Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F111E5207;
	Wed, 24 Jun 2026 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289164; cv=none; b=G3bxNRgM5ryEaGX3JvsGS60W5qthKn7UJKnRiQpanjtX7omxzh6AE1tyjv/c4ls7zd75MsXhQ49G8V5tq06mxOFUIRlGn3hXdtgYiENGUixex/2lvhnU6gq1onrchV1VMyRH6PxKsoHhiGCtOXaUAl+vDEgAnLo4F23cl40btj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289164; c=relaxed/simple;
	bh=eIG90qVQsgHidBLxq7bOOSsoz+TBIPpCebJLzBTG8JA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dOk0V4l/ijYdKrrWl/xX7163OlExEZQplzJfKmD5LApIvAyCZNmTWbPS/KuDQqVmF05zxPcnFfewMIjVbouJCVx89XDyNvpH8kzaeYLGtTjsZe/KT0MreuzAXlChoAcvCa1cqScu2loNjp5zMBBw+jhUZkBvE8iDZcN26OC3Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo/zLGPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo/zLGPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B0C1F000E9;
	Wed, 24 Jun 2026 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782289162;
	bh=AjYzqi9865zm+eZwIbZ9brn4nsZ54p3RAIGWcHNwc5E=;
	h=Date:From:To:Cc:Subject;
	b=Oo/zLGPz7YILnYbcBUdRV1Vlgu84uLV85TIfsEoCEQshKmv7HMqpd1kIwXMbNhsKT
	 xQHckILKTEzcHHQ5aH/HsCA+dvh5SdxYlLEw9g++baEufeq5WZilPzn2CHrCrlxzQb
	 8iOwTYxrPEsnHgcJwWlwPFAd28/v56MglGYADdGQzB1+lxWncE02bEbxLz/NC9p4aw
	 bOc6wO/qoVnRXOmNmmFYHlukQRHA8i/eR0lkSlKMOYklHDCjS7sxncXGqNlmmGXmxI
	 e7qw9KAppZ7SmDxSDNN6J4FeU7uXak6lOYgX1dRktQXIEhdMATu+Q6Ct2AEwagC19l
	 BdzKN6dnERLDg==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wcIpo-00000002Knj-0VeH;
	Wed, 24 Jun 2026 04:19:48 -0400
Message-ID: <20260624081806.120105649@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 24 Jun 2026 04:18:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 0/2] tracing: Remove trace_printk.h from kernel.h
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Remove trace_printk.h by creating a trace_controls.h for those places that
need access to tracing prototypes like tracing_off() and for the places that
need trace_printk() directly, to have it included directly.

Changse since v2: https://lore.kernel.org/all/20260622130739.375198646@kernel.org/

- Update change log in patch 1

- Remove #ifdef DEBUG and always include trace_printk.h in patch 2.

Steven Rostedt (2):
      tracing: Move non-trace_printk prototypes into trace_controls.h
      tracing: Remove trace_printk.h from kernel.h

----
 arch/powerpc/kvm/book3s_xics.c         |  1 +
 arch/powerpc/xmon/xmon.c               |  1 +
 arch/s390/kernel/ipl.c                 |  1 +
 arch/s390/kernel/machine_kexec.c       |  1 +
 drivers/gpu/drm/i915/gt/intel_gtt.h    |  1 +
 drivers/gpu/drm/i915/i915_gem.h        |  2 ++
 drivers/hwtracing/stm/dummy_stm.c      |  1 +
 drivers/infiniband/hw/hfi1/trace_dbg.h |  1 +
 drivers/tty/sysrq.c                    |  1 +
 drivers/usb/early/xhci-dbc.c           |  1 +
 fs/ext4/inline.c                       |  1 +
 include/linux/ftrace.h                 |  2 ++
 include/linux/kernel.h                 |  1 -
 include/linux/sunrpc/debug.h           |  1 +
 include/linux/trace_controls.h         | 54 ++++++++++++++++++++++++++++++++
 include/linux/trace_printk.h           | 56 ++--------------------------------
 kernel/debug/debug_core.c              |  1 +
 kernel/panic.c                         |  1 +
 kernel/rcu/rcu.h                       |  2 ++
 kernel/rcu/rcutorture.c                |  1 +
 kernel/trace/ring_buffer_benchmark.c   |  1 +
 kernel/trace/trace.h                   |  1 +
 kernel/trace/trace_benchmark.c         |  1 +
 lib/sys_info.c                         |  1 +
 samples/fprobe/fprobe_example.c        |  1 +
 samples/ftrace/ftrace-direct-too.c     |  1 -
 samples/trace_printk/trace-printk.c    |  1 +
 27 files changed, 83 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/trace_controls.h
