Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020112.outbound.protection.outlook.com [52.101.51.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DA9224AF7;
	Mon, 21 Apr 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745275129; cv=fail; b=imkujg+iOXgqotd/YOIlCZoAIFF1togUFzMOoIveK87mnJbop3H6iZazOWdE9alOx3MQvelGlXmCdsqPADH7e1AyHuXIBNr9uIToMR9KfE/iu9H41kax3VRtgsd4DtZceJHZ96awUgHbPd5OG6PHbRcsGHiSW5OENcZwuWsXlns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745275129; c=relaxed/simple;
	bh=+nUbCMZbvMuEPb+7D71bwvOM+MqB7YrUbWq42udG6nA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gQC9ISGMY0z5aL+FBIAnnUqljjW93RDy6ODOOas+FFtAImuJ4aEVkOASxwmzaQvY9ZeP4w+RhC3Wc9fQZvywV2CpMKZGmss1iVhasvODHTfwhkM1Cg0pxzP51CJ0Kc9jJLzVqh+riLCq0oBCgKrch5WcYWBKWppi2E5NnWnmKRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GMvGU/KM; arc=fail smtp.client-ip=52.101.51.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GMvGU/KM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ1x7J/KNbHO/4A3pdkOOilR2YliUkfGJ0kDcRnIOyJFE7aUZR317B/OiRdj4Og2Sf8kYU35u+kNCePHAEzvmmXEYwpui79JEIjbZOZ+9eBHV+7rxVLCtJE5lyF3ngim03NBWOCE737UVTpwev0QYQPx5FtJvoBEmWibwOdibvVe5sZUcx1OPPsgIGOhGuhzqu/n4BSe9ysM8dxGdjIiafpJ2uDetHgBajaBKtALkSYvt2J6RAjRJJ6qzyVpqVmxPg/VLEuLCTr2JGm2ow3xyMZ3gcTfmrvJC7nKgRNh0Ii9dWpSaSeGRDssHmArEl9JBI2hWy6ygg8knEi+6GM9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwy+eR3lmGFrnnmbJN6FupFJQi51TAhfBxhWj976cJI=;
 b=tApCl+XBiXCogrCbPM1kPx1qaqyMNTfjFMvJDw0XoV8nrQCxuERkLHjpjT1S5o6NWw0Dj62PkYoDwbbZQ5drT0bnCc4ZHbvWjRetOLYFEWKEfogpcQIXVnBPgJh0ltKvlaLP+Wx/f5d0s9FRNTZUrtBKcfQW8SuUXVlK/j+kmF96DAAwuXLqDD4aFCIeIN5iNLghOVHpy5B+8ltCpEYo5yErnfbRN1NRz6NMk1g3dxfJvkV4F2lB95DWnC7/FOnSKOTs4WStCqpykFWgJ17ER4VJsG1zoDs4Z5PltbFsq8HxMcMcX3OhItvooRehFmFZKTz/RqpQlNC+kXkBZ3j6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwy+eR3lmGFrnnmbJN6FupFJQi51TAhfBxhWj976cJI=;
 b=GMvGU/KMvaP7MzNcOISMrUJWd7zGatH4QgdDt691ZLawDEZ4arjJP/QML8J4ns91hFPjEaKkig/UZ6eOGpI6mQEuKlZnMAzTXT95EI1kgJlkxXzrJr6mwDZYxRyip74s8mxbxVILgBEux2WmjsXBMiSzJmXQonlCtas/hDRb1SQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6226.prod.exchangelabs.com (2603:10b6:303:77::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.34; Mon, 21 Apr 2025 22:38:43 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 22:38:43 +0000
Message-ID: <4cc73e33-f703-40af-9099-ebced9273778@os.amperecomputing.com>
Date: Mon, 21 Apr 2025 15:38:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] khugepaged: Refactor
 trace_mm_collapse_huge_page_isolate() to take folio instead of page
To: nifan.cxl@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org,
 willy@infradead.org
Cc: akpm@linux-foundation.org, david@redhat.com, fan.ni@samsung.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, npache@redhat.com, mcgrof@kernel.org,
 a.manzanares@samsung.com, dave@stgolabs.net,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20250418183920.273154-1-nifan.cxl@gmail.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250418183920.273154-1-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: eedd533c-a637-4462-8aa1-08dd81254537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTRhZldpUHZJR2F1NVY1cDVXb1dMU0hRYXJIZ1BWdHFHaDlmd2NseWg0Um1T?=
 =?utf-8?B?YThaNXFxM0hhWjgvUVJEZ2hlM25lWGpicTBFN09JODlTNk1UVENoS0lOVzNK?=
 =?utf-8?B?VkJFbDNWY2xmZzZpM0xnb05hdnJGdGdvdkZUZDhhQ25zVkxJT0c0THZOYjI1?=
 =?utf-8?B?ZlVOcEdCcG1QbkNNQTQzK3h1MjVzZ1JZTHR2dVphSEtYL2llS0dTNEFTS05P?=
 =?utf-8?B?TUUzaFI3QVRhSnNhYVMvL0poWlRIbXNMc1RkeGExOE5ZR2JIN0pOTVVBTjZE?=
 =?utf-8?B?aW5TWWFWUmlRQ0JQbXpjMjFyU0tyRkROaEphTjF0V1FRWUNuNUlhZWx5bjFD?=
 =?utf-8?B?dWpiU0dnbXJBWWpERGRoOEx4aUM2bEVHUzhSTndrTHJCSllqbnVhek5jdmpP?=
 =?utf-8?B?bFpsYnRrSkN2NklKR3dlTXRkQXdOM1hsWTk1RlB3Qk4veThLMVNYTEdkUlFK?=
 =?utf-8?B?c3MwSm9Oa3Z4YVNPMERHcVQ0ajZJNEh2YU5TaWxDOE92SmViYi91c2llN3dv?=
 =?utf-8?B?cUorUDNWdElVc2FteU9UQW9uNHRlMnduclkrZy82TE93UnNqWXhneXAyQ2g5?=
 =?utf-8?B?Q3VwbUc1Sis3V0NPL3RSK1l1MDFqSDM3Vzc0aUpTbTFJTEtidGViL3phekVT?=
 =?utf-8?B?cXdla1hBbDZDMmRkam5mRlRuTWZOUVkrNzd3c2VkWTVYbkR4cmNXNllvMTVw?=
 =?utf-8?B?T2hPN3J5cldBSnNhTDhEQUxSODRUNjczdHNkUHlkTVg1M0JmSDlUWnp5aWgv?=
 =?utf-8?B?cVVtSEZ3b3dUWVJnOWhtMmpKZGdhd3VoSzUyU3cvUDlLQm91MXNvUExsd01M?=
 =?utf-8?B?bTA5R3N3SmNNT0VMdkgwOUJlU0k3cW1qMkMyODlhbVdCb1hBemFLVllTbFNj?=
 =?utf-8?B?cVd2N0V2SURURGw0MFBIOTI2dENSZUJLR0lkaHBSM29MN2hzeFN4UzZaWUdr?=
 =?utf-8?B?RFk5Yy9sK1lFakdCdlhaWDd1ZCtqcE8xZVVxQlJnMS8rcVljWENNTnEzK0Fm?=
 =?utf-8?B?L1JqbE1ZL2RubFNzcXhTZ3YzTUlLbWhidUl1MDUwYm4rVlEzWkYxaUpjS3dh?=
 =?utf-8?B?MGlRUWJ0ZXdIOUZNTUNBVVpZUmxEY2NaejBReGp6b05sM1hRc0hJTm1ZRXdt?=
 =?utf-8?B?TDFjWGE0dlY2b2RWTE9yYmQ3cE1PRTRwVXhBODVXVTJTU1JrSWNSYVc3Q3ZW?=
 =?utf-8?B?bVRkaU1SVGtSa1J6cVZvS01Sc3JmcEx4QUd0QmhncVd6VWp5U3RHNlN6TDhL?=
 =?utf-8?B?NFd6OEZkSUUxenZWaVNxQmE2WUV3MkE2UGd4MmhEa1AvZmxSRHRvdkVxcnlZ?=
 =?utf-8?B?eVpsU2hYZWliMHM3bmduSVZjNjc0Vi9pL3dsRGVSSWhQYk9qK2xlSXR2dHdk?=
 =?utf-8?B?NzF6UkM0MnhMZXZjdmVldGxlaHhWdjRVMll4VEV1ZUorQ2VTeDFNRnRuNm0r?=
 =?utf-8?B?TURXR3UvbUxHU3ZvV0ExZlNqdzErYlNCRTJEMG1nVjZzVmFOcWw0b05hZGpw?=
 =?utf-8?B?N2tPVytucEgyNnZMLzhvb2JXNUlmcWNsRFNaT0tYMFNSaDNJR2RUSmhRRXRP?=
 =?utf-8?B?U1c0bjF4Qlk3RlNENktEYWJVdzB2M1VxWTJNanpMbzU2NCtRM25TS1AzdEhi?=
 =?utf-8?B?NzdWZ2M1Z3I1N3lvZngvcW1QdVk2VkVUNVpaSmRSelM1elZWUERVSmVlZzZW?=
 =?utf-8?B?bDZ6RGVVeXBvZXFjZGtwZXhtRzh4blNtb1pXTzBhVDF2QytRSzg4aGRqb2pa?=
 =?utf-8?B?aS9rczVOVWhROGk1c3NZYmVnaWVFSWRwRE94NUJ5US9ybFZBUUk2TlFoY3J2?=
 =?utf-8?Q?wJCmEp52TylQRrCLOAwWupy76eJ9StZXm7VK4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWtYQjQ3Y0ZHaEhlNGQ3eS9mYUNXT2hPS2cxY1JCRm5SeHZFbEpKNTRqNHNl?=
 =?utf-8?B?bnc3MnMvbHF5WWRQRnlpejlHRGdjV3hGMlhTUFpZODdrZUZ4M3dyK25OSGUv?=
 =?utf-8?B?WXJCeEc4TU15Q0dsMzhObUNLVGpML1FDUmVMYTk3ZHJwWXZyeWZETnFycGhs?=
 =?utf-8?B?cnJXa3BrN3dYUHdPYkZ2Vzgva2NtWmtXN3NHVlpLRTFUUnpJSE1oSXZQd0RB?=
 =?utf-8?B?RE1TMERRSEF1UEgxRVZXQXY1QW9hTkx2U0ZRanRGa2tKSXdtVC9IWDZaQXZH?=
 =?utf-8?B?T2UyTVQ1bEo3Q3lqbVNMRkFFNnorUWVRVVpaZ3dsMWFYU0YxbEF3VXlEUzZo?=
 =?utf-8?B?OEx5V1Z5SkpjTkY0c2w0YXJvTWlSSldjVkQ3YllCQ3FtK3hEcFE3eHFzS1Vx?=
 =?utf-8?B?TWE3VWtaN1Z1b0drOHQwMGJoRFdKOXEyMVY3SEZmaWJFUEFXSjQxVHZNUGE4?=
 =?utf-8?B?QkF5TysvMUpjRE9lQVhNMGRNYStkQWZMMTlEUjh2ZTU4eEtVcVYrQkpid09X?=
 =?utf-8?B?bW43Z0NVUEg2NE5BMTdPeHRUMVIxQk5Ncnh4NE50ZC9iOUZYS3lGU2RNaThQ?=
 =?utf-8?B?RFczZ2pBZGdRWU9aT2lhZkl2QlhBQ1JXM2lMdFBpZzJ4Y0xGR3l5VTY3SUQz?=
 =?utf-8?B?aHJFbEQ5Z3ZZT3hxeHVXdzVzK2NRSkxaT2JmalNXaEhZRzhwcTdLajkyQkU1?=
 =?utf-8?B?RytOQm1RUlpGVTVSZlhnVjBEbXhub2VLcndCVmlUSTN4Yzg3RS9DUThvc3Fi?=
 =?utf-8?B?S3k4WVRMWVVwWFV2NXNKQitzUFN2alA2VnkybG9GVWlNSExlakppSTBmQWhz?=
 =?utf-8?B?VlJhWU5kQ1FnUXZueGJ5RGRFMFBxNEJUVkRFVjhVSnJGMERHek9YMWxkSEU5?=
 =?utf-8?B?VnhHOXpkQmIyK3MrdCt6QjlaaTZIRFZVSnAxWUU5SFNYUlY0dFZrT0NkL3p4?=
 =?utf-8?B?UklpK3Z2MHJVdEFGb0wwVDJKWXRmc1I3VlFFdlowQk1lMzdDUnZOWnF4eDFx?=
 =?utf-8?B?a0VaL0daYmhQV2NtUXhmeTQ0UkZSZDVYajBGNzBZaitYSDlSQitSSlhVNEgx?=
 =?utf-8?B?c2t6SXdqK2lzOFN2bXlueWNrY1E4NFhYRkRuQmhhOWQ4MzR2eWpYTU8wRm9U?=
 =?utf-8?B?bXVPamxRZGJ6MWF0S2NuMC9lcjRuSW4xZFVKVHJZZVZ5SWhkN1ozSmJ1WUdZ?=
 =?utf-8?B?Y2RtdS9IeG1kdlZ6K3VWTTRhSGJTSDFxT09NQmNkeWl2Qk8rOFVHM2pIUWsv?=
 =?utf-8?B?SHlQS3NlVnZZN1J0ODBnalhQenREZEx0SUNNTktadG5yRVk0bHYxbGtzdEt5?=
 =?utf-8?B?cnNuekE5SzViSVhNSGNuVFVaUENtK0prMzdNdnN1K1MvSllsbHRoWjNBTVV4?=
 =?utf-8?B?a2V3L1Vxb2RDYUhWT0JwM3FBN0lvVTZmd1ZjUm1jdVBzb1FOMS9ZdlFsTDB2?=
 =?utf-8?B?M1B5QnI3d3hsNFY0WmFLdmZsU0hMZ1VTZ1RYYUNuWWhIV2tYaXRoUEo4bGcw?=
 =?utf-8?B?YXN6MlF5bjhiMDVYM25sdm0yZFVHc0I1RERLdEduSElGV29QbkRtVkdkVisw?=
 =?utf-8?B?bUpZNlh5dHBraWJGdFR1dmoxa0c3UHI2TEI0ZmRMTUtTLzhSekpOZFc3OG8v?=
 =?utf-8?B?TTBKYUkxVzVLRjhBeXNYcU1OaDlqSmJhVGJWQUd0UG5ZRVIxeFFXdThTRzVC?=
 =?utf-8?B?M1Z6RUMrZCtWWEZ4V1I4RnJCaVpxT0lMc3VSSlFub2hzM0hoSklzYkEvM0tk?=
 =?utf-8?B?WVpKcEFqTVBYMjg5dXJjeGI5REtFQnNlcUZMcE9ETFFTTXQxSlNCNnVwdVJI?=
 =?utf-8?B?aEk3SS9OUXhnUFBianVwOS9GditYU2FBY1hnYUxLRDJjRFh2UTZzemlGRFI3?=
 =?utf-8?B?ckNQbnorM2liUEY3aWhnNy8yT0VNUnBNU3c0MXpJYTVPNnRBdnZTdjlSWDA3?=
 =?utf-8?B?dHZ2NzBTSW9wVkFOMHdXV25JcENseE1SOWJyMWErNTRzOHpPWUx2MWpsVExq?=
 =?utf-8?B?NnB2SlY5S0lReDIwZUQ5L0lQTHVlUWJxdnNpek9NNHd2VWJtRStiMGxqaUgw?=
 =?utf-8?B?YmFmYW5XWWUzSjcwR2RtMjRQVWtsOVlmbTJRVG1CbGZ1YTNGQlBFelFVL0tE?=
 =?utf-8?B?TFkwNCt2STczSkpCS04ybTVZR2RsaHBSRktpUE5oaTJDR2g1Z1RZWTNVdnlk?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedd533c-a637-4462-8aa1-08dd81254537
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 22:38:43.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5V0dl3O57rnUq/1MP5ZB/2ZzGF8qgzEyPvhQnxHrlhD9zxVYaxnGHguyoS1wv7YJLHuLQts8vKi4oT4cGxLeOHOwjXRb5hr4gb5+0qy1BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6226



On 4/18/25 11:34 AM, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
>
> trace_mm_collapse_huge_page_isolate() is only used in
> __collapse_huge_page_isolate(), which passes in the head page of a
> folio, so refactor it to take folio directly.
>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Nico Pache <npache@redhat.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> v2:
> Picked up Reviewed-by tags;
> v1:
> https://lore.kernel.org/linux-mm/CAA1CXcB06JD9Fp4c7GGU3NHEm4W-aV7TS7JW7eWxshJEM4t2_w@mail.gmail.com/T/
> ---

Reviewed-by: Yang Shi <yang@os.amperecomputing.com>

>   include/trace/events/huge_memory.h | 6 +++---
>   mm/khugepaged.c                    | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 9d5c00b0285c..a73699f000de 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -116,10 +116,10 @@ TRACE_EVENT(mm_collapse_huge_page,
>   
>   TRACE_EVENT(mm_collapse_huge_page_isolate,
>   
> -	TP_PROTO(struct page *page, int none_or_zero,
> +	TP_PROTO(struct folio *folio, int none_or_zero,
>   		 int referenced, bool  writable, int status),
>   
> -	TP_ARGS(page, none_or_zero, referenced, writable, status),
> +	TP_ARGS(folio, none_or_zero, referenced, writable, status),
>   
>   	TP_STRUCT__entry(
>   		__field(unsigned long, pfn)
> @@ -130,7 +130,7 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
>   	),
>   
>   	TP_fast_assign(
> -		__entry->pfn = page ? page_to_pfn(page) : -1;
> +		__entry->pfn = folio ? folio_pfn(folio) : -1;
>   		__entry->none_or_zero = none_or_zero;
>   		__entry->referenced = referenced;
>   		__entry->writable = writable;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b8838ba8207a..950d147cd95e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -696,13 +696,13 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		result = SCAN_LACK_REFERENCED_PAGE;
>   	} else {
>   		result = SCAN_SUCCEED;
> -		trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
> +		trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
>   						    referenced, writable, result);
>   		return result;
>   	}
>   out:
>   	release_pte_pages(pte, _pte, compound_pagelist);
> -	trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
> +	trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
>   					    referenced, writable, result);
>   	return result;
>   }

