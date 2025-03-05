Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022074.outbound.protection.outlook.com [40.107.193.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF421D540;
	Wed,  5 Mar 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182830; cv=fail; b=u+b4SB17I2xtApjBTD7QB9i/5sadRdGE5XfZ2e3g7MDyg32W84Hl2SIMo0pIR2F2NW9hBTrHbicMR9YJYwU6QWYcqkfmcj1JPeqqqxSmdNkPG3HBdIvflnWaITI8TdvMC4f0TT1ZEo+kA/hDg95xc9mCPcXzsuf2LWaFDQ9fq9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182830; c=relaxed/simple;
	bh=051Zg5V42k9BnQbyUBLr0xzCIjVgytZstjAOVJNolfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NBd8riAeaW3KDohzpsU8Xe+u4wGl1GWnSBm0wJDTKsaZyW4kakBijwdsHbEqYTpIYGa9pUTvL83fnQvn5Y8jr33HuawdQANBDSh4e9OhbXBJ2uWEWewy8Griaw7kRtz2TV9700Na77qXxMZYeKsaFFc1lhbKZGP3r5iyMkd8aiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oMOrPIfO; arc=fail smtp.client-ip=40.107.193.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oMOrPIfO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttCwhd+VlxAGKWZb9tI2MIB4+oFkZgz04V244CnFEv/3Tjn/lJk4cDcQJlef4J1Fdp0RpcPVXZF2PpWGIBVqmeTx0BQwzvv+2K1mPaRR+mwVv6kiZcFsKijBm63K1EHLZ2ZDWxB//cMz/i+ZBOB78kjd+juQfDH2dYyDk5uhGbLI58+uctKaBDvJF1c9fY7BpEUSo1R/GHQlFyJumZvJH5NQsGSABSzb3X/YO33St26jsy5ZI9xfAhNjkjtOT59DAwjbiVRZtsjDS9fCVux5oElFfgHN2lOoLhymAjVZ++2KvYapEZvvgokJ7tLltuE+bcj3YPXsM/3tXd4lBI0Rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/z0+1IfXnynVqVwG1CV3JKDAInxdefvIFzfMJClyk4=;
 b=qQznRU9/yH87X9x5rmuyxu+3dm3b8n0DpH+5O56J9+QIDv5BtiO82zJAb1jxxSl3k1ppOrkMBglBZXTylfp7dPzxAgk4ivX4erQ/kG0pZwKiFRk+pcKLub0VAjjURQbUbHdhRJj2LDr1f7JGJaF1DNGyNzJ9KUSdU9c+THJY5pOBzz1x6RpcsT1yGu51wiOZd5gVye8Ta7hn1Nef4fQfaWWoTeAtl6SDP3J9tJ29vpMqeAGiv8Zgu6lYPMZ0xMGPHC57sgBb1xtFU4RpzcKbyCvpzrSnTVNC5k6bOSdV9f/MY2CUvSrmc2OuoTE50/YeeSZPoA/ANTYiJZqsoxMTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/z0+1IfXnynVqVwG1CV3JKDAInxdefvIFzfMJClyk4=;
 b=oMOrPIfOMIS8Z3MiK+ZNoSKUQVgeFZ1/5PHa4eyYVexAkVcymC4BvEGkEzPWjQGM/RtH59fo13ZoMD+nf4LOVSSo+V5UDgyu4fQWxWbE5j+C48gH1wvYoJqVBm4nchuTVRE9Zo4rk1VCJn8kiWNFfzlO+3NDo/Lujg/Jp+gbi7K985dQ6hdyFkgEmUuhvlj1jlo2h+jm1HxPbDhy0xblYqRFVcZZSakqvRcanLo+j56xK5yNuA0Rm/kDZPzpxrDHEOZ2VexQmufFNmyTB1sqb9lo9V9FWH/RVEkcMBYfaGy50xwAwxIjXh/g3G6AXzm8dAu3vcClyG2VW/yvhIqUpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8821.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Wed, 5 Mar
 2025 13:53:44 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:53:44 +0000
Message-ID: <f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
Date: Wed, 5 Mar 2025 08:53:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend ] tracepoint: Print the function symbol when
 tracepoint_debug is set
To: Huang Shijie <shijie@os.amperecomputing.com>, rostedt@goodmis.org
Cc: patches@amperecomputing.com, cl@linux.com, yang@os.amperecomputing.com,
 peterz@infradead.org, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250305015505.14493-1-shijie@os.amperecomputing.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250305015505.14493-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 8110f224-45fa-4387-a8f5-08dd5bed2537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXJZQWxNNUp3TEtOZW1uQXhJZWNCVnB0YlNxTkVJdnlYVnl0Ni8zTGFGYjRD?=
 =?utf-8?B?Nk9TbXdyU0MzTlNqenN2RjNYRHlzclowTEp6aXpOeGFKeDdoWXk2cHhaWFNH?=
 =?utf-8?B?UzNuNWtLQlFXd21hV3MwcTdpRmpQcHlrUVJQWVUvUStFdlhXYWV1LzFmRUV1?=
 =?utf-8?B?OGpNY3M4UEFhYlRqMUxSZlNXRFI2bm1xREQ4VExvNUZYRW8xYjBNakh6UkpY?=
 =?utf-8?B?MFN4NzhlcmtqQ3lGaUd4MDBRZTJCN3B0RXJWbFF1MGZuTzJ3Unh4blhCTDRM?=
 =?utf-8?B?aFk4YTZ5S0JLWUh1ZkVaaEpmVGJPL0xhTy9Oa3BDUjVRYWJ4cllsc1hHRFl1?=
 =?utf-8?B?TXlCU08xaERoQmRWZ1BpbmVydTEyTGczb3gwS25XeEJVUHdya3QrVnNQbktD?=
 =?utf-8?B?b3BwVUZDaVFzclgxNHhkdHg2UW03UnhiRU02REJ4UlVyOVNEaEsxQWVHUng5?=
 =?utf-8?B?RG4xTGp2dlFHaXJxOE1pdDFTM25FMjNiYnlOcDQ4c3VrSzAxaHZuZGs2V2FX?=
 =?utf-8?B?ZmpUNEk1Sy9FdHdCcTlHVUhGQ05mamJBdmN6WHJEdGZtaDdzYjJ0cE5IbERa?=
 =?utf-8?B?WVM1Tk9USWRZeG80WEdPak53Y3JOL1MvWWRPbVl0bWZTVEFTM3U0cjR6MVh6?=
 =?utf-8?B?L1lPZjZiTE9HRHpYckZwZkpTWnlJSEE2Ui91ZlhQTnNmSWhzQUVhUVhoWDBQ?=
 =?utf-8?B?VGJnV0hvb2k1em53alROcEI3TFJsTWlIcFpidGMwS2pKRGV1L09zSExlc095?=
 =?utf-8?B?cXhwbGdoR3hCV3JjRklJR09XYlQyZExKcjNkUHlKWmhnRGNJdVFQNGJLRkln?=
 =?utf-8?B?MnQ5RlhRdzVraXFtMTdvdWhNSWtJRnhqcVl6SmhzWFVWWkFPbEU3aWoxaWIy?=
 =?utf-8?B?TXh2ZElSbXo2ZDhXVCtGZXR5TldDcTU4TVJ2L1hEbEpncWFvWkdkSWNkMEpo?=
 =?utf-8?B?aHgyaEdYVzNCb0YzMFN4U3k4cHMvR0hNbVZ5S0wvS2Zva2pCdS9leGI5dGFl?=
 =?utf-8?B?Wkl4VDhCSXh4bDFnaTZ6VUo5WHVzZGdWdVpJaFRUNDd5TTUxVVJQTitLQ1hl?=
 =?utf-8?B?RzRsWFpudFpWTXJiMURyK2dZbUlSME02RE1haFVwRHMvYkF1MzcxUGp5VndO?=
 =?utf-8?B?YzFuaDdUZVJKaFVRY1MvdHZZS0JlVGJ6OW1WQURQK1FWMDNydVlnbzNPcWRn?=
 =?utf-8?B?NThURnFEeWh4ZWJQdDI0ZUZKdlJsT2tGSUFZcUkzN0lCSnhtSm51Z3pMb3NV?=
 =?utf-8?B?cXZkV1Jnd2podTZQUm9JZkZubnMyM05oNFgwNCtCK0xZaW5Ea0x3S1FoWXda?=
 =?utf-8?B?TXR5RFFsY0tVd3AybWdmVWVJeVVEci9CRE5CR3ZyajJ6K3EzdlRXbUUzem5X?=
 =?utf-8?B?V2NQNHNmYjdtZXY3MHR2Zm1DZG1HVFhBeVZqY09mUVRoNWZvRUJFdEQyTWpT?=
 =?utf-8?B?TEZXOS91YnRhdUV3cnpjZTZsVlNMbFBSVXlNR1pUOU9SR2UraVdtYTlna0NG?=
 =?utf-8?B?WHdsMktiejFYakVSVnJCdWpkZlpGUHo5VGNNS1gyVGZ5N1lKWTFrQ0VGSDlU?=
 =?utf-8?B?V1RNVHNyb0JIR3lUdFV1OVg4bksvZXgyeVJXaUE2MHVidERRQm1uNTRDTVlz?=
 =?utf-8?B?aEZXcTd3ck41eHpha3pnMEJ4Y24yRVhUbThCb0t1Um1kei9Fc0IvSWhRQUhG?=
 =?utf-8?B?bityYjh6TVBJM0xaRnl5dkFwRm4zWDVNOWduOEtqa2s4K0VNUmZmSzdKODlT?=
 =?utf-8?Q?Wj1TXt07zbO2u7/kG0Ek84eVfEsCwbf+zy+qsnQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWdZK1J6MGNoL05Ba1BlaUJ1WmZvbndURVFHRzd6bUxGRmZDclhYTEJaWFdJ?=
 =?utf-8?B?ZjRScFdLeUhZWEZ1YmdZVW9VN0tGbXV0eUZuVUZEc1YwZHN4N0U4NEkzblhM?=
 =?utf-8?B?TThwaXZSa1ExM0JpN2hSK3FHdWEvZ0FQcmp3QTNDR1JKTjNsUkNwenlkZkN3?=
 =?utf-8?B?UXZ6T25iVytIQ1gvbkxOTUx0dUpKYnZEZE1pWEM3azJiSE4wSml0SUVmUjNI?=
 =?utf-8?B?OFFlT1hYMTdrcVNJYlpyVlBJWGxRNzdhY1FxZW51Tm53Q01ZTWF6N0RRRlRP?=
 =?utf-8?B?dlN2UmMwakMvL21XWGx3UU9FMzc4K1NpWlIzR1d0UFJZMUNaT1FNRkVLcmoz?=
 =?utf-8?B?MWN1dG1aYk1jMW5TNHZUQ0g4S2s0N0lURzJFRUhkZnk0THhLZitENTdkMkd3?=
 =?utf-8?B?eVFrNzFYMmpDc2dIcVlaMXY2SDljZ2VUZ0xMcUdYbktvWk9WMVUrYUxYaXBi?=
 =?utf-8?B?SmZRTWQvSUJLQ3F1TWVCY3JjM2IvNzYvdkcwMlI4WDJRVDM1NHM4NmlremxW?=
 =?utf-8?B?SXI2TUNNclo2ZjVGVWhzZ1llSXM2bWx0ZlBid2p6SGZNVnNuZzQ5YVRzcmh0?=
 =?utf-8?B?NHRoOHdxUC8xVGNtSHprUnRBdlY0d0J4RElwUUxUdm9wSmNRczNGTXVoZ2NP?=
 =?utf-8?B?ZTArSGlLdmF1N2svcTBpMmc3MUc4a0hGM21UUm1Wb1A4NlJqdXZRRFNDOUJY?=
 =?utf-8?B?MkNQamNEVmdrUll0RU5EZEIxYUM4ZlFyVTE4SU5uUnRzWUNWbFhzR0JsbVIx?=
 =?utf-8?B?Qlpic1RVTmhJZ0lRMWR2NVBUd04wV3ZML1hiSEVvWlR2dTdFQ1h5SS80N3JF?=
 =?utf-8?B?NUhDVG0vQ3p3QmhMWjI3emMyMDVtVkhGT1ZHSTFFTkJud0JNbXlJeHRhS3ZG?=
 =?utf-8?B?S3BHSjhXVU80S29oTDF2b2QxRmRqaHovZ1ZMN2Q0S0lYc2VHcEY4eHlSVmZC?=
 =?utf-8?B?QkhsUHd3SDNoYnd4RVdaSE5VVzc5VWlJUkdQcTJnT2lQZ2JhV2lwZVZrQzdq?=
 =?utf-8?B?a1FqMnZkNXp6WDNnNk42T1RXeE9KOGVTUXNBbHZKNk9vREtIcjJubHhWZXFz?=
 =?utf-8?B?cU1PSGs4RXRkamZWbU5mRWN6ZHZEZVNyME5WNlZWbEpaN0pHQTBaQ0NOQXh5?=
 =?utf-8?B?RjU5WmlsMVdHQmc4Q3hSWktEVzFjbk5XdHlyMjNQR2RMMGlFa1FQTjdrMysz?=
 =?utf-8?B?b0xaclNsUzk2cFVxUmpydFU3R0RyLzNkc0Rxb1JDTzVydVhEMU1CNVRwRk15?=
 =?utf-8?B?UVllWExaZjBiZDdYVTBDYUYwUkdjcElHUC9vTUhkWHJKc3NFTmhQK3VMam9Z?=
 =?utf-8?B?SHYrdHdVYW5nZ0RDTWFyS3FPOU9jUytaNmRNWVhESG5WS2syNzhhUm1DY1lV?=
 =?utf-8?B?VC9HemhMb1JWNldyL1U0aWdtWFRpUjVqSHlWOHZlM3Zkc1h0L1dTOGFyTzBF?=
 =?utf-8?B?eWltcFlMUHY2Zmh3d2VQYVJuQktkT29hZEFQUzVzK3JQRGVUVldmNktrVUtx?=
 =?utf-8?B?OFNIbEgxa2ppdmthQ1JUU2dpSkRZMVBTT1dYbXdpR3ZON3Q0NzllVnNkNDlB?=
 =?utf-8?B?emZqTnpYOVFYQ1FCMmJzUkdBamZvRGZxUmp3R1E1THJJZEJCVXJJcStSdzdJ?=
 =?utf-8?B?RFJYOSswYnFXa3F4RTFmTWVUWi9iYnJUbVJIS09XWVZ5R1p1cFhkK2pyeG1y?=
 =?utf-8?B?c3lYNXhlY0VScTJSVmdML1M1a0VNbzlCVFBmcGlscW5YbDd4RVduQVdScmFD?=
 =?utf-8?B?UkVzUDZOL3ZjYVJpUjZoSjlvL2U5ZHMvZ1dZdjdPTHArcEFBNUtyb3VuUEli?=
 =?utf-8?B?ek1yZXBlbVFWUW81QVlteWtHZnNzejVUdTNIYW5LeVZ0VVFnNXArblBXTW5m?=
 =?utf-8?B?SC9XQWNzRVJkd0hHbkZ2M2d5cFk0dE5tTmtMRDBTVythZFBVT3lCVWpuMklU?=
 =?utf-8?B?WSt2YzVwMTZmZTlLaktOKzdQS0RDSGd1YS9EeXdSWFRMUzJXOVY0Y2wreG4v?=
 =?utf-8?B?L0RodkQramFyR3VYWjRxNHFjVkNXM3pPdWlNd2R6MGM5Z29hRmxXZnlKV0hC?=
 =?utf-8?B?QkttM2VmK2F3OHZDOEtsYjBnUmRZc3BlRC91anI2Ukx1R3dmczFuQzNvK0pv?=
 =?utf-8?B?M2lQZVB5aTlaTVM1OGRWemtZNUdpTnZUYzlNb0QrQUlBbFlnVnc1TVJKVXNB?=
 =?utf-8?Q?wSHs//s+c3pyDzK7sVl1QPg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8110f224-45fa-4387-a8f5-08dd5bed2537
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:53:44.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsVNvPLYaCd/OYk3WvGYiQtf2+EmNBMpdiJWbd6avXc67ylMPEJ3ofN4KNUW5Rx31bX3uMNEedy1Ix2Kr5dpj3ZyoTSOoS72uQEhCE4NXK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8821

On 2025-03-04 20:55, Huang Shijie wrote:
> When tracepoint_debug is set, we may get the output in kernel log:
>       [  380.013843] Probe 0 : 00000000f0d68cda
> 
> It is not readable, so change to print the function symbol.
> After this patch, the output may becomes:
>       [   54.930567] Probe 0 : perf_trace_sched_wakeup_template

What would it print if the address is corrupted ?

Perhaps we could do like the backtrace code and print e.g.

[<00000000f0d68cda>] perf_trace_sched_wakeup_template+0xNN/0xMM

?

I don't care about the actual layout, but removing the address
from the formatted output appears to be removing useful data
in debug situations.

Thanks,

Mathieu

> 
> Reviewed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>   kernel/tracepoint.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 1848ce7e2976..82bef4b9400a 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -127,7 +127,7 @@ static void debug_print_probes(struct tracepoint_func *funcs)
>   		return;
>   
>   	for (i = 0; funcs[i].func; i++)
> -		printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
> +		printk(KERN_DEBUG "Probe %d : %ps\n", i, funcs[i].func);
>   }
>   
>   static struct tracepoint_func *


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
