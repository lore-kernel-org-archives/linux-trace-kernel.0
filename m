Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7528934D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442769; cv=none; b=BueZirJEnvwVVdYORZBhTjMZdws9tNnXCmfVlkFl+FeTVg1BxZRA6GmiE0G+H8mPZC0FV94tGry3YkvacpT8CrRY9n1pKHQtmX6rKXw7MmPKEOrIFjC49ib1z3PA7SF3S2ODxGV2I+fTT0dKuW+lHDxbJu7BWzq9blg5OXaPxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442769; c=relaxed/simple;
	bh=ISyB477vsWeF42Yz0SalyeZ2i4D75hkmWsj/iYuj4CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU1HnquGhesV5H9WzkdwH6eSIfRzA503lGxUTzsyvAz5BUFL1PyZYvgpfvmVtu/GHnLsQfgk8ImtrzyMIpRH5nQ0v20hiTbRNHDUzesgnqWn2EEYp1fSqnJ2OVO7cfL6UYlC+T21vwGeMlhuLr6hOghHagIg19+7VbU7nrEAA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G57TGCR7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G57TGCR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748442765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvzNszbzHtfrqe4Ama9R3Qoz9uboq2bWIkQhK85os6U=;
	b=G57TGCR75QGx1p7ZjW3xeiadarmFSEeU30tEKsa91a0TuL0F+j5Tj1AG1KN91aLuFB9pk+
	n7+n4jXoOtv9ObN1dbwxj/5xrVTJ7FSM8JR0FBVX8pe23kLA/KFpnlUU7BvEemKaVZNiul
	YPGkbfyI8kZj5+mplGKaw14p/vZzMG8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-93D2QbdFNZ2vz1SoMBxQgA-1; Wed,
 28 May 2025 10:32:43 -0400
X-MC-Unique: 93D2QbdFNZ2vz1SoMBxQgA-1
X-Mimecast-MFC-AGG-ID: 93D2QbdFNZ2vz1SoMBxQgA_1748442762
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9450B1801A08;
	Wed, 28 May 2025 14:32:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33E3819560AA;
	Wed, 28 May 2025 14:32:39 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH 2/2] rtla/timerlat: Add action on threshold
Date: Wed, 28 May 2025 16:28:58 +0200
Message-ID: <20250528142858.185017-3-tglozar@redhat.com>
In-Reply-To: <20250528142858.185017-1-tglozar@redhat.com>
References: <20250528142858.185017-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Extend the functionality provided by the -t/--trace option, which
triggers saving the contents of a tracefs buffer after tracing is
stopped, to support implementing arbitrary actions.

A new option, -A/--action-on-overflow, is added. Supported actions are:
- -A trace: Saves tracefs buffer. Same as -t.
- -A signal,num=<sig>,pid=<pid>: Sends signal to process. "parent" might
be specified instead of number to send signal to parent process.
- -A exec,command=<command>: Execute shell command.

The action is executed when tracing is stopped, at the same place as
saving the trace output. Multiple actions might be specified and will be
executed in order; however, only one action of each type is allowed.

If the action fails, the following actions are not executed. For
example, this command:

$ rtla timerlat -T 20 -A trace -A command,"grep ipi_send timerlat_output.txt" -A signal,num=2,pid=parent

will send signal 2 (SIGINT) to parent process, but only if saved trace
contains the text "ipi_send".

This way, the feature can be used for flexible reactions on latency
spikes, and allows combining rtla with other tooling like perf.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/Build           |   1 +
 tools/tracing/rtla/src/actions.c       | 155 +++++++++++++++++++++++++
 tools/tracing/rtla/src/actions.h       |  33 ++++++
 tools/tracing/rtla/src/timerlat.c      |  42 +++++++
 tools/tracing/rtla/src/timerlat.h      |   4 +-
 tools/tracing/rtla/src/timerlat_hist.c |  36 ++++--
 tools/tracing/rtla/src/timerlat_top.c  |  36 ++++--
 7 files changed, 283 insertions(+), 24 deletions(-)
 create mode 100644 tools/tracing/rtla/src/actions.c
 create mode 100644 tools/tracing/rtla/src/actions.h

diff --git a/tools/tracing/rtla/src/Build b/tools/tracing/rtla/src/Build
index 7bb7e39e391a..66631280b75b 100644
--- a/tools/tracing/rtla/src/Build
+++ b/tools/tracing/rtla/src/Build
@@ -1,5 +1,6 @@
 rtla-y += trace.o
 rtla-y += utils.o
+rtla-y += actions.o
 rtla-y += osnoise.o
 rtla-y += osnoise_top.o
 rtla-y += osnoise_hist.o
diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
new file mode 100644
index 000000000000..de3a4a031699
--- /dev/null
+++ b/tools/tracing/rtla/src/actions.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <string.h>
+
+#include "actions.h"
+
+/*
+ * action_options_init - initialize struct action_options
+ */
+void
+action_options_init(struct action_options *opts)
+{
+	opts->actions_length = 0;
+	for (int i = 0; i < ACTION_FIELD_N; i++) {
+		opts->actions[i] = ACTION_NONE;
+		opts->action_present[i] = false;
+	}
+	opts->trace_output = NULL;
+}
+
+/*
+ * action_options_destroy - destroy struct action_options
+ */
+void
+action_options_destroy(struct action_options *opts)
+{
+	if (opts->command)
+		free(opts->command);
+}
+
+/*
+ * action_add_trace_output - add an action to output trace
+ */
+int
+action_add_trace_output(struct action_options *opts, char *trace_output)
+{
+	if (opts->action_present[ACTION_TRACE_OUTPUT])
+		return 1;
+	opts->action_present[ACTION_TRACE_OUTPUT] = true;
+
+	opts->actions[opts->actions_length++] = ACTION_TRACE_OUTPUT;
+	opts->trace_output = trace_output;
+
+	return 0;
+}
+
+/*
+ * action_add_trace_output - add an action to send signal to a process
+ */
+int
+action_add_signal(struct action_options *opts, int signal, int pid)
+{
+	if (opts->action_present[ACTION_SIGNAL])
+		return 1;
+	opts->action_present[ACTION_SIGNAL] = true;
+
+	opts->actions[opts->actions_length++] = ACTION_SIGNAL;
+	opts->signal = signal;
+	opts->pid = pid;
+
+	return 0;
+}
+
+/*
+ * action_add_exec - add an action to execute a shell command
+ */
+int
+action_add_exec(struct action_options *opts, char *command)
+{
+	if (opts->action_present[ACTION_EXEC])
+		return 1;
+	opts->action_present[ACTION_EXEC] = true;
+
+	opts->actions[opts->actions_length++] = ACTION_EXEC;
+	if (opts->command)
+		free(opts->command);
+	opts->command = calloc(sizeof(char), strlen(command) + 1);
+	if (!opts->command)
+		return -1;
+	strcpy(opts->command, command);
+
+	return 0;
+}
+
+/*
+ * action_parse - add an action based on text specification
+ */
+int
+action_parse(struct action_options *opts, char *trigger)
+{
+	enum action_type type = ACTION_NONE;
+	char *token;
+	char trigger_c[strlen(trigger)];
+
+	/* For ACTION_SIGNAL */
+	int signal = 0, pid = 0;
+
+	if (opts->actions_length == ACTION_FIELD_N)
+		return -1;
+
+	strcpy(trigger_c, trigger);
+	token = strtok(trigger_c, ",");
+
+	if (strcmp(token, "trace") == 0)
+		type = ACTION_TRACE_OUTPUT;
+	else if (strcmp(token, "signal") == 0)
+		type = ACTION_SIGNAL;
+	else if (strcmp(token, "exec") == 0)
+		type = ACTION_EXEC;
+	else
+		/* Invalid trigger type */
+		return -1;
+
+	token = strtok(NULL, ",");
+
+	switch (type) {
+	case ACTION_TRACE_OUTPUT:
+		/* Takes no argument */
+		if (token != NULL)
+			return -1;
+		return action_add_trace_output(opts, "timerlat_trace.txt");
+	case ACTION_SIGNAL:
+		/* Takes two arguments, num (signal) and pid */
+		while (token != NULL) {
+			if (strlen(token) > 4 && strncmp(token, "num=", 4) == 0) {
+				signal = atoi(token + 4);
+			} else if (strlen(token) > 4 && strncmp(token, "pid=", 4) == 0) {
+				if (strncmp(token + 4, "parent", 7) == 0)
+					pid = -1;
+				else
+					pid = atoi(token + 4);
+			} else {
+				/* Invalid argument */
+				return -1;
+			}
+
+			token = strtok(NULL, ",");
+		}
+
+		if (!signal || !pid)
+			/* Missing argument */
+			return -1;
+
+		return action_add_signal(opts, signal, pid);
+	case ACTION_EXEC:
+		if (token == NULL)
+			return -1;
+		if (strlen(token) > 8 && strncmp(token, "command=", 8) == 0) {
+			return action_add_exec(opts, token + 8);
+		}
+		return -1;
+	default:
+		return -1;
+	}
+}
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
new file mode 100644
index 000000000000..70caeca9b85b
--- /dev/null
+++ b/tools/tracing/rtla/src/actions.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdbool.h>
+
+enum action_type {
+	ACTION_NONE = 0,
+	ACTION_TRACE_OUTPUT,
+	ACTION_SIGNAL,
+	ACTION_EXEC,
+	ACTION_FIELD_N
+};
+
+struct action_options {
+	enum action_type actions[ACTION_FIELD_N];
+	int actions_length;
+	bool action_present[ACTION_FIELD_N];
+
+	/* For ACTION_TRACE_OUTPUT */
+	char *trace_output;
+
+	/* For ACTION_SIGNAL */
+	int signal;
+	int pid;
+
+	/* For ACTION_COMMAND */
+	char *command;
+};
+
+void action_options_init(struct action_options *opts);
+void action_options_destroy(struct action_options *opts);
+int action_add_trace_output(struct action_options *opts, char *trace_output);
+int action_add_signal(struct action_options *opts, int signal, int pid);
+int action_add_exec(struct action_options *opts, char *command);
+int action_parse(struct action_options *opts, char *trigger);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 63d6d43eafff..98d8c4950f03 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -13,6 +13,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <sched.h>
+#include <signal.h>
 
 #include "timerlat.h"
 
@@ -126,6 +127,47 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 	return -1;
 }
 
+/*
+ * timerlat_execute_actions - execute actions at threshold overflow
+ */
+int
+timerlat_execute_actions(struct osnoise_tool *record, struct action_options *action_opts)
+{
+	int i, pid, retval;
+
+	for (i = 0; i < action_opts->actions_length; i++) {
+		switch (action_opts->actions[i]) {
+		case ACTION_TRACE_OUTPUT:
+			retval = save_trace_to_file(record->trace.inst, action_opts->trace_output);
+			if (retval) {
+				err_msg("Error saving trace\n");
+				return retval;
+			}
+			break;
+		case ACTION_SIGNAL:
+			if (action_opts->pid == -1)
+				pid = getppid();
+			else
+				pid = action_opts->pid;
+			retval = kill(pid, action_opts->signal);
+			if (retval) {
+				err_msg("Error sending signal\n");
+				return retval;
+			}
+			break;
+		case ACTION_EXEC:
+			retval = system(action_opts->command);
+			if (retval)
+				return retval;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static void timerlat_usage(int err)
 {
 	int i;
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index e0a553545d03..35d274fc2875 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "actions.h"
 #include "osnoise.h"
 
 /*
@@ -22,7 +23,6 @@ struct timerlat_params {
 	/* Common params */
 	char			*cpus;
 	cpu_set_t		monitored_cpus;
-	char			*trace_output;
 	char			*cgroup_name;
 	unsigned long long	runtime;
 	long long		stop_us;
@@ -48,6 +48,7 @@ struct timerlat_params {
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 	enum timerlat_tracing_mode mode;
+	struct action_options action_opts;
 	union {
 		struct {
 			/* top only */
@@ -69,6 +70,7 @@ struct timerlat_params {
 	};
 };
 
+int timerlat_execute_actions(struct osnoise_tool *tool, struct action_options *action_opts);
 int timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params);
 
 int timerlat_hist_main(int argc, char *argv[]);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 70548beed812..072d445782ad 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -753,6 +753,7 @@ static void timerlat_hist_usage(char *usage)
 		"						       in nanoseconds",
 		"	  -u/--user-threads: use rtla user-space threads instead of kernel-space timerlat threads",
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
+		"         -A/--action-on-overflow <action>: trigger action on threshold overflow, multiple -A are allowed",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
@@ -786,11 +787,14 @@ static struct timerlat_params
 	int auto_thresh;
 	int retval;
 	int c;
+	char *trace_output;
 
 	params = calloc(1, sizeof(*params));
 	if (!params)
 		exit(1);
 
+	action_options_init(&params->action_opts);
+
 	/* disabled by default */
 	params->dma_latency = -1;
 
@@ -807,6 +811,7 @@ static struct timerlat_params
 
 	while (1) {
 		static struct option long_options[] = {
+			{"action-on-overflow",	required_argument,	0, 'A'},
 			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"cgroup",		optional_argument,	0, 'C'},
@@ -847,7 +852,7 @@ static struct timerlat_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "A:a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -866,8 +871,15 @@ static struct timerlat_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			params->trace_output = "timerlat_trace.txt";
+			action_add_trace_output(&params->action_opts, "timerlat_trace.txt");
 
+			break;
+		case 'A':
+			retval = action_parse(&params->action_opts, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
 			break;
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->monitored_cpus);
@@ -956,13 +968,14 @@ static struct timerlat_params
 		case 't':
 			if (optarg) {
 				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
+					trace_output = &optarg[1];
 				else
-					params->trace_output = &optarg[0];
+					trace_output = &optarg[0];
 			} else if (optind < argc && argv[optind][0] != '-')
-				params->trace_output = argv[optind];
+				trace_output = argv[optind];
 			else
-				params->trace_output = "timerlat_trace.txt";
+				trace_output = "timerlat_trace.txt";
+			action_add_trace_output(&params->action_opts, trace_output);
 			break;
 		case 'u':
 			params->user_workload = 1;
@@ -1061,7 +1074,8 @@ static struct timerlat_params
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
 	 * mixed mode
 	 */
-	if (params->mode == TRACING_MODE_BPF && params->trace_output && !params->no_aa)
+	if (params->mode == TRACING_MODE_BPF &&
+	    (params->action_opts.action_present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -1254,7 +1268,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->trace_output) {
+	if (params->action_opts.action_present[ACTION_TRACE_OUTPUT]) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
@@ -1325,7 +1339,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->trace_output)
+	if (params->action_opts.action_present[ACTION_TRACE_OUTPUT])
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1395,8 +1409,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
+		timerlat_execute_actions(record, &params->action_opts);
 	}
 
 out_hist:
@@ -1417,6 +1430,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
+	action_options_destroy(&params->action_opts);
 	free(params);
 	free_cpu_idle_disable_states();
 	if (params->mode != TRACING_MODE_TRACEFS)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 30f1d6cbcad1..ab89184387b8 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -513,6 +513,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -u/--user-threads: use rtla user-space threads instead of kernel-space timerlat threads",
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
+		"         -A/--action-on-overflow <action>: trigger action on threshold overflow, multiple -A are allowed",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
@@ -545,11 +546,14 @@ static struct timerlat_params
 	long long auto_thresh;
 	int retval;
 	int c;
+	char *trace_output;
 
 	params = calloc(1, sizeof(*params));
 	if (!params)
 		exit(1);
 
+	action_options_init(&params->action_opts);
+
 	/* disabled by default */
 	params->dma_latency = -1;
 
@@ -564,6 +568,7 @@ static struct timerlat_params
 
 	while (1) {
 		static struct option long_options[] = {
+			{"action-on-overflow",  required_argument,      0, 'A'},
 			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"cgroup",		optional_argument,	0, 'C'},
@@ -598,7 +603,7 @@ static struct timerlat_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "A:a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -617,7 +622,14 @@ static struct timerlat_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			params->trace_output = "timerlat_trace.txt";
+			action_add_trace_output(&params->action_opts, "timerlat_trace.txt");
+			break;
+		case 'A':
+			retval = action_parse(&params->action_opts, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
 			break;
 		case '5':
 			/* it is here because it is similar to -a */
@@ -712,14 +724,14 @@ static struct timerlat_params
 		case 't':
 			if (optarg) {
 				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
+					trace_output = &optarg[1];
 				else
-					params->trace_output = &optarg[0];
+					trace_output = &optarg[0];
 			} else if (optind < argc && argv[optind][0] != '-')
-				params->trace_output = argv[optind];
+				trace_output = argv[optind];
 			else
-				params->trace_output = "timerlat_trace.txt";
-
+				trace_output = "timerlat_trace.txt";
+			action_add_trace_output(&params->action_opts, trace_output);
 			break;
 		case 'u':
 			params->user_workload = true;
@@ -797,7 +809,8 @@ static struct timerlat_params
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
 	 * mixed mode
 	 */
-	if (params->mode == TRACING_MODE_BPF && params->trace_output && !params->no_aa)
+	if (params->mode == TRACING_MODE_BPF &&
+	    (params->action_opts.action_present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -1099,7 +1112,7 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->trace_output) {
+	if (params->action_opts.action_present[ACTION_TRACE_OUTPUT]) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
@@ -1171,7 +1184,7 @@ int timerlat_top_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->trace_output)
+	if (params->action_opts.action_present[ACTION_TRACE_OUTPUT])
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1214,8 +1227,7 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
+		timerlat_execute_actions(record, &params->action_opts);
 	} else if (params->aa_only) {
 		/*
 		 * If the trace did not stop with --aa-only, at least print the
-- 
2.49.0

