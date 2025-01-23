Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40473212B35
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642259; cv=none; b=LmIoaUwO8l3SvEIZ9vybkJcIrngQwJWH2jR94qnDIW9hXv4dWcMQRx6tzTQDCtHB2kf9kco2JN9OOc602UGZg1nUnEW7SejW/ooT/v3JXJEH99SHJjYQS08e+f9ia5RIm6bD2nAteJOJD+SBRrU2mii4UVubg+P/ZaRiQeby7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642259; c=relaxed/simple;
	bh=1D/ucQMoB2M/CHqDppJhDu+2Sta44h7HmcEkMLXLK0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=do6cY+1RBQMpIwg+WHmwHN7RXssYZavrbB43PtHNNPrD4XwLUcsaeWdMXw+4eN1rhJassqpv2mIW5KidpFNa3HCJLkHBTFSh+vNTuyNSBaC5txmUTbqxfbUFB3BBwH+g4HBYYVRh7QkbLMnd0oelK8jgJx6aXvxw/znT/fpDM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anGXBW0B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anGXBW0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737642257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr3HA6KK95LL58cJ/DRUd0E8EbP8cIddfYBa+I+9Yiw=;
	b=anGXBW0BnlfSenUIr6/Y9aNIRE04PFQDEeLQlz6Sw6Hh2nR6ITwszJbYrWlYe9GQCLg0CG
	/R8nRkK33LF9Z+Uwj9o24HEdrHyO0iukJ8lolx4G7SP6bgVcVZaFfE7lt3GiWh7JSMzbl1
	+VmxcEuYiz4V/jDgg6ADfjA6JfIelXU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-yCw5pvJ_PFKeVthyilPqPg-1; Thu,
 23 Jan 2025 09:24:13 -0500
X-MC-Unique: yCw5pvJ_PFKeVthyilPqPg-1
X-Mimecast-MFC-AGG-ID: yCw5pvJ_PFKeVthyilPqPg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 023BB1956065;
	Thu, 23 Jan 2025 14:24:13 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8613195608A;
	Thu, 23 Jan 2025 14:24:10 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/4] rtla: Add function to report missed events
Date: Thu, 23 Jan 2025 15:23:38 +0100
Message-ID: <20250123142339.990300-4-tglozar@redhat.com>
In-Reply-To: <20250123142339.990300-1-tglozar@redhat.com>
References: <20250123142339.990300-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add osnoise_report_missed_events to be used to report the number
of missed events either during or after an osnoise or timerlat run.
Also, display the percentage of missed events compared to the total
number of received events.

If an unknown number of missed events was reported during the run, the
entire number of missed events is reported as unknown.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c | 20 ++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 245e9344932b..eede5e01bff6 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1079,6 +1079,26 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
 	return NULL;
 }
 
+/*
+ * osnoise_report_missed_events - report number of events dropped by trace
+ * buffer
+ */
+void
+osnoise_report_missed_events(struct osnoise_tool *tool)
+{
+	unsigned long long total_events;
+
+	if (tool->trace.missed_events == UINT64_MAX)
+		printf("unknown number of events missed, results might not be accurate\n");
+	else if (tool->trace.missed_events > 0) {
+		total_events = tool->trace.processed_events + tool->trace.missed_events;
+
+		printf("%lld (%.2f%%) events missed, results might not be accurate\n",
+		       tool->trace.missed_events,
+		       (double) tool->trace.missed_events / total_events * 100.0);
+	}
+}
+
 static void osnoise_usage(int err)
 {
 	int i;
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 555f4f4903cc..43e4b7bb7f4a 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -104,6 +104,7 @@ struct osnoise_tool {
 void osnoise_destroy_tool(struct osnoise_tool *top);
 struct osnoise_tool *osnoise_init_tool(char *tool_name);
 struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
+void osnoise_report_missed_events(struct osnoise_tool *tool);
 
 int osnoise_hist_main(int argc, char *argv[]);
 int osnoise_top_main(int argc, char **argv);
-- 
2.48.1

