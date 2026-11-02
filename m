Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651048;
	b=sz3qOYnT14szbtPNjlz4ejKNm/FoSO5zJ+7WmwIQohROmoyLCgcrO/qlV7xUOYr2mSEy
	 KVZikU/BcgpHm7AF+IVUORVvthwPZ+nK+RDBQsApqv50fFy/5KKg09FqeGfqjypgify6b
	 OFy8GeMhHnd0C/2/0vgqRB8cRDS/kfkm6MW+bQuViqi37ZyzxOhzcfnWFCOpwZcswhq8k
	 YBjuZdPOMMl8mBSw8VE8AxyKgZ0G8NzWOaFgFxpchMoIBYiKeWsKj5edGCNqn5ASb2mfO
	 A46gJqSe7mSz2OtRa/W6wu9iuA1pZ6z6W+KeMLXc/onIEgV+e0P9OaEad3/y05no5ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651048;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject;
	bh=DwUTLFFYQyj8nimtxRUr/fjPRgG++LPW3Eiw9SLeq3s=;
	b=DX433gKJY/Dgow3L5NUGWHt/yzP7sScnS+KC1JhOna1qVueCe1ILO+oxCGcJufJNAstv
	 TZ6bvdGGJvzcENWHOEPhGl3647gSWfWUEx8So340ocSqVBt2U8e5rWilr/2CtGabAmFYU
	 ye9X6gaKxZ8QcI/cU2d4t+iING8cuMEIy1WNHpZ697LWyyc44U3wtK3G4TEupHvcA2rfH
	 qBEhBdynIhjfaJTI65/Oqt/SXhwZ+TWA76iVKtC5zlsvXgxWebdmAX4X/7VMoVtl5/8NJ
	 PrWUIUdxFQWOFaBmw5fby5Rzw+sKb83+sMbq7ZYenCSuEYnn/ZelOprS7PC/uuznbtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw+vE2So;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605D606A32F;
	Mon,  2 Nov 2026 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw+vE2So
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B221F00A16;
	Mon,  2 Nov 2026 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651048;
	bh=DwUTLFFYQyj8nimtxRUr/fjPRgG++LPW3Eiw9SLeq3s=;
	h=Date:From:To:Cc:Subject;
	b=Qw+vE2SoowovVBtA6NjmsMgSfVHMfuDKONEj1TCAmy7TPW7ZkGHIxZ93wkw6bvDZC
	 cx86bj6RSeAFmKE1gl68dN6Rkz8suZl9jzjo4khxwdQbgqjp4ttborrAIvIBW6DS8e
	 Itf0F/TWCi0a16ul+3JhHi8PwMFWRcrcRd6kq5BqSIl6oq2fejTSG2C/MBnvIrPohn
	 aQgwt0fuFjLDKrBTxrp1k4Km2IawccpMjoPLZwAg+B6ybVm21KNBnUXq7fl2HEpHlw
	 mlKslHR5wsbjCl5ux7seYTqnFUA1WSejo7KaiLkKHZ8buDMIimgTGO4ZX6TfLltg0/
	 yhh8V7kXYtPBw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xNyZb-0000000DJsB-1AMM;
	Mon, 02 Nov 2026 15:24:07 -0500
Message-ID: <20261102202320.574701415@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 02 Nov 2026 15:23:20 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] tracing: Remove trace_printk.h from kernel.h
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list


Remove trace_printk.h by creating a trace_controls.h for those places that
need access to tracing prototypes like tracing_off() and for the places that
need trace_printk() directly, to have it included directly.

Changse since v4: https://lore.kernel.org/linux-trace-kernel/20260625104007.041432666@kernel.org/

- Forward ported to latest kernel.

- Added lockdep patch for _THIS_IP_
  https://patch.msgid.link/20261028110558.623a92d1@gandalf.local.home


Steven Rostedt (3):
      lockdep: Add #include <linux/instruction_pointer.h> to lockdep.h
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
 include/linux/lockdep.h                |  1 +
 include/linux/sunrpc/debug.h           |  1 +
 include/linux/trace_controls.h         | 54 ++++++++++++++++++++++++++++++++
 include/linux/trace_printk.h           | 56 ++--------------------------------
 include/trace/trace_events.h           |  2 ++
 kernel/debug/debug_core.c              |  1 +
 kernel/panic.c                         |  1 +
 kernel/rcu/rcu.h                       |  1 +
 kernel/rcu/rcutorture.c                |  1 +
 kernel/trace/ring_buffer_benchmark.c   |  1 +
 kernel/trace/trace.h                   |  1 +
 kernel/trace/trace_benchmark.c         |  1 +
 lib/sys_info.c                         |  1 +
 samples/fprobe/fprobe_example.c        |  1 +
 samples/ftrace/ftrace-direct-too.c     |  1 -
 samples/trace_printk/trace-printk.c    |  1 +
 29 files changed, 85 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/trace_controls.h
