Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00D437448;
	Sat, 29 Aug 2026 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044732; cv=fail; b=A9Bs9qvgBiZtkiCLLPn9hbKBADCmRmp+hh6eZKZNpNr8MxPklSutph/iulelaaa9DN8PuLivYm+t2jnSNKbJ25WX3f2nnMW09ZVwG/c/lnISLxep5Pub5o3JDUkmsmqbSX0gu90CN3gRGTNTopQhBs0lt8exWnRXOHvJ7JqxDww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044732; c=relaxed/simple;
	bh=zddBvMQBCSVhPaMGDET8Z6JCF8m6G5eMjzXjbDNPRLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ReWwkPdX9mlariqMgYSogEULhll7fkTyESi4qsW/7KPmwnaDH1jb4UDxcR5ZEkOkkvP/M6QmqugXxZoqqK2Zn3Lva5oah24wr0hvPIkI34VjWvO6y6H+vAHM2k5EiirDzNh0mhA1s3u/XvdSx46MtCbms1AUi7LEjgUxHzG3hUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgiNGuiAe5JAZOenoCYpb3+woVIeTFQHNnWzwZxmk8xr68lmBvSEa4sI9NnRihipK5O3nklL/tzQd6bUP8qJctGI6r0CATddowAL8mYr3whwCPyW2Opa53LSaG3v+vtIxhSJO+Q70PrMatYvODbP7OEeH8f9iAVqFuFKJqmpUvLovu1uHCAuv6Q0pQlK9BFHQ7xaKY8fz4A5hE6j3natjYZ0ki9BgL1DhjMhC3GWkECtPjDll2qNEDvmZPO6DP3r/x6DhrKrD3mj5QSiM2/25l4Tc63oL07Nhb6ZnG3sa8UiIYVndewN3qIG+I5WKnIBUqnIBjYKRyIvGU4pXF1tzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=L8xm2tL5NuuQRIsBY4MHChqgqO4ZLhZlZXMQtcUJ424=;
 b=LyUoLC9DFRGQHdKHxcTMIj3SmIlJ/LDfNMpP62lqfv/Z1IJqsAkWxlh+LOrbZGjB7k43Y+w6u0utcFjAP0j5jJvaH6q/Pm3QUUBviNJpp63Xe7agszUHfIIdJ/XhThfzlfl7tzQWMFlWNRV5vE3Igxci8f8iBZAfbULwrwvzL597f5zXnxlfHM5CvFsDAC8eBVGWetaaE531WGTa79whugqxx+F/jHHvi0XR2PtBENrLw6ep3b8kVf5s5/7Wzfbn2sSFDXz1NycViECxbzSuOubop+0qegUImKVU6nsGdWujUl8fm89Xlu2RNa3Q5fBmoAqJEFS+nWIhiQI5NbIuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWYP123MB9008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 29 Aug
 2026 23:05:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 23:05:29 +0000
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
Subject: [PATCH 2/3] workqueue: Add workqueue_mayday and workqueue_rescued tracepoints
Date: Sat, 29 Aug 2026 19:05:16 -0400
Message-ID: <20260829230517.42468-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829230517.42468-1-atomlin@atomlin.com>
References: <20260829230517.42468-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0461.namprd03.prod.outlook.com
 (2603:10b6:408:139::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWYP123MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e98a29-559f-42cd-3575-08df062204d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h2UrXfp6TIgnH/P8a1KnbIA9dMylgpuM+SWnOvh+GeeMDl0iIIl3ZzT9Y2beZs1KP6fF7teLA7HN2oTSxG0doY9zU2etLrlmXW7ZejWyOi0IHdF3CCp3reizF3ESFNfJYIEKbMfaccom68NAXnAX/YT/sVpOv6whNYTdB7orkgb7EmonnQot0iVchLy/rOvnjRTGBkelCEYDcwYdPcJA7Zxh8rtfzNoPFquBW7mZ5dT5ecNvXsVmT9KybdGpcGXHYGlQVV1Tn3mOddL1LEZ3vgYmVxXkKSlFnutcwuVO+AFqPYsR0WR4NEu96OskI6fnO4dq0FF0JYTcgLMdsRdbWGwBj+vsV3s6m36NJJ0JeupPfvQavtrf/PxYmrGK1lnHUwX06+5Y2MrpgSBKCOBo5zWX5FbuMLK1CFRLf9ej5BiFd69RVrGbQ2dG8zB/yFo+n7Qp94gkndGI69EtbwwkZRps5vgL7qoYgG63laj9fcXv/doQmew1Xl2qWKZIVEsuxjqdaLCu3cTjimOCb5fz4K4rIB3u0Ne80VtoiQwMhIhWlClWG+Pa4qyrZ5PW5fkQIB1LBTFYU3UL8AhdKoMa1sURHewiscJgxhhEPiBrunXXTH1iwrChNMWyqhNxKlyepHqIEkM09832CRzGtWYcVaXybhyHUGvxk9wMC1v/LBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VXOnB0yT6xuotdSdEXFPhpXW2dU4ZyLsMd9svUwhF0sbe1fqO44t5c0pZSCY?=
 =?us-ascii?Q?0v/xRU8s1WhaFQMCUZok6GsVvWzuWpiaO0BMyvNTgYzXYKkTrWz8Z5w5yGbH?=
 =?us-ascii?Q?vk0ghH/DCLWtpB7rX9if+KtFmUDdCb6rgPTZzLlINiMjgTYL8eAuBg5940e7?=
 =?us-ascii?Q?kNSkHCj/dbWi6kquQMlVKnu5caky4FSI1rew//UWfoEwjeCVgtfVrwo/oplr?=
 =?us-ascii?Q?I0lxzLxyNBfiJ9nGG/gZpISqdLjlfvO/LMYcgWojqsCM3J5Bl+IxmpQHXn2e?=
 =?us-ascii?Q?DEWGgbRkcpsToxKBvQsI2l1dCWWPN+sPdVxz+oQYJkAdHvkb6ByQmQ5N2sJx?=
 =?us-ascii?Q?AMQyFM/JzTRqeKB09X3TpRQZWK6OQhaC0nLrLJiT8XkbeQXAarB9M8ZJGZal?=
 =?us-ascii?Q?xkLQmMoxSJe0Lg5Ie+F9gQpVJlJCIGezOUwSnlbU16aMdK7nNmhQxUnvjh2h?=
 =?us-ascii?Q?fzaCR2jFns3Q3ahgH3+LL0Iz3KPwbhmTlTTB30YC/kqM/r2D4CuIAXIP5hTt?=
 =?us-ascii?Q?lWQQpRt/IGy6REf2PrgNO03PwM0596hQPjR0qvnt2HOkrvtBAM/lW7+XOT1m?=
 =?us-ascii?Q?W+IMkHW4SYRdBHFb1nIH8guvpnFIeWriBL1+jKyJlq9WcFHPzS7AiqUlKIgR?=
 =?us-ascii?Q?oc+eIBJITZRlXQ12hyjwa9ujPTuE9lc3hp99kWw4OSFJt3UcvXA2ka+7Jbnp?=
 =?us-ascii?Q?BbsKlqp4wTVksaU65vuOOpcN+X3mBeZSqCfOSKdC9HtPeP62J+K41M8O/kPm?=
 =?us-ascii?Q?gt323Qeat1v46nXqZm/6mto5ALIZJjHZQSI9eDgHHhXapnSQOoVnae1hDJ9D?=
 =?us-ascii?Q?DfitlCBsGEZjJ74ROwCWsvbOQ6HrnKy1JKgHU7QEELRgRbfmZPoCheOymGqx?=
 =?us-ascii?Q?TFxDmPIdNCJtbHg8E/5tZUruAnQHTGha6XbhIjYTtmdZLfz68Lt2unW+BUyg?=
 =?us-ascii?Q?qEcSnc76kPlnSOVdmVUleA4SPsfj4O7oLxF+eFt5fosf13n1n6hXhRSmcLO6?=
 =?us-ascii?Q?wgt9pbWFbmRRO+KSrJ6f//z+xiUoiKdr5s9WV9aNXpcbmRZwgrWceE9GJ8Vp?=
 =?us-ascii?Q?c4rNjyA9GnTX0yCcbClglORaO5jVG547R2v2z9llCZHvEIByey7ZW3eZMQaA?=
 =?us-ascii?Q?UeG4gkIb6+iMGMevXZDT8Z9dOjoZR0aRSfZphyS8YACLdlqjpAzAX1UK2EPu?=
 =?us-ascii?Q?+F5uhBDkw/hWCNTRQK/ZPXfF68kwg6julBu9/tYHm73GBpunVJ+r6pWvzTpB?=
 =?us-ascii?Q?OZg8lLh4zej5609QFVIp1O56vpZmEDkpKu0N0hFuZE2+SAUBx5LaXSqNw93A?=
 =?us-ascii?Q?UMaliUxiCJHnIeIIMByFrJzaAsCgHKHu4+hixinisB1OAh75WjSmDIyDYlGp?=
 =?us-ascii?Q?PC+e/fp4GsNRFG13hSu47fkv7OWubDBeNL7/AfAcGf8/FZaORGW/87UW3eQN?=
 =?us-ascii?Q?51SB/NqeP3RuLSfyHzcQ1vOZJbuJSqIrxjZjKC2lBDLMveZ/6AYRyQHj9mUm?=
 =?us-ascii?Q?zxxsyy3A9N5N36i/QiXtCOmxNzJwwtpwFQJhJ0YoAS+CwaR4K0FLW04lG/dQ?=
 =?us-ascii?Q?1+HF8i6a7P2fhZg8X8B8YZtkgFBN2zEYpp5gprw/w9KEZqcZ/jjcZ2+dasv3?=
 =?us-ascii?Q?UnUx+HVrqF7QNTpSz39aRt/d73jctFiLGAz7QMtJc3km4pkCxX47e/Ea4q6U?=
 =?us-ascii?Q?R1OmtMsB8wh7iYKy7NM0DaBnldhEgwvJ6aokoKuljwge6DeJ6QokxbEzrZ+4?=
 =?us-ascii?Q?cPLh6/sHnw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e98a29-559f-42cd-3575-08df062204d4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 23:05:29.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX6byvM+p3kg49RgBJnlJxWWoRkY4IbGH7/1dHUD5Nk/cJRrEGZngf1H+F35c/5V5C6JMuo9BbRcMvwcRuS4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWYP123MB9008

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
index ef0f3a4b73a8..013cfa472f6d 100644
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
index 6ee644155b82..6f6fe2068389 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3122,6 +3122,7 @@ static void send_mayday(struct pool_workqueue *pwq)
 		list_add_tail(&pwq->mayday_node, &wq->maydays);
 		wake_up_process(wq->rescuer->task);
 		pwq->stats[PWQ_STAT_MAYDAY]++;
+		trace_workqueue_mayday(pwq);
 	}
 }
 
@@ -3619,6 +3620,7 @@ static bool assign_rescuer_work(struct pool_workqueue *pwq, struct worker *rescu
 	list_for_each_entry_safe_from(work, n, &pool->worklist, entry) {
 		if (get_work_pwq(work) == pwq && assign_work(work, rescuer, &n)) {
 			pwq->stats[PWQ_STAT_RESCUED]++;
+			trace_workqueue_rescued(pwq, work, work->func);
 			/* put the cursor for next search */
 			list_move_tail(&cursor->entry, &n->entry);
 			return true;
-- 
2.55.0

