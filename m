Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5091D327C09
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Aug 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696224; cv=none; b=RsK9/HVP8TtT8p4Us1EU8hTzTvJb51CuVSf7q5eHwzedmZGAwqx8abmGTfYoTbBOVonoyB5WlIaavPv874LsttHPWRDkObk+fsYRfl5C5EOMX9DkYVbE42lQJYyuTkkBadMzL1mOB4AKWCH+yw2cv00KkEJv6BhVtj69wgkMTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696224; c=relaxed/simple;
	bh=tFnmduTwKi8rKfeOua0RpyVuiF3l2Poer9y6mqarLng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+Z7M+yW7OyxI+4mchXjflsIfxJtrn6TKi1IgvVgPhV/Y4DIYb/xiz4QSHRSropFPmGMnPtqbIR7QjjgC35oFGviPRVMDD8pXQXqXEUOV3n/w1jI8yBac3D/w52ZpqlbDScwZ3z/fVY7q+J5Joe4aDJYnnRtn29GyKHcPclzDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N8YADW4I; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N8YADW4I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785696219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3ZsGVsjxs1arltMdkzF3yJ+/NF4RzrrXWmF0vxUiwo=;
	b=N8YADW4I+Rd3ESZoGCQnCn9dymAsAJa+KhJSoMYjq1od2Q6u0AHL1BlHA+W5TZ5SEqF+nY
	/fKR00ojvgJ8fJD076FMixaftu07uvBW9gbj76AoGOseMzgYdZ2TGN1tSvBKi0Kmb8MaiO
	lWaa+uhJ0N8TcgvFk+Rmc+xjDY5nZoc=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 4/4] rv/reactors: add KUnit tests for reactor registration and dispatch
Date: Mon,  3 Aug 2026 02:43:05 +0800
Message-Id: <55a167aacaf1497fafbbe9fd578ffe14cbee368f.1785695669.git.wen.yang@linux.dev>
In-Reply-To: <cover.1785695669.git.wen.yang@linux.dev>
References: <cover.1785695669.git.wen.yang@linux.dev>
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

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Kconfig             |  12 +++
 kernel/trace/rv/Makefile            |   1 +
 kernel/trace/rv/rv_reactors_kunit.c | 143 ++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
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
index 000000000000..32c25dcf0cb6
--- /dev/null
+++ b/kernel/trace/rv/rv_reactors_kunit.c
@@ -0,0 +1,143 @@
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
+/*
+ * rv_unregister_reactor() on a reactor that was never registered would
+ * list_del() an uninitialized list_head, so track registration and only
+ * unregister in the teardown if it is still on the list.
+ */
+static bool test_reactor_registered;
+
+static int unregister_test_reactor(void)
+{
+	int ret = 0;
+
+	if (test_reactor_registered) {
+		ret = rv_unregister_reactor(&test_reactor);
+		test_reactor_registered = false;
+	}
+
+	return ret;
+}
+
+/*
+ * The teardown action guarantees the reactor is unregistered even if a
+ * test fails mid-way, so a leftover entry cannot corrupt later tests.
+ */
+static void reactor_teardown(void *arg)
+{
+	unregister_test_reactor();
+}
+
+static void register_test_reactor(struct kunit *test)
+{
+	KUNIT_ASSERT_EQ(test, rv_register_reactor(&test_reactor), 0);
+	test_reactor_registered = true;
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, reactor_teardown, NULL), 0);
+}
+
+static void test_register_unregister(struct kunit *test)
+{
+	register_test_reactor(test);
+
+	KUNIT_EXPECT_EQ(test, unregister_test_reactor(), 0);
+}
+
+static void test_double_register(struct kunit *test)
+{
+	register_test_reactor(test);
+
+	KUNIT_EXPECT_EQ(test, rv_register_reactor(&test_reactor), -EINVAL);
+
+	KUNIT_EXPECT_EQ(test, unregister_test_reactor(), 0);
+}
+
+static void test_name_too_long(struct kunit *test)
+{
+	/* Name length of MAX_RV_REACTOR_NAME_SIZE (32) must be rejected. */
+	static struct rv_reactor long_reactor = {
+		.name = "kunit_reactor_name_too_long_xxx_",
+	};
+
+	KUNIT_ASSERT_EQ(test, (int)strlen(long_reactor.name),
+			MAX_RV_REACTOR_NAME_SIZE);
+	KUNIT_EXPECT_EQ(test, rv_register_reactor(&long_reactor), -EINVAL);
+}
+
+static struct kunit_case rv_reactor_registration_cases[] = {
+	KUNIT_CASE(test_register_unregister),
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
+	/* rv_react() must silently return when monitor->react is NULL. */
+	rv_react(&monitor, "no callback");
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

