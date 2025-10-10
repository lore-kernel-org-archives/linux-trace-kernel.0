Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E3273810
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067544; cv=none; b=W6266I6wYuPFrj1TqexbaG5D1L6QkAED3LOI8qAjV6njsmg+y5yIKdZbX2xtbLyZQ8CzKZbJh8aDXF+EkvHEjXYhEEEN+pTDeh8Y9GDYgZR8wWqs6GyZUJbJSdyrff2h009gwMI4mbpsaRFFaRZ56kw+RiHNaqFTMYjxj+QagPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067544; c=relaxed/simple;
	bh=KXynVc/l4z0I/0afxLQ1qgxkhnxUen6TcUANd7bwj6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzXCvSUNt2EYUf73412riUl6AsWkA/FW0g0S2jkZXXyjELdMePlsPUT1qHbGvx5lv0pDBn04Jgd8n7t0jHI2z83TKD4M9+jFkiIy83El+2WAvm6PcRzTwlMPXshSr58vYuo55xxMxYUPaKYEk6fXCCkpIOD5XzaYEkYX3CZTdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N91YdqeG; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N91YdqeG"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-782e93932ffso1512524b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760067542; x=1760672342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBZqKJ/asg/RWAeGZDfmIrxp30oaYR/dgJdIlWzmC0w=;
        b=N91YdqeGK7Nj2b2+WeiVh5z+Vi8lO4a+1AQxa2tWA0FXf9BMTdaTzpWDd0pAQEGTeR
         xb5r32XgsneiG3uZ8/DnC3ULjYAw2uwrgtviHWPWvHGGCQ3ATrranhLBaOnS3is4t9Uy
         41KlBVDbAKrFpyETmVKPM1QJ2WuK0zxSv72PsJZDTZNF6WrtZHYtSqWkVnTqa42uSHwW
         f+ohqj04AYtSMCeLFfd+kJk3x2xrD6bbc/FbOHpH0iFSN7SlW8wiZfWfC4FKugyBBIyr
         XG6oYccxEZzFtkZMTxfiewpUFB0I+YmyOPqo3go43/Ui+cAxjcwTQk9GpBmW/ZRlg/af
         RiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760067542; x=1760672342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBZqKJ/asg/RWAeGZDfmIrxp30oaYR/dgJdIlWzmC0w=;
        b=E6+3cymwqxBJHfT//e4n6OzeHnM1Cl8Dcm6Yz56571SwdkbC4ShVgJP0geJjC/n7oT
         Ckfss0l/VYyylqiPkbNKL4/Sv3YRMzRRiA7lcUvUSLi70ZoWHwcU6VbmLfIWe179ay0M
         LuSWJqItRow3jiGSWTMr1WJo0gKNmHQtkUiptRn4COnNSaMxiYJXVupwY6Zj4Qnmq+ul
         sVsazO6tRXTplaxJtORKJCHOh8s1GBxxONs3VVwcmWbhmUdE3svKVpQSiXfQKErgxsBI
         e5Lgu2P9T8ve2RobUpVj0GbdkfmgCSpdkkaxAr72b/U1bCOsu7018frO2bo+JyU0EkYg
         5OFA==
X-Forwarded-Encrypted: i=1; AJvYcCXBOMPJMCxclI+bRzr8w67hUg2EIW9Tpt/iSYHUByCSUgYXb6lFzgSNeBVovnY8D4k7xnr3RasLgMw5+32+qkVPhkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3R+aBIRS5a5KO/ZpvqwpZ+S9brdc0Pb/YXSNHj9B2mDVMmljP
	EOgp84InyQaEiw69sZvTRfCXUNR7Bs6S25BjjDew2/BEJunijk5e/c7rP2zRyWbwrkg=
X-Gm-Gg: ASbGncu1g9wY+yF0QnP2qLIjIob+gV9ifcf9ykX5EIcTbPgvgEVrZu//X/Vu9x+RqED
	RPlOFa5bjdmUy/BCh5LPhBd9IwM1IaI0aHp7EXuEkuVmUs7vR78nF+/aIbaLa2WYT+I5BzbbQiQ
	MfqOmcWoAXixPJ/iuu8HCYD5Yuu5foH4OYUMNfBYzJ8OH4d2ex92K3hpT5/kiqS50hfaqHpg+eG
	w9Pz9cQwLn4poAetA4tsRRI4L+G9SPeWlR8l3TWP0nzidtONx3WVzM928Xanp5KysdZVmwfxF+4
	AIwP4jXcRq/PDpT7z8cRyIZp4EzIwviUDcjLICN35ou42XsjKWko6M3AZt/q9T9w/Eg9Ow7QLOC
	Awn93zIPwxNlk098CHIH11Z7fGDyimj9Hxn/FZQ==
X-Google-Smtp-Source: AGHT+IG1pii1a/6UxHO3ZsdaqVmhRYM3KeTUX2lb00NzJ4iCKSEU4O/XYpU3GYBm0sSAc3AywoQaSQ==
X-Received: by 2002:a05:6a20:938e:b0:309:99e3:c6f5 with SMTP id adf61e73a8af0-32da83e68a9mr14172182637.48.1760067542542;
        Thu, 09 Oct 2025 20:39:02 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993853sm1260148b3a.74.2025.10.09.20.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 20:39:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/2] lib/test_fprobe: add testcase for mixed fprobe
Date: Fri, 10 Oct 2025 11:38:47 +0800
Message-ID: <20251010033847.31008-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033847.31008-1-dongml2@chinatelecom.cn>
References: <20251010033847.31008-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the testcase for the fprobe, which will hook the same target with two
fprobe: entry, entry+exit. And the two fprobes will be registered with
different order.

fgraph and ftrace are both used for the fprobe, and this testcase is for
the mixed situation.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 lib/tests/test_fprobe.c | 99 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/lib/tests/test_fprobe.c b/lib/tests/test_fprobe.c
index cf92111b5c79..108c7aa33cb4 100644
--- a/lib/tests/test_fprobe.c
+++ b/lib/tests/test_fprobe.c
@@ -12,7 +12,8 @@
 
 static struct kunit *current_test;
 
-static u32 rand1, entry_val, exit_val;
+static u32 rand1, entry_only_val, entry_val, exit_val;
+static u32 entry_only_count, entry_count, exit_count;
 
 /* Use indirect calls to avoid inlining the target functions */
 static u32 (*target)(u32 value);
@@ -190,6 +191,101 @@ static void test_fprobe_skip(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
 }
 
+/* Handler for fprobe entry only case */
+static notrace int entry_only_handler(struct fprobe *fp, unsigned long ip,
+				      unsigned long ret_ip,
+				      struct ftrace_regs *fregs, void *data)
+{
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, ip, target_ip);
+
+	entry_only_count++;
+	entry_only_val = (rand1 / div_factor);
+
+	return 0;
+}
+
+static notrace int fprobe_entry_multi_handler(struct fprobe *fp, unsigned long ip,
+					      unsigned long ret_ip,
+					      struct ftrace_regs *fregs,
+					      void *data)
+{
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, ip, target_ip);
+
+	entry_count++;
+	entry_val = (rand1 / div_factor);
+
+	return 0;
+}
+
+static notrace void fprobe_exit_multi_handler(struct fprobe *fp, unsigned long ip,
+					      unsigned long ret_ip,
+					      struct ftrace_regs *fregs,
+					      void *data)
+{
+	unsigned long ret = ftrace_regs_get_return_value(fregs);
+
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, ip, target_ip);
+	KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor));
+
+	exit_count++;
+	exit_val = ret;
+}
+
+static void check_fprobe_multi(struct kunit *test)
+{
+	entry_only_count = entry_count = exit_count = 0;
+	entry_only_val = entry_val = exit_val = 0;
+
+	target(rand1);
+
+	/* Verify all handlers were called */
+	KUNIT_EXPECT_EQ(test, 1, entry_only_count);
+	KUNIT_EXPECT_EQ(test, 1, entry_count);
+	KUNIT_EXPECT_EQ(test, 1, exit_count);
+
+	/* Verify values are correct */
+	KUNIT_EXPECT_EQ(test, (rand1 / div_factor), entry_only_val);
+	KUNIT_EXPECT_EQ(test, (rand1 / div_factor), entry_val);
+	KUNIT_EXPECT_EQ(test, (rand1 / div_factor), exit_val);
+}
+
+/* Test multiple fprobes hooking the same target function */
+static void test_fprobe_multi(struct kunit *test)
+{
+	struct fprobe fp1 = {
+		.entry_handler = fprobe_entry_multi_handler,
+		.exit_handler = fprobe_exit_multi_handler,
+	};
+	struct fprobe fp2 = {
+		.entry_handler = entry_only_handler,
+	};
+
+	current_test = test;
+
+	/* Test Case 1: Register in order 1 -> 2 */
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp1, "fprobe_selftest_target", NULL));
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp2, "fprobe_selftest_target", NULL));
+
+	check_fprobe_multi(test);
+
+	/* Unregister all */
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp1));
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp2));
+
+	/* Test Case 2: Register in order 2 -> 1 */
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp2, "fprobe_selftest_target", NULL));
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp1, "fprobe_selftest_target", NULL));
+
+	check_fprobe_multi(test);
+
+	/* Unregister all */
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp1));
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp2));
+}
+
 static unsigned long get_ftrace_location(void *func)
 {
 	unsigned long size, addr = (unsigned long)func;
@@ -217,6 +313,7 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe_syms),
 	KUNIT_CASE(test_fprobe_data),
 	KUNIT_CASE(test_fprobe_skip),
+	KUNIT_CASE(test_fprobe_multi),
 	{}
 };
 
-- 
2.51.0

