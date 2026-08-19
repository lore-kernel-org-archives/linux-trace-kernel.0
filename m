Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BFA4C901C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163382; cv=none; b=r4Jq4QkMpK8fr+gRrqn8rFiINo7H8/V+PDvetaJJceI+yr13/V51iABb5bJHPq9ldxEjB6/kCEYE0sYDbWc3AnjNw8qMJwbjXSbsSw73rQMthZxM6mVDPbpMpC1S2HJz5Pgjz4waCeteUxuB2xD8tvDs974ToKACiy1sPORbL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163382; c=relaxed/simple;
	bh=O6wPhTlvYSGNmaw5MhHkSj9M+7EfUqoVKJePTK8KJBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Srj4KriEfJ3FrzUjkMFxbrHtrhuyDBn295Q4H5XBNCGzt7TQs1K+JDoWa9aoHyjozHlNQpl3alEugzdi8DOpk47YHt7CyrV3/4VJCseopLbEYmlgC/8x3NzVecOCusVaAx5nMvyC4o1/9Fl1SDENEQSRNUZtC3KKKTI9ENnzDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=trTVV4Yx; arc=none smtp.client-ip=91.218.175.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="trTVV4Yx"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O6wPhTlvYSGNmaw5MhHkSj9M+7EfUqoVKJePTK8KJBs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163377; v=1; x=1787768177;
 b=trTVV4YxXtLRo9oI1+fTCVRrDFRL6CvmBQ4klFkdr1W6xqjbAm8Qvt+Gj1mCYESnMYK+nHYF
 pvs9B4B6tJiTL0pd5oRPOHqs4ptgdO5eP88p+ba1zDt83N8GkcM0pCmxHwG79C4qpC4MFWGkt9r
 O6wMzvXrsm60LaQzNL8oEkNU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (180.165.15.98)
	by mta12.migadu.com with ESMTPS id 722494209e9da1df;
	Wed, 19 Aug 2026 18:16:17 +0000
X-Mizu-Trace-ID: 722494209e9da1df
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 9/9] selftests/ftrace: Walk up to find test.d/functions when a subdirectory is passed
Date: Thu, 20 Aug 2026 02:15:26 +0800
Message-Id: <7808194405719fd0ae7b0bcf4301c5902eb31929.1787161646.git.wen.yang@linux.dev>
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

When a test directory that does not itself contain test.d/functions is
passed to ftracetest (e.g. verification/test.d/tlob/), ftracetest fell
back to its own functions file and lost the rv-specific check_requires
handling for ':monitor' and ':reactor' requirements.

Walk up the directory tree from OPT_TEST_DIR until a directory containing
test.d/functions is found. This allows monitor subdirectories to be passed
directly as the test root without placing a functions shim in each one.

The RV verification suite uses this so that

  tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh

can pass test.d/tlob/ to ftracetest and have it source
verification/test.d/functions (which understands ':monitor'/':reactor').

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/testing/selftests/ftrace/ftracetest | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 0a56bf209f6c..3ba929820dd2 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -159,9 +159,20 @@ parse_opts() { # opts
   if [ -n "$OPT_TEST_CASES" ]; then
     TEST_CASES=$OPT_TEST_CASES
   fi
-  if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ]; then
-    TOP_DIR=$OPT_TEST_DIR
-    TEST_DIR=$TOP_DIR/test.d
+  if [ -n "$OPT_TEST_DIR" ]; then
+    # Walk up from OPT_TEST_DIR to find the nearest ancestor that contains
+    # test.d/functions.  This allows a monitor subdirectory (e.g.
+    # verification/test.d/tlob/) to be passed directly without placing a
+    # dummy functions shim in each new subdirectory.
+    dir=$OPT_TEST_DIR
+    while [ "$dir" != "/" ]; do
+      if [ -f "$dir/test.d/functions" ]; then
+        TOP_DIR=$dir
+        TEST_DIR=$TOP_DIR/test.d
+        break
+      fi
+      dir=$(dirname "$dir")
+    done
   fi
 }
 
-- 
2.25.1

