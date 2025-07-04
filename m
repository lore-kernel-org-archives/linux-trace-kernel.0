Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49F2882BB
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Jul 2025 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751648924; cv=none; b=Y/Id+/JNGAYVgsUCwAlO9H40fH5d/QZ8QSBL1YzzJr5xAX0iE3T+AI7lKgvN8rP8dtaBLkE18GsXSPk9HK+StVwvEZuJPLBbQWMu0D2EUT9YeZ/4LdjzODNTt44pBRQsehknvRVU3YijzkQJgcyljQuQf8B6a4KPzo3ht8mr1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751648924; c=relaxed/simple;
	bh=RSpc/HEh7EC9KbKUGCwegqfYZnp1BrMK74eIEFnWcFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kj2Yonu1B7ECbQlmIxhH1rIfew83R9fm/lxytZM8j5+W28bUy+3YU+hqvyHYniGtSqULeVkIZr+qFtqUweU/iQ7T+vEEaD2zS85wyR+etgPKJQpqW/Q2cQ80XEWCBXPCSM0dLhYgcDVFk0N45M8I2R6VDHRQeC4WVGYsfUSd8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fd0+5KKo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd0+5KKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751648918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sIfTKBxpXvRRKFDOhvV5FIjToEH8amE07fxIQ6HxVLA=;
	b=fd0+5KKoBBTNhvE/j8+iqgMrzUjgO0iwKhiax1kLPFoDQKiYLbM0/3NfVpUMbGgP0RzrrO
	MyMQFI988IwWRZGRiJs62126KB0QxFjTHyri5gJPWn1Nn93ejaF1/iIeL2G0T4TuL8+1mt
	T3wMbUkIvDXUprn/tdkqRaxpXkpd83E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-5wCcLCKuNFy2y5dL6ZtSFQ-1; Fri,
 04 Jul 2025 13:08:35 -0400
X-MC-Unique: 5wCcLCKuNFy2y5dL6ZtSFQ-1
X-Mimecast-MFC-AGG-ID: 5wCcLCKuNFy2y5dL6ZtSFQ_1751648913
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 823671956061;
	Fri,  4 Jul 2025 17:08:32 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5124719560AB;
	Fri,  4 Jul 2025 17:08:24 +0000 (UTC)
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
	Wander Lairson Costa <wander@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v3 0/2] tracing/preemptirq: Optimize disabled tracepoint overhead
Date: Fri,  4 Jul 2025 14:07:41 -0300
Message-ID: <20250704170748.97632-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
v1: Initial version of the patch.
v2: Enabled IRQ tracing automatically when CONFIG_PROVE_LOCKING is active.
v3: Resolved a build failure on the 32-bit ARM architecture.

Wander Lairson Costa (2):
  trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
  tracing/preemptirq: Optimize preempt_disable/enable() tracepoint
    overhead

 include/linux/irqflags.h        | 30 +++++++++++++++++++---------
 include/linux/preempt.h         | 35 ++++++++++++++++++++++++++++++---
 include/linux/tracepoint-defs.h |  1 -
 include/linux/tracepoint.h      |  1 +
 kernel/sched/core.c             | 12 +----------
 kernel/trace/trace_preemptirq.c | 22 +++++++++++++++++++++
 6 files changed, 77 insertions(+), 24 deletions(-)

-- 
2.50.0

