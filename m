Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A31BC20;
	Thu, 31 Oct 2024 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376139; cv=none; b=cbdFOn4kt/hA8G1KnWoIK14RE22VpwDphg+Q/gvmzR3nt7PJS0MaxiCgdKJhgW0m6ERYVjpvh+ajHAWzK3fI+JKZfesmD2pujl4XwBqGqbS1WOKc6qosSVod6pfBHPalhjH3Cb4r+vLgFAoSPIXUEI+M9aihdvtNjbi5zOh5cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376139; c=relaxed/simple;
	bh=VpCrCjMHklWhFAHP3FL48PZf9Vh5YLINmbeBg1Ukv+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZPOKbQt4bUQ2ToAaBIiu9dBlZTnxDYBL7SQfbICXjBbC8ofkQ/KJBweOmGQD3p5JcGDzx8voQzpFSy8u3xBLxKrOJx0N5kotM0nQwSizKNNrRuSr6YMzFRM9asP5/3aFksh6GDKl4e/JAM9l2eF7ZlgST1o/HsWg/HI7GHx9LtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XfMyn44LbzQsFF;
	Thu, 31 Oct 2024 20:01:05 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 41B96140137;
	Thu, 31 Oct 2024 20:02:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Oct
 2024 20:02:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] tracing: Replace strncpy() with strscpy() when copying comm
Date: Thu, 31 Oct 2024 20:01:39 +0800
Message-ID: <20241031120139.1343025-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Replace the depreciated[1] strncpy() calls with strscpy()
when copying comm.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Fix the trace_events_hist.c build problem.
---
 kernel/trace/trace.c              | 2 +-
 kernel/trace/trace_events_hist.c  | 4 ++--
 kernel/trace/trace_sched_switch.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8f52b6527ca..cb2c66554212 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1934,7 +1934,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
+	strscpy(max_data->comm, tsk->comm);
 	max_data->pid = tsk->pid;
 	/*
 	 * If tsk == current, then use current_uid(), as that does not use
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f9119eb7c67..8e370bc4faa4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
 		return;
 	}
 
-	strncpy(comm, task->comm, TASK_COMM_LEN);
+	strscpy(comm, task->comm, TASK_COMM_LEN);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
@@ -3405,7 +3405,7 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	elt_data = context->elt->private_data;
 	track_elt_data = track_data->elt.private_data;
 	if (elt_data->comm)
-		strncpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
+		strscpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
 
 	track_data->updated = true;
 
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 8a407adb0e1c..573b5d8e8a28 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -187,7 +187,7 @@ static inline char *get_saved_cmdlines(int idx)
 
 static inline void set_cmdline(int idx, const char *cmdline)
 {
-	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
+	strscpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
 static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
-- 
2.34.1

