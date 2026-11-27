Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779792;
	b=i5ZYeXBmVZzOS9popCXqBXVWlXumpzWZj3mL9aGbkPmWNGMVDdisqrRFdESZdx8hvTpZ
	 L0EWi1hViiPGEjt6l3mAly8Gg1NQ6uXBv2PvarOnBplwMCsgotxRBAthrRrq2L8lKhnQC
	 rmgMWag4ZCCV2Rwp9F9r9cIZWGJIpA1K2qHHJNAF54ze+DExpTFIaTEO9W+W3u8v9mtAW
	 gSEFWFu8Ud+TjFoDdlCsFnumKhlkCIrsvAVNdBLI26rZpw0GN2+yltwwXxAhQAZLaftzW
	 WzWN9F37nePqDh8sKbPCHajY8wJvrDLXOZzy9G3LBa60gxEF1etG2kqWlaaDTSNa/JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779792;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=8wE3pr2Us7VMHrw2+oY4814SVfOgFE3t1to/YtX9de4=;
	b=qNDaCLnbkDzpsJrOLbkg1bmV6fZrx1Bmk05q+3JJw9Cx2IE30YuPYGLtK0kgDXvFI4++
	 RvU6rXv7AibsVbv7BjdHmsfz7auUrq2T1E6CP093jqmdjP/FimP3ok0ex/2x7cDCX2Jvh
	 jUa70gFNV2yZz7c2VEGTP/SCkeHgHm09hYl8xtGv1ZdvmusuyBnTi5Xz9OfYvGrya5NQe
	 IfxGWx/fBHjM0ntm0mgQv5wPy9qE8HLhkkERPbZnYQADFL9TDDu9yddlMqZM2BT3SLABR
	 Y6w/jIYKkDHV+1u2zMtHaB1faQ0LRdlBUh4vWVp4W8CR5UYluSF+19EMeDqPQFACwzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jJTbfbPe;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDFD606A31E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 11:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FDFD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jJTbfbPe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795779790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8wE3pr2Us7VMHrw2+oY4814SVfOgFE3t1to/YtX9de4=;
	b=jJTbfbPeo/8JhSZAa9+7EQfEAo0QJ55CabKzS/TYstWwgqYnZzMd6IRV3nTIJlY428ntVU
	vrjlOwkBuzvuWFEpiOh0oge3rL9zjQB616KMK7Zyy/l4AnrS0/8rUuMMqYeJfX7js2bCVf
	pL3dMW8LXaC/izzGpzW+lSq2XM8ID8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-K98YH8ekNVKmfDyQtlwLNw-1; Fri,
 27 Nov 2026 11:43:06 +0000
X-MC-Unique: K98YH8ekNVKmfDyQtlwLNw-1
X-Mimecast-MFC-AGG-ID: K98YH8ekNVKmfDyQtlwLNw_1795779785
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76CA41956068;
	Fri, 27 Nov 2026 11:43:05 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3917589;
	Fri, 27 Nov 2026 11:43:02 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 1/2] rtla/timerlat_top: Trigger actions with --aa-only in BPF mode
Date: Fri, 27 Nov 2026 12:32:18 +0100
Message-ID: <20261127113219.86220-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3wd8rEwGHqFKOoKiLBujxt3B5eAGwmRB_v-8Ax0uJYI_1795779785
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The implementation of timerlat_top_bpf_main_loop() for aa-only mode is
reduced to one call of timerlat_bpf_wait(), after which the function
returns. This does not allow for any actions to be performed, including
trace output and continuation of tracing.

Modify the implementation so that --aa-only uses the same code path as
--quiet, with the exception of not calling timerlat_top_bpf_pull_data(),
as rtla does not collect any aggregated data in that mode.

This fixes a discrepancy with regards the tool's behavior in tracefs
mode, where actions are handled by the shared top_main_loop() function.

The discrepancy appeared back when actions were moved to the main loop
to allow the implementation of --on-threshold continue; --aa-only was
not taken into consideration.

Fixes: 8d933d5c89e8 ("rtla/timerlat: Add continue action")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 2afd619c16059..f9221c71dd1ed 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -515,23 +515,25 @@ static int
 timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 {
 	const struct common_params *params = tool->params;
-	int retval, wait_retval;
+	int sleep_time, retval, wait_retval;
 
-	if (params->aa_only) {
-		/* Auto-analysis only, just wait for stop tracing */
-		timerlat_bpf_wait(-1);
-		return 0;
+	if (params->quiet || params->aa_only) {
+		/* There is no data to periodically refresh */
+		sleep_time = -1;
+	} else {
+		sleep_time = params->sleep_time;
 	}
 
 	/* Pull and display data in a loop */
 	while (!stop_tracing) {
-		wait_retval = timerlat_bpf_wait(params->quiet ? -1 :
-						params->sleep_time);
+		wait_retval = timerlat_bpf_wait(sleep_time);
 
-		retval = timerlat_top_bpf_pull_data(tool);
-		if (retval) {
-			err_msg("Error pulling BPF data\n");
-			return retval;
+		if (!params->aa_only) {
+			retval = timerlat_top_bpf_pull_data(tool);
+			if (retval) {
+				err_msg("Error pulling BPF data\n");
+				return retval;
+			}
 		}
 
 		if (!params->quiet)
-- 
2.56.1

