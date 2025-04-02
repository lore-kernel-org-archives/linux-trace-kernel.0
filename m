Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021131.outbound.protection.outlook.com [40.107.192.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6B23BD09;
	Wed,  2 Apr 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606119; cv=fail; b=ZebR5MQ6+b/Nx9pbcakn/eBEiedhd5jRyhlBffUHeu4oo6X3Jn/wPN/hogpbEYq9KnEbgbwmrmO3UFrOVsE7bgElLVYQoRMH24qJZw4Tzw1T/exxI6hV0kpySCHNfTVuzcxquwIqsUpk9rCtDzr3CSK1XEuBW3YcBpnJs2lJ+eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606119; c=relaxed/simple;
	bh=3q4VvFlKVzXqbG+hLTiN2et+eF078XZKdT9IURtnb2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XgDJNa2OkfoaXfUuC5evqCU0QKA7eGi/YQzr8aZR2fK4SG1oegLyjknoLv02MKrGIiKlJlRsmGLBSVgd0WIm8I2IY9asWfEQuuaBxAXuBesmujEM37aUh2vsp60fwF284WysllpL6Cg1qss7OB3BaoNjHx65DMcrChSOiJEUGV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=S4p2Lskc; arc=fail smtp.client-ip=40.107.192.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S4p2Lskc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw1xyje4cXELJIE04stkB1j1C8gFZLYeeOkF8/CDIGcJXIJ6ndmtmzrKTpcmHxQW9yqnR9lttWgRwaXUn6QxvZC6M+cm7gZTBWPcUTUpXIhxbuAwh+hXszJNJyfE4HKwegZ6OHH2yh0Dzm3kEfOb8ILGqP0Kl314tX1WIIqO9FGChrXxikgbP+r6YDkzYLxiVGnoVCPhxoHmO0ydJaeGxM+aLjF1Ul/SdcB9y89o6qQ5xu4pFj1wFUyqpMkG53wkPiY9bAauCA/K8BidyJCAU4+D737Xscf8rtGYfAoUoVyxGyI87jtwX3g1+8+wznMcKOLUdquG1A04I4HOrs9uTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCJ8aOs18XujtreepvNoGBchHjh7hJYhR5eKPsW6NrM=;
 b=CUsCJavMYBGBJ7OuBmghYnkfxX4RzfLOgsDbk/zdEE0KcItyVzK1YliUAb+3CjcsaZm9dYdwfFmIwCgnyLsfqDu/AAbDzpg6eTu/AHIBrQ2c4cTczjM5gW2ZZ9kvKqxAdsBf+1NDFFgxUetndSCdXtQEli7SlJYkit7XJu+EQOcH9itNQ8p8227P4kDKZNi9PX41kDcpipqojXeJqMmKP/5wGxaet96ghHhYDR5esDhtAVgkSwYQ5+PfJH0Ba/Vk5g47DZ8V3KufiFVt5gPHRFNoYN44rypbFe6+fIjWzMwoiLTOAFkkCYlKU05opdZsexuIz0/w937aIwBEFaMsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCJ8aOs18XujtreepvNoGBchHjh7hJYhR5eKPsW6NrM=;
 b=S4p2LskcfoX9IQXBt/J7reNGchgkAOQVDFjelvYJJ6Z2lbwjRLmjLj3uIXyj2IoF2n2Q1YsD1lLdZV+WO43JUfANDD+GVSduXdoDRyCarHlCkJUVameoW1v3hyDyd6IOza7CjWRY7rqVWBbvzB7/oECf2ugatKoF+ZSLS8uc5wQgb3caBP7+6JbWoHkJYdwhiAVO9CgwkBABBWw3+lIpAYSjLdmyvCxJwUy73wq7v0VFnZrJtxIv710luFfKIdhcn71pVrLWFcrVMB+4jvN5UNPUpVxxSD4euyFuF+jnQT711cV3a+28EDioJTb6WxmMTYVGsongV32CPWui+pgm3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by QB1PPF7FD4E7D79.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::254) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Wed, 2 Apr
 2025 15:01:47 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8534.045; Wed, 2 Apr 2025
 15:01:47 +0000
Message-ID: <a9a816d8-ce2f-4c89-a798-ef565febb906@efficios.com>
Date: Wed, 2 Apr 2025 11:01:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] tracing: Enforce the persistent ring buffer to be
 page aligned
To: Mike Rapoport <rppt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>
References: <20250401225811.008143218@goodmis.org>
 <20250401225842.261475465@goodmis.org> <Z-0BrT-OxGvaWM1H@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Z-0BrT-OxGvaWM1H@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::36) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|QB1PPF7FD4E7D79:EE_
X-MS-Office365-Filtering-Correlation-Id: 592c4c86-0269-4f25-35d4-08dd71f74a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3pHOXhwNFc5UktmRjFmcXJRZVlxMHBPZTJqWWxsSTQ1UFYzUHh6VXRCZU1R?=
 =?utf-8?B?VUFYSzhGYnNFU0h2SmJpRWlFOHI0K2o1SnJZbGdkMnBIU0hwTk5hVVRJbkpO?=
 =?utf-8?B?WUlacncxUVhNY0hZVW4vbXpSS29iYjZWQ1FtY2ZSL1cvYUMrRHpjdkxQMDdH?=
 =?utf-8?B?bGpuS2pFaEt2OTlyWURsbWFNcEpuMy9WM3o1ODVDU0FmK0ttN2Q5cnE4MklB?=
 =?utf-8?B?NWpGSEpVSWFYU1duemRNbWFrT25WVGJwSXFDZ0dXeW9UQ2ZVdk9HdTdObzNT?=
 =?utf-8?B?V1BpQ2Uxb1FJZW0rZ0EyNWtiWHh2WGhkU01WNWlONGFaUmQxZEFVY0svUWlT?=
 =?utf-8?B?WHNMRUt3R1VnOHRlVDJyZDh1dlJkM1dNeXNWK1pYdmRSMEx0czBSeHNDM2hr?=
 =?utf-8?B?NE5SWTFMbnlvZENXZFhwdkZtd0tTbEVXNXhCWmJvRG15TCtsR0dScjNlWkFu?=
 =?utf-8?B?NDRBTndyc3dDSDAzd1I2MXpLT3NhcUVZWUFGbC9GdysrWDRpVWV4dk1WbUJW?=
 =?utf-8?B?SEcxMUxFME9vSFRWemJRSC9tWSt4Nml4dWt5cTZxL2hlUzY0RlcyenJzRmxF?=
 =?utf-8?B?SWNQZGR4YnBIb0k3Zi96ZHdvRmRyMWVCN2kyMWlOTmlObS9sMTdnZ0ZJRHVx?=
 =?utf-8?B?SHJCRHRmMXhwbVRmV045SU9FTjZuL21hTWVMK01LM2tmL1pCM1NZdWFHQ3dJ?=
 =?utf-8?B?MkJHbVRIWE4xTTNCWWVxZGplUzRWejlpN3Rka3l4MmpSNW1Dc05Iek5aWlZX?=
 =?utf-8?B?dGZHalpFZHc2WjE1ME83dURCSHFtd0VWOG1IbVR6aUdmV3d6dDV5ZWs2TVRs?=
 =?utf-8?B?ZG83V2VzTFR6dWdPeEZQbm5ZMWNFN3pyUStWUEZ3U0FVTllrYkR4WE1HSXA0?=
 =?utf-8?B?RzZpczY3NUVWMzZ6T05wUytFMmNHRHBJQ2p2Y0NhMmJjVzY0N0VnYmtUTlBG?=
 =?utf-8?B?dG1URzJLOFVLMlQxUnR0eFBabUdoallpM1p0ZDg2L1FkL2kyOFFkeVRPODhJ?=
 =?utf-8?B?bElPaGV1V09TMmVaRnRpbmFnam5rVmFUNHRnSEZhWkpUdkM4RXVIajZRUERZ?=
 =?utf-8?B?UEl4NGJ6dzZvaWNqSFprQktQUmdKN2xEU1E2cHdJSEkwYnA3TkkzVHJKYXBo?=
 =?utf-8?B?WmxLRmhYUFBhSEwzdHJGNTNOYXdnWGgwajJOd3NVTEhIeUxJUmRPL0VlQW9H?=
 =?utf-8?B?aWwrc2dqODZFdHV4YmJLaVpCWU5BOTNZVnF5aDZzaHpmK3Zjc2FnNWMyTSth?=
 =?utf-8?B?RU1NUGNhZ1B5OHNWZVNaOTdLSFVtempCUHFkUE5KdkJFdHVlcjdFbjlIUDFO?=
 =?utf-8?B?QllMR0FSNWNZem9GRlJHZlFNZXVyaHdwWCtJNTJEQ0wvMzhPK2MrZVI0WkpI?=
 =?utf-8?B?L0k5QlJXSnMrTCtrQ0hiL2svS0w3RDNiZ2VEWTIvU0xkcTRxMG1sK0tZQUZ3?=
 =?utf-8?B?Z3R2ZkExUkw5dWZyMWlRSFVTaFdQM1ZJT2dDSWVxSVplc2pQeUtoMVJxMlM3?=
 =?utf-8?B?QmV3N2U2QnRxa01TdE5jakMyVjhKbnNDT2dBcWFVS1lnU0pKWFpHUmticUpE?=
 =?utf-8?B?ekU3OGdCRUg2ZUNTM2xrMHZ6ZGlGSExjeGowN0lqT0VHbjRWWWcwbi9WOTlR?=
 =?utf-8?B?YUN1ZExqcnNvYWNLR3RlOTJBdSs1aWthZUVXaFV1Sk5WN1pNOFkvUEtVTm4v?=
 =?utf-8?B?UGNHaklTUTBlRHd3Q2p3clNNRHRFWk1Ua1FZUnNkd1M5MzV1Z05mdkozTXZq?=
 =?utf-8?Q?dvmsVT6DpcvqpmKSqzexZRuvq2lSZoxGbOHdflG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0RJcDRWaXowdzgvL09aL3pMc3ZYSFk2YWMwK0xIdWFoNXQ3cEhpN3Jjajcz?=
 =?utf-8?B?eXg2VXA1TXZ6TXFkMnpsalBYOUJEZG1EdG9CZXJOZGN6MG93bnp5T0VyS21p?=
 =?utf-8?B?TDZVMFBydUhsRjlLQ21CblZjVm9ZZ20wQ293MGxYcG0rMmdveFByVmIrM1ov?=
 =?utf-8?B?NTkxOUhGNEo5K1pJb2FWRGQxdjRwWEVWczliWjU4VnRpZy9ibXFoZUtXemp6?=
 =?utf-8?B?cTVTc2FoamdkUkRGK05OcnNnS2QvRnJJd0tWcVZOS3NYek9SN3NxUmQ2TkN5?=
 =?utf-8?B?ZmlrMXRaOHFHRC9ralhRSzA4bXRIZFZtTnZIamc4bGVJV01xQ2NtbE1LMHAw?=
 =?utf-8?B?QzZJcTVUd3NFTURBWnNzdEwyRE5TOVNEallUSWVpWWR1NzBGN1BiWVhiM3lP?=
 =?utf-8?B?b2JhNVpVSjkyWW82b2xkc21HdU9uaDR5cHprL256UXNQOFVSckRDY29BODRX?=
 =?utf-8?B?dGRYV0k4SEMvNlBXaEVJTDRxM2F5bC9KQ0ptUmdPOHJicjdpYks5UHZwTU4y?=
 =?utf-8?B?RXVocm11OThQSlYxdWZKM0hwZEJqOGNPRGtxOWFRaUFIUkMySFlpSG5TZTlh?=
 =?utf-8?B?YnJlNE1ma2VCejh1emMxaENpc3lGNzdURUZsZk5HS29QRzR1TGZyVktVS0lq?=
 =?utf-8?B?cG4yc0NYcU1KTXFucnpEcHhLU2RlOFpZSkhTWjVpT1gyYWtRTGNKK3FpWkxu?=
 =?utf-8?B?OE12dVRLSmozWmJlTGkrSStvMHhNRitpYURBZnNkc0pxZ1B5eDFRR1BGMVdI?=
 =?utf-8?B?TkN2VWNQZXdkTHBQZjIxUFpjNnRXZU5vMGJ4TFpWUlBIVjdBTFFQZHk0cENE?=
 =?utf-8?B?TGxwR1VwcGVKaE9VNHJUZGc2TTRPakVpSTBjWFZlSmJ4TE5SVytZSmZqeUY4?=
 =?utf-8?B?MkV2NGxsUC9Lc2VJTWI4QlZ4ZTlhRDg4aVc0blg1OWNIMkp5VU16UXNYOSs5?=
 =?utf-8?B?T1o1eTlva3BLckovNWpQTnpXRFprNTRENkpzeGZGMkVBL0cxK2YrbnR3b29J?=
 =?utf-8?B?eTF1a0IyZEJMZTQrZ3hwN3JPUlJxa1NkVC8rN3gwVzY5cHJEUjNhdzk4UzhB?=
 =?utf-8?B?eEpoVWZhN0FYeXNsSm9zV3BBZlR5UGpScXFUbDdqNkpIVEl6OHpTemNaamNQ?=
 =?utf-8?B?em9xQjhqZG53dnNZd1V4MFduV1VYNXpJZXhZcTdMcUhQMEQwb0dkSGZYY0VX?=
 =?utf-8?B?WTZPQkhzVjdWaXM1V1hxV2hlQVR0dU1NU0FRZDBGdzBDckUra2FsVXZwWHBH?=
 =?utf-8?B?NllQejFmZzJxeHNMdVRxay8wK0J4dVJNZFpDc0RVR3NKekpFNGRqOVRQMXNT?=
 =?utf-8?B?TVlDQngrR0UxS3JGOHJGWHoyb2NRbk1ibnVaanU3WkM5T1BMSTFxWHE4WmdB?=
 =?utf-8?B?ZjE2YnNMblh5L0ZjTWpsWXltaGJRTHBRNllRRVRvWDJQR1d5SlZxaFpqdW8r?=
 =?utf-8?B?Wk5jcUN2NVVXcmluaStMSTFWNGYwQWtZd0lZbEtLR2Yzd1pxbFY1TUxkWmx0?=
 =?utf-8?B?eU9UV2owbDkvVUVYSy9hV1RCNXFXbkR6RXUyUkdFTU02LzcweERyYXVIVisr?=
 =?utf-8?B?QlBvL3FYZU1LdDY0bTQrNjBpcU5YZnpzSTFiVjY1Z0MxUjBMeDNBa0tFKytW?=
 =?utf-8?B?cUcvbkZ4ZWJ3alpsMW5vV2puSUUzVzA3cUg4SXdCL3BWcERSUGFjZXZtL3JP?=
 =?utf-8?B?ajNLMWdPNkFjY29PaloxVnI0NXBrTS9xUzg4Q29NRmdaUVNSM2Q5bHdNeWZG?=
 =?utf-8?B?amtKaVE0c0hLSXNvZC9Jb0twcU5WTzhwY2NJU01BdzZYbTh6YlJvL3FsMzd3?=
 =?utf-8?B?SFV4OWpUZnFXRENMMUU1a3BTNks3SHVIeTFIejhNWTVrUzg4ZDdISTM0N0xy?=
 =?utf-8?B?SjdJd08yNk13cnU3RWthSGcyVVZ6WDlvM2d3WFZKMlJIdXk4eW1aTi8vSXBx?=
 =?utf-8?B?RHZRYnU3VmFsVnRFSlJSTERnTGJxNkZ4aHFkZ3VJN285RDdTRE5ObTlpUEhI?=
 =?utf-8?B?bGJuVTVqbHpvQ3VjUmhwcVhkTStRRlRIeER0bmlaMGIyUndSbC8yYU5iMy81?=
 =?utf-8?B?a3daUmNoMk80RFA2VXRDK1ZVL2xhSWRlMlFiMDlXaGdVWkxYZDM3cE5SUGlN?=
 =?utf-8?B?bzBGdm5lUzdkR1IyVVNaaGt3c2RMQUZxK2tjdUtwUXVlU2dsQ015WFhKdmxk?=
 =?utf-8?Q?c57M2GjQPzJB6lqqg2r9naU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592c4c86-0269-4f25-35d4-08dd71f74a2a
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 15:01:47.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WygkRvRi5YQIPiQJpgncHrB1owBtyiOuagPtUbwil8pBnA8dptHyTj/3yGgbLb9mLA4FHagm6eF70sCEWIkXrilPa8d7aGR1TuAGSqMJrjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF7FD4E7D79

On 2025-04-02 05:21, Mike Rapoport wrote:
> On Tue, Apr 01, 2025 at 06:58:12PM -0400, Steven Rostedt wrote:
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> Enforce that the address and the size of the memory used by the persistent
>> ring buffer is page aligned. Also update the documentation to reflect this
>> requirement.

I've been loosely following this thread, and I'm confused about one
thing.

AFAIU the goal is to have the ftrace persistent ring buffer written to
through a memory range mapped by vmap_page_range(), and userspace maps
the buffer with its own virtual mappings.

With respect to architectures with aliasing dcache, is the plan:

A) To make sure all persistent ring buffer mappings are aligned on
    SHMLBA:

Quoting "Documentation/core-api/cachetlb.rst":

   Is your port susceptible to virtual aliasing in its D-cache?
   Well, if your D-cache is virtually indexed, is larger in size than
   PAGE_SIZE, and does not prevent multiple cache lines for the same
   physical address from existing at once, you have this problem.

   If your D-cache has this problem, first define asm/shmparam.h SHMLBA
   properly, it should essentially be the size of your virtually
   addressed D-cache (or if the size is variable, the largest possible
   size).  This setting will force the SYSv IPC layer to only allow user
   processes to mmap shared memory at address which are a multiple of
   this value.

or

B) to flush both the kernel and userspace mappings when a ring buffer
    page is handed over from writer to reader ?

I've seen both approaches being discussed in the recent threads, with
some participants recommending approach (A), but then the code
revisions that follow take approach (B).

AFAIU, it we are aiming for approach (A), then I'm missing where
vmap_page_range() guarantees that the _kernel_ virtual mapping is
SHMLBA aligned. AFAIU, only user mappings are aligned on SHMLBA.

And if we aiming towards approach (A), then the explicit flushing
is not needed when handing over pages from writer to reader.

Please let me know if I'm missing something,

Thanks,

Mathieu

>>
>> Link: https://lore.kernel.org/all/CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com/
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  2 ++
>>   Documentation/trace/debugging.rst               |  2 ++
>>   kernel/trace/trace.c                            | 12 ++++++++++++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 3435a062a208..f904fd8481bd 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -7266,6 +7266,8 @@
>>   			This is just one of many ways that can clear memory. Make sure your system
>>   			keeps the content of memory across reboots before relying on this option.
>>   
>> +			NB: Both the mapped address and size must be page aligned for the architecture.
>> +
>>   			See also Documentation/trace/debugging.rst
>>   
>>   
>> diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
>> index 54fb16239d70..d54bc500af80 100644
>> --- a/Documentation/trace/debugging.rst
>> +++ b/Documentation/trace/debugging.rst
>> @@ -136,6 +136,8 @@ kernel, so only the same kernel is guaranteed to work if the mapping is
>>   preserved. Switching to a different kernel version may find a different
>>   layout and mark the buffer as invalid.
>>   
>> +NB: Both the mapped address and size must be page aligned for the architecture.
>> +
>>   Using trace_printk() in the boot instance
>>   -----------------------------------------
>>   By default, the content of trace_printk() goes into the top level tracing
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index de6d7f0e6206..de9c237e5826 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -10788,6 +10788,18 @@ __init static void enable_instances(void)
>>   		}
>>   
>>   		if (start) {
>> +			/* Start and size must be page aligned */
>> +			if (start & ~PAGE_MASK) {
>> +				pr_warn("Tracing: mapping start addr %lx is not page aligned\n",
>> +					(unsigned long)start);
>> +				continue;
>> +			}
>> +			if (size & ~PAGE_MASK) {
>> +				pr_warn("Tracing: mapping size %lx is not page aligned\n",
>> +					(unsigned long)size);
>> +				continue;
>> +			}
> 
> Better use %pa for printing physical address as on 32-bit systems
> phys_addr_t may be unsigned long long:
> 
> 	pr_warn("Tracing: mapping size %pa is not page aligned\n", &size);
> 
>> +
>>   			addr = map_pages(start, size);
>>   			if (addr) {
>>   				pr_info("Tracing: mapped boot instance %s at physical memory %pa of size 0x%lx\n",
>> -- 
>> 2.47.2
>>
>>
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
