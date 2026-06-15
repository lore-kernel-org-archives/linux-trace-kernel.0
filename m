Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C540F8D6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541921; cv=none; b=uNq9MhTNPQQk6lExazkmDA0iL0F3jbP0EL8qs1fcRFN2IQuA2g3/kYL/1NnRslV1DB/pryimNUNQC0APhsrKjW8Ew7JhoTNQqkq3pZtnZ/qLDPInxHgYyCcjnzAOdiAzGWsH1OetgVaGXsSZ6n7oCnnBlsfZf5BIjXzXCbNh/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541921; c=relaxed/simple;
	bh=+p8IjXbhtjWx4HFk1LbKVGWPXEj8HoiuSdKnLmAT3C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5qH6kMSEdjH5CfR3BgCSO1M8bvuUuVF+gNrPO4Daof1iQinlN93mFTnSW8qpNXq3BmPGB2sDFGFePZGxl13K33R2XXU0IxZYcJHr+VyWgkugGg+ibZ1NYKsRMXDOTuCUcyQleArgjBJuPDcl8+3D/JivdfskMdbz7/Ge51J/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CZEoIYNK; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CZEoIYNK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781541918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqKj/DZetx58E2mnFHrT1q02Uk1HFvsLwQv5HZPEoK4=;
	b=CZEoIYNKU7UgFnFrqEwl1o4FsiQ5IUv1CSfjBxxHUy5QBv09PAviH1wYrkhBqxxS6EvNel
	9QKHIPvGatMXWs0e6stV7pgC/334Qz8DfwDVzt1VB9b032xkotz8QVAAWGcc4qPN7Zjciw
	AoE2n1TA3cOadNENHOipdquErCGuin4=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 2/3] rv/reactors: add KUnit tests for reactor_printk
Date: Tue, 16 Jun 2026 00:44:49 +0800
Message-Id: <690593305ad075539a804e0bf94493335354e6b9.1781541556.git.wen.yang@linux.dev>
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

Add KUnit tests for the printk reactor covering:
- Reactor registration and unregistration lifecycle
- React callback invocation via rv_react()
- Double registration rejection
- Multiple register/unregister cycles

The mock callback calls vprintk_deferred() — the same path as the real
reactor — then busy-waits to simulate I/O back-pressure, exercising the
LD_WAIT_FREE constraint of rv_react() under load.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Kconfig                |  10 ++
 kernel/trace/rv/Makefile               |   1 +
 kernel/trace/rv/reactor_printk_kunit.c | 123 +++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 kernel/trace/rv/reactor_printk_kunit.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..ff47895c897f 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -104,6 +104,16 @@ config RV_REACT_PRINTK
 	  Enables the printk reactor. The printk reactor emits a printk()
 	  message if an exception is found.
 
+config RV_REACT_PRINTK_KUNIT
+	bool "KUnit tests for reactor_printk" if !KUNIT_ALL_TESTS
+	depends on RV_REACT_PRINTK && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for the printk reactor. These are only
+	  for development and testing, not for regular kernel use cases.
+
+	  If unsure, say N.
+
 config RV_REACT_PANIC
 	bool "Panic reactor"
 	depends on RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 94498da35b37..ef0a2dcb927c 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -23,4 +23,5 @@ obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
+obj-$(CONFIG_RV_REACT_PRINTK_KUNIT) += reactor_printk_kunit.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
diff --git a/kernel/trace/rv/reactor_printk_kunit.c b/kernel/trace/rv/reactor_printk_kunit.c
new file mode 100644
index 000000000000..933aa5602226
--- /dev/null
+++ b/kernel/trace/rv/reactor_printk_kunit.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for reactor_printk
+ *
+ */
+
+#include <kunit/test.h>
+#include <linux/rv.h>
+#include <linux/printk.h>
+#include <linux/sched/clock.h>
+#include <linux/processor.h>
+
+/*
+ * Simulated execution time for mock_printk_react (sched_clock units,
+ * nanoseconds).  Models the time a real printk reactor callback may consume
+ * under I/O pressure, exercising the LD_WAIT_FREE constraint of rv_react().
+ */
+#define MOCK_REACT_DURATION_NS	5000000ULL
+
+/*
+ * Mock react callback mirroring rv_printk_reaction().
+ *
+ * Calls vprintk_deferred() — the same path as the real reactor — then holds
+ * the CPU for MOCK_REACT_DURATION_NS via a sched_clock() timed busy-loop,
+ * simulating a callback that is slow due to I/O back-pressure.
+ * sched_clock() is notrace and lock-free; no sleep or lock acquisition is
+ * performed, satisfying the LD_WAIT_FREE constraint of rv_react().
+ */
+__printf(1, 0) static void mock_printk_react(const char *msg, va_list args)
+{
+	u64 start = sched_clock();
+
+	vprintk_deferred(msg, args);
+
+	while (sched_clock() - start < MOCK_REACT_DURATION_NS)
+		cpu_relax();
+}
+
+static struct rv_reactor mock_printk_reactor = {
+	.name		= "test_printk",
+	.description	= "test printk reactor",
+	.react		= mock_printk_react,
+};
+
+/* Test 1: register and unregister reactor */
+static void test_printk_register_unregister(struct kunit *test)
+{
+	int ret;
+
+	ret = rv_register_reactor(&mock_printk_reactor);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_STREQ(test, mock_printk_reactor.name, "test_printk");
+
+	rv_unregister_reactor(&mock_printk_reactor);
+}
+
+/* Test 2: react callback is invoked via rv_react() */
+static void test_printk_react_called(struct kunit *test)
+{
+	struct rv_reactor reactor = {
+		.name	= "printk_cb_test",
+		.react	= mock_printk_react,
+	};
+	struct rv_monitor monitor = {
+		.name	= "test_monitor",
+		.reactor = &reactor,
+		.react	= mock_printk_react,
+	};
+
+	rv_react(&monitor, "printk violation message");
+}
+
+/* Test 3: double registration should fail */
+static void test_printk_double_register(struct kunit *test)
+{
+	int ret;
+
+	ret = rv_register_reactor(&mock_printk_reactor);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = rv_register_reactor(&mock_printk_reactor);
+	KUNIT_EXPECT_NE(test, ret, 0);
+
+	rv_unregister_reactor(&mock_printk_reactor);
+}
+
+/* Test 4: register/unregister cycle */
+static void test_printk_register_cycle(struct kunit *test)
+{
+	int ret, i;
+
+	for (i = 0; i < 5; i++) {
+		ret = rv_register_reactor(&mock_printk_reactor);
+		KUNIT_EXPECT_EQ(test, ret, 0);
+
+		rv_unregister_reactor(&mock_printk_reactor);
+	}
+}
+
+/* Test 5: react callback is not NULL (printk reactors must provide react) */
+static void test_printk_react_not_null(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_NULL(test, mock_printk_reactor.react);
+}
+
+static struct kunit_case reactor_printk_kunit_cases[] = {
+	KUNIT_CASE(test_printk_register_unregister),
+	KUNIT_CASE(test_printk_react_called),
+	KUNIT_CASE(test_printk_double_register),
+	KUNIT_CASE(test_printk_register_cycle),
+	KUNIT_CASE(test_printk_react_not_null),
+	{}
+};
+
+static struct kunit_suite reactor_printk_kunit_suite = {
+	.name		= "rv_reactor_printk",
+	.test_cases	= reactor_printk_kunit_cases,
+};
+
+kunit_test_suite(reactor_printk_kunit_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for reactor_printk");
-- 
2.25.1

