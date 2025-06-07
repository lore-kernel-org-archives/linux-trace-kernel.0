Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC27483;
	Sat,  7 Jun 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749306916; cv=fail; b=dOJfXsWbhowYU4y8MXehn4CZJ1W/U0QTiK2nnPvIzx8T2meGZfuPEYkGPt1ORZQlejJs1a3qSU7krOagnhdoIde4InGoKgf/txhIOVHuIIJVUW/jCbaneh86UZS9UlUM647P6MVme4tGM2GbGuokfR9XVKigAQKE+WfSLx5vJ7w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749306916; c=relaxed/simple;
	bh=3K7c6/+dgm95J/osdaCK7aJalVUDo2hYSact7viFTrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6TBvfWRcnjlG3lZiistuzTQOvF32liF5bASuMtPuucmXI9L+Wq2OpHLwHXe8yV0LN8TylYNdWOcA7Lm56qQLFfOM4vPaKCY3O6bUyhkqBUCIDNOf0uIjzSXDv3QqVxj0rTfLAOHQpB8CIpH5w9gt0KMTda936JzMH7BdopZ3wE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZLpWvOxA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZLpWvOxA; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZLpWvOxA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZLpWvOxA"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Jk1PJkjKBd0MFTfJ8Dre36/yaykqpOhLldxCcXl1sNaZReEAWrfsJDyZZ2SPAdHRX0b/Nqhw4sL0lQCk7JFcRebH0JVH+nOy2dTeHQfaNYaKTcLJTa+euuvj5VxIjJlaH7DXl49OlsJc3LMA4CiGYYJKNWqDh+/U7741j7KMnbsbRxln+NqBnEIQ1n0IonudLJ5XREMwhf7DaLyax+qKtBGYwsnmvaOqUTKQAnJOhdD+//U13xyf7wfhd/gsaE3vKH4LJphThSZ0PSVy17AW14jk0eJy3YB2N4JRW9lUjATg3KPiaOFU9t1Hg99m4ZqAe5/2fYG64M8VH81To1tP2A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2ohDy2SsF2AhJ0DWaOIIjbT27kMZEE+qpemF5VUT+U=;
 b=P7WD39KwNgEQJWRXZLkzWlKQt8WdcrPYh1MQ9Lp5YPq2bvbt1xtZL3aRtCwuXEU3fVaj2WNUlzkBUJpM/AJ/kYTe+OjXmI9TmhCHFGtcRYrfzk3ESVL2MlqJx6vK4xWFftX0R8LMXXzdRmr4nUWvZadkGQ9+URGgU/nKnAJOfXped2GngVl6EEnIIGuNuWBl1TiUi/a/Jd1t+9m2R+1QShxkjHp3AWgOqPbsKqHRGLYFCE2bQBlHoQbVpaSAjZu/u9n+UTU7YhYyLEJLoAcXJUQovYt/LV7dsoovQf7rd8GA9Xy7v4Q23IdVh3/o9/IE6dDMxiMWOsp5aMx5SfU6vw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2ohDy2SsF2AhJ0DWaOIIjbT27kMZEE+qpemF5VUT+U=;
 b=ZLpWvOxAapwTAdbt5nrTmm7+baH0y8ec3BZlHe+DIZ7LW6A8C36bORjkc4UmSFSOMQy5+mdnHzv532MO5aHq0vPGLbz8xTPoPzYpLiHmOo+3/VRTKEvZ8SbgMxi+BNeYl/M+dlVD8DDtzROl27Glk3Ushz3GPxfRGUszGEw7Bfg=
Received: from PA7P264CA0321.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::24)
 by PAVPR08MB8919.eurprd08.prod.outlook.com (2603:10a6:102:324::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 14:35:09 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:102:395:cafe::f) by PA7P264CA0321.outlook.office365.com
 (2603:10a6:102:395::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Sat,
 7 Jun 2025 14:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Sat, 7 Jun 2025 14:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vl8My5Axd7PsXbkbzDcXo69f2F8c4GtTng2jpaq/NKZfElpLsm3YF8xM5QzWvqYHDHsLjFWXrYjdNmbsfkCX0Ip1eYGFhNpD+FtCZ4iVCIGXjhs7mr9ncL9I3hVU26AnbJaprK1boZ75w/JepK5EpYMKPLtZSv1YzGQTfQ17gPLWGPO8jfDJSAGa4u3KiTA033wR08LNCmUfitGTYe/yF4cyfbfANUCswFZ+9ceVW0g6SgZNdIv8yMhWI/SEefBE9q1l+8OHRQNkWk9UkJa1ClCl1xohRe73ygNr7UhMwP88M1K6K/oMPicRig0yfKvMNPg3jLvb7qxsTlUNcZ4dVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2ohDy2SsF2AhJ0DWaOIIjbT27kMZEE+qpemF5VUT+U=;
 b=vergajFu5kq76WIAQCzwITb7ZXKsrEThUaUmn265CfWCmdN2xEdNXvSkpbOtfbW4J9viLSOKDBap3cZU8jmg/DtGOlDAS1+CJ3hJo9T6YuJkKtyiQXNPLJDOwOJ2uIvv0sKsVxQnVLs1B+L4LjhrA0ijTaHqy/SNJL5jhZO2CRBMDZUlMta+wgmTgfNLHcUrppW9YBhyhZjbUKxq6lTdI4ppBWNuHSsyVpyUnH6Q8SqDU9331AvouYHVFvXH4ZP3QbvoGyGqWZ0F3tNdlUflcPgXaW4QnBlMkVsrjDmkbkqZda1If9PKKBW5hW5MbMPBr5EohhCmlgpCL6o2POabPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2ohDy2SsF2AhJ0DWaOIIjbT27kMZEE+qpemF5VUT+U=;
 b=ZLpWvOxAapwTAdbt5nrTmm7+baH0y8ec3BZlHe+DIZ7LW6A8C36bORjkc4UmSFSOMQy5+mdnHzv532MO5aHq0vPGLbz8xTPoPzYpLiHmOo+3/VRTKEvZ8SbgMxi+BNeYl/M+dlVD8DDtzROl27Glk3Ushz3GPxfRGUszGEw7Bfg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB8803.eurprd08.prod.outlook.com (2603:10a6:20b:5bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 14:34:35 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Sat, 7 Jun 2025
 14:34:35 +0000
Message-ID: <b09d7553-c3c6-453a-8e3a-86dc4caeb431@arm.com>
Date: Sat, 7 Jun 2025 20:04:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
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
 rdunlap@infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-13-npache@redhat.com>
 <bc8f72f3-01d9-43db-a632-1f4b9a1d5276@arm.com>
 <CAA1CXcDOEdJRvZMu2Fyy4wsdy8k8nj4c45s4JanO9HzyJgyXOw@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAA1CXcDOEdJRvZMu2Fyy4wsdy8k8nj4c45s4JanO9HzyJgyXOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::16) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB8803:EE_|AMS1EPF00000047:EE_|PAVPR08MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5c2b47-5487-4595-293d-08dda5d0815d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QkFzUWt5M2xFaTAvK1lmWDBMQzBmaW5jcUdWbDhFQzlWUHRPOTlpcHFLdHBM?=
 =?utf-8?B?a3J2aFRsQytMTCtaR1Z4UHBGTEhMMk8vQ0ttUGNTRzAzdzI2ekppT0Z1em4w?=
 =?utf-8?B?anV5bld5L0RuTGRFYjN4SmN1K2tCZUdZQ29JSEpJY29tY1ZSUkhsamU0WGRD?=
 =?utf-8?B?NHVKUHBNYUxCTVlXUThabnlXMDNMckpvWWtld0ZZRE4wbDJhZFU4S05CNGh1?=
 =?utf-8?B?UlYzd2NlYWliYnU4dktwZTNYWFJnMERFWTZ0ckpkbFQwMXozS2Q2QjNaWnUr?=
 =?utf-8?B?UXBWai94RjJZVXRZQTk2a3hyRStZRWF3aXhQN0xQckRSQi9PMTExSGRwZkNq?=
 =?utf-8?B?UWVCVXhtZ1NKVFp2RWlVZnZJbG9sNGp5ZUFnbmY3Nms2aktnTGw4cFhId1gx?=
 =?utf-8?B?bmNZRGdsRWYwS0ZxVzNMbmt3Q09yajVCZEpaK2xDQjd6bFBib3ZwZTBuVi80?=
 =?utf-8?B?V2JNclcwdnJ3bXRqVFFMQ1NXU01tU1FGU2QraUFFZithRDkwWlVjclhlbHA5?=
 =?utf-8?B?cmk2c3hQbEViakZVUjk2a2lUdG9rMytFeTR6UmdrMWhvTFVPVVZsdnVpdFgy?=
 =?utf-8?B?T0krN3grY21BRXRlUkJ1cEo2WnhpSW9HY2pXMVM0SVZYRjdrSDBWYnZ2eStT?=
 =?utf-8?B?bVBDTXMydjR1RnBRRi9uZWhuRXdFSjlZSy9XMm5qbHdtcDA0ckI5WjQyNkY4?=
 =?utf-8?B?WjIrUjZEM2hjSnZFekR4alF4VDdyY1ltbk92YXM4M0p6TjlZMFNsdjh2UkRT?=
 =?utf-8?B?OHB4ZGRFczBsVFZTcGkxcnNjeVZOWk1ldzdFa1lpSjJUU05TOFYyWkVNZnI1?=
 =?utf-8?B?ZlI5VmpQbENxaDhrR2FSSHVuR1JybUZmMyszVCtnRGk4Q1g0am1yVTA2WW56?=
 =?utf-8?B?dVVzOGxQcXNjY0NNSG8rTnkxV0hSZG5VbWhRLzUwalErZ1VrbzRuYnVSaTd6?=
 =?utf-8?B?enJFRU0rMFJzb2ZWQ2FYd3h5NzZKUkdINWVNMkY3TXUwVFdPM0dTM25TdUY5?=
 =?utf-8?B?OHhhQ2VNOXpENnExRVFqaUY3MlBIanhaTHNHdEkxZFpoMUh6Q1ZlODZZUXFy?=
 =?utf-8?B?WFBIeHdtNnNHeWpEcFJES0JRRVlWbXl5RDRqOTZMaDF2RGcvUFJWdEJrL1ZF?=
 =?utf-8?B?aXlraGh2T2tJM1FDZTd0a3MxUlB3aXgxU1JiTjJvUWNwVnRONnNJT1YxUEov?=
 =?utf-8?B?S3k3a3VkTUJnbXlLb20wa3hyTjk4RCtqbEtuKzE2a3dEZHZwY3RGZm41RG9G?=
 =?utf-8?B?Z1ViNFNSTUZoTkJIYnNNT3FsdGVYQXVVWld2Z1BKV1Z5N3BUTnF1SUV1azR2?=
 =?utf-8?B?RUJ6UHV3KzV0T3p2RjRXaDlwb04zblVnMlhNVTRCUEZWSWgvajNMbFFRcWdM?=
 =?utf-8?B?Y1dUZlA3UWNhTEI2UjFxMUNEYmg1VzhPaU1MMWZxZWIvMEJKcHk4NnhoN0g5?=
 =?utf-8?B?WWFEcGZ4TUVUdkN3N3lMeDcyMFVvYUszSEY2WHFDU3VOdWJ3bUtoOWtUUk1y?=
 =?utf-8?B?M1N6TnVpOHpiMUZUU3o2dUpyS0l4bStuUEE4VnpiTUFyMVZob3YvZGNFYmtX?=
 =?utf-8?B?bzFvTGpKSXFUTTRtSm5jRUQyM3p2MXBwaHk1YVdpRHdqNityb0g4cTdRK1ZT?=
 =?utf-8?B?UUZ5Q21lNWFlSGdjWTUzWXRBdGhscEt3dGo4R2I4ck9nWklFNDYyd002YkNU?=
 =?utf-8?B?cERvSzVQZTFHZzdaYjd6MmMyUXkwRlVrNmdBQ2VPd2g1TGlVaXFMcGR0amlx?=
 =?utf-8?B?TW9NZE1ZNG5XeTM0ZmR4WWNYOVQvWHVMaXM0OXNWK0dBYXQ2cktydnVtdjVS?=
 =?utf-8?B?enZiamcxNWZCd3BYSVVjc29FWVIzWlI3TmVEbDQvRnFTOGduWnM2Zm5yVVB3?=
 =?utf-8?B?ZnFQbDVPV3FNeHNRR095eGt6RkVISHJ2dlU1V0N2TGJkdk9FUExwMG15dGp5?=
 =?utf-8?Q?vZkBebGZWRI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8803
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	991603cd-da90-4b9d-b476-08dda5d06c7c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|35042699022|82310400026|14060799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzkyMkdNTUIxTTIzRjJCMHUxRXNjNjZpOUpCWkw1Q3FFUU1xTkQ0VFVhNUo5?=
 =?utf-8?B?YXM4RHM4OUV4UU1sMGRWemFLSDJnR0lpN2NNdFBqbjRzcE9YSEsxU0hKQVFz?=
 =?utf-8?B?TVN6cTU0THR1dFRJcExQWld6QlNub1Vqa05oKzRMcWorQ3czQ0xMOUJ3Mk44?=
 =?utf-8?B?Uk5qaUhMNXBRcTZsYTUxbXJHZXA4NmNobzBKcmJDMVFPN25wa09GejJXdUhl?=
 =?utf-8?B?S0FHU2NMbGZwRUJLYlVlNzEvdlZyN2wwcW1ueGo3NUlUOE1OTHkwUHYxeVFj?=
 =?utf-8?B?dkJsZEFwSHVjSmRmS29qaEJNSHVtdmprOHZqbFZsMklqYnlvY2tocXpNR2lw?=
 =?utf-8?B?OTJpYlpNaXgwNXc5NzMrZ0x1YWJhQzZqU1owck5VZ3l2WDd2WTFwckRyYWEr?=
 =?utf-8?B?ZlNnYnp0MC9xN3F5Z2dUS0ZYdzFESXF5Z3ZNQm1ybGtBNzdOVXM3Unk4ZThk?=
 =?utf-8?B?SmNkMzVVdGpNOVVKNWs3aXdtUUVwbk8wNjZuNS9mRjcvQnBOOWZCbThkTnhM?=
 =?utf-8?B?dElpdU42c052VUZWK2pKR3FIWW1nc2pqWXlIcFptSWRmK2dKdDhSUmRpZjlI?=
 =?utf-8?B?aW53L2E3QjhyZm82UFZscjh6K3VIU0ZUMTJtNmNpNDJUdkVPSFNXd2U5YmVE?=
 =?utf-8?B?V0RaY1hjQXdLTmphTzYvSlUyOE9UTXhzNjhWbGQrQ1IxYkVBVGhxRzVwbXRN?=
 =?utf-8?B?cXFUczZlc01xOWdlQkhRZE5MbUk4MGtaMSs2emZWWTcyMXR0NE42RnZ0ZGlT?=
 =?utf-8?B?eDlEcnlnbmI5di9Yd0dlWFA3U3BEVWRvOGZST3oycWF3eEYwcXdtRUQ5bUpZ?=
 =?utf-8?B?UGhOaHNRNDdSSlpGemdkZjlWM2hjbkQwRkxpd3BtdmV3ZVVaeFp2MXRrVEFS?=
 =?utf-8?B?YzFlRXF2WU5nVW9KS3JJYTZRamJQcVZsNXlGSFA5Q25SSm1XQy82enhFWlA3?=
 =?utf-8?B?Q0RsNktkUy9KRURWaUM2ZTVXMUVIS00zSFlFRmJsamZKQ0JrV0J3bVArNU9t?=
 =?utf-8?B?ek94aGdCc0w1ZmpZbWVpWlVNQ2lDRzZIVGFSWDJGR05EL3JDYm11YTQxc1k2?=
 =?utf-8?B?K3hIRTdza0o1RVpFVUtmZXgxaG9GcHBLWEFIUGRMWGx6d0M0empLSHhyendY?=
 =?utf-8?B?VTdZTUtET3NUMGNIVzdiNTZ0MWhxWGFVQ0NvY0JWTWJJUXdYL3NtUS9tVzA4?=
 =?utf-8?B?dmRlYmVJc2k2WGNoL3Z3MmVxd3cxNEczSXVsNmx4MGc5RUtqeUpqOUxpSFlR?=
 =?utf-8?B?TENxN1ZCVlR4cGlMY05TY0h5a2o0UUltc08xTWpmN2gvcmFrM1o2WEJhWEp6?=
 =?utf-8?B?VjM1QWtYUU9EY2ZvUjlSR0RUVmp6MWpFS1VJQnIyQ3lMZUYrcHlhK2I4Mmtq?=
 =?utf-8?B?UUFEd0puMUNmdTVKUkJ0a2FVZklhbEorMnk3dElHMzgzSzFlTEViYkdNR2pH?=
 =?utf-8?B?ZXJFYU5vS09TWHFGcnZZNW9jRGdzeURocEJXTlBxL2tOV0xTYnRyR0xwbkUx?=
 =?utf-8?B?YTJTQ0tteTdWUkx0a29YckZqeldEWkZxYUhGa2ErY0NmRkdPZnVzRmphbWtw?=
 =?utf-8?B?YktGV3N2VWxObUZ5V0JZaVdncEwyeFMraEdiMEUyOEplZ2RRT1Uvbllxb0Ey?=
 =?utf-8?B?S2g0YUVwbzJVams0a2FVbS8vZ0Z6QnY1QnNPSXZKbU04VVZ5ZXR2bjFJNnAv?=
 =?utf-8?B?MEVLRHc1Y0p2aGJDbHVRUTdFVkNYeDZwNHNtOUkvcDRTYytmekdldHNqcnhn?=
 =?utf-8?B?ZWR4amhVTXZNVUZ1amxiZzlVT0RGcElnMTg2SGc2ekE1clVJUlFiNStHdmxO?=
 =?utf-8?B?WDAwbk94MDdxK1hoN1Y5WFhib0lEQmxGaTNJN3dvTnlBWFpIaXE2Q0xvUi9u?=
 =?utf-8?B?TG53WTdTbE5wcGlvSytvU3RXWUw0RnU3Q3dPNEZjL2dSSkxJODYvTDN2b0lH?=
 =?utf-8?B?b2NUSFY3K2lnVUZvQUNFT21HZ2xPaUFRMG92MXdMUmMyOWE3Y3l5bFlNSHYv?=
 =?utf-8?B?SXZyNnRoNXFpV0RFNnlvRVVyOUt1UkIrdmhOTmlWQTI0a3lXUG5mbTJJcVdh?=
 =?utf-8?Q?oaJy2F?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(35042699022)(82310400026)(14060799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 14:35:09.8102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5c2b47-5487-4595-293d-08dda5d0815d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8919


On 07/06/25 6:27 pm, Nico Pache wrote:
> On Sat, Jun 7, 2025 at 12:45 AM Dev Jain <dev.jain@arm.com> wrote:
>>
>> On 15/05/25 8:52 am, Nico Pache wrote:
>>
>> Now that we can collapse to mTHPs lets update the admin guide to
>> reflect these changes and provide proper guidence on how to utilize it.
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   Documentation/admin-guide/mm/transhuge.rst | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index dff8d5985f0f..5c63fe51b3ad 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>
>>
>> We need to modify/remove the following paragraph:
>>
>> khugepaged currently only searches for opportunities to collapse to
>> PMD-sized THP and no attempt is made to collapse to other THP
>> sizes.
> On this version this is currently still true, but once I add Baolin's
> patch it will not be true. Thanks for the reminder :)

You referenced Baolin's patch in the other email too, can you send the link,
or the patch?

>
> -- Nico
>
