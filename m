Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E61E32AA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jan 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381448; cv=none; b=pQLiDi/5pD7D2Bb/XeAZhMUD1Va5IrwtBNNS+kf+Nk2Vt7+H05gSjw4MaAfJT4S89W6wkyxqxNOU0m1vGTmSnI6S+PYicNtM3m/dzBVs/AYWUhlZhdgkDENFTkj2lk++etiYl9+UCwt2EaLFTNZQhGsqEO/75Y8gtUyGUQL0PQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381448; c=relaxed/simple;
	bh=rvCuSwGkqwn66YLxJ9JZEmuxXHsDpO3IBf4RM/+V9TI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWpBdnIFB5Xhn2HXMR/v7y9JigsLV2AQfwAx3CSTeyJzE4h2PMAzq6nRjvS+0fjBIvqcGcW3S+skFP4Dsn9xLA+X9hrRkzaIRbo29bUncAMa8sD9IxdnAel3f2cY4mkPVgez5wkpsUlH1r/wduxY15MYU3q3L8ggSlL8Xxf3yz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTZ986eE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTZ986eE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737381446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xh1PThZzjoyMRmJPskfVaz0KL0DrPNnQ746UIqOEatQ=;
	b=GTZ986eEyGwqOH7cxhzYIXwP54+LNtIxEdXNzkSTZeAieAqNYjFJNu2tiPFeDpgkHft16C
	PtWQUXCptGGplGZRGlhrEgh+wJuP5AxyNCoW9qcQN35DmM6JriIRvo5OPGYa0hrkoega3/
	yQZt4VShT+q1Lz9Kgd01KreQdws0L3E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-nH9PK1p2P0iEjioAds6fbA-1; Mon,
 20 Jan 2025 08:57:23 -0500
X-MC-Unique: nH9PK1p2P0iEjioAds6fbA-1
X-Mimecast-MFC-AGG-ID: nH9PK1p2P0iEjioAds6fbA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3BF61955D9C;
	Mon, 20 Jan 2025 13:57:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E43EA1956053;
	Mon, 20 Jan 2025 13:57:19 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Chang Yin <cyin@redhat.com>,
	Qiao Zhao <qzhao@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2] tools/rtla: Add basic test suite
Date: Mon, 20 Jan 2025 14:56:30 +0100
Message-ID: <20250120135630.802111-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Implement a simple TAP-based test engine in bash and a few basic tests
using it, to be used to check for bugs and regressions.

A new "check" target is added to the rtla Makefile that runs the test suite
using the "prove" command implemented by Test::Harness.

The only test format currently supported is running rtla with defined
command arguments per test, checking its exit code. In case the exit
code is non-zero, the output of rtla is displayed, together with the
exit code.

The test cases are adopted from rtla tests in the Continuous Kernel
Integration (CKI) project [1] with the authors' approval.

[1] https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/blob/main/rt-tests/us/rtla/

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---

Changes v2:
- Add 2m timeout (with additional 15s kill timeout) to terminate rtla in case
tracer or rtla gets stuck
- Display exit code when it is non-zero together with the output
- Use stdbuf to prevent buffering from eating rtla output if rtla crashes
- Remove control characters from rtla output to prevent messing up of
the terminal

 tools/tracing/rtla/Makefile         |  4 ++-
 tools/tracing/rtla/tests/engine.sh  | 48 +++++++++++++++++++++++++++++
 tools/tracing/rtla/tests/hwnoise.t  | 21 +++++++++++++
 tools/tracing/rtla/tests/osnoise.t  | 19 ++++++++++++
 tools/tracing/rtla/tests/timerlat.t | 27 ++++++++++++++++
 5 files changed, 118 insertions(+), 1 deletion(-)
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
index 000000000000..64d0446dc28e
--- /dev/null
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -0,0 +1,48 @@
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
+		result=$(stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
+		if [ $exitcode -eq 0 ]
+		then
+			echo "ok $ctr - $1"
+		else
+			echo "not ok $ctr - $1"
+			# Add rtla output and exit code as comments in case of failure
+			echo "$result" | col -b | while read line; do echo "# $line"; done
+			printf "#\n# exit code %s\n" $exitcode
+		fi
+	fi
+}
+
+set_timeout() {
+	TIMEOUT="timeout -v -k 15s $1"
+}
+
+unset_timeout() {
+	unset TIMEOUT
+}
+
+test_end() {
+	# If running without TEST_COUNT, tests are not actually run, just
+	# counted. In that case, re-run the test with the correct count.
+	[ -z "$TEST_COUNT" ] && TEST_COUNT=$ctr exec bash $0 || true
+}
+
+# Avoid any environmental discrepancies
+export LC_ALL=C
+unset_timeout
diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
new file mode 100644
index 000000000000..bbed17580537
--- /dev/null
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/engine.sh
+test_begin
+
+set_timeout 2m
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
index 000000000000..86596e547893
--- /dev/null
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/engine.sh
+test_begin
+
+set_timeout 2m
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
index 000000000000..e86f40e5749e
--- /dev/null
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/engine.sh
+test_begin
+
+set_timeout 2m
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
2.48.1

