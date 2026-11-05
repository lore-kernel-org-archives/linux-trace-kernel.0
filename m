Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901063;
	b=oI80IBgn9n2R11hbA0RJn94CCYc1omJOCtz4C3wCwiUlyX+XL+TbL0qA4FqyltI5eFCT
	 eXEMrRcrjMELW4sY/oTOdXTBAiYuG/LZTFK/mTRAY0sMeGQ2QUQu6RjhoWciFph6JGnNQ
	 gBJUJa+o1CPCwkyVVmVuTzoSNNdrCMQ3V7DomLRaex1mZKxpR2/77fXxWGup9MdfEgAw0
	 QcDO0DmetQiMk9AYNwHHjR5yUL+T1HBUuh3fp/vHo5w/1m55BRuymGQcivDh9g4hUGbwa
	 y0JYIkLG6f/sh5MhAxyz0jgnG7SOMMstR6szvuQ7g0iiOrs7XHTDehxXJxBf5+qTsyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901063;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=en2JGcUszSNZbTFqRkGnK2dq4el0SJJ/0+ZPrU1sl4I=;
	b=hdnBH8v4OB/Vd6XAfGfRPkfJwc4n/3KoVnTsWzB5DsohkKn9iNeekf8eOk+VDTUnyjUj
	 qNoUYUppeg8L8ho4b4/TbQzv6yuCPyPX8E1ipALikE/i7mCiDbyKeUVUpUnqHOcfTE9i5
	 r9kJXWTdKCm2C+7DrL/N5vmJvk9rlSJkQ5nc6G5EXpF3gm6VMOJdODzFz2pVlCcD+xPgP
	 o3kZhl6FG6sH7frJe0Z65ZdjyAgk0TMRzcPRZika4U//bvzH+CzdA35r04IOpLSqMVASl
	 rgdOa3GDrkQwvOpGeusRTcX/2Rv8XluXrsksZQr8QTwadQ+hC7KLoMSLv+1+lfQOVug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nV20PNax;
	arc=none smtp.remote-ip=91.218.175.113
Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2029606D82E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2029606D82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nV20PNax
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RBBjF1dVk/Xf0gpPRhtzgJM9UIRcoO6DnxxofY0h9rM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901061; v=1; x=1794505861;
 b=nV20PNax4o1HwVcAWTIcJn47hCczkL2rqMBS2kAURgYzxGh4F73ZFeWmVK64zV1skiQCwE4H
 mPMVMLH/dPbkKL8GkBwMYgMhRW9vwJ2Ao10bcrBlQ7XjXC6C2pt3PuVxVIhH2lY7yWSX5j5lZ5K
 gxAXIXkdNqL3qV7W1/teAZAE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 09ccaa29a133fca4;
	Thu, 05 Nov 2026 17:51:00 +0000
X-Mizu-Trace-ID: 09ccaa29a133fca4
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 14/14] selftests/ftrace: Walk up parent dirs to find test.d/functions
Date: Fri,  6 Nov 2026 01:49:14 +0800
Message-Id: <3af4874e15a978a15e2d6853b8782ed9357a4334.1793900349.git.wen.yang@linux.dev>
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

