Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77773064AF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517171; cv=none; b=WZcUqnSrW2xWajjZgS5T07JodikRfdHqNMkK/5rz+YpAUK/0hZ3J6wJlHMXjWkLeJFqV8YxUR0T37mJR0B7tsVLDZJUOdnY2hP8uGskZHBs0tK1l4HKQMeY0JCFKZpwat7NNojtdmtcij537lrv37S36gxW/3Y0SlshD8Pi7WUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517171; c=relaxed/simple;
	bh=KXynVc/l4z0I/0afxLQ1qgxkhnxUen6TcUANd7bwj6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzP6uOY+Y8lIw+QgkZtyE890M8g0h8uJlQVLmyCrRw3zcJLWgyyQDf5WZzlFUQUeEV6Q4lNn699nMNOVCGf1DCiFo7j0xeU/TLz+8mLR74Mw2Vpz6A1eXQMuZdgc5WeeeH+xLxrcKukIvXJz15tAkHYudnSjuFDwJb2yy9KgRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITmGOnfj; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITmGOnfj"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso3932636a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760517169; x=1761121969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBZqKJ/asg/RWAeGZDfmIrxp30oaYR/dgJdIlWzmC0w=;
        b=ITmGOnfjOMxXBOAJJaABZbOcR3jan9LxFHWOY2M8pgqGS5HROMwc2GBATxcoWNZU35
         OSi/kAVadhK3OVjcUbvzMcMCfPAa0GC/A37+7hCbt+RvqJFg2SUTz8bF5bKiMm17FZ8S
         y7xJkLwmjOoOTVilfNE9yw/hggcrQ46/F0ablP/ybactyPF/HIxzSHfRepDqqa6nTN9/
         wTPr+Mull7xEgVUCHy5u2io9ISlY3XNoHaL8kJDYFrDWpyr78PaIYPA5enMplSi0RvSH
         SwFLTRWU28d/ohMc5RzJCvgpTnrFlO6me7hluenmjF/PcxH0LfSfSq4wUcJpNr82fzXE
         +OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517169; x=1761121969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBZqKJ/asg/RWAeGZDfmIrxp30oaYR/dgJdIlWzmC0w=;
        b=tuAhqUny5vF1oiCwQTUU4jcaY64ENHRlm/vckh9+29gf1ti7IWmZewbsB6d/2SJSaG
         XH0eqYeUTUycyN84q8dEDOlJeE0By7n6CbvIMhNcktnYgJNvuWv5glT/ILm7377TDpdn
         XMQywXFjw8zLkyQjj+5QuJn/VBt0Q+LWg9LA6z3Pb0ODaId7HG0IeYID/wqWSygam79d
         viblIJg3pGlrZJh/84TN1ALkmGgbhOkcMInxY0nKx+KyU2d4txDRdPHne0yy7qJkAPxt
         c5kdP8J72G2x2xPu46dJ22UfLJn4Dv8gb3yVDcztvfeevM+ra75M/4J6TtJLBR59qffb
         uDAw==
X-Forwarded-Encrypted: i=1; AJvYcCUFg38uj1wcv8Rw1TP+Yrp2Tw9i95cd1u3wAZSM7yWwbTyMwhMWALd9fD6PbFmiMiY3rfSERb1O8O0qth3piidpPD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9EBKM0/Uuh8+mOYAjkG43SyHaxxPaYTXKOVb/MWrd0FK8WvxR
	O6A09fK02WM/+sft3NNj2bzXqAv+UZM9CbS9I6nsBrZYrldfDWxGFuYx
X-Gm-Gg: ASbGncvnNW+vJ84fETw0Vr2HFcIMw85wx18ZvkTKCJ7/jEoMwaJXIQevhTlXN9s4G6m
	gik7OE3kaEE+ypXiEXzTdJOwgsnBOjcDwqVG/h1GZdp+aGIY9MwSB7H8yA78d953YB5o8TJ8/4S
	ixiTx5DhepC34i5lUrjooKQxncMdbX+o+sTiDpTUpWJi7YUTupdBrcehijJ9cd8vleDwpLDbNlw
	EliaVnHL9H349Khb/aSw9k0JRCad7uFnJXxxZtXIM2MUUyfFPKqmYnmAIvSyqw0u5S9lAHOdHBZ
	FfAkSKpgN9b4m9hxAls7EDoRTE8B2Ob/KyiK6kx47fkF3tQ9vDuBjqPIbTs1AdPcJ03b69//Iqi
	C350zDPx262MM5TxVHqMaDgDaXe0RE0iNCPSeVkTi5g==
X-Google-Smtp-Source: AGHT+IHOtCfgBGstadSybPaEbTlFaVHGemKaosqIOpfnr9AukWH1u/lAVVP9acxMEh/IqYs9TWkYOQ==
X-Received: by 2002:a17:902:d607:b0:235:ed02:288b with SMTP id d9443c01a7336-290273ed890mr324186065ad.30.1760517168826;
        Wed, 15 Oct 2025 01:32:48 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35e62sm188932455ad.88.2025.10.15.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:32:48 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] lib/test_fprobe: add testcase for mixed fprobe
Date: Wed, 15 Oct 2025 16:32:38 +0800
Message-ID: <20251015083238.2374294-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
References: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
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

