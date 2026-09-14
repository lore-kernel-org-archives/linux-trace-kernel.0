Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDF31ED81;
	Mon, 14 Sep 2026 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352694; cv=fail; b=nYfiIQKhFKyNvOGQ7rc+tMfFX74gp4h6uWHYiKaMBouHZT4t8RIsFxVxaC7ydLRcJjE3xnfos8lGrA1x+ONzL6Ao4hCAV+1L0qSfnZOYYqrRTFj3YzdYexKuLym24zshD/vYJTSw7hVvqrvOzkU8gomwzps3y1nmhsCcs+/DH3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352694; c=relaxed/simple;
	bh=vWkCV8CGPb35Xm1RmMIyDB6t8L1Tl75RaRkyg9UnTic=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YJ/HshTh9Z9Bk1Etga/R8iNEJ0My6cl8nZHCls88GVYOqhxCJfOqEutmunSOee3OsDDkK669UJXwXXo5Ck4NkPT6WnUG0RCnH+Tv1Aw5ld9XLXAZFQuU9pR+F5FZd8scRgdZZReuOJpWyvump57F/LdVIUXruHXxqxi4QLsI/HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AKqE7vTg; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AKqE7vTg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJpINlq/Q+TkUEpgVhyAvSwfZhrbTDvw9qiojGaqY9XJwGS36uQtCtdeD14bMmU+ibvpceWc02h2ZOMBBYa0YCgzVlHh9oRXRPmUtJqG5xgG9lGR7HdLWTHj8mNKYTFq3w8qLG2Z3VoIN9sSwmuuhLHmI4MrpgJ9w+qxt7gEBFKWbZ8pwZ8DspEH1lBoOsKyFW+qVKM2VtXqu5j2gMW8qy3OuUWQawKHuv5QRzboWVnvtHsldAFAo7dVZ3n0avc7EfjrKUHFNQi69vGotPqLUtFjQPAYBQTteaMNJqG2evUn4Sedd9bSlHW715BQ9d7TZaLi58o3xlEV0o1CupLyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dCTXKqGClVZty2pusptUW7fOs0+Pn2ZhRQI1rlt53k=;
 b=a1q9UNf3fzFbo72NICrgPZAJnYDbpv9nvRBx2V2P5yMZ7mB2G7ugL0nnFQb2uhX2dMZMUSqrhkIfBF3EVwSgF0xZEd2cox05ez5VJnQWgULo64dQroXWfO81UNEzrRj+vz+VT3A2tAajc8umc7WSVgwVkiTuj4DZfwPvWaIrix61VmiiSswp0i8vakvJVm9NiCcmMNu0L3erRm6DTt93zQR2iQPXpL7xYsjdW1VrF1hjPWTfnNTPgX8hECE8cGtZJ6HAehRXjMNZI4zD8iwGlbmoVAh/it6AnF8RwASYizRjnQCtVH3m2fFluqbnPiEmV57xORiCu+cmhFpKlg0rtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dCTXKqGClVZty2pusptUW7fOs0+Pn2ZhRQI1rlt53k=;
 b=AKqE7vTgs/KVmLNlntiWrqIILEfl8aTRj9eKBB5qdo7xSQtSE6T+LpEWbF9DQqO5Y/KWGDGopgFC95UgOL3AZD5qgzBVDL4ScgJP8zuC5e7frkREHJjuB2nY3xsbnyn9fiEenheoexFPR7Ytx/II4Slfv8ypjEriOZ0coxUIfzyKotdbUFsfek29uF8dLzaF1i49ys4NQ+Xue113wmRTs85INsWsjoOQQuz1zVybNROXp1AnWTvpeCGiTSSszQqDbHPa5I5cUnvyQQAkd2mIRefPLpNBP1ru/frKuY3YRONWcs7HLKIL7/jR6V9W3WrKSuqV+XeaQBMv+CD0eXT7AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 02:24:23 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 02:24:23 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Sun, 13 Sep 2026 22:24:08 -0400
Subject: [PATCH v4 10/16] mm/page-flags: check page/folio->private instead
 of PG_private
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-remove-pg_private-v4-10-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
In-Reply-To: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
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
X-Mailer: b4 0.16.0
X-ClientProxiedBy: BL1PR13CA0346.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::21) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 954a18cc-1532-4c0a-bed1-08df12074a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|921020|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	UAkwPdu4UsNwrnSEMrCrJe5U+L2PKbvA44f2HfG3kmMdrbdV0BM5SMKLqriOE7Sdq+y1RgXHldtq6i+RbpLRrXD0WFkTVXBTIa7c+XCy1UZLX1g1LMnOQ10CGW5ufIzyWx0AU8Q04U0U2kgHW1MN+mzvKVBFapVilLmmk9lDCxSAGxQdS4hSk52zg4NkBTuH6uZaViuBtpRCr7EVUzRV5iCqim2rdi5uICLGIbf2ZIlZ4smjncS1ikcfL0DhBKvVn3qyFFNOEWk0p6IdWid3xcl4dEckIIeF1c853szno8Xp+J1fHxe2YSLhkaV09d3AKj0Lq6A4CXa4pFVTq6uxYHE9l//kiiLkt1uX2uso3aDNaFt4s1B0vzLdMhWiSbZkFCL/QwLlDIl3mxoqorC2MLDfwqjgbWjBoSKCoV9/p6S0OVtvR9D3tZwM9TpbARpW41H6AxVD/mfd2KLvW1ZfUP69JXudFNLBObLhAGkB02EMrTBhraD1If3MbN2dKJlRRMymgIM5TuYC8OKw0tU8SGabMMaQyL2dToo6+m9nz7HVwFrA/HiQK77w2EYtpZl4PzDAIcRNUvR8iyKpbaVihF1wjvYLgHzlEcMC5jdym6HZZFvOnlfDS57jeBzUueG8SYTsaxsRGMmiMHDZNEXXxWyvxAroQOpv6z9G7FJf5UhF4lMA28QFolH5wMUROHfxr4d4Cf1QoHV2sFf25lzPug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHMxY3lMdFI4VVdqZTdkZEErZVNiZWM0VWRRMjI2WVdSLzdHZUtUZlBxWXhz?=
 =?utf-8?B?bWtpTlpqMEhPdUh3RVNER3JtMGZDT3dRK3I4UGE4UFBWM0ZxcVJHWTQzZUJC?=
 =?utf-8?B?eTRNRHQ0SUlpU3VzREVhcGp1a2VwQXlxS3A4cVU0RVBmQVdGckFlcDlLYnFn?=
 =?utf-8?B?U0NhTjdZS1NGRzBTd0FFOVdLUzNxWlJDWDEwSWF1VXZOTnBqV3IzNm4za3E1?=
 =?utf-8?B?RlRWcnhqTFBjZno4NllmTWQ0YmJlR2FBSHZMRWZaN3pvTjdCckJSOHFqNEJF?=
 =?utf-8?B?WVYyeHJDRTJzQ3ZaTGxkWjhENTJPVVNyMDhWdWNodmhOd3BZVWRYcmhMbXNv?=
 =?utf-8?B?MnJjOWpGWnBicytoQWFWeXJTUkVOK3g4bC9MTVJpbEh1c2FUWnNhbzhhZ09n?=
 =?utf-8?B?dE1IRmNNWXQzY3FJWFhWbThoV3R6RWZEY0FNK1V3V2t1bzVNeDE1SFQvRG95?=
 =?utf-8?B?eG93akt2NnEvV2lqVk5RQXo2ZUZaTDNCT0VGZHFEemIvZWViRjlmc2hxbkhx?=
 =?utf-8?B?Z0wxRk5LUkswN1ZPSW14aGZLVWNLTGxPb3UrSEZCTCt2d0w2NTNKTmt2Tlox?=
 =?utf-8?B?alJqSjFaUU9SR0dSNk5HQ1R0ZHZGT3p3QmYwQ1JhTDUyN0JxNXN3ai9IakI3?=
 =?utf-8?B?bzJ2QURkRzloRHNVSFFPR2g4ODB1OHVwVUE5Z3dMdy9lNVpuaC9Pbm9jRXh3?=
 =?utf-8?B?SlI4WEM2MUczb2owWFRwK1RLNkFJVWd6L0Nudlc4Ylo3MHZncnM3RGxpNmdp?=
 =?utf-8?B?LzNtS3Q5OFgvb1ZSSGFKUjhjWEh6M2Q2OU0vSGp2OU1pQS96blEzYURIMjM4?=
 =?utf-8?B?WG43U1hDemV3bWZETUtRRFFrYTNlbjlocjJybW8xWmdHQWh5MnFUd1Nab042?=
 =?utf-8?B?QXB3N2pNN1hwM2FTSnRReit2c2NCUThQYmR3cEhxTExJQnVCaWFZdWtHMlZJ?=
 =?utf-8?B?OFYzSkhqa3NQWlhxS2ZUd2lGanhBTms3K0ZEUG9YemlNYzloaXVCMWdzcFRZ?=
 =?utf-8?B?aHZQUUhNbjNYREt0dmNaL2NNQ2lxT3VnUURDNWVTcmRQWmNMREc4d3NBU0tX?=
 =?utf-8?B?UlRsVFVYVmI2VllVeDEvTWVqbVR1dGUxMmtwWUdwNGxlMklxOWplZ1JRbHRI?=
 =?utf-8?B?djVuWml3c3l4ektodEEwMVpLaUVuOHJCY1ZIeURsdHBRem1VN2lCVnlrdmRj?=
 =?utf-8?B?OFpxZU8wdndwem1vS3JMVytZdHRJRkI3U0ZNZmY1bjIrRjhhTHFEREh1M0Rj?=
 =?utf-8?B?WUZ5dWsrRzV4QVQrMTBtSm91NWdMOVJXYk1yTnh0bVhtYXROeVFRRis4eDBU?=
 =?utf-8?B?aUwyMWV3R2FwSURhVTFUa2F3Ym5yeVJ1SFQwdm1mdFdNamM3VHJrSktBZ2Ft?=
 =?utf-8?B?aFZ6WHdrbXFsRnNmS1BxLy9XaDYrQmRKa1Y0Y29ZazVNaXB3VjZJZnlZdXNn?=
 =?utf-8?B?WGl6ZC9mMWNYaWJ3YlVJMDJxSGFmUC9Zb1V1RGFNbDBHSGt2NEJKRXh2OW9t?=
 =?utf-8?B?ekVZMkNidTdZVWlOZHpScGVJTVVzREd0YWwyS2ZyaGVMTUYzT2VxaTRzT3Fn?=
 =?utf-8?B?bGovdmZSNzFDcVVjaWQwVSszOFhrRFBZa0tSaGo5bmxmcTRMdVN1WFdJcXB1?=
 =?utf-8?B?SDVERkRLQ2VlMXpPaUhPZkg0NXpJa0hQM3d1WTNydVM0dVRRdzdGaVNJdkJ4?=
 =?utf-8?B?RUhsUlJqUGJCVGRVWWI4MjhMNzZER0NWN2xROS82d0hyaEhMcDR2ZmxKVnBI?=
 =?utf-8?B?QW1qMnVrekJhYmNPSzdNVzhOcSs3c2ozdzEyZUVtNHhEWVZmTWdrRldiRStI?=
 =?utf-8?B?b3llZEkxbExZOVNad2tUNlRFRml2Tm5nbXNhT1pMSTBJZE15elpHaDY5bll1?=
 =?utf-8?B?RHYraGo5aDFkUVpxSTNRbzJGem8rNFBFUHdPR1pPbW9kdFZQWEV6dHZIRklp?=
 =?utf-8?B?M0liTDhhemVHQmJ1Z3UrUjZvWWE3aHNMVi9iQ3dhZFNXRW96RlhITUk2b3Zu?=
 =?utf-8?B?VU9ndzdsUDQ3WDJ2RU5pWE9QVFF2M3IyOURkcnlmTDVnU2JNNlV3VTBJbks0?=
 =?utf-8?B?VkFFVjdwTVZxZHlobE1ESmdYTmdNKzUzM1dMZkdnREg3Q2dqTTlZSHo0Q2JQ?=
 =?utf-8?B?Y1V1UzAvRE9za0pOR1ZvV3BCby9idkVEU3J6SmlUaU54SWhBZjNrVjFabWZS?=
 =?utf-8?B?MDNBem5TckI2RjNDMGJuTU1rZmE4REQ1UWszcUR0Rk1mdFJPeTJKTlNMM0NO?=
 =?utf-8?B?TXlyY25GbHAvRzl6dkxCZFM4Q0NJTTNjcnlZMSs5MmEwcGUrZVlTMGd3M2dt?=
 =?utf-8?Q?CPXHhQ6P9tWYaoG4ow?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954a18cc-1532-4c0a-bed1-08df12074a57
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:24:23.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fpm28CY/KUZT0iwmeXlIK9RvNfroZD+RH2aN4C9JsQt9tC3vDVv6Ovu2geUH5iZh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

After the changes of the prior commits, page/folio->private != NULL is now
equivalent to checking PG_private.

Stop checking PG_private on pages and folios and use page/folio->private
instead, except swapcache and hugetlb folios, because the former uses a
field (swp_entry_t swap) overlapping with ->private and the latter sets its
flags in ->private. Exclude swapcache and hugetlb when the code is meant to
check PG_private only. PG_swapcache and folio->swap.val cannot be set/clear
as a whole, so excluding swapcache with folio_test_swapcache() is not
reliable. Instead, use folio_test_swapbacked(), since PG_swapbacked is
stable when a folio is added to/removed from swapcache. Add a helper,
folio_has_attached_private(), for this check.

folio_expected_ref_count() can be called without folio lock, so annotate
folio_test_private() with data_race() to avoid triggering race condition
checks. While at it, annotate folio->mapping too. Add data_race()
annotation for other lockless callers too.

folio_set/clear_private() and Set/ClearPagePrivate() become no-ops.
PG_private is no longer checked at page free time.

Remove KPF_PRIVATE since PG_private is no longer used.

Assisted-by: LLM
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
 fs/proc/page.c                    |  1 -
 include/linux/kernel-page-flags.h |  1 -
 include/linux/mm.h                | 20 +++++++++++------
 include/linux/page-flags.h        | 46 ++++++++++++++++++++++++++++++++++-----
 include/trace/events/pagemap.h    |  3 ++-
 mm/huge_memory.c                  |  3 ++-
 mm/migrate.c                      |  2 +-
 mm/page-writeback.c               |  3 ++-
 mm/vmscan.c                       |  2 +-
 tools/mm/page-types.c             |  2 --
 10 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 260772b20bd99..f90e1030825e9 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -232,7 +232,6 @@ u64 stable_page_flags(const struct page *page)
 
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
 	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
-	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
 	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
 	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
 	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
index 196778a087c4d..fe5ab6e50bd70 100644
--- a/include/linux/kernel-page-flags.h
+++ b/include/linux/kernel-page-flags.h
@@ -11,7 +11,6 @@
 #define KPF_RESERVED		32
 #define KPF_MLOCKED		33
 #define KPF_OWNER_2		34
-#define KPF_PRIVATE		35
 #define KPF_PRIVATE_2		36
 #define KPF_OWNER_PRIVATE	37
 #define KPF_ARCH		38
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 969594074fd2d..c9aad2c39fd9c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3004,9 +3004,9 @@ static inline bool folio_maybe_mapped_shared(struct folio *folio)
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
@@ -3044,10 +3044,16 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	ref_count += folio_test_swapcache(folio) << order;
 
 	if (!folio_test_anon(folio)) {
-		/* One reference per page from the pagecache. */
-		ref_count += !!folio->mapping << order;
-		/* One reference from PG_private. */
-		ref_count += folio_test_private(folio);
+		/*
+		 * One reference per page from the pagecache.
+		 * Use data_race() since folio might not be locked.
+		 */
+		ref_count += !!data_race(folio->mapping) << order;
+		/*
+		 * One reference from filesystem private data.
+		 * Use data_race() since folio might not be locked.
+		 */
+		ref_count += data_race(folio_has_attached_private(folio));
 	}
 
 	/* One reference per page table mapping. */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 462e89e055485..08988877331ba 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -577,7 +577,23 @@ FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
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
+	return !!page->private;
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
@@ -1169,7 +1185,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  */
 #define PAGE_FLAGS_CHECK_AT_FREE				\
 	(1UL << PG_lru		| 1UL << PG_locked	|	\
-	 1UL << PG_private	| 1UL << PG_private_2	|	\
+	 1UL << PG_private_2	|				\
 	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
 	 1UL << PG_active 	|				\
 	 1UL << PG_unevictable	| __PG_MLOCKED | LRU_GEN_MASK)
@@ -1193,8 +1209,28 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
 	(0xffUL /* order */		| 1UL << PG_has_hwpoisoned |	\
 	 1UL << PG_large_rmappable	| 1UL << PG_partially_mapped)
 
-#define PAGE_FLAGS_PRIVATE				\
-	(1UL << PG_private | 1UL << PG_private_2)
+/**
+ * folio_has_attached_private - check if the folio has private data attached
+ * @folio: The folio to check.
+ *
+ * Use this in code that may encounter swapcache or hugetlb folios but only
+ * wants to detect attached private data. Swapcache stores swp_entry_t in
+ * folio->swap, a union with folio->private, and hugetlb stores its own flags
+ * in folio->private; both are excluded.
+ *
+ * NOTE: For swapcache, folio->swap.val PG_swapcache are not set as a whole,
+ * so folio_test_swapcache() is not reliable to exclude swapcache.
+ * Use folio_test_swapbacked() instead, since it remains set when a folio is
+ * added to/removed from swapcache.
+ *
+ * Return: true if folio->private is set and the folio is neither swapcache
+ * nor hugetlb.
+ */
+static inline bool folio_has_attached_private(const struct folio *folio)
+{
+	return folio_test_private(folio) && !folio_test_swapbacked(folio) &&
+	       !folio_test_hugetlb(folio);
+}
 /**
  * folio_has_private - Determine if folio has private stuff
  * @folio: The folio to be checked
@@ -1204,7 +1240,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  */
 static inline int folio_has_private(const struct folio *folio)
 {
-	return !!(folio->flags.f & PAGE_FLAGS_PRIVATE);
+	return folio_has_attached_private(folio) || folio_test_private_2(folio);
 }
 
 #undef PF_ANY
diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 36c3a90f0acca..304652d6d8f2a 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -22,7 +22,8 @@
 	(folio_test_swapcache(folio)	? PAGEMAP_SWAPCACHE  : 0) | \
 	(folio_test_swapbacked(folio)	? PAGEMAP_SWAPBACKED : 0) | \
 	(folio_test_mappedtodisk(folio)	? PAGEMAP_MAPPEDDISK : 0) | \
-	(folio_test_private(folio)	? PAGEMAP_BUFFERS    : 0) \
+	/* data_race() is used to read attached private locklessly */ \
+	(data_race(folio_has_attached_private(folio))	? PAGEMAP_BUFFERS    : 0) \
 	)
 
 TRACE_EVENT(mm_lru_insertion,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 30b7c63b0e359..8f4bcdccd8f35 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4845,8 +4845,9 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		 * For folios with private, split_huge_page_to_list_to_order()
 		 * will try to drop it before split and then check if the folio
 		 * can be split or not. So skip the check here.
+		 * data_race() is used to read attached private locklessly.
 		 */
-		if (!folio_test_private(folio) &&
+		if (!data_race(folio_has_attached_private(folio)) &&
 		    folio_expected_ref_count(folio) != folio_ref_count(folio))
 			goto next;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index a369d0c95c386..b7b92925a28c3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1327,7 +1327,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	 * free the metadata, so the page can be freed.
 	 */
 	if (!src->mapping) {
-		if (folio_test_private(src)) {
+		if (folio_has_attached_private(src)) {
 			try_to_free_buffers(src);
 			goto out;
 		}
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eeab25d6ce364..0d754a678eac2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2705,7 +2705,8 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (folio_test_set_dirty(folio))
 		return false;
 
-	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
+	/* data_race() is used to read attached private locklessly */
+	__folio_mark_dirty(folio, mapping, !data_race(folio_has_attached_private(folio)));
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index aaceed4759eeb..c2eb8fa9d5e50 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1029,7 +1029,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 	*writeback = folio_test_writeback(folio);
 
 	/* Verify dirty/writeback state if the filesystem supports it */
-	if (!folio_test_private(folio))
+	if (!folio_has_attached_private(folio))
 		return;
 
 	mapping = folio_mapping(folio);
diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index 7fc5a8be5997f..47e4781c5fc38 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -73,7 +73,6 @@
 #define KPF_RESERVED		32
 #define KPF_MLOCKED		33
 #define KPF_OWNER_2		34
-#define KPF_PRIVATE		35
 #define KPF_PRIVATE_2		36
 #define KPF_OWNER_PRIVATE	37
 #define KPF_ARCH		38
@@ -131,7 +130,6 @@ static const char * const page_flag_names[] = {
 	[KPF_RESERVED]		= "r:reserved",
 	[KPF_MLOCKED]		= "m:mlocked",
 	[KPF_OWNER_2]		= "d:owner_2",
-	[KPF_PRIVATE]		= "P:private",
 	[KPF_PRIVATE_2]		= "p:private_2",
 	[KPF_OWNER_PRIVATE]	= "O:owner_private",
 	[KPF_ARCH]		= "h:arch",

-- 
2.53.0

