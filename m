Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8A285CAD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710649; cv=none; b=t9K5NxmuzDfPLRig8pbjbljd/q5qjX2qPLar4ql+g0LKTATvCPS6G+Xz475LacTfZnOXR2sOBJVL3ucRoOrLrrmJ0sm9fyy+9DHYlex5rFihhFLxC3tlnQ5yQI1j2ysJpx+kXFk+B1iUtDEOkiuviGorjlDzTFoCQm4ey4TfLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710649; c=relaxed/simple;
	bh=D4waafJBb8GB2KQ6vTZQVqxhUUzsp+qQ0C+MVheX+EM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WFXURwUdzOfWsm/QxpobrnZGQRr/it3An3HfIGyoO8Jc5+PO9rPuW3nYUB7OPlfH8g0nMK0rRmuMDioFAK1uHJKE5mQgJmwsDcWbOWVk7Cvjdpr5ZQYMFUbI6+w0BFayoU23VLcriDEaao+fmP6i1agUbHy7q2Nu7Bve7om9G5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=yTXovwUu; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="yTXovwUu"
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 5AL7bKNO042772
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 15:37:20 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 5AL7Wpeu089642;
	Fri, 21 Nov 2025 15:32:51 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4dCRfw3DHLz2K4jL9;
	Fri, 21 Nov 2025 15:29:12 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 21 Nov 2025 15:32:48 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <peterz@infradead.org>, <surenb@google.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <hannes@cmpxchg.org>, <vincent.guittot@linaro.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <yuming.han@unisoc.com>, <xuewen.yan94@gmail.com>,
        <ke.wang@unisoc.com>, <jstultz@google.com>
Subject: [RESEND PATCH V4] sched: psi: Add psi events trace point
Date: Fri, 21 Nov 2025 15:32:44 +0800
Message-ID: <20251121073244.9091-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 5AL7Wpeu089642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1763710386;
	bh=fejQzIuat6T8lIDshKqujybLYTGkkxBVeMkR1lJfnYo=;
	h=From:To:CC:Subject:Date;
	b=yTXovwUuGL5CFIRU0JYzo/LJr4pC3pGqIClxFvigQAfrhLvyPVxhygrD6c1LOke3v
	 QywbomAy32eO0Z1ZkxgJzRfG6yRe0/zQcgyeMeOqtPZ79tbkirZiM4yMwChfTopUYR
	 BlCiUwBHJnFQKZzidLtckvghZGomLUjXpVxx/8F6NCgHTS1uF8Nh2jX7dGKz/G04L/
	 KX3viyS6CYqMReh+dWU0qXzdecTDFsNaztT+imgdwkeXUi4shej7ofJb3ULQasN2Ry
	 JuGox0qRUbiUHNxRrPQspZ9qZa3Wx9sdkVQTkBiM+30hkXuHLulawKDibuxhpCpZuy
	 aUNwRxs+6TRog==

Add trace point to psi triggers. This is useful to
observe the psi events in the kernel space.

One use of this is to monitor memory pressure.
When the pressure is too high, we can kill the process
in the kernel space to prevent OOM.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
V4:
-generate the event only after cmpxchg() passes the check
---
V3:
-export it in the tracefs;
---
v2:
-fix compilation error;
-export the tp;
-add more commit message;
---
 include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
 kernel/sched/psi.c           |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..db8b8f25466e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -826,6 +826,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 	TP_printk("cpu=%d", __entry->cpu)
 );
 
+#ifdef CONFIG_PSI
+TRACE_EVENT(psi_event,
+
+	TP_PROTO(int aggregator, int state, u64 threshold, u64 win_size),
+
+	TP_ARGS(aggregator, state, threshold, win_size),
+
+	TP_STRUCT__entry(
+		__field(int,	aggregator)
+		__field(int,	state)
+		__field(u64,	threshold)
+		__field(u64,	win_size)
+	),
+
+	TP_fast_assign(
+		__entry->aggregator	= aggregator;
+		__entry->state		= state;
+		__entry->threshold	= threshold;
+		__entry->win_size	= win_size;
+	),
+
+	TP_printk("aggregator=%d state=%d threshold=%llu window_size=%llu",
+		__entry->aggregator, __entry->state, __entry->threshold,
+		__entry->win_size)
+);
+#endif /* CONFIG_PSI */
+
 /*
  * Following tracepoints are not exported in tracefs and provide hooking
  * mechanisms only for testing and debugging purposes.
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 59fdb7ebbf22..e8a7fd04ba9f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -141,6 +141,8 @@
 #include <linux/psi.h>
 #include "sched.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event);
+
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
@@ -515,6 +517,9 @@ static void update_triggers(struct psi_group *group, u64 now,
 				kernfs_notify(t->of->kn);
 			else
 				wake_up_interruptible(&t->event_wait);
+
+			trace_psi_event(aggregator, t->state, t->threshold,
+					t->win.size);
 		}
 		t->last_event_time = now;
 		/* Reset threshold breach flag once event got generated */
-- 
2.25.1

