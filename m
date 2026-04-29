Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020088.outbound.protection.outlook.com [52.101.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6496413234;
	Wed, 29 Apr 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487558; cv=fail; b=rbQATJMpj4k3ANcpHT6sSz+mCqw0MwUUVOHNV9uvdZh0yxzuqVRTBRJ0wlf3nvbVWGaS1kePhW11xBxK79NRJ+jZbQxM2ELZ769z2NF/T1MoOpEFM0HbLfBalybLBx6WuSLpJVa47SI3ke1GNcuWfa9CbZUrBP340jAOxeqyRvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487558; c=relaxed/simple;
	bh=pqcpDNBGGoWLZkDEGeS05G1/xr1B6LqM4211FnSWDtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWcnfWuLN24OqcYwa2yDrrB8AE7PcCeXToX35n4KxRIM5ZK59b668MTpm/CY/cJBptTrMujJ+eLSnOHbue2l1OSz2BfVfNZHfELmXibRvI1E4oHZM+0t6trvD+R7h+FL2T7nAl2VsWYNJ65t0lF/xJo74upfqseiwV5OVUH6I7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cCD8XLHQ; arc=fail smtp.client-ip=52.101.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cCD8XLHQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q83lQI56sLfaT/7gMXbzt0p91rK4s7aAnIGsmRt/lEbAgkRByhrCGeB6q9WorPQCd5yP9rNLx5ABcmQe9FePxVwCAfNnmgWPJ18+9PggybqqD4krgmgk7B85X8mRBAyhgtDlCN0RpYeoyiGiTEL/0nJjL7FgpHNSdVFqRrd1p6ytpvZ4kzMFELYygYIFCSOQh8/pl3sFPKxRrf7pm/dCGPX8FRBbaWQPG5H2rZLIulZ/cyJLVwfPRFLpNCfGbAyKdvCChUGMTMx6Cc5VPNDjL+9R3eWGLANpqLrc7IFH5MgkB6JwBwir/TC4CLrKQUiX5mFly+NiPI4YiUXzp+NzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABsjPDq1+hKmnZABrCD5CJZpRhfp34NTCKmBg9TzolA=;
 b=eRzOgerZxvndA/DvvLirlWtSTCTk7VzAH4r4N9OcsJW6QQkph9ceJLIqO1DZknXfbu5bhBPF468GeKjspq8vc8c9HhTiwOKi/y7cqT756ROYFiCe9UtSnIhKfuMV8d1Nm06MM47IpddAJ+cjAwQydtr1PJmz1kNqu3z7Wf7NLdYorvDJI6o0ThSueGRHqonU2VgkL1otL15wTlU0mVeuP5WnnRQuSggrq4wfXdCT9YYQH/Mn8GuQGzel45Y2lK7Z8xLFlKonVSg4dnkM9Qb4jv44JmrPTa3OetakGZMFMx5ZtG/nNRHnq7UTVjjtWwp2prinNoFFDunXTSIpx8Ji5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABsjPDq1+hKmnZABrCD5CJZpRhfp34NTCKmBg9TzolA=;
 b=cCD8XLHQgSMuLT+GPP3334hQ8oeQjEQDoqqB73+Q/3B3+BsYGVO1/1LY5nGGXDIfJCuY2gEIx37FI3qgUCxyvCtNxbsV3dcKNX9qD9jeYxQYXU26AzKI0PugA7nXWmHs58Jt3h1Bgq0GWSfdGdIJ/IFbEtG8nndMZdtgxxj42nAH5+U63oVXpBpUmoH+HG2ydCB3ZuADrQo2LHKr96TAOIh98g3dGz1aD26S4TGt/0cr1Xc5nGazqTmiAkgBKIvyJLwbcGVA7R/dgNs8M4xSYQAc5i/8rZc69p7i1dJ50lEOUGJNarxSR916AwXALdOvXNLMtHIs4pHcgyrhmZykTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9191.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 18:32:29 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 18:32:27 +0000
Message-ID: <b743d575-0842-4718-8dc9-23c3c97b4a92@efficios.com>
Date: Wed, 29 Apr 2026 14:32:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
To: Steven Rostedt <rostedt@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jens Remus <jremus@linux.ibm.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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
 <20260429114747.4cf74d04@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260429114747.4cf74d04@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 0062e8d9-d3de-461c-690c-08dea61da9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2I68z78zcBadOMDXujWb8SOE3gU3+DmTqCUEWPkEGD5kRc01dS/KMzd47hv7sY2xxFd/PUjeFILeR7AKrImB46N3suyTHC185gq9lSNifus8UQTE/0lWF3zmegjpg6O3n/p7ceNk7DZheAs/f4kax+cerjr5Be4LrQZL1yyMFsLF7A7CBfLDHXWIMg+aqlUMzxnPYMQpRe+EwQHLifFhzbzfnyZBRaRDENhPeJ8QUuOVH1ApeDs/zzB3Ee72ZtRrBsJCdk9KTXL1+WZNPI2vEEKhfBzJRdU75XF1vx0GHW9WJrOHgfWK4wuaXEl6HSUE/ylVMkTq0m27kt+PkRsvOUyxXKFwn+RnJz9MAzKq9Cu9VetNqei2Ulaf2x5WblsCEKLIHc3y/b3YIQLq7RRXJyluIza09QbRpLwRLPTqS+HiXYHrB4xxBPoev/YnW2pQDRnWuFhTfg6NqbxCenru8QWKkRwivW9yw6tTPFFN13Tlwm2o0ExP1LRh2AvLQ2pkOdsBWSyiCE4ZWamg+yXg7+rlC9vMnqFUSo8ffGr4crQoRbbdTFsa8MxJUOk5RLYFHbrjezTGvxviu1T6/WdUzcuc6fJ8RyEnwrI06lFx9tuLMoJp3BfzO4j83EGpWaNGrQFeG0jQAQwx/3mZRFEyW5MWMSRjkf4c2fmsLH8yRFwtgWCUeIvl5qNcoIG298zX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3lkNXlSYVBoYlBpcGdIekIyQm5FcWJseU50d0lNekVMNXRaN09ISE9ibVRP?=
 =?utf-8?B?UnYwbHlvL2FUbjNySGVmcWY5cEZVdVUwUzRucHdDZ3FnRHNOOW0rcWswMnFL?=
 =?utf-8?B?TTRIQXZSY0lwZFlSNk92Zml2YmY4aHcwYk1EeENxMlZTSzJ4N3M4TnAxRnhr?=
 =?utf-8?B?VzZJWkFRaXhORzJNWVB6SFVsR2hOTmU1YTdzVXdjbE1mVFVQTU14OU5FOHVm?=
 =?utf-8?B?WlUzOG1lUjltYi9vQWFIaVVxbTdDc1dLZzVhRll6K05jQk55blNIUUM0Y0cy?=
 =?utf-8?B?d255NFR2VFhvb3NoQkNyUTBRNFlGcHlhRWlsVnBmREgvWExETHBTZ1JIK0NV?=
 =?utf-8?B?U005QmFZWHhNSEVHZjRTTjRrZ0RqS3lhMFhKbDU4VHZiN3k5TStmNkl6bEZS?=
 =?utf-8?B?bnY3Z1hTWHcyeXFlcXA5eDZaMlZ3MkIvWVpMc0VoeURoOVRuWURQWW51OVB1?=
 =?utf-8?B?QWdaSUhjNk9CaWVSVTEyNHRlRFZyM2dZT2h6bk56OXpyRDNkVW5VT2hwRGlp?=
 =?utf-8?B?Ty9KMDU3Z2xyMW5OWTB5UCtqeGY0cFlGakZQUDIvYVNSYS9aQ1Qwb1RHeTQy?=
 =?utf-8?B?bEt3V2d4elgrM2pnS2JHL3hHbTNaVXd4eU1FdW9kRHFGTnA0c3BkRzJabWho?=
 =?utf-8?B?bGpqSWg2ZUxWL0lnUFR6WTF6TWR6NkxJb3VpOTRBM1ZBZC9nTkxLYmdndkdQ?=
 =?utf-8?B?MnEyZkdIVU12RjJNSmhkbDRFVERlSlA1UU5OOXBnRGdWQUhVK3ZKNC8xZXN3?=
 =?utf-8?B?UmZjYWVVcnk4RnQzNCtseENNci9rRUx2cUZLT2tsVTdCZkY5WUpHTjFWWXgv?=
 =?utf-8?B?NiswSUVaZXZBRk9BVm5uR1JOaU43RHI1OGtEdjRBSGVaNUgxS3RDNTR4ZmU5?=
 =?utf-8?B?NTd0MFFmazFBQk5OeGw3RVdpNDNYcWc4Unc2ckw2K1M4S04zUmFKZ3FUdHNj?=
 =?utf-8?B?WlpBMVBQVW5CTEluaXlpMDhyMWlSUnY1a1FudHZYVlh4Smx0RFcxbnlkL3hH?=
 =?utf-8?B?UCtGRWc4eDVZZ2Y2Wjc1ckJqSkJTM3plSmVQcEJaYlZzTmh2dG1TTHBySXhX?=
 =?utf-8?B?aXZpOU83THFueTZydHh5SGJ4MmVmYWJrS3k0cldYSVowU2t2ZTlDRHpwY2pX?=
 =?utf-8?B?ZXU1QU4zajluUW5pVTB5bmhrK0p2N2NRbUZ0RVk5VEpsdWVsUkVOaXVpcys0?=
 =?utf-8?B?Z0x6SjdnMTJmRGNjSEh2ZURIbWRKN01TYWEyTXNkQ0RySnluUXRRWGd0M1Zm?=
 =?utf-8?B?ekRBYmV3bzlvQytjUm4wMU02ZEcwRFFGTUpIb0pGN2liTVM5cER2Q25heDZi?=
 =?utf-8?B?RG84T1R6OS9jZm5uTDBXU21yNVRMSEpNZTYxQjltcERDMVFFUENoVWFTRlJD?=
 =?utf-8?B?UGJkSTBXeXJUVFdHeGRjOHpySTdmM0tlTVdEV0gzMTA5eTA1Z1dSQ3h6ejVW?=
 =?utf-8?B?QmFmVU1Qb3RwbjVjVFdYQS9NUUtjc3lzcVhxSXdjNWxPTkFqckd5T3NXUWxM?=
 =?utf-8?B?TE9XNEgwTXRJQUZMbEdIVHZEUHFpbmltdnN2TjZ0bDhhTlZldm1iOFk5bnJ3?=
 =?utf-8?B?bm12ckpaTXMyV0tUTUFCSW1RaXBjcEtMZFk5MjVZY1hBWkNtWDZtOFpldUd4?=
 =?utf-8?B?T2NFTUREWDVCb3FMd1dyVVhrbVZTWmswN0lTZTRvZUFUSTk0N1hkOVd4SnlF?=
 =?utf-8?B?VGVzREtxclduWktBVDJnN2ZETzRYakVDTnN3dXk5MG1jYmR5RDk3WU14OC9F?=
 =?utf-8?B?VGlpWlp1YjRjVFNJb1duVHdYVXdaYXAzSW9nMmdEZ3ZSWCs5SGttMEZsS0Rq?=
 =?utf-8?B?ZUtwKy8vd1doeHRJWFZOY2JOcVlHTzJSd1JnK3d5OE4xRWlsVVNVSm53SkNX?=
 =?utf-8?B?RmlZK0lrckNRZ1REQVJ1a3pzbHpWT2E2L3lUakhXNGh4ak1HcmFrSGU5Z1pQ?=
 =?utf-8?B?djVhRm1ZMjM3R0ptcUcwRm9HcE9HSlE4UVd5NlM5V3YrbVluNUNPWFpVU0ZL?=
 =?utf-8?B?VktRTHFXMHFnaTNSeDJiRWVRajlaZEV4dDRnUUJCdEIvZGpvNjUxQldYYzZj?=
 =?utf-8?B?SEU3OFNGMHVBeStiZVhhazdINnEvVk1zVEhDd3Z0MjZmT2RpUDJKQW0yVDBB?=
 =?utf-8?B?NzVOUHEyVFNDSXdrc3hQdlp2bHF5N3lJTExaTWVnY0RscUY1TTBKNy9UZFpx?=
 =?utf-8?B?MDQwRHNobFVTYjY4a2pabkozd1NCZ0VncW5zQmVoeVN2SU50WTYwNU5hNjZK?=
 =?utf-8?B?dXd1V1NicG1sRnkyRlR0TjFDSTNVd21zaFpkSzVTK2M5SlJja2VUWWR1MFNj?=
 =?utf-8?B?R1R0L1puM0tlNmRxK285dUk2MUhzeWdNYVRzMExrN3lsYVhDNGZFOTR5REZp?=
 =?utf-8?Q?QN0V1/PDODts5PB0Qo4ZWrvS8fAXSvzYQjqw0?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0062e8d9-d3de-461c-690c-08dea61da9a4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 18:32:27.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qvAulXbtrjg8GoY7XCsIvnAZh5h83krKcg2oRfeGyMFzo/CnhHlJajWVqDDEySPmNtw5ltphTzHpY4S/YwYfoWr6UL46AvCd7BCnAXvVhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9191

On 2026-04-29 11:47, Steven Rostedt wrote:
> On Wed, 29 Apr 2026 11:43:55 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>> index 4fcc7c58a105..005441233932 100644
>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>> @@ -562,3 +562,4 @@
>>   469	common	file_setattr			sys_file_setattr
>>   470	common	listns				sys_listns
>>   471	nospu	rseq_slice_yield		sys_rseq_slice_yield
>> +472	nospu	stacktrace_setup		sys_stacktrace_setup
> 
> BTW, I have no idea what "nospu" is. I did some searches for PowerPC and
> spu vs nospu and the only thing I found was a stackoverflow asking about
> it, and the response was "don't worry about it".
> 
> I only picked nospu because I noticed that rseq_slice_yield used it, but
> that doesn't give me a good feeling that it's correct.

AFAIR PowerPC SPUs are the Cell "Synergistic Processing Units", e.g.
for Playstation 3.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
