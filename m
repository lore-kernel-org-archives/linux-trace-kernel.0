Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD74071C4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702323; cv=none; b=PmGvy265JQuEZWEUmxUDJiq8u4JICPkyNhlbcn6BsenGSxMl23+ODqYT+pp05xV6TL3yxDRDk/3SZcgKuemRwZ/tisFZbFK53D34LDDoW+Nr1mizxslw6Tm+lOKdfRr8TUgfyahEMMf0n/1+gIjd4VvPMn2XpqKzI1SZv3l8R7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702323; c=relaxed/simple;
	bh=ozPaqmsKSxoaOW+eYiVaK6OUBhzWMg1XN7GUGPiJtus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VMadjUCj56EN0D/Xj+7uRRAshKgISHuPK9tbEPZ2ngIiRJDc85ncldqG4inXkuQTvgKLVgYGYa1/vM7qBhcMUytDuuGjesad9u+xrBITiEKpXSaBI4A0mdwgSC0Kabv+QCfLycxzRzxJRioW1WsXgXskJxBZgFDUcK95M0t3B6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqzZpVRn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqzZpVRn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781702321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXu2/hzhO0ErztKnAu7h4X31BWQFMjzfPznnbvj1HNA=;
	b=HqzZpVRnTByZEh5OA5NkGet3Ictp42jQAdWmjbSwTbkEt6ueLfpMAk+VSx1FBpkUvghroE
	Li6d3rCE80dLx29zvjZX+aWZsiRHI8/TzCFuEy9c1myOvtiGgwKQHF2s6c7KQ001GumQ7t
	jhC1FIyzqgjTyK6xnzpzbU8DKVonw6U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-QG6eQ8fKMkiHreCIMuXBXA-1; Wed,
 17 Jun 2026 09:18:38 -0400
X-MC-Unique: QG6eQ8fKMkiHreCIMuXBXA-1
X-Mimecast-MFC-AGG-ID: QG6eQ8fKMkiHreCIMuXBXA_1781702316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87C401806C90;
	Wed, 17 Jun 2026 13:18:36 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.34.165])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 559EC1800661;
	Wed, 17 Jun 2026 13:18:33 +0000 (UTC)
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
Subject: [RFC PATCH v2 4/4] rtla/osnoise: Leverage IPI event filters when tracing a subset of CPUs
Date: Wed, 17 Jun 2026 15:17:59 +0200
Message-ID: <20260617131803.2988989-5-vschneid@redhat.com>
In-Reply-To: <20260617131803.2988989-1-vschneid@redhat.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: oAvkwKuZNb9SHxXexJxVmzKCll4B8ozexq5HwTszp4c_1781702316
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Instead of post-processing the events in the tracefs_iterate_raw_events()
callbacks, leverage the kernel event filtering infrastructure to only emit
IPI events if they target CPUs that are being traced, as specified by the
-c cmdline option.

Note that some post-processing is still required for the ipi_send_cpumask
event, as the event being emitted means *some* CPUs targeted by that event
are monitored, but not all of them - userspace has to recompute that
intersection.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c | 37 +++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 5b462a3543b97..8040521710884 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -93,18 +93,15 @@ osnoise_ipi_cpu_handler(struct trace_seq *s, struct tep_record *record,
 		     struct tep_event *event, void *context)
 {
 	struct osnoise_tool *tool;
-	struct osnoise_params *params;
 	unsigned long long src_cpu, dst_cpu;
 	struct trace_instance *trace = context;
 
 	tool = container_of(trace, struct osnoise_tool, trace);
-	params = to_osnoise_params(tool->params);
 
 	src_cpu = record->cpu;
 	tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
 
-	if (CPU_ISSET(dst_cpu, &params->common.monitored_cpus))
-		account_ipi(tool, src_cpu, dst_cpu);
+	account_ipi(tool, src_cpu, dst_cpu);
 
 	return 0;
 }
@@ -141,6 +138,11 @@ osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *record,
 		return 0;
 	}
 
+	/*
+	 * Despite already filtering for such an intersection, we need to compute
+	 * the intersection here as the @cpumask field may contain non-monitered
+	 * CPUs.
+	 */
 	CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored_cpus);
 
 	/*
@@ -406,6 +408,33 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
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
+		if (retval) {
+			err_msg("Could not set ipi_send_cpu CPU filter\n");
+			goto out_err;
+		}
+
+
+		snprintf(filter, ARRAY_SIZE(filter), "cpumask & CPUS{%s}\n", params->cpus);
+		retval = tracefs_event_file_write(tool->trace.inst,
+						  "ipi", "ipi_send_cpumask", "filter",
+						  filter);
+		if (retval) {
+			err_msg("Could not set ipi_send_cpumask CPU filter\n");
+			goto out_err;
+		}
+	}
+
 	tep_register_event_handler(tool->trace.tep, -1, "ipi", "ipi_send_cpu",
 				   osnoise_ipi_cpu_handler, NULL);
 
-- 
2.54.0

