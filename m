Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1331C5489;
	Mon,  4 Aug 2025 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276847; cv=fail; b=Sya/undOBMS0sUY95pleXuQcPFvCaOvvbo4gs39cpglusHExHFRj6BNBqGsiIONbkqS47cIQ1+K5AyBCNoOOclUy6XZU5YhLHX63BQ3sY3lvPkhs8ZIas7g1nsMCLXcfmEpllqnDL7V1Zf6uuqXdIHlu0LGrNqbVzcZwuYLpH4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276847; c=relaxed/simple;
	bh=nOD7bvsW2+3chYHKzQzWcVQWNT6aSarYKAWalMqcvyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eDAagm7JXkZTRKqwOU+RskuLSjz/Ov1im81yZNW8/zg1OIAAFTQdlVn/MAxOC9LcmqUgo5xPt8lyRmdwVDM3uA/bV6e/7KH3QALHJNNmtUmdfbvLyGJPOj5JBrEkTjZQzCf0bspIGztg5d0csOcJq3S9dSMLcVCWeWOi2bvvRZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gC9jAncI; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gC9jAncI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkAvryNCIAR7X4toE8L2wosshGXTV4PBvMXpCr1koxx7QRo443UI707fAwKmeIdhcs2hd3RCspaTQLpt5hGvevAe1ioYHMrxwQXERuyL9tGq+xdlZcFhlhH/Lxkw3n8fCgAPeYMiI9Dtbxh5MBGflby1byFWOSC5b+mhRAyef65ed/DV0jQivOtUIn3T2s3j4gs7/WV1N2esfymzJ1jUgmIZPJ06JHw9pFgy4FZkjVJyQ8G1HfytMUD5KJdsiN6pFDcLQCz5GjScgR1bpQlXHjCwhEfIB89xJVSguPJR6RNTqArJugivrgkNqPJFuWHhmfNFtwoLmVnSqwGY5vRCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaYYisueZlMBXFIK7ibpUL3xhXSOEMvH2yZM58GGnEg=;
 b=gasOvl1pRDfVpCvCCh3Kgrlzr/ROQHdoD0jDHS90aogDFRoj6Q3ZAOZb5BKuiSyOJkeQlDFetMEZI4a2mIsnJJqzw9TCW2HhHwOdiSPW1+2aWXNiv1V9i4+6UJF/hFw6ZC8k8KbK30vJkaZvZp9/r/Z3fn4o8q3lGzLsmGm3S3rdydfsoRuvpGZqXw+s74NjPtkNIFJouix//jFKx9lx0cdheSG4Vq5r20WK/4OQ/HwPKkaGHQR+R3/P+eYJwFRGUs0vRoLuYILhqCgtHBAqmbJKbYBlUnT7XzIxf0yay6jSBkjM3NJ0X7HdBXMI51tY5RPyTeaW8ss8JwyqFa2BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaYYisueZlMBXFIK7ibpUL3xhXSOEMvH2yZM58GGnEg=;
 b=gC9jAncI9J+ibD6kxcIu6IO/6RveRM+Es2ywb+arupFaQeHOi+cIDwQzkYWx86yuqW5tIBxjfeo0YKwjBeCG9qXxIa8V5Pd3YoFM7WToS/blh7i+J4y2bT/f7/T2V4XNdzBX/xKXSCvIy2SZCblPSVAGNRpJxVa/ISad1ZV6oGM=
Received: from CYZPR05CA0039.namprd05.prod.outlook.com (2603:10b6:930:a3::9)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Mon, 4 Aug
 2025 03:07:21 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::8e) by CYZPR05CA0039.outlook.office365.com
 (2603:10b6:930:a3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Mon,
 4 Aug 2025 03:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 03:07:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 3 Aug
 2025 22:07:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 3 Aug
 2025 22:07:20 -0500
Received: from [10.85.42.135] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 3 Aug 2025 22:07:16 -0500
Message-ID: <78775d05-b39e-4b8b-97dd-115f57582b50@amd.com>
Date: Mon, 4 Aug 2025 08:37:15 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
To: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
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
 <97c8a989-08b1-4233-8f5a-cb8b582b6c02@amd.com>
 <c403aacc94dc09aa9ad4441be6095d00b2091f68.camel@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <c403aacc94dc09aa9ad4441be6095d00b2091f68.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c98867-68a0-49d5-29ec-08ddd3040761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2NhSWZDMVNvbVRCc21SdG1nbG1XdkpVRFhOSzVzbjZJZ0l3VUpSSXNWTFY0?=
 =?utf-8?B?cDMvMVVYV1NydDRXZ3ZHeVhiZmIzaUk5c21KNjczT2w0OVZITFp0UGc5dnFJ?=
 =?utf-8?B?d0xhWkpjWndSc3psRkxwWDBMODNDL2ZWMFduekkyQmdwTzNXaXBDcUR0Y0sx?=
 =?utf-8?B?M2lEeU9VenZTNk9QSjlwYTdTSGpHNmt6UlNiZ2JFdGw1Ly9URTdnUGFoak52?=
 =?utf-8?B?RlhEb25SdGtpOW8yN3luOXBxUUdQM2FoeStRZUVPNU16R2F2NmFkci9HSnNm?=
 =?utf-8?B?Wm5HbzRUNkZ0UUxMUVRPUlQrVjJpNGFFc2lwTFdjOERPSEVMZ2JtSlgwY0tB?=
 =?utf-8?B?TFY5STdtWkExWFlPcnlJeXprVHlLekcxREVhYXd5S3Vud1h6WStQZkgySHQ4?=
 =?utf-8?B?M2x3UnRETzhpVTk4cXl1OEc3T3hkajdNYlNVOEwvWFhQMENMRmUwYUZMcWRu?=
 =?utf-8?B?MHdUbVkvVFdyenhHZmd6RmZhdUg5VGhadWw3SitQZWcyVUt5cGJjVGJwR0FY?=
 =?utf-8?B?SGdvMThjRFBtRFhZV3R4cDZPY3J2dXgwT2xxTHg4YWFHWXVuNnVYV2d4TUVv?=
 =?utf-8?B?UHgxT0hCQVdiVmlMRmV5R21Ua2FPMVcvK0MrVUxhbHl0VWYrQThtYXJLWU5Q?=
 =?utf-8?B?cmFQc0FKdHlFcHh1RVlwRVVnYWd1YWxqRjY3cktXaEJ2ZWZvRXFwU3Q2ajZs?=
 =?utf-8?B?U0tmaSt6UXlpSUd5VzNyWm5nejVpdEpMSE95ME9tYzEzcWdDTXlaanNJV3la?=
 =?utf-8?B?RHdwSnZvRUZkWUpuZ2F5TjE5YlVIa0laeVRwejdaaFlrMExsZ05KbEN0b1cw?=
 =?utf-8?B?Z1BKcHFoUFVCa1V4dzY5czdwY2hoTEVuZUVaTHhOdGFTZzZrbVdSYmtkdTc0?=
 =?utf-8?B?L1FDTHRJWldvR2lqZ2crdGhXMitrazhFc3g0NVZPaEFldU1hcnBzMks3OEpN?=
 =?utf-8?B?OGNvRHRjSm95OU52czVPVmY5WEc4NnJNeGtqQ0JQVGtUQ0tHeHRmN20zU3FQ?=
 =?utf-8?B?ZEtQRU5QVUMzb1QzRk5yWE5yNU9KWlQzc0g1SVhJTXIzSzNNNnowTGwvUkxz?=
 =?utf-8?B?WGl1TUVHMHE0NDBSYTJiUzJPb0JaWFlLNzUvdUhoSU1pSFhKbXVVRDkxTFNK?=
 =?utf-8?B?TGNuQnpUOWs2N2pTbEV1dTcweHE3eEFrRVlzbU5vRE51TjJlQWFyd3hNbTJs?=
 =?utf-8?B?My9vY3k5ZDhpNUpQQWZxa0luNWdXajh6Wm13SDhWZkdyV1pJNEJXRXFGUUh6?=
 =?utf-8?B?NnI1V0JET0NzTDZXK1pWYVdqa1FNMWM2bGFGZDVPUUw5VnFjTGVwbGoxWG5j?=
 =?utf-8?B?K2lOSTN5K0ZsZ2xCeVYwcDlNYkVPN2pYVE9zWlZKeXY0QkVYVmZmUTJCazZ2?=
 =?utf-8?B?RTJuajFUdFNNZDRHYXZVNWltYlJ6MCt1ZjNjb2ZQLzErRjU0eFhpdU5pUG5S?=
 =?utf-8?B?ZkltSnZKeWxwcjllNUp5MDNLWE5tQTFtY0h0bzQwMnBMelpHQTAwekxQay9I?=
 =?utf-8?B?cmVndW1RNjZTNHlSUmFDcUUrdUtXUCtjU29mcS8vc292eit1UlRpbmFSU3Qy?=
 =?utf-8?B?UENZcm1OdHlVYjNLQmgrWjhrR1hYb1BLUy9JUmt5QUxXM1g1Y0Z2ZUxMTFBH?=
 =?utf-8?B?a0VYYkdkZU16bVU3cjFZSzJrNVVhRi9GeDVjeWkyUUhWQ2tDd3dCSTh1SWRQ?=
 =?utf-8?B?dnltSlFOMmNFcmlIc0VPQ1ZjZC9FMVVJN0xMak14ekErQVhaTHBRUG5FbUtm?=
 =?utf-8?B?ZlpFNVhJLzc3TzJyeGN3SkVkU0I4cEhuemxQckp3UUZDVFVyV3EwbkxzTHNs?=
 =?utf-8?B?UjFvdkxZYStvZE44M0Fza0NmeUluOGZnRmxKZm5FcEZjc2NUYnhBQ3M2YVBw?=
 =?utf-8?B?M3B5NUNDSkJtVzdKUVpGTFdGVWdlcHIxZExKaFhEbElGVmN1VWZ5M2U4czJX?=
 =?utf-8?B?eHloMS9uSjlLMVc1eXhRVlhubGRXc0ZNVE52Ry9DUUFaMVJKcHBYRGpTd3ZL?=
 =?utf-8?B?ZnNoTkVNbHFBMSt2VExRTkx5bnBVWXdtZHVnQ2hKMjVwT0ozMVNOL3VlZ2ZY?=
 =?utf-8?Q?BS0XkA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 03:07:21.2733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c98867-68a0-49d5-29ec-08ddd3040761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

Hello Gabriele,

On 8/1/2025 4:34 PM, Gabriele Monaco wrote:
> On Fri, 2025-08-01 at 15:26 +0530, K Prateek Nayak wrote:
>> There are a few more cases with delayed dequeue:
>>
>> 1. A delayed task can be reenqueued before it is completely dequeued
>> and
>>    will lead to a enqueue -> enqueue transition if we don't trace the
>>    first dequeue.
>>
>> 2. There are cases in set_user_nice() and __sched_setscheduler()
>> where
>>    a delayed task is dequeued in delayed state and be put back in the
>>    cfs_rq in delayed state - an attempt to handle 1. can trip this.
>>
>> Best I could think of is the below diff on top of your suggestion
>> where
>> a "delayed -> reenqueue" is skipped but the case 2. is captures in
>> case
>> one needs to inspect some properties from set_user_nice() /
>> __sched_setscheduler():
>>
>> (only build tested on top of the diff you had pasted)
>>
> 
> Hello Prateek,
> 
> thanks for the comments, this looks much more convoluted than I would
> have expected.
> As Nam pointed out, currently RV is not going to rely on those events
> for fair tasks (existing monitors are fine with tracepoints like
> wakeup/set_state/switch).
> 
> For the time being it might be better just add the tracepoints in the
> RT enqueue/dequeue (the only needed for this series) and not complicate
> things.
> 
> At most we may want to keep tracepoint names general, allowing the
> tracing call to be added later to other locations (or moved to a
> general one) without changing too much, besides existing users.
> And perhaps a comment saying the tracepoints are currently only
> supported on RT would do.

Most of my comments was just thinking out loud around fair tasks being
delayed on the dequeue path. If RV filters out RT tasks and the use-case
one concerns them, then Nam's suggestion is good.

I was just being cautious of folks expecting a "enqueued <--> dequeued"
transition for *all* tasks and finding it doesn't hold after delayed
dequeue. Since these are internal tracepoints, I'm sure folks using them
with RV would do their due diligence when testing these monitors before
deployment.

> 
> Anyway, that's your call Nam, I'm fine with your initial proposal as
> well, unless some scheduler guys complain.

I would be happy to help test alternate approaches if others have
concerns around delayed dequeue but for all other cases, Nam's approach
looks good. Sorry if my paranoia caused you folks any trouble!

-- 
Thanks and Regards,
Prateek

