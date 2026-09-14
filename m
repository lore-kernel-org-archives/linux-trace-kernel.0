Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090652EC0A4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413253; cv=none; b=Mu0stuzrX8MLwYkvi9Hfyeh8kRsTH29onU1WluMKsF4i75vC9lnEvtsprEtgaq1FSlLmuEIclbodaYUBCgO7KLyeLCxolPc5SD2LwKibdHBuyX9/e6ZbQB69eGWFaT6I3J8h4vCWPqVrhlw+GWG7lNmRVqLfDZjk40dKwr5TxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413253; c=relaxed/simple;
	bh=E5rD+GC6hBExNZ+C0zpz9VB7RMnNCVhPsy+cbEyF7II=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcIB/KTRqWgAM0j/lXoMbQD2entFure0zLCQU3CaJT/v+5Kv0KIZRD3MVBQTQvqrv8gp6nw1YegsEdKawNzcRyktNdeXeHVhUxWmCufRfkCYTh7hZXLY3+liQ2axJiqiVL8ZOF1NioLew6cQFfG9K5QfTREhQvn2qTLWAMJkzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L6DoL0Vj; arc=none smtp.client-ip=91.218.175.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L6DoL0Vj"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E5rD+GC6hBExNZ+C0zpz9VB7RMnNCVhPsy+cbEyF7II=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789413244; v=1; x=1790018044;
 b=L6DoL0VjSHJapG1NLQ9mH2HPHE4+ogacHPTDmxAUULhBrwL8lARPy/X31kC+Sb2gPOQZjFxi
 Suodqrbvhzjow5Rpcr7ZIntSVkrml2f0ZcIRyNbvLar5/TcygyirmglubDKatJvnLdlTZjBQaVp
 6Jth1DiSh0TvngOslX7tvzQA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7dd95a410480780c;
	Mon, 14 Sep 2026 19:14:04 +0000
X-Mizu-Trace-ID: 7dd95a410480780c
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 4/4] rv/reactors: add KUnit tests for reactor registration and dispatch
Date: Tue, 15 Sep 2026 03:13:37 +0800
Message-Id: <7d213b110815da45595ad8cd7bcce5641fac3404.1789412799.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1789412799.git.wen.yang@linux.dev>
References: <cover.1789412799.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add KUnit tests covering the reactor register/unregister lifecycle
(including duplicate and name-length rejection) and rv_react() dispatch
(a no-op without a callback, exactly one invocation with one).  The
mdelay() callback keeps the CPU busy so a timer interrupt lands inside
rv_react()'s lockdep context, exercising the LD_WAIT_SPIN wait type
from the previous patch; a spurious lockdep splat there would show up
in the test output.

The dispatch tests rely on reacting_on being enabled, since rv_react()
returns early when it is off.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Kconfig             |  12 +++
 kernel/trace/rv/Makefile            |   1 +
 kernel/trace/rv/rv_reactors_kunit.c | 111 ++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 kernel/trace/rv/rv_reactors_kunit.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index efa930f94ea4..9bfd429ffdea 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -113,6 +113,18 @@ config RV_REACT_PANIC
 	  Enables the panic reactor. The panic reactor emits a printk()
 	  message if an exception is found and panic()s the system.
 
+config RV_REACTORS_KUNIT
+	tristate "KUnit tests for RV reactors" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on RV_REACTORS
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for RV reactor registration and dispatch.
+	  These tests verify the register/unregister lifecycle, duplicate
+	  rejection, and that rv_react() correctly invokes callbacks.
+
+	  If unsure, say N.
+
 config RV_MONITORS_KUNIT_TEST
 	tristate "KUnit tests for RV monitors" if !KUNIT_ALL_TESTS
 	depends on KUNIT && RV && RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index cdbf68c84f5a..c895d81dfdad 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -25,4 +25,5 @@ obj-$(CONFIG_RV_MON_WAKEUP) += monitors/wakeup/wakeup.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
+obj-$(CONFIG_RV_REACTORS_KUNIT) += rv_reactors_kunit.o
 obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
diff --git a/kernel/trace/rv/rv_reactors_kunit.c b/kernel/trace/rv/rv_reactors_kunit.c
new file mode 100644
index 000000000000..3850c6dda288
--- /dev/null
+++ b/kernel/trace/rv/rv_reactors_kunit.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for RV reactor registration and dispatch.
+ *
+ * The dispatch tests rely on reacting_on being enabled, since rv_react()
+ * returns early when it is off. It is on by default when the suites run
+ * built-in; as a module, re-enable it if disabled via
+ * /sys/kernel/tracing/rv/reacting_on.
+ */
+
+#include <kunit/test.h>
+#include <linux/build_bug.h>
+#include <linux/rv.h>
+#include <linux/delay.h>
+#include "rv.h"
+
+static struct rv_reactor test_reactor = {
+	.name		= "kunit_test_reactor",
+	.description	= "KUnit test reactor",
+};
+
+static void reactor_teardown(void *arg)
+{
+	rv_unregister_reactor(&test_reactor);
+}
+
+static void register_test_reactor(struct kunit *test)
+{
+	KUNIT_ASSERT_EQ(test, rv_register_reactor(&test_reactor), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, reactor_teardown, NULL), 0);
+}
+
+static void test_double_register(struct kunit *test)
+{
+	register_test_reactor(test);
+	KUNIT_EXPECT_EQ(test, rv_register_reactor(&test_reactor), -EINVAL);
+}
+
+static const char long_reactor_name[] = "kunit_reactor_name_too_long_xxx_";
+static_assert(sizeof(long_reactor_name) - 1 >= MAX_RV_REACTOR_NAME_SIZE,
+	       "long_reactor_name must be at least MAX_RV_REACTOR_NAME_SIZE chars");
+
+static void test_name_too_long(struct kunit *test)
+{
+	static struct rv_reactor long_reactor = {
+		.name = long_reactor_name,
+	};
+
+	KUNIT_EXPECT_EQ(test, rv_register_reactor(&long_reactor), -EINVAL);
+}
+
+static struct kunit_case rv_reactor_registration_cases[] = {
+	KUNIT_CASE(test_double_register),
+	KUNIT_CASE(test_name_too_long),
+	{}
+};
+
+static struct kunit_suite rv_reactor_registration_suite = {
+	.name		= "rv_reactor_registration",
+	.test_cases	= rv_reactor_registration_cases,
+};
+
+static int react_call_count;
+
+__printf(1, 0) static void mock_react(const char *msg, va_list args)
+{
+	react_call_count++;
+	/* Busy-wait so a timer interrupt fires inside rv_react(). */
+	mdelay(20);
+}
+
+static void test_react_no_callback(struct kunit *test)
+{
+	struct rv_monitor monitor = {
+		.name = "kunit_null_react",
+	};
+
+	react_call_count = 0;
+	rv_react(&monitor, "no callback");
+
+	KUNIT_EXPECT_EQ(test, react_call_count, 0);
+}
+
+static void test_react_callback_invoked(struct kunit *test)
+{
+	struct rv_monitor monitor = {
+		.name	= "kunit_dispatch_monitor",
+		.react	= mock_react,
+	};
+
+	react_call_count = 0;
+	rv_react(&monitor, "callback invocation test");
+	KUNIT_EXPECT_EQ(test, react_call_count, 1);
+}
+
+static struct kunit_case rv_react_dispatch_cases[] = {
+	KUNIT_CASE(test_react_no_callback),
+	KUNIT_CASE(test_react_callback_invoked),
+	{}
+};
+
+static struct kunit_suite rv_react_dispatch_suite = {
+	.name		= "rv_react_dispatch",
+	.test_cases	= rv_react_dispatch_cases,
+};
+
+kunit_test_suites(&rv_reactor_registration_suite, &rv_react_dispatch_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for RV reactor registration and dispatch");
-- 
2.25.1

