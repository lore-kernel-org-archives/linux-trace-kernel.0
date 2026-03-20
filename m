Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021117.outbound.protection.outlook.com [40.107.192.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA53AF679;
	Fri, 20 Mar 2026 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010157; cv=fail; b=jQNOG6egkHifIreWLD+Zpb3tynXD+IRus2Mv20SOYd9rLy9wleOE/j5BP9D5R4Y3j985wO477JfMw7WmQunFTOt7Sz5cUYR8XtW5npIHsKbYngpf9HTTQ3YB9uU8IxS+mled5FlIjrFRnN4EX7PSTZzfqfVcGvpJfNYgoINujKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010157; c=relaxed/simple;
	bh=07ONOtTVbPkseXRZKdM1TZ8kw756fylR0KVJv0JXHXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jsyvmctcr2QpSxQJxTL3xq9Txoe+LhCg+oFX6f2nOKS9GsMwlw7jkaFnKnt7/0ZQvMpmujANyXiZ1WtzZAPSFmy1XSjk/UQWN61kkEUQdXX4yyetlxestxNY1Tb86KcC+kFVGFfygFl1pN1Wa7wH3abAHuPaE+fUoKVq9QCnqHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Da61isnk; arc=fail smtp.client-ip=40.107.192.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Da61isnk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJqnJJU92x/RkbJf4xGTrpUc2MEXNCpgKJQLoJENRRnlCXHfB7jwW4jV+yzM+rTFbeWci28o24yDkiBT1TVFVuE3sglHN6U9C6scdGTCoH+8TYbbldJ/9swt8kqncwNSimJOlxR0PiG6pEmZiN/CUbULfnMVYwh7Ltw7LV/lfnT5lIGHeRjpsXxZ6gVOYQ8sIWVAS1Kj/gV+Rpa6YXjJBgNwbF12VDY3DKJs57dpj+iliPKGrF96Febvx5jiM42EiQ/dSwpRUAwyO/yRXtCiqW/qDTl2wW7Z0K8QFPgDQ8fMEXjr0OyBLkBQ6oVJX9ccQ1Rd+ucW27XLKJmijYzjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX0yLDxOYEVmY0VjJRbU3dRuM/SuwQpOsOsDQY7c2Fc=;
 b=fvDPzfKS3HIpmdcZ7Jrde8zHDHTTtL9eZVoEZUrdeXZDu2sKZVEVuP8QuveUa8A423GdeJtazYP4BCM8ySrT1/DVCPDsbhu9EXZ8WGh4H6pUdOrcoAIrZDi45KpEOfw2qYrN9D1lsynKme6xB6OdEiKbqvaxqIolJrAkGYr1pQpnKCmYQHPxm4rOmgUni/Exnb2y/h7PGOVhXxP42t+ugDJGq/tkzJJT7K0JemyJYEWY/jCmmVBYwHBWqWadaC92VHlLJ8SOBpi1ct1iwDE0HNnD2uS5nhdgano3itUBeZpKTqW70aafPVH02RKgcgCeMipEMYtwlFrKrz+tv9K7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX0yLDxOYEVmY0VjJRbU3dRuM/SuwQpOsOsDQY7c2Fc=;
 b=Da61isnkpY3e7yoC1rvTDBiGwbRLFaitFEp2JlYEICArx3S0VnKplynMZ6epPiJca7SI+wX3WHCbHkIapDdymO/T88Dqs7PwSY02FhPraVW57+0SOE3n8KICH1sHyKhzHcRnGchaIF1q0ZI/sDnqoghBErRR0aFkhIMLBWP9JT1OewMSD4Oa36qZ+buEVTpTADoe1gl7jUJMo05ZR7wEflg06E8MsOurrd/hzj2Zn1s75MT9r1vyJbc6jIz485wLEpABv4fZsjnhPujSrllLnlv7lcnaNTs9xjkwbYHRn5R2gjB6MTf9FIledf4c/9JRbMBj0Pf0sysM7ZJK4k3cFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT6PR01MB10892.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:11d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 12:35:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 12:35:47 +0000
Message-ID: <7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>
Date: Fri, 20 Mar 2026 08:35:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in
 QEMU on -next
To: Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Michal Clapinski <mclapinski@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319233745.GA769346@ax162> <abzKcGiRSR_E8lLN@hyeyoo>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <abzKcGiRSR_E8lLN@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT6PR01MB10892:EE_
X-MS-Office365-Filtering-Correlation-Id: 19126c4a-e384-4b8d-74a3-08de867d3656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LXlW/BV5vQ+TTUhHwFfFMCaptNTZAERmTolgtWfVCFFQEpGMnlSN8skoV9S57iQYiUnv/wkc3YpQLO08k5wlNJbds3BqzpuQpkKhl1wbl/7VQ1p4mfgaJfqyhpO4wjnE3Lj1gND3lmFnKBsgZX+lwpBUR+IaUr8UjtP+O70t1xq86As+o2m9Q5EGxyTuVKZaZyEzShomKL36Nd78nFJ+5SGqYLmMEn+BjNNn9yFoImjnzkxV5oREgHz+b7tkrYQpIs+fPFJMn+lAyKtfp3CMUQu8cyDS+47x6F5F22zVBC4skD1kJHijS1wjRLQcq/VZM6gYZJkJ0GBVQA6MMu8PeDE5jvYEoE//ClKLGcFWTQ29FNoO7GW6ieUBsOcf8Rxze25s1bPzOpICaAWJKoWy697PN+WdI0HCcJ0qB07LPoayhfTUg8o8LN+iHnjP493P/bQgwBfD7U039aZDe59nyvmUlzE/iVtu2e5GyOxZ92uavKS7P9v419jsQJYbX9xll+EdhnZg2g5UqNa0UztPUoAzj2u41PXUXygkfOsVb30hiJzvUyRW17Az34gU4MNj6JVpxPbcZ4Uwi2kbqPnNc7lmhlxoqGAnNgfBmJXSltH7f1B/rn2fgH9MX49JHymt+UadrWWkLmEXZPKv7n3vbWjMpy5KR4Te8x9E8omE0HA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5QL29ReEtpbzFaN1JySG1oMkJzU1ZVUlZHWDNiektCL01QaTB5eUpVTU1S?=
 =?utf-8?B?bXR3WjlIVCtlZlpUVFYwdFhNTjhYQ04vSnFBR3V1Uk44OGI4eFBLTHNsM3NJ?=
 =?utf-8?B?cTFBbkhJVEhTaDQxbmNXZWM5UUo5dTVNS1JLZkNLZlJoYmlzUTVVMDNqZWVq?=
 =?utf-8?B?YmhlT1NiNnNidG5IeERqR2NEZitNSnZCK1pQYVVIU0xTMnpQQ3NvSDZQbGZN?=
 =?utf-8?B?V0syZWVYdEFYSkFxTVFQTGRXSnprZ0RhUDBZVjE5TGo0S3AzWUJvcEpzNWVj?=
 =?utf-8?B?UVV3QUd2dG9aZDQrd21JSHdPNytlL2dlOXZXa296Myt2MDA4U2I4RXBCa1VT?=
 =?utf-8?B?aGVOZDh5cGRFajkzVlRBWUdBMUpXMk1vMG9BKzB3ZW5ndEVrWEoxU1FMK3Nx?=
 =?utf-8?B?UmZ4RldLWVBoQzZCQ2hrdjhnQ3RQTUZ2Tkpuc0txaGZUc0hBT3lkaGFvRGVz?=
 =?utf-8?B?TkxwUGZPaVhRTEd1MHU4T1NLeUZGM2xqaU5oUS9mbDlrZ3Z2QW84c1NqYXVP?=
 =?utf-8?B?MW9JZTdFUWoxdGM0Q2UzcVY4dFlCQVRJaGtCN3p5ZDN1TWpvVnFOMEVUYjFP?=
 =?utf-8?B?RVk1WGtWV0dtNEtPTmNCVXhQRDJyRXhVQmJ5QktlUWNSTVNuK2VPeVpwbEw3?=
 =?utf-8?B?THZYb0psekZDSm5NSHRGRlRmUlIyaUdSdmxEOWN3RWlWa0ZyUHU1c2J6b25T?=
 =?utf-8?B?WFhJakpxZDUxOWFQYUFYQkN1Z3YrNHQ2ZVZjN0FYZDN0NXM4UjZXTzBrRDF6?=
 =?utf-8?B?U3ZWWTRERTA3MFpITWY5ZlIxVjBqbnYrUm9IN2NkV0RDZXdEdURRVUxPbm4y?=
 =?utf-8?B?QVQwRFBqVStHWVN5dnllR2FWYzIvQUNCanJ2amZQOGlCeDNpR0NmRFFpTWJU?=
 =?utf-8?B?VCtQZElnRzdhZURCbWh6bWJkbVFselU5WkdlazNvalJNamhhSksrNWxSU3RZ?=
 =?utf-8?B?YmZtNFFYZDJRK1ZkMi9Icy9DQk4zVmNTUDhFZ0FERHFSSGhIMU5IRFdLMkFB?=
 =?utf-8?B?UkY3TFNrZ2FlaEhWcnBEZmZLVWI5YlIyMzE2ZVFJTGRCbDd2ZmJ6Zkxlb0xI?=
 =?utf-8?B?ZDQ3bERIcE9hMWhyY05TWlFsbUFiVzNleHBKN2xtS2tiZHcwQTluQWRZa21Z?=
 =?utf-8?B?emdlaDRXNVA1aHRKb1B2OTlDNDY4Zlp3ZU1scE5OaE96N29LMU5xdllvWnJt?=
 =?utf-8?B?U3B4bFNEUnJBYm9ZS1VRVm0xNWdkeTV3ejFrYm5pQ0N2cmd2aE1xakRJTnl5?=
 =?utf-8?B?SjU2Ui9uWHlvWE5OdmJ4aWx5VU54bUVzdDBzWUl3TTE1d1QxRnBhUmtKOStq?=
 =?utf-8?B?RHJicEFqeGM3c3N2aFRGNG8valZNUVRKbEJKSklUOWt1cVQ1U3V3Szl0YXM0?=
 =?utf-8?B?VnRJUHczL3pKcjVxR2FETE96VStRbkx4UjVvK2lrVEprVXdpeGlNYWpZRXFl?=
 =?utf-8?B?Uml4dEZ6d1hFRDRYb29xRjY0Vit5ZTVJMllHejFHZDRaV1NLUFJnbDJScFBV?=
 =?utf-8?B?Ync4Y3hCQzhvbmFpUXkyUjY0SnFNdHJLeHlpK0J3bWl0YjBkczFuZlgwdGZy?=
 =?utf-8?B?THhuejRCUjI1RVZvQzkzUlJmY0lhRmFuZEtGRnU2ZjEvQ29ETmdad01oV1h2?=
 =?utf-8?B?dEJYd3ZKMEVFVmtOdXdwMUxTL0ZWZ2pUVHdaRDJnRWpDWWozRWZiczFlSU5H?=
 =?utf-8?B?bTZxSVp0N3UzSVZYRGRXeTBCQkJtb1MrWHJYbjVUL25KNXlWQ2hWeTg1dEFn?=
 =?utf-8?B?ZzJSVTdNU2RmbXRGYWs5ckdyRnJRNjZsR0NLK29pRVhQV0ltWGRxYkJzcUlq?=
 =?utf-8?B?cHp6OFdneS9tbFBzNzNsNG5HbENrRWdaZHNVUFdINTg5dDBmck1qbXhqT1RB?=
 =?utf-8?B?UmhKZ2VIc2lGbnMyZjlWYi9teTg5b1RWYWlleHg0ZkRlQVJLTTMvRkYyV1hu?=
 =?utf-8?B?ZGdBNXB5Mm5ESCt3NW1TUUYyVC9Ib2trM1AvREh2MGpyRDc5UTRnZG9QK012?=
 =?utf-8?B?ckFoaEszNWk2b0RkYy9aaktPSklCeUpBZWZrZlEwU09icFo4QzVYSFBUZkRi?=
 =?utf-8?B?ckphTDk1UTNhQzlTbEJ4dTB4aktkVGpKaVovdUhYV1BiWkpEaHJvL1MyWm9q?=
 =?utf-8?B?anhjU1hwa29lYlB0TWlOeEQ2c1pORUN4eFAyb3V0MjZIR1VCRnZjLytsWVpx?=
 =?utf-8?B?dzFNSHgvRXZXMytOeURWaTMrVGNlcFBFZnc3aVpJSGEvUnFiTTlCeWdtNGc2?=
 =?utf-8?B?U00xcnJ4enlGTDBVZkdDQUpwWkRIb05TcjNuNzZmMnZMZTAxaS81WXBCRGxY?=
 =?utf-8?B?VlNIWWRqM0x3SEpackdPUFFySU9EL3RDeVMzQXU4ei93ejdpTHpSY3FlN3FT?=
 =?utf-8?Q?1fpChIbTHNjtZkDUnt2dzE9klMh7bkbB9qYza?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19126c4a-e384-4b8d-74a3-08de867d3656
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:35:47.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dwhl5DD7XouRzRqYGx1aRLnquliwim7gVz3VrHyWyx3xl1apyN2dhe4cURjK1uIDIo1GKuwJKdI727XyoYqaoBADor3h7lHyBCXOCIydnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB10892

On 2026-03-20 00:17, Harry Yoo wrote:
[...]
>> [1]: https://lore.kernel.org/20260227153730.1556542-4-mathieu.desnoyers@efficios.com/
> 
> @Mathieu: In patch 1/3 description,
>> Changes since v7:
>> - Explicitly initialize the subsystem from start_kernel() right
>>    after mm_core_init() so it is up and running before the creation of
>>    the first mm at boot.
> 
> But how does this work when someone calls mm_cpumask() on init_mm early?
> Looks like it will behave incorrectly because get_rss_stat_items_size()
> returns zero?

It doesn't work as expected at all. I missed that all users of mm_cpumask()
end up relying on get_rss_stat_items_size(), which now calls
percpu_counter_tree_items_size(), which depends on initialization from
percpu_counter_tree_subsystem_init().

If you add a call to percpu_counter_tree_subsystem_init in
arch/powerpc/kernel/setup_arch() just before:

         VM_WARN_ON(cpumask_test_cpu(smp_processor_id(), mm_cpumask(&init_mm)));
         cpumask_set_cpu(smp_processor_id(), mm_cpumask(&init_mm));

Does the warning go away ?

Alternatively, would could use a lazy initialization invoking
percpu_counter_tree_subsystem_init from percpu_counter_tree_items_size
when the initialization is not already done.

Any preference ?

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
