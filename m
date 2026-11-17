Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924139;
	b=VKX0yMkMV9jBMzAEBdbgnzlyOzLTBQlQQeGUO7xuFgWurKHIRcXH6BbP196mtx+ii7HW
	 EpM1GGooUAefj9bUluR2VC0X2YcYXogOWdwAoY/iZfK3njseA7Rkn7XYG1odEXSr4pErI
	 bcp8tYHeOreuiY9tKSEDqJO75ZpjKndJgdfzE7arP3OPuAwP+AEd6On7Yey2/KXWg8kAx
	 rM8PxWPUEZcPPPCV8H2/SmwzGl/hVvB8E1wODF1ZcsCNfK8RuaTy4Gct2fK8OwpVBl/jy
	 B4VC7sXCj94cWiq/iBVLCe/pXLUPL84Quix7AqQMfaC38dN1fl+1Rl5uLKIwjxAtVcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924139;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=W9guF26tnals7LYGEyYTylUX2PK6RGL9JEgYfYVwONg=;
	b=V+hlc8GVLmkfs1WriYxZWtU461B53FBEs+FiaWRTMxELTpvyETaO9n8iULywOErNzjEy
	 ybExj9f0UxZiqfo2kGIjYVrOKOGFol6w59Fe2jXKFS1IU73xxg6I6KCunaoPxgMm9aL+3
	 rvKHcjE6u28EDTxHfYLxhId08kNHzbKao6Kh7LXgXxWLIPs0kQaL/7w6nw2WPaJTMl1sA
	 vF0vWGHS5NWTain5gUnnyrbvpCMg2l3FyuBAr5TT2PmSNfgT6URLZfK3JLd39ifQfAMnT
	 CO++YPmxrOjZvdf8qPyLoRxfQNRQtpBf6HqvJJWra/qziAz2sL1+gvDR3woxLkom3ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gygQmZzj;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jpDT+Dzw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6D606A8BF;
	Tue, 17 Nov 2026 14:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF6D606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gygQmZzj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jpDT+Dzw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794924139; x=1826460139;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XzIbDW6qiQLm/PN1N8OmaT45U6+NV/0u5ywZAD8Nsec=;
  b=gygQmZzjPhP/mSY7HY71aksI6Hfsj6PDJe+xLIehIpbaYiQRB5RnCaHF
   F32gopv8h0SEKSnxzJCZLrH6exnpu39FmuPVxNyxDxU7ZikN22h2SIPZ/
   NMhX3ttiy6KDxi2dYkfM37Ld9M4SiFJagTP5FPjPDkqNfayrX1FMI+su8
   uy2zVUkUDnjeVBorbSDILsMhk+/at2lFEeRuEtBA/GT27oA97xlT7jC1c
   bJizOoV0CfLIg4QyB1jGVW8OGUBAIGIHm1k5ujh4Bqbxrc8b7tFs75XRe
   s7gCGHgj1xCTkmS8kmORCfDNkqLs5g6u5rgMzsD58SkjliDiWe5NZzh0M
   w==;
X-CSE-ConnectionGUID: tDBvtrPbSvSuJJtCI+FfHA==
X-CSE-MsgGUID: BY9amOjyTWqIuYeFGU2j8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3716833"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3716833"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:02:18 -0800
X-CSE-ConnectionGUID: qL5Oly+VRPeMjrO6CpgUNg==
X-CSE-MsgGUID: RqAAprV+Ro+ie9Ct0IUl/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9807964"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:02:18 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:02:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 06:02:17 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:02:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVXmoLXzyntooGQN/djnyDpqSNfJ6CQlqRkAZBR29/VvofeLKz9GycvJyz0sG+VFx1MgyFCFhUhk7MeF5ih8wnfYXZy6EYgSXYRSsCBzRijl96hBzgxwOMYqcHa+c/WdmdFQ+UMjocv84oisM/6mxQ87nYUJwTm6dXNtydl0mop9ew5YcCeAxnqSH5tFnwqEhNUAedrgzmLhc0HeIfTuyuBaAywCS/Nhlx3kF6dYI0O+S07i5ddqKBpreI+mrKZuw9aKUPnF8gzlcbojHjiVLtIVcswhILuEYbitVtqFYXyMuAwBYwjhV858g3lR/ajTXMSgElPREkabqhEASlegYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9guF26tnals7LYGEyYTylUX2PK6RGL9JEgYfYVwONg=;
 b=lNsMrTtHg7+wyE5ZA3HP9uooDNobRqU0csjpUbmJsmc1iVg8Ahlaizt8plXzwc1D1IQizuGYINCExoH7snMnjUKctphr2E84mkM7KN0qTHd+QYzOHBM2CHE2S7saY2d75p8iDWTc4Th1yHsTKp9MO2IV+ah2QJbLvEC0zu5hHgV5ZqfebwOZc33TQ5vgOc/Fh/IFMyoVdijbUtvn4qBVW59g7My1EKdMGd0dnlpplmydJ7bCz88SDkO8IbSTTjdkDT64PXknTtyFdJ5sEwGVI4QE1kUZyrKh59qybNzI4pEvkN0/F2j8JaToN6yUUyj5peHDx3sxZYwro2JnQ9G2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9guF26tnals7LYGEyYTylUX2PK6RGL9JEgYfYVwONg=;
 b=jpDT+DzwidETbkKVFDBehkfy9C2Q0e6NmTHhYmXdIXmGlB13q5YO0eYbDVXEGGRa4BHZpsn564GuWBfPsUF5D5L6U7iHFcV9ayHupWRWM+TuVe/C2QyqJcKJNtBkt8ImfmLbzHDTgWZ6BU4Xti0hKSI5nRfNaTNPzc0DmKjtK/o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by CH3PR11MB7722.namprd11.prod.outlook.com (2603:10b6:610:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:02:11 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:02:11 +0000
Message-ID: <19df2f93-adbf-47d3-84ae-6cca78b34df0@intel.com>
Date: Tue, 17 Nov 2026 15:02:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint
To: Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Temitope obabi
	<obabitemitope765@gmail.com>
References: <20261110132013.732-1-obabitemitope765@gmail.com>
 <179487776546.3663701.11916478949345242482.b4-ty@b4>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <179487776546.3663701.11916478949345242482.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::10) To PH0PR11MB4952.namprd11.prod.outlook.com
 (2603:10b6:510:40::15)
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
X-MS-TrafficTypeDiagnostic: PH0PR11MB4952:EE_|CH3PR11MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 86649e6e-da32-4597-ddec-08df44b36008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|6133799003|22082099003|261009223027099003|4143699003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2aPmHbiafjlzbFZXFd6py9YB0dHFORstbmTA6kqXoa8msbWI0+adE6CY/FEyilvokdUcKlvZ0O93riHcCTIvTqa5N8zqroNu7iZduaEHwQyOAxrH9Vl5nLsYAv8KFqlxXq75Jg2U2JG0sQH4v2bqLCdLuBNU/ouUqGRC72e8EGaL0kdKSojYE7aluVA6rxrLJr4cYyJYqlOHm6TRJMZqFbryCvKQ/06fJLAYOMadWbjCHEZVrsKbyBs99iC29lN7BP8p3riXUqOYWM4cQkK1LUIQQmJMLMhzNUFpltiAX7NkEOdAKKHDhbSkhncdSyJjVfI1hAvkwWV7qamzpwD+kv1LYhNbmNgpBzKfoazvAcKh/MC/eTl4XOgwhJ7aEFmpjj0OQLmkMyTPxBAhKPV0OJRSXXN2D7xBR/V7+evOezuqarNB1j1Af69irhaLzqG4g8Le11worqIKGUfDeOgzBO0JhavAdhlIHzS3yXxFR2XHsgD/M6+R6jK5S8+qO+sm+3OtIWof3240c8RPyFQ8pqNYMCBj1beAsN/ga7T+wmF8XxIUXCuV9YM4QXJHkvkJW9Mde0i5axLey3GQvpjGR/BJM9X5pVFDrATbrpiN+oSThdTD0zgDL6vJ0CxJp2fn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHptMXp3cXdiQmNDYXVaQXh6dHpmOExaNFFpa1VVNWtWb1JPa3RIOWNHNzZm?=
 =?utf-8?B?bkhhWGYveWFMeFNBVk5GWS9aNzBkSFp4TzRCb2VoVEdNL1NHRlZkaHFmc2g2?=
 =?utf-8?B?ZUF2TWVWWUh2VDlUQ0R6Y1ZWaDJIWVJoL3RhTE4xVHE4WUVzZDVaT1J5Yjcw?=
 =?utf-8?B?UGozbWpyQVU1ejlkZ2xoZ045M3VoeU5QRFhTMEJZaHNmSUtSN3BzaEg4L3Ey?=
 =?utf-8?B?ZTVGL01SNnFCUDJOMUVpQmg3dUNBZURhM3RDSmF1SSs3RlZ6WE9Ob3ZmWTVa?=
 =?utf-8?B?T3QzWXlyWktXM2pIWnRMbXI0WTA2WW4vdHNrVmRPV0pud0xxYlB0bWsxSnlY?=
 =?utf-8?B?Tk1aZFV6cWpqc2ZjS1BqNWI3OW5zbmgvQ1hFS3dhY1dWRkFxa1dEcnF2SDBs?=
 =?utf-8?B?NHcvdXdyRk5nc1E3V1VjMkFBTENQUk5RSU44aVVRc2hoL2FMNXYzMC9NbjVT?=
 =?utf-8?B?QlNUK2VENWpidWZrMUQ0NnNZREg3dThidlZhWDZyRmx4VTN3SFpLOHFQRzd2?=
 =?utf-8?B?VDRqVEhBeUdiaDVCdTZaZXBadGJWYmlHbVQ2VUlYTXpkWUJEVy9FQk1Vb1Zk?=
 =?utf-8?B?THVGWW83d2cvV2lwTTFxUHVEVC9PdTBzUEh2eENpcERPZXFvVDNDRzBnRXd1?=
 =?utf-8?B?L2xkQzRzM3lYOW8wVmtEUEdETmZtR1pOQXhxWDBwSW9XV2t1K2IxVW92Rmc3?=
 =?utf-8?B?czZuT1R4SVBWZ2JZUkRHdUh4bUVkSlUxY3kzcWk5SjIxaG5zd1BRVnFoWjNY?=
 =?utf-8?B?RzQwVWhVaW9DTmFvb2ZRZzhyRmRpSnVZc2xtRlpDWStVUk5TSWRGWEs1OUFY?=
 =?utf-8?B?N3Y2aUd2NFQrcFdMZm9TeE5zK1pzNW55SmlDbWwyMnhLNG1ncU5nRjZJMXA5?=
 =?utf-8?B?RVZCVlVuK1BXWDI4TzNhb29vRXRXMXJQdXExUDg1RkpaQzhyZVFTelZ1NHNJ?=
 =?utf-8?B?SkM4RGYxM0dqQUpCcVlSNnJicUc1Kzl5cGphdkc2bDN0b3AyeXNvd292aisw?=
 =?utf-8?B?V1RRaWtpUHBnWjNNU2dFeU9ndnBBUjFENGZkQ1hqR1VCY0FaTFNoc2prTThQ?=
 =?utf-8?B?S1JVR3haTmV0dnRaTTg0YTdyb3RKRnV2S2M2WFBSTlppcS9DTS83TFc4WUVF?=
 =?utf-8?B?a2ptNmtETlg0YXBjRjhaVWZEeWFuZEZBWWtUTU1qM1VLdmhwKy9qTnd5dDBD?=
 =?utf-8?B?bkZwc2lTSHdLNzlZcUh1UkZpNERJNmEyTytSb2lkaG13aWx4OE9wWWpqZEVQ?=
 =?utf-8?B?RllUdGh6RHIzV05OR3crWDg0a05WK08wN29FV20waDhLaCtWMXZaWmRZVCtR?=
 =?utf-8?B?WFVweFJETmk0NEsvQUsvN1I3S1BueUFaR1ozWStDRFpWRmF4REhaYndPYjRZ?=
 =?utf-8?B?RmgrK08zVTFwMlBCa2xGZVYwNnhqVlkrZkNxN3FlTzIvYjFNSmFBelBqaXBV?=
 =?utf-8?B?MHpsT2lYVklKNHhKNmg5MG50R253RldRWXMzbmRibGdFdjRMRlc1YStqWTRZ?=
 =?utf-8?B?MysxdWNsVVNCWStxekF1VmQ4SHFUQmZVaXpSTWhscVoxVm9lRkJETjBpTXNh?=
 =?utf-8?B?MEQ3R29Rb0RiQm92ZzVOVWIzL3hERmxNMjRrMGJsRnVUaDd2N2p0Y1cyYXpr?=
 =?utf-8?B?Y0wrRExXd3UwTmhqVThKWXlxZnd3eHkzd21OOU93NndTMDhNSXoyc0VrNjJr?=
 =?utf-8?B?MFdVTGVkM2QxTEdqWUlWTEpHRzdObThYSUh5TjU1TUMwbnptblZIaUlPQjhU?=
 =?utf-8?B?alJWeFduRUVPMU5TMGdCTnp1eTkvSHFaMVk2Z21BR290VHhOYnlTSWdEZmcx?=
 =?utf-8?B?Y0R3Z2F0eHRZM0tjUHI0SUJXMUxVSFNBeHJqMWpNWG42WGhJWUpSZk1MOVp0?=
 =?utf-8?B?b05GSC9zR1dGL0gwUUpkSkhzT1loT2ZDdmJQMHlWYkI1cnRkbGVaYVNGcXo4?=
 =?utf-8?B?MVhRNE9zMklFZVRnVVNsOUVQdlFZN0FGSVVZSVlJYjZEeGphOS9qRGptNTB5?=
 =?utf-8?B?alV6Q2NNVUNWQnluOC8wS04yTlVJRHlucDQ1Y0JRR3kxTFNGazRoOXE3L05C?=
 =?utf-8?B?OTBQbUdsaUpNdnVHVGR2aGY4S2JtVkFKTWVxV2NjTVh1UUcwMUpFYSt1bUlM?=
 =?utf-8?B?Nk9iQy9pUGpyOStobTN2WThOV1d3a0dEWEtOdExIeTk4WTdjQWRDUEFiNitG?=
 =?utf-8?B?K0l1N3drWFFmN29QTFRZVkw4QVhNWGxxWUJZWHlBWHBlVTBtNFJuRnBPUjNU?=
 =?utf-8?B?c0xpblpsYjVNOEVCNzJwcVYvdnRscHorMFNTNEFWNVVFOW9TdGVpMjRURFcw?=
 =?utf-8?B?RmE0ZzFFbk1Na3VxZDRzRDMwdVltRjE2Y1FHWWVRWXRHM0NVNGdUUT09?=
X-Exchange-RoutingPolicyChecked: hlxOCx6yMFFTHf34njkcMx4WrmkAKxBJtq39UqSV1ZGtFFtCzNMculQTRm8GJVAZwaAzv6sPTpLdPrRWqP5lx7rvbwbFsmMa/v6XK2ZQ2oip7op69Uputjf4WmJB2MovmRwgehm6ZEKfXjwmuIdS8rBCmh7OEw0C2CPhluIgmBZI2h+jK/B+Wd3q/fUNRR0/2+5ygZ+xlu+MSbwYEF/woBdey3lYYQENph8M2y4rQY+cCVX97z7+XQ+AAykKmqjbz8Izco8fs6dt0KQzQpKoP7QXmg9MZa3yjS6Uy/0VYqXIZ5dIcwdBhEQCanpMr9BzAjouSbaBTe3P6z3IQVWixw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86649e6e-da32-4597-ddec-08df44b36008
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:02:11.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9n2lfJhRqz3nrU9/FFNZQ1bWZhCvJrqpRrFf1PC9l+3/J4EWzyYjWhUHZyqJ0c5L0Zo7+2WrCtoWsAJtN9UjpohgSMP4DmgisGsI+ei7Irw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7722
X-OriginatorOrg: intel.com

On 11/17/2026 2:09 AM, Mark Brown wrote:
> On Tue, 10 Nov 2026 15:20:07 +0200, Temitope obabi wrote:
>> ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5


There is a separate thread [1] started by the author that will conflict
with this very change. Ideally only the "remove whole header" version
should be applied.

[1]:
https://lore.kernel.org/all/20261111223102.1310-1-obabitemitope765@gmail.com/
