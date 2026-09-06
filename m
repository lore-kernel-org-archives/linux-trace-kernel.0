Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C63BBFBC
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714670; cv=none; b=Ub+1U7rK4D9K5wPEwvRdxZfHLMJBehZZ231JaWZ23T5MEslpvJaudQKGrPUTFFKd7MCbnD7O62cjCQEIeVPr3R0nBhBvDKoYGAa1Og5wocWkcneJdyd1qFeF2Jo164PeykgfUCEp1f6S+ez+y9YnqnEFVGHzGraY8SYZl9JoVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714670; c=relaxed/simple;
	bh=OW4UqLTrNI7q54EASlGxQ7moAEK5tuNqr5Zpl0Z108A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NeZhebesGUhF1Hl/iKA5nYoHBUGTVX5VbunICvqNGwEsKmDQhO4Wx7XA8RjqXEjVDG3uFQZd5hq2dvSKlNgpDWQjlFUYvxppkO5a9SssuIGji7ALx2k6idHpm/7+r5KlswPCoN56ntNAOnRMLfeZyusGrzoo64gwFt+BkL5hVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dzPaHW5s; arc=none smtp.client-ip=91.218.175.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dzPaHW5s"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OW4UqLTrNI7q54EASlGxQ7moAEK5tuNqr5Zpl0Z108A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788714666; v=1; x=1789319466;
 b=dzPaHW5smGFPxu8zV1Xzgu49dvQ3Jf0TG0KSl1nSkPEMsilStQmOibAfoUkQF6LzHae2A3xq
 7C/P8bRfz7Pr9N84/RInY1ni+djd/p8ON9V2o9WUtousaQ/IpHTLps5mu4T20AKFOUsetZuDG7k
 /q3RY5podOiHliBx3MgJAO54=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 4fb2ac31f6cbe7cb;
	Sun, 06 Sep 2026 17:11:06 +0000
X-Mizu-Trace-ID: 4fb2ac31f6cbe7cb
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 5/5] selftests/verification: Test loadable module-based reactor
Date: Mon,  7 Sep 2026 01:10:41 +0800
Message-Id: <8337c115db6ca718a0d442ad85f0d2d4eaa2422b.1788705281.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1788705281.git.wen.yang@linux.dev>
References: <cover.1788705281.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add a selftest module that register an RV reactor and a test that
exercises the module pinning: rmmod must fail while a monitor is
attached to the reactor and succeed after it is detached. A trap
unloads the module on failure so it does not break the next insmod.

THe module is built through the kselftest TEST_GEN_MODS_DIR mechanism,
like the livepatch selftests.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/testing/selftests/verification/Makefile |  1 +
 tools/testing/selftests/verification/config   |  2 +
 .../test.d/rv_reactor_loadable.tc             | 46 +++++++++++++++++++
 .../verification/test_modules/Makefile        | 16 +++++++
 .../test_modules/rv_test_reactor.c            | 37 +++++++++++++++
 5 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/verification/test.d/rv_reactor_loadable.tc
 create mode 100644 tools/testing/selftests/verification/test_modules/Makefile
 create mode 100644 tools/testing/selftests/verification/test_modules/rv_test_reactor.c

diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/selftests/verification/Makefile
index aa8790c22a71..7ff7382d11f0 100644
--- a/tools/testing/selftests/verification/Makefile
+++ b/tools/testing/selftests/verification/Makefile
@@ -3,6 +3,7 @@ all:
 
 TEST_PROGS := verificationtest-ktap
 TEST_FILES := test.d settings
+TEST_GEN_MODS_DIR := test_modules
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
 include ../lib.mk
diff --git a/tools/testing/selftests/verification/config b/tools/testing/selftests/verification/config
index 43072c1c38f4..ddd7581f07b9 100644
--- a/tools/testing/selftests/verification/config
+++ b/tools/testing/selftests/verification/config
@@ -1 +1,3 @@
 CONFIG_RV=y
+CONFIG_MODULES=y
+CONFIG_MODULES_UNLOAD=y
diff --git a/tools/testing/selftests/verification/test.d/rv_reactor_loadable.tc b/tools/testing/selftests/verification/test.d/rv_reactor_loadable.tc
new file mode 100644
index 000000000000..ff1691661521
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_reactor_loadable.tc
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test a loadable module-based reactor
+# requires: available_reactors insmod:program rmmod:program
+
+MODULE_KO="$FTRACETEST_ROOT/test_modules/rv_test_reactor.ko"
+[ -f "$MODULE_KO" ] || exit_unsupported
+[ -f /proc/modules ] || exit_unsupported
+monitor=$(ls monitors | head -n 1)
+[ -n "$monitor" ] || exit_unsupported
+
+cleanup() {
+	if grep -q '^test_reactors$' available_reactors; then
+		echo nop > "monitors/$monitor/reactors" || true
+		rmmod rv_test_reactor || true
+	fi
+}
+trap cleanup EXIT
+
+test_loadable_reactor() {
+	local monitor="$1"
+
+	insmod "$MODULE_KO"
+	grep -q test_reactor available_reactors
+
+	echo test_reactor > "monitors/$monitor/reactors"
+	grep -q "\[test_reactor\]"  "monitors/$monitor/reactors"
+
+	echo 1 > "monitors/$monitor/enable"
+
+	if rmmod rv_test_reactor 2> /dev/null; then
+		echo "FAIL: rmmod succeeded while the reactor is attached to a monitor"
+		return 1
+	fi
+	grep -q test_reactor available_reactors
+
+	echo nop > "monitors/$monitor/reactors"
+	grep -q "\[nop\]"  "monitors/$monitor/reactors"
+	grep -q 1 "monitors/$monitor/enable"
+
+	echo 0 > "monitors/$monitor/enable"
+	rmmod rv_test_reactor
+	! grep -q test_reactor available_reactors
+}
+
+test_loadable_reactor "$monitor"
diff --git a/tools/testing/selftests/verification/test_modules/Makefile b/tools/testing/selftests/verification/test_modules/Makefile
new file mode 100644
index 000000000000..0af95207a9a9
--- /dev/null
+++ b/tools/testing/selftests/verification/test_modules/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= /lib/modules/$(shell uname -r)/build
+
+obj-m += rv_test_reactor.o
+
+modules:
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
+endif
+
+clean:
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
+endif
diff --git a/tools/testing/selftests/verification/test_modules/rv_test_reactor.c b/tools/testing/selftests/verification/test_modules/rv_test_reactor.c
new file mode 100644
index 000000000000..a243df81fa52
--- /dev/null
+++ b/tools/testing/selftests/verification/test_modules/rv_test_reactor.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loadable RV reactor for the verification selftests. Register a
+ * reactor with owner = THIS_MODULE so the selftests can exercise the
+ * module pinning: unloading is refused while a monitor is attached
+ * to the reactor.
+ */
+
+#include <linux/module.h>
+#include <linux/rv.h>
+
+__printf(1, 0) static void rv_test_reaction(const char *msg, va_list args)
+{
+}
+
+static struct rv_reactor rv_test_reactor = {
+	.name = "test_reactor",
+	.description = "selftest reactor: exercise module-based reactors.",
+	.react = rv_test_reaction,
+	.owner = THIS_MODULE,
+};
+
+static int __init rv_test_reactor_init(void)
+{
+	return rv_register_reactor(&rv_test_reactor);
+}
+
+static void __exit rv_test_reactor_exit(void)
+{
+	rv_unregister_reactor(&rv_test_reactor);
+}
+
+module_init(rv_test_reactor_init);
+module_exit(rv_test_reactor_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Loadable RV reactor for verification selftests");
-- 
2.25.1

