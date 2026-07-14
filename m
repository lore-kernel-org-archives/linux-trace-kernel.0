Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9943C05E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054030; cv=none; b=s18LJ/7po2HPeV2/pUs2XR6A2tfS1YLJBiOP2FTwKfjoK0vSy6KWKbq/pUhXTxx4iK1RwcSu5UNsWF90bnL7xargLxwnRj0XaaCEDrGigDyZl+NPPBW5kIqOzpsxolGDMZIRq9glkRDUN8b6EM5vPDBKdOV2r6S4QWBpqMUIxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054030; c=relaxed/simple;
	bh=Gepv4EN5M9EKzOk4KnO+Ro5NR/FnPnIzfUYyZrSuJpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ9TwtnHdkjzpTuz9hvO/jV7OtcaxgZjtkPmBiugIcdEKMtN29OoT70Xk716YfevJGDYJJFC4iNDd7AX6G1zWs8MzLBXmgWD7l7ZbWysPSOAu953IK9gXuodYVfOrxJA7ryMu2b2Mg8bjH5htbhvYkCkwPfHKjNrCSvzuzDAogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7zLcB3w; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7zLcB3w"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c08df8513so9482441cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784054028; x=1784658828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxRwnz/utPYkA9CVNI0v4sXDVqY3MfYAVIwDwIjJvYI=;
        b=J7zLcB3w08njHNfoJmJs+2F+DeHDSpqslYrgpytSGPrghruJaV2i2VKhG1yKkNleNT
         afZdrcAc4+Tz/yXgm5g1HEES+W/BGhXxOxlhiZytrc4Nk9vrFd09IyfPtnNuNDnNCjZg
         66/SMchkIcHCjBlXfXafuUEdrXQrjmjfty3a2wOGWBTOP86vWnpjGXytYFMClYDws2tv
         V9Gskvi4vKycPkEvXarcQzMgjGw6uSD/F2aH0JrLbMtNlHDk6Ud4PJWaXlZAVeObYa0j
         70rybAhXbKLrctSKv3eV+AJ8xNp2kHOX3zCvM3xmp4+zzzBZ1SGxF7ntvlVBYYDe5fHj
         pl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054028; x=1784658828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxRwnz/utPYkA9CVNI0v4sXDVqY3MfYAVIwDwIjJvYI=;
        b=CrFlg9hmeeIXDOsHhBSETpV3P/C0x9jtHQZWGvkX70dqQJnvLKpRnVWscMhoA/21Pc
         24yfh7KdLT6pc2pgYGY0vaZNTOgJ2lbvb3/DMjQunuNdrPmjcR7SEBzybhLwz9LI30aS
         Gg7OcscXBJuxzyX3aTRZq/gaPQECFvEN/w5M/p5WO07Xe3tGkk6tV6o4v0jEUVO7STQz
         MCJJ0Z9m7JsuUpLUat4GPaMEl/KOF2AS0/3iVZTxkL/I1hxaGK3YBP1yHwytYLarsOU3
         B1ugV2VkPoM1skwlkFNTvejNUexxwioH7s6MiRc9w3RHRjeB+HMttJweOpEthAcUKDYA
         RDTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7Vi24myCvamaZ4yUdhOHzqGIXw4QqiQND+EUmpmCeezzhVzKlNsR8/tGpxcj/aanoD+dTncWRc3ZhZZCdpL95RGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjJUUYP3Zj9y0J3XvCclCYtVKyxQnY+KiV0eT6wk1aAaT4Ycr
	07GfDZG65RLU9ZNRK0w/cO4I9XZKQtk83z8KiZzttWSa57dJnyUuSwR3
X-Gm-Gg: AfdE7cnqOhRsbUtldSLEnmNl60nEoekx+PlzIRC9vYCHAx1udzwqLc3Y+l7A0AhmgG1
	DpiP/ZnThcFosw9rY2P54LZBLLTMLFcOmb4X88aTzXMWMx73kwGYb4HpSzNG2Gxzw5VTImTA5KW
	R5Z4k5BO4metFXbYIQL8DufrJkjHlq+sLreBzzHuIYp1j4XQ9xD76irZ0CPZmcRdAMrZSMMKBUi
	AT7XhTrNMol38DdflVRzv82MRTpbSB1gZ5uP9w1JRf+qTA0k5qy/y8BsbeSvOja+CZ3cAqdaSNJ
	RZLiXuF9SqhB3W49ADEdjkpRV35erLfTrzI4bsFLY3n0FMGbpwjZbYXNRK7UVHuwrRBUf+udUxA
	pkofvrDlNBW9hlaQGrDMEKUzHcS1lc4sC3l4PmNwyJYnoK00l+UAZTlHPEERXHePDekyCixacC7
	e7dz7dCwr0VWzuGRMlDjYkN5rtr1z0LFyHs2opwMBInjzq6s0OVUk=
X-Received: by 2002:a05:622a:993:b0:51b:fe7a:4eb8 with SMTP id d75a77b69052e-51cbf0e8c9emr148137331cf.35.1784054027768;
        Tue, 14 Jul 2026 11:33:47 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d22bsm173718936d6.32.2026.07.14.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:33:46 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 12/13] mm/kwatch: add KUnit tests for the watch expression parser
Date: Wed, 15 Jul 2026 02:33:39 +0800
Message-ID: <20260714183339.13044-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover base anchors (stack, argN, absolute address), positive and
negative offsets, dereference chains, and rejection of malformed
expressions (missing offsets, bad argument index, junk offsets).

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kwatch/.kunitconfig |   9 +++
 mm/kwatch/Kconfig      |  10 +++
 mm/kwatch/Makefile     |   1 +
 mm/kwatch/deref_test.c | 137 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)
 create mode 100644 mm/kwatch/.kunitconfig
 create mode 100644 mm/kwatch/deref_test.c

diff --git a/mm/kwatch/.kunitconfig b/mm/kwatch/.kunitconfig
new file mode 100644
index 000000000000..7e977ddf0da1
--- /dev/null
+++ b/mm/kwatch/.kunitconfig
@@ -0,0 +1,9 @@
+CONFIG_KUNIT=y
+CONFIG_KWATCH=y
+CONFIG_KWATCH_KUNIT_TEST=y
+CONFIG_PERF_EVENTS=y
+CONFIG_HAVE_HW_BREAKPOINT=y
+CONFIG_HAVE_REINSTALL_HW_BREAKPOINT=y
+CONFIG_KPROBES=y
+CONFIG_KRETPROBES=y
+CONFIG_PRINTK=y
diff --git a/mm/kwatch/Kconfig b/mm/kwatch/Kconfig
index b1c37a829dd5..74083040a1a3 100644
--- a/mm/kwatch/Kconfig
+++ b/mm/kwatch/Kconfig
@@ -15,3 +15,13 @@ config KWATCH
 	  exact instruction causing the illegal access.
 
 	  If unsure, say N.
+
+config KWATCH_KUNIT_TEST
+	bool "KUnit tests for KWatch" if !KUNIT_ALL_TESTS
+	depends on KWATCH && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the KWatch kernel module.
+	  This suite tests the core parsing logic, the pointer-chasing
+	  finite state machine, and edge cases involving complex watchpoint
+	  expressions. If unsure, say N.
diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index 02d7917602f1..1d223d73b461 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
 kwatch-y := core.o deref.o task_ctx.o hwbp.o probe.o anchor.o
+kwatch-$(CONFIG_KWATCH_KUNIT_TEST) += deref_test.o
diff --git a/mm/kwatch/deref_test.c b/mm/kwatch/deref_test.c
new file mode 100644
index 000000000000..094b7afeb235
--- /dev/null
+++ b/mm/kwatch/deref_test.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include "kwatch.h"
+#include <linux/string.h>
+
+static void kwatch_test_parse_deref_chain(struct kunit *test)
+{
+	struct kwatch_config cfg;
+	int ret;
+
+	// Test 1: stack
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "stack");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_STACK);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+
+	// Test 2: arg1
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg1");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG1);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+
+	// Test 3: arg6+8
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg6+8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG6);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 8);
+
+	// Test 4: arg2-16
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg2-16");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG2);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], -16);
+
+	// Test 5: arg3->8
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg3->8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG3);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 2);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], 8);
+
+	// Test 6: arg4+8->16
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg4+8->16");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG4);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 2);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 8);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], 16);
+
+	// Test 7: arg5-8->-16
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg5-8->-16");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG5);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 2);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], -8);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], -16);
+
+	// Test 8: stack->0->8
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "stack->0->8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_STACK);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 3);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], 0);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[2], 8);
+
+	// Test 9: arg1->+8
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg1->+8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG1);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 2);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], 8);
+
+	// Test 9.1: arg1-> (implicit 0 should fail)
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg1->");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 9.2: stack->->8 (implicit 0 should fail)
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "stack->->8");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 10: Invalid base
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "invalid_base");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 11: Invalid offset
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg1+abc");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 12: Invalid arg
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg7");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 13: Absolute address
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "0xffffffff81000000+8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ABS_ADDR);
+	KUNIT_EXPECT_EQ(test, cfg.sym_addr, 0xffffffff81000000UL);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 8);
+}
+
+static struct kunit_case kwatch_deref_test_cases[] = {
+	KUNIT_CASE(kwatch_test_parse_deref_chain),
+	{}
+};
+
+static struct kunit_suite kwatch_deref_test_suite = {
+	.name = "kwatch_deref",
+	.test_cases = kwatch_deref_test_cases,
+};
+
+kunit_test_suite(kwatch_deref_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the KWatch watch expression parser");
+MODULE_LICENSE("GPL");
-- 
2.53.0

