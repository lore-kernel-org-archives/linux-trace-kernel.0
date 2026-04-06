Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE77270EDF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775446659; cv=none; b=SiHQLWsqdhjhtXlke9UFiPx8WchA9LSMvs+bkW+qQnklJXDSFA5tkIj0hhOr0y98DyJBLh3U2G6aVn08at+VHTtI5R0k1yDMlhiU8koYrPI8t8SOY2wjnSo7CjzjAGUUoe/Vzr9dS5sQ3WomqmZR6qGSVdenDoXkyQSb5HaJQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775446659; c=relaxed/simple;
	bh=xShcbXRHcLEZpcF6Xh3ZxZzKCOxAjIKPZOETdGcqZZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNaJ2fT6cwACOxHh+K6XpAVR3led6DrVlxlsw4Hnz4lt6KG1wY/Ts5icrtmAqqXcZTZ6jic78YKbV069AzOY1aPqcyYe2ZCVsFzFtRVlqXU/mNPCnmLLEq7h+UFcYKutOy/AGrVvYRmnMHdM0qYLBjcEqGclasYLhSAuljMWeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8VM+X4m; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8VM+X4m"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so1453317b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Apr 2026 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775446658; x=1776051458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHHI9dzy0QUtRw0Ylu8czvQdIR+Ebktf2jk7D7RdBJo=;
        b=g8VM+X4mclopb2zU2zffbLLdbKVCVRJH0L9z7RSwZKtc/TWd78rAAM2yfOJM6QP+Dm
         dvXJrh/FSZXb2ilGExt8HgmtlWxdEilJml8aAZKI5shY57rVpWmFrVkLxVd/AbhVTKj7
         OLZCnhpbJjTr0pG+Kj1+jaGMKqZdPyWA9RxD3EENAQgMD6vatcxfTYTuX0yxwoUacake
         mUJUeoPv1ysoVMDJlSrO/qNZt6+WWaat5WoNYLxOpgEIrlO7yrRScwvys0yJQEh1vA/s
         8/d0zYL7tIHtxpsmd2sX43C+yLEdR/iC21JCHuNnxSz+Kn+qktuMJEjzgvoH6Hxwdr6v
         dm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775446658; x=1776051458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHHI9dzy0QUtRw0Ylu8czvQdIR+Ebktf2jk7D7RdBJo=;
        b=NliV25EYzO27/FYcSjbx+cZwbBu5/DB04jCei02or/3DWAT6rFAbhPi0ymvXh9223t
         1Py+0fE1nacYL765Ub+l6fohEyEppQpxUwT+5MI+9BSYHFFMfKJWYYx2zcHmbNxkbYK/
         8G68k+sSTwvoPouFJNAnrxaZP8wO1lLQVNQ8I3QnBhIggNRiM/VEEgcU6222WFCA9F1t
         mwXjoaMXmMHpuf+mCyAUCQeSqNAsMtNrdxz8huNTheOeM2WlHtElxE5bbP1fv8OsQYT7
         AeYh2dSnDWMw54ONiEnCX9oWndvD+Cx73xVCiWPey6wC7Pzuj2J8uZINjP6yjm7qS3/y
         /YNw==
X-Forwarded-Encrypted: i=1; AJvYcCW5gxOyR+hUJZypruyIO5cUSrn98tciiW6e0YGZdQSx58XiF8u8vH5zE6pwKLeP0pMaNtqqJ94vTd9aWmKnT8ZPrAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXL3/X9x2O954eGh2jYbiMKiJ4WbERt8Q/qTKNDHCVosWQqh1
	G4rCmgTyik2iWsm9xGitQz5AZR2QJxdG1+oaaH2W0taCta6odR3UWPDq
X-Gm-Gg: AeBDiet4dxFOQfnGDFQZW38N1VTsn4xh6L2/aDz5MgDxJLL8cVc7BXxgYsNLd1OvTLw
	wiXcfCy/RfZqWJ4vkURzx3ge7BrmWS8fzhWyxon+knd3pPVm6jQUXxaRmnf8zGP39G2uIZ4lM7l
	GiojV7V/tVDFO0xhHf6LEYuNDSCx72LInt0125DS4ubi/Vz+p2L+kYYeDS8hS6np7z6BeDl8lK8
	ko4TOdHZ0Zv4Io14P7HywVRz9VoU1ATmUO95Uj1KaBrI8qxj4j0cwOgg2I9/ONjni9zvPTD6zhk
	z6KguI3fsFk70URjBJ62crUelb0nPtKG9FqocHUGjOC/fs8wAF5cC+13s/a9fSa/5qb3B02pw/K
	ifK68f/A++aHnpGyioVOgVjWg/pGDzbT79E1TMF0afQp7P2SxK7YIxG7j/3Hc5RJNk8RxtsZHo9
	jeJskVTaKfBRfH+8Ubp/KvUtwngPIePkfFMppy92kYu39bnweAvRN7ucyhRQOj4ZnKo3XhwbQ1V
	uZk3sQPbYLxgpuKEpDy
X-Received: by 2002:a05:6a00:3e12:b0:82c:7876:a03e with SMTP id d2e1a72fcca58-82d0da8f384mr10318168b3a.17.1775446657686;
        Sun, 05 Apr 2026 20:37:37 -0700 (PDT)
Received: from localhost.localdomain ([110.44.115.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d12218738sm9539766b3a.21.2026.04.05.20.37.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Apr 2026 20:37:37 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Shuvam Pandey <shuvampandey1@gmail.com>
Subject: [PATCH] seq_buf: add KUnit tests for seq_buf_putmem_hex()
Date: Mon,  6 Apr 2026 09:22:28 +0545
Message-ID: <20260406033728.25998-1-shuvampandey1@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The seq_buf KUnit suite does not exercise seq_buf_putmem_hex().

Add one test for the len > 8 chunking path and one overflow test
where a later chunk no longer fits in the buffer.

Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 lib/tests/seq_buf_kunit.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 8a01579a9..eb466386b 100644
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
 
-- 
2.50.0

