Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10A335558
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405790; cv=none; b=KijuoMfeo3uzX5T40XjkoMMUvo+WcNjLvqNk2KjSMbE8n06vjnWxIggrwxUj1cYR7tY2RXdoFmfepLcTRxNI0gziaeCBb66vYnrtXNUi1HJouNwW3o8+vWHcLHfsxxr5tvacFQ/P1HCbJ4D/jupkWGWE6WGsFY3m9q+mWnV0BqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405790; c=relaxed/simple;
	bh=CTdSNQ9m4FPvDhaSyS7Md1HPseLc+GpMIEzjQiW7vDA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKwwWFCTcdf4a8iHcizTsIVJOLSKUzuk7HAFFmU1P9IfaaTBlip4l+OfogQqtlULKZ++rHeizrcfoDNsh3X8yUmQx0jfxLTnVVn3EMgMMW1MDTdNb/oVSDQHB3g56VkT7oXttB0N5YIXQcqjUdIjfJf6Es+agdmzc/GdZgBMBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0jBi3i8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0jBi3i8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCgxjdsl8Wp3jn7o2t/1VJkVLnufqkF/Oop+RfBQfkU=;
	b=K0jBi3i8W7/BTB7BR1aNylc8uCZv2XLtgBKvcvHRcODDvjpVzzgmU2p+gpXJu/0/4xOU7G
	7ndo6aYTWyvtLtuTaXSiLYcF46pGj5eSY3elO2XZ2mf6T0u1c+dXJHBVG8jzSDZxghbp4r
	sD04ZeZhk2buH66/adjTRn4Epg7NP/M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-dJDrf3cHMTaPgzt3K_eI9A-1; Mon,
 17 Nov 2025 13:56:23 -0500
X-MC-Unique: dJDrf3cHMTaPgzt3K_eI9A-1
X-Mimecast-MFC-AGG-ID: dJDrf3cHMTaPgzt3K_eI9A_1763405782
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13FB51956057;
	Mon, 17 Nov 2025 18:56:22 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9F45180087C;
	Mon, 17 Nov 2025 18:56:17 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 09/13] rtla: Exit if trace output action fails
Date: Mon, 17 Nov 2025 15:41:16 -0300
Message-ID: <20251117184409.42831-10-wander@redhat.com>
In-Reply-To: <20251117184409.42831-1-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The actions_add_trace_output() function can fail if it's unable to
allocate memory for a new action. Currently, the return value is not
checked, and the program continues to run, which can lead to
unexpected behavior.

Add a check to the return value of actions_add_trace_output() and
exit with a proper error message if it fails.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index f14fc56c5b4a5..39a14c4e07de8 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1070,8 +1070,10 @@ static struct common_params
 		}
 	}
 
-	if (trace_output)
-		actions_add_trace_output(&params->common.threshold_actions, trace_output);
+	if (trace_output && actions_add_trace_output(&params->common.threshold_actions, trace_output)) {
+		err_msg("Could not add a new trace output");
+		exit(EXIT_FAILURE);
+	}
 
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
-- 
2.51.1

