Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2106.outbound.protection.outlook.com [40.107.223.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB879198E92;
	Thu,  6 Mar 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232273; cv=fail; b=G9kSvpy2oJqPyGeYjAGjFsy2oTKv4HP2d1LmixmFFXVC84+sBtakk+Z6DVjslq1bVAlYHb80Fao72Dv5n5AgGwNfHyz36pEApo8QuWzwXTVFSmgQFIv3le1i7EzvG0+PqtYwa25o9e2b+tmM3zEX16y/E/jDCsX9RvZAJBBUr0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232273; c=relaxed/simple;
	bh=P3gAfaXb9YdmgBcmJzo+zRp+u50Lku11HJdpNBUjqwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbpNgzHTb74PxNtpbkPaSKacLB4cYATmgVERYhTtBJ9MVEkcVIKw2Lx1qwW9YqtRSj+ifTjV+MH2ntqN9doG5gPDw9v1KAsJkI59MoaNgl2lHxrVdSkbHhXXKJQF/locqwwPSO35irZKvdK8C2Kkp2H6yvuXxiD1+q/lDOtSqIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=4hT1E3G5 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.223.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="4hT1E3G5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prpXJTG+38RcpUrtPjZms8fxhc8N/fUSexFuOTcm//UAfNvR+prsWvFKuEjnk3hUSp0pjqDtUvZXEx4v6IdMUwKXixfj3Yh1Fxp3Mw1RF7X+j8+mrWlAQCsD0CY7jDV3cjYUfHutNV8R7VXTUWDCWM5vVStCjZ423y0GLuq/flUfvbeLkV4Xz4iv/9CVpCNiIp76f/0hh2/ugmbI6vdMrj4L3aGacYlTEAgM4KVkImjxoHzE3KLawClFleTpLrgaMGdW1wG3p1pFIFKqcaq+B/C2aMLotiwGTZWjJTkciTVNenUXRIVGc8zalIcB9OBH89lQKsa0ohp4bYF/VqL41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq+akhxCnfgFwM8LzLhGS3aM7ecP0E/1ZwMC1BRQ+S4=;
 b=deejF7hcetsnIi5hMgfC8znNAEiTVoST/rQbr0OgsDM7lqjMlZwu0p8kbhm+3g/FsOrm0HC3YcAjNpleP8Gm10ek/sTSV8TDEFP+6OMpnEDNx3D+L5UpxLpSNcJXefaHAcDa5/Y8XkGKY3/snXq/WekT1EbLKDX6tAqV3eI28RBSmrnAtHSg3u9RTEOxnBMoR43buAUXR/IbycQ7j9HxL9MNFhoFIdqjpWoWIF/IVa3OMhwYi2u6jpU6ZmQFwLoz6oxIx6iSfMVoYVtfomG9tw8nuTRjCBvMX/i7BITD+h8AW2PWqrG/R6WoK2n2DI3f1qmcPGZTKOLb3CP8PnmVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq+akhxCnfgFwM8LzLhGS3aM7ecP0E/1ZwMC1BRQ+S4=;
 b=4hT1E3G5bo5ll2Nx1pbpQHZuGKhnDyHlzX0qPY00pzq5rqI+/pPTAhf6Et5OSkhNnMAI95lxm/q5mowqLR4WSpGoB3irBddjNVI1Gx+UncSOOj/j1LbsIwSta5jsvvgOkkLhrNlaXUO513075zuQSm5d6Wx1aNWLiGQVevtbb0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SA1PR01MB7325.prod.exchangelabs.com (2603:10b6:806:1f4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 03:37:47 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 03:37:46 +0000
Message-ID: <b098cbdf-394b-4f20-9dcd-393ad1b734b7@amperemail.onmicrosoft.com>
Date: Thu, 6 Mar 2025 11:37:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend ] tracepoint: Print the function symbol when
 tracepoint_debug is set
Content-Language: en-GB
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Huang Shijie <shijie@os.amperecomputing.com>, rostedt@goodmis.org
Cc: patches@amperecomputing.com, cl@linux.com, yang@os.amperecomputing.com,
 peterz@infradead.org, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250305015505.14493-1-shijie@os.amperecomputing.com>
 <f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SA1PR01MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: d52a1b8c-8ed4-4417-05c7-08dd5c6042c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGt0RDZCK2tueXJuS3o0NG1KMHM5KzlQbzVSRWhNTmw5K2xmU2JneTJZMDQ5?=
 =?utf-8?B?UVgyQW9XYVdaVFRJa1hpbXo2QkZLUDVFaHhWTWwyR0JnUDhwMlI1Y2o4a2pX?=
 =?utf-8?B?K3k0RXRmM3RqUCswQVo2T2wzSHAvQzZyRlViWkViVkNaVktGN2JmZTdEekdF?=
 =?utf-8?B?aHl4cWs0Yk4rYVVGeVVtMGY4aEpsWE5saGwrQ2VNSWw4WUg3MW43ZU9wU3Zx?=
 =?utf-8?B?dkVLMWFvV0t6dVFNNU9INWRPb2VHdUlvTkE3WDEvbVdUWTU4dXdvczBwUW5I?=
 =?utf-8?B?TmMwWGhSNWpGQnc3b3ZIRVQ5eVBMMHlrdFF4eDcyRVM5MTduY1U1N1B4aDU2?=
 =?utf-8?B?SHI3TlhjV29obEZsTzI4OW4wZ2NzQWNQZFRDQU5Eb1F6eU1YdkRna1Q0ZkF5?=
 =?utf-8?B?c3hDWG5pcUZiY1FYR295WkUwYzJ3WUtwWldXcUJHZWF6Ui9Xdmt4Qlh5S1NI?=
 =?utf-8?B?cVhBMWQ5YkRDczhDTjVub1Q3bmJaSWpvUk9BdDhEN0RMdXlEVzFqWXN3b043?=
 =?utf-8?B?UG1qRFc1THJWcnJPRjJTLzBMOWplaTZHamxGdmFRODRRRnVJSjc0TjZWamhD?=
 =?utf-8?B?QTFHbzNtUTBSSXdONktySERaNVh6cTZ2bFZLY0hISVZvWU1BMjNRWC9PNDdv?=
 =?utf-8?B?UDlhNkZHam9KTGJrbkV0TFM4cWtEdXZ0ZTlFQmZzSHN6V0lmcjRjYWhrUkps?=
 =?utf-8?B?aEdlLzM3bTdBaURIdmZUQmpZR0Z5cGxrSWx0OENtNmpUSGpNaGkrOURQYjdr?=
 =?utf-8?B?c2gyaEdWOGh2b2lNWVhsd3UyMllQMjZJMDJWKzVCMXBUbzlPaFZOVTlScmdR?=
 =?utf-8?B?cVliSUx4UDlCRHZ4L1dFaXUxbDFwT3Z1RGp0WEhreVlkZnh5SHBsWG9FVG9S?=
 =?utf-8?B?dHhtQjJJTWpRbHRmcHpHYTJRS0FWRk1CYm9BVkVTVWltWXZsYkJwaTVJdEYw?=
 =?utf-8?B?bGRmL0xjY293RGtxWHEzV3Z0RXV5bVFoaTJkd00vYTVZSk55UDNBZEdHNlla?=
 =?utf-8?B?NlFORm83RUdKRkJudVhibnE5NFZrU0o3aFBuN3J5bHpmZGU3Q2dyRGtzT1BI?=
 =?utf-8?B?SWtyOGt0VFJYM014bklTREw2YjZlV1ZVb0JZZEhGcVBpZlpUSUFLKzJPNEtD?=
 =?utf-8?B?VFpuZVl6TUVEQjJrdWQ3VHY0Y0UvaDZzVE9tVFh2Z1ZxRm9sVVNzekhMdm8x?=
 =?utf-8?B?Q1NBWG94L2Y1Z2NyWTRuQWM0WGRYZy9tQlVKMEw1Ri8xa1BralNEWEtHVGsv?=
 =?utf-8?B?VmNubFQ5Mml3VXVYYWwyU1lJNWdIMHA3M0RySENZbSt1R3V6bDRmZEtpS01C?=
 =?utf-8?B?aGZIbmM2WXR4ekZUc3NJYnVqbFprQTBlcWx2YkFlUFFidFNmdTQ1U0hzSXN3?=
 =?utf-8?B?ejFNcDV0dlh0dHhxbzd5TWhGeFZTTElmNEE5K0ZkODIzUXJ6MmJhZWJuVnYv?=
 =?utf-8?B?NHBVZkpsenV3TGFZUHdUUzBnaVoyV3duQWEraUx4NnpVNW1Xc3dZQWdLcmpK?=
 =?utf-8?B?UkRoZWg1OTk3ZmFoL1kweGlGbDlQYmpqQURnSUZ0Rk05OTRrd3V5SjF3aThP?=
 =?utf-8?B?SldDK1RzVWcrbHJKSUpCMnBMeDVtaGNDVTFnZnhBNlFURlZGcjVtd2V1QlNk?=
 =?utf-8?B?QlQ3Ti95Z3FKL2RCOE55NHl5MTA1QTNPZVlPRXQ1VlB5ekYxSjNwVm0wQjc2?=
 =?utf-8?B?cDQ1QVU0MHdacWY3UFJrdzdTaStaRzRkaGJjdzdHNEp6ZGN0M0hYWU9JWjFt?=
 =?utf-8?B?Wm9jejg3MVVqc3N2dlZBMGxuSnRwTXNuS29sSkpJWkJNc1RCL2ZtcVF2MEts?=
 =?utf-8?B?VHZ0c1IzN2dyUFIvcnc5K2RkOVRxaXJ3ZFFRak90elNTMEQ4aHU4RityMGIv?=
 =?utf-8?Q?FgdaeT3kQzacU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TllmSmF6ajVnSUZUOVRDYS8wbmQwaU9xdG9vSnhFd3FNN3kvc1RlMk5YM2s0?=
 =?utf-8?B?VElTc1o4RUsrd3RsNjlqNWM0K2lzdm9ZNlZvMG44YzREVzZIaGVPVytKU21T?=
 =?utf-8?B?eFpuMVlCcGpsOVJWQzY1cU01Z0lmdnhJSWtNcTRpNWlKTnZZUHNLdHpuUEdQ?=
 =?utf-8?B?QlFMVFpoR011aGl4b2cvckNQUGY0WnRVZmVrUml3cmRXVHgvOFpPMkx0ZG94?=
 =?utf-8?B?MXFtMjloTTBXOVF6cUd6OG8rTnlJQkY5dHhpNVpaK3RvSnRFL1QvVkJXRTFx?=
 =?utf-8?B?VmcrZldHUzNXU2NrVFlrK2UwL3ZvR1pIenJ3YnIwN3VZWFJ6OTNEcm90ZFFz?=
 =?utf-8?B?WWdDcnA3RUZvVnF0L3dUa2RyNWVKVmtaeCtQekwwQ1p3ek1wZFJwZmVkMXhT?=
 =?utf-8?B?RWd1OW5rWldaQi9YeUc3cmRWTGgzaHFRcFVzcFk0SlRCKzBaTmxEejhSaVln?=
 =?utf-8?B?UWhHUTQ0c0tNZ3JHVGpXbWRrV0wvMUZxbFNMTmZtY1JVY3g2RmhZVmp1TDMr?=
 =?utf-8?B?eWpaaGJFZzh4S1hRU1krRXgxaTgvcjVUMWpCTVJ0ZGhYcVNDVlVFaWFkbHZG?=
 =?utf-8?B?Y01KS1kxU243YzRKVVF2RmpiQitYZ3lkZlN5b3ZickFQOGRBbzRYUitmbjFD?=
 =?utf-8?B?U0xhOTQ1c1E4ZERPdkxtTFR0MzlGWi9XYmp2ZEM2QWw4aHZGMXJRMTRwOFJJ?=
 =?utf-8?B?Q2pEM3lML0NOUTd4YXNORVg0R2RZZ015RVJKaGVEWWZucjJXeS82aGNaM2xi?=
 =?utf-8?B?WGR3UWYrOHVibWZrQ3Yvb3B2d2RldHBNbGMwYjkxMWUyVEE3em4xL0M5TWV2?=
 =?utf-8?B?WWlCbkVrL3l6Z0dwRXNaMFd6QlBzajlNazltb1FBaVVpWnVnK1RjRkJVeUZZ?=
 =?utf-8?B?TjlySEtzNkdrN3NPOHJleTIrZXN3RkZET1VmMlgzTVFRNGVlNStwQ3h4YU50?=
 =?utf-8?B?L1lCdmZGLzh6Y2pzdXBLS05qNGlmSVlqVWVaYkk0VWFlTmZJTUY3RWhRVi9G?=
 =?utf-8?B?RFpNdUMvc29QQ1VVYjNsNk5vMnlMaXF4c3RMWUk2SE1mbFY3RkhJSXRWN01w?=
 =?utf-8?B?QWE3RXhwUjdzbmJhdlAxZGs1Z1VBQlZhY2tPclFpazQvZ1NabWJ6NzNKSWFS?=
 =?utf-8?B?dXQvRThPUkhaeUthelRrNi9raXVPVDR5NEhnL0FaaE9rT2RwZ01tRVBVSHls?=
 =?utf-8?B?RklQelM2U29MQnpqS1FQRFZEckQxSURQUGVwOEd5RU5lbGFnTDFRZzJaMVJL?=
 =?utf-8?B?d3NGbnpNVW05Sk5nMHg4TzdTVk15VjlwMDROaS83VHVuNWJYeGVqMUc0bnJy?=
 =?utf-8?B?RUR5ZjRkSmt6NXVxMVpxeFUwV1NzM1FiTDJUZGl6TzdaUTBwZzdIc2VwY3JO?=
 =?utf-8?B?NjR6U0Rkd2YrVUp4cnhPN2NhdVgxUTRwb1dtTTVFVnBpT0d6RVRzR1ZLdUVP?=
 =?utf-8?B?MEF2Y2R5aVdpYk9QV0NtNXFBcDc5aTNhb0U3OXVKajFrV0J5bFFsTVgrTlpH?=
 =?utf-8?B?UzFjRUQvaDV5c3B5TlJnYSthTXljbGxFeERwZ1k1b2JncEgvbm53eWlHRyt6?=
 =?utf-8?B?TnhLRHI1VW0yRXIvSCs1U2xMY1lVSWtTZHZRYldlWGdpK2JjRmxLQUZ6UWJh?=
 =?utf-8?B?S3B1Q0Q1VEpUTzE2TnVwMHhXSW1QeVhKa1dSeFVBU1RvKzJYc3V4RHdUZjRh?=
 =?utf-8?B?RHQ2N1FKTWV3b0ZOejd5MHdROEthd2s2emg1OHNpenNlbFVTL0QyOGppV2lE?=
 =?utf-8?B?NVhjSTVGTTVJajdJbk9LeUNLck1PQ1lvbVdkSUw0Vis4VWtKQldXTlB1ZHpD?=
 =?utf-8?B?dGtHaGNRZ1AwdjlEZVQ2QmpVQXNvS0Q2cHU5UUkrcUt3L2pmZDAyTUNsR2JB?=
 =?utf-8?B?cCt2eUp2cGxwbFdLakpncVJhNWlRRGphSDlDZVNacDBpZ1J1UEV0bFJhcS9D?=
 =?utf-8?B?VXA2YlJ5Vk00Y0xvUlJORnd3NTJ5WTU4bmxsSEw1b09wSTFWYU5tZ29VUkVl?=
 =?utf-8?B?R0JNNGRleFVmMDhnOHFxSTV2UEpjS0k2UEdheHg2Um81V0RRWGthMDFIRE1M?=
 =?utf-8?B?TVI3RWo0SmgrR1BpRWpsaFRyam9pREVqWW9ydllVSE1IRkZUTVVQKzhTajAz?=
 =?utf-8?B?a1czaVZVKy8yMS9CbTlDY1pWT0R2WFpscGN1QWN1dEpiQnZyTUpPTUp1K3I5?=
 =?utf-8?Q?ZPrio9ssXq/Gug3JvDPJCKs=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52a1b8c-8ed4-4417-05c7-08dd5c6042c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 03:37:46.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMBtcUOPcKdTn4gn1vG2sDQCHa7RvssSK8ciRxaJPo4ekRsjJ2wiXTQ7etxL3CYIA4tkv96UP1NUUUegMdizFZPHBQJYtlJch6t5gqh9obrs+Kcne+yA91h9sTcJGW8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7325


On 2025/3/5 21:53, Mathieu Desnoyers wrote:
> On 2025-03-04 20:55, Huang Shijie wrote:
>> When tracepoint_debug is set, we may get the output in kernel log:
>>       [  380.013843] Probe 0 : 00000000f0d68cda
>>
>> It is not readable, so change to print the function symbol.
>> After this patch, the output may becomes:
>>       [   54.930567] Probe 0 : perf_trace_sched_wakeup_template
>
> What would it print if the address is corrupted ?
>
> Perhaps we could do like the backtrace code and print e.g.
>
> [<00000000f0d68cda>] perf_trace_sched_wakeup_template+0xNN/0xMM 

If we want this format, we can change code to:

    ---
  kernel/tracepoint.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index abfd0ac1177f..5a5041f32cc8 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -127,7 +127,8 @@ static void debug_print_probes(struct 
tracepoint_func *funcs)
                 return;

         for (i = 0; funcs[i].func; i++)
-               printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
+               printk(KERN_DEBUG "Probe %d : [ %p ] %pS\n",
+                               i, funcs[i].func, funcs[i].func);
  }


The output will look like:

[   63.818829] Probe 0 : [ 0000000032848d41 ] 
perf_trace_sched_wakeup_template+0x0/0x20
[   63.819287] Probe 0 : [ 00000000fe8cca4d ] 
perf_trace_sched_switch+0x0/0x20
[   65.325638] Probe 0 : [ 0000000032848d41 ] 
perf_trace_sched_wakeup_template+0x0/0x20
[   65.695631] Probe 0 : [ 00000000fe8cca4d ] 
perf_trace_sched_switch+0x0/0x20

Thanks

Huang Shijie

