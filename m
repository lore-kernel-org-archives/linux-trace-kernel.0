Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC22FD7C8;
	Fri, 28 Nov 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322395; cv=none; b=ocyx/EjyXp1JUQmNh3zs+MAwHHFFm0QmDBW0DLb8jgLw7AB7E7bYJEjCwI1wr+K47FTvCb+dfnovszjYcpd3CYTJmrQ3lEATEFWHR0ilkXVceihHhPKjiUjr6ETboFu0oyNgiVNlTPQr/UqCaA5EG91+Ku50UvghMWv0ZjeDZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322395; c=relaxed/simple;
	bh=9bn07rJY4ksh7dTeShVB58dZTJD4ujCLkqrXvaoWZYs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XkPGbncaXskciEqY8g04qEzAdJKsEt5VgssMLJZkpsNruOInx3ll+iKjt4Skest4nQR/j6U0Zvu67bhVgSSaSJOHUkF7pE9CtmEg84BcEcR73e6ZNK+3nT3tQkJZUD54wt3GWKYRs9fBfRVN37o/2n1xcJ2H1w6EAxud9BXoL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ixDTd2fe; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ixDTd2fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764322393; x=1795858393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0PaeDR9xr+EMrlMtz7KnHpgRGhMWJOgrVvz7hwCEMr0=;
  b=ixDTd2fexYdNiwxhDGmP+mV7Yay/giajLDTfMrcii36IMGJqmmgOHuzH
   TSuo9reu5BdKPLxURQhsrMnsoXRyG+eOWDqioQNGEc3Vuy3g02M5xGpzI
   1/4iqY5lLeqELfUYqiE6xCOGKVTFQ4/zCg2KhK3CI+G1h7A9p+zudjc5y
   3Tex6KaSrz5KuJ94NH7yEpyDjVEdfkhbWHtDkCq2IlAqicY/2jU31eZJF
   5IvlHUhL3VblaB+fwDiOrzwNaPbK/8sC5zZf7aNdBj0nGWHAfz1fh/2ug
   cLkBFoROnMR3xDE261qmHt21g0gRRLWLmSbrN6XvhZzNfAu2BuuXIQbW6
   A==;
X-CSE-ConnectionGUID: ksgq6324SZysRyh+BRf0PQ==
X-CSE-MsgGUID: 6R6I0quPTTSNo9IooxSCkw==
X-IronPort-AV: E=Sophos;i="6.20,232,1758585600"; 
   d="scan'208";a="5815041"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 09:32:53 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:26972]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.211:2525] with esmtp (Farcaster)
 id 33974e25-456b-475a-97f6-8e43f2005cf1; Fri, 28 Nov 2025 09:32:53 +0000 (UTC)
X-Farcaster-Flow-ID: 33974e25-456b-475a-97f6-8e43f2005cf1
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 09:32:52 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.109) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 09:32:47 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <vincent.guittot@linaro.org>
CC: <linux-trace-kernel@vger.kernel.org>, <jschoenh@amazon.de>,
	<dwmw@amazon.co.uk>, <kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>
Subject: [PATCH RESEND] sched: Add core cookie update tracepoint
Date: Fri, 28 Nov 2025 11:32:22 +0200
Message-ID: <20251128093222.119435-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

ftrace based analysis can be used to qualify correct behavior of cookie
based applications. Security posture can be verified by tracing the
amount of time that tasks with different cookies collocate on hyperthread
siblings and asserting that it is kept to a minimum. Performance posture
can be measured by minimizing force idle (when an hyperthread is kept
idle because it doesn't have a runnable task matching the cookie of its
sibling). It is necessary for the application doing such an analysis to
know the cookie associated with each task at any point in time.

While the task to cookie mapping is driven by userspace and thus can
alternatively be supplied through a custom side channel to an application
analysing a trace, it is more convenient and accurate if the mapping is
already part of the trace. Given that these events are infrequent the
induced overhead is negligible.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Link: https://lore.kernel.org/r/20250128113410.263994-1-sieberf@amazon.com
---
 include/trace/events/sched.h | 30 ++++++++++++++++++++++++++++++
 kernel/sched/core_sched.c    |  1 +
 2 files changed, 31 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..e3298eb0702c 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -826,6 +826,36 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
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
index 9ede71ecba7f..26eb23331fea 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -73,6 +73,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
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

