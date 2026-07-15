Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD33392811
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130420; cv=none; b=FakHi+WpoVJhn2b4w/pNsrjzIS4B15D5Yf0FaGAK4SHLKGmXuW8S31EB0+KrAv3ZRGbp4qLbI/THadHX01B2CPaJlM8QNxkwe/oj51LmLYBBkFwM/ocGAmzySdQrKOd0UOGKKB6BKKf+Szg413NqYF78Jxty562gyDFWpDPDXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130420; c=relaxed/simple;
	bh=APOsm8JAmb4xKko1LI/DErr6AxacMhKSZv2IlIg/kzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VvBQi3gyoUKW7EWX2mnVO2mOmED4OsPU6C5PManHJEIoksea+QQvuXa0VCQstt/qGYC2Bem5PV2JuEEtGIhxb7VkhvN9jr50w5bcP6Sd1wJSaobCMWYpOLGaaqR/OmGG8JiaS4JXdSuCcI7zTpHmZu0MzUYOd8lZVCggIXD8Izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQQg1q9m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQQg1q9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784130416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCxPgKyWjQRuxjOhKVOZFlCvpZ99tG2XrAFjK938emU=;
	b=HQQg1q9mPHEjMauYsf4S25IEhhkqQABxP7dwgwJf/V2KVjeukAJ4/7YrdDI7EI9sDLF431
	RegpDnKbQFFrk3EUIR8JQ7D42EHEPkzT/OY3nrHcfgYiSRXUCpTmJDzDUo1B0eB1RJ//s7
	ke2jEyzwSSU3b2oNqtk98MZT+6cbyp0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-Ug8_ypmAPi2aQ7pIrCN1aA-1; Wed,
 15 Jul 2026 11:46:52 -0400
X-MC-Unique: Ug8_ypmAPi2aQ7pIrCN1aA-1
X-Mimecast-MFC-AGG-ID: Ug8_ypmAPi2aQ7pIrCN1aA_1784130411
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B6A21955F05;
	Wed, 15 Jul 2026 15:46:51 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.32.112])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060A01800361;
	Wed, 15 Jul 2026 15:46:47 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 4/6] rtla/osnoise: Allow IPI filters to gracefully fail
Date: Wed, 15 Jul 2026 17:45:49 +0200
Message-ID: <20260715154553.2020891-5-vschneid@redhat.com>
In-Reply-To: <20260715154553.2020891-1-vschneid@redhat.com>
References: <20260715154553.2020891-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Oarg2soZsNIBp-Chay4S_AqS3D8akXIQGOG8ZGpUNtM_1784130411
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Kernels pre v6.6 won't have:

  39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")

and thus won't be able to filter events using a user-provided cpumask, but
will still be capable of recording IPI events.

Make failing to set a filter for IPI events an acceptable error and fall
back to event handlers that do the filtering job themselves.

Suggested-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c | 49 +++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 353b435fefcf8..afab2f341a1e9 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -313,6 +313,30 @@ osnoise_ipi_cpu_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+/*
+ * osnoise_ipi_cpu_unfiltered_handler - this is the handler for single CPU IPI
+ *                                      events. Slightly less optimized than
+ *                                      the filtered variant.
+ */
+static int
+osnoise_ipi_cpu_unfiltered_handler(struct trace_seq *s, struct tep_record *record,
+		     struct tep_event *event, void *context)
+{
+	struct osnoise_tool *tool;
+	unsigned long long dst_cpu;
+	struct osnoise_params *params;
+	struct trace_instance *trace = context;
+
+	tool = container_of(trace, struct osnoise_tool, trace);
+	params = to_osnoise_params(tool->params);
+	tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
+
+	if (CPU_ISSET(dst_cpu, &params->common.monitored_cpus))
+		account_ipi(tool, dst_cpu);
+
+	return 0;
+}
+
 static cpu_set_t cpumask_tmp_cpus;
 
 /*
@@ -343,7 +367,7 @@ osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *record,
 	}
 
 	/*
-	 * Despite already filtering for such an intersection, we need to compute
+	 * Even if already filtering for such an intersection, we need to compute
 	 * the intersection here as the @cpumask field may contain non-monitored
 	 * CPUs.
 	 */
@@ -368,6 +392,7 @@ osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *record,
  */
 struct osnoise_tool *osnoise_init_top(struct common_params *params)
 {
+	bool ipi_filters_enabled = false;
 	struct osnoise_tool *tool;
 	int retval;
 
@@ -402,6 +427,8 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 	/*
 	 * If tracing on a subset of possible CPUs, leverage the kernel filtering
 	 * infrastructure to only generate events on traced CPUs.
+	 * Older kernels (pre v6.6) may have the IPI events but not the ability
+	 * to filter them, so allow that to fail gracefully.
 	 */
 	if (params->cpus) {
 		char filter[MAX_PATH];
@@ -411,8 +438,8 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 						  "ipi", "ipi_send_cpu", "filter",
 						  filter);
 		if (retval < 0) {
-			err_msg("Could not set ipi_send_cpu CPU filter\n");
-			goto out_err;
+			debug_msg("Could not set ipi_send_cpu CPU filter\n");
+			goto no_filter;
 		}
 
 
@@ -421,13 +448,27 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 						  "ipi", "ipi_send_cpumask", "filter",
 						  filter);
 		if (retval < 0) {
+			/*
+			 * If we managed to set up the previous filter but not
+			 * this one, something's really wrong
+			 */
 			err_msg("Could not set ipi_send_cpumask CPU filter\n");
 			goto out_err;
 		}
+
+		ipi_filters_enabled = true;
 	}
+no_filter:
 
+	/*
+	 * If no filtering is available and we're tracing all CPUs, we can still
+	 * use the filtered callback since stats are collected for all CPUs.
+	 */
 	tep_register_event_handler(tool->trace.tep, -1, "ipi", "ipi_send_cpu",
-				   osnoise_ipi_cpu_handler, NULL);
+				   (!params->cpus || ipi_filters_enabled) ?
+				   osnoise_ipi_cpu_handler :
+				   osnoise_ipi_cpu_unfiltered_handler,
+				   NULL);
 
 	tep_register_event_handler(tool->trace.tep, -1, "ipi", "ipi_send_cpumask",
 				   osnoise_ipi_cpumask_handler, NULL);
-- 
2.55.0

