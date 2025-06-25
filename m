Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53C254AF0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Jun 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853333; cv=none; b=onpUHKoa9eqS4zzJe7DhL3ToYL4tzTqOwiYfqznkSt3/LrPraytsEZJWmgwufg3mLeAE4iqjlDnX3CO51gxmnvLfesxtpB1R07gCmIRnMd3hpZ9LCpRUvxsOSYNtPrmlxK2Mj1MeVK83YyO4uaZPreWi2JPN4v+ROL/xYx2dP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853333; c=relaxed/simple;
	bh=X8h3MG8s3fb3StRKIu5mktDQtEpEED8w2np7qHBxHZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAbzlGHph3ANbPZVPN5mjBmeMUjticYLv5da4wo6p8eMKwe7kcJH74mZ+B05jkH7TpLjVMP7Qc5VdmEqMJi+Thl8PajBtw/STH10nnIRqB9gApk3iX1zt6p/s6IQCca11nzBoOBqDjbzKwWGQViJGiOIRVTxB0EG0zH+U1nYBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnAZeIl7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnAZeIl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750853331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zTVi9eLGvwvzNaP8yl+nsFwlrw1BF+IPA5X1VEV65UQ=;
	b=AnAZeIl7y/Eec5nKLhsF83vaZ+BCyQ+DakuZa2Qrq3iYK+XmjsyKAiXh8DOig2wV334+MB
	6uBt59YbruwyvHs4oZlDxoclLjKCocc+CIFbNwn277WukpNuVnOVK79qOvRA6J/nS+JXkL
	VM9Z8pRq9YFgvMf2ZzjC4KaXxW3h7Jw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-QJVepUZHO4aAnGEtYhWywA-1; Wed,
 25 Jun 2025 08:08:47 -0400
X-MC-Unique: QJVepUZHO4aAnGEtYhWywA-1
X-Mimecast-MFC-AGG-ID: QJVepUZHO4aAnGEtYhWywA_1750853326
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B12EA19560AF;
	Wed, 25 Jun 2025 12:08:45 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.225.149])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B49D71956096;
	Wed, 25 Jun 2025 12:08:39 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2] tracing: Fix inconsistency in irq tracking on NMIs
Date: Wed, 25 Jun 2025 14:08:22 +0200
Message-ID: <20250625120823.60600-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The irq_enable/irq_disable tracepoints fire only when there's an actual
transition (enabled->disabled and vice versa), this needs special care
in NMIs, as they can potentially start with interrupts already disabled.
The current implementation takes care of this by tracking the lockdep
state on nmi_entry as well as using the variable tracing_irq_cpu to
synchronise with other calls (e.g. local_irq_disable/enable).

This can be racy in case of NMIs when lockdep is enabled, and can lead
to missing events when lockdep is disabled.

Remove dependency on the lockdep status in the NMI common entry/exit
code and adapt the tracing code to make sure that:

- The first call disabling interrupts fires the tracepoint
- The first non-NMI call enabling interrupts fires the tracepoint
- The last NMI call enabling interrupts fires the tracepoint unless
  interrupts were disabled before the NMI
- All other calls don't fire

Fixes: ba1f2b2eaa2a ("x86/entry: Fix NMI vs IRQ state tracking")
Fixes: f0cd5ac1e4c5 ("arm64: entry: fix NMI {user, kernel}->kernel transitions")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

The inconsistency is visible with the sncid RV monitor and particularly
likely on machines with the following setup:
- x86 bare-metal with 40+ CPUs
- tuned throughput-performance (activating regular perf NMIs)
- workload: stress-ng --cpu-sched 21 --timer 11 --signal 11

The presence of the RV monitor is useful to see the error but it is not
necessary to trigger it.

Changes since V1:
* Reworded confusing changelog
* Remove dependency on lockdep counters for tracepoints
* Ensure we don't drop valid tracepoints
* Extend change to arm64 code

 arch/arm64/kernel/entry-common.c |  5 ++---
 kernel/entry/common.c            |  5 ++---
 kernel/trace/trace_preemptirq.c  | 12 +++++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 7c1970b341b8c..7f1844123642e 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -213,10 +213,9 @@ static void noinstr arm64_exit_nmi(struct pt_regs *regs)
 	bool restore = regs->lockdep_hardirqs;
 
 	ftrace_nmi_exit();
-	if (restore) {
-		trace_hardirqs_on_prepare();
+	trace_hardirqs_on_prepare();
+	if (restore)
 		lockdep_hardirqs_on_prepare();
-	}
 
 	ct_nmi_exit();
 	lockdep_hardirq_exit();
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a8dd1f27417cf..e234f264fb495 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -343,10 +343,9 @@ void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 {
 	instrumentation_begin();
 	ftrace_nmi_exit();
-	if (irq_state.lockdep) {
-		trace_hardirqs_on_prepare();
+	trace_hardirqs_on_prepare();
+	if (irq_state.lockdep)
 		lockdep_hardirqs_on_prepare();
-	}
 	instrumentation_end();
 
 	ct_nmi_exit();
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 0c42b15c38004..fa45474fc54f1 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -58,7 +58,11 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
  */
 void trace_hardirqs_on_prepare(void)
 {
-	if (this_cpu_read(tracing_irq_cpu)) {
+	int tracing_count = this_cpu_read(tracing_irq_cpu);
+
+	if (in_nmi() && tracing_count > 1)
+		this_cpu_dec(tracing_irq_cpu);
+	else if (tracing_count) {
 		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
@@ -89,8 +93,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on);
  */
 void trace_hardirqs_off_finish(void)
 {
-	if (!this_cpu_read(tracing_irq_cpu)) {
-		this_cpu_write(tracing_irq_cpu, 1);
+	if (this_cpu_inc_return(tracing_irq_cpu) == 1) {
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
 		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 	}
@@ -103,8 +106,7 @@ void trace_hardirqs_off(void)
 {
 	lockdep_hardirqs_off(CALLER_ADDR0);
 
-	if (!this_cpu_read(tracing_irq_cpu)) {
-		this_cpu_write(tracing_irq_cpu, 1);
+	if (this_cpu_inc_return(tracing_irq_cpu) == 1) {
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
 		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 	}

base-commit: 78f4e737a53e1163ded2687a922fce138aee73f5
-- 
2.49.0

