Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDC23EA87
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929879; cv=none; b=tFN9N9IM90zadOlzAX5twyyOzES53Ste9DKr5cqF5GUk/KjVdHyMsGwe/EJaHBsyFad+5AYn1sc+12ZwiKFjH1bQCCILORriLp/2VuP61t2zk+N+JnuDJrVxGggsjHwgrjbJ+JqcZs8S5KnWzHaKadLLWncACGdfRM4ZFM6AmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929879; c=relaxed/simple;
	bh=pQXuVp23KmJTwl1uNecClxnb6Bjg8ReC/eYBTC9HMh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NTQQm5/U3jcIXQEW3InCSQQ8XOvsCOYxSuov5UqFX5oQ3Z8oVZzKJMjOoGWP6P/uKdvO56k/Bxp3IIRT0Y4Mm/esBHTfiNt9FfLI9J6ssJXL6PhfaoppIw/tN7bNjmq2BuvCFnwTluJfhF7AfXhpY1jq2bSsfbw/9f44Ki4goOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLyR6ptv; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLyR6ptv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767929865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OntszklQiyhOLBA2hStKkvGHmLOPE0BPoaUp0XUIGLc=;
	b=CLyR6ptvctGbNIE22zTU8HkpTLigXRfp7jNzgncnNK9KX7itRwtRezSBSPtWOYZe/5xjHe
	1o08LAZPi4Uuhwf7cZ6porM6n+pwZqng25+q45TuXRHZMLP64UEfGh2TRhJRwQ/vQG7Uqj
	MWbPQNL4yw3K0OyQMAUoe3tMEgHp1rI=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	wangfushuai@baidu.com
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3] selftests/tracing: Fix test_multiple_writes stall
Date: Fri,  9 Jan 2026 11:36:20 +0800
Message-Id: <20260109033620.25727-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
the test_multiple_writes test will stall and wait for more
input due to insufficient buffer space.

Check current buffer_size_kb value before the test. If it is
less than 12KB, it temporarily increase the buffer to 12KB,
and restore the original value after the tests are completed.

Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
V2 -> V3: Make the From and SoB match.
V1 -> V2: Restore buffer_size_kb outside of awk script.

 .../ftrace/test.d/00basic/trace_marker_raw.tc  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index 7daf7292209e..a2c42e13f614 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -89,6 +89,7 @@ test_buffer() {
 	# The id must be four bytes, test that 3 bytes fails a write
 	if echo -n abc > ./trace_marker_raw ; then
 		echo "Too small of write expected to fail but did not"
+		echo ${ORIG} > buffer_size_kb
 		exit_fail
 	fi
 
@@ -99,9 +100,24 @@ test_buffer() {
 
 	if write_buffer 0xdeadbeef $size ; then
 		echo "Too big of write expected to fail but did not"
+		echo ${ORIG} > buffer_size_kb
 		exit_fail
 	fi
 }
 
+ORIG=`cat buffer_size_kb`
+
+# test_multiple_writes test needs at least 12KB buffer
+NEW_SIZE=12
+
+if [ ${ORIG} -lt ${NEW_SIZE} ]; then
+	echo ${NEW_SIZE} > buffer_size_kb
+fi
+
 test_buffer
-test_multiple_writes
+if ! test_multiple_writes; then
+	echo ${ORIG} > buffer_size_kb
+	exit_fail
+fi
+
+echo ${ORIG} > buffer_size_kb
-- 
2.36.1

