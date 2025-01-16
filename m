Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030422D4ED
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039007; cv=none; b=ro/ylg6RZ/WAIM5EVMyWUQRRe/ETojM0/fkuvJ7ESVmhb7Q3++lmt0vL7Cxdlm9WvgIEllxFoBoFHXkwPrNLdLQOmk9TXHEHF8gNmHBDP4MUF6X/59VU8Ragqef01hbyH4Y36b5CnNCx7L4Im5FcoaWiY0lJviPcnU6cyttxgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039007; c=relaxed/simple;
	bh=A/5D10Fllz96oPHpGvT/TuptR7u0MOT1Hwu39XGkH9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDTri1wYUT3DR7GocstL6EXCTmR8onVq9ePb1+FJAuYbpPcXze53GUMO/CZq1wq0XxvBp1mEF5VL2kJh7qnGvu6U0LsnvVleb7q54UJXQvH1A0o3V9JkTb5MuAWLfo7RMOrWRl1ysAX4aBn9sH1OuFxGXtybFAacTulBJ18D/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwNiD0I3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwNiD0I3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737039004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLbwaIE4YYMMLPUgRIKU+v4dj0toIq/Nz1ySdXkHNA0=;
	b=FwNiD0I3OCzy2tpRu9Vvo5Gclf6g31CmP8y5ck0D/9ENxZPJT1xNVDUqU/lFPdHcELtj3T
	hFiMcWOGfJibSvPlfuAAgcGB0nS82LLAGbeJwj5Kg+B87aVW1qzPENAbljlvy65zc4k3O7
	vIiHXH4Km8YsBC0s9VWeyk8s9AvzB/I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33--muiw-PoPlC8OACL3rH4bw-1; Thu,
 16 Jan 2025 09:50:03 -0500
X-MC-Unique: -muiw-PoPlC8OACL3rH4bw-1
X-Mimecast-MFC-AGG-ID: -muiw-PoPlC8OACL3rH4bw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DB7A1955DC0;
	Thu, 16 Jan 2025 14:50:02 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1595619560BF;
	Thu, 16 Jan 2025 14:49:59 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/5] rtla/timerlat_top: Stop timerlat tracer on signal
Date: Thu, 16 Jan 2025 15:49:29 +0100
Message-ID: <20250116144931.649593-4-tglozar@redhat.com>
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

Apply the changes from the previous patch also to timerlat-top.

Cc: stable@vger.kernel.org
Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 059b468981e4..d21a21053917 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -900,9 +900,12 @@ static struct osnoise_tool
 }
 
 static int stop_tracing;
+static struct trace_instance *top_inst = NULL;
 static void stop_top(int sig)
 {
 	stop_tracing = 1;
+	if (top_inst)
+		trace_instance_stop(top_inst);
 }
 
 /*
@@ -950,6 +953,13 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 	trace = &top->trace;
+	/*
+	* Save trace instance into global variable so that SIGINT can stop
+	* the timerlat tracer.
+	* Otherwise, rtla could loop indefinitely when overloaded.
+	*/
+	top_inst = trace;
+
 
 	retval = enable_timerlat(trace);
 	if (retval) {
@@ -1131,7 +1141,7 @@ int timerlat_top_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&top->trace, &record->trace)) {
+	if (trace_is_off(&top->trace, &record->trace) && !stop_tracing) {
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-- 
2.47.1

