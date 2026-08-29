Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64B418368;
	Sat, 29 Aug 2026 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044736; cv=fail; b=rpfybyRmkr2ubgrmCq1ZrHNnMYN+mh8NHyPWBgdv9g27m6y/DfajS3jGT0BVd9jpcbgaIiscGaVbc9HQDr3voI4opivFMqAJd+HsUjvheNHR0vUPWx+KZe1c/z69S5+Yz6g3qe4BqvkMTe9CtlkR+MiyOw1uKp/0RJySX1qCUjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044736; c=relaxed/simple;
	bh=NaPyIlHx8ghcGwJtZOAq6uPO6PcQVLGOEkVa48QNvoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qtZoAe4OrZ7doTmZYknrHnByjjJdnHUjCx9mHd+ddo4AZpJvNPeRMgB2/PwmiNJEGcXG+Ul5jqMeu933trhb8TF2354mOT5loGwRWtdiV/5XYIGSBw+TdACB1OBC+n/1vIVXhQWPbXaJ/AAerSn0FnP0jWIfBsgrpmRyilZ8lmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Yz8JaYnMTXHeElTALvZFEda9CD41/oVQHgChRh1yVqpHo876CrUcF71FH2H9+HJkDJF49suapLP2963on/Irk//u9rzbCybx/5p6lpiSP+klo+/z/yyX4IFHys5iElgRCo2s187hic42n/wBA738OHeNQti52HIZwhZAKh0H27xWGU8u7U6d0TsK28h8kNs+vIUxLQJGyAziwbEvm4L2oULxjwnAAZU4dL5UN+TuWdJHxVh2incCDgo5oNGrsqzBb8ziOOS6IwICAr+4WrmLErokX5uTheAYsoKE58mCdOSQuumK5kF1qh6AJIwcx4vOIy8Lx1rPmCmiQLqQwwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=PuAZnavNyxaJG6TXExzJNZfyM2o8Afuwwsk1CGR47rs=;
 b=Y5qqGaremD7QgtDeA0DVtdzlu5ZPVSGcb97la9o/xNtzW6w/1k4DVkCZvgWGrFGqAiXyTlBfnLcFYYzYlwtOZrbltDuaqKmsGW/cEh3ovdBTf0r6qS8Sv5CyV++pVOlk7mQDUV2Z1bsSjn9bGRu/R7OJK90Mlp4PPxl0oLfxy2uncEN6XkSHAnhkkozpc84GFFeECVfAkTRJKFeDigks8bIXOj8XRA+sPccG0YhzqsONgGjRxrNiNxRrT0OSZNgXlSiPGth5x1JgtDd8pnJ3O/RzO5CTkParqUpZZUOTOaEXCTVNpSZV/KM68xTTVaYYadz6am7oD7TWYipY1lKPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWYP123MB9008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 29 Aug
 2026 23:05:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 23:05:32 +0000
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
Subject: [PATCH 3/3] workqueue: Add workqueue_bh_budget_yield tracepoint
Date: Sat, 29 Aug 2026 19:05:17 -0400
Message-ID: <20260829230517.42468-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829230517.42468-1-atomlin@atomlin.com>
References: <20260829230517.42468-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:408:141::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWYP123MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 8251c154-a7c6-45bb-a925-08df062206a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cZj0lL9VUhsrnG0tZU91LOkaau0Dh9758HHJSKOEB1UUSNIrj35QmX58A3sZ9uQN5FP8pbxtjdeQ5dHTNxYfivpwv547KWedipRQIukYokZmHT0e0WmO+2Myr2MqmhO3iI3FrghwauRRuqgzTv7WLIdbNb6IdwSIhTjVDu4O+NtHJ9k/FcT4zELiaeHEouOJC/9RFmhiM3ng1IkYB2FDApnJwPSEtsEzh9uwwoDCHFs3wK+dQQmich9degeMF1FJpw2AlzjtNrn6CgJ993DR2b7VJbl0Uhl84mTks2+3oHkmU7boWxVkPSn+YGKzr4tDv2V74uunoXqToyhgqc0HVBZv9ffOPt/DHgVKzck1wzqGC5jHocccobJI8jLbYSfTQst9DP9RIMRWELpWrDkfaQ5EUsNpNWCURGb+vGz/qMd/UG+5bpQM90H+9IXfv1QENRF/bUFy8RqteNtANExnSDOWsk7A08kp4OeWqMRSsk2Cu8UYjR9Bsk3qDKhbj8wkak31dZ3tcyINl3vofmjFzU6eFL4f6dJ02WXYQ6jg8fvsSi+uX9cExmVZbj4Ml+c7hCGGNh1CyYeOOgSFRfd1L5TyJ1Y0HsxG4q/49i+Pso8vkbKwqoUGawot090aa0sQRhABNQ7Bzipc6upzXjaPRFasbuQAoXyj9x4Ghb25HJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0prC23BrIWvVumgXOnJvtbQ3vK8YSJrWiuj+mZtpAT5gad1IYbR8wd+9GlnE?=
 =?us-ascii?Q?h8IcX8Avgvoam64PxDjwt00GCIEo5rIVLUscvckLmbNkXhOAEMFdE/ch9hM+?=
 =?us-ascii?Q?6Jx+9ewrDbsiJFkBRVL8hJvp///KSMI702nVLg1pGU49A+pnvT5dKumLKG+z?=
 =?us-ascii?Q?7ZC+GrzB1l952BZhRJIVHU1YJPUP88BNfRhsqukLjOMWNntbWIhJZJwCzuH8?=
 =?us-ascii?Q?tm4n8OP2u0ouslPaJaXHMrtQBGN3tqBDw1h+d3AgBAd3gU9muBLeQ1F6otjb?=
 =?us-ascii?Q?9+LtQuUCeT7qBUogUy8mSf4P7VxHDQIvnhAKJ3LZNpgd+TnHqxbG2xRhahvH?=
 =?us-ascii?Q?mNEBpb8ERogNXdu9KQUrxsEcsRf3/6wqHKbTxfzzCLfyCYmK3WstWtVVwpQW?=
 =?us-ascii?Q?x+w260NviUkr0wOrKdQc+WO8PSUuSCZLh+fkHE7Efbd67JiEo7A5GLrp+8Ej?=
 =?us-ascii?Q?IJjzOx0XNgqivOzjTUvVwsLKwqUTJCy+AhCtCpZsOxYJjFjQFONG42GKKyX4?=
 =?us-ascii?Q?U47OULG0T/FwSOe/f1ZGEYlnlb4rfXkHJDoxdo3muRH+XZEB7nU5eCTv4z5u?=
 =?us-ascii?Q?k7x4wPONxHYJxZB3V5nSOyNZHmSCT/4lPfrVsm0/hnEh7VQgcQjeiMrLOx4j?=
 =?us-ascii?Q?zyWtdTltO8zpX7a3wqISPgBX6J11EByNJrGUj9E1eEjGSHqtN3PxO6h33yLb?=
 =?us-ascii?Q?oNwM/pNSkEBsNBCXfOsY6EET7xgafVXam9nWQiP/nlwzceaAz4eZ2JQFSseG?=
 =?us-ascii?Q?XMKoziIX6JmWGj3Yk684ZL6Y80LCA+IaiuO8X3v2NlYiMkHw58m1m4cbF9ex?=
 =?us-ascii?Q?AdKap7oBjjGh0RteOJU7CBI4oc0vSuusy3I0Is2SQbFuw/r5diBrV5V38CtA?=
 =?us-ascii?Q?oBU0wHHOieRTPiFz6wexkDptr3QjAw6GlGaeqRkxM5oKkIsQfnZMQ1us/DZe?=
 =?us-ascii?Q?kHbizXTJW/DNVfo+TKPOqnSiz3KGrd34mrJdoxmLjt1aFAklMU+7rISqL9rj?=
 =?us-ascii?Q?AjDlefSUOeNDwF9gYbv5352LR2gPLWaEJSv0DZymfwvpKtVjwRRiVLlXQnVl?=
 =?us-ascii?Q?J3PBBysQkNjANQ7N7f296pJanmDqwgz+t943yhlcjAJE5RKbf4NmJxttEa0e?=
 =?us-ascii?Q?2iWWFWjCmks6EdM9uufQXmf8/jnZD+QPGphJPqY6p7eYyoYhF01iJDM2uj1T?=
 =?us-ascii?Q?vd6aBDDc4rcJx9+Bbj8ldL/0Bx/MymbklckbbPoyVUfwEaa1bVDf7nEvtwQ1?=
 =?us-ascii?Q?7aBZCyHUXyN22Ba6wtsENHDZg3NaFqn4oHjqD728Lh0g/ZVcwEkrrFeiXlx1?=
 =?us-ascii?Q?6Oxi5G9KOJHFsvQwvoG8h3nj7+HWMpupznaw+W7/VXm0k00ahpLQupcUgmu2?=
 =?us-ascii?Q?+yY4jcbwqJTYHwf1HTRkhCIn02sHLz0Ka3jwHfcwonkLQN2JWJmIHn1HVeaK?=
 =?us-ascii?Q?5HAdwfXhaRV/aLILXX/ebBPWw5AwfJKNE9DJ7pKpk8JHD7urys8E4xUcoRgs?=
 =?us-ascii?Q?BcCv577j/EHKFm0vNF5IvhVv1YCVduSZaFQK+p7gfNrJtsDGBrdgm71N3eVh?=
 =?us-ascii?Q?3UL/rGkdYMIbCqgTQhnuZFh5FMR3skZCPTpuCh95JX3c17d3teRKU5Nu9re7?=
 =?us-ascii?Q?Vt6jIxKWF7jPFgQu+gvLcUqDviXCgSyBZohdWEBag5DTmh1r84V2u2gGhExp?=
 =?us-ascii?Q?T8A5BHcRedklSkuK2nMRI7OCVVPjNNBkGm5XmjqfpkoZ2LtEoNXJKNtx7NWc?=
 =?us-ascii?Q?5TLy6IHiag=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8251c154-a7c6-45bb-a925-08df062206a9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 23:05:32.3047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b21xi/5/CgUq6mqQh3Offt/s/LN/E77bHD//TTJNHW/KTshEeN3z9dajdIYrc0y/9p0hwy7BUv2QXr7vrw9Z/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWYP123MB9008

Bottom-Half (BH) workqueues execute work items in softirq context.
To prevent softirqs from starving user and kernel threads, bh_worker()
enforces execution limits (i.e., BH_WORKER_JIFFIES and BH_WORKER_RESTARTS).

When keep_working() is still true but either the time slice or restart
count is exhausted, bh_worker() yields execution and re-raises the
softirq via kick_bh_pool().

Currently, there is no observability into when a BH worker hits these
limits and is forced to yield.

Add the workqueue_bh_budget_yield tracepoint, emitted when bh_worker()
exits the processing loop with pending work items remaining. It records,
the worker pool ID, executing CPU, number of loop restarts consumed, a
boolean flag indicating whether the yield was due to a time slice
timeout, and a boolean flag indicating whether this is a high-priority
BH pool.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/trace/events/workqueue.h | 39 ++++++++++++++++++++++++++++++++
 kernel/workqueue.c               | 13 +++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 013cfa472f6d..ad1d0ff1a96d 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -9,6 +9,7 @@
 #include <linux/workqueue.h>
 
 struct pool_workqueue;
+struct worker_pool;
 
 /**
  * workqueue_queue_work - called when a work gets queued
@@ -233,6 +234,44 @@ TRACE_EVENT(workqueue_rescued,
 		  __entry->cpu)
 );
 
+/**
+ * workqueue_bh_budget_yield - called when a BH worker yields due to budget exhaustion
+ * @pool:	pointer to struct worker_pool
+ * @restarts:	number of restarts executed
+ * @timeout:	whether execution hit the time limit (BH_WORKER_JIFFIES)
+ * @highpri:	whether this is a high-priority BH pool
+ *
+ * This event occurs when a bottom-half (BH) worker pool running in softirq
+ * context exhausts its execution time slice or restart limit and must yield
+ * execution.
+ */
+TRACE_EVENT(workqueue_bh_budget_yield,
+
+	TP_PROTO(struct worker_pool *pool, int restarts, bool timeout, bool highpri),
+
+	TP_ARGS(pool, restarts, timeout, highpri),
+
+	TP_STRUCT__entry(
+		__field( int,	pool_id		)
+		__field( int,	cpu		)
+		__field( int,	restarts	)
+		__field( bool,	timeout		)
+		__field( bool,	highpri		)
+	),
+
+	TP_fast_assign(
+		__entry->pool_id	= pool->id;
+		__entry->cpu		= pool->cpu;
+		__entry->restarts	= restarts;
+		__entry->timeout	= timeout;
+		__entry->highpri	= highpri;
+	),
+
+	TP_printk("pool_id=%d cpu=%d restarts=%d timeout=%d highpri=%d",
+		  __entry->pool_id, __entry->cpu, __entry->restarts,
+		  __entry->timeout, __entry->highpri)
+);
+
 #endif /*  _TRACE_WORKQUEUE_H */
 
 /* This part must be outside protection */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6f6fe2068389..1c25df68f7ae 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3756,6 +3756,9 @@ static void bh_worker(struct worker *worker)
 	struct worker_pool *pool = worker->pool;
 	int nr_restarts = BH_WORKER_RESTARTS;
 	unsigned long end = jiffies + BH_WORKER_JIFFIES;
+	bool budget_exhausted = false;
+	bool timeout = false;
+	int executed_restarts = 0;
 
 	worker_lock_callback(pool);
 	raw_spin_lock_irq(&pool->lock);
@@ -3781,12 +3784,22 @@ static void bh_worker(struct worker *worker)
 	} while (keep_working(pool) &&
 		 --nr_restarts && time_before(jiffies, end));
 
+	if (keep_working(pool)) {
+		budget_exhausted = true;
+		timeout = !time_before(jiffies, end);
+		executed_restarts = BH_WORKER_RESTARTS - nr_restarts;
+	}
+
 	worker_set_flags(worker, WORKER_PREP);
 done:
 	worker_enter_idle(worker);
 	kick_pool(pool);
 	raw_spin_unlock_irq(&pool->lock);
 	worker_unlock_callback(pool);
+
+	if (budget_exhausted)
+		trace_workqueue_bh_budget_yield(pool, executed_restarts, timeout,
+						pool->attrs->nice == HIGHPRI_NICE_LEVEL);
 }
 
 /*
-- 
2.55.0

