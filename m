Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021076.outbound.protection.outlook.com [40.107.192.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78C3F1677;
	Wed, 18 Mar 2026 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849099; cv=fail; b=ihQYKInhXFfzsKG8VfI44MzUEc906WFnUWkc/ZsfvwpXWawFOpf42t7W6pmdOhFq5S2yWGu9O113CpTxcPuI7/Vx5mUW/xU862ozPWSAlzav1DEcbTqZ5Q0lCOJTu0ku6Bv7zQ+7Q+o71vx/lVbHtQKUxb+rEcspciyq/u3TNGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849099; c=relaxed/simple;
	bh=l5uqGdvlde05drtyB9IaRe0f2j168XTiYadDZQOx6RA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EStT/rmVotHvGS2n9KmHjo4KPx8ShSklJMwsqpmAFV/dn+Uma+fSEg4sjV+whMxVNcz5bi7u7xl10UgbTp1JKCPPo8Jsjij0IDRYs1kp09nGBQteQg65jEYkH3m1Qizs4JDSXGYTG48zuDiNZT+QbdLxym6SNGCIDN/fPtkUCnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=I61H9EdN; arc=fail smtp.client-ip=40.107.192.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="I61H9EdN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3Lj9+zdDnw1bGAtHo9XGY3whwnjW8GEkiDLLdZmj28VEuJAGrLwsz2ptuiAq0tnCenPIBWNS+vUuXwQ3PtuBPKYyPtXzUASbBB29LMwQe8NKAQ5kmPffZoP0qbNgFrDynWp2hNL8dmjX71UAVff0+mpXP3qPHYtKLSUqV9GjSkQiTzA5dDZeGrSpEZ4Zy3XOSy/sD6a/sk3HvYEtncLmZAZh7RfEXkFCscYGfcaeY5PlubY7RT53CaPDlLtYqButpJ+5+Z01imQYTVw1/GEU6uaWtfiQL3KayFJjI80J+SNafthEPnTGWqF8ylOpxYBMXdAOvvEKkt4pJRUiAVJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hinbxIkZFxGaeHtrClDd8iC16ICFH0BY/K8l4UST/cY=;
 b=S3KhqIW+SztLpofM3G67BO0w3K2mzQwjqHzGKyUfJPqVXJ45T89CygJDBb8+G2vaSW77dMKrqMKz3IKvXyBna5RukA4NB+B8OVlOZyZagkSeIFKNEzdIQ9ciMBrFyfJJ1t9i32qF3CVsvyD5uNaF5bDNE5NeJW3i6MFHmAiyJvf0LVo8PzuG/ehYBUi3r3DDr7qI1TTVcf1ZVFKYCYt1Jkx6fFNiL35PbbjwLpPhhj2etvvMTXWrC4B/VqiMLPzPZxTOL1Qcckucf3/ir48RRUGP1QzNQBojeYop1GJsShpd81sGNYw/KnwjIX5IIDlG3F+ug1mhEeEWN4LIDkEBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hinbxIkZFxGaeHtrClDd8iC16ICFH0BY/K8l4UST/cY=;
 b=I61H9EdNZv+t+YUHHJtngZc3+C1ARRJ3gUd1zWFmyfEg/QNzxcXTdhzrYBERaj4600D7nyjyZeqgCfdCtJzVipH9Xz8neRhJKx5O677a1UJXrw7vrCKPscG0EMSh8M0BpQcA9dFwx4uhiRWeovJ8QPpdNrxrkv92J89tsU3iHrINnDB2XHT3zquL2/6kufLPWFwSNFq5JepdTqo4jPhzHQZSxzlXogAqpExjDjsixjD9lC3OCnT1rlayYSh8O0028O2b5aogFVoWXA9u2McFX6yAkQB0eobEfvlkNWJlwk8zXoXta4xxOXYPV7nQxRVr+j4Q/Pa9AczwEbbb4hmvTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5368.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:54::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:51:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 15:51:31 +0000
Message-ID: <831523cf-110c-419d-9b22-e54f93a3bdb5@efficios.com>
Date: Wed, 18 Mar 2026 11:51:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] ring-buffer: Flush and stop persistent ring buffer
 on panic
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
 <177319274904.130641.3303707869402603363.stgit@mhiramat.tok.corp.google.com>
 <20260318231959.717f07ec491a731941aee1d9@kernel.org>
 <c91f37bf-97e9-4752-99a9-3d534ce9d2f0@efficios.com>
 <20260319002918.5768a8ee053dd35373e215f2@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260319002918.5768a8ee053dd35373e215f2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0ad2c1-cf26-435e-c578-08de850638f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e+FuiSrfotjJ16dJFx7DhO9/73l6sZdoncUtK+PIpzHWbX/fK9mwFcBSY20sUh0q9yobUL7DHlWZYwL42ImBbghpFX+efCicfqmXMNsM0lP6PWxsd9j3pgcJ7adRHgW5y/hWxOsOH7pB7Ta3IvHJPBJJ/LrgoVqq6wyJnaoB/kr2N5hL2Yoolls784HBq4xXmBwNZPytGQjErKnxhiuvk9e2mgIN0CR01aYpf8Ag8TN9CqxvFMYw87661g5EYPwmojrk4NZnPE9G6PKUy3cLRRII45zuRAd6V3qSORHONnE/ecdk3ptG9MQABoOwltFqxbX8wxx2EilbUGDELg7un2xQo9hf9ScJtPxHODj0STQBKjFmK+qxFdZZRdO3TWRBHsSlf2TbMy9bi5EaiqAqnDMpYIDhobjRtSpUJk65c1djPrDvYBQW/6nBQutMW4p5JVktnoV1DTNG11NPK5C65K2WyuzKi927rR7TAFB4n74hplKy0swNOyr4hR+WTkUZQLRQRmkMqstbTedDMrh64rgLntQ5Inp3L7Z2w4h+cqME5BAOgzLF6i4BssEBWWDs7XrCOn4zFB5LZN2thAGfBAlgH8dA8jdCoPqCI0cQUuGd1KZpCwjh2yKYy1SA1DHcRH3yeba+lYFAuBB+6J4tppbG4EnlCiBFA6bnJimvGJ6LlTr20XS8wXucxTVpXUl1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2RrYWxCQzVwQTUxRnV1cGZLZUFXN2thOStQWkJlbDMvQVJEbmI1ZVFKcFI1?=
 =?utf-8?B?MWFDV2lTZGlGckkrelQvU2s3N0N3c1hvaXpnVzJHTmE2am1rTGd2YVV1V0di?=
 =?utf-8?B?TDBpZ096TldYdHFzbjdhSEtJTWNRLzE0cHM5QUtxZHBxMklOa0FNTVpPYVFx?=
 =?utf-8?B?RWNuaE45d1RoQW9CdERSRVRIajNJdld1NTBXb0RYYWhod3FaQmdWL1JJMytG?=
 =?utf-8?B?R0lIN1lqTFUzNTVpWmRUY3dWdlFkVWhaR284QTQ4NU0yQ2tqUzFDRkhudklP?=
 =?utf-8?B?N0puQnpzeFlWRlZYeDZXTzBtbmY1R1k0WTVkbVFiNzVWR1h1SjNoeFhiSHl5?=
 =?utf-8?B?d1RjVVdMMlR1NzF2Mk1ubjZZUTR4bHFaNFZOUExJZ2dmdGkzblFVU3ppR0py?=
 =?utf-8?B?Mm9GV0ZVUVg4Tm56M1dHQ3ErVTVtV0lGUWZVSEFZK0xaRHpZcjlFTHJQMzVq?=
 =?utf-8?B?UlNyTzJXMW15a1p1VSt3SXRMUVZHREpwSUdCdGJXMmkvWjd0bTFOZkNjdWxH?=
 =?utf-8?B?akFKU1JkUUJhZCtFcWtqYk5RUFJlZVpHMk5ndG5lNHBaVlBkZXg2QzdodW05?=
 =?utf-8?B?MmhwOVNyWlcwbWVQWkFtdC9Ya3dGM05JZXhNamJWNnZrUzdkOXJUZHBPS1BN?=
 =?utf-8?B?OHVLZmxMYmZGa09VNUdJUnFaL1hMbmNVRk96emIxOC9xRHRyeXJJN3FZejJF?=
 =?utf-8?B?TDFza040d2N2VWtxbjNTRmY4cEgvVnJya1BZV1pyeHBySTI5RXNBZ1JyV3RD?=
 =?utf-8?B?ZDhKdWdCQ0w0MG90Z0k0bEUyTUdFTktSazNZK0lHRHQ3RTBCMERwaWNYdU1F?=
 =?utf-8?B?bHZUbDJjVGRHdllPYzNQc1JmNjdEbnVBcXpNRTdOSDNVc29zcENjSmdXdVV4?=
 =?utf-8?B?M0lweXkrcEVUdGQ5aW1vb2QzUy9MVHNkaHZnWkZTWlhkYTlOSERLVDlnNklp?=
 =?utf-8?B?NVNSeWxIcXJTWE1XWldmcTZsNnMzZnpvdjk3K3dySGIxUllxYlJJYUtJaHFa?=
 =?utf-8?B?b0hoM1RPNHZ5MXlwKzdxY2dQQmZxV0hCbXA2RkI3U285c3E5T25nL2d4SnBq?=
 =?utf-8?B?T05DZjZQMlpQZE1nMVZJbUxPTWtOZjArRW0zS1E5QU1BaEVVdkxBMnY5VHdU?=
 =?utf-8?B?a0pqNThiQ1lNVFUxT01BNkpvMmtWU3lEai8vL2V4ajdpaXF6YktwbVkrU3Ra?=
 =?utf-8?B?ZHAydDF1N2oyQ0xKZmZiYTlGMjArTUU1a0oxZFZkOGJ1NE82Vmd6NTB1SFdW?=
 =?utf-8?B?S2xiVTN1dTA4Q0xqZWJyU3cwbXVuanJqL3FZRE9LN3VZUGRWSE1GSndxdVNq?=
 =?utf-8?B?ZHdTV0ZKOWRxWGVqbGtURGNkL0g4NlY3RVRXR0hISWtYTGJya1BQVndGRTNm?=
 =?utf-8?B?NTBvdzJKSTZYb3JnS3FvZ1R1MUd5SmwzYXBvenprL0IzSkxlS0NjSGhJeG41?=
 =?utf-8?B?MlZGYmY3NUJPQ0VSMXQ1UGNTWFF5Yjl4SlU0elFUVXl3THAxNEpSUEJkTWlv?=
 =?utf-8?B?Q1prWWdEQlZMcjJSRFdMYlk4eE5VSGNNUC9XVHA1OUpIeTVEcGx3dFk0UGhn?=
 =?utf-8?B?RVhqNDJkbC9wZktWN3lvYmtlMHZveHhiaklnejFUM3dNRm1tblFpMmdlNGhY?=
 =?utf-8?B?aUpxVHMvVmkzeFFTYUZyNzU1bHRYbWw2eXo4Y2U0clhPSXUrZUdvaTkzdUVP?=
 =?utf-8?B?OE5GUENVdFN0ekZDODlXeHRaZTRWZFQ0U1BscUJ2S0VIZ0tiNTB0SnBzNjVH?=
 =?utf-8?B?ZVVBbExjVENYeFBTMytYdWxzNktZSFJ4NjMzbkx0T1hFZDR4U2oxaTFyOWZJ?=
 =?utf-8?B?cld3NCtMd1FvbGw0ZnFCanpHTnRwWDU3TlEyVjB5ckNUZkNFTWwzU0kyRDN2?=
 =?utf-8?B?cE9vY09EN2dWc3lqZTQ1dDB6RkJyNU1uL1ZpOXo0YjZMRFZ0Z1lhUytPUEhz?=
 =?utf-8?B?ZmJVZ2V3Y2hOODljNjBWeTNxUm9JVFVkZzUxd0FmeVpLSjBtcWRxcWRBbUh4?=
 =?utf-8?B?TlFNazBYR1Q5UmptK0E3WmUvRjZySDB5bFJuVVI4NEo0RDM2NVRJNXJiY3BG?=
 =?utf-8?B?Ym54TUpBOUJXMVliMENyalFoL2N3R0ZKVG1BZnlCZU1MK0toQVFuSHZ4TXdt?=
 =?utf-8?B?NnQzUDByZU1saWRVSk1nWlF1UkRmRWsyaVJnTC9yZFpYb3hwalhsTEhUaUhP?=
 =?utf-8?B?aFlmYnF3U0d6WXFtNnUrcUZ5NFYwSTNYc0RGRTVyRis1WUNiVUZkdk93V1J6?=
 =?utf-8?B?MldWVEtPcTg5anNicmRCajl3VWl6NVRGOXNXbWZqRVhFRHRnc2k5NzgxREdE?=
 =?utf-8?B?VTF1QnFxQW1ITHBaa0lXOXA2NzRSRlpyR2UyazRuS1liR1lIN0YzVGFvV2Nm?=
 =?utf-8?Q?0hrisG/VRDJlPXkir+fQ/bOYlzexMXeT4UVza?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0ad2c1-cf26-435e-c578-08de850638f2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:51:30.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL4EIuzaOpoT7ZG6TGA+EVY3iDOwDFmf/8obXfrCi/iwfrjZt8zjFUKB3RTpEmBNy4yfOdjsPNH5jOgN/LVZmbMfCvpI5XN/aJa/ccZ6cY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5368

On 2026-03-18 11:29, Masami Hiramatsu (Google) wrote:
>>
>> - AFAIU, you are not trying to evince cache lines after creation
>>     of a new virtual mapping (which is the documented intent of
>>     flush_cache_vmap).
> 
> Ah, OK. That's a good point!
> (anyway I will replace it with do { } while (0) in the next version.)
> 
>>     
>> - AFAIU flush_cache_vmap maps to no-code on arm64 (asm-generic), what am
>>     I missing ? It makes sense to be a no-op because AFAIR arm64 does not
>>     have to deal with virtually aliasing caches.
> 
> Yeah, so my patch also introduces arm64 specific implementation.

Just make sure to call this something else than "flush_cache_vmap",
because you don't want to slow down vmap on arm64 which does not
require to evince and certainly not write back cache lines after
creation of a new virtual mapping.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
