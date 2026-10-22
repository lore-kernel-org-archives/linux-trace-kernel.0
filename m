Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792699337;
	b=rzhXJ84WAtn8Efn8526bFIuTV+pha7rRIJU5YgnKt/ZP5cYwiV2RHbfrbX+RckhxN/gB
	 TMKfXgeJQebIPkR5OjQyWS4lcswh+q2rAtl3BQWl5Zvp8qaHnZZaeLqZDFU80qprcEoKR
	 A1RIcWwMNXsqwUoeRrKcw3SrCeLlKp35VylyjoMijLJoXWF/g2F9I152tUzkJuaWTP5BH
	 bnBpublGOzTqgUdi4rs+V06FjZ3iO6GAqhUbHx6XRUkfcPasFV6wFHfdrL2CXMjkNBnI+
	 1W4FhFUH2aQRmX3fy9AkwOrbabWwiwky2LxICgbsA3n2cVw1dA3EjcVPQJgVldZ/hfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699337;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=7hhYukIB8wy+5nohd/0NiKo7C80xom8pZyVXGjxhw6w=;
	b=EUzgpuwstgMtOxBJOYWphqlUlr8YFJR3rJSYdBwDClL4zjQyxzM2bVY5Gi73mZ+9zKlX
	 cpG6YSKIPX2jLrj2t+RSkDzp/pzWG6v6Ysv9YcHDOJCRxPUQ1eeaQv5Zpc2YZJNzKBdzo
	 cpdf3kqPALzOeFwZPzfj7ag506mJ3cHFKOfeLZYwWLp2jw6hLoJ/+jeaQX1XEebOW+mZf
	 YHkB9HfCMcwtpt/RTVgOq2wWkjUQmXeBIejcZLc3y+5YF77aRFnDe7m8aruuTxmb5MYk5
	 0akOW4+I1Hg4S2Cc4MX2A0D5fffOrSEPLoXt0onqaX/Kxft1rxBlmt6TBxVKSE3GUrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V4CusNXx;
	arc=fail smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C6606A319;
	Thu, 22 Oct 2026 20:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A6C6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V4CusNXx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792699337; x=1824235337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7hhYukIB8wy+5nohd/0NiKo7C80xom8pZyVXGjxhw6w=;
  b=V4CusNXxVkxr9deP/oS5QNkbITSxbBYKCSQ4O0rNwb/RilVfjr9IUIu5
   iuR2qRnAvITCh2jAJg2y6aheTWRYm5eu4IKDnzmvr9rc5Z2m4U0t3p1rM
   kMSL28MLiVIGnAmo6AXPz8wA0xajWgcmguAv/8pB1ZtIql+BKwgl0fYR/
   J8GKKsny4Bqy6gXGD42zQYExx1HMSr15hbOiI/YYfV5WI9nTpgJf+qGUl
   50EH75reiveXl2Frtuc5WG+40p35+j/c6oltRBeRJof0LlxY/dqZctjGr
   4Wfxhsz0ebdMUr6F6rP2rTGQe7Uadp88YYisFJ34ui8O0uhVEYi/lVAYp
   g==;
X-CSE-ConnectionGUID: Ny7hgapiSs+P9ccg6dcNLw==
X-CSE-MsgGUID: n3wIsEzmQ9O0WIuwMmoAuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1496301"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1496301"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 13:02:16 -0700
X-CSE-ConnectionGUID: gRjB6gFBSTyvV6PZXJyAkg==
X-CSE-MsgGUID: TOP8apsyTUaLq3omgq47Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3440958"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 13:02:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 13:02:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 13:02:15 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 13:02:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHElPu0AH+PeahXhXTzgnjAgEuCgO7czfQ2cr1rdJXxU5N+HeyaFEipXmoc2ojxRG9kXxXqe4T4lvwHlMjHFLUifqa7rFA1zlagh58Ozah+y9VUdeGr+9uh8Nfh3Dnxln2S8Y4xuAsXsRUpJibzY+B43a+0mkwlgvtNtPRd3OiSNLWLvONbaFrM/uRDmrPOFZe1bpIXSHAOwEGSR5Lkpj7DxFuZkKdoY8Sm4uCv4WtN25gbO84u7vVQ3xqjIw0ryRAcvImcwJVuHodVt4ylSjRDkhGFuodXLJ9YEDQMk6+42YanlHfmiClGfmM4+qDptwNndpoMNoAlY3TaKk2+eOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hhYukIB8wy+5nohd/0NiKo7C80xom8pZyVXGjxhw6w=;
 b=s+043Dp3YsY2wUzSPSwcVSL7wtX5cTi606qiACT8xx+RMboyf7aD5zJmAi+SeKSoVdCInT72RKUy08rLArMl3YaV8ZCfH8RSYXi/N8jtFYSBiWeZDKv9khwJnw1B0iRpdNieW8GWEi/WinhzP8vRNBB7PA06geZWdFRpTDxmHBeWWTmerTJ3rbIf5CmxusfWb81fZmKBNtVL143UMqftQfpi4xOYYV8TWb8/x71SQ2xa6jSchvI4Zkdi0H1fKFBoGvdnGyudMPtFm+ix5uuaWiZLh5THT5jpoEWF2yNPppUGb5yr5HmETrPlZE+Nly1c9oiRgWe3qyY3u1MEIe8e9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM4PR11MB7351.namprd11.prod.outlook.com
 (2603:10b6:8:104::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.17; Thu, 22 Oct
 2026 20:02:12 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::3c00:3404:321b:fb35]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::3c00:3404:321b:fb35%7]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 20:02:11 +0000
Message-ID: <1fa2d09d-8ef2-4e38-88c5-2e71a68d5095@intel.com>
Date: Thu, 22 Oct 2026 22:02:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: haltpoll: Only define guest_halt_poll_ns
 tracepoint when used
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Eiichi Tsukata
	<eiichi.tsukata@nutanix.com>, Julia Lawall <Julia.Lawall@inria.fr>, LKML
	<linux-kernel@vger.kernel.org>
References: <20261022153359.2433474b@gandalf.local.home>
 <ae46d1e7-6e49-405c-b4ba-9f659f5fdab3@intel.com>
 <20261022160034.701ae74d@gandalf.local.home>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20261022160034.701ae74d@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0046.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::19) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2054d4-2ced-49ed-375b-08df30775c31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fawuo1bw83hJXza6WkFhZv4m0K1zguaG/UYpc2tMOM/1ZTJ0ykA4fQTtyatKsTIiDJfji/Y77p7oPK0/Ga58uVjNvLFcVx7IXNkvIe8oURXhjzI1qXA0833BD9Nvx1NZuzGqIN90d2P+qLl3E94cad+vBxGqjJ1WzgvIPbIrQ0dCoe5PphFLTGQADUF+4SUNbtyhBk13QKvrhZjq3PcWnuJE8tgPXIqEswy/TTFJNUV2sjkSg3Cy4gF8MuFouj+Cbl3TvOcHsW2JVbqIloKdp2rrAbIUkmv3dlUi+tV7xqZ2ibTHY32cfAGSUSDbZr5Jsav+CC1ZZ5+x3P65E2cX7atlWy6JZLyNiGNkmyS+k49BzojHijLPF/WQ7rfbsgh5czU7zwEFriAglSnCnV4U7r474rHPajtlWeXTzdV6KrsnTMGcuIhT6tHkMjAlWnS4aIQ9XF6rJiIJmQ0PdbswPSzgqDbBp2qU6JYOv6AJvvswV4uc5EdQ40A8zBUj3W/n0OuhmseKOukB6H8EFMNJjurmmPNQi72SoJTMX7N0WXpvvqWV/5n/Wd4KV2KtVA+51uvkXsM6zCiuFUhoIFSCvHYto7JUVSRVtOKxLX+z7HVeJNnB+co8go5kV9Qm2vLAWp4vf7Q33APNtlEDmZ6nW8vbwQ0MC5TXlOb2qIpOE64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2liUGtBNzJFTVNGeERSSU9Eckk0RnpiL0xiTlQybEQ2aW5ocnlFYWJBQnNp?=
 =?utf-8?B?aUdDT2p2cEZYV1NxaW5veTFqYnZmS01ZdlJuSkRjRWRDZTZ5L3hKNzlZbUEw?=
 =?utf-8?B?OE5CRkhleWFHUnk5aC8rSzcvMUFPbTdQSUVnN2lCOVpCTzZwTk5GeTB5UGs5?=
 =?utf-8?B?V1dXbExFQmdlUFJjREE4akg1dndFYnRINTl3V0VZUGd3N3BuVVo4WHhIcGJu?=
 =?utf-8?B?cWJkTWZQT1lVTy9aNUVrU21Lb2cwTFdOU3Y3Yk9yait0dWIrVGVYdEF6R05U?=
 =?utf-8?B?WUlCZGNTa1p5c1BONFN0WWRLYzZiT2lwZWxsbmh4cHZZT3AvSm1lSlQ1ZzFU?=
 =?utf-8?B?MjFIQnhGTU43c3VBcklCQUYycjNTYzdiR05kRGk0a1I1NVFhRE5lWEQrK2FB?=
 =?utf-8?B?bXZvOFZoWGFudVJzV2tKWk11ZHgzV2p3N3dKWHIvRlRiWXZiRHk1ZXIrcExK?=
 =?utf-8?B?dGlNUFFJcXZuelJZQWMrb085eE40MU45TG1vdklWY05LRHIwYzNRa1lOemlX?=
 =?utf-8?B?RC9wN1FCOGYyTE5lSDFoL2c0OUlFUTJoWnpmdUMzZGtUNlUxL2FRRHZGVWxY?=
 =?utf-8?B?RGtBTFR3d2phOGdzZmZnK3FlSHVDMnMrcUk0UXFIMWZIQmw3VnFJd1NPZXJX?=
 =?utf-8?B?UExLczA4U0s2YWhQcTRMdHRSaC9zK3NqTi9VWlkwOXlYaHh2K05hcXI0WjJT?=
 =?utf-8?B?d2x6emw5c0c5QU51elN4QWFRRUcvOUxwWnFUNThDZTlmbGROQ2dMTHZPTGtR?=
 =?utf-8?B?cXJrS0NpNGJoNXpFOW5NZnFwRU50eTlCWXRsdWdkeTN5SGpKejhCUndHZ3Fl?=
 =?utf-8?B?ZDRoTngrWmVHWlRsSVowM1hXL254RkNkY2NWR2lUS3h0MU9sVWV3TE9pMEN0?=
 =?utf-8?B?WG1ENDRJQkY5VTBMbFdRNWlNWUg1UVBkMldTbzFndnhzREo3NXVwTGlMRnNR?=
 =?utf-8?B?b0U0czNFelU1d3RmY0JKNldSN01xNFIrOHRxSlRsWUdnL0J1Q3ZoMFYwUFBz?=
 =?utf-8?B?YXZWUUl5azRJa1lBZDBMU1hUOXQ2TzNWT2JqY1lKZFY3Vk1oWHJxT21xcWNV?=
 =?utf-8?B?MDJTRFJ4T0F5OUloc1JZcFAwU1hzVlBsa0E5WFZRY2VKb3JrU2Naa0hXcjRG?=
 =?utf-8?B?TjZpVVllaSt4WVBuM0tZU1FYSUcxSnNhUVY4clNaSjZxaDNTS1M4VHduSU9L?=
 =?utf-8?B?djF6NlNkYnhTRG1jOEV0S1Z2MVhNdVZvOGRzQS9nYi93dXFiNjVUbWpLbzVl?=
 =?utf-8?B?SWd5d21tSnBXeFJUQkJVd1JEd0MvNThPZlFJWG5rMUdrUE5IMXo1OGgwYjVz?=
 =?utf-8?B?bFN0enZ3bGhNalBhL2tDVURUamEwai9XNkpLaVgxMFdIVlp3OE9LRGNFdStH?=
 =?utf-8?B?UWtHWXY1ek1tZ3NDWDNod2lNcDF4TFpWR1NvK2k4eUZ5Yk5kVmtOVjFBNGMr?=
 =?utf-8?B?aWVYQjhBNXN6U3h1M2dsMFduOFN5SnJlSHZlazVaM05ud3FGNWQzcUk0S0RW?=
 =?utf-8?B?dS9zUW9ocFExamg4RWFFQSs0R3FQU0g4aVN6dFVtYUt6QmN4bkJFL09tV0sy?=
 =?utf-8?B?SlE4R29UNFlFMEhSZ1pKa2YzZ2lOZFdRdUpyYktTaDY3V2s1WGZUS29VU1Vn?=
 =?utf-8?B?Q2FtMU40dmdHREtVUWIzaW84NHNJNWZnMFNxZytzOW5CVkgxMG8zZXJlQ21t?=
 =?utf-8?B?M2RVTS84MXlUdkZjZS9TMHFweW5LL2l3azZVYXZwS2pYWkxQNWx5UEFvRHlD?=
 =?utf-8?B?S05WVllySzV5MmVLY1VqS2J3aExCbzI2SEYvTzczRUVQUHdRWEtSeEZkQ2Y0?=
 =?utf-8?B?aW5WWXZIV2U0TXB6eHp3ZEx1WFk1WW9lbFNLMGdPTWNlMzc1MjdRdmxNWVFJ?=
 =?utf-8?B?SlhITmg5c0t3RlFSS1hISlVCS0ErdEFKdUR0RWJvTlMzc251MFNtMjRobnVk?=
 =?utf-8?B?ZjM3aUU1dlg3cldwZ2VZYTFyYnczNXhTdWpZdDJUL3NNVWEySVRBZmh5VEdw?=
 =?utf-8?B?ZGRKc1phOTRlalBJcjJxN2I1UUthbjdEd0p6TEJUVHlNRlcyUTF6NWVaMnFq?=
 =?utf-8?B?N0hxenZidDVuOG95RWMzV2t6ZDdwSXh1WFZrNkpXb2QwUndpSk5ZRHFSbCt1?=
 =?utf-8?B?dit0SloyZWJDUVNFajFFVHUvdHlzKzhFVTJOSFpuWCtNN2hibWVJaEdHUTNW?=
 =?utf-8?B?Vk4zNGEySGdmNGFDN3lXQUYzOEVnUXVpQzRIdmt5V0J3R09TODBLa2xLaEgz?=
 =?utf-8?B?dDB0NEMxYkVHZzhibjhJQXdiSDJUV3lkTFhlNVBvMWhoaHQ5ZDM4Z0tMN1lr?=
 =?utf-8?B?enMvc3A1SVE4VVV5N1VqNUtGSU5lMEF4RHhkemZraFhQVFN2eUgwb1dicm9u?=
 =?utf-8?Q?fUF07zMbsB7PugJk=3D?=
X-Exchange-RoutingPolicyChecked: QW3aCwMjL5QNH0c164s4cSWlpminvR824aPzb3GQL+sTUYchwys+Q76alfO1mmtLNxSRCH7CMfs5DPqQw4uMKehyF8tiSkRLJzDl7ITQ29LjGX/nh+nHJbSYpp6U/8Diw6H3yIRahX7A5cBCNq2mY8gN1hNPHC/ACmr3PZbLHndi6J03KZbmnnXoMiDAeMyR0QKs8eRW1zhvdjqt//pi/0T4D9pTCdUfsbMuLvaI7X3VGSDC1OQTESreepr8qXnxYK8tfTYZpq6mQsYk4tZv0dUrTNJgnXIsIYMT3o4MsSNNz++VNokzYarEjYL0PoyaGnqYo4KBpRD8zggR6Rtycw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2054d4-2ced-49ed-375b-08df30775c31
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 20:02:11.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODJb/tCc2ZcorP2IJHdvaxfTpoCt8mjNb0HCF93kIqwou6ly2etF1ZmjJEH9/++M0LcFEizxk90LtrFnFrub+G8s72zDL2GCoYNfl/ycSDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com


On 10/22/2026 10:00 PM, Steven Rostedt wrote:
> On Thu, 22 Oct 2026 21:54:09 +0200
> "Wysocki, Rafael J" <rafael.j.wysocki@intel.com> wrote:
>
>> On 10/22/2026 9:33 PM, Steven Rostedt wrote:
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> Tracepoints that are defined take up around 5K each, even if they are not
>>> used. When a tracepoint is used only in code when a specific config is
>>> enabled, their definition must also be only defined when the same config
>>> is enabled otherwise it wastes memory.
>>>
>>> The tracepoint guest_halt_poll_ns is only used when CONFIG_CPU_IDLE_GOV_HALTPOLL
>>> is enabled. Guard the definition of that tracepoint with the same config.
>>>
>>> Fixes: 0da11bf0cab90 ("cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink")
>>> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Thanks!
> Want me to take this through my tree, or do you want to take it?

Please feel free to take it.

Rafael


