Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5882853F6;
	Fri,  6 Jun 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227902; cv=fail; b=NZpIKE0pMpMCxT89FauCXta6juOCXzbf9Zb1/8stCjhHLO/saj39sum3aL7xYFxZE6zSK8meD9sGboCHAoLH6+6Y7mZ/p80MPFAqZUKYqtwK0KMY+0gLInpW0K7V6PEG86a2uXbrNYnifOR3hyQdcpZJkafeUJ00dDG7hz0Q/lY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227902; c=relaxed/simple;
	bh=ikT7EFtwlL1og2BQN4qMgZrz4v6nd7doZwLdGvZl4aY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WgXHmu+QCcADtcZ2ueNun0I6Jq27MarxSjPzRCTLG0pJCZC6XmSCsfe3C5nBCtIKkRlwTm17PxhtwH4KyXS9MMglia+UY7P/YJIe1dzBLrs4TKV3xWz60s9Jz26g4YBhQyE/glhCEUgIbvS8L+60df92pTXhRqQIOf7VjiRuanU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kM4Wi2X1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kM4Wi2X1; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kM4Wi2X1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kM4Wi2X1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=soltaYN5HNYzfBgB0zkjW8AtZ19Yh62W91bt9Q7kTtraC8kAnHyyrwGn4udAjF5pt76wnHM0k4+eHRlvnzl5b0LncjuV2QqdHX/tefG8keKoKqDmMI8DH3QOOjd8crR7VZOumsTuQj5e5PJ/HBOAYgH2/Y2GuWOc49F/RY1h3fZW6Tx4Xoaxt1Z+tZAE/TV8Lp8wxZOwjxRHrVfPY8OmcRI68jTpM3nLloM/TmOtprcrE9EdiPD7YhW5OH+NyHPPtqXd9fJElpQgaW83i9RSTLNuM8m+us8YTHZ9w2ca63CPkWA9AtDsZQ8FCW+uOPO4ltCvRiYSxdCTucV5ThSSRA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1PQW86cqaocRxf17aEDXgbu6YN2oSd9iWWgegUSp+o=;
 b=W0Bj/emTLhMESCPCm1JBLUl9eZICTlsCrycRd6TgeiDrAP+kkKBWx+PwskEZ/j+xgpQK3nGyIsjDF/SIZLJh7OGXM7QEQSyBYv5F0E82EIw5dRM7xw29Fp33zFD3mJsf6eriz+U7pnbmKiONxwvFEi+9QhVT9uNKm+dPsit6himJNnl4MemBw6kMajVo23ukKLFTgv60aDkY8+VlWwXQCbXm5nCKf1s2J0oPTpRMBKhqyDN4pJpYKZJS6o2F/aJb/jzigoQWNSt9Z7ItKlBp5f1Mv4FjxFvycDBZ/V5bfishp9d7ftkVUCqzkbfxVZBzJ3TfYSj6FyZvU6Avhs3p6g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1PQW86cqaocRxf17aEDXgbu6YN2oSd9iWWgegUSp+o=;
 b=kM4Wi2X1GR+R4PBuAKNKy4kaTKa8PM/u3qtGEIuL7eXXf+Y9MsrhWrhnOWEzHmptNbCdZkDiSAT/e2blf3PsQ7rWTIKI6/9/pQzeM/BzkHJQh443zYil5IFAPIXKRGc53nNVfkv3N5O0LebvMatmZib2lt5ahDGAqURlMPPsfXk=
Received: from DU2P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::26)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.39; Fri, 6 Jun
 2025 16:38:12 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::37) by DU2P251CA0019.outlook.office365.com
 (2603:10a6:10:230::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Fri,
 6 Jun 2025 16:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Fri, 6 Jun 2025 16:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJWMXtK73HiRnAouXVdJGEdCRakXqMiK/pyaSrh1W2HiyMefBk56Fy9wVvPEPQ41uKdNAjzi53Qv3MAa8nNXZfH76NKpRgP8+tExP/LL+z9R8IcqxG8uuPxJ33eP92VvR1IxYX4Qt5V8Fs1ZfVgWvddcDYM7Uh/EFe1yCfMqv5G6p/K4yKLOSDmhyFK36qgjZU8lReiRViObFP0zKdQjwc8pibLSQgeftYStI6dOnat+zAu49GrEOHX7iuUANyQVSbRP52QgXiONCjCJoSt84kY8Y5Q13f8WGI6fAHAxOJJMKr/3zNxPjJ/+DcdEvGAiMFRohkgHe4mfEp2oV7k5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1PQW86cqaocRxf17aEDXgbu6YN2oSd9iWWgegUSp+o=;
 b=pEE2eGikD84Ip27Imj486zjMis88RNcugQmFai80ecQb065g8JBcawGXXQ7rnzGe1XE8gobDYqmj85d/1/zOo2R5wILQFwc6P2Ku4Q9QmxL3uqEqCev6fmFD/E6X5QXJtJehdRc4DgqmWf+R5KXuiU0NSDSOqe0pcq/NNkoTDsHkDS6a/5RffOyHy+7aB/A4ueEPtfgNsJZ4gFse39MeCs0JvlL3wESoJFEsZP286ZR636ehabmSvOIQnqJXFUCmgQSNtZekRSp2AoOjtVTXbMOVNvEDT1L+1Bob+hKgHnjUcT12oTym2xw8Rya40mEJozmhyqyvOiglGPl7QSlGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1PQW86cqaocRxf17aEDXgbu6YN2oSd9iWWgegUSp+o=;
 b=kM4Wi2X1GR+R4PBuAKNKy4kaTKa8PM/u3qtGEIuL7eXXf+Y9MsrhWrhnOWEzHmptNbCdZkDiSAT/e2blf3PsQ7rWTIKI6/9/pQzeM/BzkHJQh443zYil5IFAPIXKRGc53nNVfkv3N5O0LebvMatmZib2lt5ahDGAqURlMPPsfXk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM8PR08MB6548.eurprd08.prod.outlook.com (2603:10a6:20b:314::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 16:37:38 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 16:37:38 +0000
Message-ID: <b2e0b383-d28f-436e-a83c-ab58b0eae995@arm.com>
Date: Fri, 6 Jun 2025 22:07:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-7-npache@redhat.com>
 <5feb1d57-e069-4469-9751-af4fb067e858@linux.alibaba.com>
 <CAA1CXcDWX7zsW03Wwg_OHRhJ2nrt6OaLd5bn8ccX0StoN1kGUQ@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAA1CXcDWX7zsW03Wwg_OHRhJ2nrt6OaLd5bn8ccX0StoN1kGUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::11) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM8PR08MB6548:EE_|DB1PEPF000509E5:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: e19b0c37-7f48-476b-e883-08dda5188685
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cHhXbGpSdlFHdldPeUVlUUdodWxGdnBDQUJXc2RsWGI2N3NxNVZjNS82UFNq?=
 =?utf-8?B?dlkzaFNhb3dIY1o4a1o5SFB3cUNMSGhvTGNKT0l0bjNhcGM2UWt0QmhONElU?=
 =?utf-8?B?d1FMTGZ1SUtrZjRodWFWRVBXRlpiRFBRdFRkOEhBWm9QTU5Ua3VhWndsUGNu?=
 =?utf-8?B?OFZqRFVXQVdNVXBUajcxQWcxQUZKdU9qYS9tN0xWZHNJUGVCM1BhMmZUR1Vj?=
 =?utf-8?B?WjFiMlNxTHk3bnppaU9aM0V5TmdyTlRPa0pJMUNkT0RGOUx4NXd1bGJJZU9s?=
 =?utf-8?B?UXdrekFFbnkyTWN3NmdBdWQyQ1lmWVlTa3NBblBNd1NpQjNyVk4vRnZQWVB0?=
 =?utf-8?B?YnNIUGtnSW9LcTN1Q3M5dG56ZndjRkJqdnBjOTkveGlUdWtFSTl0a2NONnZN?=
 =?utf-8?B?bGxpWndoZERBUEhjWkxnRjllazI3QVV5dkc5Q1BuV2xyNE1Ub1RJUXdCaGl1?=
 =?utf-8?B?dU1XaE5nMFcyWm9VTFRKRzBKWjFBdno1Uk9Od3YrNUNPNHZSTE9mL21aMnAr?=
 =?utf-8?B?R2ZTc01ZRzRvUElkazBhbElaMkcvQlBiSlA5Z0J6SnNOVGE3Y25nOC9kK1B1?=
 =?utf-8?B?WHpwSUJZaTNZNVNPZE92dTVuU3ZMTDhYcFR1OHdJRUFTOVJJalZmWDRFK2J2?=
 =?utf-8?B?WHNialVrS0RONHZHUzdTamJkY1E2L2dvQis1M2lmUCtMYUxPQm9JVjNEMDJv?=
 =?utf-8?B?aEhZVndVV2xnMXZGMTYwYm94S3UyRmZCcDZQK3NmbEtPenh1TWd3Zng4Y3Zn?=
 =?utf-8?B?VlVYbXIvR2xPc1ozTHg5ZzZHd3FHdVA3bUxoc3d6TUxybDJOcytPclNCV0V3?=
 =?utf-8?B?VkhJa2FhS0VTVDU2cTgycTZodWpaU3VsOXc2UlREN3pXUlhLdnVTeVdUdDNU?=
 =?utf-8?B?KzNjdm1yTmpZTFkrY0NmQ3FWRmxsUFJtWWh6YUsvVVgwTjhFUWF6R3A0aFhs?=
 =?utf-8?B?U1JRSWljUzd2SmlVcTlxTzRQSkZsUmtyc2dVSEFPQ2FnaWVveVBtQ2lnWHlt?=
 =?utf-8?B?YkRibm14aG5nNS9mcGNjdVdwMW1TVGJFTUdNT09CQ0JxVWI3VjB5Ymg5NlZL?=
 =?utf-8?B?S091bUVvTVVnTGlRU1BESkx5UHNhN2hrd1luTGtYWHhzaEZIcTFGeTRsMGpj?=
 =?utf-8?B?MWJWYUdVRVd3bU9MdE9QVFB4VTdQNllVL2xkTnlUcVVqaTA1VE5qdEZ4NFBV?=
 =?utf-8?B?UjNaVy9McHIzZm42RENYKzZoZmtnSnB3SU1BKzBMNWFSWGNVZWg4VHlFWkUv?=
 =?utf-8?B?eEczY0NZMzJ2RXJRZ0Y0STc2a2prZ1VkWVI4ODV3cmtxQXJjVHhIY2tRR2c0?=
 =?utf-8?B?TVBCSjdDZUFnMmFSekliczlCUlFnYnNhb1oxOE9CRGtUQXEyZmZWOXF1OFJJ?=
 =?utf-8?B?NWthZE53d1lNTlNsdks4anRWRXR2a0I4Yms1dUNzcXl0Q0NSTjRMbWdQaDQv?=
 =?utf-8?B?enFjUytaRmV6L0NkY3hGelBLMkpVZmJxWXRTY3RKNFJxMTFWbXN1bzVvY0NN?=
 =?utf-8?B?T2VzT1dJcC9tODZBaUFZUklFWk1XcEdDNEJwZHBqN2NUMGgyZW5TOU9ZYjNS?=
 =?utf-8?B?MmFqd2I3MHA1dFJzUTVBUTY4VGJlY1JJWnhxYXRVQ1RUZjRmbTdVUHVrS3M2?=
 =?utf-8?B?TjhMZ0IybHkvL2wwbytFT1NsM00yTVg0MkUxb2JiOEhYaXg2MVdRRFY2U1pI?=
 =?utf-8?B?NXFINkp5WFpjR295UWs4bWQzNVhZSlpnL1d2Wmg1QnlqUUlwc1MyUitlRk9r?=
 =?utf-8?B?VHBRdFJPWlRGWjU4emZUQmdIZ3BqT2tvekozNmROVVRHWkJZbGNvZFduN2x1?=
 =?utf-8?B?ZXpYSVBzTlJqSFk1U2tSdWJOamM1L1h3Y293Nk5ac0dGM3JoTi92L1MvNkR6?=
 =?utf-8?B?ZjllUGtMWGxlVDI5QlFUc1RjcDFINUJ3d0lNZ2lRWTl4ci9pMzcyOUlnY0tr?=
 =?utf-8?Q?6TYTvd+N3oA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6548
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3b68462f-5b7c-4d96-57ce-08dda518727b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|376014|7416014|36860700013|82310400026|14060799003|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGg3VlA1WjllVkxwaytZWFhoUDVWazJqN2gxbHp6WVV6dE9xdTVENnhObDdB?=
 =?utf-8?B?aEZQbklKQmNrU3c1VWNVN3hwdWpkOXkrZERFZ3c0cU9CYzRYQnVUN0JoQmlS?=
 =?utf-8?B?TEsrOE84QVBsSXVUbnFiTVlqenFhZ3VJeUhDSTNlcjZoTHZ6TDRMTnJOVjBS?=
 =?utf-8?B?eEN6bVZ3NllmaG15dVUvd0JSc0JQeitWazJudW1vNDVJNHpsQnRybFF3VnJ0?=
 =?utf-8?B?NkJYSktDbE5lOTZlcTM3VWhzdWVDTzZ6Ulo2M0tFaU9ZSElzanZ2QzI3eUJw?=
 =?utf-8?B?QUE2SnVqM2pnakZYbVBSL3NSZVQ4b2RhcFIwZFBrNStES1VVWlZUR0dueklO?=
 =?utf-8?B?Vzg1aHlqQnoxUlNoZXJIOGdjYUVvQU1Vb1h6eFlKcjVOUElmU3laMm1FdGdX?=
 =?utf-8?B?RnowQzBCQWlFNkFONDJxWGU0cVloT2tWYVFBajJlYUFBRHNZczBmc0IyYm00?=
 =?utf-8?B?OXBvVXVrdWJQSFVHMGJjTm1FazN4K0gzK09sb3RhS0p0ZnlzaTlTSzV2T1ho?=
 =?utf-8?B?N2NDRjZsQUdxanZPNzlBbGJsQWhEVTF0Q3pnNVNTNEFFaXZMNkN1WFo3QVlv?=
 =?utf-8?B?bmZoRGxpdUE2N3hWWS9XQVQvOWdwUUdoWmdWK2NWTzRqQmxDdU1kRUZRTWE2?=
 =?utf-8?B?Tms0dmUwU2htTnpIUTNlRjFjUjRVd3BGN1F6UVV5REhmQ3NuTHA4YTh0K29w?=
 =?utf-8?B?cXg0eGdNRkdPNktuMXBqdzhtSTRUTXpwUnpHNU1aYjQ5WWlJbTF5dXBFVHdr?=
 =?utf-8?B?aTc1eFZJNHN2ZVdXZkduKzl4OHF0azErY000ems5ZjJDU3FpeHdVbTB5TGk4?=
 =?utf-8?B?T1BlR3V2RlNNNDNGZXFMYTZKRFNuaUhINzV6R0w1S1ZsYjhvMEo2bWpUTzF6?=
 =?utf-8?B?RXdwVjJMRWFwZDNVVTFQQ1A0YkRjUzBwVnVTeTVUL29ab1dGdVRBS0tZa0gy?=
 =?utf-8?B?d3BtOGQ0OGlmVTl4VTBHSzVXTHFjenpaeHhOYVpoZ2ZxZnhlRnhFSm42dWsz?=
 =?utf-8?B?VkJPby9XYUdwdElMcmFOTEhkMU9pUXZHTy95SzVUSHNGeUtXNmczSG9md0ts?=
 =?utf-8?B?cU9DcGpZMEFNdG1CYmhuTWFSd0RGKzhya1JyWlM1QUpwSmxXS1M4dFFZaWdD?=
 =?utf-8?B?NTdGM08zQzdZMjV1WlF6WWlzTE5LN3dRalJYL2p1bHM3K3FUZHh3eXVZT3Rn?=
 =?utf-8?B?MG5RQ1pVWUFnTlh3VVRVWGowTnA1SHlFd1dSZFgyekwxNlQ4aVRMZFNrQzJl?=
 =?utf-8?B?TVArK1cySEY1dDVtb1o5ZmZxdmtSM0tFSUpXdW1IMlBQblZ0TEI4QzlqODVt?=
 =?utf-8?B?eUt6cUlLaWowQkQvYm5jd0VZVGlpbmZzaE5OZTFzYkloMDJ5MlNyNGZsR1lt?=
 =?utf-8?B?aVp5MnNEYzVGc0pBVHFyUWpqM08xanliWmJZaDlabEgwUm80dURnY3M4REla?=
 =?utf-8?B?UjRJQUdkeFhQSTcyWjVnOVU2c29YbjlqMFVITmlWWld3NDBaZlZ0eHFaeFRp?=
 =?utf-8?B?YlZVcVU1bkxGSENkemdUNFpqbFMvNDhvL1ZqNkVRazEyZnlqa3FUMXlGMjNQ?=
 =?utf-8?B?YnI1bVlDbGQ5ZUVIQXBOMDJQa0dXVVFCM2U5c0QzOEU0TWFnMjFWMTQvdGxO?=
 =?utf-8?B?SFRaOUt1R0V3eVpNL1hTd0dJUThoaGp3b0dJTTNzczNMbVBiODFmM2Y3ekFH?=
 =?utf-8?B?TDlEd0Y3N0FnQWY4LzA5c254UExCbDEwVTRjVnZac1EzQ3R6MFFVU1M1MGVr?=
 =?utf-8?B?d1llM1JpWGswb3Z2OTB3akRNVER2R1pwTGZWNGRLcmFVVXcxZ0ZwWVpxUnJB?=
 =?utf-8?B?SXM2SzZvMmlsZUJ5ZWVzdS8rMEp1NkhGd0w1R3dZQnRlQnFwNkdBZ3FCdGg0?=
 =?utf-8?B?TWtOQWlvVm5iWTR4aENwTGplakJjRjBpbzVWa0FrbWQ0Ykphc1RmaGhGZkRE?=
 =?utf-8?B?QmJIZklkcWZ3WklsSlJwU3JCNW16N0RyVmY5ZEdIS2xNY283UDRONTVVS0lG?=
 =?utf-8?B?OGJJV0N2a1UzenV2OGE3aHJ5anRjR1VwOWtrWVJVUFNNd3UzcERUdEMvaklQ?=
 =?utf-8?B?d05FNHlueGVma2FIajhhR045Wkx4ODc0NkExQT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(376014)(7416014)(36860700013)(82310400026)(14060799003)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 16:38:11.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19b0c37-7f48-476b-e883-08dda5188685
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009


On 01/05/25 12:26 am, Nico Pache wrote:
> On Wed, Apr 30, 2025 at 4:08 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>> On 2025/4/29 02:12, Nico Pache wrote:
>>> khugepaged scans anons PMD ranges for potential collapse to a hugepage.
>>> To add mTHP support we use this scan to instead record chunks of utilized
>>> sections of the PMD.
>>>
>>> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
>>> that represents chunks of utilized regions. We can then determine what
>>> mTHP size fits best and in the following patch, we set this bitmap while
>>> scanning the anon PMD.
>>>
>>> max_ptes_none is used as a scale to determine how "full" an order must
>>> be before being considered for collapse.
>>>
>>> When attempting to collapse an order that has its order set to "always"
>>> lets always collapse to that order in a greedy manner without
>>> considering the number of bits set.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>    include/linux/khugepaged.h |  4 ++
>>>    mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
>>>    2 files changed, 89 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
>>> index 1f46046080f5..18fe6eb5051d 100644
>>> --- a/include/linux/khugepaged.h
>>> +++ b/include/linux/khugepaged.h
>>> @@ -1,6 +1,10 @@
>>>    /* SPDX-License-Identifier: GPL-2.0 */
>>>    #ifndef _LINUX_KHUGEPAGED_H
>>>    #define _LINUX_KHUGEPAGED_H
>>> +#define KHUGEPAGED_MIN_MTHP_ORDER    2
>> Still better to add some comments to explain explicitly why choose 2 as
>> the MIN_MTHP_ORDER.
> Ok i'll add a note that explicitly states that the min order of anon mTHPs is 2
>>> +#define KHUGEPAGED_MIN_MTHP_NR       (1<<KHUGEPAGED_MIN_MTHP_ORDER)
>>> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
>>> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER))
>>>
>>>    extern unsigned int khugepaged_max_ptes_none __read_mostly;
>>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index e21998a06253..6e67db86409a 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>>>
>>>    static struct kmem_cache *mm_slot_cache __ro_after_init;
>>>
>>> +struct scan_bit_state {
>>> +     u8 order;
>>> +     u16 offset;
>>> +};
>>> +
>>>    struct collapse_control {
>>>        bool is_khugepaged;
>>>
>>> @@ -102,6 +107,18 @@ struct collapse_control {
>>>
>>>        /* nodemask for allocation fallback */
>>>        nodemask_t alloc_nmask;
>>> +
>>> +     /*
>>> +      * bitmap used to collapse mTHP sizes.
>>> +      * 1bit = order KHUGEPAGED_MIN_MTHP_ORDER mTHP
>>> +      */
>>> +     DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
>>> +     DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
>>> +     struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
>>> +};
>>> +
>>> +struct collapse_control khugepaged_collapse_control = {
>>> +     .is_khugepaged = true,
>>>    };
>>>
>>>    /**
>>> @@ -851,10 +868,6 @@ static void khugepaged_alloc_sleep(void)
>>>        remove_wait_queue(&khugepaged_wait, &wait);
>>>    }
>>>
>>> -struct collapse_control khugepaged_collapse_control = {
>>> -     .is_khugepaged = true,
>>> -};
>>> -
>>>    static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>>>    {
>>>        int i;
>>> @@ -1118,7 +1131,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>>>
>>>    static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>                              int referenced, int unmapped,
>>> -                           struct collapse_control *cc)
>>> +                           struct collapse_control *cc, bool *mmap_locked,
>>> +                               u8 order, u16 offset)
>>>    {
>>>        LIST_HEAD(compound_pagelist);
>>>        pmd_t *pmd, _pmd;
>>> @@ -1137,8 +1151,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>         * The allocation can take potentially a long time if it involves
>>>         * sync compaction, and we do not need to hold the mmap_lock during
>>>         * that. We will recheck the vma after taking it again in write mode.
>>> +      * If collapsing mTHPs we may have already released the read_lock.
>>>         */
>>> -     mmap_read_unlock(mm);
>>> +     if (*mmap_locked) {
>>> +             mmap_read_unlock(mm);
>>> +             *mmap_locked = false;
>>> +     }
>>>
>>>        result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>>>        if (result != SCAN_SUCCEED)
>>> @@ -1273,12 +1291,72 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>    out_up_write:
>>>        mmap_write_unlock(mm);
>>>    out_nolock:
>>> +     *mmap_locked = false;
>>>        if (folio)
>>>                folio_put(folio);
>>>        trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>>>        return result;
>>>    }
>>>
>>> +// Recursive function to consume the bitmap
>> Nit: please use '/* Xxxx */' for comments in this patch.
>>
>>> +static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
>>> +                     int referenced, int unmapped, struct collapse_control *cc,
>>> +                     bool *mmap_locked, unsigned long enabled_orders)
>>> +{
>>> +     u8 order, next_order;
>>> +     u16 offset, mid_offset;
>>> +     int num_chunks;
>>> +     int bits_set, threshold_bits;
>>> +     int top = -1;
>>> +     int collapsed = 0;
>>> +     int ret;
>>> +     struct scan_bit_state state;
>>> +     bool is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
>>> +
>>> +     cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
>>> +             { HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
>>> +
>>> +     while (top >= 0) {
>>> +             state = cc->mthp_bitmap_stack[top--];
>>> +             order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;
>>> +             offset = state.offset;
>>> +             num_chunks = 1 << (state.order);
>>> +             // Skip mTHP orders that are not enabled
>>> +             if (!test_bit(order, &enabled_orders))
>>> +                     goto next;
>>> +
>>> +             // copy the relavant section to a new bitmap
>>> +             bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap, offset,
>>> +                               MTHP_BITMAP_SIZE);
>>> +
>>> +             bits_set = bitmap_weight(cc->mthp_bitmap_temp, num_chunks);
>>> +             threshold_bits = (HPAGE_PMD_NR - khugepaged_max_ptes_none - 1)
>>> +                             >> (HPAGE_PMD_ORDER - state.order);
>>> +
>>> +             //Check if the region is "almost full" based on the threshold
>>> +             if (bits_set > threshold_bits || is_pmd_only
>>> +                     || test_bit(order, &huge_anon_orders_always)) {
>> When testing this patch, I disabled the PMD-sized THP and enabled
>> 64K-sized mTHP, but it still attempts to collapse into a PMD-sized THP
>> (since bits_set > threshold_bits is ture). This doesn't seem reasonable?
> We are still required to have PMD enabled for mTHP collapse to work.
> It's a limitation of the current khugepaged code (it currently only
> adds mm_slots when PMD is enabled).
> We've discussed this in the past and are looking for a proper way
> forward, but the solution becomes tricky.

Not sure if this is still a problem, but does this patch solve
it?

https://lore.kernel.org/all/20250211111326.14295-12-dev.jain@arm.com/

>
> However I'm surprised that it still collapses due to the code below.
> I'll test this out later today.
>      +             if (!test_bit(order, &enabled_orders))
>      +                     goto next;
>>> +                     ret = collapse_huge_page(mm, address, referenced, unmapped, cc,
>>> +                                     mmap_locked, order, offset * KHUGEPAGED_MIN_MTHP_NR);
>>> +                     if (ret == SCAN_SUCCEED) {
>>> +                             collapsed += (1 << order);
>>> +                             continue;
>>> +                     }
>>> +             }
>>> +
>>> +next:
>>> +             if (state.order > 0) {
>>> +                     next_order = state.order - 1;
>>> +                     mid_offset = offset + (num_chunks / 2);
>>> +                     cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
>>> +                             { next_order, mid_offset };
>>> +                     cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
>>> +                             { next_order, offset };
>>> +                     }
>>> +     }
>>> +     return collapsed;
>>> +}
>>> +
>>>    static int khugepaged_scan_pmd(struct mm_struct *mm,
>>>                                   struct vm_area_struct *vma,
>>>                                   unsigned long address, bool *mmap_locked,
>>> @@ -1445,9 +1523,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>>>        pte_unmap_unlock(pte, ptl);
>>>        if (result == SCAN_SUCCEED) {
>>>                result = collapse_huge_page(mm, address, referenced,
>>> -                                         unmapped, cc);
>>> -             /* collapse_huge_page will return with the mmap_lock released */
>>> -             *mmap_locked = false;
>>> +                                         unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
>>>        }
>>>    out:
>>>        trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
