Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFB30BF70;
	Wed, 15 Jul 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095257; cv=none; b=eVD/BqIrDhCxD72i0DPiUXt18WPbHZhoJQVL4LHK4bfAneNLc9vV9tApdKyJPgnQSVQXvHaSivn2yonIgX6i3w1gv5iUA4knOvmTEdbAzFOawejLaKI+GYJAlN2nTs8oX2LwsxPbBVgRECnYw5lcAosvSlA/cJ5CO9lSw0d5C9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095257; c=relaxed/simple;
	bh=+AkYzD27eVN15JFTDVCYAeiQiTwGw71+NnUjSfILO1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo/705qABhqYbGDD7IKrbV90cJNY6+WCUvo/BaTMbYvn2n1LRYbm/iyH2+VUlTzQOhQKr4YbQa7ldV5+FcnU0zqXtNvl0xg76JNbiyUi48FLnr/DlIBOpJfIXN6o1dJZa6EkduyMBgF3H6vhU7VbsW6NqRw6dh7oYvMszlDP/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 85eeb44c801211f1aa26b74ffac11d73-20260715
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR
	SRC_UNFAMILIAR, DN_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4f05005b-03fa-46d5-890a-19e300021ef8,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:31
X-CID-INFO: VERSION:1.3.12,REQID:4f05005b-03fa-46d5-890a-19e300021ef8,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:31
X-CID-META: VersionHash:e7bac3a,CLOUDID:31048d4a7970d6dc1b2aaefd51c287a6,BulkI
	D:26071514005088TTZGM8,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|85|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 85eeb44c801211f1aa26b74ffac11d73-20260715
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(94.177.131.67)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1603744587; Wed, 15 Jul 2026 14:00:46 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	gmonaco@redhat.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	namcao@linutronix.de,
	juri.lelli@redhat.com,
	wen.yang@linux.dev,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH 2/2] rv/nomiss: close enable-time task exit race
Date: Wed, 15 Jul 2026 14:00:23 +0800
Message-ID: <20260715060023.1502983-2-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715060023.1502983-1-liqiang01@kylinos.cn>
References: <20260715060023.1502983-1-liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial task scan runs before the first patch registers the task exit
tracepoint. A task can begin exiting after it was selected by the scan but
before the exit handler is attached. sched_process_exit runs before
exit_notify() removes the task from the task list, so the scan could then
store a pointer to the exiting task's deadline entity after its cleanup
event had already been missed.

Initialize the shard state and attach the new-task, exit, and syscall
tracepoints before the initial scan. Make the scan use the same
PF_EXITING-aware creation helper as dynamic policy changes. On failure,
detach those tracepoints before destroying the monitor storage.

Fixes: b133207deb72 ("rv: Add nomiss deadline monitor")
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 kernel/trace/rv/monitors/deadline/deadline.h | 27 ++++++++++-------
 kernel/trace/rv/monitors/nomiss/nomiss.c     | 18 +++++++----
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
index b92480e79807..4626d6e2b218 100644
--- a/kernel/trace/rv/monitors/deadline/deadline.h
+++ b/kernel/trace/rv/monitors/deadline/deadline.h
@@ -181,6 +181,8 @@ static void deadline_storage_init(void)
 	}
 }
 
+static int deadline_create_task_storage(struct task_struct *task);
+
 /*
  * Initialise monitors for all tasks and pre-allocate the storage for servers.
  * This is necessary since we don't have access to the servers here and
@@ -190,9 +192,7 @@ static void deadline_storage_init(void)
 static inline int init_storage(bool skip_tasks)
 {
 	struct task_struct *g, *p;
-	int cpu;
-
-	deadline_storage_init();
+	int cpu, ret;
 
 	for_each_possible_cpu(cpu) {
 		if (!da_create_empty_storage(fair_server_id(cpu)))
@@ -208,25 +208,25 @@ static inline int init_storage(bool skip_tasks)
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
 		if (p->policy == SCHED_DEADLINE) {
-			if (!da_create_storage(EXPAND_ID_TASK(p), NULL)) {
+			ret = deadline_create_task_storage(p);
+			if (ret && ret != -ESRCH) {
 				read_unlock(&tasklist_lock);
-				goto fail;
+				return ret;
 			}
-			atomic_inc(&deadline_storage_shard(p->pid)->users);
 		}
 	}
 	read_unlock(&tasklist_lock);
 	return 0;
 
 fail:
-	da_monitor_destroy();
 	return -ENOMEM;
 }
 
-static void deadline_create_task_storage(struct task_struct *task)
+static int deadline_create_task_storage(struct task_struct *task)
 {
 	struct deadline_storage_shard *shard = deadline_storage_shard(task->pid);
 	bool created = false;
+	int ret = -ESRCH;
 
 	/*
 	 * The temporary reference makes an in-flight creator visible to exit.
@@ -239,14 +239,21 @@ static void deadline_create_task_storage(struct task_struct *task)
 	raw_spin_lock(&shard->lock);
 	if (!(READ_ONCE(task->flags) & PF_EXITING)) {
 		guard(rcu)();
-		if (!da_get_monitor(EXPAND_ID_TASK(task)) &&
-		    da_create_storage(EXPAND_ID_TASK(task), NULL))
+		if (da_get_monitor(EXPAND_ID_TASK(task))) {
+			ret = 0;
+		} else if (da_create_storage(EXPAND_ID_TASK(task), NULL)) {
 			created = true;
+			ret = 0;
+		} else {
+			ret = -ENOMEM;
+		}
 	}
 	raw_spin_unlock(&shard->lock);
 
 	if (!created)
 		atomic_dec(&shard->users);
+
+	return ret;
 }
 
 static void deadline_destroy_task_storage(struct task_struct *task)
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 2e5ee681505b..843262779a41 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -231,18 +231,26 @@ static int enable_nomiss(void)
 	if (retval)
 		return retval;
 
+	deadline_storage_init();
+	rv_attach_trace_probe("nomiss", task_newtask, handle_newtask);
+	rv_attach_trace_probe("nomiss", sched_process_exit, handle_exit);
+	if (!should_skip_syscall_handle())
+		rv_attach_trace_probe("nomiss", sys_enter, handle_sys_enter);
+
 	retval = init_storage(false);
-	if (retval)
+	if (retval) {
+		rv_detach_trace_probe("nomiss", task_newtask, handle_newtask);
+		rv_detach_trace_probe("nomiss", sched_process_exit, handle_exit);
+		if (!should_skip_syscall_handle())
+			rv_detach_trace_probe("nomiss", sys_enter, handle_sys_enter);
+		ha_monitor_destroy();
 		return retval;
+	}
 	rv_attach_trace_probe("nomiss", sched_dl_replenish_tp, handle_dl_replenish);
 	rv_attach_trace_probe("nomiss", sched_dl_throttle_tp, handle_dl_throttle);
 	rv_attach_trace_probe("nomiss", sched_dl_server_stop_tp, handle_dl_server_stop);
 	rv_attach_trace_probe("nomiss", sched_switch, handle_sched_switch);
 	rv_attach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
-	if (!should_skip_syscall_handle())
-		rv_attach_trace_probe("nomiss", sys_enter, handle_sys_enter);
-	rv_attach_trace_probe("nomiss", task_newtask, handle_newtask);
-	rv_attach_trace_probe("nomiss", sched_process_exit, handle_exit);
 
 	return 0;
 }
-- 
2.50.1

