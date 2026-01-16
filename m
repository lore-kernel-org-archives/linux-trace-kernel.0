Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB86224AF2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567247; cv=none; b=V1Hsvs7Q9rbvfwe8DzYpUEgmWRIHsayviI5Swoy/71XLYZnB5y2nEctyE3T4kjQiHkos+Rpn1DKhr9cZ2UTZPnU9DICcQ1jQco4ec6c4Am+madR04Czuww0Xnr4qvblH3sUAUrDzbiOi/v7ky7fYQ74fI78L5GnMwYuF4LTdxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567247; c=relaxed/simple;
	bh=1iMP0JGAeYsSM4ZP9G3dcqoUE3Jun7u7IOsjuBdBoOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVZ61syD94ucKZmpYLdd5j1XLS8F6xNs8fIzFyRyRYmbpBztwljbxEzqe8/CGOxaEzYWiYKEIoA/LMI4GsnHHJckwO0sUCjCF7SglppkKDbI/2++ur3ydtg7jXCWef+ER+7TJHEFEQ2ZzoX/v4oi++2DvYUPXOQ647clqlq9UMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JC/p8cKz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JC/p8cKz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768567241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mD9sA2EyZaN/6DBEGI7T/3OXUo+Tl2WFG1vx/3i8fkg=;
	b=JC/p8cKz9HWjGQdg4DmXmhHtEMVheubsDrjVKaQZSPU1NQ24fq0q2eP1ru4pWDPyIvAq3S
	c8xLmQIxMWT/bMc7cMPHOk3D2miaJcsGLdA9m6au2nGNk4cthCiDRgogNCwOPJ5BTf+v5m
	lpI1SCbpMWv2IiYbItiA4LhYyiVvH/0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-OWhgG-tqO4iAhgzSHw-zpg-1; Fri,
 16 Jan 2026 07:40:40 -0500
X-MC-Unique: OWhgG-tqO4iAhgzSHw-zpg-1
X-Mimecast-MFC-AGG-ID: OWhgG-tqO4iAhgzSHw-zpg_1768567239
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21D7819560B5;
	Fri, 16 Jan 2026 12:40:39 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34D5E1955F22;
	Fri, 16 Jan 2026 12:40:34 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 13/15] sched/deadline: Move some utility functions to deadline.h
Date: Fri, 16 Jan 2026 13:39:09 +0100
Message-ID: <20260116123911.130300-14-gmonaco@redhat.com>
In-Reply-To: <20260116123911.130300-1-gmonaco@redhat.com>
References: <20260116123911.130300-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Some utility functions on sched_dl_entity can be useful outside of
deadline.c , for instance for modelling, without relying on raw
structure fields.

Move functions like pi_of, is_dl_boosted, dl_is_implicit to deadline.h
to make them available outside.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/sched/deadline.h | 51 ++++++++++++++++++++++++++++++++++
 kernel/sched/deadline.c        | 50 +--------------------------------
 2 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index c40115d4e34d..9468a9b1090c 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -37,4 +37,55 @@ extern void dl_clear_root_domain_cpu(int cpu);
 extern u64 dl_cookie;
 extern bool dl_bw_visited(int cpu, u64 cookie);
 
+extern struct rv_monitor rv_deadline;
+
+static bool dl_server(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_server;
+}
+
+static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
+{
+	BUG_ON(dl_server(dl_se));
+	return container_of(dl_se, struct task_struct, dl);
+}
+
+#ifdef CONFIG_RT_MUTEXES
+static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
+{
+	return dl_se->pi_se;
+}
+
+static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
+{
+	return pi_of(dl_se) != dl_se;
+}
+#else /* !CONFIG_RT_MUTEXES: */
+static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
+{
+	return dl_se;
+}
+
+static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
+{
+	return false;
+}
+#endif /* !CONFIG_RT_MUTEXES */
+
+/*
+ * Regarding the deadline, a task with implicit deadline has a relative
+ * deadline == relative period. A task with constrained deadline has a
+ * relative deadline <= relative period.
+ *
+ * We support constrained deadline tasks. However, there are some restrictions
+ * applied only for tasks which do not have an implicit deadline. See
+ * update_dl_entity() to know more about such restrictions.
+ *
+ * The dl_is_implicit() returns true if the task has an implicit deadline.
+ */
+static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_deadline == dl_se->dl_period;
+}
+
 #endif /* _LINUX_SCHED_DEADLINE_H */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a69d2f073916..3b4647575fa6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -18,6 +18,7 @@
 
 #include <linux/cpuset.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/deadline.h>
 #include <uapi/linux/sched/types.h>
 #include "sched.h"
 #include "pelt.h"
@@ -57,17 +58,6 @@ static int __init sched_dl_sysctl_init(void)
 late_initcall(sched_dl_sysctl_init);
 #endif /* CONFIG_SYSCTL */
 
-static bool dl_server(struct sched_dl_entity *dl_se)
-{
-	return dl_se->dl_server;
-}
-
-static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
-{
-	BUG_ON(dl_server(dl_se));
-	return container_of(dl_se, struct task_struct, dl);
-}
-
 static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)
 {
 	return container_of(dl_rq, struct rq, dl);
@@ -93,28 +83,6 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_se)
 	return !RB_EMPTY_NODE(&dl_se->rb_node);
 }
 
-#ifdef CONFIG_RT_MUTEXES
-static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
-{
-	return dl_se->pi_se;
-}
-
-static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
-{
-	return pi_of(dl_se) != dl_se;
-}
-#else /* !CONFIG_RT_MUTEXES: */
-static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
-{
-	return dl_se;
-}
-
-static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
-{
-	return false;
-}
-#endif /* !CONFIG_RT_MUTEXES */
-
 static inline struct dl_bw *dl_bw_of(int i)
 {
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
@@ -979,22 +947,6 @@ update_dl_revised_wakeup(struct sched_dl_entity *dl_se, struct rq *rq)
 	dl_se->runtime = (dl_se->dl_density * laxity) >> BW_SHIFT;
 }
 
-/*
- * Regarding the deadline, a task with implicit deadline has a relative
- * deadline == relative period. A task with constrained deadline has a
- * relative deadline <= relative period.
- *
- * We support constrained deadline tasks. However, there are some restrictions
- * applied only for tasks which do not have an implicit deadline. See
- * update_dl_entity() to know more about such restrictions.
- *
- * The dl_is_implicit() returns true if the task has an implicit deadline.
- */
-static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
-{
-	return dl_se->dl_deadline == dl_se->dl_period;
-}
-
 /*
  * When a deadline entity is placed in the runqueue, its runtime and deadline
  * might need to be updated. This is done by a CBS wake up rule. There are two
-- 
2.52.0

