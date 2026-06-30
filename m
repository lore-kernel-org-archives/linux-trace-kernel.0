Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4EE26B2DA;
	Tue, 30 Jun 2026 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784736; cv=fail; b=OWA5N5zyER+uvcB3lnL9/w0Jl1HWUIeJqXFJnChfGrezR/meLn/hDNsLf0r8UStKqKLa1JSb0oyU4z5Rw6gipV/sLzk9ltza552dQz+ZL5PBUy/HyVre6CIaDPaVKCGKdHXzAdgYFuAVpXFg4Jkv4HQRCTnf5okkelBq9JtljrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784736; c=relaxed/simple;
	bh=WVP81BQC0DXB66uCGb42wCHm/40rpBLAJpdGUPH7QBo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=HAAuBEwElaXXGO3amInGN9La/FGNOGnWZlAbW2dPTUIJJ9deGjd9OWQDTERdqebdJdpFbFO2gwnAnIV1fyKEjp4/XQ2mj8lM9X9bdW+i0YXKbwCRybXchsoc87obA/MfBZ/N6GGXQUqHdzYIKb4nBTq/Otm/jK7bmGz4IhBv/Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KUgnU7Dh; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KUgnU7Dh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n929WxwgcZ76HZ12XrH2zJJ5sMiFM/Y1T+2oaDOxi6ChWb7T8bJsD/2DbX6U5O9LldgQQM5YWt2PH1CPuJA8Kdy76/EGay3Ys6VnLeFkOaUroaUMpH9uelMY2allaC8FV8x3sgmdkM8TEe5/esHOZ2lWXdEcD4W+39ePiLnBvmPaEmVMQnG2SNBG/kjypLT02FHBTsTYRfSyFMLq8IyPNcrVJQGbDOCEjO6VZpKsGsOlBpbF5ZEPiU9rC8vHiBKYyCJXGBlB5hB3QYce0GYGX+R+WFvVUeQrBqNa12m6eKs1eBxs4Iv0taax4K62NBzaHANmpm9Lggwyqj+I/12O5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgOzn7wscYWbRcMg1eufbF3m0DIayiO5M34zrNzFKDU=;
 b=KaUBmXhFj7ok2+zeSnnS2oAAzjtQwT+1tyHfqngrwwViDhEuvC4R3TP5OAGJj1RIgNtQuo4SktZ6Hhx1fkjNAYbz8pdwc3VQb+uXQS1C3T3hNgQ/ir70z1yoU/bjCGvaMikj2NMYHK7vSMYctMD20iVaHCI5SscpDp9TaIUMTp+eJnmEDv24hOFK5urwxWYmT/T4d/qZmWMJf3NSljeMniP5A0ZdnDTYuAj1byVqBSeHEvR8w3Ts/8GCa1gbL7KErEh4Wfsec2MJUyE+ri/fWCZDjDKcCV5712/UeCFp+oZo7VdDgqpIoO9GC8lFzcV+ka9Guq0RsV/B8S7horI1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgOzn7wscYWbRcMg1eufbF3m0DIayiO5M34zrNzFKDU=;
 b=KUgnU7DhTW47p34K9OgXECWAP99Ck8SUjatYX8MM0/AzvR7Dw9L33dbSaYZsrxo0X9UdGmAEpD6oPLybFiTNNkpPsFsl59A6H4bgd4OeonU7Ut9gwbqwjO+jZGCRhm1++USb3yQJXkJHvyq1uyt8duPxmTT3K2xfqt+DjzvMmj8kWg6+UXpwfy2+46ohc/ck1yJ0QF9r0hShWUwAoyJgEY4N5l2e2AmJyLlscNeoe6X60bQbwYNyGDmXdaWVzElEPZrOzs1TKfPecUAQ/zQETcCKk4/uhfCgbQFMp89I4k/TTwUUm8f+U4pY+k+vMSArslqiYkK5mWO5rJNy2AiDkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 01:58:50 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 01:58:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 21:58:48 -0400
Message-Id: <DJM0FXNR6JM1.3ONT2E8UKBA61@nvidia.com>
Subject: Re: [PATCH v3 2/7] mm/page_owner: add MR_NEVER to enum
 migrate_reason and use it for last_migrate_reason
Cc: "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Gregory Price" <gourry@gourry.net>, "Ying Huang"
 <ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <jackmanb@google.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
To: "Ye Liu" <ye.liu@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260630015331.147174-1-ye.liu@linux.dev>
 <20260630015331.147174-3-ye.liu@linux.dev>
In-Reply-To: <20260630015331.147174-3-ye.liu@linux.dev>
X-ClientProxiedBy: YQZPR01CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::19) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aff0181-ca60-4986-027b-08ded64b2113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|11063799006|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Kkezu5meIb6AggIhZexCDCScAMfNybSlWbiyBbHpIPo7HApS5ZZ5BYWWyezEOdmGkJCqf1zcogBqMcFJhqxScTCgr40IQV5qgtCUxRZEXr6XbG+3aAtBuUVTrxQX4WF5Qziue3uPRTI4PB1OlIu0atfHVWuBIrmcBEihdgWhwYxV96c18fnzCaOXnfUQPMR9RawYgPEh64bxpmsQ1zo8oKpXGF3Q/GHfwSS3oIItlLeilztXjvdXfHXtUXw2G9wHoQ4cKXGvOZZpuHrmn3Qu7HS2durxJKXSDFWwiE4Qy6PLkRbQjf5k4J/089NtGheWFpY1O+TqVmJMq33A7LJlh7ecGrRwme1hUHd7dRkWMbb1QwALx2HMrgLzgQXIQXUO0E2x9Qs3YvHZ7Ik/FZUGMJslpSdCUiAgkP8C5tWI/1qeC9v+6CnOvQSutxXiMRqWEDVZg/7TDrI2qjtxGl/gTd8yWSxMqdlXx0WwjvpiTevPLUpL+ppi6l1qjcwIml23Bw02f1Pb1DrGWCuTme6LJM2snOBu9Yqn9QCPawA2rm1hrtHr+6i3q79xh9H6Vn5lB5a21PsIFbAfyKW7ILfBBxtcNJLA37AhJksAOeg1CRHSWnv9lVFUxsfrOxM4nfgHIHsfrQ6QDY/8lGgUfCJgFi/4dk4/UvyLHU31vIotrUE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(11063799006)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjFmUVg2SGo4bWRicGZ1UE50Vkx3aTcrOGppTWN1d3BRUU5mdjdDWUN6VzNw?=
 =?utf-8?B?TDhqWm03UWE1UDl4bE5odE1kYXoxUWFpMjg0RCtNMzMvaE5keWVLMEI1Ymk3?=
 =?utf-8?B?SzVXUWdkNm4xZVBFcTRlNG5RMFo1VWtJTXV0RjA1Rit6b0lEdzlIQ0dYL3FD?=
 =?utf-8?B?L01PcWNhMVVxMTZORElQNytkdXpMV29nTDFONGJLQit3UEhjU3Nna1hsS3VT?=
 =?utf-8?B?WmtaSG5uNEJrS21NUGdMME10NzlJZmZaRkVzNDZtVEswd3VkU0IrY1hDTkI5?=
 =?utf-8?B?SDJydkVUTmkxK20rSG1rYlp1MHF1aFhMSnYrTmRiZDdqTERjQmppV1BaQzRP?=
 =?utf-8?B?Ti9jQnRwT3NLdGs2ank2bkNBellCYXhaYVFjRlo4Mm9KbnZhUWEzeGFLTU5r?=
 =?utf-8?B?anBieGVJSklGbEp2bXIydXM0TTQ0Z1ZLY0RMZnhuQ2tDRlF0aXpBMEw3NGpN?=
 =?utf-8?B?bFhNazRWVkc4RFhPSXpIdE43RStYamZFVk5DVFdZM1BRdWFDb0NyV2ZTWDc4?=
 =?utf-8?B?QkRrL0wyanpHbUJEVWg0RFVJS0hzZHlhUGIwY09NWDcyaUYxY09BK1ZlbVY1?=
 =?utf-8?B?M2tvd0U3aFdyWWt6SjJPeUJncEp5eE5nbFFXaXVCdGh2blpWa2JIMC9FUytD?=
 =?utf-8?B?WGc2UjVSL0pMei82ekJkTU1FN2QzcUZLekx5KzcwaVNNdVRxMnQ1dW1BYWI1?=
 =?utf-8?B?NjdpRjlWMVgxMW50bFZITTZmeGZaVDQrNDk1bmttQ0tFdE9vU2djNjZZRnZL?=
 =?utf-8?B?Zm12Q3pPeUhJMnZwQjJpTnJVK3JITnp0ZnJxOUpUSTRiazVTUU5KRzh1NlQy?=
 =?utf-8?B?V3pUdUZVbUxxeHVVWDEwdFhONHBMTGlWR1FGaVpZMzZTOWtEbkxWbTRFNWxv?=
 =?utf-8?B?azVQRmdWWndNMk9IVUhoY0prekIxOVhibVl5NXJyVVF6bWFSU0FpOENMWkpG?=
 =?utf-8?B?SUVPaDJXTk9EMS9jY0U0WExqREVwekU2M2tjOEFQTzJKNFZnZ2MvRG96YVRY?=
 =?utf-8?B?eW1wYUowS0dXZzhsdk9QRUNmTkY4cmRXRUU0ZFlqMnVUZ0lZdVBONEx2UGJR?=
 =?utf-8?B?dTBEelcyUEFBU1dobmsvMVlId1hEQ0tVeGZaSm81S0Z6blhlbHJjZEY0ekxm?=
 =?utf-8?B?d1NHS3pUOUxWZGRHdFhqdjNjKzI1T1IxNVJDcEVxRnBhcUdzbkVjZGU4d2I0?=
 =?utf-8?B?ZURKNkwrUzNwNmNnVEh5Y3FjNnFvR0dVOWZKOStwVDArSGtPSjRKTnhXZmZq?=
 =?utf-8?B?UFhsam5yYzZzN2tVZjFqaEg0S3ZoU2Y3WjdTQzJMSEpScE9jMVQ2bERzN0w4?=
 =?utf-8?B?aERxcld5ZEp0aS9mMXJHSW5VK3RtVDB3VzYyblEwczM3ODhYeWo0MkdmSzZ3?=
 =?utf-8?B?NUsyWnJUZEtlMC9pd3phUElJMWNUc2ZFeU9FenFwbU01MkhaMHhlditZWXZR?=
 =?utf-8?B?UjNNZ1Vvc1pneHM2VWZkUFZKVm5qaWVJREQxQjliKzlsc01FS1QyTDJLZk91?=
 =?utf-8?B?YmVBWTM5TjdzcWRXUFhJMXEvUmg5OUxJUitZZ0ZPR3duUHp4TXZhRjZLdUVv?=
 =?utf-8?B?bVNYZ3NBeEhUME9UdzRrSXBITkpZdmZYd0RTZkFROFN3eXZadTJ0NVZTa0t2?=
 =?utf-8?B?VE1RM3NoR05WSExSbTRXRGw2VW5Kcm5FOE1vRnVIMEwrMnY3bzVQQlR2ZTYv?=
 =?utf-8?B?Z1hrbHprUGYxWmlMVTBOb3UwOTBzSDFud251VDE4ZlN2TWNtTkJSdkVFS0VU?=
 =?utf-8?B?bWZndmhnTVRsMWxCYWhaYWVlYklMTDIyNVFhOEZrYkNxMGxwVnE3cTJHZEU0?=
 =?utf-8?B?VXRjSlp1SERoN08yTzRRTlB4WGpEZlZBTkV1UEZ0bDdaaFVYQjJ0cHBIc0dU?=
 =?utf-8?B?bkI3VG5RTmJibGNtK3FTcEZzemdYUmJKcTJTeFYrWkg5RXF5RnhZQW5qNW9y?=
 =?utf-8?B?Uk5zaHNCNFYzeGhRQURWRUpqYUptZ3lmNkRCOG8vZlZSS0Q0aTdxNDB6Q3Fo?=
 =?utf-8?B?ZytZRkRhZUlEeWxTK1Z6NnlWVm9XSHhJTys5ZDBTanpXWTJtR3REcjhGZXlO?=
 =?utf-8?B?d253VWthQ3FuYzY2NGpOVVRyN0R6bTQ4R2tpcEhHT3M0ZFNZdk9Mc25seElE?=
 =?utf-8?B?U2FrS2ZiUXNPR1dyeVo4SXRLcUdUaVlONG13ZDhqYWttc2ZGQ0pKeGRoVmRk?=
 =?utf-8?B?ODRFcGREbjJ5d054NTlpbklWWEh5VmRudzUyWVEyeUZ4NTN6UDNvcTVUemtn?=
 =?utf-8?B?RVVMZXVUUllnRDB5MmVCZmRXQXhzV1Y3a3JoUnA4cmRtUlN6UGQwMDlDbmtq?=
 =?utf-8?Q?TFdMajXrfcByy24fAd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aff0181-ca60-4986-027b-08ded64b2113
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 01:58:50.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rSA53bdlZ0ge9Behi25cEOJNXDp2yWgpjLjZ0t1zO0PwQNQReN1rrkiWSd9QAlC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

On Mon Jun 29, 2026 at 9:53 PM EDT, Ye Liu wrote:
> The last_migrate_reason field uses -1 as a sentinel value to mean "no
> migration has happened".  Replace the four bare -1 occurrences by
> adding a proper MR_NEVER member to enum migrate_reason, defining a
> corresponding "never_migrated" string in the MIGRATE_REASON trace
> macro, and removing the local MIGRATE_REASON_NONE define.
>
> No functional change.
>
> Signed-off-by: Ye Liu <ye.liu@linux.dev>
> ---
>  include/linux/migrate_mode.h   | 1 +
>  include/trace/events/migrate.h | 3 ++-
>  mm/page_owner.c                | 8 ++++----
>  3 files changed, 7 insertions(+), 5 deletions(-)
>

LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

