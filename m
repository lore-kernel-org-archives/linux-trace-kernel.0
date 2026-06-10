Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021083.outbound.protection.outlook.com [40.107.192.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288A37104C;
	Wed, 10 Jun 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121932; cv=fail; b=PPu/AllvaN62j1lji4Sniz0THyipmDCLjL60+688bcbGGFI68UyNPvUUY3S2evFadLKFoNFH5Z+GWMv3QmKITbwK1fVps0iFiSoQ53I6WGQuB1EUlMnNMmmjTHhDIXz5hvDS1y/qJSOBG1JdS6v99nAxTKEc6/JyPiLtK0ARLIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121932; c=relaxed/simple;
	bh=ecHsqBTdU/qwHqeUG4Hn+qPVh4Te9tc8mtBSxx+e4nw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bbCu/zePs1KrMRW6V3yPVXcRPilgW8JuHKGnTFZgpOVXZFWH6GT+Ue/Oy4PxTXkFjPbMgqUGJSPnKtVzX4p3oJrBRL3ST6HNvkuBmOwB8EEFRKT9DWMhHer4nIRYRv9Ef1nOXXgWo83AxTwq2ktLKIRzAGWQMvJHrji7TWBAzng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HQqz4Hd6; arc=fail smtp.client-ip=40.107.192.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HQqz4Hd6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnbsfFtdkY8n3h3V8HLfuk7HFY558Un+2Vg/ECoJs/DAF4N4VkeANl+V+P4AQS9t8wKhEJ51K2fEvYFbq4AoA38dFcO1TT0Wqraq91C+qX0nGP1xgrQx7QtN/HTk0XCu8+HrKzW0CEMGy4BmuYMolljlbe0UCalr6XTXk+jm+mDoYDJ95mGSlwLX6NjXYRcFX2YdqLjDliZxwEQ0w5Y4jnLUJ8T94Od+gySC2xTPr9EimZegPujwSZ94VKqYwyTnzOS42ayptnKYm71Vai7JlKCNiZLKXl8x+6iVR0JCQKJfqexjqZpviSVSUjIyOMWEwms1upu0l28t7MZQ2qh93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK7B32pnsKBR0z1KuxrmL9btWv6IpEJv9GxJxmIIfOY=;
 b=szQF4gM24LS0sVOnl21TtnJG+wjr8+a8kmDJa7xrT6m6QM0jKToHHNTVE6AZyuDKBvbeM5Xp8rAtN6Phqtx0I7ujMHWrNq7G2jEkSaAJRhHYtHIuOqKVdlVwFGJX42B+9bD+UyFmZYXpgmggOstRm1AxvU5QCYtlvqmoSgpNGctU6D1YXsJt+juxwrqYbAy7Ri4EcV+79eTvennelKGP+BkhK5Kf1ZDylVM+KJLWxUkKBciVvdDEFp/Uq44d82YfVjTxYECDXdD8+90sDMmGzVGLIbLXQzW6Sp1V9LUQf9w6U20ejjUlqgMqt9eNDxqLVCt/w5T8S1uSb8GjB7X31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK7B32pnsKBR0z1KuxrmL9btWv6IpEJv9GxJxmIIfOY=;
 b=HQqz4Hd6Ifg6g4HVuVZiT8AQoDQHk/34kChnMIswV620DEk3VLiihCzQ1w0HTwI+aCEKKYQB/DUmzvJSS+8+zQaxjUn/Xk5AMMMtBMzalLYnBAQT779vDogZfNhcUiciFcY+93oiYx8a/X7fpZP6VZg2WMMnXor7Yov6KaQX+CH06VRLWK7yF7GwdrB40c9eFCIEjU2Jk1tbRtGC2aQ9uZ+XZE8YP0tfxZDHJCCgrTIbyp7eYEoxK8aKDWa02p+5wUMV8BJ4A5mws9r8KVJL7GuOVR0ly60rTCS1UkXObc3UTZEhcI8xKPs7ix2+2PbyaxEdooyq+16R3pqMMS9t/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB10412.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:89::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 20:05:20 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 20:05:20 +0000
Message-ID: <0ea2ae74-7452-4ba5-9549-59197c766c25@efficios.com>
Date: Wed, 10 Jun 2026 16:05:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
To: Steven Rostedt <rostedt@goodmis.org>,
 David Laight <david.laight.linux@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
 <20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
 <20260610120659.7c61cfa6@pumpkin>
 <20260610155139.01b6def4@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260610155139.01b6def4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::33) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB10412:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f6e783-eb9b-4e56-492b-08dec72b991f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|3023799007|56012099006|5023799004|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tGSm5fwIEFyX6VuQf9jhdX6D48kCvorNWVg/ZQV9eBY/dhdKkMgtjrfNnm/cbQavBgNdD58N04g0RB6qc9b8+17unaYtX7YmhhkcgqEGkVpvnDF3YnwVgZ5+5I4NMPwX+xtkJDInfUErN0efxmKEnr5DNcUsLWQ15PvoK0V3TZYQ/SghPVfN+H5f3wETHK5ls7+GSEhb2XrOAiv5BKr+wXZAtN3yDzTJVrqkFS7J0J/i3rhos+jTrk7aEb1BQLKKcAk39KJ9+0WbrKXvrHZOgWVCgE02fZHOyTi2Gyv5aUlkCNg1NngfMo4lq2NkRZbjtmCVOUBtvh59i71y12cazOREvzl1pKV8MOiHgK4tm4eqG7dCrTi/9KmRhoBD8/3aV5yC/DkYY0vhqnpoznJKSW9//pydyXle6WJzbLhInyXiJpUO4TEFky4tt71CpvtDxcXzsh1cxxOpC6wNMq2equX2YTa94XfTNhGDEQy6EsgTofIcVdLlfh8I1m2Jg93jTQsDebelBG7WwX3XrNQL7lhT5Cm9N9WKgia/JbKT7XTbGMPSFalU7bvH54GyydHGmiLqvRlHOj4r6F1R5GDPenyCRyD44eDeKcm0CRTNz5nCXJ1qrvjYlQShPT4fcwOh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZldGTjhzOEJPaHRJUGVpQkUyZXRxRmgzc2RBVDVLZWxPcVBUd3RpRnJkSXZs?=
 =?utf-8?B?eDlPMmQrcWxTRXBXYW5lWnljZTVIenZyVjkrUC9KOU5xMTl2amNleitRYXU1?=
 =?utf-8?B?cXVaVzRySmNISjM1RnR2eTgxTXNtWVdUbU5tTDdwcmJOOHFCZG9SQ00wSWRB?=
 =?utf-8?B?VGhvejh1WXdHZy9zSk55QnZDNzB4SHdlT2E5dWRVWkNVdVZIaGMxaFdld2JW?=
 =?utf-8?B?WlByK1VQemNkeXhvTWdoaHZyNUVTYVRhVGlnMGxCWEczWjc0SFlYakcwVWZY?=
 =?utf-8?B?cmIzTjFQOUVPdFp6aVcrYndqUFhIcXBvNGR3SnFJR21MV2hQd08xT3dxTE16?=
 =?utf-8?B?bnJkTHlmS1BNRmI3TGtqYXlaZGRRb1FGcGlRbFNLNkpxM3U2MlJIVHRDYXFw?=
 =?utf-8?B?NWhHZFhKREtyVGpEUjJnZ0V2MmxRY1hzRC9YNFdKWnFGVkdNVUlyS000aHpl?=
 =?utf-8?B?M1NweGxBNVhiRlY2UVBzUk9yUnAwRksvUWk4NGhORVM4b2xEYXNSc3o5bFJL?=
 =?utf-8?B?clhXQTlXTFRuNWpQRDAxdTNKUXByOHRKTlBFYlAxMHhCV0N3NjBkTDI5ZmJh?=
 =?utf-8?B?L3REbFZ1WVI2RU9XRWJQL1hPaVZaYndWdC9FYjUyNndsTzB0MkNHV25KWDMy?=
 =?utf-8?B?TmRBMGcvWHduUFMxYmVmdXAzbHFhVkdzdk9HTWRYQkZJbUpiRUcreVpxRi9u?=
 =?utf-8?B?QTQ0L0YrRWJMQndQa1NnSzAxaGtrYTYxbXlYbGtZT1BaSHZXdVR2b1pyVkxo?=
 =?utf-8?B?MHhySVZhMVF6Mnp6aGNTaGJuYm9WMG5IMWVTSHpKU2JuTDVTZEVlSUZ5b2lu?=
 =?utf-8?B?QzdYcllKbzloci96LzF1eE9jVWhyU3FmS0h2YTRJSUV4N095cjJhZnh0TlZu?=
 =?utf-8?B?dkNnaUMzQUtFbk5mWnBjS1pNMUNuc2pEa1pVcTVJYVplUXU5RDVGY1dDOVJq?=
 =?utf-8?B?K3BkVU1MTXozbkZrK2taYmYwKzFvdmpseExXbmswYkk4bCtNOXlhN016RmV6?=
 =?utf-8?B?b015QjBiOWtpRGZZZ1dXZ0J1YVpXN0F6WlNOL0lCZVROYVdhQ0Y1NWpTWm9s?=
 =?utf-8?B?MWNINUsrUVZEOHp3cmtlK2ljS1RXeEgyS1JpbTR5cmJZaDhHSkh2ZkhXWTIv?=
 =?utf-8?B?Uk94ZnZwbUxJUnVVK0hFZ0hYSk5BSFFNUWxnd2JPcUtSb2FTOWFBSXFVaS9n?=
 =?utf-8?B?Zko4TkRmcW4ycnFTWG5JZmhvcUk1bndvTnRuK2VPZldEYmpXRTVwUitVK004?=
 =?utf-8?B?NmhzL2taR1BKL3RCYUJuNXhlRlVYOE1LTzJOek5vRHp6aDNjMFNxQjFsWmJj?=
 =?utf-8?B?RTNtNWtsVGRVV1kxM0p4eEVEVkhMaWVTUENleTB4VlZyR3pKRm9CaEVBN21Q?=
 =?utf-8?B?d0pkZnJNektITlkrSTVmNFFJNjRkYmlRUlZqMHlCLzVEazZUSEZxWlRXZHhR?=
 =?utf-8?B?SEdaelorUVBxcHltTEp1YzFtdnJ0Q2tSanN0c3RsTTdIYVFFWE9VUG9jVHFi?=
 =?utf-8?B?aWM4aXhTT0R6bWVGVlBsSmU2NlFXb0k3NVc3SDJ1M05PdlM3Nk41MVJUeTk5?=
 =?utf-8?B?djRHTHdCSWg3dXFMcHpnOEk0UWUvN1dlVDl4ZkZHTUhRWGVTcGtZWjliaUow?=
 =?utf-8?B?RE9RYmdiZVh0VTFWbEt4Wnh2SWVGZlJaMGd4aTdXYllGMmFiSjNFWEhON255?=
 =?utf-8?B?VmlrRTl5UThIUDJJenV3dXU2bWpkV09mbDhkdm1ZeHFCVjZFRkN6c1RvY0VR?=
 =?utf-8?B?YVp4QUpHNER6YURzVkVBd2ZSWGJaNnpBbFpjSnpKajBqZTNJZlh4aEJ4eklR?=
 =?utf-8?B?dHpBMVlNeTR0RllLTU00SUh1VXdwR3dZS2FYQzluOWVEd1laZVFjMlpZYTls?=
 =?utf-8?B?eG1ublFsU1R5eEN2YXpQaHRtR0REdkkzK3kzYTFscjRqNjVlOVhhczRUV0Nx?=
 =?utf-8?B?OGExeUxRRERrcUM5eDJQenpPRis3clA4dnZYYTVrd2Jqcm4xR3kyWTA3VlJa?=
 =?utf-8?B?V1N1eDM1WlgyY0p3RlAreTNpbTdDV054UzZYdDFud0YyWHNEakNwL3ExUmpM?=
 =?utf-8?B?d0FxdmJKTkk2KzhKMHhacjB6ODJEcXNiK3VFYlMvNDZqcHpacFhtRWhsWWVT?=
 =?utf-8?B?eVRWTmpJcGw3eXN2Sy91T3lsU0c5cFhOeWIwVXpDT0FTZDFxNnovam8ybmJE?=
 =?utf-8?B?d0w4dHcwc251dVV5NHZqdldLWmhhOFFieFpsQUpCcDY2MU1aR2dXVDloY0x6?=
 =?utf-8?B?TDczNGQ2bGpRdVpkc3E3aldPVFpTZ3Z5WmlYTDVJaUtCYjRxQ3pYaVhpTmg0?=
 =?utf-8?B?eVdqL2cvdTRjV1huM2RwbmxZRmZhOU5JdDlEakhZYW1zZkYrTGswM1RrdExu?=
 =?utf-8?Q?SOe3eVCItFhtwGZ9szPkEkUEOXtWn+sQoos3Q?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f6e783-eb9b-4e56-492b-08dec72b991f
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 20:05:20.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCtj1d9MWFyKVPycPkxwxf1NPYAf6xPhXsGpJXnuifcKuDRjwyauLmLYSlOtS9uI0Bsq6CdiCNEFuUkvaeWzIezi8xybutHKIgKUNFxMA58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10412

On 2026-06-10 15:51, Steven Rostedt wrote:
> On Wed, 10 Jun 2026 12:06:59 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
>> So you only want __packed on structures that might be misaligned and those
>> that contain misaligned members.
>>
>> If the structure is only guaranteed to be 32bit aligned then use __packed
>> __aligned(4) so that two 32bit accesses get used instead of 8 8bit ones.
>>
>> -- David
>>
>>>
>>> Thank you,
>>>    
>>>> Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
>>>> ---
>>>>   kernel/trace/fprobe.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
>>>> index cc49ebd2a773..21751dcdb7b9 100644
>>>> --- a/kernel/trace/fprobe.c
>>>> +++ b/kernel/trace/fprobe.c
>>>> @@ -181,7 +181,7 @@ static inline void read_fprobe_header(unsigned long *stack,
>>>>   struct __fprobe_header {
>>>>   	struct fprobe *fp;
>>>>   	unsigned long size_words;
>>>> -} __packed;
>>>> +};
>>>>   
> 
> Does "__packed" really do anything between a pointer and a long?

If that structure is allocated at a non-void-ptr-aligned address, the
packed attribute will ensure that the compiler don't emit instructions
that require aligned loads/stores when accessing those fields.

It does not change the layout of the structure per se in this specific
case, but it informs the compiler about the lack of guarantees about
alignment for the entire structure.

x86 32/64 cannot care less about this, but it's relevant on other
architectures.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
