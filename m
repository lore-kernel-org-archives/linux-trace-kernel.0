Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA8372B5D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097402; cv=none; b=OgoXzfGKgqXqup57YByClCLpveX9TIfRcjKN0gVNNUZPQnigSeDU/vsy2SqJx2wIUuUcP/ZWtzo50ezDQ3580AhrM6NOrk026Qw1AqgStkO+t0vKmpb5g52oD8qb6xmC+G2zo2UH+ttdId/CqGYVnKYbUeuglyCaXhdn1XfGA3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097402; c=relaxed/simple;
	bh=HxZWeRSYutY0jtxgVODXBkfj8otsGkGb28wdnKFFUwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9i3n9U9OdEapIxzHn84VrecS6BQ9M2TB87FV6WMG6+vRstQf++yT8ht98nezbl/THvj2mRy/REC2lN1iF8lKSSq9lveoV9wVXlVB1eH/o0JCPiSrUV0job46jcXjekWEmx35Ybc25KSM6rsWy/7tCRsdE4IcxJs5qdbXOSgWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKtBmRGu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKtBmRGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769097391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVSi4pcbTB/K1W7G3tmcmc8yhizE4v2BtEGVUY/SQmE=;
	b=UKtBmRGukHkcxqQknQAPCuHIl8fT3w7rs7VNwAmuAcwdiXe9wt7zXGxqnZ69Jnti0oE3Kd
	J5ReWzQGgJi9s1hz8hyk4VCngc6Ng+FWDQl8sgGb2U9o+5Q8HTMiHFwE/pEQEFc4lYSB3q
	m7OUxEnbqGtroKoAYnc065K6n06c49Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-OzzSPyGvNkGX7TyKxKF1Gw-1; Thu,
 22 Jan 2026 10:56:28 -0500
X-MC-Unique: OzzSPyGvNkGX7TyKxKF1Gw-1
X-Mimecast-MFC-AGG-ID: OzzSPyGvNkGX7TyKxKF1Gw_1769097386
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD5B719775AC;
	Thu, 22 Jan 2026 15:56:26 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B248180049F;
	Thu, 22 Jan 2026 15:56:22 +0000 (UTC)
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
Subject: [PATCH v5 13/15] sched/deadline: Move some utility functions to deadline.h
Date: Thu, 22 Jan 2026 16:54:58 +0100
Message-ID: <20260122155500.362683-14-gmonaco@redhat.com>
In-Reply-To: <20260122155500.362683-1-gmonaco@redhat.com>
References: <20260122155500.362683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some utility functions on sched_dl_entity can be useful outside of
deadline.c , for instance for modelling, without relying on raw
structure fields.

Move functions like dl_task_of and dl_is_implicit to deadline.h to make
them available outside.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V5:
    * Do not export pi_of to deadline.h
    * Explicitly inline dl_server()

 include/linux/sched/deadline.h | 29 +++++++++++++++++++++++++++++
 kernel/sched/deadline.c        | 28 +---------------------------
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index c40115d4e34d..d25a5dc2c5cb 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -37,4 +37,33 @@ extern void dl_clear_root_domain_cpu(int cpu);
 extern u64 dl_cookie;
 extern bool dl_bw_visited(int cpu, u64 cookie);
 
+extern struct rv_monitor rv_deadline;
+
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
index a69d2f073916..08158dbc21a8 100644
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
@@ -979,22 +969,6 @@ update_dl_revised_wakeup(struct sched_dl_entity *dl_se, struct rq *rq)
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

