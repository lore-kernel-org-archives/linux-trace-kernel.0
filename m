Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794727057;
	b=klgc6hRgsAUV4D/gE1JMLgh7XZiIu4Uy1ksKUWdrlt/mQLp4EDpRAYF9/UgtZYn3v621
	 6rSl3zg44A6M72JyucmwdvkkuSr8HkvrOUhdJuKIE8umB33usSB+NzNkWDMsqky2yI13B
	 kTvS2KyyNx+6yLHN4Z3baAw2mzvCB+jZFqAvIrkH1qtfhAmg5h3EKNmYAkzZZYMCBNTPt
	 YyL887chsoW2ak7Uti5vjP0FX7LyaoJMuBWnRrc+QWwb2uvaRbEVyJZPcBiMjR+2bc1eT
	 0po0el8mFgNHyVzMcPdcpgqXUphtS+Dw7Faxj9cQftplD+ELiiL7RYs4NRvPgnkszng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727057;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jA3XxsFTm55bdn9xJgLUVE5bkeI9KRrqnLjY44lJZbY=;
	b=AS2WUTfc2BxJ6I9Mg6mgjSDSpFNViStR6hUb+bhHkhLFLszJ0bK70FaJ1cE0Js4/zLnj
	 F3LMAF+oxnVQBZBtMxhlXT5n/eFGjc7kliYbs69yZmjwJYHSyW6SOxgciryvOHMHDBnAT
	 2zArFTgfxuO0OW/iuKlGI3+kyNcOoyzUhgaEToiU5z/FV5sQoFBPfjfBUHbki1P8ylza2
	 3H2GHnB7NqTfyxiEIW6Pic0Jl3JDsXnU6wIdaKXKyxV3KQbMw/FaiOToP7uvRUAFuaxO5
	 R3LGiHHjRJ/gKS+JO1GCOxLocX5+C6RrjWflx3G7ch5hT2uYm5fu31JnziBtXvXw10A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	dkim=pass header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=ADwOqrq0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.64
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E0606A31D;
	Sun, 15 Nov 2026 07:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A90E0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=ADwOqrq0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8xw4P2xoQkON1R58b8dSNsufu9QF1/1Zr4WbUWLv4mL1JShtl6wPcmo4UyhMs7tPm2VsqgL5PvFs49hqn4LOAhDX1lUN4H7xqmwyXhaZOPsz6QI/zuElAnBX8bF0c1U5pLvaD/l7Ho2vwLiI+qaNsRXVTMJbPrW/j44fguzlaXwXaZGd4Jsm8xLdgmuwVLeF8U948lYembqRz9WIsRn7om9Beofs/f2l6Bk4CCFhKChWK+BpOtroJWpiOgi6a293cceBfh2tq3PEk4z4gf3lbgqPbPOqTaVcz74Y+5yIhxV1veUK46fh5LAlYIxCPNWdGJUzO+/Jq6IVPuZoHTXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA3XxsFTm55bdn9xJgLUVE5bkeI9KRrqnLjY44lJZbY=;
 b=BAcYdj/UF3Yp+nRVU43gkrdcOai271TZ9ur5z/E6HeReKOffr/tXEFc0vJS7EZb1VsDJSEuvj6uklsjcJCWo+y95qMZFRBeY2TbqYoEPbqldUduezZsJWrWQvgb61xK0uVDVSPJL18I+N0ART/ffdjiZNdSaA70M0fuUx8JlUCJgvicOhpbZ/XeUd61RVF9W/k4M0qGn4c0TMR/FcYmsuvFEvVmEkurhdlJyGrf9AAEgDq30hjeo1DRk/rSn3vN00IsBN7i4Ua3E+XWVd7LSa7XUy7vyZu8cZ2Hll/5qLyiw6GADy6Fb6yFTtWy1mUq+7IuC/bPXohu8Toc72suLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA3XxsFTm55bdn9xJgLUVE5bkeI9KRrqnLjY44lJZbY=;
 b=ADwOqrq0Tmk0ZoG4C0eXv/hB9C17zdg30G5PCQWeHpF2+s5vlBQgzUXaSXmOpJqWenCym3KIZWV8RR7NrJjqa0rfeiAkpVDJ1UIPiKEMZ4k+JpC30+/urVL1csc4N5DeuXXXnugSjEJ8OenR5dPJ9Da0VuhH5HFeLyggZTaUu+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by AM0PR09MB3940.eurprd09.prod.outlook.com
 (2603:10a6:208:196::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 07:17:32 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 07:17:31 +0000
Message-ID: <cd92fe07-9a9b-4a21-b596-1b2d007b4c9f@mobileye.com>
Date: Sun, 15 Nov 2026 09:17:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] riscv: probes: reject probes inside an LR/SC
 sequence
To: Guo Ren <guoren@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Pekka Enberg <penberg@kernel.org>,
 =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
References: <20261112-probes-in-lrsc-v3-0-a95089852a17@mobileye.com>
 <20261112-probes-in-lrsc-v3-2-a95089852a17@mobileye.com>
 <CAJF2gTTY5ODDH6XV2h1v+T7Sn5BK3L9x-Q_Qb_EXNmdCor5rPA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <CAJF2gTTY5ODDH6XV2h1v+T7Sn5BK3L9x-Q_Qb_EXNmdCor5rPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
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
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|AM0PR09MB3940:EE_
X-MS-Office365-Filtering-Correlation-Id: 897cbec1-9b2f-439b-6b9a-08df42e88372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zw+6Tt1/fhaT5azyQk+8MR+psTDshm5GoRwuBjf1c2i7lkYtbQBCtkX/3rxjtHW1inxXlzqbibcMBS71zNOFHxqAMtS6Nr5ITgcLUgWu5WW3oIaoKcfu50WKdJnaIGQogR4WXHSbSx/BnMjmlgjroqCmCPRUTJvACzxMnGhUS8E464K1m+kLnj7qxmpj0zB5TjtZXuHb6Jyr1flYYSqnLD80vSvwIyJmopR3Qg/FmHVwQNallT/crWVzx4BaO/jvwj8gPH8jG3NXB4I9VXd+T5b1bQvEdrD2TE1riW394dKVVdZzH6hrKgrJQtnWauXqG0IoRdVQAIbTe3GWDcApvYgxFEwJooyaB+Q4spxMJqELWX+FTKjqzRY6a+j7s4AGYzBoxWycw1AzDGkJXCXmLUMu6/+hoam9nn9ckxbOuaH1xf9vqgKFbV07jb25UDlJWb9fhrhb2e6ZRhXjqOuAeqzb+T4G1URB6HCkIWFaZBcu5qrT6TAzQgO1++AMTsa2LCixgNjnvAL49SQyGvvYmTDwiOKpWLNM/cTrH1sTj4j8qv+lro08XAc3CywzpRNUufhgpFI8Yud4S4ZSMrj/lzs/U2ejTTN3wsMs5Q5ySgY7zowIdX1WI0catSEKr4tqAzJ/X5GAE2V/I0B7AnmJgFQziHYjyIPGdreLWKeUU48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K09JdVZPMnJWVjBZNkwrcmlQb0FOaTNvTnd3S1MzYkloUXRyR2pmdWMrbkt0?=
 =?utf-8?B?ZTFyYW9KTE95b0RPQkZ1RUZCOWRhZkJETFgwcS9QUmpuSURPVVZQVzJWYjN4?=
 =?utf-8?B?K05uZDVtaDBsb0xqSzZ5YkRaL0JRbEZvWHlrclFQc2h3WEwreXVOMDBhOEdC?=
 =?utf-8?B?ZCtyRGhBelNCZ3pHUGdUZGxkQjJ3TjFCMjRURUJrdjFBWVhzRGx4SGc0NFFU?=
 =?utf-8?B?eGgrcXI2Y1FFbGdGZ2VUWkFDRzhGTnBCVUpCUFNqZ1lYcU56QTVtUWF2bmZu?=
 =?utf-8?B?WFNzVlhRQVcrdm5pKzRqb3MrYVJmMVYzT2FhRGppSXRZOU5oRzZka0N1VDdj?=
 =?utf-8?B?bVVUbVUzNVZaamxJdUZQTEhHbVM1MjhQbzlRdHVwbGFQdVFNK3Q4OE82TzdL?=
 =?utf-8?B?bVB1U1dZd0Q3WG1sNzZOV3h2RE5vNGdScEkycHFGc01LYW9DVmRiOXE3Mk9H?=
 =?utf-8?B?SVlyNDd6TWc4eWtoNWE1ODBZK2Nta3doeFZaZ0VTTjczRUY0MUlyMTRjNncz?=
 =?utf-8?B?eUJzV2tKZitITWNld0t3UG05VWErdFBrdTF3SmJ5VzZmRDdHY0NJRWRaR3J4?=
 =?utf-8?B?MVF4ckpLY2Z6MXQzQ09GYittaHpmOWROMnBnUXF1NHpCb3Zwek96b3hiTWtt?=
 =?utf-8?B?UG5OYWhnL1lFcGdPWElyRFcxcWRwK21jUFErZzY1RlpKcVZZQlNqTW9kZ3pq?=
 =?utf-8?B?T0hjWnRqSnFsRk8wL2hpNWF2VWlCbFYwOXNnS2pzaXV5ZUVwTWN1ckRzVTM2?=
 =?utf-8?B?cVoxdld5ZFdrdGhOVTkrMW5zOW9QWm9QRWNWVS8wSnFvVDdlWTYxU2psNE1a?=
 =?utf-8?B?UHJDZGlTOFZ5cnE4bzhQTE5aWGlBaUV3NzR3QVJhVzkzSzYyVGFWeCtlRzNm?=
 =?utf-8?B?dDRGd0Uxb0gzSjdGdSs0MSt6aUFPY0l4VGdtN3RXRmZ6aWNHWHk0MUM2c0FO?=
 =?utf-8?B?U1krVjI2bnVrcG9PVTNkdW03R1MrMFhBSVAxK28rd3ZkWGVTeXhNdlJoeVNs?=
 =?utf-8?B?MXFqcmZMb2QxTFUrN0R1S2g2cXU1Q0xmSVhYZmowVXZkRzloSzBIZy82Y1M5?=
 =?utf-8?B?TGxLTkVuZHZXcWxBOU9mRzgxOWNSN1FYRVEvNDRtY3lCRlAzdHVnU0lVTHV1?=
 =?utf-8?B?eENlNWpqazJ3NVVweVdTZHh3QjRXb3U3WVo2dlFLdWF4Skw4VktaaldtRFh1?=
 =?utf-8?B?YjNVS2NBSmx6V1JFRE1NZjIyRE9UZ3dESGFSalVMS3pWN2dkZGxUWlBTaUc5?=
 =?utf-8?B?K1hUNTZGTHVnb1FPdVp3L2VzMzdHK1lIK29JcTlwQ1JhWXpaN2NoSWgvek56?=
 =?utf-8?B?VmNNOE1JYjIyQzU5bFk1cy9xMlNUV3BucTlXSnJ5QVIzVWpHaW50eFRsL0Yv?=
 =?utf-8?B?MUJWQXlIbU8yVU9sWGxXTWd0TW42aCs4MUZJZ3Z2RUhXMFdIYStVZHFmZTg4?=
 =?utf-8?B?anp5RXNsS1pMRy9Zem1QLzM4VGNaTFNEK2RoQk5OelE3NVNHUVFkb1F3czA5?=
 =?utf-8?B?eFE4MWsyUUx2LzBrbldKRXhESVlha0tFcmhiNjRUSFZjeVg5QVdKWTNab0lN?=
 =?utf-8?B?N2N2dzRxKzIzdWsySmcrMC9CZ2ZNKzl6MlRiMWNuZVc0YWpMWXIxRzgxVkJQ?=
 =?utf-8?B?enZQd1BNWTZ6KzdYUWQ2VTl4WGh2U0QveXZUbFltc2REclBvUjRTRUVjODN0?=
 =?utf-8?B?d3JUYTM1b1Q2aHMzVmJnNzdnZUl2TG02MUZJQnE4Qi9oYnBDUm4zNXl6YVlu?=
 =?utf-8?B?b3dkTUM4QVRJWWhOUmJNellVcEpVcnVqcGtCbS9BYmhEYlBkWjJ4bzJnNG81?=
 =?utf-8?B?eXQzTWdESlN1WXk0V1I0QjNlNFJXYmlybk0xblpqbWZsUHlzbWtYdmJoaE9M?=
 =?utf-8?B?ejUwN1R6RmZyN0dZY0pzdi82YVcyRU00ZUJZNXVLay9vZXRPN1V4Tm5ldFJq?=
 =?utf-8?B?aE41RVd2eDRPSFlSbFNiSFRPbkVDR0NPTXpRRUdvVHQyNFZuOGRZY3owUHBo?=
 =?utf-8?B?RWRyQkllSHArSElERCtPZHNiNFYyMTg5STZSRDdvUjFFWmtCTlFGSnFxdGNv?=
 =?utf-8?B?RitDSEE0TE1IOFdZcGpUVk1vTU12SmJCbWZWMjVZSTdNVkc3SXg2NnNsNmIz?=
 =?utf-8?B?cHFhSXBTRkk5UlNIRWRyNmlDTVBxbXloKzlOdFBzM1grRE45RnF3NTgrZ3Zt?=
 =?utf-8?B?cTJscTJZT3NlVWVTbjdZKzc5YytmWkhncDFYY0FTdlRKSVpyNlU3R2tYaE8z?=
 =?utf-8?B?TThDaTV2UlMwZjFjcUNwSlZJb1JsM09XWGZoUDk4VjJldkVXcDhpU0FZcWFz?=
 =?utf-8?B?RHdLZ3pSTVBIN2R1Y0kxeWlJbDZXVERMaS9Kb1pLRVhYaU1XMFlNUT09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897cbec1-9b2f-439b-6b9a-08df42e88372
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 07:17:31.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6MGx9KdbwMhUv7tuTTYMkedaEJpezzNokDBEb7KGNMahpmMp1S33L/cLt8SigslXHOdEZad43QgEDbgQSGLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3940

On 11/13/26 10:01, Guo Ren wrote:
>> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
>> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> One patch for one Fixes tag, is that okay?
One for kprobes, 2-nd for uprobes. This is what sashiko-bot suggested, I
thought it knows the policy better than me. If it should be different,
just let me know.

Thanks, Vladimir
