Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0B366DD8;
	Fri, 20 Feb 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614609; cv=fail; b=OzJ1VBbfY8THMqOJlyHRDbc48LL8fHQ/zk2PNs0GZ/xsY5XKArzZ9qA9hhKAC+aFl09l6MszJDM2ZaOi67YMUWWHugff2ZrgD02GHoNsP4Wdfl5qPU55xvnW2/iPpIiAir8HbmO3KXczK8FJ8zSc19AeCFiNjKU3Upi/cLufZOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614609; c=relaxed/simple;
	bh=mWiu6maSBRIbhcG4JoxhiV+OuKvHz/TaHpeKF6odp+s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=GMjP2BTe2KSZ0zNzYAzg91/qQ16/g67ufdUd1qDcJx8PJliD2OlhDpsxWuO0E2pTkkiZmZfjqhxlnS4eYvBsiSkiMc0LzDdjr4QrP/ucWh1urcMI0Ehtn+TwQ97kxXYGJ7Abj6uJMDuQtlUinfUrQWGYxlVOtP0F9w+zfnOCpLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q3V/7qkK; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q3V/7qkK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkcziv5Tcr9XuN4bz2hC9cxxVHoF07m+jIwrpGH8EktmNyX9ngU9hciRn6zmMJV6q64zS0M7IfA1isTb6YL7YJe8HMoYXHQ1yy8B2TG5rLfoUCUTlJQhQSf8wevFskS+/6qZFou3Vga1NGbBR2ge+/9pFC1s50/8KWMQOC2PHcucA31+rWgFCKxWYEZnqIcWdD+r6WggBJesX05+lDaj9pq5GiJjWwA+sKOBEZDrbmJ2nbQWQCIDZjair++ycatRCOieSVVXY4droPkkZ6H/mR2MRr9NP95KJDjSKQrN5PECA3xRZyD1GjROdln4Rkh3HXZMKcbw4FI343/tRc0M/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MhgX9D2SV+aIHFpxs84pOdm4TUZ1pcYYlhxC1ecMLM=;
 b=osYqWwH+7nEfbxoxUIEfcFUcH02jCoZonoxiLrX9tkDouJytrwKb6k0pr3rP9UwXHqxPs5yBhsEInpFMYcBznLPrwpu8xa7duq6b0K5N/rqTDtNk5LNb36Ht72JgyIDrMDGWujqsJr3jk1tv/8LU9khmKe6QlQmiFt+FEMjFDgdQE9r48h/GzAL9AQZcRNhrKefttf8qahRFgWcD9B1ctYNJQubtNOKG55OLXQGS9mv71fwecVQzfi2V8epfOExWIuDSM+rJ2GN8d3Ccm6D0SNi4hXTZ6aGx7a13Ugnk5bn7xkEsXhPOnrBsgrDA0WqKDzNYnivVAR33dL48XXxLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ilvokhin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MhgX9D2SV+aIHFpxs84pOdm4TUZ1pcYYlhxC1ecMLM=;
 b=q3V/7qkKe7nc8Md2PkXmoxK60L09mJ8tdJ/PTM5eZyl5ZhlZ4YPfqVLRokmsS1lFSvfITikRAPL3Mi/pMve0PmaWjErQiZcLkdfpxu60CNlOQ523TjLZr+cuvbuZmX5N8v4lVoPFqOnaYlKnCK7qrzTzdp8UKBB4gHPFt9jmTks=
Received: from CH0PR08CA0007.namprd08.prod.outlook.com (2603:10b6:610:33::12)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:10:02 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::20) by CH0PR08CA0007.outlook.office365.com
 (2603:10b6:610:33::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend
 Transport; Fri, 20 Feb 2026 19:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:10:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:10:01 -0600
Received: from [10.236.185.70] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 11:10:00 -0800
Message-ID: <06b2a2b6-d5c8-4522-8e22-10616f887846@amd.com>
Date: Fri, 20 Feb 2026 13:09:59 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 0/4] mm: zone lock tracepoint instrumentation
To: Dmitry Ilvokhin <d@ilvokhin.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kernel-team@meta.com>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, Brendan Jackman
	<jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
	<ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, Qi Zheng
	<zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, "Axel
 Rasmussen" <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, "Wei
 Xu" <weixugc@google.com>
References: <cover.1770821420.git.d@ilvokhin.com>
Content-Language: en-US
In-Reply-To: <cover.1770821420.git.d@ilvokhin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: e3982adc-b80b-4a68-7610-08de70b3a5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTdRVUpqYUFLZHlHM3hqQXFBL0QrdkpYQUhoVnhCUXNXdGd0OFI5emZNVG1Z?=
 =?utf-8?B?YlJqUU5jYmpRdUFRTjdVTTJCRlU5THVjSFFwbmxvNjJKWUtNZ2hqWVRVRjI5?=
 =?utf-8?B?aSsxQmVDVklDcVdsUTU0VXhDU0VtdDhyUy91eXB3NG9PVC8wWWhSbXZOc0pK?=
 =?utf-8?B?cmdOTGl0U1g3ZGVjdTh3cFoxREJZY0Z6ZGtuTnBGaUFxWmo1dmdaTWFHVmsw?=
 =?utf-8?B?Q1Fuem4zNCtQL2puaXRoQlJpeWs5TU5tQUdyY3lKM0l0SkdZdlc2YzUybFFq?=
 =?utf-8?B?MUM0TFZTVXd5YUEyUlk3eU1Xdkc5K2k2YUdJN1l2T2RTOGd4dy9MKzlLaFdZ?=
 =?utf-8?B?Rm5GWEFDOGtKaS9SOHdnSFlaWDRnK2ljemtHbU9ZQkVuK21vTDB3b0t6clJV?=
 =?utf-8?B?OFQxYW5VR0JLcXBsdHhXbDcxZDFOeEY4ZGpxc3NyRldjbFl3aUF1QURxSFNm?=
 =?utf-8?B?Zk9sNFY5elJYMG0rYU9MdVhnSmZ2Yy95cDEvK2RUcDNRT1hZODVONzdUbkRY?=
 =?utf-8?B?c1ViVG9UbEJ3ekM3SlVsQVJRSWpERjVSNHBwaVhzbVZON09tVkdWc2FoRW1Q?=
 =?utf-8?B?SURyNkt4TVZMd3hIbzZZNWhiSEZDRzF4Mm9SQi90RVg5bXg2WDdNa2YrSGxx?=
 =?utf-8?B?eWhFN08vcEM5SVYyR1UrczlNZkVObmpacDhSaktLL1ROVmJGNmpZaWhwVUEz?=
 =?utf-8?B?bkszUlhNZGJadG9WV1orVlViMUpBVXRIakUxVndlTlZXa1FRaFN5RlB3SkpC?=
 =?utf-8?B?MnBxQlJmQXJXQVlYdXJLc3ZXMmFIdm9sOHhXVHFmVkYwb29kQTBKNXRZTU1V?=
 =?utf-8?B?bUlIM0ZqaUN6c1F4N3cra0grZXR6NVJYMVp4QThYOW5xZHRYamx0d2JDYlI1?=
 =?utf-8?B?VnFiejZNaHlPVmQvY1lrR2J5YXoybHVUZnN4MXB5WUlubC9XelFucVlVczhK?=
 =?utf-8?B?K3FZenZMVEpITGZDWUlzV2FvV2xzR2JQR0tIVTcvejcyeDBOaExXL201UEow?=
 =?utf-8?B?KytuNXFPc3B1TElpYzZXNGs4bnJ6SzF0aVJBWjExSzFzckRwVkhTenBpUUpN?=
 =?utf-8?B?eitaaFNwN2RBWDdmdkRjZ012TGVCOTZUcWNjUThDMk5RZXFHYVlZQ1AzTUVs?=
 =?utf-8?B?bThCMHQ1d3k1ZklUVXVTWXowTXAyMkRaMWF4SnA3VlFFTEVZZG53ZW5wbm5R?=
 =?utf-8?B?aFpIWUQ3Rm5GVUFUV0VPRS80NVpyaXdtNit2SlJVR0s4RFY3dzN1QWhPQnh6?=
 =?utf-8?B?SHVKUlgvbHh0L2EraE5GejRCdWtHK1JYaXg2ZVI3S0tGbWQvQXJWUTRtc1ZE?=
 =?utf-8?B?OEdkZG1vZ1lVQm90dWsyblZXTXNSL0lFOFhwcTNkclN3YWdPNktYVkRqbWln?=
 =?utf-8?B?ZUFTQll4L0g0R3FCeE1EODhCZnJ3cFNUUUt2NFJLQmMxcGplQ2taTFZ2cDJC?=
 =?utf-8?B?VkdrVTgrWm1CUFViU01RRHJiMU9lL0FObS9VbzNQNFdweGlvL3FoNDBMTjYr?=
 =?utf-8?B?aFNMcnM2dmNSRW1tSEY2QkJXTmVLZk5qMFpsS05ZVDVJY1VweXBRa0ZhY3pi?=
 =?utf-8?B?SmM2VklUMmlyc3JrMk14c2grL1oxbTVFb0QzLzBLVkVkMkhtamVMcWdLWmQ1?=
 =?utf-8?B?dnUvcFBPd1UrNFY0cE1oVExQTjdBR0ovUWVQZ2FnZjVPbEs3WWtabmpTWWVp?=
 =?utf-8?B?QXZuSElRZXpEcHpocVE3VzBHbUNOT2ZmTGZhVDJCcHZEY2ZJN21MZkk4ZG0v?=
 =?utf-8?B?RHVPc1YvWjNvR0ZhdisrMHFTcm1rZ2V3OFJ2TXRlRWtSbERrNFhML1FBYmcw?=
 =?utf-8?B?ZjFWcTd5UjIwNTBicG0zQWUrVHNocTdpMDZ1Tlp0Nkxod1FrMVJLNi9rSmM2?=
 =?utf-8?B?S0lpM3F3N2xZNjBVV3dnRVNSZENTMGRac2E0R2dqcWh2UTF4dHRyN0pneG5v?=
 =?utf-8?B?bWxQZnM0VWlQaUhMeVQzRmkrSXNMajV3Q3RZRjBXelhmK3VBNW9aQ3J5QlEr?=
 =?utf-8?B?RjFndlBxWEc3dk1RU2FuQ0ZaNFVmemFJZXJyMFhSUWlVL1VUWitVSlRUcklJ?=
 =?utf-8?B?VFFzV3EyVS9yMlczd01Va0R1djA0d1paODdEbmhHN3FkOGl5L1V4U3hQMXM4?=
 =?utf-8?B?Wjc3ejh6V1FHakJTRlNpMS9KOHg2TkNPU1J0RzA5aTFQeWhJc1Bud1lNZFVI?=
 =?utf-8?B?RHJScUQ5ZzdqM05VY0UwQW84aDhLTkk0ZDdLM3ZvRlY3NUw3SDArNy9uWm93?=
 =?utf-8?B?SXU0cjZZTC9KM2psM2JieWRqNFhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9pfr/T2pHZZVqwbGwqregqoGjVwJAjDQy/7wXoJ4w+kNVSSDklFDzHGPgc60ukUGOiy3bOl1TzXZsYCCsYVONjZw6XvBKYN2e0V3O8PMsmiZy3FMZtKkya46WsPuUpgtwhnAG0VMNv5FF9vEds1guU0buxixkZiug1UwSKqlLy20eZrR1lULBP+FUDKzG2opxveh0Lw13qcqqgWMpBOX0k/bAnhRxBanxPLD/UoOmmisXdnCleB1sGqJg4j4bl4XQb6opoNl8cIryl1I+us/crLHlLawnEgZV70ITQ5/xaWQrednJWjAZhHGxeEeIRpf2U1TX5/osn+qbSjS5F29h0A7C4vnNYnlxjyKfa6GYZlKdE1ELMu0BgnVvOSs/6VViVPcHCW9inBLD3jJboCsqh7mYe1I3p2NWFprel6pQakyZ/eOPnyXkMf6m5RlixQu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:10:01.8390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3982adc-b80b-4a68-7610-08de70b3a5f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

On 2/11/2026 9:22 AM, Dmitry Ilvokhin wrote:
> Zone lock contention can significantly impact allocation and
> reclaim latency, as it is a central synchronization point in
> the page allocator and reclaim paths. Improved visibility into
> its behavior is therefore important for diagnosing performance
> issues in memory-intensive workloads.
> 
> On some production workloads at Meta, we have observed noticeable
> zone lock contention. Deeper analysis of lock holders and waiters
> is currently difficult with existing instrumentation.
> 
> While generic lock contention_begin/contention_end tracepoints
> cover the slow path, they do not provide sufficient visibility
> into lock hold times. In particular, the lack of a release-side
> event makes it difficult to identify long lock holders and
> correlate them with waiters. As a result, distinguishing between
> short bursts of contention and pathological long hold times
> requires additional instrumentation.
> 
> This patch series adds dedicated tracepoint instrumentation to
> zone lock, following the existing mmap_lock tracing model.
> 
> The goal is to enable detailed holder/waiter analysis and lock
> hold time measurements without affecting the fast path when
> tracing is disabled.
> 
> The series is structured as follows:
> 
>   1. Introduce zone lock wrappers.
>   2. Mechanically convert zone lock users to the wrappers.
>   3. Convert compaction to use the wrappers (requires minor
>      restructuring of compact_lock_irqsave()).
>   4. Add zone lock tracepoints.

I think you can improve the flow of this series if reorder as follows:
	1. Introduce zone lock wrappers
	4. Add zone lock tracepoints
	2. Mechanically convert zone lock users to the wrappers
	3. Convert compaction to use the wrappers...

and possibly squash 1 & 4 (though that might be too big of a patch). It's better to introduce the
wrappers and their tracepoints together before the reviewer (i.e. me) forgets what was added in
patch 1 by the time they get to patch 4.

Thanks,
Ben
