Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792698859;
	b=2DI7w86aep1gus1Wu4afYoWiQTFTboVzZN6z5feHwsjrlyXvev015moKyTCjrfaoZVBt
	 MuyBy473IPMciqTKY3hqF2Qpbac3fOp/NDBvfXBNzUTFsDauSu+Ns6LGidw87CwShidPw
	 nyvBPwF9CXt7+DvJpOsoL58L+brkfkOwtqcF12Y90PWBzjgvqt0qe1gOMLiDcgMnSApic
	 +mOeSOZm+keCs4N7zTKxee0EdW0YcDUl8RXwv1CPrn1Mz3Zso4Y6FR+qebp9YQY9Xuod/
	 VDITZp95PWhnFD+QF7EcNzQRlLllIq7jOvR0bJdITfakABKbqRb2lVlhoQipKQPQh6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698859;
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
	bh=0A/AsXGs6oLTjxgujuTNthK700PB0MIA+b2x2qy6i3U=;
	b=l07ABdLabryO4TfDu2i6q91o4TsnKRBipCJQygcWXTeUi19poX8ZaqUrJrNlBS35JWRx
	 +QFYaNyEYFUx6TYHps41NM56JhyOl8ZxYMoCTnwVSa9VQYI934OpDQlNFoVb0cSr6rFW7
	 7M0b4qohZBXon01hP0IZgOil+bA7ZY3wTrjE6EYw/sngw4BVN1RTCEIKfbIM3Nzb2MZ3l
	 I+fR9GdYyCcrMdkNXI3V50rEM08DxOiWVGBBUgKes3DKXbjc/7udfJy8JHX8SFP/xcpzv
	 PCVhzq1u+32m7F2TrkrDSHXZ5jrkPXc0GRuENcoiDbbz/qRf+UPK24Hbk+yvnggL6wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NMZAAv0h;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40F606A319;
	Thu, 22 Oct 2026 19:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF40F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NMZAAv0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792698858; x=1824234858;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ACh0zb52zj2YS3craHCxn3DEM3VqOMiAqM6Hpc3haQc=;
  b=NMZAAv0hHMQR6a2dm35+/u1s2u2BfTG5r0uPAgTngW4ukqDatbIS5FMN
   AEcTAxv4igzPBnRlS8gcZQ+Hy/bY2bTkZZfGLexPlylplazh/WNDyDxac
   p9CYXwrBm+Ihz/7EX85vIXD5b4/pCUmeUxoXGH4VSUA1U+rVWmWpOVlwo
   xiG1wgaQwA3KA9OgyJ6XcG0H6vcbPNT1a7rsgXH00VZk3JOmX0v5W8zm7
   AmBMiBSP1ICZaU+mEYj297/mpHhcfAgpPD+1W3jq3koncUJGBap81/jFd
   Vzhl4EYQ3NJPILv2g33QHcqBdlbnjvBpe7GiIRhcPJZvB1GyPoQ0zMDTg
   w==;
X-CSE-ConnectionGUID: MNb1ki3jSbewveSRwTvMsA==
X-CSE-MsgGUID: LxPSGRtZT6GXPh3v9EubXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1467550"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1467550"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 12:54:17 -0700
X-CSE-ConnectionGUID: DOPt+KpySgOHuMYIz9r1oQ==
X-CSE-MsgGUID: JSrXkEpdSBSgv/o++npdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3543792"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 12:54:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 12:54:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 12:54:16 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 12:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydUdYSC0R8X1FE5Ue0xvsFzpfaBQ5XGfgFz5V0iNo9tFHjynvs4JW+Znk+mlFET4uACmkfr7yKHLXIgnc0hqA4d7SgIL/jtJVHGRo6gvsdiyang4fXOOj42kyCuzKX364+kDrakOFhu9lzCndrg2wVI9i8zYES3jzp+L8UCvSEiH34jiIWcl/YDHJhpsr7WgaJB/W9syRh1HNI2efCxzvV7tm+sbLM9EAVWKrHtNd0c67U24y6xFDkb1PAHZEuQYpYtmUO15NM+zlBhxr5CJk7ryc0kiZaWcv0tnQEEvt2lcWYxqb1pR3Llol8hCU5H06bODs6wwnaQfXBWx9MzL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A/AsXGs6oLTjxgujuTNthK700PB0MIA+b2x2qy6i3U=;
 b=xgFQ4afRYT1+ySqnz5SMeoqYqDSpulWgrCTq16+GEh6rjEPXJbpsEwUjyNm/2oQ36Ec1Mni6g/qhw6upvy5vSnL61NBJlJ6Do0NWYtLWOCF0NRf5MNduPVqrH4ANMrlUKBWSYFIDPwL2UfCHzOATZ49zZ8E+04f5k5vPh6PqNOJgA6jZEO5JED0aADTyyl+L6ASBdJll4JtZcYNOMdbW+Y5/pENBCFEbyoBcOCQBmonlsTJt28f9t2AkiW009AILvZQXml8SCT9+JgRPH2x5a/EYdjxxNgKWqzhB9l+/NL/ttmaRrnjwL6C0VqJT4Cb3JLYQUGaU3AlNXz6HfCm93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA7PR11MB9594.namprd11.prod.outlook.com
 (2603:10b6:806:4cf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 19:54:14 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::3c00:3404:321b:fb35]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::3c00:3404:321b:fb35%7]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 19:54:14 +0000
Message-ID: <ae46d1e7-6e49-405c-b4ba-9f659f5fdab3@intel.com>
Date: Thu, 22 Oct 2026 21:54:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: haltpoll: Only define guest_halt_poll_ns
 tracepoint when used
To: Steven Rostedt <rostedt@goodmis.org>, Linux Trace Kernel
	<linux-trace-kernel@vger.kernel.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, Eiichi Tsukata
	<eiichi.tsukata@nutanix.com>, Julia Lawall <Julia.Lawall@inria.fr>, LKML
	<linux-kernel@vger.kernel.org>
References: <20261022153359.2433474b@gandalf.local.home>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20261022153359.2433474b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0052.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::7) To DM3PPF63A6024A9.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|SA7PR11MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: 956ea737-86f1-414a-bf96-08df30763f69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261021121427099003|11063799006|261009223027099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KJJbPosUy5YefZjTRJx4tzrmmVaOZLFPyM1zsmNxAAj+jo1YXBWjKLNTzkX2dyDogikeWbvBb6wo9P6lM9uxCpEdFEmaxsvX/rl6bTu5sj5GnZuD/WR4aDaU6MZhjM66Q+MxXINZsOa6a3tyLVOnm+7c1NF5sFOWLdLrk/0aKuPev8Prh8j6+etRO47v3yr/bmdnc0NWZRyYmJ8mmjPGfCX0Hq+3boyp+VD2psbqFGmHr7HMUvp7vUX3aWJrpO+VtGICm6jBBncuorijMidh4ER36JY/IIu+6yDafG1oaaDuUoELb4IxrMmylzw2S6cM4wIHHpd3b8gfjxNGlP/Tk8zQESlZJrhkJuIhaEwh2sDL22/X2QSOtYlPfEKZGd1Y/NrbRujVRibysmzl0MtN4S1cMDhLkAvaQu05MHKwIc/vfETwxiQd3qmJcHLsMo2F+IWDq6EQEfZpdJl+YG8F2gR3J86ngeK/NY5+pBKVl4VefUt9fLdDCNfiNh0/TLuSge2iVKXQS6HUrzvQKLf2c00MEU/FieTd6UeVduhIVRkB1mFOBHcgLQuoYsdwYNHh7bgMPXDKvFzIX4/JOFGRRMErpVEVmgYcJdKlwWRwaz7KsGMaiw4tASM3wZ/Xbhf34y9Wo3WS1bGJ0IB4SeJFt0efCBHZgXqyOjiaFzFK8eU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261021121427099003)(11063799006)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRTNktBZjZMaDZtVlBRd2tlWXpsblJta1ZYRGpzN0RhNjlOUUh1WU8yYVV2?=
 =?utf-8?B?aUR2dGN3SjNoSFBYRk1DRFNSeWdKL3FTZSttcHlPOWNOb0J4SDVJNm4rcXhC?=
 =?utf-8?B?Ym9zMjJ1TmZjZCtIUDJMTmpITEREZE12OFVwY1l0eEZlcUpYOUc4RWlpK0Q5?=
 =?utf-8?B?L2NUS2Nvb1FXNWw1eTFVZGF0cEFsbUUyQUNvM25IckgzWXpncmVIcTUrRW9h?=
 =?utf-8?B?QmJnVWUyYXB3M3FNRlUydmhRTVZ5am5aSmpJemNqRU1hODlDNmV1NWh2dFZI?=
 =?utf-8?B?QWxYdXpnVHJIeEYwYkRwQTcxQjRLNk05WkNadVFiVXhoK0RoTVVjcjkxdnRa?=
 =?utf-8?B?V0xNYnJyKzRWck9qeFlKQU9pR2w4cmJKMVRteExGSkJOUW44ZjdFaGtkaHZF?=
 =?utf-8?B?WDlPNExFZHRoYXRtOFJOOWptK2k3MVFtSzJ0N0hyLy9pdFZXZDUvZVRpSFA1?=
 =?utf-8?B?ZHFocGptZ0RaMy9Ic2ZBWVdMYm01QkZFUWtmT0ZUYlpPK0dBQnFZbDhLcUxS?=
 =?utf-8?B?R2NvVUt0aHhRMHBIMmtZQWlrVnlrd1JYc2MwdTlXZ3F0ZitrM2h2ditjclZu?=
 =?utf-8?B?M1k0dXN0UTM3WHRRS3BpV0hUUEE2cHU3TVNMVUtCNmVrTUUzOXQ4cDJYNVJk?=
 =?utf-8?B?MXZXekNhaWV0Rzl0a1JmbmhCbWVETWFjS2VkKyszcGhkdk1HSXhhQnp3dXZ3?=
 =?utf-8?B?aFVmZFlJbTh5RlV2VHFVNU0zcmh1WTluUGtwYlRDNk5QQXhNQm9TTVhEWDhj?=
 =?utf-8?B?Vm10bkJjZDdnbGNhczhVNjVKd2hnckEwdDZua1FhbUFnUVZqY0JDMlVhRTl5?=
 =?utf-8?B?dHdIQW9pRGo3MmxodGUrNE1KRU01OVBlNWlQMmFraVBlSGJMZjYrL1c1eVgx?=
 =?utf-8?B?SjFnR2xqSzhxZEZmYitFZHJOTC8wb3pDY1gwTDZ6WVIwejFmc1BXby9vRjFR?=
 =?utf-8?B?cU9KRnZXL1dMdlRqSlRXUEE3ZDBDMURvMVp0NUJBT3FCdHdWaTA0b3Vva1N3?=
 =?utf-8?B?SkVYajhxaWhUUmEvT0h2dnNQWVQ0bnkvYWhiSDVWcVYxRXNRTm0xcVpVRnlh?=
 =?utf-8?B?MDVsU2h2TDQwdndKL1B0QTJYaWdSVFlyYXpVU0R5QjZYSmo2S2pxOWc2UHFj?=
 =?utf-8?B?aldKSzNWWm1Edmo4MExtM29MSFhTT3NNbjA4UWYrbDU3enhGSGthZ1d6clFE?=
 =?utf-8?B?R2c0TldWMktxOHVScHRPNFVlY3FKY2V5OXVyT1BKYjZUaDl6SVFhSFlTQ1NK?=
 =?utf-8?B?UnFMdTA0NDhodWpBcnNsalBCZG5JTHZKODJWMzdyTW1ZTjVINUJuU3M1Qi91?=
 =?utf-8?B?ZTRXSU9RZU5FN0hFNy9pYkxiQzlIelR6YXd1QmpqQ3p6RmRtTmpHUjZCVVM5?=
 =?utf-8?B?ZjNvSVdKekR1SVZvRWZTUTdRTDcvczRpRUFMZ2Vybisxd0RjcmhublMzN2dO?=
 =?utf-8?B?TjZvZFB4TS9QaVZXdWpxMGYwelBIRnh3b2EzdDFnUSs5Y2dITG85TjhTbkor?=
 =?utf-8?B?cEJ2QmlyNlpPUkdwN0RUVXRKK0FBeEhQSzlPU1Nqem4zaS9SOTVoMzRzYm80?=
 =?utf-8?B?VVlTZ1dKS3FwdHFwU0phY2hxczZYcUgyVGJrQjZUY2xSVjVYS0J5K1poMUth?=
 =?utf-8?B?ZTN4dHBZRFhjTXVDTkpaWEo3V2VRU2RMVEROWFFJMG5WUW5qRGtPZmljZXNh?=
 =?utf-8?B?VlloWVFUOWd3REFqWXk4TkFMRHRLTG9uWWtkalhha0E3MDI5RWNiU3VWNFBk?=
 =?utf-8?B?cTc1SXFTZWQ3NEdiNXF5SEJORmV5cnpvQVl2TW1ueHUzci9WZSsxWkNYK2Qv?=
 =?utf-8?B?SEhKT1dwZFBCL0ZQSDNsSi9OWUJJUFI1MjVQQ2lOWTQ1N1dLUm01UW9WcGZk?=
 =?utf-8?B?bHJ1T3FpVWd0eXh5bk8xcytidTltSTJ5SjhScVpUd2xnT1RDWUxXYzlydmla?=
 =?utf-8?B?czNNbVZqV0pVazZ3YXJER0x3b3dzRnI3L3dGNTZyTnZTd3dWWUhaeTQvejFu?=
 =?utf-8?B?c0x0ajZlQmVIaDROeTA3V2phNEZKZFdQdWcwZ2dxVW9PK1VnM2ZpNjEzNDl6?=
 =?utf-8?B?c25sb1JXU0EwVzNkb1FUZDc5VHpkMVNTZCtTcThWOVZaMkNXb0N5QXo0NTRP?=
 =?utf-8?B?NVgzUUhRRzJ1K0lOcGpBaHBYZzFWTWlwV0I3RWc2aUU4cktVbWM3ZGJjbHhL?=
 =?utf-8?B?U2FteFBQV0NKZ1hUS01majhRUFYwM1dscGdPamFTWjNvMDhVWGRLY253bXhD?=
 =?utf-8?B?SXBkWFRSQkZocUxmVjhmN24yU25tQm0yZE9JTmJtdk1jcVdDa3RYKy9BNy85?=
 =?utf-8?B?dk5ob1ZuRzB4aXFsdVFyNk1GRkRrV0J2SzNDTmthNi9wS1d0WHJVMTJ1UnBM?=
 =?utf-8?Q?n5FJ8YTrLXeZXD6Q=3D?=
X-Exchange-RoutingPolicyChecked: 35fjPj4Wa7SSuS2hTzKOQ4GIOKof81tI/2TWQtNkfyPa+wdyU7vO6MPxuZvBjvlyLz9cnZJKqoSsI3jXcWj92k4liePOrD3OoU3gVX0E96kYDTy4RJ4/hrKEWuP0SY4KcyPX6lR3YaVXSfh7dPOC/++gmvHhpYiu9faEVy2A+cHs7GgM+73IBUSArL0JMjYZMLjKt2ANIQHDrxF0qUwxU+Y1KS/5HRh6gBfrEPfh2GAPefTpux/iJ2WFjfWQ7U4nk/vCjB6b1qKsD3k+dbKvzZRjD7wFAIjcpPy34p99SBePd8X9qqqBtFNKmf/O8HY25/EBDiWCNj+8FXXJf7ZWNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 956ea737-86f1-414a-bf96-08df30763f69
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:54:13.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYbs/qjgk3lumDRQoG8YtoR1vKhXphoNehyOUd0rVQEBS/GFM8GxQctHKUsdp8xuMGK9VSVshMRkwrbRtqKoCjvuW1vNivHRkL2KIsN0TUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9594
X-OriginatorOrg: intel.com


On 10/22/2026 9:33 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Tracepoints that are defined take up around 5K each, even if they are not
> used. When a tracepoint is used only in code when a specific config is
> enabled, their definition must also be only defined when the same config
> is enabled otherwise it wastes memory.
>
> The tracepoint guest_halt_poll_ns is only used when CONFIG_CPU_IDLE_GOV_HALTPOLL
> is enabled. Guard the definition of that tracepoint with the same config.
>
> Fixes: 0da11bf0cab90 ("cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!


> ---
>   include/trace/events/power.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 370f8df2fdb4..4d17eb307b6a 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -497,6 +497,7 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
>   	TP_ARGS(name, type, new_value)
>   );
>   
> +#ifdef CONFIG_CPU_IDLE_GOV_HALTPOLL
>   TRACE_EVENT(guest_halt_poll_ns,
>   
>   	TP_PROTO(bool grow, unsigned int new, unsigned int old),
> @@ -525,6 +526,8 @@ TRACE_EVENT(guest_halt_poll_ns,
>   	trace_guest_halt_poll_ns(true, new, old)
>   #define trace_guest_halt_poll_ns_shrink(new, old) \
>   	trace_guest_halt_poll_ns(false, new, old)
> +#endif /* CONFIG_CPU_IDLE_GOV_HALTPOLL */
> +
>   #endif /* _TRACE_POWER_H */
>   
>   /* This part must be outside protection */
