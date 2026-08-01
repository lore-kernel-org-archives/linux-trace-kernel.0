Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A03C8C48;
	Sat,  1 Aug 2026 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785550642; cv=fail; b=slUeKGzGo+f5hcno1zSrS1oZCwze2t+19VP7yibSm9NFPvk6kXGiqxPNeTgqeeKsuy5jMkb/e8zfTAO2LtQ41EDdu3fwI5do7OdQaR0iuvMYpgDt+UIepQlfe9D2nLaZsOP1IZ9TJgBH9XHqa5IJ0WD3V4exmOpKYNlTqoh1e1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785550642; c=relaxed/simple;
	bh=2rlQIt/qPCvW4iHWkYekXXXFglmQNSVlBIuRAaHkIuY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QTzWgvMonBav4+14AJrG4l91t1sWIRyovn89FOJdZF0spZBPq+WY1UERLhsrbJdFwjEH1aslEqUSdg8158q/eF7nVSq8enUby/SlHfKmcA2wrkh7S2d16amyTAMXNZtIjJXrlVHTYl7BIeKRRKzJ8aOuqsDZiLET5jMEPlE8wOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YmK9D+SS; arc=fail smtp.client-ip=52.101.61.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YmK9D+SS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD4g4wk1ttey5MTQbK/vItLjD1bSuNLPdkONHKbUKvLnwrcXocqBpb6XhvFpyPFMpZqihC25jyepv5FaQcZoN0RKQa1vFlFJJLCVkuGimbospn3DM+RNh+l6aKLsgVUAecI9QqbCw9necZCAncZiOq9jfuH1UL3pc5Exhv9iNHaZDaja4G3gF2yrSBzI+bIjQqjbrotL5H7va01gc2QOcSR2U9aG6uqC1OGh4FO/d1jxqyWh0YiYnGPYW8Qp24uGvi2DjwIdz2tBNx+vuHoNnbMIBzSoqFjEqXJFVZcIvk3gmBQDUS2OZGONQTE6Lv1i6GagTVZ+1WQ1MyMCpTx66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QkUoXorDthlznC/aydCAoLmJxnU3u8/BsWO/tbZ3xM=;
 b=sA0Zx7ZQxOSwUZ1H6jZJmivAX3qlsGI+BCO60gm3xEvsOIP53YojNDbkgr72Zvaufq9g3ZsCpmMRWBQxvRR4IDZmnd2hnKGfPu9yd/AzxWj0gILI86CTWWYc30hcP93w6mcvc9+NA3jI1uw15oXyxKqSN3Db4X2MpIe5hyoYQDz5+JP/nTKdWlAPJd3KJCJ0r6vDRXWU+ymCJwkhMnZI5kneSpwINP0Q1zfA7771QONLvrHnvSQ39u//CLQ/pGb0oq1uerJeRA6HK+Ma5uiW1C1iEYHSS6BwYYWyck7vW/hiXv/ENAmlnNzBEn7SaOWmHBwYrtxeOkjuFo2VsBvBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QkUoXorDthlznC/aydCAoLmJxnU3u8/BsWO/tbZ3xM=;
 b=YmK9D+SSYgm2WpLJReodwBIwBpXhjO/e++B8tnuCzvtCfTlmnwA9S0lihNeuMSyaiKl8B/rREr3t9QSFHbvlfvpMcPbPjALL/wl6GnE3blRwAHDWuYODtvSUIhv652e55hr+7mI3+snuBJ4H4A/XxOsUU5PrSrdtg/IWUjNwfzlVRz49t0TWJnwE1Z5aCxQLXAmG/BPJTsxS1nUIgMOwuUuMUIPX0GH88Qd11Yc9qsmHPST+EmAGTKDSZJir+WQTsrDpQNd6TSGUkKqdHS2bxTeS55OSgPoAkJoZkjuzXLdQTJWYk3oL+dj8VVBus5BVekf8EoXH9nOwPR+BPxIHYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 02:17:15 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 02:17:15 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 31 Jul 2026 22:13:33 -0400
Subject: [PATCH RFC 10/14] mm/page-flags: introduce folio_test_fs_private()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-remove-pg_private-v1-10-142c97ba3562@nvidia.com>
References: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
In-Reply-To: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: YQZPR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::7) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 555700fa-23fa-4105-0152-08deef7300e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|11063799006|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	mY1cXFMnqHJZfDWFOr4Th7Jt9FRhaB4o73frKciw5rz0UHEmyk+DAitIIGKxbDUF/6xQfosRTuMeVJPfy35kSZhFKlloSz1XekT7sdgO7TiLtGSFAqn+2hh9r5HbhHa3sFV5yRbPGqiqH+BxSB8BL+VuMxBk3qTSXQtUEKEgsfcR2cnO5N+i0ww9n23Vz6vaUJ0QxQBM6fC2zd7hjo75utoa3Y8csB7zkKynYmiXewlA/KSRsq4HUact1Fk6khE/msGPAm3+ymbPRX/OIuQQqPCfDDjrKTTu7KM5hhjQSGJJ86egEckqDLGm9hdKSYUeC/hCZV/P1vhFC5q6C/9IcPG9vZIDxZoklk6QzU83VxBdJOABTseh3TD0H0XRI9tZRRFhW6piN/bpX1sNJOYaBnGavIy4mdwgi2DDJGUbyo7sdMR/1N2sYYUQPFEqdFJlhQMXcZNfkBmTUyMtS9VpfXdoqTGcNT/Yh4kseaChBQ6S3Nutye/RXEiOeQSgQBR5S8msUJ8nn24gj2xi3Zb49x6+ROcCSFnV/2dHG+Qgy5Vqayhla8Uk1WKd9wbBwIzA58sbo+Fz94u0U/pe/YRaDOwVjYo04a/dsqeHpio7nZuZRKTaoWn08EhPVS6Q3hqckLTsAnD33//L+MJsm0USzHlhTMwnZ4eovGZ3M29NEVw2e9otFzngCoKcTKDckSAq3xD970oUL+iWT1ATI0bcQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVpNdUtkNHhseDVyajBFOEk1UndycU9zUkp2ZXNZY1U4NEQ3MGJGMFUzVFIy?=
 =?utf-8?B?c042dGtkMnh2MVJPUE5YRXhGVGFMcTAyckhwcFFwWUR0RGFvMHgxU3VmMGRm?=
 =?utf-8?B?d1dudG1wZUVQUDZwdUs0M0xHeTFKMERBV0pHbFFkczlxSk1FQlJmeDZGUGha?=
 =?utf-8?B?eFhsSGpaZ2NBUUU4Q2w5aWdVUmxJU2Y3QXN1b3ZhVWllRVdZNjl0cGhJbWdI?=
 =?utf-8?B?dlVxYkZCQldqVFJHVHIyOGQyZFZ3clNuTldIcnBsWXBFTTFHSzlBc3R2L0Jr?=
 =?utf-8?B?Wm5PcDF1S3JjMytzTUlhcS9HUTZXSHJMVmlLZGs2dTljRm50dGVBV3pIQXhC?=
 =?utf-8?B?Y3VzQTRkdldEb3BXUUJSMVMzVFF4dzg5SzlqdnIxVzRtUmdQOE5ZWTVGTXF2?=
 =?utf-8?B?dERCL2tBYW1xYyt5OCtOQUdtOHZSUU5LSUNiQzh5dGw0NmJHUmZyZzJIUjVW?=
 =?utf-8?B?YnpqK3pEcmRVci85YWltZnYva3U0Vkd2czd1TGZmMTJKN2dOVFl5cXIvLzBp?=
 =?utf-8?B?ZWU3UUNLT21FNFRQYVVydEFjTWNNS0tqaDZENEtGZnRxSkljN2NFeCs1UnNq?=
 =?utf-8?B?Nno1UHp6NzI3Y2x0dEJkSXErcXNIaUswYjZXSzFtU2hkNjc0UnRncUhZUHR0?=
 =?utf-8?B?amtFSXZReUlyeGpqdkErV0NYQjNmZVR1YlRBUnpwQmIyTXhZWjRWVEU5SmR0?=
 =?utf-8?B?bnUvRWtnbG9wdTdjdnFBYlJkTFBwa3crRHcwWHQ0Q3A4MktMY3BmcVVHSnNx?=
 =?utf-8?B?T0p6YjdKTzdHUU43MU9YLzN2SCtmL290TGtJaXNyUEdoL2VrWldmaERUanlH?=
 =?utf-8?B?N0JCQTF1c0prMlZ5WW5UcXo2NDB4aUxZY093TW1YQ2NyMkdBVCtMU2s4bjI4?=
 =?utf-8?B?SU1vYmYxTUJyKzV2OERWRGQ5cktSWE5PdjhCRzZhOXUwZHNnSk0wNEY0a09M?=
 =?utf-8?B?WmxGVHJjZi9Uc2krUFlwa3B0eHpWQnhUd3hVcDI2NmYyWEtRemQrNHkrYUdD?=
 =?utf-8?B?K3NWL0FSVzZ1WXRGL3ZtTzB4MFdaaXZ2cTFuVHNYY2ozODRFTVkwSk52aCtO?=
 =?utf-8?B?RG94VWhONVh5ZERYTEJOVVNIMm9KV1hQMjlwNzdmclFuRGZqUzMvUzdwM1di?=
 =?utf-8?B?ZUVFV1dYTWF5aitQaEM5QzFGS08xVHlNdTRJeWVGMTZLQ2hHaFkxM3IvK2lw?=
 =?utf-8?B?VVltRGRjdHBqNTQ4RVg0OTMwWFJHMmtDZkJJRXFQb0thVWsrOTkydFlxYnRS?=
 =?utf-8?B?VlJjVDcxdnNIdDhPTHZYTFJkejhmelhEWlhLSHZmWDg1V1dmeWpwNGFLbmw2?=
 =?utf-8?B?bi8rdDM0VkE1Mzd5QlQwK0hITnZFbENwQmluc0JNYXpIYVRBd3ovRzJPV2pE?=
 =?utf-8?B?VERXajhwVVZzOE1rZXF0ZTEvRzhZTUZySEwxaytCSGJNMUt3YmxHa0QzTU41?=
 =?utf-8?B?TE5NSk9JUlYrMWN4RE1Ta0dUR2ZHZHRROXp6SHdQc3Q1VFJOdFNIZmJRREpv?=
 =?utf-8?B?aytCblk1c053SkJnSTBUbGVzU2VaUFN4cGNsbFZKUGFlOWdsRStCZUd3N2FR?=
 =?utf-8?B?MVZjZWFKQVc4TXltdkVIVithVWRuNk9wa1R3bWowSk1rRll6d3NqdWlGVFdi?=
 =?utf-8?B?SHJNVWx4MDk2Z1UxaUZJOUx6RlBpNFdEK0ZEQmgzYmJZZEE0ME9jRWJsd2hV?=
 =?utf-8?B?QTZrblhBMS9wSzVqQUpBRjNIV0FaR0ZMT3Z4ZFhLYktMN2tTWm1ybU9kS3Y1?=
 =?utf-8?B?Yms5d2VraC9lV1l6TWI4Z0F6dWYvcTlGbVNmWm9UL293SU0xNlFKTnBIeG5U?=
 =?utf-8?B?bzdtMWhzZ0RkcWtCRlhXUWoramNnWmFJeEYrVXRQQ2hud0dFcFJ0YkJmRFhX?=
 =?utf-8?B?a2hjVEQvRTNBeHVRbEJlUU9La2tBWmMybSt4bFI0M1crMFlUQmExUlI5VlZD?=
 =?utf-8?B?a0tiZDZ0TWhpM2laY2dhUE16dTIyTmlSY1dNWTVHM1N6N3M5MFBRQ2xEa0tx?=
 =?utf-8?B?OU1nWUp5VHJjU21QOXFRM1QrUjhwbUx2UGJwYWFNSm92R05YdnJYbTkvYldn?=
 =?utf-8?B?M2lQQjBUYjg1V2luN2lBemFTUUdFWTdlN0wvV2l1NHlmcW9FZkQyT2xoMk1B?=
 =?utf-8?B?cVVIQ1lTWVk4UERYN2lCR285NkRpUldkU00zVHk3R3h3NHNMRXovUFBIREhI?=
 =?utf-8?B?M0R1SmlHQ25PdVhlU0Q0N1I3WWhwVU04Z2xOeTk1eGV4cFdyVmVaSlBuL20v?=
 =?utf-8?B?MS9VZG1xQzU1ZEd4UXQ5WkpETTlpSUpiczdIT2Y0NC9naElOanVCaXV0RENn?=
 =?utf-8?Q?J82dQeuf4lun8BJJVl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555700fa-23fa-4105-0152-08deef7300e9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 02:17:14.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U45Z6w1oQXDG/x1n0B48lsrtUxoEujxf0JsFsKG/lOWQ03HHXaY1h1EdL5tfvGzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373

folio_test_fs_private() wraps folio->private != NULL check and excludes
swapcache and hugetlb folios, since swapcache uses swp_entry_t overlapping
with folio->private and hugetlb sets its own flags in folio->private.
Replace open code with the helper, since core MM does this check
frequently.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org
---
 fs/proc/page.c                 |  3 +--
 include/linux/mm.h             |  3 +--
 include/linux/page-flags.h     | 21 ++++++++++++++++++---
 include/trace/events/pagemap.h |  4 +---
 mm/huge_memory.c               |  4 +---
 mm/migrate.c                   |  3 +--
 6 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index abfa6f7d890cc..aab0e20b8f9fa 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -234,8 +234,7 @@ u64 stable_page_flags(const struct page *page)
 	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
 	/* preserve the original KPF_PRIVATE semantics by excluding non pagecache folios */
 	if (folio->mapping && !folio_test_anon(folio) &&
-	    (folio_get_private(folio) && !folio_test_swapcache(folio) &&
-	     !folio_test_hugetlb(folio)))
+	    folio_test_fs_private(folio))
 		u |= BIT_ULL(KPF_PRIVATE);
 	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
 	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ebc035ac26ccc..a93eaf7aae545 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3004,8 +3004,7 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
 		/* One reference from filesystem private data. */
-		ref_count += !!folio->private && !folio_test_hugetlb(folio) &&
-			     !folio_test_swapcache(folio);
+		ref_count += folio_test_fs_private(folio);
 	}
 
 	/* One reference per page table mapping. */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8efc61f967302..0e3628ea080c4 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1210,6 +1210,23 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
 	(0xffUL /* order */		| 1UL << PG_has_hwpoisoned |	\
 	 1UL << PG_large_rmappable	| 1UL << PG_partially_mapped)
 
+/**
+ * folio_test_fs_private - check if the folio has filesystem private data
+ * @folio: The folio to check.
+ *
+ * Use this in code that may encounter swapcache or hugetlb folios but only
+ * wants to detect filesystem private data. Swapcache stores swp_entry_t in
+ * folio->swap, a union with folio->private, and hugetlb stores its own flags
+ * in folio->private; both are excluded.
+ *
+ * Return: true if folio->private is set and the folio is neither swapcache
+ * nor hugetlb.
+ */
+static inline bool folio_test_fs_private(const struct folio *folio)
+{
+	return folio_test_private(folio) && !folio_test_swapcache(folio) &&
+	       !folio_test_hugetlb(folio);
+}
 /**
  * folio_has_private - Determine if folio has private stuff
  * @folio: The folio to be checked
@@ -1219,9 +1236,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  */
 static inline int folio_has_private(const struct folio *folio)
 {
-	return (!!folio->private && !folio_test_swapcache(folio) &&
-		!folio_test_hugetlb(folio)) ||
-		folio_test_private_2(folio);
+	return folio_test_fs_private(folio) || folio_test_private_2(folio);
 }
 
 #undef PF_ANY
diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index fb9abec40ec79..5425ef7bbae6e 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -22,9 +22,7 @@
 	(folio_test_swapcache(folio)	? PAGEMAP_SWAPCACHE  : 0) | \
 	(folio_test_swapbacked(folio)	? PAGEMAP_SWAPBACKED : 0) | \
 	(folio_test_mappedtodisk(folio)	? PAGEMAP_MAPPEDDISK : 0) | \
-	(folio_test_private(folio) && \
-	 !folio_test_swapcache(folio) && \
-	 !folio_test_hugetlb(folio)	? PAGEMAP_BUFFERS    : 0) \
+	(folio_test_fs_private(folio)	? PAGEMAP_BUFFERS    : 0) \
 	)
 
 TRACE_EVENT(mm_lru_insertion,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d21a9b8f40d15..7f8e99cdeacb8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4799,9 +4799,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		 * will try to drop it before split and then check if the folio
 		 * can be split or not. So skip the check here.
 		 */
-		if (!(folio_test_private(folio) &&
-		      !folio_test_swapcache(folio) &&
-		      !folio_test_hugetlb(folio)) &&
+		if (!folio_test_fs_private(folio) &&
 		    folio_expected_ref_count(folio) != folio_ref_count(folio))
 			goto next;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index ad5daef8721cf..014fcb745d210 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1330,8 +1330,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	 * free the metadata, so the page can be freed.
 	 */
 	if (!src->mapping) {
-		if (folio_test_private(src) && !folio_test_swapcache(src) &&
-		    !folio_test_hugetlb(src)) {
+		if (folio_test_fs_private(src)) {
 			try_to_free_buffers(src);
 			goto out;
 		}

-- 
2.53.0

