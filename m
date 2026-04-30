Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020083.outbound.protection.outlook.com [52.101.189.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAD477990;
	Thu, 30 Apr 2026 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566402; cv=fail; b=OTs/JN9cMwyBcWsr7mKPaa2zBG9uwc909fx2Nw60NgsMf5milXRM4dLAPspfM7OxAa+G75jhDwIoov3u9n7VYanZzkp8N0gVHICw+QyeT3wU9iTr/JhPvDVPSQECx4KhowpsttAlur2Yts+j8dtl2EuL2CF4eycD/Qp2N1xmaoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566402; c=relaxed/simple;
	bh=9ISTFf8TVvTK+Ej0ksYCYvEDdHrR1JkbLjoNO6gbEB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ngjF6VwnEg07aIN6fzOfTeRgQAFI1dls1ArOXPeTqg0ynzpYcz6ppxgRy/OIzwGqpNrN7fdLSZC1+aTkUNBschLp0Hs/o5vBwyJ+d8DpuqPsHTRcX76O13xplNj/a2rvcih5obIlAYwGSi31kxcgC1aLzhdzWz5IGmO6ojv7z0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EiMpawtr; arc=fail smtp.client-ip=52.101.189.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EiMpawtr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/Q2Bc5y8i4bmVXj9CjCT9pQr44ZLCYD0YJZGBcG/4hi6NJGcJiuZzfGz6lyGi0Xxedq/SBkEsL+CosHffCcEtG61PAL51W/wWGXdedGkC8f/IBTa/LrVwC3zGNmpkaqDQZUHnhdH4ZqC2AYYx9xtYa4u2LCeJ12V2VC5K6sri/u1tG6V4aTR3e/YXeos025uLTI82Wz1CVAswf8UII6meumJBAES/c+ts72NAkIQJkVREFaWjOzfVqau/j7ox4SGf7PNNfvKkmBx/XDaYYHlSouhgdvt+xVZMhwrtntMru8sagoI0cuxPTq9LQqSwCtvMVmUY0M+53KuYZlPK8IoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNuvPsUTyBI8n7DvqTJUQg9M6Y3eN1lW/nSNjkXLvQ0=;
 b=Z82jPeE+tVSQ5dCQyfH1+QwHCGXejsUNRhwv0G3e+BxNytRORSRdp0B4wCA+VZAEvarGDRco/FAcSsLETc18Nuk17BzmS8rJ7r1EkojzVcfH3kneOsnBoe5COXQihLzv+zbVCplPwjXR+2LQFNdmq4kPMjGef/0c+Qq1EQUvOcXZgY0hJd6nD7gHquP3u2vylNGrwiq8upQ9tKCb6hSp3KqAzIYvqmpwCfN4pjL88YlbVCl77Ykv7Zv0qhINjWT5wQDXOynCGOiQMcIncXkVrhr+upyBWFOHOdWpu/3AFB/a3TBLdDXehBJBIzDmTD7zhx92zm9TBtUFcCvPIDM6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNuvPsUTyBI8n7DvqTJUQg9M6Y3eN1lW/nSNjkXLvQ0=;
 b=EiMpawtr5LjvoTNPfEuXkvf6TL+wXSIT2Bsi+h8dtvz1z7NqZSTQ42GVYsf213Zz/YTFoM+ugYD4Ktug4I0t9/oXT+/QeXnQj9uW/N8FobYsdFa7hQvEdq5zdNIqBuWUB4vWCYZkKDgJoKDLMXkjQR1sJnP8N5UZpNXiZ0Bewc/oMP8QdbrbANdVMlqFBsGYyXb0jx9MHyK+RYtGuGZw1/1GWyNuxEZ/H9xgnEiKV2uCDvdGRaJP9nrzDfvPzxqNSp40k3AGMurw4NDXLzH0Pmr+rkDXJrHfkm/RBvBs0tiOjHueE200aKSX4nlIqvs03r8sud8/O+OMjQ9GePipvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11591.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 16:26:35 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9891.004; Thu, 30 Apr 2026
 16:26:34 +0000
Message-ID: <7d2e8876-b72b-468d-a5ec-56222b5ad5b9@efficios.com>
Date: Thu, 30 Apr 2026 12:26:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
To: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
 <ade15347-6eca-4204-9f64-9b2eed9e9aec@efficios.com>
 <20260429145512.461e09fe@gandalf.local.home>
 <20260429145815.69dcb1c0@gandalf.local.home>
 <20260429160344.7e5510e9@gandalf.local.home>
 <46aa63d3-0ebf-4062-aefb-86cf0f05dea1@linux.ibm.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <46aa63d3-0ebf-4062-aefb-86cf0f05dea1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11591:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd91101-697c-4ec4-3a3c-08dea6d53edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K2ZxRqsa8f7iaM6r+9aWHegO2HWbW3IS/jixWyuEvUnvNASKPWBwJOtq/k/4uKhIoyg+OiZPDw2yDI/zGSW5W638haDjCHzQisnSSQ83AFbTcKB+MYG959p2XEBMyzUT3YwG/oqj9c1Vp8OFYCwrt/wuzS7XI5Sj70iUy4qw2olrKips96jPfDNEdXM9H8puEznPskwqQujGRbNW1IZnwOqj+2h6zb2MryeJCbDNT6YYNduucNzgJGiQ8JIgVLe6TbbVudz1GMs8IEdqycUEG1qHFOVlWPINx+lh9rf0Tpu2uaQby5v8GxWTs0urPuxFJglO5AbUOtXu3/wUhVnK72oAF4qjGxraYGwVjaXWzRjdsQ6eAIHa1HwuENMbM/75jVaVeGliFQ5ej94nkbpZbRdxw5HP4Jwa+RyF9YwfTtq65G5fVKoAFPLvPvTnUyzW88Qrl4Ah+w+VxaIxf+3emaTJDKhixMp0qO4mupSq7W8NslZNsdWmNho1Ejt+xXFuG4+7jc/+OjcCANpMQ6jn5GS9GBm58JRO4VHmoCA157PIH63L7ZPslfob/anfU7JLWxKW8EA36ylavx9Aidn9XDI2LVDgr/2AMgii+DPW3dlFW1qHG+efG/yUI2Y4odpcCs43IwcLGqvVy1CxUAYrNv0hOWxqi4GXwZX7MLMk1usPSPz5ajE8FhdfmEEeXBMf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEtLQk5EV2FaREVhYkxXcExxMjIwcGhXSWgxRCtnQ09yRGIzd1lsdFFGcnJX?=
 =?utf-8?B?S3lzSk0zYjk3Vjk0UGdXdlY0cXJJV0R5V2s0Sm1xODhnV2lHRjB1V25rMktw?=
 =?utf-8?B?YWlwaG5GYkl0VDhST1JjRkRUY2t5bVNaa0lNakVtWDI0STRIUlVBWlFxa293?=
 =?utf-8?B?ZDIweDluTTBYTnhBUmZHUEUvRloreHlTUXpiMlVhdXVSQ2sxN1ZCZTFVUlEv?=
 =?utf-8?B?WkNZa1BEQTJ3OC8yMzA3SXBScXhLL2dzRi83Z1F0VENZNWtjdDF2d3Y2Z0kz?=
 =?utf-8?B?VklsU3JiRTQ5bk1IMlJ3dldqZlF6eHJtaHg2SDVGZXpubWhBVm4xMzlyLytw?=
 =?utf-8?B?K0dhaW8vZHkwVURnUGc0Q2oyME1pcm11VUZxT2xiVk0zZUc2WGdVTVJ1UVph?=
 =?utf-8?B?cytDRW15STV3bk56VDVMN21SVVhSQlFYWC96SlgxdTZoT0VPN0xoSzRrcHZw?=
 =?utf-8?B?WlpmODkzNjR0VWxkdG13aGsyWjEvTFBnYXZpWE5UbzhVTjBtR1c5RGprWi9H?=
 =?utf-8?B?TU5lYW1hVFJ3cXVqVVI4dzU5NDRTS1BjVGpxWEJ5U0lwRit6c0FNYzd0cEpQ?=
 =?utf-8?B?dmdkVzgwaVdodFIyRDRKR0NPcHpNTFpOR2Fka2xkdnUza1oyeG81K0hFdjRz?=
 =?utf-8?B?ZXpyUzhlSXlteXVMVG84bkZDU2MvSTNzTkxsSkNIVkFZajA3UEh5cjBIZWxF?=
 =?utf-8?B?WUdNR0FJVXhac3NZV1cxY3hyU29mRlh2anIzeFV4dXRwZUhVWjhqK1IyQkdw?=
 =?utf-8?B?S25sS2J1Q1dEY2VWOXRFemswRCtGVEJGVElDOW04RGdidlRHVUp1QysvSEFs?=
 =?utf-8?B?QmF0czlKVEgya1dNakJmVm5iSXRsNkZjOGU1b3Q0amtkdWJOUzQzUnVxZTd4?=
 =?utf-8?B?SUZRUHI2b01DTEw3dVM3a01sQmJRaTNNdlhSamYrMmJQY3FUL3lSYTFRM0lt?=
 =?utf-8?B?VmxQQTR4NngxUlNFalh2cTcvQkd1Ni9WNUpubFp5TmdwbU96NHYrb0kyYUpv?=
 =?utf-8?B?Uy9xMHJQaWFmeHZFWlZsTGg5bzdWQTRyVVN4SzdNaGNFQW91dFNWWXdjcDQ1?=
 =?utf-8?B?K1hwc3Q3UHQ2QTZDZ2k1amVvT041QkJFTm9kVW9ZbTRCcFJ1RHhoWGx2UXFa?=
 =?utf-8?B?UzhxWGpjb25ERW5XeSszOUVkWjRrUStDRjhaOVU3UW5Ed2ZRN1RKM0QrYk9u?=
 =?utf-8?B?KzFybjBBdzd1dkl2anc2WmVPb2RXcXRmZlMyVWF5aUhOVlNSbmVDZk5kKzlG?=
 =?utf-8?B?V2swVjlSZjI2N3lUOXJvcGwwRWxYYmdtRGljWnNORU1MaTBIM3B0ZXJaR0Zy?=
 =?utf-8?B?MTN1MkJjL0xiZ0IzNWFaUWJ0YzNoU1NFcWdpQ1RONkxTSnhVazZYSmdETSt2?=
 =?utf-8?B?TFJuVWxrWWVvL2RpY1lGSmMxRHFIMEJJM0IzNkZYNzlGc3hjRFJTc2srcDlX?=
 =?utf-8?B?OHNOaTR1WnA1TEtXdTFydGM5Um9rMXhHZ1pjbVFtQjFKQ0dPK0VBOFJ2K2h1?=
 =?utf-8?B?UU92bVN2SjNjZUlpTHo4a0NwM1lpQll6S1ROUVE5SGJlbVNBQTRLU3BIU01E?=
 =?utf-8?B?TkJIWmZUR2lubUhMRmNYb1VOMDMzdXNwRW1GbVI1L0xrZnhKdmhMQzMyWGN4?=
 =?utf-8?B?ajVNUTlHNE1qTmFRbGtIVCtaVncwWUNPV29FbDNiTUQvYTVyOVkwWVlKUm5N?=
 =?utf-8?B?UzRqWi83Sk9wcVlpazdZUlBJNjhPTXpnSmNoaUwrU0ZZcHZmcmhGcHF4TXJE?=
 =?utf-8?B?TXptR2tRMlRRMUJ4bXV3WVVlcUF5T1RQL3VCcU1XYkQzc2Vzbmt3VGpqTWw1?=
 =?utf-8?B?b20zeXM5THBzcUFqa3BOSmVPSWV3Q2VmdUlwWEo5bW5SNDRUN3Evd21RSFlU?=
 =?utf-8?B?QW9SbFk0OHNiZ01tYzRKald4bERUak0yL08vOEhPSWhUTE40cStjY1BQUURa?=
 =?utf-8?B?TkllSlc5MXpTYjk5K003cnJaSEdXb3pNUTkxdFFiYTMxNXBweHNHSHY4cG9R?=
 =?utf-8?B?M3pXTm1heXdkd045RitWN1ltWXlPMCtJQjlxM0hCMHRZWUF0VnNvMmpZdUdN?=
 =?utf-8?B?Y0hnMytVVE13UlliSzFLVmNQSjBLRTVEUUpsTGlXa1BmTERWdHk2c3NiaG9N?=
 =?utf-8?B?amZaWmpVWUlUWmlOL1NLK3Z1S3FaNTA1b1JTYjdQL3JGMFY5WWtFblFQZkg4?=
 =?utf-8?B?T0VTWWN0elpyMklTS01OUUlPZnAvWmxqMTVsVE8xRmlxREY1dnpKZWJRc2JO?=
 =?utf-8?B?NldQLytuMFZCcTQ1QW4zVURORTFMNWRTM08rS09EWlhKVkZmQlpac2ZEb0d5?=
 =?utf-8?B?a3czMU5leHRDbHlNMktPbHY3Nk94OWJKSkJzODBDeXZFUTN4SlBsbTRESzRS?=
 =?utf-8?Q?yOVcB4DH1eWtE4aw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd91101-697c-4ec4-3a3c-08dea6d53edb
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:26:34.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Bd4ZuVtdTcjWNITS5ZWLgY/P5UR7GJPzhD31xM9DuJSOSDAzW3p00EtD7sGpCvZqmaYt8HisO8nT0TcTKRaYqqGIDq/xFzu0csJPw+l6pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11591

On 2026-04-30 12:23, Jens Remus wrote:
> On 4/29/2026 10:03 PM, Steven Rostedt wrote:
>> On Wed, 29 Apr 2026 14:58:15 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>>> If the main executable doesn't have a sframe section, I don't see why this
>>>> shouldn't be allowed to add one.
>>>
>>> The address is added via mtree_insert_range() which states it will return
>>> -EEXISTS if the range is occupied.
>>
>> I confirmed this. I changed the test program to load its own sframe section
>> again, and it errors out with -EEXISTS.
> 
> Should an executable be allowed to remove its main executable sframe
> section?  Currently the kernel takes care of registering/unregistering
> that.

I wonder if there are programs out there that replace their exec'd
image with mmap MAP_FIXED, or just rewrite their code without exec ?
If so, it would be good to allow those program to unregister the
initial sframe and perhaps re-register a new one. JITs perhaps ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
