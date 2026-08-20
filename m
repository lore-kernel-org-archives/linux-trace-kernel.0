Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810B47ACF5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244376; cv=none; b=lT+aCXhmzsJJNtaCYhJzO6zfT0VBNBp9IB8w94vPnDxKtkvwHrkF5fQ3mb2KZI3VQ9o30zXk7Ues9eDbhNDi8ELwGGZwHiOR932FkQY6VPXkJXudAI6c9Z7sm4VquFmUdnhoYSDxPqp0TJvVdTjEocwTRvqR2yifsh4BrFfKhJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244376; c=relaxed/simple;
	bh=ouJPcVlcb9DZaDOleS4/HR3Ncw1h+rN/1GW/5XQFFDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uO2zvGqYC3f+liWwERrNTFZ/QsUQZ1Ok9GWUzFy9b84MAuA6lmN2ZKvRSZ8c58R1G2nSejA1Qg7M/7tQGxzTFJMbXsaJ5J1LVWcwXEhDJekJZ0Jk25YrErDszFdRg/D/2tDEoQre8OqvKzUxW/jpJnGTXgVeWivjlB0ZIWe/4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vnKz1QtD; arc=none smtp.client-ip=95.215.58.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vnKz1QtD"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ouJPcVlcb9DZaDOleS4/HR3Ncw1h+rN/1GW/5XQFFDw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244372; v=1; x=1787849172;
 b=vnKz1QtDw6IpTmKpeGvrEjl2SfbNlWv+9lLDBFeQrmROMh7et1hcVmFllRafaNWjOlQ3UAmD
 sa/RYB+Yuz8YOi/99qt5M5itzbmr2fwG7AnqJv2fOZlhgz6qhixVLjCHlGS++Qra5HksPDS3yWM
 zBbV0EFB9mqPBuVYqVT+8W3w=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id 7f8743662be58406;
	Thu, 20 Aug 2026 16:46:12 +0000
X-Mizu-Trace-ID: 7f8743662be58406
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 7/9] rv: Add KUnit tests for the tlob monitor
Date: Fri, 21 Aug 2026 00:45:16 +0800
Message-Id: <aa1cd3f917a0a2a782abe6f1faf51547fb09224a.1787243842.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add a test case to the shared rv_monitors_test.c suite (gated by the
existing CONFIG_RV_MONITORS_KUNIT_TEST, same as nomiss/sco/etc.)
covering the uprobe-line parser.

tlob_parse_uprobe_line() and tlob_parse_remove_line() stay static and
unconditional: production code (tlob_create_or_delete_uprobe()) always
needs them, so they can't be compiled out, and un-hiding them via
VISIBLE_IF_KUNIT would tie their linkage to CONFIG_KUNIT while nothing
else in tlob.c depends on it. Instead, expose them to the test only
through a const rv_tlob_kunit_ops struct of function pointers, built
and exported the same way nomiss.c/sco.c expose their rv_<mon>_ops:
the struct itself, its declaration in tlob_kunit.h, and its use in
tlob_kunit.c are all gated on the single CONFIG_RV_MONITORS_KUNIT_TEST
symbol, so there is no separate prototype to go out of sync with a
visibility macro.

tlob_kunit.c follows the monitors/*/*_kunit.c convention: one
rv_test_tlob() case textually included into rv_monitors_test.c,
guarded by IS_REACHABLE(CONFIG_RV_MON_TLOB) with an rv_test_stub()
fallback so the shared suite still builds when RV_MON_TLOB=n (that
symbol is independent of CONFIG_RV_MONITORS_KUNIT_TEST). Drop the
per-monitor TLOB_KUNIT_TEST Kconfig entry, .kunitconfig, and Makefile
line that a standalone test module would have needed.

Cases cover valid inputs, malformed paths and offsets (including
negative values), out-of-range thresholds, and valid and invalid
remove lines.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/monitors/tlob/tlob.c       | 24 ++++--
 kernel/trace/rv/monitors/tlob/tlob_kunit.c | 87 ++++++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob_kunit.h | 17 +++++
 kernel/trace/rv/rv_monitors_test.c         |  2 +
 4 files changed, 122 insertions(+), 8 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.h

diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
index 08b1bee884cc..18150cbf57a5 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.c
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -20,7 +20,6 @@
 #include <linux/namei.h>
 #include <linux/rv.h>
 #include <linux/slab.h>
-#include <kunit/visibility.h>
 #include <rv/instrumentation.h>
 #include <rv/rv_uprobe.h>
 #include <rv.h>
@@ -877,9 +876,9 @@ static ssize_t tlob_monitor_read(struct file *file,
  * PATH may contain ':'; the last ':' separates path from offset.
  * Returns 0, -EINVAL, or -ERANGE.
  */
-VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
-					    char **path_out,
-					    loff_t *start_out, loff_t *stop_out)
+static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
+				  char **path_out,
+				  loff_t *start_out, loff_t *stop_out)
 {
 	unsigned long long thr = 0, stop_val = 0;
 	long long start_val;
@@ -951,13 +950,12 @@ VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
 	*stop_out  = (loff_t)stop_val;
 	return 0;
 }
-EXPORT_SYMBOL_IF_KUNIT(tlob_parse_uprobe_line);
 
 /*
  * Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convention).
  */
-VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *buf, char **path_out,
-					    loff_t *start_out)
+static int tlob_parse_remove_line(char *buf, char **path_out,
+				  loff_t *start_out)
 {
 	char *binpath, *colon;
 	long long off;
@@ -980,7 +978,17 @@ VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *buf, char **path_out,
 	*start_out = (loff_t)off;
 	return 0;
 }
-EXPORT_SYMBOL_IF_KUNIT(tlob_parse_remove_line);
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "tlob_kunit.h"
+
+const struct rv_tlob_kunit_ops rv_tlob_kunit_ops = {
+	.parse_uprobe_line = tlob_parse_uprobe_line,
+	.parse_remove_line = tlob_parse_remove_line,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_tlob_kunit_ops);
+#endif
 
 static int tlob_create_or_delete_uprobe(char *buf)
 {
diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
new file mode 100644
index 000000000000..a8987fba2533
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include "tlob_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_TLOB)
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
+static void rv_test_tlob(struct kunit *test)
+{
+	u64 thr;
+	char *path;
+	loff_t start, stop;
+	char buf[128];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_valid); i++) {
+		strscpy(buf, tlob_parse_valid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, rv_tlob_kunit_ops.parse_uprobe_line(buf, &thr, &path,
+									  &start, &stop), 0);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_invalid); i++) {
+		strscpy(buf, tlob_parse_invalid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, rv_tlob_kunit_ops.parse_uprobe_line(buf, &thr, &path,
+									  &start, &stop), -EINVAL);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_out_of_range); i++) {
+		strscpy(buf, tlob_parse_out_of_range[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, rv_tlob_kunit_ops.parse_uprobe_line(buf, &thr, &path,
+									  &start, &stop), -ERANGE);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tlob_remove_valid); i++) {
+		strscpy(buf, tlob_remove_valid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, rv_tlob_kunit_ops.parse_remove_line(buf, &path, &start), 0);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tlob_remove_invalid); i++) {
+		strscpy(buf, tlob_remove_invalid[i], sizeof(buf));
+		KUNIT_EXPECT_EQ(test, rv_tlob_kunit_ops.parse_remove_line(buf, &path, &start),
+				-EINVAL);
+	}
+}
+
+#else
+#define rv_test_tlob rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.h b/kernel/trace/rv/monitors/tlob/tlob_kunit.h
new file mode 100644
index 000000000000..4c1081871ea3
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __TLOB_KUNIT_H
+#define __TLOB_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/types.h>
+
+extern const struct rv_tlob_kunit_ops {
+	int (*parse_uprobe_line)(char *buf, u64 *thr_out, char **path_out,
+				 loff_t *start_out, loff_t *stop_out);
+	int (*parse_remove_line)(char *buf, char **path_out, loff_t *start_out);
+} rv_tlob_kunit_ops;
+
+#endif
+
+#endif /* __TLOB_KUNIT_H */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 3ad11195e664..791df0fe03e3 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -153,6 +153,7 @@ static void rv_test_dummy(struct kunit *test)
 #include "monitors/nomiss/nomiss_kunit.c"
 #include "monitors/pagefault/pagefault_kunit.c"
 #include "monitors/sleep/sleep_kunit.c"
+#include "monitors/tlob/tlob_kunit.c"
 
 static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_dummy),
@@ -163,6 +164,7 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_nomiss),
 	KUNIT_CASE(rv_test_pagefault),
 	KUNIT_CASE(rv_test_sleep),
+	KUNIT_CASE(rv_test_tlob),
 	{}
 };
 
-- 
2.25.1

