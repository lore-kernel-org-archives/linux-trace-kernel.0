Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283B46D0A8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005133; cv=fail; b=KenmsxuJvwfSpbO0MbGVYcrHWtcOv/XW+g5kiNv2ytsUmCsHlT1zoURav0XJzmC5W9l+sff+fj53rofTeF0N7cOHZM0Q6XALa66tx1R9/lemMR3YRwr+sRkufuzDIN0sMk9tmWF9RwgwCzHV79AWgijOyZp5iM2IuJ1wEX0lVA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005133; c=relaxed/simple;
	bh=weC1DoDyZRtJMxpdNVRLmJuguixYzWWTssEyQRJmzr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f1IQnzLeu7o9u5856wAyt/pUFT+suPmy0toGKH5QaCsFjvpkemgalKn3wTPQuyEjpdmzx+s2IfJc37qyxklwlDR2UfwNvnYiDllDulRSUknryqN1WOw4wFQZ25pHndiTs+d+MSb8iBHii0uMNHuYnTQUq24I4NMbKRZZthF/PqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxCuxx6Q; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxCuxx6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qf9vQlF9z2ZOcMVYXIbgF3HqCCbuYmn5Ma/MHk/5/CDU/FZqeOfSnppk38kdgbZy3GWxVJ11vUUva2r+M9raR1GhJtbolyR1MqtDss6hvfYIoPd2rstAaBJm7Nk9rv6XAAnvO9Yp4I0bkRNiJsc3KIlkDEF7j29h26TOUFJUdfmX8qtyXRZfYcI9ruqhPPE/i3/D/22huGXxUw+wBeseCsTfRIwzVngF+z6kKsSuREXZAafpNVra7XdIHxyAVoM+Ya1fXpnHM02jatqRS3Lc8jSBH1BN2bRAGRVOJnj7dK46u6OHi3Lel5pgCD0ZHIPA3xFjvmtOTtowZCFGgLPOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXkyLryEaYSn9qDcAcWjBRg8nMy9IPir4ChvrSQD2mA=;
 b=JgA8D6dfv45+vYheqK9UGx+xhNg+bhvM57yNx6FiGeyBVvzgtv8FUJbeX1xtELfvF2m5j/2wpY0EbUcqvAoqDAfxUI15LCH0mTt+8zYeJQSmGOEwdX6UOti6Ll2cZ7C4zlK7Lln6KefwHMwaI1UNbiEnzpwsLHFMfyUimuuwzQISoQdrLMreaIl6m/nynQIHNGWbAw82a2Dr/W0ItHHgjB5HuTZNnjYJ54uYWAyWmoJOF6jguMqqD5ZjYN9UwDp+6x3unx5ASY+cASt2fOeW5+u1KeTydLi5oqAYzlt1BGnK2MGB98ZkD3dKGADLRAAUeKIQzNwbpjMXIU8+ZY1r1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXkyLryEaYSn9qDcAcWjBRg8nMy9IPir4ChvrSQD2mA=;
 b=lxCuxx6QfZtMUPKgSoWJDNnnmlkwc4c5/Y7HnZ3bhLoRblmqBFmSN4pFyK3npcasR73Q4nt7bV0Ntoa708nInHZFAnayQG9xeQH4J3f7YLEaTYD+WuYIXGvZ25WR1R76rtFCilGTC76jL+mnj7SC+xEG5UE4b5FTiPB0HR6cZ+Vca7Mx75YIULVftmmCztG/kLZ60+M25sRKVBZ8MobuiqKZwdFIw/5yYYTw3BKbtOc23BKR4hStCReCHI1CA1agq/jSAxw/dMEYDTFIbMMzRVj8TYKGmJbIBDGber4gvs2A3y7F/DxvSrBcmex1KMyc/pNPll2ILwLcBCi0M8wlEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LVUPR12MB999186.namprd12.prod.outlook.com (2603:10b6:408:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:38:42 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:38:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/17] mm/page-flags: check page/folio->private instead
 of PG_private
Date: Mon, 21 Sep 2026 11:38:40 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <2F224947-7601-4266-8A85-7B6B3410C289@nvidia.com>
In-Reply-To: <20260921024424.F0F951F000FF@smtp.kernel.org>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-10-bb68b6a21869@nvidia.com>
 <20260921024424.F0F951F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: CH2PR18CA0046.namprd18.prod.outlook.com
 (2603:10b6:610:55::26) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LVUPR12MB999186:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6f6985-8a8f-4e9c-0f43-08df17f66a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	pZnXHy865nfCVs+WFwHgP/UYYaIu7W3DfFW7Jbf1HYgoLLwqYvYPJuBDeJa6HcAYFjOlhkudbwy2SzutWbBqi/c9SGgnAHWp20tRqaUW7bQ801wSzpOfFsJwGaKsRZcce2RahL/ELyC5g0/x9okiDdj7AGluroX3bNONtNIqOesCOY0YnSENlP8sN60ltywG5eTQvW3zIJw8F1adQ3cGgcm1XYGIwPo7W0fSvNGUuXd34Ra8SCxQ0LzAIpU++IbP0wVwQr1cDFE44VtK215oq+oeR1e1ldMAX0vXjUyljY0I99+Qi1GajNBA4uCBgdliQ9fiL2Yw41W1bpBsJv7V5e/NrEHgC6Z8kYkJHpO2G4plDDbb4X4tqBLUe5ZBh+aJ/COrEDah1+Jn+lapEhcK9jcX/cBADX3iZRwvtrNRhx417+Xcie4KizavchjhRMa9nTHAZaHH47dCn7XF2qTUkERSCJhMjugRpT8P5upAjVfptaBKY5mACAqdpJhaJQOp4iKmowigw4uwDIHEYWTRtJNejw7V6yiGo2TzGdrss2GwPEdmW7IUzN4acAqdz0RKWSWyL9LZpucN4yeVs1lo8roId9zK85dpUkw81yvzs/O8wLc9RrdMVaog+JyJuj8z6QU74ecQoS2ks6vdAsnr5YiJw15B2Cjm1+FeN8grsi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek5wNmdpWlYyRFpGYmFkN0FveFo4bXBvS2Y5YkNHT2VLTlhxRzJJTlhobVVT?=
 =?utf-8?B?eVpnUmRvODREM0xBekFnYmdHRDc4cEdFQmo3bk0vcGJBYXgreWIweU9ZSTcr?=
 =?utf-8?B?ZDNYTDc1QmhIdGxIUWlLRVRSRkpPVXJueHpYclBjS2dFbzJON1Vjb2t3UWN3?=
 =?utf-8?B?NVdCV0ZhRTdlbWxyOEdXeHlMaXk2QXhEK2N2dWhlTllIdGpxRFJpeGFNY0wv?=
 =?utf-8?B?L09hd2VIeTBuWnlLSmdCR2x3UDZ4YmdUbm02Um4waE5NK29WZ0JLajJmaWJz?=
 =?utf-8?B?NjdVZGVnSG9haXNINUlkcnVxbDlrREdBZlNJNEdZYjBiVFQwSjRCRTBibjh0?=
 =?utf-8?B?WGxWNjFGQ3ZEOTBOVmZCWmpFMGpnUXFiSklZSXZNeHVUUmRwblp3cm9NblpE?=
 =?utf-8?B?bzVRUkh0c1pqb0Q2aEkxZCtveU5oek5wNzJ3NDQ0UzVMYWE0N21pSWhEckt1?=
 =?utf-8?B?UDVHdlJRZzh6dk0wV3ZaekZudkpZWFBneC9mb1ZqcUdIcS9mVjIrNkJlSDVJ?=
 =?utf-8?B?Lzc5QkdSKy9jWHlzVXBhbjE4QVh2L1lFcHloSVVrdDZDL2FZalppSXdxS1B2?=
 =?utf-8?B?TGFGS2ZCa29CSjJTWUs4TlU3T210U3QvRGdCbTMwMjNyK0ovZHZla21UZmZU?=
 =?utf-8?B?RW1zVG03UDZpOGMyZzBBdEEyWi95QjMxdGRPczFodWZTUW85TTNhV2VWeGZZ?=
 =?utf-8?B?OXFTVm9tKzV3bHpoanhaL2tCOWw1ck9JWll1UzBjLytqdWVJQUtZbC9WNm5j?=
 =?utf-8?B?b1NjQ085MlJ2cnNKZmJvVDUreVI2aysvVGErQUxSRmpYSFZBMU0zeStpVUhr?=
 =?utf-8?B?UnRIRVFMTjRodGRiMXJPUVBReVE5TjFTMUI1SzNwa3NRNFIyT2tUYXRVRHZH?=
 =?utf-8?B?T3pSNktqU2VEWVQyaWZxQUtRL2NpWTdQd215c1ZKOG9BU0xWUm9tN0JSSk5t?=
 =?utf-8?B?bkJkbDN4bmJYVlkwajRRK0RNbHMxN0s0d2paMkErNVRXQ2FJQk5CUUxNVDRy?=
 =?utf-8?B?ZVZwMVg0UG81cUJXaUlKV3pvWnVjcTlUc1Btb2VHTjZKMXBGUDNuYmJJVW1n?=
 =?utf-8?B?S0UxT1BQY2N3b2dGWUxCbytpU2w5OGRYWW4rd28xbXhNKzZnb3VzbHByVEk0?=
 =?utf-8?B?RkxIb0NDOUFvM1pmQVZLMFVZUzI3WGdEMlRHOWVSSS9PSDFrdDNuL0oveVZB?=
 =?utf-8?B?RTYyWFU2VnBiUFVvY1BsN29HV0VhSU9sYTEzWUJ0T3RhR3dlazNlZVdOYnB1?=
 =?utf-8?B?N2V6UC9iZENQVHdGZDF4c04wR3BKakd6bW41MGNWOG8wbVNPWnJuVktPR0xn?=
 =?utf-8?B?YjRaNWxiYWVwaXRBYTMzWXZMNndvY1ZzV3B3NVF5MnpZZWRBRE85SWtKRU1N?=
 =?utf-8?B?Mmx5RzRkaUgxR2E1MDFXMVBIMEgzcGNENmxJMmdwcHEyUk5DcnRRVUM1NGl4?=
 =?utf-8?B?YlhIaExiWkVzMTB2aVFYQ0lwT25CT3FJdVJDL3Vxa1RTTWYyc2F3RjJJSldr?=
 =?utf-8?B?OUIveU01QlhjOTRrM3l2aDl0VS9aamtZWVdKNkFrWjFldHJ2cFF5WGhjTDI0?=
 =?utf-8?B?NXBJRmNpWHFIYWpEdFY2NGVGTE1EdklUK0NKeUVoSEF4QWZvVEc1N0Q1OFdY?=
 =?utf-8?B?cUx5TkZuYzluNmxMaVNnMmdnOXhBM0FaNnFIaS9RMUkyMkh2VVlZNllNN2FI?=
 =?utf-8?B?MUl3MjlodXFkcUJWdUs4NkdQaFdUYVBtNEZHU0dlQVRqUVpkRXNDT0l4QkpY?=
 =?utf-8?B?SGY0bUJWK2o4eHFMUDFkcG02R3BjNW5pRUM1Ulh5bGlSMmVkbFlDNk1Fb3Rn?=
 =?utf-8?B?QmFSSmtKalkrbFFvOTd0cmtRS0pUZFRjbnFmbkw1Tjk0V1ROME00bHEvYU5v?=
 =?utf-8?B?TjdFcGFlb2grQStURkJiT05JK3hZeGtkSEZKVDF1anhIOC94RGtvUXh3aitv?=
 =?utf-8?B?MkZEWDg5a3lLeXdvZzVDV042d0hlR0pNMm5rZS9udER1T3g0cHA5cU1VTVNF?=
 =?utf-8?B?WFBvVjVpOWJIc1pTVTZlaE5JQjZubEVhcHJhdkhKeU1nUjBCd29Fdnl4TjI3?=
 =?utf-8?B?RDBVRWVRbCsyZHBySXRIYWJYSldYMzMrYUZzMHZqMlZEL0x3Y0JtbUpJSG1t?=
 =?utf-8?B?d1Z0UmhDMWdqbzNOVEo1bHJkTk52QU1LS28rZUtlZ1ZuYVRKWjFuVnNjbDFt?=
 =?utf-8?B?L0wrbDEyUUpkWjZxbVJIL1E5L3ZaWkJTTHk2SjR4WnhNaHQvZVNFblhsUHdM?=
 =?utf-8?B?ZTM4RVBTMlE2YmJUek5DdUNrWGtOK2dFTG1YbjhBQWJrWUxnOFBHRlBpN2Fj?=
 =?utf-8?B?Y1AxZW1zOWJIb24rNjZneEJ0Rytkci9nNWp1WWRCczYvdVFiWTZtdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6f6985-8a8f-4e9c-0f43-08df17f66a46
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:38:42.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PeAMg/OqmnmgKD7ToPIkF9Sdqn40jLLlvSCYLXrzdqnrO2H8pRQU2DnOyejcNv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999186

On 20 Sep 2026, at 22:44, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] mm: silent loss of memory leak detection for page->private on he=
ad pages at free time
> - [Medium] mm: removal of KPF_PRIVATE from /proc/kpageflags breaks usersp=
ace ABI
> --
>
> commit 11221906706fcf50f2069964f35b9ce234eeabe6
> Author: Zi Yan <ziy@nvidia.com>
>
> mm/page-flags: check page/folio->private instead of PG_private
>
> After the changes of the prior commits, page/folio->private !=3D NULL is =
now
> equivalent to checking PG_private. Stop checking PG_private on pages and
> folios and use page/folio->private instead, except swapcache and hugetlb.
>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index 260772b20bd99..f90e1030825e9 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -232,7 +232,6 @@ u64 stable_page_flags(const struct page *page)
>>
>>  	u |=3D kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
>>  	u |=3D kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
>> -	u |=3D kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
>
> [Severity: Medium]
> Does removing the KPF_PRIVATE bit from stable_page_flags() break the
> userspace ABI?
>
> Any userspace tool or script relying on this bit to identify private page=
s
> will silently fail to detect them. Could this be preserved by computing i=
t
> via folio_has_attached_private(folio) instead?

No. It is intended and userspace tools need to cope with it.

>
> [ ... ]
>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 7080a6a1a79e7..6d839f50bdcb7 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>
> [ ... ]
>
>> @@ -1169,7 +1191,7 @@ static __always_inline void __ClearPageAnonExclusi=
ve(struct page *page)
>>   */
>>  #define PAGE_FLAGS_CHECK_AT_FREE				\
>>  	(1UL << PG_lru		| 1UL << PG_locked	|	\
>> -	 1UL << PG_private	| 1UL << PG_private_2	|	\
>> +	 1UL << PG_private_2	|				\
>
> [Severity: High]
> Does removing PG_private from PAGE_FLAGS_CHECK_AT_FREE mask memory leaks
> of filesystem private data for head pages?
>
> Any buggy filesystem or driver that frees a page with an attached
> page->private structure will silently leak it without a kernel warning.
> In mm/page_alloc.c, __free_pages_prepare() unconditionally executes:
>
>     page->private =3D 0;
>
> Since PG_private was removed from PAGE_FLAGS_CHECK_AT_FREE, there is no
> longer a check that page->private was zero before this assignment, meanin=
g
> the leaked pointer is zeroed out for the head page without any validation
> or warning.
>
> The equivalent explicit check for tail pages was preserved, indicating th=
e
> loss of the head page check might be an unintended oversight when removin=
g
> the flag.

Answer copied from RFC:

After the conversion, folio/page should have an elevated refcount whenever
->private is set. That would help detect leaked private data. I tried to
enforce ->private needs to be NULL at page free time[1], but that might
cause trouble for certain use cases.

[1] https://lore.kernel.org/all/20260223032641.1859381-1-ziy@nvidia.com/

>
> [ ... ]
>
>> diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
>> index 7fc5a8be5997f..47e4781c5fc38 100644
>> --- a/tools/mm/page-types.c
>> +++ b/tools/mm/page-types.c
>
> [ ... ]
>
>> @@ -131,7 +130,6 @@ static const char * const page_flag_names[] =3D {
>>  	[KPF_RESERVED]		=3D "r:reserved",
>>  	[KPF_MLOCKED]		=3D "m:mlocked",
>>  	[KPF_OWNER_2]		=3D "d:owner_2",
>> -	[KPF_PRIVATE]		=3D "P:private",
>>  	[KPF_PRIVATE_2]		=3D "p:private_2",
>
> [Severity: Medium]
> Does removing the flag name from page_flag_names in page-types.c break
> parsing tools relying on the P:private designation?

Will send a separate patch to fix page-type.c

>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-remove-p=
g_private-v5-0-bb68b6a21869@nvidia.com?part=3D10


Best Regards,
Yan, Zi
