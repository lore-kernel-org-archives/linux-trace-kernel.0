Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37F2C1083;
	Tue, 29 Apr 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934091; cv=fail; b=RpS4W4KETx3CgjHnhldSG4g3CXYQJ7F9ibZCGajXEH7aPH/1U3Zo0JE8CNFmYmzuZnxOlgVLm09h42jTExCdZ8CyLMh/jGkkVGOVV+EKsoBN2HN84eYwzVT3qA0sEooG9gdj+03FpVIt/LCO+243Db090eV3NfHz+MKJiOWIebI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934091; c=relaxed/simple;
	bh=A3ioYdGllqUjTY9/YylF0nOcjMuhbQvMKJ2ubJr9ii4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PaDixndlHlo04sP37aoAedle/Iqdge5BzGo/jI9P1C6bMADZLFOfh0ziBE51m+kVk95YHH1/TKgy0i556k7NYtvLCnX/8+QfGtZ9LQQWhr11em4alGeiiLOc7GYFCrU6U6hX5gKX/qyIQN19KOY2Tu1u6kj/6FSEKNSA3HiJ1QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jABZXTJz; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jABZXTJz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCiwqSWD1rPkndukRDQJV5MA5hXaEyBwNc53WzkP1XSjEmHubyTpaiz9FaWyAliwcpGrs6/yHCATgbnKwXEaGl1yGJDQ7mxhaMvHocZrepuiGK0/XCG+vlkS5+yMKOhI7yqu2wCVAK1WEWQL38XSv5tvaBfN85PASgrpTO/BiiqS5DCNd7neN+u9qbPSmsVwnYt414qe18h1FAINMbKyNhOPsQIsGbu0WGdtdhCPMSlJb/DPfeq/EdoiqZHaY9pNUjPGBlsogczWBfXbA8FrANYb4QhQoZesM3l4GMeKSTMWjB4kIWJHZGcaR2lj1nqP6mp2gQ94hGt8nCqJazt1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIhwDdVhjO0v0RhcciG694Uui1v2pR88i9cDnQrSY3s=;
 b=NyZc8XRgIWuw8vx44IzOnt2DO77oJGfNzmf0AWlxGaqRkHSBmD2cu0BcOFxkyF5EYfuSSYsYfcfPS7tq77/jkbf8MeuDeUfaFu5onjyvcaECrVvKwHKBE6IrE+RZdy9wqpSvgUXoS73N98UkO7/gLUoucRfzIsPNHfZnU5hHrgWkU1P8lnjRIK9cT2Jq515bYcmtWF1Lefess/0EyGOjeWJfKRBCBY5Asn2iBCTxcypWMxAmrokZ49TsZcF+a1F3T+X3qwuy2RU2tPtD5fCp7u6L1xoOv2R66xjYth5W9gNdC1Qdi6pvJegGaISihhymi5lk+hdG9MYpFeXghKOGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIhwDdVhjO0v0RhcciG694Uui1v2pR88i9cDnQrSY3s=;
 b=jABZXTJzPbabDot8qHGcMOnjUudX1U5SKeCLZ8KeFBT4z/GW6zQT8EEtdIFbsrSHEpcrkL5g8tZtdNuOGPXYJVq9nAlTDzyTLXPNJKGIYy5x4C966TXDedeqVWhpIwmql+XXnm6hQNc61iAjEknNjl2UwQxjoC6Bx8puj2ROimBb2Il0V69WC3fcNlrmexHIUyMMGEclfwGxcVZcErsG3KzOYlSjDf/f2YILdv2i6DN9lZz//e7+YQBbwbhSYtIcvuNw1coX47P609xOWsAz5r/WKo+irFrgdKFLy8Z100QqDBVdpXX7Q0EPWye0ua+aQkScuFMh1T+K1Tjj8hZIAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 13:41:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 13:41:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
 willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
Subject: Re: [PATCH v5 01/12] khugepaged: rename hpage_collapse_* to
 khugepaged_*
Date: Tue, 29 Apr 2025 09:41:22 -0400
X-Mailer: MailMate (2.0r6245)
Message-ID: <56D52829-0DDF-4A4E-BDBA-6C5CFE65F796@nvidia.com>
In-Reply-To: <20250428181218.85925-2-npache@redhat.com>
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-2-npache@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:335::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f149bc-7a85-439b-5d2a-08dd87238a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RLVN+qtcS/Q2bH5XAIEwV49bT52DiFNS3byegkz1Jwn6vlt7nGU/dkG4TSCi?=
 =?us-ascii?Q?ci0SLKPszyY34VCwJsVCGJieijH3asX+Zh4wDnykyli2UxEqQkKmgvwRG4GK?=
 =?us-ascii?Q?puei9jdpijP3U3IwdYZBA4wbf/0OEaIJYsGE7zuViB94ufGAbX23q6S4CDqM?=
 =?us-ascii?Q?Vmu3UuiL8cjM3RB8l2+B6AIofruhEyR3G6kqBgVySFwad4avfDG0NuEvcLCP?=
 =?us-ascii?Q?TDN6t1N3sJ2lhMZ6CojLw2l1NDaHkX7oXcuQvoqjUHE3NXh1RM5eb0vkxKEj?=
 =?us-ascii?Q?4zSigDAKJgfE11E14+eiZlMXjek9K32z9K1NeQ+rKtWx2yAP/wMQQRW2raRZ?=
 =?us-ascii?Q?T2WQ6e5dcR+POmoIajmMBmdZYWCxPs8qw69z2tOhEY6Kiq9JmdE+mQji1Os+?=
 =?us-ascii?Q?51UClRbAhcK2Mx7uEGMixP8UwUuo6QeLuDSzcxMDps833Xn/oip017Fbf0wq?=
 =?us-ascii?Q?Ob5CbvO+ou8xgf4ntgZdDk3MBqk6+s8UpjYySNYvf6Buut11VLamb+5EUPea?=
 =?us-ascii?Q?sX0/UdGdA1u+iS36xtPooCb0+M0DUiKS4MHvfeRHA/UD2/tDZ7ZdVtMInASM?=
 =?us-ascii?Q?l17+f05jsY/M9suKfL1qZchF99v8mIGMdSfF9DNXSju1cSdMwQK6eQp5c4eS?=
 =?us-ascii?Q?tkMZdejWBwh1AgvbYDx1iLQ8hNFjTGEy6kiXsvF6jgqgpbnQCmUlaHY/I7ht?=
 =?us-ascii?Q?Ci1qjTwdZgCzvAtAIyMZLmvn2AR9G2f1t8cvj9BC0ILODQyusSVAyeEZeZ0E?=
 =?us-ascii?Q?v0C+NefaB/BQlfJ3EERivhI1hoyb5q5hO9vbQ/BIX6JQHX4GserE/REppBIO?=
 =?us-ascii?Q?/7k3qcP4fd4RMSga85c3HJQllcWd+9nD6u8cY4PDJaAfgRtnV6NHjMlXl/dF?=
 =?us-ascii?Q?waTCTYHyQhQrPAB/D1T6azjDNw+LnCBhhWn5Eo/H4HeRCcSDF1wIT2M8xFez?=
 =?us-ascii?Q?vxSZPlg1dOamDbQyGjdgDllFfBCXz2+o26gJwt7I+2//ZuF0+LBhGFtZV5gv?=
 =?us-ascii?Q?g0fhTNf+38Al3La9mgxQTZUUIJojOlsHTxBkvNTQ9WC68UmxcfVw9VGzSnLD?=
 =?us-ascii?Q?69lKFl8lZtibeDy17M/MV9FNeK820Lrr5eFFcUNnZ/QToAIWrgTCU5hj0XzA?=
 =?us-ascii?Q?zFHoJd+SKFWgteYu1DPe31PyS17E6b6kv3HdGFlpRc1RGhGD/cTkWxzK7viB?=
 =?us-ascii?Q?JtPceNnHoiUuwPmQ0ajfwS9cNTBnDler2N2GxoUm5vDgp/4ns9wHoQF+HWOV?=
 =?us-ascii?Q?TatT1RucTVmF685S1Et9Md+A5AHWq0q+F/7hD+TKEg/ThuAthQBkK+51wdsS?=
 =?us-ascii?Q?QDu7t6RPpPLJOlo/XvcEE2XJ7+3oUtC+M/xJU8g4UhZPvJ0NJ92XUxR3NXlU?=
 =?us-ascii?Q?Gbk5UwgW75Mto77OotgrbRBoyz7+AP+QjOQMLSIUOR6b2JaySbSY6xOX9U+u?=
 =?us-ascii?Q?S6+64Jef6Vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H780BH5+xfLPBxrsXL9Xcapw7nXIM5SYztBERFJ3BfOiCfnOev9F/Q7h0HSd?=
 =?us-ascii?Q?8jHpwzwtJQke8M/wKyxDfEzE0wiVCtQ7fsefbzpxmDNyxy3DBCQdD9JhQJNh?=
 =?us-ascii?Q?luxIqSZadXy53nU4+90pD0ctAZzG+eKHowI1AWRCZGCPQILdDfQm7wkNLG2c?=
 =?us-ascii?Q?XIxfMj7xEfXtbCi9ScmAHcnR1vR8OEVk7mYpZTq3vEhLVTjSUaKPIiJLsvAw?=
 =?us-ascii?Q?reQAxVcD0utLz42wZ/3hJPrbvwcDvPKJsW+rcWdUIT1kRqrHuQ7G4Mfkg16c?=
 =?us-ascii?Q?mmk904/+/mz+/LyPironFer/69FqXyX6sQ+FrhLlvpC0O9P5ANLvxUGqgRnE?=
 =?us-ascii?Q?tHThESDfNONF8z+MTj4GpNB6pL2W158fja2GO+M4QrtjBdtakwLOGmac1Z01?=
 =?us-ascii?Q?WKjAcahdqaXmqJa9dFca8DBgK6lF9SZPhSP59bP7kcSrD3nwn00UuG95Wdlx?=
 =?us-ascii?Q?tGqiy0UK9/8jkePaMttFPOmH42etMmay6kK79ovY3MmqzpTVvus0P5lalte8?=
 =?us-ascii?Q?abX+uO8eZ9RAyE9OVVzi0++MJifVQjxGDGqRC0PquWHthOHputxaM9h8UNMc?=
 =?us-ascii?Q?r/ihMzNJlWvhjaxPUNyD5tjIRwv90dbNBStDdwUrE1sjXyJKfAYlEdzK6qES?=
 =?us-ascii?Q?xJCqM3LJMBxTBco63MOT4sgTIMmJXwx8/6bnyWLYB2QL4YRgYwu/uFNWa1n0?=
 =?us-ascii?Q?s6hB0cHUwjNUPKEyzG9MhaIaHgyHYKymkqVFSfTIwq2YkJs9Sol95MYk5LWU?=
 =?us-ascii?Q?pFJJE3cbioQHoTTLESeLclCYLd1CLTfGXxb2biEPDLHh7naNYIXR8Gmbp7Dx?=
 =?us-ascii?Q?q7pz+BTlX7iTerUs4V2TMd1ELwHp98NK80OuVY49EKCc6uZK1VkGm1NEW+GH?=
 =?us-ascii?Q?PnTKbMYLEWpQoEKC9lAEGAQQyj4Na8eegqtYnCHF5MJ0BOTNPDAl6sVFgtT4?=
 =?us-ascii?Q?g65qaULdjHDf8C5w68Zylas7y9n0ti/76YZM7kY47VoU8U3VXSbzQC6XB/Ug?=
 =?us-ascii?Q?ryqdWlbda7eu1j9YOrlHQ5puT2DQnKTv1CavBEsZpa4YNynMJ10zjN8MqWUn?=
 =?us-ascii?Q?5DPo+iskA2Yc6SCq6cMhN4k1eBnkpGMJ0pmvy+wdtgdmQmb1iTuo5f4AJlZG?=
 =?us-ascii?Q?tSg5C/HeWeto2RZIopvRd5HGFFDiDkXD/9/DWl9CfE30b0j3tK5X9CreoPHh?=
 =?us-ascii?Q?TVYqszYeW0jD5y3GGdHqOqNelsEhN9fjKWO4E8l5QGRTRVSOOe/+RuK8EylN?=
 =?us-ascii?Q?v2ythP59sUiNit+maQlzvMrZhTltPXNmnM4qOJ1QdvxeiJrial4/wAhzUXdx?=
 =?us-ascii?Q?td84tNClD0HXkAzMlQnRrP52vswPjFTOTRc1X09Of0/6WQKduMJkpnIchShx?=
 =?us-ascii?Q?hEnm6Njo2lXwofbGB5mjoPs7B+su3lR0/EKopDXwU4VYgxWyNDRfCCyrss3X?=
 =?us-ascii?Q?B50F9gOG76OycGAKUA/ha2KsJNOO1AnbaaOOnJQcjuSd3c7FQmTRrG2FkYlv?=
 =?us-ascii?Q?+3yqi9kQC9vsDX1/r9uWX6Mf4moQZ7dUa3PRfXdTLXUZAohpbD/ducBIHBR4?=
 =?us-ascii?Q?dVT/YYKePOXp5rgcuq8qo+6y4iiwdGF3qHQmTDhn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f149bc-7a85-439b-5d2a-08dd87238a18
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:41:26.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaDf80CmfgVDEC0LATrLozqHRM4q+JvDSw6t6hBApS92/8N8dQLwSp9QfKWbCuUq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871

On 28 Apr 2025, at 14:12, Nico Pache wrote:

> functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> as the function prefix.
>
> rename all of them to khugepaged to keep things consistent and slightly
> shorten the function names.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
