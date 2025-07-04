Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F81FDA;
	Fri,  4 Jul 2025 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751606091; cv=fail; b=O0irUf7T++3mNBQ//GBR4KktK6MQB2xMDkcYdnWg+3YKcvaN0hsLM5LI25GT7GsSnNjKS67+hdrn8LmMJs+SDthJ3vT+jY4qVaNF9Yw8F3w6Es9PexhxbbdPOZwmT1T/1pD810LFs/wllk6z72vmFKxDcg/vXUn9wr0Ww9IIIDM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751606091; c=relaxed/simple;
	bh=Ii6ts3nb3CHatksxXquUc3mYuKv9V/jva//hzLW/kRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMyUdVan8glHaoPRdN4GF8/CKIMj+sns8zWkrAaNU3mFWDoDg8nZctt5YkuUhZS0koH6DRibSvEO1ZDFSCdE59z6T6V49cXdvjISowFRhls+1GWz/ekdy1O7vCVtt+Gr6QC0x1wbggXC/6wJalVIw7qXlyyd6Mum4nj1O/F6Z0s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RmHFy9WC; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RmHFy9WC; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RmHFy9WC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RmHFy9WC"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rfaFS8OaLI0giT3Pp/37NK352bYw1v+EopSX5dk+9bqtNDf8t1LrxShwfTZWWbrA/ymLGHtiZo8oMIqNEZRHKtt/1kYdB6p9JqWhLz5DwH1PHPW/PwpM0a1MajSehYQZbtUTn89bw14YdQ5Z/cmSWf2mI2Uq7igb249DbQVUNjfkZfhG6SQZsnVvNuRT7Ly2nziEe7qvQCUpuR/QU+E532ydaelmPgUYtWI+x2pgIQO7ifYGQoQquftBCRKAM+aBEsRX8RwOzO77IddHl6vbv2sQBOd2lMfxhAFSLdWYlUwIYXl8W4HgTz/xxFhCDNf3Ma4DSI3875QoRKq8vTtrqw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nB0AUbV0LAq6vn8YBl7EwBTD0zgKNSI5NIJ71UCN4zA=;
 b=isF6PpMYtxnOvedYO5Q9zdBV65A4+kj6vSh5EORyuQJZ6OUZjhoXCHpD64Cq+IRmBizPfkfdKdIkSLcmPy8Qa0ettEF0Nz48Fj5kJ1fDZd17DC1ftzf8Fxq02aX3N7Kf7/I7MNodKAKRhOt/uGBmdawCk6NRLLgMkTiepRSDyLMl38dWPA3ZrQxU+L4qPbqJ4jgvSdVQN5poHD6FHUs5dvkcshewKycPAE8AsqAWF/K+kBxaXuf2xpTI0bt+K/3QDRLqDJ7hfnbnSCLf/x0AT5rFodnXRTi668D+SFn7N4CzNVUy6XNz+QFOyf2F5fBWv4LSWeB0DV4oT59EY62uDA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB0AUbV0LAq6vn8YBl7EwBTD0zgKNSI5NIJ71UCN4zA=;
 b=RmHFy9WCvvFTEs0XiGXl2yH9vxJOMqLV45gpZHTLSnDNRPBF4a5XblPpkuUaurbyLnCJfRzayKz2akPUyQVSp4YvX4OTjJOH1BHEtPEJAo8XE9UQqk3xjgFzQUdUISCbou67wa27mVrJy583BMur9dJGSlgjUwJO4ZrhQwTklfw=
Received: from DB7PR02CA0012.eurprd02.prod.outlook.com (2603:10a6:10:52::25)
 by PAXPR08MB6512.eurprd08.prod.outlook.com (2603:10a6:102:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 05:14:44 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:52:cafe::6f) by DB7PR02CA0012.outlook.office365.com
 (2603:10a6:10:52::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Fri,
 4 Jul 2025 05:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 05:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksFoJDEBi6/LocZ6qOcQmSQs3F+vsgcdVPCKKVq0OQMsY58plDhQxpkOVSTDItNTskO6WQKQXWDjhc7NKSM83Vv++0KSNHVFx7We4XUfFeHZyFCKThBi4hnxnzFQWmh5itq8NR12iDxcrNkn8d0tcPkovcUj5VfvNndrJRrfxe24g7PALzTefck5NxUyh94/vijtAMNcEX25F+N/HUAERXYqWgT2AU/14dL+KpGjVtQ2WGqAtWMAjMo3OaKv5C9mI1nZEWMn96zRXGja7Zwc0d7sNhvN1Vurh3qIGzCZ/63r6E/A9tlsH/SkkWuZPkufsyo/2peCH42twQCXJ1j/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nB0AUbV0LAq6vn8YBl7EwBTD0zgKNSI5NIJ71UCN4zA=;
 b=Y4a35guk/oc2NTlpBoLPSOpij8k5cf/K6hMy0g39hW+ANaBX2B5UJFskRTJbisXEJ03qJhez7mqev/cut/gvfRPv6bH2TUl1V9cOTw0NZFrcDuFkr795mGnhMksjDmHu0rrdytO+0LQmuq/IzcZbGHXMlJTOYZwi2l8gcp1jmxjthIFAaSBk7xHHLULV0A/oH1yTvPap0W07krmLBvDxLoMqOTNhPX8GfDkOCWzRgHOLfD0OtrWSPTgeJx/l2oGmU3VjkgEZktCV7czUbjkP8uaQio9X5WEWCKP3bSY9vG1xiOrAezMzDulFffwezWPzea4OD6QY5oXDYhd024r1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB0AUbV0LAq6vn8YBl7EwBTD0zgKNSI5NIJ71UCN4zA=;
 b=RmHFy9WCvvFTEs0XiGXl2yH9vxJOMqLV45gpZHTLSnDNRPBF4a5XblPpkuUaurbyLnCJfRzayKz2akPUyQVSp4YvX4OTjJOH1BHEtPEJAo8XE9UQqk3xjgFzQUdUISCbou67wa27mVrJy583BMur9dJGSlgjUwJO4ZrhQwTklfw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB9PR08MB8697.eurprd08.prod.outlook.com (2603:10a6:10:3d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 05:14:11 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 05:14:11 +0000
Message-ID: <9076b4be-8b1d-4434-a72f-d7a829a1a30a@arm.com>
Date: Fri, 4 Jul 2025 10:44:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/15] khugepaged: rename hpage_collapse_* to
 khugepaged_*
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
References: <20250702055742.102808-1-npache@redhat.com>
 <20250702055742.102808-2-npache@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250702055742.102808-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	AM9PR08MB7120:EE_|DB9PR08MB8697:EE_|DB5PEPF00014B90:EE_|PAXPR08MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: d1db9a6e-8b80-4a8e-2872-08ddbab9b015
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?KzI0YUordjdVeTIzQWc1UE5WNnIwV2RCM3dEaDNSdmhPTm5nR0hTcmhiL21j?=
 =?utf-8?B?RFhlTGYxWncyTVZoWm8xeExWcUgzL09Nd2RJUUxqSFU1eURsMjNGMS9GUEV3?=
 =?utf-8?B?NGMxbmRIcGtnM08rQTV4RG1ZcUV3UEw2SUJhbnkvYTY1QlhXcVR3ajcxaUR6?=
 =?utf-8?B?L3AvclFOZXFmMk93a3FjS1huY2I4NWk0Nmh5aGdBNG4xVDkvOWZRUDZIV0xk?=
 =?utf-8?B?NEUxM3RVMTVOb1duMEs1VTJtM1lEcGQ3VFdCSDVEKytHTkdzNlViYUh2L2Fa?=
 =?utf-8?B?UXhlSTRRNi9hTnVLKzM0Y0ttQjNDYjNQM0NFL21uajJoYmZ6ZFp1QU4xcjh3?=
 =?utf-8?B?dUlQN1VTZnJpNi9RYnpaRlNvdzFwSE5oRXN4RjNZUUpzVmlIMXpBcXgzS3VT?=
 =?utf-8?B?a0R2NkhYeFBxZUJWVDAvY2dpNlV0dHQ3RUhuNk5BRE5TSTZRTkpSOW41dzRF?=
 =?utf-8?B?cWNsYlZKaTJzQTNsRGh6UzBiQ3lQSmJ3ckR3NkQ0OG9NcXdZNGJXUUQzL3Ra?=
 =?utf-8?B?Tm5QdmhNKytkS1pMNjNjVmVrL1JwcmhuTUNac2lud2xqYVRsWWFCUmpCRzRu?=
 =?utf-8?B?bGZnRXVZZitPVVN5MGR0K3piNWhXRlM1MVZxOGF6a3h2KzdmSnkwR0VoVmZa?=
 =?utf-8?B?THJpUHhEREF2TEdYQTRWNlZZQ0FnQ29ncGRDeEdDeHBoTVVLWWZrNjkyeHZN?=
 =?utf-8?B?eXgrdUhDNjNVU0lPS1VKaklYTWdpcWVUcC96U0pob0pXVHdVUGhhWSs0MW1L?=
 =?utf-8?B?bStnREgzTEc1clI4L2laOE0wWnVmcnJrYkdRNmE1OEF4Sm53MUd3UFJMZ1hN?=
 =?utf-8?B?V3RrTkZzdHZHRDBSR09yU3dmK0RSbUdpV3lNQldWZGx0SXVMMTdiODlIdVBs?=
 =?utf-8?B?TXd1dktJSjlnL0JpdUhiN2xhbWRZWFAvbWhTakFqbnZsOHFsTXlYMjNudzRy?=
 =?utf-8?B?VGVsRHBtRHREM09reWRYMjdXNmNuS2dzQmFwMDBHYWxUSU14NEtwdEh4Z2pJ?=
 =?utf-8?B?eThoVWRhNzFMTXc2TzZUNFU2RkM1SmFMM2Q5TDNreElTUjZHYmJrUFdTWUF5?=
 =?utf-8?B?bG9LV1hpeVBUUm02VmtZeVpSSkdpVnAwTEhwMi9WZ3E3S3pRYnY5cEhGTEFU?=
 =?utf-8?B?RWV3K0NUdUl4cjFjK3AzWmxFOFJtV25ZVVBPcHJva2tPaVZEWUpNbElNc3FZ?=
 =?utf-8?B?ZGtpeVN3MU9QL1FIdzlOQTB4UjYrSHV3eklYM242cmNKc2lKZ3V3VHdDbG9q?=
 =?utf-8?B?czBtNkZ5eU52YkZmcWp3b2VrMEp0ZWFiUUNUblExV0NjS29oOUh6SXpYUkdh?=
 =?utf-8?B?MjZMOGVvSnJyVmRZZG4xa3RGbGNPblppaHVTWE4vOWtjeGV4TUw4VCsrV2N3?=
 =?utf-8?B?ZXV6SUwvTTRXNEx6MmdvTUdLNG5RTXQ1Q3c2Mm5CTnp5T2w1eGc1eGFuVmRX?=
 =?utf-8?B?UmdZS2dRdUdWNWxqZlRDSWZWSXlFekczZjIrblVZbE5XeDlUeFZuQk16c2FY?=
 =?utf-8?B?L3RPcytxdlEwTlBUd3ptaVVtSWNrSEIrdDRZUmRzQ0s4bXFWNTUzdEdGM2JB?=
 =?utf-8?B?RmV5ajZnYzdKVVBXVDQwaXQwcjdBZXo5TGFrbHhxRCtoMTFIYnhqc3QwOG5w?=
 =?utf-8?B?b2hFSDc1YUtmSi9VKzlOcEwvUXQ3V1hOQnJtVHpWVy9wUlBZZlJiY1JTWk43?=
 =?utf-8?B?RDhIYnZZWUJhSlJkNjN3SjJOU215L3pRa1ZzaVpSWGp1eW54QzhMbWJVbndZ?=
 =?utf-8?B?NEpMemw5OWNaRVU3YVYyOFZZYStHV0N1VGpoUDBpK1FzTk9nU2FBdnFKMThx?=
 =?utf-8?B?RlZXUFZZUUk5Vks1R3gvSHlKbEtaS2ZEYi8rbWU2Ym1iSlVpZU9ISUs4K0dM?=
 =?utf-8?B?TVBDMURMYytmKzVVcDNMTC9SaGdXTzZnZFE5WjJkbFF5bEpLaXo3bHhBNTgy?=
 =?utf-8?Q?qhz+gjaiWoI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8697
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	45827e8b-5762-4880-6bff-08ddbab99c1e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|14060799003|1800799024|35042699022|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHBZc3BERWdVUG9LdDBnZWlyaHhaQ2hqV0dVU20wbW5tb3Y5eitRZjYrOWZO?=
 =?utf-8?B?dG5nang4VDF2RlBDeU90YkdHY1pBQ3JnSGRmYnkzU2U0NmFSMExYL1AzL0tJ?=
 =?utf-8?B?ODk0SlpseGV0NDYyaVlWaFhGM0cvODNGUFordk5yRFN2Y0ZUQTlWUXFlTjAz?=
 =?utf-8?B?WmUyMUtpVEVhNEc1dE95Y2hLTlgzSG55Mi9IU1Y3Ylo5ZHhPdVkzRFdSS2ZS?=
 =?utf-8?B?ZmZkTnE0U1Rwdkh0S1owOEZmVG5wMExiVFRKdTlmOGFFTU5xdFBMVldPS3RJ?=
 =?utf-8?B?U2cyOFJUY0ZxNG44S25pSDFNRVZPV2ZPekZhNWhnVVEyR3ovVXFQdjFsN0d5?=
 =?utf-8?B?TU9ocGdrRFJCdHJmUVhxZkxrcDZqQXVHRlZXeDVWeTR2V0dSTVFIWVRWN3FO?=
 =?utf-8?B?djhteDkzTlBFenpFZVZxcVdjWHVseFFQeGhuc2gwRndKZ1p3ZTZ1VENuMlIr?=
 =?utf-8?B?cE5PdldPZ1M2YXpCYlhHRlZRei8xT05pcThiV2NGdlYxZnlLelJMVzlwQmhD?=
 =?utf-8?B?RmhqNUtnbnl4WXFIOWJmNWJOVjgxS0Rqc20rWU95VE11dGpuaGhraVdFbW9O?=
 =?utf-8?B?YXoyZUFTUG50dTBxdXNsenI2U09VSkNRTG0xOGVkVmtmOHFYeTNENFU0MkRz?=
 =?utf-8?B?L2o5K0c4amRrbjhlVmZqOWZscVNmeEZzTGFkL0pDOFpqaVIzSTdtZmY0T053?=
 =?utf-8?B?MUI2SmVHU3oxWEc2VmxDTkVrdVZZekdaUUJtVk5TRWhZOUR5Vi8vQklrMWFt?=
 =?utf-8?B?QVVDVnNTRThvbVpLMWxTVmY0MTU0b3pxMmZ1eUc0cCsyR2pTU3BsTzJjMG9k?=
 =?utf-8?B?aHpDYUltY3hJY29OaFRmMVBlRmV2QSs2VHQ4Ky9VK2RQalhtMzFtZDZwd0Vl?=
 =?utf-8?B?YzgvamdmTSsvN3RYZzNvL0x1L21US3RXYWV6Ynp2dHozVHgxMXgxZ3k5akZl?=
 =?utf-8?B?Q1Q1SDhFY2tmV3krQVBnY3pLMW5lZDViaWxMZFllYnNONmtxMFF6ZUFLNXJw?=
 =?utf-8?B?ZDE0V093VHFKRXJubzRJRUZJcFkzTFlldUgzWlIxamo0aHpVRVgwVjIwclc0?=
 =?utf-8?B?ck4rbWhOaFZmSkt0RERjcUF2WUJDQnlhbEN6L0xhSXF6THlQUmdYNkp5NTRl?=
 =?utf-8?B?SkUxTDlielBHV3J4UVJMMWNGQ095elRWbmUxTEhsb3ZRYlFpM2FScTl1MHYy?=
 =?utf-8?B?a1VqUGRyZEl4SEpmcHNzOUJPR0YyUk4zMDA1VEdLVnFRNXpHSi9pNHNMUzNK?=
 =?utf-8?B?RHkyQXVjclJOYnozOFV2VnNORTVoQ3hKZHV1Q1l5b3B0c2tpNGw4MWJWbytH?=
 =?utf-8?B?YTdwTHZXamJPdEh2U2N4SnIraVd6TUZrRWFjZTFWbkI1RkduSDlyZ3NTZ2NU?=
 =?utf-8?B?S20vUUpiL1VET1IrOVZuR292TGhsaGN2OWwvRnZuc1hNMnB2a3NqYk1IRUF6?=
 =?utf-8?B?YmQxSmR5SlIyc09JaHhKNVo2a1FXRDRuMW5TVVhmRVJUckt4ajZWQVVTdXc0?=
 =?utf-8?B?QnVQdVNhS0xXWnZLTDR1eHVhZkZ5VXpGU0g2dFRYTTVwV0lBU01YbFZtYTU3?=
 =?utf-8?B?Nkxtc1dxRWdQTnhMcGF5V2QyWTdLemUwcy81WDNUMldmZjlOY09FMy9vZUcr?=
 =?utf-8?B?d3dQL0JNdE1wZkQ0amoxTm1sZVZQYjhaU0wyUDVMSW1XY290eWtkazVic1BW?=
 =?utf-8?B?RjhYc2tFUEdCZ0NiWlJLUjVNbDA5bW5jd1BSUXRsbW8rdHgyVlgvQzVKcGs3?=
 =?utf-8?B?UEVGaUl4VloxQUhub1JlbHFVLzRlbFRKTVloalpVM3Mwdm4zVHR6R2ZRRStn?=
 =?utf-8?B?eU0wNTdJZTlIY21TcVZtaDNwVjY2d1J4RW9IT2Nuc2dOM3hGRkIvaTRQNWp6?=
 =?utf-8?B?azhZZmZDaEozZXFFZzNEbk1UNE1KSXNLVmpZcTErK3FUeGEvRUJQbWcxVU01?=
 =?utf-8?B?TmhvQVRBM3J2dk80cVh1VDNRalJXVDVTNlY0K0xjeHBoK3h6Zk4zcGlrc3NF?=
 =?utf-8?B?M1hYd0xIRlZFVStPVlZFMk9VVXI5d0dzSk40MmQ3SHZOa0VNSjVadGtINjdn?=
 =?utf-8?Q?NAFCPx?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(14060799003)(1800799024)(35042699022)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 05:14:44.1650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1db9a6e-8b80-4a8e-2872-08ddbab9b015
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6512


On 02/07/25 11:27 am, Nico Pache wrote:
> functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> as the function prefix.
>
> rename all of them to khugepaged to keep things consistent and slightly
> shorten the function names.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   

You are essentially reverting commit 7d8faaf15545 which adds the
hpage_collapse_ prefix. Since in the next patch you also unify
madvise and khugepaged, removing hpage_collapse prefix would
make sense, but then I tend to agree with Liam that dropping
the prefix altogether is better. Having all the functions in
khugepaged.c prefixed with khugepaged_ seems unnecessary work.

@David, I forgot where you replied but I remember you saying
that we should not introduce MADV_COLLAPSE mTHP support for
now?

