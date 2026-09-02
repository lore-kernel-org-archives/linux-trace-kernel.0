Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD5493639
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352858; cv=none; b=kZXjoTWcetcH5Xj7JEu7Z7qyBhD7Kfwx8V+X9P2mCAdCdQ6D5W13VunRAoDFSNu4PxW5iH89CemdsJVxKie84f3hIJ7+Rl+CxmPPxD291befofRb4mB9yCtne9izP8ZaLivu045bK05g4k2LCccD4Kc+K9tpDQoGUY4TUDgn3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352858; c=relaxed/simple;
	bh=xyTZtukQ0nTIad9odCB2JAq1OSBUbce1d5b+4Bs6x8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=edbZSPoq9e5dA8dagkb2eUbefQIu82+RHqKq/5PromVV4I3jvF8w+La7osKj5lCPfU7pvU7VLW/NUvgnnlDPyHKToMfoGIKHuN51Pd871wmagbrdBLGR2GZT9pI2CqxqvRYPxWqmGCOVKKnp1zGj3bEI1DD8heUoc/1mwMX9mHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AY3IMnds; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AY3IMnds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788352855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hioaiPo7qfRBBdUI+++gzH6e7JfDnvI7QypkLOQkxAg=;
	b=AY3IMndscpCxqbN4LGc/ujYhcAijsiLLygWK3lVwMzSDwBqZVY6p9job7OfbcnLNpvjKwQ
	Hz3b9USg5iChCYWQJMeTtLO7gp31UiNlKooWHQ3rZb96vDUgJwBIdhTHf5YChC/n7wHONj
	epKjArOS0LMgoyuJtStCVV9l5oAAg9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-evUGaa1zP3ujXCvI2C7LBQ-1; Wed,
 02 Sept 2026 08:40:52 -0400
X-MC-Unique: evUGaa1zP3ujXCvI2C7LBQ-1
X-Mimecast-MFC-AGG-ID: evUGaa1zP3ujXCvI2C7LBQ_1788352850
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B4B31921EEA;
	Wed,  2 Sep 2026 12:40:50 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FEB51955F72;
	Wed,  2 Sep 2026 12:40:46 +0000 (UTC)
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
Subject: [PATCH v5 8/8] rtla/osnoise: Trace IPI events when recording a trace file
Date: Wed,  2 Sep 2026 14:39:37 +0200
Message-ID: <20260902123942.695822-9-vschneid@redhat.com>
In-Reply-To: <20260902123942.695822-1-vschneid@redhat.com>
References: <20260902123942.695822-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ePehsb6eK7PSiunU_DncIXWGbwADTo4E71lhxNbZeus_1788352850
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
index 8c7f5e75b2ec8..2f6cf83475550 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -205,7 +205,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 
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

