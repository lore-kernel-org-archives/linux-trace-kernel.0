Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945A38A718
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140307; cv=none; b=YyHrkDysjz7GijzH4SbdIq13qLkqMkdBN2aOq9mAV7macs2AuvsNPcwqHXc+fuhZ7/wrWdQj8nzVXhNE1cay6ukFtcsI5S2SrMXEdJq1qKRZHyUYhLxuzJJMVatzFGAGfKi8znw9vyDV+E6jGxoAOMXaDklNu2VIsQB5Djw2D+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140307; c=relaxed/simple;
	bh=vaNx9s+u+PmlMjCNwQr+qiIHFtqBwKLYj6lmz2e3m6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=emWXOrBQd0E3+c2WrA/ZjZX+LcB5g4FJtaU0UKuD4Dn97NXFUj75nlq9NerZ0QInJHDvEv7CDStLC9GBJayq/kPYelnF4Fts5t5ptDUIGpxx2YHpCfMJSSL+2liszSkzDgcxFGdQEdDfuh7/2d8/Gk5m6LUeNC6PxHlT8t716WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iutGVzb9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iutGVzb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773140305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AE7FerkShcy7F8T4j3CXf2BQEybEvEs6kWShaYEHbMM=;
	b=iutGVzb9NJ3hNXdHToMWP6lwzgv32P4VcSrIMVnxSX7lRGXAzWo7WlZewxwfslBLP1gZlQ
	TCH/0q+/NSruoAWDEJSVREmzKWgmySFpYhwScxehb/nB9gtn8TfBX0r/GFIKB9syoI81mm
	8r/SQ/NUiIS2nJoUxCUqTjXhyn2A0io=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-_kNo3hIRNaa0udstoif5gQ-1; Tue,
 10 Mar 2026 06:58:24 -0400
X-MC-Unique: _kNo3hIRNaa0udstoif5gQ-1
X-Mimecast-MFC-AGG-ID: _kNo3hIRNaa0udstoif5gQ_1773140303
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EF5F180034E;
	Tue, 10 Mar 2026 10:58:23 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.35.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA1A51800760;
	Tue, 10 Mar 2026 10:58:18 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 13/15] sched/deadline: Move some utility functions to deadline.h
Date: Tue, 10 Mar 2026 11:56:25 +0100
Message-ID: <20260310105627.332044-14-gmonaco@redhat.com>
In-Reply-To: <20260310105627.332044-1-gmonaco@redhat.com>
References: <20260310105627.332044-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 02Ug0bEnDqKk4riPjdKXGuvVj_hf_cBStwvh5Ntbj28_1773140303
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Some utility functions on sched_dl_entity can be useful outside of
deadline.c , for instance for modelling, without relying on raw
structure fields.

Move functions like dl_task_of and dl_is_implicit to deadline.h to make
them available outside.

Acked-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V5:
    * Do not export pi_of to deadline.h
    * Explicitly inline dl_server()

 include/linux/sched/deadline.h | 27 +++++++++++++++++++++++++++
 kernel/sched/deadline.c        | 28 +---------------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index c40115d4e34d..1198138cb839 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -37,4 +37,31 @@ extern void dl_clear_root_domain_cpu(int cpu);
 extern u64 dl_cookie;
 extern bool dl_bw_visited(int cpu, u64 cookie);
 
+static inline bool dl_server(struct sched_dl_entity *dl_se)
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
index d69b3e44971e..570e2bec5e1a 100644
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
@@ -991,22 +981,6 @@ update_dl_revised_wakeup(struct sched_dl_entity *dl_se, struct rq *rq)
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
2.53.0

