Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451D49482D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352838; cv=none; b=aTQPFNG7pW1I9vV7xiBw/tSkls5TAFBRDC5bO7C75N5YQXrJm3pZ59Y1bx7pUKOFA99bM2QbUlcGr5bYVlqByyoxSV8tUf24q3bGpVV4cGd22j9wVXqJk7kqq+FPEo+5h8fVCjwA704SNXuFcqS/KcYJIMWjLg2D0dr4H1hSy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352838; c=relaxed/simple;
	bh=Na7db9/2s80znu/9AE5DCwfjSCJNFyIOryOmFE9wqsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kQcd/g0zM0jDGuy6CyHpNH1oR+LkgRNMH6IO97sKG5isfF6XzLPC+7TqJA9lBVaUFLaNi3oIYhaRNLm47CpvEl2Yy3Qrfzqm1XYC7rBOJkefoPfFIAE48ZtOPu1UyPK/PptUpktyULnUrC9T+RNe4LbVyrJqpp5LxBH07xDgljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DA21j1m/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA21j1m/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788352835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtAUMyjozqDTITd3GB3tSLmdiU/PUp/kO4z4pdtBy74=;
	b=DA21j1m/XLtaDjQ8UKqr8dWNUY/mcniMZ01b9pFywCOGhZC2YvdGraEjsljhdiGwRhkWrB
	Povv8GGmE5DIj6dP/xSvQGKGXsP1S0X/3p5lu7bu4JC7IWAco/NBlywb8WlX+Nj471sdSI
	0Y/tSO1J4Tao2yNGCbeqnPL6MUSMggw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-x6c-OkcsNBWANv3AfSiupA-1; Wed,
 02 Sept 2026 08:40:29 -0400
X-MC-Unique: x6c-OkcsNBWANv3AfSiupA-1
X-Mimecast-MFC-AGG-ID: x6c-OkcsNBWANv3AfSiupA_1788352828
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D6E7195604B;
	Wed,  2 Sep 2026 12:40:28 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE0951955F72;
	Wed,  2 Sep 2026 12:40:24 +0000 (UTC)
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
Subject: [PATCH v5 3/8] rtla/osnoise: Leverage IPI event filters when tracing a subset of CPUs
Date: Wed,  2 Sep 2026 14:39:32 +0200
Message-ID: <20260902123942.695822-4-vschneid@redhat.com>
In-Reply-To: <20260902123942.695822-1-vschneid@redhat.com>
References: <20260902123942.695822-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 7IdiyigZFEgpBOP6MTuT-iR1lzQY0XbR8lJv-ujvoP4_1788352828
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Leverage the kernel event filtering infrastructure to only emit IPI events
if they target CPUs that are being traced, as specified by the -c cmdline
option.

Note that some post-processing is still required for the ipi_send_cpumask
event, as the event being emitted means *some* CPUs targeted by that event
are monitored, but not all of them - userspace has to recompute that
intersection.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c | 38 ++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 7b5ae5336cf08..353b435fefcf8 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -302,17 +302,13 @@ osnoise_ipi_cpu_handler(struct trace_seq *s, struct tep_record *record,
 		     struct tep_event *event, void *context)
 {
 	struct osnoise_tool *tool;
-	struct osnoise_params *params;
 	unsigned long long dst_cpu;
 	struct trace_instance *trace = context;
 
 	tool = container_of(trace, struct osnoise_tool, trace);
-	params = to_osnoise_params(tool->params);
-
 	tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
 
-	if (CPU_ISSET(dst_cpu, &params->common.monitored_cpus))
-		account_ipi(tool, dst_cpu);
+	account_ipi(tool, dst_cpu);
 
 	return 0;
 }
@@ -346,6 +342,11 @@ osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *record,
 		return 0;
 	}
 
+	/*
+	 * Despite already filtering for such an intersection, we need to compute
+	 * the intersection here as the @cpumask field may contain non-monitored
+	 * CPUs.
+	 */
 	CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored_cpus);
 
 	/*
@@ -398,6 +399,33 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 		goto out_err;
 	}
 
+	/*
+	 * If tracing on a subset of possible CPUs, leverage the kernel filtering
+	 * infrastructure to only generate events on traced CPUs.
+	 */
+	if (params->cpus) {
+		char filter[MAX_PATH];
+
+		snprintf(filter, ARRAY_SIZE(filter), "cpu & CPUS{%s}\n", params->cpus);
+		retval = tracefs_event_file_write(tool->trace.inst,
+						  "ipi", "ipi_send_cpu", "filter",
+						  filter);
+		if (retval < 0) {
+			err_msg("Could not set ipi_send_cpu CPU filter\n");
+			goto out_err;
+		}
+
+
+		snprintf(filter, ARRAY_SIZE(filter), "cpumask & CPUS{%s}\n", params->cpus);
+		retval = tracefs_event_file_write(tool->trace.inst,
+						  "ipi", "ipi_send_cpumask", "filter",
+						  filter);
+		if (retval < 0) {
+			err_msg("Could not set ipi_send_cpumask CPU filter\n");
+			goto out_err;
+		}
+	}
+
 	tep_register_event_handler(tool->trace.tep, -1, "ipi", "ipi_send_cpu",
 				   osnoise_ipi_cpu_handler, NULL);
 
-- 
2.55.0

