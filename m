Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66F30B532
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224132; cv=none; b=olDx9AjgN3oDAmydRVC94gPlZnVwjtUxaHTJ61Ppc51fygIOvLKBmI67xwLrm012OKdV50zUVEanGKxCfcoC9x66umqaxfvcijufjgbRahhmGM6++N9l0AkqFDqBQihYTTAtmZHoqGkas+P1ZMSH53wyfjF3MpEWd58ER3FHkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224132; c=relaxed/simple;
	bh=NXluUWsGUJWbvUwBY8QcwnUX2+oyPNqQQeow5Lv3DsI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=IdrCjWuhKO/10gmqdyQI5RcXrG7iKy/w5U77xjs3lbqTtNZtTV0HZoE6tuI2zk4Sog0oYiph2knhcR+FuKG7YhELWWN1+1yV0VjJ5vP+RuHIK4T9u2sk4dM9GBNr1CUJdMYhR9HWQyEOlfkfShZ2wcXQA3RLonv43oeQkrJ2tX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NceNciFc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NceNciFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768224130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q4s+OdLx4i189wcto/R0uWmzncKq8UkLGmJxKDFcZ3U=;
	b=NceNciFc1Lz/hqbO3Kbsn+qhzUhGpUgfyXlZN7zLAu5dr4ldddEwlLRu6gsO3RF/JeS0Af
	D5lOfbp4Ln8fuRHVZs21VGNZVrCHImpi3VAuj6wbgMETcZFKXABb4uUjek+f4liL+rL4kD
	9jIbt4PiX51sATz3dj5TVQHcBYbGJ5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-x7_y_DzHPyK5No3ZcWtJHQ-1; Mon, 12 Jan 2026 08:22:09 -0500
X-MC-Unique: x7_y_DzHPyK5No3ZcWtJHQ-1
X-Mimecast-MFC-AGG-ID: x7_y_DzHPyK5No3ZcWtJHQ_1768224128
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d110fabso64447565e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 05:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768224127; x=1768828927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4s+OdLx4i189wcto/R0uWmzncKq8UkLGmJxKDFcZ3U=;
        b=dFJQDSu8pHWxgS/pZPu7zgaEnR/ARCBi0yypo59KK206nq3dBIsEfKfp2mNw3wsKrC
         q8YP3RdPhnKbljb3X1amJ6v5WylLBuQ6rf+sRph91Jep6t3uYiC9cBDvuY+TtrkMyo/+
         lS4ORTYfM07MCHDSIxPtA7S1FKz7tDSRJtLB67UDG4L+ZHZhQuMOcreBpuTl2eexpEgd
         r1w7K3KTzTxVwbdnpu20h/6286WJ8gX55cZo+gE0wXU40CqUrX4XEIN2ndq1EDelyMB5
         xaatNMJyH3uFvfKF3IyBC5AGDS9Z3dWxRsdrjvY4O12ca1geD7HPJMCxTU08C50wYxDC
         z4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4m/sKWEhkWsps7SdYkTD7XWNYnbePF5jH8r4Pp3CZrATwX6PHMJIRPE50J3RAGTtaEDbngv/VrMaDZVZSWcFeYnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIMC7+Bxi4O5udheNfCVevQtlKS8IECTsMdEarzdCkP7Bwk6UL
	1y1puQobbIiOJAvQ8IkbvCM0l9uGiohOiu6wWI720SahWHdHFrhdrKK2YB7sU44rAsAJP608xxE
	jRx/3tw5Q3U/dTkuW5YfWYbPYjun6ed4+ud5PFS8Dk+yGEyrCo4PkcFLfCF9fwAPxn30zj9r9yz
	lds/h6ZQ==
X-Gm-Gg: AY/fxX6G1/LqWuo3YDcc+tFd+4ZI/CUH3bdJQSnAs6xc+MY3vXXo2yqJXfLzOlMnzIE
	B/JrKoXlMu7YvACcylcxoGsA+M/ajL+ZHXg0RJLEATYIo/CjSyLwewXLxfW/b7wrGp9STssu6I1
	61xF0GOTp/QHq4Jm+7OuconwDlwge6LwDNVvludLX2Xw2mkwUQlvo0r7+sqvxmReKMDZF/WlxpJ
	7PlqEAnY1DWRSuH6jxKId9G9a+y/W18pnckNX+iMl5ad0IUfUlmHb+2nP164ia7MVx2vnG817lx
	fqjXZ/Ew83HhZ7UkY6hKAKUBK6b0Pn/1KonEk7/RsvtE2beoJkvym2o2FrYil0cnF59IDCY5F2h
	8lqP+Ga/hMcFJHe4xZlsoMCwg
X-Received: by 2002:a05:600c:64cc:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47d84b09250mr195011325e9.6.1768224127550;
        Mon, 12 Jan 2026 05:22:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDJ6tQs4rCkcz2rRpswvhE3OYFURr3aglB5GxYqkRI9WjKRZzWoUkm0sPtVtevYCQc/Y+8fQ==
X-Received: by 2002:a05:600c:64cc:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47d84b09250mr195011025e9.6.1768224127058;
        Mon, 12 Jan 2026 05:22:07 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86637b90sm139400205e9.2.2026.01.12.05.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:22:06 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Fix parse_cpu_set() and add unit test
Date: Mon, 12 Jan 2026 15:21:28 +0200
Message-ID: <20260112132140.156956-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2vgsAb_3se4HwsFBugMXIL1az7qfG9fAW5Y3ZGaPYKQ_1768224128
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The patch "Replace atoi() with a robust strtoi()" introduced a bug
in parse_cpu_set(), which relies on partial parsing of the input
string.

Restore the original use of atoi() in parse_cpu_set().

Add a unit test to prevent accidental regressions.

Fixes: 7e9dfccf8f11 ("rtla: Replace atoi() with a robust strtoi()")

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/Makefile           |  3 ++
 tools/tracing/rtla/src/utils.c        | 10 ++--
 tools/tracing/rtla/tests/Makefile     | 12 +++++
 tools/tracing/rtla/tests/test_utils.c | 74 +++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 6 deletions(-)
 create mode 100644 tools/tracing/rtla/tests/Makefile
 create mode 100644 tools/tracing/rtla/tests/test_utils.c

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 2701256abaf3..1805916c7dba 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -109,7 +109,10 @@ clean: doc_clean fixdep-clean
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
 	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
+
 check: $(RTLA) tests/bpf/bpf_action_map.o
+	make -C tests/ check
 	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f -v tests/
+
 examples: example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 18986a5aed3c..0da3b2470c31 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -128,18 +128,16 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	for (p = cpu_list; *p; ) {
-		if (strtoi(p, &cpu))
-			goto err;
-		if (cpu < 0 || cpu >= nr_cpus)
+		cpu = atoi(p);
+		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
 			goto err;
 
 		while (isdigit(*p))
 			p++;
 		if (*p == '-') {
 			p++;
-			if (strtoi(p, &end_cpu))
-				goto err;
-			if (end_cpu < cpu || end_cpu >= nr_cpus)
+			end_cpu = atoi(p);
+			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
 				goto err;
 			while (isdigit(*p))
 				p++;
diff --git a/tools/tracing/rtla/tests/Makefile b/tools/tracing/rtla/tests/Makefile
new file mode 100644
index 000000000000..fe187306a404
--- /dev/null
+++ b/tools/tracing/rtla/tests/Makefile
@@ -0,0 +1,12 @@
+LIBS := -lcheck
+
+test_utils: test_utils.c ../src/utils.c
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+
+check: test_utils
+	./test_utils
+
+clean:
+	rm -f test_utils
+
+.PHONY: check clean
diff --git a/tools/tracing/rtla/tests/test_utils.c b/tools/tracing/rtla/tests/test_utils.c
new file mode 100644
index 000000000000..92ed49d60d33
--- /dev/null
+++ b/tools/tracing/rtla/tests/test_utils.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Unit tests for src/utils.c parsing functions
+ */
+
+#define _GNU_SOURCE
+#include <check.h>
+#include <unistd.h>
+
+#include "../src/utils.h"
+
+START_TEST(test_parse_cpu_set)
+{
+	cpu_set_t set;
+	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	ck_assert_int_eq(parse_cpu_set("0", &set), 0);
+	ck_assert(CPU_ISSET(0, &set));
+	ck_assert(!CPU_ISSET(1, &set));
+
+	if (nr_cpus > 2) {
+		ck_assert_int_eq(parse_cpu_set("0,2", &set), 0);
+		ck_assert(CPU_ISSET(0, &set));
+		ck_assert(CPU_ISSET(2, &set));
+	}
+
+	if (nr_cpus > 3) {
+		ck_assert_int_eq(parse_cpu_set("0-3", &set), 0);
+		ck_assert(CPU_ISSET(0, &set));
+		ck_assert(CPU_ISSET(1, &set));
+		ck_assert(CPU_ISSET(2, &set));
+		ck_assert(CPU_ISSET(3, &set));
+	}
+
+	if (nr_cpus > 5) {
+		ck_assert_int_eq(parse_cpu_set("1-3,5", &set), 0);
+		ck_assert(!CPU_ISSET(0, &set));
+		ck_assert(CPU_ISSET(1, &set));
+		ck_assert(CPU_ISSET(2, &set));
+		ck_assert(CPU_ISSET(3, &set));
+		ck_assert(!CPU_ISSET(4, &set));
+		ck_assert(CPU_ISSET(5, &set));
+	}
+
+	ck_assert_int_ne(parse_cpu_set("-1", &set), 0);
+	ck_assert_int_ne(parse_cpu_set("abc", &set), 0);
+	ck_assert_int_ne(parse_cpu_set("9999", &set), 0);
+}
+END_TEST
+
+Suite *utils_suite(void)
+{
+	Suite *s = suite_create("utils");
+	TCase *tc = tcase_create("core");
+
+	tcase_add_test(tc, test_parse_cpu_set);
+
+	suite_add_tcase(s, tc);
+	return s;
+}
+
+int main(void)
+{
+	int num_failed;
+	SRunner *sr;
+
+	sr = srunner_create(utils_suite());
+	srunner_run_all(sr, CK_NORMAL);
+	num_failed = srunner_ntests_failed(sr);
+
+	srunner_free(sr);
+
+	return (num_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
+}
-- 
2.52.0

