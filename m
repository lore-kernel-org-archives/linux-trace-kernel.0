Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2534F48F;
	Tue, 30 Jun 2026 02:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784877; cv=fail; b=SdA1V7icN1EEZfvjpOOjKMK1TXi+4TTFMsjOmxv+KOZOkeuSfLCZj27JKD/ODj7zgXaVRhVFTIfQpTPjbnDCxrxOBt0LqHtdxseDSECIxjE+ZoO3PKTjw/qUeNHluYpQi5If8gHkpuNUV+SVoo2A8scGkKJQP6/CocihC1fIdFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784877; c=relaxed/simple;
	bh=KoozPWmex+33YQ2oTJ/cY/6sQXXCmmatXskkGoRWec4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=VXJ20Ze8fJjc7KfCvfvFIGmPhVk5KuEYNLMQrvYX8qJCEXksatraQdbBGD8RqocjuAlOeELkxzhb2gsFmUrSWVaHFgrRC+ggtWm8atk/q8TmK+AAcPZiLtdRtCtsobDJ0K/2KxN7JAFLFLhSFQnX6AWV595EgjbAzRjIWlnK3VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQSIUqpc; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQSIUqpc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adw9+KMh14yZmBU9jhDZRICyAKVPnf3bI+QtMxRs03F8zSnR3UD9HpnnF8ljHJ89J5F7cqc8gJ9l/wPOkRBYzNnvSglzqq+ne7xaeUwfTZN6GSMjfLjmK3BM1mE3sP6yAWbR/MxlHqiCU6Kgl0QTI6ebEodIpHvvdvojNwjEXvmNMSH9oW7LBStJXADLJ7R5WSFDWOG5nc6IRPvtjZyXJfs+fxZl3gNzl4cfo8IzGqvw+g2kluOGcP139HidXm1SNQcHioWfnLkyc85hLlpb/gCfAkTld5ZQjzKqscIEYQxlOtHMy4cuLfWiOHaN6RXgkrD8Ha5JtzX5MWJzxC02Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssBRI7F8IJ+B4oi+JwAYL0COLt1kqht5iTcURz5FL60=;
 b=imm1v7m8M+JouwPiDKlNvegOANro3u7nMnGtKy+ZYUHJANdxegyHt/O1NGckHO4HHWXziIXmC5H1EGlSFlD3OBST+naYiDtJ5yHJ8xriEwbeI6bwl3MhWB9rVvO01efmB7fwGd8lBdDgdPcreS06BNsbRYgsnO1DPrRtQczy0FTNiAMBG9OVAYIM7J+YtgSRS/YqV8S/VP1DFf428Yza5gfQ3OWn576JlD5nWcgfxvHxuZpc6QzB+dfDxmRRUqZLrnmI1Do4wmj7XqnPV1dO+/3uSPdv8D9+JRflFsJnUcyhZcuzp5Lr3upfwzptltQkcbBVcxWCMwqm5R/F4vJn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssBRI7F8IJ+B4oi+JwAYL0COLt1kqht5iTcURz5FL60=;
 b=FQSIUqpcG0/UwhS6hciSFp34JNR0Qo00ReBecWKPa0mntCU+TKZuh4f82vjVHrWAP3GP3HXy4fX0JzdgsGyYcXVEpGQ7v9/QDrOY+O1n+O3KNeyNR0acJv8VxQnT6tN3w2SD8Z1z8AZbA5aqxTf7dEBFt4L+PM0RUdGVq16yt8SaftQ6RS7QsVOSVsjEfMfhe96yLWHlKFV4NdBJQn7zEAwXOLFkaZPXjNT4UtE97+nLrh0WqcSyYjxeMvQ9zkL+U78H/dj31KKXDkfW2vWY92jGtFFKPmbK3/gFqbv4N0zHTC3S9yl2vZncOOwCPwcUH5KhvvMI0tjVXS9obmiyEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:01:12 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 02:01:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 22:01:11 -0400
Message-Id: <DJM0HRELNVTL.2VYXK8PB4ROM6@nvidia.com>
Subject: Re: [PATCH v3 3/7] mm: use enum migrate_reason instead of int for
 migration reason parameters
Cc: "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Gregory Price" <gourry@gourry.net>, "Ying Huang"
 <ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Brendan Jackman" <jackmanb@google.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
To: "Ye Liu" <ye.liu@linux.dev>, "Muchun Song" <muchun.song@linux.dev>,
 "Oscar Salvador" <osalvador@suse.de>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260630015331.147174-1-ye.liu@linux.dev>
 <20260630015331.147174-4-ye.liu@linux.dev>
In-Reply-To: <20260630015331.147174-4-ye.liu@linux.dev>
X-ClientProxiedBy: MN2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:208:23c::13) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9630f3-a5b1-4767-fa18-08ded64b75f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|3023799007|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	mbFpn/Cw0WI72GVO7YzXr5Utdt8KM3otpdGDVv6kqAGJqnjkUc22FwadLJjdTzmv+r4RCX17tc0S9cQfxFbN9ZrN9QyQQ+r9/IQE9FAGhHScaQEcjCpk46x8jy14jrYhyJINwhGJzZYNhFfx67ZnEYDpFWla4lggKU0rsMOffWMdh7C11yvBToXDqpXbt9+xHBXHBbP1o3hB9+PYZU0L1GQSS0wisV4CCXHcqN6vnoEKrBTz/t+vygwM9zKYaIh87LYNxmIoJIVE/F+SEadgPMTrMklr6GplwaGXvsnXsTb7VwbuuvLDrsO+nxR0qcZ6IYSPvz/YPazwelLsMvc6es9fKK/E56YoZrEhaqTbrmZt+Q3mH/+bHWDu1aaR9W/lV4FtFPXwjnlssw0/tpfJc6bJR22SSynWO1O/DWZNut+BStwo2p+wAz/BFdK+olupRt+rVD+EgMOaSJdNGpFf2Fbx1+sVMrWTPjFwh09hppJ460zoWVIps7scOWOyrLSmF8ORrFoo6KEUURavq3C+t12xlryUqsKL5JlpMxygwMdvwTvx7W48XIo1m2tra/jIj4lQku2iXro9N0zbn/unHq2HL7RqDbB8qRdjG+KiW+qMdRbv0ohGINAHttuXn57rreoc1It3gRYywc7kK6tv0Du7SI07p93eQ4rM5L4LDH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVpNNk5wWmVISUEwZytuQ2cxUGtacWtYcUdLeEdqVFF2Q09ja3hUZWRJd0Iz?=
 =?utf-8?B?TnI1WklpOUoyc0dkYnBQM0ZhdWh6L3B4THZMZXk4YWVrNXV4ZGZwVjQxQlpk?=
 =?utf-8?B?c2tjZStkSXZud3pua1FFay9kdm1HbGtKL1pBZm8vL3k4ZTFVU3plU0ZkVkNp?=
 =?utf-8?B?UUcyUXlIM3REUmd4Z0NibHc3TCtDY3I4Q0lEbGk1cEZGNVg1NTRWM0VQQU1t?=
 =?utf-8?B?VVBESkhmOE1ZOUcrNFhNRjEvQktob0dxWFo5SnVVazdWMEEyUStpYzZOcFk5?=
 =?utf-8?B?V29zeFJteDF1REdINXZrQVd3bkVMOGJON1c4UXNlaGY3Wjg5cnBEcHVibklH?=
 =?utf-8?B?MnpLU25IMjBaRmlnSGVtVldLeklHTUlpdm1KM0N0aDF6bzQ5Z0hSZWNsamJW?=
 =?utf-8?B?blg2TGpYWFV0VVRPNWVqZ3k5VCt2UU5Zak91K0xheGw4RGZ1NE8wMFhNMUl5?=
 =?utf-8?B?aE1iNFR1WXFHcHZYd0R5L0tFaEE0a253U21YNmtJL1AzZXBycU10ejJFbGNv?=
 =?utf-8?B?WVZoUit0R2JjZTFhVTlNQVAvY2hTU21xTWVMYVpNVWlLUjVQUFNKZ1hXK0FF?=
 =?utf-8?B?WWFkL2hDSkRpOUtPMTE4SVIzaFZqemJLa25DQjkxNDVpVy90My8zMjM2ZlNM?=
 =?utf-8?B?WlVtR2JkZkdveHp4cGo3ekZZQmVrYmpDR3VEN0s3UVZZN2FGYVFtUXNDb0oz?=
 =?utf-8?B?b3JMQU9IKythNlpsYmRlWENNbEdTckxWUFdWS2tEZGs1b2ZZanZ2RWozTDBC?=
 =?utf-8?B?UlM0bVBweWVoazhpVVd2RFdsbFdDNkt4STRsb2pjMFFEbXBUYjVjSXNJYlVp?=
 =?utf-8?B?MXNFYlcydVN0V1BTaUpaYlE1NDIyTndycSt0d2hmQTNRZlBGenhMQWUxWHlk?=
 =?utf-8?B?UUJaQWl4enZub3hJM1ZaS3JiSjFsSElHcFBpcDhJeXp6cEpqQ0M2ZklYMzEy?=
 =?utf-8?B?bEdDbWhiYmRDcFFpZEJjckdHb1p3NlpCMjJUbU43VFBGWUU2NFJXeFBRN1lY?=
 =?utf-8?B?YVFhbTJLNmpNNEZySTVWQndDYWt2RFJPTi8vMzZib3YyTVRPZ0NFUEF3aEUr?=
 =?utf-8?B?OWcwdW1Nd2drTXpmaldTUW5yOS9heFhhWExLYmNCdW0zNFRvWThlZEVZbGZS?=
 =?utf-8?B?T1lDYUxTa3lQRjlqZXJRbVB4OS8zaHN6MUNsWjdaWjcrRUZCQkdaV1gwb20v?=
 =?utf-8?B?MVFFQkNWNWFVaTE4UkhTbVhPWklOdEFzTmxGWmtPT0M1WWd0SHc5b3J5czNZ?=
 =?utf-8?B?MHdNQ1hyaWxYYk9rc3JDVWRzaVprRFFGVjBKN1J5a3dsd0kyYzQ1NGt3dm9a?=
 =?utf-8?B?Z3FxekxjY2pLbFBPR1ZQYTBQbkFlMUpWS3BPdjZJQi9QQ2JyZ2Q2QUtBcVNP?=
 =?utf-8?B?SmFyTkhlVW1aS1lidDRnR0hyWXlraml5TjBJS3Fjclg4RHVlMFJWdFZ6OVJN?=
 =?utf-8?B?UUJzRVJTSDFqam9MQUtTREFkbkZGbnl3YS9JenFaazdMbDdGV3lSMnFtN2ts?=
 =?utf-8?B?dSt2OUdVRkgvTGloTXFVQVNuQjZRTFduN0ROT3VxNUxNcHpHVzdCbURJbGE2?=
 =?utf-8?B?TE9MOXo4LzBOQWtIb1hSeFpXb0hXSktqaTJPRHQvTWdxbXhXUFB6NkNYT1Jw?=
 =?utf-8?B?eUxDajZuNTJkRmxyaHNPWkQ5V1YybnFIYituc2tTZm1VSmNYd2JFUlRKSnFK?=
 =?utf-8?B?VHROaEpENEZYNGVCeVFMZzdxNVBXUHE5dncrU05JRmNVaEp1VHBUaWU1cVkv?=
 =?utf-8?B?VVd0b0Z2RWJyUk1ZRlJXMFM3eVE3NXl1RjduekJsM00vTVg5R3cxUG80Tmhh?=
 =?utf-8?B?MWpLazNIQWxtZk5XSmw1MExFcERUbDFFdHJqTDloRFdmaUExZTN6aFlDQzNG?=
 =?utf-8?B?Z1YvdG1EcFNwSHEwdXZNZGRTVG1NVk5HVktteURhMzlGVFBBUnNGNVRERmwr?=
 =?utf-8?B?R3RkcnpjMHJXcDRaaC80YkhUamN4UStMS1k0ekV4elBVT0pCWXNWcVJWQmhS?=
 =?utf-8?B?MjlPM0k3Y0pxVEZOMGs1cUR3SU4rY2JJVHc2cXhUTFp3NWhaM3BJbGRhQkIv?=
 =?utf-8?B?MjA4eUR6Q2NvcXlFOEFwSjlOT3ZmYUtFK2JEUTllNFdZUzRlZTNJRFQrQmwz?=
 =?utf-8?B?SE1tOGh0ZXg3YjZmVVVDR2NQaExXdDY1YXc2cGlDT1hrMHFXdXpjZnJLV0Z0?=
 =?utf-8?B?L213QjEvZXNYeHVSMkNwMnBNcWphZTJFOUttMUpzY2kycDNuYUwrZFlINnpY?=
 =?utf-8?B?c1hDSi9XaW03NklFNVVJV2tnSWVzaXd4SW1rcThqamo1WC9wRlpndW5ObVAv?=
 =?utf-8?Q?9ql6pfUfxUzGkuVrW8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9630f3-a5b1-4767-fa18-08ded64b75f5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:01:12.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLBnXUpwK02ohSaUthNwvFQ90nOJzubY/cpakK7+bVkAUAeveFL3J9D8Ez4LmlPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802

On Mon Jun 29, 2026 at 9:53 PM EDT, Ye Liu wrote:
> Replace all 'int reason' function parameters that carry migrate_reason
> values with the proper 'enum migrate_reason' type.  This makes the
> intent explicit and leverages compiler type checking.  The affected
> subsystems are:
>
>   - page_owner: __folio_set_owner_migrate_reason(),
>                 folio_set_owner_migrate_reason()
>   - migrate: migrate_pages(), migrate_pages_sync(),
>              migrate_pages_batch(), migrate_folios_move(),
>              migrate_hugetlbs(), unmap_and_move_huge_page()
>   - hugetlb: move_hugetlb_state(), htlb_allow_alloc_fallback()
>   - trace: mm_migrate_pages and mm_migrate_pages_start events
>
> The 'short last_migrate_reason' struct field and internal helper
> parameter in page_owner are intentionally left as 'short' since they
> store per-page metadata where size matters.
>
> No functional change.
>
> Signed-off-by: Ye Liu <ye.liu@linux.dev>
> ---
>  include/linux/hugetlb.h        |  9 +++++----
>  include/linux/migrate.h        |  6 ++++--
>  include/linux/page_owner.h     |  7 ++++---
>  include/trace/events/migrate.h |  8 ++++----
>  mm/hugetlb.c                   |  3 ++-
>  mm/migrate.c                   | 12 ++++++------
>  mm/page_owner.c                |  2 +-
>  7 files changed, 26 insertions(+), 21 deletions(-)
>

LGTM. Thanks.
Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

