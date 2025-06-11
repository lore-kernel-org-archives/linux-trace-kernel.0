Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B129ACDA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650241; cv=none; b=Xm7JOizMi3eCe5iNlKcdG6FwA6hedzYAZIVlD3On74h35B+psB/k8ZAkVnT1jIxshPwDg7cl5KySGMMQYvw7/V4Iovfe2UFZpP9qiCw+1HrGTlHpatFN1qDycF3PTCtVOf4DU5ZJS0b2fpsFqfMsHIF6s0L1v0C0hvt45fzn8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650241; c=relaxed/simple;
	bh=BixDELRT6uG05RHpWncF2IbGIJnbavZUgZD5qePCxjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwUu5v8FOQ2FdZRRRnuBWpxKOL1anxdygKLM2poJcpc1RxI6jPps2iyZ6X1JmMDmlxFL3aQhEUp1Qf4FECMWdD8L6OCWaQNvWrCsh11xZMuLhhKeRMma8ANM0cnLv/tnZSUzC/DReUDzLJqqH3H8/wpbaD3EeKYlGMApxhnFcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bvxvb81Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bvxvb81Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggVAEc+wazxmKfd8bKckrZJOLakgnftHGfBZZLcfyHs=;
	b=Bvxvb81QIVuCTU/ym2CYEm4upgrcny+zl44OYBY0V/A9y8BBnzE0uHtF/+cmxoEgV+lsOV
	uxFfQh55AiJIQe8woZhbPEknVtXFRsIFQqcCDFu3p1wezXEV5wnP19YK6QwbajVOJHJrO+
	9hgLWNdS1Omr/Mm8MhkidE83nblncXU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-mutgKT0jOBK8hRWB_Frtag-1; Wed,
 11 Jun 2025 09:57:17 -0400
X-MC-Unique: mutgKT0jOBK8hRWB_Frtag-1
X-Mimecast-MFC-AGG-ID: mutgKT0jOBK8hRWB_Frtag_1749650236
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE0D0180AD43;
	Wed, 11 Jun 2025 13:57:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4D5C19560A3;
	Wed, 11 Jun 2025 13:57:13 +0000 (UTC)
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
Subject: [PATCH 4/8] rtla/timerlat: Add continue action
Date: Wed, 11 Jun 2025 15:56:40 +0200
Message-ID: <20250611135644.219127-5-tglozar@redhat.com>
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

Introduce option to resume tracing after a latency threshold overflow.
The option is implemented as an action, specified using "-A continue".

Example:
$ rtla timerlat top -q -T 200 -d 1s -A exec,command="echo Threshold" \
-A continue
Threshold
Threshold
Threshold
                                     Timer Latency
...

The feature is supported for both hist and top. After the continue
action is executed, processing of the list of actions is stopped and
tracing is resumed.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/actions.c       | 27 +++++++++++-
 tools/tracing/rtla/src/actions.h       |  5 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 40 +++++++++++++++---
 tools/tracing/rtla/src/timerlat_top.c  | 57 ++++++++++++++++----------
 4 files changed, 100 insertions(+), 29 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 63bee5bdabfd..aaf0808125d7 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -17,6 +17,7 @@ actions_init(struct actions *self)
 	self->size = action_default_size;
 	self->list = calloc(self->size, sizeof(struct action));
 	self->len = 0;
+	self->continue_flag = false;
 
 	memset(&self->present, 0, sizeof(self->present));
 
@@ -108,6 +109,20 @@ actions_add_shell(struct actions *self, const char *command)
 	return 0;
 }
 
+/*
+ * actions_add_continue - add an action to resume measurement
+ */
+int
+actions_add_continue(struct actions *self)
+{
+	struct action *action = actions_new(self);
+
+	self->present[ACTION_CONTINUE] = true;
+	action->type = ACTION_CONTINUE;
+
+	return 0;
+}
+
 /*
  * actions_parse - add an action based on text specification
  */
@@ -133,6 +148,8 @@ actions_parse(struct actions *self, const char *trigger)
 		type = ACTION_SIGNAL;
 	else if (strcmp(token, "shell") == 0)
 		type = ACTION_SHELL;
+	else if (strcmp(token, "continue") == 0)
+		type = ACTION_CONTINUE;
 	else
 		/* Invalid trigger type */
 		return -1;
@@ -187,6 +204,11 @@ actions_parse(struct actions *self, const char *trigger)
 		if (strlen(token) > 8 && strncmp(token, "command=", 8) == 0)
 			return actions_add_shell(self, token + 8);
 		return -1;
+	case ACTION_CONTINUE:
+		/* Takes no argument */
+		if (token != NULL)
+			return -1;
+		return actions_add_continue(self);
 	default:
 		return -1;
 	}
@@ -196,7 +218,7 @@ actions_parse(struct actions *self, const char *trigger)
  * actions_perform - perform all actions
  */
 int
-actions_perform(const struct actions *self)
+actions_perform(struct actions *self)
 {
 	int pid, retval;
 	const struct action *action;
@@ -226,6 +248,9 @@ actions_perform(const struct actions *self)
 			if (retval)
 				return retval;
 			break;
+		case ACTION_CONTINUE:
+			self->continue_flag = true;
+			return 0;
 		default:
 			break;
 		}
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index 076bbff8519e..b10a19d55c49 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -7,6 +7,7 @@ enum action_type {
 	ACTION_TRACE_OUTPUT,
 	ACTION_SIGNAL,
 	ACTION_SHELL,
+	ACTION_CONTINUE,
 	ACTION_FIELD_N
 };
 
@@ -35,6 +36,7 @@ struct actions {
 	struct action *list;
 	int len, size;
 	bool present[ACTION_FIELD_N];
+	bool continue_flag;
 
 	/* External dependencies */
 	struct tracefs_instance *trace_output_inst;
@@ -45,5 +47,6 @@ void actions_destroy(struct actions *self);
 int actions_add_trace_output(struct actions *self, const char *trace_output);
 int actions_add_signal(struct actions *self, int signal, int pid);
 int actions_add_shell(struct actions *self, const char *command);
+int actions_add_continue(struct actions *self);
 int actions_parse(struct actions *self, const char *trigger);
-int actions_perform(const struct actions *self);
+int actions_perform(struct actions *self);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 06ee3d925ef9..1feae978344b 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1375,8 +1375,20 @@ int timerlat_hist_main(int argc, char *argv[])
 				goto out_hist;
 			}
 
-			if (osnoise_trace_is_off(tool, record))
-				break;
+			if (osnoise_trace_is_off(tool, record)) {
+				actions_perform(&params->actions);
+
+				if (!params->actions.continue_flag)
+					/* continue flag not set, break */
+					break;
+
+				/* continue action reached, re-enable tracing */
+				if (params->actions.present[ACTION_TRACE_OUTPUT])
+					trace_instance_start(&record->trace);
+				if (!params->no_aa)
+					trace_instance_start(&aa->trace);
+				trace_instance_start(trace);
+			}
 
 			/* is there still any user-threads ? */
 			if (params->user_workload) {
@@ -1386,8 +1398,27 @@ int timerlat_hist_main(int argc, char *argv[])
 				}
 			}
 		}
-	} else
-		timerlat_bpf_wait(-1);
+	} else {
+		while (!stop_tracing) {
+			timerlat_bpf_wait(-1);
+
+			if (!stop_tracing) {
+				/* Threshold overflow, perform actions on threshold */
+				actions_perform(&params->actions);
+
+				if (!params->actions.continue_flag)
+					/* continue flag not set, break */
+					break;
+
+				/* continue action reached, re-enable tracing */
+				if (params->actions.present[ACTION_TRACE_OUTPUT])
+					trace_instance_start(&record->trace);
+				if (!params->no_aa)
+					trace_instance_start(&aa->trace);
+				timerlat_bpf_restart_tracing();
+			}
+		}
+	}
 
 	if (params->mode != TRACING_MODE_TRACEFS) {
 		timerlat_bpf_detach();
@@ -1413,7 +1444,6 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		actions_perform(&params->actions);
 		return_value = FAILED;
 	}
 
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fa1072c0d126..ff0e6a7c3a1b 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -906,6 +906,7 @@ timerlat_top_set_signals(struct timerlat_params *params)
 static int
 timerlat_top_main_loop(struct osnoise_tool *top,
 		       struct osnoise_tool *record,
+		       struct osnoise_tool *aa,
 		       struct timerlat_params *params,
 		       struct timerlat_u_params *params_u)
 {
@@ -932,8 +933,20 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 		if (!params->quiet)
 			timerlat_print_stats(params, top);
 
-		if (osnoise_trace_is_off(top, record))
-			break;
+		if (osnoise_trace_is_off(top, record)) {
+			actions_perform(&params->actions);
+
+			if (!params->actions.continue_flag)
+				/* continue flag not set, break */
+				break;
+
+			/* continue action reached, re-enable tracing */
+			if (params->actions.present[ACTION_TRACE_OUTPUT])
+				trace_instance_start(&record->trace);
+			if (!params->no_aa)
+				trace_instance_start(&aa->trace);
+			trace_instance_start(trace);
+		}
 
 		/* is there still any user-threads ? */
 		if (params->user_workload) {
@@ -953,6 +966,7 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 static int
 timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 			   struct osnoise_tool *record,
+			   struct osnoise_tool *aa,
 			   struct timerlat_params *params,
 			   struct timerlat_u_params *params_u)
 {
@@ -964,22 +978,9 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 		return 0;
 	}
 
-	if (params->quiet) {
-		/* Quiet mode: wait for stop and then, print results */
-		timerlat_bpf_wait(-1);
-
-		retval = timerlat_top_bpf_pull_data(top);
-		if (retval) {
-			err_msg("Error pulling BPF data\n");
-			return retval;
-		}
-
-		return 0;
-	}
-
 	/* Pull and display data in a loop */
 	while (!stop_tracing) {
-		wait_retval = timerlat_bpf_wait(params->sleep_time);
+		wait_retval = timerlat_bpf_wait(params->quiet ? -1 : params->sleep_time);
 
 		retval = timerlat_top_bpf_pull_data(top);
 		if (retval) {
@@ -987,11 +988,24 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 			return retval;
 		}
 
-		timerlat_print_stats(params, top);
+		if (!params->quiet)
+			timerlat_print_stats(params, top);
 
-		if (wait_retval == 1)
+		if (wait_retval == 1) {
 			/* Stopping requested by tracer */
-			break;
+			actions_perform(&params->actions);
+
+			if (!params->actions.continue_flag)
+				/* continue flag not set, break */
+				break;
+
+			/* continue action reached, re-enable tracing */
+			if (params->actions.present[ACTION_TRACE_OUTPUT])
+				trace_instance_start(&record->trace);
+			if (!params->no_aa)
+				trace_instance_start(&aa->trace);
+			timerlat_bpf_restart_tracing();
+		}
 
 		/* is there still any user-threads ? */
 		if (params->user_workload) {
@@ -1205,9 +1219,9 @@ int timerlat_top_main(int argc, char *argv[])
 	timerlat_top_set_signals(params);
 
 	if (params->mode == TRACING_MODE_TRACEFS)
-		retval = timerlat_top_main_loop(top, record, params, &params_u);
+		retval = timerlat_top_main_loop(top, record, aa, params, &params_u);
 	else
-		retval = timerlat_top_bpf_main_loop(top, record, params, &params_u);
+		retval = timerlat_top_bpf_main_loop(top, record, aa, params, &params_u);
 
 	if (retval)
 		goto out_top;
@@ -1230,7 +1244,6 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		actions_perform(&params->actions);
 		return_value = FAILED;
 	} else if (params->aa_only) {
 		/*
-- 
2.49.0

