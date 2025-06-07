Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D711CFBA;
	Sat,  7 Jun 2025 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749277447; cv=fail; b=Vtlt3SE6dMxXYKm1o3Eulzf7x5+3MWPe86VNfzAci9pvNf3tNLDD8WvlWqMEdHMd432HdkiyhAg8mWwQqtzv6D+dwXEan+jLfM3GXPlF8+8V95uhgr34+zvyTl0W4pSDyXWEKFdkMswBTpdhpB8fE4Zv4AbHokt+0ebqBKsOIls=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749277447; c=relaxed/simple;
	bh=NcWbyXAdz+6fGOv2uUeREyB1dNCak5f7j/aMjn0+Y6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CUuuTD7Oo1GiVFX9tKzMEFfjsTkhHADy6jYDMdM3N0m+xy3fl84fL9xw6oI/NHhcZpMRymDM5OsKks3wIn4TzrOs6ejZ61yg5IufjZiOF/1ovdbPorBWH5qvQuM7GYu9KH00e+TsDznT9psu9nIRPXOFi4d1+Zn77JycWrX9fwE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lr15OnA4; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lr15OnA4; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lr15OnA4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lr15OnA4"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DO17Qvug56wUMzyHZFwD6Ptd5NqSQ9hP40dzCrmThkq4vGLuj1EDG1DxDRuq9t1kMvdY1jAJsHigQsvPoCCvM1eIbqiQjRuggNE30nnRERpmpRfIC64yR1IxNlSVyWyBtyBayAdhE3EwDLqc0gj371pY3DQ8aprHIOwgQQdfJlEBvFDRqPdmcVtKq4j0sF2CpWnLcMtV8E9HYtMVN/tK4W/gH0TPTXAybF/6dizI32JMHdmbABw3+2fj49AGms30wzd4U2KCoOmZCvwQWf+/qlLLT0y5uVGKnvM0xkXmFgJ49ADCqnl8OfCNyTtVI96SpsiiyLScv+AeDTOux+rAGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pue4ZWYTd7ri4DiWXSnlDQX7gZ4CjHU7phs7l9k9JmY=;
 b=lPi3GCM4AtR8n/hmqC3mAoW1VzDgVDiGmnPwXVV1S9jinokXaixZbTli9eZSQ8B4LLy3TRQS4hJhvz/lal9ZL6o9rxLYBf0JnFIMEdtXfvu/08Vl1P+ZTQCpPuzMrOq7jCQgnZMRPcnB2MM20FaKS75+pDBUdsRZjD+JxpNXQgnI5G0ALZeqs98C1e6Fag9vgkIuDELORcroIDcsP5BoHvY5YLeZ95NCTTwhRKiXT1R18dUTVTgiV/ChlWQH1ZinChoBnX11Iy/Vjz1ZVnbUSQIe9JgmNwaNStD+c3DnVZM5dZQK3MsABpHQ9VBMy/jW4Q77HDdSWHgTySSKSfhBxg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pue4ZWYTd7ri4DiWXSnlDQX7gZ4CjHU7phs7l9k9JmY=;
 b=lr15OnA4tjg97lE58wCrmLzOO+HLlGpcpXWA1czVWU82vFimXaX6WSwTaj21XFtH7CWzdF17gPThwcGlibcnIHz3dAL2aXbYUWYlv3/xYHK1Ma9I3wrjl9/AB9utgf5ty3ZUxGMMOXcXqgS5wQo2aPsS2fL4y4/QielLFCeCk4A=
Received: from PA7P264CA0176.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36f::13)
 by AS8PR08MB6632.eurprd08.prod.outlook.com (2603:10a6:20b:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Sat, 7 Jun
 2025 06:23:58 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:102:36f:cafe::a2) by PA7P264CA0176.outlook.office365.com
 (2603:10a6:102:36f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Sat,
 7 Jun 2025 06:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Sat, 7 Jun 2025 06:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsLBDPOy0fT/YZ2dpIn7l5JbVTdjjkwZRYwAFihYffP/mvJ85oHejvjIXwWp09DY9f50YUVTe4DiRfMdy4j/kxr40coVUde8ELkYfE24XWzG7Ot4HgCa0B7svCeMUInY0CaTaVF5XKhM0cDsuTsxTmI3unZ0JJGkpgNwyBCqd0VboMtTicV1sfu2fXRH5LnXdFx+qLkd3tNjqpcC7qzWnt3R91qGVTKhb2xfYSKREMUP5sQXNzLhkjMq+r4jTS+DX1hRLvbSManBr/vbmA5g5Xc+GKYMzkLryIiAEKWHNNO6EW3RciaQajnF8maT09/qlWdVuHpZlz7faXO/efVV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pue4ZWYTd7ri4DiWXSnlDQX7gZ4CjHU7phs7l9k9JmY=;
 b=MGYpcrzmHpENIqDPsACWEgpGplb4yDDddqXqk1hrQuGoQPY7jW7J/jPNRgorgDZqkLOYSU86sNujeCWHkJMhkzweQQatlcIM6uT+j4YsyElFUUG3mi7O61kvj4+p3Id81sw+z363gu2NKzLB7DR3ALAJEEJJqByAB/PenDaJbaAvhWTuy1+q8U938WQYN/whCFp2UNk3XPaMixbISCE25wquJ6U9SyNeRnhCdjOkFCXjw9k/VU1TzPnBOw9bCdNZs5ROPBgRQAhI5ENdW3PI7Q7nisxm2WHk4vcCZY2toUIdcXdxbJeZUe4Gga8dNl9dcAI3LrMyNy0XiQ7fsDfoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pue4ZWYTd7ri4DiWXSnlDQX7gZ4CjHU7phs7l9k9JmY=;
 b=lr15OnA4tjg97lE58wCrmLzOO+HLlGpcpXWA1czVWU82vFimXaX6WSwTaj21XFtH7CWzdF17gPThwcGlibcnIHz3dAL2aXbYUWYlv3/xYHK1Ma9I3wrjl9/AB9utgf5ty3ZUxGMMOXcXqgS5wQo2aPsS2fL4y4/QielLFCeCk4A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB8PR08MB5386.eurprd08.prod.outlook.com (2603:10a6:10:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Sat, 7 Jun
 2025 06:23:25 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.018; Sat, 7 Jun 2025
 06:23:24 +0000
Message-ID: <6f061c65-f3aa-42bb-ab70-b45afdcf2baf@arm.com>
Date: Sat, 7 Jun 2025 11:53:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/12] khugepaged: add mTHP support
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
 <20250515032226.128900-8-npache@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250515032226.128900-8-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::20) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB8PR08MB5386:EE_|AMS0EPF000001B6:EE_|AS8PR08MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: c10ceac4-56f0-46d1-da4d-08dda58be2a9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dGVkK01qVVR0eTB2ZlZwUE5TbkxtdHJkU3dtTjdiaEZ5MWtqWG9uVnRtNGhN?=
 =?utf-8?B?SXl6c1lja09sbDZpWGlsM1dWYUhSMzF5Y1J0S3RITlM4c3RkM3pMRWFoZ2gz?=
 =?utf-8?B?WjJUdjQ1L1JzUlVraWQ2bzAxMCtLYnJ5VTFZVExsTWFaemV2MXhoTzFzQ29t?=
 =?utf-8?B?cGZBQTZLdElUQnRYd0tlZTBMbklJb01Pc2kxdzlvODVXdFBud2dXYWpwdFZu?=
 =?utf-8?B?Y1daSjVPT0VraWFLSG9ydjByMGZkUmwvQmdlNzAvbUoyN21rY2lVeDRhZDZp?=
 =?utf-8?B?RXVCd2hNdU5SOEtKTFZkQzQxQkZIckVEYThtZVhRK29TR2ZSKzVEcHlySGRj?=
 =?utf-8?B?b25nVmM2NjJoMHhDb1AvYUlLbHVEaXZGUVhSb09VZ1ZidTJNUmdjQ21VaEhF?=
 =?utf-8?B?RGtLY080UjBKWEVlc0R2MWFIdmNYNFRlUXJGcjRMQmxvdWNQeDhpa2FVei9q?=
 =?utf-8?B?b2FKbnA2UVEvR1hzUG1MTGNOTSsybk1KbWhpb2gwcUEySFkzY1hDS01najRB?=
 =?utf-8?B?V3lGTGd4YVFGdkE3VEJBdlZUOFc3TmJPek41aVQ4RGVUc1YzLzNtQUFUT1F0?=
 =?utf-8?B?cG1YSFJxOWdsR0JhMjdsZTJGZkZGaDkrck0xcUo2cXhJZ1VtbFM3TytDeG5t?=
 =?utf-8?B?OUtNSEQ5SEovR2NDZmtRZUx5N0xDb2ZSejRReGVHSFM3cnMyTWhCUy81blhh?=
 =?utf-8?B?dGhpck1GOHcrMkJmdHNDLzNRR2FuL0d6QWpQdFZ5eldkcHdML1BjM0NqdkQ0?=
 =?utf-8?B?Q2o3Y3JjekJ2YWlyVnlrcWoyUDZqdTJ2UUtwVTR1OVVEYURKdFA0V2dSR1lE?=
 =?utf-8?B?R0VzZlBsRmxCTk1HUTJWVFNuWE9KRG1pYjNvL3A3WW56R2ZZSHJEdVhGcGNp?=
 =?utf-8?B?SzNETzI4ZXRHaDUvc3ZEUUtsdDJ4SytZdkprVXBhUktqL2JqekYwckxsd08r?=
 =?utf-8?B?Q3NPeXltRTlDekt0cVcwZzNtQ1M0c1RzKzl1Q3FxOUVjK0d2a2NPVTNmdndW?=
 =?utf-8?B?WG9rODFUenVqTEhQMGtFUzJCTE5pNWo2MUlqd05yK1dNQnZnK3U5SnB3UWhz?=
 =?utf-8?B?aXc2VVdHNTFkTnViQlRLTU02bEwrTk16RDNBb05Xb0d4RUdaN3p4VWhCSWl1?=
 =?utf-8?B?dnZINm5hU24wMDVnWDJRS3VWRytpNVR5eXFaUkJhZVhtSWYrWGZRZFhsSG01?=
 =?utf-8?B?RU9EZ3FKNVhuckE5WlMxTDZGWWcwREo5V0dhbWxkSlpzRkVXMG9vNWp1Vll4?=
 =?utf-8?B?WkZhZ25VYVBTczZscnpDNWp6UUFuVlJxaGtDL1BBVEE1MlZadXpRUmNHQlVj?=
 =?utf-8?B?TUZhWElsT282ZDBPekZTbll2RndUTUkydFByWW1VNkxndVNkNmJaa1E3NzZL?=
 =?utf-8?B?ekc5dzNtNjlabE5HOEhQRlYyYy9OZzZMNHFlNzRyOVQzNHV0QXprdnZvT2xn?=
 =?utf-8?B?MVNtTzR3S1l1Q1JUQnNPT0wrdExKaGNNcWE5dWRhMFNEbi93M1BWMDVFdUpj?=
 =?utf-8?B?a3JrbkhIdzdEeHZqMG1hS2tFNWRQRURXMjJWMnFWbE9PVkh1bHNpcnRPd1Zm?=
 =?utf-8?B?Slp1QStCMUIxWEVlT0hrZmc4TVdIL2FPY3ArL3pkSVlFQTlVaTBjcCsrWTQ1?=
 =?utf-8?B?czhFQlBQcnJiQU5VcVJhQnVFQnpaOUpPZXhVaFdldWZVL3h5YVN1MWFxNEZP?=
 =?utf-8?B?UFZDL2xoYy9HK2pYakNmSFdsaWQrWUl6eFRUUmM5RC9JK25rWFd5VG9MNlAr?=
 =?utf-8?B?cHpSMHpUR3RtMkVCczRaa0REcUd4c0ZFT2JSOVJCb1RhNlRGUmF4SjkvSkth?=
 =?utf-8?B?NDdocHE1L0YySVBZa3FOak9DQ2ttQVN0UGZNcFZxSDNlRytDenY1KzRnRXJl?=
 =?utf-8?B?UlE1VWlQQTdlaDdoYm5WQkIzYXgxaGNNVFduMUhjQ1VCTDg0ZnRBVVBFd0F4?=
 =?utf-8?Q?xA6GuHK12uo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0d13d552-aa42-44f9-edac-08dda58bce7f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|36860700013|14060799003|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnFwVVdCd1dNOVRVaGEwaTRCWFg5dWNTbG1YSUd6ZjY0SGltRlhmaVRJdmN6?=
 =?utf-8?B?Y1dZN2ZjdGlnZnA5V3VFK3ZFR1lwcnVKRjE5dm5wTm0yYnJPTkNMMEFqcmFN?=
 =?utf-8?B?OWl6VFpQelpIejVkMWRTTTBrNUpCSTZOSkdzVkd1QkJXT1ZhNnl3YklxNDJY?=
 =?utf-8?B?MzdEdllBcEdiWCtxREhWL1ZSTVRpYkZKbGdONGlHSFNnOGxqVVp2V1cyY1ZF?=
 =?utf-8?B?UlpXdnZLbHpta3MwOGo3OFlBUDZJQndlQ29vMFAxdGJFUGdvRkc0K2JCcFlv?=
 =?utf-8?B?Z1VxVU91QitFcUU5SW9BNm5rTk8xSzVQQ0dsaEpRZGxOMXRhWHlEZVVPZ3hl?=
 =?utf-8?B?a3NXbkNxZjlzQUd1YWVKbUg2WEY1cnVIeEl2KzdoamhuaWtFSm0yOEJVNUhp?=
 =?utf-8?B?TGY5OTN1L1pmUkVTSHdxMUFaaFN5SllWN3RCYzBOWXRtVHJzcFgvbGRaTHVw?=
 =?utf-8?B?d2drcjZMcnF2OVRtUW5LSXR4cXJKYXNteDJ4QUljWmJidm1wdkorRmdTdDVo?=
 =?utf-8?B?YThYUmZ1MVFEczIwZitFQVpaZzcyZ1BhNEdwc0FXYU9WbEphUWZWS01FKzRm?=
 =?utf-8?B?MFlqR0Y2YndFaEVKRzBmaUZEbnhVOW82WElIR1hKRU9STGdjL3I3UStFOTRp?=
 =?utf-8?B?bmk5bkdnV05ESGZVR29WZ2gvT3hnM0E3enl1UHFaVytLL2F6TjF4M0hXeWlB?=
 =?utf-8?B?bm9wT0NGaGRlR0sxYndpUnRoTEdpWmliSUQ4U244TG1FNmNETTZOZmlxcDVV?=
 =?utf-8?B?MTRIUFVxQTA1TGlXbTlGc2t5MjJucmE4a1J3N1EzMTFiZzBma3VVVEFvb25B?=
 =?utf-8?B?SFhkbW9BYVMvWXdqdEVkaGpMRy9QYU51WU1Gdno5emtZTHo3ZnBZZEJuVmYv?=
 =?utf-8?B?UnJuQ3dHZXlhb2tINnJhcER3WWt2MS9GWEtzTWtHcS81b2dQaDFaZmVWRVZ4?=
 =?utf-8?B?U3d5cFpBV1hYMkJHU2N4U0o4Z0JudExHRGc1RUJSTnhtenZDcG1sSmNDeHd4?=
 =?utf-8?B?SHEvTmdOTllBUy85RTF4MHZZdCtMOTJQOFN0RjZkcVE3cUd4VEdTL2Jqem5o?=
 =?utf-8?B?VUxZODlVSElna0tpang4QWVHTTFUK2VjdjhtaUlZem41MmpKVEw5Tis1Q0JQ?=
 =?utf-8?B?dkNFN3VMcUxyWGNaUFJOSXY5RmRUMXlmaFVaZUZCV24vQll6dkdHV2ZOZENy?=
 =?utf-8?B?RlFoelY1Q3o4QmpBZ0dVSjlpR2JKb21wRlRJUU12SzRDMFF3RWM2ZVhEYllt?=
 =?utf-8?B?SkRwTzhXL21lUGwvS2ZOS0JKMlZZWkUvbXdkTDRTUTZGeTgyYlpOVjR6VmFu?=
 =?utf-8?B?UDdQTG42WkxxaU5weE40NURWV1dQdzYyenhaUE4zUkpzbWI4V1R5QnJleXp0?=
 =?utf-8?B?amF5bCt3L1ZzY3Z3eVU2Sng4YVpYcWNpcDBVcElaT0ZqZXQrL1RzSHBkZUxv?=
 =?utf-8?B?QURqb2F6LyswbHAydVk5amdvaVdJTHRRaStjOVdUcjFVUEcvTHhVdlNOdnFa?=
 =?utf-8?B?UzFxb0RqcmREaXAwSE55NkdVRnF1TXpxQ1lCWjlpN3lOaTZKY3Z0RE1vTG9q?=
 =?utf-8?B?THdNNUZtVkFmMjJpVk90WDh2M0F2UVVscXpsMy9tWEMrMm44Q2ZISG9xMElr?=
 =?utf-8?B?dklyS1FHT2hmZGs0MkM0aDMvOUtVa1FrZTAzSHdndE9UbStUZUJvbllvRjR0?=
 =?utf-8?B?TVZUSjJ0eEcvbDdHU2I5bFE1YmxqbVdCaTNUZjlubGFKVngwOW12eXdGalZB?=
 =?utf-8?B?ZlpuSURrWnRqcVh6Z0cxejU1SVFSMHp2QVczb1pkYWQ5YWZYbTVsR3Y4OWha?=
 =?utf-8?B?eGNaV3UxbEd4YmJJMHBpZ2xkN25uNnlmSTJYY1gvSnR3SXZZR3RIVzFZbDNq?=
 =?utf-8?B?cTNmTjJVMS9UVVphS0o3dWdEQXBzRXJBMDd3cGhKV1pnWks2QWxUQ2J6L2s1?=
 =?utf-8?B?NmpMSVphMThkejV6R1o4K0p3c2dmRk82SEVMNUJzVEVOeGVXem1kSXBFWTBa?=
 =?utf-8?B?N3RoM0ZkWFV2aGdrOGs0OXo0Wkt6ZnhFNlREdUY0M1JhNHVyRGx4ME8vVnNU?=
 =?utf-8?Q?vHjnlq?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(36860700013)(14060799003)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 06:23:57.7799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10ceac4-56f0-46d1-da4d-08dda58be2a9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6632


On 15/05/25 8:52 am, Nico Pache wrote:
> Introduce the ability for khugepaged to collapse to different mTHP sizes.
> While scanning PMD ranges for potential collapse candidates, keep track
> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
> mTHPs are enabled we remove the restriction of max_ptes_none during the
> scan phase so we dont bailout early and miss potential mTHP candidates.
>
> After the scan is complete we will perform binary recursion on the
> bitmap to determine which mTHP size would be most efficient to collapse
> to. max_ptes_none will be scaled by the attempted collapse order to
> determine how full a THP must be to be eligible.
>
> If a mTHP collapse is attempted, but contains swapped out, or shared
> pages, we dont perform the collapse.
>
> For non PMD collapse we much leave the anon VMA write locked until after
> we collapse the mTHP

Why? I know that Hugh pointed out locking errors; I am yet to catch up
on that thread, but you need to explain in the description why you do
what you do.

[--snip---]

>   	
> -
> -	spin_lock(pmd_ptl);
> -	BUG_ON(!pmd_none(*pmd));
> -	folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
> -	folio_add_lru_vma(folio, vma);
> -	pgtable_trans_huge_deposit(mm, pmd, pgtable);
> -	set_pmd_at(mm, address, pmd, _pmd);
> -	update_mmu_cache_pmd(vma, address, pmd);
> -	deferred_split_folio(folio, false);
> -	spin_unlock(pmd_ptl);
> +	if (order == HPAGE_PMD_ORDER) {
> +		pgtable = pmd_pgtable(_pmd);
> +		_pmd = folio_mk_pmd(folio, vma->vm_page_prot);
> +		_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> +
> +		spin_lock(pmd_ptl);
> +		BUG_ON(!pmd_none(*pmd));
> +		folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
> +		folio_add_lru_vma(folio, vma);
> +		pgtable_trans_huge_deposit(mm, pmd, pgtable);
> +		set_pmd_at(mm, address, pmd, _pmd);
> +		update_mmu_cache_pmd(vma, address, pmd);
> +		deferred_split_folio(folio, false);
> +		spin_unlock(pmd_ptl);
> +	} else { /* mTHP collapse */
> +		mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
> +		mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> +
> +		spin_lock(pmd_ptl);

Nico,

I've noticed a few occasions where my review comments have not been acknowledged -
for example, [1]. It makes it difficult to follow up and contributes to some
frustration on my end. I'd appreciate if you could make sure to respond to
feedback, even if you are disagreeing with my comments. Thanks!


[1] https://lore.kernel.org/all/08d13445-5ed1-42ea-8aee-c1dbde24407e@arm.com/


[---snip---]

