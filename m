Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAD230996;
	Fri,  1 Aug 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042207; cv=fail; b=KNCp7MiAaIfrbukPvjw05GVMdEmOm26Nzt/Cunr7pNNr/8zYIXUoTuHZU4wMNU3a4jH8QjDGzTIfcwvmzfEpKs0TycMK2Xspzq9Y3OohlmAq3pwnbFdmPxarwzMeBlDBvF9ysAs8aYBd172Qmm9VUx3wT0mHQXLURyuPX4nRfw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042207; c=relaxed/simple;
	bh=OAMif0NdDsmQzJLXgCfOWbbYxuCGhFPdYXO2QX7aKfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wnxi5g7t5A6zl54IlaKKsWkoJJk+b85XIrRZPcbdMwTg/vdFJBZ6q1Ywu66Zs7Up9ZoUuhB0iiI+dc2sYl7avnVda2u9vFq9GEGHNHMQqyRlemjIjJTIVJu6E/vlJ2ef5GgQuF+Tg7SNHp2/sRAT4EFP3mSstEJqOWGRyQ25I8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YVIHMj97; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YVIHMj97"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq09BxXp5uhaTF2g3PCVUkOGfON/rX3J79dnImevQI5cuftsnU5qFxuxM7KcdZs8CrqRVaADAjW7CrrmL3g1KuJcCC39yirLTpgEpDsqxul2wSmQwDI5Rx2/lolVw1bjJZumRdVfTFKv9J9QSlaK6OQgiCf/ZQBeYw4tS3bH76RJgx+35tk8iy746ro1bLTLqYwjkdZZp74pIVHg/d4rHeOBQ9cpGOmee5y5dpueyzmO6AuESKp4/1ma5jlXqAg0hF2unOV8mKmPUC48jEezOV6BjhGT6R90PYQraxCbBSW5S2y3va2DsF1eV89RdNCXhYPLlHrUW4rgIwH4vOubpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYYkzFMNqrxkP54ufK6e9tZxnisD3lMtl7mzC+e7CYQ=;
 b=AwTlT2b5t80WeW3EAAdzrUC+APY31bmsnkqLxfNcAEdnvP+Adngu51eGGFI094zpfLowM/FPVxqmBJfATcTsuKWiGMdJYr7fTvnu+vrItuq+Bfbgog4GFlJngqh81sx2JruuLMHK50fhgabF0dDqLQi1Ys4bFritzZ2qec/KbM+QfWvvhhtvCKfSScQN+J60ML4ZwyjNgW6guE4leV/kGaZwzmNweLGn83PyiQyozKEEXG5/k2ByeRvYAsJ2zHZ2FSC/n1Px3hiEUCMg74YxttOd6zNg6oBjk5f3Bvv7+DbJcAzW37b5gy1G8D+O9E9/7cM/QcD4s6SelIr9XUMsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYYkzFMNqrxkP54ufK6e9tZxnisD3lMtl7mzC+e7CYQ=;
 b=YVIHMj97gCA9NcZTv53+oin131LUz6oZVuyU3SwwWV1kXHoiqNAnUs/l9CRidpZYZZ87OqmAk0f46tl3mvfzbckKbG3dqxJoX9F1oKNtcTHCPSUqfvUNDWAj/iPaqeEE2Z5mwrope7rpN+DHcH40PxCpqT5iIxOQekDV0aQMxqI=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 09:56:42 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::7d) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.17 via Frontend Transport; Fri,
 1 Aug 2025 09:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 09:56:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 04:56:40 -0500
Received: from [10.85.43.78] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 1 Aug 2025 04:56:37 -0500
Message-ID: <97c8a989-08b1-4233-8f5a-cb8b582b6c02@amd.com>
Date: Fri, 1 Aug 2025 15:26:36 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
To: Nam Cao <namcao@linutronix.de>
CC: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <179674c6-f82a-4718-ace2-67b5e672fdee@amd.com>
 <20250801072946.nTiUlMwS@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250801072946.nTiUlMwS@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf55edb-980e-4868-57fa-08ddd0e1b732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXBRUnV1bFBGbFpNczViMVRsR2tnZXBwVjg4OVQyUTZHTEpEL0xkMTBZTzVX?=
 =?utf-8?B?Q2lFdlZwb0VlQXBVMEFILzlIUjVPT0dlaGRQSzBxV0ZDemg0cS9rUEZNWlFR?=
 =?utf-8?B?SXdrQVdrMUEzSUNkTUNhT2xGU3BOcmtaN1FoUlNib0Q3NUEzb21NZlRBZnFG?=
 =?utf-8?B?S0tJUkJKQU5mUmx5TEdOcmhtOGxCZ1YzeW02UXBydC94aTlHdFlqQjBnc2o0?=
 =?utf-8?B?dVpraS9UZmc4Titqd0pKUHlPUjhmOGpTNi92L1owRGVnRzNtZnFJNzJQYytI?=
 =?utf-8?B?ZFdySjUzQmFlTVJUaVpkUUtpb3ZBdHpPWklrS1VBbTQ3SGJud0J4Q3FDZ1ZN?=
 =?utf-8?B?Nm1zVXNFU1duNjg5QWpONlNXRFYrOXljVGlMTkwwRVhaUi9XZXBtYk9PYTl2?=
 =?utf-8?B?ZGxEZjZJRHFQMlRHY0J5VFg2UnQvTFlueEFYMjJ4WklpMUNaM3BBcS9VSkQw?=
 =?utf-8?B?RmRXN0FrUVBPV2VkQXhzVnJ0anJhR0g2akhHS0NTOHkvUWx3M3FzQUE1MXg5?=
 =?utf-8?B?U3oybGtUZ21ocDk4bEpUV0pJZUhUVHUxMHpXMjRhYXdkczJtNHVtYWtVYTdI?=
 =?utf-8?B?eDN3dTRTOFhud0dIOUZ4aXFQR0drbnE5RHl4Wm56SnZxUW1vTTRCOXcvL1hs?=
 =?utf-8?B?enFEU2NVYnY5bElIQ2VNSkljdWlZWlZHS2E1NGJnUElIYjFibFB6SGVJMVhN?=
 =?utf-8?B?SFNpZ3BlZUZjSEo3ekFPODV2TkZaUnJoNkRWejVQaVpobXc1YnFRN1lkY0tX?=
 =?utf-8?B?aWRjSnpuNmlWRktKSmpTcXExc2RObjRpV0ZwdFZESjNQa29FR1NOdFcreXh1?=
 =?utf-8?B?VmNyUGhmSDBjcXFKbEtVSXh1MDJIcGxnQ3Ara0R0NTV2dW5HK1F1cG1pUzNk?=
 =?utf-8?B?LzA1TkpWZ0lwTElod3NlNkZxb3JzN3o4MThBZE5Jdi9PUmk1NFhsRnVlTzli?=
 =?utf-8?B?YjZGMkxxTjV5cEx3L2RQYTczYm1RRTBXTTR4akpVSXg2Zy9FQ015cnB3b29r?=
 =?utf-8?B?Q2Q1SEpLZ0JQNllQUUNTdXlUa1NkYWM4UTVGSjJaSDVKaU9Jb3BYOHhxQ1d4?=
 =?utf-8?B?YmRnb0VoRmFLSm52UkJWZWJoZ0NKWnJIT09kc0F6dWNQUVE4MG85Sk1FQkpH?=
 =?utf-8?B?SnZsZTR6R3ErSDFCS3VIeThrMnA3b0daK0s4Z3ZZTDQ4ZEJNME5yMitHUmxO?=
 =?utf-8?B?YnFRRmY0WUI5Z3BEdmNDalNaN2p3Q0o1b1hBeE5NR0t6U3JudlpzRi80MnFa?=
 =?utf-8?B?SjhrMEhnbVJWais3UDlmMjVLaFpqRmw4S2R4TVYrQkY0S3VJdXM2ZTc0UWZu?=
 =?utf-8?B?eEFFU3RUcjNoY1YrTDE1dVBBUU5EQU1DRjVSQU53dVZNeHdvTTltWDcva0pR?=
 =?utf-8?B?YWlsallRaFVyWERCM05OSUxTODZ3OEp5SWd3OXJnTGQ0bjZDK3JFclVUc3FH?=
 =?utf-8?B?TWJNMERrQjdBRHdJbEM3SFplQUFCbUhvRUtOYjNESkw2QWV4bWV0aW1iTEN6?=
 =?utf-8?B?enRxWWtIQlZ2R0EweFJHVVlXT2h4OVlLTWdlbEF4YW91RUIzQUlRVUp2aUhB?=
 =?utf-8?B?RzI1ZjRQc0c5OCtpbzNibHVyU0JYTTFDaGlJdjR6ZUhZdXlwK05OYTVLWERO?=
 =?utf-8?B?U0xKM0FuUnVXbjEvSHl0NFRvQ1hQK2NrTlh0Ym5GVmFKNWdTekMzS2RVNGg4?=
 =?utf-8?B?ZERKdllqZTlYcFZ0SUhFZ255VDNFeGxIZE5nTlRrZC9WdnJhZVdVd0Y5bkor?=
 =?utf-8?B?MlRFanpXR3R1L1NKMWdOTEl0bHlXSVRCQ1ZVQTM0TEt5ZXZITWtLbTZEUGZs?=
 =?utf-8?B?UDRaMkFlUm1YenBveC9iTFBDcmR6U0JOZW1yQzAvSzRTdytMNVNEREplaDhM?=
 =?utf-8?B?NzRlc2JVZFFobmlUakh3dGxrendEWXRXNDRGRWJwZldkUFM0TE9hdFBFcnVw?=
 =?utf-8?B?NjJVc29LdEtkV002UnFpdnJQTlRZaUZnRWV4MUt1N0FiRnQyUmxLcVdJNUh2?=
 =?utf-8?B?cFpVNlh3TFVVZUE4RFBYd1ByR2xTQ29HTnZzTnhvTm91MFY4UnJsb0VLOEJE?=
 =?utf-8?Q?tC3d/9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 09:56:41.5547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf55edb-980e-4868-57fa-08ddd0e1b732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904

Hello Nam,

On 8/1/2025 12:59 PM, Nam Cao wrote:
> On Fri, Aug 01, 2025 at 09:12:08AM +0530, K Prateek Nayak wrote:
>> Just thinking out loud, putting this tracepoint here can lead to a
>> "dequeued -> dequeued" transition for fair task when they are in delayed
>> dequeue state.
>>
>>     dequeue_task(p)
>>       trace_dequeue_task_tp(p) # First time
>>       dequeue_task_fair(p)
>>         p->se.delayed = 1
>>     ...
>>     <sched_switch> # p is still delayed
>>     ...
>>     sched_setscheduler(p)
>>       if (prev_class != next_class && p->se.sched_delayed)
>>         dequeue_task(p, DEQUEUE_DELAYED);
>>           trace_dequeue_task_tp(p) # Second time
>>
>> It is not an issue as such but it might come as a surprise if users are
>> expecting a behavior like below which would be the case for !fair task
>> currently (and for all tasks before v6.12):
>>
>>     digraph state_automaton {
>>         center = true;
>>         size = "7,11";
>>         {node [shape = plaintext, style=invis, label=""] "__init_enqueue_dequeue_cycle"};
>>         {node [shape = ellipse] "enqueued"};
>>         {node [shape = ellipse] "dequeued"};
>>         "__init_enqueue_dequeue_cycle" -> "enqueued";
>>         "__init_enqueue_dequeue_cycle" -> "dequeued";
>>         "enqueued" [label = "enqueued", color = green3];
>>         "enqueued" -> "dequeued" [ label = "dequeue_task" ];
>>         "dequeued" [label = "dequeued", color = red];
>>         "dequeued" -> "enqueued" [ label = "enqueue_task" ];
>>         { rank = min ;
>>             "__init_enqueue_dequeue_cycle";
>>             "dequeued";
>>             "enqueued";
>>         }
>>     }
>>
>>
>> Another:
>>
>>    "dequeued" -> "dequeued" [ label = "dequeue_task" ];
>>
>> edge would be needed in that case for >= v6.12. It is probably nothing
>> and can be easily handled by the users if they run into it but just
>> putting it out there for the record in case you only want to consider a
>> complete dequeue as "dequeued". Feel free to ignore since I'm completely
>> out of my depth when it comes to the usage of RV in the field :)
> 
> Ah, thanks for pointing this out. I do want to only consider complete
> dequeue as "dequeued".
> 
> These tracepoints are not visible from userspace, and RV does not care
> about enqueue/dequeue of fair tasks at the moment, so it is not a problem
> for now. But as a precaution, I trust the below patch will do.

There are a few more cases with delayed dequeue:

1. A delayed task can be reenqueued before it is completely dequeued and
   will lead to a enqueue -> enqueue transition if we don't trace the
   first dequeue.

2. There are cases in set_user_nice() and __sched_setscheduler() where
   a delayed task is dequeued in delayed state and be put back in the
   cfs_rq in delayed state - an attempt to handle 1. can trip this.

Best I could think of is the below diff on top of your suggestion where
a "delayed -> reenqueue" is skipped but the case 2. is captures in case
one needs to inspect some properties from set_user_nice() /
__sched_setscheduler():

(only build tested on top of the diff you had pasted)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9598984bee8d..1fc5a97bba6b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2071,7 +2071,8 @@ unsigned long get_wchan(struct task_struct *p)
 
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	trace_enqueue_task_tp(rq->cpu, p);
+	if (!p->se.sched_delayed || !move_entity(flags))
+		trace_enqueue_task_tp(rq->cpu, p);
 
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..1e2a636d6804 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5444,7 +5444,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * put back on, and if we advance min_vruntime, we'll be placed back
 	 * further than we started -- i.e. we'll be penalized.
 	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
+	if (move_entity(flags))
 		update_min_vruntime(cfs_rq);
 
 	if (flags & DEQUEUE_DELAYED)
@@ -7054,6 +7054,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* Fix-up what dequeue_task_fair() skipped */
 		hrtick_update(rq);
+		trace_dequeue_task_tp(rq->cpu, p);
 
 		/*
 		 * Fix-up what block_task() skipped.
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d4333731..33897d35744a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1196,19 +1196,6 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	dec_rt_group(rt_se, rt_rq);
 }
 
-/*
- * Change rt_se->run_list location unless SAVE && !MOVE
- *
- * assumes ENQUEUE/DEQUEUE flags match
- */
-static inline bool move_entity(unsigned int flags)
-{
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
-		return false;
-
-	return true;
-}
-
 static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_array *array)
 {
 	list_del_init(&rt_se->run_list);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d3f33d10c58c..37730cd834ba 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2361,6 +2361,20 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+/*
+ * Checks for a SAVE/RESTORE without MOVE. Returns false if
+ * SAVE and !MOVE.
+ *
+ * Assumes ENQUEUE/DEQUEUE flags match.
+ */
+static inline bool move_entity(unsigned int flags)
+{
+	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
+		return false;
+
+	return true;
+}
+
 struct affinity_context {
 	const struct cpumask	*new_mask;
 	struct cpumask		*user_mask;
---

Thoughts?

-- 
Thanks and Regards,
Prateek

P.S. move_entity() probably requires a better naming and perhaps can
even be simplified. I wrote out the below table just to convince myself
to reuse move_entity() in fair.c

    flags contains    (SAVE | MOVE)   (SAVE | MOVE)
                         == SAVE         != SAVE

    neiter                false           true
    SAVE                  true            false
    MOVE                  false           true
    SAVE | MOVE           false           true

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
> index b485e0639616..553c08a63395 100644
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
> @@ -2119,7 +2121,11 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  	 * and mark the task ->sched_delayed.
>  	 */
>  	uclamp_rq_dec(rq, p);
> -	return p->sched_class->dequeue_task(rq, p, flags);
> +	if (p->sched_class->dequeue_task(rq, p, flags)) {
> +		trace_dequeue_task_tp(rq->cpu, p);
> +		return true;
> +	}
> +	return false;
>  }
>  
>  void activate_task(struct rq *rq, struct task_struct *p, int flags)


