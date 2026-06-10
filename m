Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287D3DB65A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096729; cv=none; b=nK86dlJy0/7P5c7Zn5SlL0rC+dwi0w+q0WWcA6uFkJc4VPbh92Js8StKzFcnBK3YWyl5T8rZWl4BDNp/5uJ+mw87TtW/sIddPA+iPwxh3OUYpcT7ayJmwGl/D+IYpnJuouHslXw7SNsZMv49J+PPqvauFajPTWil4E2H9N7RJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096729; c=relaxed/simple;
	bh=FeftGIkIL5YCozM9Jt0jXsDJSfZ5CVGAVHeAvwB5OiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sdLTERE5dRI0/XWQWUsOa/QrJnogPy3XwDNDUmi/UAA+S6z4GkDoDVuNyWS6C1wQGt9BK//gsT8F6IpK4tGELCtozkKNObka8uQQF7thl+qWrbMfoPUikhTM+OPqsMgyDe33sWuXHi7biRpEsAtHGzV3wAme9tayzAh0x4/jw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOuoF9q9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOuoF9q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781096725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPmMPGikHnmfqQvtWsMKKE1ehlX8PFP4GGsNTku/VEs=;
	b=LOuoF9q9p11qc85/Z8ss36/2NYn80NK5JkMdU+guhSGMuEsIyYZiwvC12GW1JIX4Bo0Tj5
	YVyv3pflO2DKP4DsIvacDKIpjqQ6zmYAUWvTvWyOxKijfeyp9d55OF2AqaHbon9nQKpIEl
	sp3srtxx/mQP5sa9oT+AflJQiEf9eBw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-ZpN4zONwNtOv-tijfJXhpQ-1; Wed,
 10 Jun 2026 09:05:22 -0400
X-MC-Unique: ZpN4zONwNtOv-tijfJXhpQ-1
X-Mimecast-MFC-AGG-ID: ZpN4zONwNtOv-tijfJXhpQ_1781096721
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17B6F180AE1C;
	Wed, 10 Jun 2026 13:05:21 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12E743008B35;
	Wed, 10 Jun 2026 13:05:17 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [RFC PATCH 1/2] tracing/osnoise: Sample IPI counts
Date: Wed, 10 Jun 2026 15:04:51 +0200
Message-ID: <20260610130457.1304245-2-vschneid@redhat.com>
In-Reply-To: <20260610130457.1304245-1-vschneid@redhat.com>
References: <20260610130457.1304245-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: fakwbOHlg3LSFWoetigfyDP_p6Q9nS6v85KxzwXUmEI_1781096721
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Osnoise already implictly accounts IPIs via its IRQ tracking, however it
can be interesting to distiguish between the two: undesired IPIs usually
imply a software configuration issue (e.g. wrong/incomplete CPU isolation)
whereas undesired (non-IPI) IRQs usually imply a hardware configuration
issue.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
Note that this is modifying the osnoise:osnoise_entry Ftrace entry; I know
trace events are sort of supposed to be stable, but I'm not sure about
ftrace entries.

Alternatively I can have this be purely supported in userspace osnoise by
hooking into the IPI events and counting IPIs separately from the osnoise
events.
---
 include/trace/events/osnoise.h |  1 +
 kernel/trace/trace_entries.h   |  6 ++-
 kernel/trace/trace_osnoise.c   | 80 ++++++++++++++++++++++++++++++++--
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 3f42736238014..58442e58fe652 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -19,6 +19,7 @@ struct osnoise_sample {
 	int			irq_count;	/* # IRQs during this sample */
 	int			softirq_count;	/* # softirqs during this sample */
 	int			thread_count;	/* # threads during this sample */
+	int                     ipi_count;       /* # IPIs during this sample */
 };
 
 #ifdef CONFIG_TIMERLAT_TRACER
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 54417468fdeb1..aed778d859d37 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -430,16 +430,18 @@ FTRACE_ENTRY(osnoise, osnoise_entry,
 		__field(	unsigned int,		irq_count	)
 		__field(	unsigned int,		softirq_count	)
 		__field(	unsigned int,		thread_count	)
+		__field(	unsigned int,		ipi_count	)
 	),
 
-	F_printk("noise:%llu\tmax_sample:%llu\thw:%u\tnmi:%u\tirq:%u\tsoftirq:%u\tthread:%u\n",
+	F_printk("noise:%llu\tmax_sample:%llu\thw:%u\tnmi:%u\tirq:%u\tsoftirq:%u\tthread:%u\tipi:%u\n",
 		 __entry->noise,
 		 __entry->max_sample,
 		 __entry->hw_count,
 		 __entry->nmi_count,
 		 __entry->irq_count,
 		 __entry->softirq_count,
-		 __entry->thread_count)
+		 __entry->thread_count,
+		 __entry->ipi_count)
 );
 
 FTRACE_ENTRY(timerlat, timerlat_entry,
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 75678053b21c5..574629a6b22b3 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -35,6 +35,7 @@
 
 #include <trace/events/irq.h>
 #include <trace/events/sched.h>
+#include <trace/events/ipi.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/osnoise.h>
@@ -83,6 +84,10 @@ struct osnoise_instance {
 
 static struct list_head osnoise_instances;
 
+static struct cpumask osnoise_cpumask;
+static struct cpumask save_cpumask;
+static struct cpumask kthread_cpumask;
+
 static bool osnoise_has_registered_instances(void)
 {
 	return !!list_first_or_null_rcu(&osnoise_instances,
@@ -203,6 +208,11 @@ struct osn_thread {
 	u64	delta_start;
 };
 
+/* IPI runtime info */
+struct osn_ipi {
+	u64 count;
+};
+
 /*
  * Runtime information: this structure saves the runtime information used by
  * one sampling thread.
@@ -215,6 +225,7 @@ struct osnoise_variables {
 	struct osn_irq		irq;
 	struct osn_softirq	softirq;
 	struct osn_thread	thread;
+	struct osn_ipi          ipi;
 	local_t			int_counter;
 };
 
@@ -505,6 +516,7 @@ __record_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buff
 	entry->irq_count	= sample->irq_count;
 	entry->softirq_count	= sample->softirq_count;
 	entry->thread_count	= sample->thread_count;
+	entry->ipi_count	= sample->ipi_count;
 
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }
@@ -1288,6 +1300,7 @@ trace_sched_switch_callback(void *data, bool preempt,
  * Hook the osnoise tracer callbacks to handle the noise from other
  * threads on the necessary kernel events.
  */
+
 static int hook_thread_events(void)
 {
 	int ret;
@@ -1319,6 +1332,60 @@ static void unhook_thread_events(void)
 	unregister_migration_monitor();
 }
 
+static void ipi_emission(struct osnoise_variables *osn_var, unsigned int dst_cpu)
+{
+	if (!osn_var->sampling)
+		return;
+
+	osn_var->ipi.count++;
+}
+
+static void trace_ipi_send_cpu_callback(void *data, unsigned int cpu,
+					unsigned long callsite, void *callback)
+{
+	struct osnoise_variables *osn_var;
+
+	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+	ipi_emission(osn_var, cpu);
+}
+
+static void trace_ipi_send_cpumask_callback(void *data, const struct cpumask *cpumask,
+					    unsigned long callsite, void *callback)
+{
+	struct osnoise_variables *osn_var;
+	int cpu;
+
+	for_each_cpu_and(cpu, cpumask, &osnoise_cpumask) {
+		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+		ipi_emission(osn_var, cpu);
+	}
+}
+
+static int hook_ipi_events(void)
+{
+	int ret;
+
+	ret = register_trace_ipi_send_cpu(trace_ipi_send_cpu_callback, NULL);
+	if (ret)
+		return -EINVAL;
+
+	ret = register_trace_ipi_send_cpumask(trace_ipi_send_cpumask_callback, NULL);
+	if (ret)
+		goto out_unreg;
+
+	return 0;
+
+out_unreg:
+	unregister_trace_ipi_send_cpu(trace_ipi_send_cpu_callback, NULL);
+	return -EINVAL;
+}
+
+static void unhook_ipi_events(void)
+{
+	unregister_trace_ipi_send_cpu(trace_ipi_send_cpu_callback, NULL);
+	unregister_trace_ipi_send_cpumask(trace_ipi_send_cpumask_callback, NULL);
+}
+
 /*
  * save_osn_sample_stats - Save the osnoise_sample statistics
  *
@@ -1333,6 +1400,7 @@ save_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *
 	s->irq_count = osn_var->irq.count;
 	s->softirq_count = osn_var->softirq.count;
 	s->thread_count = osn_var->thread.count;
+	s->ipi_count = osn_var->ipi.count;
 }
 
 /*
@@ -1349,6 +1417,7 @@ diff_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *
 	s->irq_count = osn_var->irq.count - s->irq_count;
 	s->softirq_count = osn_var->softirq.count - s->softirq_count;
 	s->thread_count = osn_var->thread.count - s->thread_count;
+	s->ipi_count = osn_var->ipi.count - s->ipi_count;
 }
 
 /*
@@ -1613,10 +1682,6 @@ static int run_osnoise(void)
 	return ret;
 }
 
-static struct cpumask osnoise_cpumask;
-static struct cpumask save_cpumask;
-static struct cpumask kthread_cpumask;
-
 /*
  * osnoise_sleep - sleep until the next period
  */
@@ -2892,12 +2957,18 @@ static int osnoise_hook_events(void)
 		goto out_unhook_irq;
 
 	retval = hook_thread_events();
+	if (retval)
+		goto out_unhook_softirq;
+
+	retval = hook_ipi_events();
 	/*
 	 * All fine!
 	 */
 	if (!retval)
 		return 0;
 
+	unhook_thread_events();
+out_unhook_softirq:
 	unhook_softirq_events();
 out_unhook_irq:
 	unhook_irq_events();
@@ -2906,6 +2977,7 @@ static int osnoise_hook_events(void)
 
 static void osnoise_unhook_events(void)
 {
+	unhook_ipi_events();
 	unhook_thread_events();
 	unhook_softirq_events();
 	unhook_irq_events();
-- 
2.54.0

