Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2A37649B;
	Wed,  2 Sep 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371851; cv=fail; b=ghT+t0MVpj/8fCrYNQL+/jelHj+uWSwAq/xd49aMxHWYne19FS96N/tIv/W96JltKSlzbHrrNwUPjT8CaMt7uVfCqczGbffkAVVXY8mBXDwYvCzNGx1lgRWce4XbSWq0Jb7VSqjsejGCxuhZYx0ranYL2lyluwMGlR2XmQWqC8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371851; c=relaxed/simple;
	bh=aeSQMvd4AC5931oequhhH0u+F6yKVLXzqviIj0muTtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AF/C9mBnpUphKv3cqSM046VKUvBnmkPf0bx9SpuXceRXcfhAO5desl6a8eCUxf6dh5dnTvH4cbHiMZHHjX/1ubpETUC/XkqHxgofhW92fQ9NSZmmxTcQSPfxcuFjiJbHIksn/0JH30nwLjCfkmITBGU6jRzLBZy5tJF4vq1aVng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OMJvBiQl; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OMJvBiQl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMiBmahXk31agWsWFWn7Wth4QipRQg2TvmMu5QB7Y6x8+9YyN+rVqO/iDJEgNbr4Z8fFQLcLCWARD27khEjzx7WsUI7IOZ4c5EGD+W+45z7XikSaVmtRYaX9+iutey22U3kw4TbnhAnZ2vTB5RV/dk157FwIAcdvYk53ecActKL+huk6ugPihwd7RaLIcn7U1ihciOL2PORxnKpDliebK742oLGgX5E59i+wYpVdEEP6uAp6dIE4o8QbnJf5VoOad0HcSnz+cG5vG3ire5ZUR+iilxirkx3JgPt+aefm1wCmvknDNj8w5J7oyCJvK0BiOeiPaonRCvgw++T/p81S8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX+nrfmcjXNaxoIIwlqBQcZbjBTEfLxhDAVC8ShLeRY=;
 b=nCN9IlW49vPipwSnyk/2kpfYL5Y1ZygDV2gO2dkpPNGboJcPoBQX7k2HQ7Nj/ANdGOi33s4iGf+My9llqxkhZ9BYO57mNHZDfb7KAAljhaBybB+2aBnXAZjBoYVaclNtDxLZ+73V2fKxZEAUWp5Ln2QTzDT3KROK/AmW+VzTYhKmSyrFC7KnSFmrekyPkhRwrki3lqwCW1VYXGkqFcxRa9W98UDYl4y3jjnSPoSp85KQxGFMQPm/8cuHMNvQ0anRBaqnNCJ0cLlvqxg1HyBORUdtOU1dnGMbo/pkUBsrfV2a6XYvV/IZByWJ8F9spv+HmHOCoV7n6GW0aXzZVdiX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX+nrfmcjXNaxoIIwlqBQcZbjBTEfLxhDAVC8ShLeRY=;
 b=OMJvBiQlgUbqvgPqUVkwAqAjfZny3ZYsS3YEneHMTzqA5UIUm+om56TyU+9um1AwhU+QDD3RcXym0nuAnPrW2r5PTR9CVLmCNYWzYBl9DXfvi32Qz75q2obcbSRGhA9SuZ65lM/5rDq4G8tYCMvc8zTJouEK/kowNIJE5VCWLZDcH41RDQAUgNt46rvmLOThX2AJWQyQwPF/6mbFP0E8/9SuHoVY/ns6c31a1wOnNFcZ+p3ZZp5siJVwKV2ObD6y9Puh8ijv8FzEBRRaEcAOBH3RYkBnFE2nr+W427sGRUnNjQ4RkMLugfHGaVVj65U2Znw6jYQAW5x2L4WUvlh+Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 17:57:17 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 17:57:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: David Hildenbrand <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] mm/page-flags: remove PG_private
Date: Wed, 02 Sep 2026 13:57:12 -0400
X-Mailer: MailMate (3.0r7027)
Message-ID: <9A7F8677-8B08-4E91-B311-DC8C8602830E@nvidia.com>
In-Reply-To: <20260902170928.2227054-1-usama.arif@linux.dev>
References: <20260902170928.2227054-1-usama.arif@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0498.namprd03.prod.outlook.com
 (2603:10b6:408:130::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 116ed408-a7b9-4568-ef53-08df091b9f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|7416014|10067099003|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	mxEdFtoZCegLj1M18i8mALhHe87irVmplB+qc/mkWBN0CrVVYN50Ll2LqpuD49XtxANAiove8JsiMXMfAdGm02ooEZ7GdJ7P6+DJhikLgCDdU3dp/68xGgbYFQ+ev13ZaWQz9YD3h6qEwQBWgXEQyp5yOlbGci9XdXhrWCACe2qEaA+3Xp/7BPdy9MwDzHpuytL7V5iCQAQlU96+0fWZzCtU7OBDEPN7ydyQMsMsWrW2qjEa5lGnR4ZUnZqY3J0PsltFcR5xeO2Aga7WtvWZOwXwDiqOe0xrgaSVzLqauqGPMsmn6mekRWg/s4NLDQwWip9EtmDT0ky2/lCVsyXlqr5FYcymi1l95xjmJQtgoS3UCCu3fy2t5EHRzc5K9g5r8t2mO/yCcuVEcWFhSXb3ktFozp7157ujX0UKzFHXKJpCsZfvbGwmvb1Q4EL/tDv/mjKPEw9w7bLtxjrJ/MUgS3S5R2B/WnuMNa6hpsQgw7nbSNINhqJK3XiM/tVfCeNhkUDN+39k0ZJfKgI1swdG5t7S409VmB89ClB/fsd+wwihGSF6gvZ2YEcNoWAs8AErXUa0y4zVeBMpjfCjSY85eZT1wo60b6hMEn7z5swLQlOcWNNO5RKK6x4WsfBWuIfcBKh89htCkluInP7Vwwnb1ySLiyTGv/Ai+Fk3zVlG0jU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OWts1b110W0MyRegJjRax6wXrH3uoafA6h6xM+XFFsnVj7E4Rw4FArl4HRpN?=
 =?us-ascii?Q?6e/ie7UbmQgtPxsLLcv8HgllHH80oE2+m7Rt1hEwV6LdvNk4716raKiW/i6d?=
 =?us-ascii?Q?q9dwFVBpi38hv5XWu76DjA4170GQZwxyLtJYneY8k1PywWD+1ekCLcLMqCMk?=
 =?us-ascii?Q?VpTeiYhlBHvsjsPdWFMKC5PL4i7aWkDZ7A5SCl5lyhUNQrcqLap86NkAKrM8?=
 =?us-ascii?Q?AYBABgICIojd/NU9d7gydnA9q/H16IhpxkmueLMUiiYJRrstoaEnRaroghUJ?=
 =?us-ascii?Q?qwJh8GfjM1O2sKJxrwzMbleFaubFfVVKhpNXAWRh1gaMfkYBxzVOOyJllnpw?=
 =?us-ascii?Q?TYRh5QiLB8z3fNAKI42ytjbq9eW3Mhf1FGO6RlOUGSmAPf6bqYUmRkeOLLke?=
 =?us-ascii?Q?9J+B2fhaCBa+mjepCUmqVX8sA8O+bLFvAASlnNorcDQrRv9JCp7HaJ9ueF0c?=
 =?us-ascii?Q?bSIatBkBTYF0JfMhZir5DjN69jC8HjtIgY1lT1Ss06CvFgxUFriuU5wTZk+A?=
 =?us-ascii?Q?7N9+SxFpUQsdaFuskjQh2mZkCLRR8E8TbqLME1Ha/NMacbMAGt4aGsEGF903?=
 =?us-ascii?Q?zzZb6sg4UUutWpASiOkMrcD8UgY6iZBnMSvEgyaNHyWE83u8hexfmY1zV9Lp?=
 =?us-ascii?Q?CO8cDO0Ll0r/5PfMLXt8AfSEb7kbpV6Qp60k9vh9dAI9EkpPjV5pO2+l2v36?=
 =?us-ascii?Q?0orRO2Uhh7An75mIp5sB5TQzB0LiSJdTez62tViodQv58TUPPqth2l9jV0nF?=
 =?us-ascii?Q?AbwDm9XdKrEbX+YSYH5/itwE9mU0WR5rkPB9NdchC1Rr8r2CTWYT+QgNA61I?=
 =?us-ascii?Q?qbKcmG6AY46iDO7t3P3NKUw5pZs1jweAeDakc3ewmGS6qVoXmL0/Dd8uTGiG?=
 =?us-ascii?Q?3/geSmV/gZCyK4b6PHVLE+OjbXsVgYGrWKBE0lKmfX+NAtt6MeWkdSFNgKyt?=
 =?us-ascii?Q?ekLq5lX865XVYG21WCUdM5iqF7iVVHkLhN8tp57grgIQYofk0LVV0/EbhtOh?=
 =?us-ascii?Q?ive5iiC9g5bqeo+Ae6fnRpnkhS94qjehrI8ZzVBE1EoyYA9yUg5lSs4HMgl/?=
 =?us-ascii?Q?6MdYV8k+IEyaoDHtO9lkVDlXMCKLWYd8e59IQCXvGXrbYoFlcYtW+iNVN96O?=
 =?us-ascii?Q?ugz4Zs/VCP3/Ndyx/DdNbD23F7MfLBYOc1CfjZo4JHYoYfU7CApbKT/Iua13?=
 =?us-ascii?Q?JIm05AOCV0c3GGvDAbyLJz1Xp9r7CJX/CXM7Mmui5i85jSGanCADHVWisGwc?=
 =?us-ascii?Q?a1mlJJcmis0RRmQfleYAg6fOV6SbMC+7Snyt+XFnM3zR8EzV8Oq8CQmdPohr?=
 =?us-ascii?Q?3qJ0/qKH1sBnm8/lC2YIqxOa6ZeqfaWbO7xZ3zoZqow1pYZHzjpEBEDRNtqR?=
 =?us-ascii?Q?VddWAJ9VuTFF0iLg8sE8ZWZYRWYgDPna5hX5HHklunU19qkZGRruEtWxXK64?=
 =?us-ascii?Q?5obaxDkq4KTpdzBXl/W+PcPrUSWugOs2/pylNNoCBc+yekpHn4BJlS7ULjE+?=
 =?us-ascii?Q?4E8QaTK2CPncb3IHvvVCXHVntlXK7aomXazJmm+4LIRwGcKbRn2ARbDXB+ZA?=
 =?us-ascii?Q?tUW3Hjcxs+iLupkW0SAdQAP7Tqcbs8W4tqBnZvFaEiKIlhLDerkoknEb3D1z?=
 =?us-ascii?Q?qmw8E5xcIQLCXMnDptoZ1AmiJpbQHO2iw0i82rj/UmyZLvPAk0C2sDuwWvau?=
 =?us-ascii?Q?wNsmvIlv0V9ZOJsYmCHJS20SEBoeMae10eib14IBtuWPR/jNMIeO5VPw7/EY?=
 =?us-ascii?Q?xO0qoMZlVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116ed408-a7b9-4568-ef53-08df091b9f8a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 17:57:15.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAfb34tefFSDoffWUnF3I+upDhmdWwHhVmZt/CCxYCwsI4fStXyCjPgRd6cnsaho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

On 2 Sep 2026, at 13:09, Usama Arif wrote:

> On Mon, 31 Aug 2026 15:25:37 -0400 Zi Yan <ziy@nvidia.com> wrote:
>
>> folio->private !=3D NULL indicates a folio carries private data, repla=
cing
>> PG_private. All PG_private users are converted. Remove PG_private and
>> reserve the space as __PG_folio for future use.
>>
>> Also update files in Documentation. hugetlbfs_reserv.rst is outdated a=
nd
>> left unchanged. It should be rewritten.
>>
>> Assisted-by: Claude:claude-opus-4-8
>> Assisted-by: Codex:gpt-5
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> To: Andrew Morton <akpm@linux-foundation.org>
>> To: Baoquan He <baoquan.he@linux.dev>
>> To: Mike Rapoport <rppt@kernel.org>
>> To: Pasha Tatashin <pasha.tatashin@soleen.com>
>> To: Pratyush Yadav <pratyush@kernel.org>
>> To: Jonathan Corbet <corbet@lwn.net>
>> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> To: Jan Kara <jack@suse.cz>
>> To: David Hildenbrand <david@kernel.org>
>> To: Steven Rostedt <rostedt@goodmis.org>
>> To: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Dave Young <ruirui.yang@linux.dev>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>> Cc: "Liam R. Howlett" <liam@infradead.org>
>> Cc: Vlastimil Babka <vbabka@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-trace-kernel@vger.kernel.org
>> ---
>>  Documentation/admin-guide/kdump/vmcoreinfo.rst |  2 +-
>>  Documentation/filesystems/vfs.rst              |  6 +++---
>>  include/linux/page-flags.h                     | 19 ++---------------=
--
>>  include/trace/events/mmflags.h                 |  2 +-
>>  kernel/vmcore_info.c                           |  1 -
>>  5 files changed, 7 insertions(+), 23 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Document=
ation/admin-guide/kdump/vmcoreinfo.rst
>> index 7663c610fe901..5f1df6d080508 100644
>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> @@ -325,7 +325,7 @@ NR_FREE_PAGES
>>  On linux-2.6.21 or later, the number of free pages is in
>>  vm_stat[NR_FREE_PAGES]. Used to get the number of free pages.
>>
>> -PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_hwpoison|PG_head_mask=

>> +PG_lru|PG_swapcache|PG_swapbacked|PG_hwpoison|PG_head_mask
>>  ---------------------------------------------------------------------=
-----
>>
>>  Page attributes. These flags are used to filter various unnecessary f=
or
>> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesys=
tems/vfs.rst
>> index d3a93eec3945f..dec7816303c6a 100644
>> --- a/Documentation/filesystems/vfs.rst
>> +++ b/Documentation/filesystems/vfs.rst
>> @@ -649,8 +649,8 @@ Writeback.
>>
>>  The first can be used independently to the others.  The VM can try to=

>>  release clean pages in order to reuse them.  To do this it can call
>> -->release_folio on clean folios with the private
>> -flag set.  Clean pages without PagePrivate and with no external refer=
ences
>> +->release_folio on clean folios with folio->private set. Clean pages
>> +without folio->private set and with no external references
>>  will be released without notice being given to the address_space.
>>
>>  To achieve this functionality, pages need to be placed on an LRU with=

>> @@ -674,7 +674,7 @@ filemap_fdatawait_range, to wait for all writeback=
 to complete.
>>
>>  An address_space handler may attach extra information to a page,
>>  typically using the 'private' field in the 'struct page'.  If such
>> -information is attached, the PG_Private flag should be set.  This wil=
l
>> +information is attached, non-NULL 'private' field will
>>  cause various VM routines to make extra calls into the address_space
>>  handler to deal with that data.
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 9b585e68127a2..eb2961ed61018 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -44,10 +44,6 @@
>>   * Consequently, PG_reserved for a page mapped into user space can in=
dicate
>>   * the zero page, the vDSO, MMIO pages or device memory.
>>   *
>> - * The PG_private bitflag is set on pagecache pages if they contain f=
ilesystem
>> - * specific data (which is normally at page->private). It can be used=
 by
>> - * private allocations for its own usage.
>> - *
>>   * During initiation of disk I/O, PG_locked is set. This bit is set b=
efore I/O
>>   * and cleared when writeback _starts_ or when read _completes_. PG_w=
riteback
>>   * is set before writeback starts and cleared when it finishes.
>> @@ -105,7 +101,7 @@ enum pageflags {
>>  	PG_owner_2,		/* Owner use. If pagecache, fs may use */
>>  	PG_arch_1,
>>  	PG_reserved,
>> -	PG_private,		/* If pagecache, has fs-private data */
>> +	__PG_folio,		/* Do not use: reserved for folio identification */
>>  	PG_private_2,		/* If pagecache, has fs aux data */
>>  	PG_reclaim,		/* To be reclaimed asap */
>>  	PG_swapbacked,		/* Page is backed by RAM/swap */
>> @@ -576,7 +572,7 @@ FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
>>  /*
>>   * Private page markings that may be used by the filesystem that owns=
 the page
>>   * for its own purposes.
>> - * - PG_private and PG_private_2 cause release_folio() and co to be i=
nvoked
>> + * - folio->private and PG_private_2 cause release_folio() and co to =
be invoked
>>   */
>>
>>  static __always_inline bool folio_test_private(const struct folio *fo=
lio)
>> @@ -584,17 +580,6 @@ static __always_inline bool folio_test_private(co=
nst struct folio *folio)
>>  	return folio->private;
>>  }
>>
>> -static __always_inline int PagePrivate(const struct page *page)
>> -{
>> -	return !!page->private;
>> -}
>> -
>> -/* no-ops during transition */
>> -static __always_inline void folio_set_private(struct folio *folio) { =
}
>> -static __always_inline void folio_clear_private(struct folio *folio) =
{ }
>> -static __always_inline void SetPagePrivate(struct page *page) { }
>> -static __always_inline void ClearPagePrivate(struct page *page) { }
>> -
>>  FOLIO_FLAG(private_2, FOLIO_HEAD_PAGE)
>>
>>  /* owner_2 can be set on tail pages for anon memory */
>> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmf=
lags.h
>> index 935893e5ea53b..caf090cd6f85e 100644
>> --- a/include/trace/events/mmflags.h
>> +++ b/include/trace/events/mmflags.h
>> @@ -144,7 +144,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>>  	DEF_PAGEFLAG_NAME(owner_2),					\
>>  	DEF_PAGEFLAG_NAME(arch_1),					\
>>  	DEF_PAGEFLAG_NAME(reserved),					\
>> -	DEF_PAGEFLAG_NAME(private),					\
>> +	{ 1UL << __PG_folio, "folio" },					\
>>  	DEF_PAGEFLAG_NAME(private_2),					\
>>  	DEF_PAGEFLAG_NAME(writeback),					\
>>  	DEF_PAGEFLAG_NAME(head),					\
>> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
>> index 8614430ca212a..5a417f8a922ab 100644
>> --- a/kernel/vmcore_info.c
>> +++ b/kernel/vmcore_info.c
>> @@ -216,7 +216,6 @@ static int __init crash_save_vmcoreinfo_init(void)=

>>  	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
>>  	VMCOREINFO_NUMBER(NR_FREE_PAGES);
>>  	VMCOREINFO_NUMBER(PG_lru);
>> -	VMCOREINFO_NUMBER(PG_private);
>>  	VMCOREINFO_NUMBER(PG_swapcache);
>>  	VMCOREINFO_NUMBER(PG_swapbacked);
>>  #define PAGE_SLAB_MAPCOUNT_VALUE	(PGTY_slab << 24)
>
> + kdump maintainers and reviewers.

Thanks.

>
> I believe makedumpfile reads VMCOREINFO. Removing it here, might cause =
issues
> for older makedumpfile versions at crashdump?

The expectation is that kdump userspace tools will adapt to this change.
Later, PG_folio will be added to identify folios and has the same value
of PG_private, so preserving PG_private will not work then.
>
> Hopefully kdump folks will be able to comment better.



Best Regards,
Yan, Zi
