Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4967081E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826860; cv=none; b=bvt8smSRiE41PobG2j0YZMhRd3cJvb6JbvcyhF0+uFZH3xhVViN+u5dEhG3ei07hX/L+902FO2WiOoGRZLHsa5bTEqU2s4TbMgpY+HVC98HvdcPaNK8kcltUqqrk/K7tXb5XbTqOWZuqKpWZbvQoEJUK0sbhOUZ1oWAPp6EWwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826860; c=relaxed/simple;
	bh=S/SKHxHdcMr1QfdvIXxApGtmWBodmKNCEKaTN0iTkn4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PnfeT0zxrLfKeMUD7Z7IF6A7iM+3sby3WAktB5WUFWwwpqW4O5bdkRACqsUOO4bw+qoFQwKQm1wz4pVzAeTllBWZp3mle+g+6HqqrCrEdGw2KETE5J5g5LoPWAaE8FGjDBRBb5QIa5XqfUgvP/hCpYZBs/qsibDGMaed00xCcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dp2CnDk3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dp2CnDk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772826857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCk5SXr8JRhBJjx3kalF2SaqtbteDwoDGZPqMuj8Nbw=;
	b=Dp2CnDk3zJC5wCVscOtI3ERbQd59eVugcZ48QYnuaiPLrevL9c7JWLyAOzSDh7whv5cbLO
	bvUxCRKsbamTw9Yi/K/RbJx/7knOnNZHZX58Quwi8TglvHMPxCQr+BrAoI0rUq496IaBJE
	9kEUYWJ2BPccYogyOJ2GQ9mRLP2sC7o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-YHmB_cb2NUmC8XcGKO-D2w-1; Fri, 06 Mar 2026 14:54:16 -0500
X-MC-Unique: YHmB_cb2NUmC8XcGKO-D2w-1
X-Mimecast-MFC-AGG-ID: YHmB_cb2NUmC8XcGKO-D2w_1772826855
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48378df3469so68408875e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 11:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826855; x=1773431655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UCk5SXr8JRhBJjx3kalF2SaqtbteDwoDGZPqMuj8Nbw=;
        b=HLkxntWjIy7o4pNKEC0CRCB+xau7yHekIX3nAxzWtDW673ahuz0rC3EU7wLdUtxksZ
         c+EkyhD37MB/yiG578Q8oWFeUiWn/yd3371PoRiCEKjaySXvbACzRppj0Ha6VJpXnRhK
         qR4gWrGQ4D83DPAOmjzcxH94BWK7oXE3YPP01DV1MgMM8q1y4qiulp3yvYgHyMkC8Y5f
         EVVyxnV21ncKK2a65ouBLopXHMYcjE0Ue2SAg+wi+Z6TY2TfXv0S0wn2NRPv2HUW+U3Y
         V8RTmGmJXtoAe8/F25ceWJS7+PYyyToK8AdVFyQYN4SpiZRmgA1+IzbgM3bz3a0VKIYB
         j1rw==
X-Forwarded-Encrypted: i=1; AJvYcCXvWj6+YcOGzuGSEaYDpiNc8qJyOnC8ioW3sMqofrKGlxUR3sMK0woGWQTe9V4yWinwPOVPzhhCrhGYzLJ5pTx1O2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVM0YLJXCKUuAKNqXlI3dGsN/0jFFtTHFcIilHfjR/D29PxW1z
	4JHf/jOQfCfmhb4QAgMg0VseSDmW6CnseR+9NJ+7J6ipGR8vYu40jCYZAUXCQDWwuNJuQTGhk/v
	DvQvTyJizXvciJfmSpTIUBq3NDKyS7z4z81em7f85r6W1CPUI1eHIu+7BtEwYRwdE6VgWpqUkDg
	==
X-Gm-Gg: ATEYQzy/G5XVqXO7VOfZ8m+8vDziYVCRqz4sY+RHzcfbheOY7q+0ZWNFpioJut2ZTys
	mrnSHrtvDg5wvtpOK4rYcLZr1QJS0BH3O70aCO7waaVY9OyMcbGn/KmmOL50lDCsTnSZ32NijKt
	GqYi5JuqGb4XYL6+TX1h/DWtnBtgSK+N2J0d+h+HoZi4kZppN7OA6i7/Fc2Gya3Uff5PXK0PCup
	Ux4dtC7j1ZCpc8yOokuiAXHPtWRkslikwlzkiWNzt+/JJvKQ8o2WCBADuZL7zsYnu5hAUIQIiXf
	FmRuKL4eT8sIhjqv6u3AJXyKAaDN0olkAJhB6JDugf0nLv0oUNDX0jeqU5HJ3l3snSn1pEAbNjp
	+GBp7aYJpEzMHh2nTyK/xdCrIae6+KgUOUZgb/w==
X-Received: by 2002:a05:600c:3147:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-4852671cbebmr51861245e9.7.1772826854483;
        Fri, 06 Mar 2026 11:54:14 -0800 (PST)
X-Received: by 2002:a05:600c:3147:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-4852671cbebmr51860805e9.7.1772826853882;
        Fri, 06 Mar 2026 11:54:13 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b75eesm48596485e9.14.2026.03.06.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:54:13 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
Date: Fri,  6 Mar 2026 21:49:49 +0200
Message-ID: <20260306194953.2511960-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306194953.2511960-1-costa.shul@redhat.com>
References: <20260306194953.2511960-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AdRm0cbqwivFzIklnUzXyp7ORIgpPoLZgxp-8B4aX70_1772826855
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
cpu_possible_mask, which is fixed at boot time, so querying it
repeatedly is unnecessary.

Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
global nr_cpus variable initialized once at startup.

`#pragma once` in timerlat_u.h is needed for pre-C23 compilers to avoid
redefinition errors.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c            |  7 +++-
 tools/tracing/rtla/src/common.h            |  2 +
 tools/tracing/rtla/src/osnoise_hist.c      |  3 --
 tools/tracing/rtla/src/osnoise_top.c       |  7 ----
 tools/tracing/rtla/src/timerlat.c          |  5 +--
 tools/tracing/rtla/src/timerlat_aa.c       |  1 -
 tools/tracing/rtla/src/timerlat_hist.c     |  3 --
 tools/tracing/rtla/src/timerlat_top.c      |  7 ----
 tools/tracing/rtla/src/timerlat_u.c        |  3 +-
 tools/tracing/rtla/src/timerlat_u.h        |  1 +
 tools/tracing/rtla/src/utils.c             | 10 +----
 tools/tracing/rtla/tests/unit/unit_tests.c | 44 ++++++++++------------
 12 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index f310b0d59ad3..a31fbaea5da6 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -5,12 +5,14 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
 #include <getopt.h>
+#include <sys/sysinfo.h>
+
 #include "common.h"
 
 struct trace_instance *trace_inst;
 volatile int stop_tracing;
+int nr_cpus;
 
 static void stop_trace(int sig)
 {
@@ -165,7 +167,7 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 	}
 
 	if (!params->cpus) {
-		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
+		for (i = 0; i < nr_cpus; i++)
 			CPU_SET(i, &params->monitored_cpus);
 	}
 
@@ -213,6 +215,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 	bool stopped;
 	int retval;
 
+	nr_cpus = get_nprocs_conf();
 	params = ops->parse_args(argc, argv);
 	if (!params)
 		exit(1);
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index d4b3715700be..90a3c0d1dbf3 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -108,6 +108,8 @@ struct common_params {
 	struct timerlat_u_params user;
 };
 
+extern int nr_cpus;
+
 #define for_each_monitored_cpu(cpu, nr_cpus, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 5c863e7aad28..00b8c95cbf85 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -646,9 +646,6 @@ static struct osnoise_tool
 *osnoise_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("osnoise_hist");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index b7aed40fd216..9a6cd9a2470a 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -232,12 +232,8 @@ osnoise_print_stats(struct osnoise_tool *top)
 {
 	struct osnoise_params *params = to_osnoise_params(top->params);
 	struct trace_instance *trace = &top->trace;
-	static int nr_cpus = -1;
 	int i;
 
-	if (nr_cpus == -1)
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	if (!params->common.quiet)
 		clear_terminal(trace->seq);
 
@@ -494,9 +490,6 @@ osnoise_top_apply_config(struct osnoise_tool *tool)
 struct osnoise_tool *osnoise_init_top(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("osnoise_top");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 9e4daed0aafc..31c921efa7c1 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -99,7 +99,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 int timerlat_enable(struct osnoise_tool *tool)
 {
 	struct timerlat_params *params = to_timerlat_params(tool->params);
-	int retval, nr_cpus, i;
+	int retval, i;
 
 	if (params->dma_latency >= 0) {
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
@@ -115,8 +115,6 @@ int timerlat_enable(struct osnoise_tool *tool)
 			return -1;
 		}
 
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 		for_each_monitored_cpu(i, nr_cpus, &params->common) {
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -214,7 +212,6 @@ void timerlat_analyze(struct osnoise_tool *tool, bool stopped)
 void timerlat_free(struct osnoise_tool *tool)
 {
 	struct timerlat_params *params = to_timerlat_params(tool->params);
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	int i;
 
 	timerlat_aa_destroy();
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 178de60dcef9..095483375823 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -1043,7 +1043,6 @@ void timerlat_aa_destroy(void)
  */
 int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks, enum stack_format stack_format)
 {
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct timerlat_aa_context *taa_ctx;
 	int retval;
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 88211e54bc9d..3ebe41eed9f6 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1040,9 +1040,6 @@ static struct osnoise_tool
 *timerlat_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("timerlat_hist");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 7a00f3844f56..4105638f45c4 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -442,15 +442,11 @@ timerlat_print_stats(struct osnoise_tool *top)
 	struct timerlat_params *params = to_timerlat_params(top->params);
 	struct trace_instance *trace = &top->trace;
 	struct timerlat_top_cpu summary;
-	static int nr_cpus = -1;
 	int i;
 
 	if (params->common.aa_only)
 		return;
 
-	if (nr_cpus == -1)
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	if (!params->common.quiet)
 		clear_terminal(trace->seq);
 
@@ -790,9 +786,6 @@ static struct osnoise_tool
 *timerlat_init_top(struct common_params *params)
 {
 	struct osnoise_tool *top;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	top = osnoise_init_tool("timerlat_top");
 	if (!top)
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index ce68e39d25fd..a569fe7f93aa 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -16,7 +16,7 @@
 #include <sys/wait.h>
 #include <sys/prctl.h>
 
-#include "utils.h"
+#include "common.h"
 #include "timerlat_u.h"
 
 /*
@@ -131,7 +131,6 @@ static int timerlat_u_send_kill(pid_t *procs, int nr_cpus)
  */
 void *timerlat_u_dispatcher(void *data)
 {
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct timerlat_u_params *params = data;
 	char proc_name[128];
 	int procs_count = 0;
diff --git a/tools/tracing/rtla/src/timerlat_u.h b/tools/tracing/rtla/src/timerlat_u.h
index 661511908957..a692331bd1c7 100644
--- a/tools/tracing/rtla/src/timerlat_u.h
+++ b/tools/tracing/rtla/src/timerlat_u.h
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#pragma once
 /*
  * Copyright (C) 2023 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d979159f6b70..77593718766a 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <limits.h>
 
-#include "utils.h"
+#include "common.h"
 
 #define MAX_MSG_LENGTH	1024
 int config_debug;
@@ -119,14 +119,11 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 {
 	const char *p;
 	int end_cpu;
-	int nr_cpus;
 	int cpu;
 	int i;
 
 	CPU_ZERO(set);
 
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	for (p = cpu_list; *p; ) {
 		cpu = atoi(p);
 		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
@@ -577,7 +574,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
 	unsigned int nr_states;
 	unsigned int state;
 	int disabled;
-	int nr_cpus;
 
 	nr_states = cpuidle_state_count(cpu);
 
@@ -585,7 +581,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
 		return 0;
 
 	if (saved_cpu_idle_disable_state == NULL) {
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
 		if (!saved_cpu_idle_disable_state)
 			return -1;
@@ -662,13 +657,10 @@ int restore_cpu_idle_disable_state(unsigned int cpu)
 void free_cpu_idle_disable_states(void)
 {
 	int cpu;
-	int nr_cpus;
 
 	if (!saved_cpu_idle_disable_state)
 		return;
 
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		free(saved_cpu_idle_disable_state[cpu]);
 		saved_cpu_idle_disable_state[cpu] = NULL;
diff --git a/tools/tracing/rtla/tests/unit/unit_tests.c b/tools/tracing/rtla/tests/unit/unit_tests.c
index aa53f8605e36..f3c6d89e3300 100644
--- a/tools/tracing/rtla/tests/unit/unit_tests.c
+++ b/tools/tracing/rtla/tests/unit/unit_tests.c
@@ -7,8 +7,10 @@
 #include <sched.h>
 #include <limits.h>
 #include <unistd.h>
+#include <sys/sysinfo.h>
 
 #include "../../src/utils.h"
+int nr_cpus;
 
 START_TEST(test_strtoi)
 {
@@ -34,35 +36,29 @@ END_TEST
 START_TEST(test_parse_cpu_set)
 {
 	cpu_set_t set;
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
+	nr_cpus = 8;
 	ck_assert_int_eq(parse_cpu_set("0", &set), 0);
 	ck_assert(CPU_ISSET(0, &set));
 	ck_assert(!CPU_ISSET(1, &set));
 
-	if (nr_cpus > 2) {
-		ck_assert_int_eq(parse_cpu_set("0,2", &set), 0);
-		ck_assert(CPU_ISSET(0, &set));
-		ck_assert(CPU_ISSET(2, &set));
-	}
-
-	if (nr_cpus > 3) {
-		ck_assert_int_eq(parse_cpu_set("0-3", &set), 0);
-		ck_assert(CPU_ISSET(0, &set));
-		ck_assert(CPU_ISSET(1, &set));
-		ck_assert(CPU_ISSET(2, &set));
-		ck_assert(CPU_ISSET(3, &set));
-	}
-
-	if (nr_cpus > 5) {
-		ck_assert_int_eq(parse_cpu_set("1-3,5", &set), 0);
-		ck_assert(!CPU_ISSET(0, &set));
-		ck_assert(CPU_ISSET(1, &set));
-		ck_assert(CPU_ISSET(2, &set));
-		ck_assert(CPU_ISSET(3, &set));
-		ck_assert(!CPU_ISSET(4, &set));
-		ck_assert(CPU_ISSET(5, &set));
-	}
+	ck_assert_int_eq(parse_cpu_set("0,2", &set), 0);
+	ck_assert(CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(2, &set));
+
+	ck_assert_int_eq(parse_cpu_set("0-3", &set), 0);
+	ck_assert(CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(1, &set));
+	ck_assert(CPU_ISSET(2, &set));
+	ck_assert(CPU_ISSET(3, &set));
+
+	ck_assert_int_eq(parse_cpu_set("1-3,5", &set), 0);
+	ck_assert(!CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(1, &set));
+	ck_assert(CPU_ISSET(2, &set));
+	ck_assert(CPU_ISSET(3, &set));
+	ck_assert(!CPU_ISSET(4, &set));
+	ck_assert(CPU_ISSET(5, &set));
 
 	ck_assert_int_eq(parse_cpu_set("-1", &set), 1);
 	ck_assert_int_eq(parse_cpu_set("abc", &set), 1);
-- 
2.53.0

