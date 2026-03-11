Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833872F5474
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234163; cv=none; b=AJxZIlBW4UusHnV9hTWP0S98xQ+IyhyiXrlc5ZqGhwIEgdSdgS7ushVqs0OKefV1CE/Q+PdSEBJE92KM1IilMTFqbI+OkyrFBIGkg1WdkE+U1e1ivpSrlRvtqjPiXtbe2GamYvPIh3jLHaNki/SJRHGbl3cOLoiH6+77P6NyF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234163; c=relaxed/simple;
	bh=cOgWE7xPYdBb7ngV1nOTKdOodYtpLLNf1JLEVdngPx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PeIXLh2yL0Ij2a2cdZgFhs99noTcUeGhtp0CFkYyolN8TfYSGbmmwqIPTJ+/CmfpQphTSysnxO1dvTAngEwKvYYIpc/5cI8bj9qFGRYmf1FwPhD2JZzSpQWKQX0McIwri7S71h1anAfrjsdCLgiSUNhDadG17RD3bQu7Yq0juJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWU4TH3S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWU4TH3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773234161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr3KKQRC6yYka+uWB2bxIN0vAy+Wc13bRkpoGNmLdig=;
	b=MWU4TH3S3S2vjldD+1iZbIeaNeAr8pzo1nWqOPLcBWQ70yQl2Lu4cERVn9TTT4s4f8SIuC
	r8ooKAjsl4Nqh05ZWeGm58ZCUANFXd0+rkpDTBuv/IUoBV6mKKETHLDeVz1t5LPiFeZlco
	CdkFO1DBF9lcuzcBsiYuCZI6PaOl/Aw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-QnUWSdx2O_ObujOxbUlKvg-1; Wed,
 11 Mar 2026 09:02:35 -0400
X-MC-Unique: QnUWSdx2O_ObujOxbUlKvg-1
X-Mimecast-MFC-AGG-ID: QnUWSdx2O_ObujOxbUlKvg_1773234154
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC901180044D;
	Wed, 11 Mar 2026 13:02:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.206])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECA293000223;
	Wed, 11 Mar 2026 13:02:26 +0000 (UTC)
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
Subject: [PATCH v3 3/4] trace/preemptirq: add TRACE_IRQFLAGS_TOGGLE
Date: Wed, 11 Mar 2026 09:50:17 -0300
Message-ID: <20260311125021.197638-4-wander@redhat.com>
In-Reply-To: <20260311125021.197638-1-wander@redhat.com>
References: <20260311125021.197638-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: UsTHJIxuMw4YE8uyp32Gjw-l1zftMQpPCAT6y4yQ6RM_1773234154
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The IRQ disable/enable tracepoints are currently gated behind
TRACE_IRQFLAGS, a hidden config that cannot be selected directly by
users. It is only enabled when selected by PROVE_LOCKING or
IRQSOFF_TRACER, both of which carry overhead beyond what is needed
for just the tracepoints.

Introduce TRACE_IRQFLAGS_TOGGLE, a user-selectable config that enables
the irq_disable and irq_enable tracepoints independently. It is
mutually exclusive with TRACE_IRQFLAGS and mirrors how
TRACE_PREEMPT_TOGGLE works for preemption tracepoints.

Make this option depend on CONFIG_JUMP_LABEL to avoid a circular header
dependency. Without TRACE_IRQFLAGS, irqflags.h must check the static
key before invoking the tracepoint. Using tracepoint_enabled() for this
check pulls in tracepoint_defs.h, which eventually includes atomic.h
and cmpxchg.h, circling back to irqflags.h. Enforcing CONFIG_JUMP_LABEL
allows the use of static_key_false() directly, avoiding the inclusion
of the full tracepoint header chain and preventing the cycle.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/trace/Kconfig | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e007459ecf361..8bea77b5f1200 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -162,7 +162,7 @@ config RING_BUFFER_ALLOW_SWAP
 
 config PREEMPTIRQ_TRACEPOINTS
 	bool
-	depends on TRACE_PREEMPT_TOGGLE || TRACE_IRQFLAGS
+	depends on TRACE_PREEMPT_TOGGLE || TRACE_IRQFLAGS || TRACE_IRQFLAGS_TOGGLE
 	select TRACING
 	default y
 	help
@@ -418,6 +418,17 @@ config TRACE_PREEMPT_TOGGLE
 	  Enables hooks into preemption disable and enable paths for
 	  tracing or latency measurement.
 
+config TRACE_IRQFLAGS_TOGGLE
+	bool "IRQ disable/enable tracing hooks"
+	default n
+	depends on TRACE_IRQFLAGS_SUPPORT && JUMP_LABEL && !TRACE_IRQFLAGS
+	help
+	  Enables hooks into IRQ disable and enable paths for tracing.
+
+	  This provides the irq_disable and irq_enable tracepoints
+	  without pulling in the full TRACE_IRQFLAGS infrastructure
+	  used by lockdep and the irqsoff latency tracer.
+
 config IRQSOFF_TRACER
 	bool "Interrupts-off Latency Tracer"
 	default n
-- 
2.53.0

