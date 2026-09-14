Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDBC49EC59;
	Mon, 14 Sep 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399267; cv=fail; b=NaDjP3d0Bh1v/azXDHx9SmFLTJdjKMMNIWLj2euDlO7dJJ4FAabr6uWLVO9vd0LsD9ILIaYlCzyz1RQ8QclbmrghDnaymRP7LDXwprNudC2fR8HtqBnSAXfDJzoeFMkkHgAOw3vVk+KLaaRUfJIhgtzzwQmumFT5iLkIVCMnCj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399267; c=relaxed/simple;
	bh=/IaJuj6XEigTkdDGlM71geYocw9XJR+7oG7gnsBo87s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqywFuzBkwRUyUrItdA43IpgMs2r3zAfLj0ivwYtJvrqhxLDg7YT7Veka4Aiq03F00t+j5+sd8Iz+0a7CP6Lv3ndSC7tyPylT8MTYpdQK2mvLRqRahwtg6ON9Fa9ixxPGUiWQDBts+s0OD+rmvfvTyXlAAXUPUKFJnRhtBx5vvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nPHzEuSY; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nPHzEuSY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0Ykw4jZ+pO6jISVDe3Jd6dU+a8+qKUh2V7Y702lat9qXQ7JRPqqpGP7W26a84AtV3MfaNK1wI26JV2ImHxeHfZP9wY0ykrY2qt1VIRzSRJMByBCgUSbwmVUyFF3HLF1oZTSrYBfyq8FrFBDjdJfjIE+6f1+k/RXozhwVhHtg83ZUqVn0L6SnYZVzF6v8qESWrdRO+8SIjeZ+xdQB9fcJBPdIIvi0ZrsKuEswy3XkqYGLeQgENq/JYhw80xLpaHvqxUfaalCY2AO16Kn4ODVkv02TV4pwr2efOc/bg0L2jLzOov3U+9sl7xgOYN14la0X0z+bX6hHE9NET27azMfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IaJuj6XEigTkdDGlM71geYocw9XJR+7oG7gnsBo87s=;
 b=DZbCeDMb5a7ONlAKHyuBLBxNZtDSEubK2j9+pOryX9xq+tZ8ab74Bcm0m8OudL5SWJ8FMkeUBRGfQ2/Bd6nokAf3/2458bOcpcw+fVUSgGEgazF1CvkbW1F77JeSoOyaV9lw4ODbyyVL2SyyQ/sJ7bLDbk+VYhOMSxixW5IaCMXfbcnzq+bGtDjCcOMfmPyEWhbx4k3SbAYR1i9ljVYimKzaPvteVDGkZdV5xUtCdnhJ3lWYbLpKxyB+Ejp/mD2ErrxzmTUWWcspXQIvDVPRuOBGFjUvVfYV/UkxgwMr/zPN2GaKyp7/faCHzd5GUwK6DRewHRGZKKYeonRftnauGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IaJuj6XEigTkdDGlM71geYocw9XJR+7oG7gnsBo87s=;
 b=nPHzEuSYMwykHgFb0yhACeSPZEGl/dAJeotj39Gv/YVci3WnGgrtRtqoGd8mxKSaytf3bJ7/mDMwd0X+YCicNEiBlmHNHAEjZqXk+2dnQhBuS+zGbKlfxsVQzALg2JIQNfFZ/GU5bzRExWzMvRVcD5dzR/W85cMvIJXA/Iqp2sa0DvFyim6i93uQim4s3N4x335R9g0EYTSvLE6CEXuM2UZX3XfzWkJ0fX5OXFExSAUlIT1iRfHI72pqMZnJxOFKlbY7C7EuOjaf2SpmJ1Vp36EY8HVgP3BpbNBam8uF8+CdcGM9mGYLd86l5vZtQSmvArCv/0LDPerDXUXoYDF/9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:20:59 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:20:59 +0000
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
Date: Mon, 14 Sep 2026 11:21:00 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <2EFE2C9E-F2C2-4E4C-84AD-1E3525DDA9D6@nvidia.com>
In-Reply-To: <85c24a9b-5116-4c3f-9bfa-ea8356890c9b@kernel.org>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
 <20260913-remove-pg_private-v4-10-848550f7574e@nvidia.com>
 <37f9a01c-4f6f-429d-b221-73ceffd55369@kernel.org>
 <2CC856D0-3B58-4C84-AA3F-58D457344A73@nvidia.com>
 <85c24a9b-5116-4c3f-9bfa-ea8356890c9b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MS-Reactions: disallow
X-ClientProxiedBy: IA1P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::13) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a251a93-c37c-4a4d-cb8f-08df1273c7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+0+7FHt4+ZMoah740Suf7OAHUq1avk4oL6ozqiFFaWotkPNRFuxygWT32kH/hFmOMG/ebXh+pKciWAIoFU7uqjz18aVMxw+4ytPkzMRPjIyPWjimQiNkhDUlwLXtYjcxLbqORY7mzEt9Sv7nCmq8VWfAF4E8uah7hQh9HiF8xdKTMlTLyJFgOngmfhdswlcNdnoF4NFXDjbu+AjcjTAOsS3V/fUuj5LE71OT1AjeU7F1DNeBB7HNnf3AuMymRdYELMTuLWOSw7UkjPukOXR1YXuLCA1uM5M+9u41I9QkjXOE+1pFzr6PfLWh1by+K5VH3DlXqDUNG5/sTqj4azQYm+M80N8KjnPu35wkQG0QaePZ+PaakfKV/bf7/QvTt8+NpVzaYrp2eduZHPFPUqyXSZCe4n7Kua+INfc7COr6wtNFoeysF7chRoSfbBwiBsxIw7j2a9U+ZY1EHzscaYQz4MLQ/ZdCWtEyjZC6WGyCJ8hO+YwZ55OshPhZWQT2bwZBeo5vltUkKI2+pgOKEb0WBw1XrgODKAi/LQEka9yQuW24ATPOrHBBlKAL7jMNmlyrGPTDL7CFC1MnJJllR8AHu6q2Uzq8oRy5PBClURwq4+hl2B7+iHYtb2rckICIlLpBp9ADQuySwrZ5kMcHwmbuujckiAPM0egZ8du88kqd9Ak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdSRGE2cnE3Rm9HOFNESUhjNDZVVXFhNFFhQ1RmQUlhSENxRzBDMWxKdlU0?=
 =?utf-8?B?UmFMYUh3RVgwY0J3OEdiazQ3Sm1TNTFWRjdrR3FxbmtveGlkL2NGMStMU2FH?=
 =?utf-8?B?b1JZREZCTUlGbExhdWV5bUhES2N3MGhYZkVhcHlvbkt1b3IvbHY3NVpjOHJt?=
 =?utf-8?B?VWJkM2ZvRHMzOTBuTkl2UWdpQldHd3NKeHBDckZSdmhMbTlnNUx1bHBmTTZ5?=
 =?utf-8?B?NWdwTHJ0cVFtY3JQdVVVakVwd3NXVkRnM1VWbE41YUtoTGlaaUxHVnNzczVU?=
 =?utf-8?B?VldNVnp4cjhzdjZnTjlKRWxWZUlUY2dvYXNEZkhhSjFWeitWc1ZvZjFVLzdz?=
 =?utf-8?B?dkZBTGI3d1hCUTJkQ1R0L1hBN0JFQUI1VFRKNFZOYytpeU5Lem9RVDFZV1Vm?=
 =?utf-8?B?QmppQmRwVzJmWVd2TzJmRHVWMnFRdGZ1SWtqTERkRGZyRXBtVU5oZCtsT0Zl?=
 =?utf-8?B?dU96NjNwMzJOaEw5bi9FVEdoMk9NRTZPRVVYeTRMcWJKdUE1bzhCNndrWnRH?=
 =?utf-8?B?czZzWTlCQXp6SjJTbmR4VzJTTndXWFdPSGFNdUZOWGZSUWVueEhCN0w2MzRm?=
 =?utf-8?B?N3hMVkYveDhudktFelFSSFdVRXAxUUdkeGhRUWRQeWZ2OFNjSUdWaUV1WUcx?=
 =?utf-8?B?aURxU3V5c3hmVUptQWpRYlJMcVlZRS84RHZueG5ETEFUdTl2Wm5xcHFNc0sy?=
 =?utf-8?B?eDFwOWdDbU9RQ0FrYjhFT2hDZDBrOEIzV2s2S3BXKzhId3h4Sjc3RGtuTnUw?=
 =?utf-8?B?ZU13MjM3SHEvbTZyR1NvZDZjT2hRMWN5bnJMRzhyeW81NzJsTUpsRDVKR0dq?=
 =?utf-8?B?Tjd2LzZNbXlkNWZUTWVhTDFLNGhZUk14SHpMcUtMMkluMFBYK0x4NEpQMkRx?=
 =?utf-8?B?Lzl2cmNBV3lWSGpHTmtKSjNTT3cwSnM4a0hERUFmRDRjWUpoWHlOR21KUklD?=
 =?utf-8?B?eWJhWklwRGE2SUFHMFMzSUdDU2VNMG5jeUl0UGpqSnBXczJMOG5ING1WYTJo?=
 =?utf-8?B?MnhXeTB2Um80eTJzRDRBc0lyTXJDM01VQWdNMnlyRW01T2tKNVdmUnlySHBH?=
 =?utf-8?B?a2VNOHZ1YVI5ZGdiMEFmcEl2VXVCQ1lxekkrcVVHTDVDYm41ekpQZllIQ09y?=
 =?utf-8?B?QXZNNGlsQmFLNzVZNGdHQXpVclhFSnp1STFOWGZyOEJIYVZYVng0clZhUjND?=
 =?utf-8?B?VTYxcFR2VkFJL3VFSjNYMmJadzFLMWtZZk1vWllvTGVYV05IbDZmcHc4aVZ2?=
 =?utf-8?B?K245RlpXZ09rYTU2K1R1ZzdlQThtcnU5YzJhRGdOVkZHSjJVdWRsZVAzRjFv?=
 =?utf-8?B?OWVqV3Y5LzhIYkRWb3VORlpPVjhScVNKZGpleHJOcnByL1hNS2MyWjRuRHdD?=
 =?utf-8?B?bWVzMTlKZGpmbXJZcmhZeFF1ODhabjNZR3lHektuSFo0UnVHQmphQmFzVGZR?=
 =?utf-8?B?eGJQU1ZCV1dlVithTTNPZys1ckNtTTBUdjEyM3hscE4vb2oxUG51dEFmbVo0?=
 =?utf-8?B?dnVmN085Uk4vUWNRMnpxNXNEYURzVmFjTnVTSWJOODhpc0todE43Q1VubGFs?=
 =?utf-8?B?OFJMcFZKemg1ZFN0U0xSbWY1MEVBRnBZN24xUTR1QWhLd0dZS2xlMTYvTjNC?=
 =?utf-8?B?eDNzYi93bkVCTUhZbUx0OFhmK3dKVkdldHJPYmlxVWJNeW9tMDdDTTFUWE5K?=
 =?utf-8?B?SXZDaFpGYWdlN2tLMDd5OXF1dkdweUtaTzAzR3NFVUpXMmJ3Q3ZPRFREYzcv?=
 =?utf-8?B?WGlyUVZHNlBBc3EzWWNUKzgyS2FwaTcxc0E3S2lwdmxVbnAzdFVhT21xVEJO?=
 =?utf-8?B?WTZwb1lZNHRoaVpxQUhvWnVlVjVrVkZVQmJNeFB5d09kZUdNbTVLVERMRFpq?=
 =?utf-8?B?M1d2WlN3OWtWTzNMWnpsaGJHNi9WVmNNZFN4RXpTeTIyU0V4Q1VlMmVqMGhx?=
 =?utf-8?B?VlYrZ0Z4d2V4RzhZbW15eXN1TnNHSVFPL0dOSmxGNzVVbG5jbUNvNWVxa244?=
 =?utf-8?B?OHRMdkZIdjZWT3QrVzNaSzhqemZCMUZQSkpvVHhhem9IVndzU2R0YVdQSFQ5?=
 =?utf-8?B?QXF5bTdzOFo2TWVKS1VMRE1sR2doMjIzM2FkSHdESzcvQWR5KzVCYzBZLzNi?=
 =?utf-8?B?SDZ1bEtML1VVNXloR1I0QklHbmRkSTBtS0JiUG4rM3RPRy95Nk5CMVp5MTFr?=
 =?utf-8?B?dlRteVgxRVprczhRSFRvMEVUaVFzaGtUZUVWRWdpR1hrREw3eGc5TVZaR2to?=
 =?utf-8?B?U25oMnFYcE1XV21YaklwVzlLSEpGa0R3T3FtcjM0VHhSOHJ3Z09hYzlDeFdL?=
 =?utf-8?B?Q2tqYm45OC9jUVBmRFpycWlqYWNhZXVuWTJCYnJFRHdOSTdvVGk1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a251a93-c37c-4a4d-cb8f-08df1273c7d9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:20:59.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6qdZ33+dJk4lxDusU1j4Aso7JfwvFh4ABtejBkJ+shHYfY6tuFSae/xiEscu6rI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

On 14 Sep 2026, at 11:11, David Hildenbrand (Arm) wrote:

> On 9/14/26 16:44, Zi Yan wrote:
>> On 14 Sep 2026, at 9:26, David Hildenbrand (Arm) wrote:
>>
>>> On 9/14/26 04:24, Zi Yan wrote:
>>>> After the changes of the prior commits, page/folio->private != NULL is now
>>>> equivalent to checking PG_private.
>>>>
>>>> Stop checking PG_private on pages and folios and use page/folio->private
>>>> instead, except swapcache and hugetlb folios, because the former uses a
>>>> field (swp_entry_t swap) overlapping with ->private and the latter sets its
>>>> flags in ->private. Exclude swapcache and hugetlb when the code is meant to
>>>> check PG_private only. PG_swapcache and folio->swap.val cannot be set/clear
>>>> as a whole, so excluding swapcache with folio_test_swapcache() is not
>>>> reliable. Instead, use folio_test_swapbacked(), since PG_swapbacked is
>>>> stable when a folio is added to/removed from swapcache. Add a helper,
>>>> folio_has_attached_private(), for this check.
>>>>
>>>> folio_expected_ref_count() can be called without folio lock, so annotate
>>>> folio_test_private() with data_race() to avoid triggering race condition
>>>> checks. While at it, annotate folio->mapping too. Add data_race()
>>>> annotation for other lockless callers too.
>>>
>>> Shouldn't we just move the data_race() into folio_has_attached_private() and
>>> document there, that it can be called without the folio lock as well? Having the
>>> data_race in multiple callers looks odd.
>>
>> Not all callers call it without holding a lock. Before the patch series,
>> it is fine for lockless reads because PagePrivate() is an atomic operation.
>> But after the patch series, lockless reads can cause data tearing of
>> folio->private. I think I need to add this to avoid the confusion.
> Okay, but we should just keep that complexity internally.
>
> E.g., just teach folio_test_private/PagePrivate about the data_race, because
> that's exactly what worked before even with data races.

Makes sense. Will update folio_test_private() and PagePrivate() and get rid
of callers’ data_race().

Best Regards,
Yan, Zi
