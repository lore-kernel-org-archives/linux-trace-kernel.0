Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA674C0420
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865413; cv=none; b=lRt0IryN+kWdLhySyRWWj4aZrriXNgglp3EfUiY5pucYpzL/SUqv52vyYI7lY4xGkzWkJ3ngmvwxNf5/JocjQO7hv3N/JAw2TdvPJdwDFxaMOQ2nQm6X40p570grfzYc4G8LXooVeLTlESSwxopOuBE8tfMpHfKwklJf2T22zDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865413; c=relaxed/simple;
	bh=Na7db9/2s80znu/9AE5DCwfjSCJNFyIOryOmFE9wqsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fCIZWWV8cXT2T92JCRTPRMMgwO7R14fhASeBKu/JvH5yc+QZqvF4ndbXoB7eOIKeqxF48RQb8SDnUVBUypayKVq9+QzXF/+DsYdGOVewLYaDsiVP1KXJvWbmmk2imxrVo3TxaUTZqppl1AuiIX4NfqiohLth4bR59nkYfTtqMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ouv3N8H1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ouv3N8H1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785865410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtAUMyjozqDTITd3GB3tSLmdiU/PUp/kO4z4pdtBy74=;
	b=Ouv3N8H1hEB/5DWsslC/qysJMZwv0tFxQh2QAMrIhul3bWh2ORMR2tFiBzD5ZqFduiPx7T
	pETNd99/FrLxj4FV7MrrX7irRU87xlEN5R1QgkZegaENEw6wwCkHCHi0xItWYqzphseyVh
	KpZnzhxBQhLr4LHysWQk3YkilKLrs0Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-ez0zFdWoOX-djmQnZk_cyQ-1; Tue,
 04 Aug 2026 13:43:26 -0400
X-MC-Unique: ez0zFdWoOX-djmQnZk_cyQ-1
X-Mimecast-MFC-AGG-ID: ez0zFdWoOX-djmQnZk_cyQ_1785865404
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EF65195604B;
	Tue,  4 Aug 2026 17:43:24 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.34.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF314195422C;
	Tue,  4 Aug 2026 17:43:20 +0000 (UTC)
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
Subject: [PATCH v4 3/6] rtla/osnoise: Leverage IPI event filters when tracing a subset of CPUs
Date: Tue,  4 Aug 2026 19:42:35 +0200
Message-ID: <20260804174242.2288433-4-vschneid@redhat.com>
In-Reply-To: <20260804174242.2288433-1-vschneid@redhat.com>
References: <20260804174242.2288433-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: xtLEiQgG-kdCfRKN7a_1lU4GCpFd8etJAhy-9ny3gl0_1785865404
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

