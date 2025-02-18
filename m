Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413E26BD92
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890772; cv=none; b=ot7QPF2tHCBaGM4Hwf7j4CYFcpkXvip/gbgKdGD3Nw1kVl/AHVcJ5p4Y6HaSC/HeyqAB7p4QlRhkt0pAZkRhHokGdZnySBEQ9i/nuZDHWBIxygXfKFFs9Bswsh/b0TMObPSQ5pacfNgXuhjLoIMjQQ6x20lJ/XO5zMmoFnxFCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890772; c=relaxed/simple;
	bh=8maZ8ngfpRwK9OX04kzRSRNwfNn0i2geSTo2U3OMBl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrECEX4aBRlNAr8sNT8TbytvL9/pi9vRFgHN8kSQ6ttV/gV5r+1k0kWbNHhWA3FaFJ2iupxGDlm3aqc2r4XAD9wQUP3Vi9cDRXgLadfBXRzgTdgUhqMpiB1LY5yP+yQTMuEXBxHJwD0Wl0tH6sI1YBPxtAkSo6F+nNwdn9SVbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmPQ7kWP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmPQ7kWP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n810GFXYQhwEoh4Yo+l+JzkxPLVdP78/c81nrCjM8sA=;
	b=QmPQ7kWPEkEqdmZQ75a3m2qot4n82IqR6hCNgMNGwlSBZ9EZlwdworo6HFN7JEb9cBRTHc
	THHrEUhNsFDlOuAx+QFGa6FkW0r3xUNiQMwquGNnYqBMyANTQoJcvewDny9ofreOjW3TV6
	6hOLYx3xUw76/grbY7QS5m6bZb7np1M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-VAh_CnwqNcmb3J8pFKgasg-1; Tue,
 18 Feb 2025 09:59:28 -0500
X-MC-Unique: VAh_CnwqNcmb3J8pFKgasg-1
X-Mimecast-MFC-AGG-ID: VAh_CnwqNcmb3J8pFKgasg_1739890767
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90EEC1800984;
	Tue, 18 Feb 2025 14:59:27 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3DC11800366;
	Tue, 18 Feb 2025 14:59:24 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/8] rtla/timerlat_hist: Use BPF to collect samples
Date: Tue, 18 Feb 2025 15:58:56 +0100
Message-ID: <20250218145859.27762-6-tglozar@redhat.com>
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
measurement. Thus, instead of waking up every second to collect samples,
rtla simply sleeps until woken up by a signal or threshold overflow.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 167 +++++++++++++++++++++----
 1 file changed, 146 insertions(+), 21 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index fe683a20b0e2..202d99a598ba 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -17,6 +17,7 @@
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_u.h"
+#include "timerlat_bpf.h"
 
 struct timerlat_hist_cpu {
 	int			*irq;
@@ -193,6 +194,89 @@ timerlat_hist_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+/*
+ * timerlat_hist_bpf_pull_data - copy data from BPF maps into userspace
+ */
+static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
+{
+	struct timerlat_hist_data *data = tool->data;
+	int i, j, err;
+	long long value_irq[data->nr_cpus],
+		  value_thread[data->nr_cpus],
+		  value_user[data->nr_cpus];
+
+	/* Pull histogram */
+	for (i = 0; i < data->entries; i++) {
+		err = timerlat_bpf_get_hist_value(i, value_irq, value_thread,
+						  value_user, data->nr_cpus);
+		if (err)
+			return err;
+		for (j = 0; j < data->nr_cpus; j++) {
+			data->hist[j].irq[i] = value_irq[j];
+			data->hist[j].thread[i] = value_thread[j];
+			data->hist[j].user[i] = value_user[j];
+		}
+	}
+
+	/* Pull summary */
+	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].irq_count = value_irq[i];
+		data->hist[i].thread_count = value_thread[i];
+		data->hist[i].user_count = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].min_irq = value_irq[i];
+		data->hist[i].min_thread = value_thread[i];
+		data->hist[i].min_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].max_irq = value_irq[i];
+		data->hist[i].max_thread = value_thread[i];
+		data->hist[i].max_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].sum_irq = value_irq[i];
+		data->hist[i].sum_thread = value_thread[i];
+		data->hist[i].sum_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_OVERFLOW,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].irq[data->entries] = value_irq[i];
+		data->hist[i].thread[data->entries] = value_thread[i];
+		data->hist[i].user[data->entries] = value_user[i];
+	}
+
+	return 0;
+}
+
 /*
  * timerlat_hist_header - print the header of the tracer to the output
  */
@@ -1152,6 +1236,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	pthread_t timerlat_u;
 	int retval;
 	int nr_cpus, i;
+	bool no_bpf = false;
 
 	params = timerlat_hist_parse_args(argc, argv);
 	if (!params)
@@ -1177,6 +1262,24 @@ int timerlat_hist_main(int argc, char *argv[])
 	 */
 	hist_inst = trace;
 
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
+
 	retval = enable_timerlat(trace);
 	if (retval) {
 		err_msg("Failed to enable timerlat tracer\n");
@@ -1304,35 +1407,55 @@ int timerlat_hist_main(int argc, char *argv[])
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
-	trace_instance_start(trace);
+	if (no_bpf) {
+		trace_instance_start(trace);
+	} else {
+		retval = timerlat_bpf_attach();
+		if (retval) {
+			err_msg("Error attaching BPF program\n");
+			goto out_hist;
+		}
+	}
 
 	tool->start_time = time(NULL);
 	timerlat_hist_set_signals(params);
 
-	while (!stop_tracing) {
-		sleep(params->sleep_time);
-
-		retval = tracefs_iterate_raw_events(trace->tep,
-						    trace->inst,
-						    NULL,
-						    0,
-						    collect_registered_events,
-						    trace);
-		if (retval < 0) {
-			err_msg("Error iterating on events\n");
-			goto out_hist;
-		}
-
-		if (osnoise_trace_is_off(tool, record))
-			break;
+	if (no_bpf) {
+		while (!stop_tracing) {
+			sleep(params->sleep_time);
+
+			retval = tracefs_iterate_raw_events(trace->tep,
+							    trace->inst,
+							    NULL,
+							    0,
+							    collect_registered_events,
+							    trace);
+			if (retval < 0) {
+				err_msg("Error iterating on events\n");
+				goto out_hist;
+			}
 
-		/* is there still any user-threads ? */
-		if (params->user_workload) {
-			if (params_u.stopped_running) {
-				debug_msg("timerlat user-space threads stopped!\n");
+			if (osnoise_trace_is_off(tool, record))
 				break;
+
+			/* is there still any user-threads ? */
+			if (params->user_workload) {
+				if (params_u.stopped_running) {
+					debug_msg("timerlat user-space threads stopped!\n");
+					break;
+				}
 			}
 		}
+	} else
+		timerlat_bpf_wait(-1);
+
+	if (!no_bpf) {
+		timerlat_bpf_detach();
+		retval = timerlat_hist_bpf_pull_data(tool);
+		if (retval) {
+			err_msg("Error pulling BPF data\n");
+			goto out_hist;
+		}
 	}
 
 	if (params->user_workload && !params_u.stopped_running) {
@@ -1376,6 +1499,8 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(tool);
 	free(params);
 	free_cpu_idle_disable_states();
+	if (!no_bpf)
+		timerlat_bpf_destroy();
 out_exit:
 	exit(return_value);
 }
-- 
2.48.1

