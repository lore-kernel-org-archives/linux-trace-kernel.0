Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FDA47DF85
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244390; cv=none; b=p9FijoUA/YXGoDes5dKVOUACKgojhNfUG9Ei+PlAxcPIu2RE0l/ETwe0P2a9vBTVCYXr+n5K6HV8GpjOgqEQ2sQ5snfxdOtAT9Is1JbGp0ZBxHOEq+wgqHWzfe5SbAxhXEs/sUqzyRvywmIp1jCz5X1L8M6AAgWavFGMuo6azBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244390; c=relaxed/simple;
	bh=Ha/62liyVjjYso+YfSdBtz/c3JQY06c0daIz4kcDe8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=usfD4B2bYzpCi1EPIZUv3bhMAx/jq2iPhEJwdocHrL3FmOkCoEHCfY6+BnPkNxHWxPS0JPSuVfYsMDsyI/Hc48oN/izbnzbSLSt6rg0FzMrmjaK6DezsZQykGoiknv0cA5LEZues9n9ppINIpMYllCrCZkcduI4L7s2dfSwhXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jy54ngyN; arc=none smtp.client-ip=95.215.58.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jy54ngyN"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ha/62liyVjjYso+YfSdBtz/c3JQY06c0daIz4kcDe8U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244386; v=1; x=1787849186;
 b=jy54ngyNXfFNdisQo9Yza0t8F3e3YqVguueYkNVADi7EHUDG7j08gTjYGTUQzidTHaANeI2V
 U2Sos4p1/FvT7v3uPwzAbs6FuCsmSFcAKAqkBTpjJ/NVwOK8dWFaR+4kaViuoTQs+3FwuCUkv1q
 kKsgY5c6e65mwlCPEoD/3dEw=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id 630f0c08124a2c25;
	Thu, 20 Aug 2026 16:46:26 +0000
X-Mizu-Trace-ID: 630f0c08124a2c25
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 9/9] selftests/ftrace: Walk up to find test.d/functions when a subdirectory is passed
Date: Fri, 21 Aug 2026 00:45:18 +0800
Message-Id: <dc58717cc225389b041dc36c684df23e3253c473.1787243842.git.wen.yang@linux.dev>
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
 tools/testing/selftests/ftrace/ftracetest | 26 ++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 0a56bf209f6c..8f9d9291bf4c 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -159,9 +159,29 @@ parse_opts() { # opts
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
+    # Security: only walk within directories owned by root or the current user
+    # to prevent sourcing a functions file planted in a world-writable ancestor.
+    dir=$(realpath "$OPT_TEST_DIR" 2>/dev/null || echo "$OPT_TEST_DIR")
+    while [ "$dir" != "/" ] && [ "$dir" != "//" ]; do
+      if [ -f "$dir/test.d/functions" ]; then
+        # Verify the directory is not world-writable to prevent LPE.
+        dirperms=$(stat -c "%a" "$dir" 2>/dev/null || stat -f "%Lp" "$dir" 2>/dev/null)
+        case "$dirperms" in
+          *2|*3|*6|*7) ;; # world-writable: skip this candidate
+          *)
+            TOP_DIR=$dir
+            TEST_DIR=$TOP_DIR/test.d
+            break
+            ;;
+        esac
+      fi
+      dir=$(dirname "$dir")
+    done
   fi
 }
 
-- 
2.25.1

