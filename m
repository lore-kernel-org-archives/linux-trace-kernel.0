Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020110.outbound.protection.outlook.com [52.101.191.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D33D9042;
	Wed, 18 Mar 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845619; cv=fail; b=u8I9vUiMjEA+lP2f5PBIfB1o80/WnpV3EN7By1Y3VU83/8WHqvYeGj4lpgO6fGhd7hIQCUqWkKonJb8lR0YAk9poyxiknV0XJEq0Rv3bsw7laji+3XHJeWHvKWBFBU6HnRPb/+UGGXoH9kXCNPPJn9wyMys+RLZdtT7QR/Xlcvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845619; c=relaxed/simple;
	bh=Wu8IfpiRHXGGhCAWoosCEyr80bIhR0eHXJDpBcSCi6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfd/1R/H3c3SMLlqRVexJN2dAzO59VSq9AprcnH7UTKwkqL1LKsfqz+un9cJJfCXZ6gmYF3F6kaapPLfohcwN3WPsynPfJIQdtLyDYgHf349p3LYygHFcXu/+932b3jHvLtpJgcma0QuOakMzrobqlxFa6nf8qPuIAdDi7qdHIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AIzTLVGa; arc=fail smtp.client-ip=52.101.191.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AIzTLVGa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrE7A2hnsRn5KS/fBAZHcyp5qKmc4hectYLD/x6j+q9/0XWuo8csUhGCeOZld9todAEyjty74oEUxcGm9g8T0Q/h1DkbgmcPiGZ8efU+99vbO370G9BbpnjZAMAIfKT7NuFWkk7CI+U9c+YyafhbS3JgqY/lp91t/dOi2qAbLddbwXyF7H4H1fcOWcNBTCLC5izkHGixvx9a6rMn5C0Ziy29yltEm0zFQaV181dh0RzgmRZ/rMo0jInPCw1Mh7DMVU0TIMNSFnvQVohJPI+Kl5wDu6whim2zFIXm5Ii4qwwtM8zSG4uZiiuD8t2FPKKGvqzZklf4M6/gWOdmmqrBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWycfHgnf3i/73ig+ih2YAEVLRt64SYBLZEWehpKcIs=;
 b=x22IRA36RROFF2xXDcQoDXhhOPQRgJfFyP6SRoz7e5TjS/Lki1QBcyuTcLRnuT3fpJfTZohdE4cs6caR5ie8ssoYUX0wzJmPU390ahNn9DkP4BY4aiwaYIHrl+tpDPLT1//xWwMtWLfDmiZ2K1yUxbF+rbb1mXcfhZRvsZzN3FkGr0peyVdcoyfyBs/XBWphDDywi4CPO6X1EX4ptEPBKamRVVRDwHGwnwTF7yQZhZuz6eb4aBmDnZ69eVgYVzcaytNc6IS74oKN12iHsFi2Uhx9IPEt66rE2qF/yBV6fA6fPAorQyF23SYEFWXuGEx92ryE99tvXSbglRWRwAGyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWycfHgnf3i/73ig+ih2YAEVLRt64SYBLZEWehpKcIs=;
 b=AIzTLVGa/7OnAvZUTLu4Jwjg/QeQX3dvHdFslxXP22mqjuBchs3aaMgAwEHZQNlJJc+cn6xrXr7vgO/cfxKuYfRWFDWTjXeWKbj7/tuS3hhQbRmCIxUe4NEcFK7YZI3zRNbvkmjVks0J0wX24lTiyBxRewGYkYXoUyNwbtg20zblbfCOz1118ZwjAy0c1Y3SkUWJ0NpCsRIGPQrx6O+GRE4JkfUKEMFK+BkFyQkpm4YYBwa7EVEQ99DY+TdOPrdASlZKcK2sgx2WNN7neh9G9FGa2EUgbegyuQdFg/yuv7cQiX5qh5owrWBswSglME0bMNFTXxXCRca7e14jC4qOpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5498.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:53:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 14:53:29 +0000
Message-ID: <c91f37bf-97e9-4752-99a9-3d534ce9d2f0@efficios.com>
Date: Wed, 18 Mar 2026 10:53:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] ring-buffer: Flush and stop persistent ring buffer
 on panic
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
 <177319274904.130641.3303707869402603363.stgit@mhiramat.tok.corp.google.com>
 <20260318231959.717f07ec491a731941aee1d9@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260318231959.717f07ec491a731941aee1d9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee07f45-0593-4e2d-910e-08de84fe1dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|7053199007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WI07OHb+jZEOTVD8L1BGRT+mrTiBEQn6Sjnx+4PKptde/5l0E57OqxyIbSDnkL0XZ53S+dvDqymvylu+x5+iv+cVBL7vVsbRrjl+s/TtzVJK+ftuRUWLZDi4JYaJ1DfVbaKTMXMhdwhoqBWjrrys4gU8lxxuFTNKOdCNyPXIKHhxpUx0UtEnA3vVsSWpTnNmZE6uiHLcu/Ay+HnlrckIaEH6jNEJ1yIQ5/hoeHAEiPPhsz3MbqEn51jKIh46x2t/JxRMVllHGDxrcH1DmjFpQpHO0k/VLx9O3pRyvqFXwrQw7I/JDjcD8L4rpQPKWySBpH+p27VFHnZqS1GKytWb7SM0nYXqSCvmh87fx5uKDP+b2d4kbFyL2nZH0M++r65S+6lzHhg/3vced16rliHM7eEPrf0goHQKnM01fRymfLzRxf+dnJIhEIqltu0rWL3bhR/ZyVN7bXgHXBGJ/sEY+OIDR3O95mj4xoqwUnWlFosuoz9BBfJArVKPBICLEgPULPqjoRopTtOBf2at8O9CuNnQshGBO6gUwCWcDqx5TjvyxSAC/PaJTxx3ALvtwx4UxHoVzsYtwKRVRTOMR93LTVnfd+zPk4Yq3x54QWXBZ+60lcy7Qe2Eu7DiGc07T9R69PSLafCmQqllKKgiftx5K/nd93GwGeUrfXdN5rZNL2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(7053199007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW1LZGJ6NkdNc3k4LzlDZDM4QUxHZ0cvTGFjeWlQMFB0ZWtDbUY1YkRFNGFh?=
 =?utf-8?B?dThNdnVZdjhydW9hUTdSeXcwR2pjWmpUSFYvbTFlVU44WWthYzhGMTdodEd2?=
 =?utf-8?B?Zm15cDVvbVdzeGxPV2xKTkdOWFlYYjNjOXE0dG5sUzBGWW1vTEoranFmQmJv?=
 =?utf-8?B?NDF0d0V3SWpRcUhuS0pMdUZ4UG1rcVI4d0pxblYvZkhLK2Q1MzVEN0I5TkhH?=
 =?utf-8?B?c3ZrenpjT0RFZGVhYS9CMll5Y25LRi9uTUk2UFRuUGN4TkhSdEhWMkM1eWRI?=
 =?utf-8?B?ZGc1aWQ4TVFKZEJnQjNDOGsvQXZXZzVQZG02ZGgvL2YxaUgvNC9tbEM5WDdT?=
 =?utf-8?B?L0ZVeDZDMk4reUNJcU53Q3Y1VlZJUUFRMjhqUjRhYjdkSW8rek9VOURDSGc1?=
 =?utf-8?B?VnJxRUw1aVY0OENja05OUTNnVm4rT3JEb2NYSSthV2pSOFkxZ2QxZzZJWkgy?=
 =?utf-8?B?OFFpV1p4RmdRejRUYk9kRm1YUldwd0tLazBQbUJtMTFERk9heG03MG01N0Rm?=
 =?utf-8?B?d2Rwbmp0N0ZNcSt0endCcFlKeWlzNkVGSExqUit3VDRpN0cwTXJHcHVwMVFZ?=
 =?utf-8?B?ZFNESzJ0d1ZDcWpZRk8reU9hbEZCNWNwY280aUJzRWVwb25LbmNvMk9kK3g2?=
 =?utf-8?B?anhYZXd4UXlCTk5xbzJBWmwrL1pLT3VxNUFtSUIvUzYzMXhVa2xWTmYzWUEv?=
 =?utf-8?B?MzZSL0I1dlFmK1FZdmhMNWVVL1dNNnZzK2FaQkRTNXRYMER4UERDQjRXQ3Fk?=
 =?utf-8?B?M0dHM0NNUGNRWml2Mlc3dS9SMms2UXRHRlZxd3BVd0ZoVUMwOHhUUURvSGoz?=
 =?utf-8?B?cmZIVXBQWGNSYWExQk5GWG9jUE42bFAwUTFFc3BaYVg0ZkJaVnl6dHRiV3Vk?=
 =?utf-8?B?Ymw1SExiU1pMVGdha0V4Mnh5L1VYYk5sV1BQcElxZkk0Q3htaTF6WUJ4VVRO?=
 =?utf-8?B?Rnk2TTBEVGtBWTRqZklvaVJYaFB4SzFLMGt2ZXNTcFhzK1o3U2o5MVorc3ZD?=
 =?utf-8?B?OFNNcFFucGkwam5keDZBd3VLUnBTS2xhVVFPV0FJME5mQ1BudEpiRzBQeUp4?=
 =?utf-8?B?YWxWV1RxVXJHTEZkbGtvZmVEc1FHRDNoRzB0aVBVSFVOZWswMFdxc3hmZEtm?=
 =?utf-8?B?VUpGbHQ2SUZuMlV2S0NWamVBUmh2N3E1R0tWTGt0OGZ4QXVaYkphNmQ0YmJh?=
 =?utf-8?B?K1JpaDk3U09mQUl3TU42bkZnbmFNQVNxMjB5c0lLa0JUMmUyMmt3TTU3Q1F2?=
 =?utf-8?B?NHJsTmtmTEx4dU54OTB5M1dxeFl0dXNsV2svTGpRQUNHQ25KMHRJZGtuMm1C?=
 =?utf-8?B?Z2s4dFQranRydmxYUVp4OWVrTXduMUpld2huMURWdHFVODhvZldUY2V6RWc1?=
 =?utf-8?B?M2ROODR6bmFKazhvMkVjSi9kRTVxcTluVDJreXRwS0JKdW9waGpGSHNFSjNP?=
 =?utf-8?B?TzVUZVpjOUVmUTl2SVB3cHFLdEVvakZndlVIK09QeTBNbmg0aHZ6ZGtXa0VF?=
 =?utf-8?B?bm91REZPMEFZUUgxWkZTM283WG5rb2dWQ0R5UE9jR0REeXVucWZwT2ZiRll1?=
 =?utf-8?B?NTYydlZxS1dkUFoxN0d4Vk9MWXBYbExkT0N5NVlGZ1FrR1Z0emowTjV4OEdP?=
 =?utf-8?B?SUJQRTRiaGZndHNRN1FmdkpjdXorOEEvY3dtZmo1UTh4YjJSRzRGNDlJVjJy?=
 =?utf-8?B?U0lNb3dxN0dYUEFPRFp6czFCakVPcU5sY1ZnbkQxdlZteEIyMXZ5TkEralhV?=
 =?utf-8?B?ZmNlYUFkWDhQNmtqKy9EeGhJZXc2d0I4ak1mcTFTYTBwblZFc2J4bTc3Z0w3?=
 =?utf-8?B?T21IUFdzaUJ2YllnY1BBSTJldXFicmRPdUN3RllTeGhvZ2Z0S1k0MTdUeUNy?=
 =?utf-8?B?T0JzekdsL1FEVjFmUjJHazZDamY3blQ0NVA0UDdDL0NRNXFYWWxkWW56MCtJ?=
 =?utf-8?B?ZHJWS2owUHFLdVlqS3FXRndSUkYvNUF0SUpIK09senhXdzBqdHpTQzJrSjNS?=
 =?utf-8?B?WXA1YUN2bmVhLy90M2RnS0JRWWVoRTBrVzVRY3ZMbDN6VUhzWXhjdlhwSG4x?=
 =?utf-8?B?MG9KOW5xbnlyS3hLTUZFcmhiSnBhQWV2dzFiL0Z4VHFIOGJkcDd4V05PMEoy?=
 =?utf-8?B?ZGFMRUIvZkU5cjRObmJ5Y1NFTFZ2T3kvUCtDcFlycjdadTJCM0p0MWZFbUEr?=
 =?utf-8?B?aGUwZVRsaDQ4b2FoQWttVE1lVmVMM2pLREtFeXVvY2ZndmMyVXFidnVIWkdW?=
 =?utf-8?B?dVVXYlF3cTYrTDIxMTBWY1Zvajc4ZjVoTDVXZzJ4RHhzaHdBUU1hZTFJeWtB?=
 =?utf-8?B?OUpVL3hyMWZTOG9PU0p6Z1k5NE5hdDJ5ZGloMnZwNXZIL0J1ZGxnd25kdUpo?=
 =?utf-8?Q?3K2vMosl3SBvJiIY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee07f45-0593-4e2d-910e-08de84fe1dfd
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:53:29.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7y57ZadbYGC0Kl4qwpnJfpts46UfLutb8rVtlUUERkFhIOJR4bYCfIXMw4/byI0idFQpnKLu39TlwuY4OM7SPBdD00rErUZZ6vvaGaR5pZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5498

On 2026-03-18 10:19, Masami Hiramatsu (Google) wrote:
> On Wed, 11 Mar 2026 10:32:29 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> On real hardware, panic and machine reboot may not flush hardware cache
>> to memory. This means the persistent ring buffer, which relies on a
>> coherent state of memory, may not have its events written to the buffer
>> and they may be lost. Moreover, there may be inconsistency with the
>> counters which are used for validation of the integrity of the
>> persistent ring buffer which may cause all data to be discarded.
>>
>> To avoid this issue, stop recording of the ring buffer on panic and
>> flush the cache of the ring buffer's memory.
> 
> Hmm, on some architectures, flush_cache_vmap() is implemented using
> on_each_cpu() which waits IPI. But that does not safe in panic notifier
> because it is called after smp_send_stop().
> 
> Since this cache flush issue is currently only confirmed on arm64,
> I would like to make it doing nothing (do { } while (0)) by default.

FWIW, I've sent a related series a while ago about flushing pmem
areas to memory on panic:

https://lore.kernel.org/lkml/20240618154157.334602-3-mathieu.desnoyers@efficios.com/

When reading your patch, I feel like I'm missing something, so please bear with
me for a few questions:

- What exactly are you trying to flush ? By "flush" do you mean
   evince cache lines or write back cache lines ? (I expect you aim
   at the second option)

- AFAIU, you are not trying to evince cache lines after creation
   of a new virtual mapping (which is the documented intent of
   flush_cache_vmap).
   
- AFAIU flush_cache_vmap maps to no-code on arm64 (asm-generic), what am
   I missing ? It makes sense to be a no-op because AFAIR arm64 does not
   have to deal with virtually aliasing caches.

see commit 8690bbcf3b7 ("Introduce cpu_dcache_is_aliasing() across all architectures")

The arch_wb_cache_pmem is specific to pmem, which is not exactly what you want
to use, but on arm64 it's implemented as:

         /* Ensure order against any prior non-cacheable writes */
         dmb(osh);
         dcache_clean_pop((unsigned long)addr, (unsigned long)addr + size);

Which I think has the writeback semantic you are looking for, and AFAIU should no
require IPIs (at least on arm64) to flush cache lines across the entire system.

Cheers,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
