Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2593239085;
	Thu, 21 Aug 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785362; cv=fail; b=GX4+rru6dwf3OaCzUGCtw/tj3X9v3G2jn0mjw/vFiVnbHV4P9gssF5rJZCjcixOg+QZKJJAKFaamMOiTQh5duhDLw6PVkCWXu/epy4VOJPmS5UHzNGfAmHNLU+kJ3avv63smv26ePnwBOlMbrIKb8NsVHI4kzT8ZzNVDrJgJvC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785362; c=relaxed/simple;
	bh=Mp2NujqSTv9eeACU/4gOgPxc9S3m+lzWD9s3pnzIyus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evNSBQFrMGLcY8fjifwPoJcxQ1BiP/A/4jyV172SFtoXlRDHq/gHSuryYT2ylh2G9BfexGKkRhNP24rgIxcUcr4L41JOl8qKC8oR07UI/u3CSpDv7IOtNJFsZhviOdnFjNY1mWQIS8MDz3BV8qUw3h/1waXoB48Izy2sg1v11dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iZBGhG7N; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iZBGhG7N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2J9j4odN06x3dtWvlkFJcKrh7jOVaukrxPnvHoc9ETRHxPuOL1YV/r5BTmrt/OGo4iBGUj2fJd+AQ3+P9DsL3L5PYZow1pw5J4ZIO3MaOXx7PkYGAJamsAM6G54VKFc06JcutOkI7h73S1IV5fUfVNr6SH6t++Nrc67yBXP3ylPLHQ1BAFOWml1g0uPlQfVbWIp63bWsr9nGP7b3AcQfacgIF5vcL6qRWKH4a5JMBOa6Lf2Ogpe613QB0OyuZ5yN7XnZVdHd+a83tQqlp6613CV6fpisM3IujGgloRZ5ZRHNJtJgE/mLCQZsKN0B7HdC4Uo4KVPxqGWUxa4ArRn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hasAr54uZs9NE+L3166euCaWwbiyzuItp1W/FLZiwII=;
 b=Y/veTc49Rx8IOQ9zzCt9yQd0DwJHn8nDCjxzPZR7ZkBBYrOh7CNU2KWv6bGB0p8mtiZCXLDcrw6+mDV/SVBAodn1F4mJdNYyf8B+WlBTsScOmJwc4C/h6KMewmzDPI4hEwRsOGwExk8TD4IkLO4yh0cXPcPIC/Qz6pIrvhe9cCyBqN1JD8i8arrQk2X1V5IiQLco8eNLOdHLJopMU0LLsenK/UrSk3LC5YosfB6ulb+PTn6yaggdsGhI0iKkl+pU+kwr3mhxwHr/zl0pgceJaw8277oid05aWhN02/B8epmrBBe4a1Jc+fJHDyHoxAHrpw+TGs2dE5vIr/tSHlD6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hasAr54uZs9NE+L3166euCaWwbiyzuItp1W/FLZiwII=;
 b=iZBGhG7N2wixdmpviJeWhzp9btIoC/YA+ihLa+PirpB9OORoI/IzaextUzo0bGN08k3vw2hKf58qBafbDqvmSy9Lz1KGDYWI+hG5ZKqRc8FhG3SBE+mkv5dQ2z+2iXlQ/5IltWoNF6PF+iUVYOY3ZUuzVtTwF9BCdNqsR6adwyre3qUfqEsb//mJ/YWUmO890pSqgHVHFIeu6Pt2b1h0n8fYyrTmCvFyrpCFAnQjPviLewmqbzuF40AGuyFJNoDG3ZlAH4j0k7Ix8+eQKP76etg3fDqBjhVkicf0g243tXsHoLZavy/0MdyqKtRBSjXDHv6QvCEHzLP7vNmcwydszQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 14:09:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:09:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Nico Pache <npache@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org,
 willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 03/13] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
Date: Thu, 21 Aug 2025 10:09:10 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <1D4FF375-08FF-41E0-9B59-CDFCA6293438@nvidia.com>
In-Reply-To: <20250821034153.uyxjy5yvxx5no5sf@master>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-4-npache@redhat.com>
 <cd4dd743-679f-4c55-9635-6d32e6fa5ff7@lucifer.local>
 <CAA1CXcDORXqm4JoHn4ZSEhT3ajsuY2MAPwefMXk3+YMXcpvqkw@mail.gmail.com>
 <20250821034153.uyxjy5yvxx5no5sf@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN8PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:408:ac::40) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9c570a-e1d1-4f3e-3ad9-08dde0bc4f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fx7YdiJ5KQYtnfRH/Qu7X1BkhKFE12lPF/+AaWi+dddzyamcRLfbqOX0lI05?=
 =?us-ascii?Q?BvkMNBKpUVpXIWN+0LFtyJYQfm7f5ZMKW3tyEQ9RxNYEO+8uVB1TKPKXhgZt?=
 =?us-ascii?Q?TrFvq6YmEW1vQrpikvc+gQlk7CGLIkRUm+5FyUk2Ci4APoJDI5KpH06oGUnM?=
 =?us-ascii?Q?3T1A5SIWEOCqGB6Jp/XQRsAYWGuTNUpVaDl8zt66R1aGKJdwtz5u3KozwmQH?=
 =?us-ascii?Q?h2UgbkpHEHVJUOKUORgNYC0gV5e3IbJLPprNbPhK3ASNJW+aEyqQlpnkBT7G?=
 =?us-ascii?Q?/5FhtTOl4JC1tLewHk/hvPxMacFLrL0xavd2QaVBjH1RHXgWU5gtUp6c47rg?=
 =?us-ascii?Q?M/faGP8347oXKaN5VPnCiIAQUHzv2SjKFsSjL2bnGSNh3siAFS23HFlx2OwZ?=
 =?us-ascii?Q?XpoJx4Ki4XdK7v0WK9ylp5s6PtDEhWz2HnLNQTIgYqIhs7y9idpN7EIX3WUQ?=
 =?us-ascii?Q?VOnWy+vv+iDSJoUziaiSHWkZvE8QakNoT5IUbmiWPSAKJkjIPQ8Aw3TW4hfO?=
 =?us-ascii?Q?c4k+aZIvBdpigTN5HpvKEZyVSKU4uQQvZzDLYepwczwGOYf9luTKS/KSfl3K?=
 =?us-ascii?Q?4DbA8Ot5tBZ1o6Wj4eopLDtm6vUwpraQt4jMy2FLU4Wb3YAsAn80pN4RjS43?=
 =?us-ascii?Q?xSWlZQYTGubtwpq2driej0E0AD9mT7vayDcv/xb57saJKpi4VDbftfE6rnzq?=
 =?us-ascii?Q?FvaR01tgO0K0u4hr7L4pHyugxTEpFPbxM6l21IM5t38renXFEl6W00epAI9E?=
 =?us-ascii?Q?QFdrCx2t5lwbygmFcYXi91SjcYEMToP3beP4ohPVwnklKWyWrwAeRfPYWIVY?=
 =?us-ascii?Q?eQt0FuPsG9LZPlHDKyi3j8028csYCdivljQYDS+KcJ2IbbLxPg2GvbfisWig?=
 =?us-ascii?Q?qevL2HcX4oRwYJpxQMqT5yvYyvOzQJPzCDsfzjeDkAr7UbP5aJcmjYd3mzFc?=
 =?us-ascii?Q?XihDTPMvSQVSFeEUTErlubEIUPpiBJ9SwNU4ZUtHEhU5hlp28JoJIpT9MAaI?=
 =?us-ascii?Q?TYF+zeJXgVjfYjntaIJPW8SdBvrHULZhUmUTYVhmptr6EpbBvdkTgF6Uwnff?=
 =?us-ascii?Q?4GDQ6IzXDN6YCGuBO3CNvK6b8WAXby4qkOKKR4ffAqzIC+i6iAUNqtVZFATS?=
 =?us-ascii?Q?92/r5KERpEwNoNo8g/VX7d9dlQpow8rEqYYcq1lI5xIfZWqwoRL6OlYUZ82/?=
 =?us-ascii?Q?MgRfGnkYECuDBUm2tFsx55J7+f28JbQkg4i8MYriNwuR9/Vwt13X1ebtmIU9?=
 =?us-ascii?Q?zXZxe5Z3XmWemYpwnvsZA2x6m4gOMrsIBaujJ4kcKflrlKAqKhaJPW3uJ5+o?=
 =?us-ascii?Q?GEiR5PO9TXYxJkgbk4Zalgbn4j6EassupmKW3Loa/+HJ2yo6vHtZ1Ku2HZhG?=
 =?us-ascii?Q?dP/c6IQi+drvrXzy/LQz58+VuioBZvoPYbRPPXYef5GcsIg0okby66Tsq2D1?=
 =?us-ascii?Q?WHR+OVKtNqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nI0PBEWlvm3Zrj77AM9zIu1HpS3w1pVGt4CpchvhWFMPzg+BoH/N1WJlWmgL?=
 =?us-ascii?Q?BuH5U9iBlQCQeFw7jVMz5fqlRblCOclp70UAWCuwUCit/ylHPtBQQmLmXSzP?=
 =?us-ascii?Q?yU9RYxFHh975+7YtQSCwST1v8AdAiTJlMz2QkMrbqu5SoTpNPme2shuyjlOW?=
 =?us-ascii?Q?Tn8lTiz2UpHJtQovXcwITYI9qCheldE/IqNE+aTheJHWkKotbSHgDLz+wVYs?=
 =?us-ascii?Q?MAR9Thgk2Iqz3R9ZtRThwyOg+sfZPUNQZ/8g+50J+k0iyUMSKck7zfDJQE8b?=
 =?us-ascii?Q?F34pvBH3qCbDL0gvE3RYjPQAEWgXf9o7jSz2sWfvmcXtavCGZI9ancdLu+ru?=
 =?us-ascii?Q?MKU19WezHmqELtqSuWgPergQXq8Q0YQviBsjiW9Pi4ToVXlly8IE4fxczp2q?=
 =?us-ascii?Q?Ewx7jePddxlZuQn4c0Co6Jw8K1EYH6jhf2GdpDDVPj07oNIKZe9DLGfyuBy4?=
 =?us-ascii?Q?Ok9tg/RgAsfCqyCq1ChDd8DffAqmd6EKHABB0ffRBeXK4SW3CNnCiI/MYNmR?=
 =?us-ascii?Q?CQ9D+6cXKzHg69csZN/vWqjb3wWL0hjxMRgzbA5VUTU9cRwiN0GfQwJz1bFI?=
 =?us-ascii?Q?zIT3xsqlAJwGrF5gSZXc2Qld5Knkva9C7AoppeVICpFPBBFq42gr93D9Iki9?=
 =?us-ascii?Q?BA3qR8A+KjdAg8936kqwv8gTGadPauhi3uMlcmoh8YxZDBTapBPwZGE2wCoM?=
 =?us-ascii?Q?Szs8ROoXhmy2CEMOu6dr/qgKgro5SdjDPjYPixFVFsWXvRtARwHIPqdnpnOF?=
 =?us-ascii?Q?uS9hVOs2+Q+gtFU6vOZ03kJVDYHPM39d7rbvk8Pq0Rbh6e/kLagtKUsRnsEg?=
 =?us-ascii?Q?g2H02wOtRiylmEty6QYfvmWu4rvOHlAzVq+gGaCMaaTWi4Zy9nzapTr47Aa8?=
 =?us-ascii?Q?7rJ4st3iFiDdX9DijBsdDLpPItydv8WC8tePoT8QzoJYsCDnOu1M8P4nSfkb?=
 =?us-ascii?Q?bIfQQdr4lBOt10bMtCXvc6E+irPfs92lkSiRevPfomwR0hgFRUn/eawS85P2?=
 =?us-ascii?Q?0LiDYtoOWr95jD8cwl3HS62PYgeIw6xYvubBx1o9HKP7POfL5MSw+zQwFmOa?=
 =?us-ascii?Q?R9N3itzjGINRY3uDAthPv2xzeEHHYr35kEHwbOUPm3KNhwn+XypfsK0dNHGt?=
 =?us-ascii?Q?SI8tO7VBPwsLc5UF4Cr8+QCKdBnSbY81B/w/4Jv3StlOX4JWL9fD5sGfqcPx?=
 =?us-ascii?Q?BlE9Aihl72e7lEFirWrUAKzmH5+IW6XXwzL1QiiGb7tVRjqWA2Ll5JIZX0v8?=
 =?us-ascii?Q?X+jlkFxCg2qtbe42m+lOb/NgqKqSvVWWrDSrc8ppyjOZYWxk3oYiIteIKX5n?=
 =?us-ascii?Q?SR7V2dUS2F8yU6ejpjAM9Zru8QvTenxVtJKP8Qvhd+j59zGZwaKYGEU/3XNA?=
 =?us-ascii?Q?1aP1oDUe6UPXxP494DvcGGAspJ2fKnnHa5+LQrgZYKsT+rCUpdXiVGjw1xig?=
 =?us-ascii?Q?Vm5uMY0hrD5OFWijIoXKF1hMgAkDkD4XT+5t5DWJnK8xGD4HsKXjseW4t61v?=
 =?us-ascii?Q?I1Ou9sdqNz67RO7H7LR1u1x80y8MUO4dfnZJAiYRX2h0EWev8xcm+Yl1SjOL?=
 =?us-ascii?Q?Fz6fHx8x+aWKG3Fkt8hOV/PrHpK1RsDiT7hSEcYX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9c570a-e1d1-4f3e-3ad9-08dde0bc4f66
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:09:14.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JNwGKTXvTVUtiPQLVmCZv+O2qEJ28w9qQg7mT9KwskNSQMNqL3qrz3dEcQp9PpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

On 20 Aug 2025, at 23:41, Wei Yang wrote:

> On Wed, Aug 20, 2025 at 09:40:40AM -0600, Nico Pache wrote:
> [...]
>>>
>>>>       if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>>>>               return SCAN_ADDRESS_RANGE;
>>>> -     if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORD=
ER))
>>>> +     if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, orders=
))
>>>>               return SCAN_VMA_CHECK;
>>>>       /*
>>>>        * Anon VMA expected, the address may be unmapped then
>>>> @@ -1134,7 +1135,8 @@ static int collapse_huge_page(struct mm_struct=
 *mm, unsigned long address,
>>>>               goto out_nolock;
>>>>
>>>>       mmap_read_lock(mm);
>>>> -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc=
);
>>>> +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc=
,
>>>> +                                      BIT(HPAGE_PMD_ORDER));
>>>
>>> Shouldn't this be PMD order? Seems equivalent.
>> Yeah i'm actually not sure why we have both... they seem to be the
>> same thing, but perhaps there is some reason for having two...
>
> I am confused with these two, PMD_ORDER above and HPAGE_PMD_ORDER from =
here.
>
> Do we have a guide on when to use which?

Looking at the definition of HPAGE_PMD_SHIFT in huge_mm.h, it will cause =
a
build bug when PMD level huge page is not supported. So I think
HPAGE_PMD_ORDER should be used for all huge pages (both THP and hugetlb).=


>
>>>
>>>>       if (result !=3D SCAN_SUCCEED) {
>>>>               mmap_read_unlock(mm);
>>>>               goto out_nolock;
>>>> @@ -1168,7 +1170,8 @@ static int collapse_huge_page(struct mm_struct=
 *mm, unsigned long address,
>>>>        * mmap_lock.
>>>>        */
>>>>       mmap_write_lock(mm);
>>>> -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc=
);
>>>> +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc=
,
>>>> +                                      BIT(HPAGE_PMD_ORDER));
>>>>       if (result !=3D SCAN_SUCCEED)
>>>>               goto out_up_write;
>>>>       /* check if the pmd is still valid */
>>>> @@ -2807,7 +2810,7 @@ int madvise_collapse(struct vm_area_struct *vm=
a, unsigned long start,
>>>>                       mmap_read_lock(mm);
>>>>                       mmap_locked =3D true;
>>>>                       result =3D hugepage_vma_revalidate(mm, addr, f=
alse, &vma,
>>>> -                                                      cc);
>>>> +                                                      cc, BIT(HPAGE=
_PMD_ORDER));
>>>>                       if (result  !=3D SCAN_SUCCEED) {
>>>>                               last_fail =3D result;
>>>>                               goto out_nolock;
>>>> --
>>>> 2.50.1
>>>>
>>>
>>
>
> -- =

> Wei Yang
> Help you, Help me


--
Best Regards,
Yan, Zi
