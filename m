Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D03F12D8;
	Mon, 14 Sep 2026 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397090; cv=fail; b=uLYhGNyN3/H70lsar/QlQWikD5AqTeAtUlyZlOH8CTOH4XUeQmgaT4GbWi+Bn6M0K1H6CuAgvbJjLL0eU3+kKIJIZAiiaAJ7cju23yfxLNqCcG4RHJA0cgP4DUJj8CsVKIqoHIuz3ZCLf3dW5DUBviPqjSq/4x9/M0LsHRe15XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397090; c=relaxed/simple;
	bh=V3B3puLkLOLnydOuSNg9q1jCYKF2y7EIjz5xGGCz3UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZl010WYCkyy0sdZxPYnwSuJqLeYWOFEkjvfsUNUC7E5wDTFoegblOUQm+iihhvOmw/Q3d2xAW/mPympjBK6ivFsId2xVsLjwDW7RsknjCvbYduYDR5sKCZrWLC+VFyYpRmpUJ8iVdjZ3CWL+2zUPZnBNDqtIiGFfn9SqJxdqmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZKwWE3K9; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZKwWE3K9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVZGMAtfVSfxP2Ko/YyFQK+hURG9QpMcriug37wqvNMrPnOUpZifalVcXkoq2ftZV4nvvntX3i2erqo8X5yP/DPg0gQypPEiymxxFq8hRbycNo78pb1YmfQvAItQXDX26hb1+dPWzRmv6eehHeCdSSTy2HjRVVn6PEhUiGA/XAgurPeuF0fzPQ8fh8SRhKX2IeIdAWzNy3VCUYsNvkCdaIj/xS8lji6A2MZmI3knDisxA2y610tCD3VCUy6Nby9P7767nEE6StfO8GZqkQxLj42jLWYwCGJ0L6TGc8meuxfsVJSz9OriFk4e3y39ECNF93dVdM+J0uNHPYLyxiRuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j5uNX/FZn6OxtLx/Jfo0YlIixsNkxiju1u00W8SnKw=;
 b=dwA8Dwb6CU8fLRITsT70Q+UsnMYoEGi/WB+vK1e5aY78sLtVke/OATDHlCVKK9LV+ddWFksWig486kUAhefLqMedVzFZJzrup6cLmpUwlg78tBwWltt3a3lpiZzieqXQ24f/7ccZzxbgasg8Y40zYLUcG2u61RFd7W+/BDJ69nq1GeY1U7sLCnu9cjquARUdoSReBJFtilcgL7BmNxjR/Rsl/bMj5yr7t4MOmjdBcKzWbcyb5gSaDzQx+ClW+WV+Lx1+tfZCCMUHvuNuFgfm8cODbXFSlPifK6a1wzS3ALdqDpCDmju6mhpgmDzrU8XJMqeyI7+Gwkvuma+FOk8obg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j5uNX/FZn6OxtLx/Jfo0YlIixsNkxiju1u00W8SnKw=;
 b=ZKwWE3K9SkQcTanUTZXw/B2aXgvYnjbY9j9HZoCOwQxkAhwrFjfPQcxkxilTiSimR8d+UNH0ZHZG19+NLB/Xoxx9Ae4PMvb9PkU9NHe7/xem7Kawm7rTV7gLHyxK8PhWKOnlRL7UsfPWjD+TEmRCClFkVGAJli2Y3AREaQtca+SNZqfxLZAmkDcJEbQtREjfyVj+UHXD1d9D2rhPIvfQrcrywYHdmPeuw7kS/xPXoXNFwIxIRvaBKHpvV6Sp3ekj5nA+CJKoPBoICfL35wcz8/tXn1XnS5kaaSXn+n6/7vI7APcbc2dwfk1yYFN4ASPB3jRyWk80XTTQqvLzMJ3XCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:44:42 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:44:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jan Kara <jack@suse.cz>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/16] mm/page-flags: check page/folio->private instead
 of PG_private
Date: Mon, 14 Sep 2026 10:44:43 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <2CC856D0-3B58-4C84-AA3F-58D457344A73@nvidia.com>
In-Reply-To: <37f9a01c-4f6f-429d-b221-73ceffd55369@kernel.org>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
 <20260913-remove-pg_private-v4-10-848550f7574e@nvidia.com>
 <37f9a01c-4f6f-429d-b221-73ceffd55369@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BL1PR13CA0367.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::12) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: f26466c0-880d-4398-3527-08df126eb675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|5023799004|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	V/U0m42c8vx8OYwfj9o3CGoMxdYGNZOqXerAEyHaYb3i80YXNCVnfk1fve7pUDrpzqgaIzPzN/vlOO+Jki8WmXmnohcySsyrKibR6StLELt+4z/5G+q56shH2Z0aDyYtu9QVgMCjVdnDm3OvfUsFob6aiMiPq2hykTYQj7i4xhQc4td4UxTX4w6VIHX741s4zVATVTgGWO4BgH/lxSB84vqJb5rJK5MhDl7llbLagMiRR+A2hiMPrle/oc6ws6fzg0Q5QU7Vk56qDTuIejqBIFMEQkaxymc8IzDUofjKsNIxteWuSSy5ekGBY34l9mZuSlPbywIRSmQn09oZeQ8kZTGb9qg8WZAWUb9YtacHUvYsNRabstocPOjGFZa1J3IwvtPuMPEwVadQzwasnWdwrtAvacezqgj904iQf34ld++E6S2AbTbmChNdoCBsyXQcyO1bhNWDcbbKasGxmsfPM59XeU4QyDsgAFArIHoiT5Rc4c0CQj03OTuVtZ94O0C61lS+PSU1BAXbNoP1/10a742D1+gzvT0F/Gs3nJagipkCI9LX7fS11QejbXeF2Ao2CQs6RLibss9ZgeaEywuAjKHTad/N+/r1iGuem0VQxVGC+hJWsxGFqVADBwPEzsbjeBfGu1ewUD+hVKnQLRyWSyU9RwC1kfLgaQZkfg310fk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lTGDApfzNR+LHX/n2aPIhumGtUEUhugCMZ5pr+u7FFBo1/Snpw+oCScxJel?=
 =?us-ascii?Q?482oGIU7jq4ihaefCfj73F3ddAyFUUHGtPepamaugUkVfOFy2YYeJ9QYvEOG?=
 =?us-ascii?Q?YPmKFcohIS38NDEeHw1LDXC5Thrdwfsov2x3uER5ixcMD+AIzI50gVwkpoAA?=
 =?us-ascii?Q?Up+yA8JsY6AehA5JgFuYql2g1Bbczc/fa971zAzLSVTrQqaHsYRby5wAK0lk?=
 =?us-ascii?Q?sZBHruayd00APn05LaygfS8nqFymZMGfXxGGhyDrxCfCL+0xVvovvCcDPfks?=
 =?us-ascii?Q?rZE/1PAzzbSkoLC0z41/Rd3+FWcjMi5i+slgzV2QH4nwf/iqZoEmAmtpuCr/?=
 =?us-ascii?Q?UzwiQ5gJ+RrHdhbtJLkXgt0FolGMLGL0rk1SRpFmNujPqzJ5AvbTcYZ+1UuZ?=
 =?us-ascii?Q?ekbuy3TCe8+P+VpGvH12DRj7ME0Kcpy4Th5BcD+5pAlr2Ept7fpqmdld1Pj8?=
 =?us-ascii?Q?Hrq7r7CM4afnwPCTfMRNO9A4vclnbmLEw4g7MxlxOm+z/6NVqiPS6+32/Gof?=
 =?us-ascii?Q?GJzO0ApedyWOlBpYwSTVvRUZMw2I9F2RsvzoMvr/TSbqv0ymqjHykQBbD8fq?=
 =?us-ascii?Q?4iZZpDkD7WaPWFg6lnZ/oyH/Qy8iwlicfr5sHqA3jGSVOIiJ23cxJ4LcPMwy?=
 =?us-ascii?Q?mXSvATBmjexoEB7M3XksfOBRm/BsPJJlqEHuzb5+j3TYT9xhQYL47wdXvM0O?=
 =?us-ascii?Q?dLFk3DQJAR2a1qO3UF2Ax0kF+Ru92XapntJSfN/7ndQq0KOuAIWuA6LBTUJr?=
 =?us-ascii?Q?A01EXK6oG/WbEt+EbcR0BCR7OAnBAYxVakrEc3VJUSChtxAZrhUax1VaQsWy?=
 =?us-ascii?Q?O3kVb5gurktK8j41sKDAKGx5iHQ8kPpkcFNyDBn2ypCFezu9388Xh66rQa0Y?=
 =?us-ascii?Q?53C8SPOZliw9szAsoqLufcJzU0QfZnlTTucyXFdoL/CotUzv5slOv4z2rcoV?=
 =?us-ascii?Q?EGIDaRJeAosaqzPYXIG+Auv2HC1kBxqjcyET38b8f486AsQQ+jPTOFugT9D7?=
 =?us-ascii?Q?DPOxB4sJq80UB4kiDo7r9Rco3RH9dtNF9E9JvgBM5GWPrAlrX6WZ5zUyOETR?=
 =?us-ascii?Q?t/y+68vgNHIfIHcHY3icx5JxqKe8ZowPqmkWOmZ/LSq1UhoG7Rf8UxLe/9lc?=
 =?us-ascii?Q?irOE0C6zSDYBDYzFj0KQdTqR3j7e+XjIxjzTm3h2cfMN8Qw+j/6TeOvj4Xj0?=
 =?us-ascii?Q?oHWTtva56cylM/v0a0knLsKMqGBy7vi2VLcpZQQnyi0ALDp92mvqt1NPILjY?=
 =?us-ascii?Q?h58XlgXT1A5iZTq1IAx5zt6aqY/XnlRpkqvakHYeZx2WSy0PooZJxYrT0Wzi?=
 =?us-ascii?Q?UUzgeFRTkCkTuaYFr7ooLkqEYHHnIDcV5SamGSm+EUHT3voLVdwE2VNoKfSd?=
 =?us-ascii?Q?ON7XIb36VCaKUK2bvKxNjV+215/wQ8UjtSfuzc3XVGTLS6JYPOPAQQhRBpQ4?=
 =?us-ascii?Q?xbHXiZTufhM+KvGJCFENoAf4amvPvw6CwFjxoM7qwCtOdwQgPp6Wh4sT+DU4?=
 =?us-ascii?Q?T0UZjB8xT5KTJBQL/B7gfhWZrn8KyAuuwi7vrBYQQrdtU953hnddOO3PIdzZ?=
 =?us-ascii?Q?IuuUio6L5QFHGL2d61+EUHtIe2kwGe3cvLHi2oEBUF0tXP2I3Uz9kE/iJSMZ?=
 =?us-ascii?Q?zeYhLXYbL8Ctng3ya67MgzZhl2+Bsh30nyGWf1rA/EuP5jXYDI0+t1dOPEKe?=
 =?us-ascii?Q?ZBODmVZDTKr+DOIgruR7FX8FzdLXhxSqOzCCILxjzl8/QLOYaVrbBeSBDDey?=
 =?us-ascii?Q?fQEOmRkacA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26466c0-880d-4398-3527-08df126eb675
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:44:42.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5S+FacRTDT33eFu8wn7keD04cHAJJVxGMKb60CcrsQkGZTQcpNtuD9/+rgG9ujM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

On 14 Sep 2026, at 9:26, David Hildenbrand (Arm) wrote:

> On 9/14/26 04:24, Zi Yan wrote:
>> After the changes of the prior commits, page/folio->private !=3D NULL =
is now
>> equivalent to checking PG_private.
>>
>> Stop checking PG_private on pages and folios and use page/folio->priva=
te
>> instead, except swapcache and hugetlb folios, because the former uses =
a
>> field (swp_entry_t swap) overlapping with ->private and the latter set=
s its
>> flags in ->private. Exclude swapcache and hugetlb when the code is mea=
nt to
>> check PG_private only. PG_swapcache and folio->swap.val cannot be set/=
clear
>> as a whole, so excluding swapcache with folio_test_swapcache() is not
>> reliable. Instead, use folio_test_swapbacked(), since PG_swapbacked is=

>> stable when a folio is added to/removed from swapcache. Add a helper,
>> folio_has_attached_private(), for this check.
>>
>> folio_expected_ref_count() can be called without folio lock, so annota=
te
>> folio_test_private() with data_race() to avoid triggering race conditi=
on
>> checks. While at it, annotate folio->mapping too. Add data_race()
>> annotation for other lockless callers too.
>
> Shouldn't we just move the data_race() into folio_has_attached_private(=
) and
> document there, that it can be called without the folio lock as well? H=
aving the
> data_race in multiple callers looks odd.

Not all callers call it without holding a lock. Before the patch series,
it is fine for lockless reads because PagePrivate() is an atomic operatio=
n.
But after the patch series, lockless reads can cause data tearing of
folio->private. I think I need to add this to avoid the confusion.

>
>>
>> folio_set/clear_private() and Set/ClearPagePrivate() become no-ops.
>> PG_private is no longer checked at page free time.
>
> You can mention here that we will clean this part up next, to remove th=
ese
> helpers entirely.
>

Will do.

> [...]
>
>>  	}
>>
>>  	/* One reference per page table mapping. */
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 462e89e055485..08988877331ba 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -577,7 +577,23 @@ FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
>>   * for its own purposes.
>>   * - PG_private and PG_private_2 cause release_folio() and co to be i=
nvoked
>>   */
>> -PAGEFLAG(Private, private, PF_ANY)
>> +
>> +static __always_inline bool folio_test_private(const struct folio *fo=
lio)
>> +{
>> +	return folio->private;
>> +}
>> +
>> +static __always_inline int PagePrivate(const struct page *page)
>> +{
>> +	return !!page->private;
>> +}
>> +
>> +/* no-ops during transition */
>> +static __always_inline void folio_set_private(struct folio *folio) { =
}
>> +static __always_inline void folio_clear_private(struct folio *folio) =
{ }
>> +static __always_inline void SetPagePrivate(struct page *page) { }
>> +static __always_inline void ClearPagePrivate(struct page *page) { }
>> +
>>  FOLIO_FLAG(private_2, FOLIO_HEAD_PAGE)
>>
>>  /* owner_2 can be set on tail pages for anon memory */
>> @@ -1169,7 +1185,7 @@ static __always_inline void __ClearPageAnonExclu=
sive(struct page *page)
>>   */
>>  #define PAGE_FLAGS_CHECK_AT_FREE				\
>>  	(1UL << PG_lru		| 1UL << PG_locked	|	\
>> -	 1UL << PG_private	| 1UL << PG_private_2	|	\
>> +	 1UL << PG_private_2	|				\
>>  	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
>>  	 1UL << PG_active 	|				\
>>  	 1UL << PG_unevictable	| __PG_MLOCKED | LRU_GEN_MASK)
>> @@ -1193,8 +1209,28 @@ static __always_inline void __ClearPageAnonExcl=
usive(struct page *page)
>>  	(0xffUL /* order */		| 1UL << PG_has_hwpoisoned |	\
>>  	 1UL << PG_large_rmappable	| 1UL << PG_partially_mapped)
>>
>> -#define PAGE_FLAGS_PRIVATE				\
>> -	(1UL << PG_private | 1UL << PG_private_2)
>> +/**
>> + * folio_has_attached_private - check if the folio has private data a=
ttached
>> + * @folio: The folio to check.
>> + *
>> + * Use this in code that may encounter swapcache or hugetlb folios bu=
t only
>> + * wants to detect attached private data. Swapcache stores swp_entry_=
t in
>> + * folio->swap, a union with folio->private, and hugetlb stores its o=
wn flags
>> + * in folio->private; both are excluded.
>
> This is an implementation detail that is irrelevant for callers. Move t=
hat above
> the actual checks in the code below.

OK.

>
>> + *
>> + * NOTE: For swapcache, folio->swap.val PG_swapcache are not set as a=
 whole,
>> + * so folio_test_swapcache() is not reliable to exclude swapcache.
>> + * Use folio_test_swapbacked() instead, since it remains set when a f=
olio is
>> + * added to/removed from swapcache.
>
> Dito, a caller of this function doesn't care.

Got it.

>
>> + *
>> + * Return: true if folio->private is set and the folio is neither swa=
pcache
>> + * nor hugetlb.
>
> Can we remove these implementation details here instead and talk about =
"true if
> the folio has private data attached" ?

OK.

>
>> + */
>> +static inline bool folio_has_attached_private(const struct folio *fol=
io)
>> +{
>> +	return folio_test_private(folio) && !folio_test_swapbacked(folio) &&=

>> +	       !folio_test_hugetlb(folio);
>> +}
> Apart from that LGTM.

Thanks.


Best Regards,
Yan, Zi
