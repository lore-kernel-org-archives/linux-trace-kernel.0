Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021073.outbound.protection.outlook.com [40.107.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475B4218B3;
	Wed, 29 Apr 2026 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488182; cv=fail; b=hGLJMKgUX2qBreuv1YEe+C+YdVKVcUebAZWmALF6O6QDaGrixDi9LWkNexrngxUObTBQz8PWpj5A1e01vcNIr9TgOHihUqzwA5H41HwrOD7fPvTq+wAwmqAejZFt9Radr43yH7mFA+LNL5fuZvua/JYMqBl7yOK/UZSaKdE+Kw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488182; c=relaxed/simple;
	bh=mbybDtKemlcPf0eP5qp3DgiKym7mdtf6/fWknxGQJ98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qQQ6bsLvX87W++Kj6KwP5dcjSVNFqDyCnsN9ytyXHeAnA/3n5yCDYEfirh9T23l/efxPHAhHlQIQy6j+bvJ89LYPMl9h6DTsvOqhOJQQv1F0raJmhajsYFF/FKz0KUaGTKu5miJy8QyyZHUX7pk73d85ry+oUsw4WsQgHsE5F7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=F8eXJUaJ; arc=fail smtp.client-ip=40.107.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="F8eXJUaJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6RxYNwPuxmIUoKT7FLLm4NuCs37dwUbx4aRQPHVMHGEFsczvL6ulKWz0HttKMi1IfdPmmn0vjm84D/jpaaLBwO9B52rQ6JHbuWi7GYILy8bab3QpRfosTKKxNzPSDxGjnXTpcOA7kSIdwBIm57Hxs4Cp+tZ7vRBgbrvN/KjSWvUaQ99Uy07CPoKZPD49BV8DbE/UEg8SJxwYlR9PiA+CRJVSzGjT8KnFrlUCH64/CGKBSIxCk3V6iTvN63+OpkqyMM436Fpqn5iy29WyZbOMuJFjtLFw1GD+4dPLfrHcw7ZCOHmBXh0LM2yoHxMXn11C1XuqUCqOpmjfDQ1NEh/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41AtsaoahHdjhHaw3zFVx5UqPcDRWOgLKqaCu/a0ScY=;
 b=CcjcPE2mQQOFSPCWS02s9eJsezdXv02HTqxSGHF80hTOKFzR3uzOEt9cc4wvpSDxyywchwmVFPFHmRFzytLO0pP8XscHehIr+6ryy1HVwMvI0mThqK92Nj23mv+LEM5rLx+hsUEcHjgMznO9l3LLu4g+u2LX0iawWGF2uPklVDHnRUZlgFtcpV5DyAGa96WlhZVXZjiUqxp6RRRa6QiBFLEcLpm21rdpCF3cgjLUGZNAmomBKjZVhSGgLSib7u4n67v97q2ji6rmwPoF7M4rE6gbm2xzd6qOHvd3H13MeOt+4vG/4h9Q+u/qZ8RrhiuwO5lgNv9fZLh2BlLoXlYUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41AtsaoahHdjhHaw3zFVx5UqPcDRWOgLKqaCu/a0ScY=;
 b=F8eXJUaJeHTr+4swh891hHL9y7SIPIWWYdZcB2Wsu5jwbWFIWWnHb5LjDn4LGDlAxigNOYe8n2ssFjvvOXt6REgfAC2RLI+Mfg0jkM3epp+Wge7boo3pJYynpD+JG4OuGymbNECxDyaTSof3KNhU0dCad60haymxaLVcWOCog8q+9TuTburOzmCLx1tko3RvWeiIhQeIgPwjUp1q5pXu78b98imyxxbWc4b7xJS2InU/hSWWM7fwqcNFXUXbnssZ+7OfB4dgkAWQB7xCPUPS2S6QXWremPJcdvgrhbO71cO4HjjtC9LDvid6itO1bFovC5n2vpIa4EEZBDozBMCc+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5736.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 18:42:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 18:42:54 +0000
Message-ID: <ade15347-6eca-4204-9f64-9b2eed9e9aec@efficios.com>
Date: Wed, 29 Apr 2026 14:42:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
To: Steven Rostedt <rostedt@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jens Remus
 <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
 Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>,
 Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20260429114355.6c712e6a@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260429114355.6c712e6a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: fc918c7b-3c0c-453b-9c3a-08dea61f2028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qrzhRJ+KdLoPNTcuucCCx60/1r1iMBifBdwytkYBTLo9HSDrDptyOp1yD1m/2daLxMfM/PRe4Rg3kDDFlVlXyk6gA4hHZzi2/BfbmZywJhsXXPWo00DMEUBfgXLq3atZ4bM1lbxrPyofMYB+I4HEQW1f8PNt5pJ+EnP6zx9B+bPPD3OakOSNZK8aQKIXA7yLbjlXwkRmwx7XUHo+/XVY4PKADWAww1dC0IFsMcf9WhqAaHLFdKlFkq2KZZcPFtawgpneeTBAU6QR7GYuWl4EcrGiAgLGieWPHXMrdaNwVGZto5r1FRhnSzcMICiAFbVt7mgb+JOKHRRDeFzyh0CoyxFbQOx1EizJsNiLsdhkeP92kKuBek/vBqNlbJM+Nc8qZc6vs4AtzRDJC3Zrs+oQia0RepmSIWw7BDJUK9Zh1QYVxMETIVyxa8kfAOPEprqr591IUbx2pEGzO2cfECrNm7+cmH7pSAdnbqFX/DUAiQ+uBEvJ5L0jYfdAnyMvyzlAqLyZ09R0bnh9U60UlyKcJ0JPSzVeYH3vI45M0exem629QUwvPKDjpotdDwM1yQJ4yZ76NfVHJ6UPy66XxRF9J/jq3EIahbTkvh9//uwBSW3d/eHnT23ri7+nU+Bal+JrxKgxLmyWKHH4AvPCXYJfQY+US1H/6bJgx5yomYrVNsO34i2UZC3rJ/fg1y2tV1yX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHkvdUp1UVVIUzdBUGVweWFleVcxRmQ2a0FaNnB4MWNmYlhERjNjOWl5Zzla?=
 =?utf-8?B?K3lIYkNKblFiNlpVTUxqVldZdzcxWnBQdk4rMlFNR3Npbnd3V2d3NFRjeUQ5?=
 =?utf-8?B?ZTJxYjAxUjhIOU52RmxWanBjZ25vZHV2MDUxVUN3K1FRbVpXejlFRjVTYTNz?=
 =?utf-8?B?bVdkcGdKN3JCTjJFZDBwd3RtbTVad2FXSGF6c1NxSDJDbDljQk5sOVRHbEZl?=
 =?utf-8?B?NktFZDljc3pxTlZIcHB6NmFaSEhVODlacEhPZlhSNnZKd3oyY2FxZk94OFYy?=
 =?utf-8?B?cElxV0lwZ21JN21aWnZPWHZLY2VWVEtOM1BCZFJWenRQRHd1T0VTUmtBQjdl?=
 =?utf-8?B?a0hibkpBTUNOTVl4bTE5bEZtdCtqNVRHSllzQnU1VnVONDA3MGJwSU04NWVm?=
 =?utf-8?B?WFpHVjRROFdjUTR0Tnp6QTFHV2xoc2hwMDhpZFJMTjNhN1JKOGM1MjFrRzNs?=
 =?utf-8?B?SGw2aW1hd1ZSdm52anJXZ0ptZDZ4ZWtYZDdDY3ZCY2RCMjRzMUN4ZkJDMWkv?=
 =?utf-8?B?QmpaYnFma1hNTDBXNjdOWDVmVnBGRC83cWEzWWJMSzlSOUgvZzBEWlc3RCs2?=
 =?utf-8?B?QmNKNUtGYXF0TFJRbmZKM3lFVktzek8ralZsZm1OYmViV1BURFZ6MXpvdDV4?=
 =?utf-8?B?emJGNkhDNkpibDRxUnhlVmdva3QrMlBteGwvaVZ2dXB5MFVTSlRxTTdubVNo?=
 =?utf-8?B?VGIzb09lVlNDT29rY3JSaWtGdzJxNzFBWFhtVzRBaEEwN1orSW1LampHdzgz?=
 =?utf-8?B?dHROUE5aS0xMTEQxUE5qMyt5cmRoK0tZZzZYZU1MUWlSaUJtU2c2b21vdmVw?=
 =?utf-8?B?a3hNMS9pVDVpOGRMN3VrQ2MyZVBDVGUxNi9Rb0pXNHFlenpCWUtuSGJUQ0xj?=
 =?utf-8?B?eThHWDJjdGNwNnFDTldoY25pTVdXa2p5S2xUci9LQytuNDJvVitSdTI3MmNi?=
 =?utf-8?B?NzU3QXQ0NmFySjBPcG41QzMrcG5oVXREOFF3OGd3TTRoZkh3L3Vudk8yOUhj?=
 =?utf-8?B?SDd6aW5FTDlUUUVZM3Rtbi9BMXJOQ2luRlA3ZkZxNDYvdjN4OG5tM3VzR0hH?=
 =?utf-8?B?WjJnMTJkY2Z4MXAyVEZkaXc0bCtxR3V3L1dtMFJxcUdjbmsyVUZsWFhPUlVk?=
 =?utf-8?B?anFLVk9DZDV3VTRGTmhLaWRYQVJ2Y0U5WjR0WlBGVFhzdi9KeTNmcjYvZHNQ?=
 =?utf-8?B?Zjd0Si9JNWprb3FJdlIwa0ZXM2g0bW1XSE9SZGJjUjlEb0dzUFhrMGo4VCtp?=
 =?utf-8?B?Sk9qcGI2dUhNQjRDWEh3SEJuZlViZnVHNjJoNGIzNlNDVklRWE1kb1lrdmUw?=
 =?utf-8?B?aU43V3lCaHFKUFh6bmZ1OVZvempmbWNQUjZTOUtlcHg3d0JxRGdIblRNRVNG?=
 =?utf-8?B?bitaSXhEZmFBTWYzWG56bEpGakFkRkJWcFVyeGdLSUt6NFVvNkgrbk5DS0JU?=
 =?utf-8?B?MlhRWmR6bDRrUWRnM1FLUitxYWNDVk5pVmtWMitXUXJCZDV6eURra3c0K0RE?=
 =?utf-8?B?QVR0dG4zRVgrRUhiQ0xOUFdhdW5QQUJUeXR1RGZBQmppVDdoNTVpdVRUVjNO?=
 =?utf-8?B?VHd2OVJ5SFhTQTc4T2czV2V0eFJBMENraFFsSUh2MTdQYktPTG50U2QrS2l3?=
 =?utf-8?B?K05VM21xdktKaXVQeEFselRJazRwOEJtczMwbUdpVlBFUVMvVThFd1ZBeXcy?=
 =?utf-8?B?UUUrNzZUdFZodVdaMXZvSGlFdVI5RWoycXBLMUFvWGNIVXl4NGdFSFJmakg5?=
 =?utf-8?B?RkJudnMyZWpRb0crczZLM1pXdTNxSXhhR0l3VjVCdmgyNG5ZK0x3b3FKVDEy?=
 =?utf-8?B?bmxNZ2tBK1hraUZCaGk0OE1wekpBNHExRm1zTEJwSFVzYjFPT2tYMFNyU0Fr?=
 =?utf-8?B?SFNFa0NDWHRneFArRW1nUkNzMXIrNUtuaWI0ZWNCMkZ4UDVuemd2bTd5eGV0?=
 =?utf-8?B?d3dzaFM0TXBYc2NjTmZNTmU3b01Xc09ReTBFTkVhOVQ4LzhCSDVrZ081N3oz?=
 =?utf-8?B?Y2Jyb3lqQ1RQNzZHQ1NZU3F0THJ6QUswRGpJT2I1MlNkQ1RMOUlkb3hEajV2?=
 =?utf-8?B?YXRaUk9NWkoraGE4MTQ1dXVFejlleVNIc2VyLzYxRkJzRkpoZUF5QmRBdVdL?=
 =?utf-8?B?ZURwVVNUZlliWGxaMUwrWVNXelJ5SFhnN2FGVHFCUEw2WTI3VUh2aGtqR0gr?=
 =?utf-8?B?MTU5dnY2U2tJUlMweXg3ZXczUlZrNkR5OEZyclFEWWl5ZmxiRk1sblRCNUZz?=
 =?utf-8?B?dzVTQ3JFTmphaldSV3AzK2dvUlZrYy9xZGI5V20ybjFQcU1WWG1KU0Z4Q1Jh?=
 =?utf-8?B?WnlEQVZ5YmgzcWticVkwV2NwOGRiSjN3RmNvVi85YUZzNCtUSFJsU3ZqWVVz?=
 =?utf-8?Q?VUN8quj7ZfCW64/97A6fXF/SjuKmUBN45Xo/y?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc918c7b-3c0c-453b-9c3a-08dea61f2028
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 18:42:54.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aq+CcwBpf9lhmBrvWxaAIdbVUeWhr4ZVoVU0gdltxXp6I3kQUcCAqU3pTBs9bx94VYZUEOyocghinaqtYK3aD2hMmCFsigvvmmiSOU4Fsrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5736

On 2026-04-29 11:43, Steven Rostedt wrote:
[...]

AFAIU this is a functional iteration of my prior RFC here:

https://lore.kernel.org/lkml/2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com/

perhaps it would be valuable to refer to that thread ?

>   }
> +
> +/**
> + * sys_stacktrace_setup - register an address for user space stacktrace walking.
> + * @op: Type of operation to perform
> + * @addr_start: The virtual address of the stacktrace information
> + * @addr_length: The length of the stacktrace information
> + * @text_start: The virtual address of the text that @addr_start represents
> + * @text_length: The length of teh text

the

also, perhaps add @flags just in case ? This allows changing the
behavior without having to insert entirely new set of ops.

> + *
> + * This system call is used by dynamic library utilities to inform the kernel

Out of curiosity: what would happen if the application chooses to invoke
this system call to register sframe for the main executable ? Should it be
allowed ?

> + * of meta data that it loaded that can be used by the kernel to know how
> + * to stack walk the given text locations.
> + *
> + * Currently only sframes are supported, but in the future, this may be used
> + * to tell the kernel about JIT code which will most likely have a different
> + * format.
> + *
> + * The type command may be extended and parameters may be used for other
> + * purposes.

"type" or "op" ?

Thanks,

Mathieu

> + *
> + * Return: 0 if successful, otherwise a negative error.
> + */
> +SYSCALL_DEFINE5(stacktrace_setup, int, op, unsigned long, addr_start,
> +		unsigned long, addr_length, unsigned long, text_start,
> +		unsigned long, text_length)
> +{
> +	switch (op) {
> +	case STACKTRACE_REGISTER_SFRAME:
> +		return sframe_add_section(addr_start, addr_start + addr_length,
> +					  text_start, text_start+text_length);
> +	case STACKTRACE_UNREGISTER_SFRAME:
> +		return sframe_remove_section(addr_start);
> +	}
> +	return -EINVAL;
> +}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
