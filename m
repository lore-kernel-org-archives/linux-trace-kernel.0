Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7B2417FB;
	Tue, 11 Nov 2025 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905352; cv=fail; b=WT/hqFQ5Z135Mzheqw7ITxDUQsfO5o/FUWVcpo3BqS7MXM7O9csDAAiO3HdyRaqyUMMksQ5XpV6IrdcoxQPMe5idtG0Z9u3f3hj9lSxKYtrR3uEbBEWVb0s8cyLKXWI3rRmcE5XwFF8W4bLE60QZ8g6Uh90JYAdCRbUYVBxzmZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905352; c=relaxed/simple;
	bh=eb+sKRViQgx9Bba/G+yNrLNb2JDtVl9+fWxzxSB/YTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DeXMv8dNon26F6J+FPXnGnPsjPfcmSkSBhYjT+4t0iMhD6iTDQkNfkrzCuYpLZGCfA0qLTHpPS1u8VaqJ7ihiqS01GP3fzPr0B/kGnrJ64bLNQatXhyEdExz/APr+juRBQhrTplVvjhDg0XW6CeqRuCfQ0NBJOFIHrEEuMmNMJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aG8pOoGd; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aG8pOoGd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEZ8C4YfTi94uWuGScgQk+esGq2oRCAxMvTPCe+fv+FUltYyMMKbAcyu1XaT76tPT1hkQLnXcfrjUdwwjjJRQMCFfHe3N23QXH1TsNmglwZhEcFNCuaRtNwbG+UI7V7+dt0rNKcm4fhZk3tyE+sOfIHNa/QFxNLkmuG1w/wp2+PKfMVmFRkrGSWfER870zwhEtD+F8jBYSX9ri2RQ7hjxv343OrPB5sS26NrdgwGKDdxN0Zj5/gvSeSsxLGfxARp2dzgiELF9pWWeAHnSV2c65XvLESADaJ6a2ORVbSjXXrNNtUMK8yRY604dhngS6TEXSw+d14lm/o1rs+ii7UM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Vy2x4bxI4SxkmvOuXZTw8wOf1cXcr4/3ScuE3J98NI=;
 b=yrBSBWkXlilwwH+XINlD/rEAhkrNHP9etHIgEJ8hpLVW/AZcjTxraH9APKG82vzY6lDbgZluoWt+QmJSzLsSXLvN/wx49h3Laist9sSYCKeZ3HjHbzzfu+r27LOn2CKpVi++jxZTD/mi/C63CIHg24FTFQdsaV0UAZMYMcfeauRP69EDUADRCJjYGlVcDssQmONAIZvberr5JYv009IbUvYW0ffYy/1wVsBMPCAqwvcb3NLIdSyBy83J7pz7JBBzBG3uSbm6bVO0TntfSIR0oFeqhRVlSY6WF73pg2UUr/MtLBVARytLzedAZkn8uH7eKB9S3HadvGR/HVlHU7aM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vy2x4bxI4SxkmvOuXZTw8wOf1cXcr4/3ScuE3J98NI=;
 b=aG8pOoGdhJYu0hkzGu0IJ48A6VnJ7RnYPk87WFYxDD6JX7vAI1eVkwMW13a7QGoIvAIN7N1tgyMIepK0gAjZSaGsBoi6i/nEz14ASbPeoOjOl+MB4FsKK29S2KJhR+wtYd0MZg1hQ44oVQ/KZL3tXAvDWouhT34Pyckw5kP52Q8t1QEG4kvZY9ODb16RO1snYh8jp/sODhu/OvcQTkzoL7YTcvUR2wsPd76CwNXuUyaMnFE6hKh60CNnLuisI6Hj7rJf+xfqz8mXdA9jSkk6dZgAQKwHhEv28IMXhzs9GdfuVICSkX0z7aoRfbNTdq9nzi5EJrPt78K2nmY5ii6TVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 23:55:42 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 23:55:42 +0000
Message-ID: <19887745-170c-4cf4-8028-63a091a5493c@nvidia.com>
Date: Wed, 12 Nov 2025 10:55:37 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate_device: Add tracepoints for debugging
To: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>
References: <20251016054619.3174997-1-balbirs@nvidia.com>
 <20251110161954.47d88433@gandalf.local.home>
 <20251111155042.b07ecb045c978fe4c457b1d0@linux-foundation.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20251111155042.b07ecb045c978fe4c457b1d0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c5f11f-d167-45d5-229b-08de217dd2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitVNmdyRldjVG42OWxVSkRmQlFwNzdwdTM1WUNKbnA4NzJpQk4wdUExcldD?=
 =?utf-8?B?TE5acnBrcWZ1bUFyN1RoZW5JdnNkdW1OQzFuN2tGN3o3Q0RmUllCZEJsVGlI?=
 =?utf-8?B?aEhrRFlyR0R6b1JIaU1SelFJaVoxVWVUQzhyaTFQWjRIcWVIdXlXazlPVmpk?=
 =?utf-8?B?R1Y3VFVXQzgyZWVIWFJqa2lHVXZHOVlucnRRQllNbTM4blRlZDlPQ0JPRHNN?=
 =?utf-8?B?SjNHcUpLK0Q1d3B3ekkyQ2p3RVo3NWRIRFRtcHBWRzBvbGsrTXIwd1VKcDhJ?=
 =?utf-8?B?VW9VTHo2QmthaExKQlowMHZjUFBlR2djaWhnMGx3MWkrOVh6a0M0a3lMdllj?=
 =?utf-8?B?WUlZUXBLbjZRSUt1Q3IxYzBaT1k2ZFk5a0VpL21hM0ZQOU8wd0JTc0VxR1gv?=
 =?utf-8?B?RXhlMWNvY3lZaG1NLy9CZ0tSK1A5dzBySmZPNU5seGRBbXhoZVRMdURmZlpY?=
 =?utf-8?B?YkpCSU5PdWNXR1NRcCtvd2JwcWZsREk0M1owT3RXYzNPQXVzekRlYXZ5MmdC?=
 =?utf-8?B?RFZOazlrVTd4RzViR2xubndLUW8vZ0o0VlRKVHNuaGs3RWFubFBVR3hkeHpL?=
 =?utf-8?B?S0V4VVpYTzBUM3BWT0dNM0hPZ1B3TEFPR3hPQ0QvZXcrdmhzR3huUGJXL012?=
 =?utf-8?B?bURsRHN1b2VncmNGWGZkZkt1cFhrSkE2cXZ6YjFKK2JZMEVRejAwdVNTSDRM?=
 =?utf-8?B?MllnRis0a0F2UnVtMlVQblZzTnVkTzRQdjRRdW9UWURJd2lDVDFBenFsNERO?=
 =?utf-8?B?NFIzaFhzcnNSYjVTOWc3VGJCVXVCSDQrZEY3WTltMzFxTWNTS3Nic3V6L2Ey?=
 =?utf-8?B?RStnOHg3VlU3ZE1DOXNiMVpwUVA3Ti9Da2xRT051Z2VJQU1yYmtRK2p4RHlu?=
 =?utf-8?B?dkxSMTVQVWRjQ3YxbEMwR1N6THl1TnZvMXRQTGhWOVcxSEU2NFZlaGpaOWRv?=
 =?utf-8?B?dlFVb0Fzdk1PVzFLUGJpY3E1eUZaZTlwVjRuUDV3dU54UmZIQUY1QkJoeXNx?=
 =?utf-8?B?bzFyRzYzK28wWGdPeFczRkNDR3FuRUV6SllsOE1IUjJyNGl1d0ZCZE5wMzYr?=
 =?utf-8?B?NnlYZWRxL0FSTHJOR3g3UnVubzJ3cko3QXpaTHVHWHUrb0JmaEZscFVVYVc0?=
 =?utf-8?B?dXRZMWI2UFBKejNjcmh3bGVxN09pclFvVzZaLzdHcGh3L2dHaW5DS09ncC9Z?=
 =?utf-8?B?U0gxcnlwV2FFOFJ5OHJpTjdOYVpBbVNQRnZOZ1Q1ZExiaUdGdVJJS1lBSm5S?=
 =?utf-8?B?dlg5cHAyU2gwbzRMZHhhUXV3SnpvZE5nU2hHa3NteWpoVmk5ZnU4endVLzFh?=
 =?utf-8?B?NGRHZVF1T0RKOTRNV044bVBDMUs0aDlMZW5tZGMweXJvN2huZVNNbk90SzZl?=
 =?utf-8?B?N3czc1JHcU96ZU9yRGl2bDd2SHBieHFxaW02VzFwN0ZVTmthL2VJYUIyTkNU?=
 =?utf-8?B?NmJvSVVROTVBaVlEb3I5NWV2bkFTOE82QUFQMU5aOWZaWE5FcjNVdU1wanhF?=
 =?utf-8?B?QjUwYlRtRFI1eXBuZDBKakpIVUw3RjBjdis3VmRQU3BrS1BzTmFvTVpQNjdn?=
 =?utf-8?B?N0xDSmFrV28zeWtBbXUvZHBYRzMxSUU4LzljNHdIU2Yrc1B2TUhjMVhiVk10?=
 =?utf-8?B?bm9JZ29TY3ZvSW04RDhJazVhMEZqZkJjM21CMTI3WEgzTVJvNTRWUVVOSVYv?=
 =?utf-8?B?bHIyQ0NIU1VsQzViQkhpZWhDVWNJTDRTL1EvVW5OWk4rUm1sZDY1UkdBRnF3?=
 =?utf-8?B?aUFNK0l3RUI4QjZRVFFKcEI3bUdmL2FzM2JCdWhmeXcvZjE5Q1lxSlRPQkxV?=
 =?utf-8?B?Mi9yWXVJY3IvQXBORktnYmVua3l1MVRZZmgzUjNRTnB3S3Z6MU5CL3l3ZmFs?=
 =?utf-8?B?OTdCMU5nYjQyUk1melBON0pDU1BuWll4Vk5MU3M2UHJqZjlZYXM3REdVbWQx?=
 =?utf-8?Q?YuPhCeFOC6uKN5CS6lBv+krfOEv3IAZu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk1YdW9iQzhyVldlZlNXSjJFTGZRUkxmNDlhV1krV3RDVHI3MUptOStiYS9n?=
 =?utf-8?B?M1BsM3h6dVVvREVkRDBmQWVSYjF4a2FYbkY0cU1BMlJtYWxHUVl4Ni90ZHJr?=
 =?utf-8?B?RXNidjM0UlZGbzdweGJ3WXZUVEdvZzhLdWphZXJxam9LMUdLN2FkYUErOWhX?=
 =?utf-8?B?UEgxTzVLVVZBY3UzeGdBSkY3U0JhTTFhMUxiZ25ZWGExVlhWZTYvNDh6QURz?=
 =?utf-8?B?aTZFUE84Z2RFdkJNUWJ4YWUybENidXpqUVhuUzZRUEUzY2ExMWZjYUJNbUpy?=
 =?utf-8?B?QTl6SDgxM3pkdmRMekZPTkZETWk3OVdpeFQ3YUE5STFMU29MQ2FHOWtIc2RV?=
 =?utf-8?B?VnhaNktrQ1JCOUlsTWREemIzMlZsQmxmUVZuYlUzcTdhYys2UTlMdHhIaWh6?=
 =?utf-8?B?d0xUQzJaRlMrVjJva2hWK2YvSWNWcHhDa292dDl5Sm1NTjdoVjloTWR5Y29D?=
 =?utf-8?B?ei9HVndtRjVhKzRaV3liclJkM3N4Qlo0NkgzRmdEREd5TzhhRTM3UEhybGVU?=
 =?utf-8?B?YmxRbmhRU1QvVFM0T1kxWlA5UmJYUld5ZzBMNk5hS2EvcWE5OG4zOWdmaUth?=
 =?utf-8?B?MWRYdklOOTNFVklzNjJIS2laNGVxY3F2REVoUjBOL25vSmE1cE1qVExwTVBr?=
 =?utf-8?B?WDlDRDNNZHdhVklrYkw0ZXVnNTdlVXJxbEFJaXI5endSNVNydUJQN2xwUThO?=
 =?utf-8?B?bkQrR29zRTNJSUcySzFlcXlpaDg3S09BbnFnQTc4a0lrZXg5ZHprV1J6Y1hO?=
 =?utf-8?B?ZDVzTnphaUFwRlB6QkxtN1I3TzY2YXQvZVpYZ2VVUXhMc2RNQXdoMk1YMkx3?=
 =?utf-8?B?RFdNazIzL2FEL2I1am45cnFHRnlVZEdFWmh3cGhEWnRHN1JRcGdOTGl6M2dw?=
 =?utf-8?B?WVNuR0hCV3duVnp0LzBBL1Byc0xRWW1tVEhRSGZiamRTS0lsYzFDR1N6YjhG?=
 =?utf-8?B?eGJFMm1VVnNBc3NFS1FkaGZPeFRHQkx0VkJHVlpJQUlQdDJIaGFtcld4S2FB?=
 =?utf-8?B?NDRsYkJvTi8rWlJBZS9sdis1eUplMm90Q3hRMGUxMWRUNHZrMzNUSUVwZGNz?=
 =?utf-8?B?SkpLK2NtQmlUU0liZG9vMDRFYldIbng5M2l3Q0paV1lDcFBTYmNXdDR4MTN5?=
 =?utf-8?B?Zlh4N2ZXcWkrMW1HRzYwYU0wMnlFK01zV3o3NWdabjkzNjhaRWcrUjlJV0VW?=
 =?utf-8?B?aGNObS9tVG5IbGJWcWJGWFo3ZHNlL3VEL0ttN00yNlZMNDBOMGRsWHhJWUF0?=
 =?utf-8?B?aEZUNm5nYWhDazdEMlpSN2trdjh2MzFGWVdSeXlPWi9FS3RkMHUyUWhMb1J5?=
 =?utf-8?B?dFNnSGJpYmlHKzZLSE5qcHA1K05qQ3VrZTNxVzVKSTdqa2FYUFhoQjV4RFJr?=
 =?utf-8?B?dDdSaWVjaHVtTkRPUTQ0WVdPT3lOQ294MGcxSTRWSE04WCtCdXFiU1AwSE4r?=
 =?utf-8?B?cUhYckFFdHR6UjNWdzI5N1dCdUEraWlmN201NFhoSGw2THpuZ1czQlRYSGhT?=
 =?utf-8?B?dVdGZ2p0RWRZZ0FKWjN1RFlsSkhPNDJhSEtWZnlKMlFqdzZBVjN0WDBpMWxk?=
 =?utf-8?B?M3NLbXAwak1nMFpBbnp2dWR3akMxVEZBVGwvTTRhUloycC81ZTk4c0VFdjht?=
 =?utf-8?B?K2VvSHRNN216ZDhFZk1KWmlLWEYrYnorUHFibjN5VjZrYlNkSG5NbjljbGo1?=
 =?utf-8?B?V2tKemxnWlNpUHV4WDQybHdJanFPbzNtSEtJcEcwajFZN0ZnQ1R1U21uYXVZ?=
 =?utf-8?B?Ynkxa3IwYVlTczBSSkhaZTNiZ1pubWRvZVBwcERuSDB0SXJOTWN4VUNWdzVw?=
 =?utf-8?B?aXRPd1ZWdVhmZ1p1VTRkUXRtU2toSkxpdVkxcXF2S0x3U3hZcjM0KzcvSjhy?=
 =?utf-8?B?QSt5dUg5ZjVaQ3I2WVZMajgwK1AzaUgyVHBIaExOZ296VkRiNFhuSkhnek13?=
 =?utf-8?B?L0xQeVU0M29vSXhqOTRLVjhIK1M0NkcvRVZsMkJXZThzTlg2NHhFYnR3OS8x?=
 =?utf-8?B?NmRKSFRqYzNsWE9GcThoMWtrR09IZlNVdHpRR1dmTTR2NGN0UFd0dXdzWE1r?=
 =?utf-8?B?aGJ3bmtoOVhORE5TWFhueUo2aVB3Wjc1Z0JxVjc3YWRLRmV3SVgwaVJ6RXBU?=
 =?utf-8?B?S3VYYkZxL1g1VjgrUXBTYnlRcFliWTdTN0k3T1FHaEhyb2tSblJDbW5WYmx3?=
 =?utf-8?Q?8YkpxbHK5JjYzvxyCgy1f8TmijI8JmZ++GK5nfj2IDLi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c5f11f-d167-45d5-229b-08de217dd2e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 23:55:42.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2RYI12JHb+n3YvSA29wk5Smowk6548QaEIZEyhPnRBMy3/55+hE/Sk0vNQ+SvgwtOn3fMZvpTSRZHCcasE32g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840

On 11/12/25 10:50, Andrew Morton wrote:
> On Mon, 10 Nov 2025 16:19:54 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Thu, 16 Oct 2025 16:46:19 +1100
>> Balbir Singh <balbirs@nvidia.com> wrote:
>>
>>> Add tracepoints for debugging device migration flow in migrate_device.c.
>>> This is helpful in debugging how long migration took (time can be
>>> tracked backwards from migrate_device_finalize to migrate_vma_setup).
>>>
>>> A combination of these events along with existing thp:*, exceptions:*
>>> and migrate:* is very useful for debugging issues related to
>>> migration.
>>>
>>
>> ...
>>
>>>        hmm-tests-855   [002]    50.042800: set_migration_pmd:    addr=7f2908a00000, pmd=dfffffffd39ffe00
>>>        hmm-tests-855   [002]    50.062345: remove_migration_pmd: addr=7f2908a00000, pmd=efffffe00403fe00
>>
>> Each TRACE_EVENT() is equivalent to:
>>
>> DECLARE_EVENT_CLASS(event, ...)
>> DEFINE_EVENT(event, event, ...)
>>
>> Where a class is around 4-5K in size, and the DEFINE_EVENT is between
>> 500 and 1k in size.
>>
>> By using a single DECLARE_EVENT_CLASS() for multiple events, you can save
>> several thousands of bytes of memory.
> 
> Thanks for the detailed review.  I'll drop this version of the patch.

Thanks Steve and Andrew!

I've been looking at EVENT_CLASSES and looking for the savings you mentioned. I've not yet
finished my patch, I will resend it as soon as I have a new version

Balbir
