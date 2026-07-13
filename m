Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C333002D8;
	Mon, 13 Jul 2026 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912641; cv=fail; b=Sm7xqzfgJN/Ic6aRLHskEWneCjQN7QU5JsP4QgVqLe0koIwQfuZucWKiZUV6oiRo6g/NjNFt0TT2S+IX0cYENpZWfun0HNlcwcvLjV/0UwumNfZ2eZt9QJl0zQXweiRdsaW5C4fklVsmhJd/aVEVJcSrDzgOVah0V2kK3cYUPSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912641; c=relaxed/simple;
	bh=+uTTrvbHnOnnk968ZE34spHXbfFtiZfFXCSUfUA1TMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OR0DQzuOHs7ct2KCKmhPKOc5F4KxHqhsSyt5Tr7blRa1Lo2gVIDoDepGGSI9Mv7b35ZOVzkTRhLVle4nMCGAPnBQtpLZKk1OQ4ONg2PbXQIX+++WdGj/uA2ugORdVINgC3F00WbNuyKlP1D36DUGiC0Eq5aJXhwHTJQik5bpEfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qs2VcFMZ; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qs2VcFMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkcUyDI2UG4a8PfkJl3r4/1xlylblk9p3zcYhtspf08oVF9lJLr44RPjQ6CXYnTvrtVJ9ogzDlWBtaZ0sSMBsV+nsNuYBU/3t0XqNR0JkbuGh8DcuyvedZzK64Y6UNSnMWQf9F6O1KkKidEHxPpvcTF19k1KbSj/stLDNBwup9XhtI6FL8kwVS6Utrru9zyqPkhsJnuP1xXH9s+IXjhuL2IixiEt+XyyN5BgE7Pf/U2bTMo9Y/N+kFibD3LjeZdmKS2B/5LqX/ImwfvpJREn5FQ+4RJeG3+LQjSRYwGZvIh2vRGu2xpq+xpnD1ASptRkuhU7a11pAcXS3qlCSDzTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9er/aTlFNFiou1kZ6VAVAPgbFCV6rdNEPv9DFl4EqQ=;
 b=RljYA28vugHoDOXh5nBzZ6B/gpztGGm5t/KewpI69+6/G9Mlxn3hIgTeIIzx1PK0Q4DWTHEBc7dNsn/srPm0tbLhf232YMpflm+5P5R+4yLgvSxZJu5gfmygRRf6R+Fi3uujQGVsP3cEzQZZ/PFx8nOuXXHnIyrnW2OnWTKrfwLSAnJRU1E3yMf0ns0ugdxblKGV+XPoN9FvNHfEjAJ9DM8p/XUCV5ey0AtJL+EsZcBbAhyPiYUVgeXHXFqiXTM/jEiElkPd3kuKgDePLHBQHs+nFG9Yvb9/sNJij9ZRFed+P1LCD7qgYfQ3tiT7X2IoZsTc3ep1iTcT3yN4BD6zYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9er/aTlFNFiou1kZ6VAVAPgbFCV6rdNEPv9DFl4EqQ=;
 b=qs2VcFMZDcqRfw4T4mr2j6GY/ha/bZ5fn1VWfP6+0e44xq3HoU+ZZ0uGlBaZNByTHxq4hTA+ovWZ7/IAYYN8FEecKWir1ID/o6OP1IkikcQB1PkOtNixkBWR3twMC+/HlbKhuFrLPNy65pqDI3CtR4KKYinV76oqS+GowTXPrig=
Received: from DS7PR03CA0259.namprd03.prod.outlook.com (2603:10b6:5:3b3::24)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 03:17:12 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::14) by DS7PR03CA0259.outlook.office365.com
 (2603:10b6:5:3b3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 03:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 03:17:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 12 Jul
 2026 22:17:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 12 Jul
 2026 22:17:11 -0500
Received: from [10.136.35.249] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 12 Jul 2026 22:17:04 -0500
Message-ID: <b2f1a4e1-d640-4e96-9898-ea126dccbfe7@amd.com>
Date: Mon, 13 Jul 2026 08:46:58 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] psi: Introduce in-kernel PSI auto monitor feature
To: <pintu.k@oss.qualcomm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<hannes@cmpxchg.org>, <surenb@google.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <peterz@infradead.org>,
	<mathieu.desnoyers@efficios.com>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <pintu.ping@gmail.com>, <nathan@kernel.org>,
	<ojeda@kernel.org>, <nsc@kernel.org>, <gary@garyguo.net>, <tglx@kernel.org>,
	<thomas.weissschuh@linutronix.de>, <aliceryhl@google.com>,
	<dianders@chromium.org>, <linux.amoon@gmail.com>, <rdunlap@infradead.org>,
	<akpm@linux-foundation.org>, <shuah@kernel.org>
References: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>
 <20260702171606.527077-2-pintu.agarwal@oss.qualcomm.com>
 <6c190305-4137-411f-ba25-e0a2d8484db7@amd.com>
 <CANqwyPjEAvxtupQK1YyhYE-2h=0==+FumCj48F4FDKCpCvWZWw@mail.gmail.com>
 <CANqwyPiE1vtoGH6Zu==VxBkkwGq_E7-Zswi57msy_G97Rz2xSw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANqwyPiE1vtoGH6Zu==VxBkkwGq_E7-Zswi57msy_G97Rz2xSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 935afc98-bffc-4e7c-78b8-08dee08d3b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|22082099003|13003099007|56012099006|11063799006|4143699003|5023799004|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	po2pj86q4XAO41JnVVrrF2L0Gph29RjM5Uv3WA5eeOsiBiEB3/3ZscqozTdw6fINVsANInPYSyG4TWswiM0fE6T5s4lSxDYx6xJe5hUSgnqNuX5QJhWunIgkj5iaWpcr0xQVYlyOWSWNjq4McCD+2B2fqvl+KDcv2sF/1AzgIIqYWedPOEok9RKOjfBrGDcsj76KJ67RAhCEleDWCmL+hSyt7uyoiH1qedHyc/zFy1H8uAX/A0qfLtpSpPNcBkY5kNvaBbzR33COAdbvlkw8AAlBti2pK9JEdQs7eOjrWtLKWZ0OdBwj/uw0xCY5+xoaYdnnSpR4zssFZFQyM6J1BuhNn4ltzwgtHtWWmuk4iHUt18alFxdR8GbjbJHKI75ZMQhY0jsa7lcqMLv8BZEpeCloJQXR8ydsXde8JzBPuUkKtL21jEleWD64AIQQdFQ8+WDUFkzKpe4j/SsynUM7IiBvTM1QqPm85X/NL0b3sroUxrh2Bou/bbDbepsNXiZd0gfPD9E3nw255kO5UqIDOTHtlCJQWC1lZdQKprImmMl3aPcBIDkTHFQaCG8YocFOI5RPcdsj5SIpvquQA4pZAl/Bg9TCKknAVyABFyuLdgC7DxGfoMPXdbyoZQhArPgpAHthMaeehHsMkwKGRiRnohVqgdvGNezKJkdizwi5dpY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(22082099003)(13003099007)(56012099006)(11063799006)(4143699003)(5023799004)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NyFUbmQlik+CmiotoWmYFbVYObl3Tho9brBa4NRb2q/LWkUiJAvUOaf5C0JkkU/QdKLcoOWHeMLAEokeWulTSlxhuU7raj3+N/lIuSevKKam9yOUyMlXAdXRc7hWWDjEZvvBOeD0LzPsweESSVZFROXRO1+G+hjeJr50BUhRaqvuW1b8WO0v9driI8Yyb+gOSfsbAFW9yhaCgwSHxvS4P8uN2Z8BzVEITy+dNM09j3BDCATRTfAGwUK6XvijILmM+b/3JupzKcu5keD4i7JTzLvfsq8dt6kX6iCFH/wmfJ1Me88rhARaf2OpwIGjwGypN+kixUqP7LNXWbDfqrOj4vfH5xlJTQ/o1iY73bFV+ayhFgBvvR4jCmAyqhNv3V03jqeA6ENavpFtVBz/RT7H+pBZrJSmjus5Vk8gyfLaC+DCYdXkWI8YUUNEGf88fHvO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 03:17:12.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935afc98-bffc-4e7c-78b8-08dee08d3b7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

Hello Pintu,

On 7/10/2026 9:31 PM, Pintu Kumar Agarwal wrote:
>>> There is nothing here that warrants putting this in kernel/sched.
>> The feature depends on sched/psi so I decided to keep it close.
>> But I am open for any location.
>>
>>> Also this gets included by default when config is enabled and starts
>>> dumping a bunch of stats to dmesg without anyone asking. No?
>>>
>> This is included as a dependent feature of PSI.
>> If someone enables this CONFIG as part of PSI this indicates that they
>> are interested in getting auto-monitor stats.
>> Also, the dump will happen only if threshold is breached with high
>> default values.
>> However, for RFC stage I wanted to keep things simple.
>> Later, we can add an enable/disable flag in cmdline just like PSI.
>>
>>> Afaict, almost all of the detail used here is also available from
>>> procfs and people can easily put together a userspace tool if they
>>> need it. Why do we need an in-kernel module?
>>>
>> This is the most fundamental aspect of this auto-monitor feature.
>> This point is already described in the cover letter.
>> Let me put it again:
>> - Get kernel stats early during boot_time before userspace comes up.

People care about PSI signals at boot, and even before the userspace
is up? Why?

>>    -> Set slightly lower threshold and boot stats (helps in analysing boot time)
>> - No user intervention or continuous polling or daemons needed
>>   (Just enable config and start auto monitoring)

So overehead for everyone?

>> - userspace scheduling delays under high pressure

Even workqueues need scheduling. They don't just automagically run
at the end of the set timer.

>> - risk of missing short-lived spikes
>> - capturing details as soon as pressure hits and at same timestamp

But your data is sampled. So these will still be missed.

>> - useful for analysing real-time latency workload.

How often is PSI enabled there. I know for a fact there are certain
locking overheads associated with PSI (like ttwu trying to grab the
rq_lock to migrate PSI signals) and wouldn't most RT be better off
running without those overheads?

>> - useful for minimal environment like initramfs or busybox

Who is doing PSI analysis in these environments?

>>
>> The motivation is not to replace existing PSI interfaces or the ability
>> to build userspace monitoring tools.
>> The goal is attribution at the moment pressure thresholds are crossed.
>> A userspace implementation observes the system after being scheduled,

Workqueue threads still need scheduling. Just because it is a
kernel thread doesn't mean it gets any privilege.

>> whereas the in-kernel implementation captures contributors at the point
>> where pressure is detected.

Again, your implementation is based on sampling so signals can still
get missed.

>> During LPC-2024 I have done significant changes to core psi module
>> to implement the similar logic.
>> But the feedback was not to disturb the core psi interface, instead
>> develop a separate interface and make it configurable.
>> So, I came up with this auto-monitor idea.

I'll defer to Johannes on this since he knows these bits best.

>>
>> For more details please have a look at my OSS paper with data.
>> https://hosted-files.sched.co/ossindia2026/19/OSS-IND-26-PSI-Auto-Monitor.pdf
>> And also the reference data here:
>> https://github.com/pintuk/KERNEL/tree/master/PSI_WORK
>>
>> I am also looking out for someone who can test this on a larger
>> workload and capture data.
>> This will help us to gather insights, how the feature behaves.

I still think periodically walking the entire task tree on a large
server is a very bad idea,especially when people have tens of
thousands of task running.

>>
>>>> +
>>>> +MODULE_LICENSE("GPL");
>>>> +MODULE_AUTHOR("Pintu Kumar Agarwal");
>>>> +MODULE_DESCRIPTION("In-kernel PSI automatic monitor with sysfs, weighted scoring and tracepoints");
>>>> --
> 
> Any other feedback before I post v2 ?

It is the European holiday season so the response might be slow.

I suggest iterating on this only after checking with Johannes.
> Another thing that I wanted feedback is, whether to keep under
> kernel/sched/ or move under tools/sched/ ?

I think the only dependency here is the "psi_system" which is why you've
kept this in kernel/sched but if you can have an wrapper with an
EXPORT_SYMBOL_GPL(), you should be able to place it in tools/sched.

Again, I would check with Johannes on whether it is acceptable to expose
the PSI internals to modules.

I still think most of this is already visible via sysfs and that might
be a better way to get this information. OOMD is able to use PSI signals
and act on it without needing to be in kernel. What warrants an
in-kernel monitor?

-- 
Thanks and Regards,
Prateek

