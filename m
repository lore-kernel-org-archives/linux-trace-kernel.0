Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44342350D48
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983585; cv=none; b=cfM93ojq6TpO8R1esJ12YEKm/2Bh3EVgzjIg3FyUrV6j7qjJNOcq0YfBJbQ7ZVHOTHJiWK+x+6a7kzmPMVIYvKRzBcwqoBoP19QLPmiU4Qqm5uXHf3biYjiiw5nj3SRUZ8gmOfpAhW6JyGrMM6hnpiZmRfkG8Gvrj3WOt2GWkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983585; c=relaxed/simple;
	bh=TS3My54+1+wB3igxyJXqNn57tpPk9g2oanX93lMf9nc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=deSVzYnBORnW/OMUcI1sBCooa++A2XEJFH297xTtWfMvkuIbq5uW6SphTjQeguNYGUIy48IsKfbpW0pO+v+Cmnuh0f6kFqP4kYdXmG66wTf0jxF/v5r8zTKm8NdBxshhiTJDvQo3MyHORcwrZjpP2elx/Y9kruOYoYbHI8O1iQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlundT2P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlundT2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=st11ylo4z/SO3tLN7S2b9c++GEqcWdO6dyVW8k4qC0Q=;
	b=QlundT2PCqTjOCCTeFMDrUarIvZ6kZPSPjhBuadpBUfrH3bK9bqRyPgyt2SwJXL+UG5bTK
	9iTu1oRNTp+in0b9qSbTUovPRdNXBvn1R4z6AnKMx1EGrz3KC3vwrmmDZPy7Pq26CTqYCi
	vsxfGvaqjzc5upVhkF9rYKZlFE5VudI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Qzhbd5DYPsijzgC52W121w-1; Fri, 13 Feb 2026 06:53:00 -0500
X-MC-Unique: Qzhbd5DYPsijzgC52W121w-1
X-Mimecast-MFC-AGG-ID: Qzhbd5DYPsijzgC52W121w_1770983579
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483786a09b1so4951775e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 03:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983579; x=1771588379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=st11ylo4z/SO3tLN7S2b9c++GEqcWdO6dyVW8k4qC0Q=;
        b=ejxaWWQjFwM578IglWp0HoFHGLg1bGplwSfGYVz8/SzRNyM632t6LTM1oSdX6MBplE
         ZTdl8gkhv/k1IC0shksMw+8+PeCLsfI9KoXEE++4RPQp39+lX/uWynr9LG4Ma3CA+/zk
         /YKHAjsBB/Uu0DUZG9kQ7eL/37t8pGbjofIjIczxQtQNItXSR7mtPCjFmK96p12Ta0vv
         o2b4wp5zqsL5aeitfR+R5EY1ZuQembl6MX5XZR2irAVz3j/WTtHg7jr8Bm+KznpB4XhZ
         k6O/w9AEPC5jUi3zuE1V0PcHSSBcs6166gyEcptiEXckLWEP4U3h0ucdygADaCc5N0Lu
         TmYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG5lL4tFzmg7e6LiS9sUZggoP/or50XK1ll/IuEoq0Le1RhVs+hz/7r5tkCRYhQ/2o6WFguIqmc/W+FY/yP3yEemg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEPEHhE0BJwIWX2xJC2RxUHUckY7udJiPK9xb71jQGYh+lg7m
	uhhDVbIXyVgoQIdWOMPxJMCX2EBQkR2LG4HcEbifCMjxA6caJO11nN+JUtOohVv3qwZvyWECv4K
	3XtfTvp6yMBuJiw++fTEdopsikP/QBoHNS8A1IF84QKrwmPaqxVhEDpIx7f5I/nc4ZmFnhHUjJw
	==
X-Gm-Gg: AZuq6aL/8IBgmys7UBce/ByKRbbCFknwZXJqnmj3YEq4Yi9Ir7YBMCc+9rP0q1XD+Ni
	uTpuHgaq6OP34tkc4ckmWIvyDB9D543v4kMAyIu27WTIrxgJP4lms5kvyCKkMreGrNCohxAJl2g
	XPpxps5P8dSnrZkR3fRhx7xYqZVOtmGTLCMoDJV00F3eOYapyVVKr1u5lcbMLU19ekW8s/ebk5W
	ai6ErDPrKOLvc3QH1me0SyE3/qLtYX1jemxTeVDH5GxJ8svUXeRcC9w3aQEEmkzWzNJfp8fZtr0
	mnYpZZ7/X48Xf9W/+peCrOSgRYPXTMKwjOHc+5kDFAdsocliGeYyUwG3Qub/h9i/roBbGlBnX4z
	8v+/gycXUoS4kOb7LaBQ4n3ToPGgHatCgLAg=
X-Received: by 2002:a05:600c:5020:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-48373a71d7fmr24271525e9.28.1770983578955;
        Fri, 13 Feb 2026 03:52:58 -0800 (PST)
X-Received: by 2002:a05:600c:5020:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-48373a71d7fmr24271255e9.28.1770983578460;
        Fri, 13 Feb 2026 03:52:58 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:52:58 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 1/5] tools/rtla: Consolidate nr_cpus usage across all tools
Date: Fri, 13 Feb 2026 13:52:30 +0200
Message-ID: <20260213115234.430232-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213115234.430232-1-costa.shul@redhat.com>
References: <20260213115234.430232-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ywu_tbcUvsskMVNJz070_gUtFHchjZ4azaJAa9otPbE_1770983579
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
 tools/tracing/rtla/src/common.c        |  7 +++++--
 tools/tracing/rtla/src/common.h        |  2 ++
 tools/tracing/rtla/src/osnoise_hist.c  |  3 ---
 tools/tracing/rtla/src/osnoise_top.c   |  7 -------
 tools/tracing/rtla/src/timerlat.c      |  5 +----
 tools/tracing/rtla/src/timerlat_aa.c   |  1 -
 tools/tracing/rtla/src/timerlat_hist.c |  3 ---
 tools/tracing/rtla/src/timerlat_top.c  |  7 -------
 tools/tracing/rtla/src/timerlat_u.c    |  3 +--
 tools/tracing/rtla/src/timerlat_u.h    |  1 +
 tools/tracing/rtla/src/utils.c         | 10 +---------
 11 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index ceff76a62a30..e4cf30a65e82 100644
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
@@ -135,7 +137,7 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 	}
 
 	if (!params->cpus) {
-		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
+		for (i = 0; i < nr_cpus; i++)
 			CPU_SET(i, &params->monitored_cpus);
 	}
 
@@ -183,6 +185,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 	bool stopped;
 	int retval;
 
+	nr_cpus = get_nprocs_conf();
 	params = ops->parse_args(argc, argv);
 	if (!params)
 		exit(1);
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 7602c5593ef5..32f9c1351209 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -107,6 +107,8 @@ struct common_params {
 	struct timerlat_u_params user;
 };
 
+extern int nr_cpus;
+
 #define for_each_monitored_cpu(cpu, nr_cpus, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 9d70ea34807f..03ebff34fff4 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -647,9 +647,6 @@ static struct osnoise_tool
 *osnoise_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("osnoise_hist");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index d54d47947fb4..7dcd2e318205 100644
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
 
@@ -495,9 +491,6 @@ osnoise_top_apply_config(struct osnoise_tool *tool)
 struct osnoise_tool *osnoise_init_top(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("osnoise_top");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 8f8811f7a13b..69856f677fce 100644
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
index 31e66ea2b144..5766d58709eb 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -1022,7 +1022,6 @@ void timerlat_aa_destroy(void)
  */
 int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks)
 {
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct timerlat_aa_context *taa_ctx;
 	int retval;
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4e8c38a61197..841118ed84f2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1031,9 +1031,6 @@ static struct osnoise_tool
 *timerlat_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("timerlat_hist");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 284b74773c2b..3e395ce4fa9f 100644
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
 
@@ -781,9 +777,6 @@ static struct osnoise_tool
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
index 0da3b2470c31..8cd1b374b035 100644
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
@@ -559,7 +556,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
 	unsigned int nr_states;
 	unsigned int state;
 	int disabled;
-	int nr_cpus;
 
 	nr_states = cpuidle_state_count(cpu);
 
@@ -567,7 +563,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
 		return 0;
 
 	if (saved_cpu_idle_disable_state == NULL) {
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
 		if (!saved_cpu_idle_disable_state)
 			return -1;
@@ -644,13 +639,10 @@ int restore_cpu_idle_disable_state(unsigned int cpu)
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
-- 
2.52.0

