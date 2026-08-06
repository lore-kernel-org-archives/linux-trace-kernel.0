Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B43EDAC6
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005086; cv=none; b=dyr9XJX88/HOM/iw86hgG1R6hqSLe9v13uSbJTzocqlZZx6iit2c5c1+71QEcgHVFQmC2/gu2hR7ybu2iOO+U4vZSmTxaa+oK8DOZfL3zpJYOyMiIu4VaykrwjndjTEx/kYwBxTajx63UEdN/5y+JIeaN3E/VcxY/p/dqh42/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005086; c=relaxed/simple;
	bh=2HRJ/1Ly3wa43+KYdFLO9xCBqnRBXqeiOk2T4FLmXAI=;
	h=Content-Type:Date:Cc:Message-Id:Subject:Mime-Version:To:From; b=hyBOt2+phgx0Z1BPFiyAbHb5lqcUKCcfOVMziUbXeH/TTQwYrnRmRuuFjuB8dtx13vABT+aQZ7P04s2AuC7d2OC0f046hLKs/SFu+1vpTrAQfDQtbXV3TIUfrGEatHiV/tqUf4xJ+rJfzMN9BpAI52ruP9BFEcCc9g9elybu+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MT8UzQ0q; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MT8UzQ0q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786005078; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=d2SiBPq9Qel7pXsDTBlK71WE5oJf95jSaIB3kduOeTM=;
 b=MT8UzQ0qIR1w5JYswS6oSxMCaTaZSPCXXnH5AvSDTyK5Ga6BzFsRAdAVXWt9jEpRjXLEIk
 fdK12YrcdGuZxikCiqrjQNyOxMhEKfclo0erpKaMJV+UaLIiyFdixnBr1IxB6ryKKRFATv
 sydRLPcPBngELyX131PRNAxUjftYPqPyIF1tMvxtvcbmv9Wx5dRHhGg3Xk6MEi4ieEVTvi
 KaNGBXZ1vbVbugJcho4GgHgiS4NHlVnq1TLcvWqfbHrFk6RpN3KL+yE5/ZXivGC4U8OIcW
 JmTps6tHbMt95A9HUVXL0+ERU6BfjVuhY0rvwb/kFpVpLZsgHVtDtsjGhzI9yw==
Content-Type: text/plain; charset=UTF-8
Date: Thu,  6 Aug 2026 16:31:00 +0800
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260806083101.2651025-1-qirui.001@bytedance.com>
Subject: [PATCH 1/2] selftests/ftrace: Force C locale for readelf in uprobe test
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a744654+9821bf+vger.kernel.org+qirui.001@bytedance.com>
To: "Steven Rostedt" <rostedt@goodmis.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>, 
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Shuah Khan" <shuah@kernel.org>
From: "Rui Qi" <qirui.001@bytedance.com>

The add_remove_uprobe test parses the entry point from readelf -h output
by looking for the English "Entry" field. readelf output is localized
via gettext, while the ftracetest runner does not force LC_ALL=C and the
top-level Makefile leaves LANG effective for child processes.

If readelf prints a translated field name, ENTRYPOINT becomes empty and
the uprobe_events write is rejected because the offset after PATH: is
missing.

Run readelf with LC_ALL=C so the parsed header field remains stable
across locales.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 .../selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
index f2048c244526..f33a863be68b 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
@@ -12,7 +12,7 @@ echo 0 > events/enable
 echo > dynamic_events
 
 REALBIN=`readlink -f /bin/sh`
-ENTRYPOINT=`readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
+ENTRYPOINT=`LC_ALL=C readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
 
 echo "p:myevent ${REALBIN}:${ENTRYPOINT}" >> uprobe_events
 
-- 
2.20.1
