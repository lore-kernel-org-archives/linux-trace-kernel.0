Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D913DBA0;
	Thu, 21 Aug 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789250; cv=fail; b=u7nBaesvGlnuzDxdT8I5kJCMCKK2BHeDJEH7D0Rvd4asqz6/9XkF/aqUXR7N6gmP+q4AQF4rnnoIdrWCB5G7qW86Trhbff776ivq+b/iAYuGS80mm8VBku3uNpOQjeGDxo77bTcrWCqhRqvE+WRCXTda6JhGN4BIf0KMMUOYioQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789250; c=relaxed/simple;
	bh=VPvBqSOWk1nfg8zaSOQn5r90u4vlyKtdYfU6O09i1po=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dbUDomnZpjZrEiz/Se46/JncCQRo6xMkNDveSIVbP2RzGeC5yYntbsNoBg9kVVUqXCRciER+r6wZYuo7lz8/H8vXOVmOsy3xa3CgZJEz+13rjG6KhlmjaGhI/bnzrdpnI03gQHcRdl6qS1OiFMwxc6xCeYvc7egcyY+pU2a2lhs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WxEuoFWo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WxEuoFWo; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WxEuoFWo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WxEuoFWo"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RNjjusRs/ef8WusDUesJ6v8cNSk99PxxKQhimnrfKmnc0tMzseH4gj/L/3ebyJ5wFz2/C05pEFjFGMbvDSufPU+lzzurEZbgUawn9+8I3qtTL4wzpxa2H0SWTQ9Q/h1xiUTuQ9jAmNW8YhkbGn5ZsSmdXfFnlw30YxHs1ddpiW8hshoN+O2JkLqncRt3gJY4VqDaU436nw/v5/E+ynnlOfwFK7PNK1AYDPw+RgwodFU3WHCDAe6DlWAIiZFU/2CwF7gUTjHB8hHDIQjg2Ij2fvCi7i/ACA3UkSBDaGo2OkxgPa5u6b1g/zQlKiK0BC2Nf1JNgiVamauGOQDnMQW6MQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkntVAPChr/9GCjjgMoSnwS5j3xRBOBo/bhdovyMXYU=;
 b=XPzPa0bwNdkJk/F3FRG37LLtaOaIJkyoZwHOdl7rDhcxiTbfrFrSy9Tt5zKCiuYM1EIukvuZ+Aas49bkE9cOLWt8lqWFWnD6VFpjDV98DskaUE7RU90PPlHLwr5SaK4D5TYxdtTPn8oObMtMViW7JdowSrIcu5Zg2ZoAq9WuKuBIibsisLSx3gxwUxRReW42Q0iR2+Yf/hPxgBZhVWeTQbzWWcEczvAFRruf+r718WFQiOBNDTt1pifk+vHd0uCNYTE27lnivEC3pTrTkcMbLTZI4/oBvOZD5xvltXmW7SlCri7dQARdl97AawyiRXycgn1K/otAqUMsPKLzKLmIxQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkntVAPChr/9GCjjgMoSnwS5j3xRBOBo/bhdovyMXYU=;
 b=WxEuoFWoeW+TH+6gmo9DA9XLp1MMcNL16CrTDe8+0lCN0hp93Pf6AFcgqXLE1w0YC1hVmoV2HXzATbKC1j9QAXPojKEZ3+YHpMCUAZxG5AkhTXJSRr2pKo4fWBdLXMO8GnwWtsYUHtJMDZTp1qYLIdTqVQhdYUFIB+DN9c8LQxo=
Received: from DUZPR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::16) by DU5PR08MB10552.eurprd08.prod.outlook.com
 (2603:10a6:10:526::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 15:14:02 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::c4) by DUZPR01CA0031.outlook.office365.com
 (2603:10a6:10:468::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 15:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8 via
 Frontend Transport; Thu, 21 Aug 2025 15:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYTpguLMYhI2DCjto2TQZuuIqPgXXoyyC4+vGMTaxyZAlR+/bCUELbRmX/ZMDQKm/+VC3Y8W3Om9a/wMB8yJ7eU8ghR2jqUYlz0hl++2jIn6TNj+1E0f/fj5SXaLRd9RIzK2TLPsZgS2uUswOx2dRyCxNM0oaOkd7AqyUfSuc6gexupcS6lTtUyKlk1qTzWFEsd1A8EcQ72jNQVkB4rXVyBV3O7LscnZ5woYpzCHHf3VmX3MO/bJrDhFBwBHV972zrQfLsMsFdQWW297cXpgorv8DSWqw6UB1aXpSWyOtPQiws3CAPVNmZsBAeXJbItBGsxUyE+QJL5U/W0oKS/78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkntVAPChr/9GCjjgMoSnwS5j3xRBOBo/bhdovyMXYU=;
 b=tkRb5WCK8Kc9ePUBv5jMGNHkRe3kYEAZPr7tc+eDI9dj6mYny6pBUnjZEYMLPYn+YBTpbAkUHNjc5ml4nBewukkNRJgfRnYbw5tLwIT7kxVWSH0GVIhwHhNEA8Ued9jGidtY4DGcA3Aa1Hfe5HjfuiTxkvCK2cYM4dJV5HQLU8FjOxvvfkwev4/HZn9gxBtDVNB7W2mRbwIBd0S7VsHMTzspkZzhkmOoZ3aKeUEVvgzH0SYO37CeNgp8noIYN+3ByUaGe1L7LrS/HoGwnQYEB+IQxarLeyG4s4AAyF6WK2gXirI8cZvJMoehv+XZhwaEhb05Nm1eZe+ClTDNIA+Hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkntVAPChr/9GCjjgMoSnwS5j3xRBOBo/bhdovyMXYU=;
 b=WxEuoFWoeW+TH+6gmo9DA9XLp1MMcNL16CrTDe8+0lCN0hp93Pf6AFcgqXLE1w0YC1hVmoV2HXzATbKC1j9QAXPojKEZ3+YHpMCUAZxG5AkhTXJSRr2pKo4fWBdLXMO8GnwWtsYUHtJMDZTp1qYLIdTqVQhdYUFIB+DN9c8LQxo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PA4PR08MB7434.eurprd08.prod.outlook.com (2603:10a6:102:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Thu, 21 Aug
 2025 15:13:30 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 15:13:30 +0000
Message-ID: <38b37195-28c8-4471-bd06-951083118efd@arm.com>
Date: Thu, 21 Aug 2025 20:43:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
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
 rdunlap@infradead.org, hughd@google.com
References: <20250819134205.622806-1-npache@redhat.com>
 <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::19) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PA4PR08MB7434:EE_|DU6PEPF0000A7E0:EE_|DU5PR08MB10552:EE_
X-MS-Office365-Filtering-Correlation-Id: e80b4314-7618-4522-0742-08dde0c55c94
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?a2UxVnVrSUlCMmMycmh1WmRUYTk5MmU5OWxsY2lxMXZod3I2NGtJczJmQTRy?=
 =?utf-8?B?NU5OUEhJeEUySWVzNmtUYmlOM2d4SWdGSkxBWXltemFJK1g2YmcyUkVCVHpE?=
 =?utf-8?B?RmFubEFkbVdGZ2ZTaXdGOTFQejUvSlN2eGdobElBakhISEkzNlJZb3FadGJG?=
 =?utf-8?B?b2x1Q05obnRGc2JHc3hsM3Yvd1A4czA1aUZScWIzMllidGFUUUJscUYwUXV0?=
 =?utf-8?B?dU1vd2d1M2ZHS29OOFZ3S3kzZUZvdEFVRm1CVEtMUjFLQmtBVG1sOXZmZXQ5?=
 =?utf-8?B?cDdLdWpzN1FuOUVrOGthS0JCdWdNMXhxWER0d1lpM3BWVXBiOVQrUktVTkp0?=
 =?utf-8?B?VmdOSmZ4RFJyL3liNEhqbjZWOXhscE5XcGJtZGJGZXppbFNrenJlWnFMZ3BW?=
 =?utf-8?B?UlBEUm9ORmZKQ2dHeEU3M2J2QjBidng2clRGdk9ib25XcmNsY3kwWnRIcHp2?=
 =?utf-8?B?WS83OStDdW1JaE00WmgwTCtqcEhCWHFrZ2FiTnU5WlBCcjZUVkNNK2d5UjE2?=
 =?utf-8?B?MVdIcGI3dWNPWFZjNWI5WE05bU9qQTZQQ0dBeVFSVW5iTU4wV1dXb1FtcCti?=
 =?utf-8?B?a1BUYUVkakhhTmpGVFF1NFhDaVB5MDVQajVtd2RGNTRsOW43K0J1Z3BLZS9P?=
 =?utf-8?B?Y3lIeW5nYWVudExteHZtWi9takZwR1kxZmUzYVJORWtFcXZoT29yMS9SSmF4?=
 =?utf-8?B?emtRZjBUeC9RUElLamdiZmtPbmNTa1o1TzNJNkhldzY0ZmxCOEdKRU1ldUNi?=
 =?utf-8?B?SU5Yc0NrMnoybUVSbXlRMmlyalZMWTFOM0ZZSGlZOGxiYndydHBNelRML0VV?=
 =?utf-8?B?cHZNdDc3Z0xhS2JERUxMK09hd3k3UzFCNk0wSGNjWGZzTC9vMlhHRFlobDRW?=
 =?utf-8?B?U2tETC9KZHhmNnZ4SUJnaGgxamJxVHhIOWZwTnhVLzRScURMTkI5czhleHp2?=
 =?utf-8?B?VU5jeUlXdUVmdXRZekxoRlNvSTFoVFRCMDRCeTdHU3FqSmt0azZWQk9lQW90?=
 =?utf-8?B?UW1mR3hJQlllcGh5YXNTYlJTTjlBNUltUk16WDM3azVlOWFuSVo3TURPbUJy?=
 =?utf-8?B?bHFoRnZJeTg3MUdvTFIvNXRUVHJRMTMvTk44Yi9qUW1xZ0dnamRxeVNkZFlm?=
 =?utf-8?B?bXh5VzJCZDllM25ZbzQrWFN0OU81QlhWa0lsdzUvZlRtbHU0dCtpZ0FZSklQ?=
 =?utf-8?B?NDkxQlA5bTV1TWJhRXRneGZhT2s0dGFVcTdRbHV3ZHk1VkhCdU15ZDRaK2Er?=
 =?utf-8?B?NEwwVDJrN0d6T01tY0JhUFpmRm1JWHhueG9CeG1wa1N1aXcrOFB4MitXV2lR?=
 =?utf-8?B?STRXT0RwVW1NZmNmWFFwT0F4Y20zZTFvb2tvcTVad1RjU213enNvVWxMWUVM?=
 =?utf-8?B?cEhkaWo2dmtlOWthZkFDVHdyNnc2KzZNS3Q3NWdLQjNlZjlIMDlDaTRXb01k?=
 =?utf-8?B?alFBaHBEUzQ1bkZTWFZZVHVsZUY3NDQ1R3ovdmtmUnNqWjQrQXpQWjRLS3Ns?=
 =?utf-8?B?cjNNOWlBckxsSnJpZE9pT1lzS0gyZC9jUnRkVnJldy83dDdnRWM4RDFvSk1Q?=
 =?utf-8?B?b1JpcHhFckFxL2ZhSVdQRkNnRHFmOGFKdkZoZm84YXNOR0F3WTExR1pDdkFk?=
 =?utf-8?B?aXVFbzJ3dS9rRHNUNFc3bWtacTAzbzBXNmRWWUdDR2c3RFhsVXp1cDYyWita?=
 =?utf-8?B?Yys0YTA0Wnh2WkZ2Z1JtRkdyU3cyaFdtK25OVHdDQjdEZWpmTlVPc2V5V1g5?=
 =?utf-8?B?SG1wMDJGbGhRMDc5Wk5YTlE5alZvZ2VKSXM3SGRVT3JjMktaUGNPeU1yN1ho?=
 =?utf-8?B?VW8yTldOcHlMdXBva0VhcmsyMVAxa3F0NHArUHV1YUwrdm1nZjE2dGxKcjly?=
 =?utf-8?B?RGkySmowYXNGQ1ZRa0d6L3V4OCtBaWJ1aTM3Y2ljMDF5K0toL2gwYnBHUE5j?=
 =?utf-8?Q?O7hz8U+NzKI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7434
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	88112663-925b-4d99-c047-08dde0c5491d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|36860700013|82310400026|14060799003|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGhlNGp0Z3YzNGdQRUpPcHkzSVpPTkZrU29SQjk4NWxmdWhIS0oyVjVBeFRZ?=
 =?utf-8?B?NmdVYS9YQW1BUHE0TzhmOE45TFJJSmF0NDVGcDR5bVlHekxESWoyNnorZ2hK?=
 =?utf-8?B?SHV0T1dyRVRma3E0Q25RNFNPdWRRR3N0djVhWjZtL1Nxa3d2TzlmWEFURHZB?=
 =?utf-8?B?M2FLc1BmSjdMMHF1cW1sb2FQZG42czJvV09KTVV0K2tDdUJmRFJaOTJwdC8y?=
 =?utf-8?B?NEZRYXRyZUFRSmtmTFVXVmE3amJyeGErWWVQbURERlh5RThWV1FuTUREaDFF?=
 =?utf-8?B?bGoyVnZIL2FldURBUHNZREFFWHZyeFF4MyttRjVZZC81OW1EbGEwWXQxMElj?=
 =?utf-8?B?TlR3WXZkYXlyZGY1TlFiVmhJQjYzaGZ4Yjg1aE8wdEJMUENiTXdueTJHeUJY?=
 =?utf-8?B?Q1NCWC9vbFloNjRhNVcwMlhsalR3d3dlbTJZSnI4a2tUQ2hEODQ2UEMwdUl4?=
 =?utf-8?B?anpia0Y3M1ArSitzNFk2VnErd1o2Uzc4ZHdIK1lzUjJiL2sxU1Z1ajVMK2xN?=
 =?utf-8?B?V0ZGK3Y4Z1A3bnU3ZG9RaVZ6L0pHMVZNa0JGZTNucEtsRnRkc1ZnMUF2RXFa?=
 =?utf-8?B?UktnNWZwV0NRTHVxb3duVXBhNmI3TUh0bFdqNXNVcTJCTmVrK0lDTWRLOFli?=
 =?utf-8?B?ZktkVFhIblhtS1BKeXQvM2t2c3M0VkdOeDRQTTk4Wkx3djU4cGJuZTJiSnVR?=
 =?utf-8?B?amYxTGYrM2F4RzA4S2JRSzdpUmhub3l0cFRlODBlekJLUm55bXhvY1dUbUZp?=
 =?utf-8?B?WmRiQkZsZFcyY00vaE9rc1lXeWY1OVNWdjAyQ2lzbGhQYWduN2NvT3FhcmhR?=
 =?utf-8?B?czlNQmZvTEdmakREQ3AwWURlZU9XWTV3ajkxV1dyRzNHdnhHcXFqMjdNVzYx?=
 =?utf-8?B?NHFiWTNTeFRWVzBCMVVkSG9tMzZWRHV4aFdLdEgyZ3gzajljQUZIWlh5ZlZw?=
 =?utf-8?B?ZUVMbVFRRkhMdnFiNGtnZmJQaEFhUVRjWXo1bXlUMnh5bDBJUFZxUnE4Szdw?=
 =?utf-8?B?MUNMWXhxWEptQWduZ25MMDBocnB2c2lUVUtKWk4vYVJEaU5TMFM3UjFoVjE2?=
 =?utf-8?B?ay81TTdabExsTzZyMkVhZW14NVBMbWVlWCtWWnhJMmpPM3ZrZ3hOUHkxbGZE?=
 =?utf-8?B?d2hUZFQySlBpcU12eGNvMUpMTnRBbmtVNjR1VTNocmVsMmh1TmN3dnVzZUYy?=
 =?utf-8?B?SXN0WWF6SjRxQ3Y3Z2d3UDZvelZvbWx2ZTNLVW5MeTdDQ2FpN3p0SGROS1ZC?=
 =?utf-8?B?TEM0RWJwR2E2UDdqVFlEQ3BFODF3bjNad0xzRE9PYmZjcEJmTVNla2dzZ3pJ?=
 =?utf-8?B?VGU4SXFOSE5oMFNXZm5VbEZTeXRWamJzTXg2SWVKVzY5dXRMNGVRaG5QYy94?=
 =?utf-8?B?Ly83QzE3eWZwN1FDS29KMERpbEdHekpmbkFTVk9TcjRsdHFRYjhOUFhSNXc2?=
 =?utf-8?B?ZVYrSVU0YTZFT2MzR05nNlJ4UVFYMy9ia0IxTHZWZENRemlyLzJWU0pYZWlN?=
 =?utf-8?B?RXFqUzcxbk1wbzZVYjdBa3FadXFCVFBQbVJjVFE1TjJpVzZoL3Btc3NCOW5C?=
 =?utf-8?B?NDhxenRIVEdmLzBGQUpkVXNtMjBoaXFQTWpxOUNYMUdtdDFlRGNWQ0lYMkRS?=
 =?utf-8?B?aFpyZ2JHTWZ5bzM0RGV3c2FWSE96S244bG0ycGVVQzlPTGhuK3Urak51QVc0?=
 =?utf-8?B?VGppdHVhQS90TEVNVklNdG8xWXlGeTZnVm9qNVlWUm1ydmtXb1ZxdlJRUnVX?=
 =?utf-8?B?TFBZdld0U2JIZThBd1NMd1BIQTk1aDU5R0N5SEJqMUsyMFJUS0FIdUl5ZkVs?=
 =?utf-8?B?d2JCMGtNOUJWanpHdFNLL203MGlOS09aNXBCbzV0cDRXTWdnTzZncWRrWGlC?=
 =?utf-8?B?MmFRWHQxYmxGR3llN0lEdVBENlN3Y2N0NGhDMUtYM0Z1UmozNEo4Ym1ndGQ4?=
 =?utf-8?B?YWpNRXpGNFpiQlo1OU5lcW5JblEzcWVZa28xWlVadTZRdkhYa1pxWUR6S0ZD?=
 =?utf-8?B?UE9jcnA4YzZWaHhOdW5EZG1EMklsVEo1aHhVMkdSMGlmbkhPR2lScGNhbGhK?=
 =?utf-8?B?ZXhHRWlaT1NmMi95YTRiK05PeXQ3OFhMR1lKUT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(36860700013)(82310400026)(14060799003)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:14:02.2178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e80b4314-7618-4522-0742-08dde0c55c94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10552


On 21/08/25 8:31 pm, Lorenzo Stoakes wrote:
> OK so I noticed in patch 13/13 (!) where you change the documentation that you
> essentially state that the whole method used to determine the ratio of PTEs to
> collapse to mTHP is broken:
>
> 	khugepaged uses max_ptes_none scaled to the order of the enabled
> 	mTHP size to determine collapses. When using mTHPs it's recommended
> 	to set max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (255
> 	on 4k page size). This will prevent undesired "creep" behavior that
> 	leads to continuously collapsing to the largest mTHP size; when we
> 	collapse, we are bringing in new non-zero pages that will, on a
> 	subsequent scan, cause the max_ptes_none check of the +1 order to
> 	always be satisfied. By limiting this to less than half the current
> 	order, we make sure we don't cause this feedback
> 	loop. max_ptes_shared and max_ptes_swap have no effect when
> 	collapsing to a mTHP, and mTHP collapse will fail on shared or
> 	swapped out pages.
>
> This seems to me to suggest that using
> /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none as some means
> of establishing a 'ratio' to do this calculation is fundamentally flawed.
>
> So surely we ought to introduce a new sysfs tunable for this? Perhaps
>
> /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_ratio
>
> Or something like this?
>
> It's already questionable that we are taking a value that is expressed
> essentially in terms of PTE entries per PMD and then use it implicitly to
> determine the ratio for mTHP, but to then say 'oh but the default value is
> known-broken' is just a blocker for the series in my opinion.
>
> This really has to be done a different way I think.
>
> Cheers, Lorenzo

FWIW this was my version of the documentation patch:
https://lore.kernel.org/all/20250211111326.14295-18-dev.jain@arm.com/

The discussion about the creep problem started here:
https://lore.kernel.org/all/7098654a-776d-413b-8aca-28f811620df7@arm.com/

and the discussion continuing here:
https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@redhat.com/

ending with a summary I gave here:
https://lore.kernel.org/all/8114d47b-b383-4d6e-ab65-a0e88b99c873@arm.com/

This should help you with the context.


