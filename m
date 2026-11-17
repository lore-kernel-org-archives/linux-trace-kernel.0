Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924189;
	b=I1kA5yrAYlOOugNLCwfG6XGhsrhnrYcJzKVeHwIDI6Lg8N4lDCbubdNziyhXhb0ZgcqQ
	 0c5UQdZsTWrh3HSd5pIhoei9djRmNB3m2qbXUg3Q5zl5DiCGnQcB7gzQZiXOH6gbPgCNG
	 TKrbxIrqwPwZmgKILpxD4ktjuNT3mDcFMlxhqdIiyf+xNs5xmMKXYogluplaNL+7Opv3J
	 eJ62Rb7jw+cC3x3IwbR9s9t07vqb+gcmqcX+KzSPb/ufiYcN6gPI9tm7ntKu2XC00slDW
	 YRneRqY7p4O1M7k74ybRBj9DBGUwje5mu6bKd673nAp8HiozrN2Kg9RCE5FUxSxSzlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924189;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:From:To:CC:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=pxY8SuwSUwvvvA5xM8w0JH3pbOy6LmAqxAgQhWaFm2g=;
	b=4RjkZrMeuzwNTV/HCyN2+lxCR3VlT7WKgXshi56+hnHOC68KRsgGwfBXWhiOlNpvqhHb
	 JbuTz9NqcNnBh1e4p4FC8or8vJ+Xr8cbaEBKUnMMX5mniNDtio/WyUj3ReFe6qveykr9D
	 w4BeIdU3RejykGmSK4vQ6S+wYhoH9bROZH7SX3ICkEXl0v1JlPCe4ZgQc3YGhwy50aSP6
	 Zp6+/25Bgiwg/4qxrl894947wdiThnF2VQJJeBFwXrw2AjHj6335t3+ZVkjCpzBEj2+ku
	 F7EuiZslxx4i2r27q1nWdCl5omRSLet6GZm9EGdChsgQJLF4aFpLaV/kLz+R1lt2igA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cmailQ0g;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VU0NoNts;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC5606A330;
	Tue, 17 Nov 2026 14:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9CC5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cmailQ0g;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VU0NoNts
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794924189; x=1826460189;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pxY8SuwSUwvvvA5xM8w0JH3pbOy6LmAqxAgQhWaFm2g=;
  b=cmailQ0gcS0gD3okyBa6jGtXjHUWlHJpIwuUVWqDUegDrHCUNR1vBqwE
   wvfj4XXijXEf08cT/X7PpbEy4o5l6CbVc99mV9QAT9ZuKEvXZTmnGlsHX
   BGDsqBPidcWatatlaR6QmuexxGqulwfJnn2Be1s7a1HhtqwYgDOtufsLJ
   hlTe6oi1hbFqywwtjzIT32q39UrbsbWSGNc4Dht3wPT00Av0Wn7bEcPl8
   +9KI1hfIfxn+aa5Kvthwz765L828j//xZMzdtu18JDOGmfDPEoXOKWR9j
   0BOhhj68MzkZIwQosTxsaBvE//9LLm0bXlK6EgfDnu1Sx0oafHBBBgo+c
   g==;
X-CSE-ConnectionGUID: 3TEetKFgSMGmXYPAdZW9pg==
X-CSE-MsgGUID: 2WFoLU0BS5i9Fl0xEBSC6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3717008"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3717008"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:03:08 -0800
X-CSE-ConnectionGUID: Bahg7PlGTFuibniPfSjrKA==
X-CSE-MsgGUID: 4GJW8SnkTEaHMKGSKnLyNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9808045"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:03:08 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:03:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 06:03:07 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:03:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZ0UvSMej0UKwp1L3pVRccCgSfflkR5d4b+u+sNeyppddkpWjXvcCcTWUGNR/LnDDqm8on584wAEyzJlpn75tsXq2NcPddpyLBQOnLxu9LZkhSPgqGiCZOVRtlDD4oO9EG/f0ZXZ+75ZBHjS1RN7GLkhWUyrLWE+8911U6+f67DjFr0/QebPZaJ9KwbDpCKMOGdLzh4vLBS/JwsvilU5bkdi4MquQbnB92dPDD7lIbwKg37MHTbxo8kEG3y6k9eDuyU1QhPuK3sDG9chKo5j0OXRVuE1lomNHNTyYdN4ilqZ8oZJeD6M5NLDaurDBpu170ibiavOuqN8cu8LGUOL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxY8SuwSUwvvvA5xM8w0JH3pbOy6LmAqxAgQhWaFm2g=;
 b=QC2Y4lpa1WNJuonlwpZqnrX46ve5DTkUAOjYhvL1y5+CNIOuudr4/2lDCxegjGnA1cLesF6hiWyIDQrFi+dqz9doEQS9R5mXZri6TVW+RfS2ZXVKMt/Ak+GLOdZqURqXhRIkypmRphterIi4j15hIyQiVYhbXukh/q7mHSc5Ggt8QIa14aKMKMHjwflGX85dJq8ZeCefH60l3satfe+9mebHooDkuu65Kr72MFtB5sv+qt+0cIx0Y8SVQx1MO45tPX14CROZr6Le/SYdKBBzp6/sE0yHymUkjdA4jldTLXolu93CHmFK+Ve9kDqSZUHkeOmwcuVGxttQXiGA8lBvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxY8SuwSUwvvvA5xM8w0JH3pbOy6LmAqxAgQhWaFm2g=;
 b=VU0NoNtsPiFsGb9zmBjC4lsQ/WT1nMqTmtl9f7NXeN76vbNx57x8LGbWgS+uln/o94AnZXR3KtpJd4JSOY96cJGwERDhz32cZJiXiDu/RwHVQ0zByE799iOt5EW7AruJPTcAFo8JbZ7v4t9FPVEUfDvnSoBUFQ+HjGQBPWUaeZk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by CH3PR11MB7722.namprd11.prod.outlook.com (2603:10b6:610:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:02:56 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:02:56 +0000
Message-ID: <b1344127-25aa-45d4-8cee-756264231dfe@intel.com>
Date: Tue, 17 Nov 2026 15:02:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: Remove unused intel-sst.h trace header
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: Temitope obabi <obabitemitope765@gmail.com>, <broonie@kernel.org>
CC: <liam.r.girdwood@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-sound@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261117134538.1251-1-obabitemitope765@gmail.com>
 <2b41ca22-dc89-4e7c-8144-4dd6c02a5294@intel.com>
Content-Language: en-US
In-Reply-To: <2b41ca22-dc89-4e7c-8144-4dd6c02a5294@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008B1.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::685) To PH0PR11MB4952.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: bd10ead9-a63b-4617-bab5-08df44b37ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|6133799003|22082099003|261009223027099003|4143699003|11063799006|5023799004|56012099006|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: prZO+ZxwF6BSBYgUsGh8f+9RfCH5jVAtTAMRID4XFkiQQQUhkUiGeCEXv33MKp0Hu7aB+gA2WPIxu0z7TbF5tTCtaeKh9nAgWScdyKuM6APC7DFeqqY/98usOXRVvAKJVA5/9AX0HQff1xfrvstGFOve/A9Ob3QR1sGKyv1n0eIiY5HYLjwFCxHXIUyZJhZfFkH8cI4aIj1q8CFVxTMdmB30vSHemRIXYbp6laTgAaS4J40pehq4f7NdB9S+JyNWkoMrvmGXxtr58ptt6+0yCtptXypszZ1Uts4LpnQ5vbmKZBir+Wa33BL2nlDFIpOcfbxykYYIF0fKsUl+YNO9XRIvmce77msEb8DD/DVW3bY0IQHeySwqT7din/PxhxldmAOhp8xxI+PDSRo4RJWi62N7zspYJpp50gIZhhpRx5WC6SoHDk/g3Umam7uPP3krEKAB/EcbKfUlDEbzKyt5c/sF9Awp3S2EuNo7hf/rr4U3YdvVp9qk1W6v+CHs5vmobVenTqknmo6LwkzdfDfHir6k94gRGwWYXFv1Ea2NrPdyjdvFmNm7nJ7wRvdBFRaBmqfkv2DtPet9vhQcQ9z5zA2pGWxflmuSNsL5n0ib5aQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(261009223027099003)(4143699003)(11063799006)(5023799004)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2NXd1NKaG9sYUVyamVpcVVlNy9QM09KUkU2WnNSM3BaSDU0TGYzaDZNaFhD?=
 =?utf-8?B?b3NMQkU3bTRMaEJqQmVibFYvZkZjZ2hRQk1vWkh3THRubitTK21EM2NzYlhX?=
 =?utf-8?B?THVWOEtaSVE3S2UzenNkSmk3K3dFVWlYWHNEQlQ4cVRJZ0g1K3E2UldpQk9Q?=
 =?utf-8?B?by9uYm5ZZENLTXQ4RE5hTithZ2xVbFQ2T1R4MnFvNmtCZzZjRWVqa05qZ3ZZ?=
 =?utf-8?B?NXltcC9ESmpUd250QWdHc1o5cE5SbmY5cWRabmhPSGZUd2RQZWlQcFEydjVX?=
 =?utf-8?B?VC85azBia0xyempOeSthSWJLQXQ1WmRmWlY4L3VkVWhWU2x5blRmRWtiQUpY?=
 =?utf-8?B?bXVPZWlsdmVPU01STWRvUVFHK2NYWEl1eU9VODNERGl1VG1neFVGSXV4T1Z3?=
 =?utf-8?B?K2FiVUZ1SEpGeGtpanEwNjZuZFVJcEtEclN2QVJydTFNSUlWc3VxTGZQMDJY?=
 =?utf-8?B?SzFkODRHZDVvbENrYURwb01VTWozOXZteVlyQmYyaGQyZkRBcTZqYzUvVUYx?=
 =?utf-8?B?ekg2Tk51T2JVRTZVV285clZYMUZTN216bHRBcDc2SHVrNjdaL2pSVVhrSzJm?=
 =?utf-8?B?ditVcGNXWkFQQjJFeU1qZkJ5czNXS3JiUm5iQ1dWTG9razBqV0VBai9GcU5k?=
 =?utf-8?B?ZTlRV0lYMUZqSWtnQjFoRTNvb0grVlFOZktzQi9EL0dsMXRmQVpLeHV2blJC?=
 =?utf-8?B?UVErSVVGOEV0Y3dwcjlDU0ZIR29TeHRobVpkOHBqc014dmZlblB5TVVFbVJn?=
 =?utf-8?B?ZVJ2R3kxOGZvdU9ibkdaUHA4cXFVLzZCNU5KaEpLaVNrSWJXTFVqZitTbVNs?=
 =?utf-8?B?bkJmWnJpeHZjYVp6cG1BN0JrMmNIUldxTFVtazQ5T2ZCdUlCdkMraWE4YTJC?=
 =?utf-8?B?eWM5K3VMRE9vV0NwSUpnVGtlTGNJaVR5Uy9VeElhb2h2OHhPNUxqU2plTGJu?=
 =?utf-8?B?WWtPN3hUR2M2NnhaY3UwdXVHY0ljWXZMakZZMEFoNHJkWjBTREg4eEF1WnEr?=
 =?utf-8?B?YVN3NjAwTCtmM1hva0tqOU5UNlZZY0N4WVhJT3RjSVBoZ1BnZjRPdExpUkUw?=
 =?utf-8?B?akIxR1BBVS9jR0xxNU9xY3liVjZ4WWZkNEMwMnFucS9EczdDUlZmV1NsUmdR?=
 =?utf-8?B?ZStGQ0cwaC9rUGQxQk82dHZNOEsvMVdxZkRNeFRWNlFsT1NIYytZZ2owK3hu?=
 =?utf-8?B?cC9UY3F4SFhRYzJ3MGF1L0VjMjFaL0VoZ20yejBWWWdjMUtyRWtRZjJGZERT?=
 =?utf-8?B?REY4Y3VuNlI0N2hBT1R1MU1teW5FMjdrOStHSGh0Sk92MkFZM1N1aGpsL1R3?=
 =?utf-8?B?cnZOcDRBTU9xbEY3dTV6QlI3Smx1bjJTeHVHUS9xdTRudWV1OVBIcXM3NjEr?=
 =?utf-8?B?RUlNeXIvb3ZYS0hLVm9McTJFUUJ1b0FJYmN6ck81dHlTYVBQc25WeE1aNkUy?=
 =?utf-8?B?eXJiVE56aEE0SFBxdlc1dVVKTEp3VXVuUFpWUVkvbkRPWkQ2Wmh1T1NrVU04?=
 =?utf-8?B?MVhIc3NtYmpZN2lFODlrMFRWejcva2dkOVZTOW9ORVoxeldsdGszYzI1cDlE?=
 =?utf-8?B?VVI5d0hwS3F6U09GcVBLZmVxTWZMd3NwUEN1ZXNwZnc2bHE1KzZpY2pJVTRI?=
 =?utf-8?B?LzBWVnFndHN6QmN1M0dJSWptZE5hR2tUWHdNeGtkZWhZTlNwUFNuTUl0V1VE?=
 =?utf-8?B?Ty9peUlVRm54eHV4Y0phd08xTmU3a0F5K2xOMldVQytDR0sxY1AvREVGT0tF?=
 =?utf-8?B?d2NlYzMxZys4bytTRlpkTkxvMy9EMWMzY3JGWlFtQThmZk1aSXQ1UitLL0oz?=
 =?utf-8?B?SVJsZWtmdU1GZ1JOMXZ6cXEwQWVUN3h5cktSQTNDOElGSEtaQWJIcjlPODM5?=
 =?utf-8?B?VVlhaDRHSWw0RHc2L0FYaU9pNWhkd2F0elhQVXQxZmhYeEZWT2cwV2tINmRv?=
 =?utf-8?B?ZTlqekpsdldLWmdjM2RoRFlSUWFQSVp5dytMZGJwb1E3QjRFS2NST244aml0?=
 =?utf-8?B?U25vWXhjS0xUMUZtYzY4OXo1cC9qL3dHSGVMUEg1aGsyUnFNZlQvTi9YdWpU?=
 =?utf-8?B?K3AxMWZtVEhHZGt5UEJhZ2k1cFNWaUlzYzRnQXh1cVlJQndYWFBOWmJxUkFP?=
 =?utf-8?B?bG5PMjdXM09qOXY4M2I2c3hkMWU0WTNYWTVPbmppcVZtbVpsbzBmZEdNN3pJ?=
 =?utf-8?B?aXlqSDBIMU5CamF0YStOZVQydTZEWHAvV1Z3K2k5S202U1FzeGZhdmJMMlFF?=
 =?utf-8?B?dEhuSWY0eFp0YjVlcjlSUlpLZVd2aHFhL3dXQW5aVVJxSTdGRElmaGttem81?=
 =?utf-8?B?SENGZEZmK20rc0dZSjFXdWFZcm5NRktJaVcvdTlML1FuRFQ3U0tSUT09?=
X-Exchange-RoutingPolicyChecked: ur1YjSuiGeIp8tx0pES8KIi0FolMp0ncqg9CB66Yk2Vkxz1eWD78YjOrfDZ7eAOFnW/mOEGufzzTfom/zt+NLcLSpNum6nCFEwQVtZBmrRg/vk6nBYwoP/Au1OifTA++TGDbQhAdz1ra5dLDqwhZWkLU48xVwyIV34t1NTicX7p8jx2oB+piWzNI+wPjsomOqVOf+YcJAqByI+gV01ayvTTIjk6qXILKYBs2jYDi2ApzUy/exKTtjyuAtrfXU+weay33DwkaiLyBu4uyVbTtQS/3YnYqnQvYln9CIHpKIUDmOWu7r8V+FszSUfabBl7IpckYgKJCw2lpPPTXiHmWKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd10ead9-a63b-4617-bab5-08df44b37ab3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:02:56.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMEAK3OMCI/sCKWaS2f1o0Z6uDTmTDs8p4wMeUw5m6ubk9j4SJAHQ7URQBqk3z3bjNWcsGav4LkrFqiksQS9qcB0IJ9lfcoIvS9C/LNyv/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7722
X-OriginatorOrg: intel.com

On 11/17/2026 3:00 PM, Cezary Rojewski wrote:
> On 11/17/2026 2:45 PM, Temitope obabi wrote:
>> Commit 970d299b0a0a ("ASoC: Intel: Remove unused code") removed
>> sound/soc/intel/common/sst-dsp.c, the only file that defined
>> CREATE_TRACE_POINTS and included trace/events/intel-sst.h.
>>
>> Nothing includes this header anymore, so none of its tracepoints are
>> built. Remove the unused header.
>>
>> Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
> What's going on here. There is already v2 of yours [1] which has been
> commented by me and Steven. Why are we having a separate thread for the
> exact same subject?

Meh, forgotten to add the link.

[1]:
https://lore.kernel.org/all/20261111223102.1310-1-obabitemitope765@gmail.com/
