Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8D37E5FE;
	Wed, 15 Jul 2026 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095254; cv=none; b=G7MrKnLdltEKB3CvOl+V+/7PNPMD0/uas6ZZO+Z9c9hrSuPMR/tc1wCUvjdozVityNV39MXXd6+q4MJU639fAQqDAlepmltDWBkGQOMQReMrE4MoE7K+V3B/b9Tqw9Abmz3psTQsyXfBt0BdsXJaRTNqzEicGLfy98ojRHFc0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095254; c=relaxed/simple;
	bh=uYuISGijpe5v8UVU380HvFx8XEMmrMXgbFwTDI9qVqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lop3fGpPOtUlLDh7gSUPPojPMYHdlW97ze7+Nvj6oJ+CroNQkHoWEA227HiSCopbZKiOgt09Y7eXb8sMij0LSNZAICwA6ABVTcal7L9HTegXArjY/mU8T/n1/7OToojnkXt/e4tnvuErwdP/nGjsqo2vxEl269sopawpyiCip+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 80d4bcd6801211f1aa26b74ffac11d73-20260715
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
X-CID-O-INFO: VERSION:1.3.12,REQID:a714e744-9dad-4bf7-b1c6-5f6dfe6b3e29,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:a714e744-9dad-4bf7-b1c6-5f6dfe6b3e29,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:b6411998ebed8982ee805c46c4ba91a8,BulkI
	D:260715140042EOEY1A8W,BulkQuantity:0,Recheck:0,SF:10|66|78|85|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 80d4bcd6801211f1aa26b74ffac11d73-20260715
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(94.177.131.67)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1938403519; Wed, 15 Jul 2026 14:00:38 +0800
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
Subject: [PATCH 1/2] rv/nomiss: fix task storage lifetime
Date: Wed, 15 Jul 2026 14:00:22 +0800
Message-ID: <20260715060023.1502983-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nomiss monitor stores a pointer to a task's embedded deadline entity
in per-PID object storage. The exit handler only removed that storage when
the task was still SCHED_DEADLINE. A task that changed to another policy
before exiting left its entry behind. Once the PID was reused, the new task
could reuse the old entry and dereference the freed deadline entity.

Remove storage unconditionally at sched_process_exit. Serialize creation
and destruction with locks sharded by PID, and do not create storage once
PF_EXITING is set. Each shard tracks both stored entries and in-flight
creators, allowing exits for shards without storage to avoid locking and
hash lookups while preserving the create/exit ordering.

Fixes: b133207deb72 ("rv: Add nomiss deadline monitor")
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 kernel/trace/rv/monitors/deadline/deadline.h | 86 +++++++++++++++++++-
 kernel/trace/rv/monitors/nomiss/nomiss.c     |  2 +-
 2 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
index 78fca873d61e..b92480e79807 100644
--- a/kernel/trace/rv/monitors/deadline/deadline.h
+++ b/kernel/trace/rv/monitors/deadline/deadline.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <linux/kernel.h>
+#include <linux/hash.h>
+#include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include <linux/sched/deadline.h>
 #include <asm/syscall.h>
@@ -148,6 +150,37 @@ static inline struct sched_dl_entity *get_server(struct task_struct *tsk, u8 typ
 	return NULL;
 }
 
+#define DEADLINE_STORAGE_LOCK_BITS	6
+#define DEADLINE_STORAGE_LOCKS		BIT(DEADLINE_STORAGE_LOCK_BITS)
+
+/*
+ * A shard tracks both entries and creators which have not yet checked
+ * PF_EXITING. This lets unrelated exits avoid taking a storage lock while
+ * preserving the create/exit ordering.
+ */
+struct deadline_storage_shard {
+	raw_spinlock_t lock;
+	atomic_t users;
+} ____cacheline_aligned_in_smp;
+
+static struct deadline_storage_shard
+	deadline_storage_shards[DEADLINE_STORAGE_LOCKS];
+
+static inline struct deadline_storage_shard *deadline_storage_shard(int pid)
+{
+	return &deadline_storage_shards[hash_32(pid, DEADLINE_STORAGE_LOCK_BITS)];
+}
+
+static void deadline_storage_init(void)
+{
+	int i;
+
+	for (i = 0; i < DEADLINE_STORAGE_LOCKS; i++) {
+		raw_spin_lock_init(&deadline_storage_shards[i].lock);
+		atomic_set(&deadline_storage_shards[i].users, 0);
+	}
+}
+
 /*
  * Initialise monitors for all tasks and pre-allocate the storage for servers.
  * This is necessary since we don't have access to the servers here and
@@ -159,6 +192,8 @@ static inline int init_storage(bool skip_tasks)
 	struct task_struct *g, *p;
 	int cpu;
 
+	deadline_storage_init();
+
 	for_each_possible_cpu(cpu) {
 		if (!da_create_empty_storage(fair_server_id(cpu)))
 			goto fail;
@@ -177,6 +212,7 @@ static inline int init_storage(bool skip_tasks)
 				read_unlock(&tasklist_lock);
 				goto fail;
 			}
+			atomic_inc(&deadline_storage_shard(p->pid)->users);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -187,17 +223,61 @@ static inline int init_storage(bool skip_tasks)
 	return -ENOMEM;
 }
 
+static void deadline_create_task_storage(struct task_struct *task)
+{
+	struct deadline_storage_shard *shard = deadline_storage_shard(task->pid);
+	bool created = false;
+
+	/*
+	 * The temporary reference makes an in-flight creator visible to exit.
+	 * If storage is created, it becomes the reference owned by that entry.
+	 */
+	atomic_inc(&shard->users);
+	/* Pair with exit before it tests users without taking the shard lock. */
+	smp_mb__after_atomic();
+
+	raw_spin_lock(&shard->lock);
+	if (!(READ_ONCE(task->flags) & PF_EXITING)) {
+		guard(rcu)();
+		if (!da_get_monitor(EXPAND_ID_TASK(task)) &&
+		    da_create_storage(EXPAND_ID_TASK(task), NULL))
+			created = true;
+	}
+	raw_spin_unlock(&shard->lock);
+
+	if (!created)
+		atomic_dec(&shard->users);
+}
+
+static void deadline_destroy_task_storage(struct task_struct *task)
+{
+	struct deadline_storage_shard *shard = deadline_storage_shard(task->pid);
+
+	/* Pair with the creator barrier before taking the no-storage fast path. */
+	smp_mb();
+	if (!atomic_read(&shard->users))
+		return;
+
+	raw_spin_lock(&shard->lock);
+	guard(rcu)();
+	if (da_get_monitor(task->pid, NULL)) {
+		/* A task may leave SCHED_DEADLINE before exiting. */
+		da_destroy_storage(task->pid);
+		atomic_dec(&shard->users);
+	}
+	raw_spin_unlock(&shard->lock);
+}
+
 static void __maybe_unused handle_newtask(void *data, struct task_struct *task, u64 flags)
 {
 	/* Might be superfluous as tasks are not started with this policy.. */
 	if (task->policy == SCHED_DEADLINE)
-		da_create_storage(EXPAND_ID_TASK(task), NULL);
+		deadline_create_task_storage(task);
 }
 
 static void __maybe_unused handle_exit(void *data, struct task_struct *p, bool group_dead)
 {
-	if (p->policy == SCHED_DEADLINE)
-		da_destroy_storage(get_entity_id(&p->dl, DL_TASK, DL_TASK));
+	deadline_destroy_task_storage(p);
 }
 
 #endif
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 8ead8783c29f..2e5ee681505b 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -214,7 +214,7 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 	if (p->policy == SCHED_DEADLINE)
 		da_reset(EXPAND_ID_TASK(p));
 	else if (new_policy == SCHED_DEADLINE)
-		da_create_or_get(EXPAND_ID_TASK(p));
+		deadline_create_task_storage(p);
 }
 
 static void handle_sched_wakeup(void *data, struct task_struct *tsk)
-- 
2.50.1

