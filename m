Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581231328E;
	Fri, 21 Nov 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763558; cv=none; b=OchLsn1Nyh9jgTgfIxwtBcFQNrestW/sWXqHgnUHKyuV9wgnV3oCO9HyYwRNoMm3lR8c8/+NhKpQR1zBbgUAWGBfESK6aIKBG7BtEkjVu25YEUPKqT2zvCWdV+7Xv+CgAaEL5/SdPH1k1OdxcUxHlW54kgHNzUWsUbi01+f2nJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763558; c=relaxed/simple;
	bh=HdUVlrLNeEDJdadqr/6LMnh25jzkjxuE1j8bPRdrxB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnvP/C4mGAPm3xlRdrBUNBL3aCOPTbKp+bMiwTk2aoowjoyLGx4s9YBFj10BpnGnTq0kY7lDmC45oOudlDc2k5koIvJ5PaDpgYQthnpvH125R8OKExVF675dqAXEiaPacIjNkUUrXe+quy9YhWNPUGPSjNvWPmhqHDCbEOtQQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vKnWR/53; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vKnWR/53; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vKnWR/53";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vKnWR/53"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dCqPn5RCKz9tr1;
	Fri, 21 Nov 2025 23:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+7mh/16giWAr/RRXrYzTxXSInVenEayEZwybrpSuQc=;
	b=vKnWR/53GL31zXBvPzXO+CuJjAd99taFDJ1nN7iIFCTUY9+Lv6HkPqmNz1+9ICFg1p5wY/
	+hVtQzCsseRW5QoYObwY/47EiLcX0idoG9HQqqGb8q47+e4CeF9e0ySm1EJAQ5TpNcdGeM
	QNPeLE69RcyJq7sG16dnwhaEHK9+4EvWI5bubLw9bUTBM7xfrvY8yLEtCHw5o2RUjlE4W2
	YTE+TmEzVjtFqGKFatTkKlZW14xAev2MteTn5fXYY5OrKwpPUqonPzGgk0fxiuDkvw6+qy
	5gPB5hOl/6yO6EPds9cqlsaJpaAFu0Q8WJ00myk8R4Nyockx98RciPQtfCxuBw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+7mh/16giWAr/RRXrYzTxXSInVenEayEZwybrpSuQc=;
	b=vKnWR/53GL31zXBvPzXO+CuJjAd99taFDJ1nN7iIFCTUY9+Lv6HkPqmNz1+9ICFg1p5wY/
	+hVtQzCsseRW5QoYObwY/47EiLcX0idoG9HQqqGb8q47+e4CeF9e0ySm1EJAQ5TpNcdGeM
	QNPeLE69RcyJq7sG16dnwhaEHK9+4EvWI5bubLw9bUTBM7xfrvY8yLEtCHw5o2RUjlE4W2
	YTE+TmEzVjtFqGKFatTkKlZW14xAev2MteTn5fXYY5OrKwpPUqonPzGgk0fxiuDkvw6+qy
	5gPB5hOl/6yO6EPds9cqlsaJpaAFu0Q8WJ00myk8R4Nyockx98RciPQtfCxuBw==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 08/13] tracing: Fix typo in trace_events_hist.c
Date: Fri, 21 Nov 2025 23:18:30 +0100
Message-ID: <20251121221835.28032-10-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 79y4wbugci1r7d9xtsrxugebcjbwsyj3
X-MBO-RS-ID: b7b4601ba97fa69d0ea

Fix typo "tigger" to "trigger".

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6bfaf1210dd2..1b6b9c789da1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5283,7 +5283,7 @@ hist_trigger_actions(struct hist_trigger_data *hist_data,
  * on the stack, so when the histogram trigger is initialized
  * a percpu array of 4 hist_pad structures is allocated.
  * This will cover every context from normal, softirq, irq and NMI
- * in the very unlikely event that a tigger happens at each of
+ * in the very unlikely event that a trigger happens at each of
  * these contexts and interrupts a currently active trigger.
  */
 struct hist_pad {
-- 
2.50.1

