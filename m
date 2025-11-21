Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D830C607;
	Fri, 21 Nov 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763549; cv=none; b=dt7JKz/g2IMolemovYYykRO0rE1Mrr1VTZqFcTjsQKV9Opwm2b1WVG5RZPHZeRi9JnToEaEkghFikXecMxIWk3yZ9D9oO+dfX7iwNK7NB+OY/NXInh2vRyKY3UmIQiSM8y9Obe3DH362n1P3ytPpKGVFQLQHK10V9nJw9uo79JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763549; c=relaxed/simple;
	bh=3lPrxsYvi8hDlT8Rvf+vKBUOexahSXA/FCYalfMYfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejobqeXsOhIVNL5BQN5/b/fyAHoLasUF2BwDrJiJBQNisHw4qUfU4W9vfdewAkAVCT95uQ+PzGs7n8gfAJM2EhzfwVgwGtYH3zhx+HEfB+cDBB1sqpPHe7uzHnUBJzWuY3JMzAPj3dVEtJhUOQEggI9BMdHBfXs5+gSF3U7/728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YhtrsZ0z; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iadvvAlX; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YhtrsZ0z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iadvvAlX"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dCqPc07Jfz9sxG;
	Fri, 21 Nov 2025 23:19:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zGAYRRmUYNmgH1Xm0Ujcn6n5DD8G2qfVCpUGXhBd5w=;
	b=YhtrsZ0z2AcTJBL4cSsElqVAenc1mgSk/vQfDPDGHKu6ID8159EvFPNhfdDibuX0oWWNSD
	mP5znOm8ia2sVPBrCMB0rgBBU7SnvkfMBB4l8Y8YDq1GxEzyjMrf2tATrUKQ8KCdyWiVe7
	g4N542P3b/vJifg1FpekZ1OoFXQtIVk1rZj0nclOwvrtAeMmhfbZXt77eeB5rebmsZGohQ
	aTQZIul85IxHsKysVMpULNM37+5Oe3hSYvt8KDnvHRj0IiJTgZwyLL1V7uOERpD6kdsIs0
	Cr17oHcWcP/TzJvZQFf44CCFCqXol3sXFyUt5M1ozElv9Z3RkiAog4gDervGdw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zGAYRRmUYNmgH1Xm0Ujcn6n5DD8G2qfVCpUGXhBd5w=;
	b=iadvvAlXHu1PCCuWfUR1Ij3igNCLSp37xKcuD69tHapRHDCmmnzOkagR5bLc1ybRsyHjcq
	scOYHWHxDuSlh8zKL4KoAB1kIqAkLvfsIXrCkGbJhMCwU/tR+Vj5Zux+5kIAv7h5HxcgAe
	UrBaiNQC6m5UcCBmAWIXnhfE5eQWC91NH5NajAYkD1lY4I77PS1SYPINAm6W4VCOjThRJA
	HEIf1nKtLL0ZQKuOJAS/lT34PwwrXoybAQ2TTFRTrRj8PA+XLfHgcsiioNC+qGGhjFxpuA
	BexOJpGgx7GC3SyJHJ3rtcswcwthdpwTSvDurlAYoqQ0RcPjqWULJhodRPKvvg==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 01/13] tracing: Fix typo in fgraph.c
Date: Fri, 21 Nov 2025 23:18:22 +0100
Message-ID: <20251121221835.28032-2-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a41uzdhpuatrnfgmbg5uoo5rk77bmdec
X-MBO-RS-ID: ab66012213a4a6abe81

Fix typo "reservered" to "reserved".

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 7fb9b169d6d4..8ba62fe986f1 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -163,7 +163,7 @@ enum {
 #define RET_STACK(t, offset) ((struct ftrace_ret_stack *)(&(t)->ret_stack[offset]))
 
 /*
- * Each fgraph_ops has a reservered unsigned long at the end (top) of the
+ * Each fgraph_ops has a reserved unsigned long at the end (top) of the
  * ret_stack to store task specific state.
  */
 #define SHADOW_STACK_TASK_VARS(ret_stack) \
-- 
2.50.1

