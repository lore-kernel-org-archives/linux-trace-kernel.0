Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC81367
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775446642; cv=none; b=u0pO8IXvHpcGV9MJzO8P/t0EK4qslDyLyWeZ6MyJrJLFFLaLtxzuAAamdVggS6mH5mWr75LzQQf7xT/AkuXn2f1YlHTY7jMULFJl6ZpqnA11sOfjqbD7RXYBoWgtwG4TJsrp5vt0Z7lMEuu9TftgsLBTPuUeSyHZFwseWZa4cnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775446642; c=relaxed/simple;
	bh=xShcbXRHcLEZpcF6Xh3ZxZzKCOxAjIKPZOETdGcqZZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqbg7mvn8vJ8gDjAWSRwRp9uOBesQNdi+5k/GxrekAW5MIG36J9BDlsy0eJi28W5L7DAk98DsO4NfT1sa2Tj+Sz909NX11NzW8PeMKIcjDAT8lit4MaBM/E+eJM3juRRYLLQjyfKlQ/dWq3J9n58TZldlgyJfHJhnSbyPlVOJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idM6nJFG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idM6nJFG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so3278475a91.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Apr 2026 20:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775446641; x=1776051441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHHI9dzy0QUtRw0Ylu8czvQdIR+Ebktf2jk7D7RdBJo=;
        b=idM6nJFGi4Q7mBRMQZB1MR2DGVSxPGC2GE8XpFKoZr2/Cs11X451nGTYZsBzjMe11X
         nhPRoRmUsnUxgyCENGtRIKlg3wkwzolOVJX/xDWVY1Jo86yD8JSiSWavght9OF6oNPB4
         fZTf+ANJqm3LzOtDvplS4kCJk4ahb4v2OgE9gaw+D2YaXA5uZZ1XIdsJVmxjUrTyoZXh
         9QhzD3ZU3IlBR1FeSIrWawLP57QZA9Tl0Lyr4hFLP/PnJ50wGYygqSEZvQPxqbRx0rc0
         eizCmAoSnioU/uEoe7aA0pHYAnojV3+8tBatUCj62sOohurWY2X/gcEscmrk4nYmer2n
         Fnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775446641; x=1776051441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHHI9dzy0QUtRw0Ylu8czvQdIR+Ebktf2jk7D7RdBJo=;
        b=Ox+H3gGI/gPo6yaovhMOQcVCuXAcpGdWw+IPUgGeA/6RED1Crau9qpqWTioWP/bvRr
         WeP5VfKs+j3QY5sa34OV16rILgcU3nYmhJ06zNEGnzlcL/Hx9ze3x+MfAC29Jj5r4MEm
         4657qMJrt1dOin7GGonrS6tYlWFFjHSE5d4bvUVijWEE6qf+hFXEmjhjhZdQt1Mzw/D2
         0Q1K1hsCpdT2OiVKYZyzELYMMVgdMp33DKPnhyjDE/1+9Vdku0EJNzrWZt8ZO85pY+7J
         wgtx7PvRvVnRmWiDVlqxmA9UzvNVRBogt4Uh1La+jWauLUCbLstVawbJJ2tx90f00xDx
         xDmg==
X-Forwarded-Encrypted: i=1; AJvYcCWTsCFKH1tDH1UtNXj+jUCnWUvKVqlTwOuIkhpKF0yQueX1NNCdNzyvy0DgISnYdb0ehlRGYrT78rJTLR+5vYjPZ0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LC3C2QAGvQsw1QXL8eK5y8fDloAWfC6mSPin8EDlO8AF5DlO
	4QH1pB+/eONBnhWPMVMhaElYKOq3LLSysdAy5K1ipmtubHurqOrLPVMh
X-Gm-Gg: AeBDieuy3bUz4aedMBeBBp/2qMghWhxH4E1xDqEk4CZmNGazIOcpZuFsEAJOVef66Up
	xU9M+yu8OGh9YrXbBLaD0RJ4449+MP1d1gYP7y5XVPBuZwgRZJKciYsbltbGl2KUaDJ5WAqtyFB
	gOoZW2EXR72cGP98hxntkQj04QfzxwQ2MayvLw88HXr18R7ZCGKt6f29AmLMIi2IhO5/9T2/ML6
	6cg7EktSIKeUBIk5cdaTnvejm9Zw9In9OgrsVkqphh1CGYFIuEVxEvHu2ECGR2gFwux7Xw3+ssD
	j0s1r2VWPt6Xwx8vuwFwmRI2UvEdOdDKdcM+OModh7yQWA8bm555db2khN3b77t26+iX4sAbFwT
	m5ZKu1e41DTavNjWu5Yi5/Lx1LDGjH/Ffdnmqu3P5J0sFYLglbgNKKSuMoRO3J6HGATyuX0+OhZ
	wvR9DM1lb1zJRCkjr6aiDw1AMVWaJozZBVKP29jVoB1tY+oAOx4h/U6qhSYWVUp+kXwrea6+KNA
	lxiJX6CSnOgKNJMggcCiyrTL6KlDb8=
X-Received: by 2002:a17:902:ffcf:b0:2b2:9d60:5eaf with SMTP id d9443c01a7336-2b29d605f4bmr35935415ad.6.1775446640869;
        Sun, 05 Apr 2026 20:37:20 -0700 (PDT)
Received: from localhost.localdomain ([110.44.115.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747612b7sm121581585ad.23.2026.04.05.20.37.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Apr 2026 20:37:20 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Shuvam Pandey <shuvampandey1@gmail.com>
Subject: [PATCH] seq_buf: add KUnit tests for seq_buf_putmem_hex()
Date: Mon,  6 Apr 2026 09:22:10 +0545
Message-ID: <20260406033710.25286-1-shuvampandey1@gmail.com>
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

