Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901053;
	b=zZrcMbYjWyjV1ouGx8saktH0N3cMUg3xYLMZ6gKUVnurVIK8ydrB3zPbxbkLqNIDGsf5
	 WT9MvusquLdUZNJIbSMIthv56Mg0nPMZ3PdYHxRmuxsHmgdM0JFJCm8Y1wuFVvN9J5B9a
	 lIetWYM55Lpv48NEMWVtdlM62hypdcBZdS15VqZsOB25u/gQx6+FkgP31QRb09VbCxfOj
	 iAAm6Bu8khB3CcAIt0fZ5kOmAPah7mkN+KQP8RBGhdg4u60lCukVldUiVfVDiudkbe7qd
	 ZKAeYU8z5EdZ61SfdUuRNoIjfiavLiOaAblE3XoNiAQ8U1IRzwf7qDYa2YKP/VBfTMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901053;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XYKwFZb8pBoZFfUo/vlsxQ6VkD1QzDu2riurPkEQ/vE=;
	b=L9dE3hmXNlc3zP132UUpzrXA1vAnKhH3yOBi8WpZPVNbvFhzgMueYCGZWnYdalyRyR4p
	 IFlEUAmlyr4DSb4lSoMrYgq8btVrDivuZNMMBg/ReTwQh0ITrZKv0jAkOGRz4YsUE+NSm
	 rz/P7uveLANuLfd3UfOuraqLjeyGZvGYUzLv6WXAguzh0/YLAWp/NUePDkTnV1rRvyM1H
	 Mz3EMSd78x/Xl16mIkxRBg/um4ptd66A9jwGtS7hm71Fy63rcpg/S6TRUjxYb0+heUlU7
	 VNQCeUJAOPKqdUMy2ouaA0HqcFtCxNqfjdlYlkEIeiBtbSKxYdkPqDFCNNiD8GFPSnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="pPvk/XJW";
	arc=none smtp.remote-ip=91.218.175.108
Received: from mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3625606A330
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3625606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pPvk/XJW
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FxzXkcfWoKY1UoZI6qf48omAXtuKQPdOJTLaNA6oWxM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901051; v=1; x=1794505851;
 b=pPvk/XJWSREWnTzTbQSmgGVHeKR8zhM8EqdiXCSx7h3kzjEmvuF8R/i0Q8lyEXAmiPzNJuUB
 jOJCVae+j4TgOTfblf68mPbRjLm2JcxBresnVIbIYe0uuTaWvCiapefjO7hgfzwronURIcb8vPr
 3NpZxyEf/ohSGYTeL1sPSHvs=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 51d5130d50f54c15;
	Thu, 05 Nov 2026 17:50:51 +0000
X-Mizu-Trace-ID: 51d5130d50f54c15
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 12/14] rv: Add KUnit tests for the tlob monitor
Date: Fri,  6 Nov 2026 01:49:12 +0800
Message-Id: <68ac8927fb296b230793daade55cdec26dd44858.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add a test case to the shared rv_monitors_test.c suite covering
the uprobe-line parser in the tlob monitor.

Cases cover valid inputs, malformed paths and offsets (including
negative values), out-of-range thresholds, and valid and invalid
remove lines.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
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
index fe7d88df62f1..62b0d3330be8 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.c
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -593,6 +593,17 @@ static int tlob_parse_remove_line(char *buf, char **name_out)
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
index 3ad11195e664..548607e7c1a7 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -151,6 +151,7 @@ static void rv_test_dummy(struct kunit *test)
 #include "monitors/sts/sts_kunit.c"
 #include "monitors/opid/opid_kunit.c"
 #include "monitors/nomiss/nomiss_kunit.c"
+#include "monitors/tlob/tlob_kunit.c"
 #include "monitors/pagefault/pagefault_kunit.c"
 #include "monitors/sleep/sleep_kunit.c"
 
@@ -161,6 +162,7 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_sts),
 	KUNIT_CASE(rv_test_opid),
 	KUNIT_CASE(rv_test_nomiss),
+	KUNIT_CASE(rv_test_tlob),
 	KUNIT_CASE(rv_test_pagefault),
 	KUNIT_CASE(rv_test_sleep),
 	{}
-- 
2.25.1

