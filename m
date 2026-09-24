Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1427E1DC;
	Thu, 24 Sep 2026 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227679; cv=fail; b=vDOjMSEeStxthUq6ZoPvqx6tDXjl6tpm/ap7AHcWr9awEyi1C4Q4gg56qjiRhJWsv8g8bW01L4Zl7UiVYjsfkszqdL97z6M5aGU/QOwBkwk+7uKa0nF+A7flgiAdOSkfQVvAgKvZZd7gtRyL8d07mCFiI+v9EDIVwCOUjYWUI2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227679; c=relaxed/simple;
	bh=37TnKbfLrlWCB1+5Mn3IEBHc3F4SquQFxS7r/VEYkZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qyAjZmctvmbw+SaVGOhlYS1O0wejzspYsFOA6+zJJnXSk7N1z2iYzkvk1n8vZB8Xf6+MXfOU8yQh3yhidaVRUNX7unMHZ+ksMGmLrhTAM9jPUw3bsWrRvsdtGzKjRpf/exSYXBKSIxHYItCIPwVk4OYIUr6YxxwWG3GE3H/zEII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=m4orXv0w; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="m4orXv0w"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2jSZU4055979;
	Thu, 24 Sep 2026 05:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=jtLj8bmogkViaw0CVAGpKfhc1logFcHN2MrGT1oLB0w=; b=
	m4orXv0w/AVp4oANUtGpbwG2rJrnhyXFvX9DWz5dxfxJdZCDIp6eG6aNSf2j0Bp9
	sXEyq5vlYTMdb4Ak6tSSoo0CslAAn5+oSwC2J2e0MoW+CxeZ6MlOOMwsf5vGbJJ4
	0be0ylTr2bFA6JLNk+Ar0s9kLENRyktr71KA7Z5c1b+UA7TaVu/2aAPBODorl8sd
	cUZzCrF0b01dnLp+babHxnAMAoHeNHBGLYA94SukGvD5q241iQDj9X9s9QN/R2G2
	vlYP3H/C8hVGceI21YT/mEBkZuBQ+3RUYGReaKdDobW71w6UzutBiPvhm996RJPK
	5bjaTfwSs8nO3JiWeQFM8A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021113.outbound.protection.outlook.com [40.93.194.113])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gup35m35j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 05:27:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLJ1cKRDfg/6Iu+LPYLGmMxtjcSecsR973YeepMGYtBg3dEdmgIG9hTcemUD2kv5YjLbIN7txRFa12iNcnUj2ksVBC4s2Ozq4z2k+LccsEHm9P47QEB/kXgAJc6UAt/FGl+ZI0/93NRjIirQCC34IaxDpg2vntXfc1EhErKD0zBiTyDOCZVrBwIEOKsMHW8CKZT+c91LPIelHZaLdCuQQeF99Q/wb0TpOOlyCqlHmUf9j3DmHnxJoAZE1DivPYoR6Kxd42ULf19C1n6sgUyrfGxm2SJ2qFCRPluEmJu3WjbGI2Q7XoqXMBindSodYKrK80lnev1fFLkqwE3J4S80zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtLj8bmogkViaw0CVAGpKfhc1logFcHN2MrGT1oLB0w=;
 b=Aym7PcVZMii+H8Rmf/9XGVzBO7w1gF9EqQSWn+TlGuBJM6C9WvKhyoLMmwWYqnhWg4A4s+a+QQrd3fDGQAqzp72Cd9DQ4I8nBuI1vcTsL/LpHXRj+/J4Iy8JlKxzDFxhzZCw3Vd8jTIj2xemDTeCARO6/fZ0TaKiwGZ/knXCDf2+111ysPWHMIcOos4v3Bz/QsnSJRb/Zgk+p0yW4TM9twsZOkpVVZKeJAQM/yfZ75x6jVyx6vF2wu9X1/9lWrYQ/j6aXTSChH12JolOut4BJmi3ylpOMPXb/zMnDgVCBiqI+i3B8EHs1f2tEqLAgMH51gd9lnYJoJiJlu3mz5J9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DM3PPF2DEFDE2DF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:27:40 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 05:27:40 +0000
Message-ID: <23c3853c-61d7-4499-81e8-44ac608443ad@windriver.com>
Date: Thu, 24 Sep 2026 13:27:35 +0800
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] ftrace: add max field to function profiler stats
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
References: <20260924030108.2673654-1-yun.zhou@windriver.com>
 <20260924031016.88B601F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260924031016.88B601F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0063.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::12) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DM3PPF2DEFDE2DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 783b6511-4240-4de0-c41a-08df19fc8d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|22082099003|18002099003|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	O7yUZHXNl7ooInOhyj3tMYMXjUAG7oJESjChSNzXsxm215tuz12/lUjlQvk4wvjDcMOP1gVcsJgvZ1dfKEDnhCq8Z3L8X8IEavAxlY/Y0lJ//az8pBz0zIesC/7GM8y1rcjjjc5nim8Fjgw1DkOYEeXNYdtIIGb3QSZhkOEqYB2bAEl26VpHcyq4HaK8RNPBKaW+WC7MbJnb/phE6H5ExWh9vzFWrbGtHc7q8oPy2KhBIc6wskMQpl8IKzva6kZdqHYPpC5W3X6zPMt6pwGW29fVWIH/O0/34pwbU+N/8177jmeMRhcti3K/gl4nUedK232bi9BQf4n+qL+UT5pTGUIptYK116foZJdOkIcY0MZU7JPGL8DWHxb5JnNB7faMFunyctMzTgWoAViVakGHZR9tOdYzX4zxCBPLCU0Dzs0PCtIqOeloIlen+10rIzLvzyktIwN7kB+nVqtxWd4AqF14xx8M8S9541xAXnLk81IhyONSb6Zexbsl1/WcqJcp8v9nrgUcUtCDVGuOyxQ51MMNgL9mmHwwyi93KnieRNxsyQvORH04at5Tx7FRwgs9U4K8iYbF9Ws8R9gfjNPoU7n+QWzLJDL6mjxAvsPfKJaKb62QqUYAFRNB+QIDGEPQ8/K8PLgGkaPtN/MODy7DNxWLIoo1hHq4qjFip+sm6Gc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(22082099003)(18002099003)(6133799003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckxvWUVqYWlTSnhDZ2gwK2U5TVA3bmpPakVJcHlzcWZ6Ym1qSUJmTWRIQ0dr?=
 =?utf-8?B?Ulc5YXM2dmF1VWt6c2VvdHlUMWk1bjVsM2MyYk9mdEFTZ3MxQjZ1SUQ2UWsy?=
 =?utf-8?B?S01QaWh6d2s4N3pJYlB2c2JpUlQ4WVNwTkpJSWhBZ012MlNaTDYyUytidlZ2?=
 =?utf-8?B?ZVpTeDJRL3BTeG9WQ1FpdEh2V3VDVUNJNGx1NllqVXVKUytyMTlFeEo0allp?=
 =?utf-8?B?QlFNRlo5SnU3Z01wdk9xRm4vWllEdnUranQ1aDZxUWJVUmdOdERob3lOUDJC?=
 =?utf-8?B?c2pmc24zcUcxdnZlOTRadzIzWUdWSkV1dVNTcGt1M1VqeDF3NFNpU3VBVWg0?=
 =?utf-8?B?cFA0NlZGY29WY1VUd0RXYWZGL0NDYTd3dytDRkE4STZqRmVzUlB1MTQ4bVpG?=
 =?utf-8?B?OWxjUGV4RGdhY3dKS296cGlycGpwdWRKYkNzMzdYaExLSHRhTmorYmVSOUYx?=
 =?utf-8?B?a2MrQjhUSTF0UnVoeTk3RlUvNnpEMW9aUVRHdFV1WUFOMVk1dzQ2WksvbFgy?=
 =?utf-8?B?NU5UNVJDUVlrU3R2SnpEZVpzL3FvTm1tT2JvaXVNYklEWmZNakpZdUhvSXdB?=
 =?utf-8?B?dXh3ZDI1aW92N0hheFhNRHZUNjFVSzI5VTJmQ2t6R0NMNUE4aUh5d0sxTGM3?=
 =?utf-8?B?M0VYSDFIZHM5ZzhNenRzWlZGRGtpRFlTSVpuZnczZ0VSaEpyN3hmOHkyRkJ0?=
 =?utf-8?B?emtYa1k0YUwwYkJvTjdFK1ZHalBteUJhQS9ZZXB4bnFsb1VuTXhCR0xYMUU4?=
 =?utf-8?B?TlVlRWtQUHJTUTdMc0pobTRNa0Q4Z2xuOGhrSkdsTlZtZTJTQVJ2QysyVCtv?=
 =?utf-8?B?QnYwNU9RY0wxdkdyWFFuQ29NVHBybzRtcm4zdFhHQmhZekJ1K1hKOUJoeGdx?=
 =?utf-8?B?VVZxVnJ3K0xXMng3T2JzVmFQOWxIM3Z4aHgxV1E0VVE4ZEVIR0NtbnpiS2xR?=
 =?utf-8?B?eUZJU3Rvc3BDQUM2YkFIMmwzcHNQTytRTUlOY2d3KzQ0QlpPTk9mRUZSWEY1?=
 =?utf-8?B?aHF5M0x5Um9LanA5TzFQYzFYZzZZeFl6MHF1bWxiTU9hYXFTMjhCNk9zWlhB?=
 =?utf-8?B?Tm8yL3NzdWxURTI0T284K0dZNXUycCtKTFd5cTZ4OVVjTjlDZmYyd1haVGpT?=
 =?utf-8?B?WTBuRmEwOWNKdCtwV2dQa1ByMnI4Y1AwcDZZeVNPQkNzRXpUSGxVVTJCTHJL?=
 =?utf-8?B?cWd2UTBkMDVNWk5IT3ZobEIveTU2elBoL1kyNUYxSnVvcUlKOWVpYkRZTDk2?=
 =?utf-8?B?QkgyYnVXQ2VSVk1MM1NEeW93R2J5SWVWV0t1S0dlbkk4UWJmdXl4QjJ0eWRG?=
 =?utf-8?B?N204QXg0MkFuMXpNQms4YWN1Y0pWMUtrTGhMait2Q05xV21vYk9OK0RXcFlm?=
 =?utf-8?B?RHVoek8vYU4xUC9SM016ODZweVBPUFNZR2NZNE9pbXRyU2lIeUpMeExOaW1Q?=
 =?utf-8?B?U0hrbXlQdENZdXdhUEdYSHR6T3RkYVVvOWdvTUovd2c0ZVdzOWVETXZaa0hG?=
 =?utf-8?B?RUMrazdNNk9pcjlUREhCZ2xpZHhkdk9BTmRqSnkwSitlU0FTUk5wVlFFYk1t?=
 =?utf-8?B?SmFRNE5sbVNiRUdtNWNsb3BiazJWR2xnN0l2eHFjRVFESTM5cGlaaUhKU2xl?=
 =?utf-8?B?M2V2T1EySm0vRTdMaUw3RS9Jc3Uxb0ZpK1hLUmZDeXlOYlVoTVRZUkJKRmtG?=
 =?utf-8?B?VDdWUEVVcDFkbGpvQ3luL2xrV0x6cnRIdnRGWFpLT1JTb29LTWtZT1NQMlVB?=
 =?utf-8?B?RVY4d3BkeEJGem5HNXN5d0JBT3NmbEV1czdxVjUwa0tBQjRQRnI1R0hNRmQr?=
 =?utf-8?B?NmovaEQwWFgvcGlaSG5YVjB1V29pcFNsR2VvcDM1WEVOWlA2NFZxWjNqazhR?=
 =?utf-8?B?S1RHeURFdkMrbGN1NDVqUVkxMTZmL1JIUmFIdHJlcXpyVFFVb3YxcUtadDVL?=
 =?utf-8?B?d0l3WFd2UmZtUnFVcEZMa1pwdE53S0pLcmNZRnlYNEl4UnFSS2hHcVYxN0Rz?=
 =?utf-8?B?TkQvNU83eTUzKzgzYnQrVk9Mc3UremtsU1ViUmxGYjFnZ0YvTkpzN1JDWG1G?=
 =?utf-8?B?aU41TFZUeGxiSjdZU2M1aW11LzlRWVAvbmNmQ1I3RXg0KzBqVEpxNGo4YkFa?=
 =?utf-8?B?UmZJVG5BemFEdXdZRDdjZmE5QkpSMVBtYTFzVVdMVjVsZFdNTThUOFlQNXlQ?=
 =?utf-8?B?SlliR25kOTJvNHRRdkhUS3BQNlFUZTNsNE1vaVFVVEFjQk9PUVZpaEhvRDBR?=
 =?utf-8?B?cVpINkhhY091T3pSNTgxUmxNYnBGSlJFekxDVURRTEhqazNuVXh1TmZUY0ly?=
 =?utf-8?B?dFlCMjZ2UTRiamhNeUk5WUlJSnlQMVI4ZzRDMzY1QTBMUGxibzd5dz09?=
X-Exchange-RoutingPolicyChecked:
	rP4BTqIpQFRmjYPFI8o3u9Jgnd25o9Gqjz6Ke2oZBcFqHZ/m6AA9Ts/QwxDLrFj83tecpn2RBxSbwZ2GxnwSttJxhxXPkLMNC/6UY8UM6h143xa81YwM85rgyoeyhyyX+abT8avmDWT+siyVru86CeMH/gIVT8Y9IV+ICAqgmJUAYV7RdGzW1pc6wslMsn9tOaBWZbdaCmyBSbw9M5OwZJB+zd+84+lmGceyNmUsUuRt5w1kTvkPZsCWnd3Wdgyfi2i0G0GW1Rvv4zwufid/fcP41VWjUQsMzET1qX6Sm2++aEL9bTef68ThscE6prdItaFB6JLOQEX54e6epXEIIQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783b6511-4240-4de0-c41a-08df19fc8d30
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:27:40.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZ4lXNh9Ljq/MMPZ/1y38Ens0TuTlhJk8H6YF10pJH28XJjPuYB8jXNflP18+8oKqaVlBNWepDj8zg9c1kyvQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2DEFDE2DF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMyBTYWx0ZWRfX5M45SP0FTFfe
 7Ru2IMBteUq4SApn8iFVlDW2KdP+XOVXqIihUh3c7ujnVFYBVLcwj0rdRGnvxtcVKaZJUeIAPvC
 DQnDFf5ea4ZpQt8P7AT/rd82Tyzx8FKrWY+4xojYFVCgIXBTY067
X-Proofpoint-ORIG-GUID: XJiHIhpSDej36jpKuyNgN3yugax2_i8s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMyBTYWx0ZWRfX4VsLpYPnmWSv
 7SccTJTkczzjq+hJFRzDL+0S39l5qTm3QT6jT+RyJ1NEny/+IqXmRBmjIBeInWbQ8YcjRDpKyk7
 QRMeLUNgGHBZQz3iL8HY3Fp+jgbj58ttMBaH59Wj2TeqJskQXsWPa38yHfrcARtBeLwsqo5mUcD
 XdP6Jd8RivZ+RszGNvJqq9ymN5SaaWid5DYCrCF/JLVgwFb4HNSX1vs+2xzwt5Wol9wb9ComJio
 XDMBGXSibBZEPZmeKlSKeNoJRbjLMmGVnNeC4PpwQ1TRP62ixZbiOyqKOWBF5Rx8LE1p1TMlHJ7
 y3d0Ndmd33b/IkdX9GfVAzBaM325Mo/NI5jYHHJwV4FIbKB58FXJnZOiUg5jzz2umF0sbWFr//z
 aBMJZ6dP6TShKMaG8+jDf7lYsebwl2TRK5Lxx5x0rvwn8td06/c4JuclS7cngthHynZD/7zH4Ur
 dPbNa9Z6dohg3TSI9jQ==
X-Proofpoint-GUID: XJiHIhpSDej36jpKuyNgN3yugax2_i8s
X-Authority-Analysis: v=2.4 cv=DKMacCNb c=1 sm=1 tr=0 ts=6ab4b4d4 cx=c_pps
 a=+jjOclGHkOGhuepu6R0Llw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=CFim9kjryZuW6C6x67sA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240023



On 9/24/26 11:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] ftrace: time_max TOCTOU data race clobbers maximum latency spikes
> --
> 
> commit 9fb82451733a5ec95aac95499945b5c01e39d82b
> Author: Yun Zhou <yun.zhou@windriver.com>
> 
> ftrace: add max field to function profiler stats
> 
> This commit adds a max field to the function profiler statistics to record the
> maximum single-call duration. This allows users to better investigate
> occasional latency spikes when reviewing function execution times.
> 
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 53d5db60bfa56..dfd25e3c87f71 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
> [ ... ]
>> @@ -920,6 +923,8 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
>>        if (rec) {
>>                rec->time += calltime;
>>                rec->time_squared += calltime * calltime;
>> +             if (calltime > rec->time_max)
>> +                     rec->time_max = calltime;
> 
> [Severity: Medium]
> Could this non-atomic check and update open a time-of-check to time-of-use
> data race against concurrent nested interrupt context tracing on the same CPU?
> 
> Since profile_graph_return() is executed with local interrupts enabled, an
> interrupt or NMI could fire exactly between the condition check and the
> assignment. If the interrupt handler traces the identical function and
> records a massive latency spike, it would update rec->time_max. When the
> interrupt returns, the normal context resumes and executes the assignment,
> overwriting the true maximum latency spike with its smaller value.
> 
> Because ftrace explicitly permits tracing recursion from different contexts
> like hardirq or NMI, does this require an atomic compare-and-exchange loop
> or similar protection to avoid dropping the genuine latency spikes this
> patch intends to capture?
> 

I think this is intentional and consistent with the profiler's design.
profile_graph_return() runs under preempt_notrace() and the existing
time, time_squared and counter updates are all likewise non-atomic best-
effort accounting; the recursion guard only protects record allocation,
not the stat updates. This is a hot path - every traced function return
passes through it, and keeping the observation overhead minimal is more
important here than never dropping a single sample.
