Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE3199FA2;
	Tue, 28 Jan 2025 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738064120; cv=none; b=cj5Cn0twSxxqEmSQkBRRXo/JIW54twnvlpeHsmfW6HA38ZEWom5WqF0Y1VRwLT9/DflrkEnobKSFWlkcsIl3JU8xpspCXev7iwKR6p7fsinrAznnKnpbgEVps81lC3AHKXR4/UwERcNErNXcIS/VR7QquFmQMT61wPBD9mVlqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738064120; c=relaxed/simple;
	bh=jn9JOzF/WGN4qS7WXLtT+tiy3cYKUHmGk9MSF0J4hAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LMMBLk5AcqQQMgUG2CthqgHDDt3NZfSaqF4ozu1+je4kL91LY1zw5Qf0oFjBl9ReAJsKoNVK36e8oVvDslLsH+QqqTXLYu/t40nFggaFB6f8RFz4Q0pYBpsYwtqxZFiYwqsWBx6OXb8fFgmj4uK9QN65zhPMU+/KLpmcppau/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HLpwWYk1; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HLpwWYk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738064118; x=1769600118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ALvlAGGcC808olnSz8qV7J6SDsjm68j7lwtsFRijClQ=;
  b=HLpwWYk1cIt2ToRY+g8JGGr9hqqQc8rKGSv8FetZtJ186UcAZLfi/vCx
   aIEpqhG6rCR4pLALmSpkI4idrbCcxHWFdlG7PNW7bwYH65AGuAIZ/a6k7
   YqlxPztk9gdMSEij2HqUpZJ+mVbd3mIkWLUHKWnYGaP2Etvs7wy1EFiip
   M=;
X-IronPort-AV: E=Sophos;i="6.13,241,1732579200"; 
   d="scan'208";a="489233206"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 11:35:10 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:44674]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.144:2525] with esmtp (Farcaster)
 id 09de9ab6-b565-4a85-95a3-37e773e11524; Tue, 28 Jan 2025 11:35:09 +0000 (UTC)
X-Farcaster-Flow-ID: 09de9ab6-b565-4a85-95a3-37e773e11524
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 28 Jan 2025 11:35:08 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.220) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 28 Jan 2025 11:35:04 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: <linux-trace-kernel@vger.kernel.org>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>
Subject: [PATCH] sched: Add core cookie update tracepoint
Date: Tue, 28 Jan 2025 13:34:09 +0200
Message-ID: <20250128113410.263994-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

ftrace based analysis can be used to qualify correct behavior of cookie based
applications. Security posture can be verified by tracing the amount of time
that tasks with different cookies collocate on hyperthread siblings and
asserting that it is kept to a minimum. Performance posture can be we measured
by minimizing foce idle (when an hyperthread is kept idle because it doesn't
have a runnable task matching the cookie of its sibling). It is necessary
for the application doing such an analyis to know the cookie associated with
each task at any point in time.

While the task to cookie mapping is driven by userspace and thus can
alternatively be supplied through a custom side channel to an application
analysing a trace, it is more convenient and accurate if the mapping is already
part of the trace. Given that these events are infrequent the induced
overhead is negligible.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 include/trace/events/sched.h | 30 ++++++++++++++++++++++++++++++
 kernel/sched/core_sched.c    |  1 +
 2 files changed, 31 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9ea4c404bd4e..6034acbc1893 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -769,6 +769,36 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 	TP_printk("cpu=%d", __entry->cpu)
 );
 
+#ifdef CONFIG_SCHED_CORE
+/*
+ * Tracepoint for assigning cookies.
+ */
+TRACE_EVENT(sched_setcookie,
+
+	TP_PROTO(struct task_struct *tsk, unsigned long cookie),
+
+	TP_ARGS(tsk, cookie),
+
+	TP_STRUCT__entry(
+		__array(char, comm, TASK_COMM_LEN)
+		__field(pid_t, pid)
+		__field(unsigned long, oldcookie)
+		__field(unsigned long, newcookie)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->pid		= tsk->pid;
+		__entry->oldcookie      = tsk->core_cookie;
+		__entry->newcookie      = cookie;
+	),
+
+	TP_printk("comm=%s pid=%d oldcookie=%lx newcookie=%lx",
+			__entry->comm, __entry->pid,
+			__entry->oldcookie, __entry->newcookie)
+);
+#endif
+
 /*
  * Following tracepoints are not exported in tracefs and provide hooking
  * mechanisms only for testing and debugging purposes.
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1ef98a93eb1d..0321ccd9f944 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -71,6 +71,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
 
 	old_cookie = p->core_cookie;
+	trace_sched_setcookie(p, cookie);
 	p->core_cookie = cookie;
 
 	/*
-- 
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07

