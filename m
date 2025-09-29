Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D11A316C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759110398; cv=none; b=Ia/nyfIWnyJKjskInqhf/qxahg9fuV5bBIK6CSAzDgI2wkYck0SeCtV7+X9FXI1gxxQ7jAhWYRWLWcyN/umw7ufzobJejKtWjVuaHM02r6mEifE4syM659wqdZphqjMcU/K6jlTIEA+xqD3g0EGAPHGbMmSIcdLYrI5HCeQ6ZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759110398; c=relaxed/simple;
	bh=tPsQTvM+eiwlyUIt2YhLixQTyW//Bg+Wlvfv24oXcKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwOL+huUT+yydNIhyZQgevt23+IMXEmTYNOy3zl0xFlbq2BorS0aZx3BG/osWYTvXTM25xRqpaarKSIOiVTdD3tcSUsAX7YGaAvbCZ4op7dwtsecPf8t9HQ/cM+zfLlauMF3VClmwG54fQfAvLU3d9XeuHGXyd2Rf2YkFhdcA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=gd4XdedU; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="gd4XdedU"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 58T1gX0t005260;
	Mon, 29 Sep 2025 09:42:33 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4cZkRG21pQz2MZcn3;
	Mon, 29 Sep 2025 09:40:42 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 29 Sep 2025 09:42:29 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <surenb@google.com>, <hannes@cmpxchg.org>,
        <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <xuewen.yan@unisoc.com>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <yuming.han@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V4] sched: psi: Add psi events trace point
Date: Mon, 29 Sep 2025 09:42:27 +0800
Message-ID: <20250929014227.430-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 58T1gX0t005260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1759110162;
	bh=PYak0UliuFkoAGMykxnjYwa4GAB9iIqJIebJ8+Y2eTA=;
	h=From:To:CC:Subject:Date;
	b=gd4XdedUZmAXz2NHQGd+jI3JOJ4bLn1uDiJ8hSyY7x1Q/mSowI247mnBcBTUnl9bA
	 M9BOj77qOr4XKC3Ohk5doE/PP44ZY3CJWPS0zGihyG43zBOFQoQJiBwgy0mF6P/TQZ
	 p/PSKuSvqU65df2QTpW7JJKV7v9sEZxFKEqwaf3gcK1WIbMhmGyAr5dhzT+h0BxKvH
	 F9yAHedAYpo5DB6yWb462p5UrCRgkH/4xV8UOd+fUVHEmEt14TFSZS8NeF6BHz4j8/
	 /hUx0wHbD4G7dzgJTdM9ylP9NPW8cJP86GYdQIcneW7UvbdXv/y+MLZ7AOtPEVzOG7
	 7o+7wiavboyhQ==

Add trace point to psi triggers. This is useful to
observe the psi events in the kernel space.

One use of this is to monitor memory pressure.
When the pressure is too high, we can kill the process
in the kernel space to prevent OOM.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
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

