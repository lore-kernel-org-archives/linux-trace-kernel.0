Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FF30C37A;
	Fri, 21 Nov 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763549; cv=none; b=eCEsbX5VsMwevqwkKRlFkKqlRMRpMOP4+PmvhD816543z+HSNMq121jmmtmEBN8Rl2qB0fVUEYBkqzxBJVnBc1cE6pECFXNbwAYiojFBO3p4NEOH4xugFQ2CKPRQx/1i9NIVakcd00uLFu7ttlFhomODRi90a66XixdMGwYC76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763549; c=relaxed/simple;
	bh=VCJAuBwEz7gTNUQe92zcUFIKkRCa1kI+wt06kkT0c7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoyL2IwY2bWeiTCeinEvF8RiZ1u2solZ/RA3LUrEeU1Iv6v4bJb9y8x+MrwKV5hEmUCp2FVgU5jZmr8iO7+0mZ5dghCieRo5g/hDqEkixdBaBM/OlgIM4EBesix7CI4BZRQXpUPh72jkQST/V5W+1h2HFAuM8+tOzGsrqpOTmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WsT5/C5c; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WsT5/C5c; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WsT5/C5c";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WsT5/C5c"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dCqPh6Pl9z9tm5;
	Fri, 21 Nov 2025 23:19:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRWBcF7rla5qMSzAG+4qAsZI2bSHYVZEn5ZYKzuLm1k=;
	b=WsT5/C5cuZA+sMtI3EYz5yGe76TZwcIcndWm1EMARYDS08MQjAY+9h/Wq3ePnKg3rZliUO
	Sc7L5b4WptG5m+5/dMrzboIzhkvEEO57hi3FnyJUF02x994tqGU9JZmpXO74Mr0RecG5TS
	XcvNZFWFxTjM0xiaLOWuIybhxJPDo6Nyj4lWU8AsAJc47d3+sy1ysHo0UmZ01V4k3AwMHw
	DlApnU4qPIisi/rlQp1hpICfI9wcFRcNyPJWLeENLYRz6FoLe6Xa7P/mAELrPM6ymR4XIa
	DCxZXR7VM06aMPgZ5d1f0k4cquWvrcyMbCsop7giDKS2RE9bu89xtSPzZmnA+A==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRWBcF7rla5qMSzAG+4qAsZI2bSHYVZEn5ZYKzuLm1k=;
	b=WsT5/C5cuZA+sMtI3EYz5yGe76TZwcIcndWm1EMARYDS08MQjAY+9h/Wq3ePnKg3rZliUO
	Sc7L5b4WptG5m+5/dMrzboIzhkvEEO57hi3FnyJUF02x994tqGU9JZmpXO74Mr0RecG5TS
	XcvNZFWFxTjM0xiaLOWuIybhxJPDo6Nyj4lWU8AsAJc47d3+sy1ysHo0UmZ01V4k3AwMHw
	DlApnU4qPIisi/rlQp1hpICfI9wcFRcNyPJWLeENLYRz6FoLe6Xa7P/mAELrPM6ymR4XIa
	DCxZXR7VM06aMPgZ5d1f0k4cquWvrcyMbCsop7giDKS2RE9bu89xtSPzZmnA+A==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 04/13] tracing: Fix typo in ring_buffer_benchmark.c
Date: Fri, 21 Nov 2025 23:18:26 +0100
Message-ID: <20251121221835.28032-6-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6cf2b62d2bbff699263
X-MBO-RS-META: q8fkdh53ny5sdz6pfeisgy71ag3ti5yy

Fix typo "overwite" to "overwrite".

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/ring_buffer_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index cdc3aea12c93..593e3b59e42e 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -433,7 +433,7 @@ static int __init ring_buffer_benchmark_init(void)
 {
 	int ret;
 
-	/* make a one meg buffer in overwite mode */
+	/* make a one meg buffer in overwrite mode */
 	buffer = ring_buffer_alloc(1000000, RB_FL_OVERWRITE);
 	if (!buffer)
 		return -ENOMEM;
-- 
2.50.1

