Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0DD30E0FF;
	Fri, 21 Nov 2025 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763552; cv=none; b=EoiRgcBEhGa02Ki89aNm9ipkUZto7dNCf8CWRCDNCDYRiahT2wdJRXGPisWPEz4FmQzB996xc/kzmKs6XhvmowM+/nN5M9kleKNVJrotfWx1Y/eCmQzj94W6ltcg3Vl7wy8MvdyD0++gcbkvlLMfIdrzv7GH8dqZcmk4g2529rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763552; c=relaxed/simple;
	bh=uIQG/Ehc1GKLAtZHhN9V923q2z85E2IwNQ/sAwm78z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4350TjODw08EbLuJNPHS1YT/8e5DyR6OWsWqut1Hz+cb+sY2MuAAeVMS5GgFw9NGjHu2SMowHpS+RPgQkxrTlB9e9BLG5DpmQ/cGhWeAeHkna2bseLfY1cUwUWkhIYk7nvAtOgS5UIOCvtHaP+Hvw+I5UDcWrogL0VY+h6apeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jf80N6rF; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jf80N6rF; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jf80N6rF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jf80N6rF"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCqPm3FDSz9t2Y;
	Fri, 21 Nov 2025 23:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov3nvKGbl2Q+3IXaCFZdE8YvEhitXvk3SDLQhUDSk+M=;
	b=jf80N6rFd4kv0H6N7uiKIq6sZqiVsB/r9MmFP9BZL84DQXGICEgLb7/QfRGomrzt886G+O
	1WFeSV3hrKCMJ9JZEk2iWbOT5A9CsX2pp2retr2/iud4QAEx5brmzxpHHLg+9B59nXhjK4
	SfkhNqmwDf9BLEIkV/Hr+7kbfd2PvAkSPGOkWjG8MGxhEA4SJPfWxTrmTE4VC6NX7eDTJn
	xHLLXgdZR3GNtwDCUC31VduqosibRPPwpruCpmoouQe+zXhfWaNzS1tlHOTsCKKBgkKiwN
	u1nts+UI08JqwFXnY1uuOplf30voiMTAajGiLLmGgm4YEl4Ymt9S4uq6E2FFMg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jf80N6rF;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov3nvKGbl2Q+3IXaCFZdE8YvEhitXvk3SDLQhUDSk+M=;
	b=jf80N6rFd4kv0H6N7uiKIq6sZqiVsB/r9MmFP9BZL84DQXGICEgLb7/QfRGomrzt886G+O
	1WFeSV3hrKCMJ9JZEk2iWbOT5A9CsX2pp2retr2/iud4QAEx5brmzxpHHLg+9B59nXhjK4
	SfkhNqmwDf9BLEIkV/Hr+7kbfd2PvAkSPGOkWjG8MGxhEA4SJPfWxTrmTE4VC6NX7eDTJn
	xHLLXgdZR3GNtwDCUC31VduqosibRPPwpruCpmoouQe+zXhfWaNzS1tlHOTsCKKBgkKiwN
	u1nts+UI08JqwFXnY1uuOplf30voiMTAajGiLLmGgm4YEl4Ymt9S4uq6E2FFMg==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 07/13] tracing: Fix typo in trace_events_filter.c
Date: Fri, 21 Nov 2025 23:18:29 +0100
Message-ID: <20251121221835.28032-9-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: up6eh7fp9cujw9wgexwizd8gpt9y5qo7
X-MBO-RS-ID: 368aab9440959de9dea
X-Rspamd-Queue-Id: 4dCqPm3FDSz9t2Y

Fix typo "singe" to "single".

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 54226b48b2d1..385af8405392 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -142,7 +142,7 @@ static bool is_not(const char *str)
 }
 
 /**
- * struct prog_entry - a singe entry in the filter program
+ * struct prog_entry - a single entry in the filter program
  * @target:	     Index to jump to on a branch (actually one minus the index)
  * @when_to_branch:  The value of the result of the predicate to do a branch
  * @pred:	     The predicate to execute.
-- 
2.50.1

