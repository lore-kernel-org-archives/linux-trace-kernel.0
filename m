Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924027;
	b=se/KQ1q/K2mItmNMMgB5cG0LNpUAURMpGNbp5ZmjMoAnF50Ys7FJEoRPBP8me+qW0RpP
	 xYu4CPhm2NNQOhXWbTUBBIlCfjf+RW/psqb/0cjesDWGoECa+i/IVZPFRNK/1Op34WklJ
	 weXgjCsx6eQimUZRYzBdhlK4A9OwDTVd3hiCx6IQ7rXYG0vEyn1Vkld9QxlyqWf2AxhQo
	 UBEY5Qp+s7xufuEQ08jIOc7pX+BuLoZ2VvNYN7oSUWdqiJ4zK98gJqkFsPdYAlSA0ZGYH
	 OjbQHNxbIPMCRfDod0gxajXk4CIYF5A6ekdXsNiNI0o3eZLerAuOX+7pRBk6sDk3yyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924027;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
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
	bh=jfjjPhTnUYh86+x1MsafSC6rXBR14MzHcgnup5vQwD8=;
	b=s5yQCVrCKOApSNdtVw6/4b5vEuHIl0lgUYyKnyWAiG1iATHToSqK/pLTLMHtXtPRPjah
	 +gWhgiKrx3k5xL/1xG4m5AEHmloNAVmiRGHe+iH5OZ1f3+kf50ER0dspKyc5GIenz/7Wm
	 b0grFMOTDw5oUjVIOxQFjWl2Kf8WKGDe6Y6WHVMcq4AEbvWDQCvLB2sFGAOLqOxBN63JC
	 o28nEzTWYubgo3SQgjgMZSlCye/WJC0+bW8kA4jo2OVfIYuQZ4gxocCxnDSqn01pRz+rV
	 gWfmN8a1r0jvh7X3OSVhTtCdxOb5S0Hz2emdjrF/aKNqkBWYr5SwOBmx/2BKZG5uA4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oG+9eK2s;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Yorm475+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F6606A32F;
	Tue, 17 Nov 2026 14:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 127F6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oG+9eK2s;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Yorm475+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794924027; x=1826460027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MT9hTEKN/Q4XGeglQIRklAH9j9T3FIBxGw4Ctmr3Hfs=;
  b=oG+9eK2sQSABwX6Ot3wAd9A633xJ37EomF1PUIL2qo9UJ6iA8mMflSgJ
   zYLOlDktz6y/joUB81CgJD5MA6fYWsjWzPWsFu1hEUjtPzWG9trv1Rxef
   HS3lIHs2vmeawQipotJtLoGxFUpR5KRHU9Uzs9Qq/PUzWFQ7i+UwiqVOp
   WSZypomZPcWpeYWuZcmr0xtqC4jZcy8q5cAIvsWohpgTW4yKvnOdavVG0
   0Bc5SLaDObGyfAs3Rik8zZRR9Dg1Xy0Peam+K2vmqHtcAH3w9UVa9XPKS
   scuOMhqydU2MlhaZfKg2znvaovUmK9BZynUkKpYt2MxGJzI2lmvlpJNM7
   w==;
X-CSE-ConnectionGUID: YYpNytJqRLmvfq9IlCVFFQ==
X-CSE-MsgGUID: 0I6JzUCVTxCb1LJDCngL5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3716489"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3716489"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:00:26 -0800
X-CSE-ConnectionGUID: RSmsgrZjTuWucAHCpkX3zA==
X-CSE-MsgGUID: neyUl7WMQWSfsp3bteH7Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9807732"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:00:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:00:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 06:00:26 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:00:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdJfdSgf8/WwExLpgG6TGvHRUPFe81pGackC+72r2RSLfYO29FoenCOjg8OSLxezdonX80v6aMmjaX91MMTY671b+KE3v95Gi8zis6fmqbhY316LKe7X8Y366qFx5m2cAmrNFfAiPlVih++ASsFrvaTkddBiC6IaNpNMvXCG9GmvES2PrOwaGT58XQ9jz3mHG7V/XL79u0hdhEykkvN6oluEOkA7B5mrOZXxyzkKbJWJvSEBG3XHbHsMe5HXcI2407TEDr/SVSzYau0WdJkSyUfMUtyoop72cUra70OlikObM2f7EVwfDoAI5d1hZTJBtDY6cfyeW6cYXeUdyd29RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfjjPhTnUYh86+x1MsafSC6rXBR14MzHcgnup5vQwD8=;
 b=GWkI46/SbgkvASSJ//sCNhYePkjuOjf+56X7FUueiGpf7uhhksljRW0YqVALV78tvLmEgUkmTJjANSEVq1vO/uKT1x8trk8FeupCCmntIsCMAjcVlpNjB02Dd+lV6XbFYDRUulXVXo9rr3FBo+D9+iteOaY6LoSP00YtwhEzge9EOCUVwEAnBmXQPeOgXarmOg6xJJ1ztlBqgjT72IF0sfHGJRyz8drcTu4Vsd5IaqNQalpb8z1jXq451hhxKzMCbJLcDZ7qW0m67uxQ3tzfC9eo280+EV6iIC7uutbTyjsOASBIxEFPmlpcuv1lygnBOLJOgXIagD450ROLJcMtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfjjPhTnUYh86+x1MsafSC6rXBR14MzHcgnup5vQwD8=;
 b=Yorm475+nGe27ovsAMNG7hy61+cuMkzsiKUvNqcYqIXRQD3DaFp7uD91J/XGhVWOZ+bkNdyECHOCHv3zGENuLFzr735KWkbs3WXR9Lvwklh/YiE55MUbxbvSnUpW4jD9bBm7rI5KPUBvRhPjGfTmJxEXlrBZpi9CdhEca78FS6A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by CH3PR11MB7722.namprd11.prod.outlook.com (2603:10b6:610:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:00:22 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:00:22 +0000
Message-ID: <2b41ca22-dc89-4e7c-8144-4dd6c02a5294@intel.com>
Date: Tue, 17 Nov 2026 15:00:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: Remove unused intel-sst.h trace header
To: Temitope obabi <obabitemitope765@gmail.com>, <broonie@kernel.org>
CC: <liam.r.girdwood@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-sound@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261117134538.1251-1-obabitemitope765@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20261117134538.1251-1-obabitemitope765@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To PH0PR11MB4952.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 1e47334b-0c7d-4699-6fbe-08df44b31f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|6133799003|22082099003|261009223027099003|11063799006|5023799004|56012099006|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: kmBRO2rKMV17yDki3YK3ZMoh/9boPAN9/1983x4KFw2mc64P3QPaw+2F+nTWsm0eKZ5+EBoRWvKI5429y32UizYgEJfgeiysW6SnG1dBKSCe/BO5wgJzXVpjuTsT16uaLQhE4nR5du8XgSF9n3CRP0BPOMsUcGU1pBpvKzVkQSYGvgzT2YqPJDiruIyNDnd2l5p9YatS6aeK4DqeyfOLicdq38cp1MNaNWg/sZwMo4bKHk0uyyZnVraTtVRxG4MsVOfJN9DSdOsBTH+v8kGmB5i1GX2CKz/O4qjU4WxzaCxxm4o0MIVPrbJZdZwfJIAIEvivMu/B275lJWnPt3EsehsapO4cm6UuvTqd/AlZGkOqdiVv1UdoXTZYdyJcRiDHLREr0GTfVEnjVhE8oOn027MpTr13k4Xa81fN8lTLOgXtUliFLV25FT4MLXukSQLwFCX63GzPgAt/0hpUCS59g9x4rwYBqAXL7nE22kKlCr2EGnX/zpcP+tvldTO/p5hAmxDCuKE0+XZGML1VBZSPRmIr5hzXmsp9wuCfwyUeF/b0YwyP4mRIsLQXWRB4NdaJRx3GKrrA1DBDLTxbljLAjss+gmCU6x1yVJSQaJJinIODLw6lDcnrQG0hwoLt4WzMtm3rx2KJoG5H9jft+m/hBuZebLj/9LtlqavUc6xQBy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(261009223027099003)(11063799006)(5023799004)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFFvb2RkOHNVUTlNM1FaalRQazd3cDl2aTgrS2hIUEFmVDZKMkFYVkx6VlR6?=
 =?utf-8?B?cjA5NGRldkZUNzFsMVZXL1lYd2RrN3VVaVprbWxHU1Vub0s4eU9yeXpNd09L?=
 =?utf-8?B?elA2YXNKYUx6ei9mRU1aWm9ydUNhY1pzNDFxNlRobDNkWFNEY3U2VldGUldW?=
 =?utf-8?B?cmNlV1JZOW1ZTFNac3R2YXBWaWI3VXZhQkRiRlgxMlR1czJnZUVRc0tLQ25i?=
 =?utf-8?B?US9pYXBuVGZVUFBpUkJSSDVKaVprcDA2UTh6ZUl5dzZ0Q2lVWFZ2TEJRVGdR?=
 =?utf-8?B?Nm9wdzMvVk5NU0RHMEZtT0QvbDZiVEY2ODJDa1UwaDlIby9rL2xrNTFDWDli?=
 =?utf-8?B?ZWdRQlhyZG9LYktzczVraXpWaVVveUx6bnRkK3hxSHpIM3ZyVTVpRk80NlBy?=
 =?utf-8?B?enp2Rmd2dmV3bzR5WlBDdXIzQndYQXV3aUpPdGVwbUZzdWVNbEd3RWNOUWhu?=
 =?utf-8?B?dFBHUDJOaERJNW9aVFFaVkhtSjRUYjVISWlzMVo1UndnWi81ZGhJY1p1R2xn?=
 =?utf-8?B?R0RaaWhndkQ5QTJXeWNadkczVUFjSGhobGFYZXhiOFBKc1NBR1cyVE5vbHQr?=
 =?utf-8?B?RXk3S3NwY0gvdU1HZU9KbG01ZDM1SVBwRHJBZ2N2dVBNNm9nSkJqMzNNVkRx?=
 =?utf-8?B?bkhPeVU5YkNpclNLb082ZUI0RGw4bCtOTVRLUjM2dkgvZnBERVMvcVlqL3JW?=
 =?utf-8?B?anFsTlVZeldVUVI2SlppazF2YU9pSEc3OGg5aGNkZ0ROYVk1Tk80RWhjM2gy?=
 =?utf-8?B?N2VHanU2WGlVdXVJNkFOT2c3OWdVUnZCejc2MEJ3eDNuYUhNMlRITG0vZzdn?=
 =?utf-8?B?MFBjbi8vUko1U09yeC9valdGUTNvdy9PYytIamdYSjR1aUVHMkpBdjZoM2Rk?=
 =?utf-8?B?dzI4ajZzVU81d01uL0EvV09uMXVyeVFPSTl5RVBiSlBJbUo4bkhrM3dGYlds?=
 =?utf-8?B?bzBnN0FaNjA2WW84UHZ5NCt5NEdlbWxzeVpRbUxNRWIzUzZFWVB3Wk5Ddkxw?=
 =?utf-8?B?QWxmM3VkZnRKd0NlTW8vYTFVMkRnNXVNQm04dERHVVRUemFDZS9SRW1FWmRJ?=
 =?utf-8?B?MWtyOXdkQmVXYlpMRG8wVTlVV3NVN0RwZlJyNTdQSVY5RHZWekpOdHE2K2t6?=
 =?utf-8?B?M2doNUc4VkRlaUdEcDlRcHVwVk1KbHpzQTA1aU1RMDByUUJ5UFJNQ2xTUnpY?=
 =?utf-8?B?a3VzbHRRcER3WDU1ZEdMS0RFbzRxa240cWJOUTBabkV3VVVFQUFENy9oN3Nz?=
 =?utf-8?B?NGx5N3I0OGFnMmZlSWZQRUliQlNhRUl4YVVLazdGdERncW1UdHZOSWFWV1Fs?=
 =?utf-8?B?azdkbmMzUkdYa0pteUt6SHdFTzVuSFhoOTV5T1lkeHNFeUFZS2E0UGxUcDI2?=
 =?utf-8?B?L2R1S2RleFJSSlFQMWg5eW1tcEhIS0g0Ky9hZE1INUtKZGxMQmNUR0RvVkRi?=
 =?utf-8?B?OGZlWXk3eTdTbk43N1BlVmlhcjhQdDZSNm12b1pBeHpEUEw1d1FWRkdIZnM3?=
 =?utf-8?B?NWJOTU9vZ1kzK3Q5b0doOHQwMXhyT1MwU1pwZFJVa3BxR0JDbWphNjAvTG9k?=
 =?utf-8?B?SWY0akNxQVk0bnhvNHBPVlhrWEg3TUxlMWtWZ2VDWGRGdkZVNjgrUFU1T093?=
 =?utf-8?B?WUVIck9jMUlGWGgvMFZabHhzSFNWdTJwZ3lQWm0zZEEyVXZXUzhCMmd0Yndw?=
 =?utf-8?B?ejBNL1NWSnlsOEYvQWo3bUJkckFBRklRSWRjV2NheUMzWEZ2cTkySHdpWFlL?=
 =?utf-8?B?cVZRRklwSTFlT0U0TGJFYTZnVld3YWxoY0ZURXVRNnJ5STRuY3J5c3M1UWRZ?=
 =?utf-8?B?SGRCNlRLa3IvLy9iM0VsNEowZlQ4VDJ2TmFlMitYeG41a2MzYWd2cDJOS2xD?=
 =?utf-8?B?elFJL2JZOGdTNDNsWmpqRG9uOVhVa1o0NTNMZU9QdUJ4QWRIOEhSMS9Ka0pj?=
 =?utf-8?B?WDFnUitzNXMxSmM4dmpnU2FvWnd5NEsyVHNBSk5mbm01aU01TkYwMDNCU2V0?=
 =?utf-8?B?Z1lDdkprSmI2UldzV2FxUmlEc1oxMjd5TmNrdkMrR3lFZzlzVm9oMlFvQ1F1?=
 =?utf-8?B?b2hrKzQ2QW0wNlVpU3ZVb0FZd0E1dDlmeEErNS9KaEo3UTVOOExnSlZsWVQ3?=
 =?utf-8?B?Qm1FYURhY1JidysvV29CYVB3Vi9uTGcrdzQyOVJ4Z05GcE5EY2RaSkliU09S?=
 =?utf-8?B?enIxbFI0TklvREhST2M3RUx2RkkweDhUaUVNeW9UVDBmQmpzb2RMZmI2VHl4?=
 =?utf-8?B?R1BneTZtTktBTmZSUWdRenZLWlUzeWNWekhYaGQ1Vm4wL0RtbkQ5a0VESURN?=
 =?utf-8?B?dk1tNXp6bGZYajZpaERpWWZ6Zk02MDR3NEtUbm03b2ZXZmJyU3JPUT09?=
X-Exchange-RoutingPolicyChecked: 0k8tnYn0X2iNohqiWawJlkxxpAgE3obgdHUFlr2z4I983tzg+JizyN+SwZpWzEALDPIXnPkSP7t3NCDTCYpE5EQ6TmJqeVzslnFbpyU1ldj7qIYEa6mHrcBIrKH3cHWrC5vqezPItomqZ3eXEYVm4aIYqRH49G+stnoGEG1DaCjYvj2fhKFn9vG4hu/zi75gNlDoE4J5qkvK5tOp4mQOof10/Xo+mr/4gAp5D1PBSIvGem+ZrzEym6FRx3z3I/+tmoo/AxbIe2YyxdFsSd9TE85F8IOa26KzseOMkQvlZYACZqUN9baZA17ZCr1h59ZrfSiEbZrbktwkcOlUPfG0sQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e47334b-0c7d-4699-6fbe-08df44b31f41
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:00:22.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfJhs/oLR1SJu5+Uk21RVmnFMkshZq0zu3wxXCAOwICHpZJ0/C5V26ljPYodwjJQHXjBsLETAQCwQxpApg/coa4HuAxaio8He8wilzb1BnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7722
X-OriginatorOrg: intel.com

On 11/17/2026 2:45 PM, Temitope obabi wrote:
> Commit 970d299b0a0a ("ASoC: Intel: Remove unused code") removed
> sound/soc/intel/common/sst-dsp.c, the only file that defined
> CREATE_TRACE_POINTS and included trace/events/intel-sst.h.
> 
> Nothing includes this header anymore, so none of its tracepoints are
> built. Remove the unused header.
> 
> Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
What's going on here. There is already v2 of yours [1] which has been
commented by me and Steven. Why are we having a separate thread for the
exact same subject?
