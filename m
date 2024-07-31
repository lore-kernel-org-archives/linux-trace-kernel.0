Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF44495E5;
	Wed, 31 Jul 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411913; cv=none; b=ppTUDY2tYYtUxNjLBVFtHMEG3XcJ5EDVCiD6jz3j7U20opEDw1aL2yHy4iH0nZgpyzChiVWsg6gK3b9qXmuvL/VzSKVZGzPMOIHNumBCPP5w68wyn6j4S63cqS9Jk3a5cIKVxRDghkMT/VGOjGPnzcLRSsdmKzyyJ887C9/cRfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411913; c=relaxed/simple;
	bh=uBiILv9ml2mco3Oqm8DnzDlkUq5xH2DYhlwHYgbwHpI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WtAjIhyeR2WvvM/9APFTz86sFXpc8HVx+wXuKuFgBb9L/115rJvF7vdxXSl17qp5pG82L4sJWAa3s/nqTBLk8rRQAW2k/RhUBj+eFVSifwTJ3MIAh+VJ3Y1GhBOf5VwLm8h3rgU3ZuYVAD1MlI35BeMgdvWYQb5+vXkfFclzoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYkX94DTDzyNws;
	Wed, 31 Jul 2024 15:40:09 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C0E41180087;
	Wed, 31 Jul 2024 15:45:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 31 Jul
 2024 15:45:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] tracing: Replace strncpy() with strscpy() when copying comm
Date: Wed, 31 Jul 2024 15:50:58 +0800
Message-ID: <20240731075058.617588-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Replace the depreciated[1] strncpy() calls with strscpy()
when copying comm.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/trace/trace.c              | 2 +-
 kernel/trace/trace_events_hist.c  | 4 ++--
 kernel/trace/trace_sched_switch.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d0af984a5337..73cfdc704eec 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1907,7 +1907,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
+	strscpy(max_data->comm, tsk->comm);
 	max_data->pid = tsk->pid;
 	/*
 	 * If tsk == current, then use current_uid(), as that does not use
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d36a..4ee0e64719fa 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
 		return;
 	}
 
-	strncpy(comm, task->comm, TASK_COMM_LEN);
+	strscpy(comm, task->comm);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
@@ -3405,7 +3405,7 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	elt_data = context->elt->private_data;
 	track_elt_data = track_data->elt.private_data;
 	if (elt_data->comm)
-		strncpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
+		strscpy(track_elt_data->comm, elt_data->comm);
 
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

