Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A5366559
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698251; cv=none; b=dY+8cwXtHaXf97NpxVd5P24fnsxfbowg0d6VS7424HGCzZYpIzYVD5UmxI5GdIbZHvPyxIMworcCUGJkvYrs1tcBK0uj1ROxPBp/0/GPSKhm6ZsqZUPkT6RQP3phGk4u8Y5OfTRez0D9FksRkjFi2DCclAWayCtp6azr5i484xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698251; c=relaxed/simple;
	bh=8zOumHZLb4yUjz4MAnDaIxx35XxJbcVHj20T3tfiIPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UPlPb1V2I3bqZlNAMxUXE9fWMqYDZaIF9d+xI4cbIeG0qQXv6XJp94lc5eQYFmU1tQncNeQVMXHcTmwYySipfvwqs9oPhCr1M0EE59+XYJe4VnJq/mIiXBho6lTj7kTGRBCXDlbK17Nbe4sMSoTfbJgGBm2KKKru9jcgv9GGDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=LiX0B3yX; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="LiX0B3yX"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 62588sMt092074;
	Thu, 5 Mar 2026 16:08:54 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4fRMbW19lhz2PBYg2;
	Thu,  5 Mar 2026 16:07:51 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 5 Mar 2026 16:08:52 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <elver@google.com>,
        <kees@kernel.org>
CC: <lorenzo.stoakes@oracle.com>, <brauner@kernel.org>,
        <schuster.simon@siemens-energy.com>, <david@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <guohua.yan@unisoc.com>, <ke.wang@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] tracing: Revert "tracing: Remove pid in task_rename tracing output"
Date: Thu, 5 Mar 2026 16:08:09 +0800
Message-ID: <20260305080809.3245-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 62588sMt092074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1772698147;
	bh=tCiAwr0i8QW0sqKM2+nZCk9MOSzSpaH4AAu5VMaMrmE=;
	h=From:To:CC:Subject:Date;
	b=LiX0B3yXOGs+zB0IMECISm2npNSeK8YQlT1bY1tZMQMY14zbRqLF6jAftKe17MbdG
	 txILOayRrG4ZmaZRUQ9aMTPlHOPFb5JJ+tplmjvLqzWK4KZv3ChXdcyzcfGp6o3j6f
	 GzyBmdSD8/QmFfhrq54vCEs8MoqsTPB63LyM8dIYGamhgQ+lNdO9zXrjgs0Vkj+J0+
	 E7DrIS/PFwI17ZjRLnAevkhhl+o93Ei9Ynl05GdkdVC4lAlqo2FzO9sA2cM0A2Y8VY
	 gy4u8oTuRLsWSbw695XRHyMCL0vRJ4LHDQODELIeHxWph5X/uxw4zMM0cZpTt84CxA
	 kGGZmjWAli4ig==

This reverts commit e3f6a42272e028c46695acc83fc7d7c42f2750ad.

The commit says that the tracepoint only deals with the current task,
however the following case is not current task:

comm_write
set_task_comm
__set_task_comm
trace_task_rename

So revert the patch to show pid.

Fixes: e3f6a42272e0 ("tracing: Remove pid in task_rename tracing output")
Reported-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 include/trace/events/task.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 4f0759634306..b9a129eb54d9 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -38,19 +38,22 @@ TRACE_EVENT(task_rename,
 	TP_ARGS(task, comm),
 
 	TP_STRUCT__entry(
+		__field(	pid_t,	pid)
 		__array(	char, oldcomm,  TASK_COMM_LEN)
 		__array(	char, newcomm,  TASK_COMM_LEN)
 		__field(	short,	oom_score_adj)
 	),
 
 	TP_fast_assign(
+		__entry->pid = task->pid;
 		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
 		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
-	TP_printk("oldcomm=%s newcomm=%s oom_score_adj=%hd",
-		  __entry->oldcomm, __entry->newcomm, __entry->oom_score_adj)
+	TP_printk("pid=%d oldcomm=%s newcomm=%s oom_score_adj=%hd",
+		__entry->pid, __entry->oldcomm,
+		__entry->newcomm, __entry->oom_score_adj)
 );
 
 /**
-- 
2.25.1

