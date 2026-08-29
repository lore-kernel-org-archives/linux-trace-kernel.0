Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56741CB20;
	Sat, 29 Aug 2026 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044730; cv=fail; b=XcetpHWko4gh557jwlf5gvbySqkZXkKoo7msAB6y7Ren74lUOjG1RbMpZuHSz3LrYfyowhHuR1mTf8s6rg+Y3BYxoxStUBZ7kWWoTTj5t+2blXHxIYcXgHPWFYVC4+fFtwN3sJ+Zp39JOqcSyvk69dcZRaHiBSF9pfxPeiY1+tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044730; c=relaxed/simple;
	bh=XBWxHG0KNX2zQQzSCP7NAsj6y1h/2YJFLW3Rxng+wrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSuEYFi4FlTCpbQN6uNeWGpdyxV55+Nu3QbICmKuGkSKFzBWj6SZQxoKVbZE8NCSRTvjXxDtgdM2lKcF5q9NqIAV9ypU24wh3bSxgpjhV3a1nWQlk3tx5Zx6Z4L651SoeHTlhIJAhexBAwZjBBHkdB+JHHgNIJ+1QSaX83cJAXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyG0iuy2Ak5mbVksGCWGkUEUhKZrigIARqZrMbUUVP0pGavCFtu70bfOybhB+yMup7pnJxpCBlGjs785XDARD663GnjiB5jTshJoBRTstARsFytPDKHVvtSvJIcdSyRcSOUhGSZEKQedS7dlT0HABNPlAU2hVI+LWESm+U03COTbzXYgw0So2Z8Akohw3ph5TaPoSxYgwkbsD7cXC5ocEnuBpf6Qwc0RURanU8DrBoRu01t0FUwSlZensE0FVu1UywEn9Z8at1XyHhS6EVEzWNiViAxYx7hARA+wd6krntVx5wXIlecPRUyI3JY+TbKSJAbz/6qE5xbK1YceKrmovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=OYMGu8J62ruScyV8VKzm0/riYEUw5t/297iGAfkwSmE=;
 b=rUcRRJjIOSWKF1w95/CSZu5HUS31GDkpO6FYbkh1WtSInYixYiUReaOgG8mSIyxneAxMzCPtSYFuwB/UqJbuyjIfUdI84PnxoCsFEC1bAJ+PSznVhlx6GZ/Cb435a9xkU+dHcHZdgfbN0iEVjtFRzoeMlN8GnCNF4Ftk8Xwi/pD4cgt7amJbIq4XYm+V7omhEoRxCFNj7e6d2SHFAYPTwlaTVBUUr/xUkQrVuKStYeXAdse9UDrUIL0/Jj8jabzeWN/3dWicUBRI47Hs69QBeoph4qyJTSL239DsYkXMAMBtuXC24tVoecPeuhzk6Bn19ZPc0EcenYDAzX1uVSPa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWYP123MB9008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 29 Aug
 2026 23:05:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 23:05:25 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tj@kernel.org
Cc: jianshanlai@mail.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	osandov@osandov.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/3] workqueue: Add workqueue_cpu_intensive tracepoint
Date: Sat, 29 Aug 2026 19:05:15 -0400
Message-ID: <20260829230517.42468-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829230517.42468-1-atomlin@atomlin.com>
References: <20260829230517.42468-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0651.namprd03.prod.outlook.com
 (2603:10b6:408:13b::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWYP123MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 60df1c87-8165-4db6-9d66-08df062202af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7euXUixEav6WkwCS8VjTO9dUE3En0t7/bvTrjQU5g9ENLO55NLgmSiZ1Mnn6d5nL/r/GlysEykR0c19d/cWyo+KjudysJhfi12zEHOg9t136uCcxfdJ0w2tegK/UPAesbgBudi/YVNbccrgn1My9pT+bFqHZkPTxblU0h0t8kGhHkBblg0eC+xEr45tNpfS0/b8C6R583hwq3ukNuSdaPjCJsP9pefceDR7PZuaIbsevR8A5QDRywnXEkj3QV5geHGVMFOdpBWdWn65dxh3IMfBnY6kQacMocnPft36D/2HhKRdYPB14lab1l4nnmMluLSaTM7WJPHWHd90nuXYTVAuNSB0m5Q+PKNtzqB0BagXpG8W/O64QEBI9kuP5YTckSyMK5udLo91YkWXDwKiPagkjRqdrHqBsj4IzO3uIswFLcoKOU+SEidUvvoTjZ9TqfISOk1futkr88EwKP6bvHJBD4JbL8xxsj3TtBsq+X/xLhyhCmSw9jzkhPyuxO1HqGxtlH1BW4XixauAkf3u4FWaGEawPz7OCqPnCbRH8aiC9cNPh+DOZGsrtxDgdqeWiTP69I5L0OPwiMgL1RTm5i+AK+k0taARpeCosuLXAW8aymWF39j9aEseDjH4N+nbf61CtAht9lU3UVOM1fCyqygR8gjGyJM5YK9ppeQpKKl4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+ec/QMDJ9IYG4W6HNb0Mitrr6xjLPswq+N8mn8pRE8z81CFxf8VqhIC8bMh?=
 =?us-ascii?Q?S5MQRtEBHXM97Q+ZvfaBXdirrL6zEb28AQ++xkVBXfD/hpnrQwpqi+OZtjQ5?=
 =?us-ascii?Q?YCVA+TaJwOMVpZ91jGXbF3FlTzt2kTSmUePFjW0sNC3nZJzECtAfeOIL/p2T?=
 =?us-ascii?Q?PmD+rYXohoEEaD9CbJnodwsXluGgmVPBOg56h7DtmwiWrTK4b2quJ49ioDNf?=
 =?us-ascii?Q?gevHXxdjUBDEvxWArCQQJma0HwGdKmUMRjROvZgnyY4dtFc58TRNi5BZjkFT?=
 =?us-ascii?Q?Gi1ZWGm48gx0e/NVa3z0wsKKVa5VJ68rG/UP2K1TSjS0OUoZV3Wn0cuO5YOJ?=
 =?us-ascii?Q?tEQe5SzQ7FfFN6eQmZEjE0sGAdzUKoJsCYqhmPbh9Klj8xFYLMIcthUNZbbt?=
 =?us-ascii?Q?NpU8Fj7mjwtC+KdU/qRXRQIdolPtFVYdidX45TiXCPjlKFnxXWN/LOv9Iku+?=
 =?us-ascii?Q?ZEeRnfj1ULqSJS1Ajy+dHIgC9DYBuJKSdGIUbyafNLPTfE5v7zMlkLdyzc0R?=
 =?us-ascii?Q?jB3FE/e5YGLji1JxWV78pPncF9i6sUxaKaM3PimwAvVxO2Qi7JMIrf79eVlx?=
 =?us-ascii?Q?aqbTE2n2iMUKnZLgZEMy3dBK+664byyP8g7gUgMFhyyYxEgc5LgowOeiNeoX?=
 =?us-ascii?Q?+Osx94I+Um0DUhYxST7hqrSPZackv6ayTe7exC0AT48m54cUGsv5vO/7f3hn?=
 =?us-ascii?Q?qOLIffPSMLcaTH1vOg6AvCTyIKESrASfvamD/JcymGPWrjaHDL0Hr2d4zlqk?=
 =?us-ascii?Q?oe0qx4gKFaBfnXWV5VltpxBHhaSXwwuEbylfaHmdHtiMccFdXVkMLVbi0q5b?=
 =?us-ascii?Q?iFA8nthWqy/Lqy9pDiiAjT0kLvwRZ5YOcKSvmg70wSVtA6fBwiqdK/bYznhN?=
 =?us-ascii?Q?D5W/zTu5pXI03Rkb1o949wl1B9JHPLXDVTS9/pNBlaob6Q+09zxvN1FwVfWs?=
 =?us-ascii?Q?NvE8NVANWTRRmOJpAsbGN4H1bAUQwC7AwEZY9NXpOKQivU0Bpt8xRnYHAQ8S?=
 =?us-ascii?Q?7R9B1QGzqlwvj9vxEUmXTofbMa/B9VEu5Z1Cy5tFz5EaJVufT7Cx/VjQhMy+?=
 =?us-ascii?Q?1H62GH9GMObXnnQGbGIkeboGm0Cx74/o7vYV6mG3csxCL1xfDrMOer8wWAuA?=
 =?us-ascii?Q?uXYIZnMD6FMp7z4C5OjQVvjhQxFSj1HXIAChyfwjPTkX2SElBLA/EtFM5scT?=
 =?us-ascii?Q?wMxehPuXJzHE3bS73kIeZ3X2GL7r8NhYvFUvuT4eXFdZ73lDXMXi+s06eohf?=
 =?us-ascii?Q?hsW0WVbKn6VzJZteXmdLl61QpYu3ktCT0rSb+wCQ0l2heT5UIQOt5+VBtcXW?=
 =?us-ascii?Q?XzuMPqLFpF24SV1Rp5m1sWQ9YtL7gjdyQqtwPmqsgItUvDYcyTXrpHCibXdJ?=
 =?us-ascii?Q?0lJ0H1fQDl7vebXncaUNUiLDFp1r6pWeCxQmDXVA3cpKop/NS1wFNs4J08cy?=
 =?us-ascii?Q?JZgkycTDyCqlRPyXCtW8MAN2pwTrZvOoa3Oro6LQe20EUGiXp8HS9YBfkw4c?=
 =?us-ascii?Q?wXHpNngAtzz+YbrOZ45n2fnyjGDmMxNA3VYDoyA3ERmsfQ/D/xBibMcXTaRy?=
 =?us-ascii?Q?hUHvAYRtVk/Btji+6RDT9lLwr2nKWsA/oyMcFzEy3+Rgf3/HYPzKSdIsB+Wh?=
 =?us-ascii?Q?OC4424Z36f1tSQnI6T0vKNPp5zHrfey+StjmMyWGODxtDnJQjkVYN9MYNlI1?=
 =?us-ascii?Q?CxtLUIBFklCZl9SIe++kO+8rTQZAnwK4HDb/rOmH7g4ulesJWRVpzQV+4ljb?=
 =?us-ascii?Q?1qcF6yPuJA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60df1c87-8165-4db6-9d66-08df062202af
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 23:05:25.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13IXyykOofZ1zwnur6t0ftTNiiNYBWAvysb9KPuWOZsIMU2cAP9JPbIcHa/d+lqJP10fPTu08CG4XmH++yESkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWYP123MB9008

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
 include/trace/events/workqueue.h | 39 ++++++++++++++++++++++++++++++++
 kernel/workqueue.c               |  9 ++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index b0de2bc9ed52..ef0f3a4b73a8 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -126,6 +126,45 @@ TRACE_EVENT(workqueue_execute_end,
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
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3c034cbc5bb3..6ee644155b82 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1532,6 +1532,7 @@ void wq_worker_tick(struct task_struct *task)
 	struct worker *worker = kthread_data(task);
 	struct pool_workqueue *pwq = worker->current_pwq;
 	struct worker_pool *pool = worker->pool;
+	u64 dur;
 
 	if (!pwq)
 		return;
@@ -1557,9 +1558,10 @@ void wq_worker_tick(struct task_struct *task)
 	 * double decrements. The task is releasing the CPU anyway. Let's skip.
 	 * We probably want to make this prettier in the future.
 	 */
+	dur = (READ_ONCE(worker->task->se.sum_exec_runtime) - worker->current_at) /
+	      NSEC_PER_USEC;
 	if ((worker->flags & WORKER_NOT_RUNNING) || READ_ONCE(worker->sleeping) ||
-	    READ_ONCE(worker->task->se.sum_exec_runtime) - worker->current_at <
-	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
+	    dur < wq_cpu_intensive_thresh_us)
 		return;
 
 	raw_spin_lock(&pool->lock);
@@ -1572,6 +1574,9 @@ void wq_worker_tick(struct task_struct *task)
 		pwq->stats[PWQ_STAT_CM_WAKEUP]++;
 
 	raw_spin_unlock(&pool->lock);
+
+	trace_workqueue_cpu_intensive(pwq, worker->current_work,
+				      worker->current_func, dur);
 }
 
 /**
-- 
2.55.0

