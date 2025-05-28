Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C157E55B;
	Wed, 28 May 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415508; cv=fail; b=OHjTXNWYuGeEbISU5v7/CY2gjxPoRRcFCEKV6uFiOC0jzg0WdAhKNYePohz2E9NBHz8qWLzubeACOYOqsBm9S604EEJY+YCg04JbeGDFNLNHmYoMLxX4mGKvZT0mimWCLdZHDP5G+cu5LuGiJpQxPr3QEhRJB15B8KYSVIFXzJ4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415508; c=relaxed/simple;
	bh=mZhysNUMZtMN2EjFX8vzPV/hj15mnQ6j7gpg3ZvYwGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GDsMYL5PiPzy9LcoiR4VeXERx/gXhsn/Geg4BZewAwqQaSFavbOA0cRfHI+bF4Lr1gjrzxNSSZM092VP47DZN9g8CPgJSPkTpbqODgh6Cej05YNw6Z8oVFsuIsLQy0sdEZJGm3tdNAyrNNbBRzzzT0p5J/wy8QZElgS2Dx3bnsg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ORiWlXhK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ORiWlXhK; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ORiWlXhK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ORiWlXhK"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=o5e7o3WELjo2I6NFBzZBP4zz46F1XLJsDNqUYH/51Ucndg6prmLlUbXi1XIcAbQ5tOQ1ztqCufC4HGz1G0IJHfHXF85RbF6qS+dlPUu3SNYMCThr5IBwqERl1uOP7hW0CBDraw4+1/5cIo8aLbUnXl9VWRiYdjggUs8pK/+ysz9oYi5Pty27ebxgThkVPWqmbW/6Dg51O3A3n/Nv76VIcoTfzqWv/3EdtzZHtdYpyB79C4gdLWul19+E70zSVJ7gD5hOtJUBoddhlcdYTPWDNLAUPEMTvESQs+gqF54K8CZTHPIgoaBmOWhbKzp5aJAvoGlH/ZC4Gmr6OhI/B+9GMA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV2VFvjOj83UzZZ3l3q+/4m+2O1UIM3gyl+66VnpT1M=;
 b=I1tyxjjNjnMIPdfFnFRWzCeyYcXTHF84rWr+/poSglhCo8NrLy3bGWMaYOVL6sBq8L/pDlrix4ylEfDZfhhqGjPu9YDqxf72nKjL/m6fwS5iPMubmuokVJ6bNku6SB0xYvKHCY66Cxj56HkS0AFrZgwOOcZGP0aj9mGXHYfaOkAm5b3C8o28RQWFDCDtRKQmN1gsLC4Wa0XZI4bqvpHc/+BGwvfZMWqCsjwYrfxGuQtno86KiSFjcyI8JImGt9UddUIK3COVGDf3WMDYvO31ywyFofwYyuebYHqu9EJ8Mk+ckrJr93Fdep1hyJVuuC2yQnijAS/wf+OV7aq5z0JdNA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV2VFvjOj83UzZZ3l3q+/4m+2O1UIM3gyl+66VnpT1M=;
 b=ORiWlXhKOfvvaFmw1HiR5YZ1I8ptDBIUoJ9hnDJRAxkIUsMmYtce2o5ig80AHF+GD0Kbi6fMNew9ESe4USbyflsq6+DihPeUWiYE4dz/zHwIyZKTCTSxv/SKcMaalR9utA974PubuQlOCc3bH7P1ajZ+ioESmgAqDWCXWPwA7SU=
Received: from DU7P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::29)
 by PA4PR08MB6301.eurprd08.prod.outlook.com (2603:10a6:102:e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 06:58:22 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::c4) by DU7P251CA0009.outlook.office365.com
 (2603:10a6:10:551::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 28 May 2025 06:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Wed, 28 May 2025 06:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zH5lqoLK5ZdfDnn+enXiZECS8pmhsIeWf72rtOPTAHU6W1CrwkvILlStepPBLW42A2GOz36P5q6fgu/Z9yyLyYIe8Ow9Y96bZaNktswbP9xKrrZkaI2ytoFliIFmAYDZQFVcIeh+mF9FWSUubsCTUPtpMDq+OedEuJ5kCSGN33SOSl1iyxMoZhi3i23Mw1Ykqj5MuGC8EF2KFAnGPLDKVmkY1COP13t34nttuthLmqmhW1V1FpNIUnN+RFi50+5h4Axp4H23yhxOL01KODY7jp3wPnkAlXapoPBR1jlrjk9fM9V7BfIP0TFA/f3lFNS3Os3YFK1RJ29awlrkP5iqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV2VFvjOj83UzZZ3l3q+/4m+2O1UIM3gyl+66VnpT1M=;
 b=ZfuNzODR9NZz5HLbIYzaLGA7JEcbSVa3+z0xJ4MlqXn60WW/tZwkhJuDaEVsJDEMciujnrrPkanpDZv3eQeDC3pUu7w6mS3pOyuxuYMDoIqD+qEIaZ7lTHf8gPP603it5z1XHJ4c3+uC1e+RAzK+poPwmTgilNtNlKa+3qeMelgdfmOA6JfWaBpJLmwJOFxiuRt82IDSe6+G2I9oU6lbCrNmdIoMIpcb8IXbQbbxJBfHSiIpo/i5elIwK6R645ifHvKhbsmEIFyYmptosPbbq3cRz/s1atQgjTszT9FJuSvSuo0FIvgih2xV7mEzOfkRDm+1NQTQuDW9al4+yWsVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV2VFvjOj83UzZZ3l3q+/4m+2O1UIM3gyl+66VnpT1M=;
 b=ORiWlXhKOfvvaFmw1HiR5YZ1I8ptDBIUoJ9hnDJRAxkIUsMmYtce2o5ig80AHF+GD0Kbi6fMNew9ESe4USbyflsq6+DihPeUWiYE4dz/zHwIyZKTCTSxv/SKcMaalR9utA974PubuQlOCc3bH7P1ajZ+ioESmgAqDWCXWPwA7SU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 06:57:48 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 06:57:48 +0000
Message-ID: <89733427-8cc4-46d2-8a4f-19a621d8ab7b@arm.com>
Date: Wed, 28 May 2025 12:27:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/12] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
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
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-4-npache@redhat.com>
 <469db7d1-ba99-4dc7-af13-b5fe850d4031@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <469db7d1-ba99-4dc7-af13-b5fe850d4031@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM8PR08MB5620:EE_|DU2PEPF00028D08:EE_|PA4PR08MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 7646b844-c88b-4bf2-0815-08dd9db507f0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?a0I5emljd0F6U2d3Wk4yeVhsQzVZQ1NHY1hEMkIra0hVRjBDaFM0b0RXTEpS?=
 =?utf-8?B?L0Q1T01jYVp0NFhuend4MHJORE9JQ2dEWDd4SEZmV01wazdiaUphM3F4L0pY?=
 =?utf-8?B?THBoc2k2NGRuS0VuakV4dzM2UEFzRlh1TkRCeHdOVjlNSld4RXM0Y3BlbTJm?=
 =?utf-8?B?aWgwMUdPS2lEZ2NVZWJ4WnUwN04wOFBSdDlDUFY5bC9sN2YzTzVUeUx3aFpY?=
 =?utf-8?B?NlZPK3J6VVBKLzRoUlk5V0lWalQ2TnVHdjNaZjhXNmdIZytoK2MrdTNYL0Zt?=
 =?utf-8?B?TitFeFlvS0Rod0krazNQZVJObXFKbC9QY0plbUU0WlcvWDAvK01lbG1yOFdn?=
 =?utf-8?B?alBmY1k3aE5vUXVHTjk4WUlWMmh0bm4xZ2tRUGVGYU56VmJsKzdGNVlyNUJF?=
 =?utf-8?B?c3NPNDhuSXllWG1CbFRLUy9NR1drSTdhSHFwUTFmRStHUDFMeGJqMXRCMzcr?=
 =?utf-8?B?RXBGNGM1aDl3T0V5elhtdFE2aHErSWszTG9aTGZRSEs0YUVWdG80Tzhkc1Bm?=
 =?utf-8?B?RjB2aEhBRGl3M1k1S1pVaGg3V2xDN0hJbDE2a1VrbE9jYU4wQXFQajR0ZXh4?=
 =?utf-8?B?NHN3cnNEczVVYWphblY0ZGFUS01ER0VwdXhPTzhEbngyL2hzWWV2U1RUWXhP?=
 =?utf-8?B?UzBZdjhLako5MTBuaEh3Vll3dkNEMmROQS9mdFZKaHB0bjVMS0dzRTg1Ynps?=
 =?utf-8?B?bWFTSVo1T0E0THRVZzQzamg3bWlISExBSzFUTXNXc0FVa2tmZzJTV2xxaFk5?=
 =?utf-8?B?R25tRWhpaEdLT0E4RGxjemw2azdlQlB1Vnlnc1R4OC91Y00vdmFRdmYwZEIz?=
 =?utf-8?B?enNXTUNJMCthVmM3QTBjSkU4MXU2RFRtZXRaT05ZdDFkZzlHRVBwMDVpTEVy?=
 =?utf-8?B?NmpqSS9Ud3ZFdzdGRUFVMndGMUpzTzhuL01ERnMrUzRSZzJiQlVwcDhXMmp3?=
 =?utf-8?B?TmIvME9RNVZMVEpWT2o4WjRMMUEzTGNVaTg2akl4cXZ5MnpZZjg1YVZFOWw5?=
 =?utf-8?B?SmpScGdGN1JRSlE3bzc4d1Fqai9EMDJkMEo2MWlySEJHWjJ1d3hFTjhjNkph?=
 =?utf-8?B?alp1aUJmejByZExJWWh4R29VaTNxL3VoVURnMkVDbTN0VEFHdTFJUzFWSW1G?=
 =?utf-8?B?TnFRYndIdm9YRVV1UDJoN2NwWUdTUU9lUSsxSkt6Szk0TnAxV0JuUDhqOWg5?=
 =?utf-8?B?NTVpY1ZXcGQwSDFKTVdENWNYbjA3cHBUa1JzNExqeHRIZ2t1UGdwTEg1SUY2?=
 =?utf-8?B?TE84bmJrQ042OFVWVW40VzdPRjhPdEZuSnZsYjdPa1ZLZXd3QVVsZy9waFZH?=
 =?utf-8?B?ZENaWjFrZkFRamJMR1VDOVAxY01UMjluNm1kWmdwZ0NPSnN5VDdEaXhlenU3?=
 =?utf-8?B?NUpNL0FYUmFPQkNnUVFzRmZORUgxUlJNLzlqbGZXZkFmM0lNTHBmTlNRMVJJ?=
 =?utf-8?B?dkJCOGEwTU9wa015NS9XaEQzdEZYM1NiUG9MMWtPMytBV09zQ3VIV0piZm5n?=
 =?utf-8?B?V3VPSHp0TmlJM3NYc3JXZHZFdHYwN01HWGNjTkoxcHg3elU5V2tacnBoeUc1?=
 =?utf-8?B?LzBreFpIYmVLTGRyYWRmdVl1eU5zczJQRjRYWC92RDViQ3M4WG94SU12UExX?=
 =?utf-8?B?bXlDQVlHczFhOFlITnBQbVFLT1oxZW9ubXFBbjNwd09RU0w5b3RXMTFLMFRz?=
 =?utf-8?B?TDRnWGZSOTZvQlViVWtCVFJ6U0hDa0ZMRHF6NFgvdWNQM3lIRjZiQW5OZU14?=
 =?utf-8?B?MmpLaStrM2dVZ2Rvd1RhcnRSMUpWSzBkQmg3SXVkaHJZRWJwRGFGd283ZGlZ?=
 =?utf-8?B?U1ljanJBbFI4c1QxVW91K1V2TUVsV1F4WjVHSjN3OTluZk1DUFFoUWFLTkFj?=
 =?utf-8?B?TWd2Q3NnUTVhcUFIRXpmSnNBMmJ6NTNoSG9pcjZLZVpZanNUZXpJSlBvZ1Jk?=
 =?utf-8?Q?s44gLRUQ8R8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5620
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1730aef2-8670-40eb-b902-08dd9db4f4a0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|376014|1800799024|36860700013|82310400026|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rkdna2UxSUdUdnMzSEVYK2NIWjFOR1hQeU5ScVJtUHRWS1pNeERQU3diWXZF?=
 =?utf-8?B?Q04yNVo2ZmxWb2svSG9Ga1NuRWZiTmpSRDkzNk5IZ2tCMk51dTdWUWJ2dUI0?=
 =?utf-8?B?Q0ttc3Z6ak0vME1nZzIzendkRVVnWHFBYWNCZFpRQUZJOWc0ZHIxUjd6TmhE?=
 =?utf-8?B?elFLTkhKTHlhemh4SGdWVlJhaE1UbG5qRGxteTk2aGQwN3RNZGFFdFVnMElO?=
 =?utf-8?B?QWRsbWRZR0dEWTFlVnY3YU5LUU11Q2VCN0NWaWN3UkYzV2lxMEw2SjhaTGFZ?=
 =?utf-8?B?VmlrWnA3VmtNN3NxZkVXZDZnVGRtTHFtbE93S3RHTCtYNlRoOEF4S0ZqaStq?=
 =?utf-8?B?Z0hFVWZKdEUreW5PM3F5R3hMdkdiQVVudHo1RDVnQ0o0alRjY3pTbmdEV0FM?=
 =?utf-8?B?ZUVESStLODJSOC9MbjNxcTVWL2RUZmRibGUxZXNlcDdBdXJ0NXBXRFhoRHlr?=
 =?utf-8?B?M2hMZDRlSkZrOVRuRUpwN3A5aGJzTnNnTUJQamNkMkV1dEtQZ3ZwRHhEL05h?=
 =?utf-8?B?VU5sZ25MTk1uSUNieFhLYzNvbURGM2h0eGNNa2FERmEwaUVTeFZteVpxSERw?=
 =?utf-8?B?MDBFWWZSaUJ3ZnQ1MTF6V3RLQzhOMDNZZUNISUJMdmp3YVpHNzA5L0JZKzJU?=
 =?utf-8?B?cHh5VjJxSXppdVcyWDJSYU5pMjRuSnVPMlc4b1VGNmRzZnZlT2grV3JHb0I5?=
 =?utf-8?B?UThJTHZkWEZ1RnFnQ05RQ1B3ZzhlRVNNczFBb05TbmVlcmt1OUlmQlhkNkRJ?=
 =?utf-8?B?WjQ0NHRVMGFhYmZXNEd0M2hvcDhUYU1ySjlReUpUdnhjRlNtVThpdGtsY3hP?=
 =?utf-8?B?ck9KQnVIQStaYlBaekh4WFhsYzhlU0tuNEp4UXhxNDN5WFBoem95SjdUU2ZZ?=
 =?utf-8?B?UHpoNjdTQm5kVnZiRFBLSC9tYzBWdkVTVS9RWjdOQjdTaXlJemhPSnI0NCs5?=
 =?utf-8?B?M1FVQ1NraXM4VDhCQisyTVJlSUFxT1U2bXlPbUYrUVVWbVJ4ME9ob2p5WmUy?=
 =?utf-8?B?cjFzK2ZxeVN6VCs4SzEwUTZrS3dqd0RUbmNEbDJlMXk2UitxRlhPRmtUNit0?=
 =?utf-8?B?VjBBcUN5MEllNkR1RFA0amk0Q2NSZjRBUktZNVpldWR0S2JwZkRSbHJ0VmNa?=
 =?utf-8?B?aWdhK05qNGIrblZXRkVNSTlNWkRVUHo5Ulh3eFF3S1dPdVhSVFl6bXdDTUlV?=
 =?utf-8?B?NTJleWZSQkZYMUJMUW9lYkwrdVpjSXh5d213UUt4Ylk1eTQ2d29TY0FuNHVw?=
 =?utf-8?B?blJGMVIwOW1JOHMrSzNjVitaTXMxM1dZeGFhSFpsdWpTZ2djbFlQTE5LamMy?=
 =?utf-8?B?NHdjVGtjWFdjWmc1a1pWdTZnT1YvZ3FuT3pWbk1qVytzOTgyRGRkWjh5UjdU?=
 =?utf-8?B?Q3A1MkJjTkRvVzQ1UndXdTRMSlluOU9UR01OS2F0aXFWa3haTmMreXdmbGtK?=
 =?utf-8?B?UUs0QmZoZkFjTGZYVjBLVlNNY1IwT2Z1RXdaSGhoSzMvNDVGUkpiYldxNFl5?=
 =?utf-8?B?dW9PYzlxNEVMYUxzRnlJN3JhMzRoVUVweHBQNFBPZlBvU1NLQnc3djM4U1N2?=
 =?utf-8?B?Mk5hRXMxN3VRS09GeWp5VEtGU1pZRldTN1MzOHJMM3FmSXBCbjlIK2NxRVNn?=
 =?utf-8?B?cURJVDZURlA2S2gwMy8xL3pxdDdYd2o5MlluRlBLNEFYZzhieVBBRlZJcHQr?=
 =?utf-8?B?Q2ZBLzg0RU1VL0ZORmw2OFMzV2YrMVRaY09qWm84SjNpeDNZaEFvRGZTTVE2?=
 =?utf-8?B?V1ZkR3c0VGhydWRSTHZsdm5WKzlEU2JNN3B0ZTBPeUIySTBpOWhUaEFDeG1v?=
 =?utf-8?B?MmxjVDFSRU1XWnRGUmJFSEhTalVvRXRmQlE5NUlUR3RFYzJCVzRKeUlQTVl6?=
 =?utf-8?B?VURFdWlDdmcxYWhGNW9Zc2RYeGNmT0RzRDY2OTd0bk1ySFdjU0FHR3gvdVBz?=
 =?utf-8?B?b1VkVStXSEhRY3pvSVVzcUQ4UjNoRnVHKzdMc3M4NEhsc1Z3VlpXR2U4aHhr?=
 =?utf-8?B?NTdYZThCd2IwWnZkUWVTa3VmcXZtWlBkKzcvQmRiY29jOFlDWUFGTURwaXkw?=
 =?utf-8?B?QjF0SGhlem9yWVhzL2txN2xMNHZudjNsQjlIUT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(376014)(1800799024)(36860700013)(82310400026)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 06:58:20.3519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7646b844-c88b-4bf2-0815-08dd9db507f0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6301


On 23/05/25 12:25 pm, Baolin Wang wrote:
>
>
> On 2025/5/15 11:22, Nico Pache wrote:
>> For khugepaged to support different mTHP orders, we must generalize this
>> to check if the PMD is not shared by another VMA and the order is
>> enabled.
>>
>> No functional change in this patch.
>>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Co-developed-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/khugepaged.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 5457571d505a..0c4d6a02d59c 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -920,7 +920,7 @@ static int khugepaged_find_target_node(struct 
>> collapse_control *cc)
>>   static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned 
>> long address,
>>                      bool expect_anon,
>>                      struct vm_area_struct **vmap,
>> -                   struct collapse_control *cc)
>> +                   struct collapse_control *cc, int order)
>>   {
>>       struct vm_area_struct *vma;
>>       unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS 
>> : 0;
>> @@ -934,7 +934,7 @@ static int hugepage_vma_revalidate(struct 
>> mm_struct *mm, unsigned long address,
>>         if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>
> Sorry, I missed this before. Should we also change 'PMD_ORDER' to 
> 'order' for the thp_vma_suitable_order()?


You are right, I did that in my patch:

https://lore.kernel.org/all/20250211111326.14295-3-dev.jain@arm.com/


>
>>           return SCAN_ADDRESS_RANGE;
>> -    if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, 
>> PMD_ORDER))
>> +    if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, order))
>>           return SCAN_VMA_CHECK;
>>       /*
>>        * Anon VMA expected, the address may be unmapped then
>> @@ -1130,7 +1130,7 @@ static int collapse_huge_page(struct mm_struct 
>> *mm, unsigned long address,
>>           goto out_nolock;
>>         mmap_read_lock(mm);
>> -    result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
>> +    result = hugepage_vma_revalidate(mm, address, true, &vma, cc, 
>> HPAGE_PMD_ORDER);
>>       if (result != SCAN_SUCCEED) {
>>           mmap_read_unlock(mm);
>>           goto out_nolock;
>> @@ -1164,7 +1164,7 @@ static int collapse_huge_page(struct mm_struct 
>> *mm, unsigned long address,
>>        * mmap_lock.
>>        */
>>       mmap_write_lock(mm);
>> -    result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
>> +    result = hugepage_vma_revalidate(mm, address, true, &vma, cc, 
>> HPAGE_PMD_ORDER);
>>       if (result != SCAN_SUCCEED)
>>           goto out_up_write;
>>       /* check if the pmd is still valid */
>> @@ -2782,7 +2782,7 @@ int madvise_collapse(struct vm_area_struct 
>> *vma, struct vm_area_struct **prev,
>>               mmap_read_lock(mm);
>>               mmap_locked = true;
>>               result = hugepage_vma_revalidate(mm, addr, false, &vma,
>> -                             cc);
>> +                             cc, HPAGE_PMD_ORDER);
>>               if (result  != SCAN_SUCCEED) {
>>                   last_fail = result;
>>                   goto out_nolock;
