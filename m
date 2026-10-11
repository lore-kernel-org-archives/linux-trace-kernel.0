Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E93E2768
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747653; cv=none; b=bjd8h6iz66IDKtTRY4cVuqFMeFIF0ymDvTEDkAIjkT8VNVhDYFJMXnqrjNPXfLEjdbM30BCAI6gFKPzLAkeMmjae5gMtVsosKkpDVMJUrTIXHd5gGmz4qJ3xrPMQNxVRK/xvQAcQuM4H7fPr+pOhB+H7uYqZKCGPZqyN9zKPgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747653; c=relaxed/simple;
	bh=kj4nTabUq/lh+AWUP6dbeAsksJjVBt7GCA3vUVXCME0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m69AIRcrYWXPjIC+gqidC3iylP74j+rE3KADfo8fvAIxyN2hZKnEDa7LO9TEj/ade+3GgrgLFyrDsSH3WWQOeSEHHlGSiL2Jk1MYSpISKUSjBuN1jyRZ0YGGyiFzsVYP5XpQOLm7rae46euBRyXwrhquSp4FNztGBHwXNEKcvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpIeRuny; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpIeRuny"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kj4nTabUq/lh+AWUP6dbeAsksJjVBt7GCA3vUVXCME0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747649; v=1; x=1792352449;
 b=jpIeRunyQ46q3Mb4zxHTeEXaUQVVLY6osTATWZ9dLpswYqWOJXXwtXDwhp+htInHdqCsgv2h
 8tKQFs7O41lgzSeYlfe9nCqDXY5dlEmr4J+OqAAU959BEiAktRVNnA14OIFltlWTniwn4Sv15uH
 bNP4rFBhsUKApalsWWL+C2NQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 12638a22ec2b11c5;
	Sun, 11 Oct 2026 19:40:49 +0000
X-Mizu-Trace-ID: 12638a22ec2b11c5
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 12/14] rv: Add KUnit tests for the tlob monitor
Date: Mon, 12 Oct 2026 03:39:18 +0800
Message-Id: <74239f278c36fe9b5cb2cf42869843cd8eca4f36.1791745088.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add a test case to the shared rv_monitors_test.c suite covering
the uprobe-line parser in the tlob monitor.

Cases cover valid inputs, malformed paths and offsets (including
negative values), out-of-range thresholds, and valid and invalid
remove lines.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/monitors/tlob/tlob.c       |  11 ++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c | 151 +++++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob_kunit.h |  18 +++
 kernel/trace/rv/rv_monitors_test.c         |   2 +
 4 files changed, 182 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.h

diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
index 066a2f0663d5..159fc9a2c49e 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.c
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -863,6 +863,17 @@ static int tlob_parse_remove_line(char *buf, char **name_out)
 	return 0;
 }
 
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
+
 static int tlob_create_or_delete_uprobe(char *buf)
 {
 	loff_t offset_start, offset_stop;
diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
new file mode 100644
index 000000000000..06b212d1103b
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include "tlob_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_TLOB)
+
+/* Valid "p:NAME PATH:START STOP threshold=NS" lines and what they decode to. */
+static const struct {
+	const char	*line;
+	const char	*name;
+	const char	*path;
+	loff_t		start;
+	loff_t		stop;
+	u64		thr;
+} tlob_parse_valid[] = {
+	{ "p:region /usr/bin/myapp:4768 4848 threshold=5000000",
+	  "region", "/usr/bin/myapp", 4768, 4848, 5000000 },
+	/* Base 0: hex offsets must not decode as decimal. */
+	{ "p:my_region_2 /usr/bin/myapp:0x12a0 0x12f0 threshold=10000000",
+	  "my_region_2", "/usr/bin/myapp", 0x12a0, 0x12f0, 10000000 },
+	/* The last ':' separates the offset, so a ':' in PATH is fine. */
+	{ "p:_r3 /opt/my:app/bin:0x100 0x200 threshold=1000000",
+	  "_r3", "/opt/my:app/bin", 0x100, 0x200, 1000000 },
+	/* TLOB_MAX_NAME - 1 characters: the longest name accepted. */
+	{ "p:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa /bin/a:0x100 0x200 threshold=5000",
+	  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "/bin/a", 0x100, 0x200, 5000 },
+	/* The accepted threshold bounds themselves. */
+	{ "p:lo /bin/a:0x100 0x200 threshold=1000",
+	  "lo", "/bin/a", 0x100, 0x200, 1000 },
+	{ "p:hi /bin/a:0x100 0x200 threshold=3600000000000",
+	  "hi", "/bin/a", 0x100, 0x200, 3600000000000ULL },
+};
+
+/* Malformed "p:..." lines that must be rejected with -EINVAL. */
+static const char * const tlob_parse_invalid[] = {
+	"p /usr/bin/myapp:0x100 0x200 threshold=5000",		/* no name */
+	"p:",							/* empty name */
+	"p: /usr/bin/myapp:0x100 0x200 threshold=5000",		/* name is a path */
+	"p:r /bin/a:0x100junk 0x200 threshold=5000",		/* trailing junk */
+	"p:1region /usr/bin/myapp:0x100 0x200 threshold=5000",	/* digit lead */
+	"p:my-win /usr/bin/myapp:0x100 0x200 threshold=5000",	/* bad char */
+	"p:my.win /usr/bin/myapp:0x100 0x200 threshold=5000",	/* bad char */
+	/* TLOB_MAX_NAME characters: one over the limit. */
+	"p:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa /bin/a:0x100 0x200 threshold=5000",
+	"p:region :0x100 0x200 threshold=5000",			/* empty path */
+	"p:region /usr/bin/myapp:0x100 threshold=5000",		/* missing stop */
+	"p:region /usr/bin/myapp:-1 0x200 threshold=5000",		/* negative start */
+	"p:region /usr/bin/myapp:0x100 -1 threshold=5000000",	/* negative stop */
+	"p:region /usr/bin/myapp:0x100 0x200",			/* missing threshold */
+	"p:region /usr/bin/myapp:0x100 0x100 threshold=5000",	/* start == stop */
+	/* Duplicate threshold=, like a duplicate offset, is an error. */
+	"p:region /bin/a:0x100 0x200 threshold=5000 threshold=9000",
+};
+
+/* threshold_ns out of valid range => -ERANGE. */
+static const char * const tlob_parse_out_of_range[] = {
+	"p:region /usr/bin/myapp:0x100 0x200 threshold=0",
+	"p:region /usr/bin/myapp:0x100 0x200 threshold=999",
+	"p:region /usr/bin/myapp:0x100 0x200 threshold=3600000000001",
+};
+
+/* Valid "-:NAME" remove lines. */
+static const char * const tlob_remove_valid[] = {
+	"-:region",
+	"-:my_region",
+};
+
+/* Malformed remove lines that must be rejected with -EINVAL. */
+static const char * const tlob_remove_invalid[] = {
+	"-",	/* no name */
+	"-:",	/* empty name */
+	"-region",	/* missing ':' */
+	"-:my region",	/* bad char */
+	"-:1region",	/* digit lead */
+	"-:my-region",	/* bad char */
+	"-:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",	/* TLOB_MAX_NAME, one too many */
+};
+
+static void rv_test_tlob(struct kunit *test)
+{
+	u64 thr;
+	char *name, *path;
+	loff_t start, stop;
+	char buf[128];
+	int i, ret;
+
+	/* NAME and PATH come back NUL-terminated inside buf. */
+	strscpy(buf, "p:region /usr/bin/myapp:0x100 0x200 threshold=5000",
+		sizeof(buf));
+	ret = rv_tlob_kunit_ops.parse_uprobe_line(buf, &name, &path,
+						  &start, &stop, &thr);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_STREQ(test, name, "region");
+	KUNIT_EXPECT_STREQ(test, path, "/usr/bin/myapp");
+
+	strscpy(buf, "-:region", sizeof(buf));
+	ret = rv_tlob_kunit_ops.parse_remove_line(buf, &name);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_STREQ(test, name, "region");
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_valid); i++) {
+		strscpy(buf, tlob_parse_valid[i].line, sizeof(buf));
+		ret = rv_tlob_kunit_ops.parse_uprobe_line(buf, &name, &path,
+							  &start, &stop,
+							  &thr);
+		KUNIT_EXPECT_EQ(test, ret, 0);
+		if (ret)
+			continue;
+		KUNIT_EXPECT_STREQ(test, name, tlob_parse_valid[i].name);
+		KUNIT_EXPECT_STREQ(test, path, tlob_parse_valid[i].path);
+		KUNIT_EXPECT_EQ(test, start, tlob_parse_valid[i].start);
+		KUNIT_EXPECT_EQ(test, stop, tlob_parse_valid[i].stop);
+		KUNIT_EXPECT_EQ(test, thr, tlob_parse_valid[i].thr);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_invalid); i++) {
+		strscpy(buf, tlob_parse_invalid[i], sizeof(buf));
+		ret = rv_tlob_kunit_ops.parse_uprobe_line(buf, &name, &path,
+							  &start, &stop,
+							  &thr);
+		KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tlob_parse_out_of_range); i++) {
+		strscpy(buf, tlob_parse_out_of_range[i], sizeof(buf));
+		ret = rv_tlob_kunit_ops.parse_uprobe_line(buf, &name, &path,
+							  &start, &stop,
+							  &thr);
+		KUNIT_EXPECT_EQ(test, ret, -ERANGE);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tlob_remove_valid); i++) {
+		strscpy(buf, tlob_remove_valid[i], sizeof(buf));
+		ret = rv_tlob_kunit_ops.parse_remove_line(buf, &name);
+		KUNIT_EXPECT_EQ(test, ret, 0);
+		if (!ret)
+			KUNIT_EXPECT_STREQ(test, name,
+					   tlob_remove_valid[i] + 2);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tlob_remove_invalid); i++) {
+		strscpy(buf, tlob_remove_invalid[i], sizeof(buf));
+		ret = rv_tlob_kunit_ops.parse_remove_line(buf, &name);
+		KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	}
+}
+
+#else
+#define rv_test_tlob rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.h b/kernel/trace/rv/monitors/tlob/tlob_kunit.h
new file mode 100644
index 000000000000..c0c80c34f17b
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __TLOB_KUNIT_H
+#define __TLOB_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/types.h>
+
+extern const struct rv_tlob_kunit_ops {
+	int (*parse_uprobe_line)(char *buf, char **name_out, char **path_out,
+				 loff_t *start_out, loff_t *stop_out,
+				 u64 *thr_out);
+	int (*parse_remove_line)(char *buf, char **name_out);
+} rv_tlob_kunit_ops;
+
+#endif
+
+#endif /* __TLOB_KUNIT_H */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index b30e49419e34..ee9fde63b291 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -309,6 +309,7 @@ static void rv_test_rvtest_arm_after_destroy(struct kunit *test)
 #include "monitors/sts/sts_kunit.c"
 #include "monitors/opid/opid_kunit.c"
 #include "monitors/nomiss/nomiss_kunit.c"
+#include "monitors/tlob/tlob_kunit.c"
 #include "monitors/pagefault/pagefault_kunit.c"
 #include "monitors/sleep/sleep_kunit.c"
 
@@ -323,6 +324,7 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_sleep),
 	KUNIT_CASE(rv_test_rvtest_underflow),
 	KUNIT_CASE(rv_test_rvtest_arm_after_destroy),
+	KUNIT_CASE(rv_test_tlob),
 	{}
 };
 
-- 
2.25.1

