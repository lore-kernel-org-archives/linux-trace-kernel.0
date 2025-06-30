Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1279D2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313207; cv=none; b=Rwsx0QlllPz36jlMQQ30lvWEn0llC2ht6oolWcwlht+ax5Ian2GnIv9PUTPgiHIXs7AmGG/yumq7+En2ghSWwGdbJDSvEXyCf2XKQRyJcHfeUcG7rV075wG9Ew6L+8YuK8d00a1k3umYHiCx3bU90e5wxcGJzSwA3dg0sNu3Nhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313207; c=relaxed/simple;
	bh=mb4/1vH9n6q9rNrdgT20l/pylOhgmZ+uaaLOAbxALSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Snn5gF2L7CUC0IFoYbYGfg+WVhGxcXrmXoeF+O3h+VgCtuysmkrmrO7nZP4Ow5XTD9Tm2bKfZop+C2cEIupEcKBPI5KKLxkys/fPlpfPiy3PpC2YGhGw95Iu97hdJU++uEExSsKWGi2sj1ifeF9wDhV7OcMuWzJ0XymgSFBrHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1qqXz09; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1qqXz09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751313203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=syTb+Mhfck7Nalb+yCwZWJBPcp6go4CFDAPerQQWMAA=;
	b=E1qqXz09L/Xw2P1iNaMQl4cM3OUWctT5qKv38hQmPBur0FgOD4JN/hBlMgC5DlEaOTXaOM
	XOzT2lSMSvBVdLxLajBFQEd3Su+FMJgWczge3EOBHpuWVNOmMGpSxm6J+1TWCO9i6DEwLG
	xdFZlY4TmxU4OIWaC2IkzTWhkUQEGiA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-RzGRvR6xP5uH9BG94AFWaw-1; Mon,
 30 Jun 2025 15:53:19 -0400
X-MC-Unique: RzGRvR6xP5uH9BG94AFWaw-1
X-Mimecast-MFC-AGG-ID: RzGRvR6xP5uH9BG94AFWaw_1751313197
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDF4718DA384;
	Mon, 30 Jun 2025 19:53:16 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.65.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73E3619560A7;
	Mon, 30 Jun 2025 19:53:08 +0000 (UTC)
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
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2 0/2] tracing/preemptirq: Optimize disabled tracepoint overhead
Date: Mon, 30 Jun 2025 16:52:37 -0300
Message-ID: <20250630195243.701516-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series addresses unnecessary overhead introduced by the
preempt/irq tracepoints when they are compiled into the kernel
but are not actively enabled (i.e., when tracing is disabled).

These optimizations ensure that when tracing is inactive, the kernel
can largely bypass operations that would otherwise incur a passive
performance penalty. This makes the impact of disabled preemptirq
IRQ and preempt tracing negligible in performance-sensitive environments.

---
Performance Measurements

Measurements were taken using a specialized kernel module [1] to benchmark
`local_irq_disable/enable()` and `preempt_disable/enable()` call pairs.
The kernel used for benchmarking was version 6.16.0-rc2. "Max Average"
represents the average of the 1000 highest samples, used to reduce noise
from single highest samples.

Each benchmark run collected 10^7 samples in parallel from each CPU
for each call pair (used for average, max_avg, and median calculations).
The 99th percentile was measured in a separate benchmark run, focused
on a single CPU.

The results show that compiling with tracers (Kernel Build:
`-master-trace`) introduced significant overhead compared to a base
kernel without tracers (Kernel Build: `-master`). After applying these
patches (Kernel Build: `-patched-trace`), the overhead is
substantially reduced, approaching the baseline.

x86-64 Metrics

Tests were run on a system equipped with an Intel(R) Xeon(R) Silver 4310 CPU.

IRQ Metrics

Combined Metric            average  max_avg  median  percentile
Kernel Build
6.16.0-rc2-master               28     5587      29          23
6.16.0-rc2-master-trace         46     7895      48          32
6.16.0-rc2-patched-trace        30     6030      31          27

Preempt Metrics

Combined Metric            average  max_avg  median  percentile
Kernel Build
6.16.0-rc2-master               26     5748      27          20
6.16.0-rc2-master-trace         45     7526      48          26
6.16.0-rc2-patched-trace        27     5479      27          21

AArch64 Metrics

Tests were also conducted on an AArch64 platform.

IRQ Metrics

Combined Metric             average  max_avg  median  percentile
Kernel Build
aarch64-6.16.0-rc2-master        28     3298      32          64
aarch64-6.16.0-rc2-master-trace 105     5769      96         128
aarch64-6.16.0-rc2-patched-trace 29     3192      32          64

Preempt Metrics

Combined Metric             average  max_avg  median  percentile
Kernel Build
aarch64-6.16.0-rc2-master        27     3371      32          32
aarch64-6.16.0-rc2-master-trace  32     3000      32          64
aarch64-6.16.0-rc2-patched-trace 28     3132      32          64

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>

---
References:
[1] https://github.com/walac/tracer-benchmark

--
Changes:
v1: initial patch
v2: enable IRQ tracing when CONFIG_PROVE_LOCKING

Wander Lairson Costa (2):
  trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
  tracing/preemptirq: Optimize preempt_disable/enable() tracepoint
    overhead

 include/linux/irqflags.h        | 30 +++++++++++++++++++---------
 include/linux/preempt.h         | 35 ++++++++++++++++++++++++++++++---
 kernel/sched/core.c             | 12 +----------
 kernel/trace/trace_preemptirq.c | 22 +++++++++++++++++++++
 4 files changed, 76 insertions(+), 23 deletions(-)

-- 
2.50.0

