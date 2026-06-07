Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F42F361E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848893; cv=none; b=b6x3zXa3ksEodkKVmBChsuTcubYuYg1cDM/CMZKySe1a8LALLjHzytrwnWWaM+8fKmOaGVc5jNMrPwKsdvMhBiDx5B1w2XUeeDbtH1nsbvnL3ytalzyAOpktma2rjnel5UXQn5eYitaAnGZ9VgzgoZsktlhHwQ66qk/MSZL7g3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848893; c=relaxed/simple;
	bh=uDHmzMuc9EeJUiWFCx47eHwGQb/D4avyHxAOqpuPbSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GfPU3FtrRG/O75xqDJbwYau98LJMbLstkw/E9ifsYbuEjFL4wn+w5uE4kuFZfAyYYJ/fMlE5PLo6YSlPhR/q7+JtHnBzVWVFneKqbSLlJEcWLDmT29FhUOA3YcVodMRU1YhM1c8qlE5yKdeP8617gulhMf08oBrbq9vZdtijOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lDH6BzZ3; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lDH6BzZ3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZL4FIhbZF8B1wkJw7kqqSZYM2Y1m9D4+G/rHow/qVc=;
	b=lDH6BzZ3vAGtbU1ClmJRcVAsw9UG1lGWJjs3+gbtshpfAtMYVW8xYWs0t25F7jesVsW1pC
	UvVU022QMAarKTzI+JB33eEz4nSGaNYh3xtPVBIeENaLU8DinRVJe8FAv2HwuyCmZ5Z6P2
	t0TmS5TgBqRlF+QB4tP9bvWoIo6UP+o=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 7/9] rv/tlob: add KUnit tests for the tlob monitor
Date: Mon,  8 Jun 2026 00:13:55 +0800
Message-Id: <d9abf11ee0af54689fce87ab95f8e8f7f5eb233d.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add CONFIG_TLOB_KUNIT_TEST (tristate, depends on RV_MON_TLOB && KUNIT,
default KUNIT_ALL_TESTS) with a single test suite covering the uprobe
line parser: valid bindings are accepted, malformed ones return -EINVAL,
and out-of-range thresholds return -ERANGE.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Makefile                   |  1 +
 kernel/trace/rv/monitors/tlob/.kunitconfig |  6 ++
 kernel/trace/rv/monitors/tlob/Kconfig      |  7 ++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c | 92 ++++++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c

diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index ae59e97f8682..316d53398345 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_TLOB) += monitors/tlob/tlob.o
+obj-$(CONFIG_TLOB_KUNIT_TEST) += monitors/tlob/tlob_kunit.o
 # Add new monitors here
 obj-$(CONFIG_RV_UPROBE) += rv_uprobe.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
diff --git a/kernel/trace/rv/monitors/tlob/.kunitconfig b/kernel/trace/rv/monitors/tlob/.kunitconfig
new file mode 100644
index 000000000000..35d313dfc20d
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/.kunitconfig
@@ -0,0 +1,6 @@
+CONFIG_FTRACE=y
+CONFIG_KUNIT=y
+CONFIG_MODULES=y
+CONFIG_RV=y
+CONFIG_RV_MON_TLOB=y
+CONFIG_TLOB_KUNIT_TEST=y
diff --git a/kernel/trace/rv/monitors/tlob/Kconfig b/kernel/trace/rv/monitors/tlob/Kconfig
index b29a375de228..7ec3326640c2 100644
--- a/kernel/trace/rv/monitors/tlob/Kconfig
+++ b/kernel/trace/rv/monitors/tlob/Kconfig
@@ -10,3 +10,10 @@ config RV_MON_TLOB
 	  monitor.  tlob tracks per-task elapsed wall-clock time across a
 	  user-delimited code section and emits error_env_tlob when the
 	  elapsed time exceeds a configurable per-invocation budget.
+
+config TLOB_KUNIT_TEST
+	tristate "KUnit tests for tlob monitor" if !KUNIT_ALL_TESTS
+	depends on RV_MON_TLOB && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit unit tests for the tlob RV monitor.
diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
new file mode 100644
index 000000000000..6450d61b26c3
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the tlob RV monitor.
+ *
+ */
+#include <kunit/test.h>
+
+#include "tlob.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static const char * const tlob_parse_valid[] = {
+	"p /usr/bin/myapp:4768 4848 threshold=5000000",
+	"p /usr/bin/myapp:0x12a0 0x12f0 threshold=10000000",
+	"p /opt/my:app/bin:0x100 0x200 threshold=1000000",
+};
+
+static const char * const tlob_parse_invalid[] = {
+	/* add: malformed */
+	"p :0x100 0x200 threshold=5000",
+	"p /usr/bin/myapp:0x100 threshold=5000",
+	"p /usr/bin/myapp:-1 0x200 threshold=5000",
+	"p /usr/bin/myapp:0x100 0x200",
+	"p /usr/bin/myapp:0x100 0x100 threshold=5000",
+	/* remove: malformed */
+	"-usr/bin/myapp:0x100",
+	"-/usr/bin/myapp",
+	"-/:0x100",
+	"-/usr/bin/myapp:abc",
+};
+
+/* threshold_ns < 1000 or > TLOB_MAX_THRESHOLD_NS return -ERANGE, not -EINVAL. */
+static const char * const tlob_parse_out_of_range[] = {
+	"p /usr/bin/myapp:0x100 0x200 threshold=0",
+	"p /usr/bin/myapp:0x100 0x200 threshold=999",
+	"p /usr/bin/myapp:0x100 0x200 threshold=3600000000001",  /* TLOB_MAX_THRESHOLD_NS + 1 */
+};
+
+/*
+ * Valid add lines return -ENOENT (kern_path() finds no such file in the test
+ * environment) rather than 0; a non-(-EINVAL) return confirms the format was
+ * accepted by the parser.
+ */
+static void tlob_parse_valid_accepted(struct kunit *test)
+{
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_valid); i++) {
+		strscpy(buf, tlob_parse_valid[i], sizeof(buf));
+		KUNIT_EXPECT_NE(test, tlob_create_or_delete_uprobe(buf), -EINVAL);
+	}
+}
+
+static void tlob_parse_invalid_rejected(struct kunit *test)
+{
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_invalid); i++) {
+		strscpy(buf, tlob_parse_invalid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, tlob_create_or_delete_uprobe(buf), -EINVAL);
+	}
+}
+
+static void tlob_parse_out_of_range_rejected(struct kunit *test)
+{
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_out_of_range); i++) {
+		strscpy(buf, tlob_parse_out_of_range[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, tlob_create_or_delete_uprobe(buf), -ERANGE);
+	}
+}
+
+static struct kunit_case tlob_parse_cases[] = {
+	KUNIT_CASE(tlob_parse_valid_accepted),
+	KUNIT_CASE(tlob_parse_invalid_rejected),
+	KUNIT_CASE(tlob_parse_out_of_range_rejected),
+	{}
+};
+
+static struct kunit_suite tlob_parse_suite = {
+	.name       = "tlob_parse",
+	.test_cases = tlob_parse_cases,
+};
+
+kunit_test_suite(tlob_parse_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the tlob RV monitor");
+MODULE_LICENSE("GPL");
-- 
2.43.0

