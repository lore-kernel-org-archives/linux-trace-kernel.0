Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867B1F9F7A;
	Mon, 16 Jun 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091790; cv=fail; b=KAtXYGs5yQpVJEeLd2U9yKd1d+hB1WiVnmBXrt4kpYvzrhk+m2PJee71OJHivmVOLgfNvMb+W2rwxgo8yzNd23n/uS+Tm2fmg3Awc9X6gE6kStPAZQ3MR6dxiiqdTTXo/un4X2IA69FGIkZNBakcQpn/rPJRVhDtO6r9cIfNZQY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091790; c=relaxed/simple;
	bh=m6CnK/EjbxiAdq5ZtmOfrc3F3ASrMbbm3QYnxk3Z89s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9EwUrDx2AVDshflZ0BiRSDr/WzNYRA8ni+bKaFwDE5RhSsMDCN66ZIbORHjpnVk6Zd0aO7PBM5RRbjZvaZNTga7tHZMDwjoCavBikvMd+K1IxZukN9BsjaL0XyI/qa0xkU4AI7HxGy4jMpLL9FIHGP2rcjxJIuvWD6/QnRnnKo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M00RNRrB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M00RNRrB; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M00RNRrB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M00RNRrB"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VCTEXuY7+8uTaHg+A6XFk+k3C2fIuLcrE1UnyVwzgQvAvJw0j6U+zDWI/Ked5qYoPaUJ15J/Fz4jyf/fFdvKA0EBIp2p7yM4Iw4wbvtaa9BTW7eJcVRaPy0WUnH62eQGOJyZ5cOwo1RBQUVbOeFHqg4AjW4pIkH7/hlDrx9rqeA0SmLVrg9x3yoVUyDI8k4RqIp342m+GM2pVbziUYIFW6nfTxkie1D7qPF1AM5svql7WJo0Up9yQohPbjRzJBSJ1YINCm/27TqW2trJ4erV9VpIECDcVZRL/MDUAAvMt3Zyh/3u4/0aviSoTGfQ3GqCVPC+ZL9HT1Ioqz3MZlCFSA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6CnK/EjbxiAdq5ZtmOfrc3F3ASrMbbm3QYnxk3Z89s=;
 b=PtngzMmEFoOTY86zZ368ciigi+H1QuRLPPP+oShPNBOkh3wY3wTg81oDuLI29Mc0GR9m71FG6hHhL2LwyG+ANysXlFFeAVXIPogcB/B7XTFkpWX4/sO2AOrqGzL4JXcHykHs/QLP4doDt+BOcy796odFzrq10dURdhOHZ+3d+ZwS9/j0wSbAxvjdx4qFYXx+3xyvzfi5U772OoylQ0c1OtlljJYuAH/qnBTv1EFZ7+yalIQt10XdxeruyIa5l6WQJNXWotjbzUSb7rVjKhIdE+KrEfviKXaAPT1MVyhHqr4aBok8pOnAs6Zka9WlscQF4lCLkoXjSTJxuoi1JsFy3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6CnK/EjbxiAdq5ZtmOfrc3F3ASrMbbm3QYnxk3Z89s=;
 b=M00RNRrBKbUg9ikbz1fbeFPxjFzI4fSIwCv7r68U2IGPG/NwudxgLhR1UHPuguxJ7iHiHWId5ljB2upm1lXF3WhLVA9aWyNudOm+8UtuK22BnDrQBFRRWubQHNrGbppEM+tl6zd8pkF8NJAYCWQZzc3lIHSi7ELEYI1qJUHme7g=
Received: from DB8P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::27)
 by AS8PR08MB10271.eurprd08.prod.outlook.com (2603:10a6:20b:629::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 16:36:22 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::63) by DB8P191CA0017.outlook.office365.com
 (2603:10a6:10:130::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 16:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Mon, 16 Jun 2025 16:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFKirNE+PcLE1rE8ycmoeSTte8NNSsp+ki4V35VZxc2p3Flu8+Y2xMZqoh2hmHzsCEXykEJyy3HnEhYOVTZOq3etDonBYebvwF0O2vgqnYCSKOs/qkZwUnkBt9WMfzkKbDTaQpqXQLOgEyTmxsice84/w0mGSrRBEb2ALOhRYGZ0lrrdKFzZTqk64+boJ7claQpyAtYgO0dVszvuTEF5P456CakQSPyHVfQlvY3f50FVT80y9wGQ0iOcttdOKdgTblllO/BcdjefNLHx5kvw7nyqBIEiFFCrSQM5GqlRSYWNvbyOlcaKpGyKrgaJyymkjqLmrBzi3S0QMPUNqxF0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6CnK/EjbxiAdq5ZtmOfrc3F3ASrMbbm3QYnxk3Z89s=;
 b=DuK87tWjJj2ZBaydTUnDTlzuyLL0lU3FnbQ6hh5yXtuxFbBzZSI2da/gD1CoK3JRP54m3//3dleAyH4N6F3NGjadOKQeQsDcqgr1kr0+Cpg/dyABefZdWuofhHICTc5HlFSijX3B+nmt1dU5TNW+HUFsNFADzvpkR7vveTEqiNYmXp336oTqRkf3LbX2eBUSYbO5z3MA1OUoZYX/jlNf2RvQZflNrGmIVO27NrRAzWqG9qPLVK9Rl+IKxLVMCMc8Dw5BMCsdfkEpRMhRsQ8vwxyzQTZDHiRDd/2LZFqxHsfoSI3XzuG+FdFXBDYJiP9XPtlMhDWM+ins5OB2e14tOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6CnK/EjbxiAdq5ZtmOfrc3F3ASrMbbm3QYnxk3Z89s=;
 b=M00RNRrBKbUg9ikbz1fbeFPxjFzI4fSIwCv7r68U2IGPG/NwudxgLhR1UHPuguxJ7iHiHWId5ljB2upm1lXF3WhLVA9aWyNudOm+8UtuK22BnDrQBFRRWubQHNrGbppEM+tl6zd8pkF8NJAYCWQZzc3lIHSi7ELEYI1qJUHme7g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB9370.eurprd08.prod.outlook.com (2603:10a6:10:420::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Mon, 16 Jun
 2025 16:35:49 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 16:35:49 +0000
Message-ID: <c42a21ed-3a79-4ac5-a68d-bb4fccd28598@arm.com>
Date: Mon, 16 Jun 2025 22:05:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] khugepaged: mTHP support
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
 <8621cd4f-a206-4440-9b02-52e9277ce212@arm.com>
 <CAA1CXcD=MOEfa6XBp3+e3dSMCmgfx0NgB0DgnxRWTAS-KKZx-g@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAA1CXcD=MOEfa6XBp3+e3dSMCmgfx0NgB0DgnxRWTAS-KKZx-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::15) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB9370:EE_|DB3PEPF0000885B:EE_|AS8PR08MB10271:EE_
X-MS-Office365-Filtering-Correlation-Id: bace4387-1aba-431d-6fea-08ddacf3ed2e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?L1BSWHJQVUt2RHUyTDFxQ0V6ckVHcnVpQnU4aWU0R3lmdGlOd0FDTHU5dHAx?=
 =?utf-8?B?NVJ1SFNtaWJmZmpvUTd5eEhvbEZnZHVWNlpBWGxzK1FFUVF3YnVMTDJiUHdl?=
 =?utf-8?B?cHgzcVA2b3pXT0thWkpCUExERTltN000OTREaFVLMzhsNDVpRy9ieXNxNzZ3?=
 =?utf-8?B?QzhuOG9JSVQ0dktJdk1lR2JNNDhlVnpxMkpJZjF0c09keXU0NVJMM1JqNmVi?=
 =?utf-8?B?bFhObUNNQm95cW8vUi9uRWt0VTNIckl3TE5hWmt1ei82alFTdVpIbmx5VG1H?=
 =?utf-8?B?M3I4RFVsSkxkL2FoMG5OaUp5QjFoUWZhRHJEeG5JV0g1YUdBZ2QvYzY3dGNs?=
 =?utf-8?B?UzVsOUtzancxR3YrbE1qdWZqdmk1UEZ1c1pwZ2J2N2Z6L1pBMVN3TFl2Tjdx?=
 =?utf-8?B?OUo1Ui9ncEc3SWNENzhJeHVndS82MmNmVDRHbENMempRVDMrSDhCN29TNlYv?=
 =?utf-8?B?bm5YQ1o2NlNaVUREWHhiUkg5RTBiTkRaa2hJczJtdk1ISldzTEVaQUJyZzF1?=
 =?utf-8?B?UGxlY3RZakFMWG5oYjRjcnVXNXQrNTNFOGViUE4xTTU3bjgyOFNMZmZxb3gv?=
 =?utf-8?B?RnVDSXlnREllYkVHT0srT0xXeDBwWG05RDZCOXRoM2U3b2ZhZ0o1cngyYU1M?=
 =?utf-8?B?dWtqQStZZ1pCbkVmQ1BBRjc1aCtDM25vcnlqUG9uYUY2VURUeFptVUl1ODRK?=
 =?utf-8?B?RGlXaTlzZFZZTXc1UC80dHJPbGcyVkNERHFnNVR5dUpidVU4eUZ3b0JNLzFR?=
 =?utf-8?B?dEIzL09CbDNlWjROTzdiWWdCN1gvY2VHN1RDY3FsaGlQemJodEFLSGxheExh?=
 =?utf-8?B?WjZQZ29YNUQ0YWVZcUQ2K09IOEwzc1puSUdFSVllNDd1YkVBaDRFdmdDU3Ay?=
 =?utf-8?B?RExjRlhESU5sVFB5Sms5V1F0T3EwYXozZDBkVHNScHFTWWJEY1JBQTVJRS9U?=
 =?utf-8?B?MmtrekNraS85dnlSQ2lPc0Jha0V0cVZ0cUF3ZjZOcTI5NjlQTnZSOG95Znd1?=
 =?utf-8?B?ZkZwMFpJZXcvdDd4SVhyL0orMGlwa25Vc1hxdFdQSE9rT3MrUStpV0VTaWE1?=
 =?utf-8?B?dnRlN3NzOUV1N3R3L1RTV0FnT05mT2NUdVhTalE2aUZIb3V4UWQxMGdrYTd0?=
 =?utf-8?B?eWlBNnhoZ0J5UEcrL29HR0dOeExnUDEzK0JJUm12SDB1S21oMk1oMzM4M1JW?=
 =?utf-8?B?SzdQaCs2RGthRUQ5ODVvTGF1aTRRTTdpSlRDSXFVb2ZiUlF1SUQ2WXdxclFE?=
 =?utf-8?B?Wno1a2xzbXJJRVVsYXJxTVdLZi9Qc2N4RG1HdC8wVldaYlp2YksyTndiZ0hG?=
 =?utf-8?B?TzVFdHE0Z0FOYzF0d0o3bTdrSEtyVkVjSkpNWXlyV3VKM2orNnErcW9TcmtQ?=
 =?utf-8?B?c2gyQUZhTk12alo4K1dnditMT0Z5NklYcndlUDhvUDRFMzRqcUJ0Z1lvMmZk?=
 =?utf-8?B?NS9iVkVhcmxVN25rMGZCVzA3VmswRURoQVJIdE41aHlLa214anhTK21iMGZ3?=
 =?utf-8?B?cWl6NWZheTBXbUp0WXFpWXZiSFVIblgvQkNVY1F6eGJQZ3ViMGw0NC8zNWll?=
 =?utf-8?B?bkRBUGVkQVh2YUN5TmVaclZhZXExYklNTHBDSDBmL2JaL2d1bm9HR25pNGho?=
 =?utf-8?B?cTl5RVdRSE1Vb0lEbTN5ajFXcnA2WmxYTFdrRHpmUDZyWkpURTV1ZXZOdVZ0?=
 =?utf-8?B?RlpKNnpuMEFqK0l6L25nNXBxL0tkTUorVStGaE5yZytqMWVwbEptcXRaWldo?=
 =?utf-8?B?Sno0eDhEelo1bmdNU1pBRW9GbFo4YVNYbnduTGNSY1BTaSsxOTB5V3BBT0xp?=
 =?utf-8?B?cUQ0b2V5NnhaR3lQSm9IbXZVSkMxZ3FFUjBUL3pkZHpxcHpDMklIUVZZZ1M4?=
 =?utf-8?B?TDNrOGRKZVBJZzJVdkVvWWxSZGljVEVkQVVvN2orUGUrckFtbU9ERiszSGM1?=
 =?utf-8?Q?MTSs3Of/N6U=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9370
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f4c195b0-735d-4750-6f58-08ddacf3d9d8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|376014|7416014|14060799003|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2NaQStQek9qQTA4RFk1VFNuMmlxdU9TSGZSakVzQ1JVZUtLUlU3VTZPZDJ5?=
 =?utf-8?B?Tk8rUUFhMWhJbEJUdWQ4NTFZOWp1M2tEcTYyTmFDUFJsRFVXdXdjZTNuNzlo?=
 =?utf-8?B?cXRFMEY3b3pVWmIzbjJ4U2hkZ2lCUXRhYml1cXBVV0hIb21lUDd5bmZkdHl6?=
 =?utf-8?B?R1ZhbGkvbnNldkxBM1BRR1RndGxoUXN3U2lIZmFaYzJ4QmpDdTRuU1ZYcTJs?=
 =?utf-8?B?ZDY3Qk91bVFTSzVjZFNFUENxYXR6dmRxYzRDVzJPSGI0UWdWUjY3VURabXZv?=
 =?utf-8?B?UVAxQnBqWVJDNFVCNkVBaG1FUXMva2lvZWpkbzYrQzhoR091dkRLaHlKSnEx?=
 =?utf-8?B?Vm80NHh0alVZb2FQS25FNnAvLzQ4Wnhwd0ZPTG5CdW9sWDNsRHFhNG4wa09w?=
 =?utf-8?B?TzRaZm9ZVUNKeXk4SDQ5Y2NWWUFScnBwdTF2Q09RZWs4M3hQRGJuYllzM0Zo?=
 =?utf-8?B?N2lWQ1dGU0dEQS9sR3lGWDNMVnRPWUZSczlKSDUvdXFianVMVEYydFFHbkhG?=
 =?utf-8?B?a2l4bDljdFdUZm9McVdrWnlIZE02STJTR0wrVTkzU1VvdmRmbVJFeVhCUzdn?=
 =?utf-8?B?U24vVWROTUhTdG1WaDVkU2twL3V0Wm0ybzAxb3ByS3Q5UENyTnJDN1V0Qmhm?=
 =?utf-8?B?Rm9EYlpMV3JaWExGWXprUVpiNmdPZU5HNFVndlZqR0o4bjJpOFI1MzNVRlZV?=
 =?utf-8?B?VDVld25XZVg5RWtJNmY1aEtDQTMwU2JQRjdINHlXalJsbVcyYzRCVTJNeXBC?=
 =?utf-8?B?b3BCaUtjb2tGT3BKV2tIVExQcG1xc3ZTejRYTkdjZHVrdWhGaElKTE4xVm4w?=
 =?utf-8?B?dm9aWlBCRjRONzI2OUVmeC84RGQ2Yi9zQjZCKzJYYW1QcnE2VW9XRXp5V29L?=
 =?utf-8?B?QzYwemgzQ0MvZ3AzV1NVR1QwNGZvUkJIMTNmUzJiSEVIRUNVK3NtYi9XZWFi?=
 =?utf-8?B?R01HREhaOHZ6Q2VpcFUraTFxbm5EY1VtUi93LzB0STFmR21IbDdGdnFKN3By?=
 =?utf-8?B?cEVxNjN3WGJDSUZPSDhIbWdaYjZsNWFGRGtuRU9mWWVlVm5wOEE3d1YvTFR4?=
 =?utf-8?B?MEJDZ1dWUEVkbzQ0UitrRlR2Tk9tVUk5ZjVmZFcvdFZVVG81ampOdHdwSGND?=
 =?utf-8?B?UW5HWFZYVnFuakNqQnBVWjlwaTJ1bUNaR1RkbjFDTGp6YS8wby9FQVBFd2hO?=
 =?utf-8?B?TWtYSHZpOUwzeHYwR21jTHgvSG80cVRDeEJFd0o2SkxSNkNjem1ianJudy95?=
 =?utf-8?B?aURXOEc3K2tmSmhKYXpURGY5elpXeWJyRmxCVld1eVFoZjRpK0FOUENxYTRu?=
 =?utf-8?B?Z0ZhSUlocHF6MVdhMUVaZ0ZOLzUzRjVaMHM1dkhMVk1JRFdPL2tMbjh3NFpv?=
 =?utf-8?B?aGdxWVN1MzNhRnZvazU0Q0tqNkpLZHd1Zkp3bjcyZG1nM0pGZytYVXJrOHUw?=
 =?utf-8?B?ajdJNklNbVNkMjVRV0pnN08wVzkzSU1FVHNER2hUTUtqYlhvblp6dWdoaU81?=
 =?utf-8?B?QTYvRjIrejFZbGF3Qm1oMHRGdWlQWUJNZlNtWE9DWnJNL2xJejFzWEZSYVlS?=
 =?utf-8?B?cVUzd243bFFyQ1Q4SC9EVmw5UG1Ud0tKRzNxb1NUQ3ZLREg1eGE5S0hpQUtU?=
 =?utf-8?B?UTdRNUZ6cmdxcEVHV2U4ZjY3M0FnWWF4bWUzcmxCRGgrZmtDbzVxV3d6d0t0?=
 =?utf-8?B?MU9MVmtBdHlFQVZiRDBnajNNS0xtNFB6bGRlakpjdUFKY05HV0NpN200TURL?=
 =?utf-8?B?WUQ5Y1JkU3loUHZEV3FPUC9qRHRENGZoZFBHNDNPMG1aVFdqaEJ5R3NaRHRs?=
 =?utf-8?B?ekRuM1ZYZUQyVTlHZXFwNVdRNzR2dHFmM1N5a2pOc1FidlpLeXdxTlZTQVY5?=
 =?utf-8?B?ZW5WMmJhNUdzUzB6b05MQ2Rta1dnTXlDblk1cHFEMkVyZitTaHdnbjlRMU40?=
 =?utf-8?B?bGtPNU54QjJqaktlelhYbm1zcFdwb25Bd2JZRGFzUVdTSU9ldVJaR1h1STd5?=
 =?utf-8?B?YkhpRGZPN0ZZajhGNnFiektjWmhJVDlhMVUvdVp3bmVraUw4cWhZRTZKZFhr?=
 =?utf-8?Q?cx3Hrz?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(376014)(7416014)(14060799003)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:36:21.2034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bace4387-1aba-431d-6fea-08ddacf3ed2e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10271


On 16/06/25 9:21 pm, Nico Pache wrote:
> On Sun, Jun 15, 2025 at 9:52 PM Dev Jain <dev.jain@arm.com> wrote:
>>
>> On 15/05/25 8:52 am, Nico Pache wrote:
>>> The following series provides khugepaged and madvise collapse with the
>>> capability to collapse anonymous memory regions to mTHPs.
>> Hi Nico,
> Hey Dev!
>
>> Can you tell the expected date of posting v8 of this patchset?
> Hopefully by next week, although it may be longer (as a try to catch
> up on everything after PTO). We were originally targeting 6.16, but we
> missed that window-- so I need to repost for 6.17, which we have
> plenty of time for. Ive also been releasing them slower as previously
> I was not giving reviewers enough time to actually review between my
> different versions (and this creates a lot of noise in people's
> inboxes).
>
> I'm also going through some of the testing again, this time with
> redis-memtier (as David suggested).

Sure!

>
> Cheers,
> -- Nico
>
