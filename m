Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2245C6ED
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747664; cv=none; b=V8w3CLgEUrK7hQx3xLQgsR8vLmYWEx/XwwBxFNENvJKyWRmef3toEVCZgJrTIva1OTlVVv4RW9kXgLXGg/2h8Q61p017sc6EIX4scTqimSIulwu8Y131iL1wlsS3HxsFVIpumSC3EJlqw53YMxfS9UVhCNZnPbomQ+M492q8PYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747664; c=relaxed/simple;
	bh=RBBjF1dVk/Xf0gpPRhtzgJM9UIRcoO6DnxxofY0h9rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SkFzSmJLIj4UucNja83piVseiuAxBmNDamhd4S9lAgmtPClKwQi6w10LXLmePICN1hq2j7GOZ3Gh2LSMklpUVF0AeAJT1Ce1lL4qNnhi2QcSbYlUs0tOpTlpmQ9rDxDg4tX6lyZBKsoTVIXZq6I0UcxWSd8HEjPqnd4jAx44ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cJjb8MnZ; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cJjb8MnZ"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RBBjF1dVk/Xf0gpPRhtzgJM9UIRcoO6DnxxofY0h9rM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747659; v=1; x=1792352459;
 b=cJjb8MnZuPonHnINXiKKQI2SEaIrP0BUDmMmc1+woEYPPf9txR/i6nPnmgWmwWm/GYv/efC4
 F4hh5SvTyX5ib3mSoShoIByT4Lmnyeqeo0vyR68xvrR6qKE5JZITRiS1FAL0vFfKWkaF2upRntr
 znB19iC2uIzR+oVa99+DKC58=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id c6767f3ebfa360b0;
	Sun, 11 Oct 2026 19:40:59 +0000
X-Mizu-Trace-ID: c6767f3ebfa360b0
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 14/14] selftests/ftrace: Walk up parent dirs to find test.d/functions
Date: Mon, 12 Oct 2026 03:39:20 +0800
Message-Id: <9a83652ef9a1ba59193e2cd5c6a230d1e77fa037.1791745088.git.wen.yang@linux.dev>
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

When a subdirectory is passed (e.g. an RV monitor's test directory),
ftracetest fell back to its own functions file, losing the RV-specific
check_requires handling for ':monitor' and ':reactor' requirements.

Walk up from OPT_TEST_DIR until a directory containing test.d/functions
is found, stopping after five levels so a stray argument cannot reach an
unrelated functions file further up the tree.  When no such directory is
found the previous default is kept.

Note that TOP_DIR also feeds LOG_TOP_DIR, so logs now follow the
directory the tests were found in: an RV run writes to
verification/logs rather than ftrace/logs.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/testing/selftests/ftrace/ftracetest | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 0a56bf209f6c..3d3c3a4dfa34 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -159,9 +159,22 @@ parse_opts() { # opts
   if [ -n "$OPT_TEST_CASES" ]; then
     TEST_CASES=$OPT_TEST_CASES
   fi
-  if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ]; then
-    TOP_DIR=$OPT_TEST_DIR
-    TEST_DIR=$TOP_DIR/test.d
+  if [ -n "$OPT_TEST_DIR" ]; then
+    # A subdirectory of test.d can be given; walk up to the directory
+    # holding test.d/functions.  The bound keeps a stray directory from
+    # reaching an unrelated functions file further up the tree.
+    local dir=$OPT_TEST_DIR
+    local depth=0
+    while [ "$depth" -lt 5 ]; do
+      if [ -f "$dir/test.d/functions" ]; then
+        TOP_DIR=$dir
+        TEST_DIR=$TOP_DIR/test.d
+        break
+      fi
+      case "$dir" in /|//|.) break;; esac
+      dir=$(dirname "$dir")
+      depth=$((depth + 1))
+    done
   fi
 }
 
-- 
2.25.1

