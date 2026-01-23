Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CCF2FB630
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183013; cv=none; b=is2rbrv5+HuDrzGx4uZ3VxtGjYHzFYxYDTlZFhXS4HuvjHoqHQ4GutcQuRHRuLHBAoPwWfZ459PagyppyzWvk9Ztx3AFMMBmpxf13e4JZokx6Yn9zFMhoMjQMCf7jV/stoHpw6bgsk/JhTn3Z6lCCoYlsZ7RFuC9TW86TBFSRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183013; c=relaxed/simple;
	bh=goOQxHCj2q719asakqaKi2POkVV34ZyBdCHDD6XMC6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mElZ7mO0nbMlTDhTeIaQICUdDyCmJVeitIrre8jBcpKOup4DfgRmVUYpKbrH+KoU6D6opxqCeJsoDjJGhjrQ0EJOg83vrG3MfEVFCqA5UnnkXCcudJOLNnMF8drZjMERrsw6f9OV5+485oNmJxLSZPBBKT+hzhRiHQKYca7RXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GToTghO8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GToTghO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769183010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7s3CG28SINLAnsPeyywEoMXoWeorpu/T3Sj9MCqAl38=;
	b=GToTghO8YVY0x97uEismGqr2LTxS9IQjGeG9RIuSThhksW9sfPBJ1d714S19FdEBcvwT0X
	a+cb+oixSD88uu5qMhDV0MxjIMcjrJtiwMZkekeAtinx0zUBIwiP0vT+RW2hHxxMwtNpVG
	+b4KH1U2LCH28G3wczoY/LLRpEcpb/Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-8k_52l5XOVey1j8YxvzLpg-1; Fri,
 23 Jan 2026 10:43:27 -0500
X-MC-Unique: 8k_52l5XOVey1j8YxvzLpg-1
X-Mimecast-MFC-AGG-ID: 8k_52l5XOVey1j8YxvzLpg_1769183006
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E9D81956054;
	Fri, 23 Jan 2026 15:43:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.59])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 352321800998;
	Fri, 23 Jan 2026 15:43:22 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH 2/3] rtla/timerlat_bpf: Filter samples unseen by tracer
Date: Fri, 23 Jan 2026 16:25:33 +0100
Message-ID: <20260123152534.1036533-3-tglozar@redhat.com>
In-Reply-To: <20260123152534.1036533-1-tglozar@redhat.com>
References: <20260123152534.1036533-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If both BPF and tracefs sample collection are used (mixed mode), drop
samples seen by BPF program when the count of timerlat instances that
are both registered and have tracing on does not match the expected value.

This ensures that there are no samples seen by BPF that are not included
in auto-analysis or trace output.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.bpf.c |  9 +++++++++
 tools/tracing/rtla/src/timerlat.c     | 18 +++++++++++++++++-
 tools/tracing/rtla/src/timerlat.h     |  2 ++
 tools/tracing/rtla/src/timerlat_bpf.c |  8 ++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
index 549d2d2191d2..2724a9bfea4e 100644
--- a/tools/tracing/rtla/src/timerlat.bpf.c
+++ b/tools/tracing/rtla/src/timerlat.bpf.c
@@ -12,6 +12,8 @@ char LICENSE[] SEC("license") = "GPL";
 struct trace_event_raw_timerlat_sample {
 	unsigned long long timer_latency;
 	int context;
+	int instances_registered;
+	int instances_on;
 } __attribute__((preserve_access_index));
 
 struct {
@@ -58,6 +60,8 @@ const volatile int entries = 256;
 const volatile int irq_threshold;
 const volatile int thread_threshold;
 const volatile bool aa_only;
+const volatile int instances_registered = -1;
+const volatile int instances_on = -1;
 
 nosubprog unsigned long long map_get(void *map,
 				     unsigned int key)
@@ -143,6 +147,11 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
 	unsigned long long latency, latency_us;
 	int bucket;
 
+	if ((instances_registered != -1 && tp_args->instances_registered != instances_registered)
+		|| (instances_on != -1 && tp_args->instances_on != instances_on))
+		/* This sample is not seen by all trace instances, filter it out */
+		return 0;
+
 	if (map_get(&stop_tracing, 0))
 		return 0;
 
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 8f8811f7a13b..069f916100e7 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -28,6 +28,7 @@ int
 timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
 	int retval;
+	struct tep_event *event = NULL;
 
 	/*
 	 * Try to enable BPF, unless disabled explicitly.
@@ -36,10 +37,25 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
 		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
 		params->mode = TRACING_MODE_TRACEFS;
-	} else if (!tep_find_event_by_name(tool->trace.tep, "osnoise", "timerlat_sample")) {
+	} else if (!(event = tep_find_event_by_name(tool->trace.tep, "osnoise", "timerlat_sample"))) {
 		debug_msg("osnoise:timerlat_sample missing, disabling BPF\n");
 		params->mode = TRACING_MODE_TRACEFS;
+	}
+
+	if (event && tep_find_field(event, "instances_registered") &&
+	    tep_find_field(event, "instances_on")) {
+		params->has_instance_count_fields = true;
+
+		if (!params->no_aa)
+			params->instances_on++;
+		if (params->common.threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+		    params->common.end_actions.present[ACTION_TRACE_OUTPUT])
+			params->instances_on++;
 	} else {
+		params->has_instance_count_fields = false;
+	}
+
+	if (params->mode != TRACING_MODE_TRACEFS) {
 		retval = timerlat_bpf_init(params);
 		if (retval) {
 			debug_msg("Could not enable BPF\n");
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 8dd5d134ce08..ef97e545c7ff 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -28,6 +28,8 @@ struct timerlat_params {
 	int			deepest_idle_state;
 	enum timerlat_tracing_mode mode;
 	const char		*bpf_action_program;
+	bool			has_instance_count_fields;
+	int			instances_on;
 };
 
 #define to_timerlat_params(ptr) container_of(ptr, struct timerlat_params, common)
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 05adf18303df..80801796bbf0 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -53,6 +53,14 @@ int timerlat_bpf_init(struct timerlat_params *params)
 		bpf_map__set_autocreate(bpf->maps.summary_user, false);
 	}
 
+	if (params->mode == TRACING_MODE_MIXED && params->has_instance_count_fields) {
+		bpf->rodata->instances_on = params->instances_on;
+		bpf->rodata->instances_registered = params->instances_on + 1; /* +1 for the main instance */
+	} else {
+		bpf->rodata->instances_registered = -1;
+		bpf->rodata->instances_on = -1;
+	}
+
 	/* Load and verify BPF program */
 	err = timerlat_bpf__load(bpf);
 	if (err) {
-- 
2.52.0

