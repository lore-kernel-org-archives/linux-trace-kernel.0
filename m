Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5D1C5490
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Feb 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573476; cv=none; b=AzMuJgCI/PQCLPUEyB239C9hgfjp2fCaQR1hcu9DXBbawulpZLxS+WEL0/eUjcA6GN64LLcg/eZiqGHtegeWTtsA/PXbcYZFXEuPhVFwOGoOoeOgtXsl3XV4kKWuuBWWrsABPuaC9EDvwytJbZ68BM7FD1nYo6i4kXKeO1Ujeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573476; c=relaxed/simple;
	bh=evasHpoK8GBSpS63Eml5GqG6VjFkEbQp9b4oJySK4E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NffL2s02h4KwREebmtaOzQDQONHDVIflF458BIZ5QqbeW22CEfV+eJQRSATbCeFG9F57pujoEkjR2i2QKFw3T3v1sZkBorhzde9LxMG4rRWoop6uNOP3g3Wyc8w3Rn1FRzC4rT7OtpBejvJysjUsaqK3sgY/EVBHcyjfztM5Wuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/BsInRO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/BsInRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738573473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZX2GQIgwuPrigcnnRF64y8AhMLcsKcgIvE1ZbOWxiS4=;
	b=R/BsInROv75J49Yq/p3ICG+MWWdgFlgk7w+yIfPo6kJYCiIJe122UdE8M86tlsTRBKG2D2
	U4U9sQow8hcL8YpkpZ6Xky0+GUeUIw2Bx4n8cBw3b5bPwi02VqaO+TbRJ6YSa87XPQkQJQ
	yo9TdFT7ZrYqL+oB5E78ZQXb+hsEnm4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-rXzdWLnVPSCRCbHdoym8BA-1; Mon,
 03 Feb 2025 04:04:31 -0500
X-MC-Unique: rXzdWLnVPSCRCbHdoym8BA-1
X-Mimecast-MFC-AGG-ID: rXzdWLnVPSCRCbHdoym8BA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C57A219560BA;
	Mon,  3 Feb 2025 09:04:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 076601800268;
	Mon,  3 Feb 2025 09:04:27 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2] trace/osnoise: Add trace events for samples
Date: Mon,  3 Feb 2025 10:04:18 +0100
Message-ID: <20250203090418.1458923-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add trace events that fire at osnoise and timerlat sample generation, in
addition to the already existing noise and threshold events.

This allows processing the samples directly in the kernel, either with
ftrace triggers or with BPF.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
A proof-of-concept bpftrace script using this feature:
https://gitlab.com/-/snippets/4801190

v2:
- Move "#ifndef _OSNOISE_TRACE_H" before "#define _OSNOISE_TRACE_H"
to fix build. (Sorry about that, it was Friday.)

 include/trace/events/osnoise.h | 96 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_osnoise.c   | 55 ++++++-------------
 2 files changed, 112 insertions(+), 39 deletions(-)

diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index a2379a4f0684..3f4273623801 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -3,9 +3,105 @@
 #define TRACE_SYSTEM osnoise
 
 #if !defined(_OSNOISE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+
+#ifndef _OSNOISE_TRACE_H
 #define _OSNOISE_TRACE_H
+/*
+ * osnoise sample structure definition. Used to store the statistics of a
+ * sample run.
+ */
+struct osnoise_sample {
+	u64			runtime;	/* runtime */
+	u64			noise;		/* noise */
+	u64			max_sample;	/* max single noise sample */
+	int			hw_count;	/* # HW (incl. hypervisor) interference */
+	int			nmi_count;	/* # NMIs during this sample */
+	int			irq_count;	/* # IRQs during this sample */
+	int			softirq_count;	/* # softirqs during this sample */
+	int			thread_count;	/* # threads during this sample */
+};
+
+#ifdef CONFIG_TIMERLAT_TRACER
+/*
+ * timerlat sample structure definition. Used to store the statistics of
+ * a sample run.
+ */
+struct timerlat_sample {
+	u64			timer_latency;	/* timer_latency */
+	unsigned int		seqnum;		/* unique sequence */
+	int			context;	/* timer context */
+};
+#endif // CONFIG_TIMERLAT_TRACER
+#endif // _OSNOISE_TRACE_H
 
 #include <linux/tracepoint.h>
+TRACE_EVENT(osnoise_sample,
+
+	TP_PROTO(struct osnoise_sample *s),
+
+	TP_ARGS(s),
+
+	TP_STRUCT__entry(
+		__field(	u64,		runtime	)
+		__field(	u64,		noise	)
+		__field(	u64,		max_sample	)
+		__field(	int,		hw_count	)
+		__field(	int,		irq_count	)
+		__field(	int,		nmi_count	)
+		__field(	int, 		softirq_count	)
+		__field(	int,		thread_count	)
+	),
+
+	TP_fast_assign(
+		__entry->runtime = s->runtime;
+		__entry->noise = s->noise;
+		__entry->max_sample = s->max_sample;
+		__entry->hw_count = s->hw_count;
+		__entry->irq_count = s->irq_count;
+		__entry->nmi_count = s->nmi_count;
+		__entry->softirq_count = s->softirq_count;
+		__entry->thread_count = s->thread_count;
+	),
+
+	TP_printk("runtime=%llu noise=%llu max_sample=%llu hw_count=%d"
+		  " irq_count=%d nmi_count=%d softirq_count=%d"
+		  " thread_count=%d",
+		  __entry->runtime,
+		  __entry->noise,
+		  __entry->max_sample,
+		  __entry->hw_count,
+		  __entry->irq_count,
+		  __entry->nmi_count,
+		  __entry->softirq_count,
+		  __entry->thread_count)
+);
+
+#ifdef CONFIG_TIMERLAT_TRACER
+TRACE_EVENT(timerlat_sample,
+
+	TP_PROTO(struct timerlat_sample *s),
+
+	TP_ARGS(s),
+
+	TP_STRUCT__entry(
+		__field(	u64,		timer_latency	)
+		__field(	unsigned int,	seqnum		)
+		__field(	int,		context		)
+	),
+
+	TP_fast_assign(
+		__entry->timer_latency = s->timer_latency;
+		__entry->seqnum = s->seqnum;
+		__entry->context = s->context;
+	),
+
+	TP_printk("timer_latency=%llu seqnum=%u context=%d",
+		  __entry->timer_latency,
+		  __entry->seqnum,
+		  __entry->context)
+);
+#endif // CONFIG_TIMERLAT_TRACER
+
 TRACE_EVENT(thread_noise,
 
 	TP_PROTO(struct task_struct *t, u64 start, u64 duration),
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f3a2722ee4c0..d7083526d922 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -315,33 +315,6 @@ static inline void osn_var_reset_all(void)
  */
 bool trace_osnoise_callback_enabled;
 
-/*
- * osnoise sample structure definition. Used to store the statistics of a
- * sample run.
- */
-struct osnoise_sample {
-	u64			runtime;	/* runtime */
-	u64			noise;		/* noise */
-	u64			max_sample;	/* max single noise sample */
-	int			hw_count;	/* # HW (incl. hypervisor) interference */
-	int			nmi_count;	/* # NMIs during this sample */
-	int			irq_count;	/* # IRQs during this sample */
-	int			softirq_count;	/* # softirqs during this sample */
-	int			thread_count;	/* # threads during this sample */
-};
-
-#ifdef CONFIG_TIMERLAT_TRACER
-/*
- * timerlat sample structure definition. Used to store the statistics of
- * a sample run.
- */
-struct timerlat_sample {
-	u64			timer_latency;	/* timer_latency */
-	unsigned int		seqnum;		/* unique sequence */
-	int			context;	/* timer context */
-};
-#endif
-
 /*
  * Tracer data.
  */
@@ -497,7 +470,7 @@ static void print_osnoise_headers(struct seq_file *s)
  * Record an osnoise_sample into the tracer buffer.
  */
 static void
-__trace_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffer)
+__record_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffer)
 {
 	struct ring_buffer_event *event;
 	struct osnoise_entry *entry;
@@ -520,17 +493,19 @@ __trace_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffe
 }
 
 /*
- * Record an osnoise_sample on all osnoise instances.
+ * Record an osnoise_sample on all osnoise instances and fire trace event.
  */
-static void trace_osnoise_sample(struct osnoise_sample *sample)
+static void record_osnoise_sample(struct osnoise_sample *sample)
 {
 	struct osnoise_instance *inst;
 	struct trace_buffer *buffer;
 
+	trace_osnoise_sample(sample);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		buffer = inst->tr->array_buffer.buffer;
-		__trace_osnoise_sample(sample, buffer);
+		__record_osnoise_sample(sample, buffer);
 	}
 	rcu_read_unlock();
 }
@@ -574,7 +549,7 @@ static void print_timerlat_headers(struct seq_file *s)
 #endif /* CONFIG_PREEMPT_RT */
 
 static void
-__trace_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buffer)
+__record_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buffer)
 {
 	struct ring_buffer_event *event;
 	struct timerlat_entry *entry;
@@ -594,15 +569,17 @@ __trace_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buf
 /*
  * Record an timerlat_sample into the tracer buffer.
  */
-static void trace_timerlat_sample(struct timerlat_sample *sample)
+static void record_timerlat_sample(struct timerlat_sample *sample)
 {
 	struct osnoise_instance *inst;
 	struct trace_buffer *buffer;
 
+	trace_timerlat_sample(sample);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		buffer = inst->tr->array_buffer.buffer;
-		__trace_timerlat_sample(sample, buffer);
+		__record_timerlat_sample(sample, buffer);
 	}
 	rcu_read_unlock();
 }
@@ -1608,7 +1585,7 @@ static int run_osnoise(void)
 	/* Save interference stats info */
 	diff_osn_sample_stats(osn_var, &s);
 
-	trace_osnoise_sample(&s);
+	record_osnoise_sample(&s);
 
 	notify_new_max_latency(max_noise);
 
@@ -1803,7 +1780,7 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 	s.timer_latency = diff;
 	s.context = IRQ_CONTEXT;
 
-	trace_timerlat_sample(&s);
+	record_timerlat_sample(&s);
 
 	if (osnoise_data.stop_tracing) {
 		if (time_to_us(diff) >= osnoise_data.stop_tracing) {
@@ -1923,7 +1900,7 @@ static int timerlat_main(void *data)
 		s.timer_latency = diff;
 		s.context = THREAD_CONTEXT;
 
-		trace_timerlat_sample(&s);
+		record_timerlat_sample(&s);
 
 		notify_new_max_latency(diff);
 
@@ -2529,7 +2506,7 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		s.timer_latency = diff;
 		s.context = THREAD_URET;
 
-		trace_timerlat_sample(&s);
+		record_timerlat_sample(&s);
 
 		notify_new_max_latency(diff);
 
@@ -2564,7 +2541,7 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	s.timer_latency = diff;
 	s.context = THREAD_CONTEXT;
 
-	trace_timerlat_sample(&s);
+	record_timerlat_sample(&s);
 
 	if (osnoise_data.stop_tracing_total) {
 		if (time_to_us(diff) >= osnoise_data.stop_tracing_total) {
-- 
2.48.1

