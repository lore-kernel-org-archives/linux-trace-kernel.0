Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C284A2B;
	Mon,  9 Jun 2025 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446865; cv=fail; b=Gy7QNRto9RujwKhCZDzNX/vE1Y+/Q1ArC9QzaUqoe7ex2sEN1T1V2apChHYyhTvV9DIJ+hxk74UgN9BKQyg4KGKB+yS3qNOLeGi2hs3RpLd4e15I1GhHuizc9W4EeJ1vUutFYd26wOyRm/vMg9XafzEp32XcHDRlGYYiibJRQ48=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446865; c=relaxed/simple;
	bh=dB4Gj2Nw6DjRiBvQtHpH1A4mfNxDbJQe3cKx6F2vJS4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CZhU7i/SRwJmK0+MIj51ACBQMLi2YkU4NXEDUvBwOkg1O00CP/skE+tJl9olIys02ZegY62CTfEUwxTVJrpkuSP3ccQG69wmhvgUWcpOe45vXeubWn4K/77gY3kku83EhNB708dLAKo0dZImBiONdcmGUAfaPgb0MxftDwRLN0Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qA+uaQNJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qA+uaQNJ; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qA+uaQNJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qA+uaQNJ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Zd1ZZxZohg2Igo21du+qiU0I0qxz5Q0aPjOwm9U+XLHFY4+DN8K+t2D2Hb3yyOMwvynwMAPQT+v8Ym90nWJ91TbKSgWEgMBkTLP3pyhCtfxqWqbqSAfh3/Qy0hVbcYFRj6JXmGwRPoECyZ55Oq9r6JEW5FYh1/aUgPWuAEImgqdtJBIcFMaQZYAQLa5asi9O8cYynifI06Gn9J4biciVSOTiKg9dgNucP6Du6cIc/HtIUFhLG8OIgGKCg6/VoT4chDl1HhO/Vg9FehAVXqSPPlRhORVk9Q+1S8ekuxI1OjQIGNeVnJ3Dsx7N2lbqQJOqSSzGV4+Y1SLspDwKq6/Q3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reozUsedpYwVN6yAFlIHcMlppRWnUnXTPnZ1RGeuHMc=;
 b=unpZaMF5A5W7GQg+tIBku03hGE5c/J/Zwg73H4mgYDrC4PYfbR1N3VQ1/v9z/0SmEwNh7svJ+pDxnhX+hhEJHlLAFUH4dvAhdLlQ1XRlCeq9LwBM/Gth3QcHzqlQZWq4zqYgWm6ecbp2FlxIEwXZOmRL6q/6w7To40499OUX4k1cAmyJnAl6R5zCfdx1vwtck9kdxE+rU9JDh2ZcVedEjFQP68KN0W1Zha/muJpajag2UleBdYprkpbkKI/Fj5bfmmrHGdLToyKQFV96Jmjy9GYdC9nxsaK7sOCxeY54U38+XhLYE+IhGR0Y9aL7GWl6gBaLgOqU1TVSmF/jmjIZOQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reozUsedpYwVN6yAFlIHcMlppRWnUnXTPnZ1RGeuHMc=;
 b=qA+uaQNJg7uzzHrjS1+8ev8Z8KKBCFslEqVYHgzKQdKzjxVlOtwDD1pANft8uUVIC1OadEJuNchOBxN11ctMSxltS92p0omiLr9KpTIEJAFb3+HjEF3nUkhK/NpZwxOZRxYTV55J1m5VsI4EKEydrJn+autIgo1mYHCGEcRzflg=
Received: from DU7P191CA0008.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::12)
 by GVXPR08MB10892.eurprd08.prod.outlook.com (2603:10a6:150:1fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Mon, 9 Jun
 2025 05:27:34 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::f1) by DU7P191CA0008.outlook.office365.com
 (2603:10a6:10:54e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 05:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15 via
 Frontend Transport; Mon, 9 Jun 2025 05:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htSMmYFvsnoDGABZwTL8Yzt0DjoWFpcK8TQ5osy3CHRoXAaPddglpyUHjRLxNA4ZfI9fCBrlt2XZ8fUBudOP4TpRMjbr0FyRSgn7h2TLWlVpIHbheGI5BI+5yAUUtuQp068mINEdxD3ee+99DXiguFyGqCh+Y2z2KyG++IQytjYRmAPLW3Ll1qpfI0IHn1snuUfNwPTJe7TnP8df8cYlD0+hOUXM0/Vq2kvN2rhp4Ikpfm0xJH1/g5tJBfGS+D2CTJfxp2GP7qtji0OhCZxEYTE8WDMi+ghnS+0vWWjKMOpq+uXJ5+8ZzmVN9CtQfYXWDc4DhdC2rp43DkYJQlrnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reozUsedpYwVN6yAFlIHcMlppRWnUnXTPnZ1RGeuHMc=;
 b=kSWUclDst6G+DiL9wRXVAhOGrNTXuc2RMQ7m9bWGEeP1fKrRyes+fyRDaEbKKHQxmB8JyYNHeLEucJmQ92VXqVAvnwuhYMkaCCtVXaO1ON+1zsYoVInbtQtsXq1KU5lo2tdOUDQVUa74JD7Gm8jICkgClK18sllbxG/hfML1vU3RHc2MQnH+EkQx5w7e8HYwXKz9RhzwRLBi7pji2uFFZezg4aqrlZ9AbBHGexieXYbaD+jmkGMYwveh9/XpS2B+hHpXyrQRMERG9UPBa6vrKaEcCrY4xJ518J/7UOT6YlFA8wjYOMm729yV/IbOcczc3E4ABBYPi4pWgEkJQzlxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reozUsedpYwVN6yAFlIHcMlppRWnUnXTPnZ1RGeuHMc=;
 b=qA+uaQNJg7uzzHrjS1+8ev8Z8KKBCFslEqVYHgzKQdKzjxVlOtwDD1pANft8uUVIC1OadEJuNchOBxN11ctMSxltS92p0omiLr9KpTIEJAFb3+HjEF3nUkhK/NpZwxOZRxYTV55J1m5VsI4EKEydrJn+autIgo1mYHCGEcRzflg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS4PR08MB7532.eurprd08.prod.outlook.com (2603:10a6:20b:4fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 05:27:02 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 05:27:02 +0000
Message-ID: <b6de3ecf-a573-4a65-b575-2ba361a6ba98@arm.com>
Date: Mon, 9 Jun 2025 10:56:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, corbet@lwn.net,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-13-npache@redhat.com>
 <bc8f72f3-01d9-43db-a632-1f4b9a1d5276@arm.com>
 <CAA1CXcDOEdJRvZMu2Fyy4wsdy8k8nj4c45s4JanO9HzyJgyXOw@mail.gmail.com>
 <b09d7553-c3c6-453a-8e3a-86dc4caeb431@arm.com>
 <CAA1CXcB-A9U8GEodPrm3QdndzB2MY7eZHnoojVYU5fi_DJBbcw@mail.gmail.com>
 <4a2c359e-79d9-447b-a43e-164333d08319@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <4a2c359e-79d9-447b-a43e-164333d08319@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS4PR08MB7532:EE_|DU6PEPF0000A7DF:EE_|GVXPR08MB10892:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbe1121-d373-4c28-3dcc-08dda71656bc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NDNMZlE3YlRJRVNxZlI2RjdjVkFNdE1BUHlqNjExdStlMEZ4ZEtiMHNaSzlL?=
 =?utf-8?B?N0V3NFpnLzh3b2hsYk5LYkdYN3hjNVVkWnRiQUNTT0JDbjRySlBxdXRUcFhK?=
 =?utf-8?B?OEVkaGo5UkpHYWt4aFJ5KzFpUTlxNnFvS3pQS2E3SCtFaXdObncweGgzdDBn?=
 =?utf-8?B?THNCUUNxYzV2SVRENnJOd2p6dnNtRytrNmlMb3kwR3NndEt3N3R6eFFWanlT?=
 =?utf-8?B?SjBxakR0TG0wODdlWVBqQWRodjhJK2loSlU5RE10a3F2SXE3ZkpseTQ1SGxi?=
 =?utf-8?B?NkFZVEU0eTUyWW0wTGJOeWdJcnIwZ0NtdU1xYUtxYjhocjB5aGhLYkcvSjJn?=
 =?utf-8?B?NmtCQ3RlLzBDQnI0VUUxOUxBODlTd2dIekp2U1dZUjhETTNyYy8xay9IRy8z?=
 =?utf-8?B?d1ZGVjNNZ0Zna2h6dnZ5VHR5azhYd0d0M1VnYUtnRndoMThEOXpFUlJTNFND?=
 =?utf-8?B?QnoxbS9WMC9EVkN3eWVERWg3QWZ6Zm9uNndGWjNMTFNFcEo0M2JOMkV6SFRu?=
 =?utf-8?B?WXJsTW5wRHFjcUVEKzBiSTIrOGlkTFVZbC9BNm1lRjNybnFSVUduaUs4Smd2?=
 =?utf-8?B?SmJWbVQ5YS8yVjc4N21xeXFPaWd2NTZVT2JodjBYWDJZd25LYXBxZnZVUUlU?=
 =?utf-8?B?ak0zcGROYVY5TkRQU1JzWHRqajBsbEd3RTgrQjF6Zk9TdTlYdHhPYW1LQXBo?=
 =?utf-8?B?L0czeHpyako3UTU4eHhHVllFcDg5QUU1Z0hVTjJ4ZWIybHd4bitHVGRONjR2?=
 =?utf-8?B?Um5uUk1wTy9WWTFoRUhBZUhvTDBRUmJ1YVdBQmV3SHRJcjF5NnFTUkFXN3Nm?=
 =?utf-8?B?UG43VFN3ekJNR1ArZWx5U21QZ0Z4MTlFamdRQS96VnU1Zk5yZEs3Z1J5WWtm?=
 =?utf-8?B?OGU2M0hmb1kxS05VV1EwTDZVRFpRU3RYMmhNVFNwemV3ZW9RSzB2K3dDbzg5?=
 =?utf-8?B?KzFjZUJad0krRDhxekxxWURSK0lwb25TeS9FVDlxTk5YNzVMM0N2OTJrc29x?=
 =?utf-8?B?aTFvVnFoNkRjZVBSMWkzUXpiT0lqZTlUa2Zsbk5xUmF0SlY0NlIyQ0FmaXhQ?=
 =?utf-8?B?ZWJjcGlYOFZ4VHRTT2ZzYVhyS1g4NnVDeHBPTXNRcTFvc1hCUkRYOXpwNzhL?=
 =?utf-8?B?WTEwNHhxTkovTVBQNHlxQVFIL05BY2hFeU9VQklEYUN3SGpqRWhVeGxBcUhI?=
 =?utf-8?B?TlpPWkVCaHJnNXdRRkd4VGF0ZE1IRFBJSGluS1VPajBDZGpnMjdIUEYyWGR1?=
 =?utf-8?B?d0dkcWhpcEd3NnV0S1Z5YlZ4TzBEWEtuT21mRUtqR1ByS2dTbjloaSs2Uzgz?=
 =?utf-8?B?TjlEM2cxUXVSZ3VoUFovUmI4Njg0Nm1UVHNkQ3lQd2FhZTdNVnltZTE5eVMx?=
 =?utf-8?B?YmlTdVBiUml4YmRGSlVLVEtFVnRiY0REbkpoZXlhaCtNaW15aDh3c2trejdo?=
 =?utf-8?B?UWNFNWVOZngydG1YT3lmMXlMNHpncUVmaXZSVVI1MU9FVUlBdHBuajduS3lm?=
 =?utf-8?B?M1dCN3Zvc1FEVlRFUlhaM2hGdUVTdFF1MUdNWDBJWlRFWmVudGoyM0tZMExm?=
 =?utf-8?B?RTNSWjNPUnYvS3dta2h3aTZXVktkVFVyZzBQRHR6SWNRejBaRVNhZnhEc2tN?=
 =?utf-8?B?K0NhbnZxTHcwRlFnMkJRWUV4eEE4RkhTME5yckYwUUZEL21uekZHSjduRURz?=
 =?utf-8?B?M0VwQ0xDaGNSa2tLOTU4VFpjY2ZSKzF1R0R4T1lVRldoRjNRM25pbFVVd29l?=
 =?utf-8?B?NnBBS09HQkNvL3lwQTUyU1RJeHJZOUtmMWlIbnpkZVVObVRKUEQ4M2hvajBn?=
 =?utf-8?B?ckZFRW9Xa0Jjelp3anpQWEJxSnU1WURrQTRYcUEzdVE1MWZzcUl3VWRvTE1M?=
 =?utf-8?B?YUxPTFUrOTQ2a1Y5Q0YxT0ZOTUtkcGhjclFKTDVBbG8xTkpLbWpKQ3Z6L3l5?=
 =?utf-8?Q?TlaOvVEnOdE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7532
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79dc41cd-e9ed-40e3-c8a8-08dda716435d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|14060799003|35042699022|82310400026|7416014|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmFjUWFWSnp4NCt5anVBcmdFQXVGbGdVS0l0dVBhZE9rRlM2b29GNThrdW03?=
 =?utf-8?B?S3d5MWRpR2JCclorcko3RXJRSnFTTitkNW1HRWFUMTNDcVRCUlJhUHlIRTd3?=
 =?utf-8?B?bWJyMWtYOStKemRXOWhUQnZiVUZ0RVovR0x3S2hCMnp5Mzdiek5ZWUNtRFVy?=
 =?utf-8?B?M1Eya3ZpM1U0aS9kTWlKeXltWW42S29rdmhObkdrTzU2NEQ5bUNoQ2VnSkNi?=
 =?utf-8?B?K09FT0w3SnJDZitwSTVUeDllWmxPOEdTWTFHOG12TTFlVmRnczd1cFR1ZmFG?=
 =?utf-8?B?TGM5Q3NrNmY4aHphb28zR3I1Z1RvUzF6SHFyTEVmTXhEWlh1N0tpcnBhbkpU?=
 =?utf-8?B?azE2T1JFa1c5elhBTEZpeEpJaXpZZWNjbWZ0NzJVWklRVUMvOUtNS0tVWnVY?=
 =?utf-8?B?OHdkaCswanNxUklhSk04T1Q5b0wxaCttaFBFajhvMWVoK3BoU0kyc3paaGJG?=
 =?utf-8?B?MmVCVEJWNjA2QUdLZ0JLcTZtRnJTRSt3Vlg4N0hzUmRxVGNGYzd5TUNCWVA5?=
 =?utf-8?B?d0plMDhSaW1pNWh0aVE0T1AzT1hZZytYNDVWeldLZytSMTg2UXZIMkFPV0xC?=
 =?utf-8?B?MXRuT0Q4WXczOXhqMXJVRFhoTFRiUEZoZzY0WkI0THJvVE5xS2c1QVhwLzJT?=
 =?utf-8?B?K05DVXExZWZNNHRHYWNNTWd0K1lKRkZLNVJvZng2VzlsZzN0THpYN2xlZWQ0?=
 =?utf-8?B?c3RXb2FGL1dKRjJDaFZGYXhPVlJ3YXJsdm91bXl5Y0tIbXN1WDlHR3ZjeEVi?=
 =?utf-8?B?K0ZQN05aNnFsQW1zUHFwRnMxdG1icFg2UGRKVWp2NVBwQ1RhTWpkMi9PNy9J?=
 =?utf-8?B?U01SblZzeTBsOHplSTdmempRZUVhZVlma1JpeDdtYnhaenErYlRwTVdtRXZ2?=
 =?utf-8?B?T0FMeldHYk1aNmFwN25OMWtGVFowRVo5ZXNMdmQ0SlNNUXZyOEIwQjFSY1cz?=
 =?utf-8?B?MGJOcTJDaHVTY0Y5Y0VWT1VFV0M3ajlEcjRzVHZ3QjU4QmNKM0xmM0YrVXZR?=
 =?utf-8?B?VnlLNHFtN3k5TkFPQ2hldWMzbldXcUUwekRzYzc1clRrQnRTVlMrMzdlYUZD?=
 =?utf-8?B?VVh5SXNNS3hRMnJ4dDJ5T21CWUtOMXlHWUdUczhYNWlqdXdaMkMrbGJNWWlu?=
 =?utf-8?B?NUdRWU12UGkrWDNGM2F0VU9CQnE3Mk04QzltZmNXaC9lYmJOMVlPbWt0eFFa?=
 =?utf-8?B?ZzNPcG1jNHZEV0c4VDlYSmIrZlpXcGxPb0VhTkI2WWZ2dFZNNUtYZUdiNURI?=
 =?utf-8?B?R3F3L3BjR2Jnb0g0VUFrTGpmcjZNU0FsdmpqRjJrYzV0UCtGa2R2WjllNXh6?=
 =?utf-8?B?dU5sb3ZJdlp1dkJRWCtQZnpmR0hVWEQxbjZ2UjdENlBhM1NRM0RkbmhYSmJZ?=
 =?utf-8?B?TDljTkJacDZFVFZvV2MxbUJXanRybW9xWjVyZ3ppQVRIOThOamFtekFVYjd4?=
 =?utf-8?B?alJQT3VuSEtYbHpWL2Yvcmx6Q2pxbkZEYTVCODBZQ1NZczRZUm9JYzlQUFdE?=
 =?utf-8?B?OVhPVE1KdFM4azlrQXJqOVZENWhnb3hwZkJPdXdVclBLTkRPVmZHOWFSLzZY?=
 =?utf-8?B?Y29VMDdSTDNHSVRYY3dOaGE5TmpHMGdVQlVheWxJZVY5SVo2aEthTFkwb0l2?=
 =?utf-8?B?V0tvdTVmUGc3dTVrM1BCZ05nNGR0aEltcGNkcEZrWFRacDRLTmEzTmdzVmdS?=
 =?utf-8?B?LzB2Z24xdHdWRm9WT25CYXlHNk1vT0FwZDdFajg2dHFaL2psSDJzRnFjVUo5?=
 =?utf-8?B?enUzclpOaS9jamMzMUFGd1kycHVtNXJhQ1owLzBYdGRCVTdsd0ZhTko5NXJ0?=
 =?utf-8?B?U0RZdlRySkFGR1pheG4wQVFuQkNtWTNGMTlQREFEamtzcCs2RDk5Z3lEQ3dn?=
 =?utf-8?B?WklRcTJ4Z2szUzMrZ2JpSGc5VTE4K21ZWEZidFRmTy83N0dzUkk3U2hMQzdU?=
 =?utf-8?B?ZDJrbVpSU3k0UnZ5Q3NoL0I3NUI2NEhkUEYxajZuOTFDZ1VBRGtkLzdMb3BC?=
 =?utf-8?B?NXVncEpNWG5ibEJMZldUakdSS2pmZEM5VW1aTklLNC9wSWhDcFRIMXlUSVJo?=
 =?utf-8?B?OGtHNlhNRDY4dyt1KzJoM0t0NUY1WlhsYXVXZz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(14060799003)(35042699022)(82310400026)(7416014)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 05:27:34.2119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbe1121-d373-4c28-3dcc-08dda71656bc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10892


On 09/06/25 8:36 am, Baolin Wang wrote:
>
>
> On 2025/6/9 03:50, Nico Pache wrote:
>> On Sat, Jun 7, 2025 at 8:35 AM Dev Jain <dev.jain@arm.com> wrote:
>>>
>>>
>>> On 07/06/25 6:27 pm, Nico Pache wrote:
>>>> On Sat, Jun 7, 2025 at 12:45 AM Dev Jain <dev.jain@arm.com> wrote:
>>>>>
>>>>> On 15/05/25 8:52 am, Nico Pache wrote:
>>>>>
>>>>> Now that we can collapse to mTHPs lets update the admin guide to
>>>>> reflect these changes and provide proper guidence on how to 
>>>>> utilize it.
>>>>>
>>>>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>>>> ---
>>>>>    Documentation/admin-guide/mm/transhuge.rst | 14 +++++++++++++-
>>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst 
>>>>> b/Documentation/admin-guide/mm/transhuge.rst
>>>>> index dff8d5985f0f..5c63fe51b3ad 100644
>>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>>>
>>>>>
>>>>> We need to modify/remove the following paragraph:
>>>>>
>>>>> khugepaged currently only searches for opportunities to collapse to
>>>>> PMD-sized THP and no attempt is made to collapse to other THP
>>>>> sizes.
>>>> On this version this is currently still true, but once I add Baolin's
>>>> patch it will not be true. Thanks for the reminder :)
>>>
>>> You referenced Baolin's patch in the other email too, can you send 
>>> the link,
>>> or the patch?
>>
>> He didn't send it to the mailing list, but rather off chain to all the
>> recipients of this series. You should have it in your email look for
>>
>> Subject: "mm: khugepaged: allow khugepaged to check all anonymous mTHP
>> orders" and "mm: khugepaged: kick khugepaged for enabling
>> none-PMD-sized mTHPs"
>
> You can find them at the following link:
> https://lore.kernel.org/all/ac9ed6d71b439611f9c94b3506a8ce975d4636e9.1748435162.git.baolin.wang@linux.alibaba.com/ 
>


Thanks! Looks quite similar to my approach.

