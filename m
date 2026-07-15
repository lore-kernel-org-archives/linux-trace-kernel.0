Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2148C8AF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130432; cv=none; b=mnveVRvZdetyprWOtP2EBhPA4KDv/3ZN4H7y+kWetFg0rGkmfn7MFTmdkw49uKFT7g0iCtcIUv0mabJIiTA+jE/Y3NBvQpqC1XW5deNE6zQ1eOTE/N+6LqD+uGmbnGECc7OCh6eRJKh7i2x5ylka9nDKdDkDI1PzVkU/g6GC0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130432; c=relaxed/simple;
	bh=9NcPnTXsdZ8RvpB1dyL2Xv3ITs7uDVh7WEThip/MWWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=n84bmtKKj8PhNl6dE6xjovzm+IdnP9jgIRwSA35aYsJwyjtAMGpiCKxIsw0dxC9qmKyMv++z0bn01lgszRooCZozyZUiGJppP/xwg5+PEZkG2BfyudQMUIc0c64w932Q4vSFmeW867dzTjWPJmu0k31PBoxgCIl15Kz4sZhgvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H45J6fAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H45J6fAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784130427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9S45MFUtOE7ctpW9HaHMKFKg1ANHfRP1oIVMuko7qnU=;
	b=H45J6fAKw00IAHChhmoyRPkkfo/HfKl/0st3ic+bjKT2DcvDL12Ps28FYybxOULAScRb52
	4AT3/0W3usFokfISVLCu2bZh+/YosywXh/rppBFqBxirwNMM0+YLt4gZ8XNWNDeuUwwxj3
	TKaL0iEX/BreRGoQypgFNj5nV+cqBnA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-EZPWzez9ORaKPQRQqBWmbg-1; Wed,
 15 Jul 2026 11:47:03 -0400
X-MC-Unique: EZPWzez9ORaKPQRQqBWmbg-1
X-Mimecast-MFC-AGG-ID: EZPWzez9ORaKPQRQqBWmbg_1784130422
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 459321955F18;
	Wed, 15 Jul 2026 15:47:01 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.32.112])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCB8E1800286;
	Wed, 15 Jul 2026 15:46:55 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 6/6] rtla/osnoise: Trace IPI events when recording a trace file
Date: Wed, 15 Jul 2026 17:45:51 +0200
Message-ID: <20260715154553.2020891-7-vschneid@redhat.com>
In-Reply-To: <20260715154553.2020891-1-vschneid@redhat.com>
References: <20260715154553.2020891-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: VhaVlFkSgy-3YXhDon9hbkjWScgHGuDhECFG1nCFpjY_1784130422
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

IPIs can now be monitored and accounted by osnoise top. When that is
the case, also record them when saving a trace file.

To match what is being recorded by the tool for its own analysis, event
filters are applied to the events recorded to the trace output.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/common.c      |  2 +-
 tools/tracing/rtla/src/common.h      |  2 +-
 tools/tracing/rtla/src/osnoise.c     | 72 +++++++++++++++++++++++++++-
 tools/tracing/rtla/src/osnoise.h     |  4 ++
 tools/tracing/rtla/src/osnoise_top.c | 36 ++------------
 5 files changed, 80 insertions(+), 36 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index d0a8a6edbf0cb..dd302427557ca 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -204,7 +204,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 
 	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
 	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
-		tool->record = osnoise_init_trace_tool(ops->tracer);
+		tool->record = osnoise_init_trace_tool(params, ops->tracer);
 		if (!tool->record) {
 			err_msg("Failed to enable the trace instance\n");
 			goto out_free;
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 045253230fcf2..421e06e10f3f1 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -178,7 +178,7 @@ int osnoise_set_workload(struct osnoise_context *context, bool onoff);
 
 void osnoise_destroy_tool(struct osnoise_tool *top);
 struct osnoise_tool *osnoise_init_tool(char *tool_name);
-struct osnoise_tool *osnoise_init_trace_tool(const char *tracer);
+struct osnoise_tool *osnoise_init_trace_tool(struct common_params *params, const char *tracer);
 bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
 int osnoise_set_stop_us(struct osnoise_context *context, long long stop_us);
 int osnoise_set_stop_total_us(struct osnoise_context *context,
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 4ff5dad013b10..ae6e5f03e828f 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1178,10 +1178,56 @@ struct osnoise_tool *osnoise_init_tool(char *tool_name)
 	return top;
 }
 
+/*
+ * osnoise_init_ipi_filters - Initialize event filtering for IPI events
+ */
+int osnoise_init_ipi_filters(struct osnoise_tool *tool,
+				    struct common_params *params,
+				    bool *filters_enabled)
+{
+	char filter[MAX_PATH];
+	int retval;
+	/*
+	 * If tracing on a subset of possible CPUs, leverage the kernel filtering
+	 * infrastructure to only generate events on traced CPUs.
+	 * Older kernels (pre v6.6) may have the IPI events but not the ability
+	 * to filter them, so allow that to fail gracefully.
+	 */
+
+	snprintf(filter, ARRAY_SIZE(filter), "cpu & CPUS{%s}\n", params->cpus);
+	retval = tracefs_event_file_write(tool->trace.inst,
+					  "ipi", "ipi_send_cpu", "filter",
+					  filter);
+	if (retval < 0) {
+		debug_msg("Could not set ipi_send_cpu CPU filter\n");
+		*filters_enabled = false;
+		return 0;
+	}
+
+
+	snprintf(filter, ARRAY_SIZE(filter), "cpumask & CPUS{%s}\n", params->cpus);
+	retval = tracefs_event_file_write(tool->trace.inst,
+					  "ipi", "ipi_send_cpumask", "filter",
+					  filter);
+	if (retval < 0) {
+		/*
+		 * If we managed to set up the previous filter but not
+		 * this one, something's really wrong
+		 */
+		err_msg("Could not set ipi_send_cpumask CPU filter\n");
+		*filters_enabled = false;
+		return -1;
+	}
+
+	*filters_enabled = true;
+	return 0;
+}
+
 /*
  * osnoise_init_trace_tool - init a tracer instance to trace osnoise events
  */
-struct osnoise_tool *osnoise_init_trace_tool(const char *tracer)
+struct osnoise_tool *osnoise_init_trace_tool(struct common_params *params,
+					     const char *tracer)
 {
 	struct osnoise_tool *trace;
 	int retval;
@@ -1196,6 +1242,30 @@ struct osnoise_tool *osnoise_init_trace_tool(const char *tracer)
 		goto out_err;
 	}
 
+	if (!params->ipi)
+		goto done;
+
+	retval = tracefs_event_enable(trace->trace.inst, "ipi", "ipi_send_cpu");
+	if (retval < 0 && !errno) {
+		err_msg("Could not find ipi_send_cpu event\n");
+		goto out_err;
+	}
+
+	retval = tracefs_event_enable(trace->trace.inst, "ipi", "ipi_send_cpumask");
+	if (retval < 0 && !errno) {
+		err_msg("Could not find ipi_send_cpumask event\n");
+		goto out_err;
+	}
+
+	if (params->cpus) {
+		bool unused;
+
+		retval = osnoise_init_ipi_filters(trace, params, &unused);
+		if (retval < 0)
+			goto out_err;
+	}
+
+done:
 	retval = enable_tracer_by_name(trace->trace.inst, tracer);
 	if (retval) {
 		err_msg("Could not enable %s tracer for tracing\n", tracer);
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 340ff5a64e6e4..81a704c361ec0 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -63,6 +63,10 @@ int osnoise_enable(struct osnoise_tool *tool);
 int osnoise_main(int argc, char **argv);
 int hwnoise_main(int argc, char **argv);
 
+int osnoise_init_ipi_filters(struct osnoise_tool *tool,
+			     struct common_params *params,
+			     bool *filters_enabled);
+
 extern struct tool_ops timerlat_top_ops, timerlat_hist_ops;
 extern struct tool_ops osnoise_top_ops, osnoise_hist_ops;
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index afab2f341a1e9..87d28865515b5 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -392,7 +392,7 @@ osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *record,
  */
 struct osnoise_tool *osnoise_init_top(struct common_params *params)
 {
-	bool ipi_filters_enabled = false;
+	bool ipi_filters_enabled;
 	struct osnoise_tool *tool;
 	int retval;
 
@@ -424,41 +424,11 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 		goto out_err;
 	}
 
-	/*
-	 * If tracing on a subset of possible CPUs, leverage the kernel filtering
-	 * infrastructure to only generate events on traced CPUs.
-	 * Older kernels (pre v6.6) may have the IPI events but not the ability
-	 * to filter them, so allow that to fail gracefully.
-	 */
 	if (params->cpus) {
-		char filter[MAX_PATH];
-
-		snprintf(filter, ARRAY_SIZE(filter), "cpu & CPUS{%s}\n", params->cpus);
-		retval = tracefs_event_file_write(tool->trace.inst,
-						  "ipi", "ipi_send_cpu", "filter",
-						  filter);
-		if (retval < 0) {
-			debug_msg("Could not set ipi_send_cpu CPU filter\n");
-			goto no_filter;
-		}
-
-
-		snprintf(filter, ARRAY_SIZE(filter), "cpumask & CPUS{%s}\n", params->cpus);
-		retval = tracefs_event_file_write(tool->trace.inst,
-						  "ipi", "ipi_send_cpumask", "filter",
-						  filter);
-		if (retval < 0) {
-			/*
-			 * If we managed to set up the previous filter but not
-			 * this one, something's really wrong
-			 */
-			err_msg("Could not set ipi_send_cpumask CPU filter\n");
+		retval = osnoise_init_ipi_filters(tool, params, &ipi_filters_enabled);
+		if (retval < 0)
 			goto out_err;
-		}
-
-		ipi_filters_enabled = true;
 	}
-no_filter:
 
 	/*
 	 * If no filtering is available and we're tracing all CPUs, we can still
-- 
2.55.0

