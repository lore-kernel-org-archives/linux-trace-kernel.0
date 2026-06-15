Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D640F8E9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541927; cv=none; b=enXEq+K6SLL93mqEXtG2+DiNIrub/eoGQf1DzoxP/1hGhw+Tnm/5TumX+mpKo/JXoTzCDrIbMQveDRMiJ6b3sjjfHqF+PRxgUXKaaYaU5bWwqygr50o3Cn+XePx3Oij6SKRmvXLjbnlGnOIX0GSv+btiQzk1OV6g1BNLot74evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541927; c=relaxed/simple;
	bh=qKWnneKAtGUoeRmEMUOeFKJHRf+QxxhOhN416oe9nvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXg0cnysxpbHP3xJ0k5cDnH0bjoMb0lkW4/EyoVIFX/MA33o3DBapzJqeykaauK240VrPjUDZPMYtGjSZaNXYSHCpXawheMQYvkDHkh5hvvll82Lb4TUetajFu9zYEt50UW0yXlOpOUW94gac46F+cw+yCYsqqpLV535BFpWeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JKGe7q5h; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JKGe7q5h"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781541923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CyGz3TR9s7ubrGHuzXBTbIIWmicxQdnFDKpHFKj+eA=;
	b=JKGe7q5hIaH7Dq/yc+I9PUWLpcXlw+ZiU3xXeyriMrNFXQfX2TRe89JFRkU2LnMghdRTIH
	pxnHqIkrR7M5wBymc4u/QIqHk470ODGrX1eTT6b5/5DB0ylbH7kKpVUzXEPsif7dXm35cX
	/NxEG8QRPNL9akz5HI4Zi4abJT+eNQM=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 3/3] rv/reactors: add KUnit tests for reactor_panic
Date: Tue, 16 Jun 2026 00:44:50 +0800
Message-Id: <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
In-Reply-To: <cover.1781541556.git.wen.yang@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add KUnit tests for the panic reactor covering:
- Reactor registration and unregistration lifecycle
- Panic notifier chain reachability

The real rv_panic_reaction() calls vpanic(), which is __noreturn and
halts the system. KUnit cannot test across that boundary. Instead, the
test drives atomic_notifier_call_chain(&panic_notifier_list, ...) directly
with a high-priority mock notifier that returns NOTIFY_STOP, verifying
that the panic notification propagates without triggering real handlers
(kdump, watchdog, reboot).

The mock notifier busy-waits to simulate real handler execution time
(e.g., crash_save_vmcoreinfo, emergency_restart preamble) under the
panic context constraints.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Kconfig               |  10 +++
 kernel/trace/rv/Makefile              |   1 +
 kernel/trace/rv/reactor_panic_kunit.c | 106 ++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 kernel/trace/rv/reactor_panic_kunit.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index ff47895c897f..6c6c43c5f86c 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -121,3 +121,13 @@ config RV_REACT_PANIC
 	help
 	  Enables the panic reactor. The panic reactor emits a printk()
 	  message if an exception is found and panic()s the system.
+
+config RV_REACT_PANIC_KUNIT
+	bool "KUnit tests for reactor_panic" if !KUNIT_ALL_TESTS
+	depends on RV_REACT_PANIC && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for the panic reactor. These are only
+	  for development and testing, not for regular kernel use cases.
+
+	  If unsure, say N.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index ef0a2dcb927c..2ebfe5e5068c 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PRINTK_KUNIT) += reactor_printk_kunit.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
+obj-$(CONFIG_RV_REACT_PANIC_KUNIT) += reactor_panic_kunit.o
diff --git a/kernel/trace/rv/reactor_panic_kunit.c b/kernel/trace/rv/reactor_panic_kunit.c
new file mode 100644
index 000000000000..f9a09ae7aaad
--- /dev/null
+++ b/kernel/trace/rv/reactor_panic_kunit.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for reactor_panic
+ *
+ */
+
+#include <kunit/test.h>
+#include <linux/rv.h>
+#include <linux/panic_notifier.h>
+#include <linux/notifier.h>
+#include <linux/limits.h>
+#include <linux/sched/clock.h>
+#include <linux/processor.h>
+
+/* Simulated execution time for mock panic notifier (nanoseconds). */
+#define RV_PANIC_NOTIFIER_EXEC_NS	2000000ULL
+
+/* Test state */
+static struct {
+	bool notifier_called;
+} panic_test_state;
+
+/*
+ * Mock panic notifier callback.
+ *
+ * Runs at INT_MAX priority and returns NOTIFY_STOP to prevent real panic
+ * handlers (kdump, watchdog) from executing during the test.  Busy-waits
+ * RV_PANIC_NOTIFIER_EXEC_NS to simulate a real handler's execution time.
+ */
+static int mock_panic_notifier_fn(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	char *msg = data;
+	u64 start = sched_clock();
+
+	panic_test_state.notifier_called = true;
+	pr_emerg("KUnit: reactor_panic test intercepted panic notifier: %s\n",
+		 msg ? msg : "(no message)");
+
+	while (sched_clock() - start < RV_PANIC_NOTIFIER_EXEC_NS)
+		cpu_relax();
+
+	return NOTIFY_STOP;
+}
+
+static struct notifier_block mock_panic_nb = {
+	.notifier_call	= mock_panic_notifier_fn,
+	.priority	= INT_MAX,
+};
+
+static struct rv_reactor mock_panic_reactor = {
+	.name		= "test_panic",
+	.description	= "test panic reactor",
+};
+
+static int reactor_panic_kunit_init(struct kunit *test)
+{
+	panic_test_state.notifier_called = false;
+	return 0;
+}
+
+/* Test 1: register and unregister reactor */
+static void test_panic_register_unregister(struct kunit *test)
+{
+	int ret;
+
+	ret = rv_register_reactor(&mock_panic_reactor);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_STREQ(test, mock_panic_reactor.name, "test_panic");
+
+	rv_unregister_reactor(&mock_panic_reactor);
+}
+
+/*
+ * Test 2: panic notifier chain is reachable.
+ *
+ * vpanic() calls atomic_notifier_call_chain(&panic_notifier_list, ...).
+ * Drive the chain directly to verify panic notifiers receive the notification —
+ * the observable side-effect of reactor_panic without halting the system.
+ */
+static void test_panic_notifier_called(struct kunit *test)
+{
+	atomic_notifier_chain_register(&panic_notifier_list, &mock_panic_nb);
+	atomic_notifier_call_chain(&panic_notifier_list, 0,
+				   "panic violation message");
+	atomic_notifier_chain_unregister(&panic_notifier_list, &mock_panic_nb);
+
+	KUNIT_EXPECT_TRUE(test, panic_test_state.notifier_called);
+}
+
+static struct kunit_case reactor_panic_kunit_cases[] = {
+	KUNIT_CASE(test_panic_register_unregister),
+	KUNIT_CASE(test_panic_notifier_called),
+	{}
+};
+
+static struct kunit_suite reactor_panic_kunit_suite = {
+	.name		= "rv_reactor_panic",
+	.init		= reactor_panic_kunit_init,
+	.test_cases	= reactor_panic_kunit_cases,
+};
+
+kunit_test_suite(reactor_panic_kunit_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for reactor_panic");
-- 
2.25.1

