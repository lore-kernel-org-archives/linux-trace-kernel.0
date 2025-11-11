Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2CD277CAB;
	Tue, 11 Nov 2025 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762840752; cv=fail; b=dtOvTAjxCVimcsSY75TuepdgOGruWg3eOmXejU0pXyM7ib4+S3PAo/dbhLJGB+k+ibS9oLHJwNiH5w52D8dtQIQ8eCBiSRTR9X2ZVhBQvI6Uqpus/mMQah/xg12JAs8hnzJ7oa9RUNwy1bfsZact3tlIQoKRO1cu/sh+KTkDgA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762840752; c=relaxed/simple;
	bh=p/90sDFKqosD9fl4w4Fei15LtROb2f1HRtWr1aH5/LM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JPmVAwTTXp3+mDYtgLx3lhckqu295GHIf2HOZC03CsWynILsPTXy+7cTyMDa9CF9LBj80ZQL0CgfQsz5A2/New3pOEXahGbNvQ1ZBO1w7qnlGtUU66tSxY08ITzJ4K3VHKafV3xXCrBR5cHMBmlcvaR6b9+AzNoAQ8cVuOjM0AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WTUQbT0s; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WTUQbT0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elq1WNqsm7J04W8iSOHNUUq3o+28S5emYLNQWijjSjDJfLisFwybmVXqE710L+orbNExvenQ1fDAwru+spbnUxHjVIAwYc539Hv6gxvqtg8ZQkf2ZctGTkqz//Sz4c5eiR5eag/C8H7A4oCiTAyPqrotpahzKf5NHqJmoqQi9rzVGvOJ/5Q+rRHrCxzDhw5cGgUtEAhFkJGeCwWENPbqj1/3LzUHwiuT0eARKnJcDnfwiaWxEhmMgdEG9sPiZTip/qNLMSViCa9j0NMpEHRQ+XbzmZGBqn0rNYldmCAhlfYPhRStgxHyKZrtxNooX4uwQlLZjl9CvdIZ/oCEcGDaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ff+p2tzGhD9rj8pxwbwXPcYA4tfjOvixLAVdAdKAWc=;
 b=OwDIrArMB1QpEWBN07nkFW8fm24rwxGQwmqgU3eLPp3q4ERY57Z5yjbbBkKQ0xJxCmT5nFBWdhJFS8EF9MSA3QPC4YFMCHzqyErwFfMOpYQtloyrtfpQPc/Q0ea41DWpPEQUiFNwWzt7b+L5S5OCd754B6ozlDK57NMgSDwJoONjx8K+7Q7TUMjtmzASW/JY7fRr07Kdn44iw/CcNkUCFGr8rsSBUjNR4oAGAy8nawwXIm9RnXW4S66diqq90rbsv7skWeRzKwNK2JRthWhFxrinBAPQQzLSGjGy7hBzsj6cGjcp68aZoYEyzoSRx97Przzd530TmCk940ogSkFVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ff+p2tzGhD9rj8pxwbwXPcYA4tfjOvixLAVdAdKAWc=;
 b=WTUQbT0sLDw2thUODg+Q0pcXu9op/nYQTfurH2FkHeaxQaEudhssLdgX0WTiMSTNeSthjkWRJENNRleEtLwxMx35Wy56UocV802DxB13z6qe8aceixzdd/CvE1lL6Ngo3LFNBVQLeru0zxHVL5dUYdLQsLPxo3x3vdMIooSzoi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:59:01 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:59:01 +0000
Message-ID: <e38e8059-a62b-4ad5-8316-5af02a0cc1b6@amd.com>
Date: Tue, 11 Nov 2025 11:28:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
 <b7313a45-c36e-4390-a0b8-46f412474f86@lucifer.local>
 <39c8a4ed-53b5-48e3-baea-f67cc1e8be4f@amd.com>
 <aRH2pdhMBQ-20IC9@casper.infradead.org>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <aRH2pdhMBQ-20IC9@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::14) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 124d3d93-f1df-46f1-f829-08de20e7690f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUw0Vm9PcUxUQmxIV1VjelpvVFdLZHByanZNeHVLNSs4N2hJanZXQ2lOK3J3?=
 =?utf-8?B?VjZlZXluclY4V29UK1VxdjJjT0kwUjVHZ0ZkSVUzckJ3ZTZ5OFQwR05PNVhJ?=
 =?utf-8?B?WFlFcXlFZitDUklEdmF3WXBNNkZsejltLzBMMUl1NlFiWXZCQ3h1SE5pVnMy?=
 =?utf-8?B?Y3dJTnY4ZDBaaG9aQXh1SXlFTnBCWTNJQnQ2ellaaE1FY0VDSDZZbHhTU2ts?=
 =?utf-8?B?QTRhL2lwbnU4RE1jb01kRmRaVFVERlhkRDBxOVhIZ2NRT0N1eEFxZStQL1FY?=
 =?utf-8?B?bjdFWU9QOW11WDUrRit2a2dxRWlSWWhWaE41dTl2STA2bFpDcm5Bd3VVampt?=
 =?utf-8?B?RVJLRnBDYTdCcmFnNUFndnBhZ2xmMkEzYVMzcDR0OGFVdGt3QU5ZcDJ4WmZO?=
 =?utf-8?B?QnlKMlZFMXZoRHc4Y2tlMHc3WnRvb3ZTYXlDRnI3SnpFSU1wMWVGOHRIYkZJ?=
 =?utf-8?B?TlF3ME1ldVF4N2IwNGxnK0I5WkpydldrNGtxZXVyM1BldEp6MHJJZjB2YXZn?=
 =?utf-8?B?bkJSb01LZGVoLzN3VkE4VjRJVFgrclVOOFNOaHNvOExnRk03QU5iUUZNNEw5?=
 =?utf-8?B?SUQxeitaSkV2SnF3WE95VnBaQ3ptUnltNDRiaWJDT0Y0QWRaN2NZbk8vSGd2?=
 =?utf-8?B?RnVENzhJWlJpbU53SVBZSHRicHdmNEVrN1Z4N0JGbmZBYnBRZHZ4dTR4Q0Mw?=
 =?utf-8?B?ZFNzMlFMQ0d3ajhQYUxrcExnTStMM3NhT3VZU0dvUFFkVEtDVi8vUVVaejU4?=
 =?utf-8?B?VTdBbTYzMkZLeGNlRE5iRklzTTViaXczVmE0WXgrTVpVeEM3b3lEdlhHSjNC?=
 =?utf-8?B?aUFXQXpSZnREaXNZZ0tMdW9Id3VoOGdWaUw4MWRnRzc1d3BCZWJJSkF2dHR5?=
 =?utf-8?B?UGJXanNLbDh6VG1RN3MrN3U3RDRmejM5eGRJQjdMMURpZ0szU3M5ZjBFQXNE?=
 =?utf-8?B?Z2tFRUxkSDIrRXVSWkVuekNmZW95b1N1OFJhS0E5emRXVndqTWl3cHQxR1p3?=
 =?utf-8?B?K1hMS3RjdjU5d1U3d3FSekJldEVjU2E0d0dSNjZNdVQvTGVLRWZyMlFpYnRN?=
 =?utf-8?B?cXBrd0h6UUk3U0dkeGkrVmN6cU5IMDRVMTJqcGtsS0xjeTdSa29KZHlkSmJ2?=
 =?utf-8?B?MlBNVSs0L0NTNDFCYy8xWGVjQnJuVDVPOFA0MmhpclZjamVNWGVlbVVmZU1B?=
 =?utf-8?B?MzZFd1ZybzhwZFBuWmgvRW9tVjBGamxkTHh4alBDNDVheDdYTWVNWURSc3hp?=
 =?utf-8?B?Q2VKSk5RaU9yZmlkRU16Sm91K2xQSURqQ0xxWFpnUlFQcWQ2QlB5V3NXdW5G?=
 =?utf-8?B?Ky9MMnAwMnAxWDFEVGYyMG5TQkZZMUNPd3ZGSExZTlRzYnZ4dkNHdHFuMTUr?=
 =?utf-8?B?SzBOcExqckRYNHNjakZPdDVWbnhxalp0ZTlJRmJKMXlhR3hWRDl6cnF5bUs3?=
 =?utf-8?B?L000ZDZaSXo4ZVE3c25GcnVQWTFPSlBMZ0RxMGR6citNYlR3REdsb01WMHNw?=
 =?utf-8?B?b0gxTzFOK2RlME9TaTFsdXg3TC8zSXA5Vkk0M24vMUo1SnhWUGxUZFBWZUlE?=
 =?utf-8?B?L242V2Q4S3Ryb2Z2cVdKazMyc3k5UEdIUHppNjBGMElIbS9pRFlhTnNvUlp1?=
 =?utf-8?B?OHM2dnYxTThxbXRMeXN2SDI0MytONnZXSFp4Z1R3a0ZtWXBacUg2TWFvelJu?=
 =?utf-8?B?U0huSXhNT1dpQmZUUE1vRzk3aGhmRUxFY2FJb1B1OWk3Wkd1V3oxWGViREhW?=
 =?utf-8?B?THNxN3lTOEtNVmt4bFRCTEVzQTJzeVpHbXJyMXBiSUIrSzEwWVBKUnlXM0px?=
 =?utf-8?B?Y3lGOEVvbG5LMEswMlZyMlpmQ0pPcW5rMnlPKzluQitWNmwweTRrT2MrRGRQ?=
 =?utf-8?B?NEVwYk9rWHJsaVhPMWZNdkJqTVZEYWcyUGN3QzJjdmg3Y2swSmdZMGhuKzc2?=
 =?utf-8?Q?k/c6CKTk1CZfQfutd9Uucii+EOYff9Dc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjg4Y1BUN0t5TER4QWExd2EwcFZsdGpvU0tWelFkWms0VklmZVV1bHBJc1Ba?=
 =?utf-8?B?eXRGU0pDNVNiZVFZMjhTWFlzeUhRMTNzZjArUk5rOXRwLzNqNVdYbThJcTZu?=
 =?utf-8?B?aFBiZG1Da0p4aWtiemY3NkdHRk5Pb1B0SmtVZTZOWW40Yy9CWmpyVisvUzc4?=
 =?utf-8?B?amRnTS9kQUJhNjVmMnN5RXpqamZOeEQway8vN2h5NEhCYTBBbEVJRUQxQm0w?=
 =?utf-8?B?TXFxY0c1VFhFYXRpMkxpdzhqbTJUZjgwVm1aWnNXdkxWWVErTDVTbnIyR2wy?=
 =?utf-8?B?UmU5THp1SnZSTjlTT0xzYTNSV1Z4c3duWHp2RVpyUnZ3UFY5N1lTY3BBcDVD?=
 =?utf-8?B?eGo4T3lPMGl6UnAzazdsckNwdDVjMzY0NDNERjdZVC9NYXRIb044OXZ5dTNj?=
 =?utf-8?B?bG4vWGFpTU45OXByVGx3MFZQS3lzY2FwTW1jYXdwSFNqY3c4YkI4QWJLMXhI?=
 =?utf-8?B?dXV0RU83TklvYjhLY3N0cG90WXQzdFRUb2tKMVIvZ2pXendIeWZhVitTWUxW?=
 =?utf-8?B?RHJLVFd0NHlhMHQzODBsWTZrVWxNVWFWTDJuMXNKV0E3SG5hUXFJeGNoTTdU?=
 =?utf-8?B?ZmZYblBVV2JkNWcxMy9pZC95azFaRWJiYWRZbllram1nMlN2dGgwbWM3VEpB?=
 =?utf-8?B?RkgwVWlsQTZONDBGMFF4TzlLRXk0ajRYYTBOQ2g3dUtYODZtZ0VpTGRXRXdu?=
 =?utf-8?B?VWpsOGJ3VFVibGNpOW9zRDVtZzRVdHl5TGFPWjJWNjYwdE83NzNFMm1oZUo2?=
 =?utf-8?B?NFJmUVB3aHdNMEFkcS9XdHFLaFRQK2dVeWQ5OEtoUkZDeDdHOUF2Q1lNeEpF?=
 =?utf-8?B?dytqY2NwZm13YldRbHF5MjNFUmRxaVl2V2cyTy8yTTBqTFJ6MzdCeEY2L1cr?=
 =?utf-8?B?NWxOY29kdWZaelVYT1JJNnJFME9UVm0vampjOGF5Y1FtRGx4cnFvVEU1MHI2?=
 =?utf-8?B?Uk1LUit1VnR0TFNma2RzQVIxMFoyTzBLRjEyeWUzaGxGVEx5eEhGMXJpeWVz?=
 =?utf-8?B?WVE2bmd1MzRZaTZ1cEtwWXZFU240dEYySkJPR1hYZlhXa0g0RGE4ODJYMit5?=
 =?utf-8?B?My80aVlOa1FNU3dtclNnaHBkdFZ2RTV1RUpuNHBNWUo4ZWVMWmhPb051dzlS?=
 =?utf-8?B?NGdFcGU3RW1qUGlrN0hPdGhSVTB2Z2lHdlZnaXRFN3k4MkJ1Syt5eUZheWJB?=
 =?utf-8?B?aWNsYkJHMnRPTVJpRDlyM1NYSHZVMFZma0FUTGxwdUF2UDFzQmVIWXAxdGFP?=
 =?utf-8?B?dkNLbkovZnRzeThYVWtKY2drSUVLOWVHdlhLR2l1OVVCTHpBYytHdThkdHRM?=
 =?utf-8?B?VjEwK24yOUhjOWpzVzZBdXlHbTJlMklMZ3F6dTRQUEszOVovWktYSTNWSlNF?=
 =?utf-8?B?enNZL0t1MzJuUTBJd3FLanUzUWVOdU1TRlJFWnNCZFN3UGZEOWMvbGxJUDBF?=
 =?utf-8?B?cm1Sb2dhUS9FMVVKbEdoNXZEdDBuUmlIRC9pZmxLWXhRUTJ1TkNpZE53N0Fl?=
 =?utf-8?B?REZ2S3gwbS8vTjBYVHNvN3BibXJaZlEwWFR5bmJETnYwb042dDRlVFhMc0R0?=
 =?utf-8?B?RGcrdXJnbkZHdnh0czdVNFV0RFoxVHhVRUZjOTBZTkw0SnJqd0MzcmdNSXpC?=
 =?utf-8?B?aktVS2pMS1JlbXhxNkIrNkhXazJzQXQ0aFhiM0ZlZ1FoZVJRTTU4SHIyTHhy?=
 =?utf-8?B?YXdtRTJjME01S1l3SnlFNktTdS9xRGJONlB4Q0NwajJhR0pTNXN0VVFEQVZs?=
 =?utf-8?B?cU1HT3lxZ2djZk8wZXVnRkFpeEpUWXEyeS8xbWxwZUxvbWtyNStEU2NqbCti?=
 =?utf-8?B?OUszbzVxYnhpbHBCclE1Q0VlS1ZJVkgxaTFscnV4Y2hRcHlBOXdOQ0xQQmFK?=
 =?utf-8?B?UU9ncExFUUh2WHNKN1hRMDRiNHZ4dDVQcGxhNkNXNE5mWmhra29YMDdOQ1F0?=
 =?utf-8?B?MElFQkNoMHhCSitmQ3ZJcGpLQTV2WHdTNE51MUZDTlNOeXlrQjBQclAxRFdV?=
 =?utf-8?B?azFnTHlvOC9LKytnUTRCZDh0b3MwVVZtdU5yMVl6bHA3NHJlc0pzM1lhK0dX?=
 =?utf-8?B?VVJYYWF2TEtQeHNLU21PdkZXdCtZSDFPZzFyQVBDZ1JsQWNCZGpVbzdqR2FC?=
 =?utf-8?Q?P5vxSd6lo5l/b2yBthIxBuugx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124d3d93-f1df-46f1-f829-08de20e7690f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:59:00.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJArNAPeLj9poMpxcRKJIMcaUZuI9pcOODj/L8wtQCQvyUW+OtC+Pjj29jB4MfwjtiJignh+IEkVKkA7SZQEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467



On 11/10/2025 7:58 PM, Matthew Wilcox wrote:
> On Mon, Nov 10, 2025 at 07:50:17PM +0530, Garg, Shivank wrote:
>> The issue is copying those binary to a freshly mounted filesystem.
>> The page cache folios remain dirty until background writeback completes.
>>
>> Reproduces 100% for me: fresh XFS/EXT4 mount -> copy binary -> execute -> MADV_COLLAPSE fails.
> 
> Yes, but this is an uncommon thing to do.  Really, it's the kind of
> thing you do when you're testing something (like, whether ext4 supports
> large folios, and whether that yields a performance improvement).
> It's more reasonable to change userspace than the kernel to solve this
> problem you're having.

Fair point.

You're right that this is primarily a testing scenario, though it may also
potentially affect JIT compilers writing executables (also uncommon) but more
research is needed.

For userspace workarounds, calling fsync() before MADV_COLLAPSE works.

Synchronous writeback in MADV_COLLAPSE seems reasonable given it's already
a blocking operation. Alternatively, dropping this patch and keeping only
patch 2 also works for me. As for user sanity, returning -EAGAIN instead
of -EINVAL and some documentation would be beneficial.

Happy to go with whichever approach you think is most appropriate.

Thanks,
Shivank
