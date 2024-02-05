Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB71CA88
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138785; cv=none; b=kmo7kzHrdYWKzJ8MqU5UgHjbMSbVgok03D+yJAmYkTqz+BZWnFDhLGmVEBMUFq4xfmTjoL4iUBQytKUBsNO7xIWbZeCypHgArhdSGK3aRpL11upk2u2cXcCcxIzIQ5bV1CdsJmDbCnN+cWhJmi0XRMFp8nfk6JIY1WT2IS1oEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138785; c=relaxed/simple;
	bh=g5xEBeyldH+fm+N8Sqx3EL+fAkUst9da5wdf2Iqc/qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCIfeC0AVUVQKjJ8o1ZXfChng/95fYR6/PEHw8wPzxx+IOYVscPHE6O4UbpJIndv4/frLYq5cdLXTdN0kV1Sz0gaGtZyAXzzxTqCOWFLaUIJ0QALLXUuaNH85msmrxULMIggeESuZKuKkMxew4GHq9vnK/wba55yxjGDCfeM7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oVRwfste; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oVRwfste"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707138778; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GS6+1vc7MxVuoEwx4nJjZgrNI1JABgol9fgwCj0Yexw=;
	b=oVRwfste3elCGLhZKs/EL2f4JTcdt+rxIz7N8Fi5Dhou8/utP8J914v6KMbsII6bsjZkIa6rlYhmui7ykr3vC5zJ7r4+P6PREUSi81Q7nJIl9ux6kBqGUKg24xJT+iWuRKur7YMQH0TePTavxljZDDupWuTsoDA4gdtUW/tr27I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W0AbpQM_1707138769;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W0AbpQM_1707138769)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 21:12:58 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: =linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=linux-kselftest@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH] selftests/ftrace: Limit length in subsystem-enable tests
Date: Mon,  5 Feb 2024 21:12:33 +0800
Message-Id: <20240205131233.13686-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While sched* events being traced and sched* events continuously happen,
"[xx] event tracing - enable/disable with subsystem level files" would
never stop as it cat an endless output.
Select the first 100 lines of output would be enough to judge whether
there are more than 3 types of sched events.

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 .../selftests/ftrace/test.d/event/subsystem-enable.tc       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b1ede6249866..74c1114603a7 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -18,7 +18,7 @@ echo 'sched:*' > set_event
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +29,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -40,7 +40,7 @@ echo 0 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -ne 0 ]; then
     fail "any of scheduler events should not be recorded"
 fi
-- 
2.39.3

