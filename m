Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707D383C7B;
	Mon, 31 Aug 2026 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204378; cv=fail; b=B2VplfAv3v5SrzmCpEofLxas2JJ4Vnj23oK3Qcp5StFqHFCZkUd5pQW9B6V8jTczyfZ3Cm6HSDGdx/29Fsf0Uc8fpN/bpM2DALXJrzThI09jd5Tr8mqrE6iNw4Tn16BJWrYgK2fIWW6/Y6k5NIpRGPNlz8GIVx7rKP5E4xgrN0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204378; c=relaxed/simple;
	bh=V6rB6X6zScUDR5ZdGpz7JekGwYUymvuJHMd/vsgzPf4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pKTMNP7HEGKifXQ4GFy3GnGNsho/mIVBfdcRUq3bY9e4ze4Ux0kTN/CRWQB5QeNAR9fwCpSugOFe69n4AiM7sHNUBimeqwWz/gGrtHIMlCTCUavSFD+wjn2rBBUFDwARW05l8p6omtRhoBGVvJ6ICm3W46qRATvqC3aGFs2dLCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fe2mDwwr; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fe2mDwwr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxV6wBgkb8XbAWIZpcfVuX0Sr2nAGWl/i2U6JJijt+vYUriRmIYweg/xHtSXnuXsfbwkHdWsXl69iw0UZ30zdbgUatOZTKPWmIr9HYwEVEyR4J5wGBp3J7L0JAjA8gERrnxk5N/3UYzsiuk5pouqUYynAgMPhHipD12uoPLQuLVdcnorP31CbqP2Buawit8DOOXu0mtLmH1Hnpn6DeUns30Y2CZPPbO+w4zjQIhkaePBNxSKYhTxwg1K5D/ArQld2p++a9JjoTaNjeCZskfkWyNlj1f/HgoGCh0Dj8nNzRliKua/g7Q2ndKnrJOfia9DwdfSYn9x9eW6fTrMOdhwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnYdIIrMzR44ZS7GZCp4+zuyz1qcDtthumzMnQHLfkI=;
 b=NjerSRF8buGAPOb870Xst3YW16esy3CoKguJvOOFyAgqEOPIsTiXLFPwG640bcnHV1Nhx2c3+yJaIT5qoD2KVAQUQLi8RSvqvN2dym+BmIyR0azBORWAO8GwI0RGMxMRb/43JgtJY3BQQmAaBESfb9QgvC1uJPMF1KnEQy1D7aEJSqSF5gfcUR/pC1zrDZG+0VgCZ+9eu0VQXsV399yyLUL2+fdzzVZSzm91tTTWDr0VU1gNFLSv9UH/ygIJyleLJ9hI6E9YPPtvEg+IWKtlIgdyXHUqGjTY6x6rEXBl94JcVJoQsT2dFjUkCcd6u0WN0aEbxze1frKZ1UBmqPBX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnYdIIrMzR44ZS7GZCp4+zuyz1qcDtthumzMnQHLfkI=;
 b=fe2mDwwrgN5bquNeoWuQ63KvNBkhVmsjtmk3RhnUrKFQJAojOJq/bE9CPZfTfhIjbpuG23BOkanXUYiqV44hOTcZc9FOHGJYFxioQdUUskrMbldY+Dx5ld1zHSCE/zbyiDceK7o5JhG8AiFGVpcPrL6IiIrVcCVIwyvyPRjVc45RYj7y8tNHPYI6wbkrxZZOpo0U+cRviK/Q34uxXRelNAcsqUXNonxFGrDlWg5Ksh7C5kiPo78OoILSTyEZ8QZncJHhT5lzLybtTEX0gNq3UI1Wsd8NnMDtIeLOTjG4oFoiXAz++HFPZH/KpyKi/czaXk0+BqsnWHxUXCIylLNzAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Mon, 31 Aug
 2026 19:25:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 19:25:55 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 31 Aug 2026 15:25:33 -0400
Subject: [PATCH v2 10/14] mm/page-flags: introduce folio_test_fs_private()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-remove-pg_private-v2-10-3668159cd9e8@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
In-Reply-To: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
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
X-Mailer: b4 0.15.2
X-ClientProxiedBy: YQBPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e61fb7-4a23-406d-44df-08df0795acb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	yOldFkLn/Z+43KEkuknqEympk2R6DYYP8SohyN7fvuQy+5ThZA6Y03XGetqx08uEioyEDD1QIh8aSVJaZZo3Rm038YMNcIwvTRmqKNFsapyPvv5IL+AHIlS5d6gakBqzX5VXArXQ82/VmaYOLRA+NVcUkX481k1QCuzeeoiM58/iHdxgzf/DxsWl9dql9P7etkcPiG9Y2ORNlxxxs8Nipxtel5gTG7o/DPETuO+MFLFCZII1cMNu04gMYpmUd5z9Gvu/gZsqgjsBypWTRcNKWrzqoBX6QRC9qUVNOa9d14nKJtfTl8pOIFuFXKpnzhKOapNZuqEX3CfvWfgOPvyxqSC5jtd+6evkVKnCxZq8j6BcscLuheDfu75FJ5b0c1lY+MMDPTxUSmnG6x9h97jhrQKJwN4Iba28CjvpQ2VjaPtXDkStIMaKw5qRI5QkXXkjAfaj3A7dXtGPTE9ztqTJbVnQ9Q9HjD6XRRoaFXt3VeO/EB7ijK+dW2A4nIWpvT3Gfk0AmXbqBpROHXMNQtQSXCT55svsXLnI6SK72rs2o3yqgjLSRGtn5YG3qGVijHe73N5ALZ72i9Ug9ImmTuHACqbLCGhIuWusO0/Jz0z1vBRDcHEA/iCFxvXKki2E6jSmg89nXvEY5D1pZ+9BpEhsM5n+7gvR9jldKxTH0YNMirplKr7CqFGrqroIeraKhEgIpfEw4ciLxCBTOHLFZHBBJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjFzVGpQTXZFd05QUGpCS2NGc3F2aWdvUkpaazFhTGZsSktvRklLNG9jS0NT?=
 =?utf-8?B?d3hPdGVTdit3ajh3eWNNRVpKOXZuc1gzZTc4akNReFY5UTMrUGZVZktoUVpC?=
 =?utf-8?B?YXFYbmlrT2pSSmI3T2c0a3VVNkZ0SzZyRHY0dFFvZFlzcHN4Q0pnVVhPVlhw?=
 =?utf-8?B?MVhtaVd4VnlyNWRHeTlIUmRwQys0bS9UNEtlRGZiMVZGZWw4VkEzTm8ySVAw?=
 =?utf-8?B?N24wUkJ2b2MxZGMwdEVqOEZyYmdkb2ZpTHZGeTNUUDdZaE9SVjM5MUwzNHkv?=
 =?utf-8?B?L3lJWTNkcUYwa0tMTml3SXMrVDhPZGdxTmdOQ3hCK1hvZXl5RnJIM3paRXY1?=
 =?utf-8?B?Y3Q3TGJiNG15NmpPbFZERzkwUWNiTkZxdE9PZU1kdEFrT2hRZnJSN1NTaDVx?=
 =?utf-8?B?ZVc0Y2NRSW9ZOEx4cWFjNDRhc3MxQWY3YlRhNTBReC9tWDhwS0QrYTdiOWhn?=
 =?utf-8?B?dlJNRDFxa2d4S1B3TTZGVFZ4Q2hxeWpZZ3ppVUs5bklURmRUVFlhamVJRDRI?=
 =?utf-8?B?QTNhTUhCZHVWMUxxblZUZ2NnaEhRclZPL1ZQWFZEQnVKQVFhaEJ0WUxBNTNm?=
 =?utf-8?B?L2tLN1NWWGNxTDFiQkk1TnNwVFo0NVVBT2ZFQ2dNZHdtWGk1OE80RVR2cEFa?=
 =?utf-8?B?TkdtWStoSEJlZDA5NWZIUXdESjU3Uk1DYk1LclkyaURkMG56bjBGOHRjb0RC?=
 =?utf-8?B?eWJESzhkUGhDaFZFUjYxYkZLc0pzZWlvQ0lvYjBUWGEzcVhHd2VkbkRTYllG?=
 =?utf-8?B?cEw0cWN5MVk4L0RHRU5vbXp0ODJDNnlteGxOQmVtOGRvVEJqUTVPSUw3cnl6?=
 =?utf-8?B?WDZUU3lrdG1temZRSVF3OEx5YXBaU3RFRk9ySE4xUGtWS25YMGpFbEVacG9a?=
 =?utf-8?B?blZGT2NKZ2dUYVFLOHpLWWFXTmZPSkZPeHVsK0RvK0hsT3lCMngvTTdtNWs5?=
 =?utf-8?B?VE90WU1RTVR6YlhvbmZLR0QvNTFPYzk5NDZBT3g2aUMwTmlsdkFaMUJLQk1E?=
 =?utf-8?B?YmlCTzg3MmNhM3VDTml4K3owSk1GOU4wTkVwbEVDVk5aTTJsKy84Nk1CYklk?=
 =?utf-8?B?d0x1dWJCQUxvWEYraUwvRG1NR05jKzRFQ2dBZzF0UkNRM0V3bzN4MGU3Wk1D?=
 =?utf-8?B?cFJUUytWSUdYV0FqMS9qa0p4TzBEb1pjeWFiNC9QOEllWHRldEZhMlhMUUly?=
 =?utf-8?B?TldDb1Z2dXRSaFhLV1N3b3B6RzM2aGxrR3FYcFcvMk5remhjbXNteWQySmRh?=
 =?utf-8?B?Qy82eXI1K2o1ZE5EY1oyQVJtMUgyS3Z3V3ZKa00wNlZqSFFWekpGTHZXYThV?=
 =?utf-8?B?YmRVTTkxaG5rWSt3Nkd2RE5BcDB4UkFZNUJFRGFKc09EZEF2OWV2OEFCbFlW?=
 =?utf-8?B?SjZMODU2MDdKL1NaOVhaTjc0OE9LZm9ZSkQybWJrcWdITEUrNEZVUmRwazlZ?=
 =?utf-8?B?RHpGM3RLMlZvUSsyZnhqbEJjUHcwQUY4bVU4RElZeWFqdnBNc01CaVFEQm9H?=
 =?utf-8?B?TkVqWDRrclZnVDduTjg3M01aelB2elVZYXVtY2dYR0FwM215ak1XQVdwaktF?=
 =?utf-8?B?TTBsblhiSVZWYy9LNnRXVmpxWThGSzdXVjRmanBKS1FDMGhyMlFVVkpqU3FT?=
 =?utf-8?B?RUpoY1VhQnc5YmhmTTRTNEYyLy9TbUk4UzROWmRJaUtxT1hyZTQ4OVZ0Sjgx?=
 =?utf-8?B?QTNucXJyZVhyUlI2SDVTVWlmMllMOWxabXU0Z0ZUYXppSUpHNU9IWHEzblBi?=
 =?utf-8?B?NjMrb0E0amY0YmVnVHRjdVBhTzc3a0JXMU1uU3M0UndXeXZIVU9uMXZxRzQr?=
 =?utf-8?B?OGNYckVxSk9scWlTN3BVUEU2ZTRhZWo0Q1BXbStPQ2hnYjBWdjdRdS9vU0lx?=
 =?utf-8?B?bGM3SkQ1NVJHekkycy9lUERzSHlpSXFtSWtqeUlKL0psdzRPZ3pLd2lyY0JH?=
 =?utf-8?B?VUM4bnZKN1BqdnRQbHhDd0FGWkVFNGFnbjZsN3JuU0pJME94b1NSMUVuU2dN?=
 =?utf-8?B?S1l4SUN6SThPV09QajZpWWpMZXdMUUJGVVRndno5UldPSVRQTTRsRDBiTGFG?=
 =?utf-8?B?Z1ZYb2Y5Sjc1dmVXRjdxVEdPekVxVDJacVI0Zy9NT3pkdVBNelVsc3FBZ3NE?=
 =?utf-8?B?T1c0NlB0Q1pTRW45a3M0dEhGL1ZXSnBIZktBd1hLbVN2ZjFFYTJaM2xQTFJj?=
 =?utf-8?B?WndoQklpNmNhU2JUQTRVeWQvclJjNDBMN1pFSDl2aFVLYkZkM1RKYTRaVmpU?=
 =?utf-8?B?RGNJM1gxOWMxZm1ySzVoY2ZIdHBTTmJ6Nm4wK3BwQTVGWXVsYjlWMmtlSWhu?=
 =?utf-8?Q?N+0g+aWd10Z6Jo41ND?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e61fb7-4a23-406d-44df-08df0795acb1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:25:54.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naGLR2muBpOyBdciGV0Dh8HO4mV6oQy0x4Py+p6TVTL56FEGSPJ4Vwu8IvZTNiBK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742

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
 include/linux/mm.h             |  4 +---
 include/linux/page-flags.h     | 21 ++++++++++++++++++---
 include/trace/events/pagemap.h |  4 +---
 mm/huge_memory.c               |  4 +---
 mm/migrate.c                   |  3 +--
 mm/page-writeback.c            |  5 +----
 mm/vmscan.c                    |  3 +--
 7 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 786f8a47cea6d..b5b60f3ad58dc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3071,9 +3071,7 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 		 * One reference from filesystem private data.
 		 * Use data_race() since folio might not be locked.
 		 */
-		ref_count += data_race(folio_test_private(folio)) &&
-			     !folio_test_hugetlb(folio) &&
-			     !folio_test_swapcache(folio);
+		ref_count += data_race(folio_test_fs_private(folio));
 	}
 
 	/* One reference per page table mapping. */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ee7abb3000c11..9b585e68127a2 100644
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
index 546b37ccce37f..d085fd09466ef 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4810,9 +4810,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
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
index f14e7bfee14bd..666a7365e16e8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1327,8 +1327,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	 * free the metadata, so the page can be freed.
 	 */
 	if (!src->mapping) {
-		if (folio_test_private(src) && !folio_test_swapcache(src) &&
-		    !folio_test_hugetlb(src)) {
+		if (folio_test_fs_private(src)) {
 			try_to_free_buffers(src);
 			goto out;
 		}
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4022d6c381896..e03a1c46bce01 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2705,10 +2705,7 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (folio_test_set_dirty(folio))
 		return false;
 
-	__folio_mark_dirty(folio, mapping,
-			   !(folio_test_private(folio) &&
-			     !folio_test_swapcache(folio) &&
-			     !folio_test_hugetlb(folio)));
+	__folio_mark_dirty(folio, mapping, !folio_test_fs_private(folio));
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ac275eec086b9..29051c0f89881 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -955,8 +955,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 	*writeback = folio_test_writeback(folio);
 
 	/* Verify dirty/writeback state if the filesystem supports it */
-	if (!(folio_test_private(folio) && !folio_test_swapcache(folio) &&
-	      !folio_test_hugetlb(folio)))
+	if (!folio_test_fs_private(folio))
 		return;
 
 	mapping = folio_mapping(folio);

-- 
2.53.0

