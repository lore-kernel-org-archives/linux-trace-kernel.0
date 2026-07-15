Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEBD48B38A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130411; cv=none; b=r+QQEEp9WoS3xbfmuHPP7GGj31w5DU1VIU6d1BQ3y9aUWD+p9DS1zpV4KIDZNSkpDy7zqxXCqdOVVU6QNEY1rzR6Gpt0WsM7eaaGb3IkZVGhRnE4pEF0jgGz95eTy59SbW/K3tmmhInKD6svfJJ8PMHYw/MVt6Boc2zgDdYqHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130411; c=relaxed/simple;
	bh=1F4hLTvz/4e4ufJH1DR3U7aK+N7th6xGm76jnDcaobQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IELQOD0bfujHV3JCvt8xVtRUgosfPy1Y415ERgXnAcpzZn99vUrYFWYwIyKCDT7cfs7c1+uIYyF5Zb/xCDbeO+LktunhIoJdVlCr1y5Lt7sFd4YRUJ7Duh24Y1bhBm7saamVCAld9WGwlIx6uq1Dra7sleDuCvyCmC5/5/R6/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoVqcxgA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoVqcxgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784130408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQnQxDAGu0qfvZdzBrLhi68ogAjIIIw2QBHzq8V/lrc=;
	b=IoVqcxgASBPwBrMYP9QqzDO1edqhr3OI8RZvotRIC19FkztNZFwNZnz9tsE0vGF7UtTXh7
	enjBaw4aKRrOjkuLDJycqjdafjCw2EluqbC8oxp47YeK+yhKjvA8BrltTa3JOzLHVnxQh+
	oFJIdNzGfy24w6uL7AfGbPbu9ZabcAs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-KGA9tqSGN5K3shxwKYyuyQ-1; Wed,
 15 Jul 2026 11:46:45 -0400
X-MC-Unique: KGA9tqSGN5K3shxwKYyuyQ-1
X-Mimecast-MFC-AGG-ID: KGA9tqSGN5K3shxwKYyuyQ_1784130404
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E0418005BE;
	Wed, 15 Jul 2026 15:46:43 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.32.112])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67E121800361;
	Wed, 15 Jul 2026 15:46:40 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 2/6] rtla/osnoise: Record IPI count in osnoise top
Date: Wed, 15 Jul 2026 17:45:47 +0200
Message-ID: <20260715154553.2020891-3-vschneid@redhat.com>
In-Reply-To: <20260715154553.2020891-1-vschneid@redhat.com>
References: <20260715154553.2020891-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: n5L3YpGBVGAwn8F1Ck5echeOTCPQbgjjM7QBG1Fb9qQ_1784130404
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Leverage the ipi_send_cpu and ipi_send_cpumask trace events to record the
count of IPIs sent to monitored CPUs. These interferences are already
accounted by the IRQ count, but this split gives a better overall picture.

This uses the newly added -i cmdline option.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c | 116 ++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 512a6299cb018..7b5ae5336cf08 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
+#include <errno.h>
 #include <stdio.h>
 #include <time.h>
 
@@ -25,6 +26,7 @@ struct osnoise_top_cpu {
 	unsigned long long	irq_count;
 	unsigned long long	softirq_count;
 	unsigned long long	thread_count;
+	unsigned long long	ipi_count;
 
 	int			sum_cycles;
 };
@@ -164,6 +166,8 @@ static void osnoise_top_header(struct osnoise_tool *top)
 		goto eol;
 
 	trace_seq_printf(s, "          IRQ      Softirq       Thread");
+	if (params->common.ipi)
+		trace_seq_printf(s, "          IPI");
 
 eol:
 	if (pretty)
@@ -218,7 +222,10 @@ static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
 
 	trace_seq_printf(s, "%12llu ", cpu_data->irq_count);
 	trace_seq_printf(s, "%12llu ", cpu_data->softirq_count);
-	trace_seq_printf(s, "%12llu\n", cpu_data->thread_count);
+	trace_seq_printf(s, "%12llu", cpu_data->thread_count);
+	if (params->common.ipi)
+		trace_seq_printf(s, " %12llu", cpu_data->ipi_count);
+	trace_seq_printf(s, "\n");
 }
 
 /*
@@ -275,12 +282,93 @@ osnoise_top_apply_config(struct osnoise_tool *tool)
 	return -1;
 }
 
+static void account_ipi(struct osnoise_tool *tool, unsigned long long dst_cpu)
+{
+	struct osnoise_top_cpu *cpu_data;
+	struct osnoise_top_data *data;
+	unsigned long long inc = 1;
+
+	data = tool->data;
+	cpu_data = &data->cpu_data[dst_cpu];
+
+	update_sum(&cpu_data->ipi_count, &inc);
+}
+
+/*
+ * osnoise_ipi_cpu_handler - this is the handler for single CPU IPI events.
+ */
+static int
+osnoise_ipi_cpu_handler(struct trace_seq *s, struct tep_record *record,
+		     struct tep_event *event, void *context)
+{
+	struct osnoise_tool *tool;
+	struct osnoise_params *params;
+	unsigned long long dst_cpu;
+	struct trace_instance *trace = context;
+
+	tool = container_of(trace, struct osnoise_tool, trace);
+	params = to_osnoise_params(tool->params);
+
+	tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
+
+	if (CPU_ISSET(dst_cpu, &params->common.monitored_cpus))
+		account_ipi(tool, dst_cpu);
+
+	return 0;
+}
+
+static cpu_set_t cpumask_tmp_cpus;
+
+/*
+ * osnoise_ipi_cpumask_handler - this is the handler for broadcasted IPI events.
+ */
+static int
+osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *record,
+			 struct tep_event *event, void *context)
+{
+	struct trace_instance *trace = context;
+	struct osnoise_tool *tool;
+	struct osnoise_params *params;
+	struct tep_format_field *field;
+	cpu_set_t *event_cpus;
+	int len;
+
+	tool = container_of(trace, struct osnoise_tool, trace);
+	params = to_osnoise_params(tool->params);
+
+	field = tep_find_field(event, "cpumask");
+	if (!field)
+		return 0;
+
+	event_cpus = tep_get_field_raw(s, event, "cpumask", record, &len, 1);
+	if (!event_cpus) {
+		err_msg("Failed to get cpumask field\n");
+		return 0;
+	}
+
+	CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored_cpus);
+
+	/*
+	 * Computing the mask weight is overkill but there is no leaner option
+	 * provided by glibc, e.g cpumask_first() or somesuch.
+	 */
+	if (CPU_COUNT(&cpumask_tmp_cpus)) {
+		for (int cpu = 0; cpu < nr_cpus; cpu++) {
+			if (CPU_ISSET(cpu, &cpumask_tmp_cpus))
+				account_ipi(tool, cpu);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * osnoise_init_top - initialize a osnoise top tool with parameters
  */
 struct osnoise_tool *osnoise_init_top(struct common_params *params)
 {
 	struct osnoise_tool *tool;
+	int retval;
 
 	tool = osnoise_init_tool("osnoise_top");
 	if (!tool)
@@ -295,7 +383,33 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 	tep_register_event_handler(tool->trace.tep, -1, "ftrace", "osnoise",
 				   osnoise_top_handler, NULL);
 
+	if (!params->ipi)
+		goto out;
+
+	retval = tracefs_event_enable(tool->trace.inst, "ipi", "ipi_send_cpu");
+	if (retval < 0 && !errno) {
+		err_msg("Could not find ipi_send_cpu event\n");
+		goto out_err;
+	}
+
+	retval = tracefs_event_enable(tool->trace.inst, "ipi", "ipi_send_cpumask");
+	if (retval < 0 && !errno) {
+		err_msg("Could not find ipi_send_cpumask event\n");
+		goto out_err;
+	}
+
+	tep_register_event_handler(tool->trace.tep, -1, "ipi", "ipi_send_cpu",
+				   osnoise_ipi_cpu_handler, NULL);
+
+	tep_register_event_handler(tool->trace.tep, -1, "ipi", "ipi_send_cpumask",
+				   osnoise_ipi_cpumask_handler, NULL);
+
+out:
 	return tool;
+out_err:
+	osnoise_free_top_tool(tool);
+	osnoise_destroy_tool(tool);
+	return NULL;
 }
 
 struct tool_ops osnoise_top_ops = {
-- 
2.55.0

