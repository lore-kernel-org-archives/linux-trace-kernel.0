Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78019DF4F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096732; cv=none; b=F+3ZScB4crOaI/Udvky2afzUCjk+JReYRY/lLB0/UJSG48x7VhHYg+SKB34sncqIbt14RKt8IELkP0K93ZlpWInclzeVVRlZzircFUHmL/vDfT9sFgY43i6w3/7naN86XZUYfcWn9BmMf+KABLLRHFYVgkNHTSHc0XgQQVX0Zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096732; c=relaxed/simple;
	bh=4ebVVeDyRG6IP+IxaSEInDCBy6YwTa/gFms+KrdMbB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=B2hj55ieEKdzUBfYzvk+wNA08zktNB1Hf+oVNW0OwgUI6cEGBms8iwBeEg6vZX+C5gILaU23Wx1AX8vXp4QHeX+HBBcfJMJn5XzbfqXRIGelNup7L7lGblKMfYj8ExawuXqdWUs2LPs0C4CYxPTVMnqA53+cJk9KIGGv0PXqCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzkQe1hr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzkQe1hr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781096729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejD5bbC77pUF8fI78IgEYFGn/nrh3c8FnFb3o3GHTaM=;
	b=LzkQe1hrdiAtkj/xjuBZERc1PCAiKOYTvSsjzt0uPg8ElEWnBVw1Pin8yletunJWjAqm7t
	dOaatNJf/fv9ES+Dx/3xfn1/ZYnaOIP8M15WKuogjWwauLHhT62o6CepFm/IFHkUHwx0Jz
	v4NSp3Isq0kQeNDCZdS9CCgmmZwFtvU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-1X6jVlBpNLOwJCV4J07-YA-1; Wed,
 10 Jun 2026 09:05:25 -0400
X-MC-Unique: 1X6jVlBpNLOwJCV4J07-YA-1
X-Mimecast-MFC-AGG-ID: 1X6jVlBpNLOwJCV4J07-YA_1781096724
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7597E18DB40A;
	Wed, 10 Jun 2026 13:05:24 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 888B23000223;
	Wed, 10 Jun 2026 13:05:21 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [RFC PATCH 2/2] rtla/osnoise: Report IPI count in osnoise top
Date: Wed, 10 Jun 2026 15:04:52 +0200
Message-ID: <20260610130457.1304245-3-vschneid@redhat.com>
In-Reply-To: <20260610130457.1304245-1-vschneid@redhat.com>
References: <20260610130457.1304245-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: yypF6KYHOCwqLyn3AMIcTAl0evAS8_9WGpEi6pwvY8c_1781096724
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The osnoise tracer now also reports IPI count, extract & report them.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index e65312ec26c43..6fd5353c82f38 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -25,6 +25,7 @@ struct osnoise_top_cpu {
 	unsigned long long	irq_count;
 	unsigned long long	softirq_count;
 	unsigned long long	thread_count;
+	unsigned long long	ipi_count;
 
 	int			sum_cycles;
 };
@@ -116,6 +117,9 @@ osnoise_top_handler(struct trace_seq *s, struct tep_record *record,
 	tep_get_field_val(s, event, "thread_count", record, &val, 1);
 	update_sum(&cpu_data->thread_count, &val);
 
+	tep_get_field_val(s, event, "ipi_count", record, &val, 1);
+	update_sum(&cpu_data->ipi_count, &val);
+
 	return 0;
 }
 
@@ -163,7 +167,7 @@ static void osnoise_top_header(struct osnoise_tool *top)
 	if (params->mode == MODE_HWNOISE)
 		goto eol;
 
-	trace_seq_printf(s, "          IRQ      Softirq       Thread");
+	trace_seq_printf(s, "          IRQ      Softirq       Thread          IPI");
 
 eol:
 	if (pretty)
@@ -218,7 +222,8 @@ static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
 
 	trace_seq_printf(s, "%12llu ", cpu_data->irq_count);
 	trace_seq_printf(s, "%12llu ", cpu_data->softirq_count);
-	trace_seq_printf(s, "%12llu\n", cpu_data->thread_count);
+	trace_seq_printf(s, "%12llu ", cpu_data->thread_count);
+	trace_seq_printf(s, "%12llu\n", cpu_data->ipi_count);
 }
 
 /*
-- 
2.54.0

