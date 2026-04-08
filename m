Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279663914F0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679848; cv=none; b=BFigVNhYryeXu8usuGDzf886zuP3o0kV2/m3Znqm1nqTryUNXbHX647JocsiX9UZ8tEx/it4N86Dc8Wg+2hhVFUauRJ2Ow9AQ8MPp+/NTDM1wzVVFnK3r7vvwngiQdFvWHpN186amLA++fZrBpZqrOSYuYA1xkDzCy996pgQjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679848; c=relaxed/simple;
	bh=M/LjiKecfzVTG8HRl4m3JA7iq2zgvUsjbNQ4AnBHvSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YssnG8BkI++5kfVaoTn4pGp3y8QT4VwDp6sV1ih4M6ATZt0piwUE2ihJRZ0O7nznL70WV40jMpFp6aVIk4nY4m+NtTNYyXRa7s4mVThf98zRPtwHQfcEbCCiSoEiAm6rBPXiBH8nlIRxZjZoH0I9F28qalX6QlOzV74HZVOpHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flbmwE/K; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flbmwE/K"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so195625a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679846; x=1776284646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UthiWrjG1Hwt/0nbiWEQ1KZeqkoIURhsJh3Eb3JdJ/8=;
        b=flbmwE/Kaz/ysnc/p7I3LFzNeBn0PhsXsyUeICI3DU2yymftWFnoMS54OlI/gh3kZq
         1nPTRmysaQh9e2NhImBXEDN31GXW/o83HpUwoGLm9feJjcrupoECWC6nnQfMGhKjRNE7
         We7X9uC2sdUjPZ+6UaRzJgyA8RjGC255wjqau1LB0q3rFqlg7vqUpMp98Q6XRC/um4Il
         bZHr6ia1SmLTDY9Go/69nRXnkStv3L+KzmB4lO/YPJ/FS8H42ZpFL4Vqe4I1FHWnv9la
         twUCJxE/bQW7CpPf0vpoaI0c9tUMJONVdV4rPUJ8BHGdONVZ6Z24LeWLgeQGpbAcMH4J
         5d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679846; x=1776284646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UthiWrjG1Hwt/0nbiWEQ1KZeqkoIURhsJh3Eb3JdJ/8=;
        b=a9oUCUfGb1cC0VoEVYjLbAEMDiD9FKxqUAqMoisXMciwKFH4s37AUKk4Dc8JPmpO3z
         KE57qmM3dwmclvkm4iPIKX8TVHgg5eE5pRvZ2AQOkvM61QpBLdO8Y+4LgxXzSCxNXsr3
         HeIB6a+nmNr5Oo4y0k7pfupaIHeuEpzc7jsQBo93hF0314fozeOIg2Ho45iTpJAeZHew
         CrqW3nSIH2e1VoELOs5qX5U4Cc2sUhJl1nHO7YTdA4gfZJICe+bsupIO1kgsHyyrCLTT
         2BJ4O0VddJAfMQSM1pQLLOS01olNJvajjcXpxl2DdIfZFeEOpfqmYCoz5MrBXenyuT6L
         ZNZw==
X-Forwarded-Encrypted: i=1; AJvYcCVBqFCuEzM1lYOmUdRF4HzlK3lmvwJwahE2ZzMPCjtvyNXM4c11voGv1FJlYf8YOQXMZi2faXm/KWmkJC0hfGDycJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUA3+mEQchRKHv3+7rNTAC3O+SBf9EhI9ier50k+/NBibbJJu
	TXSPFm62siFfFqoK8MM1qf4YtyRbT/g16OqPH/smhhSKCIyVPnm7DuOWu3dp1C2t
X-Gm-Gg: AeBDietCtvazfoP7FON6d14aH9nih9O4bKPMVMKzSQYVL1c1w3X7DqZW2WZMzyQ33TH
	JtFoQ78zuX+tLL0SWd6jng3vbmwAKOGBWekAZcdm9T3lYAfaM79QxyLXUeF4E7Sf1w+IQYvdZx9
	4f/Bt9570DWLaoh4sUZ7qfbQ7qTvWDqYGq9lUMe+n8UNkKfRfR07vYzZfmG39DTxguytoQwXUh+
	tcuTLd7gIZIINQvH1mHFooguocyhpB/3LhfsBoFG+IBpaJtArNULQKEu53FP60lQ9Qcugn9y3S9
	bP3AlPmvWuQa5dz8J9bp9svsvlldT1+ZBGfFNj6hRASazeOD3xJSbpebIho+OTJvbCg7t3Nd9TQ
	bFxUD2Mjz27QEr7/QvOGjGTyzT/nV7r6R19Du9Sc9dMkkzLbH+IDmKnAEqekYeVravnlnIjWO/Q
	p9mfMkpkj/++1G0jI9vVeVxXV1ldfqDdKYmBSCBPUj/R57mF1xx20MarTiGczbJryw9noRtkDWU
	JKmwNQMPw69oE8=
X-Received: by 2002:a17:90b:5583:b0:35a:329:73d8 with SMTP id 98e67ed59e1d1-35de67a0817mr21268988a91.4.1775679846102;
        Wed, 08 Apr 2026 13:24:06 -0700 (PDT)
Received: from localhost.localdomain ([103.10.31.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34fd383dsm704288a91.6.2026.04.08.13.24.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 13:24:05 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Gow <david@davidgow.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	shuvampandey1@gmail.com
Subject: [PATCH v3] seq_buf: Export seq_buf_putmem_hex() and add KUnit tests
Date: Thu,  9 Apr 2026 02:08:51 +0545
Message-ID: <20260408202351.21829-1-shuvampandey1@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

seq_buf: Export seq_buf_putmem_hex() and add KUnit tests

The seq_buf KUnit suite does not exercise seq_buf_putmem_hex().

Add one test for the len > 8 chunking path and one overflow test
where a later chunk no longer fits in the buffer.

Export seq_buf_putmem_hex() as well so SEQ_BUF_KUNIT_TEST=m links
cleanly. Without the export, modpost reports seq_buf_putmem_hex as
undefined when seq_buf_kunit is built as a module.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
Changes since v1: https://lore.kernel.org/all/20260406033728.25998-1-shuvampandey1@gmail.com/
- export seq_buf_putmem_hex() so SEQ_BUF_KUNIT_TEST=m links cleanly
- validate with a fresh arm64 build using CONFIG_KUNIT=y and CONFIG_SEQ_BUF_KUNIT_TEST=m
- send as a new thread
- capitalize the subject for seq_buf/tracing style

 lib/seq_buf.c             |  1 +
 lib/tests/seq_buf_kunit.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index f3f3436d60a9403eae5b1ef9b091b027881f14fb..b59488fa8135cdb0340fbeb43d8d74db8ae13146 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -298,6 +298,7 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(seq_buf_putmem_hex);
 
 /**
  * seq_buf_path - copy a path into the sequence buffer
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 8a01579a978e655cd09024d0ea9c4c9cd095263f..eb466386bbefb1c81773cdae65a8ac3df91cd8ea 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -184,6 +184,38 @@ static void seq_buf_get_buf_commit_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
 }
 
+static void seq_buf_putmem_hex_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 24);
+	const u8 data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+#ifdef __BIG_ENDIAN
+	const char *expected = "0001020304050607 0809 ";
+#else
+	const char *expected = "0706050403020100 0908 ";
+#endif
+
+	KUNIT_EXPECT_EQ(test, seq_buf_putmem_hex(&s, data, sizeof(data)), 0);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), strlen(expected));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
+}
+
+static void seq_buf_putmem_hex_overflow_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 20);
+	const u8 data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+#ifdef __BIG_ENDIAN
+	const char *expected = "0001020304050607 ";
+#else
+	const char *expected = "0706050403020100 ";
+#endif
+
+	KUNIT_EXPECT_EQ(test, seq_buf_putmem_hex(&s, data, sizeof(data)), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 20);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
+}
+
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_declare_test),
@@ -194,6 +226,8 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_printf_test),
 	KUNIT_CASE(seq_buf_printf_overflow_test),
 	KUNIT_CASE(seq_buf_get_buf_commit_test),
+	KUNIT_CASE(seq_buf_putmem_hex_test),
+	KUNIT_CASE(seq_buf_putmem_hex_overflow_test),
 	{}
 };
 
