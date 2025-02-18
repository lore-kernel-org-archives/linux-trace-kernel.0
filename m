Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F326E14A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890780; cv=none; b=n3sw8blfqcFqucgkjrvgl8ixFaIYuAdWmw0vlccGnNW65E6XS779E1lPoJMaiCawFJcUqvnde2BnIItdsTXEbuX9HfnfizlM5Aa23L/tzoQB3DYqJt64FjDqJjSNvKGc8x7exhEm8U1JAztw5+/4sG/btRSk19F1LA3N/ufMOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890780; c=relaxed/simple;
	bh=E3bNa7emJRhtCu+BrKIRDmqzpc3ErP55C49NFvlfc20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zhh8iQ3jxuzTj9sn+xzk7SPFK3Xs+GwoMJwWx/B6K9nqtNdOAMW02PqXzp1owvrm7PXCxPTl8ymM44CbLZxlzwQm6ySrvVFZPzN4y8dMUt4Pm1vec4PnEM62YVUWlk11LAETtKO/GuKXcA+kId1agaMhUswBqZbF3NDG6Dauwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eswNTq1a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eswNTq1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OcTiD2GyYJaDLiGlJk8w6AGS1Irx6e6aiYphVzPoJLo=;
	b=eswNTq1axnJrSYwPZ05bHSeIR+x62fEGljpnIPSht6vofRD9EZis70f5YUj4pF9Zqcymxy
	hp/U/dRZ7D+ZteYF9rCxvdgzn7mWlKUDW6KWYjBg2sgPeXKNFBtWOSwwGmiMwObPpicAmk
	PdaADwTjr8goLF63hRcP2I2lFWVREXI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-u2TmLTq6NzqoXR-thfohlg-1; Tue,
 18 Feb 2025 09:59:34 -0500
X-MC-Unique: u2TmLTq6NzqoXR-thfohlg-1
X-Mimecast-MFC-AGG-ID: u2TmLTq6NzqoXR-thfohlg_1739890773
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3881D1800873;
	Tue, 18 Feb 2025 14:59:33 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D54FA180035F;
	Tue, 18 Feb 2025 14:59:30 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 7/8] rtla/timerlat_top: Use BPF to collect samples
Date: Tue, 18 Feb 2025 15:58:58 +0100
Message-ID: <20250218145859.27762-8-tglozar@redhat.com>
In-Reply-To: <20250218145859.27762-1-tglozar@redhat.com>
References: <20250218145859.27762-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Collect samples using BPF program instead of pulling them from tracefs.

If the osnoise:timerlat_sample tracepoint is unavailable or the BPF
program fails to load for whatever reason, rtla falls back to the old
implementation.

The collection of samples using the BPF program is fully self-contained
and requires no activity of the userspace part of rtla during the
measurement. Thus, rtla only pulls the summary from the BPF map and
displays it every second, improving the performance.

In --aa-only mode, the BPF program does not collect any data and only
signalizes the end of tracing to userspace. An optimization that re-used
the main trace instance for auto-analysis in aa-only mode was dropped, as
rtla no longer turns tracing on in the main trace instance, making it
useless for auto-analysis.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 255 ++++++++++++++++++++++----
 1 file changed, 215 insertions(+), 40 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index a3d9e8f67a4f..1b6455b9e093 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -18,6 +18,7 @@
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_u.h"
+#include "timerlat_bpf.h"
 
 struct timerlat_top_cpu {
 	unsigned long long	irq_count;
@@ -181,6 +182,76 @@ timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+/*
+ * timerlat_top_bpf_pull_data - copy data from BPF maps into userspace
+ */
+static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
+{
+	struct timerlat_top_data *data = tool->data;
+	int i, err;
+	long long value_irq[data->nr_cpus],
+		  value_thread[data->nr_cpus],
+		  value_user[data->nr_cpus];
+
+	/* Pull summary */
+	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].cur_irq = value_irq[i];
+		data->cpu_data[i].cur_thread = value_thread[i];
+		data->cpu_data[i].cur_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].irq_count = value_irq[i];
+		data->cpu_data[i].thread_count = value_thread[i];
+		data->cpu_data[i].user_count = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].min_irq = value_irq[i];
+		data->cpu_data[i].min_thread = value_thread[i];
+		data->cpu_data[i].min_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].max_irq = value_irq[i];
+		data->cpu_data[i].max_thread = value_thread[i];
+		data->cpu_data[i].max_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].sum_irq = value_irq[i];
+		data->cpu_data[i].sum_thread = value_thread[i];
+		data->cpu_data[i].sum_user = value_user[i];
+	}
+
+	return 0;
+}
+
 /*
  * timerlat_top_header - print the header of the tool output
  */
@@ -894,6 +965,111 @@ timerlat_top_set_signals(struct timerlat_params *params)
 	}
 }
 
+/*
+ * timerlat_top_main_loop - main loop to process events
+ */
+static int
+timerlat_top_main_loop(struct osnoise_tool *top,
+		       struct osnoise_tool *record,
+		       struct timerlat_params *params,
+		       struct timerlat_u_params *params_u)
+{
+	struct trace_instance *trace = &top->trace;
+	int retval;
+
+	while (!stop_tracing) {
+		sleep(params->sleep_time);
+
+		if (params->aa_only && !osnoise_trace_is_off(top, record))
+			continue;
+
+		retval = tracefs_iterate_raw_events(trace->tep,
+						    trace->inst,
+						    NULL,
+						    0,
+						    collect_registered_events,
+						    trace);
+		if (retval < 0) {
+			err_msg("Error iterating on events\n");
+			return retval;
+		}
+
+		if (!params->quiet)
+			timerlat_print_stats(params, top);
+
+		if (osnoise_trace_is_off(top, record))
+			break;
+
+		/* is there still any user-threads ? */
+		if (params->user_workload) {
+			if (params_u->stopped_running) {
+				debug_msg("timerlat user space threads stopped!\n");
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * timerlat_top_bpf_main_loop - main loop to process events (BPF variant)
+ */
+static int
+timerlat_top_bpf_main_loop(struct osnoise_tool *top,
+			   struct osnoise_tool *record,
+			   struct timerlat_params *params,
+			   struct timerlat_u_params *params_u)
+{
+	int retval, wait_retval;
+
+	if (params->aa_only) {
+		/* Auto-analysis only, just wait for stop tracing */
+		timerlat_bpf_wait(-1);
+		return 0;
+	}
+
+	if (params->quiet) {
+		/* Quiet mode: wait for stop and then, print results */
+		timerlat_bpf_wait(-1);
+
+		retval = timerlat_top_bpf_pull_data(top);
+		if (retval) {
+			err_msg("Error pulling BPF data\n");
+			return retval;
+		}
+
+		return 0;
+	}
+
+	/* Pull and display data in a loop */
+	while (!stop_tracing) {
+		wait_retval = timerlat_bpf_wait(params->sleep_time);
+
+		retval = timerlat_top_bpf_pull_data(top);
+		if (retval) {
+			err_msg("Error pulling BPF data\n");
+			return retval;
+		}
+
+		timerlat_print_stats(params, top);
+
+		if (wait_retval == 1)
+			/* Stopping requested by tracer */
+			break;
+
+		/* is there still any user-threads ? */
+		if (params->user_workload) {
+			if (params_u->stopped_running) {
+				debug_msg("timerlat user space threads stopped!\n");
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int timerlat_top_main(int argc, char *argv[])
 {
 	struct timerlat_params *params;
@@ -908,6 +1084,7 @@ int timerlat_top_main(int argc, char *argv[])
 	char *max_lat;
 	int retval;
 	int nr_cpus, i;
+	bool no_bpf = false;
 
 	params = timerlat_top_parse_args(argc, argv);
 	if (!params)
@@ -933,6 +1110,23 @@ int timerlat_top_main(int argc, char *argv[])
 	*/
 	top_inst = trace;
 
+	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
+		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
+		no_bpf = true;
+	}
+
+	if (!no_bpf && !tep_find_event_by_name(trace->tep, "osnoise", "timerlat_sample")) {
+		debug_msg("osnoise:timerlat_sample missing, disabling BPF\n");
+		no_bpf = true;
+	}
+
+	if (!no_bpf) {
+		retval = timerlat_bpf_init(params);
+		if (retval) {
+			debug_msg("Could not enable BPF\n");
+			no_bpf = true;
+		}
+	}
 
 	retval = enable_timerlat(trace);
 	if (retval) {
@@ -1007,15 +1201,9 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 	if (!params->no_aa) {
-		if (params->aa_only) {
-			/* as top is not used for display, use it for aa */
-			aa = top;
-		} else  {
-			/* otherwise, a new instance is needed */
-			aa = osnoise_init_tool("timerlat_aa");
-			if (!aa)
-				goto out_top;
-		}
+		aa = osnoise_init_tool("timerlat_aa");
+		if (!aa)
+			goto out_top;
 
 		retval = timerlat_aa_init(aa, params->dump_tasks);
 		if (retval) {
@@ -1066,44 +1254,31 @@ int timerlat_top_main(int argc, char *argv[])
 	 */
 	if (params->trace_output)
 		trace_instance_start(&record->trace);
-	if (!params->no_aa && aa != top)
+	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
-	trace_instance_start(trace);
+	if (no_bpf) {
+		trace_instance_start(trace);
+	} else {
+		retval = timerlat_bpf_attach();
+		if (retval) {
+			err_msg("Error attaching BPF program\n");
+			goto out_top;
+		}
+	}
 
 	top->start_time = time(NULL);
 	timerlat_top_set_signals(params);
 
-	while (!stop_tracing) {
-		sleep(params->sleep_time);
+	if (no_bpf)
+		retval = timerlat_top_main_loop(top, record, params, &params_u);
+	else
+		retval = timerlat_top_bpf_main_loop(top, record, params, &params_u);
 
-		if (params->aa_only && !osnoise_trace_is_off(top, record))
-			continue;
+	if (retval)
+		goto out_top;
 
-		retval = tracefs_iterate_raw_events(trace->tep,
-						    trace->inst,
-						    NULL,
-						    0,
-						    collect_registered_events,
-						    trace);
-		if (retval < 0) {
-			err_msg("Error iterating on events\n");
-			goto out_top;
-		}
-
-		if (!params->quiet)
-			timerlat_print_stats(params, top);
-
-		if (osnoise_trace_is_off(top, record))
-			break;
-
-		/* is there still any user-threads ? */
-		if (params->user_workload) {
-			if (params_u.stopped_running) {
-				debug_msg("timerlat user space threads stopped!\n");
-				break;
-			}
-		}
-	}
+	if (!no_bpf)
+		timerlat_bpf_detach();
 
 	if (params->user_workload && !params_u.stopped_running) {
 		params_u.should_run = 0;
-- 
2.48.1

