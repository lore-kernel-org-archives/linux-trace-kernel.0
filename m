Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE84217F24
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748717; cv=none; b=pI1Nzqnt8beh30GBy6ALA5GZtDqzNdLZRoqNdhE5uBwNT0AveBu9o1bHGGaIqQjqkBdCzoOFPe11Zl/e9xUpIb+w4oOqcA67pBna2PCGTWcQ5qFrvO78y6A1cdOabCGhwLuL6xm2ujanInFaczMc87cV5uTEEOXfV9ufe0HPrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748717; c=relaxed/simple;
	bh=C9JPwrnU0jkO/r3x4Ying19TjWfGEnwtT3j2p0OVqwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rLoYntw+HrgPzqlB9nKHjDEiYm2NJGYSeRcKkvpuk+z9W4zfr23r+g7RPc0nqn+vLLRxeDlNz6LyLUsDtywxhXnOUWCm1hZgiWOu/GKiWKaOfwOVX08TSeFiGza8IQqiglze1mL2C2/cuosFKuaeehUn1oGIzg6hC4Gulwa/uIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3wNQdPq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3wNQdPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755748711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA5ejlPspujcK0Jh9JPdCWycsmAfyHkNSwGiB50elP0=;
	b=F3wNQdPqzxf095l+quOGekEX3Vhf5T41IOHMGNt878QWIoHtcHPbRJ3XB7QTo2tN9pMRWI
	8MorcAKzdRzBNpKwbPM8I8CcLiqvM0lcjdgOqAdtLgxigggbvqNhLm5UstMz3xIktQrlJq
	iwQPebKVePDbiN8GJ3FWZmUhg4/IPAI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313--OYgxnqzPsKOuEEB43yRjg-1; Wed, 20 Aug 2025 23:58:29 -0400
X-MC-Unique: -OYgxnqzPsKOuEEB43yRjg-1
X-Mimecast-MFC-AGG-ID: -OYgxnqzPsKOuEEB43yRjg_1755748709
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e95109d1ddbso170427276.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755748709; x=1756353509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA5ejlPspujcK0Jh9JPdCWycsmAfyHkNSwGiB50elP0=;
        b=Ts5sbDeaHqbie8xYh4OeaKbTNcD8Tal3klzrkzllaXxkx+bSNGmaClamrUNwzdQ1J3
         +eopDGNZHCCUEKjrlGQLpslGMWpxBpkWROi7MPH/vO1gvqeXMZazi4GC8c0geY++mSI3
         eBEQYaxhoSp9HDL8mf+aGmgYflisD/uvB11g2ypuv4mayo0F5MU6FYP/VPqJOFNV0Q82
         sVME84A8o9O2IVaUgHnZcPT4nunp6Qmu1dpHtb63hkOgxaWR5prX+NuTc4cDs2EjUoVM
         ZGn1Bhn63vGWbqpL52xF2HJH/rDDFm34UJZYW5iUhf+uG93ALOaMGt/3UdLcmMS5r4t3
         ieXA==
X-Gm-Message-State: AOJu0YyyMb0aogKeGRmDEpHuDrOOv9U3Gd/iloSmZfiC/sg28hqCumbo
	46Nt4W1ed3eKGJWs3H7FgI+eXsKyQy0ZRzsZeMwHiN9bPa4nKrDugvVyDGZgoWeSrSq0ahXwsZX
	3lgLDOhGn7Elm/byfEZlTSuKzz8PoMRoWd+551RFA+1vX6e4xfGWzIhnHYStbyIvL4T3xg9PWEQ
	==
X-Gm-Gg: ASbGncuMONq27jg04qCJKb7R0VGLYxz7EIG+Wwu4h7do7INz3mrdHKKnIOJePIPc0fo
	eSdkKM2ls4KfgX8K5DdYtVhMsZ3ml01sSWxSH9M4Oj3QtiWBTTBm7CZt8bhhaVST7Gfz5eD04Ku
	xK97nNz/XwTDgFsqYdbwXGXVWXMhE3OeI7OKUrA0lGohpU9Y0FAw9ziJ/XN3Grfg2QvbP/G2i75
	91c4lPxYi+WdIBqMhyxC5izhMF3sHdlhNIutCzBSdRwKhckImsYip4yv5Cy8+dg5ZAX63BUWxbI
	8k8oAA/TQ1N2aO4BW2HG1DEiqjkeS9aQttjJO6fNhqG7Se4/nQYXEMhJ1W8q+BDladjXZAM=
X-Received: by 2002:a05:6902:1149:b0:e93:11a2:ebc5 with SMTP id 3f1490d57ef6-e95089078d0mr980244276.17.1755748707411;
        Wed, 20 Aug 2025 20:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpfIHiJ3DK+lkLnex74aaGMQvNza+kKu933F/87wAY1sm3M7T+/2VNRARHkLY6Gf2+StsB5g==
X-Received: by 2002:a05:6902:1149:b0:e93:11a2:ebc5 with SMTP id 3f1490d57ef6-e95089078d0mr980224276.17.1755748706276;
        Wed, 20 Aug 2025 20:58:26 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e95078a1bdasm385457276.34.2025.08.20.20.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:58:25 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 4/7] tools/rtla: Consolidate code between osnoise/timerlat and hist/top
Date: Wed, 20 Aug 2025 22:57:16 -0500
Message-ID: <20250821035719.137161-5-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250821035719.137161-1-crwood@redhat.com>
References: <20250821035719.137161-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iWnbL6JZMpJzOxrOuc70nNi69Ty4HHC4WbTdDZv5iUc_1755748709
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently a lot of code is duplicated between the different rtla tools,
making maintenance more difficult, and encouraging divergence such as
features that are only implemented for certain tools even though they
could be more broadly applicable.

Merge the various main() functions into a common run_tool() with an ops
struct for tool-specific details.

Implement enough support for actions on osnoise to not need to keep the
old params->trace_output path.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
I've reworked this from my original plan in order to avoid a "god object
anti-pattern" with the params struct, as requested by Costa.  In this
case I'm not 100% convinced that the separation is worth the hassle and
all the "params->common.xxx" and the churn as a field or some code goes
from tool-specific to common, but I can see some advantages.

Some bits like aa_only and the user stuff are in common even though they
are only used by timerlat.  In the case of user stuff I plan to submit
patches for supporting that on osnoise, and it doesn't seem worthwhile to
jump through hoops to move some of that code out of code that is otherwise
able to be shared.  For aa_only, making it non-common would have precluded
sharing some code, and the code that the flag inhibits isn't tool-specific
(unlike no_aa).  Plus, there's other common code referring to tool->aa.
---
 tools/tracing/rtla/src/common.c        | 281 +++++++++++++++
 tools/tracing/rtla/src/common.h        |  60 +++-
 tools/tracing/rtla/src/osnoise.c       |  66 ++--
 tools/tracing/rtla/src/osnoise.h       |  14 +-
 tools/tracing/rtla/src/osnoise_hist.c  | 234 +++---------
 tools/tracing/rtla/src/osnoise_top.c   | 218 ++----------
 tools/tracing/rtla/src/timerlat.c      | 167 ++++++++-
 tools/tracing/rtla/src/timerlat.h      |  16 +-
 tools/tracing/rtla/src/timerlat_bpf.c  |   4 +-
 tools/tracing/rtla/src/timerlat_hist.c | 450 +++++------------------
 tools/tracing/rtla/src/timerlat_top.c  | 473 ++++---------------------
 tools/tracing/rtla/src/trace.h         |   3 -
 tools/tracing/rtla/tests/hwnoise.t     |   2 +-
 tools/tracing/rtla/tests/osnoise.t     |   2 +-
 14 files changed, 794 insertions(+), 1196 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index c3834c760182..c6e446425cd2 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -2,9 +2,42 @@
 
 #define _GNU_SOURCE
 
+#include <pthread.h>
+#include <signal.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include "common.h"
 
+struct trace_instance *trace_inst;
+int stop_tracing;
+
+static void stop_trace(int sig)
+{
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(trace_inst->inst);
+		return;
+	}
+	stop_tracing = 1;
+	if (trace_inst)
+		trace_instance_stop(trace_inst);
+}
+
+/*
+ * set_signals - handles the signal to stop the tool
+ */
+static void set_signals(struct common_params *params)
+{
+	signal(SIGINT, stop_trace);
+	if (params->duration) {
+		signal(SIGALRM, stop_trace);
+		alarm(params->duration);
+	}
+}
+
 /*
  * common_apply_config - apply common configs to the initialized tool
  */
@@ -62,3 +95,251 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 	return -1;
 }
 
+
+int run_tool(struct tool_ops *ops, int argc, char *argv[])
+{
+	struct common_params *params;
+	enum result return_value = ERROR;
+	struct osnoise_tool *tool;
+	bool stopped;
+	int retval;
+
+	params = ops->parse_args(argc, argv);
+	if (!params)
+		exit(1);
+
+	tool = ops->init_tool(params);
+	if (!tool) {
+		err_msg("Could not init osnoise tool\n");
+		goto out_exit;
+	}
+	tool->ops = ops;
+	tool->params = params;
+
+	/*
+	 * Save trace instance into global variable so that SIGINT can stop
+	 * the timerlat tracer.
+	 * Otherwise, rtla could loop indefinitely when overloaded.
+	 */
+	trace_inst = &tool->trace;
+
+	retval = ops->apply_config(tool);
+	if (retval) {
+		err_msg("Could not apply config\n");
+		goto out_free;
+	}
+
+	retval = enable_tracer_by_name(trace_inst->inst, ops->tracer);
+	if (retval) {
+		err_msg("Failed to enable %s tracer\n", ops->tracer);
+		goto out_free;
+	}
+
+	if (params->set_sched) {
+		retval = set_comm_sched_attr(ops->comm_prefix, &params->sched_param);
+		if (retval) {
+			err_msg("Failed to set sched parameters\n");
+			goto out_free;
+		}
+	}
+
+	if (params->cgroup && !params->user_data) {
+		retval = set_comm_cgroup(ops->comm_prefix, params->cgroup_name);
+		if (!retval) {
+			err_msg("Failed to move threads to cgroup\n");
+			goto out_free;
+		}
+	}
+
+
+	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
+		tool->record = osnoise_init_trace_tool(ops->tracer);
+		if (!tool->record) {
+			err_msg("Failed to enable the trace instance\n");
+			goto out_free;
+		}
+		params->threshold_actions.trace_output_inst = tool->record->trace.inst;
+		params->end_actions.trace_output_inst = tool->record->trace.inst;
+
+		if (params->events) {
+			retval = trace_events_enable(&tool->record->trace, params->events);
+			if (retval)
+				goto out_trace;
+		}
+
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&tool->record->trace, params->buffer_size);
+			if (retval)
+				goto out_trace;
+		}
+	}
+
+	if (params->user_workload) {
+		pthread_t user_thread;
+
+		/* rtla asked to stop */
+		params->user.should_run = 1;
+		/* all threads left */
+		params->user.stopped_running = 0;
+
+		params->user.set = &params->monitored_cpus;
+		if (params->set_sched)
+			params->user.sched_param = &params->sched_param;
+		else
+			params->user.sched_param = NULL;
+
+		params->user.cgroup_name = params->cgroup_name;
+
+		retval = pthread_create(&user_thread, NULL, timerlat_u_dispatcher, &params->user);
+		if (retval)
+			err_msg("Error creating timerlat user-space threads\n");
+	}
+
+	retval = ops->enable(tool);
+	if (retval)
+		goto out_trace;
+
+	tool->start_time = time(NULL);
+	set_signals(params);
+
+	retval = ops->main(tool);
+	if (retval)
+		goto out_trace;
+
+	if (params->user_workload && !params->user.stopped_running) {
+		params->user.should_run = 0;
+		sleep(1);
+	}
+
+	ops->print_stats(tool);
+
+	actions_perform(&params->end_actions);
+
+	return_value = PASSED;
+
+	stopped = osnoise_trace_is_off(tool, tool->record) && !stop_tracing;
+	if (stopped) {
+		printf("rtla hit stop tracing\n");
+		return_value = FAILED;
+	}
+
+	if (ops->analyze)
+		ops->analyze(tool, stopped);
+
+out_trace:
+	trace_events_destroy(&tool->record->trace, params->events);
+	params->events = NULL;
+out_free:
+	ops->free(tool);
+	osnoise_destroy_tool(tool->record);
+	osnoise_destroy_tool(tool);
+	actions_destroy(&params->threshold_actions);
+	actions_destroy(&params->end_actions);
+	free(params);
+out_exit:
+	exit(return_value);
+}
+
+int top_main_loop(struct osnoise_tool *tool)
+{
+	struct common_params *params = tool->params;
+	struct trace_instance *trace = &tool->trace;
+	struct osnoise_tool *record = tool->record;
+	int retval;
+
+	while (!stop_tracing) {
+		sleep(params->sleep_time);
+
+		if (params->aa_only && !osnoise_trace_is_off(tool, record))
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
+			tool->ops->print_stats(tool);
+
+		if (osnoise_trace_is_off(tool, record)) {
+			actions_perform(&params->threshold_actions);
+
+			if (!params->threshold_actions.continue_flag)
+				/* continue flag not set, break */
+				return 0;
+
+			/* continue action reached, re-enable tracing */
+			if (record)
+				trace_instance_start(&record->trace);
+			if (tool->aa)
+				trace_instance_start(&tool->aa->trace);
+			trace_instance_start(trace);
+		}
+
+		/* is there still any user-threads ? */
+		if (params->user_workload) {
+			if (params->user.stopped_running) {
+				debug_msg("timerlat user space threads stopped!\n");
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int hist_main_loop(struct osnoise_tool *tool)
+{
+	struct common_params *params = tool->params;
+	struct trace_instance *trace = &tool->trace;
+	int retval = 0;
+
+	while (!stop_tracing) {
+		sleep(params->sleep_time);
+
+		retval = tracefs_iterate_raw_events(trace->tep,
+						    trace->inst,
+						    NULL,
+						    0,
+						    collect_registered_events,
+						    trace);
+		if (retval < 0) {
+			err_msg("Error iterating on events\n");
+			break;
+		}
+
+		if (osnoise_trace_is_off(tool, tool->record)) {
+			actions_perform(&params->threshold_actions);
+
+			if (!params->threshold_actions.continue_flag) {
+				/* continue flag not set, break */
+				break;
+
+				/* continue action reached, re-enable tracing */
+				if (tool->record)
+					trace_instance_start(&tool->record->trace);
+				if (tool->aa)
+					trace_instance_start(&tool->aa->trace);
+				trace_instance_start(&tool->trace);
+			}
+			break;
+		}
+
+		/* is there still any user-threads ? */
+		if (params->user_workload) {
+			if (params->user.stopped_running) {
+				debug_msg("user-space threads stopped!\n");
+				break;
+			}
+		}
+	}
+
+	return retval;
+}
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index c306ba502688..355f113a14a3 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #pragma once
 
+#include "actions.h"
+#include "timerlat_u.h"
 #include "trace.h"
 #include "utils.h"
 
@@ -51,16 +53,8 @@ struct osnoise_context {
 	int			opt_workload;
 };
 
-/*
- * osnoise_tool -  osnoise based tool definition.
- */
-struct osnoise_tool {
-	struct trace_instance		trace;
-	struct osnoise_context		*context;
-	void				*data;
-	void				*params;
-	time_t				start_time;
-};
+extern struct trace_instance *trace_inst;
+extern int stop_tracing;
 
 struct hist_params {
 	char			no_irq;
@@ -103,7 +97,46 @@ struct common_params {
 	int			output_divisor;
 	int			pretty_output;
 	int			quiet;
+	int			user_workload;
 	int			kernel_workload;
+	int			user_data;
+	int			aa_only;
+
+	struct actions		threshold_actions;
+	struct actions		end_actions;
+	struct timerlat_u_params user;
+};
+
+struct tool_ops;
+
+/*
+ * osnoise_tool -  osnoise based tool definition.
+ *
+ * Only the "trace" and "context" fields are used for
+ * the additional trace instances (record and aa).
+ */
+struct osnoise_tool {
+	struct tool_ops			*ops;
+	struct trace_instance		trace;
+	struct osnoise_context		*context;
+	void				*data;
+	struct common_params		*params;
+	time_t				start_time;
+	struct osnoise_tool		*record;
+	struct osnoise_tool		*aa;
+};
+
+struct tool_ops {
+	const char *tracer;
+	const char *comm_prefix;
+	struct common_params *(*parse_args)(int argc, char *argv[]);
+	struct osnoise_tool *(*init_tool)(struct common_params *params);
+	int (*apply_config)(struct osnoise_tool *tool);
+	int (*enable)(struct osnoise_tool *tool);
+	int (*main)(struct osnoise_tool *tool);
+	void (*print_stats)(struct osnoise_tool *tool);
+	void (*analyze)(struct osnoise_tool *tool, bool stopped);
+	void (*free)(struct osnoise_tool *tool);
 };
 
 int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
@@ -111,4 +144,11 @@ void osnoise_restore_cpus(struct osnoise_context *context);
 
 int osnoise_set_workload(struct osnoise_context *context, bool onoff);
 
+void osnoise_destroy_tool(struct osnoise_tool *top);
+struct osnoise_tool *osnoise_init_tool(char *tool_name);
+struct osnoise_tool *osnoise_init_trace_tool(const char *tracer);
+bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
+
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
+int top_main_loop(struct osnoise_tool *tool);
+int hist_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 4051b21db69a..312c511fa004 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -906,22 +906,6 @@ static void osnoise_put_workload(struct osnoise_context *context)
 	context->orig_opt_workload = OSNOISE_OPTION_INIT_VAL;
 }
 
-/*
- * enable_osnoise - enable osnoise tracer in the trace_instance
- */
-int enable_osnoise(struct trace_instance *trace)
-{
-	return enable_tracer_by_name(trace->inst, "osnoise");
-}
-
-/*
- * enable_timerlat - enable timerlat tracer in the trace_instance
- */
-int enable_timerlat(struct trace_instance *trace)
-{
-	return enable_tracer_by_name(trace->inst, "timerlat");
-}
-
 enum {
 	FLAG_CONTEXT_NEWLY_CREATED	= (1 << 0),
 	FLAG_CONTEXT_DELETED		= (1 << 1),
@@ -1056,7 +1040,7 @@ struct osnoise_tool *osnoise_init_tool(char *tool_name)
 /*
  * osnoise_init_trace_tool - init a tracer instance to trace osnoise events
  */
-struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
+struct osnoise_tool *osnoise_init_trace_tool(const char *tracer)
 {
 	struct osnoise_tool *trace;
 	int retval;
@@ -1168,6 +1152,44 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 	return -1;
 }
 
+int osnoise_enable(struct osnoise_tool *tool)
+{
+	struct osnoise_params *params = to_osnoise_params(tool->params);
+	int retval;
+
+	/*
+	 * Start the tracer here, after having set all instances.
+	 *
+	 * Let the trace instance start first for the case of hitting a stop
+	 * tracing while enabling other instances. The trace instance is the
+	 * one with most valuable information.
+	 */
+	if (tool->record)
+		trace_instance_start(&tool->record->trace);
+	trace_instance_start(&tool->trace);
+
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
+		if (stop_tracing)
+			return -1;
+
+		/*
+		 * Clean up the buffer. The osnoise workload do not run
+		 * with tracing off to avoid creating a performance penalty
+		 * when not needed.
+		 */
+		retval = tracefs_instance_file_write(tool->trace.inst, "trace", "");
+		if (retval < 0) {
+			debug_msg("Error cleaning up the buffer");
+			return retval;
+		}
+
+	}
+
+	return 0;
+}
+
 static void osnoise_usage(int err)
 {
 	int i;
@@ -1201,7 +1223,7 @@ int osnoise_main(int argc, char *argv[])
 	 * default cmdline.
 	 */
 	if (argc == 1) {
-		osnoise_top_main(argc, argv);
+		run_tool(&osnoise_top_ops, argc, argv);
 		exit(0);
 	}
 
@@ -1209,13 +1231,13 @@ int osnoise_main(int argc, char *argv[])
 		osnoise_usage(0);
 	} else if (strncmp(argv[1], "-", 1) == 0) {
 		/* the user skipped the tool, call the default one */
-		osnoise_top_main(argc, argv);
+		run_tool(&osnoise_top_ops, argc, argv);
 		exit(0);
 	} else if (strcmp(argv[1], "top") == 0) {
-		osnoise_top_main(argc-1, &argv[1]);
+		run_tool(&osnoise_top_ops, argc-1, &argv[1]);
 		exit(0);
 	} else if (strcmp(argv[1], "hist") == 0) {
-		osnoise_hist_main(argc-1, &argv[1]);
+		run_tool(&osnoise_hist_ops, argc-1, &argv[1]);
 		exit(0);
 	}
 
@@ -1226,6 +1248,6 @@ int osnoise_main(int argc, char *argv[])
 
 int hwnoise_main(int argc, char *argv[])
 {
-	osnoise_top_main(argc, argv);
+	run_tool(&osnoise_top_ops, argc, argv);
 	exit(0);
 }
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 25baf46a2520..895687030c0b 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -10,13 +10,14 @@ enum osnoise_mode {
 
 struct osnoise_params {
 	struct common_params	common;
-	char			*trace_output;
 	unsigned long long	runtime;
 	unsigned long long	period;
 	long long		threshold;
 	enum osnoise_mode	mode;
 };
 
+#define to_osnoise_params(ptr) container_of(ptr, struct osnoise_params, common)
+
 /*
  * *_INIT_VALs are also invalid values, they are used to
  * communicate errors.
@@ -54,14 +55,17 @@ int osnoise_set_print_stack(struct osnoise_context *context,
 			    long long print_stack);
 
 int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
-void osnoise_destroy_tool(struct osnoise_tool *top);
-struct osnoise_tool *osnoise_init_tool(char *tool_name);
-struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
 void osnoise_report_missed_events(struct osnoise_tool *tool);
-bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
 int osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params);
 
 int osnoise_hist_main(int argc, char *argv[]);
 int osnoise_top_main(int argc, char **argv);
+int osnoise_enable(struct osnoise_tool *tool);
 int osnoise_main(int argc, char **argv);
 int hwnoise_main(int argc, char **argv);
+
+extern struct tool_ops timerlat_top_ops, timerlat_hist_ops;
+extern struct tool_ops osnoise_top_ops, osnoise_hist_ops;
+
+int run_tool(struct tool_ops *ops, int argc, char *argv[]);
+int hist_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index a31ab9b4ab21..2c2cdd467a67 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -54,6 +54,11 @@ osnoise_free_histogram(struct osnoise_hist_data *data)
 	free(data);
 }
 
+static void osnoise_free_hist_tool(struct osnoise_tool *tool)
+{
+	osnoise_free_histogram(tool->data);
+}
+
 /*
  * osnoise_alloc_histogram - alloc runtime data
  */
@@ -95,7 +100,7 @@ static struct osnoise_hist_data
 static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
 					 unsigned long long duration, int count)
 {
-	struct osnoise_params *params = tool->params;
+	struct osnoise_params *params = to_osnoise_params(tool->params);
 	struct osnoise_hist_data *data = tool->data;
 	unsigned long long total_duration;
 	int entries = data->entries;
@@ -137,7 +142,7 @@ static void osnoise_destroy_trace_hist(struct osnoise_tool *tool)
  */
 static int osnoise_init_trace_hist(struct osnoise_tool *tool)
 {
-	struct osnoise_params *params = tool->params;
+	struct osnoise_params *params = to_osnoise_params(tool->params);
 	struct osnoise_hist_data *data = tool->data;
 	int bucket_size;
 	char buff[128];
@@ -222,7 +227,7 @@ static void osnoise_read_trace_hist(struct osnoise_tool *tool)
  */
 static void osnoise_hist_header(struct osnoise_tool *tool)
 {
-	struct osnoise_params *params = tool->params;
+	struct osnoise_params *params = to_osnoise_params(tool->params);
 	struct osnoise_hist_data *data = tool->data;
 	struct trace_seq *s = tool->trace.seq;
 	char duration[26];
@@ -339,8 +344,9 @@ osnoise_print_summary(struct osnoise_params *params,
  * osnoise_print_stats - print data for all CPUs
  */
 static void
-osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
+osnoise_print_stats(struct osnoise_tool *tool)
 {
+	struct osnoise_params *params = to_osnoise_params(tool->params);
 	struct osnoise_hist_data *data = tool->data;
 	struct trace_instance *trace = &tool->trace;
 	int has_samples = 0;
@@ -477,18 +483,22 @@ static void osnoise_hist_usage(char *usage)
 /*
  * osnoise_hist_parse_args - allocs, parse and fill the cmd line parameters
  */
-static struct osnoise_params
+static struct common_params
 *osnoise_hist_parse_args(int argc, char *argv[])
 {
 	struct osnoise_params *params;
 	struct trace_events *tevent;
 	int retval;
 	int c;
+	char *trace_output = NULL;
 
 	params = calloc(1, sizeof(*params));
 	if (!params)
 		exit(1);
 
+	actions_init(&params->common.threshold_actions);
+	actions_init(&params->common.end_actions);
+
 	/* display data in microseconds */
 	params->common.output_divisor = 1000;
 	params->common.hist.bucket_size = 1;
@@ -543,7 +553,7 @@ static struct osnoise_params
 			params->threshold = 1;
 
 			/* set trace */
-			params->trace_output = "osnoise_trace.txt";
+			trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'b':
@@ -634,13 +644,13 @@ static struct osnoise_params
 		case 't':
 			if (optarg) {
 				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
+					trace_output = &optarg[1];
 				else
-					params->trace_output = &optarg[0];
+					trace_output = &optarg[0];
 			} else if (optind < argc && argv[optind][0] != '0')
-				params->trace_output = argv[optind];
+				trace_output = argv[optind];
 			else
-				params->trace_output = "osnoise_trace.txt";
+				trace_output = "osnoise_trace.txt";
 			break;
 		case '0': /* no header */
 			params->common.hist.no_header = 1;
@@ -687,6 +697,9 @@ static struct osnoise_params
 		}
 	}
 
+	if (trace_output)
+		actions_add_trace_output(&params->common.threshold_actions, trace_output);
+
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
 		exit(EXIT_FAILURE);
@@ -695,32 +708,23 @@ static struct osnoise_params
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
 		osnoise_hist_usage("no-index set and with-zeros not set - it does not make sense");
 
-	return params;
+	return &params->common;
 }
 
 /*
  * osnoise_hist_apply_config - apply the hist configs to the initialized tool
  */
 static int
-osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
+osnoise_hist_apply_config(struct osnoise_tool *tool)
 {
-	int retval;
-
-	retval = osnoise_apply_config(tool, params);
-	if (retval)
-		goto out_err;
-
-	return 0;
-
-out_err:
-	return -1;
+	return osnoise_apply_config(tool, to_osnoise_params(tool->params));
 }
 
 /*
  * osnoise_init_hist - initialize a osnoise hist tool with parameters
  */
 static struct osnoise_tool
-*osnoise_init_hist(struct osnoise_params *params)
+*osnoise_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
 	int nr_cpus;
@@ -731,13 +735,11 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_histogram(nr_cpus, params->common.hist.entries,
-					     params->common.hist.bucket_size);
+	tool->data = osnoise_alloc_histogram(nr_cpus, params->hist.entries,
+					     params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
 
-	tool->params = params;
-
 	return tool;
 
 out_err:
@@ -745,171 +747,35 @@ static struct osnoise_tool
 	return NULL;
 }
 
-static int stop_tracing;
-static void stop_hist(int sig)
-{
-	stop_tracing = 1;
-}
-
-/*
- * osnoise_hist_set_signals - handles the signal to stop the tool
- */
-static void
-osnoise_hist_set_signals(struct osnoise_params *params)
+static int osnoise_hist_enable(struct osnoise_tool *tool)
 {
-	signal(SIGINT, stop_hist);
-	if (params->common.duration) {
-		signal(SIGALRM, stop_hist);
-		alarm(params->common.duration);
-	}
-}
-
-int osnoise_hist_main(int argc, char *argv[])
-{
-	struct osnoise_params *params;
-	struct osnoise_tool *record = NULL;
-	struct osnoise_tool *tool = NULL;
-	enum result return_value = ERROR;
-	struct trace_instance *trace;
 	int retval;
 
-	params = osnoise_hist_parse_args(argc, argv);
-	if (!params)
-		exit(1);
-
-	tool = osnoise_init_hist(params);
-	if (!tool) {
-		err_msg("Could not init osnoise hist\n");
-		goto out_exit;
-	}
-
-	retval = osnoise_hist_apply_config(tool, params);
-	if (retval) {
-		err_msg("Could not apply config\n");
-		goto out_destroy;
-	}
-
-	trace = &tool->trace;
-
-	retval = enable_osnoise(trace);
-	if (retval) {
-		err_msg("Failed to enable osnoise tracer\n");
-		goto out_destroy;
-	}
-
 	retval = osnoise_init_trace_hist(tool);
 	if (retval)
-		goto out_destroy;
+		return retval;
 
-	if (params->common.set_sched) {
-		retval = set_comm_sched_attr("osnoise/", &params->common.sched_param);
-		if (retval) {
-			err_msg("Failed to set sched parameters\n");
-			goto out_free;
-		}
-	}
-
-	if (params->common.cgroup) {
-		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
-		if (!retval) {
-			err_msg("Failed to move threads to cgroup\n");
-			goto out_free;
-		}
-	}
-
-	if (params->trace_output) {
-		record = osnoise_init_trace_tool("osnoise");
-		if (!record) {
-			err_msg("Failed to enable the trace instance\n");
-			goto out_free;
-		}
-
-		if (params->common.events) {
-			retval = trace_events_enable(&record->trace, params->common.events);
-			if (retval)
-				goto out_hist;
-		}
-
-		if (params->common.buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
-			if (retval)
-				goto out_hist;
-		}
-	}
-
-	/*
-	 * Start the tracer here, after having set all instances.
-	 *
-	 * Let the trace instance start first for the case of hitting a stop
-	 * tracing while enabling other instances. The trace instance is the
-	 * one with most valuable information.
-	 */
-	if (params->trace_output)
-		trace_instance_start(&record->trace);
-	trace_instance_start(trace);
-
-	if (params->common.warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->common.warmup);
-		sleep(params->common.warmup);
-		if (stop_tracing)
-			goto out_hist;
-
-		/*
-		 * Clean up the buffer. The osnoise workload do not run
-		 * with tracing off to avoid creating a performance penalty
-		 * when not needed.
-		 */
-		retval = tracefs_instance_file_write(trace->inst, "trace", "");
-		if (retval < 0) {
-			debug_msg("Error cleaning up the buffer");
-			goto out_hist;
-		}
-
-	}
-
-	tool->start_time = time(NULL);
-	osnoise_hist_set_signals(params);
-
-	while (!stop_tracing) {
-		sleep(params->common.sleep_time);
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
+	return osnoise_enable(tool);
+}
 
-		if (osnoise_trace_is_off(tool, record))
-			break;
-	}
+static int osnoise_hist_main_loop(struct osnoise_tool *tool)
+{
+	int retval;
 
+	retval = hist_main_loop(tool);
 	osnoise_read_trace_hist(tool);
 
-	osnoise_print_stats(params, tool);
-
-	return_value = PASSED;
-
-	if (osnoise_trace_is_off(tool, record)) {
-		printf("rtla osnoise hit stop tracing\n");
-		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
-		return_value = FAILED;
-	}
-
-out_hist:
-	trace_events_destroy(&record->trace, params->common.events);
-	params->common.events = NULL;
-out_free:
-	osnoise_free_histogram(tool->data);
-out_destroy:
-	osnoise_destroy_tool(record);
-	osnoise_destroy_tool(tool);
-	free(params);
-out_exit:
-	exit(return_value);
+	return retval;
 }
+
+struct tool_ops osnoise_hist_ops = {
+	.tracer = "osnoise",
+	.comm_prefix = "osnoise/",
+	.parse_args = osnoise_hist_parse_args,
+	.init_tool = osnoise_init_hist,
+	.apply_config = osnoise_hist_apply_config,
+	.enable = osnoise_hist_enable,
+	.main = osnoise_hist_main_loop,
+	.print_stats = osnoise_print_stats,
+	.free = osnoise_free_hist_tool,
+};
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 7c68feed300e..5a56c276f9da 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -37,13 +37,17 @@ struct osnoise_top_data {
 /*
  * osnoise_free_top - free runtime data
  */
-static void
-osnoise_free_top(struct osnoise_top_data *data)
+static void osnoise_free_top(struct osnoise_top_data *data)
 {
 	free(data->cpu_data);
 	free(data);
 }
 
+static void osnoise_free_top_tool(struct osnoise_tool *tool)
+{
+	osnoise_free_top(tool->data);
+}
+
 /*
  * osnoise_alloc_histogram - alloc runtime data
  */
@@ -123,7 +127,7 @@ osnoise_top_handler(struct trace_seq *s, struct tep_record *record,
  */
 static void osnoise_top_header(struct osnoise_tool *top)
 {
-	struct osnoise_params *params = top->params;
+	struct osnoise_params *params = to_osnoise_params(top->params);
 	struct trace_seq *s = top->trace.seq;
 	bool pretty = params->common.pretty_output;
 	char duration[26];
@@ -184,7 +188,7 @@ static void clear_terminal(struct trace_seq *seq)
  */
 static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
 {
-	struct osnoise_params *params = tool->params;
+	struct osnoise_params *params = to_osnoise_params(tool->params);
 	struct trace_seq *s = tool->trace.seq;
 	struct osnoise_top_cpu *cpu_data;
 	struct osnoise_top_data *data;
@@ -224,8 +228,9 @@ static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
  * osnoise_print_stats - print data for all cpus
  */
 static void
-osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *top)
+osnoise_print_stats(struct osnoise_tool *top)
 {
+	struct osnoise_params *params = to_osnoise_params(top->params);
 	struct trace_instance *trace = &top->trace;
 	static int nr_cpus = -1;
 	int i;
@@ -320,17 +325,21 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 /*
  * osnoise_top_parse_args - allocs, parse and fill the cmd line parameters
  */
-struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
+struct common_params *osnoise_top_parse_args(int argc, char **argv)
 {
 	struct osnoise_params *params;
 	struct trace_events *tevent;
 	int retval;
 	int c;
+	char *trace_output = NULL;
 
 	params = calloc(1, sizeof(*params));
 	if (!params)
 		exit(1);
 
+	actions_init(&params->common.threshold_actions);
+	actions_init(&params->common.end_actions);
+
 	if (strcmp(argv[0], "hwnoise") == 0) {
 		params->mode = MODE_HWNOISE;
 		/*
@@ -384,7 +393,7 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			params->threshold = 1;
 
 			/* set trace */
-			params->trace_output = "osnoise_trace.txt";
+			trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'c':
@@ -463,13 +472,13 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
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
-				params->trace_output = "osnoise_trace.txt";
+				trace_output = "osnoise_trace.txt";
 			break;
 		case 'T':
 			params->threshold = get_llong_from_str(optarg);
@@ -507,20 +516,24 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 		}
 	}
 
+	if (trace_output)
+		actions_add_trace_output(&params->common.threshold_actions, trace_output);
+
 	if (geteuid()) {
 		err_msg("osnoise needs root permission\n");
 		exit(EXIT_FAILURE);
 	}
 
-	return params;
+	return &params->common;
 }
 
 /*
  * osnoise_top_apply_config - apply the top configs to the initialized tool
  */
 static int
-osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
+osnoise_top_apply_config(struct osnoise_tool *tool)
 {
+	struct osnoise_params *params = to_osnoise_params(tool->params);
 	int retval;
 
 	retval = osnoise_apply_config(tool, params);
@@ -547,7 +560,7 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_params *param
 /*
  * osnoise_init_top - initialize a osnoise top tool with parameters
  */
-struct osnoise_tool *osnoise_init_top(struct osnoise_params *params)
+struct osnoise_tool *osnoise_init_top(struct common_params *params)
 {
 	struct osnoise_tool *tool;
 	int nr_cpus;
@@ -564,175 +577,20 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_params *params)
 		return NULL;
 	}
 
-	tool->params = params;
-
 	tep_register_event_handler(tool->trace.tep, -1, "ftrace", "osnoise",
 				   osnoise_top_handler, NULL);
 
 	return tool;
 }
 
-static int stop_tracing;
-static void stop_top(int sig)
-{
-	stop_tracing = 1;
-}
-
-/*
- * osnoise_top_set_signals - handles the signal to stop the tool
- */
-static void osnoise_top_set_signals(struct osnoise_params *params)
-{
-	signal(SIGINT, stop_top);
-	if (params->common.duration) {
-		signal(SIGALRM, stop_top);
-		alarm(params->common.duration);
-	}
-}
-
-int osnoise_top_main(int argc, char **argv)
-{
-	struct osnoise_params *params;
-	struct osnoise_tool *record = NULL;
-	struct osnoise_tool *tool = NULL;
-	enum result return_value = ERROR;
-	struct trace_instance *trace;
-	int retval;
-
-	params = osnoise_top_parse_args(argc, argv);
-	if (!params)
-		exit(1);
-
-	tool = osnoise_init_top(params);
-	if (!tool) {
-		err_msg("Could not init osnoise top\n");
-		goto out_exit;
-	}
-
-	retval = osnoise_top_apply_config(tool, params);
-	if (retval) {
-		err_msg("Could not apply config\n");
-		goto out_free;
-	}
-
-	trace = &tool->trace;
-
-	retval = enable_osnoise(trace);
-	if (retval) {
-		err_msg("Failed to enable osnoise tracer\n");
-		goto out_free;
-	}
-
-	if (params->common.set_sched) {
-		retval = set_comm_sched_attr("osnoise/", &params->common.sched_param);
-		if (retval) {
-			err_msg("Failed to set sched parameters\n");
-			goto out_free;
-		}
-	}
-
-	if (params->common.cgroup) {
-		retval = set_comm_cgroup("osnoise/", params->common.cgroup_name);
-		if (!retval) {
-			err_msg("Failed to move threads to cgroup\n");
-			goto out_free;
-		}
-	}
-
-	if (params->trace_output) {
-		record = osnoise_init_trace_tool("osnoise");
-		if (!record) {
-			err_msg("Failed to enable the trace instance\n");
-			goto out_free;
-		}
-
-		if (params->common.events) {
-			retval = trace_events_enable(&record->trace, params->common.events);
-			if (retval)
-				goto out_top;
-		}
-
-		if (params->common.buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
-			if (retval)
-				goto out_top;
-		}
-	}
-
-	/*
-	 * Start the tracer here, after having set all instances.
-	 *
-	 * Let the trace instance start first for the case of hitting a stop
-	 * tracing while enabling other instances. The trace instance is the
-	 * one with most valuable information.
-	 */
-	if (params->trace_output)
-		trace_instance_start(&record->trace);
-	trace_instance_start(trace);
-
-	if (params->common.warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->common.warmup);
-		sleep(params->common.warmup);
-		if (stop_tracing)
-			goto out_top;
-
-		/*
-		 * Clean up the buffer. The osnoise workload do not run
-		 * with tracing off to avoid creating a performance penalty
-		 * when not needed.
-		 */
-		retval = tracefs_instance_file_write(trace->inst, "trace", "");
-		if (retval < 0) {
-			debug_msg("Error cleaning up the buffer");
-			goto out_top;
-		}
-
-	}
-
-	tool->start_time = time(NULL);
-	osnoise_top_set_signals(params);
-
-	while (!stop_tracing) {
-		sleep(params->common.sleep_time);
-
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
-		if (!params->common.quiet)
-			osnoise_print_stats(params, tool);
-
-		if (osnoise_trace_is_off(tool, record))
-			break;
-
-	}
-
-	osnoise_print_stats(params, tool);
-
-	return_value = PASSED;
-
-	if (osnoise_trace_is_off(tool, record)) {
-		printf("osnoise hit stop tracing\n");
-		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
-		return_value = FAILED;
-	}
-
-out_top:
-	trace_events_destroy(&record->trace, params->common.events);
-	params->common.events = NULL;
-out_free:
-	osnoise_free_top(tool->data);
-	osnoise_destroy_tool(record);
-	osnoise_destroy_tool(tool);
-	free(params);
-out_exit:
-	exit(return_value);
-}
+struct tool_ops osnoise_top_ops = {
+	.tracer = "osnoise",
+	.comm_prefix = "osnoise/",
+	.parse_args = osnoise_top_parse_args,
+	.init_tool = osnoise_init_top,
+	.apply_config = osnoise_top_apply_config,
+	.enable = osnoise_enable,
+	.main = top_main_loop,
+	.print_stats = osnoise_print_stats,
+	.free = osnoise_free_top_tool,
+};
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index e4bf58db1dd2..b69212874127 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -15,9 +15,13 @@
 #include <sched.h>
 
 #include "timerlat.h"
+#include "timerlat_aa.h"
+#include "timerlat_bpf.h"
 
 #define DEFAULT_TIMERLAT_PERIOD	1000			/* 1ms */
 
+static int dma_latency_fd = -1;
+
 /*
  * timerlat_apply_config - apply common configs to the initialized tool
  */
@@ -26,6 +30,24 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
 	int retval;
 
+	/*
+	 * Try to enable BPF, unless disabled explicitly.
+	 * If BPF enablement fails, fall back to tracefs mode.
+	 */
+	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
+		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
+		params->mode = TRACING_MODE_TRACEFS;
+	} else if (!tep_find_event_by_name(tool->trace.tep, "osnoise", "timerlat_sample")) {
+		debug_msg("osnoise:timerlat_sample missing, disabling BPF\n");
+		params->mode = TRACING_MODE_TRACEFS;
+	} else {
+		retval = timerlat_bpf_init(params);
+		if (retval) {
+			debug_msg("Could not enable BPF\n");
+			params->mode = TRACING_MODE_TRACEFS;
+		}
+	}
+
 	if (params->mode != TRACING_MODE_BPF) {
 		/*
 		 * In tracefs and mixed mode, timerlat tracer handles stopping
@@ -65,12 +87,12 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 	 * If the user did not specify a type of thread, try user-threads first.
 	 * Fall back to kernel threads otherwise.
 	 */
-	if (!params->common.kernel_workload && !params->user_data) {
+	if (!params->common.kernel_workload && !params->common.user_data) {
 		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
 		if (retval) {
 			debug_msg("User-space interface detected, setting user-threads\n");
-			params->user_workload = 1;
-			params->user_data = 1;
+			params->common.user_workload = 1;
+			params->common.user_data = 1;
 		} else {
 			debug_msg("User-space interface not detected, setting kernel-threads\n");
 			params->common.kernel_workload = 1;
@@ -83,6 +105,137 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 	return -1;
 }
 
+int timerlat_enable(struct osnoise_tool *tool)
+{
+	struct timerlat_params *params = to_timerlat_params(tool->params);
+	int retval, nr_cpus, i;
+
+	if (params->dma_latency >= 0) {
+		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
+		if (dma_latency_fd < 0) {
+			err_msg("Could not set /dev/cpu_dma_latency.\n");
+			return -1;
+		}
+	}
+
+	if (params->deepest_idle_state >= -1) {
+		if (!have_libcpupower_support()) {
+			err_msg("rtla built without libcpupower, --deepest-idle-state is not supported\n");
+			return -1;
+		}
+
+		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+		for (i = 0; i < nr_cpus; i++) {
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
+				continue;
+			if (save_cpu_idle_disable_state(i) < 0) {
+				err_msg("Could not save cpu idle state.\n");
+				return -1;
+			}
+			if (set_deepest_cpu_idle_state(i, params->deepest_idle_state) < 0) {
+				err_msg("Could not set deepest cpu idle state.\n");
+				return -1;
+			}
+		}
+	}
+
+	if (!params->no_aa) {
+		tool->aa = osnoise_init_tool("timerlat_aa");
+		if (!tool->aa)
+			return -1;
+
+		retval = timerlat_aa_init(tool->aa, params->dump_tasks);
+		if (retval) {
+			err_msg("Failed to enable the auto analysis instance\n");
+			return retval;
+		}
+
+		retval = enable_tracer_by_name(tool->aa->trace.inst, "timerlat");
+		if (retval) {
+			err_msg("Failed to enable aa tracer\n");
+			return retval;
+		}
+	}
+
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
+		if (stop_tracing)
+			return -1;
+	}
+
+	/*
+	 * Start the tracers here, after having set all instances.
+	 *
+	 * Let the trace instance start first for the case of hitting a stop
+	 * tracing while enabling other instances. The trace instance is the
+	 * one with most valuable information.
+	 */
+	if (tool->record)
+		trace_instance_start(&tool->record->trace);
+	if (!params->no_aa)
+		trace_instance_start(&tool->aa->trace);
+	if (params->mode == TRACING_MODE_TRACEFS) {
+		trace_instance_start(&tool->trace);
+	} else {
+		retval = timerlat_bpf_attach();
+		if (retval) {
+			err_msg("Error attaching BPF program\n");
+			return retval;
+		}
+	}
+
+	return 0;
+}
+
+void timerlat_analyze(struct osnoise_tool *tool, bool stopped)
+{
+	struct timerlat_params *params = to_timerlat_params(tool->params);
+
+	if (stopped) {
+		if (!params->no_aa)
+			timerlat_auto_analysis(params->common.stop_us,
+					       params->common.stop_total_us);
+	} else if (params->common.aa_only) {
+		char *max_lat;
+
+		/*
+		 * If the trace did not stop with --aa-only, at least print
+		 * the max known latency.
+		 */
+		max_lat = tracefs_instance_file_read(trace_inst->inst, "tracing_max_latency", NULL);
+		if (max_lat) {
+			printf("  Max latency was %s\n", max_lat);
+			free(max_lat);
+		}
+	}
+}
+
+void timerlat_free(struct osnoise_tool *tool)
+{
+	struct timerlat_params *params = to_timerlat_params(tool->params);
+	int nr_cpus, i;
+
+	timerlat_aa_destroy();
+	if (dma_latency_fd >= 0)
+		close(dma_latency_fd);
+	if (params->deepest_idle_state >= -1) {
+		for (i = 0; i < nr_cpus; i++) {
+			if (params->common.cpus &&
+			    !CPU_ISSET(i, &params->common.monitored_cpus))
+				continue;
+			restore_cpu_idle_disable_state(i);
+		}
+	}
+
+	osnoise_destroy_tool(tool->aa);
+
+	if (params->mode != TRACING_MODE_TRACEFS)
+		timerlat_bpf_destroy();
+	free_cpu_idle_disable_states();
+}
+
 static void timerlat_usage(int err)
 {
 	int i;
@@ -116,7 +269,7 @@ int timerlat_main(int argc, char *argv[])
 	 * default cmdline.
 	 */
 	if (argc == 1) {
-		timerlat_top_main(argc, argv);
+		run_tool(&timerlat_top_ops, argc, argv);
 		exit(0);
 	}
 
@@ -124,13 +277,13 @@ int timerlat_main(int argc, char *argv[])
 		timerlat_usage(0);
 	} else if (strncmp(argv[1], "-", 1) == 0) {
 		/* the user skipped the tool, call the default one */
-		timerlat_top_main(argc, argv);
+		run_tool(&timerlat_top_ops, argc, argv);
 		exit(0);
 	} else if (strcmp(argv[1], "top") == 0) {
-		timerlat_top_main(argc-1, &argv[1]);
+		run_tool(&timerlat_top_ops, argc-1, &argv[1]);
 		exit(0);
 	} else if (strcmp(argv[1], "hist") == 0) {
-		timerlat_hist_main(argc-1, &argv[1]);
+		run_tool(&timerlat_hist_ops, argc-1, &argv[1]);
 		exit(0);
 	}
 
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 86cd9bac8855..fd6065f48bb7 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "actions.h"
 #include "osnoise.h"
 
 /*
@@ -26,18 +25,15 @@ struct timerlat_params {
 	int			dma_latency;
 	int			no_aa;
 	int			dump_tasks;
-	int			user_workload;
-	int			user_data;
 	int			deepest_idle_state;
-	int			aa_only;
 	enum timerlat_tracing_mode mode;
-
-	struct actions threshold_actions;
-	struct actions end_actions;
 };
 
-int timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params);
+#define to_timerlat_params(ptr) container_of(ptr, struct timerlat_params, common)
 
-int timerlat_hist_main(int argc, char *argv[]);
-int timerlat_top_main(int argc, char *argv[]);
+int timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params);
 int timerlat_main(int argc, char *argv[]);
+int timerlat_enable(struct osnoise_tool *tool);
+void timerlat_analyze(struct osnoise_tool *tool, bool stopped);
+void timerlat_free(struct osnoise_tool *tool);
+
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 03be2606f54a..e97d16646bcd 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -25,7 +25,7 @@ int timerlat_bpf_init(struct timerlat_params *params)
 	bpf->rodata->entries = params->common.hist.entries;
 	bpf->rodata->irq_threshold = params->common.stop_us;
 	bpf->rodata->thread_threshold = params->common.stop_total_us;
-	bpf->rodata->aa_only = params->aa_only;
+	bpf->rodata->aa_only = params->common.aa_only;
 
 	if (params->common.hist.entries != 0) {
 		/* Pass histogram options */
@@ -42,7 +42,7 @@ int timerlat_bpf_init(struct timerlat_params *params)
 		bpf_map__set_autocreate(bpf->maps.hist_user, false);
 	}
 
-	if (params->aa_only) {
+	if (params->common.aa_only) {
 		/* Auto-analysis only, disable summary */
 		bpf_map__set_autocreate(bpf->maps.summary_irq, false);
 		bpf_map__set_autocreate(bpf->maps.summary_thread, false);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index d339e2cffae2..a9154f83f1a9 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -16,7 +16,6 @@
 
 #include "timerlat.h"
 #include "timerlat_aa.h"
-#include "timerlat_u.h"
 #include "timerlat_bpf.h"
 
 struct timerlat_hist_cpu {
@@ -72,8 +71,12 @@ timerlat_free_histogram(struct timerlat_hist_data *data)
 	/* one set of histograms per CPU */
 	if (data->hist)
 		free(data->hist);
+}
 
-	free(data);
+static void timerlat_free_histogram_tool(struct osnoise_tool *tool)
+{
+	timerlat_free_histogram(tool->data);
+	timerlat_free(tool);
 }
 
 /*
@@ -135,7 +138,7 @@ timerlat_hist_update(struct osnoise_tool *tool, int cpu,
 		     unsigned long long context,
 		     unsigned long long latency)
 {
-	struct timerlat_params *params = tool->params;
+	struct timerlat_params *params = to_timerlat_params(tool->params);
 	struct timerlat_hist_data *data = tool->data;
 	int entries = data->entries;
 	int bucket;
@@ -282,7 +285,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
  */
 static void timerlat_hist_header(struct osnoise_tool *tool)
 {
-	struct timerlat_params *params = tool->params;
+	struct timerlat_params *params = to_timerlat_params(tool->params);
 	struct timerlat_hist_data *data = tool->data;
 	struct trace_seq *s = tool->trace.seq;
 	char duration[26];
@@ -315,7 +318,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 		if (!params->common.hist.no_thread)
 			trace_seq_printf(s, "   Thr-%03d", cpu);
 
-		if (params->user_data)
+		if (params->common.user_data)
 			trace_seq_printf(s, "   Usr-%03d", cpu);
 	}
 	trace_seq_printf(s, "\n");
@@ -371,7 +374,7 @@ timerlat_print_summary(struct timerlat_params *params,
 			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].thread_count);
 
-		if (params->user_data)
+		if (params->common.user_data)
 			trace_seq_printf(trace->seq, "%9llu ",
 					 data->hist[cpu].user_count);
 	}
@@ -399,7 +402,7 @@ timerlat_print_summary(struct timerlat_params *params,
 					     data->hist[cpu].min_thread,
 					     false);
 
-		if (params->user_data)
+		if (params->common.user_data)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].user_count,
 					     data->hist[cpu].min_user,
@@ -429,7 +432,7 @@ timerlat_print_summary(struct timerlat_params *params,
 					     data->hist[cpu].sum_thread,
 					     true);
 
-		if (params->user_data)
+		if (params->common.user_data)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].user_count,
 					     data->hist[cpu].sum_user,
@@ -459,7 +462,7 @@ timerlat_print_summary(struct timerlat_params *params,
 					     data->hist[cpu].max_thread,
 					     false);
 
-		if (params->user_data)
+		if (params->common.user_data)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].user_count,
 					     data->hist[cpu].max_user,
@@ -521,7 +524,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	if (!params->common.hist.no_thread)
 		trace_seq_printf(trace->seq, "       Thr");
 
-	if (params->user_data)
+	if (params->common.user_data)
 		trace_seq_printf(trace->seq, "       Usr");
 
 	trace_seq_printf(trace->seq, "\n");
@@ -537,7 +540,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.thread_count);
 
-	if (params->user_data)
+	if (params->common.user_data)
 		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.user_count);
 
@@ -558,7 +561,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 				     sum.min_thread,
 				     false);
 
-	if (params->user_data)
+	if (params->common.user_data)
 		format_summary_value(trace->seq,
 				     sum.user_count,
 				     sum.min_user,
@@ -581,7 +584,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 				     sum.sum_thread,
 				     true);
 
-	if (params->user_data)
+	if (params->common.user_data)
 		format_summary_value(trace->seq,
 				     sum.user_count,
 				     sum.sum_user,
@@ -604,7 +607,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 				     sum.max_thread,
 				     false);
 
-	if (params->user_data)
+	if (params->common.user_data)
 		format_summary_value(trace->seq,
 				     sum.user_count,
 				     sum.max_user,
@@ -619,8 +622,9 @@ timerlat_print_stats_all(struct timerlat_params *params,
  * timerlat_print_stats - print data for each CPUs
  */
 static void
-timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
+timerlat_print_stats(struct osnoise_tool *tool)
 {
+	struct timerlat_params *params = to_timerlat_params(tool->params);
 	struct timerlat_hist_data *data = tool->data;
 	struct trace_instance *trace = &tool->trace;
 	int bucket, cpu;
@@ -654,7 +658,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 						data->hist[cpu].thread[bucket]);
 			}
 
-			if (params->user_data) {
+			if (params->common.user_data) {
 				total += data->hist[cpu].user[bucket];
 				trace_seq_printf(trace->seq, "%9d ",
 						data->hist[cpu].user[bucket]);
@@ -690,7 +694,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%9d ",
 					 data->hist[cpu].thread[data->entries]);
 
-		if (params->user_data)
+		if (params->common.user_data)
 			trace_seq_printf(trace->seq, "%9d ",
 					 data->hist[cpu].user[data->entries]);
 	}
@@ -780,7 +784,7 @@ static void timerlat_hist_usage(char *usage)
 /*
  * timerlat_hist_parse_args - allocs, parse and fill the cmd line parameters
  */
-static struct timerlat_params
+static struct common_params
 *timerlat_hist_parse_args(int argc, char *argv[])
 {
 	struct timerlat_params *params;
@@ -794,8 +798,8 @@ static struct timerlat_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->threshold_actions);
-	actions_init(&params->end_actions);
+	actions_init(&params->common.threshold_actions);
+	actions_init(&params->common.end_actions);
 
 	/* disabled by default */
 	params->dma_latency = -1;
@@ -975,10 +979,10 @@ static struct timerlat_params
 				trace_output = "timerlat_trace.txt";
 			break;
 		case 'u':
-			params->user_workload = 1;
+			params->common.user_workload = 1;
 			/* fallback: -u implies in -U */
 		case 'U':
-			params->user_data = 1;
+			params->common.user_data = 1;
 			break;
 		case '0': /* no irq */
 			params->common.hist.no_irq = 1;
@@ -1043,14 +1047,14 @@ static struct timerlat_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '\5':
-			retval = actions_parse(&params->threshold_actions, optarg);
+			retval = actions_parse(&params->common.threshold_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case '\6':
-			retval = actions_parse(&params->end_actions, optarg);
+			retval = actions_parse(&params->common.end_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
@@ -1062,7 +1066,7 @@ static struct timerlat_params
 	}
 
 	if (trace_output)
-		actions_add_trace_output(&params->threshold_actions, trace_output);
+		actions_add_trace_output(&params->common.threshold_actions, trace_output);
 
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
@@ -1081,7 +1085,7 @@ static struct timerlat_params
 	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
-	if (params->common.kernel_workload && params->user_workload)
+	if (params->common.kernel_workload && params->common.user_workload)
 		timerlat_hist_usage("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
@@ -1089,19 +1093,21 @@ static struct timerlat_params
 	 * mixed mode
 	 */
 	if (params->mode == TRACING_MODE_BPF &&
-	    (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
-	     params->end_actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
+	    (params->common.threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	     params->common.end_actions.present[ACTION_TRACE_OUTPUT] ||
+	     !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
-	return params;
+	return &params->common;
 }
 
 /*
  * timerlat_hist_apply_config - apply the hist configs to the initialized tool
  */
 static int
-timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
+timerlat_hist_apply_config(struct osnoise_tool *tool)
 {
+	struct timerlat_params *params = to_timerlat_params(tool->params);
 	int retval;
 
 	retval = timerlat_apply_config(tool, params);
@@ -1118,7 +1124,7 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_params *pa
  * timerlat_init_hist - initialize a timerlat hist tool with parameters
  */
 static struct osnoise_tool
-*timerlat_init_hist(struct timerlat_params *params)
+*timerlat_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
 	int nr_cpus;
@@ -1129,13 +1135,11 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = timerlat_alloc_histogram(nr_cpus, params->common.hist.entries,
-					      params->common.hist.bucket_size);
+	tool->data = timerlat_alloc_histogram(nr_cpus, params->hist.entries,
+					      params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
 
-	tool->params = params;
-
 	tep_register_event_handler(tool->trace.tep, -1, "ftrace", "timerlat",
 				   timerlat_hist_handler, tool);
 
@@ -1146,349 +1150,61 @@ static struct osnoise_tool
 	return NULL;
 }
 
-static int stop_tracing;
-static struct trace_instance *hist_inst = NULL;
-static void stop_hist(int sig)
-{
-	if (stop_tracing) {
-		/*
-		 * Stop requested twice in a row; abort event processing and
-		 * exit immediately
-		 */
-		tracefs_iterate_stop(hist_inst->inst);
-		return;
-	}
-	stop_tracing = 1;
-	if (hist_inst)
-		trace_instance_stop(hist_inst);
-}
-
-/*
- * timerlat_hist_set_signals - handles the signal to stop the tool
- */
-static void
-timerlat_hist_set_signals(struct timerlat_params *params)
+static int timerlat_hist_bpf_main_loop(struct osnoise_tool *tool)
 {
-	signal(SIGINT, stop_hist);
-	if (params->common.duration) {
-		signal(SIGALRM, stop_hist);
-		alarm(params->common.duration);
-	}
-}
-
-int timerlat_hist_main(int argc, char *argv[])
-{
-	struct timerlat_params *params;
-	struct osnoise_tool *record = NULL;
-	struct timerlat_u_params params_u;
-	enum result return_value = ERROR;
-	struct osnoise_tool *tool = NULL;
-	struct osnoise_tool *aa = NULL;
-	struct trace_instance *trace;
-	int dma_latency_fd = -1;
-	pthread_t timerlat_u;
+	struct timerlat_params *params = to_timerlat_params(tool->params);
 	int retval;
-	int nr_cpus, i;
-
-	params = timerlat_hist_parse_args(argc, argv);
-	if (!params)
-		exit(1);
-
-	tool = timerlat_init_hist(params);
-	if (!tool) {
-		err_msg("Could not init osnoise hist\n");
-		goto out_exit;
-	}
-
-	trace = &tool->trace;
-	/*
-	 * Save trace instance into global variable so that SIGINT can stop
-	 * the timerlat tracer.
-	 * Otherwise, rtla could loop indefinitely when overloaded.
-	 */
-	hist_inst = trace;
-
-	/*
-	 * Try to enable BPF, unless disabled explicitly.
-	 * If BPF enablement fails, fall back to tracefs mode.
-	 */
-	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
-		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
-		params->mode = TRACING_MODE_TRACEFS;
-	} else if (!tep_find_event_by_name(trace->tep, "osnoise", "timerlat_sample")) {
-		debug_msg("osnoise:timerlat_sample missing, disabling BPF\n");
-		params->mode = TRACING_MODE_TRACEFS;
-	} else {
-		retval = timerlat_bpf_init(params);
-		if (retval) {
-			debug_msg("Could not enable BPF\n");
-			params->mode = TRACING_MODE_TRACEFS;
-		}
-	}
-
-	retval = timerlat_hist_apply_config(tool, params);
-	if (retval) {
-		err_msg("Could not apply config\n");
-		goto out_free;
-	}
-
-	retval = enable_timerlat(trace);
-	if (retval) {
-		err_msg("Failed to enable timerlat tracer\n");
-		goto out_free;
-	}
-
-	if (params->common.set_sched) {
-		retval = set_comm_sched_attr("timerlat/", &params->common.sched_param);
-		if (retval) {
-			err_msg("Failed to set sched parameters\n");
-			goto out_free;
-		}
-	}
-
-	if (params->common.cgroup && !params->user_workload) {
-		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
-		if (!retval) {
-			err_msg("Failed to move threads to cgroup\n");
-			goto out_free;
-		}
-	}
-
-	if (params->dma_latency >= 0) {
-		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
-		if (dma_latency_fd < 0) {
-			err_msg("Could not set /dev/cpu_dma_latency.\n");
-			goto out_free;
-		}
-	}
-
-	if (params->deepest_idle_state >= -1) {
-		if (!have_libcpupower_support()) {
-			err_msg("rtla built without libcpupower, --deepest-idle-state is not supported\n");
-			goto out_free;
-		}
-
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
-		for (i = 0; i < nr_cpus; i++) {
-			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
-				continue;
-			if (save_cpu_idle_disable_state(i) < 0) {
-				err_msg("Could not save cpu idle state.\n");
-				goto out_free;
-			}
-			if (set_deepest_cpu_idle_state(i, params->deepest_idle_state) < 0) {
-				err_msg("Could not set deepest cpu idle state.\n");
-				goto out_free;
-			}
-		}
-	}
-
-	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
-	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
-		record = osnoise_init_trace_tool("timerlat");
-		if (!record) {
-			err_msg("Failed to enable the trace instance\n");
-			goto out_free;
-		}
-		params->threshold_actions.trace_output_inst = record->trace.inst;
-		params->end_actions.trace_output_inst = record->trace.inst;
-
-		if (params->common.events) {
-			retval = trace_events_enable(&record->trace, params->common.events);
-			if (retval)
-				goto out_hist;
-		}
 
-		if (params->common.buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
-			if (retval)
-				goto out_hist;
-		}
-	}
+	while (!stop_tracing) {
+		timerlat_bpf_wait(-1);
 
-	if (!params->no_aa) {
-		aa = osnoise_init_tool("timerlat_aa");
-		if (!aa)
-			goto out_hist;
+		if (!stop_tracing) {
+			/* Threshold overflow, perform actions on threshold */
+			actions_perform(&params->common.threshold_actions);
 
-		retval = timerlat_aa_init(aa, params->dump_tasks);
-		if (retval) {
-			err_msg("Failed to enable the auto analysis instance\n");
-			goto out_hist;
-		}
+			if (!params->common.threshold_actions.continue_flag)
+				/* continue flag not set, break */
+				break;
 
-		retval = enable_timerlat(&aa->trace);
-		if (retval) {
-			err_msg("Failed to enable timerlat tracer\n");
-			goto out_hist;
+			/* continue action reached, re-enable tracing */
+			if (tool->record)
+				trace_instance_start(&tool->record->trace);
+			if (tool->aa)
+				trace_instance_start(&tool->aa->trace);
+			timerlat_bpf_restart_tracing();
 		}
 	}
+	timerlat_bpf_detach();
 
-	if (params->user_workload) {
-		/* rtla asked to stop */
-		params_u.should_run = 1;
-		/* all threads left */
-		params_u.stopped_running = 0;
-
-		params_u.set = &params->common.monitored_cpus;
-		if (params->common.set_sched)
-			params_u.sched_param = &params->common.sched_param;
-		else
-			params_u.sched_param = NULL;
-
-		params_u.cgroup_name = params->common.cgroup_name;
-
-		retval = pthread_create(&timerlat_u, NULL, timerlat_u_dispatcher, &params_u);
-		if (retval)
-			err_msg("Error creating timerlat user-space threads\n");
-	}
-
-	if (params->common.warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->common.warmup);
-		sleep(params->common.warmup);
-		if (stop_tracing)
-			goto out_hist;
-	}
-
-	/*
-	 * Start the tracers here, after having set all instances.
-	 *
-	 * Let the trace instance start first for the case of hitting a stop
-	 * tracing while enabling other instances. The trace instance is the
-	 * one with most valuable information.
-	 */
-	if (record)
-		trace_instance_start(&record->trace);
-	if (!params->no_aa)
-		trace_instance_start(&aa->trace);
-	if (params->mode == TRACING_MODE_TRACEFS) {
-		trace_instance_start(trace);
-	} else {
-		retval = timerlat_bpf_attach();
-		if (retval) {
-			err_msg("Error attaching BPF program\n");
-			goto out_hist;
-		}
-	}
-
-	tool->start_time = time(NULL);
-	timerlat_hist_set_signals(params);
-
-	if (params->mode == TRACING_MODE_TRACEFS) {
-		while (!stop_tracing) {
-			sleep(params->common.sleep_time);
-
-			retval = tracefs_iterate_raw_events(trace->tep,
-							    trace->inst,
-							    NULL,
-							    0,
-							    collect_registered_events,
-							    trace);
-			if (retval < 0) {
-				err_msg("Error iterating on events\n");
-				goto out_hist;
-			}
-
-			if (osnoise_trace_is_off(tool, record)) {
-				actions_perform(&params->threshold_actions);
-
-				if (!params->threshold_actions.continue_flag)
-					/* continue flag not set, break */
-					break;
-
-				/* continue action reached, re-enable tracing */
-				if (record)
-					trace_instance_start(&record->trace);
-				if (!params->no_aa)
-					trace_instance_start(&aa->trace);
-				trace_instance_start(trace);
-			}
-
-			/* is there still any user-threads ? */
-			if (params->user_workload) {
-				if (params_u.stopped_running) {
-					debug_msg("timerlat user-space threads stopped!\n");
-					break;
-				}
-			}
-		}
-	} else {
-		while (!stop_tracing) {
-			timerlat_bpf_wait(-1);
-
-			if (!stop_tracing) {
-				/* Threshold overflow, perform actions on threshold */
-				actions_perform(&params->threshold_actions);
-
-				if (!params->threshold_actions.continue_flag)
-					/* continue flag not set, break */
-					break;
-
-				/* continue action reached, re-enable tracing */
-				if (record)
-					trace_instance_start(&record->trace);
-				if (!params->no_aa)
-					trace_instance_start(&aa->trace);
-				timerlat_bpf_restart_tracing();
-			}
-		}
-	}
-
-	if (params->mode != TRACING_MODE_TRACEFS) {
-		timerlat_bpf_detach();
-		retval = timerlat_hist_bpf_pull_data(tool);
-		if (retval) {
-			err_msg("Error pulling BPF data\n");
-			goto out_hist;
-		}
-	}
-
-	if (params->user_workload && !params_u.stopped_running) {
-		params_u.should_run = 0;
-		sleep(1);
-	}
-
-	timerlat_print_stats(params, tool);
-
-	actions_perform(&params->end_actions);
-
-	return_value = PASSED;
+	retval = timerlat_hist_bpf_pull_data(tool);
+	if (retval)
+		err_msg("Error pulling BPF data\n");
 
-	if (osnoise_trace_is_off(tool, record) && !stop_tracing) {
-		printf("rtla timerlat hit stop tracing\n");
+	return retval;
+}
 
-		if (!params->no_aa)
-			timerlat_auto_analysis(params->common.stop_us,
-					       params->common.stop_total_us);
+static int timerlat_hist_main(struct osnoise_tool *tool)
+{
+	struct timerlat_params *params = to_timerlat_params(tool->params);
+	int retval;
 
-		return_value = FAILED;
-	}
+	if (params->mode == TRACING_MODE_TRACEFS)
+		retval = hist_main_loop(tool);
+	else
+		retval = timerlat_hist_bpf_main_loop(tool);
 
-out_hist:
-	timerlat_aa_destroy();
-	if (dma_latency_fd >= 0)
-		close(dma_latency_fd);
-	if (params->deepest_idle_state >= -1) {
-		for (i = 0; i < nr_cpus; i++) {
-			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
-				continue;
-			restore_cpu_idle_disable_state(i);
-		}
-	}
-	trace_events_destroy(&record->trace, params->common.events);
-	params->common.events = NULL;
-out_free:
-	timerlat_free_histogram(tool->data);
-	osnoise_destroy_tool(aa);
-	osnoise_destroy_tool(record);
-	osnoise_destroy_tool(tool);
-	actions_destroy(&params->threshold_actions);
-	actions_destroy(&params->end_actions);
-	if (params->mode != TRACING_MODE_TRACEFS)
-		timerlat_bpf_destroy();
-	free(params);
-	free_cpu_idle_disable_states();
-out_exit:
-	exit(return_value);
+	return retval;
 }
+
+struct tool_ops timerlat_hist_ops = {
+	.tracer = "timerlat",
+	.comm_prefix = "timerlat/",
+	.parse_args = timerlat_hist_parse_args,
+	.init_tool = timerlat_init_hist,
+	.apply_config = timerlat_hist_apply_config,
+	.enable = timerlat_enable,
+	.main = timerlat_hist_main,
+	.print_stats = timerlat_print_stats,
+	.analyze = timerlat_analyze,
+	.free = timerlat_free_histogram_tool,
+};
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index bb42697d2575..42c3b0518749 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -17,7 +17,6 @@
 
 #include "timerlat.h"
 #include "timerlat_aa.h"
-#include "timerlat_u.h"
 #include "timerlat_bpf.h"
 
 struct timerlat_top_cpu {
@@ -49,13 +48,18 @@ struct timerlat_top_data {
 /*
  * timerlat_free_top - free runtime data
  */
-static void
-timerlat_free_top(struct timerlat_top_data *data)
+static void timerlat_free_top(struct timerlat_top_data *data)
 {
 	free(data->cpu_data);
 	free(data);
 }
 
+static void timerlat_free_top_tool(struct osnoise_tool *tool)
+{
+	timerlat_free_top(tool->data);
+	timerlat_free(tool);
+}
+
 /*
  * timerlat_alloc_histogram - alloc runtime data
  */
@@ -128,7 +132,7 @@ timerlat_top_update(struct osnoise_tool *tool, int cpu,
 		    unsigned long long thread,
 		    unsigned long long latency)
 {
-	struct timerlat_params *params = tool->params;
+	struct timerlat_params *params = to_timerlat_params(tool->params);
 	struct timerlat_top_data *data = tool->data;
 	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
 
@@ -164,15 +168,13 @@ timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
 		     struct tep_event *event, void *context)
 {
 	struct trace_instance *trace = context;
-	struct timerlat_params *params;
 	unsigned long long latency, thread;
 	struct osnoise_tool *top;
 	int cpu = record->cpu;
 
 	top = container_of(trace, struct osnoise_tool, trace);
-	params = top->params;
 
-	if (!params->aa_only) {
+	if (!top->params->aa_only) {
 		tep_get_field_val(s, event, "context", record, &thread, 1);
 		tep_get_field_val(s, event, "timer_latency", record, &latency, 1);
 
@@ -267,7 +269,7 @@ static void timerlat_top_header(struct timerlat_params *params, struct osnoise_t
 		trace_seq_printf(s, "\033[2;37;40m");
 
 	trace_seq_printf(s, "                                     Timer Latency                                              ");
-	if (params->user_data)
+	if (params->common.user_data)
 		trace_seq_printf(s, "                                         ");
 
 	if (pretty)
@@ -278,7 +280,7 @@ static void timerlat_top_header(struct timerlat_params *params, struct osnoise_t
 			params->common.output_divisor == 1 ? "ns" : "us",
 			params->common.output_divisor == 1 ? "ns" : "us");
 
-	if (params->user_data) {
+	if (params->common.user_data) {
 		trace_seq_printf(s, "      |    Ret user Timer Latency (%s)",
 				params->common.output_divisor == 1 ? "ns" : "us");
 	}
@@ -288,7 +290,7 @@ static void timerlat_top_header(struct timerlat_params *params, struct osnoise_t
 		trace_seq_printf(s, "\033[2;30;47m");
 
 	trace_seq_printf(s, "CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max");
-	if (params->user_data)
+	if (params->common.user_data)
 		trace_seq_printf(s, " |      cur       min       avg       max");
 
 	if (pretty)
@@ -303,8 +305,7 @@ static const char *no_value = "        -";
  */
 static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 {
-
-	struct timerlat_params *params = top->params;
+	struct timerlat_params *params = to_timerlat_params(top->params);
 	struct timerlat_top_data *data = top->data;
 	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
 	struct trace_seq *s = top->trace.seq;
@@ -339,7 +340,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 		trace_seq_printf(s, "%9llu", cpu_data->max_thread);
 	}
 
-	if (!params->user_data) {
+	if (!params->common.user_data) {
 		trace_seq_printf(s, "\n");
 		return;
 	}
@@ -364,7 +365,7 @@ static void
 timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summary)
 {
 	const char *split = "----------------------------------------";
-	struct timerlat_params *params = top->params;
+	struct timerlat_params *params = to_timerlat_params(top->params);
 	unsigned long long count = summary->irq_count;
 	struct trace_seq *s = top->trace.seq;
 	int e = 0;
@@ -381,7 +382,7 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
 	}
 
 	trace_seq_printf(s, "%.*s|%.*s|%.*s", 15, split, 40, split, 39, split);
-	if (params->user_data)
+	if (params->common.user_data)
 		trace_seq_printf(s, "-|%.*s", 39, split);
 	trace_seq_printf(s, "\n");
 
@@ -406,7 +407,7 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
 		trace_seq_printf(s, "%9llu", summary->max_thread);
 	}
 
-	if (!params->user_data) {
+	if (!params->common.user_data) {
 		trace_seq_printf(s, "\n");
 		return;
 	}
@@ -437,14 +438,15 @@ static void clear_terminal(struct trace_seq *seq)
  * timerlat_print_stats - print data for all cpus
  */
 static void
-timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *top)
+timerlat_print_stats(struct osnoise_tool *top)
 {
+	struct timerlat_params *params = to_timerlat_params(top->params);
 	struct trace_instance *trace = &top->trace;
 	struct timerlat_top_cpu summary;
 	static int nr_cpus = -1;
 	int i;
 
-	if (params->aa_only)
+	if (params->common.aa_only)
 		return;
 
 	if (nr_cpus == -1)
@@ -540,7 +542,7 @@ static void timerlat_top_usage(char *usage)
 /*
  * timerlat_top_parse_args - allocs, parse and fill the cmd line parameters
  */
-static struct timerlat_params
+static struct common_params
 *timerlat_top_parse_args(int argc, char **argv)
 {
 	struct timerlat_params *params;
@@ -554,8 +556,8 @@ static struct timerlat_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->threshold_actions);
-	actions_init(&params->end_actions);
+	actions_init(&params->common.threshold_actions);
+	actions_init(&params->common.end_actions);
 
 	/* disabled by default */
 	params->dma_latency = -1;
@@ -641,7 +643,7 @@ static struct timerlat_params
 			params->print_stack = auto_thresh;
 
 			/* set aa_only to avoid parsing the trace */
-			params->aa_only = 1;
+			params->common.aa_only = 1;
 			break;
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
@@ -731,10 +733,10 @@ static struct timerlat_params
 				trace_output = "timerlat_trace.txt";
 			break;
 		case 'u':
-			params->user_workload = true;
+			params->common.user_workload = true;
 			/* fallback: -u implies -U */
 		case 'U':
-			params->user_data = true;
+			params->common.user_data = true;
 			break;
 		case '0': /* trigger */
 			if (params->common.events) {
@@ -781,14 +783,14 @@ static struct timerlat_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '9':
-			retval = actions_parse(&params->threshold_actions, optarg);
+			retval = actions_parse(&params->common.threshold_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case '\1':
-			retval = actions_parse(&params->end_actions, optarg);
+			retval = actions_parse(&params->common.end_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
@@ -800,7 +802,7 @@ static struct timerlat_params
 	}
 
 	if (trace_output)
-		actions_add_trace_output(&params->threshold_actions, trace_output);
+		actions_add_trace_output(&params->common.threshold_actions, trace_output);
 
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
@@ -813,10 +815,10 @@ static struct timerlat_params
 	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
-	if (params->no_aa && params->aa_only)
+	if (params->no_aa && params->common.aa_only)
 		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
 
-	if (params->common.kernel_workload && params->user_workload)
+	if (params->common.kernel_workload && params->common.user_workload)
 		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
@@ -824,19 +826,21 @@ static struct timerlat_params
 	 * mixed mode
 	 */
 	if (params->mode == TRACING_MODE_BPF &&
-	    (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
-	     params->end_actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
+	    (params->common.threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	     params->common.end_actions.present[ACTION_TRACE_OUTPUT] ||
+	     !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
-	return params;
+	return &params->common;
 }
 
 /*
  * timerlat_top_apply_config - apply the top configs to the initialized tool
  */
 static int
-timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_params *params)
+timerlat_top_apply_config(struct osnoise_tool *top)
 {
+	struct timerlat_params *params = to_timerlat_params(top->params);
 	int retval;
 
 	retval = timerlat_apply_config(top, params);
@@ -856,7 +860,7 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_params *para
  * timerlat_init_top - initialize a timerlat top tool with parameters
  */
 static struct osnoise_tool
-*timerlat_init_top(struct timerlat_params *params)
+*timerlat_init_top(struct common_params *params)
 {
 	struct osnoise_tool *top;
 	int nr_cpus;
@@ -871,8 +875,6 @@ static struct osnoise_tool
 	if (!top->data)
 		goto out_err;
 
-	top->params = params;
-
 	tep_register_event_handler(top->trace.tep, -1, "ftrace", "timerlat",
 				   timerlat_top_handler, top);
 
@@ -883,109 +885,16 @@ static struct osnoise_tool
 	return NULL;
 }
 
-static int stop_tracing;
-static struct trace_instance *top_inst = NULL;
-static void stop_top(int sig)
-{
-	if (stop_tracing) {
-		/*
-		 * Stop requested twice in a row; abort event processing and
-		 * exit immediately
-		 */
-		tracefs_iterate_stop(top_inst->inst);
-		return;
-	}
-	stop_tracing = 1;
-	if (top_inst)
-		trace_instance_stop(top_inst);
-}
-
-/*
- * timerlat_top_set_signals - handles the signal to stop the tool
- */
-static void
-timerlat_top_set_signals(struct timerlat_params *params)
-{
-	signal(SIGINT, stop_top);
-	if (params->common.duration) {
-		signal(SIGALRM, stop_top);
-		alarm(params->common.duration);
-	}
-}
-
-/*
- * timerlat_top_main_loop - main loop to process events
- */
-static int
-timerlat_top_main_loop(struct osnoise_tool *top,
-		       struct osnoise_tool *record,
-		       struct osnoise_tool *aa,
-		       struct timerlat_params *params,
-		       struct timerlat_u_params *params_u)
-{
-	struct trace_instance *trace = &top->trace;
-	int retval;
-
-	while (!stop_tracing) {
-		sleep(params->common.sleep_time);
-
-		if (params->aa_only && !osnoise_trace_is_off(top, record))
-			continue;
-
-		retval = tracefs_iterate_raw_events(trace->tep,
-						    trace->inst,
-						    NULL,
-						    0,
-						    collect_registered_events,
-						    trace);
-		if (retval < 0) {
-			err_msg("Error iterating on events\n");
-			return retval;
-		}
-
-		if (!params->common.quiet)
-			timerlat_print_stats(params, top);
-
-		if (osnoise_trace_is_off(top, record)) {
-			actions_perform(&params->threshold_actions);
-
-			if (!params->threshold_actions.continue_flag)
-				/* continue flag not set, break */
-				break;
-
-			/* continue action reached, re-enable tracing */
-			if (record)
-				trace_instance_start(&record->trace);
-			if (!params->no_aa)
-				trace_instance_start(&aa->trace);
-			trace_instance_start(trace);
-		}
-
-		/* is there still any user-threads ? */
-		if (params->user_workload) {
-			if (params_u->stopped_running) {
-				debug_msg("timerlat user space threads stopped!\n");
-				break;
-			}
-		}
-	}
-
-	return 0;
-}
-
 /*
  * timerlat_top_bpf_main_loop - main loop to process events (BPF variant)
  */
 static int
-timerlat_top_bpf_main_loop(struct osnoise_tool *top,
-			   struct osnoise_tool *record,
-			   struct osnoise_tool *aa,
-			   struct timerlat_params *params,
-			   struct timerlat_u_params *params_u)
+__timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 {
+	struct timerlat_params *params = to_timerlat_params(tool->params);
 	int retval, wait_retval;
 
-	if (params->aa_only) {
+	if (params->common.aa_only) {
 		/* Auto-analysis only, just wait for stop tracing */
 		timerlat_bpf_wait(-1);
 		return 0;
@@ -996,34 +905,34 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 		wait_retval = timerlat_bpf_wait(params->common.quiet ? -1 :
 						params->common.sleep_time);
 
-		retval = timerlat_top_bpf_pull_data(top);
+		retval = timerlat_top_bpf_pull_data(tool);
 		if (retval) {
 			err_msg("Error pulling BPF data\n");
 			return retval;
 		}
 
 		if (!params->common.quiet)
-			timerlat_print_stats(params, top);
+			timerlat_print_stats(tool);
 
 		if (wait_retval == 1) {
 			/* Stopping requested by tracer */
-			actions_perform(&params->threshold_actions);
+			actions_perform(&params->common.threshold_actions);
 
-			if (!params->threshold_actions.continue_flag)
+			if (!params->common.threshold_actions.continue_flag)
 				/* continue flag not set, break */
 				break;
 
 			/* continue action reached, re-enable tracing */
-			if (record)
-				trace_instance_start(&record->trace);
-			if (!params->no_aa)
-				trace_instance_start(&aa->trace);
+			if (tool->record)
+				trace_instance_start(&tool->record->trace);
+			if (tool->aa)
+				trace_instance_start(&tool->aa->trace);
 			timerlat_bpf_restart_tracing();
 		}
 
 		/* is there still any user-threads ? */
-		if (params->user_workload) {
-			if (params_u->stopped_running) {
+		if (params->common.user_workload) {
+			if (params->common.user.stopped_running) {
 				debug_msg("timerlat user space threads stopped!\n");
 				break;
 			}
@@ -1033,274 +942,30 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 	return 0;
 }
 
-int timerlat_top_main(int argc, char *argv[])
+static int timerlat_top_main_loop(struct osnoise_tool *tool)
 {
-	struct timerlat_params *params;
-	struct osnoise_tool *record = NULL;
-	struct timerlat_u_params params_u;
-	enum result return_value = ERROR;
-	struct osnoise_tool *top = NULL;
-	struct osnoise_tool *aa = NULL;
-	struct trace_instance *trace;
-	int dma_latency_fd = -1;
-	pthread_t timerlat_u;
-	char *max_lat;
+	struct timerlat_params *params = to_timerlat_params(tool->params);
 	int retval;
-	int nr_cpus, i;
-
-	params = timerlat_top_parse_args(argc, argv);
-	if (!params)
-		exit(1);
-
-	top = timerlat_init_top(params);
-	if (!top) {
-		err_msg("Could not init osnoise top\n");
-		goto out_exit;
-	}
-
-	trace = &top->trace;
-	/*
-	 * Save trace instance into global variable so that SIGINT can stop
-	 * the timerlat tracer.
-	 * Otherwise, rtla could loop indefinitely when overloaded.
-	 */
-	top_inst = trace;
-
-	/*
-	 * Try to enable BPF, unless disabled explicitly.
-	 * If BPF enablement fails, fall back to tracefs mode.
-	 */
-	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
-		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
-		params->mode = TRACING_MODE_TRACEFS;
-	} else if (!tep_find_event_by_name(trace->tep, "osnoise", "timerlat_sample")) {
-		debug_msg("osnoise:timerlat_sample missing, disabling BPF\n");
-		params->mode = TRACING_MODE_TRACEFS;
-	} else {
-		retval = timerlat_bpf_init(params);
-		if (retval) {
-			debug_msg("Could not enable BPF\n");
-			params->mode = TRACING_MODE_TRACEFS;
-		}
-	}
-
-	retval = timerlat_top_apply_config(top, params);
-	if (retval) {
-		err_msg("Could not apply config\n");
-		goto out_free;
-	}
 
-	retval = enable_timerlat(trace);
-	if (retval) {
-		err_msg("Failed to enable timerlat tracer\n");
-		goto out_free;
-	}
-
-	if (params->common.set_sched) {
-		retval = set_comm_sched_attr("timerlat/", &params->common.sched_param);
-		if (retval) {
-			err_msg("Failed to set sched parameters\n");
-			goto out_free;
-		}
-	}
-
-	if (params->common.cgroup && !params->user_data) {
-		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
-		if (!retval) {
-			err_msg("Failed to move threads to cgroup\n");
-			goto out_free;
-		}
-	}
-
-	if (params->dma_latency >= 0) {
-		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
-		if (dma_latency_fd < 0) {
-			err_msg("Could not set /dev/cpu_dma_latency.\n");
-			goto out_free;
-		}
-	}
-
-	if (params->deepest_idle_state >= -1) {
-		if (!have_libcpupower_support()) {
-			err_msg("rtla built without libcpupower, --deepest-idle-state is not supported\n");
-			goto out_free;
-		}
-
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
-		for (i = 0; i < nr_cpus; i++) {
-			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
-				continue;
-			if (save_cpu_idle_disable_state(i) < 0) {
-				err_msg("Could not save cpu idle state.\n");
-				goto out_free;
-			}
-			if (set_deepest_cpu_idle_state(i, params->deepest_idle_state) < 0) {
-				err_msg("Could not set deepest cpu idle state.\n");
-				goto out_free;
-			}
-		}
-	}
-
-	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
-	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
-		record = osnoise_init_trace_tool("timerlat");
-		if (!record) {
-			err_msg("Failed to enable the trace instance\n");
-			goto out_free;
-		}
-		params->threshold_actions.trace_output_inst = record->trace.inst;
-		params->end_actions.trace_output_inst = record->trace.inst;
-
-		if (params->common.events) {
-			retval = trace_events_enable(&record->trace, params->common.events);
-			if (retval)
-				goto out_top;
-		}
-
-		if (params->common.buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
-			if (retval)
-				goto out_top;
-		}
-	}
-
-	if (!params->no_aa) {
-		aa = osnoise_init_tool("timerlat_aa");
-		if (!aa)
-			goto out_top;
-
-		retval = timerlat_aa_init(aa, params->dump_tasks);
-		if (retval) {
-			err_msg("Failed to enable the auto analysis instance\n");
-			goto out_top;
-		}
-
-		/* if it is re-using the main instance, there is no need to start it */
-		if (aa != top) {
-			retval = enable_timerlat(&aa->trace);
-			if (retval) {
-				err_msg("Failed to enable timerlat tracer\n");
-				goto out_top;
-			}
-		}
-	}
-
-	if (params->user_workload) {
-		/* rtla asked to stop */
-		params_u.should_run = 1;
-		/* all threads left */
-		params_u.stopped_running = 0;
-
-		params_u.set = &params->common.monitored_cpus;
-		if (params->common.set_sched)
-			params_u.sched_param = &params->common.sched_param;
-		else
-			params_u.sched_param = NULL;
-
-		params_u.cgroup_name = params->common.cgroup_name;
-
-		retval = pthread_create(&timerlat_u, NULL, timerlat_u_dispatcher, &params_u);
-		if (retval)
-			err_msg("Error creating timerlat user-space threads\n");
-	}
-
-	if (params->common.warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->common.warmup);
-		sleep(params->common.warmup);
-	}
-
-	/*
-	 * Start the tracers here, after having set all instances.
-	 *
-	 * Let the trace instance start first for the case of hitting a stop
-	 * tracing while enabling other instances. The trace instance is the
-	 * one with most valuable information.
-	 */
-	if (record)
-		trace_instance_start(&record->trace);
-	if (!params->no_aa)
-		trace_instance_start(&aa->trace);
 	if (params->mode == TRACING_MODE_TRACEFS) {
-		trace_instance_start(trace);
+		retval = top_main_loop(tool);
 	} else {
-		retval = timerlat_bpf_attach();
-		if (retval) {
-			err_msg("Error attaching BPF program\n");
-			goto out_top;
-		}
-	}
-
-	top->start_time = time(NULL);
-	timerlat_top_set_signals(params);
-
-	if (params->mode == TRACING_MODE_TRACEFS)
-		retval = timerlat_top_main_loop(top, record, aa, params, &params_u);
-	else
-		retval = timerlat_top_bpf_main_loop(top, record, aa, params, &params_u);
-
-	if (retval)
-		goto out_top;
-
-	if (params->mode != TRACING_MODE_TRACEFS)
+		retval = __timerlat_top_bpf_main_loop(tool);
 		timerlat_bpf_detach();
-
-	if (params->user_workload && !params_u.stopped_running) {
-		params_u.should_run = 0;
-		sleep(1);
 	}
 
-	timerlat_print_stats(params, top);
-
-	actions_perform(&params->end_actions);
-
-	return_value = PASSED;
-
-	if (osnoise_trace_is_off(top, record) && !stop_tracing) {
-		printf("rtla timerlat hit stop tracing\n");
-
-		if (!params->no_aa)
-			timerlat_auto_analysis(params->common.stop_us,
-					       params->common.stop_total_us);
-
-		return_value = FAILED;
-	} else if (params->aa_only) {
-		/*
-		 * If the trace did not stop with --aa-only, at least print the
-		 * max known latency.
-		 */
-		max_lat = tracefs_instance_file_read(trace->inst, "tracing_max_latency", NULL);
-		if (max_lat) {
-			printf("  Max latency was %s\n", max_lat);
-			free(max_lat);
-		}
-	}
-
-out_top:
-	timerlat_aa_destroy();
-	if (dma_latency_fd >= 0)
-		close(dma_latency_fd);
-	if (params->deepest_idle_state >= -1) {
-		for (i = 0; i < nr_cpus; i++) {
-			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
-				continue;
-			restore_cpu_idle_disable_state(i);
-		}
-	}
-	trace_events_destroy(&record->trace, params->common.events);
-	params->common.events = NULL;
-out_free:
-	timerlat_free_top(top->data);
-	if (aa && aa != top)
-		osnoise_destroy_tool(aa);
-	osnoise_destroy_tool(record);
-	osnoise_destroy_tool(top);
-	actions_destroy(&params->threshold_actions);
-	actions_destroy(&params->end_actions);
-	if (params->mode != TRACING_MODE_TRACEFS)
-		timerlat_bpf_destroy();
-	free(params);
-	free_cpu_idle_disable_states();
-out_exit:
-	exit(return_value);
+	return retval;
 }
+
+struct tool_ops timerlat_top_ops = {
+	.tracer = "timerlat",
+	.comm_prefix = "timerlat/",
+	.parse_args = timerlat_top_parse_args,
+	.init_tool = timerlat_init_top,
+	.apply_config = timerlat_top_apply_config,
+	.enable = timerlat_enable,
+	.main = timerlat_top_main_loop,
+	.print_stats = timerlat_print_stats,
+	.analyze = timerlat_analyze,
+	.free = timerlat_free_top_tool,
+};
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 3cd40dd3f06c..1e5aee4b828d 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -30,9 +30,6 @@ struct trace_seq *get_trace_seq(void);
 int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer_name);
 void disable_tracer(struct tracefs_instance *inst);
 
-int enable_osnoise(struct trace_instance *trace);
-int enable_timerlat(struct trace_instance *trace);
-
 struct tracefs_instance *create_instance(char *instance_name);
 void destroy_instance(struct tracefs_instance *inst);
 
diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
index 23ce250a6852..59abb227d1ca 100644
--- a/tools/tracing/rtla/tests/hwnoise.t
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -10,7 +10,7 @@ check "verify help page" \
 check "detect noise higher than one microsecond" \
 	"hwnoise -c 0 -T 1 -d 5s -q" 0
 check "set the automatic trace mode" \
-	"hwnoise -a 5 -d 10s" 2 "osnoise hit stop tracing"
+	"hwnoise -a 5 -d 10s" 2 "rtla hit stop tracing"
 check "set scheduling param to the osnoise tracer threads" \
 	"hwnoise -P F:1 -c 0 -r 900000 -d 10s -q"
 check "stop the trace if a single sample is higher than 1 us" \
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 7574ec6a5a53..89ff89c465a2 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -10,7 +10,7 @@ check "verify help page" \
 check "verify the --priority/-P param" \
 	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q"
 check "verify the --stop/-s param" \
-	"osnoise top -s 30 -T 1" 2 "osnoise hit stop tracing"
+	"osnoise top -s 30 -T 1" 2 "rtla hit stop tracing"
 check "verify the  --trace param" \
 	"osnoise hist -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
 check "verify the --entries/-E param" \
-- 
2.48.1

