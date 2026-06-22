Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEB3AFCF5;
	Mon, 22 Jun 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133809; cv=none; b=S0J5F/Nr2TWbarEuLXodmP6UxPmAtRGNGaAg+JZo0AxPjQ3MyQr1hRdtRjvurYCah26zIGRtyBh1HEYFsGJn8PR+PfonAlcpwoTpTOWKTwpOqwhQ5GlYFAmv6tGkkgC/eDc/gkM6KyLSDVMTQvK4GDDG63paYEmGBbJ34q+FLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133809; c=relaxed/simple;
	bh=UDJBqa+xpIjCSAx/febuxi331xxiYeMnYHnUZJCZVPs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=CQN45ld5fUV5tfrvpU1Eqk+CenXe3TcafBuslCJMRl70c6tMD/YskG76NJTDCoI0Y/atN315dhn+fqxKjrDaJXP8BCq1Pbte0ffg3QhTCINr7nkEhLMfWx1U2UQHRucOHhx+tPrpv27lTp2OJJMzs8gfFJUTH84Y5v9z2cTqBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM1v7e6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM1v7e6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B961F00A3A;
	Mon, 22 Jun 2026 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782133808;
	bh=8Jl1e7MbxWpdqrTXtcTRctDgI0oEr8/xT6rG4bjyY64=;
	h=Date:From:To:Cc:Subject;
	b=AM1v7e6kWuHBqW1RW16n5u8t3M4BZqV7aqTHdwjWorKguSxOoKVbY181Bc9RMdQ+4
	 MOlR6j+WBd7seNEZ6c96j+cMbWfQtGjgXpe4kSML5DMbzgecMRFS4imb+NWwvCvNHi
	 6W9F0XmhHcdOc+zCAN0KWgeDPUERAahW44mn9uljpEq3uhYlCnmqVC+3Q0+5zOuO3G
	 0XjjGqeQj/xLsbtyapzLHpqbz2CIj28DARvBH6Zhhgp1kHhHz4nRDv8rxBMMGtfovM
	 FufvpW6vaMyAJW+hVQmThyNsrTvCGdYngB6Bu7TIltQu127NVeU2Ri9FZYFoXOkKB5
	 odMEs3CUESYmw==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wbeQ1-000000022fD-2dHY;
	Mon, 22 Jun 2026 09:10:29 -0400
Message-ID: <20260622130739.375198646@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 22 Jun 2026 09:07:39 -0400
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
Subject: [PATCH v2 0/2] tracing: Remove trace_printk.h from kernel.h
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Remove trace_printk.h by creating a trace_controls.h for those places that
need access to tracing prototypes like tracing_off() and for the places that
need trace_printk() directly, to have it included directly.

Changse since v1: https://lore.kernel.org/all/20260621093430.264983361@kernel.org/

- Create a trace_controls.h header to move the prototypes into and not
  include it back into kernel.h

- Just remove trace_printk.h from kernel.h with no alternative to keep the
  previous behavior.

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
 drivers/hwtracing/stm/dummy_stm.c      |  4 +++
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
 27 files changed, 86 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/trace_controls.h
