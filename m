Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A572B9BA;
	Wed,  3 Dec 2025 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764731626; cv=fail; b=lTdnV33S2vnIa8CM/5efIDwr5PGwN8kLANPOLue96flZye+8n+8ZFMt3Jovhl8GeTi1/+C0ynu46JvuSBL0Lwo7zsW8HZ7Am0qN82abX9Rl8/pbfrXQ36DXwqeR4gHfJs89RZKmpfqXuXNpVPbUe3fW5x0pDW3y+bsVVQKX5/CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764731626; c=relaxed/simple;
	bh=3xyxTmVJNOosSaqoTRxzYnJ2YO4BW79pKuyiozLV5Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1XqXX9QGcqvShP62uumt6EifjqlSBoVVmIo0hzB05OCgs2MZPcu3SXnTZ85KpnvskqzHiZh8IE9U90Sl2mT1Ng8le4QC+0fhsylhKKwwmriqn0/cBMgsjN2YPhlXgf9iJmczvzEyRSGvECAheriG77QWitYUv1AL92zqpOWn7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nuEyvPbF; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nuEyvPbF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX7RVv/ARyn4+LDscgqiswHta+nyV1LdG8Vsil98F1ekcE3lZkv++PHqiMwMrEhoG2K+z0gS4SkNUgR07g7h2XQyvikOal/o5vBN7NmYAtLtDiK2hhbKudtO1PgrV6vE9H04d0AHqDGmDdF3HRXYBAKfhK7FtaZvxzIFrJom2nQGpk0MAD8FINfRkiw2HuawuRrFFTOODFWSMSoWfxbo8zjfjnz9zfuog9Z6GGbCOYQZszEMwN4URvUMjKqzuQ766UlqwUEH6ycAcCEVJisuDbxsRumzLg7gy7fPKUQFYGIpg13qx6mPI7AKAqMr7inf/bvI22P49fYBnt19FXt4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7VoKbGzDynTfjogxj24Fdo71Yl9p+ZaoAuyimlAwRI=;
 b=JPtVuR8KuvU6SqCX3B5vhNt9HdzMZh59akFympie498ILF7+i3kK9li9Q4ZL1K1mnuK3H1W3qPlx+RBH1WkxqhRKPYzXNul+8ZZ4DtaGU0e5JzwHA6duV4fMKJygm4qHHMEjT6fkzzxSYT5e8S7AUkZA1PjuFZaX4EL3Yga6wwYPeqDg7gGv++4AuntD97UtkudgY8Bjl+Oc2FFg1zoGaVdpxlieWyW7AQRpAO/YRC4u05AbRzZhn0W7YVVugcT6ibKzANkopHi/LNNID9SosSNgfjXOR5KyT861P42OTqdqa75lT4nQ4jZXK16D0nyWoyVn8YRaNKd91wVigvp3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7VoKbGzDynTfjogxj24Fdo71Yl9p+ZaoAuyimlAwRI=;
 b=nuEyvPbFxbTJ4edVgJwE/Ta4sjrRWM/PzRko0TG8fE8ssYMs5m/eW/0Sqd1n3LIe+hMYx9Icu4Y9CgUbmTriG1y6JjORIbJoNQB2awRD0lwD/M7adShPQbPd/Im5+vjI1W9oNzTuqkEOZNGv1Qkq+OOPa6hRMwfczqEZ2JMfuh3wC8kyYNMzVIyykOeYARzxnWq1S9xIjKOJK5OEwcJ/bgIy9F9+VUmKVmM48p99+od9XqxELCVVfOpKrEWgJHacv9t6N7+h1ynkPR8oqeth4AkHrV6dDqBEML6IVcFX5xIQBkL3iUkMUIKO5c9bgHkJnQyQ36Ia1QDxcdlH8i2dwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PPF9A76BB3A6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 03:13:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 03:13:41 +0000
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
Subject: Re: [PATCH v13 mm-new 05/16] khugepaged: introduce is_mthp_order
 helper
Date: Tue, 02 Dec 2025 22:13:36 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <CCE3840A-A46A-4F33-8412-FC55161A6D6C@nvidia.com>
In-Reply-To: <20251201174627.23295-6-npache@redhat.com>
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-6-npache@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0273.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PPF9A76BB3A6:EE_
X-MS-Office365-Filtering-Correlation-Id: 146eef07-625d-4cdd-77a2-08de3219f5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CiRNrkNLaLDOHr5o0T3slR3tJYSO/Rkwbn5QIaKemutq39h01pIMnWLyLY6w?=
 =?us-ascii?Q?jS/Of6qmH1yyHDeLyx3MPrTGYkizI/lhqjY/zc1hHTsrSClVRkDd7QyhlRP6?=
 =?us-ascii?Q?zYrB1q7xpolyhDocz7a1Xwnzd3k+qio2aBanKqytGV2uw6rg5CkRq/Sk/+XO?=
 =?us-ascii?Q?P93m1cSvj9vILPyEOdAMKmEaZ50OBSwKM8EAQ5TGab8Vnv5RktYHVAP2HxH6?=
 =?us-ascii?Q?YLBFpkK+4s2pH8xg3ky2yHqPUvR+eIYm+0aKLGUehgxPDhC5rE7NPG20xoPa?=
 =?us-ascii?Q?5+JrDTuPTj7SlEBEO+Kq2pxyp4dQT1NYqKge5YOmm4ZokwQOFFLbnw7Lg6wL?=
 =?us-ascii?Q?SmVZRGc0JnjT9W6hQuGqtucZ04LX3we7uLKzXAzGGYrN2Br7gFFjVzrQHeqj?=
 =?us-ascii?Q?EIqg5eBZKsw0gD3GEahR4BBdbI697chZiAetwq7FiRSVVtJUlYHZXGVOO9x+?=
 =?us-ascii?Q?3ms+UTGF8IVtY8yjoIev2EpZDVemPUR4kZ8wi/PdlT09XhTskS8Y9UwawBLf?=
 =?us-ascii?Q?EFzZHbHDgoHNw8obkKtAs3KldESKoPSzUslFsdfdYMubZIbFWHMzidYxPeqf?=
 =?us-ascii?Q?tHxU+QqXrj2fffGsZN0jEkQlA3S+wM3npXUcj9rPEhhzRnPrT3r38vWSfhlM?=
 =?us-ascii?Q?kPT/ltdKJWptoToOESfFT7kirGQNIjDaxUsEuqYwkGBzCVAF7MihgIuDH63A?=
 =?us-ascii?Q?u7f2y4eudJ5q+wGBd38OgeMF+MHzeb3WbMtjfi+WzPpPmUFkZDA29nyUfPcX?=
 =?us-ascii?Q?bRL+ewaL1/HPWIu9UXemjQ72KNCZrWOJPlGOnmWIPdaHowq6KQiNZuwlL4zm?=
 =?us-ascii?Q?e50TB+TN2FTgl+HRt3hvoo8/sezr9bell3QWBkt7alETM9R3S+eYgtfP5rUf?=
 =?us-ascii?Q?LbAAPDz2hRB2Z0GWaAuQ2BxPPBjgnqgFaTxOGwYYexuOmuOmd8+q9GioC8FD?=
 =?us-ascii?Q?PcGm9fnWWRUnNqwFT5ZmxV6ujE1HuNWq2cAuqQiPiV/8fe7tVPymi73qRFfA?=
 =?us-ascii?Q?5oqgGK9tz0ekGQGizrL04RpA50n6JxCyCUDdYqLy9mlBt6Ka/ktjGZR2zEBy?=
 =?us-ascii?Q?fhyAGd1fYWTSkhWk8NGerYppo48Kz7wwMFUPdY5I3unNFPQfb4vvpzyl8So5?=
 =?us-ascii?Q?M+ZbdXLKxsAnmYbsZAIKzQieQyPlxJEwAbqRNn0YM5AX36To/TdkCfCdD542?=
 =?us-ascii?Q?eY7sJIC6tJl5x1ZKpTA88baH4pzCsMCNkLxPexsgEdbawF1ecfBYO0UT/LZc?=
 =?us-ascii?Q?vmP6AktD8P1PbXrBE/BnRZrUqlYfRvqY2S45Blx4lq0fljRcyAAuxNUHp64O?=
 =?us-ascii?Q?CH4wtdcO8vNQy7c+ppqbTN6yNFaggJh9h/w/+noKHSNdkI+GWy+0cspdOqM1?=
 =?us-ascii?Q?4Ai6T7zTnjAQsvHYuMzfrt22FIRRuotq539YyjbaL0Kb9KIwK6YbRhuipFIX?=
 =?us-ascii?Q?Q7sbU8nikJIuSDaB8UE/i1Yk2EdjLKtS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Jma/0ioExjDJhlMq9j/rWzC5bWOqRMbz3iGgFvD3sdw2r3tpn8S0v9woUo2?=
 =?us-ascii?Q?WChWHto3vMh0SxPmduLnxaVB0s/Td7+j1so74Y5mwa4GviUNfIn/r1CvIvad?=
 =?us-ascii?Q?Q2LqfEyM7hkSAktj64cyXdP+UBqyeHytPb1syvx4BkqdocF3EHtyRDLoHwM1?=
 =?us-ascii?Q?otOkislCWv6sANNnX2LAVL+9IG8XMo01Zf9KgJkIJO7CWfi6M0cbb9uuRuVn?=
 =?us-ascii?Q?GhZTgrby1M3vqyNHJFEFUL59Xvjeja2YJOqjjvk4wuR7zxgcgISpkMLIfEfO?=
 =?us-ascii?Q?U6wPD4OKM1CbD0ZZLD9HgAkh5vlo2pk3oRgX603/sOJz6CYVJQrvh0NnIjcz?=
 =?us-ascii?Q?Hi+TZw7WOYpxOmrE6BxnKnkwv0MMal0ZxD/K75ma+41qbyh2/nXZl0UgH3JJ?=
 =?us-ascii?Q?XzJ26FUFG5cjUa++13XVU+RQvcDPJicBH1ZaTuom2+fSSS07QVhVds/lKbcf?=
 =?us-ascii?Q?BYVQrzGqHwrU9AXIYjnMRgjAUNpQ0NitMbWIx78+kR/btIPFGt+5lUuzUm0/?=
 =?us-ascii?Q?g/ZTXHUNeII4q1xSXoZxEKIoNscg5lUMFxHNKN972dz/bKKZh0RRTXMyaVIQ?=
 =?us-ascii?Q?iG/7WFTWQa9jQQmpKeB2aSn5kdTznH9X4g5QT4T4QOJNx5xMO6hrHBWQPHwL?=
 =?us-ascii?Q?lc76IBkfATd6pYM3hdjyEYEuwSXnCAI7m2JffoMzl90arN3MQ3PWhsHCJ3cW?=
 =?us-ascii?Q?mS1kLyyDg4xNRt/+g29N/XK6lvCzZuBkJn5goTjVLQWi9/SUhp4vOYQqRvkH?=
 =?us-ascii?Q?pFHzHZUHd5ZpnKerycmAgCeF1B3na/Lw+AbfoxVezHcN2n/zhSir/VtYwvOo?=
 =?us-ascii?Q?lQpfEThDhuvRroi0j3t1eecGY7dW56KMPimlF64DxmFD8KZlAbCaWa8yhfx4?=
 =?us-ascii?Q?QCdllmmr13bmNGhs8zDX7DU/9j7juUZQTYDGWXjvJIyoU7GGb80A6gdaAXMo?=
 =?us-ascii?Q?9N+oHTgsaiQgjcs8NnCIizuc3Nlb037HVpPdhdvvaEWI+jRCCs9hZpWHAFe5?=
 =?us-ascii?Q?ma6/HZvGQkL+Wkl0EHQqVENORYZ9MeZZtFZKhGeljch9HGOYtY35cRQd84WP?=
 =?us-ascii?Q?9amemgAUIzvLdhw8N9BNzQVi/ukrVVIJDpqGRn77yKjdOlwXjd0rr0sYv4jp?=
 =?us-ascii?Q?RKqcRNhyA4M0mwk3H9J7ANga59pGs0Sb8Bbbjit82SUqerdTAwFGEcYo1P22?=
 =?us-ascii?Q?86KYrewZxHhqbCcUCZJvgS8RAVXZJkT4G7tbcLFCHV2ZZnFlG4CJFROc0nJf?=
 =?us-ascii?Q?ZgnohBVzgqVXt0hAiwV/DW45YRD7Kbx5mpgc4OnTrReZoPU7bSEPIjcVHF4t?=
 =?us-ascii?Q?DHXJmTIotAB754jLXxeNpnktfSe7gBs0MgjzNlolBqeMqiNQATrpoxttAe0g?=
 =?us-ascii?Q?JObWMnLv0G4WyLsgMN9a+GcuZ54FD72PtZLJl6yGA5oQmeU1qNin0LaEDCmp?=
 =?us-ascii?Q?Jk04eiKfgHdtRdwF7/h4z1mCmaNlEhL8CbrLQTFZF5kxppx4H4HshjWG8LqO?=
 =?us-ascii?Q?Sd16lUO0ERV+g59Nog4HohTGFTa1gePQ3et83CRQazB/9xxYjuhzDn453uB3?=
 =?us-ascii?Q?vB1MHU1CleOX1OyONxAz2RA04qGbwWk/XxR6Y9Mu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146eef07-625d-4cdd-77a2-08de3219f5b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 03:13:41.1968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L24brxESDtcQgF223EYkTjcgfdeONG+S4UMNYrxsCKPjNzdMbCR+hRANxQ0iS5Rk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9A76BB3A6

On 1 Dec 2025, at 12:46, Nico Pache wrote:

> In order to add mTHP support, we will often be checking if a given orde=
r
> is a mTHP or PMD order. Lets create a simple helper function to keep th=
e
> code clean and readable.
>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8599c7fa112e..9c041141b2e3 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -338,6 +338,11 @@ static bool pte_none_or_zero(pte_t pte)
>  	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
>  }
>
> +static bool is_mthp_order(unsigned int order)
> +{
> +	return order !=3D HPAGE_PMD_ORDER;
> +}
> +

The code at the bottom of __folio_split() in mm/huge_memory.c
can use this helper.

The code in deferred_split_folio() uses folio_test_pmd_mappable()
instead of order =3D=3D HPAGE_PMD_ORDER, but the code can be changed
to use the helper.

>  int hugepage_madvise(struct vm_area_struct *vma,
>  		     vm_flags_t *vm_flags, int advice)
>  {
> @@ -1071,13 +1076,13 @@ static int alloc_charge_folio(struct folio **fo=
liop, struct mm_struct *mm,
>  	folio =3D __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>  	if (!folio) {
>  		*foliop =3D NULL;
> -		if (order =3D=3D HPAGE_PMD_ORDER)
> +		if (!is_mthp_order(order))
>  			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>  		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>  		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>  	}
>
> -	if (order =3D=3D HPAGE_PMD_ORDER)
> +	if (!is_mthp_order(order))
>  		count_vm_event(THP_COLLAPSE_ALLOC);
>  	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
>
> -- =

> 2.51.1


Best Regards,
Yan, Zi
