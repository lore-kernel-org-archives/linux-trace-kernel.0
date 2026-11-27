Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793586;
	b=VhTbh+VKFmeA5JxHt4AtG9+h+jgQkPmctxaRVXG3hk5o0Oyyjl1ZcA6vGifUaBwuv0vD
	 Rq333H9VOSj99vw2gSaPXXYf3Yp87qQp8PW9CcWqzvCCxyzOUT5/XkLHitzC9HrT4pP4H
	 LEnUck/4XWZ0TGnvyERDMVt667/T4KLXVBOLpzL4wlyTZ3dWgRtPhOhjtQJR9GuoB/lZp
	 woUH6P3ZSitEXF+mY045ZCh3cTi7+zETpCD6pJN3Y/CxUtELgAOz4arwCTHOMGbYam5w0
	 +bqZfa29lNaY9zic/4A4/dhZzmn141svwJbbMnm/CafdwW06DmHNxioE5Ev9GtiybuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793586;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=hoXcOKg6Iy0B1v6fvnPApwoHZrjHBD+urxJqSYU0FTE=;
	b=BOVElYjFgK5j4mu7MkScJFQqNyyZF3O0HWM6NrvNvvqmVP/gXl9gAvw6KECgEo2I9gZZ
	 Kqy5iV5Z1hyBK6jjK6Zd34O2qogRiG7BNvyjshbJ0CSmDd9K3Yz6N6kEkV31FSlUTek2j
	 gMcD21PSY5UwyHZaeEaaAiIzdigiUWBPXxL4HOXnn+6ilUezsTNPPP3CQvbAyqdozePhQ
	 +9FL2ggTeDtF6bkAOtpPnnXJQSGX7rxvwMCuQU64ueW7RxS1imKIzK62P1jk7FZ4CHGiC
	 apjwJjhaP3dSeppaSlXgp0vwGv0M/PoJ716he1LNtqryzPWb0Ora2EfnCJhbAnV3xFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="ZQoqm/44";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A9606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B01A9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZQoqm/44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoXcOKg6Iy0B1v6fvnPApwoHZrjHBD+urxJqSYU0FTE=;
	b=ZQoqm/44XSHqkLgH9x2PJt3D0J6P/AnqNf3fmekoujf2MfftcNNUjNQNObtOSkGnEQ7RmC
	0EaFqk+oAWXGozWd/t9DC7eyIpJ1LWP0W/7TlUf28ml4BnBtj0dngJlpISPoGrJG/Il9Cd
	SyFaKFk/HiofALdDHfGoTZjiKYOlZns=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-4AsS9F-KMQmtrxl40e08HA-1; Fri,
 27 Nov 2026 15:33:01 +0000
X-MC-Unique: 4AsS9F-KMQmtrxl40e08HA-1
X-Mimecast-MFC-AGG-ID: 4AsS9F-KMQmtrxl40e08HA_1795793580
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5C611955F54;
	Fri, 27 Nov 2026 15:32:59 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4A771955F76;
	Fri, 27 Nov 2026 15:32:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 01/10] rtla: Support auto-analysis as an action
Date: Fri, 27 Nov 2026 16:31:57 +0100
Message-ID: <20261127153206.134322-2-tglozar@redhat.com>
In-Reply-To: <20261127153206.134322-1-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: crUOJgs0TSwNAKglQTZO_8jOGKLQQ9aTTBCfmEXKrAk_1795793580
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

rtla currently performs auto-analysis of a latency spike at the end of
the measurement, after the results (top/hist) are printed, in case
tracing was stopped with -i/--irq, -T/--thread, -s/--stop,
-S/--stop-total, or -a/--auto, and was not resumed with --on-threshold
continue.

This has multiple disadvantages:

- The user is not able to make auto-analysis run before other actions,
  e.g. trace output.
- The user is not able to make auto-analysis run conditionally depending
  on the result of the previous actions.
- Auto-analysis can only be used to analyze a latency that stops tracing
  without resuming, thus, only one latency spike can be analyzed per
  rtla run.

To provide more flexibility, add an option to run auto-analysis as an
action (--on-threshold aa, --on-end aa). The default behavior of
auto-analyzing at the end of the measurement stays unchanged.

If the auto-analysis action is present, the default auto-analysis at the
end is skipped to avoid analyzing twice.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/actions.c        | 39 +++++++++++---
 tools/tracing/rtla/src/actions.h        |  8 ++-
 tools/tracing/rtla/src/cli.c            |  6 +++
 tools/tracing/rtla/src/common.c         | 21 +++++---
 tools/tracing/rtla/src/common.h         |  7 +++
 tools/tracing/rtla/src/timerlat_aa.c    | 67 +++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.c          |  8 +++
 tools/tracing/rtla/src/trace.h          |  1 +
 tools/tracing/rtla/tests/unit/actions.c | 10 ++--
 9 files changed, 147 insertions(+), 20 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index bf13d9d68f169..a554539a522c6 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -4,9 +4,7 @@
 #include <signal.h>
 #include <unistd.h>
 
-#include "actions.h"
-#include "trace.h"
-#include "utils.h"
+#include "common.h"
 
 /*
  * actions_init - initialize struct actions
@@ -20,7 +18,7 @@ actions_init(struct actions *self)
 	self->continue_flag = false;
 
 	/* This has to be set by the user */
-	self->trace_output_inst = NULL;
+	self->tool = NULL;
 }
 
 /*
@@ -111,6 +109,17 @@ actions_add_continue(struct actions *self)
 	action->type = ACTION_CONTINUE;
 }
 
+/*
+ * actions_add_aa - add an action to perform auto-analysis
+ */
+void actions_add_aa(struct actions *self)
+{
+	struct action *action = actions_new(self);
+
+	self->present[ACTION_AA] = true;
+	action->type = ACTION_AA;
+}
+
 static inline const char *__extract_arg(const char *token, const char *opt, size_t opt_len)
 {
 	const size_t tok_len = strlen(token);
@@ -164,6 +173,8 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 		type = ACTION_SHELL;
 	else if (strcmp(token, "continue") == 0)
 		type = ACTION_CONTINUE;
+	else if (strcmp(token, "aa") == 0)
+		type = ACTION_AA;
 	else
 		/* Invalid trigger type */
 		return -1;
@@ -231,6 +242,12 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 			return -1;
 		actions_add_continue(self);
 		break;
+	case ACTION_AA:
+		/* Takes no argument */
+		if (token != NULL)
+			return -1;
+		actions_add_aa(self);
+		break;
 	default:
 		return -1;
 	}
@@ -240,9 +257,12 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 
 /*
  * actions_perform - perform all actions
+ * @stopped: Whether tracing was stopped on a latency threshold.
+ *
+ * Returns 0 if all actions succeeded, or an error code if an action failed.
  */
 int
-actions_perform(struct actions *self)
+actions_perform(struct actions *self, bool stopped)
 {
 	int pid, retval;
 	const struct action *action;
@@ -252,7 +272,8 @@ actions_perform(struct actions *self)
 	for_each_action(self, action) {
 		switch (action->type) {
 		case ACTION_TRACE_OUTPUT:
-			retval = save_trace_to_file(self->trace_output_inst, action->trace_output);
+			retval = save_trace_to_file(self->tool->record->trace.inst,
+						    action->trace_output);
 			if (retval) {
 				err_msg("Error saving trace\n");
 				return retval;
@@ -277,6 +298,12 @@ actions_perform(struct actions *self)
 		case ACTION_CONTINUE:
 			self->continue_flag = true;
 			return 0;
+		case ACTION_AA:
+			if (self->tool->ops->analyze)
+				self->tool->ops->analyze(self->tool, stopped);
+			/* Ensure correct ordering with respect to shell command output */
+			fflush(stdout);
+			break;
 		default:
 			break;
 		}
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index 034048682fefb..2688f22bae90d 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -2,12 +2,15 @@
 #include <tracefs.h>
 #include <stdbool.h>
 
+struct osnoise_tool;
+
 enum action_type {
 	ACTION_NONE = 0,
 	ACTION_TRACE_OUTPUT,
 	ACTION_SIGNAL,
 	ACTION_SHELL,
 	ACTION_CONTINUE,
+	ACTION_AA,
 	ACTION_FIELD_N
 };
 
@@ -39,7 +42,7 @@ struct actions {
 	bool continue_flag;
 
 	/* External dependencies */
-	struct tracefs_instance *trace_output_inst;
+	struct osnoise_tool *tool;
 };
 
 #define for_each_action(actions, action)			\
@@ -53,5 +56,6 @@ void actions_add_trace_output(struct actions *self, const char *trace_output);
 void actions_add_signal(struct actions *self, int signal, int pid);
 void actions_add_shell(struct actions *self, const char *command);
 void actions_add_continue(struct actions *self);
+void actions_add_aa(struct actions *self);
 int actions_parse(struct actions *self, const char *trigger, const char *tracefn);
-int actions_perform(struct actions *self);
+int actions_perform(struct actions *self, bool stopped);
diff --git a/tools/tracing/rtla/src/cli.c b/tools/tracing/rtla/src/cli.c
index 8c02b94ce4321..9742c70485e5b 100644
--- a/tools/tracing/rtla/src/cli.c
+++ b/tools/tracing/rtla/src/cli.c
@@ -128,6 +128,9 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	if (geteuid() && !in_unit_test)
 		fatal("osnoise needs root permission");
 
+	if (aa_action_present(&params->common))
+		fatal("auto-analysis action is not supported with osnoise tools");
+
 	return &params->common;
 }
 
@@ -210,6 +213,9 @@ struct common_params *osnoise_hist_parse_args(int argc, char **argv)
 	if (geteuid() && !in_unit_test)
 		fatal("rtla needs root permission");
 
+	if (aa_action_present(&params->common))
+		fatal("auto-analysis action is not supported with osnoise tools");
+
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
 		fatal("no-index set and with-zeros not set - it does not make sense");
 
diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index ac4172bcc4444..e085eb6c8f13f 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -138,7 +138,7 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 int
 common_threshold_handler(const struct osnoise_tool *tool)
 {
-	actions_perform(&tool->params->threshold_actions);
+	actions_perform(&tool->params->threshold_actions, true);
 
 	if (!should_continue_tracing(tool->params))
 		/* continue flag not set, break */
@@ -147,7 +147,8 @@ common_threshold_handler(const struct osnoise_tool *tool)
 	/* continue action reached, re-enable tracing */
 	if (tool->record && trace_instance_start(&tool->record->trace))
 		goto err;
-	if (tool->aa && trace_instance_start(&tool->aa->trace))
+	if (tool->aa && (trace_instance_clear(&tool->aa->trace) ||
+	    trace_instance_start(&tool->aa->trace)))
 		goto err;
 
 	return 0;
@@ -197,6 +198,13 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 	 */
 	trace_tool = tool;
 
+	/*
+	 * Expose the tool to actions, so they can access the trace output
+	 * instance and auto-analysis callback.
+	 */
+	params->threshold_actions.tool = tool;
+	params->end_actions.tool = tool;
+
 	retval = ops->apply_config(tool);
 	if (retval) {
 		err_msg("Could not apply config\n");
@@ -233,8 +241,6 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 			err_msg("Failed to enable the trace instance\n");
 			goto out_free;
 		}
-		params->threshold_actions.trace_output_inst = tool->record->trace.inst;
-		params->end_actions.trace_output_inst = tool->record->trace.inst;
 
 		if (params->events) {
 			retval = trace_events_enable(&tool->record->trace, params->events);
@@ -290,17 +296,18 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 
 	ops->print_stats(tool);
 
-	actions_perform(&params->end_actions);
-
 	return_value = PASSED;
 
 	stopped = osnoise_trace_is_off(tool, tool->record) && !stop_tracing;
+
+	actions_perform(&params->end_actions, stopped);
+
 	if (stopped) {
 		printf("%s hit stop tracing\n", ops->tracer);
 		return_value = FAILED;
 	}
 
-	if (ops->analyze)
+	if (ops->analyze && !aa_action_present(params))
 		ops->analyze(tool, stopped);
 
 out_signals:
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index ec2f6f86ec3a0..ed0e318d8e151 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -166,6 +166,13 @@ should_continue_tracing(const struct common_params *params)
 	return params->threshold_actions.continue_flag;
 }
 
+static inline bool
+aa_action_present(const struct common_params *params)
+{
+	return params->threshold_actions.present[ACTION_AA] ||
+		params->end_actions.present[ACTION_AA];
+}
+
 int
 common_threshold_handler(const struct osnoise_tool *tool);
 
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index a121ff9d2c571..11ddceab208ac 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -740,6 +740,70 @@ static int timerlat_auto_analysis_collect_trace(struct timerlat_aa_context *taa_
 	return 1;
 }
 
+/*
+ * timerlat_aa_reset - Clear old data to prepare for analysis
+ */
+static void timerlat_aa_reset(struct timerlat_aa_context *taa_ctx)
+{
+	struct timerlat_aa_data *taa_data;
+	int cpu;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		taa_data = &taa_ctx->taa_data[cpu];
+
+		/* Current CPU state */
+		taa_data->curr_state = TIMERLAT_INIT;
+
+		/* timerlat IRQ latency */
+		taa_data->tlat_irq_seqnum = 0;
+		taa_data->tlat_irq_latency = 0;
+		taa_data->tlat_irq_timstamp = 0;
+
+		/* timerlat Thread latency */
+		taa_data->tlat_thread_seqnum = 0;
+		taa_data->tlat_thread_latency = 0;
+		taa_data->tlat_thread_timstamp = 0;
+
+		/* Thread running when the IRQ arrived */
+		taa_data->run_thread_pid = 0;
+		memset(taa_data->run_thread_comm, 0, MAX_COMM);
+		taa_data->thread_blocking_duration = 0;
+		taa_data->max_exit_idle_latency = 0;
+
+		/* Information about the timerlat timer irq */
+		taa_data->timer_irq_start_time = 0;
+		taa_data->timer_irq_start_delay = 0;
+		taa_data->timer_irq_duration = 0;
+		taa_data->timer_exit_from_idle = 0;
+
+		/* Last IRQ before the timerlat irq arrived */
+		taa_data->prev_irq_duration = 0;
+		taa_data->prev_irq_timstamp = 0;
+
+		/* Interference sum */
+		taa_data->thread_nmi_sum = 0;
+		taa_data->thread_irq_sum = 0;
+		taa_data->thread_softirq_sum = 0;
+		taa_data->thread_thread_sum = 0;
+
+		/* Interference task information */
+		trace_seq_reset(taa_data->prev_irqs_seq);
+		trace_seq_reset(taa_data->nmi_seq);
+		trace_seq_reset(taa_data->irqs_seq);
+		trace_seq_reset(taa_data->softirqs_seq);
+		trace_seq_reset(taa_data->threads_seq);
+		trace_seq_reset(taa_data->stack_seq);
+
+		/* Current thread */
+		memset(taa_data->current_comm, 0, MAX_COMM);
+		taa_data->current_pid = 0;
+
+		/* Is the system running a kworker? */
+		taa_data->kworker = 0;
+		taa_data->kworker_func = 0;
+	}
+}
+
 /**
  * timerlat_auto_analysis - Analyze the collected data
  */
@@ -752,6 +816,9 @@ void timerlat_auto_analysis(int irq_thresh, int thread_thresh)
 	struct tep_handle *tep;
 	int cpu;
 
+	/* reset any data left over from previous run */
+	timerlat_aa_reset(taa_ctx);
+
 	timerlat_auto_analysis_collect_trace(taa_ctx);
 
 	/* bring stop tracing to the ns scale */
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 4b5f4d033d8b4..c608393533494 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -267,6 +267,14 @@ int trace_instance_stop(struct trace_instance *trace)
 	return tracefs_trace_off(trace->inst);
 }
 
+/*
+ * trace_instance_clear - clear all samples of a given rtla instance
+ */
+int trace_instance_clear(struct trace_instance *trace)
+{
+	return tracefs_instance_file_write(trace->inst, "trace", "");
+}
+
 /*
  * trace_events_free - free a list of trace events
  */
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 94e4510db2d19..b3a626b676b3d 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -26,6 +26,7 @@ struct trace_instance {
 int trace_instance_init(struct trace_instance *trace, char *tool_name);
 int trace_instance_start(struct trace_instance *trace);
 int trace_instance_stop(struct trace_instance *trace);
+int trace_instance_clear(struct trace_instance *trace);
 void trace_instance_destroy(struct trace_instance *trace);
 
 struct trace_seq *get_trace_seq(void);
diff --git a/tools/tracing/rtla/tests/unit/actions.c b/tools/tracing/rtla/tests/unit/actions.c
index 94ad5ad42774b..6d91ad698a925 100644
--- a/tools/tracing/rtla/tests/unit/actions.c
+++ b/tools/tracing/rtla/tests/unit/actions.c
@@ -27,7 +27,7 @@ START_TEST(test_actions_init)
 	ck_assert_int_eq(actions.len, 0);
 	ck_assert_int_eq(actions.size, action_default_size);
 	ck_assert(!actions.continue_flag);
-	ck_assert_ptr_eq(actions.trace_output_inst, NULL);
+	ck_assert_ptr_eq(actions.tool, NULL);
 }
 END_TEST
 
@@ -302,7 +302,7 @@ END_TEST
 START_TEST(test_actions_perform_continue)
 {
 	actions_add_continue(&actions_fixture);
-	ck_assert_int_eq(actions_perform(&actions_fixture), 0);
+	ck_assert_int_eq(actions_perform(&actions_fixture, true), 0);
 
 	ck_assert(actions_fixture.continue_flag);
 }
@@ -312,7 +312,7 @@ START_TEST(test_actions_perform_continue_after_successful_shell_command)
 {
 	actions_add_shell(&actions_fixture, "exit 0");
 	actions_add_continue(&actions_fixture);
-	ck_assert_int_eq(actions_perform(&actions_fixture), 0 << 8);
+	ck_assert_int_eq(actions_perform(&actions_fixture, true), 0 << 8);
 
 	ck_assert(actions_fixture.continue_flag);
 }
@@ -322,7 +322,7 @@ START_TEST(test_actions_perform_continue_after_failed_shell_command)
 {
 	actions_add_shell(&actions_fixture, "exit 1");
 	actions_add_continue(&actions_fixture);
-	ck_assert_int_eq(actions_perform(&actions_fixture), 1 << 8);
+	ck_assert_int_eq(actions_perform(&actions_fixture, true), 1 << 8);
 
 	ck_assert(!actions_fixture.continue_flag);
 }
@@ -334,7 +334,7 @@ START_TEST(test_actions_perform_continue_unset_flag)
 
 	actions_add_shell(&actions_fixture, "exit 1");
 	actions_add_continue(&actions_fixture);
-	ck_assert_int_eq(actions_perform(&actions_fixture), 1 << 8);
+	ck_assert_int_eq(actions_perform(&actions_fixture, true), 1 << 8);
 
 	ck_assert(!actions_fixture.continue_flag);
 }
-- 
2.56.1

