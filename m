Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F313B7AE;
	Fri, 20 Feb 2026 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548753; cv=fail; b=nn1f+sfzORccaYviGKQJVLdrX1bI3V+rIVB7n0f5tsKwuIos/KCzi5Hxy3PAYdTBbMvqWGW4GEI9DTv41Lhn9LZPs2KAtpfMFXmRTF3vN0Logba/IXfarRH5/shwV50xOKYDFjL5MoNItm548vDiKodSsOF470Z9qBwpbDRmxoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548753; c=relaxed/simple;
	bh=CWobktd4TQPP3c4KUic2MRzbX/rmPrVuw/qad9mcOfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fl+6YbyXhlBBtoRgweyWhAx88PJJKR226CF9Yppl4ZHZCmURnnA1dFYCFzwNiln1hVSqZK105oZHBt9tHPOji7jpV5ev3jQfBHYmqFDMGXFX5NqlhOvuDMbNHCxmcXMXcvNPHn2mAOya1T6eT2Pv8p2Xj1sIuVL0dDZEUy9ECBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b7rBYNLw; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b7rBYNLw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkSraFQpV8/dpk6xnNGx2Cg9KkhJIfaGWJzIc+VngJ9cZRWHcfFMr+0+7SB4tpgPeWc2JrTqiTddfYuhjMKBJNGacUPCcwDEf8v/G9qAar4nWWIJq5ZmHXoYihescVpdhq0MPHahuDdsQofFA7eNo2XYVdC9qEWWmidU9949fACx44YaXFNu13luk0ffbrGWTm2BFzmEmZfXv2+R2ewU3fBaFTNbXbqWKeNkjZeSqmA/CWoT7Exws60C7W8a1GiyYBSw3Mo1cuFx0D8x8aG/nLcoYQholxr2HplV9QEKiUwE01BMseYFHgn8OD1+T6wIqxFDUQtwald58xbgGax6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq1/6VI3rqa373X13Mi1BH2INOvmwKrjiJJpMw/gYKk=;
 b=ebyKnKwsGg8gCsrERdenaq8Uoyo5EF3qNAtyTxvLVXR+oKMbvy8Hm7NtM5+pdrpvfn28WmxvXe2FxuXYe6fNZMuwqiGoRZH1R7ckNqVQqtBOISA8UUz5T3mWXljSVGd3RhNDawJwobTXkBUjo1KWzlIu3ANkxilEBejugoxW1G7PkCLYWDmC5KVWCWnuLozh/BUivS7JVspUFFJzID2WNepCxt0ECHwktAXUu0QyLZPVtMatw25BZNl3mV5B9HNESpztNAev8GqsNJk2+u5ipzxvPgA2Xd8r7wQFTgLbDskiXhz3s0AGvnS+7M/CFZWmy2QgPulQKx5utt88jKw9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq1/6VI3rqa373X13Mi1BH2INOvmwKrjiJJpMw/gYKk=;
 b=b7rBYNLw8DBFY9YsnZZP/B46NGCoNZ80mYJo+Lr1d/utJv9Gk8AvdfUJGo5nb7HYFGcEughflxSWPWsAn608PItmmRHVRpKhbKHxNRPBBmeiQLLU4DTutiUHKVJa/XYfALaQMhtveKULGoa4cId9lRJ5ayTcsP1HyIXRZNHMJga6gIzP4mW24lBqDfnxT8K6oPIECXmgqbuxCmp0qAuSfZnYnf7ij8PoocIjlzVSpJ3ROFIh/BM8NGd8LCGgaFTQKrvY2rjm3U2Ia7i4AWnii1fuzu0ZbrG4IO0FRlQ3Tnexi6euNlphgggChT5k0nns2JM90vqld48GCxXFnsxGgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Fri, 20 Feb
 2026 00:52:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 00:52:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org,
 kernel-team@android.com, android-mm@google.com,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Minchan Kim <minchan@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 Wander Lairson Costa <wander@redhat.com>, Petr Mladek <pmladek@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/tracing: rss_stat: Ensure curr is false from kthread
 context
Date: Thu, 19 Feb 2026 19:52:21 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <0B29A60C-51E4-4430-80F0-2119276E92AF@nvidia.com>
In-Reply-To: <20260219233708.1971199-1-kaleshsingh@google.com>
References: <20260219233708.1971199-1-kaleshsingh@google.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc16ed7-7813-4676-8709-08de701a5161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qTtdxywootpCpwRFJFUwpfyy2bGmhrgQjs7wGeiJEgCNMk6Y7kZuLklxQL4o?=
 =?us-ascii?Q?3RYc38cqgHOoBarfaik8nVbNXZkDPHBNg2fw6DUheacgjgF4OoqcuMI6NgMm?=
 =?us-ascii?Q?UMggoQrE+Qblv+sYVkbtjDKLmJaFabvGQNWRVK1rmtf1RJZPm+0x5tZAiLEp?=
 =?us-ascii?Q?U9MWYVB4AR9pFRLi2r4w0IGa+GVFm+LbfyRvlhh/gUcOjDJp0lEaFfjKILD7?=
 =?us-ascii?Q?Z9Hm7HP6P6VdhWDF3UGQK4xuVlwKOdZN90lOladu5VHooAVUcowUg98SvWeK?=
 =?us-ascii?Q?UMwSRsRWEW7BNfPWOSgd5gXWjeetE+g5A0+B87PPzlv2Pj+5MCz4hAXO3ksO?=
 =?us-ascii?Q?VQB+H3rxMw0lVJ3+MOBMHvxczFfQ05xurp5ZA8g/x4es4Sw59dMjP+Bhxshd?=
 =?us-ascii?Q?BcoCTkcJLwXW8Q612GHHF+Q9SnydjrCCXppT6/OGGbeiGL6VIUYpFeMvYaMD?=
 =?us-ascii?Q?yXkV1/4nyvyZD7S16pSqOM+ZUad0gxI1rVIVxpyC8eY0CscLhitLVMyjN7Z3?=
 =?us-ascii?Q?xeHebsNzzG6cokzOD6fS75BGUiP+FyIP61W3U51i3uFNLWATQhlWomQbbj1K?=
 =?us-ascii?Q?y92O6z8nxi8zWsz35pdTeVFWPishEHqzHrnY7XN1r2a9J/8/fcGilCi3WM05?=
 =?us-ascii?Q?5gidGNTNgGDxHZQ6/JMdMmEvbSTtlSbhFMby9eH4136EcrbF30ArxQxAMZD2?=
 =?us-ascii?Q?8wg38GBzrJAizIpC6pk7GqLoWQ3Tamfq4kf6w1SfovsfemlfLtUCWIeZYwOK?=
 =?us-ascii?Q?9BUFQoHOFOPcYRsLyHfW+B0FqU0HhT50CsETAtoMuDzIoBAV2mNCT3avN3mK?=
 =?us-ascii?Q?70h58FL8C8FbxBEmwNEO8avUD62hLVY6seW/uRoeFaIFrQxUUt11OV7pRjXo?=
 =?us-ascii?Q?Wef/Lvoh3u/Pt/Psk0tx3aXqadiG38DwUsJ8CROSmtMrxOiqGPuWUbyQHTzL?=
 =?us-ascii?Q?u/q9xLnO/pviwIS0m4WRKZIklbUolPl+mC8wGnOyb0vuglkMiAZOUaYWO7Jb?=
 =?us-ascii?Q?zmFtTOCfoiRcMvoSv+Xkpk+4LswkdVP5TMug1pt3iK77XhWgWzrVo4lIMm5m?=
 =?us-ascii?Q?9d6Vep0COqh+RiGj7zK72p+F+drPw8iVFPszmu1xhLEoacs6ulDNuZMVkaJF?=
 =?us-ascii?Q?VfkFjP+pwN0q6HsIqhHusC9xInEvwqdngU+nZkkmlhPgAyCT/gDTAnE6SDXZ?=
 =?us-ascii?Q?KCMOUvJKFb452OVEZHQy9Nhuw8FYoXf+cAENRAtkRcIcPeMwTM9E5folEdWh?=
 =?us-ascii?Q?MojupWzsfhY4TZJnxlq00BLeMBJ0+OIORy4QbwN472Hzzg4kxJbl0hRn8p0o?=
 =?us-ascii?Q?CVh7LhNJdwRUc3SenjdxvSQfeQLENfqbgL2amGw6kOHN7p7LMRWFoK5CQrGf?=
 =?us-ascii?Q?LFeExJ5HTZm+svKtf1FLaZ0k0casBuNNJ9w9x370CSead8+gWL3AzQ8d9HcW?=
 =?us-ascii?Q?WRmfoW1WFuiDQ/zTWqOICExY2DrSQe85Xg/B4k+nLLu1J++X0Ql7MRZc9OK5?=
 =?us-ascii?Q?Ky58x5Judw8RsyOv/EKIyhw1876wns8LgmIOFVTa5wENwtYf1OvPceOh/mdc?=
 =?us-ascii?Q?C3GWDweftwcAlgYoZcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rPrNhCVTWSMkXzUIhwWdvvcIqIN8Pd2ELvrO8mZPHZa/lci4VZhjiebs53TZ?=
 =?us-ascii?Q?RahzG0IzQ5OuPCy0Ht3fg7n9vvl1Q/Sm7+fieRew8j7wsVtnVIqvn2iR6tBP?=
 =?us-ascii?Q?vCEUDzjbhd5Y05MwUnpMsZywlFxvKzpHvHLtmXw1Am5SCrTVaqUo/eibfb0R?=
 =?us-ascii?Q?OFG4AvT5c3kd1VwnAS0NHH3h/11sEFS38xTVYmklTkJo5chnoVrPSyG0aoN6?=
 =?us-ascii?Q?sHrbvtsUw5aRtyZBQgSazdxnrRNPJZQlOVFnNaPqJBreBsSLZmiVaDcH3ty3?=
 =?us-ascii?Q?LrgKferRjWxd8WmuGDz0wL9TDobGW1dLSgcYyZ9iWQ4vPjJHflOo1wIaG4VN?=
 =?us-ascii?Q?vmiCRNBTx7+vOSk7eMUZoyQRcor+Zle66Ahz+aTln+4iPsJHKnnnLQA6Sl4s?=
 =?us-ascii?Q?zyCeWOrykRpoj/r3Walu8GyC8RYe3FRVigomjH6CvnC+L0hvPEpf/e4oZEC+?=
 =?us-ascii?Q?S9245a/2Vk+EdmaUu8Qzk22Nk4ImMOtAHr4aX8x3zx9ZSeGTFd4A2jiz8omf?=
 =?us-ascii?Q?v9UAsSDZj/I4T5DkXvZcZJzSmyWcTbvFG7MJeJhZrb4qIEQa7pTCxulUNjEs?=
 =?us-ascii?Q?OPDvz8O/+BagkuLhq0u2dfOn7e8uG1DrkVmAGDgJwDHBRQ1KBpeileoSv7EN?=
 =?us-ascii?Q?6Z4QDxyrE8uQAtk0ZFiGl7ngCI3vbPHJocnBYU1A/SyYLIjg49g2ofP9EJdG?=
 =?us-ascii?Q?RfYep6bV00o4FkzfcHIX4jfc5NQUdKA0fmnrZhsOoqTXUtsxYnp6MTEoQT94?=
 =?us-ascii?Q?AzSe9QZ+6vDN9dTU6/aKzoWTzLfjSdV4MRYeHFSxMlv/L4cVRpWtKMQlEABm?=
 =?us-ascii?Q?7c+3K8EA9h0tWtWNLYiPeDjaIzjjmyPStp+BxeZlAzXWbR2InaKUYGsZ7219?=
 =?us-ascii?Q?uswmaoWFNLlr4sqq9aGp6FLUf5DTAltpzuZDdulewdqBjxE9XJT+KKFNLe26?=
 =?us-ascii?Q?Ul/94R5gzLHVTffXmoAB41r2BvwQWE3hPetsryw0kf/9hveiMsEFMlxRiBXf?=
 =?us-ascii?Q?HnZfCImZ+5DDnJc1mhxow/ZwKOXjFs7EH0f11Jm5G7mGvA16Et0q+exRh6me?=
 =?us-ascii?Q?gixpLo05T/FqLRi1g1mfnAtdAkhNImxgghVt7WUF/yxI/Bh2/IvCXXD05sCW?=
 =?us-ascii?Q?tsmNr78Qb/TqBiKkluRUgnrYz2wmdVLLaSV3rJa9r+77hsH1pTHhSQK38OPj?=
 =?us-ascii?Q?SoYdgj3oBz1LELvzHKnTmQiySukfOYcxjUy8b5dEqdEbNwBqJc3zw29bbiDy?=
 =?us-ascii?Q?J9HP5Nk+HlMKuccjhbg0/Csg3wwz2LZUPRwEPTRNATU/5CZalVqxSVjFy96o?=
 =?us-ascii?Q?/A1WfU0td4yQtZHL+Gca/MyRDyaJC4iHJNvQIAGHfIdmnJpt76Gu8Ck0gHhK?=
 =?us-ascii?Q?O9rcQvZrYI4nsPlrH2zZeMtehkrF4Psotw6qEEx0UUYGEOFziloOPJ/M2UIa?=
 =?us-ascii?Q?Ron4STCCPpRqZtFT/tiA4kpEjleL+gwdbITlRLx6arPt96BdUSa55B2qqjGL?=
 =?us-ascii?Q?WaIB6Lw4ycGaU2r4yCNWcvASLrrYUqoT8XiZCd5v0E2rQkaW5txDRAI8c8GQ?=
 =?us-ascii?Q?nNShqquOY3ipQ/bSedfS8YBug+xxCJCMLLlc8BQ4vJAvF79RY62UspZxzmil?=
 =?us-ascii?Q?NA2rlLjJ+kJoytyJWRfoAVQA27rvX2g2++pyAUanJQ/r+f9U740voIKTxPXR?=
 =?us-ascii?Q?m4aT6G1LBwxaPhKAhdaJ2x6pSUT643Sl4nlu8AjZ1vneaci4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc16ed7-7813-4676-8709-08de701a5161
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 00:52:27.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEQaL/PoqbEoRCLqhViWVOxC4xJ499OeKqhSztrCTmXw12b4Q2bXB7fLvLblHDte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

On 19 Feb 2026, at 18:36, Kalesh Singh wrote:

> The rss_stat trace event allows userspace tools, like Perfetto [1],
> to inspect per-process RSS metric changes over time.
>
> The curr field was introduced to rss_stat in commit e4dcad204d3a
> ("rss_stat: add support to detect RSS updates of external mm").
> It's intent is to  indicate whether the RSS update is for the
> mm_struct of the current execution context; and is set to false
> when operating on a remote mm_struct (e.g., via kswapd or a
> direct reclaimer).
>
> However, an issue arises when a kernel thread temporarily adopts
> a user process's mm_struct. Kernel threads do not have their own
> mm_struct and normally have current->mm set to NULL. To operate
> on user memory, they can "borrow" a memory context using
> kthread_use_mm(), which sets current->mm to the user process's mm.
>
> This can be observed, for example, in the USB Function Filesystem
> (FFS) driver. The ffs_user_copy_worker() handles AIO completions
> and uses kthread_use_mm() to copy data to a user-space buffer.
> If a page fault occurs during this copy, the fault handler executes
> in the kthread's context.
>
> At this point, current is the kthread, but current->mm points to the
> user process's mm. Since the rss_stat event (from the page fault)
> is for that same mm, the condition current->mm == mm becomes true,
> causing curr to be incorrectly set to true when the trace event is
> emitted.
>
> This is misleading because it suggests the mm belongs to the kthread,
> confusing userspace tools that track per-process RSS changes and
> corrupting their mm_id-to-process association.
>
> Fix this by ensuring curr is always false when the trace event is
> emitted from a kthread context by checking for the PF_KTHREAD flag.
>
> [1] https://perfetto.dev/
>
> Fixes: e4dcad204d3a ("rss_stat: add support to detect RSS updates of external mm")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "David Hildenbrand (Arm)" <david@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  include/trace/events/kmem.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
