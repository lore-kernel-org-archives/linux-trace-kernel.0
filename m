Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021084.outbound.protection.outlook.com [52.101.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38C51FCBA;
	Fri,  4 Sep 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550510; cv=fail; b=uUyg0dmmjJ7kMOGjYY52CusJ9WywxBIaodn25G6ALilgOKhhtB+9kXesZ2sg5Om8Hu7SqXicUoq2Qm4Njpw853RW66Y0qsdpzp/ImEWOcnrHH3wz4s1dDEDoLGN+XmT315zqdOkrmnCnL5adnNFU+AaFcvK/FDeOZBXfH6hHsvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550510; c=relaxed/simple;
	bh=NZDHVeBSPRybjgQmtY5tIpgdLRzp+gdGI/6g9SyNHf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4pFIcLGahkVb1I0JWiqC79wvx0uqblXa/NMJeHPoL9iV/d22OwDp47A65Ih3ZtSmdCVS82zA18/i9ThQJw0XHNJuGVSCQZptp0vQ/X9Trhbmct53L999Hnfsn8HhIsJQepNLfT/TobnUeWZHxtn8BgQZrlp8FjSbFFe7odHBsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2h7ZMS8OEC3ZGIee9hduLTHlgOAkU6AcphrmACaPzcU4a6i79CcWR1tLp49wZJKERPnFnltuw6GHgbwnaCVF4AETG5fbgdQEQhOwPJxcYUxuOQyrRLKDfLJjaMuu7OLqVaU5f27+OxlHxPQjm6B1MwpA+QhoPszoCq2qZJutMSZ+XD0PmQ2OCa30ddlhi/jZkYy7H47WhHn8NexCwsNIlc//+LvUNXnpvG560wpHSu0r81REFIIdG1A4aRB3HAyBCDHGTiALOA2q7z9LDs802xYok9tejb5CkuXkwCcYWMA9luFiBj9n4SXPKkEHzkz9fkK+zNqfAxjN4i+5CECxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=3o9PM5krr9MAsC88OgEw5jx6eebyOcujwR5q54QHquE=;
 b=dpXKoWqXXVOrwgvEMw4RqbZl5ni91QiWnQteO0Zm1dVo6wk+3Blx0v0A5qt13zZ3eiyggoSAKGwd9UxXT2eBeEinnNzYCj8lTaxvmg8kTvEnQBzh9QrvwAZjU9Pq5O95Che9ONV1DJg3XcZpVjxqoQ28vUqhvnKbWruQhjHnSVdAqMDOcw2oxO8vfpGvsMhgpW3UYJFGlerQjiW8/jG6lgSDkNvDSe7QDPH9LHvEgiMizKVLssz76i7Eh26QQkyDWsg0VGhH8dAkmou3sV9sB4sWxfZo6auV0gNFy0B/xryVyak3MIg6RBxgyqiSu9gBHm6JJMIX3zbx7D2zHtXmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6609.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 19:35:03 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 19:35:01 +0000
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
Subject: [PATCH v2 3/3] workqueue: Add workqueue_bh_budget_yield tracepoint
Date: Fri,  4 Sep 2026 15:34:47 -0400
Message-ID: <20260904193447.247502-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904193447.247502-1-atomlin@atomlin.com>
References: <20260904193447.247502-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0048.namprd20.prod.outlook.com
 (2603:10b6:208:235::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 48306d6c-3182-44af-dfe9-08df0abb9cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fGgQPuQRuDMdm3np+L3ZWZ0VeAEl6/U7hHTm/L+NtxpfVo/H7txOcTaTUXVb4Ijxqk3jHBvIQVYePfLL2QUOsE37JwYD+M99RDQUC6qEo0oUnrHCIg8z2Y5UTzogrK+2JB4rttKDa/vOsb3PhbSGmuPGpDRPbyAgssyQjZa+HFSCQSzBvxX8FSBzcaFfJ/BX5Dsryu+306S6mdH2WmWvW+qL6R3HNRSqakXBvS/HE5lm4kn0vda9VDL8tyXeYyVKKjyulqilMAP3IAXMHaGudDJMssko4fawiGkhsftIxIZAZQk426dFTqpKhn8gO2ywB+k+RGPagi40t2FObb/jYOwqCun6s4agP5mAek2a2WxWP1cQMVcryFyXFtbVzOE/EO9bRn34qWh+CTY5xxpT+oBsAC7nKZgRXR6t4ZwFGAnaHsR/SS+sIOEp0bXbFi6Q6+Dl7AfsZLTJB5UAjiJJ6533fxievdlR2pu91qQQrIdsqkXqoXoFuHllbvPFjz21xAQ29FUag/8Z5AfBxNKhD83B0jhtjeWE5uHqJWKAwSgKsb6QUx7Uz96fc1zMhJ1xCjILFAlAoUuBPBvHBIMOhaWg9c15xLpkZ4VCikySFjZ16LuwE2zGqCK505AX0nK+1YZlN+ZFdHyiCoh3BK68sN4WiVsAxSCF7cZXgBS27VU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BaCQCwnIQhhZQwkkIEGK3PPjkf+0glz/PyeCq9OrFnGrsA87Yp/UzhqQDLHz?=
 =?us-ascii?Q?+3oetHL99+cDedHobnsfzFs7ZH4+cpmPRlACF8GYrFN7j1FN0xyO0IyEIxbf?=
 =?us-ascii?Q?mRFWfgwsY0SbkXvZbTjYYZoSA1n16QebWsFH2RVgyYlgZNa0cBLOuunusKWq?=
 =?us-ascii?Q?zaSBHkvIBpIy+SfZFgIxlRHAxoZseTHVYuR+fIUoSkZXm4F8wfVICK7gY4MH?=
 =?us-ascii?Q?4wYcS9MSne3zk+irLXzhjnsVHTck48h0yGIcJwocZkLIlgMP0VU450hRHxfO?=
 =?us-ascii?Q?lvdZiqdCGaMl/Eekj1fXMIYB6br/VuNRce7PDWbHqy1V6pfXPXbGSIdfdFgj?=
 =?us-ascii?Q?BnCGEcJ/WeC6V4m+0SxBhff4Bg5cKw9n0SSFGfp3IE1efu4+O0LwtPSqlS+D?=
 =?us-ascii?Q?gZM43asw5CPM/eIFqjt9nP7rWvWAvYr2gQgS/yvXijavHaiuVoBiqOv4fx9X?=
 =?us-ascii?Q?gu+RcBTtbXcqQParD888RzgT2QyUhNvdIvlb2HRdtn6zdhQv3m/aXHQsw4Qs?=
 =?us-ascii?Q?r3JLXzwEtl0RR42ckr+UcC0++WFq+CMACsfcN5WcbdSQXIqlIwvmVGaiJVXM?=
 =?us-ascii?Q?g8MHWX1isKtR3LLRLBNFojoGg1rl/M/tpB6hxyZDlHs2GI/6PiqZBPHBiMWy?=
 =?us-ascii?Q?r1Kj6CnReO47lLoaq8MYQmj4JmDjhV12CqIvpOYijG38a0fFmr3UqZ8au7F7?=
 =?us-ascii?Q?5O20EK6PylJl6yZisdKQmJCURPMuKX7cw6eFzPOnNcqKIbgus4d5rNMd9HJX?=
 =?us-ascii?Q?bnF/V3sRNkgLWc70d+xSfWaYeQXVwv5KHrPqi6MhF+xh43MFL4W90c9GazS0?=
 =?us-ascii?Q?WE1hASEqY42u8oZIfyWCGi2Uman3awcMCovT4aIYbPf7V22gQHdbzkjG6uAo?=
 =?us-ascii?Q?H30OIvrdwHBMK4/9qx74aruCGpJje32UP13vkU/fqeKhTp8n3Pv4q4q2gADa?=
 =?us-ascii?Q?oxlTt7QOkQrf67lcNq0NEx+0NIM+nY9CqCinoxSRTqe0qCgLFupWSxx199Z3?=
 =?us-ascii?Q?ILjeweosVzCZurDF49aL/uo63LyDVd2mtWzGfN69oNmN+LgM6md2ZPWJo2AE?=
 =?us-ascii?Q?Bm2TXCxEMgo96E75h+hhm7gP4cZnTTiwgH1O40lZXuaqZxaFOm+zo4M0lJ4c?=
 =?us-ascii?Q?PJzdmDupvFb3/64q8VZGTJhtzwoEuMgS4hbwwhRqB7OB4uAyyEuVjN3ugKjt?=
 =?us-ascii?Q?syRz0Hxs/q0KzWzxK4DH1TiSVAmSJWbZC0FsOAHr9mLYEacNqLITbuWw06Kn?=
 =?us-ascii?Q?rGMTHbNOqSjj1zz+TwEWmBIPfWV++ptuTIsjCl0GY4Cku6d8r3YKfaD2nsCR?=
 =?us-ascii?Q?k7N0cOmzMQWe1OzkpmM+UcGSgFXAJujQbNEfZqnUqTJ0UcPVYgFozbOs1yo/?=
 =?us-ascii?Q?KksYla8CWD7fbVL3A/CimphNXVsGo9RQxNZ3MGMwoamtGgiBre5HxEiqIQ6U?=
 =?us-ascii?Q?ZR1b61q17v81jSExpSSrsdUJ90H1F39hDAdQwhPKNiVVPrjjtDSghzopdWng?=
 =?us-ascii?Q?jjbf7oi83GDXcWtxFyH8/mmlK2P53pR/oqOwdxhGhxvCEkBpLRKt7RVVKm5Z?=
 =?us-ascii?Q?wSHSMLkwfIWHNc7XyoT/r6Hqxb9/yKn3rvVbG98Y44eUQmRgqWIqL9zTgohs?=
 =?us-ascii?Q?BikugUBtZxLHjNH5VWCyPAissuYKvEGXdvEK4DH2FlfUOJr9VpmlxmHKTU5U?=
 =?us-ascii?Q?/tcDQuWO3f4nFy/B+4FXu1nzlnDNh6j9huwBwoq86x5H3WBDOdmZOlk9jxmI?=
 =?us-ascii?Q?wp05XZtqMw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48306d6c-3182-44af-dfe9-08df0abb9cba
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:35:01.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3++nms1h8QHIDnUjVEA2rcSztP7zKKryf85p1aXz8A6kNfMQA97kctN2J719kDoYQvEB7l45rtKSuDwLnx2LjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6609

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
 kernel/workqueue.c               | 26 +++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 12ac24586835..bbba34e40470 100644
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
index ab1371ed890a..74f595396227 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3758,6 +3758,9 @@ static void bh_worker(struct worker *worker)
 	struct worker_pool *pool = worker->pool;
 	int nr_restarts = BH_WORKER_RESTARTS;
 	unsigned long end = jiffies + BH_WORKER_JIFFIES;
+	bool budget_exhausted = false;
+	bool timeout = false;
+	int restarts = 0;
 
 	worker_lock_callback(pool);
 	raw_spin_lock_irq(&pool->lock);
@@ -3780,8 +3783,23 @@ static void bh_worker(struct worker *worker)
 
 		if (assign_work(work, worker, NULL))
 			process_scheduled_works(worker);
-	} while (keep_working(pool) &&
-		 --nr_restarts && time_before(jiffies, end));
+
+		if (!keep_working(pool))
+			break;
+
+		if (!--nr_restarts) {
+			budget_exhausted = true;
+			break;
+		}
+
+		if (!time_before(jiffies, end)) {
+			budget_exhausted = true;
+			timeout = true;
+			break;
+		}
+
+		restarts++;
+	} while (1);
 
 	worker_set_flags(worker, WORKER_PREP);
 done:
@@ -3789,6 +3807,10 @@ static void bh_worker(struct worker *worker)
 	kick_pool(pool);
 	raw_spin_unlock_irq(&pool->lock);
 	worker_unlock_callback(pool);
+
+	if (budget_exhausted)
+		trace_workqueue_bh_budget_yield(pool, restarts, timeout,
+						pool->attrs->nice == HIGHPRI_NICE_LEVEL);
 }
 
 /*
-- 
2.55.0

