Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F663B2FC7
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295483; cv=none; b=umJQ3+qzQkc4565jdTYdr29t1ODP+G6bzWS8D+1yY9ZIsw1leR1pUKXSMKPLgj/TewywXDguA8tTgo963xcpSOwqaK84j8HYKzJY5ToP7hHLrjqmcLmi4FLNIhC9gz+Dq6+xpO0oCcUPpi+j9N533bZFwkIBMDAv2/PDJiku4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295483; c=relaxed/simple;
	bh=wnquJR+5vXNgOlT7/7bQkGGxiSmrctDirKmYq0iJow8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doKnjTNWs/sJi0msH3NBnAjhtdzkqzPwNAzr34JCRtCf6ijZmWxgU2Wba4oOsIZQ/m1m73L5+tWfC9uBogMcpRWHTtx9a2AgWMV2JkI02A/QJ1UgGnnexk4YAUcLwQjHxpsaSwbtZMg8gxaQ9GQC7Dd2BTM2XJVKDqH9oLQ2Ozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j3K4Yu6E; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j3K4Yu6E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786295478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn5zEW2hyaObBuC/eUmpPRrpZwxqCcMW2x2qCB2BR+o=;
	b=j3K4Yu6EgBwq3p4CRaweh3UjZHQbG1GqBbAm+fqnmRUhpWUB3ouoV6oiLEOaD5QWws7Rub
	r8A1nKW4OcfXsJSYpZhx6Kpcw1fZt8Ow8c1XEbev0gGTbQmNedsdINnLxrBP79lTfoaUQu
	+PQ8JsGVWCn4ggAdMfgFP5+y36DZoMM=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 4/4] rv/reactors: add KUnit tests for reactor registration and dispatch
Date: Mon, 10 Aug 2026 01:10:41 +0800
Message-Id: <2b91af9f6d045f7fdb8620ef5c66c3b3e189833b.1786294920.git.wen.yang@linux.dev>
In-Reply-To: <cover.1786294920.git.wen.yang@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add KUnit tests covering the reactor register/unregister lifecycle
(including duplicate and name-length rejection) and rv_react() dispatch
(a no-op without a callback, exactly one invocation with one; the mdelay
callback keeps the CPU busy so a timer interrupt exercises the LD_WAIT_SPIN
lockdep context).  The Kconfig entry is tristate so the tests can be built
as a module when CONFIG_KUNIT=m; only RV_REACTORS is required.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Kconfig             |  12 +++
 kernel/trace/rv/Makefile            |   1 +
 kernel/trace/rv/rv_reactors_kunit.c | 119 ++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
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
index 000000000000..d5b731eb11f3
--- /dev/null
+++ b/kernel/trace/rv/rv_reactors_kunit.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for RV reactor registration and dispatch.
+ */
+
+#include <kunit/test.h>
+#include <linux/rv.h>
+#include <linux/delay.h>
+#include <linux/atomic.h>
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
+/*
+ * Use a fixed-size array so sizeof() gives the exact byte count at
+ * compile time.
+ */
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
+static atomic_t react_call_count;
+
+__printf(1, 0) static void mock_react(const char *msg, va_list args)
+{
+	atomic_inc(&react_call_count);
+	/*
+	 * Hold the CPU for 5 ms so a timer interrupt is likely to fire
+	 * inside rv_react()'s lockdep context, exercising the LD_WAIT_SPIN
+	 * constraint.  mdelay() is a calibrated busy-wait with no scheduler
+	 * interaction.
+	 */
+	mdelay(5);
+}
+
+static void test_react_no_callback(struct kunit *test)
+{
+	struct rv_monitor monitor = {
+		.name = "kunit_null_react",
+	};
+
+	atomic_set(&react_call_count, 0);
+	rv_react(&monitor, "no callback");
+
+	/*
+	 * The only possible failure in this test case is a kernel panic.
+	 * NULL react guard: callback must NOT have been invoked
+	 */
+	KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 0);
+}
+
+static void test_react_callback_invoked(struct kunit *test)
+{
+	struct rv_monitor monitor = {
+		.name	= "kunit_dispatch_monitor",
+		.react	= mock_react,
+	};
+
+	atomic_set(&react_call_count, 0);
+	rv_react(&monitor, "callback invocation test");
+	KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 1);
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

