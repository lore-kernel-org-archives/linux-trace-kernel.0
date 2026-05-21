Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022082.outbound.protection.outlook.com [40.107.193.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271C23E356;
	Thu, 21 May 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375597; cv=fail; b=mfar5jLFLVgYHHQnHlW4svmk+rF1SptnBC6/GiUE5DTrsdyABIRl4p/ChMkN1E6RxGenT5XlGmtOIDnYs4SMLzYQVSW3i/4hsqhH280sYWE9TJN5h1vO8vEX5OYwOCaFZDTr5lXrv48yJ8ByEKnud7A+B7aQyL/umrgRurBQ1qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375597; c=relaxed/simple;
	bh=ugA01srX1MzFtLMxe89Q6eeMohl7BXxWYf3QSdlIRZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IA8jzlHWjWNhmRihqC7R5sRaLrNDdBMXHIn6DrpV1qgE2hvFIN2+BZK/hBl+H17XY4qVrKrIzzkJPfdeMaySaEJdaVckc3KCLK7zO4pRCHmvltfsB8FvlyWH1Z9h4zWcQ2vg+mIu7sCSJoHR9rFD57C0Wv5DMrO3JvLVZ4d77Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SbQ1bvqx; arc=fail smtp.client-ip=40.107.193.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SbQ1bvqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgDkEAUSZUorZxuOHhlN0koh05UbtnDklZAKFK7IKJhr0Hsz5lmyKfShQfbeJDx5CF1GrKmBNjvx0xO53RCqFZEkVyqULlc+ZUVBeKCg0gQ2hA2CQEYAcbe2TNQrlJCkxjqgmfSowVqSkRgaW1EKvg+P/Qk7YoTsWKWigqwf6hb6/aUc66Ihcwbas0JFrCtps6aMZzHkWl+0NQKh9PDbLTBLvX0RAdUPR290/8Pyr7l11AxmcMKZLlGyVGDm3fMUXAQfSR9bvfFM2ZJjwKoXLTWIurUhF57TW4pszoMFLkU94gclpqK+zCnTJqrlNFVjXmOd0zdjxe/gNUu/iZ3Jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFvBz9ruS1P+pkYTArRsXhcplWWLaAPYa2sA/R9uNqQ=;
 b=LqmRrB9J/da9rL9sqLm+nWrpJdlj38szlATh21kpaOmaVzoWZrPo5DfstGFgqE19ifLfLaZjMiCg0msp9fR3/Jl7tssUU9duxqjQzb8tFqhpa1IRcbCc7TkLCSdz+TlDbwY8LseoQqhjLhCOhZ7U2SgQhLmsSRDdgNpMuPQgm6730T//UcZCkPCx1sscSg1aQTR6087k2ySfce1TcrXynp6l2Qm9gVougTxI+K7yeZl9qYwDSvAdTcnKUbGVx83esggPYoj4XGFzAg9q0lwY4VKo4QHE6htZ2WiJW2I1TVIQNsBbYr3yq71EH9E9kpCQY+3LuhDPmZxVpHvAlhVI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFvBz9ruS1P+pkYTArRsXhcplWWLaAPYa2sA/R9uNqQ=;
 b=SbQ1bvqxGN87giFKtPmbI474qRA3WwP8jFMtkauzTJvcJG8Ij4wDuB5sy9iHSv2aJfaOM+ojmYW+3omuRalJALxaUiVUvGzjH0KJwG42EINR8NJb5uFhxZSbxZ1V+lyiYEa3Y1nFHfHWLs3XIiC/h4+NjLYzcO9c60wkRQag5XszgO0THPz+zG6GA1HW7pZutU4eLthG2QFQ14PAvJtPpkn5s2wZOYxxHVOIOvUJ6atFleW2Fa8vy/qaCx6cY5hgM/63qwfOWOj/IGs95e78yi8mpTI408J9YmefLytGVDiWc65GubxXBbiwzlbg7K4FMxnSqynZCMab3OcOH2S5Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB9606.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.7; Thu, 21 May 2026
 14:59:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.21.0071.005; Thu, 21 May 2026
 14:59:51 +0000
Message-ID: <7f96531f-0f7a-4ec5-bbf3-f7dca7c97c2a@efficios.com>
Date: Thu, 21 May 2026 10:59:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] random: tracing: Expose last boot ID on
 persistent instance
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: ea82019f-21b9-4a12-cbc3-08deb7499c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Fn1X/F9D+H4Y+vjw0Vhq1oEoDDH/ZA51pBHRbVG/l0hPZfnu92bfcsnyKR474fqcXDNHIo601A6GX4tU8BMicME46LV0k6aPXb9Bcx+sCGh2cejzRxaeAbUZM06/4bCNRXAXTL0q+RWh6XzUOFj1n/PEt/aGKCas/a4pgdebP4AIEOKn4uCMcq+lzFWfItMQRQkxJBQCefTzibcRaQN5zRIX4KnpTKGvgbOAn80PSmOCCdPlpIns/gVVNiAqHTy0FzJ6JgfWlUxS5vceC1E4ekNq47SCAoIxWnLPJuRI35BMVGYxgCGMAE0PceUGvfccOshUqyEV28HnOeYmbD2e2cBR/YGePXTHnQhOKjxBPsTxGh79xCk/9VjMzeKB8IUwf9zwE8M9wHvfWHQ2qwimvw5NJCzGFfCmGqFPIlR9Ojud3rCZky3ATZyHxwSPBtvZ0L4SfJfpm54PZNtqSIFaHQZJUxAbyg4Znc10m1PQg8aIJDKkfWMux7K6pqyLdIzQcZ3ZxOZq4lm1KQVFWaf+PCFApko4DqtZ/ZK3juJlR+OeP/cfXUQ9hjVfK66mEmI+SVg5HkXtu7SXmyuoawkHZgZPAsEKR846PIlhBpO7lfih6aoBVFherNBGCU585tlr2r2Z0qsG13WxnAJ64u8KBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVVVUW1RMnIxZStnQlY1S25PQlFtSE5zc3RjYjk0NGdTWnU3WnNpTGpEcERr?=
 =?utf-8?B?eVplOXAxZEorZ3NwVSs0eVk5QVoxSDFZTGNkTEJSTE52QmZDYi9qOWxLVWRT?=
 =?utf-8?B?ei9DWEZwQUFRckh3YU5NNCtPL01YSFdiY3cwKytOQ0ZIM0QrbkY4bHFpdHh1?=
 =?utf-8?B?bXBOMUdsUEdIRmJtdVlGR1pOTEFjaG9keFd6d0V3aVFGTmpWUjEvcEg5UUlo?=
 =?utf-8?B?NWk5aVVTVXpaa3RTUElJckwzcFRQVTdhVlJSUjE3T2ZXR3B4V2VDRGJkUitk?=
 =?utf-8?B?dmVFR0JSekJsNis0eVhpYnA1cGZIQzZqMGludlhTdkNHUUZtZE90a3hxdWtk?=
 =?utf-8?B?QlBGVWs3ODJ6WDNyTDJLYTJ5M1pUbnRDU29VYTdFNDFiNmx3VVNMaTB0UXUx?=
 =?utf-8?B?d25NSmNzLzd3bEc5bE9xTGtGS0VEc3JrTS9ZSXVpaU1IOHZxM2kwN0FtVWFF?=
 =?utf-8?B?elpqVDdsL3BrWExJaENNNXVJdVJwd2l0WWZhbXBsRmVkSkYwTDNVZlJUdjcr?=
 =?utf-8?B?dmRJT2VYTzluL0NTUDk4ZVoyYm9FVE5OWVRTODJkTlhOYUg1T05aWWRISVYz?=
 =?utf-8?B?Y3NNeE1TN25DRU9hU2lqaDNCRURXLys0Qkc0ditQQ1dUNHVYcVoxdEg3bVRh?=
 =?utf-8?B?K0c5VlBYaHh5dmphVHhNVTZqUDFZREFhbm02bHl2ejZ4NERVUCtuTkVUYTk0?=
 =?utf-8?B?RytnY3dVU2tYU0E1MHFKT1IwWTY5UEFLUkJlcmM2TXdORXpocElDdEU2MEN1?=
 =?utf-8?B?R1dnYjdBOHJlWk5mUm53Z1NGakVXcmpUUFBTbHpVTWNlUUhYYjAwZEZyek5J?=
 =?utf-8?B?VE1nRWQwUi96RGxHOUp1WkJLV2VuUVUrbzBBbGpLck1SNjc1MHVEaDR1Rzda?=
 =?utf-8?B?Tzl0L0F5V3J3YXNMTjMvQmhNcWZMb3EzV1o1aFA0aHFkTVRocWlsSjlUWHpa?=
 =?utf-8?B?Vm1CVmp3ME83MUFmVDd2a1EvTk5JME5jck94ZzU1dFk0eGVxb0l0b0ZyNkVU?=
 =?utf-8?B?RHMyR3JINjNreU9IdmY1cEZPUW94VHA5SE1raFRQT1hlOE8zZnM0aW9wWDQ4?=
 =?utf-8?B?TytLUHBGWStyeGd4NU1IcTBOZnhmRTNseDZIYUdocVJlSUU0V0ZjOWN2OEhi?=
 =?utf-8?B?TnMvMmZESHRnemUySWx1UnJuMDdpbGdMbXY2R2hKVHRhNlFFUEtvRmZqdjBi?=
 =?utf-8?B?MDJuczBRTi8xaTNUajNzajA1Uk5IQ3FLdGV3c0tuUmxKaHY2MTgvTWc2N2Z3?=
 =?utf-8?B?S2h4WSswdmlwVTdyVFJQN0xmUEV6TytnUkh4RWwremJXSnZtd0FaQlBaRTFR?=
 =?utf-8?B?eHFxNk5FVDUrQzRwS0JwYjNhMElqaGtaOXZydmlrZWdFTFBnVUE1MDNaaDV4?=
 =?utf-8?B?VlZ3bVFvTFg2eVRXdDVuMDRTbERUVzRjRWVXWDJDdzNIVzdnUjNtQm1jb1U4?=
 =?utf-8?B?MW9vRjFVM0Q3NnJpK3VyNlJiZkhxNG9YNGhKRjNKZHBvME1PenhRRUN6dU8v?=
 =?utf-8?B?c1Y1YU1wSytWcWU2dFNSejl5cGtqUEVHZ01GVzJxci9FVkh1aHNqMkxqdVQy?=
 =?utf-8?B?eW1VZTdzU3hIbEk4ZlZmeTJoMmNkUXN4UmlGbkVuWmUxSFZmY3V5UnNpdVVv?=
 =?utf-8?B?eXBoTWxlbjZDV1p5ZjRlNERZUFhKdExiRlhscmk4SEVTRmFGRGdpQXdlazQy?=
 =?utf-8?B?aWI1NWtPalcxU1htRHFBVHo3SHJQQnZsbVlMSmRrbUpaaXREWjJoTDJFa2VZ?=
 =?utf-8?B?VFJ4blJuaU5MaHRMNnZYTDAvdWZ4K0ZlQ0F1NmU2TW8wdk5qcGtiQ2QwTWd4?=
 =?utf-8?B?VlJNVm1PVU9la2lLMnhGYUZ5Q2RJcnJFeG1DY0dxY2RCNlhqTTZidW1nOEVn?=
 =?utf-8?B?cm9PL2ZXamx1MERtSm14OGhCQ2FYUUI0QVBlVk1Dd1lvOGFQM3Y0VW5FQm5P?=
 =?utf-8?B?SkdibUt5NHpGZlNGN0d5YUJlUUM1MmFyUkVDUkg4UGpmMXNZWXQwMndreEZC?=
 =?utf-8?B?NS9ycnc5bUV3RDdVQjNPSW5LUHg4RkluNDlNNFB3d1JFbk1ldGp3MnhHTUVM?=
 =?utf-8?B?T0Z5WFJpUERmbmJrYVR6R3pDSE8yZ3NNTFoxNlpUclJYNERsVXRKWVB2V1M2?=
 =?utf-8?B?RGxZR2Q5RWxBdGdkWWI5bHV1UXlmelVJM2VZUHZWTzc3V0JXVkRWaXBudVpT?=
 =?utf-8?B?T2wyWDV1bEE3Z1B0SkV0K0VuWFpaZURtbWV5MU9maXk1ZzNUTTVSeFMvcmsz?=
 =?utf-8?B?bE9JSlJpbEpZN3RmSlhjRFZCRERmT0RtcGF5K3p0ckVJZDEzSC9ZWjQ0bHFV?=
 =?utf-8?B?YmU4NmdxakJaSjZwUVk4NnRoR1pBVGE1bHdtNW4rVE1MR0dkbVRJbXRYUkZI?=
 =?utf-8?Q?nm0Z0FOPxGSW2zOY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea82019f-21b9-4a12-cbc3-08deb7499c54
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:59:51.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmuIBe9FG5XlbwhPEAo4Hty4HJtxRzXFrjZL+CcqX/qi1cBZOWMmm4soGDK+2eBxSXIny5NetkjfDNtwKO53z4yhrndvCALAJspBt3KbYkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9606

On 2026-05-21 10:56, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is an RFC series to expose the boot ID (random UUID for each
> boot) in the last_boot_info of the persistent ring buffer instance.
> 
> The persistent ring buffer can hold trace data beyond reboot/crashes.
> This means the recorded data does not always come from the last boot.
> Currently we just assume that the data comes from the last boot.
> 
> On the other hand, the kernel provides a random generated UUID for
> each boot time, called "boot ID". If you record the logs with the
> boot ID, it is easy to do cross-referencing it with other logs.
> 
> Similarly, recording the Boot ID for persistent ring buffer
> instances would make it easier to determine which boot the read
> data came from.
> 
> For example:
> 
>   # cat /proc/sys/kernel/random/boot_id
>   df152e7a-c0a7-4d32-9f0b-7f5c39fb7b68
> 
> (enable tracing on persistent instance and reboot)
> 
>   # cat /sys/kernel/tracing/instances/ptracingtest/last_boot_info
> # boot_id: df152e7a-c0a7-4d32-9f0b-7f5c39fb7b68
> ffffffff81000000       [kernel]
> 

FWIW, we've used boot id to uniquely identify traces belonging
to a given kernel execution and allow validation that traces
can indeed be correlated across CPU and across kernel vs userspace
for years in LTTng.

Good to see this approach proposed for Ftrace as well.

Thanks,

Mathieu

> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>        random: Expose boot ID to other subsystems
>        tracing: Record and show boot ID in last_boot_info
> 
> 
>   drivers/char/random.c  |   27 +++++++++++++++++++++------
>   include/linux/random.h |    9 +++++++++
>   kernel/trace/trace.c   |   14 ++++++++++++--
>   3 files changed, 42 insertions(+), 8 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
