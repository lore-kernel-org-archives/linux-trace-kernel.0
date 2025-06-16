Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F53972607;
	Mon, 16 Jun 2025 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750045955; cv=fail; b=kMZYkuqbeGhAtSNTeNbcaPOOO4Zhn8ZGXttcMe4NKIT0eWXEJJBN4gIZaPMbNtga6kSar3aALtrFl2tOZEmC3OW6Fk4uAtGuBkUi9CF/Lx0dYR0gXLb5I+4rOiQ+TBJ0lCYVH2Z8yqyCAQNcU4S/Y8kqERlzrNPbQ7jQNjYE0oY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750045955; c=relaxed/simple;
	bh=55MhLEJyimAXOw450Cw/Y64gPFBxoWwi0BYsApSDgqo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrzZRulESmqOqSN1ssPmIPH2QIP2+83LUiz4BhvIWOdeFpdpfAo9w3gvOs8JzZP3wgEVWizkBfU3x6rZwt3+ab+1SOsBCe+2ziOfXc56QhDqX2n91TaxwF2elSkFn3uYdnrgVaTOEHj0pK2eyQ9OTyPhnY0f6qsQDaYCR8Ah10U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OlMZhf05; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OlMZhf05; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OlMZhf05";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OlMZhf05"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=otWCAAQLiIWhmgYGN4hBNG+G5jwuoL6AOqGTWBPa7hLaISBXgJymc8QlwvcxV/oBo2RHhRUVyv0r2CUv/bpaoWoWhYBkJ4sRhkfP6T+T+O25Z0cDbPXG8vK5MXVNEmpVgI6z7KQb5moTKH2l+sUXQlux9m3st8doFauqeQaIHsab+RSt9fgIizVeMrLSnzS6dtoJvFQ0SJehb0X11ZMdTQuSM8Ooj22aFG7h4df2jyz2/pnoHKdNYOZLjRb9WvmJJLVB1vMAKsY6VdC7NcaxpMVAzdMkNfHKTXtlVEl1ISDbPwXKPqFVY1i/zCkH/bsrY1fPKgzE+sPU42WplgjNkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55MhLEJyimAXOw450Cw/Y64gPFBxoWwi0BYsApSDgqo=;
 b=tcN6p4BA7uJTIym/qxHvMElXPzvE8neqEzU+TvcYACF90acqBGcuxgHR8BuPLFnz7ghc/FcbVrh/10al972AG/GGbjvwvHm71H6SlWVeZ1LCcZDnnbIIRTXZyVkh7ffO8wuncu9D+kxXirt6CINuJar/pZPZ/8vplQQ3rBk4Z9dQ/1b72NBaSa4QbnbCDEX/0SYDZ0CSM39ECAhG+sxxqp3GQOFujgm+/+m3HESTe9Z2mTM1CZafWHjFbO54Ppse80pnL5wbpB2KOwfJEdoMVXZl75TbJyE0NGPVihNq581I94w0xrIbrksKK7hmtvXY7CFsY0GePISHPVGLAXtHUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55MhLEJyimAXOw450Cw/Y64gPFBxoWwi0BYsApSDgqo=;
 b=OlMZhf05Bp+E6TnueS5wHnEQjtb17h7kMTzMZDUkBmMNr6019AdO4N6/gVVeXcg+oMV/RkzIAH3UyB49aCiGBQgD5WV304AoBqWFipnIm9azbZF5eSfY8gbFYVUx270f97yAHcF/St0Vba1SGdjHcJSGxb6FwT+kt06V6/yn6Zg=
Received: from AS4P192CA0004.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::12)
 by DU4PR08MB10933.eurprd08.prod.outlook.com (2603:10a6:10:575::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 03:52:29 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::68) by AS4P192CA0004.outlook.office365.com
 (2603:10a6:20b:5da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 03:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Mon, 16 Jun 2025 03:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lln2OnuoYAzaoS2jlxPA17w73rsUWwPU3GmfVpzhooRKPtTelzHlNltseJzFCLazAe/sagwuOdXCgQ7kAELD87Bo45SBlFq+0rQH0E8pWo99ZA+ltFr/VVzjKM3k2HUfmlZRqhr9hpkjBHR9L/Kgk4xvNCx8scG8r+V7CsNo2qnzmBjBAYWeVh4UkkO5uv2OAlJUWoEgYJ3bzqDT66wzTZVyVlORfSBXPQv0Vl8CsNjmNqhCpwHZwWES/C6M+NhKMQbCqY7Vk7UKlxb/QSITc6Ni2jMPnAK9K3z1Tatms4BI+hH1dTuGJb5z0W55M1Rs+reHprsANGLX69XifHlpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55MhLEJyimAXOw450Cw/Y64gPFBxoWwi0BYsApSDgqo=;
 b=ozQaJsrAl5x0UHpDf8bWFQYxXE3DnDSRX0md17rDevkvAhdJzhQ2tKDWXj17eubVRxDLqZFItNNf9wolWP/HkUVhKWELdQ/quMAstlLKqdyZBKtxRiMtQgaoTMmnchukp2OtU/pMA3wjaUOjqBZbzf/uTypWZ41Cwcl7m/ETm9PnDlNyf8AN7NX52R7D95FcaCaH7yDgs4ZGqd6OtBdqxXt9xW9dQ5Rn9mMDzzryibzBQK1A5ql8lr5vqSG2p8zSDT4N2xmWd0DzuH3mD5chNBWcm8H+mfIDb6vKbkBPsDK+Yp1qgK/Z+3K6F5fmux8bUVgDyzdhwgeZleA55YgeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55MhLEJyimAXOw450Cw/Y64gPFBxoWwi0BYsApSDgqo=;
 b=OlMZhf05Bp+E6TnueS5wHnEQjtb17h7kMTzMZDUkBmMNr6019AdO4N6/gVVeXcg+oMV/RkzIAH3UyB49aCiGBQgD5WV304AoBqWFipnIm9azbZF5eSfY8gbFYVUx270f97yAHcF/St0Vba1SGdjHcJSGxb6FwT+kt06V6/yn6Zg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DBBPR08MB5882.eurprd08.prod.outlook.com (2603:10a6:10:200::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 03:51:56 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 03:51:55 +0000
Message-ID: <8621cd4f-a206-4440-9b02-52e9277ce212@arm.com>
Date: Mon, 16 Jun 2025 09:21:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] khugepaged: mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250515032226.128900-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0097.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::38) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DBBPR08MB5882:EE_|AM3PEPF0000A78E:EE_|DU4PR08MB10933:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0dc32b-7bd6-49a5-21a4-08ddac893680
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dk1waDRxRlhIem5MRUJPc3BJNlVUcXEvWS9NUVZKM3Njc0Rpck1rSGIyV2pO?=
 =?utf-8?B?R3BYOGg4bXNncGQ1MzdobGNud0pwZVhSZ1VUTEltNzhYdDZGZmR2YTlHTEl6?=
 =?utf-8?B?RlEweXI4Zko3bjZLZGR1VWp3R0lwN1BDVi9EdUdYMUl2Q3NTT3RJTE1CNWN3?=
 =?utf-8?B?V1QrcVhoVHBybFZBUENTZWVOa2FBRVpnV2hRaU92V2YyRGFkL0dVTDlBUDZJ?=
 =?utf-8?B?MUcvKytCV2Q5YUR4S2t0Nno3SEFUQUUzelhzQTdGUTA2d25VK2hNK0I0cFhX?=
 =?utf-8?B?M2FuWGJ1SytpNzUzSmp2QllndXArNDNmOU8ycERyazVFVkNMSXMyYTVJRnlv?=
 =?utf-8?B?cHlpSTg0RXVXOHhmaGhtT0ZyUjJLbjZGN0ZiM1Q1MEhiYXRGdFkzWWZ3bGZF?=
 =?utf-8?B?SXh0N0VTeUZzWXV0QXpwbDFsNnNQTTg0UG00Z0NPSGhUVyttQmxITFRTbnNW?=
 =?utf-8?B?M3ZTTm9hbUpvRnkrS2hMdVRCUjZTc2ZycDg4U0Yrc1hmc1dhUXI0QXBlWnJy?=
 =?utf-8?B?QW1RS0lEallUUlJaQ3dZMmtCUVRRVGk2VDgzcHFPcy9IZEVId3pKdHBMUUJ6?=
 =?utf-8?B?VWdDUjE5VUVaZWIwYUFNbE1aellrL1JhNkpFdjhmZEw5OUw5a1JxL0Y5NHJK?=
 =?utf-8?B?KzBQaXA3SmFpZThjRDlKeFFJK2NWdEFXS3V3bC9LMldtVzM4R0VqQ081eEVm?=
 =?utf-8?B?cXVoM1R3WEtRZzF0eXk1a1lWeEVBTnJjdWsxZlBkZXlDek1qVXJSRlZUcnJV?=
 =?utf-8?B?ZXIvb2VSelZGSFJxbFBrVTAzZDVvQmtTdXRTZm1Cc1BoKy9RU3YxV1oxQjdV?=
 =?utf-8?B?L3grQWtEWTFlN2JGUll0dE1lMVFHRFBVM1hXWVEzWDhxdFRwejhqcmxUQVFN?=
 =?utf-8?B?QVBXOERhZUZyTjlnSEhSWXUzd1JFTDJkdEV3ZGZOZ1d1WkJPT015cGRQV0h0?=
 =?utf-8?B?R3JHZmJSUDNuOG5lc0ZIRHY4b0xpSmdwOWY4R2VNa1psaEtNMWZITnlid3BR?=
 =?utf-8?B?T0lOa1B5MnVOSlhxVC9zVlU0STFyVktNSWhJU1AyWXdlQmpOMWZCT2VGME5u?=
 =?utf-8?B?elRjcHgxZ1U5S1ZSdFQ5ZnE1VTNhWGN2a2F5R0xCVUpqUjUydXpxblBLR01P?=
 =?utf-8?B?THBjakUwUTQrQzM5UEN6UG5pbHU1QjVEcHBaUTAzYjJHdHZXWnJDMlhjZmd4?=
 =?utf-8?B?S0tsVVkrUnR4TWdTMlZCcHlhWnlTWGZXYVZocnVWb3gvNXFSQ25zbWFmUFJL?=
 =?utf-8?B?UFpnNWIwVXBWTEVzOTNPbXYxSkVXQzd0U0p4UGtUaGJCblJvSDdTR2xsR3ls?=
 =?utf-8?B?a1J3bzBGSThtdys3VzlYQnROeWlEZ3hzQmVOdW1lbjZRdmpUTFBjVlQraDcv?=
 =?utf-8?B?QXFCMkJoNXVNUWFXYnBNelhqVzdXakdDUllmQktrTzluLzlFYnl3cFp1OHVl?=
 =?utf-8?B?aFBpek1uZHNWWUkvdVpMUGRuQ2tiMFdRam1xditXNTZURnpHWDNOdDVhNkwz?=
 =?utf-8?B?MXhCelE3MWVEeWRoVVB1YkJmM29tNWppZUxSS1pIWWJCMlh6cFl5NGYvTHVj?=
 =?utf-8?B?d0hoNXBwbkJnU3R3akZkRGd1Y0MrUUI3bGRNeWpwd2dXeVhJczZteEQvSDZq?=
 =?utf-8?B?OGxKRU9RcFI2dUp4bkxxNmp5SEpqdTJVc1ZReTNQK3VMNEp4Uklsb3ptYUMw?=
 =?utf-8?B?MzdpTzY4aWtpeXFmQzJYc29MNExRUGduM0FvY2VaN0N2dWk5VDJOVzIvYnhC?=
 =?utf-8?B?KzlKbDBhTU84Z0k5RW1jRk5sbldvenVsOUxNTDVnb1dVZ3RmWThMZVdVakQ3?=
 =?utf-8?B?aWU2SGpJeFMyQVlMbTRpNkowdVhScHRSTWk0V294QmFzd1dkbXdKV2NkT3pi?=
 =?utf-8?B?SmtIS2R0eEFIYU5vQlJ2UUtKTExXYW5OZjVockV5eHgvWmlvR29FSE1YZkZU?=
 =?utf-8?Q?GPd3FOOTAxc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5882
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d84106c1-94f3-4479-8372-08ddac892324
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|14060799003|376014|1800799024|7416014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0Nrdm9iR2pGV0tWV1BMaWZ4Q2hJbVNISDRTZ01ObVcyYWs0aFh0RDE3YnVP?=
 =?utf-8?B?NEFYRWxkaEIwS0h5Z1RpU0w3d1ZzV1lIM3ltQnNIRHZCUEozc3NqMlhwSUZ2?=
 =?utf-8?B?MVpKd2s5b3pNaVgxTkhoa0NiQTlJYWYxL1RyVk9qa2dNOTYzb08zbjRvYTcr?=
 =?utf-8?B?bUlod25CTnpYLytMdWRxWEszd1B0Nlh6VlhvamN6L2F5cnB2L09zeElFL0gv?=
 =?utf-8?B?K0o1SUF4QWFldVc0UHlWTUFDMU5OTFc2STk3SU1ybTRZQWZBMFFhNUJrb1dV?=
 =?utf-8?B?Q2I2bDJhaUI4UXVsZ285MjdObnJNUklsZTBzYjZ2UlZESDI5VWFVU045NkNZ?=
 =?utf-8?B?YW9MMHdMZE9QZUJkcHd3UERZTFF2anlJL1BaSzQ2SHVLdUs1OVVkSGxTWXRY?=
 =?utf-8?B?RE1nTlZJSXV6a0Q5SnN6d2FCWkwranVxTHlYU2ZFL0FWblFIbXFSY01TR3pu?=
 =?utf-8?B?dUNET09keXg1VGFUSlFqTHE0Nno0MGZ4ajBrT0VpUnpicGVSdW4wQjAvdnI2?=
 =?utf-8?B?RXpubXIrWG54aFFjdGtUMmVmZUt3RHJrU0Fyb1ArV0pzOHUvS3ZiTWxxdUR1?=
 =?utf-8?B?VkMxZ00wWGEvYzM1bmlkYngxWXRGdVRUSkZEVUxPcEhHemFjVnlOQmI5WFht?=
 =?utf-8?B?Vm11RUFTVlh1QmU3TTY5TEVvdzZWN0g3QlFaVjNRdmlsbE9CTkltRUNYZkZW?=
 =?utf-8?B?NUdYVkpCaHBpd1QyNUJOYmFkL2ZySDUwc2drN3hxL2dlc1VRS29YazRFaGUx?=
 =?utf-8?B?M2tabVQ5Z0gwS2Y5bUcwZDkySFJrNzNyYTZPQVVjbzVNdmY5YVNmU1VEUmdX?=
 =?utf-8?B?SngvRTArQmNnN0x3V2RRTUE2anhuY3JNSmpaSjlRUW96RGxkSCtkSE1KOUt5?=
 =?utf-8?B?bkZRVU14eDdFRVB2cXJ1WVpqanYxd1pERjIxUzE3K3B5cVhNanJ2cEE5Qk1t?=
 =?utf-8?B?L2ViU2hiRTRPQkc5MXlGMnVtdGxlUlJkcDd6ZmcvanJkRGpxbUNmSFRNdjQ0?=
 =?utf-8?B?U1VBdlo1TWJuakRFSmwxdXM4blAwT3RTMXRlU3dJQWZCRUJRUVFnVEcxSmpX?=
 =?utf-8?B?bmt1NmJyZzhEWGpNU2FoT0pUWVhoNStpLzdiY3BPN0pnREIrdm43L1A3WkVO?=
 =?utf-8?B?N1oxWHNxcWNic2lZWDhwamZ3SzB4Q1hOZmdXQ2VoVWRsck9rMnRzNDB0Y3JR?=
 =?utf-8?B?blFXV2p5VE5saHlPdFJ5RjNNeUxkaVdWZ0VIVE1oUU1XQkFOZDJwUEJwZUNR?=
 =?utf-8?B?dnpXcVpRWGtrdjJRaHF0VHdQdkVvbVdsQTFjU2I4QWM0Q0pSNUFCeHpFSEhK?=
 =?utf-8?B?MFA0c1dFenJJMUVxUjgxYk1OTlpkL3ltMFdWTTMrb0xVaEZLd21hcjFGU2JQ?=
 =?utf-8?B?aFUzVzd5QVE4LzRjdktjTjdmTVBSK3FnRWtiUDg5Mlg2RWNWUzJ5aTZSMllv?=
 =?utf-8?B?YTlacHNHS1o0d204WGdMUS9BU2lFVGhod1BUVWZKbTF2ZG9YRXl3K2xDcmMx?=
 =?utf-8?B?RUVoUHJkK3dnajlaMmRXRkNHeDdSaHpwSi8xU3lHNHpMTHh0cWN2cExMRlRx?=
 =?utf-8?B?blo1cWpaeDJVd01XN21xVEY3NUdVQmpVNnQ4U2x0WG1OYWpObXhFNVo5SzJl?=
 =?utf-8?B?QnM4YzZZMVVXSDJ6UFJTVW4xNnZUMjJsSjd5TUo0ZmhReUlTSTFTMXpPbjhy?=
 =?utf-8?B?OU5qZjVKTkoyK1dITElvQlp2V2ZpUlBOckxReTVXaEpSTk80Y1E3WS8xcVhF?=
 =?utf-8?B?ZWNVMnhrdStlWjNGQnpQUWZmWnlpbUgrY0J5UGNqdzVvWDA4SEJkTnJ4MWs2?=
 =?utf-8?B?Q3YxUVB1dG5aQ3pIZ0dpcHRnYTNUa2RlcTJDODh6REo3Z2pyajRrSzBFYmFu?=
 =?utf-8?B?WDl0Y082MXFyTVI4UktRSi9HMzRyT2FDdnJHUGMrLzdOMlFLNWRIS2lLc3Ux?=
 =?utf-8?B?bS9qWlZ1ajJYSkJWLy9mdEpnb1NxNndQTEVDb1J6dUlRS21saGpoLzNRU0dk?=
 =?utf-8?B?SkNaYW5Rc3MzSm1UZmhGdld0djh3RWpNd1pHaEVtUW9Bd0ZmYUxxbW9JdVlp?=
 =?utf-8?Q?8/gx/e?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(14060799003)(376014)(1800799024)(7416014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:52:28.0752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0dc32b-7bd6-49a5-21a4-08ddac893680
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10933


On 15/05/25 8:52 am, Nico Pache wrote:
> The following series provides khugepaged and madvise collapse with the
> capability to collapse anonymous memory regions to mTHPs.

Hi Nico,

Can you tell the expected date of posting v8 of this patchset?

>
