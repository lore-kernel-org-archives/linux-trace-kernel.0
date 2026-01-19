Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E610031984E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823590; cv=none; b=cFONPHXmys3o+2Y+jnbffP5/0d20XfuCRFpBxi1DPeXWLDVA9D+CUzZwuDsSf2HW0Q36j2SsvlbjBVmw9gqXTAUuhUGpAtCZG1ZGPF2TdxP1fDbphMQ4TJEzZQ5yJiY/wOxxsSYV5rCwEY8PKiVNAnt2Cpoe80d/bOSpysVfVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823590; c=relaxed/simple;
	bh=+SiSoTaJ/rmYQVIXNJBErZzh2HjgmE2wtuUefOHUm3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5WKNfqsTIPS25N9NE2pi1n2CRnaCQDSXSfcZ7Z3aAlDjbt/0+03pq/rlHC6uhw7Jwgjh1zTTQ/S1pUe70cU55cErK/7iA/NKeE2T5Rw7UA6TZjQoCWhBVdX0JqBE1RnPWvtSQSHgPjo+2Q7imx1XkZ8fRFQ9WlEe7+Krr9nfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nb7Pj1LB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nb7Pj1LB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768823584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IghXUD+O0nV0MsE/PPOJl4tb9JhdnNfnzbv4WtW3eJU=;
	b=Nb7Pj1LBp9GkQv9L/JX90+SLsmsnyq6yJvkdzOq0FReMBmNf4jgVFtFm/ew2ToKq4yBQrt
	tUB3NjBVjb5EtuqDqbnUbkld+Ms1z+wFUhGRiKBLVoNWcNmfLFjp0Yh0+ySwH3Atx17YKw
	tDxudXZot8ubGfcyVRDrXE4B6unEQLM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-avQbWf8rPumQkbnCIHsQ6Q-1; Mon,
 19 Jan 2026 06:53:02 -0500
X-MC-Unique: avQbWf8rPumQkbnCIHsQ6Q-1
X-Mimecast-MFC-AGG-ID: avQbWf8rPumQkbnCIHsQ6Q_1768823581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6420918011D0;
	Mon, 19 Jan 2026 11:52:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3017630002D2;
	Mon, 19 Jan 2026 11:52:49 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 1/2] rtla/timerlat: Add --stack-format option
Date: Mon, 19 Jan 2026 12:52:21 +0100
Message-ID: <20260119115222.744150-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In the current implementation, the auto-analysis code for printing the
stack captured in the tracefs buffer of the aa instance stops at the
first encountered address that cannot be resolved into a function
symbol.

This is not always the desired behavior on all platforms; sometimes,
there might be resolvable entries after unresolvable ones, and
sometimes, the user might want to inspect the raw pointers for the
unresolvable entries.

Add a new option, --stack-format, with three values:

- truncate: stop at first unresolvable entry. This is the current
  behavior, and is kept as the default.
- skip: skip unresolvable entries, but do not stop on them.
- full: print all entries, including unresolvable ones.

To make this work, the "size" field of the stack entry is now also read
and used as the maximum number of entries to print, capped at 64, since
that is the fixed length of the "caller" field.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.c      |  2 +-
 tools/tracing/rtla/src/timerlat.h      |  1 +
 tools/tracing/rtla/src/timerlat_aa.c   | 36 +++++++++++++++++++++-----
 tools/tracing/rtla/src/timerlat_aa.h   |  2 +-
 tools/tracing/rtla/src/timerlat_hist.c | 10 +++++++
 tools/tracing/rtla/src/timerlat_top.c  | 10 +++++++
 tools/tracing/rtla/src/utils.c         | 18 +++++++++++++
 tools/tracing/rtla/src/utils.h         |  7 +++++
 8 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 8f8811f7a13b..9e4daed0aafc 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -134,7 +134,7 @@ int timerlat_enable(struct osnoise_tool *tool)
 		if (!tool->aa)
 			return -1;
 
-		retval = timerlat_aa_init(tool->aa, params->dump_tasks);
+		retval = timerlat_aa_init(tool->aa, params->dump_tasks, params->stack_format);
 		if (retval) {
 			err_msg("Failed to enable the auto analysis instance\n");
 			return retval;
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 8dd5d134ce08..364203a29abd 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -28,6 +28,7 @@ struct timerlat_params {
 	int			deepest_idle_state;
 	enum timerlat_tracing_mode mode;
 	const char		*bpf_action_program;
+	enum stack_format	stack_format;
 };
 
 #define to_timerlat_params(ptr) container_of(ptr, struct timerlat_params, common)
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 31e66ea2b144..178de60dcef9 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -104,6 +104,7 @@ struct timerlat_aa_data {
 struct timerlat_aa_context {
 	int nr_cpus;
 	int dump_tasks;
+	enum stack_format stack_format;
 
 	/* per CPU data */
 	struct timerlat_aa_data *taa_data;
@@ -481,23 +482,43 @@ static int timerlat_aa_stack_handler(struct trace_seq *s, struct tep_record *rec
 {
 	struct timerlat_aa_context *taa_ctx = timerlat_aa_get_ctx();
 	struct timerlat_aa_data *taa_data = timerlat_aa_get_data(taa_ctx, record->cpu);
+	enum stack_format stack_format = taa_ctx->stack_format;
 	unsigned long *caller;
 	const char *function;
-	int val, i;
+	int val;
+	unsigned long long i;
 
 	trace_seq_reset(taa_data->stack_seq);
 
 	trace_seq_printf(taa_data->stack_seq, "    Blocking thread stack trace\n");
 	caller = tep_get_field_raw(s, event, "caller", record, &val, 1);
+
 	if (caller) {
-		for (i = 0; ; i++) {
+		unsigned long long size;
+		unsigned long long max_entries;
+
+		if (tep_get_field_val(s, event, "size", record, &size, 1) == 0)
+			max_entries = size < 64 ? size : 64;
+		else
+			max_entries = 64;
+
+		for (i = 0; i < max_entries; i++) {
 			function = tep_find_function(taa_ctx->tool->trace.tep, caller[i]);
-			if (!function)
-				break;
-			trace_seq_printf(taa_data->stack_seq, " %.*s -> %s\n",
-					 14, spaces, function);
+			if (!function) {
+				if (stack_format == STACK_FORMAT_TRUNCATE)
+					break;
+				else if (stack_format == STACK_FORMAT_SKIP)
+					continue;
+				else if (stack_format == STACK_FORMAT_FULL)
+					trace_seq_printf(taa_data->stack_seq, " %.*s -> 0x%lx\n",
+						     14, spaces, caller[i]);
+			} else {
+				trace_seq_printf(taa_data->stack_seq, " %.*s -> %s\n",
+						 14, spaces, function);
+			}
 		}
 	}
+
 	return 0;
 }
 
@@ -1020,7 +1041,7 @@ void timerlat_aa_destroy(void)
  *
  * Returns 0 on success, -1 otherwise.
  */
-int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks)
+int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks, enum stack_format stack_format)
 {
 	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct timerlat_aa_context *taa_ctx;
@@ -1035,6 +1056,7 @@ int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks)
 	taa_ctx->nr_cpus = nr_cpus;
 	taa_ctx->tool = tool;
 	taa_ctx->dump_tasks = dump_tasks;
+	taa_ctx->stack_format = stack_format;
 
 	taa_ctx->taa_data = calloc(nr_cpus, sizeof(*taa_ctx->taa_data));
 	if (!taa_ctx->taa_data)
diff --git a/tools/tracing/rtla/src/timerlat_aa.h b/tools/tracing/rtla/src/timerlat_aa.h
index cea4bb1531a8..a11b5f30cdce 100644
--- a/tools/tracing/rtla/src/timerlat_aa.h
+++ b/tools/tracing/rtla/src/timerlat_aa.h
@@ -3,7 +3,7 @@
  * Copyright (C) 2023 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
-int timerlat_aa_init(struct osnoise_tool *tool, int dump_task);
+int timerlat_aa_init(struct osnoise_tool *tool, int dump_task, enum stack_format stack_format);
 void timerlat_aa_destroy(void);
 
 void timerlat_auto_analysis(int irq_thresh, int thread_thresh);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4e8c38a61197..e5b3d4f098b2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -747,6 +747,7 @@ static void timerlat_hist_usage(void)
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
 		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
 		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
+		"	     --stack-format <format>: set the stack format (truncate, skip, full)",
 		NULL,
 	};
 
@@ -787,6 +788,9 @@ static struct common_params
 	/* default to BPF mode */
 	params->mode = TRACING_MODE_BPF;
 
+	/* default to truncate stack format */
+	params->stack_format = STACK_FORMAT_TRUNCATE;
+
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
@@ -819,6 +823,7 @@ static struct common_params
 			{"on-threshold",	required_argument,	0, '\5'},
 			{"on-end",		required_argument,	0, '\6'},
 			{"bpf-action",		required_argument,	0, '\7'},
+			{"stack-format",	required_argument,	0, '\10'},
 			{0, 0, 0, 0}
 		};
 
@@ -966,6 +971,11 @@ static struct common_params
 		case '\7':
 			params->bpf_action_program = optarg;
 			break;
+		case '\10':
+			params->stack_format = parse_stack_format(optarg);
+			if (params->stack_format == -1)
+				fatal("Invalid --stack-format option");
+			break;
 		default:
 			fatal("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 284b74773c2b..d6ce7dcb8e82 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -518,6 +518,7 @@ static void timerlat_top_usage(void)
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
 		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
 		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
+		"	     --stack-format <format>: set the stack format (truncate, skip, full)",
 		NULL,
 	};
 
@@ -556,6 +557,9 @@ static struct common_params
 	/* default to BPF mode */
 	params->mode = TRACING_MODE_BPF;
 
+	/* default to truncate stack format */
+	params->stack_format = STACK_FORMAT_TRUNCATE;
+
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
@@ -582,6 +586,7 @@ static struct common_params
 			{"on-threshold",	required_argument,	0, '9'},
 			{"on-end",		required_argument,	0, '\1'},
 			{"bpf-action",		required_argument,	0, '\2'},
+			{"stack-format",	required_argument,	0, '\3'},
 			{0, 0, 0, 0}
 		};
 
@@ -716,6 +721,11 @@ static struct common_params
 		case '\2':
 			params->bpf_action_program = optarg;
 			break;
+		case '\3':
+			params->stack_format = parse_stack_format(optarg);
+			if (params->stack_format == -1)
+				fatal("Invalid --stack-format option");
+			break;
 		default:
 			fatal("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 0da3b2470c31..d979159f6b70 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -164,6 +164,24 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 	return 1;
 }
 
+/*
+ * parse_stack_format - parse the stack format
+ *
+ * Return: the stack format on success, -1 otherwise.
+ */
+int parse_stack_format(char *arg)
+{
+	if (!strcmp(arg, "truncate"))
+		return STACK_FORMAT_TRUNCATE;
+	if (!strcmp(arg, "skip"))
+		return STACK_FORMAT_SKIP;
+	if (!strcmp(arg, "full"))
+		return STACK_FORMAT_FULL;
+
+	debug_msg("Error parsing the stack format %s\n", arg);
+	return -1;
+}
+
 /*
  * parse_duration - parse duration with s/m/h/d suffix converting it to seconds
  */
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index f7c2a52a0ab5..80d5ec0cf934 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -62,8 +62,15 @@ struct sched_attr {
 };
 #endif /* SCHED_ATTR_SIZE_VER0 */
 
+enum stack_format {
+	STACK_FORMAT_TRUNCATE,
+	STACK_FORMAT_SKIP,
+	STACK_FORMAT_FULL
+};
+
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int parse_cpu_set(char *cpu_list, cpu_set_t *set);
+int parse_stack_format(char *arg);
 int __set_sched_attr(int pid, struct sched_attr *attr);
 int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
-- 
2.52.0

