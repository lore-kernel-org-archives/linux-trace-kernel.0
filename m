Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5F309F0A;
	Fri, 21 Nov 2025 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763544; cv=none; b=YlkqktCmQdXkDm6B7Vt15LBD7OxziS+iExofDsS1AnqMZszvVIBllvyS+Qk92WeZPG0bhaODHZsGN4F/i8mgJFGxOMJRmGkyqrxT6QIMr3gj2djHGvm1TrQZEhcRx6wh7XK4BRVCkhIIfn+o32FePFENUtJo/puvj6+aEUEyzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763544; c=relaxed/simple;
	bh=3lPrxsYvi8hDlT8Rvf+vKBUOexahSXA/FCYalfMYfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSNi2+j8k4bMkg0go4a8gwJlvCKgYhcO2q+E2pnDIeiNbKcJEVAcEpaByMSUArzxj8Cr66TK6M4yHHtaIVYFDOFOIKphU7bmW+jgOtgdCz49EXpUoHiZa1uLa72CCrBqSuc56xF07EHis6ylXmS27EZ1rbQqsXjPiHDcvfhMoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KhYLL1gt; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KhYLL1gt; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KhYLL1gt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KhYLL1gt"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCqPd1L1vz9spH;
	Fri, 21 Nov 2025 23:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zGAYRRmUYNmgH1Xm0Ujcn6n5DD8G2qfVCpUGXhBd5w=;
	b=KhYLL1gtgJQDLZk5fa+ORR9fLCxZNoVBlwInOBFA9VVJzPEuK1CKy2q0AZsZMgHqP7MKVc
	3YJqriwj0BYsaYZChGn/NxlcJYLC7QliioAt9lff6K0Uv2/9XUoADEKAci3oZ8/SUj8CIR
	40OxSJkkhcbN3g2Cg5486mUiFzYBKRysVn1pO8OpW/xWrMurqJyNOcXdU13u8QxkFdMI1R
	0p+MQPddsON+yrMuzrSpAcnoTWb9HJBVpu3dD/aJf9uNubF+SuyAzhfgI7mEn8bhBDwXR2
	qhV8quWaMpc4zATo7hfgWjZ3l3m6IeRwneh4jO1Kxvlmj4rG2h/kesmV3Udeyw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zGAYRRmUYNmgH1Xm0Ujcn6n5DD8G2qfVCpUGXhBd5w=;
	b=KhYLL1gtgJQDLZk5fa+ORR9fLCxZNoVBlwInOBFA9VVJzPEuK1CKy2q0AZsZMgHqP7MKVc
	3YJqriwj0BYsaYZChGn/NxlcJYLC7QliioAt9lff6K0Uv2/9XUoADEKAci3oZ8/SUj8CIR
	40OxSJkkhcbN3g2Cg5486mUiFzYBKRysVn1pO8OpW/xWrMurqJyNOcXdU13u8QxkFdMI1R
	0p+MQPddsON+yrMuzrSpAcnoTWb9HJBVpu3dD/aJf9uNubF+SuyAzhfgI7mEn8bhBDwXR2
	qhV8quWaMpc4zATo7hfgWjZ3l3m6IeRwneh4jO1Kxvlmj4rG2h/kesmV3Udeyw==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 01/13] tracing: Fix typo in fpgraph.c
Date: Fri, 21 Nov 2025 23:18:23 +0100
Message-ID: <20251121221835.28032-3-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ae32dd121c6a0dc6b99
X-MBO-RS-META: kduzs9tmm63fmrndkdwoprfn8m5d7o4u

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

