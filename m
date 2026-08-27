Received: from mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A96499F32
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855000; cv=none; b=kF6C/HkcFsneOrokb+W8p4qf7sIzEW7EB3RxbAG2cwIHX2YwkKJoi6dXLQ+dfw/6pMlWf3OlDGYuNsqAbUj8gXU+9YwvLX9P/qX1QmQ7Dx5GBJyZlGZ9AX1J0gp8pyNKnr+a8Gc5TIvDVQYDHVHfyY9wfbSdJ187csBuzXJoVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855000; c=relaxed/simple;
	bh=oHPCXF7JgvUkyyf6uF5a4JEpbpTZhJHx4pcplb6yknc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIe3HJG2wQkk0gsE+O0BCAXi48VAMV9x7kAvsvxqytYRK4NZaAvoWl7YAwEWJarRIbKEhhZm2HiSJ6OmZaG+F/h0b7/s/XVURsSaW9RoA6xpDYlMDsXMjEINukcmGD7KL1pOAnyeQ964+0MRrI6geGQsiZOX6hXZRH3QzABnKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ubwIX/lf; arc=none smtp.client-ip=95.215.58.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ubwIX/lf"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oHPCXF7JgvUkyyf6uF5a4JEpbpTZhJHx4pcplb6yknc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787854995; v=1; x=1788459795;
 b=ubwIX/lfFf3lwnFe0Vf42r7nC361NNnzdBWeorpeKr84tg+g5g2Ou9MbABQsSgl0Ps/4n91y
 BgQLheuPh/0bxOSv9uhRvVOf89qshpfIhbl7bGW/Z1CBUYfZ/rtWYpqFr4iOGI5c35t1gHVg6jv
 Qol+eJdC9YgLoho3sjzqznQ8=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 28f2f9d6a0f5d900;
	Thu, 27 Aug 2026 18:23:15 +0000
X-Mizu-Trace-ID: 28f2f9d6a0f5d900
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 4/4] rv/reactors: add KUnit tests for reactor registration and dispatch
Date: Fri, 28 Aug 2026 02:22:46 +0800
Message-Id: <ab4e483f66a7297fb5b9c247964051a7de4a7ab7.1787854397.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787854397.git.wen.yang@linux.dev>
References: <cover.1787854397.git.wen.yang@linux.dev>
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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Kconfig             |  12 ++++
 kernel/trace/rv/Makefile            |   1 +
 kernel/trace/rv/rv_reactors_kunit.c | 105 ++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
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
index 000000000000..2ccbe55ce408
--- /dev/null
+++ b/kernel/trace/rv/rv_reactors_kunit.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for RV reactor registration and dispatch.
+ */
+
+#include <kunit/test.h>
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
+_Static_assert(sizeof(long_reactor_name) - 1 >= MAX_RV_REACTOR_NAME_SIZE,
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
+	mdelay(5);
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

