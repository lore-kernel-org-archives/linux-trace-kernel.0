Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D845480350
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853618; cv=none; b=ftXTMxmrt/OWFvbVAgBddOvrPPj5skVpNIO7zdfrXnaivI/cVet4zeDnS1o5FlfKj7/fStHQQccOCNkZjHLW34iPn7YD7nMHnVhvAtRfLHFj1XEk7ZYA6+1I/O0uDJS5yD+7vVOLVthdyGMkpuxOZr7k1HMPWwWNdL+Qd4ZMBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853618; c=relaxed/simple;
	bh=yBlqorQ3jiHJ8vcOYJ6h8nz+PEhyCyHs983dx044N+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KE3fG9FtdYELqELgf8phHRWOLmM5ikd91gCXYAeWygI7ROwYYHkuEdRb7xMuvIdK64gyeJlRTCoBF7uOtx0rmGTJk8WgaQKAyUGkJPvsbVa4OH8StcoUUYc+dH4MzuFXuoAIMEhkwyLtlg9WbieqPIBNEIRjZ4kf0oa5HY3WZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=qoz8hZnA; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="qoz8hZnA"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-514ae601e01so61329521cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853610; x=1779458410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5b7MFuPFCa9drfejPWp8MN12KDx0vpagcMC8lqxli0=;
        b=qoz8hZnA+ib6rz/lA0rxjQm4g7y3BCc0kpsC1nJJ+tYIf2kvTfT0CLRH25iQ5s3+DL
         QObg6yWa1eYmFStmGL2B74ehliXQxv9Nbqt+a9uzfHscj66up0myPT4TZxAs+NRnDPzm
         pOZC9rzVotaW3WleP4yqT1J/FjyeXototKQmVfBEZm0uF1KuJHKuytDdvHFaKbzVX/og
         eUN0EIrSPomA6uNp1y5ViRpHgtj2j8RYuLqYOoJYRi8oBCveFmLtRUWV9c/axu5tQS8F
         lVggsC+a6B1siGYNm4yhKY3PTdeERPFcrLGYIwJtMjNqxOfybc9bEwC7UQFVJliOV18b
         2bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853610; x=1779458410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5b7MFuPFCa9drfejPWp8MN12KDx0vpagcMC8lqxli0=;
        b=ADXm05N81+VtBhD6YRScMRlwN1C34pYeOMj3TLko0WD1/7Pnao+MZIwu+HOeuh8s4A
         fhSD7fl8TdniKwrc1G0MDR5wcK4OPXZY0+KiA//HMlKatQh/6e6qR4T3/nujwiIjiM3L
         1zTSQOZCVg3NiXFhGMpFznykonmfEcrw9P2ENclxh5fh+aqUWzuUyCm0tvm7VbUh4bTb
         G02SBhu2JoMH3DjHfQKnVcgK/8Si1j8q+uJZkYV1hMxWz2NFa4Zw6TR19DYj1yhjIO5o
         P1MXJLw8TFgtZKqCgpZRsZEPV7ZEFs6l0H5dxA95o6MQyzKY/w6yK1VJGgg9hkwsoE+T
         gWkw==
X-Forwarded-Encrypted: i=1; AFNElJ+q+/qN51ku6qRwnn4hvoIbT8AfZqxYeN+kgv0NgDWN+ZI9qApLnFWlGJIrfHmcxmmWtn9u+OYvh223YpR/Il3Owx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dEeLVTcLtuadgA5lkvqQM6w4VvPiOvdNEKvHMh++4SXV93av
	v/Vfol9Hg0pcnshLxsfWRbbDtAufnqUx+dN1TLMfhxhyOkVyy4wQCPYX5P1YH4zA5zo=
X-Gm-Gg: Acq92OH5t2Ez20pjRCTCka/jvn6C0aMvv1nSWdhpjh/+c3wAFsSRJcO9GjDwyrel5mX
	Wx4NnWumkqgMcyz3qSxb3D0NoRCPOitPmGfvwzmHX6mj3RGAnqtq+ql3z9rH+055foN7omkeydR
	+XFbfHIL+qV5u4Wylaop8oITup0lI1ARzuCR8WTQRQeAU3NswVl8t5KUKXKIaatSz2hjAG5fUQC
	97Cs+BocQ0gTdcSUT6Yh+uk/dsn9EWjZ4CaqNf1m8TVFjY2ny8rqqi0H2LuARGXhUsgXlzATezP
	Mp70kCtZE4t4WCIQdkHOklnKqB60Lserp7UxIkNtmB0ZND+6sTpISvbKz2Y1uUqZg+X4pNL415J
	bZxF9NfIobN01FgidRP0734L04x7UTzJWALRwwKwLe60W0VaazN07uhSZl9K10A6wNjua/YcrmL
	oVLOzOgc7k4GuiIwBu6fJLwrohjMzJLEof0y9zQMw=
X-Received: by 2002:ac8:58cb:0:b0:50f:ba60:2de7 with SMTP id d75a77b69052e-5165a0cf3ffmr53506661cf.38.1778853609086;
        Fri, 15 May 2026 07:00:09 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c9092ea630sm52559676d6.20.2026.05.15.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:00:08 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 11/11] x86: msr: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 10:00:04 -0400
Message-ID: <20260515140004.2238951-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 arch/x86/lib/msr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index dfdd1da89f36..14785fe5e07b 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -125,21 +125,21 @@ EXPORT_SYMBOL_FOR_KVM(msr_clear_bit);
 #ifdef CONFIG_TRACEPOINTS
 void do_trace_write_msr(u32 msr, u64 val, int failed)
 {
-	trace_write_msr(msr, val, failed);
+	trace_call__write_msr(msr, val, failed);
 }
 EXPORT_SYMBOL(do_trace_write_msr);
 EXPORT_TRACEPOINT_SYMBOL(write_msr);
 
 void do_trace_read_msr(u32 msr, u64 val, int failed)
 {
-	trace_read_msr(msr, val, failed);
+	trace_call__read_msr(msr, val, failed);
 }
 EXPORT_SYMBOL(do_trace_read_msr);
 EXPORT_TRACEPOINT_SYMBOL(read_msr);
 
 void do_trace_rdpmc(u32 msr, u64 val, int failed)
 {
-	trace_rdpmc(msr, val, failed);
+	trace_call__rdpmc(msr, val, failed);
 }
 EXPORT_SYMBOL(do_trace_rdpmc);
 EXPORT_TRACEPOINT_SYMBOL(rdpmc);
-- 
2.54.0

