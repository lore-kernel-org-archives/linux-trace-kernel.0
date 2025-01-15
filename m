Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC068F77;
	Wed, 15 Jan 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971949; cv=fail; b=O0HGESEzniikDHXAaZCny7jKzsJKqglCZY5i992BSbhipbHvSpLNXRygA7ZOoQzZ3bMSgzcG8pbTUyuLQmiTHpBx9DWc9ze+piWQfK/wvxxwi2005zqvsXwnpefy3Ue3CZB38pJY+Lbn78mdPnaohKP+bo0s+5ss8YLvz0kY1s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971949; c=relaxed/simple;
	bh=awXyZjQ3pCqVuhS0HUImR9HKOjUDGrEKBR7MQ39cmSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bx9tdgC3zvPafoLI4+ZaEzwd59yQ3/5AdxvKfNmzPGZ966XRC7etTecoQcag9jHI2412k6+zcUaaIm5bWiT/Ywvd/pqBCs9bjyOqyG8WhvHuawmeq5yoaY8GL7A+0vVig9Jhx9jNZEBByMkk6Y7Hu+tqTjo4dLg/gUuLME6yeps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gAoY3LL+; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gAoY3LL+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPV6uJutQQXsagYRLixaq8VXseN2rMYA01Fn00GAnqbp29O8ke8zTigimFL3xo1rxdhiRhz8K9iLHk8XI+hbwTyshzYOTsb2B6bZooRqFtdJNXOH6SQ0sgOPHd99c72onwXguaeVyYGGRJVjVR6BPwy3x+1S+mfKEmiJ0eNHTCifPkUgLKc5akN8Db6Paw2AIxxENI7mT+UjNIGIbAlUcvN4vUUBhRezuGLlQJOxJfhhhTw1H0md4vP2PZY1jNltXhKNVtkziiB9TF+69dF0q8bf4+c2rSCFr4QbNKKNMr/LXhMsz7p0I8HmOF0K4GmsHdavKM8TjnlUrm9IHhumxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gmNDHlKOH2Mde389sjJS/2Lw9FRvlY0pojvvZo6RXU=;
 b=OG7CN6owwlJILdALVKXBsWoDlm4RCfm2A5UF7lmDF0SN5cH4/os2y60cxvhYKbg7Fwya5r6vZfq9C1WHlk7Ckgf2VRBWrbVpC5oxFbAfTdNc7YARyWGTIQHFKRFVbtucrhzyEOv08eWDxZvzM/hU/IeuU6yhkrA5DnH0Yes8Cawsma3uREvfhJ/vw0CX3whV1Mrt9o89XH6HzgMwHu7pfEXK/1M9VjI+SWX7fQ4On1G7kNnR4rKYLQIGwbB+WK3wyVTAMsxMntIdkztXaZlSPl/chGBwJBwKj18/WUvAagpLa0xJyOtjnrUlqVg6d8q7C8t6oCrpshOqHCXJC1LxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gmNDHlKOH2Mde389sjJS/2Lw9FRvlY0pojvvZo6RXU=;
 b=gAoY3LL+By8D+rCutSEc4b7MUTy2YA6vgXZ2G7852LpLee7OheE5CyPseS6Etpd2JibJwLQ6ECJqrWmA9IWw+iDzOFmvTzisCrUqDruZUBoFeX6bx0BIOUOHEFsIDBbbydA9xXDS68+dhfxp123zbjZuqt/o4xGgmunpFSgZQB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 by AS2PR08MB8574.eurprd08.prod.outlook.com (2603:10a6:20b:55d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 20:12:23 +0000
Received: from DB9PR08MB6650.eurprd08.prod.outlook.com
 ([fe80::f628:7b8a:8001:a01d]) by DB9PR08MB6650.eurprd08.prod.outlook.com
 ([fe80::f628:7b8a:8001:a01d%6]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 20:12:22 +0000
Message-ID: <9582878b-1ce7-4fc4-9b45-b72bba722f49@arm.com>
Date: Wed, 15 Jan 2025 20:12:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: Introduce DMA_ATTR_SKIP_DEVICE_SYNC
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
 Justin Chen <justin.chen@broadcom.com>, Jonathan Corbet <corbet@lwn.net>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Petr Tesarik <petr@tesarici.cz>, Michael Kelley <mhklinux@outlook.com>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Eder Zulian <ezulian@redhat.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20250115194659.618438-1-florian.fainelli@broadcom.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250115194659.618438-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To DB9PR08MB6650.eurprd08.prod.outlook.com
 (2603:10a6:10:26d::23)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6650:EE_|AS2PR08MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 31621f18-35b5-4499-28d8-08dd35a0ebfe
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MURPT1Zkcy8reWpQakhtK3lPNmNaendVbmxnbUM2NHhPU1lEMlVsUVROUkg3?=
 =?utf-8?B?NlhQdzRYUzBpbGg4NTNnL3A1ako0SUtjYXJ5Qm9pdTVzVHFsYm9RcEh1Ui9X?=
 =?utf-8?B?RjdPdkxSUGtEZThubjhhZDJObXV6TytHemlTUGJpYmo1RmRqeitzWkUrVnR3?=
 =?utf-8?B?dEN2QnhocGErYjZTQVE3Q1pMd1RyWUdSRXU2M3RGUHloNU9NTFN3UW1iVXl4?=
 =?utf-8?B?eUFlN1RGazd2S0ZvajhTRFUweUN1dWNvNGd2TGgxYmtUd21NNnBjUFYvWDZw?=
 =?utf-8?B?bkc4Z21ObTZ1NmUxSWxVWWJVaE5IOHFkVVpodFAzN0JCYjgvSmh0cjd2U0p1?=
 =?utf-8?B?eU9KU09FNEVZeXhWVmZ3UFpmTVlEZks0ZHU1bVo4UGNyV1RoS0VmN1NDblZ0?=
 =?utf-8?B?RG03ZWhGdHgvRHZhb0taM3BZeWtJZDRheFdvMk5GQjVtc2R4YzYwQ0RtZ0hN?=
 =?utf-8?B?NDNOUS96MlZJT1Byb1JDUHdEVDJzWURNbWJqRE9JcFlYai9nNUR5TDZTV2hz?=
 =?utf-8?B?czBsdTVoWVVDSjdmdllxT2xPSFo4ZnFIYmxFZ0tUS0pvSFRRa2hyR1hQRW1T?=
 =?utf-8?B?OExJL1RSUWpmRFAxZEVQQUpCdWovdlNCMVhoemJZeEFJOWVqbDRlaHZPVnh0?=
 =?utf-8?B?TjRrMmlEbXdOWW9xTHpuZTA4UVVRUFcxSjFreTJSNUl0M2RtQk1PK2FPaUZp?=
 =?utf-8?B?Nk5wSkQ0ZTYzUUE1SHl5eElkNTA3UjJaS3lvOUk3a2IwbGZtQm5DYlFDanlU?=
 =?utf-8?B?MEh6dlZOZHpiRjhibkNIRElhL1hldlVnQXkyUGJyZ0lkNWRMd0hQQzVLcXdP?=
 =?utf-8?B?NlFOVmQ0VWFpRDlnTkpubE5YNUpTTm1WRFAxN2hVd3IwVTUxdzJXS2NlMWlI?=
 =?utf-8?B?L1pubGJwU0JzVXZrdGdUTkVQUHBNY0NCWVhDK3gvUzkvem1OS0FrQjlKcHE4?=
 =?utf-8?B?SThHbDBxNG1LeVlUMXI0UWZ5eXZmZTF6LzE5bnlTZXo2b3k2WUtaNFdlWXo3?=
 =?utf-8?B?Qnc1eW93Yjkyb053cytLVmFjTW9sRE1FMTJKY291a2ozOHdHU0o1eXZGSlFC?=
 =?utf-8?B?bDUzRXl5KzQ1TllFQllwR2xHeVQzbXIxQitpNVVNOFNxYTJmVWJDR05mTGg1?=
 =?utf-8?B?bU9KYi9aSHNSNlF1N3JVdWxmWU1YTThYUHY3cFB3NUVTUVlBVXVDcnVRUzJV?=
 =?utf-8?B?bmIwM3lWQ1J3YmVsRWtrZDFLZk14aTUycEQ1V3dvcXdPTm5BR1owWmtkWGpU?=
 =?utf-8?B?UExFaHRnbjNjUDRlenU2OHI5ck9hZXpIdWlUVHJFS2FKbDNFVzV1TndNNmNR?=
 =?utf-8?B?dENmczNpQkF2Nm1pUjFmYlk4cER5SXFPeHc0ZnphK1NQZUNyUkVhdkVrdmpl?=
 =?utf-8?B?WTlua0JsZWxTMUYvU0ZUanlaQjBRbWk0dXdiNml1VFlKSU5tRHZRUzRZY3dV?=
 =?utf-8?B?ZnhjdGhmSGVvZWpKQlkvY2pFY3pMb0h3aGM2eGdvRTZUa29EYlkwQTdYNk10?=
 =?utf-8?B?UjVxOGJCb3dPaGhpVWdnY1hKZmhlYjJxS1AxbWFEVnQ1OVNZakZVTkg2dDB1?=
 =?utf-8?B?b0lZYjB1UEs5ZnVjaEZHSTdDYUR5eG1jaTBMRWVUc3dLY2ZqOENidWEyMXpw?=
 =?utf-8?B?SlFiTERZT2FmVHo1UmU0Wnhwd2VQWVpuSFBTaHRPNlRnQ1BjSDZiUDlTVU9j?=
 =?utf-8?B?WGpKVjNWUGVyWTVJVGpLZGlFKzF4K0JobjNIVVN0cllCVktmMjk0ak40RFp0?=
 =?utf-8?B?RVBwQjVEdWVnT3FYYVpaQVkyazlkNCtyb05xcWh1dTVHbHpUU1gvQWdxY0Vh?=
 =?utf-8?B?elVOeFJiaHhFTXc2S0JrYnRZNXN1R3pZd1dZSGZ5RktCMGRzeHZGbjFqalRh?=
 =?utf-8?Q?z1Wb1Q137ueWz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6650.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anp3RCs1cENxT2Y4Vzg3bzAwWUdzZ0Y1NFhYSzBUQmVlWG1tbzUrREcxSWJB?=
 =?utf-8?B?WTdDYjhQTU91Q2J4NTBVNW1BQTY5bnltWFdMMm12c1RkTnNhTmF0QmlMMXJK?=
 =?utf-8?B?ci8yRnRKa3BKTWRMaHBlenBrNVhlZmJmd3dvU1pOU0Q3dkJyMFJDZWdLNzhs?=
 =?utf-8?B?cU9Ea0dHQTMyVmFzY3FXT0NlTkxPblFodUhNOEE2VDlPV0RyUnlNMlgxd3Nn?=
 =?utf-8?B?ZW9vQzRBSmNnYW1yWEljSlN1Wit2dmFQSmlJcUtqYVZQMTg5Q0EzUmF3YlJT?=
 =?utf-8?B?bEQyeTZYUy9wN244NkQ0aWV4QWR6Q1lEMEdTRXhZcWdDaXcvc0ZUNTBZM1lJ?=
 =?utf-8?B?NFRJYkwzaGJxdWdlclBUQ2JpSlJzeW9vb2VLU21tVEY4SUtFakJQakhKSkxy?=
 =?utf-8?B?cCtERGRUUDdzbkcxNEhJUEhXUFVqWkRLNGpHRjliU2RhZTJQRUhSUUl6RDNF?=
 =?utf-8?B?QWhVT2V4M2xwTklyQ0hvSStKR0w5SG91UUw1R3NzN0ZIMWxObzQxUGlObGl3?=
 =?utf-8?B?KzVUVC84YzVYYjVhdTN1ZHIyT2pqQk5BVDVBbTFzcVpDUnA0RVdGaTUrcW5o?=
 =?utf-8?B?dldYMnRoZ0g3OW1tUDBqdktNdkFVOGRUVEZLcldTTEdrd0lYYjgvNlhLVlVV?=
 =?utf-8?B?T3hJRzFMaVhYb1hpRnVlR05STU5zVjkrSmZONmZCTlpRb1hZb0hLOXgwRXF0?=
 =?utf-8?B?bjQyUVZUbkFtNEc5S2pFbVUwZW5FUHdrN3NhRTRXbFczU0JGSFJKZjNpRCtX?=
 =?utf-8?B?NmlWSkcvOFh0RmtQOCtxQS9ucFd5U1lnZkVDaXVZMmErYXdaWUpGOUgrSSth?=
 =?utf-8?B?TEhydjg1UmdDUnpVT3NXY3pPZkZZTkJnOVhaamxaMC9lNE5NWEtHdE1MV2JC?=
 =?utf-8?B?VHdGMzhMNGIraUR2RlZLaW9oaHp2NHpQeTRlcVB2bU9iTmtIYy9ucTBId2c4?=
 =?utf-8?B?MmkySEp2djV2a0dwSUhCRzd2SHZrR00vSjZLWUhBRlc3UThUMXRlOTdEc2J1?=
 =?utf-8?B?b0NVS1I5bWFGMVZnbEF6c2N6cWxPWGd4MXJIc0dTZWZuU1hydWkxTEVld0Rs?=
 =?utf-8?B?b3c1NUxBVWxKcEYxOEUvb1dGeXdzSllxbngzTGZwTXQ5cmR2SjhuWjVkQ09r?=
 =?utf-8?B?a2hRSHFVUldESTdEQ1B5ZUhKSm9vRWtEZGQrdmpTdFVFcGhpUVRBcTY2d3px?=
 =?utf-8?B?ZSt3TUZSRk54bFozRzI2K3B3Q1dGSWpKSW80dDNsRFI2dFk1M0VBZ2FENE9r?=
 =?utf-8?B?RjdsczRQLy9ybVJHQVdzOVRTQk1MYnd3UjRQMEVHSG9vQktBNnkvOXNKZHZD?=
 =?utf-8?B?Y0VJeFZLK3ZRdjhnRXRpV1hIcktLWWNORFhzQ1hqMDZaUXVuZHNXRW1KT2JF?=
 =?utf-8?B?S0dzd3pqRHVkaVFabjFPalFwSFgzNmdIQU9RSVdydE9zL29MU0xJUHFYOEsw?=
 =?utf-8?B?eEZ0SllQRXNSdE9LQ3hqeUxjQ2VMM1h6NHpEanM1ZzFWWXBnWHgybjZYOFBZ?=
 =?utf-8?B?TFRHTTE4OEFqUDFyaWVSaEFkY0Y2OFFHZTdxTXRUY25yRmJVRmN2bnFkQ2M4?=
 =?utf-8?B?K1ZJSmk5UHBqbmdWcmxQMWJnZEdYcGdZcTNmUkFrQXdEdGR5L2RpdUVCNVAr?=
 =?utf-8?B?MEN4WFVjdVppM2NZSXlWMS9iY0h0Y0RTK0kxOTM4VGN5eEh1NFdtZjB3TXBB?=
 =?utf-8?B?cXhWYVR2UnpUTzBNMlhjVU5sSDNjVEpYUFdnU1VneVZGS1djUmQvRVFyWStI?=
 =?utf-8?B?TUNpbTJDTWtHZU12cmk4czNCbFJXT3ZkMHNLMlNCUGx0TzdFZUM1NmYwY1l2?=
 =?utf-8?B?MnBvalhvenhiVmsrWE8zNFVpazhDOWhReUlPOU1rSzlIZnE4Q1QvUlJwZEZU?=
 =?utf-8?B?aEozUndFdWFrby9ITXkvY3lqOTROV1VVYlV5SE93dU92dnhiZ0FBTWNhWmVW?=
 =?utf-8?B?RWtzVmlmZEFpSHd0UnhzRnQ3ZU5wbTBidGI3Q01MN3BlVkRkOEpBRG5rZmZW?=
 =?utf-8?B?dnpWZHpXYVZJNkl0NTNQaXNqNStuUFZTc1hacGJCOW53UFpqM2NTTDRxRUtk?=
 =?utf-8?B?R0JyNnlXeWpPeGlYQ0RVTU92ek54M0l2YjkrbDVWWFNnakVGRE4vQ0JHK1Bh?=
 =?utf-8?Q?OlqPAZx1/H2MmnD+9FBza2oWX?=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31621f18-35b5-4499-28d8-08dd35a0ebfe
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 20:12:22.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1e3bc6Ip8LodG2H3BrNHDJ4qgkSW9+FXby85RqYymX9Jyk3WYUBgLbhkThOanKiGbKr2yM0khHPoZHR6OrBaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8574

On 2025-01-15 7:46 pm, Florian Fainelli wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> Network device driver's receive path typically do the following:
> 
> - dma_map_single(.., DMA_FROM_DEVICE)
> - dma_sync_single_for_cpu() to allow the CPU to inspect packet
>    descriptors
> - dma_unmap_single(.., DMA_FROM_DEVICE) when releasing the buffer
> 
> Each of those operations incurs a copy from the original buffer to the
> TLB buffer, even if the device is known to be writing full buffers.
> 
> Add a DMA_ATTR_SKIP_DEVICE_SYNC flag which can be set by device drivers
> to skip the copy at dma_map_single() to speed up the RX path when the
> device is known to be doing full buffer writes.
> 
> This has been seen to provide a 20% speedup for Wi-Fi RX throughput
> testing.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> [florian: commit message, add DMA-API attribute flag]
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>   Documentation/core-api/dma-attributes.rst | 9 +++++++++
>   Documentation/core-api/swiotlb.rst        | 4 +++-
>   include/linux/dma-mapping.h               | 6 ++++++
>   include/trace/events/dma.h                | 3 ++-
>   kernel/dma/swiotlb.c                      | 8 ++++++++
>   5 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 1887d92e8e92..ccd9c1891200 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -130,3 +130,12 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
>   subsystem that the buffer is fully accessible at the elevated privilege
>   level (and ideally inaccessible or at least read-only at the
>   lesser-privileged levels).
> +
> +DMA_ATTR_SKIP_DEVICE_SYNC
> +-------------------------
> +
> +Device drivers can set DMA_ATTR_SKIP_DEVICE_SYNC in order to avoid doing a copy
> +from the original buffer to the TLB buffer for dma_map_single() with a
> +DMA_FROM_DEVICE direction. This can be used to save an extra copy in a device
> +driver's data path when using swiotlb bounce buffering.
> +
> diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
> index 9e0fe027dd3b..3bc1f9ba67b2 100644
> --- a/Documentation/core-api/swiotlb.rst
> +++ b/Documentation/core-api/swiotlb.rst
> @@ -67,7 +67,9 @@ to the driver for programming into the device. If a DMA operation specifies
>   multiple memory buffer segments, a separate bounce buffer must be allocated for
>   each segment. swiotlb_tbl_map_single() always does a "sync" operation (i.e., a
>   CPU copy) to initialize the bounce buffer to match the contents of the original
> -buffer.
> +buffer, except if DMA_ATTR_SKIP_DEVICE_SYNC is specified and the direction is
> +DMA_FROM_DEVICE. This is a performance optimization that may not be suitable for
> +all platforms.
>   
>   swiotlb_tbl_unmap_single() does the reverse. If the DMA operation might have
>   updated the bounce buffer memory and DMA_ATTR_SKIP_CPU_SYNC is not set, the
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index b79925b1c433..bfdaa65f8e9d 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -58,6 +58,12 @@
>    */
>   #define DMA_ATTR_PRIVILEGED		(1UL << 9)
>   
> +/*
> + * DMA_ATTR_SKIP_DEVICE_SYNC: used to indicate that the buffer does not need to
> + * be synchronized to the device.
> + */
> +#define DMA_ATTR_SKIP_DEVICE_SYNC	(1UL << 10)
> +
>   /*
>    * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>    * be given to a device to use as a DMA source or target.  It is specific to a
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index d8ddc27b6a7c..6eb8fd7e3515 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -31,7 +31,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>   		{ DMA_ATTR_FORCE_CONTIGUOUS, "FORCE_CONTIGUOUS" }, \
>   		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
>   		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
> -		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" })
> +		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
> +		{ DMA_ATTR_SKIP_DEVICE_SYNC, "SKIP_DEVICE_SYNC" })
>   
>   DECLARE_EVENT_CLASS(dma_map,
>   	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index abcf3fa63a56..8dab89bf5e33 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1435,8 +1435,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   	 * the original data, even if it's garbage, is necessary to match
>   	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
>   	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
> +	 *
> +	 * Setting DMA_ATTR_SKIP_DEVICE_SYNC will negate the behavior described
> +	 * before and avoid the copy from the original buffer to the TLB
> +	 * buffer.
>   	 */
> +	if (dir == DMA_FROM_DEVICE && (attrs & DMA_ATTR_SKIP_DEVICE_SYNC))
> +		goto out;

Nope, we still need to initialise the SWIOTLB slot with *something*, or 
we're just reintroducing the same data leakage issue again. The whole 
deal with that was that the caller *did* expect the entire buffer to be 
written, but the device had an error, and thus the subsequent unmap 
bounced out whatever data was in SWIOTLB before.

A memset is hopefully at least a bit faster than a copy, so maybe there 
is still some life in this idea, but the semantic is not "skip sync", 
it's "I'm OK with this entire buffer getting scribbled even my device 
ends up never touching it".

Thanks,
Robin.

> +
>   	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
> +out:
>   	return tlb_addr;
>   }
>   

