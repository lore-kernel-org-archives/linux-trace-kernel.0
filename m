Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021081.outbound.protection.outlook.com [52.101.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0451C353;
	Fri,  4 Sep 2026 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550502; cv=fail; b=mjETqLqcOTRZOaJQJglHpGRNPonbdxeXLrW1KgnE62S5D17aXQesGNkQ8Td4I6STRNFSPnoMXUcjW8NCi7l66J0Kyrj7KkFW66tWWaKmoVprebHk8i5OztwNoGr96Dg/CLa14ZJ+C40XsRxlGH9XBbwIIWiAHxnsk83c4wsOLDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550502; c=relaxed/simple;
	bh=raBDC4fAvLfQd7viColR6L8M9aHxA0PWjt0OQhzfazw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3ALR2MzyRVdYjwBj+qNINeTZKOjht7C1t5izd0W1pQsgfkfH1v2G2QJPwPdBLv20YQB0PT2ZBfX975/Uhe0n8hbEKOzYJdSYVLUgKzDZaFaAws9gmhVv2yUihJzrTfu9cmfLegASyukOeoDcpACTGd3qO/ec9QRs/x5EnPVO6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtiG3LyCWU2zP9TIwj5mIpz7ktp345Z3PgQg2QJP42DnOYYlNsjhsqphJaCTu+VKgPCaSMunCang6bHdYmrCweIvNJyNbNujWpOVqiUXuollcrrMUNoXNlhZjXD5RZeJQW+oLxhUNILF6u8WVs1KYSWbDIvruxQzTYAe8QFdegbxR3238CZtF9xqUP20jf5kWFrWGcasVlA5lDcoQALxKcLZpRE9Y4232LqiZKsv2BNKfx5SX20cxiX5vr8roAFtoCPkfSK0R56+Dw+fnO+OpV7JYIM/arTifJw+/rtrqYjfQlW9Xw5wmLZLcl8HFp3VkNKuXgMERmhyiUwCoFOXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=BF599Z1rQK3wzeLKAgHzYVuUgGJBZ4GOFp4JL/IGj/E=;
 b=EeYcMYfGjiDkPIiVBDjiSisOeij/5840Ca6Ru8bphVXO7sNxmvrQlenldYPpsH3Xll4J0o4nXHR7PTdPYd0Y1yeV/9s3YBCRrNqRxoHvhpTk+7/L/E7qu/u7r/StApOMIoii5GZ8yGhwyMmxdrJ4pPquX9bi46sRBq+Px1J8XARCsRBurF1usi45BP8Dtdju0Czjmw2i4AOEcdsUTxwcemNRjqKNloHexbbItQoA39ps+KkaQSDxkI/EZ/AATrKaU+Acrkq8vgQTGruq1LktIHF4VgWaahXKGafR47/+pMvmGZ7HA4IRIyjyjc+Ubl5/23ue9nUKhgyIAtZnIW/ksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6609.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 19:34:58 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 19:34:58 +0000
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
Subject: [PATCH v2 2/3] workqueue: Add workqueue_mayday and workqueue_rescued tracepoints
Date: Fri,  4 Sep 2026 15:34:46 -0400
Message-ID: <20260904193447.247502-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904193447.247502-1-atomlin@atomlin.com>
References: <20260904193447.247502-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7d3308-d4af-4ba4-6ef1-08df0abb9a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tWLDGu+aM9FolKQaV6Hy6/SWH3OIP2Q3ilH8xD+jeY7FAGZ/0uGuRK3PbxIIIzxb47n+e2nO9RvW/4mv8CDqaRAtRhb5zedZSQi3M99uEe1ryCfHHJSEYg1v3T2gLRNdKQBUnXNd0OvO4WSz8cSs/yg2dFcFct2tyGPqcMGerXbsKRHSz3lUNIKoIOA6Jg6fZbcZq/5kouU6Dg7UgVSLRou1dKZeTzhjV21wlVQDsCLT8DFRRLtP1WwtWRB5CRjNLQ6OMmugGazBc3Di+OLFRbw/EGDtuiKQQsr55tzxK1Sun3kcbvp9DNiP2U2esWkNTIRKj86xqYapfK2FgpuYhxvrIxyJZ1Oie/fJ4FCbWCyTbUh8jCv9FGP7qk46U3AiZnnlsiH9Uyfz0QfL+KMTVwXKMfMlUW8cJMqV0DY7KF2+hPLiaeHy+63QFxudynKR1Bq3GBkhb5XcRUGVK3w1YPhjAdoScZzfokypROHJpgB0Rwj0YDMXgeEiJ8kC+EqPR3fE8TBY2JqMcL9zTp3FbxjRsGZTBi67Y/1o3FKfaGh/fKFtxPduCHfmrv0haQlYKr552giWe2x4afiyNnX/hQ0AEsn6QpR2Nn/A2K+7M+sz+xZJW9tmQxYh4hhXAhigGRBsEt3QGvz7ywLdhVFfkuhV/CVw2VP89bGr/haXn+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9g4nW3Bxfo8cWMtUg02Y35g9Yv4SeUF+lfKcrwNm7qiSZCELUnpRp/6DUjJu?=
 =?us-ascii?Q?mjd44OP+sYZvjkvB/bqTd+Iy01yQ/NbDRze5LY8b9ouhBAhaDsTKdMPpxC26?=
 =?us-ascii?Q?AuwBONpku8mLzJIFDZVhKCOxPEMzXLuS1aHNflCyMWuX5iXaAXUX1I5WFZ06?=
 =?us-ascii?Q?jkIktKFG+xNl0dNLibNYNI7WT/wah6Uhqgf9jYKog+x5i/g2D0+aa11YqfFn?=
 =?us-ascii?Q?Z922KGHlyR5GCbjfm3g1GgQXL+xr3u9JoWDXlZGEaPGGnqtnDt8grCHEA6RQ?=
 =?us-ascii?Q?sBBZY8EFL5GZxq+1DJvnxvsmaH/Ky/jM5MG9aWVm4qTaKC3wQ7OPwibn+wnn?=
 =?us-ascii?Q?jF+Ai2IuTG0MkEZYPry62UB291gNXidbarMbw5eexKs3ow5kAleTaC4wzss/?=
 =?us-ascii?Q?ThbNrGiF0ftl3JXWrsE376x9D/0vjXbCp0OG9b/rQdmI7l+SPaOmDZ1/1ujL?=
 =?us-ascii?Q?y8bxqtl+gMs9M71jJpI8oOxi5NEGf9UhvHMWwack2wD6G4c8FMHYHxAqB1+T?=
 =?us-ascii?Q?0N/iiBybgG33I/+59qzmvgKLdDPdm7eJM9EKTjOhCRmpwnbTni30hcl+44iZ?=
 =?us-ascii?Q?0OrVFUaSb2v1cmbD1mxdR8jd1sivXnA4oxyg58pZJ+9QqifIWupHBHdRDFJc?=
 =?us-ascii?Q?sedMUdZIZveqcmLM4vxHAQs16JbO0723uI4U1kRoLWr7AzDPA4yVvSsWcbJs?=
 =?us-ascii?Q?ufpqu9OcMDASvME3bdC+Bai538p+WujOUj6V8VOFCqxRgalEbzzTjxRj7ZwQ?=
 =?us-ascii?Q?Q8ZwEN6Z6ud8xzMlzPF72QKzqMN6H8QIIe9S60UKTm5OOxeVFvjUBhWmBqDW?=
 =?us-ascii?Q?gvJCVizbopQWKnnYq2EdiCS2hA2r024rfSgooREH8DzCAIJx/f7vq/tcPgip?=
 =?us-ascii?Q?LBvV3ez+PKulTKsaMxnpC/eVaIRR0M2ULRZu02bNPQd9suBsdcUx0N/ZdTkQ?=
 =?us-ascii?Q?npoWBkTqDO6FtO5/GuqqItHiH6eeIfZT5ZsslxSBMzL1MRVbMXkAxDsHa8Ji?=
 =?us-ascii?Q?uRqGTUaBfp5kS6MniCS+IkgiZITXUsf1C/76zwUdkZsQjr2+kA1bPrRPU13N?=
 =?us-ascii?Q?bHrpJtJQqEA4H8XnWLTA1DlY6Nc86uDzybcK3wJgizMv85oAPkk91bbs8/W1?=
 =?us-ascii?Q?i83rwqVpKCw8vAmoC2mE+sNmy0vGc5rB8TIOtSVvf0l0GPNnBnkDJL98BKIc?=
 =?us-ascii?Q?XVotCw3U4VUH8JtHSvvNdIxoX0mKpJnmjs4Im75/XLcOoqzLU9C4WpSTQQ5/?=
 =?us-ascii?Q?iejeqwNBANe1M0v8kiEKXmWA9LgY+/3yHQCiDXa//68zvRt2I2Ugt8p0SwQJ?=
 =?us-ascii?Q?3UBCoMQnVl3yXXba7wwEVbZZAv0Oe2n7yTY3rbF+zUyoY3DCf1LDeSnun5bT?=
 =?us-ascii?Q?VxHrEgmh1IUXwt6lUGCYUsOT728gIKc3SHDzIq7JVqEoG9DvQDb3166jcjEE?=
 =?us-ascii?Q?JDdCNrSn3v4CRVll9SDShiGrvAsBpOHnHEH8H5eiGJAQRMce86TpXYf9PUIP?=
 =?us-ascii?Q?vjqbbVNtueZjJkUBrEXOMtJ0R0wzU/eP8PFChmSKDTKk9GSXzbznpP7gftIS?=
 =?us-ascii?Q?lGmlh9FJ3HUN/JshYypTj8LHDm0tbwCcMDTLblbAKqxXvblG8KHMWgCRtf6C?=
 =?us-ascii?Q?Be041+g4P3IM0weHvSIkKkCFoiOdsF+NWN/jGWD8XmEhprAlQFqwQruhi5LR?=
 =?us-ascii?Q?93hVLqQwxeLBeq8e43xwwb6VhYXTH89LTK1BXFGRk8Nk+oYAR8M3AB8HCj8L?=
 =?us-ascii?Q?CfX/6nLr8g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7d3308-d4af-4ba4-6ef1-08df0abb9a9e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:34:58.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7mL+S5pvBTSA4KiWStLYiOLqyY/Z4nrhB34JXMFMtUlv4g1hdHSRnjyOUZVEPhEDuZh31roGSEv4/wyvThIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6609

When a worker pool fails to create a new worker thread within
MAYDAY_INTERVAL (e.g., typically under severe memory pressure where
memory reclaim paths depend on pending work items), send_mayday()
signals distress to the workqueue's rescuer thread. The rescuer then
takes over processing the pending work items via assign_rescuer_work().

While pwq->stats[PWQ_STAT_MAYDAY] and pwq->stats[PWQ_STAT_RESCUED] track
these occurrences cumulatively, there is currently no event-driven
mechanism to observe exactly when mayday distress occurs or which work
items require rescue.

Add two new tracepoints namely workqueue_mayday and workqueue_rescued to
make distress and rescuer execution easily observable (e.g., via Ftrace
or eBPF).

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/trace/events/workqueue.h | 68 ++++++++++++++++++++++++++++++++
 kernel/workqueue.c               |  2 +
 2 files changed, 70 insertions(+)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index d2ad38f93a83..12ac24586835 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -165,6 +165,74 @@ TRACE_EVENT(workqueue_cpu_intensive,
 		  __entry->cpu, __entry->duration_us)
 );
 
+/**
+ * workqueue_mayday - called when a pool_workqueue sends mayday to rescuer
+ * @pwq:	pointer to struct pool_workqueue
+ *
+ * This event occurs when a worker pool fails to create a new worker
+ * within MAYDAY_INTERVAL and requests the workqueue's rescuer thread to
+ * process pending works.
+ */
+TRACE_EVENT(workqueue_mayday,
+
+	TP_PROTO(struct pool_workqueue *pwq),
+
+	TP_ARGS(pwq),
+
+	TP_STRUCT__entry(
+		__string( workqueue,	pwq->wq->name	)
+		__field( int,		pool_id		)
+		__field( int,		cpu		)
+		__field( int,		nr_active	)
+	),
+
+	TP_fast_assign(
+		__assign_str(workqueue);
+		__entry->pool_id	= pwq->pool->id;
+		__entry->cpu		= pwq->pool->cpu;
+		__entry->nr_active	= pwq->nr_active;
+	),
+
+	TP_printk("workqueue=%s pool_id=%d cpu=%d nr_active=%d",
+		  __get_str(workqueue), __entry->pool_id, __entry->cpu,
+		  __entry->nr_active)
+);
+
+/**
+ * workqueue_rescued - called when a work item is assigned to a rescuer
+ * @pwq:	pointer to struct pool_workqueue
+ * @work:	pointer to struct work_struct
+ * @function:	pointer to worker function
+ *
+ * This event occurs when a work item is claimed by a rescuer thread
+ * to guarantee forward progress.
+ */
+TRACE_EVENT(workqueue_rescued,
+
+	TP_PROTO(struct pool_workqueue *pwq, struct work_struct *work,
+		 work_func_t function),
+
+	TP_ARGS(pwq, work, function),
+
+	TP_STRUCT__entry(
+		__field( void *,	work		)
+		__field( void *,	function	)
+		__string( workqueue,	pwq->wq->name	)
+		__field( int,		cpu		)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= function;
+		__assign_str(workqueue);
+		__entry->cpu		= pwq->pool->cpu;
+	),
+
+	TP_printk("work struct=%p function=%ps workqueue=%s cpu=%d",
+		  __entry->work, __entry->function, __get_str(workqueue),
+		  __entry->cpu)
+);
+
 #endif /*  _TRACE_WORKQUEUE_H */
 
 /* This part must be outside protection */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bad1217cf45a..ab1371ed890a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3124,6 +3124,7 @@ static void send_mayday(struct pool_workqueue *pwq)
 		list_add_tail(&pwq->mayday_node, &wq->maydays);
 		wake_up_process(wq->rescuer->task);
 		pwq->stats[PWQ_STAT_MAYDAY]++;
+		trace_workqueue_mayday(pwq);
 	}
 }
 
@@ -3621,6 +3622,7 @@ static bool assign_rescuer_work(struct pool_workqueue *pwq, struct worker *rescu
 	list_for_each_entry_safe_from(work, n, &pool->worklist, entry) {
 		if (get_work_pwq(work) == pwq && assign_work(work, rescuer, &n)) {
 			pwq->stats[PWQ_STAT_RESCUED]++;
+			trace_workqueue_rescued(pwq, work, work->func);
 			/* put the cursor for next search */
 			list_move_tail(&cursor->entry, &n->entry);
 			return true;
-- 
2.55.0

