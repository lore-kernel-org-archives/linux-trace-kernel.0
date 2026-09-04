Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021141.outbound.protection.outlook.com [52.101.95.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60802511222;
	Fri,  4 Sep 2026 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550498; cv=fail; b=H38Kqe2xKRTIVUDMh+kiUq1c2HHM8KiUPZk0S8gjEM6KJBPMtSEtl34n5zNQ5Qwg6b2YJBcThs3yf/7qXs/cOh3aPzmPyeyZxeZKZRJWAN5GRZxw/WfRkDh4u/TQp4p6jvVjzTABO7tJ8reYxGX0SjXEqSxtwG+SWcVJqt/Fcog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550498; c=relaxed/simple;
	bh=IjM6tPF+KSBrbl6tvDGDsc8LsiV9fJ/DNxEr8obtcdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBYV8WWevP7pdgwvp/K85T6QJZp5/N/wb0ysb4otTB5ltEex+eb8xQJgkqzq4gxpemnYvNGCdyFWj7WuytHACYSAYXoG07EjAleajiCe2tQKsk/t2rUft84b3Av+bFMQsSWam6ruEABie3BEujSHKHOwFqbV6acrWin/q7tctAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj25hPNg3jEi9eouW0btdRyl2FQWIoC2FOi2nyg99UrFzwos5YURBtYSUap9/nZBv5PwCu2Vb7H8syMaLnq9RZcDFPokozwebNd8H67kK/mECoE2RemLCzYG1YlZqdqrNjlDBA5a+lKSbP/e09yr11XZZgP1OpyeYcvpVafHszhqUZVmmBDFkJxGqCtXQRMnJTAp06GQPo0IyXfAMfczAI8XUWhIEjs6v05wkcJMCu+6sZBxC5aaTJYw9FSKHwk5nhtDlO4lR5NxVqmTrw2yLIKj5H1c+R5HoFiDWA0eRhnEqLr4f5qmfBl40MLeo0Y69VbRDJVjiOrZi2/obKd8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=T7O9lvpns/4pU+Cc0w/gFbEPoPkbxb3Ug9E7fy3mvQ0=;
 b=YvxAcu4mUehhj9BiTnr2Xc9amlEFRErU5Q6lvz3Ar70fg2/xmzRn5pnUTjZjmBm/7WOq911Osg/Mh3CBrmsaFN8LlLUU6HQcPI9JVgWo5rktLiPqouQPtGgMakgPTxu/32XiGzT8V2oxsw9KnQO+z5TMBSk+pSkij9Uwxe+BPTuTtgSzNFfJilgUggkMO6FFuIBz3nwkwRO4ujjXS2aXBh9wy1e765yPJiLRFgbYwuJXLQWQN8GMYjCuh7dm06zgwGGghPvB8QaHmifmFCdTkzxX0uYqaxPXTe17nGV5vLvCX8Ag6mjjDa+ka1j6GXetm+iwmJiESZgfunk46D6/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6609.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 19:34:54 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 19:34:54 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	osandov@osandov.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	sean@ashe.io,
	marco.crivellari@suse.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] workqueue: Add workqueue_cpu_intensive tracepoint
Date: Fri,  4 Sep 2026 15:34:45 -0400
Message-ID: <20260904193447.247502-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904193447.247502-1-atomlin@atomlin.com>
References: <20260904193447.247502-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddc7b72-7153-458d-b99a-08df0abb984a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xJUxI5ztzxZtEmpBGU/t6QnMOb/pnVwUm4l/uJjMXInnWzaKzshZM1oN94Gp1ZOI9TUGFbfTUKjQHgnoqu+f2h8jsq2gQ2EYgCxpwbsG/0TnflW1xXiYO/0A9yMm7zdmzmiIZ/u4odndVqnpiLwOv+LtXhMnvbFXYNGDBVuWuPs8Ci0Z33hOaZDIeYp2OfRzCiM6pf2vXMmYnj0+vHTY6LZCX86kEVShBL00y/6mu2JP5Ldzed8RJPnWs1SHp2p27gm8/r9lJQwV1aNmvwWC7Ijn0z4inFHq4SDGoSB+eBid1X1/dzH7Ist69wbsdvg/9LBgm6kPaZREEugHy+9Hm2/Balnx5CV2SetC/aO+klPXcTCBG/aSgdr9NhEY518+GTKWtQT6Vi+eMTJjcPeRJ1cOPV9Jy6DsNZuiy1VjAftisgeVueSngQFhSe5SyQrivRZZkyqWS9/omPh75n+HrzCpdcWWqKGglhUZGQEN2FB8Yw8hzSzq7Sf57vheeFxe3J+EALuU65YNsnRj1MnzIvc/De4Os9YzSCyAwPwk/kRKllJL7gkt3HC0kl67quh9IWmUa7rFGJzH2Kz20+6tMbK4fXSOzNQn1uBeskO6MxniYQRh2LrRtFYjRhO7vIbmofw8jgse0mhFHaobEggUUNp9QIWH6Ov/38F5/7+yPNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ximktAxfjaFQ+/5IRoo6A2LucDPYvTYsj/gORbfFl6yfSlbcu34zSvPx4O0Z?=
 =?us-ascii?Q?4pJUhqoRz92QmzDPM3cQMlkb41RwjdLQJuV3wyluuEwdYnEDE2rsrGkssSoZ?=
 =?us-ascii?Q?7duwCYwjBt3apzq5uzzN82n47/U/VCKxMg9zrOLzDY9ShTcV26zj040hlaEq?=
 =?us-ascii?Q?+u5KM4FcHl87XHb42k+GkXk8D/ScjgWCBdfw2EVe4ev9PrmUzt729S5Pe2Ir?=
 =?us-ascii?Q?C621XPWvjMIMei9D3sEOJE5HsNnLYUYB8cRFsogjN2MbBY82/AecXcSmZs8A?=
 =?us-ascii?Q?hUlSFOqaPwCbLA/iHR0Gy5hoCYXCHdw6OLc3lDwYGNpS0Gnpi7S3RWrZklrx?=
 =?us-ascii?Q?oQTkPqKiMSqAVBCbY/Xs4QYVKapDfsd46p60Ya6/tw9BuUejqwtgIMyiI/0w?=
 =?us-ascii?Q?BMxZmOncG7204P85dNCNu2ThxhCQ/Oi2g7gggYr151yI/+kxPY31p9romf+B?=
 =?us-ascii?Q?eBnMr2qrcv4Ke9MHVqnXClOGlbyGpu+8cA9Z2ogONu9UC5w5ljeREnBWBZX/?=
 =?us-ascii?Q?pq6iwZZ7vkHlYG9NDnxQBw2W6sMPLtFOkT+RbiXT+JClKaM+eJAc1yNuaCv2?=
 =?us-ascii?Q?hc4V5opdsxuiTMbWRlDJ23UM4pLS3NK0Pxo7QPMmLN1EYXAUNqng30o308k8?=
 =?us-ascii?Q?L12JPqjIdh3QptcL2MHgEXv4owL207LR4L3ReTwcPpgS3gSRXZtJVWT8aMyb?=
 =?us-ascii?Q?GT2uVcbSc6KKWaFCyqoSibgwX5hX6n2AvGaPgAfBhrY1hi0Tgl7Sb7j8PlDS?=
 =?us-ascii?Q?q9HfUy6ha4XA/uKTpJkPec63OI8UYdEGtebL8kAsb5ond9XT3+1UiJ1mT8wz?=
 =?us-ascii?Q?prSOGeDcuAuf6rRCMcvwKfHrBLvAw6QzTOj0noyakNXz/11iGSn1BXIbYkie?=
 =?us-ascii?Q?vAmlkqcdgm6ewFNUoZcSLfu5izpqJPx9h6Z4ESWpE91CuVgvviqSsXQfPQZv?=
 =?us-ascii?Q?1judaz8r17bo4RgMsvQ6W2tU+3X5lDNoJQ6RuYOUq+a2ieqzrKe/J44p8sBs?=
 =?us-ascii?Q?B36GrbIpl/ZJjl76pAU6sUyXK6LY5IPeWBOJDjgI14/oeqdUXaokwuwdI0RE?=
 =?us-ascii?Q?KkHmnqSS5mRndSwKKLlvEefuXL2/eq5im1wK+MYaUr1OahWGDt4R9KH+bf6l?=
 =?us-ascii?Q?49Klm9yfTyCGM7RHFP/hGJ2afFGtfU+qAt2drSX2xNuaMr5ExB/UcfuWbrxy?=
 =?us-ascii?Q?R+2puFRqMlhmZBHYabUL2Gl4R6CmP9Y4SlpKiMrlJOok5rH8CsVG7v8GXJAf?=
 =?us-ascii?Q?nF941TIZSDOHettFw206dx86lpD2YW7IlNNeWqZSXAPB51T/mA30aFdBKK0E?=
 =?us-ascii?Q?rQXbyFcbhO/dGY8LGKOMzSAGjS+lF8ukLnCT6rHOUiaiTbkMUelJcG6Zef5d?=
 =?us-ascii?Q?74wGwOu7Qkp37BGszO/UQwKwfhfIwC20OK35CrBd63DcKpQDQ8T5CqJ3184B?=
 =?us-ascii?Q?n4xvrDtUYO1+THj7mkdIAkUzBxNSd6sJ74D88fhk2O1K2gmUXtUYd2HtvraC?=
 =?us-ascii?Q?flLstv3ZdfEqw0atdGuVfuemQf+0E00HnKs4QTbK4F200zsEpG5YJyRUF3+x?=
 =?us-ascii?Q?Q86GvQMWsoj9sv5tsf84PTJnoDsxSBI/1fVHG7DNEUOFjK0AbGByFnrR4c+3?=
 =?us-ascii?Q?BLw4O3VC4uaBE8p6gIF2If/dFYgm3MaZJfgmHQWZmd7y08DsP2j3pP0j+umE?=
 =?us-ascii?Q?hyu66XoxS15eA1iLUTSNIIYcZzpBu7lnUN7Mym+Zl6RtXLMR9mStWztmYenV?=
 =?us-ascii?Q?x00M6Wz9zw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddc7b72-7153-458d-b99a-08df0abb984a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:34:54.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLkxmj9Ef2DTmwKCkpGOUloPJDgbe0hTzE+gpzRlry53hvbXYY4Z/4IoHHHhZ/VuRFBYbcpewdXn2tsnhNlRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6609

When a concurrency-managed per-CPU work item runs continuously without
sleeping for longer than wq_cpu_intensive_thresh_us, wq_worker_tick() marks
the worker as WORKER_CPU_INTENSIVE and kicks it out of concurrency
management so that pending work items on the pool are not starved.

While CONFIG_WQ_CPU_INTENSIVE_REPORT logs rate-limited warnings and
pwq->stats[PWQ_STAT_CPU_INTENSIVE] maintains a cumulative counter, there is
currently no tracepoint emitted at the moment of this transition.

Therefore, add the workqueue_cpu_intensive tracepoint, recording the
work_struct pointer and callback function pointer, workqueue name,
executing CPU, and the runtime duration consumed in microseconds.

This enables eBPF profilers, bpftrace, and Ftrace to immediately detect and
attribute CPU-hogging work items in real time.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/trace/events/workqueue.h | 40 ++++++++++++++++++++++++++++++++
 kernel/workqueue.c               |  7 ++++++
 2 files changed, 47 insertions(+)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index b0de2bc9ed52..d2ad38f93a83 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -126,7 +126,47 @@ TRACE_EVENT(workqueue_execute_end,
 	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
 );
 
+/**
+ * workqueue_cpu_intensive - called when a work item exceeds cpu_intensive threshold
+ * @pwq:	pointer to struct pool_workqueue
+ * @work:	pointer to struct work_struct
+ * @function:	pointer to worker function
+ * @duration_us: CPU time consumed in microseconds
+ *
+ * This event occurs when a concurrency-managed work item runs for longer
+ * than wq_cpu_intensive_thresh_us without sleeping and is excluded from
+ * concurrency management to prevent stalling other work items.
+ */
+TRACE_EVENT(workqueue_cpu_intensive,
+
+	TP_PROTO(struct pool_workqueue *pwq, struct work_struct *work,
+		 work_func_t function, u64 duration_us),
+
+	TP_ARGS(pwq, work, function, duration_us),
+
+	TP_STRUCT__entry(
+		__field( void *,	work		)
+		__field( void *,	function	)
+		__string( workqueue,	pwq->wq->name	)
+		__field( int,		cpu		)
+		__field( u64,		duration_us	)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= function;
+		__assign_str(workqueue);
+		__entry->cpu		= pwq->pool->cpu;
+		__entry->duration_us	= duration_us;
+	),
+
+	TP_printk("work struct=%p function=%ps workqueue=%s cpu=%d duration_us=%llu",
+		  __entry->work, __entry->function, __get_str(workqueue),
+		  __entry->cpu, __entry->duration_us)
+);
+
 #endif /*  _TRACE_WORKQUEUE_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
+
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3c034cbc5bb3..bad1217cf45a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -56,6 +56,7 @@
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
+#include <linux/math64.h>
 
 #include "workqueue_internal.h"
 
@@ -1532,6 +1533,7 @@ void wq_worker_tick(struct task_struct *task)
 	struct worker *worker = kthread_data(task);
 	struct pool_workqueue *pwq = worker->current_pwq;
 	struct worker_pool *pool = worker->pool;
+	u64 delta;
 
 	if (!pwq)
 		return;
@@ -1572,6 +1574,11 @@ void wq_worker_tick(struct task_struct *task)
 		pwq->stats[PWQ_STAT_CM_WAKEUP]++;
 
 	raw_spin_unlock(&pool->lock);
+
+	delta = READ_ONCE(worker->task->se.sum_exec_runtime) - worker->current_at;
+	trace_workqueue_cpu_intensive(pwq, worker->current_work,
+				      worker->current_func,
+				      div_u64(delta, NSEC_PER_USEC));
 }
 
 /**
-- 
2.55.0

