Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687B13EFF3;
	Fri,  1 Aug 2025 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019741; cv=fail; b=bmkkf1mWx8263CfjqQffEE8nDWT1NY7D0ANbogwHaUtHDlYPQQPnnOnoAJ5QPb171RhpQIN6R5au7rfB/fuB6mhzbv0940RK3+Lb4lTSGYIUdIf4RryiyIf/CB8cg8qgYWWX3eYo0AvJs0rJb0vZGBPJ5FrPzetSZasPK4bVwjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019741; c=relaxed/simple;
	bh=f9Z/xo9EXvgwyJRgegg6By92TmGAMJB/JRb8eOAjZGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dezpe7WqZ4OqwqoFwGwDAr6Qt3aEApZv73DdkLf3Aae/7FRf/ZSicu+pFmu3S4C+gNlYtAa2vl0Hht9IU7FDbrnw9yUnaaSrjXw8Iy519QM34arR/ONASMHYcFJ04bnzVzwk/LrlvsesOaN2yocb1h5WuShDAwiC+F53cdcf/G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lqYJ9eeM; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lqYJ9eeM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaWkSZVLfJ+2a2homezGgmn8HkhdgW0CRFK23zuYzGOX3UiSjgERLjiaBQk3yTEwZbZu3Fd9tx0/uikCJE5jlFH/CDZtwGr1XEthgj/ipVPZ+wfHUsNvdS0kpHlOkK1xD0+dhgOJsUKn8KUBV8vAWTbaM5/vQ0Sgnr2FQyDrSWGg7Q1vqyX5wrJfzQ0BaCstX9sTZl76adL6KSQZj+/G769yBWPNisZV6bjT61zg7w0jB/+xWbfnRfamH7hYCu2jjp/cxcts0Uww2w4j9fEPPA94dm6TEHT8UpayruUBCDla4Vj2fcrFYE7axv5+vMAThpcYD2BpmupR/yq2wYdYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVxp4j9rDIBI+iJ33ja5Elpc83uXAkmUJM379TzJ+Ys=;
 b=X0eiHXkXXSGreImHWZP/b4SK8ZQT7SvbAvyueMiGMUAcDsOEnkygfyFtdl7JnVOShlmnlb9eDEr+Gp0FGzSM3Oq+gav4Ax5FyKEHY45TafTnwLLb0jAAdet6M8zb7Tg6NO56vErUM3LD+tgCWIMia060P18v9RrwcDq8scnQr5gpdIY6EnSkhEmr8BDi1MXgWx+HNGX6CJEHOSoV0AuLOkRNYhpFC8BsE8GGOXndsv5ADgfrWCO1MGNxPAiQYU093jEluI1DsHHIZDmMvBlljTzS28OmNzLF099rbJDK0afMXTly2+YsxiajNGDRMfJooiVInGfsgUR8w8LHAAe6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVxp4j9rDIBI+iJ33ja5Elpc83uXAkmUJM379TzJ+Ys=;
 b=lqYJ9eeMl9v6ctv/hejm0B2vi+ZCisJOKHdAFiiiZruHBwsqKUFMslFfwjyddbAfnCIxii5ZWwXh+8JspK9ED1NnrPc0W6EaAnniLSDIhF4uzyvSq6F48IGRw2KrUkrud7MTg+KecLazEnFjIkwcX0Fof89RV/jmWaQ6YjjysXY=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.12; Fri, 1 Aug 2025 03:42:14 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::3a) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 03:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 03:42:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 22:42:13 -0500
Received: from [10.85.43.78] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 31 Jul 2025 22:42:09 -0500
Message-ID: <179674c6-f82a-4718-ace2-67b5e672fdee@amd.com>
Date: Fri, 1 Aug 2025 09:12:08 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
To: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <cover.1753879295.git.namcao@linutronix.de>
 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
 <20250730151818.7RemAREO@linutronix.de>
 <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>
 <20250731073520.ktIOaGts@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250731073520.ktIOaGts@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: f83e9f07-f28f-4fea-36fd-08ddd0ad677f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFRndURiTVMrODlzZEdOdVpJMEZyazZoaDlTR2NZUEhxd09wTHV1Y3BOQkhO?=
 =?utf-8?B?VFgrWm1OMlZDRFBxK1FlaEFNVk82WVRRUkFjOVNmSUNFeDBBank2MGIvc3RM?=
 =?utf-8?B?bkdWZEh2bUllTnZHaVBpUVNoQkhMaWJMNXdhaUNCT2o3YktDVWx0MlI0Y1BM?=
 =?utf-8?B?bWhCaHNKdTM4L1FTNVFjdHpYQnFiNnhBVUQyV25Way9zMWgvZ3ZUcFdQVFRY?=
 =?utf-8?B?bFJjbHFaOEJZZ2JTNVlacGxsb0dZbldCNythdG5oNnJaT0ZDY1JLeUtVcDV1?=
 =?utf-8?B?Q2NxWm9GSFA5TFo1eHJZNTByYUI4WS96R2lQS1gwUHY5T0hCUldVNVBONmZq?=
 =?utf-8?B?VER6L3Vua1VsTHZSSk51WUtQRGpKN01QM1kxRUlodmVNOVZkeDNEUDJPNm56?=
 =?utf-8?B?b21IMkVOTUtSZUZJOEJuSll5M3hyc2FjNE5RcFBnTjBTNHhzcGFuUmRPTHNC?=
 =?utf-8?B?WllEazlrVkVTczA4SW4vMEs5dFAwa1FFVU5aeEU5TlN1dlFWQWN0b0RLTFQ1?=
 =?utf-8?B?V3RZK0JOVGhWNlVTc3cxbHpSYlZuaEpxS0xkL2JDNUxQL004b2Mra1F4Q3p2?=
 =?utf-8?B?Y3Y4VDE0ODVXT0gxMnJjTDdld0JxNExZcVJDdUtlRkJFU1JsME9mVFFIb0Ri?=
 =?utf-8?B?N0JVNFZ3dlpoNGczT0JIWlZCOWZYUmVjaUNaZ2FmWUM5RmRDMUVPd09vcTQr?=
 =?utf-8?B?WElWQ0xIdk5JU2NXUUxnWEsxNXpNTERITmxtQWFuaGNSSlN5Mi8xeE42NHd1?=
 =?utf-8?B?Y3FQR2FUS1pGWHFhRWZsaVdNZ3FTRVRiMDJBNDNvaUF3bWN5ZTVSVzZmb0tS?=
 =?utf-8?B?ZlNzNnVhU0piNDBOMXJid3BramRORFV1ekJTcjJUamI4REROQXZkWW1YUG5z?=
 =?utf-8?B?V1dmODF1VytMRlN2NzhEYUw1bXFhL2ExRnB6S0lkeDdKbHNMYzZ0UVNpbHox?=
 =?utf-8?B?UjVkb3Z5SkFXMXhFbmdWSktJbUdUb3BweHNqSU1UMFlsS0o1dG5IZEhTcTQ3?=
 =?utf-8?B?QXI5eS9JUk9qT3BTSnNnYlhBZ0V2OTkrdTJueW0rZ0pqeVl3cE1mUk9yQmdw?=
 =?utf-8?B?TVp4ZEF0anI5NGp1SjFSMzJhMC95M2cyRCswc0FOeXhnQWhrTTZvcUI1dndv?=
 =?utf-8?B?Wk1IYmIxVlR2VFF2Z1JzUG1COFdRb2ZjZXBLTzNBTE1nWVA4Y1MwNEx4YWoy?=
 =?utf-8?B?dWNGK0FsK1hMV2pqbCtxVE9TeGJwWUxLUUJPUjQ4V2tSM3pJTlFTREFnc0Jt?=
 =?utf-8?B?cGorRmh2USsrZTR0Nzh5WWltaGxOay9Bd3Y2OG1DNWFaYU9pbWljVjQ0RGk0?=
 =?utf-8?B?d2JnYjlMQUl6MWgwS2J3OGowTjI3Sk9nL2swYytTTGRnbFhHQllBSHVRbEFw?=
 =?utf-8?B?RFozcWQ0cEtRQm9uc043aHNjeGxpRjVwR3VMamttamR6N3k3WXNlTURqWkJI?=
 =?utf-8?B?UW1vQmJEeGMwMjZsTmNoUzBDNDAvSncvVHBZWllFckhmQ2w3aEZrRG9MUFVm?=
 =?utf-8?B?bnhteFJpV2x2Z2U3OXJlZ0t4VnNPY1k1bUFZM3UvdDlUZlQ3NjFqQlc5bTEx?=
 =?utf-8?B?K3JDOUhuYU1wVmMrUnJBVGlhSFRYbTB6QklQN0FSME9JbG9JMTdoblhiaytq?=
 =?utf-8?B?VlJPRlNSWUFSaXBTaUpndTFiSFVVUERSeGZvNGorMHU2Z0JJWnlzVWVtSjYw?=
 =?utf-8?B?MG5kYWNSNEI5clZ6NXNCWmJWaGZvU21WdXJVSUF0eFd0NnJONHRBSHVlTWZu?=
 =?utf-8?B?SHgyWDh3Yzh6eEFweUxwSHRjZGtKQ0daVVVmM3JHUHJiaGRyNDZOeW5rRnNU?=
 =?utf-8?B?UitZSzRrbTJaaHU1azBaK3NMRk9ibThmY1JIM1A4SE9GVERPWGhyaWlKcFhY?=
 =?utf-8?B?bjRhWEZQSTRiSUZBcjBnWlJETGZJRndScUVnRUNzU3Nia2V2aWNLRXpJaHU4?=
 =?utf-8?B?U3RKdzZFTmRUMDNJdVlJTXRoZzFPKzA4RWVraXpVaTQzQk0rV2lGWEZ2VHZL?=
 =?utf-8?B?R3hsaTFuWm8vRVhFbTl6a21HT3NMbzZrZFYwNlRMRU9ZcHdKL0dUVWxuRTN6?=
 =?utf-8?Q?4hmjBS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 03:42:14.0377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83e9f07-f28f-4fea-36fd-08ddd0ad677f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168

On 7/31/2025 1:05 PM, Nam Cao wrote:
> Something like the untested patch below?
> 
> Will you have a use case for it too? Then I will try to accommodate your
> use case, otherwise I will do just enough for my case.
> 
> Nam
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index c38f12f7f903..b50668052f99 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -906,6 +906,14 @@ DECLARE_TRACE(dequeue_task_rt,
>  	TP_PROTO(int cpu, struct task_struct *task),
>  	TP_ARGS(cpu, task));
>  
> +DECLARE_TRACE(enqueue_task,
> +	TP_PROTO(int cpu, struct task_struct *task),
> +	TP_ARGS(cpu, task));
> +
> +DECLARE_TRACE(dequeue_task,
> +	TP_PROTO(int cpu, struct task_struct *task),
> +	TP_ARGS(cpu, task));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b485e0639616..2af90532982a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
>  
>  void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> +	trace_enqueue_task_tp(rq->cpu, p);
> +
>  	if (!(flags & ENQUEUE_NOCLOCK))
>  		update_rq_clock(rq);
>  
> @@ -2103,6 +2105,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>   */
>  inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> +	trace_dequeue_task_tp(rq->cpu, p);

Just thinking out loud, putting this tracepoint here can lead to a
"dequeued -> dequeued" transition for fair task when they are in delayed
dequeue state.

    dequeue_task(p)
      trace_dequeue_task_tp(p) # First time
      dequeue_task_fair(p)
        p->se.delayed = 1
    ...
    <sched_switch> # p is still delayed
    ...
    sched_setscheduler(p)
      if (prev_class != next_class && p->se.sched_delayed)
        dequeue_task(p, DEQUEUE_DELAYED);
          trace_dequeue_task_tp(p) # Second time

It is not an issue as such but it might come as a surprise if users are
expecting a behavior like below which would be the case for !fair task
currently (and for all tasks before v6.12):

    digraph state_automaton {
        center = true;
        size = "7,11";
        {node [shape = plaintext, style=invis, label=""] "__init_enqueue_dequeue_cycle"};
        {node [shape = ellipse] "enqueued"};
        {node [shape = ellipse] "dequeued"};
        "__init_enqueue_dequeue_cycle" -> "enqueued";
        "__init_enqueue_dequeue_cycle" -> "dequeued";
        "enqueued" [label = "enqueued", color = green3];
        "enqueued" -> "dequeued" [ label = "dequeue_task" ];
        "dequeued" [label = "dequeued", color = red];
        "dequeued" -> "enqueued" [ label = "enqueue_task" ];
        { rank = min ;
            "__init_enqueue_dequeue_cycle";
            "dequeued";
            "enqueued";
        }
    }


Another:

   "dequeued" -> "dequeued" [ label = "dequeue_task" ];

edge would be needed in that case for >= v6.12. It is probably nothing
and can be easily handled by the users if they run into it but just
putting it out there for the record in case you only want to consider a
complete dequeue as "dequeued". Feel free to ignore since I'm completely
out of my depth when it comes to the usage of RV in the field :)

> +
>  	if (sched_core_enabled(rq))
>  		sched_core_dequeue(rq, p, flags);
>  
> 

-- 
Thanks and Regards,
Prateek

