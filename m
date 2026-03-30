Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C53C73EB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869101; cv=none; b=rCc3nq+5E1dB5fBlsoD59sXTjUctaqsFtMPxefSJTq6BS8jYjI+73Og0zGYdIpUH2omiv8F6+dC4cAgITOqk1VNDju8yLSANNCWE0wx02FGmUyuUwUsnCwUkgk9xP2QZgXiOaLTQh1EhtZ1bjYpIaV8gSNyJrKBmEYIoGvM0YTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869101; c=relaxed/simple;
	bh=EUrUFAQQ3lJqeIRiWaKIKlvyHFdyrQjMMdaTyblMUvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K9kwpIxtq5v+ttKhJrWE64R+xO2vbi4uOVLvi+62bMGuBLjdzYHkFqYKr7BE0ao2Xu6RBndjuP3j7aC22yQmzGr/YZXqNTXwQIM9Ay6J4HCdKP9DaXoe7XAOYJz0SaU+Ntm7xG97UnP8pnJaUiu5enhGHgjxV8aBOahRo/HaQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVDgKPBZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVDgKPBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774869093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmdUAOSjwNTTn7v2gqNUD965bNyDVkXQ0VFo2lZIPVc=;
	b=NVDgKPBZDwKlroiQKQHJSD/N9FESOThzS9ZDQrmOVYYIEZsRT+EMjapc6kGguoxEJZTDOW
	NPUqYNfwC8x8w+3U26rwPoKpliukb7R6G00kQh/fsPeTMMH8r6N4OkZSmB3XNKliVJ4+ts
	OQsP6qorWHwkWy9396EgOlRPXP9cKRQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-gmo4X9-dP8SLdSi-jgCkKg-1; Mon,
 30 Mar 2026 07:11:28 -0400
X-MC-Unique: gmo4X9-dP8SLdSi-jgCkKg-1
X-Mimecast-MFC-AGG-ID: gmo4X9-dP8SLdSi-jgCkKg_1774869087
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B91E18002E9;
	Mon, 30 Mar 2026 11:11:26 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.33.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80DD230001A1;
	Mon, 30 Mar 2026 11:11:21 +0000 (UTC)
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
Subject: [PATCH v8 11/12] sched/deadline: Move some utility functions to deadline.h
Date: Mon, 30 Mar 2026 13:10:09 +0200
Message-ID: <20260330111010.153663-12-gmonaco@redhat.com>
In-Reply-To: <20260330111010.153663-1-gmonaco@redhat.com>
References: <20260330111010.153663-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: z30OVXNMymNiskS2hgcwBMaxJ4FffYL-Qg9tDr7XCNU_1774869087
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
index e511e36916bd..c10415c1aa4a 100644
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
@@ -990,22 +980,6 @@ update_dl_revised_wakeup(struct sched_dl_entity *dl_se, struct rq *rq)
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

