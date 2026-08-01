Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006C3C73EA;
	Sat,  1 Aug 2026 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785550640; cv=fail; b=YT5srgk8qH2vcx6LUKSM8+zmHScCIRM9JUpMYTKytN6eXgJ+LdNjDSMWHAm4iJ7dHWUfZSaxF41HPNMLHuKWbNmJptPWuwMY2xtpDAaHVb/pPxYCtr5mmPf/xz98ULfMjvBT73GYMvN5Q0CmsNPumyBrX4TOKvDl4OAGi454uuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785550640; c=relaxed/simple;
	bh=wEswOiTbZx+kaa8gIz46hWdl9AlGstYHUwyRcca4hm4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oMf+Myp71z6hMHqeoiu6kf9I5X2wekc6cEXQUM/ZVfLtDKwEnUX3O9BxKFfujaRlraVdibqmvBeKGK8gs1Suve02e55jSo8B6ja9itZpdA011eL24pczxTFSOl6WOO+4oT/hiMIlcHk0kP2XABJ4Vz4iVfl5fdqpUDMYerxHrbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V7+fAAvw; arc=fail smtp.client-ip=52.101.61.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7+fAAvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbGxXhNqhqciYfrJrT+4pIEbvJiIw82PNZRMXUdPr0sILKYGJzhnIht3Bnk38obhpcHYLPVDROI7m5Zhjw8GCS59o/Jc30Rw1xhMmkW4v9eytQKdP1acM988Erx1+7ZkKZwYs/ZbQbx9AJbRkR1WgIundYccYWswCe3c/GgKXbAspFpMy+zGaViBvlqMA+HIgRAuIMY8ZkcwzyaZiIzblo4LvDNdLYqSkvqSTXwA8f1IHLNKuo+khRWiFSU8/LBYGdfta0xXSEzYu1d+j2Nv6XgDewBr6uJIvDpTEyilzFkoQCJpUqJtRFnCEkj6gIAwnRZ7WVe34WQIIXjv6jeGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve3jazNzqzZLcEb5eDxPBcYbxu+FauvcjmAdxm+XhOE=;
 b=cgC/pVP5TR3AC3QGsxnC0vh/XYrOh5hZzSTcEbqC8KuawZDArfNZqFqy4H2FIX52z0lQI91FXeEyV7wcOHfu7HLY7nPHxLAYLKPpSU1ZzDBxbBMWHrPxijRnvc5W/4qdZuPzptaNxr3mxAf4NVwUSYfhHiwwzYZWUs+v5V1FHdHo5BJU5QbetN+4g2iCbBrY0x7XTQWJNjwvfx+rSySYoT6RLRV4KLxswrK92herYPxi0IgaZBZoYqxZo7jJAGAqkW9FBuNfBBcBts9qebaHIgsQkaeYZymeHXdSlBve8KKrRFFOZZWhdICIX3F0NkG4X4ML05Vd+F7DFkLKTA1erw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve3jazNzqzZLcEb5eDxPBcYbxu+FauvcjmAdxm+XhOE=;
 b=V7+fAAvwwk4WuzJdQ0jIA0xuEJchU8eab6bg6QvKhv1suDbmJDSPPiCygBe5FwEJxbwtsC96E5Pqn0T664HKzN8BQ79LNOzsiUOmnH9BTXzcFdZKcvuAOGnGa4zqwz88surhqRykN34MhYYWBhukm4H4HXi9aNTNji2F6t8odr+6IlmaIjZs/Mds7RRO8DYaRImNdLZ4uTvsECqtMX7HzsAjnHE3a2OYiEm8llPcCc8IgpNsp4x9t6fDs9qYrZE/rje+snoy/ZijDSN+nrZD2BfR+jIu1eaE33N7vVG5l5umRk3yfMREDkL6QapUPgWsPZswOpqSztSQ0LzGCkI1hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 02:17:13 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 02:17:13 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 31 Jul 2026 22:13:32 -0400
Subject: [PATCH RFC 09/14] mm/page-flags: check page/folio->private instead
 of PG_private
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-remove-pg_private-v1-9-142c97ba3562@nvidia.com>
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
 Masami Hiramatsu <mhiramat@kernel.org>, Jan Kara <jack@suse.cz>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: YQBPR01CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 71af5d83-175f-41d2-c3b9-08deef730010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	7TdfpscXtX+ZAOJ6wPVnLfzAI0qontjN5yLip1FhHQ4igRjsTB3GCWogwEQmeQVQKvc7EWQfFsWxdEv5428GhQZyXtXW+/MYKkee8dDXhaKRsNl6kNLtXCsZWZXKFR1sI0TfKWoSxafQM6GeQdvbsjs8vZo9HJuXlbILiWozubTHz3gez4pydOOXkXIv/o0k3USSdHfXZHkQy+CBmVuLGDpscxCXOhZSwWJefvl6jqjvwuXT+EAKKR67ZwlFKCxL5/EZBcyfYYquEPSRni0ZfzFs/yAphbcGX7CDi0UlB4SW5gg5nK/oA2ZFdU7ZGzXL7ApoL2q4JazWmaQ21aZCoQ6v7X6XQEo7XCeJKwJVDHBZhTtCqeyruGLoh988PQayV4QxzogRfg7sWXlvnQAkdbOluWeRlDegoXagKQ51OrLFzU9JF0BTtAPvVRC49Gd0G6daytizz4Vb8UE3SO0X5AJy6PcXgWjip8kW2JJIVSjJI7MSwjfgcbMxjKqb9LhRfDYOp6ecJjdbH0yCamcrun1YgSzHy5fLrM8+g0wwtrPAKPdsTGxk5lmz3tWrlewuJZkQYdsgUdJ/YHj7mPmIsHJmNEf4Kdq0cJk26PFE9HsnbEsx4FaG29LH8I206r/7X+k+w3F7LUd+W0vI/6JkF7zFs7OXZSRfGWm4mEoFn0/pVXHQLWwubJ+of6tD/1a6OWM2SqOQfNvqJ2VHxfRX4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpoMTFuWk9EMEFreVVkcUtvNElkRnczWWRZQTk5Mjc0R0pMRmNUVzFnbjAz?=
 =?utf-8?B?QUIrcC9mSXIrZEd5YjI1YVRyOGxtRHF3R0h4SXR2aWIrUGZBc2dTWHlqSThH?=
 =?utf-8?B?cllHb2NrSnJialhqNTFBVDJYR1dNeXdPU3dZUk1QeWpWV3ZNcEpTYnZFcmRx?=
 =?utf-8?B?a1FNMDJXSXV3cXZsV2RWMmFnTGNYbmxFSVZpZ1FreXEyNWhnQ01SQ0c4eThr?=
 =?utf-8?B?TTR0N3ByVHJGMlRVNkdQNDlZa0g1R1c4VDB3WjV1RWgxUU5ESG45NUtXZzAw?=
 =?utf-8?B?MkJ4OUM1c1l0K2xaU2EzSDEydldoZFI1ZndPVFVYalBvclNtcU9Ra3NXdnd1?=
 =?utf-8?B?VkdHVm1aSjVBOTdLZmFiUGRUSHJKK2xpazVnTXVHdFpRM21EbFdpV3h3amZ1?=
 =?utf-8?B?QnNwMXJtMVR6a0RISVhGZUROdjB4dlp1YlpkbDNibTI1N2w3RjR0Qmd3a3p6?=
 =?utf-8?B?Ujh4bkt1VVY0eGxNS2RjMzY5SkVPYWxqTzBsK1o0NUs5NGxrZlV2c3VLYW5T?=
 =?utf-8?B?aXV0dnpnZTNvZk1DY2RHTzY4MERpV3FHdURia2NjcFRKNkhHV1ROUkc3ZXNK?=
 =?utf-8?B?M3E1UG9XVTFMSHFmNDZoTkYwcTlZVHU3dlZxVGFtK3k1Z2M4OGY0NnBvS2dz?=
 =?utf-8?B?N0g0bDg0Y25TQVRmaXVoR2ZMUXJCbGVtOWtqUEFQRnU3TW95aEtGN04wZlFT?=
 =?utf-8?B?T2V3WUxhUmhkSjJBOFUxR2hYd0lnd0d2a21NVTQ1Z0dNUi9HbTRyUEloWWhT?=
 =?utf-8?B?ZnhpNloxYnFQOTRaTUozS21ERDlFVGpHK3FJRUFtYzVxd0pHa2lDMHhzSE1h?=
 =?utf-8?B?NlZWT2lNU0R0dGpxQlZ0Um0zSG1JQTY3c3h4VjF3cnh1TFU1cFUyWGZwT3BF?=
 =?utf-8?B?Q0tSUm5PMDh1OE81ZGxSOTBuUUR1aXBEUVoyZmlpY0dYMHRWZWVqcDNGVGp1?=
 =?utf-8?B?aWpyZWhEUFhDNUsyMFo5bnE2V2YyY0tldWZ3bWZzRmFsaU1vNWZZek1qZ3I5?=
 =?utf-8?B?VDNLb3VqUlBIQlFReVVwVEt2alpyU05MTVZhMVp2UVhXVFB6N2t3TzgrMVNr?=
 =?utf-8?B?TlMrOWZQdUcydjh2N3dyb01GZFJMMmZ6TmJubjZ6RUFXSXBram1QVEdVZVF1?=
 =?utf-8?B?Yjllb0ZuTXh6cjFEVjB4bFUvZU1oN1Zha1dNSG41Wjd0TGpEREtNaFMrNlBx?=
 =?utf-8?B?V0lnWTVJVjE2REFKKzlWdkgxWVQ2L00zWkNuUGVsWjczRjdKRE5OVk9LaVJE?=
 =?utf-8?B?ZWp0MkhDWGE3dUNPZThLV2o2cXBFaHBZYTZJZU9QS2cxd1RodURac1JFdW9w?=
 =?utf-8?B?VUEwRzBrNXdvd01qOU43dnMyT0t5WE5adkQyaUVLOGNQWGliby9jNlZCOXdr?=
 =?utf-8?B?S1laTWN0b1NuL0tCZXhqUG1MOXVRRGtHUlcxQ0pQcm1rdUpCUXJDQjlib0Fw?=
 =?utf-8?B?MXpyemhtUUE3VnNFdnovT3RpRncwa0pheEY4RkpVd0FXWEF1ZWw0Tlh2VEtn?=
 =?utf-8?B?ZnJIamlxQXUxRUVnZUlMUHdDdFgyc3VQSG5UYjBEL0IwRFhsdC9oeHFNYXYz?=
 =?utf-8?B?ZzMyVVRzUTdQa2ZVL3R0TmRnRzY5QkVwb3lDNDFQeW96N1NlcE9tSGloWkN5?=
 =?utf-8?B?VWZjaHFHcnNrVTdaRTFsSXd2NllITGRBUjdEZW5hT0dSUUVITUNxY2NCaUlI?=
 =?utf-8?B?T0h3MEZrekVIOEIrMWY0NkZyMkY1ZDdueWZhblhUV3piOTI5anFoT2RRd2Z0?=
 =?utf-8?B?QjRxcmQ1OVIvZ05qOW00Uld4QWovTTBNamFRZGpmaUdxSlRISmttcnVZdDVC?=
 =?utf-8?B?dTBKRENFeTQ4bFYySnl2VDBFTGVKamR1MWsvZVpUTFJhUVNyekRQbGpkeUlv?=
 =?utf-8?B?clFZbjFsYWM2cXIzUU1jS0V2U1htdzE5eWVraUNTTG5pd3Fmdk1ocWZSR3Zv?=
 =?utf-8?B?bDNUaVpNaFM4bE1mc1JmQTdVRll1bnJBODNVSGN1b2RmN0Z0eVo4WDZvUWJH?=
 =?utf-8?B?VkM3ZkVHTVNmRWR6cm1MSkdIdlBadUxQMlRPa1RIVGZWYlBLMzhKaWdza0tv?=
 =?utf-8?B?djJ5MW5aVVNuZ29aOEJ1ZnFTTE50b3UzSFRDd1R2ckRYTW44dUdxZEdzNjBr?=
 =?utf-8?B?UmJDL3ZQU0ZjV1BuOWxUTS90bURJQ3krNUNabjBzWktLdVVucTdtazdaUkFs?=
 =?utf-8?B?OCtNN09Gdk5UZERyNm5nUzRUTmpaRy8vY1VTK1F4RDZZWENST2RLcUFQQUxQ?=
 =?utf-8?B?eXBGT0hFTThFOXdNc1UrRTlPcHUxME5TZkJPYjltaEZMSXRrMks1TVBrNG5w?=
 =?utf-8?Q?BhpEpI+xKt9gx0/b2c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71af5d83-175f-41d2-c3b9-08deef730010
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 02:17:13.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIAQq/xE66jMQs8qQfKsfq5QTEMuln+3IICksSLLswWWLN5H3HnpFF8YDaNDxuGJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373

After the changes of the prior commits, page/folio->private != NULL is now
equivalent to checking PG_private.

Stop checking PG_private on pages and folios and use page/folio->private
instead, except swapcache and hugetlb folios, because the former uses a
field (swp_entry_t swap) overlapping with ->private and the latter sets its
flags in ->private. Exclude swapcache and hugetlb when the code is meant to
check PG_private only.

folio_set/clear_private() and Set/ClearPagePrivate() become no-ops.
PG_private is no longer checked at page free time.

KPF_PRIVATE exposes PG_private to userspace. Change its code logic to check
folio->private != NULL and exclude non-pagecache, swapcache, hugetlb, and
anon folios. One minor semantic change, for orphaned pagecache folios
(mapping == NULL) with fs-private data will no longer have KPF_PRIVATE.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
To: Johannes Weiner <hannes@cmpxchg.org>
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
Cc: Qi Zheng <qi.zheng@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kairui Song <kasong@tencent.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org
---
 fs/proc/page.c                 |  6 +++++-
 include/linux/mm.h             | 11 ++++++-----
 include/linux/page-flags.h     | 26 +++++++++++++++++++++-----
 include/trace/events/pagemap.h |  4 +++-
 mm/huge_memory.c               |  4 +++-
 mm/migrate.c                   |  3 ++-
 mm/page-writeback.c            |  5 ++++-
 mm/vmscan.c                    |  3 ++-
 8 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 260772b20bd99..abfa6f7d890cc 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -232,7 +232,11 @@ u64 stable_page_flags(const struct page *page)
 
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
 	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
-	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
+	/* preserve the original KPF_PRIVATE semantics by excluding non pagecache folios */
+	if (folio->mapping && !folio_test_anon(folio) &&
+	    (folio_get_private(folio) && !folio_test_swapcache(folio) &&
+	     !folio_test_hugetlb(folio)))
+		u |= BIT_ULL(KPF_PRIVATE);
 	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
 	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
 	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7fabe6c66b4b7..ebc035ac26ccc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2961,9 +2961,9 @@ static inline bool folio_maybe_mapped_shared(struct folio *folio)
  * @folio: the folio
  *
  * Calculate the expected folio refcount, taking references from the pagecache,
- * swapcache, PG_private and page table mappings into account. Useful in
- * combination with folio_ref_count() to detect unexpected references (e.g.,
- * GUP or other temporary references).
+ * swapcache, private data (folio->private != NULL) and page table mappings into
+ * account. Useful in combination with folio_ref_count() to detect unexpected
+ * references (e.g., GUP or other temporary references).
  *
  * Does currently not consider references from the LRU cache. If the folio
  * was isolated from the LRU (which is the case during migration or split),
@@ -3003,8 +3003,9 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	if (!folio_test_anon(folio)) {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
-		/* One reference from PG_private. */
-		ref_count += folio_test_private(folio);
+		/* One reference from filesystem private data. */
+		ref_count += !!folio->private && !folio_test_hugetlb(folio) &&
+			     !folio_test_swapcache(folio);
 	}
 
 	/* One reference per page table mapping. */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7a863572adce7..8efc61f967302 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -578,7 +578,23 @@ FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
  * for its own purposes.
  * - PG_private and PG_private_2 cause release_folio() and co to be invoked
  */
-PAGEFLAG(Private, private, PF_ANY)
+
+static __always_inline bool folio_test_private(const struct folio *folio)
+{
+	return folio->private;
+}
+
+static __always_inline int PagePrivate(const struct page *page)
+{
+	return !!page_private(page);
+}
+
+/* no-ops during transition */
+static __always_inline void folio_set_private(struct folio *folio) { }
+static __always_inline void folio_clear_private(struct folio *folio) { }
+static __always_inline void SetPagePrivate(struct page *page) { }
+static __always_inline void ClearPagePrivate(struct page *page) { }
+
 FOLIO_FLAG(private_2, FOLIO_HEAD_PAGE)
 
 /* owner_2 can be set on tail pages for anon memory */
@@ -1170,7 +1186,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  */
 #define PAGE_FLAGS_CHECK_AT_FREE				\
 	(1UL << PG_lru		| 1UL << PG_locked	|	\
-	 1UL << PG_private	| 1UL << PG_private_2	|	\
+	 1UL << PG_private_2	|				\
 	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
 	 1UL << PG_active 	|				\
 	 1UL << PG_unevictable	| __PG_MLOCKED | LRU_GEN_MASK)
@@ -1194,8 +1210,6 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
 	(0xffUL /* order */		| 1UL << PG_has_hwpoisoned |	\
 	 1UL << PG_large_rmappable	| 1UL << PG_partially_mapped)
 
-#define PAGE_FLAGS_PRIVATE				\
-	(1UL << PG_private | 1UL << PG_private_2)
 /**
  * folio_has_private - Determine if folio has private stuff
  * @folio: The folio to be checked
@@ -1205,7 +1219,9 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  */
 static inline int folio_has_private(const struct folio *folio)
 {
-	return !!(folio->flags.f & PAGE_FLAGS_PRIVATE);
+	return (!!folio->private && !folio_test_swapcache(folio) &&
+		!folio_test_hugetlb(folio)) ||
+		folio_test_private_2(folio);
 }
 
 #undef PF_ANY
diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 36c3a90f0acca..fb9abec40ec79 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -22,7 +22,9 @@
 	(folio_test_swapcache(folio)	? PAGEMAP_SWAPCACHE  : 0) | \
 	(folio_test_swapbacked(folio)	? PAGEMAP_SWAPBACKED : 0) | \
 	(folio_test_mappedtodisk(folio)	? PAGEMAP_MAPPEDDISK : 0) | \
-	(folio_test_private(folio)	? PAGEMAP_BUFFERS    : 0) \
+	(folio_test_private(folio) && \
+	 !folio_test_swapcache(folio) && \
+	 !folio_test_hugetlb(folio)	? PAGEMAP_BUFFERS    : 0) \
 	)
 
 TRACE_EVENT(mm_lru_insertion,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 21c92ee48e469..d21a9b8f40d15 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4799,7 +4799,9 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		 * will try to drop it before split and then check if the folio
 		 * can be split or not. So skip the check here.
 		 */
-		if (!folio_test_private(folio) &&
+		if (!(folio_test_private(folio) &&
+		      !folio_test_swapcache(folio) &&
+		      !folio_test_hugetlb(folio)) &&
 		    folio_expected_ref_count(folio) != folio_ref_count(folio))
 			goto next;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index b937cbd764808..ad5daef8721cf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1330,7 +1330,8 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	 * free the metadata, so the page can be freed.
 	 */
 	if (!src->mapping) {
-		if (folio_test_private(src)) {
+		if (folio_test_private(src) && !folio_test_swapcache(src) &&
+		    !folio_test_hugetlb(src)) {
 			try_to_free_buffers(src);
 			goto out;
 		}
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 47495be68598f..b44468383f900 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2706,7 +2706,10 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (folio_test_set_dirty(folio))
 		return false;
 
-	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
+	__folio_mark_dirty(folio, mapping,
+			   !(folio_test_private(folio) &&
+			     !folio_test_swapcache(folio) &&
+			     !folio_test_hugetlb(folio)));
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 17d2b793cbfc4..ab059a2c6ea35 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -954,7 +954,8 @@ static void folio_check_dirty_writeback(struct folio *folio,
 	*writeback = folio_test_writeback(folio);
 
 	/* Verify dirty/writeback state if the filesystem supports it */
-	if (!folio_test_private(folio))
+	if (!(folio_test_private(folio) && !folio_test_swapcache(folio) &&
+	      !folio_test_hugetlb(folio)))
 		return;
 
 	mapping = folio_mapping(folio);

-- 
2.53.0

