Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0F4C77B8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163379; cv=none; b=a85cAPAsAmId7adUVJhIMMtirUO2XzjCIl51C8i72xf9r56mKNlpXxR/NjEwc5Gr9g7lwprfbFfUQZAOZD94FPA2MKM9zuLP8ao0qTHYtcbKWhS4WUbMl6eNaUbZOvCznn2/RimbNnYgQzKYicE/YwQ/o+V6R5/dgfrrqSlBOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163379; c=relaxed/simple;
	bh=wTwiVZ3zJCxSIFHUWcm86v0p6/CcYclhFzCJcamTHfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnZ9g5eeeLgcH+KWqW+hPPIpsy0aPU7nEWWDXfR8TaiUqtmD/OAkrHhrYn7vqw61h3A4nlsCB0qux8WsByYx8gVXbsHqP+t7svGP2eehajoRoWJ+Xmf8JAExTgroUyp5xHZ7w9THsUpkmlJZC78f11vRra1xppfchVbnUO2Ltrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLAjnvDs; arc=none smtp.client-ip=91.218.175.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLAjnvDs"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wTwiVZ3zJCxSIFHUWcm86v0p6/CcYclhFzCJcamTHfc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163371; v=1; x=1787768171;
 b=PLAjnvDsHuGrWJvfmUKXI1XhrnB6mbKpfUDvzKJwjgHJQ83fvUbjHsN2nBVU7uLn0//a+2Ei
 hEnMwZQrrJY4+misd/FuaaDBgmyHONMah83yyfRb6ACW/jod3RNgp8Ky/UpJlj8brQwWe0pMePk
 ejRNxDVoTlfGnsjedDIL+7AI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (180.165.15.98)
	by mta12.migadu.com with ESMTPS id 2a73da8f1c798b73;
	Wed, 19 Aug 2026 18:16:11 +0000
X-Mizu-Trace-ID: 2a73da8f1c798b73
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 7/9] rv: Add KUnit tests for the tlob monitor
Date: Thu, 20 Aug 2026 02:15:24 +0800
Message-Id: <31b0f05cbbb4859b510e247687e467bf2096b4f6.1787161646.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add CONFIG_TLOB_KUNIT_TEST (tristate, depends on RV_MON_TLOB && KUNIT,
default KUNIT_ALL_TESTS) with a test suite covering the uprobe-line
parser.

Tests call tlob_parse_uprobe_line() and tlob_parse_remove_line()
directly rather than going through the top-level write handler.
Mark both functions VISIBLE_IF_KUNIT and export with
EXPORT_SYMBOL_IF_KUNIT.  Update the IS_ENABLED guard in tlob.h to use
CONFIG_TLOB_KUNIT_TEST instead of CONFIG_KUNIT.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Makefile                   |   1 +
 kernel/trace/rv/monitors/tlob/.kunitconfig |   5 +
 kernel/trace/rv/monitors/tlob/Kconfig      |  10 ++
 kernel/trace/rv/monitors/tlob/tlob.c       |   6 +-
 kernel/trace/rv/monitors/tlob/tlob.h       |   6 +
 kernel/trace/rv/monitors/tlob/tlob_kunit.c | 139 +++++++++++++++++++++
 6 files changed, 165 insertions(+), 2 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c

diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index cd0ec11f0e05..92a04367ce93 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_WAKEUP) += monitors/wakeup/wakeup.o
 obj-$(CONFIG_RV_MON_TLOB) += monitors/tlob/tlob.o
+obj-$(CONFIG_TLOB_KUNIT_TEST) += monitors/tlob/tlob_kunit.o
 # Add new monitors here
 obj-$(CONFIG_RV_UPROBE) += rv_uprobe.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
diff --git a/kernel/trace/rv/monitors/tlob/.kunitconfig b/kernel/trace/rv/monitors/tlob/.kunitconfig
new file mode 100644
index 000000000000..82a6f121016e
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_UPROBES=y
+CONFIG_RV=y
+CONFIG_RV_MON_TLOB=y
+CONFIG_TLOB_KUNIT_TEST=y
diff --git a/kernel/trace/rv/monitors/tlob/Kconfig b/kernel/trace/rv/monitors/tlob/Kconfig
index aa43382073d2..f4fce35d38fb 100644
--- a/kernel/trace/rv/monitors/tlob/Kconfig
+++ b/kernel/trace/rv/monitors/tlob/Kconfig
@@ -10,3 +10,13 @@ config RV_MON_TLOB
 	  monitor.  tlob tracks per-task elapsed wall-clock time across a
 	  user-delimited code section and emits error_env_tlob when the
 	  elapsed time exceeds a configurable per-invocation budget.
+
+config TLOB_KUNIT_TEST
+	tristate "KUnit tests for tlob monitor" if !KUNIT_ALL_TESTS
+	depends on RV_MON_TLOB && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit unit tests for the tlob RV monitor.  The tests
+	  cover the uprobe-line parser (tlob_parse_uprobe_line) and the
+	  remove-line parser (tlob_parse_remove_line), verifying valid,
+	  invalid, and out-of-range inputs without requiring a running kernel.
diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
index 99acd34726f1..e109390ba3ad 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.c
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -874,7 +874,7 @@ static ssize_t tlob_monitor_read(struct file *file,
  * PATH may contain ':'; the last ':' separates path from offset.
  * Returns 0, -EINVAL, or -ERANGE.
  */
-static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
+VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
 					    char **path_out,
 					    loff_t *start_out, loff_t *stop_out)
 {
@@ -948,11 +948,12 @@ static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
 	*stop_out  = (loff_t)stop_val;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(tlob_parse_uprobe_line);
 
 /*
  * Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convention).
  */
-static int tlob_parse_remove_line(char *buf, char **path_out,
+VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *buf, char **path_out,
 					    loff_t *start_out)
 {
 	char *binpath, *colon;
@@ -976,6 +977,7 @@ static int tlob_parse_remove_line(char *buf, char **path_out,
 	*start_out = (loff_t)off;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(tlob_parse_remove_line);
 
 static int tlob_create_or_delete_uprobe(char *buf)
 {
diff --git a/kernel/trace/rv/monitors/tlob/tlob.h b/kernel/trace/rv/monitors/tlob/tlob.h
index 94e7382c2130..6ad9d5179ab6 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.h
+++ b/kernel/trace/rv/monitors/tlob/tlob.h
@@ -146,4 +146,10 @@ static const struct automaton_tlob automaton_tlob = {
 /* Upper budget bound (1 hour): keeps the u64 ns accumulators far from overflow. */
 #define TLOB_MAX_THRESHOLD_NS	3600000000000ULL
 
+#if IS_ENABLED(CONFIG_TLOB_KUNIT_TEST)
+int tlob_parse_uprobe_line(char *buf, u64 *thr_out, char **path_out,
+			   loff_t *start_out, loff_t *stop_out);
+int tlob_parse_remove_line(char *buf, char **path_out, loff_t *start_out);
+#endif /* CONFIG_TLOB_KUNIT_TEST */
+
 #endif /* _RV_TLOB_H */
diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
new file mode 100644
index 000000000000..6a6fb57d0678
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
@@ -0,0 +1,139 @@
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
+/* Valid "p PATH:START STOP threshold=NS" lines. */
+static const char * const tlob_parse_valid[] = {
+	"p /usr/bin/myapp:4768 4848 threshold=5000000",
+	"p /usr/bin/myapp:0x12a0 0x12f0 threshold=10000000",
+	"p /opt/my:app/bin:0x100 0x200 threshold=1000000",
+};
+
+/* Malformed "p ..." lines that must be rejected with -EINVAL. */
+static const char * const tlob_parse_invalid[] = {
+	"p :0x100 0x200 threshold=5000",
+	"p /usr/bin/myapp:0x100 threshold=5000",
+	"p /usr/bin/myapp:-1 0x200 threshold=5000",
+	"p /usr/bin/myapp:0x100 -1 threshold=5000000",	/* negative stop offset */
+	"p /usr/bin/myapp:0x100 0x200",
+	"p /usr/bin/myapp:0x100 0x100 threshold=5000",
+};
+
+/* threshold_ns < TLOB_MIN_THRESHOLD_NS or > TLOB_MAX_THRESHOLD_NS => -ERANGE. */
+static const char * const tlob_parse_out_of_range[] = {
+	"p /usr/bin/myapp:0x100 0x200 threshold=0",
+	"p /usr/bin/myapp:0x100 0x200 threshold=999",
+	"p /usr/bin/myapp:0x100 0x200 threshold=3600000000001",
+};
+
+/* Valid "-PATH:OFFSET_START" remove lines. */
+static const char * const tlob_remove_valid[] = {
+	"-/usr/bin/myapp:0x100",
+	"-/opt/my:app/bin:0x200",
+};
+
+/* Malformed remove lines that must be rejected with -EINVAL. */
+static const char * const tlob_remove_invalid[] = {
+	"-usr/bin/myapp:0x100",
+	"-/usr/bin/myapp",
+	"-/:0x100",
+	"-/usr/bin/myapp:-1",	/* negative offset */
+	"-/usr/bin/myapp:abc",
+};
+
+static void tlob_parse_valid_accepted(struct kunit *test)
+{
+	u64 thr;
+	char *path;
+	loff_t start, stop;
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_valid); i++) {
+		strscpy(buf, tlob_parse_valid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, tlob_parse_uprobe_line(buf, &thr, &path,
+							     &start, &stop), 0);
+	}
+}
+
+static void tlob_parse_invalid_rejected(struct kunit *test)
+{
+	u64 thr;
+	char *path;
+	loff_t start, stop;
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_invalid); i++) {
+		strscpy(buf, tlob_parse_invalid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, tlob_parse_uprobe_line(buf, &thr, &path,
+							     &start, &stop), -EINVAL);
+	}
+}
+
+static void tlob_parse_out_of_range_rejected(struct kunit *test)
+{
+	u64 thr;
+	char *path;
+	loff_t start, stop;
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_out_of_range); i++) {
+		strscpy(buf, tlob_parse_out_of_range[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, tlob_parse_uprobe_line(buf, &thr, &path,
+							     &start, &stop), -ERANGE);
+	}
+}
+
+static void tlob_remove_valid_accepted(struct kunit *test)
+{
+	char *path;
+	loff_t start;
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_remove_valid); i++) {
+		strscpy(buf, tlob_remove_valid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, tlob_parse_remove_line(buf, &path, &start), 0);
+	}
+}
+
+static void tlob_remove_invalid_rejected(struct kunit *test)
+{
+	char *path;
+	loff_t start;
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_remove_invalid); i++) {
+		strscpy(buf, tlob_remove_invalid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, tlob_parse_remove_line(buf, &path, &start), -EINVAL);
+	}
+}
+
+static struct kunit_case tlob_parse_cases[] = {
+	KUNIT_CASE(tlob_parse_valid_accepted),
+	KUNIT_CASE(tlob_parse_invalid_rejected),
+	KUNIT_CASE(tlob_parse_out_of_range_rejected),
+	KUNIT_CASE(tlob_remove_valid_accepted),
+	KUNIT_CASE(tlob_remove_invalid_rejected),
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
2.25.1

