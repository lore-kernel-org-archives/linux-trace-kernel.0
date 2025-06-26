Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E052E425A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Jun 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941388; cv=none; b=u3JyyxqnXFokAcLkKMSi2uODtFT5dijQoeA9dyZjEXTLJJA07Kcq/dBDNud4S/6LTR+VnefwAouZwIFM5rF+BEjJis4hqFpDdTsHjwyVyyXakhswyZP1Prgd9uB2abSfFKDECd7veIINTa48A3mmHfdLFW62U9meAQ/sN+7cRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941388; c=relaxed/simple;
	bh=72wucJGD61ASXRvziRF37YPvfvCkBbclhcdwDvqUTsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeaScQEag7wJv30UqFnSv66XMkVSP/llW73UdJ1yGxoe5W5pk/iq9hFvRtOCZQI8voaz5fJTauhrTP3xTdjtMv9KNhmcByWMVOwFfKUmg13IROIEHnkcUhkEn+tLu2hdQgrLRCEXUdzahBGujze3hgoAPrLUMuq1lrUPhaIdFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrC8uNhH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrC8uNhH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMJg0dH4UPkLa1Hf7lH56pyNZrxSWYtoTrC2yVPM9go=;
	b=SrC8uNhHcDky6R2fEsGsa84Q+Bq8IwIMHVCttYnkGQtdLyrbt/vaSJ+k//XmlGpmUhTuZI
	Jqam32vyN5WgXsFWOuktN7X3mFnnkA6NkXYW9BX5aYT0ZsIjrseDpDN6OYrgeib/3Pd/F1
	6o//w7ALwln+mG9CU0JsEKx9XxOm8fU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-3f56Zdm0M2OV4FIVE3J4eQ-1; Thu,
 26 Jun 2025 08:36:24 -0400
X-MC-Unique: 3f56Zdm0M2OV4FIVE3J4eQ-1
X-Mimecast-MFC-AGG-ID: 3f56Zdm0M2OV4FIVE3J4eQ_1750941383
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BA5419560B9;
	Thu, 26 Jun 2025 12:36:23 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.241])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18B1B18003FC;
	Thu, 26 Jun 2025 12:36:18 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 5/9] rtla/timerlat: Add action on end feature
Date: Thu, 26 Jun 2025 14:34:01 +0200
Message-ID: <20250626123405.1496931-6-tglozar@redhat.com>
In-Reply-To: <20250626123405.1496931-1-tglozar@redhat.com>
References: <20250626123405.1496931-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Implement actions on end next to actions on threshold. A new option,
--on-end is added, parallel to --on-threshold. Instead of being
executed whenever a latency threshold is reached, it is executed at the
end of the measurement.

For example:

$ rtla timerlat hist -d 5s --on-end trace

will save the trace output at the end.

All actions supported by --on-threshold are also supported by --on-end,
except for continue, which does nothing with --on-end.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.h      |  5 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 44 +++++++++++++++++--------
 tools/tracing/rtla/src/timerlat_top.c  | 45 ++++++++++++++++++--------
 3 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index d1fcf9a97621..bc55ed04fc96 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -48,7 +48,10 @@ struct timerlat_params {
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 	enum timerlat_tracing_mode mode;
-	struct actions actions;
+
+	struct actions threshold_actions;
+	struct actions end_actions;
+
 	union {
 		struct {
 			/* top only */
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4f13a8f92711..9baea1b251ed 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -758,6 +758,7 @@ static void timerlat_hist_usage(char *usage)
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
+		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
 		NULL,
 	};
 
@@ -793,7 +794,8 @@ static struct timerlat_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->actions);
+	actions_init(&params->threshold_actions);
+	actions_init(&params->end_actions);
 
 	/* disabled by default */
 	params->dma_latency = -1;
@@ -846,6 +848,7 @@ static struct timerlat_params
 			{"trace-buffer-size",	required_argument,	0, '\3'},
 			{"deepest-idle-state",	required_argument,	0, '\4'},
 			{"on-threshold",	required_argument,	0, '\5'},
+			{"on-end",		required_argument,	0, '\6'},
 			{0, 0, 0, 0}
 		};
 
@@ -1038,7 +1041,14 @@ static struct timerlat_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '\5':
-			retval = actions_parse(&params->actions, optarg);
+			retval = actions_parse(&params->threshold_actions, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '\6':
+			retval = actions_parse(&params->end_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
@@ -1050,7 +1060,7 @@ static struct timerlat_params
 	}
 
 	if (trace_output)
-		actions_add_trace_output(&params->actions, trace_output);
+		actions_add_trace_output(&params->threshold_actions, trace_output);
 
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
@@ -1077,7 +1087,8 @@ static struct timerlat_params
 	 * mixed mode
 	 */
 	if (params->mode == TRACING_MODE_BPF &&
-	    (params->actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
+	    (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	     params->end_actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -1270,13 +1281,15 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->actions.present[ACTION_TRACE_OUTPUT]) {
+	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
 			goto out_free;
 		}
-		params->actions.trace_output_inst = record->trace.inst;
+		params->threshold_actions.trace_output_inst = record->trace.inst;
+		params->end_actions.trace_output_inst = record->trace.inst;
 
 		if (params->events) {
 			retval = trace_events_enable(&record->trace, params->events);
@@ -1342,7 +1355,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->actions.present[ACTION_TRACE_OUTPUT])
+	if (record)
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1375,14 +1388,14 @@ int timerlat_hist_main(int argc, char *argv[])
 			}
 
 			if (osnoise_trace_is_off(tool, record)) {
-				actions_perform(&params->actions);
+				actions_perform(&params->threshold_actions);
 
-				if (!params->actions.continue_flag)
+				if (!params->threshold_actions.continue_flag)
 					/* continue flag not set, break */
 					break;
 
 				/* continue action reached, re-enable tracing */
-				if (params->actions.present[ACTION_TRACE_OUTPUT])
+				if (record)
 					trace_instance_start(&record->trace);
 				if (!params->no_aa)
 					trace_instance_start(&aa->trace);
@@ -1403,14 +1416,14 @@ int timerlat_hist_main(int argc, char *argv[])
 
 			if (!stop_tracing) {
 				/* Threshold overflow, perform actions on threshold */
-				actions_perform(&params->actions);
+				actions_perform(&params->threshold_actions);
 
-				if (!params->actions.continue_flag)
+				if (!params->threshold_actions.continue_flag)
 					/* continue flag not set, break */
 					break;
 
 				/* continue action reached, re-enable tracing */
-				if (params->actions.present[ACTION_TRACE_OUTPUT])
+				if (record)
 					trace_instance_start(&record->trace);
 				if (!params->no_aa)
 					trace_instance_start(&aa->trace);
@@ -1435,6 +1448,8 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	timerlat_print_stats(params, tool);
 
+	actions_perform(&params->end_actions);
+
 	return_value = PASSED;
 
 	if (osnoise_trace_is_off(tool, record) && !stop_tracing) {
@@ -1464,7 +1479,8 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
-	actions_destroy(&params->actions);
+	actions_destroy(&params->threshold_actions);
+	actions_destroy(&params->end_actions);
 	if (params->mode != TRACING_MODE_TRACEFS)
 		timerlat_bpf_destroy();
 	free(params);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 60f9c78cb272..c80b81c0b4da 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -517,6 +517,7 @@ static void timerlat_top_usage(char *usage)
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
+		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
 		NULL,
 	};
 
@@ -552,7 +553,8 @@ static struct timerlat_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->actions);
+	actions_init(&params->threshold_actions);
+	actions_init(&params->end_actions);
 
 	/* disabled by default */
 	params->dma_latency = -1;
@@ -597,6 +599,7 @@ static struct timerlat_params
 			{"trace-buffer-size",	required_argument,	0, '7'},
 			{"deepest-idle-state",	required_argument,	0, '8'},
 			{"on-threshold",	required_argument,	0, '9'},
+			{"on-end",		required_argument,	0, '\1'},
 			{0, 0, 0, 0}
 		};
 
@@ -623,6 +626,7 @@ static struct timerlat_params
 
 			/* set trace */
 			trace_output = "timerlat_trace.txt";
+
 			break;
 		case '5':
 			/* it is here because it is similar to -a */
@@ -776,7 +780,14 @@ static struct timerlat_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '9':
-			retval = actions_parse(&params->actions, optarg);
+			retval = actions_parse(&params->threshold_actions, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '\1':
+			retval = actions_parse(&params->end_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
@@ -788,7 +799,7 @@ static struct timerlat_params
 	}
 
 	if (trace_output)
-		actions_add_trace_output(&params->actions, trace_output);
+		actions_add_trace_output(&params->threshold_actions, trace_output);
 
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
@@ -812,7 +823,8 @@ static struct timerlat_params
 	 * mixed mode
 	 */
 	if (params->mode == TRACING_MODE_BPF &&
-	    (params->actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
+	    (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	     params->end_actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -934,14 +946,14 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 			timerlat_print_stats(params, top);
 
 		if (osnoise_trace_is_off(top, record)) {
-			actions_perform(&params->actions);
+			actions_perform(&params->threshold_actions);
 
-			if (!params->actions.continue_flag)
+			if (!params->threshold_actions.continue_flag)
 				/* continue flag not set, break */
 				break;
 
 			/* continue action reached, re-enable tracing */
-			if (params->actions.present[ACTION_TRACE_OUTPUT])
+			if (record)
 				trace_instance_start(&record->trace);
 			if (!params->no_aa)
 				trace_instance_start(&aa->trace);
@@ -993,14 +1005,14 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 
 		if (wait_retval == 1) {
 			/* Stopping requested by tracer */
-			actions_perform(&params->actions);
+			actions_perform(&params->threshold_actions);
 
-			if (!params->actions.continue_flag)
+			if (!params->threshold_actions.continue_flag)
 				/* continue flag not set, break */
 				break;
 
 			/* continue action reached, re-enable tracing */
-			if (params->actions.present[ACTION_TRACE_OUTPUT])
+			if (record)
 				trace_instance_start(&record->trace);
 			if (!params->no_aa)
 				trace_instance_start(&aa->trace);
@@ -1128,13 +1140,15 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->actions.present[ACTION_TRACE_OUTPUT]) {
+	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
 			goto out_free;
 		}
-		params->actions.trace_output_inst = record->trace.inst;
+		params->threshold_actions.trace_output_inst = record->trace.inst;
+		params->end_actions.trace_output_inst = record->trace.inst;
 
 		if (params->events) {
 			retval = trace_events_enable(&record->trace, params->events);
@@ -1201,7 +1215,7 @@ int timerlat_top_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->actions.present[ACTION_TRACE_OUTPUT])
+	if (record)
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1236,6 +1250,8 @@ int timerlat_top_main(int argc, char *argv[])
 
 	timerlat_print_stats(params, top);
 
+	actions_perform(&params->end_actions);
+
 	return_value = PASSED;
 
 	if (osnoise_trace_is_off(top, record) && !stop_tracing) {
@@ -1276,7 +1292,8 @@ int timerlat_top_main(int argc, char *argv[])
 		osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
-	actions_destroy(&params->actions);
+	actions_destroy(&params->threshold_actions);
+	actions_destroy(&params->end_actions);
 	if (params->mode != TRACING_MODE_TRACEFS)
 		timerlat_bpf_destroy();
 	free(params);
-- 
2.49.0

