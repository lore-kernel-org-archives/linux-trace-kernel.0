Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95ED219A9A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jan 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430200; cv=none; b=MGslfnSEi7G2Qnwof2Q/b0Th/IvQGtSIJXvspu7mLA1DkRBfaFoL8bdZrSctGNjqNJLJpq3BNBR1vRBIS93OKnHl8cHNDQ657x+o/fwFpHVR3OdsluNCxFUu2jOtOyTHxF7f627XBzPYGh2wt6xu8SfidWbAzGCJn0BwkOQqqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430200; c=relaxed/simple;
	bh=NNiKZlDesZrQ5MxRZqNtDbJsKMvrQkXGgTU/JW1Nyb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIZZwSb5H6KjMDemy9/eE5qMeCndOOPPr2whSTz3l4EN8u7u3oCLlW3X9AakVlmTwsV5AWJU7sKRS7orl9h1Nsn0MEv52iaZnMAeYWgE+AAKvFemCr8BFztsgd0j3zAVngd7TDix5hJ2RUytLDvXe28D9G36FNwCNf1NlfhHw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hmd9+3d6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hmd9+3d6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736430197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TihcAEV138XMIe717CqBIKAsKj1kH3m5ChCM4UzhiGk=;
	b=Hmd9+3d6xUBbopYCw3afJl1aOc4KyY5hjQ+YqOnylHaqMIdczu305j3w1OqT6OdH99LAY4
	GdMhuXtp9uvDo8K6hBjvBxw7EDNY8bg+wluSNy4uLto1wH2dNW9HsNGv96fmiLi+HHI+mN
	2Q/MWc8n3pNFXmvXWU9S6RIaLWHFShA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-x9BemdXrN4m3m9BKN8bBgw-1; Thu,
 09 Jan 2025 08:43:14 -0500
X-MC-Unique: x9BemdXrN4m3m9BKN8bBgw-1
X-Mimecast-MFC-AGG-ID: x9BemdXrN4m3m9BKN8bBgw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67B421955D8F;
	Thu,  9 Jan 2025 13:43:13 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84D9E195E3D9;
	Thu,  9 Jan 2025 13:43:09 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Chang Yin <cyin@redhat.com>,
	Qiao Zhao <qzhao@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] tools/rtla: Add basic test suite
Date: Thu,  9 Jan 2025 14:38:52 +0100
Message-ID: <20250109133852.360122-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Implement a simple TAP-based test engine in bash and a few basic tests
using it, to be used to check for bugs and regressions.

A new "check" target is added to the rtla Makefile that runs the test suite
using the "prove" command implemented by Test::Harness.

The only test format currently supported is running rtla with defined
command arguments per test, checking its exit code. In case the exit
code is non-zero, the output of rtla is displayed.

The test cases are adopted from rtla tests in the Continuous Kernel
Integration (CKI) project [1] with the authors' approval.

[1] https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/blob/main/rt-tests/us/rtla/

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile         |  4 +++-
 tools/tracing/rtla/tests/engine.sh  | 29 +++++++++++++++++++++++++++++
 tools/tracing/rtla/tests/hwnoise.t  | 19 +++++++++++++++++++
 tools/tracing/rtla/tests/osnoise.t  | 17 +++++++++++++++++
 tools/tracing/rtla/tests/timerlat.t | 25 +++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 tools/tracing/rtla/tests/engine.sh
 create mode 100644 tools/tracing/rtla/tests/hwnoise.t
 create mode 100644 tools/tracing/rtla/tests/osnoise.t
 create mode 100644 tools/tracing/rtla/tests/timerlat.t

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index a6a7dee16622..8b5101457c70 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -85,4 +85,6 @@ clean: doc_clean fixdep-clean
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
-.PHONY: FORCE clean
+check: $(RTLA)
+	RTLA=$(RTLA) prove -o -f tests/
+.PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
new file mode 100644
index 000000000000..547490960a77
--- /dev/null
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+test_begin() {
+	# Count tests to allow the test harness to double-check if all were
+	# included correctly.
+	ctr=0
+	[ -z "$RTLA" ] && RTLA="./rtla"
+	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
+}
+
+check() {
+	# Simple check: run rtla with given arguments and test exit code.
+	# If TEST_COUNT is set, run the test. Otherwise, just count.
+	ctr=$(($ctr + 1))
+	if [ -n "$TEST_COUNT" ]
+	then
+		# Run rtla; in case of failure, include its output as comment
+		# in the test results.
+		result=$("$RTLA" $2 2>&1) && echo "ok $ctr - $1" || echo "not ok $ctr - $1
+$(echo "$result" | while read line; do echo "# $line"; done)
+"
+	fi
+}
+
+test_end() {
+	# If running without TEST_COUNT, tests are not actually run, just
+	# counted. In that case, re-run the test with the correct count.
+	[ -z "$TEST_COUNT" ] && TEST_COUNT=$ctr exec bash $0 || true
+}
diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
new file mode 100644
index 000000000000..491383e30373
--- /dev/null
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/engine.sh
+test_begin
+
+check "verify help page" \
+	"hwnoise --help"
+check "detect noise higher than one microsecond" \
+	"hwnoise -c 0 -T 1 -d 5s -q"
+check "set the automatic trace mode" \
+	"hwnoise -a 5 -d 30s"
+check "set scheduling param to the osnoise tracer threads" \
+	"hwnoise -P F:1 -c 0 -r 900000 -d 1M -q"
+check "stop the trace if a single sample is higher than 1 us" \
+	"hwnoise -s 1 -T 1 -t -d 30s"
+check "enable a trace event trigger" \
+	"hwnoise -t -e osnoise:irq_noise trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 1m"
+
+test_end
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
new file mode 100644
index 000000000000..83a7625d2226
--- /dev/null
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/engine.sh
+test_begin
+
+check "verify help page" \
+	"osnoise --help"
+check "verify the --priority/-P param" \
+	"osnoise top -P F:1 -c 0 -r 900000 -d 1M -q"
+check "verify the --stop/-s param" \
+	"osnoise top -s 30 -T 1 -t"
+check "verify the  --trace param" \
+	"osnoise hist -s 30 -T 1 -t"
+check "verify the --entries/-E param" \
+	"osnoise hist -P F:1 -c 0 -r 900000 -d 1M -b 10 -E 25"
+
+test_end
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
new file mode 100644
index 000000000000..a17218a064bb
--- /dev/null
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -0,0 +1,25 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/engine.sh
+test_begin
+
+check "verify help page" \
+	"timerlat --help"
+check "verify -s/--stack" \
+	"timerlat top -s 3 -T 10 -t"
+check "verify -P/--priority" \
+	"timerlat top -P F:1 -c 0 -d 1M -q"
+check "test in nanoseconds" \
+	"timerlat top -i 2 -c 0 -n -d 30s"
+check "set the automatic trace mode" \
+	"timerlat top -a 5 --dump-tasks"
+check "print the auto-analysis if hits the stop tracing condition" \
+	"timerlat top --aa-only 5"
+check "disable auto-analysis" \
+	"timerlat top -s 3 -T 10 -t --no-aa"
+check "verify -c/--cpus" \
+	"timerlat hist -c 0 -d 30s"
+check "hist test in nanoseconds" \
+	"timerlat hist -i 2 -c 0 -n -d 30s"
+
+test_end
-- 
2.47.1

