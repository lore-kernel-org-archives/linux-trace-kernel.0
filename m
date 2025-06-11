Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF5F29ACDA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650237; cv=none; b=j/by9LFM5fKsdJ+n/Ucb85o4UezpsKDCMXkXCL7IfEopt/uBha/HUsvPHzXuYcId3qpRvGt+JohwgwVUdV122b5TIL4U0UvZAsFiyGlPrv45XO0YxW6D77qnsSZQIyW8RjPCFlfWRRn2akfkZNvNo/ryq8RMPmYdoqaFTbOfkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650237; c=relaxed/simple;
	bh=KPBFq9bSpOpVt8THvutTIbUGGi/WcUgSog0hUu3lfTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBaDLXL0cbJfdzyfFGnErwwYR+ojUVRzAtRLvGbi1iNu88NUYxXEU8J9Y5/KMurDt+6wwAjXJbypvyn2sBcDDhD+mDCEmUQ8ZgQXEZeXMheS60mJnENLEqddVxVljl07J4RM3UCs/x6+TOSskBIgorLGfL9ENmam18d6an0mfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sxt922Zt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sxt922Zt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JovY/rx/M+ovQ0uSvs7vstwdcPy8CzwU4hgWrha1Bc=;
	b=Sxt922ZtI+I3aZCxgYQFtx5whgFKkgnmLXCcGWS7X9iNgrM3AFbWLJb4nt5AmlQCHqmp0w
	Ij3DH1wHE+FLlmxYT8y0un/Gkhw1zv2IK0lRgc0jXVrtZQbjSbEqyMQ1CoBD+B5tbisQ6a
	ssr/wOb1lsgpObf9Zh9ZG+TsTe4ZHas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-9qoCHRNvPK2QEeBujRetHg-1; Wed,
 11 Jun 2025 09:57:10 -0400
X-MC-Unique: 9qoCHRNvPK2QEeBujRetHg-1
X-Mimecast-MFC-AGG-ID: 9qoCHRNvPK2QEeBujRetHg_1749650229
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A5E4180029D;
	Wed, 11 Jun 2025 13:57:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB82719560AF;
	Wed, 11 Jun 2025 13:57:05 +0000 (UTC)
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
Subject: [PATCH 2/8] rtla/timerlat: Add action on threshold feature
Date: Wed, 11 Jun 2025 15:56:38 +0200
Message-ID: <20250611135644.219127-3-tglozar@redhat.com>
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

Extend the functionality provided by the -t/--trace option, which
triggers saving the contents of a tracefs buffer after tracing is
stopped, to support implementing arbitrary actions.

A new option, -A/--on-threshold, is added, taking an argument
that further specifies the action. Actions added in this patch are:

- trace[,file=<filename>]: Saves tracefs buffer, optionally taking a
filename.
- signal,num=<sig>,pid=<pid>: Sends signal to process. "parent" might
be specified instead of number to send signal to parent process.
- shell,command=<command>: Execute shell command.

Multiple actions may be specified and will be executed in order,
including multiple actions of the same type. Trace output requested via
-t and -a now adds a trace action to the end of the list.

If an action fails, the following actions are not executed. For
example, this command:

$ rtla timerlat -T 20 -A trace \
-A shell,command="grep ipi_send timerlat_output.txt" \
-A signal,num=2,pid=parent

will send signal 2 (SIGINT) to parent process, but only if saved trace
contains the text "ipi_send".

This way, the feature can be used for flexible reactions on latency
spikes, and allows combining rtla with other tooling like perf.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/Build           |   1 +
 tools/tracing/rtla/src/actions.c       | 235 +++++++++++++++++++++++++
 tools/tracing/rtla/src/actions.h       |  49 ++++++
 tools/tracing/rtla/src/timerlat.h      |   3 +-
 tools/tracing/rtla/src/timerlat_hist.c |  42 +++--
 tools/tracing/rtla/src/timerlat_top.c  |  40 +++--
 6 files changed, 345 insertions(+), 25 deletions(-)
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
index 000000000000..63bee5bdabfd
--- /dev/null
+++ b/tools/tracing/rtla/src/actions.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "actions.h"
+#include "trace.h"
+#include "utils.h"
+
+/*
+ * actions_init - initialize struct actions
+ */
+void
+actions_init(struct actions *self)
+{
+	self->size = action_default_size;
+	self->list = calloc(self->size, sizeof(struct action));
+	self->len = 0;
+
+	memset(&self->present, 0, sizeof(self->present));
+
+	/* This has to be set by the user */
+	self->trace_output_inst = NULL;
+}
+
+/*
+ * actions_destroy - destroy struct actions
+ */
+void
+actions_destroy(struct actions *self)
+{
+	/* Free any action-specific data */
+	for (struct action *action = self->list; action < self->list + self->len; action++) {
+		if (action->type == ACTION_SHELL)
+			free(action->command);
+		if (action->type == ACTION_TRACE_OUTPUT)
+			free(action->trace_output);
+	}
+
+	/* Free action list */
+	free(self->list);
+}
+
+/*
+ * actions_new - Get pointer to new action
+ */
+static struct action *
+actions_new(struct actions *self)
+{
+	if (self->size >= self->len) {
+		self->size *= 2;
+		self->list = realloc(self->list, self->size * sizeof(struct action));
+	}
+
+	return &self->list[self->len++];
+}
+
+/*
+ * actions_add_trace_output - add an action to output trace
+ */
+int
+actions_add_trace_output(struct actions *self, const char *trace_output)
+{
+	struct action *action = actions_new(self);
+
+	self->present[ACTION_TRACE_OUTPUT] = true;
+	action->type = ACTION_TRACE_OUTPUT;
+	action->trace_output = calloc(strlen(trace_output) + 1, sizeof(char));
+	if (!action->trace_output)
+		return -1;
+	strcpy(action->trace_output, trace_output);
+
+	return 0;
+}
+
+/*
+ * actions_add_trace_output - add an action to send signal to a process
+ */
+int
+actions_add_signal(struct actions *self, int signal, int pid)
+{
+	struct action *action = actions_new(self);
+
+	self->present[ACTION_SIGNAL] = true;
+	action->type = ACTION_SIGNAL;
+	action->signal = signal;
+	action->pid = pid;
+
+	return 0;
+}
+
+/*
+ * actions_add_shell - add an action to execute a shell command
+ */
+int
+actions_add_shell(struct actions *self, const char *command)
+{
+	struct action *action = actions_new(self);
+
+	self->present[ACTION_SHELL] = true;
+	action->type = ACTION_SHELL;
+	action->command = calloc(strlen(command) + 1, sizeof(char));
+	if (!action->command)
+		return -1;
+	strcpy(action->command, command);
+
+	return 0;
+}
+
+/*
+ * actions_parse - add an action based on text specification
+ */
+int
+actions_parse(struct actions *self, const char *trigger)
+{
+	enum action_type type = ACTION_NONE;
+	char *token;
+	char trigger_c[strlen(trigger)];
+
+	/* For ACTION_SIGNAL */
+	int signal = 0, pid = 0;
+
+	/* For ACTION_TRACE_OUTPUT */
+	char *trace_output;
+
+	strcpy(trigger_c, trigger);
+	token = strtok(trigger_c, ",");
+
+	if (strcmp(token, "trace") == 0)
+		type = ACTION_TRACE_OUTPUT;
+	else if (strcmp(token, "signal") == 0)
+		type = ACTION_SIGNAL;
+	else if (strcmp(token, "shell") == 0)
+		type = ACTION_SHELL;
+	else
+		/* Invalid trigger type */
+		return -1;
+
+	token = strtok(NULL, ",");
+
+	switch (type) {
+	case ACTION_TRACE_OUTPUT:
+		/* Takes no argument */
+		if (token == NULL)
+			trace_output = "timerlat_trace.txt";
+		else {
+			if (strlen(token) > 5 && strncmp(token, "file=", 5) == 0) {
+				trace_output = token + 5;
+			} else {
+				/* Invalid argument */
+				return -1;
+			}
+
+			token = strtok(NULL, ",");
+			if (token != NULL)
+				/* Only one argument allowed */
+				return -1;
+		}
+		return actions_add_trace_output(self, trace_output);
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
+		return actions_add_signal(self, signal, pid);
+	case ACTION_SHELL:
+		if (token == NULL)
+			return -1;
+		if (strlen(token) > 8 && strncmp(token, "command=", 8) == 0)
+			return actions_add_shell(self, token + 8);
+		return -1;
+	default:
+		return -1;
+	}
+}
+
+/*
+ * actions_perform - perform all actions
+ */
+int
+actions_perform(const struct actions *self)
+{
+	int pid, retval;
+	const struct action *action;
+
+	for (action = self->list; action < self->list + self->len; action++) {
+		switch (action->type) {
+		case ACTION_TRACE_OUTPUT:
+			retval = save_trace_to_file(self->trace_output_inst, action->trace_output);
+			if (retval) {
+				err_msg("Error saving trace\n");
+				return retval;
+			}
+			break;
+		case ACTION_SIGNAL:
+			if (action->pid == -1)
+				pid = getppid();
+			else
+				pid = action->pid;
+			retval = kill(pid, action->signal);
+			if (retval) {
+				err_msg("Error sending signal\n");
+				return retval;
+			}
+			break;
+		case ACTION_SHELL:
+			retval = system(action->command);
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
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
new file mode 100644
index 000000000000..076bbff8519e
--- /dev/null
+++ b/tools/tracing/rtla/src/actions.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <tracefs.h>
+#include <stdbool.h>
+
+enum action_type {
+	ACTION_NONE = 0,
+	ACTION_TRACE_OUTPUT,
+	ACTION_SIGNAL,
+	ACTION_SHELL,
+	ACTION_FIELD_N
+};
+
+struct action {
+	enum action_type type;
+	union {
+		struct {
+			/* For ACTION_TRACE_OUTPUT */
+			char *trace_output;
+		};
+		struct {
+			/* For ACTION_SIGNAL */
+			int signal;
+			int pid;
+		};
+		struct {
+			/* For ACTION_SHELL */
+			char *command;
+		};
+	};
+};
+
+static const int action_default_size = 8;
+
+struct actions {
+	struct action *list;
+	int len, size;
+	bool present[ACTION_FIELD_N];
+
+	/* External dependencies */
+	struct tracefs_instance *trace_output_inst;
+};
+
+void actions_init(struct actions *self);
+void actions_destroy(struct actions *self);
+int actions_add_trace_output(struct actions *self, const char *trace_output);
+int actions_add_signal(struct actions *self, int signal, int pid);
+int actions_add_shell(struct actions *self, const char *command);
+int actions_parse(struct actions *self, const char *trigger);
+int actions_perform(const struct actions *self);
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index e0a553545d03..d1fcf9a97621 100644
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
+	struct actions actions;
 	union {
 		struct {
 			/* top only */
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 6cf260e8553b..06ee3d925ef9 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -753,6 +753,7 @@ static void timerlat_hist_usage(char *usage)
 		"						       in nanoseconds",
 		"	  -u/--user-threads: use rtla user-space threads instead of kernel-space timerlat threads",
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
+		"         -A/--on-threshold <action>: define action to be executed at latency threshold, multiple -A are allowed",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
@@ -786,11 +787,14 @@ static struct timerlat_params
 	int auto_thresh;
 	int retval;
 	int c;
+	char *trace_output = NULL;
 
 	params = calloc(1, sizeof(*params));
 	if (!params)
 		exit(1);
 
+	actions_init(&params->actions);
+
 	/* disabled by default */
 	params->dma_latency = -1;
 
@@ -807,6 +811,7 @@ static struct timerlat_params
 
 	while (1) {
 		static struct option long_options[] = {
+			{"on-threshold",	required_argument,	0, 'A'},
 			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"cgroup",		optional_argument,	0, 'C'},
@@ -847,8 +852,9 @@ static struct timerlat_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
-				 long_options, &option_index);
+		c = getopt_long(argc, argv,
+				"A:a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+				long_options, &option_index);
 
 		/* detect the end of the options. */
 		if (c == -1)
@@ -866,8 +872,15 @@ static struct timerlat_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			params->trace_output = "timerlat_trace.txt";
+			trace_output = "timerlat_trace.txt";
 
+			break;
+		case 'A':
+			retval = actions_parse(&params->actions, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
 			break;
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->monitored_cpus);
@@ -956,13 +969,13 @@ static struct timerlat_params
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
 			break;
 		case 'u':
 			params->user_workload = 1;
@@ -1037,6 +1050,9 @@ static struct timerlat_params
 		}
 	}
 
+	if (trace_output)
+		actions_add_trace_output(&params->actions, trace_output);
+
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
 		exit(EXIT_FAILURE);
@@ -1061,7 +1077,8 @@ static struct timerlat_params
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
 	 * mixed mode
 	 */
-	if (params->mode == TRACING_MODE_BPF && params->trace_output && !params->no_aa)
+	if (params->mode == TRACING_MODE_BPF &&
+	    (params->actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -1254,12 +1271,13 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->trace_output) {
+	if (params->actions.present[ACTION_TRACE_OUTPUT]) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
 			goto out_free;
 		}
+		params->actions.trace_output_inst = record->trace.inst;
 
 		if (params->events) {
 			retval = trace_events_enable(&record->trace, params->events);
@@ -1325,7 +1343,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->trace_output)
+	if (params->actions.present[ACTION_TRACE_OUTPUT])
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1395,8 +1413,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
+		actions_perform(&params->actions);
 		return_value = FAILED;
 	}
 
@@ -1418,6 +1435,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
+	actions_destroy(&params->actions);
 	if (params->mode != TRACING_MODE_TRACEFS)
 		timerlat_bpf_destroy();
 	free(params);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1644eeb60181..fa1072c0d126 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -513,6 +513,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -u/--user-threads: use rtla user-space threads instead of kernel-space timerlat threads",
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
+		"	  -A/--on-threshold <action>: define action to be executed at latency threshold, multiple -A are allowed",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
@@ -545,11 +546,14 @@ static struct timerlat_params
 	long long auto_thresh;
 	int retval;
 	int c;
+	char *trace_output = NULL;
 
 	params = calloc(1, sizeof(*params));
 	if (!params)
 		exit(1);
 
+	actions_init(&params->actions);
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
+			trace_output = "timerlat_trace.txt";
+			break;
+		case 'A':
+			retval = actions_parse(&params->actions, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
 			break;
 		case '5':
 			/* it is here because it is similar to -a */
@@ -712,14 +724,13 @@ static struct timerlat_params
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
 			break;
 		case 'u':
 			params->user_workload = true;
@@ -776,6 +787,9 @@ static struct timerlat_params
 		}
 	}
 
+	if (trace_output)
+		actions_add_trace_output(&params->actions, trace_output);
+
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
 		exit(EXIT_FAILURE);
@@ -797,7 +811,8 @@ static struct timerlat_params
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
 	 * mixed mode
 	 */
-	if (params->mode == TRACING_MODE_BPF && params->trace_output && !params->no_aa)
+	if (params->mode == TRACING_MODE_BPF &&
+	    (params->actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -1099,12 +1114,13 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->trace_output) {
+	if (params->actions.present[ACTION_TRACE_OUTPUT]) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
 			goto out_free;
 		}
+		params->actions.trace_output_inst = record->trace.inst;
 
 		if (params->events) {
 			retval = trace_events_enable(&record->trace, params->events);
@@ -1171,7 +1187,7 @@ int timerlat_top_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->trace_output)
+	if (params->actions.present[ACTION_TRACE_OUTPUT])
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1214,8 +1230,7 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
+		actions_perform(&params->actions);
 		return_value = FAILED;
 	} else if (params->aa_only) {
 		/*
@@ -1248,6 +1263,7 @@ int timerlat_top_main(int argc, char *argv[])
 		osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
+	actions_destroy(&params->actions);
 	if (params->mode != TRACING_MODE_TRACEFS)
 		timerlat_bpf_destroy();
 	free(params);
-- 
2.49.0

