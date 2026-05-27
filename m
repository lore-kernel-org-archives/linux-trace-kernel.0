Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7F3CD8BD;
	Wed, 27 May 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875692; cv=none; b=ZzlJIcDg5tk5BpL2IOh3K9t+MD8plMS8f7U+PuMRYF9bbsc1rTA9JrYy3lDGjhcB9N0ltGWLAJKYfoeUfPWjXPIFbnQs4jCM1NsP/V+Wg4TIOliuzNajK+Eq8fzVa6t3xNosFOFJuHdbcG5hqF7CHAT+8+ainfNIy/mC4ZfuQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875692; c=relaxed/simple;
	bh=7qXGcS/WGFWb8Y3lG9s/3v7JKA20Rxyu5PwKyGpGsJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f5/qP4NTktUFesCN2+N6I8ScjhC5WyengVRZK9gNtEKJEVcRZZaNC0mnjnUDCwTFC80xgBVJQzjlmpo2eT99jePsH0xNAoOtzKxG0Pe9jPDR1/wAxCNnq3r0fXjn2ojVtlLY4c4HemvYY04nvfkXwLzl+79hdTkHbuQhgNJh9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qv9wKLX8; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qv9wKLX8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779875686; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DvdRFFhCgukKkTxPVdLh28AR1RcII91zSrhZrWjpXQs=;
	b=qv9wKLX8gEoCBB920ZVNJ/+qnNVO61jqvtTAaqFutuq2LLtd1CiCRZDIGU2DPqW/NDEyj/o822Qp55DNV55IChJ2cedlQxwrKefa9tg3Pk9/9rrZRZNBiKVTafpgl2Qf0wKBOIeYlTV9cG9VQpoEAvOTS5p/xOM/8oN1RKTK+J0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X3jQQS-_1779875678;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0X3jQQS-_1779875678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 17:54:45 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Fix trace_marker_raw test on 64K page kernels
Date: Wed, 27 May 2026 17:54:37 +0800
Message-Id: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ARM64 kernels with 64K pages, the trace_marker_raw test fails because
bash's printf builtin uses stdio buffering which splits output into
multiple small write() calls to the tracefs file. Since each individual
write is within TRACE_MARKER_MAX_SIZE (4096), they all succeed, causing
the "too big" write test to incorrectly pass.

Fix by piping make_str output through dd with iflag=fullblock to
guarantee a single atomic write() syscall to trace_marker_raw.

Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 .../selftests/ftrace/test.d/00basic/trace_marker_raw.tc     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index 8e905d4fe6dd..efd8263e6087 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -43,8 +43,10 @@ write_buffer() {
 	id=$1
 	size=$2
 
-	# write the string into the raw marker
-	make_str $id $size > trace_marker_raw
+	# Pipe through dd to ensure a single atomic write() syscall.
+	# Shell's printf builtin uses stdio buffering which may split the
+	# output into multiple writes.
+	make_str $id $size | dd of=trace_marker_raw bs=`expr $size + 4` iflag=fullblock
 }
 
 
-- 
2.39.3

