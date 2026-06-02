Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5FA396D25
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425821; cv=none; b=n0uTxw/Ii3m9UvIYDqth+jyfdvjxE4zj9NrG/O8sImev2+4AVMzRjCkYZf3ZA5VC1oH2zAgstfott1IKelzf2rxrE6xp29dAelfJKMBn3scTW7vsCRDXZrTy+Zg9EaFBfcP36xqL4UeNON0+/Xn+5c/O1iSSmEAylCpvP+Pn/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425821; c=relaxed/simple;
	bh=3Fd6TtJuprtvtCJX0pymaKKsP0+uLjIwmWNDxyTSYN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mr9NfOXazKlH0gyGx5y+mgqmmBHoCHQyEo1/MfzpzV9RVn6m9Spve+w0qe6D1sV9GCah9ZeeoHQKZkOQwjoWjxduDl2CM4bCCfPlB7d/P89JQMGiKl+la5w6tPtuOsTvT1oBGe7+Nge8TzLUkCmlGsWB/+le+OQjrLWzNkBC6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HQglv8AI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="HQglv8AI"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-915671abd29so222551985a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780425819; x=1781030619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6P9tEyW3kCCqm7OVGERZCcZB+h75VvrRt5VoI5vtrBM=;
        b=HQglv8AIh2QEGdoa28si0f0E/m4mYpHMzCpOTQs7U44cnh68xAVSfq2/j6lrBIlUqf
         YJU1Ke0Ir7leWokPxDAS1vIfLBvaSQbpjd0O7+qKRxfoglf7SrVHHtvwvrt0juXv1HGZ
         5qAvEO8rX69aH0LrQl5/NoWPLRJgC1AtVAjmm0sIFESqXbxBwzrB7nWccb1Y/Geiygjc
         BXzZLLFbIjR+7mqXrhQn5hzkJeIK83VGq1aBvBixRjdG2I+UBwcvP/hwHPb6vU9UG0gF
         bN06ZglKeLmkG3A3g0IHv+TeIQ/2iNeJxgyUttzh93TZ3ND225u1mcV7608CcpHWnZ2b
         IOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425819; x=1781030619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P9tEyW3kCCqm7OVGERZCcZB+h75VvrRt5VoI5vtrBM=;
        b=MKNlBi2aDc2mu10/PDuGOpApqIR2NrNqwbMtmGZkuP9zgvtgaVja7rUJ/EFMIslY4O
         tP0D2G/vq9m6EQrAxel9T7K+A4julzoUXWB7U23+sNUosxV3pyUubNLNw2ukhsJEAvNk
         hsQQAl3tCPfgpzsIXccrlJcK4oULUSjAFFOHK9qnVi899GUcvkyY2eUkj9AZCNUEnf29
         kpm68bDbpfhxYQwHPvz0LGweNXTuldBBkUrurmxuI24lDRk7J9Lon+FbqSFLYirzJsUk
         dp60lsLjMSMHJUcWPGEQWXd2BA8GulOlVRbjAMZPdbt5uwQZwXRUK4qOhC1wgwRydyr/
         /sPw==
X-Forwarded-Encrypted: i=1; AFNElJ/pRjpSMT//zqXyHzJmTGsgdVxtf1l+sm6uXMDX/PCVuv0lisLSUKqCrDidoJ0/xFT3nwkUqUQyWfTwuifn9NBlwlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+PnB6H4F8Fvp3T0h+nBc6LRCtx98lSB7UPSNsjHfADrfSQyl
	Ygx3rNGM48R1nmem1EhGo2JiR3LHuDCVAwWfaawPR34YvZaKikj4N54YMgi4kZWZ6/Y=
X-Gm-Gg: Acq92OHjKcqh2bwshzww0p71zjEk/qUCryv9ILVmH38qEO4XxCFxDblbYGtKdXhtozU
	GVN1TTUmnYOdE3ufgfW6m/IEAqsJmTiZKj7ugkNoiDb/adL35RZChV01NKxhXJk/wzFn6huG+O0
	kqqOK7Ixn31O3w0yErAxaUxy8tKLMpjRBdb3GwgookWXyYgaATcwW2k0nGkPT7KawKV3Me1g1W3
	ut0dEBg6mfB8HzccBQmhWY9zQYBkjSUG/P9xsvKZQvn4Kxb9+yrMAYmocDq56zBpPuaI1ngYd8W
	w/CjiBIehp7ZB/0/+FwPawWzCf7Mj8Qz84Q0H1Y5dbE7DoqLeCFX6uDzWgOzbjg/743cQKST9zc
	rEZYn3Q6CmexDm/IIv2/qvLN46wbvFsLAfD+ZYMPliLBdS/NfCcLzD+YwHHn8mUFDZtPohUm3+N
	t6kicXdO7gCVf/Pt7ze97ohV8MlaI6icBVgjL/hA==
X-Received: by 2002:a05:620a:2786:b0:913:7bc8:79b4 with SMTP id af79cd13be357-9158a81148bmr43320785a.51.1780425818854;
        Tue, 02 Jun 2026 11:43:38 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a00a4f4sm26247885a.3.2026.06.02.11.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 11:43:38 -0700 (PDT)
From: Sam Moelius <sam.moelius@trailofbits.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Reject tracefs buffer size values that overflow bytes
Date: Tue,  2 Jun 2026 18:43:34 +0000
Message-ID: <20260602184335.1554470-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Moelius <sam.moelius@trailofbits.com>

`tracing_entries_write()` accepts a `buffer_size_kb` value as
`unsigned long`, checks only for zero, then shifts left by 10. On
64-bit, writing `18014398509481984` KB wraps the byte count to zero
and the ring buffer resize path accepts it as a tiny buffer instead
of rejecting an impossible huge size.

The fix also adds the same pre-scale overflow check to
`buffer_subbuf_size_write()`.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..79da29c3d525 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5735,7 +5735,7 @@ tracing_entries_write(struct file *filp, const char __user *ubuf,
 		return ret;
 
 	/* must have at least 1 entry */
-	if (!val)
+	if (!val || val > ULONG_MAX >> 10)
 		return -EINVAL;
 
 	/* value is in KB */
@@ -8206,6 +8206,9 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	if (ret)
 		return ret;
 
+	if (!val || val > ULONG_MAX / 1024)
+		return -EINVAL;
+
 	val *= 1024; /* value passed in is in KB */
 
 	pages = DIV_ROUND_UP(val, PAGE_SIZE);
-- 
2.43.0

