Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13B29551E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650249; cv=none; b=oiie0uU/sirJBEQ9l18Z390bbVic4/cKrRpMMW2jRhzYcaUiEqY1ZT4i8naSmXBWXFO47H2SgzaQMB77bG5yKfD7WlC2xsPf6pihF39ezkWA40TidP0P74uNt0CNQBiAoUjXCmyQO5zm0H+FGwM0RfusAq7vDIppUb5oNh5Upks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650249; c=relaxed/simple;
	bh=dnqY09qNZp4Xr7NvJmfW7/KxRZKf+JbZCfUste3bVu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUgntMOy8u+qAoajYAY6acqxdwO11z9WoAUOm6fpe+xq0T1vKOiptiJWdmTNNK2cJzMrJgZpD7sjYUJ+GMn7gM6vXPftkLTAg6nnn/s6oVAE2K+4G5Hv8zGTb0IVtT/Bz5el4XZ4PxEKimBpU7TlPDTAWyOxuMARxkaxAbsb7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmiWWyEX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmiWWyEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3cGoNH2Y3CS+dkV9i+BhnoSsZ6NTHRWJM21OtOTSXs=;
	b=GmiWWyEXpfDNuw9L8sjtNPVRWvAFcwJw0IyMnFwVNxR8hH3XNGzvSNhtWg5tSzXCTh0lHH
	PLZdSe/wMo9wG1re2hqpQ8dG8sUwsIPtvzc0MQYpYMXFWbEmfrZ/2iCZjeX7CHUYYIcYfM
	gpnUmVM/ia+7bGWPB9VWY7vSfd//TYs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-knY3GOFhP6-lfs3tUIq2Dg-1; Wed,
 11 Jun 2025 09:57:21 -0400
X-MC-Unique: knY3GOFhP6-lfs3tUIq2Dg-1
X-Mimecast-MFC-AGG-ID: knY3GOFhP6-lfs3tUIq2Dg_1749650240
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 904531808985;
	Wed, 11 Jun 2025 13:57:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48FDE19560A3;
	Wed, 11 Jun 2025 13:57:17 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/8] rtla/timerlat: Add action on end feature
Date: Wed, 11 Jun 2025 15:56:41 +0200
Message-ID: <20250611135644.219127-6-tglozar@redhat.com>
In-Reply-To: <20250611135644.219127-1-tglozar@redhat.com>
References: <20250611135644.219127-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Implement actions on end next to actions on threshold. A new option,
-N/--on-end is added, parallel to -A/--on-threshold. Instead of being
executed whenever a latency threshold is reached, it is executed at the
end of the measurement.

For example:

$ rtla timerlat hist -d 5s -N trace

will save the trace output at the end.

All actions supported by -A are also supported by -N, except for
continue, which does nothing with -N.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.h      |  5 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 46 +++++++++++++++++--------
 tools/tracing/rtla/src/timerlat_top.c  | 47 ++++++++++++++++++--------
 3 files changed, 67 insertions(+), 31 deletions(-)

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
index 1feae978344b..1b4d5ddaa676 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -754,6 +754,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -u/--user-threads: use rtla user-space threads instead of kernel-space timerlat threads",
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"         -A/--on-threshold <action>: define action to be executed at latency threshold, multiple -A are allowed",
+		"	  -N/--on-end: define action to be executed at measurement end, multiple -N are allowed"
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
@@ -793,7 +794,8 @@ static struct timerlat_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->actions);
+	actions_init(&params->threshold_actions);
+	actions_init(&params->end_actions);
 
 	/* disabled by default */
 	params->dma_latency = -1;
@@ -822,6 +824,7 @@ static struct timerlat_params
 			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
+			{"on-end",		required_argument,	0, 'N'},
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
 			{"priority",		required_argument,	0, 'P'},
@@ -853,7 +856,7 @@ static struct timerlat_params
 		int option_index = 0;
 
 		c = getopt_long(argc, argv,
-				"A:a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+				"A:a:c:C::b:d:e:E:DhH:i:kN:np:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -876,7 +879,7 @@ static struct timerlat_params
 
 			break;
 		case 'A':
-			retval = actions_parse(&params->actions, optarg);
+			retval = actions_parse(&params->threshold_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
@@ -946,6 +949,13 @@ static struct timerlat_params
 		case 'k':
 			params->kernel_workload = 1;
 			break;
+		case 'N':
+			retval = actions_parse(&params->end_actions, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		case 'n':
 			params->output_divisor = 1;
 			break;
@@ -1051,7 +1061,7 @@ static struct timerlat_params
 	}
 
 	if (trace_output)
-		actions_add_trace_output(&params->actions, trace_output);
+		actions_add_trace_output(&params->threshold_actions, trace_output);
 
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
@@ -1078,7 +1088,8 @@ static struct timerlat_params
 	 * mixed mode
 	 */
 	if (params->mode == TRACING_MODE_BPF &&
-	    (params->actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
+	    (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	     params->end_actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -1271,13 +1282,15 @@ int timerlat_hist_main(int argc, char *argv[])
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
@@ -1343,7 +1356,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->actions.present[ACTION_TRACE_OUTPUT])
+	if (record)
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1376,14 +1389,14 @@ int timerlat_hist_main(int argc, char *argv[])
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
@@ -1404,14 +1417,14 @@ int timerlat_hist_main(int argc, char *argv[])
 
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
@@ -1436,6 +1449,8 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	timerlat_print_stats(params, tool);
 
+	actions_perform(&params->end_actions);
+
 	return_value = PASSED;
 
 	if (osnoise_trace_is_off(tool, record) && !stop_tracing) {
@@ -1465,7 +1480,8 @@ int timerlat_hist_main(int argc, char *argv[])
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
index ff0e6a7c3a1b..f022fbd9435e 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -514,6 +514,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	  -A/--on-threshold <action>: define action to be executed at latency threshold, multiple -A are allowed",
+		"	  -N/--on-end: define action to be executed at measurement end, multiple -N are allowed"
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
@@ -552,7 +553,8 @@ static struct timerlat_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->actions);
+	actions_init(&params->threshold_actions);
+	actions_init(&params->end_actions);
 
 	/* disabled by default */
 	params->dma_latency = -1;
@@ -578,6 +580,7 @@ static struct timerlat_params
 			{"help",		no_argument,		0, 'h'},
 			{"house-keeping",	required_argument,	0, 'H'},
 			{"irq",			required_argument,	0, 'i'},
+			{"on-end",		required_argument,	0, 'N'},
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
 			{"priority",		required_argument,	0, 'P'},
@@ -603,7 +606,7 @@ static struct timerlat_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "A:a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "A:a:c:C::d:De:hH:i:kN:np:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -623,9 +626,10 @@ static struct timerlat_params
 
 			/* set trace */
 			trace_output = "timerlat_trace.txt";
+
 			break;
 		case 'A':
-			retval = actions_parse(&params->actions, optarg);
+			retval = actions_parse(&params->threshold_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
@@ -698,6 +702,13 @@ static struct timerlat_params
 		case 'k':
 			params->kernel_workload = true;
 			break;
+		case 'N':
+			retval = actions_parse(&params->end_actions, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		case 'n':
 			params->output_divisor = 1;
 			break;
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

