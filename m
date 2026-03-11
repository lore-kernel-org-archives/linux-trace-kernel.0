Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A540DFD5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234138; cv=none; b=aJnRldijz06DLCS44ldzZD1OdAoa4aEcqOKaSNMapqevoJtRRPZhGCY9OM85ZAr5fpYN+iPmmGvMkvIH/5HLBGz7hO+tHuuqVq45/lZvdEmGTlU5xii4hzAGjxlwFCQ9GGUSYmndssnf0aD0JnYdU1mTYXC0xJvTwAzIOJ4t5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234138; c=relaxed/simple;
	bh=8bxddo//bFeiWVZAjXE5G5A906QpfmTHXlOStuvysZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=bJraD/cy6YUCxdQXoY2l9ft6ZFFpm0ZdobZjpDyrcOj6pbU/wkZQTv2FmciIjyripHv4IRiGXU3ZPPWkNo3e3JHK7VXvVU1fM5R+QZxPPs8iGE+zhx45t7TKOVPP5j9tM2t7/J/W34cCakop41A1z10FKQaC4iQ6RCO6gC1j5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H42/jk9B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H42/jk9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773234135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W95+Aag+pT4am7UJ7kn0ZYkNZAOsuR+Lm542dQtuy/8=;
	b=H42/jk9BnK5zig4b15GT5k7BtUz7PbUdyHbfoNGStOSIJaxhxyPTu/zu2ipa1oFI0XoH3I
	eJy/xnEytn+3P8iQKTR9mDa37o9GqV1uxlhR0WCYw2JuqibYWwisTBK2nGUBBuJemxClNa
	8ZfPj80GSzfyYqRvcdhoR5zRjOXsub8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-vvQlvA_DOQmkgxuLkn0YWA-1; Wed,
 11 Mar 2026 09:02:14 -0400
X-MC-Unique: vvQlvA_DOQmkgxuLkn0YWA-1
X-Mimecast-MFC-AGG-ID: vvQlvA_DOQmkgxuLkn0YWA_1773234132
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81DB518005B6;
	Wed, 11 Mar 2026 13:02:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.206])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F383730002D2;
	Wed, 11 Mar 2026 13:02:03 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: acme@kernel.org,
	williams@redhat.com,
	gmonaco@redhat.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 0/4] tracing/preemptirq: Optimize disabled tracepoint overhead
Date: Wed, 11 Mar 2026 09:50:14 -0300
Message-ID: <20260311125021.197638-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: drb5HNu65XoaijmKnmhpqDBteSbrbI-zsWCoELHdDKA_1773234132
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The preempt and IRQ tracepoints currently impose measurable overhead
even when they are compiled in but not actively enabled. This overhead
stems from external function calls and unconditional tracepoint checks
in highly active code paths.

The v2 series optimized within the existing CONFIG_TRACE_IRQFLAGS
path, which still required the heavy lockdep and irqsoff
infrastructure to be enabled. This v3 takes a different approach by
providing independent, user-selectable configurations
(CONFIG_TRACE_PREEMPT_TOGGLE and CONFIG_TRACE_IRQFLAGS_TOGGLE) that
expose the tracepoints without pulling in the heavier infrastructure.

The preempt optimization uses inline static key checks, while the IRQ
optimization employs lightweight wrapper functions that check raw
hardware state. Making both configurations explicitly user-selectable
addresses upstream feedback regarding the impact on code generation,
ensuring that this optimization remains strictly opt-in.

---
Performance Measurements

Measurements were taken using the tracer-benchmark kernel module [1].
The module creates one kthread per online CPU. Each thread performs
a configurable number of iterations of
local_irq_disable()/local_irq_enable() and
preempt_disable()/preempt_enable() pairs, timing each pair with
ktime_get_ns(). All threads start simultaneously via a completion
to maximize contention. Per-CPU results (average, median) are aggregated across
CPUs. The 99th percentile is measured separately
on a single pinned CPU. The kernel used was version 7.0.0. All
values are in nanoseconds. Each run collected 10^7 samples.

Configurations compared:
 - 7.0.0: stock kernel
 - irqsoff: stock kernel with CONFIG_IRQSOFF_TRACER=y and
   CONFIG_PREEMPT_TRACER=y
 - preemptirq: patched kernel with CONFIG_TRACE_PREEMPT_TOGGLE=y
   and CONFIG_TRACE_IRQFLAGS_TOGGLE=y

The '+' suffix indicates the test ran with tracepoints enabled.

IRQ Metrics

          Metric          7.0.0  irqsoff  irqsoff+  preemptirq  preemptirq+
          average            19       27       175          19          166
          median             19       27       172          19          164
          99 percentile      21       29       234          21          221

Preempt Metrics

          Metric          7.0.0  irqsoff  irqsoff+  preemptirq  preemptirq+
          average            16       21       169          16          160
          median             16       21       165          17          159
          99 percentile      18       23       236          18          217

The preemptirq configuration matches the stock kernel performance
when tracepoints are disabled, while the irqsoff configuration adds
~40% overhead even when inactive. When tracepoints are enabled,
preemptirq is also slightly faster than irqsoff.

Binary size impact (stripped vmlinux, defconfig):

          7.0.0:       43404576 bytes
          preemptirq:  43429152 bytes (+24576 bytes, +0.057%)

Suggested-by: Steven Rostedt <rostedt@goodmis.org>

---
References:
[1] https://github.com/walac/tracer-benchmark

Changes in v3:
- Reworked series from 2 to 4 patches
- IRQ tracing rearchitected: instead of optimizing within
  CONFIG_TRACE_IRQFLAGS, introduced independent
  CONFIG_TRACE_IRQFLAGS_TOGGLE that provides irq_disable/irq_enable
  tracepoints without pulling in lockdep or irqsoff infrastructure
- Made TRACE_PREEMPT_TOGGLE user-selectable in Kconfig, addressing
  upstream feedback about code generation impact
- Preempt optimization now handles CONFIG_PREEMPT_TRACER alongside
  CONFIG_DEBUG_PREEMPT in the three-way #if split
- Fixed __preempt_trace_enabled() macro to accept val as parameter
- Resolved circular header dependency on m68k by placing
  tracepoint-defs.h include inside conditional blocks instead of
  at the top of preempt.h and irqflags.h
- Moved atomic.h include from tracepoint-defs.h to tracepoint.h
  to break circular dependency chain on ARM32
- Used EXPORT_TRACEPOINT_SYMBOL() instead of raw
  EXPORT_SYMBOL(__tracepoint_*) for proper tracepoint registration
- Narrowed core.c compilation guard to CONFIG_DEBUG_PREEMPT ||
  CONFIG_PREEMPT_TRACER since TRACE_PREEMPT_TOGGLE is now handled
  inline
- Updated performance benchmarks on 7.0.0, including
  tracepoint-enabled measurements and binary size impact

Changes in v2:
- Fixed build failure on arm32 (circular dependency:
  atomic.h -> cmpxchg.h -> irqflags.h -> tracepoint.h -> atomic.h)

Wander Lairson Costa (4):
  tracing/preemptirq: Optimize preempt_disable/enable() tracepoint
    overhead
  trace/preemptirq: make TRACE_PREEMPT_TOGGLE user-selectable
  trace/preemptirq: add TRACE_IRQFLAGS_TOGGLE
  trace/preemptirq: Implement trace_irqflags hooks

 include/linux/irqflags.h          | 62 +++++++++++++++++++++++++++-
 include/linux/preempt.h           | 49 ++++++++++++++++++++--
 include/linux/tracepoint-defs.h   |  1 -
 include/linux/tracepoint.h        |  1 +
 include/trace/events/preemptirq.h |  2 +-
 kernel/sched/core.c               |  2 +-
 kernel/trace/Kconfig              | 19 +++++++--
 kernel/trace/trace_preemptirq.c   | 68 +++++++++++++++++++++++++++++++
 8 files changed, 193 insertions(+), 11 deletions(-)

-- 
2.53.0

