Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31938F254
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013170; cv=none; b=P5tWN+r4NLP5NvedM8KLCaQAeHT7A2eg0bv9sczIiI4t2W00b/PJM1UzouPVGzCX5e6iZzUJMZCeGGkzSQDAs4AnM/TGn1cZyE6tgueH5SqHz3ex5R8EcPbIJUu8brbIqaWJv6q8bfsnDbrErDCHsSJrPIXcvMj7r3hQFSFCtIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013170; c=relaxed/simple;
	bh=PfR9SdlezVt8tzNcAHMRd097cbreybH7a3p1rBNlBNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TBAQcc5rl4WbJGenMesDCURiyLYTuk3Sx24cbXheC6HV7sg25yJwVO58NQ4tUDgR5nlDhUO3cO3DiLhRel6Yh7EoiwOIFkPcWtSK+BgG8J31Ssf6bPOEKsCDXPQihoFS0vEIZO4DR2XzfKQhmjRqSWnF+rjQUqcFfnCkPHrk/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N124WIz8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N124WIz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8V3X5hkE2IlquoPrOEJqRu0ztnuYk/PhzlZd0fakUDc=;
	b=N124WIz87cALWrEJnPmqON9Ox3w+RXao9/NBc0fNCfp6dzFopIUJ1hGRG6s581I7EJgXPM
	2lIaSJs0LqG7dzQC/tB6LdwmJmnqWI4Aw4KP2OQeQUE+gGYFpqSC3H5oxNf4uiJHg4sv+x
	vDSiYV9GS/NTylfqB749bTh4QcGi6bI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-wWVz5cGgM02OfIz9xUUeLQ-1; Wed,
 25 Feb 2026 04:52:44 -0500
X-MC-Unique: wWVz5cGgM02OfIz9xUUeLQ-1
X-Mimecast-MFC-AGG-ID: wWVz5cGgM02OfIz9xUUeLQ_1772013163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 550F01800378;
	Wed, 25 Feb 2026 09:52:43 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.216])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 622861800370;
	Wed, 25 Feb 2026 09:52:38 +0000 (UTC)
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
Subject: [PATCH v6 13/16] sched/deadline: Move some utility functions to deadline.h
Date: Wed, 25 Feb 2026 10:51:19 +0100
Message-ID: <20260225095122.80683-14-gmonaco@redhat.com>
In-Reply-To: <20260225095122.80683-1-gmonaco@redhat.com>
References: <20260225095122.80683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: o_7snaw7q6246gZjB1_5utuF2_ngr28CKtMyYyGzul0_1772013163
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
index b8d01f0eda7d..c340cb8405c3 100644
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

