Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9B1FC7FB
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784114; cv=none; b=iVRY2Z2QaW7fqhvNCki0srOQp/WM5fFVllyI14mCmPhgQpevn8HOmggW1qV3XRKTAs1JV/n3Jv7Q9w5T9sMUCO8S+r3nUy4htc987AryKvAqEpx9EFXFo1ALs7DyHx1800ybf8+1oa9roQOdEwmEy0jcfjJYFpFnZQbqIbW40ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784114; c=relaxed/simple;
	bh=r86bYWmgJvYIJixbP6qjPCwoNkmdAiOFFtwK5AChiCY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yd15klKh6TcNi+cBsxbRfNzdM187diw0yegYjZOV7Do6/EhSKKPU7TBvaLCHiAld9ViBEiwIafrU0b2Jhq7okp9owjlIBLtSDsecxq7iyzZQlYD/cgX24X6pf3IT/A+Ggjg7Wjf05NCdnF16mz/8sHH9FYxYOCjpQcVTK/RioKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=B8wtgnUU; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="B8wtgnUU"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 62680Evf077596;
	Fri, 6 Mar 2026 16:00:14 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4fRzM064CSz2NK5vR;
	Fri,  6 Mar 2026 15:59:08 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 6 Mar 2026 16:00:11 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <elver@google.com>,
        <kees@kernel.org>
CC: <lorenzo.stoakes@oracle.com>, <brauner@kernel.org>,
        <schuster.simon@siemens-energy.com>, <david@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <guohua.yan@unisoc.com>, <ke.wang@unisoc.com>,
        <xuewen.yan94@gmail.com>, <jing.xia@unisoc.com>
Subject: [PATCH V2] tracing: Revert "tracing: Remove pid in task_rename tracing output"
Date: Fri, 6 Mar 2026 15:59:54 +0800
Message-ID: <20260306075954.4533-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 62680Evf077596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1772784041;
	bh=GNpRpMauuj7gFsNQV7OtGtgexum9Eop40z9zrHZikbk=;
	h=From:To:CC:Subject:Date;
	b=B8wtgnUUP6i1nV5h/Nj+Xh0dwwq4OjaS59ApqA906N3mMwcY8xqjJzMkvVozVPocv
	 UQdKZ0QO4nBOkT3+iRm64A4Ytenh40QpkMoOiuPwaykabo6k+wkB9OgQbCIWB74+a8
	 o2LuNBZJzWF4lPU/VMK2oYsyAZ9R6LMG2zVM0GCOlQl4+/6BnY8KM+bEICo8ZBMqnL
	 Y+ZMEHt4GnBtWMT7J6AwtmRZ090z1aszrwNV7Jk3Wexk8quFjc/me/aEys93iIscUW
	 Kpxs/l4eEgoJEnRNHq00FGQ6eEvm3TJ9X7qJFqrDwuqF++l+rEHnpuLVwbo4Fj2qD5
	 g0vTf08/JJZfA==

This reverts commit e3f6a42272e028c46695acc83fc7d7c42f2750ad.

The commit says that the tracepoint only deals with the current task,
however the following case is not current task:

comm_write() {
    p = get_proc_task(inode);
    if (!p)
        return -ESRCH;

    if (same_thread_group(current, p))
        set_task_comm(p, buffer);
}
where set_task_comm() calls __set_task_comm() which records
the update of p and not current.

So revert the patch to show pid.

Fixes: e3f6a42272e0 ("tracing: Remove pid in task_rename tracing output")
Reported-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
v2:
- update commit message (Steven)
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

