Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDD2F39B8
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659522; cv=none; b=Ryjwue6QUFEjbpQnF26cZrQJDl54/ySmsLc/5mWWFddNaeFxFExk2RZ4OxwrVrgNQtVx4xJXKb7T8Xra/rqyDYH4apjkuSjDnrR8QUo4ZSgSwf8bMXgRR5U3VxZnGC7la4hO1+CHlgkT/mynyw80NB6bOBfQE53hOwO8l0Ls1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659522; c=relaxed/simple;
	bh=a6x2OhReSVc3Z1dCtiMclRTOwCsIuCnXoMbbim9keHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEv/6sAmafKUy3qRgLv6S4b6U/dVHZxZx46t1o5pZn7m7dB1+XMoXN1v771BzqDZwv5BWlcCN7llj0a1TMmcvxqIcf0lUVmyz/Uw6GsxU9Klf2OjaPHrPRJsGmn00HSSgJ+gU7Ek6ZcID25O/dkzgKaTKDySS2f+PYc7/AtCyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew3b1Crz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew3b1Crz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad617d5b80so34479755ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775659521; x=1776264321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M53r6SkdFKKJnPXXmzaN0o7kYfdxnvwHZHkbphF/YkQ=;
        b=Ew3b1CrzzRe3ZZjVSbuvMOcN6Qp2qg/r7SFEL7M6NShme40+wsQ3pnDH0uweWm27ty
         CMc+vD92EX0mvJBrF7WzC/BIEkyYMXr9H9wuRQptyO2HH7fCkWt4cJsQOc23cOQchNiv
         kcNkMgJS9OGrULsnptQztlXw8dipRKu9rZwxs28Q8Sdi1Zm/oAQXbn/dP7HtHQmcBUkN
         6LE803Rq5f6T3rJdlSarOMGDadruP3JwL6O4i1e2VhZS2laQXnOzG6BQ1EdcD78rkiiu
         lLh+Vsqh+DXcRTv3bwRR9ajYNX8oC7WukHw8GyEay+Re5/dzhHIz4nh0nhl0ejWZ2RIb
         5Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659521; x=1776264321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M53r6SkdFKKJnPXXmzaN0o7kYfdxnvwHZHkbphF/YkQ=;
        b=sl+BsuPyuefzBh37c6kIFyitfpbbAvuOzNIsPkseGVH2uYqGPVJOC9UMMVIN3qlT6P
         WdyXZZDIa7WiBIvf6miIA4xBbyDTW+trcwA5KFmzHLDxfJOw7r9IOMuNwK9/2eeGvZUp
         9LHDyyCjvSbXv57HQ5vtT47ulDuBUFmXvypcZNryw+xoY9vDpKSZEPJn/Lf96Qc71cYf
         lVtUbM1mWxCMzEzoyusO6uvLngPiWMAo/2SQS1BNRUobCM7znTP9xnEXpOCInn1wwWud
         6RuOeWx63ogRQxHHvA2BFM5bJ9UsF5RLSybrYD/CmvuXeUGOq0Z7YnvgR0Y5E0uZUNyT
         3/pg==
X-Forwarded-Encrypted: i=1; AJvYcCVFcoX98zOAA5assSqcli2sQUkZeL1aMCxs0BNRSye7FHj9BTL6MEKAAVEx3L/auCgpsBdhKSGV778etptXIwtfU6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZqRJxE2ag5pIt5aeqhmlGgPZyC1pN2zxa90ytEzmEQAfZZRE
	tqvw6IM4IyeKzE2sSF/XMgnuxaU43cHteqGbjpNhAv8SWzaIZPV/Zchh
X-Gm-Gg: AeBDievL89vDjk7OgtX1joh8LD7h8AIJUAlT5UT0T1F/A3vKS1CkMw7dhORfdp/P1mu
	4kAj0fw1D3nVENT8X6y/2BuD7fbFMFAN8Td/zwj4HW3uAz0iiRMVF6fuUdq/H3mKrjbb97X6KQu
	W9qzMj0Mu7hkAMPJSJNhb9zV7jcghVApFaVH2qhZwevFgmv074/h6oRGIGw+QF+SKIPKp2l4H5X
	q4EurkBPRpKWC+gNonxA0UqvOcjO0BIMedrB8nPj6dn7hK0GEGmgDfnpvJabaJmcgvgXAvxysUI
	fsnKznJNyyQ32OAidwC52xKn4/DFJVNHZOxWQ1r3XN0pQn8BHKgd1NukAOr56DpZEEtbEGNJ1xF
	KHxCc87CQQhmDH06aRUfLBIOiK4TU4DBTZxMrgpJ4XdPONDAnu5mcR5e502o76IBJuY1F88AYQp
	f+A7NnNmH1MkT06pQ+JMIjtw8utiQVCTYKMmipYvWB80DOS7jcIp2I4pogxwgL81bvhjKk1Ft/T
	k6b52GCIeAxjSU=
X-Received: by 2002:a17:903:191:b0:2b2:5637:1487 with SMTP id d9443c01a7336-2b28178f0b7mr220740205ad.34.1775659520719;
        Wed, 08 Apr 2026 07:45:20 -0700 (PDT)
Received: from localhost.localdomain ([103.10.31.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274756621sm203094795ad.20.2026.04.08.07.45.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 07:45:20 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	shuvampandey1@gmail.com
Subject: [PATCH v2] seq_buf: export seq_buf_putmem_hex() and add KUnit tests
Date: Wed,  8 Apr 2026 20:29:49 +0545
Message-ID: <20260408144449.57375-1-shuvampandey1@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260406033728.25998-1-shuvampandey1@gmail.com>
References: <20260406033728.25998-1-shuvampandey1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

seq_buf: export seq_buf_putmem_hex() and add KUnit tests

The seq_buf KUnit suite does not exercise seq_buf_putmem_hex().

Add one test for the len > 8 chunking path and one overflow test
where a later chunk no longer fits in the buffer.

Export seq_buf_putmem_hex() as well so SEQ_BUF_KUNIT_TEST=m links
cleanly. Without the export, modpost reports seq_buf_putmem_hex as
undefined when seq_buf_kunit is built as a module.

Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
v2:
- export seq_buf_putmem_hex() so SEQ_BUF_KUNIT_TEST=m links cleanly
- validate with a fresh arm64 build using CONFIG_KUNIT=y and CONFIG_SEQ_BUF_KUNIT_TEST=m

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
 
