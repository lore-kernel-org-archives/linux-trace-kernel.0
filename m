Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011067.outbound.protection.outlook.com [40.107.130.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4557483;
	Sat,  7 Jun 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749306759; cv=fail; b=Gdvzs9woiBum+Rw4XLKZkxtUNXiZVrwaSOo+8wiqhSEMkCVMX4eH75knLVv19ceLR9QKgE49W4/sB6cJHH0YpcqhLcSyluI9c6M18LLmTd/W/++1FdTnSLzZ6YDToCs2eedKjk8B8Rr2NqZAIweLcy9LXABBDOjW5OChlleM33c=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749306759; c=relaxed/simple;
	bh=1+NY5A4JhBCAy1GHkt1Esy4Kz7yocBAkjXQvwCDgsWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Za4hWgCaj0ubNUDANjhqOGVIEUkDyuYBOHh7pnaSkOWHTOk6v/pXAnc9Z5IMBYHJzVNyjYTz1UqNdndj6+f1UBWZaPNoZPnJPy99wz0k8TGy6DxCyFBcWoSrRNYBMI0IkRvDfCOI0N6lxr3weKDswsMltv/krzJClBBDUWeAZp4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=do3Ag7JI; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=do3Ag7JI; arc=fail smtp.client-ip=40.107.130.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="do3Ag7JI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="do3Ag7JI"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=v0c6VEONZYnaniQCDzsBYqYwPrIDYjQGi+eD7vKS/c/N1B6JYROS78JkqaJg08+vogQlu6KxtAAq0WYDJd6E4n6h+vRXbtZIEA8zPZKtPOPiv8v7oSUEETmWHawHzCSXf0k5X1KDhJX2PsYZfuRDKfW8EI9fe6x6/qmSsC4/5qlEiIA2+WYxw+ITVTzbIHmrcBdgMtI2f5kU5wyZvTD4nqO8pdvKuRdzfunX41DFFCynhqUAoBCul3o1UxLvmEaObuYBXrYOjfMiVISbwPE4LsPe9+GnXfyoXMcgb4Xju8Y9LnTVKHxVlzpjHcEExjJApMrpo1PBFdXgwUwkxocQsg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uoppk4CSGJmN2aSzM1SHcGOiPlJ3MngYyKBOvUUKR/s=;
 b=CRIM0z9SCEzceO+MX+ZOb24+9hY0C6Crxaz4G2/k7jg+vVrBNke2uha4i27L5L9fUtKq+ZB9ZoMrBJhry8ExVGYYqb/XDE82o2vSOnFFpUprWmaVdnzeaUOAHv3T+aC53L3liiAqfuKd+K2Mznfw0T5HxqZysOppn+g2vxx0Dw63mnkJtXlsDpBfHQwLiLNUXo3tR4qgx0asJbCCHKDWCfy68pGpTv5t0ZnJ9p/LPCLHl0sLYPYXYYxoqvVZv1w9Sxj9hEtOBbSsxcDRncpG7l68dEiaaNu5MTRV/OblQllSTbYXbK2RMO8fBoRlrxvTk+vLcr7llarW1AEqpoRe/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uoppk4CSGJmN2aSzM1SHcGOiPlJ3MngYyKBOvUUKR/s=;
 b=do3Ag7JIlWO2zGyMupS6r0juIHRNAJpw1cVQY6BRDNlHIE60Ij1xxRkqH/QgPELMnLdQuEW22ZfqbxqxH4IfZuZqTNDp8Vln7V89dichIRIXjCVvonBclVyRqpbhpHirPmBZ13R78tVEDhOEVR0RKLeN/++1q+OTjk71AFN3Vks=
Received: from AS4P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::16)
 by PA6PR08MB10420.eurprd08.prod.outlook.com (2603:10a6:102:3d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Sat, 7 Jun
 2025 14:32:31 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::8b) by AS4P195CA0027.outlook.office365.com
 (2603:10a6:20b:5d6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Sat,
 7 Jun 2025 14:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Sat, 7 Jun 2025 14:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMR7Z+5uDCKw6AWc+nw9r7xe7fi4/PxM8tJlqlFZC1NFK0OZvgBbdSeQZvfBahDyP7N7pGjEQcqeuiFChoSJkOqXSyJhdtm2ZuomGY0LpG+eKwD2M9n/J8TUXJUMI1Y2sGNQ2F1Wkuih5kb0jaBLpEB1t6EG7pwRyTqzXL/WHNAtAh+Q9RF5Ix6QnWkXUDa53e0vyk18V/4APJg61w1GDO2N2ZmBJ8uqdI8LA5/ZGBIKne5Kf0gx7MB3tVWqTGt4NXSIWmTRov6Mg6OYbb9VubgqqCI1JocrkUVc8hJ6NwAaS/1sHGXVR5+wcK/EsOnjzRji27tRWOtYH38s9kp66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uoppk4CSGJmN2aSzM1SHcGOiPlJ3MngYyKBOvUUKR/s=;
 b=GzAe6l2Q8vMcdI99EOxM4H03p3cfBQXVn6bY+mJvkaIKWu4xylb2HJ+OhetxzOvYi1T7xgSCuPLB0x8JN7Intl8I/Pnv2ezijGXfb2KbscOHewKZK81TdhztzOhbuO7ex1Ldl2bgl7WInLUzQ0F4SDj86gYiZdKHSMsYXxb/6jIWWgTRVJ2JuKfDa9LdNCORxTL8t9EpgJEYHdI0MX1YNuESQIQneWihmtLBgXh/Nfb3jPNzAlHP0efAJy77jgF+NKTlxwf2eXywGRdSbm8gmZxcNqrbxeNxpjDCF6fSoPZjMyOkotqhmWzA+ZPGTNvs1gaKanPSE5O9ZzDn4RUq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uoppk4CSGJmN2aSzM1SHcGOiPlJ3MngYyKBOvUUKR/s=;
 b=do3Ag7JIlWO2zGyMupS6r0juIHRNAJpw1cVQY6BRDNlHIE60Ij1xxRkqH/QgPELMnLdQuEW22ZfqbxqxH4IfZuZqTNDp8Vln7V89dichIRIXjCVvonBclVyRqpbhpHirPmBZ13R78tVEDhOEVR0RKLeN/++1q+OTjk71AFN3Vks=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB8803.eurprd08.prod.outlook.com (2603:10a6:20b:5bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 14:31:56 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Sat, 7 Jun 2025
 14:31:56 +0000
Message-ID: <2666b1a8-12c0-475e-9aad-2fdc3e846e9a@arm.com>
Date: Sat, 7 Jun 2025 20:01:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/12] khugepaged: add mTHP support
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
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
 <20250515032226.128900-8-npache@redhat.com>
 <6f061c65-f3aa-42bb-ab70-b45afdcf2baf@arm.com>
 <CAA1CXcDVMdzNWS3maQPd3L2ZTOjnNyswH21H-BNfZpUPXk6UcQ@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAA1CXcDVMdzNWS3maQPd3L2ZTOjnNyswH21H-BNfZpUPXk6UcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To AS8PR08MB7111.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB8803:EE_|AMS0EPF000001B3:EE_|PA6PR08MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e812ca-eadd-4e94-67aa-08dda5d02242
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YmlrZXlJSlN6a2VQNW1uYURWN1A4VjlZMFhRQUp4R2IxQWR2MnZoczB1TWhD?=
 =?utf-8?B?c0pLV0lpZUFIbm5Gd3ZFVWtQWmJUVUozRE43RTlZMnRiODZ4dEpGZFpqR1h1?=
 =?utf-8?B?dVFVQ3pGbkRSblVPbUdKTFF6eUphYTdRNUJseEFsWldEcmYwbUdHWUUwMUJ0?=
 =?utf-8?B?Tjh3ZmNKWkRvVDdUeVlJM083YjdVWnhnTXlJZEE1U04rTjFRcXRwZXoxVzRQ?=
 =?utf-8?B?UzVBamRuMWR3bDRsbW1CM1hmVTRPUkptUVBvdWhsL2ljTDNiN1lTdWI2OXAw?=
 =?utf-8?B?Vy9FaXNNZWt1SzIwak1jR3hRWlRsazhzQXZPU1JSOEhKUDk2d0VMNGFNTjFi?=
 =?utf-8?B?WDJveGtFZFZabEhWbHp3RnBWZTJIQVNGRlRVVnFsamkwT3drQjZsS1VSNjEz?=
 =?utf-8?B?RVpmWi9SWkxRUlc5WC9QOGVFZUhFN05lY1dVYjc5M2VYWW9yeWNRTjBqaVJJ?=
 =?utf-8?B?bTc4UjRjL0VHSFFRT1ZzMnVRWjdNNEViZXpHOG5xY2x3am1xRGROMjA2Y1Nn?=
 =?utf-8?B?T1ZHdmlmekorNnZYY29QWlVyc1lWNkR6TFEvYTljME9YdVUxV3pwQ1FhWUhG?=
 =?utf-8?B?N3pINFcreFViOTZmYkJ4NHZxdEc1TDBML0dhRlJLOFIyNEJ2VllSZlBtOWRE?=
 =?utf-8?B?K0pLVTlkUWpEVk1jMDR1REpsVFlyN2lKeHExcnVzSGJMQy9hNzl6V01mVkRa?=
 =?utf-8?B?cFNIYm5SQW5vQjNHM0EzT3RmZ1hKV1J1cUdiemdpS0lPc08zU0p2VXpnck81?=
 =?utf-8?B?WUQ5bUdXTkZzc3BWZnpCdWFSeFMyN3U4QzFhYXpzdlpIdE5mSmdIaWtRWExG?=
 =?utf-8?B?K1hFQ0xYbWJhbW4yd0k4ckxURXZvT2h0Z2lERlVnU3BIdFNieGJmQjZYWDJj?=
 =?utf-8?B?Q2lVWTVOV3VhZTBmSGlaNllLTFJRYWsyVWh3N1VIVmRtbmMxczY4ZkMzT3BL?=
 =?utf-8?B?WUVlQnRyRVU2aHpIZmwwUXh2S0tzV3RaZkV1VnZ5WUdibGFqL0FpL0c2N2Y1?=
 =?utf-8?B?VHg2Yk1WbFFrZmVodExFVThsNGZ5VFE3MzljTThHcElhcEc0STdKdVB5ZWp1?=
 =?utf-8?B?akE1OTFTNEhCeHBtRWFVRmZBQlNMY2F0R0xiVU1Ob0tlR0Z2N1Y1T01INW9v?=
 =?utf-8?B?a1R6cXN3SkR4cFZkNGZRQjUxa0laNk5lV3ZSZTVTbXpOYWlFNk1xM2JXSDZs?=
 =?utf-8?B?Rk5jcWtjZnJBR2FTeklDdFVsNlhOL2NXSFZpWlYwaGxoT1dlWDQ3bW93bGh1?=
 =?utf-8?B?Mm1TaFVQY3doS2VEK2djdnNXNkhvVStQdldBeWg3UFdVSThGNzhtcTdiUVFP?=
 =?utf-8?B?K2VCOVNxclEySnhsRWtodU9IRndad2xkNisvTkRwYy9XWitCcTU1ODJRREhE?=
 =?utf-8?B?TDRrRFcxZDNvUytqbVhPWmd1N3liUzlHelBIV1NIa1BVV24xaG5ZeU1xTmRQ?=
 =?utf-8?B?T284TzFxaE9vQVREQmxqcytOWTdqdVZ3Q1lqOFBqSHAyZk14dHRZNmRVUEV0?=
 =?utf-8?B?dGdCL2VGSWs4OStxMUxsQ3NYWUkxQVB1cHY2dVpwR1hqUDRmVjE5NWkwKzNV?=
 =?utf-8?B?Rkx6bWRrTGNoSjB5RnBPVVkwd2xwVGlKdGVTYStnS0ZRNXVmTFNSZEpkajk0?=
 =?utf-8?B?VG1JbSt2VmJGYnV4ZE5HdnNGSEdtSG5kYjYzb0IvK1dGV0QxRVFzVVFHTmNz?=
 =?utf-8?B?aUtJRHhmdjhUbkwyamxXbkxzVjdQZDh2S0hwbWtnWlgwdDZCTkJhQVk5R1lo?=
 =?utf-8?B?YUc5d3EwZS9iZ3RrMDV3Q0NUOGxyd1RYS2xTQ1A1ZFhTajZ2MCtXcDFUU3VK?=
 =?utf-8?B?ck1qUGJXLzBZRjhsRlA4bkZxaDAxYXpiMEpRcWlXWll6QmloclFBUUhLQ1hW?=
 =?utf-8?B?a1BNUUxibllVVXU2WWhjalltTXNaZkxCdDNZcU5JZlNXN2ZBbHJWQ0R0c2Y3?=
 =?utf-8?Q?y8g7lgd41Sc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8803
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e4587f7d-bd7b-41ca-6ab8-08dda5d00dcc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|36860700013|376014|1800799024|82310400026|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU1OdU15YnFvZWFQWW1DbzJydkFMbGYvTW1RZ2pYRXF2OUxRemw0eEYwY1dm?=
 =?utf-8?B?M00zbklNRUZub0VJTGtpNlNkbW9VcUhjeDRmTGpNR0NVNHdlREk5c29NRmdx?=
 =?utf-8?B?ZU9hQUk1Vy9NNXB5cW9iUDJoUFU5eUZ5bmhobDN2N1R6S3NTeE5nVytiQWl5?=
 =?utf-8?B?VXFYeGVwcWdiL01lSnZlSjVlYkIrdUJ0ZFh1Y09pTENIWXdvL3RranI3Z0pr?=
 =?utf-8?B?dDQrOU1paFBvWlRqUEJtUVF4dnBicTA4MnRzZ2pVVUR2NHdiZk1jaTY0Tktn?=
 =?utf-8?B?bTdpNjJoVk9vVzF0Q0ljSnh4QjJKS2dXdW0xcTEyVlF3aDB4UUw3WjgxYVoy?=
 =?utf-8?B?ZnoxQXBqRDR3bGpuNFJEZUFpSXZ0dFIzZXorL0xSTlUrNTRpeTNWK0FYMzcw?=
 =?utf-8?B?OER1UW91WnVtT3hCRFhOWDhheldUZGxFZTNwSlFYRVhXZmVGZ29vV3o3UmdV?=
 =?utf-8?B?c0x4dmVNY2U2WTdhU3dwZjRkTEJJOHltUG5IY1prd2xpSDZqSk1ZeWhVYzA4?=
 =?utf-8?B?ckJBK0Y0YTFOWWlMYWJZRjNlSXozWGZBZXdyS3pHWDMxNXNnOEg4NW55aTA1?=
 =?utf-8?B?RkFpMXVjdWdHQXNXNkoxN2hmV0JSTkRHSjgzSllYTEo0b243YWxEVXFaeGw1?=
 =?utf-8?B?OUw0V2t1bmR6ZlhSWm1tbjlPWEcyNnlJQ0w1Tm90UXc0YWhSbE5lUUZ2cC9O?=
 =?utf-8?B?OGNqRVZPdlNXMlFqd0tOdU40MjhCSlVoVG9Oa0RvdGFhUUMvbmxBQVdWNDZV?=
 =?utf-8?B?WGZlemlnY29mTG15MFRJcHNSam9EUnZINTRDTUhQU0kweHRuODR1NHVZYXdR?=
 =?utf-8?B?K0ZONzQvb0Z6TGp6MEYraVR2Y3VzRk1RZGRzdHVwdnNaYmsxQjFsanFiMzY1?=
 =?utf-8?B?cWp5aVFwNWpETDhWaUhQSFRET1RHUVBTaEtsN0xMeTVDa2xyczVFOXJ5VTRO?=
 =?utf-8?B?YVpaRExSQSt3NTBObExDY1JaSmxlaEZYQ2pSZEZQLzU0VFhvQzVzcUx2bUht?=
 =?utf-8?B?RnU0VXdyUVFZNEtWU3hlbGt0d3luUEx4MlVxcmZ2Q2RxWXV5MG5Td0txTXpv?=
 =?utf-8?B?TVBsN0lXU0d6UUhVTHBWZHdndXN3RE95bmF6R1NUYjBMSU1la0o2cEJTSXk1?=
 =?utf-8?B?UDlzMXorU3RFKy8wOUx4aXlSclJ1dUVGUERWQnljYXg0bHJPbHdJZzBqeDhx?=
 =?utf-8?B?WkwzUk5ZWUIrenE5d0ZqM09aSVFFL2xPZ0FjWmhydnZQWnJjNTVpS055TjYy?=
 =?utf-8?B?NU1lT2hYd29tMjVrUUplKzdDbWkrblJjVllZUjNJTWtBNDdZSjJqd0I2UHUr?=
 =?utf-8?B?cllsLzBWZ0hiZ2pxNE42bnlGaU5ZTFZCSEtZSGVONjVoemtSOC9RempJU3Yr?=
 =?utf-8?B?ZDd0bjVpYU9KOHM5bjJzZ0V0aDg5aEY5d3JCbld5b0RQZVUzY0xtQWJFSlpQ?=
 =?utf-8?B?NWhRa3ZoUW80RThVaGkyT3ZMUkZvcFpZWVRSb0tuV3E4U1dxNUtzdjczaTVK?=
 =?utf-8?B?RGptVklyK2xHUFFSS2tRd1l1RWpIV0JhVGtjNlovQVhzRFREazBOUnJiNmZv?=
 =?utf-8?B?SGdlZmtYRjNiTVRyZjBQWHRyYVJwclZLSVJtdllrajl6TkpWcllLNWRWRlcx?=
 =?utf-8?B?cGN4emZ6T0hReWIyZTdKVURHMHVQR01XeCtyREppT1gvdFdaN0xTbWlzZmhU?=
 =?utf-8?B?UlJjRllCZFMwazg0MWUyZzNNUUM0akpSUmt1YkJJVTFyNXViNkFTN1hSNWRY?=
 =?utf-8?B?K2dDc3dmcEc3UTl3djV2ZGVsVXN4eEp3bU1JUGlzcFNGMndaclpYYkFOWWxE?=
 =?utf-8?B?M2xTQlFwT0gzMkU5ZTlhdWZ1dVp3bEx5ZGF4aTFaZGdIb2wzVFZPSUlSZ3Fy?=
 =?utf-8?B?YS8wVUFoUERHdjBzUzJaWkZhSlEzK243ZE8zeVF3MVFDdjBvWVhYMllxdnJa?=
 =?utf-8?B?Sy9UT3JSckU5Y1oyMUV3SThsNWtJZHRtZ0tiWnllTXBIODFRb29kYU5pOEdM?=
 =?utf-8?B?ZDlKcDNuR01sSGtySWVaeTlOWjF1WkhaVjhGV2VNYzNHbGU5eVdneG43K1Z5?=
 =?utf-8?Q?VFA/6H?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(36860700013)(376014)(1800799024)(82310400026)(35042699022)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 14:32:30.2344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e812ca-eadd-4e94-67aa-08dda5d02242
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10420


On 07/06/25 6:33 pm, Nico Pache wrote:
> On Sat, Jun 7, 2025 at 12:24 AM Dev Jain <dev.jain@arm.com> wrote:
>>
>> On 15/05/25 8:52 am, Nico Pache wrote:
>>> Introduce the ability for khugepaged to collapse to different mTHP sizes.
>>> While scanning PMD ranges for potential collapse candidates, keep track
>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
>>> mTHPs are enabled we remove the restriction of max_ptes_none during the
>>> scan phase so we dont bailout early and miss potential mTHP candidates.
>>>
>>> After the scan is complete we will perform binary recursion on the
>>> bitmap to determine which mTHP size would be most efficient to collapse
>>> to. max_ptes_none will be scaled by the attempted collapse order to
>>> determine how full a THP must be to be eligible.
>>>
>>> If a mTHP collapse is attempted, but contains swapped out, or shared
>>> pages, we dont perform the collapse.
>>>
>>> For non PMD collapse we much leave the anon VMA write locked until after
>>> we collapse the mTHP
>> Why? I know that Hugh pointed out locking errors; I am yet to catch up
>> on that thread, but you need to explain in the description why you do
>> what you do.
>>
>> [--snip---]
>>
>>> -
>>> -     spin_lock(pmd_ptl);
>>> -     BUG_ON(!pmd_none(*pmd));
>>> -     folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>>> -     folio_add_lru_vma(folio, vma);
>>> -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>> -     set_pmd_at(mm, address, pmd, _pmd);
>>> -     update_mmu_cache_pmd(vma, address, pmd);
>>> -     deferred_split_folio(folio, false);
>>> -     spin_unlock(pmd_ptl);
>>> +     if (order == HPAGE_PMD_ORDER) {
>>> +             pgtable = pmd_pgtable(_pmd);
>>> +             _pmd = folio_mk_pmd(folio, vma->vm_page_prot);
>>> +             _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>>> +
>>> +             spin_lock(pmd_ptl);
>>> +             BUG_ON(!pmd_none(*pmd));
>>> +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
>>> +             folio_add_lru_vma(folio, vma);
>>> +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>> +             set_pmd_at(mm, address, pmd, _pmd);
>>> +             update_mmu_cache_pmd(vma, address, pmd);
>>> +             deferred_split_folio(folio, false);
>>> +             spin_unlock(pmd_ptl);
>>> +     } else { /* mTHP collapse */
>>> +             mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
>>> +             mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
>>> +
>>> +             spin_lock(pmd_ptl);
>> Nico,
>>
>> I've noticed a few occasions where my review comments have not been acknowledged -
>> for example, [1]. It makes it difficult to follow up and contributes to some
>> frustration on my end. I'd appreciate if you could make sure to respond to
>> feedback, even if you are disagreeing with my comments. Thanks!
> I'm sorry you feel that way, are there any others? I feel like I've
> been pretty good at responding to all comments. I've also been out of
> the office for the last month, so keeping up with upstream has been
> more difficult, but i'm back now.

No issues, there were others but I don't want to waste our time digging
them up, when we are on the same page!

>
> Sorry I never got back to you on that one! I will add the BUG_ON, but
> I believe it's unnecessary. Your changeset was focused on different
> functionality and it seems that you had a bug in it if you were
> hitting that often.

In my original reply, when I said "I hit the BUG_ON a lot of times",
I meant, during testing. It was quite difficult to extend for non-PMD
sized VMAs, and the BUG_ON was getting hit due to rmap reaching the
non-isolated folios and somehow installing the PMD again. That is
why I say that the BUG_ON is important since it will help us catch
bugs early. And we have that for the PMD case anyways so why not
for mTHP...

>
> Cheers,
> -- Nico
>>
>> [1] https://lore.kernel.org/all/08d13445-5ed1-42ea-8aee-c1dbde24407e@arm.com/
>>
>>
>> [---snip---]
>>
>
