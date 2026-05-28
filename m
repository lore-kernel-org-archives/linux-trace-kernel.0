Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189212E612E;
	Thu, 28 May 2026 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935090; cv=none; b=AlNByHOAPOSRZmgZOt4WvrAKvdAd0eBINq5xHvTt/EBZg6gMMZsLVG1cCW1Ws/f6Uqf0f8qT15KLFLt2jXQ4GsPUGbJEUEJ95IC3E27GbZnp5OD6Wm8W5YEVYwA/fbacAnbXpFnHf8xnVcGj0dHcymsyq/UBWA+FAk2+oTCxUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935090; c=relaxed/simple;
	bh=tyxGu8CHfgD8OUfKmd8OdRNkrpbl1UQV1MEgVj7xqFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nGPDPZmivxkRrYS+YIm/QiSJVdTNSaCzOuUPLR9grhLM4zsQgRbkriVWEP6vvaQxIKjavWenJ8WfzTv1HSOD3NAs9VQ3z5kWYFselVmPfMGyepSSbq/XQBJuuu8LkLbwrqo6oYwD6y/2xPoyNe3d24oXPUq5Xe0/awXc0ch0Nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FXLDw1Qf; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FXLDw1Qf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779935084; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9rVMlDYzcI35lZwQKZ05tc29Po6MNzJ6x2rJ0HSbwhs=;
	b=FXLDw1QfFCU5j3Y/1qkbRNioy+ATnye5ovD0xfEm+zr8vzOQhtVlzP10CgZ6wEDQn1UZIWKzKOf9OeWK3HDiLRTJx4ZgT0VnDaTgoD4Lr1wPCOBbdy+LMcfiPVRNoA9L8sPtJMeQGvFWXhcogfgQXUkWG+sUgBcvtYALVBNDrAQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X3kwRqf_1779935058;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0X3kwRqf_1779935058 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 May 2026 10:24:44 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/ftrace: Fix trace_marker_raw test on 64K page kernels
Date: Thu, 28 May 2026 10:24:17 +0800
Message-Id: <20260528022417.1813745-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
References: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
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
v2:
Update comment about 64K pages.
---
 .../selftests/ftrace/test.d/00basic/trace_marker_raw.tc    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index 8e905d4fe6dd..f68f1901f65f 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -43,8 +43,11 @@ write_buffer() {
 	id=$1
 	size=$2
 
-	# write the string into the raw marker
-	make_str $id $size > trace_marker_raw
+	# Pipe through dd to ensure a single atomic write() syscall
+	# on architectures with 64K pages, where shell's printf builtin
+	# uses stdio buffering which may split the output into multiple
+	# writes.
+	make_str $id $size | dd of=trace_marker_raw bs=`expr $size + 4` iflag=fullblock
 }
 
 
-- 
2.39.3

