Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F78F2EA73F;
	Thu, 21 Aug 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765853; cv=fail; b=INIktUkDBZl37RjRMx3W6KnpjFS2cyUXdquUHwmfbbhNY3ozkNGOfUykZ8Dx6R2XkrziEycBG2VUe2v7igdeCMHVS0Vo7xdabiD4MsW0QXyTETqnim9fpDf8T7BrxZQc9JRx6B6tsUgYIfitLtkZQyL6rTtwVLja9CJ42GbX/+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765853; c=relaxed/simple;
	bh=v26M77AdxMPwbWN8ayJg/9Z9xtT3RhM8YaV0dsJ/06k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sQThrr8JWPbU9Wq9khqThwAKRoiIVzRza3OqhECQo8ZfbutPUwbzmfDKmGiY4AOfpQjaF5CuQKV3hLmFejEkRdwnOevgI3Bz/+7TZumYw0jtXKzSPHik1F+GsUoVeE6TzxWlsVxytVIIvfAjwZyU1FagJJ4TTG6foZPzwO+3Byk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fG3g3Bfs; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fG3g3Bfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws6Ra1diqX7V7SM8ytXDdCTTqBoafpKcOcweT9gQlXGLR2HgUvJEmJd4/KP0iDMZjhCayro36ie1FD2UUp3VxKIZgUWjDEdRLfg1odYJyZONYU1hHNj7hwca4Y+Z0oonzX7RtQK8g8ZQv5GDxMDex27YSp0rGveocHOqqZdMbf/CkfkHnBVutFKwZOpJvyvOMid1uTNP0i1m+hxHZZxcGxWdax7dcvsovp5rqYjtVxwSYYpIS2Yrrp3dALTl1Bl+6ib19RqUcwbU+zWRvchAyPuK9ndknZ7TINw+4Y5hebJWjkNytLJ8X6aIUzh1irT5ENOSz0dbn16iTM9KUolViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFSGSQNlWJNj/jJYzMd1ozhWmA6wOaJLiXpJeALuVCQ=;
 b=eYkdvHQo9Ziz8PNylt5fiUljn5Q4sSICFquaC7XRv5WJL7v+5p9BR6SR6ZMFbJZqoX/n1e4QMHecAy7XYLk4juQzkbUhKoLItAqnQvXLJwLjMNYrYM/H9u7fFI1lC3l/b1mFgyw3k0pM95RflO3THPmmeYQwwbWvGq1ONkCZR9rZWfoDhYFJRcWohAY9+AMroqA4/HFjiQJhPO25P8uDesz2TDbDSJmI8ksWDOODWZui7Y5O6XUCzPqjA7p79KQymtB0fnD1rkDblr7wknXorahaGEML3OF9PFiHQWAhL3Rv2AGFzczL9hVIN1+UNRz8shzabCLZdU5lMT9R6wxqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFSGSQNlWJNj/jJYzMd1ozhWmA6wOaJLiXpJeALuVCQ=;
 b=fG3g3Bfsfl3qmBdSgVxRHwP7QPny9bfAuCg06/e6G5IkbGIITn4TYwTLAbDW5JVlYqv+A5hJyBvRdwNkd38Kk63iZIhJ51T6l7TSgN2me2qT2w6XLAz6/UaUwsh8pLk/lvBtRPukACEY+s6r1M4Rfny9fIbfVMNUsr9ypfmGXYo=
Received: from SA9PR13CA0038.namprd13.prod.outlook.com (2603:10b6:806:22::13)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 21 Aug
 2025 08:44:08 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::9c) by SA9PR13CA0038.outlook.office365.com
 (2603:10b6:806:22::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.6 via Frontend Transport; Thu,
 21 Aug 2025 08:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 08:44:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 03:44:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 01:44:03 -0700
Received: from [172.31.184.125] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 03:44:00 -0500
Message-ID: <47c67022-427c-4c24-8dcf-a3721f8c5bdd@amd.com>
Date: Thu, 21 Aug 2025 14:13:54 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] sched: Add task enqueue/dequeue trace points
To: Nam Cao <namcao@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Phil
 Auld" <pauld@redhat.com>
References: <cover.1754466623.git.namcao@linutronix.de>
 <f87ce0cb979daa3e8221c496de16883ca53f3950.1754466623.git.namcao@linutronix.de>
 <20250815134016.GB3289052@noisy.programming.kicks-ass.net>
 <20250815135212.GA1386988@noisy.programming.kicks-ass.net>
 <20250821070504.-ZhqdfHs@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250821070504.-ZhqdfHs@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad23782-ef42-46fa-b9fe-08dde08ee495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0NOUUszdnpsL0RQamRwUHBvbnlKandwUzhsZUwyNWNxOXQ3amd2ZEwvdVBw?=
 =?utf-8?B?ditKRnR5OWpNMXphUUIzdExEVnE1OHNTTTZpV1hNK2t6aHRKZHp3N3RqenNN?=
 =?utf-8?B?MUVSdlZBampsaER5SE9Ob2d3dktQLytWVDBZM0MxWk1pMFV3ODdIZzNFR3Bk?=
 =?utf-8?B?Q1hWRldPbW15QUZRQ3BjSG5RMzNzSFpNeW1ZZHpGSEpYcUZGZU4rall2Z3NY?=
 =?utf-8?B?bUFTMUc2Mzd0TFgvMzZheVNhSEh5NkNFSkJQT1hQWGhtallyRUlYTVRoTUdW?=
 =?utf-8?B?M0hGNnN2YVFzdFNoZnpLQjY5K1NxOFVQaVU5TlBNcFV3Y3NVaktQSUd2R2VB?=
 =?utf-8?B?R0x4M2FuN3NyTmk5ejNENVIzRXNybGhFSlRIVzZZTkZDS0JlRm94bEpVeTNv?=
 =?utf-8?B?aDcxZDhWT2E4WjB6R3VIRUFPU0lOTGh1bTZrdHNRN0FDZGh3MGZoM3BhQ3Fz?=
 =?utf-8?B?M09vZjk0K1VLQWxyS0t4T2pHL3RPa3Y4SFphVm9jemh3Q2dsTldzMFpaRVJE?=
 =?utf-8?B?enFqTUlQUlVxTjZjeThKZEErUmVVMlJidHZCcXdpbnk3QnBYcitsUXpLdGtQ?=
 =?utf-8?B?aXEwZmNXZWdSSU9SYkx5Qmg0OG5VVUc5dFVJb2pCRmlvNFlEZkdLVWQwejFn?=
 =?utf-8?B?MEFaaUl3aWhmUllmRXByTmg5SjVUeloxb242cGRqTENSbzZ2TTUvdEd0M1FW?=
 =?utf-8?B?SitJRURDQ1hWclU2ckdaM3U1Z3VtaUNiOVlLc0FoZFBnaW9wTnBxSDlSSEta?=
 =?utf-8?B?L2ZMbE02K0wvNCtCeUlPNjR0TGFMM3NCVCsveUFSRFRDbk4zSHArZC8zcDBL?=
 =?utf-8?B?K1BQVFY1VS9ZNXFhTTVtOWFiQnpLcG1DaGtjSHUvWmdjQUxzVVRsajNOUlRQ?=
 =?utf-8?B?am15Qmh6QzlkTjRxalFDN09uREkxQThxTVdyTWJ1NWJ5L2FLNHZ0eVdPWmpW?=
 =?utf-8?B?Z0hCeVdLamhaY2dxNExKVzY1N1pHUEdzNEFvU01lU1JFdHh4R1d5ZWR5VlVz?=
 =?utf-8?B?cmphRXJPaVQwS0ppQXM4VUszRm1EbTVPQitTUnNNblBDeDY5Yzh0T05zV1g4?=
 =?utf-8?B?MWRsSDhSL1FDbHJwNGFjMEpYZGYwa3dzb0c5MCtUckxuZHEvMXRONHZUcUZ0?=
 =?utf-8?B?UmRsSTBWdVB1b2VmWXRjTE5FZEVFWElDSmI5b0M3ZENjU0xXL1BUazkrMmty?=
 =?utf-8?B?eFJtM1RReUFvNWwreTlBZ1p2bVc0b2pjelZWSUw1d2xhS3V0SzBQbXp6VTU3?=
 =?utf-8?B?RFBka1BmK1VSK2tqZFc5blNxbkNJeDRCWlBuS2hxVGg5bC9HdVAwejZpbGtV?=
 =?utf-8?B?TXdtRVQ4U2QxYmNCdnVvS25MWUhZOUVVQWhFUVFOK3MxTjVid1Y1dit1OVBR?=
 =?utf-8?B?eG0zQ1ZheDlNME0wQWRNQ2NGY2RBbXd5bGkwQWVXcFlYMHI5dUppdmxRV1JY?=
 =?utf-8?B?eHJqcm5iZkdCSHo3Q3k3aXR3K1U4c2VsL01INzJlWG0yOUZ0MTdBQlRWVkJK?=
 =?utf-8?B?bmNseXphR0pGc0RWLzFEaWo4ZCtqYjZEKzVBcFJoc1hUWFAvQUg4dm5haHcr?=
 =?utf-8?B?b09uT3IyUXdncVNCN1BKbUN3L0RSY29VTEFUSkFKck93dDlreVBGRHdRQ3FB?=
 =?utf-8?B?SU1SM3FFbGlVQzUvQTJPRHltSU00cktHcTlzOVVBNHdOeGR5Y3dsS2IybVRI?=
 =?utf-8?B?RFVsSjV3RW1WSEk2aVIrR2gwQTBSMWtXdUE5UEV1SExsTk5PRi9udTBGRzRl?=
 =?utf-8?B?NDNQaGRuUDJWY2NpUXRYcEh4Vnc3QlhIbmc1WGZSd05nVFYzTmZYSXdpVGhn?=
 =?utf-8?B?dHcwaDI0K2xmVlJSMDA0SStwWm5qN1luNFJZY1dQWlhEV3VjZ1hqVGFmSjlK?=
 =?utf-8?B?ODMwbGxaR2FBSmV3K1ZDcGliRFk5YTRYbnZyMlRzdUNsakx4bzBtLzNJZmVS?=
 =?utf-8?B?OU8yVUVBV1N6bzl1TWhYK0YzMWNKbllaVWNSbjVIRHRIaDdMdTFtUjRWb20v?=
 =?utf-8?B?cm1ZQXBzV3EvNCs0VHp6ZDNnYlJkbS9lWGtpRk10YWF0cHgweGNOS3IwbXVk?=
 =?utf-8?Q?CCHJz3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:44:08.0801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad23782-ef42-46fa-b9fe-08dde08ee495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126

Hello Nam,

On 8/21/2025 12:35 PM, Nam Cao wrote:
>>> How about something like:
>>>
>>> dequeue_task():
>>> 	...
>>> 	ret = p->sched_class->dequeue_task(rq, p, flags);
>>> 	if (trace_dequeue_task_p_enabled() && !(flags & DEQUEUE_SLEEP))
>>> 		__trace_dequeue_task_tp(rq->cpu, p);
>>> 	return ret;
>>>
>>>
>>> __block_task():
>>> 	trace_dequeue_task_tp(rq->cpu, p);
>>> 	...
>>>
>>>
>>> Specifically, only DEQUEUE_SLEEP is allowed to fail, and DEQUEUE_SLEEP
>>> will eventually cause __block_task() to be called, either directly, or
>>> delayed.
>>
>> If you extend the tracepoint with the sleep state, you can probably
>> remove the nr_running tracepoints. Esp. once we get this new throttle
>> stuff sorted.
> 
> Sorry, I'm a bit out of depth here. Can you elaborate?
> 
> By "sleep state" do you mean (flags & DEQUEUE_SLEEP)? The nr_running
> tracepoints are not hit if the task is throttled, while these new
> tracepoints are hit. How does the sleep state help with this difference?

Once we have per-task throttling being discussed in
https://lore.kernel.org/lkml/20250715071658.267-1-ziqianlu@bytedance.com/
throttled tasks will do a

    dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_THROTTLE);

and remove themselves from the runqueue but they won't hit block_task().

To preserve current throttle behavior, I don't think per-task throttle
should call dequeue_task() directly since it does a bunch more stuff
with core-sched dequeue, psi, uclamp, etc or maybe it is fine to do
that now with per-task throttling?

Peter, what do you think?

If we don't what to do all that stuff in the throttle path, adding to
Peter's suggestion, perhaps we can have a wrapper like:
    
    int __dequeue_task(rq, p, flags)
        int ret = p->sched_class->dequeue_task(rq, p, flags);
        if (trace_dequeue_task_p_enabled() &&
            !((flags & (DEQUEUE_SLEEP | DEQUEUE_THROTTLE)) == DEQUEUE_SLEEP))
            __trace_dequeue_task_tp(rq->cpu, p);
       
        return ret;

and then per-task throttle can just call __dequeue_task() instead. I'll
let Peter chime in with his thoughts.

> 
> Also +Cc Phil Auld <pauld@redhat.com>, who seems to care about the
> nr_running tracepoints.
> 
> Nam

-- 
Thanks and Regards,
Prateek

