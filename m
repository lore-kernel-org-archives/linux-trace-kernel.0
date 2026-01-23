Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF22F618B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183019; cv=none; b=oMMgw/c51VPRssxotsnVWp920K6mQAQr87VSCCbjHFxB+YXFXHA0fSM7QPrpRrydlZZYLS9xpw802eCD4Bd4o4emHJSAy9K0SSI9QHpAEUUKivETrdgAxAgiE9sqOkz0EJ4H3QdtnD3LraXXjlTqCie+jBliNBQo8+dz1Bken7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183019; c=relaxed/simple;
	bh=9LoUwfXrMrjPUPnHDS7DWd0SWwF3Ha/G4b/0MLy344w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wd9n2l0OF7zXaZO0Ej80XmBlTYYOJqEaRSuwWESdMLFtuNpg3bhJKsQ2SrDzVEvjDL+yn1Zkx/z4TGNXxHsCtEYUasTQo5qUenThKJcOWw9bvw8WSc8cY8yvHfBtbDYBRz7g4nOTUVZvXuDjp7KE9cVENucl9MNaO3YII1JmYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHT3OgXt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHT3OgXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769183014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTMLV/ktvUIYmallXY3510Gw9B5viJgJMKNSmr/W1f8=;
	b=PHT3OgXtfb4t+QTUTdyKf/59O1kUpjPavtB5+wYYpFYobLvauYOrJhnj1n0EcooRHv04kG
	H4k9EEffLz4KIPeyyR2r48PcAE53Y8aEeR1RzJ4f8AWiTyHvsOtfrXzKQUpeDXeQhJPHiY
	Wvu7pGvzuFH/oZuL+Lj8auTO1mJeB3c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-YpqCMGX4Mo-jaOX6q2FnSQ-1; Fri,
 23 Jan 2026 10:43:30 -0500
X-MC-Unique: YpqCMGX4Mo-jaOX6q2FnSQ-1
X-Mimecast-MFC-AGG-ID: YpqCMGX4Mo-jaOX6q2FnSQ_1769183009
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC4E41955D80;
	Fri, 23 Jan 2026 15:43:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.59])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAB6718004D8;
	Fri, 23 Jan 2026 15:43:26 +0000 (UTC)
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
Subject: [RFC PATCH 3/3] rtla/timerlat: Attach BPF program before tracers
Date: Fri, 23 Jan 2026 16:25:34 +0100
Message-ID: <20260123152534.1036533-4-tglozar@redhat.com>
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

If osnoise:timerlat_sample has instance count fields, attach the BPF program
before starting trace instances in BPF/mixed mode.

This ensures that what is seen by BPF sample collection is exactly what
is seen by the last enabled tracefs instance.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 069f916100e7..da2e2d003ec9 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -170,6 +170,21 @@ int timerlat_enable(struct osnoise_tool *tool)
 			return -1;
 	}
 
+	if (params->mode != TRACING_MODE_TRACEFS && params->has_instance_count_fields) {
+		/*
+		 * If the timerlat tracer has instance count fields, it is safe
+		 * to attach the BPF program before starting the trace instances.
+		 *
+		 * The BPF program will ignore any samples that arrive before
+		 * the trace instances are started.
+		 */
+		retval = timerlat_bpf_attach();
+		if (retval) {
+			err_msg("Error attaching BPF program\n");
+			return retval;
+		}
+	}
+
 	/*
 	 * Start the tracers here, after having set all instances.
 	 *
@@ -183,7 +198,15 @@ int timerlat_enable(struct osnoise_tool *tool)
 		trace_instance_start(&tool->aa->trace);
 	if (params->mode == TRACING_MODE_TRACEFS) {
 		trace_instance_start(&tool->trace);
-	} else {
+	} else if (!params->has_instance_count_fields) {
+		/*
+		 * Without instance count fields, play safe and attach the BPF program
+		 * after starting the trace instances.
+		 *
+		 * This might lead to samples being seen only by trace output and
+		 * auto analysis, but it is better than RTLA reporting results over
+		 * threshold that cannot be analyzed further.
+		 */
 		retval = timerlat_bpf_attach();
 		if (retval) {
 			err_msg("Error attaching BPF program\n");
-- 
2.52.0

