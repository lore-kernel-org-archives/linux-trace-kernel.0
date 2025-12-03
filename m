Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFE2B9BA;
	Wed,  3 Dec 2025 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764731032; cv=fail; b=PPoIPmpRcDNfX9eQkba8KE6GIz9sh3GK+ps/sTgsDguNCZnL25Av7t1i9FIt+TYj2fYCUNEVJoWIw0UNBIp1NjA8OdBI82SIix5+kZc7vUDA2QRNHM+BMXqWJYZLjLVYH16aqmMwhrCYjabJhDFQUeCp6KYW8z9h2GExgPCbIc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764731032; c=relaxed/simple;
	bh=LcdS1/j5doDegLtAPe2XBTXJKiUMjaQZgkOu7lBpWGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paZ7iaXWcfpsWAlNWwl90vPXgjkIScHSqr+5yi0AAg5DmG6PhdceZwRxBqM6WClG3fjIy3EywWWHOpZ8NvSrjkkmWH0WNa9izOpJppuRIo4iF1wGd66siym7o7N5ctTjoeUcbq3TQSd64TQV7gzsyyg2gS5qb+p9EmBiPMtZEsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lCx+H1wb; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lCx+H1wb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJf1aJrMsgTJt3Ie2gBwaER/aJJtbe8re1vCBC1koVpuXIX82BOFpqn3jVGTpawPqVJcIGPoDO8HgWg3L01jLPNiF0ULAUtMHUhF3uh9rudchC9j5Y1MVpLUTSfY2KeRUwW8y76N+QVrdhYzOLaPV6qCNyxQeAdb6VmYEEMTEE5oftShKOWbt9QQNJZwkAVu6g76oEQUuE4VTDS6hq8uGxIosWaVfC9Ecvv4RJqE0FfWzvSxAda1Ujba2HOpDrM17Fr5mOEHSEDwAuAjA6CRi7aEC8o4zOpdCQSvPJVb7AUMwv1WuuPxiTpjYNv+zyg3cnQ86JHkUYQPYdOFSzSvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgA2tN5yyMtbzoobyca4YX2IwNu5VEnxI/glY0vVkkc=;
 b=njbCdnBZhZj+y2ewTRxDq+hCfoc+t/UUa2b96adc9L5NTeBssQHlUBL4J51nsQ6E2YjSz9fOUrJlOTF4immndQmDMlFTn2JTMiM4xC0kOG8DPKznyzBoFNeSEw2pn9Q/1LHuXDVcnvSy2Q3T7PXZ0rRR/HoSouRnUpm6QspcMICKDZmU99uPGpJi5nDyTY/COqR91soxomqB+KVl+Vcn6uJIvXrWktC6RpKtGzsR+8MMfjbBKK7RACXv0CnaVut8nv7t2YBQNwzTUTgC/1wAMHjvpCAKqYHfFWeEvMKp6gVSLpTuta9/1EVJLuQ8jVUK8LDGoQJTM6SO6iFptiqoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgA2tN5yyMtbzoobyca4YX2IwNu5VEnxI/glY0vVkkc=;
 b=lCx+H1wbw4HmZOX+b71ypPWzXJWTe/fviKHChO2byIearKZf/qP93bIeFfwCuteailYr8bWtlGhXDQCKPaDyd1bQwOJS6UQhKHlKNEhrf2P9GdCgE96CeSYykDrlmi3BXcDwzXhO9Rl91hqZsaS22EEDQVTzGgHsjaVY7ShPJe2ILWd4uZZImh76FJ3Ep7AtNV3JXK2CyBFRTPlP1SgumgoKjPR5Jb3WNeBB7ozSALsaSUNraVnOrYv+8MV4d2WRtc6RBuY7MOXhTbG9Q9JBmKCQUYxvvIrcQRcDQEMbpgwD/6LngXCzwv/iCV7Ys88XyDNLsFNDWEHUefy48MvK2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 03:03:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 03:03:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org,
 willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
Subject: Re: [PATCH v13 mm-new 03/16] khugepaged: generalize
 hugepage_vma_revalidate for mTHP support
Date: Tue, 02 Dec 2025 22:03:41 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <1883435B-66AD-4FC6-82E3-16355BAC446B@nvidia.com>
In-Reply-To: <20251201174627.23295-4-npache@redhat.com>
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-4-npache@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:208:329::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cdb211-9772-4ad4-94bc-08de321892ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3u9z5VCsyg0wCObvBdVi6Yx/K1+HJDykVDqGQofdjnOq4jSGvKJPvA17kc9c?=
 =?us-ascii?Q?S3CZMgacLhKdVWlxFU6wjdxBRDLOEjm7rUfZDcm71NFUTCxqoLkVkpFifjyH?=
 =?us-ascii?Q?fYIOFSu4EekJlYmYuOPcV20f9FJgYoEEqW3Pi2cWMlSTid92pHzMZgzgcHc7?=
 =?us-ascii?Q?fq5H8BUeC90E7MhJsimsGEp4MPDWXFNDKVCuN1VliwdAT3PRFU7pkBivHpmX?=
 =?us-ascii?Q?0Ntrl9PlKW7rWmlkudQToD81kyPH2bxg7t7oB5Q66vUh16sz8KYTQWAB4NTq?=
 =?us-ascii?Q?gba0YMT0PvzsGIu5KkguEzyb9lHmQ1BbRUjIRIReI9qUqDTaC2jaNh1fMWTD?=
 =?us-ascii?Q?663K1+YhPjlym+m4GOx7u1QQ+b4Qc3InfM4tBkOGuH2QsBk1zdEaa/qYJPP8?=
 =?us-ascii?Q?wzsvcpQtqwtex9t9VVpNuQYoHMWYGslnF2bKcSLsoMWIHMDa8+UbvjzP/k/U?=
 =?us-ascii?Q?QQYCC7BtLqCuZmDyJmxZgUYP/1Q+BvYJp6TJfHPRG54AlaZbUcL2mijYro8Z?=
 =?us-ascii?Q?LPItZ44Nibi99x6w/DRyJEzYZ0NHJKrwHtkr3yKohiOc7qQNQl8DSxmLEWGo?=
 =?us-ascii?Q?O3a6bNBbx2+F0vHxmJzViMS75Twj8emRRB84PrYDYKz8LVbJnLP7V/3SVfZ5?=
 =?us-ascii?Q?BKguU10GhG3mtbkUkzV2aKn7aXJvIbLfgyMA6MVl6z4HO0gXyzZTz4PqlfNx?=
 =?us-ascii?Q?5BIHjxWYfIHgXiJ7CZRiJkc66FplwFJ3Li+a1K749GUJq7/+HoC7QNSHV+h9?=
 =?us-ascii?Q?4+nK/t4k4AiJZ3reU1SopE06S+Z2tIAQ2Nmpq7ejdIWCzXbwGcft5GuqvhGx?=
 =?us-ascii?Q?qklHNoIg9yKcw08OgJvIsvxPaztmHGqjOPKWYZP/EnvKxPSVdQfCi4yysZWY?=
 =?us-ascii?Q?+QcnVLY6PsOP6E7Qi0zLMjb+11RrFttsEW+i0xEwpYvEnKKp7AcV6EFGK2+k?=
 =?us-ascii?Q?M6ppApqKbUhiYo/KseXQtocg1ZJ2KtthGRA0pHi4QQO8jK63WdcmCA5UpJGb?=
 =?us-ascii?Q?V1eGnTBGXaCx60E+cvoBFkB3YPsOOC7JWyWbytW+PXtlpB8VXiMeWQrvqmFF?=
 =?us-ascii?Q?3APiuzWz2jHpthPWUoophlOeXovXtLrrvzrPojcsLHSIYeBHLbSR1FBDagbp?=
 =?us-ascii?Q?IfTJ78e9uqJeFWIMVmK63BBL1Xd2XcsXMzgNR3ZqmmawsAk3vIZShZdx61Fc?=
 =?us-ascii?Q?InBhDXZSqThD1kXbcvk3V2WGoacp7Pas18WnbvtWXwsUY2AX7x5bf6fNKgst?=
 =?us-ascii?Q?FeMiuGyfj82iRIBqrnNb6SIDgscaGGMRSgB2QwIkx3lbAT3IhYtSCR4DM+M+?=
 =?us-ascii?Q?lsg4CMHI859AGhu82/WZsdkndVWnhx5DBXvAN54XdEUidiPTQpN+1MmoYasf?=
 =?us-ascii?Q?JlOm+MJU/qXVqZ4hH9ylq1kcE1SdFlFNIx5Ogd+LC+B0xLveKrXgb2R40chW?=
 =?us-ascii?Q?zFq35yeDduZQR3toX4WRqcXAsk2Kokbb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gxIeZ/uMvLd4D3xDIOtZp051481xVGeCfsqEq67DXwmTtOjdt+KA/HqE/Slk?=
 =?us-ascii?Q?DQ6uDPGBvOsvbPpHG/sE8W3h4Nn1pnR9FN8GzylTpWgTLRKcTEFqOZEEzckf?=
 =?us-ascii?Q?BbBk/41ZpqC8jWQ4iJzq8BMEWTzWhpi8bgITU+AjIZCIaK4AM8PkUXIvkEXQ?=
 =?us-ascii?Q?g3uxXPqTZYVYjr4GQiay3TvoPSQk4IWBbBcZqHPeUv6vNYgFiHOLRaurkVTP?=
 =?us-ascii?Q?PM5tNPPo+I4cqGxoFdalzxhGYbaxJl7T7Jkb9UOJ7eGhDeBs0UDjhzk50y3y?=
 =?us-ascii?Q?t2Y/ZiQUUSlqUFO0oydMgne9QU8/AcMzMU3abcwQoxu/OBWkaxp2Alw5ajRR?=
 =?us-ascii?Q?3M6+5gGdLlt+ShfSgITI8f5vffzU4krv8q8nW2Vgfbahgy8ROzVCXGodhuAJ?=
 =?us-ascii?Q?P2qDoFa9w6Q80OMPVGitWHeZKiErVy8xk9EuwFVwdhl1GdEfBd/096pWHJDR?=
 =?us-ascii?Q?eXq5/oJyO6bv6MQdA9QamkeHNw6kvHAPG470jjOhmCOa9zq9MkId1ByqX1c8?=
 =?us-ascii?Q?jTfKEsmnnWFuwuhC51kN+RcpE5aENm10KHqnJWWkpRV74DjeWkDCrwjjCb0K?=
 =?us-ascii?Q?DjpZANE/zKCFS78+gHwBScxL4zfSS4Lj+H+JGg3p9hRkO0C7ztT8Bv23uk+p?=
 =?us-ascii?Q?Qs+i6sjewxNs4VkuYIRZahQtaBULoJ4xG4C10ds144Bu1M+UWl+umlldYUYD?=
 =?us-ascii?Q?W4cHtRTqPDXkhcEHpvDCSVdXYOItiMVIY371n0e/xYiQpiFBKnJJmi7BXRfs?=
 =?us-ascii?Q?gebdZkGd97MfoOzaIDO6pYwF3IxAqcNhS/yD+YjDyXZkiauN2dI1CfvKZ4Gr?=
 =?us-ascii?Q?bAJGNGE8PD7TzP+qpJvfyd2EO29nagV331KhAygDC+zeKypaBZPNjRUF8q2z?=
 =?us-ascii?Q?QPF2HkYsYIIyrZEtbsYtfYP2KU5RtHHu4NteuQqDIXOLranpBVXfa9I4lvu9?=
 =?us-ascii?Q?CqSECQvC6f+KscYM21ityC5bSalSu/4HsS96pPkS3OB0g/BIjECPjF9SfT0K?=
 =?us-ascii?Q?asabtMsoql3fEG2cA3csBqj9aNzVlKP6CYMBwaAr7HuoG3wR+4fDFifoim9E?=
 =?us-ascii?Q?R/V37BnreLoYAqL6cCf/gDtSxIY/KKgM0kQ/Au3ZGJpJXjgol8RprK0uj6U+?=
 =?us-ascii?Q?ZfKQE60+nqDHA613GSp3O9eM0FFCvcl7La7llm8frs+9jFf96K92yKKJhy/y?=
 =?us-ascii?Q?OXKU4Q0Skxbk3MpAgSdomln0PETLjMmlITLuDAVclUud6vuOFzY0ti8+Rbnv?=
 =?us-ascii?Q?h0CRiyuDv3YHodh/vrgwpJwxXsEbnrPoarzzNdUh+tN9oLJ2k09JmctRXf7F?=
 =?us-ascii?Q?5WeGCO+FT+GRYkMHLC2dSRDZXv6Mel1yf1OiXWkWhFQL1Udj6PcBTwdiByhB?=
 =?us-ascii?Q?Csjd/olTbKktw0uMBs4wZuNKKQF7vFzTkd3WuaqRDWs2p9OKLL4momoovOqv?=
 =?us-ascii?Q?P+eRrtuyt3yaLqAHHTE9kzTneUnopigk3jkOS7/B+NTjv6Qcj3pWsipAAFaD?=
 =?us-ascii?Q?dZ3jpxNDE63zLNJoBH/pvJYbm3EdqTS9ylOH3HwzyoyzFQCS5qfJSKqMnZa+?=
 =?us-ascii?Q?geFvU0+UcmEd8GudGn0A1tHHB501pJotvRwzI3Yb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cdb211-9772-4ad4-94bc-08de321892ff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 03:03:46.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zqXv0Q1R0bD3IiefEZMs2SoYH7BLxNKS32EZrn/Z0jd2HMzkbseOuC2LVeMXFJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225

On 1 Dec 2025, at 12:46, Nico Pache wrote:

> For khugepaged to support different mTHP orders, we must generalize this
> to check if the PMD is not shared by another VMA and that the order is
> enabled.
>
> No functional change in this patch. Also correct a comment about the
> functionality of the revalidation.
>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
