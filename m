Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D113D8B1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951866; cv=none; b=aRgkKkX4HecUrhv8FpUUeRZCQfGQx/P/RfEYNJTn17Omv8nECWljWwZn+gUggKCA6YfpDTWQg344hHf5uSUpkFF8HnNanbI/VWBbbGXhZtu1m6EK2Ds0YgD6r5BQrcoBlvAJXLqINk6TQux0p8gO9yHUix9RbxBZgO++oelUMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951866; c=relaxed/simple;
	bh=+GT4GEimZN6BsXH0kV+jWdh++F8o7fRLAVmYJM+PxW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ftfhx7/LZW6t24uHNo6NvNkyjqpZdpsH4a/K+mT1QazSoFSWoOs6BlFtIoLFp5l0609S/ipHPPh3Ho4WShiIF43QD5QAQyxhr4YbFW/bEX2BoieQt3JnbLz30QIuY/dCw+bCRJb5B8EbyNxM0FM8kfkg/O8NlLdPrbve9tnu/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrP1NX8U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrP1NX8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783951864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LiKxkmmrwlHgOmnYzkquHoAVOmvSL6iPKoX+bXiuwgA=;
	b=YrP1NX8UQWtxxOFrV07AYjzocerf3MnOY4ZckNOaRDD+59812FjRNenhty6R7yMTcjtY7Z
	FqzxPeirbpH8VhRwOLnTDbH4sq0cJz9cw9FzA/MM0ulsM0oaXLNNgTWaGlP5SumCWQ5zZq
	tMGpiU/ROvanYQXIxQDEhWB6Lp9v62Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-qOePKv5WMuWu5uveJ_EUSA-1; Mon,
 13 Jul 2026 10:11:00 -0400
X-MC-Unique: qOePKv5WMuWu5uveJ_EUSA-1
X-Mimecast-MFC-AGG-ID: qOePKv5WMuWu5uveJ_EUSA_1783951859
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE76A18052F9;
	Mon, 13 Jul 2026 14:10:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C45A3000B4C;
	Mon, 13 Jul 2026 14:10:55 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Attila Fazekas <afazekas@redhat.com>
Subject: [PATCH] rtla/timerlat_top: Fix on-threshold actions firing on signal
Date: Mon, 13 Jul 2026 16:10:47 +0200
Message-ID: <20260713141047.687877-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: v6iwYijMira-9IvCmQo2FGtZINzZC7GaPgkiZCucpHM_1783951859
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A bug was reported when rtla-timerlat-top tool performs on-threshold
actions, even though no threshold was hit. This is reproduced even if no
threshold is set at all:

$ rtla timerlat top -q -c 0 --on-threshold shell,command='echo BAD'
BAD
                                     Timer Latency
...

The bug is due to incorrect logic in timerlat_top_bpf_main_loop().
The loop uses timerlat_bpf_wait(), the return values of which are:

- > 0 (number of ringbuffer entries): at least 1 CPU hit threshold
- = 0: time out
- < 0: wait was interrupted by a signal

Commit 3138df6f0cd0 ("rtla/timerlat: Exit top main loop on any non-zero
wait_retval") changed the condition for "threshold hit" from
"wait_reval == 1" (exactly 1 CPU hit threshold) to "wait_retval != 0",
to fix a race where multiple CPUs hit the threshold at the same time.

That also made it incorrectly include a signal (< 0), coming from either
duration expired (SIGALRM) or user interrupt (SIGINT).

Check for wait_retval greater than zero in the if condition to cover all
return values correctly.

Fixes: 3138df6f0cd0 ("rtla/timerlat: Exit top main loop on any non-zero wait_retval")
Reported-by: Attila Fazekas <afazekas@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 18e1071a2e242..6206a0a565ad3 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -536,7 +536,7 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 		if (!params->quiet)
 			timerlat_print_stats(tool);
 
-		if (wait_retval != 0) {
+		if (wait_retval > 0) {
 			/* Stopping requested by tracer */
 			retval = common_threshold_handler(tool);
 			if (retval)
-- 
2.55.0

