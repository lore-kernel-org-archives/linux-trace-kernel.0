Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39003F12E6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525171; cv=none; b=VWTe3SyrGyclCybqHiP4/3LR/qcOC2rkdhpLWs80JUumZDb59Ccc6gIG/UxDeJp4LHoQicfamD4msd1iE22DWnGtCJupq+eZ6lavEIXSqrTOiHLILW+eO/7EgaaQpjvRasrIaXl29ds1Lg8Eu1e0o2FnOkqN31Gg/OxsLGWQo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525171; c=relaxed/simple;
	bh=2NizjHn1wd165dWwmEjKsUz+yEaZX2jeecpYo5qf1Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyFisvy101GB3eQ0NxRs4ZW7cpLyNfM09m5EW4LKupk6O9WinBbM7sQZU6AMIWOV2DP1Qp+vje4iuFLk1a1iJ9u0f85pgGNRAgf9Opb6avE74Yvty5Y8tT2U0fBmSne8q9KSYcR6FenKYgtZPKusivh92f6YB81osPAbxEBoXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AORxvFBS; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AORxvFBS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ3hf7dGaovMdiVksikaMoIv3qF+j16rWQP4TKRwPUs=;
	b=AORxvFBSyxuyO7vRiBXVdZtqtZ/wa1R5akk7xVa4I12x/0in5QSpZ4nBo/3+GlRh/aKKl/
	bhUc/iVimx4KOj8DtXLy044YqGV9HB4gZH4Mmo2nCO3LKn8lXQU0m7v/WZcuCc38WDOC02
	+n7abgxhWuOgJ2cW3uZ8sZhve3gtNF4=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 7/8] rv/tlob: add KUnit tests for the tlob monitor
Date: Wed,  8 Jul 2026 23:38:33 +0800
Message-Id: <18ab97e8a248e55dfeef5daa49daa407bf58dc56.1783524627.git.wen.yang@linux.dev>
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
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
default KUNIT_ALL_TESTS) with a test suite covering the uprobe-line
parser.

Tests call tlob_parse_uprobe_line() and tlob_parse_remove_line()
directly rather than going through the top-level write handler, so
they exercise parser logic only without touching the uprobe or
filesystem subsystems.

Cases cover valid inputs, malformed paths and offsets (including
negative values), out-of-range thresholds, and valid and invalid
remove lines.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Makefile                   |   1 +
 kernel/trace/rv/monitors/tlob/.kunitconfig |   8 ++
 kernel/trace/rv/monitors/tlob/Kconfig      |   7 ++
 kernel/trace/rv/monitors/tlob/tlob.c       |   7 +-
 kernel/trace/rv/monitors/tlob/tlob.h       |   4 +-
 kernel/trace/rv/monitors/tlob/tlob_kunit.c | 139 +++++++++++++++++++++
 6 files changed, 162 insertions(+), 4 deletions(-)
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
index 000000000000..34ebf3b172ac
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/.kunitconfig
@@ -0,0 +1,8 @@
+CONFIG_FTRACE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_KUNIT=y
+CONFIG_MODULES=y
+CONFIG_RV=y
+CONFIG_RV_MON_TLOB=y
+CONFIG_TLOB_KUNIT_TEST=y
+CONFIG_UPROBES=y
diff --git a/kernel/trace/rv/monitors/tlob/Kconfig b/kernel/trace/rv/monitors/tlob/Kconfig
index aa43382073d2..402ef2e5c076 100644
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
diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
index b45e84195131..a6f9c371646c 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.c
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -708,7 +708,7 @@ static ssize_t tlob_monitor_read(struct file *file,
  * PATH may contain ':'; the last ':' separates path from offset.
  * Returns 0, -EINVAL, or -ERANGE.
  */
-static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
+VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
 				  char **path_out,
 				  loff_t *start_out, loff_t *stop_out)
 {
@@ -782,6 +782,7 @@ static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
 	*stop_out  = (loff_t)stop_val;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(tlob_parse_uprobe_line);
 
 /*
  * Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convention).
@@ -810,8 +811,9 @@ VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *buf, char **path_out,
 	*start_out = (loff_t)off;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(tlob_parse_remove_line);
 
-VISIBLE_IF_KUNIT int tlob_create_or_delete_uprobe(char *buf)
+static int tlob_create_or_delete_uprobe(char *buf)
 {
 	loff_t offset_start, offset_stop;
 	u64 threshold_ns;
@@ -836,7 +838,6 @@ VISIBLE_IF_KUNIT int tlob_create_or_delete_uprobe(char *buf)
 	mutex_unlock(&tlob_uprobe_mutex);
 	return ret;
 }
-EXPORT_SYMBOL_IF_KUNIT(tlob_create_or_delete_uprobe);
 
 static ssize_t tlob_monitor_write(struct file *file,
 				  const char __user *ubuf,
diff --git a/kernel/trace/rv/monitors/tlob/tlob.h b/kernel/trace/rv/monitors/tlob/tlob.h
index fceeba748c85..15bdf3b7fade 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.h
+++ b/kernel/trace/rv/monitors/tlob/tlob.h
@@ -145,7 +145,9 @@ int tlob_start_task(struct task_struct *task, u64 threshold_ns);
 int tlob_stop_task(struct task_struct *task);
 
 #if IS_ENABLED(CONFIG_KUNIT)
-int tlob_create_or_delete_uprobe(char *buf);
+int tlob_parse_uprobe_line(char *buf, u64 *thr_out, char **path_out,
+			   loff_t *start_out, loff_t *stop_out);
+int tlob_parse_remove_line(char *buf, char **path_out, loff_t *start_out);
 #endif /* CONFIG_KUNIT */
 
 #endif /* _RV_TLOB_H */
diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
new file mode 100644
index 000000000000..7448f3fab959
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
+/* threshold_ns out of valid range => -ERANGE. */
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

