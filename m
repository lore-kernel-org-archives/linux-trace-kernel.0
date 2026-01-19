Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B72276050
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820425; cv=none; b=hMs12B53/gunJZUM5iCXPGuyWfhcVKZqCV2Rh77ms2tRkYrmhLrL3ZREsavoBCPmS549bjIQMOBHs5q1e2A5ZGOUc9ve5VzcdStgy8G4T2YptvN18WiEz3Gnl7CiBgrW0OUyQuWEDGX9Sgk8ojGmJJ5cCln8c9t7RMaHJ97/43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820425; c=relaxed/simple;
	bh=ez8aOnbh/mA/GGI1tyq+dSDzRfB5tvxRONXjcBSQbKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=B8Oufkx2BxCT3GF9XCZFnIoAJpQRxNfGhvWMUjV9HtmEZFgm/VEclXlThTAFb9kRdnzHkhEl1yNgpQNlxBhkDIhmbKRqQxZRsR1Be0PuiSuwevLW93kUNY3+IdMyrHQquaATR4rroWjZscLDoRKVjvD5PDGshyTUNOOhiISWD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcPXZoBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcPXZoBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768820422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeqBKSIGtMGISMXlLxGNxdibLP5FYPHmt6b8d363gek=;
	b=CcPXZoBFeG9d/jB1grlWhroV25hrJt4IuViSP3YJFwZZeRovJbBfN9FssGPM3voGHwZhn6
	pGj2HWhGsdzpE7/Y5lEFgBbHvVc5LifEfdP27feAHmmDtzFBxIDY+dSCcLFHb0V4R6vRyb
	WF76MvClqMy5VuZgEZsC3aSjSyZDi1A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-EsiQPfTSOFWlwaWBBtYLCw-1; Mon, 19 Jan 2026 06:00:21 -0500
X-MC-Unique: EsiQPfTSOFWlwaWBBtYLCw-1
X-Mimecast-MFC-AGG-ID: EsiQPfTSOFWlwaWBBtYLCw_1768820420
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432586f2c82so3210500f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 03:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820420; x=1769425220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NeqBKSIGtMGISMXlLxGNxdibLP5FYPHmt6b8d363gek=;
        b=vsKzyLD4rdszi9zjs1n+iaLoAYr8DY3wfnbTFCfJ5r3pPtdl0p0hIWaUoXUZRs1RhO
         EGl8BsLyQv4443euVM043mrdndKA1lU38AQWFvgPbpMxDB4HJLbVvA61gtITpB+9SzNw
         EH2oM9JnYt3+ficGe2fxKMAV6Cl0sTRTpJ+frwTGnNjUBTteSXbdVzvclds4Z1FYAPVZ
         DzdUjtc5asJe2clReNzy7hdeBDfUjhtUTwh6UFgVsao75byhjGVCI4HEtGzWZOuqCMyb
         Yqn4uCzVeiVAYmWLx2MisdnuKrfEkt1139TCv2nskV41GwYJmDbehmfUufhVg0EnmA28
         pTMw==
X-Forwarded-Encrypted: i=1; AJvYcCVflT8R9oiir0JkRP3rhQTDVzsrfNGUrkVLOa/tHyDFEoseFEv/GqUJ8GvOsBZayOMMjfLxukFEDeEywT333PemaxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfC9S6ZDumCiaKVX3/TIQ4Q/Wg9MYQMyxm7cJywfzIu25tT7JF
	by/wRSMCV/d7VJrU1lClZOTnziJvRwCDdiNuftpHzvPS2zJHMpF2PE9pF+V58fvfG9JPUbK6BP6
	MFH3pcis7jrbdMhDnUFHZhRNoK/Sc9oJdk5pWGB4tngn96BGG4uRZH81ewXHdCfwOeajjoNpdoQ
	==
X-Gm-Gg: AZuq6aIISFB3o3YSRu9jLbgYsT7uYeDsbFvsK3c7J4wJcC1YDclnyhVauMQJ3xj2iQZ
	Y9MxnvOb55TDpxocLbbt0leBfEtPJ54ygcGzdgFkY4kPPEq7iB1F5w49wVqXkqwa6MOiUBl4pGr
	X3wl18hEwhIn8mCXnBA2iYvRpeCfFrpeoHpgOU3MGsA7bCybpd2s2n+AoiiI9Ew4feDjn1CsJDj
	26sguo40oNInEyZ/wmJH5goJ0sOnQrhyo1s4ijG9eL7EzNwpwD9YHb0dZKA4M7Onwrwkxsx84wX
	w/Qo/xtKjVr9IXgEXHQh27nIg5tqmJMoUf4nk21BgSkO/r4y1JAR+aAm17okTtrDZOx88P9oyow
	IrsCw2iB1mpyaOhG2F77tTg==
X-Received: by 2002:a05:6000:250e:b0:431:1c7:f967 with SMTP id ffacd0b85a97d-4356955eef8mr15330933f8f.17.1768820420132;
        Mon, 19 Jan 2026 03:00:20 -0800 (PST)
X-Received: by 2002:a05:6000:250e:b0:431:1c7:f967 with SMTP id ffacd0b85a97d-4356955eef8mr15330855f8f.17.1768820419491;
        Mon, 19 Jan 2026 03:00:19 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569922032sm23320735f8f.8.2026.01.19.03.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:00:19 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Blake Jones <blakejones@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] tools/rtla: Add unit tests for utils.c
Date: Mon, 19 Jan 2026 12:58:57 +0200
Message-ID: <20260119105857.797498-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119105857.797498-1-costa.shul@redhat.com>
References: <20260119105857.797498-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qgaksSaMY66eciSkuu6WIWqB_KJZl645FY-Lh8ksCxE_1768820420
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add unit tests for utility functions in src/utils.c using the Check
testing framework. The tests verify parse_cpu_set(), strtoi(), and
parse_prio() functions.

Unit tests are built conditionally when libcheck is available.
Run tests with 'make unit-test'.

The test framework uses the Check library which provides process
isolation for each test, preventing failures in one test from
affecting others.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---

v2: Address feedback from Tomas Glozar
- Split the patch.
- Extract separate target unit-test.
- use build system

- libcheck: document, add to tools/build dependency detection
---
 tools/tracing/rtla/Build                    |   1 +
 tools/tracing/rtla/Makefile                 |   5 +
 tools/tracing/rtla/Makefile.config          |   8 ++
 tools/tracing/rtla/README.txt               |   1 +
 tools/tracing/rtla/tests/unit/Build         |   2 +
 tools/tracing/rtla/tests/unit/Makefile.unit |  17 +++
 tools/tracing/rtla/tests/unit/unit_tests.c  | 123 ++++++++++++++++++++
 7 files changed, 157 insertions(+)
 create mode 100644 tools/tracing/rtla/tests/unit/Build
 create mode 100644 tools/tracing/rtla/tests/unit/Makefile.unit
 create mode 100644 tools/tracing/rtla/tests/unit/unit_tests.c

diff --git a/tools/tracing/rtla/Build b/tools/tracing/rtla/Build
index 6c9d5b36a315..3ce2e0f567fd 100644
--- a/tools/tracing/rtla/Build
+++ b/tools/tracing/rtla/Build
@@ -1 +1,2 @@
 rtla-y += src/
+unit_tests-y += tests/unit/
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 2701256abaf3..45690ee14544 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -33,12 +33,14 @@ DOCSRC		:= ../../../Documentation/tools/rtla/
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
 FEATURE_TESTS	+= libcpupower
+FEATURE_TESTS	+= libcheck
 FEATURE_TESTS	+= libbpf
 FEATURE_TESTS	+= clang-bpf-co-re
 FEATURE_TESTS	+= bpftool-skeletons
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 FEATURE_DISPLAY	+= libcpupower
+FEATURE_DISPLAY	+= libcheck
 FEATURE_DISPLAY	+= libbpf
 FEATURE_DISPLAY	+= clang-bpf-co-re
 FEATURE_DISPLAY	+= bpftool-skeletons
@@ -47,6 +49,7 @@ all: $(RTLA)
 
 include $(srctree)/tools/build/Makefile.include
 include Makefile.rtla
+include tests/unit/Makefile.unit
 
 # check for dependencies only on required targets
 NON_CONFIG_TARGETS := clean install tarball doc doc_clean doc_install
@@ -109,6 +112,8 @@ clean: doc_clean fixdep-clean
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
 	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
+	$(Q)rm -f $(UNIT_TESTS)
+
 check: $(RTLA) tests/bpf/bpf_action_map.o
 	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f -v tests/
 examples: example/timerlat_bpf_action.o
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 07ff5e8f3006..0bdd258b76de 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -61,6 +61,14 @@ else
   $(info Please install libcpupower-dev/kernel-tools-libs-devel)
 endif
 
+$(call feature_check,libcheck)
+ifeq ($(feature-libcheck), 1)
+  $(call detected,CONFIG_LIBCHECK)
+else
+  $(info libcheck is missing, building without unit tests support.)
+  $(info Please install check-devel/check)
+endif
+
 ifndef BUILD_BPF_SKEL
   # BPF skeletons are used to implement improved sample collection, enable
   # them by default.
diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index 43e98311d10f..a9faee4dbb3a 100644
--- a/tools/tracing/rtla/README.txt
+++ b/tools/tracing/rtla/README.txt
@@ -12,6 +12,7 @@ RTLA depends on the following libraries and tools:
  - libtracefs
  - libtraceevent
  - libcpupower (optional, for --deepest-idle-state)
+ - libcheck (optional, for unit tests)
 
 For BPF sample collection support, the following extra dependencies are
 required:
diff --git a/tools/tracing/rtla/tests/unit/Build b/tools/tracing/rtla/tests/unit/Build
new file mode 100644
index 000000000000..5f1e531ea8c9
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/Build
@@ -0,0 +1,2 @@
+unit_tests-y += unit_tests.o
+unit_tests-y +=../../src/utils.o
diff --git a/tools/tracing/rtla/tests/unit/Makefile.unit b/tools/tracing/rtla/tests/unit/Makefile.unit
new file mode 100644
index 000000000000..2088c9cc3571
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/Makefile.unit
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+UNIT_TESTS := $(OUTPUT)unit_tests
+UNIT_TESTS_IN := $(UNIT_TESTS)-in.o
+
+$(UNIT_TESTS): $(UNIT_TESTS_IN)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^ -lcheck
+
+$(UNIT_TESTS_IN):
+	make $(build)=unit_tests
+
+unit-tests: FORCE
+	$(Q)if [ "$(feature-libcheck)" = "1" ]; then \
+		$(MAKE) $(UNIT_TESTS) && $(UNIT_TESTS); \
+	else \
+		echo "libcheck is missing, skipping unit tests. Please install check-devel/check"; \
+	fi
diff --git a/tools/tracing/rtla/tests/unit/unit_tests.c b/tools/tracing/rtla/tests/unit/unit_tests.c
new file mode 100644
index 000000000000..aa53f8605e36
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/unit_tests.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <check.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <limits.h>
+#include <unistd.h>
+
+#include "../../src/utils.h"
+
+START_TEST(test_strtoi)
+{
+	int result;
+	char buf[64];
+
+	ck_assert_int_eq(strtoi("123", &result), 0);
+	ck_assert_int_eq(result, 123);
+	ck_assert_int_eq(strtoi(" -456", &result), 0);
+	ck_assert_int_eq(result, -456);
+
+	snprintf(buf, sizeof(buf), "%d", INT_MAX);
+	ck_assert_int_eq(strtoi(buf, &result), 0);
+	snprintf(buf, sizeof(buf), "%ld", (long)INT_MAX + 1);
+	ck_assert_int_eq(strtoi(buf, &result), -1);
+
+	ck_assert_int_eq(strtoi("", &result), -1);
+	ck_assert_int_eq(strtoi("123abc", &result), -1);
+	ck_assert_int_eq(strtoi("123 ", &result), -1);
+}
+END_TEST
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
+	ck_assert_int_eq(parse_cpu_set("-1", &set), 1);
+	ck_assert_int_eq(parse_cpu_set("abc", &set), 1);
+	ck_assert_int_eq(parse_cpu_set("9999", &set), 1);
+}
+END_TEST
+
+START_TEST(test_parse_prio)
+{
+	struct sched_attr attr;
+
+	ck_assert_int_eq(parse_prio("f:50", &attr), 0);
+	ck_assert_uint_eq(attr.sched_policy, SCHED_FIFO);
+	ck_assert_uint_eq(attr.sched_priority, 50U);
+
+	ck_assert_int_eq(parse_prio("r:30", &attr), 0);
+	ck_assert_uint_eq(attr.sched_policy, SCHED_RR);
+
+	ck_assert_int_eq(parse_prio("o:0", &attr), 0);
+	ck_assert_uint_eq(attr.sched_policy, SCHED_OTHER);
+	ck_assert_int_eq(attr.sched_nice, 0);
+
+	ck_assert_int_eq(parse_prio("d:10ms:100ms", &attr), 0);
+	ck_assert_uint_eq(attr.sched_policy, 6U);
+
+	ck_assert_int_eq(parse_prio("f:999", &attr), -1);
+	ck_assert_int_eq(parse_prio("o:-20", &attr), -1);
+	ck_assert_int_eq(parse_prio("d:100ms:10ms", &attr), -1);
+	ck_assert_int_eq(parse_prio("x:50", &attr), -1);
+}
+END_TEST
+
+Suite *utils_suite(void)
+{
+	Suite *s = suite_create("utils");
+	TCase *tc = tcase_create("core");
+
+	tcase_add_test(tc, test_strtoi);
+	tcase_add_test(tc, test_parse_cpu_set);
+	tcase_add_test(tc, test_parse_prio);
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

