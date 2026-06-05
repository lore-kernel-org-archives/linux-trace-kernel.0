Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E140BCAE;
	Fri,  5 Jun 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686224; cv=fail; b=i+4hBxgznnSRmb837LzbRu1blRiZ2Nt+fGwDJLcGQm8BQV1DuUulh1mNCG89ZP+K8wtStI+WBHohLaknXiqLqbOdYDL6eQjlhA7jxMwFif2QGARHFPR+XuEpGWp0db2QB41zSa2D7wbVcqzbI5+NDGrAYf6+zpnzm1+ZrZSH7N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686224; c=relaxed/simple;
	bh=NF4rTYj9U6tyCQUROwDz1F/UyApbVPXBlFZmK1U3GWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUCmrlf+mumb7UWf8IHI+v+WV9f7oxcEbl7thrPk9eaSUj0pknYqFnMMaLnPdr0z5Koq1ttrZZV2CO1Xx8vmi12xh7yC+pmV03VpsQzUBLGagH0pxGBaWRmKGTCwnPGWuJsI//2LStQUE2jvb6XdoZKIIaojgQeoQKgMVlET05k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TtjpzMzd; arc=fail smtp.client-ip=52.101.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TtjpzMzd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fucx7M0MhzXzxLMLBD5vLgrzlpSa4UNkPxafBmY6Dl/A3xGoXKpoBHKLg6ygji+xAiZ/beVJyRz2OnwunN4YmNrkvtpEFV0zmm2iZ+k6RaF/YJRYFeBI+F54bQT4Yf+SdF2oEPClF9XquvR35bG+Ep8yT4fkIwv5x4lVJbKNLo+BFqzMEzu0HjRjwGwiyUTJ9s9EP+b3Dqb5F3cKFwfMtOBgpG7gGDqw38ytDhT16XZHOH/fR12j3ZXJWCqRQjfCC0TXvicLkQo2kscO6l7tdlFGxW5ojRCJs+tXWnFebSv0NIMnd2LDptv86o1gbsDcAXiUmmMPS0dNPdGSKTU4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5Zt1lYz8476Up6o6xsCXIvYzDKxz+lEH8ny8OlgWVU=;
 b=EkT/5tlNdtM82RVmLcnD0nfFF5q2NX+LQygaTnCUZmf2H4CmO5n1f92aqvfZlWRnVn6jKXzvAngF7Ys74bf1xr2tHEiJedX0TOHqnbE4DWq9audw6W1lkT/3HV39Vo/aPqOVGBf8RDeVScb5cca+54+dkgLUfI/Y2q/KmqC1xeymfhSsW4QsnE1aA6C6jCc0uHLWq7goJd3PtM6ZeFMd16tGzns2XOfZB8KkUiq9Be66cIb3Hqa2WVv4ftHJGOLNA7PuMx4ROXwfjnzYCJb2NZRODvg9C5CzhkhCmAk6pKydRxjmvxLDvdt0l3Ba+rHf4V7NMLE3vK5daMdy0rd2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5Zt1lYz8476Up6o6xsCXIvYzDKxz+lEH8ny8OlgWVU=;
 b=TtjpzMzdIr3gmleYjDJLa12FrK2MDRMkpUvX12hvboDKVQlyxyToJ977xEIQDQ71N500Xo/73eyYtmL4TZEpZRIMLwidzqLGAARM2x6KNgrepWk5ObiDUkTxqqQRuwdec4+ITg57VR7j2NMa86/4HdT8ZxgO3YNFRp3d2GdiQwIY/FuspSHrTU/nE5tlFkwLjbYXoSszKdjTgbm8nQ0XiK1xGWsjcvaTAUrN6/6PxL6civp8iRybkOQvpg/oPOd8YHgHXOQExTLfViA2k18iyH9G/o5qPOttqE8NYw0rJNcqOGQEgynPpOL3s0P9+n7+1nez134L5O4aM4LRn2EbBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 19:03:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 19:03:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
 gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
 jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz,
 vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org,
 willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v19 04/14] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
Date: Fri, 05 Jun 2026 15:03:16 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <89D0DDA6-9712-4DB3-AB8C-B632857BD281@nvidia.com>
In-Reply-To: <20260605161422.213817-5-npache@redhat.com>
References: <20260605161422.213817-1-npache@redhat.com>
 <20260605161422.213817-5-npache@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fee859-1826-437e-2e43-08dec335240e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|11063799006|4143699003|3023799007|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/r2iWY3zE1VZOHiO+fVXs5g/f9EI4hAvKx2s+TqwwI3bF0hWpGf8FXyGQxGkplgGSRNOhiBJex9vj/JsI0rYn8zPG2BV5LyZMAlJ9p5rJI4/OscAC4SxkCqZWreVCVlEXFO1j792IBpPh/1q2aVGeF27riUrFe7Mc6m0igzHMl+mcFuPLwILg5n2W2Bif6F2OKlp1gfwCC25uGMoAfeW/GE4WKzAtBmKT1sadFjuVPU9p4hR2bvfjzGZu9hm4E+bf+d3q3Qw+YnvCtp0gNOzFZwLBg3zXsm414Q8b3Vy27B44zQuupe8aQViKOK3ze/pUikUcbuVvpC5o/ET9qXrGaw6BaHLc5qttPnYQwytKqE30iyYOabZHy+1AQwVGtN4dTw7Mjo2jfhrAcBh/0HZ0/AdbMxuR3iFQVS0nmXoMWjwl4bwdkEXPiV1IkI3iSNXW9Y3m3gpIhUezigVeLl1FxUCQToxNee7R+Rw4FUER/q1mCylbIxIdCVewQSKwsPGLdcizIpx9eH3/8mjuzEElIpCi5KfMRGc8Y5azZlesuyQPcieX1P2jvzifOWBUneoxK767GN1qavJutOQXvPTV2+nfc0aQ0p+XCBNvCKXD93LcQ2ZjMRU7RJp1Sm8UDVLfTO1i6Bfld5HiSIHfYM3oPoX0GCG23ZZzOrZJsB+ph4EBU4ZdTD+tMGJA6i8S53H5wVKOUJXjXuBnvEpf8PfGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmIiCDwiyhA9HJuL3Xlu2N6lE7atA1P1l2eDOWiWf6+RHcwEzdtwowQihtIm?=
 =?us-ascii?Q?kxl6VWfkh0ZGpepfyIobZBmRApSi/Ah5PH3aeWhx0LxBGez1wFDaXFXuEb/E?=
 =?us-ascii?Q?lWm9fz1sy1AT9pXY0uo/Y2BeXR5TZPtoPO9J1oDb501cKTxx+wCstQb5DGQK?=
 =?us-ascii?Q?hJP3TXax6UAhNZ6PPG4etH9LXtZD/y+OMuYdmPxx/R7I8YIUo4p3F69lIbat?=
 =?us-ascii?Q?UGNTEazRblW1KxNyV9uhRCylsOw62zdkjgtObwOWk2itiZHmOq2f4kR7WAeE?=
 =?us-ascii?Q?zXEEvhK+DtHrWSG4kCSmlfjA64jzYps54IqwMd+RPrEjjDvyTG6MGcfpzqbM?=
 =?us-ascii?Q?YN7U77VCca2eHNU8aQAhZA7bAMDUphhM7ILyZ7Hd/DFpimvsuTjRzUWH42vu?=
 =?us-ascii?Q?P/CHgymrEnCPiA+vOkeIEw68lUCt5YMmVCj6ziygNRIppH1caNqgRMhlnAhi?=
 =?us-ascii?Q?Oa5jbH9s2+M5a6Lrdb6IxQmlg6LAuvVU+O2zMd/HzdiLg8OxdZQAcuejWyIs?=
 =?us-ascii?Q?TkvvxPXJZCNbQdvus03IzGHBtHLAl2kRA60/tKi+6tNA81Iuh7UZR+GybHDZ?=
 =?us-ascii?Q?L1+7V63uikN8wqoeWeU9eqdds/ZQunDxOBldHr7cMCrvC2lr27f181UqVwCE?=
 =?us-ascii?Q?D0vjvHmuSeKTd2xGwsg9TWzD0zhryNZ3YFApzAkimFtCz+aBDkOSBX4y6sPd?=
 =?us-ascii?Q?la/NMaaV+rBdvhaan+JAnAjI/2DF8RjaWN+9m8LkGZNHWSY2Bv/IczLuHS34?=
 =?us-ascii?Q?geQQ2udG1e3S1WoFbcOxbuz3yZVWBBC4+mn4esr5zRO7wHz6egYoxIdEzuzi?=
 =?us-ascii?Q?xV7IGhkeYGASLcmU5HnmH0xi1iGM5HgPc7KPKp5RhcSpvlqIZklpJYb0DyxH?=
 =?us-ascii?Q?v4Gh/Rf4lPao7Ght+s7w0lERcLxUk6yr8CCF1+3D7D0QjuNs1Js5nG6V37jx?=
 =?us-ascii?Q?SsiQBeZd4QGU7ZnSeX8e02tXC10tA3PSZ99e9Cnu36BX4dlRoHG18GuJE3f0?=
 =?us-ascii?Q?n+hySkJDerK/XbTiG9v7cOhAMeXOUSb+3xp35UdBGfI8JKXvzRmm+GIAQuPp?=
 =?us-ascii?Q?DSZ6W3mSpg0ELYRZzmWVf81S45lLHaNvdzvHGI0b4SCqlwRgTJQaHEULtk3N?=
 =?us-ascii?Q?57waJ2NA86+yDgjUFANc4XnDvWtZxinKUGbZ/WwEDbe5IhK1MfkRALmD3YnO?=
 =?us-ascii?Q?j/afZeMT6T1wOdMWaoXoyyRhs7iJgOhWRq6Ul/Sh1AOV7t2kVQlDEeKM9Eqt?=
 =?us-ascii?Q?xwUFMrjM0DfsP1g/r+SdAEpBW6fAhXSVS0GFZzn6Irx1GQgB2kwHiUJbwv4R?=
 =?us-ascii?Q?ziLXTFa8nzXR5jllzZG0C8M5QZ03/TtzB67m0M7Xg2qiSS0M8h9gQxhEEO4J?=
 =?us-ascii?Q?hRuLgEjxXp6izDqd+wz5t60cBsjsYBPk0hwUP/WVkq3otBxjwoH+9DKudzOk?=
 =?us-ascii?Q?3G6gkd4yDhm7/Qj7KvG6RL5DDIiMhj0G63tanwy9LhTJcbqp6oUuUR+V5u5t?=
 =?us-ascii?Q?KUYJOqiZRdNy+89lPQo59/NR3WcGWSK3Tzk9jneabBNzlw3WTRrwFUSnSeBx?=
 =?us-ascii?Q?tNU/NavBikU9AygGsUsjgVkSYTjCO6JeKYGY6EXCcZF/SCMzL9RaGYVqyPmr?=
 =?us-ascii?Q?Yxc/MPqTwC9OgHyNyO1VSQsXLg88gUywSyR8WREhQ81gnUWieaDFM58dtP3I?=
 =?us-ascii?Q?4pIHvf1+A3WQqaZUQHz5pIqxcdsZzYqhw3ybZWZecWBRE0Jv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fee859-1826-437e-2e43-08dec335240e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:03:34.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToqjogQKfgJn4dd8z/tPnuhNwQHbIUaAEVy2GGegn3eJe9f4w/M9GJYw4XnqsgRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

On 5 Jun 2026, at 12:14, Nico Pache wrote:

> generalize the order of the __collapse_huge_page_* and collapse_max_*
> functions to support future mTHP collapse.
>
> The current mechanism for determining collapse with the
> khugepaged_max_ptes_none value is not designed with mTHP in mind. This
> raises a key design issue: if we support user defined max_pte_none valu=
es
> (even those scaled by order), a collapse of a lower order can introduce=
s
> an feedback loop, or "creep", when max_ptes_none is set to a value grea=
ter
> than HPAGE_PMD_NR / 2. [1]
>
> With this configuration, a successful collapse to order N will populate=

> enough pages to satisfy the collapse condition on order N+1 on the next=

> scan. This leads to unnecessary work and memory churn.
>
> To fix this issue introduce a helper function that will limit mTHP
> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
> This effectively supports two modes: [2]
>
> - max_ptes_none=3D0: never collapses if it encounters an empty PTE or a=
 PTE
>   that maps the shared zeropage. Consequently, no memory bloat.
> - max_ptes_none=3D511 (on 4k pagesz): Always collapse to the highest
>   available mTHP order.
>
> This removes the possibility of "creep", and a warning will be emitted =
if
> any non-supported max_ptes_none value is configured with mTHP enabled.
> Any intermediate value will default mTHP collapse to max_ptes_none=3D0.=

>
> mTHP collapse will not honor the khugepaged_max_ptes_shared or
> khugepaged_max_ptes_swap parameters, and will fail if it encounters a
> shared or swapped entry.
>
> No functional changes in this patch; however it defines future behavior=

> for mTHP collapse.
>
> [1] - https://lore.kernel.org/all/e46ab3ab-a3d7-4fb7-9970-d0704bd5d05a@=
arm.com
> [2] - https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@=
redhat.com
>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Acked-by: David Hildenbrand (arm) <david@kernel.org>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 126 +++++++++++++++++++++++++++++++++++-------------=

>  1 file changed, 93 insertions(+), 33 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
