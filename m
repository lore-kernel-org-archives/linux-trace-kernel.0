Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E04071C7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702321; cv=none; b=Wz4bm2udl+lMR5Y3YSDyEBbXYoW4EZBq0gIXMDv5v/O0ij+sbZ2mL+OyupOPbtx2gm7eyJub6kJCmucSGY+q8t1YCYNJijiS5z29OJp5KhrH7pMn4YGc8X/mI+ZMIy7IpUfO62VnHdABfncxBK1Mb2QmnDvXNZbIahaifQCs4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702321; c=relaxed/simple;
	bh=aQaCQWWuuC6ec7b2VkuFVnlosCxUZIFVxjLMCbWl7kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KdlXDbNzcmPuP8jmjjoo8tPKE4bpEVnkppMmSRX68pyh7AB81IyP2dJgvHi/rQKOVCliHmlelXHdm+wCDBLlD8r6ApORQecLKdxJt6tSNzxabN6cpEu2K2qoEC0ef14fY3Ji24CK6ofA3StBjOEzLQVcJyWKN4pEYJ/TwjgBWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgoIA0fm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgoIA0fm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781702318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q45nV+7l+QpyDRCdvuzjLoPvmOApQgcTLxPEjmhUrRA=;
	b=GgoIA0fmwRQn7MghMUIfgle+FWSF1bOsa3IVh7YBEFBHnjzca6ymCIwdqN5JY6dYYJ6WGF
	jjUUS6EIJMQiTEEGMdu9SVBeO2qzdNygn/FdaD1L99KNboFQTwP/OueRi36R1iUHUBW9DI
	EhivX5oAW3/Wj2tjopRWPMMd3QjUuo8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-OHRpc-Z9Nhus92ug0VbuNg-1; Wed,
 17 Jun 2026 09:18:34 -0400
X-MC-Unique: OHRpc-Z9Nhus92ug0VbuNg-1
X-Mimecast-MFC-AGG-ID: OHRpc-Z9Nhus92ug0VbuNg_1781702313
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF2721800581;
	Wed, 17 Jun 2026 13:18:32 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.34.165])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E820180049F;
	Wed, 17 Jun 2026 13:18:29 +0000 (UTC)
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
Subject: [RFC PATCH v2 3/4] rtla/osnoise: Trace IPI events when recording a trace file
Date: Wed, 17 Jun 2026 15:17:58 +0200
Message-ID: <20260617131803.2988989-4-vschneid@redhat.com>
In-Reply-To: <20260617131803.2988989-1-vschneid@redhat.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: rJm4fezIAPOcfhGWsnR2QnJFUv877rWUk0d38afTuEY_1781702313
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

IPIs can now be monitored and accounted by osnoise top. When that is
the case, also record them when saving a trace file.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/common.c  |  2 +-
 tools/tracing/rtla/src/common.h  |  2 +-
 tools/tracing/rtla/src/osnoise.c | 17 ++++++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

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
index 4ff5dad013b10..281f6f57d15af 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1181,7 +1181,8 @@ struct osnoise_tool *osnoise_init_tool(char *tool_name)
 /*
  * osnoise_init_trace_tool - init a tracer instance to trace osnoise events
  */
-struct osnoise_tool *osnoise_init_trace_tool(const char *tracer)
+struct osnoise_tool *osnoise_init_trace_tool(struct common_params *params,
+					     const char *tracer)
 {
 	struct osnoise_tool *trace;
 	int retval;
@@ -1196,6 +1197,20 @@ struct osnoise_tool *osnoise_init_trace_tool(const char *tracer)
 		goto out_err;
 	}
 
+	if (params->ipi) {
+		retval = tracefs_event_enable(trace->trace.inst, "ipi", "ipi_send_cpu");
+		if (retval < 0 && !errno) {
+			err_msg("Could not find ipi_send_cpu event\n");
+			goto out_err;
+		}
+
+		retval = tracefs_event_enable(trace->trace.inst, "ipi", "ipi_send_cpumask");
+		if (retval < 0 && !errno) {
+			err_msg("Could not find ipi_send_cpumask event\n");
+			goto out_err;
+		}
+	}
+
 	retval = enable_tracer_by_name(trace->trace.inst, tracer);
 	if (retval) {
 		err_msg("Could not enable %s tracer for tracing\n", tracer);
-- 
2.54.0

