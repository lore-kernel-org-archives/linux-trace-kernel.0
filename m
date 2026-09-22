Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F0367B6E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040213; cv=fail; b=YH/t4ovTWzvzWG1qA/vpRG5JrTVv+AttiJcmswJbFemt8BVAVhAKRpGZXg3zG18Q+TnakFIYPk9wkwrioYNXRdFFW4V71gOAmvD1dSFwAypy8rB4dMv17D4+J+hR2qXXsU6rFl6eH7Ck7Hg7NAwxrq4pbZV+a1famLw/oSfy9Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040213; c=relaxed/simple;
	bh=1Ed7cIIRRAn9tbByw8aEBPjKiAHhpCQ8Z6BOStAxTlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NTgJkFe8TbBRjuj/c4MtvThnj5XvzoQYQX5LCyz3UY+Gis1eQdBlvmNdO0XYRlnzIcDFIiyL4/c+PBWnzkOSckwctOXNLgR7qstHKkDMn1arHjCRcUnXDGYu6dtYy7xRjrE1YRIgn2GnVJ2NpVNKD0mxHqhu4cn0FGk1/XT+iyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KU5BudBN; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KU5BudBN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r28XNxv/agOTg2ftvb0cWG5kclmEnzbO2PIKcvIhROVYzU61hs5BX7Bpm7/Sw8lX5IWQ9HzNjvrW5RguMSc8E7d2KNU67BUfTuxFvDiVeAuSldegKDvQkKubzr0dbgtGfSsgeEMUvuSCaULNseyZuWymwj7M/NV+4hZX2eypJ/xpgugXzK/s57dejoCznAkO2UV85ULXbqfXxA6EzsLwpy66X6Q4C2SkC8ysZ0XBtBXELKwNekTjGPAwAT4Cr3PYmJb8uYmWopqjxeV083JLJbxohJsjJRoEZzBK7LXldYXkL67Vmo/NTM3GAx3Zb4fYnGYbxBwACLk+U37xSCPw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFhvA5GyY+cRgDFIPEU30aByu9vpPqjg3xaNcqn4bV0=;
 b=EAO0Z3LZCjEHNAtPOedluXkrLHKRhQGK0eTEpxbJgyenCGnC4nVaIRvi3kI7kap+DFFAreWjU9WtkEvZ9d6LOI4RxwpUYk1D33Jc2UKshy1r7kUzgIHG4sZDOdT5JfykxhSVC4P/4+s24MuiDZ3OANCCMaDhufvK5JYUVpjFsxsOJ+hDkHEjEkKr4RcP1Z+XQp7JdIChsWf83LwxM2Kqjw4zz2wkBTxotHJAoglhCb0DrhmOOWO1QN2VYCnpYsWGsE/BLKs6Bo1BUxdJVn4POQZ9PaTQTPa5A3PEktiJC/rnJX9rodPEfN2jtiMQ0Nv5vy1SezD6y15xr+HoDAI5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFhvA5GyY+cRgDFIPEU30aByu9vpPqjg3xaNcqn4bV0=;
 b=KU5BudBNYGhskFzypID8kGC7JXiJUQqK4rSQebe2qPPflahkTZp02uFCblVS5cuSE5F1fjQ5PCScm5VOZViIPDPgV9Z0dS+Ml4BayFxC8i1I4K3epKRmI7EXMoXuc28L1HKy6/Os1znXEb5IFXlXIGOTriLiaJChzAdJkmW9PPy/hn5PQHvNiDfCEwFv8A7zjc/H2JP7UzwCwjGxQAKzthUkxlfUqnynbz94skAIrFhBpqDoM4riGN+s8SK2vU8+c+r/vb2Z0i7VujPw/ch75jejnJkaG02UtVUm3hrcTYqK3hxobxUTRL7MD8ZbXLTLKs5iJqnQ84WGI8V9B2AgMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 01:23:29 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 01:23:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 10/17] mm/page-flags: check page/folio->private instead
 of PG_private
Date: Mon, 21 Sep 2026 21:23:28 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <A794FFD4-DAC4-468B-95D2-BC7FCBF02AAC@nvidia.com>
In-Reply-To: <2F224947-7601-4266-8A85-7B6B3410C289@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-10-bb68b6a21869@nvidia.com>
 <20260921024424.F0F951F000FF@smtp.kernel.org>
 <2F224947-7601-4266-8A85-7B6B3410C289@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:408:f7::16) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb80b3b-149d-435f-8dbe-08df18481b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SdT7nVPdBJ+t2ct8eTcbYTNHbOI9J6Uc//yCA5+LnbE/4XaGhrCoeQRZVPnygN/i1X1itVr4O/A3RX0B9LkdYN1sJsULc2bVeYLmjmDIkygE5RPceYoXJNLDUtaJO3pg5ltA3ib2nWG9A57qtRDuG6p7spLADtAB8jCgf06jqigGnpdyLopLwV4nzvPGJxmV0E5klH9v8SXngLT6lG47Pwu2ovyATWN+wcAbQPexkNbYYbyPZTWVViaYXj2jnvR5Oq/tExnkMKbBpVZPd8K4tNGVJf6GoSbntu8a45sDFTgK4gHFU8B1maVdGKa0N2lkY4fmQ1srCQGbXX0pkAHUutUDI2SUBjAVBy6fDEuvqirtgtPViBHa7yDTXGucJyIH+qVggq+YJyWZ2Iwik/VZpoiMVHF4jLiuGNphTIYMG/qhspkfY7NfCZdPr48Vv6wq1h89uT0aiGCs8tiu3XqWt2DOGGSrn72N1gIq7CQi/igepmi3jUhNVEFWfAsatFMakpOWRXuZdc/8QU93B13qU+9Ng4J4n+XTl2HYYGJGlEFJpNnofSMkY/p+t0qMfo2vte0a7hYrnW2C1acQ+XpO657EQwu5c7E5FwYbeyG+PvhDnrF6Yi+u+SUpu1E2Fu3O3bU2M7KhKfIqW84EdZwbOkZHi4W2aPeWIup4Xcs8a8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzRyMXVqUStiMUZHektHd3JOVlRTandpaFd1SlpLSk1tbGZCRjU2SjF6QVh6?=
 =?utf-8?B?TUdZZFBlWHRiZ2NWWlJNc0VFekk5aG9XK0l6WmRVOTlGL0lOVXJlK1JNRWxQ?=
 =?utf-8?B?TzU2L3ZUL21iYTNXUkNRR0xQU3dkMDQ1TnpKeVk0cWtSSElwdlJjQ1dYNlJP?=
 =?utf-8?B?UGc4aDVyK2plcDB5Y3B5VmsyWnRCOXJUZDNDOUZ6TkYwODRPWjBGWHJLL2FO?=
 =?utf-8?B?NEJpNmp6TGFSL2xXNFpkZUVrc001VHVmdmlnMVByeEY5N1FnVFU3SG10REF3?=
 =?utf-8?B?cE9Gdmtmejg0TmFzbnhDSzIyclgwSm5CcVE1eVE3U1FKWWIrVjRxUE5wY0ZS?=
 =?utf-8?B?TnFvcVpMdFBPZ2x3LzJEQlZZS0lhQzZXQUVJcldsZHFvejVVNWRsMElwZnVL?=
 =?utf-8?B?Z1dVeVR2TUJoWUVtd0RhNFRETVNmcUxwLzhwYjBCYjJqY3IwNjNPT3p1bzdk?=
 =?utf-8?B?SXNUVlpoMFNlRUVLZWZVN1VsZmFMSEtDb0Z5R0d1MzYremNrWlBCb0pwZDRN?=
 =?utf-8?B?K3FQcmJkc0ROdHMvVjMrcTQyajBCMHBXTHd5b3JzU0hFbjh5M1VpYW1UZW1V?=
 =?utf-8?B?Mk9IWnhXcmJPaGVyeStDWG1XMnhKNUdWTndBSHorWUduVGVjeFFBRFZNNFFs?=
 =?utf-8?B?dDFPcFlqWVdVR0JYNWRoQlJtd3BRWDhHVXNKQlg5NEhCVFJzRXlNT3FidDZU?=
 =?utf-8?B?SjZVU2VKMFQyYmNOWi9Qa0VscFJjTHo3RVJOeFg4ejNnTytWb2F6dmVNdkZJ?=
 =?utf-8?B?MlJ2ZFppOGV1OWY3YzRuRk5pMWlsQ1VVT2pTZEl1NnFSSHRndEEyTzRTRDRB?=
 =?utf-8?B?Tm1LRVRsZitsTjZ4c0R5RGdHSSs3QVN2aVhQUmNJY2hEQnI0ZHhtK1BGQU9l?=
 =?utf-8?B?K2theXFOT3Bpc01nc0pPNUllTW5ReHhBTEFpeVBGREVmeWp1em5aVmFDcnhY?=
 =?utf-8?B?SEhFTTIwQUVBLzhRY1QweldoYWdUQVEvcmp6YVRadjhxMEZWQ0ZLc0cvRjVL?=
 =?utf-8?B?ZDBGVzdVNjl1eG93T25NdDBsZGd1U2piVm5ZWGRkNDlQazdlSUJoVnJCVEhT?=
 =?utf-8?B?VUlLdGRNS2FIdUN6bTB1ZWdleXlqclhPdWJ3WHU0VGJEc0czWEdnTnVwSlhu?=
 =?utf-8?B?SUFkT09RNmxTcE5lWStPTndVWFNPZnJyUGI1dVFNRHcvaDFRYlpLcEpRTmZp?=
 =?utf-8?B?ekJweTFPdGM3TjJoZlhjUHZVaDhNS2oxSUs2dGV6Vm1tOTRROWlJVWoyR2N0?=
 =?utf-8?B?N1l4bkVKcHNkRTdhalF1THlCUVN1L21COVZ6NUFBS1BpR203Z3UvSjJOdUR1?=
 =?utf-8?B?aWVkdmpqejA2NTNaUTUyRWNyUUlnbXN6TVZPbGlGQ1lxR2hpTzNvRm1JVEZn?=
 =?utf-8?B?c2Z1NEVmRWNYaU0yb3hxNUViaVhDUXVPMFduY2VvSE9lb3p4eWdWOXhqZXBt?=
 =?utf-8?B?L3l5WVE5aXl5TGFiK2pRMGNCbHNXTHg4QlVIdmdadFJ3STVFd01aaVVyMktX?=
 =?utf-8?B?REhDRXg1R3VrZ2s2VUFCSHl0eU50L1A4eERJeWxOYkE2TnNhK1dOUzlhRkFQ?=
 =?utf-8?B?VXBmS2p2NEZDOURYdjdUVTJDWmNOaFdNQUdVR3BoODNoTENmc3Q5ZWlIUms2?=
 =?utf-8?B?eElLcDhOOEhSUzdJaEdMaGlYazd5UkZJRWQ1bllQdjRaUmw1a2gybmhKc2dh?=
 =?utf-8?B?ZmtKN1p1MHpRZ1BINWNUclN2amxybGM1ZTFLS0MyNjRyenJOQjZ1Z2p6ekRV?=
 =?utf-8?B?cGxmR2JSRitEVE13Y2Rmc1JlY1o5aHErNWJsQlZ6d2cyMWloaGlIWkUwWGpm?=
 =?utf-8?B?YURNdlFnVkljTnlnL2s3NnRtWllJMUhmbUp0OEZOOUFRNjhCK3R5YXMrSGQr?=
 =?utf-8?B?YXp1cEUwUlVZS3hIN3lCRW5lcFpWU1RBTGxiV0xlRi9OY0Q4UTZpYTV6SWk2?=
 =?utf-8?B?Z29JU2tMZlU3aFZiZU14cVVlWjFhMXNUTGIxVEVQMC9ncFh0WllxWDVpRXBT?=
 =?utf-8?B?L2V6T3Z6ZnJuQ3dPZG5BNXhaa2kxTWZRRHlzTmZiSXRSRVRxdjZjdzQvZ1Nn?=
 =?utf-8?B?TFpqNy81NGRWTXA2Z1NITlhjYkZ6M2c2NzRaSTQ2Qm14ejZtQzlLUFNtb25B?=
 =?utf-8?B?SnFmMlZTLzZzL2JRZmwxYTc0NDlnSVRzZFNhUlBnVlRLeVo5TnN4TXpLNG92?=
 =?utf-8?B?WFB6c3laU3ZMeGt3T3lDSmRKRkZCQUZYV05wQ3RmeUZOV0NzTmE2bzZvZkJR?=
 =?utf-8?B?NkgvS0cwUWhRREZmZjJOeFZpWjljbkpHSkFrbitZU3puNFp4MUIwUGtYQUR3?=
 =?utf-8?B?Q05wNURKOHZLTDJKOFgxeHhpVlZnYm1JZ1YxcEtZRE8rcXhCZ2VpZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb80b3b-149d-435f-8dbe-08df18481b9f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 01:23:29.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb9DP9N5UQ1B/Xw/W1tfAJYAXWF6oRzXbHc6pv3JoVC6lQhnU3bpSfO+DbGWz6S8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704

>>
>>> diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
>>> index 7fc5a8be5997f..47e4781c5fc38 100644
>>> --- a/tools/mm/page-types.c
>>> +++ b/tools/mm/page-types.c
>>
>> [ ... ]
>>
>>> @@ -131,7 +130,6 @@ static const char * const page_flag_names[] =3D {
>>>  	[KPF_RESERVED]		=3D "r:reserved",
>>>  	[KPF_MLOCKED]		=3D "m:mlocked",
>>>  	[KPF_OWNER_2]		=3D "d:owner_2",
>>> -	[KPF_PRIVATE]		=3D "P:private",
>>>  	[KPF_PRIVATE_2]		=3D "p:private_2",
>>
>> [Severity: Medium]
>> Does removing the flag name from page_flag_names in page-types.c break
>> parsing tools relying on the P:private designation?
>
> Will send a separate patch to fix page-type.c

Misread the review. The change is intended. Any related parsing tool
needs to adapt to the change.

>
>>
>> --=20
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-remove-=
pg_private-v5-0-bb68b6a21869@nvidia.com?part=3D10


Best Regards,
Yan, Zi
