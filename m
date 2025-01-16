Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336922D4E2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039006; cv=none; b=TJeQKnnglUsFUWXmuZwwofWm1Vk735l/AqA03Gn5U+tyRCrw90ySeZHVVZ8B76leqN4vNd9keZ68Nw887g3w9XK8WsaYoZ5TN1UrWBR3Y6DK5tEIzA+vfvryVawwcwN0oQIsT0CEReC3dood1yTMdxVEqPr3NOoD24qx9iC6vjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039006; c=relaxed/simple;
	bh=wf0Yzqz5ici9UpjGB9ZFAGQJNcWiDwzF7KV5jzve4Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnEsgUPEWy5YXmxjvzIkRNeu6FgU84ZtDKZr+RGKtbyhFOnFoGx6r1mFUBDWQCW7J3QUrkNRe7tR06aT2UDELBPp+54gflaPC7FIHpqVm+gFulPJo9QY+ZxuOAZ6dApi6+pAbhi4q+r/AvY9BA2p2bHACH58FljWFsuDYSrNU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=An/eOyIB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="An/eOyIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737039003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pZRM52y0zcwLVV6w0FfhCCVSvfl6V2hE3PVHsUhNsA=;
	b=An/eOyIBWxifN6MLGT1zqpMPw7tJ16oTK4cdAZPsuFUNCJFcSfEKAyEK6GGBpa7PpkSvIZ
	PR9R/kUUuDfztXXmikqWXIF0NKmm8A4KXyK5RHHdMjeO4XmaDGMHGFLs2P2CF5GZWf3BFi
	xm4UvK7TSoXCgl/lv+28mG7nj4yS7Kg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-G3CsaHnJOTCjhEi5RzH4UQ-1; Thu,
 16 Jan 2025 09:50:02 -0500
X-MC-Unique: G3CsaHnJOTCjhEi5RzH4UQ-1
X-Mimecast-MFC-AGG-ID: G3CsaHnJOTCjhEi5RzH4UQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 962DD195605E;
	Thu, 16 Jan 2025 14:49:59 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9111C195605F;
	Thu, 16 Jan 2025 14:49:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/5] rtla/timerlat_hist: Stop timerlat tracer on signal
Date: Thu, 16 Jan 2025 15:49:28 +0100
Message-ID: <20250116144931.649593-3-tglozar@redhat.com>
In-Reply-To: <20250116144931.649593-1-tglozar@redhat.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Currently, when either SIGINT from the user or SIGALRM from the duration
timer is caught by rtla-timerlat, stop_tracing is set to break out of
the main loop. This is not sufficient for cases where the timerlat
tracer is producing more data than rtla can consume, since in that case,
rtla is looping indefinitely inside tracefs_iterate_raw_events, never
reaches the check of stop_tracing and hangs.

In addition to setting stop_tracing, also stop the timerlat tracer on
received signal (SIGINT or SIGALRM). This will stop new samples so that
the existing samples may be processed and tracefs_iterate_raw_events
eventually exits.

Cc: stable@vger.kernel.org
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4403cc4eba30..e8d249e22251 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1146,9 +1146,12 @@ static struct osnoise_tool
 }
 
 static int stop_tracing;
+static struct trace_instance *hist_inst = NULL;
 static void stop_hist(int sig)
 {
 	stop_tracing = 1;
+	if (hist_inst)
+		trace_instance_stop(hist_inst);
 }
 
 /*
@@ -1195,6 +1198,12 @@ int timerlat_hist_main(int argc, char *argv[])
 	}
 
 	trace = &tool->trace;
+	/*
+	 * Save trace instance into global variable so that SIGINT can stop
+	 * the timerlat tracer.
+	 * Otherwise, rtla could loop indefinitely when overloaded.
+	 */
+	hist_inst = trace;
 
 	retval = enable_timerlat(trace);
 	if (retval) {
@@ -1363,7 +1372,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (trace_is_off(&tool->trace, &record->trace) && !stop_tracing) {
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-- 
2.47.1

