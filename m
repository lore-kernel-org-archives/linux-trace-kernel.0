Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022080.outbound.protection.outlook.com [40.107.193.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F524C92;
	Wed,  2 Apr 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605820; cv=fail; b=PK+oSUaSrdt8XgUdFC/X4tzxiM+gp4xhUb1JnNdLF5eYYVMoA8TcW8pU1B2IaWlPa0Vt6mB5gWU42MgL5d0S6gXXAONMu6mJUI7VtcschyrGm2vM/TPKuoccXMmdDPfu/YXEgGHSiwWsQ1proJ7mXccihIBl13HVrmtpWpBU3RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605820; c=relaxed/simple;
	bh=mIETl3rVRq6TjPJXtx1XkaIufPQb0Xw8PpmgYhl0mpI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=thihVZtWol135B1my4FrX2C8in8KdGKFfrnPX/MP5NZo8ksPHU47+HPiG8Rgny4dnbBo+sLljeLFJUnS57q/rPI7Yu+v214bGwBTz8yad1i46pr4aDuWMUu59+QVL6X8jMmbVsKA8dwQCBHQ4J5fdEmQEStfHAI51ZmX1Oe0lGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fKeWgPYT; arc=fail smtp.client-ip=40.107.193.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fKeWgPYT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRT8G4IF82nTUZjQaPLV3XXDgjX7ZXPHqqYAyNCn350anybperPBcHX1pch5ihmpMaSP/Et/UdlDT7AFIaDCbOqI5cc22cjzipjw2B67HkX5tcnetxbEaGgR5YQe0zoU3LVYyAaRP1tqdenN2tcBkuGBfrZhgMbGZhpMBR7lhY0RX5OWesEdChhQ/S8Qidlq+FO96FgVTFJ1cAioWSreknQEbeQl1GxpWkugYqHfx8sX/jxr3kWJ4VtnuTngIWD7CiJVrczsNE3BwOSFPgzMXC5RHSRuWawXmXw5/w4IixxmPArhxrAdRRfRdmdF2yEJQRtGkufjB20BmE/7Fh6Fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGBoc9Kdt7z6zHUx/R8OmCZxWN7aKgaZHF8X1iK2j40=;
 b=WvQpvhFUAhunknu7iAqaHSJs+e6Q54R4OvONqBUCyTA83cA+o6E+9nksbp0fcLiXCThTeG83E4fAYwCXp2MeStMa+sQB9sqQm0AGO1N17UjqKNgPckGwfd+jcRQQ1DLBAfGdCnN2n5P12S3iqT0Tb0gxv2xXGoA8xlyTAoUZY8+6fLLzDzBfFp59sl15+JHYXwiDi4CTthtctaThBicUQh+3rjaHt0WaybhB0VCoconj1Osume7q35ShP4UzPQ66NndoVgav8yFB++6heUn5yzvucexFo77XF12g79m7MYCqFVgzQfIMOLNK3wZJFDxRadPzuN2oEoTH4Kt4IxCUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGBoc9Kdt7z6zHUx/R8OmCZxWN7aKgaZHF8X1iK2j40=;
 b=fKeWgPYTTq9huo6pprzkVtYwMGwPWABe6o7NnsFfyXRvvbeCL7doffCDY/yqUGrpoVzUwCs4etfDb971nLQlbtRZw+R6OAzbN5tC92b444SiMB4sMqxDzcLd80otABumm5S0y1TMw/NyDjoscUJtSa9ckLlSwke/gge84BBBBZWDO2GrVYzbhrVLyHUFr3Q+0cfidCLimoE4mVGw/AhbpATp0A8jZm5q8RWnZE6O2L2LUs0OfNqUxvGC75qIT8nQAgtistf7pYXQ2hULHFzEptnbEVUomPgRRqBuCu7YwElN0bo5AaNLsffgVudtQlL5qhZI72FZG5cVis73sw95gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQBPR0101MB6086.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 14:56:53 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8534.045; Wed, 2 Apr 2025
 14:56:53 +0000
Message-ID: <c3e395d7-0c64-44d0-a0a7-57205b2ab712@efficios.com>
Date: Wed, 2 Apr 2025 10:56:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] tracing: Clean up persistent ring buffer code
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Jann Horn <jannh@google.com>
References: <20250402144903.993276623@goodmis.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250402144903.993276623@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::34) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQBPR0101MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bad7b62-a79c-4012-54e9-08dd71f69a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjV5bTdyWkw4VHlPb2xZcGhPSUxNTmJkT3pLNU5DZ3pxbUd4ZUJuQk1WVDFz?=
 =?utf-8?B?b3planUyZlB4REcwWmd4TmdrZE9BL05JVVBFanZmUStocVBjV2tUOW1CK3lW?=
 =?utf-8?B?WnUvR3Z0eHdoa0s0V3Q3bXIweHdKblg4RW5IZERzQThOdG5qMXA5SDNZc00w?=
 =?utf-8?B?ditmcDBUOUorVjVYeTlPWVZqSHlDT1pUbGs2eUZtNXZIdHVjN2gvQXE1Lzhz?=
 =?utf-8?B?QjA1NHFRTi9LdlRuY3dEQ0xtdVRGR3RhUzY2MVIxZlAxTGR4QzNlaFRYTFBN?=
 =?utf-8?B?NWtnTUpLYUdSWEdNellEcENVWDM2bG1adG05UmpFNWN1WGJSeHV2NzVZRjVv?=
 =?utf-8?B?UGFQNVdiRUp1VHVmRWpjSkZCS2hXQkN6UEtCNHRrRmlpSGFFeWhRckxyam84?=
 =?utf-8?B?VTdRYndKc0haT3VPczNSYXh5ZE9ERXVLd2FxQURsNFBtMWlzVmV6V2Q0SFJk?=
 =?utf-8?B?V29ranB5Skc2SUJVL0poWFQzSFVYL2luWVZrNjNldGpOR05KYXVSNEY4V25n?=
 =?utf-8?B?Y0ZRM0dickZCN0lBcE5iNzlWRUdUVkpFQ3V0UzlwSndtRCt5ODFHQjVwOHNQ?=
 =?utf-8?B?UU1YY2x0UllmRmdJZUdLU05mWDY2SzdZZHpVV244TnBZNGVKMWV0WGNZR0pS?=
 =?utf-8?B?aTdiL0R3b0lUZ3NpbWxZQW1DUDlPZjY2NmtISzMxUnNxRC9kQTlFbDl5b3pG?=
 =?utf-8?B?L2QwcnFxZmdNclFQYkpFREYybHpHVGRIS0pZMGYzdkRDRWtQaU0rOVdjbnFD?=
 =?utf-8?B?TzV3MU1LUURSR3pCOTRMVGdYY1pqazZNVlh2OFVRV1E3ZDlOc0g3QzNoRTJY?=
 =?utf-8?B?TUJqSzBBY1RDanhmZXNCTkRraEdnZDFqV2dNeGZVbDVKOUc1SlUxdmVmK3Fr?=
 =?utf-8?B?TDkySzFwbUlNK0NZbzRHUUhBMmpFeWtDY2prODRaMWtGWnRSRWF3TkM2OEtx?=
 =?utf-8?B?NXAwZTY4U1Z2MGFmMkhHYUEvb3N2SlkzZ1p6bGFubG9kWDArVGI0b1J3aTY4?=
 =?utf-8?B?THBrdGZCZGJsWXcvMXYzSWh0aHhSWHZqTXNPbVJKTStCdjMrbENVMjY4SU9U?=
 =?utf-8?B?NnpBcVlYemFpNHY2QXNoaVh2NjFyM1pzK0RHazc2VW9lNVBZRlRDREV2RXlS?=
 =?utf-8?B?bnExb3RacUR2WXRwRFQ4MGJ6SGVyM0QvT0lRdzczSDJjV1J0QnpyUDltajBm?=
 =?utf-8?B?SXNubHlmYkdkN1B3dW5OM3RLeno1dEVuVGVhbEpQcUhHSWtoUEtkS3Z4czRX?=
 =?utf-8?B?cEFQamh2czRzd1dYeGQ0R3RwcmhKZ0FBNVVIZGpyMEdDTDY1a25aUkNRNHly?=
 =?utf-8?B?aGpGZzlQc2F4MS96TGFHOTJQclg1bDBQTTJnNDR3QVhKQXc4VUdQNWxZellD?=
 =?utf-8?B?WkNSTGVucFFBMFJXUmtUdHI5cFk0aHN6dXRZTWxjZmR0dkRBNGZYV2RqQ3BD?=
 =?utf-8?B?WW5PVkZQOFVZUklCNGMwcHdpVUY4R2huMHhrandES29PNVNqb1J4U1NxVUFX?=
 =?utf-8?B?Sld2eE1ydUovbTd5Y09TalRJeXVrdFR6K09WemhxSndxN3NGZXgyWmk5dGFz?=
 =?utf-8?B?V05BZmFKMmtvMjBmdmFjcFpkSUJKQzJGd2Q3QU0xa0gzanRrRitHVVlya1ZW?=
 =?utf-8?B?Vy84Y1lIKzVMRDE2dTRnSE1UckwvL0UvU2hxZjBTaHcwY0tCc0szNFF5c3hP?=
 =?utf-8?B?UEdqUjhrSUVVZHNpVk85VHo0UWFHS0F0enJhVWdnVXQ3UUxPUkJhRUl0RXYz?=
 =?utf-8?B?blorQVJnZFZONUpzM2NzUUs0SHJvKzAzY2FXa1Q0dzlrbDl0U2JIN2x5clJH?=
 =?utf-8?Q?UV35uSSuYPOLRcQG+5Eadot+S8vvWNp9S7V4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTNOcmcxbGdhK04xQWhjUzhubU5ISnZWM1pwUXhsTXFyWk8rQnFFZ3R0Z2p6?=
 =?utf-8?B?d2Q0MGlCcldzeTJLcmlick1XZ2hjSHVXTVhscW83Q1NIMXk5Rlp1elBiamEz?=
 =?utf-8?B?TDdjRk1VdkhyMHA5cVVkZW50bHNad0NlSFNwS2FDRFBwdW90NjBNbExQeWt1?=
 =?utf-8?B?WlBkTkZqVFI1NUMyKzRnTjBKWjJYYXhrSTd3T2hFTS9yU2FvNjJYeEVUYWdu?=
 =?utf-8?B?YWEyZWsvZTJIR3puVklBSTR3bFFWY1dRMjFQaTN2L0l1Z1daOWdQU2FOSWRJ?=
 =?utf-8?B?Nzd2ekxtRkJrNFNETVZGOVhIeDNkSWozQklYQlY0RGNNKytHVzhFTmRaVGgz?=
 =?utf-8?B?NFpldzVaWjNsV3p0T2ZoVGg4a2ZhNko1akFTYWhCV1JzRmxDQjdndVJzUGpQ?=
 =?utf-8?B?eU5CYjBNNWZDZ3pVaWplUXk5d0hXbEVjRHF4MXlhQ2drM2dieXI5eDY4OU1B?=
 =?utf-8?B?LzRFMEpFOS9CZDNiNU1tUXlKeTBiU091UFprN05WVkJuSUErM3d4Tm5GZlpG?=
 =?utf-8?B?K1V2ZHd1T2s1NW5aNVF6dTNMbW9IbmdCSVZvOG5FUEVsWmtmVTBOSFM5UjZS?=
 =?utf-8?B?TlpaY04vRm5SMGd3Q0pFNm8rNndwNXQvYVpyREh0RkpMTU1yTGNYU0ppWU1D?=
 =?utf-8?B?V1E2RkI3bjAvcExiQUhicFp1VFlNa0N1Ri8xUEg3ejh4R0ZaVnZNRHRkRTcr?=
 =?utf-8?B?QklYbmF5cTkySUtJKzFYNHNvektNNzJwQnNVb3RDRFlTRktaT01iT3BhcDQ0?=
 =?utf-8?B?SFZ3R1hXMEtyaW4vV0xnMU83Q2RRckJRTDVPeWdTQ2Rob2NIcXZSMysxbGh6?=
 =?utf-8?B?Mkt3a095akRwQVNvOHVBWUpHWXI4aU9UOTdTZysvNjRIOXdVeWJVbXNFaUQ2?=
 =?utf-8?B?bmFZZjJXWnlYcFlLYkFpWlMxM1ZIMDdGODhudVZybHI5OWlxMHlwbHJ0UlVX?=
 =?utf-8?B?ZHNNUExYMVBTaG1qTWV2UW9FVnFWS0NkNW9SUEVSblRSRUpBbFpnaUZuR1dh?=
 =?utf-8?B?SFpLZllpUzBvdGhBWE8yMnBiVGtlNUo0VWhCci9CWVJ2clc4ZzdNakwxVVg0?=
 =?utf-8?B?blpNemFEYnROL0w1bmhpaGlXUjFnaUFFeisxb2lFeldWRXN2aUhwS25hV2xY?=
 =?utf-8?B?WEF5T0wzc0ZnNU4vSHdmVDQvNXg3TUh2QW43d0Q1RnEwcW0xOURPWld6TUda?=
 =?utf-8?B?OE1RT3drSUdhZEpmUW1sWG1QU1JoNHBKMlpvWUxqdGJlUXI3RWRFanlzYmFM?=
 =?utf-8?B?T3hSa3R3VGg3eGNLTFNlN1FBN1hSeTJzbTNEazFLMjhKNWxyL0RDb0Q4bmJ3?=
 =?utf-8?B?RU5yVE8xNzlkZVhVZnlZbFY4U0djL2JkamV5NWpKaDBIcDFBV1FlUVZLR3lI?=
 =?utf-8?B?SjhtY0pqSjVhTWF0WDNpYjVXUjB2ODJFNlJob0g3TWlCSDQ0QWJaUG5TOEtq?=
 =?utf-8?B?UkkwT1Z0bnVJcmxVaytCVkRzOGZ3OFYrOGxnZW1zMEFrRGd3dGR0N0NGbzZ1?=
 =?utf-8?B?eEtpK2UwK0pBV3pkV3ZGNWdxbkpiYVEyMEpKalRnYWZQR1FQY3BkeUV6S3N3?=
 =?utf-8?B?bEpvSmJ4WWl6emRrNXhKQTFvdW5pQWg2eFh0Ymt3OG41cnVUWVdhSFl0UFBq?=
 =?utf-8?B?RXBHTGxBc1JNNURHa0s2eUoxM2lBdVk1cWt1dnNTemY0MkY2K3dKN2JlMnZ0?=
 =?utf-8?B?TCt4WWl3U2t1OTI5bUl6cmZneWNRSzFNZFc4OU91VnF5YlU1VFBaOTEvUlRZ?=
 =?utf-8?B?dXU5blcwczkzZE01ampaNVhZd1dybm9vN2ZWd2t0VWpiekY2YUFEVzJPdE9i?=
 =?utf-8?B?Rll4WmZkS1RJOFhoWXo1dGM0WGprUmNSTHRWdktMMkVPcTFUbnlJWCtWVjZu?=
 =?utf-8?B?SVRsSUYyV3dtZmN2NFAwaVZuUERxb3FEMGY2Yk5vbGpKOWFKMFdiR2ZRVDRi?=
 =?utf-8?B?NHhNNFJqbE9qYTZ4bStpTFZvOGEyWGtybG5RRkdYR1pGOHpqNHRGSzIxenZW?=
 =?utf-8?B?MlJRd3d6NFpnK2ltcVV2ZnoyeEhqUEJWZnp5RTRJelBVd2dxZE1hUUxyYTUx?=
 =?utf-8?B?VHBlT1R2anp0KzY4YzVFUkxNaFhpQUNmbDBOYlFyYUN5S3psQ0pKRlA3RTFU?=
 =?utf-8?B?Q2pLYkVCUXFRcTdicDArbVJoenZBZlM0enVucVA4MEdrNHdWV3plNlVYSUl0?=
 =?utf-8?Q?i/F7mTDqj/wgLXlXRjKpwpg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bad7b62-a79c-4012-54e9-08dd71f69a7b
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 14:56:52.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J85AyfT5k6UqC1MiXST8hKcqvaMHVBpLUyT94v5Ltsdx0W/5K4j6R21CAtVB8jyNx4G6WlBdEF3xUxKWZKzzfMhtdWr9pfOhnhRqnKze4VA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6086

On 2025-04-02 10:49, Steven Rostedt wrote:
> 
> Now that I learned that the memory passed back from reserve_mem is part
> of the memory allocator and just "reserved" and the memory is already
> virtually mapped, it can simply use phys_to_virt() on the physical memory
> that is returned to get the virtual mapping for that memory!
>    (Thanks Mike!)
> 
> That makes things much easier, especially since it means that the memory
> returned by reserve_mem is no different than the memory retrieved by
> page_alloc(). This allows that memory to be memory mapped to user space
> no differently than it is mapped by the normal buffer.
> 
> This new series does the following:

So I've been loosely following this patch series, and I'm confused about
one thing.

AFAIU one goal is to have the ftrace persistent ring buffer written to
through a memory range returned by vmap_page_range(), and userspace maps
the buffer with virtual mappings.

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
some consensus aiming towards (A), but then the code that follows takes
approach (B).

AFAIU, it we are aiming for approach (A), then I'm missing where
vmap_page_range() guarantees that the _kernel_ virtual mapping is
SHMLBA aligned. AFAIU, only user mappings are aligned on SHMLBA.

And if we aiming towards approach (A), then the explicit flushing
is not needed when handing over pages from writer to reader, but
an SHMLBA alignment should be introduced.

Please let me know if I'm missing something,

Thanks,

Mathieu

> 
> - Enforce the memory mapping is page aligned (both the address and the
>    size). If not, it errors out.
> 
> - Use phys_to_virt() to get to the virtual memory from the reserve_mem
>    returned addresses. As the memory is already freed via
>    reserve_mem_release_by_name() and it's not mapped by vmap() anymore,
>    the free ring buffer code doesn't need to do anything special for
>    this mapping.
> 
> - Treat the buffer allocated via memmap differently. It still needs to
>    be virtually mapped (cannot use phys_to_virt) and it must not be
>    freed nor memory mapped to user space. A new flag is added when a buffer
>    is created this way to prevent it from ever being memory mapped to user
>    space and the ref count is upped so that it can never be freed.
> 
> - Use vmap_page_range() instead of using kmalloc_array() to create an array
>    of struct pages for vmap().
> 
> - Use flush_kernel_vmap_range() instead of flush_dcache_folio()
> 
> Changes since v5: https://lore.kernel.org/linux-trace-kernel/20250401225811.008143218@goodmis.org/
> 
> - Use %pa instead of %lx for start and size sizes (Mike Rapoport)
> 
> - Updated change log to use memblock_alloc() instead of memblock_reserve()
>    (Mike Rapoport)
> 
> Steven Rostedt (4):
>        tracing: Enforce the persistent ring buffer to be page aligned
>        tracing: Have reserve_mem use phys_to_virt() and separate from memmap buffer
>        tracing: Use vmap_page_range() to map memmap ring buffer
>        ring-buffer: Use flush_kernel_vmap_range() over flush_dcache_folio()
> 
> ----
>   Documentation/admin-guide/kernel-parameters.txt |  2 +
>   Documentation/trace/debugging.rst               |  2 +
>   kernel/trace/ring_buffer.c                      |  5 +-
>   kernel/trace/trace.c                            | 66 ++++++++++++++++---------
>   kernel/trace/trace.h                            |  1 +
>   5 files changed, 50 insertions(+), 26 deletions(-)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
